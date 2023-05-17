Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E49705E91
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 06:10:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz8TD-0005NL-8c; Wed, 17 May 2023 00:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1pz8TB-0005Mu-Gy
 for qemu-devel@nongnu.org; Wed, 17 May 2023 00:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1pz8T7-0003yb-St
 for qemu-devel@nongnu.org; Wed, 17 May 2023 00:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684296532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Btu1VLWEz93nMGVVDHB47gvtBGEHWCIq6c1u+1ru/6o=;
 b=C2LE63pPe88zShurYKJLzuuQyDHH1d/xe4Yu0RMd4uRJDeHCO6mKENekcc9Wagbc79pKbD
 SkaPvKpmjJWlh1OWgauz3kv4cKpjvWfhHnzAH0KldmyO+6mHTM04wSKBz6zDv+TVXc4+bD
 aIoVBeTezeilXbTqtakEk963I+O9MvA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-xvHXrMT5MemqJCBwq-lQGg-1; Wed, 17 May 2023 00:08:51 -0400
X-MC-Unique: xvHXrMT5MemqJCBwq-lQGg-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1aaf5dcd999so4380415ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 21:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684296530; x=1686888530;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Btu1VLWEz93nMGVVDHB47gvtBGEHWCIq6c1u+1ru/6o=;
 b=N9V85glyzFFDvL0ucgvc2PacJk2XyKDk2vjYGxrT8PfDan7gNchTnz6HUBBLnoalNR
 WU1OOoPS4Ml1yqZB61he37L2eppAPO49yra8e9Ff+Osk5G5+n0dqOugGWQ2I+dIjFCnI
 EGougJvDxcNwpq/i67OLDZHL8ZQn5MZqa6q89gfP+v6oFiXqail89lInoDEoWz1mzJ18
 4V1Yoyahh0DJcJLRJzK5AQiAxq23OgxxvgY5uFFyWfAMRq7VHv4hKjJFhviEMe0YtqF0
 MH8nkmia08RYstYe86uIObmwBBM6JlpFATanDaDMtHs9GwUOlAvd9MTMrSWsCPdAo/ak
 2Upg==
X-Gm-Message-State: AC+VfDy5BBi7Qvoy6wE7rrTHJrZnIuWil5mawSqVmiFxmueZMGCYIrnW
 QLnLijDUFupMSJZ7PUxe2gFFcGlOhS67wUN7U8XFiwWQLYDT5R+Djp7xzdNxC4JBJLOxSfpa107
 z+5ZBIeuSUBQ66VM=
X-Received: by 2002:a17:902:d48d:b0:1ac:8835:b89b with SMTP id
 c13-20020a170902d48d00b001ac8835b89bmr38768689plg.5.1684296529970; 
 Tue, 16 May 2023 21:08:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7EwqeT+wp8EdZgPQHyIz6Fi0Kcz4hFf9LO58GZz+BFsi/RgTR8OPK13V0eCU5Mnq1byXfMjQ==
X-Received: by 2002:a17:902:d48d:b0:1ac:8835:b89b with SMTP id
 c13-20020a170902d48d00b001ac8835b89bmr38768673plg.5.1684296529590; 
 Tue, 16 May 2023 21:08:49 -0700 (PDT)
Received: from [10.72.12.65] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 ha2-20020a17090af3c200b00250c753b889sm428908pjb.23.2023.05.16.21.08.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 21:08:49 -0700 (PDT)
Message-ID: <78ff94f4-ca26-dbab-f4c9-25b1e4889aab@redhat.com>
Date: Wed, 17 May 2023 12:08:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2] vhost: fix possible wrap in SVQ descriptor ring
Content-Language: en-US
To: Hawkins Jiawei <yin31149@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>
Cc: 18801353760@163.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230509084817.3973-1-yin31149@gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230509084817.3973-1-yin31149@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.666, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


