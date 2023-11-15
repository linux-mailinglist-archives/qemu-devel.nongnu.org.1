Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F0A7EBAC4
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 02:02:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r34IR-0004XC-B1; Tue, 14 Nov 2023 20:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34IN-0004X4-VI
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:02:19 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34IL-0005aO-IQ
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:02:19 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6bd32d1a040so6526059b3a.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 17:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700010136; x=1700614936; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K7SLFkFQRF7j3uv5Sfj9Whegr7DV8LXc6u/xFxK1L2c=;
 b=ZAiS5mfhHlgquGa+d4WLuUW6y89+r5JOx2HTpJhPjnuLakMaXQPKCFc0TcJSmtuoxI
 nFyto9igfrRNaaiQiGsnjhq0cAB/d3LULMHXndVpjUNla03UMz7ZgnbWc5JnoSRv8fGO
 TOtLGYuSzQna0v9gsh6dI60cycERc4JNsjWaHTn4miawkl8Ea/7/wYCHOIqTTEbsDnbX
 SAi9usqksEIdUjpi33L6fZ0uZASswGmP/XazjrjY4bMbivBk3ujrJXxf3t5c2JPRqDTv
 RBn37v/Ch2IcG9/Tm0Eo3xHFtqplqU4/ik3+nLO7u/TWJb+d+R7jbpifKBE3yAvrdBFF
 AlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700010136; x=1700614936;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K7SLFkFQRF7j3uv5Sfj9Whegr7DV8LXc6u/xFxK1L2c=;
 b=nwI+3Dr9L65yMBkHNRlQoMiQ4Pjq2a2fF85YUUXwDdfOUQScMBcMitql1js5qP+XXY
 6DK454WYfK3VgXkppXmCk+I5eLu344BmFNwhT1sTqUqB0GXOM4YIMHNcfFjqrdOeZJJN
 aFVx1pAS+jfL1Rdfuciy3yVC1oWIimSDmidoga5eZbKaQF34+SkJ3Cfkkc5VYCSjr14S
 DstqkPfedcWq8wBAMr9V68QU4h14Lyl1OZqbeOlkyUkHiz2gx+U/ijUo6GdbfecvHEmW
 aBEUew2fXQUWzCnjB6KSHgONU0MZ0otG5/YsKHTMyEV+wgaB6N7LyrFCkOWraYASp1/c
 T0Gw==
X-Gm-Message-State: AOJu0Yxld986K/czvIorvu+D87s9f1DUfTFRTffk15LbUEjnH8Nb8eOs
 5CftVW5KTBQT/MaVE3zNJGCIog==
X-Google-Smtp-Source: AGHT+IFDX61NlRb1L7Q+eA0z63Xq2j1mvyl/amlukNMwZOuezk86Nre8fCoPes12f2/arHjnU0en2w==
X-Received: by 2002:a05:6a20:9389:b0:187:6676:67f2 with SMTP id
 x9-20020a056a20938900b00187667667f2mr230116pzh.62.1700010135869; 
 Tue, 14 Nov 2023 17:02:15 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 d9-20020a056a00198900b006be0b0fc83asm1748118pfl.125.2023.11.14.17.02.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 17:02:15 -0800 (PST)
Message-ID: <a3c176fb-0cda-4b59-bdfc-79234cdff78b@linaro.org>
Date: Tue, 14 Nov 2023 17:02:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/31] target/mips: Use generic cpu_list()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-16-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-16-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/14/23 15:56, Gavin Shan wrote:
> Before it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-mips64 -cpu ?
> MIPS '4Kc'
> MIPS '4Km'
> MIPS '4KEcR1'
> MIPS 'XBurstR1'
> MIPS '4KEmR1'
> MIPS '4KEc'
> MIPS '4KEm'
> MIPS '24Kc'
> MIPS '24KEc'
> MIPS '24Kf'
> MIPS '34Kf'
> MIPS '74Kf'
> MIPS 'XBurstR2'
> MIPS 'M14K'
> MIPS 'M14Kc'
> MIPS 'P5600'
> MIPS 'mips32r6-generic'
> MIPS 'I7200'
> MIPS 'R4000'
> MIPS 'VR5432'
> MIPS '5Kc'
> MIPS '5Kf'
> MIPS '20Kc'
> MIPS 'MIPS64R2-generic'
> MIPS '5KEc'
> MIPS '5KEf'
> MIPS 'I6400'
> MIPS 'I6500'
> MIPS 'Loongson-2E'
> MIPS 'Loongson-2F'
> MIPS 'Loongson-3A1000'
> MIPS 'Loongson-3A4000'
> MIPS 'mips64dspr2'
> MIPS 'Octeon68XX'
> 
> After it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-mips64 -cpu ?
> Available CPUs:
>    20Kc
>    24Kc
>    24KEc
>    24Kf
>    34Kf
>    4Kc
>    4KEc
>    4KEcR1
>    4KEm
>    4KEmR1
>    4Km
>    5Kc
>    5KEc
>    5KEf
>    5Kf
>    74Kf
>    I6400
>    I6500
>    I7200
>    Loongson-2E
>    Loongson-2F
>    Loongson-3A1000
>    Loongson-3A4000
>    M14K
>    M14Kc
>    mips32r6-generic
>    mips64dspr2
>    MIPS64R2-generic
>    Octeon68XX
>    P5600
>    R4000
>    VR5432
>    XBurstR1
>    XBurstR2
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/mips/cpu-defs.c.inc | 9 ---------
>   target/mips/cpu.h          | 4 ----
>   2 files changed, 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

