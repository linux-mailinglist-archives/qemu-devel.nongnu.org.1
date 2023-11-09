Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 778957E667E
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 10:19:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r11Bs-00065K-QV; Thu, 09 Nov 2023 04:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1r11Bh-000639-5Z
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 04:18:58 -0500
Received: from mail-lo4gbr01on2097.outbound.protection.outlook.com
 ([40.107.122.97] helo=GBR01-LO4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1r11Bf-0002J5-EG
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 04:18:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4TBl1LCfFGBIau+56CBjd9ZKeojkATnh77UocgRUAa2tZnecUW5ObdO6Ppyr2NO+p0RN+VmubQkAH3qkFpmehCD16ooTYEw1rGf9hPKj+JUhaxrZrWM5fLM4obfSH5ypYi8UUh8MtxKCixi/ZxaPWL9lctVG7znIs3v+L/LO8dxANepTBZMfFbD/N35fN+8GqAxf2TZ1+nJX5x5stMNyfgxoQnhnZ4OasEzyruPn5gGnTP29vCn0YSKvB6bUqoWgLgxPxTUrt6jR5vCdBnONIEEF/P0rvoQYOts+hrb0+ZUhfrTFkivELWzESDrO2oliBoFIjNVQGw9JLhsfGFY6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5G7XOcKtovDh5oNxVTKVE9m/1fUYLktR6tnQLnoT6VA=;
 b=L2vqLzgOW+zinKSO7yiTu7N/Tf1z9rRPzILLDnNuFDBufcsUza3twO/+/goWXMVUOaUpv5oBNqb6nuXceXx11LAJ/nTDY2RsLNTa6e1eMgcyFELVuiHgLzKFy3NXi3BN2pUe3nGdEed+03/UXNCPih/o0TwXQsVXq2QlAsoGKEBRXpf2MmgY9BC4Nlh+UGH0zWQ4KfkD7+SqaJM258cW7pvKxLcRs9FxF0xZQvt/jnyfoJTXGgRX2sJggpMPfc2FckFQC6PQ/uGy3n7C++rUcCDL9nUKpYFwMW6mQxeT+4zuoK+50Vl3e2G9IVxs/QdCyOvbNpN9JGOr1hiSn0MSag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rapitasystems.com; dmarc=pass action=none
 header.from=rapitasystems.com; dkim=pass header.d=rapitasystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rapitasystems.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5G7XOcKtovDh5oNxVTKVE9m/1fUYLktR6tnQLnoT6VA=;
 b=FxmEd+neCWRC+X98c0TFksHNnKt4wDJLOxKNmpPDGiohm5aY/4lD8AOvub5pi7TENe1zspqU99nnQI7tdSaWYWr0qCLMEs01LcHYOO1o2iIbMvkb2Bo1TCvgokeoEOMlOSpg6QAQCin8E3WhgMwEuIEGSbJBjqaQrjaN3KlU9ig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rapitasystems.com;
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:d8::10)
 by CWLP123MB3282.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 09:13:50 +0000
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e732:bfe0:f22b:d2c0]) by CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e732:bfe0:f22b:d2c0%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 09:13:50 +0000
From: Greg Manning <gmanning@rapitasystems.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Greg Manning <gmanning@rapitasystems.com>
Subject: [PATCH] plugins: fix win plugin tests on cross compile
Date: Thu,  9 Nov 2023 09:13:16 +0000
Message-ID: <20231109091337.415-1-gmanning@rapitasystems.com>
X-Mailer: git-send-email 2.42.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0040.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::28) To CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:d8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB4341:EE_|CWLP123MB3282:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b48a272-64a5-4ac0-d2d3-08dbe1042f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fY3nIksFzeqvFb5d2eBG4w2EYZCvAB4cUNG+AnlhBWaWPZmcmldGYEqIAG3dMLGSmq2ibHer1bJUBGIoIv81e+FvDpPeM2PDq+hjWiTGo5C3KtJCepLiOCcjuElFbFlCFhg54TccaI+rbCwLvkTz9tMA9cE9QDGVNMC3H0YDhD/AjkoqgM9fmdS0iU3b4WprmmeRn2fPosvFzqxax61uxG/v0vBu20nmWWak0bMH36Hip1CO8BrUGcCWL8rINf+HG4WY9LxwPlJL18uOD4z+gBdX2fcihr7vrvomhrJ+erqf1cgYLgv0sTT23ySfINU2MaE6LsYwsSIU4k4ALb+Q+SVD28Yf8tlLWR0Ae7uzLzoMwdUwVZjhewURwH/QKLd2SSyP+jGQPXz5NJ2H1ChPX3AMIOt7TtJjKax6tIiq/aWDVG/qgtrt387IxyaKLObmfF2ync50YG2NMYMLqssTJ7kEKS4CAASeNU7MfXX/oeMbRFAc1dnKXuk0qL8GkhQQsROCDF4i5zmkjFlBkCWu+wjA40rDjfBryEqvizMMTxT+RfMIAP17BlTY4X7bDJqdH7m32K0juy+DuMvvs21lWRt29Nc3rDzvr61fx5tlh7pJUXJiD/oLSRQq5BCC/8HU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(39840400004)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(83380400001)(26005)(2616005)(6506007)(6512007)(38100700002)(1076003)(107886003)(478600001)(6666004)(66556008)(66476007)(54906003)(66946007)(316002)(6916009)(36756003)(41300700001)(2906002)(8936002)(4326008)(6486002)(8676002)(86362001)(5660300002)(460985005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QTA8SWICGWgkBW5DszjuQZ9bhSiCpHIH4tYSLZwK7Nh+HcpGwk3mHYWG6zIE?=
 =?us-ascii?Q?IAjxlLw8AtUBOmPw7ot9fl0hhdHloBmfFwtI5zP2GczDrqBpM33ewVnv/PUH?=
 =?us-ascii?Q?s+rZNj8JwbXYoqQT9K5cEInn4q/+YQCAwGKOC6CjOrRF89tw905diYxWwIl8?=
 =?us-ascii?Q?cyugTLVY9OWLL+bAvghd0UUt2YGh67wpDHRmklulFGZXooWQ3i6gM5DbnjDf?=
 =?us-ascii?Q?qPJzu6QxA7SmhbkQXCh1a80gHXojeM89CLHUyH8D0W2EUZKhmbgYQWw1lJFi?=
 =?us-ascii?Q?h1ejsFzzMzECwhptRcomKLQEfZA+yaDmWliEJq7euMkPcJDJYnUJwGyrGlLz?=
 =?us-ascii?Q?wM+yN1ff39LQYCStR+7QbHmYYNpG4fDbmt+Y9W8vGIzFw1kRGrHgytC4iAHj?=
 =?us-ascii?Q?IjWX0Q3/rBf58s5IhCYpd5kmBEvQFf7+wVOt3gpoJkcnJkBzIqoXX+bDAUns?=
 =?us-ascii?Q?ZKOEfCsJ8Pz7rzye//rVYxlWbahGuHX26tB2dE+k+I63HcZKj54SbvrswJX2?=
 =?us-ascii?Q?kFX9EA51o6EBhqobBj2lWh6DEbeRUVBFFb+nZ9VjQDojIaka+7sYystvzk3Z?=
 =?us-ascii?Q?CuQwzfuBgABJ9CE0EcxE4k0QGa2WZyRRlYp1IJmDLR1JDmoOh89wUiA+5F6+?=
 =?us-ascii?Q?hGyY7IetYPYS6C9uL6kyheX++e+9UEW8YmesTc7pazebwOSV9aZ5ZLXnAHF0?=
 =?us-ascii?Q?UnOZp91wXuGF6HU/x3Wf807TjLZz7x12UyaQXt36JHZx1FNsNmVEWW6KeCwl?=
 =?us-ascii?Q?6Eq8eHNuHc+2fRqE0JybLn0EV8uo0HmNe7XqgLKokUIVjxjk/aD665TON8dz?=
 =?us-ascii?Q?7vbCfAAFw3rtSOk4Z628/NQ2Ozezemzg7j4NznMmtVb+sYdf4IA6zZKwgQgw?=
 =?us-ascii?Q?e7Owameum3TA/BGJ9dwmUYDkXmuXktlU2x4CfaYDbHkJ5J2lgm1WCUco/ujf?=
 =?us-ascii?Q?vXGLtDUfyyytdFuVa9Du1pXHxtoJPWUDFsGcNj+ydDGSlbh7MwyfA+oTx2IK?=
 =?us-ascii?Q?aaYeoTuAGscuRmbEVJx7uM9BxeWK084E5mo9HOBWqLyDOQ8knIQ8Q6Shdtv7?=
 =?us-ascii?Q?TSaVBRyLJFrJauvrZa6s/GePzQOXiJgETuboa8OQsd5EXI32YGMWnKaxnbiY?=
 =?us-ascii?Q?hGrnpJcepjsQlzCj3C39lwSSDHSbP70/nNqN5qD55dBCbTbjTMToX5pVbxEf?=
 =?us-ascii?Q?JeTEj4q920U1+asxEs4vnYI4DkQWYO93kwKrDPD1riv3pUBIFB6uj495vPOz?=
 =?us-ascii?Q?8E6hQCHy4S+Ba0mcOO7XNgCu9t2szsLOnpRR5Ro+KRw1r8q0CAUNTyg86Dhq?=
 =?us-ascii?Q?t5gsFoJBGNe4GUN3dIBUpG9qOvUNdpCPZIHyQGPIg37+wn9FOPhhx3UEFfUe?=
 =?us-ascii?Q?HSezdFPpVWjyNO+Lt5QI1Fsv7/O3mL3LmENNwU2quASSyIwvmnZRrBV2IxFe?=
 =?us-ascii?Q?xWgh+We03rbwZzvUoalDJsIDnUaa3cS8Ra61NlThIupBmTS05/A5BYR00nb3?=
 =?us-ascii?Q?3EUa5tFNFjpZaMLpUXW6pX34pstuYp4xgamJv8H8bko1uvi/TAai9+b+zAAx?=
 =?us-ascii?Q?pzgU22k/3oq39/SSlWkJOKVV6Mb9MegEqIRSF1KpXA1gUWNwIYKDFXfToeC8?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: rapitasystems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b48a272-64a5-4ac0-d2d3-08dbe1042f7b
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 09:13:50.0713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 63a1ab10-c4bd-4b99-881c-0040cec74971
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzZizEpHb4vTX+NTIJvjfzJg/q4QaNH0rcWnLzUWNP9J+hVam0PuvHQlWIttrzMI+wwiseolg8H1RD4RBLpsTr3OjyVwjfl0FyrZ1aURC4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB3282
Received-SPF: pass client-ip=40.107.122.97;
 envelope-from=gmanning@rapitasystems.com;
 helo=GBR01-LO4-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

fixes #1927.

Cross compile gcc is more picky about argument order than msys. Changed
the meson command to take the (now renamed) libqemu_plugin_api.a as a
lib, rather than an object. This puts it in the right place on both
native and cross compile gcc commands

Reenable plugins on crossbuilds
---
 .gitlab-ci.d/crossbuilds.yml | 2 +-
 contrib/plugins/Makefile     | 2 +-
 plugins/meson.build          | 2 +-
 tests/plugin/meson.build     | 3 ++-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index ac71a2abd3..56dd603a86 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -165,7 +165,7 @@ cross-win32-system:
     job: win32-fedora-cross-container
   variables:
     IMAGE: fedora-win32-cross
-    EXTRA_CONFIGURE_OPTS: --enable-fdt=internal --disable-plugins
+    EXTRA_CONFIGURE_OPTS: --enable-fdt=internal
     CROSS_SKIP_TARGETS: alpha-softmmu avr-softmmu hppa-softmmu m68k-softmmu
                         microblazeel-softmmu mips64el-softmmu nios2-softmmu
   artifacts:
diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index 1783750cf6..0b64d2c1e3 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -49,7 +49,7 @@ all: $(SONAMES)
 	$(CC) $(CFLAGS) $(PLUGIN_CFLAGS) -c -o $@ $<
 
 ifeq ($(CONFIG_WIN32),y)
-lib%$(SO_SUFFIX): %.o win32_linker.o ../../plugins/qemu_plugin_api.lib
+lib%$(SO_SUFFIX): %.o win32_linker.o ../../plugins/libqemu_plugin_api.a
 	$(CC) -shared -o $@ $^ $(LDLIBS)
 else ifeq ($(CONFIG_DARWIN),y)
 lib%$(SO_SUFFIX): %.o
diff --git a/plugins/meson.build b/plugins/meson.build
index 40d24529c0..6b2d7a9292 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -28,7 +28,7 @@ if get_option('plugins')
     # then use dlltool to assemble a delaylib.
     win32_qemu_plugin_api_lib = configure_file(
       input: win32_plugin_def,
-      output: 'qemu_plugin_api.lib',
+      output: 'libqemu_plugin_api.a',
       command: [dlltool, '--input-def', '@INPUT@',
                 '--output-delaylib', '@OUTPUT@', '--dllname', 'qemu.exe']
     )
diff --git a/tests/plugin/meson.build b/tests/plugin/meson.build
index 528bb9d86c..28a929dbcc 100644
--- a/tests/plugin/meson.build
+++ b/tests/plugin/meson.build
@@ -4,7 +4,8 @@ if get_option('plugins')
     if targetos == 'windows'
       t += shared_module(i, files(i + '.c') + '../../contrib/plugins/win32_linker.c',
                         include_directories: '../../include/qemu',
-                        objects: [win32_qemu_plugin_api_lib],
+                        link_depends: [win32_qemu_plugin_api_lib],
+                        link_args: ['-Lplugins', '-lqemu_plugin_api'],
                         dependencies: glib)
 
     else
-- 
2.42.0.windows.1


