Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2252772F1C3
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:26:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FD8-000693-56; Tue, 13 Jun 2023 21:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FCw-0005rU-Qs
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:59 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FCv-0004h6-9r
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:58 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-54fb3c168fcso1186758a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705716; x=1689297716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9xzdyHnF2lMoYjSUlhbbzm/UQDV/RgdBRzn1doXxkDw=;
 b=hg1mXpbaAEfFLVdhIX/Dz00fzbE3Z9Pa7G313NMxDMyhdNh3KdnciUeZaUxZmPbwat
 KEVHObdUL8RinMC7eM43pjW5yrEbTvF0iCglW4q34IWSDl+1JLQjxzb7VwN8knACfQGr
 olWu8fK4RfcK0cqMxje4MF8LOgSsgYq7NwzBDfaWl7Dbt1xB/e8UuoNFv//+CfWzZS5t
 +p10f4/h10UWP566REzO7w7DExKXclYY6GbqgoKfbK3ta+6xVQiyhKPCcdbYsu4yCS8I
 AY5AXGmlqlDACEvbw00GhqsbuI3QO40+GSTYZvnbfe9TNl3u+PQwrIJ5dAlB+UktC++L
 Dnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705716; x=1689297716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9xzdyHnF2lMoYjSUlhbbzm/UQDV/RgdBRzn1doXxkDw=;
 b=aHUzamF9Vzq1laaVV04E2c9GaHnpypBPbE2WKLpDWYvaMQ22LkzJLts0oBghtcgtey
 IOOS1RMFXOYNmkD26PU5mu9wIPwIDrblTWR4Wdp9YkeWSXKF6FSy4yx5Xotin3YWTG9r
 bGu9CY09VevXPvTbyF33H6FnDgjXONfbUgXQ+KoFAe7k2BQzPynbYg9fdL4jKIBTY06b
 nHQMToug4nGgPB6gRgIeX0xE9r51T/GkPbqfyo7eCjBjStKxDuiegIsAY6xb63//j9Wx
 bSwPZTzvDaIT5z13BJtJBgE5tIKu33QbJWAHun7zUH3CW9MhKLVu8sBBzGHFTf2N+rhU
 nDFg==
X-Gm-Message-State: AC+VfDyMo1Ox41tkDZMTassuiHPSY2YpvgJCWPb1Njkw+OFY6fKwaQCQ
 EIvDotNMHOqKuclP6PrvW2QHsa9e6YR43g==
X-Google-Smtp-Source: ACHHUZ4tN9W7kfYSR4JFKW/ELJlcTkPMsVeO1/olrCHYKgMqP5wYsMk/ms3RbnwgVqRxcS8PO5HFJg==
X-Received: by 2002:a05:6a20:4311:b0:111:1bd6:2723 with SMTP id
 h17-20020a056a20431100b001111bd62723mr588564pzk.3.1686705715813; 
 Tue, 13 Jun 2023 18:21:55 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:21:55 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 20/60] target/riscv: Flush TLB when MMWP or MML bits are changed
Date: Wed, 14 Jun 2023 11:19:37 +1000
Message-Id: <20230614012017.3100663-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52e.google.com
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

From: Weiwei Li <liweiwei@iscas.ac.cn>

MMWP and MML bits may affect the allowed privs of PMP entries and the
default privs, both of which may change the allowed privs of exsited
TLB entries. So we need flush TLB when they are changed.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230517091519.34439-8-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 2403039133..4d62dfc732 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -578,6 +578,9 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
     if (riscv_cpu_cfg(env)->epmp) {
         /* Sticky bits */
         val |= (env->mseccfg & (MSECCFG_MMWP | MSECCFG_MML));
+        if ((val ^ env->mseccfg) & (MSECCFG_MMWP | MSECCFG_MML)) {
+            tlb_flush(env_cpu(env));
+        }
     } else {
         val &= ~(MSECCFG_MMWP | MSECCFG_MML | MSECCFG_RLB);
     }
-- 
2.40.1


