Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF1A738E29
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 20:07:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC2Di-0000GC-9D; Wed, 21 Jun 2023 14:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qC2Df-0000F2-BZ
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 14:06:15 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qC2Dc-0006uZ-NG
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 14:06:15 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51bdd6f187fso1425487a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 11:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687370771; x=1689962771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzQxtvCYu0WA3x6PRPKK8xlDLVLtN3Yi/AsYMLXAiqY=;
 b=IcKGbeDVFoTR0CWdVKMimaaIKf/wQV772tD+ve4JXyxmUDsWqSjxnTP06WuCayhBes
 tfofCPe8YUzFPLukr3XOIafNxvQz2QwF5faXmPug4cJTUJ2fO3AOstv6ap2alI6U//md
 zn+gerE+hERP7w2Y0UAUz0KXo1YC+HOR/aw1r3Uvukg8pDeXfrBxocoygYNGn6iLSnpk
 1YT5wCyRNRAJcK9hbTIgnsqqMwUYHHfQfgaZhcry30PKWZUhGdwb32sXPcihoP3CUAzK
 dm/RrZZ3osU2N7jPfj8ac9n2we5GeCTFmxlUlSbo5vBWOteBPXXCr5S16Fo58eu2DR2t
 pEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687370771; x=1689962771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RzQxtvCYu0WA3x6PRPKK8xlDLVLtN3Yi/AsYMLXAiqY=;
 b=Pby9Go72/8zmWFyQhYhi3SJzfZTJvKGH8LKQpeFSR6eyHekkjTmbgApXvndBwjnFFa
 7NYwyMxAM893jVwZCY9Xjk3p3isPknMFxHZH+vqDOWpqSjdQMl+MjT4qzOGJkMESv6eI
 D2e3e2Du5OXwghwIQSah4yOFQ5quRxvsxIEc7Wsgt/AewAvHYBIkOa/abe3Oau3u/+eX
 RBsX3hhbXulCCVpwCOMkZMsS25bZU4MpWk+DIZCI3Co8CrE0dS8/abhRkBjCOG9lcY48
 acbU5z43p2JpFvBG+giGZPwX21zVftVnrutsxG3bm8BftjMhuIc3k9rh7OVmLCPJgNU8
 uuDg==
X-Gm-Message-State: AC+VfDxq3+uMlGbBAjV+07ehkn1ick2FtrUNIhQjXvpr3To5eIExvDlw
 WW2VWDvY+RdHinB2gegMoSV6Km9i7sAtjvlbfA7WiAvM
X-Google-Smtp-Source: ACHHUZ5w5G/eOpeBebPlfzeAbTVUPNX5tQS135d1skV6z50jZbFU/lZlwiZZvwSl7zmrqOAdOeEpdw==
X-Received: by 2002:aa7:da90:0:b0:51b:de6f:2182 with SMTP id
 q16-20020aa7da90000000b0051bde6f2182mr2154343eds.8.1687370771092; 
 Wed, 21 Jun 2023 11:06:11 -0700 (PDT)
Received: from stoup.lan ([176.176.128.70]) by smtp.gmail.com with ESMTPSA id
 g9-20020aa7d1c9000000b0051495ce23absm2910944edp.10.2023.06.21.11.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 11:06:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 1/8] target/sparc: Use tcg_gen_lookup_and_goto_ptr in
 gen_goto_tb
Date: Wed, 21 Jun 2023 20:06:00 +0200
Message-Id: <20230621180607.1516336-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621180607.1516336-1-richard.henderson@linaro.org>
References: <20230621180607.1516336-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index bad2ec90a0..28d4cdb8b4 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -318,10 +318,10 @@ static void gen_goto_tb(DisasContext *s, int tb_num,
         tcg_gen_movi_tl(cpu_npc, npc);
         tcg_gen_exit_tb(s->base.tb, tb_num);
     } else {
-        /* jump to another page: currently not optimized */
+        /* jump to another page: we can use an indirect jump */
         tcg_gen_movi_tl(cpu_pc, pc);
         tcg_gen_movi_tl(cpu_npc, npc);
-        tcg_gen_exit_tb(NULL, 0);
+        tcg_gen_lookup_and_goto_ptr();
     }
 }
 
-- 
2.34.1


