Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D77778598
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 04:44:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUI7G-0006tH-BJ; Thu, 10 Aug 2023 22:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maverickk1778@gmail.com>)
 id 1qUI7E-0006t9-Mv
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 22:43:04 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maverickk1778@gmail.com>)
 id 1qUI7D-0004Jf-0l
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 22:43:04 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-790b080f2a0so53283139f.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 19:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691721781; x=1692326581;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=njuKOggsh5ZuBe2MY5qsFN4kGwCJ+yONnPm00uk5Ofk=;
 b=pC7TMlb/4YJ0hBmz49SMSK79G8l0lDjq87mkr3kXFPPUP4G8ZpWSzagPpHGhfU60Ck
 olvbeTdP43Pz41mzve9JDbFvm7YdENaejs51JZYfaAfOx5m7EoRl0VbSNq04K5dcPG21
 i2N4/uGtuMoTOGAw3YhlutY20DGCwnfKLzHud3UAreUVkp3tPBLDQjQgQOqw3mXkej1m
 LDC8qPCMBnhS040NxSVTYUMc6JYFIVmAuK7WQ3VC05H8d2NOKoT9qYl5wYFhEgFDcGMI
 VKl0bZ58IQi6OPmzPpN1Gg+KfoSYCLusJfriMKvi9vKCyQVxmkZvgvyJHFH+YGC9R0HT
 M1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691721781; x=1692326581;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=njuKOggsh5ZuBe2MY5qsFN4kGwCJ+yONnPm00uk5Ofk=;
 b=RXeA0cilGlYj6gOPpUc1RYWA2Uf/q2Rgrfz4LgYpx8NciNU6X8dpxeIyTcsndMIwUT
 Kr32+vOYTYg5D0aID9ffesW3Adwy04DedF2BWhgQ0rY2cW92VLl6R8BYrLregVNTA8xv
 K0dKZvogUqZb2PUx8HxHBjfkgZUAOXGzfpAVaG6QEYmj8DYTKN9sGor3O8Ku+yvUjhN7
 JRL2sqZ4tPYm2QH77nRWyADokH8x3fNA2GcsBgb60w6MUxLxs60wI9R042xwO8qjc14K
 8edUcR4h1AXCgqsnSxG2B/PZHjnW41YgZxp1rOmsqhmTP3NE0rb9Dw+puSZwrXGE00sS
 6jgw==
X-Gm-Message-State: AOJu0YymigRYzbjq1TksKQ4p+q4Xdo+m1dCVh/WNp5y9GhTvE/HwpDz6
 7KoQTkEsBYMikb+IT+qvYx32Inl4AcnspOtzdnY=
X-Google-Smtp-Source: AGHT+IHitFVbdAFCcci0AYPXJTO+gptwEaQ3+sD1KRqNFruLRVJUzj9sNM5CtF+qus0IFjaFXdZGpOWMJa0+5XNgBL4=
X-Received: by 2002:a05:6e02:1113:b0:345:3378:4251 with SMTP id
 u19-20020a056e02111300b0034533784251mr596876ilk.23.1691721781528; Thu, 10 Aug
 2023 19:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <CALfBBTtUtydebmJuh6JZ5RAXZfx5OgJ+RCug1apbZa4mm17rJQ@mail.gmail.com>
 <f64d5006-ae77-cc10-270a-0c0fc6e3a0ef@linaro.org>
In-Reply-To: <f64d5006-ae77-cc10-270a-0c0fc6e3a0ef@linaro.org>
From: Maverickk 78 <maverickk1778@gmail.com>
Date: Fri, 11 Aug 2023 08:12:50 +0530
Message-ID: <CALfBBTs=FRN4cGUCtVAyoVZPjT88SKwUPhF_m+sJkUBFbwH9QQ@mail.gmail.com>
Subject: Re: CXL volatile memory is not listed
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d35;
 envelope-from=maverickk1778@gmail.com; helo=mail-io1-xd35.google.com
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

Thanks Phil, David and Fan

Looks like it was an error from my side due to lack of information
cxl create-region works :)


On Thu, 10 Aug 2023 at 16:29, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi,
>
> Cc'ing Igor and David.
>
> On 9/8/23 00:51, Maverickk 78 wrote:
> > Hello,
> >
> > I am running qemu-system-x86_64
> >
> > qemu-system-x86_64 --version
> > QEMU emulator version 8.0.92 (v8.1.0-rc2-80-g0450cf0897)
> >
> > qemu-system-x86_64 \
> > -m 2G,slots=3D4,maxmem=3D4G \
> > -smp 4 \
> > -machine type=3Dq35,accel=3Dkvm,cxl=3Don \
> > -enable-kvm \
> > -nographic \
> > -device pxb-cxl,id=3Dcxl.0,bus=3Dpcie.0,bus_nr=3D52 \
> > -device cxl-rp,id=3Drp0,bus=3Dcxl.0,chassis=3D0,port=3D0,slot=3D0 \
> > -object memory-backend-file,id=3Dmem0,mem-path=3D/tmp/mem0,size=3D1G,sh=
are=3Dtrue \
> > -device cxl-type3,bus=3Drp0,volatile-memdev=3Dmem0,id=3Dcxl-mem0 \
> > -M cxl-fmw.0.targets.0=3Dcxl.0,cxl-fmw.0.size=3D1G
> >
> >
> > I was expecting the CXL memory to be listed in "System Ram", the lsmem
> > shows only 2G memory which is System RAM, it's not listing the CXL
> > memory.
>
> Sounds like a bug. Do you mind reporting at
> https://gitlab.com/qemu-project/qemu/-/issues?
>
> Thanks,
>
> Phil.
>
> > Do I need to pass any particular parameter in the kernel command line?
> >
> > Is there any documentation available? I followed the inputs provided in
> >
> > https://lore.kernel.org/linux-mm/Y+CSOeHVLKudN0A6@kroah.com/T/
> >
> > Is there any documentation/blog listed?
> >
>

