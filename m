Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1F072F20B
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:36:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FCA-0004eY-Ak; Tue, 13 Jun 2023 21:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FC7-0004dt-Mr
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:07 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FC6-0004Ux-4j
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:07 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-652699e72f7so4751807b3a.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705664; x=1689297664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eEXufG7+S9skUG0ZAdZdSP3hOIYNAn3OZ8ZcgLO/yXM=;
 b=QtjDODEHPTDQMf1Ck0OF7C4sThtcY+u1q777CuhAnUAyBZeS1dnYOABiN7pZmjA1fT
 D/9QLxv2gkNoSeMXiUJjfNv658HxgPivXjcaR7keOdsf0nvyO3JkkOLSxT1rk/NSLjFM
 ptn5DMT+7Ij4puzuMUWbvPYdi21yxgIPZfo7h7dzmMx3uqjmxNpTNjh4nl+0sbygiKM7
 BaVGmM6yrGshIfXh3BLKfF+q46biX6VnFk6dxKmNaDIctaQDzZ5xpw7lBkEmqRfkOdsZ
 SuEj6MR6yXLxllGfgF2wWZTn4rfkz92Iu49YpR7LdGByz0cbh2gSkcy0x3i4wU5ndMDW
 7uTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705664; x=1689297664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eEXufG7+S9skUG0ZAdZdSP3hOIYNAn3OZ8ZcgLO/yXM=;
 b=Ne90oSoCYje/PJQcQo7PqU9KfSs4LuYY5ZuxoMEhdwoJrehfAA8ab1oyuJFs590Adc
 jxMx1PGiuBk0fD1u6mi0ToFq3sD6y6JmvVqlkq+dWXd5dCsa4g1zhmW8GX0IvYMB9h6c
 GlImvddvZhYm70lBlmpt8YVpBxKeNRz9ZyVdkh6ZpTAH46GnF456vUnero3tYEVsQYW1
 j6VZaGD97fQgU7NddUwe2iO4Jerh8fVT0M/P0tfKwtGn0c2tSrans1PiULlCuxw2JcFW
 rJLCG2Tm3xKmwZeGppgyHExiggOCrqYK9paxKVEnXnZuQRDkmTHDCCUWuiflG87P1S5c
 o8Nw==
X-Gm-Message-State: AC+VfDwa3t30kMD8Y0KoZKeRm7Wg2oP+VYu6tCxIt4z3aASb3mQba1AZ
 jHwEEtEEvAFGgeMdTjfSBHumRELoJ60CpA==
X-Google-Smtp-Source: ACHHUZ5pqmMUitcK7LceLDq9zbQO7hRQTpRStFdfkaj/0sZShnfF6rGf/NFaiTNq3oTl9OpIHqrF8w==
X-Received: by 2002:a05:6a00:9a4:b0:664:2f24:5578 with SMTP id
 u36-20020a056a0009a400b006642f245578mr492908pfg.13.1686705664483; 
 Tue, 13 Jun 2023 18:21:04 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:21:03 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 07/60] target/riscv: Mask the implicitly enabled extensions in
 isa_string based on priv version
Date: Wed, 14 Jun 2023 11:19:24 +1000
Message-Id: <20230614012017.3100663-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42c.google.com
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

From: Weiwei Li <liweiwei@iscas.ac.cn>

Using implicitly enabled extensions such as Zca/Zcf/Zcd instead of their
super extensions can simplify the extension related check. However, they
may have higher priv version than their super extensions. So we should mask
them in the isa_string based on priv version to make them invisible to user
if the specified priv version is lower than their minimal priv version.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230517135714.211809-6-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a0c4acfb47..81a785d525 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1758,7 +1758,8 @@ static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
     int i;
 
     for (i = 0; i < ARRAY_SIZE(isa_edata_arr); i++) {
-        if (isa_ext_is_enabled(cpu, &isa_edata_arr[i])) {
+        if (cpu->env.priv_ver >= isa_edata_arr[i].min_version &&
+            isa_ext_is_enabled(cpu, &isa_edata_arr[i])) {
             new = g_strconcat(old, "_", isa_edata_arr[i].name, NULL);
             g_free(old);
             old = new;
-- 
2.40.1


