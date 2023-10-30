Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A707DBB78
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:11:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxSyM-0006KR-0W; Mon, 30 Oct 2023 10:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dev@adrianwowk.com>)
 id 1qxIE4-0001oo-Gq
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 22:42:01 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dev@adrianwowk.com>)
 id 1qxIE2-0000Pc-Vf
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 22:42:00 -0400
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7781bc3783fso300169785a.1
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 19:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adrianwowk.com; s=google; t=1698633717; x=1699238517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5LQLfJ434pvG/aKnk93WWxZXxZnR5kjhoIoxzzxZhEE=;
 b=JwbDGuM6x/v4kLZ2o77Vg1EyoaGA3FUtfW36sbQaCFMoj9iXWGTXPznZMvTf2p5tps
 TaVSaXA7AOoP+CDtzhsksVZVrLkT59e4DcBDpC4a2IEeTnwGkClu76KfFYLIuTvT3GWC
 2kOIQxBg2cSoi7VSAC+ZPe5wmEZbgA3MvYDfXGWQzKpj15jIfqi6STdpmNkkiCF5RqDC
 eIszIZmifSUbm3dpBA+uqt+JNRyBlAWSW/0M4s4ZqxtUIvQ2rP6DL8B1kObvP0W9iuH2
 +Ba0Ej90Q//HPgAiHHFsW6evqEC4qTkbFy18Sd37S+IENQVhsAsTRSofIf2Kf1QGqN8O
 CZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698633717; x=1699238517;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5LQLfJ434pvG/aKnk93WWxZXxZnR5kjhoIoxzzxZhEE=;
 b=q26j7nUKX83HKwDuv3cBcYk5t7y3HqoN88bV9oDZ+ss/chD341FPYK9FqWg8jxEoJZ
 WH4UxbhSZ/3iUA3RSivLJzFy2Jj/9n42cW6mTnCX/FwJwKD9ucFoAo+M8cSyartPB2g+
 iZgjIco+8ch21+rI44TAJawmQhUVcahFVhI5YzmewetvRndXY2s7Ne3q31W0T+SbhgmY
 0liPPXEloUja9AVL8gCNDW/RREkMOujzu19IN5/gJgzECXDSbDqo7MyFqXjF11IddXpI
 evX8ry+yn8Z3y0eJ7ugseeY3F0dQaRb7i5NgG5bO1wThFdbZ2UOztzByHR+H4AC0pYAn
 99dA==
X-Gm-Message-State: AOJu0YwA4Ys754yOCmfwmkJFrjqRWhLTrDjwzyanC1onsMF1gciKHu28
 KVMBrswSAwPMh3cwGqmJXSO8ptPvdYsRIeFDAVvemw==
X-Google-Smtp-Source: AGHT+IHDg9WAW6McayJkYVjhDzmxCjfAjON/QrQvhQAJCcFQ3WZEbm0OzfUBcUHRqodxUE7a4koVGw==
X-Received: by 2002:a05:622a:1752:b0:41e:5ccd:a7a0 with SMTP id
 l18-20020a05622a175200b0041e5ccda7a0mr5739424qtk.44.1698633716969; 
 Sun, 29 Oct 2023 19:41:56 -0700 (PDT)
Received: from localhost.localdomain ([131.125.11.1])
 by smtp.gmail.com with ESMTPSA id
 kf21-20020a05622a2a9500b0041950c7f6d8sm3059925qtb.60.2023.10.29.19.41.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 29 Oct 2023 19:41:56 -0700 (PDT)
From: Adrian Wowk <dev@adrianwowk.com>
To: qemu-devel@nongnu.org
Cc: Adrian Wowk <dev@adrianwowk.com>
Subject: [PATCH] ui/sdl2: use correct key names in win title on mac
Date: Sun, 29 Oct 2023 22:41:19 -0400
Message-Id: <20231030024119.28342-1-dev@adrianwowk.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=dev@adrianwowk.com; helo=mail-qk1-x735.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 30 Oct 2023 10:10:17 -0400
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

Previously, when using the SDL2 UI on MacOS, the title bar uses incorrect
key names (such as Ctrl and Alt instead of the standard MacOS key symbols
like ⌃ and ⌥). This commit changes sdl_update_caption in ui/sdl2.c to
use the correct symbols when compiling for MacOS (CONFIG_DARWIN is
defined).

Unfortunately, standard Mac keyboards do not include a "Right-Ctrl" key,
so in the case that the SDL grab mode is set to HOT_KEY_MOD_RCTRL, the
default text is still used.

Signed-off-by: Adrian Wowk <dev@adrianwowk.com>
---
Hi! I created this patch after having to compile QEMU from source with the SDL UI enabled to avoid an unrelated bug in the Cocoa UI. I noticed that the title of the window was not correct so I added a quick fix. I have tested this change on MacOS Sonoma (Version 14.1), and it works as expected. I did my best to ensure correctness, but this is my first time contrbuting to QEMU (and also my first time sending git patches over email), so if there is anything I can do better then please let me know. Thank You!

 ui/sdl2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index fbfdb64e90..4971963f00 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -172,11 +172,19 @@ static void sdl_update_caption(struct sdl2_console *scon)
         status = " [Stopped]";
     } else if (gui_grab) {
         if (alt_grab) {
+#ifdef CONFIG_DARWIN
+            status = " - Press ⌃⌥⇧G to exit grab";
+#else
             status = " - Press Ctrl-Alt-Shift-G to exit grab";
+#endif
         } else if (ctrl_grab) {
             status = " - Press Right-Ctrl-G to exit grab";
         } else {
+#ifdef CONFIG_DARWIN
+            status = " - Press ⌃⌥G to exit grab";
+#else
             status = " - Press Ctrl-Alt-G to exit grab";
+#endif
         }
     }
 
-- 
2.39.3 (Apple Git-145)


