Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FD9749B38
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 13:56:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHNau-0003Sa-Fx; Thu, 06 Jul 2023 07:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHNas-0003SS-8Z
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:56:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHNaq-00069Q-8l
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688644575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2f/g2alP9+EzLjZZT0/Ao0oN96X9B3txxDORPb4OgI4=;
 b=i4hudDJ2lWF+uVEnNRFhSRoVgkG50IlEx5MekNLXFW0SkF3pW51LaYVRVTQnSg+f9aUVjK
 BVrbIZlspAVbe53JtQ2UWg9xq0XfxCnQ56cLWQ9rwvBB+U10v58Tckex/2Qruz+4coqtLB
 Gzl6L8GLGrlboJsGbE4YtUpKPpbnoPo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-hwLUWhenPu2_w4CiHzip4g-1; Thu, 06 Jul 2023 07:56:14 -0400
X-MC-Unique: hwLUWhenPu2_w4CiHzip4g-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7673887b2cfso18769885a.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 04:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688644573; x=1691236573;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2f/g2alP9+EzLjZZT0/Ao0oN96X9B3txxDORPb4OgI4=;
 b=Xbn50L86sO+0+aMitXv0Wr8hB5KHpcbes+MNhlsZUjqPNMgrZzw6a2IA4PxiQUHUR2
 vVNZby9t//pn5G8xC2htSOFKqAnO2tr5Rvh3wHxJolyTBUkP+9IpGbCSrDE0tFJM/tBp
 xvd+MpESxdhTxdklHLGOgs+E1bRwyVM2TpXdbm22oLRFlhdQaUXPskKbJQZ0T4UmxwDK
 a8lddZiVQrPBDEg06vRlRk66UuUAFi8kXutFzmnbHccHehyLRa8SZOtT/2yu2IDas4dg
 FKKr8KYH/crWjRVbgy6o5KdKT3iTOE0B9O14qQ7sbCXIi5owYJw5wydgg9yxQBMbM4X4
 /DJw==
X-Gm-Message-State: ABy/qLbpR2LQwQwFfz0vixijgy3u0vh0iwMtpq+DRA31/McZEkHC8Wg6
 D5U9EeuG3wjUmUpXjk7/F7UPScHDZlqETVvkmqNlAfZMvyUsX/au8Nxn0SawyysfZahvgl5pGFp
 udfckzRhuq3OERUJhLNyyoyJ85MpzD8H/RDFEE0dv/1WMwdfYnjRXUqX6KQfH2zpXu/8twVwW
X-Received: by 2002:a05:620a:2a0e:b0:75b:23a1:69e4 with SMTP id
 o14-20020a05620a2a0e00b0075b23a169e4mr1936061qkp.4.1688644573489; 
 Thu, 06 Jul 2023 04:56:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEVlyTHcdncMTqHKnM3S4DNV/SYxhVUMsP4ukNsJsQAezIdU1S3v+Ir8KjMROBS7LR5BqI1qg==
X-Received: by 2002:a05:620a:2a0e:b0:75b:23a1:69e4 with SMTP id
 o14-20020a05620a2a0e00b0075b23a169e4mr1936037qkp.4.1688644573031; 
 Thu, 06 Jul 2023 04:56:13 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 a3-20020a05620a102300b00765a71e399bsm665778qkk.55.2023.07.06.04.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 04:56:12 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2] docs/migration: Update postcopy bits
Date: Thu,  6 Jul 2023 07:56:11 -0400
Message-ID: <20230706115611.371048-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

We have postcopy recovery but not reflected in the document, do an update
for that.

Add a very small section on postcopy preempt.

Touch up the pagemap section, dropping the unsent map because it's already
been dropped in the source code in commit 1e7cf8c323 ("migration/postcopy:
unsentmap is not necessary for postcopy").

Touch up the postcopy section to remove "network connection" failures as
downside, because now it's not fatal and can be recovered.  Suggested by
Laszlo.

Acked-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
v2:
- Touch up "network connection" failures lines [Laszlo]
- Added A-b for Laszlo
---
 docs/devel/migration.rst | 92 ++++++++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 26 deletions(-)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index 6f65c23b47..c3e1400c0c 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -594,8 +594,7 @@ Postcopy
 'Postcopy' migration is a way to deal with migrations that refuse to converge
 (or take too long to converge) its plus side is that there is an upper bound on
 the amount of migration traffic and time it takes, the down side is that during
-the postcopy phase, a failure of *either* side or the network connection causes
-the guest to be lost.
+the postcopy phase, a failure of *either* side causes the guest to be lost.
 
 In postcopy the destination CPUs are started before all the memory has been
 transferred, and accesses to pages that are yet to be transferred cause
@@ -721,6 +720,42 @@ processing.
    is no longer used by migration, while the listen thread carries on servicing
    page data until the end of migration.
 
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
 Postcopy states
 ---------------
 
@@ -765,36 +800,31 @@ ADVISE->DISCARD->LISTEN->RUNNING->END
     (although it can't do the cleanup it would do as it
     finishes a normal migration).
 
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
  - End
 
     The listen thread can now quit, and perform the cleanup of migration
     state, the migration is now complete.
 
-Source side page maps
----------------------
+Source side page map
+--------------------
 
-The source side keeps two bitmaps during postcopy; 'the migration bitmap'
-and 'unsent map'.  The 'migration bitmap' is basically the same as in
-the precopy case, and holds a bit to indicate that page is 'dirty' -
-i.e. needs sending.  During the precopy phase this is updated as the CPU
-dirties pages, however during postcopy the CPUs are stopped and nothing
-should dirty anything any more.
-
-The 'unsent map' is used for the transition to postcopy. It is a bitmap that
-has a bit cleared whenever a page is sent to the destination, however during
-the transition to postcopy mode it is combined with the migration bitmap
-to form a set of pages that:
-
-   a) Have been sent but then redirtied (which must be discarded)
-   b) Have not yet been sent - which also must be discarded to cause any
-      transparent huge pages built during precopy to be broken.
-
-Note that the contents of the unsentmap are sacrificed during the calculation
-of the discard set and thus aren't valid once in postcopy.  The dirtymap
-is still valid and is used to ensure that no page is sent more than once.  Any
-request for a page that has already been sent is ignored.  Duplicate requests
-such as this can happen as a page is sent at about the same time the
-destination accesses it.
+The 'migration bitmap' in postcopy is basically the same as in the precopy,
+where each of the bit to indicate that page is 'dirty' - i.e. needs
+sending.  During the precopy phase this is updated as the CPU dirties
+pages, however during postcopy the CPUs are stopped and nothing should
+dirty anything any more. Instead, dirty bits are cleared when the relevant
+pages are sent during postcopy.
 
 Postcopy with hugepages
 -----------------------
@@ -853,6 +883,16 @@ Retro-fitting postcopy to existing clients is possible:
      guest memory access is made while holding a lock then all other
      threads waiting for that lock will also be blocked.
 
+Postcopy Preemption Mode
+------------------------
+
+Postcopy preempt is a new capability introduced in 8.0 QEMU release, it
+allows urgent pages (those got page fault requested from destination QEMU
+explicitly) to be sent in a separate preempt channel, rather than queued in
+the background migration channel.  Anyone who cares about latencies of page
+faults during a postcopy migration should enable this feature.  By default,
+it's not enabled.
+
 Firmware
 ========
 
-- 
2.41.0


