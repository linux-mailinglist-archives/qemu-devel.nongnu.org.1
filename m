Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26764BE3D38
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Oct 2025 15:58:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9OTU-0006da-Jh; Thu, 16 Oct 2025 09:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v9OTQ-0006cr-TA
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 09:56:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v9OTG-00065F-Ky
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 09:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760623000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jJXkalnXc8twVuHEZ1Cy/JQpH0FxYFZzPkuFhGnTsCQ=;
 b=eIyT+6XqoHF5wMEwruwyz3Pau1VvtlNar6dfhQ4QvUk2DGI8pStLnWmVU6Qu8epk7iCSGj
 fX1BvLxMCCzUL99vDg9rjOlbBB9jynUEDQazD8fE05P+9LwCb3oLUole9Lf+hUbvaDRDos
 r7nnwI1ncA/LcWgo9XKxb9LB5DJ1wuA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-0XajE8XePjOcddOFZbkW6Q-1; Thu,
 16 Oct 2025 09:56:36 -0400
X-MC-Unique: 0XajE8XePjOcddOFZbkW6Q-1
X-Mimecast-MFC-AGG-ID: 0XajE8XePjOcddOFZbkW6Q_1760622995
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 116C7195609F; Thu, 16 Oct 2025 13:56:35 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.238])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 284FB19560AD; Thu, 16 Oct 2025 13:56:29 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com,
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [PATCH 0/7] Mitigation of "failed to load
 cpu:cpreg_vmstate_array_len" migration failures
Date: Thu, 16 Oct 2025 15:55:12 +0200
Message-ID: <20251016135625.249551-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When migrating ARM guests accross same machines with different host
kernels we are likely to encounter failures such as:

"failed to load cpu:cpreg_vmstate_array_len"

This is due to the fact KVM exposes a different number of registers
to qemu on source and destination. When trying to migrate a bigger
register set to a smaller one, qemu cannot save the CPU state.

For example, recently we faced such kind of situations with:
- unconditionnal exposure of KVM_REG_ARM_VENDOR_HYP_BMAP_2 FW pseudo
  register from v6.16 onwards. Causes backward migration failure.
- removal of unconditionnal exposure of TCR2_EL1, PIRE0_EL1, PIR_EL1
  from v6.13 onwards. Causes forward migration failure.

This situation is really problematic for distributions which want to
guarantee forward and backward migration of a given machine type
between different releases.

This small series tries to address that issue by introducing CPU
array properties that list the registers to ignore or to fake according
to the situation. An example is given to illustrate how those props
could be used to apply compats for machine types supposed to "see" the
same register set accross various host kernels.

The first patch improves the tracing so that we can quickly detect
which registers are unexpected and cause the migration failure. Missing
registers are also traced. Those do not fail migration but their default
value is kept on the destination.

Then we introduce the infrastructure to handle 'hidden' registers and
'fake' registers.

Eric Auger (7):
  target/arm/machine: Improve traces on register mismatch during
    migration
  target/arm/kvm: Introduce the concept of hidden KVM regs
  target/arm/kvm: Introduce the concept of enforced/fake registers
  kvm-all: Add the capability to blacklist some KVM regs
  target/arm/cpu: Implement hide_reg callback()
  target/arm/kvm: Expose kvm-hidden-regs and kvm-fake-regs properties
  hw/arm/virt: [DO NOT UPSTREAM] Enforce compatibility with older
    kernels

 include/hw/core/cpu.h   |  2 ++
 target/arm/cpu.h        | 42 ++++++++++++++++++++++++
 accel/kvm/kvm-all.c     | 12 +++++++
 hw/arm/virt.c           | 19 +++++++++++
 target/arm/cpu.c        | 12 +++++++
 target/arm/kvm.c        | 73 ++++++++++++++++++++++++++++++++++++++++-
 target/arm/machine.c    | 71 +++++++++++++++++++++++++++++++++++----
 target/arm/trace-events | 11 +++++++
 8 files changed, 235 insertions(+), 7 deletions(-)

-- 
2.49.0


