Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E77AE4DEB
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Jun 2025 22:09:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTnRh-0005zS-2D; Mon, 23 Jun 2025 16:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTnRd-0005y1-KB
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTnRa-0003U6-Q1
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750709226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gyi67L/mCVdqWaAB2hOwjtOrHcsq7jHl0MC/l/bPYKQ=;
 b=PFrXBDxxTm3hJhcC8QYmNWH/MLnLUdSFIsr+Hvmz327exa5iqAX+ab046FdJnh+D+XFGjc
 RF433TLS+cFzNhOUwNRcAdMBrGga9+VQdRHbKFB9yQgixsMsFqO4S753VZF/QFzlyxpgez
 EKinRn4eVhlyk4mhMEyTkP4iDGvRJwc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-DdJULZaBOvuPrf0fu_uShg-1; Mon, 23 Jun 2025 16:07:04 -0400
X-MC-Unique: DdJULZaBOvuPrf0fu_uShg-1
X-Mimecast-MFC-AGG-ID: DdJULZaBOvuPrf0fu_uShg_1750709224
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7caee990721so1046139885a.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 13:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750709223; x=1751314023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gyi67L/mCVdqWaAB2hOwjtOrHcsq7jHl0MC/l/bPYKQ=;
 b=gv94kAljrfAMugCCnA1c7h82qvqa/xQihOk0mii0h2gK1PcRgtOoY6Ze3eF0OzgEgv
 H8tO7q3Nu2cRdF+Q7rsXDUf5jiGTFWB2wlESzG43LMUtLALeQ6losc4qDiy7zM8geukj
 jGkhxcXvPlUBgn2jTyoaDAjGYM9NMvN3dx2Whv77MTqZ4xungd7e2YST7YfceBHD56zP
 ZtrofmlfGhgx/5AeG+TXC2ZBbu358o09n9O0d2FWJwACE5FNSq3CfsN4mqOFI+SHkd+8
 xkLHpEu0my/M0ZQ3eLvacVuLIUAimTKArqmEGmkK62uPDxekSiUYoQJncS4sh6CB8sxf
 l/1A==
X-Gm-Message-State: AOJu0YyHGjYL7VDtfC79ob2t/H1tZVwE5Ux9scyLd8SXNm8Kx9vGPYOO
 RnY87HLXh3vZz3JMfdXFdGdpsPigr1GmWU9CJFPafW1lJKQ8b0YeNkCaxkHsSUFCtRRcQ2+60k1
 qBa9BFz9z1z1JqkzQ5D0aCQxTW8cO+HwhHJX/wLQLK7J8Lgpa7ni6gg2h4vQ45Vuk0+iUPEya6k
 5kfALgNMy48WiPk5xc+B01xuxjYUAdyiLjYPb4fQ==
X-Gm-Gg: ASbGncvpud6o6YX0af7BXT/76hYwwdkmB4QgNAtOaOhR/COBIdJxyD6e5J3CgK8ynvJ
 6atCy3uwlrsOrDLi3XPxmDkqPUEOaffvBuHHSGq3nmgJt/Dh3f7lqJasxml1zhsHcrJmBxtMf0J
 VACpnsT8Jij8HCkV2n54CpQCptqP7Z0ioRVyLQzV3rQNtE/xQ1Jb3oycQcLX8NCrWgQQS2nJd6J
 Am1opRpX1cJD+Ultbfpg+K6a4ADkU75jcjWM4haB39pMCamI/1GqMyGZ40gzqDVc+gwGHeJJz8y
 F4tmEqph98g=
X-Received: by 2002:a05:620a:190d:b0:7c5:3d60:7f91 with SMTP id
 af79cd13be357-7d3f98dce2cmr1873790985a.15.1750709223257; 
 Mon, 23 Jun 2025 13:07:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcPWRko38gPId8sI1wzYPZRCKHVhK99EGO6/kWY6aVxIuit0K6kkAbHE/7wtvKS1R634p+Qg==
X-Received: by 2002:a05:620a:190d:b0:7c5:3d60:7f91 with SMTP id
 af79cd13be357-7d3f98dce2cmr1873785885a.15.1750709222605; 
 Mon, 23 Jun 2025 13:07:02 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd095a775bsm48427976d6.112.2025.06.23.13.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 13:07:01 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 02/11] tests/qtest: Remove migration-helpers.c
