Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A5F747EB8
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 09:58:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGxNu-0005KS-7Y; Wed, 05 Jul 2023 03:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qGxNs-0005Jz-2M
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 03:57:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qGxNq-0003ZP-9k
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 03:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688543824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IAzuhizZEXeXCoEHj59J7UJxJUf9zplOyiq5HLTRKBc=;
 b=TuJ/mAFmEd134j5KkpBMs7yb81M/ZdN7YYKAiJiXxFscTLuvshydDfLmMtsQlBCzmgvvge
 VwS2FF4/qrd6YEO54br03JyGkassZRwDi7gjiuVc4DMMZsBvxVeKlsi67OXcCXTWJ+xRaq
 zFYLWsLI/MM+4+9FiY8IfLr0uP2e5k4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-O2cBdPKrPOu6XDmqpW5D4g-1; Wed, 05 Jul 2023 03:57:03 -0400
X-MC-Unique: O2cBdPKrPOu6XDmqpW5D4g-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-635e91cba88so69708326d6.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 00:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688543823; x=1691135823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IAzuhizZEXeXCoEHj59J7UJxJUf9zplOyiq5HLTRKBc=;
 b=YiJEfRNmEJXyRJ3F0vvwx5gbfvK7YgwV5Gjx+oz7olEX1TrQBCBkrsX4uxugoo5bYx
 r5pv1RibNxQ/60ilxAbo56y2tAwYLSZHiUhC6QYLFnipgZKv5ah4aPV6EOzfGcylLWmb
 2hp6hzZ8QHHg7n7pqlU8zV993FiyPKaEvFFqJan/CiiPQiwthy2A3564JRIWhZAq3ED1
 ed1rAZDxJuKi90xcf87vlOBLkVNhoDpbyQeD2UvKlGqqf5KgkEg/y+td8pvbQdvjkysK
 3emm/fsfvXw1n9/8BAlHu4fA+ZsC930FV9daeohhw75NjXMh9GZ2iJo5HN7o9Q8ambiA
 QwKA==
X-Gm-Message-State: ABy/qLZbKdXtHTItUDWWmxFtde4k0RRSztmfQlyCBrfVxUzyRibd4GXJ
 ZTcZBaYx3dL2hiwNgOD4LHbq5hlxO0l+n2IAcaq1/VbMGXFi1H3Kjc0L637y5LsqtJ9tsrVrgY0
 VfEn0F3CwIQLEcSKimoj3t6PWR/8vNEA=
X-Received: by 2002:ad4:5ccf:0:b0:635:33b0:f424 with SMTP id
 iu15-20020ad45ccf000000b0063533b0f424mr22394299qvb.40.1688543823223; 
 Wed, 05 Jul 2023 00:57:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFQcTR3YRZxGfBLCR4YcLoC2bj2BrlVJx34fnf6yngG1E7ZJLhtcAJ7ohAJtzHDvkVQU1pdVk58O8gWUMAh9Lk=
X-Received: by 2002:ad4:5ccf:0:b0:635:33b0:f424 with SMTP id
 iu15-20020ad45ccf000000b0063533b0f424mr22394279qvb.40.1688543822950; Wed, 05
 Jul 2023 00:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230704071931.575888-1-lvivier@redhat.com>
 <20230704071931.575888-2-lvivier@redhat.com>
