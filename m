Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 317FE80A545
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 15:19:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBbg6-0005pa-Cz; Fri, 08 Dec 2023 09:18:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1rBU34-0005VS-No
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 01:09:18 -0500
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1rBU31-0000FF-2Q
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 01:09:18 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20231208060904epoutp03785c5d17532f533cdd9651c176642cd3~exk0xq1kd2390623906epoutp03C
 for <qemu-devel@nongnu.org>; Fri,  8 Dec 2023 06:09:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20231208060904epoutp03785c5d17532f533cdd9651c176642cd3~exk0xq1kd2390623906epoutp03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1702015744;
 bh=plTBxFvLpkojV/trx8zbBPyUjvb2bjBuLuILPYmjkYI=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=UXsCBHLvfCSV/rjBx2aJKMciAV5Cr5CEmp+/nkS9U2QnPVkEtm6gLjr3KcUcqI3Hg
 oNeI60i8m6yHwwLu9IkyXiL/gIkRtotv2+VnbZhQTUCnkTljXa1z+Eb43VeHx3BurE
 O8gTJgi7zhHgyfNuGxpgSokaHZAX2T4DzTADrRPQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20231208060903epcas2p1378f8705222a119bf9b3a07ee75f7f5a~exk0Q-wix3055630556epcas2p1J;
 Fri,  8 Dec 2023 06:09:03 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.70]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4Smggy585pz4x9Q2; Fri,  8 Dec
 2023 06:09:02 +0000 (GMT)
X-AuditID: b6c32a47-bfdfa70000002726-58-6572b2fe57d2
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 F3.9E.10022.EF2B2756; Fri,  8 Dec 2023 15:09:02 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 0/3] Support for Zoned UFS
From: Daejun Park <daejun7.park@samsung.com>
To: "kwolf@redhat.com" <kwolf@redhat.com>, "hreitz@redhat.com"
 <hreitz@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "fam@euphon.net" <fam@euphon.net>, "thuth@redhat.com" <thuth@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
CC: Daejun Park <daejun7.park@samsung.com>, Seokhwan Kim
 <sukka.kim@samsung.com>, Yonggil Song <yonggil.song@samsung.com>, Jeuk Kim
 <jeuk20.kim@samsung.com>, JinHwan Park <jh.i.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba@epcms2p3>
Date: Fri, 08 Dec 2023 15:09:02 +0900
X-CMS-MailID: 20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmqe6/TUWpBk93a1i8PKRpsepBuMWV
 /ecZLR7c7We0uL/1GqNF/792FoslF1MtPjVIWezf9o/VYta7djaL4707WCxWdcxltFh5zMZi
 6vkjTA58Hj/OtbN5PLm2mcnj/b6rbB59W1YxBrBEZdtkpCampBYppOYl56dk5qXbKnkHxzvH
 m5oZGOoaWlqYKynkJeam2iq5+AToumXmAB2opFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFV
 Si1IySkwL9ArTswtLs1L18tLLbEyNDAwMgUqTMjO6NjVyFbwi7Vi9u0zzA2MR1i6GDk5JARM
 JJb8nMHYxcjFISSwg1Hi/JrbTF2MHBy8AoISf3cIg9QIC2hJPPjwnA3EFhJQklh/cRY7RFxP
 4tbDNYwgNpuAjsT0E/fZQeaICNxjkpi99i0biMMscIxRonVuFyvENl6JGe1PoTZLS2xfvpUR
 wtaQ+LGslxnCFpW4ufotO4z9/th8qBoRidZ7Z6FqBCUe/NwNFZeUuD13E1R9vsT/K8uh7BqJ
 bQfmQdn6Etc6NoLt5RXwlZg19TgTiM0ioCpx69VfqHtcJA5ceQc2n1lAXmL72znMoIBgFtCU
 WL9LH8SUEFCWOHKLBaKCT6Lj8F92mK8aNv7Gyt4x7wkThK0mse7neiaIMTISt+YxTmBUmoUI
 6FlI1s5CWLuAkXkVo1hqQXFuemqxUYExPG6T83M3MYKTqpb7DsYZbz/oHWJk4mA8xCjBwawk
 wptzPj9ViDclsbIqtSg/vqg0J7X4EKMp0MMTmaVEk/OBaT2vJN7QxNLAxMzM0NzI1MBcSZz3
 XuvcFCGB9MSS1OzU1ILUIpg+Jg5OqQYmoy/dvLmFv7MnavSckDzxtrJ2hYdiUweXX4rLQQOB
 f68SNl3kmfb03vFlLX1Wwbs1uU8y7WdP8jle/9drTYmg19E1Uq3F3hef3/6bLF/D2t32+oKW
 +uFsrzSxaZ6nTxQIuHHYOM0+em7rsrMuzPkWv+93Jv9/nPrkeeYrTQeRqvxOjzV3kwV7D97I
 bm/LSpu2abf0DsWiKwemBCvZ+YZJu1xd/pHnR3e8885vKdd5E3vXn47dbmrjn7uIxy+s665i
 c1e8IYNW0aJTfC87jFk+vlJWcVdreLoiMWbjs9fzzn968/UAv8qqrprjUWuub5HeKllUc+j7
 n+NGMlpJHJUujltO1mVdPd2w86nWWU0lluKMREMt5qLiRAAXeRw2MwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba
References: <CGME20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba@epcms2p3>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=daejun7.park@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 08 Dec 2023 09:17:29 -0500
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
Reply-To: daejun7.park@samsung.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This patch enables zoned support for UFS devices.
By applying this patch, a QEMU run can use parameters to configure whether
each LU of each UFS is zoned, and the capacity, size, and max open zones.
Zoned UFS is implemented by referencing ZBC2. 
(https://www.t10.org/members/w_zbc2.htm)

Daejun Park (3):
  hw/ufs: Support for Zoned UFS
  hw/scsi: add mode sense support for zbc device
  tests/qtest: Add tests for Zoned UFS

 hw/scsi/scsi-disk.c    |  13 +-
 hw/ufs/lu.c            | 616 +++++++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs.c           |   6 +-
 hw/ufs/ufs.h           |  32 +++
 include/block/ufs.h    |  31 +++
 tests/qtest/ufs-test.c | 178 ++++++++++++
 6 files changed, 870 insertions(+), 6 deletions(-)

-- 
2.25.1


