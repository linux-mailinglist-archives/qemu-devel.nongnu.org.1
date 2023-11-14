Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFCC7EB4EB
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 17:33:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wKc-00037o-Ui; Tue, 14 Nov 2023 11:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2wKa-00037A-Sz
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:32:04 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2wKX-0006Y7-5l
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:32:03 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-507a98517f3so7716971e87.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 08:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699979518; x=1700584318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3H+/pStoCerFaavD4+6+pbKHikmNIDPKszX2p8LZLs8=;
 b=Oi4Ov/WtGnex3fHPkMbLHKC8V3SKWdpYona8TsW+lxRPeOdhCghGlRbP9gxqxNtl82
 bCdHg0FbjcqfMjhnLj8wbd6RUH0Op4o2Q+fLgLXqiL0kGaQJ8rngGo94J7ckx4X2gppK
 JKOqTo6EEP3bco11/9nH9Ku2htSTqfC6oD0gk31R6s79GXJE1CkHvOTCv5q06X0QadfN
 EkT4R6sksc2jcVllMNOJlLHa9sF2MEpgl8/sMR7BMiDyOHFAbFxJ6bUN11VF+7U4pdpI
 X3NGiwU+GdvNeWVYFv0oGLOOlnLhRCuLqUAI2FAg4xBLx2E09GksUH9F6VJ+T8G7WAli
 YfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699979518; x=1700584318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3H+/pStoCerFaavD4+6+pbKHikmNIDPKszX2p8LZLs8=;
 b=xQzCwY82JMEPDR8Lj4MK8Ex51Ib5R3T4wpGiWhgLQBH4nZJ9MnmjOB/KVyTWSR4Rpf
 5H7vgnjSeFChxHkT2i5QpjNZaqBYlMV6dlB6hddXoMupLIfdTVm8EGWgNo6CEtcX+BpW
 A97So3pQnDfW2BnobQvfDP0JCScfZGqfsgnxMkO2ySQDDZLECvLD5OTiV3H+ypP21eIV
 F7Mj+M+ptqIINSqZrNvslR/EwQb9gBoyrtQExTMqshZlbUmYku5j+Nu77mX5D1oFFw1+
 FtNO0ViwCvYrBLqc3uvAeKP3JzN0LBiv2eXsb6DYjIeZ1WKsBTdg/AWD/0OxfDBHWGxw
 cjdA==
X-Gm-Message-State: AOJu0YyWZzEiX5w+gQ+JwJcz/itSKDK8Uag6cPmS40J9qQnVmiVaZXxV
 lsTuUTlVTJuAww56fPyqvEFsgzEpQFIrDATpnyQ=
X-Google-Smtp-Source: AGHT+IFU6wDkoylQ5/58cZgzmE5wfkRGyUxVY57V7J9SRhQ2EOS6zAeN62VBuenc3iIc8vTnT/LH0w==
X-Received: by 2002:a19:9103:0:b0:507:9f4c:b72 with SMTP id
 t3-20020a199103000000b005079f4c0b72mr5872272lfd.15.1699979517897; 
 Tue, 14 Nov 2023 08:31:57 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 c19-20020a50f613000000b00542d3e470f9sm5386152edn.10.2023.11.14.08.31.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 08:31:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH-for-9.0 5/9] hw/xen/hvm: Expose xen_read_physmap() prototype
Date: Tue, 14 Nov 2023 17:31:19 +0100
Message-ID: <20231114163123.74888-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114163123.74888-1-philmd@linaro.org>
References: <20231114163123.74888-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

In a pair of commit we are going to call xen_read_physmap()
out of hw/i386/xen/xen-hvm.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/xen/xen-hvm-common.h | 1 +
 hw/i386/xen/xen-hvm.c           | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
index 0fed15ed04..536712dc83 100644
--- a/include/hw/xen/xen-hvm-common.h
+++ b/include/hw/xen/xen-hvm-common.h
@@ -97,6 +97,7 @@ void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
 
 void cpu_ioreq_pio(ioreq_t *req);
 
+void xen_read_physmap(XenIOState *state);
 void xen_arch_handle_ioreq(XenIOState *state, ioreq_t *req);
 void xen_arch_set_memory(XenIOState *state,
                          MemoryRegionSection *section,
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index a65a96f0de..789779d02c 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -525,7 +525,7 @@ static void handle_vmport_ioreq(XenIOState *state, ioreq_t *req)
 }
 
 #ifdef XEN_COMPAT_PHYSMAP
-static void xen_read_physmap(XenIOState *state)
+void xen_read_physmap(XenIOState *state)
 {
     XenPhysmap *physmap = NULL;
     unsigned int len, num, i;
@@ -573,7 +573,7 @@ static void xen_read_physmap(XenIOState *state)
     free(entries);
 }
 #else
-static void xen_read_physmap(XenIOState *state)
+void xen_read_physmap(XenIOState *state)
 {
 }
 #endif
-- 
2.41.0


