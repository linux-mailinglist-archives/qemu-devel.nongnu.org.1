Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6677FA54D
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 16:53:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7dul-0005rX-Tl; Mon, 27 Nov 2023 10:52:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7due-0005q8-S0
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 10:52:45 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7dud-0007ee-8n
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 10:52:44 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3E0FA21B89;
 Mon, 27 Nov 2023 15:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701100361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:  in-reply-to:in-reply-to; 
 bh=ZllqXhCAmZoGIb+lXioK3cFiY+0JNGGALx8aIJbiTrI=;
 b=vvGIB5kHSJy5t2js7Izv8gmVukvH3MMDGdNYljqLSEkShzpwJVWGIG0V7vD833+CIX/Fyo
 2GMQEXi6TcgGxQWLcAeHrgOnFYfyohAoyz2vLp/6TTaHg0vb3KpK/nRMvormZ0EIyhF9YK
 tV5yaKbAMZOee8ZBnA6eDze1TiuF0+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701100361;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:  in-reply-to:in-reply-to; 
 bh=ZllqXhCAmZoGIb+lXioK3cFiY+0JNGGALx8aIJbiTrI=;
 b=Y8u7mCmT8jeTYAEYNwU5RWTEwlLEWyxUnOwU1sDB7d6e+kCPnJBmun7+jtDNBoPMbfYGP5
 ELoBNJUrQd70bwCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF1301379A;
 Mon, 27 Nov 2023 15:52:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id t/M0IUi7ZGWRTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Nov 2023 15:52:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Leonardo
 Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 5/7] tests/qtest/migration: Print migration incoming
 errors
In-Reply-To: <ZWSswkonmoz2ryQu@x1n>
Date: Mon, 27 Nov 2023 12:52:38 -0300
Message-ID: <87ttp72ny1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -3.10
X-Spamd-Result: default: False [-3.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[99.98%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Fri, Nov 24, 2023 at 01:14:30PM -0300, Fabiano Rosas wrote:
>> We're currently just asserting when incoming migration fails. Let's
>> print the error message from QMP as well.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/migration-helpers.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>> index 24fb7b3525..f1106128a9 100644
>> --- a/tests/qtest/migration-helpers.c
>> +++ b/tests/qtest/migration-helpers.c
>> @@ -118,6 +118,12 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
>>  
>>      rsp = qtest_qmp(to, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
>>                      args);
>> +
>> +    if (!qdict_haskey(rsp, "return")) {
>> +        g_autoptr(GString) s = qobject_to_json_pretty(QOBJECT(rsp), true);
>> +        g_test_message("%s", s->str);
>> +    }
>
> This traps the "migrate-incoming" command only (which, afaiu, only setup
> the listening), would this capture the incoming error?

This is about the migrate-incoming only. We could replace "incoming
migration" with "qmp_migrate_incoming" in the commit message to clarify.

