Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A98EF7A9206
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:26:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjE3p-0000vn-8R; Thu, 21 Sep 2023 03:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjE3m-0000vP-Qz
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:25:14 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjE3k-0003vw-0e
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:25:14 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3addaf54b5dso440418b6e.1
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 00:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695281109; x=1695885909;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/74XBA4XDm+i+o0t1C5ivQvEuNkPqqhN1c6kqQJV2tU=;
 b=v+cFrP/mczVYmxcoKhfrQMI08Y/q3O4MvrMCo03gQFIyRJ3t52e580mKc7ipsMO2dN
 PocFPHRboEyIDUCgOt3cLZ08VAkRvWTJlzvzEbTcABM520Qmg9m2IRREB2YJzdoC3om/
 CWfQCVKY0TdQhSAeRAtzpaoHfnqYWrIq4n17J22LClrii12e8WVi0zvAqV/OeoQgyLhO
 zyiWMY65YeNP6m7scOa3bcQnEF/CUiDqytJrB3UI7CQLFzSdCOXMlxGN3tFxkMu0zwMY
 sfpEm1O8sSjtmGatlE2IeQV3NKGLPQZEyXse/AFaGhXvteF1chlkp4dQ//s5lMc0t14z
 OEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695281109; x=1695885909;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/74XBA4XDm+i+o0t1C5ivQvEuNkPqqhN1c6kqQJV2tU=;
 b=Jnp0z100j3XptDIQIM94wLLdBHaMVpRHP3abwb0yeJqIL0x3NdLV/vZeyFWTll4NJe
 M/Nw+dALBPcjFy+jL8PxwzN0w131tZ+Yi8jCDIMADXDkBfEskc4+Nrtn5GR/Jz9HuzQH
 CA0aXksraiEos+S1IIECzlKgy9Lg+15qgEgyA8sG+EzQus3l03lKyShUPawnn575QfN5
 R7HouBvbmKtJajp+aSVZPRVLnV8wY2E4GcO6qqexiP2ZArwMC2v5rN7M1wtjXC8FAm2S
 CwrVzKbVCjuOMJzKfOH0S7LlSJsBl5TyEUPrSnepZWS1S+IV3G3bl1DIkMbv1ecFG/9J
 xaYQ==
X-Gm-Message-State: AOJu0YyKN3d11xvogddkMlc20NEl+aKH4asIteczBv/HkNdTA2zsHEL0
 6E+iTkocS5wqgzASujgf63WT/A==
X-Google-Smtp-Source: AGHT+IHL3mhTdrZoBqHBqUOhbYs8XRD3azvm/y/EID/gPJe7YlpAjBMZhSwCCYY0msQJJ4bYCKo7dg==
X-Received: by 2002:a05:6808:c2:b0:3a7:55f2:552d with SMTP id
 t2-20020a05680800c200b003a755f2552dmr4524575oic.58.1695281109036; 
 Thu, 21 Sep 2023 00:25:09 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 fe18-20020a056a002f1200b0069102aa1918sm658750pfb.48.2023.09.21.00.25.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 00:25:08 -0700 (PDT)
Message-ID: <a5cd5a46-7f33-42b6-99eb-b09159af42d7@daynix.com>
Date: Thu, 21 Sep 2023 16:25:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/kvm/kvm-all: Handle register access errors
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20221201102728.69751-1-akihiko.odaki@daynix.com>
 <CAFEAcA_ORM9CpDCvPMs1XcZVhh_4fKE2wnaS_tp1s4DzZCHsXQ@mail.gmail.com>
 <a3cc1116-272d-a8e5-a131-7becf98115e0@daynix.com>
 <ed62645a-ec48-14ff-4b7e-15314a0da30e@daynix.com>
 <CAFEAcA-pOKf1r+1BzURpv5FnFS79D2V=SSeY_a2Wene1wf+P1A@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA-pOKf1r+1BzURpv5FnFS79D2V=SSeY_a2Wene1wf+P1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/06/19 21:19, Peter Maydell wrote:
> On Sat, 10 Jun 2023 at 04:51, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2022/12/01 20:00, Akihiko Odaki wrote:
>>> On 2022/12/01 19:40, Peter Maydell wrote:
>>>> On Thu, 1 Dec 2022 at 10:27, Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> wrote:
>>>>>
>>>>> A register access error typically means something seriously wrong
>>>>> happened so that anything bad can happen after that and recovery is
>>>>> impossible.
>>>>> Even failing one register access is catastorophic as
>>>>> architecture-specific code are not written so that it torelates such
>>>>> failures.
>>>>>
>>>>> Make sure the VM stop and nothing worse happens if such an error occurs.
>>>>>
>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>
>>>> In a similar vein there was also
>>>> https://lore.kernel.org/all/20220617144857.34189-1-peterx@redhat.com/
>>>> back in June, which on the one hand was less comprehensive but on
>>>> the other does the plumbing to pass the error upwards rather than
>>>> reporting it immediately at point of failure.
>>>>
>>>> I'm in principle in favour but suspect we'll run into some corner
>>>> cases where we were happily ignoring not-very-important failures
>>>> (eg if you're running Linux as the host OS on a Mac M1 and your
>>>> host kernel doesn't have this fix:
>>>> https://lore.kernel.org/all/YnHz6Cw5ONR2e+KA@google.com/T/
>>>> then QEMU will go from "works by sheer luck" to "consistently
>>>> hits this error check"). So we should aim to land this extra
>>>> error checking early in the release cycle so we have plenty of
>>>> time to deal with any bug reports we get about it.
> 
>>> Actually I found this problem when I tried to run QEMU with KVM on M2
>>> MacBook Air and encountered a failure described and fixed at:
>>> https://lore.kernel.org/all/20221201104914.28944-2-akihiko.odaki@daynix.com/
>>>
>>> Although the affected register was not really important, QEMU couldn't
>>> run the guest well enough because kvm_arch_put_registers for ARM64 is
>>> written in a way that it fails early. I guess the situation is not so
>>> different for other architectures as well.
>>>
>>> I still agree that this should be postponed until a new release cycle
>>> starts as register saving/restoring is too important to fail.
> 
>> Hi,
>>
>> QEMU 8.0 is already released so I think it's time to revisit this.
> 
> Two months ago would have been a better time :-) We're heading up
> towards softfreeze for 8.1 in about three weeks from now.
> 
> thanks
> -- PMM

Hi Peter,

Please apply this.

Regards,
Akihiko Odaki

