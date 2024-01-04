Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDF2824A93
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 23:00:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLVjM-0001YS-Jd; Thu, 04 Jan 2024 16:58:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rLVjL-0001YD-7L
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:58:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rLVjJ-0003Nq-MW
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704405501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/uDi4hdadcNMfRKx6ixOC0QgHn/W3XRuPYkCGT+T/aw=;
 b=CM1M/2+r9x++P1cO0z3Y4QbgLXE2zbDPRYC0l5nfmh89pqqPIdNrxbyVN6aHFgRIg1iB1J
 iZ1jVi/An1jjQX9dWQJIJ1pxi4X9vN8lECaxjvd6m5p4T8aP3zn8XWBwSFkTZygZ/LLaDc
 RzCnV6+7+241ln17NKMc5FXIF9ilpPg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-VeJIljweM1iq4jo9xXfvSw-1; Thu, 04 Jan 2024 16:58:19 -0500
X-MC-Unique: VeJIljweM1iq4jo9xXfvSw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ccc4841251so10562311fa.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 13:58:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704405497; x=1705010297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/uDi4hdadcNMfRKx6ixOC0QgHn/W3XRuPYkCGT+T/aw=;
 b=YVrhMrcJQ+uqOIgHhQtm6KatNmrnSlCrtgnzCQ+5AqvD+qhnnPyXd0PwNCIA/GlZUh
 DghLJb2VMt4OQgiF7sO9rVHhlvzYjHRSS/U+lD74AwPeNHMLAhCKLBaXm3pn0CqJqNJj
 7EEjZzeXbQBbpiDeKlBfBNvaO88vQJhOYTHGwQKT6lt9jv41yKg+2/CdQC3VQK+0w+JN
 neALM8AJC6wu5pfrdvnS4XkeRmYmZF7SS7bKWpPMY8IrGe23S3eJYHHutfdFbKX+bOri
 VfTIogqUiDzGsJ8vWg9XHPnsQVLrgxwBnI2DTeO+MjdDlxX2mGMuy64o7d3hZOKQmBNh
 FJfA==
X-Gm-Message-State: AOJu0YzKi3NYYjuCcENVHMCUaj/TUqYndzZ9ZVaYnc+ySlRLGce+wTeS
 dJjFoQHVV7RywVM348Z2eSYnoCVpQZ44ksRG9YT9YeCuj25foW0uiEFkVfohanVgtRn6lk3xpCF
 qxoLqR6N6zbYfnUcMX1/E+FTNoEtMFHvZPM9oFsIK7AnRDbhrDcYcjtHBGrVVumeEpp8okWrAL4
 dCi1CYPvA=
X-Received: by 2002:a05:6512:3c86:b0:50e:3818:ec3c with SMTP id
 h6-20020a0565123c8600b0050e3818ec3cmr586930lfv.63.1704405497416; 
 Thu, 04 Jan 2024 13:58:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKG2OBfDdQASbFQfqMePlnTN1r/Zqfb+luUP+gN+Y4AvtcoeE5OmBovEv48yZz7cGnJkIOpw==
X-Received: by 2002:a05:6512:3c86:b0:50e:3818:ec3c with SMTP id
 h6-20020a0565123c8600b0050e3818ec3cmr586925lfv.63.1704405497019; 
 Thu, 04 Jan 2024 13:58:17 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a056402248c00b005561c3997c6sm182979eda.9.2024.01.04.13.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:58:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
	balaton@eik.bme.hu
Subject: [PATCH v2 1/8] vga: use common endian swap macros
Date: Thu,  4 Jan 2024 22:58:04 +0100
Message-ID: <20240104215813.156153-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104215813.156153-1-pbonzini@redhat.com>
References: <20240104215813.156153-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The constant-expression bswap is provided by const_le32(), and GET_PLANE()
can also be implemented using cpu_to_le32().  Remove the custom macros in
vga.c.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/vga.c | 67 +++++++++++++-----------------------------------
 1 file changed, 18 insertions(+), 49 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 37557c3442a..02a7deb66f8 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -90,58 +90,25 @@ const uint8_t gr_mask[16] = {
     0x00, /* 0x0f */
 };
 
-#define cbswap_32(__x) \
-((uint32_t)( \
-                (((uint32_t)(__x) & (uint32_t)0x000000ffUL) << 24) | \
-                (((uint32_t)(__x) & (uint32_t)0x0000ff00UL) <<  8) | \
-                (((uint32_t)(__x) & (uint32_t)0x00ff0000UL) >>  8) | \
-                (((uint32_t)(__x) & (uint32_t)0xff000000UL) >> 24) ))
-
-#if HOST_BIG_ENDIAN
-#define PAT(x) cbswap_32(x)
-#else
-#define PAT(x) (x)
-#endif
-
-#if HOST_BIG_ENDIAN
-#define BIG 1
-#else
-#define BIG 0
-#endif
-
-#if HOST_BIG_ENDIAN
-#define GET_PLANE(data, p) (((data) >> (24 - (p) * 8)) & 0xff)
-#else
-#define GET_PLANE(data, p) (((data) >> ((p) * 8)) & 0xff)
-#endif
-
 static const uint32_t mask16[16] = {
-    PAT(0x00000000),
-    PAT(0x000000ff),
-    PAT(0x0000ff00),
-    PAT(0x0000ffff),
-    PAT(0x00ff0000),
-    PAT(0x00ff00ff),
-    PAT(0x00ffff00),
-    PAT(0x00ffffff),
-    PAT(0xff000000),
-    PAT(0xff0000ff),
-    PAT(0xff00ff00),
-    PAT(0xff00ffff),
-    PAT(0xffff0000),
-    PAT(0xffff00ff),
-    PAT(0xffffff00),
-    PAT(0xffffffff),
+    const_le32(0x00000000),
+    const_le32(0x000000ff),
+    const_le32(0x0000ff00),
+    const_le32(0x0000ffff),
+    const_le32(0x00ff0000),
+    const_le32(0x00ff00ff),
+    const_le32(0x00ffff00),
+    const_le32(0x00ffffff),
+    const_le32(0xff000000),
+    const_le32(0xff0000ff),
+    const_le32(0xff00ff00),
+    const_le32(0xff00ffff),
+    const_le32(0xffff0000),
+    const_le32(0xffff00ff),
+    const_le32(0xffffff00),
+    const_le32(0xffffffff),
 };
 
-#undef PAT
-
-#if HOST_BIG_ENDIAN
-#define PAT(x) (x)
-#else
-#define PAT(x) cbswap_32(x)
-#endif
-
 static uint32_t expand4[256];
 static uint16_t expand2[256];
 static uint8_t expand4to8[16];
@@ -1015,6 +982,8 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, uint32_t val)
 typedef void vga_draw_line_func(VGACommonState *s1, uint8_t *d,
                                 uint32_t srcaddr, int width);
 
+#define GET_PLANE(data, p) ((cpu_to_le32(data) >> ((p) * 8)) & 0xff)
+
 #include "vga-access.h"
 #include "vga-helpers.h"
 
-- 
2.43.0


