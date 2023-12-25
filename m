Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5FA81E446
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 01:54:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHvhA-0006Yk-E7; Mon, 25 Dec 2023 19:53:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <merenberg@uwaterloo.ca>)
 id 1rHucu-0000XD-7a; Mon, 25 Dec 2023 18:44:52 -0500
Received: from esa.hc503-62.ca.iphmx.com ([216.71.135.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <merenberg@uwaterloo.ca>)
 id 1rHucs-0007xL-3S; Mon, 25 Dec 2023 18:44:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
 t=1703547890; x=1735083890;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=Y9kSjmBO1bNUTbNBpVBRGu2RyFc5BclNG86BRG7sajs=;
 b=zo18kJ+rjw20XqQYY5cdnjJz/0GoTMlWt5GkdYva8eXZGWO/iJR9qT2W
 ugnsOzMLesnV757qetx1riRos9hO91Uh5lNewnH62mCvH8u8vcwgv0zTt
 SBYSpxx1RggJYtRTBb6T98VZ6dOmM07QvcBx2N4AOzFmoBL+FTIqsO5AG 0=;
X-CSE-ConnectionGUID: /4RGVPK+ROOSgFNCiZ4uQA==
X-CSE-MsgGUID: 8QdwztHFQma5hv0RMglM7Q==
X-Talos-CUID: =?us-ascii?q?9a23=3AHgCjFGlYMFHp7eowRy37+IMSxTbXOTqB9ljuG2z?=
 =?us-ascii?q?7M0FOc7K7b3SRyv95quM7zg=3D=3D?=
X-Talos-MUID: 9a23:Bzj/NAZ8yERNB+BT5wbgmyN+FOlR5q3zCF5Vq7AJv+zbDHkl
Received: from mail-yt3can01lp2169.outbound.protection.outlook.com (HELO
 CAN01-YT3-obe.outbound.protection.outlook.com) ([104.47.75.169])
 by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Dec 2023 18:44:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=indCO/0AQtOJZCBxKs0ra7dEujUiRaDPQRB+yywIWwYye/Bp1g+0bha1ygRqL0OAlYI3eNcOWuQKKnrJajp0DFpaym8t2v/3jeVExrNUKheSvrH168gIfqAfj6c3GwnsYGdg/mBHOyvsfUGhVZkuhjlTUDm1fcVLnaOR3ZdbwUwCh1VENBAkOdrq/zPa9w0ICi4DUe6eR0nBAm+8K1uBWKdRvaTEhDlNZFJ7orYAQGr46ChIcA+V+tpW+VLksR9sL3blLfvMkATT/PZvxIJ8D7epKjEEi6DgZZLvh9hX4SeTrVngUxGX9yjhRa/iYMB3rVw8/EWJddT3vfIgBtotIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+UEjnR4Lh5sIuuCWraBxxUWwonlWno7Pk1NsZ6AgFQ=;
 b=HwmXi3qFPtqDklWPcHd/cBjSbIP04cckRTO+/HBolQjpM3BQQ7B+dmzt+dnwIVyXKH49TmM9895fVXJlryHACzy1wmtmCHqM8R86PfXwCPohREPif2ZsFPOlM69e1lyquTd/qKPXKxUUad4wOecPU5djrZ99KWZmGoeMBOTxnEkOAtFmzevAJ7mDyHo1bBdYLEEvswEAscnuFCwXxJhfYwBBNJRCNL7K9THcp2ho+eH6WlEd3EVJ6prAQ31DW+NdZO0v9XbDrLqI63VoXLqfi014Qn0vZO8cD48uXOVfwptmu/J2x8S1zNoiERZhn9jViYA3rjbB3jQBSedFsKsDTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YT2PR01MB4621.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:39::14)
 by YT3PR01MB6646.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:72::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 23:44:34 +0000
Received: from YT2PR01MB4621.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7ea9:e189:bf7:d38e]) by YT2PR01MB4621.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7ea9:e189:bf7:d38e%3]) with mapi id 15.20.7113.027; Mon, 25 Dec 2023
 23:44:34 +0000
