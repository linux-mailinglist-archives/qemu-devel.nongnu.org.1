Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D556710FC9
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 17:39:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2D2M-0003NC-KM; Thu, 25 May 2023 11:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q2D2G-0003I6-UZ
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:37:52 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1q2D2E-0000mS-Kw
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:37:52 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20230525153743euoutp01a37f03c3a0440b144640c7d9c5aab22a~ibQGETT3r3201932019euoutp01k
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 15:37:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20230525153743euoutp01a37f03c3a0440b144640c7d9c5aab22a~ibQGETT3r3201932019euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1685029063;
 bh=He01n4nCkrCZ6PbiB+L7TuBQM/wdp5mBObnzox/BmUU=;
 h=From:To:Cc:Subject:Date:References:From;
 b=NGzNUEl3+GSVPEKXCZbmE+d1FL4FZPWuUG3obx68g3FV4weL0rq8WWre6Jc4GcfUL
 QxxROVQJ7nzBAvAhyUTu/TYQC/BZlv+c3d2H9vxQyr8DDJ27qrrXdVaho8cYksHujF
 6csygmDTKKXCQn0HNPrMDC8qAxFU66ycRZJpnhp8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230525153743eucas1p2a3e2a220c9e28e6fd56d1df303865831~ibQF7JxgV2952929529eucas1p2L;
 Thu, 25 May 2023 15:37:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 8C.28.11320.7C08F646; Thu, 25
 May 2023 16:37:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20230525153743eucas1p145858f3572c2d53687377a4e879d1e0b~ibQFQgrgq1853818538eucas1p1V;
 Thu, 25 May 2023 15:37:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230525153742eusmtrp16f48bdf165a703fd0469cbcbe0354f93~ibQFP9rUE0099000990eusmtrp1M;
 Thu, 25 May 2023 15:37:42 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-d3-646f80c7d055
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 38.C4.10549.6C08F646; Thu, 25
 May 2023 16:37:42 +0100 (BST)
