Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCF672F1F6
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:33:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FD7-000607-LX; Tue, 13 Jun 2023 21:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FCt-0005l2-IN
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:57 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FCs-0004gm-0X
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:55 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-65292f79456so4685742b3a.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705711; x=1689297711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ogtpRg+KE0Wdg1+dUNR1f+IijVtouEWOYgKuGIRiW4g=;
 b=Xvafxc5mdfUvjqDknEbAbo79N3gMjDdv6a9Dlv+1IVwOSezaNGAkTAf/E2vxTNp8+Z
 JNF0PK/k6aENFmvOcdF/uwlzLpRFvAJQaUWHvEOFV9Sa+xDxMrMx6TF3TO109lL1SeOG
 2G1G4VBgtxNA2EJ3lhxydgs/a+6s48q5rp5b+Wzsi18jia7R+2H4hiU5rv2Cmfzwznpe
 eRbEb85UL7+v6nPbxAMyX3b3um7YwarcaQTt8pduQxYIxQJkGq/OSuhy27kax3DxJVEp
 /JsHrQtsovJHgrwHjfrE9XB0uEUh7p643pMK9NROzLUrXA+wqW3l7xaRATnAZjXDoA83
 nHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705711; x=1689297711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ogtpRg+KE0Wdg1+dUNR1f+IijVtouEWOYgKuGIRiW4g=;
 b=CGPV5gHtHaRCEtB0tACIITw4maZ1EwHiGiBEm7PaYaRUA495YGsXxdJ8308cQlIbhm
 FpXKVZBnf133ebrq6hmFxxNZ9uojRCMv7rxPZaTeETdiLCU78ssZG9A+hjSM0zBPcxoV
 0JUNW+lk8wiGWqE8UHlx16wC3dCWmBMHq7lcxPXu1PoApBLPsAD9DAAuI1r8+GOyGi16
 7nJI2qQT6teGuCWwNgfnrXCs8yFQ2eR+omgnFyNvPlXQILAT4K9bCuR6PKQ9/CiIYfak
 SQYAdLrRUGjoRzaVI3s+o9ed/VJl95pEG8+KeTLzLoi3Ee0NPE3qjzmwZ6oZZvyj2ZFI
 sJNQ==
X-Gm-Message-State: AC+VfDylDaHV5q60xTvMAqmyfnJbAv1FFaO9H2HQgYNrrAEOJgWEVOHy
 RmafBDZ2A5QuEy+K7OKYg6gO+1hRyWTCUw==
X-Google-Smtp-Source: ACHHUZ4/3HjBzExNmBu/YLap2Fgt4mGGkpFHijzbwiT+nut+Oyuk8NgobsPemkQWapFXUrUE5E9Uig==
X-Received: by 2002:a05:6a00:2ea7:b0:653:a9ac:44c with SMTP id
 fd39-20020a056a002ea700b00653a9ac044cmr538013pfb.11.1686705711201; 
 Tue, 13 Jun 2023 18:21:51 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:21:50 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 19/60] target/riscv: Remove unused paramters in
 pmp_hart_has_privs_default()
Date: Wed, 14 Jun 2023 11:19:36 +1000
Message-Id: <20230614012017.3100663-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x435.google.com
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

The addr and size parameters in pmp_hart_has_privs_default() are unused.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230517091519.34439-7-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 9a6e04cda0..2403039133 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -236,8 +236,7 @@ static int pmp_is_in_range(CPURISCVState *env, int pmp_index,
 /*
  * Check if the address has required RWX privs when no PMP entry is matched.
  */
-static bool pmp_hart_has_privs_default(CPURISCVState *env, target_ulong addr,
-                                       target_ulong size, pmp_priv_t privs,
+static bool pmp_hart_has_privs_default(CPURISCVState *env, pmp_priv_t privs,
                                        pmp_priv_t *allowed_privs,
                                        target_ulong mode)
 {
@@ -309,8 +308,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
 
     /* Short cut if no rules */
     if (0 == pmp_get_num_rules(env)) {
-        return pmp_hart_has_privs_default(env, addr, size, privs,
-                                          allowed_privs, mode);
+        return pmp_hart_has_privs_default(env, privs, allowed_privs, mode);
     }
 
     if (size == 0) {
@@ -454,8 +452,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
 
     /* No rule matched */
     if (!ret) {
-        ret = pmp_hart_has_privs_default(env, addr, size, privs,
-                                         allowed_privs, mode);
+        ret = pmp_hart_has_privs_default(env, privs, allowed_privs, mode);
     }
 
     return ret;
-- 
2.40.1


