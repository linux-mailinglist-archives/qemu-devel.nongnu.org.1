Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E937BE538
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 17:43:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpsQ4-0003Xr-4w; Mon, 09 Oct 2023 11:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpsQ1-0003Ww-So
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 11:43:41 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpsPv-0006Am-TZ
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 11:43:40 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9ada2e6e75fso856721966b.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696866208; x=1697471008; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Lqlop1lTg6fmHhv9QV2Uy7vWb9gqoDPYBxKHVz5S40=;
 b=yiLGn4ztnaCjpA5g+eJckLMmMspmCdUp0KdS9XgA31Dq5n1bkENgWPJOoT8+zlgsXO
 X7HzEhBhek1n/OX5lOsFf70FcUeujdcGyzajZ0Nt90arqCLp+gaKW4LWDTeiAC5Ie3nC
 Nvf07rnj3oaQZwT/3ZvfPvngFYxUrHcuubKtSAcY0TY3yFoKxMzBvrnvSA4uzDhAfmG0
 DtoR25EVJKdzbxTgAN/m2i29AFdoEzUmw+PU1ku6m4QCZh6IUQx3Dd+4r5W7MxHiSuno
 cnMrT/zUgo2JGyVNkUo0kf0+qipnSNXRprreMxyAJSFR8DhBG8tzAeM6c+qsfoK9TtX0
 KABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696866208; x=1697471008;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Lqlop1lTg6fmHhv9QV2Uy7vWb9gqoDPYBxKHVz5S40=;
 b=hR2v5JXMj3tYFNzDXyEzS/lvvDkPP4lAsPn+v4ZOhghR8123Qj+hg8ZFrh+VTWNlus
 iuDPChDPVoa4yRkJ6t/FF+vL21uJdvpmmggeboSF0FvpcZAG5CGCYlgPg3G1LWDFwbMT
 6SL/hPVIoOqSHM8/ATQ4HSf+R9a6QwMLu49/h02HPGO2tiKQEhkDz8SbuwBZd81X6+MF
 Xi5/2w8IBE0zJYeK+0UYwPmZcgn2d7XxZD7kkeDWeiq+tG4NbA4IPLqEvElRUkn/euCg
 ZHv3MWDy57q/vxVvLiF3d8DsKWDzIc7UEMkVCrrYcFttPVlW29t6J+s9kLYyPym9KyDa
 /IVQ==
X-Gm-Message-State: AOJu0YwDB1n/dVcpT76hN+zKzyZbS5STqZBZRFBMgoR2eOrJvdu9IRxe
 htESZ7UEXAB2mhUA6tJKoqOxHQ==
X-Google-Smtp-Source: AGHT+IGinWR8EgeWNrFfj9jeU45VO+LIbOHEIKPulc1Cck6CvpDqrna3MgTKaBi47IRJ97IisPmNZw==
X-Received: by 2002:a17:907:720b:b0:9a1:f4e8:87b9 with SMTP id
 dr11-20020a170907720b00b009a1f4e887b9mr17120231ejc.45.1696866208322; 
 Mon, 09 Oct 2023 08:43:28 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr. [176.170.217.185])
 by smtp.gmail.com with ESMTPSA id
 sd23-20020a170906ce3700b009b2b9af0784sm6835300ejb.110.2023.10.09.08.43.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 08:43:27 -0700 (PDT)
Message-ID: <b4074e1b-63b0-e37a-dfc6-688c7480cca5@linaro.org>
Date: Mon, 9 Oct 2023 17:43:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 3/6] hw/display/vga: Clean up global variable shadowing
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost
 <eduardo@habkost.net>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, David Hildenbrand <david@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth
 <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20231009094747.54240-1-philmd@linaro.org>
 <20231009094747.54240-4-philmd@linaro.org>
 <333F6764-343E-428B-AB57-76542780083A@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <333F6764-343E-428B-AB57-76542780083A@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/10/23 16:11, Ani Sinha wrote:
> 
> 
>> On 09-Oct-2023, at 3:17 PM, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Fix:
>>
>>   hw/display/vga.c:2307:29: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>>                 MemoryRegion *address_space_io, bool init_vga_ports)
>>                             ^
>>   include/exec/address-spaces.h:35:21: note: previous declaration is here
>>   extern AddressSpace address_space_io;
>>                       ^
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> hw/display/vga_int.h | 2 +-
>> hw/display/vga.c     | 6 +++---
>> 2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
>> index 7cf0d11201..94949d8a0c 100644
>> --- a/hw/display/vga_int.h
>> +++ b/hw/display/vga_int.h
>> @@ -157,7 +157,7 @@ static inline int c6_to_8(int v)
>> }
>>
>> bool vga_common_init(VGACommonState *s, Object *obj, Error **errp);
>> -void vga_init(VGACommonState *s, Object *obj, MemoryRegion *address_space,
>> +void vga_init(VGACommonState *s, Object *obj, MemoryRegion *io,
>>                MemoryRegion *address_space_io, bool init_vga_ports);
> 
> Ok here you are replacing *address_space with *io but …
> 
>> MemoryRegion *vga_init_io(VGACommonState *s, Object *obj,
>>                            const MemoryRegionPortio **vga_ports,
>> diff --git a/hw/display/vga.c b/hw/display/vga.c
>> index 37557c3442..bb4cd240ec 100644
>> --- a/hw/display/vga.c
>> +++ b/hw/display/vga.c
>> @@ -2304,7 +2304,7 @@ MemoryRegion *vga_init_io(VGACommonState *s, Object *obj,
>> }
>>
>> void vga_init(VGACommonState *s, Object *obj, MemoryRegion *address_space,
>> -              MemoryRegion *address_space_io, bool init_vga_ports)
>> +              MemoryRegion *io, bool init_vga_ports)
> 
> Here you replace *address_space_io with *io? This does not look right.

Yeah this is totally wrong, sorry...


