Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA5F7A820D
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 14:55:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiwiz-00040v-Sp; Wed, 20 Sep 2023 08:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1qiwix-00040H-KB; Wed, 20 Sep 2023 08:54:35 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1qiwiv-0005YN-6Y; Wed, 20 Sep 2023 08:54:35 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6c0b8f42409so4089248a34.0; 
 Wed, 20 Sep 2023 05:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695214471; x=1695819271; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YLHzCQ8Xo73qNN6wxL1sFWjkQUlZ/9hp+7fQkgZXQAM=;
 b=HNGRvmLGPLv87cYngz3x7Zf2R5kPr/5n55bn0PNDkYBOnWD3sMWAUv5JpEHzC5js3f
 0INP6zScRO+Jh2eEwtunOLMyXH3V2plWXWiarxo7FNu/bkJ46v0hcbEKAHLVRQeNl8d+
 mxtW8++u0KJJD/U85FFZe1f7uzzyEvloODRC0d7W80W7VfmxsP4ptqTj7cWt2D1OLwfT
 c4b2x2RvmWvezeVzyzJTU3oc1odtp8OzL4ShAQ3pITEq2X1QqMpASwrkKdM6WQsoNm7q
 HUysz3KAm3eAvlA8n92jYZDKj+Jw38OMk2WR5bcrOZygEL/O5Iz5zwEbznu9Y9UjjBPn
 HqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695214471; x=1695819271;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YLHzCQ8Xo73qNN6wxL1sFWjkQUlZ/9hp+7fQkgZXQAM=;
 b=Nbn20SExX7HGiinQiUtoRRFJ8RL/2VNRcNON6hJeJfPhrMg72cb/bA/CJ3zmF/vQP1
 c9jr00z4QbrQumdqU1SWNQygCysZn17sxANaMFNMyJ1Yk2/L6v8lJHMgw2C/1YgxZYPx
 WmE6hvi3hQQtWEg2f+QPShuaixiT2oZHmI69XbYXzubVFVEkhHqjufnn+PX/Xa3BjGFB
 evEw0zTVAEYydL2YfKKwk6cCbe1k0EkfAIP/35NqlXOVuF5ijqGWjho6r98J+M+CncEX
 pG6pW68wYN8yBYZw/yVZ++87Aev7SiWFFKwAwUCiKsEMWWlNQKtkYEZsXdGC/tF7YNv+
 17/g==
X-Gm-Message-State: AOJu0YyCMT8lreTG7e9E+aNWr1lNE7OkGxKsu8QCJpNIJ15lfhVv6poQ
 JBu3TKIY1FzpV8PcRQHk2Q==
X-Google-Smtp-Source: AGHT+IFKBEGE1U73aS2zTs1THqHoV3gvJgvfQ7Ajs2q3YxaWLxud1JXtarODMHJTx3tqHncdyFLBCg==
X-Received: by 2002:a05:6830:c89:b0:6c4:7696:e89 with SMTP id
 bn9-20020a0568300c8900b006c476960e89mr572327otb.6.1695214470747; 
 Wed, 20 Sep 2023 05:54:30 -0700 (PDT)
Received: from serve.minyard.net ([47.189.89.62])
 by smtp.gmail.com with ESMTPSA id
 s189-20020a4a51c6000000b0056e67f2f92asm6627814ooa.22.2023.09.20.05.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 05:54:30 -0700 (PDT)
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1d::35])
 by serve.minyard.net (Postfix) with ESMTPSA id EC2C81800E8;
 Wed, 20 Sep 2023 12:54:28 +0000 (UTC)
Date: Wed, 20 Sep 2023 07:54:27 -0500
From: Corey Minyard <minyard@acm.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Klaus Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
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
Message-ID: <ZQrrgxHrfzmGyhZU@mail.minyard.net>
References: <20230914-nmi-i2c-v6-0-11bbb4f74d18@samsung.com>
 <20230920124803.00005ae9@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920124803.00005ae9@Huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=tcminyard@gmail.com; helo=mail-ot1-x32f.google.com
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

