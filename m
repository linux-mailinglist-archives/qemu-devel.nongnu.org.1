Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E1A7902F6
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 22:45:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcAzH-0007EY-3c; Fri, 01 Sep 2023 16:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcAyy-00072K-Ex
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 16:43:10 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcAyv-0001ys-Cs
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 16:43:08 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68a440a8a20so2058329b3a.3
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 13:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693600983; x=1694205783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mqs/jfDEIHNofUCfPibQFnYzPmfzQW+loIwUJrctV2Y=;
 b=KHdlZu61YagUHHQbODp5Ew143SF/t5iVYhgtpRrv7R+fBjB8DACeyoU7l2DmDA2sdf
 b9kjhElYFKyI7MVikgpNV2bt0X/5tm93W8ardtBCD4xHR9G0ZkhpAZOsgxtuK6ASEP08
 4g6cTw/WsI2BkunO0dU+vzFAfkRvyA0BXiPxngDvc0P6nFvPvxmJeOEFZsJD9Iwh7ak7
 A/F3LOPAck71TTIdYzwLDZ/HrbUu9a7V9lyiOvRHugAivICcCqDmi9yYXlYSHi3D+l2m
 d0Bt5sDuwyIBUqvnHFlKlhnw6eB9u/cOvlI7J6J0khNOs0QNJceVFaxguILtvQVJ0PdI
 s5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693600983; x=1694205783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mqs/jfDEIHNofUCfPibQFnYzPmfzQW+loIwUJrctV2Y=;
 b=F9DIG6oJ0ULFjKj5VydsCEXAJfvCa5mZcygCv9vCi+CJXg1RqwrvIsdSZaPzN3a7E/
 iZ23ZzC67FR564ccf6i6G+h6i5L8crurBq3eCsD4ruyEc7QXepnoO7GecK4ZjQyrEVba
 QKswYncLcH4vpPcEPLcFzdsJm5M9QefA7EGLoGmFtjmlCF3NDVHAV+TWrs6kZHj0+wFt
 v6xRI84Cvpd2WXvaTVypZBUdHsc6FZ+JBwoMfocYMi8PZF4zwDGhrd3OmCZUvsSRxja5
 49O6DRI/QjZqA8W0q7sUwtHOp1qvn4dHA+iCEAjVfGS6EoVHjqjnq5w0v6fzjh9IY+rd
 nf5w==
X-Gm-Message-State: AOJu0Yw3Ab/MBLQTpNUXgSzHXb9JQXlKypn5oFDNtXm7Kts4qYhIdWMx
 3Wd+KIKSPqSmuWRb7FK1QNMXqs56hGK5EqRo5AA=
X-Google-Smtp-Source: AGHT+IECctyunljcjLbUnDSO4lHrYQrd2PessSthws60l1KuCfj8OVnsYIuN8+Ptv7Bo0zfvCnjDZw==
X-Received: by 2002:a05:6a20:7f85:b0:134:76f6:e9e2 with SMTP id
 d5-20020a056a207f8500b0013476f6e9e2mr5320407pzj.58.1693600983481; 
 Fri, 01 Sep 2023 13:43:03 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j15-20020aa78d0f000000b0068c97a4eb0dsm3320666pfe.191.2023.09.01.13.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 13:43:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/13] linux-user: Fix shmdt
Date: Fri,  1 Sep 2023 13:42:50 -0700
Message-Id: <20230901204251.137307-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901204251.137307-1-richard.henderson@linaro.org>
References: <20230901204251.137307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

If the shm region is not mapped at shmaddr, EINVAL.
Do not unmap the region until the syscall succeeds.
Use mmap_reserve_or_unmap to preserve reserved_va semantics.

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index f45b2d307c..44116c014b 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1102,14 +1102,25 @@ abi_long target_shmdt(abi_ulong shmaddr)
     /* shmdt pointers are always untagged */
 
     WITH_MMAP_LOCK_GUARD() {
-        for (int i = 0; i < N_SHM_REGIONS; ++i) {
+        int i;
+
+        for (i = 0; i < N_SHM_REGIONS; ++i) {
             if (shm_regions[i].in_use && shm_regions[i].start == shmaddr) {
-                shm_regions[i].in_use = false;
-                page_set_flags(shmaddr, shmaddr + shm_regions[i].size - 1, 0);
                 break;
             }
         }
+        if (i == N_SHM_REGIONS) {
+            return -TARGET_EINVAL;
+        }
+
         rv = get_errno(shmdt(g2h_untagged(shmaddr)));
+        if (rv == 0) {
+            abi_ulong size = shm_regions[i].size;
+
+            shm_regions[i].in_use = false;
+            page_set_flags(shmaddr, shmaddr + size - 1, 0);
+            mmap_reserve_or_unmap(shmaddr, size);
+        }
     }
     return rv;
 }
-- 
2.34.1


