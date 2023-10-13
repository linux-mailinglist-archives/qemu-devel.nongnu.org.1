Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A757C8127
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:58:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqr-0001v6-75; Fri, 13 Oct 2023 04:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqH-0008KT-AS
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:21 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqF-00012O-L9
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:21 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31c5cac3ae2so1686800f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186897; x=1697791697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5erDX5CeJrmaM9ok4NwBCizXAUuy1vmVb0p0qWaCyl0=;
 b=QKW2xPg48CuVaY+jKbOCK6MM6z9QAFSuKC/xQHjqqSF5U1nutOwMoqaowlNYSby2Fp
 XwNnkIpxyzNRTT+XjilFjBC+45hFt2xlic+lDtQXyi+qpsd3MxhS/bT0Rppj4pHp4eJW
 dWw+yLdGQ6kJcoVUfHsiw/o+JphwE7sjGlYHRXVYguygOdDAJ11SYkTv3KNfsjLNS39l
 18CyNdHaGCgISLWPE1WhfnT+wAgn4gMv6fbcZI4OIXHxTg1XoGEpXKO+zwI9xMB6KPKH
 04SsM8xHlRdi5uaMoJe87n6EfiFYsNrsLdC6vZLjzqTNeCT/m3mybDxF9pOlAptHIxds
 zkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186897; x=1697791697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5erDX5CeJrmaM9ok4NwBCizXAUuy1vmVb0p0qWaCyl0=;
 b=iI2tVA3iCXjl/UE27yZfAFHEmH4wqPDKKAabDMA7BrShPeieNWnbIveNxEZ81dcgF1
 xHGLRdR/ZI3HqgKm4aJi5DK01s2nDxJFHNQozuQo3DlA76h4Ydd/eGdR7hiOpjWzLDVO
 iunTdzrOF3OHvuUslxcJQrBO4XhgR0IlRugnGkzhEyb+UMUP3p10+l3qWZL9ElGnhTCo
 ybD0vHbfD0UcG5fYy/5OKb6cZ4SYWWmHnYreJMEoHJWebbC1SrsEveTYEENBptxaQwTQ
 5keqbd+ZKYg3pWYcsrmJUPpeJAujOMRXEC/ZIL14nCl5aVBdundVl8DQ34N48Ih4QkF3
 pifA==
X-Gm-Message-State: AOJu0YxMLyLZ09+Yxjq6z2yLVCcq176+KVhFKC6EuWiOzEdscYuL9Lty
 lWsyjGEyXs7y6XOualqeTeHdRzMJxqFqU1nur8I=
X-Google-Smtp-Source: AGHT+IF6s4oLTg7/S2G8s0owYUpcStvNNkyiUkbz/P1tAUQsGhCcO1bHrFrkErvI6jcVjeaZeNr7UA==
X-Received: by 2002:a05:6000:114d:b0:323:37a8:d085 with SMTP id
 d13-20020a056000114d00b0032337a8d085mr21956953wrx.58.1697186897015; 
 Fri, 13 Oct 2023 01:48:17 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:16 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC PATCH v3 38/78] system/rtc.c: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:06 +0300
Message-Id: <08834e5c3405e40263a7e9f288804e9e03ee1e0c.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x429.google.com
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
 system/rtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/rtc.c b/system/rtc.c
index 4904581abe..bb406542c8 100644
--- a/system/rtc.c
+++ b/system/rtc.c
@@ -53,7 +53,7 @@ static time_t qemu_ref_timedate(QEMUClockType clock)
     switch (clock) {
     case QEMU_CLOCK_REALTIME:
         value -= rtc_realtime_clock_offset;
-        /* fall through */
+        fallthrough;
     case QEMU_CLOCK_VIRTUAL:
         value += rtc_ref_start_datetime;
         break;
-- 
2.39.2


