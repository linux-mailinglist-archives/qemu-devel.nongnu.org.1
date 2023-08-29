Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B70C78C0BD
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 10:47:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qauMr-0006yj-KN; Tue, 29 Aug 2023 04:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qauMp-0006yU-QK
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:46:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qauMj-00076f-OM
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693298782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zl6YNOtPQc/5q9fjWL1VM/ODw3ja7xvsw3fr3/nSdt4=;
 b=I8h+XstPrjA//9uEum9kskBqkXzxBeW13AOlBOInm0+mamfTTsNeQhpnUnHCxDI4oAIoVH
 ASVxyEdpI9An2WTJvbVSdn4iglhYhFWHgwuuqM2buNRiWiafvGwUcRlwFtRHkRRYsS18on
 6ujIhOW5qOXc5L9cuiKGcBK8FtfnhjI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-n1GF2etqN5a4v-Y1YARNbw-1; Tue, 29 Aug 2023 04:46:20 -0400
X-MC-Unique: n1GF2etqN5a4v-Y1YARNbw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9a198d4d98aso303820066b.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 01:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693298779; x=1693903579;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zl6YNOtPQc/5q9fjWL1VM/ODw3ja7xvsw3fr3/nSdt4=;
 b=fsSx6w65tx4AJdrYhSkGRd9Irzj1LmHgIUz1ZLMC7SzjL/DmPfoYJEy8izDsHUV9kn
 lVk9o0ZWPebAnm5BFyl8lNt5lWaqujSYWJIN+7GyMU09NOp7pwQn6KwZXsHu9O6qAMqm
 +0O+iOQI5xiQ58TkMsOJJGJw6RCVyqk8g4Gs744qTjho+L4smw7CTvjvNnQlvYl108vf
 xWpBih4Xb6Pqa6QJf7mymjlKG8Qt3VU+Dul3O8JoWoS9Ey/uy23pZatUqWjrTs8G6wmf
 OpquBTWPlel2qAaC+qeMOgpPYeoMV9W08UTJaOlSXKljx256+Wogl18Rfc9JECivW46g
 ayfA==
X-Gm-Message-State: AOJu0YxZl42S0F/bs1SP5lYX47R96KyqJvn6a6fhLWo+H6S6MUR9Iqnh
 xPqk5NxOh20RMnKqCtWDEcPi2NOZK74O16cI9LYhFsKyQLsZIOnHCnfW0xocF5dhI89AATvfPaK
 xfUkR4LjyOGG/9kM=
X-Received: by 2002:a17:906:d14d:b0:9a5:8eab:49da with SMTP id
 br13-20020a170906d14d00b009a58eab49damr6907551ejb.19.1693298779522; 
 Tue, 29 Aug 2023 01:46:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwZA2OTqOH635+Jc4+FJwsPdHLhpQIqx7A1gr4Kneb+4B8q7mBYKsLJLB5YeJO+Bac8pYO1A==
X-Received: by 2002:a17:906:d14d:b0:9a5:8eab:49da with SMTP id
 br13-20020a170906d14d00b009a58eab49damr6907535ejb.19.1693298779159; 
 Tue, 29 Aug 2023 01:46:19 -0700 (PDT)
Received: from ?IPV6:2003:cf:d70f:5ee0:6d7a:8486:6b83:8d37?
 (p200300cfd70f5ee06d7a84866b838d37.dip0.t-ipconnect.de.
 [2003:cf:d70f:5ee0:6d7a:8486:6b83:8d37])
 by smtp.gmail.com with ESMTPSA id
 gy25-20020a170906f25900b0098951bb4dc3sm5678407ejb.184.2023.08.29.01.46.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 01:46:18 -0700 (PDT)
Message-ID: <32a9c17b-2020-d95a-27b0-af4a012e5a77@redhat.com>
Date: Tue, 29 Aug 2023 10:46:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] qemu-img: map: report compressed data blocks
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 eblake@redhat.com, vsementsov@yandex-team.ru, den@virtuozzo.com
References: <20230706163047.128999-1-andrey.drobyshev@virtuozzo.com>
 <20230706163047.128999-3-andrey.drobyshev@virtuozzo.com>
 <ada340d8-8ac1-9817-6d58-0da60a601637@redhat.com>
 <dd69ae0d-63e9-490e-ac59-4345841a78e5@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <dd69ae0d-63e9-490e-ac59-4345841a78e5@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.169, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 29.08.23 08:44, Andrey Drobyshev wrote:
> On 8/25/23 17:14, Hanna Czenczek wrote:
>> On 06.07.23 18:30, Andrey Drobyshev wrote:
>>> Right now "qemu-img map" reports compressed blocks as containing data
>>> but having no host offset.  This is not very informative.  Instead,
>>> let's add another boolean field named "compressed" in case JSON output
>>> mode is specified.  This is achieved by utilizing new allocation status
>>> flag BDRV_BLOCK_COMPRESSED for bdrv_block_status().
>>>
>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> ---
>>>    qapi/block-core.json |  7 +++++--
>>>    qemu-img.c           | 16 +++++++++++++---
>>>    2 files changed, 18 insertions(+), 5 deletions(-)
>> Patch 3 must be merged into this patch.  Every test must pass on every
>> commit so we don’t break bisecting.
> Agreed, should've figured that myself.
>
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index 5dd5f7e4b0..b263d2cd30 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -409,6 +409,9 @@
>>>    #
>>>    # @zero: whether the virtual blocks read as zeroes
>>>    #
>>> +# @compressed: true indicates that data is stored compressed.  Optional,
>>> +#     only valid for the formats whith support compression
>> This is missing information for when this field was introduced (i.e. a
>> “(since 8.2)”).
> Noted.
>
>> I also wonder why this field is optional.  We have compression
>> information even for formats that don’t support compression,
>> specifically, nothing is compressed.  I would just make this field
>> mandatory and print it always.  (A technical reason to do so is that
>> this patch uses block_driver_can_compress() to figure out whether there
>> is compression support; but that function only tells whether the driver
>> can write compressed data.  Even if it cannot do that, the format may
>> still support compression, and the driver may be able to read compressed
>> data, just not write it.)
>>
> I figured that for the formats which surely can't support compression,
> such as "raw", this information would simply be redundant.  AFAICT right
> now the only drivers which can read compressed data are exactly the ones
> which can write it: vmdk, qcow and qcow2.  But if we assume that this
> might change, and that we'd better show the field value no matter what
> (as we do with "zero" field) -- I'm OK with it.

It is indeed redundant, but as this is intended to be the 
machine-readable output, I don’t mind the output becoming arguably 
needlessly verbose.


