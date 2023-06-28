Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1517A7415B8
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:54:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXUM-000624-3x; Wed, 28 Jun 2023 11:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXUJ-00061Z-OR
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:53:47 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXUI-00083X-70
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:53:47 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-977e0fbd742so713082866b.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967624; x=1690559624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M4pELBSXaj94TdEs4Hqr6RUUTU6KwmRqNkUY4T4RPC0=;
 b=yM6RQlvGIBPD5YHXRzZgP564Q2NFVDp7Xmvp+L3VXSTF2Q0TITRvaW1umeFteQQl99
 uJ5fYIbpVcnaQlsmFj9aMTVeUhX3VKmAOn0gDRjft+2Hh+UizVb70o3ulsdixf5fxk3i
 970ZyI4Z4ffse9rPn5i01avhk4C3a+w8D8OD1yIOdCTZebUDmU74cwEruU/XtIv001IR
 nI6BMhH21mS4eZGxsIwl4Wc4U8ODQmqhzMRxt2V+xH6YDR3OxFBtQxe9wuT9RVSiwIAt
 8t3/KI4yrp87GYVs2AvA8HrOXzNer4kdkpSu1kJNj7av3tI4ruWKkDVct2DU4isP8Cqg
 8R+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967624; x=1690559624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M4pELBSXaj94TdEs4Hqr6RUUTU6KwmRqNkUY4T4RPC0=;
 b=jW/dQo7DsNv/hcCbPd4NVpYxMMDWW4VigOwFm38r4w4BtB7LemThz00qaJ1ye/fZA9
 OZ1N60gzSQd7IIvbR1Ergu2oPynRuGT6zselCVEqri3SFBi0edAWXdxRzTq/msWoO/x8
 spjU45j0RXFnV0FEY/6+yXH1XnfgXXyBYIxF985fcq7yUGHTrAJg/RklYuBSOjwFSKmK
 Lb1jJDVqXlABJQr2Y8d5rRfZJGziBlaj45y9jYWm4MY895iH24QvGqnBHq0mvol5tCwn
 rzql39KhgQQnZpAE2nw92bJ+58QbvZkdUsyYWXIBnGI5Py9xmp7CkKlNw+xvsy8sGbGw
 6D6Q==
X-Gm-Message-State: AC+VfDw6TAKYxcAQ+RCdErptvRFdeSfrHw5cnfXjovhEt0bBa73nYFa/
 oEb2G3fe8biHELgyvmjsEobrdhVmk0xs8cDuXPo=
X-Google-Smtp-Source: ACHHUZ7QdUgz0sOhkRlxGnzDe02NM2oi2KWBEkc+zW6T3u8ChnaWmt0yth07ADjhR4wFxk/xD3cepA==
X-Received: by 2002:a17:907:2687:b0:97c:64bd:50a5 with SMTP id
 bn7-20020a170907268700b0097c64bd50a5mr31263586ejc.53.1687967624737; 
 Wed, 28 Jun 2023 08:53:44 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 e8-20020a1709062c0800b0098822e05539sm5784963ejh.191.2023.06.28.08.53.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:53:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/30] accel: Remove unused hThread variable on TCG/WHPX
Date: Wed, 28 Jun 2023 17:52:48 +0200
Message-Id: <20230628155313.71594-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On Windows hosts, cpu->hThread is assigned but never accessed:
remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230624174121.11508-4-philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops-mttcg.c   | 4 ----
 accel/tcg/tcg-accel-ops-rr.c      | 3 ---
 target/i386/whpx/whpx-accel-ops.c | 3 ---
 3 files changed, 10 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index b320ff0037..b276262007 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -152,8 +152,4 @@ void mttcg_start_vcpu_thread(CPUState *cpu)
 
     qemu_thread_create(cpu->thread, thread_name, mttcg_cpu_thread_fn,
                        cpu, QEMU_THREAD_JOINABLE);
-
-#ifdef _WIN32
-    cpu->hThread = qemu_thread_get_handle(cpu->thread);
-#endif
 }
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 23e4d0f452..2d523289a8 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -329,9 +329,6 @@ void rr_start_vcpu_thread(CPUState *cpu)
 
         single_tcg_halt_cond = cpu->halt_cond;
         single_tcg_cpu_thread = cpu->thread;
-#ifdef _WIN32
-        cpu->hThread = qemu_thread_get_handle(cpu->thread);
-#endif
     } else {
         /* we share the thread */
         cpu->thread = single_tcg_cpu_thread;
diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
index e8dc4b3a47..67cad86720 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/target/i386/whpx/whpx-accel-ops.c
@@ -71,9 +71,6 @@ static void whpx_start_vcpu_thread(CPUState *cpu)
              cpu->cpu_index);
     qemu_thread_create(cpu->thread, thread_name, whpx_cpu_thread_fn,
                        cpu, QEMU_THREAD_JOINABLE);
-#ifdef _WIN32
-    cpu->hThread = qemu_thread_get_handle(cpu->thread);
-#endif
 }
 
 static void whpx_kick_vcpu_thread(CPUState *cpu)
-- 
2.38.1


