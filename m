Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D578714B79
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 16:04:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3dRu-0002nv-Hy; Mon, 29 May 2023 10:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q3dRs-0002nF-0S
 for qemu-devel@nongnu.org; Mon, 29 May 2023 10:02:12 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q3dRp-0006ns-Ta
 for qemu-devel@nongnu.org; Mon, 29 May 2023 10:02:11 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20230529140203euoutp02a077f8db680dd5cfa73c9203b6a92dbe~johslYmwt1123211232euoutp02s
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 14:02:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20230529140203euoutp02a077f8db680dd5cfa73c9203b6a92dbe~johslYmwt1123211232euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1685368923;
 bh=hfG0HX10NnlBbzuJ8TFLBlyZ0haLW6QgdGoDnoJj+Ls=;
 h=From:To:Cc:Subject:Date:References:From;
 b=gYiPDcL1s+0XB+e2UcYKPAvL4VenpknCmO9KzDUMoPHOFZOQIJ4EZbiiApPjmOT8Z
 RgNtfpDOFRy/iDLvUVKsdiA223hjOAMFKP9iZVMc3sCml+spJecKnvMG++SFBiLhU8
 EAt/10LYsRuaTCYKjdDHe0RvZccM2MX6uThpNDIw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230529140202eucas1p13ae9d6be5fd92ac8d4bae6845460cc86~johsRposF2568125681eucas1p1H;
 Mon, 29 May 2023 14:02:02 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id D2.91.42423.A50B4746; Mon, 29
 May 2023 15:02:02 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20230529140202eucas1p1920add7c8fd0a0c4efdfac6e9bdf5a7f~johr6CUW92227922279eucas1p10;
 Mon, 29 May 2023 14:02:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230529140202eusmtrp1c25c2ec6161e75ab6eafba8c3165c78e~johr5fR3z0620706207eusmtrp18;
 Mon, 29 May 2023 14:02:02 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-d5-6474b05a3019
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id FB.06.10549.A50B4746; Mon, 29
 May 2023 15:02:02 +0100 (BST)
