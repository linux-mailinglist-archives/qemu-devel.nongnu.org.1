Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB64A15E23
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Jan 2025 17:42:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZBt4-0003zs-Bh; Sat, 18 Jan 2025 11:41:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tZBsu-0003wd-AQ
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 11:41:22 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tZBsr-0007oS-Mc
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 11:41:20 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d3f57582a2so8513005a12.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 08:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737218476; x=1737823276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+wE3Swfoh6salpcQwR9qOMCQ5Jvi+Z3uZrnQwuPDqk=;
 b=ZEut6+g8ntPws/tMA3alCg1pdbOvtRbD98ZHJjIKtvrlNKyUgn84GdFM4cCjgUBwwQ
 HzbT0unDOFzuw9en/rFGi9SpxYMQUPIRWKJf14IkXl+UdAT2QW8crUuwxnmExjoyf1sI
 AhrKbQCYkS0qXKkZiojuF2SX8INJsKsznzsl/jZ+RL9f7Cmjs/ks0quUYRMm3Y21lmUR
 W+51qVT1DIU6NKCR6799mAQMVLlyfoo5H4MtPBZwel+CfYjTnvXEQHi/LYwuhA5Ryoiv
 J6A3g+GfM29DUPqBZskStUDRFFRcQqQ2HzdA9vo3272AURRw9GYAmFGnuN/ntpjn/v6D
 Bn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737218476; x=1737823276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d+wE3Swfoh6salpcQwR9qOMCQ5Jvi+Z3uZrnQwuPDqk=;
 b=rQWB/XB4oS3rDtlLIpC+ZVXm6HuEdg2QNozNR0s7GfhRwNReXBCjhUVBOL7MpvIUpe
 dDyhVecLqYj9L070MyoQ53hvb4dZwZGmvefpUu88Nwv/LXs3Q0Eh3/I1PsfBzRmAhWQY
 a/kQIdEMtHsHoyff0XziBMeYjwROiTGqJHrBp0/6n1VW1DKuObClito23tvvpF/4gd5g
 T1Q+V5JFnScRhuOvLMF/QTyT485hd5S6nODk9O5pe6APMJM41BTAjgGXRlBw0ajCGEP4
 B2plrpD5/w8m9UX28Wc8xnbQK+PwoGmDAXbERiE3srn+TCqSThqnReTQ6noAZhH3IwjQ
 oKoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXM7Q7Ll+MnmvH/336aeMEuResf10Kh8BzT12MaDjxybqco9sHETu8AuDj2pLR4tdoK1FRoU+JJ8IB@nongnu.org
X-Gm-Message-State: AOJu0Yw8wfz+R2C5hpPXvBaH8eFNWmAPf1Ki9Ce7qae4YWhhfjtVPT7p
 TsESr/APBPSqDneWGTUyMsoZM8jMeD51rQm7BdAjxNkErUbWCHds
X-Gm-Gg: ASbGncsPLrW+prK9LvCqamCPE9W3bD7EmEUthcTIaXsAtncNZA9oOL3N+P58n4OJNkm
 9T3k3xySXNfxvwbKmddNn57OEXQem/FCeZwJbSOZhjJ7XKwQLJCC2SWnFaj54K3NeOe+9A7ezPf
 yGXsTVfKnVAxWcHAYYro0NKMCE0HNxLWfAfoK+lMwhc6l5O7f9VhwbtPMHyCalAyFnE17BXLDBD
 GBBEboMLSVva4N1fx0NMO3A2Y8IeDOR/viuU8AOq5CCajwxHQ39yilpvudzcNbrqnkNxdIxQsMT
 wtE=
X-Google-Smtp-Source: AGHT+IEK5JS+f384lQ+QzM3xRo6AHb3TR1VZE0742dL9hi63zSQ27yn89P6EB8Gflro3oK5Z1Ss9gg==
X-Received: by 2002:a17:906:7954:b0:ab3:a515:c41 with SMTP id
 a640c23a62f3a-ab3a5155d68mr281436566b.16.1737218475894; 
 Sat, 18 Jan 2025 08:41:15 -0800 (PST)
