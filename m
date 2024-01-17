Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C65830C83
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 19:13:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQAPs-0004Cr-Bc; Wed, 17 Jan 2024 13:13:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQAPp-0004B4-7c
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 13:13:29 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQAPm-00049P-LD
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 13:13:28 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6666F21DD9;
 Wed, 17 Jan 2024 18:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705515204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vmqgTqNR8A32i7MPicwh+u6XAwS5pM8q1oVr6IeqExY=;
 b=G+kZBQD6asF6coJuHct3fH4rWjBGj9V8yq0wFkBurNLJeyLEKkpF4YJNcPdohBB4CJ+PsK
 m+AO7f6iMNSu9cUnmY0sgBZhqKE4vbKWQvSJKRJjQ3C9QWNR62k5LCGT+W3uOmxXqr0yeK
 7nS5pYHgeEBYpvlFvjeeu9Uv889SFLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705515204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vmqgTqNR8A32i7MPicwh+u6XAwS5pM8q1oVr6IeqExY=;
 b=pftk7EMFBM3zZp2ldx1NP+K4rGhPMfuTwMyFsgn+AnTnckZFRtzL4V6FgFii6JfzeTaLx6
 ecV5AHiRC0Bc3RAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705515204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vmqgTqNR8A32i7MPicwh+u6XAwS5pM8q1oVr6IeqExY=;
 b=G+kZBQD6asF6coJuHct3fH4rWjBGj9V8yq0wFkBurNLJeyLEKkpF4YJNcPdohBB4CJ+PsK
 m+AO7f6iMNSu9cUnmY0sgBZhqKE4vbKWQvSJKRJjQ3C9QWNR62k5LCGT+W3uOmxXqr0yeK
 7nS5pYHgeEBYpvlFvjeeu9Uv889SFLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705515204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vmqgTqNR8A32i7MPicwh+u6XAwS5pM8q1oVr6IeqExY=;
 b=pftk7EMFBM3zZp2ldx1NP+K4rGhPMfuTwMyFsgn+AnTnckZFRtzL4V6FgFii6JfzeTaLx6
 ecV5AHiRC0Bc3RAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB72813751;
 Wed, 17 Jan 2024 18:13:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ux7PJ8MYqGU0TQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Jan 2024 18:13:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Juan
 Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 19/30] migration/ram: Ignore multifd flush when
 doing fixed-ram migration
In-Reply-To: <ZaY9Bl4GOD9BbumD@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-20-farosas@suse.de> <ZaY9Bl4GOD9BbumD@x1n>
Date: Wed, 17 Jan 2024 15:13:20 -0300
Message-ID: <87a5p3de0v.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.19)[-0.949]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

> On Mon, Nov 27, 2023 at 05:26:01PM -0300, Fabiano Rosas wrote:
>> Some functionalities of multifd are incompatible with the 'fixed-ram'
>> migration format.
>> 
>> The MULTIFD_FLUSH flag in particular is not used because in fixed-ram
>> there is no sinchronicity between migration source and destination so
>> there is not need for a sync packet. In fact, fixed-ram disables
>> packets in multifd as a whole.
>> 
>> However, we still need to sync the migration thread with the multifd
>> channels at key moments:
>> 
>> - between iterations, to avoid a slow channel being overrun by a fast
>> channel in the subsequent iteration;
>> 
>> - at ram_save_complete, to make sure all data has been transferred
>>   before finishing migration;
>
> [1]
>
>> 
>> Make sure RAM_SAVE_FLAG_MULTIFD_FLUSH is only emitted for fixed-ram at
>> those key moments.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/ram.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 08604222f2..ad6abd1761 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1363,7 +1363,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
>>          pss->page = 0;
>>          pss->block = QLIST_NEXT_RCU(pss->block, next);
>>          if (!pss->block) {
>> -            if (migrate_multifd() &&
>> +            if (migrate_multifd() && !migrate_fixed_ram() &&
>>                  !migrate_multifd_flush_after_each_section()) {
>>                  QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
>>                  int ret = multifd_send_sync_main(f);
>> @@ -3112,7 +3112,8 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>>          return ret;
>>      }
>>  
>> -    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
>> +    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()
>> +        && !migrate_fixed_ram()) {
>>          qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
>>      }
>>  
>> @@ -3242,8 +3243,11 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>>  out:
>>      if (ret >= 0
>>          && migration_is_setup_or_active(migrate_get_current()->state)) {
>> -        if (migrate_multifd() && migrate_multifd_flush_after_each_section()) {
>> -            ret = multifd_send_sync_main(rs->pss[RAM_CHANNEL_PRECOPY].pss_channel);
>> +        if (migrate_multifd() &&
>> +            (migrate_multifd_flush_after_each_section() ||
>> +             migrate_fixed_ram())) {
>> +            ret = multifd_send_sync_main(
>> +                rs->pss[RAM_CHANNEL_PRECOPY].pss_channel);
>
> Why you want this one?  ram_save_iterate() can be called tens for each
> second iiuc.
>

AIUI, this is a requirement for live migration, so that we're not
sending the new version of the page while the old version is still in
transit.

> There's one more?  ram_save_complete():
>
>     if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
>         qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
>     }
>
> IIUC that's the one you referred to at [1] above, not sure why you modified
> the code in ram_save_iterate() instead.
>

I mentioned it in the commit message as well:

" - between iterations, to avoid a slow channel being overrun by a fast
 channel in the subsequent iteration;"

>>              if (ret < 0) {
>>                  return ret;
>>              }
>> -- 
>> 2.35.3
>> 
>
> Since the file migration added its whole new code in
> multifd_send_sync_main(), now I'm hesitating whether we should just provide
> multifd_file_sync_threads(), put file sync there, and call explicitly,
> like:
>
>   if (migrate_multifd()) {
>     if (migrate_is_file()) {
>        multifd_file_sync_threads();
>     } else if (migrate_multifd_flush_after_each_section()) {
>        multifd_send_sync_main();
>     }
>   }
>
> It'll be much clearer that file goes into its own path and we don't need to
> worry on fat eyes of those if clauses.  diff should be similar.

Hm, it could be a good idea indeed. Let me experiment with it.

