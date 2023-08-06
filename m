Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F028771371
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 05:40:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSUaC-0003gK-3R; Sat, 05 Aug 2023 23:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUa9-0003fI-0w
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:29 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUa7-0007Yb-JC
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:28 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2680f27b52dso1967349a91.0
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 20:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691293046; x=1691897846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XZm1OFwkD4B8Sj8o40TKDrmNFRuwUs1Ie6LEvKqa7G4=;
 b=ZbWd5jB2YZ6jGGpbje1Pu6cR8bNBepO67ZMqIVGmuKZ59EFVYgXAuhRzVA7GAScLNr
 R+RsCPpO1lGEWRmAX0Vp5QQZOqp7+R6oK9Fk21R5zWRGpKVhUCq/8oB7NYY0c4bUKETV
 uMrPYzbnWUhiflOQQSkh+mbZaB/76Uk0thvRf9DfG9qCfY2ZV5oPGJ6JP4OaPR5V3J8J
 7mS2p0DrTWw3hwHqlmZgJE0L9ox+JS41SCzvkd/2BbXvvkF0KSnp2LWH59WKxbMEAtE+
 taQgC+n2IGcs5kSu6ivHX9TWRClGusftuC3ngD0OL9rSCq2Sjr4MqnPUHpv+YKMN4bgb
 dRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691293046; x=1691897846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XZm1OFwkD4B8Sj8o40TKDrmNFRuwUs1Ie6LEvKqa7G4=;
 b=d6Zi+aoJ23N/H+GWaJuCJ5CRje/J5FIcA9M9f2WcivTA32UzoK5NyG/L5Ni3fjbQAc
 eiF+YKQBBbypaKgQUpcBixNE6ThhvhhpFU0aFBuetnubO+kvRP4brQVB8B3lX2egSHJp
 7NC78B8E/z+uCiFopNhbXQ6yNLcChfCl00bdhAya9nwq8OB7LkQxkmkEDNB3HN7YLSqV
 lRfTPr4MBqmtgLpJCpF7TTB+K1/FjrERz6O0xRVm9B/SiXMjga95AWzC48cdc1oT+lOu
 G4pNzJg2Sbh7tVFgQmtgUMUxZIdwoGqjmdQiepvPykwah7GQBElxL/rf0+nAQU1+b7Gv
 KeLg==
X-Gm-Message-State: AOJu0YwVcCuW+5bV/CeVM14JKWmFL6XxITPQuucirWcQQWSQX99/TObM
 NoroezqVvgkeaHPTAJ4k6Tc5WIcweLgs6wx8aQs=
X-Google-Smtp-Source: AGHT+IFzdw9xWkE8JFMgveBLLlPWhDwA6IbW0zgMkgeBAFpFVvUvHQdLwHWR5RckCm1kRy1wCkYD3Q==
X-Received: by 2002:a17:90a:4f4a:b0:268:b0b:a084 with SMTP id
 w10-20020a17090a4f4a00b002680b0ba084mr5596892pjl.46.1691293046291; 
 Sat, 05 Aug 2023 20:37:26 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a17090a740500b00262e604724dsm6306451pjg.50.2023.08.05.20.37.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Aug 2023 20:37:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/24] bsd-user: Remove last_brk
Date: Sat,  5 Aug 2023 20:37:03 -0700
Message-Id: <20230806033715.244648-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230806033715.244648-1-richard.henderson@linaro.org>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

This variable is unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/qemu.h | 1 -
 bsd-user/mmap.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index edf9602f9b..8f2d6a3c78 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -232,7 +232,6 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_size, unsigned long flags,
                        abi_ulong new_addr);
 int target_msync(abi_ulong start, abi_ulong len, int flags);
-extern unsigned long last_brk;
 extern abi_ulong mmap_next_start;
 abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size);
 void TSA_NO_TSA mmap_fork_start(void);
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index b62a69bd07..8e148a2ea3 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -214,8 +214,6 @@ static int mmap_frag(abi_ulong real_start,
 #endif
 abi_ulong mmap_next_start = TASK_UNMAPPED_BASE;
 
-unsigned long last_brk;
-
 /*
  * Subroutine of mmap_find_vma, used when we have pre-allocated a chunk of guest
  * address space.
-- 
2.34.1


