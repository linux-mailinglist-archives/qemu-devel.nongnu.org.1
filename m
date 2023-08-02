Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EB976CF58
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 15:58:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRCM2-0006Kb-3y; Wed, 02 Aug 2023 09:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRCM0-0006KC-5o
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 09:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRCLy-00071F-GF
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 09:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690984649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sPGhXosv8sGSjRX94qsKXua6iKr/u27PjRkbP/f+8yA=;
 b=Dg0pvYGciqp9m1eaVBaFFVriHOy2oqY32zRwzZvw/l3LXP4YpMRJqj8orBPQCR03FK2/kq
 aAlqjRh4/D0zkj3vGdCgxaqQ6oSkM3wKnmtttyMMyYfRv48nFcW5w85b3IfgVNIDUOj/Fy
 CQEqInwWftBElxNdW1A5xLLap+4N4jA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-Z6pBO4CwPUCQAPsWj6yDAg-1; Wed, 02 Aug 2023 09:57:27 -0400
X-MC-Unique: Z6pBO4CwPUCQAPsWj6yDAg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20CB81011562;
 Wed,  2 Aug 2023 13:57:27 +0000 (UTC)
Received: from thuth.com (unknown [10.39.195.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A979E2166B25;
 Wed,  2 Aug 2023 13:57:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH for-8.1 0/6] Fix endianness issues in the intel-iommu device
Date: Wed,  2 Aug 2023 15:57:17 +0200
Message-Id: <20230802135723.178083-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The intel-iommu device is currently unusable on big endian hosts.
When doing something like this on a s390x host:

 wget https://download.fedoraproject.org/pub/fedora/linux/releases/38/Server/x86_64/images/Fedora-Server-KVM-38-1.6.x86_64.qcow2
 ./qemu-system-x86_64 -M q35 -device intel-iommu -m 2G \
        -hda ~/Fedora-Server-KVM-38-1.6.x86_64.qcow2 -trace "vtd_*"

... the guest kernel crashes during boot, complaining about some
problems with the iommu, and you can see clearly in the traces that
some values are wrong when compared to running this on a x86 host.

After spending quite some time hunting down the problems one by one,
I think I now found them all - at least I can successfully boot the
above kernel after I applied these patches.

Thomas Huth (6):
  hw/i386/intel_iommu: Fix trivial endianness problems
  hw/i386/intel_iommu: Fix endianness problems related to
    VTD_IR_TableEntry
  hw/i386/intel_iommu: Fix struct VTDInvDescIEC on big endian hosts
  hw/i386/intel_iommu: Fix index calculation in
    vtd_interrupt_remap_msi()
  hw/i386/x86-iommu: Fix endianness issue in
    x86_iommu_irq_to_msi_message()
  include/hw/i386/x86-iommu: Fix struct X86IOMMU_MSIMessage for big
    endian hosts

 hw/i386/intel_iommu_internal.h |  9 ++++++
 include/hw/i386/intel_iommu.h  | 50 ++++++++++++++++++----------------
 include/hw/i386/x86-iommu.h    | 50 ++++++++++++++++++----------------
 hw/i386/intel_iommu.c          | 23 ++++++++++------
 hw/i386/x86-iommu.c            |  2 +-
 5 files changed, 76 insertions(+), 58 deletions(-)

-- 
2.39.3


