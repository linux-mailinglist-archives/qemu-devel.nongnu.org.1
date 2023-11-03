Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F257E04AD
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 15:29:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyv9V-0005nb-Su; Fri, 03 Nov 2023 10:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyv9L-0005gJ-0p
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 10:27:53 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyv9H-0004U1-3r
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 10:27:50 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53e70b0a218so3659659a12.2
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 07:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699021663; x=1699626463; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3d8YdsY7amKu4t+7ONvQkOry155R+fswCQzg9jFrA4U=;
 b=ish/nJdDbmg1QFv/1aBlbu5L1wlh940DouKqsGpGa83/WXTnLlHLdqqhqKD/Fn1UFP
 1KVGmEog1MMicJvnrctCrirfDhZi1q0kxBrKzAnDt7s63Wq1I4NzhmcV2RjV2faNOTNG
 s1t/trAQkakvfBv8Bd+ccbKymkjwb629n7CsaCrcyXWV+ORHsZhd3cW6XQwjd0j+5Nlw
 yqwXKABVwNBuWnQj+9RewA1Opa0dQUfoT6ULiYpHZYuK5HoUT/xcKxtvuzewPkYhzJs0
 nluY2jlxmtDKVCshtn7UWs0gN8W2toE8uOukhQhTsIwRbZTF5bF1ytPlF+qXDX6g4RNa
 xq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699021663; x=1699626463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3d8YdsY7amKu4t+7ONvQkOry155R+fswCQzg9jFrA4U=;
 b=r0BqTerFSyLfIUJaHlf1jPHv6HcGrOq9OSU7RnmXkC8eWWluTpEePBfw9jSkVF0JLo
 sCosPDsgSyZ6VxdZ5Zf4IJmNw0NGa+s5yqvPBzN3QRPaADF8ThLMibEnIlasVgkAv1Am
 IFNkANcCsFhEc7hjvxRUPEtT5/aqMxgsebtDcUU469D2J0eUOb24SgqY6kK/60Xquegs
 iBehxVgZWVj9cLIUD6S+8d38z1gP0OPHDA4KtikS+2rwdCLN9t/m1IjmC0toF+6sW0h4
 lxsKWRtVqHCE3uW4FeEe8upVzeHlesosYhxCt6sC6Y6lNv/KE20rE1avcptffps1CIKe
 Yhtg==
X-Gm-Message-State: AOJu0YxUCXw+mTnRN3Lfjo9pB1RPwDALjjLWyyOng1sN5A+68E+OhQyk
 cbqe5R75EtJxLBrpt3e5FW/EKdrmU+VaI7Cg/9QUFhLVxkasKjF/
X-Google-Smtp-Source: AGHT+IFnNNiGPk9IIaasJsAWrq9aThkl7ajEpIraKfCdeOYLvzRJ3aS+8O4HnLWU46bHZ3dS+HYfb7OtpwuCTPpmwDo=
X-Received: by 2002:a05:6402:3586:b0:540:ef06:23d7 with SMTP id
 y6-20020a056402358600b00540ef0623d7mr22878930edc.1.1699021663523; Fri, 03 Nov
 2023 07:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <475d918d-ab0e-f717-7206-57a5beb28c7b@redhat.com>
In-Reply-To: <475d918d-ab0e-f717-7206-57a5beb28c7b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Nov 2023 14:27:32 +0000
Message-ID: <CAFEAcA_w5fM57L81vpByTnOPvdn455xBXtU7UnHFGuJuq-0New@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: fix PMU IRQ registration
To: Sebastian Ott <sebott@redhat.com>
Cc: qemu-devel@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Fri, 3 Nov 2023 at 14:14, Sebastian Ott <sebott@redhat.com> wrote:
>
> Since commit 9036e917f8 ("{include/}hw/arm: refactor virt PPI logic")
> PMU IRQ registration fails for arm64 guests:
>
> [    0.563689] hw perfevents: unable to request IRQ14 for ARM PMU counters
> [    0.565160] armv8-pmu: probe of pmu failed with error -22
>
> That commit re-defined VIRTUAL_PMU_IRQ to be a INTID but missed a case
> where the PMU IRQ is actually referred by its PPI index. Fix that by using
> INTID_TO_PPI() in that case.
>
> Fixes: 9036e917f8 ("{include/}hw/arm: refactor virt PPI logic")
> Signed-off-by: Sebastian Ott <sebott@redhat.com>

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1960

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

