Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B91A7BD1F
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Apr 2025 15:01:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0gfg-0008Tb-D3; Fri, 04 Apr 2025 09:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u0gfV-0008Nf-Ih
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 09:01:13 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u0gfS-00037F-5U
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 09:01:09 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3914a5def6bso1251653f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 06:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1743771663; x=1744376463; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q3nlRM217rRS4PnJ/8Qmg/adVq+zK7QrFPF7tsXn14k=;
 b=i/cwGrIMGsZmWCX/giapMRIxQ3gB7fdWpoF26h43pANDcjkkgnIXAeQPLT2zSudUte
 ajVaox5eTmgvCghGiuybRjAkme1/nrG3CDIBac1qHYXj9+1ZUxlXwaqV4IRKtELZkLCK
 vDpt9rZgpFZwVuPL6UIowVG+eZQnjQZ8go6xjROGuI4FAC5iVPiiKVN1PA8C9c63/YgF
 aAxmaOE3xuCoJR6mygZXYmIL2yljiYWgFyLwS/5qXz7cRaOwyIguHETXGdPvLbB4+F2l
 9tW7bXuDkjaGbjVGPpdcLkWyDdUDBMk0Jcb439IIZ9O6Gw0CrJvA0X7BfMwxvShYTX4S
 MYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743771663; x=1744376463;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3nlRM217rRS4PnJ/8Qmg/adVq+zK7QrFPF7tsXn14k=;
 b=Qq4ve6IXM3+lyYs5D3Pc5xF9WTCHgEUqAQZTQ2QocEA3VW24szBvckI898zeo8YW1n
 ftJRJ0ku39CkCkMamYkm2PCiaN4RRNMDUtY3BgCdDc/j1/1S+tYbt3IkxWjaMenUgiOg
 EqkKkIwIt6infLwiz3FWhyw9V2ZaIHk956ZwKPeK3X3SqMl1MKM5F8FKZZPI54mVnJvy
 IccZxAqYDQHJ0C6SpxHuNkdSYQ1H0heLgP9dzfUzrYUyZQhf9HoYcAm3h0d6HAQsYjVh
 VetG00bxwhrEaxoQl56VR8jXb1UoSLTry46LZ792P4N9ZDGU5dYrWls7knnOJGoIFgaq
 rUFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/m3kwxDoF9l3dRmRUGZ6C9NPwvSQlvWZOO8Lvah5xAccvT88RWFzAOM8cMvtOi7t0ZYXbVwuz57gP@nongnu.org
X-Gm-Message-State: AOJu0Yx/WWVH0l987aOgZygfZl/I993htzMcEIcHYHTCOO2b3+id0lVc
 Yb1lhg9S3aIJWLjLLG8jzVlaBw1jHpHTF6p/7l9HOgNAuO65IeiF5xfDPGYMuTJ4FeaIn6JBydu
 X
X-Gm-Gg: ASbGncvSveouAuqWbyp8ROVtjEBHPOhvjUlgVb+ESq6AM9XckZsVPTMnsJyAMWOUfpw
 Vyn/LYKgI0+5Wo5FAqGBJTnxTDHHjbkK+il8nBZI1G3d9F+77Ltw/DRK02IQN2o5bxWDq7Ben7R
 mB7coIqudE0vVBGd6T5oDXVwDseasP3VL1usWJpT1U64Xri7yZZSuU46DGqZP5yFNW3OqUNGmLk
 H6bMvYng0hlA9Md+gyJCV1k6DS6VZMpjoUkQ33ee7CV0DnuJnVhZrgvE1xsTh65IdyIrH11kOba
 NtXjgFLxuac4cyGpshMTTIFt4mcV59QNx6/GrF5CBuRxj7TmcFjOBEWxzgwuiG/BL0+WuXi0/w=
 =
X-Google-Smtp-Source: AGHT+IHrX3wdWdiaYbCseq8nnB6UkuEqHGUpBvL7QbEr9+GNfd9zyswHzFXFct/QY3cLhjuNrFQBzg==
X-Received: by 2002:a05:6000:2a06:b0:39c:1257:c96d with SMTP id
 ffacd0b85a97d-39cba9442bdmr1624467f8f.57.1743771662727; 
 Fri, 04 Apr 2025 06:01:02 -0700 (PDT)
