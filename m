Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C519C83191F
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:27:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRRl-0003O7-7K; Thu, 18 Jan 2024 07:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRe-0003De-Mx
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRY-0005d3-Mz
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705580663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=egeyUdc9pjO+1xQmlTrMlEire79rsJCnWzWZGPWX2jo=;
 b=JzEYXRfn814THtvnhICpMtjtiixEJ3HzLgU5r7P5Zj02k4M0VW421F3qq6C/5q8l0zlCQ4
 dZ7d2BuCaV7qJGfb0ULBD5mf6J0lnh8Q/F/RQrBidH/Lenjx0PWtzlrep5+CCOk/0nBZIu
 EnGd27skV1khXZ+XnKfaGm4fMBQcG7w=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-6IqNE1gnO3WWOitupWJLdA-1; Thu, 18 Jan 2024 07:24:21 -0500
X-MC-Unique: 6IqNE1gnO3WWOitupWJLdA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ccbfa17001so99729851fa.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:24:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705580660; x=1706185460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=egeyUdc9pjO+1xQmlTrMlEire79rsJCnWzWZGPWX2jo=;
 b=Fyyew9Oa02JPNTYNidNFM9DJbHSBu+Md5G+WVkLJXPsKzcX30KcKVJNm9KD9AxVhJl
 fv/tVk1dNVe6qfW8Cv6ANYqTJs3+BppBSZbFYZMr+h4UmuIg3xY4G2qdCO8OiJK3fRBA
 i6QNfF0fPXyI1rLMVovmP51thndNx5hPsiVTpfuIDbvMy9+vTEl+WQuWuZRp7BaueZuV
 jm3hRpIYt9kUyQKxv8QyiAjJ7kOgFt42ZNhgYKC06DzR6BTq0GGRRm2/Xpp94PZsHc7s
 jhfZwQXgALqNwLsQpgXMdsId7AcM0WuT809fa5TQw1qh8dNzItTQ2bQAjXlpGDkfa/wG
 9V8w==
X-Gm-Message-State: AOJu0YwLptew9FPSldX/NIgu2owJZwz53aN1+7tFicCfOXk20Cqs1CzV
 CSuUSfwmAnRvv29MtirgwL70vW2ieIP8fzKj2AtAqosIiO8hy3X9EGdnpduuhPuv4aH3poSAY5s
 mYVBjsbYazE9L2yrpYlyJFMhtO1pOcHanEsNgCnDjH36WNe1UpHigpIU7UiyjgpZMyjLnJ/INw+
 g2o2u+obGoE7PvYLXHq8gl6Z8/LVwMIRZCgVcL
X-Received: by 2002:a2e:9b0a:0:b0:2cd:63eb:e7b5 with SMTP id
 u10-20020a2e9b0a000000b002cd63ebe7b5mr453094lji.80.1705580660098; 
 Thu, 18 Jan 2024 04:24:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiZkl1225h5ISC4H0jHyRfk62Jm81yjW/iQ5KQlUJ0Vm9dMc8o8ZX8uVwx8gsUki/B3kUMyQ==
X-Received: by 2002:a2e:9b0a:0:b0:2cd:63eb:e7b5 with SMTP id
 u10-20020a2e9b0a000000b002cd63ebe7b5mr453088lji.80.1705580659692; 
 Thu, 18 Jan 2024 04:24:19 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 x9-20020aa7cd89000000b00558e0481b2fsm8024551edv.47.2024.01.18.04.24.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 04:24:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/16] vga: use common endian swap macros
Date: Thu, 18 Jan 2024 13:24:01 +0100
Message-ID: <20240118122416.9209-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118122416.9209-1-pbonzini@redhat.com>
References: <20240118122416.9209-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 hw/display/vga.c | 65 +++++++++++++-----------------------------------
 1 file changed, 17 insertions(+), 48 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 886a4020e5d..a8b5830a30a 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -90,58 +90,27 @@ const uint8_t gr_mask[16] = {
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
+#define GET_PLANE(data, p) ((cpu_to_le32(data) >> ((p) * 8)) & 0xff)
 
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
-- 
2.43.0


