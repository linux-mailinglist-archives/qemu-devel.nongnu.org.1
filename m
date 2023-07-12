Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B92FF750936
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 15:05:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJZVf-00013h-UI; Wed, 12 Jul 2023 09:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qJZVd-00013L-PU
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 09:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qJZVb-0001FU-LV
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 09:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689167034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=upP2pwEd28KjCddrMkkk5gOsRZ3ukcGO4ODfZs0mZ/g=;
 b=df+14+bt7MoPqARaqr2tz/buo2v4KnbH2cg7quWwkuNewbzAWutgdpXpG2p0M6mB8Cqvsh
 /eiJklPa+lkpw/OxAaNpkxRo67F8OuUAvI9Q2T1Se/b16G1RwQifEzRZDHmU5PoTN9tepa
 slslHIoay1DvuX9FBhYQ/rF5CghB808=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-PqvLn7WJOLu3PJhUMr_EtQ-1; Wed, 12 Jul 2023 09:03:53 -0400
X-MC-Unique: PqvLn7WJOLu3PJhUMr_EtQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FFBE3C13945;
 Wed, 12 Jul 2023 13:03:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1139540C206F;
 Wed, 12 Jul 2023 13:03:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0946221E6A1F; Wed, 12 Jul 2023 15:03:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  quintela@redhat.com,
 dgilbert@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v7 6/9] migration: modified migration QAPIs to accept
 'channels' argument for migration
References: <20230710122750.69194-1-het.gala@nutanix.com>
 <20230710122750.69194-7-het.gala@nutanix.com>
Date: Wed, 12 Jul 2023 15:03:51 +0200
In-Reply-To: <20230710122750.69194-7-het.gala@nutanix.com> (Het Gala's message
 of "Mon, 10 Jul 2023 12:27:47 +0000")
Message-ID: <87y1jlp9hk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The subject

    migration: modified migration QAPIs to accept 'channels' argument for migration

is rather long.  Try to limit subjects to about 60 characters.  Easily
done here:

    migration: New migrate and migrate-incoming argument 'channels'

Het Gala <het.gala@nutanix.com> writes:

> MigrateChannelList allows to connect accross multiple interfaces. Added
> MigrateChannelList struct as argument to migration QAPIs.


We prefer imperative mood for describing a change in a commit message:
"Add MigrateChannelList argument ..."

> Future patchset series plans to include multiple MigrateChannels
> for multiple interfaces to be connected. That is the reason,
> 'MigrateChannelList'
> is the preferred choice of argument over 'MigrateChannel' and making
> migration QAPIs future proof.

If you need to respin, please reflow the paragraph like this:

  Future patchset series plans to include multiple MigrateChannels for
  multiple interfaces to be connected.  That is the reason
  'MigrateChannelList' is the preferred choice of argument over
  'MigrateChannel' and making migration QAPIs future proof.

Or less wordy:

  We plan to support multiple channels in the future, so multiple
  interfaces can be connected.  This is why we make the new argument a
  MigrateChannelList instead of a MigrateChannel.

