Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3407B70F1
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 20:33:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkAq-00081V-Fk; Tue, 03 Oct 2023 14:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAm-0007xH-1h
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:08 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAg-0001eE-Qd
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:07 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-694ed84c981so978479b3a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 11:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696357861; x=1696962661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MeJK52obcjftsHra4OOU5xIwq9R14g84P4JBuSuP22k=;
 b=th4i0MyO/UplOqIOh+M7Q9kvnw1MY1IlMVsa0/O/pZmDaYaWyk/VB9cZ786PfQ3MYF
 JEghl1v/ux1OsvIRtE9LvFspAqhxWPs8SCCIKbvkh8bIhEdgDE7F62kbCfTlrJnI4QmF
 5DavCrnh5aQ9PIHjePDvE88ZD3DpGyyec65tXAUAnBb+MoCS+5a9gIZKV8pQQQ3PzdBZ
 ZgzUWQITN7TPB9lPz0e44InJLz6DqcvuhOyGeuvRg8QbNXCBFU3QhaaEetU5PrWW79v+
 S7OleuENFhdkPJ9WvSY5M9bMLECsYgKyfHHaJ8qJjnOgAi8rhmXMT0vtxMNcQC++lGDB
 xtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696357861; x=1696962661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MeJK52obcjftsHra4OOU5xIwq9R14g84P4JBuSuP22k=;
 b=tFL6AamKS5yFofkqVjXUZ220XE+672hseb2V0PstUxW3+BTOh85S+U9FSocb8lV6Dk
 CNqkFvQXSZvZ3mCWwqCL+q1NkhUJnX89NuMt92CmcgPpPZA92NuKeBM01dZBRoN96lav
 nTJ3vSG9Z0UHSWOstxVB7tYKMNBZ0iaUCOnTH2GifQ3GviI+TUU9rIVbuzPwI0cXhSsi
 M9oENogY3REbRXF0j+YTbx1hOhgK0NPOatrQw9qpw+jU9J8yW3V3IBUk8LTD3i272pHs
 hGh7K3ommScIDyx/OS5gA/IcsMnbFon3Wc/RABYsgJQNLF2dUZlJGRX/CgoA1qauYgo3
 KdLQ==
X-Gm-Message-State: AOJu0YxF5B/6RBn8QCytSOoqoKE0q5ENNwfazooAk7bO1d0dkbuyspff
 l9CCLggvmMPM/tfrpFU/f9Zo/PpgW+xzKt+mrtI=
X-Google-Smtp-Source: AGHT+IFT70gZxXJNvAkE9lrOjoMrw7F3aykZGyzuYixGNQAbNklHoaELAw2RdqtUkKvuoEBFuACWKw==
X-Received: by 2002:a05:6a20:12d6:b0:15d:bc0f:9b64 with SMTP id
 v22-20020a056a2012d600b0015dbc0f9b64mr298632pzg.45.1696357861378; 
 Tue, 03 Oct 2023 11:31:01 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g7-20020a170902934700b001b7cbc5871csm1920432plp.53.2023.10.03.11.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 11:31:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: fei2.wu@intel.com
Subject: [PATCH v17 02/16] tcg: Record orig_nb_ops TCGContext
Date: Tue,  3 Oct 2023 11:30:44 -0700
Message-Id: <20231003183058.1639121-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003183058.1639121-1-richard.henderson@linaro.org>
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Remember the value of nb_ops before optimization.
To be copied into TBStatistics when desired.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 3 +++
 tcg/tcg.c         | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 82b4625773..e49574b7c7 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -564,6 +564,9 @@ struct TCGContext {
     uint16_t gen_insn_end_off[TCG_MAX_INSNS];
     uint64_t *gen_insn_data;
 
+    /* Used by TBStatistics */
+    int orig_nb_ops;
+
     /* Exit to translator on overflow. */
     sigjmp_buf jmp_trans;
 };
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 71c25f1974..e90b0a0c69 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -5924,6 +5924,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     int i, start_words, num_insns;
     TCGOp *op;
 
+    s->orig_nb_ops = s->nb_ops;
+
     if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP)
                  && qemu_log_in_addr_range(pc_start))) {
         FILE *logfile = qemu_log_trylock();
-- 
2.34.1


