Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B92283196A
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:47:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRo3-0001u5-Dl; Thu, 18 Jan 2024 07:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQRnv-0001tb-A4
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:47:32 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQRno-0005pQ-K9
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:47:31 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 48FD5222A5;
 Thu, 18 Jan 2024 12:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705582041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wEdgAqqt4suKo6vMyOCtLIOixa/LZP63T4K5oORwcNg=;
 b=KOsoW0+HEjI3w9oeUEFINk7dxqmgYxZjyIl299dC6bQf6X82YyMWuugW43AkdgtbFqNIev
 8raXFVR5fYVRX/gvxCs0YLX1xfFGsG5kTKbQE6tmnnKIccTFOl6rBkTHiYdmptX2nU5bxw
 iZNh7ZFESWlHKYQEeIzkgHV36CwDhLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705582041;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wEdgAqqt4suKo6vMyOCtLIOixa/LZP63T4K5oORwcNg=;
 b=ajAx6LkV2rUnUNEkC5d1qM6olhMoZ1N3ZP6sILPAFaNrgYh0/gNP8Cjq2wSyt6i0jVChpc
 gGpM60NKzKTvb4Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705582041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wEdgAqqt4suKo6vMyOCtLIOixa/LZP63T4K5oORwcNg=;
 b=KOsoW0+HEjI3w9oeUEFINk7dxqmgYxZjyIl299dC6bQf6X82YyMWuugW43AkdgtbFqNIev
 8raXFVR5fYVRX/gvxCs0YLX1xfFGsG5kTKbQE6tmnnKIccTFOl6rBkTHiYdmptX2nU5bxw
 iZNh7ZFESWlHKYQEeIzkgHV36CwDhLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705582041;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wEdgAqqt4suKo6vMyOCtLIOixa/LZP63T4K5oORwcNg=;
 b=ajAx6LkV2rUnUNEkC5d1qM6olhMoZ1N3ZP6sILPAFaNrgYh0/gNP8Cjq2wSyt6i0jVChpc
 gGpM60NKzKTvb4Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7C1E136F5;
 Thu, 18 Jan 2024 12:47:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ns5GI9gdqWVHeAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 18 Jan 2024 12:47:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Juan
 Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 15/30] io: Add a pwritev/preadv version that
 takes a discontiguous iovec
In-Reply-To: <ZajW26IiC8JMWSO9@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-16-farosas@suse.de> <ZaYpKorhxEi3CEmv@x1n>
 <875xztxhyh.fsf@suse.de> <ZaeiXra5hLSo0jnt@x1n> <87fryvdeco.fsf@suse.de>
 <ZajW26IiC8JMWSO9@x1n>
Date: Thu, 18 Jan 2024 09:47:18 -0300
Message-ID: <87zfx2erl5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KOsoW0+H;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ajAx6LkV
X-Spamd-Result: default: False [-2.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-0.00)[37.07%];
 MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 48FD5222A5
X-Spam-Score: -2.31
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

> On Wed, Jan 17, 2024 at 03:06:15PM -0300, Fabiano Rosas wrote:
>> Oh no, you're right. Because of p->pending_job. And thinking about
>> p->pending_job, wouldn't a trylock to the same job while being more
>> explicit?
>> 
>>     next_channel %= migrate_multifd_channels();
>>     for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
>>         p = &multifd_send_state->params[i];
>> 
>>         if(qemu_mutex_trylock(&p->mutex)) {
>>             if (p->quit) {
>>                 error_report("%s: channel %d has already quit!", __func__, i);
>>                 qemu_mutex_unlock(&p->mutex);
>>                 return -1;
>>             }
>>             next_channel = (i + 1) % migrate_multifd_channels();
>>             break;
>>         } else {
>>             /* channel still busy, try the next one */
>>         }
>>     }
>>     multifd_send_state->pages = p->pages;
>>     p->pages = pages;
>>     qemu_mutex_unlock(&p->mutex);
>
> We probably can't for now; multifd_send_thread() will unlock the mutex
> before the iochannel write()s, while the write()s will need those fields.

Right, but we'd change that code to do the IO with the lock held. If no
one is blocking, it should be ok to hold the lock. Anyway, food for
thought.


