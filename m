Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 192ED7735BE
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 03:10:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTBED-0002Y0-M2; Mon, 07 Aug 2023 21:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankit.kumar@samsung.com>)
 id 1qTB6V-0000Ob-BD
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 21:01:43 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankit.kumar@samsung.com>)
 id 1qTB6P-0001vq-Uf
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 21:01:43 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20230808010131epoutp029304a0876f72e84d79a8e84546b2a84d~5Qre1G7vg3097430974epoutp02B
 for <qemu-devel@nongnu.org>; Tue,  8 Aug 2023 01:01:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20230808010131epoutp029304a0876f72e84d79a8e84546b2a84d~5Qre1G7vg3097430974epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1691456491;
 bh=gSM+Gyo01YgbrodjXi7d5V6BCxBrUdz9zTwpkgw7YNs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YsYluZbNMRSRI6NGzW7VsBgw7PkWH6CYgVsLIYum5neZwqwlGFyRrLxAcq0SMEyP9
 Aq8zFtLXjl5/zvnCcLgVy8kbpHkL9g8mI/aotzcpzKbHd5OP0JieRTBMumn+GrkkyX
 dlVodv2gYtJfIPgRqKMRMxBVOd+bmOzipf8NV20A=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20230808010131epcas5p2e75d29d1a89dbe993ecf7aa47e7aef80~5QreZBPXB0916909169epcas5p2-;
 Tue,  8 Aug 2023 01:01:31 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.178]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4RKZdQ0rLFz4x9QJ; Tue,  8 Aug
 2023 01:01:30 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 26.D3.55173.9E391D46; Tue,  8 Aug 2023 10:01:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20230807160837epcas5p3b360bae29265c0851f13491952b40f38~5JaMYH5Wf1623916239epcas5p3B;
 Mon,  7 Aug 2023 16:08:37 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230807160837epsmtrp1d260d941135e8501bb99c5d740f0cc43~5JaMWpDnq3052430524epsmtrp1V;
 Mon,  7 Aug 2023 16:08:37 +0000 (GMT)
