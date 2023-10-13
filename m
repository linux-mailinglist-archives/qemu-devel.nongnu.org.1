Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B107C8138
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:59:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqK-0008NI-Ad; Fri, 13 Oct 2023 04:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqD-0008B1-H0
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:17 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqB-00011h-Qv
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:17 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40684f53d11so22241725e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186894; x=1697791694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M9LkGlEKRSz223Ey1OkuAlQ7hiRFoI4Wxoo+HIWaXT4=;
 b=hOHn2vXcVZ84Lpn9OaeHE3gbGsST61y3CNXmEmjCIEh9yrpekoMU1eLrhO0pzO4zEc
 oTWOGlKxRGLwQ0JNIuDykgTbXHv2w+pq3GLh1OpyFApkTL+9egSLDSkD09tyuZkwx15X
 dY5vaej7D1T7FX9vttx1AB2k17jNTU/bzcnDTe0HgfeOSJBo7GZ6b4L8F8RAbT+dLb0A
 G5DxE8AJFiEhpuZFSweE9vUvcFa6ZD/Gexn2IF3sIsyKf05fYYtxTstgvgk+FRoEPZGp
 rHW9/wk0XclI+l7xuRGv4dhociqu6G7FhhKeRGJxWtYrGRvw4CAI77pE4ofTtc0JRtJ6
 B+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186894; x=1697791694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M9LkGlEKRSz223Ey1OkuAlQ7hiRFoI4Wxoo+HIWaXT4=;
 b=l+BePXlWe783sU2qlIcYG6pg0YB21IOOazrqEWF2Vc9VtlX6XUfuDJ50IzU8ZDG1e/
 Of5UVyvg02So5Zch5lsShrHL+Sgo6BDgFkm0Kn6Z2fmsQZulmoajMRnhwerDpbuUjUKy
 /Y/GZgx/Oxpu7A6gnXlvPbYlj9U3nV/bAe93wZXvVZyUlzTaLCtIJpn90Pwq5AaTda7o
 lg/SQliu+FjymbFpfgj7GsWouksgA6kOoS9v59lFnyjfSfPk0YvNBCfAJqb6jtv5iW4A
 XglucfLYr3nnw13iDOsSgU17U7SvN/5VqkEduCwVvLRdttsiNdg4cfW6cDukN60u1rmC
 breA==
X-Gm-Message-State: AOJu0YzxA8W0RLvxcTXi90kZodiHi6l6ObsnBI5gcbDwUda1rw/O3p3r
 baOz/GRNC9A94pd5u2d5KYUu0I2OQDgNnyJ1ai0=
X-Google-Smtp-Source: AGHT+IH8KOp7N4i6goXLJ+GUVpP9iyEmiLV6FXvfPKbewTYZw8MxfB1oazBV/h28He86j8csa+7Yow==
X-Received: by 2002:a7b:ce07:0:b0:406:4501:9095 with SMTP id
 m7-20020a7bce07000000b0040645019095mr23383078wmc.40.1697186894028; 
 Fri, 13 Oct 2023 01:48:14 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:13 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stafford Horne <shorne@gmail.com>
Subject: [RFC PATCH v3 36/78] target/openrisc: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:04 +0300
Message-Id: <92f0a633d3d24d6747cd45fae5a8889ebede21c1.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/openrisc/mmu.c       | 2 +-
 target/openrisc/translate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index 603c26715e..7ed744e81b 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -168,7 +168,7 @@ hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
         if (!excp) {
             return phys_addr;
         }
-        /* fallthru */
+        fallthrough;
 
     case 0:
         /* The mmu is definitely disabled; lookups never fail.  */
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index ecff4412b7..de77014d60 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1618,7 +1618,7 @@ static void openrisc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
            However, we will have stored into jmp_pc as well;
            we know now that it wasn't needed.  */
         tcg_gen_discard_tl(jmp_pc);
-        /* fallthru */
+        fallthrough;
 
     case DISAS_TOO_MANY:
         if (translator_use_goto_tb(&dc->base, jmp_dest)) {
-- 
2.39.2


