Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 560A2709C3A
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 18:15:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q02l7-0002r6-1X; Fri, 19 May 2023 12:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1q02ks-0002pq-PM
 for qemu-devel@nongnu.org; Fri, 19 May 2023 12:14:58 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1q02kg-00065Z-Ld
 for qemu-devel@nongnu.org; Fri, 19 May 2023 12:14:58 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-199dd37f0e4so2596933fac.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 09:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1684512884; x=1687104884;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Tq6xfwT5cHquy+MPJLoYTkt26hrJyZpju4pMec1VbH8=;
 b=MZWjl6MfCU5ot2ibae3EjTT8AsscGhUcenXnV7cjH6/5QK5O5bL9uMbEN3gOyuWgZ9
 J+YMt1eWT5q7Qn4cCVwTQhhVER0X4oD7nECDK+6j12kyNe7i8Ivx6NV5Uy0+trh49rNv
 jP53GH+1xjjYZIKpO7eEcAL4hsJ5wQJnB8Dlrq7nvbmuS7dGuCSHWLgXXsb3d6qIx0l6
 KnnjfsXspi/gShqbEbApc77IrldaJPBko84mY0VnC9lLbSiF8qzwfZvDHZMTTAhX3uMz
 V5v41bVr0rgMIzZHAmQ3W0aqnTUAv6nnE9YcSzexHCQMID3eXhWR0SaiiiL1RKtUfaEP
 mxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684512884; x=1687104884;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tq6xfwT5cHquy+MPJLoYTkt26hrJyZpju4pMec1VbH8=;
 b=UxDKTdHLh7dIGEgycqXXuKx4CuIAoXq2gzUejpCN6BuQG5bG9TqxbztBMvzMWjMwgZ
 6gjUm/lQwvHWvQV2J05Zftzr21ubfr7wtmMxXKD1EKRtutThRZpLpBczI+H97p8HBSWI
 VHGaK4sXiVIsL5pTE/bPPjw6mdCs3MerOO6et7D+k5poGC6VB82JjXStsCbHihzODmFT
 MuCspT9qgP6Q2bTedoQjVRwkQ7rrMWfW5IE8FgPruda2g7lea3x05WAopLyl/cfs9Frc
 Voz/ZKrIYwDTq5sp4vg+xecOaBmxs6QJFr3TA8h/yWXX1+Af0xtpDxzibQFMIZ1LMZ4j
 fOQw==
X-Gm-Message-State: AC+VfDybfuIY5iw7JjrLr7Pz8P3wRJycbCbTePv80yASkOlmIvgqQJaN
 vCbxK3bd5BDrn/qan0pnwR1YsQ==
X-Google-Smtp-Source: ACHHUZ5lOcBc3CSo6y0CP5FTVmpFNOVeZCTiiR9faPjHi/JKkUFXfZEhiL+gFThlyXIFZh9xGU14VA==
X-Received: by 2002:a05:6871:4694:b0:195:f440:40e9 with SMTP id
 ni20-20020a056871469400b00195f44040e9mr1912929oab.31.1684512884603; 
 Fri, 19 May 2023 09:14:44 -0700 (PDT)
Received: from sunil-laptop ([106.51.191.118])
 by smtp.gmail.com with ESMTPSA id
 bd6-20020a056870d78600b00172ac40356csm2080793oab.50.2023.05.19.09.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 09:14:43 -0700 (PDT)
Date: Fri, 19 May 2023 21:44:36 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2] hw/riscv: virt: Assume M-mode FW in pflash0 only when
 "-bios none"
Message-ID: <ZGegbFr7EBanur1R@sunil-laptop>
References: <20230425102545.162888-1-sunilvl@ventanamicro.com>
 <CABJz62Og-9mVUfBKExMU1MG=UD7mnOKsdpeuEvXpoPTVn8TS7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABJz62Og-9mVUfBKExMU1MG=UD7mnOKsdpeuEvXpoPTVn8TS7A@mail.gmail.com>
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-oa1-x2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, May 19, 2023 at 09:11:37AM -0700, Andrea Bolognani wrote:
> On Tue, Apr 25, 2023 at 03:55:45PM +0530, Sunil V L wrote:
> > qemu-system-riscv64 -bios <opensbi_fw> \
> > -drive file=<smode_fw_vars>,if=pflash,format=raw,unit=0 \
> > -drive file=<smode_fw_code>,if=pflash,format=raw,unit=1,readonly=on  \
> > -machine virt
> 
> I've noticed that edk2 for RISC-V, at least in the form it is
> currently packaged for Fedora, doesn't seem to have separate CODE and
> VARS files:
> 
>   $ ls /usr/share/edk2/riscv/* | cat
>   /usr/share/edk2/riscv/RISCV_VIRT.fd
>   /usr/share/edk2/riscv/RISCV_VIRT.raw
> 
> Is that something that needs to be addressed in upstream edk2? If so,
> will you be looking into it?
> 
Hi Andrea,

Yes, I have changes ready but before I submit EDK2 patches, I need qemu
changes merged which enables EDK2 to use both pflash.

Thanks,
Sunil

