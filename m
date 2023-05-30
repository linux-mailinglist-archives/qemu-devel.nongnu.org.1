Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EE27161BB
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:27:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zNJ-00066T-6R; Tue, 30 May 2023 09:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3zMS-0005Tz-IS; Tue, 30 May 2023 09:26:06 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3zMQ-0001GE-O3; Tue, 30 May 2023 09:26:04 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-64d30ab1f89so2966408b3a.3; 
 Tue, 30 May 2023 06:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685453159; x=1688045159;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=edByqPNtj0G84FjebXqqbNkz4aqPwbfefgrWnY29Uf8=;
 b=KzBUtKCYG4cA4mYsJZg2W8Qn/QcbtbLwIRyczlgTIfE8mkAhLy3z1JbQaCrNcysZvj
 JHakH4/4VvraTk9XQCA2TscVOvIHSJtVWhNX+VUfZXXQFvpPfAVQF+VRB1Axpcv2bguF
 LfgeSevBEh3yOrp5gr0kS5AyGyjCmssQz3g8o5nv/S9WqYOs+c9puLAma6yRnTfLzWwN
 mQumwNkFZYSdi/e6VNRhawF9drCgEk6tNO4fw23W2MNzigwv7i/IshRVOPw7bwwI6gwV
 XnxcGbKyUVX+kXhm77vd3dI1eP+tq+vmHalUijlDls16k+ioPgE+jlf1eXiwtJQ3URUd
 BWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453159; x=1688045159;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=edByqPNtj0G84FjebXqqbNkz4aqPwbfefgrWnY29Uf8=;
 b=cjcq0FvrrdSW+VTK0Z800krfH2pB/OZcIL068UCXR8+u8B3vkEUP/aao/KcNYrMUG1
 Pr4fjiyak1Q9Fwbo6VkXSbYh8l35Jjrcx5ya7F4r9Og8+LJHq+oGGaSI2S2m3Mpm0RlX
 YLXmrLN6HJPlmYU14Knj1+9Y29Mb+2uHKxj8YTzB3AK3gd+PsZ0v9UWQgdJ5kyq4LCwx
 pl6DwQE+tsXYt8tVF5/OUNCAD9bDYdWZlS6nk9OZXLiv+gxZ+9g24wdv7XyXKqYKgtTE
 g3acZH47JQFoDYogRTkYeC/MBBSbB+R2RhVsVK/xeP6Cr4BAvupi1nGvO9l1EBrmM26Q
 ypQw==
X-Gm-Message-State: AC+VfDyV3dvXGcwZmbh2iIUItLSlRwYHNNFANDcuDXmbgycoDTPEr0No
 6SnH1DfOHXMs0yGqTtThLWa2OHFBagU=
X-Google-Smtp-Source: ACHHUZ71kAZqSNdDM56UdT6IWjnO6gUXWgPta+vFLX1T7QDLLNV5JSXJArVx4PUssFFBEeoC5pbnAw==
X-Received: by 2002:a05:6a21:398b:b0:10e:e1f9:d197 with SMTP id
 ad11-20020a056a21398b00b0010ee1f9d197mr2430044pzc.38.1685453158957; 
 Tue, 30 May 2023 06:25:58 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 w32-20020a634920000000b0050927cb606asm8601514pga.13.2023.05.30.06.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:25:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 0/6] target/ppc: Assorted ppc target fixes
Date: Tue, 30 May 2023 23:25:37 +1000
Message-Id: <20230530132543.385138-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Reposting these since two were merged, and I moved the PMU fix out
of the series since that's a crash fix. Should be no real change
other than rebase and kvm-only build fix.

Thanks,
Nick

Nicholas Piggin (6):
  target/ppc: Fix instruction loading endianness in alignment interrupt
  target/ppc: Change partition-scope translate interface
  target/ppc: Add SRR1 prefix indication to interrupt handlers
  target/ppc: Implement HEIR SPR
  target/ppc: Add ISA v3.1 LEV indication in SRR1 for system call
    interrupts
  target/ppc: Better CTRL SPR implementation

 target/ppc/cpu.h         |  1 +
 target/ppc/cpu_init.c    | 23 +++++++++++
 target/ppc/excp_helper.c | 83 +++++++++++++++++++++++++++++++++++++++-
 target/ppc/mmu-radix64.c | 38 ++++++++++++------
 target/ppc/translate.c   |  9 ++++-
 5 files changed, 140 insertions(+), 14 deletions(-)

-- 
2.40.1


