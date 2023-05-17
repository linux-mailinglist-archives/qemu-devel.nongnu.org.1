Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC47F706D31
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:49:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJND-0004j9-OA; Wed, 17 May 2023 11:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1pzJN0-0004fj-OC
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:47:19 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1pzJMw-0004f9-Jd
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:47:17 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20230517154708euoutp02ca0336b9adfb7444006660be41f4b0e2~f_OBzIGY00526605266euoutp02Y
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 15:47:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20230517154708euoutp02ca0336b9adfb7444006660be41f4b0e2~f_OBzIGY00526605266euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1684338428;
 bh=1r42ZLmEIdETKMiR78Uz4iFLyS1NYwb51A2ysIaD7aE=;
 h=From:To:Cc:Subject:Date:References:From;
 b=A95KG40h1+dKw+PKTCSQLujD5JaWosPy4aTgk7A+TfwO9qn36bXDNhh0JZYCNZMn1
 JaxNRRld6v+6ljuO1kl92BhWWbZApAfABBMOQQD6UTqlKQwUCmf1CPt+qIIL3q4Fct
 4JJxe67s+vDslIk2J+PNCho8T+EW1nfvNf41SmcE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230517154708eucas1p162fd50c1e5011d6fa2cc5ba2705e4cd5~f_OBmI2qk2624726247eucas1p1V;
 Wed, 17 May 2023 15:47:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id D2.DD.42423.CF6F4646; Wed, 17
 May 2023 16:47:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20230517154707eucas1p17bfd3bbcece98f1eb900e75d09983169~f_OBRAc0b2624726247eucas1p1U;
 Wed, 17 May 2023 15:47:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230517154707eusmtrp17633d064e864b9ecaa6c93356372b39a~f_OBQae112897228972eusmtrp1F;
 Wed, 17 May 2023 15:47:07 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-45-6464f6fce9a6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id BC.07.10549.BF6F4646; Wed, 17
 May 2023 16:47:07 +0100 (BST)
