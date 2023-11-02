Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7483A7DF8A0
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:24:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybPC-0004jR-3z; Thu, 02 Nov 2023 13:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1qybP9-0004hK-Bv
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:22:51 -0400
Received: from mail-lo2gbr01on0707.outbound.protection.outlook.com
 ([2a01:111:f400:fe15::707]
 helo=GBR01-LO2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1qybP7-0004ME-Qa
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:22:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzaC0tDd4f5BtqUDXe4BS77mPtmqkw/DLNj/0E3LIqH/LHpybvNUtyP1GaIlbvtoiCThdld2FJitZgzw1BECmVUnE5e1zsX0kvSdE8nlr6bdlOVaZHhrFvzPR5329iCKC/qVjXHSSQ6SoEBj81wSX2AU4Gy7+ARV/7/XPsHAAot4uU5yqJmBLBWzj3OG5hik8FoBewvA/8JvNXY/fPIysUXw/LQqUrxIDWBtgYCNMqDd2lOgYLODrJynWDn1M9kSZmcrJh3zKxOGGSDl4GZ+XYeobp8EpOzKAC/yskZNRvqudsKqik9lsYiXA6lNXSRnK3RMMz+yHPD1GrcWQbFJRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqJenFpOkaZGD0stEfyWz444Z8zJate4MIi/ygJhhfk=;
 b=dIJbc+LuyQ88BIh2BjTI0Gl24EVrDtHSB2T0MCA/qE2iUnnPGRzSBjWAZ6wCzXgMqjy4ppO8duccj24B8cDQAVNSXfV5RWsLdeFkMqEV83q4Sp2Bl0MgcGX/h5mZMA1oPEcum7MkuTatFho9vl3VzWcl/73nY7HSAb7cC+Z5cvuvC5Pbm7xwV6DzczZQZNbOuLWYAgFNowpPbSkDgUTEjsuer5iE7mKdjJPSlyQL7vsOsmajou6L3MWvetE4VzSioX6uNgCpKtJnO+ZQhCd6lZXvPMNN/C6S2EKKy2TGM5K+KEUPUnhe5MLF/k/41Ri9ANqMy8xUHZLPq7XA/3lufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rapitasystems.com; dmarc=pass action=none
 header.from=rapitasystems.com; dkim=pass header.d=rapitasystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rapitasystems.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqJenFpOkaZGD0stEfyWz444Z8zJate4MIi/ygJhhfk=;
 b=L2KgGk2Se0kd6PCh2P1pGcqS+E/ZU32jkAeV/dVdXLojPV601YZTRyR7jdzTBuFWpS4WNx/ScIQGvRdDqxxJJ4wmm5olSL6lU7tHFSg1ZAWxaAtj32In0uCpuxH9zZenjRFbM/6Rek0kf3fW2tmgwCP4JD+fJhRZqdU24UWpTQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rapitasystems.com;
Received: from LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:19a::8)
 by CWXP123MB3365.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:7b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 17:22:38 +0000
