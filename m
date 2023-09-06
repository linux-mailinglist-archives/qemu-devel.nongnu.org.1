Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ECC793EA7
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 16:22:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdtPo-0003qi-Vs; Wed, 06 Sep 2023 10:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdtPZ-0003os-Rb
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:21:42 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdtPU-0003C9-EK
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:21:39 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4c0so2227790a12.0
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 07:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694010095; x=1694614895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=loA6p7ewRgoInrzBZwsV2T/2uT7kXiuE4wiTsrqbzaM=;
 b=PL/d14V5/qP9arm0vXrP4kQwC0YVyXlXL7aeTqSoDiaIMg/7YygvMtjfWxvTrzVKLm
 EQNRbbwhWuvxAf4AC7ihH1P5M+fy0jesBGqlvsULouydIu2zeW+FerMom74melF5nKOX
 xn4KWGs4d7KNmKjnYiAMZ33EHOrzXRriBbC787ikpffZrMKdj3QeJHCp73PscVm361wL
 thuYlAh1OojRcljtqv1Kp3GkZjPiPkGPijzBkg4v66JG42dWmXbIX1E4eLmQsSt1yAWy
 Cbqndl06v+d2/K9EEtJDkhOwIfBIHoZbfQYztcxO0rG7vCcS/dEWw8qDWp3CHldJrRoq
 CK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694010095; x=1694614895;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=loA6p7ewRgoInrzBZwsV2T/2uT7kXiuE4wiTsrqbzaM=;
 b=Rl5nNWVx2PDvwZFBvOvslJLfKMre21PzBsUF/pi3VDTbCWffW8Qx/KVG2ExLT+9TPy
 jfI/IzGf5U94Q+TvV/d/BBsGMsCpvi45F2PGhkZYZHfyNAnZD0n1fd+EwpN9Z0va4AkI
 E+5BAIAmgzvvF8Py53ckhdx1X4R8C7IghJ2HS6oRuFfhKmrR4gkj8op5bTRYHGX3+2s9
 3Dq/s5KNzKoaVy/AwYMUL5ZFB0oEXszBvssx7u8VuvRnzzI4SmDKRXRFWe9m8qZZRXmV
 H69/2haVlf05jr7SRl3WM50yySGthu44uhmlabrrJ+bl0yOJR6N7HiaG6HrUuOwMLG82
 cRWQ==
X-Gm-Message-State: AOJu0Yy2UxUYCz5kqSRID6R48I90DXSwRIaZeu2KxQ6zX2yzdHOCZYq5
 Go5Ds4d3X8/jtcXqapQz/6O86Q==
X-Google-Smtp-Source: AGHT+IEyeIRwwiss80ecavjxE2lCQkLUGIDLRUkbl4cHnmEKBUpfCmpuvzYRGustDg8J+fkf+a+R6g==
X-Received: by 2002:aa7:ca49:0:b0:52a:38c3:1b4b with SMTP id
 j9-20020aa7ca49000000b0052a38c31b4bmr3068266edt.15.1694010094804; 
 Wed, 06 Sep 2023 07:21:34 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-51-223.dsl.sta.abo.bbox.fr.
 [176.172.51.223]) by smtp.gmail.com with ESMTPSA id
 w4-20020aa7da44000000b0052241b8fd0bsm8474442eds.29.2023.09.06.07.21.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 07:21:34 -0700 (PDT)
Message-ID: <c53f4cae-7014-066a-de3d-09f47b27dbc6@linaro.org>
Date: Wed, 6 Sep 2023 16:21:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v6 2/3] virtio-dmabuf: introduce virtio-dmabuf
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 cohuck@redhat.com, kraxel@redhat.com, marcandre.lureau@gmail.com
References: <20230906111549.357178-1-aesteve@redhat.com>
 <20230906111549.357178-3-aesteve@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230906111549.357178-3-aesteve@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

