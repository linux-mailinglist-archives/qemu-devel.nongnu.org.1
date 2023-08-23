Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA12786179
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:27:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOj-0000K2-DO; Wed, 23 Aug 2023 16:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOU-0008KC-Ks
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:58 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOK-0005Tm-BZ
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:49 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bc8a2f71eeso40250715ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822214; x=1693427014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z7czmYNurSz0UJJSj6mQcZ7eC/i6fMnP8HLlVqYuy8o=;
 b=xotu/2RYb0UOGjkG1Od4S/JVWjez2QkB6r6OvinoWZfeffIHATJxnGZM7Xy5ZG92jb
 rQf/V0hv2wVm477GMeiWr0xEtyKKW7NMU5JP/veY36NKY7WGnxTiFijGDWlpvkC9/w96
 LP/lsoe73XXr2NbOd2fnf/wkVBpscIeqcNNtq3bhbgiRrsPdwoqY6BkYPmazCj1wPpFZ
 1GgP5Ac5sWbtlA07LmgaXJt514dOU77NmHnF0+GkbUg/Zmtw7xD1GDUQ9melMMqRKhP9
 9AZsWger4pO/fz9pHjk2qfYeVT+ZsMktHWqi+E9jOWRiIW4UBuscQT2RyeTNSJtcqetN
 Z96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822214; x=1693427014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z7czmYNurSz0UJJSj6mQcZ7eC/i6fMnP8HLlVqYuy8o=;
 b=Bay+TdYqgTrjVWaz+caju5UmdZiqplj2jBlEMW43iz5R8z0AimEs2/zNZN+uuyfTBZ
 uUulipa1NTAbp+pK2vIkeSJtSAvTJUhaAaQ3/anVhpfnvEauUhgXiortun3TJcohcuL7
 zmVbyLfF7ffTfKdXh4P7MvV5PAcQsyoQbUqjlHi5sa+DesrKu6nciq2URsodcMDALKJn
 azE2gj4PXYXXArg6CH2T0NKuTWEvSOqc+LlxixW4Qo/CcwggGKSwIIkmc7/KLfpC82Sd
 H2vVPmdTxxNhZzhBQYN4OXpOTmrFHrVDjM5oUf7x0eGug+88yc0QOKuyBLOqKbCLogEO
 utdQ==
X-Gm-Message-State: AOJu0YwfA88oBWWE8sXwS+C7CVwJcivpWbFWCd6MB4aPdR4ozYXmoO+d
 zacwzxaNqp/o4tEOYUcf80U6OqqRbI7HcL1Xtws=
X-Google-Smtp-Source: AGHT+IEVMhZnPzvM4D0NGtVfNnsFwQKcw8S/giuBgcTLZKCLJPW28K2/lwqpvbgo9peBZxtpKYOb0Q==
X-Received: by 2002:a17:902:8c8a:b0:1b8:2537:541c with SMTP id
 t10-20020a1709028c8a00b001b82537541cmr9710898plo.32.1692822213935; 
 Wed, 23 Aug 2023 13:23:33 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 06/48] include/exec: typedef abi_ptr to vaddr in softmmu
Date: Wed, 23 Aug 2023 13:22:44 -0700
Message-Id: <20230823202326.1353645-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

From: Anton Johansson via <qemu-devel@nongnu.org>

In system mode, abi_ptr is primarily used for representing addresses
when accessing guest memory with cpu_[st|ld]*(). Widening it from
target_ulong to vaddr reduces the target dependence of these functions
and is step towards building accel/ once for system mode.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230807155706.9580-7-anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index da10ba1433..f3ce4eb1d0 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -121,8 +121,8 @@ static inline bool guest_range_valid_untagged(abi_ulong start, abi_ulong len)
     h2g_nocheck(x); \
 })
 #else
-typedef target_ulong abi_ptr;
-#define TARGET_ABI_FMT_ptr TARGET_FMT_lx
+typedef vaddr abi_ptr;
+#define TARGET_ABI_FMT_ptr "%016" VADDR_PRIx
 #endif
 
 uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr ptr);
-- 
2.34.1


