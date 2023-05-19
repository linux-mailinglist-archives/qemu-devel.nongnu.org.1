Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDF270A108
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 22:53:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q075I-0005E3-AV; Fri, 19 May 2023 16:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1q075D-0005Dd-J0; Fri, 19 May 2023 16:52:15 -0400
Received: from mail-bn8nam04olkn20827.outbound.protection.outlook.com
 ([2a01:111:f400:7e8d::827]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1q075A-0002h3-FM; Fri, 19 May 2023 16:52:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePQQyw8Mrye4EsThrPa0uEGClguUe1pxdV5prYnruG0AMKy+CA3NDkrL3ml9IAtLV19RPIuL7RqcaH1Jpt6WrPM7qqbhxIsyy5p0ZQHsnBqoCLSEjR3RiA+ROz8MqC2FwkjEHCc3rqeFR3u7C+o5vkp9owb4RoR+g+46PjIGZqJhx/pjnaMQ3XRw/D1fwxyEvjvf8h7quDq+bhidP9Yfx3vdCJfRRksrbJ6544ltkKFE4Squ6rE4+hmVfUqh1c9unmrcHZROL7RBovjUnonuOHyRHdyr/pI4yNWHpCWngQwLdhVUvMFqidSBYMxK/8Tc1ovfDKDwVtuh/izYPvaCuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnr+L2tHxEp1/+EjWopyL1kKNpTBzT4JtVp4mw1Gceg=;
 b=oNBGhG5p/y1arYMBvUCos5r5+BHe85EGXFxf9hOtF3pzJUK/OT/LcvXyHsPSmkF5T9MFr6OcXVepG+92qVKnWlIeNEDsHfzuAS2fkitdC0WjliMJ4XE8kGkaMRId0lhRfZz8vg3Ky6u2PFWaCodG9WF7nW5BSA8f01Djbf4FtQ6khcNCeh6PCljESmodG/kk+kPRZ8jZA5gt4+vUjPo8POHLteUo79HFVzzP60hbqFpkQg2pk+BtWLjSsvyoWnDnr4jIjsmBMuJ0obww/3IbSBRGAJTHy2SVY1T2f0ZLLCBlMXPIaIOK5z1sJmL18l1DrvkKQ4awa/I9bqPOPot0PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnr+L2tHxEp1/+EjWopyL1kKNpTBzT4JtVp4mw1Gceg=;
 b=vRGVflDQWcEEuTg26GCqFTqs2l45FzRcJBmYDJ95+URjhMtTiEz86MJvFWkiWY052OG1jrr+QHkct1uFjnf3c1gVNybreRhCF1buUjHCUQF8JGjFk/WbST+z+3HuGBpNIwnnmmqkbutLKNOnLQMCiZDSONVYW6ZT+XQitsF8357FJwW4RQbeHOXRv2GFark5I8pTE5Ad7R7LYbqlz5BuaVPSnvMSFsVN5Iu/3oQ0xeG2Dp9JPI4GIYe15TeOv5Tmt7PQmx1bhpZ2UejUOqCQsrbnIqitmhiz4Qbc6t4VYctgp6vSA1/4Ex/28+Clt00rsmuAEFenQmn4y0rf+8MzCw==
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.19; Fri, 19 May 2023 20:52:08 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::bf6e:1dc2:10ea:cc04]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::bf6e:1dc2:10ea:cc04%3]) with mapi id 15.20.6387.033; Fri, 19 May 2023
 20:52:08 +0000
