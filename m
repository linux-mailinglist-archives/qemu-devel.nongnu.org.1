Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 401C770CFBB
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 02:46:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1G9L-0005vo-NU; Mon, 22 May 2023 20:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1G9J-0005vg-0n
 for qemu-devel@nongnu.org; Mon, 22 May 2023 20:45:13 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1G9F-000498-Uw
 for qemu-devel@nongnu.org; Mon, 22 May 2023 20:45:12 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ae58e4b295so43723895ad.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 17:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684802708; x=1687394708;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hhTuf+o9ChrgkJKXC25o46KxXkLp19PuNLIAwbshpD4=;
 b=ry4s2Mgp09JXehjTBXTfVlJ4gfc1VzJ532sqy1t+D4gdTLlIOlQmNnxbR6vC7l1AXG
 UATuTPGTKkuhB8aCSn1JzNlLpzq2jHToyFTqchfjvBXDWfxxaIrIC3CzebkWgUwcDgj0
 6TUyQPli5j7Q/Jd9Wa+B1U9wlRm2VdnpYtSCNA1juzqltq6YNIwZ/39bq/zecL7nsNMc
 CVJy0mFb5oYup6O46ZfQRfMi3fCfK5yS1SIibt7VwAf1qDsEpp06qXxyHRaalBkT3D3I
 kbT81Yfqup9/Hx9g5KSk71rPxypxTyK9ZRtI2PJtxL7tlzY9NMt8PfyRNrDySB8UHNWW
 BbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684802708; x=1687394708;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hhTuf+o9ChrgkJKXC25o46KxXkLp19PuNLIAwbshpD4=;
 b=WEHkV7ThPq5t12hPETAAqNqNotnGa1CK92sQAdogV+WT4/E5u1gwr/ku4ePpDzP4Jy
 p/L+h9Ho2oF0Rla/Ynl0qn8xWQJd26mTi8i6MmNiIAscblrdJBYarqvARD2IiXoz2GgF
 1BP2fI54JZAEammQAUbYbSX7xMAdtjqkSohi5ExyRZsXX/6X2C1pP9JZDCXsRidemSoZ
 T57w/UmYy8ESH0vquevtNb0G8nURNwAnlUyeKTj9JIskzD3RCbkwsDYXe/fuczeBdXL0
 cqHTJzTRX5VG039eo0U51qhRQ7APkXZ56qabZMIO87tSAMrUgARX5GVcgaGqpl/6uFJj
 0vGQ==
X-Gm-Message-State: AC+VfDwhBvsjRxw9XKvJIPqbqMRD2r9G0gpTmlQt6prE1E6vZtEfyYkC
 zfSxQmQucLIEhbR/mZh6xHPGJw==
X-Google-Smtp-Source: ACHHUZ5XdIxNtxuV6hzQFqHI2qnVamsV+t9fHeYW6wQR0xw+sgf4g9f0zwT8cqZhDiUa0CktCCX6ig==
X-Received: by 2002:a17:903:1d2:b0:1ac:7260:80a7 with SMTP id
 e18-20020a17090301d200b001ac726080a7mr15543475plh.43.1684802708099; 
 Mon, 22 May 2023 17:45:08 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:86fe:2b34:5897:c8ef?
 ([2602:ae:1598:4c01:86fe:2b34:5897:c8ef])
 by smtp.gmail.com with ESMTPSA id
 q7-20020a170902a3c700b001ab39cd875csm5487702plb.133.2023.05.22.17.45.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 17:45:07 -0700 (PDT)
Message-ID: <0bf482cc-fb96-0ada-f166-50d99b4952a5@linaro.org>
Date: Mon, 22 May 2023 17:45:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v12 02/15] accel: collecting TB execution count
Content-Language: en-US
To: Fei Wu <fei2.wu@intel.com>, qemu-devel@nongnu.org, alex.bennee@linaro.org
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230518135757.1442654-1-fei2.wu@intel.com>
 <20230518135757.1442654-3-fei2.wu@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230518135757.1442654-3-fei2.wu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/18/23 06:57, Fei Wu wrote:
> +void HELPER(inc_exec_freq)(void *ptr)
> +{
> +    TBStatistics *stats = (TBStatistics *) ptr;
> +    tcg_debug_assert(stats);
> +    ++stats->executions.normal;
> +}
...
> +static inline void gen_tb_exec_count(TranslationBlock *tb)
> +{
> +    if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
> +        TCGv_ptr ptr = tcg_temp_new_ptr();
> +        tcg_gen_movi_ptr(ptr, (intptr_t)tb->tb_stats);
> +        gen_helper_inc_exec_freq(ptr);
> +    }
> +}

This is 3 host instructions, easily expanded inline:

--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -11,6 +11,7 @@
  #include "qemu/error-report.h"
  #include "tcg/tcg.h"
  #include "tcg/tcg-op.h"
+#include "tcg/tcg-temp-internal.h"
  #include "exec/exec-all.h"
  #include "exec/gen-icount.h"
  #include "exec/log.h"
@@ -18,6 +19,30 @@
  #include "exec/plugin-gen.h"
  #include "exec/replay-core.h"

+
+static void gen_tb_exec_count(TranslationBlock *tb)
+{
+    if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
+        TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
+
+        tcg_gen_movi_ptr(ptr, (intptr_t)&tb->tb_stats->executions.normal);
+        if (sizeof(tb->tb_stats->executions.normal) == 4) {
+            TCGv_i32 t = tcg_temp_ebb_new_i32();
+            tcg_gen_ld_i32(t, ptr, 0);
+            tcg_gen_addi_i32(t, t, 1);
+            tcg_gen_st_i32(t, ptr, 0);
+            tcg_temp_free_i32(t);
+        } else {
+            TCGv_i64 t = tcg_temp_ebb_new_i64();
+            tcg_gen_ld_i64(t, ptr, 0);
+            tcg_gen_addi_i64(t, t, 1);
+            tcg_gen_st_i64(t, ptr, 0);
+            tcg_temp_free_i64(t);
+        }
+        tcg_temp_free_ptr(ptr);
+    }
+}
+
  bool translator_use_goto_tb(DisasContextBase *db, target_ulong dest)
  {
      /* Suppress goto_tb if requested. */


I'm not expecially keen on embedding the TBStatistics pointer directly like this; for most 
hosts we will have to put this constant into the constant pool.  Whereas the pointer 
already exists at tb->tb_stats, and tb is at a constant displacement prior to the code, so 
we already have mechanisms for generating pc-relative addresses.

However, that's premature optimization.  Let's get it working first.


r~


