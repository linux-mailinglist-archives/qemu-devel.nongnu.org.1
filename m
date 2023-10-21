Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4BC7D1FA5
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 22:50:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quIvJ-0005uf-5e; Sat, 21 Oct 2023 16:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1quIvE-0005uU-Lp
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 16:50:13 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1quIvC-0007jT-Ah
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 16:50:12 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c504a5e1deso32308621fa.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 13:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1697921407; x=1698526207;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M2xwEY2YJ5qzNC/XhwD9gwZUeiF7Nxufofc/HM5wdok=;
 b=NgIWCRuCff+iYi5ySTjYFl2kFQJPTtvlU5UsMKv1ziGZYMexhiAQx/BOJMdKlKBWpz
 wqB7/sEqqX9/um0elTzdnalDA8qN8X4NmDpsacmRkZorEmdne7ZxFtn2c8XxxlcISoVe
 N7YECHYHLIrBshNlJYN5Tr6+Wl0p+NV36rYe2NKNLXbWLaNfqYUEqFpJlJDxdVZeNhxc
 H8dA5gGkweCyYhbBYIb4p4o5lwmPOPQV5CdIwCWkdUn9rXVmC19sVSnb4DtB7d5jVERu
 LirW9B6gr1yI1Kw1Mzzqb2cscSrQB9cY/b9o2AZLyA7awv1uk9bZFGRIiceBfYKwaaVR
 2Fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697921407; x=1698526207;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M2xwEY2YJ5qzNC/XhwD9gwZUeiF7Nxufofc/HM5wdok=;
 b=NmHDlwGrQlDgUfiR6taMSqBPYuWKDVVir5QEAxwQEYJo8LC/2N2olF9HZGUkI2tJ9K
 C0CcU2eb3hEaVXgZC2BakgehP/ZYWlMGT42x2hiykysF6quKJCR/v/ShqTqhi18cMNrt
 9yPhIvEcVYf+Tgu38UiqKbgn1xjWUcz3Xs00XZH0RvKS0t01MqAfp4M6l8Wc0YKWd4nq
 co4612HYexY3DoF9m8A0+86AZ6w183uaFOULjUrCzyT+zGPKmc3RG6rC9pdaSnPrCWjr
 R5BQ9/ACZ2C0FdKkZO77zrNLxSF4ekRHbAhyml4nMnNYTDyebgtlR6lGJoMig2RXTpIa
 dXXw==
X-Gm-Message-State: AOJu0YwXTpE45ixspRNP/aJb8NAIrqQERH97+bsUPRcniugFC45lKGlZ
 na8n01nR9Oo9oYShZ9Dm2N65rd9RAq8MCPmgxfn7Cg==
X-Google-Smtp-Source: AGHT+IGT9Lo2kR64oCU119v3ngTVhS5npZzdF2sHneQU+gar0ZjrLjSBfoCRxKxDc2wYIs12Z2367dAGfNErZJLoopQ=
X-Received: by 2002:a2e:a543:0:b0:2bf:7905:12c3 with SMTP id
 e3-20020a2ea543000000b002bf790512c3mr3776278ljn.40.1697921406917; Sat, 21 Oct
 2023 13:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230420225258.58009-1-agraf@csgraf.de>
 <087e1543-1f22-4cea-b5b5-c3f9970787cd@csgraf.de>
In-Reply-To: <087e1543-1f22-4cea-b5b5-c3f9970787cd@csgraf.de>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Sat, 21 Oct 2023 22:49:55 +0200
Message-ID: <CAGCz3vuoCxsuz-w=iQdVUyCSr3FGiTDgqBQP-JEZx-S4NLbyGw@mail.gmail.com>
Subject: Re: [PATCH] hvf: Enable 1G page support
To: Alexander Graf <agraf@csgraf.de>
Cc: qemu-devel@nongnu.org, Roman Bolshakov <r.bolshakov@yadro.com>, 
 Cameron Esfahani <dirty@apple.com>,
 Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: neutral client-ip=2a00:1450:4864:20::22c;
 envelope-from=lists@philjordan.eu; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

Didn't spot this one first time around. :-)

The code looks fine to me, and in my test, it does indeed fix the
immediate crash.

There's still something making OVMF from Qemu 8.1 very, very unhappy
even with this patch - I'm getting memory allocation errors from it
and can't get anywhere near booting an OS, but I get the same result
in TCG mode, or if I disable CPUID_EXT2_PDPE1GB in hvf without this
patch, so that's not a regression caused by this change. I found no
other problems with a quick spot check using older OVMF and a few
other VMs.

Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>


On Tue, 17 Oct 2023 at 22:16, Alexander Graf <agraf@csgraf.de> wrote:
>
>
> On 21.04.23 00:52, Alexander Graf wrote:
> > Hvf on x86 only supported 2MiB large pages, but never bothered to strip
> > out the 1GiB page size capability from -cpu host. With QEMU 8.0.0 this
> > became a problem because OVMF started to use 1GiB pages by default.
> >
> > Let's just unconditionally add 1GiB page walk support to the walker.
> >
> > With this fix applied, I can successfully run OVMF again.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1603
> > Signed-off-by: Alexander Graf <agraf@csgraf.de>
> > Reported-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
> > Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
>
> Ping. Anyone willing to pick this up? :)
>
>
> Alex
>
>
>

