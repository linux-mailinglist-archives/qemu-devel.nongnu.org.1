Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 468A173D802
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 08:51:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDg2v-00069i-69; Mon, 26 Jun 2023 02:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1qDg2p-00068B-Qz
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 02:49:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1qDg2m-0004Q7-BH
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 02:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687762187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fYvIEwyzzG4pXA1ioSf53LM7nWsz6glb/hBkt2gcd0A=;
 b=Q9fPc1GMnk7jXDxvZTt+C1BVrzc9dlQTBptcpb88yxzLHtPWT/NE36S21lAdkdza4nl0Sr
 CX2l8JguBT+AYxOWk8VLTeUyps6nLoU2hn4V9geA6VqkPXiaW5ZK4k+vCXEja1HQlKjLSu
 f71v0QybZPIIvgH7NQmQK0bccmZh3E4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-Ci1AyDDlMq-nIANg3maySQ-1; Mon, 26 Jun 2023 02:49:43 -0400
X-MC-Unique: Ci1AyDDlMq-nIANg3maySQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2AB4185A794;
 Mon, 26 Jun 2023 06:49:42 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com
 (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 923F6200C0CD;
 Mon, 26 Jun 2023 06:49:42 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: oliver.upton@linux.dev, salil.mehta@huawei.com, james.morse@arm.com,
 gshan@redhat.com, Shaoqin Huang <shahuang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v1 0/5] target/arm: Handle psci calls in userspace
Date: Mon, 26 Jun 2023 02:49:04 -0400
Message-Id: <20230626064910.1787255-1-shahuang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

The userspace SMCCC call filtering[1] provides the ability to forward the SMCCC
calls to the userspace. The vCPU hotplug[2] would be the first legitimate use
case to handle the psci calls in userspace, thus the vCPU hotplug can deny the
PSCI_ON call if the vCPU is not present now.

This series try to enable the userspace SMCCC call filtering, thus can handle
the SMCCC call in userspace. The first enabled SMCCC call is psci call, by using
the new added option 'user-smccc', we can enable handle psci calls in userspace.

qemu-system-aarch64 -machine virt,user-smccc=on

This series reuse the qemu implementation of the psci handling, thus the
handling process is very simple. But when handling psci in userspace when using
kvm, the reset vcpu process need to be taking care, the detail is included in
the patch05.

[1] lore.kernel.org/20230404154050.2270077-1-oliver.upton@linux.dev
[2] lore.kernel.org/20230203135043.409192-1-james.morse@arm.com

Shaoqin Huang (5):
  linux-headers: Update to v6.4-rc7
  linux-headers: Import arm-smccc.h from Linux v6.4-rc7
  target/arm: make psci call can be used by kvm
  arm/kvm: add skeleton implementation for userspace SMCCC call handling
  arm/kvm: add support for userspace psci calls handling

 docs/system/arm/virt.rst                      |   4 +
 hw/arm/virt.c                                 |  21 ++
 hw/intc/arm_gicv3_kvm.c                       |  10 +
 include/hw/arm/virt.h                         |   1 +
 include/standard-headers/linux/const.h        |   2 +-
 include/standard-headers/linux/virtio_blk.h   |  18 +-
 .../standard-headers/linux/virtio_config.h    |   6 +
 include/standard-headers/linux/virtio_net.h   |   1 +
 linux-headers/asm-arm64/kvm.h                 |  33 +++
 linux-headers/asm-riscv/kvm.h                 |  53 +++-
 linux-headers/asm-riscv/unistd.h              |   9 +
 linux-headers/asm-s390/unistd_32.h            |   1 +
 linux-headers/asm-s390/unistd_64.h            |   1 +
 linux-headers/asm-x86/kvm.h                   |   3 +
 linux-headers/linux/arm-smccc.h               | 240 ++++++++++++++++++
 linux-headers/linux/const.h                   |   2 +-
 linux-headers/linux/kvm.h                     |  12 +-
 linux-headers/linux/psp-sev.h                 |   7 +
 linux-headers/linux/userfaultfd.h             |  17 +-
 target/arm/helper.c                           |   3 +-
 target/arm/kvm.c                              | 146 +++++++++++
 21 files changed, 573 insertions(+), 17 deletions(-)
 create mode 100644 linux-headers/linux/arm-smccc.h

base-commit: e3660cc1e3cb136af50c0eaaeac27943c2438d1d
-- 
2.39.1


