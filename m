Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E3F73DD17
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:16:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkBO-0002ui-8v; Mon, 26 Jun 2023 07:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBL-0002tl-50
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:14:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBJ-0000XB-7y
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687778091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wRAc6f7nKmkBx5cWgWSx5rm/aX7MA5Hq+gKL60VbYs8=;
 b=IcQAE5Ox08DsmiN1JCn1pUSRK+ZH6HLHlxIYn5p63JZoTYf/Kcn/0bqXYdpKzeDklbWk7j
 z+XNPkbfrF4O18YGh3KT/k9Vl2c8DdWwkQsbJbEJlVPFovasOvuEOiNEK3KAGU0IhUzoWq
 N5mbQfx6J5wPKBTPYs/U8+nIZx1sBhE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-7YsDpl3EOOCAUPR4oviztg-1; Mon, 26 Jun 2023 07:14:50 -0400
X-MC-Unique: 7YsDpl3EOOCAUPR4oviztg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fa7b245a75so14101575e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687778088; x=1690370088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wRAc6f7nKmkBx5cWgWSx5rm/aX7MA5Hq+gKL60VbYs8=;
 b=XJbg8Q4QUh2FvXzmrxJcRiYB7CWPhEDJk8HzGOkch/B43EuGnn+mVcBInhYFhvwLOI
 Bu9ladilSXP3QlZRmHxViwrEvIbNgTwjgbhdvo+tFlT77z0FWlXlhHW9wA57rk6I1wO1
 xBSQgE3swhwozevcDdI4rBxKgY4LViIb8T8+9UEqxzIeVbC2Z/J9PaZaW0GCh4FTfNPu
 VfGen1yLTd9jOuGa04KwhpKUIMnPggnbw5DKuVqJGoqtPzqmYBVqPpDEXE01X8m/mPra
 VkCxqlHw+3SKSBCzpBsh+wv4zr7eF4BF/mVvElOJbFMyqcfylShfplXuei1kjQBOXhV6
 xs2A==
X-Gm-Message-State: AC+VfDyH3/2VVsZ67mC8t0yyIPdMPDu9yl57Trh5dCirVxn2srT/1KPp
 arqKH/epLe+P36wdRuXxTNgCjAff3ou82p9fCM+sL8VfiKN86TdAG/Bku1hRiyFoQUYeLW0+pz6
 s0dnNxNHqaQwjkfoSlM2l+BiPW/TqcLmDZbQaJEbSHMYYuVxz6u7LW6TEYD4z38/spp1NOt6DMi
 s=
X-Received: by 2002:a05:600c:10d1:b0:3f7:a20a:561d with SMTP id
 l17-20020a05600c10d100b003f7a20a561dmr27128677wmd.8.1687778088622; 
 Mon, 26 Jun 2023 04:14:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6/QZzGNfz4wlk4+aVy1mQhS+9gAE3qsDvnz9NeLI0owx9NmxLfupAL7JjY51eMKrqsYuieqQ==
X-Received: by 2002:a05:600c:10d1:b0:3f7:a20a:561d with SMTP id
 l17-20020a05600c10d100b003f7a20a561dmr27128655wmd.8.1687778088224; 
 Mon, 26 Jun 2023 04:14:48 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 l21-20020a7bc455000000b003fa95c466a1sm2937195wmi.5.2023.06.26.04.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:14:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 01/18] build: further refine build.ninja rules
Date: Mon, 26 Jun 2023 13:14:28 +0200
Message-ID: <20230626111445.163573-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626111445.163573-1-pbonzini@redhat.com>
References: <20230626111445.163573-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

In commit b0fcc6fc7fc1 ("build: rebuild build.ninja using
"meson setup --reconfigure"", 2023-05-19) I changed the build.ninja
rule in the Makefile to use "meson setup" so that the Makefile would
pick up a changed path to the meson binary.

However, there was a reason why build.ninja was rebuilt using $(NINJA)
itself.  Namely, ninja has its own cache of file modification times,
and if it does not know about the modification that was done outside
its control, it will *also* try to regenerate build.ninja.  This can be
simply by running "make" on a fresh tree immediately after "configure";
that will trigger an unnecessary meson run.

So, apply a refinement to the rule in order to cover both cases:

- track the meson binary that was used (and that is embedded in
  build.ninja's reconfigure rules); to do this, write build.ninja.stamp
  right after executing meson successfully

- if it changed, force usage of "$(MESON) setup --reconfigure" to
  update the path in the reconfigure rule

- if it didn't change, use "$(NINJA) build.ninja" just like before
  commit b0fcc6fc7fc1.

Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile  | 17 +++++++++++++----
 configure |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index b22bf6fba12..804a5681e0a 100644
--- a/Makefile
+++ b/Makefile
@@ -83,16 +83,17 @@ config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/scripts/meson-buildoptions.sh
 	@if test -f meson-private/coredata.dat; then \
 	  ./config.status --skip-meson; \
 	else \
-	  ./config.status && touch build.ninja.stamp; \
+	  ./config.status; \
 	fi
 
 # 2. meson.stamp exists if meson has run at least once (so ninja reconfigure
 # works), but otherwise never needs to be updated
+
 meson-private/coredata.dat: meson.stamp
 meson.stamp: config-host.mak
 	@touch meson.stamp
 
-# 3. ensure generated build files are up-to-date
+# 3. ensure meson-generated build files are up-to-date
 
 ifneq ($(NINJA),)
 Makefile.ninja: build.ninja
@@ -106,11 +107,19 @@ Makefile.ninja: build.ninja
 endif
 
 ifneq ($(MESON),)
-# A separate rule is needed for Makefile dependencies to avoid -n
+# The path to meson always points to pyvenv/bin/meson, but the absolute
+# paths could change.  In that case, force a regeneration of build.ninja.
+# Note that this invocation of $(NINJA), just like when Make rebuilds
+# Makefiles, does not include -n.
 build.ninja: build.ninja.stamp
 $(build-files):
 build.ninja.stamp: meson.stamp $(build-files)
-	$(MESON) setup --reconfigure $(SRC_PATH) && touch $@
+	@if test "$$(cat build.ninja.stamp)" = "$(MESON)" && test -n "$(NINJA)"; then \
+	  $(NINJA) build.ninja; \
+	else \
+	  echo "$(MESON) setup --reconfigure $(SRC_PATH)"; \
+	  $(MESON) setup --reconfigure $(SRC_PATH); \
+	fi && echo "$(MESON)" > $@
 
 Makefile.mtest: build.ninja scripts/mtest2make.py
 	$(MESON) introspect --targets --tests --benchmarks | $(PYTHON) scripts/mtest2make.py > $@
diff --git a/configure b/configure
index 01a53576a7d..86363a7e508 100755
--- a/configure
+++ b/configure
@@ -1895,6 +1895,7 @@ if test "$skip_meson" = no; then
   if test "$?" -ne 0 ; then
       error_exit "meson setup failed"
   fi
+  echo "$meson" > build.ninja.stamp
 else
   if test -f meson-private/cmd_line.txt; then
     # Adjust old command line options that were removed
-- 
2.41.0


