Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F4772F1AA
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:22:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FDH-0007e3-OH; Tue, 13 Jun 2023 21:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDF-0007Px-J4
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:17 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDD-0004jn-M9
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:17 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-665a16cdd97so2386942b3a.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705734; x=1689297734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2dguhDmlXBxgO4DQik/72fKiXxqXi4QsRT4dSliRH8Y=;
 b=EYRcIrldOxTKFMR1REm1J9eOnHQW63TlOowvC5IcFMCQ5pXuk5zX17yeateB/ke6D2
 THXBUWxbacE/4sVi07YCE9dRjhL99PhiXtExqr8SNgn1j/eNDOt91vF3nHq2jQj/znC0
 ghHGgjoYMLQKdbi1aP8KFfY1lgYXb/eh7A7Z5C++YCmpsqKBJMAPDtbaMQ24llGxCADU
 T8dCUP/9+scEguemuWqhY7G2RGWR+lg9Xt/TUnZVQjbH8B4XKsVf+YAxx7FcQT3MForO
 R6H6hRtdQjE/HNJgN/Q8SD1EukGweKxzm1++K2w4ga6jj/DFn1gX4NybhlMJtyZ7AXQg
 yIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705734; x=1689297734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2dguhDmlXBxgO4DQik/72fKiXxqXi4QsRT4dSliRH8Y=;
 b=Q61f3KB6s8er+EuRT9JqeKw5PbIuyNbyIXqnPAWEJBalcLqSD3+YcfgXB1tU5l8PLE
 aqjcf/CUn7qPK+aF6nv1KjtV9D8kAhIamwUPC/k/8gLTMCs3DGLAjE84fWpYpIk5PlWD
 H1URi89O1i1dQQtF1l5XMKEYmEG3C9Cx2eANNT9/rus4nbgE/T/hztfqQSV/rc6aUmjw
 cr4nKUOE57xmaebNd3ifyhFZ3dlBUyB9s0vWM9NQzqzsL9kHMpj5vYdUQQRhVt6625LW
 f7FZJaVyJYdeQzbcbbICrrcfpGhhvR5rrwj38O6yp8kQHcbn4A6eSqZrOqZIDErVhmcJ
 tM7w==
X-Gm-Message-State: AC+VfDxzvURohgflv8Kd9UKXpk0RUiXo1ARjXfTcfqj5xzza/AZw3JZt
 JnhMr4e+WjFqa+TI6PEejKrUkWsOAIom1A==
X-Google-Smtp-Source: ACHHUZ7s6/vBUp8K7ZEBnxj/N9P6XMrHdX1KZ2oLnSmsU3cMfErE+IaYRbK0+urRZWBy+GP6AGq1rg==
X-Received: by 2002:a05:6a00:b94:b0:64c:4f2f:a235 with SMTP id
 g20-20020a056a000b9400b0064c4f2fa235mr618168pfj.30.1686705734150; 
 Tue, 13 Jun 2023 18:22:14 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:22:13 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 25/60] target/riscv: Deny access if access is partially inside
 the PMP entry
Date: Wed, 14 Jun 2023 11:19:42 +1000
Message-Id: <20230614012017.3100663-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
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

Access will fail if access is partially inside the PMP entry.
However,only setting ret = false doesn't really mean pmp violation
since pmp_hart_has_privs_default() may return true at the end of
pmp_hart_has_privs().

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230517091519.34439-13-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 37e9985d6a..418738afd8 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -327,8 +327,8 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
         if ((s + e) == 1) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "pmp violation - access is partially inside\n");
-            ret = false;
-            break;
+            *allowed_privs = 0;
+            return false;
         }
 
         /* fully inside */
-- 
2.40.1


