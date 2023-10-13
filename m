Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5887C7FD3
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:18:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCyI-0002br-B2; Fri, 13 Oct 2023 03:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxN-000733-SZ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:39 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxB-00055N-5y
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:37 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-323ef9a8b59so1741753f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183480; x=1697788280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zt1Cbdxf80sA4qUTrrmRnyL3tHABTBMLvyZdLPFroHM=;
 b=JhSOyziwlr5QOeQAQsrV6IRv0vSWF9AOy7kTmgWgHyEJ97LsUX2xZkYibaxAhzmaWF
 1KSIDF0VScQvzm4U+HAc7ERqeripWbqxK04F5yH4SuQvZPLsMwXCGg+GpoYB86hLb6yg
 MEwZuqRgwWZDMVTetRRNOXmRxw/3Gtv3SAuC8dbR/Cw9SlsvT0+aPZPik2qwgKQ45JJs
 NENT5BNuWgL5zvBBHSngGopGAnYTTqxMbQHn4lNwO7AKz2cBNSOmXw7GJpaiBHWTvHQa
 C+M8p+k9a7JOWQIeFziCEruLRbNuVB12J0korBG2xvRnC6lYdOD9zzXPOESdjw6uCDj9
 W9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183480; x=1697788280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zt1Cbdxf80sA4qUTrrmRnyL3tHABTBMLvyZdLPFroHM=;
 b=IKuzTSy70BP0tqYFSBdSK9LvwGAX1ciyshOrwww9e5V/2UOLlPGe+hkjsWBQ7sSPVa
 oICkNapWu2kjMoj4PfcezA2HP4NeDRGI2y7XkZJIMx2NBdReUQPnDI19hadqNJEvpUq0
 J027flZovznbrAtcbQlO08bPHr8Z5VuibBM96E8YnyNdRHW/lSaohRdm0otBecwWAY3z
 MqupHwGR9md9oc5GU523vIJivjKXpVPoGZKLXUKR2LZJo2mzEurnCdpm8oKc7yydilmM
 8C/gLOo8b8eP44Gl7ZxaJK1214Nu4vupteywUZ+7r7t6TOcHcSSDMJHqkyimCJV4cNUk
 PdEw==
X-Gm-Message-State: AOJu0YxdQ+WGjo2W7j4b02TxAnTaWT38JVpkZo968CAgcl17gReFeRIn
 BD4jdVGrLzsgyhUe5+/bZugEMnZqHH3lxVkoF34=
X-Google-Smtp-Source: AGHT+IE+915UM9wOp91wVPOLR2Bf5xkrHGuJYiRABFXOYouT1JSz+f/xr5IVbDed+hUxFZRgqHN6bA==
X-Received: by 2002:adf:f403:0:b0:321:5b64:f744 with SMTP id
 g3-20020adff403000000b003215b64f744mr21846560wro.20.1697183480727; 
 Fri, 13 Oct 2023 00:51:20 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:51:20 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
Subject: [RFC PATCH 43/75] hw/m68k/mcf_intc.c: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:53 +0300
Message-Id: <3cda982b0d9959ff4ca39d90e404a27a489b9340.1697034504.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697034504.git.manos.pitsidianakis@linaro.org>
References: <cover.1697034504.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42a.google.com
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

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/m68k/mcf_intc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index 4cd30188c0..9556a0ccb7 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -58,34 +58,34 @@ static void mcf_intc_update(mcf_intc_state *s)
 static uint64_t mcf_intc_read(void *opaque, hwaddr addr,
                               unsigned size)
 {
     int offset;
     mcf_intc_state *s = (mcf_intc_state *)opaque;
     offset = addr & 0xff;
     if (offset >= 0x40 && offset < 0x80) {
         return s->icr[offset - 0x40];
     }
     switch (offset) {
     case 0x00:
         return (uint32_t)(s->ipr >> 32);
     case 0x04:
         return (uint32_t)s->ipr;
     case 0x08:
         return (uint32_t)(s->imr >> 32);
     case 0x0c:
         return (uint32_t)s->imr;
     case 0x10:
         return (uint32_t)(s->ifr >> 32);
     case 0x14:
         return (uint32_t)s->ifr;
     case 0xe0: /* SWIACK.  */
         return s->active_vector;
     case 0xe1: case 0xe2: case 0xe3: case 0xe4:
     case 0xe5: case 0xe6: case 0xe7:
         /* LnIACK */
         qemu_log_mask(LOG_UNIMP, "%s: LnIACK not implemented (offset 0x%02x)\n",
                       __func__, offset);
-        /* fallthru */
+        fallthrough;
     default:
         return 0;
     }
 }
-- 
2.39.2


