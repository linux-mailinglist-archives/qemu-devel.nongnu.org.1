Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F01B9F343F
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Dec 2024 16:18:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNCq0-0001EK-2B; Mon, 16 Dec 2024 10:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tNCpk-0001Bz-9c; Mon, 16 Dec 2024 10:16:36 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tNCpi-0008KA-AK; Mon, 16 Dec 2024 10:16:31 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 26B832111F;
 Mon, 16 Dec 2024 15:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734362186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P2s+gCmqM5Sv7ZxSPSWF5o7JMNY7ndjU62hqBJ2vtHs=;
 b=dWv6UdGoCQnGCufg9CvvCUQPRSy8w83Dnhu7kTpWX6B30Fm+VHkdgP1lrKOWYYUm+8DVmF
 xCNSLSx3eU3CD/PU/E8U3IS9jX35fOa1RS8HXdCJ7TrgTcEIaVIXHCI/MDFrRtAK10K3fp
 DDA91le12tAQFUE+jL/xR1wxmGPnAqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734362186;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P2s+gCmqM5Sv7ZxSPSWF5o7JMNY7ndjU62hqBJ2vtHs=;
 b=bdeB+8EDFODv2jkK3rL+zIiNLIpzPHUTEKokspiQU1en34nmcF6KAJcw79V5PG9pweqGIS
 bqEu317YoBu1ItCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734362186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P2s+gCmqM5Sv7ZxSPSWF5o7JMNY7ndjU62hqBJ2vtHs=;
 b=dWv6UdGoCQnGCufg9CvvCUQPRSy8w83Dnhu7kTpWX6B30Fm+VHkdgP1lrKOWYYUm+8DVmF
 xCNSLSx3eU3CD/PU/E8U3IS9jX35fOa1RS8HXdCJ7TrgTcEIaVIXHCI/MDFrRtAK10K3fp
 DDA91le12tAQFUE+jL/xR1wxmGPnAqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734362186;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P2s+gCmqM5Sv7ZxSPSWF5o7JMNY7ndjU62hqBJ2vtHs=;
 b=bdeB+8EDFODv2jkK3rL+zIiNLIpzPHUTEKokspiQU1en34nmcF6KAJcw79V5PG9pweqGIS
 bqEu317YoBu1ItCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A9AD13418;
 Mon, 16 Dec 2024 15:16:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id L+fyF0lEYGd9EgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 16 Dec 2024 15:16:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, Stefan Hajnoczi <stefanha@redhat.com>, Andrey
 Drobyshev <andrey.drobyshev@virtuozzo.com>, Eric Blake
 <eblake@redhat.com>, "Dr . David Alan Gilbert" <dave@treblig.org>, Kevin
 Wolf <kwolf@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v2 3/6] migration/block: Make late-block-active the default
In-Reply-To: <20241206230838.1111496-4-peterx@redhat.com>
References: <20241206230838.1111496-1-peterx@redhat.com>
 <20241206230838.1111496-4-peterx@redhat.com>
Date: Mon, 16 Dec 2024 12:16:23 -0300
Message-ID: <874j33y7y0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[11];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
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

> Migration capability 'late-block-active' controls when the block drives
> will be activated.  If enabled, block drives will only be activated until
> VM starts, either src runstate was "live" (RUNNING, or SUSPENDED), or it'll
> be postponed until qmp_cont().
>
> Let's do this unconditionally.  There's no harm to delay activation of
> block drives.  Meanwhile there's no ABI breakage if dest does it, because
> src QEMU has nothing to do with it, so it's no concern on ABI breakage.
>
> IIUC we could avoid introducing this cap when introducing it before, but
> now it's still not too late to just always do it.  Cap now prone to
> removal, but it'll be for later patches.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

