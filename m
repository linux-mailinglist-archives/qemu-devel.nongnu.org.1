Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 299297EDFE6
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 12:32:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3aaG-0005Ry-1M; Thu, 16 Nov 2023 06:30:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r3aaE-0005L7-6T
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 06:30:54 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r3aaC-0001TY-Ff
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 06:30:53 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-53e07db272cso1044036a12.3
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 03:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700134248; x=1700739048; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KA2fYAOCdDWgAkBiDsmbiDN//ARxFgpCJQzgPvBBm/U=;
 b=oiQ3FqxtMpI6/rDoeNSoyQ3BsqqHWtXUDeaVoUer2TT6kis3zj9nn6EjKF305r9c1y
 Y0H121HDBlRflPc8RlY3eyRjwA8GiQ0gTqVnciR/u9FPJ5NYKRX+l0CUkwwrisdDCpUd
 ABAzUyUDZpCbwpFVLXSZdPZqWzJD3LeLBWgQFovDhRIqhdjhDyYFnd+rxA/1avCHKKfc
 XjejwtlTgnOyaGZF5ar5Y+l2ue1f5V5YQEPt37H28lnWSrYhrtHSNdK25+tqqZEeoQpT
 Ct9S1gwNLCG8uQtpdsoDzQzM6Er/vF1+QHZM6/6/QLFOC4nTm27ycdRFuSA46jwKCnKh
 0iwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700134248; x=1700739048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KA2fYAOCdDWgAkBiDsmbiDN//ARxFgpCJQzgPvBBm/U=;
 b=NiglEceP7BRENyRPH5A8VSTN7a7AsKG3bJoAX26Orzk5l0Lm+0vBiqZdvUPIg97iBs
 GDB8ZWmBGFuYYmW2p44frI2N203KLkSKV6FhSow7FdvXoC+EVh6iUHRYngHIpomsf157
 nQ96qSNZwGaHTMaz3opMwFbZDXhRi4ZyW6AcTvV3HLsh//TXfYvS3Um1Api/pTmJzVsL
 sYEuAO2T4NrGD7co4oS39/1U9ybwfV6Dxg1YVVBtbqBpVqmALuvPxaNDOByE1UEr5hEn
 AJzj+ObE56hnjR0UXQQQYnf1w0Pv85pHwX2NV5P7ycRBBayW9DDkgfJXAT3Fuh2z96d9
 Eoxg==
X-Gm-Message-State: AOJu0YzIKq4Kjkh+rMvHsRvnlWjNuMffW8I0Kfhtblk0YcwT+4V7FmQD
 Ck4ShN+ndk4Au6GyiLLFjm/2JulMhmgt0BrWJsdXhw==
X-Google-Smtp-Source: AGHT+IHMCANmRpr7xkLLqkehC56cKhvV+KwU4mShx+m6wMMIZv32T2MhXzOvNGCtEwa/XZkaOklk9FCCL8AR0iMsKUI=
X-Received: by 2002:aa7:c1c9:0:b0:541:2bb8:7a9f with SMTP id
 d9-20020aa7c1c9000000b005412bb87a9fmr10176368edp.38.1700134247801; Thu, 16
 Nov 2023 03:30:47 -0800 (PST)
MIME-Version: 1.0
References: <20231114205507.3792947-1-venture@google.com>
 <CAFEAcA_cKSM-N0nkjtg4UYKwQwBRxffifteU3P=BBxxhEyePsw@mail.gmail.com>
 <CAO=notzk2Dv3LOh+w1XZ1H6vTdq4sp_KvOat4Dj1vbDBhJKzvA@mail.gmail.com>
 <aa6bce64-430c-4876-9025-f29e06399d4d@linaro.org>
 <CAO=notyVTQTAsk9u7LkZJF_C+mqPvQPkYB52-cHAoNAWYW9=Lw@mail.gmail.com>
In-Reply-To: <CAO=notyVTQTAsk9u7LkZJF_C+mqPvQPkYB52-cHAoNAWYW9=Lw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Nov 2023 11:30:37 +0000
Message-ID: <CAFEAcA-kdA6knf5fqNDaUiHNG=5ek_-jk-i3vNA3oinXHCUH4Q@mail.gmail.com>
Subject: Re: [PATCH] softmmu/memory: use memcpy for multi-byte accesses
To: Patrick Venture <venture@google.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, pbonzini@redhat.com,
 peterx@redhat.com, 
 david@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org, 
 Chris Rauer <crauer@google.com>, Peter Foley <pefoley@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Wed, 15 Nov 2023 at 17:26, Patrick Venture <venture@google.com> wrote:
>
>
>
> On Wed, Nov 15, 2023 at 9:02=E2=80=AFAM Richard Henderson <richard.hender=
son@linaro.org> wrote:
>>
>> On 11/15/23 08:58, Patrick Venture wrote:
>> >
>> >
>> > On Wed, Nov 15, 2023 at 2:35=E2=80=AFAM Peter Maydell <peter.maydell@l=
inaro.org
>> > <mailto:peter.maydell@linaro.org>> wrote:
>> >
>> >     On Tue, 14 Nov 2023 at 20:55, Patrick Venture <venture@google.com
>> >     <mailto:venture@google.com>> wrote:
>> >      > Avoids unaligned pointer issues.
>> >      >
>> >
>> >     It would be nice to be more specific in the commit message here, b=
y
>> >     describing what kind of guest behaviour or machine config runs int=
o this
>> >     problem, and whether this happens in a situation users are likely =
to
>> >     run into. If the latter, we should consider tagging the commit
>> >     with "Cc: qemu-stable@nongnu.org <mailto:qemu-stable@nongnu.org>" =
to have it
>> >     backported to the
>> >     stable release branches.
>> >
>> >
>> > Thanks! I'll update the commit message with v2.  We were seeing this i=
n our
>> > infrastructure with unaligned accesses using the pointer dereference a=
s there are no
>> > guarantees on alignment of the incoming values.
>>
>> Which host cpu, for reference?  There aren't many that generate unaligne=
d traps these days...
>>
>
> Here's the sanitizer log/qemu log, the host-cpu was an amd64.
> third_party/qemu/softmmu/memory.c:1341:16: runtime error: load of misalig=
ned address 0x52500020b10d for type 'uint32_t' (aka 'unsigned int'), which =
requires 4 byte alignment
> 0x52500020b10d: note: pointer points here
>  ab ab ab ab ab ab ab  ab ab ab ab ab ab ab ab  ab ab ab ab ab ab ab ab  =
ab ab ab ab ab ab ab ab  ab
>              ^

> SUMMARY: UndefinedBehaviorSanitizer: misaligned-pointer-use third_party/q=
emu/softmmu/memory.c:1341:16 in

Ah, right, so the clang/gcc undefined-behaviour sanitizers rather than
the actual host hardware barfing. (We definitely want to fix these
regardless.)

thanks
-- PMM

