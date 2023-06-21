Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92547737F95
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 12:32:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBv88-0006QG-EU; Wed, 21 Jun 2023 06:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qBv7x-0006Ny-2x
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:31:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qBv7u-0008Sl-Us
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687343510;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=GO+h0yRsFA0/qVIPbhYqhbL016e1dQfdCTNZNx7a5/w=;
 b=eudK3BYrqokHR0AvUkamp1QAUGyctwoAFviVkf3arze2eboPTlJuaqQoFv7KIJYV3bp8bo
 kkzKavWXvau5jXYHHLOhWEsoE/oaawDw+YHMzlcDmDE70hxM9ohssfC0ya1x/ie7Rx1Zs/
 /fkbtava9bF/5nnoIowHKaf7UnCWRQs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-pOJ7puJ7N2uNiRO0gxqOcg-1; Wed, 21 Jun 2023 06:31:47 -0400
X-MC-Unique: pOJ7puJ7N2uNiRO0gxqOcg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5A3E38008AE;
 Wed, 21 Jun 2023 10:31:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F0E3B9E9C;
 Wed, 21 Jun 2023 10:31:44 +0000 (UTC)
Date: Wed, 21 Jun 2023 11:31:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 6/6] migration: Deprecated old compression method
Message-ID: <ZJLRj02koQn4jXHi@redhat.com>
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-7-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230612193344.3796-7-quintela@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Jun 12, 2023 at 09:33:44PM +0200, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  docs/about/deprecated.rst |  8 ++++
>  qapi/migration.json       | 92 ++++++++++++++++++++++++---------------
>  migration/options.c       | 13 ++++++
>  3 files changed, 79 insertions(+), 34 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 173c5ba5cb..fe7f2bbde8 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -460,3 +460,11 @@ block migration (since 8.1)
>  Block migration is too inflexible.  It needs to migrate all block
>  devices or none.  Use driver_mirror+NBD instead.
>  
> +old compression method (since 8.1)
> +''''''''''''''''''''''''''''''''''
> +
> +Compression method fails too much.  Too many races.  We are going to
> +remove it if nobody fixes it.  For starters, migration-test
> +compression tests are disabled becase they hand randomly.  If you need
> +compression, use multifd compression methods.
> +
> diff --git a/qapi/migration.json b/qapi/migration.json
> index a8497de48d..40a8b5d124 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -244,6 +244,7 @@
>  #
>  # @compression: migration compression statistics, only returned if
>  #     compression feature is on and status is 'active' or 'completed'
> +#     It is obsolete and deprecated.  Use multifd compression methods.
>  #     (Since 3.1)

This doesn't give users an indication /why/ we're saying this. Instead
I'd suggest

  This feature is unreliable and not tested. It is recommended to
  use multifd migration instead, which offers an alternative reliable
  and tested compression implementation.
  

>  #
>  # @socket-address: Only used for tcp, to know what the real port is
> @@ -261,7 +262,8 @@
>  # Features:
>  #
>  # @deprecated: @disk migration is deprecated.  Use driver_mirror+NBD
> -#     instead.
> +#     instead. @compression is obsolete use multifd compression
> +#     methods instead.

For @deprecated, are we supposed to list multiple things at once, or
use a separate @deprecated tag for each one ?

Again I'd suggest rewording

    @compression is unreliable and untested. It is recommended to
    use multifd migration, which offers an alternative compression
    implementation that is reliable and tested.


> diff --git a/migration/options.c b/migration/options.c
> index 374dc0767e..c04e62ba2d 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -443,6 +443,11 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>                      "Use driver_mirror+NBD instead.");
>      }
>  
> +    if (new_caps[MIGRATION_CAPABILITY_BLOCK]) {

Surely MIGRATION_CAPABILITY_COMPRESS not BLOCK ?

> +        warn_report("Old compression method is deprecated. "
> +                    "Use multifd compression methods instead.");
> +    }
> +
>  #ifndef CONFIG_REPLICATION
>      if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
>          error_setg(errp, "QEMU compiled without replication module"
> @@ -1196,18 +1201,26 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>      /* TODO use QAPI_CLONE() instead of duplicating it inline */
>  
>      if (params->has_compress_level) {
> +        warn_report("Old compression is deprecated. "
> +                    "Use multifd compression methods instead.");
>          s->parameters.compress_level = params->compress_level;
>      }
>  
>      if (params->has_compress_threads) {
> +        warn_report("Old compression is deprecated. "
> +                    "Use multifd compression methods instead.");
>          s->parameters.compress_threads = params->compress_threads;
>      }
>  
>      if (params->has_compress_wait_thread) {
> +        warn_report("Old compression is deprecated. "
> +                    "Use multifd compression methods instead.");
>          s->parameters.compress_wait_thread = params->compress_wait_thread;
>      }
>  
>      if (params->has_decompress_threads) {
> +        warn_report("Old compression is deprecated. "
> +                    "Use multifd compression methods instead.");
>          s->parameters.decompress_threads = params->decompress_threads;
>      }
>  
> -- 
> 2.40.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


