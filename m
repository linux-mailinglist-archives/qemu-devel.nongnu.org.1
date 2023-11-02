Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A334B7DF3AE
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 14:25:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyXhI-0001HA-7W; Thu, 02 Nov 2023 09:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qyXhG-0001Gz-2b
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 09:25:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qyXhD-0001p7-5B
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 09:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698931513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VCMoGHay3E7aF7R69T7S8uoajFTOhZ8UrVMcIY11jX0=;
 b=MgBd2CjQtxZqp8L2VFNgMdTZqDa+Cyggc8pKu7PkbabsVXHuxh7i5j4xhFPxuwxbLx39Ug
 gFZXQ7R+4O6SrMMTybm7XPgSpFeeJ2fW9zUbX0KGM7Xo7sgZ+OvsXszdeH3pa+6YC7d5sE
 2KK/fYsebK8HutIIg89hhPGd9+f9Irc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-Oyc_F3y3PLCPtnPh-Qxvow-1; Thu, 02 Nov 2023 09:25:11 -0400
X-MC-Unique: Oyc_F3y3PLCPtnPh-Qxvow-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c50257772bso9167741fa.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 06:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698931509; x=1699536309;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VCMoGHay3E7aF7R69T7S8uoajFTOhZ8UrVMcIY11jX0=;
 b=XHojImVvlC5/icSJHwWJ0OEhxyEtVG9cI5UrLLLGxJwLtUhFyOy6fAysdzCyhZXf7w
 6AcIdGx7cXK2KnpCpBs8oTZ3jbdjxjewVHh0nMoi0NhsOcPCv5qIaB19P3PQVWpgpa7y
 jbvEVlzgSISBZp8yzMU9ZgO8b8FWzafWAKODHgIAS+g2KgCadHj4Rieuf40/KXI7f0hk
 YT3OQZ49VbYpAPl7j4rVFdZqStb3lh07aqNECITrzOVJsDQz7NSDIlEuLlOiHCFxgnIx
 z+7jaXEGG2F3gmcRwYmRdYqJN5dRI4cPIcCEE5obhtIH7q6umMSf4fT5Wci88MZzWSue
 Hswg==
X-Gm-Message-State: AOJu0YyeZFbsQi7SArHC8QCaRrW4cpgMp/BhC8oTR4f3CxCPp6bwtvfj
 dDyxfRfxK+y1kdIu2GST2+l8Whv/TloTfVC+7geMIKXCK2SKZVeZ2mrQE10qfyxEP9LTyI40VlJ
 xGyNYilkXgiHttiOsa2BNr6/wyhVI2spfuinPK6vAe22Wrd3aUuU4OXaTW5MEPhdXDdXFOWs=
X-Received: by 2002:a2e:9a86:0:b0:2bd:180d:67b1 with SMTP id
 p6-20020a2e9a86000000b002bd180d67b1mr15398322lji.51.1698931509657; 
 Thu, 02 Nov 2023 06:25:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNaWlAkVP5vgyENBVBknkj5Kp/gSFI7UwgCMm8rkTBuXDutU0D0WuzwBY7VH2YnvnZioruNA==
X-Received: by 2002:a2e:9a86:0:b0:2bd:180d:67b1 with SMTP id
 p6-20020a2e9a86000000b002bd180d67b1mr15398306lji.51.1698931509172; 
 Thu, 02 Nov 2023 06:25:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c716:3000:f155:cef2:ff4d:c7?
 (p200300cbc7163000f155cef2ff4d00c7.dip0.t-ipconnect.de.
 [2003:cb:c716:3000:f155:cef2:ff4d:c7])
 by smtp.gmail.com with ESMTPSA id
 d25-20020a05600c4c1900b003fe1c332810sm2851996wmp.33.2023.11.02.06.25.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Nov 2023 06:25:08 -0700 (PDT)
Message-ID: <394b537c-2833-4c71-98c0-2db4d1b3d956@redhat.com>
Date: Thu, 2 Nov 2023 14:25:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] virtio-mem: fix division by zero in
 virtio_mem_activate_memslots_to_plug()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Mario Casquero <mcasquer@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
References: <20231023111341.219317-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231023111341.219317-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 23.10.23 13:13, David Hildenbrand wrote:
> When running with "dynamic-memslots=off", we enter
> virtio_mem_activate_memslots_to_plug() to return immediately again
> because "vmem->dynamic_memslots == false". However, the compiler might
> not optimize out calculating start_idx+end_idx, where we divide by
> vmem->memslot_size. In such a configuration, the memslot size is 0 and
> we'll get a division by zero:
> 
>      (qemu) qom-set vmem0 requested-size 3G
>      (qemu) q35.sh: line 38: 622940 Floating point exception(core dumped)
> 
> The same is true for virtio_mem_deactivate_unplugged_memslots(), however
> we never really reach that code without a prior
> virtio_mem_activate_memslots_to_plug() call.
> 
> Let's fix it by simply calling these functions only with
> "dynamic-memslots=on".
> 
> This was found when using a debug build of QEMU.
> 
> Reprted-by: Mario Casquero <mcasquer@redhat.com>
> Fixes: 177f9b1ee464 ("virtio-mem: Expose device memory dynamically via multiple memslots if enabled")
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Queued to

https://github.com/davidhildenbrand/qemu.git mem-next

-- 
Cheers,

David / dhildenb


