Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D547540F5
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 19:47:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKMsZ-0002rt-Mx; Fri, 14 Jul 2023 13:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKMsO-0002rH-Pu; Fri, 14 Jul 2023 13:46:44 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKMsN-0007Eq-5z; Fri, 14 Jul 2023 13:46:44 -0400
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-666eb03457cso1548015b3a.1; 
 Fri, 14 Jul 2023 10:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689356801; x=1691948801;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QP3tTgyfZObIgMXj8yArMWEA5dwxB7s3Ien1JTdx0j8=;
 b=LRAWLgA9A1SH3g7AF97nGpDmKlSPB46oZHoSwZ2FlGlx2VC1dTO5QNW5a4C4VQBOOG
 FDmF6gCoBkhQJjykP8uVmWvvQWAKgFVOIYSKakr2AK36+XriBx3ENFu9FrIRMdx3/7xy
 7dbxQ9kYogSb9+5hVLbgq47CIrMzoI+EgtVFVH8cr2+MHffR74DLvWKIAgUSTPCijWn8
 3IKuE/OiCr1doEdNQnYnEwA0HcMtpWM44wHmGY+DatnU3KcPgQR2W0RyGNaPsN84hcr6
 zumUKkVqXS0V71vIvv5PFcWk5PlGMF8P/W/bWtdGj4PdZh/8jQJMMEM3caZOcwmbwPPd
 1VcA==
X-Gm-Message-State: ABy/qLaZ0Q7fYVsU0fYXPm8Hc0lcZcEJLJlCs/uK9H1wcuEJONRIGvVN
 A67j9WqywmKw75ESnTN3pkQXKY2QPsxIjA==
X-Google-Smtp-Source: APBJJlG4xPLuwQ9Mr1RMeBUg06TvQe1s5mNB08ylzfdbZcEb+mTDdcBrz+wpWdVBgdQchh8yIdwdEg==
X-Received: by 2002:a05:6a00:1a16:b0:647:4dee:62b7 with SMTP id
 g22-20020a056a001a1600b006474dee62b7mr4443380pfv.29.1689356801266; 
 Fri, 14 Jul 2023 10:46:41 -0700 (PDT)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com.
 [209.85.210.182]) by smtp.gmail.com with ESMTPSA id
 l4-20020a63be04000000b0053b92b26412sm7040584pgf.14.2023.07.14.10.46.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jul 2023 10:46:41 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-666eb03457cso1548006b3a.1; 
 Fri, 14 Jul 2023 10:46:41 -0700 (PDT)
X-Received: by 2002:a17:90a:1b6c:b0:262:c3b3:f8fa with SMTP id
 q99-20020a17090a1b6c00b00262c3b3f8famr3319563pjq.39.1689356800801; Fri, 14
 Jul 2023 10:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-10-j@getutm.app>
 <d3d3d9d0-fb88-9500-34d9-9780f9c2644f@linux.ibm.com>
 <CA+E+eSDinJuo8xyZTzfqKXr=rf+fyjkvOLVEqam0eapehQ1OYA@mail.gmail.com>
 <1a394fc6-4a64-5e00-5631-eb5a6aa4ce59@linux.ibm.com>
 <CA+E+eSCbPXZWk2zst+AunRpL74DOEB437mZqMhpWQ0K+=dvf8A@mail.gmail.com>
 <bd034676-1a9b-59a7-0445-129c32daa7b1@linux.ibm.com>
In-Reply-To: <bd034676-1a9b-59a7-0445-129c32daa7b1@linux.ibm.com>
From: Joelle van Dyne <j@getutm.app>
Date: Fri, 14 Jul 2023 10:46:29 -0700
X-Gmail-Original-Message-ID: <CA+E+eSC7MOOWhZ1WzAAjczX+P8WvjGdLY8wkX=sq98M3YCRVJQ@mail.gmail.com>
Message-ID: <CA+E+eSC7MOOWhZ1WzAAjczX+P8WvjGdLY8wkX=sq98M3YCRVJQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] tpm_tis_sysbus: move DSDT AML generation to
 device
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, 
 Song Gao <gaosong@loongson.cn>, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 "open list:ARM ACPI Subsystem" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.210.177; envelope-from=osy86dev@gmail.com;
 helo=mail-pf1-f177.google.com
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

On Fri, Jul 14, 2023 at 10:43=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.c=
om> wrote:
>
>
>
> On 7/14/23 13:39, Joelle van Dyne wrote:
> > On Fri, Jul 14, 2023 at 10:37=E2=80=AFAM Stefan Berger <stefanb@linux.i=
bm.com> wrote:
> >>
> >>
> >>
> >> On 7/14/23 13:29, Joelle van Dyne wrote:
> >>> On Fri, Jul 14, 2023 at 9:19=E2=80=AFAM Stefan Berger <stefanb@linux.=
ibm.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>>
> >>>> I don't know whether we would want multiple devices. tpm_find() usag=
e is certainly not prepared for multiple devices.
> >>> Sorry, "multiple TPM interfaces" here does not mean "at the same
> >>> time". Will clarify the description.
> >>>
> >>>>
> >>>>
> >>>> Good for the consolidation.
> >>>>
> >>>>
> >>>> Does moving the TIS to a different address help on aarch64?
> >>> That was the first thing we tried and no it doesn't help.
> >>
> >> I would remove it if we don't have a known alternative address that ma=
kes it work. If we do, I think we should document it in tpm.rst.
> > "It" is referring to tpm-tis-device? Note that it does work fine with L=
inux VMs.
>
> yes, tpm_tis_sysbus and I know it works with Liunux but I see this discus=
sion here around Win 11 on aarch64. Why do we need to user another address =
than the standard address if for Win 11 on aarch64 it doesn't get it to wor=
k.
The standard address won't work for Linux either.

TPM TIS on standard address on ARM64 Virt machines =3D collision with
DRAM, will not instantiate
TPM TIS on SysBus with dynamically allocated address =3D works on Linux,
cannot start on Windows

>
> >
> >>
> >>
> >>>>
> >>>> Can the size really be an option? I don't see it useful and if one g=
ave the wrong size it may break things.
> >>> It was added for consistency (otherwise we have to determine the size
> >>> by looking at the interface everywhere). Also, it is possible for the
> >>> size to be larger than the constant. For example, Apple Silicon uses
> >>> 16KiB page sizes and we may decide to force the device to be 16KiB
> >>> aligned (not sure if this is needed yet while we still track down why
> >>> the dual mapping was not working). In that case, we would need to
> >>> inform the OS of the true region size to prevent any overlap issues.
> >>> Both baseaddr and size should be provided only by the plug handler in
> >>> the virt machine, otherwise things may break even if we get rid of
> >>> size and have just an incorrect baseaddr.
> >>>
> >>>>
> >>>>
> >>>>

