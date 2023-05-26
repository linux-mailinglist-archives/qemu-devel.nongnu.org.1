Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9773F712F31
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 23:50:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2fJT-0006Qy-N1; Fri, 26 May 2023 17:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2fJR-0006Qh-3g
 for qemu-devel@nongnu.org; Fri, 26 May 2023 17:49:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2fJP-0004Wt-3i
 for qemu-devel@nongnu.org; Fri, 26 May 2023 17:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685137766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QedGRa0jecldcdCynPAniWXOp29URElQcju/Ij61s0w=;
 b=gq0eZ6g85VLhoqyEZvHAb7bB90yUqjWInP75mcyf/WUcYmyWCLcEwyrQGyokkqHklDBjg1
 7gafjMATPk1mZD1xgRyYxqYIntV8+V8ujjbFyafsJkM2w5fAHF7/kOLIFpiwxLFB0ufv0B
 b+s2YwgmJQF1A4gaoTY+vmvQ2nPLFiM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-wRnNYE4ENUqQnnfErMHpZw-1; Fri, 26 May 2023 17:49:24 -0400
X-MC-Unique: wRnNYE4ENUqQnnfErMHpZw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-75b175cf0d1so26040985a.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 14:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685137763; x=1687729763;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QedGRa0jecldcdCynPAniWXOp29URElQcju/Ij61s0w=;
 b=RyRVYbQ75y72FasDp600lCvk5L/0Sxg9bthKWhpB5gDS/IFfKk6LcQRF1LVJazAmhn
 pmtLOdMuFuUUHrBfFIVw5LHjZdxpRFYdBK/GEpQD7k4HIJDJ4D9r2PuipDBznTYkgi7B
 /nfujGvElau33ti8Yd/Y43DZKoZraz9tkj1znumjkOvsbLyvMqnmAIcvcvoUjj5o4GE9
 VV5B5Rd0ZTPQTEnOvr76j1CwSpm74J+U5tx2k7KSDHYpJ7mylAR7BJvU9H/MVTxt9Rcq
 9IPtLT2uSnbGxZu63PdkzM78BtleKpSXvfirdBgOhdnbbLkl6Gb6PcpPsNWgTNGKnrxY
 Z/RA==
X-Gm-Message-State: AC+VfDzItJk149f7GCOMnlneixEy1/1Tv1RvzeiiLYYRh9d3ZeVVA28V
 p5GRRdu5oTaFgCyEDIUpk0EzDOigUXCMKt3QtQMwiMtzY9PLeX9Ovy1a9PF6GZKruJYForQZTAr
 R9bfk5dvZSX1TF1w=
X-Received: by 2002:a05:6214:528d:b0:621:65de:f60c with SMTP id
 kj13-20020a056214528d00b0062165def60cmr3315661qvb.3.1685137763488; 
 Fri, 26 May 2023 14:49:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5+kFoaey11+0FgsG1Tk9tc2fhJuIblwBGkgYn7C8WxhrHaTiHW0K/6UFbvo0BpkUd9KlrGtA==
X-Received: by 2002:a05:6214:528d:b0:621:65de:f60c with SMTP id
 kj13-20020a056214528d00b0062165def60cmr3315649qvb.3.1685137763122; 
 Fri, 26 May 2023 14:49:23 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 mg16-20020a056214561000b0061b63237be3sm1500835qvb.131.2023.05.26.14.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 14:49:22 -0700 (PDT)
Date: Fri, 26 May 2023 17:49:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: quintela@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v1] migration: fix migrate_params_test_apply to set the
 dest param correctly
Message-ID: <ZHEpYQ01D7O3MQqM@x1n>
References: <20230524080157.530968-1-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230524080157.530968-1-wei.w.wang@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, May 24, 2023 at 04:01:57PM +0800, Wei Wang wrote:
> qmp_migrate_set_parameters expects to use tmp for parameters check,
> so migrate_params_test_apply is expected to copy the related fields from
> params to tmp. So fix migrate_params_test_apply to use the function
> parameter, *dest, rather than the global one. The dest->has_xxx (xxx is
> the feature name) related fields need to be set, as they will be checked
> by migrate_params_check.

I think it's fine to do as what you suggested, but I don't see much benefit
either.. the old code IIUC will check all params even if 1 param changed,
while after your change it only checks the modified ones.

There's slight benefits but not so much, especially "22+, 2-" LOCs, because
we don't really do this a lot; some more sanity check also makes sense to
me even if everything is always checked, so we'll hit errors if anything
accidentally goes wrong too.

