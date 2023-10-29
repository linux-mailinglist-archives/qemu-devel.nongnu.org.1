Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F01F77DAE6A
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 22:10:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxD1m-0002eb-PR; Sun, 29 Oct 2023 17:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxD1k-0002eC-Ez
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:08:56 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxD1g-0005DM-LT
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:08:56 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6b7f0170d7bso3777539b3a.2
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 14:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698613731; x=1699218531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=eXLlwLlC9PpEdWbXFK0w6D6ZLA5syZW+CHn2NQVmR6k=;
 b=OZt5SdTh1ODS+51jGnLBHWmyPv/xdpDfZSRwtuS6S2n1IYxBKhf71l+HqZ1V6Mellb
 lgjXpLuJvdXIKHa+981L0OhlmhV3ilflkMCNMjgKAaN2phYJRgpLlszbLpU1HdEaVANu
 AlNqbI7DZsBLon6pUditQzh3n49Y8TiG0q/xzv/606BF/IrLIjjuehoUt1yd60Ic4adJ
 06u5DLMUUMEK8F1noYZfUw2gj4iGNWtXDLYRdGZHKLCf/f7cWDsRMzI+YsYaCXtrTsN1
 e69PDabVIzLdQu3/GdZD2DNEB2HNJ53mXxyAzqv+VVfrD35gD8LNA1nYm+6KyevIHmZT
 awVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698613731; x=1699218531;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eXLlwLlC9PpEdWbXFK0w6D6ZLA5syZW+CHn2NQVmR6k=;
 b=IF9zW/mxB6AyZJ9I1kbe4vlGVhabUvlwocY64OHviODdAtgrUrhiOvdxc3M9v9/83G
 4vhkMz+A9rg3Gf6kPTquiryQBQDHF3opviT8h833+sLNeORrwk1bS4xxm78T1Ccli7lx
 h2XJMaCMIVQtc4uF24Y5rlt0a3Flcxzh+KBASMJpEd22k5EkCU98HtTkw1cpscMN2bdC
 PX+iQvzbbUS3LoDaBEzc7KaQbRnGcdu0OM4kZAO7jLpoyXp+qNTi2jaJorLe8GC4p6xK
 p3Umj4qcfCoNX8Z2LH6ZuGQyPLvoKSBghHXTvgBTj3TOCR+oWD4HopUHGCMmqSGiV38K
 f21A==
X-Gm-Message-State: AOJu0YyZWL6r9widJomyKoejQD9qsy1HnqZoyeeaSbKw3CGSunnA/XDB
 zD39nEsXY5DatQoz2RB2dL9+szlGtJSVTXgHXcw=
X-Google-Smtp-Source: AGHT+IFO8LSq4IcWvVI4KbqXjz3cW0CUI+vezCe8The2M5NDrow5yRvOHVireRni3rXBipUeZ5KP/Q==
X-Received: by 2002:a05:6a00:b42:b0:6be:30f1:45f8 with SMTP id
 p2-20020a056a000b4200b006be30f145f8mr10676184pfo.20.1698613730638; 
 Sun, 29 Oct 2023 14:08:50 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 z11-20020aa785cb000000b006c0685422e0sm4622847pfn.214.2023.10.29.14.08.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 14:08:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/11] tcg: Move tcg expanders out of line
Date: Sun, 29 Oct 2023 14:08:37 -0700
Message-Id: <20231029210848.78234-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This reduces the amount of code within tcg-op-common.h, and the amount
of code in the code segment full stop.

With many translators these days, we're putting the expander function
addresses into tables, or pass them to other general target-specific
expansion helpers.  At present that means we get out-of-line copies of 
these functions anyway.  If the target is implemented with multiple
translation units, we can get multiple out-of-line copies.

This is also a necessary step in making tcg/arch/tcg-target.h private.

Top few code size reductions:

	-89k	qemu-system-ppc64
	-88k	qemu-system-aarch64
	-60k	qemu-system-mipsel
	-50k	qemu-system-arm
	-42k	qemu-system-riscv64
	-33k	qemu-system-i386
	-33k	qemu-system-m68k
	-32k	qemu-system-tricore


r~


Richard Henderson (11):
  tcg: Mark tcg_gen_op* as noinline
  tcg: Move tcg_gen_op* out of line
  tcg: Move generic expanders out of line
  tcg: Move 32-bit expanders out of line
  tcg: Move 64-bit expanders out of line
  tcg: Move vec_gen_* declarations to tcg-internal.h
  tcg: Move tcg_gen_opN declarations to tcg-internal.h
  tcg: Unexport tcg_gen_op*_{i32,i64}
  tcg: Move tcg_constant_* out of line
  tcg: Move tcg_temp_new_*, tcg_global_mem_new_* out of line
  tcg: Move tcg_temp_free_* out of line

 include/tcg/tcg-op-common.h     | 538 +++---------------------------
 include/tcg/tcg-temp-internal.h |  56 +---
 include/tcg/tcg.h               |  77 -----
 tcg/tcg-internal.h              |  18 +
 tcg/tcg-op.c                    | 566 +++++++++++++++++++++++++++-----
 tcg/tcg.c                       | 104 +++++-
 6 files changed, 664 insertions(+), 695 deletions(-)

-- 
2.34.1


