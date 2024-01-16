Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CF982E838
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 04:23:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPa0T-0005wk-Nv; Mon, 15 Jan 2024 22:20:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPa0R-0005uf-M9
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:20:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPa0O-00036S-4h
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:20:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705375247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WqtYvIaIxP66Jv1Pf5X6efIhpNJoSlvKm+/PsY334o4=;
 b=LuEmjD7h3lTLMEKCsaLI9m+izPLyofP/c/jOwGX+kyVr9t6R6E9BcbWQqA8et7PQtXnFmw
 sQvv2QmPC4LgdDKw0owPVCBTKkqR5/tRGmyBoqRs2ky40WUFlkpLdJKq2MM8yjzAXFK2iX
 5G57FvaxOhdyO+LYJecclwH9HwbhNmk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-oRqRjz1QNqC7jXBYA22Dyg-1; Mon, 15 Jan 2024 22:20:44 -0500
X-MC-Unique: oRqRjz1QNqC7jXBYA22Dyg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B71FE811E86;
 Tue, 16 Jan 2024 03:20:43 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6DBB83C25;
 Tue, 16 Jan 2024 03:20:40 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 15/20] docs/migration: Split "Postcopy"
Date: Tue, 16 Jan 2024 11:19:42 +0800
Message-ID: <20240116031947.69017-16-peterx@redhat.com>
In-Reply-To: <20240116031947.69017-1-peterx@redhat.com>
References: <20240116031947.69017-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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

From: Peter Xu <peterx@redhat.com>

Split postcopy into a separate file.  Introduce a head page "features.rst"
to keep all the features on top of migration framework.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20240109064628.595453-7-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/migration/features.rst |   9 +
 docs/devel/migration/index.rst    |   1 +
 docs/devel/migration/main.rst     | 305 ------------------------------
 docs/devel/migration/postcopy.rst | 304 +++++++++++++++++++++++++++++
 4 files changed, 314 insertions(+), 305 deletions(-)
 create mode 100644 docs/devel/migration/features.rst
 create mode 100644 docs/devel/migration/postcopy.rst

diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
new file mode 100644
index 0000000000..0054e0c900
--- /dev/null
+++ b/docs/devel/migration/features.rst
@@ -0,0 +1,9 @@
+Migration features
+==================
+
+Migration has plenty of features to support different use cases.
+
+.. toctree::
+   :maxdepth: 2
+
+   postcopy
diff --git a/docs/devel/migration/index.rst b/docs/devel/migration/index.rst
index 9a8fd1ead7..21ad58b189 100644
--- a/docs/devel/migration/index.rst
+++ b/docs/devel/migration/index.rst
@@ -8,6 +8,7 @@ QEMU live migration works.
    :maxdepth: 2
 
    main
+   features
    compatibility
    vfio
    virtio
diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 97811ce371..051ea43f0e 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -644,308 +644,3 @@ algorithm will restrict virtual CPUs as needed to keep their dirty page
 rate inside the limit. This leads to more steady reading performance during
 live migration and can aid in improving large guest responsiveness.
 
