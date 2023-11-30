Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D707FFB37
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 20:25:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8meE-0005Ql-B1; Thu, 30 Nov 2023 14:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r8meB-0005Qd-JW
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 14:24:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r8me9-0003It-Jz
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 14:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701372265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qiTcE6EU08wHka11o1eRTnjhASTCyNBzW6O8qPaxEJo=;
 b=dbuChA0AjYTjmTHBusFv/LR8eHYXgOLN842dm36qPK5YC83ARh3vY4dzOVH8Kp59vAqpHe
 4Tqi9PJz2bBZa4D/2Mc0JMWLV/0tguQUWdyBhphc/v4BjQkAvInxL6Pxf4g8Kq/0U0UrbK
 NHGw2qtRafyNQLzTpzkpy9duh365FIg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-e5BHyGdoP_a6YnvffYrxzw-1; Thu, 30 Nov 2023 14:24:21 -0500
X-MC-Unique: e5BHyGdoP_a6YnvffYrxzw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B281101A550;
 Thu, 30 Nov 2023 19:24:21 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.190])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C39940C6EB9;
 Thu, 30 Nov 2023 19:24:20 +0000 (UTC)
Date: Thu, 30 Nov 2023 13:24:18 -0600
From: Eric Blake <eblake@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 1/2] block: commit: Allow users to request only format
 driver names in backing file format
Message-ID: <glhxou7nm34iouz4df4vz7hatzkziom3l5ba6cvdo4q5zvrayz@6hqdwepwqq5i>
References: <cover.1701360249.git.pkrempa@redhat.com>
 <2062cb544eab1a3ac785de65fd8c9b2a3f0265dc.1701360249.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2062cb544eab1a3ac785de65fd8c9b2a3f0265dc.1701360249.git.pkrempa@redhat.com>
User-Agent: NeoMutt/20231103
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Nov 30, 2023 at 05:06:03PM +0100, Peter Krempa wrote:
> Introduce a new flag 'backing_file_format_no_protocol' for the
> block-commit QMP command which instructs the internals to use 'raw'
> instead of the protocol driver in case when a image is used without a
> dummy 'raw' wrapper.
> 
> The flag is designed such that it can be always asserted by management
> tools even when there isn't any update to backing files.
> 
> The flag will be used by libvirt so that the backing images still
> reference the proper format even when libvirt will stop using the dummy
> raw driver (raw driver with no other config). Libvirt needs this so that
> the images stay compatible with older libvirt versions which didn't
> expect that a protocol driver name can appear in the backing file format
> field.
> 
> Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---

> +++ b/qapi/block-core.json
> @@ -1810,6 +1810,14 @@
>  #     Care should be taken when specifying the string, to specify a
>  #     valid filename or protocol.  (Since 2.1)
>  #
> +# @backing-file-format-no-protocol: If true always use a 'format' driver name
> +#     for the 'backing file format' field if updating the image header of the
> +#     overlay of 'top'. Otherwise the real name of the driver of the backing
> +#     image may be used which may be a protocol driver.
> +#
> +#     Can be used also when no image header will be updated.
> +#     (default: false; since: 9.0)

This is a long name.  What about:

@backing-mask-protocol: If true, replace any protocol mentioned in the
    'backing file format' with 'raw', rather than storing the protocol
    name as the backing format.  Can be used even when no image header
    will be updated (default false; since 9.0).

or s/mask/hide/ if that sounds better.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


