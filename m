Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC148375CB
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 23:03:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS2NH-00089Z-KK; Mon, 22 Jan 2024 17:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rS2ND-00089K-QH
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 17:02:32 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rS2NA-00035X-GB
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 17:02:30 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6dbd07916d0so2123589b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 14:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705960946; x=1706565746; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uXM8xkLKePSKWxUnlGvoWgfRvffu6+pTgfAN0qvsdQQ=;
 b=nfp+GF9Us8GuTwSfskSms5qLUsro8p0abQga69R2G2wUMe1E2T1TYyjD5Ud/Q/Rn8O
 hquGZ9vHSrA6R7uUmYaRlblRvXrHe1mMgHv+8DfLN4bBUcL086pcZm/dtoJL2c+EjROK
 8neIDv9H2cTE7XmS/RoBYEZVIQsG75yYZZBkZ7ShVmVjD9p1RUEoJ6OBHI+XMqfxTlSF
 PueHsTpDiviyPj9OBFv/eIE/HScCA7lIIZg7bnY97qlfaApvvdWWAvJ1STTi/mypDTh2
 LZuBVwvjJD/Cft7rgVMy2pB+4vWqeP78p7gMRDFDrJ7y/96zz2IEvfKwj0R2eUOyg5ej
 w/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705960946; x=1706565746;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uXM8xkLKePSKWxUnlGvoWgfRvffu6+pTgfAN0qvsdQQ=;
 b=gEne2f6NpGvTArFKvyI3cSvZkKYtmVWqw4zESxJarJ5+qkoyUdys53H4j1p0Ng0dRg
 3bFjxuIJpfKM6IQWzMMcb+1eacfXUmJ1ocWbGmFvQRYTiJT9tl3Us5YOGZrtfQ9tcErd
 jeferYfrBvgxvSRbEedCpd90t2sGet3v3zK1Odqo9t3fLlH4H48tZqbPsion/kin4Do/
 eHj3wOTaf4JJpyfdDxwSn8CpOF54Hx5vaiSeSVmplSJrk+hwtpVAORN2IbG7l8T4alFy
 lbwgZ3aipXJbjcU9B+yUqwA3yls6L8MdsdAxcGndYCk3+yoEBc+ffx+tk0JdknBLgWlO
 adhA==
X-Gm-Message-State: AOJu0YzL53f0opQjeJFZnVO9hKy96wzvpeJjhIR9mVBx0rMesK5aEkgm
 XVMLc19c2+/Gg0v+wtwPbi+ltKKQIc+Y5Wtb6nAci/5Cl33FyfTzG8lIaY1Hws0aw8BthfqXddm
 Elxw=
X-Google-Smtp-Source: AGHT+IFQ3SDcu6+2Bfieit15o8AJslud3iDZDxC3j1F7rTuv1DJC6O3iwjoHpXJMjVj9z2wbVRJ75w==
X-Received: by 2002:a05:6a21:189:b0:19a:5687:9490 with SMTP id
 le9-20020a056a21018900b0019a56879490mr6526353pzb.19.1705960946652; 
 Mon, 22 Jan 2024 14:02:26 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:2a49:979b:9002:98e6?
 (2001-44b8-2176-c800-2a49-979b-9002-98e6.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:2a49:979b:9002:98e6])
 by smtp.gmail.com with ESMTPSA id
 b7-20020aa78107000000b006dbd9501028sm3171030pfi.92.2024.01.22.14.02.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 14:02:26 -0800 (PST)
Message-ID: <d9bee29b-2317-41be-87c6-55fc42f9804e@linaro.org>
Date: Tue, 23 Jan 2024 08:02:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] tcg + linux-user patch queue
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240121002047.89234-1-richard.henderson@linaro.org>
 <CAFEAcA84d+mq85kae=yiwNvg1Ja=SKch00mocuNok1VghiYozQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA84d+mq85kae=yiwNvg1Ja=SKch00mocuNok1VghiYozQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 1/23/24 01:26, Peter Maydell wrote:
> On Sun, 21 Jan 2024 at 00:22, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> The following changes since commit 3f2a357b95845ea0bf7463eff6661e43b97d1afc:
>>
>>    Merge tag 'hw-cpus-20240119' of https://github.com/philmd/qemu into staging (2024-01-19 11:39:38 +0000)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240121
>>
>> for you to fetch changes up to 1d5e32e3198d2d8fd2342c8f7f8e0875aeff49c5:
>>
>>    linux-user/elfload: check PR_GET_DUMPABLE before creating coredump (2024-01-21 10:25:07 +1100)
>>
>> ----------------------------------------------------------------
>> tcg/s390x: Fix encoding of VRIc, VRSa, VRSc insns
>> tcg: Clean up error paths in alloc_code_gen_buffer_splitwx_memfd
>> linux-user/riscv: Adjust vdso signal frame cfa offsets
>> linux-user: Fixed cpu restore with pc 0 on SIGBUS
>>
>> ----------------------------------------------------------------
> 
> The new chacha test seems to consistently segfault on aarch64 host:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/5979230595
> https://gitlab.com/qemu-project/qemu/-/jobs/5978381815
> https://gitlab.com/qemu-project/qemu/-/jobs/5982075408

Oh dear.  It seems to be a problem with the aarch64 cross-compiler for s390x.
If I use a binary created on an s390x or x86_64 host, it works.

Unless someone has a better idea, I'll drop the testcase for now.


r~

