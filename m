Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF9078E7E1
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 10:25:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbcz2-0001iH-A9; Thu, 31 Aug 2023 04:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbcyz-0001i9-ET
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:24:53 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbcyx-0008Hp-36
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:24:53 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2bcfdadd149so11371091fa.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 01:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693470288; x=1694075088; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sLiiee3nXJY6tP4BtwdP4sOzfxbPJrPWoVoCAQ0is/I=;
 b=oSorNAFdtHRXoPY3a6c7yqo4Xz8qAL3Awlqfqa0UjFJhHrqLe5P1A/LyhmY8iKsMad
 UKsqsu5XP43LOFleIHz3bc3LKS3nrhraZ5ombwveC37D1nmj9B798wzyPXg3RBPwvgJT
 KgXvOZJSz/QhpWM3HsSZnsIdZ7K2u3tkufAlbG/L79aAcfIeU472u0o+NIvOH13WZagF
 +30GA/5lnnuBMp9VhssS+Fl88gdkiDM0Vui9pHpDpH1KMuJR7GjKgx2kUKP9wVDoR8mO
 8K38i9WLe03V3IGxBG93KuC+iHcqVTcMW1AeTtEIWKpi9j221CKpnRgol6irowsbxkog
 WZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693470288; x=1694075088;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sLiiee3nXJY6tP4BtwdP4sOzfxbPJrPWoVoCAQ0is/I=;
 b=ZPMZp76mITg+oE1A0Ucx+v8lFIkNP5IlnjPn6dyKKZsB4jeizCzDFQR9ddiaYIBREX
 uqlcl5GzgpzKSGMMvM9aaF0lDEO5x2hOINPZrJ0UpOjK02WLe2Pgmza8AXR0XwBgh61s
 wRns/NWkdyYeK1yh6478a8ojbVYhTDHI8mmxeSab6sI0geYBxVZCQwRnrzmXcTquKeWT
 /h7kq0xj3rnAAr94zB7dOLp0KuNrqpPj2n3w6K8JxZTHQV046k+je5YOKJA27f+a/3fd
 /DGfb4RagvsLi33iPVgqfhS6tSKoSPuuIThZn74X72QRe6S0q3aq7gzFiEcDuiOfNT+r
 SgGA==
X-Gm-Message-State: AOJu0YzUzt6UsnnPPc21urNlmnPvMv6qsAn0ig9+mfeh4wGVDH2o6QW/
 kmnRtjjHpgtJfIgVQFQqqopVJU8CpJLNLvc8sF6DVrHh
X-Google-Smtp-Source: AGHT+IFb1AsWtVXhNRZ1s0cGQM6Q6P5ZTWSEFRGban+RgSk3gFVdHcGuWcyLoUw8MhA7f05JGONr6A==
X-Received: by 2002:a2e:9957:0:b0:2b6:da1e:d063 with SMTP id
 r23-20020a2e9957000000b002b6da1ed063mr3530044ljj.45.1693470288197; 
 Thu, 31 Aug 2023 01:24:48 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 u19-20020a05600c00d300b003fe17901fcdsm4350692wmm.32.2023.08.31.01.24.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 01:24:47 -0700 (PDT)
Message-ID: <844557d5-db5d-48ba-ddec-175bc72be8c0@linaro.org>
Date: Thu, 31 Aug 2023 10:24:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] hw/usb/hcd-xhci-pci: Fail if user requested MSIX but it
 can't be used
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20230719141733.35818-1-philmd@linaro.org>
 <e2bfcdb3-c057-7da5-8047-f6d7e1875c13@linaro.org>
 <6fe71919-db29-3be4-c196-da2c6daa1149@linaro.org>
In-Reply-To: <6fe71919-db29-3be4-c196-da2c6daa1149@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

Cc'ing Markus and Marc-André

On 31/8/23 10:22, Philippe Mathieu-Daudé wrote:
> kind ping?
> 
> On 25/8/23 10:02, Philippe Mathieu-Daudé wrote:
>> Ping?
>>
>> On 19/7/23 16:17, Philippe Mathieu-Daudé wrote:
>>> Do not silently ignore the user request of using MSIX.
>>> Remove the TODO. Coverity reported this as CID 1508725.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   hw/usb/hcd-xhci-pci.c | 21 ++++++++++++++++-----
>>>   1 file changed, 16 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
>>> index 643d4643e4..416656b78c 100644
>>> --- a/hw/usb/hcd-xhci-pci.c
>>> +++ b/hw/usb/hcd-xhci-pci.c
>>> @@ -155,11 +155,22 @@ static void usb_xhci_pci_realize(struct 
>>> PCIDevice *dev, Error **errp)
>>>       }
>>>       if (s->msix != ON_OFF_AUTO_OFF) {
>>> -        /* TODO check for errors, and should fail when msix=on */
>>> -        msix_init(dev, s->xhci.numintrs,
>>> -                  &s->xhci.mem, 0, OFF_MSIX_TABLE,
>>> -                  &s->xhci.mem, 0, OFF_MSIX_PBA,
>>> -                  0x90, NULL);
>>> +        ret = msix_init(dev, s->xhci.numintrs,
>>> +                        &s->xhci.mem, 0, OFF_MSIX_TABLE,
>>> +                        &s->xhci.mem, 0, OFF_MSIX_PBA,
>>> +                        0x90, &err);
>>> +        if (ret < 0) {
>>> +            if (s->msi == ON_OFF_AUTO_ON) {
>>> +                /* Can't satisfy user's explicit msi=on request, 
>>> fail */
>>> +                error_append_hint(&err, "You might have to use 
>>> msi=auto"
>>> +                                        " (default) or msi=off with 
>>> this"
>>> +                                        " machine type.\n");
>>> +                error_propagate(errp, err);
>>> +                return;
>>> +            }
>>> +            /* report that msix is not supported, but do not error 
>>> out */
>>> +            warn_report_err(err);
>>> +        }
>>>       }
>>>       s->xhci.as = pci_get_address_space(dev);
>>>   }
>>
> 


