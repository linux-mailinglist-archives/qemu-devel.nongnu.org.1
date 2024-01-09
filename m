Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8076828875
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 15:48:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNDNO-00042r-7c; Tue, 09 Jan 2024 09:46:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rNDNL-00040u-Bj
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:46:43 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rNDNI-0001V3-MF
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:46:43 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0702F22089;
 Tue,  9 Jan 2024 14:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704811596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hxWtnbld3fTKNzynoG8nzywBlcft9xxV6leutRJaXx0=;
 b=GkOIUooGuu2MHWd7O5yxtXMwDAqzw4jAokI+n+ocR8mW5pQDetJnHfSztvuAi5hAOpZ49r
 m6splKviKESYzETpfUPwsf/L2enYTlpHViLBcYbx+iBxhvaEb/iTYXasneU2Xubfk/yzkE
 yoxzvPWkvFv3GBoEwoVRwSCb1EW1lak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704811596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hxWtnbld3fTKNzynoG8nzywBlcft9xxV6leutRJaXx0=;
 b=5PAi9dPlRoQH+ot53iGbLqegoPvEwPsO+O8uMAAeWFH+cHPjIUuUvic4WqynqrivDDhYJc
 EbKaValb5mK6vPAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704811596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hxWtnbld3fTKNzynoG8nzywBlcft9xxV6leutRJaXx0=;
 b=GkOIUooGuu2MHWd7O5yxtXMwDAqzw4jAokI+n+ocR8mW5pQDetJnHfSztvuAi5hAOpZ49r
 m6splKviKESYzETpfUPwsf/L2enYTlpHViLBcYbx+iBxhvaEb/iTYXasneU2Xubfk/yzkE
 yoxzvPWkvFv3GBoEwoVRwSCb1EW1lak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704811596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hxWtnbld3fTKNzynoG8nzywBlcft9xxV6leutRJaXx0=;
 b=5PAi9dPlRoQH+ot53iGbLqegoPvEwPsO+O8uMAAeWFH+cHPjIUuUvic4WqynqrivDDhYJc
 EbKaValb5mK6vPAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80B31134E8;
 Tue,  9 Jan 2024 14:46:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bYmVEUtcnWX/IAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 09 Jan 2024 14:46:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v3 4/4] [NOT FOR MERGE] tests/qtest/migration: Adapt
 tests to use older QEMUs
In-Reply-To: <ZZzC1n0GotQZukqJ@x1n>
References: <20240105180449.11562-1-farosas@suse.de>
 <20240105180449.11562-5-farosas@suse.de> <ZZuvDREDrQ07HsGs@x1n>
 <877ckj3kfp.fsf@suse.de> <ZZzC1n0GotQZukqJ@x1n>
Date: Tue, 09 Jan 2024 11:46:32 -0300
Message-ID: <87zfxe7eev.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0702F22089
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GkOIUooG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5PAi9dPl
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-4.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
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

> On Mon, Jan 08, 2024 at 12:37:46PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Fri, Jan 05, 2024 at 03:04:49PM -0300, Fabiano Rosas wrote:
>> >> [This patch is not necessary anymore after 8.2 has been released]
>> >> 
>> >> Add the 'since' annotations to recently added tests and adapt the
>> >> postcopy test to use the older "uri" API when needed.
>> >> 
>> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >
>> > You marked this as not-for-merge.  Would something like this still be
>> > useful in the future?  IIUC it's a matter of whether we'd still want to
>> > test those old binaries.
>> >
>> 
>> Technically yes, but I fail to see what benefit testing old binaries
>> would bring us. I'm thinking maybe it could be useful for bisecting
>> compatibility issues, but I can't think of a scenario where we'd like to
>> change the older QEMU instead of the newer.
>> 
>> I'm of course open to suggestions if you or anyone else has an use case
>> that you'd like to keep viable.
>> 
>> So far, my idea is that once a new QEMU is released, all the "since:"
>> annotations become obsolete. We could even remove them. This series is
>> just infrastructure to make our life easier if a change is ever
>> introduced that is incompatible with the n-1 QEMU. IMO we cannot have
>> compatibility testing if a random change might break a test and make it
>> more difficult to run the remaining tests. So we'd use 'since' or the
>> vercmp function to skip/adapt the offending tests until the next QEMU is
>> released.
>> 
>> I'm basing myself on this loosely worded support statement from our
>> docs:
>> 
>>   "In general QEMU tries to maintain forward migration compatibility
>>   (i.e. migrating from QEMU n->n+1) and there are users who benefit from
>>   backward compatibility as well."
>
> I think we could still have users migrating from e.g. 8.0 -> 9.0 as long as
> with the same machine type, especially when upgrading upper level stack
> (e.g. an openstack cluster upgrade), where IIUC can jump a few qemu major
> versions.  That does sound like a common use case, and I suspect the doc
> was only taking one example on why compatibility needs to be maintained,
> rather than emphasizing "+1 only".

Oh, I would expect people to be migrating in all sorts of ways. But we
need to think in terms of what upstream QEMU supports so we can guide
the development. And hopefully have a test for everything we actually
support and everyone that touches migration code having the same view on
this.

I can barely think about n->n+1 to be honest, that's why I was writing
this compatibility test even before Juan asked for it.

You raise a good point about a cloud provider or distro jumping major
versions. That's a tricky situation. Because then their support
statement would potentially cover something that's completely different
from what we're testing upstream.

> However then the question is whether those old binaries needs to be
> convered.
>
> Then I noticed that taking all these "since: XXX" and cmdline changes along
> with migration-test may be yet another burden even if we want to cover old
> binaries for whatever reason.  I am now more convinced myself that we
> should try to get rid of as much burden as we can for migration, because we
> already have enough, and it's not ideal to keep growing that unnecessarily.
>
> One good thing with CI in this case (I still don't have enough knowledge on
> CI, so I am hoping some CI people can review that patch, though) is that if
> we can always guarantee n-1 -> n works for the test cases we enabled, it
> most probably means when n boosts again to n+1, we keep making sure n ->
> n+1 works perfectly, then n-1 -> n+1 should not fail either, considering
> that we're testing the stream protocol matching each other.  There might be
> outliers (especially if not described with VMSDs) but should be corner
> cases.

I agree that the transitivity should be preserved. If we could override
the QEMU_PREV_VERSION variable in the CI script, that would be an easy
way of running a sanity check every once in a while.

> So I tend to agree with you on that we drop this patch, keep it simple
> until we're much more clear what we can get from that.
>
> But then if so - do we need "since" at all to be expressed in versions?

I agree that we don't need "since" semantics.

> Basically we keep qtest always be valid only on the latest qemu binary as
> before (which actually works the same as Linux v.s. kselftests, which makes
> sense), there's one exception now with "n-1" due to the CI we plan to add.
> Dropping this patch means we don't yet plan to support n-2.  Then maybe
> instead of a "since" we only need a boolean showing "whether one test needs
> to be covered by a cross-binary test"?  Then we set it in incompatible
> binaries (skip all cross-binary tests directly, rather than relying on any
> qemu versions, no compare needed), and can also drop that when a new
> release starts.

Hm, it would be better to avoid the extra maintenance task at the start
of every release, no? It also blocks us from doing n-2 even
experimentally.

