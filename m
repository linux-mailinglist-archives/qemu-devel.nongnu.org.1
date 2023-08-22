Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD04784824
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 19:02:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYUlq-0008Qj-E3; Tue, 22 Aug 2023 13:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYUlm-0008Mf-9e
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 13:02:18 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYUli-0002KM-J6
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 13:02:17 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-56b2e689968so1412523a12.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 10:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692723733; x=1693328533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dyMnZPF0lJjltNxI1ShT7iDXd4Rf74ljeip+pJOFsn0=;
 b=dit81IQtr9lfNtbpySaog6AF/9oRIkx9V7RygsWQidvLYVLi9fnigzpNP4lu1CUD5Y
 vjDm3cjTQAMzrUCjLSTSKKWpMq46MPpAWAWzhAChI0MB3f/V5nJRivZh2ys2VI2HC66S
 UTr6ugff/0eDFDDJlFhflP1fYGfGr4/DmOYirn2X7Js8cpHI9FoqJGhdpuxU1gp3mm3m
 by2BueWZPZjweDmjYAytIG6BRaUEfO7YgWJydE8CZKaMv9DUBx+qbe7FjnuqHKZkqquc
 yA6n/HWAXWLfbolW674rVaE6eRPB4TRn/eWvqREfKZOgTvkCySG7Dq8Q6UNAMFghVRx2
 zicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692723733; x=1693328533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dyMnZPF0lJjltNxI1ShT7iDXd4Rf74ljeip+pJOFsn0=;
 b=fh3Caxbx48hppg27p1jl0I39npd+GtORQ79k5EjYOsFOImYS+Gb9jDPbeskiYFmGat
 CWf0+t3X7EpjX3ke+oLAuX32ZOD2/rGQvJ8bLLA6Oq7295frzHbyaenRiRvfRMBaUMSY
 cavGHiUR8ZY7Iaw5zrVhE2Z/L1wExzrgf+Vxj3ANvg/+MdqEyN7hppmVyJHSUY6miqaX
 fMBI0hUcwYzwKU+EZJp7y0y3mbPp/6xJLPXHg4YaXI3W6s0+78GnkFhpGz7HWijncbz8
 v7Q+KxX8+M6tqMI/AR3vsr/VkDYupSd1t5DaoZv6vObYkcXhDlXhpTphHe9v/62OqgGC
 oQgQ==
X-Gm-Message-State: AOJu0Ywut+Z5twE9GUG/HiP8B8W1iBpUSN+9NiQI+EtsH+TQHWgNBEGC
 Xvo+FfmMsOHGJO+89SGadb2EBkunA0e6BIW/PWk=
X-Google-Smtp-Source: AGHT+IFwVWd2NXKc1hR0xqNWZZxnWw5etzjFJtVofHOFj9Rq2qxmfi32s5+e6DXxwfliywQwRqjUxQ==
X-Received: by 2002:a17:90b:1d06:b0:26d:b12:8383 with SMTP id
 on6-20020a17090b1d0600b0026d0b128383mr7476481pjb.8.1692723732847; 
 Tue, 22 Aug 2023 10:02:12 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 27-20020a17090a031b00b00264040322desm8761121pje.40.2023.08.22.10.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 10:02:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 2/3] linux-user/aarch64: Fix normal SIGILL si_code
Date: Tue, 22 Aug 2023 10:02:08 -0700
Message-Id: <20230822170209.1130173-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822170209.1130173-1-richard.henderson@linaro.org>
References: <20230822170209.1130173-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Most illegal instructions use ILL_ILLOPC.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/cpu_loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 2e2f7cf218..22c9789326 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -110,7 +110,7 @@ void cpu_loop(CPUARMState *env)
             /* just indicate that signals should be handled asap */
             break;
         case EXCP_UDEF:
-            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPN, env->pc);
+            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC, env->pc);
             break;
         case EXCP_PREFETCH_ABORT:
         case EXCP_DATA_ABORT:
-- 
2.34.1


