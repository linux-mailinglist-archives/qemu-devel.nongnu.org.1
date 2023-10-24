Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8127D51FC
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 15:39:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvHbJ-0004Xo-6g; Tue, 24 Oct 2023 09:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvHbG-0004XJ-An; Tue, 24 Oct 2023 09:37:38 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvHbE-0006U8-N0; Tue, 24 Oct 2023 09:37:38 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4083ac51d8aso35779805e9.2; 
 Tue, 24 Oct 2023 06:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698154655; x=1698759455; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=j9rxO3yi9gLObbLJi9rghTRfPCV/QR8/fM1S9i4WEuI=;
 b=QZYhwkrUnfSxoTXTELk1PD8nttKGkGEPXl1Hm+UuOKOu7dt6JDimcVmmEggWMcEcTA
 bk5AD695Iru8CaBP7HYKnAGLITSqK5zQ2Q+tYjohhzneBySzilJhmpsJTYzCF4u5S3z/
 kW9NyqC8H+EstA342Gw+HxSaq/G6ojiONfLXXjPHiqq1+Ka9h9Q/BDe4Y3faI0RQ8dvY
 vsTNuz9R7zXUg7h07tC1183lIp74YGQ0WeN0Qm8TW/yKPLyx1rOppTWkWupTGpSKFLJ4
 xoj3s0DDnHNb/ds1ie8pNbqApYzMgn2vKdMhLuzeUrn+0DLyN7VpYIfSA31ASOpOSBYc
 ps0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698154655; x=1698759455;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j9rxO3yi9gLObbLJi9rghTRfPCV/QR8/fM1S9i4WEuI=;
 b=BD8nlM8xET1xWqjjKwp1hL761/mIXXlgj/8Jbodq/ZfA3g4GhwrQR8wrQb8favW89B
 gI/aCkq/tPiYw8MqxlfFHU+G4Vo3N1qJ7jaFYMVt+QZVCs40w/wFElcv8ckQWcGQxGHj
 jCYoeGEmqR/Cdb/4IMK3sZe1ncHFq7mIuwD3kWkSOMgkojIaKhRudU6I/73iSQ618eHE
 v7xvydiGD5fzlYlfdlBURX4nw/dGl9deihawpbo66kWs82CPn+OP/MNiVrqmYYGX5aMK
 aNnyKfVCG6teB3qgdie2JXBn3GabiQ6USCrRSeX5jnwq1rOfCr4gOKtbAHVavAAv5jYO
 Anfg==
X-Gm-Message-State: AOJu0YzP/lkyvkGFqpUz6mhlo9g8kAmVkp8F6P2XRXxshsAKDfuF8y+7
 retz9Q/9aPlBEdlsLRjanYg=
X-Google-Smtp-Source: AGHT+IFCwR5Zipko4S5zjbV/abnJStyPGZ1/DwAYuPk2b3wwXjk/TEZ1ExZWj50RRXVedONgMthJkw==
X-Received: by 2002:a05:600c:4588:b0:409:7d0:d20b with SMTP id
 r8-20020a05600c458800b0040907d0d20bmr3231221wmo.24.1698154654600; 
 Tue, 24 Oct 2023 06:37:34 -0700 (PDT)
Received: from [192.168.6.66] (54-240-197-238.amazon.com. [54.240.197.238])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c028100b004077219aed5sm16673519wmk.6.2023.10.24.06.37.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 06:37:34 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <ea38b980-14dd-4442-96d4-699ee39a0d27@xen.org>
Date: Tue, 24 Oct 2023 14:37:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] hw/xen: add get_frontend_path() method to
 XenDeviceClass
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org
References: <20231016151909.22133-1-dwmw2@infradead.org>
 <20231016151909.22133-7-dwmw2@infradead.org>
 <5ef43a7c-e535-496d-8a14-bccbadab3bc0@xen.org>
 <d43b900a6c7987c6832ceeede9b4c5ab65d5bacd.camel@infradead.org>
 <55bb6967-9499-45ef-b4c8-00fbfaccef0d@xen.org>
 <4d059cb96a92004fe25fdb140a6c0b12e91b4d7e.camel@infradead.org>
Organization: Xen Project
In-Reply-To: <4d059cb96a92004fe25fdb140a6c0b12e91b4d7e.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 24/10/2023 14:29, David Woodhouse wrote:
> On Tue, 2023-10-24 at 13:59 +0100, Paul Durrant wrote:
>> On 24/10/2023 13:56, David Woodhouse wrote:
>>> On Tue, 2023-10-24 at 13:42 +0100, Paul Durrant wrote:
>>>>
>>>>> --- a/hw/xen/xen-bus.c
>>>>> +++ b/hw/xen/xen-bus.c
>>>>> @@ -711,8 +711,16 @@ static void xen_device_frontend_create(XenDevice *xendev, Error **errp)
>>>>>      {
>>>>>          ERRP_GUARD();
>>>>>          XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
>>>>> +    XenDeviceClass *xendev_class = XEN_DEVICE_GET_CLASS(xendev);
>>>>>      
>>>>> -    xendev->frontend_path = xen_device_get_frontend_path(xendev);
>>>>> +    if (xendev_class->get_frontend_path) {
>>>>> +        xendev->frontend_path = xendev_class->get_frontend_path(xendev, errp);
>>>>> +        if (!xendev->frontend_path) {
>>>>> +            return;
>>>>
>>>> I think you need to update errp here to note that you are failing to
>>>> create the frontend.
>>>
>>> If xendev_class->get_frontend_path returned NULL it will have filled in errp.
>>>
>>
>> Ok, but a prepend to say that a lack of path there means we skip
>> frontend creation seems reasonable?
> 
> No, it *is* returning an error. Perhaps I can make it
> 

I understand it is returning an error. I thought the point of the 
cascading error handling was to prepend text at each (meaningful) layer 
such that the eventual message conveyed what failed and also what the 
consequences of that failure were.

   Paul

>      if (!xendev->frontend_path) {
>          /*
>           * If the ->get_frontend_path() method returned NULL, it will
>           * already have set *errp accordingly. Return the error.
>           */
>          return /* false */;
>      }
> 
> 
>>> As a general rule (I'll be doing a bombing run on xen-bus once I get my
>>> patch queue down into single digits) we should never check 'if (*errp)'
>>> to check if a function had an error. It should *also* return a success
>>> or failure indication, and we should cope with errp being NULL.
>>>
>>
>> I'm pretty sure someone told me the exact opposite a few years back.
> 
> Then they were wrong :)


