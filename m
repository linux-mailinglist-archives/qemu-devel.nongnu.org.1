Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C68497B4E72
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 11:00:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnEl0-0001kJ-Rz; Mon, 02 Oct 2023 04:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkj-0001SV-Bw; Mon, 02 Oct 2023 04:58:09 -0400
Received: from mail-db8eur05on2071c.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::71c]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkh-0003RK-LL; Mon, 02 Oct 2023 04:58:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlAoYetD5NS8ZYQ5rFXcXxOQ2z84h3HtTef/K7/ZR91WbVmKG3lv4KaLQ8y0h1MzX8F/hogzJwDSz5qHJy9e23VYtLl1kcU5xWd4iNd9HFk8JfMx7I2bI5xq5Pn8EfiFWKAyAgpUM/dDAoF7DK2QXI2bedSudgZz4ppPe46UVE5kJTwiAnCAfh9x6QoB3WF4tCUPolzocls7uz3jl7wqeXsVEG0rxrMaXu8snyc9vrsuycS8TbX5DWn41JFjrTyRk1shnJ5mZ4YQVrB5WI7kizta5BOehtLm7XBxaEz2zmtflcmBrXHNbRq7P5MRLZoPwIlqLUfhcBsMfSui/DUwUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCqR52SWiqwGpqA01eoe8qm0htMF5yvZG+o1fGTYxNQ=;
 b=NBn5kvlQTqcqiA3s+BG2SHfLNjjYFXxL7BY0+jsDVZAhhRJ3gYnI3Vc448u12XWuPcQzx9PHh9VrsfMZu9QtRqZAhRPqWaSdYGRkgyUljiXhtogBrVzj1tFWcoz+Bgct7ICJ4B2fw89buPT6NglrTrpavWwRv79RykHskv3WNg7+p0QJI8FUkbVMm59mmlPVQKk58BqZAi5fLutHnYk9T5eYEifwnmez9a/gtcMflzrf6D4HDxDR6Q30c4GLH62Tka/+OHiKrj9VpoMEerktKaEBaTicCUzD1LKZnTyfCnG2aCVpQW8Sdyhmk/J7RiGf0yV22/8L9Gx6ktbVlt9pWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCqR52SWiqwGpqA01eoe8qm0htMF5yvZG+o1fGTYxNQ=;
 b=jE3wWEHT8WzECSXGYSk3p3uW8qhXcyVVPmnMYMouHVTXWrlsx2WsvulMc+1cMNzdMwfO76CgfZ4qyyEjJXAWhaZ7Bz1kLGZkFYuKCTC0Hh7r3TqCs+iI/9+IdHtF8pAuOn4WKxuPzheNI8LtPK99lEUFZcODGtV85pFOUfbMj4tTRGfJj4J+MUiCVtEH3vY9vjdir1NrT0X/FhM9sX0iTYRxmDfSXjfxa0V7jajUwImfq3kYdv0qKy690BnNPeCKW03XcJCR+EYznpoh+eBSWlrGz+1VRsMnSnMItYiPW20cZVw3vTJMTeGRgonAYlKDoo6YR+KJKE0y0CexegyzzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by AS8PR08MB8273.eurprd08.prod.outlook.com (2603:10a6:20b:537::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 2 Oct
 2023 08:57:54 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77%5]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 08:57:54 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 06/19] parallels: Add a note about used bitmap in
 parallels_check_duplicate()
