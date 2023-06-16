Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA422732831
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 08:59:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA3Pq-0005mx-Da; Fri, 16 Jun 2023 02:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@samsung.com>)
 id 1qA3Pn-0005mI-6g
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 02:58:35 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@samsung.com>)
 id 1qA3Pi-0003uG-6N
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 02:58:34 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20230616065818epoutp04049722b171e4e95bee42253e5a636f85~pEW3HWF5O2921129211epoutp04S
 for <qemu-devel@nongnu.org>; Fri, 16 Jun 2023 06:58:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20230616065818epoutp04049722b171e4e95bee42253e5a636f85~pEW3HWF5O2921129211epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1686898698;
 bh=RxGYrgVRkzjOO/SsxvyEPKNzopiSDoHglnyKJlYmbBY=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=JCOnOwOsHKsA/oxCrgC7FCNdOzRhhUo3Vf3Og2qfl6e6fDupspy+Z6ApU/pATjV2V
 r5rM+heTzcVcr5X0omSRH2+aRcNkISXJaBnzMR9XeLF3FVtG+7HglOWF/yn3xaCvEo
 3idfcHyuXbW2bV+w6Onl9ZGQtAByGaIA04Aar5m4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20230616065818epcas2p3900437ec62da02fac3bc3bbc3b8dcc72~pEW2qstDK1613416134epcas2p3H;
 Fri, 16 Jun 2023 06:58:18 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.91]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4Qj93X5Nk6z4x9QD; Fri, 16 Jun
 2023 06:58:16 +0000 (GMT)
X-AuditID: b6c32a45-445fd70000022cba-15-648c0808940e
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 F4.20.11450.8080C846; Fri, 16 Jun 2023 15:58:16 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 0/3] hw/ufs: Add Universal Flash Storage (UFS) support
From: Jeuk Kim <jeuk20.kim@samsung.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "kwolf@redhat.com" <kwolf@redhat.com>, "hreitz@redhat.com"
 <hreitz@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "fam@euphon.net" <fam@euphon.net>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, Klaus Birkelund Jensen <k.jensen@samsung.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230616065816epcms2p82787f1aeb410ec4b8ab6ffedb6edf4d2@epcms2p8>
Date: Fri, 16 Jun 2023 15:58:16 +0900
X-CMS-MailID: 20230616065816epcms2p82787f1aeb410ec4b8ab6ffedb6edf4d2
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdljTXJeDoyfF4NMrLYuXhzQtruw/z2jx
 4G4/o8XJxj2sFksuplrs3/aP1WLWu3Y2i+O9O1gsXk/6z+rA6fHjXDubx5Nrm5k83u+7yubR
 t2UVYwBLVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+Arltm
 DtApSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL281BIrQwMD
 I1OgwoTsjLkL3zEVrOWpeNR0jrGBsYGzi5GTQ0LARGJu3yzmLkYuDiGBHYwSHzfuZeti5ODg
 FRCU+LtDGKRGWMBT4u3/Z8wgtpCAgsScbR3sEHFNienrJzKBlLMJqEucXmgOEhYRMJY4dngJ
 2Ehmge1MEufnHWSC2MUrMaP9KQuELS2xfflWRghbQ+LHsl5mCFtU4ubqt+ww9vtj86FqRCRa
 752FqhGUePBzN1RcUuLUt8esEPZ0RokF/01BFksILGCU+NU8HapBX+Jax0awxbwCvhI33y8A
 i7MIqErM/vgWapCLxKut88HizALyEtvfzmEGeYwZ6Mn1u/RBTAkBZYkjt1ggKvgkOg7/ZYd5
 q2Hjb6zsHfOeQL2uIrG4+TArxBgpiQ27QycwKs1ChPMsJGtnIaxdwMi8ilEstaA4Nz212KjA
 EB61yfm5mxjBaVLLdQfj5Lcf9A4xMnEwHmKU4GBWEuFddqIrRYg3JbGyKrUoP76oNCe1+BCj
 KdDDE5mlRJPzgYk6ryTe0MTSwMTMzNDcyNTAXEmcV9r2ZLKQQHpiSWp2ampBahFMHxMHp1QD
 067Nxjf7TjkJci5IYud2O8fteXvRx6U1hdqb9jrr6h9ivbPW7pLcjENtvHuUZ+x+JT/FbPZz
 advn53fZzH2g1rxUQ1z7W9zjhcc7/q1kTnX6IfhHY0nHItmmr1vzfSZPkpBwk7Q798l6IU9B
 n+b8hPB/7csThFau7I4yP3b73ImVl5rN9BVfOUwUuVyiavI09URU8sLsH/nlty78NJnq88FS
 /a9znmBJlIDCpNPcnFfCpm2e7ZnAKjz3wT6D3U59j37PMJ7N6BlYaX2Z5a/6fR2Vt98Tvp/X
 2L+Mx/epOO+9TZm/3v2YK/rZQs9Mmdk81OW93j05cQfzp5czdZPVBHZ8ONl+vVnowmQ35swY
 ViWW4oxEQy3mouJEADGQt38cBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230616065816epcms2p82787f1aeb410ec4b8ab6ffedb6edf4d2
References: <CGME20230616065816epcms2p82787f1aeb410ec4b8ab6ffedb6edf4d2@epcms2p8>
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

Since v1:
- use macros of "hw/registerfields.h" (Addressed Philippe's review comments)

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
 include/block/ufs.h      | 1048 ++++++++++++++++++++++++++
 include/hw/pci/pci.h     |    1 +
 include/hw/pci/pci_ids.h |    1 +
 include/scsi/constants.h |    1 +
 meson.build              |    1 +
 15 files changed, 4206 insertions(+)
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

