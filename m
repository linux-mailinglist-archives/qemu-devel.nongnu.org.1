Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 968777415BC
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:54:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXV0-0006yP-CO; Wed, 28 Jun 2023 11:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXUs-0006jh-Ay
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:54:23 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXUq-0008UT-MQ
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:54:22 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-313e742a787so47447f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967658; x=1690559658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jLMNH/0PsIWJuWhqZm5mNX+8fMPAi7xMcam0psgty2U=;
 b=VwqovcIg6d0q9MizOwKy7iZVU6Y3jsND0m9lz68ELL4Wc437NttRUxk9H8ek/RvnyC
 OyMOExjhRhL866LaDMrCzrZlHaETNjST6DD7j86qXioTSFoUn99YN5UAz/11CSHRW4tf
 euzti+zGFgPWM7T9Jar2wHK9aQh1gOZdLsZlT/Ocqtr0J2VapBVzbpCOmHQdX+32CGSx
 5uavl3Y6whFLW1Mp3/DTSWCH6UfMN3aol1Esl7mpp0G1bMetUEulLZqknSwA6ztfco01
 5Bs89JRPu//58hW3DVSRaBS5d66kV9lMB78lSdncSuoNMA8Dbc50+O5nm9SHbHY643U+
 C+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967658; x=1690559658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jLMNH/0PsIWJuWhqZm5mNX+8fMPAi7xMcam0psgty2U=;
 b=jHq30IrXXTCtpMWIW1VlGYJ8NF9AY7U/12oYIA0GJnPzYeGfn77edgxasG77RzbPKX
 ewAd7TixwdMQik6Hru0yzXPegZ+zDR2g1Rby60naB3sp+1XNaKHSQFhrPXQ3R+jRSCnK
 Pd8SigtBtHz71GTlnEd8y5dca0H0+wefECM7D74E1EXowJ/xbdhHAoWngkZQmPgqJipN
 ffNnfnuvbFCtxAO25Ga0yQ5oTkujyh5WfqHPmH4FxgOWA+d8kWffk+Dj26TEs2UvGRtN
 AEEg9Vzq7AiabHFU9DoTkxAItuxcqZ2GwqN7Gvy2fB5HLn/U8KFEhFg1ICZJrVdKvBvA
 z1wQ==
X-Gm-Message-State: AC+VfDyyBUKFyd4g1+kEiaqdja8blaR33bjK99JOFTe+CKhwXhzqNJux
 AIfHmOlT/JXkP8n5HOMhdBMMn49hgGfeokRjVJo=
X-Google-Smtp-Source: ACHHUZ4s4NbUffjSvtxylNyPAeJhrZwAWBr5vT4pc96D4T3fdh2DxdU7ScdoCefppfCHXdxsqHOlTg==
X-Received: by 2002:adf:fa52:0:b0:313:f5ea:44f7 with SMTP id
 y18-20020adffa52000000b00313f5ea44f7mr1744365wrr.35.1687967658403; 
 Wed, 28 Jun 2023 08:54:18 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 u13-20020a5d514d000000b0030e56a9ff25sm13500991wrt.31.2023.06.28.08.54.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:54:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/30] accel: Remove NVMM unreachable error path
Date: Wed, 28 Jun 2023 17:52:54 +0200
Message-Id: <20230628155313.71594-12-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

g_malloc0() can not fail. Remove the unreachable error path.

https://developer-old.gnome.org/glib/stable/glib-Memory-Allocation.html#glib-Memory-Allocation.description

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230624174121.11508-10-philmd@linaro.org>
---
 target/i386/nvmm/nvmm-all.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index b3c3adc59a..90e9e0a5b2 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -943,10 +943,6 @@ nvmm_init_vcpu(CPUState *cpu)
     }
 
     qcpu = g_malloc0(sizeof(*qcpu));
-    if (qcpu == NULL) {
-        error_report("NVMM: Failed to allocate VCPU context.");
-        return -ENOMEM;
-    }
 
     ret = nvmm_vcpu_create(mach, cpu->cpu_index, &qcpu->vcpu);
     if (ret == -1) {
-- 
2.38.1


