Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 153BD7C80BF
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:50:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqo-0001ZY-GO; Fri, 13 Oct 2023 04:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqa-0000qB-A3
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:40 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqY-00017u-Hy
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:40 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3226cc3e324so1761061f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186917; x=1697791717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wu2X45rHyvL3XcPNHVCYQy3x7VFhkkKPO+gE/2X5B1M=;
 b=tW8T5jHlIpsyOIJmdMmiV9FY/rssAsT+rX4o8SJ5MaetSi45meV5vEtIk30KGhCK27
 75npuMb1UdIYHocml3MJuGf6C0Fmj5YpozMspz7dC4em3kmaN3StQfZuVAL8eZ8Jtuvq
 hS8lKhuLYjzqHBWERxyNT91TXmMghzRfnteX/tdzn54k+w3wegQakg+iAgpsVqg+Ixko
 p2kS7aJsaj0SVd8HrrJUGEmoM83fQP1ZURCmqc7yz/QcXkAAMfhzO7Os40n66+2Ifav2
 /SbsBfkUuXqG1cAoARfpV/ZlRgxy6nhvnN2jnhKY+WgPbR7pmnLsVJnZyWOnH0vOaHP+
 yXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186917; x=1697791717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wu2X45rHyvL3XcPNHVCYQy3x7VFhkkKPO+gE/2X5B1M=;
 b=ojgOE0GWlttV94KPFBRLakC9G941DA8Wpi+txarWDpqd7Kw1/V7jF/T09GViS+00N2
 C5dBQrhARGBAF0E+yxnCjDaFudccu9KwHvnGbHLJ+lhi3Bd+ts0D+1DNLqWwvR+vQlpS
 YkTztwIYPeEG7WAfoSbMNQJpus2+3ekXLELogCjdYQb2vNLMnQCUfphVZ9R9QAZpI+bj
 ytJzmmmqAovCpMzkx0czMnAg3WEziId5lLKhDik54Pkyp56/VOEDdx+9dc/HpvjEb5Hf
 AP2/HVmR1MEUqFrstiqGW8ifq78MUQlsKHo4R57Z0T0tCCib5J3mEVTwkQCs+DY6wY83
 Tkow==
X-Gm-Message-State: AOJu0Yz7jokd0Np2cbOO1FMW7H/AUDvJ7nCRnLyyplRUoeP7wpyQkIbu
 L3+DPjGuLhyEtBhX5v0MVevX3FMF+nIExoJHGko=
X-Google-Smtp-Source: AGHT+IFHP9M26NOeDyo5SMDPN5RoKQq8LSQ4HqxnfrmU6Q4RYBQPiqAqtPCadD37K+51JAPBmDMCoA==
X-Received: by 2002:adf:e9d0:0:b0:313:e8b6:1699 with SMTP id
 l16-20020adfe9d0000000b00313e8b61699mr22616610wrn.55.1697186916936; 
 Fri, 13 Oct 2023 01:48:36 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:36 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [RFC PATCH v3 50/78] hw/audio: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:18 +0300
Message-Id: <d53fd37b46a1011bafa2719440447b14a042d262.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
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
 hw/audio/asc.c        | 2 +-
 hw/audio/cs4231a.c    | 2 +-
 hw/audio/gusemu_hal.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index 0f36b4ce9b..336da09509 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -229,7 +229,7 @@ static int generate_fifo(ASCState *s, int maxsamples)
                 break;
 
             default:
-                /* fallthrough */
+                fallthrough;
             case 0x80:
                 /* Raw mode */
                 if (fs->cnt) {
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 3aa105748d..3bf0116c68 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -311,7 +311,7 @@ static void cs_reset_voices (CSState *s, uint32_t val)
 
     case 6:
         as.endianness = 1;
-        /* fall through */
+        fallthrough;
     case 2:
         as.fmt = AUDIO_FORMAT_S16;
         s->shift = as.nchannels;
diff --git a/hw/audio/gusemu_hal.c b/hw/audio/gusemu_hal.c
index f159978b49..76dd906ea1 100644
--- a/hw/audio/gusemu_hal.c
+++ b/hw/audio/gusemu_hal.c
@@ -261,7 +261,7 @@ void gus_write(GUSEmuState * state, int port, int size, unsigned int data)
             GUSregb(IRQStatReg2x6) = 0x10;
             GUS_irqrequest(state, state->gusirq, 1);
         }
-        /* fall through */
+        fallthrough;
     case 0x20D:                /* SB2xCd no IRQ */
         GUSregb(SB2xCd) = (uint8_t) data;
         break;
-- 
2.39.2


