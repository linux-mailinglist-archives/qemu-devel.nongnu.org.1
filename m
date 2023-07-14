Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F17754362
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 21:45:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKOiX-0008Br-3N; Fri, 14 Jul 2023 15:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKOiU-0008Bf-Gw
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 15:44:38 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKOiS-0006Op-PO
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 15:44:38 -0400
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-55adfa61199so1742164a12.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 12:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689363874; x=1691955874;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T2cEWYWl1rpoQ1pqc17PwNqKqPxXzClQrKoF+cu6cIM=;
 b=RyKWHuHEuy1sXw5QE0J7f+WkcSLo/jepM6axDk9oRoPekBgDOMgtnwXovXB8GdoO3g
 NRdUdpX1ilrwn6KN925l8tqTVy4KqyeJLwd2xSXqNMPoPfWFHzsB9uCR7/TI9JKd4dhT
 YFe5NlTgbNxA9nB+fcJCUxwRgXQIZkokxUrUnP+rdoD9mphq7PwOUKXgVzTepL2dWbUU
 Z7cpq7U/czPVJq6EujmhMZOCrt2IYa4CEFJD4lRD8avHUrITfsaQhfYZg2bLjxJo36yO
 /lr+MS/jB1Rm3xSTXgb1vUfFmkQgVOORmqPU/DEjk+R6BPYWgqJfzOUepaBrkszh9xtu
 FLmQ==
X-Gm-Message-State: ABy/qLYe8ynmlhoOHAgU0lloQVN4L+CCDD5dYu8gIV0QQa/EhmGPEGZp
 TLU2jIslk81+L6p2Or6WNafwEmDLRO0=
X-Google-Smtp-Source: APBJJlFg27tuMDNX58fygCGbiVpFW8XmQvymyGdgQLciIAxoKKXn2y/DGscYzGslhU1dJCzT1iSizw==
X-Received: by 2002:a17:90a:d3c5:b0:25e:886b:c6b with SMTP id
 d5-20020a17090ad3c500b0025e886b0c6bmr4329451pjw.48.1689363874421; 
 Fri, 14 Jul 2023 12:44:34 -0700 (PDT)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com.
 [209.85.214.172]) by smtp.gmail.com with ESMTPSA id
 1-20020a17090a19c100b00265df5f782fsm1534691pjj.0.2023.07.14.12.44.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jul 2023 12:44:34 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-1b8ad9eede0so17677445ad.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 12:44:34 -0700 (PDT)
X-Received: by 2002:a17:902:dac8:b0:1b8:1bac:3782 with SMTP id
 q8-20020a170902dac800b001b81bac3782mr6309145plx.6.1689363874000; Fri, 14 Jul
 2023 12:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-12-j@getutm.app>
 <581b037d-ccb7-8df7-8946-df8198cb04e6@linux.ibm.com>
 <fe8ea892-0690-2308-5036-f31e10da0351@linux.ibm.com>
 <CA+E+eSCC2F-2bsO7OiCoS0weo7bh4daL7M5GYxa=6r-6qKcGmg@mail.gmail.com>
 <67a2b78d-8eea-7c9c-cf1b-50444e481006@linux.ibm.com>
 <562ec838-2714-2bb2-d1a5-7b98bb43a60b@linux.ibm.com>
 <CA+E+eSC_Hg5zxepaeCZTNiYS8oq6hNUqO8Pijft45O7vhD2q6Q@mail.gmail.com>
 <78cee616-94fa-baba-8dad-1dbcbbbbc45a@linux.ibm.com>
In-Reply-To: <78cee616-94fa-baba-8dad-1dbcbbbbc45a@linux.ibm.com>
From: Joelle van Dyne <j@getutm.app>
Date: Fri, 14 Jul 2023 12:44:23 -0700
X-Gmail-Original-Message-ID: <CA+E+eSAfzpLV_--hZnHjYsfRRrDTzOkVbT68KvdL_otteX94rg@mail.gmail.com>
Message-ID: <CA+E+eSAfzpLV_--hZnHjYsfRRrDTzOkVbT68KvdL_otteX94rg@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] tpm_crb: support restoring older vmstate
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.215.175; envelope-from=osy86dev@gmail.com;
 helo=mail-pg1-f175.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Jul 14, 2023 at 12:12=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.c=
om> wrote:
>
>
>
> On 7/14/23 14:49, Joelle van Dyne wrote:
> > On Fri, Jul 14, 2023 at 11:41=E2=80=AFAM Stefan Berger <stefanb@linux.i=
bm.com> wrote:
> >>
> >>
> >>
> >> On 7/14/23 14:22, Stefan Berger wrote:
> >>> On 7/14/23 13:04, Joelle van Dyne wrote:
> >>>> On Fri, Jul 14, 2023 at 7:51=E2=80=AFAM Stefan Berger <stefanb@linux=
.ibm.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 7/14/23 10:05, Stefan Berger wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 7/14/23 03:09, Joelle van Dyne wrote:
> >>>>>>> When we moved to a single mapping and modified TPM CRB's VMState,=
 it
