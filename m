Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA3C79A3CD
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:48:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfagw-00078h-0D; Mon, 11 Sep 2023 02:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfagt-0006ql-C6
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:46:35 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfagq-0005IS-Pv
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:46:35 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-490e78ae83bso1478624e0c.0
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414790; x=1695019590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U4G46vZUX3T6HlmuQo4H9nSm/xnI45i/vWbugcAhR7I=;
 b=ejulp8BA0JLKZbfoIUFG/KIRozOspxctOVSgUvvUiKktUjVxviABw7A40kCHVMzqGT
 mQ9fzxXr3Aj1kvPBPbOivhEK3mK5IAcy1VK/lUVNBTw3Dij95EyB41oZEMSu1nC9sJ53
 jfv6M1UinCq3TZ0Ya7BIG3W4CISyN28onTJp/7pYSmWlORbalBAr7J9GCKYkVLy/L27/
 s8hMyQv+fEhEvpmdD9c9wGOfDX4IrsgJiDFgsnl114jmC3cCBQEK/F/d2P5kE6exD2tl
 uowxeb/RGnRIjtGmo3orAIFdfyRxtjoVFbYpfRJx+BVNoy98If6nsfSagFLAPexSDSo1
 0HWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414790; x=1695019590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U4G46vZUX3T6HlmuQo4H9nSm/xnI45i/vWbugcAhR7I=;
 b=ngQSOJx2t18ymiw0azwRJDsLGHOt1empTqX3ANfMUOIQN8x7DVUXJbMMVHl8+srDZ4
 4Tm6LAox5kuoqahrDMJBiToOcueDjCHBWoO0FsKkld1L0Jq+r9t6BH+r2DJfmh47dYFX
 FkvIUNUDKJ6WfySdmPOiJuj25SN3VuP02EZdVzd/+IwLHS9917gPOjsDLoolJJFhh+W0
 brh/CjRXuYRHPVd45GCe32zdM9osO1cZSxOtBFYZnQX0sq+PR+WPOaJJiAWFgXjN8xuY
 B+y6X/eS3vUmoXQepkivnb0JOKmtsqFqdN0jQlaXd9oJT7lpK81c9Gvrb3gd+lEsSAqn
 geMw==
X-Gm-Message-State: AOJu0YwSf0bj+cg8Y7GHxby+5mGUM2Ma2kRF6M7FAi4oLdR6lJqNfmde
 itGdLF9XhsI2YBcGqoxVWteMJdWIpJ9NRg==
X-Google-Smtp-Source: AGHT+IEQWAr3g0oKZkdhGHmJCKRZKiMkNua7/fXECxTaVzQv+M110EHisgHExNrFpMWAnsBZDJIe1g==
X-Received: by 2002:a1f:de84:0:b0:48d:2bcf:f959 with SMTP id
 v126-20020a1fde84000000b0048d2bcff959mr6387234vkg.3.1694414790187; 
 Sun, 10 Sep 2023 23:46:30 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:46:29 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Nikita Shubin <n.shubin@yadro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 45/45] target/riscv: don't read CSR in riscv_csrrw_do64
Date: Mon, 11 Sep 2023 16:43:20 +1000
Message-ID: <20230911064320.939791-46-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2b.google.com
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
index 68eecc3c96..85a31dc420 100644
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


