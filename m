Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2397A32C8
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:46:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd3q-0006iU-I5; Sat, 16 Sep 2023 17:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd37-0005Do-JL
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:57 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd34-0000VD-Hq
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:56 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-57355a16941so2076379eaf.2
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900513; x=1695505313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HHBE2N1zmj6JeCBieiTBjGikB9utE52NnbMbL9slySg=;
 b=XmZJ97sNMHx5KuGy6wnVFiDjrk65q4HGmAX7bxH/iUumSsujQ9FC276QMybyeeVB1E
 chvZWDhGC3JcWMjbuEmu27OL3O2pAd61CLTbUx06X02xyVaFVfTXug9EJSi34i2fwpzA
 JTciEX3Rs+2Q1oqTzD1hf8yYLwRQadAFJJEfXGvDPNqNv9YQNRIrAyx1NCWnE+vRZXLC
 QfPt4aI6HyRva+86wA7J/pDah+mhN3+l6fnoQyyo9CiAknpahzj4rWIGpMtUCikCtAL+
 72CgcP/e837roooBKBM20IAWBjmbCW0C6WgyLQSy9ryAzs2hmos2/t0QYXcSSns0c1mV
 Vpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900513; x=1695505313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HHBE2N1zmj6JeCBieiTBjGikB9utE52NnbMbL9slySg=;
 b=XkqAGSh/TLjc+LaNYkiyERvchE62qHIIAwPuLr4lLnCyXi8htaHQD1FCpbdG/dEral
 H3uzunG7jTsr7Bv9czBpBbvfrHJ7P70Qm+Qm2lDcPdDS2pS+SIGRlqOm9mLlRzBuz39Z
 ukRizhSJIE0Eur97p0PVDe5h1an9IGRfJaqd5qb6RpHIXN2fzbGHM7SaB2U2mL7YbLQf
 VgQcWd6zhQjD9BNUq2HVHpK8Mvw7ht4xIYJNXfZ65p1FI4befhXTEb86GeklX1BUdC9m
 wN0HGxuPjv6faqRbtRptkQMmO3JCq39ZjAePc68F8lADCLm2o9X8dLE6wuTY7BDwv3fk
 NU7Q==
X-Gm-Message-State: AOJu0YzMGqoIWt5EIEfUXUz9wni6z08JnmsIAsvM012HJvN0Pj8oIgGx
 N1h9pH75+pptvKPrkRu65+U8jCF1o//fzreoKhg=
X-Google-Smtp-Source: AGHT+IF5kUHx+KRIDXplYx9ID/+MIVZ+7PBuDy8F96q3q0aWdn4h6+eeyjsF4SKsdG9vLQoERk45wA==
X-Received: by 2002:a05:6358:93a7:b0:142:fd2b:d165 with SMTP id
 h39-20020a05635893a700b00142fd2bd165mr6816545rwb.13.1694900513017; 
 Sat, 16 Sep 2023 14:41:53 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 29/39] exec: Rename cpu.c -> cpu-target.c
Date: Sat, 16 Sep 2023 14:41:13 -0700
Message-Id: <20230916214123.525796-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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

We have exec/cpu code split in 2 files for target agnostic
("common") and specific. Rename 'cpu.c' which is target
specific using the '-target' suffix. Update MAINTAINERS.
Remove the 's from 'cpus-common.c' to match the API cpu_foo()
functions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230914185718.76241-7-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS                   | 4 ++--
 meson.build                   | 4 ++--
 cpus-common.c => cpu-common.c | 0
 cpu.c => cpu-target.c         | 0
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename cpus-common.c => cpu-common.c (100%)
 rename cpu.c => cpu-target.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 00562f924f..12261d8eaf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -139,7 +139,8 @@ R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: softmmu/cpus.c
 F: softmmu/watchpoint.c
-F: cpus-common.c
+F: cpu-common.c
+F: cpu-target.c
 F: page-vary.c
 F: page-vary-common.c
 F: accel/tcg/
@@ -1772,7 +1773,6 @@ M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Yanan Wang <wangyanan55@huawei.com>
 S: Supported
-F: cpu.c
 F: hw/core/cpu.c
 F: hw/core/machine-qmp-cmds.c
 F: hw/core/machine.c
diff --git a/meson.build b/meson.build
index 5150a74831..3e86a6cebf 100644
--- a/meson.build
+++ b/meson.build
@@ -3416,8 +3416,8 @@ if have_block
   system_ss.add(when: 'CONFIG_WIN32', if_true: [files('os-win32.c')])
 endif
 
-common_ss.add(files('cpus-common.c'))
-specific_ss.add(files('cpu.c'))
+common_ss.add(files('cpu-common.c'))
+specific_ss.add(files('cpu-target.c'))
 
 subdir('softmmu')
 
diff --git a/cpus-common.c b/cpu-common.c
similarity index 100%
rename from cpus-common.c
rename to cpu-common.c
diff --git a/cpu.c b/cpu-target.c
similarity index 100%
rename from cpu.c
rename to cpu-target.c
-- 
2.34.1


