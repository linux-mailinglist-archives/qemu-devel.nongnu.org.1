Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3923C738A39
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 17:57:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC0B6-0001Po-51; Wed, 21 Jun 2023 11:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qC0B3-0001PL-6f
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 11:55:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qC0B1-0006VJ-FR
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 11:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687362922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vtr0iZKYwNtQtVA4wbFMTfEWEMie+ugu9/HhG8ngzPk=;
 b=LmqkG+ML74UbO9htnUVd3RKhIIU2pFgXVNivkmkcK+TMeY1ooZ690HGG8upgQ/51zNkc/8
 /cXtL8crSu9RobRPyxXvygegQRO6yG++bZBWvI4DqdBFOABBQKHu5kAX0PWHfHrhlHwRTa
 Ybh6uaPhLKgBAqfVg1OQLxMFPmKKJHU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-CNozbGQbM9S758vhXOc9rg-1; Wed, 21 Jun 2023 11:55:19 -0400
X-MC-Unique: CNozbGQbM9S758vhXOc9rg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-76248f3057bso75812885a.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 08:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687362919; x=1689954919;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vtr0iZKYwNtQtVA4wbFMTfEWEMie+ugu9/HhG8ngzPk=;
 b=boVy1Crrte6pUqKUkxcWrTJRJIU261K26IzLqpfNyw6O5fhWgGl8Fo4BdQcF6XFO5O
 qYq6zUQv5TZL5Nr7hsORsI8M7DkcPzvkxbzaIvUMeq4IB5FYysXAbSY8QU770eG46puU
 b93Hivt2giO2vXxVBYgi/sP6vmTdrAHDOv5GQlAnWl4AtwlmUD1OMJ05SvtoKsvtW+X4
 2iG3iOTZc1NATbHRMbFUKiyp66aJOvAJMO+1LuneB1HwKiMd7nNxZuNF5IARMXF7iXaC
 Er7cMkLbgAUPAraA08VBj6STZVimRlVysuwoLYemf3u4HsM4UUJy7+dutsSSQC1EdnQX
 /VGQ==
X-Gm-Message-State: AC+VfDwTyws+gCi/n6JHdGO/ypouyuRK2SXvp72x4qbsy5Rf3GvXcq7j
 cUZwM9EklUwWC/jcpA9bOyF+123ihQ2/K4pyjQsnyXgxGrQfn4zZNFQ6GY4sqBn+Ol3gFqwdEKE
 RVgg/hQYQyMgC2Fc=
X-Received: by 2002:a05:620a:319f:b0:760:3db8:fd60 with SMTP id
 bi31-20020a05620a319f00b007603db8fd60mr18810939qkb.2.1687362919145; 
 Wed, 21 Jun 2023 08:55:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6FRwIUjSIwJ3A+JRamr4ecqCVQWN/+YMc4m/bDYcT8gTRK/+Snq51qyYoXPhN1U6ZcP4PPKg==
X-Received: by 2002:a05:620a:319f:b0:760:3db8:fd60 with SMTP id
 bi31-20020a05620a319f00b007603db8fd60mr18810929qkb.2.1687362918871; 
 Wed, 21 Jun 2023 08:55:18 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 27-20020a05620a079b00b0075b1d85e6f9sm2357441qka.68.2023.06.21.08.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 08:55:18 -0700 (PDT)
Date: Wed, 21 Jun 2023 11:55:17 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peng Tao <tao.peng@linux.alibaba.com>
Subject: Re: [PATCH v1 1/4] softmmu/physmem: Warn with
 ram_block_discard_range() on MAP_PRIVATE file mapping
Message-ID: <ZJMdZRoeu9BVm0z8@x1n>
References: <20230620130354.322180-1-david@redhat.com>
 <20230620130354.322180-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230620130354.322180-2-david@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Jun 20, 2023 at 03:03:51PM +0200, David Hildenbrand wrote:
> ram_block_discard_range() cannot possibly do the right thing in
> MAP_PRIVATE file mappings in the general case.
> 
> To achieve the documented semantics, we also have to punch a hole into
> the file, possibly messing with other MAP_PRIVATE/MAP_SHARED mappings
> of such a file.
> 
> For example, using VM templating -- see commit b17fbbe55cba ("migration:
> allow private destination ram with x-ignore-shared") -- in combination with
> any mechanism that relies on discarding of RAM is problematic. This
> includes:
> * Postcopy live migration
> * virtio-balloon inflation/deflation or free-page-reporting
> * virtio-mem
> 
> So at least warn that there is something possibly dangerous is going on
> when using ram_block_discard_range() in these cases.

The issue is probably valid.

One thing I worry is when the user (or, qemu instance) exclusively owns the
file, just forgot to attach share=on, where it used to work perfectly then
it'll show this warning.  But I agree maybe it's good to remind them just
to attach the share=on.

For real private mem users, the warning can of real help, one should
probably leverage things like file snapshot provided by modern file
systems, so each VM should just have its own snapshot ram file to use then
map it share=on I suppose.

For the long term, maybe we should simply support private mem here simply
by a MADV_DONTNEED.  I assume that's the right semantics for postcopy (just
need to support MINOR faults, though; MISSING faults definitely will stop
working.. but for all the rest framework shouldn't need much change), and I
hope that's also the semantics that balloon/virtio-mem wants here.  Not
sure whether/when that's strongly needed, assuming the corner case above
can still be work arounded properly by other means.

For now, a warning looks all sane.

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

> ---
>  softmmu/physmem.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index 6bdd944fe8..27c7219c82 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -3451,6 +3451,24 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
>               * so a userfault will trigger.
>               */
>  #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
> +            /*
> +             * We'll discard data from the actual file, even though we only
> +             * have a MAP_PRIVATE mapping, possibly messing with other
> +             * MAP_PRIVATE/MAP_SHARED mappings. There is no easy way to
> +             * change that behavior whithout violating the promised
> +             * semantics of ram_block_discard_range().
> +             *
> +             * Only warn, because it work as long as nobody else uses that
> +             * file.
> +             */
> +            if (!qemu_ram_is_shared(rb)) {
> +                warn_report_once("ram_block_discard_range: Discarding RAM"
> +                                 " in private file mappings is possibly"
> +                                 " dangerous, because it will modify the"
> +                                 " underlying file and will affect other"
> +                                 " users of the file");
> +            }
> +
>              ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>                              start, length);
>              if (ret) {
> -- 
> 2.40.1
> 

-- 
Peter Xu


