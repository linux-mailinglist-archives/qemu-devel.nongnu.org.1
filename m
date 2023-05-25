Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC26711277
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 19:36:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Erd-0005S0-VR; Thu, 25 May 2023 13:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2Era-0005Re-Ub
 for qemu-devel@nongnu.org; Thu, 25 May 2023 13:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2ErZ-0005Mh-5a
 for qemu-devel@nongnu.org; Thu, 25 May 2023 13:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685036095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pKXcyStX60ET+gJq/6AJRW80CvRbkKIgbklWTO9rPGA=;
 b=O0P3qoIQW8Nf5p1KZpCptdGcqEzl50ZVTdcoOZGmPtSO5aUG+q2BfZeitBPRCEWpFRu6UW
 X6gYg6wPdl2ZC7e889i6eEAwh2ph8dZOgyYYrrmlZGkzuzqJad3OAupF3oWsutnbigwjBd
 JfPIEMArUON0QXvwak+ZMS6zNppNOOE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-G8l_bTAjNBS_5M8FSjMHmA-1; Thu, 25 May 2023 13:34:53 -0400
X-MC-Unique: G8l_bTAjNBS_5M8FSjMHmA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80EE8101A53B;
 Thu, 25 May 2023 17:34:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AEA4400E118;
 Thu, 25 May 2023 17:34:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 466EA21E692E; Thu, 25 May 2023 19:34:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  quintela@redhat.com,
 dgilbert@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v5 1/9] migration: introduced 'MigrateAddress' in QAPI
 for migration wire protocol.
References: <20230519094617.7078-1-het.gala@nutanix.com>
 <20230519094617.7078-2-het.gala@nutanix.com>
Date: Thu, 25 May 2023 19:34:52 +0200
In-Reply-To: <20230519094617.7078-2-het.gala@nutanix.com> (Het Gala's message
 of "Fri, 19 May 2023 09:46:09 +0000")
Message-ID: <87sfbkjow3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

> This patch introduces well defined MigrateAddress struct and its related =
child
> objects.
>
> The existing argument of 'migrate' and 'migrate-incoming' QAPI - 'uri' is=
 of
> string type. The current migration flow follows double encoding scheme for
> fetching migration parameters such as 'uri' and this is not an ideal desi=
gn.
>
> Motive for intoducing struct level design is to prevent double encoding o=
f QAPI
> arguments, as Qemu should be able to directly use the QAPI arguments with=
out
> any level of encoding.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qapi/migration.json | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 179af0c4d8..c500744bb7 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1407,6 +1407,47 @@
>  ##
>  { 'command': 'migrate-continue', 'data': {'state': 'MigrationStatus'} }
>=20=20
> +##
> +# @MigrateTransport:

I'd prefer MigrationTransport, because "migration" is a noun, while
migrate is a verb.  Verbs are for commands.  For types we use nouns.

More of the same below, not noting it again.

Actually, I'd prefer MigrationAddressType, because it's purpose is to
serve as discriminator type in union MigrationAddress.

> +#
> +# The supported communication transport mechanisms for migration
> +#
> +# @socket: Supported communication type between two devices for migratio=
n.
> +#          Socket is able to cover all of 'tcp', 'unix', 'vsock' and
> +#          'fd' already

Migration is between hosts, not "two devices".

The second sentence confuses me.  What are you trying to say?

Also, missing period at the end.

> +#
> +# @exec: Supported communication type to redirect migration stream into =
file.
> +#
> +# @rdma: Supported communication type to redirect rdma type migration st=
ream.

What about:

   ##
   # @MigrationTransport:
   #
   # The migration stream transport mechanisms
   #
   # @socket: Migrate via socket
   #
   # @rdma: Migrate via RDMA
   #
   # @file: Direct the migration stream to a file

> +#
> +# Since 8.1
> +##
> +{ 'enum': 'MigrateTransport',
> +  'data': ['socket', 'exec', 'rdma'] }
> +
> +##
> +# @MigrateExecCommand:

Documentation of @args is missing.

> + #
> + # Since 8.1
> + ##

Unwanted indentation.

> +{ 'struct': 'MigrateExecCommand',
> +   'data': {'args': [ 'str' ] } }
> +
> +##
> +# @MigrateAddress:
> +#
> +# The options available for communication transport mechanisms for migra=
tion

Not happy with this sentence (writing good documentation is hard).

Is the address used for the destination only, or for the source as well?

If destination only, could it be used for the source at least in theory?

I'm asking because I need to understand more about intended use to be
able to suggest doc improvements.

> +#
> +# Since 8.1
> +##
> +{ 'union': 'MigrateAddress',
> +  'base': { 'transport' : 'MigrateTransport'},
> +  'discriminator': 'transport',
> +  'data': {
> +    'socket': 'SocketAddress',
> +    'exec': 'MigrateExecCommand',
> +    'rdma': 'InetSocketAddress' } }
> +

Aside: a more powerful type system would let us extend SocketAddress
with additional variants instead of wrapping it in a union.

>  ##
>  # @migrate:
>  #


