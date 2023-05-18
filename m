Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7B770838D
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 16:06:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzeFp-0007Td-Kr; Thu, 18 May 2023 10:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1pzeFn-0007T3-8H
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:05:15 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1pzeFa-0003ng-5w
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:05:15 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20230518140458euoutp013e6105b64faac1740a73b141f3a7005a~gQeGwS7-63097730977euoutp01k
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 14:04:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20230518140458euoutp013e6105b64faac1740a73b141f3a7005a~gQeGwS7-63097730977euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1684418698;
 bh=/RZUBP+5BOkPl5P2jh2sy3iB7ty3zWb58X/R8p37OiY=;
 h=From:To:Cc:Subject:Date:References:From;
 b=GdpH+t55eA+PeOp+0R9ZaRzobIY2KHmGV7DDjEWtl2EeU7NB0Fch6g3tCWHqnKxRv
 jRsbeN/uNUPvR8inz50/pB4fHp8unM9WCxMr7j/R3uPJ2etipJ9g0yh9PEaDjhnbM/
 xmrTbWfIwdE1y9ISVUkM1RawrHFOGXURakHV2Z7Q=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230518140457eucas1p1c86f4aa256a9b96399c72c83e3bd7bca~gQeGfhFQm3166531665eucas1p1P;
 Thu, 18 May 2023 14:04:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 6E.72.42423.98036646; Thu, 18
 May 2023 15:04:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20230518140457eucas1p17f5acf26efb84441f8da0510ffd38bab~gQeF4J4H11423714237eucas1p1P;
 Thu, 18 May 2023 14:04:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230518140457eusmtrp260b1525a35a54c34c53096fd7a69d966~gQeF3c5MV0224402244eusmtrp2a;
 Thu, 18 May 2023 14:04:57 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-18-646630897f27
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 71.61.14344.98036646; Thu, 18
 May 2023 15:04:57 +0100 (BST)
