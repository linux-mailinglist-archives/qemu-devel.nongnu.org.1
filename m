Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB957548FC
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:56:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfiy-0004WW-QB; Sat, 15 Jul 2023 09:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiN-00045L-Hh
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:40 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiL-0001HN-BR
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:39 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3144bf65ce9so2840237f8f.3
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429216; x=1692021216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GYIDC6C9sVxFY0DlBpogq7e8qtq1Fq4gc1frrPqq0IQ=;
 b=Z5jQet2dyrtANj7hJTmkFGdhPyQZoOehgxlVV/uUMWSl0IAY7v7/nvSOCnkt7AUtFg
 pQjwEwYkWl5jYH9mZRvRRkkuSybkJqS25mR+YMg8NNNYHVKc20SQvkkkvy1J5yqJCf7A
 yJy1ZEaF0MxCxEur+2tzo/cCrHEyrrnmUFk4gaM5lZ+wGyNcnakWryHps+r5CB/8K8zn
 AB7bONfe+GJyzFZZgye7acg7s8GdZjs+vaNKa3Z/v5Zco1j3JkGUH9U0GN84s/FIOuox
 e2v9lNoirwjg/uP1KRHpn5DttVlX2tlnDgOVpOkBlld8YSW9PWmV2gu6lFNhaOBO0KKc
 wBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429216; x=1692021216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GYIDC6C9sVxFY0DlBpogq7e8qtq1Fq4gc1frrPqq0IQ=;
 b=StH6YHyX+D6orUVfqpWy4/oMuYKsqpQ8tSeM4iQGTH8gUnJlPTSoCLJqq0jb4OIh8p
 7NrOMqXsyDBRTncOMwaM+RvdgF9A7d6Av0Y03HefB49YNSHav5RdTkNXilDCGXhhnSl2
 dIsAIy1Gj0Tnr9WV+AVRrFL1sZuNNULqycwZ/w1qlKNoJRqlOfKaDYMVELqB8GN/ARJp
 TaWbCEOV3N30Cqz283O/Sd7CDP6RxBNMgALd+uSjDXtOP7Hsf0nTb1a9u2eC7QHU6VTO
 IXurcG7ohUeu6jNM4iOOAj/9VEdupxyet8BKN2+QlkwNDXcgWuWA5tZWLdDuhE1kcRjf
 raLw==
X-Gm-Message-State: ABy/qLaz5DDDyigT88Tk32NaCa3j95aA52LIAFUEXsy/jwZZUVbSXtfK
 3qkNtqdrzMWcrsSv8X4ANTC0QOpWvL9hIBKt8BHLNQ==
X-Google-Smtp-Source: APBJJlEi01WudE9tNs+kjNB7ANaBpj1TOXXQOxxUJ/ctF2+XASN+GCVhgAEBfUxGARuY6AgH/PuZzQ==
X-Received: by 2002:a5d:670e:0:b0:313:ee3e:50c5 with SMTP id
 o14-20020a5d670e000000b00313ee3e50c5mr6190431wru.20.1689429215894; 
 Sat, 15 Jul 2023 06:53:35 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andreas Schwab <schwab@suse.de>
Subject: [PULL 20/47] linux-user: Make sure initial brk(0) is page-aligned
Date: Sat, 15 Jul 2023 14:52:50 +0100
Message-Id: <20230715135317.7219-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Andreas Schwab <schwab@suse.de>

Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
Signed-off-by: Andreas Schwab <schwab@suse.de>
Message-Id: <mvmpm55qnno.fsf@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b78eb686d8..02d3b6c90a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -806,7 +806,7 @@ static abi_ulong brk_page;
 
 void target_set_brk(abi_ulong new_brk)
 {
-    target_brk = new_brk;
+    target_brk = TARGET_PAGE_ALIGN(new_brk);
     brk_page = HOST_PAGE_ALIGN(target_brk);
 }
 
-- 
2.34.1


