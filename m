Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0374A9B5215
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Oct 2024 19:49:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5rGO-0005Fh-4c; Tue, 29 Oct 2024 14:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t5rGJ-0005FY-3z
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 14:48:15 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t5rGG-0008L7-Ea
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 14:48:14 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9364221AC1;
 Tue, 29 Oct 2024 18:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730227688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fsmBZ+w5yd2DMImeC5CdS0xCDRR97Dy6ZCcQtQryybc=;
 b=P9IqZX6SQ40HhFWtvh0iXzk2K+ThUMwjyh9hEhFkBdjsA+4qL37pJrFqJVQHC9eoNLwCBz
 PD74Fb86A+P6GASkNGU7D47bN7ff6Fj+02Ld3q2F64hUC1a/d9Yf1ghtNK8CS71Hind7HH
 2C6yv2nA66/+D5lxjR3FCFRPsm0AF7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730227688;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fsmBZ+w5yd2DMImeC5CdS0xCDRR97Dy6ZCcQtQryybc=;
 b=65Z4d1q0HB4PADKBkHwLWHd5YdjX2QlWatdWySStSX9e6rXMc+UNZXMOjSica5ZztYSyiB
 mSwqP+Z1tmGYDlCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730227688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fsmBZ+w5yd2DMImeC5CdS0xCDRR97Dy6ZCcQtQryybc=;
 b=P9IqZX6SQ40HhFWtvh0iXzk2K+ThUMwjyh9hEhFkBdjsA+4qL37pJrFqJVQHC9eoNLwCBz
 PD74Fb86A+P6GASkNGU7D47bN7ff6Fj+02Ld3q2F64hUC1a/d9Yf1ghtNK8CS71Hind7HH
 2C6yv2nA66/+D5lxjR3FCFRPsm0AF7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730227688;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fsmBZ+w5yd2DMImeC5CdS0xCDRR97Dy6ZCcQtQryybc=;
 b=65Z4d1q0HB4PADKBkHwLWHd5YdjX2QlWatdWySStSX9e6rXMc+UNZXMOjSica5ZztYSyiB
 mSwqP+Z1tmGYDlCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DA64136A5;
 Tue, 29 Oct 2024 18:48:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wP4bNectIWdwTAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 29 Oct 2024 18:48:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,
 peterx@redhat.com, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 1/8] migration: Take migration object refcount
 earlier for threads
In-Reply-To: <20241024213056.1395400-2-peterx@redhat.com>
References: <20241024213056.1395400-1-peterx@redhat.com>
 <20241024213056.1395400-2-peterx@redhat.com>
Date: Tue, 29 Oct 2024 15:48:05 -0300
Message-ID: <875xpad9ui.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

> Both migration thread or background snapshot thread will take a refcount of
> the migration object at the entrace of the thread function.
>
> That makes sense, because it protects the object from being freed by the
> main thread in migration_shutdown() later, but it might still race with it
> if the thread is scheduled too late.  Consider the case right after
> pthread_create() happened, VM shuts down with the object released, but
> right after that the migration thread finally got created, referencing
> MigrationState* in the opaque pointer which is already freed.
>
> The only 100% safe way to make sure it won't get freed is taking the
> refcount right before the thread is created, meanwhile when BQL is held.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

