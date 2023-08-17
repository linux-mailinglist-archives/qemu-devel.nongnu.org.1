Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF0277F8F6
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 16:30:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWe18-0001Ny-9j; Thu, 17 Aug 2023 10:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qWe13-0001L8-Ua
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:30:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qWe11-0007Eu-EU
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692282620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eolIBFljUPAFq5HpURwofL438D7hlQjAqPaOxFCbLi4=;
 b=W5UQ9GpTUVCFIDMUcT3C3UkfNGJ0ENUJvm01MbSmcVvN+9/z0OrxdlFeQE9MyrKwSCxLWe
 puin1Vy7xx5+1YayDQwOZ5C8YYFY1rlefOjsfs1g+a1Ji11zVLsCzwBE8gSQty2hVNoK87
 rrHMxLwcb9FCS/YZg9BeBb9JL0QFxyU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-EB7HIKqiP4eJLRRDoA8luQ-1; Thu, 17 Aug 2023 10:30:19 -0400
X-MC-Unique: EB7HIKqiP4eJLRRDoA8luQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so50043125e9.3
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 07:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692282618; x=1692887418;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eolIBFljUPAFq5HpURwofL438D7hlQjAqPaOxFCbLi4=;
 b=FieQmxHpxPg9N7YoDO1LqlJ+FDUCO4aqhl814N2DJo9iWBF19rWUTMdJNS2FVVWF74
 /nTS49Eqyca6bp/U9eEXsWgZHMOAQKu66BZW9w0uwwgWb6fVGCEb+AvH0pv+CzanzyXj
 lkGukJF8upUdfITj1GSWwLgftn+o5VBkHmAGTY/OdxR/VGjwi6c2vn4Vi3s+0pvK6tF7
 9LAOutES9j0danRtYpbGtvCpGSGFUjAo5CQ3tKPfelk0YqCywU7ceOwzQwW2XFmyLged
 ltfkIGUDyMAQswafQ3JWYGGUTFdcbrI4WP5fU8BEtUYWjGoGhtjWkr26O3QI5sYOivb1
 1/Rg==
X-Gm-Message-State: AOJu0YxFEwSJtzav1bxgKNZyjlaZ8iG2zea5zrjVVFmn6vn/cNGP6Ry/
 X7rgd08TieGYUWSPhk3qWY3hrJGTjf+3I1RySkND+saRaRx8cFsVjYGN1oZHpGFyZrvzMYQ7EW4
 W/QfpZtTjh6iFnHc=
X-Received: by 2002:a1c:cc12:0:b0:3fb:d1db:5454 with SMTP id
 h18-20020a1ccc12000000b003fbd1db5454mr4305300wmb.35.1692282617950; 
 Thu, 17 Aug 2023 07:30:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjEfON6gbcS+yysLZ033Ilaordcpo0gaUVMi/TpSuNrDyX2Iuqcm4U1zi7QBcYXk4EPRrTKw==
X-Received: by 2002:a1c:cc12:0:b0:3fb:d1db:5454 with SMTP id
 h18-20020a1ccc12000000b003fbd1db5454mr4305282wmb.35.1692282617621; 
 Thu, 17 Aug 2023 07:30:17 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 w3-20020a05600c014300b003fe0a0e03fcsm3165284wmm.12.2023.08.17.07.30.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 07:30:17 -0700 (PDT)
Message-ID: <c92648e5-e974-48ac-2213-b5926a16ed4d@redhat.com>
Date: Thu, 17 Aug 2023 16:30:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: ThinerLogoer <logoerthiner1@163.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com> <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com> <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
 <1b4168d2.4182.189e324e0ef.Coremail.logoerthiner1@163.com>
 <08cc9db9-b774-b027-58f5-dd7e6c374657@redhat.com>
 <2b967b3.13b7.189e82ee694.Coremail.logoerthiner1@163.com>
 <06f9a805-8150-8106-7d0a-05d0d2465cd0@redhat.com>
Organization: Red Hat
In-Reply-To: <06f9a805-8150-8106-7d0a-05d0d2465cd0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.01, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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


> @Stefan, do you have any concern when we would do 1) ?
> 
> As far as I can tell, we have to set the nvdimm to "unarmed=on" either way:
> 
> +   "unarmed" controls the ACPI NFIT NVDIMM Region Mapping Structure "NVDIMM
> +   State Flags" Bit 3 indicating that the device is "unarmed" and cannot accept
> +   persistent writes. Linux guest drivers set the device to read-only when this
> +   bit is present. Set unarmed to on when the memdev has readonly=on.
> 
> So changing the behavior would not really break the nvdimm use case.

Looking into the details, this seems to be the right thing to do.

This is what I have now as patch description, that also highlights how libvirt
doesn't even make use of readonly=true.


 From 42f272ace68e0cd660a8448adb5aefb3b9dd7005 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Thu, 17 Aug 2023 12:09:07 +0200
Subject: [PATCH v2 2/4] backends/hostmem-file: Make share=off,readonly=on
  result in RAM instead of ROM

For now, "share=off,readonly=on" would always result in us opening the
file R/O and mmap'ing the opened file MAP_PRIVATE R/O -- effectively
turning it into ROM.

As documented, readonly only specifies that we want to open the file R/O:

     @readonly: if true, the backing file is opened read-only; if false,
         it is opened read-write.  (default: false)

Especially for VM templating, "share=off" is a common use case. However,
that use case is impossible with files that lack write permissions,
because "share=off,readonly=off" will fail opening the file, and
"share=off,readonly=on" will give us ROM instead of RAM.

With MAP_PRIVATE we can easily open the file R/O and mmap it R/W, to
turn it into COW RAM: private changes don't affect the file after all and
don't require write permissions.

This implies that we only get ROM now via "share=on,readonly=on".
"share=off,readonly=on" will give us RAM.

The sole user of ROM via memory-backend-file are R/O NVDIMMs. They
also require "unarmed=on" to be set for the nvdimm device.

With this change, R/O NVDIMMs will continue working even if
"share=off,readonly=on" was specified similar to when simply
providing ordinary RAM to the nvdimm device and setting "unarmed=on".

Note that libvirt seems to default for a "readonly" nvdimm to
* -object memory-backend-file,share=off (implying readonly=off)
* -device nvdimm,unarmed=on
And never seems to even set "readonly=on" for memory-backend-file. So
this change won't affect libvirt, they already always get COW RAM -- not
modifying the underlying file but opening it R/O.

If someone really wants ROM, they can just use "share=on,readonly=on".
After all, there is not relevant difference between a R/O MAP_SHARED
file mapping and a R/O MAP_PRIVATE file mapping.

Signed-off-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


