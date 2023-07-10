Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D62F074D5D6
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:39:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq6n-00008x-6Q; Mon, 10 Jul 2023 08:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq6h-0008IO-Du
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:35:11 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq6e-0005GG-1j
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:35:11 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-668711086f4so2803045b3a.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992505; x=1691584505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c1FsdHQ3+Eg/1cDR8TaBdFMP++lgj3lEIxG3SBowRyo=;
 b=k6OwLkkkkdG+zNgE/xKanc6oERZp0xhka/MRxZqRFU0BL336XFgXqCWMjOm6UbuJow
 vKgbnzBpJER4LNefWI7J9KqlrsL4J4Ts0C5dvQmEkZPO87bnHxQg0DLrFxN7LTKJXVaT
 s84Tk98W3PRo9Hf9gdJThUhVOp2Yv7Cz67IGzZiBsg6IizrepDY4CDhLTV/iTmEHhEPv
 vTQ6Z+kWtrfKVTGGFh1+Iotn7mUXLc+BivfQZmqdioXZFf7Y+AMbybex31Xo7irFR8yE
 rhKJWBzz03/YyUfWU8X6e87GMYODxxXLeWlArEevHSeLnK4fePYG+YBXUlMlxzUDmTHZ
 DIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992505; x=1691584505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c1FsdHQ3+Eg/1cDR8TaBdFMP++lgj3lEIxG3SBowRyo=;
 b=gZKsw9xca7ZB9e8SbtmxK117DL8skLj78cY5wKz/Xwh5hdJeeRLzGUtwbdSQurE9up
 ClcxAgDCdALmwdx0w53ocaAtViqm1rF6AVOxTFNdz70ca+XiSPh3QlzpdXR72sR5uVWx
 9dnFD2rfxsOMst2ENBQmcAM77taDL0NctLOEAyANmNJXTRCerzIdNbNIdLoNcrVD7dOR
 BtDw+sXvLKSe+VRmHOfhZ60SjeukyxDsOUo//tydmQNyvAaajR96/AXDKgMDtba0G41z
 YCOkiR9G6qbwRb16qc1VG57glRymeXkItbQ+5dgkN8LlBo6IlVK29wfH+uSl6NBO33nr
 4h9A==
X-Gm-Message-State: ABy/qLYQDN1WhTVJIUq2h1Ye4b1K/x6hJ6ltk1oIWFIAwWQs/6icgrTB
 IJhiZfk/C53MvFq4xt7Ffdf2WhlnWXBfqQ==
X-Google-Smtp-Source: APBJJlEO5aNfGwU/YZc6CGiQnRiz+YIWekUfxRFVx9PCaBjbQA8k/An/JlJB7XucailK6QBSbIu8oQ==
X-Received: by 2002:a05:6a20:9383:b0:12e:c5fb:757 with SMTP id
 x3-20020a056a20938300b0012ec5fb0757mr21371654pzh.5.1688992505361; 
 Mon, 10 Jul 2023 05:35:05 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:35:04 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 48/54] target/riscv/cpu.c: add satp_mode properties earlier
Date: Mon, 10 Jul 2023 22:31:59 +1000
Message-Id: <20230710123205.2441106-49-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

riscv_cpu_add_user_properties() ended up with an excess of "#ifndef
CONFIG_USER_ONLY" blocks after changes that added KVM properties
handling.

KVM specific properties are required to be created earlier than their
TCG counterparts, but the remaining props can be created at any order.
Move riscv_add_satp_mode_properties() to the start of the function,
inside the !CONFIG_USER_ONLY block already present there, to remove the
last ifndef block.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230706101738.460804-16-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 31e591a938..deb3c0f035 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1852,6 +1852,8 @@ static void riscv_cpu_add_user_properties(Object *obj)
     DeviceState *dev = DEVICE(obj);
 
 #ifndef CONFIG_USER_ONLY
+    riscv_add_satp_mode_properties(obj);
+
     if (kvm_enabled()) {
         kvm_riscv_init_user_properties(obj);
     }
@@ -1870,10 +1872,6 @@ static void riscv_cpu_add_user_properties(Object *obj)
 #endif
         qdev_property_add_static(dev, prop);
     }
-
-#ifndef CONFIG_USER_ONLY
-    riscv_add_satp_mode_properties(obj);
-#endif
 }
 
 static Property riscv_cpu_properties[] = {
-- 
2.40.1


