Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C66687986FC
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 14:27:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeaZU-0004gQ-UG; Fri, 08 Sep 2023 08:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeaZL-0004O1-AW
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:26:39 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeaZF-0007si-GJ
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:26:37 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so2673669a12.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 05:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694175991; x=1694780791; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qt7D41T+GidVoWAvkM46nCy/YKce8RGy4siKWz5OqK4=;
 b=GuY7Lu1T6PM6e88iGi4P/eJVi4LT+BzLOXGbccTkChkHuUSjMK58CRDy1mxJpTcho6
 pEwqJhLrNGIrx1i/quJufInwGCsuGf9lZol4vJ96xUNpC4HKIfd6mEfVj9F8T7HNQ4CM
 QZd6oYgtoC1vuutaFf36MhZnLTB3nBnUGOFEdgMuI2abQx7pB+vuGkwVdq2Q5ypHYDGW
 hLF60XXp+z79w6uwm5bhuYwoNllGjaepY4WrmlPbkW+YCkeaNtAy7jhjboM1fSuzXRy7
 bCT7Ok9RFj6tGamqLyAKv/6AFmQAPW2W+7Y3hrJsYX/o6j5HBGVEozQinGzgD8NUlBE7
 H7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694175991; x=1694780791;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qt7D41T+GidVoWAvkM46nCy/YKce8RGy4siKWz5OqK4=;
 b=jSy32DUJ4vd6dYEAnDnGUTThtt5q0I2dYoxQ+zJQyoospdJ9+dz4k9Ue8/TOqSNDBr
 v2xE6zuCVtvzm2eZBinLSsgRk7fBtzTbyBIeKJucljU3bJlyo9zXClyIlmwqiEfQZDiT
 7wb0jClMSMnEEua/8l8Ervhl0uUJoky6NHTsp6liOvCID3YeMt+h2nfWhPZw5W/gkYyH
 fAIsfNce1OCEHkyCgXFTU42TwTjmaHzGpDhgBd3F30s+6icVJzDAsPTK6jxrhcmptVYV
 6C4mcbJfJAL/d1Z0F2WdE6jndqZxiYtNpqdRYScWMAN5Y8MmUSo8mhS7yl3EyJTyqYzL
 BTeg==
X-Gm-Message-State: AOJu0YwY5UEPPPMbhAIiLvc69Y+qFWVpP93CuLcgBwZ2za3dKmcJ4F7T
 iZjlxsOK4m0JzJGv1mGU0M5ZW8BhuMeOQKu1QJWBEA==
X-Google-Smtp-Source: AGHT+IEmrq5sR2U2ixUqSshuQ177pGEAvITzqUZzQBt6sb1T8cdgliFUblLauVYchVn65dLl56YLgMsElr75Jzb1NeM=
X-Received: by 2002:a05:6402:759:b0:52e:24fd:50f4 with SMTP id
 p25-20020a056402075900b0052e24fd50f4mr1645115edy.18.1694175991071; Fri, 08
 Sep 2023 05:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230904161235.84651-1-philmd@linaro.org>
 <20230904161235.84651-4-philmd@linaro.org>
In-Reply-To: <20230904161235.84651-4-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2023 13:26:19 +0100
Message-ID: <CAFEAcA_=g-kb29_8x41qLf7T=YueCuLLuKT=jgOJm1jfQpuRXw@mail.gmail.com>
Subject: Re: [PATCH v2 03/22] target/arm/hvf: Clean up local variable shadowing
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, 
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 4 Sept 2023 at 17:12, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Per Peter Maydell analysis [*]:
>
>   The hvf_vcpu_exec() function is not documented, but in practice
>   its caller expects it to return either EXCP_DEBUG (for "this was
>   a guest debug exception you need to deal with") or something else
>   (presumably the intention being 0 for OK).
>
>   The hvf_sysreg_read() and hvf_sysreg_write() functions are also not
>   documented, but they return 0 on success, or 1 for a completely
>   unrecognized sysreg where we've raised the UNDEF exception (but
>   not if we raised an UNDEF exception for an unrecognized GIC sysreg --
>   I think this is a bug). We use this return value to decide whether
>   we need to advance the PC past the insn or not. It's not the same
>   as the return value we want to return from hvf_vcpu_exec().
>
>   Retain the variable as locally scoped but give it a name that
>   doesn't clash with the other function-scoped variable.
>
> This fixes:
>
>   target/arm/hvf/hvf.c:1936:13: error: declaration shadows a local variab=
le [-Werror,-Wshadow]
>         int ret =3D 0;
>             ^
>   target/arm/hvf/hvf.c:1807:9: note: previous declaration is here
>     int ret;
>         ^
> [*] https://lore.kernel.org/qemu-devel/CAFEAcA_e+fU6JKtS+W63wr9cCJ6btu_hT=
_ydZWOwC0kBkDYYYQ@mail.gmail.com/
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

