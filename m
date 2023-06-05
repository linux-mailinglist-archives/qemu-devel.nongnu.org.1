Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFCA723320
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 00:25:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Ict-0008It-3G; Mon, 05 Jun 2023 18:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6Icq-0008HS-QZ
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 18:24:32 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6Ico-0005we-72
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 18:24:32 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f6d7abe9a4so47982345e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 15:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686003868; x=1688595868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SxRmr/I1VpSZkmrvvvEhVA2TInHdyZDnBscGrBEdNSQ=;
 b=aQssGCvLFKYPpOVBm8UOh8EL55qTwGNg1Jk0vgpc4ROrSkCfUdlTCr0hkP2tA89adF
 m1mrTvpC4Y+47EPDB3tqY72+gabE0peNZpeo1sPpFui88GrxX7/fpW8ULvbnPrbNgM5j
 mX6QTZ/+qQPLIkXwOpKbgRNka5rl4I8LTY+M/crF632TxCd8nv8HucddOuOwbHoe/fkE
 xyKnZbnZ8kenvwSpkKqmxVvQehW5uRSee8jRA5BD6sbEPKgw1zaJCkpu/0PhgPtLD6x4
 RQ2UWqWoyxNpXdw1PiICXFhlcTn7POPuS28aa+X6COfiwW43JhAyXSKP+mg2QHZURZBF
 pXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686003868; x=1688595868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SxRmr/I1VpSZkmrvvvEhVA2TInHdyZDnBscGrBEdNSQ=;
 b=CseI1YIQ8BBlRO/rHtHbvb918ukTpCDWNze7UMV4XUQlt9dXPFEGjOppsvOkWAErIs
 svuRKo1NjYuy9hyDmeQmdqoej0/57Odt0qHu7xvaOONh0Cjmw2XHhccswyAdnSRnzQmE
 OoKxVxpB/z4nfGen9cVAnyQ0vC20aT9b+33lr089tSHveZOfFEMJGcF4SVtCkRS55QvA
 F8mjSU9fOs9oq8EDzuzZGqR4l6MPY1csUzFEVduBCT3jyy7dYXlD/SQMt6JxaNXkmZs1
 wyqJHEYb6WHnHtdRA9l3hpKVcPL/j8ZbvEHx49BReu01uylWbsNSxMPnV5+Wkbx3TZu3
 ic6Q==
X-Gm-Message-State: AC+VfDwMH21w82eGwoJrbQVeID/ppsKrXa8HBZTelRkxTr3f8ivciv1y
 TuSGRZI2y5ZQ36u5lGAxKqNSy2tahWx5OlHrsVY=
X-Google-Smtp-Source: ACHHUZ5oOF/Rrf7E8mz0276W4pv0k4nSmy8nhFjdsu6ifquP02rya07hYbszd9mLqgejxj1JUxtF/w==
X-Received: by 2002:a05:600c:220e:b0:3f7:3673:5429 with SMTP id
 z14-20020a05600c220e00b003f736735429mr355827wml.2.1686003868416; 
 Mon, 05 Jun 2023 15:24:28 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a1c7c0b000000b003f60faa4612sm11989320wmc.22.2023.06.05.15.24.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Jun 2023 15:24:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 1/9] target/tricore: Remove pointless CONFIG_SOFTMMU
 guard
Date: Tue,  6 Jun 2023 00:24:12 +0200
Message-Id: <20230605222420.14776-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230605222420.14776-1-philmd@linaro.org>
References: <20230605222420.14776-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We don't build any user emulation target for Tricore,
only the system emulation. No need to check for it as
it is always defined.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/tricore/helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 114685cce4..cd34b34133 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -30,7 +30,6 @@ enum {
     TLBRET_MATCH = 0
 };
 
-#if defined(CONFIG_SOFTMMU)
 static int get_physical_address(CPUTriCoreState *env, hwaddr *physical,
                                 int *prot, target_ulong address,
                                 MMUAccessType access_type, int mmu_idx)
@@ -56,7 +55,6 @@ hwaddr tricore_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     }
     return phys_addr;
 }
-#endif
 
 /* TODO: Add exeption support*/
 static void raise_mmu_exception(CPUTriCoreState *env, target_ulong address,
-- 
2.38.1


