Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EC5816C87
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:39:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBsf-0007fI-Up; Mon, 18 Dec 2023 06:33:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBsQ-00079P-Rj
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:38 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBsD-0003PU-S2
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:37 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50dfac6c0beso3464434e87.2
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899203; x=1703504003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V/3KTHhaXn8gw7Kymod6Pbk9EKXu1H7ND5ieOsslvsk=;
 b=y1LTbsBmnEo0CGkRbuvaDOOjetcY9hDfsAI9hKncJ4+1KUl0q9q2Jz6BBUDvhKbZn3
 sawpK0z9fJUMN3BPj+OZqjFi20yR2MAHeRa4UhYIuUe58fIiyUQ88H6qP45Ie6IVTcdq
 HO+W6WeYiBdXTYv4KZbiLygWb/ATHM848qGGaX0WFaP6yznIBjgQePtM1BUAhNa8u3v5
 gQ+kiAQvbExQCBfI7PacjJ543o7V99O4dHlhbM6myltW2TGGHq82pr6GQL/U1fUhjsuV
 c2TZPcOFpQ4CxHMcyv4tesoQ3YI4jtOMUDXAjuvpSKxJ7acRbNx39j0H5579rhkTt9/9
 6DJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899203; x=1703504003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V/3KTHhaXn8gw7Kymod6Pbk9EKXu1H7ND5ieOsslvsk=;
 b=fIESsdYtSJW6frENbNOgtEH1+y2mGGE7SVqt8kd39YYWLdq7pf8/w8hkPhA/LXDU8+
 DSrOMQdFyRw/AbIvAYRwIW+fki1bk7Vql7o2OGUBywu9yErrvnGyIaBXgJkgi6iyiBjB
 y5qLZjGE/QNuU/wa7lMU4DasHhMiEPS4KzvtPavNHX4+rr5sBr/xO7LIhKTA5QONi1zo
 fE0HpUCEjeCUuwg1qsiJ0WB65VEL/tqYjVqaljAdznXqF1UctUkDSy1a0KiLPLFsAOtK
 Es/mqD0C02VNE/YhbsfAGOZbF6LUmQ31Twh/Bm0jaQ/760Vkm5vvkqgloqxI7hJhssGD
 8Slg==
X-Gm-Message-State: AOJu0YzvjQ7dS3A2u4C6Jvf5pg7YbiyZCRZgHAMSlpn5/eluXN/jXLBO
 i1YcH2+2Gp/I1AVeaKcGDbqsPQKZgsGyya9JPpA=
X-Google-Smtp-Source: AGHT+IFYexsSNBqnlxcRk7deyaK5qBhUcXBXsSyTLt+s62Tu+qg7GIxMOA+KCK5lrQQTfz3XTqUa8w==
X-Received: by 2002:ac2:4114:0:b0:50e:30b3:b8ff with SMTP id
 b20-20020ac24114000000b0050e30b3b8ffmr1286041lfi.16.1702899203124; 
 Mon, 18 Dec 2023 03:33:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 34/35] target/arm: Enhance CPU_LOG_INT to show SPSR on AArch64
 exception-entry
Date: Mon, 18 Dec 2023 11:33:04 +0000
Message-Id: <20231218113305.2511480-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
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

We already print various lines of information when we take an
exception, including the ELR and (if relevant) the FAR. Now
that FEAT_NV means that we might report something other than
the old PSTATE to the guest as the SPSR, it's worth logging
this as well.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c72ce4aee09..b8604f39169 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11493,6 +11493,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     }
     env->banked_spsr[aarch64_banked_spsr_index(new_el)] = old_mode;
 
+    qemu_log_mask(CPU_LOG_INT, "...with SPSR 0x%x\n", old_mode);
     qemu_log_mask(CPU_LOG_INT, "...with ELR 0x%" PRIx64 "\n",
                   env->elr_el[new_el]);
 
-- 
2.34.1


