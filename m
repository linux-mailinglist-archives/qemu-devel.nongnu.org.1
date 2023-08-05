Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36584770E93
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 09:52:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSC3r-0007sv-1A; Sat, 05 Aug 2023 03:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qSC3p-0007sN-7H
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 03:50:53 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qSC3n-0005DB-B6
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 03:50:52 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 959EE11EE06;
 Sat,  5 Aug 2023 07:50:49 +0000 (UTC)
From: ~hyman <hyman@git.sr.ht>
Date: Sat, 05 Aug 2023 07:50:49 +0000
MIME-Version: 1.0
Subject: [PATCH QEMU 0/3] provide a smooth upgrade solution for multi-queues
 disk
Message-ID: <169122184935.7839.16786323109706183366-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: ~hyman <yong.huang@smartx.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

A 1:1 virtqueue:vCPU mapping implementation for virtio-*-pci disk
introduced since qemu >=3D 5.2.0, which improves IO performance
remarkably. To enjoy this feature for exiting running VMs without
service interruption, the common solution is to migrate VMs from the
lower version of the hypervisor to the upgraded hypervisor, then wait
for the next cold reboot of the VM to enable this feature. That's the
way "discard" and "write-zeroes" features work.

As to multi-queues disk allocation automatically, it's a little
different because the destination will allocate queues to match the
number of vCPUs automatically by default in the case of live migration,
and the VMs on the source side remain 1 queue by default, which results
in migration failure due to loading disk VMState incorrectly on the
destination side. This issue requires Qemu to provide a hint that shows
multi-queues disk allocation is automatically supported, and this allows
upper APPs, e.g., libvirt, to recognize the hypervisor's capability of
this. And upper APPs can ensure to allocate the same num-queues on the
destination side in case of migration failure.

To fix the issue, we introduce the auto-num-queues property for
virtio-*-pci as a solution, which would be probed by APPs, e.g., libvirt
by querying the device properties of QEMU. When launching live
migration, libvirt will send the auto-num-queues property as a migration
cookie to the destination, and thus the destination knows if the source
side supports auto-num-queues. If not, the destination would switch off
by building the command line with "auto-num-queues=3Doff" when preparing
the incoming VM process. The following patches of libvirt show how it
roughly works:
https://github.com/newfriday/libvirt/commit/ce2bae2e1a6821afeb80756dc01f3680f=
525e506
https://github.com/newfriday/libvirt/commit/f546972b009458c88148fe079544db7e9=
e1f43c3
https://github.com/newfriday/libvirt/commit/5ee19c8646fdb4d87ab8b93f287c20925=
268ce83

The smooth upgrade solution requires the introduction of the auto-num-
queues property on the QEMU side, which is what the patch set does. I'm
hoping for comments about the series.

Please review, thanks.
Yong

Hyman Huang(=E9=BB=84=E5=8B=87) (3):
  virtio-scsi-pci: introduce auto-num-queues property
  virtio-blk-pci: introduce auto-num-queues property
  vhost-user-blk-pci: introduce auto-num-queues property

 hw/block/vhost-user-blk.c          |  1 +
 hw/block/virtio-blk.c              |  1 +
 hw/scsi/vhost-scsi.c               |  2 ++
 hw/scsi/vhost-user-scsi.c          |  2 ++
 hw/scsi/virtio-scsi.c              |  2 ++
 hw/virtio/vhost-scsi-pci.c         | 11 +++++++++--
 hw/virtio/vhost-user-blk-pci.c     |  9 ++++++++-
 hw/virtio/vhost-user-scsi-pci.c    | 11 +++++++++--
 hw/virtio/virtio-blk-pci.c         |  9 ++++++++-
 hw/virtio/virtio-scsi-pci.c        | 11 +++++++++--
 include/hw/virtio/vhost-user-blk.h |  5 +++++
 include/hw/virtio/virtio-blk.h     |  5 +++++
 include/hw/virtio/virtio-scsi.h    |  5 +++++
 13 files changed, 66 insertions(+), 8 deletions(-)

--=20
2.38.5

