Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C0D73EF2C
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 01:22:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDvWF-0004ym-LM; Mon, 26 Jun 2023 19:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDvWC-0004wR-OX
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 19:21:12 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDvWA-0000EV-Rq
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 19:21:12 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-51d894b9b6cso2313298a12.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 16:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687821667; x=1690413667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y5G3GZnisObOugerwvl7UVGEu2t0avWriP2R6IveebM=;
 b=WoLMAr+CiJgH4B1qgk83JpNhJB6Anw1PEQbSOH75xrkn4K9fOj93grM/N+PxivWbrU
 xO/K6z230taLvqq3Mh7TpjyC5FyePvSLv5GsoEFSNwyjZIV2Qacc/l17KP/qkWq6C1re
 +HJpvwUSkpoQDan70CBkQxNhOAqE/eJLeSev4hMughTYeMUfPV1vCB93eD2K5FyFLtzp
 pUjDu1CIf9TrQSPxigQFI1zfth9fw17R10Hfrs512BzTu9zA9DuqNf6CHOe5MIov7JGZ
 82boGt6vwPSObe6ow5UKccJOB820mbia4TFQisPAClK8T5dn4QYWv3IBjW+cE3ghAoKF
 q6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687821667; x=1690413667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y5G3GZnisObOugerwvl7UVGEu2t0avWriP2R6IveebM=;
 b=VcaEpgynrP4M3uWrAR9j71Kg2uYK8HpIks0QVFPIjNi6jvJ1FLsS7oGXu2iBAHC1Yh
 XGN8A/TsDr+p+drcm/jGcPXeB/qUeO+CAlZDetCqjZUMPAbEowCjJGr1t/hTAXN/+HSk
 FSa/j/a+K1DjaQRLdOEEHyDSLh8HMMDy5LNjhJryjk2Wns+Jjr1U1Dr0ychFTfdgsjIB
 7n18Hh57i+hmOALW+I03teNnqOrY7fk6YcilBeFcGdZRkLQDbMjkA7tPhUaShs2IQ5/M
 iLirfVvkJYUsP+a79wR9Z0AEj6fjjUroVRPx4f171TOv9XHFOr046Z92ppEQQmAaY5T5
 EJBQ==
X-Gm-Message-State: AC+VfDyrp7LmrLFRz38YTuSmhinDTXPLB8ILEHXPDaMwyoso/tqk5AwX
 VfT3EDI8sLE1EfMzECYmQUWk7lIT40B9yptHbM8=
X-Google-Smtp-Source: ACHHUZ58GdSTaP+DLnF9cLEnkuzjvcgNgocGoqCWJKkZH3weS5u2v8um5FaknaOsz9DJsOwGg9i5qg==
X-Received: by 2002:a17:907:8a05:b0:992:13c7:563 with SMTP id
 sc5-20020a1709078a0500b0099213c70563mr116433ejc.75.1687821667596; 
 Mon, 26 Jun 2023 16:21:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.226])
 by smtp.gmail.com with ESMTPSA id
 k19-20020a1709061c1300b00988b32160dfsm3739150ejg.222.2023.06.26.16.21.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Jun 2023 16:21:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, qemu-riscv@nongnu.org
Subject: [PATCH 09/16] target/riscv: Expose some 'trigger' prototypes from
 debug.c
Date: Tue, 27 Jun 2023 01:20:00 +0200
Message-Id: <20230626232007.8933-10-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230626232007.8933-1-philmd@linaro.org>
References: <20230626232007.8933-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

We want to extract TCG-specific code from debug.c, but some
functions call get_trigger_type() / do_trigger_action().
Expose these prototypes in "debug.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/debug.h | 4 ++++
 target/riscv/debug.c | 5 ++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index c471748d5a..65cd45b8f3 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -147,4 +147,8 @@ void riscv_trigger_init(CPURISCVState *env);
 
 bool riscv_itrigger_enabled(CPURISCVState *env);
 void riscv_itrigger_update_priv(CPURISCVState *env);
+
+target_ulong get_trigger_type(CPURISCVState *env, target_ulong trigger_index);
+void do_trigger_action(CPURISCVState *env, target_ulong trigger_index);
+
 #endif /* RISCV_DEBUG_H */
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 75ee1c4971..5676f2c57e 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -88,8 +88,7 @@ static inline target_ulong extract_trigger_type(CPURISCVState *env,
     }
 }
 
-static inline target_ulong get_trigger_type(CPURISCVState *env,
-                                            target_ulong trigger_index)
+target_ulong get_trigger_type(CPURISCVState *env, target_ulong trigger_index)
 {
     return extract_trigger_type(env, env->tdata1[trigger_index]);
 }
@@ -217,7 +216,7 @@ static inline void warn_always_zero_bit(target_ulong val, target_ulong mask,
     }
 }
 
-static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
+void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
 {
     trigger_action_t action = get_trigger_action(env, trigger_index);
 
-- 
2.38.1


