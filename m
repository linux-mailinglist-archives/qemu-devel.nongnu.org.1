Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5CF78D7D9
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 19:44:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbPDv-0005cK-MA; Wed, 30 Aug 2023 13:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qbPDp-0005Pp-Gs; Wed, 30 Aug 2023 13:43:17 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qbPDn-0007B8-2O; Wed, 30 Aug 2023 13:43:17 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 877E521850;
 Wed, 30 Aug 2023 17:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693417391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IaODpBWakujtrJ0lCYeSOwk7ksqC4bQZWiaIn1M69Lc=;
 b=o1Nf7PLN9T///QJOcamGOjxmRdrrc1ICaZDpklNkfk0phYiv7vTSf+oX6N/rjySEdS2IuK
 G1axA1nH0Hh5uWXUNZ8HlzlSHDgXRXGRFE8BhVWuYFEux7S+RMU4c/rxJGUULpAOLb0EEh
 d4jLW/6Ef/XFm60BupB7t6LnkUE5bck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693417391;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IaODpBWakujtrJ0lCYeSOwk7ksqC4bQZWiaIn1M69Lc=;
 b=HFKNG1ow+FAbdUz2zd65XtpPVv18h+wBhnCzl/qJL0aT0bIsyXbojYj8GImCWTVwhE3RZL
 kaLe39saG5B9EMBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0BC2713441;
 Wed, 30 Aug 2023 17:43:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eNMJMq5/72ROdAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 30 Aug 2023 17:43:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Michael Tokarev <mjt@tls.msk.ru>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Juan Quintela
 <quintela@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Jeuk
 Kim <jeuk20.kim@samsung.com>, qemu-block@nongnu.org, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Leonardo Bras
 <leobras@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?utf-8?Q?Dani?=
 =?utf-8?Q?el_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Peter Xu
 <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow
 <jsnow@redhat.com>, Fam Zheng <fam@euphon.net>, =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau
 <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PULL v3 1/5] block-migration: Ensure we don't crash during
 migration cleanup
In-Reply-To: <a3782935-e47c-c66e-8175-126c8747ec95@tls.msk.ru>
References: <20230830114942.449060-1-stefanha@redhat.com>
 <20230830114942.449060-2-stefanha@redhat.com>
 <a3782935-e47c-c66e-8175-126c8747ec95@tls.msk.ru>
Date: Wed, 30 Aug 2023 14:43:08 -0300
Message-ID: <87o7ioifyr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> 30.08.2023 14:49, Stefan Hajnoczi wrote:
>> From: Fabiano Rosas <farosas@suse.de>
>> 
>> We can fail the blk_insert_bs() at init_blk_migration(), leaving the
>> BlkMigDevState without a dirty_bitmap and BlockDriverState. Account
>> for the possibly missing elements when doing cleanup.
>> 
>> Fix the following crashes:
>> 
>> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
>> 0x0000555555ec83ef in bdrv_release_dirty_bitmap (bitmap=0x0) at ../block/dirty-bitmap.c:359
>> 359         BlockDriverState *bs = bitmap->bs;
>>   #0  0x0000555555ec83ef in bdrv_release_dirty_bitmap (bitmap=0x0) at ../block/dirty-bitmap.c:359
>>   #1  0x0000555555bba331 in unset_dirty_tracking () at ../migration/block.c:371
>>   #2  0x0000555555bbad98 in block_migration_cleanup_bmds () at ../migration/block.c:681
>> 
>> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
>> 0x0000555555e971ff in bdrv_op_unblock (bs=0x0, op=BLOCK_OP_TYPE_BACKUP_SOURCE, reason=0x0) at ../block.c:7073
>> 7073        QLIST_FOREACH_SAFE(blocker, &bs->op_blockers[op], list, next) {
>>   #0  0x0000555555e971ff in bdrv_op_unblock (bs=0x0, op=BLOCK_OP_TYPE_BACKUP_SOURCE, reason=0x0) at ../block.c:7073
>>   #1  0x0000555555e9734a in bdrv_op_unblock_all (bs=0x0, reason=0x0) at ../block.c:7095
>>   #2  0x0000555555bbae13 in block_migration_cleanup_bmds () at ../migration/block.c:690
>
> This smells like -stable material, is it not?
> (applies to 7.2, 8.0 and 8.1).

Yes, I agree.


