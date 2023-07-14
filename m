Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E12A37542CE
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 20:50:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKNqz-0004EO-AR; Fri, 14 Jul 2023 14:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKNqw-0004ED-PX
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 14:49:18 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKNqv-0002OX-5O
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 14:49:18 -0400
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-1b8c81e36c0so14077155ad.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 11:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689360555; x=1691952555;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XIymPxqneQy5XKqANIsnp72CAbfW7RYeV7M/gmOJuIM=;
 b=RVb8r+iu+q59cVB7Dg/Krj7KAJss0f+uk38NHtOn7XxYyc2AWkEYKT7xpA+A7doaAG
 3nHroBjxLPgzcTU6SPZABGc5sZW1Of0wNRzsRM4Pzq4IM3pbZFOGOf04KavXnyBg8EpW
 ZtAK+zMtHOQaKXyYlC/AVsOw3feHEbd01edYxm6KK7yYSlu3wSobJcj+LaOGxP6wvD6e
 hu8QT+9lXZbbOQKwafBaZJSAoeCloET9So13l/uhxol5qXpPBcWAwOXVeWCjNgUpU7Lx
 IRo6Bc7hCQOzRxMX4gA18Qa4LfQwMxzHWmLqzcWh0VSUDiSJLnUEuBiiCpFGV2xwyJiR
 15vQ==
X-Gm-Message-State: ABy/qLYrpA3I85wMRA8yvM8NK4VARptHtFO+fegyhm7KVVpbX5AJdmGO
 QRgtMIUjHUpiSKpqOki5sIyUlVSU67k=
X-Google-Smtp-Source: APBJJlGNxKjTCUbcRItJO4gCSdqPbXvxB+pJ8q7or3Rz/abDD41pFgFB74AsrMncAOvaFBX9vonc3g==
X-Received: by 2002:a17:902:b218:b0:1b6:4bbd:c3a3 with SMTP id
 t24-20020a170902b21800b001b64bbdc3a3mr3770265plr.52.1689360555474; 
 Fri, 14 Jul 2023 11:49:15 -0700 (PDT)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com.
 [209.85.216.42]) by smtp.gmail.com with ESMTPSA id
 y2-20020a1709029b8200b001b86f1b5797sm8042953plp.302.2023.07.14.11.49.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jul 2023 11:49:14 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-26304be177fso1195081a91.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 11:49:14 -0700 (PDT)
X-Received: by 2002:a17:90a:9483:b0:262:d661:2963 with SMTP id
 s3-20020a17090a948300b00262d6612963mr3615060pjo.39.1689360554658; Fri, 14 Jul
 2023 11:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-12-j@getutm.app>
 <581b037d-ccb7-8df7-8946-df8198cb04e6@linux.ibm.com>
 <fe8ea892-0690-2308-5036-f31e10da0351@linux.ibm.com>
 <CA+E+eSCC2F-2bsO7OiCoS0weo7bh4daL7M5GYxa=6r-6qKcGmg@mail.gmail.com>
 <67a2b78d-8eea-7c9c-cf1b-50444e481006@linux.ibm.com>
 <562ec838-2714-2bb2-d1a5-7b98bb43a60b@linux.ibm.com>
In-Reply-To: <562ec838-2714-2bb2-d1a5-7b98bb43a60b@linux.ibm.com>
From: Joelle van Dyne <j@getutm.app>
Date: Fri, 14 Jul 2023 11:49:03 -0700
X-Gmail-Original-Message-ID: <CA+E+eSC_Hg5zxepaeCZTNiYS8oq6hNUqO8Pijft45O7vhD2q6Q@mail.gmail.com>
Message-ID: <CA+E+eSC_Hg5zxepaeCZTNiYS8oq6hNUqO8Pijft45O7vhD2q6Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] tpm_crb: support restoring older vmstate
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.214.181; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f181.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Jul 14, 2023 at 11:41=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.c=
om> wrote:
>
>
>
> On 7/14/23 14:22, Stefan Berger wrote:
> > On 7/14/23 13:04, Joelle van Dyne wrote:
> >> On Fri, Jul 14, 2023 at 7:51=E2=80=AFAM Stefan Berger <stefanb@linux.i=
bm.com> wrote:
> >>>
> >>>
> >>>
> >>> On 7/14/23 10:05, Stefan Berger wrote:
> >>>>
> >>>>
> >>>> On 7/14/23 03:09, Joelle van Dyne wrote:
> >>>>> When we moved to a single mapping and modified TPM CRB's VMState, i=
t
> >>>>> broke restoring of VMs that were saved on an older version. This
> >>>>> change allows those VMs to gracefully migrate to the new memory
> >>>>> mapping.
> >>>>
> >>>> Thanks. This has to be in 4/11 though.
> >>>>
> >>>
> >>> After applying the whole series and trying to resume state taken with=
 current git
> >>> master I cannot restore it but it leads to this error here. I would j=
ust leave it
> >>> completely untouched in 4/11.
> >>>
> >>> 2023-07-14T14:46:34.547550Z qemu-system-x86_64: Unknown ramblock "tpm=
-crb-cmd", cannot accept migration
> >>> 2023-07-14T14:46:34.547799Z qemu-system-x86_64: error while loading s=
tate for instance 0x0 of device 'ram'
> >>> 2023-07-14T14:46:34.547835Z qemu-system-x86_64: load of migration fai=
led: Invalid argument
> >>>
> >>>      Stefan
> >>
> >> To be clear, you are asking to back out of 4/11? That patch changes
> >> how the registers are mapped so it's impossible to support the old
> >> style register mapping. This patch attempts to fix that with a
> >
> > Why can we not keep the old style register mapping as 'secondary mappin=
g'?
>
> I think the first goal should be for existing TPM CRB device not to chang=
e anything, they
> keep their .read and .write behaivor as it.
>
> If you need different .read behavior for the sysbus device due to AARCH64=
 then it may want to use its own MemoryRegionOps.
>
> I am fairly sure that you could refactor the core of the existing tpm_crb=
_mmio_write() and have it work on s->regs and mmio regs.
> The former would be used by existing code, the latter for CRB sysbus call=
ing into this new function from a wrapper.
>
>     Stefan

I agree that new QEMU should be able to read old QEMU state but vice
versa is not always true. There's been many changes in the past that
incremented the vmstate's version_id to indicate that the state format
has changed. Also, we are not changing the .read behavior because in
the old code, the only field that gets a dynamic update is
tpmEstablished which we found is never changed. So effectively, .read
is just doing a memcpy of the `regs` state. This makes it possible to
map the page as memory while retaining the same behavior as before.
(We are changing the code but not the behavior).

The issue with Windows's buggy tpm.sys driver is that fundamentally it
cannot work with MemoryRegionOps. The way MMIO is implemented is that
a hole is left in the guest memory space so when the device registers
are accessed, the hypervisor traps it and sends it over to QEMU to
handle. QEMU looks up the address, sees its a valid MMIO mapping, and
calls into the MemoryRegionOps implementation. When tpm.sys does a LDP
instruction access to the hole, the information for QEMU to determine
if it's a valid access is not provided. Other hypervisors like Apple's
VZ.framework and VMware will read the guest PC, manually decode the
AArch64 instruction, determine the type of access, read the guest Rn
registers, does a TLB lookup to determine the physical address, then
emulate the MMIO. None of this capability currently exists in QEMU's
ARM64 backend. That's why we decided the easier path is to tell QEMU
that this mapping is RAM for read purposes and MMIO only for write
purposes (thankfully Windows does not do a STP or we'd be hosed).

