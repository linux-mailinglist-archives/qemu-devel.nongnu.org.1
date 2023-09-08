Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5617981C3
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:06:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUcD-0008UO-DM; Fri, 08 Sep 2023 02:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUcA-0008UC-V8
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:05:10 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUc5-0005Cc-E4
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:05:10 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c06f6f98c0so13935675ad.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153102; x=1694757902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vym8XbbEH4MOTDPO5rs9mKsM5VAOMq/9GygQwXQnKYA=;
 b=q4h78H6JYa4GmTloCCHNUeFmAcbIKMxI8dLBaISqZUFvWyCjWeR93tVQrKHRKwWQTW
 XQaWoEfiRURtYIari1HTxBl80jvGMaiDC2SjBP+ozdb9gbiGFJj+9pgey0DdORutWoJV
 Ic8gQ72MmSzF0Ge7wt5MStuNlHIhgodkdKH0Kah+MlZlmuKycvGuXrSc6iyhWOgaUqGt
 XLn0gUx59WDbOneeo+kH2n0WsQOrQoxoYF9MHDpLPP9Uc9cpJhpNKZT6Atxq6T7hXNfI
 z4H/JS8bTj9scbvqjF22g6j7KaRJsTN9UggYp1oT9qCyS9OyFZdGDnY1i36mF7V33m8O
 9SwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153102; x=1694757902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vym8XbbEH4MOTDPO5rs9mKsM5VAOMq/9GygQwXQnKYA=;
 b=C3W+ZqDjWs8eH3XzmdPe9x+qlRggeqnwzt9rVW0ijRB5/BgW8cGagLrZ6IUHnktkLU
 lu9cy0gooiO9NmwjhGQ4d5GbPuCL+kmI9sTooP7fUIg5ntvx1EEL5HlEtFKq+dIkI/+E
 U1fmq/OpCxzBgJ0KzhTojlDEYKqx83inKRn1S6SGaip+vOHaJBjRCYhFYSv2pGsvoOwr
 wixGeZGlFyFzr1xAXgg+fZOXCDcI96RdkFmM/dxt4siLOgj3bllZ/DdmpQeEJ4p3DqbD
 2CtcdJcfIt1OdXAie+1pa8qRynHhqahOJqGiMnL04SWALcj0vUajTKWIB+//gl2T+39r
 Or8A==
X-Gm-Message-State: AOJu0Yzd553z7B/usbs9uJcd0nbAT4V1XMw/SqEgDkQKThd4RrT288mC
 mzyzR9BPi4XCOt/r38zPsA4rmc5cF9diYBmx
X-Google-Smtp-Source: AGHT+IGB0yKImZLaxrKAObiL4nhHCn950URu7udzeeMeJoUptMtO8xtMc3WQreNIBK+6/ixjYmN9lA==
X-Received: by 2002:a17:902:f7cf:b0:1c3:6705:bcee with SMTP id
 h15-20020a170902f7cf00b001c36705bceemr1553292plw.57.1694153102512; 
 Thu, 07 Sep 2023 23:05:02 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:05:01 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng@tinylab.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/65] hw/char/riscv_htif: Fix printing of console characters
 on big endian hosts
Date: Fri,  8 Sep 2023 16:03:28 +1000
Message-ID: <20230908060431.1903919-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The character that should be printed is stored in the 64 bit "payload"
variable. The code currently tries to print it by taking the address
of the variable and passing this pointer to qemu_chr_fe_write(). However,
this only works on little endian hosts where the least significant bits
are stored on the lowest address. To do this in a portable way, we have
to store the value in an uint8_t variable instead.

Fixes: 5033606780 ("RISC-V HTIF Console")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng@tinylab.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230721094720.902454-2-thuth@redhat.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/char/riscv_htif.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index 37d3ccc76b..f96df40124 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -232,7 +232,8 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
             s->tohost = 0; /* clear to indicate we read */
             return;
         } else if (cmd == HTIF_CONSOLE_CMD_PUTC) {
-            qemu_chr_fe_write(&s->chr, (uint8_t *)&payload, 1);
+            uint8_t ch = (uint8_t)payload;
+            qemu_chr_fe_write(&s->chr, &ch, 1);
             resp = 0x100 | (uint8_t)payload;
         } else {
             qemu_log("HTIF device %d: unknown command\n", device);
-- 
2.41.0


