Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E95573DD18
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:16:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkBN-0002ty-DN; Mon, 26 Jun 2023 07:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBJ-0002sz-SX
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBI-0000X1-1L
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687778091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Cg5YbdFiOsUl6WPQcsfSv3GFMwpsdbkqfBKYblRo38M=;
 b=GVQh9rXCf3QQYuqQZJr/V+TIQYT8Pt1Iemy00QBlUOj6BhllTk4Vzx6iyvG+Qzt8TFdKBs
 DyH9Ej+cvafBTlP1Gb/sGXl8/yeW5TBhpP2U+xMnz3ma7Z8PIESvEhlPlWcEf8f2ErsEHw
 1SZGageSCYkBD5BkxB5NvyyBngqrn5Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-86ybIdAzPY2jjUCvFvA4CQ-1; Mon, 26 Jun 2023 07:14:48 -0400
X-MC-Unique: 86ybIdAzPY2jjUCvFvA4CQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f5df65f9f4so18207255e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687778087; x=1690370087;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cg5YbdFiOsUl6WPQcsfSv3GFMwpsdbkqfBKYblRo38M=;
 b=BBDE6NfDpVOQJ5Inhz1LzdkYlxFmWOamPZp6z19YqY6mW9hOOvt0ZUtSGfsoJk/GvJ
 51oj/qArIuqoAr/r4AGzyPRCsNSUtwbgE4+4AKQshIS0+/8PNCDo/WjF+SZY5JhflpZO
 hoveCH7LNrAT4eB4zo2how3SQIu253zeha5rlqQar8UX/PEKH2OFNCbWhJhDI/RNjcIz
 X5n16ZEGcxk1lZ8W9WspK/0Inqg7SxWJfFudLhqODABWkfepwXGvqp1Sqn05oeVYmmHU
 iF60+O7sTsSlImgxr7ThavDgHQWaQZfTG7wR4MLpfdltxQL3/s4x8/3eDR0SvHY+YBLl
 8pIQ==
X-Gm-Message-State: AC+VfDxjwBeBwYDdzOU4mvLzMNwXCUoPnKe4OEwTUrcfZbdYZuASlSQE
 0BhxPI0AZY9THWnbEuIpGX55FaEFzfZltqQ92tPg+HFdRePGxftvt0HvJl8yUvQqHyslFCoIu04
 k3R/R9lzlBdKpYbs9IuMVY/H+Acj9M2cF4SJ6tYeo6Dt43SEUsurBvpvNanrDMwWu3U8z/g8CY4
 g=
X-Received: by 2002:a05:600c:2903:b0:3fa:7fb2:c927 with SMTP id
 i3-20020a05600c290300b003fa7fb2c927mr5970523wmd.39.1687778087287; 
 Mon, 26 Jun 2023 04:14:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6LGfnLMjk8iGRxzmBl7J/c4jiYy6nfp5kNwif1A44vfDa4MB+vut4gRagIt5HPkVcKLf+jVA==
X-Received: by 2002:a05:600c:2903:b0:3fa:7fb2:c927 with SMTP id
 i3-20020a05600c290300b003fa7fb2c927mr5970507wmd.39.1687778086789; 
 Mon, 26 Jun 2023 04:14:46 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a1c4b11000000b003f9b24cf881sm10292771wma.16.2023.06.26.04.14.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:14:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/18] Misc, i386 patches for 2023-06-26
Date: Mon, 26 Jun 2023 13:14:27 +0200
Message-ID: <20230626111445.163573-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 79dbd910c9ea6ca38f8e1b2616b1e5e885b85bd3:

  Merge tag 'hppa-boot-reboot-fixes-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2023-06-25 08:58:49 +0200)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 8edddaa23d75c57e093d99bf098a39f8cbd227c7:

  git-submodule.sh: allow running in validate mode without previous update (2023-06-26 10:23:56 +0200)

----------------------------------------------------------------
* kvm: reuse per-vcpu stats fd to avoid vcpu interruption
* Validate cluster and NUMA node boundary on ARM and RISC-V
* various small TCG features from newer processors
* Remove dubious 'event_notifier-posix.c' include
* fix git-submodule.sh in releases

----------------------------------------------------------------
Gavin Shan (3):
      numa: Validate cluster and NUMA node boundary if required
      hw/arm: Validate cluster and NUMA node boundary
      hw/riscv: Validate cluster and NUMA node boundary

Marcelo Tosatti (1):
      kvm: reuse per-vcpu stats fd to avoid vcpu interruption

Paolo Bonzini (13):
      build: further refine build.ninja rules
      target/i386: fix INVD vmexit
      target/i386: TCG supports 3DNow! prefetch(w)
      target/i386: TCG supports RDSEED
      target/i386: do not accept RDSEED if CPUID bit absent
      target/i386: TCG supports XSAVEERPTR
      target/i386: TCG supports WBNOINVD
      target/i386: Intel only supports SYSCALL/SYSRET in long mode
      target/i386: AMD only supports SYSENTER/SYSEXIT in 32-bit mode
      target/i386: sysret and sysexit are privileged
      target/i386: implement RDPID in TCG
      target/i386: implement SYSCALL/SYSRET in 32-bit emulators
      git-submodule.sh: allow running in validate mode without previous update

Philippe Mathieu-Daudé (1):
      hw/remote/proxy: Remove dubious 'event_notifier-posix.c' include

 Makefile                            | 17 +++++++--
 accel/kvm/kvm-all.c                 | 30 +++++++--------
 bsd-user/i386/target_arch_cpu.h     |  4 ++
 configure                           |  3 +-
 hw/arm/sbsa-ref.c                   |  2 +
 hw/arm/virt.c                       |  2 +
 hw/core/machine.c                   | 42 +++++++++++++++++++++
 hw/remote/proxy.c                   |  1 -
 hw/riscv/spike.c                    |  2 +
 hw/riscv/virt.c                     |  2 +
 include/hw/boards.h                 |  1 +
 include/hw/core/cpu.h               |  1 +
 linux-user/i386/cpu_loop.c          |  9 +++--
 meson.build                         |  2 +
 scripts/git-submodule.sh            | 73 +++++++++++++++++++++----------------
 target/i386/cpu.c                   | 31 ++++++++++++----
 target/i386/helper.h                |  4 +-
 target/i386/tcg/misc_helper.c       | 21 ++++++++---
 target/i386/tcg/seg_helper.c        |  7 +++-
 target/i386/tcg/sysemu/seg_helper.c |  7 ++--
 target/i386/tcg/translate.c         | 55 +++++++++++++++++++++-------
 target/i386/tcg/user/seg_helper.c   |  2 -
 22 files changed, 224 insertions(+), 94 deletions(-)
-- 
2.41.0


