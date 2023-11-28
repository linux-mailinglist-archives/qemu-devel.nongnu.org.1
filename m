Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 242C17FBDDA
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 16:13:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7zlI-0001AW-2R; Tue, 28 Nov 2023 10:12:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7zlB-00018m-MD
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 10:12:27 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7zl5-0007M7-Cc
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 10:12:22 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40b397793aaso26302015e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 07:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701184338; x=1701789138; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xzcmHq9QW+/UuSqL5wUBTa2eJN1cDjJW1n9Awc1lyf8=;
 b=sgEaSI/PBpjqLDsNXV8l9gNPxB0H5sY1ol/U/+tGhSdOXn2uoIplHqNXPGH4ylqdDc
 k0U+FEweF/3mBDUEivDMQq153qJaQQ/SK7AfakYV0ybOQHUtw+ipxxPIGiJ8A/ISLMBJ
 T9YyPKhtBJgVb5vDcyJHkcSPQE5fgJk7Nl8F5Lg2A5Wiwo0n6tGkIkU8vFGE153/L3YS
 GOmAnIT60S+K2SejpS2iiTA8rSLtXvQgKXcvqHXlsN1iCTrOdGKwTrZ1QGBM8jEhbvTX
 GJjp+1wlJznmBZSO2FdlPWorkEny8V56YPocx4QA5WN8iYDxbLLXQo014kQgqb1hmwz4
 TVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701184338; x=1701789138;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xzcmHq9QW+/UuSqL5wUBTa2eJN1cDjJW1n9Awc1lyf8=;
 b=GHkl8Wg2MG+4S/Iesjq2ifNhviIBq7PTpttW6Nh3IuG3VQrO8zkn4cZGwLkQ1YBGoj
 2+2cmkvnYFPgXQi3GSlB7kyXH5uCQRbUlOUxzuSX0WG+S0NSp1E8hjTNKsAmMvZmPo9s
 e6cgcisYOHs+Se6lgrB9JcTE8HJeXBLixzFw6wGKS9Jhq7fnrR2ea+ce3Yvq/nt45ldQ
 hnFkaZvCa5+DnLV5nlcbUJ767RU57pXHTcqbtFrdh8mZdp/0/2fB+Cf85hXtfb3AN7Sf
 ozvD2zvzu2ELP8TRlPBGoiBFAur7AR2TAktMMvNDGR5r/CifHwl8RJIJpDtAwSUvDEwC
 A6AA==
X-Gm-Message-State: AOJu0YyGGQg/x55Oc6/1NfI3UNTuLieniWg97ho/+2D/7xfCAmAhjrIZ
 2twF05NvgfStjL6OnU2dnGiCow==
X-Google-Smtp-Source: AGHT+IH7VxUq4hQrGl6Jnxx+q2ckxU2rbD0eo8MlB2pC+ALkFapWMLbEM141hPTexbVDIbPO3EOErg==
X-Received: by 2002:a05:600c:1c19:b0:40b:34bb:10ce with SMTP id
 j25-20020a05600c1c1900b0040b34bb10cemr15831686wms.13.1701184337676; 
 Tue, 28 Nov 2023 07:12:17 -0800 (PST)
Received: from [192.168.69.100] (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 ay20-20020a05600c1e1400b0040b42df75fcsm9994841wmb.39.2023.11.28.07.12.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 07:12:17 -0800 (PST)
Message-ID: <edc0e1a9-604a-4d05-bf27-ad701ed14829@linaro.org>
Date: Tue, 28 Nov 2023 16:12:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/7] qemu: add support for iOS host
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, Joelle van Dyne <j@getutm.app>
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20210105022055.12113-1-j@getutm.app>
 <20210105022055.12113-4-j@getutm.app>
 <CAFEAcA-GArVcXbL6-r7jOsOzQ9SOiVByztzTpj+SUp0XahtNNw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-GArVcXbL6-r7jOsOzQ9SOiVByztzTpj+SUp0XahtNNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

(Cc'ing Ariadne, libucontext maintainer)

On 21/1/21 19:53, Peter Maydell wrote:
> On Tue, 5 Jan 2021 at 02:25, Joelle van Dyne <j@getutm.app> wrote:
>>
>> This introduces support for building for iOS hosts. When the correct Xcode
>> toolchain is used, iOS host will be detected automatically.
>>
>> * block: disable features not supported by iOS sandbox
>> * slirp: disable SMB features for iOS
>> * osdep: disable system() calls for iOS
> 
>> +``ucontext`` support is broken on iOS. The implementation from ``libucontext``
>> +is used instead.
> 
> Just a note since it came up in another thread today, but
> looking at libucontext its aarch64 backend doesn't handle
> the floating point registers. I think if the *context
> routines don't save/restore the callee-saves fp regs
> (v8-v15, FPCR) then it's liable to result in tricky-to-track
> down bugs where some kept-in-a-callee-saves-fp-register data
> from a function further up the callstack gets corrupted, depending
> on what the compiler happens to do. It would be good to work with
> the libucontext maintainers to add that functionality.

Per https://github.com/kaniini/libucontext/blob/master/README.md#caveats
this is a design choice:

   Only basic GPR registers are saved and restored when context swapping.
   The glibc implementation uses hardware capability detection to
   save/restore other register groups, such as the FPU registers or
   vector processing (AltiVec/AVX/NEON) registers. Adding this capability
   detection would significantly increase the complexity of the project
   and thus is not implemented. Support for compiling in code to
   save/restore FPU registers or vector registers may be added in a later
   release as a build-time setting -- for now, we assume a soft-float ABI
   with no optional processor features.

Minor update in 2022:
https://github.com/kaniini/libucontext/commit/5244775fb93ab9

   This is a work in progress, as newer compilers will spill even
   non-floating-point state through floating point registers when allowed
   to do so.

Regards,

Phil.

