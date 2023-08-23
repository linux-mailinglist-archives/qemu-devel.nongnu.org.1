Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09948786168
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:26:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOc-0008TG-Gw; Wed, 23 Aug 2023 16:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOV-0008L4-8E
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:59 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOK-0005Te-Tx
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:56 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bdc19b782aso41149995ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822211; x=1693427011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CumRRNy4oJ8v2b9mAzFsvwDx5ATFvQj9a3tTdZCeMgY=;
 b=IBK7O0FZJlTLvn7Bo/q7XODxYtsOqyOH6bq64ko7eRsmU92/tmq0MWOwa/YcYMF8mN
 JPLbupyEaSDVjxG7u5QRzKeO7o3bEcjNTLKTtjSEd0M/Lesu9BycWI5QWTAa5RlrNQQW
 Q8l8pbiWeqYc3uCprODQy4ZuCm2l0x+MKMpomLQ42PbhFP68e6eYsK1dkU+aJO8WIxud
 QjWIqLWniE1pEv73Kv4LHPvgxz2ZMO5X3363sIkAdTfmIMPXd7HbQyEqbbfAc9MDpk5g
 InqVzAtnyRvF5A1mVpVGIBwov6M7R+FQOyE5w33l3c2mibT4Rjfb4qa+zFhN6QNy51XU
 eI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822211; x=1693427011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CumRRNy4oJ8v2b9mAzFsvwDx5ATFvQj9a3tTdZCeMgY=;
 b=OaiR1JQ+hfZJZ540XNaW8d9OxSgmgOhYGoklD7MKDkKYh59InIriZeDGiAzdPc/kJa
 LDgMYx7YiBsg0sxMrF3fkOnlpLvIq45bNHSmVS6HRr8laXzYqp70oksj+QX3dYxTLB4/
 xPvmBXtnKDNN8Zv4KN/rVob1cep/7vOOOw6i6I4k1ihqjofygfV39EIOtsOGS/WcpcID
 Lvvix8ZosysJtd4DVJodcUmvWbPoC0ilqSV2U6vjavFWI+mwL0udY7/ogjEi+htyOMJ+
 Cf+1F3ZVxs8NqtEG/xf7Q9ns1MnRyHls921yXXemmDSF4LX20HaikqSi9p2npY1J5aaI
 BxjA==
X-Gm-Message-State: AOJu0Yy4vi7lic/et+0iZvf9P1/WUwJaoasX056QWEFn+OaZit4A+Uqb
 /QNQ1wIytJG5tWNpx/GOtsWOPgdOdF09EjcJIcY=
X-Google-Smtp-Source: AGHT+IGsYOvcY82rehuC9G6QEUvnh1Li8ScqD0/9//7HIFFHqdJwqQdrzi5Isui+Cvr44FtUh7My/w==
X-Received: by 2002:a17:903:120a:b0:1b7:e86f:7631 with SMTP id
 l10-20020a170903120a00b001b7e86f7631mr13822817plh.19.1692822211651; 
 Wed, 23 Aug 2023 13:23:31 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 04/48] sysemu/hvf: Use vaddr for
 hvf_arch_[insert|remove]_hw_breakpoint
Date: Wed, 23 Aug 2023 13:22:42 -0700
Message-Id: <20230823202326.1353645-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Changes the signature of the target-defined functions for
inserting/removing hvf hw breakpoints. The address and length arguments
are now of vaddr type, which both matches the type used internally in
accel/hvf/hvf-all.c and makes the api target-agnostic.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230807155706.9580-5-anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/sysemu/hvf.h  | 6 ++----
 target/arm/hvf/hvf.c  | 4 ++--
 target/i386/hvf/hvf.c | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index 4cbae87ced..4037cd6a73 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -51,10 +51,8 @@ int hvf_sw_breakpoints_active(CPUState *cpu);
 
 int hvf_arch_insert_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp);
 int hvf_arch_remove_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp);
-int hvf_arch_insert_hw_breakpoint(target_ulong addr, target_ulong len,
-                                  int type);
-int hvf_arch_remove_hw_breakpoint(target_ulong addr, target_ulong len,
-                                  int type);
+int hvf_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type);
+int hvf_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type);
 void hvf_arch_remove_all_hw_breakpoints(void);
 
 /*
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8fce64bbf6..486f90be1d 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2063,7 +2063,7 @@ int hvf_arch_remove_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp)
     return 0;
 }
 
-int hvf_arch_insert_hw_breakpoint(target_ulong addr, target_ulong len, int type)
+int hvf_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     switch (type) {
     case GDB_BREAKPOINT_HW:
@@ -2077,7 +2077,7 @@ int hvf_arch_insert_hw_breakpoint(target_ulong addr, target_ulong len, int type)
     }
 }
 
-int hvf_arch_remove_hw_breakpoint(target_ulong addr, target_ulong len, int type)
+int hvf_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     switch (type) {
     case GDB_BREAKPOINT_HW:
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index b9cbcc02a8..cb2cd0b02f 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -690,12 +690,12 @@ int hvf_arch_remove_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp)
     return -ENOSYS;
 }
 
-int hvf_arch_insert_hw_breakpoint(target_ulong addr, target_ulong len, int type)
+int hvf_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     return -ENOSYS;
 }
 
-int hvf_arch_remove_hw_breakpoint(target_ulong addr, target_ulong len, int type)
+int hvf_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     return -ENOSYS;
 }
-- 
2.34.1


