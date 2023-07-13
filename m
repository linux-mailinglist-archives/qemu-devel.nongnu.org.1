Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC5F75206A
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 13:52:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJurU-00068c-JV; Thu, 13 Jul 2023 07:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qJurS-00068L-3z
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 07:51:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qJurQ-0002e0-H9
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 07:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689249111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZC31GdCHW6wkhcoUhkkI9YDNYn1ED8WDqWcICTi5k64=;
 b=SSv2iCT/jHP75LbNwSMe0tUz1iFMmioAU/3ZR5bkm3VfpNBSq4bGgASNaTlU4HvNbWRDYQ
 4dS68FZDYit1GOtZb26m3BmN8xdBH6+cuNF4Q0JIvUiyEiW+Up8p2F3X275D+GUxHfpnmq
 3b0n6B2BPftb2qkKt9mUsH5Idw327MI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-_S6RWwBeOayxl0KKYfFW1A-1; Thu, 13 Jul 2023 07:51:50 -0400
X-MC-Unique: _S6RWwBeOayxl0KKYfFW1A-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-621257e86daso6957666d6.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 04:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689249109; x=1691841109;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZC31GdCHW6wkhcoUhkkI9YDNYn1ED8WDqWcICTi5k64=;
 b=K0ABgHFkf/WEOPqnSXb+WV7/ZPnpYyY/mYmoa2q/k7/OaloaKWXGaewD40p2pHrwKR
 pZh7L2VXGuUFSxjHrivsNm6eZN2JFFtYDmgCX91I2kulWYlaL2O9kqoyrwgQg1MuIx09
 7rMjobxnrPr63B6ciH3f4b5E5xNkiiP7QnQpZ2sRjdwOsQsPdtP0wYzw8o3Km7rke+72
 Iz4A9eEaAuaHVn1GfdaUhkhS4pL5yZJszkYyfb+7wsLBZiyOGl1fIH1/Hnv/g66CdjS5
 WbVP4YJJgE3UdIxSwxIpOlcqYbRDivG5NmL9ljkxHcWUK3fq6B40oIEbBGb0Tq0thTxf
 T0YA==
X-Gm-Message-State: ABy/qLYkkyl5wbr8iLT4QNF8oqot0YrhAcJTGRIBTkU5FR26hJP3Nbdi
 P4ydjGnvnIEjbSzAN9bhopGeFBl0Tx68iMU6nMUo0Z7OlYz1WOsLRlEUNsM70IS891Vppa9896X
 3LvwWZsE5ywMDXNw=
X-Received: by 2002:a0c:e001:0:b0:637:5742:e370 with SMTP id
 j1-20020a0ce001000000b006375742e370mr1181230qvk.50.1689249109811; 
 Thu, 13 Jul 2023 04:51:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGcIAbs1FFFQJoJlxJOkEmoLcZqDHXuFhhwoYlSLz5cC4pc6uzggsofn12t/0zsUZTWxJABKw==
X-Received: by 2002:a0c:e001:0:b0:637:5742:e370 with SMTP id
 j1-20020a0ce001000000b006375742e370mr1181212qvk.50.1689249109463; 
 Thu, 13 Jul 2023 04:51:49 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 a12-20020a0ce38c000000b0062de6537febsm2999898qvl.58.2023.07.13.04.51.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 04:51:48 -0700 (PDT)
Message-ID: <652f313b-ff67-1579-b3e5-b1550847a363@redhat.com>
Date: Thu, 13 Jul 2023 13:51:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] hw/mips: Improve the default USB settings in the
 loongson3-virt machine
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
References: <20230621074134.82781-1-thuth@redhat.com>
 <062e8b3b-dcdd-8f87-d245-ea9e16b1c276@linaro.org>
 <512d2664-5464-a502-391a-bf41491926fe@tls.msk.ru>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <512d2664-5464-a502-391a-bf41491926fe@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 13/07/2023 13.47, Michael Tokarev wrote:
> 13.07.2023 13:09, Philippe Mathieu-Daudé wrote:
>> Hi Thomas,
>>
>> On 21/6/23 09:41, Thomas Huth wrote:
>>> It's possible to compile QEMU without the USB devices (e.g. when using
>>> "--without-default-devices" as option for the "configure" script).
>>> To be still able to run the loongson3-virt machine in default mode with
>>> such a QEMU binary, we have to check here for the availability of the
>>> USB devices first before instantiating them.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   v2: Use #ifdef instead of runtime check
>>>
>>>   hw/mips/loongson3_virt.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
>>> index 216812f660..3094413eea 100644
>>> --- a/hw/mips/loongson3_virt.c
>>> +++ b/hw/mips/loongson3_virt.c
>>> @@ -51,6 +51,7 @@
>>>   #include "sysemu/reset.h"
>>>   #include "sysemu/runstate.h"
>>>   #include "qemu/error-report.h"
>>> +#include CONFIG_DEVICES
>>
>> I'm a but reluctant to include CONFIG_DEVICES.
>>
>>> +#ifdef CONFIG_USB_OHCI_PCI
>>>       if (defaults_enabled()) {
>>
>> What about:
>>
>>    if (defaults_enabled() && object_class_by_name(TYPE_PCI_OHCI)) {
> 
> I think it was a v1 like this :)

Yes, that's how I did it in v1:

  https://lore.kernel.org/qemu-devel/20230525064731.1854107-1-thuth@redhat.com/

  Thomas


