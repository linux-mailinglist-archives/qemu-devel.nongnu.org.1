Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3379D7EB4E6
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 17:33:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wKS-00034Y-V3; Tue, 14 Nov 2023 11:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2wKR-00033m-BR
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:31:55 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2wKP-0006Wn-O4
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:31:55 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53e08e439c7so9510582a12.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 08:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699979512; x=1700584312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hRnzgqjbzRTGqJ5jrYQJxW1BmP5r27YtuyDu1IVzHFA=;
 b=zlbIMCcsH3CK7EKk2fIxJKaNewLV20JmOwIGdJ3tS1Zm688KZ0Qwu1P7tsjLlXE9/S
 r8mmqpIwu5RJDC29yEdqTQspp4lA8jgcKAwXsrYECR18voio9U+Uk6QLz9b+QZT+FZe9
 rpdVsSZ7CLVIcLrrjjpZ8jRSkApecJsbz71I7tnEnc96oL6qnz2XHUATRxBNb0j7W96l
 tPOQ/sV76vjOBA1e9uNLE/jWBdbVgatqiCCv8yx9b7cie+U70ihCm9F/3mN1Ny+KynKM
 RGXhk4YGbfIPwalI4kQonj6NTpAwwNd3By4ayVoiS4XsdalBMmiQJhpKM6O5jgUo9e5U
 fU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699979512; x=1700584312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hRnzgqjbzRTGqJ5jrYQJxW1BmP5r27YtuyDu1IVzHFA=;
 b=iLNf2RZh+D+TR2dy0OcH+4SYIpSMx6VFBzPpYpn29FGIYDCEirgyfpq2X2JQ5uNM0P
 dOqmRUlpvtdMxjywAFwJpOjH0Mj0Hhv0g3VhXLUNmoKGo7PyUou5cOAxXZ4S/CKgG7bo
 vmAIG6QqWYSsp/GIbIA8FkGas+S5nxYKgLy9Tv5yFcbYgQXvcIw/9lqvk4u1K+2+Hg4V
 bOs2d9kGQBWWtjEAcZ/W/pshyUTQH8zB4/WNWSPjFxvimRoYGNQSisId+SPO7l+hAc4U
 rSKamzd6Ebvr30qiKa9g5p/6RRM+yU1rA7W5JVDih7kbm3trQBdpiOKXcG27eViGfxNL
 TQXA==
X-Gm-Message-State: AOJu0YxrA1uC5dHyVQhvrJNCTdF1zPapYU5tCi0k//DtWy9YeSGwctTv
 9l0XHY4HYMXfxjH+EpwNUGDem0hbU6pw5gLbICY=
X-Google-Smtp-Source: AGHT+IE8/KnAMA1FjOTiA03DDYyTyNl6glp0CwMJ10smYv5ORjVAvozuUmjkzAh9auk1H2jVfOhg2Q==
X-Received: by 2002:a05:6402:3cf:b0:543:70c2:aa8d with SMTP id
 t15-20020a05640203cf00b0054370c2aa8dmr7379909edw.15.1699979511911; 
 Tue, 14 Nov 2023 08:31:51 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 d17-20020aa7c1d1000000b0052febc781bfsm5327156edp.36.2023.11.14.08.31.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 08:31:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH-for-9.0 4/9] hw/xen/hvm: Expose xen_memory_listener declaration
Date: Tue, 14 Nov 2023 17:31:18 +0100
Message-ID: <20231114163123.74888-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114163123.74888-1-philmd@linaro.org>
References: <20231114163123.74888-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

There can only be a single xen_memory_listener definition
in a qemu-system binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/xen/xen-hvm-common.h | 1 +
 hw/arm/xen_arm.c                | 2 +-
 hw/i386/xen/xen-hvm.c           | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
index 83ed16f425..0fed15ed04 100644
--- a/include/hw/xen/xen-hvm-common.h
+++ b/include/hw/xen/xen-hvm-common.h
@@ -18,6 +18,7 @@
 extern MemoryRegion xen_memory;
 extern MemoryListener xen_io_listener;
 extern DeviceListener xen_device_listener;
+extern const MemoryListener xen_memory_listener;
 
 //#define DEBUG_XEN_HVM
 
diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index b478d74ea0..39dcd74d07 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -38,7 +38,7 @@
 #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
 OBJECT_DECLARE_SIMPLE_TYPE(XenArmState, XEN_ARM)
 
-static const MemoryListener xen_memory_listener = {
+const MemoryListener xen_memory_listener = {
     .region_add = xen_region_add,
     .region_del = xen_region_del,
     .log_start = NULL,
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index b64204ea94..a65a96f0de 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -469,7 +469,7 @@ static void xen_log_global_stop(MemoryListener *listener)
     xen_in_migration = false;
 }
 
-static const MemoryListener xen_memory_listener = {
+const MemoryListener xen_memory_listener = {
     .name = "xen-memory",
     .region_add = xen_region_add,
     .region_del = xen_region_del,
-- 
2.41.0


