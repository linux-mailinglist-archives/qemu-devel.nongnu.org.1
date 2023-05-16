Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ECD705983
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 23:33:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz2HQ-0001Kq-8L; Tue, 16 May 2023 17:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pz2HO-0001KH-3C
 for qemu-devel@nongnu.org; Tue, 16 May 2023 17:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pz2HM-0003pD-2r
 for qemu-devel@nongnu.org; Tue, 16 May 2023 17:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684272739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7juesrT79hBoh6wMjcWCHtPvyqBAUsG7WJWIbmiApic=;
 b=OXv38wUPwC6KuAkd+k8p+sWXqGHAv7gIcE9AxlTXw4wffMw25sEoaRX4K/qhuVdYvxeO4Y
 Pl0P1B0U8iWpYYGM7cZvRDREDXWHvGJNEvNRV0ZCy4VWlwXqAPjibrdXYVUHCM97vzaTaZ
 t9MP1w6ijjEPPZiqroIZf4e6hA7LgDo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-PEU8-2XeNV-2cCEq3VML3Q-1; Tue, 16 May 2023 17:32:17 -0400
X-MC-Unique: PEU8-2XeNV-2cCEq3VML3Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D49B870820;
 Tue, 16 May 2023 21:32:17 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C18C22026DFD;
 Tue, 16 May 2023 21:32:16 +0000 (UTC)
Date: Tue, 16 May 2023 16:32:15 -0500
From: Eric Blake <eblake@redhat.com>
To: ~akihirosuda <suda.kyoto@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 akihiro.suda.cz@hco.ntt.co.jp
Subject: Re: [PATCH qemu] docs/interop/qcow2.txt: fix description about
 "zlib" clusters
Message-ID: <vjg4r5ikuypvaholisxbdzhxokhb55zu5qa5jae3xu2jmwh24y@w4kxdch6i4hr>
References: <168424874322.11954.1340942046351859521-0@git.sr.ht>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168424874322.11954.1340942046351859521-0@git.sr.ht>
User-Agent: NeoMutt/20230512
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On Tue, May 16, 2023 at 11:32:27PM +0900, ~akihirosuda wrote:
> 
> From: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
> 
> "zlib" clusters are actually raw deflate (RFC1951) clusters without
> zlib headers.
> 
> Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
> ---
>  docs/interop/qcow2.txt | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Seems like a useful clarification to me (there's a difference between
the encoding name and the program used to create/parse that encoding).

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index f7dc304ff6..e7f036c286 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -214,14 +214,18 @@ version 2.
>                      type.
>  
>                      If the incompatible bit "Compression type" is set: the field
> -                    must be present and non-zero (which means non-zlib
> +                    must be present and non-zero (which means non-deflate
>                      compression type). Otherwise, this field must not be present
> -                    or must be zero (which means zlib).
> +                    or must be zero (which means deflate).
>  
>                      Available compression type values:
> -                        0: zlib <https://www.zlib.net/>
> +                        0: deflate <https://www.ietf.org/rfc/rfc1951.txt>
>                          1: zstd <http://github.com/facebook/zstd>
>  
> +                    The deflate compression type is called "zlib"
> +                    <https://www.zlib.net/> in QEMU. However, clusters with the
> +                    deflate compression type do not have zlib headers.
> +
>  
>  === Header padding ===
>  
> -- 
> 2.38.4
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


