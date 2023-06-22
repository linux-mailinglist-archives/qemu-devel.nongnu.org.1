Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA5373A235
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 15:54:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCKkc-0005D4-O1; Thu, 22 Jun 2023 09:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCKkT-0005Cb-SN
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:53:22 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCKkR-0005Mm-PG
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:53:21 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51be61663c8so1051821a12.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 06:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687441998; x=1690033998;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t0AIVt6PJJLRYHimfReCtlFpsshxhGM7Mx5qiiWBZtc=;
 b=b7ohX1TAlKbGixTdd4kOCJNFiTrrdke6jl5qYMpTYjR/79ddlBskFr6IncddaLferK
 9vpA5Wv6bdwL97rq5bh2N6HMeSg2o/YDU3evSaVscLoNQqFI9R3l3H3gccTOI2+W8phf
 gpjVRjW6HAzmeYZbl5+G4AIs2wkXSx1SrQ9fPZrvhV3XKvomRh2qr4Jyo06g2sDv/prM
 Z9TsUavPtkzMDl4o9EAQQDQkeyFdAt/YP7TENphJY5nB9TwcFq+k1SnY6VFgEihqoSZM
 COFpM/MRDIDj4e6hQgpNYbt4jw9GczP2qyBbA5N4uDFEOqNHCizm+rzhkwu44Bez3Oh2
 Fe7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687441998; x=1690033998;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t0AIVt6PJJLRYHimfReCtlFpsshxhGM7Mx5qiiWBZtc=;
 b=eNBO3ely7kLtASPzeABJLX7kFgVwZD0F+a7r9IRloR5zR65jlO9zNY/utQ8WNb+4x5
 WiOEbRQnWmWa2E5ZNs9+1lk5ZtZAsVPYpVnvxj/JuE0EP5HMuzDyRMDN0skzFr+cO7Ti
 RxAFzChlN9S15N+oe9GSQ0OZATetPUqAmYgFw9VAx24SFzsVddwVMWBnyjpLsJFPuE/b
 fECEaEABmiQ4nfKJsBh9rdqC48RSm+DQJugrKSHAwMaw7vrOG8JcyYdgxed0DnzwSMM7
 rGkRmmqqk5igCgSysQ6mFvIfz5LyZmAuW8Typ3TjzDoL7+ro5J8OsPjFuYzPtolXYUvq
 NYtA==
X-Gm-Message-State: AC+VfDyDkKFjvp0LX9dgWGs5fmUDE8Y6wwFIXFlfnm5kudhwtWij/UXb
 Et9B27ruTrcuVjW9hHKW6GISXPEKjJIQex/3l/7ENA==
X-Google-Smtp-Source: ACHHUZ4esE9ptcqSc6j4EVtx59wDKVstAJ/DRHezH2gDvkjlZYZow1SWHWbYMSH44WFPGKQ9n63sqTvEawrQlPly47A=
X-Received: by 2002:a50:ee14:0:b0:51a:59d1:fb37 with SMTP id
 g20-20020a50ee14000000b0051a59d1fb37mr9505832eds.28.1687441998010; Thu, 22
 Jun 2023 06:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230620195054.23929-1-lvivier@redhat.com>
 <20230620195054.23929-3-lvivier@redhat.com>
 <CAFEAcA_r31PU1LRka36dSJ6vZ2boP33MB=Ns5hDMRrSTN1Lmag@mail.gmail.com>
 <269b9686-f7df-72de-ae6b-242767feccaa@redhat.com>
In-Reply-To: <269b9686-f7df-72de-ae6b-242767feccaa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jun 2023 14:53:07 +0100
Message-ID: <CAFEAcA8ecCgYiL=QUmerTkF3e0hT-+0GGo=mZ9BmAkR2uy4GVg@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm_crb: mark memory as protected
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 jasowang@redhat.com, mst@redhat.com, David Hildenbrand <david@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, marcandre.lureau@redhat.com,
 eric.auger@redhat.com, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 22 Jun 2023 at 14:39, Laurent Vivier <lvivier@redhat.com> wrote:
>
> On 6/22/23 15:12, Peter Maydell wrote:
> > On Tue, 20 Jun 2023 at 20:51, Laurent Vivier <lvivier@redhat.com> wrote=
:
> >>
> >> This memory is not correctly aligned and cannot be registered
> >> by vDPA and VFIO.
> >
> > Isn't this a vDPA/VFIO problem? There's no requirement
> > for RAM MemoryRegions to be aligned in any way. Code
> > that doesn't want to work with small or weirdly aligned
> > regions should skip them if that's the right behaviour
> > for that particular code IMHO.
> >
>
> Marc-Andr=C3=A9 proposed to modify vDPA code to skip the region but Micha=
l disagreed:
>
> https://lists.nongnu.org/archive/html/qemu-devel/2022-11/msg03670.html

"Special case the TPM device in the vhost-vdpa" is clearly also
not the right way to solve the issue, so I agree with Michael
about that.

The vhost-vdpa code already seems able to correctly detect
whether a region is unaligned and ignores it. If that's the
right thing to do, maybe we should just remove the
error_report() ? Listeners are going to see MemoryRegions
which are RAM and which aren't necessarily page-aligned,
so they should handle them, not complain about them.

thanks
-- PMM

