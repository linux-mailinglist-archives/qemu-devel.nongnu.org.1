Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2593B80B8C5
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 05:07:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCB5L-0005Nc-UO; Sat, 09 Dec 2023 23:06:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCB54-0005Lb-W8
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:06:16 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCB52-00058h-Pr
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:06:14 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6d9fa8f6535so469258a34.0
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 20:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702181171; x=1702785971;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=voi+A61G/6HAMRyLGLve9tgdpJLV/B3rCn4d7KzHcfI=;
 b=cQuNcZkvseWjVC4TPzLjYmTXAjynjvFs5H37Nf+LRdPdgvxx/62gaDRDD8uoI6HPgl
 IgJ6z/b3D1YNDxj9mGZMMmfQtwQRW68iMPi/vKcRD9Hm//Vk85hc4zco2eIi2kd/f02b
 qR2Javj9k0Sh6NcGOJWBM79tEit8VGdWh02DysVpqIhN5uTqgj+UJdq8Qgc91c+Yj3Zb
 U0PH9PAAs/1WK4csKKbtXebUQEfD2XV57fq9ZdaneVkEf+VBN/KjVwV+q/5OxS5DFLLZ
 203F0HAgsKF5epeVWYXTzNFOvdQPLC7P2DET0l8F9q73oWM/DeLeUX1Be4uV2hBuHrzV
 el0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702181171; x=1702785971;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=voi+A61G/6HAMRyLGLve9tgdpJLV/B3rCn4d7KzHcfI=;
 b=ZciK1BJ0LLCZKosfaztpkY5YvYjY4llAMgfl2amrdhwDUJqGL1kcbI+ImlWn8JbQ4G
 7orzfh0Qx3dVO9UvfWbS8clqYnSCFhCpdYtadynvs65nuYzQyikg2AvOmdkRIbR3bUd2
 /A4QAv9aiQH6h94xiTJSRvgs+DnCnUGs9pX64Z8VOLQAQQSK0liCRcpMDJqGU7Wa/NT4
 LtHQs2GFcPmLZg+Th4xE/WRqA4zRpAUX4vOzw/xFw86NvZtL5cBPZDWUQk1qwHDCV6Nv
 fan0AYelMXoHd5EfjAdd/FAhOsG3BxG43kcTb4lqu2YAvy8Z8CDaC84qQ+cl7e/o/kue
 tf7w==
X-Gm-Message-State: AOJu0Yy3nOF4ZlRdW8bSmgzuAase/GFtvta7JaWP531+cHODzH96NtYB
 l+nTd4Q6PV+139crufqtwXKAkg==
X-Google-Smtp-Source: AGHT+IHYXiJUunET3r+Y371b0U+xvuAOu5tzjlweOW0t16Obja6EtYjlZ4VghM68Bohr3WpDLYRjUA==
X-Received: by 2002:a05:6358:881:b0:16b:fa26:3ad8 with SMTP id
 m1-20020a056358088100b0016bfa263ad8mr762255rwj.10.1702181170546; 
 Sat, 09 Dec 2023 20:06:10 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 n37-20020a634d65000000b005c21c23180bsm3953156pgl.76.2023.12.09.20.06.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 20:06:10 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RFC v2 00/12] virtio-net: add support for SR-IOV emulation
Date: Sun, 10 Dec 2023 13:05:43 +0900
Message-Id: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABc5dWUC/12MwQrCMBBEf6Xs2Uiy0VY9CYIf4FV6aJqN3YONJ
 BJaSv7dkKOXgTczvA0iBaYIl2aDQIkj+7kA7hoYp2F+kWBbGFCiViVEDOyTOB8kOoMtGjpB+X4
 COV6q5wmP+w36Uk4cvz6s1Z1Unf40SQkpNBp97KTrjG2vdlhnXvajf0Ofc/4B1GUve6AAAAA=
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::32c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Introduction
------------

This series is based on the RFC series submitted by Yui Washizu[1].
See also [2] for the context.

This series enables SR-IOV emulation for virtio-net. It is useful
to test SR-IOV support on the guest, or to expose several vDPA devices
in a VM. vDPA devices can also provide L2 switching feature for
offloading though it is out of scope to allow the guest to configure
such a feature.

The PF side code resides in virtio-pci. The VF side code resides in
the PCI common infrastructure, but it is restricted to work only for
virtio-net-pci because of lack of validation.

