Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8861D777E63
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 18:37:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU8eV-00066a-I2; Thu, 10 Aug 2023 12:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU8eQ-000652-79
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:36:42 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU8eN-0007g2-I4
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:36:40 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fe5c0e57d2so9640285e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 09:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691685398; x=1692290198;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fuww2XdOKU0XVRXUiUWVHkwBQnhMf/9xcGXQTT+nT9g=;
 b=FqMX4Nh/QqOFSNlzo37PA3uFgX0tLEfzuLOD5BWx3UHCnleqVST/yVp5U2ArLAGfvh
 skAr80aqAsEfog1A8fsIbPUjL3rqdbsxI00PTX9kyEi7YPSqPh/0YbqhhBJdQrVHzvEC
 dDExLxRgKAKJeQUDnfIfh3M1Lg/ZgP9aa1oggTHXMX2KXvnSeMlZ7OWV9qkz5JATKA5u
 cJ6AB4Uyi58IlSI26clqjoBVKeXSDCrqjL8R8zHucqvuUWglAlVfYNcP5gtc9DVhP8FF
 V9nSz4FJo7/Hc6bUONBOmLR+RRX6NkUEmdwTFs9PQNpGecYG/S7EzB+ikgpUwFAZ7PMk
 VQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691685398; x=1692290198;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fuww2XdOKU0XVRXUiUWVHkwBQnhMf/9xcGXQTT+nT9g=;
 b=YL7G71WIk+je9mVFwTr0RJahIJlVnlYcuxNiXzn+WO8OblIgfV1gU1ayPR8IGGvoPS
 ul7lEDUzCptgABoI1z2Vt5umJe9rpSB+eyTEVfthv8XJpnc7qO9rqqmN3Wb1luJB8L+M
 c86/horncNFgaUluelLcPDJ+wFTi9dfc4x4r/hIsMgpIqjepfkSuUO/pe0ruAzrAxMg2
 BM606azbHyTVUnKXI31cK/Q6gDItktRjj4T8NNAAxz4ZzVjg2BfbqEZiJjVW5hGWFOkU
 ZazYt7JrvpG9tkNIVKtCQnc7lVZNa9wnMGEnma1rEhGRk7sMcc9TFB9GcY8e/x/Yd/dm
 zY0A==
X-Gm-Message-State: AOJu0YxHDuX1/3YQ2STsAVHlcv5XPD2PQO7ajBKr8PmJu4kg7OVKrXMt
 xF/B2xAc0gN2XE8M4wR37CTdLQ==
X-Google-Smtp-Source: AGHT+IEeP9hWrvfu2mGgWf99EeL0pqwkIzylyC1HNrOB/VsnFvT3C9Lrw33P3RBb1KQR13oK4NmhXw==
X-Received: by 2002:a5d:4386:0:b0:317:7081:9a6a with SMTP id
 i6-20020a5d4386000000b0031770819a6amr2050866wrq.24.1691685397856; 
 Thu, 10 Aug 2023 09:36:37 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 w17-20020adfee51000000b00317eee26bf0sm2674971wro.69.2023.08.10.09.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 09:36:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EB7161FFBB;
 Thu, 10 Aug 2023 17:36:36 +0100 (BST)
References: <20230810153640.1879717-1-alex.bennee@linaro.org>
 <CAFEAcA9bOS7tJDe_TRKOUGFcCDq_CjUfzAF7dYYRJbZA=5hvqw@mail.gmail.com>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>, Yonggang
 Luo <luoyonggang@gmail.com>, Beraldo Leal <bleal@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand
 <david@redhat.com>, qemu-arm@nongnu.org, qemu-s390x@nongnu.org, Wainer dos
 Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 0/8] some testing and gdbstub fixes
Date: Thu, 10 Aug 2023 17:35:40 +0100
In-reply-to: <CAFEAcA9bOS7tJDe_TRKOUGFcCDq_CjUfzAF7dYYRJbZA=5hvqw@mail.gmail.com>
Message-ID: <87il9m3ld7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 10 Aug 2023 at 16:36, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> This is mostly gdbstub focused but I cleaned up some bits while I was
>> in the testing makefiles. This is mostly to make the "check-tcg"
>> output as clean as possible without ugly line wraps. I tried to
>> eliminate the gdbstub info() output but sadly this is harder than
>> expected.
>>
>> I've tweaked the gdbstub handling for Ctrl-c packets as suggested by
>> Matheus. While I was there I also noticed we were being a bit precious
>> about gdb sending preemptive ACKS so I fixed that as well.
>>
>> I don't know if this is all late 8.1-rc material but its fairly simple
>> testing updates and the ccache stuff from Daniel should help as well.
>
> At this point in the cycle I would favour putting in
> the minimum that actually fixes bugs / test failure issues.

So 7 and 8? I would argue for 6 as well given that's a foot gun just
waiting to happen.

>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