Received: from AMDN5139.EU.corp.samsungelectronics.net (unknown
 [106.210.135.112]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230517154707eusmtip2be21e67ffe9d377f5386b6d69ed93102~f_OAud73k1593615936eusmtip2h;
 Wed, 17 May 2023 15:47:07 +0000 (GMT)
From: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
To: qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
Subject: [PATCH v7 0/7] igb: packet-split descriptors support
Date: Wed, 17 May 2023 17:46:55 +0200
Message-Id: <20230517154702.4215-1-t.dzieciol@partner.samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduzned0/31JSDO5e4bP4fGotu8WyS5+Z
 LBrnz2G12Hr1B7vF8d4dLBa9m14wObB5nHh7kNXjwqNzzB5Prm1m8ni/7yqbR9+WVYwBrFFc
 NimpOZllqUX6dglcGTf+HmEvaOaomHh0OnsD4xa2LkZODgkBE4nZ8/YB2VwcQgIrGCVmXPjE
 DOF8YZQ40/SKCcL5zCjx9cp+RpiWQ10vWSESyxkl3uyfCZYQEmhnkpjwjgnEZhMwk3j0ZR5Q
 EQeHiICxxMd2cZAws0CqxNE/B1lAbGEBW4nDrRfAylkEVCW2rTnFCmLzCjhJ9F/exw6xS15i
 5qXv7BBxQYmTM5+wQMyRl2jeOhvsUgmBmRwScx8+YAHZJSHgIrGuvw6iV1ji1fEtUHNkJE5P
 7mGBsMslfp7dxg7R28IosWfqZKgia4lLW3+C3cwsoCmxfpc+RNhR4umuHnaI8XwSN94KQpzA
 JzFp23RmiDCvREebEES1jsS3TTPZIMJSEgtvQB3jIdG86iUzJJxiJQ7vPc88gVFhFpK/ZiH5
 axbCCQsYmVcxiqeWFuempxYb5qWW6xUn5haX5qXrJefnbmIEJpfT/45/2sE499VHvUOMTByM
 hxglOJiVRHgD+5JThHhTEiurUovy44tKc1KLDzFKc7AoifNq255MFhJITyxJzU5NLUgtgsky
 cXBKNTAVTlCYOzUhSdV16u0LPfIz/mlfqzjdknBzV3GdVk/+MZPU64tSWowYA+422z3VKmnl
 ipx3L0QzyeDvmQ9chyWEynl59z5+Nv3M90jJO97y7WzHH07bnJ/bqtaTkpzJvVfI45b7oUcM
 DRs1WvdG6R038j0xp/1mvTHLbtHlq931rl8K/8TEznHcUM9BcqZd3/917/8IKGktuHtUmNf0
 PF9tg/5RgZn9PRIbGu+vmeDpdmTb/GW/D5y0ezNh8YKQLqeyHX9Fr+lcD7P0mbq5fEmP59U/
 jMrzwmTviK263y73smF1+5nS/588WVvOzGsTElmw5rC7X9aJE4s7Ay/k6FiuKwhSf6hzO+1S
 nZDJ4lglluKMREMt5qLiRABJCq6LnQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsVy+t/xe7q/v6WkGJw6Ymbx+dRadotllz4z
 WTTOn8NqsfXqD3aL4707WCx6N71gcmDzOPH2IKvHhUfnmD2eXNvM5PF+31U2j74tqxgDWKP0
 bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mm78PcJe
 0MxRMfHodPYGxi1sXYycHBICJhKHul6ydjFycQgJLGWU2PNnLgtEQkpiX89/dghbWOLPtS42
 iKJWJondu6YwgiTYBMwkHn2ZB9TNwSEiYCrxbK8kSJhZIFPi9Kt9YAuEBWwlDrdeYAKxWQRU
 JbatOcUKYvMKOEn0X94HNV9eYual7+wQcUGJkzOfsEDMkZdo3jqbeQIj3ywkqVlIUgsYmVYx
 iqSWFuem5xYb6hUn5haX5qXrJefnbmIEhva2Yz8372Cc9+qj3iFGJg7GQ4wSHMxKIryBfckp
 QrwpiZVVqUX58UWlOanFhxhNge6byCwlmpwPjK68knhDMwNTQxMzSwNTSzNjJXFez4KORCGB
 9MSS1OzU1ILUIpg+Jg5OqQYmfw7thByOje7tCSXLv+/X2/bnr4Z3Se/je1rs0yIv5UrcbL9V
 O1VQUZT9etZ9I7XAO6mcQXla/7eeZjRfPNPWhuvOzmTJFy9vuR71sd+255hPUIbLs1+8TPHb
 AwUkX9WJOa5+Iagtv3KjuWkwE9+r9wc1i8rd+v+oOFhznFlXLyVtfS7+j7acZZqoOW9y4/K7
 H8zjfu28sMdTosMvOnb/1KIJvh8yDST14tkuMi7+dzr2ikpBipxVxf+NVXffKLSs1LPaNush
 L2NFnfOmhEtyR7yWr7xyOubXjfzlrZfu+i/8fYvv94SmOe8b3mVF1Nu6V+skRv2YuK/h5tm3
 V1tC/Hc9SrpbX+Px/W4G80olluKMREMt5qLiRAD48NKK9gIAAA==
X-CMS-MailID: 20230517154707eucas1p17bfd3bbcece98f1eb900e75d09983169
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230517154707eucas1p17bfd3bbcece98f1eb900e75d09983169
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230517154707eucas1p17bfd3bbcece98f1eb900e75d09983169
References: <CGME20230517154707eucas1p17bfd3bbcece98f1eb900e75d09983169@eucas1p1.samsung.com>
Received-SPF: none client-ip=210.118.77.12;
 envelope-from=t.dzieciol@partner.samsung.com; helo=mailout2.w1.samsung.com
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
 hw/net/igb_core.c        | 744 ++++++++++++++++++++++++++++-----------
 hw/net/igb_regs.h        |  20 +-
 hw/net/trace-events      |   6 +-
 tests/qtest/libqos/igb.c |   5 +
 5 files changed, 602 insertions(+), 251 deletions(-)

-- 
2.25.1


