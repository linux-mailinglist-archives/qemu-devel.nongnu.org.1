Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E32072F1C9
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:27:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FE9-00027m-14; Tue, 13 Jun 2023 21:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDn-0001ps-Ny
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:52 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDl-0004pC-VO
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:51 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6563ccf5151so6537223b3a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705768; x=1689297768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=klboDe57Mx7EkkqekpsoOJNMG3gdhXe6yAQHYI9CspA=;
 b=XLSiEDN9+EHaoqXs015GMARqhNSHi/f7ItyV5tVmW3v7eOODnz85ZGvHsIzU0/UbuS
 gffiyR93CNO85qJijk2CNYiIdJ7jA/ctOsFYun2D+h1lZxwFJTlm226MvS+V4ay+/OS2
 Nq5ladp0ukA0o9jwgQ5nl4mk0+KT2keNDvSbTDfh5EUeJBtI5yFeR6cTt4u2qumHp/hb
 xAoWM5GAgiuWftWI1RT5q1RCLmQUT/ZVxKvkrzys2I4JkbMZeWf2Q0IUkMvSr3+Wazq1
 BdsEt3jjaiJV6G3WW4/9bQnZ/ag4onjUjQ0Hakesa1u8pMi3cN4waYFDUSJ/ETAgQTNL
 jmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705768; x=1689297768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=klboDe57Mx7EkkqekpsoOJNMG3gdhXe6yAQHYI9CspA=;
 b=NB2hm1sTac4mjTXeTOxUgHIt7wmUWO4TicRtZjaxNnOaTbVYUKVo3E+kMRtfe38zNQ
 k5G5gFBHH9CtNQ+j5GDyZhjOkOV7QvbDz8nk3SDR7M8WnB3PGXWEvOv7KECaokIM9W6n
 DYTNHFTk4h0bhAOsfpbaYQmj69q1w5IIRvqenw9A8cSrxEonwb+1xdVWIZ3Se/SHDBil
 vyvImnDdkhluJi0lmnEODBo6vndJmvkWXDW6fwAhT9PZoal0YVNlWHow2ZU0fzgB6+Eg
 Crqd7QVgbQYA4Z54XrZ791GekZgoC0tBMDeT9a9o7OVV0XRXl+OsChiQwpCK3x5gjKmu
 0TqA==
X-Gm-Message-State: AC+VfDyYSwho5KO6KndXLDhAEdTa4+1FUF/7RFE8xKgfca8poN9eBPkl
 CvodreLo3Mztot5o1P7WLoJsqKCUR6NQ5A==
X-Google-Smtp-Source: ACHHUZ53xXL2f/eaOP8U8eq8HkUBhS7e15VC12SG08NbbE0qwlEGPD4dIPZduuL8GQh54JjpojSolA==
X-Received: by 2002:a05:6a20:8f29:b0:10c:5324:dba with SMTP id
 b41-20020a056a208f2900b0010c53240dbamr470652pzk.28.1686705768441; 
 Tue, 13 Jun 2023 18:22:48 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:22:47 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 34/60] target/riscv: smstateen check for fcsr
Date: Wed, 14 Jun 2023 11:19:51 +1000
Message-Id: <20230614012017.3100663-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
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

From: Mayuresh Chitale <mchitale@ventanamicro.com>

Implement the s/h/mstateen.fcsr bit as defined in the smstateen spec
and check for it when accessing the fcsr register and its fields.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230518175058.2772506-2-mchitale@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ad73691878..58499b5afc 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -82,6 +82,10 @@ static RISCVException fs(CPURISCVState *env, int csrno)
         !riscv_cpu_cfg(env)->ext_zfinx) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
+
+    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
+        return smstateen_acc_ok(env, 0, SMSTATEEN0_FCSR);
+    }
 #endif
     return RISCV_EXCP_NONE;
 }
@@ -2104,6 +2108,9 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
                                       target_ulong new_val)
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
+    if (!riscv_has_ext(env, RVF)) {
+        wr_mask |= SMSTATEEN0_FCSR;
+    }
 
     return write_mstateen(env, csrno, wr_mask, new_val);
 }
@@ -2177,6 +2184,10 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
+    if (!riscv_has_ext(env, RVF)) {
+        wr_mask |= SMSTATEEN0_FCSR;
+    }
+
     return write_hstateen(env, csrno, wr_mask, new_val);
 }
 
@@ -2263,6 +2274,10 @@ static RISCVException write_sstateen0(CPURISCVState *env, int csrno,
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
+    if (!riscv_has_ext(env, RVF)) {
+        wr_mask |= SMSTATEEN0_FCSR;
+    }
+
     return write_sstateen(env, csrno, wr_mask, new_val);
 }
 
-- 
2.40.1


