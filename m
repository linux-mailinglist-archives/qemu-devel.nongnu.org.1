Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C3A7A8712
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 16:37:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiyJw-0004kQ-9a; Wed, 20 Sep 2023 10:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1qiyJo-0004UZ-P4; Wed, 20 Sep 2023 10:36:45 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1qiyJj-0001z6-Eb; Wed, 20 Sep 2023 10:36:41 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5717f7b932aso4372967eaf.0; 
 Wed, 20 Sep 2023 07:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695220597; x=1695825397; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6tsMZWef5DNnUlUhJEtp0wEaK+tiZcAN1lRlJlCbjY8=;
 b=IW3uU8CeNMJ7b9pcSrAjiY0j0+xZHuVrpqUH9ojSaxm4p10AQ4L2I1A5oBHcyXxsZ+
 0Nn/+zqzLTuhznfftJZiArkV81dGHCSFrWmDT0bcQCCpMFYC4DJixzu39Sj+hMPjCxv7
 NBvXe+W7snXKYuSTeCO2ZQGSupkKsjropaUkMbKDpqVEWqcWagTgIDgkNisn40dNa6L3
 l6eVFjeqHYNmTvhT4JlGQIYsWVaBZwJi75ejM5wD0VIo83eUJLRuzCerifvP5hQGSwdu
 StyYgA8E4qud0Rti/v1KNtNrfVI8OBtE86e01bV1ReKCFTSLdcrMS8/+cGUabCi7i2W0
 GpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695220597; x=1695825397;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6tsMZWef5DNnUlUhJEtp0wEaK+tiZcAN1lRlJlCbjY8=;
 b=mbeb8Xb4RG6cDDaPf1UDzbJIDhCoq8+kMvExMw0BcEgAvQR3udg4EKAYhiZ5CeBMuw
 doj1bgtrgcYlzUDuy4YitRC+0wM3AT8YNfPMLV8nI/YEzi0+NdQsI4RZEo50E4WwdEZJ
 pmEZkIOL9gwSgRGqHQWhyub0xW5WnmtQtin33DxeeZO6aSAKo450ZrHnIJRcS0DyIdOM
 OTaCiVPZ6+9ptFKX8H3EaXrEyPrOtang0PQ4Vop4DDGehPZHdo6ChRmrY/NpBxXE2dGb
 umNfrQgEtayQeZszJ/FyHH7GlGRpkAlQWu6s/YwjwCZnbShlMLxaqbElaVIWEMoC+3SY
 D4fQ==
X-Gm-Message-State: AOJu0YxXwzodx1t3oz1DZKeeesYKDWnJTfnCwx/QtSPOv+EthLhwpj/I
 peGelDYkIXVdCrV0nb+sOQ==
X-Google-Smtp-Source: AGHT+IEwGelVBN2V1nrZgiY0qlR+4g+FG/hu7oZAah4qVKfYpqKYleh0IncPm14ipDCP7EG3f+ksYQ==
X-Received: by 2002:a05:6870:c088:b0:1be:dfdf:cb1 with SMTP id
 c8-20020a056870c08800b001bedfdf0cb1mr3049150oad.46.1695220597140; 
 Wed, 20 Sep 2023 07:36:37 -0700 (PDT)
Received: from serve.minyard.net ([47.189.89.62])
 by smtp.gmail.com with ESMTPSA id
 ec1-20020a0568708c0100b001d4d8efa7f9sm7264835oab.4.2023.09.20.07.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 07:36:36 -0700 (PDT)
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1d::35])
 by serve.minyard.net (Postfix) with ESMTPSA id 94BC81800BD;
 Wed, 20 Sep 2023 14:36:35 +0000 (UTC)
Date: Wed, 20 Sep 2023 09:36:34 -0500
From: Corey Minyard <minyard@acm.org>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Corey Minyard <cminyard@mvista.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Lior Weintraub <liorw@pliops.com>, Jeremy Kerr <jk@codeconstruct.com.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Peter Delevoryas <peter@pjd.dev>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v6 0/3] hw/{i2c,nvme}: mctp endpoint, nvme management
 interface model