From: Zhuojia Shen <chaosdefinition@hotmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Zhuojia Shen <chaosdefinition@hotmail.com>
Subject: [PATCH v3 0/2] target/arm: allow DC CVA[D]P in user mode emulation
Date: Fri, 19 May 2023 13:43:47 -0700
Message-ID: <DS7PR12MB63096EDD683DE70EBC472E97AC7C9@DS7PR12MB6309.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [2IqhfUpBGo07iUjps5myntWHeEQggWvx]
X-ClientProxiedBy: SJ0P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::34) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
X-Microsoft-Original-Message-ID: <20230519204349.282169-1-chaosdefinition@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c0ddfc1-1985-42e7-fff5-08db58aae924
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3nvAoS/oQTVQZ1S7Y8lGJvUp6lYURevRgkKenZ4SngpYug14dF6Q7j+hEM4Vp6XV52u2kHOplqeSNx4A4Ym29yJYIvEvzkiEzHQLKuQ6iWkkLHgtzy20fuxQC+mG5n4+q7ahPp2FAEidoT3G2Hlqg2MC/8DYO9nA+B65+bTXDourUKqxLJxjGQBeViY/qjV1lKhgG6bSiezRzkNEBNsb5akguERMNBsH8FbQORS94jE0fmxYshzR0qHCXpf57qBqxACqHiCZBZrnaUsy1Wh+s2ixJxJp60nuD7LSh7Y+AXX4H7LiaIe1TaHGqZuTEVdr2PnnT8FtvpzYlxZ64y9o4lc/2d6cDcMYUDHPJ9s4oFY36RKlih8o4lGPuQXX0skqoHe3hqEW91ubSoVW5ndcRF+RyQ2Cf73derVBev8/7W8VTJCwfuwBPJtunPjj8bMJy4SCDxlXMuWkGFjFn9tRT4dXhx4xaK67vPekO/8FPyAAVW7huMjpvGDUHO5ajQk0gtkUPo81LI5hyef+UiROgBHQxzGO26if/J1+5ouviVMhyNoCloCDRP5mMJVeaUMOM29ctmlD0c4B599X+dSh/8U9B43X77pj2wC7XTSjuas+vcq9stRHjHAcXJ3DEtM5b3x4Gdc59K/nAPeqKq01P+KZWK512rvZP4Hb/QJqeVG52k7BAxo6FAIhz7fwj86VWXNcHZoOkMHX37MdFw+UuimswxWQy9xoz9ZqvlFECUhFFAnuxFLyjFbTpbEr5DkoCwWUwh9c4lM2eV/X59zV9tt
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D4/VJaHw5QrRhj8Ra1JbU0Kb5u5nDpugkXwR1/lkUI7WAtUlESclqBkRx1XEgHtxlu+Coc9qxxNJC0RJ3vH0b8/0p71JuO6kioAbFa0LA9ixUYs38nqKsf5fOQaSF78QiL3gEoeMfb0B6KSnE1rAO+iNMANTALNoHTXymkA/+fA8KlLl/mH52OSitFNmKNyhTOC8wJ60X76RaX4FK8mF94OO7NFO0bw0JaSLEfOTiJ993MFHK+YkYEygV0Kh9ONKE15HTp+7CvDmBFzjaSvWG/1Aql9WV5Wqwn47PsJhH/1lOEHsrUfVakFePbBXuKaCYx3kmXO/th7UpNRaPeaOxEJD5aTcw5dZXghFGM3kUobUCBnQiHE60l1jG7q0Kecu8RcQBXTjPEjYJZ2BnT7PMba7pEy8GWBhIrx1oCVryPFtcHWb2NBif2frDVItaI83bTRLOwIFygj9FTDBruI1rNLZCJMj5k/gIeiBFvIYjMEr+EWznORjLeWHsslDt9h2MGNI5ia0TzeAD08FGYn4i8Ycb2mJCds9wJ3prQViSu74yOdx4vTOoXuUK+jvrkkU0HhZ2kYjZx6hPIyqx+Kb9u2zMvPb3mcsOQln1jZoPe8=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MUNkPxq0tjOFNPeLo73ksk4edYuUKRhbV0uGzXKjAGP7A9u98wFoz4wyAi+U?=
 =?us-ascii?Q?Dm/W+xqyTkVJX4eNaWGxztnl/aLoAKfFbeDBKrYBZbgMgNVp0vO5lpRCAlXh?=
 =?us-ascii?Q?eTHfgrdqIacNCQMBun+gBLOo0YnFup2B6lEUMAocUIY6MkBrZbSIJTxNi+Bu?=
 =?us-ascii?Q?lm//UapRXCJ2MlDrnEgl4woODD5XIHpOEUT0ASYu3VlzNyVUg9x3rPFzZ/+X?=
 =?us-ascii?Q?MW9fAwfvzrsT1mbOOPEOnJdGVZpPPSbB441eED9COFKrJ8kZV9s8tVpD5fQx?=
 =?us-ascii?Q?FtuFrBjcR4gsjnTs4EU42582pYPxk5Jx3cHm8REcv4SiioXK+LaZpfDvGYl0?=
 =?us-ascii?Q?sxlkqb3i+miKAXM2IxM9RF+hcHUlgsiTr8I3gi6LwhvhCdXjo8je8AkUlPJw?=
 =?us-ascii?Q?YdGDP8CYKHq43k4u7+IB/TYv/nhaa2G8Yrfz9RMGoFdns30wFsbSYpvJIzPP?=
 =?us-ascii?Q?ynX8LC2T7HtgVtk6pKULSo7FQrVC8X3yjTd5hCgQMaEm3qmU+Uw24n789RwB?=
 =?us-ascii?Q?/4VvHMbKA1ESRq90Dt/IEGKQNitZs24PrtjKiZgZibYrgsrnFNBQvK/xJ30L?=
 =?us-ascii?Q?y/vUPleoK5OD4Si6MxZ3OXMY+zX05crT0PNyOQGW0dnY9b9jtklCKBQoYIHS?=
 =?us-ascii?Q?5/4i5SIs4nqaMsQSxwTYaK6GlTdsIoZ72xbVVg+wssrUJuUaO6TAOLuXkNya?=
 =?us-ascii?Q?sRKufiP1Q1CB7OQ+wqa7rwjc8h1VJrRPGBZmDlVKu0T/rDfMxRfLBsiM0DM6?=
 =?us-ascii?Q?HkDd8umzEf9dkE4qn2nq5xa0Qh4zUKzsOyBomZPVPdMNRu7e3PEWaCKSoRD8?=
 =?us-ascii?Q?dNvszbBG6Q03bDLfFKKKKqiTt20a4pCYdMTpy96MJ8oU/5rbsExVpyzzaE/x?=
 =?us-ascii?Q?inUSaOZcuijjufEpEKPFM+HHtcIW9JVf5hZqXuhcd9zxq+EJ8TOIiAOS1U/o?=
 =?us-ascii?Q?r31vVhXtDUija+u7f01/6V53wbcSweonqkPiZ70VNylirKlR5y91DJjjcLpS?=
 =?us-ascii?Q?Xq54HP2Ec4VAf65xxA7SeS+ZmYydswmdgOmsaC+SnuEnu5tyhqrgK91ZnCih?=
 =?us-ascii?Q?jRA5KXM4QV9R6+QdCp08w06H3LH5NHolyHBuRenmDIfCNLbxatDT2eGZo/jd?=
 =?us-ascii?Q?7qkfepLlwbfBm0MLiVzZoaJz40lrFKgSyfZ9UpaDErFSDmSJ7xZJuRJl6hpc?=
 =?us-ascii?Q?paxZiARhbAueuj2esfFY4lpyomORJBMWPbJ0cne45b3O1iKhE6Jp1mFdA2Q?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0ddfc1-1985-42e7-fff5-08db58aae924
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 20:52:08.6988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
Received-SPF: pass client-ip=2a01:111:f400:7e8d::827;
 envelope-from=chaosdefinition@hotmail.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch series enables executing DC CVAP and DC CVADP instructions in
AArch64 Linux user mode emulation and adds proper TCG tests.

Changes in v3:
- Fix typo of HWCAP2_DCPODP
- Split tests into a separate patch
- Remove unnecessary handling of SIGILL in tests
- Merge 4 tests into 2

Changes in v2:
- Fix code to deal with unmapped address
- Add tests for DC'ing unmapped address

Zhuojia Shen (2):
  target/arm: allow DC CVA[D]P in user mode emulation
  tests/tcg/aarch64: add DC CVA[D]P tests

 target/arm/helper.c               |  6 ++--
 tests/tcg/aarch64/Makefile.target | 11 ++++++
 tests/tcg/aarch64/dcpodp.c        | 58 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/dcpop.c         | 58 +++++++++++++++++++++++++++++++
 4 files changed, 129 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/aarch64/dcpodp.c
 create mode 100644 tests/tcg/aarch64/dcpop.c

-- 
2.40.1


