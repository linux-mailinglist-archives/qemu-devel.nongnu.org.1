Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B86D7738E2C
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 20:08:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC2Dl-0000I0-KA; Wed, 21 Jun 2023 14:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qC2Di-0000GU-Ud
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 14:06:18 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qC2Dh-00072c-Fh
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 14:06:18 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5187aa18410so6692656a12.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 11:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687370776; x=1689962776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UrvWGBwgWeQ4TSd2RLxu4vOp8kCc/g/B3m61WE/+p70=;
 b=Dn+XzVK3lHKIvAo15QhC2NjK4eYfHJaxYQ72bq2BUfb+Sh8mElcjXweiX1JNB2A8uv
 48U+jI7l9DThdUF0yNmLZJMbaYbwrmnlU38nv15OCFV9dElov9ak1OExP1AxoqaVNbNu
 gvUWQ6C8zxzptRObVNoE7GKdOd3FXe5kRwIUCNQr8PtLWVZBJRtLk2wcP7EAO6ogunm1
 U9UdhCKG7NSXObeWolp8s/Fglm4GPtzQ0BknvpN05N/poyw12rtr7frl46nwAMg5dOJ4
 DC03ZsFfMSfvxRT3cnn2lupgclt7riHcTe6WHLADmpiDugZmgFLOFdz/uFoNdzxxXl3A
 zV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687370776; x=1689962776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UrvWGBwgWeQ4TSd2RLxu4vOp8kCc/g/B3m61WE/+p70=;
 b=JtkekqgyM31+yi1iDa4lK+SefLKD3bfkbnV22WNVxpTzX3MXFI9h4Ut8c0ZzUkUwNY
 fXqPrWe45zUtyvC131XHwSEY36r7QBWt7UchH2eEfdTlYpaL9p/A9eO8dazx1vXmMPC0
 NWuFZFKAdh/jfsg8WTsXaTD0MszuibRe07DOmEP4pfsbWQWWuRD9c+GVaJncr1tFf3rE
 zstVfeZPoCVO/sqoutTIY/GRhaLoIPHlQmjfsQkNCHDDQcJoif+aV+iyAc3GyOYEodAH
 4cXus4gLS4nb+vf9Q+TtjnBj32SMROH4Q1zTLi9AKAKTpA96PpB8bm8mDaJPLxRDMuiB
 m7Xw==
X-Gm-Message-State: AC+VfDxdsd1DFlv7Zps7rnrETISN9O9Ae8hipjfxblAVAOtiG8mkUrU2
 s8NlCeS8h82J9vUpB5jCe1Vegju6QQj9a4FJYS1npI0e
X-Google-Smtp-Source: ACHHUZ6pDpcpA5TZl8ycJTqFnmYup2iCiTXBXKcfUr2+KBIkLrczBCOsBqt5gxIkOaRLPNgGaSfVSA==
X-Received: by 2002:a05:6402:4c9:b0:51a:327d:f065 with SMTP id
 n9-20020a05640204c900b0051a327df065mr11076476edw.13.1687370775920; 
 Wed, 21 Jun 2023 11:06:15 -0700 (PDT)
Received: from stoup.lan ([176.176.128.70]) by smtp.gmail.com with ESMTPSA id
 g9-20020aa7d1c9000000b0051495ce23absm2910944edp.10.2023.06.21.11.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 11:06:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 6/8] target/sparc: Use DYNAMIC_PC_LOOKUP for JMPL
Date: Wed, 21 Jun 2023 20:06:05 +0200
Message-Id: <20230621180607.1516336-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621180607.1516336-1-richard.henderson@linaro.org>
References: <20230621180607.1516336-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x533.google.com
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

This is for a plain indirect branch with no other side effects.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index bd3feed72e..9ed235d26d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5058,7 +5058,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                         gen_check_align(cpu_tmp0, 3);
                         gen_address_mask(dc, cpu_tmp0);
                         tcg_gen_mov_tl(cpu_npc, cpu_tmp0);
-                        dc->npc = DYNAMIC_PC;
+                        dc->npc = DYNAMIC_PC_LOOKUP;
                     }
                     goto jmp_insn;
 #if !defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
-- 
2.34.1


