Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4389A6E91A
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Mar 2025 06:02:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwQF-00064o-UG; Tue, 25 Mar 2025 01:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwO9-000414-U3
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:48 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwO8-0005y5-Bk
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:45 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2260c91576aso86525945ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878783; x=1743483583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JtusWKYTrMDoHpdfg0nshB8ODIflkcfJFt+VFvekQoU=;
 b=fV3eTQSLHlCNRbuDaBE1mU+AknsXZZS2d1ywwIUvCGoaPNwGUERvQESf8XSbo2fnQt
 e+HDnWHlEdNWjTV+UKfiWIY6WVIM7k0Rb6WMKknZWbDNjSAgusDxw0sTxTguhQLBNnfL
 wFsaVxDHFKza+73/Hh0tpikZpQRyte6LnINtsV6k02Sy+nLF4ZLKqPEM8NqEP4OpjrV/
 CyrxJY0DsU6hrln+g6gNyumc8OU6aT7fZdk0RkPQ9smuKtAJgMBjCR2dNLVx1BUfPsc0
 mEk9yOzhug0gYwW0DQiGp8QksK+h3CP7pqekxZxKE6V1ZtXHoJR2TyBEtsjSIjKb6Dsl
 GdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878783; x=1743483583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JtusWKYTrMDoHpdfg0nshB8ODIflkcfJFt+VFvekQoU=;
 b=bCERvgWVj/BmtqYCCSNQOXed6P1UEb3YRpGsX0rlGUNJt6DsM3DPamYg/84KtxZwBY
 uhiH/+OIQjlljh32kLMMnuaPWBoz1AsZJwRdFhPHqNvS8RBluaN635Zu/pgLXly1KWOn
 EZPqL1epWcFflOAvkegwwMvGkWjPg/5zSTKeeBhQvO48xIZHgOC6b4PlkF0mocf+NOOX
 fFXYJPPlq2Sa0vAoQIjRXkkd6RrvTPa5UfwwOtswC+dULgDb9LPgLUQvBtOFh53GxMut
 aYvrM+JVv/4pfB5UTQ7kSN6ZEY4bEO1B9p6dNnZFNXkjBDw6ae6uwzQNqwGlaFWiu6lA
 IkEw==
X-Gm-Message-State: AOJu0Yx55bnjXOf8lz2LcsyDOvxJucKE/Db6vofO0ahopeFNGoL1FRSt
 ynT3FDjBe7ysvVGthOtXg64pQaVJnP72KPsnXo1npLwiqmzFw6k99795+ohDDsdQSaeRAMRbUsj
 I
X-Gm-Gg: ASbGncvq8QL2w4wyqITOE37Y6/wFC27BrusnTh2WkJJ1AbgQWiqVblbZVMda6cvFnk9
 FJl3LKHc4wrETgeYpQzAUEGlqYNEfl/sM8F1U2hZXFFE41dHzq5nRnn37rnyfQ4xiG4+zb8Yg3A
 sLwoqDHsTU96mCJHq45U2Kp4ErFmGxH9IMSJ43OeaHCEe5uGsAobEUp1bf9SjJS5ZvulK2LQwsk
 Rp37uuBAoNIvWxNcSG6AM/6Q1NxuQqGtKWm44CofW2DHiDA+8ubNu0/2/VpUdZAHese8a+TTW54
 /SYvWg2yFk2JZ2ysgQN4bfDra5iVZz2XgBMtF+VK+iCQWyGKOQUX9CY=
X-Google-Smtp-Source: AGHT+IF7fVNDkEZpxZD3TpaipUefPuzR5blv1e1P/DipQrGSgNSjRKkE8a4ucCi3CcRYcjp1MOK1Kw==
X-Received: by 2002:a17:903:46c3:b0:21b:d2b6:ca7f with SMTP id
 d9443c01a7336-22780e07919mr289321195ad.32.1742878782353; 
 Mon, 24 Mar 2025 21:59:42 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 22/29] target/arm/cpu: remove inline stubs for aarch32
 emulation
Date: Mon, 24 Mar 2025 21:59:07 -0700
Message-Id: <20250325045915.994760-23-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Directly condition associated calls in target/arm/helper.c for now.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.h    | 8 --------
 target/arm/helper.c | 6 ++++++
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b1c3e463267..c1a0faed3ad 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1222,7 +1222,6 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
  */
 void arm_emulate_firmware_reset(CPUState *cpustate, int target_el);
 
-#ifdef TARGET_AARCH64
 int aarch64_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
@@ -1254,13 +1253,6 @@ static inline uint64_t *sve_bswap64(uint64_t *dst, uint64_t *src, int nr)
 #endif
 }
 
-#else
-static inline void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq) { }
-static inline void aarch64_sve_change_el(CPUARMState *env, int o,
-                                         int n, bool a)
-{ }
-#endif
-
 void aarch64_sync_32_to_64(CPUARMState *env);
 void aarch64_sync_64_to_32(CPUARMState *env);
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index fa23e309040..73e98532c03 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6564,7 +6564,9 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
      */
     new_len = sve_vqm1_for_el(env, cur_el);
     if (new_len < old_len) {
+#ifdef TARGET_AARCH64
         aarch64_sve_narrow_vq(env, new_len + 1);
+#endif
     }
 }
 
@@ -10648,7 +10650,9 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
          * Note that new_el can never be 0.  If cur_el is 0, then
          * el0_a64 is is_a64(), else el0_a64 is ignored.
          */
+#ifdef TARGET_AARCH64
         aarch64_sve_change_el(env, cur_el, new_el, is_a64(env));
+#endif
     }
 
     if (cur_el < new_el) {
@@ -11665,7 +11669,9 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,
 
     /* When changing vector length, clear inaccessible state.  */
     if (new_len < old_len) {
+#ifdef TARGET_AARCH64
         aarch64_sve_narrow_vq(env, new_len + 1);
+#endif
     }
 }
 #endif
-- 
2.39.5


