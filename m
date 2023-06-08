Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E1E72819C
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:43:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FvA-0004nt-6J; Thu, 08 Jun 2023 09:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q7Fv8-0004nc-0D
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:43:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q7Fv6-00014S-56
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686231799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3z98tDruaNA1zqYdLF3Uzl7bvAIdkYCuuj86iGgcavs=;
 b=Zi50gHBytXPfOIjmaD4+ZOzHO6M9Ka7PFNG9beNjRZaOgMSL0qHITQZgMhj4VWQUbF2tel
 /bIq9eAh9KFacB0CPIfkxwdTqeZ5TwNom9vrQsEJav78HMpnhTEEtHlNW9PWj91eZVVh1M
 zkXAdWAs0AH3RVULB6r8L4fKqiVg/PU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-igwa3G52PhS0qDJj7F8o6g-1; Thu, 08 Jun 2023 09:43:17 -0400
X-MC-Unique: igwa3G52PhS0qDJj7F8o6g-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-977d4b0d9e3so62861166b.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 06:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686231796; x=1688823796;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3z98tDruaNA1zqYdLF3Uzl7bvAIdkYCuuj86iGgcavs=;
 b=gzU16waL1WrBhIRm1G9XflKRKS29X0sfwxwFPJgEn31KtzXp3w02z/+SV/fR3/iwq8
 noPzNqtW1w/CbiuZKRUskP4miNA/wRJafh2Uct44ik51UMwhr4LStpn+nzJif+8Cisz/
 Aj65hF+pTiRB5SeNuSmndqwNN9Ujm+K/M9IcUUX6WJfE8ssOT5cYX56rQpzhvYEfolc9
 oY91yr7sJdYIuFQZm8quYKtSw8ILHytoAQ0jl/KDYNQP2jhHOhHUo+nK/unVo7/e+wda
 OvqrXzas+07s7lQSPb2qzT8X91sSETimSZbBR+3a6eoiYDro4SMxDcZmSXf4ly6cpqsg
 BdRg==
X-Gm-Message-State: AC+VfDzoLLFdCtlQEeD8LP3lxCMJXlhCfE21iJ4R64XBKF92kMNaRxFN
 hxvuCCCYVFY6DvyxBynfHx93fSp1K861ucLlO+a0nGLmNmgExt/aavfDAnULAaxo2A5pdAgLEIR
 6gzExDoFr4QhagMp5uvfc+iezQoTNIVd48kRL/srI+06DXbutMjhdU0N83q71ATiK+NNSQVKj8X
 E=
X-Received: by 2002:a17:906:6a16:b0:973:9a6c:2a6 with SMTP id
 qw22-20020a1709066a1600b009739a6c02a6mr10726344ejc.49.1686231796349; 
 Thu, 08 Jun 2023 06:43:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5FEsPp21ND7J4FHlxd7y8CrPBi73VTvnJO4z1DgWp9OWcnBIpW07zLX/Qje0LmHRUkGaQmHg==
X-Received: by 2002:a17:906:6a16:b0:973:9a6c:2a6 with SMTP id
 qw22-20020a1709066a1600b009739a6c02a6mr10726314ejc.49.1686231795894; 
 Thu, 08 Jun 2023 06:43:15 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 a24-20020a1709062b1800b0097812e2b66csm723829ejg.111.2023.06.08.06.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 06:43:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH] build: further refine build.ninja rules
Date: Thu,  8 Jun 2023 15:43:14 +0200
Message-Id: <20230608134314.943615-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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
index 8a638dd82ae..cbdb389dc95 100755
--- a/configure
+++ b/configure
@@ -1894,6 +1894,7 @@ if test "$skip_meson" = no; then
   if test "$?" -ne 0 ; then
       error_exit "meson setup failed"
   fi
+  echo "$meson" > build.ninja.stamp
 else
   if test -f meson-private/cmd_line.txt; then
     # Adjust old command line options that were removed
-- 
2.40.1


