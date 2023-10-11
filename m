Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DEE7C5040
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:35:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWXM-0001dd-54; Wed, 11 Oct 2023 06:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWXA-0001MZ-BQ
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:45 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX6-0005HZ-GJ
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:44 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-406609df1a6so63997545e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697020419; x=1697625219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pu5EXKGxbl4h50PEu15NUratwzwygqcDFyq/bZZGLKA=;
 b=mryxe3LxispMPCRD6tywTZJpUNbKmE/6NdvM9e31wJa8AlYA3Wbviqk7K4sI16cB++
 h0RrBzHMvS7V/S7cDxrBVDDSRRGfQLi7RG3JJAc2/cN4YNp5GRbG4yLYQpuWclOMWy6q
 ezEVj4Uea4QknrhIaahzzEt1/bEVOhjHiiHcTu39WUiK8y5HJDO89euBd+98Jsfb3Kiy
 Ra54dJJT0TKxIm84UHVe2kw6Qqf4vOfH4k+fdQP00NeuoFrW0t1IsazeV2jFIFB0cZLN
 oGP5XJhskaXOqPYhDz4XrFUNe+ngZzQrcRc3XLDursuEH2peFCyyyQErSNY5j5DijeMK
 /oYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697020419; x=1697625219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pu5EXKGxbl4h50PEu15NUratwzwygqcDFyq/bZZGLKA=;
 b=na7YiY8RsLDBC4Ru1uyuiHMlsGQsobtVtzKdwOv5Bds3K/YcY1lpFLScKi43tyWkZt
 r0wukarOFc7SRkxenO/n6ik+NOwkbLkd84YvlQUYz7W1zXoezJqtPkchD1b9rDv5gZk0
 GxwUyl6uux7YYJQLagHM1+08Zo4ftS6EsYROM9w1v99l3GYz84m9iH/8Y2KfHHims2Vm
 MiycEgHjjwV/+J21zi1CNyLjZRtl5RbBu81xt3wzD10w1nTD7WfneBu1S5r0ErkUlIPS
 j8XxeHRB+LxzTnvBfWzsHkpit8xQL3zAQfeP9ZX4xZIDaaKq6EmiIX+4b+wxm7HXpFFQ
 etHA==
X-Gm-Message-State: AOJu0YySymGMyBq1SsuIocef1RtH7ndtvTBAvBNfcAWSXYuAV87lLsTk
 /QuJ7mkBPgvkIA1kMe5/DPJOgLDFoA6ryX5FZAM=
X-Google-Smtp-Source: AGHT+IEDedtLFWcviJjiuCeEvY459bTYPgm4N15vXPPaoT14d8cUBT/WzJGsfV4jpJ7QLj1ObGVj6w==
X-Received: by 2002:a05:6000:10c2:b0:321:68af:947 with SMTP id
 b2-20020a05600010c200b0032168af0947mr16601830wrx.8.1697020419204; 
 Wed, 11 Oct 2023 03:33:39 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 bp22-20020a5d5a96000000b0032ce54bacb1sm4599276wrb.0.2023.10.11.03.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:33:36 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5B2D21FFCC;
 Wed, 11 Oct 2023 11:33:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 20/25] accel/tcg: Add plugin_enabled to DisasContextBase
Date: Wed, 11 Oct 2023 11:33:24 +0100
Message-Id: <20231011103329.670525-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011103329.670525-1-alex.bennee@linaro.org>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230824181233.1568795-2-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231009164104.369749-21-alex.bennee@linaro.org>

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 9d9e980819..6d3f59d095 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -73,6 +73,7 @@ typedef enum DisasJumpType {
  * @max_insns: Maximum number of instructions to be translated in this TB.
  * @singlestep_enabled: "Hardware" single stepping enabled.
  * @saved_can_do_io: Known value of cpu->neg.can_do_io, or -1 for unknown.
+ * @plugin_enabled: TCG plugin enabled in this TB.
  *
  * Architecture-agnostic disassembly context.
  */
@@ -85,6 +86,7 @@ typedef struct DisasContextBase {
     int max_insns;
     bool singlestep_enabled;
     int8_t saved_can_do_io;
+    bool plugin_enabled;
     void *host_addr[2];
 } DisasContextBase;
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index e7abcd86c1..c5da7b32a5 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -158,6 +158,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     } else {
         plugin_enabled = plugin_gen_tb_start(cpu, db, false);
     }
+    db->plugin_enabled = plugin_enabled;
 
     while (true) {
         *max_insns = ++db->num_insns;
-- 
2.39.2


