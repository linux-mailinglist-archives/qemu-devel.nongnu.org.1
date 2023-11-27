Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C95327FAB9E
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:33:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7iHl-00057x-6V; Mon, 27 Nov 2023 15:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iHk-00057X-1t
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:32:52 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iHi-0004L4-Hu
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:32:51 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AB52A1F898;
 Mon, 27 Nov 2023 20:32:48 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 376611379A;
 Mon, 27 Nov 2023 20:32:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sSVnAPD8ZGUUIwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Nov 2023 20:32:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Leonardo
 Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 5/7] tests/qtest/migration: Print migration incoming
 errors
In-Reply-To: <ZWT6pCri-NmPy3Bt@x1n>
References: <ZWSswkonmoz2ryQu@x1n> <87ttp72ny1.fsf@suse.de>
 <ZWT6pCri-NmPy3Bt@x1n>
Date: Mon, 27 Nov 2023 17:32:45 -0300
Message-ID: <87r0kb2az6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Bar: ++++++++
Authentication-Results: smtp-out2.suse.de; dkim=none;
 dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de
 (policy=none); 
 spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
 permitted nor denied by domain of farosas@suse.de)
 smtp.mailfrom=farosas@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [8.11 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.84)[85.26%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 R_SPF_SOFTFAIL(4.60)[~all:c]; RCVD_COUNT_THREE(0.00)[3];
 MX_GOOD(-0.01)[]; NEURAL_SPAM_LONG(2.15)[0.616];
 RCPT_COUNT_SEVEN(0.00)[7]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(2.20)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Score: 8.11
X-Rspamd-Queue-Id: AB52A1F898
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

> On Mon, Nov 27, 2023 at 12:52:38PM -0300, Fabiano Rosas wrote:
>> >> @@ -118,6 +118,12 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
>> >>  
>> >>      rsp = qtest_qmp(to, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
>> >>                      args);
>> >> +
>> >> +    if (!qdict_haskey(rsp, "return")) {
>> >> +        g_autoptr(GString) s = qobject_to_json_pretty(QOBJECT(rsp), true);
>> >> +        g_test_message("%s", s->str);
>> >> +    }
>> >
>> > This traps the "migrate-incoming" command only (which, afaiu, only setup
>> > the listening), would this capture the incoming error?
>> 
>> This is about the migrate-incoming only. We could replace "incoming
>> migration" with "qmp_migrate_incoming" in the commit message to clarify.
>
> Ah.. Did you ever see this failure in any of your runs in these tests?  I
> think it means you hit the assertion right below this part, but I'm just
> curious how, as the URIs in the test cases are pretty constant.

Yes, I don't remember what exactly, but we changed the code that parses
the URIs in this release and I'm also working on
file_start_incoming_migration.

