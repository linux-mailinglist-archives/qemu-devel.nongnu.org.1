Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C297D0425
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:45:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaoy-0000tC-Of; Thu, 19 Oct 2023 17:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaow-0000oF-Bz
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:44:46 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaou-0001Ka-PT
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:44:46 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4084095722aso1132335e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697751883; x=1698356683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uDZAS0Mx20iO1KmgE/pzeGzzDgVoxyPcDP2bBIkHh4g=;
 b=XzGU26h8kU/CUF++mS6PySMZhGa0u0Q9V1BhsF37Kln9qK1RZmp5HE9fbRXWBugPUa
 j/eumQf1dN9ftlN/c9QRrJiH9FHCT2CVhi6dUBcm1s12FXjVCdxOzwETZZ5KhU1Pixq4
 6kQWo7xV5lMiysrhaysvTmL5gn3GtGyTqdOcPW7yaDsOcyz0jSnvOQpvVxVqMguToS1h
 8ehLeJpZSdg0BwrhtTA+PDluotVWErtNhQIchyZTNiiSOVNJh7rdwfZdLGSsr5ueoiLJ
 pfzcyIpPXHMhMocZYeDR//JwuzD9ThJ5GluBpf/8USv+0QtwGEeTIUaq3fB05hFzhOB5
 j6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697751883; x=1698356683;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uDZAS0Mx20iO1KmgE/pzeGzzDgVoxyPcDP2bBIkHh4g=;
 b=IFptQo4gpLPkoYearQfaHATy3vRRrcrfcZUWFQkdzDxeehdZ3ZIXn16z7kPF4NT2J+
 XQK8Kjt1uySXumjeaTpaWa/OMohCwWjoJyeLTAkJj+R7Y2AwQwohLRUUKBkvcBIgXHMJ
 UKu6nh0KcYwU4axsW9fCPQEN3y02eCDxPGHdIALO5OGyrCUyUHXY/Q++CnvSw0ENkU/G
 5iczQt0a+KPUCPPzDstiCslvOwNSDMLaMr3bozNP6yfs9WwdvAg349UoWh51lMu1FPCO
 HZv2Gizch2i3kNMToeO13eN1kxm1U56rfvVz/AfQ9/EVZ/avBRqjukY5s/uJhVSSDzri
 an2Q==
X-Gm-Message-State: AOJu0Ywmw/Lq7q3DpgjTmKephTG8iR4gXUrFDCnhb30Un+lvpq+/FV++
 bWQrx864kMRCcPd7+Kh8ZGpxzg==
X-Google-Smtp-Source: AGHT+IFapKEUShtym3zv4S7MVLAqVwKm2GuhVDvQsbvLGc3f+exKcuXN8oCnsfVIVWwNxmmDbyzKMw==
X-Received: by 2002:a05:600c:3502:b0:3fe:2bb1:11ba with SMTP id
 h2-20020a05600c350200b003fe2bb111bamr65787wmq.27.1697751883254; 
 Thu, 19 Oct 2023 14:44:43 -0700 (PDT)
Received: from [192.168.69.115] (176-131-216-177.abo.bbox.fr.
 [176.131.216.177]) by smtp.gmail.com with ESMTPSA id
 m29-20020a05600c3b1d00b003fe61c33df5sm5452984wms.3.2023.10.19.14.44.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 14:44:42 -0700 (PDT)
Message-ID: <5fd6c6c2-5245-c73c-6683-5136751dbde5@linaro.org>
Date: Thu, 19 Oct 2023 23:44:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2] hw/audio/pcspk: Inline pcspk_init()
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20231019073307.99608-1-philmd@linaro.org>
 <C044C8A9-952A-4F9A-8B9F-DE689A5FEF46@gmail.com>
 <87ttqmcxc3.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <87ttqmcxc3.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 19/10/23 19:54, Markus Armbruster wrote:
> Bernhard Beschow <shentey@gmail.com> writes:
> 
>> Am 19. Oktober 2023 07:33:07 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>>> pcspk_init() is a legacy init function, inline and remove it.
>>>
>>> Since the device is realized using &error_fatal, use the same
>>> error for setting the "pit" link.
>>>
>>> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> [...]
> 
>>> diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
>>> index 63e0857208..79ffbb52a0 100644
>>> --- a/hw/isa/i82378.c
>>> +++ b/hw/isa/i82378.c
>>> @@ -67,6 +67,7 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
>>>      uint8_t *pci_conf;
>>>      ISABus *isabus;
>>>      ISADevice *pit;
>>> +    ISADevice *pcspk;
>>>
>>>      pci_conf = pci->config;
>>>      pci_set_word(pci_conf + PCI_COMMAND,
>>> @@ -102,7 +103,9 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
>>>      pit = i8254_pit_init(isabus, 0x40, 0, NULL);
>>>
>>>      /* speaker */
>>> -    pcspk_init(isa_new(TYPE_PC_SPEAKER), isabus, pit);
>>> +    pcspk = isa_new(TYPE_PC_SPEAKER);
>>> +    object_property_set_link(OBJECT(pcspk), "pit", OBJECT(pit), &error_fatal);
>>> +    isa_realize_and_unref(pcspk, isabus, &error_fatal);
>>
>> Why not pass errp here? I think that was Mark's comment in v1.

That would more than "inlining". Can be updated on top, but so far
this function is not error proof, so I'm not really worried.

> &error_fatal is almost always wrong in a function that takes Error **.
> Happy to explain in more detail if needed.
> 
> [...]
> 


