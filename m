Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AE67D7D06
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 08:49:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvuA1-00043g-IW; Thu, 26 Oct 2023 02:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvu9z-00043S-F1
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 02:48:03 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvu9x-0000Eo-Nu
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 02:48:03 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-32db8924201so342732f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 23:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698302880; x=1698907680; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RlfNyiKqhmHcIHhkwbbS7IpD8oeQxl8RhFknRZ1yB3I=;
 b=EedCG78fXyP3C06dCWqSN3INryf5JM38kYoM8M9TeR5fc3X6mYmO5wUIIwyf2nMlqL
 k0/DiYLhrMkovwpzNWpsCCq6YHxlW5bSfw5lPSQycIZp1BkYI/f3D0RzIa2PfGDoIoWg
 ZbRx4FUSAAzQFDcDxPCsyLSVcj4tLf0nj9EYa4Xlh6Oz1iuUvcMVgFg3i0O2EXoNYPGA
 zx365IrNW5Zd4t1Ipahsh3CRLbj4y64VzYySK32fg/71xWt9/ycPkvt+wVWNYv1RDw7j
 xSIXCKXtQutPImxjmD5RlJb89h3m698jq2M3qfCP3ohXKijMoZiWXizC8yKzG8xpyhYO
 myNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698302880; x=1698907680;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RlfNyiKqhmHcIHhkwbbS7IpD8oeQxl8RhFknRZ1yB3I=;
 b=QK5OItm36O9kdJD1m3JW6u5MgIQw1M4ED7s1OLMV+md9BipcGq6tHm+KSBGllYVu91
 e6RZRfbRzoufeuoycEFJI7JKRjKnv0/7PUUsV/s6wwun5KMnobw4rpmzsXTKNTc/KuOK
 eECZBvtxqu3hAaD5I4Qr62m9J0j7TZhlfUntMdHeQKnSym1vdhDyxmlCSj7yG4E9LbI6
 3DyKH0uEk5M9CUzDG3i5YP96+aACDEhqkkerUcbdcC4C0em3Dg9+nEkd2gsQlaEuf8BA
 2zYI83uYtmIL6nLwt/24QXtbdPwLCohKgBoejFec96S0c2nwhYSZbSZoLHzP1U93ir5r
 qSnw==
X-Gm-Message-State: AOJu0Yx429J5V0AdnrkoQenePSa3DPTKj94fJ0X/+wBw+0ZBEH9da7+7
 eUFON9AnWdWAs2FLoV2dQaFTAQ==
X-Google-Smtp-Source: AGHT+IEvW2eH/a+Z/J1N8DLg1j95Nmkb4DP5VCJNphuLdHZaqa7a8Zu3waLecb76EObit6rqZj9HfQ==
X-Received: by 2002:adf:ef8b:0:b0:32d:96a7:9551 with SMTP id
 d11-20020adfef8b000000b0032d96a79551mr11856453wro.36.1698302879631; 
 Wed, 25 Oct 2023 23:47:59 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-114-150.dsl.sta.abo.bbox.fr. [176.172.114.150])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adfe7d0000000b0032db8f7f378sm13598930wrn.71.2023.10.25.23.47.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 23:47:59 -0700 (PDT)
Message-ID: <e2c1163d-087c-c2dd-31c4-a2bd970a95aa@linaro.org>
Date: Thu, 26 Oct 2023 08:47:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] virtio: rng: Check notifier helpers for
 VIRTIO_CONFIG_IRQ_IDX
Content-Language: en-US
To: Mathieu Poirier <mathieu.poirier@linaro.org>, mst@redhat.com
Cc: viresh.kumar@linaro.org, lulu@redhat.com, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20231025171841.3379663-1-mathieu.poirier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231025171841.3379663-1-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

Hi Mathieu,

On 25/10/23 19:18, Mathieu Poirier wrote:
> Since the driver doesn't support interrupts, we must return early when
> index is set to VIRTIO_CONFIG_IRQ_IDX.  Basically the same thing Viresh
> did for "91208dd297f2 virtio: i2c: Check notifier helpers for
> VIRTIO_CONFIG_IRQ_IDX".
> 
> Fixes: 544f0278afca ("virtio: introduce macro VIRTIO_CONFIG_IRQ_IDX")
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   hw/virtio/vhost-user-rng.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/hw/virtio/vhost-user-rng.c b/hw/virtio/vhost-user-rng.c
> index 201a39e220c5..62142b717f73 100644
> --- a/hw/virtio/vhost-user-rng.c
> +++ b/hw/virtio/vhost-user-rng.c
> @@ -129,6 +129,14 @@ static void vu_rng_guest_notifier_mask(VirtIODevice *vdev, int idx, bool mask)
>   {
>       VHostUserRNG *rng = VHOST_USER_RNG(vdev);
>   
> +    /*
> +     * We don't support interrupts, return early if index is set to
> +     * VIRTIO_CONFIG_IRQ_IDX.
> +     */
> +    if (idx == VIRTIO_CONFIG_IRQ_IDX) {
> +        return;
> +    }
> +
>       vhost_virtqueue_mask(&rng->vhost_dev, vdev, idx, mask);
>   }
>   
> @@ -136,6 +144,14 @@ static bool vu_rng_guest_notifier_pending(VirtIODevice *vdev, int idx)
>   {
>       VHostUserRNG *rng = VHOST_USER_RNG(vdev);
>   
> +    /*
> +     * We don't support interrupts, return early if index is set to
> +     * VIRTIO_CONFIG_IRQ_IDX.
> +     */
> +    if (idx == VIRTIO_CONFIG_IRQ_IDX) {
> +        return false;
> +    }
> +
>       return vhost_virtqueue_pending(&rng->vhost_dev, idx);
>   }

The patch looks fine, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Now I wonder if we shouldn't add that check one layer above in the
caller, eventually checking a VirtioDeviceClass::irq_supported bool.
This is out of the scope of this patch.

Regards,

Phil.

