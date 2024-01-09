Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC36828A76
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 17:51:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNFJ4-0004NI-9w; Tue, 09 Jan 2024 11:50:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rNFJ1-0004KA-Gf
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 11:50:23 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rNFIz-0000fX-Fd
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 11:50:23 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9603F22198;
 Tue,  9 Jan 2024 16:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704819018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4IiljVF0FBTn1q8AaBwB1XicmuJxJ0XNVgR4AN0bHm4=;
 b=JZ4Jk9yOLu8axl0sazHYe2QLWKqhHOBHN8NgFeZvCxr9+bJYnJb7l4vWOVZrgMxZcJ+/Kd
 dS+NsPgs/41jMQTpukajOiN4m/9IMVgr52St9CDwR0U51PPpAOxjfObqh4Me1Y1ioTHPx7
 cO+13CMJFhPLBM+7xr05OqaNRSSuUOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704819018;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4IiljVF0FBTn1q8AaBwB1XicmuJxJ0XNVgR4AN0bHm4=;
 b=2V/kBnCI73Bu1H9di7fJUU18swAkSWo9wj4yCY6KLV2s7wM8LojyZKWLG8icUGK1Gh/OQR
 rsDI6GaruCuJEPBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704819018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4IiljVF0FBTn1q8AaBwB1XicmuJxJ0XNVgR4AN0bHm4=;
 b=JZ4Jk9yOLu8axl0sazHYe2QLWKqhHOBHN8NgFeZvCxr9+bJYnJb7l4vWOVZrgMxZcJ+/Kd
 dS+NsPgs/41jMQTpukajOiN4m/9IMVgr52St9CDwR0U51PPpAOxjfObqh4Me1Y1ioTHPx7
 cO+13CMJFhPLBM+7xr05OqaNRSSuUOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704819018;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4IiljVF0FBTn1q8AaBwB1XicmuJxJ0XNVgR4AN0bHm4=;
 b=2V/kBnCI73Bu1H9di7fJUU18swAkSWo9wj4yCY6KLV2s7wM8LojyZKWLG8icUGK1Gh/OQR
 rsDI6GaruCuJEPBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22386134E8;
 Tue,  9 Jan 2024 16:50:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rgmaNkl5nWUJDAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 09 Jan 2024 16:50:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v3 2/4] tests/qtest/migration: Add infrastructure to
 skip tests on older QEMUs
In-Reply-To: <ZZyuzqbL5oaUVGhj@x1n>
References: <20240105180449.11562-1-farosas@suse.de>
 <20240105180449.11562-3-farosas@suse.de> <ZZuulnlKscT1ULS7@x1n>
 <87a5pf3mnq.fsf@suse.de> <ZZyuzqbL5oaUVGhj@x1n>
Date: Tue, 09 Jan 2024 13:50:15 -0300
Message-ID: <87v88278oo.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9603F22198
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JZ4Jk9yO;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="2V/kBnCI"
X-Spam-Score: -3.52
X-Spamd-Result: default: False [-3.52 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-0.01)[47.99%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
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

> On Mon, Jan 08, 2024 at 11:49:45AM -0300, Fabiano Rosas wrote:
>> >> +
>> >> +    if (major > tgt_major) {
>> >> +        return -1;
>> >
>> > This means the QEMU version is newer, the function will return negative.
>> > Is this what we want?  It seems it's inverted.
>> 
>> The return "points" to which once is the more recent:
>> 
>> QEMU version | since: version
>> -1           0         1
>
> Here if returns -1, then below [1] will skip the test?
>

Ah ok, code below is wrong.

>> 
>> > In all cases, document this function with retval would be helpful too.
>> >
>> 
>> Ok.
>> 
>> >> +    }
>> >> +    if (major < tgt_major) {
>> >> +        return 1;
>> >> +    }
>> >
>> > Instead of all these, I'm wondering whether we can allow "since" to be an
>> > array of integers, like [8, 2, 0].  Would that be much easier?
>> 
>> I don't see why push the complexity towards the person writing the
>> tests. The string is much more natural to specify.
>
> To me QEMU_VER(8,2,0) is as easy to write and read, too.  What Dan proposed
> looks also good in the other thread.
>
> I don't really have a strong opinion here especially for the test case. But
> imho it'll be still nice to avoid string <-> int if the string is not required.

Ok, I'll change it to something else.

>
> [...]
>
>> >> @@ -850,6 +856,17 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>> >>          qtest_qmp_set_event_callback(*from,
>> >>                                       migrate_watch_for_stop,
>> >>                                       &got_src_stop);
>> >> +
>> >> +        if (args->since && migration_vercmp(*from, args->since) < 0) {
>
> [1]
>
>> >> +            g_autofree char *msg = NULL;
>> >> +
>> >> +            msg = g_strdup_printf("Test requires at least QEMU version %s",
>> >> +                                  args->since);
>> >> +            g_test_skip(msg);
>> >> +            qtest_quit(*from);
>> >> +
>> >> +            return -1;
>> >> +        }

