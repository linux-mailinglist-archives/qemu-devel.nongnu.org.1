Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 443A5930D93
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jul 2024 07:27:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTEER-0003Wz-19; Mon, 15 Jul 2024 01:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTEEM-0003MN-2K
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:26:34 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTEE8-0000gA-Hx
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:26:33 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-78cc22902dcso731858a12.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 22:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721021179; x=1721625979;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A5DQvwhNUSdfuiyr6xdA4cBcty39lESgP6o5nYgfKFY=;
 b=jzA9XsY45Lav5cpWrR8OB1v5DY8cEjsFMSvX//hRdRHg8qLI637+f7yAyDKYRz1VSX
 zhiZREyMQOvM/yDoiQDIs3vdTOrDX4TK/klXHYowVuj9qdfoUqLvp9Ts0I1C918aARFU
 bN+yQTUKAN/2LXLHc1Y6adQHS5L99Ybw2q79pN+YKKoPA0Klx1wcVqP9bddiqllRWFEe
 F8xU8bFeuP+128zQ4U3CrpY2peSfLfgHj19sTtA6mY41pm4ZZ1FI2cFH06jj6IEiVNxV
 gKw6MtxbXNy8RxHyE35UCLeXiAwcINVBydJZNEqvGEmpqm6yZpKP5y/vNN1hgxr1mRFl
 KeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721021179; x=1721625979;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A5DQvwhNUSdfuiyr6xdA4cBcty39lESgP6o5nYgfKFY=;
 b=uHf8Mgsqy34yLv02qW0KP2gcR1ujgTrMBOHZNOKA94FB/NKHg++bekKkTyqm6DEFpW
 zIOqcY1NEHGyleBPCT16Ms3Snzsf+tUh6aoPQnJT+h3BxO6pzRnNBK21ZTra4UvbzNI4
 3a5tQw8HxKQyw5T0MetNEQdrWbJzZsb1D5jjiB4FkD3TmeFi3v/bN9QthkkelKFG8eme
 C/E1mXGD6MMdeZ6655SHMF6LjIiPbekTCmTimirnF43rxIis0FcsGzBBi+UykneiAswW
 Wn9xKQLAT9r3FwETbNKNq/wHBVQlPTFLMhWcOCF8A/2douOlpu9lWnp7238QZFDeIZtu
 k32A==
X-Gm-Message-State: AOJu0Yxm33bnw4CLmudo6JytlPlTtwj/EhISrryCS5hS+z7Xvqd0/3yB
 c06kLt4tM/r1AghE7iaME/gwLjtNfzHEh5y/PowSRUsSCJBCJahnLlLu1ocgW4hELfUc/eLGVdU
 sFw8=
X-Google-Smtp-Source: AGHT+IG6ZTJyiWSpAJyCixANZSAj85vvDwMcslX2xfCRjN5x4MOMWqxorowMIRKWniFs7t2fkNIKtQ==
X-Received: by 2002:a05:6a20:4328:b0:1c3:3436:a225 with SMTP id
 adf61e73a8af0-1c33436aef4mr14010262637.21.1721021179097; 
 Sun, 14 Jul 2024 22:26:19 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2caedcac045sm3370440a91.57.2024.07.14.22.26.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 22:26:18 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 15 Jul 2024 14:25:45 +0900
Subject: [PATCH v3 4/4] ui/console: Remove dpy_cursor_define_supported()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240715-cursor-v3-4-afa5b9492dbf@daynix.com>
References: <20240715-cursor-v3-0-afa5b9492dbf@daynix.com>
In-Reply-To: <20240715-cursor-v3-0-afa5b9492dbf@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::52e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Remove dpy_cursor_define_supported() as it brings no benefit today and
it has a few inherent problems.

All graphical displays except egl-headless support cursor composition
without DMA-BUF, and egl-headless is meant to be used in conjunction
with another graphical display, so dpy_cursor_define_supported()
always returns true and meaningless.

Even if we add a new display without cursor composition in the future,
dpy_cursor_define_supported() will be problematic as a cursor display
fix for it because some display devices like virtio-gpu cannot tell the
lack of cursor composition capability to the guest and are unable to
utilize the value the function returns. Therefore, all non-headless
graphical displays must actually implement cursor composition for
correct cursor display.

Another problem with dpy_cursor_define_supported() is that it returns
true even if only some of the display listeners support cursor
composition, which is wrong unless all display listeners that lack
cursor composition is headless.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/ui/console.h    |  1 -
 hw/display/qxl-render.c |  4 ----
 hw/display/vmware_vga.c |  6 ++----
 ui/console.c            | 13 -------------
 4 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 82b573e68082..fa986ab97e3b 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -324,7 +324,6 @@ void dpy_text_update(QemuConsole *con, int x, int y, int w, int h);
 void dpy_text_resize(QemuConsole *con, int w, int h);
 void dpy_mouse_set(QemuConsole *con, int x, int y, bool on);
 void dpy_cursor_define(QemuConsole *con, QEMUCursor *cursor);
-bool dpy_cursor_define_supported(QemuConsole *con);
 bool dpy_gfx_check_format(QemuConsole *con,
                           pixman_format_code_t format);
 
diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index ec99ec887a6e..837d2446cd52 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -307,10 +307,6 @@ int qxl_render_cursor(PCIQXLDevice *qxl, QXLCommandExt *ext)
         return 1;
     }
 
-    if (!dpy_cursor_define_supported(qxl->vga.con)) {
-        return 0;
-    }
-
     if (qxl->debug > 1 && cmd->type != QXL_CURSOR_MOVE) {
         fprintf(stderr, "%s", __func__);
         qxl_log_cmd_cursor(qxl, cmd, ext->group_id);
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 512f224b9f58..3db3ff98f763 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -904,10 +904,8 @@ static uint32_t vmsvga_value_read(void *opaque, uint32_t address)
         caps |= SVGA_CAP_RECT_FILL;
 #endif
 #ifdef HW_MOUSE_ACCEL
-        if (dpy_cursor_define_supported(s->vga.con)) {
-            caps |= SVGA_CAP_CURSOR | SVGA_CAP_CURSOR_BYPASS_2 |
-                    SVGA_CAP_CURSOR_BYPASS;
-        }
+        caps |= SVGA_CAP_CURSOR | SVGA_CAP_CURSOR_BYPASS_2 |
+                SVGA_CAP_CURSOR_BYPASS;
 #endif
         ret = caps;
         break;
diff --git a/ui/console.c b/ui/console.c
index 0ec70cb50ce6..33976446425e 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1001,19 +1001,6 @@ void dpy_cursor_define(QemuConsole *c, QEMUCursor *cursor)
     }
 }
 
-bool dpy_cursor_define_supported(QemuConsole *con)
-{
-    DisplayState *s = con->ds;
-    DisplayChangeListener *dcl;
-
-    QLIST_FOREACH(dcl, &s->listeners, next) {
-        if (dcl->ops->dpy_cursor_define) {
-            return true;
-        }
-    }
-    return false;
-}
-
 QEMUGLContext dpy_gl_ctx_create(QemuConsole *con,
                                 struct QEMUGLParams *qparams)
 {

-- 
2.45.2


