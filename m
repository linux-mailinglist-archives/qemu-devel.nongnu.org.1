Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C007937DA
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:17:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdoeP-0002Ro-EB; Wed, 06 Sep 2023 05:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdoeL-0002Nq-LE
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:16:37 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdoeI-0005Xd-MM
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:16:37 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-501bd7711e8so2912270e87.1
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 02:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693991792; x=1694596592; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xGd39gv0uJeOo6HcThBWjEYjPgZB6zCH8FBMkj+cjbY=;
 b=t7BQpFawfDwhitWAxHIImNZ1DamBivGCfIfS/ScFT5z2M7DFsvtOnVIY1rjcxEtczN
 S8ST4HtkYRLC5a2fE0BhSY1GdSlYS0+PeV6ZuxtYmLkGTxmZ8UxvputGc8LlSsrHjzXy
 rKs6By2KOF8LxjP204gnvTBG+jKYFjpUnJJ0Aqz2/UkRxLm8q1mhMZIBJTGgtrgAg99Y
 wF0DYO4lG9xAgJQllTgBvDHWeMxnD0KlKtnwbKm7QH0RIczGXuYw9ndfnsvqou23zKv8
 zkEn/Dqk0M6/GTSNf+sEKdVfNqZ3NXWveB207KdxXITVl8n7e8yECibC6m7Sj2pKgH/i
 ZW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693991792; x=1694596592;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xGd39gv0uJeOo6HcThBWjEYjPgZB6zCH8FBMkj+cjbY=;
 b=gGSCVSXyTHLiJIY1SA6ESmYQKyO2bij1tgGUOeOgqGDKtNAXaWP+RyzAZkISAQY3gU
 N41od3BSZ7qZWUebZ4/aEpQr4sNCIgDPdam6gPdzCU8q4H/WyILs0ieSEl6Q8NntYmNz
 Xm6MRGQU2A2DTLb9C8gM+8EEAPiRLyjbca26IcjiUXN+BBkbTa6iyhlHX2JppsPGmIdR
 q9N6zoBU6aFmziNt2lchptE8KK9v5PFiV6phCCHuLiTB6Ec7hnIlaBhoko3OKXgAKgej
 55tTU+eBxHbldTAaU52ek4AosY1zDBTxbIAK8Zwq7cVW0fvUqVakR1Ybwqf11kjTiPgL
 3UHw==
X-Gm-Message-State: AOJu0Yyp/MBBjSnfMUcajgd6xEfncarxhFlcXILMJKrckJFe9tzOcjAH
 46yLZaSbyns3yR4Qwx6ZWdJgQpFehwJy2i9YsN8=
X-Google-Smtp-Source: AGHT+IEROj017BiQnJaiWUBWwR/zsKcHLqSkJCskrREznMuyoTa6swqmEF5YrZ5LObtgYyM/IUQg4Q==
X-Received: by 2002:a05:6512:3713:b0:500:b8bc:bd9a with SMTP id
 z19-20020a056512371300b00500b8bcbd9amr1685231lfr.49.1693991792396; 
 Wed, 06 Sep 2023 02:16:32 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-51-223.dsl.sta.abo.bbox.fr.
 [176.172.51.223]) by smtp.gmail.com with ESMTPSA id
 d19-20020a05640208d300b00523b1335618sm7977025edz.97.2023.09.06.02.16.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 02:16:31 -0700 (PDT)
Message-ID: <579322f6-be00-f030-1eec-8c051c6c93fc@linaro.org>
Date: Wed, 6 Sep 2023 11:16:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v5 2/4] virtio-dmabuf: introduce virtio-dmabuf
Content-Language: en-US
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, kraxel@redhat.com,
 cohuck@redhat.com, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20230802090824.91688-1-aesteve@redhat.com>
 <20230802090824.91688-3-aesteve@redhat.com>
 <e6b6abb1-921b-43d7-054a-71042b0f4e38@linaro.org>
 <CADSE00KS0KTXTdq+AdAd57qwz-ZNQRxSqhizhs+qaJ8MpGRChA@mail.gmail.com>
 <CADSE00Jq9iJDD7ojjth4eyU=fxVvjexWp8AYKZyDZT8ZrJyDHQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CADSE00Jq9iJDD7ojjth4eyU=fxVvjexWp8AYKZyDZT8ZrJyDHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

On 6/9/23 10:45, Albert Esteve wrote:

>          > diff --git a/include/hw/virtio/virtio-dmabuf.h
>         b/include/hw/virtio/virtio-dmabuf.h
>          > new file mode 100644
>          > index 0000000000..536e622555
>          > --- /dev/null
>          > +++ b/include/hw/virtio/virtio-dmabuf.h
>          > @@ -0,0 +1,103 @@
>          > +/*
>          > + * Virtio Shared dma-buf
>          > + *
>          > + * Copyright Red Hat, Inc. 2023
>          > + *
>          > + * Authors:
>          > + *     Albert Esteve <aesteve@redhat.com
>         <mailto:aesteve@redhat.com>>
>          > + *
>          > + * This work is licensed under the terms of the GNU GPL,
>         version 2.
>          > + * See the COPYING file in the top-level directory.
>          > + */
>          > +
>          > +#ifndef VIRTIO_DMABUF_H
>          > +#define VIRTIO_DMABUF_H
>          > +
>          > +#include "qemu/osdep.h"
>          > +
>          > +#include <glib.h>
>          > +#include "qemu/uuid.h"
>          > +#include "vhost.h"
>          > +
>          > +enum SharedObjectType {
>          > +    TYPE_INVALID = 0,
>          > +    TYPE_DMABUF,
>          > +    TYPE_VHOST_DEV,
>          > +};
>          > +
> 
>         Please declare a
> 
>         typedef
> 
>          > +struct VirtioSharedObject {
>          > +    enum SharedObjectType type;
>          > +    gpointer value;
>          > +};
> 
>         VirtioSharedObject;
> 
>         and use it instead of 'struct VirtioSharedObject'.
> 
> 
>     You mean making the struct anonymous and typedefing?
> 
> 
> So after re-reading your comment and looking for more examples in the 
> codebase, I see
> it is not uncommon to have a named struct also typedef in the same 
> declaration.
> So I will typedef, but not make it anonymous, same for the enum.

Correct (see https://qemu-project.gitlab.io/qemu/devel/style.html#typedefs

>     Should I do the same with the enum? In other files I see enums are
>     typedef too, but not anonymous (e.g., block/qcow2.h).
>     So I could do the same here.
> 
>     For the rest... Ack!

Thanks!

Phil.