> For current patchset series, have limited the size of the list to single
> element (single interface) as runtime check.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>  migration/migration-hmp-cmds.c |  16 +++--
>  migration/migration.c          |  34 ++++++++--
>  qapi/migration.json            | 109 ++++++++++++++++++++++++++++++++-
>  softmmu/vl.c                   |   2 +-
>  4 files changed, 147 insertions(+), 14 deletions(-)
>
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 9885d7c9f7..5f04598202 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -423,10 +423,12 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
>  {
>      Error *err = NULL;
>      const char *uri = qdict_get_str(qdict, "uri");
> +    MigrationChannelList *caps = NULL;
> +    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
>  
> -    qmp_migrate_incoming(uri, &err);
> -
> -    hmp_handle_error(mon, err);
> +    QAPI_LIST_PREPEND(caps, channel);
> +    qmp_migrate_incoming(uri, false, caps, &err);
> +    qapi_free_MigrationChannelList(caps);
>  }
>  
>  void hmp_migrate_recover(Monitor *mon, const QDict *qdict)
> @@ -704,9 +706,13 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>      bool resume = qdict_get_try_bool(qdict, "resume", false);
>      const char *uri = qdict_get_str(qdict, "uri");
>      Error *err = NULL;
> +    MigrationChannelList *caps = NULL;
> +    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
>  
> -    qmp_migrate(uri, !!blk, blk, !!inc, inc,
> -                false, false, true, resume, &err);
> +    QAPI_LIST_PREPEND(caps, channel);
> +    qmp_migrate(uri, false, caps, !!blk, blk, !!inc, inc,
> +                 false, false, true, resume, &err);
> +    qapi_free_MigrationChannelList(caps);
>      if (hmp_handle_error(mon, err)) {
>          return;
>      }
> diff --git a/migration/migration.c b/migration/migration.c
> index 52e2ec3502..65272ef739 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -465,10 +465,22 @@ static bool migrate_uri_parse(const char *uri,
>      return true;
>  }
>  
> -static void qemu_start_incoming_migration(const char *uri, Error **errp)
> +static void qemu_start_incoming_migration(const char *uri, bool has_channels,
> +                                          MigrationChannelList *channels,
> +                                          Error **errp)
>  {
>      g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
>  
> +    /*
> +     * Having preliminary checks for uri and channel
> +     */
> +    if (uri && has_channels) {
> +        error_setg(errp, "'uri' and 'channels' arguments are mutually "
> +                   "exclusive; exactly one of the two should be present in "
> +                   "'migrate-incoming' qmp command ");
> +        return;
> +    }
> +
>      /* URI is not suitable for migration? */
>      if (!migration_channels_and_uri_compatible(uri, errp)) {
>          return;
> @@ -1496,7 +1508,8 @@ void migrate_del_blocker(Error *reason)
>      migration_blockers = g_slist_remove(migration_blockers, reason);
>  }
>  
> -void qmp_migrate_incoming(const char *uri, Error **errp)
> +void qmp_migrate_incoming(const char *uri, bool has_channels,
> +                          MigrationChannelList *channels, Error **errp)
>  {
>      Error *local_err = NULL;
>      static bool once = true;
> @@ -1514,7 +1527,7 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
>          return;
>      }
>  
> -    qemu_start_incoming_migration(uri, &local_err);
> +    qemu_start_incoming_migration(uri, has_channels, channels, &local_err);
>  
>      if (local_err) {
>          yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> @@ -1550,7 +1563,7 @@ void qmp_migrate_recover(const char *uri, Error **errp)
>       * only re-setup the migration stream and poke existing migration
>       * to continue using that newly established channel.
>       */
> -    qemu_start_incoming_migration(uri, errp);
> +    qemu_start_incoming_migration(uri, false, NULL, errp);
>  }
>  
>  void qmp_migrate_pause(Error **errp)
> @@ -1684,7 +1697,8 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
>      return true;
>  }
>  
> -void qmp_migrate(const char *uri, bool has_blk, bool blk,
> +void qmp_migrate(const char *uri, bool has_channels,
> +                 MigrationChannelList *channels, bool has_blk, bool blk,
>                   bool has_inc, bool inc, bool has_detach, bool detach,
>                   bool has_resume, bool resume, Error **errp)
>  {
> @@ -1693,6 +1707,16 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>      MigrationState *s = migrate_get_current();
>      g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
>  
> +    /*
> +     * Having preliminary checks for uri and channel
> +     */
> +    if (uri && has_channels) {
> +        error_setg(errp, "'uri' and 'channels' arguments are mutually "
> +                   "exclusive; exactly one of the two should be present in "
> +                   "'migrate' qmp command ");
> +        return;
> +    }
> +
>      /* URI is not suitable for migration? */
>      if (!migration_channels_and_uri_compatible(uri, errp)) {
>          return;
> diff --git a/qapi/migration.json b/qapi/migration.json
> index b583642c2d..239affdc34 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1458,6 +1458,34 @@
>      'exec': 'MigrationExecCommand',
>      'rdma': 'InetSocketAddress' } }
>  
> +##
> +# @MigrationChannelType:
> +#
> +# The migration channel-type request options.
> +#
> +# @main: Main outbound migration channel.
> +#
> +# Since 8.1
> +##
> +{ 'enum': 'MigrationChannelType',
> +  'data': [ 'main' ] }
> +
> +##
> +# @MigrationChannel:
> +#
> +# Migration stream channel parameters.
> +#
> +# @channel-type: Channel type for transfering packet information.
> +#
> +# @addr: Migration endpoint configuration on destination interface.
> +#
> +# Since 8.1
> +##
> +{ 'struct': 'MigrationChannel',
> +  'data': {
> +      'channel-type': 'MigrationChannelType',
> +      'addr': 'MigrationAddress' } }
> +
>  ##
>  # @migrate:
>  #
> @@ -1465,6 +1493,9 @@
>  #
>  # @uri: the Uniform Resource Identifier of the destination VM
>  #
> +# @channels: list of migration stream channels with each stream
> +#     in the list connected to a destination interface endpoint.

Formatting is acceptable as is, but if you need to respin, tweak it like
this:

   # @channels: list of migration stream channels with each stream in the
   #     list connected to a destination interface endpoint.

> +#
>  # @blk: do block migration (full disk copy)
>  #
>  # @inc: incremental disk copy migration
> @@ -1489,14 +1520,50 @@
>  # 3. The user Monitor's "detach" argument is invalid in QMP and should
>  #    not be used
>  #
> +# 4. The uri argument should have the Uniform Resource Identifier of
> +#    default destination VM. This connection will be bound to default
> +#    network.
> +#
> +# 5. For now, number of migration streams is restricted to one, i.e
> +#    number of items in 'channels' list is just 1.
> +#
> +# 6. The 'uri' and 'channels' arguments are mutually exclusive;
> +#    exactly one of the two should be present.
> +#
>  # Example:
>  #
>  # -> { "execute": "migrate", "arguments": { "uri": "tcp:0:4446" } }
>  # <- { "return": {} }
> +# -> { "execute": "migrate",
> +#      "arguments": {
> +#          "channels": [ { "channel-type": "main",
> +#                          "addr": { "transport": "socket",
> +#                                    "type": "inet",
> +#                                    "host": "10.12.34.9",
> +#                                    "port": "1050" } } ] } }
> +# <- { "return": {} }
> +#
> +# -> { "execute": "migrate",
> +#      "arguments": {
> +#          "channels": [ { "channel-type": "main",
> +#                          "addr": { "transport": "exec",
> +#                                    "args": [ "/bin/nc", "-p", "6000",
> +#                                              "/some/sock" ] } } ] } }
> +# <- { "return": {} }
> +#
> +# -> { "execute": "migrate",
> +#      "arguments": {
> +#          "channels": [ { "channel-type": "main",
> +#                          "addr": { "transport": "rdma",
> +#                                    "host": "10.12.34.9",
> +#                                    "port": "1050" } } ] } }
> +# <- { "return": {} }
> +#
>  ##
>  { 'command': 'migrate',
> -  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool',
> -           '*detach': 'bool', '*resume': 'bool' } }
> +  'data': {'*uri': 'str', '*channels': [ 'MigrationChannel' ],
> +           '*blk': 'bool', '*inc': 'bool', '*detach': 'bool',
> +           '*resume': 'bool' } }
>  
>  ##
>  # @migrate-incoming:
> @@ -1507,6 +1574,9 @@
>  # @uri: The Uniform Resource Identifier identifying the source or
>  #     address to listen on
>  #
> +# @channels: list of migration stream channels with each stream
> +#     in the list connected to a destination interface endpoint.

   # @channels: list of migration stream channels with each stream in the
   #     list connected to a destination interface endpoint.

