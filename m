Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3F67F9846
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 05:25:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7TAm-0002Dw-MM; Sun, 26 Nov 2023 23:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7TAl-0002Dj-60
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:24:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7TAj-0007fJ-Sr
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701059076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bzPDIBNHl9MOltvsq0mdaA199GFM+p4KPfAkED3jE+o=;
 b=TvmuOIf8gJnw6MVUszLE88kYPgpYlm//RkBcCmVDrPzqbDBWOd7sozAfmEM/fzsbExiBzI
 wOSjmeuduUT/hsBZaXp3nZykYvQSHHVvK5wVp82V3/3GZ/ELRNEbS54O7ApGcbuR/TUm/Y
 ZP9pmznusoJfXTStFDObJU4mzNB0m94=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-A7MbGaYtNdyLM2sRTYMxbA-1; Sun, 26 Nov 2023 23:24:35 -0500
X-MC-Unique: A7MbGaYtNdyLM2sRTYMxbA-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6d7e70f7e77so4532317a34.3
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 20:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701059074; x=1701663874;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bzPDIBNHl9MOltvsq0mdaA199GFM+p4KPfAkED3jE+o=;
 b=wKa9NUBk5FP/ee15c48jYLcFidvMfG+CBnbGSuTW9OifIAOUo8dgJDA+WjVd9a/ksT
 ymKpf+pdCjkZRnmrmE+79iY0EKy/OKB50NLNEeTyMLa7R8rcEAZhGvXAUTHSnQEvjwcO
 oAvRc145kodzaJiPLesQ4Z891YMY1m/MrrrfGnvPrnSJCnRKWOOPFKp49TRR4X2p0YCh
 tRpgIx4jcinJ2VaAQ93U0jA94D6URliin/YXg0SDcuGn3GMPV2VCi7ChVvNF4QY7c4aP
 dJcaFhY/sW0B9WdlSUQ5JaXIGyBB8ahDwD3MQsjJ8NhlVxThFajfS/PSxt1R4ltVT5Az
 LuRQ==
X-Gm-Message-State: AOJu0Yyv6XPpDZb4T/aY49baV0uxOUtHBmW52c4Zx9lAgk4c5aDQ07zJ
 SBQJVyMTWL0VuJWlEojy1WMZLkM7m0p78/4n6e92kwXm8sRAJcalyDmSLacuzMDldP8teZRmOE4
 VU363dzzu8sjva+U=
X-Received: by 2002:a05:6871:e70f:b0:1fa:132a:9b00 with SMTP id
 qa15-20020a056871e70f00b001fa132a9b00mr11727292oac.1.1701059074748; 
 Sun, 26 Nov 2023 20:24:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1jEgPKjcgQaFtUugtd8wSBFNs+kOlf89lz1lRtIYb6mzdgQLzxpVzHLYxv9Y3NsA0Zy/pCw==
X-Received: by 2002:a05:6871:e70f:b0:1fa:132a:9b00 with SMTP id
 qa15-20020a056871e70f00b001fa132a9b00mr11727285oac.1.1701059074542; 
 Sun, 26 Nov 2023 20:24:34 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 m22-20020aa78a16000000b00692cb1224casm6337813pfa.183.2023.11.26.20.24.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 20:24:34 -0800 (PST)
Message-ID: <903f8425-3c49-4f21-80e9-24f208045c96@redhat.com>
Date: Mon, 27 Nov 2023 15:24:29 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 10/16] target/arm/kvm: Have kvm_arm_vcpu_init take
 a ARMCPU argument
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231123183518.64569-1-philmd@linaro.org>
 <20231123183518.64569-11-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123183518.64569-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


On 11/24/23 05:35, Philippe Mathieu-Daudé wrote:
> Unify the "kvm_arm.h" API: All functions related to ARM vCPUs
> take a ARMCPU* argument. Use the CPU() QOM cast macro When
> calling the generic vCPU API from "sysemu/kvm.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/kvm.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
>

Reviewed-by: Gavin Shan <gshan@redhat.com>


