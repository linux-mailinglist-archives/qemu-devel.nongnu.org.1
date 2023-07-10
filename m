Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C2B74D5D2
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:38:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq5x-0004Gl-E8; Mon, 10 Jul 2023 08:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5c-0003eU-42
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:07 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5a-0004nl-E9
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:03 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6b73c2b6dcfso2667171a34.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992441; x=1691584441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qiK96Tz0+VWsWaBPDgHRD91wlyhqNn1V3rKtNqdog3k=;
 b=DWGMgVsqh16HYKVbZFORk5RWCJXXkyXDwdVjxSw18Z6UQb9pVlmeUuT5CfN/GzzNMq
 RyNH+PzEoy6xuRTEkbezDsc2ASEDSumelO+GtnKILn7pHXtf8317DreZMqoZWaAeRysn
 6HMGd8pEeqCOeEkAQg3uC3mVElQkQW71EI4V156zSlH/J6Bt5JS2qkpiBzCCt4DRE0QD
 Ltmd7EKBsKCkYKfrh4OfY3t82Xujukn3tQIabwG0DbBdEk1jWAETUBoDJmjL28IUrj5t
 ofHBvF/GeOpU87+CmvJ5ekZCGWwt1Xlveu2+XC8HgAWDE9Tbgdk0gjWd6j8cr36L1ahR
 4s1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992441; x=1691584441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qiK96Tz0+VWsWaBPDgHRD91wlyhqNn1V3rKtNqdog3k=;
 b=G/VHVwuFnAmZQ9jlEkafZBt7Z6ZACU+oJf4GXWKNhgGNyt++gK6zE2MM46sMMo6gNH
 S9CcjtIm1DpsKVnKp4G1R+MsKAYcT8atJAGMDt2pShUA2ZFvfGhVeZ8M5hIT0L3mRMjS
 +Dd9ShBbor9yx+qBGypniR0uEC7t95XRCB3AkZGnc22lynOrQK092RljTC4gjzJsaoXs
 yY130RNn1eSTzidWwEzBEUgtWejaRERwdvFBUEKztlrHnF/mbTxB302LoB6sxaIh74cP
 lp0w9wIkYa2RZTCoxkONyBcXp/KtTqHl66UNxI1Mz8lmFm1CvYzvrlMhkzh15FqXr1CI
 T60w==
X-Gm-Message-State: ABy/qLaTktLu6t2zIUlSeRamwtICAxl1J0zFameOMH3wooE0OAizKUIY
 sTEx6CmMSEQGsHvohh7ko6J6lpMdmXa05w==
X-Google-Smtp-Source: APBJJlG6HMcBR2EMeZcRZxbmdbpJ0mbQFm0xymC/3ZEpBaXcgnP8YyF04A9ZEqsR6aVffFMWh+Ra2Q==
X-Received: by 2002:a05:6830:4d0:b0:6b8:691c:88ae with SMTP id
 s16-20020a05683004d000b006b8691c88aemr7756502otd.33.1688992440896; 
 Mon, 10 Jul 2023 05:34:00 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:34:00 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 29/54] target/riscv: Expose properties for BF16 extensions
Date: Mon, 10 Jul 2023 22:31:40 +1000
Message-Id: <20230710123205.2441106-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x32b.google.com
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

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-Id: <20230615063302.102409-6-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0272b1d071..fd647534cf 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -94,6 +94,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zifencei, PRIV_VERSION_1_10_0, ext_ifencei),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
+    ISA_EXT_DATA_ENTRY(zfbfmin, PRIV_VERSION_1_12_0, ext_zfbfmin),
     ISA_EXT_DATA_ENTRY(zfh, PRIV_VERSION_1_11_0, ext_zfh),
     ISA_EXT_DATA_ENTRY(zfhmin, PRIV_VERSION_1_11_0, ext_zfhmin),
     ISA_EXT_DATA_ENTRY(zfinx, PRIV_VERSION_1_12_0, ext_zfinx),
@@ -125,6 +126,8 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zve32f, PRIV_VERSION_1_10_0, ext_zve32f),
     ISA_EXT_DATA_ENTRY(zve64f, PRIV_VERSION_1_10_0, ext_zve64f),
     ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve64d),
+    ISA_EXT_DATA_ENTRY(zvfbfmin, PRIV_VERSION_1_12_0, ext_zvfbfmin),
+    ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
     ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
@@ -1762,6 +1765,10 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("x-zvfh", RISCVCPU, cfg.ext_zvfh, false),
     DEFINE_PROP_BOOL("x-zvfhmin", RISCVCPU, cfg.ext_zvfhmin, false),
 
+    DEFINE_PROP_BOOL("x-zfbfmin", RISCVCPU, cfg.ext_zfbfmin, false),
+    DEFINE_PROP_BOOL("x-zvfbfmin", RISCVCPU, cfg.ext_zvfbfmin, false),
+    DEFINE_PROP_BOOL("x-zvfbfwma", RISCVCPU, cfg.ext_zvfbfwma, false),
+
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.40.1


