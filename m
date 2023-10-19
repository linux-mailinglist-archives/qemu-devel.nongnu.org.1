Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9107A7D005F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 19:21:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtWgv-0001dI-8h; Thu, 19 Oct 2023 13:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qtWgr-0001VQ-T2
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 13:20:10 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qtWgp-0003Ci-Tv
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 13:20:09 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-57babef76deso4546496eaf.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 10:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697736005; x=1698340805; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oNElmABxHJ1SOD+uaLyrhboa1c2qYhbBgthOc9UqbWw=;
 b=MPIPYcvgxqbmsPnZn+UVm7getD99FrSLhTuZxUttUqAxaAm7NZeYH8ocAHSFIGpF7r
 RXrH7gM6pdc9Gx8y7/hoJSipdwGeRSdkt0A/RZM+XSVUQjcbMg1j/SdJuqfrcUSkcav9
 bmIRv1JJuthRrDl/WefLrx5ZdS6+0CjYVWTRA7rd71xwpGRti1lVLUZQx/6cHmfA0oAA
 TEdufpXk3Trofq2uhEYCvPbW7hruWrRA9Uk06yhQ+TwFg8p8Ndb+I4xFTlXu4ERc9TBv
 7XD8nh713A/CPq9OFIm0sdaxno1BxmViza6GYhEUny+zsiIIcEMLIErUMku5rE8QzPHw
 gp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697736005; x=1698340805;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oNElmABxHJ1SOD+uaLyrhboa1c2qYhbBgthOc9UqbWw=;
 b=rf37uk2TlO40KKrjY9QBNNRWyZqJcuwCktCKJ2KhENwhbPoMip9GKQ5pc6DpLQBpvs
 +ey2h3iaO5WaN6vLuP9lUk7/BxowjqRQMfir6RsnPqRbcO3PMuFIA5vXW8SSTaMKB8vM
 6bxWUtj0ie/f/JMOkrfzFviwAh+uccVID/cVtdi/YHVi8nuUQkrQj8IVAriG3FSjgsK0
 QIu0x92DEDH6dbsdcWxK75b9FLYp9roCiwo4b2E6Tvztxt2P/NDOET4fgyLicDMzTw/a
 VeULATqbhN8eCV2kzYLR9mjmLADK0LRr6XZBFjvmQywrXCigvFJtqPvRhAza4rDVHpkW
 9KEQ==
X-Gm-Message-State: AOJu0YyoxqkV4acquA99WZcsAghfVqv/51ICMFyX4kqtxk2VL+jrO/ci
 WkJpfjyH4+hBr/Y+acMh+lakpzc1mTPWYdcLMF0=
X-Google-Smtp-Source: AGHT+IE43ac1maRBpxRKnBuAcZba3eZW1NLcRnPQ5i4lbdmQEfE4os880KC/jheGDeseUs7JlWVVqZTvLZ66jl5Aep4=
X-Received: by 2002:a4a:c385:0:b0:581:df34:15c with SMTP id
 u5-20020a4ac385000000b00581df34015cmr2941962oop.5.1697736005487; Thu, 19 Oct
 2023 10:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231018204030.391572-1-deller@kernel.org>
In-Reply-To: <20231018204030.391572-1-deller@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 19 Oct 2023 10:19:52 -0700
Message-ID: <CAJSP0QUyROvzRR-Wenc36zr2H5r7npO5nzRDpZCQFLdW9=xJXA@mail.gmail.com>
Subject: Re: [PULL 00/11] C3700 patches
To: deller@kernel.org
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 18 Oct 2023 at 13:42, <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> The following changes since commit 63011373ad22c794a013da69663c03f1297a5c56:
>
>   Merge tag 'pull-riscv-to-apply-20231012-1' of https://github.com/alistair23/qemu into staging (2023-10-12 10:24:44 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/hdeller/qemu-hppa.git tags/C3700-pull-request
>
> for you to fetch changes up to 6120e493c9c5b7d2b122f2501ea1c2cc2b64d1e3:
>
>   hw/hppa: Add new HP C3700 machine (2023-10-17 23:13:19 +0200)

