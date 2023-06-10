Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FC372A8EE
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 05:51:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7pdG-0003zv-OB; Fri, 09 Jun 2023 23:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q7pdC-0003zm-As
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 23:51:14 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q7pd8-0008WE-UW
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 23:51:14 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-256531ad335so1307060a91.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 20:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1686369069; x=1688961069;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=keZFtC4q7nGqwkwPIt24fKDWj9qoKt9aTQihY50Kp8I=;
 b=Si9MEC3oTAJhiURwtR8P5gVAaFxtWeTt850pFCJE48TwO99/bFDala+9/5+PbDVLP4
 iCd4T6/vbnRzkSGJdzXESOquK+mfbnbjOA8RMhBRuSw1mqzZEFVJv4VeuflGpkijj6Bi
 45UbVXXFLhUbSB1gsTUnlD1NATbxruaSIyGyilw3INO28GBhXmegHNOrsehGYMF7WNeD
 M2zhJNJ1SmN1NNEBqO6JHQx4zuRiAPPQusGd+6coYUNqndZ9rfSygFqc2X+QcKL28igi
 FD31RcQ/ry5ySNQASN/nSws+Zt+ISzk7AtsdzIlbtIVkS0sDJMu7sFWVGDNFyDbmlf3c
 8jsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686369069; x=1688961069;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=keZFtC4q7nGqwkwPIt24fKDWj9qoKt9aTQihY50Kp8I=;
 b=d9P8gKTFIVMlvVgSPcpyzZpoZ/CguXzhSFPNOOoVcHKRA2Yy1PxnocVdk6gBHb4xla
 9khYBH+L9P7fE8/Ix1o5LcI+KC3U6xePg0fInJ+DT09kZZAry1h+Lxo2QMt+vahaEG9x
 eCymtUVzwyTqVC8rmksNCOH12VmnKqCyyYoroQmSXFbQmzJJ4zPb0e/sTpwYjiggLf0J
 qeqHMErcs3C9hcxcrDDZCyx07D5gG+sbNcrW4wU0uKImT8ohBvanniIyl9BJB6Bm+zFR
 gORg1xkN/qwcaekhozwn/0TbnVYIL41spR3QEpJwBxdJMs2JJTQdiOIb2C/wcazGP3YG
 CDiA==
X-Gm-Message-State: AC+VfDwMChSPlSSS+MIcdVMOLAJLas0G44l7SIzVh3iATO5nUpjr2aKR
 HnVIrSUAkki8CBvO5cZPRiUUHA==
X-Google-Smtp-Source: ACHHUZ7yCMAmE2exlUNJ1g0D+dgZViDTjS54GrGA//Ko8QotzeAqgDXs0V94Z/TLFIcvE2Jcy8wWhQ==
X-Received: by 2002:a17:90b:1d0e:b0:259:bf3e:5f8b with SMTP id
 on14-20020a17090b1d0e00b00259bf3e5f8bmr3286706pjb.17.1686369069601; 
 Fri, 09 Jun 2023 20:51:09 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 im16-20020a170902bb1000b001b008b3dee2sm3985040plb.287.2023.06.09.20.51.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 20:51:09 -0700 (PDT)
Message-ID: <ed62645a-ec48-14ff-4b7e-15314a0da30e@daynix.com>
Date: Sat, 10 Jun 2023 12:51:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] accel/kvm/kvm-all: Handle register access errors
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20221201102728.69751-1-akihiko.odaki@daynix.com>
 <CAFEAcA_ORM9CpDCvPMs1XcZVhh_4fKE2wnaS_tp1s4DzZCHsXQ@mail.gmail.com>
 <a3cc1116-272d-a8e5-a131-7becf98115e0@daynix.com>
In-Reply-To: <a3cc1116-272d-a8e5-a131-7becf98115e0@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On 2022/12/01 20:00, Akihiko Odaki wrote:
> On 2022/12/01 19:40, Peter Maydell wrote:
>> On Thu, 1 Dec 2022 at 10:27, Akihiko Odaki <akihiko.odaki@daynix.com> 
>> wrote:
>>>
>>> A register access error typically means something seriously wrong
>>> happened so that anything bad can happen after that and recovery is
>>> impossible.
>>> Even failing one register access is catastorophic as
>>> architecture-specific code are not written so that it torelates such
>>> failures.
>>>
>>> Make sure the VM stop and nothing worse happens if such an error occurs.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>
>> In a similar vein there was also
>> https://lore.kernel.org/all/20220617144857.34189-1-peterx@redhat.com/
>> back in June, which on the one hand was less comprehensive but on
>> the other does the plumbing to pass the error upwards rather than
>> reporting it immediately at point of failure.
>>
>> I'm in principle in favour but suspect we'll run into some corner
>> cases where we were happily ignoring not-very-important failures
>> (eg if you're running Linux as the host OS on a Mac M1 and your
>> host kernel doesn't have this fix:
>> https://lore.kernel.org/all/YnHz6Cw5ONR2e+KA@google.com/T/
>> then QEMU will go from "works by sheer luck" to "consistently
>> hits this error check"). So we should aim to land this extra
>> error checking early in the release cycle so we have plenty of
>> time to deal with any bug reports we get about it.
>>
>> thanks
>> -- PMM
> 
> Actually I found this problem when I tried to run QEMU with KVM on M2 
> MacBook Air and encountered a failure described and fixed at:
> https://lore.kernel.org/all/20221201104914.28944-2-akihiko.odaki@daynix.com/
> 
> Although the affected register was not really important, QEMU couldn't 
> run the guest well enough because kvm_arch_put_registers for ARM64 is 
> written in a way that it fails early. I guess the situation is not so 
> different for other architectures as well.
> 
> I still agree that this should be postponed until a new release cycle 
> starts as register saving/restoring is too important to fail.
> 
> Regards,
> Akihiko Odaki

Hi,

QEMU 8.0 is already released so I think it's time to revisit this.

Regards,
Akihiko Odaki

