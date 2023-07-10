Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B637174D585
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:33:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq4e-0000il-Oi; Mon, 10 Jul 2023 08:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4a-0000Tm-Lk
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:01 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4Z-0003Nh-4M
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:00 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6687466137bso2735769b3a.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992377; x=1691584377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p/otPcHa/MJ52rE0UQhNzbApY8GuoRU/7R3XvMGrnss=;
 b=i51mPoucPm62UCOcIGGCp4211Lk0mqs0YdhW0/RwVL76U9GJlAfjB5VySy6I79N/tH
 81HEV7ufymNrGCGdaZOYoHmh+KoFKofX0MJT5VWrQQAi0jOMw8oNPHSCOof4YOItLxXI
 N9VwPgGd1NGmAMqDSjaNVSO1IQZfziiL6pddVYAehDFUHe5H6xHGKqjnpD6mpwWTnp7g
 NQQpH6A7L15wHlujjqAOBInR9A2iHq+rkDtqCB9STQn/2eu3oXyRUXH/6xtcipGx7htA
 8KsdRqtJmbTRI9vkXR8rQBcBeIRW0sbM8PqzxQnn3JY0Ev+RsPwtrnXK6hx1ZydloiLW
 z86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992377; x=1691584377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p/otPcHa/MJ52rE0UQhNzbApY8GuoRU/7R3XvMGrnss=;
 b=Qq5XtIlZCofYsNz2tMf0lM42Gx/PEpyDAtiJrZKLeyNt0wXrNyPwjxTGxxnVpwGDq0
 xwpMEj/UtyyNmPZcT4reO5BDtQ2My8to6O8GH4A8tDGI4en8CQHik/DJLw7Xm7qCAKjS
 8JQMcLy+57XIbRm8QaHetpFeWOmVLg7WYyknaobymCXgih5mmDiJLDt00w8IxjHOJWXt
 erkdudZfjiQmR8tznZ8IfbGxiopuDL8cR2K5UrvxzP8W8hEWNB6Qh3E7+3Nr0ve8xP6x
 r3OyR8Y0yu4yhuITXeJLwD/lHkM7LbLhe0sWJ7N5V3gXS0QqFF2IBNt4uW+5c6eXK8Ns
 5QLw==
X-Gm-Message-State: ABy/qLarRS9WCVSp1pitkZ4wokezFC+di0mi9yHD6MJZuHY8L11mc3Nm
 MMGqftbRZpVwA+ZMQnPJwYkAGNQLB0Y19g==
X-Google-Smtp-Source: APBJJlFh4a56rNwkwUjcumYK7jnS8p8Eb7boCgQAypdMEIwuu9KPw86PQJ5kj80sCxp+Oc0fzSds4Q==
X-Received: by 2002:a17:90b:3843:b0:263:f4cc:a988 with SMTP id
 nl3-20020a17090b384300b00263f4cca988mr9527585pjb.5.1688992377431; 
 Mon, 10 Jul 2023 05:32:57 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:32:57 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/54] target/riscv: Remove redundant assignment to SXL
Date: Mon, 10 Jul 2023 22:31:22 +1000
Message-Id: <20230710123205.2441106-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
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

SXL is initialized as env->misa_mxl which is also the mxl value.
So we can just remain it unchanged to keep it read-only.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230603134236.15719-4-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 6ac11d1f11..25345f3153 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1321,10 +1321,6 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
 
     mstatus = (mstatus & ~mask) | (val & mask);
 
-    if (xl > MXL_RV32) {
-        /* SXL field is for now read only */
-        mstatus = set_field(mstatus, MSTATUS64_SXL, xl);
-    }
     env->mstatus = mstatus;
 
     /*
-- 
2.40.1


