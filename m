Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C0171F321
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 21:44:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4oCf-0002fN-S7; Thu, 01 Jun 2023 15:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1q4oCU-0002eH-UB; Thu, 01 Jun 2023 15:43:11 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1q4oCS-0008Gg-P3; Thu, 01 Jun 2023 15:43:10 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6af6df840ffso1048584a34.1; 
 Thu, 01 Jun 2023 12:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685648585; x=1688240585;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5z3sfd+u9XMiVAAiY2wszfBYA0kxwter/jGnF+RQ+IE=;
 b=hjNoE8Th3bNcNBZHmxkrCQPmV9mPM2Bt+UVu6EnAQfcfB8qlWB0lMxugfBonc435tk
 0aazZDcQLxiLqJHn4NvdSBlAr2F9GariiO1cLd4Mn1Ao8OsRCfuIsWJ96fHzOInteVgM
 2VrhzxZSVYJxQrw0e4iHIXHHWXhdS1XCj2tWZOjC2oFkjltrkfh8AF7eu07P/dbd6khf
 JDbrivy/kJm/HNpIFafO8oBXfP0mrqMZhxQZLXxlRE+bnXW/oBurD/iXWQNPV2DxzWgA
 OSorlxwYyTbvm3eslGJ5n2cfzZQAcyGyQTUDRBFSjaxBp+UG9pwcmBMXEwRKH7yzLfBO
 +l1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685648585; x=1688240585;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5z3sfd+u9XMiVAAiY2wszfBYA0kxwter/jGnF+RQ+IE=;
 b=MyBjGnr9zA0Q2ttSsC2zkc+PSQ5aDweJDwGZe4nWpC+iOXRiYWh/IU7e7E6WWzENqw
 e4xNHgaV3cbdwzEr4J+zm9uQbvHtVp2l9UgKr0xnzVlUAdxriebMNGEhbygWitWay9u5
 96GTXwKTXn15LcdGa49hisiG0QrY14pqEonYaGcRHXfmL0HOICF7LaAW9YwVphv8m0MW
 L3iXQdhfoJohDgSb3SRZ4N2kF6xMBijaQJiWvInteRWTjJV3x9WBoNc2IXJJQvO2pmDg
 MYJ5YTRE+rWTEBoWEanXCt0L6u08ay9AMwZP+nDJxHIPH1T3ijcG0G+vaAXZtf+oOFsg
 YE7Q==
X-Gm-Message-State: AC+VfDxjM8oMDuP0weHTvmX6nY0sa6oE1hzFzWmY5vI656YWksNM/7CV
 7Wnt123fNvCfk309xDMRAg==
X-Google-Smtp-Source: ACHHUZ74EJQqgVepHwDNq3npGia8sjlW8rn8L+TkHUzWHrYyoeY/gds3B+UYZrjtY55Fy1bs3wZomg==
X-Received: by 2002:a05:6830:18e:b0:6a4:4252:47aa with SMTP id
 q14-20020a056830018e00b006a4425247aamr397410ota.21.1685648585294; 
 Thu, 01 Jun 2023 12:43:05 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id
 r12-20020a9d750c000000b006af886703f2sm1857662otk.37.2023.06.01.12.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 12:43:04 -0700 (PDT)
Received: from mail.minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:4d5a:813b:a2b2:477c])
 by serve.minyard.net (Postfix) with ESMTPSA id A0AF7180047;
 Thu,  1 Jun 2023 19:42:59 +0000 (UTC)
Date: Thu, 1 Jun 2023 14:42:58 -0500
From: Corey Minyard <minyard@acm.org>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Corey Minyard <cminyard@mvista.com>,
 Keith Busch <kbusch@kernel.org>, Jason Wang <jasowang@redhat.com>,
 Lior Weintraub <liorw@pliops.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jeremy Kerr <jk@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Matt Johnston <matt@codeconstruct.com.au>,
 Peter Delevoryas <peter@pjd.dev>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-block@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 Peter Maydell <peter.maydell@linaro.org>, gost.dev@samsung.com
Subject: Re: [PATCH v3 0/3] hw/{i2c, nvme}: mctp endpoint, nvme management
 interface model
