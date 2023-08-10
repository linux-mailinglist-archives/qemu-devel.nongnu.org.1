Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B12777FF7
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 20:09:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUA6G-00021Y-2d; Thu, 10 Aug 2023 14:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUA5q-0001xh-62
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 14:09:07 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUA5m-0001yG-Dx
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 14:09:05 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bc0d39b52cso8858595ad.2
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 11:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691690937; x=1692295737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZN+1yYSBIrLJScTtAThKTp6Rq6Vl+u2vg/TEhX0ETmw=;
 b=uyUazPTwX+ezXYgxtT14sMXI1T3E0DmaYURCuQNjnLKkbsnOXNw+VQtuhzqFqsZ/kU
 XKynZ9YAX4w4ArelbeOZOhrpfWgpNOiWtgm327pnXgn5+E82AXq788s8z9BqERKZTpxf
 UGhRnwkQulqdRcb2vL/EG5h9ArKIKdT2ysSwpVCB0SQzSm2EqFCKhMdqYfx/HhQd+eJe
 br/4NetyfZdtQTLGWG/vqQYiPsN4dyBDkZ2+5pdKcXchoPCxww0Qo/QJ6IaAxKETgMpd
 lmM4l47gN1mYA4fBU0Bh8qh1b0p51+IeUazo6HLsTqS9GFuVDo9BRCalv5AswzjiXnmj
 Ly+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691690937; x=1692295737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZN+1yYSBIrLJScTtAThKTp6Rq6Vl+u2vg/TEhX0ETmw=;
 b=dwxkBpbwvxSyjPVUGsOnoSmHOGFqVkfKZA9ZeNRXHCESerpLRaQyfhiNxLPwvV4O4Q
 OuQHy83nE0S8McGJUIIs1DSe8y824MUcs28IfpcES+Qj2sjehxo67Q/8gePwwaw1PWu2
 Zmg6HQq9hCS+HSlcgoSbhiZZGrmEGsAY9w5bkrQMs+zRoCnLGT3a33Bn3KXwq3jp3fNb
 VUPlPge6Ao3MzhclNd24C1LM5W+xlMdQzw6DffZm+Na/L7e17ek1Ff9y5KgLswOn1gFj
 VoVegp1USK8AmeOMoDnQhpnGJpMTEnynhZteFi8zRjCN3UXFqc4aHwQQycgXJnPfuGKV
 vtvg==
X-Gm-Message-State: AOJu0YxfAU/+GQ3I+XUgIIN+6TuufxtOJBPbczX9M54u7sCc6RWOY7Fc
 2yzXB0fRxUiKEisbCiPRqOi2vLC/FmxcuhZBXcA=
X-Google-Smtp-Source: AGHT+IEBi9hGODKRD1WQJuHg2C5nMML/zcOT6mMUJJXA25kZiD5+B1cVFBVP5R53hggI33jSYSwKug==
X-Received: by 2002:a17:903:26d2:b0:1b8:6e2e:78cd with SMTP id
 jg18-20020a17090326d200b001b86e2e78cdmr2774317plb.40.1691690937362; 
 Thu, 10 Aug 2023 11:08:57 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:9e4d:b830:d4fd:9164])
 by smtp.gmail.com with ESMTPSA id
 b14-20020a170902b60e00b001bd41b70b65sm2085212pls.49.2023.08.10.11.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 11:08:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/4] gdbstub: more fixes for client Ctrl-C handling
Date: Thu, 10 Aug 2023 11:08:51 -0700
Message-Id: <20230810180852.54477-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810180852.54477-1-richard.henderson@linaro.org>
References: <20230810180852.54477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

The original fix caused problems with spurious characters on other
system emulation. So:

  - instead of spamming output make the warning a trace point
  - ensure we only allow a stop reply if it was 0x3

Suggested-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <456ed3318421dd7946bdfb5ceda7e05332da368c.1690910333.git.quic_mathbern@quicinc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230810153640.1879717-8-alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
index 0c18a4d70a..7bc79a73c4 100644
--- a/gdbstub/trace-events
+++ b/gdbstub/trace-events
@@ -26,6 +26,7 @@ gdbstub_err_invalid_repeat(uint8_t ch) "got invalid RLE count: 0x%02x"
 gdbstub_err_invalid_rle(void) "got invalid RLE sequence"
 gdbstub_err_checksum_invalid(uint8_t ch) "got invalid command checksum digit: 0x%02x"
 gdbstub_err_checksum_incorrect(uint8_t expected, uint8_t got) "got command packet with incorrect checksum, expected=0x%02x, received=0x%02x"
+gdbstub_err_unexpected_runpkt(uint8_t ch) "unexpected packet (0x%02x) while target running"
 
 # softmmu.c
 gdbstub_hit_watchpoint(const char *type, int cpu_gdb_index, uint64_t vaddr) "Watchpoint hit, type=\"%s\" cpu=%d, vaddr=0x%" PRIx64 ""
-- 
2.34.1


