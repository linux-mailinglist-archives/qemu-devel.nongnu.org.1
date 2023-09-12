Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F2279C75B
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 08:59:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxMX-0001Li-H9; Tue, 12 Sep 2023 02:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxMC-0000l6-IY
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:58:48 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxMA-0007XQ-9W
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:58:44 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-271c700efb2so3483776a91.0
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 23:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694501921; x=1695106721;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qUVjTcjkNZmdhwavklqNnzqJkSIaiyxihMzM0GkWlyU=;
 b=Zi7vS9s5jEZPEkPPXCsiZy8ikCDOOAtQqeGMrmnFWW31R9GvN+iFl3b2xE03l89jLJ
 ow0drjs5qO0LtU4PFXafNTikCyoc0Q45WU3Pk0vJpy3fKhx5Cku6Ds/8A6R8r48njuLh
 MIQhe6H+DYQrH7yw9dcs7/b6+vMwYhiG7GtG5uGH19QzA3wkyu2b0zSsJPLEaOQTUF2m
 cnAaA1HuZbKZdhYeznGLf/YwuopM2/NqKxqSneHpGJDDdu2C7seAv8oh48e3pqbxhkCT
 K43Nq+XWuN8nHHLcELv3czkxnMebIR0l4cNStySUJxxSHqqUIW8YWw2SbGzfi0p/a3PC
 ShMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694501921; x=1695106721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qUVjTcjkNZmdhwavklqNnzqJkSIaiyxihMzM0GkWlyU=;
 b=r8g+UOo2AY4g/CN+IPZvvSDeagiXx0ZEQe2Hu9QZQeOrEee65H/tQDJ2AKZ/5QoMwd
 A9l0tDM73xy0BMEa0/olMY/ORuwe4INrk3ph3fm34uFttWVwiUoKaspID0tXeMWP5UFL
 K0K5WO4YKTbbFa06bfXnVb0pzX1XgT3dZZR1m+pOofVacmna26sjL9ssLx+Ik3QZUiGf
 xo31hbPRiV+Z7ZQf9xoYNdl/xvh3SsspGiLhHEHMrtFH0wHH2S63iYt3JaO+2fbwh0qQ
 bAoW1TkKj6+PqOT2xqbeJ1bKzZyMVh2Mixeo99cZ4aLihL+SXfpHEZa+UZ+0RK6vaLRu
 Bvnw==
X-Gm-Message-State: AOJu0YxXBxWmtGM/E6R3bIhDDEi7KDyacBEyZj/oTeXe7bYJ6zFXciNS
 mSN4+Op9ND9lalXLGrdjpoaTtKeRd48M0CDzRI0=
X-Google-Smtp-Source: AGHT+IEugFWzGyIJbgfzMAWZi8kFoV7blGP2kP/el/CE65Q22wACUuhF50orAYjH+Es7z+1uVi5USQ==
X-Received: by 2002:a17:90a:72c3:b0:273:b0bd:343b with SMTP id
 l3-20020a17090a72c300b00273b0bd343bmr9158534pjk.41.1694501921213; 
 Mon, 11 Sep 2023 23:58:41 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a17090a2ac800b002696aeb72e5sm9315058pjg.2.2023.09.11.23.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 23:58:40 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH v2 08/11] target/arm: Remove references to gdb_has_xml
Date: Tue, 12 Sep 2023 15:58:03 +0900
Message-ID: <20230912065811.27796-9-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912065811.27796-1-akihiko.odaki@daynix.com>
References: <20230912065811.27796-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1034;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

GDB has XML support since 6.7 which was released in 2007.
It's time to remove support for old GDB versions without XML support.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/gdbstub.c | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 8fc8351df7..b7ace24bfc 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -46,21 +46,7 @@ int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         /* Core integer register.  */
         return gdb_get_reg32(mem_buf, env->regs[n]);
     }
-    if (n < 24) {
-        /* FPA registers.  */
-        if (gdb_has_xml()) {
-            return 0;
-        }
-        return gdb_get_zeroes(mem_buf, 12);
-    }
-    switch (n) {
-    case 24:
-        /* FPA status register.  */
-        if (gdb_has_xml()) {
-            return 0;
-        }
-        return gdb_get_reg32(mem_buf, 0);
-    case 25:
+    if (n == 25) {
         /* CPSR, or XPSR for M-profile */
         if (arm_feature(env, ARM_FEATURE_M)) {
             return gdb_get_reg32(mem_buf, xpsr_read(env));
@@ -100,21 +86,7 @@ int arm_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->regs[n] = tmp;
         return 4;
     }
-    if (n < 24) { /* 16-23 */
-        /* FPA registers (ignored).  */
-        if (gdb_has_xml()) {
-            return 0;
-        }
-        return 12;
-    }
-    switch (n) {
-    case 24:
-        /* FPA status register (ignored).  */
-        if (gdb_has_xml()) {
-            return 0;
-        }
-        return 4;
-    case 25:
+    if (n == 25) {
         /* CPSR, or XPSR for M-profile */
         if (arm_feature(env, ARM_FEATURE_M)) {
             /*
-- 
2.42.0


