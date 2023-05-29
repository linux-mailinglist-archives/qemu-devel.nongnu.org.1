Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD252714CCD
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 17:17:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3eak-00047h-Jw; Mon, 29 May 2023 11:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1q3eae-00045n-4U; Mon, 29 May 2023 11:15:20 -0400
Received: from mail-dbaeur03on20705.outbound.protection.outlook.com
 ([2a01:111:f400:fe1a::705]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1q3eab-0003O3-Ph; Mon, 29 May 2023 11:15:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVN5Tq++d0e+ED4oOKciiwRF0fHQ/DfMvM6NTeSF2ztPFJgU6nIbmyhGFE1JsU3uA72Htv3dzlbHJG4ULlu0YdgTK70hGE8cD0PD1Fzl99ncIFIBBBtwtr/uBySsncIcSuIFK8Rrc1d7+0dklGkQ0u7V6iR5LptmO24G800Ntx5eRj8OvOZYMnfugYhSerWc07a9+WCMUy7adptGXKihT2JFLI3WL/ZxuUn2vhVXcxfIh9Ewr/9Fs4YLUjTWyzPImeK1BVXMdh8UGYLFHJm+vjg0uoIbFPVsOJ9hrVmYCJSVbZLLjQiDI3CvSRzwUSLX8xu7OWzTIEfUwaj4TeboCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xa3W4ks4KaGBCSg2VtHmedHKw46guDrD61CPjub+TOw=;
 b=fpq/qQGR+cVeZbRhNI6eUaSXqTe2scR+x3qTp3sVvR2+cN+AldUeLVwRSzJ0RdbjvXfKgeRgckm6XO67tQMUSuV3sw8UxlrI5qnEtrXbEwgNODJ9vSDUL/fJIMbr1s1KpYkKkRwyrE+TxHd0kCoD9IY5vrYDJSvFzdz4rLyu/583DGs7Wri9SBYODXmNsaFOKfNH1atVgY6QqC/cXvVk4SgbJYxNp6JIzoP68aEAVXnF245ONLAK0eDQhPbg1KNhVW5LkgeMF+RkVbqyPvyadzEH8/rjxpCy+9FMd4hYdEXi/1ICiYd1pvafLEvqpUj2qj25XaUiNqroC2CF0MToxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xa3W4ks4KaGBCSg2VtHmedHKw46guDrD61CPjub+TOw=;
 b=h0buOcb2jDFDhDXynOduiS8iOePmP99VKCB7roj2AqdPgAadZ7e3tuIOBtATXPdAkM2n/djNZzmoF4ORwFIzSoo1drwEYLJOwQknL+YtyW7J+ehu5LWRAPQGX03UUAO2c/REaWRTpGXRFBXrLdwfWTVTU4MkIlGfKche1zTXjFZRmE6PWopmYWcvbQwjE0vpadJV3tFAyqIEnK0GgItSVdkv8gGrhq2H/RrhWmIt2Qg7p4VUJTMuCxfdsGNDERYu/0pxUsaHPrj9Whg8d58Hscb6OU5F1T2aqkzJ44dk/euh51tdyhoGb3vlnvQIovb5yJjEggPjcW5cirCtJTtYag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by PAXPR08MB6382.eurprd08.prod.outlook.com (2603:10a6:102:15b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Mon, 29 May
 2023 15:15:11 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::b630:c4eb:fba3:1158]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::b630:c4eb:fba3:1158%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 15:15:11 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 1/5] parallels: Incorrect data end calculation in
 parallels_open()
