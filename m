Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5387459A4
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:07:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGRh-00037y-F9; Mon, 03 Jul 2023 06:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRZ-0002wy-AK
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:06:05 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRH-0005tW-Qd
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:06:05 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57ddso15581135e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 03:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688378746; x=1690970746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+os3nHQ/ZmARewYX8s5fRYkcgS0NtfZNFjYHPGkpaM4=;
 b=X5TrsKfAhQX/kK1CsQ/ipdzc+4Nj/S5XX4YJ45qsbLFxdaK9RAoC+QjOOK3flb3hrj
 MKhWK7LSXOlky1g+ytCR4o9OJdPGZaI8BuoJffTrWhpBojgxmhc+pFA/XZO73EDZ4CRl
 gWgutKsdYSJP9oUN8QstNcmAfiFS9NMyQM4hghNmU3pNglAQZCJ0T05oe69+S88Zm7hD
 +jaMZRrOOHl05q91EUSJNv1gfHqdUHrow3MrrOEMD65cvmctQKvckyjIdbqMu7RR3wzp
 WzlerCFCKLjy9gcmPWFmapv5Sl2toL9nRzREUZkofCQQMgi7+4li0wx+DQKMMWwlZSdp
 C/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688378746; x=1690970746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+os3nHQ/ZmARewYX8s5fRYkcgS0NtfZNFjYHPGkpaM4=;
 b=BQYXPc59vW5ItQJLso+0WPJWI6J0GcblWAMQvg3GCavCpMLcrM1WvtU0/lTqz7UPBB
 Sqx5KNZSrzthiTrC9jNYOFXtXhqav6ZaiEqZ4qPZfpD4M2fQZKupJEUwlGa6HidnMzCZ
 3DfBswfVw0NVkACvwddRkAS/4npRg0Taq8N7sbeTy1EHFRAP7SaTT0Bqq+bSEOv6Crf9
 tV/Kf2/K/9UWVrgHbAOUrXrb1v9BmWY64v79jgfgM/G1gljTBtXV6WrNrx6bLAeoTF/6
 YaoTBeyRd1TM46dhyr0bW8bBCcfXHVv/LVjW8mLxVNIu83r7TgSwLuB/Gj9i81mNIxE+
 RgkQ==
X-Gm-Message-State: AC+VfDzR6rcqG2/h8/KQLn3PENMZzRaJWNyESgBQAfOsH25Q+coiDyE5
 DysQWT57IbkIonGgArxtJOugjSdDxn8XFx3oX+1OdQ==
X-Google-Smtp-Source: ACHHUZ44n7UqB44H291RGVVvCZ8CI95gg/yhq4p5d9KjrwxSOncV6wVCWPmS5qVvFnz/KQMLd+zIBQ==
X-Received: by 2002:a05:600c:2253:b0:3fb:a5b3:4f02 with SMTP id
 a19-20020a05600c225300b003fba5b34f02mr7464716wmm.36.1688378746218; 
 Mon, 03 Jul 2023 03:05:46 -0700 (PDT)
Received: from stoup.home (91.232.79.188.dynamic.jazztel.es. [188.79.232.91])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a05600001c500b00313f7b077fesm18446562wrx.59.2023.07.03.03.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:05:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com
Subject: [PATCH v4 22/37] target/i386: Use aesenc_SB_SR_MC_AK
Date: Mon,  3 Jul 2023 12:05:05 +0200
Message-Id: <20230703100520.68224-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703100520.68224-1-richard.henderson@linaro.org>
References: <20230703100520.68224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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

This implements the AESENC instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/ops_sse.h | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 893913ebf8..93a4e0cf16 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2188,16 +2188,12 @@ void glue(helper_aesdeclast, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 
 void glue(helper_aesenc, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
-    int i;
-    Reg st = *v;
-    Reg rk = *s;
+    for (int i = 0; i < SHIFT; i++) {
+        AESState *ad = (AESState *)&d->ZMM_X(i);
+        AESState *st = (AESState *)&v->ZMM_X(i);
+        AESState *rk = (AESState *)&s->ZMM_X(i);
 
-    for (i = 0 ; i < 2 << SHIFT ; i++) {
-        int j = i & 3;
-        d->L(i) = rk.L(i) ^ bswap32(AES_Te0[st.B(AES_shifts[4 * j + 0])] ^
-                                    AES_Te1[st.B(AES_shifts[4 * j + 1])] ^
-                                    AES_Te2[st.B(AES_shifts[4 * j + 2])] ^
-                                    AES_Te3[st.B(AES_shifts[4 * j + 3])]);
+        aesenc_SB_SR_MC_AK(ad, st, rk, false);
     }
 }
 
-- 
2.34.1


