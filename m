Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 999BD79A3A7
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:45:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfaeI-0000Bc-BP; Mon, 11 Sep 2023 02:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfaeG-0000BU-Rq
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:43:52 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfaeE-0004RK-Ou
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:43:52 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3a85c5854deso3171395b6e.0
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414629; x=1695019429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TjdxtVU3gNPjJmXFfAVRml366UxrtlzbUcZBrAyMCEU=;
 b=rrkF9KoRGYqQE6nn68Dz6IgQNwkf1VojbPKoiTlAFRFpSrsL8pTFcKLlHdkz8ISRHv
 JozrvQGEpAkdCyfZptj8vog1FnHDhLsewGIS1jxq9Mh5AesEZpARu0Dq8xTV93i8Lrwv
 nQEmRvCxIrcAxnJZsSLaY/LIvJ0PkCPDLak2uCCMs25MMwglVL0HMEO3QiF02alfoG0m
 WCc8H4tGT+1f4BPGIUxLmLg0f42NhukQF7NWGnBVlkXaupixNrv4xP9DLvSoexzOEDNi
 ysOLLtoKdW6GiRAUvJsgJFbb1zU3stSkG1kia+BwfT4EGBHZ4wCm1rKEsv9DKyJamCDG
 ZEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414629; x=1695019429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TjdxtVU3gNPjJmXFfAVRml366UxrtlzbUcZBrAyMCEU=;
 b=qUrlPKOVvC7i/u5KVtRkucZKnPOBxWn9niEU31Y1UrcOuoO8txRQ+PCnsE+QF1MVPd
 YELsidbfjbzYnkAJBhCE/lHv+7LD03Kd/NW8npBPudJYdlmLSltXK9Pgttdb0+wUe7ie
 uRBTvqgef7EU1YgfapMCIHpvMl4ghY5NRDEK49kNI0R2n/tfdt8JAut3qBj+wI2MBsSl
 sPgnCe6mnejx2LSa/EYUJ+aj0KMPQg9oBTrgZI4vE2X50J3KCO8AAamUFGei5ZOOD8u0
 mAHevfMqYKZkt4dQNo/xRlWSCULU1u8bmDkqwb5l9UijJ+PcHmyfb/UkXrJeOKlkF/0R
 7I4A==
X-Gm-Message-State: AOJu0YzbMLcWOV0S9aGUQ1+lUbhdDPegU7t5xDnZk9uJEfjD0xoa2KV+
 YnRQL6Fln9aU42/v77VBlxxObw6PLyM7uw==
X-Google-Smtp-Source: AGHT+IFbxi1u0b2fGmog/ZAbQjSXcL7y3oPbFjAD0rFVukgXds0qPjrqHkD6nJNdW4adqbza89FdIg==
X-Received: by 2002:aca:1216:0:b0:3a7:3ea1:b5a0 with SMTP id
 22-20020aca1216000000b003a73ea1b5a0mr11063314ois.47.1694414629302; 
 Sun, 10 Sep 2023 23:43:49 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:43:48 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng@tinylab.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL v2 03/45] hw/char/riscv_htif: Fix the console syscall on big
 endian hosts
Date: Mon, 11 Sep 2023 16:42:38 +1000
Message-ID: <20230911064320.939791-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22d.google.com
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


