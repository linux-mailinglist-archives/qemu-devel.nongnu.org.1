Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A819838BB2
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 11:25:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSDxR-0000QJ-Tr; Tue, 23 Jan 2024 05:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSDxQ-0000Q8-Ih
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:24:40 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSDxP-0004dp-0z
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:24:40 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6d9344f30caso2556378b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 02:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706005478; x=1706610278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=McCaPLIJxvTbADv66BEO7sWToPqj2hCMM+otAiFa5d4=;
 b=AQKv+fNArFTzeLgw7mDKhKdqnNm9cP0JQu4QCwk5UTbURygHnNhjDCEKUClHRjic9B
 rdTsPRLTyf2Rx3Pu6xMMT3Gz9DEBWB1EHxZsaXjeMTXypHOtG70W5uk/MnfqFJiRkGwy
 V4J24KJZOA11sNop/Bx8vM9Lopk9rtv49rNb+57s91phKK9T+jDde4tzEfkspLT1UXT1
 hLHwoFLj3OcnYVkxHaI9DawFDLq8uEo/qhiHuy5yRpWPUgTIHnZdJ762Z9bSXs3tEAzO
 FOdocvJH8TSoLHEjzckUVQMFinvF/T15ptLA9CsjwiOuRdIu1YMJ9fXu0ITzsZ1tUe4J
 z+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706005478; x=1706610278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=McCaPLIJxvTbADv66BEO7sWToPqj2hCMM+otAiFa5d4=;
 b=qBsBmmlT8fvMqm35Tn0taEhZN/m+jdBUFVRuGl33AlOr1wwB/HVwrB523DHZXLHuB4
 k+s2o/Jv7i7NZUM0TWUiYGUG4fqEO6EMfrIzzhrm7KrQceLFs091nJ0ToXWQZMHc7LFb
 zvMfX3ZMbiqF4heelhPiJR5rof/Wd8dmYF/T4v2xIrOqM9iCMkyqr4RQfNulsyUHXnS1
 JtP2HGEauuKxlmfL9VpMgFW0WmKo3V1cDHVzlfiDbm64Oad3Eg//f7ciqxBO/UgY7+lC
 6nW6oaVFgAFuqutaak4taRa/9SKu+zQ7fjSK06/Qo1D4JvYxrvn1to6z7x1kybqmtLZs
 e8oA==
X-Gm-Message-State: AOJu0YxNF/d3/K99CU/gx1Zste6L/VD6yqPZBG0YO+7+8ZvfuS+/f6w0
 C4poTP3mzyhLNVWkRgbwSbohRsGxg4k5ABbGGJDWLJuMHfIqvvVEsEUoqNfuijidHkAQAktn4rH
 8NJY=
X-Google-Smtp-Source: AGHT+IFG63a/PFhuWVxUEhb9qe/0tUlKvJr3xTRvIjk+1oY3X3bFH6u9zHzH/1F7kvUtT/b0TJu0MA==
X-Received: by 2002:a05:6a20:4329:b0:199:89a0:9f2b with SMTP id
 h41-20020a056a20432900b0019989a09f2bmr6537956pzk.26.1706005477681; 
 Tue, 23 Jan 2024 02:24:37 -0800 (PST)
Received: from stoup.lan
 (2001-44b8-2176-c800-b8a0-0408-58be-7d2e.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:b8a0:408:58be:7d2e])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a62f808000000b006d9ce7d3258sm11072408pfh.204.2024.01.23.02.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 02:24:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 7/8] linux-user/elfload: check PR_GET_DUMPABLE before
 creating coredump
Date: Tue, 23 Jan 2024 20:24:11 +1000
Message-Id: <20240123102412.4569-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123102412.4569-1-richard.henderson@linaro.org>
References: <20240123102412.4569-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

From: Thomas Weißschuh <thomas@t-8ch.de>

A process can opt-out of coredump creation by calling
prctl(PR_SET_DUMPABLE, 0).
linux-user passes this call from the guest through to the
operating system.
From there it can be read back again to avoid creating coredumps from
qemu-user itself if the guest chose so.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Message-Id: <20240120-qemu-user-dumpable-v3-2-6aa410c933f1@t-8ch.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c596871938..daf7ef8435 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2,6 +2,7 @@
 #include "qemu/osdep.h"
 #include <sys/param.h>
 
+#include <sys/prctl.h>
 #include <sys/resource.h>
 #include <sys/shm.h>
 
@@ -4667,6 +4668,11 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     init_note_info(&info);
 
     errno = 0;
+
+    if (prctl(PR_GET_DUMPABLE) == 0) {
+        return 0;
+    }
+
     if (getrlimit(RLIMIT_CORE, &dumpsize) == 0 && dumpsize.rlim_cur == 0) {
         return 0;
     }
-- 
2.34.1