Received: from think.fritz.box ([2a02:8109:8384:1400:d15a:20d8:4bbe:9a4c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f8624fsm358331266b.150.2025.01.18.08.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 08:41:14 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v7 2/4] chardev/char-hub: implement backend chardev aggregator
Date: Sat, 18 Jan 2025 17:40:50 +0100
Message-ID: <20250118164056.830721-3-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250118164056.830721-1-r.peniaev@gmail.com>
References: <20250118164056.830721-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patch implements a new chardev backend `hub` device, which
aggregates input from multiple backend devices and forwards it to a
single frontend device. Additionally, `hub` device takes the output
from the frontend device and sends it back to all the connected
backend devices. This allows for seamless interaction between
different backend devices and a single frontend interface.

The idea of the change is trivial: keep list of backend devices
(up to 4), init them on demand and forward data buffer back and
forth.

The following is QEMU command line example:

   -chardev pty,path=/tmp/pty,id=pty0 \
   -chardev vc,id=vc0 \
   -chardev hub,id=hub0,chardevs.0=pty0,chardevs.1=vc0 \
   -device virtconsole,chardev=hub0 \
   -vnc 0.0.0.0:0

Which creates 2 backend devices: text virtual console (`vc0`) and a
pseudo TTY (`pty0`) connected to the single virtio hvc console with
the backend aggregator (`hub0`) help. `vc0` renders text to an image,
which can be shared over the VNC protocol.  `pty0` is a pseudo TTY
backend which provides biderectional communication to the virtio hvc
console.

'chardevs.N' list syntax is used for the sake of compatibility with
the representation of JSON lists in 'key=val' pairs format of the
util/keyval.c, despite the fact that modern QAPI way of parsing,
namely qobject_input_visitor_new_str(), is not used. Choice of keeping
QAPI list sytax may help to smoothly switch to modern parsing in the
future.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-fe.c          |   9 +
 chardev/char-hub.c         | 334 +++++++++++++++++++++++++++++++++++++
 chardev/char.c             |  26 ++-
 chardev/chardev-internal.h |  56 ++++++-
 chardev/meson.build        |   1 +
 include/chardev/char.h     |   1 +
 qapi/char.json             |  27 +++
 7 files changed, 451 insertions(+), 3 deletions(-)
 create mode 100644 chardev/char-hub.c

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 158a5f4f551e..cfd0577c3f46 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -200,6 +200,12 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
             if (!mux_chr_attach_frontend(d, b, &tag, errp)) {
                 return false;
             }
+        } else if (CHARDEV_IS_HUB(s)) {
+            HubChardev *d = HUB_CHARDEV(s);
+
+            if (!hub_chr_attach_frontend(d, b, errp)) {
+                return false;
+            }
         } else if (s->be) {
             error_setg(errp, "chardev '%s' is already in use", s->label);
             return false;
@@ -226,6 +232,9 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)
         if (CHARDEV_IS_MUX(b->chr)) {
             MuxChardev *d = MUX_CHARDEV(b->chr);
             mux_chr_detach_frontend(d, b->tag);
+        } else if (CHARDEV_IS_HUB(b->chr)) {
+            HubChardev *d = HUB_CHARDEV(b->chr);
+            hub_chr_detach_frontend(d);
         }
         if (del) {
             Object *obj = OBJECT(b->chr);
diff --git a/chardev/char-hub.c b/chardev/char-hub.c
new file mode 100644
index 000000000000..9b53df51de44
--- /dev/null
+++ b/chardev/char-hub.c
@@ -0,0 +1,336 @@
+/*
+ * QEMU Character Hub Device
+ *
+ * Author: Roman Penyaev <r.peniaev@gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/option.h"
+#include "chardev/char.h"
+#include "chardev-internal.h"
+
+/*
+ * Character hub device aggregates input from multiple backend devices
+ * and forwards it to a single frontend device. Additionally, hub
+ * device takes the output from the frontend device and sends it back
+ * to all the connected backend devices.
+ */
+
+/*
+ * Write to all backends. Different backend devices accept data with
+ * various rate, so it is quite possible that one device returns less,
+ * then others. In this case we return minimum to the caller,
+ * expecting caller will repeat operation soon. When repeat happens
+ * send to the devices which consume data faster must be avoided
+ * for obvious reasons not to send data, which was already sent.
+ */
+static int hub_chr_write_to_all(HubChardev *d, const uint8_t *buf, int len)
+{
+    int r, i, ret = len;
+    unsigned int written;
+
+    /* Invalidate index on every write */
+    d->be_eagain_ind = -1;
+
+    for (i = 0; i < d->be_cnt; i++) {
+        if (!d->backends[i].be.chr->be_open) {
+            /* Skip closed backend */
+            continue;
+        }
+        written = d->be_written[i] - d->be_min_written;
+        if (written) {
+            /* Written in the previous call so take into account */
+            ret = MIN(written, ret);
+            continue;
+        }
+        r = qemu_chr_fe_write(&d->backends[i].be, buf, len);
+        if (r < 0 && errno == EAGAIN) {
+            /*
+             * Fail immediately if write would block. Expect to be called
+             * soon on watch wake up.
+             */
+            d->be_eagain_ind = i;
+            return r;
+        } else if (r < 0) {
+            /*
+             * Ignore all other errors and pretend the entire buffer is
+             * written to avoid this chardev being watched. This device
+             * becomes disabled until the following write succeeds, but
+             * writing continues to others.
+             */
+            r = len;
+        }
+        d->be_written[i] += r;
+        ret = MIN(r, ret);
+    }
+    d->be_min_written += ret;
+
+    return ret;
+}
+
+/* Called with chr_write_lock held.  */
+static int hub_chr_write(Chardev *chr, const uint8_t *buf, int len)
+{
+    HubChardev *d = HUB_CHARDEV(chr);
+    return hub_chr_write_to_all(d, buf, len);
+}
+
+static int hub_chr_can_read(void *opaque)
+{
+    HubCharBackend *backend = opaque;
+    CharBackend *fe = backend->hub->frontend;
+
+    if (fe && fe->chr_can_read) {
+        return fe->chr_can_read(fe->opaque);
+    }
+
+    return 0;
+}
+
+static void hub_chr_read(void *opaque, const uint8_t *buf, int size)
+{
+    HubCharBackend *backend = opaque;
+    CharBackend *fe = backend->hub->frontend;
+
+
+    if (fe && fe->chr_read) {
+        fe->chr_read(fe->opaque, buf, size);
+    }
+}
+
+static void hub_chr_event(void *opaque, QEMUChrEvent event)
+{
+    HubCharBackend *backend = opaque;
+    HubChardev *d = backend->hub;
+    CharBackend *fe = d->frontend;
+
+    if (event == CHR_EVENT_OPENED) {
+        /*
+         * Catch up with what was already written while this backend
+         * was closed
+         */
+        d->be_written[backend->be_ind] = d->be_min_written;
+
+        if (d->be_event_opened_cnt++) {
+            /* Ignore subsequent open events from other backends */
+            return;
+        }
+    } else if (event == CHR_EVENT_CLOSED) {
+        if (!d->be_event_opened_cnt) {
+            /* Don't go below zero. Probably assert is better */
+            return;
+        }
+        if (--d->be_event_opened_cnt) {
+            /* Serve only the last one close event */
+            return;
+        }
+    }
+
+    if (fe && fe->chr_event) {
+        fe->chr_event(fe->opaque, event);
+    }
+}
+
+static GSource *hub_chr_add_watch(Chardev *s, GIOCondition cond)
+{
+    HubChardev *d = HUB_CHARDEV(s);
+    Chardev *chr;
+    ChardevClass *cc;
+
+    if (d->be_eagain_ind == -1) {
+        return NULL;
+    }
+
+    assert(d->be_eagain_ind < d->be_cnt);
+    chr = qemu_chr_fe_get_driver(&d->backends[d->be_eagain_ind].be);
+    cc = CHARDEV_GET_CLASS(chr);
+    if (!cc->chr_add_watch) {
+        return NULL;
+    }
+
+    return cc->chr_add_watch(chr, cond);
+}
+
+static bool hub_chr_attach_chardev(HubChardev *d, Chardev *chr,
+                                   Error **errp)
+{
+    bool ret;
+
+    if (d->be_cnt >= MAX_HUB) {
+        error_setg(errp, "hub: too many uses of chardevs '%s'"
+                   " (maximum is " stringify(MAX_HUB) ")",
+                   d->parent.label);
+        return false;
+    }
+    ret = qemu_chr_fe_init(&d->backends[d->be_cnt].be, chr, errp);
+    if (ret) {
+        d->backends[d->be_cnt].hub = d;
+        d->backends[d->be_cnt].be_ind = d->be_cnt;
+        d->be_cnt += 1;
+    }
+
+    return ret;
+}
+
+static void char_hub_finalize(Object *obj)
+{
+    HubChardev *d = HUB_CHARDEV(obj);
+    CharBackend *fe = d->frontend;
+    int i;
+
+    if (fe) {
+        fe->chr = NULL;
+    }
+    for (i = 0; i < d->be_cnt; i++) {
+        qemu_chr_fe_deinit(&d->backends[i].be, false);
+    }
+}
+
+static void hub_chr_update_read_handlers(Chardev *chr)
+{
+    HubChardev *d = HUB_CHARDEV(chr);
+    int i;
+
+    for (i = 0; i < d->be_cnt; i++) {
+        qemu_chr_fe_set_handlers_full(&d->backends[i].be,
+                                      hub_chr_can_read,
+                                      hub_chr_read,
+                                      hub_chr_event,
+                                      NULL,
+                                      &d->backends[i],
+                                      chr->gcontext, true, false);
+    }
+}
+
+bool hub_chr_attach_frontend(HubChardev *d, CharBackend *b, Error **errp)
+{
+    if (d->frontend) {
+        error_setg(errp, "hub: multiplexed chardev '%s' is already used "
+                   "for multiplexing", d->parent.label);
+        return false;
+    }
+    d->frontend = b;
+
+    return true;
+}
+
+void hub_chr_detach_frontend(HubChardev *d)
+{
+    d->frontend = NULL;
+}
+
+static void qemu_chr_open_hub(Chardev *chr,
+                                 ChardevBackend *backend,
+                                 bool *be_opened,
+                                 Error **errp)
+{
+    ChardevHub *hub = backend->u.hub.data;
+    HubChardev *d = HUB_CHARDEV(chr);
+    strList *list = hub->chardevs;
+
+    d->be_eagain_ind = -1;
+
+    if (list == NULL) {
+        error_setg(errp, "hub: 'chardevs' list is not defined");
+        return;
+    }
+
+    while (list) {
+        Chardev *s;
+
+        s = qemu_chr_find(list->value);
+        if (s == NULL) {
+            error_setg(errp, "hub: chardev can't be found by id '%s'",
+                       list->value);
+            return;
+        }
+        if (CHARDEV_IS_HUB(s) || CHARDEV_IS_MUX(s)) {
+            error_setg(errp, "hub: multiplexers and hub devices can't be "
+                       "stacked, check chardev '%s', chardev should not "
+                       "be a hub device or have 'mux=on' enabled",
+                       list->value);
+            return;
+        }
+        if (!hub_chr_attach_chardev(d, s, errp)) {
+            return;
+        }
+        list = list->next;
+    }
+
+    /* Closed until an explicit event from backend */
+    *be_opened = false;
+}
+
+static void qemu_chr_parse_hub(QemuOpts *opts, ChardevBackend *backend,
+                                  Error **errp)
+{
+    ChardevHub *hub;
+    strList **tail;
+    int i;
+
+    backend->type = CHARDEV_BACKEND_KIND_HUB;
+    hub = backend->u.hub.data = g_new0(ChardevHub, 1);
+    qemu_chr_parse_common(opts, qapi_ChardevHub_base(hub));
+
+    tail = &hub->chardevs;
+
+    for (i = 0; i < MAX_HUB; i++) {
+        char optbuf[16];
+        const char *dev;
+
+        snprintf(optbuf, sizeof(optbuf), "chardevs.%u", i);
+        dev = qemu_opt_get(opts, optbuf);
+        if (!dev) {
+            break;
+        }
+
+        QAPI_LIST_APPEND(tail, g_strdup(dev));
+    }
+}
+
+static void char_hub_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->parse = qemu_chr_parse_hub;
+    cc->open = qemu_chr_open_hub;
+    cc->chr_write = hub_chr_write;
+    cc->chr_add_watch = hub_chr_add_watch;
+    /* We handle events from backends only */
+    cc->chr_be_event = NULL;
+    cc->chr_update_read_handler = hub_chr_update_read_handlers;
+}
+
+static const TypeInfo char_hub_type_info = {
+    .name = TYPE_CHARDEV_HUB,
+    .parent = TYPE_CHARDEV,
+    .class_init = char_hub_class_init,
+    .instance_size = sizeof(HubChardev),
+    .instance_finalize = char_hub_finalize,
+};
+
+static void register_types(void)
+{
+    type_register_static(&char_hub_type_info);
+}
+
+type_init(register_types);
diff --git a/chardev/char.c b/chardev/char.c
index 7705da5ad02b..31536f4b7356 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -334,6 +334,9 @@ static bool qemu_chr_is_busy(Chardev *s)
     if (CHARDEV_IS_MUX(s)) {
         MuxChardev *d = MUX_CHARDEV(s);
         return d->mux_bitset != 0;
+    } else if (CHARDEV_IS_HUB(s)) {
+        HubChardev *d = HUB_CHARDEV(s);
+        return d->frontend != NULL;
     } else {
         return s->be != NULL;
     }