In-Reply-To: <20230704071931.575888-2-lvivier@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 5 Jul 2023 15:56:50 +0800
Message-ID: <CACGkMEv7eGJoLPDGiC52K+6SESMtmd30ut+NLRXes8EkqVjQAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] vhost-vdpa: mute unaligned memory error report
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, eric.auger@redhat.com, Peter Xu <peterx@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, mst@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 marcandre.lureau@redhat.com, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 4, 2023 at 3:19=E2=80=AFPM Laurent Vivier <lvivier@redhat.com> =
wrote:
>
> With TPM CRM device, vhost-vdpa reports an error when it tries
> to register a listener for a non aligned memory region:
>
>   qemu-system-x86_64: vhost_vdpa_listener_region_add received unaligned r=
egion
>   qemu-system-x86_64: vhost_vdpa_listener_region_del received unaligned r=
egion
>
> This error can be confusing for the user whereas we only need to skip
> the region (as it's already done after the error_report())
>
> Rather than introducing a special case for TPM CRB memory section
> to not display the message in this case, simply replace the
> error_report() by a trace function (with more information, like the
> memory region name).
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  hw/virtio/trace-events | 2 ++
>  hw/virtio/vhost-vdpa.c | 8 ++++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 8f8d05cf9b01..9b0d643b9475 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -34,7 +34,9 @@ vhost_vdpa_dma_map(void *vdpa, int fd, uint32_t msg_typ=
e, uint32_t asid, uint64_
>  vhost_vdpa_dma_unmap(void *vdpa, int fd, uint32_t msg_type, uint32_t asi=
d, uint64_t iova, uint64_t size, uint8_t type) "vdpa:%p fd: %d msg_type: %"=
PRIu32" asid: %"PRIu32" iova: 0x%"PRIx64" size: 0x%"PRIx64" type: %"PRIu8
>  vhost_vdpa_listener_begin_batch(void *v, int fd, uint32_t msg_type, uint=
8_t type)  "vdpa:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
>  vhost_vdpa_listener_commit(void *v, int fd, uint32_t msg_type, uint8_t t=
ype)  "vdpa:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
> +vhost_vdpa_listener_region_add_unaligned(void *v, const char *name, uint=
64_t offset_as, uint64_t offset_page) "vdpa: %p region %s offset_within_add=
ress_space %"PRIu64" offset_within_region %"PRIu64
>  vhost_vdpa_listener_region_add(void *vdpa, uint64_t iova, uint64_t llend=
, void *vaddr, bool readonly) "vdpa: %p iova 0x%"PRIx64" llend 0x%"PRIx64" =
vaddr: %p read-only: %d"
> +vhost_vdpa_listener_region_del_unaligned(void *v, const char *name, uint=
64_t offset_as, uint64_t offset_page) "vdpa: %p region %s offset_within_add=
ress_space %"PRIu64" offset_within_region %"PRIu64
>  vhost_vdpa_listener_region_del(void *vdpa, uint64_t iova, uint64_t llend=
) "vdpa: %p iova 0x%"PRIx64" llend 0x%"PRIx64
>  vhost_vdpa_add_status(void *dev, uint8_t status) "dev: %p status: 0x%"PR=
Ix8
>  vhost_vdpa_init(void *dev, void *vdpa) "dev: %p vdpa: %p"
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 3c575a9a6e9e..24d32f0d3728 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -323,7 +323,9 @@ static void vhost_vdpa_listener_region_add(MemoryList=
ener *listener,
>
>      if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MA=
SK) !=3D
>                   (section->offset_within_region & ~TARGET_PAGE_MASK))) {
> -        error_report("%s received unaligned region", __func__);
> +        trace_vhost_vdpa_listener_region_add_unaligned(v, section->mr->n=
ame,
> +                       section->offset_within_address_space & ~TARGET_PA=
GE_MASK,
> +                       section->offset_within_region & ~TARGET_PAGE_MASK=
);
>          return;
>      }
>
> @@ -405,7 +407,9 @@ static void vhost_vdpa_listener_region_del(MemoryList=
ener *listener,
>
>      if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MA=
SK) !=3D
>                   (section->offset_within_region & ~TARGET_PAGE_MASK))) {
> -        error_report("%s received unaligned region", __func__);
> +        trace_vhost_vdpa_listener_region_del_unaligned(v, section->mr->n=
ame,
> +                       section->offset_within_address_space & ~TARGET_PA=
GE_MASK,
> +                       section->offset_within_region & ~TARGET_PAGE_MASK=
);
>          return;
>      }
>
> --
> 2.41.0
>


