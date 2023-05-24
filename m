Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1671B70FCB3
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 19:33:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1sL7-0004kf-Uw; Wed, 24 May 2023 13:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=50182a298=nsaenz@amazon.es>)
 id 1q1sL4-0004kS-OC
 for qemu-devel@nongnu.org; Wed, 24 May 2023 13:31:55 -0400
Received: from smtp-fw-80008.amazon.com ([99.78.197.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=50182a298=nsaenz@amazon.es>)
 id 1q1sL2-0000XL-F5
 for qemu-devel@nongnu.org; Wed, 24 May 2023 13:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1684949512; x=1716485512;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=pInfELZ+cRzpmlTS7+VGnPpbYkNotRLVmuBo4u2qrps=;
 b=AcoQvx92zInOB4wtdvqcH2ENpf6J4JTyjL94n1FGjRmgG+zOmqM2YRTB
 jP/iSOrk+O6cvol6rDYF0C/bMcqepbZKwCKwO/mWxIL4wATBTDCnpCjqS
 PCgeCzgTBwplkAJ07HAaQcyKt2piC8K6TlwIZ8JMOtFzCC0Goe3pJwPjI Q=;
X-IronPort-AV: E=Sophos;i="6.00,189,1681171200"; 
   d="scan'208";a="5584057"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com)
 ([10.25.36.210]) by smtp-border-fw-80008.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 17:31:47 +0000
Received: from EX19D004EUC001.ant.amazon.com
 (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
 by email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com (Postfix)
 with ESMTPS id 0EA23C0134; Wed, 24 May 2023 17:31:47 +0000 (UTC)
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 May 2023 17:31:43 +0000
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: <pbonzini@redhat.com>, <philmd@linaro.org>
CC: <marcandre.lureau@redhat.com>, <berrange@redhat.com>, <thuth@redhat.com>, 
 <hilmd@linaro.org>, <qemu-devel@nongnu.org>, Nicolas Saenz Julienne
 <nsaenz@amazon.com>
Subject: [PATCH] meson.build: Fix glib -Wno-unused-function workaround
Date: Wed, 24 May 2023 17:31:23 +0000
Message-ID: <20230524173123.66483-1-nsaenz@amazon.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.13.235.138]
X-ClientProxiedBy: EX19D036UWB003.ant.amazon.com (10.13.139.172) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)
Precedence: Bulk
Received-SPF: pass client-ip=99.78.197.219;
 envelope-from=prvs=50182a298=nsaenz@amazon.es; helo=smtp-fw-80008.amazon.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

We want to only enable '-Wno-unused-function' if glib's version is
smaller than '2.57.2' and has a G_DEFINE_AUTOPTR_CLEANUP_FUNC()
implementation that doesn't take into account unused functions. But the
compilation test isn't working as intended as '-Wunused-function' isn't
enabled while running it.

Let's enable it.

Fixes: fc9a809e0d28 ("build: move glib detection and workarounds to meson")
Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>

---

Meson logs before:

  Running compile:
  Working directory:  /local/home/nsaenz/c/qemu/build/meson-private/tmp5fgb3xnk
  Command line:  clang -m64 -mcx16 -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include /local/home/nsaenz/c/qemu/build/meson-private/tmp5fgb3xnk/testfile.c -o /local/home/nsaenz/c/qemu/build/meson-private/tmp5fgb3xnk/output.obj -c -D_FILE_OFFSET_BITS=64 -O0 -Werror=implicit-function-declaration -Werror=unknown-warning-option -Werror=unused-command-line-argument -Werror=ignored-optimization-argument -std=gnu11 -Werror

  Code:

    #include <glib.h>
    typedef struct Foo {
      int i;
    } Foo;
    static void foo_free(Foo *f)
    {
      g_free(f);
    }
    G_DEFINE_AUTOPTR_CLEANUP_FUNC(Foo, foo_free)
    int main(void) { return 0; }
  Compiler stdout:

  Compiler stderr:


Meson logs after:

  Running compile:
  Working directory:  /local/home/nsaenz/c/qemu/build/meson-private/tmp1fnp2s4u
  Command line:  clang -m64 -mcx16 -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include /local/home/nsaenz/c/qemu/build/meson-private/tmp1fnp2s4u/testfile.c -o /local/home/nsaenz/c/qemu/build/meson-private/tmp1fnp2s4u/output.obj -c -D_FILE_OFFSET_BITS=64 -O0 -Werror=implicit-function-declaration -Werror=unknown-warning-option -Werror=unused-command-line-argument -Werror=ignored-optimization-argument -std=gnu11 -Wunused-function -Werror

  Code:

    #include <glib.h>
    typedef struct Foo {
      int i;
    } Foo;
    static void foo_free(Foo *f)
    {
      g_free(f);
    }
    G_DEFINE_AUTOPTR_CLEANUP_FUNC(Foo, foo_free)
    int main(void) { return 0; }
  Compiler stdout:

  Compiler stderr:
   /local/home/nsaenz/c/qemu/build/meson-private/tmp1fnp2s4u/testfile.c:10:3: error: unused function 'glib_autoptr_cleanup_Foo' [-Werror,-Wunused-function]
    G_DEFINE_AUTOPTR_CLEANUP_FUNC(Foo, foo_free)
    ^
  /usr/include/glib-2.0/glib/gmacros.h:461:22: note: expanded from macro 'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
    static inline void _GLIB_AUTOPTR_FUNC_NAME(TypeName) (TypeName **_ptr) { if (*_ptr) (func) (*_ptr); }         \
                       ^
  /usr/include/glib-2.0/glib/gmacros.h:441:43: note: expanded from macro '_GLIB_AUTOPTR_FUNC_NAME'
  #define _GLIB_AUTOPTR_FUNC_NAME(TypeName) glib_autoptr_cleanup_##TypeName
                                            ^
  <scratch space>:58:1: note: expanded from here
  glib_autoptr_cleanup_Foo
  ^

 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index ef181ff2df..71a4fcee52 100644
--- a/meson.build
+++ b/meson.build
@@ -780,7 +780,7 @@ if not cc.compiles('''
     g_free(f);
   }
   G_DEFINE_AUTOPTR_CLEANUP_FUNC(Foo, foo_free)
-  int main(void) { return 0; }''', dependencies: glib_pc, args: ['-Werror'])
+  int main(void) { return 0; }''', dependencies: glib_pc, args: ['-Wunused-function', '-Werror'])
   glib_cflags += cc.get_supported_arguments('-Wno-unused-function')
 endif
 glib = declare_dependency(dependencies: [glib_pc, gmodule],
-- 
2.39.2


