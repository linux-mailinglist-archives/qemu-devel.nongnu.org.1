Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5818B7B7DC4
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 13:05:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnzgM-0003Bj-C3; Wed, 04 Oct 2023 07:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qnzgI-00039d-Bt
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:04:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qnzgD-00018o-H0
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696417475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i3khdJ0l6g/DFrmoNZvPtVEeNiwouZdlitocCgx7nQA=;
 b=AUl5ZkRszk1ddF2DnETPzLYd9DKCUUS8w5YvRBUovRllUt7oIDPNE7TZ25RGRUCPUZ+kgx
 61DNahoYueTbCaHiPHstDSxV2wEX4mkhJSJka9//XewPuHsiPuWX2nZ6GvpvtuFQQMtPRh
 dhsbfwLMVIhuI6MDRAkTpFJ43u1i9h0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537--3YfJyqJMcaoG3ySgnMXTQ-1; Wed, 04 Oct 2023 07:04:34 -0400
X-MC-Unique: -3YfJyqJMcaoG3ySgnMXTQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9adc78b386cso175839666b.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 04:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696417473; x=1697022273;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i3khdJ0l6g/DFrmoNZvPtVEeNiwouZdlitocCgx7nQA=;
 b=R6RuCcVQtE/srOKjK/bO5ZIFMCa20+qlP99zyp0tRk4jg94xrFcaOj8KVZoIZzlVJL
 1KhS0GCacbgMMEwHQivadnY0iXQeFAbasulebvDuKrbRYsBNL7+/V7tLmeLPS78ET9RU
 dM1omWoy5qdP2EvLt8EK9NNV+1MlJ5vuaS4UWhegL1j/RBycLpEsOnGN5NYX4LXe7ZQE
 dNskzhWV6fKFnO9Ki97iH+XKYR0mfgRrapWbEQT4HdtW0qKb3LoO6pe4KwEb/uFP5Una
 YuvlQn4KSWQkZe9behtREtspgH/0RkyxoD6Yt2/wgVVB4nexRW/Qq0Ti+wMG1F8lpETG
 Koqw==
X-Gm-Message-State: AOJu0YwsykUGz+txNqzw8Mupe6g3pp//jjLmp56Yu3bYypH8sc2649Zv
 hvVPf+kO5W2WRoZAu5T6X1qHfzzGpI+4xDl/L8ACjRMu+bqhk0zHkrGfOm6rMy5W7pJsMGgQRNC
 tPLAJb+b8ayUtmGk=
X-Received: by 2002:a17:907:7798:b0:9a9:f14a:22dc with SMTP id
 ky24-20020a170907779800b009a9f14a22dcmr1670548ejc.8.1696417473155; 
 Wed, 04 Oct 2023 04:04:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrqQzGZT226AqbfANq1sLQTrYf8gg/+AiG0OniUWR2Dg0ing06J24kfEi3Zik2KyqHCvXv2Q==
X-Received: by 2002:a17:907:7798:b0:9a9:f14a:22dc with SMTP id
 ky24-20020a170907779800b009a9f14a22dcmr1670535ejc.8.1696417472876; 
 Wed, 04 Oct 2023 04:04:32 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 jo3-20020a170906f6c300b0099df2ddfc37sm2621364ejb.165.2023.10.04.04.04.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 04:04:32 -0700 (PDT)
Message-ID: <b616b5ec-8739-d069-ae62-09a3d8cfbcf4@redhat.com>
Date: Wed, 4 Oct 2023 13:04:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/3] virtio: call ->vhost_reset_device() during reset
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Raphael Norwitz
 <raphael.norwitz@nutanix.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, eperezma@redhat.com,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20231004014532.1228637-1-stefanha@redhat.com>
 <20231004014532.1228637-4-stefanha@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231004014532.1228637-4-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 04.10.23 03:45, Stefan Hajnoczi wrote:
> vhost-user-scsi has a VirtioDeviceClass->reset() function that calls
> ->vhost_reset_device(). The other vhost devices don't notify the vhost
> device upon reset.
>
> Stateful vhost devices may need to handle device reset in order to free
> resources or prevent stale device state from interfering after reset.
>
> Call ->vhost_device_reset() from virtio_reset() so that that vhost
> devices are notified of device reset.
>
> This patch affects behavior as follows:
> - vhost-kernel: No change in behavior since ->vhost_reset_device() is
>    not implemented.
> - vhost-user: back-ends that negotiate
>    VHOST_USER_PROTOCOL_F_RESET_DEVICE now receive a
>    VHOST_USER_DEVICE_RESET message upon device reset. Otherwise there is
>    no change in behavior. DPDK, SPDK, libvhost-user, and the
>    vhost-user-backend crate do not negotiate
>    VHOST_USER_PROTOCOL_F_RESET_DEVICE automatically.
> - vhost-vdpa: an extra SET_STATUS 0 call is made during device reset.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   meson.build               |  1 +
>   include/hw/virtio/vhost.h | 10 ++++++++++
>   hw/scsi/vhost-user-scsi.c | 11 -----------
>   hw/virtio/vhost.c         |  9 +++++++++
>   hw/virtio/virtio.c        |  4 ++++
>   5 files changed, 24 insertions(+), 11 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