Received: from AMDN5139.EU.corp.samsungelectronics.net (unknown
 [106.210.135.112]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230518140456eusmtip2023e687f6199f75263cfb553748b2f4c~gQeFXTQvP2811328113eusmtip2k;
 Thu, 18 May 2023 14:04:56 +0000 (GMT)
From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
To: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
Subject: [PATCH v8 0/7] igb: packet-split descriptors support
Date: Thu, 18 May 2023 16:04:41 +0200
Message-Id: <20230518140448.2001-1-t.dzieciol@partner.samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduzned1Og7QUg/VfjC0+n1rLbrHs0mcm
 i8b5c1gttl79wW5xvHcHi0XvphdMDmweJ94eZPW48Ogcs8eTa5uZPN7vu8rm0bdlFWMAaxSX
 TUpqTmZZapG+XQJXRsvCnywFzRwVPzYvZWxg3MLWxcjJISFgIrHhVh9rFyMXh5DACkaJY4/m
 sUE4Xxglrs/ZxQjhfGaUmDXlODtMy5wFX6ASyxklzqz+zALhtDNJHPu3kQWkik3ATOLRl3lA
 gzk4RASMJT62i4OEmQVSJY7+OQhWIixgK3Hmzk+woSwCqhLXpi4Hi/MKOEm0/pvJArFMXmLm
 pe/sEHFBiZMzn7BAzJGXaN46mxlkr4TATA6Jl4/PQ13nIvH0/Q1mCFtY4tXxLVBxGYn/O+cz
 QdjlEj/PbmOHaG5hlNgzdTJUkbXEpa0/wY5mFtCUWL9LHyLsKNE1/QwTSFhCgE/ixltBiBv4
 JCZtm84MEeaV6GgTgqjWkfi2aSYbRFhKYuGNOoiwh0Tv47OMILaQQKzEubUrWSYwKsxC8tgs
 JI/NQjhhASPzKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMAEc/rf8U87GOe++qh3iJGJ
 g/EQowQHs5IIb2BfcooQb0piZVVqUX58UWlOavEhRmkOFiVxXm3bk8lCAumJJanZqakFqUUw
 WSYOTqkGprZvzhPlZmosZVU4OStZZJvbkulpCTxHFN9wtNhm7ZW7VVP4Nix22e+SExwL7v67
 uerTF1f9rSXS7dftj8/hm3dmWYbo5Bcn1GQkLb4cmvhOnmfNnycXHhvntKoUu6/LblvYN0fu
 2dTT6j3cidyrNtye79XBfN9//6S9qmk1h2syV3KKhbz2PWK7q+fc5O8FGic2VS0vby983PBj
 rpOsvcKsnq7TzVWrTWqLlsr+mfFMc3XSt/ObjCZtac31vC5166HoypMqCRqZr/+f1JqzMvfS
 VsFXz/XVPrNwz/3Yz7Pi/tWPMgWFe1o12XzkZGeVrHOOvreoquOzzunzxzuXZ3U/f/Fho6Ha
 mvvipQ+kt7YrsRRnJBpqMRcVJwIAxLTwyZ8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsVy+t/xe7qdBmkpBn3PeCw+n1rLbrHs0mcm
 i8b5c1gttl79wW5xvHcHi0XvphdMDmweJ94eZPW48Ogcs8eTa5uZPN7vu8rm0bdlFWMAa5Se
 TVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJeRsvCnywF
 zRwVPzYvZWxg3MLWxcjJISFgIjFnwRfGLkYuDiGBpYwSy682QCWkJPb1/GeHsIUl/lzrYoMo
 amWS+LmpmRkkwSZgJvHoyzzWLkYODhEBU4lneyVBwswCmRKnX+0DmyMsYCtx5s5PsDksAqoS
 16YuZwGxeQWcJFr/zWSBmC8vMfPSd3aIuKDEyZlPWCDmyEs0b53NPIGRbxaS1CwkqQWMTKsY
 RVJLi3PTc4uN9IoTc4tL89L1kvNzNzECQ3vbsZ9bdjCufPVR7xAjEwfjIUYJDmYlEd7AvuQU
 Id6UxMqq1KL8+KLSnNTiQ4ymQPdNZJYSTc4HRldeSbyhmYGpoYmZpYGppZmxkjivZ0FHopBA
 emJJanZqakFqEUwfEwenVAPTKk6rHje3W3PaZbRZGG6fPOtWt0AoQHbDmierztfMa1VJWTp3
 IaMoWybT3cv7RHaJda6p5Qs93SQ+7U4+S2HxDv9DT2bLv5223mXP9F9bp345KvLHaP29JOmD
 GjX2G3ZYT4oImmewUbknyasiKuxnP0vKg8mFef0cB9va2n4vUPnbKcq52jtT3eO3R82bx/6/
 ImaeLVMJz6lK6t99O+DpgiDxT9d51mompq14eqHM4MuaxU1Xbt2u2BoQ52BlbsZy61PCkQ3X
 y5Smzdor0Pom6nd1TMucb/5NTgGnJev271XvnrP7Sfg2z/ivt/PVDd61+TP17CjiWqWeI7Mh
 WW/fxXzrWf38q26tXiOVrXZZiaU4I9FQi7moOBEAxhpBX/YCAAA=
X-CMS-MailID: 20230518140457eucas1p17f5acf26efb84441f8da0510ffd38bab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230518140457eucas1p17f5acf26efb84441f8da0510ffd38bab
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230518140457eucas1p17f5acf26efb84441f8da0510ffd38bab
References: <CGME20230518140457eucas1p17f5acf26efb84441f8da0510ffd38bab@eucas1p1.samsung.com>
Received-SPF: none client-ip=210.118.77.11;
 envelope-from=t.dzieciol@partner.samsung.com; helo=mailout1.w1.samsung.com
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Based-on: <20230423041833.5302-1-akihiko.odaki@daynix.com>
("[PATCH v3 00/47] igb: Fix for DPDK")

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

 hw/net/e1000e_core.c     |  78 ++--
 hw/net/igb_core.c        | 746 ++++++++++++++++++++++++++++-----------
 hw/net/igb_regs.h        |  20 +-
 hw/net/trace-events      |   6 +-
 tests/qtest/libqos/igb.c |   5 +
 5 files changed, 604 insertions(+), 251 deletions(-)

-- 
2.25.1


