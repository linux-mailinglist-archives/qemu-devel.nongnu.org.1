Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D212A7D077E
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 07:07:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qthiU-0003yT-Rg; Fri, 20 Oct 2023 01:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qthiS-0003y0-3E
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 01:06:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qthiQ-0007Ry-Hx
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 01:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697778389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hYFSpNc/22pvdQd4DuLOvG6VT1KzHoIAhPOocUUc4PY=;
 b=Cp0AT4sYHh+RA0ldQMw09l98lL8KL6Ix9SrGo9oypEKGe1Cs1Uv4b+U8CXfG/PSYDPJKbd
 xObjB7asBhG3vBngD5Xsm8l6CDvwqsShJpo4BkfqTEYsPqYdaYpu1CFB5RzP126QxJXEIT
 y2cJ5k4oBpzPf+f0XfiPrrN6RrxMNNQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-odSH73ENPfqvb78em1rsTA-1; Fri, 20 Oct 2023 01:06:23 -0400
X-MC-Unique: odSH73ENPfqvb78em1rsTA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2793E811764;
 Fri, 20 Oct 2023 05:06:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01A622166B26;
 Fri, 20 Oct 2023 05:06:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E47A621E6A1F; Fri, 20 Oct 2023 07:06:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  dgilbert@redhat.com,
 pbonzini@redhat.com,  berrange@redhat.com,  eblake@redhat.com,
 manish.mishra@nutanix.com,  aravind.retnakaran@nutanix.com,  Het Gala
 <het.gala@nutanix.com>,  Juan Quintela <quintela@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v14 02/14] fixup! migration: New QAPI type 'MigrateAddress'
References: <20231019192353.31500-1-farosas@suse.de>
 <20231019192353.31500-3-farosas@suse.de>
Date: Fri, 20 Oct 2023 07:06:21 +0200
In-Reply-To: <20231019192353.31500-3-farosas@suse.de> (Fabiano Rosas's message
 of "Thu, 19 Oct 2023 16:23:41 -0300")
Message-ID: <87y1fxc27m.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
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
> ---
>  qapi/migration.json | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index c352c7ac52..602cb706e3 100644
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
> +  'data': ['socket', 'exec', 'rdma', 'file'] }

I don't like our use of spaces around parenthesis in the QAPI schema,
but I like inconsistency even less: please insert a space after '['.

> +
> +##
> +# @FileMigrationArgs:
> +#
> +# @path: file path

Name this @filename for local consistency.  We use both @filename and
@path for filenames in the schema, which is sad.  However,
migration.json uses only @filename so far.  Let's keep it that way.

"file path" is awfully terse.  Maybe "file to receive the migration
stream"?

> +#
> +# @offset: initial offset for the file

Again, too terse.  How is @offset to be used?  Start writing at this
file offset?

> +#
> +# Since 8.2
> +##
> +{ 'struct': 'FileMigrationArgs',
> +  'data': {'path': 'str',

Please insert a space after '{', and reindent the next line.

> +           'offset': 'uint64' } }
>  
>  ##
>  # @MigrationExecCommand:
> @@ -1547,7 +1562,8 @@
>    'data': {
>      'socket': 'SocketAddress',
>      'exec': 'MigrationExecCommand',
> -    'rdma': 'InetSocketAddress' } }
> +    'rdma': 'InetSocketAddress',
> +    'file': 'FileMigrationArgs' } }
>  
>  ##
>  # @migrate:


