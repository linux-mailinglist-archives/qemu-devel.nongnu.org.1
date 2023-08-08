Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E0D773C58
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 18:04:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTPBE-0001Os-PM; Tue, 08 Aug 2023 12:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <huanyu.zhai@outlook.com>)
 id 1qTPBC-0001Ki-Bs
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 12:03:30 -0400
Received: from mail-am6eur05olkn2057.outbound.protection.outlook.com
 ([40.92.91.57] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <huanyu.zhai@outlook.com>)
 id 1qTPB9-0005fI-Vb
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 12:03:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLwB4cX62PicwoBwo9fM0Qc0XZ4sKmrGUSvmLECQ/H80XuCNv7xiB0qgWPC2E1lPjNErAJRa0xSRcLOsrWqGv2gPhp3v134lIjuGZuuhWw9A+4ArKIpuhwldXmgRYkoa9n/uCrEAgyt10TPUcHIjNGI9wHy89UyODMZVaqCDX8YmRMqQT4YTP4Ee/tQcxEd25o1D1GdXKfbCDkJ8j9AniwWuIjWS7It9yLl8LPlN7MQOfHHVx2ORfqg8E51PupHG5JGBLuVBAjqeWF+XjqoSLv5r7WcaDevTL0ItbPlx6d9AKZsXG63ItwMjlfVXhtSZOcpo6g9iiNloLmZj9b61GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vn84VDn6Hne+Igc0Tl9IjE0lnNzQxG11Jl1hlkBjaE0=;
 b=bBO1fgw0ygklVqwx3Xg/4FuAUSpAcFUc7+MYr0nHFdqvRwPg9PXDs6lKdvou1ia5Bme8NipI7jL1pnqsugPvUq+K4OYZ1QnvS88vNmGHX3Bc7PLyORDovCvUCceptmRZgoqQDIJ9gb6g49ZSY/rxqRaOf2iQ8MJy0XXC/SachXw3l9kJsyyDFp/oYTIDJKHCHlB/CX5sS6MU/TpOYSt7i4KaiPZjoBljIbL17xe7HgcMrwYiCHaw3Icuz9BIuyPTaiFVc/kvnUftaDhasMVwgdseo7rn/lSLcHOt8E9XJ/8NANIIVbpomldWzuLDCcw1PJ0YRWMvHpcD8/hKrNaNgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vn84VDn6Hne+Igc0Tl9IjE0lnNzQxG11Jl1hlkBjaE0=;
 b=qUQ+/0fOHVzWZdBQvDEEWbio5tPwCirkWNXxkCBD0+mbLGCDhVE9PGXxVp/SdCbI4+Dsl1gfyINOgvNs3X+dufQ1dgXAnAvWRWm4l7BQmtVybikNcn6k6X1U6q2Hj3d+MhS1F5yvjQlvjIHYlmgDvmmw3MVs/+a5wKcQO6oCC4mzDYp0Yz1wfK/jS8veLM9QYyMicbfiPu16Tb3Ynu92I9cS/7MWk/+Fa+koVl3hLsaZnIUFVARyABER2W/XN7NXpIUeezCb1jOy/phYQ0LA9b96w6HCLViuF4pUA0neLxdImWr4HqqcZ4+/XmxQpeZDA4Wl18jeVOkA9CgX6aeUMQ==
Received: from AS4P190MB2021.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:519::16)
 by AS8P190MB1128.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 15:58:24 +0000
