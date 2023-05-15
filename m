Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC9A70318F
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 17:29:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pya7U-00076M-Qn; Mon, 15 May 2023 11:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pya7S-00075Y-Qi
 for qemu-devel@nongnu.org; Mon, 15 May 2023 11:28:14 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pya7R-0001kS-6x
 for qemu-devel@nongnu.org; Mon, 15 May 2023 11:28:14 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-50bc456cc39so19049473a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 08:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684164491; x=1686756491;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uws9FIAaaYwX2PwdPVre/nN5mC8VFkyKLBItlzcAiM8=;
 b=xWE1qPF0uJJN0GRNX9CTyABDusUikQtTw/DMr7J8VEyoy4Zpud45giO9fy4UCzP12L
 p5kWL+mUuwAnO5SbByhaHOupAxJVKTuuhqff5JDvb2jW+wBvQOGJ7mbiyztLgPSsXf+l
 3wfb2kXKROB/5G5v/3oNTkMlG79CrJv0a7nqqGCRXtXnksUZ+LNIik0BS1EEM3FPv0Ny
 KjOuI4allN1kHL0gZKMFt3z5K8i6juzkrztWUXz7ncchzevCUTO2MMIpzw4sCCdv6JIi
 0wMD3lp4ti5dv/JXpaVexpYXGYIs1c7QXSvlJwmyRkSBHxkEhz3vXAG6EKHbUwbb374L
 hc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684164491; x=1686756491;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uws9FIAaaYwX2PwdPVre/nN5mC8VFkyKLBItlzcAiM8=;
 b=SSdXLzA6lZE0L01tuVQk+TKZSUTNubbRPbBhxSSXuKzC8u/dOQrYVJhbv84iXuTYjL
 LuQQkBdVt3uBEZEst2zNmaxHHBv6oYnQx/qAXaezYoj76+q/5cfFCHAfStWWdmwfYt6m
 YKMfWUgFuZCWAyo9FeSHoBCHhomOr3Gwnvs0RphNTztKsY91HgxmtJBQusRB+V4WgiUU
 WQshgZhahlVqI+ZvPHv4dVyUlNPxQD20ViH8Mw5trBcfJZAzOU0K/IDxJqR4iwko03ae
 b943KgQOh8S4hIemJ5UoV4YgY+QI+U8FWicSg4inPe/ERtr/2d7en291ITuWT5aMSrKV
 96aQ==
X-Gm-Message-State: AC+VfDxVI/AnZLBuZ6xUW7qyY5ia23RzDEebNsbLjujphs7O0n26iquJ
 zY1/mnKMksdCD5U0Ng+edJd6t5PLWycd+C2iGL/zow==
X-Google-Smtp-Source: ACHHUZ7qfp0+uLoyrVMjhzPONt/1Jr88vzLaRbVhtNDqyg9vg2RpI8N5h07vIxsLPUMUV3YrMxL9LyFAnj+qXbaC38M=
X-Received: by 2002:a17:907:3e27:b0:962:9ffa:be22 with SMTP id
 hp39-20020a1709073e2700b009629ffabe22mr31329461ejc.7.1684164491573; Mon, 15
 May 2023 08:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230506183417.1360427-1-marcin.juszkiewicz@linaro.org>
 <CAFEAcA-d2_3xXMNwMG+-WOw=y=zandSM24-GfcJ8s=3etqACcQ@mail.gmail.com>
 <88e30a90-71c3-0ded-8412-0f3af6ec3b37@quicinc.com>
In-Reply-To: <88e30a90-71c3-0ded-8412-0f3af6ec3b37@quicinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 May 2023 16:28:00 +0100
Message-ID: <CAFEAcA-MuBoy81GB472G5thCy8n10gYQfOMOPxu_3tb60BL5vA@mail.gmail.com>
Subject: Re: [PATCH] sbsa-ref: switch default cpu core to Neoverse-N1
To: Leif Lindholm <quic_llindhol@quicinc.com>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Fri, 12 May 2023 at 17:02, Leif Lindholm <quic_llindhol@quicinc.com> wrote:
>
> On 2023-05-12 15:50, Peter Maydell wrote:
> > On Sat, 6 May 2023 at 19:34, Marcin Juszkiewicz
> > <marcin.juszkiewicz@linaro.org> wrote:
> >>
> >> The world outside moves to newer and newer cpu cores. Let move SBSA
> >> Reference Platform to something newer as well.
> >>
> >> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> >> ---
> >>   hw/arm/sbsa-ref.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> >> index 0b93558dde..a1562f944a 100644
> >> --- a/hw/arm/sbsa-ref.c
> >> +++ b/hw/arm/sbsa-ref.c
> >> @@ -852,7 +852,7 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
> >>
> >>       mc->init = sbsa_ref_init;
> >>       mc->desc = "QEMU 'SBSA Reference' ARM Virtual Machine";
> >> -    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a57");
> >> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("neoverse-n1");
> >>       mc->max_cpus = 512;
> >>       mc->pci_allow_0_address = true;
> >>       mc->minimum_page_bits = 12;
> >
> > Seems reasonable; Leif, any objection?
>
> None.
>
> Longer-term, I still want to move to "max" as the default, but that is
> likely to require some invasive changes to TF-A, and this is already a
> huge improvement. So:
> Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>

Thanks; applied to target-arm.next.

-- PMM

