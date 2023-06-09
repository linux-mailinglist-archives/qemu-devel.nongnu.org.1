Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F413D72A032
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 18:30:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ezM-0004sH-NW; Fri, 09 Jun 2023 12:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7ezJ-0004s3-Ju
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 12:29:21 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7ezI-0003QY-1i
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 12:29:21 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4f62d93f38aso2555333e87.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 09:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686328157; x=1688920157;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QdtNiuSZhg+5KnK2ViBDg+P4Ibn+zLdzYsmVmaZa+6Y=;
 b=YhdvN4qWCPnWP9x7hcQFF7yhRP6AlivNB2lnsGAa8PhKtuOawsmpI/PvyjxB07jHcJ
 UNby2MN6K456+7BqCWBy/ey23eEFT5pio+OuEchOA8zplF58f7faB8yNMXmIk0pgmzBb
 rVJwAyBC4nWQJUI0iUlUjAClebV31QmCGYsv1xWMD/shvG0hal4r5/Ed+EKGuJx8DkL2
 BMKEwacG7+EkG5JZYVYsxSna5P1ipBp+5Qu1If18tWmRvmCokNNC1H0LjIWsc2LWEFK+
 KZ2d5tWIY90ufCwW2BaZYnmvL+mC1y+F0PByt5vvrQENWhvyDWcigHySbznQfsfPsIAc
 4p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686328157; x=1688920157;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QdtNiuSZhg+5KnK2ViBDg+P4Ibn+zLdzYsmVmaZa+6Y=;
 b=IguYP26rXdnoithxEMhc/Ka8jhpfu949Ha839wNkw9xkg+Zedqc67jprTG5mbCOluI
 jLvC+hqGLsF4Zs9KklpOs0u9VLiCFLgrW384KfAVNl7nN2KkpdzeBHuXBm4P8WDeVTiY
 NFNQ3TyFPnR2FKGXjFB5vs4gpWy3ZyaEMXcgeZNOWiUnPBBt2h1POMIbhCyjN3ed3HgA
 9ic6J1dsBHcNK/yHDScv7rJsisBMcZdwSORQLeGQ7j96ttwqb391gZ4iC7RB4HuoZ41s
 3siSu6hkwKpxPEYk/mczX+VyzxXE7c0/Q7w58NrPYpAVAfbEMxBn+h7gq3h3vDl5McbV
 jsig==
X-Gm-Message-State: AC+VfDxoJbr/5kgJ2dXu4gzZl3ll27pA5xmkO91zsLFOt53HF7FzJVID
 gQf/zvkDGP4WX5zAWFnabmSXBzvpIntEgBIYWRs=
X-Google-Smtp-Source: ACHHUZ4Gx5ZGK71UGPuFxZ9l+Zq/o7niLB8oA5ENMfr2ynkcszSQVbqM0NuojrJ0HW9g0PHq1GzBmw==
X-Received: by 2002:a19:4303:0:b0:4f2:62aa:986a with SMTP id
 q3-20020a194303000000b004f262aa986amr1287244lfa.21.1686328157178; 
 Fri, 09 Jun 2023 09:29:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a5d4683000000b0030aefd11892sm4939300wrq.41.2023.06.09.09.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 09:29:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v2] linux-user: Return EINVAL for getgroups() with negative
 gidsetsize
Date: Fri,  9 Jun 2023 17:29:15 +0100
Message-Id: <20230609162915.175810-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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

Coverity doesn't like the way we might end up calling getgroups()
with a NULL grouplist pointer. This is fine for the special case
of gidsetsize == 0, but we will also do it if the guest passes
us a negative gidsetsize. (CID 1512465)

Explicitly fail the negative gidsetsize with EINVAL, as the kernel
does. This means we definitely only call the libc getgroups()
with valid parameters. It also brings the getgroups() code in
to line with the setgroups() code.

Possibly Coverity may still complain about getgroups(0, NULL), but
that would be a false positive.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
v2: also change TARGET_NR_getgroups32 code
---
 linux-user/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 83685f0aa59..bb29444ca7e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11676,7 +11676,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             g_autofree gid_t *grouplist = NULL;
             int i;
 
-            if (gidsetsize > NGROUPS_MAX) {
+            if (gidsetsize > NGROUPS_MAX || gidsetsize < 0) {
                 return -TARGET_EINVAL;
             }
             if (gidsetsize > 0) {
@@ -12012,7 +12012,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             g_autofree gid_t *grouplist = NULL;
             int i;
 
-            if (gidsetsize > NGROUPS_MAX) {
+            if (gidsetsize > NGROUPS_MAX || gidsetsize < 0) {
                 return -TARGET_EINVAL;
             }
             if (gidsetsize > 0) {
-- 
2.34.1


