Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BF3827EE5
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 07:48:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN5uF-0006EK-Qp; Tue, 09 Jan 2024 01:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN5tk-0005o5-JR
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 01:47:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN5tX-0005pG-Hs
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 01:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704782842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AIcWPDuFibc9Kc5PfZ5Pz/6K0DzoVgl9LdVZCMi6Cw4=;
 b=TbBiss67a9wkfzR+HxQkwlpR0HmO/A+LqcGqYkz0PT6DpXIqhBKM5qDhoC/H5gx1437aOs
 3FMkGTY1dvfYyDSWWg0W2veGVXvn9ZsGuYDPx5BbyDy9DYfGpcE6xHfV23Uao81DY1ai31
 QFa56pgS5m1RfqkgbElhQ41B77zV6to=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-fP5cDZNVOda8EOmimtuRJQ-1; Tue,
 09 Jan 2024 01:47:19 -0500
X-MC-Unique: fP5cDZNVOda8EOmimtuRJQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05AA038149CC;
 Tue,  9 Jan 2024 06:47:19 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ACBC2492BC9;
 Tue,  9 Jan 2024 06:47:14 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bandan Das <bdas@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 08/10] docs/migration: Organize "Postcopy" page
Date: Tue,  9 Jan 2024 14:46:26 +0800
Message-ID: <20240109064628.595453-9-peterx@redhat.com>
In-Reply-To: <20240109064628.595453-1-peterx@redhat.com>
References: <20240109064628.595453-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

Reorganize the page, moving things around, and add a few
headlines ("Postcopy internals", "Postcopy features") to cover sub-areas.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/migration/postcopy.rst | 159 ++++++++++++++++--------------
 1 file changed, 84 insertions(+), 75 deletions(-)

diff --git a/docs/devel/migration/postcopy.rst b/docs/devel/migration/postcopy.rst
index d60eec06ab..6c51e96d79 100644
--- a/docs/devel/migration/postcopy.rst
+++ b/docs/devel/migration/postcopy.rst
@@ -1,6 +1,9 @@
+========
 Postcopy
 ========
 
+.. contents::
+
 'Postcopy' migration is a way to deal with migrations that refuse to converge
 (or take too long to converge) its plus side is that there is an upper bound on
 the amount of migration traffic and time it takes, the down side is that during
@@ -14,7 +17,7 @@ Postcopy can be combined with precopy (i.e. normal migration) so that if precopy
 doesn't finish in a given time the switch is made to postcopy.
 
 Enabling postcopy
------------------
+=================
 
 To enable postcopy, issue this command on the monitor (both source and
 destination) prior to the start of migration:
@@ -49,8 +52,71 @@ time per vCPU.
   ``migrate_set_parameter`` is ignored (to avoid delaying requested pages that
   the destination is waiting for).
 
-Postcopy device transfer
-------------------------
+Postcopy internals
+==================
+
+State machine
+-------------
+
+Postcopy moves through a series of states (see postcopy_state) from
+ADVISE->DISCARD->LISTEN->RUNNING->END
+
+ - Advise
+
+    Set at the start of migration if postcopy is enabled, even
+    if it hasn't had the start command; here the destination
+    checks that its OS has the support needed for postcopy, and performs
+    setup to ensure the RAM mappings are suitable for later postcopy.
+    The destination will fail early in migration at this point if the
+    required OS support is not present.
+    (Triggered by reception of POSTCOPY_ADVISE command)
+
+ - Discard
+
+    Entered on receipt of the first 'discard' command; prior to
+    the first Discard being performed, hugepages are switched off
+    (using madvise) to ensure that no new huge pages are created
+    during the postcopy phase, and to cause any huge pages that
+    have discards on them to be broken.
+
+ - Listen
+
+    The first command in the package, POSTCOPY_LISTEN, switches
+    the destination state to Listen, and starts a new thread
+    (the 'listen thread') which takes over the job of receiving
+    pages off the migration stream, while the main thread carries
+    on processing the blob.  With this thread able to process page
+    reception, the destination now 'sensitises' the RAM to detect
+    any access to missing pages (on Linux using the 'userfault'
+    system).
+
+ - Running
+
+    POSTCOPY_RUN causes the destination to synchronise all
+    state and start the CPUs and IO devices running.  The main
+    thread now finishes processing the migration package and
+    now carries on as it would for normal precopy migration
+    (although it can't do the cleanup it would do as it
+    finishes a normal migration).
+
+ - Paused
+
+    Postcopy can run into a paused state (normally on both sides when
+    happens), where all threads will be temporarily halted mostly due to
+    network errors.  When reaching paused state, migration will make sure
+    the qemu binary on both sides maintain the data without corrupting
+    the VM.  To continue the migration, the admin needs to fix the
+    migration channel using the QMP command 'migrate-recover' on the
+    destination node, then resume the migration using QMP command 'migrate'
+    again on source node, with resume=true flag set.
+
+ - End
+
+    The listen thread can now quit, and perform the cleanup of migration
+    state, the migration is now complete.
+
+Device transfer
+---------------
 
 Loading of device data may cause the device emulation to access guest RAM
 that may trigger faults that have to be resolved by the source, as such