Message-ID: <ZQsDcmkZYCk0eVhA@mail.minyard.net>
References: <20230914-nmi-i2c-v6-0-11bbb4f74d18@samsung.com>
 <20230920124803.00005ae9@Huawei.com>
 <ZQrrgxHrfzmGyhZU@mail.minyard.net>
 <ZQr0LXsSRXGqJ4EL@cormorant.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQr0LXsSRXGqJ4EL@cormorant.local>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=tcminyard@gmail.com; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: minyard@acm.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Sep 20, 2023 at 06:31:25AM -0700, Klaus Jensen wrote:
> On Sep 20 07:54, Corey Minyard wrote:
> > On Wed, Sep 20, 2023 at 12:48:03PM +0100, Jonathan Cameron via wrote:
> > > On Thu, 14 Sep 2023 11:53:40 +0200
> > > Klaus Jensen <its@irrelevant.dk> wrote:
> > > 
> > > > This adds a generic MCTP endpoint model that other devices may derive
> > > > from.
> > > > 
> > > > Also included is a very basic implementation of an NVMe-MI device,
> > > > supporting only a small subset of the required commands.
> > > > 
> > > > Since this all relies on i2c target mode, this can currently only be
> > > > used with an SoC that includes the Aspeed I2C controller.
> > > > 
> > > > The easiest way to get up and running with this, is to grab my buildroot
> > > > overlay[1] (aspeed_ast2600evb_nmi_defconfig). It includes modified a
> > > > modified dts as well as a couple of required packages.
> > > > 
> > > > QEMU can then be launched along these lines:
> > > > 
> > > >   qemu-system-arm \
> > > >     -nographic \
> > > >     -M ast2600-evb \
> > > >     -kernel output/images/zImage \
> > > >     -initrd output/images/rootfs.cpio \
> > > >     -dtb output/images/aspeed-ast2600-evb-nmi.dtb \
> > > >     -nic user,hostfwd=tcp::2222-:22 \
> > > >     -device nmi-i2c,address=0x3a \
> > > >     -serial mon:stdio
> > > > 
> > > > From within the booted system,
> > > > 
> > > >   mctp addr add 8 dev mctpi2c15
> > > >   mctp link set mctpi2c15 up
> > > >   mctp route add 9 via mctpi2c15
> > > >   mctp neigh add 9 dev mctpi2c15 lladdr 0x3a
> > > >   mi-mctp 1 9 info
> > > > 
> > > > Comments are very welcome!
> > > > 
> > > >   [1]: https://github.com/birkelund/hwtests/tree/main/br2-external
> > > > 
> > > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > > 
> > > Hi Klaus,
> > > 
> > > Silly question, but who is likely to pick this up? + likely to be soon?
> > > 
> > > I'm going to post the CXL stuff that makes use of the core support shortly
> > > and whilst I can point at this patch set on list, I'd keen to see it upstream
> > > to reduce the dependencies (it's got 2 sets ahead of it of CXL stuff
> > > anyway but that will all hopefully go through Michael Tsirkin's tree
> > > for PCI stuff in one go).
> > 
> > I can pick it up, but he can just request a merge, too.
> > 
> > I did have a question I asked earlier about tests.  It would be unusual
> > at this point to add something like this without having some tests,
> > especially injecting invalid data.
> > 
> 
> Hi all,
> 
> Sorry for the late reply. I'm currently at SDC, but I will write up some
> tests when I get back to in the office on Monday.
> 
> Corey, what kinds of tests would be best here? Avocado "acceptance"
> tests or would you like to see something lower level?

My main concern is testing what happens when bad data gets injected, to
avoid people coming up with clever names for exploits in qemu.  It's not
so much for this code, it's for the changes that comes in the future.

And, of course, normal functional tests to make sure it works.  What a
friend of mine calls "dead chicken" tests.  You wave a dead chicken at
it, and if the chicken is still dead everything is ok :).

I'm fine with either type of tests, but I'm not sure you can do this
with avocado.  It's probably about the same amount of work either path
you choose.

-corey

