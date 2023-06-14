Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E3C730685
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 20:02:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Umr-0007ZU-Gi; Wed, 14 Jun 2023 14:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q9Umo-0007ZC-HT
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 14:00:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q9Uml-0001lj-Ue
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 14:00:02 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3A1AB1FDEC;
 Wed, 14 Jun 2023 17:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1686765598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nh82iEruHHP4Nlw1VnrOAV8vFr0k4gmxV++gCUU0vUg=;
 b=n9W3IjwPzFYIW5JNHIRXEvuocthr+E+hs4tzGHBgOXGHGdGJ3IEnF228WUsSPu5awDg+p+
 AYEoqUuMrbGTayU1S75KgymIv1JW692UvIc5FLvLd8KyRIm5eNI9y1q1MzCyKw0Hk47YH3
 epNj7FZFDRmaH/3hQvFj2sY20cag8Es=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1686765598;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nh82iEruHHP4Nlw1VnrOAV8vFr0k4gmxV++gCUU0vUg=;
 b=PTmRBkfFsA8WNqKZ0Zf5nqX2rY9kkbxFTJLZw0fACiYevdkRiU7W538X2gbJIewFQwzYew
 vvdIPN7dRY+x2LAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B6A01357F;
 Wed, 14 Jun 2023 17:59:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5T/zDB0AimQBXwAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 14 Jun 2023 17:59:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org, Juan
 Quintela <quintela@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH V2] migration: file URI
In-Reply-To: <ZInhvxq9YgoM9ykZ@x1n>
References: <1686163139-256654-1-git-send-email-steven.sistare@oracle.com>
 <ZIdnj7Hr1L3iDVUG@x1n> <bddfc088-268b-2d9b-7a28-6345b8bfa2e7@oracle.com>
 <ZId4LggDVgxbtGTn@x1n> <877cs6ujtu.fsf@suse.de> <ZInhvxq9YgoM9ykZ@x1n>
Date: Wed, 14 Jun 2023 14:59:54 -0300
Message-ID: <874jn9vs9x.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Jun 14, 2023 at 12:47:41PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Mon, Jun 12, 2023 at 03:39:34PM -0400, Steven Sistare wrote:
>> >> On 6/12/2023 2:44 PM, Peter Xu wrote:
>> >> > Hi, Steve,
>> >> > 
>> >> > On Wed, Jun 07, 2023 at 11:38:59AM -0700, Steve Sistare wrote:
>> >> >> Extend the migration URI to support file:<filename>.  This can be used for
>> >> >> any migration scenario that does not require a reverse path.  It can be used
>> >> >> as an alternative to 'exec:cat > file' in minimized containers that do not
>> >> >> contain /bin/sh, and it is easier to use than the fd:<fdname> URI.  It can
>> >> >> be used in HMP commands, and as a qemu command-line parameter.
>> >> > 
>> >> > I have similar question on the fixed-ram work,
>> >> 
>> >> Sorry, what is the "fixed-ram work"?
>> >
>> > https://lore.kernel.org/all/20230330180336.2791-1-farosas@suse.de
>> >
>> > It has similar requirement to migrate to a file, though slightly different
>> > use case.
>> >
>> >> 
>> >> > on whether we should assume
>> >> > the vm stopped before doing so.  Again, it leaves us space for
>> >> > optimizations on top without breaking anyone.
>> >> 
>> >> I do not assume the vm is stopped.  The migration code will stop the vm
>> >> in migration_iteration_finish.
>> >> 
>> >> > The other thing is considering a very busy guest, migration may not even
>> >> > converge for "file:" URI (the same to other URIs) but I think that doesn't
>> >> > make much sense to not converge for a "file:" URI.  The user might be very
>> >> > confused too.
>> >> 
>> >> The file URI is mainly intended for the case where guest ram is backed by shared memory 
>> >> and preserved in place, in which case writes are not tracked and convergence is not an
>> >> issue.  If not shared memory, the user should be advised to stop the machine first.
>> >> I should document these notes in qemu-options and/or migration.json.
>> >
>> > My question was whether we should treat "file:" differently from most of
>> > other URIs.  It makes the URI slightly tricky for sure, but it also does
>> > make sense to me because "file:" implies more than the rest URIs, where
>> > we're sure about the consequence of the migration (vm stops), in that case
>> > keeping vm live makes it less performant, and also weird.
>> >
>> > It doesn't need to be special in memory type being shared, e.g. what if
>> > there's a device that contains a lot of data to migrate in the future?
>> > Assuming "shared memory will always migrate very fast" may not hold true.
>> >
>> > Do you think it makes more sense to just always stop VM when migrating to
>> > file URI?  Then if someone tries to restart the VM or cancel the migration,
>> > we always do both (cancel migration, then start VM).
>> 
>> From our discussions in the other thread, I have implemented a
>> MIGRATION_CAPABILITY_SUSPEND to allow the management layer to decide
>> whether the guest should be stopped by QEMU before the migration.
>> 
>> I'm not opposed to coupling file URI with a stopped VM, although I
>> think, at least for fixed-ram, libvirt would prefer to be able to decide
>> when to stop.
>
> IIUC the best timing is when migration starts, not earlier, not later.
>

Sorry, I meant "when" as in "which migration instances".

> If that's always the case, it's better qemu guarantee that?  Or am I wrong
> that libvirt wants to not do it in some cases?

In this message Daniel mentions virDomainSnapshotXXX which would benefit
from using the same "file" migration, but being done live:

https://lore.kernel.org/r/ZD7MRGQ+4QsDBtKR@redhat.com

And from your response here:
 https://lore.kernel.org/r/ZEA759BSs75ldW6Y@x1n

I had understood that having a new SUSPEND cap to decide whether to do
it live or non-live would be enough to cover all use-cases.

