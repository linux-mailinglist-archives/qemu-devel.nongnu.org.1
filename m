Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C99EE7F77C1
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 16:26:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Y2X-0004dZ-Tq; Fri, 24 Nov 2023 10:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r6Y2W-0004dC-Mp
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:24:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r6Y2V-00049M-91
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700839458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KmQ0T7rx17iHO2O3C1cis9pHGGhMaYE462PYDT0eF2I=;
 b=Oau8Ae4zTVLxisiUtZVKGybAyWmXJWT6+GpKPo77Ru4IrxDTN6a+M4m7QANE2GVjcNvqP9
 xcMKPEdD7Ljw8iWIPDqY1beeMyFaC5SIwFjz558gZNzfdJ0rpK3jnxOMTwAQk+VqL4WZbK
 hSabDaE+wh5F6yh0ztaBmaU6T5HePto=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-ecUHW5OaOIScteQpTniyYw-1; Fri, 24 Nov 2023 10:24:17 -0500
X-MC-Unique: ecUHW5OaOIScteQpTniyYw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-77d5f56155bso241130385a.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 07:24:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700839456; x=1701444256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KmQ0T7rx17iHO2O3C1cis9pHGGhMaYE462PYDT0eF2I=;
 b=LgmnqhbTOF7yGPJOD7cVmui9Ux3GDTrrJgNslfWcR7XgW9+3c1nFY72Gez1kWogJw6
 dLUElOi/wfW0Xl+43YduPLjAsRNrYBbCRXuHUoVDHJ64e6ES6QAmNOql6WjEY3B0O1Q7
 3ArvWJujRyl/ij8YPzpNQcYBfH1aPSivFnKXWwYm9rkI4W6LVD4vvUWd3Q4CdYvORbKZ
 2mZeSnzKUPZODJwSGJgX5qF/1pNudLAG772LQbW0rw+xxmCKB4yVAF4KdtXpLYbIIVJh
 OA4UA+FlD/MGCw0fDkjXnG4SEbi74P2nmb3IGhZGvTMkj3yWwpNuZy8dBK0fCVXZ8z9n
 Km0w==
X-Gm-Message-State: AOJu0YxYq6KOX+4m5iBeSvmPDWWKsYw2VEFCRg7pHNOy0Dja0Sh0VMGn
 z0MdrJhDCL9ntaWWzsPk5+P5SV2NXJea390FE9L1OkLH8jMjsA/O/3RREt/j4OHjJe8toQx42E1
 uEyhmh01HvL1NyOpYOFviRNfbwoLhluYkvPL4P047xmsm/GTKqXGgPB4XU3L3Ufv3eZrw/DC5wG
 E=
X-Received: by 2002:a05:620a:1218:b0:779:eb01:8390 with SMTP id
 u24-20020a05620a121800b00779eb018390mr3053069qkj.49.1700839456395; 
 Fri, 24 Nov 2023 07:24:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJgqAfzexxqwl30PlOeOl5YSzTy9PqWgYYCIZ5ZGjUJ+RvETkQf94gOBdwPzT1K/PnFyRxnw==
X-Received: by 2002:a05:620a:1218:b0:779:eb01:8390 with SMTP id
 u24-20020a05620a121800b00779eb018390mr3053045qkj.49.1700839456040; 
 Fri, 24 Nov 2023 07:24:16 -0800 (PST)
Received: from [10.201.49.108] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 o21-20020a05620a131500b0076cda7eab11sm1269226qkj.133.2023.11.24.07.24.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 07:24:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/10] tests: respect --enable/--disable-download for Avocado
Date: Fri, 24 Nov 2023 16:24:00 +0100
Message-ID: <20231124152408.140936-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124152408.140936-1-pbonzini@redhat.com>
References: <20231124152408.140936-1-pbonzini@redhat.com>
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
index 42fe4d05108..959b1a20c1c 100755
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
@@ -1634,6 +1634,7 @@ if test "$container" != no; then
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
2.43.0


