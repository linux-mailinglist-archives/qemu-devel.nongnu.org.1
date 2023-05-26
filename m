Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F6B711F15
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 07:07:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Pef-0001xJ-A8; Fri, 26 May 2023 01:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@samsung.com>)
 id 1q2PeR-0001wY-V7
 for qemu-devel@nongnu.org; Fri, 26 May 2023 01:06:08 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@samsung.com>)
 id 1q2PeN-0001D0-JI
 for qemu-devel@nongnu.org; Fri, 26 May 2023 01:06:07 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20230526050553epoutp04d0f02fca7cf3d155eca8396a0b7e2016~imRtGRCHP1539115391epoutp04E
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 05:05:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20230526050553epoutp04d0f02fca7cf3d155eca8396a0b7e2016~imRtGRCHP1539115391epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1685077553;
 bh=Bled66rrj4FKi3XpyuK12JACVChZ/yGuH64147SAHMQ=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=tkKB0CuuyjUyYDxJBjgNl+OJCNg/lHPS52uXq+Mg2UGS5XknbLbA7T0/IzoIBXImE
 sieCH6maLjD92EYDPiD4WHSy3dsmqiWMtnbz5IGnfqAmJcStUrdXLb94s3j6i7sAgS
 LaXntlAA0d5ZD+dUHOQ8US8NdJUHjT1HqF/GysFc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20230526050552epcas2p20d16bcc40d79d231cd74a70e6946c596~imRszgdKI2305623056epcas2p24;
 Fri, 26 May 2023 05:05:52 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.70]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4QSCYW6dSFz4x9Pv; Fri, 26 May
 2023 05:05:51 +0000 (GMT)
X-AuditID: b6c32a46-b23fd7000001438d-33-64703e2f0dc1
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 25.42.17293.F2E30746; Fri, 26 May 2023 14:05:51 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 0/3] hw/ufs: Add Universal Flash Storage (UFS) support
From: Jeuk Kim <jeuk20.kim@samsung.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "kwolf@redhat.com" <kwolf@redhat.com>, "hreitz@redhat.com"
 <hreitz@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "fam@euphon.net" <fam@euphon.net>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, Klaus Birkelund Jensen <k.jensen@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230526050551epcms2p811ed2ba94fbe7600f811199727f4d0f0@epcms2p8>
Date: Fri, 26 May 2023 14:05:51 +0900
X-CMS-MailID: 20230526050551epcms2p811ed2ba94fbe7600f811199727f4d0f0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdljTVFffriDF4NskE4uXhzQtruw/z2jx
 4G4/o8XJxj2sFksuplrs3/aP1WLWu3Y2i+O9O1gcODx+nGtn83hybTOTx/t9V9k8+rasYgxg
 icq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6Qkmh
 LDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQ
 nfFhVk7BTe6KD3dfsjYw7uToYuTkkBAwkWiZf4Wpi5GLQ0hgB6PE/s/dbF2MHBy8AoISf3cI
 g9QIC7hJXFk8hxnEFhJQkJizrYMdIq4pMX39RCaQcjYBdYnTC81BwiICxhLHDi9hBhnJLNDB
 JHHi0EVmiF28EjPan7JA2NIS25dvZYSwNSR+LOuFqhGVuLn6LTuM/f7YfKgaEYnWe2ehagQl
 HvzcDRWXlDj17TErhD2dUWLBf1OQxRICCxglfjVPh2rQl7jWsRFsMa+Ar0R3z3mwBhYBVYlV
 D+9DDXKR6N01F8xmFpCX2P4W5GEOIFtTYv0ufRBTQkBZ4sgtFogKPomOw3/ZYd5q2PgbK3vH
 vCdMELaKxOLmw6wQY6QkNuwOncCoNAsRzrOQrJ2FsHYBI/MqRrHUguLc9NRiowIjeMwm5+du
 YgSnRi23HYxT3n7QO8TIxMF4iFGCg1lJhHdDTn6KEG9KYmVValF+fFFpTmrxIUZToIcnMkuJ
 JucDk3NeSbyhiaWBiZmZobmRqYG5kjivtO3JZCGB9MSS1OzU1ILUIpg+Jg5OqQYmD3VdCfVb
 j1I2WfeEzPT1FPKZepivlSnHaFeadSJPWFPKoQN37uz7Mumm/6oYz+szvgvf+pdm/PxIXIzn
 H2nXk58qXeZnpG4Jcsx2ss1yiLnhsP769dlnO0MPfJneoVuqIHhNPDmx971VgdUbl0UPNV+L
 yYn3SR4qvld6N/WAxfEzpUaaZy3b3F5eeqxZs73w4tvi/Y6rso037JQ5lBmh0OF9dtGxfv4a
 0QAnBvY9tecZ1upXyxzVLp6/LbH/nYJsGcN63opJyp0ndvs+Db5Z+uzgd7bJa019uJibN/5a
 6n0wfye70hTW8y2rBcU5V327sKPu96xC6bn2nw9n1u5pcaty/37C1v9/Vl7sJh8lluKMREMt
 5qLiRACekC5gFgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230526050551epcms2p811ed2ba94fbe7600f811199727f4d0f0
References: <CGME20230526050551epcms2p811ed2ba94fbe7600f811199727f4d0f0@epcms2p8>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=jeuk20.kim@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: jeuk20.kim@samsung.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This patch series adds support for a new PCI-based UFS device.

The UFS pci device id (PCI_DEVICE_ID_REDHAT_UFS) is not registered
in the Linux kernel yet, so it does not work right away, but I confirmed
that it works with Linux when the UFS pci device id is registered.

I have also verified that it works with Windows 10.

Jeuk Kim (3):
  hw/ufs: Initial commit for emulated Universal-Flash-Storage
  hw/ufs: Support for Query Transfer Requests
  hw/ufs: Support for UFS logical unit

 MAINTAINERS              |    6 +
 hw/Kconfig               |    1 +
 hw/meson.build           |    1 +
 hw/ufs/Kconfig           |    4 +
 hw/ufs/lu.c              | 1441 ++++++++++++++++++++++++++++++++++++
 hw/ufs/meson.build       |    1 +
 hw/ufs/trace-events      |   58 ++
 hw/ufs/trace.h           |    1 +
 hw/ufs/ufs.c             | 1511 ++++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs.h             |  130 ++++
 include/block/ufs.h      | 1251 +++++++++++++++++++++++++++++++
 include/hw/pci/pci.h     |    1 +
 include/hw/pci/pci_ids.h |    1 +
 include/scsi/constants.h |    1 +
 meson.build              |    1 +
 15 files changed, 4409 insertions(+)
 create mode 100644 hw/ufs/Kconfig
 create mode 100644 hw/ufs/lu.c
 create mode 100644 hw/ufs/meson.build
 create mode 100644 hw/ufs/trace-events
 create mode 100644 hw/ufs/trace.h
 create mode 100644 hw/ufs/ufs.c
 create mode 100644 hw/ufs/ufs.h
 create mode 100644 include/block/ufs.h

-- 
2.34.1


