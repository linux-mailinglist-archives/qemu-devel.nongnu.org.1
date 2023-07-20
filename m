Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D48375B3B2
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 18:00:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMW3r-0000YJ-Tg; Thu, 20 Jul 2023 11:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMW3X-0000X0-SY
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 11:59:07 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMW3W-00053t-4B
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 11:59:07 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57b6so8486055e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 08:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689868744; x=1690473544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xQLZW4i4RwSsIRthgz4zXgxBtJp6nXoRhcDsoNfo8Zg=;
 b=WjuU/m2JrumlbIxMi6C4lDSTFURyPZy6V01bUd1JHSD5fuB2IJwbWhOU9nJUK3/JcY
 O/XpCbALYG+XV7X/LncX5UdOBlRSSrcocINyDMv1ArfG9tZfqV+OJji7gkW4eUzsBCtq
 PEIZzT1gP3d7qsI2a3bPUVHXv4Hwnt9neM4JpzLMqPkdYlAqZI9EDVl6NQnz4dPjSLzK
 k1pqFbftEU8bqLAcuPm1YGBQEzLHFNoV/iOMuJd+I4ndQsDPajIR0Niyu6pBv8JDCaWB
 tNQWKzcQjRtFDgJ4Wk2h392RJG4+gPPxovt4krz7WoToXP+HiQstMOP839nNAPxLn0HO
 M2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689868744; x=1690473544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xQLZW4i4RwSsIRthgz4zXgxBtJp6nXoRhcDsoNfo8Zg=;
 b=PvQOM2nubShZgl+iucNqQdgNBRPoPSaNsXNvOUeP/JRloB3BgOeqoDqTxpNLplz5Rw
 gwjyFQMaI8LIN8LqKfvc8JESrivh+jQJGuZ2UxE5bxXTmXl6nhFOWkSObge2eoYGErCt
 oU84puEtLM5SQpo8JoTVxltmK4QPUmEcmnZ/l37NzS1ZKLrcUv3+yfmb4Zfm4GsUhnd5
 kxH16k79tjdqkrFK73blPggcqrV9S/H0KnMHO2rK3/eBvZ+yBQmJVZQTrE0QZ7/CTDAK
 lwo6yzDJFkLYpIrGOQ8oARVMV6CSRnn3Opn0XxSpWGfyiKbthl5tMknusRNWlidNCGT5
 IH8A==
X-Gm-Message-State: ABy/qLYxC++T0jwWkV3P0E/YLi4FbAZHmTqx2uH3M6vkWJDlsKY1OJYT
 uuT3zZAXsEx+8DAsIN7u+jAm7KpN5jTb1m8/rwY=
X-Google-Smtp-Source: APBJJlEj66efBVt2tcL5ODmn4VJuBvjsMxImyf2VK95LmOS6pjMBoG0IDGzFLNREMEqclh49e+L4xw==
X-Received: by 2002:a1c:4c11:0:b0:3f9:b748:ff37 with SMTP id
 z17-20020a1c4c11000000b003f9b748ff37mr7722489wmf.20.1689868744659; 
 Thu, 20 Jul 2023 08:59:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z5-20020a05600c220500b003fc02a410d0sm4187572wml.48.2023.07.20.08.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 08:59:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Subject: [PATCH for-8.2 2/4] hw/rtc/twl92230: Use int64_t for sec_offset and
 alm_sec
Date: Thu, 20 Jul 2023 16:59:00 +0100
Message-Id: <20230720155902.1590362-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720155902.1590362-1-peter.maydell@linaro.org>
References: <20230720155902.1590362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In the twl92230 device, use int64_t for the two state fields
sec_offset and alm_sec, because we set these to values that
are either time_t or differences between two time_t values.

These fields aren't saved in vmstate anywhere, so we can
safely widen them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I have a suspicion that really these fields *should* be
being migrated, but this device is only used in the n800
and n810 boards, so I'm not going to investigate how broken
migration/vmsave is there...
---
 hw/rtc/twl92230.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/rtc/twl92230.c b/hw/rtc/twl92230.c
index d8534dad949..64c61c3daeb 100644
--- a/hw/rtc/twl92230.c
+++ b/hw/rtc/twl92230.c
@@ -65,8 +65,8 @@ struct MenelausState {
         struct tm tm;
         struct tm new;
         struct tm alm;
-        int sec_offset;
-        int alm_sec;
+        int64_t sec_offset;
+        int64_t alm_sec;
         int next_comp;
     } rtc;
     uint16_t rtc_next_vmstate;
-- 
2.34.1


