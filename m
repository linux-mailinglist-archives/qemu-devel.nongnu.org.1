Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EFA820AD6
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 10:40:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJsIX-0003UF-6a; Sun, 31 Dec 2023 04:39:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJsIC-0003Lq-O0
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:39:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJsI9-0001Oi-6x
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704015572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p3Cfhng1m30gY0FPzL64Bq2Z6lQcD2J+KCqhTI1oPmc=;
 b=H6y6Fg43H3SZ1/aOPCCz2sfbuqTLfYEn3ldwSWNMHECWZYEjAPI5+bRyUJXfDOUPvDSU57
 8KOIeNRotnx9ADl+oclDZhy6MNIaeKZ0X+0Jt6IAsviIWBbVY2LbZAfoGhmgASlRyyixSv
 4iNoj7FxRI6vkzLbm8loP8H2r9PnMgU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-QbV0TZsmMhS9OnEfM7ua-g-1; Sun, 31 Dec 2023 04:39:25 -0500
X-MC-Unique: QbV0TZsmMhS9OnEfM7ua-g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40d8687b0caso1551885e9.0
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 01:39:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704015563; x=1704620363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p3Cfhng1m30gY0FPzL64Bq2Z6lQcD2J+KCqhTI1oPmc=;
 b=SLGsxwjrjtfzGg4zV2gvAY2imV6ASHJe64eRO+n+a/tvlEnQlS7AY1AFmnIYZ08JWn
 v/Q3Zc2rFDYfesEGInSA6npGpj4Sbb4B6kEX1by+2s0VC/l6lpKHRBdzL12OEer4E8SD
 xz6uZ7izV6sFe6qKXtbiVaXUYjnUBAc/5HhXCI6XAdk/ZrP5AmJPnQMb1TIqzQXqqrXU
 f2u5+Nvzgdj6O5y1jrY7FIn4mrB3ngdSde4WmYZGDiNWdj4FLvH9v4Q+EvEujDcpR+JM
 NiVFs8eV11Jp9yHpvpiQeIaTs9yYyA7XWvm+gbB+ueEGXgvK2vbf4fZGdXvNk0fZHF6y
 4wvQ==
X-Gm-Message-State: AOJu0Yxo8ZxZJmX+6vVeO67SVsnPWmcb2LQjtYsFZsYzG6lHbDQoQGlu
 ZJ2W6gNIXMsWkgFuENkZ2+WRv54RpjNhJsoPU9HpcMAnLo2+iTb3Pa0R0VO2pOisrvPekjX6Tgt
 pDoHVrFWIFaBjzbC2Qjh31vy4nKb/cOh2pDotICP3mVh/1kZ0+DeBzNfmqcojMhl0ZhgvSfehj0
 0bv8UFrJQ=
X-Received: by 2002:a05:600c:1f88:b0:40d:64a8:97b2 with SMTP id
 je8-20020a05600c1f8800b0040d64a897b2mr2520365wmb.116.1704015563411; 
 Sun, 31 Dec 2023 01:39:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQCobwWFOj1HLFYqzwxAloGl54Z09wVNnzTF8fn4Q5afRgAkn7uu/fGOt3MFJM6CgdpTm7NA==
X-Received: by 2002:a05:600c:1f88:b0:40d:64a8:97b2 with SMTP id
 je8-20020a05600c1f8800b0040d64a897b2mr2520361wmb.116.1704015563178; 
 Sun, 31 Dec 2023 01:39:23 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 d13-20020a05600c34cd00b0040d833195cdsm4871234wmq.37.2023.12.31.01.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 01:39:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com
Subject: [PATCH 1/8] vga: remove unused macros
Date: Sun, 31 Dec 2023 10:39:11 +0100
Message-ID: <20231231093918.239549-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231093918.239549-1-pbonzini@redhat.com>
References: <20231231093918.239549-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/vga.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 37557c3442a..18d966ecd3e 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -103,12 +103,6 @@ const uint8_t gr_mask[16] = {
 #define PAT(x) (x)
 #endif
 
-#if HOST_BIG_ENDIAN
-#define BIG 1
-#else
-#define BIG 0
-#endif
-
 #if HOST_BIG_ENDIAN
 #define GET_PLANE(data, p) (((data) >> (24 - (p) * 8)) & 0xff)
 #else
@@ -134,14 +128,6 @@ static const uint32_t mask16[16] = {
     PAT(0xffffffff),
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


