Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F817706FD7
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:46:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLDk-00076K-IH; Wed, 17 May 2023 13:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDb-00072A-PA
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDZ-00042M-SW
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9VpYpqcmx3CeiKdheVcW1c/Ecj3zfYd8vAZWtX94+BU=;
 b=dUEjk19yhnV8UFW4RxiRln1Vi5ooEW1JVkB9SQNkn9kdyrakT53HQdrLWjKWghfu10ceZt
 MyUvTYLmzX6OufsGwUqqi+d6s6Leii70xD02NMnMQW0CGzQgcLg0rZnaeKlvFynnwXedCV
 bu8hhnvfNWMTVVrgnzD97tJQpNmjX4Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-jMsXP-hiMxa9k5e3WSVVyw-1; Wed, 17 May 2023 13:45:40 -0400
X-MC-Unique: jMsXP-hiMxa9k5e3WSVVyw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f420ec766dso7589935e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345538; x=1686937538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9VpYpqcmx3CeiKdheVcW1c/Ecj3zfYd8vAZWtX94+BU=;
 b=G36wzoyc1AR5CKRDBIEtfIL51Qvv5v0aP+CTxg+YTSRuQfLsATZPKuN1QfyGTjfGS9
 Xb8EiF+UZJtjNzrjpVrdEXkJCRXZBa8Uk0Al5S+6txf2JmTkImBrfDd+Yn0Q3H02b/4+
 M51++IusIc6xHXCdy3Kbli7GSrRZ3gba2VrAQb5wtFq7bE6In/OPLXKEySQ6S6kOHvs5
 YQOnhTIWnmpiEfovK09KiSpxEwGX+PIOGybQcE5tjn1xRxhnrSj9S9uMD+LrG4nJVfut
 lT0FfeNUTWHbVclxGlhVXYtHShPDs25zZ3bPt1Pq93oBH7z8VmJkwTFNIiZw1ZH2QjF4
 pL8Q==
X-Gm-Message-State: AC+VfDygL79bxKdmyxZ4ahTdRkzZoilvs3B4WJBfQr6UjonzsvUZUi/q
 QBcOOqTmDwWAXWC5tyzT8qSoNkfqTAjehOe8F6Nl5TlvUUuE5E0JgGALteW/MQH397NiDZMLgzo
 X6wAHn4PcUlyFHFRE1rYgTQPJXamjAIW9JJmHaaKZ3+9sYsh6rs0kHMIYb2DffYT3997uE+HPUd
 4=
X-Received: by 2002:a5d:4e0e:0:b0:309:11d8:62a6 with SMTP id
 p14-20020a5d4e0e000000b0030911d862a6mr1340862wrt.43.1684345538366; 
 Wed, 17 May 2023 10:45:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4BDn6R7mUctonk/SrK9zL5U0HCxYx0VDpUYi5QN+3JekM+W5YgjUKInurRMxog9HN3aRTKLg==
X-Received: by 2002:a5d:4e0e:0:b0:309:11d8:62a6 with SMTP id
 p14-20020a5d4e0e000000b0030911d862a6mr1340849wrt.43.1684345538037; 
 Wed, 17 May 2023 10:45:38 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 c4-20020a056000104400b0030922ba6d0csm3781316wrx.45.2023.05.17.10.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:45:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 09/68] meson: Pass -j option to sphinx
Date: Wed, 17 May 2023 19:44:21 +0200
Message-Id: <20230517174520.887405-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Fabiano Rosas <farosas@suse.de>

Save a bit of build time by passing the number of jobs option to
sphinx.

We cannot use  the -j option from make because  meson does not support
setting build time parameters for custom targets. Use nproc instead or
the equivalent sphinx option "-j  auto", if that is available (version
>=1.7.0).

Also make sure our plugins support parallelism and report it properly
to sphinx. Particularly, implement the merge_domaindata method in
DBusDomain that is used to merge in data from other subprocesses.

Tested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <20230503203947.3417-2-farosas@suse.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/meson.build           | 12 ++++++++++++
 docs/sphinx/dbusdomain.py  |  4 ++++
 docs/sphinx/fakedbusdoc.py |  5 +++++
 docs/sphinx/qmp_lexer.py   |  5 +++++
 4 files changed, 26 insertions(+)

diff --git a/docs/meson.build b/docs/meson.build
index f220800e3e59..6d0986579e17 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -10,6 +10,18 @@ if sphinx_build.found()
     SPHINX_ARGS += [ '-W', '-Dkerneldoc_werror=1' ]
   endif
 
+  sphinx_version = run_command(SPHINX_ARGS + ['--version'],
+                               check: true).stdout().split()[1]
+  if sphinx_version.version_compare('>=1.7.0')
+    SPHINX_ARGS += ['-j', 'auto']
+  else
+    nproc = find_program('nproc')
+    if nproc.found()
+      jobs = run_command(nproc, check: true).stdout()
+      SPHINX_ARGS += ['-j', jobs]
+    endif
+  endif
+
   # This is a bit awkward but works: create a trivial document and
   # try to run it with our configuration file (which enforces a
   # version requirement). This will fail if sphinx-build is too old.
diff --git a/docs/sphinx/dbusdomain.py b/docs/sphinx/dbusdomain.py
index 2ea95af623d2..9872fd5bf6a4 100644
--- a/docs/sphinx/dbusdomain.py
+++ b/docs/sphinx/dbusdomain.py
@@ -400,6 +400,10 @@ def get_objects(self) -> Iterator[Tuple[str, str, str, str, str, int]]:
         for refname, obj in self.objects.items():
             yield (refname, refname, obj.objtype, obj.docname, obj.node_id, 1)
 
+    def merge_domaindata(self, docnames, otherdata):
+        for name, obj in otherdata['objects'].items():
+            if obj.docname in docnames:
+                self.data['objects'][name] = obj
 
 def setup(app):
     app.add_domain(DBusDomain)
diff --git a/docs/sphinx/fakedbusdoc.py b/docs/sphinx/fakedbusdoc.py
index d2c507904654..2d2e6ef64035 100644
--- a/docs/sphinx/fakedbusdoc.py
+++ b/docs/sphinx/fakedbusdoc.py
@@ -23,3 +23,8 @@ def run(self):
 def setup(app: Sphinx) -> Dict[str, Any]:
     """Register a fake dbus-doc directive with Sphinx"""
     app.add_directive("dbus-doc", FakeDBusDocDirective)
+
+    return dict(
+        parallel_read_safe = True,
+        parallel_write_safe = True
+    )
diff --git a/docs/sphinx/qmp_lexer.py b/docs/sphinx/qmp_lexer.py
index f7e4c0e19860..a59de8a079c0 100644
--- a/docs/sphinx/qmp_lexer.py
+++ b/docs/sphinx/qmp_lexer.py
@@ -41,3 +41,8 @@ def setup(sphinx):
         sphinx.add_lexer('QMP', QMPExampleLexer)
     except errors.VersionRequirementError:
         sphinx.add_lexer('QMP', QMPExampleLexer())
+
+    return dict(
+        parallel_read_safe = True,
+        parallel_write_safe = True
+    )
-- 
2.40.1


