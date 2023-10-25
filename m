Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A47A7D7881
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:28:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnHe-0001Sf-08; Wed, 25 Oct 2023 19:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHZ-0001S6-KP
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHX-0004YV-UT
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NNY4dhJlHyDw9eHL9HFeyHjM5YXvbe40bpaF3rRptBQ=;
 b=A5ktn50lMc33GmZDcTJgTVGo/pHnWvcteWFzKGz2B1UtdwiZkzWiRDLmRS712nlULxugze
 m4rsm9DvV84e2qhLXeCPlT2PgFwfe2HAlRBuPrvW3UCPGlxguWBH0EG07inp1jYR2d4Ag9
 7WnbaO023yDq9yzf3DTKphyoqRsYfj4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-qtg6WwSoOTiSGtcpXOgelA-1; Wed, 25 Oct 2023 19:27:21 -0400
X-MC-Unique: qtg6WwSoOTiSGtcpXOgelA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66d12b547e2so4237906d6.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276440; x=1698881240;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NNY4dhJlHyDw9eHL9HFeyHjM5YXvbe40bpaF3rRptBQ=;
 b=q8ewRGqt0jaq9ck656Ts1IkHwzjz1MxMsNYuWqw1uZiPmRBiovUdiTaRhaESMcQNmC
 xrGZkbJcmX83hSqz7kctF/NqBbrMzUWDNCHUvdK9om2SM/Vyq7cJFVOFs3x1a+BMFj4x
 VujpiA3M2Jbl5KfU+3XH9agKKGMu4WHW5tIkw4MCOpvkhNkhW3w2tflBg/2OvsCP0soZ
 X2drB+Xyn+bDgn5AX2wxSsnHnLRElgv2NejXJY4a7ih6PS6ZwnoMuo1f3M/T/0IF0GMN
 2Rm2GftT0wC2oNCd1MgFvui+nsdd8H0V33xyMFX15eovidolF511ALqsOKU8fcpvph3U
 y4IA==
X-Gm-Message-State: AOJu0YyJDAOUZST/fGkOVUTZ+sH2yPQPcoRhTEf98yhM2y3QN3+6Sryy
 8PYLTg/tMqrLRXgNKjmTO848Guy66qFeWFjXsUEK9h1zBPqYLS+rTGM9i9aE6ImM5aqpIY7hKqG
 HDOFsin+qREDODjFxuydJxECeD4du1JaWvnRpo4Epmw09EqP3fjgpVQm8XSbQrQO91htg0D3UkB
 c=
X-Received: by 2002:ad4:5bce:0:b0:66d:212b:32ab with SMTP id
 t14-20020ad45bce000000b0066d212b32abmr18614480qvt.47.1698276440439; 
 Wed, 25 Oct 2023 16:27:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjmWNt6kEeuydxQyPgD+W8ISj5sRSN33f9uMBHlVHaWCzuPgLjHgYGL+rXZ8BrUdGS3o1fug==
X-Received: by 2002:ad4:5bce:0:b0:66d:212b:32ab with SMTP id
 t14-20020ad45bce000000b0066d212b32abmr18614465qvt.47.1698276440069; 
 Wed, 25 Oct 2023 16:27:20 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 f9-20020ad45589000000b0066e0c924109sm2192740qvx.106.2023.10.25.16.27.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:27:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/24] x86, KVM changes for 2023-10-26
Date: Thu, 26 Oct 2023 01:26:53 +0200
Message-ID: <20231025232718.89428-1-pbonzini@redhat.com>
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

The following changes since commit a95260486aa7e78d7c7194eba65cf03311ad94ad:

  Merge tag 'pull-tcg-20231023' of https://gitlab.com/rth7680/qemu into staging (2023-10-23 14:45:46 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 39dd3e1f55a70f568cc9d280f67467aa4e8a63bd:

  kvm: i8254: require KVM_CAP_PIT2 and KVM_CAP_PIT_STATE2 (2023-10-25 19:53:38 +0200)

----------------------------------------------------------------
* target/i386: implement SHA instructions
* target/i386: check CPUID_PAE to determine 36 bit processor address space
* target/i386: improve validation of AVX instructions
* require Linux 4.4 for KVM

----------------------------------------------------------------
Ani Sinha (1):
      target/i386: check CPUID_PAE to determine 36 bit processor address space

Paolo Bonzini (23):
      tests/tcg: fix out-of-bounds access in test-avx
      target/i386: implement SHA instructions
      tests/tcg/i386: initialize more registers in test-avx
      tests/tcg/i386: test-avx: add test cases for SHA new instructions
      target/i386: group common checks in the decoding phase
      target/i386: validate VEX.W for AVX instructions
      kvm: remove unnecessary stub
      kvm: require KVM_CAP_INTERNAL_ERROR_DATA
      kvm: require KVM_CAP_SIGNAL_MSI
      kvm: require KVM_IRQFD for kernel irqchip
      kvm: require KVM_IRQFD for kernel irqchip
      kvm: drop reference to KVM_CAP_PCI_2_3
      kvm: assume that many ioeventfds can be created
      kvm: require KVM_CAP_IOEVENTFD and KVM_CAP_IOEVENTFD_ANY_LENGTH
      kvm: unify listeners for PIO address space
      kvm: i386: move KVM_CAP_IRQ_ROUTING detection to kvm_arch_required_capabilities
      kvm: i386: require KVM_CAP_DEBUGREGS
      kvm: i386: require KVM_CAP_XSAVE
      kvm: i386: require KVM_CAP_SET_VCPU_EVENTS and KVM_CAP_X86_ROBUST_SINGLESTEP
      kvm: i386: require KVM_CAP_MCE
      kvm: i386: require KVM_CAP_ADJUST_CLOCK
      kvm: i386: require KVM_CAP_SET_IDENTITY_MAP_ADDR
      kvm: i8254: require KVM_CAP_PIT2 and KVM_CAP_PIT_STATE2

 accel/kvm/kvm-all.c                  | 231 ++++------------------------------
 accel/stubs/kvm-stub.c               |  14 ---
 hw/i386/kvm/clock.c                  |   4 -
 hw/i386/kvm/i8254.c                  |  38 ++----
 hw/i386/pc.c                         |   6 +-
 hw/intc/arm_gicv3_its_common.c       |   3 +-
 hw/intc/arm_gicv3_its_kvm.c          |   2 +-
 hw/misc/pci-testdev.c                |   3 +-
 hw/s390x/virtio-ccw.c                |   4 -
 hw/virtio/vhost-user.c               |   7 +-
 hw/virtio/virtio-mmio.c              |   4 -
 hw/virtio/virtio-pci.c               |  23 +---
 include/sysemu/kvm.h                 |  37 +-----
 include/sysemu/kvm_int.h             |   5 -
 system/memory.c                      |  16 +--
 target/i386/cpu.c                    |   4 +-
 target/i386/kvm/kvm.c                | 225 +++------------------------------
 target/i386/kvm/kvm_i386.h           |   2 -
 target/i386/ops_sse.h                | 128 +++++++++++++++++++
 target/i386/tcg/decode-new.c.inc     | 232 ++++++++++++++++++++++++++---------
 target/i386/tcg/decode-new.h         |  36 ++++--
 target/i386/tcg/emit.c.inc           |  62 ++++++++--
 target/i386/tcg/ops_sse_header.h.inc |  14 +++
 target/riscv/kvm/kvm-cpu.c           |   2 +-
 tests/tcg/i386/test-avx.c            |  19 ++-
 tests/tcg/i386/test-avx.py           |   3 +-
 26 files changed, 491 insertions(+), 633 deletions(-)
-- 
2.41.0


