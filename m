Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BF578115A
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:14:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX323-0008Mt-I9; Fri, 18 Aug 2023 13:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX320-0008Jc-CV
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:05 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31x-00086q-PM
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:04 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bf3a2f44f0so6379445ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378780; x=1692983580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FBWXK2o1QI213n+CXudGJA2Q6k8dmEbYGhoqpLagvf0=;
 b=FnuKhpln339jwIBI+ES0FtOPqRQf5OTTZW9Mx0n9J1PKCu6xdKZhwaF+i30snDjJRN
 7L+EniJBNBA4ZobUjd2BVOQagbXWvItj502wXnFMss7qlKRjI7oxiCHe0WBfhXk9yd3C
 NEQFywNrsbl+5jwl2UPbZmroJv9VQaP2JaOuW+pZiakbx/lDOm9VWFZZN0WhtzQocJ10
 0RYkDLcWCON3R56wl7zt93FmXLm/FNEB7l85a1wNQ4f+meQ9eicF9ceE8Nciv2PbOVRK
 fyiIHOV3fcGT13CIHHe1L9NpVgBH4UB2uS7rzh32MIFKTtOGxk1YG343FrlplVTUhNxR
 oL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378780; x=1692983580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FBWXK2o1QI213n+CXudGJA2Q6k8dmEbYGhoqpLagvf0=;
 b=DhofAZH2DmRiEyPFTs5yoWtB1/gPvlnsI/UlxaweP4uSWbO7AsClWjn23UpYpA4aXB
 1vdDGsC/3lqzHMCBBQLr21YOEPW3UHZCTilRldGs+oqK/MKV0c7K+cq3zQbJffPlCAHT
 Q60oYkA6wQBvc/mIK82ZsUMqSBAsQNiUR9UOOz41J7mZA5KaAEe5vWMrEYsdfkQ71/IZ
 1fuItK0rsRoKgpe2/41GYkN4hLcV8DdNG2n3rSmIVow7uYpj+ytSDVn44WAWNtVRkZQt
 oVgUFfCbgTLrjtQBXLRp6l+oiuQAGzP3m3ziJmfszMszB0nBNutoaZ0SO+mPeEujC9L3
 4enQ==
X-Gm-Message-State: AOJu0Yz4aQ8PLwhJptMKpux+VljZy1xaW1dbkJc7YwdU1vRA4KqBnaVL
 4Sd6I+bpH6niCcKSpWFSVjH93xZnkr2SgjIkoHo=
X-Google-Smtp-Source: AGHT+IE76qGhaasWvrI4aN7er7ebjpaIpoqHuM55pKbl2kBLtUIi4t6kcmufv7IlxexfZKtt94LkuA==
X-Received: by 2002:a17:902:ecc9:b0:1bc:7001:6e62 with SMTP id
 a9-20020a170902ecc900b001bc70016e62mr3637749plh.35.1692378780545; 
 Fri, 18 Aug 2023 10:13:00 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:13:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 26/33] linux-user: Deprecate and disable -p pagesize
Date: Fri, 18 Aug 2023 10:12:20 -0700
Message-Id: <20230818171227.141728-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

This option controls the host page size.  From the mis-usage in
our own testsuite, this is easily confused with guest page size.

The only thing that occurs when changing the host page size is
that stuff breaks, because one cannot actually change the host
page size.  Therefore reject all but the no-op setting as part
of the deprecation process.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index c1058abc3c..3dd3310331 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -332,10 +332,11 @@ static void handle_arg_ld_prefix(const char *arg)
 
 static void handle_arg_pagesize(const char *arg)
 {
-    qemu_host_page_size = atoi(arg);
-    if (qemu_host_page_size == 0 ||
-        (qemu_host_page_size & (qemu_host_page_size - 1)) != 0) {
-        fprintf(stderr, "page size must be a power of two\n");
+    unsigned size, want = qemu_real_host_page_size();
+
+    if (qemu_strtoui(arg, NULL, 10, &size) || size != want) {
+        error_report("Deprecated page size option cannot "
+                     "change host page size (%u)", want);
         exit(EXIT_FAILURE);
     }
 }
@@ -496,7 +497,7 @@ static const struct qemu_argument arg_table[] = {
     {"D",          "QEMU_LOG_FILENAME", true, handle_arg_log_filename,
      "logfile",     "write logs to 'logfile' (default stderr)"},
     {"p",          "QEMU_PAGESIZE",    true,  handle_arg_pagesize,
-     "pagesize",   "set the host page size to 'pagesize'"},
+     "pagesize",   "deprecated change to host page size"},
     {"one-insn-per-tb",
                    "QEMU_ONE_INSN_PER_TB",  false, handle_arg_one_insn_per_tb,
      "",           "run with one guest instruction per emulated TB"},
-- 
2.34.1


