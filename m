Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC58283CD85
	for <lists+qemu-devel@lfdr.de>; Thu, 25 Jan 2024 21:37:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT6SD-0006eF-NK; Thu, 25 Jan 2024 15:36:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rT6SB-0006ct-6x
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 15:36:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rT6S8-0007tz-RV
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 15:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706214959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hya+okKtel8vFsZ9gUw500Nnz7XOaPz4dd2R1XwHCZw=;
 b=DoqowDTU8unUqPBB+GV2KqmE7sv+TxTE0EHAJJpajhkoSWIeYkdlrr2VjrMrb613oH2cFy
 ATekyoldHpn3WMc12+5NWBEGeeaDcPqmIBsCTsc7SlKKbEzdmwsXTcg0DGK4H56aNDIeQh
 DGRWD4TJX9zk/sbHuYmNnPH7VyigvVQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-fqI03NDCOT-BRfzlUVIU_g-1; Thu,
 25 Jan 2024 15:35:55 -0500
X-MC-Unique: fqI03NDCOT-BRfzlUVIU_g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9086638212E7;
 Thu, 25 Jan 2024 20:35:54 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CD591B92;
 Thu, 25 Jan 2024 20:35:53 +0000 (UTC)
Date: Thu, 25 Jan 2024 14:35:51 -0600
From: Eric Blake <eblake@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com, 
 kwolf@redhat.com, den@virtuozzo.com
Subject: Re: [PATCH] iotests/264: Use iotests.sock_dir for socket creation
Message-ID: <c55wrjqjpnmkswppx73yfj54lyvdqjrsy5hyk5qox54hviw36b@6sltisabrtme>
References: <20240125135237.189493-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125135237.189493-1-andrey.drobyshev@virtuozzo.com>
User-Agent: NeoMutt/20231221
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Jan 25, 2024 at 03:52:37PM +0200, Andrey Drobyshev wrote:
> If socket path is too long (longer than 108 bytes), socket can't be
> opened.  This might lead to failure when test dir path is long enough.
> Make sure socket is created in iotests.sock_dir to avoid such a case.
> 
> This commit basically aligns iotests/264 with the rest of iotests.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  tests/qemu-iotests/264 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/tests/qemu-iotests/264 b/tests/qemu-iotests/264
> index c532ccd809..c6ba2754e2 100755
> --- a/tests/qemu-iotests/264
> +++ b/tests/qemu-iotests/264
> @@ -25,7 +25,8 @@ import os
>  import iotests
>  from iotests import qemu_img_create, file_path, qemu_nbd_popen
>  
> -disk_a, disk_b, nbd_sock = file_path('disk_a', 'disk_b', 'nbd-sock')
> +disk_a, disk_b = file_path('disk_a', 'disk_b')
> +nbd_sock = file_path('nbd-sock', base_dir=iotests.sock_dir)
>  nbd_uri = 'nbd+unix:///?socket=' + nbd_sock
>  wait_limit = 3.0
>  wait_step = 0.2
> -- 
> 2.39.3
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


