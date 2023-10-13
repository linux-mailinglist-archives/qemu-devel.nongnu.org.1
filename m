Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B5B7C80BB
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:50:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqz-0002US-8C; Fri, 13 Oct 2023 04:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqi-0001OL-Jk
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:49 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqg-00019p-Uw
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:48 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-405524e6768so19127295e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186925; x=1697791725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LX5WHtDL9EafO+7HgeRGMujR99d0Db9RUjRHakhp3to=;
 b=cqaOrBy3Fj54z3awuZcNoO0yeFafYTDg6GPcrFuCxEASOrzQhKc8kzXZCzVyyi7wF/
 7Y0JDGu6Pz16O23DKOMZ5Cbo4uYxnyQQO/ZIG7zFZxLmAs5oCNZtIa4lFjpjmItIOv8K
 8nSZNrbvCBD69z7oAH9edC87Bs1AF+v0G8VQ7IRSLOfCybl99oIVUMTY+Ezp0PDm2ug1
 5+EkrJabyC+FC9OjARsMoTEBh259PPPgDe8D6A5TmDFn/5IgiPB+e3FX7wrkUnndmDyO
 bahJIyuG3+dnd8sKUVgTPdzZMNbqc89reoHI7xCQOuXuo9nQknfg+xAaN87bDoSA6kPk
 1kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186925; x=1697791725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LX5WHtDL9EafO+7HgeRGMujR99d0Db9RUjRHakhp3to=;
 b=lqZ6+b1gt6Ub4LAgq3Z30nai7QhJdv6yRJgZmiSf1GApnxMV0D7EN07MoMTDBxUmxV
 SLJq0y4WhFNDbyIzxQ2XXx4HkG1DS9K6od2RuJPxSSTpOoGMIcV/N9LoGTTesDFH2aGs
 gdNqix9UrzBCBKOAaUGHIU3AKMPmwa1MJJxhw/cm4KVR3tfVsfKjOVp8tt+aa8vmBMfH
 d9IL8RWRDy63WoJ2foSU5kO0WqWmGP6HCsIgqhDmWrl+klme8aCYL3esWL2SDllq5C0d
 kdescgdqOWD7Or5fgW5MY4KIglrbDu1zpiDQXfOxA8WRkEBX4ZKMTE57dMAXQERxED6o
 EunA==
X-Gm-Message-State: AOJu0YyYU5OCFxYJ0pWb61t/5fCbCWqlx/FJkPhu1hkLtX7ldNI3EZOb
 FcEVzWHC+xKrVXLlYVqJeQ6JRhGGSUBbKojPbNU=
X-Google-Smtp-Source: AGHT+IEJAhnvCL4H11zN540SU7YeS3hq/fybM9ZNwkAR+lNcWx+nrjMKlzxqjoMxEgdQpo75xha98w==
X-Received: by 2002:a05:6000:614:b0:32d:8c7d:a13a with SMTP id
 bn20-20020a056000061400b0032d8c7da13amr5196942wrb.18.1697186925097; 
 Fri, 13 Oct 2023 01:48:45 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:44 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [RFC PATCH v3 55/78] hw/display: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:23 +0300
Message-Id: <e43114a12f5375ba9da0c1aa42ceb4dd0f4c2de9.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32b.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/display/cg3.c        | 2 +-
 hw/display/cirrus_vga.c | 2 +-
 hw/display/tcx.c        | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 2e9656ae1c..53eb9831b2 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -231,7 +231,7 @@ static void cg3_reg_write(void *opaque, hwaddr addr, uint64_t val,
                 s->b[s->dac_index] = regval;
                 /* Index autoincrement */
                 s->dac_index = (s->dac_index + 1) & 0xff;
-                /* fall through */
+                fallthrough;
             default:
                 s->dac_state = 0;
                 break;
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index b80f98b6c4..f1513a084c 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -1360,7 +1360,7 @@ static void cirrus_vga_write_sr(CirrusVGAState * s, uint32_t val)
         break;
     case 0x07:                  // Extended Sequencer Mode
         cirrus_update_memory_access(s);
-        /* fall through */
+        fallthrough;
     case 0x08:                  // EEPROM Control
     case 0x09:                  // Scratch Register 0
     case 0x0a:                  // Scratch Register 1
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 1b27b64f6d..e21450d726 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -396,7 +396,7 @@ static uint64_t tcx_dac_readl(void *opaque, hwaddr addr,
     case 2:
         val = s->b[s->dac_index] << 24;
         s->dac_index = (s->dac_index + 1) & 0xff; /* Index autoincrement */
-        /* fall through */
+        fallthrough;
     default:
         s->dac_state = 0;
         break;
@@ -438,7 +438,7 @@ static void tcx_dac_writel(void *opaque, hwaddr addr, uint64_t val,
             s->b[index] = val >> 24;
             update_palette_entries(s, index, index + 1);
             s->dac_index = (s->dac_index + 1) & 0xff; /* Index autoincrement */
-            /* fall through */
+            fallthrough;
         default:
             s->dac_state = 0;
             break;
-- 
2.39.2


