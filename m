Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E91CA7DF89F
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:23:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybP4-0004cy-2e; Thu, 02 Nov 2023 13:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1qybP1-0004cf-3V
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:22:43 -0400
Received: from mail-lo2gbr01on0707.outbound.protection.outlook.com
 ([2a01:111:f400:fe15::707]
 helo=GBR01-LO2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1qybOz-0004ME-Bc
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:22:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qipv6Dp48hOWCKBs5UauhOV+pyHcLOdDocn6+2XX87X9mVbGcGZngdSnn/NVA0z0+9IhqOEwnDmOExs30jqTmDZZR3NMDWXsHzRnqQovoaHAOYm/3bk/jcpHm77q+93RKvFynnaBxzq5VIwCifZ7gktjBzDuphqsUHFhdFsHWLY7c7kNnPzSyuiiBWPI0Phrb0ju/B13LOrgcQYm0SOiRsfpymx7TIPzsywJDya4+E1Ta6RjOvS38SKSZBonfnibSDUCfykWYpoqwgAaEuZnpsfUASQ0ZUyl8rIzSnuLN1cXypJPY32NxAoVUxjJ5MMleMRMkPJuYsJMCYokhP8y8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXOZjzmVWumF8XzSMLEba2mUmzoC45eYcTCG8tO2sQ8=;
 b=RQM46sXZIGSSb2jnJS20dmADSjk/Bc373S2/NC+4aoteWkDyGoXcu51HFbiKtxDGUfIQgmcrlOUYunp+iEeF2lxTnRlGAt6PkVzgej76l/KSmZUmNzDSqQZz2k7fxRL4axam3FyUt+cK9jh6uOoACQqSRDK57MPclHZP0IiS4uQcdvJJqC+6yxQNZCkwNMtfFQkeajO9pNQkqfxHQmG/O1XiwSNIRn72BHjuqbEbZSGHU74/BYaY3X/Wkszj55j/FysodyqTP9qbLuJ+N9M5RGrwud31ud3x5BKGEWZVUT02JhT+DEkLiYEjHtHJ3fa3gg/GLc86ed0XTpYRLvtQPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rapitasystems.com; dmarc=pass action=none
 header.from=rapitasystems.com; dkim=pass header.d=rapitasystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rapitasystems.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXOZjzmVWumF8XzSMLEba2mUmzoC45eYcTCG8tO2sQ8=;
 b=HCnJrRxiYSXGBufe9ia0XFoj+MIoUntZtj6eIdQZ1TX5gw2fl+dp9XBLiE+J7O1cKSZjjGNFy2lVlACB25rMHw7/6o59jvrc0boIFAmNjx3j26JSeBDqHGC+QIoGzihsPA/KU/d/ZU5kgoDvh7XWNlZS3eg5cSwEcCWJfyUsSis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rapitasystems.com;
Received: from LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:19a::8)
 by CWXP123MB3365.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:7b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 17:22:35 +0000
