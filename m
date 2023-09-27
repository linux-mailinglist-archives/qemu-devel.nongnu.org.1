Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E9A7B0461
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 14:40:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlTpZ-0000lX-6D; Wed, 27 Sep 2023 08:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qlTpM-0000bC-5j
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 08:39:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qlTpJ-0002HJ-D7
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 08:39:38 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 14573210E3;
 Wed, 27 Sep 2023 12:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695818376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sqe9mAvCuoHyl+Ajzn5lMh6rh9ysfzdLGn3NZGdnPZE=;
 b=J+HQb4m7iUfaivXzXBHiviVWSn9GXWUrSLq/PqOsO/c0dSif539/ho/Uovuf6nrfY2e5Kh
 5/9tCbBrfojkOO40V9gJ8ZNe32wm9Da9V9dgARfcI2N0Aghx3ZUn6GYge/1fVdo513sTx9
 y/r4AFxT8fZR7rJs04QdZA8klLaWnOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695818376;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sqe9mAvCuoHyl+Ajzn5lMh6rh9ysfzdLGn3NZGdnPZE=;
 b=XYzeQHbqV7XNqEQUf6bpcYQxvihyZIDa/lS0QRD8gNH132MJsVKtnoEGiA5NMfWNrfhcQo
 7j+x/DzIG1TL3JBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F88713479;
 Wed, 27 Sep 2023 12:39:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tu3aGociFGUUBQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 27 Sep 2023 12:39:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 0/8] migration fixes
In-Reply-To: <20230918172822.19052-1-farosas@suse.de>
References: <20230918172822.19052-1-farosas@suse.de>
Date: Wed, 27 Sep 2023 09:39:33 -0300
Message-ID: <8734yzn62i.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fabiano Rosas <farosas@suse.de> writes:

> This series contains fixes for the two currently know failures that
> show up in migration tests plus a set of fixes for some theoretical
> race conditions around QEMUFile handling.
>
> Patch 1 addresses the issue found in the postcopy/preempt/plain test:
> https://gitlab.com/qemu-project/qemu/-/issues/1886
>
> Patch 7 fixes a rare crash during the postocpy/preempt/recovery/plain test:
>
>   Thread 7 "return path" received signal SIGSEGV, Segmentation fault.
>       0x00005555560e4893 in qemu_file_get_error_obj (f=0x0, errp=0x0) at ../migration/qemu-file.c:154
>       154         return f->last_error;
>
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1008652837
>
> Fabiano Rosas (7):
>   migration: Fix possible race when setting rp_state.error
>   migration: Fix possible races when shutting down the return path
>   migration: Fix possible race when shutting down to_dst_file
>   migration: Remove redundant cleanup of postcopy_qemufile_src
>   migration: Consolidate return path closing code
>   migration: Replace the return path retry logic
>   migration: Move return path cleanup to main migration thread
>
> Peter Xu (1):
>   migration: Fix race that dest preempt thread close too early
>
>  migration/migration.c    | 145 +++++++++++++++------------------------
>  migration/migration.h    |  14 +++-
>  migration/postcopy-ram.c |  38 +++++++++-
>  3 files changed, 106 insertions(+), 91 deletions(-)

Ping

