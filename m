Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6451715517
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 07:41:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3s5J-0007oz-Hz; Tue, 30 May 2023 01:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q3s5F-0007oe-PL
 for qemu-devel@nongnu.org; Tue, 30 May 2023 01:39:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q3s5E-00069O-1Q
 for qemu-devel@nongnu.org; Tue, 30 May 2023 01:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685425186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SD7ESvp9YCoZy7Zxvq1JJkwekQXNkPzeYEIbGmLJQ6w=;
 b=GeNrIpFW2kXYdpZcHXw/GGHqG12z1Nh9hFwQFI3eiYBH7oXtnCyjXCHse+vNdBEyIHs/3w
 MQiEUVZiqQ3EOaxiBOdiZ/T/7+6fIGkg3RTwPsnViPP+I8Pdd67K3a0aj6Yzdh67VIwuNg
 GWEUceRRHjzutrftzbUtjcYf6DYeGmw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-MfGYLiCvNKaYzAGq4Q5Ybg-1; Tue, 30 May 2023 01:39:45 -0400
X-MC-Unique: MfGYLiCvNKaYzAGq4Q5Ybg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3097ebd267dso1483852f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 22:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685425184; x=1688017184;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SD7ESvp9YCoZy7Zxvq1JJkwekQXNkPzeYEIbGmLJQ6w=;
 b=JPPx3Ru1W4ukOIdQS3Lw/YHuFHo2iYKA3p0DUf/48QngHdvF48ZapQ4cnMDYP79aNL
 VbLVNg6EeXQCQPDK8YbGRPHP2QeniwlXg85MGFG0cOQcB6XWY83abRGQI355L55Z2pdV
 o0fgBBb12ZpHXfD/8AEPFT8r/UnYODu0QbHArpKqO2RpqWR5NY7g9Ewd5dbHLi98ye44
 Jn5CaNy2YOPFOFz0gtQfNlq9xzJc+x7btgmiU38CKEowD0xyvtAdTfKjFYN/KERoFEw3
 fLuzvuqzdD5+uGaS+q0+E76FHlNgZEjWhOZea0+RZyA9FoNiTO1zDy2ZhBu7IxIpTvdZ
 cHaw==
X-Gm-Message-State: AC+VfDwK3p8TH6b3MIfLJu11F0UhMg0diT5AORyOTTIZsk9LKLk7Alx4
 i2jndW966ARwUBGMiemtXDOUqxKR88G0w8Rzv8moTImlauH45VwnyAnXFS1yQwLW7uIkRmx7f55
 FJehrLO9RROZvdo8=
X-Received: by 2002:adf:e946:0:b0:307:9592:846d with SMTP id
 m6-20020adfe946000000b003079592846dmr606581wrn.14.1685425184038; 
 Mon, 29 May 2023 22:39:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7wo/UFSQ0DEPlIoB38R0xG9z2/ZLSD3XnGQorbqdy3HuUXsjJncDNlZdyDg6s/5xh1HcYFHA==
X-Received: by 2002:adf:e946:0:b0:307:9592:846d with SMTP id
 m6-20020adfe946000000b003079592846dmr606568wrn.14.1685425183724; 
 Mon, 29 May 2023 22:39:43 -0700 (PDT)
Received: from [192.168.8.105] (tmo-065-8.customers.d1-online.com.
 [80.187.65.8]) by smtp.gmail.com with ESMTPSA id
 t16-20020a5d6910000000b00307a86a4bcesm1972415wru.35.2023.05.29.22.39.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 May 2023 22:39:43 -0700 (PDT)
Message-ID: <432e800a-9499-a7e5-bac8-2f8877ae1a46@redhat.com>
Date: Tue, 30 May 2023 07:39:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] hw/ufs: Initial commit for emulated
 Universal-Flash-Storage
Content-Language: en-US
To: jeuk20.kim@samsung.com
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "hreitz@redhat.com"
 <hreitz@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Klaus Birkelund Jensen <k.jensen@samsung.com>
References: <fbc8003d-9d91-55a0-940f-240d687aae75@redhat.com>
 <20230526050555epcms2p287be772002cd941cc79226968c319036@epcms2p2>
 <CGME20230526050555epcms2p287be772002cd941cc79226968c319036@epcms2p3>
 <20230530013646epcms2p392066e0dcbd6613d06977974a4f81c1d@epcms2p3>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230530013646epcms2p392066e0dcbd6613d06977974a4f81c1d@epcms2p3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 30/05/2023 03.36, Jeuk Kim wrote:
> On 26/05/2023 15:37, Thomas Huth wrote:
>> On 26/05/2023 07.05, Jeuk Kim wrote:
>>> Universal Flash Storage (UFS) is a high-performance mass storage device
>>> with a serial interface. It is primarily used as a high-performance
>>> data storage device for embedded applications.
>>>
>>> This commit contains code for UFS device to be recognized
>>> as a UFS PCI device.
>>> Patches to handle UFS logical unit and Transfer Request will follow.
>>>
>>> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
>>> ---
>>>    MAINTAINERS              |    6 +
>>>    hw/Kconfig               |    1 +
>>>    hw/meson.build           |    1 +
>>>    hw/ufs/Kconfig           |    4 +
>>>    hw/ufs/meson.build       |    1 +
>>>    hw/ufs/trace-events      |   33 +
>>>    hw/ufs/trace.h           |    1 +
>>>    hw/ufs/ufs.c             |  305 ++++++++++
>>>    hw/ufs/ufs.h             |   42 ++
>>>    include/block/ufs.h      | 1251 ++++++++++++++++++++++++++++++++++++++
>>>    include/hw/pci/pci.h     |    1 +
>>>    include/hw/pci/pci_ids.h |    1 +
>>>    meson.build              |    1 +
>>
>> Do you expect lots of additional files to be added to the hw/ufs/ folder? If
>> the answer is no, then it's maybe a little bit overkill to introduce a
>> separate folder for this. Wouldn't hw/block/ be a good fit for this as well?
>> Or maybe we could introduce hw/flash/ or so and also move the contents of
>> hw/nvme there?
> 
> Yes. I plan to add more files to UFS for different functions (UICCMD, MQ, zoned, etc.) like nvme.
> So personally, I think it would be good to keep the hw/ufs/ directory.

Ok, fair. Then start with hw/ufs/ first and we'll see how it goes. We can 
still move the files later if necessary.

  Thomas