-Postcopy
-========
-
-'Postcopy' migration is a way to deal with migrations that refuse to converge
-(or take too long to converge) its plus side is that there is an upper bound on
-the amount of migration traffic and time it takes, the down side is that during
-the postcopy phase, a failure of *either* side causes the guest to be lost.
-
-In postcopy the destination CPUs are started before all the memory has been
-transferred, and accesses to pages that are yet to be transferred cause
-a fault that's translated by QEMU into a request to the source QEMU.
-
-Postcopy can be combined with precopy (i.e. normal migration) so that if precopy
-doesn't finish in a given time the switch is made to postcopy.
-
-Enabling postcopy
------------------
-
-To enable postcopy, issue this command on the monitor (both source and
-destination) prior to the start of migration:
-
-``migrate_set_capability postcopy-ram on``
-
-The normal commands are then used to start a migration, which is still
-started in precopy mode.  Issuing:
-
-``migrate_start_postcopy``
-
-will now cause the transition from precopy to postcopy.
-It can be issued immediately after migration is started or any
-time later on.  Issuing it after the end of a migration is harmless.
-
-Blocktime is a postcopy live migration metric, intended to show how
-long the vCPU was in state of interruptible sleep due to pagefault.
-That metric is calculated both for all vCPUs as overlapped value, and
-separately for each vCPU. These values are calculated on destination
-side.  To enable postcopy blocktime calculation, enter following
-command on destination monitor:
-
-``migrate_set_capability postcopy-blocktime on``
-
-Postcopy blocktime can be retrieved by query-migrate qmp command.
-postcopy-blocktime value of qmp command will show overlapped blocking
-time for all vCPU, postcopy-vcpu-blocktime will show list of blocking
-time per vCPU.
-
-.. note::
-  During the postcopy phase, the bandwidth limits set using
-  ``migrate_set_parameter`` is ignored (to avoid delaying requested pages that
-  the destination is waiting for).
-
-Postcopy device transfer
-------------------------
-
-Loading of device data may cause the device emulation to access guest RAM
-that may trigger faults that have to be resolved by the source, as such
-the migration stream has to be able to respond with page data *during* the
-device load, and hence the device data has to be read from the stream completely
-before the device load begins to free the stream up.  This is achieved by
-'packaging' the device data into a blob that's read in one go.
-
-Source behaviour
-----------------
-
-Until postcopy is entered the migration stream is identical to normal
-precopy, except for the addition of a 'postcopy advise' command at
-the beginning, to tell the destination that postcopy might happen.
-When postcopy starts the source sends the page discard data and then
-forms the 'package' containing:
-
-   - Command: 'postcopy listen'
-   - The device state
-
-     A series of sections, identical to the precopy streams device state stream
-     containing everything except postcopiable devices (i.e. RAM)
-   - Command: 'postcopy run'
-
-The 'package' is sent as the data part of a Command: ``CMD_PACKAGED``, and the
-contents are formatted in the same way as the main migration stream.
-
-During postcopy the source scans the list of dirty pages and sends them
-to the destination without being requested (in much the same way as precopy),
-however when a page request is received from the destination, the dirty page
-scanning restarts from the requested location.  This causes requested pages
-to be sent quickly, and also causes pages directly after the requested page
-to be sent quickly in the hope that those pages are likely to be used
-by the destination soon.
-
-Destination behaviour
----------------------
-
-Initially the destination looks the same as precopy, with a single thread
-reading the migration stream; the 'postcopy advise' and 'discard' commands
-are processed to change the way RAM is managed, but don't affect the stream
-processing.
-
-::
-
-  ------------------------------------------------------------------------------
-                          1      2   3     4 5                      6   7
-  main -----DISCARD-CMD_PACKAGED ( LISTEN  DEVICE     DEVICE DEVICE RUN )
-  thread                             |       |
-                                     |     (page request)
-                                     |        \___
-                                     v            \
-  listen thread:                     --- page -- page -- page -- page -- page --
-
-                                     a   b        c
-  ------------------------------------------------------------------------------
-
-- On receipt of ``CMD_PACKAGED`` (1)
-
-   All the data associated with the package - the ( ... ) section in the diagram -
-   is read into memory, and the main thread recurses into qemu_loadvm_state_main
-   to process the contents of the package (2) which contains commands (3,6) and
-   devices (4...)
-
-- On receipt of 'postcopy listen' - 3 -(i.e. the 1st command in the package)
-
-   a new thread (a) is started that takes over servicing the migration stream,
-   while the main thread carries on loading the package.   It loads normal
-   background page data (b) but if during a device load a fault happens (5)
-   the returned page (c) is loaded by the listen thread allowing the main
-   threads device load to carry on.
-
-- The last thing in the ``CMD_PACKAGED`` is a 'RUN' command (6)
-
-   letting the destination CPUs start running.  At the end of the
-   ``CMD_PACKAGED`` (7) the main thread returns to normal running behaviour and
-   is no longer used by migration, while the listen thread carries on servicing
-   page data until the end of migration.
-
-Postcopy Recovery
------------------
-
-Comparing to precopy, postcopy is special on error handlings.  When any
-error happens (in this case, mostly network errors), QEMU cannot easily
-fail a migration because VM data resides in both source and destination
-QEMU instances.  On the other hand, when issue happens QEMU on both sides
-will go into a paused state.  It'll need a recovery phase to continue a
-paused postcopy migration.
-
-The recovery phase normally contains a few steps:
-
-  - When network issue occurs, both QEMU will go into PAUSED state
-
-  - When the network is recovered (or a new network is provided), the admin
-    can setup the new channel for migration using QMP command
-    'migrate-recover' on destination node, preparing for a resume.
-
-  - On source host, the admin can continue the interrupted postcopy
-    migration using QMP command 'migrate' with resume=true flag set.
-
-  - After the connection is re-established, QEMU will continue the postcopy
-    migration on both sides.
-
-During a paused postcopy migration, the VM can logically still continue
-running, and it will not be impacted from any page access to pages that
-were already migrated to destination VM before the interruption happens.
-However, if any of the missing pages got accessed on destination VM, the VM
-thread will be halted waiting for the page to be migrated, it means it can
-be halted until the recovery is complete.
-
-The impact of accessing missing pages can be relevant to different
-configurations of the guest.  For example, when with async page fault
-enabled, logically the guest can proactively schedule out the threads
-accessing missing pages.
-
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
-Postcopy with hugepages
------------------------
-
-Postcopy now works with hugetlbfs backed memory:
-
-  a) The linux kernel on the destination must support userfault on hugepages.
-  b) The huge-page configuration on the source and destination VMs must be
-     identical; i.e. RAMBlocks on both sides must use the same page size.
-  c) Note that ``-mem-path /dev/hugepages``  will fall back to allocating normal
-     RAM if it doesn't have enough hugepages, triggering (b) to fail.
-     Using ``-mem-prealloc`` enforces the allocation using hugepages.
-  d) Care should be taken with the size of hugepage used; postcopy with 2MB
-     hugepages works well, however 1GB hugepages are likely to be problematic
-     since it takes ~1 second to transfer a 1GB hugepage across a 10Gbps link,
-     and until the full page is transferred the destination thread is blocked.
-
-Postcopy with shared memory
----------------------------
-
-Postcopy migration with shared memory needs explicit support from the other
-processes that share memory and from QEMU. There are restrictions on the type of
-memory that userfault can support shared.
-
-The Linux kernel userfault support works on ``/dev/shm`` memory and on ``hugetlbfs``
-(although the kernel doesn't provide an equivalent to ``madvise(MADV_DONTNEED)``
-for hugetlbfs which may be a problem in some configurations).
-
-The vhost-user code in QEMU supports clients that have Postcopy support,
-and the ``vhost-user-bridge`` (in ``tests/``) and the DPDK package have changes
-to support postcopy.
-
-The client needs to open a userfaultfd and register the areas
-of memory that it maps with userfault.  The client must then pass the
-userfaultfd back to QEMU together with a mapping table that allows
-fault addresses in the clients address space to be converted back to
-RAMBlock/offsets.  The client's userfaultfd is added to the postcopy
-fault-thread and page requests are made on behalf of the client by QEMU.
-QEMU performs 'wake' operations on the client's userfaultfd to allow it
-to continue after a page has arrived.
-
-.. note::
-  There are two future improvements that would be nice:
-    a) Some way to make QEMU ignorant of the addresses in the clients
-       address space
-    b) Avoiding the need for QEMU to perform ufd-wake calls after the
-       pages have arrived
-
-Retro-fitting postcopy to existing clients is possible:
-  a) A mechanism is needed for the registration with userfault as above,
-     and the registration needs to be coordinated with the phases of
-     postcopy.  In vhost-user extra messages are added to the existing
-     control channel.
-  b) Any thread that can block due to guest memory accesses must be
-     identified and the implication understood; for example if the
-     guest memory access is made while holding a lock then all other
-     threads waiting for that lock will also be blocked.
-
-Postcopy Preemption Mode
-------------------------
-
-Postcopy preempt is a new capability introduced in 8.0 QEMU release, it
-allows urgent pages (those got page fault requested from destination QEMU
-explicitly) to be sent in a separate preempt channel, rather than queued in
-the background migration channel.  Anyone who cares about latencies of page
-faults during a postcopy migration should enable this feature.  By default,
-it's not enabled.
-
diff --git a/docs/devel/migration/postcopy.rst b/docs/devel/migration/postcopy.rst
new file mode 100644
index 0000000000..d60eec06ab
--- /dev/null
+++ b/docs/devel/migration/postcopy.rst
@@ -0,0 +1,304 @@
+Postcopy
+========
+
+'Postcopy' migration is a way to deal with migrations that refuse to converge
+(or take too long to converge) its plus side is that there is an upper bound on
+the amount of migration traffic and time it takes, the down side is that during
+the postcopy phase, a failure of *either* side causes the guest to be lost.
+
+In postcopy the destination CPUs are started before all the memory has been
+transferred, and accesses to pages that are yet to be transferred cause
+a fault that's translated by QEMU into a request to the source QEMU.
+
+Postcopy can be combined with precopy (i.e. normal migration) so that if precopy
+doesn't finish in a given time the switch is made to postcopy.
+
+Enabling postcopy
+-----------------
+
+To enable postcopy, issue this command on the monitor (both source and
+destination) prior to the start of migration:
+
+``migrate_set_capability postcopy-ram on``
+
+The normal commands are then used to start a migration, which is still
+started in precopy mode.  Issuing:
+
+``migrate_start_postcopy``
+
+will now cause the transition from precopy to postcopy.
+It can be issued immediately after migration is started or any
+time later on.  Issuing it after the end of a migration is harmless.
+
+Blocktime is a postcopy live migration metric, intended to show how
+long the vCPU was in state of interruptible sleep due to pagefault.
+That metric is calculated both for all vCPUs as overlapped value, and
+separately for each vCPU. These values are calculated on destination
+side.  To enable postcopy blocktime calculation, enter following
+command on destination monitor:
+
+``migrate_set_capability postcopy-blocktime on``
+
+Postcopy blocktime can be retrieved by query-migrate qmp command.
+postcopy-blocktime value of qmp command will show overlapped blocking
+time for all vCPU, postcopy-vcpu-blocktime will show list of blocking
+time per vCPU.
+
+.. note::
+  During the postcopy phase, the bandwidth limits set using
+  ``migrate_set_parameter`` is ignored (to avoid delaying requested pages that
+  the destination is waiting for).
+
+Postcopy device transfer
+------------------------
+
+Loading of device data may cause the device emulation to access guest RAM
+that may trigger faults that have to be resolved by the source, as such
+the migration stream has to be able to respond with page data *during* the
+device load, and hence the device data has to be read from the stream completely
+before the device load begins to free the stream up.  This is achieved by
+'packaging' the device data into a blob that's read in one go.
+
+Source behaviour
+----------------
+
+Until postcopy is entered the migration stream is identical to normal
+precopy, except for the addition of a 'postcopy advise' command at
+the beginning, to tell the destination that postcopy might happen.
+When postcopy starts the source sends the page discard data and then
+forms the 'package' containing:
+
+   - Command: 'postcopy listen'
+   - The device state
+
+     A series of sections, identical to the precopy streams device state stream
+     containing everything except postcopiable devices (i.e. RAM)
+   - Command: 'postcopy run'
+
+The 'package' is sent as the data part of a Command: ``CMD_PACKAGED``, and the
+contents are formatted in the same way as the main migration stream.
+
+During postcopy the source scans the list of dirty pages and sends them
+to the destination without being requested (in much the same way as precopy),
+however when a page request is received from the destination, the dirty page
+scanning restarts from the requested location.  This causes requested pages
+to be sent quickly, and also causes pages directly after the requested page
+to be sent quickly in the hope that those pages are likely to be used
+by the destination soon.
+
+Destination behaviour
+---------------------
+
+Initially the destination looks the same as precopy, with a single thread
+reading the migration stream; the 'postcopy advise' and 'discard' commands
+are processed to change the way RAM is managed, but don't affect the stream
+processing.
+
+::
+
+  ------------------------------------------------------------------------------
+                          1      2   3     4 5                      6   7
+  main -----DISCARD-CMD_PACKAGED ( LISTEN  DEVICE     DEVICE DEVICE RUN )
+  thread                             |       |
+                                     |     (page request)
+                                     |        \___
+                                     v            \
+  listen thread:                     --- page -- page -- page -- page -- page --
+
+                                     a   b        c
+  ------------------------------------------------------------------------------
+
+- On receipt of ``CMD_PACKAGED`` (1)
+
+   All the data associated with the package - the ( ... ) section in the diagram -
+   is read into memory, and the main thread recurses into qemu_loadvm_state_main
+   to process the contents of the package (2) which contains commands (3,6) and
+   devices (4...)
+
+- On receipt of 'postcopy listen' - 3 -(i.e. the 1st command in the package)
+
+   a new thread (a) is started that takes over servicing the migration stream,
+   while the main thread carries on loading the package.   It loads normal
+   background page data (b) but if during a device load a fault happens (5)
+   the returned page (c) is loaded by the listen thread allowing the main
+   threads device load to carry on.
+
+- The last thing in the ``CMD_PACKAGED`` is a 'RUN' command (6)
+
+   letting the destination CPUs start running.  At the end of the
+   ``CMD_PACKAGED`` (7) the main thread returns to normal running behaviour and
+   is no longer used by migration, while the listen thread carries on servicing
+   page data until the end of migration.
+
+Postcopy Recovery
+-----------------
+
+Comparing to precopy, postcopy is special on error handlings.  When any
+error happens (in this case, mostly network errors), QEMU cannot easily
+fail a migration because VM data resides in both source and destination
+QEMU instances.  On the other hand, when issue happens QEMU on both sides
+will go into a paused state.  It'll need a recovery phase to continue a
+paused postcopy migration.
+
+The recovery phase normally contains a few steps:
+
+  - When network issue occurs, both QEMU will go into PAUSED state
+
+  - When the network is recovered (or a new network is provided), the admin
+    can setup the new channel for migration using QMP command
+    'migrate-recover' on destination node, preparing for a resume.
+
+  - On source host, the admin can continue the interrupted postcopy
+    migration using QMP command 'migrate' with resume=true flag set.
+
+  - After the connection is re-established, QEMU will continue the postcopy
+    migration on both sides.
+
+During a paused postcopy migration, the VM can logically still continue
+running, and it will not be impacted from any page access to pages that
+were already migrated to destination VM before the interruption happens.
+However, if any of the missing pages got accessed on destination VM, the VM
+thread will be halted waiting for the page to be migrated, it means it can
+be halted until the recovery is complete.
+
+The impact of accessing missing pages can be relevant to different
+configurations of the guest.  For example, when with async page fault
+enabled, logically the guest can proactively schedule out the threads
+accessing missing pages.
+
+Postcopy states
+---------------
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
+Source side page map
+--------------------
+
+The 'migration bitmap' in postcopy is basically the same as in the precopy,
+where each of the bit to indicate that page is 'dirty' - i.e. needs
+sending.  During the precopy phase this is updated as the CPU dirties
+pages, however during postcopy the CPUs are stopped and nothing should
+dirty anything any more. Instead, dirty bits are cleared when the relevant
+pages are sent during postcopy.
+
+Postcopy with hugepages
+-----------------------
+
+Postcopy now works with hugetlbfs backed memory:
+
+  a) The linux kernel on the destination must support userfault on hugepages.
+  b) The huge-page configuration on the source and destination VMs must be
+     identical; i.e. RAMBlocks on both sides must use the same page size.
+  c) Note that ``-mem-path /dev/hugepages``  will fall back to allocating normal
+     RAM if it doesn't have enough hugepages, triggering (b) to fail.
+     Using ``-mem-prealloc`` enforces the allocation using hugepages.
+  d) Care should be taken with the size of hugepage used; postcopy with 2MB
+     hugepages works well, however 1GB hugepages are likely to be problematic
+     since it takes ~1 second to transfer a 1GB hugepage across a 10Gbps link,
+     and until the full page is transferred the destination thread is blocked.
+
+Postcopy with shared memory
+---------------------------
+
+Postcopy migration with shared memory needs explicit support from the other
+processes that share memory and from QEMU. There are restrictions on the type of
+memory that userfault can support shared.
+
+The Linux kernel userfault support works on ``/dev/shm`` memory and on ``hugetlbfs``
+(although the kernel doesn't provide an equivalent to ``madvise(MADV_DONTNEED)``
+for hugetlbfs which may be a problem in some configurations).
+
+The vhost-user code in QEMU supports clients that have Postcopy support,
+and the ``vhost-user-bridge`` (in ``tests/``) and the DPDK package have changes
+to support postcopy.
+
+The client needs to open a userfaultfd and register the areas
+of memory that it maps with userfault.  The client must then pass the
+userfaultfd back to QEMU together with a mapping table that allows
+fault addresses in the clients address space to be converted back to
+RAMBlock/offsets.  The client's userfaultfd is added to the postcopy
+fault-thread and page requests are made on behalf of the client by QEMU.
+QEMU performs 'wake' operations on the client's userfaultfd to allow it
+to continue after a page has arrived.
+
+.. note::
+  There are two future improvements that would be nice:
+    a) Some way to make QEMU ignorant of the addresses in the clients
+       address space
+    b) Avoiding the need for QEMU to perform ufd-wake calls after the
+       pages have arrived
+
+Retro-fitting postcopy to existing clients is possible:
+  a) A mechanism is needed for the registration with userfault as above,
+     and the registration needs to be coordinated with the phases of
+     postcopy.  In vhost-user extra messages are added to the existing
+     control channel.
+  b) Any thread that can block due to guest memory accesses must be
+     identified and the implication understood; for example if the
+     guest memory access is made while holding a lock then all other
+     threads waiting for that lock will also be blocked.
+
+Postcopy Preemption Mode
+------------------------
+
+Postcopy preempt is a new capability introduced in 8.0 QEMU release, it
+allows urgent pages (those got page fault requested from destination QEMU
+explicitly) to be sent in a separate preempt channel, rather than queued in
+the background migration channel.  Anyone who cares about latencies of page
+faults during a postcopy migration should enable this feature.  By default,
+it's not enabled.
-- 
2.43.0


