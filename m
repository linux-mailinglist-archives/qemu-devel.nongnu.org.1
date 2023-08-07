Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 245717735C0
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 03:10:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTBEB-0002WX-Ol; Mon, 07 Aug 2023 21:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankit.kumar@samsung.com>)
 id 1qTB6Y-0000QN-Dq
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 21:01:46 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankit.kumar@samsung.com>)
 id 1qTB6W-0001xz-07
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 21:01:46 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20230808010138epoutp04b102701b5f46f4c27409dc68a2aa35a4~5QrlfmRCB3267732677epoutp041
 for <qemu-devel@nongnu.org>; Tue,  8 Aug 2023 01:01:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20230808010138epoutp04b102701b5f46f4c27409dc68a2aa35a4~5QrlfmRCB3267732677epoutp041
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1691456499;
 bh=yVBKiJxjdRz0DEN5wZFdEkAhJ/D9Yjy685K72Y/ZWX0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uL5l/EvPcBaiSrkv+uWYaD3HekN2ksa9vc959NkNUGBN+BT2sb1dOy92OjWBxY1U8
 yFGpgUYo8YuJbxp0BilIGjFAOFQ6agXX6KZVqTdwbvupKbWBDGR4KLhNoXWzuiej2r
 osuCv50KOD/3vZycyL/owksGaYgALRfRDqzuvGOs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20230808010138epcas5p3f923f556959ffc1d96973a5b0b7629b6~5QrlCD4YZ2072920729epcas5p3J;
 Tue,  8 Aug 2023 01:01:38 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.179]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4RKZdY10T4z4x9Pp; Tue,  8 Aug
 2023 01:01:37 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C5.C9.57354.1F391D46; Tue,  8 Aug 2023 10:01:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20230807160839epcas5p3fc18f1e23b454a6db48de18c822ac2d4~5JaOC3tn_1429914299epcas5p3-;
 Mon,  7 Aug 2023 16:08:39 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230807160839epsmtrp2eaec2edca287b0cb2745d2e9b76006bb~5JaOCRbn_2055820558epsmtrp2h;
 Mon,  7 Aug 2023 16:08:39 +0000 (GMT)
