Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D71A079724F
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 14:32:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEAJ-0002CU-O4; Thu, 07 Sep 2023 08:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeE9J-0001qx-5J
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 08:30:18 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeE93-0006TS-Iq
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 08:30:16 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-99bcc0adab4so107752166b.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 05:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694089799; x=1694694599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2KjSP2EwBUdECeTIgYlH4EXAAjspyPQU/7HbrLq3ph4=;
 b=n1FEWM+5ffwV87CWx4ZxbL31raMVm8kSt+D4zPHHfhQaeGDYKBGqefDURIjsNnD4D2
 GfQDkGUrk58rRR8R3CsenL6Ebe0ktu8YxJ1sd7+QNNW+aGnfWeGOea0yPowwfWUoibUH
 VuWfyengYS6CgwLaH9ho6jlbAgux7EFMqyisQ+uT9h+nVci3tT629fFMrb5IJn0ub9cI
 4TRJQmjU48HvokqZtaRJ1iOKTuih+l8b+ydLRVjpb3iKqXdpNX9irYXY+VAWcKD0hyFB
 8iF4/RYpLm6iLCJja0tVZbWWH7NymvG+8ONG+GR7cJHxpgXODLnp1Qt8+eLeDF4ZV6OX
 GmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694089799; x=1694694599;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2KjSP2EwBUdECeTIgYlH4EXAAjspyPQU/7HbrLq3ph4=;
 b=FZOnuTOjJBqGjdY8PQug9wO36uhOhp+hajaSCW834KH0kfNa7DfMX03q0h9lrkdtsG
 EnOvXSlEodF+4hog5jw7U0PqLrDdjCMHtQ5lzDxw/uK/o1DGlZRiC430SIfTQKSTlokN
 mPoNlNX/ujo18tt5CGoBRzep+9X0ojT7ZbEz+MByjF521lPaVo/OZmbQTuvE/XwVP5Jy
 eDa4iqQUkqFeNBf/PEY8AeowvlW7Le3BDat6htowkmcFuHDS1D8/rmm4gnbdNPdJMcjA
 o4ckVc32OzZC/QTIAA1S3L2Qtvk8KWFahGlSJgKruvQdoLsSFzX16Vfeo3/PMp7qYiUU
 dNxA==
X-Gm-Message-State: AOJu0Yxe5BJJg1hGzv2aOuPnf6Tw/EM8nFpZXG9Lo1WkPjfD61YQtuWp
 MMrnbGSb6TL9IdkoPxFy5dSNxg==
X-Google-Smtp-Source: AGHT+IHkgpAVAHwNw+Wz3/117ucGJT9J4Io2vgHOi1nk6iAUleopczSIb+eXIebiWNy51a/YC3PyUg==
X-Received: by 2002:a17:906:295:b0:9a9:e5bb:edc5 with SMTP id
 21-20020a170906029500b009a9e5bbedc5mr1023122ejf.65.1694089798795; 
 Thu, 07 Sep 2023 05:29:58 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-226.abo.bbox.fr.
 [176.131.222.226]) by smtp.gmail.com with ESMTPSA id
 v14-20020a170906338e00b00992b8d56f3asm10384194eja.105.2023.09.07.05.29.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 05:29:58 -0700 (PDT)
Message-ID: <1398e971-8115-13e1-6ee4-4c46df0814dc@linaro.org>
Date: Thu, 7 Sep 2023 14:29:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: riscv64 virt board crash upon startup
Content-Language: en-US
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list
 <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Sunil V L <sunilvl@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 "Warkentin, Andrei" <andrei.warkentin@intel.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
References: <139b9697-5732-dafa-0942-6d93eed674c7@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <139b9697-5732-dafa-0942-6d93eed674c7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/9/23 13:25, Laszlo Ersek wrote:
> This is with QEMU v8.1.0-391-gc152379422a2.
> 
> I use the command line from (scroll to the bottom):
> 
>    https://github.com/tianocore/edk2/commit/49f06b664018
> 
> (with "-full-screen" removed).
> 
> The crash is as follows:
> 
>    Unexpected error in object_property_find_err() at ../../src/upstream/qemu/qom/object.c:1314:
>    qemu: Property 'qemu-fixed-text-console.device' not found
>    Aborted (core dumped)

Cc'ing Marc-André for commit b208f745a8
("ui/console: introduce different console objects")

> 
> (Full backtrace attached.)
> 
> If I replace the "-device virtio-gpu-pci" option with "-nographic", then
> there is no crash; QEMU launches fine and the guest starts booting fine.
> 
> I think this is a board-related problem; the riscv virt board code
> likely does not set up the console properly.
> 
> Furthermore, I reckon this could be regression. When Sunil's above patch
> was committed to edk2 (2023-06-23), the graphical guest window must have
> worked still.
> 
> Laszlo


