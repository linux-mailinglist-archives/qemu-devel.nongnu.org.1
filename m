Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2E774992F
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 12:16:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHM1r-00040o-Hf; Thu, 06 Jul 2023 06:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qHM1o-0003zC-Qn
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:16:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qHM1m-0004um-Qb
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688638556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lai2jSluB6Hol1XoCgFN0/XwaVbMUG7S5ipHRjn+3AQ=;
 b=HRIiaJ9H9zq/SPHNSQF4QBbMEfmwev0lvVfh+VCIZstUIGMckwrb8oILOLR80hDE4CSKao
 5+UsFGRof9PyPjb17JYwO0gSD+haz0VSU4wv2Kj8VC/+G3QBVHAPGX1Y6iLshKkjbs9+qI
 /Ixir2SCymvNxSbW2nZxfk9uTMii3bE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-x0IbV2WDMMOdMvcq5_CK6w-1; Thu, 06 Jul 2023 06:15:55 -0400
X-MC-Unique: x0IbV2WDMMOdMvcq5_CK6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 014A681DA5D
 for <qemu-devel@nongnu.org>; Thu,  6 Jul 2023 10:15:55 +0000 (UTC)
Received: from [10.39.194.17] (unknown [10.39.194.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 092A92166B25;
 Thu,  6 Jul 2023 10:15:53 +0000 (UTC)
Message-ID: <ddb293c6-2475-8fbb-7d84-f276ce17956a@redhat.com>
Date: Thu, 6 Jul 2023 12:15:47 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] docs/migration: Update postcopy bits
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>
References: <20230627200222.557529-1-peterx@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <20230627200222.557529-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lersek@redhat.com;
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

On 6/27/23 22:02, Peter Xu wrote:
> We have postcopy recovery but not reflected in the document, do an update
> for that.
> 
> Add a very small section on postcopy preempt.
> 
> Touch up the pagemap section, dropping the unsent map because it's already
> been dropped in the source code in commit 1e7cf8c323 ("migration/postcopy:
> unsentmap is not necessary for postcopy").
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/devel/migration.rst | 89 +++++++++++++++++++++++++++++-----------
>  1 file changed, 65 insertions(+), 24 deletions(-)
> 
> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
> index 6f65c23b47..6ed485ae38 100644
> --- a/docs/devel/migration.rst
> +++ b/docs/devel/migration.rst
> @@ -721,6 +721,42 @@ processing.
>     is no longer used by migration, while the listen thread carries on servicing
>     page data until the end of migration.
>  
> +Postcopy Recovery
> +-----------------
> +
> +Comparing to precopy, postcopy is special on error handlings.  When any
> +error happens (in this case, mostly network errors), QEMU cannot easily
> +fail a migration because VM data resides in both source and destination
> +QEMU instances.  On the other hand, when issue happens QEMU on both sides
> +will go into a paused state.  It'll need a recovery phase to continue a
> +paused postcopy migration.
> +
> +The recovery phase normally contains a few steps:
> +
> +  - When network issue occurs, both QEMU will go into PAUSED state
> +
> +  - When the network is recovered (or a new network is provided), the admin
> +    can setup the new channel for migration using QMP command
> +    'migrate-recover' on destination node, preparing for a resume.
> +
> +  - On source host, the admin can continue the interrupted postcopy
> +    migration using QMP command 'migrate' with resume=true flag set.
> +
> +  - After the connection is re-established, QEMU will continue the postcopy
> +    migration on both sides.
> +
> +During a paused postcopy migration, the VM can logically still continue
> +running, and it will not be impacted from any page access to pages that
> +were already migrated to destination VM before the interruption happens.
> +However, if any of the missing pages got accessed on destination VM, the VM
> +thread will be halted waiting for the page to be migrated, it means it can
> +be halted until the recovery is complete.
> +
> +The impact of accessing missing pages can be relevant to different
> +configurations of the guest.  For example, when with async page fault
> +enabled, logically the guest can proactively schedule out the threads
> +accessing missing pages.
> +
>  Postcopy states
>  ---------------
>  
> @@ -765,36 +801,31 @@ ADVISE->DISCARD->LISTEN->RUNNING->END
>      (although it can't do the cleanup it would do as it
>      finishes a normal migration).
>  
> + - Paused
> +
> +    Postcopy can run into a paused state (normally on both sides when
> +    happens), where all threads will be temporarily halted mostly due to
> +    network errors.  When reaching paused state, migration will make sure
> +    the qemu binary on both sides maintain the data without corrupting
> +    the VM.  To continue the migration, the admin needs to fix the
> +    migration channel using the QMP command 'migrate-recover' on the
> +    destination node, then resume the migration using QMP command 'migrate'
> +    again on source node, with resume=true flag set.
> +
>   - End
>  
>      The listen thread can now quit, and perform the cleanup of migration
>      state, the migration is now complete.
>  
> -Source side page maps
> ----------------------
> +Source side page map
> +--------------------
>  
> -The source side keeps two bitmaps during postcopy; 'the migration bitmap'
> -and 'unsent map'.  The 'migration bitmap' is basically the same as in
> -the precopy case, and holds a bit to indicate that page is 'dirty' -
> -i.e. needs sending.  During the precopy phase this is updated as the CPU
> -dirties pages, however during postcopy the CPUs are stopped and nothing
> -should dirty anything any more.
> -
> -The 'unsent map' is used for the transition to postcopy. It is a bitmap that
> -has a bit cleared whenever a page is sent to the destination, however during
> -the transition to postcopy mode it is combined with the migration bitmap
> -to form a set of pages that:
> -
> -   a) Have been sent but then redirtied (which must be discarded)
> -   b) Have not yet been sent - which also must be discarded to cause any
> -      transparent huge pages built during precopy to be broken.
> -
> -Note that the contents of the unsentmap are sacrificed during the calculation
> -of the discard set and thus aren't valid once in postcopy.  The dirtymap
> -is still valid and is used to ensure that no page is sent more than once.  Any
> -request for a page that has already been sent is ignored.  Duplicate requests
> -such as this can happen as a page is sent at about the same time the
> -destination accesses it.
> +The 'migration bitmap' in postcopy is basically the same as in the precopy,
> +where each of the bit to indicate that page is 'dirty' - i.e. needs
> +sending.  During the precopy phase this is updated as the CPU dirties
> +pages, however during postcopy the CPUs are stopped and nothing should
> +dirty anything any more. Instead, dirty bits are cleared when the relevant
> +pages are sent during postcopy.
>  
>  Postcopy with hugepages
>  -----------------------
> @@ -853,6 +884,16 @@ Retro-fitting postcopy to existing clients is possible:
>       guest memory access is made while holding a lock then all other
>       threads waiting for that lock will also be blocked.
>  
> +Postcopy Preemption Mode
> +------------------------
> +
> +Postcopy preempt is a new capability introduced in 8.0 QEMU release, it
> +allows urgent pages (those got page fault requested from destination QEMU
> +explicitly) to be sent in a separate preempt channel, rather than queued in
> +the background migration channel.  Anyone who cares about latencies of page
> +faults during a postcopy migration should enable this feature.  By default,
> +it's not enabled.
> +
>  Firmware
>  ========
>  

One suggestion, to squash in:

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index 6f65c23b47dc..3294679936b2 100644
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

This removes "or the network connection" as a fatal failure.

Acked-by: Laszlo Ersek <lersek@redhat.com>

Laszlo