@@ -943,7 +946,26 @@ QemuOptsList qemu_chardev_opts = {
         },{
             .name = "chardev",
             .type = QEMU_OPT_STRING,
+        },
+        /*
+         * Multiplexer options. Follows QAPI array syntax.
+         * See MAX_HUB macro to obtain array capacity.
+         */
+        {
+            .name = "chardevs.0",
+            .type = QEMU_OPT_STRING,
+        },{
+            .name = "chardevs.1",
+            .type = QEMU_OPT_STRING,
         },{
+            .name = "chardevs.2",
+            .type = QEMU_OPT_STRING,
+        },{
+            .name = "chardevs.3",
+            .type = QEMU_OPT_STRING,
+        },
+
+        {
             .name = "append",
             .type = QEMU_OPT_BOOL,
         },{
@@ -1106,8 +1128,8 @@ ChardevReturn *qmp_chardev_change(const char *id, ChardevBackend *backend,
         return NULL;
     }
 
-    if (CHARDEV_IS_MUX(chr)) {
-        error_setg(errp, "Mux device hotswap not supported yet");
+    if (CHARDEV_IS_MUX(chr) || CHARDEV_IS_HUB(chr)) {
+        error_setg(errp, "For mux or hub device hotswap is not supported yet");
         return NULL;
     }
 
diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index 853807f3cb88..ff5432008aad 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -29,13 +29,16 @@
 #include "chardev/char-fe.h"
 #include "qom/object.h"
 
+#define MAX_HUB 4
 #define MAX_MUX 4
 #define MUX_BUFFER_SIZE 32 /* Must be a power of 2.  */
 #define MUX_BUFFER_MASK (MUX_BUFFER_SIZE - 1)
 
 struct MuxChardev {
     Chardev parent;
+    /* Linked frontends */
     CharBackend *backends[MAX_MUX];
+    /* Linked backend */
     CharBackend chr;
     unsigned long mux_bitset;
     int focus;
@@ -53,11 +56,59 @@ struct MuxChardev {
     int64_t timestamps_start;
 };
 typedef struct MuxChardev MuxChardev;
+typedef struct HubChardev HubChardev;
+typedef struct HubCharBackend HubCharBackend;
+
+/*
+ * Back-pointer on a hub, actual backend and its index in
+ * `hub->backends` array
+ */
+struct HubCharBackend {
+    HubChardev   *hub;
+    CharBackend  be;
+    unsigned int be_ind;
+};
+
+struct HubChardev {
+    Chardev parent;
+    /* Linked frontend */
+    CharBackend *frontend;
+    /* Linked backends */
+    HubCharBackend backends[MAX_HUB];
+    /*
+     * Number of backends attached to this hub. Once attached, a
+     * backend can't be detached, so the counter is only increasing.
+     * To safely remove a backend, hub has to be removed first.
+     */
+    unsigned int be_cnt;
+    /*
+     * Number of CHR_EVEN_OPENED events from all backends. Needed to
+     * send CHR_EVEN_CLOSED only when counter goes to zero.
+     */
+    unsigned int be_event_opened_cnt;
+    /*
+     * Counters of written bytes from a single frontend device
+     * to multiple backend devices.
+     */
+    unsigned int be_written[MAX_HUB];
+    unsigned int be_min_written;
+    /*
+     * Index of a backend device which got EAGAIN on last write,
+     * -1 is invalid index.
+     */
+    int be_eagain_ind;
+};
+typedef struct HubChardev HubChardev;
 
 DECLARE_INSTANCE_CHECKER(MuxChardev, MUX_CHARDEV,
                          TYPE_CHARDEV_MUX)
-#define CHARDEV_IS_MUX(chr)                             \
+DECLARE_INSTANCE_CHECKER(HubChardev, HUB_CHARDEV,
+                         TYPE_CHARDEV_HUB)
+
+#define CHARDEV_IS_MUX(chr)                                \
     object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX)
+#define CHARDEV_IS_HUB(chr)                                \
+    object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_HUB)
 
 bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
                              unsigned int *tag, Error **errp);
