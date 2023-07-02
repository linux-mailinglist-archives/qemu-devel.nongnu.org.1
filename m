Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3ED744C25
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 05:53:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFo88-0001xz-Jo; Sat, 01 Jul 2023 23:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFo86-0001xa-SN
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 23:52:06 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFo7y-0001DY-An
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 23:52:06 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1b7fef01fe4so18733905ad.0
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 20:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688269913; x=1690861913;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D5XubCbqbcRQcOAMDiVKiDMMgVHc2JFM6oQ+N4uvb40=;
 b=d/IkwCZwZxAwMTTaD5802LS8+Qhd/27XyUynb0+Y88tcWlAiQAzzRPqLieoKLBf0oF
 Vqano5Q8jPGQGgLOmvNIjH1tQ5hy1+bdj5bj909cAO6ZQEQJTKUSOjE5gtEmhcVon1iW
 FS8B9WasErg8i8pkKd+lz6LiuJZQmy7d58fvkq0zyHofA12YL+C9Txi/XlPqOBe4fKKR
 sok/La4KTAyPFE8tpPfFZACWkFunvvstVM8gphIzk5lFThKOZk72yXGBEAyUBH1lLuVP
 JRV0uh7/I7UXGpUvrif/PtYPtGOQ8YSHNcKbRdqSJTpYhNoBUS1+wxGk5EDq3LPsrWfb
 v4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688269913; x=1690861913;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D5XubCbqbcRQcOAMDiVKiDMMgVHc2JFM6oQ+N4uvb40=;
 b=P8J3qzTws65nwTNME89WUBeaGDLS7aS2Y8UW7Kq5uoxRaW05Yqn+ZIxAgmqffMca6a
 wHDP96kNZEN1GMDEgIYJphghic764Cxplmty+qZ0rU1HgbrWyjpBUb7yUi+b5rY6M7ky
 ORFENU+qlJ4hG0xE7Xo9bCsXi5ivyi5KdhPN7U3F1oNVyXqnp5pogdS0hb4VDZIaoF2r
 f3yDBSymN8cptFqPYGJUyXvS3tnUbUyNDpJtrqJGiX3B/QrDjIH475HrYVKtRwnGCSdq
 l+cYW+ZpYTzHO7gMQYjNay1eN/0RTmUom8NnbTKh/964jEMILdqZhUc3ecLL4+W4S+IL
 Mw9w==
X-Gm-Message-State: ABy/qLa0ljUKMqs58yA1S0WgC1TpZbnCv6Wql+mVp3D4kJWY8A6GuXmj
 2rBPniUbE/wjOqZgLTmYtw3djA==
X-Google-Smtp-Source: APBJJlHdwm8mYu9kjbAKLQw6EMhp5CEzu0MhahHCUMe5NMxqwPEY+ui+G0uBN9EaFMQRJ2uV0hHuyw==
X-Received: by 2002:a05:6a00:24d1:b0:666:81ae:fec0 with SMTP id
 d17-20020a056a0024d100b0066681aefec0mr5649083pfv.25.1688269913197; 
 Sat, 01 Jul 2023 20:51:53 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 s4-20020aa78284000000b0063b8ddf77f7sm12008968pfm.211.2023.07.01.20.51.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jul 2023 20:51:52 -0700 (PDT)
Message-ID: <354b2e91-a92b-0886-cbd6-7175a9461fbf@daynix.com>
Date: Sun, 2 Jul 2023 12:51:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] docs: Fix next function numbers in SR/IOV
 documentation
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
References: <20230701070133.24877-1-akihiko.odaki@daynix.com>
 <20230701070133.24877-2-akihiko.odaki@daynix.com>
 <F9B87AA5-617E-4AD7-A2F8-92C54819F875@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <F9B87AA5-617E-4AD7-A2F8-92C54819F875@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2023/07/01 23:31, Ani Sinha wrote:
> 
> 
>> On 01-Jul-2023, at 12:31 PM, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> The next function numbers are expected to form a linked list ending with
>> 0.
>>
>> Fixes: 2503461691 ("pcie: Add some SR/IOV API documentation in docs/pcie_sriov.txt")
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>> docs/pcie_sriov.txt | 5 +++--
>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/pcie_sriov.txt b/docs/pcie_sriov.txt
>> index 7eff7f2703..cc4232e49a 100644
>> --- a/docs/pcie_sriov.txt
>> +++ b/docs/pcie_sriov.txt
>> @@ -48,7 +48,7 @@ setting up a BAR for a VF.
>>        ...
>>        int ret = pcie_endpoint_cap_init(d, 0x70);
>>        ...
>> -      pcie_ari_init(d, 0x100, 1);
>> +      pcie_ari_init(d, 0x100, fun_offset);
>>        ...
>>
>>        /* Add and initialize the SR/IOV capability */
>> @@ -76,9 +76,10 @@ setting up a BAR for a VF.
>>     pci_your_vf_dev_realize( ... )
>>     {
>>        ...
>> +      uint16_t nextvfn = pcie_sriov_vf_number(dev) + 1;
>>        int ret = pcie_endpoint_cap_init(d, 0x60);
>>        ...
>> -      pcie_ari_init(d, 0x100, 1);
>> +      pcie_ari_init(d, 0x100, nextvfn < total_vfs ? fun_offset + nextvfn * stride : 0);
>                                                                                                                                                      ^^^^
> I think this will be fun_offset and not just 0
> Same with the other patches ..

It is intended to point to the PF. fun_offset points to the first VF.

> 
>>        ...
>>        memory_region_init(mr, ... )
>>        pcie_sriov_vf_register_bar(d, bar_nr, mr);
>> -- 
>> 2.41.0
>>
> 

