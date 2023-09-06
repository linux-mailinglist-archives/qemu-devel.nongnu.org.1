Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A4C79351A
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 08:06:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdleo-0004ER-IN; Wed, 06 Sep 2023 02:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdlej-0004C0-LB
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 02:04:49 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdleg-0003bg-PG
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 02:04:49 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99c3d3c3db9so508091066b.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 23:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693980285; x=1694585085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wkp1MQX8gIyLBWV4/FhnA2jRcxGZXLirbpCzzZteXiM=;
 b=Aez6284X4fivxdh6YBRsrut8K16GIjTaLgOtyR2yjn37Bma5eGsf1d0ACxQa6U9mgx
 q3/u3IIVgmenKkkwPrHnSCBJIPNntMnNquMC6PVvWwF7/UREIQ7e9mhWGMz4OfNk5chN
 rT95b8dRiocENnLVODd2P4sLU9xZ+c7qNOdzvDcqU8cB7dQjzcVREsgneu/nEiIxct8D
 Nmuz4NzOXglTk6QAb5f9CoqEsrCtZh0BMysv31yDD0DWJj6+Morrjc5Kl9GhxngLhqvi
 l/snzqt5Z23Bymn3VC2c2Q5Mt4Cbji2zxInn2UqIQOwzZknz/d5iKSe/BW0/htbfCGkT
 1X8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693980285; x=1694585085;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wkp1MQX8gIyLBWV4/FhnA2jRcxGZXLirbpCzzZteXiM=;
 b=X/kU35DpdXDyIDJwR7OZMwucLui5VQuiYQ7vbff7hGSQCs6W2sTLgBBQGg7pdnsTfH
 yFNQIZDjCQKtYRMI+DwZWWFka/pgGfol9jm3pyk44aWlDxZsa1WvxeZyZkoKexiX7aBp
 qjbG7nfU5GsCyluBDHqf7NkLN+UFu6pl22559GeR2/8GoYz74KlNapjMDUxPPVfiSAk4
 UfNquchAJyBjaaZAhkslQL40qoCQeAnbygK+jRXjOThkMfxlzzq3YRPRiPSkNplqB7J6
 aw7wmZuU6lgcGxRtWF2QEGiXjEZfF/fkTYHUqztYWNhC53l59vtx+8g6WPD8Bur+6gP4
 8LJg==
X-Gm-Message-State: AOJu0Yz7lp6Io5hv2xn0iFazcRF+Yzf7UmdXpnqKFQqQAaEwtyLz1How
 qaE6tqYMI7PH23R7Qa02FeBX0A==
X-Google-Smtp-Source: AGHT+IGuTmAN/OU5OaeeOFFYpAC3NxH0tvDrk++fCj7GM++aj+lMN7xKuCB6cfqMPVlv/6Fkea9ZLQ==
X-Received: by 2002:a17:906:7391:b0:9a5:852f:10bd with SMTP id
 f17-20020a170906739100b009a5852f10bdmr1252306ejl.62.1693980284762; 
 Tue, 05 Sep 2023 23:04:44 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-51-223.dsl.sta.abo.bbox.fr.
 [176.172.51.223]) by smtp.gmail.com with ESMTPSA id
 le18-20020a170906ae1200b0099bcbaa242asm8473948ejb.9.2023.09.05.23.04.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 23:04:44 -0700 (PDT)
Message-ID: <911eef0c-d04f-2fcf-e78b-2475cd7af8f0@linaro.org>
Date: Wed, 6 Sep 2023 08:04:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v5 3/4] vhost-user: add shared_object msg
Content-Language: en-US
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, kraxel@redhat.com, cohuck@redhat.com,
 Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20230802090824.91688-1-aesteve@redhat.com>
 <20230802090824.91688-4-aesteve@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230802090824.91688-4-aesteve@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/8/23 11:08, Albert Esteve wrote:
> Add three new vhost-user protocol
> `VHOST_USER_BACKEND_SHARED_OBJECT_* messages`.
> These new messages are sent from vhost-user
> back-ends to interact with the virtio-dmabuf
> table in order to add or remove themselves as
> virtio exporters, or lookup for virtio dma-buf
> shared objects.
> 
> The action taken in the front-end depends
> on the type stored in the virtio shared
> object hash table.
> 
> When the table holds a pointer to a vhost
> backend for a given UUID, the front-end sends
> a VHOST_USER_GET_SHARED_OBJECT to the
> backend holding the shared object.
> 
> In the libvhost-user library we need to add
> helper functions to allow sending messages to
> interact with the virtio shared objects
> hash table.
> 
> The messages can only be sent after successfully
> negotiating a new VHOST_USER_PROTOCOL_F_SHARED_OBJECT
> vhost-user protocol feature bit.
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>   docs/interop/vhost-user.rst               |  57 ++++++++
>   hw/virtio/vhost-user.c                    | 166 ++++++++++++++++++++++
>   include/hw/virtio/vhost-backend.h         |   3 +
>   subprojects/libvhost-user/libvhost-user.c | 118 +++++++++++++++
>   subprojects/libvhost-user/libvhost-user.h |  55 ++++++-
>   5 files changed, 398 insertions(+), 1 deletion(-)


