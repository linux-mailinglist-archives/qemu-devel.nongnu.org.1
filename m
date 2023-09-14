Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC027A0FB0
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 23:18:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtj4-0001MO-Ji; Thu, 14 Sep 2023 17:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qgtj3-0001Ll-5v
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 17:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qgtj1-00079C-LB
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 17:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694726289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bw8IvthquNmtaifvk7xOxFmKqjJYU4eaCq+QH6FJ5W0=;
 b=PwXUu1WYhupKcHTWazPmRV0Ro4dzvBA8or/IQg3dddaMPhSdUW44F0580xiEMbVczVLyql
 2Pxkf6WnSQ3HNeVjaU1lzXQRSjOG04CghRWHE7mz1NTPFsdQjmXcH23AaNsAxUi0YeI7lt
 L1OwuwWQnvWbKJ7s6KxNFSwquS9rQfY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-x-m5n8pWOoCzUpJkDT3UpQ-1; Thu, 14 Sep 2023 17:18:05 -0400
X-MC-Unique: x-m5n8pWOoCzUpJkDT3UpQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 715FB101F7A3;
 Thu, 14 Sep 2023 21:17:55 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BD2A21B20B1;
 Thu, 14 Sep 2023 21:17:54 +0000 (UTC)
Date: Thu, 14 Sep 2023 16:17:52 -0500
From: Eric Blake <eblake@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com, 
 kwolf@redhat.com, fam@euphon.net, vsementsov@yandex-team.ru, den@virtuozzo.com
Subject: Re: [PATCH v3 2/2] qemu-img: map: report compressed data blocks
Message-ID: <b6yyul657xkv3usgp7vrczy6r5xssbhmzfgftvrp2srlnct7gt@ja5barlss2kh>
References: <20230907210226.953821-1-andrey.drobyshev@virtuozzo.com>
 <20230907210226.953821-3-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907210226.953821-3-andrey.drobyshev@virtuozzo.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Sep 08, 2023 at 12:02:26AM +0300, Andrey Drobyshev wrote:
> Right now "qemu-img map" reports compressed blocks as containing data
> but having no host offset.  This is not very informative.  Instead,
> let's add another boolean field named "compressed" in case JSON output
> mode is specified.  This is achieved by utilizing new allocation status
> flag BDRV_BLOCK_COMPRESSED for bdrv_block_status().
> 
> Also update the expected qemu-iotests outputs to contain the new field.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---

> +++ b/qapi/block-core.json
> @@ -409,6 +409,9 @@
>  #
>  # @zero: whether the virtual blocks read as zeroes
>  #
> +# @compressed: true indicates that data is stored compressed.  Only valid
> +#     for the formats whith support compression (since 8.2)

s/whith/which/

"compressed":false seems universally valid for all other file formats,
and the field is not marked as optional.  Do we really need the
disclaimer?  Could we get by with the shorter 'Will be false for
formats that do not support compression', or by omitting it
altogether?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


