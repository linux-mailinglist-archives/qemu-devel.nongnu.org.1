Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFD79E1A55
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Dec 2024 12:06:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIQj9-0001hA-TH; Tue, 03 Dec 2024 06:05:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>)
 id 1tIQj2-0001gd-Ub; Tue, 03 Dec 2024 06:05:53 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>)
 id 1tIQj0-0005yT-U2; Tue, 03 Dec 2024 06:05:52 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385dece873cso2066906f8f.0; 
 Tue, 03 Dec 2024 03:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733223948; x=1733828748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gHdmag75iaWZnkfBuSd+viy7kreS7aX/TkGtbBNIJSA=;
 b=HoIgsHmQOVWYl6LpGticfhuaau7En4dAA8blfPCUb2RYLiwMCS7hhfjIxgubhyfnav
 fNamVFry/YXcApr5EM7K0uamjx0mrHKuKqU7J9vRrYBbBd+uDtXW/2Q4EwL+VN/dRQEc
 ANRuneWJ7TcDJmYGmvWQy7Qs1497H2d3kfEdjYBydFV0q9+118RtS2FF/T0607wEGV9a
 7MTo1leSw6vo7jYQCjBhDZqCUQzhiH5tflX5PnZpIWcZNptL1uffh4kVAzoq5W0e55iJ
 2XdtI9QlIjFKt+frBjTzZG+94d3X9/NZZ0UEb4pjIKhpf45au3WFlHdQRb3rwkLINvq9
 DWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733223948; x=1733828748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gHdmag75iaWZnkfBuSd+viy7kreS7aX/TkGtbBNIJSA=;
 b=SQOP/t3SmcWpUt1oRjFZh+fDmXqhx2eqLQKL2qWLG4RUf4Js9dY8BgehZmFb5rMXSA
 9P97XxQTqkZQN0OMBu7pS3BlICmYjfOgdvgkWzZVEBeTXQzbw/zCVzhusV2Hov9RY/I5
 urqF0ifL48ap+Ocsn/FFDIgpt3tSXJhUC0hNHruJgWFV7tPGXC77uea5H6bZAgH85QD/
 r1hQsmqYy99d7BQeSjC6ow7wTpYZrjkilFgp8idJcMa2G5hEqzXWleIkJlHbojuHCJhK
 T+/1ZPI9gOMMlkzfuL/jJHnIN3hjs5qZhvF9ccSloA7D3S1m+0kyOkmf9y0DRW11Rzvl
 t1pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYq1/JAiapWrMa7oRNRFx3qi4hGsbQEi5CVT6l1qT6dbcTzqO4cPctqqkI94F/6Ab2jIM8aQzr+rqjMg==@nongnu.org
X-Gm-Message-State: AOJu0YwY+nxEkl+YIr9nOzHAAQ71dh3g2bfR1Yj+S9cFNHBHrTEW+6up
 w2ImhBFEf6Fc/9FexFaBLXRgJW2CSvvpJZsjrNX1606nu+4yiLHC2jqkEA==
X-Gm-Gg: ASbGncvJmTnRUzqkI9fYfT2C9wvCvtwSEuKzs9lAt2LOJ+DIYo4i9H546XJwc/RejbE
 jEAW8m7AjzD3qkSbWuPbJcoU/FmzUrrfA8tKHqPpirGL6gXgbc2GT2khlFlAWyfFk8fdk9Jb5r7
 p8oPccodSixLW52UBeGJEX6V0h30GsObhihVknqJS5/IQ6GDOTDdYiiXzs8p7ftyCgNeUH57Ddq
 l4HYMT6ToeAQVE4VKm2VJs1qiRoVbVc3SoDfZQDdjEYYZSET2ryaIXBqQNZBQT7bina0BQC0L/1
 MQUI4WnBqXSukg==
X-Google-Smtp-Source: AGHT+IE1Xodmw1U0bXJD7a49TyPA4XwARYukb6gaESWAhI8L2A78gL3N9Tpi4X46HcQmI+7GalKNyA==
X-Received: by 2002:a05:6000:1445:b0:385:f060:b7fc with SMTP id
 ffacd0b85a97d-385fd3e6cc1mr1295102f8f.25.1733223948238; 
 Tue, 03 Dec 2024 03:05:48 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0d9bc11sm190052535e9.4.2024.12.03.03.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 03:05:47 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>, qemu-stable@nongnu.org,
 Stafford Horne <shorne@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jia Liu <proljc@gmail.com>
Subject: [PATCH v3 1/2] hw/openrisc/openrisc_sim: keep serial@90000000 as
 default
Date: Tue,  3 Dec 2024 11:05:35 +0000
Message-ID: <20241203110536.402131-2-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241203110536.402131-1-shorne@gmail.com>
References: <20241203110536.402131-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=shorne@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

