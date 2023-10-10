Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EF57BFBCD
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 14:51:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqCCT-0000YI-GI; Tue, 10 Oct 2023 08:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqCCR-0000Wn-Cc
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:50:59 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqCCP-00044Z-I4
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:50:59 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9ae75ece209so1018570866b.3
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696942256; x=1697547056; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ad08G+rVW9fKY4cJRcOJHAnqKJuo12utYYXblggBquo=;
 b=NyuA8GVPIB2+5OFhfDvxC4En4EIZ413t3Vlfb+1rW7oZVjvsVvINmLfu6gu5ELOUwV
 v2jjNUHT3RSydHzAg/Ppu1iu71Xfou7OQn10fcHY67REbz9VM5tlSI1YIcgwjM7exOu/
 K4Mm5eBHsIDV2VHG7RCs0uzAxv0x41r7YQ6JIUg/JWEB8qdJQxNQu9yGaLXqRZLwJLce
 3mdIshl8/BBeeK8vsL1kOht9CUK/LZc97k9kMxkc9KEgwR+mpuj7o82TdRWdjZKAm5qO
 Ylg+px6ZnZnJmCXjgC+1qnB0P/kj5ileRCCLh35uhW6VBqL7fiUikWUk7WgLIeA9CYdI
 3+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696942256; x=1697547056;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ad08G+rVW9fKY4cJRcOJHAnqKJuo12utYYXblggBquo=;
 b=syNbRWQKzsIZhJQkA3YI4tfS3i1K67n+MpRa2T+RMc4R6LaRnsk83FaxPBJlC2uLYx
 1wpnEPgi+0NpmlCQE99VffreE9EMnV++gmNEJbpKNLNuF/Gt9XyTHvEjH+Qax/fajROw
 yl3b+1E8PA7J57CpSle559uZZI0UEIe4NY40M0SmFzH1VPu7bPgNXYG9BTJvKPFNPdps
 gH22GrnGjIfQWaS2ouGPdGSKtmk3Bk+GOU/SEoSU2uvbu6i/QlbY6zUuPQRpxbKccgt9
 CR6UavkmY/Ya+npYMLC3OLfnzK9ZMNCTn1g2X8WDIiS1ngYkgTBywXZObaA6lNx2UStG
 rCVw==
X-Gm-Message-State: AOJu0YzqyNeATjrXW79cnDXeqs9RP5kp1Px80qfesUnOhxeLvv4qqQAx
 ybvbZiMhDZA8I22U68SswNfn/w==
X-Google-Smtp-Source: AGHT+IHzypXOFt/AfdeN7rtnV/elvAth0cSPh2ugifRO6YWx7x2PQcKVorf35eWPyKdLhwPKcp/CyA==
X-Received: by 2002:a17:906:209b:b0:9a9:f17e:412f with SMTP id
 27-20020a170906209b00b009a9f17e412fmr19677074ejq.50.1696942255690; 
 Tue, 10 Oct 2023 05:50:55 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr. [176.172.113.148])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a1709063c1100b009b94a8150d8sm8502220ejg.199.2023.10.10.05.50.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 05:50:55 -0700 (PDT)
Message-ID: <5e31c60b-08f9-0bb5-b35b-849695364751@linaro.org>
Date: Tue, 10 Oct 2023 14:50:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/6] hw/display/vga: Clean up global variable shadowing
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20231010115048.11856-1-philmd@linaro.org>
 <20231010115048.11856-4-philmd@linaro.org>
 <0FFB0F58-830E-47D6-BC07-E668EDE2692C@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <0FFB0F58-830E-47D6-BC07-E668EDE2692C@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 10/10/23 14:46, Ani Sinha wrote:
> 
> 
>> On 10-Oct-2023, at 5:20 PM, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Rename 'address_space' -> 'legacy_io' and
>> 'address_space_io' -> 'io' to fix:
> 
> This works but why not replace address_space with legacy_address_space instead?

I'd rather avoid using 'address_space' for MemoryRegion, since we
also have an AddressSpace type.

Besides, both regions are mapped in I/O space.

> 
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
>> hw/display/vga_int.h |  4 ++--
>> hw/display/vga.c     | 12 ++++++------
>> 2 files changed, 8 insertions(+), 8 deletions(-)


