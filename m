Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1667A8BD9
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:33:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj20B-0005WK-3u; Wed, 20 Sep 2023 14:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qj1zZ-0005KG-Vt
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:32:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qj1zW-0002vq-57
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695234719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4d8o9jVLRrQAC/C156ADyMbZ06/G9fhC8Of9ewcXqM0=;
 b=W67gtMvzRloIPTmlpeK7youFphII4ztkfdMNrc/s4B72DeeVp6pSNI5SRkbfMcvDA2Yd8r
 ky8DpeR/q/KLJ16pGwq+/gadniJfbq9pLULvNChVkxmDqrsZSG4SajK/LOZWyER2Xrw4ZO
 zualXCrfS6fCW3zJ8ObU3GkrP7RvkuU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-hrEPizR0PjKkhEZ8z8iLZA-1; Wed, 20 Sep 2023 14:31:54 -0400
X-MC-Unique: hrEPizR0PjKkhEZ8z8iLZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC7CE28EC10E;
 Wed, 20 Sep 2023 18:31:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 64D8A40C6EBF;
 Wed, 20 Sep 2023 18:31:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4A41521E690E; Wed, 20 Sep 2023 20:31:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, idryomov@gmail.com,
 pl@kamp.de, sw@weilnetz.de, sstabellini@kernel.org,
 anthony.perard@citrix.com, paul@xen.org, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, stefanha@redhat.com, fam@euphon.net,
 quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 kraxel@redhat.com, qemu-block@nongnu.org, xen-devel@lists.xenproject.org,
 alex.bennee@linaro.org, peter.maydell@linaro.org
Subject: [PATCH v2 7/7] qobject atomics osdep: Make a few macros more hygienic
Date: Wed, 20 Sep 2023 20:31:49 +0200
Message-ID: <20230920183149.1105333-8-armbru@redhat.com>
In-Reply-To: <20230920183149.1105333-1-armbru@redhat.com>
References: <20230920183149.1105333-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Variables declared in macros can shadow other variables.  Much of the
time, this is harmless, e.g.:

    #define _FDT(exp)                                                  \
        do {                                                           \
            int ret = (exp);                                           \
            if (ret < 0) {                                             \
                error_report("error creating device tree: %s: %s",   \
                        #exp, fdt_strerror(ret));                      \
                exit(1);                                               \
            }                                                          \
        } while (0)

Harmless shadowing in h_client_architecture_support():

        target_ulong ret;

        [...]

        ret = do_client_architecture_support(cpu, spapr, vec, fdt_bufsize);
        if (ret == H_SUCCESS) {
            _FDT((fdt_pack(spapr->fdt_blob)));
            [...]
        }

        return ret;

However, we can get in trouble when the shadowed variable is used in a
macro argument:

    #define QOBJECT(obj) ({                                 \
        typeof(obj) o = (obj);                              \
        o ? container_of(&(o)->base, QObject, base) : NULL; \
     })

QOBJECT(o) expands into

    ({
--->    typeof(o) o = (o);
        o ? container_of(&(o)->base, QObject, base) : NULL;
    })

Unintended variable name capture at --->.  We'd be saved by
-Winit-self.  But I could certainly construct more elaborate death
traps that don't trigger it.

To reduce the risk of trapping ourselves, we use variable names in
macros that no sane person would use elsewhere.  Here's our actual
definition of QOBJECT():

    #define QOBJECT(obj) ({                                         \
        typeof(obj) _obj = (obj);                                   \
        _obj ? container_of(&(_obj)->base, QObject, base) : NULL;   \
    })

Works well enough until we nest macro calls.  For instance, with

    #define qobject_ref(obj) ({                     \
        typeof(obj) _obj = (obj);                   \
        qobject_ref_impl(QOBJECT(_obj));            \
        _obj;                                       \
    })

the expression qobject_ref(obj) expands into

    ({
        typeof(obj) _obj = (obj);
        qobject_ref_impl(
            ({
--->            typeof(_obj) _obj = (_obj);
                _obj ? container_of(&(_obj)->base, QObject, base) : NULL;
            }));
        _obj;
    })

Unintended variable name capture at --->.

The only reliable way to prevent unintended variable name capture is
-Wshadow.

One blocker for enabling it is shadowing hiding in function-like
macros like

     qdict_put(dict, "name", qobject_ref(...))

qdict_put() wraps its last argument in QOBJECT(), and the last
argument here contains another QOBJECT().

Use dark preprocessor sorcery to make the macros that give us this
problem use different variable names on every call.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qmp/qobject.h | 11 +++++++++--
 include/qemu/atomic.h      | 17 ++++++++++++-----
 include/qemu/compiler.h    |  3 +++
 include/qemu/osdep.h       | 31 +++++++++++++++++++++++--------
 4 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
index 9003b71fd3..d36cc97805 100644
--- a/include/qapi/qmp/qobject.h
+++ b/include/qapi/qmp/qobject.h
@@ -45,10 +45,17 @@ struct QObject {
     struct QObjectBase_ base;
 };
 