Date: Mon, 29 May 2023 17:14:59 +0200
Message-Id: <20230529151503.34006-2-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529151503.34006-1-alexander.ivanov@virtuozzo.com>
References: <20230529151503.34006-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0041.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::8) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|PAXPR08MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4425c0-74ec-4635-f8e9-08db60577f07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /i2xs43eL+l6B9H7lwUFeaYM0gQ0nrIehTaupL7PYqK0Xc/P2BWr85HYo8foy9TNZSugdvNXifF/JSQbej7sb7AJOp7kq5sKRW+YaAmF4wSjoQuyrzs56lAEKJqIwyUM3nUEpU5DxaFe3UyNSFtHC6a5Q6FR5norkHZZrcofxWvZ773IkrJB/AI59tcRdkPENb8Re/Y+RU9oHoSOVXq2nsGcA693KYVMUWx/aFkNNG6Jm8/LvofD3S6w+YLCPZXFaiRapTeeZo3Y6V4a7aTkhJj4DMY7wzhahByTDBTIP0qUbNhx6kgYmIU0t0ny6evaeb7xsgyjR2gB4ortwwWArQT8byeuBzYuIIdO5xG7yI8XlDRQFHxjj1iLV+N4W0u68Ah5RP6p+B63qNOPDHiMFXhG4+Q/rxENisuIUmuE99F7/dmVcrmp7wHjkVShWM8lfz1fQJtBhg4xLOlHqdnIvPmKssEDKGTwJOTe6wIJJgt8zCMAbwbsYIeN264vI9/S2dLeXzQYAB33jv3qDpmo6y1J/b+5+/z6oIV8OhGYeHNzCsjW1YQ4aMj3+smgwZ5V7VkN7CuqP8t9jE+1gZ9K6cjmmTgGqbM1v642TmoSJ2lYOTx+uNRfv9mduVoBB7XG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39850400004)(366004)(396003)(346002)(376002)(451199021)(6666004)(52116002)(6486002)(2616005)(83380400001)(6506007)(6512007)(36756003)(38350700002)(38100700002)(86362001)(1076003)(186003)(26005)(2906002)(4326008)(316002)(66556008)(66476007)(66946007)(6916009)(8936002)(8676002)(44832011)(5660300002)(41300700001)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bLk1oCO30qJeDqbmiDCP2K38euVQWxvHh8CeIXWjJxDeOW6KUME9r6/wNb6B?=
 =?us-ascii?Q?aVK7SKhvOAU/41ROEBFxn0Hc9Zu8F//wXbgOWBa/9nm8Fj5hODN8q0hrPy36?=
 =?us-ascii?Q?mnpzd3q8CWuvZmuco1c35oW9mgKwNsit4IR/njzhPomR2GKkasoWei3k1FtY?=
 =?us-ascii?Q?l/O+afnQYv3V3dkhiuz0oykUUNjRZPgKYXlA8wjI/vRDSCF0uS3prv1lx4hm?=
 =?us-ascii?Q?EqzPxCYLDEXvZ+QBchzay+IFBYJovyAaNxDnT8oC7X/2auSDBzg4qusB8LZ0?=
 =?us-ascii?Q?++qG4E3vowQ0QKA+MiJTlDZ8L3zvUhLa0sGIbnwn1SefQLupmT5ChoXGPpKD?=
 =?us-ascii?Q?zlMFhJ/Vl0VV8IQkNQJCIOy4NiBLGX3amwfNr/VRzloEKQ5ym4Em8nZ19WsG?=
 =?us-ascii?Q?XhGSEDVRx/YfRXp1f7+YphRDWeRINvYCGUnUsVQfjAU/ql+potGDawVDUUFU?=
 =?us-ascii?Q?KMlk7x1F0WiF3uKx9Dd+LEF2fKu8fChoCb2KeVJDtVTY6cWyEG8Em9dArGxY?=
 =?us-ascii?Q?ZPtl+VnzkO1ciulMcJ3VILre+SQKeC1yDbIxcwnIvAYzbJG4c84aao5jX0BX?=
 =?us-ascii?Q?py/kjCnzifbWKYZJZ9cSslKGerJKk1PyG3Oaxku00ii523AfSC/Q+acZBQHJ?=
 =?us-ascii?Q?EmO4KmmJM+JYH4f9/mv2ZnfU8DSMy72OwK0k94EzTFdZV/mIH65KovrhKSc6?=
 =?us-ascii?Q?D8rdv6LvKMDkpYmOiqvIaD4HHcFf6xBt37wx99p6wcFJkuTtzCPpy0zMl6Rf?=
 =?us-ascii?Q?oyUAOVJITiXvaZm2gpKdyUBgicJpp9tMrgmfoeRoNHqak+nGLTHrgfYMSWdt?=
 =?us-ascii?Q?lY21MUUdb96XaGgqUrh8H99ay41I+mpqfe0YIUDuSN3N+gErPRGgTi+4gfTG?=
 =?us-ascii?Q?XzL5K/q7MpP5VeFFFG/NMK6GvoMUO4PRxokeHvDHgRBvhfpoLVcl15adhIET?=
 =?us-ascii?Q?31b4SaX3M/gTQ1986ZkiTQgg6zasLeHt38HOkGUa3QgCMnINPWhouvKDzF6O?=
 =?us-ascii?Q?2EBhiWj0beoQ8j8cl3Oy9KZHwHg5sSA1amXvb/IQIruFcmYWbW9SsBKOJfOe?=
 =?us-ascii?Q?mXbSy14UkcJBeAmZ9Rw0UZv/ubYyIAAruXAn06eV9q12Uq2ZKVPHhuMoh9RZ?=
 =?us-ascii?Q?LMCczKeMH9TwDptOVlEhLeYO3TacNM9q6k5a3eVWswtVH+nVTK/3wob9hpvM?=
 =?us-ascii?Q?0lm0vHzaQt8WO9edI/5L5tTKiOudpWdDf4nEu+I3mBz4xr53+8fiXeNzXGCM?=
 =?us-ascii?Q?zCluVHYsdmMSPVCF8wXX9g+mIBuLCGx4TXmO6YnnIqopwaGRUpHNoZ70ukTX?=
 =?us-ascii?Q?KYk4guD9CoB5+vNVTDYAmNVyZuQPtklqk4HeGA8y3mZN7KxKbma3MZj9N9A6?=
 =?us-ascii?Q?U0bGEBI0bJL7IIWRXumgYgS21nl9KL7B8H0BicgEapn4IZS+Tj7xNFw4mMJ7?=
 =?us-ascii?Q?QPW71hmJaQuKok8y7AiZSklccURxyO5lEOjJv5fBgMoT7Djf6Z4nZom9s/+Q?=
 =?us-ascii?Q?TwN+DdMGHlZfWuCQiVk4U2AZ1ewHU1ufWTGLk45sC6tJF5q3J3vVbSa8LwT8?=
 =?us-ascii?Q?j5BzzkuFFEIhFO7Fhzj9qNuWRgfhhg1ahhuinVjw/P+UmW0eVNr6AhbbR6rZ?=
 =?us-ascii?Q?rqIZGFxHUGz9Zucy6w1WrvU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4425c0-74ec-4635-f8e9-08db60577f07
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 15:15:11.3955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4N6O1VKcxVHdKEvEjbLYhO7u/wvRe9CrrHh5Bu+5pePoPylajHf3qOPerjAX+rcDKjMCttmhDdoMPVDRnfh0qGPlYZUdtMBvHmPJ9mciZWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6382
Received-SPF: pass client-ip=2a01:111:f400:fe1a::705;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The BDRVParallelsState structure contains data_end field that is measured
in sectors. In parallels_open() initially this field is set by data_off
field from parallels image header.

According to the parallels format documentation, data_off field contains
an offset, in sectors, from the start of the file to the start of the
data area. For "WithoutFreeSpace" images: if data_off is zero, the offset
is calculated as the end of the BAT table plus some padding to ensure
sector size alignment.

The parallels_open() function has code for handling zero value in
data_off, but in the result data_end contains the offset in bytes.

Replace the alignment to sector size by division by sector size and fix
the comparision with s->header_size.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 7c263d5085..1ec98c722b 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -861,9 +861,9 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
     s->data_end = le32_to_cpu(ph.data_off);
     if (s->data_end == 0) {
-        s->data_end = ROUND_UP(bat_entry_off(s->bat_size), BDRV_SECTOR_SIZE);
+        s->data_end = DIV_ROUND_UP(size, BDRV_SECTOR_SIZE);
     }
-    if (s->data_end < s->header_size) {
+    if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
         /* there is not enough unused space to fit to block align between BAT
            and actual data. We can't avoid read-modify-write... */
         s->header_size = size;
-- 
2.34.1