Likewise.

> +#
>  # Returns: nothing on success
>  #
>  # Since: 2.3
> @@ -1522,13 +1592,46 @@
>  #
>  # 3. The uri format is the same as for -incoming
>  #
> +# 5. For now, number of migration streams is restricted to one, i.e
> +#    number of items in 'channels' list is just 1.
> +#
> +# 4. The 'uri' and 'channels' arguments are mutually exclusive;
> +#    exactly one of the two should be present.
> +#
>  # Example:
>  #
>  # -> { "execute": "migrate-incoming",
>  #      "arguments": { "uri": "tcp::4446" } }
>  # <- { "return": {} }
> +#
> +# -> { "execute": "migrate",
> +#      "arguments": {
> +#          "channels": [ { "channel-type": "main",
> +#                          "addr": { "transport": "socket",
> +#                                    "type": "inet",
> +#                                    "host": "10.12.34.9",
> +#                                    "port": "1050" } } ] } }
> +# <- { "return": {} }
> +#
> +# -> { "execute": "migrate",
> +#      "arguments": {
> +#          "channels": [ { "channel-type": "main",
> +#                          "addr": { "transport": "exec",
> +#                                    "args": [ "/bin/nc", "-p", "6000",
> +#                                              "/some/sock" ] } } ] } }
> +# <- { "return": {} }
> +#
> +# -> { "execute": "migrate",
> +#      "arguments": {
> +#          "channels": [ { "channel-type": "main",
> +#                          "addr": { "transport": "rdma",
> +#                                    "host": "10.12.34.9",
> +#                                    "port": "1050" } } ] } }
> +# <- { "return": {} }
>  ##
> -{ 'command': 'migrate-incoming', 'data': {'uri': 'str' } }
> +{ 'command': 'migrate-incoming',
> +             'data': {'*uri': 'str',
> +                      '*channels': [ 'MigrationChannel' ] } }
>  
>  ##
>  # @xen-save-devices-state:
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index b0b96f67fa..d811f3f878 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -2651,7 +2651,7 @@ void qmp_x_exit_preconfig(Error **errp)
>      if (incoming) {
>          Error *local_err = NULL;
>          if (strcmp(incoming, "defer") != 0) {
> -            qmp_migrate_incoming(incoming, &local_err);
> +            qmp_migrate_incoming(incoming, false, NULL, &local_err);
>              if (local_err) {
>                  error_reportf_err(local_err, "-incoming %s: ", incoming);
>                  exit(1);

The issues I'm pointing out don't justfy yet another respin.  But if you
need to respin the series for some other reason, plase take care of them.

Acked-by: Markus Armbruster <armbru@redhat.com>


