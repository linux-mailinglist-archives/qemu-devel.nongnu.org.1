Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75269770B9C
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 00:02:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2rR-0005EO-Gz; Fri, 04 Aug 2023 18:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2ql-0004aQ-0q
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:49 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qh-0001oG-5l
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:45 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3a78604f47fso238663b6e.1
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 15:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691186442; x=1691791242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VNYrY2Waoll+LErzR9Xgbts1EKTxuONltL+p3Yeklu4=;
 b=Yo7WI6t5glkTUAPMQ0umLk/jb0jYnLaPxcNb7rv+2cjWe2usocQOl4ivHTgJpMmnEY
 IDXduaygAPwnbPBjyB8IY5zEAftxzsT+qOThmgHHikm+gFCcHn8NOHtPGmZjTtR3dLNW
 gNwZ/JAQm9Dqe/Xo/DhF6rMCEQFpNKex6MO5QBqLJ53uGYeScV1lyUdVgTR73OsL/R8K
 3pYwG4bKnmKIsEiPevJT4iOXedqMHQIN1lIdl5OAleKiazrpj5mJp7iRm7UoBIFBCTQ7
 JEQZy4ul7F+Ia/QeWFL84KPyvOyUChKIRGsramN0XL8Wwx8Asjo8gE3Df7QWxbYR++Py
 xPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691186442; x=1691791242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VNYrY2Waoll+LErzR9Xgbts1EKTxuONltL+p3Yeklu4=;
 b=KsRo9XCNSHQ+0upjHYdiCypQJPAgxWoQxaTIcGKGeewwTryPWAs43bQCQqCswKtvGz
 JJMUvCkV4YoRVmRcqiRHCh0kP9v7u5BI08KRszpF0IWsjdsupQDWbtBbFsxVlpgT//7m
 emU76i+gi6Q5Hqbe9jPULA1Po91xniPFdrXHNUG4vex3BXJO/GkiEmHk9p1x0dVXAOz9
 utEkC9kknA80Rkr3cH3TOCbxG1qhSiiQVzIrWBh75eRoJhQ+8fvcY3gZ7rGonGWHgs3p
 EfTLVZxZXVtd70hPp+8S8cVuV5nwS5u/H7oKFZABmGyFM7341fRaK90Y8pfdWL9EZAVd
 yacQ==
X-Gm-Message-State: AOJu0YyhIIUEu1IFq0Pv+3WNfDWYEOErw1QPcGGfp5SMjaB/inVOYjrx
 o5eP9OxqwnLCDbtlAYpEv5QHFBF/IWq5nAFyPY8=
X-Google-Smtp-Source: AGHT+IEssg9bEPkUkUo4ygfoMByROp49nvMIwW90HpNZTKJ4SHgHXPJsPNxEPoBTQ5zlv3CaphZnqw==
X-Received: by 2002:a54:468f:0:b0:3a7:4a89:752c with SMTP id
 k15-20020a54468f000000b003a74a89752cmr2992840oic.31.1691186441690; 
 Fri, 04 Aug 2023 15:00:41 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090282c100b001bbf7fd354csm2185568plz.213.2023.08.04.15.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 15:00:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH v9 09/24] linux-user: Do nothing if too small brk is specified
Date: Fri,  4 Aug 2023 15:00:17 -0700
Message-Id: <20230804220032.295411-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804220032.295411-1-richard.henderson@linaro.org>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Linux 6.4.7 does nothing when a value smaller than the initial brk is
specified.

Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230802071754.14876-6-akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f64024273f..e1436a3962 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -820,14 +820,14 @@ abi_long do_brk(abi_ulong brk_val)
 
     /* brk pointers are always untagged */
 
-    /* return old brk value if brk_val unchanged or zero */
-    if (!brk_val || brk_val == target_brk) {
+    /* return old brk value if brk_val unchanged */
+    if (brk_val == target_brk) {
         return target_brk;
     }
 
     /* do not allow to shrink below initial brk value */
     if (brk_val < initial_target_brk) {
-        brk_val = initial_target_brk;
+        return target_brk;
     }
 
     new_brk = TARGET_PAGE_ALIGN(brk_val);
-- 
2.34.1


