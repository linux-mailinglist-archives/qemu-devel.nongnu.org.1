Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C43792288
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 14:22:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdV4h-0003jG-OC; Tue, 05 Sep 2023 08:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdV4E-0003Tm-Sb
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 08:22:04 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdV49-0000pC-Nc
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 08:21:59 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-401da71b85eso23975685e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 05:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693916515; x=1694521315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gzxK/xbqt7oVpzvsNE0mB2t8RXiKOYU8OLm+TL14vNw=;
 b=VRSFKpPkpoAHefW8vIXHqEINvVaKm2dlEBiGmRheqcapLPFE4iPR8axW4TTUmXTdMh
 dEABrrCCkd5TAlzOy45ZmDeZHSh8TME7f4jsYdqRFC3uP1mbdKPEEmxQui321491KTCS
 QCnMGcHE+YbArGVpOCw6ODvjb7Ob9mGR4/zorlDyMXrYUTekWhD8Nvk/NWeTuJLiykum
 LdokdgEYBj3vO5ccKUAPBhpiqtyQSO9bJSdgaF0MKLeEZVVry2Vn8RG08HUodjslp4ei
 XCLzictG+mOf+vVlphwR4hMhfH/PUvYcPwrichtW5CRIiffsF6q4g2/UdDu/nyQF9iFZ
 4g9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693916515; x=1694521315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gzxK/xbqt7oVpzvsNE0mB2t8RXiKOYU8OLm+TL14vNw=;
 b=PsjJ8rS23Ch2jMJltRgDm+Mz+ykuSdvEt5mYEJbN+DYF780w7NYSv4XvI9DNS1/OAE
 J0WsuWLTJOpMJ6LGlnxvYnPljCwdsMUJRT3qKdTSIn7h+omGk8g2SQ/zn7zxOog9awBP
 h+Ha5nozqQoCuyljPU/wKXz7wmxlqoB8E2+s9vGizCZHwGSuPJsPypuDl15vfYLo1G2F
 Qaciq3gLEBfAJT4Usye6ACiWFEf2D94EfKwAxMKLiVETKCueVREo3OVqtzgDyqrtIjLk
 0iEvaA5RoDAk3IEy8+bu78uYg+prRCBfS3XCKu2bleBjCxQBKHHYqHKYdyJip8fy41rp
 p2sQ==
X-Gm-Message-State: AOJu0YwL52Y9Uxa36wRi/19BK3BIN4hhauVNaIaOWoSCQSjxijMGuFTR
 sSDue/N3DlQ53s7B8C6SKvdgyq/gIrSY/QsyruY=
X-Google-Smtp-Source: AGHT+IHbz5YkYNFi6ne5hl8VA0Ok/qvzggQRihAZp+7XxeX9TpfDtJE/W1Zlywnx0kt8k7q4Mg47Ow==
X-Received: by 2002:a5d:56c7:0:b0:314:3a3d:5d1f with SMTP id
 m7-20020a5d56c7000000b003143a3d5d1fmr9789209wrw.19.1693916514769; 
 Tue, 05 Sep 2023 05:21:54 -0700 (PDT)
Received: from localhost.localdomain ([37.69.27.38])
 by smtp.gmail.com with ESMTPSA id
 bp5-20020a5d5a85000000b0031f07d1edbcsm14680949wrb.77.2023.09.05.05.21.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Sep 2023 05:21:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 2/3] sysemu/xen: Remove unreachable xen_ram_alloc() code
Date: Tue,  5 Sep 2023 14:21:41 +0200
Message-ID: <20230905122142.5939-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905122142.5939-1-philmd@linaro.org>
References: <20230905122142.5939-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

The xen_ram_alloc() call in softmmu/physmem.c is guarded
by checking for xen_enabled(), which evaluate to 'false'
when XEN is not built in. The compiler elide the function
call, and thus the inlined function is not used. Remove it.

Inspired-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/xen.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
index 9b2d0b21ff..1f797a9abe 100644
--- a/include/sysemu/xen.h
+++ b/include/sysemu/xen.h
@@ -27,8 +27,6 @@ extern bool xen_allowed;
 #define xen_enabled()           (xen_allowed)
 
 void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
-void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
-                   struct MemoryRegion *mr, Error **errp);
 
 #else /* !CONFIG_XEN_IS_POSSIBLE */
 
@@ -38,12 +36,10 @@ static inline void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
 {
     /* nothing */
 }
-static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
-                                 MemoryRegion *mr, Error **errp)
-{
-    g_assert_not_reached();
-}
 
 #endif /* CONFIG_XEN_IS_POSSIBLE */
 
+void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
+                   struct MemoryRegion *mr, Error **errp);
+
 #endif
-- 
2.41.0


