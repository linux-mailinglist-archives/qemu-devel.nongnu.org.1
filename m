Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D18C764972
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 09:55:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOvTZ-0005EY-Va; Thu, 27 Jul 2023 03:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qOvTV-0005CJ-Gk
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:31:53 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qOvTR-0003Q5-0C
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:31:50 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-686f25d045cso272348b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 00:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690443104; x=1691047904;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XNojA4zMzd30qUIFHT5IxiLGg6u2c9ZAs/+vQaBH6fU=;
 b=LhjJaoFIO3msBLNQYeOszTGi+0keE5rszVhxOFnadyd7/NHtSVHXCLuhR4RKxJUJnI
 5TtMvuKGi/nZLKJKkiXtlNS7euW6Ort7K+6sPSwUIg98N9b0Im+psTxghbHI9ND0hIAi
 OaOjQO4p79GnpVwb//4G/AKxayCkpCudZkY1Kx2ZhWTjWFEpIHZtTb1TofH4ln59wiir
 GlQDunLexjW1adklQSpJmWkopkq9XfwGesFVuKbKhKtNENy11UirUdUGylQZ68Bqr+5W
 aaH05c3B63s1qqdzQ1MJlP+vTeaZqhyLan5L2++ke3wwrnAS4rshT49GM8LMtWxtL7Hd
 PKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690443104; x=1691047904;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XNojA4zMzd30qUIFHT5IxiLGg6u2c9ZAs/+vQaBH6fU=;
 b=V/f/1qIWUgkg34XaHfuJH6xy3FFw7LuhIEBEdh/vrwm+Wt/j8XYmUKPMQ8lKZ4O+lX
 IEPmry+0FFceDDEHXzdIXuIPXRFQu0dpr9QnmPkEIq4et5BGRju6zqpg9HliLO+Z2rlU
 BG/EmYzyMQgQDGiNX6DphK0W50/kM2KsK3FS3O2k2M2PQLxo7s5tUA9aozINsBtj2V7X
 Sk6T1vuibERmkH0xY4SFaFBYIprd975KyMtnZ56avMTL92G58mVQaUJGoeEZxl2WjWG/
 88HJs6D/7NJ2epcf0rwIxS4YiYh05WKX9NSz9HKZLk26rbMMQOjYk5ZPqVLmmJ/V3/WP
 GXYQ==
X-Gm-Message-State: ABy/qLbb5q/W7zxjTnCzqjKW72tqPb7v3yXrlNJ4Ta/pmeE/I7nqv7r+
 fvK2ns8m0OYclpt/279JLN7P862/TdzFkGn3/hI=
X-Google-Smtp-Source: APBJJlGr1mGBX50eU/zNqYdAc7dzLGhkxLnfOcLJuIXfrTZJjIQVNAA7VVv29xDe12znB1fcScLamw==
X-Received: by 2002:a05:6a00:808:b0:686:b94a:3879 with SMTP id
 m8-20020a056a00080800b00686b94a3879mr4859980pfk.18.1690443104613; 
 Thu, 27 Jul 2023 00:31:44 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 d9-20020aa78689000000b0064fa2fdfa9esm802002pfo.81.2023.07.27.00.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 00:31:44 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 0/6] accel/kvm: Specify default IPA size for arm64
Date: Thu, 27 Jul 2023 16:31:25 +0900
Message-ID: <20230727073134.134102-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Some Arm systems such as Apple Silicon Macs have IPA size smaller than the
default used by KVM. Introduce our own default IPA size that fits on such a
system.

When reviewing this series, Philippe Mathieu-Daudé found the error handling
around KVM type decision logic is flawed so I added a few patches for fixing
the error handling path.

V4 -> V5: Fixed KVM type error handling
V3 -> V4: Removed an inclusion of kvm_mips.h that is no longer needed.
V2 -> V3: Changed to use the maximum IPA size as the default.
V1 -> V2: Introduced an arch hook

Akihiko Odaki (6):
  kvm: Introduce kvm_arch_get_default_type hook
  accel/kvm: Specify default IPA size for arm64
  mips: Report an error when KVM_VM_MIPS_VZ is unavailable
  accel/kvm: Use negative KVM type for error propagation
  accel/kvm: Free as when an error occurred
  accel/kvm: Make kvm_dirty_ring_reaper_init() void

 include/sysemu/kvm.h     |  2 ++
 target/mips/kvm_mips.h   |  9 ---------
 accel/kvm/kvm-all.c      | 19 +++++++++++--------
 hw/arm/virt.c            |  2 +-
 hw/mips/loongson3_virt.c |  2 --
 hw/ppc/spapr.c           |  2 +-
 target/arm/kvm.c         |  7 +++++++
 target/i386/kvm/kvm.c    |  5 +++++
 target/mips/kvm.c        |  3 ++-
 target/ppc/kvm.c         |  5 +++++
 target/riscv/kvm.c       |  5 +++++
 target/s390x/kvm/kvm.c   |  5 +++++
 12 files changed, 44 insertions(+), 22 deletions(-)

-- 
2.41.0