Received: from LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM
 ([fe80::a33f:4559:b41e:cea9]) by LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM
 ([fe80::a33f:4559:b41e:cea9%4]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 17:22:35 +0000
From: Greg Manning <gmanning@rapitasystems.com>
To: qemu-devel@nongnu.org
Cc: luoyonggang@gmail.com, richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Greg Manning <gmanning@rapitasystems.com>
Subject: [PATCH v2 0/4] Enable plugin support for windows
Date: Thu,  2 Nov 2023 17:19:43 +0000
Message-ID: <20231102172053.17692-1-gmanning@rapitasystems.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0282.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::30) To LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:19a::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P123MB4352:EE_|CWXP123MB3365:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b151bd2-7f8b-47cb-8b5f-08dbdbc84dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4L1/RTdaPwxP1NCEQy3Jd4SAPjOohiCYXmy4iV1dR3WD1MzliAR6rB+0tGjDYkoOATQg3rI6p9AmG91unbJL8V7VOyOhARNOboKam+agMEuOvRO+s6YmB5n+dYnw98NRjxL9kFpcJIdr3W4i3xFZJWHZogBfcpYRDZs3hz+zv+NEfqRRMF+G+WLFkLIxgAcucA9sDDMRlF/gAFvWlHPQuly27YWLL/X0KR5tSsapg/9FqmNOLcuPy3DJV8hwd/auucps9TkdPd4jh2Eqp3152oHO1casVGN21+ZSIH9C/vT+7AkKPqqR3SLwU5tNjN/PSiiolFKmpEVSTZ+HYLKj379uNawJM/JE2pNbH/pxEdDQ7XkD25ngHAh1tRnF+xp1nqdkRtBYsGVKZ+s3no1++WmS7LI75EuAwPMYKS0ZOQjzDpq2i/3ktezVQYy1ed9WSD+3+UNH08x3mmNwS6IOzG8LiVECwlJmRC5Z+CX0qHWFOvaIPF8wRPtSUMqBqkPag1ggcBjUNeb543Dng3jfG0jbaltYYXXllauebLBhmaO1XSIW184d2jMazDXrFKYJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39840400004)(346002)(366004)(136003)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(66556008)(54906003)(6916009)(66476007)(66946007)(316002)(6506007)(478600001)(1076003)(6666004)(107886003)(2616005)(4326008)(26005)(8936002)(83380400001)(8676002)(6486002)(6512007)(5660300002)(36756003)(4744005)(2906002)(38100700002)(41300700001)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BHtq1t9JvHSzqgD+o+tCjk5mi6pSwGE4H/Jim4MgJfuPRmKD3VvTLReJsc3D?=
 =?us-ascii?Q?HBrXvinfrLLG+1kPFXCCpcnBJVlKBcAjHXmpQG52+ob8FXncNEb1VpYC7GYN?=
 =?us-ascii?Q?2jqQXEk5FemDiadlekMFop7XWN6N4wsOdRL8y7KHnLeutdJ4va1GV73eG/P6?=
 =?us-ascii?Q?pAOIgz1hgmBaroD+S5yptgBx+9HGMzuljfH9t8Y+JjDzUQfPA43EyaFIwew2?=
 =?us-ascii?Q?3MQBUy5ZpjTXpcA7CyJnUn2AigX9eY9F3AmIoq6T/pY3WyrQGPOap8OF0Ot+?=
 =?us-ascii?Q?oqBRgTRnff8ZirLi5Lvl/p3tR+MlmvMsrcjLN/VQxeFj49/yXd5x7C5p6sgG?=
 =?us-ascii?Q?Nf0gFN3H+FHgVsk80JM8weT543VXfCPE50UWmq3T7502zzyH3s9273I4UjG4?=
 =?us-ascii?Q?6PXK2gvJMH/KcEX3K0jJ/0QZcBh+fkce7kNHb8nsfOJ7VDImf3eTADVNL6wf?=
 =?us-ascii?Q?DVV1yHy4UWj8GJPA3DgqT6och+EP14nUwGKeqrGULSppf/5TGQJVN79j0YE3?=
 =?us-ascii?Q?3HzikkvjNpfi6mnYLd/u49oG39pEacEmbaFR8tgi5clFwjAOAxNPnrRCXP9h?=
 =?us-ascii?Q?nwmhMXQ6IB60pddaqGtKmW5sAblr6T8spmDgbDmESlTvz70xlop/B8PR20wp?=
 =?us-ascii?Q?F6mmkOPcKRq7CPp2Y8hfqK8+5zBAqUfRAOe+Pn6/HVRN4sH38ooGBEFOQzd5?=
 =?us-ascii?Q?6e0w2PLDPozd5ucUgn2f0DrsemHZQDgVVzr5Vusos7bJRxi1EvyoMhqAPCvG?=
 =?us-ascii?Q?aCt/ND104rci1wBPogFJGm0xyXH4iV3YhNYUgz31bJl6BxouWv4wy7PHknXs?=
 =?us-ascii?Q?1NV6fB3qVeVzNVyHcepr8QXevW2pJQdAeMJ50dbizYxKxBepBYYC+nmKVj9T?=
 =?us-ascii?Q?KToC0b15OcUSIETumvldA0aYHsa26aivoqo202yYHj2eaQVkb768xliJsElw?=
 =?us-ascii?Q?RLdQ3ivdZ4nkyEf4dIaHlQ240m1cN3giTPQ7Dpl1F8a9rI8CeCEZ32bOd+qM?=
 =?us-ascii?Q?gzFo8ZgHNJ3v3iw+DS3haQ9Ooo2xatgh1pLh2DrJV2EGP7xeqcynHI6dxnFe?=
 =?us-ascii?Q?+Klgzf+fjn/ylsMQYlTdEvdECAh1TIOYXeokr6qMyHfpBZ++OG51ZNdlmjlT?=
 =?us-ascii?Q?RdyaNyaGNBBOF6zK85HJjOoP0B8zor81EcKf4gkx7b8pZrv1w475z5HSdmIt?=
 =?us-ascii?Q?tsZnQ0h86UjZOfH/wBeEXgry2LfqvIEhCTv9TjmMtXISEaJsgl9izLSNtPEF?=
 =?us-ascii?Q?daMOsPfcijw29RojWWtc2pz4Ctuixsgk/LJMjfieMxmH+ISoOR7KHX7KoGwP?=
 =?us-ascii?Q?HDx5n1itpeFbsOiEd54weo4VIx4nyGneGsdsi/3iE8I9JszHYCrbMs5/K/N9?=
 =?us-ascii?Q?ad2K1HZtpLt8j8iSwsXNzyfo8NqoymC9f1cO+rOy/ohic46huuSsSwq+BYyK?=
 =?us-ascii?Q?F1nCa2E9Ly3GkRgqPZ1+mTEZNTbU7l0m0bLg+woYP+t4OAPVoT5Ng1xmdiK5?=
 =?us-ascii?Q?cC+lC/LBfpSE3of7//ERjOto1NbXAN4TObgRoswDNMqdB6ivZ4vF/ji4g3LS?=
 =?us-ascii?Q?IvSEOQEUdQouG0w81cOxz4zkRbs0meijG86dxec1jnsYr3KtbG/ucqRGnmZ9?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: rapitasystems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b151bd2-7f8b-47cb-8b5f-08dbdbc84dcd
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 17:22:35.0029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 63a1ab10-c4bd-4b99-881c-0040cec74971
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qv80jn6IOzPHwjmsfpnU3A98Bs8PM69f8IdMUHbivaZ1E3KtVdRLtR4CGE78PFincaKCBQyyv9B/VN4rA1/RKF/C5PLr/Gu0L48omer013c=
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

V1-2:
  * Break up commit into separate commits
  * tidy up contrib/plugins/Makefile so the "if windows" and "if macos"
    conditions are symmetric.

Greg Manning (4):
  plugins: add dllexport and dllimport to api funcs
  plugins: make test/example plugins work on windows
  plugins: disable lockstep plugin on windows
  plugins: allow plugins to be enabled on windows

 configure                      |  9 ++----
 contrib/plugins/Makefile       | 26 +++++++++++++++---
 contrib/plugins/win32_linker.c | 34 +++++++++++++++++++++++
 include/qemu/qemu-plugin.h     | 50 ++++++++++++++++++++++++++++++++--
 meson.build                    |  5 ++++
 plugins/meson.build            | 17 ++++++++++++
 tests/plugin/meson.build       | 14 ++++++++--
 7 files changed, 139 insertions(+), 16 deletions(-)
 create mode 100644 contrib/plugins/win32_linker.c

-- 
2.42.0


