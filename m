Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D824C70F164
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 10:48:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kAM-0001vD-JJ; Wed, 24 May 2023 04:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q1kAK-0001uy-Gy
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:48:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q1kAG-0002Ti-J7
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684918090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ice5vyWLZIdFvZsU4KYca0HCuRNiy82oFSrQDE43eC4=;
 b=XRTfj2fdpED/wqSkyEym1qGgS9GPjr5tJMILDIHBXgkc1FnkxHtDiprLUShIjbWK+dnWYk
 n6AHP3V8cXIqueCVjEXvf8zwJXQLsvy00fcsBwZWbGm++2YNGDk+9j7TTkOGA1NebKhzEr
 8rvUUkVIOpAiQm7IwcpK4I23WvKs90k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-recLrSmfNJWdA8o3R9yTvg-1; Wed, 24 May 2023 04:48:01 -0400
X-MC-Unique: recLrSmfNJWdA8o3R9yTvg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f4dd7f13d0so3031165e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 01:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684918080; x=1687510080;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ice5vyWLZIdFvZsU4KYca0HCuRNiy82oFSrQDE43eC4=;
 b=V7HnNUIDPM0bUVhQUfaDw0FfdkKWQYfLmR0DhX8juQJ1wHEOefX+/EbU7Fr6m4MzVu
 LRV/WEVErDL/lCDeHLyKqC+o5ilEKGb7gADAWo+fCR9T2ZSNI4lsqeafrHG6CG1VE2d4
 iV5B79uA9f1ty4yudsxOy6kguqG/oLR0nRU+hhU1RxmuFamRdwvtaM7ZQ1mU2GbR30G9
 cEsskS01xRpN63XqM20alvTkugQ6zRTR8tmJ7fL9n9YHygUj09KYsLQVrY0z0yJCIja7
 WUN0Un/tQ0yAEeH159tMjpeq2MXt0YCVGyysrOrjLe79BgY38DmNvA/jkAjrhZ0akGAj
 25Jg==
X-Gm-Message-State: AC+VfDz87tDZCulvhJTGtTHuX9F8u+dkzxW0rm5T4hmPV/v6H3xPtiIQ
 rrhh5kHE8a0AUviWcn6ijaQmopcviBIPXsJat8Vbco56RnvTJkQE0eAdKVDA/bqAvBitRNShOPc
 1hOedNz4rglbvi40=
X-Received: by 2002:a7b:ce88:0:b0:3f6:c7b:d3b7 with SMTP id
 q8-20020a7bce88000000b003f60c7bd3b7mr3479827wmj.37.1684918080856; 
 Wed, 24 May 2023 01:48:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7UHT/Zh7wO+OH1Oxh3QT/tcrOrKhvVcbUbZ7TzycjShzVBmTQRbmnX0N1Gj6T5Sjrqzkd74Q==
X-Received: by 2002:a7b:ce88:0:b0:3f6:c7b:d3b7 with SMTP id
 q8-20020a7bce88000000b003f60c7bd3b7mr3479809wmj.37.1684918080585; 
 Wed, 24 May 2023 01:48:00 -0700 (PDT)
Received: from sgarzare-redhat ([134.0.5.107])
 by smtp.gmail.com with ESMTPSA id
 r14-20020adfce8e000000b00306c5900c10sm13805227wrn.9.2023.05.24.01.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 01:47:59 -0700 (PDT)
Date: Wed, 24 May 2023 10:47:53 +0200
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
Subject: Re: [PATCH v2 4/6] block/io_uring: convert to blk_io_plug_call() API
Message-ID: <qnl7sgmindnbs32daw44rhgbyhcw4lruecqgtctdbeiwc7yog2@yxuukgxwi4m3>
References: <20230523171300.132347-1-stefanha@redhat.com>
 <20230523171300.132347-5-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230523171300.132347-5-stefanha@redhat.com>
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

On Tue, May 23, 2023 at 01:12:58PM -0400, Stefan Hajnoczi wrote:
>Stop using the .bdrv_co_io_plug() API because it is not multi-queue
>block layer friendly. Use the new blk_io_plug_call() API to batch I/O
>submission instead.
>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>Reviewed-by: Eric Blake <eblake@redhat.com>
>---
>v2
>- Removed whitespace hunk [Eric]
>---
> include/block/raw-aio.h |  7 -------
> block/file-posix.c      | 10 ----------
> block/io_uring.c        | 44 ++++++++++++++++-------------------------
> block/trace-events      |  5 ++---
> 4 files changed, 19 insertions(+), 47 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


