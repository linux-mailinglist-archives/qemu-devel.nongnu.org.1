Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 448397D3EE0
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:17:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzQy-0005X8-J0; Mon, 23 Oct 2023 14:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQs-0005UN-DL
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:42 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQm-00085H-Cq
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:41 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5842c251d7cso1760757eaf.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084815; x=1698689615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kj+TKk2K3WfpkaNPPr/v3KoLmzqb4EREhy9sjMrwx20=;
 b=one66qpi95XCTW+FH9knVwkLj8dYV74LKPb15HOGn4Z5OwzkaJC8QeXbQGZtJqL9jo
 tVVzUZMuZo6oxxz4edWDIo2zjfQPkomEZErtT7aClnEv3+1PC757rrhieM6GZPnke23g
 zndSSKS8OtiiQw3amCjKIz0drEPa87MIPjwmN4ARyFGmNpetB257XYX3XMNII/t6PUDY
 QzUaIHEgzlFE6JhJU8vICRg8EiyQXTXTix7b9dBugeqRUR1GcXMHiYdk0DZ2ZlkNe9z5
 pm8PDYrRIhxQ0hyeLhuLNNws+3baLUlpm58KyxhLswshMXH+9kvXZYESgRwoZH2vXs9+
 pnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084815; x=1698689615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kj+TKk2K3WfpkaNPPr/v3KoLmzqb4EREhy9sjMrwx20=;
 b=YNKMA+PAkEinXuNcB/hqMAQzntnXQtPrzJFe1DRWK5rVVLS3EEndH7qDiIJzY9jUFF
 QdJts7ijyfmzOly9HPjTX1FMQLsQFVSulg7mGIno1kOR5ljKkhTZB2w9WJVHkhdyjotL
 RVG0SQs6DOtGi2HM6cYp173ZuxoN9YE68DIojlgKweByjyuk7qOU4A5OSCX6N/whrPlf
 g2i+6ZP99tPXj+iWFFJ8GcIxZeMYt5lJU7ElTWUu7WLq8YxbxFWmVd2fIwgWEUwtUgoX
 /aBZ90hEXw1ZXDN8Z2ajU7MGESwGqgj/NGyqaUEBNF+wpJx9Oq+DcXK2MkOHOOp7Dqws
 rdfw==
X-Gm-Message-State: AOJu0YzcqDmAwiO5MgeOOmjfNWW55Wfqmix7EEmkr+T8cfOgqX4cj+KV
 qFV7jICcuHKOb6s7zmw7pgbUn6uFYFSu++NJbpw=
X-Google-Smtp-Source: AGHT+IGzQKuf4P3l5Gs7tnIuKE5whQF3yImuoEe9cXzopwmOYS4BM3ClQyTwc6gpwztEuCMA9vBnJA==
X-Received: by 2002:a05:6358:6e93:b0:168:e592:f8d2 with SMTP id
 q19-20020a0563586e9300b00168e592f8d2mr2405493rwm.25.1698084815312; 
 Mon, 23 Oct 2023 11:13:35 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 05/38] tcg/ppc: Use ADDPCIS in tcg_out_movi_int
Date: Mon, 23 Oct 2023 11:12:56 -0700
Message-Id: <20231023181329.171490-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index b0b8cd2390..226b5598ac 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1055,6 +1055,19 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
         return;
     }
 
+    /* Load addresses within 2GB with 2 insns. */
+    if (have_isa_3_00) {
+        intptr_t hi = tcg_pcrel_diff(s, (void *)arg) - 4;
+        int16_t lo = hi;
+
+        hi -= lo;
+        if (hi == (int32_t)hi) {
+            tcg_out_addpcis(s, TCG_REG_TMP2, hi);
+            tcg_out32(s, ADDI | TAI(ret, TCG_REG_TMP2, lo));
+            return;
+        }
+    }
+
     /* Load addresses within 2GB of TB with 2 (or rarely 3) insns.  */
     if (!in_prologue && USE_REG_TB && tb_diff == (int32_t)tb_diff) {
         tcg_out_mem_long(s, ADDI, ADD, ret, TCG_REG_TB, tb_diff);
-- 
2.34.1


