Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3D578D418
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 10:28:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbGXV-0005Sj-6u; Wed, 30 Aug 2023 04:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qbGXL-0005Ke-Rf
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:26:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qbGXJ-00033B-Js
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693384008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tZaLmmYjKD1ROxlV1f4dDQlHzQovf63qwXOdUr21tOk=;
 b=SLbwSB1gsGv+S24iOiJ6WeD2QZuj4qi9A57b+broQdieymJ6VtDjj+ssB2HAo8Bm8lB/3+
 JkZ8linZA1cvMorJOtQG18zYYKiQxEts2M9PbWHrFexwXxRlUu53JE99tqPnfrc+sN69Ze
 omXBhXdw68/kgR4POD5jUWQS9UaegMs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-icdP1p8CPWi0MrYu1n1Q6w-1; Wed, 30 Aug 2023 04:26:46 -0400
X-MC-Unique: icdP1p8CPWi0MrYu1n1Q6w-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-99c01c680beso362265766b.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 01:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693384005; x=1693988805;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tZaLmmYjKD1ROxlV1f4dDQlHzQovf63qwXOdUr21tOk=;
 b=blAE86SlZymOfJ/tf0n7JqUdbpoTSSzTtoGjEcbhd1/mhoxjPT9w3Qg0dhKomtD8uf
 Pu5d00iuzXWRxEE7tN5RdCtDPWycJl3Gf6SKMiGUAheQ1DQkN6tq2rV//PEWO1+M1Mbn
 4xELfGNuBdRmGp+kYTmbaw58/KjAOlys2duxTirBI1/6nGJ1ULcv3N57om+fenHt7tf2
 tPVYCoKk/o8L6zTjcbXGsVi4r+raFGsVYk2Um70wupraZrUboIsacVntv/zoRp60T2Z8
 4Io5bZ14EqomSKk3iHn7adpqnaJpUVUQGxkRzowDiQRZYeGDna2H25NIjkl4qpn/Bl3w
 1tsg==
X-Gm-Message-State: AOJu0YzKRkDEevps05lst0Xkv0wNfNRr8rXZ5IS5ioIQIH4stbCz13tg
 Py8jZ02wrWBTc0q2LmK5bfY990R27BopNZYjHfmBlS5mMTH4PxP6OFQF774rd35Z9cHUJladBCx
 yr818l4Z/MrVE0cY=
X-Received: by 2002:a17:906:3152:b0:994:1844:c7d1 with SMTP id
 e18-20020a170906315200b009941844c7d1mr993059eje.13.1693384005328; 
 Wed, 30 Aug 2023 01:26:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy/S4SkjWmo2OSsm5tKC1O4u52kHbYtbboBIUtJQNPpUHAAmpJWCDA2KjmrL0rTn+ZTjjuxA==
X-Received: by 2002:a17:906:3152:b0:994:1844:c7d1 with SMTP id
 e18-20020a170906315200b009941844c7d1mr993043eje.13.1693384004796; 
 Wed, 30 Aug 2023 01:26:44 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it.
 [82.57.51.114]) by smtp.gmail.com with ESMTPSA id
 v24-20020a17090606d800b0099364d9f0e2sm6938925ejb.98.2023.08.30.01.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 01:26:44 -0700 (PDT)
Date: Wed, 30 Aug 2023 10:26:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, 
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>
Subject: Re: [PATCH 1/7] vhost-user: strip superfluous whitespace
Message-ID: <64zbml5xq6tmu7zq4x3acia5eu4x73erjv5igwj2ljfpxj5nzf@2ahy5rzialjr>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-2-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230827182937.146450-2-lersek@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Aug 27, 2023 at 08:29:31PM +0200, Laszlo Ersek wrote:
>Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
>Cc: Eugenio Perez Martin <eperezma@redhat.com>
>Cc: German Maglione <gmaglione@redhat.com>
>Cc: Liu Jiang <gerry@linux.alibaba.com>
>Cc: Sergio Lopez Pascual <slp@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>---
> hw/virtio/vhost-user.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


