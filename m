Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D19179A3C3
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:47:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfagT-0003MJ-3B; Mon, 11 Sep 2023 02:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfafy-0002tI-DB
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:45:45 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfafv-00056u-Q1
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:45:38 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3ab244ef065so3152130b6e.0
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414734; x=1695019534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLQpbDK+vhuZxw59pu2RWadiyahlNw5xeOR7KVVdyRM=;
 b=B5qKRI6EMl8XKxsCOnqNSbCMgtXirzNRtn56VbhldD/IHLEseGQoi25ORKI0JgCJ/B
 iZKFqOg8rQavQ0od+SPhVRO3VQTf6arlkQqTGplNdrkVI+nk8gVg/VvkRekpJ/1uq+hm
 nMUoslxdUszYKNB6kkGpIWcWItclPPmKP/pJ9WDvMvaTwP1agb2zEa/5W75KvTNJG9o5
 ypbMThCrq9q5sygkppDdz/IzrURxGpEC2ebdG2M+rGuT0bM6yeWwY0FIow6U1Pw77JnJ
 wgJ07oCmXbEhmVLScmuQbBgYWaianZfhXjRSqZ33upw974cjdyM57UZvqTM3qVGHApza
 MfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414734; x=1695019534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vLQpbDK+vhuZxw59pu2RWadiyahlNw5xeOR7KVVdyRM=;
 b=f6S5gedRsRDxbtje2d9AHjEb4yfe7if2qS6C5E25708z++x2y/z2hgKR0pFtPNAFWr
 Ig/0xdBQ9ApwoaeRwScxUjn0KozPiW5XpRYYAq8yi46nkLUdYaE1yuIYinx9WpVzlHMd
 1JoxXoYO6SyWkqokDwtRSG7fAGCw8eK5c0rarfiqQs/pUd23aLso531IjDLoDkYsB3MM
 bh5igEw5w0AUOshRwg/zngSkF/31Imj4hmCjjg0eIXTZ+8ysSv1vuB5RyQvFFwslIGkI
 2fhprVRWZ/JTsCO/nbhqNMXN4paBb2NoVXSb/KwXSJ8nXlmCnqpSxJMmKD/waPa0Un79
 WxAQ==
X-Gm-Message-State: AOJu0YyClmBAuUEMBdT8pQ6k10RiWlFowvDYO5JKI4S9yXwFZAdtXBch
 +NVvrK0pahbnPUw2vPAapJ6PwcfTus+wog==
X-Google-Smtp-Source: AGHT+IHbftEtcOcKGZBAWN1x6HOJGeyJQqQcOPGZ88Tcl8nRePjbMLFDMN0XG+134UXJAYK4W5Jzsg==
X-Received: by 2002:a05:6870:7995:b0:1d5:b9e1:d363 with SMTP id
 he21-20020a056870799500b001d5b9e1d363mr3045648oab.14.1694414733755; 
 Sun, 10 Sep 2023 23:45:33 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:45:32 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 30/45] target/riscv: check the in-kernel irqchip support
Date: Mon, 11 Sep 2023 16:43:05 +1000
Message-ID: <20230911064320.939791-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x233.google.com
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

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

We check the in-kernel irqchip support when using KVM acceleration.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20230727102439.22554-3-yongxuan.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index dbcf26f27d..2953547cb6 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -926,7 +926,15 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
 int kvm_arch_irqchip_create(KVMState *s)
 {
-    return 0;
+    if (kvm_kernel_irqchip_split()) {
+        error_report("-machine kernel_irqchip=split is not supported on RISC-V.");
+        exit(1);
+    }
+
+    /*
+     * We can create the VAIA using the newer device control API.
+     */
+    return kvm_check_extension(s, KVM_CAP_DEVICE_CTRL);
 }
 
 int kvm_arch_process_async_events(CPUState *cs)
-- 
2.41.0


