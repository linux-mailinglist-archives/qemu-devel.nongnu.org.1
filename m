Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B62AC737C8B
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 09:57:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBsh3-0003vH-HE; Wed, 21 Jun 2023 03:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@samsung.com>)
 id 1qBsgv-0003qq-3M
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 03:55:51 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@samsung.com>)
 id 1qBsgr-0001ve-TZ
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 03:55:48 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20230621075537epoutp035fa1d8d34de49e397a03e7c8621b64d7~qnXVLIn-c1717317173epoutp03Q
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 07:55:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20230621075537epoutp035fa1d8d34de49e397a03e7c8621b64d7~qnXVLIn-c1717317173epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1687334137;
 bh=J3MrmB9oYgiljPuXDcj1qliF1LUgLDwZNUzeLUe2imw=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=Mp7hZna5cPZk1nG3Bm+HC1wkdbEpYi5xI5K/eUS6MG/im5fb7aD+dUluBzUuuU15K
 t/31j5pU/NcRspVLF40JQjze6Da5KvxskN/H86GmmoEWbxwKu+KK/pzZqDoeI73UeW
 G3eoF1iilqEWBd+q1skpM45JWk83AS8bzXP2sePo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20230621075537epcas2p2bda01a01438e4e281501c3e2615a5eb6~qnXU2-r211899418994epcas2p2h;
 Wed, 21 Jun 2023 07:55:37 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.69]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4QmG5N1mCHz4x9Px; Wed, 21 Jun
 2023 07:55:36 +0000 (GMT)
X-AuditID: b6c32a48-87fff70000007e89-44-6492acf8272b
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 C1.43.32393.8FCA2946; Wed, 21 Jun 2023 16:55:36 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v3 0/3] hw/ufs: Add Universal Flash Storage (UFS) support
From: Jeuk Kim <jeuk20.kim@samsung.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "kwolf@redhat.com" <kwolf@redhat.com>, "hreitz@redhat.com"
 <hreitz@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "fam@euphon.net" <fam@euphon.net>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, Klaus Birkelund Jensen <k.jensen@samsung.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, Jeuk Kim
 <jeuk20.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230621075535epcms2p7fc17717fe677ab8a8b714607486b7b6a@epcms2p7>
Date: Wed, 21 Jun 2023 16:55:35 +0900
X-CMS-MailID: 20230621075535epcms2p7fc17717fe677ab8a8b714607486b7b6a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTVPfHmkkpBicfcllc2X+e0eLB3X5G
 i/tbrzFanGzcw2qx5GKqxf5t/1gtZr1rZ7M43ruDxeL1pP+sDpweP861s3k8ubaZyeP9vqts
 Hn1bVjEGsERl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6
 ZeYA3aKkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAv0CtOzC0uzUvXy0stsTI0
 MDAyBSpMyM7ouHiRpeA0b8X79S2MDYxfOLsYOTkkBEwkZn1awdzFyMUhJLCDUWLP8r3sXYwc
 HLwCghJ/dwiDmMICnhLXjomClAsJKEjM2dbBDmILC2hKTF8/kQmkhE1AXeL0QnOQsIiAscSx
 w0vAJjIL3GGSaDh/iBViFa/EjPanLBC2tMT25VsZIWwNiR/LepkhbFGJm6vfssPY74/Nh6oR
 kWi9dxaqRlDiwc/dUHFJiVPfHkPNn84oseC/KchiCYEFjBK/mqdDNehLXOvYCLaYV8BXou9S
 L9gCFgFViVOftzBB1LhIbJz0C6yeWUBeYvvbOcwgjzEDPbl+lz6IKSGgLHHkFgtEBZ9Ex+G/
 7DBv7Zj3BGqKisTi5sOsEOVSEht2h0KYHhJPvytAAjBQYtOGKawTGBVmIUJ5FpKtsxC2LmBk
 XsUollpQnJueWmxUYAKP2OT83E2M4CSp5bGDcfbbD3qHGJk4GA8xSnAwK4nwBu3tSxHiTUms
 rEotyo8vKs1JLT7EaAr070RmKdHkfGCaziuJNzSxNDAxMzM0NzI1MFcS5zV81psiJJCeWJKa
 nZpakFoE08fEwSnVwHQosMUrSnPa7f2XbppZvUjZ88joxG6TnV9OH/i6X2DPart7kYzCR71P
 eIjeeauyRI/5e7m+zIESr2Q+D4PDSWtjl2rwhFed+c2kJXjjX9XfddK3fu+zmrSl+ImM8dpt
 3CFcBlYcUitnr15lnbDAi4vD80DxU+d0jjtqV7Sifscevbblr7vLle9PG5snu1n1neBdM1v3
 4tPlOW/z3kYzqz88VTfl9YlMqeVV90Ku2jJti5vLv9VrsrZQyjmLlzJLc2wbvVMaBZWaWrSe
 2p829z40u6isX+H39uLITc8TdcwSNOaFMjeWV57OW8NkG2hoqbVA0ofJa9bf8ym7A5nUZvMu
 imFjrt90TMFVV2X9fyWW4oxEQy3mouJEAJFKhP8bBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230621075535epcms2p7fc17717fe677ab8a8b714607486b7b6a
References: <CGME20230621075535epcms2p7fc17717fe677ab8a8b714607486b7b6a@epcms2p7>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=jeuk20.kim@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Since v2:
Addressed review comment from Stefan Hajnoczi. The main fixes are as follows.
- Use of SPDX licence identifiers
- fixed endianness error
- removed memory leak
- fixed DMA error handling logic


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
 docs/specs/pci-ids.rst   |    2 +
 hw/Kconfig               |    1 +
 hw/meson.build           |    1 +
 hw/ufs/Kconfig           |    4 +
 hw/ufs/lu.c              | 1441 +++++++++++++++++++++++++++++++++++
 hw/ufs/meson.build       |    1 +
 hw/ufs/trace-events      |   59 ++
 hw/ufs/trace.h           |    1 +
 hw/ufs/ufs.c             | 1545 ++++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs.h             |  131 ++++
 include/block/ufs.h      | 1048 ++++++++++++++++++++++++++
 include/hw/pci/pci.h     |    1 +
 include/hw/pci/pci_ids.h |    1 +
 include/scsi/constants.h |    1 +
 meson.build              |    1 +
 16 files changed, 4244 insertions(+)
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


