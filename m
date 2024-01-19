Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E078328FE
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:41:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQnAg-00033X-Qq; Fri, 19 Jan 2024 06:36:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnAc-0002uC-85
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:36:22 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnAZ-00022r-05
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:36:21 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e779f030aso4015225e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705664176; x=1706268976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lEBY/QoJw39gPaelo1yXBjmSZBtzyiV4TS+i3QbPQJM=;
 b=Nw+dTagW1+d6LhKDba/gyndclCxvvQoFFz3LJR/KjY92aNF4CQ9oYOGcrhopwsZy2i
 M1OuBpYsTwB29K00ykYB7gP+2tvj/W21DKkPDUSQzlJXqrVdahY02Ru9ErI8rsO03M0z
 jGg9kSqVOVvbz61D57F7aDEspJh1hvvm6g3c5euD1H4vx5UXFR8W6n7wrscAY8nE4Zhv
 ZVVhofRhrRPgQFDa4C+U/gwQoZdyTgPEKc17+LUbA1T43++wQE8oz/GGJYhXU37Fo+4u
 F69OX4AhqoVSuyyq7SaH6mbTpdT7qLCcXK5A3X3DLyHpabFV3LZokoq5N+8wAjq3gA/7
 Uarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705664176; x=1706268976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lEBY/QoJw39gPaelo1yXBjmSZBtzyiV4TS+i3QbPQJM=;
 b=E5FxK89fz3TE4TTWKb4w/CXQk+CPtNGGtJrj6gzFpuVXnOmMsR0jVSlCFECQuXXsvp
 A9fJKjU7jkwWEVoXB8w387lIQ0I2DRuz5rf8n8LvkyPNhTqJ2e8YtJJK/LEHbrxsEB05
 qDj0UpRBMI+DKz+KGgkFVRw+w9d2tcvDVQch7m62cpOmdT/RFkNxN0RGHyqbWt3KGi3Y
 ZMV0m7cyC8J2UvBajON1XAQny7OjZflWkjJh2R9iXHRGw+RKJdanVylHee4ML2hb1PHK
 KMjBew2BcDk4/xQWXA4blH+jgko8du05aKAp7pEubMnj0iAGIFAsptCuOCVlnXnp1m9a
 6JVQ==
X-Gm-Message-State: AOJu0Yw8f3g2DEY8V01mntw6PdNbxmTAwdBV0zcTqv8W03hozDCLTnbK
 nXTOoir+xNXpNVJME2r/AvcrgvrXvTZind0817bTzuWkJh2N3k8KySl7bu22AfKXw1HUtVz6gno
 LFZdf5Q==
X-Google-Smtp-Source: AGHT+IHeteUmgwAwy4JhqSXuAP9WItdxEigyNMJ0LqUhFfJ0EEy9EGExUg4AliU0+wFjYRuXuKt8Vg==
X-Received: by 2002:a1c:7706:0:b0:40e:84f3:7e11 with SMTP id
 t6-20020a1c7706000000b0040e84f37e11mr477000wmi.81.1705664176322; 
 Fri, 19 Jan 2024 03:36:16 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 r17-20020a05600c459100b0040e88fbe051sm8678595wmo.48.2024.01.19.03.36.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 03:36:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, Samuel Tardieu <sam@rfc1149.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Magnus Damm <magnus.damm@gmail.com>
Subject: [PULL 15/36] target/sh4: Deprecate the shix machine
Date: Fri, 19 Jan 2024 12:34:44 +0100
Message-ID: <20240119113507.31951-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119113507.31951-1-philmd@linaro.org>
References: <20240119113507.31951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Samuel Tardieu <sam@rfc1149.net>

The shix machine has been designed and used at Télécom Paris from 2003
to 2010. It had been added to QEMU in 2005 and has not been maintained
since. Since nobody is using the physical board anymore nor interested
in maintaining the QEMU port, it is time to deprecate it.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240109083053.2581588-2-sam@rfc1149.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst | 5 +++++
 hw/sh4/shix.c             | 1 +
 2 files changed, 6 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 2e15040246..e6a12c9077 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -269,6 +269,11 @@ Nios II ``10m50-ghrd`` and ``nios2-generic-nommu`` machines (since 8.2)
 
 The Nios II architecture is orphan.
 
+``shix`` (since 9.0)
+''''''''''''''''''''
+
+The machine is no longer in existence and has been long unmaintained
+in QEMU.
 
 Backend options
 ---------------
diff --git a/hw/sh4/shix.c b/hw/sh4/shix.c
index aa812512f0..eb3150b5bc 100644
--- a/hw/sh4/shix.c
+++ b/hw/sh4/shix.c
@@ -80,6 +80,7 @@ static void shix_machine_init(MachineClass *mc)
     mc->init = shix_init;
     mc->is_default = true;
     mc->default_cpu_type = TYPE_SH7750R_CPU;
+    mc->deprecation_reason = "old and unmaintained";
 }
 
 DEFINE_MACHINE("shix", shix_machine_init)
-- 
2.41.0


