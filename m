Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC3C820ADA
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 10:41:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJsIZ-0003Vk-27; Sun, 31 Dec 2023 04:39:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJsIO-0003NA-IF
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:39:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJsIK-0001PM-RX
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704015580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zGuVDWpXyHgDtnpBoCqtCU0iZWlD325c2JY3QKidV/E=;
 b=FfJwpW2Bk9CLJrgm9wdKacJhFIVqMATvN8Z/yee/iSrL/eGIMEyGI1UoS2JaNuFL31H3+V
 RsU9Ifu6vbTHFWTxMTJ5MejQieC9IqNzDkg3/BQfJtA85iS+RSPJp7W7hTj8tI7753298k
 XDvevv9DmgJMXoZvR+GALJI6ZmOSXA4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-J-a3J6KBPoud5swmYfs4aA-1; Sun, 31 Dec 2023 04:39:35 -0500
X-MC-Unique: J-a3J6KBPoud5swmYfs4aA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40d4a423c84so71887975e9.3
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 01:39:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704015574; x=1704620374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zGuVDWpXyHgDtnpBoCqtCU0iZWlD325c2JY3QKidV/E=;
 b=S26Z2Xy7LRTvD5KbWxfv/QZ/bQmqJte+74Mdnyok2TQtSHphtfdaj/JM9v49Ec1pCE
 PoEeCdQ2CmlKDR3jm+eT7QNWiBIJeF/D4IbqJJ3tKdO3veZLRvstaSJU6QFyvTTdYC48
 84Jk25C6vl+6u+uXyMleR37hzHt61PQr84JDdoyEVh7ggFVtEpcIHjDInzEdCdvaYGCH
 pucViR2nddxbcBbFpFOAHCNX7mGif4+TPJMpxUxCiL/oI6YYLb4cBwnyHopFJCuq5NbN
 b3b/3YG6RACvaTsJs1Q9UTb65epSeYYQVFnBNvENwvw55M9txwOK2iKFvuWodU2UKRVH
 Xq+w==
X-Gm-Message-State: AOJu0Yyvxj7PoTYbaALVxOuCE5LNCHGE8ujQi8jWuWL34JSNkldlvBTA
 yv8+iS5TrezckQpFuHdqpTZl3JpSYlx+uFNnG9r2ahBPF8N1LgPGUjBWK42PpwRAcuGe2Zhe7mp
 JU4NpuUgpbPiBDuKrNNuc5kQRjp+FKs+dCzqI7zOYYU2W/j/63+c70JfVOQo1sB5zx42VrhktSf
 aJjlySafk=
X-Received: by 2002:a05:600c:5204:b0:40d:7b30:4f9f with SMTP id
 fb4-20020a05600c520400b0040d7b304f9fmr1138845wmb.26.1704015574055; 
 Sun, 31 Dec 2023 01:39:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQvi8QqI4heBaLzPOhUxOiDs8qK2I6mTEOKcjO1KnTpZH9JjjR5DyxQzXzmpqH1USxD6h3QA==
X-Received: by 2002:a05:600c:5204:b0:40d:7b30:4f9f with SMTP id
 fb4-20020a05600c520400b0040d7b304f9fmr1138842wmb.26.1704015573745; 
 Sun, 31 Dec 2023 01:39:33 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a05600c310e00b0040d6eb862a7sm10785056wmo.41.2023.12.31.01.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 01:39:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com
Subject: [PATCH 5/8] vga: optimize horizontal pel panning in 256-color modes
Date: Sun, 31 Dec 2023 10:39:15 +0100
Message-ID: <20231231093918.239549-6-pbonzini@redhat.com>
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

Do not go through the panning buffer unless the address wraps in the middle
of the line.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/vga-helpers.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/display/vga-helpers.h b/hw/display/vga-helpers.h
index 29933562c45..60ddb27d946 100644
--- a/hw/display/vga-helpers.h
+++ b/hw/display/vga-helpers.h
@@ -265,6 +265,18 @@ static void *vga_draw_line8d2(VGACommonState *vga, uint8_t *d,
 
     palette = vga->last_palette;
     hpel = (hpel >> 1) & 3;
+
+    /* For 256 color modes, we can adjust the source address and write directly
+     * to the destination, even if horizontal pel panning is active.  However,
+     * the loop below assumes that the address does not wrap in the middle of a
+     * plane.  If that happens...
+     */
+    if (addr + (width >> 3) * 4 < VGA_VRAM_SIZE) {
+        addr += hpel * 4;
+        hpel = 0;
+    }
+
+    /* ... use the panning buffer as in planar modes.  */
     if (hpel) {
         width += 8;
         d = vga->panning_buf;
-- 
2.43.0