> >>>>>>> broke restoring of VMs that were saved on an older version. This
> >>>>>>> change allows those VMs to gracefully migrate to the new memory
> >>>>>>> mapping.
> >>>>>>
> >>>>>> Thanks. This has to be in 4/11 though.
> >>>>>>
> >>>>>
> >>>>> After applying the whole series and trying to resume state taken wi=
th current git
> >>>>> master I cannot restore it but it leads to this error here. I would=
 just leave it
> >>>>> completely untouched in 4/11.
> >>>>>
> >>>>> 2023-07-14T14:46:34.547550Z qemu-system-x86_64: Unknown ramblock "t=
pm-crb-cmd", cannot accept migration
> >>>>> 2023-07-14T14:46:34.547799Z qemu-system-x86_64: error while loading=
 state for instance 0x0 of device 'ram'
> >>>>> 2023-07-14T14:46:34.547835Z qemu-system-x86_64: load of migration f=
ailed: Invalid argument
> >>>>>
> >>>>>       Stefan
> >>>>
> >>>> To be clear, you are asking to back out of 4/11? That patch changes
> >>>> how the registers are mapped so it's impossible to support the old
> >>>> style register mapping. This patch attempts to fix that with a
> >>>
> >>> Why can we not keep the old style register mapping as 'secondary mapp=
ing'?
> >>
> >> I think the first goal should be for existing TPM CRB device not to ch=
ange anything, they
> >> keep their .read and .write behaivor as it.
> >>
> >> If you need different .read behavior for the sysbus device due to AARC=
H64 then it may want to use its own MemoryRegionOps.
> >>
> >> I am fairly sure that you could refactor the core of the existing tpm_=
crb_mmio_write() and have it work on s->regs and mmio regs.
> >> The former would be used by existing code, the latter for CRB sysbus c=
alling into this new function from a wrapper.
> >>
> >>      Stefan
> >
> > I agree that new QEMU should be able to read old QEMU state but vice
> > versa is not always true. There's been many changes in the past that
> > incremented the vmstate's version_id to indicate that the state format
> > has changed. Also, we are not changing the .read behavior because in
>
> Unfortunately the CRB device is being used by x86 on some distros
> and the expectation is that this existing device can also downgrade
> to a previous version of QEMU I would say. I have read people migrating
> from RHEL 9.x even to RHEL 8.x and the expectation is that this works.
But would the migration even work due to other parts of QEMU? The only
way you can, say, migrate from QEMU 8.1.0 to 8.0.0 is if every single
VMstate has its version_id unchanged. Does QEMU provide that
guarantee? I'm fine with changing it but just want to make sure
expectations are set correctly. Have you tested a downgrade and found
that no other device impeded the process?

>
> Now you are introducing a new device and I think you can leave
> the existing device with its s->regs alone and have the new device
> with its mmio regs work a little different just to preserve the QEMU
> downgrade for x86.
>
> > the old code, the only field that gets a dynamic update is
> > tpmEstablished which we found is never changed. So effectively, .read
>
> Correct and that's why you don't need a .read in the new device.
>
> > is just doing a memcpy of the `regs` state. This makes it possible to
> > map the page as memory while retaining the same behavior as before.
> > (We are changing the code but not the behavior).
> >
> > The issue with Windows's buggy tpm.sys driver is that fundamentally it
> > cannot work with MemoryRegionOps. The way MMIO is implemented is that
>
> At least not with the .read part as it seems and you have to have the
> .write part to be able to react to cmd transfers etc.
>
> > a hole is left in the guest memory space so when the device registers
> > are accessed, the hypervisor traps it and sends it over to QEMU to
> > handle. QEMU looks up the address, sees its a valid MMIO mapping, and
> > calls into the MemoryRegionOps implementation. When tpm.sys does a LDP
> > instruction access to the hole, the information for QEMU to determine
> > if it's a valid access is not provided. Other hypervisors like Apple's
> > VZ.framework and VMware will read the guest PC, manually decode the
> > AArch64 instruction, determine the type of access, read the guest Rn
> > registers, does a TLB lookup to determine the physical address, then
> > emulate the MMIO. None of this capability currently exists in QEMU's
> > ARM64 backend. That's why we decided the easier path is to tell QEMU
> > that this mapping is RAM for read purposes and MMIO only for write
> > purposes (thankfully Windows does not do a STP or we'd be hosed).
>
> Thanks, this confirms what I thought.
>
>     Stefan

