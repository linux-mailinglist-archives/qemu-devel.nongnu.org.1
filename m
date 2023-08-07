Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6587735BF
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 03:10:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTBEC-0002XQ-K0; Mon, 07 Aug 2023 21:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankit.kumar@samsung.com>)
 id 1qTB6U-0000O2-3d
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 21:01:42 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankit.kumar@samsung.com>)
 id 1qTB6N-0001tN-TR
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 21:01:41 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20230808010124epoutp02201912cde0f8f8f048a5a1a08513cac2~5QrX40Wbf0119201192epoutp02r
 for <qemu-devel@nongnu.org>; Tue,  8 Aug 2023 01:01:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20230808010124epoutp02201912cde0f8f8f048a5a1a08513cac2~5QrX40Wbf0119201192epoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1691456484;
 bh=dqZY2dYuDxpQb4R+xCAOy+u+211gRBwVkDL+hZLdt4U=;
 h=From:To:Cc:Subject:Date:References:From;
 b=eW4PXknFeJ8o/kXJZ7+h21HUiIQjTaCG0j9jO8SYWLA3ApElrnOIleCPjUdYRMrDa
 cmk3QoJK3DBJhMWAuN4dn25xt85JyxtiJlYVsZ3S0KYXtexjLfUJymIMj4p0xbD2d+
 YmiAl921Jxy+BS9/DTHrPHEUYRxJACB03mPH+Ze0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20230808010124epcas5p3748b53462f2c1b3d1080b845912d779f~5QrXqk8GS1226212262epcas5p3D;
 Tue,  8 Aug 2023 01:01:24 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4RKZdH03WBz4x9QF; Tue,  8 Aug
 2023 01:01:23 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 09.1C.44250.2E391D46; Tue,  8 Aug 2023 10:01:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20230807160836epcas5p34398954fecd7388469012404b09b78f9~5JaLh06U92188821888epcas5p33;
 Mon,  7 Aug 2023 16:08:36 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230807160836epsmtrp13120a37be4a211191c98c96716a3d174~5JaLhN0iC3052430524epsmtrp1U;
 Mon,  7 Aug 2023 16:08:36 +0000 (GMT)
