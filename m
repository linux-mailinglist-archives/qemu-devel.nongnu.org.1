Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA80F70C5CE
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 21:12:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Aqd-0003nt-BL; Mon, 22 May 2023 15:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1Aq4-0003al-HR
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:05:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1Apy-0003bL-Si
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684782294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RiCtQ0xCAy0vQkDtjFwaAtOVgPYu0x7yElW2ooP6Jnc=;
 b=BRWwBtCTGG34viiVuzhP3TFnhA0BF2CeBGn6x82HI5yTG29Bn9uOLDwoqb20Du/d76VE3E
 r3MI2X1Cw/w69L2jCgjwnfzUUNYl/Iqdz+pnsyfbFv9PZ0nRcXDmS1eTSkG/yeibLjv6wD
 CEoUf73DIvrpSZf7doWKEO1zWoOPyuA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-ZBjE2DayMra_skzzUaZobw-1; Mon, 22 May 2023 15:04:48 -0400
X-MC-Unique: ZBjE2DayMra_skzzUaZobw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4453A29A9D59;
 Mon, 22 May 2023 19:04:48 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5282F482060;
 Mon, 22 May 2023 19:04:47 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com, qemu-block@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 integration@gluster.org (open list:GLUSTER)
Subject: [PATCH v3 07/19] cutils: Adjust signature of parse_uint[_full]
Date: Mon, 22 May 2023 14:04:29 -0500
Message-Id: <20230522190441.64278-8-eblake@redhat.com>
In-Reply-To: <20230522190441.64278-1-eblake@redhat.com>
References: <20230522190441.64278-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

It's already confusing that we have two very similar functions for
wrapping the parse of a 64-bit unsigned value, differing mainly on
whether they permit leading '-'.  Adjust the signature of parse_uint()
and parse_uint_full() to be like all of qemu_strto*(): put the result
parameter last, use the same types (uint64_t and unsigned long long
have the same width, but are not always the same type), and mark
endptr const (this latter change only affects the rare caller of
parse_uint).  Adjust all callers in the tree.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---

