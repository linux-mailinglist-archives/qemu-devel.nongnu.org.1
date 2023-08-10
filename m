Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03006777C59
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:38:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU7iZ-0005Pm-NP; Thu, 10 Aug 2023 11:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU7iV-0005Mg-Uj
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:36:51 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU7iQ-0003Ey-BI
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:36:51 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fe4ad22eb0so9289025e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691681805; x=1692286605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+hzkLqMShk2eSDpt7ofnm8iQ+BmAGdQ23pVnCkXYCc=;
 b=qSPdGP5emdtMSmZHodKdvztcmt7T2Wkdf08tKPUMS/9gAsiyfPFv+Ci/GKNhXrZnT9
 7RGEA6bBHUMUog0P+/yiJV+tax/4X5wj6ToeaKaCIE5BXAOutBMDqp2tNwISMd/keoKo
 oumOpPBpU6Ow1A7iHYosTIZ7Z4Bs2ajdKeH8CIGDP07pGYKZaJp2OQpbpt60pYiQq2WC
 Ch8qoESAQZJibYd3a80bJUfWdy1RWnr4sOzDYBDUsEXEgrFB+/od2/n6XM6sPOKR1MJi
 5+ZjSPBanf1SdlGkqtHhwOymo8+q0FzlyhHNNYKCIjUtpMA1zoP3leECjU9jPdbwgr9q
 S/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691681805; x=1692286605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+hzkLqMShk2eSDpt7ofnm8iQ+BmAGdQ23pVnCkXYCc=;
 b=FOcnKpAVywQSR5/9kdvrWgeHnmJn5Ym5+4F8oNtliS3Q/U7FVmDT9N93dOKmtKqtoL
 VsI1wWqBtDUaCIiwCeZgP+fNQ0LNJ6oEyu1ekpOwFADXk0l1xqUU9mhI0udzaHV2XZAD
 Ngqt/2Tl8m95zuDQARzUskEMFQNBsGDj0PexiYYzZvDZipxdofLHYDgCRWnVy8Pth9H6
 ORQmKT/W3MxPj00RnLJBP33vaVli5xPkrHVWHH1LbxehPZEE0ec5VahYrYqeZ5r1xWXl
 CJMmo+KxRYYa3Yz+CMwAgqFWH2TATrJBz3ho9f+HrMs2wlU7d9KEokHUEz+XOiwcNL9u
 FtlA==
X-Gm-Message-State: AOJu0YwntERWfzkt9ZF6p8z73x31Ogf2rnoO6yf8C3TSTvZZpoY16+Fz
 YRo/MHtSTE4MvAoMYEqLgnqytg==
X-Google-Smtp-Source: AGHT+IFEg2o3IM7QDmNxkgmskaXfAN/Z2Ug/n7eOHumvqAFZjT1yRHJZn6u6sqnuFgQqHWEAoZCEXQ==
X-Received: by 2002:a5d:504a:0:b0:317:74ce:3e27 with SMTP id
 h10-20020a5d504a000000b0031774ce3e27mr2676389wrt.67.1691681804925; 
 Thu, 10 Aug 2023 08:36:44 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a5d4d04000000b00314398e4dd4sm2503902wrt.54.2023.08.10.08.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 08:36:43 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8AA4E1FFC2;
 Thu, 10 Aug 2023 16:36:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Subject: [PATCH 7/8] gdbstub: more fixes for client Ctrl-C handling
Date: Thu, 10 Aug 2023 16:36:39 +0100
Message-Id: <20230810153640.1879717-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810153640.1879717-1-alex.bennee@linaro.org>
References: <20230810153640.1879717-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

The original fix caused problems with spurious characters on other
system emulation. So:

  - instead of spamming output make the warning a trace point
  - ensure we only allow a stop reply if it was 0x3

Suggested-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <456ed3318421dd7946bdfb5ceda7e05332da368c.1690910333.git.quic_mathbern@quicinc.com>
---
 gdbstub/gdbstub.c    | 5 +++--
 gdbstub/trace-events | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index e74ecc78cc..20b6fe03fb 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -2059,9 +2059,10 @@ void gdb_read_byte(uint8_t ch)
          * here, but it does expect a stop reply.
          */
         if (ch != 0x03) {
-            warn_report("gdbstub: client sent packet while target running\n");
+            trace_gdbstub_err_unexpected_runpkt(ch);
+        } else {
+            gdbserver_state.allow_stop_reply = true;
         }
-        gdbserver_state.allow_stop_reply = true;
         vm_stop(RUN_STATE_PAUSED);
     } else
 #endif
diff --git a/gdbstub/trace-events b/gdbstub/trace-events
index 0c18a4d70a..b383bf8d29 100644
--- a/gdbstub/trace-events
+++ b/gdbstub/trace-events
@@ -26,6 +26,7 @@ gdbstub_err_invalid_repeat(uint8_t ch) "got invalid RLE count: 0x%02x"
 gdbstub_err_invalid_rle(void) "got invalid RLE sequence"
 gdbstub_err_checksum_invalid(uint8_t ch) "got invalid command checksum digit: 0x%02x"
 gdbstub_err_checksum_incorrect(uint8_t expected, uint8_t got) "got command packet with incorrect checksum, expected=0x%02x, received=0x%02x"
+gdbstub_err_unexpected_runpkt(uint8_t ch) "unexpected packet (%c) while target running"
 
 # softmmu.c
 gdbstub_hit_watchpoint(const char *type, int cpu_gdb_index, uint64_t vaddr) "Watchpoint hit, type=\"%s\" cpu=%d, vaddr=0x%" PRIx64 ""
-- 
2.39.2


