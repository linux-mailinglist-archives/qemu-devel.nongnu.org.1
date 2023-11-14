Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F567EB4E3
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 17:32:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wKg-00039C-4q; Tue, 14 Nov 2023 11:32:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2wKd-00038R-Du
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:32:07 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2wKb-0006an-G3
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:32:07 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9bf86b77a2aso858903566b.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 08:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699979524; x=1700584324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WTlDtVgsnwcqvtsJBU/yKayNDVYOQAUQMToAEPEK6Gk=;
 b=nuEFZDw3TtMaKNUd/Hh5GoHAP/wESvt2MJgXiPM6t+xxDuHDHHxWsOhjSR4dVo8TT4
 CzK5yFV8O2PTZ1gZ5bZStx1B6rWH+sRa26teHx+cxpwDUmMTindf/fWN+UV6dX3cSse/
 JQ8qfMGUO089TzH4LEdYydR2sP/G/sgCZdcBP2nlRoBTesQV+pXMUsbnjn07WSLovSx2
 ygGNGn7uILSuSkQB2gzhZjtej5rOUz+gsAo1Z7MP840FMX0P6sG+8sYumODdPrbe4NPS
 Bfy/BYKwKplX2C9sA5B3ySfOQIuXopCqE76kxOXmCMjw1PXS5IW419ErUJXoK3reuEL5
 usPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699979524; x=1700584324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WTlDtVgsnwcqvtsJBU/yKayNDVYOQAUQMToAEPEK6Gk=;
 b=TgZpzUqOE7HHWIQKBW0MrTBv1YxI+yYxU8I3iV/qF7mxInctr+bn4gF1cyJpczmu77
 +8nadDvRxVleB1QWGpHDKdmRMh6e0CJwgc7UquKXNpylHd+Y9eCQF0Ok2x7pBMZOEMjF
 vGFv7jY3nTWoduLhu3CFJU4rLfHXx7gtILW3Oev74VJP0lljJdwlotbw7/c5qIIxIoXu
 GyRCaKWKoKxqhcxUDrvSmUkfd2LWTsbdTvawPWt5FRXl1ntNPy1tYi5aKdKqZumj+Zor
 l8MfM5PVBudqY1EnpFQpR6Q7cW7y/iOGQxJTUwvhA2TYSZOVkA5fQaUaX0HX3Knw6/ga
 dnpw==
X-Gm-Message-State: AOJu0Yz97l7C2mwu6QI2XojexvpDeVveEd4osVioBN4HzDVFf+AAdWpE
 18r3Auas4heppjW7yk+uL2T137Uk6EsJySuqVtM=
X-Google-Smtp-Source: AGHT+IHt381u+VrZTF53LFbjgSQ6v/t56GRcLe7EuiK5Y6nqGj9R0LI6bw4MbxrPYnsq1mWw3maHWw==
X-Received: by 2002:a17:906:3458:b0:9dd:dc2a:eb8b with SMTP id
 d24-20020a170906345800b009dddc2aeb8bmr6116891ejb.41.1699979523898; 
 Tue, 14 Nov 2023 08:32:03 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 b11-20020a1709062b4b00b009b2b47cd757sm5740724ejg.9.2023.11.14.08.32.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 08:32:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [RFC PATCH-for-9.0 6/9] hw/xen/hvm: Initialize xen_physmap QLIST in
 xen_read_physmap()
Date: Tue, 14 Nov 2023 17:31:20 +0100
Message-ID: <20231114163123.74888-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114163123.74888-1-philmd@linaro.org>
References: <20231114163123.74888-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

xen_read_physmap() is the first function requiring
xen_physmap QLIST being initialized. Move the init
call there.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/xen/xen-hvm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 789779d02c..3b9c31c1c8 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -532,6 +532,8 @@ void xen_read_physmap(XenIOState *state)
     char path[80], *value = NULL;
     char **entries = NULL;
 
+    QLIST_INIT(&xen_physmap);
+
     snprintf(path, sizeof(path),
             "/local/domain/0/device-model/%d/physmap", xen_domid);
     entries = xs_directory(state->xenstore, 0, path, &num);
@@ -575,6 +577,7 @@ void xen_read_physmap(XenIOState *state)
 #else
 void xen_read_physmap(XenIOState *state)
 {
+    QLIST_INIT(&xen_physmap);
 }
 #endif
 
@@ -595,7 +598,6 @@ void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
 
     xen_register_ioreq(state, max_cpus, &xen_memory_listener);
 
-    QLIST_INIT(&xen_physmap);
     xen_read_physmap(state);
 
     suspend.notify = xen_suspend_notifier;
-- 
2.41.0


