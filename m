Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0571D780EB7
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:12:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX18E-0006EM-5N; Fri, 18 Aug 2023 11:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qX17x-0006D4-Vy
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:11:06 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qX17u-0007Z0-3H
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:11:04 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31783d02093so953520f8f.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 08:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692371460; x=1692976260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJiiohdKQZbGGA4ANTWMA+44jYq1EDm9KHj0/oftavU=;
 b=ITxIhNTjD4V/gTxIbkqVUyHXR4kGcSEpSYVVuvDAvTk2ngkOZdJJt4fTM7VtxLhU6q
 +b83HgAmeeZ1XnuUFHOc05qCOkn/ru9IRIfoN1cSs3GPBtnqhn+qyBij5AZtiymUYTak
 DWZ1TL3tEPIgKYq4wFo0grGCGtkA9uzm2Luk8IjeV/C8YgOpPwSee+zRAdiDY4H9FSro
 VRGzs3aUkzs/hKCRzGVdOgCExiB0xjqo3X0KrI2P6W9qojDZF9+E4qavyMKvzeK/oQUe
 KEGcosQLdKYQl9+Tx79K6M/9kDWTg1ClXN4WWUY7pZPkdoSBK/hM3qQtDhlZHGRTsaXT
 11VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692371460; x=1692976260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UJiiohdKQZbGGA4ANTWMA+44jYq1EDm9KHj0/oftavU=;
 b=AiSe3uDMX+Op4QVFCXNA0hLR2Rny2ckUXN7I9y1aQ5HSBeJyVM4Tr9YduzRkDQhPVM
 +AJEBkHLTfOMdmVodJpAcWMeWu/Ol6cavstEK2+/UOpZJVPijmxQoNCeyA8ZelALH2Ko
 10SoZWf7IKfFe1nDPswGQKWAAPeD/vK/EeKOF56UDhT8NxUceUMN+PyfHACXMPMeweBd
 TlMN5Yx2WTAfpRGkU0ugt2BpmsdAgacTWQyiRTh7qnbv8FtN9Lqtg+OVmgI+huoDUEg6
 DZMqKIYukJe2p7z75H7HX/4bNl9G94JTT496wP0OP1oJS+PKb36HlyxBPomSMNRRwDwZ
 MHQA==
X-Gm-Message-State: AOJu0YxY355bziZIsbtw0TZ5WN2c0I7tjtHIDTU7T16slLhZvA+IZn3C
 0PnYRZ/kcQGrBXHu0QBHE04Qa1Cs4BJEvV2IOJ4=
X-Google-Smtp-Source: AGHT+IHF9wBoC1qcLaECybzOAXmTth/29ps36aYfnEe2B+mrxQwj+SPXrPpc5gqZ23iCYN2u4dWUNA==
X-Received: by 2002:a5d:494c:0:b0:317:de6f:22cb with SMTP id
 r12-20020a5d494c000000b00317de6f22cbmr2539092wrs.2.1692371460007; 
 Fri, 18 Aug 2023 08:11:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a26-20020a5d457a000000b00316eb7770b8sm3097631wrc.5.2023.08.18.08.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 08:10:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] ui/vnc-enc-hextile: Use static rather than dynamic length
 stack array
Date: Fri, 18 Aug 2023 16:10:56 +0100
Message-Id: <20230818151057.1541189-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818151057.1541189-1-peter.maydell@linaro.org>
References: <20230818151057.1541189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

In the send_hextile_tile_* function we create a variable length array
data[].  In fact we know that the client_pf.bytes_per_pixel is at
most 4 (enforced by set_pixel_format()), so we can make the array a
compile-time fixed length of 1536 bytes.

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 ui/vnc-enc-hextile-template.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/ui/vnc-enc-hextile-template.h b/ui/vnc-enc-hextile-template.h
index 0c56262afff..283c0eaefaf 100644
--- a/ui/vnc-enc-hextile-template.h
+++ b/ui/vnc-enc-hextile-template.h
@@ -7,6 +7,8 @@
 #define NAME BPP
 #endif
 
+#define MAX_CLIENT_BPP 4
+
 static void CONCAT(send_hextile_tile_, NAME)(VncState *vs,
                                              int x, int y, int w, int h,
                                              void *last_bg_,
@@ -25,10 +27,13 @@ static void CONCAT(send_hextile_tile_, NAME)(VncState *vs,
     int bg_count = 0;
     int fg_count = 0;
     int flags = 0;
-    uint8_t data[(vs->client_pf.bytes_per_pixel + 2) * 16 * 16];
+    uint8_t data[(MAX_CLIENT_BPP + 2) * 16 * 16];
     int n_data = 0;
     int n_subtiles = 0;
 
+    /* Enforced by set_pixel_format() */
+    assert(vs->client_pf.bytes_per_pixel <= MAX_CLIENT_BPP);
+
     for (j = 0; j < h; j++) {
         for (i = 0; i < w; i++) {
             switch (n_colors) {
@@ -205,6 +210,7 @@ static void CONCAT(send_hextile_tile_, NAME)(VncState *vs,
     }
 }
 
+#undef MAX_CLIENT_BPP
 #undef NAME
 #undef pixel_t
 #undef CONCAT_I
-- 
2.34.1


