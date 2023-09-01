Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1927902EF
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 22:45:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcAzF-0007DK-RC; Fri, 01 Sep 2023 16:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcAyt-0006yX-7R
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 16:43:03 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcAyq-0001xa-9h
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 16:43:02 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68a410316a2so2030461b3a.0
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 13:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693600979; x=1694205779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0iqggZ/kUA5XzQ6SOnvjK327/KaVNo8nl6UgLS2s/bg=;
 b=DlZ9HJrESRXlyfxOWl61Wi/5iq42dknbSyrqwMWe9baERQaQEhyLttui/+FsWUjzgp
 MqjMrGRWUbSO6fmA2GNt31iP7r15FgJEsW0EL3z8rJpErYqeR+TdVBV8M4uxP9DSjq3s
 4RssjGjFvBBJKPDD6NRh3/SH8y9q9ZmDseuQvFEOsavSDEuI7fa3pf3rSA2yXrQGX++/
 wI+QtoK01lIkBMxysPtn07bTXCEMmSlUE5pDLR95QF7HfcE45jDA3yq5VcLXPqzw22h7
 G5QLOKOabUqsoPwNyckVL3ZoLbaEpFTcIGt14c2UK8YqrmBJl1qEMBcgGKX8KDUGotoB
 3Vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693600979; x=1694205779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0iqggZ/kUA5XzQ6SOnvjK327/KaVNo8nl6UgLS2s/bg=;
 b=e+VUQX+nr4/8Vd9BJ8V74fkc28zuq0nGLtL2oXOP2YEu9yJ0xzO8yUeAYauqs1OoBH
 J2jJLFM1X+we21YYZuXNBy7YPJEcPsfBot1hLaDVJKghH24+VyqAYQwZTCneRWJUat+Z
 RTwKZ/i4kfx/vFag3zNhNN3HTJs+N0xMITlN+CWA7nfN1oHkKkb8Hm4JoWhO384hwZXz
 GbOOd5OS6ql5YQIsdY+z9sHqWubjkfnBsiwnERPByXtX6XbaFGlSndwfVp+KuLh1ncL5
 460PXEao99t16AVd93EscrjTEiE12JNbdZxNcrAbzOMX2N3JcrscBBaN++OnH/ihSRv0
 MhQA==
X-Gm-Message-State: AOJu0YzjLW5tlLaH5WXQg4ZgJl97hmgMEGOmQ5huUNgU9G/wX1glgZuX
 ZEfUzO12umn6n4f/nLSxs6cHwPcC50hDX+PCB9U=
X-Google-Smtp-Source: AGHT+IGk75YpWpJdWqZP9pcN8d6FcuQhswB9Ai6oVrANDXHsUm/5DdCdcG+LspzZNp+qzN4gqTVUGQ==
X-Received: by 2002:a05:6a21:6da0:b0:14e:509:1d7b with SMTP id
 wl32-20020a056a216da000b0014e05091d7bmr4934665pzb.8.1693600979002; 
 Fri, 01 Sep 2023 13:42:59 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j15-20020aa78d0f000000b0068c97a4eb0dsm3320666pfe.191.2023.09.01.13.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 13:42:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 07/13] linux-user: Show heap address in /proc/pid/maps
Date: Fri,  1 Sep 2023 13:42:45 -0700
Message-Id: <20230901204251.137307-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901204251.137307-1-richard.henderson@linaro.org>
References: <20230901204251.137307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 0b91f996b7..0641d8f433 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8125,6 +8125,8 @@ static void open_self_maps_4(const struct open_self_maps_data *d,
 
     if (test_stack(start, end, info->stack_limit)) {
         path = "[stack]";
+    } else if (start == info->brk) {
+        path = "[heap]";
     }
 
     /* Except null device (MAP_ANON), adjust offset for this fragment. */
-- 
2.34.1


