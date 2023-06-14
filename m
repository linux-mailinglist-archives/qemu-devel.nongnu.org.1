Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1560472F1F0
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:31:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FG2-0006Me-Ex; Tue, 13 Jun 2023 21:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FFN-0005j7-BO
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:24:29 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FFH-00051K-LD
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:24:25 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-662f0feafb2so4530071b3a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705862; x=1689297862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EKsu31DdEac+zt28WxA5NELSUtvT8osZvWAWCSHx2zc=;
 b=PV0yCw6uTsREN/jgjK3a9jpJmEKylxvWyhofBD+4ZVfHrRC9GBAW5L+JORtk3CqBcX
 hezijzaG3/jtyqnMGomgoQPSdAezJ65jeksfbPNsKGOl6WY6r6wAhW54qkZ3JAn6qshk
 lN/jM5Z2G/o+lXXrvPt5dSElpHCEXtf0Db6aQzOzNz68PMG+rnThqjinSmkhyE+a7SFu
 9tUvhTIPen144H9IZ9a+qUXKwIZZW+PTJViLqkx72KGEMYgJABVKdkguUHBjPhbkKwSe
 WHeGG+fY1bV9WAqaOGEYNUENk85eozvbxq5c0W3pOFnLWs2RLi5aGjpwbOMrbML85RvZ
 xdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705862; x=1689297862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EKsu31DdEac+zt28WxA5NELSUtvT8osZvWAWCSHx2zc=;
 b=Svn5FKPnuX7+5fgLs25a/u9udmVVBsQVNQ6DvtfLeJ8ZHxEjLom7r/2sONMnTvGZhV
 PqPL1cu8rU+555MM1Pr7/bg8eumWUtg/hUQ7qny12DnPmqgtNjVOPp0kC8tGHkGkK45D
 Otq2ZrwVEJP+bIW1ZnyPhIVdv8EXu5SBHpP6cPET7pKIEvA5Dj+p66o1mX8fZYsgpO/2
 Sf9FspLUV4TtjkVDkx6JDpxsrfULd99qtnw5h/Q8VvsDkcDl5QH/hnpRRedtJI10XK6S
 SGkD3ykljy7yM3C2Vlpi62Zqzuj7N9mY2tX4JMZB4/9uL6SxUJ5d1Uwr6hpLft84Oj1u
 CrBw==
X-Gm-Message-State: AC+VfDxuHkdmiEDQH/E2tucpffIKQhatq18ND7ZRJ/gHQS3oFBlZZtWR
 ubO1TLz8Hgp5iD79ib7H1rJDIo+q/zmhpg==
X-Google-Smtp-Source: ACHHUZ6U4HLrlG+O1lG3wAIj+6omXy6b3mqeGyiOIqUjNDg6rQc1LdkHwGspm5WiIw/AKYstlj4JWg==
X-Received: by 2002:a05:6a00:2d87:b0:645:834c:f521 with SMTP id
 fb7-20020a056a002d8700b00645834cf521mr201613pfb.17.1686705861860; 
 Tue, 13 Jun 2023 18:24:21 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:24:21 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Xiao Wang <xiao.w.wang@intel.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 57/60] target/riscv/vector_helper.c: clean up reference of MTYPE
Date: Wed, 14 Jun 2023 11:20:14 +1000
Message-Id: <20230614012017.3100663-58-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x434.google.com
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

From: Xiao Wang <xiao.w.wang@intel.com>

There's no code using MTYPE, which was a concept used in older vector
implementation.

Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-Id: <20230608053517.4102648-1-xiao.w.wang@intel.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 7505f9470a..e8af64e626 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -388,7 +388,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
 
 /*
  * masked unit-stride load and store operation will be a special case of
- * stride, stride = NF * sizeof (MTYPE)
+ * stride, stride = NF * sizeof (ETYPE)
  */
 
 #define GEN_VEXT_LD_US(NAME, ETYPE, LOAD_FN)                            \
@@ -660,10 +660,6 @@ GEN_VEXT_LDFF(vle64ff_v, int64_t, lde_d)
 #define DO_MAX(N, M)  ((N) >= (M) ? (N) : (M))
 #define DO_MIN(N, M)  ((N) >= (M) ? (M) : (N))
 
-/* Unsigned min/max */
-#define DO_MAXU(N, M) DO_MAX((UMTYPE)N, (UMTYPE)M)
-#define DO_MINU(N, M) DO_MIN((UMTYPE)N, (UMTYPE)M)
-
 /*
  * load and store whole register instructions
  */
-- 
2.40.1