Please take a look at the following CI failure:

266/841 ERROR:../tests/qtest/device-introspect-test.c:262:test_device_intro_concrete:
assertion failed (qom_tree_start == qom_tree_end): ("/machine
(none-machine)\r\n /peripheral (container)\r\n /peripheral-anon
(container)\r\n /qtest (qtest)\r\n /unattached (container)\r\n /io[0]
(memory-region)\r\n /sysbus (System)\r\n /system[0]
(memory-region)\r\n" == "/machine (none-machine)\r\n /peripheral
(container)\r\n /peripheral-anon (container)\r\n /qtest (qtest)\r\n
/unattached (container)\r\n /device[0] (elroy-pcihost)\r\n /elroy[0]
(memory-region)\r\n /pci (PCI)\r\n /pci-conf-data[0]
(memory-region)\r\n /pci-conf-idx[0] (memory-region)\r\n
/pci-isa-mmio[0] (memory-region)\r\n /pci-mmio-alias[0]
(memory-region)\r\n /pci-mmio[0] (memory-region)\r\n
/unnamed-gpio-in[0] (irq)\r\n /unnamed-gpio-in[1] (irq)\r\n
/unnamed-gpio-in[2] (irq)\r\n /unnamed-gpio-in[3] (irq)\r\n
/unnamed-gpio-in[4] (irq)\r\n /unnamed-gpio-in[5] (irq)\r\n
/unnamed-gpio-in[6] (irq)\r\n /unnamed-gpio-in[7] (irq)\r\n /device[1]
(elroy-pcihost)\r\n /elroy[0] (memory-region)\r\n /pci (PCI)\r\n
/pci-conf-data[0] (memory-region)\r\n /pci-conf-idx[0]
(memory-region)\r\n /pci-isa-mmio[0] (memory-region)\r\n
/pci-mmio-alias[0] (memory-region)\r\n /pci-mmio[0]
(memory-region)\r\n /unnamed-gpio-in[0] (irq)\r\n /unnamed-gpio-in[1]
(irq)\r\n /unnamed-gpio-in[2] (irq)\r\n /unnamed-gpio-in[3] (irq)\r\n
/unnamed-gpio-in[4] (irq)\r\n /unnamed-gpio-in[5] (irq)\r\n
/unnamed-gpio-in[6] (irq)\r\n /unnamed-gpio-in[7] (irq)\r\n /device[2]
(elroy-pcihost)\r\n /elroy[0] (memory-region)\r\n /pci (PCI)\r\n
/pci-conf-data[0] (memory-region)\r\n /pci-conf-idx[0]
(memory-region)\r\n /pci-isa-mmio[0] (memory-region)\r\n
/pci-mmio-alias[0] (memory-region)\r\n /pci-mmio[0]
(memory-region)\r\n /unnamed-gpio-in[0] (irq)\r\n /unnamed-gpio-in[1]
(irq)\r\n /unnamed-gpio-in[2] (irq)\r\n /unnamed-gpio-in[3] (irq)\r\n
/unnamed-gpio-in[4] (irq)\r\n /unnamed-gpio-in[5] (irq)\r\n
/unnamed-gpio-in[6] (irq)\r\n /unnamed-gpio-in[7] (irq)\r\n /device[3]
(elroy-pcihost)\r\n /elroy[0] (memory-region)\r\n /pci (PCI)\r\n
/pci-conf-data[0] (memory-region)\r\n /pci-conf-idx[0]
(memory-region)\r\n /pci-isa-mmio[0] (memory-region)\r\n
/pci-mmio-alias[0] (memory-region)\r\n /pci-mmio[0]
(memory-region)\r\n /unnamed-gpio-in[0] (irq)\r\n /unnamed-gpio-in[1]
(irq)\r\n /unnamed-gpio-in[2] (irq)\r\n /unnamed-gpio-in[3] (irq)\r\n
/unnamed-gpio-in[4] (irq)\r\n /unnamed-gpio-in[5] (irq)\r\n
/unnamed-gpio-in[6] (irq)\r\n /unnamed-gpio-in[7] (irq)\r\n /device[4]
(elroy-pcihost)\r\n /elroy[0] (memory-region)\r\n /pci (PCI)\r\n
/pci-conf-data[0] (memory-region)\r\n /pci-conf-idx[0]
(memory-region)\r\n /pci-isa-mmio[0] (memory-region)\r\n
/pci-mmio-alias[0] (memory-region)\r\n /pci-mmio[0]
(memory-region)\r\n /unnamed-gpio-in[0] (irq)\r\n /unnamed-gpio-in[1]
(irq)\r\n /unnamed-gpio-in[2] (irq)\r\n /unnamed-gpio-in[3] (irq)\r\n
/unnamed-gpio-in[4] (irq)\r\n /unnamed-gpio-in[5] (irq)\r\n
/unnamed-gpio-in[6] (irq)\r\n /unnamed-gpio-in[7] (irq)\r\n /device[5]
(elroy-pcihost)\r\n /elroy[0] (memory-region)\r\n /pci (PCI)\r\n
/pci-conf-data[0] (memory-region)\r\n /pci-conf-idx[0]
(memory-region)\r\n /pci-isa-mmio[0] (memory-region)\r\n
/pci-mmio-alias[0] (memory-region)\r\n /pci-mmio[0]
(memory-region)\r\n /unnamed-gpio-in[0] (irq)\r\n /unnamed-gpio-in[1]
(irq)\r\n /unnamed-gpio-in[2] (irq)\r\n /unnamed-gpio-in[3] (irq)\r\n
/unnamed-gpio-in[4] (irq)\r\n /unnamed-gpio-in[5] (irq)\r\n
/unnamed-gpio-in[6] (irq)\r\n /unnamed-gpio-in[7] (irq)\r\n /device[6]
(elroy-pcihost)\r\n /elroy[0] (memory-region)\r\n /pci (PCI)\r\n
/pci-conf-data[0] (memory-region)\r\n /pci-conf-idx[0]
(memory-region)\r\n /pci-isa-mmio[0] (memory-region)\r\n
/pci-mmio-alias[0] (memory-region)\r\n /pci-mmio[0]
(memory-region)\r\n /unnamed-gpio-in[0] (irq)\r\n /unnamed-gpio-in[1]
(irq)\r\n /unnamed-gpio-in[2] (irq)\r\n /unnamed-gpio-in[3] (irq)\r\n
/unnamed-gpio-in[4] (irq)\r\n /unnamed-gpio-in[5] (irq)\r\n
/unnamed-gpio-in[6] (irq)\r\n /unnamed-gpio-in[7] (irq)\r\n /device[7]
(elroy-pcihost)\r\n /elroy[0] (memory-region)\r\n /pci (PCI)\r\n
/pci-conf-data[0] (memory-region)\r\n /pci-conf-idx[0]
(memory-region)\r\n /pci-isa-mmio[0] (memory-region)\r\n
/pci-mmio-alias[0] (memory-region)\r\n /pci-mmio[0]
(memory-region)\r\n /unnamed-gpio-in[0] (irq)\r\n /unnamed-gpio-in[1]
(irq)\r\n /unnamed-gpio-in[2] (irq)\r\n /unnamed-gpio-in[3] (irq)\r\n
/unnamed-gpio-in[4] (irq)\r\n /unnamed-gpio-in[5] (irq)\r\n
/unnamed-gpio-in[6] (irq)\r\n /unnamed-gpio-in[7] (irq)\r\n /io[0]
(memory-region)\r\n /sysbus (System)\r\n /system[0]
(memory-region)\r\n") ERROR

266/841 qemu:qtest+qtest-hppa / qtest-hppa/device-introspect-test
ERROR 1.60s killed by signal 6 SIGABRT

https://gitlab.com/qemu-project/qemu/-/jobs/5332200642

Stefan