We used to only have a single UART on the platform and it was located at
address 0x90000000. When the number of UARTs was increased to 4, the
first UART remained at it's location, but instead of being the first one
to be registered, it became the last.

This caused QEMU to pick 0x90000300 as the default UART, which broke
software that hardcoded the address of 0x90000000 and expected it's
output to be visible when the user configured only a single console.

This caused regressions[1] in the barebox test suite when updating to a
newer QEMU. As there seems to be no good reason to register the UARTs in
inverse order, let's register them by ascending address, so existing
software can remain oblivious to the additional UART ports.

Changing the order of uart registration alone breaks Linux which
was choosing the UART at 0x90000300 as the default for ttyS0.  To fix
Linux we fix three things in the device tree:

 1. Define stdout-path only one time for the first registered UART
    instead of incorrectly defining for each UART.
 2. Change the UART alias name from 'uart0' to 'serial0' as almost all
    Linux tty drivers look for an alias starting with "serial".
 3. Add the UART nodes so they appear in the final DTB in the
    order starting with the lowest address and working upwards.

In summary these changes mean that the QEMU default UART (serial_hd(0))
is now setup where:

 * serial_hd(0) is the lowest-address UART
 * serial_hd(0) is listed first in the DTB
 * serial_hd(0) is the /chosen/stdout-path one
 * the /aliases/serial0 alias points at serial_hd(0)

[1]: https://lore.barebox.org/barebox/707e7c50-aad1-4459-8796-0cc54bab32e2@pengutronix.de/T/#m5da26e8a799033301489a938b5d5667b81cef6ad

Fixes: 777784bda468 ("hw/openrisc: support 4 serial ports in or1ksim")
Cc: qemu-stable@nongnu.org
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
[stafford: Change to serial0 alias and update change message, reverse
 uart registration order]
Signed-off-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
Since v2:
 - Fruther updates of commit message indicating the changes to the DTB
   registation order.
Since v1:
 - Fix commit message and reverse registration order as pointed out by Peter.

 hw/openrisc/openrisc_sim.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 9fb63515ef..42f002985b 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -250,7 +250,7 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
     void *fdt = state->fdt;
     char *nodename;
     qemu_irq serial_irq;
-    char alias[sizeof("uart0")];
+    char alias[sizeof("serial0")];
     int i;
 
     if (num_cpus > 1) {
@@ -265,7 +265,7 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
         serial_irq = get_cpu_irq(cpus, 0, irq_pin);
     }
     serial_mm_init(get_system_memory(), base, 0, serial_irq, 115200,
-                   serial_hd(OR1KSIM_UART_COUNT - uart_idx - 1),
+                   serial_hd(uart_idx),
                    DEVICE_NATIVE_ENDIAN);
 
     /* Add device tree node for serial. */
@@ -277,10 +277,13 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
     qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency", OR1KSIM_CLK_MHZ);
     qemu_fdt_setprop(fdt, nodename, "big-endian", NULL, 0);
 
-    /* The /chosen node is created during fdt creation. */
-    qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
-    snprintf(alias, sizeof(alias), "uart%d", uart_idx);
+    if (uart_idx == 0) {
+        /* The /chosen node is created during fdt creation. */
+        qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
+    }
+    snprintf(alias, sizeof(alias), "serial%d", uart_idx);
     qemu_fdt_setprop_string(fdt, "/aliases", alias, nodename);
+
     g_free(nodename);
 }
 
@@ -326,11 +329,22 @@ static void openrisc_sim_init(MachineState *machine)
                                 smp_cpus, cpus, OR1KSIM_OMPIC_IRQ);
     }
 
-    for (n = 0; n < OR1KSIM_UART_COUNT; ++n)
+    /*
+     * We create the UART nodes starting with the highest address and
+     * working downwards, because in QEMU the DTB nodes end up in the
+     * DTB in reverse order of creation. Correctly-written guest software
+     * will not care about the node order (it will look at stdout-path
+     * or the alias nodes), but for the benefit of guest software which
+     * just looks for the first UART node in the DTB, make sure the
+     * lowest-address UART (which is QEMU's first serial port) appears
+     * first in the DTB.
+     */
+    for (n = OR1KSIM_UART_COUNT - 1; n >= 0; n--) {
         openrisc_sim_serial_init(state, or1ksim_memmap[OR1KSIM_UART].base +
                                         or1ksim_memmap[OR1KSIM_UART].size * n,
                                  or1ksim_memmap[OR1KSIM_UART].size,
                                  smp_cpus, cpus, OR1KSIM_UART_IRQ, n);
+    }
 
     load_addr = openrisc_load_kernel(ram_size, kernel_filename,
                                      &boot_info.bootstrap_pc);
-- 
2.47.0


