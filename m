Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7FBA26138
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Feb 2025 18:20:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf06T-00087u-Dp; Mon, 03 Feb 2025 12:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tf06Q-00087h-7X
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:19:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tf06N-0003ym-Ob
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:19:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738603155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pFBlPoR8oobvBzAsrZH9vZK9ovsNpf2glQXgbzvjxyg=;
 b=VhwvxukBO/hBW1ChNb7sMjnagghjCMQusG8ucjYA4XPk+Is/46Rqve/ukUz6pQbQnv9IGV
 Out5O0UUyedtEOCKWJgACXkuAYZVwP9Ry0Y7mpeN2ZhyGobxicOuIOjD5YgyBr14WV1wpl
 ztbD7g79AQux0ZLfIyRrRcKdV2UEhaM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-EdNPa-HDO0iopUE7zPd00A-1; Mon,
 03 Feb 2025 12:19:08 -0500
X-MC-Unique: EdNPa-HDO0iopUE7zPd00A-1
X-Mimecast-MFC-AGG-ID: EdNPa-HDO0iopUE7zPd00A
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 348671800366; Mon,  3 Feb 2025 17:19:07 +0000 (UTC)
Received: from localhost (unknown [10.39.208.25])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B6091800267; Mon,  3 Feb 2025 17:19:04 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org, Alexandre Iooss <erdnaxe@crans.org>,
 Roman Penyaev <r.peniaev@gmail.com>
Subject: [PULL v2 2/8] chardev/char-hub: implement backend chardev aggregator
Date: Mon,  3 Feb 2025 21:18:42 +0400
Message-ID: <20250203171848.686582-3-marcandre.lureau@redhat.com>
In-Reply-To: <20250203171848.686582-1-marcandre.lureau@redhat.com>
References: <20250203171848.686582-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Roman Penyaev <r.peniaev@gmail.com>

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
QAPI list syntax may help to smoothly switch to modern parsing in the
future.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Reviewed-by: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <20250123085327.965501-3-r.peniaev@gmail.com>
---
 qapi/char.json             |  27 ++++
 chardev/chardev-internal.h |  51 ++++++-
 include/chardev/char.h     |   1 +
 chardev/char-hub.c         | 301 +++++++++++++++++++++++++++++++++++++
 chardev/char.c             |  23 ++-
 chardev/meson.build        |   1 +
 6 files changed, 401 insertions(+), 3 deletions(-)
 create mode 100644 chardev/char-hub.c

diff --git a/qapi/char.json b/qapi/char.json
index e045354350..f02b66c06b 100644
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
diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index 853807f3cb..9752dd75f7 100644
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
@@ -53,11 +56,57 @@ struct MuxChardev {
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
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 01df55f9e8..429852f8d9 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -232,6 +232,7 @@ OBJECT_DECLARE_TYPE(Chardev, ChardevClass, CHARDEV)
 
 #define TYPE_CHARDEV_NULL "chardev-null"
 #define TYPE_CHARDEV_MUX "chardev-mux"
+#define TYPE_CHARDEV_HUB "chardev-hub"
 #define TYPE_CHARDEV_RINGBUF "chardev-ringbuf"
 #define TYPE_CHARDEV_PTY "chardev-pty"
 #define TYPE_CHARDEV_CONSOLE "chardev-console"
diff --git a/chardev/char-hub.c b/chardev/char-hub.c
new file mode 100644
index 0000000000..3a4aae3289
--- /dev/null
+++ b/chardev/char-hub.c
@@ -0,0 +1,301 @@
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
+ * Called with chr_write_lock held.
+ */
+static int hub_chr_write(Chardev *chr, const uint8_t *buf, int len)
+{
+    HubChardev *d = HUB_CHARDEV(chr);
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
+        if (r < 0) {
+            if (errno == EAGAIN) {
+                /* Set index and expect to be called soon on watch wake up */
+                d->be_eagain_ind = i;
+            }
+            return r;
+        }
+        d->be_written[i] += r;
+        ret = MIN(r, ret);
+    }
+    d->be_min_written += ret;
+
+
+    return ret;
+}
+
+static int hub_chr_can_read(void *opaque)
+{
+    HubCharBackend *backend = opaque;
+    CharBackend *fe = backend->hub->parent.be;
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
+    CharBackend *fe = backend->hub->parent.be;
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
+    CharBackend *fe = d->parent.be;
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
+    int i;
+
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
index 7705da5ad0..5a9e9762ad 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -943,7 +943,26 @@ QemuOptsList qemu_chardev_opts = {
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
@@ -1106,8 +1125,8 @@ ChardevReturn *qmp_chardev_change(const char *id, ChardevBackend *backend,
         return NULL;
     }
 
-    if (CHARDEV_IS_MUX(chr)) {
-        error_setg(errp, "Mux device hotswap not supported yet");
+    if (CHARDEV_IS_MUX(chr) || CHARDEV_IS_HUB(chr)) {
+        error_setg(errp, "For mux or hub device hotswap is not supported yet");
         return NULL;
     }
 
diff --git a/chardev/meson.build b/chardev/meson.build
index 70070a8279..56ee39ac0b 100644
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
-- 
2.47.0


