Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD96737CAA
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:05:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBsq6-0002gH-Od; Wed, 21 Jun 2023 04:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBspz-0002fg-Fr
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:05:11 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBspu-0006SP-Bw
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:05:11 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f900cd3f96so44138705e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 01:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687334704; x=1689926704;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9h0Yy+2k8mgIlSHpB7SqCa/PYfXma6p7c1y7i2KTwc=;
 b=SfNfgDlT8uYk4ocjVDAweljUbUT6XvU3Eon2/5zs2NbzAnAuXf6YWjA5Bo7+sVKsqZ
 aFZq7iXmAympVXqna1xF5fVM4EEB854I77iEn48/femBAQw3Maim5aumfMTWpPwqncZt
 nzUpdJav/NIlXzBjXTVXifJinnxVYerc0eZq7iiTE0OuluGuRxDtxoIoBzdQ8IpKahof
 qO8eVz4pnzwQzWmmsZRMaLNop84NrBWgxHzaxL3Cezf13ZOfGbAwyhfjFB6QnGnR88Mq
 wofd0Ek0PpBhZRb3FUHw3lxw9wk0P+T3kexZU7WAfS29Le1ZV8DG4QemC3+XzJc1TN4f
 /YxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687334704; x=1689926704;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F9h0Yy+2k8mgIlSHpB7SqCa/PYfXma6p7c1y7i2KTwc=;
 b=IR+LAPIiPRJPM5MTKoi8dwF+RHuFAzs5VThU/z4DDNeHqBYnhv28ySMLsUq9Nzu6Wt
 FbJqqTifE/cfx1BUwYVxENxwxWlk+hF1zW1Hyf4QwhIBdlY1LBbxhQ3rirDnYvjOdQxT
 qCURudJzBfxAyomlT4+MtYJal+6M9ctp49QIIUHtUZLYG+/hxVgDK6i6qrbFjWkPX2Bb
 RU9sn9TnV+ykP77PUm8TLZd+dtc2afXf+43v4U7BwBubF2EZVuW177gj15E9RStfJLfL
 FUaWdZg9D0AxaEmNbcsxzq+dtoXoXEOdYrmvWzI0R+HNHkrbJlZdseUyt6PF0nw/6N9Y
 h0ng==
X-Gm-Message-State: AC+VfDwvficf4IGEcyR/x2KihNDGmPjJkUQ2HB+Sn0IOxmqs8Rt46RXU
 fxe3T8L6FFZ7fyfktBaw7+KC0g==
X-Google-Smtp-Source: ACHHUZ7OK49j36l+/j/DXjARdMQH7ebMOcXWAx1DnPQ4jeGoNDfGWpn8jlRgXdQeMHlaFHkqutq2fg==
X-Received: by 2002:a05:600c:2202:b0:3f9:1e32:b1f6 with SMTP id
 z2-20020a05600c220200b003f91e32b1f6mr6383514wml.10.1687334703509; 
 Wed, 21 Jun 2023 01:05:03 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q6-20020a7bce86000000b003f735ba7736sm4207373wmj.46.2023.06.21.01.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 01:05:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A150A1FFBB;
 Wed, 21 Jun 2023 09:05:02 +0100 (BST)
References: <CAFEAcA_UkPyic7U8eJkzBdBNoQowMToJkK-ro9re51zwn9-CMw@mail.gmail.com>
 <CAFEAcA_EjzQvy67XpXeEn7zMbkoCPLAs3n5PGK2J5kuGkFEBhQ@mail.gmail.com>
User-agent: mu4e 1.11.6; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson
 <richard.henderson@linaro.org>, Phil =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: 'make check-tcg' fails with an assert in
 qemu_plugin_vcpu_init_hook
Date: Wed, 21 Jun 2023 09:03:52 +0100
In-reply-to: <CAFEAcA_EjzQvy67XpXeEn7zMbkoCPLAs3n5PGK2J5kuGkFEBhQ@mail.gmail.com>
Message-ID: <87352li6kx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> On Tue, 20 Jun 2023 at 17:56, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>>
>> $ make -C build/x86 check-tcg
>> make: Entering directory '/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/bui=
ld/x86'
>> [...]
>>   TEST    munmap-pthread on arm
>> **
>> ERROR:../../plugins/core.c:221:qemu_plugin_vcpu_init_hook: assertion
>> failed: (success)
>> **
>> ERROR:../../accel/tcg/cpu-exec.c:1024:cpu_exec_setjmp: assertion
>> failed: (cpu =3D=3D current_cpu)
>
> git bisect blames commit d7ee93e2435970:
>
>     cputlb: Restrict SavedIOTLB to system emulation
>
> I think that commit is not correct, because it means that
> the size of 'struct CPUState' and also the offset of fields
> like 'cpu_index' will be different for files which are
> compile-per-target-for-usermode and files which are
> compile-once-only. The assert happens here because the
> code which sets up cpu_index is build-once, but the code
> in qemu_plugin_vcpu_init_hook() which reads cpu_index is
> build-per-target and now they don't agree about where in
> the struct the field is...

Hmm two things from that imply:

  - I suspect the plugin core stuff could be build once (or maybe twice,
    system and user)

  - we need to have some guard rails somehow to make sure things don't
    go out of sync

>
> Reverting the commit fixes the bug.
>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

