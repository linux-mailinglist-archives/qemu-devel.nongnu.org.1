Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F3A790720
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 11:42:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcN7n-000099-Ut; Sat, 02 Sep 2023 05:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <williamtsai1111@gmail.com>)
 id 1qcN7l-00008o-V5; Sat, 02 Sep 2023 05:41:01 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <williamtsai1111@gmail.com>)
 id 1qcN7g-0003XE-7a; Sat, 02 Sep 2023 05:41:01 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bf078d5f33so23024605ad.3; 
 Sat, 02 Sep 2023 02:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693647653; x=1694252453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d+KN3fx+FqsPNwik0UQPupoziiNLKWlxyH+kvDK82QI=;
 b=gCOeHgS1dGULY62Vx8A1CkldbyMDMYOLlmprd2w18ZNzSa0X9lQCiyg4CDcvPp6bNr
 XeGDXjkZKYEzlin7/Upr6X+RHFlyArOeucBZqB9AyD0249ceLe8newYK+f1FdsWCLIFB
 XvcwPH/cHoS00Rk3p2r9M/33ouKPfnaQLhmiYLeairQ4DuYZn4UzupVzF/KPVarsYERg
 xQqC1JfltzQt73++Jvp4PM0mckEOCCNeuNud+pxzaHwiqIoOxRRT1YhopfYv34TQEIXo
 K+SgtPYQDa+STkCDRTSiTKdh+ZULOEoRb9WlYHn6sevD3TWx7eWV8VEL+I7+HhVCoZIv
 fWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693647653; x=1694252453;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d+KN3fx+FqsPNwik0UQPupoziiNLKWlxyH+kvDK82QI=;
 b=OnUvakM1lOGK8qQybMz3lb8rjZzIGlKbrZSLR7CxHWKcHAfXaPYiggMaGkVHcSrNcT
 RUM8oBiaSWrFY2PPydswhV/rBUbUwSUaPqckvw8ymiatu4rQSt6SXkSO6uXZPn1sOKz6
 nD2TM3ctwTtOCpn1XdFlsg8lzYrNu4Z4jMoGB0QI9n6BIk+sW1JaunFOJ8oCdUINUCnf
 guAKH5bbk4m5Qpgtxg74gHGGWmzLIX07uItuLjpHKeYD6p0Cp4q9ngbvFtMVvFS1+trm
 DVIxohtWsIh7FwOJvieSQWZThqSjSWY8Hgm0SQ1wc6li8QfUhOQmh9RqpNrsk8+E+/1s
 Fh4Q==
X-Gm-Message-State: AOJu0YwFL7ErXUJO7M03jVJzuabIk086ej8KWF+f5sHVwQeOwPAEOTOP
 0mJNmtM4aqsO7iknfyPnf5s9zBfDO889Ojxa
X-Google-Smtp-Source: AGHT+IGw/LItZ+H9XI6EKD3/vUP9Bsn8udULiaeBxFwH1MeRXPBHRS2X92FW9D93KqLzit/LUgsnUA==
X-Received: by 2002:a17:902:f7d5:b0:1c3:1167:26e4 with SMTP id
 h21-20020a170902f7d500b001c3116726e4mr4241732plw.60.1693647651265; 
 Sat, 02 Sep 2023 02:40:51 -0700 (PDT)
Received: from localhost
 (2001-b030-020d-d213-e15f-7601-37b3-3e9c.hinet-ip6.hinet.net.
 [2001:b030:20d:d213:e15f:7601:37b3:3e9c])
 by smtp.gmail.com with UTF8SMTPSA id
 9-20020a170902c14900b001b8baa83639sm4312874plj.200.2023.09.02.02.40.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Sep 2023 02:40:50 -0700 (PDT)
From: William Tsai <williamtsai1111@gmail.com>
To: qemu-devel@nongnu.org
Cc: William Tsai <williamtsai1111@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, Fam Zheng <fam@euphon.net>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH v2] qdict: Preserve order for iterating qdict elements
Date: Sat,  2 Sep 2023 17:40:40 +0800
Message-Id: <20230902094041.8626-1-williamtsai1111@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=williamtsai1111@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Changing the structure of qdict so that it can preserve order when
iterating qdict. This will fix array_properties as it relies on `len-`
prefixed argument to be set first.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1090
Signed-off-by: William Tsai <williamtsai1111@gmail.com>
---
 block.c                                       |   6 +-
 block/blkdebug.c                              |   2 +-
 block/nbd.c                                   |   4 +-
 block/nfs.c                                   |   2 +-
 block/null.c                                  |   2 +-
 block/qapi.c                                  |   2 +-
 block/ssh.c                                   |   2 +-
 include/qapi/qmp/qdict.h                      |   8 +-
 qapi/qmp-dispatch.c                           |   2 +-
 qapi/qobject-input-visitor.c                  |   2 +-
 qobject/block-qdict.c                         |  18 +-
 qobject/qdict.c                               |  50 +-
 qobject/qjson.c                               |   2 +-
 qom/object_interfaces.c                       |   2 +-
 softmmu/vl.c                                  |   2 +-
 target/i386/cpu-sysemu.c                      |   4 +-
 target/s390x/cpu_models_sysemu.c              |   2 +-
 tests/qemu-iotests/043.out                    |  22 +-
 tests/qemu-iotests/051.out                    |  11 +-
 tests/qemu-iotests/051.pc.out                 |  10 +-
 tests/qemu-iotests/060.out                    |  14 +-
 tests/qemu-iotests/061.out                    |  78 +-
 tests/qemu-iotests/065                        |  17 +-
 tests/qemu-iotests/071.out                    |   4 +-
 tests/qemu-iotests/082.out                    |  42 +-
 tests/qemu-iotests/095.out                    |  14 +-
 tests/qemu-iotests/099.out                    |   4 +-
 tests/qemu-iotests/108.out                    |  14 +-
 tests/qemu-iotests/117.out                    |   2 +-
 tests/qemu-iotests/120.out                    |   2 +-
 tests/qemu-iotests/127.out                    |  20 +-
 tests/qemu-iotests/140.out                    |   4 +-
 tests/qemu-iotests/141.out                    |  76 +-
 tests/qemu-iotests/143.out                    |   2 +-
 tests/qemu-iotests/144.out                    |  18 +-
 tests/qemu-iotests/156.out                    |  20 +-
 tests/qemu-iotests/161.out                    |  28 +-
 tests/qemu-iotests/176.out                    |  16 +-
 tests/qemu-iotests/183.out                    |  10 +-
 tests/qemu-iotests/184.out                    | 138 +--
 tests/qemu-iotests/186.out                    |  82 +-
 tests/qemu-iotests/190.out                    |   4 +-
 tests/qemu-iotests/191.out                    | 802 +++++++++---------
 tests/qemu-iotests/195.out                    |   4 +-
 tests/qemu-iotests/227.out                    | 174 ++--
 tests/qemu-iotests/229.out                    |  14 +-
 tests/qemu-iotests/244.out                    |  12 +-
 tests/qemu-iotests/247.out                    |  16 +-
 tests/qemu-iotests/249.out                    |  18 +-
 tests/qemu-iotests/273.out                    | 334 ++++----
 tests/qemu-iotests/tests/iothreads-resize.out |   2 +-
 tests/qemu-iotests/tests/qsd-jobs.out         |   8 +-
 tests/qtest/arm-cpu-features.c                |   2 +-
 tests/unit/check-block-qdict.c                |   2 +-
 tests/unit/check-qdict.c                      |   4 +-
 util/keyval.c                                 |   6 +-
 util/qemu-option.c                            |   4 +-
 57 files changed, 1086 insertions(+), 1080 deletions(-)

diff --git a/block.c b/block.c
index 0af890f647..e51bd36d4e 100644
--- a/block.c
+++ b/block.c
@@ -4223,7 +4223,7 @@ static int bdrv_reset_options_allowed(BlockDriverStat=
e *bs,
         "read-only", "auto-read-only", "detect-zeroes", NULL
     };
=20
-    for (e =3D qdict_first(bs->options); e; e =3D qdict_next(bs->options, =
e)) {
+    for (e =3D qdict_first(bs->options); e; e =3D qdict_next(e)) {
         if (!qdict_haskey(new_opts, e->key) &&
             !is_str_in_list(e->key, common_options) &&
             !is_str_in_list(e->key, bs->drv->mutable_opts)) {
@@ -4950,7 +4950,7 @@ static int bdrv_reopen_prepare(BDRVReopenState *reope=
n_state,
                 ret =3D -EINVAL;
                 goto error;
             }
-        } while ((entry =3D qdict_next(reopen_state->options, entry)));
+        } while ((entry =3D qdict_next(entry)));
     }
=20
     ret =3D 0;
