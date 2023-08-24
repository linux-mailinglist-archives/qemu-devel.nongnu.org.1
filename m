Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE4178778C
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 20:13:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZEpA-000679-Ai; Thu, 24 Aug 2023 14:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qZEoy-00066N-56
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:12:41 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qZEov-0001kT-N7
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:12:39 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-56b0c5a140dso35268a12.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692900756; x=1693505556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDnDMiaLlkKdKPyuMD9lZt7zOa1hw99W+ENZjRrOYpE=;
 b=oHSnkKtP7XngEBxgzpYEzOxCK33J4+c8zeWsb27RT2ARSn2Z6sIySdUEQ4NY7wx9sa
 Y3gyt+wn856B705d2dn+C7b35xtNkMQX1qZC/oqFzHr2j6CNBb/0Z4/VY1Nv30E15uKY
 ZCD58xguEYcRZb/ThUfd0b3jWxgUfeEx5J99CGlBasNcSAoIQYVYXsRELfq/X1Rbyrpt
 epF3umiUA0RXzTq5JQeKF0XoLhqYPBb7IfTq7LUBUDq69wXeqOPLgzRrJfon6poS1IkD
 AACLshuNDCtKx9ClzLEF0aH1a49QvHBjMZmYfafbfRTcetj6B/Rbv/DgQUuhQSpVi9uO
 GGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692900756; x=1693505556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eDnDMiaLlkKdKPyuMD9lZt7zOa1hw99W+ENZjRrOYpE=;
 b=NOEajcxhiF5/XiLmaL00JHO3rEYLCmfTnCAtVSWze4K79pK2NITHeGSXDZ6fddka1B
 Lhbza+lI+u9bTbQxLt+6wQkL1qjNINsb3hvfSQ5cQeabS/r6iSwiMuey1aBnosKHSnRO
 5qaZjRjjUnIyrIHEEMAnm0myg3go8rk+qyxTfkfDtoK84NsUyPWML/lVIYZoF2UHoSan
 4ka1zkBCEnoEpWO/7g5/E+s4PJihtnKn0OSdW0Acd2EajixeUudnonpjtb0uosCUgd+C
 Q4TAo9qStq11qDph2LMCRY57GOaqsDmjdGUJilZIH34F24fWZp6oqWOdhd9fB/lWe0HU
 QBTg==
X-Gm-Message-State: AOJu0YwEA7PiWWh87K9yE3bpzE81D4MqnsVrfwKX9y0w8jwxdnxSeiMw
 63i2/poMKPSC7Y8AXjEcij0GTXtuNvydgjM98JY=
X-Google-Smtp-Source: AGHT+IF/2KYNAaTaXnQHEq47gLnJgylxay3AEDsMvq2ZvUovtqxCO5HkWJj5AOG8vpez/DSsbUujuQ==
X-Received: by 2002:a17:90a:c68a:b0:26d:1e39:faae with SMTP id
 n10-20020a17090ac68a00b0026d1e39faaemr14052806pjt.22.1692900756431; 
 Thu, 24 Aug 2023 11:12:36 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:5418:3064:bd46:c048])
 by smtp.gmail.com with ESMTPSA id
 n20-20020a17090ade9400b0026cecddfc58sm1880544pjv.42.2023.08.24.11.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 11:12:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 1/2] accel/tcg: Add plugin_enabled to DisasContextBase
Date: Thu, 24 Aug 2023 11:12:32 -0700
Message-Id: <20230824181233.1568795-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824181233.1568795-1-richard.henderson@linaro.org>
References: <20230824181233.1568795-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h | 2 ++
 accel/tcg/translator.c    | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index a53d3243d4..e89c182cca 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -72,6 +72,7 @@ typedef enum DisasJumpType {
  * @num_insns: Number of translated instructions (including current).
  * @max_insns: Maximum number of instructions to be translated in this TB.
  * @singlestep_enabled: "Hardware" single stepping enabled.
+ * @plugin_enabled: TCG plugin enabled in this TB.
  *
  * Architecture-agnostic disassembly context.
  */
@@ -83,6 +84,7 @@ typedef struct DisasContextBase {
     int num_insns;
     int max_insns;
     bool singlestep_enabled;
+    bool plugin_enabled;
     void *host_addr[2];
 } DisasContextBase;
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 1a6a5448c8..37f8dadbbd 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -156,6 +156,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
     plugin_enabled = plugin_gen_tb_start(cpu, db, cflags & CF_MEMI_ONLY);
+    db->plugin_enabled = plugin_enabled;
 
     while (true) {
         *max_insns = ++db->num_insns;
-- 
2.34.1


