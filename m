Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9287970B1
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 10:20:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeAFH-0005lm-20; Thu, 07 Sep 2023 04:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeAEx-0005kY-BG
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:19:51 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeAEu-000687-H3
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:19:51 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-501cba1ec0aso1030764e87.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 01:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694074787; x=1694679587; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nAccg4g5WedsSNaE/qJX8rRRbybDHFAji3Av1eW98og=;
 b=S9m//vozUWn6T+11J3EhO2htMGzpX4t1jFOb6MXLWMhTN9lrN+tFr12pZ/pOGW7ojL
 COV+iZ/XWL9k+0QEQiPhcvI+btGMnNCdN7/TYZn3/O8VPBamcjrYlqUl7fjUmTMSaPnV
 KSbcnHyisz4y6AoU4eNw5JId7vWRbclfFJ6DmPtew0YOfOdEb0K6iNTufNHXPc95g/57
 OA6enNcqN5b1q+nVA2oeu/uPkzaXGj05L+rkRKfeqGAiwCXzYa1Ij+Yy92pOgt0t3H2Y
 EUwN/VQNP/4eLV9YxC4yH7ypmurPjvpBUjN1h0i3WceIb6tIpCoXsGICIM1ACG18JG7C
 Gt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694074787; x=1694679587;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nAccg4g5WedsSNaE/qJX8rRRbybDHFAji3Av1eW98og=;
 b=To8DHlWGiMZGrrRhl4PQU7DLp4psLSdnXWfpbUjLoOrYtenNvJh71yXrMECRHBadzh
 zUh9PPj3lnpOoZzbRkMhfKLUup07o5r+J9dy6rZVF01506GElPsY9wIfydu1JJnnxHwD
 fwZgj5OH8BHmmqvZaad5psKk4vHzc2brYpUEXJnruEUX0HjrXYNoA5r6Vx1F3tcS+JT8
 cefHq0ZJpDLcxva6oK5RBX6xuy4zKCGEvConmpGZo+VM0pOBG17SDS7Z7V9RAoAnl0SZ
 v4VwLojTAPZ7eHZ2hstCvtkwvYGuZR3WRKdLU+4eZCRTyxCztyBbyuEGSlcQSx1JGiIe
 SNGQ==
X-Gm-Message-State: AOJu0Yx6DQnETX3mj+yGa4QE3IJSbvM6QrIvAAk4Ou53nt94iEEs2j3x
 fH80oBjmn9QW4Sm3DM/11n2BNw==
X-Google-Smtp-Source: AGHT+IEjGRUpphoyK/d5kgUb8EDmUVrlH8tdRoR7hExHduG4VzL3VkqfsApqqPqeUPOoGl3f5Gfxsg==
X-Received: by 2002:a19:3857:0:b0:500:7d05:552a with SMTP id
 d23-20020a193857000000b005007d05552amr3919812lfj.53.1694074786785; 
 Thu, 07 Sep 2023 01:19:46 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-226.abo.bbox.fr.
 [176.131.222.226]) by smtp.gmail.com with ESMTPSA id
 r9-20020aa7d589000000b0052a1c0c859asm9513055edq.59.2023.09.07.01.19.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 01:19:46 -0700 (PDT)
Message-ID: <200d8e04-ffec-5aee-0a2b-84b947a57086@linaro.org>
Date: Thu, 7 Sep 2023 10:19:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v7 2/4] virtio-dmabuf: introduce virtio-dmabuf
Content-Language: en-US
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, cohuck@redhat.com, kraxel@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Fam Zheng <fam@euphon.net>
References: <20230907074318.528064-1-aesteve@redhat.com>
 <20230907074318.528064-3-aesteve@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230907074318.528064-3-aesteve@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

On 7/9/23 09:43, Albert Esteve wrote:
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
>   hw/display/virtio-dmabuf.c        | 136 +++++++++++++++++++++++++++++
>   include/hw/virtio/virtio-dmabuf.h | 103 ++++++++++++++++++++++
>   tests/unit/meson.build            |   1 +
>   tests/unit/test-virtio-dmabuf.c   | 137 ++++++++++++++++++++++++++++++
>   6 files changed, 385 insertions(+)
>   create mode 100644 hw/display/virtio-dmabuf.c
>   create mode 100644 include/hw/virtio/virtio-dmabuf.h
>   create mode 100644 tests/unit/test-virtio-dmabuf.c


> diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/virtio-dmabuf.h
> new file mode 100644
> index 0000000000..202eec5868
> --- /dev/null
> +++ b/include/hw/virtio/virtio-dmabuf.h
> @@ -0,0 +1,103 @@
> +/*
> + * Virtio Shared dma-buf
> + *
> + * Copyright Red Hat, Inc. 2023
> + *
> + * Authors:
> + *     Albert Esteve <aesteve@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef VIRTIO_DMABUF_H
> +#define VIRTIO_DMABUF_H
> +
> +#include "qemu/osdep.h"

See https://www.qemu.org/docs/master/devel/style.html#include-directives

   Do not include “qemu/osdep.h” from header files since the .c
   file will have already included it.

> +#include <glib.h>

This one is also included via "qemu/osdep.h" -> "glib-compat.h"

> +#include "qemu/uuid.h"
> +#include "vhost.h"
> +
> +typedef enum SharedObjectType {
> +    TYPE_INVALID = 0,
> +    TYPE_DMABUF,
> +    TYPE_VHOST_DEV,
> +} SharedObjectType;
> +
> +typedef struct VirtioSharedObject {
> +    SharedObjectType type;
> +    gpointer value;
> +} VirtioSharedObject;

Since this need a repost, better use "hw/display: Introduce 
virtio-dmabuf" as patch subject (and "util/uuid" prefix for the previous 
patch).

Otherwise LGTM, so with these changes:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


