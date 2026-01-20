Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
Delivered-To: lists+qemu-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 688AMovPb2kTMwAAu9opvQ
	(envelope-from <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>)
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 19:55:07 +0100
X-Original-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8D749DCC
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 19:55:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGs2-0005CW-OM; Tue, 20 Jan 2026 13:54:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1viGry-0005B7-Mg
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:54:26 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1viGrw-0008N1-Vb
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:54:26 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 311F45BCC9;
 Tue, 20 Jan 2026 18:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768935263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zHyr4gg040iZBR6fmFVgGACWVxI3UiejJgX8J6l61S4=;
 b=Acz368kUqv+19nyYJxq8tDyvDQB2a8iqQMvZQsWTfqW6Fkq/PLv40TO4hvIrTfoGceV/v9
 KpQkzL9g1vcMMJ+CLENsMWr6hiepdDF9BWucPrRZKErByNEqzDy95wHeKSGQV4ZRCR1RCo
 plhmDYc3xT2EYgBYUszfK1TbXXNe5y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768935263;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zHyr4gg040iZBR6fmFVgGACWVxI3UiejJgX8J6l61S4=;
 b=of/fGI0rlUHfwYBZZ+dsM5pm0IM6L0lucTEDlxP94BTnG8q0IVgehAgesmj2gh3cD4ZjkM
 HIABDT13B7WlzIAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768935263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zHyr4gg040iZBR6fmFVgGACWVxI3UiejJgX8J6l61S4=;
 b=Acz368kUqv+19nyYJxq8tDyvDQB2a8iqQMvZQsWTfqW6Fkq/PLv40TO4hvIrTfoGceV/v9
 KpQkzL9g1vcMMJ+CLENsMWr6hiepdDF9BWucPrRZKErByNEqzDy95wHeKSGQV4ZRCR1RCo
 plhmDYc3xT2EYgBYUszfK1TbXXNe5y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768935263;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zHyr4gg040iZBR6fmFVgGACWVxI3UiejJgX8J6l61S4=;
 b=of/fGI0rlUHfwYBZZ+dsM5pm0IM6L0lucTEDlxP94BTnG8q0IVgehAgesmj2gh3cD4ZjkM
 HIABDT13B7WlzIAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9612E3EA63;
 Tue, 20 Jan 2026 18:54:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id S//hFF7Pb2k2ZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Jan 2026 18:54:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>, Hailiang
 Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, =?utf-8?Q?Daniel_P_=2E?=
 =?utf-8?Q?_Berrang=C3=A9?=
 <berrange@redhat.com>, Zhang Chen <zhangckid@gmail.com>, "Dr . David Alan
 Gilbert" <dave@treblig.org>, Prasad Pandit <ppandit@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 08/13] migration: Thread-ify precopy vmstate load process
In-Reply-To: <aW-v9YKkDO5bRKBQ@x1.local>
References: <20251022192612.2737648-1-peterx@redhat.com>
 <20251022192612.2737648-9-peterx@redhat.com> <87y0m7df46.fsf@suse.de>
 <aWUYVvFVbhXCdVod@x1.local> <871pju1wlv.fsf@suse.de>
 <aWVim4LDYb4gMQLk@x1.local> <87fr89psu5.fsf@suse.de>
 <aWZ3q3NBBCl5KTYr@x1.local> <87jyxhmdp6.fsf@suse.de>
 <aW-v9YKkDO5bRKBQ@x1.local>
Date: Tue, 20 Jan 2026 15:54:19 -0300
Message-ID: <87cy34ktd0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -4.30
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
X-Spamd-Result: default: False [-0.71 / 15.00];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.51.188.0/24:c];
	MAILLIST(-0.20)[mailman];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[lists,qemu-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nongnu.org,fujitsu.com,xfusion.com,redhat.com,yandex-team.ru,gmail.com,treblig.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[farosas@suse.de,qemu-devel-bounces@nongnu.org];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:peterx@redhat.com,m:qemu-devel@nongnu.org,m:lizhijian@fujitsu.com,m:zhanghailiang@xfusion.com,m:kwolf@redhat.com,m:vsementsov@yandex-team.ru,m:berrange@redhat.com,m:zhangckid@gmail.com,m:dave@treblig.org,m:ppandit@redhat.com,m:pbonzini@redhat.com,m:yury-kotov@yandex-team.ru,m:jmarcin@redhat.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[qemu-devel@nongnu.org];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[farosas@suse.de,qemu-devel-bounces@nongnu.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[qemu-devel];
	ASN(0.00)[asn:22989, ipnet:209.51.188.0/24, country:US];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,lists.gnu.org:rdns,lists.gnu.org:helo]
X-Rspamd-Queue-Id: 5E8D749DCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Peter Xu <peterx@redhat.com> writes:

> On Fri, Jan 16, 2026 at 06:48:21PM -0300, Fabiano Rosas wrote:
>> Another one for the pile:
>> 
>> #5  0x00007f0beda4fb32 in __assert_fail (assertion=0x55b8c3ed8cb8 "mode >= 0 ...) at assert.c:103
>> #6  0x000055b8c3a1d7a9 in migrate_mode () at ../migration/options.c:882
>> #7  0x000055b8c3a1084e in fill_source_migration_info (info=0x55b8f1291650) at ../migration/migration.c:1322
>> #8  0x000055b8c3a10cae in qmp_query_migrate (errp=0x7fff5742ae80) at ../migration/migration.c:1438
>> #9  0x000055b8c3d4bc2a in qmp_marshal_query_migrate (args=0x55b8f11f2280, ret=0x7f0becd25da8, errp=0x7f0becd25da0) at qapi/qapi-commands-migration.c:48
>> #10 0x000055b8c3d9a13b in do_qmp_dispatch_bh (opaque=0x7f0becd25e40) at ../qapi/qmp-dispatch.c:128
>> #11 0x000055b8c3dc6366 in aio_bh_call (bh=0x55b8f12922d0) at ../util/async.c:173
>> #12 0x000055b8c3dc6482 in aio_bh_poll (ctx=0x55b8f10741e0) at ../util/async.c:220
>> #13 0x000055b8c3da9832 in aio_poll (ctx=0x55b8f10741e0, blocking=false) at ../util/aio-posix.c:719
>> #14 0x000055b8c3cea017 in monitor_cleanup () at ../monitor/monitor.c:676
>> #15 0x000055b8c39ef646 in qemu_cleanup (status=0) at ../system/runstate.c:999
>> #16 0x000055b8c3cec38e in qemu_default_main (opaque=0x0) at ../system/main.c:51
>> #17 0x000055b8c3cec430 in main (argc=33, argv=0x7fff5742b208) at
>> #../system/main.c:93
>> 
>> (gdb) p/x mode
>> $8 = 0xcccccccc
>
> What's the reproducer?  Is it easy to reproduce?
>

Just hammering some make check instances in parallel, as usual.

> I wonder if current_migration released already, or if monitor should still
> process any QMP handler if the VM is shutting down..
>

monitor_cleanup says it will continue dispatching and just never send a
response to the command. It seems migration will need it's own way of
tracking this.

Maybe as a first step we could clear current_migration at
migration_instance_finalize().
(I see device-introspect-test doesn't like it. I'll look into it)

> Is this only happening after this series applied?  I can't yet see how the
> threadify affected it..

No, sorry, I posted here because I think this affects this series'
assumptions about the BQL.