@@ -65,6 +116,9 @@ bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag);
 void mux_set_focus(Chardev *chr, unsigned int focus);
 void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
 
+bool hub_chr_attach_frontend(HubChardev *d, CharBackend *b, Error **errp);
+void hub_chr_detach_frontend(HubChardev *d);
+
 Object *get_chardevs_root(void);
 
 #endif /* CHARDEV_INTERNAL_H */
diff --git a/chardev/meson.build b/chardev/meson.build
index 70070a8279a9..56ee39ac0b01 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -3,6 +3,7 @@ chardev_ss.add(files(
   'char-file.c',
   'char-io.c',
   'char-mux.c',
+  'char-hub.c',
   'char-null.c',
   'char-pipe.c',
   'char-ringbuf.c',
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 01df55f9e8c8..429852f8d9d3 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -232,6 +232,7 @@ OBJECT_DECLARE_TYPE(Chardev, ChardevClass, CHARDEV)
 
 #define TYPE_CHARDEV_NULL "chardev-null"
 #define TYPE_CHARDEV_MUX "chardev-mux"
+#define TYPE_CHARDEV_HUB "chardev-hub"
 #define TYPE_CHARDEV_RINGBUF "chardev-ringbuf"
 #define TYPE_CHARDEV_PTY "chardev-pty"
 #define TYPE_CHARDEV_CONSOLE "chardev-console"
diff --git a/qapi/char.json b/qapi/char.json
index e04535435034..f02b66c06b3e 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -332,6 +332,19 @@
   'data': { 'chardev': 'str' },
   'base': 'ChardevCommon' }
 
+##
+# @ChardevHub:
+#
+# Configuration info for hub chardevs.
+#
+# @chardevs: List of chardev IDs, which should be added to this hub
+#
+# Since: 10.0
+##
+{ 'struct': 'ChardevHub',
+  'data': { 'chardevs': ['str'] },
+  'base': 'ChardevCommon' }
+
 ##
 # @ChardevStdio:
 #
@@ -479,6 +492,8 @@
 #
 # @mux: (since 1.5)
 #
+# @hub: (since 10.0)
+#
 # @msmouse: emulated Microsoft serial mouse (since 1.5)
 #
 # @wctablet: emulated Wacom Penpartner serial tablet (since 2.9)
@@ -521,6 +536,7 @@
             'pty',
             'null',
             'mux',
+            'hub',
             'msmouse',
             'wctablet',
             { 'name': 'braille', 'if': 'CONFIG_BRLAPI' },
@@ -595,6 +611,16 @@
 { 'struct': 'ChardevMuxWrapper',
   'data': { 'data': 'ChardevMux' } }
 
+##
+# @ChardevHubWrapper:
+#
+# @data: Configuration info for hub chardevs
+#
+# Since: 10.0
+##
+{ 'struct': 'ChardevHubWrapper',
+  'data': { 'data': 'ChardevHub' } }
+
 ##
 # @ChardevStdioWrapper:
 #
@@ -703,6 +729,7 @@
             'pty': 'ChardevPtyWrapper',
             'null': 'ChardevCommonWrapper',
             'mux': 'ChardevMuxWrapper',
+            'hub': 'ChardevHubWrapper',
             'msmouse': 'ChardevCommonWrapper',
             'wctablet': 'ChardevCommonWrapper',
             'braille': { 'type': 'ChardevCommonWrapper',
-- 
2.43.0


