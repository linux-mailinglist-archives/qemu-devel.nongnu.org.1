Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A289E778580
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 04:35:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUHz8-0003un-2v; Thu, 10 Aug 2023 22:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maverickk1778@gmail.com>)
 id 1qUHz6-0003uO-5s
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 22:34:40 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maverickk1778@gmail.com>)
 id 1qUHz4-00022O-H8
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 22:34:39 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3492e8fb906so5740945ab.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 19:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691721277; x=1692326077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7RczCAEfFlIDjbcm6CEP7Zo7Rw49GxpIvtdn+ukP/+o=;
 b=LEBN+RQzOrBJ3NTt+QN+ma1T54nWv94ArqaMwmmUy4hTYmtMcxOejO9GFC3MKGwxeF
 8/QLGL39sZuUkQB9ntY5ibxI2QOT4LX8JTKxL6UhjSufJT3WTQ/KjG1bypW+Hvce5jEI
 4Gvh8y2bLi/appa3A/DH3hQxmsHiN7wHFJ70zTHhap14kl4WzJZHpqTnVAOULZOXNQgo
 2lJ8EXG/sUI0AIM4qTldvPcvhSZhDDA+tZ2ukOwcOvmJVTOj0Pr3a/nCnqAtCq8uTaTC
 fxQVDLL1kOKnb8FixGBl7TFIAFvVPyFp8CG+IyREdD0qPBu0KNRtd7IXmXX70xnQnM39
 JSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691721277; x=1692326077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7RczCAEfFlIDjbcm6CEP7Zo7Rw49GxpIvtdn+ukP/+o=;
 b=DhUYH4viB6sakQQD6eGqMUHEkuafxnec4F24nu5yFE3ERwOalHyDfl1cnA4fGNUtVp
 uIMi/DXEvs9mflxqQ5QVrjTqt0V5yKNZjB1HGpsWqqHH0MEwyHBMq9UZzdwEqqR8RV1j
 CVG6lfvUxauUcXewauAeUzAyK5FwiZOyKOfhED1ysfr6ldX19GNiYaUkRuNReBpHhZmZ
 NhUC64x2me7TvwbOB0U59wd64JEpuesbrKzVH/sDb6xXTZYRsCMyJzIPSdI0fVZ90UBr
 AAm/hyZmu9BNs2FyO1jNQS4wvh2p960864vnfcC4tTeLyxWejOLQiC+kiE2o/OOV4Mm4
 k+yg==
X-Gm-Message-State: AOJu0Yw35fgzxIX/j23PAjVBMpEERgpOXzOJ1Zv76jfUUxvBLlQ0qPFY
 kxSxcRFSIqCOq47haljzLhCcnjG3ygn+gM6pji1KuXHnUhnxTg==
X-Google-Smtp-Source: AGHT+IGjdTEMWT5dDZzHB7sl1DeRZKElA98jt/FYICjlSj2Icg9K7JbNqm2/OqZ/qR3A9bAqoQ9sX0yTlVBXvRMDKC8=
X-Received: by 2002:a92:c5d0:0:b0:345:df7f:efc4 with SMTP id
 s16-20020a92c5d0000000b00345df7fefc4mr741425ilt.27.1691721277269; Thu, 10 Aug
 2023 19:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <CALfBBTtUtydebmJuh6JZ5RAXZfx5OgJ+RCug1apbZa4mm17rJQ@mail.gmail.com>
 <20230810113512.00000516@Huawei.com>
In-Reply-To: <20230810113512.00000516@Huawei.com>
From: Maverickk 78 <maverickk1778@gmail.com>
Date: Fri, 11 Aug 2023 08:04:26 +0530
Message-ID: <CALfBBTud4Y7qxKB8nkZ5Lo5sQs-7-F9Rkso+iQGvLO07VyRcDA@mail.gmail.com>
Subject: Re: CXL volatile memory is not listed
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron via <qemu-devel@nongnu.org>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=maverickk1778@gmail.com; helo=mail-il1-x136.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Jonathan,

> More generally for the flow that would bring the memory up as system ram
> you would typically need the bios to have done the CXL enumeration or
> a bunch of scripts in the kernel to have done it.  In general it can't
> be fully automated, because there are policy decisions to make on things like
> interleaving.

BIOS CXL enumeration? is CEDT not enough? or BIOS further needs to
create an entry
in the e820 table?

>
> I'm not aware of any open source BIOSs that do it yet.  So you have
> to rely on the same kernel paths as for persistent memory - manual configuration
> etc in the kernel.
>
Manual works with "cxl create regiton"  :)

On Thu, 10 Aug 2023 at 16:05, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 9 Aug 2023 04:21:47 +0530
> Maverickk 78 <maverickk1778@gmail.com> wrote:
>
> > Hello,
> >
> > I am running qemu-system-x86_64
> >
> > qemu-system-x86_64 --version
> > QEMU emulator version 8.0.92 (v8.1.0-rc2-80-g0450cf0897)
> >
> +Cc linux-cxl as the answer is more todo with linux than qemu.
>
> > qemu-system-x86_64 \
> > -m 2G,slots=4,maxmem=4G \
> > -smp 4 \
> > -machine type=q35,accel=kvm,cxl=on \
> > -enable-kvm \
> > -nographic \
> > -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> > -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
> > -object memory-backend-file,id=mem0,mem-path=/tmp/mem0,size=1G,share=true \
> > -device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0 \
> > -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=1G
>
> There are some problems upstream at the moment (probably not cxl related but
> I'm digging). So today I can't boot an x86 machine. (goody)
>
>
> More generally for the flow that would bring the memory up as system ram
> you would typically need the bios to have done the CXL enumeration or
> a bunch of scripts in the kernel to have done it.  In general it can't
> be fully automated, because there are policy decisions to make on things like
> interleaving.
>
> I'm not aware of any open source BIOSs that do it yet.  So you have
> to rely on the same kernel paths as for persistent memory - manual configuration
> etc in the kernel.
>
> There is support in ndctl for those enabling flows, so I'd look there
> for more information
>
> Jonathan
>
>
> >
> >
> > I was expecting the CXL memory to be listed in "System Ram", the lsmem
> > shows only 2G memory which is System RAM, it's not listing the CXL
> > memory.
> >
> > Do I need to pass any particular parameter in the kernel command line?
> >
> > Is there any documentation available? I followed the inputs provided in
> >
> > https://lore.kernel.org/linux-mm/Y+CSOeHVLKudN0A6@kroah.com/T/
> >
> > Is there any documentation/blog listed?
>

