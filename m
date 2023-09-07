Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31191797251
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 14:32:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEAp-0002fm-FE; Thu, 07 Sep 2023 08:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qeEAS-0002S3-5P
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 08:31:28 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qeEAN-0007cR-39
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 08:31:26 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-402d499580dso10297025e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 05:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694089880; x=1694694680; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lS5AVmG1mGfnRWRcE7iGI0zXLsxr6HHGOJcea+3Df2Q=;
 b=FrxPSB1N/+8Bc46bI+S6/+Lxaz/3tVnv+PrkChabrkvSqJ+83n7TQJCITkXM1HhXSH
 c9YpdlXha9UEGvH4rDO0KuIlEtHXeLWovLcKl4yIGQr8bP4UHdssmoPAX+xvOQt8FM1C
 tyqbHduOQ/vbBEwpA6KYQ85IxgOAw21RWnL/GNbnOev2AVSvIKHx/UEZ5dz5P5CV0u4Z
 9kYkfS9O/Toc1/+HI4G4ZGzSfCIpoLxMgpcyOMBdEfp4G2RDlsDXaKxjPX8o6DCA7yKR
 X+MfnqxMWnQ1kdBbfZNSYCLYhTesN2ATHNPeSLlApZb/UdK0K95aEyr2ZXp6ZefENN17
 49vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694089880; x=1694694680;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lS5AVmG1mGfnRWRcE7iGI0zXLsxr6HHGOJcea+3Df2Q=;
 b=PFz27wOicXhBMITiSVA2w7CFFV1fZLIvLNORQavketLToy5QEBsrrM0EeoH0JvY+yc
 MkIjnYQ3kSaJH7Aw5fVdUoCJ4JcuB6CCAALr6uNbxoTCPgZraRvOZQz5Srh5VF/CLDAU
 yj/z7ngnVE4Kev64gs7CZWuJB/z3oEZnFczMjXpLfDY5MmGEnuJKUv3Nzp911izq/UZE
 tR+4UQEDm7ZJYFtxVgjz5JEUqBIFSqC+0C2wYRGF5qNqy6aAbHPFBKei4lUGmxhxUBnj
 LmOToA38XrrAkNYX6evux5nuXnG4LPLzCJpFcAuekGyOnPgXwd25p71gdJjfiWMm5/vC
 d72w==
X-Gm-Message-State: AOJu0YynKiRK+Kyepp7oeB5cDoIp9cq82Fu/UNNgd+g5n7NteIu/6j+0
 fyBBfyUDqwB73W+ZEjWmggRvEg==
X-Google-Smtp-Source: AGHT+IFp6REPghLc4J97XMM/U7vMzGvG0saFE+teHjWJQgBLVXiN/jSR4/RbEujqW20zhHcMRTz7yw==
X-Received: by 2002:adf:f6cc:0:b0:317:5c36:913b with SMTP id
 y12-20020adff6cc000000b003175c36913bmr4692234wrp.48.1694089880483; 
 Thu, 07 Sep 2023 05:31:20 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 s12-20020a5d4ecc000000b0031423a8f4f7sm23401316wrv.56.2023.09.07.05.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 05:31:19 -0700 (PDT)
Date: Thu, 7 Sep 2023 14:31:18 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, palmer@dabbelt.com, 
 bin.meng@windriver.com, peter.maydell@linaro.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] docs/devel: Add cross-compiling doc
Message-ID: <20230907-6262b40a0a352bdce53999e3@orel>
References: <20230907084604.253347-2-ajones@ventanamicro.com>
 <87sf7q1djr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sf7q1djr.fsf@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x329.google.com
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

On Thu, Sep 07, 2023 at 11:20:55AM +0100, Alex Bennée wrote:
> 
> Andrew Jones <ajones@ventanamicro.com> writes:
> 
> > Add instructions for how to cross-compile QEMU for RISC-V. The
> > file is named generically because there's no reason not to collect
> > other architectures steps into the same file, especially because
> > several subsections like those for cross-compiling QEMU dependencies
> > using meson and a cross-file could be shared. Additionally, other
> > approaches to creating sysroots, such as with debootstrap, may be
> > documented in this file in the future.
> >
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  docs/devel/cross-compiling.rst | 221 +++++++++++++++++++++++++++++++++
> >  docs/devel/index-build.rst     |   1 +
> >  2 files changed, 222 insertions(+)
> >  create mode 100644 docs/devel/cross-compiling.rst
> >
> > diff --git a/docs/devel/cross-compiling.rst b/docs/devel/cross-compiling.rst
> > new file mode 100644
> > index 000000000000..1b988ba54e4c
> > --- /dev/null
> > +++ b/docs/devel/cross-compiling.rst
> > @@ -0,0 +1,221 @@
> > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +====================
> > +Cross-compiling QEMU
> > +====================
> > +
> > +Cross-compiling QEMU first requires the preparation of a cross-toolchain
> > +and the cross-compiling of QEMU's dependencies. While the steps will be
> > +similar across architectures, each architecture will have its own specific
> > +recommendations.
> 
> "some architectures" - most of the cross compile stuff is hidden away by
> the build system on systems with appropriate development libraries
> installed. I think we would be remiss if we didn't just outline the
> common case:
> 
>    ../configure --cross-prefix=riscv64-linux-gnu-
> 
> I think we could make it clearer that in most cases you don't need to
> prepare and cross-compile a bunch of dependencies lest we send
> developers down a rabbit hole.
> 
> Maybe build-system.rst be updated and this reference it for the common
> case?
> 

Hi Alex,

tl;dr, I'd welcome instructions helping people get cross-arch development
libraries installed without having to build them. I wouldn't make a good
author for those instructions, though, since I don't know how.

I'm guessing the dependencies can be installed with a distro's package
management, assuming the package management supports cross-arch
installation and installing to a specified root directory. I'm on Fedora,
so I just tried

 $ sudo dnf install --forcearch=aarch64 --installroot=$SYSROOT --releasever=36 glib2-devel

but it wanted to install a huge number of packages, which most people
probably wouldn't want to do. Maybe that command isn't what you had in
mind or other distros can manage this better. I'm all ears.

Thanks,
drew

