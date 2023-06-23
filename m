Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 547B273B8A9
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 15:19:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgfD-0004W2-N1; Fri, 23 Jun 2023 09:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCgfA-0004Qf-3Z
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCgf8-0005Ys-J8
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687526236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=E31OsKq7fAy/CGKWfNdKg0D1o4T6H5eKdfFJ55V18dA=;
 b=MH6bYIQLroIUgq7GuaHGyVfhcYzMTyYIsVEvBDzh0mgMuNgaMmgSKCsSt7zN323Nx/Mr5i
 cUEDQcZa4MfF0LKJuh0lVDgavoTYYLfdRMZOYevnCLt1FnW7s5CGPp79DTs9IG6Xlr8Tw9
 /VyjugIsGhDJiuxMEizOL5MdHMHpA60=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-RDq-epgdM1m_iwnPGYw3ZA-1; Fri, 23 Jun 2023 09:17:15 -0400
X-MC-Unique: RDq-epgdM1m_iwnPGYw3ZA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-50a16ab50e6so320267a12.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 06:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687526233; x=1690118233;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E31OsKq7fAy/CGKWfNdKg0D1o4T6H5eKdfFJ55V18dA=;
 b=Re1Qkbu5HdddQAlOmcLMG+ZBdT7fJNVqFJ7RF48Z00d2IW52GSsoRZ5m2zioEoq7ks
 RupgBC7YP9T3arpFRcg+NU/moKEA2ecQjE1mWS3FjQ+UdlowZi17E0p6yw29+xrpgkPE
 XQ0dUGrmv3EUItPC1/e6EDwvR3znmSAC+ziDFa9f5uT2uMd9r5JNjdpnGMzPa2SyjpIA
 Z9l1QOyCWt5ULJcBf8bamZ7kbZIq60f2krflrfCkjMlZF04gWeIe3d5LcdcKkTscWHob
 H8rGy0XoC8wPpJ+F5JybSKyJ1YAdjYqh47xlO3iYoL4q+ZyFHTcB265FuObSxpt4iW+4
 teKg==
X-Gm-Message-State: AC+VfDxx/QcPuhVInmRxzO3s5yxixEF/7DzFI9pNO8fzS/PWcAVb83d3
 C6ZqH1+nIl3XsfFf81thyDm7FNgXB6mk6kce/mTC69emfvAxi8lXna63GWEfKxxKjegRVbyRb5s
 GDf6OfNOEWm7xCU9u6MZbTvnCaOqbUSKciqaHRIuAkzcBZPSqWM4fk+qbVq6OAMwI8jCevgrfGD
 k=
X-Received: by 2002:a50:ee14:0:b0:51a:59d1:fb37 with SMTP id
 g20-20020a50ee14000000b0051a59d1fb37mr11819117eds.28.1687526233645; 
 Fri, 23 Jun 2023 06:17:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5gfQBfCAkiEy8VHHoFe3ssZDE5Jr4vLYxMmAw4NUSXrlgu5pHYFSLHncGDNeC5b2dkwLEaeA==
X-Received: by 2002:a50:ee14:0:b0:51a:59d1:fb37 with SMTP id
 g20-20020a50ee14000000b0051a59d1fb37mr11819103eds.28.1687526233307; 
 Fri, 23 Jun 2023 06:17:13 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 n26-20020aa7c79a000000b0051be5bbce23sm2621447eds.35.2023.06.23.06.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 06:17:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 00/11] target/i386: add a few simple features
Date: Fri, 23 Jun 2023 15:17:00 +0200
Message-ID: <20230623131711.96775-1-pbonzini@redhat.com>
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

In preparation for supporting named CPU models for user-mode emulation,
add a few TCG features that are actually already implemented, or that
are easy to implement.  The most important (and most relevant to user-mode
emulation) are RDSEED, RDPID, and for 32-bit processors SYSCALL as well.

Paolo

v1->v2:
- fix WBNOINVD vmexit
- correctly implement 32-bit SYSCALL and SYSENTER
- do not include linux-user/ from target/

v2->v3:
- do not accept RDSEED if CPUID bit absent
- also raise illegal opcode exception for SYSRET in 32-bit mode for Intel CPUs
- raise illegal opcode exception for SYSENTER/SYSEXIT in 64-bit mode for AMD CPUs
- Also try sched_getcpu() to return a sensible value for RDPID, since FreeBSD
  does write the CPUID to MSR_TSC_AUX.
- Fully implement SYSCALL/SYSRET for 32-bit processors, including system emulators

Paolo Bonzini (11):
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

 bsd-user/i386/target_arch_cpu.h     |  4 +++
 linux-user/i386/cpu_loop.c          | 13 ++++---
 meson.build                         |  2 ++
 target/i386/cpu.c                   | 31 +++++++++++-----
 target/i386/helper.h                |  4 +--
 target/i386/tcg/misc_helper.c       | 21 +++++++----
 target/i386/tcg/seg_helper.c        |  7 ++--
 target/i386/tcg/sysemu/seg_helper.c |  7 ++--
 target/i386/tcg/translate.c         | 55 ++++++++++++++++++++++-------
 target/i386/tcg/user/seg_helper.c   |  2 --
 10 files changed, 105 insertions(+), 41 deletions(-)

-- 
2.41.0


