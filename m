Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9B779A3AD
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:45:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfaeF-0000BG-Pz; Mon, 11 Sep 2023 02:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfaeD-0000Ao-V7
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:43:49 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfaeB-0004R5-62
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:43:49 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1d5c54160a8so230524fac.0
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414625; x=1695019425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vym8XbbEH4MOTDPO5rs9mKsM5VAOMq/9GygQwXQnKYA=;
 b=KC9/kyy9swxVPXMz4b5W4kcSDU4LVxIbnMnr+/kcyl0meUO4R5xk+RmDgBZZX6AzaP
 1YxqtYiaFEP0TmND74H9TwqNczvWw4nlokjrFkEEtIqRL2aafLBv9I47EeKLMrBAHjfe
 d+2CeAZP6ORWp2vYcDzZ5UiWpYPW+dLlGoaCvpW1hd1uf09HZMCvztZCHyrtA+z/Ks9T
 RT4bwMbtd0zCZxfqD8TvwZur+Ahh3Vy7XsBk/deMr9UWO2ruX5UiWneTSShSYexXifhX
 prnYLg7JQHsUTphcEegaa3q9/r/gb39bEDFsMxknAmB+WBRVhBkg5Fjd9z15KopJPOom
 nhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414625; x=1695019425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vym8XbbEH4MOTDPO5rs9mKsM5VAOMq/9GygQwXQnKYA=;
 b=WyTWukWzMOUN92dXwBvKZvmxiOnlRwN9/5N60lZAeLCbQLATBwCFJsMMhseUh36hSq
 yAdh0LiOrdSxhVbV5M+XpNt58vHqwYfrjQ+z21Fo8Vb5qHSt8X+hJe2rXzhizJAH8I8r
 Eb7G3lpWc/dCXyItCisxSFewcwTpjpYhDBcK8HivOo+mMIEIQVASoWIIUd6T8eYIgX7/
 /6ulTg+syP8X0s1BR0jtbXKeTU1PUDhnOXivv9jaOuRKh6lwY6FBGLONKCoNaeBoIi7x
 fifnLFKcpjOnssnA6L7/ypR5BhGXSjfoL16OQTqza0lkjrvSiJhEtwF0LhpV9iVe1lWy
 Vbkg==
X-Gm-Message-State: AOJu0Yy1P7W/l3oYo9xSu7Rb5wy8K1NGwO7AwrAr/yQ9UMZ1e0i17t7r
 dSZncnLUVgZBrDVifvbRWnvDPI/bhVhTzg==
X-Google-Smtp-Source: AGHT+IGLTw3M64I1rtN6GBwEA4GPPH5DxBv7UdRjuDpleizu6L2jaVTRRjJERvzkGkUTZwteoynj+A==
X-Received: by 2002:a05:6870:b014:b0:196:45b7:9385 with SMTP id
 y20-20020a056870b01400b0019645b79385mr10440514oae.27.1694414625541; 
 Sun, 10 Sep 2023 23:43:45 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:43:44 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng@tinylab.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 02/45] hw/char/riscv_htif: Fix printing of console
 characters on big endian hosts
Date: Mon, 11 Sep 2023 16:42:37 +1000
Message-ID: <20230911064320.939791-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=alistair23@gmail.com; helo=mail-oa1-x29.google.com
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


