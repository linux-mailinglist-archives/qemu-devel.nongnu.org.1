Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1AD77796A
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 15:18:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU5XN-0003Lo-7l; Thu, 10 Aug 2023 09:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU5XL-0003LY-2P
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 09:17:11 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU5XJ-0007Hg-As
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 09:17:10 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52256241c66so1877236a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 06:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691673428; x=1692278228;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XvznmDeo1oK14c9Q6GLwEOoHv2gSi+p2PJZSwYjMG3M=;
 b=IZSghdtfkWQ72+6+i7kIB9azioGJUSy62LgBbW6TK13LJEStKXrST7GZDQSZEjyLac
 IzDSPKvEHDu+LEURTHCTHSrZWWXBDVsrhwbQOy6qwqBM85wL9VvKEggQJiVqPehgzFoj
 riDEn1l62lbVcRo1VEmEQAnMiudaBlGPOUPEhSfmDGlWhvcT0kT+YV2gOEsYa3YwMO25
 /nQcfUe5+QCLj8buGQp1VbQd2in09Mqe1tmGxN//tFF2ntaRXYX4NAcfwbVH4bn2hB6O
 RS/r+gGT7rgMLl3LkoQzFMGP2AAIOZnGdbcNp4Ta6pVVxgzfG1C784f29fiyMF2VpQjB
 lkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691673428; x=1692278228;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XvznmDeo1oK14c9Q6GLwEOoHv2gSi+p2PJZSwYjMG3M=;
 b=G+k8gFsD46wZHuMGQ2Ko4j8AbElJqyfgjH6G46mR12wRIm8759b6gr5rT4Chv4ARxH
 sTBkf0wGspcQ+WE7cUaFdKrm2TeoFhlLYHrdMLlgccw/731i4eYxfDeANUrBE8bKw3Ts
 O/9cSuYrhLUxrh5BU3kqvQMSOTzgawe+zVGJW7XU5BViI2uI0ZaGkDRrmeL0Ysb/YnOi
 OzyKSe/l+6HLVGFFr2Pl4dZIfRW2Q4iFQC1VUwxGbLvHW24ZbO/HD1wzmd8ti1ATW+Jq
 qvmXP+BAZVPzUUYfcu3ATXdSGtb6fFLVF83sTSh4NZiNrFRJ8DHkCvcGp53sIem7QWfK
 vMVw==
X-Gm-Message-State: AOJu0YyDF7eJhPNpCfqaXRUfZuBeIDtVzUXoSBdJt94jq7kT3CUyYlGn
 7gDSgZE1FOZOJ6ig5JyWOwq57/+wftMsdW7R4RiJCA==
X-Google-Smtp-Source: AGHT+IH6mxa4nWlqPUoWlLZfzqhiRswbchZZ8safXPe41J94Euhy7TseSP72ugkkbxKZxLrT/yLgezE82LvFULarrwM=
X-Received: by 2002:a05:6402:1ac9:b0:523:e25:5656 with SMTP id
 ba9-20020a0564021ac900b005230e255656mr2517110edb.5.1691673427593; Thu, 10 Aug
 2023 06:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230809123706.1842548-1-jean-philippe@linaro.org>
In-Reply-To: <20230809123706.1842548-1-jean-philippe@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2023 14:16:56 +0100
Message-ID: <CAFEAcA8wh35V4ivo2cMP6zUGgCDi6t9-AHS0FVfeLThvjHtV9A@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] target/arm: Fixes for RME
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Wed, 9 Aug 2023 at 13:37, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> A few patches to fix RME support and allow booting a realm guest, based
> on "[PATCH v2 00/15] target/arm/ptw: Cleanups and a few bugfixes"
> https://lore.kernel.org/all/20230807141514.19075-1-peter.maydell@linaro.org/
>
> Since v2:
>
> * Updated the comment in patch 5. I also removed the check for FEAT_RME,
>   because as pointed out in "target/arm: Catch illegal-exception-return
>   from EL3 with bad NSE/NS", the SCR_NSE bit can only be set with
>   FEAT_RME enabled. Because of this additional change, I didn't add the
>   Reviewed-by.
>
> * Added an EL-change hook to patch 6, to update the timer IRQ
>   when changing the security state. I was wondering whether the
>   el_change function should filter security state changes, since we only
>   need to update IRQ state when switching between Root and
>   Secure/NonSecure. But with a small syscall benchmark exercising
>   EL0-EL1 switch with FEAT_RME enabled, I couldn't see any difference
>   with and without the el_change hook, so I kept it simple.
>
> * Also added the .raw_write callback for CNTHCTL_EL2.
>
> v2: https://lore.kernel.org/all/20230802170157.401491-1-jean-philippe@linaro.org/

This didn't build for the linux-user targets. I squashed
this into patch 6:

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7df1f7600b1..d906d2b1caa 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2169,9 +2169,11 @@ static void arm_cpu_realizefn(DeviceState *dev,
Error **errp)
         set_feature(env, ARM_FEATURE_VBAR);
     }

-    if (cpu_isar_feature(aa64_rme, cpu)) {
+#ifndef CONFIG_USER_ONLY
+    if (tcg_enabled() && cpu_isar_feature(aa64_rme, cpu)) {
         arm_register_el_change_hook(cpu, &gt_rme_post_el_change, 0);
     }
+#endif

     register_cp_regs_for_features(cpu);
     arm_cpu_register_gdb_regs_for_features(cpu);

With that, I've applied the series to target-arm-for-8.2.

thanks
-- PMM

