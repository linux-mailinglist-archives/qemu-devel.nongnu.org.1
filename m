Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F3EA7DD37
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Apr 2025 14:09:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1lHU-0003Fx-Cm; Mon, 07 Apr 2025 08:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u1lHG-00036o-8j
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 08:08:37 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u1lHB-0006Sj-0g
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 08:08:32 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 789811F388;
 Mon,  7 Apr 2025 12:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744027704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ADA6ClYSRMEtT0Nhx6DgS07ZrQ/GP+k1CuZ7zJ9hadY=;
 b=EvqQrkqAP1U7SDnBAs/JMNySBsHBa9uqCXeGjv1lV7n+K0QgOa8zoQ8Lw7sqq09UUL5Tl0
 oLBkwX01T78edA5NsnCJMtLyPgIzalzsaUdgY02lSDrb21DnQ0dWCYppLhVSH3gPbvqoxB
 guri6YCr/JpdyCzt1KZTIMR16w5dEUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744027704;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ADA6ClYSRMEtT0Nhx6DgS07ZrQ/GP+k1CuZ7zJ9hadY=;
 b=U+kvcmzzNnqe2UQkXxN5LlHeoo0PEKe4cj6Cz9ggJtLqCuMKNRldRcpXtVajchT8ptPfZP
 wUhQ4t3iIvMcNsBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744027704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ADA6ClYSRMEtT0Nhx6DgS07ZrQ/GP+k1CuZ7zJ9hadY=;
 b=EvqQrkqAP1U7SDnBAs/JMNySBsHBa9uqCXeGjv1lV7n+K0QgOa8zoQ8Lw7sqq09UUL5Tl0
 oLBkwX01T78edA5NsnCJMtLyPgIzalzsaUdgY02lSDrb21DnQ0dWCYppLhVSH3gPbvqoxB
 guri6YCr/JpdyCzt1KZTIMR16w5dEUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744027704;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ADA6ClYSRMEtT0Nhx6DgS07ZrQ/GP+k1CuZ7zJ9hadY=;
 b=U+kvcmzzNnqe2UQkXxN5LlHeoo0PEKe4cj6Cz9ggJtLqCuMKNRldRcpXtVajchT8ptPfZP
 wUhQ4t3iIvMcNsBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E355513691;
 Mon,  7 Apr 2025 12:08:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xaqaJzfA82fjeAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 07 Apr 2025 12:08:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: Re: [PATCH] migration: Fix latent bug in migrate_params_test_apply()
In-Reply-To: <20250407072833.2118928-1-armbru@redhat.com>
References: <20250407072833.2118928-1-armbru@redhat.com>
Date: Mon, 07 Apr 2025 09:08:21 -0300
Message-ID: <87plhojhsa.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> migrate_params_test_apply() neglects to apply tls_authz.  Currently
> harmless, because migrate_params_check() doesn't care.  Fix it anyway.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  migration/options.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/migration/options.c b/migration/options.c
> index b0ac2ea408..cb8eec218f 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -1193,6 +1193,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>          dest->tls_hostname = params->tls_hostname->u.s;
>      }
>  
> +    if (params->tls_authz) {
> +        assert(params->tls_authz->type == QTYPE_QSTRING);
> +        dest->tls_authz = params->tls_authz->u.s;
> +    }
> +
>      if (params->has_max_bandwidth) {
>          dest->max_bandwidth = params->max_bandwidth;
>      }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

