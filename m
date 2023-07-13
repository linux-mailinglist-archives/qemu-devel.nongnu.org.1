Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F0A7519F6
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 09:30:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJqlL-0001ow-UO; Thu, 13 Jul 2023 03:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mborgerson@gmail.com>)
 id 1qJqlJ-0001oc-M1
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 03:29:17 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mborgerson@gmail.com>)
 id 1qJqlI-0002pg-0t
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 03:29:17 -0400
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-4faaaa476a9so678742e87.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 00:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689233353; x=1691825353;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9ZC5/qSllNpAv/47ssSnEZAmriPd+4d3s4euw2qO4b8=;
 b=PermYG/IiLjglN5WZYsNGxaurH43wO5K6PJ5NFQJd3Cn5xQDd/wmRMsC3z2rO73iCb
 oOMLL1/9v5j2zUwZcQw1PqDWJS+Xl7d8T+fJlJyIn5+MeP1seMyM002rwUPoY4Q/JT1T
 KlEwRJCYlo8BhBbw0bqnE59VZwHnQoUpGgkPBvsaXQt9t1PlLWeMPGDkD6b8ScGoMc3q
 LOiFqn2eiqzziemdfDS5arDiN3Hg+WR+7OsxOE1hQU2pFgSjbKAMxTsWhnIgrqC91I0K
 T/yHOxfr/cGFNK5QMp2z7W5aT1wBh6c98VSUbuAK2pijfkVZf4Os6N9E2dq8Z8eENRNR
 ce8w==
X-Gm-Message-State: ABy/qLZyOdEwbIYpyB4S2JGzJgB0EEuf4zDQ8WNIkgvQ5QMQDyby4uGE
 J+FIoostvhs5cVMR7el4f5vo1/5ynOE0TA==
X-Google-Smtp-Source: APBJJlH8mwAp7i9rOzOzteD2lRaIOh6Yu5zitaDFKMGSqfFUOua8RLwH7W6dkpT6ynkNatdP8+S3Ew==
X-Received: by 2002:a05:6512:3143:b0:4f8:67a5:94df with SMTP id
 s3-20020a056512314300b004f867a594dfmr503967lfi.15.1689233352782; 
 Thu, 13 Jul 2023 00:29:12 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com.
 [209.85.167.51]) by smtp.gmail.com with ESMTPSA id
 z7-20020ac24187000000b004f26d63f823sm1010321lfh.237.2023.07.13.00.29.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 00:29:12 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-4fb73ba3b5dso695229e87.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 00:29:12 -0700 (PDT)
X-Received: by 2002:a2e:9ed3:0:b0:2b4:47ad:8c70 with SMTP id
 h19-20020a2e9ed3000000b002b447ad8c70mr649029ljk.11.1689233352288; Thu, 13 Jul
 2023 00:29:12 -0700 (PDT)
MIME-Version: 1.0
From: Matt Borgerson <contact@mborgerson.com>
Date: Thu, 13 Jul 2023 00:29:01 -0700
X-Gmail-Original-Message-ID: <CADc=-s5F10muEhLs4f3mxqsEPAHWj0XFfOC2sfFMVHrk9fcpMg@mail.gmail.com>
Message-ID: <CADc=-s5F10muEhLs4f3mxqsEPAHWj0XFfOC2sfFMVHrk9fcpMg@mail.gmail.com>
Subject: [PATCH] target/i386: Check CR0.TS before enter_mmx
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.167.51; envelope-from=mborgerson@gmail.com;
 helo=mail-lf1-f51.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

When CR0.TS=1, execution of x87 FPU, MMX, and some SSE instructions will
cause a Device Not Available (DNA) exception (#NM). System software uses
this exception event to lazily context switch FPU state.

Before this patch, enter_mmx helpers may be generated just before #NM
generation, prematurely resetting FPU state before the guest has a
chance to save it.

Signed-off-by: Matt Borgerson <contact@mborgerson.com>
---
 target/i386/tcg/decode-new.c.inc | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 46afd9960b..0ead1c6011 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1803,16 +1803,19 @@ static void disas_insn_new(DisasContext *s,
CPUState *cpu, int b)
         }
         break;

-    case X86_SPECIAL_MMX:
-        if (!(s->prefix & (PREFIX_REPZ | PREFIX_REPNZ | PREFIX_DATA))) {
-            gen_helper_enter_mmx(cpu_env);
-        }
+    default:
         break;
     }

     if (!validate_vex(s, &decode)) {
         return;
     }
+
+    if (decode.e.special == X86_SPECIAL_MMX &&
+        !(s->prefix & (PREFIX_REPZ | PREFIX_REPNZ | PREFIX_DATA))) {
+        gen_helper_enter_mmx(cpu_env);
+    }
+
     if (decode.op[0].has_ea || decode.op[1].has_ea || decode.op[2].has_ea) {
         gen_load_ea(s, &decode.mem, decode.e.vex_class == 12);
     }
-- 
2.34.1

