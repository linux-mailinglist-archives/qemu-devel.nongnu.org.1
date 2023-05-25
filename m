Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C357112D9
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 19:52:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2F7B-0008OJ-0u; Thu, 25 May 2023 13:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2F78-0008NK-8e
 for qemu-devel@nongnu.org; Thu, 25 May 2023 13:51:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2F76-0000OX-Av
 for qemu-devel@nongnu.org; Thu, 25 May 2023 13:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685037058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9nqijJSvPyQ5zFXrCqMw/Jo986/3sbShNMaKEKZHY34=;
 b=XIBaERBuXk+zpk10ZR02HqTss0wamGmB3i3PguUdsKOW7xIdd1tQmJVOXb8H2esqcEOMLF
 SLi2iWT1jU7iHjAE+e1uUJ9QfRqmZrn6xedWJ6+DhrgMHG2bHxYw70SfU9sWUJEYhFFnYP
 UipEUpJehf/eKCvhx6IX7N06UgUBD7k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-k5ZOKZ64MN6OTa8-DlH1dg-1; Thu, 25 May 2023 13:50:52 -0400
X-MC-Unique: k5ZOKZ64MN6OTa8-DlH1dg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E559F8032F5;
 Thu, 25 May 2023 17:50:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9931740C6CDD;
 Thu, 25 May 2023 17:50:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8B6B021E692E; Thu, 25 May 2023 19:50:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  quintela@redhat.com,
 dgilbert@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v5 6/9] migration: modified migration QAPIs to accept
 'channels' argument for migration
References: <20230519094617.7078-1-het.gala@nutanix.com>
 <20230519094617.7078-7-het.gala@nutanix.com>
Date: Thu, 25 May 2023 19:50:50 +0200
In-Reply-To: <20230519094617.7078-7-het.gala@nutanix.com> (Het Gala's message
 of "Fri, 19 May 2023 09:46:14 +0000")
Message-ID: <875y8gjo5h.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Het Gala <het.gala@nutanix.com> writes:

> MigrateChannelList allows to connect accross multiple interfaces. Added
> MigrateChannelList struct as argument to migration QAPIs.
>
> Future patchset series plans to include multiple MigrateChannels
> for multiple interfaces to be connected. That is the reason, 'MigrateChannelList'
> is the preferred choice of argument over 'MigrateChannel' and making
> migration QAPIs future proof.
>
> For current patchset series, have limited the size of the list to single
> element (single interface) as runtime check.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index c500744bb7..86bbc916d1 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1448,12 +1448,47 @@
>      'exec': 'MigrateExecCommand',
>      'rdma': 'InetSocketAddress' } }
>  
> +##
> +# @MigrateChannelType:

As mentioned in my review of PATCH 1, I prefer nouns to verbs for types,
i.e.  Migration, not Migrate.  More of the same below, not flagging it
again.

> +#
> +# The supported options for migration channel type requests
> +#
> +# @main: Support request for main outbound migration control channel
> +#
> +# Since 8.1
> +##
> +{ 'enum': 'MigrateChannelType',
> +  'data': [ 'main' ] }
> +
> +##
> +# @MigrateChannel:
> +#
> +# Information regarding migration Channel-type for transferring packets,
> +# source and corresponding destination interface for socket connection
> +# and number of multifd channels over the interface.
> +#
> +# @channeltype: Name of Channel type for transfering packet information

@channel-type, because "channeltype" is not a word.

> +#
> +# @addr: Information regarding migration parameters of destination interface

> +#
> +# Since 8.1
> +##
> +{ 'struct': 'MigrateChannel',
> +  'data': {
> +       'channeltype': 'MigrateChannelType',
> +       'addr': 'MigrateAddress' } }
> +
>  ##
>  # @migrate:
>  #
>  # Migrates the current running guest to another Virtual Machine.
>  #
>  # @uri: the Uniform Resource Identifier of the destination VM
> +#       for migration thread
> +#
> +# @channels: Struct containing list of migration channel types, with all
> +#            the information regarding destination interfaces required for
> +#            initiating a migration stream.

Please format like

   # @uri: the Uniform Resource Identifier of the destination VM for
   #     migration thread
   #
   # @channels: Struct containing list of migration channel types, with
   #     all the information regarding destination interfaces required
   #     for initiating a migration stream.

to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
to conform to current conventions).

>  #
>  # @blk: do block migration (full disk copy)
>  #
> @@ -1479,14 +1514,44 @@
>  # 3. The user Monitor's "detach" argument is invalid in QMP and should
>  #    not be used
>  #
> +# 4. The uri argument should have the Uniform Resource Identifier of default
> +#    destination VM. This connection will be bound to default network
> +#
> +# 5. The 'uri' and 'channel' arguments are mutually exclusive; exactly one
> +#    of the two should be present.
> +#

