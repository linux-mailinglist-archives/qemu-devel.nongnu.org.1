Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D5678F709
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:25:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtpA-0006Zb-UB; Thu, 31 Aug 2023 22:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtp9-0006Yn-7M
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:51 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtp7-0001R3-0f
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:50 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68a3082c771so989200b3a.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535027; x=1694139827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Yj/XvFLoTKPoAfaLaRz8qbNSbPbOFb4IFK3vAL5tQg=;
 b=XABPTiZ9amEnC07HAYUgC9z/MKERp6xwPFWTxjDg63bNaxUuUpS0BK/CXZlqqQE1hL
 V4loRxxi5UfALemjcj9gUrNubFE2HwhHTa+epL8SWhFffqlgPTbCoWwQgfBR9iyBpLpU
 rw3m6/QZhVfeaYLrxc3q5pmOM2etpj4iidhxejJybtBAjnfS0C97j17zDT3cJqpHocSj
 +AtN5LvHDjXDPKj5xXRS5kM7jcymsH7+8ZgEUa4bhBr8s1Ult6wyLbPHJevDGcuEngzY
 pMfp5oaF3R1Gi3SJkOyjICDO1/zG9XIUXtSAnGVmZuYDJKgZImMdrr8YzTyZBEoDxhWe
 +xbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535027; x=1694139827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Yj/XvFLoTKPoAfaLaRz8qbNSbPbOFb4IFK3vAL5tQg=;
 b=Sj5FpyQVV/+Ss62EbaDjkKV/GJOo1zJmb9SOBH+GU55n/PX/E9eBx0oGn80xyS3We6
 HZb5mc8bxclo5YGavj17WyQbXp4/E6I0coqkl1TH9BfJooYZykUCJyHbjyDLjVokbfwN
 k3dfwnYKYdO2zvrFiELkjM0FBggnGhQ63afnUyoClkei7o42RCpaTwoD4biOk5CHnMga
 Eg/Y2Iz6UNke0F8+LsASe0Re0hie7bdvWbcA6TlE5XzY8wsm0Eb80uTvoppcppDQUM6g
 r8D9moSQac0ylo7pVmK+0lwf8XsgK9nUihaa6K4ao/XvhDP+pchdRenxFr0HTJO9RKp1
 BFqg==
X-Gm-Message-State: AOJu0Yz2Lzgo/tvZ/INIu6jaFQNxnmUxZsRoiYCjKF8eR82QjtKcziBc
 KVJx3mo7GvM2ZLiv6o7TiCC8d0jvCSPh9K/Mawc=
X-Google-Smtp-Source: AGHT+IFivOqLxgG2wgBF6HazPlUigFXzNqKNZ93LHedL4X4NiWKBIsM81cy+1GTLLqZ4/P1tYQkTVw==
X-Received: by 2002:a05:6a00:21c5:b0:68a:6734:b018 with SMTP id
 t5-20020a056a0021c500b0068a6734b018mr1750624pfj.15.1693535027597; 
 Thu, 31 Aug 2023 19:23:47 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	alex.bennee@linaro.org
Subject: [PATCH v2 18/33] linux-user: Fix sub-host-page mmap
Date: Thu, 31 Aug 2023 19:23:16 -0700
Message-Id: <20230901022331.115247-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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


