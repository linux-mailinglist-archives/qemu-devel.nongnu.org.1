Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AFB7D4757
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 08:21:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvAmF-00024B-1w; Tue, 24 Oct 2023 02:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1qvAm9-00022y-AY
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 02:20:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1qvAm6-000207-H7
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 02:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698128421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V0okVi0Ko4GhhSteA9ZgpilBibPpRLshKHCS87Esk5I=;
 b=XoHhX1Ms2F08fltwQQLioynwSwLnN7x3idNzv+qkRhLZWMAmVTL0L19cDUYK01iBee5vOm
 mLs2BM9aXQH5R3OZPfgTbglvRTqBsBRDew0tW5QgTbjaJglXkZgtPwVqpbyblyPKy68wO4
 Ez4lXWKSkk0cABwQEnc1voL+G4jfLhk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-7RUUMHh0PIeyR2qNJCOiIw-1; Tue, 24 Oct 2023 02:19:14 -0400
X-MC-Unique: 7RUUMHh0PIeyR2qNJCOiIw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c50bebd8dfso36525081fa.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 23:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698128353; x=1698733153;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V0okVi0Ko4GhhSteA9ZgpilBibPpRLshKHCS87Esk5I=;
 b=SahToRMBHMUkJM13mlTGKdO1MX4+wkwiJzjr8Zz5AoWHp/XWq64IWUUrb2eCACgkDb
 LsapuzhCkCcm4bM7NcPB90Z3RnyB/W9hROWzzp+Czn+UJOgfLbutQ6UN4mxo5dV+yzU+
 j1gZ3py8KIL8IJ3NPBFrgdaRHm4vk55LozHQ9Z3ZC/gV4T28R6kw6QmVazICEkUHj+5P
 UB5aZNLH1Wb0MHwlG64mXcMNQql5f+D7LKuhCHX+GIbK0bv4AYGs2L0E4W2WFaWKX5AY
 mXcaStAmomaaYhw75kNpUOXFoG1XVGEBGbN2vNPdPnb69oI4sGUxaVO7oVHF4m2wvQkI
 2khQ==
X-Gm-Message-State: AOJu0YzO1fXIOlGFK+uceOBwMc1Sq/q3VUDqTsWCzhHLgxaFvnjnDNBv
 YSCUSMTr0aGlBOFmMVlQPZ4zP1Uyu/TAQA/UvJrKYkXlslr2Ltzr4soCDB/0m7RAkQ6AKwjFX49
 tGBxKXMkY0j7eCG4QaIPaEeLmkz559A8=
X-Received: by 2002:a05:651c:c85:b0:2bc:dcdb:b5dc with SMTP id
 bz5-20020a05651c0c8500b002bcdcdbb5dcmr9072363ljb.39.1698128352733; 
 Mon, 23 Oct 2023 23:19:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpfxKzmjBJD0nMpeILKFpcUOZ4X0jyhgm/bnEOWRQ7HruBnhFnmag2LbPe6BRZXo8UhMTIIhvacEbqbUQmMkg=
X-Received: by 2002:a05:651c:c85:b0:2bc:dcdb:b5dc with SMTP id
 bz5-20020a05651c0c8500b002bcdcdbb5dcmr9072347ljb.39.1698128352316; Mon, 23
 Oct 2023 23:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231023111341.219317-1-david@redhat.com>
In-Reply-To: <20231023111341.219317-1-david@redhat.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Tue, 24 Oct 2023 08:19:01 +0200
Message-ID: <CAMXpfWvpmwWHAGpBXEc_S2zMzGXxRfx7pNcaHXoaRjVWmRBmeA@mail.gmail.com>
Subject: Re: [PATCH v1] virtio-mem: fix division by zero in
 virtio_mem_activate_memslots_to_plug()
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This patch has been successfully tested by QE. With a debug QEMU
build, start a VM with a virtio-mem device and 'dynamic-memslots=3Doff',
this one can be resized seamlessly, no floating point exception found.

Tested-by: Mario Casquero <mcasquer@redhat.com>




