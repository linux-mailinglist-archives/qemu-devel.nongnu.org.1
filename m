Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7739BA6B0EB
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Mar 2025 23:33:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOQg-0003Y5-WB; Thu, 20 Mar 2025 18:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPc-0002Ue-4g
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:55 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPN-0007BW-OX
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:51 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-226185948ffso26876815ad.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742509833; x=1743114633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H6JY17RXIOhpi9WGu5PHvZc/K1MBVjPo3G9pvjwYgCU=;
 b=KmGeHOyW8pisf0coyMZI7MBjdk/RNVxjFZrSL0WTDS+8/oqeNrMMqQZWks34sCPnFv
 pzye6slDUU+r4J8dDr87SgyItYV+ETV2hkDLWb9GjqPhdiVIyqx3Cm5OZr9zFj2n/1/W
 +xQVhFoj4rX7UH/oLHl0eltuezRqnjuhBbk586w2uHP0XH6oDH+j93iACDNKtKRAc3Mb
 atlrzUf+UaZCjjy+pOkm/aF0FblwRNGqLfIGEIZlhbhqfBFieBCkwnSGJCX2ecknrEpV
 pTmw5MhdtLTR8tuy3ur/odJYECB+jCBEek2yjFNr0WAOTVEY/Pt4W5hAV7rbgvzYEyck
 zqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509833; x=1743114633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H6JY17RXIOhpi9WGu5PHvZc/K1MBVjPo3G9pvjwYgCU=;
 b=ifKGpofDSPXefaw7hDjqFo8N08T38q0FptOac4vZpg9ocwuLncvrq74vUF+mdANnnG
 K/jR1bMdWtiUWHow2d5DZ6UFosb+9TktVyycZCueZklVTrU7H/AknUPEluiemkOrN0VA
 hFndS9UC8hizrRIu20S5HqZgWOHcy8tOmDEwYu0g3Cg+Hs0vHdZZyDkavmlYunMAtHRE
 2DoqD5ZObZFFfeGqCPoi+j8Bcej0TK5bkKyxfl65dViBY3Lw6KQhzm0bIuSncStBCAUj
 uHiYN8xP0uFj3W62DOzaVivBbHgZ5ll4oqGL7yUBPi3aquItyrZLb4oOp+6lON0Mk67F
 XwXw==
X-Gm-Message-State: AOJu0YwUX+tRewIwKnwEG4TjN1jYYMue8wjD5TBV/E3QX7gpbmZSYLDJ
 AED3sVkN5hOaGIdTg37FDDnOXINWSYY9O3YM7jm6f73TPC9RT2vMIJyMVeplUweqvCWfQqI4jF0
 R
X-Gm-Gg: ASbGnctBWUn7wsnK0SUChrX1nJt+G8yuegT97A8dJJvya4xgRYnxtiVIK4hXlhA8iUu
 FX5V5NOvrzEjOztzlM8zltIAB3Mac55P4xrvqWsiDorOsQ0y/uZa1jrKZz/mw7wplhDYyhGlLE9
 siCXFnTHw+lgGeQgKXk7AT9cccx2kfnlZhgWuoQ1ZDLSkWgaAQIr/GuRLRuc1IxJHAVO1C2cJgh
 jrop2XjJrj2hJ5Egck/KNIzfAUu1Q42FaR1GPq7iOhH5BVw3hOpvZR54PozLFMiKZ92nP7K6dWV
 laRU5FSsnMcc8pXONQ9OTBq0/czuDaWF20xXYqboNGPJIXoKBY0gilI=
X-Google-Smtp-Source: AGHT+IE59Qwtp5nBxQhisMzue6LUyvUvNBhkAAgS1BGy24OByXsm0hDrGv8KdLQQ/IM83anAIbBe6A==
X-Received: by 2002:a17:902:f54e:b0:223:fb3a:8647 with SMTP id
 d9443c01a7336-22780e0a4b3mr14803805ad.41.1742509832795; 
 Thu, 20 Mar 2025 15:30:32 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm3370145ad.59.2025.03.20.15.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 15:30:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 21/30] target/arm/cpu: flags2 is always uint64_t
Date: Thu, 20 Mar 2025 15:29:53 -0700
Message-Id: <20250320223002.2915728-22-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

Do not rely on target dependent type, but use a fixed type instead.
Since the original type is unsigned, it should be safe to extend its
size without any side effect.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.h        | 10 ++++------
 target/arm/tcg/hflags.c |  4 ++--
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ab7412772bc..cc975175c61 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -194,7 +194,7 @@ typedef struct ARMPACKey {
 /* See the commentary above the TBFLAG field definitions.  */
 typedef struct CPUARMTBFlags {
     uint32_t flags;
-    target_ulong flags2;
+    uint64_t flags2;
 } CPUARMTBFlags;
 
 typedef struct ARMMMUFaultInfo ARMMMUFaultInfo;
@@ -2968,11 +2968,9 @@ uint64_t arm_sctlr(CPUARMState *env, int el);
  * We collect these two parts in CPUARMTBFlags where they are named
  * flags and flags2 respectively.
  *
- * The flags that are shared between all execution modes, TBFLAG_ANY,
- * are stored in flags.  The flags that are specific to a given mode
- * are stores in flags2.  Since cs_base is sized on the configured
- * address size, flags2 always has 64-bits for A64, and a minimum of
- * 32-bits for A32 and M32.
+ * The flags that are shared between all execution modes, TBFLAG_ANY, are stored
+ * in flags. The flags that are specific to a given mode are stored in flags2.
+ * flags2 always has 64-bits, even though only 32-bits are used for A32 and M32.
  *
  * The bits for 32-bit A-profile and M-profile partially overlap:
  *
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 8d79b8b7ae1..e51d9f7b159 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -506,8 +506,8 @@ void assert_hflags_rebuild_correctly(CPUARMState *env)
 
     if (unlikely(c.flags != r.flags || c.flags2 != r.flags2)) {
         fprintf(stderr, "TCG hflags mismatch "
-                        "(current:(0x%08x,0x" TARGET_FMT_lx ")"
-                        " rebuilt:(0x%08x,0x" TARGET_FMT_lx ")\n",
+                        "(current:(0x%08x,0x%016" PRIx64 ")"
+                        " rebuilt:(0x%08x,0x%016" PRIx64 ")\n",
                 c.flags, c.flags2, r.flags, r.flags2);
         abort();
     }
-- 
2.39.5


