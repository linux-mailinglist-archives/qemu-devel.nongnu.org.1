Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC786743E11
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 16:58:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFFZQ-0005HQ-3R; Fri, 30 Jun 2023 10:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qFFZL-0005Gy-8v
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 10:57:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qFFZJ-0003d4-Pp
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 10:57:55 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9B8471F854;
 Fri, 30 Jun 2023 14:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688137072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AdOc+lF7f776xjtCjYQfpxcD5d8ygrZ39pm6rYfcFvM=;
 b=Lbc4hTz0DKZcEBf4knNr7ytiArrsm99GC+2RpORoOhs6Ks9NBvQqf58r+awyDpnVpI5vmV
 kF2x9WLw0hmXtCsQU0GJCheqMb9zEdbuFQXWQGFqFIHvGl8NhMkZ5SC3UYkm6dKwVYcc9z
 emDClVfvaLhP6lCD1PNUAx2TcpDsS2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688137072;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AdOc+lF7f776xjtCjYQfpxcD5d8ygrZ39pm6rYfcFvM=;
 b=OvoehqJspF7VpFXrOtGAoyFXEHxtqQvzNYwHyGw4TuEzz39mqyS8fPrGfFUgGYcVAg8HBJ
 WaGMht860bm1htBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2ACD013915;
 Fri, 30 Jun 2023 14:57:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Tb1vOW/tnmTaDwAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 30 Jun 2023 14:57:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Steve
 Sistare <steven.sistare@oracle.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/6] tests/qtest: migration: Add migrate_incoming_qmp
 helper
In-Reply-To: <ZJ30tJ+3umGH2Xto@x1n>
References: <20230628165542.17214-1-farosas@suse.de>
 <20230628165542.17214-4-farosas@suse.de> <ZJ30tJ+3umGH2Xto@x1n>
Date: Fri, 30 Jun 2023 11:57:49 -0300
Message-ID: <877crlq9oy.fsf@suse.de>
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

> On Wed, Jun 28, 2023 at 01:55:39PM -0300, Fabiano Rosas wrote:
>> file-based migration requires the target to initiate its migration after
>> the source has finished writing out the data in the file. Currently
>> there's no easy way to initiate 'migrate-incoming', allow this by
>> introducing migrate_incoming_qmp helper, similarly to migrate_qmp.
>> 
>> Also make sure migration events are enabled and wait for the incoming
>> migration to start before returning. This avoid a race when querying
>> the migration status too soon after issuing the command.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/migration-helpers.c | 28 ++++++++++++++++++++++++++++
>>  tests/qtest/migration-helpers.h |  4 ++++
>>  2 files changed, 32 insertions(+)
>> 
>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>> index 2df198c99e..bc54b29184 100644
>> --- a/tests/qtest/migration-helpers.c
>> +++ b/tests/qtest/migration-helpers.c
>> @@ -81,6 +81,34 @@ void migrate_set_capability(QTestState *who, const char *capability,
>>                               capability, value);
>>  }
>>  
>> +void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
>> +{
>> +    va_list ap;
>> +    QDict *args, *rsp, *data;
>> +
>> +    va_start(ap, fmt);
>> +    args = qdict_from_vjsonf_nofail(fmt, ap);
>> +    va_end(ap);
>> +
>> +    g_assert(!qdict_haskey(args, "uri"));
>> +    qdict_put_str(args, "uri", uri);
>> +
>> +    migrate_set_capability(to, "events", true);
>> +
>> +    rsp = qtest_qmp(to, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
>> +                    args);
>> +    g_assert(qdict_haskey(rsp, "return"));
>
> rsp leaked?
>

Good catch. I'll fix it.