Received: from localhost (cst2-173-28.cust.vodafone.cz. [31.30.173.28])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226dfesm4356352f8f.97.2025.04.04.06.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 06:01:02 -0700 (PDT)
Date: Fri, 4 Apr 2025 15:01:00 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH for-10.1] hw/riscv: do not mark any machine as default
Message-ID: <20250404-bb01d18c3e47c6ae57ca3e78@orel>
References: <20250327130256.653357-1-dbarboza@ventanamicro.com>
 <19d7409d-35a0-486f-a626-9d382fb8a6bf@linaro.org>
 <CAKmqyKPsRvaVztUdPRwf5h90rVdT9MOrvQz_=WvoEj-bWoTWVg@mail.gmail.com>
 <65b3fa18-0f04-4cf8-8d21-ecef180f2fcc@ventanamicro.com>
 <c8df891c-c0bb-4a19-bc13-ef128ed222ae@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8df891c-c0bb-4a19-bc13-ef128ed222ae@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x42e.google.com
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

On Fri, Apr 04, 2025 at 02:37:32PM +0200, Philippe Mathieu-Daudé wrote:
> On 4/4/25 13:30, Daniel Henrique Barboza wrote:
> > 
> > 
> > On 4/4/25 2:50 AM, Alistair Francis wrote:
> > > On Fri, Mar 28, 2025 at 2:16 AM Philippe Mathieu-Daudé
> > > <philmd@linaro.org> wrote:
> > > > 
> > > > On 27/3/25 14:02, Daniel Henrique Barboza wrote:
> > > > > Commit 5b4beba124 ("RISC-V Spike Machines") added the Spike machine and
> > > > > made it default for qemu-system-riscv32/64. It was the first RISC-V
> > > > > machine added in QEMU so setting it as default was sensible.
> > > > > 
> > > > > Today we have 7 risc64 and 6 riscv32 machines and having 'spike' as
> > > > > default machine is not intuitive. For example, [1] is a bug that was
> > > > > opened with the 'virt' board in mind, but given that the user didn't
> > > > > pass a '-machine' option, the user was using 'spike' without knowing.
> > > > > 
> > > > > The QEMU archs that defines a default machine usually defines it as the
> > > > > most used machine, e.g. PowerPC uses 'pseries' as default. So in theory
> > > > > we could change the default to the 'virt' machine, but that would make
> > > > > existing command lines that don't specify a machine option to act
> > > > > weird: they would silently use 'virt' instead of 'spike'.
> > > > > 
> > > > > Being explicit in the command line is desirable when we have a handful
> > > > > of boards available, so remove the default machine setting from RISC-V
> > > > > and make it obligatory to specify the board.
> > > > > 
> > > > > After this patch we'll throw an error if no machine is specified:
> > > > > 
> > > > > $ ./build/qemu-system-riscv64 --nographic qemu-system-riscv64: No
> > > > > machine specified, and there is no default Use -machine help to list
> > > > > supported machines
> > > > > 
> > > > > 'spike' users that aren't specifying their machines in the command line
> > > > > will be impacted and will need to add '-M spike' in their scripts.
> > > > > 
> > > > > [1] https://gitlab.com/qemu-project/qemu/-/issues/2467
> > > > > 
> > > > > Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > > > > ---
> > > > >    hw/riscv/spike.c | 1 -
> > > > >    1 file changed, 1 deletion(-)
> > > > 
> > > > I'm in favor of this change, which I believe is the correct way to
> > > > go, so:
> > > 
> > > Agreed
> > > 
> > > > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > but I'd rather we follow the deprecation process. Up to the maintainer.
> > > 
> > > I agree, it is a breaking change, it would be nice to go through the
> > > deprecation process in case people are expecting Spike to be the
> > > default.
> > 
> > I don't mind going through the deprecation process in this case since we're
> > not just eliminating a default value, we're removing it.
> > 
> > What about other default val related changes, e.g. do we have to go
> > through\
> > the deprecation process to change the default CPU of a board? And yeah,
> > spoiler alert :D
> 

I don't think we need the deprecation process to change a board's default
cpu type from a generic type which is a strict subset of the type to which
we change (rv64 -> max). While changing to a superset may change behavior
(things that didn't work before will suddenly start working) generic cpu
types have always had the freedom to add new extensions. If we want to
avoid all behavior changes, then we'll need to start versioning the
generic cpu types (which might not be such a bad idea).

> I think so. My preference to avoid this is to remove default values ;)
>

I personally don't mind not having a default cpu type for the virt board,
but, if we want one, then I think the max cpu type makes the most sense
(like arm64 has).

Thanks,
drew