> +static bool
> +vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr,
> +                                  VhostUserPayload *payload)
> +{
> +    Error *local_err = NULL;
> +    struct iovec iov[2];
> +
> +    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> +        hdr->flags &= ~VHOST_USER_NEED_REPLY_MASK;
> +    }
> +    hdr->flags |= VHOST_USER_REPLY_MASK;
> +
> +    hdr->size = sizeof(payload->u64);
> +
> +    iov[0].iov_base = hdr;
> +    iov[0].iov_len = VHOST_USER_HDR_SIZE;
> +    iov[1].iov_base = payload;
> +    iov[1].iov_len = hdr->size;
> +
> +    if (qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), &local_err)) {
> +        error_report_err(local_err);

This function could have a 'Error **errp' parameter to propagate
the error to the caller.

> +        return false;
> +    }
> +    return true;
> +}
> +
> +static bool
> +vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr,
> +                                  VhostUserPayload *payload)
> +{
> +    hdr->size = sizeof(payload->u64);
> +    return vhost_user_send_resp(ioc, hdr, payload);
> +}

I'm confused by having two vhost_user_backend_send_dmabuf_fd() functions
with different body...

> +int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *uuid,
> +                                 int *dmabuf_fd)
> +{
> +    struct vhost_user *u = dev->opaque;
> +    CharBackend *chr = u->user->chr;
> +    int ret;
> +    VhostUserMsg msg = {
> +        .hdr.request = VHOST_USER_GET_SHARED_OBJECT,
> +        .hdr.flags = VHOST_USER_VERSION,
> +    };
> +    memcpy(msg.payload.object.uuid, uuid, sizeof(msg.payload.object.uuid));
> +
> +    ret = vhost_user_write(dev, &msg, NULL, 0);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    ret = vhost_user_read(dev, &msg);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    if (msg.hdr.request != VHOST_USER_GET_SHARED_OBJECT) {
> +        error_report("Received unexpected msg type. "
> +                     "Expected %d received %d",
> +                     VHOST_USER_GET_SHARED_OBJECT, msg.hdr.request);
> +        return -EPROTO;
> +    }
> +
> +    *dmabuf_fd = qemu_chr_fe_get_msgfd(chr);
> +    if (*dmabuf_fd < 0) {
> +        error_report("Failed to get dmabuf fd");
> +        return -EIO;
> +    }
> +
> +    return 0;
> +}
> +
> +static int
> +vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
> +                                               QIOChannel *ioc,
> +                                               VhostUserHeader *hdr,
> +                                               VhostUserPayload *payload)

Also propagate a 'Error **errp'.

> +{
> +    QemuUUID uuid;
> +    CharBackend *chr = u->user->chr;
> +    int dmabuf_fd = -1;
> +    int fd_num = 0;
> +
> +    memcpy(uuid.data, payload->object.uuid, sizeof(payload->object.uuid));
> +
> +    payload->u64 = 0;
> +    switch (virtio_object_type(&uuid)) {
> +        case TYPE_DMABUF:
> +            dmabuf_fd = virtio_lookup_dmabuf(&uuid);
> +            break;
> +        case TYPE_VHOST_DEV:
> +        {
> +            struct vhost_dev *dev = virtio_lookup_vhost_device(&uuid);
> +            if (dev == NULL) {
> +                payload->u64 = -EINVAL;
> +                break;
> +            }
> +            int ret = vhost_user_get_shared_object(dev, uuid.data, &dmabuf_fd);
> +            if (ret < 0) {
> +                payload->u64 = ret;
> +            }
> +            break;
> +        }
> +        case TYPE_INVALID:
> +            payload->u64 = -EINVAL;
> +            break;
> +    }
> +
> +    if (dmabuf_fd != -1) {
> +        fd_num++;
> +    }
> +
> +    if (qemu_chr_fe_set_msgfds(chr, &dmabuf_fd, fd_num) < 0) {
> +        error_report("Failed to set msg fds.");
> +        payload->u64 = -EINVAL;
> +    }
> +
> +    if (!vhost_user_backend_send_dmabuf_fd(ioc, hdr, payload)) {
> +        error_report("Failed to write response msg.");
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}