v3: rebase test-cutils to earlier changes, tweak commit message, drop
dead initializer [Hanna], R-b added
---
 include/qemu/cutils.h         |   5 +-
 audio/audio_legacy.c          |   4 +-
 block/gluster.c               |   4 +-
 block/nfs.c                   |   4 +-
 blockdev.c                    |   4 +-
 contrib/ivshmem-server/main.c |   4 +-
 qapi/opts-visitor.c           |  10 +--
 tests/unit/test-cutils.c      | 119 +++++++++++++++-------------------
 ui/vnc.c                      |   4 +-
 util/cutils.c                 |  13 ++--
 util/guest-random.c           |   4 +-
 util/qemu-sockets.c           |  10 +--
 12 files changed, 85 insertions(+), 100 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 92c436d8c70..92c927a6a35 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -163,9 +163,8 @@ int qemu_strtou64(const char *nptr, const char **endptr, int base,
 int qemu_strtod(const char *nptr, const char **endptr, double *result);
 int qemu_strtod_finite(const char *nptr, const char **endptr, double *result);

-int parse_uint(const char *s, unsigned long long *value, char **endptr,
-               int base);
-int parse_uint_full(const char *s, unsigned long long *value, int base);
+int parse_uint(const char *s, const char **endptr, int base, uint64_t *value);
+int parse_uint_full(const char *s, int base, uint64_t *value);

 int qemu_strtosz(const char *nptr, const char **end, uint64_t *result);
 int qemu_strtosz_MiB(const char *nptr, const char **end, uint64_t *result);
diff --git a/audio/audio_legacy.c b/audio/audio_legacy.c
index b848001ff70..dc72ba55e9a 100644
--- a/audio/audio_legacy.c
+++ b/audio/audio_legacy.c
@@ -35,8 +35,8 @@

 static uint32_t toui32(const char *str)
 {
-    unsigned long long ret;
-    if (parse_uint_full(str, &ret, 10) || ret > UINT32_MAX) {
+    uint64_t ret;
+    if (parse_uint_full(str, 10, &ret) || ret > UINT32_MAX) {
         dolog("Invalid integer value `%s'\n", str);
         exit(1);
     }
diff --git a/block/gluster.c b/block/gluster.c
index 185a83e5e53..ad5fadbe793 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -424,7 +424,7 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
     int ret;
     int old_errno;
     SocketAddressList *server;
-    unsigned long long port;
+    uint64_t port;

     glfs = glfs_find_preopened(gconf->volume);
     if (glfs) {
@@ -445,7 +445,7 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
                                    server->value->u.q_unix.path, 0);
             break;
         case SOCKET_ADDRESS_TYPE_INET:
-            if (parse_uint_full(server->value->u.inet.port, &port, 10) < 0 ||
+            if (parse_uint_full(server->value->u.inet.port, 10, &port) < 0 ||
                 port > 65535) {
                 error_setg(errp, "'%s' is not a valid port number",
                            server->value->u.inet.port);
diff --git a/block/nfs.c b/block/nfs.c
index 006045d71a6..fabea0386a3 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -114,13 +114,13 @@ static int nfs_parse_uri(const char *filename, QDict *options, Error **errp)
     qdict_put_str(options, "path", uri->path);

     for (i = 0; i < qp->n; i++) {
-        unsigned long long val;
+        uint64_t val;
         if (!qp->p[i].value) {
             error_setg(errp, "Value for NFS parameter expected: %s",
                        qp->p[i].name);
             goto out;
         }
-        if (parse_uint_full(qp->p[i].value, &val, 0)) {
+        if (parse_uint_full(qp->p[i].value, 0, &val)) {
             error_setg(errp, "Illegal value for NFS parameter: %s",
                        qp->p[i].name);
             goto out;
diff --git a/blockdev.c b/blockdev.c
index 5d56b79df4a..fca26186c85 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -341,10 +341,10 @@ static bool parse_stats_intervals(BlockAcctStats *stats, QList *intervals,
         switch (qobject_type(entry->value)) {

         case QTYPE_QSTRING: {
-            unsigned long long length;
+            uint64_t length;
             const char *str = qstring_get_str(qobject_to(QString,
                                                          entry->value));
-            if (parse_uint_full(str, &length, 10) == 0 &&
+            if (parse_uint_full(str, 10, &length) == 0 &&
                 length > 0 && length <= UINT_MAX) {
                 block_acct_add_interval(stats, (unsigned) length);
             } else {
diff --git a/contrib/ivshmem-server/main.c b/contrib/ivshmem-server/main.c
index 224dbeb547e..5901f17707e 100644
--- a/contrib/ivshmem-server/main.c
+++ b/contrib/ivshmem-server/main.c
@@ -69,7 +69,7 @@ static void
 ivshmem_server_parse_args(IvshmemServerArgs *args, int argc, char *argv[])
 {
     int c;
-    unsigned long long v;
+    uint64_t v;
     Error *err = NULL;

     while ((c = getopt(argc, argv, "hvFp:S:m:M:l:n:")) != -1) {
@@ -112,7 +112,7 @@ ivshmem_server_parse_args(IvshmemServerArgs *args, int argc, char *argv[])
             break;

         case 'n': /* number of vectors */
-            if (parse_uint_full(optarg, &v, 0) < 0) {
+            if (parse_uint_full(optarg, 0, &v) < 0) {
                 fprintf(stderr, "cannot parse n_vectors\n");
                 ivshmem_server_help(argv[0]);
                 exit(1);
diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 587f31baf6b..8812d23677a 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -454,8 +454,8 @@ opts_type_uint64(Visitor *v, const char *name, uint64_t *obj, Error **errp)
     OptsVisitor *ov = to_ov(v);
     const QemuOpt *opt;
     const char *str;
-    unsigned long long val;
-    char *endptr;
+    uint64_t val;
+    const char *endptr;

     if (ov->list_mode == LM_UNSIGNED_INTERVAL) {
         *obj = ov->range_next.u;
@@ -471,17 +471,17 @@ opts_type_uint64(Visitor *v, const char *name, uint64_t *obj, Error **errp)
     /* we've gotten past lookup_scalar() */
     assert(ov->list_mode == LM_NONE || ov->list_mode == LM_IN_PROGRESS);

-    if (parse_uint(str, &val, &endptr, 0) == 0 && val <= UINT64_MAX) {
+    if (parse_uint(str, &endptr, 0, &val) == 0 && val <= UINT64_MAX) {
         if (*endptr == '\0') {
             *obj = val;
             processed(ov, name);
             return true;
         }
         if (*endptr == '-' && ov->list_mode == LM_IN_PROGRESS) {
-            unsigned long long val2;
+            uint64_t val2;

             str = endptr + 1;
-            if (parse_uint_full(str, &val2, 0) == 0 &&
+            if (parse_uint_full(str, 0, &val2) == 0 &&
                 val2 <= UINT64_MAX && val <= val2 &&
                 val2 - val < OPTS_VISITOR_RANGE_MAX) {
                 ov->range_next.u = val;
diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
index 249fc1fa7e7..70469b583d3 100644
--- a/tests/unit/test-cutils.c
+++ b/tests/unit/test-cutils.c
@@ -31,12 +31,11 @@

 static void test_parse_uint_null(void)
 {
-    unsigned long long i = 999;
-    char f = 'X';
-    char *endptr = &f;
+    uint64_t i = 999;
+    const char *endptr = "somewhere";
     int r;

-    r = parse_uint(NULL, &i, &endptr, 0);
+    r = parse_uint(NULL, &endptr, 0, &i);

     g_assert_cmpint(r, ==, -EINVAL);
     g_assert_cmpuint(i, ==, 0);
@@ -45,13 +44,12 @@ static void test_parse_uint_null(void)

 static void test_parse_uint_empty(void)
 {
-    unsigned long long i = 999;
-    char f = 'X';
-    char *endptr = &f;
+    uint64_t i = 999;
+    const char *endptr = "somewhere";
     const char *str = "";
     int r;

-    r = parse_uint(str, &i, &endptr, 0);
+    r = parse_uint(str, &endptr, 0, &i);

     g_assert_cmpint(r, ==, -EINVAL);
     g_assert_cmpuint(i, ==, 0);
@@ -60,13 +58,12 @@ static void test_parse_uint_empty(void)

 static void test_parse_uint_whitespace(void)
 {
-    unsigned long long i = 999;
-    char f = 'X';
-    char *endptr = &f;
+    uint64_t i = 999;
+    const char *endptr = "somewhere";
     const char *str = "   \t   ";
     int r;

-    r = parse_uint(str, &i, &endptr, 0);
+    r = parse_uint(str, &endptr, 0, &i);

     g_assert_cmpint(r, ==, -EINVAL);
     g_assert_cmpuint(i, ==, 0);
@@ -76,13 +73,12 @@ static void test_parse_uint_whitespace(void)

 static void test_parse_uint_invalid(void)
 {
-    unsigned long long i = 999;
-    char f = 'X';
-    char *endptr = &f;
+    uint64_t i = 999;
+    const char *endptr = "somewhere";
     const char *str = " \t xxx";
     int r;

-    r = parse_uint(str, &i, &endptr, 0);
+    r = parse_uint(str, &endptr, 0, &i);

     g_assert_cmpint(r, ==, -EINVAL);
     g_assert_cmpuint(i, ==, 0);
@@ -92,13 +88,12 @@ static void test_parse_uint_invalid(void)

 static void test_parse_uint_trailing(void)
 {
-    unsigned long long i = 999;
-    char f = 'X';
-    char *endptr = &f;
+    uint64_t i = 999;
+    const char *endptr = "somewhere";
     const char *str = "123xxx";
     int r;

-    r = parse_uint(str, &i, &endptr, 0);
+    r = parse_uint(str, &endptr, 0, &i);

     g_assert_cmpint(r, ==, 0);
     g_assert_cmpuint(i, ==, 123);
@@ -107,13 +102,12 @@ static void test_parse_uint_trailing(void)

 static void test_parse_uint_correct(void)
 {
-    unsigned long long i = 999;
-    char f = 'X';
-    char *endptr = &f;
+    uint64_t i = 999;
+    const char *endptr = "somewhere";
     const char *str = "123";
     int r;

-    r = parse_uint(str, &i, &endptr, 0);
+    r = parse_uint(str, &endptr, 0, &i);

     g_assert_cmpint(r, ==, 0);
     g_assert_cmpuint(i, ==, 123);
@@ -122,13 +116,12 @@ static void test_parse_uint_correct(void)

 static void test_parse_uint_octal(void)
 {
-    unsigned long long i = 999;
-    char f = 'X';
-    char *endptr = &f;
+    uint64_t i = 999;
+    const char *endptr = "somewhere";
     const char *str = "0123";
     int r;

-    r = parse_uint(str, &i, &endptr, 0);
+    r = parse_uint(str, &endptr, 0, &i);

     g_assert_cmpint(r, ==, 0);
     g_assert_cmpuint(i, ==, 0123);
@@ -137,13 +130,12 @@ static void test_parse_uint_octal(void)

 static void test_parse_uint_decimal(void)
 {
-    unsigned long long i = 999;
-    char f = 'X';
-    char *endptr = &f;
+    uint64_t i = 999;
+    const char *endptr = "somewhere";
     const char *str = "0123";
     int r;

-    r = parse_uint(str, &i, &endptr, 10);
+    r = parse_uint(str, &endptr, 10, &i);

     g_assert_cmpint(r, ==, 0);
     g_assert_cmpuint(i, ==, 123);
@@ -152,13 +144,12 @@ static void test_parse_uint_decimal(void)

 static void test_parse_uint_llong_max(void)
 {
-    unsigned long long i = 999;
-    char f = 'X';
-    char *endptr = &f;
+    uint64_t i = 999;
+    const char *endptr = "somewhere";
     char *str = g_strdup_printf("%llu", (unsigned long long)LLONG_MAX + 1);
     int r;

-    r = parse_uint(str, &i, &endptr, 0);
+    r = parse_uint(str, &endptr, 0, &i);

     g_assert_cmpint(r, ==, 0);
     g_assert_cmpuint(i, ==, (unsigned long long)LLONG_MAX + 1);
@@ -169,13 +160,12 @@ static void test_parse_uint_llong_max(void)

 static void test_parse_uint_max(void)
 {
-    unsigned long long i = 999;
-    char f = 'X';
-    char *endptr = &f;
+    uint64_t i = 999;
+    const char *endptr = "somewhere";
     char *str = g_strdup_printf("%llu", ULLONG_MAX);
     int r;

-    r = parse_uint(str, &i, &endptr, 0);
+    r = parse_uint(str, &endptr, 0, &i);

     g_assert_cmpint(r, ==, 0);
     g_assert_cmpuint(i, ==, ULLONG_MAX);
@@ -186,32 +176,31 @@ static void test_parse_uint_max(void)

 static void test_parse_uint_overflow(void)
 {
-    unsigned long long i;
-    char f = 'X';
-    char *endptr;
+    uint64_t i;
+    const char *endptr;
     const char *str;
     int r;

     i = 999;
-    endptr = &f;
+    endptr = "somewhere";
     str = "99999999999999999999999999999999999999";
-    r = parse_uint(str, &i, &endptr, 0);
+    r = parse_uint(str, &endptr, 0, &i);
     g_assert_cmpint(r, ==, -ERANGE);
     g_assert_cmpuint(i, ==, ULLONG_MAX);
     g_assert_true(endptr == str + strlen(str));

     i = 999;
-    endptr = &f;
+    endptr = "somewhere";
     str = "0x10000000000000000"; /* 65 bits, 64-bit sign bit clear */
-    r = parse_uint(str, &i, &endptr, 0);
+    r = parse_uint(str, &endptr, 0, &i);
     g_assert_cmpint(r, ==, -ERANGE);
     g_assert_cmpuint(i, ==, ULLONG_MAX);
     g_assert_true(endptr == str + strlen(str));

     i = 999;
-    endptr = &f;
+    endptr = "somewhere";
     str = "0x18000000080000000"; /* 65 bits, 64-bit sign bit set */
-    r = parse_uint(str, &i, &endptr, 0);
+    r = parse_uint(str, &endptr, 0, &i);
     g_assert_cmpint(r, ==, -ERANGE);
     g_assert_cmpuint(i, ==, ULLONG_MAX);
     g_assert_true(endptr == str + strlen(str));
@@ -219,24 +208,23 @@ static void test_parse_uint_overflow(void)

 static void test_parse_uint_negative(void)
 {
-    unsigned long long i;
-    char f = 'X';
-    char *endptr;
+    uint64_t i;
+    const char *endptr;
     const char *str;
     int r;

     i = 999;
-    endptr = &f;
+    endptr = "somewhere";
     str = " \t -321";
-    r = parse_uint(str, &i, &endptr, 0);
+    r = parse_uint(str, &endptr, 0, &i);
     g_assert_cmpint(r, ==, -ERANGE);
     g_assert_cmpuint(i, ==, 0);
     g_assert_true(endptr == str + strlen(str));

     i = 999;
-    endptr = &f;
+    endptr = "somewhere";
     str = "-0xffffffff00000001";
-    r = parse_uint(str, &i, &endptr, 0);
+    r = parse_uint(str, &endptr, 0, &i);
     g_assert_cmpint(r, ==, -ERANGE);
     g_assert_cmpuint(i, ==, 0);
     g_assert_true(endptr == str + strlen(str));
@@ -244,13 +232,12 @@ static void test_parse_uint_negative(void)

 static void test_parse_uint_negzero(void)
 {
-    unsigned long long i = 999;
-    char f = 'X';
-    char *endptr = &f;
+    uint64_t i = 999;
+    const char *endptr = "somewhere";
     const char *str = " -0";
     int r;

-    r = parse_uint(str, &i, &endptr, 0);
+    r = parse_uint(str, &endptr, 0, &i);

     g_assert_cmpint(r, ==, -ERANGE);
     g_assert_cmpuint(i, ==, 0);
@@ -259,11 +246,11 @@ static void test_parse_uint_negzero(void)

 static void test_parse_uint_full_trailing(void)
 {
-    unsigned long long i = 999;
+    uint64_t i = 999;
     const char *str = "123xxx";
     int r;

-    r = parse_uint_full(str, &i, 0);
+    r = parse_uint_full(str, 0, &i);

     g_assert_cmpint(r, ==, -EINVAL);
     g_assert_cmpuint(i, ==, 0);
@@ -271,11 +258,11 @@ static void test_parse_uint_full_trailing(void)

 static void test_parse_uint_full_correct(void)
 {
-    unsigned long long i = 999;
+    uint64_t i = 999;
     const char *str = "123";
     int r;

-    r = parse_uint_full(str, &i, 0);
+    r = parse_uint_full(str, 0, &i);

     g_assert_cmpint(r, ==, 0);
     g_assert_cmpuint(i, ==, 123);
@@ -284,11 +271,11 @@ static void test_parse_uint_full_correct(void)
 static void test_parse_uint_full_erange_junk(void)
 {
     /* FIXME - inconsistent with qemu_strto* which favors EINVAL */
-    unsigned long long i = 999;
+    uint64_t i = 999;
     const char *str = "-2junk";
     int r;

-    r = parse_uint_full(str, &i, 0);
+    r = parse_uint_full(str, 0, &i);

     g_assert_cmpint(r, ==, -ERANGE /* FIXME -EINVAL */);
     g_assert_cmpuint(i, ==, 0);
diff --git a/ui/vnc.c b/ui/vnc.c
index 9d8a24dd8a6..92964dcc0c0 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3728,7 +3728,7 @@ static int vnc_display_get_address(const char *addrstr,
     } else {
         const char *port;
         size_t hostlen;
-        unsigned long long baseport = 0;
+        uint64_t baseport = 0;
         InetSocketAddress *inet;

         port = strrchr(addrstr, ':');
@@ -3776,7 +3776,7 @@ static int vnc_display_get_address(const char *addrstr,
             }
         } else {
             int offset = reverse ? 0 : 5900;
-            if (parse_uint_full(port, &baseport, 10) < 0) {
+            if (parse_uint_full(port, 10, &baseport) < 0) {
                 error_setg(errp, "can't convert to a number: %s", port);
                 goto cleanup;
             }
diff --git a/util/cutils.c b/util/cutils.c
index 36c14b769fd..0e279a531aa 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -722,10 +722,10 @@ const char *qemu_strchrnul(const char *s, int c)
  * parse_uint:
  *
  * @s: String to parse
- * @value: Destination for parsed integer value
  * @endptr: Destination for pointer to first character not consumed, must
  * not be %NULL
  * @base: integer base, between 2 and 36 inclusive, or 0
+ * @value: Destination for parsed integer value
  *
  * Parse unsigned integer
  *
@@ -748,8 +748,7 @@ const char *qemu_strchrnul(const char *s, int c)
  *
  * Else, set *@value to the parsed integer, and return 0.
  */
-int parse_uint(const char *s, unsigned long long *value, char **endptr,
-               int base)
+int parse_uint(const char *s, const char **endptr, int base, uint64_t *value)
 {
     int r = 0;
     char *endp = (char *)s;
@@ -793,8 +792,8 @@ out:
  * parse_uint_full:
  *
  * @s: String to parse
- * @value: Destination for parsed integer value
  * @base: integer base, between 2 and 36 inclusive, or 0
+ * @value: Destination for parsed integer value
  *
  * Parse unsigned integer from entire string
  *
@@ -803,12 +802,12 @@ out:
  * characters are present after a non-overflowing parsed number, the
  * function will return -EINVAL, and *@v will be set to 0.
  */
-int parse_uint_full(const char *s, unsigned long long *value, int base)
+int parse_uint_full(const char *s, int base, uint64_t *value)
 {
-    char *endp;
+    const char *endp;
     int r;

-    r = parse_uint(s, value, &endp, base);
+    r = parse_uint(s, &endp, base, value);
     if (r < 0) {
         return r;
     }
diff --git a/util/guest-random.c b/util/guest-random.c
index a24d27624c6..9465dda085d 100644
--- a/util/guest-random.c
+++ b/util/guest-random.c
@@ -89,8 +89,8 @@ void qemu_guest_random_seed_thread_part2(uint64_t seed)

 int qemu_guest_random_seed_main(const char *optarg, Error **errp)
 {
-    unsigned long long seed;
-    if (parse_uint_full(optarg, &seed, 0)) {
+    uint64_t seed;
+    if (parse_uint_full(optarg, 0, &seed)) {
         error_setg(errp, "Invalid seed number: %s", optarg);
         return -1;
     } else {
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index c06a4dce77c..892d33f5e6b 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -249,12 +249,12 @@ static int inet_listen_saddr(InetSocketAddress *saddr,

     /* lookup */
     if (port_offset) {
-        unsigned long long baseport;
+        uint64_t baseport;
         if (strlen(port) == 0) {
             error_setg(errp, "port not specified");
             return -1;
         }
-        if (parse_uint_full(port, &baseport, 10) < 0) {
+        if (parse_uint_full(port, 10, &baseport) < 0) {
             error_setg(errp, "can't convert to a number: %s", port);
             return -1;
         }
@@ -732,19 +732,19 @@ static bool vsock_parse_vaddr_to_sockaddr(const VsockSocketAddress *vaddr,
                                           struct sockaddr_vm *svm,
                                           Error **errp)
 {
-    unsigned long long val;
+    uint64_t val;

     memset(svm, 0, sizeof(*svm));
     svm->svm_family = AF_VSOCK;

-    if (parse_uint_full(vaddr->cid, &val, 10) < 0 ||
+    if (parse_uint_full(vaddr->cid, 10, &val) < 0 ||
         val > UINT32_MAX) {
         error_setg(errp, "Failed to parse cid '%s'", vaddr->cid);
         return false;
     }
     svm->svm_cid = val;

-    if (parse_uint_full(vaddr->port, &val, 10) < 0 ||
+    if (parse_uint_full(vaddr->port, 10, &val) < 0 ||
         val > UINT32_MAX) {
         error_setg(errp, "Failed to parse port '%s'", vaddr->port);
         return false;
-- 
2.40.1


