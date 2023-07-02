Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 230A3744D6E
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 13:21:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFv7S-0001Sv-08; Sun, 02 Jul 2023 07:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFv7O-0001Sc-BG
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 07:19:50 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFv7L-0001pg-O5
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 07:19:49 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1b03ec2015fso3149615fac.3
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 04:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688296786; x=1690888786;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fwjspJhm0fNSdjvrIHrR4y6b8xFi93i6UKtlUKyCXJA=;
 b=GkSeB6csMo6VzLkNQwmsj+mga/yZ6sRZ9w/Hdq5SH5T/Bu06IU77meFwZdJPc2o57r
 BOvlc2uNm8KEExzT+Qvo2qr1g2ew6QFzZL+7nuBDexZVvI4EbZONpKJ3CEoWYABkh+gV
 yYizGUbQM/WLWpacWLZO49ramfJid+tAYF+pwNnIrGS9iMowYNrMxpshuiLpwqgHZPyB
 Z8f2coo+sthq9E0WB3BarHHnxyT8+FIhMaLSq5Y0fH0i4UuRnEtGyzVoodkBldQdT1TM
 tdRZWDgRS+GZhEZVGgmUoqT7isml9GoIlhO90snHYadtwezDYQekRxs02LbV6+Xji5TY
 2CFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688296786; x=1690888786;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fwjspJhm0fNSdjvrIHrR4y6b8xFi93i6UKtlUKyCXJA=;
 b=IbuI65ZNkKoYmbPFgGZdh9RU9RjUtTnfle3bHCu5fzgqQy/bE86dTXKjBCW5Z54Aaa
 Q2iKNdyyl9qT0e1frAsuD5EkvqlmDISWeTUSV8IpdM2r8yQmugiWraDgwipK9I9WuYAO
 3C5SnWY7jsni9jaJ/5lh+glpVIcu2/mGD//1c0kqbfAZCo11hu2iDNym/WHN2J5Jw04U
 JIWBOuxPVAL1SbdDWjqtf9OAeN5+eXzOxT5oBSzpOq/XygrEYaPg0RUp27VjGN5mSVYD
 +1lcdS0zSthFiBDCwSprEiw3+ItzwjB/m3uzk/Ls7CdsWxB+5AHuVM2ous5f6Kwl/Zf+
 ZW0A==
X-Gm-Message-State: ABy/qLbtWzeq5n00tICDSzKZ9Xj+J7Q+eXKD8YBUKmKi+uouzLI4cN/A
 4vDRD2gGZVX7Pe/L7ciqgIrFbQ==
X-Google-Smtp-Source: ACHHUZ6xYIXkFgCCNB4F1nIvWbVqou/roG7c/8yYki26cdPF2UoqsRVKz/JtGKO6VO4fXD2R8IvKQg==
X-Received: by 2002:a05:6870:3c16:b0:1a6:4f6a:8a5c with SMTP id
 gk22-20020a0568703c1600b001a64f6a8a5cmr10665994oab.5.1688296786397; 
 Sun, 02 Jul 2023 04:19:46 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a17090a1b0e00b0025e9519f9e7sm14824728pjq.15.2023.07.02.04.19.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Jul 2023 04:19:46 -0700 (PDT)
Message-ID: <611d209e-0fd7-5e72-7f25-61fc88ec1a2f@daynix.com>
Date: Sun, 2 Jul 2023 20:19:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/4] docs: Fix next function numbers in SR/IOV
 documentation
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
References: <20230702094631.39111-1-akihiko.odaki@daynix.com>
 <20230702094631.39111-2-akihiko.odaki@daynix.com>
 <20230702064038-mutt-send-email-mst@kernel.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230702064038-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2001:4860:4864:20::2d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On 2023/07/02 19:40, Michael S. Tsirkin wrote:
> On Sun, Jul 02, 2023 at 06:46:25PM +0900, Akihiko Odaki wrote:
>> The ARI next function number field is undefined for VF so the PF should
>> end the linked list formed with the field by specifying 0.
>>
>> This also changes the value of the field for VF; it seems to imply the
>> value has some meaning if it differs from one of the PF, but it doesn't.
>>
>> Fixes: 2503461691 ("pcie: Add some SR/IOV API documentation in docs/pcie_sriov.txt")
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   docs/pcie_sriov.txt | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/pcie_sriov.txt b/docs/pcie_sriov.txt
>> index 7eff7f2703..2b7094dc47 100644
>> --- a/docs/pcie_sriov.txt
>> +++ b/docs/pcie_sriov.txt
>> @@ -48,7 +48,7 @@ setting up a BAR for a VF.
>>         ...
>>         int ret = pcie_endpoint_cap_init(d, 0x70);
>>         ...
>> -      pcie_ari_init(d, 0x100, 1);
>> +      pcie_ari_init(d, 0x100, 0);
>>         ...
>>   
>>         /* Add and initialize the SR/IOV capability */
>> @@ -78,7 +78,7 @@ setting up a BAR for a VF.
>>         ...
>>         int ret = pcie_endpoint_cap_init(d, 0x60);
>>         ...
>> -      pcie_ari_init(d, 0x100, 1);
>> +      pcie_ari_init(d, 0x100, 0);
>>         ...
>>         memory_region_init(mr, ... )
>>         pcie_sriov_vf_register_bar(d, bar_nr, mr);
> 
> 
> So now code does not match docs.

Can you elaborate more?

