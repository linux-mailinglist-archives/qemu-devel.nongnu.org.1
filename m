Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 347F1798207
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:11:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUen-00016c-7G; Fri, 08 Sep 2023 02:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUel-00010s-3r
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:51 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUei-00086L-N3
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:50 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c1f8aaab9aso14776545ad.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153267; x=1694758067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V2SYdMaTh5B2DYvWJCJ2xIYyu0izkkUvTM4RwQhhWt8=;
 b=sG0oBPKpeVV1CEdoq1RAQIs8XU+VqRfYzkY2q8Wv+c6oUerMzxGVlXwmb7xYowczl0
 vP39mZswKcGNPbg6bTVJqwO1/UiGBUEMBvtrXYB4kaOQ0TPIVtsTiLBQwSWzH5yWqIyk
 +WPv6qASme3frh0KxnRzyxOPIVZK65tk0Wj8kcCZWiu4G/1ajVasItlhKAB9hl76pLmR
 a9pDHT3lgjzTKAR7GD6yMmfbcB6EJnLYuRqaeCVeoIIaCkKsQJ97AaFtbJNBP9cBg1qJ
 iIvxezniWvXQaMRSCP/huscgUsHaV/6GhTvBql2gAk2vleMHVe1t7Yo5Xr9r50VVBtVW
 8DTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153267; x=1694758067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V2SYdMaTh5B2DYvWJCJ2xIYyu0izkkUvTM4RwQhhWt8=;
 b=oNljDjuwJqjCQ6cvAeeVYLKspuLLgyMgzPjAjdrKIhlz4f8quOEOI83zX/qegFIKLR
 6UQVFhAWXwbewaMihYZ3QIzkVgWYmepKXAWC2tXdHjh4dZciI9OWy/g8RaKJj0oXOHxf
 m7CTqog9X2uWHR2I+/v+UkKyoXsx3kBl5uLa7Ig16w7iJ9512GXPwGUsY6o7153H6yGS
 viSd6weQ/o/xqle3ppzSX1getEtgy68D63VoLhrOO7yVresxEwdd1psTiMbKzN96ix3Y
 zyU7m9QDPt8iLu9kY1kmHKuvoUjfvaNXydAeptnfzGwMlhaI3danVLtgowCHbycIwEyA
 oTyA==
X-Gm-Message-State: AOJu0YzQkgh1WpNVo/rutEOmunIeqPVPmrZJGfoUCt2W7V+UR8Be/j/v
 p37k/pitpY9c8AKMGYO/vm4ojrWtbWOOa4Z8
X-Google-Smtp-Source: AGHT+IHj7l+i0mTgZINozOhRCYzryZLYvauDY5sDdVdEKCVKxVxZkmcuha/yRo0RJFqd3103AYlQ0Q==
X-Received: by 2002:a17:902:f546:b0:1bb:7f71:df43 with SMTP id
 h6-20020a170902f54600b001bb7f71df43mr1796073plf.34.1694153267010; 
 Thu, 07 Sep 2023 23:07:47 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:07:46 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Nikita Shubin <n.shubin@yadro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 45/65] target/riscv: don't read CSR in riscv_csrrw_do64
Date: Fri,  8 Sep 2023 16:04:11 +1000
Message-ID: <20230908060431.1903919-46-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nikita Shubin <n.shubin@yadro.com>

As per ISA:

"For CSRRWI, if rd=x0, then the instruction shall not read the CSR and
shall not cause any of the side effects that might occur on a CSR read."

trans_csrrwi() and trans_csrrw() call do_csrw() if rd=x0, do_csrw() calls
riscv_csrrw_do64(), via helper_csrw() passing NULL as *ret_value.

Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230808090914.17634-1-nikita.shubin@maquefel.me>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 4a0f6a89be..e51815c448 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3917,21 +3917,27 @@ static RISCVException riscv_csrrw_do64(CPURISCVState *env, int csrno,
                                        target_ulong write_mask)
 {
     RISCVException ret;
-    target_ulong old_value;
+    target_ulong old_value = 0;
 
     /* execute combined read/write operation if it exists */
     if (csr_ops[csrno].op) {
         return csr_ops[csrno].op(env, csrno, ret_value, new_value, write_mask);
     }
 
-    /* if no accessor exists then return failure */
-    if (!csr_ops[csrno].read) {
-        return RISCV_EXCP_ILLEGAL_INST;
-    }
-    /* read old value */
-    ret = csr_ops[csrno].read(env, csrno, &old_value);
-    if (ret != RISCV_EXCP_NONE) {
-        return ret;
+    /*
+     * ret_value == NULL means that rd=x0 and we're coming from helper_csrw()
+     * and we can't throw side effects caused by CSR reads.
+     */
+    if (ret_value) {
+        /* if no accessor exists then return failure */
+        if (!csr_ops[csrno].read) {
+            return RISCV_EXCP_ILLEGAL_INST;
+        }
+        /* read old value */
+        ret = csr_ops[csrno].read(env, csrno, &old_value);
+        if (ret != RISCV_EXCP_NONE) {
+            return ret;
+        }
     }
 
     /* write value if writable and write mask set, otherwise drop writes */
-- 
2.41.0


