Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A149803E69
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 20:33:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAEfx-0002zO-8Z; Mon, 04 Dec 2023 14:32:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rAEfl-0002z9-3M
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 14:32:07 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rAEfi-0004rl-8F
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 14:32:03 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 599B4218F4;
 Mon,  4 Dec 2023 19:31:59 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C58C81398A;
 Mon,  4 Dec 2023 19:31:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jA+vIS4pbmURMgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 04 Dec 2023 19:31:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH V6 05/14] migration: propagate suspended runstate
In-Reply-To: <ZW4LX9FpfTj77TZv@x1n>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-6-git-send-email-steven.sistare@oracle.com>
 <ZWkVbiQNl16hC1LW@x1n> <ea771378-33c4-4d4e-9de2-d39310028d10@oracle.com>
 <ZW4LX9FpfTj77TZv@x1n>
Date: Mon, 04 Dec 2023 16:31:56 -0300
Message-ID: <87r0k1n4r7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Bar: ++++++++++
X-Spam-Score: 10.28
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de; dkim=none;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
 permitted nor denied by domain of farosas@suse.de)
 smtp.mailfrom=farosas@suse.de; 
 dmarc=fail reason="No valid SPF,
 No valid DKIM" header.from=suse.de (policy=none)
X-Rspamd-Queue-Id: 599B4218F4
X-Spamd-Result: default: False [10.28 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_SPAM_SHORT(2.99)[0.995];
 R_SPF_SOFTFAIL(4.60)[~all:c]; RCVD_COUNT_THREE(0.00)[3];
 MX_GOOD(-0.01)[]; NEURAL_SPAM_LONG(3.50)[1.000];
 RCPT_COUNT_SEVEN(0.00)[8]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(2.20)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Dec 01, 2023 at 11:23:33AM -0500, Steven Sistare wrote:
>> >> @@ -109,6 +117,7 @@ static int global_state_post_load(void *opaque, int version_id)
>> >>          return -EINVAL;
>> >>      }
>> >>      s->state = r;
>> >> +    vm_set_suspended(s->vm_was_suspended || r == RUN_STATE_SUSPENDED);
>> > 
>> > IIUC current vm_was_suspended (based on my read of your patch) was not the
>> > same as a boolean representing "whether VM is suspended", but only a
>> > temporary field to remember that for a VM stop request.  To be explicit, I
>> > didn't see this flag set in qemu_system_suspend() in your previous patch.
>> > 
>> > If so, we can already do:
>> > 
>> >   vm_set_suspended(s->vm_was_suspended);
>> > 
>> > Irrelevant of RUN_STATE_SUSPENDED?
>> 
>> We need both terms of the expression.
>> 
>> If the vm *is* suspended (RUN_STATE_SUSPENDED), then vm_was_suspended = false.
>> We call global_state_store prior to vm_stop_force_state, so the incoming
>> side sees s->state = RUN_STATE_SUSPENDED and s->vm_was_suspended = false.
>
> Right.
>
>> However, the runstate is RUN_STATE_INMIGRATE.  When incoming finishes by
>> calling vm_start, we need to restore the suspended state.  Thus in 
>> global_state_post_load, we must set vm_was_suspended = true.
>
> With above, shouldn't global_state_get_runstate() (on dest) fetch SUSPENDED
> already?  Then I think it should call vm_start(SUSPENDED) if to start.
>
> Maybe you're talking about the special case where autostart==false?  We
> used to have this (existing process_incoming_migration_bh()):
>
>     if (!global_state_received() ||
>         global_state_get_runstate() == RUN_STATE_RUNNING) {
>         if (autostart) {
>             vm_start();
>         } else {
>             runstate_set(RUN_STATE_PAUSED);
>         }
>     }
>
> If so maybe I get you, because in the "else" path we do seem to lose the
> SUSPENDED state again, but in that case IMHO we should logically set
> vm_was_suspended only when we "lose" it - we didn't lose it during
> migration, but only until we decided to switch to PAUSED (due to
> autostart==false). IOW, change above to something like:
>
>     state = global_state_get_runstate();
>     if (!global_state_received() || runstate_is_alive(state)) {
>         if (autostart) {
>             vm_start(state);
>         } else {
>             if (runstate_is_suspended(state)) {
>                 /* Remember suspended state before setting system to STOPed */
>                 vm_was_suspended = true;
>             }
>             runstate_set(RUN_STATE_PAUSED);
>         }
>     }
>
> It may or may not have a functional difference even if current patch,
> though.  However maybe clearer to follow vm_was_suspended's strict
> definition.
>
>> 
>> If the vm *was* suspended, but is currently stopped (eg RUN_STATE_PAUSED),
>> then vm_was_suspended = true.  Migration from that state sets
>> vm_was_suspended = s->vm_was_suspended = true in global_state_post_load and 
>> ends with runstate_set(RUN_STATE_PAUSED).
>> 
>> I will add a comment here in the code.
>>  
>> >>      return 0;
>> >>  }
>> >> @@ -134,6 +143,7 @@ static const VMStateDescription vmstate_globalstate = {
>> >>      .fields = (VMStateField[]) {
>> >>          VMSTATE_UINT32(size, GlobalState),
>> >>          VMSTATE_BUFFER(runstate, GlobalState),
>> >> +        VMSTATE_BOOL(vm_was_suspended, GlobalState),
>> >>          VMSTATE_END_OF_LIST()
>> >>      },
>> >>  };
>> > 
>> > I think this will break migration between old/new, unfortunately.  And
>> > since the global state exist mostly for every VM, all VM setup should be
>> > affected, and over all archs.
>> 
>> Thanks, I keep forgetting that my binary tricks are no good here.  However,
>> I have one other trick up my sleeve, which is to store vm_was_running in
>> global_state.runstate[strlen(runstate) + 2].  It is forwards and backwards
>> compatible, since that byte is always 0 in older qemu.  It can be implemented
>> with a few lines of code change confined to global_state.c, versus many lines 
>> spread across files to do it the conventional way using a compat property and
>> a subsection.  Sound OK?  
>
> Tricky!  But sounds okay to me.  I think you're inventing some of your own
> way of being compatible, not relying on machine type as a benefit.  If go
> this route please document clearly on the layout and also what it looked
> like in old binaries.
>
> I think maybe it'll be good to keep using strings, so in the new binaries
> we allow >1 strings, then we define properly on those strings (index 0:
> runstate, existed since start; index 2: suspended, perhaps using "1"/"0" to
> express, while 0x00 means old binary, etc.).
>
> I hope this trick will need less code than the subsection solution,
> otherwise I'd still consider going with that, which is the "common
> solution".
>
> Let's also see whether Juan/Fabiano/others has any opinions.

Can't we pack the structure and just go ahead and slash 'runstate' in
half? That would claim some unused bytes for future backward
compatibility issues.