On Wed, Sep 20, 2023 at 12:48:03PM +0100, Jonathan Cameron via wrote:
> On Thu, 14 Sep 2023 11:53:40 +0200
> Klaus Jensen <its@irrelevant.dk> wrote:
> 
> > This adds a generic MCTP endpoint model that other devices may derive
> > from.
> > 
> > Also included is a very basic implementation of an NVMe-MI device,
> > supporting only a small subset of the required commands.
> > 
> > Since this all relies on i2c target mode, this can currently only be
> > used with an SoC that includes the Aspeed I2C controller.
> > 
> > The easiest way to get up and running with this, is to grab my buildroot
> > overlay[1] (aspeed_ast2600evb_nmi_defconfig). It includes modified a
> > modified dts as well as a couple of required packages.
> > 
> > QEMU can then be launched along these lines:
> > 
> >   qemu-system-arm \
> >     -nographic \
> >     -M ast2600-evb \
> >     -kernel output/images/zImage \
> >     -initrd output/images/rootfs.cpio \
> >     -dtb output/images/aspeed-ast2600-evb-nmi.dtb \
> >     -nic user,hostfwd=tcp::2222-:22 \
> >     -device nmi-i2c,address=0x3a \
> >     -serial mon:stdio
> > 
> > From within the booted system,
> > 
> >   mctp addr add 8 dev mctpi2c15
> >   mctp link set mctpi2c15 up
> >   mctp route add 9 via mctpi2c15
> >   mctp neigh add 9 dev mctpi2c15 lladdr 0x3a
> >   mi-mctp 1 9 info
> > 
> > Comments are very welcome!
> > 
> >   [1]: https://github.com/birkelund/hwtests/tree/main/br2-external
> > 
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> 
> Hi Klaus,
> 
> Silly question, but who is likely to pick this up? + likely to be soon?
> 
> I'm going to post the CXL stuff that makes use of the core support shortly
> and whilst I can point at this patch set on list, I'd keen to see it upstream
> to reduce the dependencies (it's got 2 sets ahead of it of CXL stuff
> anyway but that will all hopefully go through Michael Tsirkin's tree
> for PCI stuff in one go).

I can pick it up, but he can just request a merge, too.

I did have a question I asked earlier about tests.  It would be unusual
at this point to add something like this without having some tests,
especially injecting invalid data.

-corey

> 
> Jonathan
> 
> > ---
> > Changes in v6:
> > - Use nmi_scratch_append() directly where it makes sense. Fixes bug
> >   observed by Andrew.
> > - Link to v5: https://lore.kernel.org/r/20230905-nmi-i2c-v5-0-0001d372a728@samsung.com
> > 
> > Changes in v5:
> > - Added a nmi_scratch_append() that asserts available space in the
> >   scratch buffer. This is a similar defensive strategy as used in
> >   hw/i2c/mctp.c
> > - Various small fixups in response to review (Jonathan)
> > - Link to v4: https://lore.kernel.org/r/20230823-nmi-i2c-v4-0-2b0f86e5be25@samsung.com
> > 
> > ---
> > Klaus Jensen (3):
> >       hw/i2c: add smbus pec utility function
> >       hw/i2c: add mctp core
> >       hw/nvme: add nvme management interface model
> > 
> >  MAINTAINERS                   |   7 +
> >  hw/arm/Kconfig                |   1 +
> >  hw/i2c/Kconfig                |   4 +
> >  hw/i2c/mctp.c                 | 432 ++++++++++++++++++++++++++++++++++++++++++
> >  hw/i2c/meson.build            |   1 +
> >  hw/i2c/smbus_master.c         |  26 +++
> >  hw/i2c/trace-events           |  13 ++
> >  hw/nvme/Kconfig               |   4 +
> >  hw/nvme/meson.build           |   1 +
> >  hw/nvme/nmi-i2c.c             | 407 +++++++++++++++++++++++++++++++++++++++
> >  hw/nvme/trace-events          |   6 +
> >  include/hw/i2c/mctp.h         | 125 ++++++++++++
> >  include/hw/i2c/smbus_master.h |   2 +
> >  include/net/mctp.h            |  35 ++++
> >  14 files changed, 1064 insertions(+)
> > ---
> > base-commit: 005ad32358f12fe9313a4a01918a55e60d4f39e5
> > change-id: 20230822-nmi-i2c-d804ed5be7e6
> > 
> > Best regards,
> 
> 

