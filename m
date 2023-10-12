Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA51B7C70C7
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:55:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqx4h-0006PZ-OT; Thu, 12 Oct 2023 10:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqx4X-0006OT-L7
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:53:57 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqx4U-0000F9-SP
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:53:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 905931F8A4;
 Thu, 12 Oct 2023 14:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697122432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yoF7Nc7P4WKuERExi9/S8wZcGBnCoIiJQiCFzkwFkWk=;
 b=ehkft5wv9Jfv7PUMtJNSOGcNrJ232ntqeeA8/3KzWkU4hsiHujJnY21NCYifawki/iJ0J8
 gWKSdZpBItp195woffGwBLay2JB7ANk2IyqrQcfQ88vE5Q0IpHPHldoVm0Sj4XVMsr3DQQ
 A8AqubhD6e9TmC+7YpLcaDd4/JZu+Dc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697122432;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yoF7Nc7P4WKuERExi9/S8wZcGBnCoIiJQiCFzkwFkWk=;
 b=ixWfW+oyUhItX1hYl4nY0kjpSykdXatf5LNc440vEtwHQLKc65INUELQvy4acQTSSS55eB
 C1VfrEA4GEUYcYBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 21DCE139F9;
 Thu, 12 Oct 2023 14:53:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rIWVN38IKGWdIwAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 12 Oct 2023 14:53:51 +0000
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
In-Reply-To: <84d1dbe6-560e-46d1-93c3-0d6243131c2e@redhat.com>
References: <20231006123910.17759-1-farosas@suse.de>
 <20231006123910.17759-4-farosas@suse.de>
 <84d1dbe6-560e-46d1-93c3-0d6243131c2e@redhat.com>
Date: Thu, 12 Oct 2023 11:53:49 -0300
Message-ID: <87sf6fzybm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -4.10
X-Spamd-Result: default: False [-4.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.00)[24.15%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[10];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Thomas Huth <thuth@redhat.com> writes:

> On 06/10/2023 14.39, Fabiano Rosas wrote:
>> We're adding support for using more than one QEMU binary in
>> tests. Modify qtest_get_machines() to take an environment variable
>> that contains the QEMU binary path.
>> 
>> Since the function keeps a cache of the machines list in the form of a
>> static variable, refresh it any time the environment variable changes.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   tests/qtest/libqtest.c | 17 +++++++++++++----
>>   1 file changed, 13 insertions(+), 4 deletions(-)
>> 
>> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
>> index 88b79cb477..47c8b6d46f 100644
>> --- a/tests/qtest/libqtest.c
>> +++ b/tests/qtest/libqtest.c
>> @@ -1441,9 +1441,10 @@ struct MachInfo {
>>    * Returns an array with pointers to the available machine names.
>>    * The terminating entry has the name set to NULL.
>>    */
>> -static struct MachInfo *qtest_get_machines(void)
>> +static struct MachInfo *qtest_get_machines(const char *var)
>>   {
>>       static struct MachInfo *machines;
>> +    static char *qemu_var;
>>       QDict *response, *minfo;
>>       QList *list;
>>       const QListEntry *p;
>> @@ -1452,11 +1453,19 @@ static struct MachInfo *qtest_get_machines(void)
>>       QTestState *qts;
>>       int idx;
>>   
>> +    if (g_strcmp0(qemu_var, var)) {
>> +        qemu_var = g_strdup(var);
>> +
>> +        /* new qemu, clear the cache */
>> +        g_free(machines);
>> +        machines = NULL;
>> +    }
>> +
>>       if (machines) {
>>           return machines;
>>       }
>
> After sleeping on the topic of the string handling in this patch series a 
> little bit  I think it was maybe a bad idea to suggest to remove the 
> g_strdups in the other patches. If you actually clear the cache here, the 
> strings that previously were guaranteed to stay around until the end of the 
> program might now vanish. So instead of returning the pointer to the cache 
> here, it might be better to create a copy of the whole structure here and 
> let the callers decide whether they want to keep it around or free it at the 
> end?

Hm, let me try that out. We could have a 'bool refresh' parameter in the
top level API then, which would be a clearer interface perhaps.

Thanks

