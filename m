Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7024827939
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 21:40:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMwPO-0008Mx-Kl; Mon, 08 Jan 2024 15:39:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rMwPC-0008MR-MQ
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 15:39:32 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rMwP9-0003Fs-Pp
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 15:39:30 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A70B421D0E;
 Mon,  8 Jan 2024 20:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704746364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XEhYPUImz+WCc91z7/tJed36OGcLQ8lwF97ewVg/giA=;
 b=Y23iXvfTnDo4lzxaCCm5YNKWbiLy0UR//cnc7yug9iHAKD73qj6ZTv27izaQ5PhzLRW8v9
 zDH62DjKGGdUeYSo/OoFBP1vpw+PbS/cxOOC8Y+866l/wHLuo1eOaOVByqp+nCYk2fsLgA
 DHptapDYqSq854HFwtnKPuHqCz1vGdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704746364;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XEhYPUImz+WCc91z7/tJed36OGcLQ8lwF97ewVg/giA=;
 b=KFwmAlaKKOzZvLDxChZY8PRr6Zo85REIGDrbZp5hgqBYhGnMFB5c1cc2+2hapmhdHG1zkO
 6f7Ca8rm8nKaciDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704746364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XEhYPUImz+WCc91z7/tJed36OGcLQ8lwF97ewVg/giA=;
 b=Y23iXvfTnDo4lzxaCCm5YNKWbiLy0UR//cnc7yug9iHAKD73qj6ZTv27izaQ5PhzLRW8v9
 zDH62DjKGGdUeYSo/OoFBP1vpw+PbS/cxOOC8Y+866l/wHLuo1eOaOVByqp+nCYk2fsLgA
 DHptapDYqSq854HFwtnKPuHqCz1vGdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704746364;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XEhYPUImz+WCc91z7/tJed36OGcLQ8lwF97ewVg/giA=;
 b=KFwmAlaKKOzZvLDxChZY8PRr6Zo85REIGDrbZp5hgqBYhGnMFB5c1cc2+2hapmhdHG1zkO
 6f7Ca8rm8nKaciDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CF011392C;
 Mon,  8 Jan 2024 20:39:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gcvGOHtdnGX1TAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 08 Jan 2024 20:39:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>, peter.maydell@linaro.org,
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 01/20] multifd: Add capability to enable/disable
 zero_page
In-Reply-To: <20240104004452.324068-2-hao.xiang@bytedance.com>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
 <20240104004452.324068-2-hao.xiang@bytedance.com>
Date: Mon, 08 Jan 2024 17:39:21 -0300
Message-ID: <87r0irsgp2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: 0.09
X-Rspamd-Queue-Id: A70B421D0E
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Y23iXvfT;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KFwmAlaK
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: /
X-Spamd-Result: default: False [0.09 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 BAYES_SPAM(5.10)[100.00%];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[]; FROM_HAS_DN(0.00)[];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]
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

Hao Xiang <hao.xiang@bytedance.com> writes:

> From: Juan Quintela <quintela@redhat.com>
>
> We have to enable it by default until we introduce the new code.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/options.c | 15 +++++++++++++++
>  migration/options.h |  1 +
>  qapi/migration.json |  8 +++++++-
>  3 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/migration/options.c b/migration/options.c
> index 8d8ec73ad9..0f6bd78b9f 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -204,6 +204,8 @@ Property migration_properties[] = {
>      DEFINE_PROP_MIG_CAP("x-switchover-ack",
>                          MIGRATION_CAPABILITY_SWITCHOVER_ACK),
>      DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LIMIT),
> +    DEFINE_PROP_MIG_CAP("main-zero-page",
> +            MIGRATION_CAPABILITY_MAIN_ZERO_PAGE),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -284,6 +286,19 @@ bool migrate_multifd(void)
>      return s->capabilities[MIGRATION_CAPABILITY_MULTIFD];
>  }
>  
> +bool migrate_use_main_zero_page(void)
> +{
> +    /* MigrationState *s; */
> +
> +    /* s = migrate_get_current(); */
> +
> +    /*
> +     * We will enable this when we add the right code.
> +     * return s->enabled_capabilities[MIGRATION_CAPABILITY_MAIN_ZERO_PAGE];
> +     */
> +    return true;
> +}
> +
>  bool migrate_pause_before_switchover(void)
>  {
>      MigrationState *s = migrate_get_current();
> diff --git a/migration/options.h b/migration/options.h
> index 246c160aee..c901eb57c6 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -88,6 +88,7 @@ int migrate_multifd_channels(void);
>  MultiFDCompression migrate_multifd_compression(void);
>  int migrate_multifd_zlib_level(void);
>  int migrate_multifd_zstd_level(void);
> +bool migrate_use_main_zero_page(void);
>  uint8_t migrate_throttle_trigger_threshold(void);
>  const char *migrate_tls_authz(void);
>  const char *migrate_tls_creds(void);
> diff --git a/qapi/migration.json b/qapi/migration.json
> index eb2f883513..80c4b13516 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -531,6 +531,12 @@
>  #     and can result in more stable read performance.  Requires KVM
>  #     with accelerator property "dirty-ring-size" set.  (Since 8.1)
>  #
> +#
> +# @main-zero-page: If enabled, the detection of zero pages will be
> +#                  done on the main thread.  Otherwise it is done on
> +#                  the multifd threads.
> +#                  (since 8.2)
> +#
>  # Features:
>  #
>  # @deprecated: Member @block is deprecated.  Use blockdev-mirror with
> @@ -555,7 +561,7 @@
>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>             'validate-uuid', 'background-snapshot',
>             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
> -           'dirty-limit'] }
> +           'dirty-limit', 'main-zero-page'] }
>  
>  ##
>  # @MigrationCapabilityStatus:

I'll extract this zero page work into a separate series and submit for
review soon. I want to get people's opinion on it independently of this
series.

