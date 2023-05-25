Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1425710D7F
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 15:44:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2BFh-0001PC-Bz; Thu, 25 May 2023 09:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1q2BFf-0001NK-Hs
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:43:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1q2BFc-0000pI-CM
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685022211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g1xlDOtW55fsHDEqZYD02dvREbm6bxmXVm1xX4Q9G4U=;
 b=EkI2T0wMYnxHQfVQse2K8xTTtkJJWoWEHL5XImiwrYYFjEhrjUyRPBv1EGRQ+KGIuzdxTc
 KFrwIZQgJ3nUgRUbNn2WzBdXTSxUu4UauARJtf1empz/mxiaWeVrh7aJ0hA/GAMSpyiFv3
 GrL3ypNEGfaJrMWW+8tYlANuKc9svWw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-YZdjg9LfNjeWGZQhdurB_Q-1; Thu, 25 May 2023 09:43:30 -0400
X-MC-Unique: YZdjg9LfNjeWGZQhdurB_Q-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2553b096ddfso706785a91.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 06:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685022209; x=1687614209;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g1xlDOtW55fsHDEqZYD02dvREbm6bxmXVm1xX4Q9G4U=;
 b=buthM0zS9P0/KfEfIKBh2iJYRSin2c8iY/yxj5mt55bvXP+/YGQlg5xD1JydCxgace
 WhFk5FLXx2C3JsWQjC9T42IDUiF9TvdtNBp10kRdYe0GvFC3PKc4eFw9J/AWjzKAwzaw
 TxKoW2lN5RZvnhe8Oomh/tMF1UZbdlcFIju0zxxoZaoIOnRDbInxMc2hYNpczXqn/+CO
 K/ad74HSdtH3BZjo3OivULMJO+cta65STZdLqugZBdUofLfv2FHjd5afsnMjNVccXb8I
 LLhWuMpXPpn0zljCK+CuFI+SgQApbon6MXsmfzgfLDrvX89T7mES5ScUOjQ4/o07UAfO
 JFdg==
X-Gm-Message-State: AC+VfDyTYJavn0ZV9OQ6CMHkokVPO/STf/TssB4uq727Yh69qQfs2IPw
 ySJJ58VLwV93eCNr1SP3sawbpRkQvt+id8s4+XZpNFvmcIzyANI6R2/ijxJcnK+bqDx5QNg7H++
 8I4uDaS7vR47ufVA9s3a2rSsXjg2QnCA=
X-Received: by 2002:a17:90a:4e83:b0:244:d441:8f68 with SMTP id
 o3-20020a17090a4e8300b00244d4418f68mr1871117pjh.16.1685022209440; 
 Thu, 25 May 2023 06:43:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ59M1DA9WZiMqyj0BAjZMPFcA/KfWigEDwq2/KA0Jci5J54iUz9eNGBLAdPTo85u4YllJXzFWz0VGIZEBlatsc=
X-Received: by 2002:a17:90a:4e83:b0:244:d441:8f68 with SMTP id
 o3-20020a17090a4e8300b00244d4418f68mr1871087pjh.16.1685022209051; Thu, 25 May
 2023 06:43:29 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 25 May 2023 13:43:28 +0000
From: Andrea Bolognani <abologna@redhat.com>
References: <20230523102805.100160-1-sunilvl@ventanamicro.com>
 <CABJz62MQ5uRHUP4LLKt=AxTf-Sz0aTEOLWDz=9ftK=H3tZ9JUg@mail.gmail.com>
 <ZG5KgLQ4H/leWKJi@sunil-laptop>
MIME-Version: 1.0
In-Reply-To: <ZG5KgLQ4H/leWKJi@sunil-laptop>
Date: Thu, 25 May 2023 13:43:28 +0000
Message-ID: <CABJz62NHXrBKkc3Gux0TXOjUCO4up-OunwJ6UO94ts+rTgVsAg@mail.gmail.com>
Subject: Re: [PATCH v3] hw/riscv: virt: Assume M-mode FW in pflash0 only when
 "-bios none"
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, May 24, 2023 at 11:03:52PM +0530, Sunil V L wrote:
> On Wed, May 24, 2023 at 03:50:34PM +0000, Andrea Bolognani wrote:
> > First off, the only RISC-V edk2 build readily accessible to me (from
> > the edk2-riscv64 Fedora package) is configured to work off a R/W
> > pflash1. You said that you have edk2 patches making R/O CODE pflash0
> > and R/W VARS pflash1 ready. Any chance you could make either the
> > build output, or the patches and some hints on how to build edk2
> > after applying them, somewhere?
>
> Please build EDK2 using the branch
> https://github.com/vlsunil/edk2/tree/separate_code_vars.
>
> The instructions to build is in
> https://github.com/vlsunil/riscv-uefi-edk2-docs/wiki/RISC-V-Qemu-Virt-support#build-edk2
>
> However, now it will create two images for code and vars.

Following your pointers, I was able to build suitable edk2 images and
verify that they work with a patched QEMU, so

  Tested-by: Andrea Bolognani <abologna@redhat.com>

Note, however, that said testing was limited to verifying that edk2
would come up.

I have also tried booting an openSUSE Tumbleweed "JeOS" image, since
that's the only distro I'm aware of that uses UEFI boot on RISC-V at
this point - though they use U-Boot's UEFI support rather than edk2.

During that attempt, I ended up in the edk2 shell. Running

  fs0:\efi\boot\bootriscv64.efi

brings up GRUB just fine, but selecting the default boot entry
results in

  Loading Linux 6.3.2-1-default ...
  Loading initial ramdisk ...
  EFI stub: Booting Linux Kernel...
  EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
  EFI stub: Generating empty DTB
  EFI stub: Exiting boot services...

being printed, after which it's back to OpenSBI and from there to
edk2 again.

I feel that this has probably more to do with the way the openSUSE
image has been built than edk2, but I thought I'd report my
experience nonetheless in case there's any useful information that
can be gathered from it :)

> > Going further and testing libvirt integration. After hacking around
> > other issues, I finally stumbled upon this error:
> >
> >   qemu-system-riscv64: Property 'virt-machine.pflash0' not found
>
> Thanks!. This needs some investigation. Let me look into supporting
> this.

Yes please! It's critical to libvirt integration. Feel free to CC me
when you post patches and I'll gladly test them.

-- 
Andrea Bolognani / Red Hat / Virtualization


