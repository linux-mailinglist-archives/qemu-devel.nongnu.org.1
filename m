Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF96E7FBEA2
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 16:53:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r80OC-000720-BE; Tue, 28 Nov 2023 10:52:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r80OA-00071Y-Dr
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 10:52:42 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r80O7-00083O-8n
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 10:52:40 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6ce2eaf7c2bso3430677a34.0
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 07:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701186758; x=1701791558; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HcckzcY4tdsf2d2h4+wwOaQIuyaZz73wwAPwe9+zbAc=;
 b=QXNQqjJEt5tQZtxhm1Y5XNGFylzkeRNK9FZtesJGmi2d2X0l72ViRtXxaxRiJrtSzo
 D/YTCTMFuAM0Q22bFip3fSC4IZ3VqIuZQmuzjxOjMRwUTI/pMMc2BS8Y+VW3ZrNej2Ha
 +lKMRvOHguI58i7a6NE64LHLAhOMD1lK5M/Yr2Ttey3uSuZBOCRvpS6h3P/gsxiYYxfF
 BEeQhdp31tzS26fTuEnkkyV2u+IDp53g2gifsVDLhXnTV2g0NRr9YG8sW3BgQ9acliRE
 DtLWzQuA1CGY3AOzaLoOf/kQhQLp/imznHsGZsxbTwJUTDpviFEO9GiK4QIefkVMPe8g
 lLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701186758; x=1701791558;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HcckzcY4tdsf2d2h4+wwOaQIuyaZz73wwAPwe9+zbAc=;
 b=fxG340VxEN+mkC0bOBZH5irhSC0abQvefF8IA8z0Y33TsEItTUjQb7zhsUrfYqi72o
 T6dWGCN4YxgwPBeTrnwCRJn/6PsqP9vptrbIYbL7OXN2dk58AJe+UQ4j6qNTlwTc8bOg
 fxCI9fMrQ2a80dO8/D87mDq+DNaRZgAQL/nxAhxt/MPdmxGOEsymOSRw5gKgrU83tFUV
 O82RZYOFvwKgNGzn4cKvqHcPZea0YBSBrImgCgNbhuqN35wz+6KXyPrFpA2w8xACTIH7
 LQ26TPXr0CEiy5Cq8N2PWiWWr8Shr2tf6uoJkwH2ooEdFDl69geW6zIyuaaY2An0PLS7
 kwwQ==
X-Gm-Message-State: AOJu0YwjWpMkz6AKe3VKd7PVd85MwLbvQkGiFRC+fmE1XGP96DL3WbE5
 iKWhjm3FugfbhIVcR9H1fIej1Q==
X-Google-Smtp-Source: AGHT+IGmY1MRwcvYYuCiMPoYGDKvDcybGCFph+5AxiONsBagth51pZB1afVWusK3o6dicBPIvy1evw==
X-Received: by 2002:a9d:7303:0:b0:6d7:f540:45eb with SMTP id
 e3-20020a9d7303000000b006d7f54045ebmr16902894otk.6.1701186757947; 
 Tue, 28 Nov 2023 07:52:37 -0800 (PST)
Received: from [172.20.7.39] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 q10-20020a056830440a00b006c4f7ced5d2sm1674015otv.70.2023.11.28.07.52.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 07:52:37 -0800 (PST)
Message-ID: <5717e259-7d0f-42bf-8d5a-43120bdb0284@linaro.org>
Date: Tue, 28 Nov 2023 09:52:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu/timer: Don't use RDTSC on i486
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, Petr Cvek <petrcvekcz@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "S. Tsirkin, Michael" <mst@redhat.com>
References: <6826113a-d428-401e-b5a3-56ad5d8fbaa4@gmail.com>
 <CABgObfabW_WKdfGFgao0BJ0wHYHRx6KzMsLzvqUvzu3ZMx5Bdw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CABgObfabW_WKdfGFgao0BJ0wHYHRx6KzMsLzvqUvzu3ZMx5Bdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/26/23 09:56, Paolo Bonzini wrote:
> 
> 
> Il sab 25 nov 2023, 13:23 Petr Cvek <petrcvekcz@gmail.com <mailto:petrcvekcz@gmail.com>> 
> ha scritto:
> 
>     GCC defines __i386__ for i386 and i486, which both lack RDTSC instruction.
>     The i386 seems to be impossible to distinguish, but i486 can be identified
>     by checking for undefined __i486__.
> 
> 
> As far as I know QEMU cannot be run on i486 anyway since TCG assumes the presence of 
> CPUID. Have you actually tried?

TCG does not assume CPUID.

We might have problems without cmpxchg8b, but if so that's in accel/tcg/ not tcg/.


r~

