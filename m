Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1187973A5C1
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:11:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCMtk-00086Y-Q6; Thu, 22 Jun 2023 12:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCMtG-0007DG-Ah
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:10:37 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCMtE-00022X-Ki
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:10:34 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f9b258f3a2so49976115e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 09:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687450231; x=1690042231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xrWBSt50GXK7KCFoWhMRFDVlBR7e4c4Lap7a/Dv/MfQ=;
 b=uh16dyOE/YngV+vlrCn9FF7LTn5kqMPDeNAZPJp/OXd6o48t2oNQK6+xyZgF0O/Rwg
 eOGnESuioKTn+49rZFTitvpZbXcCCA2lKI3uKKPWDO6qAJwPVxKRyFjY6tswlOnD5ggQ
 uglMk0I6MEVmcZiNo50/xLJc3XKZtwUiYzcshho3Z8PHZ77Ff5SeMMqNEPPm+6yamswW
 43xD7f+l3wuUlEu0Jk5k14uNzXBhG+/BP5Z2LtMbnA+vN2SOlxaHgl9cD7Y/VNZS7ggW
 sXiU9m8gF/k7MyaKQbMxBUzf2iKP0B73BEmBKpJN7i3GqROl8rychDyAYceCJlDAbGA3
 M6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687450231; x=1690042231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xrWBSt50GXK7KCFoWhMRFDVlBR7e4c4Lap7a/Dv/MfQ=;
 b=OxvnBVIi8WaMI959h6NwzG1h/AGg5FMsc5GnWMTrpoRWI9dAqrwIZCIkrHxA6WDybB
 2iwxChyuyZkqGOsIU1lQbwwcU3PUYE6N2rr78v5WJTdPE1/BoW0gd801ptqeD3gq9Yj+
 aJ0VwDfpE8W6rSb1RTv2c/31cF/YxOWWAbNnoyPc9DSOWLDMyrBlo4Isacj3ceCdzEwB
 7ZqQzi95xFGIMhyobJp7xOHfc6wYddIbOrqxuHZGHyzlOrxJQQwVJWVeqv6RLt8hjEqq
 JxEjBwSV8TPqR6jFn9La8ka7VU0yvnVPeZ2AxnaKWfB8/q9WymIJiPFSAbHb6+XyLtxi
 Bb3Q==
X-Gm-Message-State: AC+VfDyYbWgb8KuPHx0wohQJN9Dk/Z8VX1SP6kqtJppMlbcDqrwKkHxO
 U0yu3pwmr3viBJYnHM8zBHxCfS7GRvi3AzW5z9ROJw==
X-Google-Smtp-Source: ACHHUZ5cB8aDLTQ/tjJec4fXZP1xWmF+PhC752VaaNKObmwfmqLXBqw27M1/B1ILuvDg4fp61kaDNA==
X-Received: by 2002:a1c:7911:0:b0:3f9:b2a9:c546 with SMTP id
 l17-20020a1c7911000000b003f9b2a9c546mr9068827wme.28.1687450231205; 
 Thu, 22 Jun 2023 09:10:31 -0700 (PDT)
Received: from localhost.localdomain (230.red-88-28-3.dynamicip.rima-tde.net.
 [88.28.3.230]) by smtp.gmail.com with ESMTPSA id
 8-20020a05600c028800b003f9c8c6bf53sm3978876wmk.13.2023.06.22.09.10.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jun 2023 09:10:30 -0700 (PDT)
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
Subject: [PATCH v2 12/16] accel: Remove WHPX unreachable error path
Date: Thu, 22 Jun 2023 18:08:19 +0200
Message-Id: <20230622160823.71851-13-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230622160823.71851-1-philmd@linaro.org>
References: <20230622160823.71851-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

g_new0() can not fail. Remove the unreachable error path.

https://developer-old.gnome.org/glib/stable/glib-Memory-Allocation.html#glib-Memory-Allocation.description

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/whpx/whpx-all.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 340053e6dd..012ba696a9 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2179,12 +2179,6 @@ int whpx_init_vcpu(CPUState *cpu)
 
     vcpu = g_new0(struct whpx_vcpu, 1);
 
-    if (!vcpu) {
-        error_report("WHPX: Failed to allocte VCPU context.");
-        ret = -ENOMEM;
-        goto error;
-    }
-
     hr = whp_dispatch.WHvEmulatorCreateEmulator(
         &whpx_emu_callbacks,
         &vcpu->emulator);
-- 
2.38.1