Long lines.  Better:

   # 4. The uri argument should have the Uniform Resource Identifier of
   #    default destination VM.  This connection will be bound to default
   #    network
   #
   # 5. The 'uri' and 'channel' arguments are mutually exclusive; exactly
   #    one of the two should be present.

>  # Example:
>  #
>  # -> { "execute": "migrate", "arguments": { "uri": "tcp:0:4446" } }
>  # <- { "return": {} }
> +# -> { "execute": "migrate",
> +#      "arguments": {
> +#          "channels": [ { "channeltype": "main",
> +#                          "addr": { "transport": "socket", "type": "inet",
> +#                                    "host": "10.12.34.9",
> +#                                    "port": "1050" } } ] } }
> +# <- { "return": {} }
> +#
> +# -> { "execute": "migrate",
> +#      "arguments": {
> +#          "channels": [ { "channeltype": "main",
> +#                          "addr": { "transport": "exec",
> +#                                    "args": [ "/bin/nc", "-p", "6000",
> +#                                              "/some/sock" ] } } ] } }
> +# <- { "return": {} }
> +#
> +# -> { "execute": "migrate",
> +#      "arguments": {
> +#          "channels": [ { "channeltype": "main",
> +#                          "addr": { "transport": "rdma",
> +#                                    "host": "10.12.34.9",
> +#                                    "port": "1050" } } ] } }
> +# <- { "return": {} }
> +#
>  ##
>  { 'command': 'migrate',
> -  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool',
> -           '*detach': 'bool', '*resume': 'bool' } }
> +  'data': {'*uri': 'str', '*channels': [ 'MigrateChannel' ], '*blk': 'bool',
> +           '*inc': 'bool', '*detach': 'bool', '*resume': 'bool' } }
>  
>  ##
>  # @migrate-incoming:
> @@ -1497,6 +1562,10 @@
>  # @uri: The Uniform Resource Identifier identifying the source or
>  #     address to listen on
>  #
> +# @channels: Struct containing list of migration channel types, with all
> +#            the information regarding destination interfaces required for
> +#            initiating a migration stream.
> +#

The list doesn't contain migration channel types, it contains migration
channels.

I'm not sure what you're trying to say by "with all the information ..."

What does it mean to have multiple channels?

Please format like

   # @channels: Struct containing list of migration channel types, with
   #     all the information regarding destination interfaces required
   #     for initiating a migration stream.

>  # Returns: nothing on success
>  #
>  # Since: 2.3
> @@ -1512,13 +1581,42 @@
>  #
>  # 3. The uri format is the same as for -incoming
>  #
> +# 4. The 'uri' and 'channel' arguments are mutually exclusive; exactly one
> +#    of the two should be present.
> +#

Long line.  Better:

   # 4. The 'uri' and 'channel' arguments are mutually exclusive; exactly
   #    one of the two should be present.

>  # Example:
>  #
>  # -> { "execute": "migrate-incoming",
>  #      "arguments": { "uri": "tcp::4446" } }
>  # <- { "return": {} }
> +#
> +# -> { "execute": "migrate",
> +#      "arguments": {
> +#          "channels": [ { "channeltype": "main",
> +#                          "addr": { "transport": "socket", "type": "inet",
> +#                                    "host": "10.12.34.9",
> +#                                    "port": "1050" } } ] } }
> +# <- { "return": {} }
> +#
> +# -> { "execute": "migrate",
> +#      "arguments": {
> +#          "channels": [ { "channeltype": "main",
> +#                          "addr": { "transport": "exec",
> +#                                    "args": [ "/bin/nc", "-p", "6000",
> +#                                              "/some/sock" ] } } ] } }
> +# <- { "return": {} }
> +#
> +# -> { "execute": "migrate",
> +#      "arguments": {
> +#          "channels": [ { "channeltype": "main",
> +#                          "addr": { "transport": "rdma",
> +#                                    "host": "10.12.34.9",
> +#                                    "port": "1050" } } ] } }
> +# <- { "return": {} }
>  ##
> -{ 'command': 'migrate-incoming', 'data': {'uri': 'str' } }
> +{ 'command': 'migrate-incoming',
> +             'data': {'*uri': 'str',
> +                      '*channels': [ 'MigrateChannel' ] } }
>  
>  ##
>  # @xen-save-devices-state:

The text feels cumbersome.  Writing good prose is hard, especially when
you're not a native speaker.  Eric, would you like to try your hand at
polishing this?

[...]


