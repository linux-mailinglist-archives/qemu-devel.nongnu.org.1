Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E19F762148
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 20:25:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOMi4-0000Cj-JG; Tue, 25 Jul 2023 14:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qOMi2-0000CY-BP
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:24:34 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qOMhz-0005IG-Mg
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:24:33 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 447AD1FD90;
 Tue, 25 Jul 2023 18:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1690309469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w79NPHniTAnsC8aSF/IzEv0lE3ed2uWTImclAZSTTgM=;
 b=gPJWkXif//ihxUuxBEFcWDG76rdhNmjajVMBAiq3x4hhiNr9+xw8RoTvFrb9t1ok3yMqp1
 GHQTf3Fp3+Kzm5Wx7Ul/CghPaJsvsuIy5AwGZSKAsgnHa1LIL6bvTLPb3vkYmJMg8j96en
 iEoYGjpBtkq2QPVj0nTRxNf+ekt9rE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1690309469;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w79NPHniTAnsC8aSF/IzEv0lE3ed2uWTImclAZSTTgM=;
 b=7w/INNM2pcQWPYQ5BJS5FlD5roZ11E4F9VDeEQT1+ItA8fTsK1LH0eIhFK+EaqoCT4FyIG
 CCDjTTb7glwaqjBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC6FA13487;
 Tue, 25 Jul 2023 18:24:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wXd7JVwTwGTVcwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 25 Jul 2023 18:24:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Leonardo Bras Soares Passos <lsoaresp@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Lukas Straub <lukasstraub2@web.de>, Laszlo Ersek
 <lersek@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH v2 0/7] migration: Better error handling in return path
 thread
In-Reply-To: <87351dz9fi.fsf@suse.de>
References: <20230705163502.331007-1-peterx@redhat.com>
 <87351dz9fi.fsf@suse.de>
Date: Tue, 25 Jul 2023 15:24:26 -0300
Message-ID: <87r0ovonmt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
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

Fabiano Rosas <farosas@suse.de> writes:

> Peter Xu <peterx@redhat.com> writes:
>
>> v2:
>> - Patch "migration: Provide explicit error message for file shutdowns"
>>   - Touched up qapi doc [Fabiano]
>>   - Added Bugzilla link to commit which I didn't even notice that I was
>>     fixing a bug.. but rightfully pointed out by Laszlo.
>>   - Moved it to the 1st patch because it fixes a bug, please consider
>>     review and merge it earlier.
>>
>> This is a small series that reworks error handling of postcopy return path
>> threads.
>>
>> We used to contain a bunch of error_report(), converting them into
>> error_setg() properly and deliver any of those errors to migration generic
>> error reports (via migrate_set_error()).  Then these errors can also be
>> observed in query-migrate after postcopy is paused.
>>
>> Dropped the return-path specific error reporting: mark_source_rp_bad(),
>> because it's a duplication if we can always use migrate_set_error().
>>
>> Please have a look, thanks.
>>
>> Peter Xu (7):
>>   migration: Display error in query-migrate irrelevant of status
>>   migration: Let migrate_set_error() take ownership
>>   migration: Introduce migrate_has_error()
>>   migration: Refactor error handling in source return path
>>   migration: Deliver return path file error to migrate state too
>>   qemufile: Always return a verbose error
>>   migration: Provide explicit error message for file shutdowns
>>
>>  qapi/migration.json      |   5 +-
>>  migration/migration.h    |   8 +-
>>  migration/ram.h          |   5 +-
>>  migration/channel.c      |   1 -
>>  migration/migration.c    | 168 +++++++++++++++++++++++----------------
>>  migration/multifd.c      |  10 +--
>>  migration/postcopy-ram.c |   1 -
>>  migration/qemu-file.c    |  20 ++++-
>>  migration/ram.c          |  42 +++++-----
>>  migration/trace-events   |   2 +-
>>  10 files changed, 149 insertions(+), 113 deletions(-)
>
> Hi Peter,
>
> Were you aiming at solving any specific bug with this series? I'm seeing
> a bug on master (361d5397355) with the
> /x86_64/migration/postcopy/preempt/recovery/plain test around the areas
> that this series touches.
>
> It happens very rarely and I'm still investigating, but in case you have
> any thoughts:
>
> ====
> It seems there's a race condition between postcopy resume and the return
> path cleanup.
>
> It is possible for open_return_path_on_source() to setup the new
> QEMUFile *before* the cleanup path at source_return_path_thread() has
> had a chance to run, so we end up calling migration_release_dst_files()
> on the new file and ms->rp_state.from_dst_file gets set to NULL again,
> leading to a SIGSEGV at qemu_file_get_error(rp) due to rp being NULL.

I did some more digging and this is indeed what happens. When we pause
on the incoming side, the to_src_file is closed and the source return
path sees an error (EBADFD) which leads to the cleanup (from_dst_file =
NULL). This happens independently and without any synchronization with a
potential concurrent resume operation.

Is there a reason for not closing the return path thread and starting a
new one for resume? The from_dst_file is the only thing being changed
anyway. It would allow us to remove the retry logic along with the
problematic cleanup path and not need another synchronization point
between qmp_migrate() and the return path.

Here's the race (important bit is open_return_path happening before
migration_release_dst_files):

migration                 | qmp                         | return path
--------------------------+-----------------------------+---------------------------------
                            qmp_migrate_pause()
                             shutdown(ms->to_dst_file)
                              f->last_error = -EIO
migrate_detect_error()
 postcopy_pause()
  set_state(PAUSED)
  wait(postcopy_pause_sem)
                            qmp_migrate(resume)
                            migrate_fd_connect()
                             resume = state == PAUSED
                             open_return_path <-- TOO SOON!
                             set_state(RECOVER)
                             post(postcopy_pause_sem)
                                                        (incoming closes to_src_file)
                                                        res = qemu_file_get_error(rp)
                                                        migration_release_dst_files()
                                                        ms->rp_state.from_dst_file = NULL
  post(postcopy_pause_rp_sem)
                                                        postcopy_pause_return_path_thread()
                                                          wait(postcopy_pause_rp_sem)
                                                        rp = ms->rp_state.from_dst_file
                                                        goto retry
                                                        qemu_file_get_error(rp)
                                                        SIGSEGV
-------------------------------------------------------------------------------------------

