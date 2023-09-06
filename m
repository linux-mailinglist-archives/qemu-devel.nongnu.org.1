Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84872793529
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 08:11:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdllG-0008I1-JY; Wed, 06 Sep 2023 02:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdll5-0008Gz-DL
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 02:11:24 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdll3-0005Hd-6K
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 02:11:23 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-99de884ad25so505174366b.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 23:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693980679; x=1694585479; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ELKEyvM2yaorgj/pBxRS47Ft2l/wjkKsMSVTTEfp3H8=;
 b=niYOyjetKiLA+An/iJVXMd0nzCUlMI8OREAiOBTxdzoQRX6LBV0ijztD6SX0vOaofm
 Phf1O00plIQ2GLZAEGcQjCbzRStM1xd2+ppaly4LhnnFVI09QncvD+ZwYAzHM9txJcEW
 0matALOOcDmpUphMC8Qb5kOdn37U+skfMBxhOtz1ryGOoEO6rMhdr6evVEJZBXPvlidE
 wvkD0pLC4y7VoUEYohxXvKTD7VOwtZXCJfLwYa2wHFdJOgELt4UZH87uzhcXKwFI+dkE
 PHwpDE9DVj+I3KE1L60vg9sh4w6tjAc5F0rIKURAV5UMNnAZXmybbcsc1l80rvC4+B8n
 cNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693980679; x=1694585479;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ELKEyvM2yaorgj/pBxRS47Ft2l/wjkKsMSVTTEfp3H8=;
 b=CaFeAOJayO75dlY0REwdSyah+j7e0VXLRtmRY5gubb5YrnEAVKGSfJD9A2b/vwLXuO
 JrJOtpYDiqGdwcGhEt8ZVk/WJIlcRmPII9NjCXqgCdG6/W3ESeABWpuaRGuBonqY9PdH
 Kwp+8ydV7qWwqPENIIrOludbtGZylTTujvEzvk0ehi3raVBP31oawxBG1K2pydtYQIKu
 iYEGohvH58ldHaD2JWsdcnXq6ygXLh1GDv0McWJwIMXe5XP7DQOK5P3CvPlWWxhd5UpI
 EHOz20yuQzNFLLBxeQ83lO1XxgeKa3GKrMsybTecX165nv3ma4Tm51MyBXu6c5J6hUiy
 sfaw==
X-Gm-Message-State: AOJu0YyuhCzvJpIFAjgFxt0BMWqIf40a5TaCVeAnWBaOSFDJ5jfsKVmP
 S/CV7Xh9jp6NoLz7mjEKAUetQQ==
X-Google-Smtp-Source: AGHT+IGk+o3J39Q7wLmrdkxamfP8iBJpH8AcsTGvv6CgTZpugu4wPkC20bnfVzNdLfIFYDIioSOXPQ==
X-Received: by 2002:a17:907:2ce7:b0:9a5:b876:b1e3 with SMTP id
 hz7-20020a1709072ce700b009a5b876b1e3mr1341821ejc.20.1693980679456; 
 Tue, 05 Sep 2023 23:11:19 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-51-223.dsl.sta.abo.bbox.fr.
 [176.172.51.223]) by smtp.gmail.com with ESMTPSA id
 k13-20020a17090646cd00b00997e00e78e6sm8503695ejs.112.2023.09.05.23.11.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 23:11:18 -0700 (PDT)
Message-ID: <5521b168-47fe-50fe-8697-9a85d94a5e5a@linaro.org>
Date: Wed, 6 Sep 2023 08:11:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v5 4/4] vhost-user: refactor send_resp code
Content-Language: en-US
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, kraxel@redhat.com, cohuck@redhat.com,
 Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20230802090824.91688-1-aesteve@redhat.com>
 <20230802090824.91688-5-aesteve@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230802090824.91688-5-aesteve@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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
> Refactor code to send response message so that
> all common parts both for the common REPLY_ACK
> case, and other data responses, can call it and
> avoid code repetition.
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>   hw/virtio/vhost-user.c | 36 +++++++++---------------------------
>   1 file changed, 9 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 104a56a48d..28fa0ace42 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1632,29 +1632,23 @@ vhost_user_backend_handle_shared_object_remove(VhostUserShared *object)
>       return virtio_remove_resource(&uuid);
>   }
>   
> -static bool
> -vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr,
> -                                  VhostUserPayload *payload)
> +static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hdr,
> +                                 VhostUserPayload *payload)

Squash this patch with the previous one (in particular
because this fixes the build failure).


