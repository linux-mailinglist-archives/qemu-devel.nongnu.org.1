Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CF47FEC98
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 11:12:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8e13-0006gc-1m; Thu, 30 Nov 2023 05:11:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1r8e0u-0006fe-QO; Thu, 30 Nov 2023 05:11:21 -0500
Received: from mail-he1eur01on0702.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::702]
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1r8e0s-0000UE-Fy; Thu, 30 Nov 2023 05:11:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibFrHK7WyaevSR1rDgWINAm8N7eAlBpRj11Z6dTUB6cElNUKsQXhn9W5cP0hm9rfS10Li1siWqDAvG7mXfAEPL7ZS53vYBjMCtP7tU7PgNkvYV8ZOV8POqFCslY9Y7EuJXqdNWFsTQM2E5D939d4NI2DykveNVT6AIuQuHX6HhBrh8sEFg+jhwkmCl4dzSZZNHxXBSYlW/KXOuWFezqHe32ZR7Yw/0X16rnxTz+CiEwIhgRwT4kHepFpKYSARF8N5vQ+prHj5SaFDMK64p4bLkU1HNbuIFCY6nhXoatXevEmHzVktJ/vZw37YDES4Aop/mnf5ythgIBnOhTuNNBufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qU/mR0+m5E0jvoAvzII0CzxwG92mzc9v8CFJv8waXog=;
 b=MpnGTvNeuHfN9cxy4Dq4K+ZUmY8nXN4Hw+EwY+NqawfhhxZO2cry+cqrTDzM9+PYm8HPP+rTdOs8bzajA9yfQHUBI3Eb78fUW7XveRAfHBZlvOAe7AI9tchSU/vyETYuuwcivyZfZLrEcY2usjuY0yfR44StDLqcbNOkPirMqQPerGPxIl3EUZ40Os5LK6ST4LNSC34znXdmIl1Gacohu335tVutKpyDNus33b8yhI9N6dXXxzTv72d1TSp/1+gX9+07nppeaYRo8cEdI+PYj6XdeoX9V9jWQf1DZfhqrGq/i+lsM2D7apMA8I4huq6B+ocTPSBSVRppR8ouSHqc6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qU/mR0+m5E0jvoAvzII0CzxwG92mzc9v8CFJv8waXog=;
 b=KrWRFtcWnTwyEpaizbE5M+JTNQ1MV9qggq2ux/YGG6VMViZLAj7K/Z9HCZpoaLNX/WPOrMwBCml0NfChP0v+aU7ICK6TBvvpj6s2bqs5ba/xfjmWC/Xt65OfAD7aAjbHQy/7gf/LYh63IeccT2v9/xDrvxyW5XZHsquCILiitIVn+lDqP7cFAzZXXSA+jlfJwSRx8mh9cl4ZlLe8gMTjEJ2ImaZzP7LpG0zx3OIfVrkLfbn8elaCXbFxwGqEmXelPWH+z+dUAzF/AmlaKX71MYxV3plzK/E3tI9bh9rtPJy0AzZ4xZ4yLC2KOh8rKkvokQegQ7oiu/Dy5VwUr3yAFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB5PR08MB10045.eurprd08.prod.outlook.com
 (2603:10a6:10:48c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 10:11:12 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 10:11:12 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 jsnow@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
Subject: [PATCH] blockcommit: Reopen base image as RO after abort
Date: Thu, 30 Nov 2023 11:11:04 +0100
Message-Id: <20231130101104.127356-1-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::14) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|DB5PR08MB10045:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f0b3505-7b58-41f5-d2b7-08dbf18cadee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L0Zi8IruCu8q9Wg5gJymxpTNZAjX1CH+iYFermPbkBNNzf6dsj3nT+93PVqE45Ar/rKd5SlICE4HIISQklYtPnNwsQALC45Ok++MxcWyjYEkIcff4QZ5HfcMZxXyuPY7Hv3qlGvxyHbgw9kZiLMyTL27s1DmlGGfsNplFCOU2qUkQ1phOgg63GCWJMN7eJkGT9LczveNwrAaBZfpGWFKVFtDfQMJdnPSuP7BVOV5liiliSQqQS26stl6NBdx2gAXlSwJIv/GYMpb/t7QVv30bPxHRqhGjPObh0kivPC37epebJ8ahOO3ZTqA8eDWXyiSWPZY+qMgJtRVcwu8yw/XtRxKtKZGv5Kt7+uHVeru9TGptET2Hv5fXH6wlL9uVG49L8P5MFKLUKrlsVuHrA2R6jZB9CI4bZiBecN8k4J97LL86ZCqoQMPukZxz9K4Ttp+UsxnqtdL67GjEIbLM9tjxYu9AONkhgNOJ7DJK3/7gDGbn+VtHyQrYQO9uyDibGn1aDom07gKEy2EQ8HHy0TNVrHxm/WGD8FkEOC1tIAbvgvdau7mj/N2c2bf39agttEJ8Gx+i27osxUvZFfqvyGfheXw86YN7uZNk3XgqRl6dv2tQcObflZUl7MHTt9WnEPkiercDOJMOrRWXpcMsglCyfOdBgLmOH7OA6Ndj/gE4Io=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(346002)(396003)(39840400004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(202311291699003)(1076003)(38350700005)(86362001)(5660300002)(2906002)(26005)(52116002)(83380400001)(6666004)(6512007)(38100700002)(2616005)(6506007)(8676002)(36756003)(316002)(478600001)(41300700001)(44832011)(6486002)(66476007)(66946007)(66556008)(6916009)(4326008)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+oN3hsx7ei5TiTKc7RffTtpTZEnW41pAgmtXkdeFNtB1myBlkQWmoxobSiJL?=
 =?us-ascii?Q?4Xcqk7aglTU9CMheCq1px7qCbnYA9xO/EoCMTjVCi3roGdwBCBaG+mGBeeOT?=
 =?us-ascii?Q?+HGwzscIYI1vIh+euOOypSfHGw0roaC5YaQ09FHX7bRBkchbBeM8tB3oZZDi?=
 =?us-ascii?Q?hG4ROh3GQZFcW8sK3Ap2f5HjLFpSIMm6wv6gdbFFfqjNsx1X9GhF3nS3z/2k?=
 =?us-ascii?Q?gmNQpB4ns3vdxuqJbsJpGAxQe/tHQuauAlEAF+h5Qo5+EHzPzeVuP5OP83AU?=
 =?us-ascii?Q?5zyoXT25ZTeMf83CKheGOWiyMgqgoM+YeHVT0ZqzuDdYxJ+jok4n/PWmZRMw?=
 =?us-ascii?Q?H6XhYb0BZbqbn7UdIlcc1HqiBE0yJqwzBtLskhhdpCVbi4RJ9j78uG1bVJ47?=
 =?us-ascii?Q?KachgIpOgmJE2auqQp5M8Xt2GxU8Itlcq3SkIScZ4aJF12ffNYTYWE/oy3Hl?=
 =?us-ascii?Q?wjnH+GOKXnwL6bhtSMX9izR2xXpK7n8hHYfKfMU+ojaaAmDhoCsjIELk6Jyd?=
 =?us-ascii?Q?aQDGoaJauKqJOQgkIBo2gXaNiig7Jq2oxfpPJYXjvlbwldXUCANRo8NqhgNh?=
 =?us-ascii?Q?FiyW/Fy2no0/mD9ldIjNOtO7tYtcUsPRPX1cRGJtYWfbHWGOBKZqnbR/Cy46?=
 =?us-ascii?Q?6yI/trWv6VO6b7IaR/qe8TfQRxaQZNqu3R0qnRV6RvqkY5mTEbqtXBQiEqT1?=
 =?us-ascii?Q?W70fM2RGHKQ29vBGohKMVxl2goGry3VqqQmku9whA7Gi/PXzrr8ye40+ts70?=
 =?us-ascii?Q?bZ6Awqk2bL9RVey9KyZQw4zXhjVTH8uDdDN+hyGmYqngztusBhCCtyC7AAkB?=
 =?us-ascii?Q?3RCPkYm6Q++BXss4caGusRYCLNGW8ZR60bNPIdk6hMUdIoNTGOc5oMRMm5QE?=
 =?us-ascii?Q?tjBbbN2UQMmOFYmwoN3NAHuF/6rjJ7k9pMXdQmxzxTM6gaCOROOmfZTc0Hc6?=
 =?us-ascii?Q?/l5z8FNh/AKy0ta5wi2ZC3ecSvrgUUPJnUuElziFk71q5UjGY6vGDGoUnfI/?=
 =?us-ascii?Q?j/FWr2D33VxPqGtgPH6Wak4CwrJ4sKiyljJb5Lho/MrHz7UyL9bIG+ezVX0M?=
 =?us-ascii?Q?F2XAVGy60K0bQlfI+QcJPguK4BQXhtYdt0Z6pFlESl7NbSbZxCE1mtT5FDGl?=
 =?us-ascii?Q?CK93qkoh83GRk6VaWaGG6vyzbqcfZuGv8pV93VB2pxO8XSudbnY20ie5Fa0L?=
 =?us-ascii?Q?HCEfquwF/eEVdcKV+mfMU9qdanB1zb5Ibv4QB1CW7nL82rMl1YzHjLqSov5d?=
 =?us-ascii?Q?S/QnfEN53+6VlNQuoLQFkwhWssYpYXW8iHs3ZVewEUWweFkQm6GsHxO61LKr?=
 =?us-ascii?Q?T2yw4YuNDZI5wbMRjcgiMMis07668eUHz+WoWOS4yKvZkccz5DnIGHGE5oMk?=
 =?us-ascii?Q?cUZoprFicy8I+fxvLImYS2ktFJAXcYwZVnXZ8LqkcvkW/3J29PozgiQW70nY?=
 =?us-ascii?Q?FTtST/xh8jv/1pYm6pQSbVFJhebiIYYiz7oQkHgXqCAe/73TRGrZV0j+CbPD?=
 =?us-ascii?Q?BP+GIjwHCza/Uv/I/O2pFZrMOf2pxLswLWbfaYhqqReqA7hyIqaR1TfyiWdm?=
 =?us-ascii?Q?AfaWUeNx+EYPOVWP9be+dH5qNnXa16zbMwfgTRqOYBvJWfrwKr85deLsEfdm?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0b3505-7b58-41f5-d2b7-08dbf18cadee
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 10:11:12.0879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6f4TFSY0g3nbqIntWQ/4Kb4BmauXy+EU/2gSeT0Nb0OdFxLAmEdT3WpTgc1jKQmWRbVCUmpPVkBk5otYyAeleJGTnL3AlffGoCFRHPZF7NA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10045
Received-SPF: pass client-ip=2a01:111:f400:fe1e::702;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
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

If a blockcommit is aborted the base image remains in RW mode, that leads
to a fail of subsequent live migration.

How to reproduce:
  $ virsh snapshot-create-as vm snp1 --disk-only

  *** write something to the disk ***

  $ virsh blockcommit vm vda --active --shallow && virsh blockjob vm vda --abort
  $ lsof /vzt/vm.qcow2
  COMMAND      PID USER   FD   TYPE DEVICE   SIZE/OFF NODE NAME
  qemu-syst 433203 root   45u   REG  253,0 1724776448  133 /vzt/vm.qcow2
  $ cat /proc/433203/fdinfo/45
  pos:    0
  flags:  02140002

Reopen the base image in RO mode in mirror_exit_common() if the blockjob
is aborted.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/mirror.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/mirror.c b/block/mirror.c
index dcd88de2e3..50a2825b1c 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -789,6 +789,10 @@ static int mirror_exit_common(Job *job)
     block_job_remove_all_bdrv(bjob);
     bdrv_replace_node(mirror_top_bs, mirror_top_bs->backing->bs, &error_abort);
 
+    if (abort && !bdrv_is_read_only(target_bs)) {
+        bdrv_reopen_set_read_only(target_bs, true, NULL);
+    }
+
     bs_opaque->job = NULL;
 
     bdrv_drained_end(src);
-- 
2.39.2


