Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6288A76993A
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 16:16:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQTgd-0005al-AQ; Mon, 31 Jul 2023 10:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQTgT-0005Xy-Tm
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:15:41 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQTgR-0007ex-QP
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:15:41 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fe2048c910so9789235e9.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 07:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690812938; x=1691417738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=umPuKK0TP/i1glV8Qojb6FP6t/DJTY4yK7JJ/sINZ5E=;
 b=MFrKBW+iLqvFD3CUTIt8nain8KfYljuJkzxSmKOVH2WaY2eHKUQ/bZBX9g2NqO4BtS
 vfqZJnerM9oyDYR0uGaMweOhuHoRE9KETpezJxS9yOEDgz6XlJUHGpDS/SNxID04pXfp
 +R5+CMe1nnV1IHHjeQnuPMjV2NALGZB0wmSdgMpkgu1mBszVXXOE4Yjr2A7dj4qNHQht
 vPpyzBquqZUn9l86j8j4ugjY/K3ng3KMy6wh6nfKp4O1Hj+TZHuccFzpHG5IxPnIyKU+
 TBT6wVsP3q5PrlpS1J8RXPk8VuWJ5ElB6JQCKcSNi/tYKKjGMvww5e0BTNKnoEyffzg7
 KUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690812938; x=1691417738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=umPuKK0TP/i1glV8Qojb6FP6t/DJTY4yK7JJ/sINZ5E=;
 b=KARH+nFz7diFro5g8565NrS4N2fpo+vUpxxaUZ/P7ZSRSgjtVfrrZxveNGxTjGnxZf
 HIjn3N7Y5qrpPtSPz+yadldoGRViITg9Hwfxm7iEDLxtE8GNnl/TeMPy+rIPfJypafUF
 an5Bm9rnjZ9O64ClqIe0MWemM63lNztugqKNV+kv55DrFF2toeVbINX+uZ4OOM1u6Q2n
 BgbXBo12nGMiW/rdgyCjc8al9ches66/RXmnxCSClqTdYMGFCGPHhK9dWwRFs3tV6NpA
 Y51ajH46eiUCSJBeOmgS64Kp0fej9H0N1ENRPB6oarTjDc4RGL68LY2UfaC4DL883BC8
 NgSQ==
X-Gm-Message-State: ABy/qLY+vSr3QraxG9TKC+IneB4cMd/7ucMA9w+Yrj7Qi6zYpLeptcDs
 ZSFBU3SaKR7j52K7wpEBta8TMWcyedg7ZpWsCwE=
X-Google-Smtp-Source: APBJJlGOSesnwnG5ZiYGHKNIwSI6goZcnKQnF/tNx/wE9gsyxL61i+We79zbJocQVsSPs16fKHSt7A==
X-Received: by 2002:a05:600c:215:b0:3fe:25b3:951d with SMTP id
 21-20020a05600c021500b003fe25b3951dmr77568wmi.5.1690812938053; 
 Mon, 31 Jul 2023 07:15:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a05600c114f00b003fbb5506e54sm11450675wmz.29.2023.07.31.07.15.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 07:15:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/6] gdbstub: Fix client Ctrl-C handling
Date: Mon, 31 Jul 2023 15:15:33 +0100
Message-Id: <20230731141533.3303894-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731141533.3303894-1-peter.maydell@linaro.org>
References: <20230731141533.3303894-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Nicholas Piggin <npiggin@gmail.com>

The gdb remote protocol has a special interrupt character (0x03) that is
transmitted outside the regular packet processing, and represents a
Ctrl-C pressed in the client. Despite not being a regular packet, it
does expect a regular stop response if the stub successfully stops the
running program.

See: https://sourceware.org/gdb/onlinedocs/gdb/Interrupts.html

Inhibiting the stop reply packet can lead to gdb client hang. So permit
a stop response when receiving a character from gdb that stops the vm.
Additionally, add a warning if that was not a 0x03 character, because
the gdb session is likely to end up getting confused if this happens.

Cc: qemu-stable@nongnu.org
Fixes: 758370052fb ("gdbstub: only send stop-reply packets when allowed to")
Reported-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Tested-by: Joel Stanley <joel@jms.id.au>
Message-id: 20230711085903.304496-1-npiggin@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 gdbstub/gdbstub.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 6911b73c079..ce8b42eb159 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -2051,8 +2051,17 @@ void gdb_read_byte(uint8_t ch)
             return;
     }
     if (runstate_is_running()) {
-        /* when the CPU is running, we cannot do anything except stop
-           it when receiving a char */
+        /*
+         * When the CPU is running, we cannot do anything except stop
+         * it when receiving a char. This is expected on a Ctrl-C in the
+         * gdb client. Because we are in all-stop mode, gdb sends a
+         * 0x03 byte which is not a usual packet, so we handle it specially
+         * here, but it does expect a stop reply.
+         */
+        if (ch != 0x03) {
+            warn_report("gdbstub: client sent packet while target running\n");
+        }
+        gdbserver_state.allow_stop_reply = true;
         vm_stop(RUN_STATE_PAUSED);
     } else
 #endif
-- 
2.34.1


