Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6597F0047
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 16:27:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4NCV-0003OS-RX; Sat, 18 Nov 2023 10:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r4NCA-0003Kp-Nb
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 10:25:20 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r4NC8-0007o1-Ly
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 10:25:18 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1ce5e65ba37so11038595ad.1
 for <qemu-devel@nongnu.org>; Sat, 18 Nov 2023 07:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1700320994; x=1700925794;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bo6ow+3THX/vVzTTSSoq8Ep2dpKhj9o6TyQslkfrchI=;
 b=LaGkdL77JmYb36/cpV3pCYPfFGjvDH79xllnmJhkfwChQg/yHF3WKIKZGT68X2AFho
 iVHpTb40kYY/VQMtyR9l2layeMv6k/mISgZUFhzGfBbkU56HSFQgDUSFljaGb6656DAa
 CZv4RG5M0/vtcwXclnCJRVCC27VafCjOBa8em9qrQCxcUfGt5irUk64T5IdIMH/23u/k
 b5TBt9by9/HkAXlIS9flqrE5cmvA5sLjhOyHrrj79wpRSkiPot27/OJI4nerDGF+c+M7
 +fuZexN8ei3sv+2dfun851VR5lOUROKzZy/YrlRxUSaI8eFyR+4ZhGCQ2EmiU9DjT7kK
 Cu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700320994; x=1700925794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bo6ow+3THX/vVzTTSSoq8Ep2dpKhj9o6TyQslkfrchI=;
 b=Ams6Z3yP3E3xscCRZyCxL9lQA3OgP25KBAweNQoUqk++Hf1l7FYl3Y94v1yYgb5YZD
 3t+ZVpvG9vuknf68qi+tVLEdmMa5Mz/ugLQYTMKYkIrIBWatR3rZQfwrrI9OOCi1AItj
 V/N/otYzqbw5ifg2ZvGpwc6k4YPZ405Q0UuqpKEqbt4P5WDwybE+wJG0pAhYpJb1px4W
 c0r6VL0WXw4ILBkKhzwysWJ07vCDWAK3v2r26IJjpS+iS1WWb9ZytNW3K9QzGCaIf6i5
 rLoK0M0qxveONp8cB1SUQb4whkYiWKwTHTu5Sm48MksOSfCpwtgt0TtPXO/ApPnKDEU9
 ILCg==
X-Gm-Message-State: AOJu0YxapjxVI21QcJzW+NaCd9BuxoRCW+7i6pHPJ4LQO4LDj9XMW1Pj
 BAjrpWYvGb/dXvOQY4sKPDT9Y97rOsD94BmtrT1sCw==
X-Google-Smtp-Source: AGHT+IGtaZaQaMM178M9zlrFUDCLg+6u4l+N5C53yZbRvuwVCzdPr5G84qYmF3tfL4NR+FOO/GgzAg==
X-Received: by 2002:a17:902:d50f:b0:1bc:edd:e891 with SMTP id
 b15-20020a170902d50f00b001bc0edde891mr12359403plg.1.1700320993846; 
 Sat, 18 Nov 2023 07:23:13 -0800 (PST)
Received: from localhost.localdomain ([125.71.94.124])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a170902ce8200b001bbb25dd3a7sm3120884plg.187.2023.11.18.07.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 07:23:13 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [v2 2/2] vhost-user-test: Add negotiated features check
Date: Sat, 18 Nov 2023 23:22:50 +0800
Message-Id: <b7bbe163f0c042d9e014116c5574ce29da705637.1700319559.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1700319559.git.yong.huang@smartx.com>
References: <cover.1700319559.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x633.google.com
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

When a vhost-user network device is restored from an unexpected
failure, the acked_features could be used as input for the
VHOST_USER_SET_FEATURES command because QEMU internally backups
the final features as acked_features after the guest acknowledges
features during virtio-net driver initialization.

The negotiated features check verifies whether the features in the
Vhost slave device and the acked_features in QEMU are identical.

Through the usage of the vhost-user protocol, the test case seeks to
verify that the vhost-user network device is correctly negotiating.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 tests/qtest/vhost-user-test.c | 100 ++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index d4e437265f..4f98ee2560 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -13,6 +13,7 @@
 #include "libqtest-single.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qlist.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/range.h"