Received: from LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM
 ([fe80::a33f:4559:b41e:cea9]) by LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM
 ([fe80::a33f:4559:b41e:cea9%4]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 17:22:38 +0000
From: Greg Manning <gmanning@rapitasystems.com>
To: qemu-devel@nongnu.org
Cc: luoyonggang@gmail.com, richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Greg Manning <gmanning@rapitasystems.com>
Subject: [PATCH v2 4/4] plugins: allow plugins to be enabled on windows
Date: Thu,  2 Nov 2023 17:19:47 +0000
Message-ID: <20231102172053.17692-5-gmanning@rapitasystems.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231102172053.17692-1-gmanning@rapitasystems.com>
References: <20231102172053.17692-1-gmanning@rapitasystems.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0282.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::30) To LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:19a::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P123MB4352:EE_|CWXP123MB3365:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e91ec5a-e041-4c68-10d7-08dbdbc84ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qhSaavY8yrBSvJgM71qtTPzO/NIh3tFpsUX1EvhKi9wCbj3Ysj8a1Pmyurk4hh9Xj5E2+2xENjSBuU6FfLE3VFOaf/yhWP+yq3kPm0UEwDe0mV4xO8hW66GCFVTD/5PXy0tg9vxXU4r6G2vLCABgE31zOCaPNmSP0NY+wxM9lrVbxMRXlDw7u8W67q/NPZJs7eGWyBAJDdyas+/hP/Cia3/Lbx76wgzuEgJIJnODdQs4W1hbtkmMzU4jbhC1Uf98as1nRUln8XGkzLP1lEO0MkP+zbFtDNQtBcWB4nhvmQTSKTaJ5IpeOvCmYgYmxWcTXM+r6abof7whO8rPss6ZXd/Er47YzKqEnjd8JRbl1i6/0TnJzYB7DT04f9vqjd0pMI/14FVwXcKieJzk/QDsOaYoFuHzTb90Gavp5AgEqmdKBgyrVWq2fmUKV8oan1PoxvAvJhYgXCLVftT7UnuAcvPOjRSS5yGcrJA0xiPWf1yIuHmowvzHLW/eGWoynFMSK3CucZPFpp60kjhjdf5B7Qc5G1Afpv+IIQQGxwt+pe/f4wUANmXoO1JBA6x62jdm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39840400004)(346002)(366004)(136003)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(66556008)(54906003)(6916009)(66476007)(66946007)(316002)(6506007)(478600001)(1076003)(6666004)(107886003)(2616005)(4326008)(26005)(8936002)(83380400001)(8676002)(6486002)(6512007)(5660300002)(36756003)(2906002)(38100700002)(41300700001)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a8nd6/8C2DhtwB3Mq0YTub+2GSy0JUam3a86WwgsvG4XghDiOYCQZBttYa3b?=
 =?us-ascii?Q?0ivDdl6V16RIuUCbs68XV6bdV6/ykYeT0W1p20Gj5n22RpylLgvzA+haEtuG?=
 =?us-ascii?Q?TVYcR6rjIEXWJ5Tpf2O5rFEfDRXjRqXBzM6m5k2mXQxzZBClEI8sZ4zES9/i?=
 =?us-ascii?Q?a3BS5ynMkKoJRHo55PCHcwacvv7ugykGQL673Sr9bj4GhrphqawB3aF4BW5y?=
 =?us-ascii?Q?EiAXl35lZzWKv+2s0MaB3uoKxq5QUC/PxIQL1rtNNhBX/E6Sq5eOrGIroU2A?=
 =?us-ascii?Q?r9Bp6Z2Wx6Y1RMXgBfwv/YIYtIGuMtnjALPrIMwhppG+XxNqUEMKo/rxCa8X?=
 =?us-ascii?Q?1xYCdIyaGG/RnDrnCNl9dYCoklTKCdgUGV2+y2SQCcwNUeEOa4xIdO9zCH/0?=
 =?us-ascii?Q?YEKAjGFXc0XcaTjlQkVMlLtjzNXSXsZspgCRrtTkWAOiDOe8AMJG+nSlli2V?=
 =?us-ascii?Q?HGa9eV0t9ckHZnmDvHTTvNsCXVTkYr3zPTZ299JkJQhK96WuZW2xLuoysmYL?=
 =?us-ascii?Q?nyeSuSF4zBVGDatL3Ppt/etd9lDI7wGFszJ0qE7OxjJpOu5yfN3xawiuWS9L?=
 =?us-ascii?Q?t5xz2su02h52I50daKXPspJD8fL6ubOPbqlzHRSpibSFTGe307xo5mmat2r6?=
 =?us-ascii?Q?IxUTxl/YRP6ngDfX9zBzDSfQo28Es3AaBoIpGIf960CdRuJLFCNqhoTqVwTc?=
 =?us-ascii?Q?7M7MA1SG7AeDn+pL1x2zjJsmbGJUMK4zEJDzJpoJzRbmGXXXpXxvGRl2Ljvm?=
 =?us-ascii?Q?WKsAVdqD/jCdtjUwTaNBSG1pmx+lY+mF2aQItmfHhq7Ts1MGFPVVzq3I/rw9?=
 =?us-ascii?Q?17/C/68gM7uTu5K25Un3xQyVc7Q+xbleTTOGSiYl4hKSqd2DEI1D2UM+9mRr?=
 =?us-ascii?Q?ZbBKerWbSpKMxZ/ccr4VbqcqoLyrMZVQXdvehtOAIh/3VAYBf1OVUaKg9bqo?=
 =?us-ascii?Q?/PTv3BeOv/hl8wBDuCiVVpDB9BQnUNw7bXgaNxBAf4s3hBfBJaBJ5Bn5bqkq?=
 =?us-ascii?Q?g8tLsHXoIRfyTXrpJNab8bj+t89DmnanadjgbwPUhVkwZeINvke4ShX3Y4iG?=
 =?us-ascii?Q?EZ9jXgn2Mubgc9tUS8wAQWZdmGBlfU+VdJgl5TdYnmq9bT8zfP5KXFInj+Yb?=
 =?us-ascii?Q?/Gzy4olo12iXs9G+TJzEXcL/N9AJg5txvFjuMsgVIBbctEZ/jp5j9ZDXRL66?=
 =?us-ascii?Q?Ie4tSRiZpHA8N4NoVWH1Ms22YY7hy5Za/aa48Bp+hixeE8oZsX7A+queIHL5?=
 =?us-ascii?Q?pxqfSoH4Qd3VtUWHKRxvreWxTt9jCU/SVzI5unGDDMhEHeW3IWgYm6RAw+rS?=
 =?us-ascii?Q?sO/auACzVDQhHATiORD9Gq2NjFNTnh7LGRJPDznjtpHpADmTGzXbIsoGdhXi?=
 =?us-ascii?Q?yDrlPW0//qY68id2lVzsaV7yDLlnaKLAC+UJJ/2W2foTrJFNcGH/JEMQVZD3?=
 =?us-ascii?Q?qkheLHobpe/S36M+evC+MpRV1vx9b7WJTLbnyZnYPsn3zvGA54sQCjIZ+kJF?=
 =?us-ascii?Q?OrvqTH9Dtmd3mEWA2J+zj49+hNLIdKvt3ZNDIWE71l2duXqTKnUJos09TaIt?=
 =?us-ascii?Q?xZgJBmmrFcYxpywnwCKf2RUmLBWuQruUNna1iwl8L5vIZ8fr+iUFd0NQgRxs?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: rapitasystems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e91ec5a-e041-4c68-10d7-08dbdbc84ff9
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 17:22:38.7491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 63a1ab10-c4bd-4b99-881c-0040cec74971
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3NRmpeAGAu4S7drnlU6aBGIjDRGmgJighxezinVA435pDBM4bhtl7uwmHTc1YThWaZhvEVNWQAN0faAPOPW4GEJk4A7lDBg3fQ1sSMcTSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3365
Received-SPF: pass client-ip=2a01:111:f400:fe15::707;
 envelope-from=gmanning@rapitasystems.com;
 helo=GBR01-LO2-obe.outbound.protection.outlook.com
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

