Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B058478E7D0
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 10:23:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbcxG-0000p6-1o; Thu, 31 Aug 2023 04:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbcxE-0000oy-Mb
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:23:04 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbcxC-00083r-4R
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:23:04 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40037db2fe7so5235915e9.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 01:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693470180; x=1694074980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9BrJs30t+O2+fu2OuyJAjeseUQnrZkFYeCUhMRXXbII=;
 b=QVfAG5FpWBQk1WoGIaa+Axq3JtNccgOXCeVRaYGP6aa4Vmc57vtACVzA8MPDQiObjX
 NJrLbsXof26L/6xETbNJguqKxTOIuqNXYCzwvKZF4gkkIDnZUvzLpfTRopI/BAd8FGMo
 +Qk5nL1TUt9dz9oyXDeQEfR0uxf7hZEp8GLBIlSNfFyY3v5Sxats+KLgEYRDrSBkVXrY
 4giYj2+6g39Xkjln48RDZV/keEPghKO+0TYBsuk6KxMWOqH/fcOL5hJWYZRNaVdcZUEc
 5XKgJqZrSEG2CM44trGXQAsyOlCC+UVzwN6Dhv7tooD3s97Ky80lrDTlUmtoW+5ekMOw
 8jqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693470180; x=1694074980;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9BrJs30t+O2+fu2OuyJAjeseUQnrZkFYeCUhMRXXbII=;
 b=Aw8JGtCUIRfppNmBDuwOcWBpAwH8cAzg2WlMOSS6zJcTdtaH3/c4gPbD71v0WC13qD
 Kdnb/y3bXTjCAMGQgfQt0CfukRXSDwrXbWYBPB2ErM0ISlOnkmBoAxkHWY6d0isGi4Zo
 nRDisa7ZJHK1OOGux7aINFkW3B2nlDgvaeSoHGdJHoMRTUQcPfcpM4N4Pn9VJGnfycxV
 EAHOCxMYDHKKfIB5Yq0r7a3GxUc1ygCrnbyxeLryVHZ+3SIhnyct9Tonupf4x+59sppV
 YYchF3/yQZKIXYZeQlC8FpUN5noz7iSUeAeCaAsQgDlvRkDEDHIRk0WgnjJ2cByFlvN1
 c1ng==
X-Gm-Message-State: AOJu0YzI+ptK9qDR0cSdUP2Pn3gIsKxmm+LciFlqZraVNIFgY8AJWCNw
 qPngryCyIA44wDma7yhq1JatxDOKGOuMq28PSkn/GzQh
X-Google-Smtp-Source: AGHT+IH2S8rY5o0O5DWpfDsxwW57Wtt7KZ7ONSKHMU6fx+O9KngmUX83/StQAKsJH7BaZUenugGVMA==
X-Received: by 2002:a1c:4c16:0:b0:401:cf0d:25cd with SMTP id
 z22-20020a1c4c16000000b00401cf0d25cdmr4082601wmf.22.1693470179981; 
 Thu, 31 Aug 2023 01:22:59 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a7bce8d000000b003fe4548188bsm4379478wmj.48.2023.08.31.01.22.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 01:22:59 -0700 (PDT)
Message-ID: <6fe71919-db29-3be4-c196-da2c6daa1149@linaro.org>
Date: Thu, 31 Aug 2023 10:22:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] hw/usb/hcd-xhci-pci: Fail if user requested MSIX but it
 can't be used
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20230719141733.35818-1-philmd@linaro.org>
 <e2bfcdb3-c057-7da5-8047-f6d7e1875c13@linaro.org>
In-Reply-To: <e2bfcdb3-c057-7da5-8047-f6d7e1875c13@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

kind ping?

On 25/8/23 10:02, Philippe Mathieu-Daudé wrote:
> Ping?
> 
> On 19/7/23 16:17, Philippe Mathieu-Daudé wrote:
>> Do not silently ignore the user request of using MSIX.
>> Remove the TODO. Coverity reported this as CID 1508725.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/usb/hcd-xhci-pci.c | 21 ++++++++++++++++-----
>>   1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
>> index 643d4643e4..416656b78c 100644
>> --- a/hw/usb/hcd-xhci-pci.c
>> +++ b/hw/usb/hcd-xhci-pci.c
>> @@ -155,11 +155,22 @@ static void usb_xhci_pci_realize(struct 
>> PCIDevice *dev, Error **errp)
>>       }
>>       if (s->msix != ON_OFF_AUTO_OFF) {
>> -        /* TODO check for errors, and should fail when msix=on */
>> -        msix_init(dev, s->xhci.numintrs,
>> -                  &s->xhci.mem, 0, OFF_MSIX_TABLE,
>> -                  &s->xhci.mem, 0, OFF_MSIX_PBA,
>> -                  0x90, NULL);
>> +        ret = msix_init(dev, s->xhci.numintrs,
>> +                        &s->xhci.mem, 0, OFF_MSIX_TABLE,
>> +                        &s->xhci.mem, 0, OFF_MSIX_PBA,
>> +                        0x90, &err);
>> +        if (ret < 0) {
>> +            if (s->msi == ON_OFF_AUTO_ON) {
>> +                /* Can't satisfy user's explicit msi=on request, fail */
>> +                error_append_hint(&err, "You might have to use msi=auto"
>> +                                        " (default) or msi=off with 
>> this"
>> +                                        " machine type.\n");
>> +                error_propagate(errp, err);
>> +                return;
>> +            }
>> +            /* report that msix is not supported, but do not error 
>> out */
>> +            warn_report_err(err);
>> +        }
>>       }
>>       s->xhci.as = pci_get_address_space(dev);
>>   }
> 


