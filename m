Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9589A79D35E
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:16:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg4AE-0007Tz-EG; Tue, 12 Sep 2023 10:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg4A0-0007Qp-Sq
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:14:37 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg49y-0000av-Id
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:14:36 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9ad8d0be93aso124737266b.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694528072; x=1695132872; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PbTg3+2gfAtUMJssZQ4fs8JcnXIDf2UKyBh5zojAQd4=;
 b=mn62tvYMZHsv/HAJmrlUtFtMKEA16E/wXwRg+QcYhOnoAyhpzvxEJK9SYgu0FyQ/vp
 duao0QHLV5pVV7c3BRw1LjgqWLreooWTGhKkiX6RjEIxV/KL8FMQGT+RwAsti6m1UCeZ
 vaY+Jq12ucMjypeIS21pjqnLnh0sbemtxXUuKPYdnsDSpAqoNN8TYdV3knUj9MCQoy1r
 +7YOwJ6Wb9tbFAenS79M1XgGTpgFPz08bRkGZq3GKVD+3LC2bl/TeStK4DGS6Crw9Qfb
 avMTfaACtKS0/OpdOmqAyFv5h8/OqtnQPaQoYrZE5webFuqBHRS2yx4SI4qbvvNrftkl
 1d+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694528072; x=1695132872;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PbTg3+2gfAtUMJssZQ4fs8JcnXIDf2UKyBh5zojAQd4=;
 b=KaqXGmAVZstJ6XwZo1ROAOcxCz7bcgwnB3QF3ZjCdKrK8a9JQJMS3LpTF49Fd+KJLa
 d+8cpzlbV6raahpNkGI28HxMxPNIRm8uuhK5+E5eDk/tDvkgzscgdZgBYZvipR4bhRsn
 knUKRv3jJAVS4iwi6c68XLEWrRkrMCzcqSAJkTWDS2boxBcfuxv29IWy8SIUYgrfmVcl
 LxcmA5X7iBwghMpYDzYiHVEQIMi47xHlSKRKivegcIlUvAxHeuzgEMkzlEjn8vQTZlBQ
 6kWu46deLKSqfwhjNo5EnoD3KDliaKX8wJyFbJUPHBdXHAwX8G7ih0Z97ePG6iystmHB
 KOaw==
X-Gm-Message-State: AOJu0YzQJB4k2rZ4RZME1uE3QgcV2AaECH4xhH+Yq27nmZzyoEGVqgOJ
 Y74KssktZcIvw05noHH+nb8qfQW9CXyfSJS78OKdmso6S1ED5lFk
X-Google-Smtp-Source: AGHT+IE2nYW+NHBVqgqUISTu2Q23HJcdyBSILUaiOUrF/iO/+whaqViNAUVnRqP1u4sLph5OQxlU5W+vefhxl9cH0AI=
X-Received: by 2002:a17:907:72d1:b0:98e:4f1:f987 with SMTP id
 du17-20020a17090772d100b0098e04f1f987mr3680915ejc.3.1694528072002; Tue, 12
 Sep 2023 07:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230801154451.3505492-1-peter.maydell@linaro.org>
 <CAFEAcA-=HX59+S89oOu1QN_VQwzC2-V5RC=Qmx6wazHDfY9z-A@mail.gmail.com>
In-Reply-To: <CAFEAcA-=HX59+S89oOu1QN_VQwzC2-V5RC=Qmx6wazHDfY9z-A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2023 15:14:21 +0100
Message-ID: <CAFEAcA9W=XHPz2J=5OGY6msi15NeAgVR9mdc6m1+6K6jeOa8Pg@mail.gmail.com>
Subject: Re: [PATCH] target/m68k: Add URL to semihosting spec
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 29 Aug 2023 at 16:48, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 1 Aug 2023 at 16:44, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > The spec for m68k semihosting is documented in the libgloss
> > sources. Add a comment with the URL for it, as we already
> > have for nios2 semihosting.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  target/m68k/m68k-semi.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
> > index 239f6e44e90..80cd8d70dbb 100644
> > --- a/target/m68k/m68k-semi.c
> > +++ b/target/m68k/m68k-semi.c
> > @@ -15,6 +15,10 @@
> >   *
> >   *  You should have received a copy of the GNU General Public License
> >   *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> > + *
> > + *  The semihosting protocol implemented here is described in the
> > + *  libgloss sources:
> > + *  https://sourceware.org/git/?p=newlib-cygwin.git;a=blob;f=libgloss/m68k/m68k-semi.txt;hb=HEAD
> >   */
> >
> >  #include "qemu/osdep.h"
> > --
>
> Ping for review? I can take this through the arm tree if
> you don't have an m68k pullreq planned.

Picked up for target-arm.next.

-- PMM

