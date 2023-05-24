Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA0870F05F
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 10:14:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1jch-0004MO-AC; Wed, 24 May 2023 04:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q1jcf-0004IK-D5
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:13:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q1jcd-0003RB-Sw
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684916007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pdqRwguXZFLYTV9FtQQFWD/FtkvuQeDoxuRVCDomYds=;
 b=ikeOwOrgm08Zrx0MECdmF7rufVAQt7xFiQvuNy+0qg0kmmjXGc4j7EvVCwcoFs25Kud2tN
 VFq6lD18kqJPYLyCykOnBgUK7Fw4wGHwMHcSs5hkkqbKiGRE/JXb9dBq38wi0wO7iH+By/
 FZgaLouB9kR4g2uqxqOY3athh7LyPHA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-sG8FOTvWNvepFr9wnCLAIg-1; Wed, 24 May 2023 04:13:25 -0400
X-MC-Unique: sG8FOTvWNvepFr9wnCLAIg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30634323dfeso209140f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 01:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684916004; x=1687508004;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pdqRwguXZFLYTV9FtQQFWD/FtkvuQeDoxuRVCDomYds=;
 b=Uo0foAMZdafBX3iD0tH1yl44jeNXXfEYKiSLWXn1QJJrD7XTsZsAJNsTi9gCkKrz6z
 bpV6Z7xC0mWwGqZWT5OflZFdKiDS0vVYrU7giz3QINvNwQf4a6bQxEAA8pSGAJZ0+Cjr
 oyxqtUNphAGrJIN8VqUFk3649Z41z8uN4P0SqbgTKHfgy7QROQEt6kZpQsxMN7f8TI+C
 kamENtlQ/lDcMQnwLJWnw9VJUEIFboYwCM2s/punJpfZGnlXe83VmAn2qKoLCwrxo5cV
 KjfdtJOEH+ok5TzfonNhBGCJGd0fpC6uOHcjxkf+0Kojx4FrpA86xZKfTD4AGvn7Lh3s
 Gj0Q==
X-Gm-Message-State: AC+VfDz6mVv1M1Dh8Bg+NSkkxBpu+KVYvk++JxJomTlXWc2k41SJBmDp
 RHV6C4AVxkPb/YSTquiCDjEwrksTdAIdIphjIs3CYU0LDYVRbVz0euEGkBg6SUMXZ+wZ7n+vu1+
 UuHkmPVmfjNJWDG6cMyWFr/o=
X-Received: by 2002:adf:f74a:0:b0:306:342a:6a01 with SMTP id
 z10-20020adff74a000000b00306342a6a01mr11799941wrp.47.1684916004609; 
 Wed, 24 May 2023 01:13:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ZnJ0/K9dDPiC0ZaAZ/7pQ5w7egHROoU20w4IJP/Gip9aXS3+Iv+Josl6t+iFMGZ+1JPC4Zw==
X-Received: by 2002:adf:f74a:0:b0:306:342a:6a01 with SMTP id
 z10-20020adff74a000000b00306342a6a01mr11799919wrp.47.1684916004329; 
 Wed, 24 May 2023 01:13:24 -0700 (PDT)
Received: from sgarzare-redhat ([134.0.5.107])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a05600c378b00b003f195d540d9sm1466237wmr.14.2023.05.24.01.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 01:13:23 -0700 (PDT)
Date: Wed, 24 May 2023 10:13:20 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Hanna Reitz <hreitz@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 xen-devel@lists.xenproject.org, 
 eblake@redhat.com, Anthony Perard <anthony.perard@citrix.com>, 
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 3/6] block/blkio: convert to blk_io_plug_call() API
Message-ID: <7nq4x6dcajbnjuoytz7g3egfipbq2y5hyadactbco7t4kr6gxt@g37bnv7sijh2>
References: <20230523171300.132347-1-stefanha@redhat.com>
 <20230523171300.132347-4-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230523171300.132347-4-stefanha@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On Tue, May 23, 2023 at 01:12:57PM -0400, Stefan Hajnoczi wrote:
>Stop using the .bdrv_co_io_plug() API because it is not multi-queue
>block layer friendly. Use the new blk_io_plug_call() API to batch I/O
>submission instead.
>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>Reviewed-by: Eric Blake <eblake@redhat.com>
>---
>v2
>- Add missing #include and fix blkio_unplug_fn() prototype [Stefano]
>---
> block/blkio.c | 43 ++++++++++++++++++++++++-------------------
> 1 file changed, 24 insertions(+), 19 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