On 6/9/23 13:15, Albert Esteve wrote:
> This API manages objects (in this iteration,
> dmabuf fds) that can be shared along different
> virtio devices, associated to a UUID.
> 
> The API allows the different devices to add,
> remove and/or retrieve the objects by simply
> invoking the public functions that reside in the
> virtio-dmabuf file.
> 
> For vhost backends, the API stores the pointer
> to the backend holding the object.
> 
> Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>   MAINTAINERS                       |   7 ++
>   hw/display/meson.build            |   1 +
>   hw/display/virtio-dmabuf.c        | 134 +++++++++++++++++++++++++++++
>   include/hw/virtio/virtio-dmabuf.h | 103 ++++++++++++++++++++++
>   tests/unit/meson.build            |   1 +
>   tests/unit/test-virtio-dmabuf.c   | 137 ++++++++++++++++++++++++++++++
>   6 files changed, 383 insertions(+)
>   create mode 100644 hw/display/virtio-dmabuf.c
>   create mode 100644 include/hw/virtio/virtio-dmabuf.h
>   create mode 100644 tests/unit/test-virtio-dmabuf.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b29568ed4..fb0f7b823f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2150,6 +2150,13 @@ T: git https://gitlab.com/cohuck/qemu.git s390-next
>   T: git https://github.com/borntraeger/qemu.git s390-next
>   L: qemu-s390x@nongnu.org
>   
> +virtio-dmabuf
> +M: Albert Esteve <aesteve@redhat.com>
> +S: Supported
> +F: hw/display/virtio-dmabuf.c
> +F: include/hw/virtio/virtio-dmabuf.h
> +F: tests/unit/test-virtio-dmabuf.c
> +
>   virtiofs
>   M: Stefan Hajnoczi <stefanha@redhat.com>
>   S: Supported
> diff --git a/hw/display/meson.build b/hw/display/meson.build
> index 413ba4ab24..05619c6968 100644
> --- a/hw/display/meson.build
> +++ b/hw/display/meson.build
> @@ -37,6 +37,7 @@ system_ss.add(when: 'CONFIG_MACFB', if_true: files('macfb.c'))
>   system_ss.add(when: 'CONFIG_NEXTCUBE', if_true: files('next-fb.c'))
>   
>   system_ss.add(when: 'CONFIG_VGA', if_true: files('vga.c'))
> +system_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-dmabuf.c'))
>   
>   if (config_all_devices.has_key('CONFIG_VGA_CIRRUS') or
>       config_all_devices.has_key('CONFIG_VGA_PCI') or
> diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
> new file mode 100644
> index 0000000000..268ffe81ec
> --- /dev/null
> +++ b/hw/display/virtio-dmabuf.c
> @@ -0,0 +1,134 @@
> +/*
> + * Virtio Shared dma-buf
> + *
> + * Copyright Red Hat, Inc. 2023
> + *
> + * Authors:
> + *     Albert Esteve <aesteve@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "hw/virtio/virtio-dmabuf.h"
> +
> +
> +static GMutex lock;
> +static GHashTable *resource_uuids;
> +
> +/*
> + * uuid_equal_func: wrapper for UUID is_equal function to
> + * satisfy g_hash_table_new expected parameters signatures.
> + */
> +static int uuid_equal_func(const void *lhv, const void *rhv)
> +{
> +    return qemu_uuid_is_equal(lhv, rhv);
> +}
> +
> +static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject *value)
> +{
> +    bool result;
> +    g_mutex_lock(&lock);
> +    if (resource_uuids == NULL) {
> +        resource_uuids = g_hash_table_new_full(
> +            qemu_uuid_hash, uuid_equal_func, NULL, g_free);
> +    }
> +    if (g_hash_table_lookup(resource_uuids, uuid) != NULL) {
> +        g_mutex_unlock(&lock);
> +        return false;
> +    }
> +    result = g_hash_table_insert(resource_uuids, uuid, value);
> +    g_mutex_unlock(&lock);
> +
> +    return result;
> +}

Alternatively same logic, but simpler / safer:

static bool virtio_add_resource(...)
{
     bool result = false;

     g_mutex_lock(&lock);
     if (resource_uuids == NULL) {
         resource_uuids = g_hash_table_new_full(qemu_uuid_hash,
                                                uuid_equal_func,
                                                NULL,
                                                g_free);
     }
     if (g_hash_table_lookup(resource_uuids, uuid) == NULL) {
        result = g_hash_table_insert(resource_uuids, uuid, value);
     }
     g_mutex_unlock(&lock);

     return result;
}

> +static VirtioSharedObject *get_shared_object(const QemuUUID *uuid)
> +{
> +    g_mutex_lock(&lock);
> +    if (resource_uuids == NULL) {
> +        g_mutex_unlock(&lock);
> +        return NULL;
> +    }
> +    gpointer lookup_res = g_hash_table_lookup(resource_uuids, uuid);
> +    g_mutex_unlock(&lock);
> +    return (VirtioSharedObject*) lookup_res;
> +}

Similarly:

static VirtioSharedObject *get_shared_object(const QemuUUID *uuid)
{
     gpointer lookup_res = NULL;

     g_mutex_lock(&lock);
     if (resource_uuids != NULL) {
         lookup_res = g_hash_table_lookup(resource_uuids, uuid);
     }
     g_mutex_unlock(&lock);

     return (VirtioSharedObject *)lookup_res;
}

> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    g_test_add_func("/virtio-dmabuf/add_rm_res", test_add_remove_resources);
> +        g_test_add_func("/virtio-dmabuf/add_rm_dev", test_add_remove_dev);

Mis-indent.

> +    g_test_add_func("/virtio-dmabuf/rm_invalid_res",
> +                    test_remove_invalid_resource);
> +    g_test_add_func("/virtio-dmabuf/add_invalid_res",
> +                    test_add_invalid_resource);
> +    g_test_add_func("/virtio-dmabuf/free_res", test_free_resources);
> +
> +    return g_test_run();
> +}

Thanks for updating, LGTM!


