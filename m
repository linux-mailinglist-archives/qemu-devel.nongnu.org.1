Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A73F6737D3B
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:21:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBt4u-0000Kg-1U; Wed, 21 Jun 2023 04:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qBt4o-0000Gg-Rh; Wed, 21 Jun 2023 04:20:33 -0400
Received: from mail-he1eur04on0726.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::726]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qBt4n-0007B8-A0; Wed, 21 Jun 2023 04:20:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qck5+GWq0Zj2TJkGqTh0ACx3n0vAfs71tQuRfd19Q/vCmpszc/usDlsxn3v1GsmA5nIV+vK82toRRMGawns2KwxLft/WkK0qQ9wxXE+tPJQ6/R4ILuF9GK5zmI9i996A/ayA+Bjnc9CJuau4sRUPSiqKrfMxuhIDcvrXM6gV8HNhZzoGA8/J//Ef+b7uFUNWl/BpyRNLFQ/fVcVcj4zlOz8D5eClX/uSwD4UmY6IVWigZ44upuNXM014+zFwG6l02/O8ff9H2AAjM7U3YxD/LcA4U8pXan5FpPKGB+IaGrTqKL62gblp5tmO/7ayTEyKQAUsD4LvEezhf8C/exG0Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRJpf7twJJc5P6zwdiBJeQBXlzslnqjgsxls1aebyY8=;
 b=VeijWeEv9OmQU0xJQ7kSEi0Uzr+Hylvs63mbufhLOM6tC46/EkOH7yFN9sirr/GVp0HjGhnW792hjb/gR+EnWWbBPLTg8vCqVbH+JNsMt/ThfoZM+zK8wmQC3j8ED8+zmErMVxSTXJFGy8+qBKCz9IBhWt4w6r5IQ5lA3DXJazosSr/DXl2q4GhP/2aGyf+mcDBlqOdLdn3KN77yPVjq9lHXhXN1f7g4wkHmHPThou/55zR7826OL9mv99vrdmajVlTKTvbzPSgQKViyxvhvaajcMudGMBai0iFEMlJPrBUbzgrTGq+aF+XGBme5tOVjqiNaL5us7AfHuKIVHKnvvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRJpf7twJJc5P6zwdiBJeQBXlzslnqjgsxls1aebyY8=;
 b=SaC/3DilZ+AFWOt0FMIjD0mq9nI5ER3qi7ZXTCsgeZe0mWZNwNJCbjTZquQ13HQH8Wj1WlvJ4WGvJrt1V+puFJOsz3W2grVsXLgpc5+OZnmEtKUeGa9GkZlwLT+b2MgosmCYnYAIBOqcRSjNZXXGdFAU/gc/slqm/Yt/fnY6Q7RL8LBDsxdSOKrjd41pqgqBjTXFej5HkGHxTEcnVK/GQ8zZEroQoOM09GezV6YwPWsA2wJflTyiS2JndpIzcs1wsv45/BaLidZqKCrqsXIBqSPs33zdBpVhPyYawmWkIEkfZ0J5+lwe0UOiwJUQoSTZ8NV1zTaxBPSlCsQ38uIFHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 08:20:19 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 08:20:19 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v6 2/5] parallels: Check if data_end greater than the file size
