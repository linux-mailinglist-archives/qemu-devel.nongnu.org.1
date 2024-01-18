Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 635A3831315
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:25:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQMlf-0005Ve-9X; Thu, 18 Jan 2024 02:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rQMlb-0005VQ-1r
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 02:24:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rQMlZ-0002b5-Er
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 02:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705562684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b/gdp2wY5yZWT7alu8PK6Y2qThHVlmQYxqjYh45jLbM=;
 b=gz2MrVyZeFFlkaS+TUsrlhyml8Nbwd+bG33+E/mH8vYNpSg+mP/7pMrzvjBob4WbzuujIt
 CxeAoiepLhOAwvK0oi2dAmJJOZ82SVS0twcuWoqY0mg1S+VscZlsfVaSkj4+NCBnTKAwfY
 DR/cHQN+Ajn3z0RaLR+6bzQB6lDGWjE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-GftN28e5OGCeTwQjGAAdaw-1; Thu, 18 Jan 2024 02:24:42 -0500
X-MC-Unique: GftN28e5OGCeTwQjGAAdaw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-429d186ef21so85528341cf.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 23:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705562682; x=1706167482;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b/gdp2wY5yZWT7alu8PK6Y2qThHVlmQYxqjYh45jLbM=;
 b=Uu9YuR+2pDAnZtP8kRaCeIm+qqY8OlzF+llXx6sN1GmQf8bKfvL2ndawUQbV8MqEET
 ZJbSxNWBMXIT9/K+sapCICqIBpuhknJpaNVwCfN5wcT1r1x7A0rQEYe6CA2Uu/EetY64
 Ff8NB//EUrt9zyU+LzI3D5Myjk7+j4whVUu/FoxJoFXST9iKr3/og+AFoxYGQUDEQyBX
 +01DBfAMz700cC/hY193SxRuOX2uhuYGe+KTE5/bbE0TtM5ZaYfuMdC3+sSVgWxbIwcO
 USZhZi965EzFWjnIgVh+GszC7nK4hHpXtcvHpCZg8uCzsDd28vlNJlNGZ5NYT+ndFRwg
 hoWQ==
X-Gm-Message-State: AOJu0YzrU9WkyqgQVfrkwlrnTrpAMtleKf3I09SA6M3lLo9/CasIcccr
 pPl0W2C/aeR5fJAwh0bCU9JNwpXRwPUo1wIteUm9z+DoX3DCD8+RaFMZoAXAFXFv/ADrQbk9e9l
 c0OtZt95Z/6woO8Vp4GxUgQuy37aKdKKfSeTMRsn5MAJpdgm028A3
X-Received: by 2002:a05:622a:1014:b0:429:7412:a30b with SMTP id
 d20-20020a05622a101400b004297412a30bmr453081qte.6.1705562682247; 
 Wed, 17 Jan 2024 23:24:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFH4KoG5mJPyNMWuSQ9uaKO8WDF4L1CwGoDLDCYovHHkKeaphElWHsGGVy9v99VYx9uJ9TbrA==
X-Received: by 2002:a05:622a:1014:b0:429:7412:a30b with SMTP id
 d20-20020a05622a101400b004297412a30bmr453076qte.6.1705562682035; 
 Wed, 17 Jan 2024 23:24:42 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 b12-20020a05620a118c00b007834879d667sm4586199qkk.11.2024.01.17.23.24.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 23:24:41 -0800 (PST)
Message-ID: <5a325626-f131-42c7-a6b9-96a191d2e24d@redhat.com>
Date: Thu, 18 Jan 2024 08:24:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: use matching sizeof type
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240117160344.175872-1-pbonzini@redhat.com>
 <ZaiyfDX2-hUUynhp@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZaiyfDX2-hUUynhp@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/18/24 06:09, Peter Xu wrote:
> On Wed, Jan 17, 2024 at 05:03:44PM +0100, Paolo Bonzini wrote:
>> Do not use uint64_t for the type of the declaration and __u64 when
>> computing the number of elements in the array.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   hw/vfio/common.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 0b3352f2a9d..0da4003ecf5 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1118,7 +1118,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
>>   {
>>       uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
>>                           sizeof(struct vfio_device_feature_dma_logging_report),
>> -                        sizeof(__u64))] = {};
>> +                        sizeof(uint64_t))] = {};
>>       struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
>>       struct vfio_device_feature_dma_logging_report *report =
>>           (struct vfio_device_feature_dma_logging_report *)feature->data;
> 
> There seem to have other places in the sme file that reference __u64.  Are
> we going to remove all __u64 references?  Or maybe something else?

AFAIUI, this change is to match the types of the 'buf' array and
the one used by sizeof.
  
> Copy Alex/Cedric to make sure this won't get lost..

Applied to vfio-next.

Thanks,

C.


