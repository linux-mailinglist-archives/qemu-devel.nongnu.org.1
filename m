Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 921887CE2F3
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:38:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt9YC-0000vD-9b; Wed, 18 Oct 2023 12:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9Y8-0000uZ-SL
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:37:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9Y7-0007N7-9G
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697647054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RQeYQg6S87oPCWYEeppDCz9QTajde7K0bjQMdx6fi80=;
 b=K5ANsDPN/iPWA0ljMkgUO87RBuNLczRieLFn2Ruwc9rb/iE1B8r2tCPeLfn7yJEeW/lH15
 ZfLur1XmAyzWwouzagN+2qtXevHue9zYas6J70oiAYaB2jJPQjIoIf0Ka8AYBwvKdarCvN
 832mKPMKmJLKdUxnVfcYk1LC9QUN3H0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-d1HBRv02M6CAMcJk5HUl-w-1; Wed, 18 Oct 2023 12:37:32 -0400
X-MC-Unique: d1HBRv02M6CAMcJk5HUl-w-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-99bcb13d8ddso522956066b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 09:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697647051; x=1698251851;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RQeYQg6S87oPCWYEeppDCz9QTajde7K0bjQMdx6fi80=;
 b=WUm2+t0hgkU3zjcVwVPyNtK5eZijTQamDlWemuPpiuJVrrd09WA6jOUr6viAEm2Mh9
 H+dR9CDxOj35xENX07B/MR77OAdDMStve1fltBjJZGlikZyJdQNVLhwxRNbcZll+CdUf
 KyS4Yv8DrMc7HXPTxJ5AfT5VtJvGMZXLZA60plpfuQJ3dlXvq3S+eRt1g3+fvj5O8Sbe
 GMxDYcSVWbBWdmwA3aNhljbQ9BLj5CPSOQ5t5TjCwJgqALV3IuGoq+qDTCbOSqbH9k1z
 1ZjdnlBk/P69qbo3fwEJ0G325iSJ3SaaRZPMo1A4NoeV+kPTIYfT4Xh5wGuzF9ih6mPi
 CQkw==
X-Gm-Message-State: AOJu0Ywe2YdIPN9Ta1QiTXuClxJ96hXgsveept/qrpk0WA4BucbyEbKT
 d/I+MX/Rdkqpq6d7yR84Uk2wsZm1x5VNjfbAyVqHoALgJN/n6ZSiAVlKIX4VMAbFrj6qySnMSOg
 jRlaHIkSpHppDx6bamzmIvqVVDlqnXXtvRV7RgRKWppgRkVgnUcUTPqGHyiO9XV2BbRAFlbX/cS
 c=
X-Received: by 2002:a17:907:7f20:b0:9b2:babd:cd44 with SMTP id
 qf32-20020a1709077f2000b009b2babdcd44mr5267642ejc.44.1697647050964; 
 Wed, 18 Oct 2023 09:37:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQhIOqBp2M+KydMVXWC2q1ZKTz6dUQ/yziLyZjC/Lix/lki6h0yMTJzGm/r2Qi0s9Mt7CwsQ==
X-Received: by 2002:a17:907:7f20:b0:9b2:babd:cd44 with SMTP id
 qf32-20020a1709077f2000b009b2babdcd44mr5267619ejc.44.1697647050463; 
 Wed, 18 Oct 2023 09:37:30 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a1709065a9400b0099bcdfff7cbsm2008525ejq.160.2023.10.18.09.37.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 09:37:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/17] kvm: drop support for really old kernels
Date: Wed, 18 Oct 2023 18:37:11 +0200
Message-ID: <20231018163728.363879-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This removes checks for KVM capabilities introduced in very old kernels.
I focused mostly (though not exclusively) on caps that are extremely
old or have a lot of supporting code around them.  The new inferior
limit is Linux 4.4 (or RHEL/CentOS 7) for all architectures except ARM,
for which the limit is Linux 4.19 (or RHEL/CentOS 8).

Note that sometimes older capabilities have evolved and have to
be tested anyway, for example in the case of KVM_CAP_ADJUST_CLOCK
it is possible to remove kvm_has_adjust_clock() but not
kvm_has_adjust_clock_stable().

I intentionally didn't include capabilities that map to guest-visible
features, such as KVM_CAP_TSC_DEADLINE_TIMER, instead focusing more
on very old APIs.

Kernel code technically does not require KVM_CAP_IRQFD to be always
available on architectures that support an in-kernel interrupt controller;
however this is currently true for all supported architectures, and
I plan to submit a kernel patch to ensure this equivalence.

Paolo

Paolo Bonzini (17):
  kvm: remove unnecessary stub
  kvm: require KVM_CAP_INTERNAL_ERROR_DATA
  kvm: require KVM_CAP_SIGNAL_MSI
  kvm: require KVM_CAP_IRQFD for kernel irqchip
  kvm: drop reference to KVM_CAP_PCI_2_3
  kvm: assume that many ioeventfds can be created
  kvm: require KVM_CAP_IOEVENTFD and KVM_CAP_IOEVENTFD_ANY_LENGTH
  kvm: unify listeners for PIO address space
  kvm: arm: require KVM_CAP_SET_VCPU_EVENTS
  kvm: i386: move KVM_CAP_IRQ_ROUTING detection to kvm_arch_required_capabilities
  kvm: i386: require KVM_CAP_DEBUGREGS
  kvm: i386: require KVM_CAP_XSAVE
  kvm: i386: require KVM_CAP_SET_VCPU_EVENTS and KVM_CAP_X86_ROBUST_SINGLESTEP
  kvm: i386: require KVM_CAP_MCE
  kvm: i386: require KVM_CAP_ADJUST_CLOCK
  kvm: i386: require KVM_CAP_SET_IDENTITY_MAP_ADDR
  kvm: i8254: require KVM_CAP_PIT2 and KVM_CAP_PIT_STATE2

 accel/kvm/kvm-all.c            | 239 ++++-----------------------------
 accel/stubs/kvm-stub.c         |  14 --
 hw/i386/kvm/clock.c            |   4 -
 hw/i386/kvm/i8254.c            |  38 ++----
 hw/i386/pc.c                   |   6 +-
 hw/intc/arm_gicv3_its_common.c |   3 +-
 hw/intc/arm_gicv3_its_kvm.c    |   2 +-
 hw/misc/pci-testdev.c          |   3 +-
 hw/s390x/virtio-ccw.c          |   4 -
 hw/virtio/vhost-user.c         |   7 +-
 hw/virtio/virtio-mmio.c        |   4 -
 hw/virtio/virtio-pci.c         |  23 +---
 include/sysemu/kvm.h           |  39 +-----
 include/sysemu/kvm_int.h       |   6 -
 system/memory.c                |  16 +--
 target/arm/kvm.c               |  10 +-
 target/i386/kvm/kvm.c          | 225 +++----------------------------
 target/i386/kvm/kvm_i386.h     |   2 -
 target/riscv/kvm/kvm-cpu.c     |   2 +-
 20 files changed, 77 insertions(+), 572 deletions(-)

-- 
2.41.0


