Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5088DA3C7F8
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Feb 2025 19:50:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkp5m-00030e-TK; Wed, 19 Feb 2025 13:46:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Bie2ZwgKCnEljWPdihWVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--wuhaotsh.bounces.google.com>)
 id 1tkp5f-0002wg-Qm
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:46:36 -0500
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Bie2ZwgKCnEljWPdihWVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--wuhaotsh.bounces.google.com>)
 id 1tkp5c-0004i0-Sp
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:46:34 -0500
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2fc3e239675so331060a91.0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 10:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1739990790; x=1740595590; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=HBwUiikiGOfgCxanP9f6qzV84BwbvfIj1V8/CZyi2UA=;
 b=Tj6/E4/5w43q/ct9FeX/ZakTNUMhDfYy0nDc4704cNTUpxWSmXaoQVGYXw/bcXlae9
 Sbhv0LH6pIJewzr2n3s2axcKgU61LAaNgy3dPjH6wUNWTlLAXz6pq4k/3pIMzim3psxs
 v3Y9zwZhiXdycfiuds8CDW7AWmTX93XkKCfgqwhqGXRJ40tf0L4uTj1LtVRxbEdalS+x
 4hW23Me7ly8lqGbVgJll156UUvf64zH5hUWK+DebTv8K+xTrvW6Nd3h66GbHHZvv30c5
 yYKgBVl2EAdlcIOw5PZirV5DWXsPEG8OxuB0cgZO4X5YI9IU3EHT0S4N8hTaUg64y7Ww
 a63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739990790; x=1740595590;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HBwUiikiGOfgCxanP9f6qzV84BwbvfIj1V8/CZyi2UA=;
 b=AJXpMtJpPn2JXNUs3jXLmCxSOCBOkr02NbtpNRne59cM1/J6xH018YD4TRASQQhAGb
 ne1ZwCRU+gazpn6pgWdxfR7NED9i1UCSXjSXTkh5bgeuB3BY23ualGhvUCnz9UJtMG2G
 1kxH/zk3iY3WwRsZPXv5npzmVsWYnYB4dmKy4a896i5wFUb52BKM2S+5z2q9uMeQsmuY
 w2SXYBpqw8n3OnFQ2dZfdFB8sXH7T22eR82ZoPDpr4dOv625NhHWIljqe1zR/23+OWMS
 XRkhWagshCP+uMLug9IDtkXO6tGUCuC9Fd3+jqApfO4FJf0y1L+web5GnNRQvOf7KJF2
 xfgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYDjyTa4p3Fn9wI7cSEA19GIfgnRorAZtKuXRRXHz5b0Z+oU4n4L9hkDUpLsaO1DtF0wKoe2Mw8Tqc@nongnu.org
X-Gm-Message-State: AOJu0YyRSzrPYZwFSZuORlhs2eD22QY4Bupv2yWRDu9lmc5ADuM0gror
 1Dd49k8SR4N7Q+Nsj4Lvotysex+qXU6+VvvWMSdxl/QWN+90DTyByPY8ABLlm7eXHLf7KYu1BLB
 mJkC516bM8Q==
X-Google-Smtp-Source: AGHT+IEwwD2lu/hPJqm85pgmkpOiSYrUHGpIAUlJO8gmjmTJYcjdXJFMGwdUx+BBzSN3CXlvpOMZQ53B4cZr6Q==
X-Received: from pjg8.prod.google.com ([2002:a17:90b:3f48:b0:2ef:82a8:7171])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e7cc:b0:2ee:5bc9:75c3 with SMTP id
 98e67ed59e1d1-2fc40c1d6e4mr27228277a91.5.1739990790450; 
 Wed, 19 Feb 2025 10:46:30 -0800 (PST)
Date: Wed, 19 Feb 2025 10:45:55 -0800
In-Reply-To: <20250219184609.1839281-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20250219184609.1839281-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219184609.1839281-5-wuhaotsh@google.com>
Subject: [PATCH v5 04/17] hw/misc: Rename npcm7xx_gcr to npcm_gcr
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3Bie2ZwgKCnEljWPdihWVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--wuhaotsh.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

NPCM7XX and NPCM8XX have a different set of GCRs and the GCR module
needs to fit both. This commit changes the name of the GCR module.
Future commits will add the support for NPCM8XX GCRs.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 hw/misc/meson.build                           | 2 +-
 hw/misc/{npcm7xx_gcr.c => npcm_gcr.c}         | 2 +-
 include/hw/arm/npcm7xx.h                      | 2 +-
 include/hw/misc/{npcm7xx_gcr.h => npcm_gcr.h} | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename hw/misc/{npcm7xx_gcr.c => npcm_gcr.c} (99%)
 rename include/hw/misc/{npcm7xx_gcr.h => npcm_gcr.h} (96%)

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 55f493521b..554eb8df5b 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -70,7 +70,7 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
 ))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files(
   'npcm7xx_clk.c',
-  'npcm7xx_gcr.c',
+  'npcm_gcr.c',
   'npcm7xx_mft.c',
   'npcm7xx_pwm.c',
   'npcm7xx_rng.c',
diff --git a/hw/misc/npcm7xx_gcr.c b/hw/misc/npcm_gcr.c
similarity index 99%
rename from hw/misc/npcm7xx_gcr.c
rename to hw/misc/npcm_gcr.c
index 07464a4dc9..826fd41123 100644
--- a/hw/misc/npcm7xx_gcr.c
+++ b/hw/misc/npcm_gcr.c
@@ -16,7 +16,7 @@
 
 #include "qemu/osdep.h"
 
-#include "hw/misc/npcm7xx_gcr.h"
+#include "hw/misc/npcm_gcr.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 4e0d210188..510170471e 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -24,7 +24,7 @@
 #include "hw/i2c/npcm7xx_smbus.h"
 #include "hw/mem/npcm7xx_mc.h"
 #include "hw/misc/npcm7xx_clk.h"
-#include "hw/misc/npcm7xx_gcr.h"
+#include "hw/misc/npcm_gcr.h"
 #include "hw/misc/npcm7xx_mft.h"
 #include "hw/misc/npcm7xx_pwm.h"
 #include "hw/misc/npcm7xx_rng.h"
diff --git a/include/hw/misc/npcm7xx_gcr.h b/include/hw/misc/npcm_gcr.h
similarity index 96%
rename from include/hw/misc/npcm7xx_gcr.h
rename to include/hw/misc/npcm_gcr.h
index c0bbdda77e..9b4998950c 100644
--- a/include/hw/misc/npcm7xx_gcr.h
+++ b/include/hw/misc/npcm_gcr.h
@@ -13,8 +13,8 @@
  * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
  * for more details.
  */
-#ifndef NPCM7XX_GCR_H
-#define NPCM7XX_GCR_H
+#ifndef NPCM_GCR_H
+#define NPCM_GCR_H
 
 #include "exec/memory.h"
 #include "hw/sysbus.h"
@@ -70,4 +70,4 @@ struct NPCM7xxGCRState {
 #define TYPE_NPCM7XX_GCR "npcm7xx-gcr"
 OBJECT_DECLARE_SIMPLE_TYPE(NPCM7xxGCRState, NPCM7XX_GCR)
 
-#endif /* NPCM7XX_GCR_H */
+#endif /* NPCM_GCR_H */
-- 
2.48.1.601.g30ceb7b040-goog


