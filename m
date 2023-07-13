Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ED7752055
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 13:45:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJukt-00044w-89; Thu, 13 Jul 2023 07:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJukp-00044K-74
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 07:45:03 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJukn-0007O9-Je
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 07:45:02 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51f90f713b2so761671a12.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 04:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689248700; x=1691840700;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rTNUKy4QVti3eVyce8T/CM16Hk1RMV7WxqXGOsUbJOQ=;
 b=wdKBoT1e2PrdByc7sIDhnlfnyY2K0wyZi+ORi/m1TccwQHAAqSZ+3XFdAQdLmnKIUK
 Ne11ifb1E2u6fktjNp7Kcpex4Y9ORrMMn/+KVAuucIv6b51K6lP0x/P7z9bXtuDftPO6
 PAowo5r8X2YD89QMvaz9yfv5Fjpbn5GswM7c09Aa8aahD0i/BIL0/4vzuAduOpSyZD6A
 FfRP4K/jQ6Sgz5qJpaUjUHRw6RCaZ90REnOSlaHZI+wdR6DsIPMM/2l5VRybo1iusz9v
 yyvZIHDRuW+u/puSbXnIxxtleSU8jn4DXj6/zmpfkPT3yyhD5Vf9gF33JPY/Xxf7bKLi
 GmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689248700; x=1691840700;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rTNUKy4QVti3eVyce8T/CM16Hk1RMV7WxqXGOsUbJOQ=;
 b=Z0nB1d70M3k4PUvz80HS2CijN/Zes8O0TnXv+rtDUUGR4AjzBNTuzV6hgVhwgPWKeC
 YEZiNRg3hbdhOOTQnSliAVT3tUUTryzNeH/xa2PepKkX9rAmi+nbbyu1ZjZayRDzStdE
 vYGgDhpcFuHqPxymX7IASBXBPuFilkEtZGkurhn4KjcHpinU37AMoP58sggnClATiQ9Y
 M9X1x8wmhch88cZmowJbxxEyKS5cHEOJ6qTGELxrTUniNJCvMP+v9LaSJ4K9r0yZ3nmp
 lKoXoeQ3LVYRqpWk/1WjNnJVYX4bfE5vCiZrQ3c2KD934f8SXwerixRC/uiLiPC2ObL7
 fCgg==
X-Gm-Message-State: ABy/qLYTD3IIlcIjwij2ZFB4b2k75PQwAQs+81ZMI00PGHIaVke39pEG
 xXGuhMuiyMqMXvXt3DoduZIRpsZ+n4ObQvxh22Xw0A==
X-Google-Smtp-Source: APBJJlGDLdznQUSeAyvryFWOMr0V2aMhh0EOm7PFuyREeFef1qZfQ1kDsM9M2DB+lzg0FlIiHYHHv8e5EZdDSfpn318=
X-Received: by 2002:a05:6402:715:b0:51d:dbb0:fb86 with SMTP id
 w21-20020a056402071500b0051ddbb0fb86mr1735973edx.11.1689248699865; Thu, 13
 Jul 2023 04:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230713054502.410911-1-gshan@redhat.com>
In-Reply-To: <20230713054502.410911-1-gshan@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2023 12:44:49 +0100
Message-ID: <CAFEAcA8197FCwfNZrnxfO-87RveOko0Ju-KcTJOEi0vfjVtDKg@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/arm/virt: Use generic CPU invalidation
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, 
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, shan.gavin@gmail.com
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

On Thu, 13 Jul 2023 at 06:45, Gavin Shan <gshan@redhat.com> wrote:
>
> There is a generic CPU type invalidation in machine_run_board_init()
> and we needn't a same and private invalidation for hw/arm/virt machines.
> This series intends to use the generic CPU type invalidation on the
> hw/arm/virt machines.
>
> PATCH[1] factors the CPU type invalidation logic in machine_run_board_init()
>          to a helper validate_cpu_type().
> PATCH[2] uses the generic CPU type invalidation for hw/arm/virt machines
> PATCH[3] support "host-arm-cpu" CPU type only when KVM or HVF is visible
>
> Testing
> =======
>
> With the following command lines, the output messages are varied before
> and after the series is applied.
>
>   /home/gshan/sandbox/src/qemu/main/build/qemu-system-aarch64 \
>   -accel tcg -machine virt,gic-version=3,nvdimm=on            \
>   -cpu cortex-a8 -smp maxcpus=2,cpus=1                        \
>     :
>
> Before the series is applied:
>
>   qemu-system-aarch64: mach-virt: CPU type cortex-a8-arm-cpu not supported
>
> After the series is applied:
>
>   qemu-system-aarch64: Invalid CPU type: cortex-a8-arm-cpu
>   The valid types are: cortex-a7-arm-cpu, cortex-a15-arm-cpu, \
>   cortex-a35-arm-cpu, cortex-a55-arm-cpu, cortex-a72-arm-cpu, \
>   cortex-a76-arm-cpu, a64fx-arm-cpu, neoverse-n1-arm-cpu,     \
>   neoverse-v1-arm-cpu, cortex-a53-arm-cpu, cortex-a57-arm-cpu, \
>   max-arm-cpu

I see this isn't a change in this patch, but given that
what the user specifies is not "cortex-a8-arm-cpu" but
"cortex-a8", why do we include the "-arm-cpu" suffix in
the error messages? It's not valid syntax to say
"-cpu cortex-a8-arm-cpu", so it's a bit misleading...

-- PMM

