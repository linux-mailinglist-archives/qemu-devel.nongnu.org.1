Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2200BF8C3B
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Oct 2025 22:47:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJEa-0004Ac-Gm; Tue, 21 Oct 2025 16:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBJEY-0004AI-7g
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:45:30 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBJEV-0000Ub-P9
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:45:29 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D8D41211BA;
 Tue, 21 Oct 2025 20:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761079520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rd4e1hgWP5nobV/uKOhh1uJhGcqM717KZaXJpj2yTD4=;
 b=WsqNJRsgS7feMohlZvpduqG1Q6cro9MEd4cCS+duX0Nd4l5VWKOsIcWsXIiHOxEiMLgEMF
 oyY8FVGpI0XkdqXCIRtZTjaLNwdbVCJt/aG32usujGfBYE8FDFh2wF0wm9WkJCIg07x+oi
 MhMpzfTiy4JHOjdqw+IAp4ugwRe5a1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761079520;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rd4e1hgWP5nobV/uKOhh1uJhGcqM717KZaXJpj2yTD4=;
 b=J0jahQKuIPTbixH4W2tkTNN6Kw65jvccu29QZb30W88bkCexz4X0fPIWkQdzymDy4CMQtU
 vF+KHrGp7NDIdqAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761079515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rd4e1hgWP5nobV/uKOhh1uJhGcqM717KZaXJpj2yTD4=;
 b=rqRxoZ04CD/q8FxhCZrKGs/foltm6cdstwuM8MVbP+pfbjyb+RwJ7066ZhTQoZ2/wpWzhL
 pAdDy+/wHyM8DnnsuVRHc4UuL08L8U8qspmBQqg/TXkxoc5W0IQyHO25607mZcgicuO9+K
 fNsjW0Ir1F5UIWUsMcJQFm+CK8hxSQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761079515;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rd4e1hgWP5nobV/uKOhh1uJhGcqM717KZaXJpj2yTD4=;
 b=S2gFLf9Lzc8+7HPV/lnog2XA61QNrkbl95UrsoGuje+Nnu9FbgJCD1xdzhy6tmpm89FY6r
 RIt9CI8+Uz8q/FDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E4CD139D2;
 Tue, 21 Oct 2025 20:45:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WgYUCdvw92iXUQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 21 Oct 2025 20:45:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Arun Menon <armenon@redhat.com>, peterx@redhat.com, Peter Maydell
 <peter.maydell@linaro.org>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 1/3] migration: Fix error leak in
 postcopy_ram_listen_thread()
In-Reply-To: <20251021184132.2635958-2-peterx@redhat.com>
References: <20251021184132.2635958-1-peterx@redhat.com>
 <20251021184132.2635958-2-peterx@redhat.com>
Date: Tue, 21 Oct 2025 17:45:12 -0300
Message-ID: <87qzuwt25j.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Score: -4.30
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

> As reported and analyzed by Peter:
>
> https://lore.kernel.org/r/CAFEAcA9otBWtR7rPQ0Y9aBm+7ZWJzd4VWpXrAmGr8XspPn+zpw@mail.gmail.com
>
> Fix it by freeing the error.  When at it, always reset the local_err
> pointer in both paths.
>
> Cc: Arun Menon <armenon@redhat.com>
> Resolves: Coverity CID 1641390
> Fixes: 94272d9b45 ("migration: Capture error in postcopy_ram_listen_thread()")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/savevm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index aafa40d779..635fa2f918 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2136,17 +2136,18 @@ static void *postcopy_ram_listen_thread(void *opaque)
>          if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
>              !migrate_postcopy_ram() && migrate_dirty_bitmaps())
>          {
> -            error_report("%s: loadvm failed during postcopy: %d. All states "
> +            error_report("%s: loadvm failed during postcopy: %s. All states "

Do we want to keep the %d for consistency with the way we report the
error below?

loadvm failed during postcopy: %d: %s

>                           "are migrated except dirty bitmaps. Some dirty "
>                           "bitmaps may be lost, and present migrated dirty "
>                           "bitmaps are correctly migrated and valid.",
> -                         __func__, load_res);
> +                         __func__, error_get_pretty(local_err));
> +            g_clear_pointer(&local_err, error_free);
>              load_res = 0; /* prevent further exit() */
>          } else {
>              error_prepend(&local_err,
>                            "loadvm failed during postcopy: %d: ", load_res);
>              migrate_set_error(migr, local_err);
> -            error_report_err(local_err);
> +            g_clear_pointer(&local_err, error_report_err);
>              migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
>                                             MIGRATION_STATUS_FAILED);
>          }

