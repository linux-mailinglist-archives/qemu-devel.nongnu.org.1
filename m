Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2927174E4
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:12:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D7X-0004cs-Gk; Wed, 31 May 2023 00:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D7A-0003Ak-Cu
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:07:13 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D78-0006w2-NO
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:07:12 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-64d1a0d640cso3930356b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685506029; x=1688098029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PRmXJMFN3rYya2LUNfLtjvM1yMLdoZFGjXY4lJtw1jE=;
 b=zp93nkUCckeyJ6CTj6+4twkpRAlm8KmW6ciuuTW6Yv/1s+MTo2hgmrGytJaukl5+Ia
 nrHF908sH9MbkEIUcfdDI+eBDWs5ZEKIHRdRiSPx43D4D0C7WvF+zU18mAmHv3BXUkMk
 HX6aZCFFEPEZy/3WIDQyWXbHCZwXHkewBbe12WAz0pjU+nkzwku5qK0/Zev9B39mYm7v
 Scgs7IrNxgJBvcsLDdf67FAw4NRUkX4LGqwlB3VE70YPwDKMqSveFGFIbd6A6kPa6Sd3
 SGwgKEeRKUplb0/3TiAcyoTlSd+DW5Tj2V27RR0TiuQ5wtCFsA5gDVnxgSjx4vQ0B3kw
 L92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685506029; x=1688098029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PRmXJMFN3rYya2LUNfLtjvM1yMLdoZFGjXY4lJtw1jE=;
 b=BKE5BmWlyoN/Xn5ZeixFcgwTpwF6JrQzvxdle0VvZu704KSlm3646xeGFL1iqAVT83
 0VLli0SiKTv1+naUnh/JjnIadEpDh08UFuCvKm6XbsB+tXY9PA+m52thvk/bi/WrS578
 rTc/5MGtFA+s5eyqV8m4mr77XtnEifPeGwkaEJ6IX8B64Fn1fj80vxb9RkDM/7eqUv0r
 RLJ99+reiZ0euXxQlINY9MkP9RLpliVIoNTTqneMacHDYJKRHd5kVKOtYD1k7bXAIKbN
 45tW4/FM/3T/UFaccfLqcm37TZZJgcHEuKj0OrnnEsvoVN7oKW/4HM/+vUzzuHHqOrxl
 1WBw==
X-Gm-Message-State: AC+VfDwd+NpG0WDrVfBfA7u2kR5lmeNv36O83ql4+5aTn8JqSiUDU4FT
 xRebHZKJQmXQfTUP/XX66NsHR8ttVh8am6KOZec=
X-Google-Smtp-Source: ACHHUZ7dQOaOV07Tx04ML2OD9QJy1iksbOWyisKViTeISjEkW1hpCipYptev7yLGssRRRzUUA2G7IQ==
X-Received: by 2002:a05:6a20:a109:b0:10b:6698:769d with SMTP id
 q9-20020a056a20a10900b0010b6698769dmr4846923pzk.11.1685506029094; 
 Tue, 30 May 2023 21:07:09 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a170902f7cd00b001aadd0d7364sm151797plw.83.2023.05.30.21.07.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:07:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 47/48] exec/poison: Do not poison CONFIG_SOFTMMU
Date: Tue, 30 May 2023 21:03:29 -0700
Message-Id: <20230531040330.8950-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

If CONFIG_USER_ONLY is ok generically, so is CONFIG_SOFTMMU,
because they are exactly opposite.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/poison.h         | 1 -
 scripts/make-config-poison.sh | 5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index 256736e11a..e94ee8dfef 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -85,7 +85,6 @@
 #pragma GCC poison CONFIG_HVF
 #pragma GCC poison CONFIG_LINUX_USER
 #pragma GCC poison CONFIG_KVM
-#pragma GCC poison CONFIG_SOFTMMU
 #pragma GCC poison CONFIG_WHPX
 #pragma GCC poison CONFIG_XEN
 
diff --git a/scripts/make-config-poison.sh b/scripts/make-config-poison.sh
index 1892854261..2b36907e23 100755
--- a/scripts/make-config-poison.sh
+++ b/scripts/make-config-poison.sh
@@ -4,11 +4,12 @@ if test $# = 0; then
   exit 0
 fi
 
-# Create list of config switches that should be poisoned in common code...
-# but filter out CONFIG_TCG and CONFIG_USER_ONLY which are special.
+# Create list of config switches that should be poisoned in common code,
+# but filter out several which are handled manually.
 exec sed -n \
   -e' /CONFIG_TCG/d' \
   -e '/CONFIG_USER_ONLY/d' \
+  -e '/CONFIG_SOFTMMU/d' \
   -e '/^#define / {' \
   -e    's///' \
   -e    's/ .*//' \
-- 
2.34.1


