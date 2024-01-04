Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F22A7824A96
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 23:00:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLVjX-0001ao-PD; Thu, 04 Jan 2024 16:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rLVjU-0001Zy-DN
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:58:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rLVjT-0003P1-0G
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:58:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704405510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zGuVDWpXyHgDtnpBoCqtCU0iZWlD325c2JY3QKidV/E=;
 b=XS5U/z4Wfi7IyNI59H0Vt4SlUN5GJEb7RH6CAFnCsO2qJmLuKUTEHd9zKdDFrSu1IGnHcW
 dCYHSxN8qF1Ox3DWIzaWmK9u03vz8USsNUT6mbU5K9Eeh5yji009ebq/82/smxKNfeIbwI
 faBK2/X/IZk3lwgqtvIxiOl51wO96TU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-gmHQcxtROhW7RA7tyihEng-1; Thu, 04 Jan 2024 16:58:29 -0500
X-MC-Unique: gmHQcxtROhW7RA7tyihEng-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a28f6a233afso36966066b.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 13:58:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704405507; x=1705010307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zGuVDWpXyHgDtnpBoCqtCU0iZWlD325c2JY3QKidV/E=;
 b=eYPCZAGPpKU1r0zw2BM+BJmeDxEAd7sESEitCcWJY8ts3inaHKQ9rVn3qF9dfn0XG7
 mBXzLuR35mfXDV7gchW4hahkAqDiWFJJUd8wmRH4eUTVaQD64L0ffnjjVu/TL9Pech7X
 s3iAnQ44+e7c0EmHh+PQGttaDTQ1JaSQAb157MPYAw8qlLy8Vd7if6PKRAjjT/yPf2u5
 a+ekEsRvDRDizkK0pt9vyvFbp3iv8FzHjdKOrENKxov9DTnLsS1GKSC+yvEXwH6sbCJt
 pzmF5p6a2F4toU7F2MGv8aQ9/TlfL21Z4hSS0G5/NoMW0s77KuudX3z4+hk1/F66Mtoa
 zvUw==
X-Gm-Message-State: AOJu0Yxui0mZdCBspMgY7xxjgSXvor/J62BtGK2IKeoPi6a3oWzshVqa
 C3fFJk8gm17H+MyXY/7mqFlbSUGNPYGv1/RAt7Cve8bmdpUxTjxjduoW/Q2YJKGZ96C1rVpkxSe
 3+WhQgp4G8WJFFaGK+cER1kqVql27ewxrhOmZaVyYL02qaFqjpHa3EROXnm7lNbhWp7RClXWhu1
 0Yls+uCsY=
X-Received: by 2002:a17:907:76c5:b0:a26:c055:9e85 with SMTP id
 kf5-20020a17090776c500b00a26c0559e85mr456452ejc.58.1704405507395; 
 Thu, 04 Jan 2024 13:58:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEd5WE4IQ5UzNfn4dgY0IAdIYpqD3kjJ4lXUOBZ7rRdzJwAonExfp87NAK11PSr2Kn/xhhE1A==
X-Received: by 2002:a17:907:76c5:b0:a26:c055:9e85 with SMTP id
 kf5-20020a17090776c500b00a26c0559e85mr456447ejc.58.1704405507209; 
 Thu, 04 Jan 2024 13:58:27 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 m21-20020a1709061ed500b00a236378a43fsm112642ejj.62.2024.01.04.13.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:58:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
	balaton@eik.bme.hu
Subject: [PATCH v2 5/8] vga: optimize horizontal pel panning in 256-color modes
Date: Thu,  4 Jan 2024 22:58:08 +0100
Message-ID: <20240104215813.156153-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104215813.156153-1-pbonzini@redhat.com>
References: <20240104215813.156153-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
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


