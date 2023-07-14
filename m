Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7E2754091
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 19:39:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKMkY-00026M-QX; Fri, 14 Jul 2023 13:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKMkU-00025q-E3
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 13:38:34 -0400
Received: from mail-oo1-f42.google.com ([209.85.161.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKMkS-0008JN-QR
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 13:38:34 -0400
Received: by mail-oo1-f42.google.com with SMTP id
 006d021491bc7-5634808e16eso1464647eaf.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 10:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689356310; x=1691948310;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JtFguPMYibuL+IW/GYQnjjFA/jCwcgBNp4BwQBPUg78=;
 b=hCOJcD4USL26V/xlHIAI39n6bhDggOFLdJzSVkx+JJasWrBaqxuwXZ2WyGc6XQgI7j
 EfBvhE8Cx97JQR2/0Lh1Bk7I5NNEzZpgUIAMa1nvlvk/kUN1K8m5s3TYTCloihXjvaCA
 LastWsW+HogTNoo0weAFEq9qD9aeapSga4JDjO2USd0E3AH0hPS1H7MIGze976J72Isk
 lwRwcfI2cx6ZSkCChoNB7o5rcgfmpaF5yAfjgBmNnNZY/zdl8GUIIcS+PpckPbVEG9a/
 6m5jT8k2lqWqqDAHxdjnZZrFr5OWl4wfGL+u/EU1+JXbg11FYD/j4s3CLeYvEvietFY1
 sRHA==
X-Gm-Message-State: ABy/qLaKXj2N14qqqqynuD3Er+E3EnLvolwHYrxCvzZAJq7L6IuUTYg1
 v2Sy0gJwdIsh5gu8lVvEHb/kMmgKIvoVPw==
X-Google-Smtp-Source: APBJJlEiDkGwWQCZLecTdBelg0gL14pF5yeUZRF1XZ+HzhqH6B65xcKYCdbqutY2Vd2PqEX6U8Xi5w==
X-Received: by 2002:a4a:270c:0:b0:566:ef1e:f11c with SMTP id
 l12-20020a4a270c000000b00566ef1ef11cmr4186967oof.3.1689356310417; 
 Fri, 14 Jul 2023 10:38:30 -0700 (PDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com.
 [209.85.167.180]) by smtp.gmail.com with ESMTPSA id
 j4-20020a056830014400b006b9734b9fafsm4017649otp.13.2023.07.14.10.38.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jul 2023 10:38:30 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-3a1d9b64837so1759220b6e.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 10:38:30 -0700 (PDT)
X-Received: by 2002:a05:6808:1889:b0:3a4:3b56:68f0 with SMTP id
 bi9-20020a056808188900b003a43b5668f0mr4530963oib.41.1689356309876; Fri, 14
 Jul 2023 10:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230713035232.48406-1-j@getutm.app>
 <20230713035232.48406-5-j@getutm.app>
 <4a49285e-0d91-93a0-2f8e-e76c71ed89f8@linux.ibm.com>
 <CAFEAcA-r_VOc18-jm99asYQQk4TJMBW_7oJMzFQofEHqVdF50A@mail.gmail.com>
 <ab339186-1af7-171c-eb11-fe124f12b4a2@linux.ibm.com>
 <CAFEAcA9nad4H3MgitMyVsZjNZdY-n9d65Yz4Gtbz2wPYA4fbsg@mail.gmail.com>
 <e2340c41-1d77-3406-001c-4dcce544af74@linux.ibm.com>
 <CAFEAcA-WtwcckNO=kDP8HbY53qV3mTtYysH2Lw8FSJsrWO2tdQ@mail.gmail.com>
 <afb324e8-d65a-12b3-e591-65133087689b@linux.ibm.com>
 <CAFEAcA9Z5wHRuMmeogoyrN=C4OtoKObxNu58nQaOXdYwzq_gpw@mail.gmail.com>
 <c5b44af5-e737-d899-5ea1-3d7debe760a4@linux.ibm.com>
 <CAFEAcA-igpEHJOxw8mCV=em6FRUT8BuNRPCiVMvQ7moaasSmLw@mail.gmail.com>
 <de9befdf-82ea-6cff-e300-7a9edf3e867b@linux.ibm.com>
 <CAFEAcA8KgSsmiCFA51vrYAFrXg6p8x=0_qM0wrZ4yHOWrQKp2A@mail.gmail.com>
 <ee0effff-341a-8a69-3cc8-6f615c4743fe@linux.ibm.com>
In-Reply-To: <ee0effff-341a-8a69-3cc8-6f615c4743fe@linux.ibm.com>
From: Joelle van Dyne <j@getutm.app>
Date: Fri, 14 Jul 2023 10:38:18 -0700
X-Gmail-Original-Message-ID: <CA+E+eSCfhrya-nvJM=+0k5oH1NNmiP-G0sSZzW1OCtR4Zy0GkA@mail.gmail.com>
Message-ID: <CA+E+eSCfhrya-nvJM=+0k5oH1NNmiP-G0sSZzW1OCtR4Zy0GkA@mail.gmail.com>
Subject: Re: [PATCH 04/11] tpm_crb: use a single read-as-mem/write-as-mmio
 mapping
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Joelle van Dyne <j@getutm.app>,
 qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.161.42; envelope-from=osy86dev@gmail.com;
 helo=mail-oo1-f42.google.com
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

On Fri, Jul 14, 2023 at 4:57=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
>
> On 7/14/23 06:05, Peter Maydell wrote:
> > On Thu, 13 Jul 2023 at 19:43, Stefan Berger <stefanb@linux.ibm.com> wro=
te:
> >>
> >>
> >>
> >> On 7/13/23 13:18, Peter Maydell wrote:
> >>> On Thu, 13 Jul 2023 at 18:16, Stefan Berger <stefanb@linux.ibm.com> w=
rote:
> >>>> I guess the first point would be to decide whether to support an i2c=
 bus on the virt board and then whether we can use the aspeed bus that we k=
now that the tpm_tis_i2c device model works with but we don't know how Wind=
ows may react to it.
> >>>>
> >>>> It seems sysbus is already supported there so ... we may have a 'mat=
ch'?
> >>>
> >>> You can use sysbus devices anywhere -- they're just
> >>
> >> 'anywhere' also includes aarch64 virt board I suppose.
> >
> > Yes. Literally any machine can have memory mapped devices.
> >
> >>> "this is a memory mapped device". The question is whether
> >>> we should, or whether an i2c controller is more like
> >>> what the real world uses (and if so, what i2c controller).
> >>>
> >>
> >>> I don't want to accept changes to the virt board that are
> >>> hard to live with in future, because changing virt in
> >>> non-backward compatible ways is painful.
> >>
> >> Once we have the CRB sysbus device we would keep it around forever and=
 it seems to
> >> - not require any changes to the virt board (iiuc) since sysbus is alr=
eady being used
> >> - works already with Windows and probably also Linux
> >
> > "Add a sysbus device to the virt board" is the kind of
> > change I mean -- once you do that it's hard to take it
> > out again, and if we decide in 6 months time that actually
> > i2c would be the better option then we end up with two
> > different ways to do the same thing and trying to
> > deprecate the other one is a pain.
>
>
> At least CRB is a standard interface and from this perspective we are fin=
e. I am not sure what would drive the introduction of the i2c bus in 6 mont=
hs. I suppose one could then still use sysbus CRB device or the i2c device.=
 The sysbus CRB device should still work then. Anyway, I think we should co=
ntinue with this series.
>
>     Stefan
>
> >
> > -- PMM

FWIW the Windows 11 tpm.sys driver does not support the I2C interface.
The driver only recognizes ACPI devices and the case for Start Method
=3D 12 (FIFO Interface over I2C bus) goes to an error handler.