X-AuditID: b6c32a50-df1ff7000001d785-b7-64d193e9db35
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 1A.AC.64355.50711D46; Tue,  8 Aug 2023 01:08:37 +0900 (KST)
Received: from unvme-desktop.sa.corp.samsungelectronics.net (unknown
 [107.99.41.39]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230807160836epsmtip27ac98aa429a6622e6f8e45aaf19e95c0~5JaLnaqzE2883728837epsmtip2O;
 Mon,  7 Aug 2023 16:08:36 +0000 (GMT)
From: Ankit Kumar <ankit.kumar@samsung.com>
To: kbusch@kernel.org, its@irrelevant.dk
Cc: qemu-devel@nongnu.org, Ankit Kumar <ankit.kumar@samsung.com>
Subject: [PATCH 1/3] hw/nvme: fix CRC64 for guard tag
Date: Tue,  8 Aug 2023 02:57:43 +0530
Message-Id: <20230807212745.70151-2-ankit.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807212745.70151-1-ankit.kumar@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmlu7LyRdTDKY9trZYc+U3u8X+g99Y
 LSYdusZocbx3B4sDi8e5HefZPTat6mTzeHJtM5NH35ZVjAEsUdk2GamJKalFCql5yfkpmXnp
 tkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUA7lRTKEnNKgUIBicXFSvp2NkX5pSWp
 Chn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGTenX2EuuM5R0bzmNVsD4362
 LkZODgkBE4ljj/8zdTFycQgJ7GGUOHF7ITuE84lRYtn8/axwztIJCxm7GDnAWraekYOI72SU
 WHviJFRHJ5PE0k332EHmsgloS7x6e4MZxBYR0JCYdeAc2D5mAQeJX2duM4HYwgKmEhPOLgCz
 WQRUJZZcuAnWyytgI/Hu9Q8miPvkJWZe+g4W5xSwlXj8bDFUjaDEyZlPWCBmyks0b53NDHKE
 hMAxdomWH9uYIC51kTjz1ANijrDEq+Nb2CFsKYmX/W1QdrbEpoc/oXYVSBx50csMYdtLtJ7q
 ZwYZwyygKbF+lz5EWFZi6ql1TBBr+SR6fz+BauWV2DEPxlaV+HvvNguELS1x891VKNtD4vD8
 J2DjhQQmMEq0tThMYFSYheSbWUi+mYWweQEj8ypGqdSC4tz01GTTAkPdvNRyeCQn5+duYgQn
 Q62AHYyrN/zVO8TIxMF4iFGCg1lJhHfek/MpQrwpiZVVqUX58UWlOanFhxhNgeE9kVlKNDkf
 mI7zSuINTSwNTMzMzEwsjc0MlcR5X7fOTRESSE8sSc1OTS1ILYLpY+LglGpgWvVfQKEiyNTK
 ZWZxyrYVxqs3yJgGnGtZfKXW+LyD4sR94Wd3J1zn3rSpI9Pf95Llx0tyWz4I5fY9PG38J6ay
 bY3SxDfKCvwn/W9sa7dLkZyl8Kk8NHGeQtn5f39/HLJW5p3y/5u+7Z+LR9imepz6veae4v7s
 vskmq/wSNikErRb/9+v+4pDmeN8V34J+xJ9bFmiiezzQ3vXGi5P/Albc3OG389WClmx2XSXr
 oLKQTWuSrOS+3xAtZrnxLWyNwvGvry41nWL+sDGrsXk1//bo/Cl9AZW7soPyT0+b0+h321Dv
 yrz0CtngXsbG2Uqa2x57sZk3J3SV+/sf2Oj86aV/woHe3KSbCq+Ez2xY8N9aTomlOCPRUIu5
 qDgRAGvPkCEPBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsWy7bCSvC6r+MUUg723RCzWXPnNbrH/4DdW
 i0mHrjFaHO/dweLA4nFux3l2j02rOtk8nlzbzOTRt2UVYwBLFJdNSmpOZllqkb5dAlfGzelX
 mAuuc1Q0r3nN1sC4n62LkYNDQsBEYusZuS5GLg4hge2MEufvfoCKS0ssXJ/YxcgJZApLrPz3
 nB2ipp1J4uPJHcwgCTYBbYlXb28wg9SLCGhJnOyvBAkzCzhJ7LjVyg5iCwuYSkw4u4AJxGYR
 UJVYcuEmWJxXwEbi3esfTBDz5SVmXvoOFucUsJV4/GwxmC0EVLPmw3kmiHpBiZMzn7BAzJeX
 aN46m3kCo8AsJKlZSFILGJlWMYqmFhTnpucmFxjqFSfmFpfmpesl5+duYgSHqFbQDsZl6//q
 HWJk4mA8xCjBwawkwjvvyfkUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzKOZ0pQgLpiSWp2amp
 BalFMFkmDk6pBqYEyWytyKhpwpciuVjv6a78f+wts1/Kh10348y/Jq/VdZ+fuupKiJo92+4z
 29vPHl/xLtr46Afdolvfz3Eu+910+kHEQ70DLWcTDS9qlT9eLs3kVPrrzMJdq/e8FHeIuKw0
 4V8Jm7OjVhZXpHLAcqM9LXabt23a3GHavzFvt7fjvgMnFnn9duJQWbzv1Supc2eWvwtzfMhg
 0M1gP+3X2utKa3tXCik6vhP1K/72JJfN4q1I6Sc36bhJPXkf9jqnvb3ydgJjjldHlHPAkdIZ
 1T3nPOSXpqx60K76JaumhT/o97ae52XJF86cmNJ5+1xjma62V735xrvNbl+0XgTLzTvx72uR
 b++s64xXp++ec+uuEktxRqKhFnNRcSIAMT4kYMACAAA=
X-CMS-MailID: 20230807160837epcas5p3b360bae29265c0851f13491952b40f38
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230807160837epcas5p3b360bae29265c0851f13491952b40f38
References: <20230807212745.70151-1-ankit.kumar@samsung.com>
 <CGME20230807160837epcas5p3b360bae29265c0851f13491952b40f38@epcas5p3.samsung.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=ankit.kumar@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 07 Aug 2023 21:09:37 -0400
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

The nvme CRC64 generator expects the caller to pass inverted seed value.
Pass inverted crc value for metadata buffer.

Signed-off-by: Ankit Kumar <ankit.kumar@samsung.com>
---
 hw/nvme/dif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/dif.c b/hw/nvme/dif.c
index 63c44c86ab..01b19c3373 100644
--- a/hw/nvme/dif.c
+++ b/hw/nvme/dif.c
@@ -115,7 +115,7 @@ static void nvme_dif_pract_generate_dif_crc64(NvmeNamespace *ns, uint8_t *buf,
         uint64_t crc = crc64_nvme(~0ULL, buf, ns->lbasz);
 
         if (pil) {
-            crc = crc64_nvme(crc, mbuf, pil);
+            crc = crc64_nvme(~crc, mbuf, pil);
         }
 
         dif->g64.guard = cpu_to_be64(crc);
@@ -246,7 +246,7 @@ static uint16_t nvme_dif_prchk_crc64(NvmeNamespace *ns, NvmeDifTuple *dif,
         uint64_t crc = crc64_nvme(~0ULL, buf, ns->lbasz);
 
         if (pil) {
-            crc = crc64_nvme(crc, mbuf, pil);
+            crc = crc64_nvme(~crc, mbuf, pil);
         }
 
         trace_pci_nvme_dif_prchk_guard_crc64(be64_to_cpu(dif->g64.guard), crc);
-- 
2.25.1


