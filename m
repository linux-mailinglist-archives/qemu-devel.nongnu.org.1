Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 661EB77D400
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 22:18:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0TA-0001kL-KT; Tue, 15 Aug 2023 16:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW0T8-0001iV-Cf
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 16:16:46 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW0T5-00059F-9H
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 16:16:46 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6bd0911c95dso5174845a34.3
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 13:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692130602; x=1692735402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lo3i5N5BbKo6DP4yawS4oeiSuoKJHFlJGeBJBU9cGgc=;
 b=gmKq3fJjJzeUjvSGnsU7oCh34vwqmuckT9Bu3NFRHArW7gp6Qa+YSSq9ZmUCgWfzGN
 eZSpFB5MwI63HhQy5zQxzcRAS8HQX+gyQnFyt1Px+Hiod+fM7Hysac3PXuT5erkBS96L
 hZQsWG5NT3GGvZkRxnrJS4LjIr8nPVcsu7hNjZPEtMi8o2B663C+3/w2CHAAAsbN4oM3
 ijgUVzWgrc8LAUEZTeyytfHlyjzjyqdl1Mwjg6ntE+vQwJn34AG4Ka/idV60X6eXUOS/
 jYwT4nwg5z7CIQj+8zN0d04Cri/6F15jG5jXipx4e+0eiU/mjxSOjyTjTcHY8A2gnUCN
 zKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692130602; x=1692735402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lo3i5N5BbKo6DP4yawS4oeiSuoKJHFlJGeBJBU9cGgc=;
 b=djt4pxb03sTqrcZSc/m+8QdRk9c3IdpEidYhSVJ/kJUo6+KtTu22lgbHDToaOd5CQn
 HX0ZW+CUBkZxYqmmGQjLWjdAvRnlJRcePVklyaPlUvaHbl7cJq5UqhsNSqy8iZA65CX0
 9l0IGB7eFU5JgF9jz6DROLrC5BOSt0lRIUUbzSove+IHzGxAQLBZzOmUyEe0uPhMwINn
 KDcluwU/QZd0pPD5rh1eMM41roIAhgzYrpfbKE0IQR3DrCqs3xGCAtv0rXtY5/xs9YHt
 bE4J3n31mN5UkSTftSfwcMf04YtIf28iMMYI0g86NlUYM/5qPOMIR51tqUG0XNaEM86B
 wafw==
X-Gm-Message-State: AOJu0YzAcYXwDMcn1CmNYXS+Xc9mUtpRG0pCQyXYF1YFNIfpNKhJVB6e
 wvVUn2BTacMKxQmr1nf0192qzsg9cuagv8Td3ds=
X-Google-Smtp-Source: AGHT+IGXcxoL6ufyaRynV1T+E9EvKyBaUfKSUqnQcO2PsXCrtjamS4w9CNZZmBVjATPGvvEZb2EzEw==
X-Received: by 2002:a05:6870:6091:b0:1bf:440:a055 with SMTP id
 t17-20020a056870609100b001bf0440a055mr12901224oae.4.1692130602032; 
 Tue, 15 Aug 2023 13:16:42 -0700 (PDT)
Received: from grind.. (189-69-160-189.dial-up.telesp.net.br. [189.69.160.189])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a056870e80e00b001bb5b2a958csm6658203oan.23.2023.08.15.13.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 13:16:41 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v7 12/12] target/riscv: deprecate the 'any' CPU type
Date: Tue, 15 Aug 2023 17:15:59 -0300
Message-ID: <20230815201559.398643-13-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815201559.398643-1-dbarboza@ventanamicro.com>
References: <20230815201559.398643-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The 'any' CPU type was introduced in commit dc5bd18fa5725 ("RISC-V CPU
Core Definition"), being around since the beginning. It's not an easy
CPU to use: it's undocumented and its name doesn't tell users much about
what the CPU is supposed to bring. 'git log' doesn't help us either in
knowing what was the original design of this CPU type.

The closest we have is a comment from Alistair [1] where he recalls from
memory that the 'any' CPU is supposed to behave like the newly added
'max' CPU. He also suggested that the 'any' CPU should be removed.

The default CPUs are rv32 and rv64, so removing the 'any' CPU will have
impact only on users that might have a script that uses '-cpu any'.
And those users are better off using the default CPUs or the new 'max'
CPU.

We would love to just remove the code and be done with it, but one does
not simply remove a feature in QEMU. We'll put the CPU in quarantine
first, letting users know that we have the intent of removing it in the
future.

[1] https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02891.html

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/about/deprecated.rst | 12 ++++++++++++
 target/riscv/cpu.c        |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 92a2bafd2b..4ced7427ac 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -371,6 +371,18 @@ QEMU's ``vhost`` feature, which would eliminate the high latency costs under
 which the 9p ``proxy`` backend currently suffers. However as of to date nobody
 has indicated plans for such kind of reimplementation unfortunately.
 
+RISC-V 'any' CPU type ``-cpu any`` (since 8.2)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The 'any' CPU type was introduced back in 2018 and has been around since the
+initial RISC-V QEMU port. Its usage has always been unclear: users don't know
+what to expect from a CPU called 'any', and in fact the CPU does not do anything
+special that aren't already done by the default CPUs rv32/rv64.
+
+After the introduction of the 'max' CPU type RISC-V now has a good coverage
+of generic CPUs: rv32 and rv64 as default CPUs and 'max' as a feature complete
+CPU for both 32 and 64 bit builds. Users are then discouraged to use the 'any'
+CPU type starting in 8.2.
 
 Block device options
 ''''''''''''''''''''
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 592808939f..3930c85341 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1470,6 +1470,11 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+    if (object_dynamic_cast(OBJECT(dev), TYPE_RISCV_CPU_ANY) != NULL) {
+        warn_report("The 'any' CPU is deprecated and will be "
+                    "removed in the future.");
+    }
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
-- 
2.41.0


