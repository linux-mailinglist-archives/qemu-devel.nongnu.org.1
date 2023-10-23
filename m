Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 722987D35F1
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 13:57:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qutYg-0002fw-T4; Mon, 23 Oct 2023 07:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qutYe-0002fa-GD
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 07:57:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qutYc-0000CI-P3
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 07:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698062237;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BDB/gXxzzwJsTAsTIFGyOrRNsSzMxZlGzArJMd2rbCE=;
 b=JiBkZ2ex5jriXBTm0Jj7AGkhsAJrSVKA5dlanEPH4bVBpkehTFhfcXd9fTcg8jpzf7+v56
 yMVTnL/QGfeu3Aec+aslyTxCW7O6AlSOPbTsmwXpvMWhhVjRoZ9A80S00RkWui5AHKqb6O
 D69uYBoD0lk/5y3Rw648/3Ui3j6biUE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-DOW1coPXN_-NOvTZzpozOw-1; Mon, 23 Oct 2023 07:57:04 -0400
X-MC-Unique: DOW1coPXN_-NOvTZzpozOw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F9D180F926;
 Mon, 23 Oct 2023 11:57:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC5821C060AE;
 Mon, 23 Oct 2023 11:57:01 +0000 (UTC)
Date: Mon, 23 Oct 2023 12:56:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, dgilbert@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 manish.mishra@nutanix.com, aravind.retnakaran@nutanix.com,
 Het Gala <het.gala@nutanix.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v14 02/14] fixup! migration: New QAPI type 'MigrateAddress'
Message-ID: <ZTZfhmV+qjJi5wL6@redhat.com>
References: <20231019192353.31500-1-farosas@suse.de>
 <20231019192353.31500-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231019192353.31500-3-farosas@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

On Thu, Oct 19, 2023 at 04:23:41PM -0300, Fabiano Rosas wrote:
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  qapi/migration.json | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

from a functional POV, and assuming Markus' feedback
will be included.

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
> +
> +##
> +# @FileMigrationArgs:
> +#
> +# @path: file path
> +#
> +# @offset: initial offset for the file
> +#
> +# Since 8.2
> +##
> +{ 'struct': 'FileMigrationArgs',
> +  'data': {'path': 'str',
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
> -- 
> 2.35.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


