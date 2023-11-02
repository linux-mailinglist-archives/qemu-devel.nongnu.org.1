Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 918987DEA41
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:41:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMYP-0005ww-Qw; Wed, 01 Nov 2023 21:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXq-0005nB-QH
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:50 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXm-0001d4-2P
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:50 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6b7f0170d7bso500238b3a.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888644; x=1699493444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nte4AsF0yU49KoFZ5WsKrCyyvXp9Hm4i6B93/Stt4MI=;
 b=t74CW5XJVVNILjGbhgKul5NCO117c2wmycQ2xuO5E1Qy3ksV8FwjyphQ1N9yqBuuN6
 Ms1A8TrIkN3ZdVnUt8JQEzwOulRS9D4hp9KpAbdOSuewXINwQeEcQde6CY/fmsEd9ZNs
 0Dz2ZeI412uA49SBvnMHcA3J6D3dPfaA3/GcNyrzFWyTWbVEATbQ1S12ynlT5ndkBATm
 ts4bH/N6+5CVbTe+Bv5RRMQAW+qxvtTn1sR7Sll84+SZ8vG8u+jWwESsPrdqmb8NIeGt
 3AQJlv7ynMgoPlh3WsFyNfYualJlVe04fPbwri+8GfbKpa5gM18EBjUbMM6DwpsfvCCe
 cafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888644; x=1699493444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nte4AsF0yU49KoFZ5WsKrCyyvXp9Hm4i6B93/Stt4MI=;
 b=QR7tq+4lg9EHXXh7xblF1H1KnvjkwQQ6NI58Nbh3idFKd+rO272ayIa2E4LOr1pGJ9
 fzA+cjSBvaPtspMvcOb8OmtniyVjgtuMX2rStkmkkvoFtfzoP50Vm2VyYJOz2lyVdDdb
 oQHPSsUbpa/icRhf0OynxJg+NA95goncTWbDjbXSUhgiCi/W5j8kPADZBgxjzlyic9Xx
 zrw2nCmwTxTKoMvsduOhX641VcJ/cs6BKIkyn3KI3kxBt1u5lUx6ImwW4yNpgAmFQkeQ
 UFC+Q7kbaKr9PEk6jA5q337Z34Dy1vr1sSLQkc5VrfnMyXrXT/x5PztC/y3Vs0fp7cOa
 cG3Q==
X-Gm-Message-State: AOJu0Yypo7R23yPD/uPqqB/9GMUYlW30Q1/dn2NeoyGVXnUg34MDFG6q
 4saM1fMqVsBuV5GIkTI9SnCIyvjvJA/+25K09Es=
X-Google-Smtp-Source: AGHT+IErGCCpJLdc7+zB1kDcXLBdrhS1VnfCVdZquN3m6p5CBYOn6x77GQOU1ZshsUxaYHR1DgvFcg==
X-Received: by 2002:a05:6a00:856:b0:6be:23dd:d62c with SMTP id
 q22-20020a056a00085600b006be23ddd62cmr21950112pfk.2.1698888644583; 
 Wed, 01 Nov 2023 18:30:44 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 29/88] target/hppa: Use copy_iaoq_entry for link in
 do_ibranch
Date: Wed,  1 Nov 2023 18:29:17 -0700
Message-Id: <20231102013016.369010-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

We need to make sure the link is masked properly along the
use_nullify_skip path.  The other three settings of a link
register already use this.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 348fdb75e5..c2db2782f4 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1898,7 +1898,7 @@ static bool do_ibranch(DisasContext *ctx, TCGv_reg dest,
 
         nullify_over(ctx);
         if (link != 0) {
-            tcg_gen_movi_reg(cpu_gr[link], ctx->iaoq_n);
+            copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
         }
         tcg_gen_lookup_and_goto_ptr();
         return nullify_end(ctx);
-- 
2.34.1