Date: Wed, 21 Jun 2023 10:20:07 +0200
Message-Id: <20230621082010.139195-3-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621082010.139195-1-alexander.ivanov@virtuozzo.com>
References: <20230621082010.139195-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0165.eurprd08.prod.outlook.com
 (2603:10a6:800:d1::19) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|DU0PR08MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c9daf9-bba4-4a97-c670-08db723059d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W8lwa46DB6OaDNDZ7mlpmvZIuodmlSvTqK/8CkXHfouedh3qekvZV6oGQKOPd4pJjvGWxPsggWEumoFec8am38EFvY9bYSywZaL5h/MV4w+IMODqugjLvNiAm1Yg1aLANDf2C/onRShrBx9S48n+reGIrhgkK0/J/C1BEhD6n3Q6JrQqFyBzWJYNAYtxCJoxAYXEmnZDpKcqksxcAyrdyJYCHaqboKqqoZkJwcskJgJwNwBoOLc6pHRAX4Mb4ZYZzrIs7xMR4uz/wJFfCK7f+U9/5nOku62SzcglIs5uO8oqAUrbrkTPj52DWoBEZjUbi2yQpfeHnpXfQgHheTBzch5pyjB0Ojp/q+J1RmiZNJjY2NSWkhy7hmuWVn64AFZ5FG/4Dy1HJPZ2nUI1FWWk8RSs+afYEc18yKfrrFY9eCuC1DjevCu4pQ2xFE4N1PxWwR9zyis9cDHVPbHAEsK3qODc6oIupIbE3UdBl5bsn0YTECvqTHOH12qHq6Bg2E02aEhBpc10SOH89MRTTinyM28SI5QKHxzCAlEndTSC5wHfQ/pw3FNnQHO6gUMjhdxOkmZo9CxeD08B63GkGDufTPt6fP4JAwn3c98ud4dLcSFs8Nrt0wVSB4/mv/rPKkWo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(451199021)(66946007)(44832011)(5660300002)(86362001)(2616005)(8936002)(8676002)(1076003)(26005)(6666004)(186003)(6486002)(36756003)(6512007)(6506007)(52116002)(2906002)(478600001)(4744005)(83380400001)(38350700002)(4326008)(66556008)(316002)(6916009)(66476007)(38100700002)(41300700001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tqwHvFIuwfdKe1QwA3fkCRT3gw3YR/9Y8BcrOqbMtVCj5swdJKgYE469KY0L?=
 =?us-ascii?Q?e2xxx/Dc69f3XQ+jxhiA6ctg/jyT0uMTm47uSsxx2dTgrCPc9PMAQUac77+W?=
 =?us-ascii?Q?HjuZVfqL3k5vDE2RdDN9gMSLQX3uM4qpBEU08UKcxQD8yvpoVBX4ywv3QjIW?=
 =?us-ascii?Q?1mKxee4SJjomS5eIo15eq5Q5VbrlCc0W4/shkONDWEIzrfOQapCUlDqz6pKT?=
 =?us-ascii?Q?gW8ULji7rlqU843Ojoi6uJJny06tWsGEcZKv8ALfKhGfEAesKAd4cQgkwOKX?=
 =?us-ascii?Q?DwE+Fr/q5s/thFG/WYx9V/QocGO03Hx9bH9z4VGB+HbouTRoh0DOTcjOBwFK?=
 =?us-ascii?Q?0qS/Gg3imv4fs9WFaSw6HYG1tK8IIaaB3YBaTGPUapKtgeBF+CJsii3UUAo4?=
 =?us-ascii?Q?KVCRsw0xOKSREOsEDFjSsPRYRj32kqSVERKufFMgKgbMGsnOBqu1eN2rG1X+?=
 =?us-ascii?Q?hXB+XYaWdXwIF0QxqT4LjJLGXL9pWLRLIfkhkWdAbKsp/DFfAu8lYgD/vnV+?=
 =?us-ascii?Q?G+HwoUBKKZrwE1szxJ7T5iY83xEs9cIZROd2x8q1z0adZ5I8fcMGlFu/BPFz?=
 =?us-ascii?Q?h1NeVfOVEZ44uoXvXf7JpZPlowtAXAqxIdCk2xqbCmwh8O6QZBwm4XrhMDtj?=
 =?us-ascii?Q?6C41b+ICLY1y13ZYwxASAUwic0/yYwr3XPHFf67UXDAB5W367tHr95td6cby?=
 =?us-ascii?Q?fPpvC2dJnA+DU1qPmJ6/xSEKWvfTbhs8nrY3RrTGtC94tzPXWWAL58tIGtd4?=
 =?us-ascii?Q?j0suvSl/mTR7i0pAAcEmDIjuGfoIOmftKRcH2xcq/4GSwLjFwCd6xp/3SNh7?=
 =?us-ascii?Q?ui6oYHZTtLYygYXq9FOLIsZpTHCr/7JQYabnmYK5trujSW9EeDujBgWFlAs0?=
 =?us-ascii?Q?ngv31fH8kcVByKQiVyr8baGLoLonmS5Fwq4s8qBY6xYuRLUIZBBZ4LR4RBEC?=
 =?us-ascii?Q?k+SUx6gOlRf/m0TQBeyB+B/bCrsd0oW+Mr+eKSzO4uRCremnrl9DrwGbpM7U?=
 =?us-ascii?Q?ymhxPJdpuoTQlVA7CxU9VR94KTKZEKkNSd1k8nFJVylS5MbEoEArBcf9j0kT?=
 =?us-ascii?Q?nKsLmvhzHkhNzuZzkebtoPNUzLksC4uA2Jta7TkNFphrjwlcZqxa0nbf/5GL?=
 =?us-ascii?Q?ochpngUlKXiQHmIYtY6ggWnf6t/c4KZDHS9VMSqop0VtyTrYljesSmd6kvfF?=
 =?us-ascii?Q?VJ18QO8Pmc/m1LK1pQx7rs5AdRR1pLz6aej9GmWEU5WnKiN1EuUGFaeC62Rj?=
 =?us-ascii?Q?Sh4KeKEFrbbn2SwYTvmitr6IvLkm1SSHvbZWUyIRYuz0R7hD3UiAzk/SaI1G?=
 =?us-ascii?Q?a4w1tAjl39cEU0dQ1uzQTfpR/J3pWtQ5o68/XV0YjGJJBxt8Jonjia/cbPpt?=
 =?us-ascii?Q?r65B/znbHRuIEHzUk18OXSEEYUg6D7sSwUcSdrPjg2wzmd7Scgo2nGB/mgC2?=
 =?us-ascii?Q?82X046ZKZexeNaCwS1/SFEW2ugAk4OTryzdnttgYukKFjyYscfsZe7m/xpG2?=
 =?us-ascii?Q?hgTkHmAo9uIot0djz14cSGICIBcNvpSFEf/tAhxZK0VXRNlsedmmxB0DLnLn?=
 =?us-ascii?Q?QgjEHVG6kxurfWxHXQ7PciBHzHr3U2RgR7fDf04bmtAFWlVcO0Bn9Gsi/5+P?=
 =?us-ascii?Q?JLGH0d6K7Dv/ZHpBfejCj94=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c9daf9-bba4-4a97-c670-08db723059d8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 08:20:19.5780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UultCc1IlI+X7siq1H/CIcqo2PCnZVRIUFzQHY1dTuNFiqSNdAvqUbX/ja28MtL9LeuWQZ6zEVdFTVnVMMMtC5MDcMQD8EUizXn8iwqv1Jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8422
Received-SPF: pass client-ip=2a01:111:f400:fe0d::726;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
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

Initially data_end is set to the data_off image header field and must not be
greater than the file size.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 1ec98c722b..4b7eafba1e 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -868,6 +868,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
            and actual data. We can't avoid read-modify-write... */
         s->header_size = size;
     }
+    if (s->data_end > file_nb_sectors) {
+        error_setg(errp, "Invalid image: incorrect data_off field");
+        ret = -EINVAL;
+        goto fail;
+    }
 
     ret = bdrv_pread(bs->file, 0, s->header_size, s->header, 0);
     if (ret < 0) {
-- 
2.34.1