Message-ID: <ZHj0wnVHdY2HzL20@mail.minyard.net>
References: <20230531114744.9946-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531114744.9946-1-its@irrelevant.dk>
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=tcminyard@gmail.com; helo=mail-ot1-x335.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, May 31, 2023 at 01:47:41PM +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> This adds a generic MCTP endpoint model that other devices may derive
> from. I'm not 100% happy with the design of the class methods, but it's
> a start.
> 
> Also included is a very basic implementation of an NVMe-MI device,
> supporting only a small subset of the required commands. Lior (CC'ed) has some
> patches coming up that adds futher support.
> 
> Since this all relies on i2c target mode, this can currently only be
> used with an SoC that includes the Aspeed I2C controller.
> 
> The easiest way to get up and running with this, is to grab my buildroot
> overlay[1]. It includes modified a modified dts as well as a couple of
> required packages.
> 
> QEMU can then be launched along these lines:
> 
>   qemu-system-arm \
>     -nographic \
>     -M ast2600-evb \
>     -kernel output/images/zImage \
>     -initrd output/images/rootfs.cpio \
>     -dtb output/images/aspeed-ast2600-evb-nmi.dtb \
>     -nic user,hostfwd=tcp::2222-:22 \
>     -device nmi-i2c,address=0x3a \
>     -serial mon:stdio
> 
> From within the booted system,
> 
>   mctp addr add 8 dev mctpi2c15
>   mctp link set mctpi2c15 up
>   mctp route add 9 via mctpi2c15
>   mctp neigh add 9 dev mctpi2c15 lladdr 0x3a
>   mi-mctp 1 9 info
> 
> Comments are very welcome!
> 
>   [1]: https://github.com/birkelund/buildroots/tree/main/mctp-i2c
> 
> Changes since v2
> ~~~~~~~~~~~~~~~~
> 
>   - Applied a bunch of feedback from Jonathan:
>     + Moved a lot of internally used structs out of the include headers
>       and into the source files.
>     + Added spec references in various places
>     + Split the patch for i2c_smbus_pec() into its own
>     + Fix a compile error (and bug) in nmi-i2c.c.
> 
>   - From Corey:
>     + Reworked the buffer handling. The deriving devices now returns a
>       pointer to their own buffer that the mctp core copies into.

You didn't do what I asked here, I guess I wasn't clear.  You have:

+static void i2c_mctp_handle_control_set_eid(MCTPI2CEndpoint *mctp, uint8_t eid)
+{
+    mctp->my_eid = eid;
+
+    uint8_t buf[] = {
+        0x0, 0x0, eid, 0x0,
+    };
+
+    memcpy(i2c_mctp_control_data(mctp->buffer), buf, sizeof(buf));
+    mctp->len += sizeof(buf);
+}

That style of programming can lead to buffer overruns as code changes,
as you aren't checking the length of the target buffer.  I don't think
there are any issues now, but as people change the code you might end up
with one if someone gets a length wrong.

What I would like is for you to create a function like:

  i2c_mctp_add_bytes(mctp, buf, len)

that checks that len bytes will fit, then does the addition of the
bytes.  You need to adjust this to fit how you are doing things, and you
probably want one that adds just one byte, but hopefully you get the idea.

I'm sorry to be picky, but I've seen and fixed too many buffer overruns
(including one in the qemu i2c code) in situations like this.  Corey's
rule is: Never add anything to a buffer without checking the length.

Everything else looks good.

-corey

>     + Added a couple of extra debugging trace events.
> 
> Changes since v1
> ~~~~~~~~~~~~~~~~
> 
>   - Fix SPDX-License tag for hw/nvme/nmi-i2c.c (Philippe)
>   - Add some asserts to verify buffer indices (by request from Corey).
>   - Drop short packets that could result in underflow (Corey)
>   - Move i2c_smbus_pec() to smbus common code (Corey)
>   - A couple of logic fixes (patch from Jeremy squashed in)
>   - Added a patch to handle messages with dest eid 0 (Matt)
>     Maybe squash this as well.
> 
> Klaus Jensen (3):
>   hw/i2c: add smbus pec utility function
>   hw/i2c: add mctp core
>   hw/nvme: add nvme management interface model
> 
>  MAINTAINERS                   |   7 +
>  hw/arm/Kconfig                |   1 +
>  hw/i2c/Kconfig                |   4 +
>  hw/i2c/mctp.c                 | 398 ++++++++++++++++++++++++++++++++++
>  hw/i2c/meson.build            |   1 +
>  hw/i2c/smbus_master.c         |  28 +++
>  hw/i2c/trace-events           |  13 ++
>  hw/nvme/meson.build           |   1 +
>  hw/nvme/nmi-i2c.c             | 367 +++++++++++++++++++++++++++++++
>  hw/nvme/trace-events          |   6 +
>  include/hw/i2c/mctp.h         | 137 ++++++++++++
>  include/hw/i2c/smbus_master.h |   2 +
>  include/net/mctp.h            |  28 +++
>  13 files changed, 993 insertions(+)
>  create mode 100644 hw/i2c/mctp.c
>  create mode 100644 hw/nvme/nmi-i2c.c
>  create mode 100644 include/hw/i2c/mctp.h
>  create mode 100644 include/net/mctp.h
> 
> -- 
> 2.40.0
> 
> 

