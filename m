Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BCE83191E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:26:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRRw-0003W4-Uq; Thu, 18 Jan 2024 07:24:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRi-0003L0-8K
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRe-0005qA-Ic
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705580669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/VVeA71Dmkqh48AQEKSvnskR8Cu+XOI6j0l+YjpNLD4=;
 b=b1XJhRnwkiOCwr3IuAMWH4SLJ/EsBM1g1NSCVadgqCq0FVrzY0OKmPF+oALkvKtzOLm+1/
 W0teXIBPjWyWAPU5qMnGMs/TEUyM8uGpXGuDQc6pxr5yFsVCdGO2iIGSfufs7KzgONCUHH
 INHgMfEpDdVNu14hwUbLDxazOvI/yjo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-FXTfme9gODq7MQbyn3LHRg-1; Thu, 18 Jan 2024 07:24:27 -0500
X-MC-Unique: FXTfme9gODq7MQbyn3LHRg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a2b762cfdafso470818366b.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:24:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705580666; x=1706185466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/VVeA71Dmkqh48AQEKSvnskR8Cu+XOI6j0l+YjpNLD4=;
 b=QsFer2ILD4yarb4CYRYvaqqL4LZFCGJUCmUJSvExdwQmBO4eoBc1MC2Y9KuBgqk6ox
 WV1dVN5dJNVOUC4q7W+2ssIJVbt8q/m0vFy3r3hxTBvpx4PoD1gZfYdqzCx5gkhCDu29
 kXRZEG2TMucH/bfDE//9ALRf1SlHSvHbLW6BC6ty92f4tQXKE2kUlwMiljjFKADlknV9
 wyuZNB94YcjXQ1EuDafn8BdpT9MFfQD51dL7gMGt1gZO8R64jKjnVvm78eJ9MI3ghWpB
 Y+dTL85jj3KyIolu4YMb4UsKNjvmOTZTNstUdGl7HZSpv+kTKYnMJPm2TKZSBwrpc4RI
 ykrA==
X-Gm-Message-State: AOJu0YyrVY5bZRIU8EharrpX1ulS5aUlSiP6aLCQqEBUxhxmnrJ9Qh7e
 WVLZAYd3n/JYBkl874QAYPRdf69DZgIZmfNk/9hCl9dnFakeyJyXQQZc/ctT0ehKD9a+xb0+pTl
 LkLgCo+x3gmn7UW4aNtzFxu5+6wjiAqyYI7EZceh9TljRh8FKzvru2bfQvv3bzwqbWTWa2TSENf
 Cbs7w/zvx7TwbxhOf24J7XzirTKMdlswOPgQVm
X-Received: by 2002:a17:906:bc57:b0:a27:6615:15ed with SMTP id
 s23-20020a170906bc5700b00a27661515edmr519813ejv.42.1705580666387; 
 Thu, 18 Jan 2024 04:24:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzeMDwNlGqKPtAovH20EgugCMLpSj8Wi9ikIifjhFSicZGbIm3Xknr6VJYHA4mTAhOeKmBrQ==
X-Received: by 2002:a17:906:bc57:b0:a27:6615:15ed with SMTP id
 s23-20020a170906bc5700b00a27661515edmr519807ejv.42.1705580666130; 
 Thu, 18 Jan 2024 04:24:26 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 23-20020a170906311700b00a269b4692a9sm6728146ejx.84.2024.01.18.04.24.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 04:24:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/16] vga: optimize horizontal pel panning in 256-color modes
Date: Thu, 18 Jan 2024 13:24:05 +0100
Message-ID: <20240118122416.9209-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118122416.9209-1-pbonzini@redhat.com>
References: <20240118122416.9209-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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
index 29933562c45..2029b61791b 100644
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


