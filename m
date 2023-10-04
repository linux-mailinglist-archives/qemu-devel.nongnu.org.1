Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD1D7B8121
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:38:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo24I-0004Li-3v; Wed, 04 Oct 2023 09:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo24F-0004LH-MD
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:37:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo24D-0003m1-7X
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696426652;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=LBWyA/ofUWVGkMoY+v1hKEcmSsljCHGGaFXNRZoRGBk=;
 b=Q5tnsh5vaTSYv7K3U3x5Woul/4X+yxwzr3L+QB4r0fCCYQ26U+cmomff4n27YxeixJIbP+
 2yOGSmXoxSQQo6tHWCwCpIED2BEwK0jD5g6vHsCxmO5HnwHlrnH+UrmlqHyG/Hgdq5FPOG
 l2Wmkba74GH8O1Gwe18rhZVywvnakXk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-a9opxvXlNTKPMbINPugYDA-1; Wed, 04 Oct 2023 09:37:30 -0400
X-MC-Unique: a9opxvXlNTKPMbINPugYDA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4065478afd3so15701525e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 06:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696426649; x=1697031449;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LBWyA/ofUWVGkMoY+v1hKEcmSsljCHGGaFXNRZoRGBk=;
 b=O+QBYWhus9F5xibWjMZ7Vob2VfHR4jfrHsqeXWQEWMjFD9ypIMQcy5Qpg8gSkYGdUm
 InEANhNmcwZxrQL+LQawoXJaIR1wVQ2TYiT0sXy9JqzLKXLtHZtfxY1WGLR72KY0fc/p
 QdsF7U//5g7xXnTpB68sCzj8UZTg4+cNT/9BYwiKmMAOLTMljBwe49pGdoIKyoUj2XN1
 UsDj5Np2zp4OYguxZ+kPJiNgqEtZKNoS+pW5xne64tKbpcLvNzm5GXRhnknZXt6b0NGQ
 tzvlvRbIpPNM/fDYmkrzZj601NlPwhCvw0uuRb54VIY4yLaRitUB3ovVZbh7FoFZ0r9N
 ZRaA==
X-Gm-Message-State: AOJu0YyqsJqZ0S98wZvRNTsTT9lp40eSDNUqUn0fvVXzfwYIgmRLPROf
 kgqgA+6ZCsUySvEHfdDGlYacjF5/Kx2NRkxY0TA4+dUrsz+JrRCPVCrVrNFHL8dV0l1MKQeNVcE
 6Mu+lCtX2lFqW7Rw=
X-Received: by 2002:a05:600c:4686:b0:405:95ae:4a94 with SMTP id
 p6-20020a05600c468600b0040595ae4a94mr2232293wmo.5.1696426649754; 
 Wed, 04 Oct 2023 06:37:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2zN8mYVwnkuwh7lF39AiSCAXNPhf+AAjTm94fxCE6jJKmQh+t1hXY/aHVcx60EnpWQxez/g==
X-Received: by 2002:a05:600c:4686:b0:405:95ae:4a94 with SMTP id
 p6-20020a05600c468600b0040595ae4a94mr2232281wmo.5.1696426649428; 
 Wed, 04 Oct 2023 06:37:29 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 fl16-20020a05600c0b9000b00406847c988asm1501182wmb.12.2023.10.04.06.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 06:37:28 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Tejus GK <tejus.gk@nutanix.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de
Subject: Re: [PATCH v5 2/2] migration: Update error description outside
 migration.c
In-Reply-To: <87leci36db.fsf@secure.mitica> (Juan Quintela's message of "Wed, 
 04 Oct 2023 14:43:44 +0200")
References: <20231003065538.244752-1-tejus.gk@nutanix.com>
 <20231003065538.244752-3-tejus.gk@nutanix.com>
 <874jj77u4a.fsf@secure.mitica>
 <c281b1e9-a027-4871-a1d5-7fc10f4ba1ed@nutanix.com>
 <871qea6bk1.fsf@secure.mitica>
 <68db0be7-694a-44da-8513-e761109d5902@nutanix.com>
 <87leci36db.fsf@secure.mitica>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 15:37:28 +0200
Message-ID: <87h6n633vr.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Juan Quintela <quintela@redhat.com> wrote:
> Tejus GK <tejus.gk@nutanix.com> wrote:
>> On 04/10/23 1:53 pm, Juan Quintela wrote:
>>> Tejus GK <tejus.gk@nutanix.com> wrote:
>>>> On 03/10/23 6:14 pm, Juan Quintela wrote:
> Ouch, that again.
>
> I think that I know how to fix that.
>
> Will take a look.
>
> Later, Juan.

I first only saw that you were missing migrate_set_error().
migrate_get_current() is .... more interesting.

The problem is that migration.c has lots of things that depend of qemu
and we can't use that in qtest.
This is one disection toh help fix it, but I can't see a trivial way to
get current_migration() working as needed.  Really what we should have
is a way to have vmstate store its own error, and only set
migrate_set_error() at callers time, but that don't seem completely
obvious how to do it.

Later, Juan.


From cdbdbca65059ebb9fd6a4d354a94c3be7cf69f92 Mon Sep 17 00:00:00 2001
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 4 Oct 2023 15:22:39 +0200
Subject: [PATCH] migration: Create common.c

We can (yet) add migration.c to migration_files because it brings too
many dependencies to the tests.

This file is a place where to move things that are also needed for
tests.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/common.c    | 25 +++++++++++++++++++++++++
 migration/migration.c |  8 --------
 migration/meson.build |  1 +
 3 files changed, 26 insertions(+), 8 deletions(-)
 create mode 100644 migration/common.c

diff --git a/migration/common.c b/migration/common.c
new file mode 100644
index 0000000000..1d02f37c99
--- /dev/null
+++ b/migration/common.c
@@ -0,0 +1,25 @@
+/*
+ * QEMU live migration common code for qemu and qtests
+ *
+ * Copyright (c) 2011 Red Hat Inc
+ *
+ * Authors:
+ *  Juan Quintela <quintela@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "migration.h"
+
+void migrate_set_error(MigrationState *s, const Error *error)
+{
+    QEMU_LOCK_GUARD(&s->error_mutex);
+    if (!s->error) {
+        s->error = error_copy(error);
+    }
+}
diff --git a/migration/migration.c b/migration/migration.c
index 585d3c8f55..f143b3a41e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1221,14 +1221,6 @@ static void migrate_fd_cleanup_bh(void *opaque)
     object_unref(OBJECT(s));
 }
 
-void migrate_set_error(MigrationState *s, const Error *error)
-{
-    QEMU_LOCK_GUARD(&s->error_mutex);
-    if (!s->error) {
-        s->error = error_copy(error);
-    }
-}
-
 static void migrate_error_free(MigrationState *s)
 {
     QEMU_LOCK_GUARD(&s->error_mutex);
diff --git a/migration/meson.build b/migration/meson.build
index 92b1cc4297..57b3098c46 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -1,5 +1,6 @@
 # Files needed by unit tests
 migration_files = files(
+  'common.c',
   'migration-stats.c',
   'page_cache.c',
   'xbzrle.c',

-- 
2.41.0


