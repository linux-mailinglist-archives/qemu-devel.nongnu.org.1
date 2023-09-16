Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1537A32B3
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:44:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd3b-0005VM-P6; Sat, 16 Sep 2023 17:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd37-0005Dn-Is
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:57 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd35-0000VT-AO
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:56 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68fb98745c1so2628339b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900514; x=1695505314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=50A87DiNBui2Aabq1+Nxd0earov0nrUH3Txq9Zcvjq0=;
 b=PT4MrCq9UdpKjdeukrDd3wyIXbkbiqieGHplQzMBn7weCWL34jRZJMAs4KaO0sjs0b
 z456e94v3hS6mxbjzBdShGbj4ECc4f1r13Wy1jLu+Zqt5a2g/Kp0kmdoWKpNs5sEkf8/
 jjtDhdsk8GjONe5eScSAPW5cUfaWopgEWVGfFE0E4tZn3qVG+NDp98dSxBxZf+i/EcFo
 xytgigmEZir9VjAI9E8c/gyEu0mgZyMGUQTO0m51o9+yGbfslB7rDJhpfGYIj9hqSfw/
 cx6VOTZhqnXiO9bfpvxoKd5rbFWIV7xvK2SwZEbaLIHv16KPSZAI5gDg7E7lwJIP+dBZ
 JGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900514; x=1695505314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=50A87DiNBui2Aabq1+Nxd0earov0nrUH3Txq9Zcvjq0=;
 b=ajD/NHzmha+F2xXjQugZzWSIcOYo8HIms3UCSXHoC6huXDQ/3qG4s10q9rAS6n3SbX
 EUs0vgwHw+DU114K4CWUZwufZ7z/hrHcg7JH27T3m6o+eAOdcQCvnBIfVJCRH159FoAu
 Gv4V+j9ofvOmRIM65y0z6kCtoMO94UzGVy1La3RHr2q5fK9HCiWFJQ8CyJowisuX7Tgf
 5axs8igOg8g9mLRY5mEICV4zExf0KSQK/8eTmqf5GIARJsPoPPww676P8cLXlPDFnhO9
 BDa3sI6Qg5pL5axUqVsF82oF//FqwpQO+YTT+/4Kztuvl0w0DHN7LyAXqXs/DdvCeCYl
 k+Fw==
X-Gm-Message-State: AOJu0Yxh65HsJStK/QY1cdPDDCi1BN5Cz0cjl2YS48oxWjcY5PPfJfdu
 UBlBe2Bqg+DXXPvDqQ+8GmwW896GVOgkkBAEt+g=
X-Google-Smtp-Source: AGHT+IFm1UpsAJsbxMCZuZaJ6JUoSWQBqanN+cdIT9Jw+XQB/tw9B3bUmUYNi4Pt2/GT1caO4yFrDg==
X-Received: by 2002:a05:6a00:b92:b0:68e:2cc4:c720 with SMTP id
 g18-20020a056a000b9200b0068e2cc4c720mr5837543pfj.12.1694900513870; 
 Sat, 16 Sep 2023 14:41:53 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 30/39] exec: Rename target specific page-vary.c ->
 page-vary-target.c
Date: Sat, 16 Sep 2023 14:41:14 -0700
Message-Id: <20230916214123.525796-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

This matches the target agnostic 'page-vary-common.c' counterpart.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230914185718.76241-8-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS                       | 2 +-
 meson.build                       | 2 +-
 page-vary.c => page-vary-target.c | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename page-vary.c => page-vary-target.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12261d8eaf..ff436dbf21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -141,7 +141,7 @@ F: softmmu/cpus.c
 F: softmmu/watchpoint.c
 F: cpu-common.c
 F: cpu-target.c
-F: page-vary.c
+F: page-vary-target.c
 F: page-vary-common.c
 F: accel/tcg/
 F: accel/stubs/tcg-stub.c
diff --git a/meson.build b/meson.build
index 3e86a6cebf..3282f888a3 100644
--- a/meson.build
+++ b/meson.build
@@ -3439,7 +3439,7 @@ if get_option('b_lto')
   pagevary = declare_dependency(link_with: pagevary)
 endif
 common_ss.add(pagevary)
-specific_ss.add(files('page-vary.c'))
+specific_ss.add(files('page-vary-target.c'))
 
 subdir('backends')
 subdir('disas')
diff --git a/page-vary.c b/page-vary-target.c
similarity index 100%
rename from page-vary.c
rename to page-vary-target.c
-- 
2.34.1


