Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FEC79DC0A
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:43:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgC4l-0002ft-UO; Tue, 12 Sep 2023 18:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgC4j-0002eA-6v
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:41:41 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgC4g-0001Ac-Ta
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:41:40 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bf7a6509deso42915205ad.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 15:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694558497; x=1695163297;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qUVjTcjkNZmdhwavklqNnzqJkSIaiyxihMzM0GkWlyU=;
 b=L16HHbbwdNI5YodBI9IkvJLShReAsoemCT4McdA1yPynm/69TTAsxMb8+kDHW/g48E
 m4tJAE3vf2YSs7uUCjbO1Ip7FcgjNiCPLi+1It5gvVSL3CbXRqNrIaSzSFJs69kl2uWQ
 bzGbYyppqf7pOUoYjc99ZKhQu0rzMkxBrcfSjhsrs5NH6esuXPOQDEN7/OUGCC1yrAEn
 bGU9m9f58bM8whclf6N98fRCq+bxC91ROKkyapBMuG3qYfAdnykgBIjyqLmE5fTK4Wcj
 tx/3IeLevsC9HplUHxoxZh7ZSf/vSb7ccz+GfT5wHCl7WClpgB1iBe0qIVoK0+HiJCQW
 f01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694558497; x=1695163297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qUVjTcjkNZmdhwavklqNnzqJkSIaiyxihMzM0GkWlyU=;
 b=Q2gr4OTOFzwA+YF2N9mtuhaBhfYXa2gayYTCjFB57jUy/YZALVwgKXKqArP6DdmyR2
 QL7GcrDAzmR9vyAIFfPYP5DS7Es2y9/lD1WjDwNqeUxf+dtsBibsePzKgQdvyFqgJn4v
 TWU3YhhITrNFGWjT2/AZlmkXHc4M08SwTOk9878M9v7o3oEdMxgDWXgUDT04BmWjkzHU
 HpEwV99z+ZzxS5BZMZFhMr5XIunyV1cWxLDq6fVuWLfE+mSHToNGDSFT9i7BN0e0ancY
 JO6Hj996Z8NPcsxM0X8zhlFOlMLF5wnykzIxVWxcj4lUa0qci4Dk0IilwLwazgAnW8v3
 Be+w==
X-Gm-Message-State: AOJu0Yyq/gct8c0j//FSR5AVklCAzD2Ka7RTAdZIihcvUe9UXH4KuSYu
 bG+Is++NAjsWCLF91Q0OqaxSNQ==
X-Google-Smtp-Source: AGHT+IG2nbzABz+c+CMqzZPhKJhBEfkgWTxlp3sD/pBZI1VhAGcfZZmGkwuua0HR3rZDxiah+fFh9Q==
X-Received: by 2002:a17:902:7892:b0:1c0:e6e1:4a11 with SMTP id
 q18-20020a170902789200b001c0e6e14a11mr980553pll.54.1694558497679; 
 Tue, 12 Sep 2023 15:41:37 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a170902d34d00b001bbbc655ca1sm8996977plk.219.2023.09.12.15.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 15:41:37 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH v3 09/12] target/arm: Remove references to gdb_has_xml
Date: Wed, 13 Sep 2023 07:40:58 +0900
Message-ID: <20230912224107.29669-10-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912224107.29669-1-akihiko.odaki@daynix.com>
References: <20230912224107.29669-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
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


