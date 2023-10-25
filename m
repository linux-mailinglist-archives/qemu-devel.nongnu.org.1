Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0000C7D65BA
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 10:49:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvZZC-0002Jk-Mu; Wed, 25 Oct 2023 04:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvZZ3-0002D8-Rj
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 04:48:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvZZ2-0002Fg-1R
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 04:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698223711;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qVjwIa4PylLHEvrv0/PkfK+RlNeHS04+0f8kHQ/8kEw=;
 b=Vo5kSvT28/3uVs7WmegwHpU8S/EPG6FcfqTiKBgZgzJ2wCZZ6rkRFYxQ4SkHqdaA+7lqeR
 HXDmI9JfbIoVJ4dAK5ASMK2oYpozdEe5G963kteClxpinHcRyBQUZy4kqw1ZovD57OooDd
 eUPjhvs8vkg6jNxIucSslaV4t2w+POs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-3Mmg11jAPe-1iN0VQdn7nA-1; Wed,
 25 Oct 2023 04:48:27 -0400
X-MC-Unique: 3Mmg11jAPe-1iN0VQdn7nA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4362D2825EAC;
 Wed, 25 Oct 2023 08:48:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E989140C6F79;
 Wed, 25 Oct 2023 08:48:25 +0000 (UTC)
Date: Wed, 25 Oct 2023 09:48:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 06/29] migration: Add auto-pause capability
Message-ID: <ZTjWV9wQ5obKTpOG@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023203608.26370-7-farosas@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 23, 2023 at 05:35:45PM -0300, Fabiano Rosas wrote:
> Add a capability that allows the management layer to delegate to QEMU
> the decision of whether to pause a VM and perform a non-live
> migration. Depending on the type of migration being performed, this
> could bring performance benefits.

I'm not really see what problem this is solving.

Mgmt apps are perfectly capable of pausing the VM before issuing
the migrate operation.

IMHO changing the default pause behaviour when certain migration
capabilties are set creates an unneccessary suprise for mgmt
apps. Having to then also add an extra capability to turn off
this new feature just adds to the migration maint burden.

> 
> Note that the capability is enabled by default but at this moment no
> migration scheme is making use of it.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 19 +++++++++++++++++++
>  migration/options.c   |  9 +++++++++
>  migration/options.h   |  1 +
>  qapi/migration.json   |  6 +++++-
>  4 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index a6efbd837a..8b0c3b0911 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -124,6 +124,20 @@ migration_channels_and_uri_compatible(const char *uri, Error **errp)
>      return true;
>  }
>  
> +static bool migration_should_pause(const char *uri)
> +{
> +    if (!migrate_auto_pause()) {
> +        return false;
> +    }
> +
> +    /*
> +     * Return true for migration schemes that benefit from a nonlive
> +     * migration.
> +     */
> +
> +    return false;
> +}
> +
>  static gint page_request_addr_cmp(gconstpointer ap, gconstpointer bp)
>  {
>      uintptr_t a = (uintptr_t) ap, b = (uintptr_t) bp;
> @@ -1724,6 +1738,11 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>          }
>      }
>  
> +    if (migration_should_pause(uri)) {
> +        global_state_store();
> +        vm_stop_force_state(RUN_STATE_PAUSED);
> +    }
> +
>      if (strstart(uri, "tcp:", &p) ||
>          strstart(uri, "unix:", NULL) ||
>          strstart(uri, "vsock:", NULL)) {
> diff --git a/migration/options.c b/migration/options.c
> index 42fb818956..c3def757fe 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -200,6 +200,8 @@ Property migration_properties[] = {
>      DEFINE_PROP_MIG_CAP("x-switchover-ack",
>                          MIGRATION_CAPABILITY_SWITCHOVER_ACK),
>      DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LIMIT),
> +    DEFINE_PROP_BOOL("x-auto-pause", MigrationState,
> +                     capabilities[MIGRATION_CAPABILITY_AUTO_PAUSE], true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -210,6 +212,13 @@ bool migrate_auto_converge(void)
>      return s->capabilities[MIGRATION_CAPABILITY_AUTO_CONVERGE];
>  }
>  
> +bool migrate_auto_pause(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    return s->capabilities[MIGRATION_CAPABILITY_AUTO_PAUSE];
> +}
> +
>  bool migrate_background_snapshot(void)
>  {
>      MigrationState *s = migrate_get_current();
> diff --git a/migration/options.h b/migration/options.h
> index 237f2d6b4a..d1ba5c9de7 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -24,6 +24,7 @@ extern Property migration_properties[];
>  /* capabilities */
>  
>  bool migrate_auto_converge(void);
> +bool migrate_auto_pause(void);
>  bool migrate_background_snapshot(void);
>  bool migrate_block(void);
>  bool migrate_colo(void);
> diff --git a/qapi/migration.json b/qapi/migration.json
> index db3df12d6c..74f12adc0e 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -523,6 +523,10 @@
>  #     and can result in more stable read performance.  Requires KVM
>  #     with accelerator property "dirty-ring-size" set.  (Since 8.1)
>  #
> +# @auto-pause: If enabled, allows QEMU to decide whether to pause the
> +#     VM before migration for an optimal migration performance.
> +#     Enabled by default. (since 8.1)
> +#
>  # Features:
>  #
>  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
> @@ -539,7 +543,7 @@
>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>             'validate-uuid', 'background-snapshot',
>             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
> -           'dirty-limit'] }
> +           'dirty-limit', 'auto-pause'] }
>  
>  ##
>  # @MigrationCapabilityStatus:
> -- 
> 2.35.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


