Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2096E789899
	for <lists+qemu-devel@lfdr.de>; Sat, 26 Aug 2023 20:09:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZxhO-0007BW-FU; Sat, 26 Aug 2023 14:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qZxhH-0007BE-Ep; Sat, 26 Aug 2023 14:07:44 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qZxhE-0005oG-HV; Sat, 26 Aug 2023 14:07:42 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5922b96c5fcso23090977b3.0; 
 Sat, 26 Aug 2023 11:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693073258; x=1693678058;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2DF51CMxuflnJb6K95gZn9dCPXtxU4OCDwBPvvSjzEg=;
 b=E/W7J8rIrf2z0KfrGkXpXl1DQW3XkKEoJpqEBayYF0RDRDsNp59J846zQ56wGCc08H
 L1OHAbR1boh4QpKpai8Mnect+EpSxMZEbOuom/h1a1zxtRgOxLRitFQD3A8qMAyp1qYq
 8Z+3i1rZUxbxz7E2Vn+eTbelRRoK5QQn6E9xUsVKFfwfqbAxealYLv77s08oD9RkfSO+
 lQY66wybQFKkPf9wuMD+0r0qmqu++Rt5pHJmNg4js0pPa1X5WdJbJ8yx3TSPG9yTD4AN
 830DM9IiOU7kEXKEm6JowmSjkDmKkNKOMB+3h0k8t4z/vHLuimSzsJe8fnXgGXN46rOV
 dNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693073258; x=1693678058;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2DF51CMxuflnJb6K95gZn9dCPXtxU4OCDwBPvvSjzEg=;
 b=alw3tHYcPc34SGRDeHu7BRGINi1YZks+mVKKfAU8f3aLmwzYUt5e3PdldZURB5D91w
 yV60cyBjeS7xE5mM34gHcXZa0XlpwsPhqBXwSLRZD7xtoPkxgLkHNmfQSjJJ4NCJKWxl
 FZrlB/H+EpHA9qOi3RdrQm5E0IQTetFIecQi5KvIz45/4/g5p7Td9IybcVCdqAaTmN+2
 z72Txtt6OKmK/2w7iDcG1f5BZOmquNMp3Hp/wBsRwyTDsVPCnEqKi1lZM9e/2Jxr0Qrz
 bgElUNglrGPfVDx4rom0Upfbu8/JTLoRP0Nn858+AkNqniAfPoHESRZy43unD5e8Msp5
 0L3g==
X-Gm-Message-State: AOJu0YzHEhDWyZ5fBkf73jYUvvmiZ0o+5nELdNfx0IE0Z1+g+5Ab8VcG
 LSmBwueo8j06wsP9X1eyZ7MX90rciigMJH1xmHo=
X-Google-Smtp-Source: AGHT+IGX9U7EhqZRnH1oyCvPDlu83naVpZ185y5rT4XPrXGoo3M/kcSvQl5nFNEnS2YzMRzflXS5tjzjaEz4fkPfm/U=
X-Received: by 2002:a81:4e86:0:b0:58d:70b4:233a with SMTP id
 c128-20020a814e86000000b0058d70b4233amr25070654ywb.37.1693073258462; Sat, 26
 Aug 2023 11:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <ad7e1294-f19f-5bea-e891-f6adbe323cd5@proxmox.com>
 <CAFn=p-ahLoVd3W2GaFp5EUFq5EOudz+bUkEk5DV+Z07AjHaHtg@mail.gmail.com>
 <d07bdbc1-065e-f8ec-2a44-ab141ffedd41@proxmox.com>
 <CAL77WPAdDyKFWP_Dqsz_xr7OCzHLTkw6VbYDMGobi8kek4e_8A@mail.gmail.com>
 <85488658-80df-f6ac-8a1d-51172148a436@proxmox.com>
 <CAL77WPDJaRBgCeBtVx6tZ6yxKTG6Z2SEk_oif4RCSSnUgOuURA@mail.gmail.com>
 <1f581666-cfe0-cb7e-bbb5-6097e03c76e2@proxmox.com>
 <fb142bbf-d1d4-2a7f-3a4c-b5c59059dc19@proxmox.com>
In-Reply-To: <fb142bbf-d1d4-2a7f-3a4c-b5c59059dc19@proxmox.com>
From: Mike Maslenkin <mike.maslenkin@gmail.com>
Date: Sat, 26 Aug 2023 21:07:02 +0300
Message-ID: <CAL77WPCD4pCfciDy9MHkRg7aqwpgHa2WdiDgbdKd5x3SeZ=B-A@mail.gmail.com>
Subject: Re: Lost partition tables on ide-hd + ahci drive
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, 
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>, 
 Aaron Lauterer <a.lauterer@proxmox.com>, simon.rowe@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=mike.maslenkin@gmail.com; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Aug 23, 2023 at 12:17=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> =
wrote:
>
> Am 23.08.23 um 10:47 schrieb Fiona Ebner:
> > Am 17.02.23 um 22:22 schrieb Mike Maslenkin:
> >> I can not tell anything about dma-reentracy issues, but yes, i would
> >> start to look at check_cmd() function call sequence.
> >> The most interesting is why Sector Count =3D 1. I thought about race
> >> with IDE reset where registers initialized with
> >> value SATA_SIGNATURE_DISK =3D 0x00000101, but this means LBA=3D1 as we=
ll...
> >>
> >
> > You got it! Since we got another report (after half a year of nothing)
> > and also because of Simon's mail, I gave it another shot too and was
> > finally able to reproduce the issue (with our patched QEMU 8.0, but
> > patches shouldn't affect IDE code). See below for the traces that
> > confirm your theory. The reason the write goes to sector 0 and not 1 is
> > because ide_dma_cb() uses sector_num =3D ide_get_sector(s); and that wi=
ll
> > evaluate to 0 after a reset.
> >
> > So the issue is indeed that ide_dma_cb can get called with an IDEState
> > just after that state was reset. Can we somehow wait for pending
> > requests before proceeding with the reset, or can we force an error
> > return for callbacks that are still pending during reset?
> >
>
> I noticed that ide_bus_reset() does the reset first and then cancels the
> aiocb. Maybe it's already enough to switch those around?
>
> Best Regards,
> Fiona

Great job! Patch looks good to me.

Since the reason is known now, It can be easier to reproduce original
case again, but with disabled NCQ.
There is no command line argument, so it is required to rebuild qemu
without announcing HOST_CAP_NCQ capability.
I'd expect this greatly increase chances to catch original corruption.

Best Regards,
Mike.

