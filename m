Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D35907EBE98
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 09:33:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3BJK-0001nh-KR; Wed, 15 Nov 2023 03:31:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r3BJ9-0001kS-Fr
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 03:31:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r3BJ8-0000cb-00
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 03:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700037089;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i/sp9dSk+9d6wb5LOzdsqAqrNA2dbjX/YACVS7sU5LI=;
 b=PA7oVtVG4TPzsRy7JH2kSPUb7faJQ3j5s+N9hHcgRNxg/DFqxVCMs4A5UoOYJ8C84xkOMw
 NBOu+HZBRSL0dcYzG+KFggVtclQa7gD8VVaFIf3BwL/Nomm0ghor63Jz01c7XTg4MKYjN1
 Rg0use7zv8Nqohf6+g3ZjCfOGotb8J4=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-R6GTOSzSPS63LYT3KwW2gw-1; Wed, 15 Nov 2023 03:31:28 -0500
X-MC-Unique: R6GTOSzSPS63LYT3KwW2gw-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-daee86e2d70so7945241276.0
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 00:31:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700037087; x=1700641887;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i/sp9dSk+9d6wb5LOzdsqAqrNA2dbjX/YACVS7sU5LI=;
 b=vkb6InTwrqOBrdX5+A1vpWU1/b0jFepHhcYwCFTepiGPJIhHH3mIJEbf99hQEN8TvE
 3Ql//0VkZ/ObJDglmzVg1/ZRmt+67KDwMYL9wgx3UMbZHcBpk2lHPHPMVmJNlSTWEDr3
 9d4cO6ASVIYcw2qxmnlQjAoygFj931IsL8oQs/Wiw6MjmUxuKcZ9w+vuiFLYvq/vbItT
 2t2VTdiGHFTaLGx433ikZmDzeBloD2IM8T5+mJ8TOCXUwCDKeiTmcQnvUE5IU1TpuXFX
 AiTxXsFgkW/CnMCXm66x8saS2aIr1gvPZQ8kgHTBAxwEoUPxL3FiYtOmpSPs9Y+f99m2
 h7cA==
X-Gm-Message-State: AOJu0YxcHwgXC39KUEhivbWkhZIMkTIyKlD+NUqWKVlD8Thzowz2VD3z
 deWcgAuPlLSm5dGfwvd9b8lAr/xcjjlnvZRiaZEaiCrAAPuPUf4N5wnKMC5VaRN9f3+/eyTXmko
 BknwCbnOI0vBRKnM=
X-Received: by 2002:a25:2905:0:b0:d9a:bddd:f714 with SMTP id
 p5-20020a252905000000b00d9abdddf714mr11377379ybp.9.1700037087554; 
 Wed, 15 Nov 2023 00:31:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7aWKa2QwbkaVBgvtIIE2aYzdg2yAnLhBeb+LpbuHc9ceFR/dQZG9896ke4gWFypU6MvN84g==
X-Received: by 2002:a25:2905:0:b0:d9a:bddd:f714 with SMTP id
 p5-20020a252905000000b00d9abdddf714mr11377372ybp.9.1700037087270; 
 Wed, 15 Nov 2023 00:31:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 lf19-20020a0562142cd300b0065afedf3aabsm364626qvb.48.2023.11.15.00.31.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 00:31:26 -0800 (PST)
Message-ID: <68c65be2-dbee-4fcb-9a4b-dea67a60c24e@redhat.com>
Date: Wed, 15 Nov 2023 09:31:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado/intel_iommu: Add asset hashes to avoid
 warnings
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20231114143531.291820-1-thuth@redhat.com>
 <5f09ba2a-3e62-454a-8665-0f80508b5168@redhat.com>
 <ff6f2d1f-dc7a-408c-a6d8-19e5fec9fea6@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <ff6f2d1f-dc7a-408c-a6d8-19e5fec9fea6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Thomas,

On 11/15/23 07:20, Thomas Huth wrote:
> On 14/11/2023 21.42, Eric Auger wrote:
>> Hi Thomas,
>>
>> On 11/14/23 15:35, Thomas Huth wrote:
>>> The intel_iommu test is currently succeeding with annoying warnings.
>> nit: you may have precised the nature of the warning or quotes
>
> The annoying warnings look like this (in the summary):
>
>  (031/174) tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu:
> WARN: Test passed but there were warnings during execution. Check the
> log for details. (67.87 s)
>  (032/174)
> tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu_strict: WARN:
> Test passed but there were warnings during execution. Check the log
> for details. (55.83 s)
>  (033/174)
> tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu_strict_cm:
> WARN: Test passed but there were warnings during execution. Check the
> log for details. (56.01 s)
>  (034/174)
> tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu_pt: WARN:
> Test passed but there were warnings during execution. Check the log
> for details. (54.06 s)
>
> ... not too helpful to quote them in the commit log, I guess...
Ah OK. Not really helpful indeed ;-)

Eric
>
>>> Add the proper asset hashes to avoid those.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   tests/avocado/intel_iommu.py | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/avocado/intel_iommu.py
>>> b/tests/avocado/intel_iommu.py
>>> index 474d62f6bf..77635ab56c 100644
>>> --- a/tests/avocado/intel_iommu.py
>>> +++ b/tests/avocado/intel_iommu.py
>>> @@ -54,9 +54,11 @@ def common_vm_setup(self, custom_kernel=None):
>>>               return
>>>             kernel_url = self.distro.pxeboot_url + 'vmlinuz'
>>> +        kernel_hash = '5b6f6876e1b5bda314f93893271da0d5777b1f3c'
>>>           initrd_url = self.distro.pxeboot_url + 'initrd.img'
>>> -        self.kernel_path = self.fetch_asset(kernel_url)
>>> -        self.initrd_path = self.fetch_asset(initrd_url)
>>> +        initrd_hash = 'dd0340a1b39bd28f88532babd4581c67649ec5b1'
>>> +        self.kernel_path = self.fetch_asset(kernel_url,
>>> asset_hash=kernel_hash)
>>> +        self.initrd_path = self.fetch_asset(initrd_url,
>>> asset_hash=initrd_hash)
>>>         def run_and_check(self):
>>>           if self.kernel_path:
>> Besides,
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>
> Thanks!
>
>  Thomas
>