在 2023/5/9 16:48, Hawkins Jiawei 写道:
> QEMU invokes vhost_svq_add() when adding a guest's element
> into SVQ. In vhost_svq_add(), it uses vhost_svq_available_slots()
> to check whether QEMU can add the element into SVQ. If there is
> enough space, then QEMU combines some out descriptors and some
> in descriptors into one descriptor chain, and adds it into
> `svq->vring.desc` by vhost_svq_vring_write_descs().
>
> Yet the problem is that, `svq->shadow_avail_idx - svq->shadow_used_idx`
> in vhost_svq_available_slots() returns the number of occupied elements,
> or the number of descriptor chains, instead of the number of occupied
> descriptors, which may cause wrapping in SVQ descriptor ring.
>
> Here is an example. In vhost_handle_guest_kick(), QEMU forwards
> as many available buffers to device by virtqueue_pop() and
> vhost_svq_add_element(). virtqueue_pop() returns a guest's element,
> and then this element is added into SVQ by vhost_svq_add_element(),
> a wrapper to vhost_svq_add(). If QEMU invokes virtqueue_pop() and
> vhost_svq_add_element() `svq->vring.num` times,
> vhost_svq_available_slots() thinks QEMU just ran out of slots and
> everything should work fine. But in fact, virtqueue_pop() returns
> `svq->vring.num` elements or descriptor chains, more than
> `svq->vring.num` descriptors due to guest memory fragmentation,
> and this causes wrapping in SVQ descriptor ring.
>
> This bug is valid even before marking the descriptors used.
> If the guest memory is fragmented, SVQ must add chains
> so it can try to add more descriptors than possible.
>
> This patch solves it by adding `num_free` field in
> VhostShadowVirtqueue structure and updating this field
> in vhost_svq_add() and vhost_svq_get_buf(), to record
> the number of free descriptors.
>
> Fixes: 100890f7ca ("vhost: Shadow virtqueue buffers forwarding")
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> Acked-by: Eugenio Pérez <eperezma@redhat.com>


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
> v2:
>    - update the commit message
>    - remove the unnecessary comment
>    - add the Acked-by tag
>
> v1: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg01727.html
>
>   hw/virtio/vhost-shadow-virtqueue.c | 5 ++++-
>   hw/virtio/vhost-shadow-virtqueue.h | 3 +++
>   2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
> index 8361e70d1b..bd7c12b6d3 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -68,7 +68,7 @@ bool vhost_svq_valid_features(uint64_t features, Error **errp)
>    */
>   static uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq)
>   {
> -    return svq->vring.num - (svq->shadow_avail_idx - svq->shadow_used_idx);
> +    return svq->num_free;
>   }
>   
>   /**
> @@ -263,6 +263,7 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
>           return -EINVAL;
>       }
>   
> +    svq->num_free -= ndescs;
>       svq->desc_state[qemu_head].elem = elem;
>       svq->desc_state[qemu_head].ndescs = ndescs;
>       vhost_svq_kick(svq);
> @@ -449,6 +450,7 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
>       last_used_chain = vhost_svq_last_desc_of_chain(svq, num, used_elem.id);
>       svq->desc_next[last_used_chain] = svq->free_head;
>       svq->free_head = used_elem.id;
> +    svq->num_free += num;
>   
>       *len = used_elem.len;
>       return g_steal_pointer(&svq->desc_state[used_elem.id].elem);
> @@ -659,6 +661,7 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
>       svq->iova_tree = iova_tree;
>   
>       svq->vring.num = virtio_queue_get_num(vdev, virtio_get_queue_index(vq));
> +    svq->num_free = svq->vring.num;
>       driver_size = vhost_svq_driver_area_size(svq);
>       device_size = vhost_svq_device_area_size(svq);
>       svq->vring.desc = qemu_memalign(qemu_real_host_page_size(), driver_size);
> diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
> index 926a4897b1..6efe051a70 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.h
> +++ b/hw/virtio/vhost-shadow-virtqueue.h
> @@ -107,6 +107,9 @@ typedef struct VhostShadowVirtqueue {
>   
>       /* Next head to consume from the device */
>       uint16_t last_used_idx;
> +
> +    /* Size of SVQ vring free descriptors */
> +    uint16_t num_free;
>   } VhostShadowVirtqueue;
>   
>   bool vhost_svq_valid_features(uint64_t features, Error **errp);


