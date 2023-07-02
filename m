Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3323F744D14
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 11:50:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFtiV-0007Hh-48; Sun, 02 Jul 2023 05:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFtiP-0007HO-Q3
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 05:49:57 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFtiO-000898-AU
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 05:49:57 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-666ed230c81so2969943b3a.0
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 02:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688291393; x=1690883393;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YE3wnDw5foKp/WZylnf46yeOa5vkfZ7gdKr2zRxuWrg=;
 b=LCzMMuBQ20ZuNxFCt3OvbZDqs6XtgBcG5fxl1AiXPLlkrGIOhetebGDmuZqEoquHDs
 IaU2ol6vl9653s8X88T6SgrmtMSHTKQyVnEu0uTUYjkRQRct1VoBVBKMdO1hMc9gRp9M
 Gtx7pt7fECOpnw1E1xZUm58L4cPFU6H4Ncdctn3JwMywBJ6l8E3JjXsTJlxUfBnpwjOq
 LfaM0MTT7t+RGeyakevntXThPiDvflhGl1a34jNus+JKpyd+HpaAlZApuV6RlkQjh+LZ
 lFKbzO7uiq88CanMbeQmod7MEi5sWuIiMe7TZouWS2uE2hsM55pXZu6MzfsgeIMBcate
 nQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688291393; x=1690883393;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YE3wnDw5foKp/WZylnf46yeOa5vkfZ7gdKr2zRxuWrg=;
 b=QaCppaB9tFHcS1zuwN9EzbB8xnkEjsz0SwRT4p/PiCigsHJ1xN5oGs6PD//Y4aN8ZG
 +GzwUipbIIN4KCkVZmPBzP4Ocs9Mxkgr8DFtgvLl5yzAjZa6YbcAUWrfUCVyTnYaNKMe
 kZzMFD6IXQRB0TscghLqcEnPhqSauYWXDU0Mw0NjX+OnzrpfHBA1WWBoACW2lhqObtY3
 Hn1g7A2EP1u+3c1UYVKPj5YPmDn17q6GfYnUtr++G+bZ2nGpigPAa9OrTUPDc5A1OBgc
 KRtgtk96Q3DN0PD4XLWMzgrHKrUV/AIKE+XKiGSHKnnoJmid6ZF0ZA11eEKRkQUz+X8z
 mfVw==
X-Gm-Message-State: ABy/qLaoCPDA2Itn6l4G+9IvUqvNcyMuospjeGdivVNjdhbkZ7Ljrt0X
 5GQPQo8s9zDvr/EdfIPGyu3Kzw==
X-Google-Smtp-Source: APBJJlHIMMimoI2yBM0aIgGQbRGGZycjkmx8nD/ZHGemFig5Rlk74yfLIm2A4y6sxkUcuQXtQ66vdg==
X-Received: by 2002:a05:6a00:138d:b0:680:2b80:8479 with SMTP id
 t13-20020a056a00138d00b006802b808479mr9759495pfg.19.1688291393717; 
 Sun, 02 Jul 2023 02:49:53 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a62ae11000000b00679dc747738sm10035140pff.10.2023.07.02.02.49.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Jul 2023 02:49:53 -0700 (PDT)
Message-ID: <d0769c54-62f7-6aa8-01b1-0e40cc46e02a@daynix.com>
Date: Sun, 2 Jul 2023 18:49:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] igb: Fix ARI next function numbers
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
References: <20230702083357.13517-1-akihiko.odaki@daynix.com>
 <20230702083357.13517-4-akihiko.odaki@daynix.com>
 <20230702045815-mutt-send-email-mst@kernel.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230702045815-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 2023/07/02 18:00, Michael S. Tsirkin wrote:
> On Sun, Jul 02, 2023 at 05:33:56PM +0900, Akihiko Odaki wrote:
>> The ARI next function number field is undefined for VF so the PF should
>> end the linked list formed with the field by specifying 0.
>>
>> Fixes: 3a977deebe ("Intrdocue igb device emulation")
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> 
> I would also change it for the VF just so people don't wonder
> what's the magic value. Do document in commit log though.
> 
> Maybe just drop this parameter from pcie_ari_init completely
> for now?

I sent v2, but it doesn't change the field for VFs either to save code 
for migration. The parameter for pcie_ari_init() also remains to migrate 
from older versions.

> 
> 
>> ---
>>   hw/net/igb.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/net/igb.c b/hw/net/igb.c
>> index 1c989d7677..897386fc09 100644
>> --- a/hw/net/igb.c
>> +++ b/hw/net/igb.c
>> @@ -431,7 +431,7 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
>>           hw_error("Failed to initialize AER capability");
>>       }
>>   
>> -    pcie_ari_init(pci_dev, 0x150, 1);
>> +    pcie_ari_init(pci_dev, 0x150, 0);
>>   
>>       pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF,
>>           IGB_82576_VF_DEV_ID, IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,
>> -- 
>> 2.41.0
> 