allow plugins to be enabled in the configure script on windows. Also,
add the qemu_plugin_api.lib to the installer.

Signed-off-by: Greg Manning <gmanning@rapitasystems.com>
---
 configure   | 6 ------
 meson.build | 5 +++++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/configure b/configure
index 04f2cdd166..1129e6dd94 100755
--- a/configure
+++ b/configure
@@ -1010,12 +1010,6 @@ if test "$targetos" = "bogus"; then
 fi
 
 # test for any invalid configuration combinations
-if test "$targetos" = "windows"; then
-  if test "$plugins" = "yes"; then
-    error_exit "TCG plugins not currently supported on Windows platforms"
-  fi
-  plugins="no"
-fi
 if test "$tcg" = "disabled" ; then
   if test "$plugins" = "yes"; then
     error_exit "Can't enable plugins on non-TCG builds"
diff --git a/meson.build b/meson.build
index dcef8b1e79..b855224acc 100644
--- a/meson.build
+++ b/meson.build
@@ -3904,6 +3904,11 @@ endforeach
 
 if get_option('plugins')
   install_headers('include/qemu/qemu-plugin.h')
+  if targetos == 'windows'
+    # On windows, we want to deliver the qemu_plugin_api.lib file in the qemu installer,
+    # so that plugin authors can compile against it.
+    install_data(win32_qemu_plugin_api_lib, install_dir: 'lib')
+  endif
 endif
 
 subdir('qga')
-- 
2.42.0


