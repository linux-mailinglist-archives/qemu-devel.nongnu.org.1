Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F01570C292
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 17:37:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q17We-0007bC-8N; Mon, 22 May 2023 11:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q17WG-0007QU-TE
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:32:21 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q17WD-0001Nb-Bx
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:32:20 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f41d087a84so26344355e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 08:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684769535; x=1687361535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tnpVE0KcY4+JRcfuSFzjf1/8d9/S4c9dHftftoYjEBk=;
 b=wrPfWhfARqAZEI26T8s2j5R4+TGHe7B/jSYVvOJNK4gsHgEG6HV9e2eXDLZsT71Jm3
 ODoxO7HsYFmg+bgZbiPQGBuxMnmsKfOp6fax0jrPepxdlA3f4rVuRrg6ouctiQ2XmZcm
 yLNScv4q91N8KvsU4f8RDA3pS9XYR7JCI4JDMv91dyLmtDkOyD54QigtvAJrz3LdgcIe
 ufPkfT9D2YnIu6/f1TKGetyJ+zImBnwN/heNu6+2RHZXPrWHpLbhBKa5IM9kcWwowD2s
 AN1CzLtixljLrASPCMmelwfMLD9kgWTVcGmaKtR8+ADS7sFGZaE60Gf7YyAujI3qBL5s
 Cyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684769535; x=1687361535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tnpVE0KcY4+JRcfuSFzjf1/8d9/S4c9dHftftoYjEBk=;
 b=NdPDFKTe0COgOfq48DzfVdNR7IJglEt1dGS/f18gvw/clL5LIbpJRfOob0nmmkf9qE
 6CvTzFQzgUBkz/UhXyS6wpTaE2OmgXBvONvUPAFQ+pecGXpuskstgTTtSJftaTyURLPR
 yRDn5AAhlcl67eDbbamG508YJqqx15eExJ3gaj6LIwPWnSXugiq7xUFDZcPDZzqMTV35
 RQVnv3oQYFAulUtnzLk6L4wW3eenRKLdtwx8MKJ6dMHGLB6wv/uPkpQYnxBkILQMJEbt
 WkJzTEW8kPdJW3JJgVTeGjTNSoR7aZ+dsAVZmOUiOr4EauCTmjMNtURbURqs2t4pR5pH
 m8rQ==
X-Gm-Message-State: AC+VfDxP8bN/WPR8tfhOeO91fseDptcXKGaZno9O0lsbCptnen0ZewGI
 G7B5z4njkc92hT7XZDNe9qLIW65nq/ms9V91gh8=
X-Google-Smtp-Source: ACHHUZ5nWLq1Q6uL75RxBlw3CYXHjQj51PfGGGaNKb+Y7t3d/zBETgyzGb17ORcbG6GAY8LoTeALFQ==
X-Received: by 2002:a05:600c:3146:b0:3f4:ed2a:4347 with SMTP id
 h6-20020a05600c314600b003f4ed2a4347mr7854105wmo.16.1684769535492; 
 Mon, 22 May 2023 08:32:15 -0700 (PDT)
Received: from localhost.localdomain ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 h19-20020a05600c28d300b003f427cba193sm11884546wmd.41.2023.05.22.08.32.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 May 2023 08:32:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/12] hw/char/pl011: Remove duplicated PL011_INT_[RT]X
 definitions
Date: Mon, 22 May 2023 17:31:37 +0200
Message-Id: <20230522153144.30610-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230522153144.30610-1-philmd@linaro.org>
References: <20230522153144.30610-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

PL011_INT_TX duplicates INT_TX, and PL011_INT_RX INT_RX.
Follow other register fields definitions from this file,
keep the shorter form.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 274e48003f..93e19b2c40 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -48,9 +48,6 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
     return dev;
 }
 
-#define PL011_INT_TX 0x20
-#define PL011_INT_RX 0x10
-
 /* Flag Register, UARTFR */
 #define PL011_FLAG_TXFE 0x80
 #define PL011_FLAG_RXFF 0x40
@@ -157,7 +154,7 @@ static uint64_t pl011_read(void *opaque, hwaddr offset,
             s->flags |= PL011_FLAG_RXFE;
         }
         if (s->read_count == s->read_trigger - 1)
-            s->int_level &= ~ PL011_INT_RX;
+            s->int_level &= ~ INT_RX;
         trace_pl011_read_fifo(s->read_count);
         s->rsr = c >> 8;
         pl011_update(s);
@@ -262,7 +259,7 @@ static void pl011_write(void *opaque, hwaddr offset,
         /* XXX this blocks entire thread. Rewrite to use
          * qemu_chr_fe_write and background I/O callbacks */
         qemu_chr_fe_write_all(&s->chr, &ch, 1);
-        s->int_level |= PL011_INT_TX;
+        s->int_level |= INT_TX;
         pl011_update(s);
         break;
     case 1: /* UARTRSR/UARTECR */
@@ -350,7 +347,7 @@ static void pl011_put_fifo(void *opaque, uint32_t value)
         s->flags |= PL011_FLAG_RXFF;
     }
     if (s->read_count == s->read_trigger) {
-        s->int_level |= PL011_INT_RX;
+        s->int_level |= INT_RX;
         pl011_update(s);
     }
 }
-- 
2.38.1


