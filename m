Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DFA7CAE6A
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 18:03:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsQ1C-00038F-BK; Mon, 16 Oct 2023 12:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qsQ0w-0002uy-2G
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:00:18 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qsQ0u-0002Rb-0j
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:00:17 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 561F221C76;
 Mon, 16 Oct 2023 16:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697472009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iOuNuUPUMMCtDGHezv7UOdDYWWkdw0wnESMhTVbyIzY=;
 b=1+8am893S/ASCWmZUpmdgnZt/pfY4TFLyXLvBjnWwl/BofrvGS5X81Ba0RzAlF/+/VfkBt
 pFfpoOgYHPtV3nBUUnmIISkwiD6cFLq3ugJ7yIkYbdmLZK3FKMpta92zzfaPEQRHmnxYUP
 8rMhaH8kxZwAYz4p4qxSwflkF8J/rcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697472009;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iOuNuUPUMMCtDGHezv7UOdDYWWkdw0wnESMhTVbyIzY=;
 b=oc2YEaPkH4wzAXBewPdHFIO32RFCL5m9ZZpkBmiL0UD0nXs7sPFhIocQIk+yHsT+EYwBzQ
 iqMf9ORDMKpV6yAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB8A3138EF;
 Mon, 16 Oct 2023 16:00:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6oOhKQheLWXuFAAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 16 Oct 2023 16:00:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 3/9] tests/qtest: Allow qtest_get_machines to use an
 alternate QEMU binary
In-Reply-To: <87sf6fzybm.fsf@suse.de>
References: <20231006123910.17759-1-farosas@suse.de>
 <20231006123910.17759-4-farosas@suse.de>
 <84d1dbe6-560e-46d1-93c3-0d6243131c2e@redhat.com> <87sf6fzybm.fsf@suse.de>
Date: Mon, 16 Oct 2023 13:00:06 -0300
Message-ID: <87cyxeblrt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -0.31
X-Spamd-Result: default: False [-0.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.21)[-0.209]; NEURAL_SPAM_LONG(3.00)[1.000];
 RCPT_COUNT_SEVEN(0.00)[10]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
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

Fabiano Rosas <farosas@suse.de> writes:

> Thomas Huth <thuth@redhat.com> writes:
>
>> On 06/10/2023 14.39, Fabiano Rosas wrote:
>>> We're adding support for using more than one QEMU binary in
>>> tests. Modify qtest_get_machines() to take an environment variable
>>> that contains the QEMU binary path.
>>> 
>>> Since the function keeps a cache of the machines list in the form of a
>>> static variable, refresh it any time the environment variable changes.
>>> 
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> ---
>>>   tests/qtest/libqtest.c | 17 +++++++++++++----
>>>   1 file changed, 13 insertions(+), 4 deletions(-)
>>> 
>>> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
>>> index 88b79cb477..47c8b6d46f 100644
>>> --- a/tests/qtest/libqtest.c
>>> +++ b/tests/qtest/libqtest.c
>>> @@ -1441,9 +1441,10 @@ struct MachInfo {
>>>    * Returns an array with pointers to the available machine names.
>>>    * The terminating entry has the name set to NULL.
>>>    */
>>> -static struct MachInfo *qtest_get_machines(void)
>>> +static struct MachInfo *qtest_get_machines(const char *var)
>>>   {
>>>       static struct MachInfo *machines;
>>> +    static char *qemu_var;
>>>       QDict *response, *minfo;
>>>       QList *list;
>>>       const QListEntry *p;
>>> @@ -1452,11 +1453,19 @@ static struct MachInfo *qtest_get_machines(void)
>>>       QTestState *qts;
>>>       int idx;
>>>   
>>> +    if (g_strcmp0(qemu_var, var)) {
>>> +        qemu_var = g_strdup(var);
>>> +
>>> +        /* new qemu, clear the cache */
>>> +        g_free(machines);
>>> +        machines = NULL;
>>> +    }
>>> +
>>>       if (machines) {
>>>           return machines;
>>>       }
>>
>> After sleeping on the topic of the string handling in this patch series a 
>> little bit  I think it was maybe a bad idea to suggest to remove the 
>> g_strdups in the other patches. If you actually clear the cache here, the 
>> strings that previously were guaranteed to stay around until the end of the 
>> program might now vanish. So instead of returning the pointer to the cache 
>> here, it might be better to create a copy of the whole structure here and 
>> let the callers decide whether they want to keep it around or free it at the 
>> end?
>
> Hm, let me try that out. We could have a 'bool refresh' parameter in the
> top level API then, which would be a clearer interface perhaps.

I'm looking into this right now. I don't think callers ever want to keep
the machines list around. We'd have to cache the list and the binary
name a second time in the callers just to avoid having to copy/free a
few strings.

The caching needs to be centralized at qtest_get_machines(), otherwise
we'd be better off having doing setenv around the function calls, which
is what my hacked first version did.

If you're ok with that I'll just add a cleanup function to free all
strings when clearing the cache and keep strdup'ing where appropriate.