Date: Mon, 25 Dec 2023 18:44:32 -0500
From: Max Erenberg <merenber@uwaterloo.ca>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, jslaby@suse.cz
Subject: [PATCH] edu: fix DMA range upper bound check
Message-ID: <ZYoT4OGEuikUup59@max-HP-NOTEBOOK>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: YT3PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::12) To YT2PR01MB4621.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:39::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB4621:EE_|YT3PR01MB6646:EE_
X-MS-Office365-Filtering-Correlation-Id: cc76b6eb-dff3-4abd-1acb-08dc05a372ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rG/ywvZD0lS7gNN3q2PB1RpH6hwADnyLpdE5g662+1rgQGVQ2wfCzaCMGWSoTbITg8wAI+sWMpiEa8Jgu/TNDCSy9Qb1YOyiuJLVI9pvKM/6w0Q7P6pLOmyotqIAUZBqS5OkLndo/GAMgW+KkOE1npxrZ1NG1uw65TOT2H8c0czA8RHJRNotrH7X78EEsm2ctgxl6FdGEP6XZ+4UjrOO9tY7qMcVZ6ltaa62COc3Pbl3AZSBcRar847+qFU5NhsSvZVe3+9sHEf2dY95hqr+orNYMf23q9BK8nIHwFNHujVdhH1lW7JqPBbuzUUgN56rFLwtLTt9WYOV/hdvkNw8S8O7Xz01Xz+/uRpH2Ms0Jd8jzrEqa6QCwNPvTIxNQIsoHlwcQ7J4CaeKO3t4OFwXMKXQC3Rn+JL+qoaZrJex04NqDt2Lj8IQZCMsGqREgCg7Yd3fMfL/OU2/nhwexcDYkVJHXBnvGvRBFuYScgu9hUfr1ALNwZndfOwnu9V/seYoiHLcHY9Q18/XtSIt/FVNNw+L6LqGJOsjWnEy0Vho6khLHdXuYn3BxEfjfHkhV2Co
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB4621.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(396003)(39860400002)(366004)(376002)(346002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(83380400001)(38100700002)(9686003)(478600001)(316002)(6916009)(786003)(66476007)(66946007)(66556008)(6506007)(6512007)(8676002)(8936002)(4326008)(5660300002)(2906002)(6486002)(33716001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e3CJyW8CbksF0zj/HkY9DlvxtJOVPABnkqBotDRATQol51Fvf86vuXpvXhj+?=
 =?us-ascii?Q?3SCjQpd4RJKZP2ShFDUIxmmMWc8YsXx/VfGORBCKtEhPKdxBrjP80ZmGASAj?=
 =?us-ascii?Q?vmlY7ybPU957hAVMF70GBvgJNxis0mHjVKctqr45s/6cmNpOmCr59s19Emzm?=
 =?us-ascii?Q?5z8l/czeIriGCGc2Ize145H8vTgzdL8V5ikssxysWvNg4K+SsJ7294hxTuxP?=
 =?us-ascii?Q?sDSNCniMRPYdBJpGRtvBhcFiUaJFXKcR+DmlyboIjngoM/VrgvBvxHQ3b9Ce?=
 =?us-ascii?Q?8/3OoOwBFySFyMp8Gf0bpSBTkJeCeN0o25sctw3wgYh5nkNkr+NTnYSAd9zn?=
 =?us-ascii?Q?SjQNC7+r8bNnUNYJcRDF5SzdgTMxxblqOJHgy5gm0dBRlihoqXHXGH37rp9H?=
 =?us-ascii?Q?HA28bJ6HY2JnbstG2Y5yrGd/FpyDbT0UIAN269t2N7WTTQaYToUA/1aThLlX?=
 =?us-ascii?Q?E1ZeJKKy/vPTA3s8wD9lu4eU/54vtVQoLMlMzmSysWwKL3q9JrL/xmNr0wso?=
 =?us-ascii?Q?sJOEsWY0/HMrE8yIGdkzVC9/bAY41IowPp9f3s1l37JYjq8KIkFApmn/UsmR?=
 =?us-ascii?Q?JylFZyx5O8kM1rOP3ef72vKIm/mDGGT0g54XauQEJSQroSacMsA2su3Jsr9U?=
 =?us-ascii?Q?J/pM4bcKz3Gfj+fODvoD+Huekc1J13RlMPPNqR9kELNSb7+crK6R/KxT4YnN?=
 =?us-ascii?Q?8DFh0PX+k3hTlhLMw+lrUW604NsgtQliJWYQMTKp6lbTjHkRUWau/mTBb0y4?=
 =?us-ascii?Q?JKuWVr1ocP9lCDzqMW+nOEfUp6/RzGTB/D7n7GL+IN6KKtg7jRfKPuplYKQP?=
 =?us-ascii?Q?Tuw4wXFxyVi8w+Km+lYiPWuThJPtGDF3AHUzgCT8iX2LpeacwIdmSvjjVJM3?=
 =?us-ascii?Q?CMJPn5HOniiQ8m1tYcjAOZvNtRwDQsyzqMd6WtUGu7P1zv0mogJf1Tj83MFA?=
 =?us-ascii?Q?JTQfNHAkvOjDl6ywWevCy1UWotadNUjTylN6pLzXLLNbMX7+MKA63t6uVCx6?=
 =?us-ascii?Q?QImrHsUKO9qYl9JQ/uZLj6B0ZAJZyP4fe+RMpH2fS9VbMcn5MNH+jQg4x0Xu?=
 =?us-ascii?Q?wDxgNEnNMQqwc6fjVN45e9xGHoyaoE2waVrPR8oW9UPkIfdJy4EockmdDA5a?=
 =?us-ascii?Q?xvCZS15d4GOYt4drYsKdmrmeaRTa3NjTU9paZJ+2Q9rIZKQwy3pJVCNg0qBy?=
 =?us-ascii?Q?ApSpocMtM1SwNCB3OEs1masB0oMQp7qR1JEO4hOMljOHxwP9vvOmScIENbcP?=
 =?us-ascii?Q?K4MNyJ4f/2jpFjSc28ooBvvfwWyt7IcwLqcNSqN2YF8oZ80elMnArrZqzcEA?=
 =?us-ascii?Q?/+XDji6tfjF4E892i24HsDLxr7H0e7JJxDZVhS1ItW/erNf4iQf7LawTEtlk?=
 =?us-ascii?Q?qo/iqoJAmD/ppJpM/zBAebZA+KyAkOhYG41i92IeVcGRkFaF4hxKAE12zHLD?=
 =?us-ascii?Q?2CCrRLPFAYx3VO+FS2gqLvnyFJ+nls5XEPdVH3Ruay//K89JdU9GNEDTRCZ0?=
 =?us-ascii?Q?VFJJdp1wTxu79Zbg6jQ3LaZ7ARYP1uoNMRZkX1ugYWem7hktjFfB9oqVC132?=
 =?us-ascii?Q?N97NK+SxXM7d/3Zzy7PelNawn3+CtTuYhwYwlaYrskXqG+CyXtQ0J7v6P4au?=
 =?us-ascii?Q?Iuzo+MR8YG0lBG+l03TvHyQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VNHnc74lgUARtzTutN04QZcxpXIWhBAmtPm78U20I9hcy/hZyKuymyP9abLmAEaOlISQLBh0GgtTVNDEFTbtb1Y6FeMSAtO4S/DRzq/KwdPCVtWmQlM+hVRGMMBOss6oH9TwLmHrazu+jHkvewI6OmGWn2726ZLdx4qVpYS5W0bxDrclCpDq8Axg+WmwURrLWM1d1V+pq8u20hfLiFuBp87u+ZfrQMXtWKqmMU1r8NotK63CNO3KZHTg8CxglSYlzoCk5799BeMcgcOPgZdbhWzrvUtIUCC8HXQA3MBMAwxs0xEzLIjjockoWIkJ2jQIrIVY6t3703myNLvwXcY/wGW8LiWUYrtwSv9FqYrp2136NuqImRWHkMSYO9hHFXS+E5gOyHea0EPPOymrJ/PoTs7VFxuQezICfihz0imse9M9aqqaw9P0+10O/EEXEHquybWJeuYZhQQmQdFfrL4dvlXkUbZ7CF9INlAsht9Faa9UOYdzJworJtHpsmvOdSODCD5tyRb4N1qkEil/VLH4FLemWyx6/K2Rfc43VQMCzQBLgC5Ft9FpF6ZUyZxufNZcubGvX8Ag+3/d+c9qeFeVgNhELcAp/AUT5su5kcX6nzHIWBS+CCEUwXMHsK2tsAOC
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: cc76b6eb-dff3-4abd-1acb-08dc05a372ad
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB4621.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2023 23:44:34.2481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IcE3hQQ7Vp6Wit0QMfrwW9pjH8gwNQH6P9YsKUYEtZF2ioxQnnHM90AM6MpnoVHPw3JNRT1ZOD82xkyLdeSSeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6646
Received-SPF: pass client-ip=216.71.135.51;
 envelope-from=merenberg@uwaterloo.ca; helo=esa.hc503-62.ca.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 25 Dec 2023 19:53:19 -0500
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

The edu_check_range function checks that start <= end1 < end2, where
end1 is the upper bound (exclusive) of the guest-supplied DMA range and
end2 is the upper bound (exclusive) of the device's allowed DMA range.
When the guest tries to transfer exactly DMA_SIZE (4096) bytes, end1
will be equal to end2, so the check fails and QEMU aborts with this
puzzling error message (newlines added for formatting):

  qemu: hardware error: EDU: DMA range
    0x0000000000040000-0x0000000000040fff out of bounds
   (0x0000000000040000-0x0000000000040fff)!

By checking end1 <= end2 instead, guests will be allowed to transfer
exactly 4096 bytes. It is not necessary to explicitly check for
start <= end1 because the previous two checks (within(addr, start, end2)
and end1 > addr) imply start < end1.

Signed-off-by: Max Erenberg <merenber@uwaterloo.ca>
---
 hw/misc/edu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index a1f8bc7..e64a246 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -115,7 +115,7 @@ static void edu_check_range(uint64_t addr, uint64_t size1, uint64_t start,
     uint64_t end2 = start + size2;
 
     if (within(addr, start, end2) &&
-            end1 > addr && within(end1, start, end2)) {
+            end1 > addr && end1 <= end2) {
         return;
     }
 
-- 
2.39.2

