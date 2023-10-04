Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFD97B7EA7
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:06:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0bk-0003s4-TL; Wed, 04 Oct 2023 08:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0ZW-0000Sk-1B
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:01:57 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0ZT-00019H-3J
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:01:44 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3247cefa13aso1856535f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696420901; x=1697025701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S8wZ57nmGBju5vDKBp5SHeeONo30+tUOfUJLJWu5rBM=;
 b=ASPt7McQQhoErHzFzwBk8oTN7THDTc0MAKq5S0f7aWfy+v75jGvkk+zU7cshZne3X8
 tJcxUoRN4zs4wTFyN7/T8jFo8Qcwwrv/cBnVaktOOsgzxlurJJd/aDghhUhqCFowKTWH
 56NHZqTIMTCMncT1Bbxw+oOjnTGLHJxXBz70e/TagiBM5JbCJlIwVwaQGlgrtvkPyCk6
 CbtUajBlmaUzve7Mc0Nie/Clbfm00G+lIlexVWvZ79Rc3zgTHU8DW90IzqnghEC6riBc
 OPhUgj2B62kNNGb+QBiZ+0AInDYAbPdJf/beh0bY+6OwaiPb2ND68eFUY9SJRNtfeGRG
 u4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696420901; x=1697025701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S8wZ57nmGBju5vDKBp5SHeeONo30+tUOfUJLJWu5rBM=;
 b=R58BULKq9w040ho7a11kdMTc4IwM75zzzsJJ9tGM6pm30GmJnAmsSJ/a39THwM+B8z
 LnlO+hQ75e9KkuDAPEc0FvntrOmMux/x3Er8T+iqnRrHsQtPig/jBGiFGcaij0DqLsJU
 CRyAiZA0bAbfJvryIp0B4Ou039oeykGZl7HfrMrHTMkJlGIfqdmquZkJQGRuxOW0ysxx
 Qmp51KS8EOgXuVrS4UzpCQqy/bVM7JzPstgCQnBeiemBGHIsA3xEXieZFPB3TugeRS6f
 sEbdaFTY18LKGNaWM6p5m92zNuezdLwjBGUYaW+CCxA5I5x/AmSR67nCQfy8b2OF+bFK
 jODA==
X-Gm-Message-State: AOJu0YwStMe0CJaqEzn+fAjkIA+uzf+P1qcD+t3u02k36jqgRNGGhdcV
 4xnw7ymls8qcxndP/WIrLlA5Z5OelK6NWRTK33w=
X-Google-Smtp-Source: AGHT+IFh+h1QITEFymxYa1mOeXdp4CFUuSTFG1pWVC2Am6MR4oBUKGoOgn/svtx/ldDdjHOHYkiPlQ==
X-Received: by 2002:adf:e6ce:0:b0:31f:b7b2:d4e1 with SMTP id
 y14-20020adfe6ce000000b0031fb7b2d4e1mr1846346wrm.20.1696420901110; 
 Wed, 04 Oct 2023 05:01:41 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 j14-20020a5d464e000000b0031f8a59dbeasm3816870wrs.62.2023.10.04.05.01.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 05:01:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 13/16] semihosting/arm-compat: Clean up local variable
 shadowing
Date: Wed,  4 Oct 2023 14:00:16 +0200
Message-ID: <20231004120019.93101-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004120019.93101-1-philmd@linaro.org>
References: <20231004120019.93101-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Fix:

  semihosting/arm-compat-semi.c: In function ‘do_common_semihosting’:
  semihosting/arm-compat-semi.c:379:13: warning: declaration of ‘ret’ shadows a previous local [-Wshadow=local]
    379 |         int ret, err = 0;
        |             ^~~
  semihosting/arm-compat-semi.c:370:14: note: shadowed declaration is here
    370 |     uint32_t ret;
        |              ^~~
  semihosting/arm-compat-semi.c:682:27: warning: declaration of ‘ret’ shadows a previous local [-Wshadow=local]
    682 |                 abi_ulong ret;
        |                           ^~~
  semihosting/arm-compat-semi.c:370:9: note: shadowed declaration is here
    370 |     int ret;
        |         ^~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 semihosting/arm-compat-semi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 564fe17f75..0033a1e018 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -367,7 +367,6 @@ void do_common_semihosting(CPUState *cs)
     target_ulong ul_ret;
     char * s;
     int nr;
-    uint32_t ret;
     int64_t elapsed;
 
     nr = common_semi_arg(cs, 0) & 0xffffffffU;
@@ -725,6 +724,9 @@ void do_common_semihosting(CPUState *cs)
 
     case TARGET_SYS_EXIT:
     case TARGET_SYS_EXIT_EXTENDED:
+    {
+        uint32_t ret;
+
         if (common_semi_sys_exit_extended(cs, nr)) {
             /*
              * The A64 version of SYS_EXIT takes a parameter block,
@@ -752,6 +754,7 @@ void do_common_semihosting(CPUState *cs)
         }
         gdb_exit(ret);
         exit(ret);
+    }
 
     case TARGET_SYS_ELAPSED:
         elapsed = get_clock() - clock_start;
-- 
2.41.0


