Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B69805A83
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 17:52:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAYer-0006ll-AZ; Tue, 05 Dec 2023 11:52:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rAYen-0006lE-4A
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 11:52:25 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rAYek-0001t9-VP
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 11:52:24 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8651B1FB9F;
 Tue,  5 Dec 2023 16:52:19 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B48B136CF;
 Tue,  5 Dec 2023 16:52:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id H9H6L0JVb2ViBAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Dec 2023 16:52:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org, Juan
 Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V6 05/14] migration: propagate suspended runstate
In-Reply-To: <ZW9NcwNropqV_7Kz@x1n>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-6-git-send-email-steven.sistare@oracle.com>
 <ZWkVbiQNl16hC1LW@x1n> <ea771378-33c4-4d4e-9de2-d39310028d10@oracle.com>
 <ZW4LX9FpfTj77TZv@x1n> <87r0k1n4r7.fsf@suse.de> <ZW4wTK0dld9pPCtX@x1n>
 <87o7f5n08z.fsf@suse.de> <ZW5M19173nTZTLv1@x1n> <87cyvkn7j7.fsf@suse.de>
 <ZW9NcwNropqV_7Kz@x1n>
Date: Tue, 05 Dec 2023 13:52:16 -0300
Message-ID: <877clsmw1r.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Bar: ++++++
Authentication-Results: smtp-out2.suse.de; dkim=none;
 dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de
 (policy=none); 
 spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
 permitted nor denied by domain of farosas@suse.de)
 smtp.mailfrom=farosas@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [6.75 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_SPAM_SHORT(2.96)[0.986];
 R_SPF_SOFTFAIL(4.60)[~all:c]; RCVD_COUNT_THREE(0.00)[3];
 MX_GOOD(-0.01)[]; RCPT_COUNT_SEVEN(0.00)[8];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Score: 6.75
X-Rspamd-Queue-Id: 8651B1FB9F
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> On Tue, Dec 05, 2023 at 09:44:12AM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Mon, Dec 04, 2023 at 06:09:16PM -0300, Fabiano Rosas wrote:
>> >> Right, I got your point. I just think we could avoid designing this new
>> >> string format by creating new fields with the extra space:
>> >> 
>> >> typedef struct QEMU_PACKED {
>> >>     uint32_t size;
>> >>     uint8_t runstate[50];
>> >>     uint8_t unused[50];
>> >>     RunState state;
>> >>     bool received;
>> >> } GlobalState;
>> >> 
>> >> In my mind this works seamlessly, or am I mistaken?
>> >
>> > I think what you proposed should indeed work.
>> >
>> > Currently it's:
>> >
>> >     .fields = (VMStateField[]) {
>> >         VMSTATE_UINT32(size, GlobalState),
>> >         VMSTATE_BUFFER(runstate, GlobalState),
>> >         VMSTATE_END_OF_LIST()
>> >     },
>> >
>> > I had a quick look at vmstate_info_buffer, it mostly only get()/put() those
>> > buffers with its sizeof(), so looks all fine.  For sure in all cases we'd
>> > better test it to verify.
>> >
>> > One side note is since we so far use qapi_enum_parse() for the runstate, I
>> > think the "size" is not ever used..
>> >
>> > If we do want a split, IMHO we can consider making runstate[] even smaller
>> > to just free up the rest spaces all in one shot:
>> >
>> >   typedef struct QEMU_PACKED {
>
> [1]
>
>> >       uint32_t size;
>> >       /*
>> >        * Assuming 16 is good enough to fit all possible runstate strings..
>> >        * This field must be a string ending with '\0'.
>> >        */
>> >       uint8_t runstate[16];
>> >       /* 0x00 when QEMU doesn't support it, or "0"/"1" to reflect its state */
>> >       uint8_t vm_was_suspended[1];
>> >       /*
>> >        * Still free of use space.  Note that we only have 99 bytes for use
>> >        * because the last byte (the 100th byte) must be zero due to legacy
>> >        * reasons, if not it may be set to zero after loaded on dest QEMU. 
>> >        */
>> 
>> I'd add a 'uint8_t reserved;' to go along with this comment instead of
>> leaving a hole.
>
> Note that "struct GlobalState" is not a binary format but only some
> internal storage, what really matters is vmstate_globalstate.  Here the
> "uint8_reserved" will be a pure waste of 1 byte in QEMU binary, imho.
>

I prefer wasting the byte and make the code more obvious to people who
might not immediately understand what's going on. We could even
assert(!global_state.reserved) to sanity check the assumption. Anyway,
that's minor, I'm fine with it either way.

> I think I just copied what you had previously and extended it, logically I
> don't think we ever need QEMU_PACKED right above [1].  We can also drop
> "size" directly here, but this can be done later.

Ah right, I was initially thinking of letting the new qemu overrun
runstate[16] so we wouldn't have to change the code. But that's indeed
not necessary, your additions to the vmstate make it ok. Thanks.

