Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4287358D0
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 15:43:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBF8b-0007F4-AN; Mon, 19 Jun 2023 09:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBF8T-0007D7-VM
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:41:39 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBF8S-0004kY-7p
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:41:37 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-988aefaa44eso158732666b.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 06:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687182094; x=1689774094;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R7iWOfq6yyVMl+4WGC/6g/d+jKGFb6uwUoaTDvuxXx0=;
 b=HK7fsvDcRbP4jLbm4Jekvp5oGi33/ZYt6elH6tQf70aGPNAe4b0ULH56mzzMXLMotF
 qVyLuMDv8Kbg5K7rQua55jy/QfC63XXCeO2wwVHa35PcODnr+D68yyzSu0JPZ/YDpkph
 AVbD0HH8RKcMOjhoGHzdVzomLPo5reKr5vAnubL5QENpEcq5PRTRDiurWOHZ+1DX1WyZ
 9mxTfWXNcIUYN3Xq330oKZgknlv5ih42V9Ji4DkepR7PKA04DjJ4sHHoySBcZfaS/a4S
 jqBGVNdPic1Wc33iwqyZeIAD4DKmD9ZHgomqWbcXMLp/AnJXbr+lmTt/SSdmO3Q6eUwu
 5ZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687182094; x=1689774094;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R7iWOfq6yyVMl+4WGC/6g/d+jKGFb6uwUoaTDvuxXx0=;
 b=UsCkHRH2+l6dfVuqgM4mn5Dfas5XZwgD49UjN4OQyaCdmZJivHK7Bm1v7j71JnjkjJ
 yGpGkfDZvVrCA5G+XwlVuv0FsW4byC6WHgskw/J4KkT8JH8fawA6WvQEE8TxyJhhbwtz
 tGyAK9OuG/L2D2xF60yjVntRjnya79TdykKBgUtaOG42RcdxWTRRyF7yB/wpo00ItQ62
 EwztmgzCF5EpypEI0CXjRVCEEG+2HkwvncRkVJw7Wat2zBk3Az1ssD0zfGgsnq1k7vdV
 WbtjlhjNpNgJJOqbdOHJtmpYYTj86Jo2bSVgKO8NoDBuDuc+8LMaxwmE0fdl56gHGsHF
 M7CQ==
X-Gm-Message-State: AC+VfDzO7NBatyMJEU5ZCeRwNrhEaajjHgI9JnzmCFfH9/T54Jg0aY5m
 empBSbDLCzwbzjj0SSWofURozCWH9VNJIF6SvpH2+A==
X-Google-Smtp-Source: ACHHUZ4BmFOBVCbVWMtIuqgvjJ12nDcUaa0cN3WUrQCHUGmSDJlnWZVyWXK3Gr7a7VEEoN0Mwu+uGHq3HNcrfVdoltY=
X-Received: by 2002:a17:906:4fc5:b0:973:daa0:2f6 with SMTP id
 i5-20020a1709064fc500b00973daa002f6mr9870738ejw.3.1687182094410; Mon, 19 Jun
 2023 06:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230607043943.1837186-1-clg@kaod.org>
 <20230607043943.1837186-13-clg@kaod.org>
 <955C217E-FE0F-41E2-8E97-9AFD8C4A0DBE@ynddal.dk>
In-Reply-To: <955C217E-FE0F-41E2-8E97-9AFD8C4A0DBE@ynddal.dk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2023 14:41:23 +0100
Message-ID: <CAFEAcA-siVrV0NWOZYR10UanT-Rrh37CqJ7Xm83Y90eGV91jSw@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] target/arm: Allow users to set the number of VFP
 registers
To: Mads Ynddal <mads@ynddal.dk>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 "open list:ARM cores" <qemu-arm@nongnu.org>, qemu-devel@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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

On Mon, 19 Jun 2023 at 13:47, Mads Ynddal <mads@ynddal.dk> wrote:
>
> Sorry, if this has already been acknowledged, but I couldn't find it on the
> mailinglist.
>
> This commit seems to break compatibility with macOS accelerator hvf when
> virtualizing ARM CPUs.
>
> It breaks the VM on boot-up with the message "ARM CPUs must have both VFP-D32
> and Neon or neither". I haven't looked into what VFP-D32 and Neon are, but the
> same VM worked on earlier versions of QEMU.
>
> It can be reproduced with the following:
>
> qemu-system-aarch64 \
>   -nodefaults \
>   -display "none" \
>   -machine "virt" \
>   -accel "hvf" \
>   -cpu "host" \
>   -serial "mon:stdio"
> qemu-system-aarch64: ARM CPUs must have both VFP-D32 and Neon or neither
>
>
> If you fix/work on this issue in a separate thread/patch, you can add
> reported-by, so I'll automatically follow and help test it:
>
> Reported-by: Mads Ynddal <mads@ynddal.dk>
>


> > @@ -1406,6 +1409,22 @@ void arm_cpu_post_init(Object *obj)
> >         }
> >     }
> >
> > +    if (cpu->has_vfp && cpu_isar_feature(aa32_simd_r32, cpu)) {
> > +        cpu->has_vfp_d32 = true;
> > +        if (!kvm_enabled()) {

Probably this should be "if (!kvm_enabled() && !hvf_enabled())".
Is that sufficient to fix the regression ? (I have a feeling it
isn't, but we might as well test...)

> > +            /*
> > +             * The permitted values of the SIMDReg bits [3:0] on
> > +             * Armv8-A are either 0b0000 and 0b0010. On such CPUs,
> > +             * make sure that has_vfp_d32 can not be set to false.
> > +             */
> > +            if (!(arm_feature(&cpu->env, ARM_FEATURE_V8) &&
> > +                  !arm_feature(&cpu->env, ARM_FEATURE_M))) {
> > +                qdev_property_add_static(DEVICE(obj),
> > +                                         &arm_cpu_has_vfp_d32_property);
> > +            }
> > +        }
> > +    }
> > +
> >     if (arm_feature(&cpu->env, ARM_FEATURE_NEON)) {
> >         cpu->has_neon = true;
> >         if (!kvm_enabled()) {
> > @@ -1672,6 +1691,19 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
> >         return;
> >     }
> >
> > +    if (cpu->has_vfp_d32 != cpu->has_neon) {
> > +        error_setg(errp, "ARM CPUs must have both VFP-D32 and Neon or neither");
> > +        return;
> > +    }

The other thing I see looking again at this code is that it
doesn't account for CPUs which don't have AArch32 support
at all. The MVFR0 register which the aa32_simd_r32 feature
test is looking at is an AArch32 register, and the test
will not return a sensible answer on an AArch64-only CPU.

On the other side of this, target/arm/hvf/hvf.c always
sets ARM_FEATURE_NEON, which I think is probably not
correct given that Neon is also an AArch32-only thing.

thanks
-- PMM

