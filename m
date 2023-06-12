Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D6872B85E
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 08:57:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8bTz-0003Fo-15; Mon, 12 Jun 2023 02:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coc.cyqh@gmail.com>)
 id 1q8bTl-0003FZ-9s
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 02:56:41 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coc.cyqh@gmail.com>)
 id 1q8bTj-00074L-Ci
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 02:56:41 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1b3a9e5bf6aso9028655ad.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 23:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686552996; x=1689144996;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a4mCzG6/ugbdK1+/Lml/4geapoMKhYxY2WKj0jaMX6U=;
 b=nGQ6hD7LakyKRcWmIYwzUS4zvGFmROvDbHIk68i2Sp31T4HB3+crEzw3fR7sKA2HzF
 ZPyDwGi3o7NKj0JaijoaHp8mbMT3LWFw0FWlU7VFayapgrmSXKDuS/1j+ywipMV1VsBW
 uxrLUJ7JYjsosIM/9wAtUlW/wR3kIZjbyCdKraP3QYt/LWiSM11pBwy9QQgJP+rhEKKN
 qQW1ZQk2M3pHmlxRXn5mMZYMYql1ZJEfjgH6dgmgHoBkLu0dUEJlZdNcYqt4Cn5/EilF
 pRoIiZkZjS4lDoS8QqLHdc4csQT4d8l+fgczbER8YchFur7bo9oZxP6z2SdaNevM2H8+
 E4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686552996; x=1689144996;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a4mCzG6/ugbdK1+/Lml/4geapoMKhYxY2WKj0jaMX6U=;
 b=AJUs9YNEJvCCBHthYbQ+yAg6je40RYyqfxMs0fzkZfqaC8HpB7jLDvnLi62wnUVJZv
 bhBpOdOL5KMkeMnrVZQreqGbSH30LUKr3hEWib+YdGjsBFIoFD6tBPomrAHZW2hHE3ms
 pcON/tNH4vcJOsaHrPsqZ12OCW9CV120FehzTq4I19yhBzhfg2jxBPXwQ9llx7ewC7k+
 0SnO1DS+7eqWVphOfiUvmvvolep3+rhAYr/42uip7iF/kIdGUtNhAuBucSVIB5doyDqT
 10luZjtXIdboVAxnIAfl8IB8Xj67U1aZ6EQn4oHaCGeF7X2kGuG34BLNKnRftj2MbM8I
 Yzvg==
X-Gm-Message-State: AC+VfDyb5/R6a/nvjqxHRReGVdxUdoW3s/6RpWE5blEmWbHPBxZcL12W
 O5sqFnbLri3n0kVm5yrthMjb57K1axaMrWxqkD8=
X-Google-Smtp-Source: ACHHUZ4WSsv1EDD1P9wNcExCCKRaWb1EDyHBAVMmjGBKj+aqQ9AlKgB27977ZVvk7dEsbovGXDbThg==
X-Received: by 2002:a17:903:22c9:b0:1ad:fcdc:2a9f with SMTP id
 y9-20020a17090322c900b001adfcdc2a9fmr5897585plg.51.1686552996469; 
 Sun, 11 Jun 2023 23:56:36 -0700 (PDT)
Received: from coc-virtual-machine.localdomain ([61.165.187.211])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a170903234100b001ab12545508sm7473652plh.67.2023.06.11.23.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 23:56:36 -0700 (PDT)
From: Siqi Chen <coc.cyqh@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	kbastian@mail.uni-paderborn.de
Subject: [PATCH] target/tricore: Fix out-of-bounds index in imask instruction
Date: Mon, 12 Jun 2023 14:56:33 +0800
Message-Id: <20230612065633.149152-1-coc.cyqh@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=coc.cyqh@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

When translating  "imask" instruction of Tricore architecture, QEMU did not check whether the register index was out of bounds, resulting in a global-buffer-overflow.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1698
Reported-by: Siqi Chen <coc.cyqh@gmail.com>
Signed-off-by: Siqi Chen <coc.cyqh@gmail.com>
---
 target/tricore/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index cd33a1dcdd..3b8d3f53ee 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -5331,6 +5331,7 @@ static void decode_rcrw_insert(DisasContext *ctx)
 
     switch (op2) {
     case OPC2_32_RCRW_IMASK:
+        CHECK_REG_PAIR(r4);
         tcg_gen_andi_tl(temp, cpu_gpr_d[r3], 0x1f);
         tcg_gen_movi_tl(temp2, (1 << width) - 1);
         tcg_gen_shl_tl(cpu_gpr_d[r4 + 1], temp2, temp);
-- 
2.34.1