Date: Mon, 23 Jun 2025 16:06:47 -0400
Message-ID: <20250623200656.1882674-3-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623200656.1882674-1-peterx@redhat.com>
References: <20250623200656.1882674-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

Commit 407bc4bf90 ("qapi: Move include/qapi/qmp/ to include/qobject/")
brought the migration-helpers.c back by mistake. This file has been
replaced with migration/migration-qmp.c and
migration/migration-util.c.

Fixes: 407bc4bf90 ("qapi: Move include/qapi/qmp/ to include/qobject/")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Message-id: 20200310152141.13959-1-peter.maydell@linaro.org
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/r/20250523123023.19284-1-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-helpers.c | 530 --------------------------------
 1 file changed, 530 deletions(-)
 delete mode 100644 tests/qtest/migration-helpers.c

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
deleted file mode 100644
index b08b49bd43..0000000000
--- a/tests/qtest/migration-helpers.c
+++ /dev/null
@@ -1,530 +0,0 @@
-/*
- * QTest migration helpers
- *
- * Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
- *   based on the vhost-user-test.c that is:
- *      Copyright (c) 2014 Virtual Open Systems Sarl.
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#include "qemu/osdep.h"
-#include "qemu/ctype.h"
-#include "qobject/qjson.h"
-#include "qapi/qapi-visit-sockets.h"
-#include "qapi/qobject-input-visitor.h"
-#include "qapi/error.h"
-#include "qobject/qlist.h"
-#include "qemu/cutils.h"
-#include "qemu/memalign.h"
-
-#include "migration-helpers.h"
-
-/*
- * Number of seconds we wait when looking for migration
- * status changes, to avoid test suite hanging forever
- * when things go wrong. Needs to be higher enough to
- * avoid false positives on loaded hosts.
- */
-#define MIGRATION_STATUS_WAIT_TIMEOUT 120
-
-static char *SocketAddress_to_str(SocketAddress *addr)
-{
-    switch (addr->type) {
-    case SOCKET_ADDRESS_TYPE_INET:
-        return g_strdup_printf("tcp:%s:%s",
-                               addr->u.inet.host,
-                               addr->u.inet.port);
-    case SOCKET_ADDRESS_TYPE_UNIX:
-        return g_strdup_printf("unix:%s",
-                               addr->u.q_unix.path);
-    case SOCKET_ADDRESS_TYPE_FD:
-        return g_strdup_printf("fd:%s", addr->u.fd.str);
-    case SOCKET_ADDRESS_TYPE_VSOCK:
-        return g_strdup_printf("vsock:%s:%s",
-                               addr->u.vsock.cid,
-                               addr->u.vsock.port);
-    default:
-        return g_strdup("unknown address type");
-    }
-}
-
-static QDict *SocketAddress_to_qdict(SocketAddress *addr)
-{
-    QDict *dict = qdict_new();
-
-    switch (addr->type) {
-    case SOCKET_ADDRESS_TYPE_INET:
-        qdict_put_str(dict, "type", "inet");
-        qdict_put_str(dict, "host", addr->u.inet.host);
-        qdict_put_str(dict, "port", addr->u.inet.port);
-        break;
-    case SOCKET_ADDRESS_TYPE_UNIX:
-        qdict_put_str(dict, "type", "unix");
-        qdict_put_str(dict, "path", addr->u.q_unix.path);
-        break;
-    case SOCKET_ADDRESS_TYPE_FD:
-        qdict_put_str(dict, "type", "fd");
-        qdict_put_str(dict, "str", addr->u.fd.str);
-        break;
-    case SOCKET_ADDRESS_TYPE_VSOCK:
-        qdict_put_str(dict, "type", "vsock");
-        qdict_put_str(dict, "cid", addr->u.vsock.cid);
-        qdict_put_str(dict, "port", addr->u.vsock.port);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    return dict;
-}
-
-static SocketAddressList *migrate_get_socket_address(QTestState *who)
-{
-    QDict *rsp;
-    SocketAddressList *addrs;
-    Visitor *iv = NULL;
-    QObject *object;
-
-    rsp = migrate_query(who);
-    object = qdict_get(rsp, "socket-address");
-
-    iv = qobject_input_visitor_new(object);
-    visit_type_SocketAddressList(iv, NULL, &addrs, &error_abort);
-    visit_free(iv);
-
-    qobject_unref(rsp);
-    return addrs;
-}
-
-static char *
-migrate_get_connect_uri(QTestState *who)
-{
-    SocketAddressList *addrs;
-    char *connect_uri;
-
-    addrs = migrate_get_socket_address(who);
-    connect_uri = SocketAddress_to_str(addrs->value);
-
-    qapi_free_SocketAddressList(addrs);
-    return connect_uri;
-}
-
-static QDict *
-migrate_get_connect_qdict(QTestState *who)
-{
-    SocketAddressList *addrs;
-    QDict *connect_qdict;
-
-    addrs = migrate_get_socket_address(who);
-    connect_qdict = SocketAddress_to_qdict(addrs->value);
-
-    qapi_free_SocketAddressList(addrs);
-    return connect_qdict;
-}
-
-static void migrate_set_ports(QTestState *to, QList *channel_list)
-{
-    QDict *addr;
-    QListEntry *entry;
-    const char *addr_port = NULL;
-
-    addr = migrate_get_connect_qdict(to);
-
-    QLIST_FOREACH_ENTRY(channel_list, entry) {
-        QDict *channel = qobject_to(QDict, qlist_entry_obj(entry));
-        QDict *addrdict = qdict_get_qdict(channel, "addr");
-
-        if (qdict_haskey(addrdict, "port") &&
-            qdict_haskey(addr, "port") &&
-            (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
-                addr_port = qdict_get_str(addr, "port");
-                qdict_put_str(addrdict, "port", addr_port);
-        }
-    }
-
-    qobject_unref(addr);
-}
-
-bool migrate_watch_for_events(QTestState *who, const char *name,
-                              QDict *event, void *opaque)
-{
-    QTestMigrationState *state = opaque;
-
-    if (g_str_equal(name, "STOP")) {
-        state->stop_seen = true;
-        return true;
-    } else if (g_str_equal(name, "SUSPEND")) {
-        state->suspend_seen = true;
-        return true;
-    } else if (g_str_equal(name, "RESUME")) {
-        state->resume_seen = true;
-        return true;
-    }
-
-    return false;
-}
-
-void migrate_qmp_fail(QTestState *who, const char *uri,
-                      const char *channels, const char *fmt, ...)
-{
-    va_list ap;
-    QDict *args, *err;
-
-    va_start(ap, fmt);
-    args = qdict_from_vjsonf_nofail(fmt, ap);
-    va_end(ap);
-
-    g_assert(!qdict_haskey(args, "uri"));
-    if (uri) {
-        qdict_put_str(args, "uri", uri);
-    }
-
-    g_assert(!qdict_haskey(args, "channels"));
-    if (channels) {
-        QObject *channels_obj = qobject_from_json(channels, &error_abort);
-        qdict_put_obj(args, "channels", channels_obj);
-    }
-
-    err = qtest_qmp_assert_failure_ref(
-        who, "{ 'execute': 'migrate', 'arguments': %p}", args);
-
-    g_assert(qdict_haskey(err, "desc"));
-
-    qobject_unref(err);
-}
-
-/*
- * Send QMP command "migrate".
- * Arguments are built from @fmt... (formatted like
- * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
- */
-void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
-                 const char *channels, const char *fmt, ...)
-{
-    va_list ap;
-    QDict *args;
-    g_autofree char *connect_uri = NULL;
-
-    va_start(ap, fmt);
-    args = qdict_from_vjsonf_nofail(fmt, ap);
-    va_end(ap);
-
-    g_assert(!qdict_haskey(args, "uri"));
-    if (uri) {
-        qdict_put_str(args, "uri", uri);
-    } else if (!channels) {
-        connect_uri = migrate_get_connect_uri(to);
-        qdict_put_str(args, "uri", connect_uri);
-    }
-
-    g_assert(!qdict_haskey(args, "channels"));
-    if (channels) {
-        QObject *channels_obj = qobject_from_json(channels, &error_abort);
-        QList *channel_list = qobject_to(QList, channels_obj);
-        migrate_set_ports(to, channel_list);
-        qdict_put_obj(args, "channels", channels_obj);
-    }
-
-    qtest_qmp_assert_success(who,
-                             "{ 'execute': 'migrate', 'arguments': %p}", args);
-}
-
-void migrate_set_capability(QTestState *who, const char *capability,
-                            bool value)
-{
-    qtest_qmp_assert_success(who,
-                             "{ 'execute': 'migrate-set-capabilities',"
-                             "'arguments': { "
-                             "'capabilities': [ { "
-                             "'capability': %s, 'state': %i } ] } }",
-                             capability, value);
-}
-
-void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
-{
-    va_list ap;
-    QDict *args, *rsp;
-
-    va_start(ap, fmt);
-    args = qdict_from_vjsonf_nofail(fmt, ap);
-    va_end(ap);
-
-    g_assert(!qdict_haskey(args, "uri"));
-    qdict_put_str(args, "uri", uri);
-
-    /* This function relies on the event to work, make sure it's enabled */
-    migrate_set_capability(to, "events", true);
-
-    rsp = qtest_qmp(to, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
-                    args);
-
-    if (!qdict_haskey(rsp, "return")) {
-        g_autoptr(GString) s = qobject_to_json_pretty(QOBJECT(rsp), true);
-        g_test_message("%s", s->str);
-    }
-
-    g_assert(qdict_haskey(rsp, "return"));
-    qobject_unref(rsp);
-
-    migration_event_wait(to, "setup");
-}
-
-/*
- * Note: caller is responsible to free the returned object via
- * qobject_unref() after use
- */
-QDict *migrate_query(QTestState *who)
-{
-    return qtest_qmp_assert_success_ref(who, "{ 'execute': 'query-migrate' }");
-}
-
-QDict *migrate_query_not_failed(QTestState *who)
-{
-    const char *status;
-    QDict *rsp = migrate_query(who);
-    status = qdict_get_str(rsp, "status");
-    if (g_str_equal(status, "failed")) {
-        g_printerr("query-migrate shows failed migration: %s\n",
-                   qdict_get_str(rsp, "error-desc"));
-    }
-    g_assert(!g_str_equal(status, "failed"));
-    return rsp;
-}
-
-/*
- * Note: caller is responsible to free the returned object via
- * g_free() after use
- */
-static gchar *migrate_query_status(QTestState *who)
-{
-    QDict *rsp_return = migrate_query(who);
-    gchar *status = g_strdup(qdict_get_str(rsp_return, "status"));
-
-    g_assert(status);
-    qobject_unref(rsp_return);
-
-    return status;
-}
-
-static bool check_migration_status(QTestState *who, const char *goal,
-                                   const char **ungoals)
-{
-    bool ready;
-    char *current_status;
-    const char **ungoal;
-
-    current_status = migrate_query_status(who);
-    ready = strcmp(current_status, goal) == 0;
-    if (!ungoals) {
-        g_assert_cmpstr(current_status, !=, "failed");
-        /*
-         * If looking for a state other than completed,
-         * completion of migration would cause the test to
-         * hang.
-         */
-        if (strcmp(goal, "completed") != 0) {
-            g_assert_cmpstr(current_status, !=, "completed");
-        }
-    } else {
-        for (ungoal = ungoals; *ungoal; ungoal++) {
-            g_assert_cmpstr(current_status, !=,  *ungoal);
-        }
-    }
-    g_free(current_status);
-    return ready;
-}
-
-void wait_for_migration_status(QTestState *who,
-                               const char *goal, const char **ungoals)
-{
-    g_test_timer_start();
-    while (!check_migration_status(who, goal, ungoals)) {
-        usleep(1000);
-
-        g_assert(g_test_timer_elapsed() < MIGRATION_STATUS_WAIT_TIMEOUT);
-    }
-}
-
-void wait_for_migration_complete(QTestState *who)
-{
-    wait_for_migration_status(who, "completed", NULL);
-}
-
-void wait_for_migration_fail(QTestState *from, bool allow_active)
-{
-    g_test_timer_start();
-    QDict *rsp_return;
-    char *status;
-    bool failed;
-
-    do {
-        status = migrate_query_status(from);
-        bool result = !strcmp(status, "setup") || !strcmp(status, "failed") ||
-            (allow_active && !strcmp(status, "active"));
-        if (!result) {
-            fprintf(stderr, "%s: unexpected status status=%s allow_active=%d\n",
-                    __func__, status, allow_active);
-        }
-        g_assert(result);
-        failed = !strcmp(status, "failed");
-        g_free(status);
-
-        g_assert(g_test_timer_elapsed() < MIGRATION_STATUS_WAIT_TIMEOUT);
-    } while (!failed);
-
-    /* Is the machine currently running? */
-    rsp_return = qtest_qmp_assert_success_ref(from,
-                                              "{ 'execute': 'query-status' }");
-    g_assert(qdict_haskey(rsp_return, "running"));
-    g_assert(qdict_get_bool(rsp_return, "running"));
-    qobject_unref(rsp_return);
-}
-
-char *find_common_machine_version(const char *mtype, const char *var1,
-                                  const char *var2)
-{
-    g_autofree char *type1 = qtest_resolve_machine_alias(var1, mtype);
-    g_autofree char *type2 = qtest_resolve_machine_alias(var2, mtype);
-
-    g_assert(type1 && type2);
-
-    if (g_str_equal(type1, type2)) {
-        /* either can be used */
-        return g_strdup(type1);
-    }
-
-    if (qtest_has_machine_with_env(var2, type1)) {
-        return g_strdup(type1);
-    }
-
-    if (qtest_has_machine_with_env(var1, type2)) {
-        return g_strdup(type2);
-    }
-
-    g_test_message("No common machine version for machine type '%s' between "
-                   "binaries %s and %s", mtype, getenv(var1), getenv(var2));
-    g_assert_not_reached();
-}
-
-char *resolve_machine_version(const char *alias, const char *var1,
-                              const char *var2)
-{
-    const char *mname = g_getenv("QTEST_QEMU_MACHINE_TYPE");
-    g_autofree char *machine_name = NULL;
-
-    if (mname) {
-        const char *dash = strrchr(mname, '-');
-        const char *dot = strrchr(mname, '.');
-
-        machine_name = g_strdup(mname);
-
-        if (dash && dot) {
-            assert(qtest_has_machine(machine_name));
-            return g_steal_pointer(&machine_name);
-        }
-        /* else: probably an alias, let it be resolved below */
-    } else {
-        /* use the hardcoded alias */
-        machine_name = g_strdup(alias);
-    }
-
-    return find_common_machine_version(machine_name, var1, var2);
-}
-
-typedef struct {
-    char *name;
-    void (*func)(void);
-} MigrationTest;
-
-static void migration_test_destroy(gpointer data)
-{
-    MigrationTest *test = (MigrationTest *)data;
-
-    g_free(test->name);
-    g_free(test);
-}
-
-static void migration_test_wrapper(const void *data)
-{
-    MigrationTest *test = (MigrationTest *)data;
-
-    g_test_message("Running /%s%s", qtest_get_arch(), test->name);
-    test->func();
-}
-
-void migration_test_add(const char *path, void (*fn)(void))
-{
-    MigrationTest *test = g_new0(MigrationTest, 1);
-
-    test->func = fn;
-    test->name = g_strdup(path);
-
-    qtest_add_data_func_full(path, test, migration_test_wrapper,
-                             migration_test_destroy);
-}
-
-#ifdef O_DIRECT
-/*
- * Probe for O_DIRECT support on the filesystem. Since this is used
- * for tests, be conservative, if anything fails, assume it's
- * unsupported.
- */
-bool probe_o_direct_support(const char *tmpfs)
-{
-    g_autofree char *filename = g_strdup_printf("%s/probe-o-direct", tmpfs);
-    int fd, flags = O_CREAT | O_RDWR | O_TRUNC | O_DIRECT;
-    void *buf;
-    ssize_t ret, len;
-    uint64_t offset;
-
-    fd = open(filename, flags, 0660);
-    if (fd < 0) {
-        unlink(filename);
-        return false;
-    }
-
-    /*
-     * Using 1MB alignment as conservative choice to satisfy any
-     * plausible architecture default page size, and/or filesystem
-     * alignment restrictions.
-     */
-    len = 0x100000;
-    offset = 0x100000;
-
-    buf = qemu_try_memalign(len, len);
-    g_assert(buf);
-
-    ret = pwrite(fd, buf, len, offset);
-    unlink(filename);
-    g_free(buf);
-
-    if (ret < 0) {
-        return false;
-    }
-
-    return true;
-}
-#endif
-
-/*
- * Wait for a "MIGRATION" event.  This is what Libvirt uses to track
- * migration status changes.
- */
-void migration_event_wait(QTestState *s, const char *target)
-{
-    QDict *response, *data;
-    const char *status;
-    bool found;
-
-    do {
-        response = qtest_qmp_eventwait_ref(s, "MIGRATION");
-        data = qdict_get_qdict(response, "data");
-        g_assert(data);
-        status = qdict_get_str(data, "status");
-        found = (strcmp(status, target) == 0);
-        qobject_unref(response);
-    } while (!found);
-}
-- 
2.49.0