@@ -130,7 +196,20 @@ processing.
    is no longer used by migration, while the listen thread carries on servicing
    page data until the end of migration.
 
-Postcopy Recovery
+Source side page bitmap
+-----------------------
+
+The 'migration bitmap' in postcopy is basically the same as in the precopy,
+where each of the bit to indicate that page is 'dirty' - i.e. needs
+sending.  During the precopy phase this is updated as the CPU dirties
+pages, however during postcopy the CPUs are stopped and nothing should
+dirty anything any more. Instead, dirty bits are cleared when the relevant
+pages are sent during postcopy.
+
+Postcopy features
+=================
+
+Postcopy recovery
 -----------------
 
 Comparing to precopy, postcopy is special on error handlings.  When any
@@ -166,76 +245,6 @@ configurations of the guest.  For example, when with async page fault
 enabled, logically the guest can proactively schedule out the threads
 accessing missing pages.
 
-Postcopy states
----------------
-
-Postcopy moves through a series of states (see postcopy_state) from
-ADVISE->DISCARD->LISTEN->RUNNING->END
-
- - Advise
-
-    Set at the start of migration if postcopy is enabled, even
-    if it hasn't had the start command; here the destination
-    checks that its OS has the support needed for postcopy, and performs
-    setup to ensure the RAM mappings are suitable for later postcopy.
-    The destination will fail early in migration at this point if the
-    required OS support is not present.
-    (Triggered by reception of POSTCOPY_ADVISE command)
-
- - Discard
-
-    Entered on receipt of the first 'discard' command; prior to
-    the first Discard being performed, hugepages are switched off
-    (using madvise) to ensure that no new huge pages are created
-    during the postcopy phase, and to cause any huge pages that
-    have discards on them to be broken.
-
- - Listen
-
-    The first command in the package, POSTCOPY_LISTEN, switches
-    the destination state to Listen, and starts a new thread
-    (the 'listen thread') which takes over the job of receiving
-    pages off the migration stream, while the main thread carries
-    on processing the blob.  With this thread able to process page
-    reception, the destination now 'sensitises' the RAM to detect
-    any access to missing pages (on Linux using the 'userfault'
-    system).
-
- - Running
-
-    POSTCOPY_RUN causes the destination to synchronise all
-    state and start the CPUs and IO devices running.  The main
-    thread now finishes processing the migration package and
-    now carries on as it would for normal precopy migration
-    (although it can't do the cleanup it would do as it
-    finishes a normal migration).
-
- - Paused
-
-    Postcopy can run into a paused state (normally on both sides when
-    happens), where all threads will be temporarily halted mostly due to
-    network errors.  When reaching paused state, migration will make sure
-    the qemu binary on both sides maintain the data without corrupting
-    the VM.  To continue the migration, the admin needs to fix the
-    migration channel using the QMP command 'migrate-recover' on the
-    destination node, then resume the migration using QMP command 'migrate'
-    again on source node, with resume=true flag set.
-
- - End
-
-    The listen thread can now quit, and perform the cleanup of migration
-    state, the migration is now complete.
-
-Source side page map
---------------------
-
-The 'migration bitmap' in postcopy is basically the same as in the precopy,
-where each of the bit to indicate that page is 'dirty' - i.e. needs
-sending.  During the precopy phase this is updated as the CPU dirties
-pages, however during postcopy the CPUs are stopped and nothing should
-dirty anything any more. Instead, dirty bits are cleared when the relevant
-pages are sent during postcopy.
-
 Postcopy with hugepages
 -----------------------
 
@@ -293,7 +302,7 @@ Retro-fitting postcopy to existing clients is possible:
      guest memory access is made while holding a lock then all other
      threads waiting for that lock will also be blocked.
 
-Postcopy Preemption Mode
+Postcopy preemption mode
 ------------------------
 
 Postcopy preempt is a new capability introduced in 8.0 QEMU release, it
-- 
2.41.0


