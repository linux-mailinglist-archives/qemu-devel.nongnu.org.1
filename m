Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A4581F6C7
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 11:15:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rInNp-0005HP-M3; Thu, 28 Dec 2023 05:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNl-0005GK-Tc; Thu, 28 Dec 2023 05:12:53 -0500
Received: from mail-dbaeur03on20700.outbound.protection.outlook.com
 ([2a01:111:f403:260d::700]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNk-0000ek-6A; Thu, 28 Dec 2023 05:12:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0db5DOoX6jDoglVDWdykmCGVdbAMkZLUaXeTUEXywn5iL0e2vFU3i1s+8G2AreSoAGEP8I61IXHcCOoQzTGVIzFCVi4QTtSHH23Sbl7UOSCJBpcuNH1Wml7iHFEAux3RoKKOCrV1x7P49++jJ22Uwo7GghCuvka/59uhSspNfdgf120qhEckd5dcDgKt2R3sMH6Y5GnbcPA3RIQ8xhvLEL8SXuDPwKOBTXXuZCHwVLvCRFvc8QEJ49RJuwXUdy3qE0UYrvUkfOhO1vg7QPNN9asl1IjBrEjot+VGYaa8rCkKaj7yy+lalkqMORW4RJvq4BbfvK3CFkAdessMsw8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlLc3sGjbjLxYT0I28zHA5XYRyRf4UFwkyTz7Ixlqm4=;
 b=mwOqKrXYxcjbeWJNq95+g7kXFeBu9Wd1GtRUFS1FBt+VjGr9nt2mlihNB/j/t4lMGG52LBplUL5dKmynqZ/4kBT/F2O23c4npw6yovCLoVhlyFSn18wlNF25RC1OjO9IlmLjLzIe5wHHIevdJoKTfOkz1GToxpidAfT9bWVu5Wm43MWYBVNf1gaJDrUA8+mkVnqTNLkS0KYS55ArQMCIf12M0eOjFOAOeYzOXEIyRC8bKkwZImJHymM9214UiCKv8dETIcso5TxxNtOTWg0TDYaRxq/K44YaV5+wxLe938TM933YfDIEK3E/9pxF6vqDxj6Nx4RidAqXQTjKIkyWqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlLc3sGjbjLxYT0I28zHA5XYRyRf4UFwkyTz7Ixlqm4=;
 b=QmPubgX2uoSYkpcElpyCc/QQIbw9QoL42pSXvzJDPpP0A3p6xcX07k69bD/2h+qx33GhgqvBF14NcvwthIdzPrG3gTHYUOuP59X7nuqPuaduzeoPPiRqP4ga/pUsHXedswoqsfWQkrmezPoV22Z3991eDvIglqXFDynfEBJ5+ou8tWDzpaWr+Wk4iJo3SaQ83QmBPO1c11CMYjM6b2GtOz34t1b+BKFgeiRPL/8XkIzJ7R4aJiZBkZRaRR5uCZJ+Xry45ZGglcNSUXUN5Wez0N/TuSnz0WJdyzwjlXSCJT0qizjQWCCZWp+IBRopmbzbvev4TZQKr5HyH9CnpudgnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AS8PR08MB6134.eurprd08.prod.outlook.com
 (2603:10a6:20b:291::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 10:12:48 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 10:12:48 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v4 14/21] parallels: Make a loaded dirty bitmap persistent
Date: Thu, 28 Dec 2023 11:12:25 +0100
Message-Id: <20231228101232.372142-15-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::8) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AS8PR08MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f595bd-3d00-4108-db1c-08dc078d8aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vxss1E2wXOme2FKmbbmgoc0tmvqGThOGntHz2Z0Ll6wtEeiBK+vw9FHr6JWHy7aVaeQ0+b5JnAF+uQnCANcEfdaw7hFicj3UcciK3YYU0A1Ok3/AMc8Y95kecmzmWWQkpZwunkfuw5kDpYKoMUwATfcBzH5dP4D+96Yx2xWrxv6w/6ET0uO7DlEY7H+Blsp4iYeFaUeF6/YNhsefHAwDaYpuopElQsTTE4XIAVRYXYHnmyZW6dmRXg+P02cRSSAhj5Sklo+7YiVgGaQwH7oNUp32ZuE48U3NhB4+h2FFMn4jkecmHkqKon6jH3b1ne236OppmbLBlMlqoBex6/k0aFKC7uijU9vdJz6xWsJCkHS6IBzrnSJwQACmy97Ef1zEhGGlgXJqUZxRvnIsHWdVFtJeaMnKMf4/EvGo/1ODtTXR7UfMB+J1X8Sy2f/4MakrIvd392mKK6fems/cdfaXPMAqjzfWiNGiWqI55az6zmUuvCggEOsWKA52FXAEfP31ffPYtgr9C0/Z7VcEeMggjjK/E+k493cg/OXk2ABG/T5J4OyeHVn7Nv/apbHilPOBb2/JdDe9SaZfnMTBFcuwpBScR/GRr2OxJPTxQBUd53HG0FsmS04CqDRAnVzYjClK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39850400004)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(41300700001)(2616005)(26005)(1076003)(38100700002)(8936002)(8676002)(316002)(4326008)(5660300002)(4744005)(2906002)(44832011)(478600001)(6666004)(6506007)(6512007)(52116002)(6916009)(66476007)(66946007)(6486002)(66556008)(38350700005)(86362001)(36756003)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r0LSF+eqnq/dSBcXrXkV01YbrRraJmJhUAK45duc3ApX1ypXR6atPFeUaRns?=
 =?us-ascii?Q?r6i77unLVhLjbhOJMiRLRIQb1XZhfKGvUYfDyPCa8KM6LeaRgvTTg3OlrSZU?=
 =?us-ascii?Q?2hqMfDyrQspzRfyRepapSzt3qhGA+nmKKlSexIFK5uNcniiu8PAPVg7LDKap?=
 =?us-ascii?Q?DFwxxw5sAAK0/nyAzHAAeFA2nNjafxEirXLANNM4XRvQBDAdLLbcxY7c4nYW?=
 =?us-ascii?Q?HmZ7hh2ZuQokdlDZnYXkv4y4sRRPSRy/5ppRXJgoKZh0tFiOyGo5l9VkcRH2?=
 =?us-ascii?Q?bvXE8ZJqWbaf1iv3rQF3mMSRxIes5dkdrjg1pLq12fHaaYEGHA/SrghPgfiW?=
 =?us-ascii?Q?zqAUPby915hxVZxIw5gNvA+760pCNjlyetG1qKp+2OqKF2saf+3NKLB2/Nvf?=
 =?us-ascii?Q?X3LZgeHfL1jvNYGTkB78PmmrPOcegLi50fNRlHt6a1Y0Q7KjYXv4V+2paKb0?=
 =?us-ascii?Q?ohIx4LSAu1WGK0A2PYVgPokSYw8QRFZTal1DceT7sQ3P0i21dtPzCAHE3kRB?=
 =?us-ascii?Q?H3QpIW/1yJCD2vfwiofL0MmS2KlRcvdCS9eSPFdjpcyySTzKOEAtpi48b5tG?=
 =?us-ascii?Q?6HOJg9BO+c9/ywRveui7RShebsPSsSBpYlJ+ZU4vUiOlXUeKxSw9Atpa/YKe?=
 =?us-ascii?Q?wPNfaZK0YDbXRnPeSY3Qncm1lYyeyFzhkKssmu9ZTmfEjprOySsqw4hIdmNR?=
 =?us-ascii?Q?Fev0uiopvH31ZKP7STQtdJMjwDK1B5pJxaNJuuf3sGd8/A9zDFDzicR5hguG?=
 =?us-ascii?Q?zjTB1dQ6XyLzFnSC5uGX0vF19UVLM68m/0LMi9X3bKJxfZa8/yqmTIlN9dZa?=
 =?us-ascii?Q?QTdqp8QXGFog/MWJcv83ZyJWciy3eCqpY4PwGrO98Br7Ac+k/qQAIuNiNP4W?=
 =?us-ascii?Q?3LXAgjCasyp//mGnszs6Q0Au3MwlyzRFDV/gr4daFMKKpgyIQT/K+nynnRFH?=
 =?us-ascii?Q?VkpLi33pAvw3MU4nUR8L8wokCYvtkW4jgCMC9iMaH91JSfbty5kAPl7JqIUK?=
 =?us-ascii?Q?3Ly5WSIYul6pRK3OKjpWCCwsrpRj95mM3lqN053p/FhyM1a6MrnDkDubckss?=
 =?us-ascii?Q?8CG1gvLwDxRoUPgcfbq39CYlXNDnCC+9Dh0HHGIwkJAbKNKW5lxZ1XjO3XV9?=
 =?us-ascii?Q?IsJRo26Zsh8th/oWuxu9/5NSgml37uvP4l6Zr4kNUZ/PRxj8jIeD9HLGiNZ5?=
 =?us-ascii?Q?t8pi8iLw1apTs723hvwIRLyWC5JNClR2SpPtop+9fZmu45jJ4xwlgabzAC1z?=
 =?us-ascii?Q?d1CxasHfNjFjbJxWu27glPINjGItwunAEMjvi31a97S85WTEoWGXUoqoXdil?=
 =?us-ascii?Q?h5df8j4pkX5f0o2Y6GiP1ML9s9ue92Z7fs1BOXOa8qHDqJasztlCAT9o6NUg?=
 =?us-ascii?Q?2rfxRhg6YZm71m3YbbLQOX20LnHwrmmcImOnLvCeQrQQ4yzJ3DMDdJ3De2it?=
 =?us-ascii?Q?qiJt54/f96GFO4SPlN81iYoEunyZJN38U92sLfuF20Ot6SptOS+T3rR+HRtQ?=
 =?us-ascii?Q?h6FaWA0+pHn/AV0jat/8yh9hlDyA63UmrwCjPR/xJuxewldIs6vWM16tCdEl?=
 =?us-ascii?Q?F0bg4AuTf0g4a9aZ3X661J7Xri1TvHLQjdA8iLMtQsCW1lx6cvLowbfYvoVK?=
 =?us-ascii?Q?WGnEQSQJdUpgxcsCz0h8dIE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f595bd-3d00-4108-db1c-08dc078d8aaa
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 10:12:47.9743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5bu99vr//52l5y16n2Aj+lTi7+wH815fn/SxljfehdF1QVTCq8W+y7xrI/cEHWUXxNDv21QyXPbftvIG4dIKzRw1wYo2ty/T97NGQLcGcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6134
Received-SPF: pass client-ip=2a01:111:f403:260d::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

After bitmap loading the bitmap is not persistent and is removed on image
saving. Set bitmap persistence to true.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels-ext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 033ca3ec3a..2a7ff6e35b 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -255,6 +255,7 @@ parallels_parse_format_extension(BlockDriverState *bs, uint8_t *ext_cluster,
             if (!bitmap) {
                 goto fail;
             }
+            bdrv_dirty_bitmap_set_persistence(bitmap, true);
             bitmaps = g_slist_append(bitmaps, bitmap);
             break;
 
-- 
2.40.1


