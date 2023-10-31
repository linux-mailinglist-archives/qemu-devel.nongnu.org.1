Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0227DD76F
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 22:02:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxvra-00052Y-1e; Tue, 31 Oct 2023 17:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxvrW-00052O-FD
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 17:01:22 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxvrT-000394-Kh
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 17:01:22 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a7fb84f6ceso55199967b3.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 14:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698786078; x=1699390878; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5tR/l23z2VbTyoI4whZa72Id5S3ny5uM3IZuWlods7o=;
 b=U5wAa39gdGqNvA2+eQYYVnEPTcAMqPMKG/Jn8lz/QFU25qzANMCtYDOfb2vMQm2+In
 FCc4NfzJvTkc+5zGOqLMd75fMe2VXk3oPQoT1br7vTUzvhaltQCWC+xgJ3wRirUb595P
 4Qm57QaYVJ2NHBRWRr6x4cPwrOuan1WfT8f+UdZoJWwddLDju3atESaPtnPUAIpEimc1
 BPG043IBa0j1Jmr7Okcgetwjr9cx7WcrFAEIogC0+l0Fnr9jHqQbPavaQKYk/5N4hFJz
 d+9aZ4TWtBUokg1073KY4iPXIt2s21TOjdtzHXPzP8XEdY5kS1utsqNC5141g78LhYcs
 Fqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698786078; x=1699390878;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5tR/l23z2VbTyoI4whZa72Id5S3ny5uM3IZuWlods7o=;
 b=UHrGspb5f/B3tmH8iVI4q7SvKY5fbfVw2Q9LJWnJhmF56BjaYiW8OHU52RjMlDN2Eu
 9idTK5u3AgDxsxnTHrtjx5Q5DfusAEbmZbvNMb2FZJuu79o30dRc6p99STP9ttQBL2kr
 M2inYqM4iTuNFMqOCfE3xJhdghQFSPn07u//r1TMNh5h596CaXRfoNxQAqV3m8TdO4Wp
 g8eI6tDDEXLphjPPhy4grLM9AVLTvYd8eE8wGp1lTUUo+M14bXji66EH3/Uyv5TTMOEd
 Ss9CyJzremT1nYJhqCu16KpW7XYPkU3+F0wnKAJ/AJKK/vDgohm6nQfjgTfbEmt5w6i7
 dFAg==
X-Gm-Message-State: AOJu0YwkVUeeoRu0cgAw6hBfA+Wlvf4UKLb/Qy2luWA64r2wGNkIos3R
 8FFNIloIu3SuzSX6+ld2gtEggg==
X-Google-Smtp-Source: AGHT+IGhLYlbCwdhH3WS1Apauy7lW3CFgsSTtaYpEovXbaQYQk3sJEDMofDcJ3lrN3IDFt0TrEwg2Q==
X-Received: by 2002:a81:e34c:0:b0:59b:c805:de60 with SMTP id
 w12-20020a81e34c000000b0059bc805de60mr10313307ywl.45.1698786078499; 
 Tue, 31 Oct 2023 14:01:18 -0700 (PDT)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a819108000000b005a8eadbadbesm1327863ywg.19.2023.10.31.14.01.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 14:01:17 -0700 (PDT)
Message-ID: <af74e0ee-6536-47dd-bac5-b53689e854a5@ventanamicro.com>
Date: Tue, 31 Oct 2023 18:01:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hw/ppc/e500: Declare CPU QOM types using
 DEFINE_TYPES() macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: Luc Michel <luc.michel@amd.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20231030143957.82988-1-philmd@linaro.org>
 <20231030143957.82988-3-philmd@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231030143957.82988-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 10/30/23 11:39, Philippe Mathieu-Daudé wrote:
> When multiple QOM types are registered in the same file,
> it is simpler to use the the DEFINE_TYPES() macro. In
> particular because type array declared with such macro
> are easier to review.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

> I'm going to do that for each file I modify, so eventually
> we'll get all converted.
> ---
>   hw/ppc/ppce500_spin.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
> index bbce63e8a4..e3608d8c16 100644
> --- a/hw/ppc/ppce500_spin.c
> +++ b/hw/ppc/ppce500_spin.c
> @@ -195,17 +195,14 @@ static void ppce500_spin_class_init(ObjectClass *klass, void *data)
>       dc->reset = spin_reset;
>   }
>   
> -static const TypeInfo ppce500_spin_info = {
> -    .name          = TYPE_E500_SPIN,
> -    .parent        = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(SpinState),
> -    .instance_init = ppce500_spin_initfn,
> -    .class_init    = ppce500_spin_class_init,
> +static const TypeInfo ppce500_spin_types[] = {
> +    {
> +        .name           = TYPE_E500_SPIN,
> +        .parent         = TYPE_SYS_BUS_DEVICE,
> +        .instance_size  = sizeof(SpinState),
> +        .instance_init  = ppce500_spin_initfn,
> +        .class_init     = ppce500_spin_class_init,
> +    },
>   };
>   
> -static void ppce500_spin_register_types(void)
> -{
> -    type_register_static(&ppce500_spin_info);
> -}
> -
> -type_init(ppce500_spin_register_types)
> +DEFINE_TYPES(ppce500_spin_types)

