Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 786737DBC55
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 16:04:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxTnx-0007lV-Cx; Mon, 30 Oct 2023 11:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxTnv-0007lJ-Ip
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 11:03:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxTns-00084s-Gc
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 11:03:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B25C41FF04;
 Mon, 30 Oct 2023 15:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698678222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ew4/JODP4y33/2ZIW9gtwSI3XjMdodBacJ7snANSiew=;
 b=itYvCqmrm+2FXJVLvpggN9YrsrGHXhNmMpWfgaqidte6h1JbQGJA8G3qDtUIJyycOgcwAM
 EY8j6txV0evXVaV/D77HDsOItfzlVeEsvvpTjGjUxwr3/c6yrOPvVWZsBxcVM9EE86zZ2T
 aBrXdkt8sVHI3sGyafsYKVGe6/mctZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698678222;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ew4/JODP4y33/2ZIW9gtwSI3XjMdodBacJ7snANSiew=;
 b=wA0/xQ/EHsEK/tUaWe1XtC1gJhFzd4r6wAvzc3Tuy0L0rpXPm8IKHC+PL0SD0fzhnhXW5x
 J4EP7dd7ygOK48Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BED6138EF;
 Mon, 30 Oct 2023 15:03:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id q6c2Ac7FP2WkWQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 30 Oct 2023 15:03:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>, quintela@redhat.com,
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 13/16] migration/multifd: Add migration option set
 packet size.
In-Reply-To: <20231025193822.2813204-14-hao.xiang@bytedance.com>
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
 <20231025193822.2813204-14-hao.xiang@bytedance.com>
Date: Mon, 30 Oct 2023 12:03:39 -0300
Message-ID: <87bkcgnodw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hao Xiang <hao.xiang@bytedance.com> writes:

