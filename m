Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6C87EB2A6
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:42:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ubD-0007P0-HK; Tue, 14 Nov 2023 09:41:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uah-000611-PG
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:40:37 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uaV-0008Kb-Ly
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:40:35 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-53e751aeb3cso8835064a12.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699972822; x=1700577622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xWc7O88tTfL+IROUfXsM+NSd2X7VWDO4aCdpc797HXc=;
 b=CNEsi3so+btQYoMYE9vqoQFufHMRMk1f9ubh/3YZJgD21aT5jSZtvy7aNxIESE/q1u
 zlQ0AVHyA5MtFwmadi8E1wdH/dWb/b8uTy/oCq9Ki7AmEM3v/T9GoWr14kIflHgCMba4
 NTyCKByJi9Y5m1R/ukGhfzu/y5scZwocO3alHKH6aF4s59kUnwvbKdZNVF21/OV5fOEK
 lMX00EFFENchkvt393hxFV+MBnNUzAjwabry1kHtveUsdMetcK3/fq/0nqjpc6JiRnlc
 Ms1V2kHnnZ1Zr9BjUrcCVg1XuIuQgFQbhURC5S2sazxH7xVTJiKBwSzFTGjcBmJr0l9G
 Vd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699972822; x=1700577622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xWc7O88tTfL+IROUfXsM+NSd2X7VWDO4aCdpc797HXc=;
 b=wwcNAE/8R2P5NFG/JbqhE/sHb1OiGX3SJDGaDcceIQVk+hXkZFrE7QRIz6JgIrvrXo
 93+7M9Z5zWKrTnlwRvk1yV600LS3R8Y+h4o08gSD8zgTgihIEq707QiYSKd4kNS43F8+
 UyPjtt58IyeD42JRoiVXPL8kUSX1whLPLfFvCMHU/BDPeTPQ3I+bX0ucJiWV0i65fK0M
 9rff/aTI1HwMmuS4VjAryrEaSeUVk55NytXcbPWnn1PO5PG++QTD7r+TcA0OJDNjG3K1
 /gIeQx0TjhBegFojVFFhRe73m+UOYJ/1dEa1VuQDlbH9w9hi88ZSWrHc9kd3/Tuym+H4
 +FKg==
X-Gm-Message-State: AOJu0Yw4SOaIuDRBOhbBuMfS7+WYDAPehw0orTjs8O248dPVTGqDHD70
 uX+2RBLk+GP9OgKgnRwLnG83zw==
X-Google-Smtp-Source: AGHT+IHNrn5T4boQ0NzVhZdNm2rxcLbpt1HdZaO6IACtyCbzFgVV5y7RIxXgNNvQBcNbwz/XH0TntA==
X-Received: by 2002:a05:6402:518e:b0:543:5c2f:e0e6 with SMTP id
 q14-20020a056402518e00b005435c2fe0e6mr7401790edd.17.1699972821905; 
 Tue, 14 Nov 2023 06:40:21 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 e29-20020a50d4dd000000b0052e1783ab25sm5343752edj.70.2023.11.14.06.40.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 06:40:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: David Woodhouse <dwmw@amazon.co.uk>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Anthony Perard <anthony.perard@citrix.com>, kvm@vger.kernel.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH-for-9.0 v2 18/19] hw/i386/xen: Compile 'xen-hvm.c' with Xen
 CPPFLAGS
Date: Tue, 14 Nov 2023 15:38:14 +0100
Message-ID: <20231114143816.71079-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114143816.71079-1-philmd@linaro.org>
References: <20231114143816.71079-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

xen-hvm.c calls xc_set_hvm_param() from <xenctrl.h>,
so better compile it with Xen CPPFLAGS.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/xen/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/xen/meson.build b/hw/i386/xen/meson.build
index 3dc4c4f106..3f0df8bc07 100644
--- a/hw/i386/xen/meson.build
+++ b/hw/i386/xen/meson.build
@@ -1,8 +1,10 @@
 i386_ss.add(when: 'CONFIG_XEN', if_true: files(
-  'xen-hvm.c',
   'xen_apic.c',
   'xen_pvdevice.c',
 ))
+i386_ss.add(when: ['CONFIG_XEN', xen], if_true: files(
+  'xen-hvm.c',
+))
 
 i386_ss.add(when: 'CONFIG_XEN_BUS', if_true: files(
   'xen_platform.c',
-- 
2.41.0


