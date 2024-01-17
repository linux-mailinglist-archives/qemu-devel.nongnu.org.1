Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E968A830202
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 10:17:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ21u-0008ND-PF; Wed, 17 Jan 2024 04:16:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQ21r-0008Mj-9V
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 04:16:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQ21p-0006Ym-FR
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 04:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705482967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tdidY4U1kB1Pcgq6ZR20pmVRFxtkVA7yLHgAwGZ/jIQ=;
 b=UKUC7fycT0r9UCcViHw5mbri5K28gTOJZ3tJv8KGz/KpwV79B7qw6yv4T2koo101xBtTxk
 1ywSBHFcI/VNYfZ+9ZhJM5b7+B1d6QV0mCMbELn81H6mTn+OEKzYnCt8gruvW5Dwf027Zt
 jJiO+1PxOQTCk2MFTVEozhry80CelTo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-As1APFfRMlm6UUYKALpVUQ-1; Wed,
 17 Jan 2024 04:16:05 -0500
X-MC-Unique: As1APFfRMlm6UUYKALpVUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E70F38135F5
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 09:16:05 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DD762166B32;
 Wed, 17 Jan 2024 09:16:01 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, peterx@redhat.com
Subject: [PATCH 0/4] intel_iommu: Reset vIOMMU after all the rest of devices
Date: Wed, 17 Jan 2024 17:15:55 +0800
Message-ID: <20240117091559.144730-1-peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Peter Xu <peterx@redhat.com>

There're issue reported that when syetem_reset the VM with an intel iommu
device and MT2892 PF(mlx5_core driver), the host kernel throws DMAR error.

  https://issues.redhat.com/browse/RHEL-7188

Alex quickly spot a possible issue on ordering of device resets.

It's verified by our QE team then that it is indeed the root cause of the
problem.  Consider when vIOMMU is reset before a VFIO device in a system
reset: the device can be doing DMAs even if the vIOMMU is gone; in this
specific context it means the shadow mapping can already be completely
destroyed.  Host will see these DMAs as malicious and report.

To fix it, we'll need to make sure all devices under the vIOMMU device
hierachy will be reset before the vIOMMU itself.  There's plenty of trick
inside, one can get those by reading the last patch.

I didn't check other vIOMMUs, but this series should fix the issue for VT-d
as of now.  The solution can be slightly ugly, but a beautiful one can be
very non-trivial.

Review comments welcomed, thanks.

Peter Xu (4):
  reset: qemu_register_reset_one()
  reset: Allow multiple stages of system resets
  intel_iommu: Tear down address spaces before IOMMU reset
  intel_iommu: Reset vIOMMU at the last stage of system reset

 include/sysemu/reset.h |  5 ++++
 hw/core/reset.c        | 67 ++++++++++++++++++++++++++++++------------
 hw/i386/intel_iommu.c  | 56 +++++++++++++++++++++++++++++++++--
 3 files changed, 107 insertions(+), 21 deletions(-)

-- 
2.43.0


