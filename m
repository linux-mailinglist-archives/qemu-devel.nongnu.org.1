Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE92B7E66AF
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 10:25:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r11H6-0007lq-Og; Thu, 09 Nov 2023 04:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1r11H4-0007lU-GS
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 04:24:30 -0500
Received: from mail-cwxgbr01on20700.outbound.protection.outlook.com
 ([2a01:111:f403:261b::700]
 helo=GBR01-CWX-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1r11H2-0003HZ-Ug
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 04:24:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwnZ9By7UzEHHPKw52BdmbU4QhUMIxC/BdN8uQ9UDJqgROmvI/nf//xLvXDpldOvprQGTUUAd4wVejKz/T3OIoKhnIB+1kKi+ErWvajkxocBtAbNUsYlmALgE7/Pc6qt4zutInUXH7xmBq4tiRn8+w8t6U5zpCiARnQirPm3VC/ApgObb6Lg2B9YAkQLk0CXfDE/DDVmGn4KYy7wgYAmedA6ZUqP3dLmLFGTZCSvrltNSAd9MK/GeXkafHQF0YzOyL/pGImq0UJfsAk1aK/Fc3jp1f77/lE0tjMNoEhvNQSEkabVp3RGxwTLHmV129kz/c5ifdU3OmwQOK0RfW2JcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIvol/9YY8/4jkaKiW0HV0BhsuzJK5J+FCA72RrE7g0=;
 b=Vl+NCSStrM6Hh+2jo983zFXze0S3U2mfW66nyI8jMd77q57IWUAp3ff3Jq0N1UGELvXlD+FfTC7JouzBM+VPd7z2gpIGbcm7pGO5LbWf3yEfDgMMeFUKfk69qDLOYFohygidKdVnUeFNszXHP9vwEkDmCX46Vp3m3/V3LFxRnK16S/6mfLyyk33PkCecmtkgm55rCXPoWdD41xXAeMiXZs1FGbUncuKxW7JKzPhOD1PINeTiX8yAXuyUImy1t3RBbWUNYI5dtdqwcIJ8dyDm/VYGNuzqcFn9qkHNmR3kPD5GLX+xUZigJlBf7MAOy8ngoC7xddbJvTGiXm1kpqFbDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rapitasystems.com; dmarc=pass action=none
 header.from=rapitasystems.com; dkim=pass header.d=rapitasystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rapitasystems.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIvol/9YY8/4jkaKiW0HV0BhsuzJK5J+FCA72RrE7g0=;
 b=Yot/zBZGmakZqbhrJ+TAQHbHoe80wv0O14TVJ5hFTkfuCz3DDLqOg61d6ICMI3FDAz0xws39YHhJ7Y5VVz8zbNaZ6lzF98MFWFiw1wUHYRV2FKhLtCgGRrwrJloOIjERX0O3SvuM2N/hxWzcISQt1TXiDnk8xiYfW1HPibPWuaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rapitasystems.com;
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:d8::10)
 by LO0P123MB6654.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Thu, 9 Nov
 2023 09:24:25 +0000
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e732:bfe0:f22b:d2c0]) by CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e732:bfe0:f22b:d2c0%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 09:24:25 +0000
From: Greg Manning <gmanning@rapitasystems.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Greg Manning <gmanning@rapitasystems.com>
Subject: [PATCH v2 1/1] plugins: fix win plugin tests on cross compile
Date: Thu,  9 Nov 2023 09:24:06 +0000
Message-ID: <20231109092418.84-2-gmanning@rapitasystems.com>
X-Mailer: git-send-email 2.42.0.windows.1
In-Reply-To: <20231109092418.84-1-gmanning@rapitasystems.com>
References: <20231109092418.84-1-gmanning@rapitasystems.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0210.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::13) To CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:d8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB4341:EE_|LO0P123MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9db30c-0a8d-484d-fb1e-08dbe105aa84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmyWCXQUeaE62A3u/J53pDjspHEoSk+ej/X0f0cb6mC9DG4slPk6pt2DgQzkmQxKYwbdUPiCf/Jcn1YO2BnaPIhSm4GmigrEsRs+TkVikCOx+j9dgwzqPYgFfMbgq5jTsIP1uFdcYqXgh/PnLpusi94qNV5POvhkrIAH3eVzk0N7UjYLqXORY67jjZLrCyU16EPDsz3zaRRz5TY0YecX/cWBYMGVLCtFbmwEMEgT+yTHvw9uQll09c6HDbKcrrv2buw6s7u21rRhOcV+2kZuIsNnbR4aqhWD6c1eBqOBqi4tU7xl0C8Sg0/4loaqF/Efz07uGPXpRkL1Us+hTpuvS3GIH4u0yKdLXcO8Y1XCpaW8j5H0F2aCybO3AfMVpxAXzobPELw0/3hMUg+Ycc8UVBJHPGfH39blL3TqZ1ZB0iRR7cWlj2TIskUHCf/ku71JoF8K7av3WG3e9rFOsrzr3sHp90lt8BKEwDQrc26SKRh/g7bIlQYMERcNpRJt0xpyzacSVm9cmoWQ4ftHHU9RZ2ocp1/xntOBo2W0Q3sH/BY4VdJEtV7CpTm2ha4Goc+0/8XRORNm4sTcP8DSfuf+zy43XrSPzOBCQPxCPh5FJZGIl4qKV/5R+LfI0IjqXwSP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(396003)(376002)(346002)(366004)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(478600001)(6486002)(2616005)(107886003)(6666004)(6512007)(6506007)(36756003)(38100700002)(86362001)(41300700001)(5660300002)(66556008)(6916009)(54906003)(316002)(66946007)(66476007)(83380400001)(26005)(2906002)(1076003)(4326008)(8936002)(8676002)(460985005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EETuwzz+B1/xbg4SBIhZedATfcQJrcTru5UQNEAug6HY7qUhXXCY0tzwWsWD?=
 =?us-ascii?Q?y14COQNlqDluqJcoaZ6sam7CbMdm+UZZBRMsA0mO5SI1xIqo2R1UmRU7/L/1?=
 =?us-ascii?Q?6S8sylDnJ7lLeZwCd6hbnMnLt0m+64xTNeuBIW1tWVnJh/2nFuHnof3dtqMk?=
 =?us-ascii?Q?0WMuX89FgpdHiTdWp9Xg5caIsgJS31nGSqYg2//0K8Y5IjVWQzjTWV6H4OMQ?=
 =?us-ascii?Q?8JSy+a+eLKjhStmtCG3jKlwIMo9FLM4QwGSUcwJMyh2DvBHNyGgz7QzJGB63?=
 =?us-ascii?Q?2MgCg14/WhFRLLN/iSKUwcRvPzqWsdY8hREu9qejlq3AVXFaKlHXrf2iJGkt?=
 =?us-ascii?Q?oAIMWhnlUN1c++DOaU1wYY/kJTCAHZcKHOlUQsWB+KiQNBjE50mum87UqOjy?=
 =?us-ascii?Q?+BTX+18xDARxzMOx6GMDSJ0ALnKj2DhDO8CP/i+I5j9zzQA9jmzwiM/F7pyL?=
 =?us-ascii?Q?vGrBrI2ryQfMrkuI9LNt7/mxK21+KGh327Q81Yeh0R023OowUrcxDpfvr75+?=
 =?us-ascii?Q?qyTgLZXGap+xQ/JvYrBXbnlgwSVbocKjcgeqLtyCMuFY2PFQGIIrhR3FOhM2?=
 =?us-ascii?Q?8vcuYjhXS6mppCgcfCV1MuXJmITPnNmmarugriWHZDh6slkAlGSfMgUxmIeo?=
 =?us-ascii?Q?cX4t0otj2RdThTCuf9TdOTedfn/o3W+L7e2JrBIs21ZEvj7UPT8xqt7Q/nMH?=
 =?us-ascii?Q?ImoetZl5TK6wyx7VGPgwx8w3VmTHlOCgjb0vOU7x5H+62HZkiEco5E+d+cN4?=
 =?us-ascii?Q?Pr+BgK0sOcPD4Xkq4tFBYPe/ckJZeXVyla8oI3K3HlEJuM/nkNGiC3QGr08H?=
 =?us-ascii?Q?VnHh/8ZflVu2fVCVoqNfDaseZGPyUuQ10yTrlNn63rtsFpvpgeKAw11pzkKw?=
 =?us-ascii?Q?O5emT65cQLi5hll910QyIDTUiano6vyNmvwUyvHhgDeWVJvZ2eW1I7jDyH5w?=
 =?us-ascii?Q?4WhBpE0wYHXs9wCtC2HyIM0s0DK+S0u5KDULxWrhXsc14kVO62xamvDrpoHB?=
 =?us-ascii?Q?jSpUDuhLlVkX7B8toIHedwPLqEY1s62ntFW3HJNM/ttzxfKRs/9ETnjasYPZ?=
 =?us-ascii?Q?Sctuk4QpAX4X4k2Ny2KDAcvmy6chDZAVSjLhNEAxAIJYruJsTBvLFH3GsQ/0?=
 =?us-ascii?Q?jYL5BU1cGQw0C0E+njAKVj80DxXTu6k6wkFuCyPlRJdAC7qVii7vZKJ6Onpr?=
 =?us-ascii?Q?Jf+eo5XFDEqMKxM8eLRUVmEbVtcyKxUMBb+WBWD8uKi1ogoXu2BuKzrwp/ei?=
 =?us-ascii?Q?+hRgl89NFv78nqU1aphByGKQhfsvMBRrbVCoggkNVN6e1k182sj/ZgNILRva?=
 =?us-ascii?Q?O6XJF0s2OyLhVZizm4pamMNrOisopDJl580qhKd+pzOOD8IlTT+QKWUSG1gb?=
 =?us-ascii?Q?f/4wCdGMQaTZJYz7tywE9AFR0GUVgZ+ytAuJJTVqMUVOmmPXcDISKkrwI8wm?=
 =?us-ascii?Q?xMeM0UpJgB8+DKwaSJD7v7A/6wmfY+WJSArxLS5vWi9HSXSfeL3HBXdBFHQy?=
 =?us-ascii?Q?h1+jJyP37lIF4QoeZtqx8LEAyZM+VosI1txSbJBPnhZV0xpnehX+jBii6/lT?=
 =?us-ascii?Q?soLJyCOVOx9/q+KBaIVdPEFo3JSI5vjoix0lwtk60VkCtmRh4JV2e3iBK3SS?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: rapitasystems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9db30c-0a8d-484d-fb1e-08dbe105aa84
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 09:24:25.6146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 63a1ab10-c4bd-4b99-881c-0040cec74971
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zyTaTzU6ZR9tiwPW6qYnYyC2RyzCvkh92LDkrPc++BWLl6pMq6ETr0Mlg5M7//pvnfoBqzJfbtt4kYoCYuCFAfAewqgPnqPUwW7FnoeOyWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6654
Received-SPF: pass client-ip=2a01:111:f403:261b::700;
 envelope-from=gmanning@rapitasystems.com;
 helo=GBR01-CWX-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Greg Manning <gmanning@rapitasystems.com>
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


