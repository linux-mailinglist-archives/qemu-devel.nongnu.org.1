Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 379977735C1
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 03:10:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTBEC-0002Xd-ST; Mon, 07 Aug 2023 21:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankit.kumar@samsung.com>)
 id 1qTB6U-0000O4-9I
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 21:01:42 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankit.kumar@samsung.com>)
 id 1qTB6Q-0001ws-0L
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 21:01:42 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20230808010135epoutp0213c6ede79ba4f89121f56660a40f4100~5QrhzveLU3068130681epoutp02b
 for <qemu-devel@nongnu.org>; Tue,  8 Aug 2023 01:01:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20230808010135epoutp0213c6ede79ba4f89121f56660a40f4100~5QrhzveLU3068130681epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1691456495;
 bh=JpYPOlBvqpTKgpjgLJgqjbI43le9C/lfkvjpv5D8ND8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aUCNff0nTW0wrGBVujIDzdXY4F1p2TAOpoo6yOBOlzBqhjVN3bllSb/qUMFq7/sZO
 WFsQGPhuB8nbg5uxwUC85xEwMewaotBaLvATeUwuD1qP8F+eJd2q7+QtnQ3oaZU8EU
 12BfN6d9HAZfZ88Zklt/I7/dPZtZp14V6KB7+6rs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20230808010134epcas5p1130e84ba2cc5bdd85bf3b204a71baa50~5QrhlmtnX1435914359epcas5p1K;
 Tue,  8 Aug 2023 01:01:34 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.180]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4RKZdT4296z4x9Q9; Tue,  8 Aug
 2023 01:01:33 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 13.C9.57354.DE391D46; Tue,  8 Aug 2023 10:01:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20230807160838epcas5p389c82acd77fd8c74fc7f83300b9d0aa9~5JaNNKyee1415114151epcas5p3G;
 Mon,  7 Aug 2023 16:08:38 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230807160838epsmtrp224d033cd3a2493dca4abcda5f7500d6c~5JaNMkeQT2055820558epsmtrp2g;
 Mon,  7 Aug 2023 16:08:38 +0000 (GMT)
