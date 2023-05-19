Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5941E70A240
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 23:58:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q086m-0005xb-Cm; Fri, 19 May 2023 17:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q086k-0005wT-GT
 for qemu-devel@nongnu.org; Fri, 19 May 2023 17:57:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q086i-0004F8-OA
 for qemu-devel@nongnu.org; Fri, 19 May 2023 17:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684533471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SYwV4//niYK1yUOMeHy+0b1UysggeG/jkOQ4Fyqz0nU=;
 b=K96hY2PdCmcUYqrnd0vLwkISF7mv/GBGs8qfRnDJxBkJDovIEPVKEZbXN/GD++o9GDe7Qb
 WoDcxD6+krGkGQEuIwkQPd9KlL1Uy17qyOG2WssE3fnpXw4czxBQyeQTT0j+uKQkMy/Yn3
 QumxKgyb0e7C4ADqPdpFy9IWquMMpus=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-B9KkD4tDOceQrvN_1YTJEg-1; Fri, 19 May 2023 17:57:48 -0400
X-MC-Unique: B9KkD4tDOceQrvN_1YTJEg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BCFA3803518;
 Fri, 19 May 2023 21:57:48 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.10.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4E4BC0004B;
 Fri, 19 May 2023 21:57:47 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: robin@streamhpc.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com
Cc: Alex Williamson <alex.williamson@redhat.com>,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 0/4] vfio/pci: Atomic Ops completer support
Date: Fri, 19 May 2023 15:57:35 -0600
Message-Id: <20230519215739.402729-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This RFC proposes automatically enabling PCIe Atomic Ops completer
support on PCIe root ports within the VM given the restrictions that
a) vfio-pci provides a capability on the vfio device indicating enabled
support for various operations, and b) requiring a configuration of
installing the vfio-pci as a cold-plug device immediately downstream of
the root port, thus avoiding a secondary issue for enabling Atomic Ops
routing.  This idea was outlined in reply[1] to another proposal
suggesting manual device options to pcie-root-port to do the same.

This support depends on this[2] kernel patch enabling the host Atomic Op
reporting.

There are however some concerns with an automatic approach.  First is
the issue of hotplug.  If we've marked Atomic Ops completion as
supported by the root port and subsequently unplug the endpoint that was
the basis for that enablement, do we let that capability remain?  Should
the device exit function clear that capability?  Is it even legal to
clear capabilities on the root port at runtime?  I'm not sure it's safe
to assume that other devices on the same host would have similar
capabilities, but regardless, it's not safe to assume the VM is even
running on the same host for a subsequent hot-add.

We could potentially require the vfio-pci-nohotplug variant, but this
then becomes a usability barrier that not only do we require management
tools to pick the correct device flavor in QEMU, but we lose support for
things like unplugging a device for migration and re-plugging a
replacement on the target system.

Potentially the best solution might be to clear these capability bits in
the QEMU device exit function.  I don't know if the spec specifically
disallows this, but I suspect we could get away with it from a guest
perspective.

In a similar vein, the second concern is that PCIe slots are composable
in QEMU, ie. a user could create a multi-function device where the
Atomic Ops support between devices is in conflict.  The simple solution
would be to virtualize DEVCAP2 on the device to only report Atomic Ops
capabilities when supported by the host routing (which would also
simplify the hot-plug situation), but it does not appear to be common
practice for Linux in-kernel drivers to look at this register on the
endpoint.

Maybe the solution is that we only enable Atomic Ops on the root port
for a device iff the device is at slot address zero and the
multifunction bit is clear.  Additionally the device exit function
should remove the capabilities it has enabled.

I'll work on a v2 with these changes but discussion is welcome whether
such a solution would be acceptable.  Thanks,

Alex

[1]https://lore.kernel.org/all/20230518161309.369a5d6c.alex.williamson@redhat.com/
[2]https://lore.kernel.org/all/20230519214748.402003-1-alex.williamson@redhat.com/

Alex Williamson (4):
  linux-headers: Update for vfio capability reporting AtomicOps
  vfio: Implement a common device info helper
  pcie: Add a PCIe capability version helper
  vfio/pci: Enable AtomicOps completers on root ports

 hw/pci/pcie.c                 |  7 ++++
 hw/s390x/s390-pci-vfio.c      | 37 +++-----------------
 hw/vfio/common.c              | 46 ++++++++++++++++++------
 hw/vfio/pci.c                 | 66 +++++++++++++++++++++++++++++++++++
 include/hw/pci/pcie.h         |  1 +
 include/hw/vfio/vfio-common.h |  1 +
 linux-headers/linux/vfio.h    | 14 ++++++++
 7 files changed, 129 insertions(+), 43 deletions(-)

-- 
2.39.2


