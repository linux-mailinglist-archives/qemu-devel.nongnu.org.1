Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7BA80A1AB
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 12:00:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBYZm-0002Bj-79; Fri, 08 Dec 2023 05:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rBYZi-0002BA-TJ
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 05:59:20 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rBYZg-00078f-Tv
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 05:59:18 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-54bf9a54fe3so2783599a12.3
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 02:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702033155; x=1702637955; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qkjgn4ZvUHpr4/3qC3pPsfAMu7ry/ihF7Qc14QbAkKw=;
 b=VWkPnzkfjbjiv1h9x7yovnB7yA8c508Ku1Ypa9/g2Buv4r8fpLVQaMX2sZuyywzOlj
 vIl5bWqI0FrVBAnXbrSkEHtSu0kuUYo3VQUt0lBRciY9TnmZ/kMULZU7bQ0OqsZNyFPs
 bbvJ3iqf3XNxLgF25MMhxAsIb8jmLZmJZx4UCZ6LnXQUTZqoFFHI3gFEuNEvM/ARpyx8
 0QihqR+8yrZ52jbbHOA9tA/Z40EuvF831O3sPN2Atskrm8B6assCoo7b29NL09Q3mPy+
 IY5+3Rpa8IDFThGS+VXkL+14DRhW2qdYfy/WmXpQduWLUegxEhBcoEV0hxMZX21lpXoq
 7F8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702033155; x=1702637955;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qkjgn4ZvUHpr4/3qC3pPsfAMu7ry/ihF7Qc14QbAkKw=;
 b=QMc1gVntlG6KxftbKzquIT1Cri2pOsDA0xbc1ZFUs3uPtRncUWe+Hv4EvurjujgoSJ
 lg5P7PyesLkBFqAApZddKKNCLVicndFZS96iS+zJew1wyV1/f7H8E5iwot5+IgrDBTn7
 IgUwYjrlm5NLINAKMNYPdkXnHVYAhBE/bskq+ivQ2yn7jEVSPiryBkFpYDaiP5174g5B
 5VE3Bbmo8GtmiYydaBho1vXZMB4em+iZ0xver/vnETY2Wn+vQ8ylv6FRXy4pcBPx5Q0v
 UXoV4IW7TvRcgqX1GaWrEA1eZvmWK/rjJGbCWsuCcAsIC1udWodXwSE20DEEBqPptpha
 nBvQ==
X-Gm-Message-State: AOJu0YwGV2FAPumQZgcHG+ea+RlWi4n/tvPNW4epB/22Ts8B/NiG+Jks
 s/RC7BFu/fGr2FgsE0LesBjRwHavMwtQbxliMHOsog==
X-Google-Smtp-Source: AGHT+IHSH2BX+n+iWKMVbpkncXYwy6UARP2osuDuEL9sVT+ph2vIcU9f2ob/uXO3Ixhg1zwGRXAYjDleC/egBFh/nxo=
X-Received: by 2002:a50:d74f:0:b0:54c:4837:9a8d with SMTP id
 i15-20020a50d74f000000b0054c48379a8dmr2081349edj.52.1702033155357; Fri, 08
 Dec 2023 02:59:15 -0800 (PST)
MIME-Version: 1.0
References: <277e21fc78b75ec459efc7f5fde628a0222c63b0.1701989261.git.m.a.young@durham.ac.uk>
 <ZXLg_YCHM-P6drQV@redhat.com>
In-Reply-To: <ZXLg_YCHM-P6drQV@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Dec 2023 10:59:03 +0000
Message-ID: <CAFEAcA8HXWEPbx2fKEg_kscdEnNpGCJVO9jqgD1YDpULYp_yDw@mail.gmail.com>
Subject: Re: [PATCH] fix qemu build with xen-4.18.0
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Michael Young <m.a.young@durham.ac.uk>, qemu-devel@nongnu.org, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Fri, 8 Dec 2023 at 09:25, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> CC'ing the Xen folks
>
> On Thu, Dec 07, 2023 at 11:12:48PM +0000, Michael Young wrote:
> > diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
> > index 6f09c48823..04b1ef4d34 100644
> > --- a/include/hw/xen/xen_native.h
> > +++ b/include/hw/xen/xen_native.h
> > @@ -532,7 +532,7 @@ static inline int xendevicemodel_set_irq_level(xend=
evicemodel_handle *dmod,
> >  }
> >  #endif
> >
> > -#if CONFIG_XEN_CTRL_INTERFACE_VERSION <=3D 41700
> > +#if CONFIG_XEN_CTRL_INTERFACE_VERSION >=3D 41700
>
> This change is not correct
>
> We can see the upstream change was introduced in 4.17:
>
>   $ git describe  2128143c114
>   4.16.0-rc4-967-g2128143c11
>
> IOW, if we have 4.17 or newer these constants already
> exist. If we have 4.16 or older, then we need to define
> them to provide back compat.

Wouldn't that suggest we want "< 41700" ? Or did 4.17 have
some issue that means we need the back-compat there too?

thanks
-- PMM

