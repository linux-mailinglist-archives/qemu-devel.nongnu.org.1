Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 519F27C63FB
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:20:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn56-0007jJ-Dn; Thu, 12 Oct 2023 00:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn53-0007YW-EO
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:49 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn51-0002p8-Nm
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:49 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c9bf22fe05so4625345ad.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697084026; x=1697688826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=veftKSXB2FWrw6QpnwNApk7dB5GUHGTtEp1XFLpeKKM=;
 b=ATuZnPoEaZ4k8RcGDV0bQb+xCgM4kY4qSvZrXzKJYI9MqiG/CJS/hw4a6l29MWXS0Z
 Ltadd2yRqYUxJ/5lbLNGB42hwnkwLOFwFxLpBeVOzd4Wfb0GD4Cl3bI9YDJlHJLKpyv6
 rn+9uXwrUkjoJrGEImj5ntiLxoO0ZM63C4e2u7ih8p71PjSnSxRfjU2+5ERGHDEo8Avl
 y/JcNs3+MvYMl941BSJtE5o6Fga17sm43qQgbSN7h/zDFZHJO47c/ELuzz+ZF7/cFB+3
 VHEo9ekxHMww/8N0Z3ESBsOPuQm8mHMhO4mZwDsC8OMmQHfDzR9vfdSYbSoq8BksQfdR
 e3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697084026; x=1697688826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=veftKSXB2FWrw6QpnwNApk7dB5GUHGTtEp1XFLpeKKM=;
 b=LiGr6ULmgwNwt7heYv/2TaGzpGB7LHxVFM6ZsZeKU8JLhmv34iMjGN73N9gMK+hoo7
 /04k6F/ou4kUczPRBPxOVSALVm0s7Ia0v/Zlox9K5jaavV/3FwGkkpuJY8g5DeS3u5Rq
 SVVTGloHc0WQlnmsZiJOrT3XPJ8qIAKmKeBB9f7kis1g/cz8tIydREVjgl3zG14aLqlO
 74l5Pft3V3fJVvUqOQOwOI3E7ZHesqVBUqSHvNKOdYAzX+s1bhArmJT5w0vWUNZVwhSg
 +4jjwEQ01Qa6O3L4KgS2uyDL7bV9IPRH68Ii8UGYFYsIe102q5H1SJI5c5ccX5Qi80f1
 wzTw==
X-Gm-Message-State: AOJu0Yxamns0jfwbHqvS4tOATmWxKFGOCtDAkV0H/o9QL/Y1Flb6G8wF
 BU+tQHrZ+h4NlhYTfUvDhdm+q8r6aUSIqQ==
X-Google-Smtp-Source: AGHT+IEPWZg1DbxP+NK1hTrPiS72OmLbvtHfRonN3q6pGX4ndBU+AADk52n5d/oyztB2osJ1P2cDVA==
X-Received: by 2002:a17:902:d2cd:b0:1c3:94a4:34bf with SMTP id
 n13-20020a170902d2cd00b001c394a434bfmr24931248plc.66.1697084026202; 
 Wed, 11 Oct 2023 21:13:46 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:13:45 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 47/54] hw/char: riscv_htif: replace exit calls with proper
 shutdown
Date: Thu, 12 Oct 2023 14:10:44 +1000
Message-ID: <20231012041051.2572507-48-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

From: Clément Chigot <chigot@adacore.com>

This replaces the exit calls by shutdown requests, ensuring a proper
cleanup of Qemu. Otherwise, some connections like gdb could be broken
before its final packet ("Wxx") is being sent. This part, being done
inside qemu_cleanup function, can be reached only when the main loop
exits after a shutdown request.

Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231003071427.188697-5-chigot@adacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/char/riscv_htif.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index 40de6b8b77..9bef60def1 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -32,6 +32,7 @@
 #include "exec/address-spaces.h"
 #include "exec/tswap.h"
 #include "sysemu/dma.h"
+#include "sysemu/runstate.h"
 
 #define RISCV_DEBUG_HTIF 0
 #define HTIF_DEBUG(fmt, ...)                                                   \
@@ -206,7 +207,9 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
                     g_free(sig_data);
                 }
 
-                exit(exit_code);
+                qemu_system_shutdown_request_with_code(
+                    SHUTDOWN_CAUSE_GUEST_SHUTDOWN, exit_code);
+                return;
             } else {
                 uint64_t syscall[8];
                 cpu_physical_memory_read(payload, syscall, sizeof(syscall));
-- 
2.41.0


