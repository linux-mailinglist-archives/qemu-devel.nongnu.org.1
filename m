Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C2982512E
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 10:50:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLgpF-0000Zq-DH; Fri, 05 Jan 2024 04:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLgpD-0000ZU-BM
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 04:49:11 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLgpB-00027I-KY
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 04:49:11 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50ea8fbf261so1535040e87.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 01:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704448147; x=1705052947; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=REezkvB0quUFLhMo/wFGY5GIi3LfzpoM+Qnjd3AbMHM=;
 b=eXVcXsVa2IjrM6SV+F0sMzl1/Mf1nvKDpt1wUWLYusWvO3YaBE3RdPeHiTFZ1QQG8U
 U0aZOTRTD43jdjvZRt2KK1U3HeOvpbUrX1MY8EkD3vsIWbyLpxD7Fq15U1mbS1kCyHec
 mS7AxIvnZYtd1shOKfWVq8DDMre1bq6GtMoai4mdRgjjMLYVDScrmJkt9OwnuXM6yh8V
 qR8UXV+KN4iYPRwhc+VolavmDJ/AhQiX8Jb5jqzoGzh2F2XigppP+uEpux7CdiEAtVlN
 4tp72uwQQihz0FRI3eu+Q9W9JbpmfiJLiYOEnUmB1exNGkAb4srL8X6WqOEZSUzNwaTQ
 /i3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704448147; x=1705052947;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=REezkvB0quUFLhMo/wFGY5GIi3LfzpoM+Qnjd3AbMHM=;
 b=xMaCKKX6upZhyEJ0Mgf5jIL7fQbOMcvyaQzkdf+A0NFXhLMPZMQCQdo2xC/rl2JJbb
 Cs0bHUj+xFbjikF6127k9zj/BcC7WbYtRDB2SE/zs2cl8o3YaCJdtQNT9Za4sWHj9wM/
 LolQewMyOtsqMT41oBfoMw2v8akWDhuZLgIGbgzhSfqr+Bewcx5UmLFbJMAl7WGb1E0M
 ODgw1ZCMNKr0dbhgzPRjt6ip/a7b2PjEXGi5bZvRs4+USXcGX18e+X66ZKCJSMAEocYF
 EMG1ItgmE+4/GT5AVsmZEOFjBVSXvn4Q4awW1ARPCZoBxrTHEUwZ3AuegRfQUVkiJXre
 heDg==
X-Gm-Message-State: AOJu0YzU+1+e1YJdEK/v8kiUJM8hcad6hu/LZjs/E/fV+NN3cU3Z3hwa
 zUupth1bavAiUtFANEmk2NrvJc2GXFHrkQ==
X-Google-Smtp-Source: AGHT+IG6Ce+VHs9SKU1ejBbdohYKZzPHqBbkqAlwhNdBhRZXi+lgtdJBrHbUFULIAL46GPh/jpDVJw==
X-Received: by 2002:a05:6512:2381:b0:50e:a789:dd3b with SMTP id
 c1-20020a056512238100b0050ea789dd3bmr1201890lfv.1.1704448147349; 
 Fri, 05 Jan 2024 01:49:07 -0800 (PST)
Received: from [192.168.69.100] (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 b6-20020a170906708600b00a268002274csm691648ejk.52.2024.01.05.01.49.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jan 2024 01:49:06 -0800 (PST)
Message-ID: <98246d7d-0e6f-45c3-91c2-2b2e1cd7fe93@linaro.org>
Date: Fri, 5 Jan 2024 10:49:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/11] virtio: split into vhost-user-base and
 vhost-user-device
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jason Wang <jasowang@redhat.com>, Erik Schilling
 <erik.schilling@linaro.org>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 virtio-fs@redhat.com, Hanna Reitz <hreitz@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20240104210945.1223134-1-alex.bennee@linaro.org>
 <20240104210945.1223134-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240104210945.1223134-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 4/1/24 22:09, Alex Bennée wrote:
> Lets keep a cleaner split between the base class and the derived
> vhost-user-device which we can use for generic vhost-user stubs. This
> includes an update to introduce the vq_size property so the number of
> entries in a virtq can be defined.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v5
>    - s/parent/parent_obj/
>    - remove left over vhost-user-device.h
>    - use DEFINE_TYPES
> v6
>    - rebase and set .abstract = true for vhost-user-device
> v7
>    - checkpatch line length + MAINTAINERS
>    - s/abstract = true/dc->user_creatable = false/ for both mmio and pci
> ---
>   MAINTAINERS                                   |   6 +
>   ...{vhost-user-device.h => vhost-user-base.h} |  21 +-
>   hw/virtio/vhost-user-base.c                   | 346 ++++++++++++++++++
>   hw/virtio/vhost-user-device-pci.c             |  13 +-
>   hw/virtio/vhost-user-device.c                 | 338 +----------------
>   hw/virtio/meson.build                         |   1 +
>   6 files changed, 383 insertions(+), 342 deletions(-)
>   rename include/hw/virtio/{vhost-user-device.h => vhost-user-base.h} (71%)
>   create mode 100644 hw/virtio/vhost-user-base.c


> @@ -358,6 +42,9 @@ static void vud_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
> +    /* Reason: stop inexperienced users confusing themselves */
> +    dc->user_creatable = false;


What about making VHOST_USER_DEVICE_PCI and
TYPE_VHOST_USER_DEVICE TypeInfos abstract instead?

> +
>       device_class_set_props(dc, vud_properties);
>       dc->vmsd = &vud_vmstate;
>       set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> @@ -366,14 +53,11 @@ static void vud_class_init(ObjectClass *klass, void *data)
>   static const TypeInfo vud_info = {
>       .name = TYPE_VHOST_USER_DEVICE,
>       .parent = TYPE_VHOST_USER_BASE,
> -    .instance_size = sizeof(VHostUserBase),
>       .class_init = vud_class_init,
> -    .class_size = sizeof(VHostUserBaseClass),
>   };

