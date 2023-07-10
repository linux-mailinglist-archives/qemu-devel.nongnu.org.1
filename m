Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 388F474D5DD
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:40:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq66-0004aF-5d; Mon, 10 Jul 2023 08:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5s-00043z-Rt
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:20 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5r-0004sM-DB
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:20 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3a36b30aa7bso3022514b6e.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992458; x=1691584458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1HkY9ZFYcS/6Nf90TmL70ifxc6A5Ol9CuGtkqDyObh4=;
 b=H4h4w+n/hjwjP3Dby1J2Oi9rbF1dhRjA32ydDIXMFG9iLoWykryiRISIcQUbzkfuer
 nIRZoEN0BNVh2vy+awWMlOqM6fwp6dG+McWNSrrbWAnb6cKBQhDHFwRA24b+RrduuHiI
 8ESkmEslvEZJF8NPQjDqVE5uWh+ciABl5zhAQsPW6ngI4J35FyNN8Y/7PazIMpZ2mZii
 MMOLRnTeY4w6TvMvoZDod75DHoCbrQTaSOkuC9TLL6+N2kuNlM79lfV0XpVE0BEIy6Ol
 oL7eWzwBFWX4jYzg2bZOUc6oiuz/mDgfGQORukpJSRrw7uo9cJU40tMENUz5+4YFqerD
 qE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992458; x=1691584458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1HkY9ZFYcS/6Nf90TmL70ifxc6A5Ol9CuGtkqDyObh4=;
 b=a6s+eQFJG3e3DDwzThqyFhGsn/JhqPqO7k4u2FewBe/h3/T3A93bYN5qJtfOoB03bo
 e4TFmO/Gkh7V+nehQqx9p5nk7e/Lxo99/H+7clgWCOu7wWOJUVYUVYn5a3ZsHBxJs+yh
 XrJ9m7QNHru083PA2wMuEQhZavFZL91e3lMZ3MOoWsHVtizuvezjvb2Ai+bkN0DgtOxh
 0cMqV3VMe6eWsOeYdLL8imyBiZC1Nsl0k3IlXOtnddU9Jq+robfyWAXOWd4y8wR35seC
 4BO6NbphzJX6uLDJYF+VDMH6aYMZW0zRNjfWIFbTi0kFl3ESMZ+U8cQhcJ2qazZVkS37
 HlkQ==
X-Gm-Message-State: ABy/qLZaSU9oB63+gLBG15pyaATvQeo38DVUWUrhLuec1jE4EkVNmbbd
 smZDHCm8DAXidTTfX0BkELop6guUniE92g==
X-Google-Smtp-Source: APBJJlEmJxqR6gVX2nLrs3MHIluaWRceSqtVPmPs0gndgQd4JqqDJb+c0RgnR0omKBbmUeZnqis/jQ==
X-Received: by 2002:a05:6808:f94:b0:3a2:79ea:d372 with SMTP id
 o20-20020a0568080f9400b003a279ead372mr11512936oiw.52.1688992457898; 
 Mon, 10 Jul 2023 05:34:17 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:34:17 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Lakshmi Bai Raja Subramanian <lakshmi.bai.rajasubramanian@bodhicomputing.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 34/54] hw/riscv: virt: Convert fdt_load_addr to uint64_t
Date: Mon, 10 Jul 2023 22:31:45 +1000
Message-Id: <20230710123205.2441106-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x231.google.com
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

From: Lakshmi Bai Raja Subramanian <lakshmi.bai.rajasubramanian@bodhicomputing.com>

fdt_load_addr was previously declared as uint32_t which doe not match
with the return type of riscv_compute_fdt_addr().

This patch modifies the fdt_load_addr type from a uint32_t to a uint64_t
to match the riscv_compute_fdt_addr() return type.

This fixes calculating the fdt address when DRAM is mapped to higher
64-bit address.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Lakshmi Bai Raja Subramanian <lakshmi.bai.rajasubramanian@bodhicomputing.com>
[ Change by AF:
 - Cleanup commit title and message
]
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <168872495192.6334.3845988291412774261-1@git.sr.ht>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 96b01703a9..2b380eff73 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1245,7 +1245,7 @@ static void virt_machine_done(Notifier *notifier, void *data)
     target_ulong start_addr = memmap[VIRT_DRAM].base;
     target_ulong firmware_end_addr, kernel_start_addr;
     const char *firmware_name = riscv_default_firmware_name(&s->soc[0]);
-    uint32_t fdt_load_addr;
+    uint64_t fdt_load_addr;
     uint64_t kernel_entry = 0;
     BlockBackend *pflash_blk0;
 
-- 
2.40.1