> The current multifd packet size is 128 * 4kb. This change adds
> an option to set the packet size. Both sender and receiver needs
> to set the same packet size for things to work.
>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>  migration/options.c | 34 ++++++++++++++++++++++++++++++++++
>  migration/options.h |  1 +
>  qapi/migration.json | 20 +++++++++++++++++---
>  3 files changed, 52 insertions(+), 3 deletions(-)
>
> diff --git a/migration/options.c b/migration/options.c
> index 9ee0ad5d89..6cb3d19470 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -83,6 +83,12 @@
>   */
>  #define DEFAULT_MIGRATE_MULTIFD_NORMAL_PAGE_RATIO 101
>  
> +/*
> + * Parameter for multifd packet size.
> + */
> +#define DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE (512 * 1024)
> +#define MAX_MIGRATE_MULTIFD_PACKET_SIZE (1024 * 4 * 1024)
> +
>  #define DEFINE_PROP_MIG_CAP(name, x)             \
>      DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
>  
> @@ -183,6 +189,9 @@ Property migration_properties[] = {
>      DEFINE_PROP_UINT8("multifd-normal-page-ratio", MigrationState,
>                        parameters.multifd_normal_page_ratio,
>                        DEFAULT_MIGRATE_MULTIFD_NORMAL_PAGE_RATIO),
> +    DEFINE_PROP_SIZE("multifd-packet-size", MigrationState,
> +                     parameters.multifd_packet_size,
> +                     DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE),
>  
>      /* Migration capabilities */
>      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> @@ -822,6 +831,13 @@ uint8_t migrate_multifd_normal_page_ratio(void)
>      return s->parameters.multifd_normal_page_ratio;
>  }
>  
> +uint64_t migrate_multifd_packet_size(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    return s->parameters.multifd_packet_size;
> +}
> +
>  MultiFDCompression migrate_multifd_compression(void)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -958,6 +974,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
>      params->has_block_incremental = true;
>      params->block_incremental = s->parameters.block_incremental;
> +    params->has_multifd_packet_size = true;
> +    params->multifd_packet_size = s->parameters.multifd_packet_size;
>      params->has_multifd_channels = true;
>      params->multifd_channels = s->parameters.multifd_channels;
>      params->has_multifd_compression = true;
> @@ -1016,6 +1034,7 @@ void migrate_params_init(MigrationParameters *params)
>      params->has_downtime_limit = true;
>      params->has_x_checkpoint_delay = true;
>      params->has_block_incremental = true;
> +    params->has_multifd_packet_size = true;
>      params->has_multifd_channels = true;
>      params->has_multifd_compression = true;
>      params->has_multifd_zlib_level = true;
> @@ -1104,6 +1123,15 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>  
>      /* x_checkpoint_delay is now always positive */
>  
> +    if (params->has_multifd_packet_size &&
> +        ((params->multifd_packet_size < DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE) ||
> +            (params->multifd_packet_size >  MAX_MIGRATE_MULTIFD_PACKET_SIZE))) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> +                    "multifd_packet_size",
> +                    "a value between 524288 and 4194304");
> +        return false;
> +    }
> +
>      if (params->has_multifd_channels && (params->multifd_channels < 1)) {
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>                     "multifd_channels",
> @@ -1281,6 +1309,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      if (params->has_block_incremental) {
>          dest->block_incremental = params->block_incremental;
>      }
> +    if (params->has_multifd_packet_size) {
> +        dest->multifd_packet_size = params->multifd_packet_size;
> +    }
>      if (params->has_multifd_channels) {
>          dest->multifd_channels = params->multifd_channels;
>      }
> @@ -1408,6 +1439,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>      if (params->has_block_incremental) {
>          s->parameters.block_incremental = params->block_incremental;
>      }
> +    if (params->has_multifd_packet_size) {
> +        s->parameters.multifd_packet_size = params->multifd_packet_size;
> +    }
>      if (params->has_multifd_channels) {
>          s->parameters.multifd_channels = params->multifd_channels;
>      }
> diff --git a/migration/options.h b/migration/options.h
> index dafb09d6ea..1170971aef 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -93,6 +93,7 @@ const char *migrate_tls_hostname(void);
>  uint64_t migrate_xbzrle_cache_size(void);
>  const char *migrate_multifd_dsa_accel(void);
>  uint8_t migrate_multifd_normal_page_ratio(void);
> +uint64_t migrate_multifd_packet_size(void);
>  
>  /* parameters setters */
>  
> diff --git a/qapi/migration.json b/qapi/migration.json
> index a667527081..a492b73060 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -835,6 +835,10 @@
>  # @multifd-normal-page-ratio: Test hook setting the normal page ratio.
>  #     (Since 8.1)
>  #
> +# @multifd-packet-size: Packet size used to migrate data. This value
> +#     needs to be a multiple of qemu_target_page_size(). The default
> +#     value is (512 * 1024) (Since 8.0)

User doesn't know what qemu_target_page_size means. I'd also not have
them do arithmetic, specially since the option takes a single number.

We also need to enforce this in the code in the next patch.

> +#
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
> @@ -859,7 +863,7 @@
>             'multifd-zlib-level', 'multifd-zstd-level',
>             'block-bitmap-mapping',
>             { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
> -           'vcpu-dirty-limit', 'multifd-normal-page-ratio'] }
> +           'vcpu-dirty-limit', 'multifd-normal-page-ratio', 'multifd-packet-size'] }
>  
>  ##
>  # @MigrateSetParameters:
> @@ -1007,6 +1011,10 @@
>  # @multifd-normal-page-ratio: Test hook setting the normal page ratio.
>  #     (Since 8.1)
>  #
> +# @multifd-packet-size: Packet size used to migrate data. This value
> +#     needs to be a multiple of qemu_target_page_size(). The default
> +#     value is (512 * 1024) (Since 8.0)
> +#
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
> @@ -1050,7 +1058,8 @@
>                                              'features': [ 'unstable' ] },
>              '*vcpu-dirty-limit': 'uint64',
>              '*multifd-dsa-accel': 'StrOrNull',
> -            '*multifd-normal-page-ratio': 'uint8'} }
> +            '*multifd-normal-page-ratio': 'uint8',
> +            '*multifd-packet-size' : 'uint64'} }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1218,6 +1227,10 @@
>  # @multifd-normal-page-ratio: Test hook setting the normal page ratio.
>  #     (Since 8.1)
>  #
> +# @multifd-packet-size: Packet size used to migrate data. This value
> +#     needs to be a multiple of qemu_target_page_size(). The default
> +#     value is (512 * 1024) (Since 8.0)
> +#
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
> @@ -1258,7 +1271,8 @@
>                                              'features': [ 'unstable' ] },
>              '*vcpu-dirty-limit': 'uint64',
>              '*multifd-dsa-accel': 'str',
> -            '*multifd-normal-page-ratio': 'uint8'} }
> +            '*multifd-normal-page-ratio': 'uint8',
> +            '*multifd-packet-size': 'uint64'} }
>  
>  ##
>  # @query-migrate-parameters:

