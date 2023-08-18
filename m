Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A0B781173
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:17:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX321-0008Ip-MU; Fri, 18 Aug 2023 13:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31u-0008HM-Lb
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:58 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31s-00083l-3C
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:58 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bc8045e09dso8859205ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378775; x=1692983575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5Yj/XvFLoTKPoAfaLaRz8qbNSbPbOFb4IFK3vAL5tQg=;
 b=A7HDiRyBaWFcD+TihQWGaqy1kQl1tBgYOW1jgiFHI029eqXaLnZ3a2KKi2OciBOkGK
 mX6Yv1nkoeIMt4y/mlVq17n8Akg4ev1svIjewJopkCk2PLBhC7l7N7qzzdtxLnXhGD4e
 ZSm5aYsKJQjpBIBuPcA+Q8MofwDd8JLQ0e9dLJ5t/2VHA6asVBqkfGrvg9fIeN7rIj9s
 f7rBXcSTC74ve5eUUhGfy5PNQ9eVKNLI3p1WqhblfCTUjf1kGG7EOj648B4mMfJGH0Vt
 kR7HUQZtPZYLe0WDDOWPTAFa3rEK+AGLtUUKYR5B+YhXVmr87oTuqPx/KZe6HX/PAuAn
 JPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378775; x=1692983575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Yj/XvFLoTKPoAfaLaRz8qbNSbPbOFb4IFK3vAL5tQg=;
 b=lwaV+8L5UE1a445QvT+LLcTsjpJQAeKZzbr+RaQp700vwQzYY5b6fys/icqh5TsH97
 uamuYD70ee6Mjt6/OJIgNRVGf57kJn9prr5ukmhYKH/THAHc2D8bvmv8H/AySghOHdKv
 BIHnb7PmRbbVXZjz+U5gIMs/ktpYMWKnJ+jZOgaG0GYVwmemgO9vgIxyujnzlM6URCML
 IpSZWsab44SvT3C3hYy361daep9wBBDlDszN8mnCgoIaXYle9PNcSHE3MJXls4H7sJVF
 hUH0cr+VmHcPi7R+hkfpYolF8BlZMS+Z7S8Au8os3/7ey8t2ZUX1PNA3vbDGS5fLQI1i
 Rk6Q==
X-Gm-Message-State: AOJu0YxTLEivIWxMrAdfgpbE8vLFgt+8xT4oFakSP+rdFTYx0kv+ZLhw
 UQOQr90nNcul04r1cMRnpDiJhaWxhvTp4zbCSYE=
X-Google-Smtp-Source: AGHT+IHvYmrintGGFmnaH8kxqd3Yxt2j5qVQzad0yC12HTLx+Z3QEpWvUFWwOB6r97j0IX4CSEBXfg==
X-Received: by 2002:a17:902:efcf:b0:1bd:c7e2:462 with SMTP id
 ja15-20020a170902efcf00b001bdc7e20462mr2928172plb.11.1692378774855; 
 Fri, 18 Aug 2023 10:12:54 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:12:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/33] linux-user: Fix sub-host-page mmap
Date: Fri, 18 Aug 2023 10:12:12 -0700
Message-Id: <20230818171227.141728-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

We cannot skip over the_end1 to the_end, because we fail to
record the validity of the guest page with the interval tree.
Remove "the_end" and rename "the_end1" to "the_end".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 85d16a29c1..e905b1b8f2 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -599,7 +599,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                                target_prot, flags, fd, offset)) {
                     return -1;
                 }
-                goto the_end1;
+                goto the_end;
             }
             if (!mmap_frag(real_start, start,
                            real_start + host_page_size - 1,
@@ -646,7 +646,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
             passthrough_last = real_last;
         }
     }
- the_end1:
+ the_end:
     if (flags & MAP_ANONYMOUS) {
         page_flags |= PAGE_ANON;
     }
@@ -663,7 +663,6 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
             page_set_flags(passthrough_last + 1, last, page_flags);
         }
     }
- the_end:
     trace_target_mmap_complete(start);
     if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
         FILE *f = qemu_log_trylock();
-- 
2.34.1


