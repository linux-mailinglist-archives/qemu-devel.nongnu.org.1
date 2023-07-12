Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3AC7508E6
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 14:56:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJZNf-0006Vs-AL; Wed, 12 Jul 2023 08:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qJZNa-0006UW-AP
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 08:55:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qJZNX-0006nu-6a
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 08:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689166529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7k7jprat6K8tAjQ24m8TYG8iaXo3Wi7gPCY03hd0asY=;
 b=W8VMIqdaLEYmxlIgZIfJSB+kz5sTDFlEw6/KjUieD8Vc62fTg+/LaeoZgOduONEsTYvqQM
 8B9lffC+F6pNoYmS3X0lP3C1JeNV0wWmv9jw9qNP83DfhEi5W77ncVSFYExNU/hkpc84eS
 3zZhJ8hFqOOKkxwmye1wrna2nR2Kbfo=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-8ZU3J-HsOQaGV0vJgtetuQ-1; Wed, 12 Jul 2023 08:55:26 -0400
X-MC-Unique: 8ZU3J-HsOQaGV0vJgtetuQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D054838117E8;
 Wed, 12 Jul 2023 12:55:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACEC9200B415;
 Wed, 12 Jul 2023 12:55:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 973E721E6A1F; Wed, 12 Jul 2023 14:55:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  quintela@redhat.com,
 dgilbert@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v7 1/9] migration: introduced 'MigrateAddress' in QAPI
 for migration wire protocol.
References: <20230710122750.69194-1-het.gala@nutanix.com>
 <20230710122750.69194-2-het.gala@nutanix.com>
Date: Wed, 12 Jul 2023 14:55:24 +0200
In-Reply-To: <20230710122750.69194-2-het.gala@nutanix.com> (Het Gala's message
 of "Mon, 10 Jul 2023 12:27:42 +0000")
Message-ID: <878rblqog3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

    migration: introduced 'MigrateAddress' in QAPI for migration wire proto=
col.

is rather long.  Try to limit subjects to about 60 characters.  Easily
done here:

    migration: New QAPI type 'MigrateAddress'

Het Gala <het.gala@nutanix.com> writes:

> This patch introduces well defined MigrateAddress struct and its related
> child objects.
>
> The existing argument of 'migrate' and 'migrate-incoming' QAPI - 'uri'
> is of string type. The current migration flow follows double encoding
> scheme for  fetching migration parameters such as 'uri' and this is
> not an ideal design.
>
> Motive for intoducing struct level design is to prevent double encoding
> of QAPI arguments, as Qemu should be able to directly use the QAPI
> arguments without any level of encoding.

Suggest to mention that this commit only adds the type, and actual uses
come in later commits.

> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qapi/migration.json | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 47dfef0278..b583642c2d 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1417,6 +1417,47 @@
>  ##
>  { 'command': 'migrate-continue', 'data': {'state': 'MigrationStatus'} }
>=20=20
> +##
> +# @MigrationAddressType:
> +#
> +# The migration stream transport mechanisms.
> +#
> +# @socket: Migrate via socket.
> +#
> +# @exec: Direct the migration stream to another process.
> +#
> +# @rdma: Migrate via RDMA.
> +#
> +# Since 8.1
> +##
> +{ 'enum': 'MigrationAddressType',
> +  'data': ['socket', 'exec', 'rdma'] }
> +
> +##
> +# @MigrationExecCommand:
> +#
> +# @args: command (list head) and arguments to execute.
> +#
> +# Since 8.1
> +##
> +{ 'struct': 'MigrationExecCommand',
> +  'data': {'args': [ 'str' ] } }
> +
> +##
> +# @MigrationAddress:
> +#
> +# Migration endpoint configuration.
> +#
> +# Since 8.1
> +##
> +{ 'union': 'MigrationAddress',
> +  'base': { 'transport' : 'MigrationAddressType'},
> +  'discriminator': 'transport',
> +  'data': {
> +    'socket': 'SocketAddress',
> +    'exec': 'MigrationExecCommand',
> +    'rdma': 'InetSocketAddress' } }
> +
>  ##
>  # @migrate:
>  #

The issues I'm pointing out don't justfy yet another respin.  But if you
need to respin the series for some other reason, plase take care of them.

Acked-by: Markus Armbruster <armbru@redhat.com>


