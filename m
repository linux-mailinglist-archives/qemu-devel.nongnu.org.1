Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3918B7981C9
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:07:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUcE-0008WG-Tr; Fri, 08 Sep 2023 02:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUcA-0008U8-Om
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:05:10 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUc8-0005D0-De
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:05:10 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bee82fad0fso14660955ad.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153106; x=1694757906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TjdxtVU3gNPjJmXFfAVRml366UxrtlzbUcZBrAyMCEU=;
 b=qhwY4i2v7M5r8EGe7TlfQy6Ssv8xoBoaXxjOznFW66cYc7WYWJWtobtdag400mwqXj
 t8f4Ihgy5xeueHmcM6dRsBWx3uHDyhIcNysmOdiUydWRk8zjqThWiL0TxNf2ZcVMqgf2
 q45fEjM/i59opjah3m8PbBaEhtkiFvwyWFP/q+lrWST+KAUqqP5hUsxQNFkmXnybjDJI
 4df9wtzPpYgwEuz725UW4w3co6XszIS2bAEsZ2j0RfTAb+voq4Xse6iQR5KrDBdGTKXO
 u+MIJWZ624Rad0If3hwh1otRz1D4RPVpw/4Wc2Gb8gbF/y/PhA00X4rAF5Fd8PH3HLj0
 l7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153106; x=1694757906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TjdxtVU3gNPjJmXFfAVRml366UxrtlzbUcZBrAyMCEU=;
 b=dMDW8IM7S7BuZZhg3W3OxsjqiOcquKVf0jqaMJk3B0oF8hCG06JRg6pl3ZcWn6icws
 HcV/YhopMCnFDXDtu3CxC0xzrjcluVprGcXJFrYnpE6swN6NTFnj8meI6g6A1V0CPBWu
 ZnUdoPKW2y0gQt/iO3aeYJf7GA/E4PZoacrLrHx012c3RKf6lHX6+fTtZmDn1Jl9qPkb
 QkqVnr8i0RXIthMaP9wcER+kFFqO8Mp3KpKBkTOpo1Uzw9S6RJWETDByQiy/qMWxhheQ
 70zm0h/YXXiLHpzNdMkupZt9QvbsTh9g/QnhaNgpbqQge2O348GVOm5/ZSUbFz2SQcvV
 8M+Q==
X-Gm-Message-State: AOJu0YxIMw4j4lJ3NO1LaHrv9RauIQhAT/y9sj5dOca53b4/9WnHDRa1
 6ZEx2wjejKDg20HUYAXZxoWdkQpyzYYNhL69
X-Google-Smtp-Source: AGHT+IEJBxij3UDeLb5QsG+N4+0qrKv4inB0P1Mm8zVbOa+U1yTXE31lF0UQyRCbxrOvUrCyGAZ/ew==
X-Received: by 2002:a17:902:b497:b0:1c3:61d9:2b32 with SMTP id
 y23-20020a170902b49700b001c361d92b32mr1399375plr.45.1694153106453; 
 Thu, 07 Sep 2023 23:05:06 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:05:05 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng@tinylab.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 03/65] hw/char/riscv_htif: Fix the console syscall on big
 endian hosts
Date: Fri,  8 Sep 2023 16:03:29 +1000
Message-ID: <20230908060431.1903919-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Thomas Huth <thuth@redhat.com>

Values that have been read via cpu_physical_memory_read() from the
guest's memory have to be swapped in case the host endianess differs
from the guest.

Fixes: a6e13e31d5 ("riscv_htif: Support console output via proxy syscall")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng@tinylab.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-Id: <20230721094720.902454-3-thuth@redhat.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/char/riscv_htif.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index f96df40124..40de6b8b77 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -30,6 +30,7 @@
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
 #include "exec/address-spaces.h"
+#include "exec/tswap.h"
 #include "sysemu/dma.h"
 
 #define RISCV_DEBUG_HTIF 0
@@ -209,11 +210,11 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
             } else {
                 uint64_t syscall[8];
                 cpu_physical_memory_read(payload, syscall, sizeof(syscall));
-                if (syscall[0] == PK_SYS_WRITE &&
-                    syscall[1] == HTIF_DEV_CONSOLE &&
-                    syscall[3] == HTIF_CONSOLE_CMD_PUTC) {
+                if (tswap64(syscall[0]) == PK_SYS_WRITE &&
+                    tswap64(syscall[1]) == HTIF_DEV_CONSOLE &&
+                    tswap64(syscall[3]) == HTIF_CONSOLE_CMD_PUTC) {
                     uint8_t ch;
-                    cpu_physical_memory_read(syscall[2], &ch, 1);
+                    cpu_physical_memory_read(tswap64(syscall[2]), &ch, 1);
                     qemu_chr_fe_write(&s->chr, &ch, 1);
                     resp = 0x100 | (uint8_t)payload;
                 } else {
-- 
2.41.0


