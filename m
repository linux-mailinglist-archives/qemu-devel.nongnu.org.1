Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1E4786176
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:27:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOj-0000K5-Ms; Wed, 23 Aug 2023 16:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOT-0008KA-4k
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:58 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOB-0005TM-VO
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:49 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bda9207132so48316985ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822209; x=1693427009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sag9wYjn+T6sNPgSHmtKDLhQdqb9BHIQ8q3YF6+2bV0=;
 b=C0qtO0Kl87dxlFvgLLgkHnHWv/+fc9hWcETKjsH8OsH5clCkBhGvwA6ebOLqpnquks
 ZqPHevlc4ZrnvE17BUw2TNXUv0IXsav/yUYGGB7USqoYfexhfjiCXkMfuqlXDQ77ozt0
 I9OxF71hulGYdGxMzqkyfHT4gJGk7b8J/KvgsD4u70HjXGiZBxmaIoqegGAwLWsOhSgz
 KoNzbjwIxFGCPEKTWbT7ayR7bk9nVL44VYpThqAYNlUzKyjywn1OT5uRX5dtDdpMGokm
 FkCzoAjKSFq/R8yI/PnaA8RMdMNian1/+KOa9MKFTviEIJxKi/NoqmnK3XMPPjYZ9Ooz
 kcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822209; x=1693427009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sag9wYjn+T6sNPgSHmtKDLhQdqb9BHIQ8q3YF6+2bV0=;
 b=Fk7OeTr1Xe1eKNEt7EH57u/o9udeZrOMdB1vbg1/5Z5N589XXbOarnVMYP6W3FrAqI
 fc9zo3v3NmEbG/Tp0hPKFUBo4yT4Jnv1NLq4EnwU9EOzPnkzDiJxMFbJ59TuidQj5h30
 PDU3tPdGUWmpWA/WODfyGcCpn+C8tD0RcIcC5HXYJtQZ2fbvepOrHw64qi2H8LD/9gZ0
 2uVR2HQgmHyewRu5ru3IB3+eeNL+GkKdHqizeJWmtJYLpNNwRyruEg5330M02CpXTAom
 qw2lu1FVfKMJGRFx0lwlW12kgrWhTttO9s3X2NZTvl232ULe+3SyT/DeOmUXB1dO3RAa
 CTFw==
X-Gm-Message-State: AOJu0YwNw4uDVZ6++cI22Af7GkercRMm/RwiMbGz9JZxN9FsOJhAer5m
 bDhCaXwhaTXGy2Vws6+2eYmgLfHbMaKnz00CbW8=
X-Google-Smtp-Source: AGHT+IHC8HZrtrwH6/j7XsTNIUtChh7IgdZVeZ4/mdW6xqcDf/lA9oukib11xg03tEyrKBh7PcPCaw==
X-Received: by 2002:a17:902:c20d:b0:1c0:bf62:c921 with SMTP id
 13-20020a170902c20d00b001c0bf62c921mr908199pll.18.1692822209146; 
 Wed, 23 Aug 2023 13:23:29 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 01/48] accel/kvm: Widen pc/saved_insn for kvm_sw_breakpoint
Date: Wed, 23 Aug 2023 13:22:39 -0700
Message-Id: <20230823202326.1353645-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Anton Johansson via <qemu-devel@nongnu.org>

Widens the pc and saved_insn fields of kvm_sw_breakpoint from
target_ulong to vaddr. The pc argument of kvm_find_sw_breakpoint is also
widened to match.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230807155706.9580-2-anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/sysemu/kvm.h | 6 +++---
 accel/kvm/kvm-all.c  | 3 +--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 115f0cca79..5670306dbf 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -411,14 +411,14 @@ struct kvm_guest_debug;
 struct kvm_debug_exit_arch;
 
 struct kvm_sw_breakpoint {
-    target_ulong pc;
-    target_ulong saved_insn;
+    vaddr pc;
+    vaddr saved_insn;
     int use_count;
     QTAILQ_ENTRY(kvm_sw_breakpoint) entry;
 };
 
 struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu,
-                                                 target_ulong pc);
+                                                 vaddr pc);
 
 int kvm_sw_breakpoints_active(CPUState *cpu);
 
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 7b3da8dc3a..76a6d91d15 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3306,8 +3306,7 @@ bool kvm_arm_supports_user_irq(void)
 }
 
 #ifdef KVM_CAP_SET_GUEST_DEBUG
-struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu,
-                                                 target_ulong pc)
+struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu, vaddr pc)
 {
     struct kvm_sw_breakpoint *bp;
 
-- 
2.34.1