X-AuditID: b6c32a4a-ec1fd7000000acda-34-64d193e22f9c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 E0.6A.14748.40711D46; Tue,  8 Aug 2023 01:08:36 +0900 (KST)
Received: from unvme-desktop.sa.corp.samsungelectronics.net (unknown
 [107.99.41.39]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230807160835epsmtip289cb7f77085b7b2ba9b8356dd971e3fc~5JaKyzEXQ2743027430epsmtip2k;
 Mon,  7 Aug 2023 16:08:35 +0000 (GMT)
From: Ankit Kumar <ankit.kumar@samsung.com>
To: kbusch@kernel.org, its@irrelevant.dk
Cc: qemu-devel@nongnu.org, Ankit Kumar <ankit.kumar@samsung.com>
Subject: [PATCH 0/3] hw/nvme: bug fixes and doc update
Date: Tue,  8 Aug 2023 02:57:42 +0530
Message-Id: <20230807212745.70151-1-ankit.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmpu6jyRdTDHYvFLRYc+U3u8X+g99Y
 LSYdusZocbx3B4sDi8e5HefZPTat6mTzeHJtM5NH35ZVjAEsUdk2GamJKalFCql5yfkpmXnp
 tkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUA7lRTKEnNKgUIBicXFSvp2NkX5pSWp
 Chn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGetWzWUueM9S8enidsYGxtfM
 XYycHBICJhI3fx9j72Lk4hAS2M0o8bdrITtIQkjgE6PE2wUWEIlvjBITn09ggum48v03E0Ri
 L6PE9Y0XWCE6OpkkLl4tB7HZBLQlXr29AbZCREBDYtaBc2wgNrOAg8SvM7eBmjk4hAXMJOa2
 coOEWQRUJSZu2QNWwitgI/FkRSvUdfISMy99Z4eIC0qcnPmEBWKMvETz1tnMIDdICGxjlzjy
 YBbUcS4Sc7bPZoWwhSVeHd/CDmFLSbzsb4OysyU2PfwJVV8gceRFL9Qye4nWU/3MILcxC2hK
 rN+lDxGWlZh6ah0TxF4+id7fT6BaeSV2zIOxVSX+3rvNAmFLS9x8dxXK9pCYP/k42EghgViJ
 xbNTJjDKz0LyzSwk38xCWLyAkXkVo2RqQXFuemqxaYFRXmo5PFaT83M3MYLTnZbXDsaHDz7o
 HWJk4mA8xCjBwawkwjvvyfkUId6UxMqq1KL8+KLSnNTiQ4ymwCCeyCwlmpwPTLh5JfGGJpYG
 JmZmZiaWxmaGSuK8r1vnpggJpCeWpGanphakFsH0MXFwSjUwxRi472SIPfJQKTxp45yrUq7t
 ewTaNrAcC2N5nHXnxFIHbq7Cmo3KMjdvh4bxrPaxb/MJeXphaWfsjCsr2Ty7vV6Uc6583vBw
 U53kzdrSwJdb1z0srLrD41du1fh+9aSEN41uR08ucT/nFSdQ0HljdnxHwPfbXyMWVk52ztlp
 Zb/q/OOft3SKpKTvJMvMXulit3njqXzmReeTX8lu5jrQtVnlkSvXp6O+k5kqLwWc+HnopOxO
 7qJfkRvvOtY8FNe/uuiv5GfGkM2eu0wb9SbUniuK+5lqeTpxlbVTlNWaadNlTWJC334+ziBx
 82/45y0XWcVOL7grlMsyawpX01yFpb3HZMOvr15WeUJ3KUfLVCWW4oxEQy3mouJEAOFCV1MA
 BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsWy7bCSvC6L+MUUg0VtMhZrrvxmt9h/8Bur
 xaRD1xgtjvfuYHFg8Ti34zy7x6ZVnWweT65tZvLo27KKMYAlissmJTUnsyy1SN8ugStj3aq5
 zAXvWSo+XdzO2MD4mrmLkZNDQsBE4sr330xdjFwcQgK7GSUeTV/J2MXIAZSQlli4PhGiRlhi
 5b/n7BA17UwSR3c0MIEk2AS0JV69vcEMUi8ioCVxsr8SJMws4CSx41YrO0hYWMBMYm4rN0iY
 RUBVYuKWPWwgNq+AjcSTFa1QJ8hLzLz0nR0iLihxcuYTFogx8hLNW2czT2Dkm4UkNQtJagEj
 0ypGydSC4tz03GTDAsO81HK94sTc4tK8dL3k/NxNjODQ09LYwXhv/j+9Q4xMHIyHGCU4mJVE
 eOc9OZ8ixJuSWFmVWpQfX1Sak1p8iFGag0VJnNdwxuwUIYH0xJLU7NTUgtQimCwTB6dUA9Pu
 VzvaOVl6uV7K/xWbemPlhx/vz4h/eHrK3rbl91WDk6bGZkYyDVVWba+myV96Na/i6aQaP4bV
 QSyCH5hn918QuJiw4dUn86AXN5VUu7+tzNr7+KX4r4olc/dEWdUnfZ4U+KrqzrVpu9PKPyz0
 Cvzbsbrz2Jz604vaSn39LwpMid2Sx7+0Ydk8zxQRra5ZTIU2l36/3HndnclGj+u6ToegS2NT
 YinrT0WjaQEHz8gb9z9m1Q9wLtNca2o8a4ZlQ9TEF5scYj6qCU93C5IIzrdeu3KD4iMRA8el
 B28ZXfitaGiZebwpYOf7H7t1Fj0rl1qwM+14y6bMFXd/qF2/Uloaz93IcW3usrZY7zjNslYl
 luKMREMt5qLiRAAaLH1urAIAAA==
X-CMS-MailID: 20230807160836epcas5p34398954fecd7388469012404b09b78f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230807160836epcas5p34398954fecd7388469012404b09b78f9
References: <CGME20230807160836epcas5p34398954fecd7388469012404b09b78f9@epcas5p3.samsung.com>
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

This series fixes two bugs
1. CRC64 generation when metadata buffer is used.
2. Protection information disable check for Type 3 protection.

This series also updates the documentaion for pi (protection information),
and adds missing pif (protection information format) entry.

Ankit Kumar (3):
  hw/nvme: fix CRC64 for guard tag
  hw/nvme: fix disable pi checks for Type 3 protection
  docs: update hw/nvme documentation for protection information

 docs/system/devices/nvme.rst | 10 +++++++---
 hw/nvme/dif.c                |  9 +++++----
 2 files changed, 12 insertions(+), 7 deletions(-)

-- 
2.25.1


