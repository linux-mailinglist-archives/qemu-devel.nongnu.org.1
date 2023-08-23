Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B213785124
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 09:07:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYhxR-0006XK-3J; Wed, 23 Aug 2023 03:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qYhxO-0006X3-PC
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 03:07:10 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qYhxN-00044M-1h
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 03:07:10 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31969580797so4716060f8f.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 00:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1692774427; x=1693379227;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XhD97iO9Cr9UC31aJ5SoAXRsEoQS/yz+IXBL36dUT+0=;
 b=QkeCfdMVbNKGr09S+IC/2GgrzcZ/sL4AkI1PX7gmq146WTu91SExg51vLQo7S9pp78
 x6N/rNfc+xfhFnBgT3uLnl9X63A29EFYBWjc+eezcUA0FO8mWnD5MXB3CPoVBc1m6XPH
 us3/LSUKi0ETSFXRlggh0Spaqig6xmZi5xD3O6V3O9C1m3td7A3p+Z3gTWH7bFswUctb
 ZAEnDRZF6wfNBJfPYehuHOE0Hs+5v2cG0zTNsysBP8ZuZKNNZDLhvwss1zBDmY4fsFQq
 RcYHeukIyyDsfG1eSOLPnmlGkC9vWTR/S46wFPrOO6K7lfYtEc/t1HBNOAuxiy8QpDib
 Wbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692774427; x=1693379227;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XhD97iO9Cr9UC31aJ5SoAXRsEoQS/yz+IXBL36dUT+0=;
 b=U2NXwBRXz1s8/eb0o+XoEomjyp7XCula4AOFg1TjRu/pctnIB5oJF4jTaZUrEMbfV6
 FbQ8UCDcBnT0Vttli7PFjRqfCjWD54RGfLQnSp/t1GFcoo1TGdkBMByWByEp2KETv4Rl
 B+F2SiSDcGETLrd0rvw7EuFz8MJGDAyIA93nzlo+pC+pgQgd6k+4mAM5WKD2SvoSjkAR
 3Ew8FLGkwBUUeLpnhbqpAeD/JxXqAK4lGz6L3KZiSM1xaQpC8WKko7MH8XyoOedU8pKw
 BBSdhJiuVe21fORIRrDrF7mPdMWYQmRHGPJlCKUmh09qPAD4xPWai7M8+8b7PwJr30Im
 8e8w==
X-Gm-Message-State: AOJu0YzglLpXKwObo5jgR2sVvnlPhT+knZiUxlMi56oqKhb58Sxp8PWV
 AAnJ1oGtu6fpBwEGAlJ7QdKzh4ap5OsekMA4imo=
X-Google-Smtp-Source: AGHT+IFkgUUI8BS2Ce2Cpm9VkzCGS4qcldZ1sZgkQXpFMBofifVVcTX+vINuY6E6VyA3eHHQmb2siA==
X-Received: by 2002:adf:f64c:0:b0:319:77dd:61f9 with SMTP id
 x12-20020adff64c000000b0031977dd61f9mr8845679wrp.35.1692774427389; 
 Wed, 23 Aug 2023 00:07:07 -0700 (PDT)
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:d434:6b1d:751:97d0])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a5d58c1000000b003180155493esm17750970wrf.67.2023.08.23.00.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 00:07:06 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 2/3] hw/char: riscv_htif: replace exit(0) with proper
 shutdown
Date: Wed, 23 Aug 2023 09:07:04 +0200
Message-Id: <20230823070704.363098-1-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=chigot@adacore.com; helo=mail-wr1-x432.google.com
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

This replaces the exit(0) call by a shutdown request, ensuring a proper
cleanup of Qemu. Otherwise, some connections like gdb could be broken
without being correctly flushed.

Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/char/riscv_htif.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index 37d3ccc76b..c49d20a221 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -31,6 +31,7 @@
 #include "qemu/error-report.h"
 #include "exec/address-spaces.h"
 #include "sysemu/dma.h"
+#include "sysemu/runstate.h"
 
 #define RISCV_DEBUG_HTIF 0
 #define HTIF_DEBUG(fmt, ...)                                                   \
@@ -205,7 +206,16 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
                     g_free(sig_data);
                 }
 
-                exit(exit_code);
+                /*
+                 * Shutdown request is a clean way to stop the QEMU, compared
+                 * to a direct call to exit(). But we can't pass the exit code
+                 * through it so avoid doing that when it can matter.
+                 */
+                if (exit_code) {
+                    exit(exit_code);
+                } else {
+                    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+                }
             } else {
                 uint64_t syscall[8];
                 cpu_physical_memory_read(payload, syscall, sizeof(syscall));
-- 
2.25.1


