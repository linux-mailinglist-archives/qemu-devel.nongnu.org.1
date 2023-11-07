Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC057E32F1
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:31:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0BrL-0002bp-Cn; Mon, 06 Nov 2023 21:30:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BrE-0002aw-V1
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:25 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BrC-0002QC-Cz
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:24 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5a9bf4fbd3fso4046174a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324220; x=1699929020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xOdH92NkZAH1ojRVZxJOAZiCj1qqpGj42yNB5LR2Flg=;
 b=JmU4i/qMhCG7ziiRvaxgxo11Mvlzz2iRSFwI6JyJ5FKq7JS4BfusNpKwvILTBORJur
 8oVylFrarvmoP3qo1XJxO074MCIX63krJRSrEewOxQDim+BVZRt+JC01MYDV62VqbnHD
 QswVKc63bORi+sCEcAxTkYojBt7xLDi+efs40gNmVUavI+mdm6KMTapYofPdqwlwqIgP
 Soshb7mIFDYpxamzdU5HtOYMzyU2rymS6EsY7HDMp0FpgvL6nt2Ag3ZtAhQxFjhLuYBx
 CcTH65vtnzRkXvq8HSMnCDuXV2S8LpXVT+srb0OZ2kUaCri7faZGophWb3XrsvvRhViz
 BjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324220; x=1699929020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xOdH92NkZAH1ojRVZxJOAZiCj1qqpGj42yNB5LR2Flg=;
 b=G3Bk7WIeV3ZW2gK53wOXMscJXLnmjKHAKRpDNS7Vgkbs6ujZboyEeG3lj0k5RAdgHa
 tm4ZtNov14UF9ZpEx1IUhRlMXdKzNgGb9YhsaACs4WnkerDJcU2GwEc3TeMSbah01o+k
 UAiLJFgwXrPQxTGC/fK/0AYtxHEXayhDgMOL1ggV4Pn/S9uZ32/uyFhp5FPI6RnypKWb
 ECl58qCYqNabt1S9tD55mWms6YyuYOumBzvepk6Vf0XRnmUuE2MAfwHNGzhdsGdNde5p
 7M50grt/Wi6c4FFDk28crLUnffPbjt8m1wGsXmEW6bOnT3UhJDvyASM9NqlHN4WKuSsj
 NOEw==
X-Gm-Message-State: AOJu0YwKPdwXhyiAGyxXhtKgHA4xran9HdnY6xt7xiwloUwDKG2C6NkK
 643+ml7dDYLs1e4HNj9RKed/2RzQUK6P0g==
X-Google-Smtp-Source: AGHT+IFjdYHeF7W1wcIjypQ6BeGOlGMTVKJZw65cOUsF4qhuHy8fzXKUiCIdUmXj7pFOqjuyvY6tXA==
X-Received: by 2002:a05:6a20:914a:b0:13f:9cee:ff42 with SMTP id
 x10-20020a056a20914a00b0013f9ceeff42mr38577463pzc.41.1699324220084; 
 Mon, 06 Nov 2023 18:30:20 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:30:19 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rajnesh Kanwal <rkanwal@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 07/49] target/riscv: Set VS* bits to one in mideleg when H-Ext
 is enabled
Date: Tue,  7 Nov 2023 12:29:03 +1000
Message-ID: <20231107022946.1055027-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52d.google.com
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

From: Rajnesh Kanwal <rkanwal@rivosinc.com>

With H-Ext supported, VS bits are all hardwired to one in MIDELEG
denoting always delegated interrupts. This is being done in rmw_mideleg
but given mideleg is used in other places when routing interrupts
this change initializes it in riscv_cpu_realize to be on the safe side.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231016111736.28721-4-rkanwal@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 418b040d6d..bbce254ee1 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -618,7 +618,12 @@ static bool tcg_cpu_realize(CPUState *cs, Error **errp)
             cpu->pmu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                           riscv_pmu_timer_cb, cpu);
         }
-     }
+    }
+
+    /* With H-Ext, VSSIP, VSTIP, VSEIP and SGEIP are hardwired to one. */
+    if (riscv_has_ext(env, RVH)) {
+        env->mideleg = MIP_VSSIP | MIP_VSTIP | MIP_VSEIP | MIP_SGEIP;
+    }
 #endif
 
     return true;
-- 
2.41.0


