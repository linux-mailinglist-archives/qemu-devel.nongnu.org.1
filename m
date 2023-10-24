Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1477D470E
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 07:51:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvAJN-0008Rp-M6; Tue, 24 Oct 2023 01:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvAJJ-0008Rc-7j
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 01:50:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvAJH-0004UT-Ke
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 01:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698126634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hh3mPb9bmkRfTxUy5OW7cKNPsXGV10TrIrYcTTqizOg=;
 b=F3f44FT7fvsZoAzOqAkM8cO2Tnm3CmNVko0pNGCxgs/jNS+3Vkze/NG9RlIwiSOklVNygI
 spuNOYZZqfz9geLFbZISN25pCOhsU4Cm/B0JwulWdiaZVu5aMe4AaBj2VyqkxOhXhYDUym
 5EKZNVTdAjPMEN6KCyPB9cdoeczmirU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-G2SiljlKNM2IvjUWb05E8w-1; Tue,
 24 Oct 2023 01:50:20 -0400
X-MC-Unique: G2SiljlKNM2IvjUWb05E8w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66F361C05AED;
 Tue, 24 Oct 2023 05:50:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3ED9A2166B26;
 Tue, 24 Oct 2023 05:50:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 35FC821E6A1F; Tue, 24 Oct 2023 07:50:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  dgilbert@redhat.com,
 pbonzini@redhat.com,  berrange@redhat.com,  eblake@redhat.com,
 manish.mishra@nutanix.com,  aravind.retnakaran@nutanix.com,  Het Gala
 <het.gala@nutanix.com>,  Juan Quintela <quintela@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v15 02/14] fixup! migration: New QAPI type 'MigrateAddress'
References: <20231023182053.8711-1-farosas@suse.de>
 <20231023182053.8711-3-farosas@suse.de>
Date: Tue, 24 Oct 2023 07:50:19 +0200
In-Reply-To: <20231023182053.8711-3-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 23 Oct 2023 15:20:41 -0300")
Message-ID: <8734y0vaas.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> writes:

> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qapi/migration.json | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index c352c7ac52..abebe23523 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1519,10 +1519,25 @@
>  #
>  # @rdma: Migrate via RDMA.
>  #
> +# @file: Direct the migration stream to a file.
> +#
>  # Since 8.2
>  ##
>  { 'enum': 'MigrationAddressType',
> -  'data': ['socket', 'exec', 'rdma'] }
> +  'data': [ 'socket', 'exec', 'rdma', 'file' ] }
> +
> +##
> +# @FileMigrationArgs:
> +#
> +# @filename: The file to receive the migration stream
> +#
> +# @offset: The file offset where the migration stream will start
> +#
> +# Since 8.2
> +##
> +{ 'struct': 'FileMigrationArgs',
> +  'data': { 'filename': 'str',
> +            'offset': 'uint64' } }

Have you considered making @offset optional, default 0?  This is *not* a
demand!

>=20=20
>  ##
>  # @MigrationExecCommand:
> @@ -1547,7 +1562,8 @@
>    'data': {
>      'socket': 'SocketAddress',
>      'exec': 'MigrationExecCommand',
> -    'rdma': 'InetSocketAddress' } }
> +    'rdma': 'InetSocketAddress',
> +    'file': 'FileMigrationArgs' } }
>=20=20
>  ##
>  # @migrate:

Acked-by: Markus Armbruster <armbru@redhat.com>


