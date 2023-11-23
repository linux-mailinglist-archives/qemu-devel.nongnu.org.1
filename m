Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8537F5776
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 05:43:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r61Y9-0006N2-Mk; Wed, 22 Nov 2023 23:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Xp-0006LF-TQ
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:30 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Xk-00064l-Ne
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:29 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3b6d80daae8so348328b6e.2
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 20:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700714541; x=1701319341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/RJe0+6jbJTwAypT42FH4DkgaN/bD8EpjoaWzgOvMn0=;
 b=Jvi96HjXt/ojTtHeGJcBcqc7x2psBNMrlmAAar1nw8xjZpmuiS80oehG5EfO26BxeS
 Vhc0Lu/BII3Rp1hwDDNxMCIcDj2fcW5kmTw92JHwRtLXIeivDeWXxWX0XRVq7DH5VCjt
 mtVirJ0N1aUr/izEFGa20hV/IztQAbpacVZTvhq9QksMifPFVZygYG9TDWL1GeTcdkXK
 Q9CU/pcZfcfMPppDEnLo/CcUptEEZCmVXqzg/dkwfYOu/8i1lBTI/69bJIhjryNhCyrY
 0/9EOgPqxktAa+zVhFGoE+SBxxS3JRooUGdCDgw1b5B5oZm30HxME11nH4VZhZFAZkcK
 DQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700714541; x=1701319341;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/RJe0+6jbJTwAypT42FH4DkgaN/bD8EpjoaWzgOvMn0=;
 b=h4B+bjMQ36K6+y7KzO5U+yePwabfrZOBZoztvxTJQ3DtD1Y6zgac7Eprn1wDyKjBh5
 SjsZMn/FmGQvL+FF7tOn0SXmAxOOmDZkG958NPaSNFQASrT69veYasKYpCnkkLXZJxxi
 yvGeXa0kUa/YljfeFKlq4NvUtYgRkYyk+rdgsjYOdvZ5rEk7A2JlO9czrcrrn2GjWH59
 WPpIHNaH99tIgAUeHdjWXQYaDYyjHfjFOdG8ezg42rlASYFPVrBn8e0v74dx9OGf1W4r
 Ym+gLP6KNOI1HO9fmjMmJa4WTWC9h50MEG8nx/4Wyhn0SWILM3V7aNnoJZuw0gi9YijZ
 FiXA==
X-Gm-Message-State: AOJu0YwUxQvb9JvgxdS8D5ArWIf74Nh3jqqXGSp4YXRjMXaeZpHR1+jz
 2QHZaIoJf/zSsrp0VPADVzcDKZWe8JDL6Ttq61xyRY93
X-Google-Smtp-Source: AGHT+IHDBM9SO0UwztHozVp1PYuNerG/uF0ihba1U9mYbsOq5S4YTp7Sg0b59EgRbsQujr7xiUapYw==
X-Received: by 2002:aca:100f:0:b0:3b6:d665:4938 with SMTP id
 15-20020aca100f000000b003b6d6654938mr4993813oiq.43.1700714541522; 
 Wed, 22 Nov 2023 20:42:21 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 i7-20020a056808030700b003b8347de3c2sm73888oie.19.2023.11.22.20.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 20:42:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH for-9.0 00/21] target/arm: kvm cleanups
Date: Wed, 22 Nov 2023 22:41:58 -0600
Message-Id: <20231123044219.896776-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

This is primarily concerned with merging kvm64.c with kvm.c
and then unexporting everything that is not required outside.

r~

Chao Du (1):
  target/arm: kvm64: remove a redundant KVM_CAP_SET_GUEST_DEBUG probe

Richard Henderson (20):
  accel/kvm: Make kvm_has_guest_debug static
  target/arm/kvm: Merge kvm_arm_init_debug into kvm_arch_init
  target/arm/kvm: Move kvm_arm_verify_ext_dabt_pending and unexport
  target/arm/kvm: Move kvm_arm_copy_hw_debug_data and unexport
  target/arm/kvm: Move kvm_arm_hw_debug_active and unexport
  target/arm/kvm: Move kvm_arm_handle_debug and unexport
  target/arm/kvm: Unexport kvm_arm_{get,put}_virtual_time
  target/arm/kvm: Inline kvm_arm_steal_time_supported
  target/arm/kvm: Move kvm_arm_get_host_cpu_features and unexport
  target/arm/kvm: Use a switch for kvm_arm_cpreg_level
  target/arm/kvm: Move kvm_arm_cpreg_level and unexport
  target/arm/kvm: Move kvm_arm_reg_syncs_via_cpreg_list and unexport
  target/arm/kvm: Merge kvm64.c into kvm.c
  target/arm/kvm: Unexport kvm_arm_vcpu_init
  target/arm/kvm: Unexport kvm_arm_vcpu_finalize
  target/arm/kvm: Unexport kvm_arm_init_cpreg_list
  target/arm/kvm: Init cap_has_inject_serror_esr in kvm_arch_init
  target/arm/kvm: Unexport kvm_{get,put}_vcpu_events
  target/arm/kvm: Unexport and tidy kvm_arm_sync_mpstate_to_{kvm,qemu}
  target/arm/kvm: Unexport kvm_arm_vm_state_change

 target/arm/kvm_arm.h   |  203 ------
 accel/kvm/kvm-all.c    |    2 +-
 target/arm/kvm.c       | 1372 +++++++++++++++++++++++++++++++++++++++-
 target/arm/kvm64.c     | 1290 -------------------------------------
 target/arm/meson.build |    2 +-
 5 files changed, 1345 insertions(+), 1524 deletions(-)
 delete mode 100644 target/arm/kvm64.c

-- 
2.34.1


