Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 627BE821637
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:00:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU3Y-0003Ze-3e; Mon, 01 Jan 2024 20:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3Q-0003UZ-W0
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:53 -0500
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3P-00073E-Df
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:52 -0500
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2045bedb806so6360451fac.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160730; x=1704765530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/pDTiX/W/3uE1ebfbK0jDL+RrICwab7UesIidaqTDMQ=;
 b=mta5MaAf8zmWkyZMiZx/Ho8mpo4jStj/WSBz183q2UusqAb4BpLik6lyTV5wkSs/lr
 4oRWj+lpe/ZCWPKH0xCSbFXgf45Y+09x83c+3WfR0MtRm5g5A8Qzz7MT+bbzmouoI9cT
 WUKlMg9kltbAfvoece6yjlc/R7W3nskLZoamB23eZneWyGm3kgLvGayyfwK/fPVoZl1I
 6x8NEfEh+RE01vwgZJYrB6Fb68hPyeOOVSLKc53RtK/X5ftROUEhqCPPZoEyKvhiNlJg
 PirrintzKyuYtQSxqtq5+K60SWM3M+oWbCq4RGfLe1XRYzpVZGLDtrOPEvcHw2mTv7IG
 39Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160730; x=1704765530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/pDTiX/W/3uE1ebfbK0jDL+RrICwab7UesIidaqTDMQ=;
 b=Go6kUORICTiyfVqJ1qk2h5rcDa++AVj0DldbvztvJ8TtogiFYzd7k5tsGaANaID1Ua
 GB0xNBtCY5ctyt5KJscuGWlxvUsErvmtmRZIxpZU1a0RZiDj9a+j9wxe/ELaa1NVKOhV
 8mL7v8CzkKDij564bg8G9UomSGysgAqlDOmT3FZzi4Pk2OxBe9ACPcX+UkVt4KU2MfEX
 WUZPv8EVUCpqa97VPdYs6ZWvJVbDyEXa55J9M7czsqSBN3dzPgFnB6OqEx82m+qzik0v
 CL+n3Cd/rwC1ZH9XmqTujqcC9N9Xo8uP5NQ6SxsuaJj9EwwNcy7NzjKn7qOw59IPFPdW
 FSqA==
X-Gm-Message-State: AOJu0YzNasW9FLPUUSyiTeRNbSDi0NRVoze+u9TO2DmOMUXHCYgK6/Hy
 Wr5KF90xyAOFqx+cvuEvvVB5kr5O/kEjFushyLa/ruIqe78=
X-Google-Smtp-Source: AGHT+IH4DOe402Om0PZiBkW8rrcVki8Ybgk9LbmIgEXNW9HvwnpnHiQJ9vRb85c0DqTDNYSAhNw08Q==
X-Received: by 2002:a05:6871:606:b0:204:c23:8831 with SMTP id
 w6-20020a056871060600b002040c238831mr21960222oan.37.1704160730184; 
 Mon, 01 Jan 2024 17:58:50 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.58.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:58:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 18/33] linux-user: Fix sub-host-page mmap
Date: Tue,  2 Jan 2024 12:57:53 +1100
Message-Id: <20240102015808.132373-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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

We cannot skip over the_end1 to the_end, because we fail to
record the validity of the guest page with the interval tree.
Remove "the_end" and rename "the_end1" to "the_end".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index fbaea832c5..48fcdd4a32 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -643,7 +643,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                                target_prot, flags, fd, offset)) {
                     return -1;
                 }
-                goto the_end1;
+                goto the_end;
             }
             if (!mmap_frag(real_start, start,
                            real_start + host_page_size - 1,
@@ -690,7 +690,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
             passthrough_last = real_last;
         }
     }
- the_end1:
+ the_end:
     if (flags & MAP_ANONYMOUS) {
         page_flags |= PAGE_ANON;
     }
@@ -708,7 +708,6 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
         }
     }
     shm_region_rm_complete(start, last);
- the_end:
     trace_target_mmap_complete(start);
     if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
         FILE *f = qemu_log_trylock();
-- 
2.34.1


