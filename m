Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FE382B4D5
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 19:40:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNzx1-0002ZT-TT; Thu, 11 Jan 2024 13:38:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rNzww-0002Z7-Ct
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 13:38:42 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rNzws-0006sp-Bs
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 13:38:41 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 50FFF220A4;
 Thu, 11 Jan 2024 18:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704998316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YUu8rewE3FmY878ExJG0UOri5bVKsRz8zDfQxQJOziU=;
 b=Cey6EdHzVX9w674DvPiYyi/Y0COTQTskTS7lXq+fOeD7Y/u+MScslJ86uY2iFwrmo/QOJE
 yTT1O3oypa8ODGii9wDEexR3fcplpNzgHFpS51YYyZKk4aF6vCypd47Yc0bLlO2KGxRrzq
 1jJM0REw0PwoaU9PX8zwGPCfbCqL9p4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704998316;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YUu8rewE3FmY878ExJG0UOri5bVKsRz8zDfQxQJOziU=;
 b=wDxf/ZPEiG8DdiVTL/SIaOO6v0l3bzJ5AOogJjjxos6kptn+Iko0XO1R59d+/fw/u3AeLe
 YxIQOj6vLvmialDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704998316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YUu8rewE3FmY878ExJG0UOri5bVKsRz8zDfQxQJOziU=;
 b=Cey6EdHzVX9w674DvPiYyi/Y0COTQTskTS7lXq+fOeD7Y/u+MScslJ86uY2iFwrmo/QOJE
 yTT1O3oypa8ODGii9wDEexR3fcplpNzgHFpS51YYyZKk4aF6vCypd47Yc0bLlO2KGxRrzq
 1jJM0REw0PwoaU9PX8zwGPCfbCqL9p4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704998316;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YUu8rewE3FmY878ExJG0UOri5bVKsRz8zDfQxQJOziU=;
 b=wDxf/ZPEiG8DdiVTL/SIaOO6v0l3bzJ5AOogJjjxos6kptn+Iko0XO1R59d+/fw/u3AeLe
 YxIQOj6vLvmialDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB16E132CF;
 Thu, 11 Jan 2024 18:38:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5gDWF6s1oGXudwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 11 Jan 2024 18:38:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Leonardo
 Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 00/30] migration: File based migration with
 multifd and fixed-ram
In-Reply-To: <ZZ_IElHLW1D-lrec@x1n>
References: <20231127202612.23012-1-farosas@suse.de> <ZZ_IElHLW1D-lrec@x1n>
Date: Thu, 11 Jan 2024 15:38:31 -0300
Message-ID: <87zfxbn2ag.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Cey6EdHz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="wDxf/ZPE"
X-Spamd-Result: default: False [-3.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 50FFF220A4
X-Spam-Score: -3.31
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> On Mon, Nov 27, 2023 at 05:25:42PM -0300, Fabiano Rosas wrote:
>> Hi,
>> 
>> In this v3:
>> 
>> Added support for the "file:/dev/fdset/" syntax to receive multiple
>> file descriptors. This allows the management layer to open the
>> migration file beforehand and pass the file descriptors to QEMU. We
>> need more than one fd to be able to use O_DIRECT concurrently with
>> unaligned writes.
>> 
>> Dropped the auto-pause capability. That discussion was kind of
>> stuck. We can revisit optimizations for non-live scenarios once the
>> series is more mature/merged.
>> 
>> Changed the multifd incoming side to use a more generic data structure
>> instead of MultiFDPages_t. This allows multifd to restore the ram
>> using larger chunks.
>> 
>> The rest are minor changes, I have noted them in the patches
>> themselves.
>
> Fabiano,
>
> Could you always keep a section around in the cover letter (and also in the
> upcoming doc file fixed-ram.rst) on the benefits of this feature?
>
> Please bare with me - I can start to ask silly questions.
>

That's fine. Ask away!

> I thought it was about "keeping the snapshot file small".  But then when I
> was thinking the use case, iiuc fixed-ram migration should always suggest
> the user to stop the VM first before migration starts, then if the VM is
> stopped the ultimate image shouldn't be large either.
>
> Or is it about performance only?  Where did I miss?

Performance is the main benefit because fixed-ram enables the use of
multifd for file migration which would otherwise not be
parallelizable. To use multifd has been the direction for a while as you
know, so it makes sense.

A fast file migration is desirable because it could be used for
snapshots with a stopped vm and also to replace the "exec:cat" hack
(this last one I found out about recently, Juan mentioned it in this
thread: https://lore.kernel.org/r/87cyx5ty26.fsf@secure.mitica).

The size aspect is just an interesting property, not necessarily a
reason. It's about having the file bounded to the RAM size. So a running
guest would not produce a continuously growing file. This is in contrast
with previous experiments (libvirt code) in using a proxy to put
multifd-produced data into a file.

I'll add this^ information in a more organized matter to the docs and
cover letter. Let me know what else I need to clarify.

Some notes about fixed-ram by itself:

This series also enables fixed-ram without multifd, which would only
take benefit of the size property. That is not part of our end goal
which is to have multifd + fixed-ram, but I kept it nonetheless because
it helps to debug/reason about the fixed-ram format without conflating
matters with multifd.

Fixed-ram without multifd also allows the file migration to take benefit
of direct io because the data portion of the file (pages) will be
written with alignment. This version of the series does not yet support
it, but I have a simple patch for the next version.

I also had a - perhaps naive - idea that we could merge the io code +
fixed-ram first, to expedite things and later bring in the multifd and
directio enhancements, but the review process ended up not being that
modular.