On Mon, Oct 23, 2023 at 1:13=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> When running with "dynamic-memslots=3Doff", we enter
> virtio_mem_activate_memslots_to_plug() to return immediately again
> because "vmem->dynamic_memslots =3D=3D false". However, the compiler migh=
t
> not optimize out calculating start_idx+end_idx, where we divide by
> vmem->memslot_size. In such a configuration, the memslot size is 0 and
> we'll get a division by zero:
>
>     (qemu) qom-set vmem0 requested-size 3G
>     (qemu) q35.sh: line 38: 622940 Floating point exception(core dumped)
>
> The same is true for virtio_mem_deactivate_unplugged_memslots(), however
> we never really reach that code without a prior
> virtio_mem_activate_memslots_to_plug() call.
>
> Let's fix it by simply calling these functions only with
> "dynamic-memslots=3Don".
>
> This was found when using a debug build of QEMU.
>
> Reprted-by: Mario Casquero <mcasquer@redhat.com>
> Fixes: 177f9b1ee464 ("virtio-mem: Expose device memory dynamically via mu=
ltiple memslots if enabled")
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/virtio/virtio-mem.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 9dc3c61b5a..be4b0b364f 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -525,9 +525,7 @@ static void virtio_mem_activate_memslots_to_plug(Virt=
IOMEM *vmem,
>                                   vmem->memslot_size;
>      unsigned int idx;
>
> -    if (!vmem->dynamic_memslots) {
> -        return;
> -    }
> +    assert(vmem->dynamic_memslots);
>
>      /* Activate all involved memslots in a single transaction. */
>      memory_region_transaction_begin();
> @@ -547,9 +545,7 @@ static void virtio_mem_deactivate_unplugged_memslots(=
VirtIOMEM *vmem,
>                                   vmem->memslot_size;
>      unsigned int idx;
>
> -    if (!vmem->dynamic_memslots) {
> -        return;
> -    }
> +    assert(vmem->dynamic_memslots);
>
>      /* Deactivate all memslots with unplugged blocks in a single transac=
tion. */
>      memory_region_transaction_begin();
> @@ -598,7 +594,9 @@ static int virtio_mem_set_block_state(VirtIOMEM *vmem=
, uint64_t start_gpa,
>          virtio_mem_notify_unplug(vmem, offset, size);
>          virtio_mem_set_range_unplugged(vmem, start_gpa, size);
>          /* Deactivate completely unplugged memslots after updating the s=
tate. */
> -        virtio_mem_deactivate_unplugged_memslots(vmem, offset, size);
> +        if (vmem->dynamic_memslots) {
> +            virtio_mem_deactivate_unplugged_memslots(vmem, offset, size)=
;
> +        }
>          return 0;
>      }
>
> @@ -635,9 +633,11 @@ static int virtio_mem_set_block_state(VirtIOMEM *vme=
m, uint64_t start_gpa,
>           * blocks we are plugging here. The following notification will =
inform
>           * registered listeners about the blocks we're plugging.
>           */
> -        virtio_mem_activate_memslots_to_plug(vmem, offset, size);
> +        if (vmem->dynamic_memslots) {
> +            virtio_mem_activate_memslots_to_plug(vmem, offset, size);
> +        }
>          ret =3D virtio_mem_notify_plug(vmem, offset, size);
> -        if (ret) {
> +        if (ret && vmem->dynamic_memslots) {
>              virtio_mem_deactivate_unplugged_memslots(vmem, offset, size)=
;
>          }
>      }
> @@ -749,7 +749,9 @@ static int virtio_mem_unplug_all(VirtIOMEM *vmem)
>          notifier_list_notify(&vmem->size_change_notifiers, &vmem->size);
>
>          /* Deactivate all memslots after updating the state. */
> -        virtio_mem_deactivate_unplugged_memslots(vmem, 0, region_size);
> +        if (vmem->dynamic_memslots) {
> +            virtio_mem_deactivate_unplugged_memslots(vmem, 0, region_siz=
e);
> +        }
>      }
>
>      trace_virtio_mem_unplugged_all();
> --
> 2.41.0
>


