Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 521F57383FD
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 14:41:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBx8s-0007I7-FY; Wed, 21 Jun 2023 08:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qBx8q-0007Hx-Ez
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:40:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qBx8n-00035I-QX
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687351252;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=73RxGw3IB95tCE5EObcvhkXsjIS2fPCz3K5oGcbxgTQ=;
 b=iBUsCkFLpTLiHkQY7Cw3SF3aozMrwpZCRMqOPa2bj4N4rkqwKC8NHIKBaSwu8MuppHndNn
 M+XOUv9/EVc6QO28ByUXYQokuDQgGczgpg62l/edPV0dEYxQptYZ97Xiw3rK636pV0TVsU
 w1Ct0bbT+32puYbdZPiX37RgUQ1gycs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-TNvtHzQ5PBW7lyesnM4CQQ-1; Wed, 21 Jun 2023 08:40:50 -0400
X-MC-Unique: TNvtHzQ5PBW7lyesnM4CQQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D7A9104458F;
 Wed, 21 Jun 2023 12:40:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4FB6200C0DA;
 Wed, 21 Jun 2023 12:40:48 +0000 (UTC)
Date: Wed, 21 Jun 2023 13:40:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH V2] migration: file URI
Message-ID: <ZJLvzl+CBCwwXZxJ@redhat.com>
References: <1686163139-256654-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1686163139-256654-1-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 07, 2023 at 11:38:59AM -0700, Steve Sistare wrote:
> Extend the migration URI to support file:<filename>.  This can be used for
> any migration scenario that does not require a reverse path.  It can be used
> as an alternative to 'exec:cat > file' in minimized containers that do not
> contain /bin/sh, and it is easier to use than the fd:<fdname> URI.  It can
> be used in HMP commands, and as a qemu command-line parameter.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

> diff --git a/qemu-options.hx b/qemu-options.hx
> index b37eb96..b93449d 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4610,6 +4610,7 @@ DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
>      "                prepare for incoming migration, listen on\n" \
>      "                specified protocol and socket address\n" \
>      "-incoming fd:fd\n" \
> +    "-incoming file:filename\n" \
>      "-incoming exec:cmdline\n" \
>      "                accept incoming migration on given file descriptor\n" \
>      "                or from given external command\n" \
> @@ -4626,7 +4627,10 @@ SRST
>      Prepare for incoming migration, listen on a given unix socket.
>  
>  ``-incoming fd:fd``
> -    Accept incoming migration from a given filedescriptor.
> +    Accept incoming migration from a given file descriptor.
> +
> +``-incoming file:filename``
> +    Accept incoming migration from a given file.

To be usable for libvirt we need to support an offset

   -incoming file:filename,offset=NNNN

because for save/restore to disk,libvirt stores its own header and XML
document in front of the QEMU save state, and we need to be able to
tell QEMU to leave space (on save) or skip over it (on restore).

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