User Interface
--------------

A user can configure a SR-IOV capable virtio-net device by adding
virtio-net-pci functions to a bus. Below is a command line example:
  -netdev user,id=n -netdev user,id=o
  -netdev user,id=p -netdev user,id=q
  -device pcie-root-port,id=b
  -device virtio-net-pci,bus=b,addr=0x0.0x3,netdev=q,sriov-pf=f
  -device virtio-net-pci,bus=b,addr=0x0.0x2,netdev=p,sriov-pf=f
  -device virtio-net-pci,bus=b,addr=0x0.0x1,netdev=o,sriov-pf=f
  -device virtio-net-pci,bus=b,addr=0x0.0x0,netdev=n,id=f

The VFs specify the paired PF with "sriov-pf" property. The PF must be
added after all VFs. It is user's responsibility to ensure that VFs have
function numbers larger than one of the PF, and the function numbers
have a consistent stride.

Keeping VF instances
--------------------

A problem with SR-IOV emulation is that it needs to hotplug the VFs as
the guest requests. Previously, this behavior was implemented by
realizing and unrealizing VFs at runtime. However, this strategy does
not work well for the proposed virtio-net emulation; in this proposal,
device options passed in the command line must be maintained as VFs
are hotplugged, but they are consumed when the machine starts and not
available after that, which makes realizing VFs at runtime impossible.

As an strategy alternative to runtime realization/unrealization, this
series proposes to reuse the code to power down PCI Express devices.
When a PCI Express device is powered down, it will be hidden from the
guest but will be kept realized. This effectively implements the
behavior we need for the SR-IOV emulation.

Summary
-------

Patch [1, 5] refactors the PCI infrastructure code.
Patch [6, 10] adds user-created SR-IOV VF infrastructure.
Patch 11 makes virtio-pci work as SR-IOV PF for user-created VFs.
Patch 12 allows user to create SR-IOV VFs with virtio-net-pci.

[1] https://patchew.org/QEMU/1689731808-3009-1-git-send-email-yui.washidu@gmail.com/
[2] https://lore.kernel.org/all/5d46f455-f530-4e5e-9ae7-13a2297d4bc5@daynix.com/

Co-developed-by: Yui Washizu <yui.washidu@gmail.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Changed to keep VF instances.
- Link to v1: https://lore.kernel.org/r/20231202-sriov-v1-0-32b3570f7bd6@daynix.com

---
Akihiko Odaki (12):
      hw/pci: Initialize PCI multifunction after realization
      hw/pci: Determine if rombar is explicitly enabled
      hw/pci: Do not add ROM BAR for SR-IOV VF
      vfio: Avoid inspecting option QDict for rombar
      hw/qdev: Remove opts member
      pcie_sriov: Reuse SR-IOV VF device instances
      pcie_sriov: Release VFs failed to realize
      pcie_sriov: Ensure PF and VF are mutually exclusive
      pcie_sriov: Check PCI Express for SR-IOV PF
      pcie_sriov: Allow user to create SR-IOV device
      virtio-pci: Implement SR-IOV PF
      virtio-net: Implement SR-IOV VF

 docs/pcie_sriov.txt         |   8 +-
 include/hw/pci/pci.h        |   2 +-
 include/hw/pci/pci_device.h |  13 +-
 include/hw/pci/pcie_sriov.h |  25 ++-
 include/hw/qdev-core.h      |   4 -
 hw/core/qdev.c              |   1 -
 hw/net/igb.c                |   3 +-
 hw/nvme/ctrl.c              |   3 +-
 hw/pci/pci.c                |  98 +++++++-----
 hw/pci/pci_host.c           |   4 +-
 hw/pci/pcie.c               |   4 +-
 hw/pci/pcie_sriov.c         | 360 +++++++++++++++++++++++++++++++++-----------
 hw/vfio/pci.c               |   3 +-
 hw/virtio/virtio-net-pci.c  |   1 +
 hw/virtio/virtio-pci.c      |   7 +
 system/qdev-monitor.c       |  12 +-
 16 files changed, 395 insertions(+), 153 deletions(-)
---
base-commit: 4705fc0c8511d073bee4751c3c974aab2b10a970
change-id: 20231202-sriov-9402fb262be8

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


