Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D9C82ACDA
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:07:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNsso-0001nE-Pj; Thu, 11 Jan 2024 06:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssL-0001PM-78
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:31 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssH-0004Yq-Uv
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:28 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e54b2e437so22224185e9.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971124; x=1705575924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dPASAMQebICClfujL1GDn0UotimEe/hhOLtey9oE2+o=;
 b=Q/05WpzGsDdIawxHn9Z30sZQqyGHZ/PLccuxBrgFbl4TBXAuNIHoeMUFpoGPOZjM05
 4KGdUwS0AUpzTT/OKxuU/zxtDYliCjnq/iL7xFiVqER12fOzBn2+E7+FY5E3sjGyArEr
 kVXhvzixdkJIjgllAkAu80Ncce6l+6FKHz+dljbjVEIbChxheNSD+QW4et2gfhCV/LyB
 kEBiSw/1LEu9HnYDS0/hlqDOA8AmY4X7f5u0gx55kMrl+yysdk1qWqqcP8CoE7g+Am6e
 82vdg91YJzlQaq7xxIYWIPj76PILcjID30pF15jz+OxRO9a3GyOipQKNiQ5sFWvS85aA
 6zww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971124; x=1705575924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dPASAMQebICClfujL1GDn0UotimEe/hhOLtey9oE2+o=;
 b=k7RdBBZO7WzqVoqD6KVbJDcUe12S0mYSMEYpnxgqCLdw/pj1jkH2mRbUhzWt2BTXsx
 SeLKKymHxLMZimetvgn0HVtqj1uY1qj1WRFc+XcGakxbcJ+s84gaMrofdVtYNaakn971
 U2iuY98SXEcGWAywiLZggA2+CJ7sCX6l9zTd/PzcGMIJVekQQSC5ZTdc0Oo3E/fHdopw
 9IlxebuxkmO3DoLR6xB1w/AF/2zpOW4yj+fEbgbiqGsNCiJdkJsYkcCLDcnQLmE+B3LN
 MSdtFfTb3X69ckpUM2G7abAo6R+sW8NzHT+GwuMLU6OCUwH0lyHCtC8uQaoB1GOQskwS
 KoMg==
X-Gm-Message-State: AOJu0YzuuPGGPxW4++B5rc+HbsnzBmIsoDLbutoz6aqEtDdHdGuJOnx9
 gXSOf0aHrj52iH4beGYRV5wgMu1Wjc/fvxjsHT4UpXtSHiM=
X-Google-Smtp-Source: AGHT+IGMwvcc6BqpGSa5vGtMqKVa0Wze5Pp2NTg4jhuwMcqLBsNLz+/6cei7AYMHxs5mduWsKEbT2w==
X-Received: by 2002:a05:600c:3c83:b0:40e:4d77:dbf7 with SMTP id
 bg3-20020a05600c3c8300b0040e4d77dbf7mr298265wmb.163.1704971124385; 
 Thu, 11 Jan 2024 03:05:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/41] target/arm: Enhance CPU_LOG_INT to show SPSR on AArch64
 exception-entry
Date: Thu, 11 Jan 2024 11:05:04 +0000
Message-Id: <20240111110505.1563291-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

We already print various lines of information when we take an
exception, including the ELR and (if relevant) the FAR. Now
that FEAT_NV means that we might report something other than
the old PSTATE to the guest as the SPSR, it's worth logging
this as well.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 target/arm/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4550ff7ffde..dc8f14f4331 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11416,6 +11416,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     }
     env->banked_spsr[aarch64_banked_spsr_index(new_el)] = old_mode;
 
+    qemu_log_mask(CPU_LOG_INT, "...with SPSR 0x%x\n", old_mode);
     qemu_log_mask(CPU_LOG_INT, "...with ELR 0x%" PRIx64 "\n",
                   env->elr_el[new_el]);
 
-- 
2.34.1


