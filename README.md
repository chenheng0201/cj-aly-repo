# cj-aly-repo

在github上创建的一个项目，被阿里云的个人版镜像仓库关联。

阿里云个人仓库路径：[容器镜像服务 (aliyun.com)](https://cr.console.aliyun.com/cn-hangzhou/instance/repositories)

![image-20231018220737634](F:\cj-github\cj-aly-repo\README.assets\image-20231018220737634.png)

帮助文档路径：[如何使用个人版实例推送拉取镜像_容器镜像服务 ACR-阿里云帮助中心 (aliyun.com)](https://help.aliyun.com/zh/acr/user-guide/use-a-container-registry-personal-edition-instance-to-push-and-pull-images?spm=a2c4g.11186623.0.0.31d060714w5zQo)

## 前提条件

- 已安装Docker。具体操作，请参见[安装Docker](https://docs.docker.com/engine/installation/linux/docker-ce/centos/)。
- 已绑定源代码平台。具体操作，请参见[绑定源代码托管平台](https://help.aliyun.com/zh/acr/user-guide/bind-a-source-code-hosting-platform-1#task-2038492)。

## 步骤一：获取镜像仓库的登录名

- 如果您使用的是阿里云账号，阿里云账号就是您的镜像仓库登录名。
- 如果您使用的是RAM用户，去掉RAM用户账号aliyundoc.com后的名称就是您的镜像仓库登录名。例如您的RAM用户为287683832402436789aliyundoc.com，则您的镜像仓库登录名为287683832402436789。

## 步骤二：设置镜像仓库登录密码

**说明**

若您是首次登录容器镜像服务控制台，您需要设置Registry登录密码，以便镜像的上传和下载。

- 使用账号登录，需要设置Registry登录密码。
- 使用RAM角色登录，需要调用接口获取临时账号密码登录。具体操作，请参见[GetAuthorizationToken - 获取用于登录实例的临时账号和临时密码](https://help.aliyun.com/zh/acr/developer-reference/api-cr-2018-12-01-getauthorizationtoken)。

1. 登录[容器镜像服务控制台](https://cr.console.aliyun.com/)。

2. 单击**设置Registry登录密码**。

   **说明**

   如果您忘记设置的Registry登录密码，您可以配置访问凭证来重置密码。

3. 在**设置Registry登录密码**对话框中输入**密码**和**确认密码**，单击**确定**。

## 步骤三：创建命名空间

您可以通过命名空间管理该命名空间下的仓库集合，包括仓库权限和仓库属性。

1. 登录[容器镜像服务控制台](https://cr.console.aliyun.com/)。
2. 在顶部菜单栏，选择所需地域。
3. 在左侧导航栏，选择**实例列表**。
4. 在**实例列表**页面单击个人版实例。
5. 在个人版实例管理页面选择***\*仓库管理\** > \**命名空间\****。
6. 在**命名空间**页面单击**创建命名空间**。
7. 在**创建命名空间**对话框中设置命名空间名称，单击**确定**。

## 步骤四：创建镜像仓库

1. 登录[容器镜像服务控制台](https://cr.console.aliyun.com/)。

2. 在左侧导航栏，选择**实例列表**。

3. 在**实例列表**页面单击个人版实例。

4. 在个人版实例管理页面选择***\*仓库管理\** > \**镜像仓库\****。

5. 在**镜像仓库**单击**创建镜像仓库**。

6. 在**仓库信息**配置向导中设置**命名空间**、**仓库名称**、**仓库类型**、**摘要**、**描述信息**，单击**下一步**。

   **说明**

   仓库名称长度为2~64个字符，由小写英文字母、数字、下划线（_）、短划线（-）、半角句号（.）组成，且下划线不能在首位或末位，不支持正斜线（/）。

7. 在**代码源**配置向导中设置**代码源**、**构建设置**、**构建规则设置**，单击**创建镜像仓库**。

   | **参数**     | **说明**                                                     |
   | ------------ | ------------------------------------------------------------ |
   | 代码源       | 选择代码源。**重要**选择代码源前，请务必绑定源代码平台。具体操作，请参见[绑定源代码托管平台](https://help.aliyun.com/zh/acr/user-guide/bind-a-source-code-hosting-platform-1#task-2038492)。 |
   | 构建设置     | **代码变更自动构建镜像**：当分支有代码提交后会自动触发构建规则。**海外机器构建**：构建时会在海外机房构建，构建成功后推送到指定地域。**不使用缓存**：每次构建时会强制重新拉取基础依赖镜像，可能会增加构建时间。 |
   | 构建规则设置 | 请在仓库创建完成后，前往构建页面设置。具体操作，请参见[构建仓库与镜像](https://help.aliyun.com/zh/acr/user-guide/create-a-repository-and-build-images#topic1686)。 |

## 步骤五：推送拉取镜像

1. 执行以下命令，登录镜像仓库。

   ```shell
   docker login --username=<镜像仓库登录名> registry.cn-<个人版实例所在的地域>.aliyuncs.com
   ```

   返回结果中输入[步骤二：设置镜像仓库登录密码](https://help.aliyun.com/zh/acr/user-guide/use-a-container-registry-personal-edition-instance-to-push-and-pull-images?spm=a2c4g.11186623.0.0.31d060714w5zQo#section-sep-lzq-eyt)设置的密码，然后显示`login succeeded`，表示登录成功。

2. 推送镜像。

   1. 执行以下命令，给镜像打标签。

      ```shell
      docker tag <镜像ID> registry.cn-<个人版实例所在地域>.aliyuncs.com/<命名空间名称>/<镜像仓库名称>：<镜像版本号>
      ```

   2. 执行以下命令，推送镜像至个人版实例。

      ```shell
      docker push registry.cn-<个人版实例所在地域>.aliyuncs.com/<命名空间名称>/<镜像仓库名称>：<镜像版本号>
      ```

      在**镜像仓库**页面单击目标镜像仓库名称，选择**镜像版本**，在**镜像版本**页面可以看到推送的镜像，说明推送镜像成功。

3. 执行以下命令，拉取镜像。

   ```shell
   docker pull registry.cn-<个人版实例所在地域>.aliyuncs.com/<命名空间名称>/<镜像仓库名称>：<镜像版本号>
   ```

   执行`docker images`，在返回结果中可以看到拉取的镜像，说明拉取镜像成功。

## 相关操作

### **批量删除镜像版本**

1. 登录[容器镜像服务控制台](https://cr.console.aliyun.com/)。
2. 在顶部菜单栏，选择所需地域。
3. 在左侧导航栏，选择**实例列表**。
4. 在**实例列表**页面单击个人版实例。
5. 在个人版实例管理页面选择***\*仓库管理\** > \**镜像仓库\****，在右侧页面单击目标仓库的名称。
6. 在镜像仓库详情页面左侧导航栏单击**镜像版本**。
7. 在**镜像版本**页面选中**版本**左侧的![批量删除](https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7120512561/p435592.png)图标，单击**批量删除**。
8. 在确认对话框中选中**确定删除该版本的镜像**，单击**确定**。