Received: from AS4P190MB2021.EURP190.PROD.OUTLOOK.COM
 ([fe80::d9cd:47c:563f:48a4]) by AS4P190MB2021.EURP190.PROD.OUTLOOK.COM
 ([fe80::d9cd:47c:563f:48a4%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 15:58:24 +0000
From: Huanyu Zhai <huanyu.zhai@outlook.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, dave@treblig.org,
 NikoZHAI <huanyu.zhai@outlook.com>, Wang Xin <wangxinxin.wang@huawei.com>
Subject: cpu/i386: update xsave components after CPUID filtering
Date: Tue,  8 Aug 2023 23:58:07 +0800
Message-ID: <AS4P190MB2021A57F5CFB31C5C0314A9FF60DA@AS4P190MB2021.EURP190.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [S5XbE5kmeGrTWhhTbMKLe64xdH881KsV]
X-ClientProxiedBy: TYCP286CA0317.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::7) To AS4P190MB2021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:519::16)
X-Microsoft-Original-Message-ID: <20230808155807.232919-1-huanyu.zhai@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P190MB2021:EE_|AS8P190MB1128:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc88653-5d31-4591-c64b-08db98284bb6
X-MS-Exchange-SLBlob-MailProps: mWtqiNqNgRv21NE1NrA6pbK48PbEI3gK04Xgbtlcy+aox+n8yZzKdQp9DbfvEvbgLE6GrXITNB4WurNx8YyyiaidAz1jCf8Kum5lAzNnyBUqIimWA35vM3RDAM5ZBfXpZRKrldPALQeujV4pKYI2D7SVcwzdUGlGtTbKuSZK1Bg7wCBc/1ND+KbSX30tZrKQKPeVY8fAQX75dVDR+S054BvrwC/awYOooOTmu3SNv8CoX+JoTWmq8k1puQGEd/Os28TozwNpFm9Ofne6d/nLiBdzYf2D/EUH5F9Ap1xxPIU+dLMZSJipeQ/YFAj4HVQNjLiwh8Q+YKgcLtxiTtHPob76Bfu4oY77/cNCzNh5ky6HMCqmFIfL4u1F+po75TSSmf1EERt8JDQTL41IoO5H6lGsWIVNYGHL7tUJowPnC+/jM2FOpgctdHOpsphn8s0sPDP8tBmCC+tfrPtoqCBsDsDq+HMEx4i5zIia6Z7zxIIw+Pb9zM4BCuhW1NKVkYVOaC41/TeaLQDUhJZ97PNT01oUpXZhsfEiyc5YFDSWx8dfQGtvWTcgiT01t8egTMVO6yMFmrcX7SWZzs2+u67z2k6zueN86pcO53acAfHVCFsaEhm9bDv4e4nAm9JVaTRalYG7c/Tu/OsA8TcWojoat2B0GhIsO8z5NmPq0bEdx6r1dFKW08cLFXHuPpgtRsowMkJ1sIeEk2SDwcydGkv9h18Zudwl8V/jdGbzOSfgSARE+4AmEwfPfcf6Nc9UMaUN1NkZmopPioO4PbTXeTK3l+m6bEX/G5lvSQKCZCDYLU8=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N103g4HiJ8/cO6VSla5Iz+30m1bBr7/2uo3ei89smGPos3YWULuIRbzpiPJoyiYPno6NCrbpBlBwcUrpdNxFqwI8jR3qg7safmzoENZjjmDURK6T8XMEfYNTBX/AtZdviNWg5sbt+xeSgQWsavBhIq2DS8Hk50ndhV2ye9B8GQj5MkRMhsh8d8biSMS2HECTO4jdl7dW4XIGISXWbai7Ro4ry7sBsh/hqYWbipZ0uhTGPKKbD/y1ppv8wserR8gNbAGtRGBrhwf26vxy4U19u2MLJWvNZ/zwswD1mptcBL6g7z3G+RnOhjiSH3b5Q8cbWTPJi7FFjKqnSSNztPg8AhXcxF3NmhqqS+ydEF8RITV10li7cM2HlQyNJ2CXrqS+mwZ2gxxDFgIGYpyFcvousS8a8KYRDUfV6DumBTa7UMC/kdcV42OXJX7HcDJEPBDmog9Netdhr2tftvaGlcQVdMXSEiIzF7Bqe4DLBbGKhniT7eJetTYrJ/AmaWPZju3ZPTxChJJQBoL7/2VPd4FQ2XSMeH9kuAiu18ewzZSdvsDOvXqZS37V6sOzkgG6LWrMTo2ZTO4zdkqw+d9/VFtu1DTbu8Ct2yDbLHB+YynAjBQ=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iAgoyhTstYqXrOTmMpCtsC62N2Daghk7J1VREaqX2GcqiGpsdPdswXi8vo1t?=
 =?us-ascii?Q?Ur6XGWiiTFn3XMXFPaVRzlUlFXe1L399dZQsDav382LqXQPy2xk7SmBeD/Pf?=
 =?us-ascii?Q?Y98IiZPjlNKe2NQLVSuwcMWpthsl2ZrbDkCeC2FleopwaB2Qd+QbW8+CFZ5N?=
 =?us-ascii?Q?zjbj8o0xac6i4JNbkEMCFd3pNUIcZEzQYZgf7h91QgpVebwFjHbNKeHuJy12?=
 =?us-ascii?Q?CNfJS9PgoA4Bz+wUAOD0naa/iG+4Kg2bStz4H2ouG5ouW7UfrZyy7+U7thfM?=
 =?us-ascii?Q?sWV4GzDI4e28QMA+5Rx4jqHONVGAYfcmuRH3uL5rZGOf2KEbjnvS0a6DGzmG?=
 =?us-ascii?Q?R15uLb4VafAf+QXLd+7eLNm43gOzh8S0WUy9TTRf3PRv5xk0ZUXhBKvRtsjA?=
 =?us-ascii?Q?w1+KURvcTeduqTnm4W7oqngueQACR8dsWd+1bMxW9aOHmwIT6BEIQPAypa+0?=
 =?us-ascii?Q?uX6X2Bf8rVdnCgkOESDIZ5Je0EwwgSMvvZdM02ESsH4wP7V1vnujBP+iwlZa?=
 =?us-ascii?Q?DW0o/YlqYyOEm3EqeivcqvldRAUMbmNwpHHh1VCoaHyQuT29tV4t1CU+NFR8?=
 =?us-ascii?Q?BVO9XeYnZxTCfrsadmXITFyND7nzUKpNTFAda8VaB/m3JtoQPMc6wKAd48of?=
 =?us-ascii?Q?zQNymRnINyM7yJuDWB/4ROxQUFTDD/jsQMvoT95e6EeP8vCw03w51hGIM8Vp?=
 =?us-ascii?Q?OSolHar4ZcMIh42oxhBdTDAnpEpzSsf8vJbWO9rGgen3ivnia/I9D29jwe9Z?=
 =?us-ascii?Q?s7CjJ7RYDffa8qY4eAW4AaKNE58HBSakU9arwCWYc/P1ecugWlyvBagJ7dB/?=
 =?us-ascii?Q?DWh8Oid5JdJRWCcSbRXYQevXEYn1rtbxHyb6zDLkZC+YxNI3L04bCiKWl+GB?=
 =?us-ascii?Q?FpC4HW58eyeM6iCrjOHTueg8dx5gpZv/8SLrLZZF99tel7Algrsg2qTdKlHg?=
 =?us-ascii?Q?0Ad/FVJ/1LB5Vfw6x2dRAErAr2EsOo+8u+JUkrPpn4kjuo8/eQSBBwtQwJYB?=
 =?us-ascii?Q?RVq5tb1j0GQfb20oKW/wSr/Dou8QPaqrWUC1ypmhq/ml8iT6nJy+3TbJ+mgr?=
 =?us-ascii?Q?uAJiCiQ9ZqlLBfShXiqs8kJXaSiLMYPZ2AcrabDRAqQDfYxXQ/CRH85bUz5O?=
 =?us-ascii?Q?wpYh7WV8DV/oLbRGQgyCKpQibjLepJgHCMwMXtxmVEAHSAs9C5t6tHKcujuY?=
 =?us-ascii?Q?xQDH/aMeDIFtHHRIvDDAmSbuGbpLL67WvIQxbA1KhYPV06Jx3iearbzjwTs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc88653-5d31-4591-c64b-08db98284bb6
