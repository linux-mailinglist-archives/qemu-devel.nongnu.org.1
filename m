Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 935927E6AC6
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 13:45:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r14OT-00043W-6f; Thu, 09 Nov 2023 07:44:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1r14OF-00042e-J2
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:44:12 -0500
Received: from mail-lo4gbr01on20701.outbound.protection.outlook.com
 ([2a01:111:f403:261a::701]
 helo=GBR01-LO4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1r14OB-0003dc-Rt
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:44:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAcuYauM8g+hrz28XXaeA0XJ7RdQBzV7LTzxQ1eiHOZCjZ4zil7c2UZmp7eRzIVS7Z274fsXYnVt8tbNiVmmqaUfy7vPKSjno5ui+yOoeoQwJR8cCtZCCcs4oNeoxVnEkotUzBz12xzlU9V+vvL8Luj04iHpjfMBQFsloJCsWQrF34lp1mnxSw8f9i/bR5tmtv69JJkoEJ+QPlygKQnQFR29xRVZrm1eH3kWBoKIk80SSKzCqobYOglBUuqJmADH55E7FAavgQ+o8EsuaGsh+RX3dfsYIXRivqqrQ8xrR2acgKhh4/WWwRSSDlWQILrYx0bFl1ZbCeLEj4vLzH5AYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6f2sSvOEBYP4saMgNcKzhCySND+v6o9PYBX6bos74A=;
 b=jP7DlZjewNiFYpBTcgfxCUI/8kDhZffqadQizAXHPUmtwMvKyzdwm7GllmMPdpD+KY/V8dqIyX/lXYzTFYg9zwWkIbL2kkLP3WAvAZkuRBqbRqM3NLzFp5eNrOfJzSErHlhGKwnUhjLev5nT9WebIqnkVUUjil+LW2RQZAz2fyqz96n1D9iiwjI7lECyp4+whyTMCeQVfQcXVCk3HmqKtq5E1pQUZCCQLKMPwMnLdMIhFag2MVTkMdmiKTxINT/sCG7L5Hr1QiWPAXhcDC+i71e89q0fdWPv+Ohr/5yO6bPEYU2ALhTHi97Cm6pT5xpcx3t7/ZU/mYbqIHfXxM4BXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rapitasystems.com; dmarc=pass action=none
 header.from=rapitasystems.com; dkim=pass header.d=rapitasystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rapitasystems.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6f2sSvOEBYP4saMgNcKzhCySND+v6o9PYBX6bos74A=;
 b=KSypRqEj55+H+71Am2OVabllkhBGiYUzXmbaqIYLTFRvC3MfQZBDrz6DTw9+10sqvSgjZ3Bs1P8bUJKhEXiwfOdPt+1vEV5KAKNAXQt7bQ9mPRKSXdUVGIeeuS1PFUfSG8FI2dNVdQPWHlUSQhRfaMmCMj11baVbHJiuPkwfbkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rapitasystems.com;
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:d8::10)
 by LO4P123MB6562.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:27c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 12:44:01 +0000
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e732:bfe0:f22b:d2c0]) by CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e732:bfe0:f22b:d2c0%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 12:44:01 +0000
From: Greg Manning <gmanning@rapitasystems.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Greg Manning <gmanning@rapitasystems.com>
Subject: [PATCH v3 1/1] plugins: fix win plugin tests on cross compile
Date: Thu,  9 Nov 2023 12:43:19 +0000
Message-ID: <20231109124326.21106-2-gmanning@rapitasystems.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109124326.21106-1-gmanning@rapitasystems.com>
References: <20231109124326.21106-1-gmanning@rapitasystems.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0099.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::15) To CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:d8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB4341:EE_|LO4P123MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: d2373594-3a8d-407f-ed4f-08dbe1218bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u5cTjOsgjB/QNVnNybvU4SMYIBmTMC5hXe3hlXS1qqO7+LYBpja7Xm1U6a5FHdxYkWmWOMZ7tO4zJ+d1W2fmmJKKTVRjy6GoADIHL6qUX0OCyQ+O3cyW8APCCvesa3F3niR5+3XL4FvIZt9tb6L+cYYp73rtQWiIc9ifb4Oc44HlHOkP06LU6LN1czmEPdfHyHQ0MefmrGgLdgEIbfWfk4zdYaZGSX2PZdBejVkaEdMGl1UMz0zqS/yz73KJo5fUmq6c/MIIqXlMWrqyuj5agptbNUNQL1QmZOUH6DTfMPFKACDwZFnKuo5Lkkye4NwhGVqO/EbqOkiek5Qtv2nuYq7SWWlcoWUZxray//M6GE2sedmswhfiuTATYPtV/6e677yC6oGvLwglj7GbkUhqSnSDOGgNk30w07WC8fXydBvX9kHucafAwzpsz6oN1Lo7TYesmbtAPuJKqspRRCDx/X6PihMsEqkcuQxY3BYSGsWrks9lEH6EKvVQl6WU6dQJmMyUuuyEklg3LdfGFeOJFLP7gQU8IGyDRch3XBvJJG3uAPbp8uuPpaOwL9Y7zaySecMm5snGVAtPI1TCQrxHxfio5lgZ2wztkUmBtviLdM0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39840400004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(966005)(6486002)(478600001)(86362001)(1076003)(2616005)(83380400001)(36756003)(38100700002)(66946007)(316002)(6512007)(54906003)(66476007)(107886003)(6916009)(6506007)(6666004)(66556008)(5660300002)(26005)(2906002)(41300700001)(8676002)(8936002)(4326008)(460985005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OVt7H93hY4+8jLoBzIsyum56BPugDN87CYCnxn7b2UrRSr73cAFM0CZZ83Va?=
 =?us-ascii?Q?48X7rQCn+l8QKyCOhoD2AXN1/XJtp+/zzc0uOdh0mqp29K386IBY0h2hQ4g+?=
 =?us-ascii?Q?jijcCqh1/kAbVFGPPmLIxOcDb0yR/7DBdo0wpYIT2rOX1yllwW2HgjDohGZ1?=
 =?us-ascii?Q?1ojCYrIPt2PrMEYxFpwEd6HMFccS3ww8tTmb0lDXA+9clMp7lifpyvHKF86a?=
 =?us-ascii?Q?aBPEnTustEjueQBH/ncB52MsrrknkUhW5/qFvqI9sJJXYq0Ay7WrnWrfJ/OV?=
 =?us-ascii?Q?qKyLp/e9YVGtXgl/ykyr9HaHOlmZXjkYfuK3iMA5sp0AftzJkvzGcE83g8/z?=
 =?us-ascii?Q?ZQuLdJGYkx0fEv//aKGMWjSCfVKhbLVnKAwtK4zcLT/6FWCUA7pu+Vleisvx?=
 =?us-ascii?Q?mju2zOmi+o71qUYWxEbyROEBl2ECY0i0pZQIzcjO5TaXzXfka/hJXlJ7zXX/?=
 =?us-ascii?Q?mjT3yAH4dhDGF3qUt5WjBMa5Da9z7MTMLDJcd/1xhPtqx5eJ08fIGDaDjqPI?=
 =?us-ascii?Q?AOPWeZDCw1+vc9ysgr7r94F6tNwHJ1HRoIh9qjsPLbq/K5xVUfTDx1Fr0Xev?=
 =?us-ascii?Q?euHTGAZMc/winl3D1JlEO5RixeticFifMIEqlur3pQMuuQmGOR4gcp6PVoCq?=
 =?us-ascii?Q?CQK7xm2oEfwbpPwUPER7TBT4ksJ6WQfR0j/EFNW9/bhMHsSarYgQQQuQALqu?=
 =?us-ascii?Q?0Aite67JDUWm15IbOUHU7I7uSXEMow/gtWrB1NJfoM1lU42VG+aeHZ9MgNsH?=
 =?us-ascii?Q?QiG993j2iQVuW/8a/K9UVluYeXAOQadV/ytKMj0TnWzi7UKae263/6zSGoBg?=
 =?us-ascii?Q?9cq9VFLzwDiGRoKu7jOSHQCyqsf7kGuw8TvqOhcBwI9ZN7Umefcy3PkDmLKc?=
 =?us-ascii?Q?XkjYA8b+ddIDZ9vJQWsQYeJTJIqdh0xSAGUH3JfQxx5qr6QqEU7LWtvUuoR3?=
 =?us-ascii?Q?I0aSp0XP8D4erL6CXhW2+9xY38YWFcUp/NBrvYmtbm7tTKhaSzXefMQqSLrO?=
 =?us-ascii?Q?F2wpaPpVp5FS+iHLkCE0LvjqYFqfMIN9vmgmGWE+gn13DTWzBI+nLYkFremL?=
 =?us-ascii?Q?7LGlf1rJpQz+PjJR60WFuym/0p+dJYczk0PCyKhKUzvlnoc+QIoS0JoQxMvq?=
 =?us-ascii?Q?9jlJ5Ok12ZA6/xjr//seyAlwS77fNjWUzGpRNfOnwOdTr8WSA50tM9KSJcbh?=
 =?us-ascii?Q?ljKqDecHXZRtgsgGgXJ5xLUW5WHhsArb/ypIFUILFjOjeBtnmIcha1kEmlxJ?=
 =?us-ascii?Q?R+oTcp/UEWbxCKgn67emTag22pRcLXQEna4vwwBKZag/q9Fz2Bn9BAfJgBFI?=
 =?us-ascii?Q?fgdJX2POFLijn7TW1hAQvatp8iXiNse0Q6WLfMfLRM5wmEWM0Qs6C4IQVqSG?=
 =?us-ascii?Q?YdCs1NkgwCbPa2HjCsj5hl2CvsSQ2R1ZFgXvmkoplx9p0FjdtUfNuZSVHtJQ?=
 =?us-ascii?Q?yCOf2ucMYCER6u9wYw16icZslqYM5o2QeLSF0FhC6PKBGTG7rPC3ydSsHgDJ?=
 =?us-ascii?Q?jH+5PUHbjvTEjDbZI1VBhsGJck9g7ft5VIwdBf6BdbIgHNZg3U/gEQg4WBjX?=
 =?us-ascii?Q?eYXugHl7rEamKASIHtbPzhcjpsj8KqRKqYLfTB9Q7hL6hL0PfZHiZe/pnM+q?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: rapitasystems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2373594-3a8d-407f-ed4f-08dbe1218bb9
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 12:44:01.4546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 63a1ab10-c4bd-4b99-881c-0040cec74971
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFpp0pXpsdkSVUVCUoQJawBYD4RYjlHQvnIcEekLRZdwJ2PXXu0Wsb1mUgDRGUzRhPFWWIOoPQvVisvWcU2vwBH4AJAyLwBzjQiJUtXVa00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6562
Received-SPF: pass client-ip=2a01:111:f403:261a::701;
 envelope-from=gmanning@rapitasystems.com;
 helo=GBR01-LO4-obe.outbound.protection.outlook.com
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

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1972

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
2.42.0


