Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C14987E8B5E
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 16:30:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1pvX-0003ms-S4; Sat, 11 Nov 2023 10:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1pvV-0003l9-HJ
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 10:29:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1pvU-0008IB-0t
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 10:29:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699716573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tBCjXd6MN5whkUidc8Z8YGzlyTzID2NTEQolnZ2fGZ4=;
 b=gED4BumbZ4I/pv9h52FRvTxHYudlK57dno1Rp0pj2th4/wgl5D5azynNfoAqcF3V33TlDe
 ddCAdNlJm2IQQedMxiK3ae/YgfC3HPbwt49vjrBVDFxgWLdFfhZUn3/P2+mOz+jECpHv3O
 c1w3YoM8d2LJ2qxLJ71x/zKHa4jPysQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-Nqx8luIwP02KgrEN1zrmAg-1; Sat, 11 Nov 2023 10:29:31 -0500
X-MC-Unique: Nqx8luIwP02KgrEN1zrmAg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9dfbccc2a8cso226421366b.1
 for <qemu-devel@nongnu.org>; Sat, 11 Nov 2023 07:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699716570; x=1700321370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tBCjXd6MN5whkUidc8Z8YGzlyTzID2NTEQolnZ2fGZ4=;
 b=AhyjpfK5llSl3aZmmAkLsXEefNzQAjHYY//p7mlkeVarJi0PN9eFR5JsJEsLLw+Isg
 Bv9c6V1kzSottNUtP4G4UarKnM0aB+H/vS6brBcFTvnwpgyaFHSHJe8e/JTexC8MAy8S
 RheCKfKFnIckRWHHwip4bFVUctL+7R1Py86G3DpRuHrjM1bLksaNOwMufwF3DQEFsjUG
 wo5CsSMNs+oTRwwzPOx77Oo5Sz8xZo3hJ2zOg0Vune5GH6bQ0Os9qWY8oVqmtdu7+NV/
 chIwCxlxAiHO3cVi8z2VY6TJ0PfZyUZEHv4q04PUxPuWf4XN8YOZ8JMiv7pIolBUYB0b
 C8OA==
X-Gm-Message-State: AOJu0Yxqfl2o6sU7AAIjQLIauxVWCh679BIQZqJ2P6omrdfWYPSWl1Bz
 QHUB8W82DmFFnSP3U9cKTJZ1dhLrFJFg/Fp5lH+oJQoLS7hsEYyOzKXCo2boenOnHpYnv8cJnpn
 SGCz8Y9OldzlXwuQWrQVDW/4fmyPzJOUQNVTEfIJzKddOxilEvoMLI7G4Un3piz6riOSwtbXQ6I
 U=
X-Received: by 2002:a17:906:c30a:b0:9e6:568:7374 with SMTP id
 s10-20020a170906c30a00b009e605687374mr1391442ejz.1.1699716570430; 
 Sat, 11 Nov 2023 07:29:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNkgusr97VU1Tn6QKo4BAt/YlPl7EScJokLjIgrJJjPvtCeV+mQCYnYlzdvCBtxl9tJkYt5w==
X-Received: by 2002:a17:906:c30a:b0:9e6:568:7374 with SMTP id
 s10-20020a170906c30a00b009e605687374mr1391433ejz.1.1699716570044; 
 Sat, 11 Nov 2023 07:29:30 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 v24-20020a170906489800b009b2ba067b37sm1181501ejq.202.2023.11.11.07.29.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 07:29:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/6] tests: respect --enable/--disable-download for Avocado
Date: Sat, 11 Nov 2023 16:29:19 +0100
Message-ID: <20231111152923.966998-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231111152923.966998-1-pbonzini@redhat.com>
References: <20231111152923.966998-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Pass the content of $mkvenv_flags (which is either "--online"
or empty) down to tests/Makefile.include.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure              | 9 +++++----
 tests/Makefile.include | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index abcb199aa87..2da3c278db6 100755
--- a/configure
+++ b/configure
@@ -968,14 +968,14 @@ meson="$(cd pyvenv/bin; pwd)/meson"
 
 # Conditionally ensure Sphinx is installed.
 
-mkvenv_flags=""
-if test "$download" = "enabled" -a "$docs" = "enabled" ; then
-    mkvenv_flags="--online"
+mkvenv_online_flag=""
+if test "$download" = "enabled" ; then
+    mkvenv_online_flag=" --online"
 fi
 
 if test "$docs" != "disabled" ; then
     if ! $mkvenv ensuregroup \
-         $mkvenv_flags \
+         $(test "$docs" = "enabled" && echo "$mkvenv_online_flag") \
          ${source_path}/pythondeps.toml docs;
     then
         if test "$docs" = "enabled" ; then
@@ -1631,6 +1631,7 @@ if test "$container" != no; then
 fi
 echo "SUBDIRS=$subdirs" >> $config_host_mak
 echo "PYTHON=$python" >> $config_host_mak
+echo "MKVENV_ENSUREGROUP=$mkvenv ensuregroup $mkvenv_online_flag" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
 echo "MESON=$meson" >> $config_host_mak
 echo "NINJA=$ninja" >> $config_host_mak
diff --git a/tests/Makefile.include b/tests/Makefile.include
index dab1989a071..c9d1674bd07 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -111,7 +111,7 @@ quiet-venv-pip = $(quiet-@)$(call quiet-command-run, \
 
 $(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
 	$(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
-	$(PYTHON) python/scripts/mkvenv.py ensuregroup --online $< avocado
+	$(MKVENV_ENSUREGROUP) $< avocado
 	$(call quiet-command, touch $@)
 
 $(TESTS_RESULTS_DIR):
-- 
2.41.0


