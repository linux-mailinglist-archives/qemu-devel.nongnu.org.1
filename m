Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 567C470E27C
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:55:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1VHq-0004sE-7s; Tue, 23 May 2023 12:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q1VHe-0004fJ-S9
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:54:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q1VHc-0006Sk-K1
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684860887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FRwfHeQ1cOmUq1hbrkO2W0pSQtIIvGeanyKX+67mOyw=;
 b=EEKTELs9ZrVSUpWxV3kyAlgwwxAvlWYn3g2/8+41H6YjUhXVhbyzFpxcrVNtsIycM/CnL6
 wKogl+nu5zQkJc3Avkb4ZN+BL6zQLr6txcK3RM71wwSv7D2RJ9162YLbjuMMzALJcyCqcc
 f5wfeJK7FQ7dH5lciXHsmlsS0uTw1jw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-u7aCrhHyMqOhq21uwEbBEg-1; Tue, 23 May 2023 12:54:45 -0400
X-MC-Unique: u7aCrhHyMqOhq21uwEbBEg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-307814dd87eso3260087f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684860884; x=1687452884;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FRwfHeQ1cOmUq1hbrkO2W0pSQtIIvGeanyKX+67mOyw=;
 b=jhooN0YuvIzAQEKrGU+feyxGVusO1EfeGhqaNRR1wYyf3CIFsOasXcWXpm1vYMuaLb
 xiwFYaUpQpXWjAPIELYS5kFZp+Yv8GCKmfrgigBzGcU7nlR/kncWrins6xeCt//2/hYc
 IC6xS4T2tCHS5htXSdSa8m7BagRpa4/2ewTLmZJ08M84Vby66e56UNMAGN/yBJdAQQKf
 gN9RgLoN6fouUeD+Qa6x0ZejsQAJLhCTlLDQ29No2UCAlszEX550ZrBA7fHOgoBnrbjI
 8kktZpP2Te8gJDMSjJuGdrABi5yVIZqe2LMN8YgjUI9rQ+IwZLGf/oKZPiap/Ljo/Mc3
 vCLw==
X-Gm-Message-State: AC+VfDyhT4qTzIVK+wLK3NTh94ZeFn0qjguPHka88rugMxsYjHji37ag
 fOcifATbMzTS1MBXunQlscTjFby00KW/YVFbQtg9yAe7Vc7gqnzM6VCY07EkQ4dKr6a2PRz2pU2
 os7F5NAd7fVfV/iM=
X-Received: by 2002:a5d:5346:0:b0:306:31b7:abe4 with SMTP id
 t6-20020a5d5346000000b0030631b7abe4mr10422744wrv.14.1684860884302; 
 Tue, 23 May 2023 09:54:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Ow7qvZtj7tWZWBozR1L04bDfj8smDeUQLyA8xYzXpsgMC1twdwLYts8RY8QcjgF1vY9w9cQ==
X-Received: by 2002:a5d:5346:0:b0:306:31b7:abe4 with SMTP id
 t6-20020a5d5346000000b0030631b7abe4mr10422733wrv.14.1684860883963; 
 Tue, 23 May 2023 09:54:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 z20-20020a1cf414000000b003f17af4c4e0sm15999859wma.9.2023.05.23.09.54.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 09:54:43 -0700 (PDT)
Message-ID: <20c80f7e-43bf-6563-c46b-04ddd9fd9ad3@redhat.com>
Date: Tue, 23 May 2023 18:54:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 1/3] vfio/pci: add support for VF token
Content-Language: en-US
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: Minwoo Im <minwoo.im@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
References: <20230509215923.3186420-1-alex.williamson@redhat.com>
 <20230509215923.3186420-2-alex.williamson@redhat.com>
 <f7134011-27df-416d-699c-33d41f82c307@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <f7134011-27df-416d-699c-33d41f82c307@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Hello Matthew,

On 5/23/23 18:51, Matthew Rosato wrote:
> On 5/9/23 5:59 PM, Alex Williamson wrote:
>> From: Minwoo Im <minwoo.im@samsung.com>
>>
>> VF token was introduced [1] to kernel vfio-pci along with SR-IOV
>> support [2].  This patch adds support VF token among PF and VF(s). To
>> passthu PCIe VF to a VM, kernel >= v5.7 needs this.
>>
>> It can be configured with UUID like:
>>
>>    -device vfio-pci,host=DDDD:BB:DD:F,vf-token=<uuid>,...
>>
>> [1] https://lore.kernel.org/linux-pci/158396393244.5601.10297430724964025753.stgit@gimli.home/
>> [2] https://lore.kernel.org/linux-pci/158396044753.5601.14804870681174789709.stgit@gimli.home/
>>
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
>> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
>> Link: https://lore.kernel.org/r/20230320073522epcms2p48f682ecdb73e0ae1a4850ad0712fd780@epcms2p4
>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> 
> Hi Minwoo, Alex,
> 
> I'm seeing a regression in vfio-pci on s390 and bisect points to this commit.  I don't believe it's specific to s390 though, but rather when not using this new vf-token, see below...
> 
>> ---
>>   hw/vfio/pci.c | 13 ++++++++++++-
>>   hw/vfio/pci.h |  1 +
>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index ec9a854361ac..cf27f28936cb 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2856,6 +2856,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>       int groupid;
>>       int i, ret;
>>       bool is_mdev;
>> +    char uuid[UUID_FMT_LEN];
>> +    char *name;
>>   
>>       if (!vbasedev->sysfsdev) {
>>           if (!(~vdev->host.domain || ~vdev->host.bus ||
>> @@ -2936,7 +2938,15 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>           goto error;
>>       }
>>   
>> -    ret = vfio_get_device(group, vbasedev->name, vbasedev, errp);
>> +    if (!qemu_uuid_is_null(&vdev->vf_token)) {
>> +        qemu_uuid_unparse(&vdev->vf_token, uuid);
>> +        name = g_strdup_printf("%s vf_token=%s", vbasedev->name, uuid);
>> +    } else {
>> +        name = vbasedev->name;
> 
> ^ here we copy the pointer when a vf-token was not specified.
> 
>> +    }
>> +
>> +    ret = vfio_get_device(group, name, vbasedev, errp);
>> +    g_free(name);
> 
> ^ and then free it regardless.  But I don't think we meant to free what vbasedev->name points to, this was meant to free a duplicate string.  I'm subsequently seeing qemu crashes later on e.g. during device unplug.
> 
> I think doing a strdup in either case would fix the issue OR skipping the g_free when qemu_uuid_is_null(&vdev->vf_token).
> 
> FWIW, I tried the following and it resolved the issue for me:

Zhenzhong provided the exact same fix :

   https://lore.kernel.org/qemu-devel/20230517024651.82248-1-zhenzhong.duan@intel.com/

Thanks,

C.

> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index bf27a39905..73874a94de 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2994,7 +2994,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>           qemu_uuid_unparse(&vdev->vf_token, uuid);
>           name = g_strdup_printf("%s vf_token=%s", vbasedev->name, uuid);
>       } else {
> -        name = vbasedev->name;
> +        name = g_strdup(vbasedev->name);
>       }
>   
>       ret = vfio_get_device(group, name, vbasedev, errp);
> 
> 
> 
> 


