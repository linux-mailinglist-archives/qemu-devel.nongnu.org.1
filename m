Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 574B47D709D
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 17:17:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvfb7-0005hv-L8; Wed, 25 Oct 2023 11:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qvfb2-0005gF-Km
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:15:01 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qvfb0-0003jq-4Q
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:15:00 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6b1e46ca282so5804038b3a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 08:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1698246897; x=1698851697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uhhXgiA9ijhkCgdvzjre6qvwHLpR2uYfFwrcGxeZDYQ=;
 b=jBmRWAaGObUfmYDv2nPYBbK/f4OtSnKNApg1F2VPh7imCMjxE9qf42WAnQSfOqkpE+
 mheFsqlZ2F7yZRUWDqDHSKlCdRa3f7HAHd29AVcFCYufaEpCaeuy085+gQudrqIwraAG
 ZAOtwjMhGyPOHA7P6oQQBhhngNRxUef7rfLlfZvh8PkujOEnGPhAnsKWeqAZRp81/xit
 Mk7yP4ZacBY25eWeQSrmb35JSlDGGmDd+c3gejGFI/KpMinCBjvZy1p+vfHXkAClN4FP
 ZWZgP5L4TWx55kJqvJU0AL5lFKHEY8XpnLIlMZlqMhLVWWUTUMaWGpSsZIwHYwARV00/
 ut/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698246897; x=1698851697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uhhXgiA9ijhkCgdvzjre6qvwHLpR2uYfFwrcGxeZDYQ=;
 b=i0DfqTz1uH9JelYKKQTJeELVA7MwTNZHTfeJplZnRrDxHUvd0YLUoByrBeQgj3IHEn
 BlTV6McrnEkJ/+pMzMo8S8b9TOJRWxP8FDxaekGuInyxRxO71wWMZMw50QyHl9e49nrY
 e1jxVlIqcD3ZnVel1r9ilDVJj9Bl8eFJ8wXmVICGigHdEbp7BKWKDxgKIVqSZdBC53eX
 +nxK4crlaBJotEEd72F/bkiuOh0w+WgY1N8YNeRaFG+MlI6MzHJo3XM9dGhkqaoj/k7n
 BLKgu6BMe+3UqydwFnJZqXcPUXfZpfC0bfZBpnAc8xd0zP5TurDLpDyTlFn+wC5nD93U
 +Z5A==
X-Gm-Message-State: AOJu0Yy0IC/yRKPcaTOU2YnW6kmcn9cIhm0My7yhYYz6rGahLm+T1cd3
 aRWQTVrhab37KQgdNXQWOssSfTan9D5K/K9AtQtKewSVMHYcTbPJZmt2GjJjKNEllVTs/0shnHz
 VcgQ42s49PnNWdGSrd/VbAoxyeqc7TXCVzasLEhcTXdBYj4lfBIl/a8kxyuC7E4FnkkO5AKcxZm
 Um
X-Google-Smtp-Source: AGHT+IHiNV7l5886K5RJyRZEx4y7KbRDZ5rGOL52oOvaLUaI2tL1RGQ9R2mahd0i/u63Orc5IXa8IA==
X-Received: by 2002:a05:6a00:2e97:b0:692:a727:1fdd with SMTP id
 fd23-20020a056a002e9700b00692a7271fddmr18972961pfb.4.1698246896595; 
 Wed, 25 Oct 2023 08:14:56 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 w14-20020a63160e000000b005b8ebef9fa0sm2677807pgl.83.2023.10.25.08.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 08:14:56 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH 12/14] disas/riscv: Add rv_codec_vror_vi for vror.vi
Date: Wed, 25 Oct 2023 23:13:36 +0800
Message-Id: <20231025151341.725477-13-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025151341.725477-1-max.chou@sifive.com>
References: <20231025151341.725477-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x432.google.com
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

Add rv_codec_vror_vi for the vector crypto instruction - vror.vi.
The rotate amount of vror.vi is defined by combining seperated bits.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 disas/riscv.c | 11 +++++++++++
 disas/riscv.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index 8e89e1d1157..6d60033abab 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -4011,6 +4011,12 @@ static uint32_t operand_vzimm10(rv_inst inst)
     return (inst << 34) >> 54;
 }
 
+static uint32_t operand_vzimm6(rv_inst inst)
+{
+    return ((inst << 37) >> 63) << 5 |
+        ((inst << 44) >> 59);
+}
+
 static uint32_t operand_bs(rv_inst inst)
 {
     return (inst << 32) >> 62;
@@ -4393,6 +4399,11 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa)
         dec->imm = operand_vimm(inst);
         dec->vm = operand_vm(inst);
         break;
+    case rv_codec_vror_vi:
+        dec->rd = operand_rd(inst);
+        dec->rs2 = operand_rs2(inst);
+        dec->imm = operand_vzimm6(inst);
+        break;
     case rv_codec_vsetvli:
         dec->rd = operand_rd(inst);
         dec->rs1 = operand_rs1(inst);
diff --git a/disas/riscv.h b/disas/riscv.h
index b242d73b25e..19e5ed2ce63 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -152,6 +152,7 @@ typedef enum {
     rv_codec_v_i,
     rv_codec_vsetvli,
     rv_codec_vsetivli,
+    rv_codec_vror_vi,
     rv_codec_zcb_ext,
     rv_codec_zcb_mul,
     rv_codec_zcb_lb,
-- 
2.34.1


