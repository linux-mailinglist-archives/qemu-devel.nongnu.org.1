Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DD173FB6A
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 13:53:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7Eu-00025c-Pa; Tue, 27 Jun 2023 07:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE7Er-000248-V2
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:52:05 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE7Eq-0004oK-Cj
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:52:05 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51d805cb33aso4575520a12.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 04:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687866723; x=1690458723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Exw+JZXOL4uO7+3m9iYv0CMoNufl6q663SemmcVGUDs=;
 b=D243fL8YZ2ilzOwTH/R8fl1t9I9RYRViHPE68ZXBeP+S469Nr7nvuq4AqADY5HOsyu
 zq9quS90T8MgbQ7+yyRMLjcPtSE347AwW60WlQ5t5OYGSNaz7KMjHMqpR7rujdO0iMOA
 aryT5Wtx7M4p6y+JSfmdYDUCxAileqJkzUDSh09Pd7zzPJF5NxyXSdYhWqjSx0z7vcH6
 7COGTXxcsk0Z+/cqu6QwPo0GsQRk5kPyiXvWmbRjqTvBaPU8ZKuhCKlUhnOUzOGLhqBL
 sIRRkvo2lkxuucS9iU0L65KEQvNQJP1J0HA58464MLtV2nvdEqSTC3ASlRMC5nMBKKHW
 ZlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687866723; x=1690458723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Exw+JZXOL4uO7+3m9iYv0CMoNufl6q663SemmcVGUDs=;
 b=doK12Wtnfms1jq4fX5v4uUZQlWiSCnGENYPd8VoAIuHp72tQAEsw/0iIiOQl7jGyWf
 xCHSDLRQO+qwGJs6mznxnAnb8XQCt4jRu3HXYUaRB25MbHG/bIpjxnCXyCwkdy3yXiaH
 ByrF0jWTfZNt0ZDY8P6D74+HVPbI8cwuFZsQA7wCWz+ri33qkwzdMGBhTDiOSLoUvdrl
 umpZATDojRuEUN7200LbVGg/3PjfqwWdO4Y6od0SVZUp+GMLrqqv4RuyKjpT//YuY2BA
 TuQQQt0sg+O2OmSSGi2VzEmc3QfUOUolhIycBtvOUIYqvSbXPNYEhnybBur+fzBos8vS
 jRDQ==
X-Gm-Message-State: AC+VfDyzttgdXULpvY2b/Wl+GoSFE7YVBe1x//CYpqaFx0ZJa+eaomN2
 0hfhb04wWkaOZzqlwJVGf6FzG68qVHOGIJjlN1A=
X-Google-Smtp-Source: ACHHUZ6uCsnqM9P3N/MzuPiI6BmEG2Gg8wTsAU8ZrHvRjeKw1Voa0SIfZlyjcTP+MPN77umcbDZmgA==
X-Received: by 2002:a05:6402:498:b0:519:b784:b157 with SMTP id
 k24-20020a056402049800b00519b784b157mr20050286edv.12.1687866722978; 
 Tue, 27 Jun 2023 04:52:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a056402040e00b0051d890b2407sm3384524edv.81.2023.06.27.04.52.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Jun 2023 04:52:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>,
 kvm@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 6/6] target/ppc: Remove pointless checks of
 CONFIG_USER_ONLY in 'kvm_ppc.h'
Date: Tue, 27 Jun 2023 13:51:24 +0200
Message-Id: <20230627115124.19632-7-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230627115124.19632-1-philmd@linaro.org>
References: <20230627115124.19632-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/kvm_ppc.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 901e188c9a..6a4dd9c560 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -42,7 +42,6 @@ int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu);
 target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
                                      bool radix, bool gtse,
                                      uint64_t proc_tbl);
-#ifndef CONFIG_USER_ONLY
 bool kvmppc_spapr_use_multitce(void);
 int kvmppc_spapr_enable_inkernel_multitce(void);
 void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
@@ -52,7 +51,6 @@ int kvmppc_remove_spapr_tce(void *table, int pfd, uint32_t window_size);
 int kvmppc_reset_htab(int shift_hint);
 uint64_t kvmppc_vrma_limit(unsigned int hash_shift);
 bool kvmppc_has_cap_spapr_vfio(void);
-#endif /* !CONFIG_USER_ONLY */
 bool kvmppc_has_cap_epr(void);
 int kvmppc_define_rtas_kernel_token(uint32_t token, const char *function);
 int kvmppc_get_htab_fd(bool write, uint64_t index, Error **errp);
@@ -262,7 +260,6 @@ static inline void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
 {
 }
 
-#ifndef CONFIG_USER_ONLY
 static inline bool kvmppc_spapr_use_multitce(void)
 {
     return false;
@@ -322,8 +319,6 @@ static inline void kvmppc_write_hpte(hwaddr ptex, uint64_t pte0, uint64_t pte1)
     abort();
 }
 
-#endif /* !CONFIG_USER_ONLY */
-
 static inline bool kvmppc_has_cap_epr(void)
 {
     return false;
-- 
2.38.1