-#define QOBJECT(obj) ({                                         \
+/*
+ * Preprocessory sorcery ahead: use a different identifier for the
+ * local variable in each expansion, so we can nest macro calls
+ * without shadowing variables.
+ */
+#define QOBJECT_INTERNAL(obj, _obj) ({                          \
     typeof(obj) _obj = (obj);                                   \
-    _obj ? container_of(&(_obj)->base, QObject, base) : NULL;   \
+    _obj                                                        \
+        ? container_of(&(_obj)->base, QObject, base) : NULL;    \
 })
+#define QOBJECT(obj) QOBJECT_INTERNAL((obj), MAKE_IDENTFIER(_obj))
 
 /* Required for qobject_to() */
 #define QTYPE_CAST_TO_QNull     QTYPE_QNULL
diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index d95612f7a0..d4cbd01909 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -157,13 +157,20 @@
     smp_read_barrier_depends();
 #endif
 
-#define qatomic_rcu_read(ptr)                          \
-    ({                                                 \
+/*
+ * Preprocessory sorcery ahead: use a different identifier for the
+ * local variable in each expansion, so we can nest macro calls
+ * without shadowing variables.
+ */
+#define qatomic_rcu_read_internal(ptr, _val)            \
+    ({                                                  \
     qemu_build_assert(sizeof(*ptr) <= ATOMIC_REG_SIZE); \
-    typeof_strip_qual(*ptr) _val;                      \
-    qatomic_rcu_read__nocheck(ptr, &_val);             \
-    _val;                                              \
+    typeof_strip_qual(*ptr) _val;                       \
+    qatomic_rcu_read__nocheck(ptr, &_val);              \
+    _val;                                               \
     })
+#define qatomic_rcu_read(ptr) \
+    qatomic_rcu_read_internal((ptr), MAKE_IDENTFIER(_val))
 
 #define qatomic_rcu_set(ptr, i) do {                   \
     qemu_build_assert(sizeof(*ptr) <= ATOMIC_REG_SIZE); \
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index a309f90c76..03236d830c 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -37,6 +37,9 @@
 #define tostring(s) #s
 #endif
 
+/* Expands into an identifier stemN, where N is another number each time */
+#define MAKE_IDENTFIER(stem) glue(stem, __COUNTER__)
+
 #ifndef likely
 #define likely(x)   __builtin_expect(!!(x), 1)
 #define unlikely(x)   __builtin_expect(!!(x), 0)
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 2897720fac..0d39bb1876 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -383,19 +383,28 @@ void QEMU_ERROR("code path is reachable")
  * determined by the pre-processor instead of the compiler, you'll
  * have to open-code it.  Sadly, Coverity is severely confused by the
  * constant variants, so we have to dumb things down there.
+ *
+ * Preprocessory sorcery ahead: use different identifiers for the
+ * local variables in each expansion, so we can nest macro calls
+ * without shadowing variables.
  */
-#undef MIN
-#define MIN(a, b)                                       \
+#define MIN_INTERNAL(a, b, _a, _b)                      \
     ({                                                  \
         typeof(1 ? (a) : (b)) _a = (a), _b = (b);       \
         _a < _b ? _a : _b;                              \
     })
-#undef MAX
-#define MAX(a, b)                                       \
+#undef MIN
+#define MIN(a, b) \
+    MIN_INTERNAL((a), (b), MAKE_IDENTFIER(_a), MAKE_IDENTFIER(_b))
+
+#define MAX_INTERNAL(a, b, _a, _b)                      \
     ({                                                  \
         typeof(1 ? (a) : (b)) _a = (a), _b = (b);       \
         _a > _b ? _a : _b;                              \
     })
+#undef MAX
+#define MAX(a, b) \
+    MAX_INTERNAL((a), (b), MAKE_IDENTFIER(_a), MAKE_IDENTFIER(_b))
 
 #ifdef __COVERITY__
 # define MIN_CONST(a, b) ((a) < (b) ? (a) : (b))
@@ -416,14 +425,20 @@ void QEMU_ERROR("code path is reachable")
 /*
  * Minimum function that returns zero only if both values are zero.
  * Intended for use with unsigned values only.
+ *
+ * Preprocessory sorcery ahead: use different identifiers for the
+ * local variables in each expansion, so we can nest macro calls
+ * without shadowing variables.
  */
-#ifndef MIN_NON_ZERO
-#define MIN_NON_ZERO(a, b)                              \
+#define MIN_NON_ZERO_INTERNAL(a, b, _a, _b)             \
     ({                                                  \
         typeof(1 ? (a) : (b)) _a = (a), _b = (b);       \
-        _a == 0 ? _b : (_b == 0 || _b > _a) ? _a : _b;  \
+        _a == 0 ? _b                                    \
+        : (_b == 0 || _b > _a) ? _a                     \
+        : _b;                                           \
     })
-#endif
+#define MIN_NON_ZERO(a, b) \
+    MIN_NON_ZERO_INTERNAL((a), (b), MAKE_IDENTFIER(_a), MAKE_IDENTFIER(_b))
 
 /*
  * Round number down to multiple. Safe when m is not a power of 2 (see
-- 
2.41.0