X-AuditID: b6c32a44-269fb7000001e00a-30-64d193f18de5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 91.B8.30535.70711D46; Tue,  8 Aug 2023 01:08:39 +0900 (KST)
Received: from unvme-desktop.sa.corp.samsungelectronics.net (unknown
 [107.99.41.39]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230807160838epsmtip2ddde2a078bdc8bac86bb35598ad4ac23~5JaNSFq7I2883728837epsmtip2P;
 Mon,  7 Aug 2023 16:08:38 +0000 (GMT)
From: Ankit Kumar <ankit.kumar@samsung.com>
To: kbusch@kernel.org, its@irrelevant.dk
Cc: qemu-devel@nongnu.org, Ankit Kumar <ankit.kumar@samsung.com>
Subject: [PATCH 3/3] docs: update hw/nvme documentation for protection
 information
Date: Tue,  8 Aug 2023 02:57:45 +0530
Message-Id: <20230807212745.70151-4-ankit.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807212745.70151-1-ankit.kumar@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmhu7HyRdTDB7cZbVYc+U3u8X+g99Y
 LSYdusZocbx3B4sDi8e5HefZPTat6mTzeHJtM5NH35ZVjAEsUdk2GamJKalFCql5yfkpmXnp
 tkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUA7lRTKEnNKgUIBicXFSvp2NkX5pSWp
 Chn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGXun7Gcq6OOu6L+wk6WBcRln
 FyMnh4SAicS6r0tYuxi5OIQEdjNKbNnbxQbhfGKUmHxsBzOE841R4s7VeawwLcs3LGYBsYUE
 9jJK/DptB2F3Mkn8f5gHYrMJaEu8enuDGcQWEdCQmHXgHBuIzSzgIPHrzG0mEFtYIETiy7cj
 jF2MHBwsAqoSzatcQMK8AjYS11sfsUOskpeYeek7mM0pYCvx+NlidogaQYmTM5+wQIyUl2je
 OhvsTgmBU+wSpw79ZYZodpFo2r4B6mZhiVfHt0ANlZL4/G4vG4SdLbHp4U8mCLtA4siLXqhe
 e4nWU/3MILcxC2hKrN+lDxGWlZh6ah0TxF4+id7fT6BaeSV2zIOxVSX+3rvNAmFLS9x8dxXK
 9pCY1b2dBRKeExglvnU8Z5rAqDALyT+zkPwzC2H1AkbmVYySqQXFuempyaYFhnmp5fA4Ts7P
 3cQIToVaLjsYb8z/p3eIkYmD8RCjBAezkgjvvCfnU4R4UxIrq1KL8uOLSnNSiw8xmgLDeyKz
 lGhyPjAZ55XEG5pYGpiYmZmZWBqbGSqJ875unZsiJJCeWJKanZpakFoE08fEwSnVwNS7/3mS
 wZfIU/Knbpk/7dzMsjxoWrVlyE6O/offnttaTP8kedfx1bmJRx6W3H7x7tuG056ZRo8VGxi6
 p1+59om5X7ft3je5gtnZJzJKbq5z8zcU7JU8y51R9zbTKzN9uhjT2+ufXDaG92aknzo/+WbI
 k3qzsmVFNlmazSd29CYpMDIFxYk69z6P3/bc/ZPCix4ZE9M3d7hfqv+/kKSc81poRyF3k1JI
 g4zy3F/hh3u/ljWIPQvtjHOp/jtvc5MkxwGdyD2WVRvyppu+53mkKqrkMuv3jP83A7I6vkd+
 +jpXZdtNXr+YQP/vJ5c+K1Lc1z7nx0qd7vnHV87dK+8hwnP8s65s2jrByOiZRf3nzZVYijMS
 DbWYi4oTAYNCjfcOBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSvC67+MUUg8/NnBZrrvxmt9h/8Bur
 xaRD1xgtjvfuYHFg8Ti34zy7x6ZVnWweT65tZvLo27KKMYAlissmJTUnsyy1SN8ugStj75T9
 TAV93BX9F3ayNDAu4+xi5OSQEDCRWL5hMUsXIxeHkMBuRokHDROZuxg5gBLSEgvXJ0LUCEus
 /PecHcQWEmhnknjVWAhiswloS7x6ewOsXERAS+JkfyVImFnASWLHrVawcmGBIIm2x6fBSlgE
 VCWaV7mAhHkFbCSutz5ih5guLzHz0ncwm1PAVuLxs8VQm2wk1nw4zwRRLyhxcuYTFojx8hLN
 W2czT2AUmIUkNQtJagEj0ypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjOBA1dLawbhn
 1Qe9Q4xMHIyHGCU4mJVEeOc9OZ8ixJuSWFmVWpQfX1Sak1p8iFGag0VJnPfb694UIYH0xJLU
 7NTUgtQimCwTB6dUA5OWh7B+6ye99Z+vP5v8QGbi1xmHfDIMt1hcD9vzZYOBj0KfkYzxW6FU
 lR2ax9wORYt96Vf+VbZzZu2j3+sfBz39n2idum7CjjfrWG9v8zOb8kI6sj059OrvMyrJPMoS
 izdnnp/urvnnkyVzgXT1Mda4bfX3Q7SijnvsU0gumXry7t919w5XXdiiVvhUS+TkfVnXdWkn
 X6ubaQqw+y2br7T2/4mQxdZ9L9ynzDywOTP/4mNBi8jy1ISE20J+62+tXPPKsKYzdaU913GL
 VKVQ8cqOGSFck1tUpa054g+EPtstXDop4ySnb+Pc5v7+jY7vNs893/+Ie4rz8a985VIpdju/
 dVd43/eMkWpx61snI6LEUpyRaKjFXFScCABNmXiewwIAAA==
X-CMS-MailID: 20230807160839epcas5p3fc18f1e23b454a6db48de18c822ac2d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230807160839epcas5p3fc18f1e23b454a6db48de18c822ac2d4
References: <20230807212745.70151-1-ankit.kumar@samsung.com>
 <CGME20230807160839epcas5p3fc18f1e23b454a6db48de18c822ac2d4@epcas5p3.samsung.com>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=ankit.kumar@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
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

Add missing entry for pif ("protection information format").
Protection information size can be 8 or 16 bytes, Update the pil entry
as per the NVM command set specification.

Signed-off-by: Ankit Kumar <ankit.kumar@samsung.com>
---
 docs/system/devices/nvme.rst | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
index 2a3af268f7..30d46d9338 100644
--- a/docs/system/devices/nvme.rst
+++ b/docs/system/devices/nvme.rst
@@ -271,9 +271,13 @@ The virtual namespace device supports DIF- and DIX-based protection information
 
 ``pil=UINT8`` (default: ``0``)
   Controls the location of the protection information within the metadata. Set
-  to ``1`` to transfer protection information as the first eight bytes of
-  metadata. Otherwise, the protection information is transferred as the last
-  eight bytes.
+  to ``1`` to transfer protection information as the first bytes of metadata.
+  Otherwise, the protection information is transferred as the last bytes of
+  metadata.
+
+``pif=UINT8`` (default: ``0``)
+  By default, the namespace device uses 16 bit guard protection information
+  format. Set to ``2`` to enable 64 bit guard protection information format.
 
 Virtualization Enhancements and SR-IOV (Experimental Support)
 -------------------------------------------------------------
-- 
2.25.1


