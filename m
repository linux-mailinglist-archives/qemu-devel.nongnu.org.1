Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E78D7C41BB
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 22:43:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqJY2-0000c9-Ap; Tue, 10 Oct 2023 16:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qqJXu-0000XC-T9
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 16:41:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qqJXt-0006gg-1S
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 16:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696970494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mlml52KYEl6hPBbxf5dC0hWl1GcKGoq7JsMQPRCXH6A=;
 b=dxKsuZ8aQNTIH8O2d+oCbHoOUCZvKd5BMQUED4Z7/6bAGXELR4G1KJrR46k25C9aR7yQN8
 OnodMbnqnlvSAvLVmhNbR+xEB9/Jkf45zc/OO0we2TV1NMZueKTmPSjrUqDktUyMIWLhZL
 w8xa/b+BaksoeMANQ7hdrrnTF1ed5ck=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-kA3cLsImMkW3V-z36TSoZw-1; Tue, 10 Oct 2023 16:41:33 -0400
X-MC-Unique: kA3cLsImMkW3V-z36TSoZw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-77576c78c11so698464785a.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 13:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696970492; x=1697575292;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mlml52KYEl6hPBbxf5dC0hWl1GcKGoq7JsMQPRCXH6A=;
 b=tXFkEtUn89pscTZKBQUBZwDvVIkOSkNHiZFLAOqvHYKOs0Wd0ArDmbuiOHadn3mPJd
 EnqaexRIAcpbM9co8TJ4NmZLmtGOtC5hpmjifWBclUagyhT4URaOLOpsLk6SMsNeiNBZ
 lgZeL+sN91CjanKVkRBCBJGd37OmF2vHtSOTU1kp+adaCAwLq/9WyKeuI4JfnSqA0w5H
 rZ362v3Qy0zJd9UJjotLUFVSqqMJJAADShcIvos1/EWvmnktK3e1J6HmIxeOdAPd+kWO
 Zhs9AY+lQJHaCVbfW+mreXwY1IIBODU9oGVYkl84Qsbx9csXgI3aZ7rQLc2r+aotauSy
 9vvQ==
X-Gm-Message-State: AOJu0YzHJzqo0S5HZoMEFJRVR658vxEPbm+y7PYNo3o0VCq1PL/Xj0NU
 viIfisbP56VPc2UdWblcxO1aURm3Pjldce5H2cn7lEcnSe6bFVOZKmXdOtaR/mh7DE+VqZH7PlN
 D7MVcQAU6pw2Awqc=
X-Received: by 2002:a05:620a:2a03:b0:776:5135:d98c with SMTP id
 o3-20020a05620a2a0300b007765135d98cmr20425223qkp.15.1696970492634; 
 Tue, 10 Oct 2023 13:41:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEHH8MSt2DkTiB2gNDJgC7qciSFmGQbQF3ZRHP1AzGk7N+9Mql4di3OcGDcwesIDHtPSi/uA==
X-Received: by 2002:a05:620a:2a03:b0:776:5135:d98c with SMTP id
 o3-20020a05620a2a0300b007765135d98cmr20425209qkp.15.1696970492399; 
 Tue, 10 Oct 2023 13:41:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 m19-20020ae9e013000000b00767dcf6f4adsm4605283qkk.51.2023.10.10.13.41.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 13:41:32 -0700 (PDT)
Message-ID: <4a6e370f-f966-8905-a4ec-338ea42da980@redhat.com>
Date: Tue, 10 Oct 2023 22:41:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] misc/pca9552: Fix for pca9552 not getting reset
Content-Language: en-US
To: Miles Glenn <milesg@linux.vnet.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, clg@kaod.org, andrew@codeconstruct.com.au,
 joel@jms.id.au
References: <20231010195209.264757-1-milesg@linux.vnet.ibm.com>
 <57112a6f-2624-4bd5-b301-cd28cb197771@ilande.co.uk>
 <1fcb9e1820b2ca5c5e6b84d7186c328c1df426e8.camel@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <1fcb9e1820b2ca5c5e6b84d7186c328c1df426e8.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 10/10/23 22:35, Miles Glenn wrote:
> On Tue, 2023-10-10 at 21:31 +0100, Mark Cave-Ayland wrote:
>> On 10/10/2023 20:52, Glenn Miles wrote:
>>
>>> Testing of the pca9552 device on the powernv platform
>>> showed that the reset method was not being called when
>>> an instance of the device was realized.  This was causing
>>> the INPUT0/INPUT1 POR values to be incorrect.
>>>
>>> Fixed by overriding the parent pca955x_realize method with a
>>> new pca9552_realize method which first calls
>>> the parent pca955x_realize method followed by the
>>> pca9552_reset function.
>>>
>>> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
>>> ---
>>>    hw/misc/pca9552.c | 7 +++++++
>>>    1 file changed, 7 insertions(+)
>>>
>>> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
>>> index fff19e369a..4e183cc554 100644
>>> --- a/hw/misc/pca9552.c
>>> +++ b/hw/misc/pca9552.c
>>> @@ -384,6 +384,12 @@ static void pca955x_realize(DeviceState *dev,
>>> Error **errp)
>>>        qdev_init_gpio_out(dev, s->gpio, k->pin_count);
>>>    }
>>>    
>>> +static void pca9552_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    pca955x_realize(dev, errp);
>>> +    pca9552_reset(dev);
>>> +}
>>> +
>>>    static Property pca955x_properties[] = {
>>>        DEFINE_PROP_STRING("description", PCA955xState, description),
>>>        DEFINE_PROP_END_OF_LIST(),
>>> @@ -417,6 +423,7 @@ static void pca9552_class_init(ObjectClass *oc,
>>> void *data)
>>>        PCA955xClass *pc = PCA955X_CLASS(oc);
>>>    
>>>        dc->reset = pca9552_reset;
>>> +    dc->realize = pca9552_realize;
>>>        dc->vmsd = &pca9552_vmstate;
>>>        pc->max_reg = PCA9552_LS3;
>>>        pc->pin_count = 16;
>>
>> The reason that the reset function isn't being called here is because
>> TYPE_I2C_SLAVE
>> is derived from TYPE_DEVICE, and for various historical reasons the
>> DeviceClass reset
>> function is only called for devices that inherit from
>> TYPE_SYS_BUS_DEVICE.
>>
>> Probably the best way to make this work instead of mixing up the
>> reset and realize
>> parts of the object lifecycle is to convert pca9552_reset() to use
>> the new Resettable
>> interface for TYPE_PCA9552: take a look at commit d43e967f69 ("q800-
>> glue.c: convert
>> to Resettable interface") as an example, along with the documentation
>> at
>> https://www.qemu.org/docs/master/devel/reset.html.
>>
> 
> Ahh, that's very helpful.  Thanks, Mark!

yes. My bad, I didn't look close enough. Thanks Mark

C.


