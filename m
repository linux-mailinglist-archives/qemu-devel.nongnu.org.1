Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A834D74B031
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:46:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjij-0007k5-D9; Fri, 07 Jul 2023 07:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjih-0007ee-DY; Fri, 07 Jul 2023 07:33:51 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjif-00075z-UV; Fri, 07 Jul 2023 07:33:51 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6b5ef64bca6so1625248a34.3; 
 Fri, 07 Jul 2023 04:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729628; x=1691321628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QkjDD2MyIJf1W+5sZdfrx7JqdlOzHwifJlixrav+Tr8=;
 b=dQyKtjvKEcFGqWzBWIZD9lhfBZYeck+bO9PxtEv6fqGCcYkSIBXAC6h1FT0ipEO8O0
 vHd61JMgcy8x6dRRtSjFNmtpujrk8n0xU/T1b4+sKOMQsPYhIo5hbZAna1EUZHGlhYkw
 3vztgGbQiK7sIODC8M2WUxdBNfuMGa2xUaf8bZ4skiWxrhLLBNrPd9Xi5zXazhRdHuQK
 n57rHd3v8HD3zBuzFjLeGxI8mNJe331qlaskTooSaRCHINX2wqkDVPQDIJDk/JIh7rux
 DemJAQXkhUFJ8b4vs/lb9npy5rgcudXdgIms5dEE8eEwOsbY2XySJybqM9aHPlDBmKp9
 1Mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729628; x=1691321628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QkjDD2MyIJf1W+5sZdfrx7JqdlOzHwifJlixrav+Tr8=;
 b=NyvGpjaasBkjoquB0P7Kx3zpksMqoLCdMVA521C6VLgJiGWTxdsK7K3X4S36kvNSRN
 fif6/hDBJbNq9edHbOrmKKbel3i4rny8sViJSzU/Sx6jxcVa9k2gF20H/4cnWsbUdHFE
 R9yV6/XRWc0aLL9rtRQLj8Lh4pEmHLSgy8MEIxmf/bq7lyC/J5kEeWeySwYMR7mO+zfU
 1MJKs8UwUKECx0KhFEZJXL4GwTo1aHtfsB/vFDe3am1vvlqAp6dQgfVbVQ2JA2Lwis9O
 OCWMjMZKrtAPSHrZFMsEpFLsnSFrbiQVtzDGmElNgaKZy5MEkR1XHpLLHSWVEyHpD2ly
 Am3w==
X-Gm-Message-State: ABy/qLahRx5+w9ZYwtaPeRrGjtft6avbDuKFBspi4DizkKY8RK/xYoAt
 hf/1AKvnYtTklFzhs6lRGIKm85Zwy6M=
X-Google-Smtp-Source: APBJJlFhdJiDUNbIEkmw3HoPiHHJlPXxRnfNOwv69vSgzMDLYUODLThV/OMf8o8pulpmFj3679Ginw==
X-Received: by 2002:a05:6830:1314:b0:6b7:3dab:dbd6 with SMTP id
 p20-20020a056830131400b006b73dabdbd6mr1305234otq.15.1688729628451; 
 Fri, 07 Jul 2023 04:33:48 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:33:48 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Greg Kurz <groug@kaod.org>
Subject: [PULL 58/60] target/ppc: Remove pointless checks of CONFIG_USER_ONLY
 in 'kvm_ppc.h'
Date: Fri,  7 Jul 2023 08:31:06 -0300
Message-ID: <20230707113108.7145-59-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x335.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-ID: <20230627115124.19632-7-philmd@linaro.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
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
2.41.0


