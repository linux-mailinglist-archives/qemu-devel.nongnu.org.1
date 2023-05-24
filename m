Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5059570F17D
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 10:53:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kEj-0007Qm-3s; Wed, 24 May 2023 04:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q1kEb-0007FK-86
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:52:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q1kEY-0003jb-FY
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684918357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3kcVMQ7kvj0Iz6K5ZAjc8mmj/6YQBshqNuaYR17461o=;
 b=GtibrgCw6NDUNZeTvh6DO9Z6XRycCk9i9pDmHg2QeiLWhaUpgTzEZMqiAl0vC1DPKub70e
 9e7DYZ69+i4B0mfHpGTW7laBr7yXswjgChXFFsHFUlrgUtZk7ZHXLgb6De6+DYzMgYFAwM
 5HisvG2Au/+Qr/YmVGS7NQWcxNTJkdo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-1KDkuu0aPrSi-U9Wo0Lq2A-1; Wed, 24 May 2023 04:52:34 -0400
X-MC-Unique: 1KDkuu0aPrSi-U9Wo0Lq2A-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f60162f7fcso2670425e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 01:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684918353; x=1687510353;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3kcVMQ7kvj0Iz6K5ZAjc8mmj/6YQBshqNuaYR17461o=;
 b=bI1tTjKXfc9iry776haqyepP1xL7QJ2O7ZK75DKh+wUMmjVkQianHqo83Q5gXEzhbf
 HFLRa8NVlRyozoW1pSkfRKkOHb74b14xxtw/S7HcP8hEmhj4mNVeifHXBHrf6ERNZdPg
 2Ta974rRu3++2ZlwvFpEZwTyKl7fPjTJh3QM/Yo2QMCVZSpktBO5j433ksC//iARAx+j
 gWmlp5LHOdw2m1vsGrbRZVM8U1j8dsduSiSAMgvmgLu+sy1EeH1yc97fl/ngJqs/FbCC
 bD24ULs915uJFU1+N9hpGk8FeJgR4X8V65HkzEonmKEGqyz489F5EYeHJPa738SOyKmp
 Ynqw==
X-Gm-Message-State: AC+VfDzlKf+CtE1BhCMCcw6d5tGLe9jCnNDPjFbMA2xAVXY44qa7A5/d
 roE9PfoJRC1OIWgnzXa13XM3a5l1YDMO0yowq8JNFcvn1b4ZQrU/b9ZJEJdyydRGpR0du2Qtd9h
 tacGJT23uqCUrFq0=
X-Received: by 2002:a7b:cd8a:0:b0:3f6:a66:a372 with SMTP id
 y10-20020a7bcd8a000000b003f60a66a372mr3673528wmj.1.1684918353366; 
 Wed, 24 May 2023 01:52:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7TQg7OL7OGuh6V7LESCC2zr/IQghY3wNUBo+TQKydHcYVu7y54l8KC2f19D6VPXvGmoMotOg==
X-Received: by 2002:a7b:cd8a:0:b0:3f6:a66:a372 with SMTP id
 y10-20020a7bcd8a000000b003f60a66a372mr3673507wmj.1.1684918353149; 
 Wed, 24 May 2023 01:52:33 -0700 (PDT)
Received: from sgarzare-redhat ([134.0.5.107])
 by smtp.gmail.com with ESMTPSA id
 c8-20020a05600c0ac800b003f4285629casm1515371wmr.42.2023.05.24.01.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 01:52:32 -0700 (PDT)
Date: Wed, 24 May 2023 10:52:29 +0200
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
Subject: Re: [PATCH v2 6/6] block: remove bdrv_co_io_plug() API
Message-ID: <yosdxsqcqcj4utt4dwmfgfdsgnmduu6avjc7wrd33bxzs3vds4@wossen4sa7ve>
References: <20230523171300.132347-1-stefanha@redhat.com>
 <20230523171300.132347-7-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230523171300.132347-7-stefanha@redhat.com>
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

On Tue, May 23, 2023 at 01:13:00PM -0400, Stefan Hajnoczi wrote:
>No block driver implements .bdrv_co_io_plug() anymore. Get rid of the
>function pointers.
>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>Reviewed-by: Eric Blake <eblake@redhat.com>
>---
> include/block/block-io.h         |  3 ---
> include/block/block_int-common.h | 11 ----------
> block/io.c                       | 37 --------------------------------
> 3 files changed, 51 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


