Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D05ECAA9DC7
	for <lists+qemu-devel@lfdr.de>; Mon,  5 May 2025 23:06:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC30J-0000mq-HS; Mon, 05 May 2025 17:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uC30F-0000m9-5b
 for qemu-devel@nongnu.org; Mon, 05 May 2025 17:05:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uC30D-0004KK-4S
 for qemu-devel@nongnu.org; Mon, 05 May 2025 17:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746479127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sPiO1MdcdEDyL+yfS2OEoRZ/VaWEuB4TuY4jjzkkR5A=;
 b=dCLrMbrDUkWvSEQGMrEa0P0xHOZNGZpPhUXDYQarkfLgDbUjZVgcPz8NfB3DtPklJxjnMC
 PEkICoV6UmM94IHBIbA2v2jJGAA5zv6WsGC1llL5Yt+R95H60kQ3fYnJucsDBX6eGjwg8x
 AVyKlXhBacPQbzJh9dvVfho5MCwPKWA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-TAqd6YklMMCHmCslaYWNsg-1; Mon, 05 May 2025 17:05:26 -0400
X-MC-Unique: TAqd6YklMMCHmCslaYWNsg-1
X-Mimecast-MFC-AGG-ID: TAqd6YklMMCHmCslaYWNsg_1746479125
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43ea256f039so37729365e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 14:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746479125; x=1747083925;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sPiO1MdcdEDyL+yfS2OEoRZ/VaWEuB4TuY4jjzkkR5A=;
 b=gvdy4unaRHHeBWy18PLQM1w3MMOWWOpDrQM5CIrBxHVCW56pmlu4K+ksrjJaE/dre4
 h6Zrv4e6MQyuQ5LxDpzMEmRGkQWiBNaTASGPRSLRV2see9oir5+X5mC28wjs2Dgd07u9
 NG9qyzES0wDCAdO2uiuNEUdoj9XRDhAA3l07XKalwIX2XkIxZzHMWS/R/ySM2sX47X4k
 FzglJ5oXK9/4gHy2t6lR13zv0ICSBpCtpuzvdyxjczdplEdNpep4Q7ZCVBpuyuXK4W1r
 Ju9EOel0ACKrJPSmIum+I7nAFZ8nxTMEkCJ7x7J5jfLlcj4Qy5ypQrT2KOBLZjFQX9CN
 +gBw==
X-Gm-Message-State: AOJu0Yz4zAVTrtrkRh0JxXvmxd+4VG3w2Q6P31Tr99ABdwnbw+XxZg54
 BoNGPpnLOb3mA968CHTgX53lPiDl4Dip6Z3vrdvpxNDcTi+DP35pu+a5UrkyfiSHNaqcuVc+mJe
 Kie9jLMcE/P0S6rl0Ku26KOhqDwZhTtevth3Pz1QDw15BgQIFsn9y
X-Gm-Gg: ASbGncsMwWRMhvAIOa9uyLTuCFJAfPZBZdy5+uA//koe+JRrEgE41iuvMQta5FZmEkU
 rtHKacRos4PJZ/Ju/XQBPi2xrasAKB3Om6+1dPUTlqPGNcDixFUV+rmqh5fnJ5Btflr0JO4mv9f
 PiICf+zq5aqcZZYWZ/iXNLRhrkYKO3XRnP9sw8DV07cH0WFH1axt6czlLk3e67L0h+bHS63YBVB
 WrSvDS5UljSrd9BJwXra7QOTPgtZEm2HwNQLL5GwMAGzxgC5TVKYaXY4zSHMX2c8DzrlyfkBeVI
 3KrgDQUUSEQFnuEI60PjXsKppadmgO5dIZV52SBifJCI3ImsfA==
X-Received: by 2002:a05:600c:350a:b0:43c:ee3f:2c3 with SMTP id
 5b1f17b1804b1-441c48b0603mr73932005e9.7.1746479125053; 
 Mon, 05 May 2025 14:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE/e3DtgiEftxkyjV7Ne/ANVz5KOraHBRVwnIa97gYzOS0m6WxbAA2ARup04kcvTlUi5KoRg==
X-Received: by 2002:a05:600c:350a:b0:43c:ee3f:2c3 with SMTP id
 5b1f17b1804b1-441c48b0603mr73931575e9.7.1746479124628; 
 Mon, 05 May 2025 14:05:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8a2873csm143950455e9.30.2025.05.05.14.05.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 14:05:24 -0700 (PDT)
Message-ID: <84022fbf-46fb-4df6-8498-4e44893b69bc@redhat.com>
Date: Mon, 5 May 2025 23:05:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/15] vfio: add unmap_all flag to DMA unmap callback
To: John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 qemu-s390x@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
 <20250430194003.2793823-9-john.levon@nutanix.com>
 <bfeb9363-a33a-4a2f-b0e9-115beebb1fbf@redhat.com> <aBi8j0sM_VA0StmY@lent>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aBi8j0sM_VA0StmY@lent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/5/25 15:26, John Levon wrote:
> On Mon, May 05, 2025 at 02:06:03PM +0200, Cédric Le Goater wrote:
> 
>> !-------------------------------------------------------------------|
>>   CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> On 4/30/25 21:39, John Levon wrote:
>>> We'll use this parameter shortly; this just adds the plumbing.
>>
>> I am not sure the 'unmap_all' name reflects what the dma_unmap()
>> handler does.
> 
> FWIW the vfio API flag that reflects this is already called
> VFIO_DMA_UNMAP_FLAG_ALL so there's precedent for the name.
> 
> It unmaps the entire address space, right? 

yes but the unmap is split in two.

> Do you have a suggestion for a better name?

no. Let's move on.


Thanks,

C.



