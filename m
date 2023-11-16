Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8907B7EE401
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 16:16:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3e6C-0004Qr-T2; Thu, 16 Nov 2023 10:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r3e63-0004LX-Ni
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 10:15:59 -0500
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r3e61-0008BL-8K
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 10:15:58 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9DD6422940;
 Thu, 16 Nov 2023 15:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700147754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c20nUv58webHAWHqrCIr1J9xKdq8VoHYpuAm1j5MlIs=;
 b=pKOyLGZYtP4OTA5l9MWrrTdtY1c13NaNRiYdXrHidlghlhHOFKgk8lOohXTNUZSS7294Ok
 KotG4F0+AqLjaVpdV/IQsLQaoGFW4SvO+FF28QY2eWsNBbYlnV5xgBMKuDbrJxN8v2OtqD
 x3rKYrAwIATS9eI5YfnSsPYYddoBSeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700147754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c20nUv58webHAWHqrCIr1J9xKdq8VoHYpuAm1j5MlIs=;
 b=zE6owXl7aO5czzGR8tW2OQ9ZeGMb0QN+/V+/Nynlh+Ds3WJ8Wp8UePdlka7qV9d7gRQdIV
 CMNOaZ56o77ztFBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E2DB1377E;
 Thu, 16 Nov 2023 15:15:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jynLOikyVmWsTQAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 16 Nov 2023 15:15:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>, peter.maydell@linaro.org,
 quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 01/20] multifd: Add capability to enable/disable
 zero_page
In-Reply-To: <20231114054032.1192027-2-hao.xiang@bytedance.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-2-hao.xiang@bytedance.com>
Date: Thu, 16 Nov 2023 12:15:51 -0300
Message-ID: <87msvdenko.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -1.31
X-Spamd-Result: default: False [-1.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.01)[50.13%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
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
>  migration/options.c | 13 +++++++++++++
>  migration/options.h |  1 +
>  qapi/migration.json |  8 +++++++-
>  3 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/migration/options.c b/migration/options.c
> index 8d8ec73ad9..00c0c4a0d6 100644
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
> @@ -284,6 +286,17 @@ bool migrate_multifd(void)
>      return s->capabilities[MIGRATION_CAPABILITY_MULTIFD];
>  }
>  
> +bool migrate_use_main_zero_page(void)

We dropped the 'use' from these a while back. Let's not bring it back.

> +{
> +    //MigrationState *s;
> +
> +    //s = migrate_get_current();
> +
> +    // We will enable this when we add the right code.
> +    // return s->enabled_capabilities[MIGRATION_CAPABILITY_MAIN_ZERO_PAGE];

Could use /* */ so checkpatch won't complain.

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
> index 975761eebd..09e4393591 100644
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

