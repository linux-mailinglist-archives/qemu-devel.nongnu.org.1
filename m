Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B4470F297
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:23:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1khC-0001RE-M1; Wed, 24 May 2023 05:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1khA-0001Qj-EF
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:22:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1kh8-0003kG-U3
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684920130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2k84SUV0s+m+tq128j2/TPhmTT8TB8HkIYVKtJnbpR4=;
 b=iLSeUaP6VKpAy5yAVeQ5WkagRyIochCcOZFk6zpMYozN+q+gTU51yRJkQkygCNwp0vcjht
 tyNgfIanaWNyO4KHILI1Imn/oazpidT0M2wiDh1HFZOI+g1MpSygS2CzHQ5tEp+yPEBriw
 bpKr3kSMU6PtOTCPV5NnOWj/T11ZCjE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-gI0cqSCTMpizxQ_2S9TzsQ-1; Wed, 24 May 2023 05:22:08 -0400
X-MC-Unique: gI0cqSCTMpizxQ_2S9TzsQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3093e600770so364991f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684920127; x=1687512127;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2k84SUV0s+m+tq128j2/TPhmTT8TB8HkIYVKtJnbpR4=;
 b=YsO1SIxAdcF/Qh8ZO27TfGtkMQM53byRolBP4pl9/7cWTOd9defK877wDR00diZ+t9
 zx1IyWIgRhWxHkRsDoGYw+EeepgV/WTvpyDM3+8QhLelTbGv/4rPQ7p1iK7OrRNcEMyA
 juJ6KyiQrADQ7VXc8UvPkY2LMllw5Ajub4T4E6n5byoIXiqeF8sMrYe8SwsMPmlaldB7
 sRPDQlCQZ9drSoghtr7GeA/IcTbF9yfDVje5W8voBi8McxmZwBtq/FmB+WqFHVyWG/6N
 GHSE8YFrQDDoo+aFT/h7+1AqnDzobte9hJAP1wf551QFwkP2sPlpI2T7qL8+kJANNGFG
 UnIg==
X-Gm-Message-State: AC+VfDyFvIZq6RbItZ9rhBgXJxQFzKuRis0G9OSHYVqqpBol0g8bow6s
 7qFgE0/i1vn1LUA52cFnmqlcim/rGuGJV4OFAIbrAc8exJYaKHF2ZTbsAlEaNAk1vFDmBEy+f8W
 dR4RxM5vRKTle4J0=
X-Received: by 2002:a5d:68cd:0:b0:309:5188:5928 with SMTP id
 p13-20020a5d68cd000000b0030951885928mr12382621wrw.35.1684920127266; 
 Wed, 24 May 2023 02:22:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6G+kl8je9bjPRELErhfUw0d2upQ8Y9GXrpLOTE+WfY/NqvQNZGmyN71DFZk0dQQOoT2DYEIQ==
X-Received: by 2002:a5d:68cd:0:b0:309:5188:5928 with SMTP id
 p13-20020a5d68cd000000b0030951885928mr12382607wrw.35.1684920126937; 
 Wed, 24 May 2023 02:22:06 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-64.web.vodafone.de.
 [109.43.176.64]) by smtp.gmail.com with ESMTPSA id
 t1-20020a5d6a41000000b003063176ef09sm14035255wrw.6.2023.05.24.02.22.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 02:22:06 -0700 (PDT)
Message-ID: <6dfa9cdb-2efb-8991-e810-f08b4a215321@redhat.com>
Date: Wed, 24 May 2023 11:22:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: 20230524082037.1620952-1-thuth@redhat.com, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <e682f6d5-acbe-7910-54ef-4d75c88a3d28@redhat.com>
 <20230524083913.696175-1-marcin.juszkiewicz@linaro.org>
 <20230524083913.696175-3-marcin.juszkiewicz@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 3/3] hw/arm/sbsa-ref: use MachineClass->default_display
In-Reply-To: <20230524083913.696175-3-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 24/05/2023 10.39, Marcin Juszkiewicz wrote:
> Mark the default graphica via the new MachineClass->default_display
> setting so that the machine-defaults code in vl.c can decide whether the
> default graphics is usable or not (for example when compiling with the
> "--without-default-devices" configure switch).
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   hw/arm/sbsa-ref.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 9a3d77d6b6..30ce7f7db4 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -649,7 +649,7 @@ static void create_pcie(SBSAMachineState *sms)
>           }
>   
>           if (vga_interface_type != VGA_NONE) {
> -            pci_create_simple(pci->bus, -1, "bochs-display");
> +            pci_create_simple(pci->bus, -1, mc->default_display);

Based-on: <20230524082037.1620952-1-thuth@redhat.com>
(otherwise you don't have the "mc" variable available here)

>           }
>       }
>   
> @@ -865,6 +865,7 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
>       mc->default_ram_size = 1 * GiB;
>       mc->default_ram_id = "sbsa-ref.ram";
>       mc->default_cpus = 4;
> +    mc->default_display = "bochs-display";

I guess this might not work as expected yet...

The code in vl.c looks through the vga_interfaces[] array and warns if it 
cannot find the default_display there... and since there is no entry for the 
bochs-display in that array, you likely now always get this warning message, 
even if it is available?

So I think you either have to drop this patch, or you've got to add an entry 
for the bochs-display to vga_interfaces[], too.

  Thomas


