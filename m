Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 125DF72831C
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:56:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7H37-0008VW-2M; Thu, 08 Jun 2023 10:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q7H2y-0008Sz-2F
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:55:37 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q7H2t-00031O-Fb
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:55:30 -0400
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-777a9d7efabso24492239f.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1686236124; x=1688828124;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dcgV4A8KaqvjLKmFYnDAKUormAwRgmM4FIFcbvzM0K4=;
 b=eyUfagcA2PFZKwbgHzEgkBIQkT4saEfAO71Rt1jJLmeNmu51moiLT0DNU4jmggEIKU
 AZp+K53oazeRWxuubgu1fgLX1JYlaMU7VXIPjcYrwIBM8+0YtThEbMgjjaYbOl+hM/Kh
 onzt4VshykVuCWx7j104Fkg3TTgsYCBK3NAt1xWeLtJdXKGzDLxt5wiTPHvZk0/k6hpR
 pn+Ij51wTs2xdZ5GJzyszLnmpzDphM0PToQv7ntgmPQ9fWb12mwhK+rBLSxoRVluWM/I
 aH7SZTe+uYZSFC8F3yz3M2ovbZ+M7MiVcAMCJn83WT3obYNyZ99RdWKdXNgiu/FDhsq+
 0p5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686236124; x=1688828124;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dcgV4A8KaqvjLKmFYnDAKUormAwRgmM4FIFcbvzM0K4=;
 b=FdxfWzP9BbLtjvWaRjiNyfKlbAVBLaFuvlTTN2XUq8fY+ZW4XN4kpEhWlJc8CdIg2P
 98SOpKugUPCHRQJqhQwCLCVTaDHUSxPILEtIhlyDVQdunXGmIjmzasFSFs4J2qk3+9wK
 wXBK0cxLGzg9cASQwd1KEq5Vin1zc/y6+odJaRHN1nFCTteIWk/lSa/GVtAFU3K2iXZH
 xOnCrerj87adxlPkGx73grjOlsw9vBPAdCMWE27htDNaEYQqp5O76cJqCkpbqJUfB+mj
 IGOUZL61Io2gG2pxMXbmkSat6T5kttpE8gM5plghE0o7eJlPIMZlBNYlFDwwlTt7umPc
 tLYA==
X-Gm-Message-State: AC+VfDytCMZgkVcm7OvBdi6XNyRKOdx8DNg5g8WmImZyofS+JuuoFiwK
 /snuk0r23vrqwIbRo4/u5AP4lfzQqx6rG0NUiy0=
X-Google-Smtp-Source: ACHHUZ4KR+3edoQtKyqwAvr3hhGbFG/HwWGN/b23yQcyv2osbBT9D9NxopV11iN2cJRix2Gf8toe6Q==
X-Received: by 2002:a92:c090:0:b0:335:1ed:359b with SMTP id
 h16-20020a92c090000000b0033501ed359bmr10547516ile.15.1686236124612; 
 Thu, 08 Jun 2023 07:55:24 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a17090a71c400b0025671de4606sm3196863pjs.4.2023.06.08.07.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 07:55:24 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Antonio Caggiano <quic_acaggian@quicinc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH] sdl2: Check if window exists before updating it
Date: Thu,  8 Jun 2023 23:55:12 +0900
Message-Id: <20230608145512.25970-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d30;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-io1-xd30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A console does not have a window if the surface is a placeholder and
the console is not the first one. sdl2 cannot update the texture in
such a case.

Add a proper check for window existence. Such a check is only necessary
for the "gl" implementation as the "2d" implementation checks for the
texture, which is set only if a window exists.

Fixes: c821a58ee7 ("ui/console: Pass placeholder surface to displays")
Reported-by: Antonio Caggiano <quic_acaggian@quicinc.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/sdl2-gl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 39cab8cde7..bbfa70eac3 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -67,6 +67,10 @@ void sdl2_gl_update(DisplayChangeListener *dcl,
 
     assert(scon->opengl);
 
+    if (!scon->real_window) {
+        return;
+    }
+
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
     surface_gl_update_texture(scon->gls, scon->surface, x, y, w, h);
     scon->updates++;
-- 
2.40.1


