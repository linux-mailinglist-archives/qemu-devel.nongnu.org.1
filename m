Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E0C759210
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 11:51:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM3q5-0004ke-T2; Wed, 19 Jul 2023 05:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qM3pz-0004kJ-Oq
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 05:51:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qM3px-00041d-Ty
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 05:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689760272;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WQS5Y66532Q1FhMCQi0G0ekBG2bZ5W04mLL4qNL/U2U=;
 b=W2i1ZGpwwscROXCtg5ZxRb4qU3CMMHuP5CtsTURiVrI9/0UsynNdkvBJy/uodttemzLan1
 pRB7MYaBsrh1pdIxOE4xFL1KGwLNOW1YtX8De2vFNfsFo1e7CTicdGxdOnA4R0HFmsMy5v
 e70HuQJLCVe+BcTSZHbrBPGKD88RXcg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175--GuCgOPCOcujl4hIzO5DVw-1; Wed, 19 Jul 2023 05:51:10 -0400
X-MC-Unique: -GuCgOPCOcujl4hIzO5DVw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4B28800D9C;
 Wed, 19 Jul 2023 09:51:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BEE3F6CD5;
 Wed, 19 Jul 2023 09:51:08 +0000 (UTC)
Date: Wed, 19 Jul 2023 10:51:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v8 1/9] migration: New QAPI type 'MigrateAddress'
Message-ID: <ZLeyChEfqJQ0N0a/@redhat.com>
References: <20230713105713.236883-1-het.gala@nutanix.com>
 <20230713105713.236883-2-het.gala@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230713105713.236883-2-het.gala@nutanix.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jul 13, 2023 at 10:57:05AM +0000, Het Gala wrote:
> This patch introduces well defined MigrateAddress struct
> and its related child objects.
> 
> The existing argument of 'migrate' and 'migrate-incoming' QAPI
> - 'uri' is of type string. The current implementation follows
> double encoding scheme for fetching migration parameters like
> 'uri' and this is not an ideal design.
> 
> Motive for intoducing struct level design is to prevent double
> encoding of QAPI arguments, as Qemu should be able to directly
> use the QAPI arguments without any level of encoding.
> 
> Note: this commit only adds the type, and actual uses comes
> in later commits.
> 
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
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
>  
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

Note we're in freeze for 8.1 now, so unfortunately this series has
missed the cut off. Update to 8.2 across all patches, next time you
post this series.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


