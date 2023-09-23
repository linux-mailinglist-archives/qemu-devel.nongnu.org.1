Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB447AC215
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 14:42:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qk1wd-0005U7-56; Sat, 23 Sep 2023 08:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qk1vo-0005Ok-G2
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 08:40:27 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qk1vk-00062O-Kb
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 08:40:18 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5334f9a56f6so3685212a12.3
 for <qemu-devel@nongnu.org>; Sat, 23 Sep 2023 05:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695472814; x=1696077614; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KZ2vWW8XbVEjErQMJC9QNOZpZI8B0WFn2Dw81OiB8w4=;
 b=b08xcscFgD5rxRId3K5kijBCbBNDk+WMHd9ZlJaKUfvgYnKOMZeEiEzPM6nMw4VdZo
 RJitZb7/pQqb0vHH7Q9wb7OM4GJPimDJMZObPEnWXWaIl0HY+8fjk3vmFE6gstPnfVXJ
 hXBOzpC+uueD0KQpZJT3uEkuaWpsGu76Ec+cfQZMyu5ga/gGOsbXaP4hS5Vs0bdyEIqy
 8mHhO/HMnE9Gv6v8xKzu95EVCgFDhwP5Xw26REmaW2VN5YJX4ymHtFJRroXHPVsEy4TE
 ixTzafxeaNIQiCUJsrkKqmkRScdkCdjcSMqEpkvJ1RiSr8KO2TlbKHeMz/7qQE3JVXsP
 3eLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695472814; x=1696077614;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KZ2vWW8XbVEjErQMJC9QNOZpZI8B0WFn2Dw81OiB8w4=;
 b=KcuTV2zwZATpK747Yc1YkHEFAMcH0zMYWT+WUKvFh+Y0uk08YYHFxFEnfsgZ2lTJMu
 Q8ERWTdk4+pRwJE08esyUL9YhS3OweN55LJRR2PH6d1mWpJhlR/EGVs4Uekgi8Oef2za
 J8cH4sJb8N0KAsnxvULJGGNta8lfs72H+8wygI+ZPkPCy6FCUf5yPwA0LUI4k8KQQNvq
 iin95+XRcNZz1xT0RRPI+8PpRzo1RgAfmuT37w33CTxebK8Ai4FeElNv0nnltKGm12MZ
 aCr3AQ9XhC1pel0vRmW/Ss8adHaFNuIOr3ByhdEOeTEN/WVOV4xs2c0IhdX8dqjhVFyQ
 1nSw==
X-Gm-Message-State: AOJu0YxmRbKGAN83yzoJya107RH0rWip6NCt78ut+N6fzKaNRe90pU/x
 h9R2HAWN/ZOZ+3+owdJwEKNa5t1XMmTvvOmZB8jnrg==
X-Google-Smtp-Source: AGHT+IH9+zSz+RHil5DPIrFKsDdYV4pgsfQ9Kt6X5zsUVxHop552MZdV8ct96pjewkKVRkZG+aUFhs+z/xPQtMTcKBs=
X-Received: by 2002:a05:6402:619:b0:530:c717:b8f2 with SMTP id
 n25-20020a056402061900b00530c717b8f2mr1594325edv.38.1695472814316; Sat, 23
 Sep 2023 05:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230923121009.GD552050@quicinc.com>
In-Reply-To: <20230923121009.GD552050@quicinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 23 Sep 2023 13:39:55 +0100
Message-ID: <CAFEAcA_vyJyrg3oK8XEnoS3ZDE6BNKUXJALKPi8-VEKXA9j=Ug@mail.gmail.com>
Subject: Re: Question on Qemu flash driver - pflash_cfi01
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Sat, 23 Sept 2023 at 13:11, Srivatsa Vaddagiri
<quic_svaddagi@quicinc.com> wrote:
>
> cfi01 driver initializes a rom device with ops represented by pflash_cfi01_ops.
>
> static const MemoryRegionOps pflash_cfi01_ops = {
>     .read_with_attrs = pflash_mem_read_with_attrs,
>     .write_with_attrs = pflash_mem_write_with_attrs,
>     .endianness = DEVICE_NATIVE_ENDIAN,
> };
>
>
>     memory_region_init_rom_device(
>         &pfl->mem, OBJECT(dev),
>         &pflash_cfi01_ops,
>         pfl,
>         pfl->name, total_len, errp);
>
> This region is also mapped in guest address space. For ex: hw/arm/virt.c does
> that by:
>
> virt_flash_map1() {
>
>     memory_region_add_subregion(sysmem, base,
>                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
> }
>
> It is not clear to me under what circumstance would the callbacks listed in
> pflash_cfi01_ops be invoked. Is rom device memory supposed to be of trap/emulate
> type, so that guest read of that memory will get trapped and handled by ops
> listed in pflash_cfi01_ops? I see that a hypervisor accelerator's memory
> listener callback gets notified of that memory range and appears to be
> registering that as "read-only" memory. A read of that memory range from guest
> need not necessarily cause a trap for example, in which case when would
> pflash_mem_read_with_attrs get invoked?

A "rom device" is (as described in
https://www.qemu.org/docs/master/devel/memory.html) a device which
works like RAM for reads (directly accessing a region of host memory),
but like MMIO for writes (invoking a callback).

ROM devices also have two modes:
 (1) "romd mode" is the default; as above, reads go to memory,
     and writes go to the write function in the MemoryRegionOps
 (2) "romd mode disabled" means that both reads and writes
     go to the functions in the MemoryRegionOps
The device can use memory_region_rom_device_set_romd() to
switch between these.

For the pflash devices, we use these so that in normal
circumstances, execution and reading from the flash is fast.
But the guest still has the ability to reprogram the flash
(by writing commands to it); when the guest is programming the
flash, reads from the device don't return the flash data, they
return command responses. So when the guest starts programming
the flash, the device puts itself into "romd disabled" mode,
so that it can handle the read accesses correctly. Once the
programming has finished it can switch back into romd mode again.

thanks
-- PMM

