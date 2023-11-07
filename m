Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5257E32F6
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:32:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0BrE-0002ab-C3; Mon, 06 Nov 2023 21:30:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Br6-0002Zp-W3
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:17 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Br5-0002PZ-Dt
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:16 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cc2f17ab26so37340905ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324214; x=1699929014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p6yQaWGRnUWFyyDZIYz2GzCBbP3OQCY5cDmIUuxmHvo=;
 b=ZJ4VnJRhjEH9OReWuK5RLwbny3xK/Nu47/U7tVlmW3pOLXVy6xzIzNfCh4GaZjH8Uu
 Lgm3soEv0l5Jltwq0xVkglPjT7rfAyR1wR43Yyd2T00Hk+LgOFQrxSlnQ5FrjvKZXn6+
 JXS1GebSgNdjH+U14EowEJ8jzBjtxeXtjaZvevIzFQdEX37gfbEGHtNuRdu3ceGhMfXh
 q233pENTdNS8LDj2Zm9huCQ/XmGdo8M6UN/cz8pyMiD7Cj6PiCPvRUBlwDNhvL8Ir1RL
 TBT1Qn/WGSWzABZUa7e4DGaBf2VAVsRhvO604gBqIGUASXbhvgDHjrS7IBAtOFy2AQTo
 Bfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324214; x=1699929014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p6yQaWGRnUWFyyDZIYz2GzCBbP3OQCY5cDmIUuxmHvo=;
 b=ZyjVfMAP/pR710+1yyIcOURDLDirSzb+Lkf8zabBzwDMn5GOv8320FUJg0wPhkYn4w
 bDH3rYyvuCAbCkcpFwWY1oCLLKGuchokWMcVlxlkHR3SFR9ZqsC33y/4bPwbF1kbOpwN
 meyADEeQl+/miM/P08x1nLfLlv5Qbvw12W/3YcvVTHkPz3XiDFgD61j94HAKErkFZ4sb
 qqNxd6Siqs5XU+CLADKkYwTWjs1076ugLP5xjW4DJ30Y9CnZzOf6bJXv7Gv97OisKz8t
 11uDnI0565feDhvKcgz9I6MY6xiCNSQH3PPY0nq+8OIJjD6DNP4CLmQsZGDwkib/U3eS
 bE8w==
X-Gm-Message-State: AOJu0YyaE2DEGDs9ZO6DlDcvcsMY6EwfBhwSL0ZuXGW2JaISDr5+8fMj
 cNvvw5r66s556/RowcF3fwUn7ac5TF0dXQ==
X-Google-Smtp-Source: AGHT+IEChUILORPz1T9wSbHWZ9ixQZmYH4H9VjyrofQiNbJfBkUmEnl+onnuVTCNjifACjGw9TmWMg==
X-Received: by 2002:a17:902:d502:b0:1cc:6fdb:b640 with SMTP id
 b2-20020a170902d50200b001cc6fdbb640mr21522649plg.56.1699324213770; 
 Mon, 06 Nov 2023 18:30:13 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:30:12 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rajnesh Kanwal <rkanwal@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/49] target/riscv: Without H-mode mask all HS mode inturrupts
 in mie.
Date: Tue,  7 Nov 2023 12:29:01 +1000
Message-ID: <20231107022946.1055027-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231016111736.28721-2-rkanwal@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 30cc21e979..4847b47a98 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1525,7 +1525,7 @@ static RISCVException rmw_mie64(CPURISCVState *env, int csrno,
     env->mie = (env->mie & ~mask) | (new_val & mask);
 
     if (!riscv_has_ext(env, RVH)) {
-        env->mie &= ~((uint64_t)MIP_SGEIP);
+        env->mie &= ~((uint64_t)HS_MODE_INTERRUPTS);
     }
 
     return RISCV_EXCP_NONE;
-- 
2.41.0


