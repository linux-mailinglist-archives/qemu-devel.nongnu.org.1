Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 663AB704BC4
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 13:06:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pysQ9-0002qe-O5; Tue, 16 May 2023 07:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysPJ-0001cA-CL
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysPB-0008AF-5w
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684234782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UPbo2+VzDqysnyV4UzfBcKr3OVEdwOudnHphko4hQ4w=;
 b=RWqn8ojXVlg9PYp/gejxhCKpACkuW308qMQa1S7QIL6KNXMxASyiqWEybuJqjow6tVemS6
 y5X/tId25jxZ4qxguGVLmqgxJJ0JrtjCYhFPzo8ts0J6Tv1ma7upQEUGe/bNuB6lb8AINd
 7eyaI0EFdieF9po0BakrmQwQFsxOh54=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-J02CaRITNQWHL5BGQbObAQ-1; Tue, 16 May 2023 06:59:41 -0400
X-MC-Unique: J02CaRITNQWHL5BGQbObAQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F041C85A5B1;
 Tue, 16 May 2023 10:59:40 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20A0E492B00;
 Tue, 16 May 2023 10:59:39 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	philmd@linaro.org,
	berrange@redhat.com
Subject: [PATCH v2 21/27] configure: move --enable-docs and --disable-docs
 back to configure
Date: Tue, 16 May 2023 12:59:02 +0200
Message-Id: <20230516105908.527838-21-pbonzini@redhat.com>
In-Reply-To: <20230516105908.527838-1-pbonzini@redhat.com>
References: <20230516105908.527838-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

Move this option back from meson into configure for the purposes of
using the configuration value to bootstrap Sphinx in different ways
based on this value.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20230511035435.734312-21-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configure b/configure
index 4519c4d412f8..f8308926bbc6 100755
--- a/configure
+++ b/configure
@@ -279,6 +279,7 @@ debug_tcg="no"
 sanitizers="no"
 tsan="no"
 fortify_source="yes"
+docs="auto"
 EXESUF=""
 modules="no"
 prefix="/usr/local"
@@ -750,6 +751,10 @@ for opt do
   ;;
   --disable-debug-info) meson_option_add -Ddebug=false
   ;;
+  --enable-docs) docs=enabled
+  ;;
+  --disable-docs) docs=disabled
+  ;;
   --enable-modules)
       modules="yes"
   ;;
@@ -2615,6 +2620,7 @@ if test "$skip_meson" = no; then
 
   # QEMU options
   test "$cfi" != false && meson_option_add "-Dcfi=$cfi"
+  test "$docs" != auto && meson_option_add "-Ddocs=$docs"
   test "$fdt" != auto && meson_option_add "-Dfdt=$fdt"
   test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
   test "$qemu_suffix" != qemu && meson_option_add "-Dqemu_suffix=$qemu_suffix"
-- 
2.40.1



