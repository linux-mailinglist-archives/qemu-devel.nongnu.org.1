Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9BC713049
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 01:17:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2gfO-0004f0-9F; Fri, 26 May 2023 19:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q2gfL-0004eB-5x
 for qemu-devel@nongnu.org; Fri, 26 May 2023 19:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q2gfG-0007wy-As
 for qemu-devel@nongnu.org; Fri, 26 May 2023 19:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685142964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZArUHqYYAA0xFyEV/RQGm//aHVeDh6L3ztgQ2+/RhgQ=;
 b=WHCGdKD+P0w3HBDSdUYZd1Tr+TKJR5Ail61HTVXcVAWJf9VcrYatLiqF0zHjsVcjDR0K+f
 ZjpEktxUWOgUlx6c3ewAtfztoXix2YGIktWuQwR1BPrqhx9QharfIFYJu/0n0JIQHzEFPr
 FhYIFipCUZX0llKgzQhSNqPfnuaQqis=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-2jFC6ffYOZa0VlShGLwmVg-1; Fri, 26 May 2023 19:16:03 -0400
X-MC-Unique: 2jFC6ffYOZa0VlShGLwmVg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C78E31C04180;
 Fri, 26 May 2023 23:16:02 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.10.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4864F40C6CCC;
 Fri, 26 May 2023 23:16:01 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: robin@streamhpc.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 clg@redhat.com
Subject: [RFC PATCH v2 0/4] vfio/pci: Atomic Ops completer support
Date: Fri, 26 May 2023 17:15:54 -0600
Message-Id: <20230526231558.1660396-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This RFC proposes to allow a vfio-pci device to manipulate the PCI
Express capability of an associated root port to enable Atomic Op
completer support as equivalent to host capabilities.  This would
dynamically change capability bits in the config space of the root
port on realize and exit of the vfio-pci device under the following
condiations:

 - The vfio-pci device is directly connected to the root port and
   the root port implements a v2 PCIe capability, thereby supporting
   the DEVCAP2 register.

 - The vfio-pci device is exposed as a single-function device.

 - Atomic completer support is not otherwise reported on the root port.

 - The vfio-pci device reports the VFIO_DEVICE_INFO_CAP_PCI_ATOMIC_COMP
   capability with a non-zero set of supported atomic completer widths.

This proposal aims to avoid complications of reporting Atomic Ops
Routing, which can easily escalate into invalid P2P paths.  We also
require a specific VM configuration to avoid dependencies between
devices which may be sourced from dissimilar host paths.

While it's not exactly standard practice to modify root port device
capabilities runtime, it also does not seem to be precluded by the PCIe
Spec (6.0.1).  The Atomic Op completion bits of the DEVCAP2 register
are defined as Read-only:

7.4 Configuration Register Types
 Read-only - Register bits are read-only and cannot be altered by software.
             Where explicitly defined, these bits are used to reflect changing
             hardware state, and as a result bit values can be observed to
             change at run time. Register bit default values and bits that
             cannot change value at run time, are permitted to be hard-coded,
             initialized by system/device firmware, or initialized by hardware
             mechanisms such as pin strapping or nonvolatile storage.
             Initialization by system firmware is permitted only for system-
             integrated devices. If the optional feature that would Set the
             bits is not implemented, the bits must be hardwired to Zero.

Here "altered by software" is relative to guest writes to the config
space register, whereas in this implementation we're acting as hardware
and the bits are changing to reflect a change in runtime capabilities.
The spec does include a HwInit register type which would restrict the
value from changing at runtime outside of resets.  Therefore while it
would not be advised to update these bits arbitrarily, it does seem safe
and compatible with guest software to update the value on device attach
and detach.

Note that of the Linux in-kernel drivers that make use of Atomic Ops,
it's not common for the driver to test Atomic Ops support of the device
itself.  Support is assumed, therefore it's fruitless to provide masking
of support at the device rather than the root port.

Also, by allowing this dynamic support, enabling Atomic Ops becomes
transparent to VM management tools.  There is no requirement to
designate specific Atomic Ops capabilities to a root port and impose a
burden on other userspace utilities.

Feedback welcome.  Thanks,

Alex

v2:
 - Don't require cold-plug device, modify RP bits around realize/exit

Alex Williamson (4):
  linux-headers: Update for vfio capability reporting AtomicOps
  vfio: Implement a common device info helper
  pcie: Add a PCIe capability version helper
  vfio/pci: Enable AtomicOps completers on root ports

 hw/pci/pcie.c                 |  7 ++++
 hw/s390x/s390-pci-vfio.c      | 37 +++--------------
 hw/vfio/common.c              | 46 ++++++++++++++++-----
 hw/vfio/pci.c                 | 78 +++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h                 |  1 +
 include/hw/pci/pcie.h         |  1 +
 include/hw/vfio/vfio-common.h |  1 +
 linux-headers/linux/vfio.h    | 14 +++++++
 8 files changed, 142 insertions(+), 43 deletions(-)

-- 
2.39.2


