Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8443673A59E
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:09:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCMrX-0002Qt-IG; Thu, 22 Jun 2023 12:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCMrV-0002Gj-5k
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:08:45 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCMrS-0007eG-Fa
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:08:44 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3111547c8f9so8486981f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 09:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687450120; x=1690042120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+JIxHWMClVl6mvpALDoBK231PZeNGUQgT3foMweSwl8=;
 b=m+sOyJwBwsltlHfQ5plMWKOLIis+OEb+I+kYqnZLv4G8Ud23JDgwJFKc5QbUKlQQoS
 1zKSS1dPuy4yqZPNl6TAEFOkN/4qh6Z7q8wJxnI3w+xUocRyREHjcikLswb/B58iAjAw
 i0Kwl0CU2mChgimY0x1pocirTiLNpGhvP2OOxOZgzVdLhbaNm1KhLhoBCcbuNucTQQ3G
 RtyEsciQU1EctCDZTXKzkq/56Q8BpF4exuWzK5Zi9+g+wdZDHRqUsfqn3qJyaskO1hMN
 ORq6jEFNL0dLVh/Tn8LHeYLlV/JThI4azyQy/GqlByxiQt/VVPM3RXqUH7+Gq+EH6hC4
 YgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687450120; x=1690042120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+JIxHWMClVl6mvpALDoBK231PZeNGUQgT3foMweSwl8=;
 b=Q8irszQLNSxAHb+wNZ/BL87wM3PPPzCkuljy8U79ZdaQWAPwHTQS+VJ1xPS7DHL0rn
 WbHkn6pJ0N2PC0B8g9KJEbLDyXgjKT3jFqF8Nz1M2ehVwnua++hFoxbJhhO0YNRfkHxY
 vt63qtWf/q+xLQImhM46BilFk3ES7ae0sNs4ESjAFZFSx/MQ5EEL+VuPR1MODdTPRxvZ
 ohTqURC83YLXcTgWiEJhVN6z4UtS8+qegtdt5elW30lIEDiIW1xsLAmVsXA6ip4bHW/n
 Jw2eUuXUiy0ZDkyeEzCJJ2TkeeI5lmOmHvyYukz4hWfK5MPmxuR9JXor0rZgM2y87BCc
 nW6w==
X-Gm-Message-State: AC+VfDyhlFeDxHM1WyKvifEbb0ZTV93i3O2gqTmRqk8oUzshaDtSaQXJ
 C7UHy4xBGb7zJBvM2AApoq3gGg+5pvQMSQlPr05vHg==
X-Google-Smtp-Source: ACHHUZ6j9PL4gNb09NvEUjJSuIorrjesDgNKCq1cC1uX5pyBuSA6/zCj91wre6SrtXJc4I0XeTLuqQ==
X-Received: by 2002:a5d:67cd:0:b0:2ef:b052:1296 with SMTP id
 n13-20020a5d67cd000000b002efb0521296mr16834670wrw.22.1687450120463; 
 Thu, 22 Jun 2023 09:08:40 -0700 (PDT)
Received: from localhost.localdomain (230.red-88-28-3.dynamicip.rima-tde.net.
 [88.28.3.230]) by smtp.gmail.com with ESMTPSA id
 k7-20020a5d5187000000b0031128382ed0sm7377909wrv.83.2023.06.22.09.08.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jun 2023 09:08:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Durrant <paul@xen.org>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Eduardo Habkost <eduardo@habkost.net>,
 Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2 01/16] MAINTAINERS: Update Roman Bolshakov email address
Date: Thu, 22 Jun 2023 18:08:08 +0200
Message-Id: <20230622160823.71851-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230622160823.71851-1-philmd@linaro.org>
References: <20230622160823.71851-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

r.bolshakov@yadro.com is bouncing: Update Roman's email address
using one found somewhere on the Internet; this way he can Ack-by.

(Reorder Taylor's line to keep the section sorted alphabetically).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 4 ++--
 .mailmap    | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f323cd2eb..1da135b0c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -497,14 +497,14 @@ F: target/arm/hvf/
 
 X86 HVF CPUs
 M: Cameron Esfahani <dirty@apple.com>
-M: Roman Bolshakov <r.bolshakov@yadro.com>
+M: Roman Bolshakov <rbolshakov@ddn.com>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: target/i386/hvf/
 
 HVF
 M: Cameron Esfahani <dirty@apple.com>
-M: Roman Bolshakov <r.bolshakov@yadro.com>
+M: Roman Bolshakov <rbolshakov@ddn.com>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: accel/hvf/
diff --git a/.mailmap b/.mailmap
index b57da4827e..64ef9f4de6 100644
--- a/.mailmap
+++ b/.mailmap
@@ -76,9 +76,10 @@ Paul Burton <paulburton@kernel.org> <pburton@wavecomp.com>
 Philippe Mathieu-Daudé <philmd@linaro.org> <f4bug@amsat.org>
 Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@redhat.com>
 Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@fungible.com>
+Roman Bolshakov <rbolshakov@ddn.com> <r.bolshakov@yadro.com>
 Stefan Brankovic <stefan.brankovic@syrmia.com> <stefan.brankovic@rt-rk.com.com>
-Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
 Taylor Simpson <ltaylorsimpson@gmail.com> <tsimpson@quicinc.com>
+Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
 
 # Also list preferred name forms where people have changed their
 # git author config, or had utf8/latin1 encoding issues.
-- 
2.38.1