Date: Mon,  2 Oct 2023 10:57:25 +0200
Message-Id: <20231002085738.369684-7-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002085738.369684-1-alexander.ivanov@virtuozzo.com>
References: <20231002085738.369684-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::45) To HE1PR0801MB1931.eurprd08.prod.outlook.com
 (2603:10a6:3:4b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|AS8PR08MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b60ae4-4871-4a0b-60be-08dbc325a916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M8wXoSnWp0Pkt9KIiyVBpgPoeZgKdNI/23tpg+gHH0/VHx3lc7cIG07R/2JQ265N00UK01puo+9xyma7KVvnzun/NKY1jIRC8j0QBqdheN3Fi1q6A6ZQ7jtBSesGNM8cSPy/VatfXHZ/Zf7BSun+2WT3hw636WYZ0dJ1Df6Xk5p3y5A0S6BkSGxdctPtl9Jdc8qsYMqYqh/mOO0iy8JpOuGKTvZpqBGBTPxI5h/zmQPC1JpburHrougXQInETyMxkrZkaYvKzXJbhAnu2FrRtGeYJjONfreLFM7vRYsFqE1Tzkz/edtzgv7ScSghoxhmSoYRdesoBfsmiPe1LmvwWBggB0PdpO4ntWUOaX5PuiD9kKteRm29rDlY0yVkw8/IGnCv0kpA4bzXvMWwNYWvrzxxS87PS/JmScb8veXb1yIMKJI+rO+n+jIdp69Iznh3h/a7zdSNhkB+r9GfWcOTh59CaOV0QhrZyxCpx+LbKgrZ3paviKluSI0um3WtjUIkWCbxP/MKnUSv1pOQH0p4F+vUyOmNu3l0rZdqrO8rYgSpSs0ONG7jxyi+BQnvG+vCghMwWHRVuRgkiPOXvrkQ4J8sWc5VG6X4Ucji/fZX2sqsUVyBeam+jWBQvci2AU7Y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(39840400004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(478600001)(1076003)(38100700002)(2616005)(26005)(6506007)(52116002)(6486002)(6512007)(38350700002)(86362001)(83380400001)(36756003)(6666004)(316002)(8936002)(4326008)(8676002)(6916009)(41300700001)(66476007)(66556008)(66946007)(44832011)(2906002)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n5+U680CNLw+CCGKc3bgzK5Q9/9ULRY/4FYBTKRUJGvCp08wqyuVPGf0L+un?=
 =?us-ascii?Q?pFK9VxgR8ngnbCp7m8yaywDsgxu09Bc5uTxILVCRQpW1PaulS8Z5ESlVCymT?=
 =?us-ascii?Q?2Cle+H6kHG8XUadp2eNxubgN58DZnvWSD2mLi/7D6tzascH9ByJ28iC2mgYI?=
 =?us-ascii?Q?fAWicuoAF9PhHhQ/R+H39CQUT6GkpDpi8DDMg9qBkNp/HAy8TDZN1HCbaq4P?=
 =?us-ascii?Q?1fI13FBUGxxGeaNtPZ9Z+k+s8DDVKjqYuLmVIcwZ5AzKu16sPwS721yEyJf9?=
 =?us-ascii?Q?JrMsi4Yw4jUgUsOQsGAStc81ZrApglbNa1YXQzrjVSrIr6gIlSouBPtWPXFs?=
 =?us-ascii?Q?jeNFr0HxeWw0tNKZzmjz8e5mFX4Xh+DwAuXoiXoSRtCailAT78E/8QomzMsN?=
 =?us-ascii?Q?H38TG6AcZjNjxzjRJexLbdKoFnQMip9Cy9B860nQ0P7ZSeUXF4VuVirpZwl5?=
 =?us-ascii?Q?Df8DQyVjtwLCuE7cP0q+1Tc3CEERD/1c6pZchto3ZMkmcgl0UPrYQL9VVY6r?=
 =?us-ascii?Q?jpByOpPIc9+5RRFpyWskJXUOed+Jo8nO+D5Jb6GWZkXsRSaTceVSH1dWPWCo?=
 =?us-ascii?Q?SzOQ3M+ayDNHMKU6Fe6j3Z24GJgF7ZCnPTIre/9w5MI80jwo3wHVn+WrOsnU?=
 =?us-ascii?Q?4qqQlyzcamTDKoYcaRQ7TwxWefBhfGxtuQFyMCbXoBg3iwHnNu21QzpVU76n?=
 =?us-ascii?Q?ytgds+bTUDV5EP9tNMq3DLXG9lcSJ+UEZvYSY/yZ1tf6yT+IphTzJdKV6Rul?=
 =?us-ascii?Q?KRmRf/+L/oUmdgnN2R8B2xSsRu5AEbcQ+8ifVj/O5+1HxMm1MHBjO3bgxzNx?=
 =?us-ascii?Q?tlkdfajz9oDZCZ+USPlXWTpd//WWm4V0jlDLazta1cXXEPI04w5wOEQMqof7?=
 =?us-ascii?Q?CULHQ/FCo1ArLrrSjpcLkIO28cQj3nyf+emeidknfvg+bomDzOG2XufNA3CE?=
 =?us-ascii?Q?/9L2Ndz+1Y7uVM/U00pIAGf1owbum908uNCUL+xUD0I7ktkE1GQ/0RYzJDC3?=
 =?us-ascii?Q?zLWLU+Mix8WY4FAJzP5TpUgUPYzBX7E3rgFJjZIvsfIFA3/P+cGfWKI7pAJ+?=
 =?us-ascii?Q?nbNqbT0bx3BwSTyn7nxcmuKvKAKmS5rg5dZ2axChk9Viaxkg89WAdZ3vYDqd?=
 =?us-ascii?Q?9zEBvezwZQn8oYNdS2QuIkOSMm4zJX7lWQGhYYA8Ovm7x/ZKCsrJUQu+EY2S?=
 =?us-ascii?Q?PliMjRnRRBnMN3X+T6AgMnMuz+CCstpQnwLTARoUPF7Ivahboq2HMAgbWsTF?=
 =?us-ascii?Q?c37B7FwG+zNtLnWHWWchz7RPebrMqAdUtaQfCmnBjhMJaBygoJQ0ftsOfbTN?=
 =?us-ascii?Q?pfFLsWKLArzgURRN6r7dQZiAKOENlGs7qp0ckSwWgo6Hsb0+LLhhuLctettc?=
 =?us-ascii?Q?FCVf9kJk2yvIzqhJtc5Zwk1sDyon86DmAGtNH5BvBcpzPK0Po8CZGinF5A62?=
 =?us-ascii?Q?1V4FugBbPn3QyOPrNkD3zm1bL/k2+DJ+/R6yaWa74EYaLkXrKTFmKVP3fR13?=
 =?us-ascii?Q?4JHYlx752Qotttu5DwTLN0w2bPqpSvZkqgkRDa2X8kf2gy31OAcKNRggvwEk?=
 =?us-ascii?Q?PiuZN8IkuaDS7E0Vy897aw31DnZrpdkcXmBr8cI212Hbjs7hQRklWkycqai7?=
 =?us-ascii?Q?Nxn+V58AydH4oPWdH238PPc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b60ae4-4871-4a0b-60be-08dbc325a916
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 08:57:52.2951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bsjeoYMPYa882M69uGzpiIHYTzWL5aajXJEbKyb9p7/AsNb+BXDPkqNAnIDcUCLDdJH3H36/Ti5HEsWWfm0WrkelzV0/xxUiYINPutDb8iE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8273
Received-SPF: pass client-ip=2a01:111:f400:7e1a::71c;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

In parallels_check_duplicate() We use a bitmap for duplication detection.
This bitmap is not related to used_bmap field in BDRVParallelsState. Add
a comment about it to avoid confusion.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/parallels.c b/block/parallels.c
index 1a4f8d1eb2..b735ba8390 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -834,7 +834,10 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
     bool fixed = false;
 
     /*
-     * Create a bitmap of used clusters.
+     * Create a bitmap of used clusters. Please note that this bitmap is not
+     * related to used_bmap field in BDRVParallelsState and is created only for
+     * local usage.
+     *
      * If a bit is set, there is a BAT entry pointing to this cluster.
      * Loop through the BAT entries, check bits relevant to an entry offset.
      * If bit is set, this entry is duplicated. Otherwise set the bit.
-- 
2.34.1


