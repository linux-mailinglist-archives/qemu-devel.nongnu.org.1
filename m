Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8347B7B7331
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 23:18:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnmm4-0007LS-Rr; Tue, 03 Oct 2023 17:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qnmm2-0007LI-B9
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 17:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qnmm0-0002m3-8o
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 17:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696367862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eo29Ru12FGhhu8TfcE+H8JU0YdqcI7P2yohi/6ntiNY=;
 b=EsyDhFRHsacDgag7bNnlvkNmAKHTRNCBhHNnwcACWIvARWA7VHW0L7UOzNNasUO9GqeayG
 9S1Cm9yg26+AR5No+VNxYcrbLg9evgjKHoR/Z3a4qvF3bMStsJglcsUwFqu3D7qY2EsNJa
 cIOKVWSDX7/vzmWJPqX7PoE7crQmoCw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-4x1IG_ChOgWj0WhXU3pMcA-1; Tue, 03 Oct 2023 17:17:36 -0400
X-MC-Unique: 4x1IG_ChOgWj0WhXU3pMcA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-65afcf18d05so15392926d6.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 14:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696367856; x=1696972656;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eo29Ru12FGhhu8TfcE+H8JU0YdqcI7P2yohi/6ntiNY=;
 b=vjWPfSQkEkrznVCRJXImAXCBxBMSQcwznDSjj8PY/ySrL+aPtOyWPy3jjBkhHS0wsw
 nbIGcd+zH1++gDBWjVHTaSHuzMz1kP6r5eEsl84WztVIyz6cX3mU2J2MkKmyrdOs+j6g
 ERJKtwufsFKUeRa8OVydesradPsQwaEXhrBCDj24NYsefBaj/HvcAn+u1xAvL7JABD5S
 lPEJYtstetxnJ05IRVlI4l5UHtKeWoxV3Cp3T7A5wd7lZE4dWKnbic9HayL949CBplS6
 UqOHbmEwk/nrPfJA2JqqNg4ukRV/Bf9UIwuNsJX4IXs3tetuApgPR7loVXT78RGEsXFL
 /nng==
X-Gm-Message-State: AOJu0YzEk8fABtOAyIaWAK+nDlzrrCyv7GfwBqH1DFi9UHlGft848SDs
 LvQrFstv9ifKTGXiyb8wIcPjCBeK0EB3mDe7gVyt06RLwFDVTE5zHHJ7REuIkGU5eRr6ENmSaaX
 a0TCgpxxA6B57dwE=
X-Received: by 2002:a0c:b347:0:b0:65b:26d4:7fb6 with SMTP id
 a7-20020a0cb347000000b0065b26d47fb6mr499984qvf.4.1696367856018; 
 Tue, 03 Oct 2023 14:17:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEiKe79Ojx8XoFbl1BfZyjsbJIkfGyJ+jAh3T3bcIlc7DtIgE7/bgFrgc3LBXNnIMMQco84w==
X-Received: by 2002:a0c:b347:0:b0:65b:26d4:7fb6 with SMTP id
 a7-20020a0cb347000000b0065b26d47fb6mr499975qvf.4.1696367855783; 
 Tue, 03 Oct 2023 14:17:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 e15-20020a0cb44f000000b00656373f9c30sm801185qvf.75.2023.10.03.14.17.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 14:17:35 -0700 (PDT)
Message-ID: <da918371-ef09-c296-7178-db5f2dcd68ec@redhat.com>
Date: Tue, 3 Oct 2023 23:17:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH for-8.1] vfio/display: Fix missing update to set backing
 fields
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>,
 Alex Williamson <alex.williamson@redhat.com>, kraxel@redhat.com
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 "Kim, Dongwon" <dongwon.kim@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
References: <20230816215550.1723696-1-alex.williamson@redhat.com>
 <a3a6f8ec-ca61-4472-45b4-1077dd27bb52@linaro.org>
 <acddfb4a-fe42-ba8c-e920-edc7e9ff5268@intel.com>
 <CAJ+F1C+YiDgRuyWcGeUPhaNO4SdjOSFSHKBY1wBS3dJFLO-k2w@mail.gmail.com>
 <20230904081129.3908c083.alex.williamson@redhat.com>
 <CAJ+F1CJFiHCu4FTbSFfLgSANiHJHEowJg7Um3j+ZMiHb_S21aQ@mail.gmail.com>
 <20230905090907.2b70b6a0.alex.williamson@redhat.com>
 <20230913131827.3bfe7bcb.alex.williamson@redhat.com>
 <b138199a-ceaa-4bf9-4d91-50a05ccc3267@redhat.com>
 <ce76c905-71bc-d141-cd98-b310732e4e41@tls.msk.ru>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <ce76c905-71bc-d141-cd98-b310732e4e41@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 10/3/23 19:03, Michael Tokarev wrote:
> 22.09.2023 12:38, Cédric Le Goater:
>> On 9/13/23 21:18, Alex Williamson wrote:
>>>
>>> Hi Gerd,
>>>
>>> Some consultation would be appreciated on this thread to get this patch
>>> out of limbo.  Is there a better solution that what I've proposed?
>>
>> This does fix a regression reproducible on systems with an Intel Gen 8,
>> my T480 laptop for instance.
>>
>> Tested-by: Cédric Le Goater <clg@redhat.com>
>>
>> Also, queuing it in vfio-next.
> 
> Cédric, can we get this in time for 8.1.2 please
> (which I'm planning for Oct-14 for now)?  Looks like
> it hit quite some people already.

yes. I would like to include this series [1] from Eric in my next PR.
It doesn't need much, an Ack from the s390 team mostly, the rest is
aesthetic. So, I hope this week, else I will send a smaller PR.

Thanks,

C.

[1] https://lore.kernel.org/qemu-devel/20231003101530.288864-1-eric.auger@redhat.com/


> 
> I dunno what are your plans for vfio-next, maybe this
> one (which missed 8.1.0 already) can be pushed as a
> bugfix?
> 
> Thank you!
> 
> /mjt
> 


