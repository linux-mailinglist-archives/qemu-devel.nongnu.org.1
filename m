Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 036DD7213AC
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 00:27:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5ZfR-00075I-Nc; Sat, 03 Jun 2023 18:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZfP-00073f-8K
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:24:11 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZfN-0004xw-M1
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:24:11 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-33bea381adcso13903125ab.3
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 15:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685831048; x=1688423048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TsEvG+VWvCxR8wzqDIyWaXPHqC8uQbp4ZRAeyYSrQhw=;
 b=FudaGlD4HLJCDv+NhpRNbM1hxsEH3E1F9SjDf7q0eyHDXV3KA6YAIMW7yzDkCM+nea
 4+6Q1xsy3Id0LWYphCbmskofjN7mGTPcDwVaqyP5hfg2ahwyeu6RVDjDk5HXRNwbl48X
 dmImrbl3wr4fx1RwUvggtnKoOEFSrQUVQRUdwxoD9aVnl9KRyvdzoDDdjzyG5lyZ9ZnG
 9aFK7pXWENIMKEjudSollDwm79Dd7CTCJiP5T5Kz+KlYamiQ16aGQeJaWkydz0Hf8hGE
 cnDzMtkONhLwPO1WqOqNyfyER9C/2d9vMe09OPEH5moYVJpQh3DEylTXZtfcDi8XCLSf
 kmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685831048; x=1688423048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TsEvG+VWvCxR8wzqDIyWaXPHqC8uQbp4ZRAeyYSrQhw=;
 b=fNwCNa83BuJNacJi5lNf1YrarV0S44f8ljVJ9e/OSLJJjNKc9uvhhKAcKEPWZmyWuh
 zblzTzHRyT2FZoKnyMbLb7nrxCjhpJPLW3oH2fKOUtoMIZmBQRQhri0KAMWlfax4UcEc
 MwxObeKAySbLlNi2nuO0XIwPev8uDX8wzOG03XO2LSvLYdBgZk92tpQpwdSWycva8Muj
 5xlNXqeKKnbD2uxVXPQCDadp6zKLgX6CinYbGZPsbS10GLfwloUXpJLoRgjyFyvRRaqP
 I/hb7s+wf4yWuHA9UF4EKOUCdmyw2CqaWBTDAuGLj/NXMWuzH6hlFloHzK869XG0wN1f
 kgTA==
X-Gm-Message-State: AC+VfDyuw9sPyN/DladS4D3NGTof9qWRtr+bTaJPT954a4AK0XQL/Dho
 wgFUJUxOR0/L7oNC4wjapb6Th/dD5JXuEkhthr4=
X-Google-Smtp-Source: ACHHUZ4U6gt1BDFIj4Hc1trAydRHSsS6iqWXVp8CxxZOzWD2ERRrGK8qekizihxMfco4YscPo8NdRA==
X-Received: by 2002:a92:d08b:0:b0:32b:12ee:3f0b with SMTP id
 h11-20020a92d08b000000b0032b12ee3f0bmr13268571ilh.9.1685831048459; 
 Sat, 03 Jun 2023 15:24:08 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 m14-20020aa78a0e000000b0063d2dae6247sm187208pfa.77.2023.06.03.15.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jun 2023 15:24:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 14/15] include/exec/user: Set ABI_LLONG_ALIGNMENT to 4 for
 microblaze
Date: Sat,  3 Jun 2023 15:23:54 -0700
Message-Id: <20230603222355.1379711-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603222355.1379711-1-richard.henderson@linaro.org>
References: <20230603222355.1379711-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x129.google.com
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

Based on gcc's microblaze.h setting BIGGEST_ALIGNMENT to 32 bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/user/abitypes.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/exec/user/abitypes.h b/include/exec/user/abitypes.h
index 743b8bb9ea..beba0a48c7 100644
--- a/include/exec/user/abitypes.h
+++ b/include/exec/user/abitypes.h
@@ -15,7 +15,9 @@
 #define ABI_LLONG_ALIGNMENT 2
 #endif
 
-#if (defined(TARGET_I386) && !defined(TARGET_X86_64)) || defined(TARGET_SH4)
+#if (defined(TARGET_I386) && !defined(TARGET_X86_64)) \
+    || defined(TARGET_SH4) \
+    || defined(TARGET_MICROBLAZE)
 #define ABI_LLONG_ALIGNMENT 4
 #endif
 
-- 
2.34.1