Received: from AMDN5139.EU.corp.samsungelectronics.net (unknown
 [106.210.135.112]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230529140201eusmtip2f283fc526b9ec58870e6faa9026be394~johrT21Iy1093210932eusmtip2m;
 Mon, 29 May 2023 14:02:01 +0000 (GMT)
From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
To: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
Subject: [PATCH v10 0/7] igb: packet-split descriptors support
Date: Mon, 29 May 2023 16:01:46 +0200
Message-Id: <20230529140153.4053-1-t.dzieciol@partner.samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CLcRzHfZ/n2Z6n3PJsdfYRkTnnhNGFdieRH2f/uBNd7jqOZY9x2uy2
 Un42vwoV0aH1u7BqEtePiVSaH1O7dlmiw5XSERI1IiVaTx3/vT+vz6/35+5D4YIEjie1WxXJ
 aFSyCBHXlTA9HrAtCLsVKV+Uck4kcdTfICUGuwOTHM3O4EjKm3+SEktSBSFJKunCVnKlTz7X
 cqSNHTZc2vm8FJN+qW7mSs+WGdEGTphrgJyJ2L2P0SwM3O6662ZrO67OImNu578jdeg15wxy
 oYBeDPX970a0KyWgCxAYm8xjwTcErwvrMTZwIBiuT8DGWzpqrASbyEeQ1P2MZIN4DOoyu7nO
 Ki69FDq+ZY3MoigP2g9644VOjNMMPBqqJZzYnQ6E61a1ExP0bCiz1Yx28uhVYHhQidhdM0Bv
 /0GynA91+k6CHTMDjpen4861QOspSOxrGzO3BvIuZOOsdoePljKS1dPAmpJIsDoaBhpMJNt8
 AsG9iyljRcvAXj4w6hmn58LNuwtZHAQF7S+REwPtBi2f+awHN7hguoyzmAen4gRs9XzoL9Fz
 WewJuS1HWCwFXerg6B4BvRVS3+hQMvJO+++wtP8OS/tnIQfhRiRkorRKBaP1VTHRYq1MqY1S
 KcQ79ipL0Mi/WIctfRUo82Ov2IwwCpkRULjIg7dcppULeHLZ/gOMZu82TVQEozWjqRQhEvLm
 La/bIaAVskhmD8OoGc14FqNcPHVYcB5f7VVOy4qNbZVVLjFKw55VO//wrwVN2u6danxS9Ckx
 cuDFkbD+56djWpZUn5RoNj1upu+5BVwZLvY+lKMKuR/X5SfeKJfi/qofHnp7ldp0NGCyxadl
 mvWGvCc6OMVL2j242bQ12CKMrUzIPjCzodVRMXm/mYjv2XY46BdqInsMueFhyzLePuxaffBS
 7tlQprCd39eYZV3jXZbfuI65awgpVly12YY8GsTXfNqrq8KTQ9Pn0Mc6Awb91haXxn3dvL43
 XrlvxZ2DrwRPC+5MeftMWJRTOPE8Z+i3uBPLFLWWkluSp4fEVfvrbnW/+u7/3s6YZuVPUKz+
 kFoU2xYb6BAR2l0yXx9co5X9BaX0irieAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsVy+t/xe7pRG0pSDI4s5rb4fGotu8WyS5+Z
 LBrnz2G12Hr1B7vF8d4dLBa9m14wObB5nHh7kNXjwqNzzB5Prm1m8ni/7yqbR9+WVYwBrFF6
 NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GevvPWQu
 mMdesX35M/YGxjusXYycHBICJhKP9p9m6WLk4hASWMoocWJvHxNEQkpiX89/dghbWOLPtS42
 iKJWJonja76DdbMJmEk8+jIPyObgEBEwlXi2VxIkzCyQKXH61T42kLCwgJ3E6tMFIGEWAVWJ
 Lef2s4HYvAJOEssO72aEGC8vMfPSd3aIuKDEyZlPWCDGyEs0b53NPIGRbxaS1CwkqQWMTKsY
 RVJLi3PTc4sN9YoTc4tL89L1kvNzNzECA3vbsZ+bdzDOe/VR7xAjEwfjIUYJDmYlEV7bxOIU
 Id6UxMqq1KL8+KLSnNTiQ4ymQPdNZJYSTc4HxlZeSbyhmYGpoYmZpYGppZmxkjivZ0FHopBA
 emJJanZqakFqEUwfEwenVANTtQCvyUwptVuKji5npz3+6yinHblwa1Z9RZrPoddWv51niaxI
 u7sgO//D79w5OrXHJSaI3Jo2L27Z6/QjE27bbOM+/fCbe2HE0j2ZHR9ZT5/w8rZZ5vhFhb9O
 wuXVzhK5x+enK1Wd8ukUPz/jq1/zxVYj321Lp3/fVOYuUxVgoWyWL9JrJL13b7xPrUzx7Cu3
 ey27v7z6d6FM3Nlo6cLjlsUuZiLnM//N3/LKX/PnN5lcMSXnR5u/xvSGyeVP2CSmd31dHfOD
 R48dv/Zsvpqs93fj/9XfxfU9duln7FhwL41384wkr2o7kWfHd+5bG7h+ioqEu24B45b4jT79
 bxp6+PI+HeMsvXRZ1qf22pbjSizFGYmGWsxFxYkAjbS0dPUCAAA=
X-CMS-MailID: 20230529140202eucas1p1920add7c8fd0a0c4efdfac6e9bdf5a7f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230529140202eucas1p1920add7c8fd0a0c4efdfac6e9bdf5a7f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230529140202eucas1p1920add7c8fd0a0c4efdfac6e9bdf5a7f
References: <CGME20230529140202eucas1p1920add7c8fd0a0c4efdfac6e9bdf5a7f@eucas1p1.samsung.com>
Received-SPF: none client-ip=210.118.77.12;
 envelope-from=t.dzieciol@partner.samsung.com; helo=mailout2.w1.samsung.com
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Purposes of this series of patches:
* introduce packet-split RX descriptors support. This feature is used by Linux
  VF driver for MTU values from 2048.
* refactor RX descriptor handling for introduction of packet-split RX
  descriptors support
* fix descriptors flags handling

Tomasz Dzieciol (7):
  igb: remove TCP ACK detection
  igb: rename E1000E_RingInfo_st
  igb: RX descriptors guest writting refactoring
  igb: RX payload guest writting refactoring
  igb: add IPv6 extended headers traffic detection
  igb: packet-split descriptors support
  e1000e: rename e1000e_ba_state and e1000e_write_hdr_to_rx_buffers

 hw/net/e1000e_core.c     |  78 +++--
 hw/net/igb_core.c        | 730 ++++++++++++++++++++++++++++-----------
 hw/net/igb_regs.h        |  20 +-
 hw/net/trace-events      |   6 +-
 tests/qtest/libqos/igb.c |   5 +
 5 files changed, 592 insertions(+), 247 deletions(-)

-- 
2.25.1


