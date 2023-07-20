Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 279DB75AF7C
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 15:16:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTVF-0003eh-No; Thu, 20 Jul 2023 09:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMTVC-0003ds-SB
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:15:30 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMTV7-0008NP-CA
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:15:30 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31716932093so618258f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 06:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689858923; x=1690463723;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DJagqy899cqfJ8F6MPMb/Z/P3ROJgtL4fWrjBNYenT0=;
 b=a8cbXO4JNyXWaA6+i/OpFHEBUtHpvzlVJNqJmeEiu4XpkMvRSM4aT1HqMcT2zSygca
 mO63bYeM+yiymNC2T9qj4FEMjDvm+ThfNeClxgzqWNtMshBJlZqa4XS22NXUgi7u+1XT
 2ZWgoQjABuSWsgnXWKKbDPIRJ2DDA1Ffi+Z7+wZRRA9iHVvh9dQwo8TX5MNDz5Y5YXti
 PTGrT+b9yFwHEa4cXHU2+no8OoTgiAeA6W46is6p7nHMx2Wwizp4Sl5vgXM4ilVcd6PO
 /mxx7UAUFjNWALgRFcBwNfnCWO0SFM13cm7ujiE/x4diVK2wh5tMw2JZHauE4wluppzi
 0Oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689858923; x=1690463723;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DJagqy899cqfJ8F6MPMb/Z/P3ROJgtL4fWrjBNYenT0=;
 b=GlBh6YAmRNRyPpuPjkVIbN2C96utknDtIu22JgMCWIJIRzhvnIYwaOsTbcbHaMB/iD
 SsMw2OVFYjSteLAuctQz8ehoD4Zh7cXCSZkII4hkaoZ1UW0ZGwD1jOyikZy8K5tToXQG
 2ffAPmrYjQPZDmsd3WkP9qWMu7OyOVsvThw8LEJWVqsu3HNEDOqdrtRKBhxk5p93KiBo
 A/24yz3VonzRYYD3ui6mw+GU++YEO0/C/S7s5Q4H0rJBRuXezTHlsQe37gOVURALQBGz
 H0A63mWM5esQxpRy+Pyir3oVqG90oM1DAV1iZOEb36fdX2UP547vuxzF+dX4lYavY2Iu
 pz7Q==
X-Gm-Message-State: ABy/qLbAy+aeVemddqxWdaYS+slg+JAR8G3lUW593S5EI2rmTdtg2bch
 zw1yMBHe9CWq5jkCgTJPeU7LjoJD9LqJ5I+Z/Ko=
X-Google-Smtp-Source: APBJJlHSZ16kKL1IhA4MFAHBnM9G+yvPoMlwmrW2kZxeUd5I6NqXpp4AALWFxCu/ngIu3jZ92S1rVw==
X-Received: by 2002:a5d:44cd:0:b0:316:f25c:d0b3 with SMTP id
 z13-20020a5d44cd000000b00316f25cd0b3mr2037215wrr.22.1689858923465; 
 Thu, 20 Jul 2023 06:15:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p15-20020a7bcc8f000000b003fbfef555d2sm3882080wma.23.2023.07.20.06.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 06:15:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] tests/decode: Suppress "error: " string for expected-failure
 tests
Date: Thu, 20 Jul 2023 14:15:21 +0100
Message-Id: <20230720131521.1325905-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

The "expected failure" tests for decodetree result in the
error messages from decodetree ending up in logs and in
V=1 output:

>>> MALLOC_PERTURB_=226 /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/python3 /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/scripts/decodetree.py --output-null --test-for-error /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/../../tests/decode/err_argset1.decode
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― ✀  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/../../tests/decode/err_argset1.decode:5: error: duplicate argument "a"
―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 1/44 qemu:decodetree / err_argset1                OK              0.05s

This then produces false positives when scanning the
logfiles for strings like "error: ".

For the expected-failure tests, make decodetree print
"detected:" instead of "error:".

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
My initial thought was "just get meson to suppress stderr for these
tests", but AFAICT meson has no way to do that, and we already have a
command line option to decodetree to request specific behaviour for
the tests that expect failure, so this seemed simplest.

 scripts/decodetree.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index a8a6cb69cda..e8b72da3a97 100644
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -134,6 +134,10 @@ def error_with_file(file, lineno, *args):
     global output_file
     global output_fd
 
+    # For the test suite expected-errors case, don't print the
+    # string "error: ", so they don't turn up as false positives
+    # if you grep the meson logs for strings like that.
+    end = 'error: ' if not testforerror else 'detected: '
     prefix = ''
     if file:
         prefix += f'{file}:'
@@ -141,7 +145,7 @@ def error_with_file(file, lineno, *args):
         prefix += f'{lineno}:'
     if prefix:
         prefix += ' '
-    print(prefix, end='error: ', file=sys.stderr)
+    print(prefix, end=end, file=sys.stderr)
     print(*args, file=sys.stderr)
 
     if output_file and output_fd:
-- 
2.34.1


