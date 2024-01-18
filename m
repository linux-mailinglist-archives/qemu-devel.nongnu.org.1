Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C18D1831CA9
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:35:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQUPV-0007Td-23; Thu, 18 Jan 2024 10:34:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQUPL-0007SB-6a
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 10:34:20 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQUPI-0002R6-L1
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 10:34:18 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-337cf4eabc9so593906f8f.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 07:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705592054; x=1706196854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SwuaHqluR1Y5JxpZebqlgJ2NJ8ORccM92Gb37cL7c0k=;
 b=sIVskwNecz/a6NnLOcFpfmWR0s6w6xr8eHaiVA8IeMF47oN0uY8WhZr9RWR1KHNB7s
 qaG0TxM49A3b26RuRdM/FFhKk9tlUpO4Acy/WAAU/k+u5qI/6NrMNbIo2NVpa320/Csc
 AbFN4B9NL1GQH4bCefN5+1nhfkEMhed5IhwzFPXWdfymRWRn4YTTpPHIHpX0ibh5EJh/
 +w+etVUarjc8QWQpiXz/tiR05b8TdMRHuqR6UXmtXP1sPmDgv3CAHMKBZCaj1zbaWs9A
 XeQIFKkyJPcHlyj2YDBozt0aOg9X3oyJ4+yygOdhMun52rd1c2WNhiWq9ek/IPgl9TLY
 b/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705592054; x=1706196854;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SwuaHqluR1Y5JxpZebqlgJ2NJ8ORccM92Gb37cL7c0k=;
 b=Nn4LubVOsIqVcLRxVMRur5ra9TO6wf0kyAIaK0j5wT0DlFVbVmbGPeAH2wJbPjai68
 cSFwB+1TstUIFcc4+jBWx8Rkv4oPvJGgvnZsTWpgMx17n7VQFBgPXm0Beq732Qy1SBYJ
 SZZzSY/gTBSzS9fJG/vqupw2NdxJW42HWF4nKa0FxExcwoMeiMvVPCDRKbh5UUFajtRE
 5b18aO8wzQfdKl3bVOUqNmDRUQypqI3Q1+ceuFNo1Izm7por58G2wBu/nPMjFu6796j+
 xSSf4HjTKF4cFYWWGthhQWg68YyGUv8A6aNEPYsAHJ7YgPecCxywKz1wyyOHEuXBJWRP
 Wmgw==
X-Gm-Message-State: AOJu0YzkIa4yeVJaliv7cmNI66Z1EUNehwcgMdHBNqL7yOdPM3JFZsD6
 dzffYHNIStDpWdrZNi4Aj/1A6vROXQg7qMTG01d+fYYmJUVkyvW82bMGXWfpePXxX6gTTXZIPXa
 3+pYvcA==
X-Google-Smtp-Source: AGHT+IHgz/rapFoR0xCb1hs55FmFDsAZD2p4fBl1uquM4awL1jz0Ag1TsFbBrCBDGGAhjRbwDGHBoQ==
X-Received: by 2002:a5d:6712:0:b0:337:c4e2:a1de with SMTP id
 o18-20020a5d6712000000b00337c4e2a1demr532631wru.105.1705592054244; 
 Thu, 18 Jan 2024 07:34:14 -0800 (PST)
Received: from localhost.localdomain (33.red-95-127-38.staticip.rima-tde.net.
 [95.127.38.33]) by smtp.gmail.com with ESMTPSA id
 i2-20020adff302000000b0033788e357e1sm4271671wro.108.2024.01.18.07.34.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jan 2024 07:34:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] ui/gtk: Strip trailing '\n' from error string arguments
Date: Thu, 18 Jan 2024 16:34:11 +0100
Message-ID: <20240118153411.2907-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

error_report() strings should not include trailing newlines.

Noticed running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h \
    --sp-file scripts/coccinelle/err-bad-newline.cocci \
    --keep-comments --use-gitgrep --dir .
  ./ui/gtk.c:1094:56:"gtk: unexpected touch event type\n"

Fixes: 5a4cb61ae1 ("ui/gtk: enable backend to send multi-touch events")
Inspired-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/gtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 810d7fc796..c819c72a20 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1091,7 +1091,7 @@ static gboolean gd_touch_event(GtkWidget *widget, GdkEventTouch *touch,
         type = INPUT_MULTI_TOUCH_TYPE_END;
         break;
     default:
-        warn_report("gtk: unexpected touch event type\n");
+        warn_report("gtk: unexpected touch event type");
         return FALSE;
     }
 
-- 
2.41.0