X-MS-Exchange-CrossTenant-AuthSource: AS4P190MB2021.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 15:58:24.2327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1128
Received-SPF: pass client-ip=40.92.91.57; envelope-from=huanyu.zhai@outlook.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: NikoZHAI <huanyu.zhai@outlook.com>

On i386 platform, CPUID data are setup through three consecutive steps: CPU model definition, expansion and filtering.
XSAVE components are enabled during the expansion stage, by checking if they are enabled in CPUID. However, it is still
probable that some XSAVE features will be enabled/disabled during the filtering stage and the XSAVE components left unchanged.
Inconsistency between XSAVE features and enabled XSAVE components can lead to problems on some Linux guests in the absence of
the following patch in the kernel:

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1452368.html

A simple case to reproduce this problem is to start a SUSE 12 SP3 guest with cpu model set to Skylake-Server:
$ qemu-system-x86_64 -cpu Skylake-Server ...

In the SUSE 12 SP3 guest, one can observe that PKRU will be enabled without Intel PKU's presence.
That's because on platform with Skylake-Server cpus, Intel PKU is disabled during x86_cpu_filter_features(),
but the XSAVE PKRU bit was enabled by x86_cpu_expand_features().

Signed-off-by: Huanyu Zhai <huanyu.zhai@outlook.com>
Co-authored-by: Wang Xin <wangxinxin.wang@huawei.com>
---
 target/i386/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1242bd541a..1f6424bd80 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6901,6 +6901,9 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
             mark_unavailable_features(cpu, FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT, prefix);
         }
     }
+
+    /* Update XSAVE components again based on the filtered CPU feature flags */
+    x86_cpu_enable_xsave_components(cpu);
 }
 
 static void x86_cpu_hyperv_realize(X86CPU *cpu)
-- 
2.39.3


