Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDAA7F983E
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 05:22:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7T8N-0001Fz-CX; Sun, 26 Nov 2023 23:22:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7T8L-0001FN-Ln
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:22:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7T8K-0007Bs-CH
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701058927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/nhwhp1t2bW5Fo7bLOGwpFSKPeOVuScueoe5eRS0QQw=;
 b=hSmXNFgKzNTKWu+ySKTjOfgvZ9sRGx88w/QyCoWZ8v8vwUJ7BiiqBXSwCLgNJ1x9YtSWdV
 H5jYhXZB6DmGn/ABuCoiSjzyj7sekQ5Mr6ZqbALO9NJk90NiJr6MfAYzD1Sh3FZGaB1MV6
 /igEV6DNGZVwSuGv7/JrKC6GtSCoSHw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-A9PeQQscNNmBg_E4RCExkQ-1; Sun, 26 Nov 2023 23:22:06 -0500
X-MC-Unique: A9PeQQscNNmBg_E4RCExkQ-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1cfd4aea4dbso3668885ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 20:22:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701058924; x=1701663724;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/nhwhp1t2bW5Fo7bLOGwpFSKPeOVuScueoe5eRS0QQw=;
 b=THcW/RQT8Tyf9LTZ5CLuLeRj2G1CncX3XrnOnuAcxS/OwhHcD2LbxqImvgGNep5h/T
 VfdR5crOI9IeQAFQ9KqyYTPYrBLegEYr5l0svJoW0e4IKJhvZl8w6iUkeYCveJOPTudE
 V14PNi09+aMfwV8Fm1DEUq3DR12jGAr5wLwfdWzkRnPHL7Fiz8xGewnLhaasIVcXpX9K
 +g8P+JORqETxSRr49FIEFUl2cKlgxNNe3CQLEW4C1lyjYFCpgnjGL6/0zFmK9/VFOGt/
 fY5eHk9COlo3QMYXouuyqANl1K7vA59EOz8g1+MSACOLYOhh+evsNqHaheqOXhSLs/5p
 abDg==
X-Gm-Message-State: AOJu0YxctnOLF4sHL0u8y7XzChGsJBFVZwUhalDmPjeXpQeJttbgxWaM
 uYghXhiO9eK904ZXClthsPfbeKDcDTL/P/DVC26LNyTlwM/7AmjIWeoOd6DM7b0tSCmAovIVcGC
 vUCZDkMe7ZrBWG1DPrGFaRZg=
X-Received: by 2002:a17:902:9898:b0:1cf:cf43:303a with SMTP id
 s24-20020a170902989800b001cfcf43303amr1786950plp.64.1701058924755; 
 Sun, 26 Nov 2023 20:22:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGahJzPVW6qpzOig4IomRFqNt413I5D7KdVsB5RNKfQL4bunCVAFvR+or0fMFWGg+/2zvnFtQ==
X-Received: by 2002:a17:902:9898:b0:1cf:cf43:303a with SMTP id
 s24-20020a170902989800b001cfcf43303amr1786940plp.64.1701058924515; 
 Sun, 26 Nov 2023 20:22:04 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 q8-20020a17090311c800b001cf57ea953csm7140277plh.290.2023.11.26.20.22.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 20:22:04 -0800 (PST)
Message-ID: <6d1cdfc7-803f-438f-b210-1eddb34aeba7@redhat.com>
Date: Mon, 27 Nov 2023 15:21:59 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 09/16] target/arm/kvm: Have kvm_arm_pmu_set_irq
 take a ARMCPU argument
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231123183518.64569-1-philmd@linaro.org>
 <20231123183518.64569-10-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123183518.64569-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 11/24/23 05:35, Philippe Mathieu-Daudé wrote:
> Unify the "kvm_arm.h" API: All functions related to ARM vCPUs
> take a ARMCPU* argument. Use the CPU() QOM cast macro When
> calling the generic vCPU API from "sysemu/kvm.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/kvm_arm.h | 4 ++--
>   hw/arm/virt.c        | 2 +-
>   target/arm/kvm.c     | 6 +++---
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