@@ -7862,7 +7862,7 @@ static bool append_strong_runtime_options(QDict *d, B=
lockDriverState *bs)
         } else {
             const QDictEntry *entry;
             for (entry =3D qdict_first(bs->options); entry;
-                 entry =3D qdict_next(bs->options, entry))
+                 entry =3D qdict_next(entry))
             {
                 if (strstart(qdict_entry_key(entry), *option_name, NULL)) {
                     qdict_put_obj(d, qdict_entry_key(entry),
diff --git a/block/blkdebug.c b/block/blkdebug.c
index addad914b3..c5205f0805 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -984,7 +984,7 @@ static void blkdebug_refresh_filename(BlockDriverState =
*bs)
     }
=20
     for (e =3D qdict_first(bs->full_open_options); e;
-         e =3D qdict_next(bs->full_open_options, e))
+         e =3D qdict_next(e))
     {
         /* Real child options are under "image", but "x-image" may
          * contain a filename */
diff --git a/block/nbd.c b/block/nbd.c
index 5322e66166..e1a6a6fb5f 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1563,7 +1563,7 @@ static bool nbd_has_filename_options_conflict(QDict *=
options, Error **errp)
 {
     const QDictEntry *e;
=20
-    for (e =3D qdict_first(options); e; e =3D qdict_next(options, e)) {
+    for (e =3D qdict_first(options); e; e =3D qdict_next(e)) {
         if (!strcmp(e->key, "host") ||
             !strcmp(e->key, "port") ||
             !strcmp(e->key, "path") ||
@@ -1654,7 +1654,7 @@ static bool nbd_process_legacy_socket_options(QDict *=
output_options,
         return true;
     }
=20
-    for (e =3D qdict_first(output_options); e; e =3D qdict_next(output_opt=
ions, e))
+    for (e =3D qdict_first(output_options); e; e =3D qdict_next(e))
     {
         if (strstart(e->key, "server.", NULL)) {
             error_setg(errp, "Cannot use 'server' and path/host/port at th=
e "
diff --git a/block/nfs.c b/block/nfs.c
index c24df49747..75c1e69472 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -156,7 +156,7 @@ static bool nfs_has_filename_options_conflict(QDict *op=
tions, Error **errp)
 {
     const QDictEntry *qe;
=20
-    for (qe =3D qdict_first(options); qe; qe =3D qdict_next(options, qe)) {
+    for (qe =3D qdict_first(options); qe; qe =3D qdict_next(qe)) {
         if (!strcmp(qe->key, "host") ||
             !strcmp(qe->key, "path") ||
             !strcmp(qe->key, "user") ||
diff --git a/block/null.c b/block/null.c
index 4808704ffd..faeac5de10 100644
--- a/block/null.c
+++ b/block/null.c
@@ -250,7 +250,7 @@ static void null_refresh_filename(BlockDriverState *bs)
     const QDictEntry *e;
=20
     for (e =3D qdict_first(bs->full_open_options); e;
-         e =3D qdict_next(bs->full_open_options, e))
+         e =3D qdict_next(e))
     {
         /* These options can be ignored */
         if (strcmp(qdict_entry_key(e), "filename") &&
diff --git a/block/qapi.c b/block/qapi.c
index f34f95e0ef..de24bb750b 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -868,7 +868,7 @@ static void dump_qdict(int indentation, QDict *dict)
 {
     const QDictEntry *entry;
=20
-    for (entry =3D qdict_first(dict); entry; entry =3D qdict_next(dict, en=
try)) {
+    for (entry =3D qdict_first(dict); entry; entry =3D qdict_next(entry)) {
         QType type =3D qobject_type(entry->value);
         bool composite =3D (type =3D=3D QTYPE_QDICT || type =3D=3D QTYPE_Q=
LIST);
         char *key =3D g_malloc(strlen(entry->key) + 1);
diff --git a/block/ssh.c b/block/ssh.c
index 2748253d4a..aa3eac9722 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -246,7 +246,7 @@ static bool ssh_has_filename_options_conflict(QDict *op=
tions, Error **errp)
 {
     const QDictEntry *qe;
=20
-    for (qe =3D qdict_first(options); qe; qe =3D qdict_next(options, qe)) {
+    for (qe =3D qdict_first(options); qe; qe =3D qdict_next(qe)) {
         if (!strcmp(qe->key, "host") ||
             !strcmp(qe->key, "port") ||
             !strcmp(qe->key, "path") ||
diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index 82e90fc072..f1bb79ec99 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -21,13 +21,15 @@
 typedef struct QDictEntry {
     char *key;
     QObject *value;
-    QLIST_ENTRY(QDictEntry) next;
+    QLIST_ENTRY(QDictEntry) bucket_next;
+    QTAILQ_ENTRY(QDictEntry) next;
 } QDictEntry;
=20
 struct QDict {
     struct QObjectBase_ base;
     size_t size;
-    QLIST_HEAD(,QDictEntry) table[QDICT_BUCKET_MAX];
+    QLIST_HEAD(, QDictEntry) table[QDICT_BUCKET_MAX];
+    QTAILQ_HEAD(, QDictEntry) first;
 };
=20
 void qdict_unref(QDict *q);
@@ -44,7 +46,7 @@ void qdict_del(QDict *qdict, const char *key);
 int qdict_haskey(const QDict *qdict, const char *key);
 QObject *qdict_get(const QDict *qdict, const char *key);
 const QDictEntry *qdict_first(const QDict *qdict);
-const QDictEntry *qdict_next(const QDict *qdict, const QDictEntry *entry);
+const QDictEntry *qdict_next(const QDictEntry *entry);
=20
 /* Helper to qdict_put_obj(), accepts any object */
 #define qdict_put(qdict, key, obj) \
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 555528b6bb..0d0075f40b 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -50,7 +50,7 @@ static QDict *qmp_dispatch_check_obj(QDict *dict, bool al=
low_oob,
     const QObject *arg_obj;
=20
     for (ent =3D qdict_first(dict); ent;
-         ent =3D qdict_next(dict, ent)) {
+         ent =3D qdict_next(ent)) {
         arg_name =3D qdict_entry_key(ent);
         arg_obj =3D qdict_entry_value(ent);
=20
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 3e8aca6b15..49b508a1e1 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -223,7 +223,7 @@ static const QListEntry *qobject_input_push(QObjectInpu=
tVisitor *qiv,
         h =3D g_hash_table_new(g_str_hash, g_str_equal);
         for (entry =3D qdict_first(qdict);
              entry;
-             entry =3D qdict_next(qdict, entry)) {
+             entry =3D qdict_next(entry)) {
             g_hash_table_insert(h, (void *)qdict_entry_key(entry), NULL);
         }
         tos->h =3D h;
diff --git a/qobject/block-qdict.c b/qobject/block-qdict.c
index 4a83bda2c3..9ed90c42b7 100644
--- a/qobject/block-qdict.c
+++ b/qobject/block-qdict.c
@@ -102,7 +102,7 @@ static void qdict_flatten_qdict(QDict *qdict, QDict *ta=
rget, const char *prefix)
     entry =3D qdict_first(qdict);
=20
     while (entry !=3D NULL) {
-        next =3D qdict_next(qdict, entry);
+        next =3D qdict_next(entry);
         value =3D qdict_entry_value(entry);
         dict_val =3D qobject_to(QDict, value);
         list_val =3D qobject_to(QList, value);
@@ -172,7 +172,7 @@ void qdict_extract_subqdict(QDict *src, QDict **dst, co=
nst char *start)
     entry =3D qdict_first(src);
=20
     while (entry !=3D NULL) {
-        next =3D qdict_next(src, entry);
+        next =3D qdict_next(entry);
         if (strstart(entry->key, start, &p)) {
             if (dst) {
                 qdict_put_obj(*dst, p, qobject_ref(entry->value));
@@ -188,7 +188,7 @@ static int qdict_count_prefixed_entries(const QDict *sr=
c, const char *start)
     const QDictEntry *entry;
     int count =3D 0;
=20
-    for (entry =3D qdict_first(src); entry; entry =3D qdict_next(src, entr=
y)) {
+    for (entry =3D qdict_first(src); entry; entry =3D qdict_next(entry)) {
         if (strstart(entry->key, start, NULL)) {
             if (count =3D=3D INT_MAX) {
                 return -ERANGE;
@@ -341,7 +341,7 @@ static int qdict_is_list(QDict *maybe_list, Error **err=
p)
     int64_t val;
=20
     for (ent =3D qdict_first(maybe_list); ent !=3D NULL;
-         ent =3D qdict_next(maybe_list, ent)) {
+         ent =3D qdict_next(ent)) {
         int is_index =3D !qemu_strtoi64(ent->key, NULL, 10, &val);
=20
         if (is_list =3D=3D -1) {
@@ -435,7 +435,7 @@ QObject *qdict_crumple(const QDict *src, Error **errp)
     two_level =3D qdict_new();
=20
     /* Step 1: split our totally flat dict into a two level dict */
-    for (ent =3D qdict_first(src); ent !=3D NULL; ent =3D qdict_next(src, =
ent)) {
+    for (ent =3D qdict_first(src); ent !=3D NULL; ent =3D qdict_next(ent))=
 {
         dict_val =3D qobject_to(QDict, ent->value);
         list_val =3D qobject_to(QList, ent->value);
         if ((dict_val && qdict_size(dict_val))
@@ -478,7 +478,7 @@ QObject *qdict_crumple(const QDict *src, Error **errp)
      * into a multi-level dict */
     multi_level =3D qdict_new();
     for (ent =3D qdict_first(two_level); ent !=3D NULL;
-         ent =3D qdict_next(two_level, ent)) {
+         ent =3D qdict_next(ent)) {
         dict_val =3D qobject_to(QDict, ent->value);
         if (dict_val && qdict_size(dict_val)) {
             child =3D qdict_crumple(dict_val, errp);
@@ -553,7 +553,7 @@ static QObject *qdict_crumple_for_keyval_qiv(QDict *src=
, Error **errp)
     const QDictEntry *ent;
     QObject *dst;
=20
-    for (ent =3D qdict_first(src); ent; ent =3D qdict_next(src, ent)) {
+    for (ent =3D qdict_first(src); ent; ent =3D qdict_next(ent)) {
         buf =3D NULL;
         switch (qobject_type(ent->value)) {
         case QTYPE_QNULL:
@@ -634,7 +634,7 @@ int qdict_array_entries(QDict *src, const char *subqdic=
t)
     }
=20
     /* Consider everything handled that isn't part of the given sub-QDict =
*/
-    for (entry =3D qdict_first(src); entry; entry =3D qdict_next(src, entr=
y)) {
+    for (entry =3D qdict_first(src); entry; entry =3D qdict_next(entry)) {
         if (!strstart(qdict_entry_key(entry), subqdict, NULL)) {
             entries++;
         }
@@ -668,7 +668,7 @@ void qdict_join(QDict *dest, QDict *src, bool overwrite)
=20
     entry =3D qdict_first(src);
     while (entry) {
-        next =3D qdict_next(src, entry);
+        next =3D qdict_next(entry);
=20
         if (overwrite || !qdict_haskey(dest, entry->key)) {
             qdict_put_obj(dest, entry->key, qobject_ref(entry->value));
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 8faff230d3..4ad9ccbbbf 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -28,6 +28,7 @@ QDict *qdict_new(void)
     QDict *qdict;
=20
     qdict =3D g_malloc0(sizeof(*qdict));
+    QTAILQ_INIT(&qdict->first);
     qobject_init(QOBJECT(qdict), QTYPE_QDICT);
=20
     return qdict;
@@ -93,7 +94,7 @@ static QDictEntry *qdict_find(const QDict *qdict,
 {
     QDictEntry *entry;
=20
-    QLIST_FOREACH(entry, &qdict->table[bucket], next)
+    QLIST_FOREACH(entry, &qdict->table[bucket], bucket_next)
         if (!strcmp(entry->key, key)) {
             return entry;
         }
@@ -126,7 +127,8 @@ void qdict_put_obj(QDict *qdict, const char *key, QObje=
ct *value)
     } else {
         /* allocate a new entry */
         entry =3D alloc_entry(key, value);
-        QLIST_INSERT_HEAD(&qdict->table[bucket], entry, next);
+        QLIST_INSERT_HEAD(&qdict->table[bucket], entry, bucket_next);
+        QTAILQ_INSERT_TAIL(&qdict->first, entry, next);
         qdict->size++;
     }
 }
@@ -301,41 +303,20 @@ const char *qdict_get_try_str(const QDict *qdict, con=
st char *key)
     return qstr ? qstring_get_str(qstr) : NULL;
 }
=20
-static QDictEntry *qdict_next_entry(const QDict *qdict, int first_bucket)
-{
-    int i;
-
-    for (i =3D first_bucket; i < QDICT_BUCKET_MAX; i++) {
-        if (!QLIST_EMPTY(&qdict->table[i])) {
-            return QLIST_FIRST(&qdict->table[i]);
-        }
-    }
-
-    return NULL;
-}
-
 /**
  * qdict_first(): Return first qdict entry for iteration.
  */
 const QDictEntry *qdict_first(const QDict *qdict)
 {
-    return qdict_next_entry(qdict, 0);
+    return qdict->first.tqh_first;
 }
=20
 /**
  * qdict_next(): Return next qdict entry in an iteration.
  */
-const QDictEntry *qdict_next(const QDict *qdict, const QDictEntry *entry)
+const QDictEntry *qdict_next(const QDictEntry *entry)
 {
-    QDictEntry *ret;
-
-    ret =3D QLIST_NEXT(entry, next);
-    if (!ret) {
-        unsigned int bucket =3D tdb_hash(entry->key) % QDICT_BUCKET_MAX;
-        ret =3D qdict_next_entry(qdict, bucket + 1);
-    }
-
-    return ret;
+    return QTAILQ_NEXT(entry, next);
 }
=20
 /**
@@ -346,14 +327,10 @@ QDict *qdict_clone_shallow(const QDict *src)
 {
     QDict *dest;
     QDictEntry *entry;
-    int i;
=20
     dest =3D qdict_new();
-
-    for (i =3D 0; i < QDICT_BUCKET_MAX; i++) {
-        QLIST_FOREACH(entry, &src->table[i], next) {
-            qdict_put_obj(dest, entry->key, qobject_ref(entry->value));
-        }
+    QTAILQ_FOREACH(entry, &src->first, next) {
+        qdict_put_obj(dest, entry->key, qobject_ref(entry->value));
     }
=20
     return dest;
@@ -384,7 +361,8 @@ void qdict_del(QDict *qdict, const char *key)
=20
     entry =3D qdict_find(qdict, key, tdb_hash(key) % QDICT_BUCKET_MAX);
     if (entry) {
-        QLIST_REMOVE(entry, next);
+        QLIST_REMOVE(entry, bucket_next);
+        QTAILQ_REMOVE(&qdict->first, entry, next);
         qentry_destroy(entry);
         qdict->size--;
     }
@@ -407,7 +385,7 @@ bool qdict_is_equal(const QObject *x, const QObject *y)
         return false;
     }
=20
-    for (e =3D qdict_first(dict_x); e; e =3D qdict_next(dict_x, e)) {
+    for (e =3D qdict_first(dict_x); e; e =3D qdict_next(e)) {
         const QObject *obj_x =3D qdict_entry_value(e);
         const QObject *obj_y =3D qdict_get(dict_y, qdict_entry_key(e));
=20
@@ -433,8 +411,8 @@ void qdict_destroy_obj(QObject *obj)
     for (i =3D 0; i < QDICT_BUCKET_MAX; i++) {
         QDictEntry *entry =3D QLIST_FIRST(&qdict->table[i]);
         while (entry) {
-            QDictEntry *tmp =3D QLIST_NEXT(entry, next);
-            QLIST_REMOVE(entry, next);
+            QDictEntry *tmp =3D QLIST_NEXT(entry, bucket_next);
+            QLIST_REMOVE(entry, bucket_next);
             qentry_destroy(entry);
             entry =3D tmp;
         }
diff --git a/qobject/qjson.c b/qobject/qjson.c
index 167fcb429c..fc15565fd7 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -187,7 +187,7 @@ static void to_json(JSONWriter *writer, const char *nam=
e,
=20
         for (entry =3D qdict_first(val);
              entry;
-             entry =3D qdict_next(val, entry)) {
+             entry =3D qdict_next(entry)) {
             to_json(writer, qdict_entry_key(entry), qdict_entry_value(entr=
y));
         }
=20
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 7d31589b04..80d536c38f 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -51,7 +51,7 @@ static void object_set_properties_from_qdict(Object *obj,=
 const QDict *qdict,
     if (!visit_start_struct(v, NULL, NULL, 0, errp)) {
         return;
     }
-    for (e =3D qdict_first(qdict); e; e =3D qdict_next(qdict, e)) {
+    for (e =3D qdict_first(qdict); e; e =3D qdict_next(e)) {
         if (!object_property_set(obj, e->key, v, errp)) {
             goto out;
         }
diff --git a/softmmu/vl.c b/softmmu/vl.c
index b0b96f67fa..8ce81a2605 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1645,7 +1645,7 @@ static void keyval_dashify(QDict *qdict, Error **errp)
     for (ent =3D qdict_first(qdict); ent; ent =3D next) {
         g_autofree char *new_key =3D NULL;
=20
-        next =3D qdict_next(qdict, ent);
+        next =3D qdict_next(ent);
         if (!strchr(ent->key, '_')) {
             continue;
         }
diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index 28115edf44..1ffdc2d775 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -95,7 +95,7 @@ static void x86_cpu_to_dict(X86CPU *cpu, QDict *props)
     QDict *sprops =3D x86_cpu_static_props();
     const QDictEntry *e;
=20
-    for (e =3D qdict_first(sprops); e; e =3D qdict_next(sprops, e)) {
+    for (e =3D qdict_first(sprops); e; e =3D qdict_next(e)) {
         const char *prop =3D qdict_entry_key(e);
         x86_cpu_expand_prop(cpu, props, prop);
     }
@@ -133,7 +133,7 @@ static void object_apply_props(Object *obj, QDict *prop=
s, Error **errp)
 {
     const QDictEntry *prop;
=20
-    for (prop =3D qdict_first(props); prop; prop =3D qdict_next(props, pro=
p)) {
+    for (prop =3D qdict_first(props); prop; prop =3D qdict_next(prop)) {
         if (!object_property_set_qobject(obj, qdict_entry_key(prop),
                                          qdict_entry_value(prop), errp)) {
             break;
diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sys=
emu.c
index 63981bf36b..4631f3cdbd 100644
--- a/target/s390x/cpu_models_sysemu.c
+++ b/target/s390x/cpu_models_sysemu.c
@@ -142,7 +142,7 @@ static void cpu_model_from_info(S390CPUModel *model, co=
nst CpuModelInfo *info,
             object_unref(obj);
             return;
         }
-        for (e =3D qdict_first(qdict); e; e =3D qdict_next(qdict, e)) {
+        for (e =3D qdict_first(qdict); e; e =3D qdict_next(e)) {
             if (!object_property_set(obj, e->key, visitor, &err)) {
                 break;
             }
diff --git a/tests/qemu-iotests/043.out b/tests/qemu-iotests/043.out
index 63ecb21816..d8fcff24e9 100644
--- a/tests/qemu-iotests/043.out
+++ b/tests/qemu-iotests/043.out
@@ -40,29 +40,29 @@ cluster_size: 65536
 =3D=3D finite chain of length 3 (json) =3D=3D
 [
     {
-        "virtual-size": 134217728,
         "filename": "TEST_DIR/t.IMGFMT",
-        "cluster-size": 65536,
         "format": "IMGFMT",
-        "full-backing-filename": "TEST_DIR/t.IMGFMT.2.base",
+        "dirty-flag": false,
+        "virtual-size": 134217728,
+        "cluster-size": 65536,
         "backing-filename": "TEST_DIR/t.IMGFMT.2.base",
-        "dirty-flag": false
+        "full-backing-filename": "TEST_DIR/t.IMGFMT.2.base",
     },
     {
-        "virtual-size": 134217728,
         "filename": "TEST_DIR/t.IMGFMT.2.base",
-        "cluster-size": 65536,
         "format": "IMGFMT",
-        "full-backing-filename": "TEST_DIR/t.IMGFMT.1.base",
+        "dirty-flag": false,
+        "virtual-size": 134217728,
+        "cluster-size": 65536,
         "backing-filename": "TEST_DIR/t.IMGFMT.1.base",
-        "dirty-flag": false
+        "full-backing-filename": "TEST_DIR/t.IMGFMT.1.base",
     },
     {
-        "virtual-size": 134217728,
         "filename": "TEST_DIR/t.IMGFMT.1.base",
-        "cluster-size": 65536,
         "format": "IMGFMT",
-        "dirty-flag": false
+        "dirty-flag": false,
+        "virtual-size": 134217728,
+        "cluster-size": 65536,
     }
 ]
 *** done
diff --git a/tests/qemu-iotests/051.out b/tests/qemu-iotests/051.out
index d462156405..cdb0d57dd8 100644
--- a/tests/qemu-iotests/051.out
+++ b/tests/qemu-iotests/051.out
@@ -82,8 +82,7 @@ QEMU_PROG: -device scsi-hd: drive property not set
 Testing: -drive file=3DTEST_DIR/t.qcow2,driver=3Dqcow2,backing.file.filena=
me=3DTEST_DIR/t.qcow2.orig,if=3Dnone,id=3Ddrive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver"=
: "file", "filename": "TEST_DIR/t.qcow2.orig"}}, "driver": "qcow2", "file":=
 {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
-    Removable device: not locked, tray closed
+drive0 (NODE_NAME): json:{"driver": "qcow2", "backing": {"driver": "qcow2"=
, "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.orig"}}, "file":=
 {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)    Removable d=
evice: not locked, tray closed
     Cache mode:       writeback
     Backing file:     TEST_DIR/t.qcow2.orig (chain depth: 1)
 (qemu) quit
@@ -175,7 +174,7 @@ QEMU_PROG: -drive driver=3Dnull-co,cache=3Dinvalid_valu=
e: invalid cache option
 Testing: -drive file=3DTEST_DIR/t.qcow2,cache=3Dwriteback,backing.file.fil=
ename=3DTEST_DIR/t.qcow2.base,backing.cache.no-flush=3Don,backing.node-name=
=3Dbacking,backing.file.node-name=3Dbacking-file,file.node-name=3Dfile,if=
=3Dnone,id=3Ddrive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver"=
: "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file":=
 {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
+drive0 (NODE_NAME): json:{"driver": "qcow2", "backing": {"driver": "qcow2"=
, "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "file":=
 {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
@@ -195,7 +194,7 @@ backing-file: TEST_DIR/t.qcow2.base (file, read-only)
 Testing: -drive file=3DTEST_DIR/t.qcow2,cache=3Dwritethrough,backing.file.=
filename=3DTEST_DIR/t.qcow2.base,backing.cache.no-flush=3Don,backing.node-n=
ame=3Dbacking,backing.file.node-name=3Dbacking-file,file.node-name=3Dfile,i=
f=3Dnone,id=3Ddrive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver"=
: "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file":=
 {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
+drive0 (NODE_NAME): json:{"driver": "qcow2", "backing": {"driver": "qcow2"=
, "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "file":=
 {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writethrough
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
@@ -215,7 +214,7 @@ backing-file: TEST_DIR/t.qcow2.base (file, read-only)
 Testing: -drive file=3DTEST_DIR/t.qcow2,cache=3Dunsafe,backing.file.filena=
me=3DTEST_DIR/t.qcow2.base,backing.cache.no-flush=3Don,backing.node-name=3D=
backing,backing.file.node-name=3Dbacking-file,file.node-name=3Dfile,if=3Dno=
ne,id=3Ddrive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver"=
: "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file":=
 {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
+drive0 (NODE_NAME): json:{"driver": "qcow2", "backing": {"driver": "qcow2"=
, "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "file":=
 {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback, ignore flushes
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
@@ -464,7 +463,7 @@ QEMU_PROG: -drive driver=3Dnull-co,snapshot=3Don: Could=
 not open temporary file SNAP
 Testing: -drive file=3DTEST_DIR/t.qcow2,snapshot=3Don,read-only=3Don,if=3D=
none,id=3Ddrive0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver"=
: "file", "filename": "TEST_DIR/t.qcow2"}}, "driver": "qcow2", "file": {"dr=
iver": "file", "filename": SNAPSHOT_PATH}} (qcow2, read-only)
+drive0 (NODE_NAME): json:{"driver": "qcow2", "backing": {"driver": "qcow2"=
, "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}}, "file": {"dr=
iver": "file", "filename": SNAPSHOT_PATH}} (qcow2, read-only)
     Removable device: not locked, tray closed
     Cache mode:       writeback, ignore flushes
     Backing file:     TEST_DIR/t.qcow2 (chain depth: 1)
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index 4d4af5a486..654f1cffae 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -82,7 +82,7 @@ QEMU_PROG: -device scsi-hd: drive property not set
 Testing: -drive file=3DTEST_DIR/t.qcow2,driver=3Dqcow2,backing.file.filena=
me=3DTEST_DIR/t.qcow2.orig,if=3Dnone,id=3Ddrive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver"=
: "file", "filename": "TEST_DIR/t.qcow2.orig"}}, "driver": "qcow2", "file":=
 {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
+drive0 (NODE_NAME): json:{"driver": "qcow2", "backing": {"driver": "qcow2"=
, "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.orig"}}, "file":=
 {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback
     Backing file:     TEST_DIR/t.qcow2.orig (chain depth: 1)
@@ -255,7 +255,7 @@ QEMU_PROG: -drive driver=3Dnull-co,cache=3Dinvalid_valu=
e: invalid cache option
 Testing: -drive file=3DTEST_DIR/t.qcow2,cache=3Dwriteback,backing.file.fil=
ename=3DTEST_DIR/t.qcow2.base,backing.cache.no-flush=3Don,backing.node-name=
=3Dbacking,backing.file.node-name=3Dbacking-file,file.node-name=3Dfile,if=
=3Dnone,id=3Ddrive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver"=
: "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file":=
 {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
+drive0 (NODE_NAME): json:{"driver": "qcow2", "backing": {"driver": "qcow2"=
, "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "file":=
 {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
@@ -275,7 +275,7 @@ backing-file: TEST_DIR/t.qcow2.base (file, read-only)
 Testing: -drive file=3DTEST_DIR/t.qcow2,cache=3Dwritethrough,backing.file.=
filename=3DTEST_DIR/t.qcow2.base,backing.cache.no-flush=3Don,backing.node-n=
ame=3Dbacking,backing.file.node-name=3Dbacking-file,file.node-name=3Dfile,i=
f=3Dnone,id=3Ddrive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver"=
: "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file":=
 {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
+drive0 (NODE_NAME): json:{"driver": "qcow2", "backing": {"driver": "qcow2"=
, "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "file":=
 {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writethrough
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
@@ -295,7 +295,7 @@ backing-file: TEST_DIR/t.qcow2.base (file, read-only)
 Testing: -drive file=3DTEST_DIR/t.qcow2,cache=3Dunsafe,backing.file.filena=
me=3DTEST_DIR/t.qcow2.base,backing.cache.no-flush=3Don,backing.node-name=3D=
backing,backing.file.node-name=3Dbacking-file,file.node-name=3Dfile,if=3Dno=
ne,id=3Ddrive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver"=
: "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file":=
 {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
+drive0 (NODE_NAME): json:{"driver": "qcow2", "backing": {"driver": "qcow2"=
, "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "file":=
 {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
     Removable device: not locked, tray closed
     Cache mode:       writeback, ignore flushes
     Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
@@ -544,7 +544,7 @@ QEMU_PROG: -drive driver=3Dnull-co,snapshot=3Don: Could=
 not open temporary file SNAP
 Testing: -drive file=3DTEST_DIR/t.qcow2,snapshot=3Don,read-only=3Don,if=3D=
none,id=3Ddrive0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver"=
: "file", "filename": "TEST_DIR/t.qcow2"}}, "driver": "qcow2", "file": {"dr=
iver": "file", "filename": SNAPSHOT_PATH}} (qcow2, read-only)
+drive0 (NODE_NAME): json:{"driver": "qcow2", "backing": {"driver": "qcow2"=
, "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}}, "file": {"dr=
iver": "file", "filename": SNAPSHOT_PATH}} (qcow2, read-only)
     Removable device: not locked, tray closed
     Cache mode:       writeback, ignore flushes
     Backing file:     TEST_DIR/t.qcow2 (chain depth: 1)
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 329977d9b9..f654a6579c 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -17,11 +17,11 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
-    compression type: COMPRESSION_TYPE
+    extended l2: false
     lazy refcounts: false
-    refcount bits: 16
     corrupt: true
-    extended l2: false
+    refcount bits: 16
+    compression type: COMPRESSION_TYPE
 qemu-io: can't open device TEST_DIR/t.IMGFMT: IMGFMT: Image is corrupt; ca=
nnot be opened read/write
 no file open, try 'help open'
 read 512/512 bytes at offset 0
@@ -418,11 +418,11 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D6=
7108864
 qcow2: Marking image as corrupt: Preventing invalid write on metadata (ove=
rlaps with refcount table); further corruption events will be suppressed
 QMP_VERSION
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_IMAGE_CORRUPTED", "data": {"device": "none0", "msg": "Preventing i=
nvalid write on metadata (overlaps with refcount table)", "offset": 65536, =
"node-name": "drive", "fatal": true, "size": 65536}}
+{"event": "BLOCK_IMAGE_CORRUPTED", "timestamp": {"seconds":  TIMESTAMP, "m=
icroseconds":  TIMESTAMP}, "data": {"device": "none0", "node-name": "drive"=
, "msg": "Preventing invalid write on metadata (overlaps with refcount tabl=
e)", "offset": 65536, "size": 65536, "fatal": true}}
 write failed: Input/output error
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"event": "SHUTDOWN", "timestamp": {"seconds":  TIMESTAMP, "microseconds":=
  TIMESTAMP}, "data": {"guest": false, "reason": "host-qmp-quit"}}
=20
 =3D=3D=3D Testing incoming inactive corrupted image =3D=3D=3D
=20
@@ -430,10 +430,10 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D6=
7108864
 QMP_VERSION
 {"return": {}}
 qcow2: Image is corrupt: L2 table offset 0x2a2a2a00 unaligned (L1 index: 0=
); further non-fatal corruption events will be suppressed
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_IMAGE_CORRUPTED", "data": {"device": "", "msg": "L2 table offset 0=
x2a2a2a00 unaligned (L1 index: 0)", "node-name": "drive", "fatal": false}}
+{"event": "BLOCK_IMAGE_CORRUPTED", "timestamp": {"seconds":  TIMESTAMP, "m=
icroseconds":  TIMESTAMP}, "data": {"device": "", "node-name": "drive", "ms=
g": "L2 table offset 0x2a2a2a00 unaligned (L1 index: 0)", "fatal": false}}
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"event": "SHUTDOWN", "timestamp": {"seconds":  TIMESTAMP, "microseconds":=
  TIMESTAMP}, "data": {"guest": false, "reason": "host-qmp-quit"}}
=20
     corrupt: false
 *** done
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 139fc68177..a0b0788715 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -497,7 +497,16 @@ wrote 65536/65536 bytes at offset 2147483648
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 3221225472
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-    (0.00/100%)=0D    (12.50/100%)=0D    (25.00/100%)=0D    (37.50/100%)=
=0D    (50.00/100%)=0D    (62.50/100%)=0D    (75.00/100%)=0D    (87.50/100%=
)=0D    (100.00/100%)=0D    (100.00/100%)
+    (0.00/100%)
+    (12.50/100%)
+    (25.00/100%)
+    (37.50/100%)
+    (50.00/100%)
+    (62.50/100%)
+    (75.00/100%)
+    (87.50/100%)
+    (100.00/100%)
+    (100.00/100%)
 No errors were found on the image.
=20
 =3D=3D=3D Testing progress report with snapshot =3D=3D=3D
@@ -512,7 +521,24 @@ wrote 65536/65536 bytes at offset 2147483648
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 3221225472
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-    (0.00/100%)=0D    (6.25/100%)=0D    (12.50/100%)=0D    (18.75/100%)=0D=
    (25.00/100%)=0D    (31.25/100%)=0D    (37.50/100%)=0D    (43.75/100%)=
=0D    (50.00/100%)=0D    (56.25/100%)=0D    (62.50/100%)=0D    (68.75/100%=
)=0D    (75.00/100%)=0D    (81.25/100%)=0D    (87.50/100%)=0D    (93.75/100=
%)=0D    (100.00/100%)=0D    (100.00/100%)
+    (0.00/100%)
+    (6.25/100%)
+    (12.50/100%)
+    (18.75/100%)
+    (25.00/100%)
+    (31.25/100%)
+    (37.50/100%)
+    (43.75/100%)
+    (50.00/100%)
+    (56.25/100%)
+    (62.50/100%)
+    (68.75/100%)
+    (75.00/100%)
+    (81.25/100%)
+    (87.50/100%)
+    (93.75/100%)
+    (100.00/100%)
+    (100.00/100%)
 No errors were found on the image.
=20
 =3D=3D=3D Testing version downgrade with external data file =3D=3D=3D
@@ -525,13 +551,13 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
-    compression type: COMPRESSION_TYPE
-    lazy refcounts: false
-    refcount bits: 16
     data file: TEST_DIR/t.IMGFMT.data
     data file raw: false
-    corrupt: false
     extended l2: false
+    lazy refcounts: false
+    corrupt: false
+    refcount bits: 16
+    compression type: COMPRESSION_TYPE
 No errors were found on the image.
=20
 =3D=3D=3D Testing version downgrade with extended L2 entries =3D=3D=3D
@@ -552,13 +578,13 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
-    compression type: COMPRESSION_TYPE
-    lazy refcounts: false
-    refcount bits: 16
     data file: foo
     data file raw: false
-    corrupt: false
     extended l2: false
+    lazy refcounts: false
+    corrupt: false
+    refcount bits: 16
+    compression type: COMPRESSION_TYPE
=20
 qemu-img: Could not open 'TEST_DIR/t.IMGFMT': 'data-file' is required for =
this image
 image: TEST_DIR/t.IMGFMT
@@ -567,12 +593,12 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
-    compression type: COMPRESSION_TYPE
-    lazy refcounts: false
-    refcount bits: 16
     data file raw: false
-    corrupt: false
     extended l2: false
+    lazy refcounts: false
+    corrupt: false
+    refcount bits: 16
+    compression type: COMPRESSION_TYPE
=20
 =3D=3D=3D Clearing and setting data-file-raw =3D=3D=3D
=20
@@ -583,13 +609,13 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
-    compression type: COMPRESSION_TYPE
-    lazy refcounts: false
-    refcount bits: 16
     data file: TEST_DIR/t.IMGFMT.data
     data file raw: true
-    corrupt: false
     extended l2: false
+    lazy refcounts: false
+    corrupt: false
+    refcount bits: 16
+    compression type: COMPRESSION_TYPE
 No errors were found on the image.
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
@@ -597,13 +623,13 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
-    compression type: COMPRESSION_TYPE
-    lazy refcounts: false
-    refcount bits: 16
     data file: TEST_DIR/t.IMGFMT.data
     data file raw: false
-    corrupt: false
     extended l2: false
+    lazy refcounts: false
+    corrupt: false
+    refcount bits: 16
+    compression type: COMPRESSION_TYPE
 No errors were found on the image.
 qemu-img: data-file-raw cannot be set on existing images
 image: TEST_DIR/t.IMGFMT
@@ -612,12 +638,12 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
-    compression type: COMPRESSION_TYPE
-    lazy refcounts: false
-    refcount bits: 16
     data file: TEST_DIR/t.IMGFMT.data
     data file raw: false
-    corrupt: false
     extended l2: false
+    lazy refcounts: false
+    corrupt: false
+    refcount bits: 16
+    compression type: COMPRESSION_TYPE
 No errors were found on the image.
 *** done
diff --git a/tests/qemu-iotests/065 b/tests/qemu-iotests/065
index b76701c71e..e329d5e6b6 100755
--- a/tests/qemu-iotests/065
+++ b/tests/qemu-iotests/065
@@ -90,8 +90,8 @@ class TestQCow2(TestQemuImgInfo):
     img_options =3D 'compat=3D0.10,compression_type=3Dzlib'
     json_compare =3D { 'compat': '0.10', 'refcount-bits': 16,
                      'compression-type': 'zlib' }
-    human_compare =3D [ 'compat: 0.10', 'compression type: zlib',
-                      'refcount bits: 16' ]
+    human_compare =3D [ 'compat: 0.10', 'refcount bits: 16',
+                     'compression type: zlib' ]
=20
 class TestQCow3NotLazy(TestQemuImgInfo):
     '''Testing a qcow2 version 3 image with lazy refcounts disabled'''
@@ -105,9 +105,10 @@ class TestQCow3NotLazy(TestQemuImgInfo):
     json_compare =3D { 'compat': '1.1', 'lazy-refcounts': False,
                      'refcount-bits': 16, 'corrupt': False,
                      'compression-type': compression_type, 'extended-l2': =
False }
-    human_compare =3D [ 'compat: 1.1', f'compression type: {compression_ty=
pe}',
-                      'lazy refcounts: false', 'refcount bits: 16',
-                      'corrupt: false', 'extended l2: false' ]
+    human_compare =3D [ 'compat: 1.1', 'extended l2: false',
+                      'lazy refcounts: false', 'corrupt: false',
+                      'refcount bits: 16',
+                      f'compression type: {compression_type}' ]
=20
 class TestQCow3Lazy(TestQemuImgInfo):
     '''Testing a qcow2 version 3 image with lazy refcounts enabled'''
@@ -115,9 +116,9 @@ class TestQCow3Lazy(TestQemuImgInfo):
     json_compare =3D { 'compat': '1.1', 'lazy-refcounts': True,
                      'refcount-bits': 16, 'corrupt': False,
                      'compression-type': 'zlib', 'extended-l2': False }
-    human_compare =3D [ 'compat: 1.1', 'compression type: zlib',
-                      'lazy refcounts: true', 'refcount bits: 16',
-                      'corrupt: false', 'extended l2: false' ]
+    human_compare =3D [ 'compat: 1.1', 'extended l2: false',
+                     'lazy refcounts: true', 'corrupt: false',
+                     'refcount bits: 16', 'compression type: zlib' ]
=20
 class TestQCow3NotLazyQMP(TestQMP):
     '''Testing a qcow2 version 3 image with lazy refcounts disabled, openi=
ng
diff --git a/tests/qemu-iotests/071.out b/tests/qemu-iotests/071.out
index bca0c02f5c..ff00da1ad1 100644
--- a/tests/qemu-iotests/071.out
+++ b/tests/qemu-iotests/071.out
@@ -46,7 +46,7 @@ QMP_VERSION
 read failed: Input/output error
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"event": "SHUTDOWN", "timestamp": {"seconds":  TIMESTAMP, "microseconds":=
  TIMESTAMP}, "data": {"guest": false, "reason": "host-qmp-quit"}}
=20
=20
 =3D=3D=3D Testing blkverify on existing block device =3D=3D=3D
@@ -85,7 +85,7 @@ wrote 512/512 bytes at offset 0
 read failed: Input/output error
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"event": "SHUTDOWN", "timestamp": {"seconds":  TIMESTAMP, "microseconds":=
  TIMESTAMP}, "data": {"guest": false, "reason": "host-qmp-quit"}}
 QEMU_PROG: Failed to flush the L2 table cache: Input/output error
 QEMU_PROG: Failed to flush the refcount block cache: Input/output error
=20
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index d0dd333117..0617ae4d30 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -17,11 +17,11 @@ virtual size: 128 MiB (134217728 bytes)
 cluster_size: 4096
 Format specific information:
     compat: 1.1
-    compression type: COMPRESSION_TYPE
+    extended l2: false
     lazy refcounts: true
-    refcount bits: 16
     corrupt: false
-    extended l2: false
+    refcount bits: 16
+    compression type: COMPRESSION_TYPE
=20
 Testing: create -f qcow2 -o cluster_size=3D4k -o lazy_refcounts=3Don -o cl=
uster_size=3D8k TEST_DIR/t.qcow2 128M
 Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D8192 extended_l2=
=3Doff compression_type=3Dzlib size=3D134217728 lazy_refcounts=3Don refcoun=
t_bits=3D16
@@ -31,11 +31,11 @@ virtual size: 128 MiB (134217728 bytes)
 cluster_size: 8192
 Format specific information:
     compat: 1.1
-    compression type: COMPRESSION_TYPE
+    extended l2: false
     lazy refcounts: true
-    refcount bits: 16
     corrupt: false
-    extended l2: false
+    refcount bits: 16
+    compression type: COMPRESSION_TYPE
=20
 Testing: create -f qcow2 -o cluster_size=3D4k,cluster_size=3D8k TEST_DIR/t=
.qcow2 128M
 Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 cluster_size=3D8192 extended_l2=
=3Doff compression_type=3Dzlib size=3D134217728 lazy_refcounts=3Doff refcou=
nt_bits=3D16
@@ -329,11 +329,11 @@ virtual size: 128 MiB (134217728 bytes)
 cluster_size: 4096
 Format specific information:
     compat: 1.1
-    compression type: COMPRESSION_TYPE
+    extended l2: false
     lazy refcounts: true
-    refcount bits: 16
     corrupt: false
-    extended l2: false
+    refcount bits: 16
+    compression type: COMPRESSION_TYPE
=20
 Testing: convert -O qcow2 -o cluster_size=3D4k -o lazy_refcounts=3Don -o c=
luster_size=3D8k TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 image: TEST_DIR/t.IMGFMT.base
@@ -342,11 +342,11 @@ virtual size: 128 MiB (134217728 bytes)
 cluster_size: 8192
 Format specific information:
     compat: 1.1
-    compression type: COMPRESSION_TYPE
+    extended l2: false
     lazy refcounts: true
-    refcount bits: 16
     corrupt: false
-    extended l2: false
+    refcount bits: 16
+    compression type: COMPRESSION_TYPE
=20
 Testing: convert -O qcow2 -o cluster_size=3D4k,cluster_size=3D8k TEST_DIR/=
t.qcow2 TEST_DIR/t.qcow2.base
 image: TEST_DIR/t.IMGFMT.base
@@ -639,11 +639,11 @@ virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
-    compression type: COMPRESSION_TYPE
+    extended l2: false
     lazy refcounts: true
-    refcount bits: 16
     corrupt: false
-    extended l2: false
+    refcount bits: 16
+    compression type: COMPRESSION_TYPE
=20
 Testing: amend -f qcow2 -o size=3D130M -o lazy_refcounts=3Doff TEST_DIR/t.=
qcow2
 image: TEST_DIR/t.IMGFMT
@@ -652,11 +652,11 @@ virtual size: 130 MiB (136314880 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
-    compression type: COMPRESSION_TYPE
+    extended l2: false
     lazy refcounts: false
-    refcount bits: 16
     corrupt: false
-    extended l2: false
+    refcount bits: 16
+    compression type: COMPRESSION_TYPE
=20
 Testing: amend -f qcow2 -o size=3D8M -o lazy_refcounts=3Don -o size=3D132M=
 TEST_DIR/t.qcow2
 image: TEST_DIR/t.IMGFMT
@@ -665,11 +665,11 @@ virtual size: 132 MiB (138412032 bytes)
 cluster_size: 65536
 Format specific information:
     compat: 1.1
-    compression type: COMPRESSION_TYPE
+    extended l2: false
     lazy refcounts: true
-    refcount bits: 16
     corrupt: false
-    extended l2: false
+    refcount bits: 16
+    compression type: COMPRESSION_TYPE
=20
 Testing: amend -f qcow2 -o size=3D4M,size=3D148M TEST_DIR/t.qcow2
 image: TEST_DIR/t.IMGFMT
diff --git a/tests/qemu-iotests/095.out b/tests/qemu-iotests/095.out
index 8257c5e1e6..b952051f16 100644
--- a/tests/qemu-iotests/095.out
+++ b/tests/qemu-iotests/095.out
@@ -15,14 +15,14 @@ virtual size: 5 MiB (5242880 bytes)
 { 'execute': 'block-commit',
                                  'arguments': { 'device': 'test',
                                  'top': 'TEST_DIR/t.IMGFMT.snp1' } }
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "test"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "test"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "test", "status": "created"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "test", "status": "running"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "test"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "test"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "test", "len": 104857600, "offs=
et": 104857600, "speed": 0, "type": "commit"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "test"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "test"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "test", "status": "waiting"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "test", "status": "pending"}}
+{"event": "BLOCK_JOB_COMPLETED", "timestamp": {"seconds":  TIMESTAMP, "mic=
roseconds":  TIMESTAMP}, "data": {"type": "commit", "device": "test", "len"=
: 104857600, "offset": 104857600, "speed": 0}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "test", "status": "concluded"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "test", "status": "null"}}
=20
 =3D=3D=3D Base image info after commit and resize =3D=3D=3D
 image: TEST_DIR/t.IMGFMT.base
diff --git a/tests/qemu-iotests/099.out b/tests/qemu-iotests/099.out
index 8cce627529..5726466bc6 100644
--- a/tests/qemu-iotests/099.out
+++ b/tests/qemu-iotests/099.out
@@ -12,11 +12,11 @@ blkverify:TEST_DIR/t.IMGFMT.compare:TEST_DIR/t.IMGFMT
=20
 =3D=3D=3D Testing JSON filename for blkdebug =3D=3D=3D
=20
-json:{"driver": "IMGFMT", "file": {"image": {"driver": "file", "filename":=
 "TEST_DIR/t.IMGFMT"}, "driver": "blkdebug", "inject-error.0.event": "l1_up=
date"}}
+json:{"driver": "IMGFMT", "file": {"driver": "blkdebug", "inject-error.0.e=
vent": "l1_update", "image": {"driver": "file", "filename": "TEST_DIR/t.IMG=
FMT"}}}
=20
 =3D=3D=3D Testing indirectly enforced JSON filename =3D=3D=3D
=20
-json:{"driver": "raw", "file": {"test": {"driver": "IMGFMT", "file": {"ima=
ge": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driver": "blkdeb=
ug", "inject-error.0.event": "l1_update"}}, "driver": "blkverify", "raw": {=
"driver": "file", "filename": "TEST_DIR/t.IMGFMT.compare"}}}
+json:{"driver": "raw", "file": {"driver": "blkverify", "test": {"driver": =
"IMGFMT", "file": {"driver": "blkdebug", "inject-error.0.event": "l1_update=
", "image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}}}, "raw": {=
"driver": "file", "filename": "TEST_DIR/t.IMGFMT.compare"}}}
=20
 =3D=3D=3D Testing plain filename for blkdebug =3D=3D=3D
=20
diff --git a/tests/qemu-iotests/108.out b/tests/qemu-iotests/108.out
index b5401d788d..faaabbcdf3 100644
--- a/tests/qemu-iotests/108.out
+++ b/tests/qemu-iotests/108.out
@@ -163,18 +163,18 @@ OK: Reftable is where we expect it
                "size": 67108864,
                "cluster-size": 512
            } } }
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "create"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "create"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "create", "status": "created"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "create", "status": "running"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "create"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "create"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "create"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "create", "status": "waiting"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "create", "status": "pending"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "create", "status": "concluded"}}
 { "execute": "job-dismiss", "arguments": { "id": "create" } }
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "create"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "create", "status": "null"}}
 {"return": {}}
 { "execute": "quit" }
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"event": "SHUTDOWN", "timestamp": {"seconds":  TIMESTAMP, "microseconds":=
  TIMESTAMP}, "data": {"guest": false, "reason": "host-qmp-quit"}}
=20
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/117.out b/tests/qemu-iotests/117.out
index 735ffd25c6..015c971197 100644
--- a/tests/qemu-iotests/117.out
+++ b/tests/qemu-iotests/117.out
@@ -19,7 +19,7 @@ wrote 65536/65536 bytes at offset 0
 {"return": ""}
 { 'execute': 'quit' }
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"event": "SHUTDOWN", "timestamp": {"seconds":  TIMESTAMP, "microseconds":=
  TIMESTAMP}, "data": {"guest": false, "reason": "host-qmp-quit"}}
 No errors were found on the image.
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/120.out b/tests/qemu-iotests/120.out
index 0744c1f136..d677c72599 100644
--- a/tests/qemu-iotests/120.out
+++ b/tests/qemu-iotests/120.out
@@ -6,7 +6,7 @@ wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"event": "SHUTDOWN", "timestamp": {"seconds":  TIMESTAMP, "microseconds":=
  TIMESTAMP}, "data": {"guest": false, "reason": "host-qmp-quit"}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 0
diff --git a/tests/qemu-iotests/127.out b/tests/qemu-iotests/127.out
index 1685c4850a..863832d162 100644
--- a/tests/qemu-iotests/127.out
+++ b/tests/qemu-iotests/127.out
@@ -14,20 +14,20 @@ wrote 42/42 bytes at offset 0
            'mode':   'existing',
            'sync':   'top'
        } }
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "mirror"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "mirror"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "mirror", "status": "created"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "mirror", "status": "running"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "mirror"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_READY", "data": {"device": "mirror", "len": 65536, "offset": 6=
5536, "speed": 0, "type": "mirror"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "mirror", "status": "ready"}}
+{"event": "BLOCK_JOB_READY", "timestamp": {"seconds":  TIMESTAMP, "microse=
conds":  TIMESTAMP}, "data": {"type": "mirror", "device": "mirror", "len": =
65536, "offset": 65536, "speed": 0}}
 { 'execute': 'block-job-complete',
        'arguments': { 'device': 'mirror' } }
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "mirror"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "mirror"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "mirror", "len": 65536, "offset=
": 65536, "speed": 0, "type": "mirror"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "mirror", "status": "waiting"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "mirror", "status": "pending"}}
+{"event": "BLOCK_JOB_COMPLETED", "timestamp": {"seconds":  TIMESTAMP, "mic=
roseconds":  TIMESTAMP}, "data": {"type": "mirror", "device": "mirror", "le=
n": 65536, "offset": 65536, "speed": 0}}
 { 'execute': 'quit' }
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "mirror"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "mirror"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "mirror", "status": "concluded"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "mirror", "status": "null"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"event": "SHUTDOWN", "timestamp": {"seconds":  TIMESTAMP, "microseconds":=
  TIMESTAMP}, "data": {"guest": false, "reason": "host-qmp-quit"}}
 *** done
diff --git a/tests/qemu-iotests/140.out b/tests/qemu-iotests/140.out
index 312f76d5da..586b64b24e 100644
--- a/tests/qemu-iotests/140.out
+++ b/tests/qemu-iotests/140.out
@@ -15,10 +15,10 @@ read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'eject',
        'arguments': { 'device': 'drv' }}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_EXPORT_DELETED", "data": {"id": "drv"}}
+{"event": "BLOCK_EXPORT_DELETED", "timestamp": {"seconds":  TIMESTAMP, "mi=
croseconds":  TIMESTAMP}, "data": {"id": "drv"}}
 qemu-io: can't open device nbd+unix:///drv?socket=3DSOCK_DIR/nbd: Requeste=
d export not available
 server reported: export 'drv' not present
 { 'execute': 'quit' }
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"event": "SHUTDOWN", "timestamp": {"seconds":  TIMESTAMP, "microseconds":=
  TIMESTAMP}, "data": {"guest": false, "reason": "host-qmp-quit"}}
 *** done
diff --git a/tests/qemu-iotests/141.out b/tests/qemu-iotests/141.out
index 63203d9944..4d8c7b598c 100644
--- a/tests/qemu-iotests/141.out
+++ b/tests/qemu-iotests/141.out
@@ -23,20 +23,20 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D104=
8576 backing_file=3DTEST_DIR/m.
 'format': 'IMGFMT',
 'sync': 'none'}}
 Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT backing_fmt=3DIMGFMT
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "created"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "running"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "paused"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "running"}}
 {'execute': 'blockdev-del',
           'arguments': {'node-name': 'drv0'}}
 {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: node is =
used as backing hd of 'NODE_NAME'"}}
 {'execute': 'block-job-cancel',
           'arguments': {'device': 'job0'}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_CANCELLED", "data": {"device": "job0", "len": 1048576, "offset=
": 0, "speed": 0, "type": "backup"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "aborting"}}
+{"event": "BLOCK_JOB_CANCELLED", "timestamp": {"seconds":  TIMESTAMP, "mic=
roseconds":  TIMESTAMP}, "data": {"type": "backup", "device": "job0", "len"=
: 1048576, "offset": 0, "speed": 0}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "concluded"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "null"}}
 {'execute': 'blockdev-del',
           'arguments': {'node-name': 'drv0'}}
 {"return": {}}
@@ -59,21 +59,21 @@ Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D104=
8576 backing_file=3DTEST_DIR/t.
 'format': 'IMGFMT',
 'sync': 'none'}}
 Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT backing_fmt=3DIMGFMT
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_READY", "data": {"device": "job0", "len": 0, "offset": 0, "spe=
ed": 0, "type": "mirror"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "created"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "running"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "ready"}}
+{"event": "BLOCK_JOB_READY", "timestamp": {"seconds":  TIMESTAMP, "microse=
conds":  TIMESTAMP}, "data": {"type": "mirror", "device": "job0", "len": 0,=
 "offset": 0, "speed": 0}}
 {'execute': 'blockdev-del',
           'arguments': {'node-name': 'drv0'}}
 {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: block de=
vice is in use by block job: mirror"}}
 {'execute': 'block-job-cancel',
           'arguments': {'device': 'job0'}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "job0", "len": 0, "offset": 0, =
"speed": 0, "type": "mirror"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "waiting"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "pending"}}
+{"event": "BLOCK_JOB_COMPLETED", "timestamp": {"seconds":  TIMESTAMP, "mic=
roseconds":  TIMESTAMP}, "data": {"type": "mirror", "device": "job0", "len"=
: 0, "offset": 0, "speed": 0}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "concluded"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "null"}}
 {'execute': 'blockdev-del',
           'arguments': {'node-name': 'drv0'}}
 {"return": {}}
@@ -91,21 +91,21 @@ Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D104=
8576 backing_file=3DTEST_DIR/t.
 {"return": {}}
 {'execute': 'block-commit',
 'arguments': {'job-id': 'job0', 'device': 'drv0'}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_READY", "data": {"device": "job0", "len": 0, "offset": 0, "spe=
ed": 0, "type": "commit"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "created"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "running"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "ready"}}
+{"event": "BLOCK_JOB_READY", "timestamp": {"seconds":  TIMESTAMP, "microse=
conds":  TIMESTAMP}, "data": {"type": "commit", "device": "job0", "len": 0,=
 "offset": 0, "speed": 0}}
 {'execute': 'blockdev-del',
           'arguments': {'node-name': 'drv0'}}
 {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: block de=
vice is in use by block job: commit"}}
 {'execute': 'block-job-cancel',
           'arguments': {'device': 'job0'}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "job0", "len": 0, "offset": 0, =
"speed": 0, "type": "commit"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "waiting"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "pending"}}
+{"event": "BLOCK_JOB_COMPLETED", "timestamp": {"seconds":  TIMESTAMP, "mic=
roseconds":  TIMESTAMP}, "data": {"type": "commit", "device": "job0", "len"=
: 0, "offset": 0, "speed": 0}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "concluded"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "null"}}
 {'execute': 'blockdev-del',
           'arguments': {'node-name': 'drv0'}}
 {"return": {}}
@@ -128,18 +128,18 @@ wrote 1048576/1048576 bytes at offset 0
 'device': 'drv0',
 'top':    'TEST_DIR/m.IMGFMT',
 'speed':  1}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "created"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "running"}}
 {'execute': 'blockdev-del',
           'arguments': {'node-name': 'drv0'}}
 {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: block de=
vice is in use by block job: commit"}}
 {'execute': 'block-job-cancel',
           'arguments': {'device': 'job0'}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_CANCELLED", "data": {"device": "job0", "len": 1048576, "offset=
": 524288, "speed": 1, "type": "commit"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "aborting"}}
+{"event": "BLOCK_JOB_CANCELLED", "timestamp": {"seconds":  TIMESTAMP, "mic=
roseconds":  TIMESTAMP}, "data": {"type": "commit", "device": "job0", "len"=
: 1048576, "offset": 524288, "speed": 1}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "concluded"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "null"}}
 {'execute': 'blockdev-del',
           'arguments': {'node-name': 'drv0'}}
 {"return": {}}
@@ -161,18 +161,18 @@ wrote 1048576/1048576 bytes at offset 0
 'arguments': {'job-id': 'job0',
 'device': 'drv0',
 'speed': 1}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "created"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "running"}}
 {'execute': 'blockdev-del',
           'arguments': {'node-name': 'drv0'}}
 {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: block de=
vice is in use by block job: stream"}}
 {'execute': 'block-job-cancel',
           'arguments': {'device': 'job0'}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_CANCELLED", "data": {"device": "job0", "len": 1048576, "offset=
": 524288, "speed": 1, "type": "stream"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "aborting"}}
+{"event": "BLOCK_JOB_CANCELLED", "timestamp": {"seconds":  TIMESTAMP, "mic=
roseconds":  TIMESTAMP}, "data": {"type": "stream", "device": "job0", "len"=
: 1048576, "offset": 524288, "speed": 1}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "concluded"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "null"}}
 {'execute': 'blockdev-del',
           'arguments': {'node-name': 'drv0'}}
 {"return": {}}
diff --git a/tests/qemu-iotests/143.out b/tests/qemu-iotests/143.out
index 9ec5888e0e..ec58b08e43 100644
--- a/tests/qemu-iotests/143.out
+++ b/tests/qemu-iotests/143.out
@@ -11,5 +11,5 @@ qemu-io: can't open device nbd+unix:///aa--aa1?socket=3DS=
OCK_DIR/nbd: Requested ex
 server reported: export 'aa--aa...' not present
 { 'execute': 'quit' }
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"event": "SHUTDOWN", "timestamp": {"seconds":  TIMESTAMP, "microseconds":=
  TIMESTAMP}, "data": {"guest": false, "reason": "host-qmp-quit"}}
 *** done
diff --git a/tests/qemu-iotests/144.out b/tests/qemu-iotests/144.out
index b3b4812015..49ce8c6316 100644
--- a/tests/qemu-iotests/144.out
+++ b/tests/qemu-iotests/144.out
@@ -25,22 +25,22 @@ Formatting 'TEST_DIR/tmp.qcow2', fmt=3Dqcow2 cluster_si=
ze=3D65536 extended_l2=3Doff co
                                                  'device': 'virtio0'
                                               }
                     }
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "virtio0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "virtio0"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "virtio0", "status": "created"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "virtio0", "status": "running"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "virtio0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_READY", "data": {"device": "virtio0", "len": 0, "offset": 0, "=
speed": 0, "type": "commit"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "virtio0", "status": "ready"}}
+{"event": "BLOCK_JOB_READY", "timestamp": {"seconds":  TIMESTAMP, "microse=
conds":  TIMESTAMP}, "data": {"type": "commit", "device": "virtio0", "len":=
 0, "offset": 0, "speed": 0}}
 { 'execute': 'block-job-complete',
                                 'arguments': {
                                                 'device': 'virtio0'
                                               }
                    }
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "virtio0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "virtio0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "virtio0", "len": 0, "offset": =
0, "speed": 0, "type": "commit"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "virtio0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "virtio0"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "virtio0", "status": "waiting"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "virtio0", "status": "pending"}}
+{"event": "BLOCK_JOB_COMPLETED", "timestamp": {"seconds":  TIMESTAMP, "mic=
roseconds":  TIMESTAMP}, "data": {"type": "commit", "device": "virtio0", "l=
en": 0, "offset": 0, "speed": 0}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "virtio0", "status": "concluded"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "virtio0", "status": "null"}}
=20
 =3D=3D=3D Performing Live Snapshot 2 =3D=3D=3D
=20
diff --git a/tests/qemu-iotests/156.out b/tests/qemu-iotests/156.out
index 4a22f0c41a..bb01818fc7 100644
--- a/tests/qemu-iotests/156.out
+++ b/tests/qemu-iotests/156.out
@@ -26,11 +26,11 @@ Formatting 'TEST_DIR/t.IMGFMT.target.overlay', fmt=3DIM=
GFMT size=3D1048576 backing_f
                       'target': 'TEST_DIR/t.IMGFMT.target.overlay',
                       'mode': 'existing',
                       'sync': 'top' } }
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "source"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "source"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "source", "status": "created"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "source", "status": "running"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "source"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_READY", "data": {"device": "source", "len": 131072, "offset": =
131072, "speed": 0, "type": "mirror"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "source", "status": "ready"}}
+{"event": "BLOCK_JOB_READY", "timestamp": {"seconds":  TIMESTAMP, "microse=
conds":  TIMESTAMP}, "data": {"type": "mirror", "device": "source", "len": =
131072, "offset": 131072, "speed": 0}}
 { 'execute': 'human-monitor-command',
        'arguments': { 'command-line':
                       'qemu-io source "write -P 4 192k 64k"' } }
@@ -40,11 +40,11 @@ wrote 65536/65536 bytes at offset 196608
 { 'execute': 'block-job-complete',
        'arguments': { 'device': 'source' } }
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "source"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "source"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "source", "len": 196608, "offse=
t": 196608, "speed": 0, "type": "mirror"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "source"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "source"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "source", "status": "waiting"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "source", "status": "pending"}}
+{"event": "BLOCK_JOB_COMPLETED", "timestamp": {"seconds":  TIMESTAMP, "mic=
roseconds":  TIMESTAMP}, "data": {"type": "mirror", "device": "source", "le=
n": 196608, "offset": 196608, "speed": 0}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "source", "status": "concluded"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "source", "status": "null"}}
=20
 { 'execute': 'human-monitor-command',
        'arguments': { 'command-line':
@@ -73,7 +73,7 @@ read 65536/65536 bytes at offset 196608
=20
 { 'execute': 'quit' }
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"event": "SHUTDOWN", "timestamp": {"seconds":  TIMESTAMP, "microseconds":=
  TIMESTAMP}, "data": {"guest": false, "reason": "host-qmp-quit"}}
=20
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/161.out b/tests/qemu-iotests/161.out
index 6cc285afcf..c62657639a 100644
--- a/tests/qemu-iotests/161.out
+++ b/tests/qemu-iotests/161.out
@@ -18,17 +18,17 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D104=
8576 backing_file=3DTEST_DIR/t.
 {"return": {}}
 { 'execute': 'block-stream',        'arguments': { 'device': 'none0',
                       'base': 'TEST_DIR/t.IMGFMT.base' } }
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "none0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "none0"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "none0", "status": "created"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "none0", "status": "running"}}
 {"return": {}}
 { 'execute': 'human-monitor-command',
        'arguments': { 'command-line':
                       'qemu-io none0 "reopen -o backing.detect-zeroes=3Don=
"' } }
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "none0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "none0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "none0", "len": 1048576, "offse=
t": 1048576, "speed": 0, "type": "stream"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "none0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "none0"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "none0", "status": "waiting"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "none0", "status": "pending"}}
+{"event": "BLOCK_JOB_COMPLETED", "timestamp": {"seconds":  TIMESTAMP, "mic=
roseconds":  TIMESTAMP}, "data": {"type": "stream", "device": "none0", "len=
": 1048576, "offset": 1048576, "speed": 0}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "none0", "status": "concluded"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "none0", "status": "null"}}
 {"return": ""}
=20
 *** Commit and then change an option on the backing file
@@ -40,16 +40,16 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D104=
8576 backing_file=3DTEST_DIR/t.
 {"return": {}}
 { 'execute': 'block-commit',        'arguments': { 'device': 'none0',
                       'top': 'TEST_DIR/t.IMGFMT.int' } }
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "none0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "none0"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "none0", "status": "created"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "none0", "status": "running"}}
 {"return": {}}
 { 'execute': 'human-monitor-command',
        'arguments': { 'command-line':
                       'qemu-io none0 "reopen -o backing.detect-zeroes=3Don=
"' } }
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "none0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "none0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "none0", "len": 1048576, "offse=
t": 1048576, "speed": 0, "type": "commit"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "none0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "none0"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "none0", "status": "waiting"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "none0", "status": "pending"}}
+{"event": "BLOCK_JOB_COMPLETED", "timestamp": {"seconds":  TIMESTAMP, "mic=
roseconds":  TIMESTAMP}, "data": {"type": "commit", "device": "none0", "len=
": 1048576, "offset": 1048576, "speed": 0}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "none0", "status": "concluded"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "none0", "status": "null"}}
 {"return": ""}
 *** done
diff --git a/tests/qemu-iotests/176.out b/tests/qemu-iotests/176.out
index 9d09b60452..b46b743850 100644
--- a/tests/qemu-iotests/176.out
+++ b/tests/qemu-iotests/176.out
@@ -170,7 +170,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"event": "SHUTDOWN", "timestamp": {"seconds":  TIMESTAMP, "microseconds":=
  TIMESTAMP}, "data": {"guest": false, "reason": "host-qmp-quit"}}
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -207,7 +207,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {"sha256": HASH}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"event": "SHUTDOWN", "timestamp": {"seconds":  TIMESTAMP, "microseconds":=
  TIMESTAMP}, "data": {"guest": false, "reason": "host-qmp-quit"}}
=20
 =3D=3D=3D Test pass bitmap.1 =3D=3D=3D
=20
@@ -219,7 +219,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"event": "SHUTDOWN", "timestamp": {"seconds":  TIMESTAMP, "microseconds":=
  TIMESTAMP}, "data": {"guest": false, "reason": "host-qmp-quit"}}
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -257,7 +257,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {"sha256": HASH}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"event": "SHUTDOWN", "timestamp": {"seconds":  TIMESTAMP, "microseconds":=
  TIMESTAMP}, "data": {"guest": false, "reason": "host-qmp-quit"}}
=20
 =3D=3D=3D Test pass bitmap.2 =3D=3D=3D
=20
@@ -269,7 +269,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"event": "SHUTDOWN", "timestamp": {"seconds":  TIMESTAMP, "microseconds":=
  TIMESTAMP}, "data": {"guest": false, "reason": "host-qmp-quit"}}
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -307,7 +307,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {"sha256": HASH}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"event": "SHUTDOWN", "timestamp": {"seconds":  TIMESTAMP, "microseconds":=
  TIMESTAMP}, "data": {"guest": false, "reason": "host-qmp-quit"}}
=20
 =3D=3D=3D Test pass bitmap.3 =3D=3D=3D
=20
@@ -319,7 +319,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"event": "SHUTDOWN", "timestamp": {"seconds":  TIMESTAMP, "microseconds":=
  TIMESTAMP}, "data": {"guest": false, "reason": "host-qmp-quit"}}
 wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 131072/131072 bytes at offset 2147352576
@@ -354,5 +354,5 @@ QMP_VERSION
 {"return": {}}
 {"return": {"sha256": HASH}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"event": "SHUTDOWN", "timestamp": {"seconds":  TIMESTAMP, "microseconds":=
  TIMESTAMP}, "data": {"guest": false, "reason": "host-qmp-quit"}}
 *** done
diff --git a/tests/qemu-iotests/183.out b/tests/qemu-iotests/183.out
index fd9c2e52a5..3d34cc5033 100644
--- a/tests/qemu-iotests/183.out
+++ b/tests/qemu-iotests/183.out
@@ -30,13 +30,13 @@ read 65536/65536 bytes at offset 0
        'arguments': { 'uri': 'unix:SOCK_DIR/migrate', 'blk': true } }
 {"return": {}}
 { 'execute': 'query-status' }
-{"return": {"status": "postmigrate", "singlestep": false, "running": false=
}}
+{"return": {"running": false, "singlestep": false, "status": "postmigrate"=
}}
=20
 =3D=3D=3D Do some I/O on the destination =3D=3D=3D
=20
 { 'execute': 'query-status' }
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "RESUME"}
-{"return": {"status": "running", "singlestep": false, "running": true}}
+{"event": "RESUME", "timestamp": {"seconds":  TIMESTAMP, "microseconds":  =
TIMESTAMP}}
+{"return": {"running": true, "singlestep": false, "status": "running"}}
 { 'execute': 'human-monitor-command',
        'arguments': { 'command-line':
                       'qemu-io disk "read -P 0x55 0 64k"' } }
@@ -56,8 +56,8 @@ wrote 65536/65536 bytes at offset 1048576
 {"return": {}}
 {"execute":"quit"}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"event": "SHUTDOWN", "timestamp": {"seconds":  TIMESTAMP, "microseconds":=
  TIMESTAMP}, "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"event": "SHUTDOWN", "timestamp": {"seconds":  TIMESTAMP, "microseconds":=
  TIMESTAMP}, "data": {"guest": false, "reason": "host-qmp-quit"}}
 No errors were found on the image.
 No errors were found on the image.
 wrote 65536/65536 bytes at offset 1048576
diff --git a/tests/qemu-iotests/184.out b/tests/qemu-iotests/184.out
index 77e5489d65..93e33ba20a 100644
--- a/tests/qemu-iotests/184.out
+++ b/tests/qemu-iotests/184.out
@@ -24,64 +24,64 @@ Testing:
 {
     "return": [
         {
-            "iops_rd": 0,
+            "file": "json:{\"driver\": \"throttle\", \"throttle-group\": \=
"group0\", \"file\": {\"driver\": \"null-co\"}}",
+            "node-name": "throttle0",
+            "ro": false,
+            "drv": "throttle",
+            "backing_file_depth": 1,
+            "encrypted": false,
             "detect_zeroes": "off",
+            "bps": 0,
+            "bps_rd": 0,
+            "bps_wr": 0,
+            "iops": 0,
+            "iops_rd": 0,
+            "iops_wr": 0,
             "image": {
+                "filename": "json:{\"driver\": \"throttle\", \"throttle-gr=
oup\": \"group0\", \"file\": {\"driver\": \"null-co\"}}",
+                "format": "throttle",
+                "actual-size": 0,
+                "virtual-size": 1073741824,
                 "backing-image": {
-                    "virtual-size": 1073741824,
                     "filename": "null-co://",
                     "format": "null-co",
-                    "actual-size": 0
-                },
-                "virtual-size": 1073741824,
-                "filename": "json:{\"throttle-group\": \"group0\", \"drive=
r\": \"throttle\", \"file\": {\"driver\": \"null-co\"}}",
-                "format": "throttle",
-                "actual-size": 0
+                    "actual-size": 0,
+                    "virtual-size": 1073741824
+                }
             },
-            "iops_wr": 0,
-            "ro": false,
-            "node-name": "throttle0",
-            "backing_file_depth": 1,
-            "drv": "throttle",
-            "iops": 0,
-            "bps_wr": 0,
-            "write_threshold": 0,
-            "encrypted": false,
-            "bps": 0,
-            "bps_rd": 0,
             "cache": {
-                "no-flush": false,
+                "writeback": true,
                 "direct": false,
-                "writeback": true
+                "no-flush": false
             },
-            "file": "json:{\"throttle-group\": \"group0\", \"driver\": \"t=
hrottle\", \"file\": {\"driver\": \"null-co\"}}"
+            "write_threshold": 0
         },
         {
-            "iops_rd": 0,
-            "detect_zeroes": "off",
-            "image": {
-                "virtual-size": 1073741824,
-                "filename": "null-co://",
-                "format": "null-co",
-                "actual-size": 0
-            },
-            "iops_wr": 0,
-            "ro": false,
+            "file": "null-co://",
             "node-name": "disk0",
-            "backing_file_depth": 0,
+            "ro": false,
             "drv": "null-co",
-            "iops": 0,
-            "bps_wr": 0,
-            "write_threshold": 0,
+            "backing_file_depth": 0,
             "encrypted": false,
+            "detect_zeroes": "off",
             "bps": 0,
             "bps_rd": 0,
+            "bps_wr": 0,
+            "iops": 0,
+            "iops_rd": 0,
+            "iops_wr": 0,
+            "image": {
+                "filename": "null-co://",
+                "format": "null-co",
+                "actual-size": 0,
+                "virtual-size": 1073741824
+            },
             "cache": {
-                "no-flush": false,
+                "writeback": true,
                 "direct": false,
-                "writeback": true
+                "no-flush": false
             },
-            "file": "null-co://"
+            "write_threshold": 0
         }
     ]
 }
@@ -94,11 +94,11 @@ Testing:
     }
 }
 {
+    "event": "SHUTDOWN",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "SHUTDOWN",
     "data": {
         "guest": false,
         "reason": "host-qmp-quit"
@@ -121,25 +121,25 @@ Testing:
 }
 {
     "return": {
-        "bps-read-max-length": 1,
-        "iops-read-max-length": 1,
-        "bps-read-max": 0,
-        "bps-total": 0,
-        "iops-total-max-length": 1,
         "iops-total": 1000,
-        "iops-write-max": 0,
-        "bps-write": 0,
-        "bps-total-max": 0,
-        "bps-write-max": 0,
-        "iops-size": 0,
+        "iops-total-max": 0,
+        "iops-total-max-length": 1,
         "iops-read": 0,
-        "iops-write-max-length": 1,
+        "iops-read-max": 0,
+        "iops-read-max-length": 1,
         "iops-write": 0,
+        "iops-write-max": 0,
+        "iops-write-max-length": 1,
+        "bps-total": 0,
+        "bps-total-max": 0,
         "bps-total-max-length": 1,
-        "iops-read-max": 0,
         "bps-read": 0,
+        "bps-read-max": 0,
+        "bps-read-max-length": 1,
+        "bps-write": 0,
+        "bps-write-max": 0,
         "bps-write-max-length": 1,
-        "iops-total-max": 0
+        "iops-size": 0
     }
 }
 {
@@ -148,25 +148,25 @@ Testing:
 }
 {
     "return": {
-        "bps-read-max-length": 1,
-        "iops-read-max-length": 1,
-        "bps-read-max": 0,
-        "bps-total": 0,
-        "iops-total-max-length": 1,
         "iops-total": 0,
-        "iops-write-max": 0,
-        "bps-write": 0,
-        "bps-total-max": 0,
-        "bps-write-max": 0,
-        "iops-size": 0,
+        "iops-total-max": 0,
+        "iops-total-max-length": 1,
         "iops-read": 0,
-        "iops-write-max-length": 1,
+        "iops-read-max": 0,
+        "iops-read-max-length": 1,
         "iops-write": 0,
+        "iops-write-max": 0,
+        "iops-write-max-length": 1,
+        "bps-total": 0,
+        "bps-total-max": 0,
         "bps-total-max-length": 1,
-        "iops-read-max": 0,
         "bps-read": 0,
+        "bps-read-max": 0,
+        "bps-read-max-length": 1,
+        "bps-write": 0,
+        "bps-write-max": 0,
         "bps-write-max-length": 1,
-        "iops-total-max": 0
+        "iops-size": 0
     }
 }
 {
@@ -174,11 +174,11 @@ Testing:
     }
 }
 {
+    "event": "SHUTDOWN",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "SHUTDOWN",
     "data": {
         "guest": false,
         "reason": "host-qmp-quit"
@@ -216,11 +216,11 @@ Testing:
     }
 }
 {
+    "event": "SHUTDOWN",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "SHUTDOWN",
     "data": {
         "guest": false,
         "reason": "host-qmp-quit"
@@ -252,11 +252,11 @@ Testing:
     }
 }
 {
+    "event": "SHUTDOWN",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "SHUTDOWN",
     "data": {
         "guest": false,
         "reason": "host-qmp-quit"
diff --git a/tests/qemu-iotests/186.out b/tests/qemu-iotests/186.out
index 01530040e5..12ea630222 100644
--- a/tests/qemu-iotests/186.out
+++ b/tests/qemu-iotests/186.out
@@ -57,7 +57,7 @@ qdev_id: [not inserted]
 Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -dev=
ice ide-hd,drive=3Dnull
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
+null: json:{"driver": "null-co", "read-zeroes": true} (null-co)
     Attached to:      /machine/peripheral-anon/device[N]
     Cache mode:       writeback
 (qemu) quit
@@ -65,7 +65,7 @@ null: json:{"read-zeroes": true, "driver": "null-co"} (nu=
ll-co)
 Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -dev=
ice ide-hd,drive=3Dnull,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
+null: json:{"driver": "null-co", "read-zeroes": true} (null-co)
     Attached to:      qdev_id
     Cache mode:       writeback
 (qemu) quit
@@ -73,7 +73,7 @@ null: json:{"read-zeroes": true, "driver": "null-co"} (nu=
ll-co)
 Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -dev=
ice scsi-hd,drive=3Dnull
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
+null: json:{"driver": "null-co", "read-zeroes": true} (null-co)
     Attached to:      /machine/peripheral-anon/device[N]
     Cache mode:       writeback
 (qemu) quit
@@ -81,7 +81,7 @@ null: json:{"read-zeroes": true, "driver": "null-co"} (nu=
ll-co)
 Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -dev=
ice scsi-hd,drive=3Dnull,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
+null: json:{"driver": "null-co", "read-zeroes": true} (null-co)
     Attached to:      qdev_id
     Cache mode:       writeback
 (qemu) quit
@@ -89,7 +89,7 @@ null: json:{"read-zeroes": true, "driver": "null-co"} (nu=
ll-co)
 Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -dev=
ice virtio-blk-pci,drive=3Dnull
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
+null: json:{"driver": "null-co", "read-zeroes": true} (null-co)
     Attached to:      /machine/peripheral-anon/device[N]/virtio-backend
     Cache mode:       writeback
 (qemu) quit
@@ -97,7 +97,7 @@ null: json:{"read-zeroes": true, "driver": "null-co"} (nu=
ll-co)
 Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -dev=
ice virtio-blk-pci,drive=3Dnull,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
+null: json:{"driver": "null-co", "read-zeroes": true} (null-co)
     Attached to:      /machine/peripheral/qdev_id/virtio-backend
     Cache mode:       writeback
 (qemu) quit
@@ -105,7 +105,7 @@ null: json:{"read-zeroes": true, "driver": "null-co"} (=
null-co)
 Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -dev=
ice floppy,drive=3Dnull
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
+null: json:{"driver": "null-co", "read-zeroes": true} (null-co)
     Attached to:      /machine/peripheral-anon/device[N]
     Removable device: not locked, tray closed
     Cache mode:       writeback
@@ -114,7 +114,7 @@ null: json:{"read-zeroes": true, "driver": "null-co"} (=
null-co)
 Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -dev=
ice floppy,drive=3Dnull,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
+null: json:{"driver": "null-co", "read-zeroes": true} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
@@ -123,7 +123,7 @@ null: json:{"read-zeroes": true, "driver": "null-co"} (=
null-co)
 Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -dev=
ice ide-cd,drive=3Dnull
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
+null: json:{"driver": "null-co", "read-zeroes": true} (null-co)
     Attached to:      /machine/peripheral-anon/device[N]
     Removable device: not locked, tray closed
     Cache mode:       writeback
@@ -132,7 +132,7 @@ null: json:{"read-zeroes": true, "driver": "null-co"} (=
null-co)
 Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -dev=
ice ide-cd,drive=3Dnull,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
+null: json:{"driver": "null-co", "read-zeroes": true} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
@@ -141,7 +141,7 @@ null: json:{"read-zeroes": true, "driver": "null-co"} (=
null-co)
 Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -dev=
ice scsi-cd,drive=3Dnull
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
+null: json:{"driver": "null-co", "read-zeroes": true} (null-co)
     Attached to:      /machine/peripheral-anon/device[N]
     Removable device: not locked, tray closed
     Cache mode:       writeback
@@ -150,7 +150,7 @@ null: json:{"read-zeroes": true, "driver": "null-co"} (=
null-co)
 Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull -dev=
ice scsi-cd,drive=3Dnull,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
+null: json:{"driver": "null-co", "read-zeroes": true} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
@@ -162,11 +162,11 @@ null: json:{"read-zeroes": true, "driver": "null-co"}=
 (null-co)
 Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnu=
ll -device ide-hd,drive=3Dnull,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
+none0 (null): json:{"driver": "null-co", "read-zeroes": "on"} (null-co)
     Removable device: not locked, tray closed
     Cache mode:       writeback
=20
-null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
+null: json:{"driver": "null-co", "read-zeroes": "on"} (null-co)
     Attached to:      qdev_id
     Cache mode:       writeback
 (qemu) quit
@@ -174,11 +174,11 @@ null: json:{"read-zeroes": "on", "driver": "null-co"}=
 (null-co)
 Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnu=
ll -device scsi-hd,drive=3Dnull,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
+none0 (null): json:{"driver": "null-co", "read-zeroes": "on"} (null-co)
     Removable device: not locked, tray closed
     Cache mode:       writeback
=20
-null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
+null: json:{"driver": "null-co", "read-zeroes": "on"} (null-co)
     Attached to:      qdev_id
     Cache mode:       writeback
 (qemu) quit
@@ -186,11 +186,11 @@ null: json:{"read-zeroes": "on", "driver": "null-co"}=
 (null-co)
 Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnu=
ll -device virtio-blk-pci,drive=3Dnull,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
+none0 (null): json:{"driver": "null-co", "read-zeroes": "on"} (null-co)
     Removable device: not locked, tray closed
     Cache mode:       writeback
=20
-null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
+null: json:{"driver": "null-co", "read-zeroes": "on"} (null-co)
     Attached to:      /machine/peripheral/qdev_id/virtio-backend
     Cache mode:       writeback
 (qemu) quit
@@ -198,11 +198,11 @@ null: json:{"read-zeroes": "on", "driver": "null-co"}=
 (null-co)
 Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnu=
ll -device floppy,drive=3Dnull,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
+none0 (null): json:{"driver": "null-co", "read-zeroes": "on"} (null-co)
     Removable device: not locked, tray closed
     Cache mode:       writeback
=20
-null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
+null: json:{"driver": "null-co", "read-zeroes": "on"} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
@@ -211,11 +211,11 @@ null: json:{"read-zeroes": "on", "driver": "null-co"}=
 (null-co)
 Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnu=
ll -device ide-cd,drive=3Dnull,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
+none0 (null): json:{"driver": "null-co", "read-zeroes": "on"} (null-co)
     Removable device: not locked, tray closed
     Cache mode:       writeback
=20
-null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
+null: json:{"driver": "null-co", "read-zeroes": "on"} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
@@ -224,11 +224,11 @@ null: json:{"read-zeroes": "on", "driver": "null-co"}=
 (null-co)
 Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnu=
ll -device scsi-cd,drive=3Dnull,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
+none0 (null): json:{"driver": "null-co", "read-zeroes": "on"} (null-co)
     Removable device: not locked, tray closed
     Cache mode:       writeback
=20
-null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
+null: json:{"driver": "null-co", "read-zeroes": "on"} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
@@ -240,7 +240,7 @@ null: json:{"read-zeroes": "on", "driver": "null-co"} (=
null-co)
 Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnu=
ll -device ide-hd,drive=3Dnone0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
+none0 (null): json:{"driver": "null-co", "read-zeroes": "on"} (null-co)
     Attached to:      /machine/peripheral-anon/device[N]
     Cache mode:       writeback
 (qemu) quit
@@ -248,7 +248,7 @@ none0 (null): json:{"read-zeroes": "on", "driver": "nul=
l-co"} (null-co)
 Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnu=
ll -device ide-hd,drive=3Dnone0,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
+none0 (null): json:{"driver": "null-co", "read-zeroes": "on"} (null-co)
     Attached to:      qdev_id
     Cache mode:       writeback
 (qemu) quit
@@ -256,7 +256,7 @@ none0 (null): json:{"read-zeroes": "on", "driver": "nul=
l-co"} (null-co)
 Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnu=
ll -device scsi-hd,drive=3Dnone0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
+none0 (null): json:{"driver": "null-co", "read-zeroes": "on"} (null-co)
     Attached to:      /machine/peripheral-anon/device[N]
     Cache mode:       writeback
 (qemu) quit
@@ -264,7 +264,7 @@ none0 (null): json:{"read-zeroes": "on", "driver": "nul=
l-co"} (null-co)
 Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnu=
ll -device scsi-hd,drive=3Dnone0,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
+none0 (null): json:{"driver": "null-co", "read-zeroes": "on"} (null-co)
     Attached to:      qdev_id
     Cache mode:       writeback
 (qemu) quit
@@ -272,7 +272,7 @@ none0 (null): json:{"read-zeroes": "on", "driver": "nul=
l-co"} (null-co)
 Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnu=
ll -device virtio-blk-pci,drive=3Dnone0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
+none0 (null): json:{"driver": "null-co", "read-zeroes": "on"} (null-co)
     Attached to:      /machine/peripheral-anon/device[N]/virtio-backend
     Cache mode:       writeback
 (qemu) quit
@@ -280,7 +280,7 @@ none0 (null): json:{"read-zeroes": "on", "driver": "nul=
l-co"} (null-co)
 Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnu=
ll -device virtio-blk-pci,drive=3Dnone0,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
+none0 (null): json:{"driver": "null-co", "read-zeroes": "on"} (null-co)
     Attached to:      /machine/peripheral/qdev_id/virtio-backend
     Cache mode:       writeback
 (qemu) quit
@@ -288,7 +288,7 @@ none0 (null): json:{"read-zeroes": "on", "driver": "nul=
l-co"} (null-co)
 Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnu=
ll -device floppy,drive=3Dnone0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
+none0 (null): json:{"driver": "null-co", "read-zeroes": "on"} (null-co)
     Attached to:      /machine/peripheral-anon/device[N]
     Removable device: not locked, tray closed
     Cache mode:       writeback
@@ -297,7 +297,7 @@ none0 (null): json:{"read-zeroes": "on", "driver": "nul=
l-co"} (null-co)
 Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnu=
ll -device floppy,drive=3Dnone0,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
+none0 (null): json:{"driver": "null-co", "read-zeroes": "on"} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
@@ -306,7 +306,7 @@ none0 (null): json:{"read-zeroes": "on", "driver": "nul=
l-co"} (null-co)
 Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnu=
ll -device ide-cd,drive=3Dnone0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
+none0 (null): json:{"driver": "null-co", "read-zeroes": "on"} (null-co)
     Attached to:      /machine/peripheral-anon/device[N]
     Removable device: not locked, tray closed
     Cache mode:       writeback
@@ -315,7 +315,7 @@ none0 (null): json:{"read-zeroes": "on", "driver": "nul=
l-co"} (null-co)
 Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnu=
ll -device ide-cd,drive=3Dnone0,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
+none0 (null): json:{"driver": "null-co", "read-zeroes": "on"} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
@@ -324,7 +324,7 @@ none0 (null): json:{"read-zeroes": "on", "driver": "nul=
l-co"} (null-co)
 Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnu=
ll -device scsi-cd,drive=3Dnone0
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
+none0 (null): json:{"driver": "null-co", "read-zeroes": "on"} (null-co)
     Attached to:      /machine/peripheral-anon/device[N]
     Removable device: not locked, tray closed
     Cache mode:       writeback
@@ -333,7 +333,7 @@ none0 (null): json:{"read-zeroes": "on", "driver": "nul=
l-co"} (null-co)
 Testing: -drive if=3Dnone,driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnu=
ll -device scsi-cd,drive=3Dnone0,id=3Dqdev_id
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
+none0 (null): json:{"driver": "null-co", "read-zeroes": "on"} (null-co)
     Attached to:      qdev_id
     Removable device: not locked, tray closed
     Cache mode:       writeback
@@ -411,7 +411,7 @@ floppy0: [not inserted]
 Testing: -drive if=3Dfloppy,driver=3Dnull-co,read-zeroes=3Don
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-floppy0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (null=
-co)
+floppy0 (NODE_NAME): json:{"driver": "null-co", "read-zeroes": "on"} (null=
-co)
     Attached to:      /machine/unattached/device[N]
     Removable device: not locked, tray closed
     Cache mode:       writeback
@@ -420,7 +420,7 @@ floppy0 (NODE_NAME): json:{"read-zeroes": "on", "driver=
": "null-co"} (null-co)
 Testing: -drive if=3Dide,driver=3Dnull-co,read-zeroes=3Don
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-ide0-hd0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (nul=
l-co)
+ide0-hd0 (NODE_NAME): json:{"driver": "null-co", "read-zeroes": "on"} (nul=
l-co)
     Attached to:      /machine/unattached/device[N]
     Cache mode:       writeback
 (qemu) quit
@@ -436,7 +436,7 @@ ide0-cd0: [not inserted]
 Testing: -drive if=3Dide,driver=3Dnull-co,read-zeroes=3Don,media=3Dcdrom
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-ide0-cd0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (nul=
l-co, read-only)
+ide0-cd0 (NODE_NAME): json:{"driver": "null-co", "read-zeroes": "on"} (nul=
l-co, read-only)
     Attached to:      /machine/unattached/device[N]
     Removable device: not locked, tray closed
     Cache mode:       writeback
@@ -445,7 +445,7 @@ ide0-cd0 (NODE_NAME): json:{"read-zeroes": "on", "drive=
r": "null-co"} (null-co,
 Testing: -drive if=3Dvirtio,driver=3Dnull-co,read-zeroes=3Don
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-virtio0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (null=
-co)
+virtio0 (NODE_NAME): json:{"driver": "null-co", "read-zeroes": "on"} (null=
-co)
     Attached to:      /machine/peripheral-anon/device[N]/virtio-backend
     Cache mode:       writeback
 (qemu) quit
@@ -453,7 +453,7 @@ virtio0 (NODE_NAME): json:{"read-zeroes": "on", "driver=
": "null-co"} (null-co)
 Testing: -drive if=3Dpflash,driver=3Dnull-co,read-zeroes=3Don,size=3D1M
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-pflash0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co", "size=
": "1M"} (null-co)
+pflash0 (NODE_NAME): json:{"driver": "null-co", "size": "1M", "read-zeroes=
": "on"} (null-co)
     Attached to:      /machine/system.flash0
     Cache mode:       writeback
 (qemu) quit
diff --git a/tests/qemu-iotests/190.out b/tests/qemu-iotests/190.out
index ed9d8214eb..2acea9982c 100644
--- a/tests/qemu-iotests/190.out
+++ b/tests/qemu-iotests/190.out
@@ -29,8 +29,8 @@ bitmaps size: 537198592
=20
 expected bitmap 545259520
 {
-    "bitmaps": 545259520,
     "required": 18874368,
-    "fully-allocated": 2199042129920
+    "fully-allocated": 2199042129920,
+    "bitmaps": 545259520
 }
 *** done
diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
index ea88777374..7c0e9a2f5c 100644
--- a/tests/qemu-iotests/191.out
+++ b/tests/qemu-iotests/191.out
@@ -22,25 +22,25 @@ wrote 65536/65536 bytes at offset 1048576
                       'base':'TEST_DIR/t.IMGFMT.base',
                       'top': 'TEST_DIR/t.IMGFMT.mid' } }
 {
+    "event": "JOB_STATUS_CHANGE",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "JOB_STATUS_CHANGE",
     "data": {
-        "status": "created",
-        "id": "commit0"
+        "id": "commit0",
+        "status": "created"
     }
 }
 {
+    "event": "JOB_STATUS_CHANGE",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "JOB_STATUS_CHANGE",
     "data": {
-        "status": "running",
-        "id": "commit0"
+        "id": "commit0",
+        "status": "running"
     }
 }
 {
@@ -48,61 +48,61 @@ wrote 65536/65536 bytes at offset 1048576
     }
 }
 {
+    "event": "JOB_STATUS_CHANGE",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "JOB_STATUS_CHANGE",
     "data": {
-        "status": "waiting",
-        "id": "commit0"
+        "id": "commit0",
+        "status": "waiting"
     }
 }
 {
+    "event": "JOB_STATUS_CHANGE",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "JOB_STATUS_CHANGE",
     "data": {
-        "status": "pending",
-        "id": "commit0"
+        "id": "commit0",
+        "status": "pending"
     }
 }
 {
+    "event": "BLOCK_JOB_COMPLETED",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "BLOCK_JOB_COMPLETED",
     "data": {
+        "type": "commit",
         "device": "commit0",
         "len": 67108864,
         "offset": 67108864,
-        "speed": 0,
-        "type": "commit"
+        "speed": 0
     }
 }
 {
+    "event": "JOB_STATUS_CHANGE",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "JOB_STATUS_CHANGE",
     "data": {
-        "status": "concluded",
-        "id": "commit0"
+        "id": "commit0",
+        "status": "concluded"
     }
 }
 {
+    "event": "JOB_STATUS_CHANGE",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "JOB_STATUS_CHANGE",
     "data": {
-        "status": "null",
-        "id": "commit0"
+        "id": "commit0",
+        "status": "null"
     }
 }
=20
@@ -112,268 +112,268 @@ wrote 65536/65536 bytes at offset 1048576
 {
     "return": [
         {
-            "iops_rd": 0,
+            "file": "TEST_DIR/t.IMGFMT.ovl2",
+            "node-name": "top2",
+            "ro": false,
+            "drv": "IMGFMT",
+            "backing_file": "TEST_DIR/t.IMGFMT.base",
+            "backing_file_depth": 1,
+            "encrypted": false,
             "detect_zeroes": "off",
+            "bps": 0,
+            "bps_rd": 0,
+            "bps_wr": 0,
+            "iops": 0,
+            "iops_rd": 0,
+            "iops_wr": 0,
             "image": {
-                "backing-image": {
-                    "virtual-size": 67108864,
-                    "filename": "TEST_DIR/t.IMGFMT.base",
-                    "cluster-size": 65536,
-                    "format": "IMGFMT",
-                    "actual-size": SIZE,
-                    "dirty-flag": false
-                },
-                "backing-filename-format": "IMGFMT",
-                "virtual-size": 67108864,
                 "filename": "TEST_DIR/t.IMGFMT.ovl2",
-                "cluster-size": 65536,
                 "format": "IMGFMT",
+                "dirty-flag": false,
                 "actual-size": SIZE,
-                "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                "virtual-size": 67108864,
+                "cluster-size": 65536,
                 "backing-filename": "TEST_DIR/t.IMGFMT.base",
-                "dirty-flag": false
+                "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                "backing-filename-format": "IMGFMT",
+                "backing-image": {
+                    "filename": "TEST_DIR/t.IMGFMT.base",
+                    "format": "IMGFMT",
+                    "dirty-flag": false,
+                    "actual-size": SIZE,
+                    "virtual-size": 67108864,
+                    "cluster-size": 65536,
+                }
             },
-            "iops_wr": 0,
-            "ro": false,
-            "node-name": "top2",
-            "backing_file_depth": 1,
-            "drv": "IMGFMT",
-            "iops": 0,
-            "bps_wr": 0,
-            "write_threshold": 0,
-            "backing_file": "TEST_DIR/t.IMGFMT.base",
-            "encrypted": false,
-            "bps": 0,
-            "bps_rd": 0,
             "cache": {
-                "no-flush": false,
+                "writeback": true,
                 "direct": false,
-                "writeback": true
+                "no-flush": false
             },
-            "file": "TEST_DIR/t.IMGFMT.ovl2"
+            "write_threshold": 0
         },
         {
-            "iops_rd": 0,
+            "file": "TEST_DIR/t.IMGFMT.ovl2",
+            "node-name": "NODE_NAME",
+            "ro": false,
+            "drv": "file",
+            "backing_file_depth": 0,
+            "encrypted": false,
             "detect_zeroes": "off",
+            "bps": 0,
+            "bps_rd": 0,
+            "bps_wr": 0,
+            "iops": 0,
+            "iops_rd": 0,
+            "iops_wr": 0,
             "image": {
-                "virtual-size": 197120,
                 "filename": "TEST_DIR/t.IMGFMT.ovl2",
                 "format": "file",
+                "dirty-flag": false,
                 "actual-size": SIZE,
-                "dirty-flag": false
+                "virtual-size": 197120,
             },
-            "iops_wr": 0,
-            "ro": false,
-            "node-name": "NODE_NAME",
-            "backing_file_depth": 0,
-            "drv": "file",
-            "iops": 0,
-            "bps_wr": 0,
-            "write_threshold": 0,
-            "encrypted": false,
-            "bps": 0,
-            "bps_rd": 0,
             "cache": {
-                "no-flush": false,
+                "writeback": true,
                 "direct": false,
-                "writeback": true
+                "no-flush": false
             },
-            "file": "TEST_DIR/t.IMGFMT.ovl2"
+            "write_threshold": 0
         },
         {
-            "iops_rd": 0,
+            "file": "TEST_DIR/t.IMGFMT",
+            "node-name": "top",
+            "ro": false,
+            "drv": "IMGFMT",
+            "backing_file": "TEST_DIR/t.IMGFMT.base",
+            "backing_file_depth": 1,
+            "encrypted": false,
             "detect_zeroes": "off",
+            "bps": 0,
+            "bps_rd": 0,
+            "bps_wr": 0,
+            "iops": 0,
+            "iops_rd": 0,
+            "iops_wr": 0,
             "image": {
-                "backing-image": {
-                    "virtual-size": 67108864,
-                    "filename": "TEST_DIR/t.IMGFMT.base",
-                    "cluster-size": 65536,
-                    "format": "IMGFMT",
-                    "actual-size": SIZE,
-                    "dirty-flag": false
-                },
-                "backing-filename-format": "IMGFMT",
-                "virtual-size": 67108864,
                 "filename": "TEST_DIR/t.IMGFMT",
-                "cluster-size": 65536,
                 "format": "IMGFMT",
+                "dirty-flag": false,
                 "actual-size": SIZE,
-                "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                "virtual-size": 67108864,
+                "cluster-size": 65536,
                 "backing-filename": "TEST_DIR/t.IMGFMT.base",
-                "dirty-flag": false
+                "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                "backing-filename-format": "IMGFMT",
+                "backing-image": {
+                    "filename": "TEST_DIR/t.IMGFMT.base",
+                    "format": "IMGFMT",
+                    "dirty-flag": false,
+                    "actual-size": SIZE,
+                    "virtual-size": 67108864,
+                    "cluster-size": 65536,
+                }
             },
-            "iops_wr": 0,
-            "ro": false,
-            "node-name": "top",
-            "backing_file_depth": 1,
-            "drv": "IMGFMT",
-            "iops": 0,
-            "bps_wr": 0,
-            "write_threshold": 0,
-            "backing_file": "TEST_DIR/t.IMGFMT.base",
-            "encrypted": false,
-            "bps": 0,
-            "bps_rd": 0,
             "cache": {
-                "no-flush": false,
+                "writeback": true,
                 "direct": false,
-                "writeback": true
+                "no-flush": false
             },
-            "file": "TEST_DIR/t.IMGFMT"
+            "write_threshold": 0
         },
         {
-            "iops_rd": 0,
+            "file": "TEST_DIR/t.IMGFMT",
+            "node-name": "NODE_NAME",
+            "ro": false,
+            "drv": "file",
+            "backing_file_depth": 0,
+            "encrypted": false,
             "detect_zeroes": "off",
+            "bps": 0,
+            "bps_rd": 0,
+            "bps_wr": 0,
+            "iops": 0,
+            "iops_rd": 0,
+            "iops_wr": 0,
             "image": {
-                "virtual-size": 197120,
                 "filename": "TEST_DIR/t.IMGFMT",
                 "format": "file",
+                "dirty-flag": false,
                 "actual-size": SIZE,
-                "dirty-flag": false
+                "virtual-size": 197120,
             },
-            "iops_wr": 0,
-            "ro": false,
-            "node-name": "NODE_NAME",
-            "backing_file_depth": 0,
-            "drv": "file",
-            "iops": 0,
-            "bps_wr": 0,
-            "write_threshold": 0,
-            "encrypted": false,
-            "bps": 0,
-            "bps_rd": 0,
             "cache": {
-                "no-flush": false,
+                "writeback": true,
                 "direct": false,
-                "writeback": true
+                "no-flush": false
             },
-            "file": "TEST_DIR/t.IMGFMT"
+            "write_threshold": 0
         },
         {
-            "iops_rd": 0,
+            "file": "TEST_DIR/t.IMGFMT.mid",
+            "node-name": "mid",
+            "ro": false,
+            "drv": "IMGFMT",
+            "backing_file": "TEST_DIR/t.IMGFMT.base",
+            "backing_file_depth": 1,
+            "encrypted": false,
             "detect_zeroes": "off",
+            "bps": 0,
+            "bps_rd": 0,
+            "bps_wr": 0,
+            "iops": 0,
+            "iops_rd": 0,
+            "iops_wr": 0,
             "image": {
-                "backing-image": {
-                    "virtual-size": 67108864,
-                    "filename": "TEST_DIR/t.IMGFMT.base",
-                    "cluster-size": 65536,
-                    "format": "IMGFMT",
-                    "actual-size": SIZE,
-                    "dirty-flag": false
-                },
-                "backing-filename-format": "IMGFMT",
-                "virtual-size": 67108864,
                 "filename": "TEST_DIR/t.IMGFMT.mid",
-                "cluster-size": 65536,
                 "format": "IMGFMT",
+                "dirty-flag": false,
                 "actual-size": SIZE,
-                "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                "virtual-size": 67108864,
+                "cluster-size": 65536,
                 "backing-filename": "TEST_DIR/t.IMGFMT.base",
-                "dirty-flag": false
+                "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                "backing-filename-format": "IMGFMT",
+                "backing-image": {
+                    "filename": "TEST_DIR/t.IMGFMT.base",
+                    "format": "IMGFMT",
+                    "dirty-flag": false,
+                    "actual-size": SIZE,
+                    "virtual-size": 67108864,
+                    "cluster-size": 65536,
+                }
             },
-            "iops_wr": 0,
-            "ro": false,
-            "node-name": "mid",
-            "backing_file_depth": 1,
-            "drv": "IMGFMT",
-            "iops": 0,
-            "bps_wr": 0,
-            "write_threshold": 0,
-            "backing_file": "TEST_DIR/t.IMGFMT.base",
-            "encrypted": false,
-            "bps": 0,
-            "bps_rd": 0,
             "cache": {
-                "no-flush": false,
+                "writeback": true,
                 "direct": false,
-                "writeback": true
+                "no-flush": false
             },
-            "file": "TEST_DIR/t.IMGFMT.mid"
+            "write_threshold": 0
         },
         {
-            "iops_rd": 0,
+            "file": "TEST_DIR/t.IMGFMT.mid",
+            "node-name": "NODE_NAME",
+            "ro": false,
+            "drv": "file",
+            "backing_file_depth": 0,
+            "encrypted": false,
             "detect_zeroes": "off",
+            "bps": 0,
+            "bps_rd": 0,
+            "bps_wr": 0,
+            "iops": 0,
+            "iops_rd": 0,
+            "iops_wr": 0,
             "image": {
-                "virtual-size": 393216,
                 "filename": "TEST_DIR/t.IMGFMT.mid",
                 "format": "file",
+                "dirty-flag": false,
                 "actual-size": SIZE,
-                "dirty-flag": false
+                "virtual-size": 393216,
             },
-            "iops_wr": 0,
-            "ro": false,
-            "node-name": "NODE_NAME",
-            "backing_file_depth": 0,
-            "drv": "file",
-            "iops": 0,
-            "bps_wr": 0,
-            "write_threshold": 0,
-            "encrypted": false,
-            "bps": 0,
-            "bps_rd": 0,
             "cache": {
-                "no-flush": false,
+                "writeback": true,
                 "direct": false,
-                "writeback": true
+                "no-flush": false
             },
-            "file": "TEST_DIR/t.IMGFMT.mid"
+            "write_threshold": 0
         },
         {
-            "iops_rd": 0,
+            "file": "TEST_DIR/t.IMGFMT.base",
+            "node-name": "base",
+            "ro": false,
+            "drv": "IMGFMT",
+            "backing_file_depth": 0,
+            "encrypted": false,
             "detect_zeroes": "off",
+            "bps": 0,
+            "bps_rd": 0,
+            "bps_wr": 0,
+            "iops": 0,
+            "iops_rd": 0,
+            "iops_wr": 0,
             "image": {
-                "virtual-size": 67108864,
                 "filename": "TEST_DIR/t.IMGFMT.base",
-                "cluster-size": 65536,
                 "format": "IMGFMT",
+                "dirty-flag": false,
                 "actual-size": SIZE,
-                "dirty-flag": false
+                "virtual-size": 67108864,
+                "cluster-size": 65536,
             },
-            "iops_wr": 0,
-            "ro": false,
-            "node-name": "base",
-            "backing_file_depth": 0,
-            "drv": "IMGFMT",
-            "iops": 0,
-            "bps_wr": 0,
-            "write_threshold": 0,
-            "encrypted": false,
-            "bps": 0,
-            "bps_rd": 0,
             "cache": {
-                "no-flush": false,
+                "writeback": true,
                 "direct": false,
-                "writeback": true
+                "no-flush": false
             },
-            "file": "TEST_DIR/t.IMGFMT.base"
+            "write_threshold": 0
         },
         {
-            "iops_rd": 0,
-            "detect_zeroes": "off",
-            "image": {
-                "virtual-size": 393216,
-                "filename": "TEST_DIR/t.IMGFMT.base",
-                "format": "file",
-                "actual-size": SIZE,
-                "dirty-flag": false
-            },
-            "iops_wr": 0,
-            "ro": false,
+            "file": "TEST_DIR/t.IMGFMT.base",
             "node-name": "NODE_NAME",
-            "backing_file_depth": 0,
+            "ro": false,
             "drv": "file",
-            "iops": 0,
-            "bps_wr": 0,
-            "write_threshold": 0,
+            "backing_file_depth": 0,
             "encrypted": false,
+            "detect_zeroes": "off",
             "bps": 0,
             "bps_rd": 0,
+            "bps_wr": 0,
+            "iops": 0,
+            "iops_rd": 0,
+            "iops_wr": 0,
+            "image": {
+                "filename": "TEST_DIR/t.IMGFMT.base",
+                "format": "file",
+                "dirty-flag": false,
+                "actual-size": SIZE,
+                "virtual-size": 393216,
+            },
             "cache": {
-                "no-flush": false,
+                "writeback": true,
                 "direct": false,
-                "writeback": true
+                "no-flush": false
             },
-            "file": "TEST_DIR/t.IMGFMT.base"
+            "write_threshold": 0
         }
     ]
 }
@@ -383,11 +383,11 @@ wrote 65536/65536 bytes at offset 1048576
     }
 }
 {
+    "event": "SHUTDOWN",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "SHUTDOWN",
     "data": {
         "guest": false,
         "reason": "host-qmp-quit"
@@ -429,25 +429,25 @@ wrote 65536/65536 bytes at offset 1048576
                       'base':'TEST_DIR/t.IMGFMT.base',
                       'top': 'TEST_DIR/t.IMGFMT.mid' } }
 {
+    "event": "JOB_STATUS_CHANGE",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "JOB_STATUS_CHANGE",
     "data": {
-        "status": "created",
-        "id": "commit0"
+        "id": "commit0",
+        "status": "created"
     }
 }
 {
+    "event": "JOB_STATUS_CHANGE",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "JOB_STATUS_CHANGE",
     "data": {
-        "status": "running",
-        "id": "commit0"
+        "id": "commit0",
+        "status": "running"
     }
 }
 {
@@ -455,61 +455,61 @@ wrote 65536/65536 bytes at offset 1048576
     }
 }
 {
+    "event": "JOB_STATUS_CHANGE",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "JOB_STATUS_CHANGE",
     "data": {
-        "status": "waiting",
-        "id": "commit0"
+        "id": "commit0",
+        "status": "waiting"
     }
 }
 {
+    "event": "JOB_STATUS_CHANGE",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "JOB_STATUS_CHANGE",
     "data": {
-        "status": "pending",
-        "id": "commit0"
+        "id": "commit0",
+        "status": "pending"
     }
 }
 {
+    "event": "BLOCK_JOB_COMPLETED",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "BLOCK_JOB_COMPLETED",
     "data": {
+        "type": "commit",
         "device": "commit0",
         "len": 67108864,
         "offset": 67108864,
-        "speed": 0,
-        "type": "commit"
+        "speed": 0
     }
 }
 {
+    "event": "JOB_STATUS_CHANGE",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "JOB_STATUS_CHANGE",
     "data": {
-        "status": "concluded",
-        "id": "commit0"
+        "id": "commit0",
+        "status": "concluded"
     }
 }
 {
+    "event": "JOB_STATUS_CHANGE",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "JOB_STATUS_CHANGE",
     "data": {
-        "status": "null",
-        "id": "commit0"
+        "id": "commit0",
+        "status": "null"
     }
 }
=20
@@ -519,279 +519,279 @@ wrote 65536/65536 bytes at offset 1048576
 {
     "return": [
         {
-            "iops_rd": 0,
+            "file": "TEST_DIR/t.IMGFMT.ovl2",
+            "node-name": "NODE_NAME",
+            "ro": true,
+            "drv": "IMGFMT",
+            "backing_file": "TEST_DIR/t.IMGFMT.base",
+            "backing_file_depth": 1,
+            "encrypted": false,
             "detect_zeroes": "off",
+            "bps": 0,
+            "bps_rd": 0,
+            "bps_wr": 0,
+            "iops": 0,
+            "iops_rd": 0,
+            "iops_wr": 0,
             "image": {
-                "backing-image": {
-                    "virtual-size": 67108864,
-                    "filename": "TEST_DIR/t.IMGFMT.base",
-                    "cluster-size": 65536,
-                    "format": "IMGFMT",
-                    "actual-size": SIZE,
-                    "dirty-flag": false
-                },
-                "backing-filename-format": "IMGFMT",
-                "virtual-size": 67108864,
                 "filename": "TEST_DIR/t.IMGFMT.ovl2",
-                "cluster-size": 65536,
                 "format": "IMGFMT",
+                "dirty-flag": false,
                 "actual-size": SIZE,
-                "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                "virtual-size": 67108864,
+                "cluster-size": 65536,
                 "backing-filename": "TEST_DIR/t.IMGFMT.base",
-                "dirty-flag": false
+                "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                "backing-filename-format": "IMGFMT",
+                "backing-image": {
+                    "filename": "TEST_DIR/t.IMGFMT.base",
+                    "format": "IMGFMT",
+                    "dirty-flag": false,
+                    "actual-size": SIZE,
+                    "virtual-size": 67108864,
+                    "cluster-size": 65536,
+                }
             },
-            "iops_wr": 0,
-            "ro": true,
-            "node-name": "NODE_NAME",
-            "backing_file_depth": 1,
-            "drv": "IMGFMT",
-            "iops": 0,
-            "bps_wr": 0,
-            "write_threshold": 0,
-            "backing_file": "TEST_DIR/t.IMGFMT.base",
-            "encrypted": false,
-            "bps": 0,
-            "bps_rd": 0,
             "cache": {
-                "no-flush": false,
+                "writeback": true,
                 "direct": false,
-                "writeback": true
+                "no-flush": false
             },
-            "file": "TEST_DIR/t.IMGFMT.ovl2"
+            "write_threshold": 0
         },
         {
-            "iops_rd": 0,
+            "file": "TEST_DIR/t.IMGFMT.ovl2",
+            "node-name": "NODE_NAME",
+            "ro": true,
+            "drv": "file",
+            "backing_file_depth": 0,
+            "encrypted": false,
             "detect_zeroes": "off",
+            "bps": 0,
+            "bps_rd": 0,
+            "bps_wr": 0,
+            "iops": 0,
+            "iops_rd": 0,
+            "iops_wr": 0,
             "image": {
-                "virtual-size": 197120,
                 "filename": "TEST_DIR/t.IMGFMT.ovl2",
                 "format": "file",
+                "dirty-flag": false,
                 "actual-size": SIZE,
-                "dirty-flag": false
+                "virtual-size": 197120,
             },
-            "iops_wr": 0,
-            "ro": true,
-            "node-name": "NODE_NAME",
-            "backing_file_depth": 0,
-            "drv": "file",
-            "iops": 0,
-            "bps_wr": 0,
-            "write_threshold": 0,
-            "encrypted": false,
-            "bps": 0,
-            "bps_rd": 0,
             "cache": {
-                "no-flush": false,
+                "writeback": true,
                 "direct": false,
-                "writeback": true
+                "no-flush": false
             },
-            "file": "TEST_DIR/t.IMGFMT.ovl2"
+            "write_threshold": 0
         },
         {
-            "iops_rd": 0,
+            "file": "TEST_DIR/t.IMGFMT.ovl3",
+            "node-name": "top2",
+            "ro": false,
+            "drv": "IMGFMT",
+            "backing_file": "TEST_DIR/t.IMGFMT.ovl2",
+            "backing_file_depth": 2,
+            "encrypted": false,
             "detect_zeroes": "off",
+            "bps": 0,
+            "bps_rd": 0,
+            "bps_wr": 0,
+            "iops": 0,
+            "iops_rd": 0,
+            "iops_wr": 0,
             "image": {
+                "filename": "TEST_DIR/t.IMGFMT.ovl3",
+                "format": "IMGFMT",
+                "dirty-flag": false,
+                "actual-size": SIZE,
+                "virtual-size": 67108864,
+                "cluster-size": 65536,
+                "backing-filename": "TEST_DIR/t.IMGFMT.ovl2",
+                "full-backing-filename": "TEST_DIR/t.IMGFMT.ovl2",
+                "backing-filename-format": "IMGFMT",
                 "backing-image": {
-                    "backing-image": {
-                        "virtual-size": 67108864,
-                        "filename": "TEST_DIR/t.IMGFMT.base",
-                        "cluster-size": 65536,
-                        "format": "IMGFMT",
-                        "actual-size": SIZE,
-                        "dirty-flag": false
-                    },
-                    "backing-filename-format": "IMGFMT",
-                    "virtual-size": 67108864,
                     "filename": "TEST_DIR/t.IMGFMT.ovl2",
-                    "cluster-size": 65536,
                     "format": "IMGFMT",
+                    "dirty-flag": false,
                     "actual-size": SIZE,
-                    "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                    "virtual-size": 67108864,
+                    "cluster-size": 65536,
                     "backing-filename": "TEST_DIR/t.IMGFMT.base",
-                    "dirty-flag": false
-                },
-                "backing-filename-format": "IMGFMT",
-                "virtual-size": 67108864,
-                "filename": "TEST_DIR/t.IMGFMT.ovl3",
-                "cluster-size": 65536,
-                "format": "IMGFMT",
-                "actual-size": SIZE,
-                "full-backing-filename": "TEST_DIR/t.IMGFMT.ovl2",
-                "backing-filename": "TEST_DIR/t.IMGFMT.ovl2",
-                "dirty-flag": false
+                    "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                    "backing-filename-format": "IMGFMT",
+                    "backing-image": {
+                        "filename": "TEST_DIR/t.IMGFMT.base",
+                        "format": "IMGFMT",
+                        "dirty-flag": false,
+                        "actual-size": SIZE,
+                        "virtual-size": 67108864,
+                        "cluster-size": 65536,
+                    }
+                }
             },
-            "iops_wr": 0,
-            "ro": false,
-            "node-name": "top2",
-            "backing_file_depth": 2,
-            "drv": "IMGFMT",
-            "iops": 0,
-            "bps_wr": 0,
-            "write_threshold": 0,
-            "backing_file": "TEST_DIR/t.IMGFMT.ovl2",
-            "encrypted": false,
-            "bps": 0,
-            "bps_rd": 0,
             "cache": {
-                "no-flush": false,
+                "writeback": true,
                 "direct": false,
-                "writeback": true
+                "no-flush": false
             },
-            "file": "TEST_DIR/t.IMGFMT.ovl3"
+            "write_threshold": 0
         },
         {
-            "iops_rd": 0,
+            "file": "TEST_DIR/t.IMGFMT.ovl3",
+            "node-name": "NODE_NAME",
+            "ro": false,
+            "drv": "file",
+            "backing_file_depth": 0,
+            "encrypted": false,
             "detect_zeroes": "off",
+            "bps": 0,
+            "bps_rd": 0,
+            "bps_wr": 0,
+            "iops": 0,
+            "iops_rd": 0,
+            "iops_wr": 0,
             "image": {
-                "virtual-size": 197120,
                 "filename": "TEST_DIR/t.IMGFMT.ovl3",
                 "format": "file",
+                "dirty-flag": false,
                 "actual-size": SIZE,
-                "dirty-flag": false
+                "virtual-size": 197120,
             },
-            "iops_wr": 0,
-            "ro": false,
-            "node-name": "NODE_NAME",
-            "backing_file_depth": 0,
-            "drv": "file",
-            "iops": 0,
-            "bps_wr": 0,
-            "write_threshold": 0,
-            "encrypted": false,
-            "bps": 0,
-            "bps_rd": 0,
             "cache": {
-                "no-flush": false,
+                "writeback": true,
                 "direct": false,
-                "writeback": true
+                "no-flush": false
             },
-            "file": "TEST_DIR/t.IMGFMT.ovl3"
+            "write_threshold": 0
         },
         {
-            "iops_rd": 0,
+            "file": "TEST_DIR/t.IMGFMT.base",
+            "node-name": "NODE_NAME",
+            "ro": true,
+            "drv": "IMGFMT",
+            "backing_file_depth": 0,
+            "encrypted": false,
             "detect_zeroes": "off",
+            "bps": 0,
+            "bps_rd": 0,
+            "bps_wr": 0,
+            "iops": 0,
+            "iops_rd": 0,
+            "iops_wr": 0,
             "image": {
-                "virtual-size": 67108864,
                 "filename": "TEST_DIR/t.IMGFMT.base",
-                "cluster-size": 65536,
                 "format": "IMGFMT",
+                "dirty-flag": false,
                 "actual-size": SIZE,
-                "dirty-flag": false
+                "virtual-size": 67108864,
+                "cluster-size": 65536,
             },
-            "iops_wr": 0,
-            "ro": true,
-            "node-name": "NODE_NAME",
-            "backing_file_depth": 0,
-            "drv": "IMGFMT",
-            "iops": 0,
-            "bps_wr": 0,
-            "write_threshold": 0,
-            "encrypted": false,
-            "bps": 0,
-            "bps_rd": 0,
             "cache": {
-                "no-flush": false,
+                "writeback": true,
                 "direct": false,
-                "writeback": true
+                "no-flush": false
             },
-            "file": "TEST_DIR/t.IMGFMT.base"
+            "write_threshold": 0
         },
         {
-            "iops_rd": 0,
+            "file": "TEST_DIR/t.IMGFMT.base",
+            "node-name": "NODE_NAME",
+            "ro": true,
+            "drv": "file",
+            "backing_file_depth": 0,
+            "encrypted": false,
             "detect_zeroes": "off",
+            "bps": 0,
+            "bps_rd": 0,
+            "bps_wr": 0,
+            "iops": 0,
+            "iops_rd": 0,
+            "iops_wr": 0,
             "image": {
-                "virtual-size": 393216,
                 "filename": "TEST_DIR/t.IMGFMT.base",
                 "format": "file",
+                "dirty-flag": false,
                 "actual-size": SIZE,
-                "dirty-flag": false
+                "virtual-size": 393216,
             },
-            "iops_wr": 0,
-            "ro": true,
-            "node-name": "NODE_NAME",
-            "backing_file_depth": 0,
-            "drv": "file",
-            "iops": 0,
-            "bps_wr": 0,
-            "write_threshold": 0,
-            "encrypted": false,
-            "bps": 0,
-            "bps_rd": 0,
             "cache": {
-                "no-flush": false,
+                "writeback": true,
                 "direct": false,
-                "writeback": true
+                "no-flush": false
             },
-            "file": "TEST_DIR/t.IMGFMT.base"
+            "write_threshold": 0
         },
         {
-            "iops_rd": 0,
+            "file": "TEST_DIR/t.IMGFMT",
+            "node-name": "top",
+            "ro": false,
+            "drv": "IMGFMT",
+            "backing_file": "TEST_DIR/t.IMGFMT.base",
+            "backing_file_depth": 1,
+            "encrypted": false,
             "detect_zeroes": "off",
+            "bps": 0,
+            "bps_rd": 0,
+            "bps_wr": 0,
+            "iops": 0,
+            "iops_rd": 0,
+            "iops_wr": 0,
             "image": {
-                "backing-image": {
-                    "virtual-size": 67108864,
-                    "filename": "TEST_DIR/t.IMGFMT.base",
-                    "cluster-size": 65536,
-                    "format": "IMGFMT",
-                    "actual-size": SIZE,
-                    "dirty-flag": false
-                },
-                "backing-filename-format": "IMGFMT",
-                "virtual-size": 67108864,
                 "filename": "TEST_DIR/t.IMGFMT",
-                "cluster-size": 65536,
                 "format": "IMGFMT",
+                "dirty-flag": false,
                 "actual-size": SIZE,
-                "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                "virtual-size": 67108864,
+                "cluster-size": 65536,
                 "backing-filename": "TEST_DIR/t.IMGFMT.base",
-                "dirty-flag": false
+                "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                "backing-filename-format": "IMGFMT",
+                "backing-image": {
+                    "filename": "TEST_DIR/t.IMGFMT.base",
+                    "format": "IMGFMT",
+                    "dirty-flag": false,
+                    "actual-size": SIZE,
+                    "virtual-size": 67108864,
+                    "cluster-size": 65536,
+                }
             },
-            "iops_wr": 0,
-            "ro": false,
-            "node-name": "top",
-            "backing_file_depth": 1,
-            "drv": "IMGFMT",
-            "iops": 0,
-            "bps_wr": 0,
-            "write_threshold": 0,
-            "backing_file": "TEST_DIR/t.IMGFMT.base",
-            "encrypted": false,
-            "bps": 0,
-            "bps_rd": 0,
             "cache": {
-                "no-flush": false,
+                "writeback": true,
                 "direct": false,
-                "writeback": true
+                "no-flush": false
             },
-            "file": "TEST_DIR/t.IMGFMT"
+            "write_threshold": 0
         },
         {
-            "iops_rd": 0,
+            "file": "TEST_DIR/t.IMGFMT",
+            "node-name": "NODE_NAME",
+            "ro": false,
+            "drv": "file",
+            "backing_file_depth": 0,
+            "encrypted": false,
             "detect_zeroes": "off",
+            "bps": 0,
+            "bps_rd": 0,
+            "bps_wr": 0,
+            "iops": 0,
+            "iops_rd": 0,
+            "iops_wr": 0,
             "image": {
-                "virtual-size": 197120,
                 "filename": "TEST_DIR/t.IMGFMT",
                 "format": "file",
+                "dirty-flag": false,
                 "actual-size": SIZE,
-                "dirty-flag": false
+                "virtual-size": 197120,
             },
-            "iops_wr": 0,
-            "ro": false,
-            "node-name": "NODE_NAME",
-            "backing_file_depth": 0,
-            "drv": "file",
-            "iops": 0,
-            "bps_wr": 0,
-            "write_threshold": 0,
-            "encrypted": false,
-            "bps": 0,
-            "bps_rd": 0,
             "cache": {
-                "no-flush": false,
+                "writeback": true,
                 "direct": false,
-                "writeback": true
+                "no-flush": false
             },
-            "file": "TEST_DIR/t.IMGFMT"
+            "write_threshold": 0
         }
     ]
 }
@@ -801,11 +801,11 @@ wrote 65536/65536 bytes at offset 1048576
     }
 }
 {
+    "event": "SHUTDOWN",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "SHUTDOWN",
     "data": {
         "guest": false,
         "reason": "host-qmp-quit"
diff --git a/tests/qemu-iotests/195.out b/tests/qemu-iotests/195.out
index ec84df5012..485d7a1115 100644
--- a/tests/qemu-iotests/195.out
+++ b/tests/qemu-iotests/195.out
@@ -22,11 +22,11 @@ Testing: -drive if=3Dnone,file=3DTEST_DIR/t.IMGFMT,back=
ing.node-name=3Dmid
     }
 }
 {
+    "event": "SHUTDOWN",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "SHUTDOWN",
     "data": {
         "guest": false,
         "reason": "host-qmp-quit"
@@ -60,11 +60,11 @@ Testing: -drive if=3Dnone,file=3DTEST_DIR/t.IMGFMT,node=
-name=3Dtop
     }
 }
 {
+    "event": "SHUTDOWN",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "SHUTDOWN",
     "data": {
         "guest": false,
         "reason": "host-qmp-quit"
diff --git a/tests/qemu-iotests/227.out b/tests/qemu-iotests/227.out
index a947b1a87d..7246d2ea02 100644
--- a/tests/qemu-iotests/227.out
+++ b/tests/qemu-iotests/227.out
@@ -14,43 +14,43 @@ Testing: -drive driver=3Dnull-co,read-zeroes=3Don,if=3D=
virtio
     "return": [
         {
             "device": "virtio0",
+            "qdev": "/machine/peripheral-anon/device[0]/virtio-backend",
+            "node-name": "NODE_NAME",
             "stats": {
+                "rd_bytes": 0,
+                "wr_bytes": 0,
+                "zone_append_bytes": 0,
+                "unmap_bytes": 0,
+                "rd_operations": 0,
+                "wr_operations": 0,
+                "zone_append_operations": 0,
+                "flush_operations": 0,
                 "unmap_operations": 0,
-                "unmap_merged": 0,
-                "failed_zone_append_operations": 0,
+                "rd_total_time_ns": 0,
+                "wr_total_time_ns": 0,
+                "zone_append_total_time_ns": 0,
                 "flush_total_time_ns": 0,
+                "unmap_total_time_ns": 0,
                 "wr_highest_offset": 0,
-                "wr_total_time_ns": 0,
-                "failed_wr_operations": 0,
-                "failed_rd_operations": 0,
+                "rd_merged": 0,
                 "wr_merged": 0,
-                "wr_bytes": 0,
-                "timed_stats": [
-                ],
-                "failed_unmap_operations": 0,
                 "zone_append_merged": 0,
+                "unmap_merged": 0,
+                "failed_rd_operations": 0,
+                "failed_wr_operations": 0,
+                "failed_zone_append_operations": 0,
                 "failed_flush_operations": 0,
-                "account_invalid": true,
-                "rd_total_time_ns": 0,
-                "invalid_unmap_operations": 0,
-                "flush_operations": 0,
-                "wr_operations": 0,
-                "unmap_bytes": 0,
-                "rd_merged": 0,
-                "rd_bytes": 0,
-                "unmap_total_time_ns": 0,
+                "failed_unmap_operations": 0,
+                "invalid_rd_operations": 0,
+                "invalid_wr_operations": 0,
+                "invalid_zone_append_operations": 0,
                 "invalid_flush_operations": 0,
+                "invalid_unmap_operations": 0,
+                "account_invalid": true,
                 "account_failed": true,
-                "zone_append_total_time_ns": 0,
-                "zone_append_operations": 0,
-                "rd_operations": 0,
-                "zone_append_bytes": 0,
-                "invalid_zone_append_operations": 0,
-                "invalid_wr_operations": 0,
-                "invalid_rd_operations": 0
-            },
-            "node-name": "NODE_NAME",
-            "qdev": "/machine/peripheral-anon/device[0]/virtio-backend"
+                "timed_stats": [
+                ]
+            }
         }
     ]
 }
@@ -59,11 +59,11 @@ Testing: -drive driver=3Dnull-co,read-zeroes=3Don,if=3D=
virtio
     }
 }
 {
+    "event": "SHUTDOWN",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "SHUTDOWN",
     "data": {
         "guest": false,
         "reason": "host-qmp-quit"
@@ -85,42 +85,42 @@ Testing: -drive driver=3Dnull-co,if=3Dnone
     "return": [
         {
             "device": "none0",
+            "node-name": "NODE_NAME",
             "stats": {
+                "rd_bytes": 0,
+                "wr_bytes": 0,
+                "zone_append_bytes": 0,
+                "unmap_bytes": 0,
+                "rd_operations": 0,
+                "wr_operations": 0,
+                "zone_append_operations": 0,
+                "flush_operations": 0,
                 "unmap_operations": 0,
-                "unmap_merged": 0,
-                "failed_zone_append_operations": 0,
+                "rd_total_time_ns": 0,
+                "wr_total_time_ns": 0,
+                "zone_append_total_time_ns": 0,
                 "flush_total_time_ns": 0,
+                "unmap_total_time_ns": 0,
                 "wr_highest_offset": 0,
-                "wr_total_time_ns": 0,
-                "failed_wr_operations": 0,
-                "failed_rd_operations": 0,
+                "rd_merged": 0,
                 "wr_merged": 0,
-                "wr_bytes": 0,
-                "timed_stats": [
-                ],
-                "failed_unmap_operations": 0,
                 "zone_append_merged": 0,
+                "unmap_merged": 0,
+                "failed_rd_operations": 0,
+                "failed_wr_operations": 0,
+                "failed_zone_append_operations": 0,
                 "failed_flush_operations": 0,
-                "account_invalid": true,
-                "rd_total_time_ns": 0,
-                "invalid_unmap_operations": 0,
-                "flush_operations": 0,
-                "wr_operations": 0,
-                "unmap_bytes": 0,
-                "rd_merged": 0,
-                "rd_bytes": 0,
-                "unmap_total_time_ns": 0,
+                "failed_unmap_operations": 0,
+                "invalid_rd_operations": 0,
+                "invalid_wr_operations": 0,
+                "invalid_zone_append_operations": 0,
                 "invalid_flush_operations": 0,
+                "invalid_unmap_operations": 0,
+                "account_invalid": true,
                 "account_failed": true,
-                "zone_append_total_time_ns": 0,
-                "zone_append_operations": 0,
-                "rd_operations": 0,
-                "zone_append_bytes": 0,
-                "invalid_zone_append_operations": 0,
-                "invalid_wr_operations": 0,
-                "invalid_rd_operations": 0
-            },
-            "node-name": "NODE_NAME"
+                "timed_stats": [
+                ]
+            }
         }
     ]
 }
@@ -129,11 +129,11 @@ Testing: -drive driver=3Dnull-co,if=3Dnone
     }
 }
 {
+    "event": "SHUTDOWN",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "SHUTDOWN",
     "data": {
         "guest": false,
         "reason": "host-qmp-quit"
@@ -160,11 +160,11 @@ Testing: -blockdev driver=3Dnull-co,node-name=3Dnull
     }
 }
 {
+    "event": "SHUTDOWN",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "SHUTDOWN",
     "data": {
         "guest": false,
         "reason": "host-qmp-quit"
@@ -186,43 +186,43 @@ Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,=
node-name=3Dnull -device virtio-b
     "return": [
         {
             "device": "",
+            "qdev": "/machine/peripheral/virtio0/virtio-backend",
+            "node-name": "null",
             "stats": {
+                "rd_bytes": 0,
+                "wr_bytes": 0,
+                "zone_append_bytes": 0,
+                "unmap_bytes": 0,
+                "rd_operations": 0,
+                "wr_operations": 0,
+                "zone_append_operations": 0,
+                "flush_operations": 0,
                 "unmap_operations": 0,
-                "unmap_merged": 0,
-                "failed_zone_append_operations": 0,
+                "rd_total_time_ns": 0,
+                "wr_total_time_ns": 0,
+                "zone_append_total_time_ns": 0,
                 "flush_total_time_ns": 0,
+                "unmap_total_time_ns": 0,
                 "wr_highest_offset": 0,
-                "wr_total_time_ns": 0,
-                "failed_wr_operations": 0,
-                "failed_rd_operations": 0,
+                "rd_merged": 0,
                 "wr_merged": 0,
-                "wr_bytes": 0,
-                "timed_stats": [
-                ],
-                "failed_unmap_operations": 0,
                 "zone_append_merged": 0,
+                "unmap_merged": 0,
+                "failed_rd_operations": 0,
+                "failed_wr_operations": 0,
+                "failed_zone_append_operations": 0,
                 "failed_flush_operations": 0,
-                "account_invalid": true,
-                "rd_total_time_ns": 0,
-                "invalid_unmap_operations": 0,
-                "flush_operations": 0,
-                "wr_operations": 0,
-                "unmap_bytes": 0,
-                "rd_merged": 0,
-                "rd_bytes": 0,
-                "unmap_total_time_ns": 0,
+                "failed_unmap_operations": 0,
+                "invalid_rd_operations": 0,
+                "invalid_wr_operations": 0,
+                "invalid_zone_append_operations": 0,
                 "invalid_flush_operations": 0,
+                "invalid_unmap_operations": 0,
+                "account_invalid": true,
                 "account_failed": true,
-                "zone_append_total_time_ns": 0,
-                "zone_append_operations": 0,
-                "rd_operations": 0,
-                "zone_append_bytes": 0,
-                "invalid_zone_append_operations": 0,
-                "invalid_wr_operations": 0,
-                "invalid_rd_operations": 0
-            },
-            "node-name": "null",
-            "qdev": "/machine/peripheral/virtio0/virtio-backend"
+                "timed_stats": [
+                ]
+            }
         }
     ]
 }
@@ -231,11 +231,11 @@ Testing: -blockdev driver=3Dnull-co,read-zeroes=3Don,=
node-name=3Dnull -device virtio-b
     }
 }
 {
+    "event": "SHUTDOWN",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "SHUTDOWN",
     "data": {
         "guest": false,
         "reason": "host-qmp-quit"
diff --git a/tests/qemu-iotests/229.out b/tests/qemu-iotests/229.out
index 7d2bfbfbe6..3f4391df6e 100644
--- a/tests/qemu-iotests/229.out
+++ b/tests/qemu-iotests/229.out
@@ -16,19 +16,19 @@ wrote 2097152/2097152 bytes at offset 0
                                'mode':   'existing',
                                'on-source-error': 'stop',
                                'on-target-error': 'stop' }}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "testdisk"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "testdisk"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "testdisk", "status": "created"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "testdisk", "status": "running"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_ERROR", "data": {"device": "testdisk", "operation": "write", "=
action": "stop"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "testdisk"}}
+{"event": "BLOCK_JOB_ERROR", "timestamp": {"seconds":  TIMESTAMP, "microse=
conds":  TIMESTAMP}, "data": {"device": "testdisk", "operation": "write", "=
action": "stop"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "testdisk", "status": "paused"}}
=20
 =3D=3D=3D Force cancel job paused in error state  =3D=3D=3D
=20
 {'execute': 'block-job-cancel',
                  'arguments': { 'device': 'testdisk',
                                 'force': true}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "testdisk"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "testdisk", "status": "running"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "testdisk"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_CANCELLED", "data": {"device": "testdisk", "len": 2097152, "of=
fset": OFFSET, "speed": 0, "type": "mirror"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "testdisk", "status": "aborting"}}
+{"event": "BLOCK_JOB_CANCELLED", "timestamp": {"seconds":  TIMESTAMP, "mic=
roseconds":  TIMESTAMP}, "data": {"type": "mirror", "device": "testdisk", "=
len": 2097152, "offset": OFFSET, "speed": 0}}
 *** done
diff --git a/tests/qemu-iotests/244.out b/tests/qemu-iotests/244.out
index 5e03add054..57cffee1ea 100644
--- a/tests/qemu-iotests/244.out
+++ b/tests/qemu-iotests/244.out
@@ -156,14 +156,14 @@ wrote 1048576/1048576 bytes at offset 0
                "data-file": "data",
                "data-file-raw": true
            } } }
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "create"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "create"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "create", "status": "created"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "create", "status": "running"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "create"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "create"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "create"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "create", "status": "waiting"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "create", "status": "pending"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "create", "status": "concluded"}}
 { "execute": "job-dismiss", "arguments": { "id": "create" } }
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "create"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "create", "status": "null"}}
 {"return": {}}
=20
 Comparing pattern:
diff --git a/tests/qemu-iotests/247.out b/tests/qemu-iotests/247.out
index e909e83994..e3a051fb5e 100644
--- a/tests/qemu-iotests/247.out
+++ b/tests/qemu-iotests/247.out
@@ -9,14 +9,14 @@ Formatting 'TEST_DIR/t.IMGFMT.3', fmt=3DIMGFMT size=3D134=
217728
 Formatting 'TEST_DIR/t.IMGFMT.4', fmt=3DIMGFMT size=3D134217728
 QMP_VERSION
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "created"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "running"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "job0", "len": 134217728, "offs=
et": 134217728, "speed": 0, "type": "commit"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "waiting"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "pending"}}
+{"event": "BLOCK_JOB_COMPLETED", "timestamp": {"seconds":  TIMESTAMP, "mic=
roseconds":  TIMESTAMP}, "data": {"type": "commit", "device": "job0", "len"=
: 134217728, "offset": 134217728, "speed": 0}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "concluded"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "null"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"event": "SHUTDOWN", "timestamp": {"seconds":  TIMESTAMP, "microseconds":=
  TIMESTAMP}, "data": {"guest": false, "reason": "host-qmp-quit"}}
 *** done
diff --git a/tests/qemu-iotests/249.out b/tests/qemu-iotests/249.out
index d2bf9be85e..a1a1a1b851 100644
--- a/tests/qemu-iotests/249.out
+++ b/tests/qemu-iotests/249.out
@@ -16,8 +16,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D10485=
76 backing_file=3DTEST_DIR/t.
 { 'execute': 'block-commit',
        'arguments': {'job-id': 'job0', 'device': 'none1', 'top-node': 'int=
',
                      'filter-node-name': '1234'}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "created"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "null"}}
 {"error": {"class": "GenericError", "desc": "Invalid node-name: '1234'"}}
=20
 =3D=3D=3D Send a write command to a drive opened in read-only mode (2)
@@ -30,14 +30,14 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D104=
8576 backing_file=3DTEST_DIR/t.
=20
 { 'execute': 'block-commit',
        'arguments': {'job-id': 'job0', 'device': 'none1', 'top-node': 'int=
'}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "created"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "running"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "job0", "len": 1048576, "offset=
": 1048576, "speed": 0, "type": "commit"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "waiting"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "pending"}}
+{"event": "BLOCK_JOB_COMPLETED", "timestamp": {"seconds":  TIMESTAMP, "mic=
roseconds":  TIMESTAMP}, "data": {"type": "commit", "device": "job0", "len"=
: 1048576, "offset": 1048576, "speed": 0}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "concluded"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "null"}}
=20
 =3D=3D=3D Send a write command to a drive opened in read-only mode (3)
=20
diff --git a/tests/qemu-iotests/273.out b/tests/qemu-iotests/273.out
index 6a74a8138b..88c6011eb8 100644
--- a/tests/qemu-iotests/273.out
+++ b/tests/qemu-iotests/273.out
@@ -21,263 +21,263 @@ Testing: -blockdev file,node-name=3Dbase,filename=3DT=
EST_DIR/t.IMGFMT.base -blockdev
 {
     "return": [
         {
-            "iops_rd": 0,
+            "file": "TEST_DIR/t.IMGFMT",
+            "node-name": "top",
+            "ro": false,
+            "drv": "IMGFMT",
+            "backing_file": "TEST_DIR/t.IMGFMT.mid",
+            "backing_file_depth": 2,
+            "encrypted": false,
             "detect_zeroes": "off",
+            "bps": 0,
+            "bps_rd": 0,
+            "bps_wr": 0,
+            "iops": 0,
+            "iops_rd": 0,
+            "iops_wr": 0,
             "image": {
+                "filename": "TEST_DIR/t.IMGFMT",
+                "format": "IMGFMT",
+                "dirty-flag": false,
+                "actual-size": SIZE,
+                "virtual-size": 67108864,
+                "cluster-size": 65536,
+                "backing-filename": "TEST_DIR/t.IMGFMT.mid",
+                "full-backing-filename": "TEST_DIR/t.IMGFMT.mid",
+                "backing-filename-format": "IMGFMT",
                 "backing-image": {
-                    "backing-image": {
-                        "virtual-size": 197120,
-                        "filename": "TEST_DIR/t.IMGFMT.base",
-                        "format": "file",
-                        "actual-size": SIZE,
-                        "dirty-flag": false
-                    },
-                    "backing-filename-format": "IMGFMT",
-                    "virtual-size": 67108864,
                     "filename": "TEST_DIR/t.IMGFMT.mid",
-                    "cluster-size": 65536,
                     "format": "IMGFMT",
+                    "dirty-flag": false,
                     "actual-size": SIZE,
-                    "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                    "virtual-size": 67108864,
+                    "cluster-size": 65536,
                     "backing-filename": "TEST_DIR/t.IMGFMT.base",
-                    "dirty-flag": false
-                },
-                "backing-filename-format": "IMGFMT",
-                "virtual-size": 67108864,
-                "filename": "TEST_DIR/t.IMGFMT",
-                "cluster-size": 65536,
-                "format": "IMGFMT",
-                "actual-size": SIZE,
-                "full-backing-filename": "TEST_DIR/t.IMGFMT.mid",
-                "backing-filename": "TEST_DIR/t.IMGFMT.mid",
-                "dirty-flag": false
+                    "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                    "backing-filename-format": "IMGFMT",
+                    "backing-image": {
+                        "filename": "TEST_DIR/t.IMGFMT.base",
+                        "format": "file",
+                        "dirty-flag": false,
+                        "actual-size": SIZE,
+                        "virtual-size": 197120,
+                    }
+                }
             },
-            "iops_wr": 0,
-            "ro": false,
-            "node-name": "top",
-            "backing_file_depth": 2,
-            "drv": "IMGFMT",
-            "iops": 0,
-            "bps_wr": 0,
-            "write_threshold": 0,
-            "backing_file": "TEST_DIR/t.IMGFMT.mid",
-            "encrypted": false,
-            "bps": 0,
-            "bps_rd": 0,
             "cache": {
-                "no-flush": false,
+                "writeback": true,
                 "direct": false,
-                "writeback": true
+                "no-flush": false
             },
-            "file": "TEST_DIR/t.IMGFMT"
+            "write_threshold": 0
         },
         {
-            "iops_rd": 0,
+            "file": "TEST_DIR/t.IMGFMT",
+            "node-name": "topf",
+            "ro": false,
+            "drv": "file",
+            "backing_file_depth": 0,
+            "encrypted": false,
             "detect_zeroes": "off",
+            "bps": 0,
+            "bps_rd": 0,
+            "bps_wr": 0,
+            "iops": 0,
+            "iops_rd": 0,
+            "iops_wr": 0,
             "image": {
-                "virtual-size": 197120,
                 "filename": "TEST_DIR/t.IMGFMT",
                 "format": "file",
+                "dirty-flag": false,
                 "actual-size": SIZE,
-                "dirty-flag": false
+                "virtual-size": 197120,
             },
-            "iops_wr": 0,
-            "ro": false,
-            "node-name": "topf",
-            "backing_file_depth": 0,
-            "drv": "file",
-            "iops": 0,
-            "bps_wr": 0,
-            "write_threshold": 0,
-            "encrypted": false,
-            "bps": 0,
-            "bps_rd": 0,
             "cache": {
-                "no-flush": false,
+                "writeback": true,
                 "direct": false,
-                "writeback": true
+                "no-flush": false
             },
-            "file": "TEST_DIR/t.IMGFMT"
+            "write_threshold": 0
         },
         {
-            "iops_rd": 0,
+            "file": "TEST_DIR/t.IMGFMT.mid",
+            "node-name": "mid",
+            "ro": true,
+            "drv": "IMGFMT",
+            "backing_file": "TEST_DIR/t.IMGFMT.base",
+            "backing_file_depth": 1,
+            "encrypted": false,
             "detect_zeroes": "off",
+            "bps": 0,
+            "bps_rd": 0,
+            "bps_wr": 0,
+            "iops": 0,
+            "iops_rd": 0,
+            "iops_wr": 0,
             "image": {
-                "backing-image": {
-                    "virtual-size": 197120,
-                    "filename": "TEST_DIR/t.IMGFMT.base",
-                    "format": "file",
-                    "actual-size": SIZE,
-                    "dirty-flag": false
-                },
-                "backing-filename-format": "IMGFMT",
-                "virtual-size": 67108864,
                 "filename": "TEST_DIR/t.IMGFMT.mid",
-                "cluster-size": 65536,
                 "format": "IMGFMT",
+                "dirty-flag": false,
                 "actual-size": SIZE,
-                "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                "virtual-size": 67108864,
+                "cluster-size": 65536,
                 "backing-filename": "TEST_DIR/t.IMGFMT.base",
-                "dirty-flag": false
+                "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
+                "backing-filename-format": "IMGFMT",
+                "backing-image": {
+                    "filename": "TEST_DIR/t.IMGFMT.base",
+                    "format": "file",
+                    "dirty-flag": false,
+                    "actual-size": SIZE,
+                    "virtual-size": 197120,
+                }
             },
-            "iops_wr": 0,
-            "ro": true,
-            "node-name": "mid",
-            "backing_file_depth": 1,
-            "drv": "IMGFMT",
-            "iops": 0,
-            "bps_wr": 0,
-            "write_threshold": 0,
-            "backing_file": "TEST_DIR/t.IMGFMT.base",
-            "encrypted": false,
-            "bps": 0,
-            "bps_rd": 0,
             "cache": {
-                "no-flush": false,
+                "writeback": true,
                 "direct": false,
-                "writeback": true
+                "no-flush": false
             },
-            "file": "TEST_DIR/t.IMGFMT.mid"
+            "write_threshold": 0
         },
         {
-            "iops_rd": 0,
+            "file": "TEST_DIR/t.IMGFMT.mid",
+            "node-name": "midf",
+            "ro": false,
+            "drv": "file",
+            "backing_file_depth": 0,
+            "encrypted": false,
             "detect_zeroes": "off",
+            "bps": 0,
+            "bps_rd": 0,
+            "bps_wr": 0,
+            "iops": 0,
+            "iops_rd": 0,
+            "iops_wr": 0,
             "image": {
-                "virtual-size": 197120,
                 "filename": "TEST_DIR/t.IMGFMT.mid",
                 "format": "file",
+                "dirty-flag": false,
                 "actual-size": SIZE,
-                "dirty-flag": false
+                "virtual-size": 197120,
             },
-            "iops_wr": 0,
-            "ro": false,
-            "node-name": "midf",
-            "backing_file_depth": 0,
-            "drv": "file",
-            "iops": 0,
-            "bps_wr": 0,
-            "write_threshold": 0,
-            "encrypted": false,
-            "bps": 0,
-            "bps_rd": 0,
             "cache": {
-                "no-flush": false,
+                "writeback": true,
                 "direct": false,
-                "writeback": true
+                "no-flush": false
             },
-            "file": "TEST_DIR/t.IMGFMT.mid"
+            "write_threshold": 0
         },
         {
-            "iops_rd": 0,
+            "file": "TEST_DIR/t.IMGFMT.base",
+            "node-name": "base",
+            "ro": true,
+            "drv": "file",
+            "backing_file_depth": 0,
+            "encrypted": false,
             "detect_zeroes": "off",
+            "bps": 0,
+            "bps_rd": 0,
+            "bps_wr": 0,
+            "iops": 0,
+            "iops_rd": 0,
+            "iops_wr": 0,
             "image": {
-                "virtual-size": 197120,
                 "filename": "TEST_DIR/t.IMGFMT.base",
                 "format": "file",
+                "dirty-flag": false,
                 "actual-size": SIZE,
-                "dirty-flag": false
+                "virtual-size": 197120,
             },
-            "iops_wr": 0,
-            "ro": true,
-            "node-name": "base",
-            "backing_file_depth": 0,
-            "drv": "file",
-            "iops": 0,
-            "bps_wr": 0,
-            "write_threshold": 0,
-            "encrypted": false,
-            "bps": 0,
-            "bps_rd": 0,
             "cache": {
-                "no-flush": false,
+                "writeback": true,
                 "direct": false,
-                "writeback": true
+                "no-flush": false
             },
-            "file": "TEST_DIR/t.IMGFMT.base"
+            "write_threshold": 0
         }
     ]
 }
 {
     "return": {
+        "nodes": [
+            {
+                "id": 5,
+                "type": "block-driver",
+                "name": "top"
+            },
+            {
+                "id": 4,
+                "type": "block-driver",
+                "name": "topf"
+            },
+            {
+                "id": 3,
+                "type": "block-driver",
+                "name": "mid"
+            },
+            {
+                "id": 2,
+                "type": "block-driver",
+                "name": "midf"
+            },
+            {
+                "id": 1,
+                "type": "block-driver",
+                "name": "base"
+            }
+        ],
         "edges": [
             {
-                "name": "file",
                 "parent": 5,
-                "shared-perm": [
-                    "write-unchanged",
-                    "consistent-read"
-                ],
+                "child": 4,
+                "name": "file",
                 "perm": [
                     "resize",
                     "write",
                     "consistent-read"
                 ],
-                "child": 4
+                "shared-perm": [
+                    "write-unchanged",
+                    "consistent-read"
+                ]
             },
             {
-                "name": "backing",
                 "parent": 5,
+                "child": 3,
+                "name": "backing",
+                "perm": [
+                ],
                 "shared-perm": [
                     "resize",
                     "write-unchanged",
                     "write",
                     "consistent-read"
-                ],
-                "perm": [
-                ],
-                "child": 3
+                ]
             },
             {
-                "name": "file",
                 "parent": 3,
-                "shared-perm": [
-                    "write-unchanged",
-                    "consistent-read"
-                ],
+                "child": 2,
+                "name": "file",
                 "perm": [
                     "consistent-read"
                 ],
-                "child": 2
+                "shared-perm": [
+                    "write-unchanged",
+                    "consistent-read"
+                ]
             },
             {
-                "name": "backing",
                 "parent": 3,
+                "child": 1,
+                "name": "backing",
+                "perm": [
+                ],
                 "shared-perm": [
                     "resize",
                     "write-unchanged",
                     "write",
                     "consistent-read"
-                ],
-                "perm": [
-                ],
-                "child": 1
-            }
-        ],
-        "nodes": [
-            {
-                "name": "top",
-                "type": "block-driver",
-                "id": 5
-            },
-            {
-                "name": "topf",
-                "type": "block-driver",
-                "id": 4
-            },
-            {
-                "name": "mid",
-                "type": "block-driver",
-                "id": 3
-            },
-            {
-                "name": "midf",
-                "type": "block-driver",
-                "id": 2
-            },
-            {
-                "name": "base",
-                "type": "block-driver",
-                "id": 1
+                ]
             }
         ]
     }
@@ -287,11 +287,11 @@ Testing: -blockdev file,node-name=3Dbase,filename=3DT=
EST_DIR/t.IMGFMT.base -blockdev
     }
 }
 {
+    "event": "SHUTDOWN",
     "timestamp": {
         "seconds":  TIMESTAMP,
         "microseconds":  TIMESTAMP
     },
-    "event": "SHUTDOWN",
     "data": {
         "guest": false,
         "reason": "host-qmp-quit"
diff --git a/tests/qemu-iotests/tests/iothreads-resize.out b/tests/qemu-iot=
ests/tests/iothreads-resize.out
index 2ca5a9d964..98d40acf1d 100644
--- a/tests/qemu-iotests/tests/iothreads-resize.out
+++ b/tests/qemu-iotests/tests/iothreads-resize.out
@@ -4,7 +4,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"event": "SHUTDOWN", "timestamp": {"seconds":  TIMESTAMP, "microseconds":=
  TIMESTAMP}, "data": {"guest": false, "reason": "host-qmp-quit"}}
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
diff --git a/tests/qemu-iotests/tests/qsd-jobs.out b/tests/qemu-iotests/tes=
ts/qsd-jobs.out
index c1bc9b8356..336a5c3946 100644
--- a/tests/qemu-iotests/tests/qsd-jobs.out
+++ b/tests/qemu-iotests/tests/qsd-jobs.out
@@ -8,15 +8,15 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_CANCELLED", "data": {"device": "job0", "len": 0, "offset": 0, =
"speed": 0, "type": "commit"}}
+{"event": "BLOCK_JOB_CANCELLED", "timestamp": {"seconds":  TIMESTAMP, "mic=
roseconds":  TIMESTAMP}, "data": {"type": "commit", "device": "job0", "len"=
: 0, "offset": 0, "speed": 0}}
=20
 =3D=3D=3D Streaming can't get permission on base node =3D=3D=3D
=20
 QMP_VERSION
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "created"}}
+{"event": "JOB_STATUS_CHANGE", "timestamp": {"seconds":  TIMESTAMP, "micro=
seconds":  TIMESTAMP}, "data": {"id": "job0", "status": "null"}}
 {"error": {"class": "GenericError", "desc": "Permission conflict on node '=
fmt_base': permissions 'write' are both required by an unnamed block device=
 (uses node 'fmt_base' as 'root' child) and unshared by stream job 'job0' (=
uses node 'fmt_base' as 'intermediate node' child)."}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_EXPORT_DELETED", "data": {"id": "export1"}}
+{"event": "BLOCK_EXPORT_DELETED", "timestamp": {"seconds":  TIMESTAMP, "mi=
croseconds":  TIMESTAMP}, "data": {"id": "export1"}}
 *** done
diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index 3fc33fc24d..151726a1bc 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -229,7 +229,7 @@ static uint64_t resp_get_sve_vls(QDict *resp)
=20
     props =3D resp_get_props(resp);
=20
-    for (e =3D qdict_first(props); e; e =3D qdict_next(props, e)) {
+    for (e =3D qdict_first(props); e; e =3D qdict_next(e)) {
         if (strlen(e->key) > 3 && !strncmp(e->key, "sve", 3) &&
             g_ascii_isdigit(e->key[3])) {
             char *endptr;
diff --git a/tests/unit/check-block-qdict.c b/tests/unit/check-block-qdict.c
index 751c58e737..6b1cf2dc54 100644
--- a/tests/unit/check-block-qdict.c
+++ b/tests/unit/check-block-qdict.c
@@ -516,7 +516,7 @@ static int qdict_count_entries(QDict *dict)
     const QDictEntry *e;
     int count =3D 0;
=20
-    for (e =3D qdict_first(dict); e; e =3D qdict_next(dict, e)) {
+    for (e =3D qdict_first(dict); e; e =3D qdict_next(e)) {
         count++;
     }
=20
diff --git a/tests/unit/check-qdict.c b/tests/unit/check-qdict.c
index b5efa859b0..288c5a10bc 100644
--- a/tests/unit/check-qdict.c
+++ b/tests/unit/check-qdict.c
@@ -209,7 +209,7 @@ static void qdict_iterapi_test(void)
     qdict_put_int(tests_dict, "key3", 3);
=20
     count =3D 0;
-    for (ent =3D qdict_first(tests_dict); ent; ent =3D qdict_next(tests_di=
ct, ent)){
+    for (ent =3D qdict_first(tests_dict); ent; ent =3D qdict_next(ent)) {
         g_assert(qdict_haskey(tests_dict, qdict_entry_key(ent)) =3D=3D 1);
         count++;
     }
@@ -218,7 +218,7 @@ static void qdict_iterapi_test(void)
=20
     /* Do it again to test restarting */
     count =3D 0;
-    for (ent =3D qdict_first(tests_dict); ent; ent =3D qdict_next(tests_di=
ct, ent)){
+    for (ent =3D qdict_first(tests_dict); ent; ent =3D qdict_next(ent)) {
         g_assert(qdict_haskey(tests_dict, qdict_entry_key(ent)) =3D=3D 1);
         count++;
     }
diff --git a/util/keyval.c b/util/keyval.c
index 66a5b4740f..9e95f08e8a 100644
--- a/util/keyval.c
+++ b/util/keyval.c
@@ -325,7 +325,7 @@ static void keyval_do_merge(QDict *dest, const QDict *m=
erged, GString *str, Erro
     const QDictEntry *ent;
     QObject *old_value;
=20
-    for (ent =3D qdict_first(merged); ent; ent =3D qdict_next(merged, ent)=
) {
+    for (ent =3D qdict_first(merged); ent; ent =3D qdict_next(ent)) {
         old_value =3D qdict_get(dest, ent->key);
         if (old_value) {
             if (qobject_type(old_value) !=3D qobject_type(ent->value)) {
@@ -420,7 +420,7 @@ static QObject *keyval_listify(QDict *cur, GSList *key_=
of_cur, Error **errp)
      */
     has_index =3D false;
     has_member =3D false;
-    for (ent =3D qdict_first(cur); ent; ent =3D qdict_next(cur, ent)) {
+    for (ent =3D qdict_first(cur); ent; ent =3D qdict_next(ent)) {
         if (key_to_index(ent->key, NULL) >=3D 0) {
             has_index =3D true;
         } else {
@@ -456,7 +456,7 @@ static QObject *keyval_listify(QDict *cur, GSList *key_=
of_cur, Error **errp)
     nelt =3D qdict_size(cur) + 1; /* one extra, for use as sentinel */
     elt =3D g_new0(QObject *, nelt);
     max_index =3D -1;
-    for (ent =3D qdict_first(cur); ent; ent =3D qdict_next(cur, ent)) {
+    for (ent =3D qdict_first(cur); ent; ent =3D qdict_next(ent)) {
         index =3D key_to_index(ent->key, NULL);
         assert(index >=3D 0);
         if (index > max_index) {
diff --git a/util/qemu-option.c b/util/qemu-option.c
index eedd08929b..6245429193 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -999,7 +999,7 @@ QemuOpts *qemu_opts_from_qdict(QemuOptsList *list, cons=
t QDict *qdict,
=20
     for (entry =3D qdict_first(qdict);
          entry;
-         entry =3D qdict_next(qdict, entry)) {
+         entry =3D qdict_next(entry)) {
         if (!qemu_opts_from_qdict_entry(opts, entry, errp)) {
             qemu_opts_del(opts);
             return NULL;
@@ -1021,7 +1021,7 @@ bool qemu_opts_absorb_qdict(QemuOpts *opts, QDict *qd=
ict, Error **errp)
     entry =3D qdict_first(qdict);
=20
     while (entry !=3D NULL) {
-        next =3D qdict_next(qdict, entry);
+        next =3D qdict_next(entry);
=20
         if (opts_accepts_any(opts->list) ||
             find_desc_by_name(opts->list->desc, entry->key)) {
--=20
2.37.1 (Apple Git-137.1)