Is there a real bug somewhere?

> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  migration/options.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/options.c b/migration/options.c
> index b62ab30cd5..a560483871 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -1089,39 +1089,45 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>  static void migrate_params_test_apply(MigrateSetParameters *params,
>                                        MigrationParameters *dest)
>  {
> -    *dest = migrate_get_current()->parameters;
> -
>      /* TODO use QAPI_CLONE() instead of duplicating it inline */
>  
>      if (params->has_compress_level) {
> +        dest->has_compress_level = true;
>          dest->compress_level = params->compress_level;
>      }
>  
>      if (params->has_compress_threads) {
> +        dest->has_compress_threads = true;
>          dest->compress_threads = params->compress_threads;
>      }
>  
>      if (params->has_compress_wait_thread) {
> +        dest->has_compress_wait_thread = true;
>          dest->compress_wait_thread = params->compress_wait_thread;
>      }
>  
>      if (params->has_decompress_threads) {
> +        dest->has_decompress_threads = true;
>          dest->decompress_threads = params->decompress_threads;
>      }
>  
>      if (params->has_throttle_trigger_threshold) {
> +        dest->has_throttle_trigger_threshold = true;
>          dest->throttle_trigger_threshold = params->throttle_trigger_threshold;
>      }
>  
>      if (params->has_cpu_throttle_initial) {
> +        dest->has_cpu_throttle_initial = true;
>          dest->cpu_throttle_initial = params->cpu_throttle_initial;
>      }
>  
>      if (params->has_cpu_throttle_increment) {
> +        dest->has_cpu_throttle_increment = true;
>          dest->cpu_throttle_increment = params->cpu_throttle_increment;
>      }
>  
>      if (params->has_cpu_throttle_tailslow) {
> +        dest->has_cpu_throttle_tailslow = true;
>          dest->cpu_throttle_tailslow = params->cpu_throttle_tailslow;
>      }
>  
> @@ -1136,45 +1142,58 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      }
>  
>      if (params->has_max_bandwidth) {
> +        dest->has_max_bandwidth = true;
>          dest->max_bandwidth = params->max_bandwidth;
>      }
>  
>      if (params->has_downtime_limit) {
> +        dest->has_downtime_limit = true;
>          dest->downtime_limit = params->downtime_limit;
>      }
>  
>      if (params->has_x_checkpoint_delay) {
> +        dest->has_x_checkpoint_delay = true;
>          dest->x_checkpoint_delay = params->x_checkpoint_delay;
>      }
>  
>      if (params->has_block_incremental) {
> +        dest->has_block_incremental = true;
>          dest->block_incremental = params->block_incremental;
>      }
>      if (params->has_multifd_channels) {
> +        dest->has_multifd_channels = true;
>          dest->multifd_channels = params->multifd_channels;
>      }
>      if (params->has_multifd_compression) {
> +        dest->has_multifd_compression = true;
>          dest->multifd_compression = params->multifd_compression;
>      }
>      if (params->has_xbzrle_cache_size) {
> +        dest->has_xbzrle_cache_size = true;
>          dest->xbzrle_cache_size = params->xbzrle_cache_size;
>      }
>      if (params->has_max_postcopy_bandwidth) {
> +        dest->has_max_postcopy_bandwidth = true;
>          dest->max_postcopy_bandwidth = params->max_postcopy_bandwidth;
>      }
>      if (params->has_max_cpu_throttle) {
> +        dest->has_max_cpu_throttle = true;
>          dest->max_cpu_throttle = params->max_cpu_throttle;
>      }
>      if (params->has_announce_initial) {
> +        dest->has_announce_initial = true;
>          dest->announce_initial = params->announce_initial;
>      }
>      if (params->has_announce_max) {
> +        dest->has_announce_max = true;
>          dest->announce_max = params->announce_max;
>      }
>      if (params->has_announce_rounds) {
> +        dest->has_announce_rounds = true;
>          dest->announce_rounds = params->announce_rounds;
>      }
>      if (params->has_announce_step) {
> +        dest->has_announce_step = true;
>          dest->announce_step = params->announce_step;
>      }
>  
> @@ -1321,6 +1340,7 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
>          params->tls_hostname->u.s = strdup("");
>      }
>  
> +    memset(&tmp, 0, sizeof(MigrationParameters));
>      migrate_params_test_apply(params, &tmp);
>  
>      if (!migrate_params_check(&tmp, errp)) {
> -- 
> 2.27.0
> 

-- 
Peter Xu


