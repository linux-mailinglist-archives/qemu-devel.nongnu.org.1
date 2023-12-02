Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CF1801B4F
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 09:03:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9Kvm-0004K4-Ec; Sat, 02 Dec 2023 03:00:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9KvT-0004Hm-LA
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:00:41 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9KvQ-0004vR-4N
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:00:35 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d048c171d6so12144085ad.1
 for <qemu-devel@nongnu.org>; Sat, 02 Dec 2023 00:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1701504029; x=1702108829;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tnX6Z12zqSN0J7SdKBlef8wbLoS0SpAxBo4zWGV6cw8=;
 b=NjMEJ8+ZMpAltv4M1XwDTjJuk7dx7oV/np1RGvqUWgkzsxzu8oiqzbUrbZ8jadVWpF
 LIsddYnzwTFqahzIW4gAGGQzuispcQYyweBy9/N9Z0ScEJ4ZoJnnlte34+Yaa5QwJauy
 Oxi4KsUA9nug8AcSCGTIHYpwlLz3mvCoeX8XPQp+DbTDksS1CBHwJA0KJk32aWAtHILy
 /kFGW88bOFUbkt9GouuKIP+ZgukIDd70rBUHqUn+BlFgeD5JO1KSsRCSCg29Uvqetpg7
 AfpBuIE0eerQzeueWSE2Tu014JSph7XZ/a2oMsfKjP0MxeUiJML92+SBxuxNA4VmcAX3
 8yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701504029; x=1702108829;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tnX6Z12zqSN0J7SdKBlef8wbLoS0SpAxBo4zWGV6cw8=;
 b=CJBbxrIEXyz4Uo0rUR26VFNPcZjZwlYG8Hal7CUoCWJ7qlSjWqNcKnGzCQ71LL0VJ8
 9kHmq2wTQx2Ntifi67p/nr9UNNVKeZ1swpBHwVIPpx1N20KBRiRYbDSwwAVdx+g2IfF3
 aln0168HxsiAlQRT7qMHU7r31Y6pbVtKAq19oX5vf+Uk1zJYKndSxHjJIBb9qDqcGEDR
 lvx21fq87gc1P2JD/Hy1OVKDH53Kp9wkaHkJOC/oz3c5vNwVZD61arqbU6Awuuxlter0
 CPt/2ZqQpJtghXkvhLr63cf5eCTi14JRRxvu4HcfodUKRQ+nl34l14DDHAQ7F321Fu+j
 39RQ==
X-Gm-Message-State: AOJu0Yw0eS9KOqmcEZRH73atrezHUo7N7+yLqB0QXjvb+EjXDa8dXJkT
 yVHQ5YJ+Rl3F3KG3pP0bYAicyw==
X-Google-Smtp-Source: AGHT+IHdMAz828vKWhFldAigxg+YLhLoVqpU8I3jnWQoT3sp3rmLkPY6uzuHsg1teXZAkVnD49yi2A==
X-Received: by 2002:a17:902:f544:b0:1d0:6ffd:9e1a with SMTP id
 h4-20020a170902f54400b001d06ffd9e1amr998016plf.108.1701504029534; 
 Sat, 02 Dec 2023 00:00:29 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 p12-20020a170902eacc00b001d075e847d5sm581686pld.44.2023.12.02.00.00.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Dec 2023 00:00:29 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 00/14] virtio-net: add support for SR-IOV emulation
Date: Sat, 02 Dec 2023 17:00:23 +0900
Message-Id: <20231202-sriov-v1-0-32b3570f7bd6@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABfkamUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDIKFbXJSZX6ZraWJglJZkZGaUlGqhBFRbUJSallkBNic6trYWAOI/Sa5
 XAAAA
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
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
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
to test SR-IOV support on the guest, or to expose several vDPA devices in a
VM. vDPA devices can also provide L2 switching feature for offloading
though it is out of scope to allow the guest to configure such a feature.

The new code of SR-IOV emulation for virtio-net actually resides in
virtio-pci since it's specific to PCI. Although it is written in a way
agnostic to the virtio device type, it is restricted for virtio-net because
of lack of validation.

User Interface
--------------

A user can configure a SR-IOV capable virtio-net device by adding
virtio-net-pci functions to a bus. Below is a command line example:
  -netdev user,id=n -netdev user,id=o -netdev user,id=p -netdev user,id=q
  -device virtio-net-pci,addr=0x0.0x3,netdev=q,sriov-pf=f
  -device virtio-net-pci,addr=0x0.0x2,netdev=p,sriov-pf=f
  -device virtio-net-pci,addr=0x0.0x1,netdev=o,sriov-pf=f
  -device virtio-net-pci,addr=0x0.0x0,netdev=n,id=f

The VFs specify the paired PF with "sriov-pf" property. The PF must be
added after all VFs. It is user's responsibility to ensure that VFs have
function numbers larger than one of the PF, and the function numbers have
a consistent stride.

Implementation Challenge
------------------------

