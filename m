Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2819B7D178B
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:51:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwOr-0001nC-To; Fri, 20 Oct 2023 16:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOo-0001h6-A0
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:14 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOm-0001AF-Ou
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:14 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6b36e1fcee9so1239532b3a.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834831; x=1698439631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eb3lHT3qpP27fmh9TI6JGY9d7TBx7N43aA+xXi4r9Co=;
 b=TFs8g1IMaDKU5O77WWQ5PquWmkqvplZs54zCixeiBIkSuWfAqoqvikGQLymYvw7iI+
 sMi4/5MIDeDLi6w4Govl9wLZ+HppFEh0wLcVS+1C26pT8ORVjmPfTOowhBIfn5SQ3/9u
 R9DHwZIDKakdFO12PKP7Wd0SEj7kllKTT064EV4Juv0icw574kpBp3YsVB12E4VWoMwR
 30eZmyTECWNSYdugi44ssuTn1TOSXE5e1t7HnKpyUbZzBgnCoL+eAqYZH7QtBHQZwBUe
 FURx/RDKdIT0wMDW7sRJS7HzYdlaUKLlTk8VTUezvQaWhiiZDMy90gyxQYHl2WEujnf1
 nwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834831; x=1698439631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eb3lHT3qpP27fmh9TI6JGY9d7TBx7N43aA+xXi4r9Co=;
 b=n29p04AVBqCHaUAvqithDmZADlvXZV3RTf2GGiG91XK/s4epiS+lxOPz6HXxMJEKri
 7+zValMzKDQdAgNMBW8sjRHXzzumH57j1Opji7lkH9NKaPqTzPtMBQJWSPqurCzsyJXW
 QECppOrB3fE+48cFaZnWxr/ix01wWLFYzKSVuEEERbsvXRtLzx+BDw9XviVIprMm0Lib
 x904ZtlpfFmgo2KTdtJaggKKK8Vae9d93IBj4YqfB1zovCzzoC2vNkgcixH5/9cI0aiO
 EPYVdZLpNofw182FIECyRy/khJT8GFIgObalJIhhgPUaXp0cZJNtSz2JQ1sE/Ux5rBfu
 5r5A==
X-Gm-Message-State: AOJu0YxGswlB74Aa6Nbo0jwZSuqlcDCDk3LhFZMUpP8UdHeDxiD2p/S5
 2ER2Sc0FpKnzb+3bZjPbeDLx0oRPqbTQWiD7+xI=
X-Google-Smtp-Source: AGHT+IG4yKJYOGUNP9IlchSxtzOqeKdDjQdQsdVhUx91FzMmiMx6RDbTAUK7GvoCQksyuYfv7/vCWQ==
X-Received: by 2002:a05:6a20:7fa5:b0:15e:b8a1:57b9 with SMTP id
 d37-20020a056a207fa500b0015eb8a157b9mr3609527pzj.24.1697834831469; 
 Fri, 20 Oct 2023 13:47:11 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u7-20020aa78487000000b00694fee1011asm1946775pfn.208.2023.10.20.13.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:47:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 43/65] target/hppa: Implement CLRBTS, POPBTS, PUSHBTS,
 PUSHNOM
Date: Fri, 20 Oct 2023 13:43:09 -0700
Message-Id: <20231020204331.139847-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
 target/hppa/insns.decode | 2 ++
 target/hppa/translate.c  | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 6f0c3f6ea5..ba7731b517 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -381,6 +381,8 @@ bl              111010 ..... ..... 101 ........... n:1 .        &BL l=2 \
                 disp=%assemble_22
 b_gate          111010 ..... ..... 001 ........... .   .        @bl
 blr             111010 l:5   x:5   010 00000000000 n:1 0
+nopbts          111010 00000 00000 010 0---------1   0 1    # clrbts/popbts
+nopbts          111010 00000 ----- 010 00000000000   0 1    # pushbts/pushnom
 bv              111010 b:5   x:5   110 00000000000 n:1 0
 bve             111010 b:5   00000 110 10000000000 n:1 -        l=0
 bve             111010 b:5   00000 111 10000000000 n:1 -        l=2
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 05fe5bf7fe..4dccaff687 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3746,6 +3746,12 @@ static bool trans_bve(DisasContext *ctx, arg_bve *a)
 #endif
 }
 
+static bool trans_nopbts(DisasContext *ctx, arg_nopbts *a)
+{
+    /* All branch target stack instructions implement as nop. */
+    return ctx->is_pa20;
+}
+
 /*
  * Float class 0
  */
-- 
2.34.1