X-AuditID: b6c32a44-269fb7000001e00a-20-64d193edc6e1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 31.6A.14748.60711D46; Tue,  8 Aug 2023 01:08:38 +0900 (KST)
Received: from unvme-desktop.sa.corp.samsungelectronics.net (unknown
 [107.99.41.39]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230807160837epsmtip2507c5966b0dcb5eba5a53bf11c5094e2~5JaMcz6VP2743027430epsmtip2l;
 Mon,  7 Aug 2023 16:08:37 +0000 (GMT)
From: Ankit Kumar <ankit.kumar@samsung.com>
To: kbusch@kernel.org, its@irrelevant.dk
Cc: qemu-devel@nongnu.org, Ankit Kumar <ankit.kumar@samsung.com>
Subject: [PATCH 2/3] hw/nvme: fix disable pi checks for Type 3 protection
Date: Tue,  8 Aug 2023 02:57:44 +0530
Message-Id: <20230807212745.70151-3-ankit.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807212745.70151-1-ankit.kumar@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmuu7byRdTDC5tkLJYc+U3u8X+g99Y
 LSYdusZocbx3B4sDi8e5HefZPTat6mTzeHJtM5NH35ZVjAEsUdk2GamJKalFCql5yfkpmXnp
 tkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUA7lRTKEnNKgUIBicXFSvp2NkX5pSWp
 Chn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGeuPrmQs2MRZMfH9C9YGxjns
 XYycHBICJhJvZu5m7mLk4hAS2M0o8arvBROE84lR4szV2VDON0aJ/p0v2GBaTq/5B5XYyyix
 +PRXNgink0ni4v0XLCBVbALaEq/e3mAGsUUENCRmHTgH1s0s4CDx68xtJhBbWMBTom3ZNjCb
 RUBV4uq0T6wgNq+AjcScB/ugtslLzLz0HexYTgFbicfPFrND1AhKnJz5hAViprxE89bZYE9I
 CJxil7i76g1Us4vEp8W9UJ8KS7w6vgXKlpL4/G4vVE22xKaHP5kg7AKJIy96mSFse4nWU/1A
 NgfQAk2J9bv0IcKyElNPrWOC2Msn0fv7CVQrr8SOeTC2qsTfe7dZIGxpiZvvrrKAjJEQ8JB4
 sB1supDABEaJN7vUJzAqzELyzSwk38xCWLyAkXkVo2RqQXFuemqyaYFhXmo5PJKT83M3MYKT
 oZbLDsYb8//pHWJk4mA8xCjBwawkwjvvyfkUId6UxMqq1KL8+KLSnNTiQ4ymwOCeyCwlmpwP
 TMd5JfGGJpYGJmZmZiaWxmaGSuK8r1vnpggJpCeWpGanphakFsH0MXFwSjUwud9e0O5tXXy2
 P8mxX+rwK6fNx05zCtVtf9vRNTssas6m+ZssrFeuvX63KrlupcUEK6U/IqbrRW+8juFWS/p0
 PO9Dk6vDFaN3m05k3Jyyuu6zhq6y284udtnF8ZsPC1gGPpxZe2LVKoml1+VzD+1NK47jMeHg
 nHL8WeauG3vMosWCdkxYUfvhsuuL+292B5ce+9i24v5UkxcLxdSnbbv+0fx0xQ6x90aVsV2P
 MxT37xXRD7gkI/I1kCE7e9U501vPq4zOrnx3xcCyc+mKtM0TH3XO2d145sv5nweyvueanJ0k
 fYDdv+PsQcceu6neX7pnvnMzeOD3zMtjxquezOTJjuZ6e7Zd5ZapO+V/0W6BVKcSS3FGoqEW
 c1FxIgAMvnZ8DwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSvC6b+MUUg+6lfBZrrvxmt9h/8Bur
 xaRD1xgtjvfuYHFg8Ti34zy7x6ZVnWweT65tZvLo27KKMYAlissmJTUnsyy1SN8ugStj/dGV
 jAWbOCsmvn/B2sA4h72LkZNDQsBE4vSaf0wgtpDAbkaJj7ukuxg5gOLSEgvXJ0KUCEus/Pcc
 qJwLqKSdSWLx20tgvWwC2hKv3t5gBqkXEdCSONlfCRJmFnCS2HGrFaxEWMBTom3ZNrDxLAKq
 ElenfWIFsXkFbCTmPNjHBjFfXmLmpe9g9ZwCthKPny1mhzjHRmLNh/NMEPWCEidnPmGBmC8v
 0bx1NvMERoFZSFKzkKQWMDKtYpRMLSjOTc9NNiwwzEst1ytOzC0uzUvXS87P3cQIDlUtjR2M
 9+b/0zvEyMTBeIhRgoNZSYR33pPzKUK8KYmVValF+fFFpTmpxYcYpTlYlMR5DWfMThESSE8s
 Sc1OTS1ILYLJMnFwSjUw3fwbsut6nBbjk8k7A9g55aNSXI7u/lw5s8It+9qCQ7NZy+6rXM77
 Gsb6b2t7l3D6wWaVOWvMApbUJvjWzBQu3htnvCH67Vu/tYe1Xm16K2d3USjv0HOlA5/smtTd
 9hu21hUciar7Eer3dsF6m9fFVs9ZhXUeZyza/bvTV3Njanjlh+23zkREfUo4J87yPz9B4v7T
 k0dWubBzXYy2Upz9Y21/iHb9Wo4Zf7yPLvr84Eua4gHTcEGWT3X8conH88/FXz41TWnO7M8q
 zLWeBy8pTPy2OmzbLu1N2zZLmJQGTWVz8fw866nVRfb1pgZ/VI4u/ZGyuZ1PTUFv0jZG56xp
 J/0TlX9NldHfYRy98dIdXiWW4oxEQy3mouJEAPjmQtjEAgAA
X-CMS-MailID: 20230807160838epcas5p389c82acd77fd8c74fc7f83300b9d0aa9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230807160838epcas5p389c82acd77fd8c74fc7f83300b9d0aa9
References: <20230807212745.70151-1-ankit.kumar@samsung.com>
 <CGME20230807160838epcas5p389c82acd77fd8c74fc7f83300b9d0aa9@epcas5p3.samsung.com>
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

As per the NVM command set specification, the protection information
checks for Type 3 protection are disabled, only when both application
and reference tag have all bits set to 1.

Signed-off-by: Ankit Kumar <ankit.kumar@samsung.com>
---
 hw/nvme/dif.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/dif.c b/hw/nvme/dif.c
index 01b19c3373..f9bd29a2a6 100644
--- a/hw/nvme/dif.c
+++ b/hw/nvme/dif.c
@@ -157,7 +157,8 @@ static uint16_t nvme_dif_prchk_crc16(NvmeNamespace *ns, NvmeDifTuple *dif,
 {
     switch (NVME_ID_NS_DPS_TYPE(ns->id_ns.dps)) {
     case NVME_ID_NS_DPS_TYPE_3:
-        if (be32_to_cpu(dif->g16.reftag) != 0xffffffff) {
+        if ((be32_to_cpu(dif->g16.reftag) != 0xffffffff) ||
+            (be16_to_cpu(dif->g16.apptag) != 0xffff)) {
             break;
         }
 
@@ -225,7 +226,7 @@ static uint16_t nvme_dif_prchk_crc64(NvmeNamespace *ns, NvmeDifTuple *dif,
 
     switch (NVME_ID_NS_DPS_TYPE(ns->id_ns.dps)) {
     case NVME_ID_NS_DPS_TYPE_3:
-        if (r != 0xffffffffffff) {
+        if (r != 0xffffffffffff || (be16_to_cpu(dif->g64.apptag) != 0xffff)) {
             break;
         }
 
-- 
2.25.1


