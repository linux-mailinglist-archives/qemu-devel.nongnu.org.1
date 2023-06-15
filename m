Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C86C6731A15
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 15:35:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9n7Q-0008Ry-KD; Thu, 15 Jun 2023 09:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <huasenzhang@foxmail.com>)
 id 1q9kLJ-0003za-Cv
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 06:36:41 -0400
Received: from out162-62-57-64.mail.qq.com ([162.62.57.64])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <huasenzhang@foxmail.com>)
 id 1q9kLG-0006Kj-N0
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 06:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1686825386;
 bh=pNrW9vjqvWWoCJJOYtWj9365TGMtYXNkIGKhKEdijQE=;
 h=From:To:Cc:Subject:Date;
 b=Oryru5Fk8lbHje92Ci5qez1dWQrRhj+XJsmPpnvTiFMKe6sMmgzMygj0NDyEGpL3o
 fUiXSaLmBguVY8vOpn3SMniKHDjGt+2MVPVSlWvU6kGQolRu5HsGdIUu7mUtknkXn0
 7+IZJL0M3cJkImRGErGnIwo/3SpOwEPjjr/rDDzk=
Received: from localhost.localdomain ([14.18.187.46])
 by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
 id 8CB0D862; Thu, 15 Jun 2023 18:35:11 +0800
X-QQ-mid: xmsmtpt1686825311td95wn0ka
Message-ID: <tencent_8DA57B405D427A560FD40F8FB0C0B1ADDE09@qq.com>
X-QQ-XMAILINFO: No84gL0ijbqce/xSuu3ksqY7JXEgl64aipk8ej1lPpa9+S+pIfRd7iAC0zAvuk
 VxgpLuJ4dNlXlQkbEm7RLgLamzN6dqZRz3NkF80gkZNPqO4HuuHAPZ4ZnXAIhlrgUek3wkluN0DZ
 m8p8iSsl/XFoK9Mig6ZdmM4AtuFf65wd4Asv9seWt19QvtXW3Jpjh9L1B+TTJrRa7S9aVUOCgPyl
 8ca2iiF2HmTqYiwzs7wDNm90XcTkK7tDEmkJXw+YsQ3khXon2dFs8QllaB1jkabZsOsWxN8nUgfU
 6JzU1TDolyViLVKQdaEuQQ7AvTTUjSlYtkwM0FfX0Y3dEC3wBGIDxq0ivNgCrHcfwibrDVBOdxNy
 wObExAqGq3UZkX0VC2C+r4Xf1T4WwMcONaCYVbdJddyDA//c5V4fOobYOpuwy2DtytyY9XZDRXJs
 lzI7Le4vS7s+kuw0NvNKe5st2zrZckkys4I1HJoj1jQuoB3aw4An78X3+5kkLBPiQ5q11mIF4Xp1
 KZg0BJuy/Tts/6KEPOIGuLcQMaWJ2dO8+fhhLRyhgesxAgSvuj/GX+SQGd6vKmpbDbxVBu6FT8+o
 fJYiy9XI5X+IvsJBFxx89KWNBTlIGw7Iiu3Fm1rVvHTmxImskbLck1caW4sJWP6eklKfZ8nklctM
 eI9v7sS99jevG2AxEq9pjLFCEJasVxqYkCRLuEsg9DNFt2OG0XYBMv7sEcPC9F/uQB4X+2GHXGIc
 85KfoBWm6oIOLZeoS0IeTZ7JKhsl/jS9dtDJmwMFJDmF/zmI866kCRKZb10Ym1YNMtPRnKtJbfe7
 3Z0q62KTq+uxnPbIWP5L1fuNDyTHiPo1XqBbaBYX8T9IfFZyLCq7td+UV2T2H3Meva7uotcx58to
 5dNmu/a0x4Z1HE4REEwvKhenswLcduRIfhkH4icDF2sQW6Kstr89IClkXcAYyx5SXcjH8cYBN302
 87XJpjl/LH9Ya6HE4xxK7e4psOC4EXw0+urhZtYM0hKf30mH3jLU0Ej2bbaKAu
X-QQ-XMRINFO: M0RWTeBkoNRBR1Uh12iQNRvA1CSLhD8+1Q==
From: Zhang Huasen <huasenzhang@foxmail.com>
To: huasenzhang@foxmail.com,
	qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Subject: [PATCH] chardev/char-win-stdio: Support VT sequences on Windows 11
 host
Date: Thu, 15 Jun 2023 18:35:00 +0800
X-OQ-MSGID: <20230615103511.3299-1-huasenzhang@foxmail.com>
X-Mailer: git-send-email 2.41.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.64;
 envelope-from=huasenzhang@foxmail.com; helo=out162-62-57-64.mail.qq.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 15 Jun 2023 09:34:25 -0400
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

If the monitor or the serial port use STDIO as backend on Windows 11 host,
e.g. -nographic options is used, the monitor or the guest Linux do not
response to arrow keys.

When Windows creates a console, ENABLE_VIRTUAL_PROCESS_INPUT is disabled
by default. Arrow keys cannot be retrieved by ReadFile or ReadConsoleInput
functions.

Add ENABLE_VIRTUAL_PROCESS_INPUT to the flag which is passed to SetConsoleMode,
when opening stdio console.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1674

Signed-off-by: Zhang Huasen <huasenzhang@foxmail.com>
---
 chardev/char-win-stdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index eb830eabd9..1a18999e78 100644
--- a/chardev/char-win-stdio.c
+++ b/chardev/char-win-stdio.c
@@ -190,7 +190,7 @@ static void qemu_chr_open_stdio(Chardev *chr,
         }
     }
 
-    dwMode |= ENABLE_LINE_INPUT;
+    dwMode |= ENABLE_LINE_INPUT | ENABLE_VIRTUAL_TERMINAL_INPUT;
 
     if (is_console) {
         /* set the terminal in raw mode */
-- 
2.41.0.windows.1


