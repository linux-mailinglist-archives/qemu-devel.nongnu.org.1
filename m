Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C7E9E5F33
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Dec 2024 20:55:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJHwa-0000k0-5l; Thu, 05 Dec 2024 14:55:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJHwX-0000jR-5W
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 14:55:21 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJHwV-00087X-IO
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 14:55:20 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E68EC2115C;
 Thu,  5 Dec 2024 19:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733428514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DwAvbk9WnTvk9QKdi6FIm4UNiiVgkQmEBW1cx+AOm0A=;
 b=14vy4+5wl6e3q62bmRArJ6kEXvck6fHuFWMwwPVgB3SEPidTfPDjVsfCuFk1iwbkIn/+xB
 il0F1fKpGTnImgVUNxzATkpK1sPsTQ8vnD/FRGJD/DdpfuiEJSW45E8j1Uai+bdJkmKpji
 35tkJsP50UIL1GJh3HIK+KHNuDT6CFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733428514;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DwAvbk9WnTvk9QKdi6FIm4UNiiVgkQmEBW1cx+AOm0A=;
 b=j8V/Ri1Hqske9FY9433bs9e7jVZEIXdkHnua/0trcb3b52/bFs8VX7TFPLnODqwlbggiHz
 IdZOLvgNOm5wndCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="rtqh/FYS";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mZZCRnjf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733428512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DwAvbk9WnTvk9QKdi6FIm4UNiiVgkQmEBW1cx+AOm0A=;
 b=rtqh/FYS1MsFhi+9tA4ARkdMpcjFT4aRcMNsmS7i7MvX6cFOiydGVq2sS63OthC21QOMEp
 K7FtXf73gTRFe68vQEcBgiXX+HASaE54KSkU4D2DBRfZLl1TuaW7Xx75qQZw28yC09c/wi
 eGyxyc8GZOIJ4Yas9eFRuAZ9cPcWV+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733428512;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DwAvbk9WnTvk9QKdi6FIm4UNiiVgkQmEBW1cx+AOm0A=;
 b=mZZCRnjfRfqYIkZy81qVHxNW+GwQAI/XUGyonDRWC5lSOaBOQ0W0U1hy3C8Ofwukyc2seR
 QGeCHrZa/0ge4MDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48A4B138A5;
 Thu,  5 Dec 2024 19:55:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id quFDBCAFUmeeRQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 05 Dec 2024 19:55:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Alex Williamson <alex.williamson@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH 1/2] migration/multifd: Further remove the SYNC on complete
In-Reply-To: <20241205185303.897010-2-peterx@redhat.com>
References: <20241205185303.897010-1-peterx@redhat.com>
 <20241205185303.897010-2-peterx@redhat.com>
Date: Thu, 05 Dec 2024 16:55:08 -0300
Message-ID: <878qstj46b.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: E68EC2115C
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> Commit 637280aeb2 ("migration/multifd: Avoid the final FLUSH in
> complete()") removed the FLUSH operation on complete() which should avoid
> one global sync on destination side, because it's not needed.
>
> However that commit overlooked multifd_ram_flush_and_sync() part of things,
> as that's always used together with the FLUSH message on the main channel.

Let's please write the full name of the flags, functions, etc. As we've
seen in the discussion with Prasad, we're stumbling over ambiguous
terminology. This is RAM_SAVE_FLAG_MULTIFD_FLUSH.

>
> For very old binaries (multifd_flush_after_each_section==true), that's
> still needed because each EOS received on destination will enforce
> all-channel sync once.

Ok, but why does this patch not reinstate the flag?

>
> For new binaries (multifd_flush_after_each_section==false), the flush and
> sync shouldn't be needed just like the FLUSH, with the same reasoning.
>
> Currently, on new binaries we'll still send SYNC messages on multifd
> channels, even if FLUSH is omitted at the end.  It'll make all recv threads
> hang at SYNC message.

I don't get this part, is this a bug you're describing? There's not SYNC
message on the recv side, I think you mean the MULTIFD_FLAG_SYNC and
this code?

    if (flags & MULTIFD_FLAG_SYNC) {
        qemu_sem_post(&multifd_recv_state->sem_sync);
        qemu_sem_wait(&p->sem_sync);
    }

That's not a hang, that's the sync.

>
> Multifd is still all working fine because luckily recv side cleanup
> code (mostly multifd_recv_sync_main()) is smart enough to make sure even if
> recv threads are stuck at SYNC it'll get kicked out.  And since this is the
> completion phase of migration, nothing else will be sent after the SYNCs.

Hmm, a last sync on the recv side might indeed not be needed.

>
> This may be needed for VFIO in the future because VFIO can have data to
> push after ram_save_complete(), hence we don't want the recv thread to be
> stuck in SYNC message. Remove this limitation will make src even slightly
> faster too to avoid some more code.
>
> Stable branches do not need this patch, as no real bug I can think of that
> will go wrong there.. so not attaching Fixes to be clear on the backport
> not needed.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/ram.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 05ff9eb328..7284c34bd8 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3283,9 +3283,16 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>          }
>      }
>  
> -    ret = multifd_ram_flush_and_sync();
> -    if (ret < 0) {
> -        return ret;
> +    if (migrate_multifd() &&
> +        migrate_multifd_flush_after_each_section()) {
> +        /*
> +         * Only the old dest QEMU will need this sync, because each EOS
> +         * will require one SYNC message on each channel.
> +         */
> +        ret = multifd_ram_flush_and_sync();
> +        if (ret < 0) {
> +            return ret;
> +        }

I don't think this works. We need one last flush to not lose the last
few pages of ram. And we need the src side sync of multifd threads to
make sure this function doesn't return before all IO has been put on the
wire.

This also doesn't address what the commit message says about the recv
side never getting the RAM_SAVE_FLAG_MULTIFD_FLUSH message.

>      }
>  
>      if (migrate_mapped_ram()) {

