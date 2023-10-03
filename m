Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 414547B6FD0
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:33:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjFG-00009B-31; Tue, 03 Oct 2023 13:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjFB-0008WF-Bv
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:37 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjF8-0007YY-KX
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:37 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-573e67cc6eeso780470a12.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354293; x=1696959093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c/FZaZNCOMSfV9rgR/7MTnUZZZXhYKw4ogSZ+5ucjRw=;
 b=FfNShVGc2+8YVqaAF2aoc81XDWvwKDozWnWljqMUHHnMU8fEOXys5jAZ6Zh8dj+vUj
 0foIWBD6ZPX3poSSKYYpGPIdgPuvBLQHx8ujq94P+4mURGKOROsWdWr2NGciOLeABVVN
 i/Dxn4Tqr+M4E2MPBdMSRMBrRtFmXZJcRjgofO3UsE880ZHRau3Uj3Gk+i7i5y7A6qqE
 ccrBsKpYN265hdVgtS1DI3So3be7CI2dB20G7n+baNbhhcMdzCXBzf8YIdL8uHHJaij+
 knlsqPCKqe3j9F0vUnJUjvo1RV53cSHRpB29zdaICjv3e8Hd+gTUhja9y2saeUZW3LfG
 V4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354293; x=1696959093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c/FZaZNCOMSfV9rgR/7MTnUZZZXhYKw4ogSZ+5ucjRw=;
 b=nyuPubn2/6JfXpH6WWxIEACj086cqOWL4+HeYYhGK9iQgm7agxVsv/EVmUokqMXd7c
 ul59avaau8L+TeqQmyPjlPL/VyGZ+2h2Zvd0hSq8tm6fXoRBwT6sEEK4jDFM7MuXlmWO
 dMiUKFXqzk+w9PcCngLs3z8zMhz4cdrBGBNeOyeKhnH5Ir3Kqhn8Kcb8BxFy2Z+EBNkT
 EMzthnC1jSHcXHCkmO1CKEMHVEtJEXydWMN1oTAtZn2a0NHIQZsiIBuOWe1DSkar4E84
 PdIjwJVAZgkzoU68/3e6msnCzk/JJFLDxxby/jseicIikIPXOPUQc0pGfF+KPRmjgHZG
 oh9g==
X-Gm-Message-State: AOJu0YzpzWXln3u4ijXli8c1tHUfBZqfLwklarrSn++cMynQY6zxIOoK
 fQIG6gaBMjTWI4vj0NWtWyXTd4INsIRjKNSdxTo=
X-Google-Smtp-Source: AGHT+IHYVAyKJy93RH5ldXukLjJmE2hs/oDSYLzgem2QGAO5X62R0MlTLyb9bKyAizUiAMt2ooBf1A==
X-Received: by 2002:a05:6a21:6811:b0:15e:b8a1:57b0 with SMTP id
 wr17-20020a056a21681100b0015eb8a157b0mr63304pzb.39.1696354293325; 
 Tue, 03 Oct 2023 10:31:33 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 36/47] exec: Rename cpu.c -> cpu-target.c
Date: Tue,  3 Oct 2023 10:30:41 -0700
Message-Id: <20231003173052.1601813-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
index 81625f036b..f82b78afa8 100644
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
@@ -1766,7 +1767,6 @@ M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Yanan Wang <wangyanan55@huawei.com>
 S: Supported
-F: cpu.c
 F: hw/core/cpu.c
 F: hw/core/machine-qmp-cmds.c
 F: hw/core/machine.c
diff --git a/meson.build b/meson.build
index 21a1bc03f8..0760c29857 100644
--- a/meson.build
+++ b/meson.build
@@ -3431,8 +3431,8 @@ if have_block
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


