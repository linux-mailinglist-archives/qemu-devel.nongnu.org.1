Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC187C63FE
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:20:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn55-0007eP-58; Thu, 12 Oct 2023 00:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn50-0007GR-Tk
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:47 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4y-0002oe-UL
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:46 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so418917a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697084023; x=1697688823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=atO5nwZZQlIy61ye8XKDsNGXZMxK/7JkrrKgc8s8+OQ=;
 b=G8RLzgM7koJ06HpkEbKTDG/aOiktUzI0hm9nAMPv4fImpNRnMYduSTPYRgaZeR8OCc
 fkVRV4vKjf45iJmvO4b3prr3gp41P73Edvyj3gqzQZgBY/x1whPjkgvVY0BVqDjpzNNx
 j3MZKtc/US9FahC8l1GshYax9bzruiO1Px+kxN42C2a1/a+ouciLZeZnhmF2d8Bw5iGC
 xGHEM/Ckpg6s+Ke+5L23mVGtpo6oK4lxpyu1pa5lb13+KyC//IEb2wPslWSJqwYl+dGl
 Nm7v4JkMZtyBXR77T5irKfNr2OF3ggjQ0MKfVlaLQBtryz27tDcgO9WmDTqiMD8zzwro
 ETyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697084023; x=1697688823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=atO5nwZZQlIy61ye8XKDsNGXZMxK/7JkrrKgc8s8+OQ=;
 b=opD+frU8M/IYPssp8RtDQvH+60AWV8Z/qzeVld11+YKU+ogijC3fqEgr8wNE2f/T2S
 cMaVwTQopYe4YPTozlw9G1sPQ8dxshxSVgVLtQwLNO7U81s17r13YIQl/wButHER9u85
 p6UlubkWFlYbnXmVm63/2XOLjMi8c3xQAHCWcUoE6jWQLxeZS4ZCUyZFxVapuX6dsIKT
 pEG38vGvvQX7fi9SEfqBJJPpFhXgoJDwpnFmR6DLpR27SBpDb67Zn7gtM+9aw22WZK9s
 frvk3HNlUfcL/eFgw9+rLHpPuu3r4TWRtu0VxY/ACEqNVFSfuE/aIV4MDBd3u5d49GbP
 NdhQ==
X-Gm-Message-State: AOJu0Yx4qE6ouHl4s0c41mBvuG7BWXUw86/01vx7s3/HhollwDAivn1x
 ylJh1PW1mhWfFO0AJ+1iFbld7o/l+yIbXA==
X-Google-Smtp-Source: AGHT+IGZWHyeWzs2NOLGHx3QrDZvVCFsIB6Zh0NBgWGamfSf/f9J99uNygK69CPGOCWNxjhGEx168g==
X-Received: by 2002:a05:6a20:7485:b0:15e:e0fd:98e7 with SMTP id
 p5-20020a056a20748500b0015ee0fd98e7mr27408289pzd.20.1697084023222; 
 Wed, 11 Oct 2023 21:13:43 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:13:42 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 46/54] hw/misc/sifive_test.c: replace exit calls with proper
 shutdown
Date: Thu, 12 Oct 2023 14:10:43 +1000
Message-ID: <20231012041051.2572507-47-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52b.google.com
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
Message-ID: <20231003071427.188697-4-chigot@adacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/misc/sifive_test.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/misc/sifive_test.c b/hw/misc/sifive_test.c
index 56df45bfe5..ad688079c4 100644
--- a/hw/misc/sifive_test.c
+++ b/hw/misc/sifive_test.c
@@ -25,6 +25,7 @@
 #include "qemu/module.h"
 #include "sysemu/runstate.h"
 #include "hw/misc/sifive_test.h"
+#include "sysemu/sysemu.h"
 
 static uint64_t sifive_test_read(void *opaque, hwaddr addr, unsigned int size)
 {
@@ -39,9 +40,13 @@ static void sifive_test_write(void *opaque, hwaddr addr,
         int code = (val64 >> 16) & 0xffff;
         switch (status) {
         case FINISHER_FAIL:
-            exit(code);
+            qemu_system_shutdown_request_with_code(
+                SHUTDOWN_CAUSE_GUEST_PANIC, code);
+            return;
         case FINISHER_PASS:
-            exit(0);
+            qemu_system_shutdown_request_with_code(
+                SHUTDOWN_CAUSE_GUEST_SHUTDOWN, code);
+            return;
         case FINISHER_RESET:
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             return;
-- 
2.41.0


