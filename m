Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A527F11E6
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 12:24:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r52O6-0004Em-GO; Mon, 20 Nov 2023 06:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r52Np-0004D1-2p
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 06:24:05 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r52Nj-00077P-LE
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 06:24:02 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc1ee2d8dfso37607475ad.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 03:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700479436; x=1701084236;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bR4kc8wOrFfjmtOt3ZkWz10Jcqjs8BczuOQt6Gw4Imw=;
 b=ULdsyoXGw1L/b7wjc4GrCPbpyZEgQrv4s6Lf3Ku3iI+wJ8pdm1VijyX0OJSHmikmpg
 BASHT3CqHjm0opAcgSaNcrACXwSDhP3PeT9gCMFgCFxjhVjgif74vbD4AEPAi8/l3pII
 QmC6m9k4gWlXErefD3SNEzppcXOBl5CN8scEOiKxO5dwZgiUKLwfLRYoNPNPMbe+8xzu
 z7t4zSfYpR0gbWm+Ij44l9Hmf0spb6BI7smwUO3Ehu9TIDLbRTb20VQOpzI4ySmupcnE
 VXRc86XOgw13WYBCv9wn4EufjKo470185SBlD3OFNJCaE9lsdMaojd9fmdhvXDPRefTm
 PemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700479436; x=1701084236;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bR4kc8wOrFfjmtOt3ZkWz10Jcqjs8BczuOQt6Gw4Imw=;
 b=l5hmZvUFQJKZRRXw8pPkH6wf2t4HdYFo2dioauaF+PqetvP9ehoA8dDt+EITvaR2os
 S7W6nV3Vh3NORmdknuucfav0KgPM9/YwHQDiBx2p3ntmEW8fW1nIXT6NF2v/ihdZVxXd
 rFbWsbuen7WtGfkMxqJrdlvCFugZylcMmL3+ycEEopY4Qj7nrXyDGzFPR4JAWp2ViiUD
 z8tss/u5/T8taCJfU480AozepnR1h5cFleChFliY7CamsPsIqIK/k9Pgq5NdXuFql44/
 3ZJ4+aoVzVsjncDoZ3/zIz72wgQs3XBcVhifvxDw038CIvWgucnhTBCMZDgPFYpF7l7I
 Dl5g==
X-Gm-Message-State: AOJu0YxMJuZ0Ln0MU3mmmrpgcwtBEb/mIj+jaCod6ZV9ZUyxdnTmW9i7
 kqBuM9okUlwPShw4kjzvQmOSHQ==
X-Google-Smtp-Source: AGHT+IFpdxjbHJyzV6/yzAGAq/OE0TyL7GpGcANgD5c8ClPhhp0IFaY330I7o6KNAAnWL6AhpfjqRA==
X-Received: by 2002:a17:90b:1b12:b0:283:3f5f:b29b with SMTP id
 nu18-20020a17090b1b1200b002833f5fb29bmr7129350pjb.27.1700479436455; 
 Mon, 20 Nov 2023 03:23:56 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 p3-20020a17090ab90300b00285125abb33sm3450621pjr.4.2023.11.20.03.23.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 03:23:56 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH] meson: -Wno-error=format-overflow for ubsan
Date: Mon, 20 Nov 2023 20:23:26 +0900
Message-ID: <20231120112329.4149-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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

ubsan causes wrong -Wformat-overflow warnings as follows:

In file included from /usr/include/stdio.h:906,
                 from /home/alarm/q/var/qemu/include/qemu/osdep.h:114,
                 from ../disas/cris.c:21:
In function 'sprintf',
    inlined from 'format_dec' at ../disas/cris.c:1737:3,
    inlined from 'print_with_operands' at ../disas/cris.c:2477:12,
    inlined from 'print_insn_cris_generic.constprop' at ../disas/cris.c:2690:8:
/usr/include/bits/stdio2.h:30:10: warning: null destination pointer [-Wformat-overflow=]
   30 |   return __builtin___sprintf_chk (__s, __USE_FORTIFY_LEVEL - 1,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   31 |                                   __glibc_objsize (__s), __fmt,
      |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   32 |                                   __va_arg_pack ());
      |                                   ~~~~~~~~~~~~~~~~~

Don't let these errors stop the build.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index d7d841e71e..02f1a18080 100644
--- a/meson.build
+++ b/meson.build
@@ -365,7 +365,9 @@ if get_option('sanitizers')
   # Detect static linking issue with ubsan - https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84285
   if cc.links('int main(int argc, char **argv) { return argc + 1; }',
               args: [qemu_ldflags, '-fsanitize=undefined'])
-    qemu_cflags = ['-fsanitize=undefined'] + qemu_cflags
+    # 87884 – ubsan causes wrong -Wformat-overflow warning
+    # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=87884
+    qemu_cflags = ['-fsanitize=undefined', '-Wno-error=format-overflow'] + qemu_cflags
     qemu_ldflags = ['-fsanitize=undefined'] + qemu_ldflags
   endif
 endif
-- 
2.42.1