The major problem with SR-IOV emulation is that it allows the guest to
realize and unrealize VFs at runtime, which means we cannot realize VFs at
initialization time and keep them. In this series, virtio-pci realizes VFs
at initialization time, but instead of keeping them, it extracts VF
configurations that are necessary to initialize the PF and device options
that will be used to realize VFs later, and unrealize them.

Retrieving Device Options
-------------------------

Usually device options are applied with property setters, and applied
options are bound to a particular device instance. It is problematic for
SR-IOV emulation because it recreates device instances at runtime. The
earlier RFC series[1] had no configurability because of this.
Looking at the code, I found there are currently two methods to retrieve
device options at initialization time, but both of them had downsides.

Existing Approach: DeviceState::opts
------------------------------------

One of them is to reading DeviceState::opts, which holds options except
"id", "bus", and "driver". However, this member of DeviceState is only used
by vfio to know the "rombar" option of pci-device is set and vfio shouldn't
do that in my opinion. DeviceState::opts is untyped, and it is
responsibility of pci-device to type the "rombar" property, but vfio reads
the untyped value in an intrusive way. There will be no usage of
DeviceState::opts If I eliminate this hacky usage, and keeping it only for
SR-IOV emulation of virtio-net is too much. As such, I determined
DeviceState::opts should be gone.

Existing Approach: DeviceListener::hide_device()
------------------------------------------------

The other method is to use DeviceListener::hide_device() callback. The
callback receives device options and decide *not* to realize the device
when a device is being added. virtio-net uses it to _hide_ the primary
device.

A downside of this approach is that it needs explicit registration.
virtio-net failover implementation only registers a DeviceListener after
a virtio-net device is added so it simply *ignores* the primary device
if it is added before the virtio-net device. It is better generate some
error message in such a situation at least.

Another problem of DeviceListener::hide_device() is that it is called for
all devices. For virtio-net failover, the primary device should be a
pci-device. For the SR-IOV emulation, the VF should be a virtio-pci.

Proposal: DeviceClass::hide()
-----------------------------

In this series, I propose DeviceClass:hide() as an alternative to
DeviceListener::hide_device(). A device that can be hidden implements this
function to decide whether it should be hidden. It requires no
registration, and encapsled in specific devices.

Summary
-------

Patch 1 will change the definition of "rombar" property of pci-device to
eliminate DeviceState::opts access in vfio. It will be used later to
generate an error if rombar is requested for SR-IOV VF.
Patch 2 removes DeviceState::opts.
Patch 3 adds DeviceClass::hide().
Patch 4 and 5 use DeviceClass::hide() to implement virtio-net failover.
Patch 6 removes DeviceListener::hide_device().
Patch [7, 11] makes trivial changes for SR-IOV emulation.
Patch 12 changes the common SR-IOV emulation code to accept device options.
Patch 13 adds the SR-IOV emulation code to virtio-pci.
Patch 14 enables the SR-IOV emulation code for virtio-net.

[1] https://patchew.org/QEMU/1689731808-3009-1-git-send-email-yui.washidu@gmail.com/
[2] https://lore.kernel.org/all/5d46f455-f530-4e5e-9ae7-13a2297d4bc5@daynix.com/

Co-developed-by: Yui Washizu <yui.washidu@gmail.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (14):
      vfio: Avoid inspecting option QDict for rombar
      hw/qdev: Remove opts member
      qdev: Add DeviceClass::hide()
      hw/pci: Add pci-failover
      virtio-net: Implement pci-failover
      qdev: Remove DeviceListener::hide_device()
      hw/pci: Add hide()
      qdev: Add qdev_device_new_from_qdict()
      hw/pci: Do not add ROM BAR for SR-IOV VF
      msix: Call pcie_sriov_vf_register_bar() for SR-IOV VF
      pcie_sriov: Release VFs failed to realize
      pcie_sriov: Allow to specify VF device options
      virtio-pci: add SR-IOV capability
      virtio-net: Add SR-IOV capability

 docs/pcie_sriov.txt            |   2 +-
 include/hw/pci/pci_device.h    |  21 +++++
 include/hw/pci/pcie_sriov.h    |  13 ++-
 include/hw/qdev-core.h         |  61 +++++-------
 include/hw/virtio/virtio-net.h |   3 +-
 include/hw/virtio/virtio-pci.h |   2 +
 include/monitor/qdev.h         |   2 +
 hw/core/qdev.c                 |  19 ----
 hw/net/igb.c                   |   2 +-
 hw/net/virtio-net.c            |  24 +----
 hw/nvme/ctrl.c                 |   2 +-
 hw/pci/msix.c                  |   8 +-
 hw/pci/pci.c                   |  61 +++++++++++-
 hw/pci/pcie_sriov.c            |  71 +++++++++++---
 hw/vfio/pci.c                  |   3 +-
 hw/virtio/virtio-net-pci.c     |  15 +++
 hw/virtio/virtio-pci.c         | 208 +++++++++++++++++++++++++++++++++++++++--
 system/qdev-monitor.c          |  49 +++++++---
 18 files changed, 442 insertions(+), 124 deletions(-)
---
base-commit: 4705fc0c8511d073bee4751c3c974aab2b10a970
change-id: 20231202-sriov-9402fb262be8

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


