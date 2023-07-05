Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC937490CB
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 00:06:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHAcj-00013e-UE; Wed, 05 Jul 2023 18:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qHAch-00013F-MD
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 18:05:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qHAcg-0004NB-3W
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 18:05:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 901DC21980;
 Wed,  5 Jul 2023 22:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688594716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H7nvyUXHRLHu3253rr2ARaBZjkCs0YjYHM/j0EJZCMA=;
 b=d0AqwboocNNFrgn9wim7hKTFcIs5Rgol7UYJpNW/DfZELmqZYuWhdLebbPdikNHx7PPPGW
 vmOJSFF+vqZ5LBUUCzEhXl/YAEG4QWr1uc/CW0QlBoZXiKG5YKW08REZS+N9yc+dTULvoz
 z63/b6+bz0ReCYFJ+0A6McXHcBOn2dM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688594716;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H7nvyUXHRLHu3253rr2ARaBZjkCs0YjYHM/j0EJZCMA=;
 b=w3u2w9E/7Mdt5XZP6laonybMfIGzN/k4xCOlRlnVzxYYwz4YbOSl/OOPF6B5lCOvLOeocq
 WtOQ1+VeI0FHSfCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 228C5134F3;
 Wed,  5 Jul 2023 22:05:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cyOvNxvppWSbWAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 05 Jul 2023 22:05:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Leonardo Bras Soares Passos <lsoaresp@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Lukas Straub <lukasstraub2@web.de>, Laszlo Ersek
 <lersek@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH v2 7/7] migration: Provide explicit error message for
 file shutdowns
In-Reply-To: <20230705163502.331007-8-peterx@redhat.com>
References: <20230705163502.331007-1-peterx@redhat.com>
 <20230705163502.331007-8-peterx@redhat.com>
Date: Wed, 05 Jul 2023 19:05:13 -0300
Message-ID: <878rbu3tgm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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

> Provide an explicit reason for qemu_file_shutdown()s, which can be
> displayed in query-migrate when used.
>

Can we consider this to cover the TODO:

 * TODO: convert to propagate Error objects instead of squashing
 * to a fixed errno value

or would that need something fancier?

> This will make e.g. migrate-pause to display explicit error descriptions,
> from:
>
> "error-desc": "Channel error: Input/output error"
>
> To:
>
> "error-desc": "Channel is explicitly shutdown by the user"
>
> in query-migrate.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/qemu-file.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 419b4092e7..ff605027de 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -87,7 +87,10 @@ int qemu_file_shutdown(QEMUFile *f)
>       *      --> guest crash!
>       */
>      if (!f->last_error) {
> -        qemu_file_set_error(f, -EIO);
> +        Error *err = NULL;
> +
> +        error_setg(&err, "Channel is explicitly shutdown by the user");

It is good that we can grep this message. However, I'm confused about
who the "user" is meant to be here and how are they implicated in this
error.

> +        qemu_file_set_error_obj(f, -EIO, err);
>      }
>  
>      if (!qio_channel_has_feature(f->ioc,