@@ -169,6 +170,7 @@ typedef struct TestServer {
     int test_flags;
     int queues;
     struct vhost_user_ops *vu_ops;
+    uint64_t features;
 } TestServer;
 
 struct vhost_user_ops {
@@ -1020,6 +1022,100 @@ static void test_multiqueue(void *obj, void *arg, QGuestAllocator *alloc)
 }
 
 
+static QDict *query_virtio(QTestState *who)
+{
+    QDict *rsp;
+
+    rsp = qtest_qmp(who, "{ 'execute': 'x-query-virtio'}");
+    g_assert(!qdict_haskey(rsp, "error"));
+    g_assert(qdict_haskey(rsp, "return"));
+
+    return rsp;
+}
+
+static QDict *query_virtio_status(QTestState *who, const char *path)
+{
+    QDict *rsp;
+
+    rsp = qtest_qmp(who, "{ 'execute': 'x-query-virtio-status', "
+        "'arguments': { 'path': %s} }", path);
+
+    g_assert(!qdict_haskey(rsp, "error"));
+    g_assert(qdict_haskey(rsp, "return"));
+
+    return rsp;
+}
+
+static uint64_t get_acked_features(QTestState *who)
+{
+    QDict *rsp_return, *status, *vhost_info, *dev;
+    QList *dev_list;
+    const QListEntry *entry;
+    const char *name;
+    char *path;
+    uint64_t acked_features;
+
+    /* query the virtio devices */
+    rsp_return = query_virtio(who);
+    g_assert(rsp_return);
+
+    dev_list = qdict_get_qlist(rsp_return, "return");
+    g_assert(dev_list && !qlist_empty(dev_list));
+
+    /* fetch the first and the sole device */
+    entry = qlist_first(dev_list);
+    g_assert(entry);
+
+    dev = qobject_to(QDict, qlist_entry_obj(entry));
+    g_assert(dev);
+
+    name = qdict_get_try_str(dev, "name");
+    g_assert_cmpstr(name, ==, "virtio-net");
+
+    path = g_strdup(qdict_get_try_str(dev, "path"));
+    g_assert(path);
+    qobject_unref(rsp_return);
+    rsp_return = NULL;
+
+    /* fetch the status of the virtio-net device by QOM path */
+    rsp_return = query_virtio_status(who, path);
+    g_assert(rsp_return);
+
+    status = qdict_get_qdict(rsp_return, "return");
+    g_assert(status);
+
+    vhost_info = qdict_get_qdict(status, "vhost-dev");
+    g_assert(vhost_info);
+
+    acked_features = qdict_get_try_int(vhost_info, "acked-features-bits", 0);
+
+    qobject_unref(rsp_return);
+    g_free(path);
+
+    return acked_features;
+}
+
+static void acked_features_check(QTestState *qts, TestServer *s)
+{
+    uint64_t acked_features;
+
+    acked_features = get_acked_features(qts);
+    g_assert_cmpint(acked_features, ==, s->features);
+}
+
+static void test_acked_features(void *obj,
+                                     void *arg,
+                                     QGuestAllocator *alloc)
+{
+    TestServer *server = arg;
+
+    if (!wait_for_fds(server)) {
+        return;
+    }
+
+    acked_features_check(global_qtest, server);
+}
+
 static uint64_t vu_net_get_features(TestServer *s)
 {
     uint64_t features = 0x1ULL << VHOST_F_LOG_ALL |
@@ -1040,6 +1136,7 @@ static void vu_net_set_features(TestServer *s, CharBackend *chr,
         qemu_chr_fe_disconnect(chr);
         s->test_flags = TEST_FLAGS_BAD;
     }
+    s->features = msg->payload.u64;
 }
 
 static void vu_net_get_protocol_features(TestServer *s, CharBackend *chr,
@@ -1109,6 +1206,9 @@ static void register_vhost_user_test(void)
     qos_add_test("vhost-user/multiqueue",
                  "virtio-net",
                  test_multiqueue, &opts);
+    qos_add_test("vhost-user/read_acked_features",
+                 "virtio-net",
+                 test_acked_features, &opts);
 }
 libqos_init(register_vhost_user_test);
 
-- 
2.39.1


