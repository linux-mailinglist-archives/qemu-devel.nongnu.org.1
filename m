Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B6F7A0D9F
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 20:59:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgrXR-0007vD-A7; Thu, 14 Sep 2023 14:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrXN-0007uP-Ja
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:58:01 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrXL-0007fM-W6
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:58:01 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2bfb17435e4so20873701fa.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 11:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694717878; x=1695322678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t5Rz8HKuvZLDU2N58zBMis6gb93UGW7YVVT09iNRQGM=;
 b=WTWXyOiSigJOjXcwGBKxGooXul2ODrYEjkF9Db7pafPvUSR7BZbV9wMVEDuXxLpY/Q
 RbFu2RLAULYwrmx1WHzilpR3wzaTW5CZebfT7QxXlJAIlMgv3FAkj4zAzt7nAqdEHrdJ
 cXO2jS7VwwCcajDgbFODnAkPpatTYJXFHSjpO4hM13n3hiyH4FTQwyNP/sCX/Qs4oL5l
 onNq2GZKZHLHh/v4aZNSXFNrdnuRQh0zAqW3bqn9evlugvU77d7BfghsXSZpL5oaSvZj
 cs2SppSuruq+dzZoSuDahlXHR9zUV5Tqt9rBk+NAdp0oPd7Cz1kVqtlrUU3t3Usa9PDG
 ZITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694717878; x=1695322678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t5Rz8HKuvZLDU2N58zBMis6gb93UGW7YVVT09iNRQGM=;
 b=CZWKtZE21RTz0YOyK2RK6hLbkdTVStej0YCpzGYpMexc8/6y2hIp86/jx86sV6zai7
 dAEOi6HFbzfUPL1vdk7oE/l644jbtaQIPUIwsB1oH+Yd1frusqLjkvxFbdmrtwE8P5un
 4L8hn+L+Hxctb70brSyxN9wC6cToGRwzQZr8kkb9/YSOOlwFei5CynDvAFRHxC/wxHHW
 0nTIUAnGp61KO/Byt01idS0FrVxXEvjFfz+w9h/dMZRu8/csmogcNkRBY8DpKf4YIZyr
 LT6QLC+38pyLc/d3Dz2s5Defp1XMX3rhl4FJIkkLSUheij+/5bhtu/80BsR6YlzyPbdh
 JhNg==
X-Gm-Message-State: AOJu0YxRmFARkNQUoKmNCcoXGx0yOmRY08bDCpngs2Vn+P3EAIsoWqoA
 ltEgP33fk88pFKW7GSNmak+xd3iWX1VZkbWOhBs=
X-Google-Smtp-Source: AGHT+IFrpywYo6gUXk0tKxFk2qDI44GdC/4tVbLXtZSg9Lz27cqZI4oR40375IwXBR6x2ixBjchAvQ==
X-Received: by 2002:a05:651c:8f:b0:2bf:9576:afd4 with SMTP id
 15-20020a05651c008f00b002bf9576afd4mr5370974ljq.16.1694717878158; 
 Thu, 14 Sep 2023 11:57:58 -0700 (PDT)
Received: from m1x-phil.lan (176-131-223-129.abo.bbox.fr. [176.131.223.129])
 by smtp.gmail.com with ESMTPSA id
 x7-20020a170906134700b00992e94bcfabsm1378249ejb.167.2023.09.14.11.57.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Sep 2023 11:57:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/11] exec: Rename cpu.c -> cpu-target.c
Date: Thu, 14 Sep 2023 20:57:12 +0200
Message-ID: <20230914185718.76241-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914185718.76241-1-philmd@linaro.org>
References: <20230914185718.76241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

We have exec/cpu code split in 2 files for target agnostic
("common") and specific. Rename 'cpu.c' which is target
specific using the '-target' suffix. Update MAINTAINERS.
Remove the 's from 'cpus-common.c' to match the API cpu_foo()
functions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.41.0


