Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A44579CFAC
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 13:18:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg1P5-0005Bl-2n; Tue, 12 Sep 2023 07:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qg1P3-0005BI-7a
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:17:57 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qg1Oz-0001kz-8E
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:17:56 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-313e742a787so3445774f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 04:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694517471; x=1695122271; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=85UTq3jAiV07PhU0DmElk1A0UttCR8iC8owBGfX2y+8=;
 b=UThyTTbZJgZCq737HLPts5Rdcp9nn3RLXRFPKhnxAX0+RgNqikFtDS4hq+AEKbCA55
 ST2UwDSzDvaUFW6EeYKm3oj1udVzMoJAacY7I55IpNKP2oyjkX5T2dnsFnC00baHlDdd
 EeOlGiK61BzJwo7enPPtih9272npk4mB3bgFrYteRHsZXVe+gnV14GO8eIx75kdgWC+p
 rAiulb++C6J1JI7UW53ULjgW+w+rjrd3uj6D8aG3mYlt3SYlvSi//yELunOsCSDeGKoC
 nNdcwN+2xOjbvMEFPXxVruqINnSIwt+kmIEZseBsbDJU7xWu68mRVgng7ekPisN37Lbz
 fAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694517471; x=1695122271;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=85UTq3jAiV07PhU0DmElk1A0UttCR8iC8owBGfX2y+8=;
 b=rhyMfo5VY/5zKLT2byWdaJBkQoYDQLcY3ISucBCn3W8Zz1PTj8SboujrOWoMfVn5Tu
 /Y/BQ8FsuYvuDOWY+u9QeVy+Ziv0vxAPgKDpAVKFbF4jmsKfdPXnQnFe7zJZV/l6FZyl
 6xCcsaimjVUNX9V3ZZROAIit02ClzlffLelfmRFGHY2xnS77JSmJS8Co13S7MTSBih1N
 xT1H451pIlyynnRciZG+bzes/XFMvAxP2fI96QyTOq/nhNDcg+HdYcm/udJ4gd5Se0Py
 R6LGjmTIPsxPfkCO03FdlW0lUqxDoTxw/Gbs2ZR9odWCU8a7MMlqkxUTnZpNA4mUTUbR
 v7cw==
X-Gm-Message-State: AOJu0Yx0UHZ730G8NdbvDnqua6XOkUNzY8bujg/N1Ff6vliWcaSCmO3T
 RUuSY+AlMZorWO9azqqQ9e8EdQ==
X-Google-Smtp-Source: AGHT+IE2XjbMJr1Xz0aEVEjQIzSKR/Nbf4LjA9MD+JhFQksbFQctZv8ArpT0Yfmcf4gejE34gAUk9A==
X-Received: by 2002:a05:6000:1364:b0:31c:8c5f:877e with SMTP id
 q4-20020a056000136400b0031c8c5f877emr1556316wrz.33.1694517470994; 
 Tue, 12 Sep 2023 04:17:50 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-50-150.dsl.sta.abo.bbox.fr.
 [176.172.50.150]) by smtp.gmail.com with ESMTPSA id
 bu21-20020a056000079500b003196b1bb528sm4781870wrb.64.2023.09.12.04.17.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 04:17:50 -0700 (PDT)
Message-ID: <b8e7e4c5-92dc-d82c-cb61-abfbaa6e5f0b@linaro.org>
Date: Tue, 12 Sep 2023 13:17:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] vdpa: fix gcc cvq_isolated uninitialized variable warning
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=c3=a9rez?=
 <eperezma@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
References: <20230911215435.4156314-1-stefanha@redhat.com>
 <430ea775-678f-e5ac-d548-6556dcf54e06@linaro.org>
 <CAJSP0QUiTQVuq3OhVcZmHjmChDJtVFhH8YmEZQmHBfTAWhESwQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAJSP0QUiTQVuq3OhVcZmHjmChDJtVFhH8YmEZQmHBfTAWhESwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 12/9/23 12:48, Stefan Hajnoczi wrote:
> On Tue, 12 Sept 2023 at 02:19, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 11/9/23 23:54, Stefan Hajnoczi wrote:
>>> gcc 13.2.1 emits the following warning:
>>>
>>>     net/vhost-vdpa.c: In function ‘net_vhost_vdpa_init.constprop’:
>>>     net/vhost-vdpa.c:1394:25: error: ‘cvq_isolated’ may be used uninitialized [-Werror=maybe-uninitialized]
>>>      1394 |         s->cvq_isolated = cvq_isolated;
>>>           |         ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
>>>     net/vhost-vdpa.c:1355:9: note: ‘cvq_isolated’ was declared here
>>>      1355 |     int cvq_isolated;
>>>           |         ^~~~~~~~~~~~
>>>     cc1: all warnings being treated as errors
>>>
>>> Cc: Eugenio Pérez <eperezma@redhat.com>
>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>> Cc: Jason Wang <jasowang@redhat.com>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>>    net/vhost-vdpa.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>>> index 34202ca009..7eaee841aa 100644
>>> --- a/net/vhost-vdpa.c
>>> +++ b/net/vhost-vdpa.c
>>> @@ -1352,7 +1352,7 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
>>>        VhostVDPAState *s;
>>>        int ret = 0;
>>>        assert(name);
>>> -    int cvq_isolated;
>>> +    int cvq_isolated = 0;
>>>
>>>        if (is_datapath) {
>>>            nc = qemu_new_net_client(&net_vhost_vdpa_info, peer, device,
>>
>> Alternatively:
>>
>> -- >8 --
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index 34202ca009..218fe0c305 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -1352,13 +1352,12 @@ static NetClientState
>> *net_vhost_vdpa_init(NetClientState *peer,
>>        VhostVDPAState *s;
>>        int ret = 0;
>>        assert(name);
>> -    int cvq_isolated;
>>
>>        if (is_datapath) {
>>            nc = qemu_new_net_client(&net_vhost_vdpa_info, peer, device,
>>                                     name);
>>        } else {
>> -        cvq_isolated = vhost_vdpa_probe_cvq_isolation(vdpa_device_fd,
>> features,
>> +        int cvq_isolated =
>> vhost_vdpa_probe_cvq_isolation(vdpa_device_fd, features,
>>                                                          queue_pair_index
>> * 2,
>>                                                          errp);
>>            if (unlikely(cvq_isolated < 0)) {
>> @@ -1391,7 +1390,7 @@ static NetClientState
>> *net_vhost_vdpa_init(NetClientState *peer,
>>
>>            s->vhost_vdpa.shadow_vq_ops = &vhost_vdpa_net_svq_ops;
>>            s->vhost_vdpa.shadow_vq_ops_opaque = s;
>> -        s->cvq_isolated = cvq_isolated;
>> +        s->cvq_isolated = true;
> 
> This is incorrect because the return value of
> vhost_vdpa_probe_cvq_isolation() is -errno for errors, 0 for no cvq
> isolation, and 1 for cvq isolation. A variable is still needed to
> distinguish between no cvq isolation and cvq isolation.

Oh, I was expecting a boolean for a field named 'cvq_isolated',
my bad. R-b stands for your patch.

Regards,

Phil.

> 
>>
>> ---
>>
>> Whichever you prefer:
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>>


