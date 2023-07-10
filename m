Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6162D74D5BD
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:37:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq4O-0008Vf-IQ; Mon, 10 Jul 2023 08:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4M-0008Kx-0v
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:32:46 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4B-0002mT-SU
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:32:45 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6b708b97418so3984452a34.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992353; x=1691584353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r7cFLS+0izr/IaJRspeY3sKlm9afvExWy2NMKv+pESc=;
 b=m+G7cxein4OA4Fp2BWdthmEOO2q3J137YScJRqCOgYpOuqx8ZRO1meFGqfjjt/2hCi
 ty3UxqTHY4x2PGoRa6gYzS8I0nnPGoUDf3yr3g/3QDXoOWRTEDsEtebKyr4x8duzY3XK
 DX+58irHn8NxT8N827W9mEHjBuAa8NXzPteAYVl/Y4K1qIpJapLjKx4DDt3GtNa5UsQj
 ZblihMmrzsBn5PUCqFFIQP69cDvNZw8ycs32kUJBwWGSCFfotHy4dZc3//LD7ev5BpEP
 jlLfmnVjURrw27kNdEo8VjRJNBHzR/TeM9RagfhU/THlZc6XaNP+hBAaSBUNOC+awUjm
 bKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992353; x=1691584353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r7cFLS+0izr/IaJRspeY3sKlm9afvExWy2NMKv+pESc=;
 b=VSuXgDNBR3cHf2+6ggY30rA95yi3Z0lBuzSiZTpr4OuS5tvBwalAPJqAE2EDH/OzMj
 IHMEqQY5u+3CD3S2Lnjelut7J+UMMkCkbYuXdTtFB4z8cNgdgPtThVgBFpgwuYHIhRxD
 elaug+4a3XQfGi7ulLcoahgI2lE7FAsGQmPIQ0Z79Y+N/iRVNCShlAzdK5qQ7yRpA2qp
 xMOBf6XlI5SeJWtmtzE+2ozrB0H4SftrZ4awiBpVkKRKNMfS2Fn+i/g1gojSsX0CJUcR
 +0UMVfSN8OGKxZT4rkVgVUszEyCmbOhA+X2K/0WRDWf2rfU4QFS73NUAwJXCYvJwoU9n
 MX1g==
X-Gm-Message-State: ABy/qLZ2bqCZUVEzwqgJR+ScUBiaRdpDYGD3wTaOo12Me/WfXCmzlbQU
 rPBDuZKV+boWxZiN5JD1Bn9RQHxELoiSmA==
X-Google-Smtp-Source: APBJJlGyCBuRT+L5US3wjYdbXEVNb+kT3xUsV/Ldj0iHtljARnWppnB4fB17HvZ7a8HHoIDMGPG0JQ==
X-Received: by 2002:a9d:65ca:0:b0:6b9:482e:ed10 with SMTP id
 z10-20020a9d65ca000000b006b9482eed10mr3454811oth.21.1688992353519; 
 Mon, 10 Jul 2023 05:32:33 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:32:32 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 04/54] disas/riscv: Make rv_op_illegal a shared enum value
Date: Mon, 10 Jul 2023 22:31:15 +1000
Message-Id: <20230710123205.2441106-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x32a.google.com
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

From: Christoph Müllner <christoph.muellner@vrull.eu>

The enum value 'rv_op_illegal' does not represent an
instruction, but is a catch-all value in case we have
no match in the decoder. Let's make the value a shared
one, so that other compile units can reuse it.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Message-Id: <20230612111034.3955227-5-christoph.muellner@vrull.eu>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.h | 4 ++++
 disas/riscv.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 9288255915..debbe69239 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -191,6 +191,10 @@ typedef struct {
     const rvc_constraint *constraints;
 } rv_comp_data;
 
+enum {
+    rv_op_illegal = 0
+};
+
 enum {
     rvcd_imm_nz = 0x1
 };
diff --git a/disas/riscv.c b/disas/riscv.c
index 4a55348267..b6ced2a26a 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -23,7 +23,7 @@
 #include "disas/riscv.h"
 
 typedef enum {
-    rv_op_illegal = 0,
+    /* 0 is reserved for rv_op_illegal. */
     rv_op_lui = 1,
     rv_op_auipc = 2,
     rv_op_jal = 3,
-- 
2.40.1