Received: from AMDN5139.EU.corp.samsungelectronics.net (unknown
 [106.210.135.112]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230525153742eusmtip2ebafca45475154658f6f850d8356a59a~ibQEsJ-aY1912419124eusmtip2P;
 Thu, 25 May 2023 15:37:42 +0000 (GMT)
From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
To: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
Subject: [PATCH v9 0/7] igb: packet-split descriptors support
Date: Thu, 25 May 2023 17:37:26 +0200
Message-Id: <20230525153733.4104-1-t.dzieciol@partner.samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZduzned3jDfkpBv+2q1h8PrWW3WLZpc9M
 Fo3z57BabL36g93ieO8OFoveTS+YHNg8Trw9yOpx4dE5Zo8n1zYzebzfd5XNo2/LKsYA1igu
 m5TUnMyy1CJ9uwSujJ1vbjAWfOCoONh7lbmBcQJ7FyMnh4SAicTOm+fZuhi5OIQEVjBK7H35
 mRnC+cIosa7lBCOE85lR4t7nXywwLet7loPZQgLLGSVW9qlAFLUzSXxcNI8RJMEmYCbx6Ms8
 1i5GDg4RAWOJj+3iIGFmgVSJo38OgvUKC9hKLNvwGKycRUBV4mDTRzCbV8BJ4vOXE1C75CVm
 XvrODhEXlDg58wkLxBx5ieats8EulRCYySGxYet/VogGF4nO3c/YIGxhiVfHt0D9KSNxenIP
 1NByiZ9nt7FDNLcwSuyZOhmqyFri0tafYEczC2hKrN+lD2JKCDhKfG4VhDD5JG68FYQ4gU9i
 0rbpzBBhXomONiGIGToS3zbNZIMIS0ksvFEHEfaQmLbmBwtIWEggVmLO+tQJjAqzkLw1C8lb
 sxAOWMDIvIpRPLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMwtZz+d/zLDsblrz7qHWJk4mA8
 xCjBwawkwrshJz9FiDclsbIqtSg/vqg0J7X4EKM0B4uSOK+27clkIYH0xJLU7NTUgtQimCwT
 B6dUA9OaUPlfs9gP3p+dr291bS+Hq7VJwWqVuzZG73+fn79KLkfJ5Njz4Kt/+R7fXSH+89+X
 6ebHSt3ZP8x/p/vrQG5GpJaosWN82xyHyqNpTCm8+x5kZRpyuHw4q3NuvuyfltT666FNky9O
 zmf/73XCQuNAb0Lvsu6NHGc91u5SDzk4ufphVazDkkPsiztDHauknI0VTZNtI2ctsgrx+3B+
 0jQNhikxDBrnmERY7pdc9pjxU2+P8OeHE84XxJlyhp1j/HK+Use5WfnK1WjFWN9kx6v3Et/J
 NDnb/fybdWOtW3724TRtK5+vhimBkwzmfrZO2NGYNa+rXVSSyY9T54zMzW6W1MKVFbeUz0W5
 HVj4XImlOCPRUIu5qDgRAF9gLu2cAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsVy+t/xe7rHGvJTDHr2m1t8PrWW3WLZpc9M
 Fo3z57BabL36g93ieO8OFoveTS+YHNg8Trw9yOpx4dE5Zo8n1zYzebzfd5XNo2/LKsYA1ig9
 m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jJ1vbjAW
 fOCoONh7lbmBcQJ7FyMnh4SAicT6nuUsXYxcHEICSxkl9t9vh0pISezr+Q9lC0v8udbFBmIL
 CbQySdxaJAxiswmYSTz6Mo+1i5GDQ0TAVOLZXkmQMLNApsTpV/vAyoUFbCWWbXjMCGKzCKhK
 HGz6CGbzCjhJfP5yggVivLzEzEvf2SHighInZz5hgZgjL9G8dTbzBEa+WUhSs5CkFjAyrWIU
 SS0tzk3PLTbUK07MLS7NS9dLzs/dxAgM7G3Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeDfk5KcI
 8aYkVlalFuXHF5XmpBYfYjQFum8is5Rocj4wtvJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTS
 E0tSs1NTC1KLYPqYODilGpgiDJx6/r+wX7P2nc3n/VXySb/aT1RY7vpe91vXb1aJygnjJU2P
 bc49yLA1Xhb54EDIpu9lMbNP3f4meveS26Ns4S3XgjZEfJdp2evdlbqhXMRLz6hzaW71T+Mn
 x/WnTD4x496nTv5vtmY/lvQGeOycb/rggP/EJTIR8fwlKds9tcTLXrtYzr2UI32MWyq182Lb
 BokH7RO2zLuxpp/1868FfDMVrOKKuG+syiq08H2l7q6qeZ7RwkjxrXvkPtVHieF2cjk/PLbm
 /EnRXb6ly4z7grLoa5Ystnksn/ZxS+zdrr3DSWaV4/msI4a1F549OH9ObKvYInPG1ekv/Hdn
 aGSbBOeZKK6T+1rXyONr/VSJpTgj0VCLuag4EQD+bqsU9QIAAA==
X-CMS-MailID: 20230525153743eucas1p145858f3572c2d53687377a4e879d1e0b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230525153743eucas1p145858f3572c2d53687377a4e879d1e0b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230525153743eucas1p145858f3572c2d53687377a4e879d1e0b
References: <CGME20230525153743eucas1p145858f3572c2d53687377a4e879d1e0b@eucas1p1.samsung.com>
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

Based-on: <20230523024339.50875-1-akihiko.odaki@daynix.com>
("[PATCH v5 00/48] igb: Fix for DPDK")

Purposes of this series of patches:
* introduce packet-split RX descriptors support. This feature is used by Linux
  VF driver for MTU values from 2048.
* refactor RX descriptor handling for introduction of packet-split RX
  descriptors support
* fix descriptors flags handling

In addition to comments from previous review endianess issues in
igb_write_adv_ps_rx_descr were fixed.

Tomasz Dzieciol (7):
  igb: remove TCP ACK detection
  igb: rename E1000E_RingInfo_st
  igb: RX descriptors guest writting refactoring
  igb: RX payload guest writting refactoring
  igb: add IPv6 extended headers traffic detection
  igb: packet-split descriptors support
  e1000e: rename e1000e_ba_state and e1000e_write_hdr_to_rx_buffers

 hw/net/e1000e_core.c     |  78 +++--
 hw/net/igb_core.c        | 740 ++++++++++++++++++++++++++++-----------
 hw/net/igb_regs.h        |  20 +-
 hw/net/trace-events      |   6 +-
 tests/qtest/libqos/igb.c |   5 +
 5 files changed, 602 insertions(+), 247 deletions(-)

-- 
2.25.1


