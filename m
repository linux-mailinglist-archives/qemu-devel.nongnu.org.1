Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CF17DBE60
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 17:57:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxVYU-0006Ng-Vi; Mon, 30 Oct 2023 12:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qxVYO-0006NJ-2O
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:55:52 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qxVYL-0007XH-O2
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:55:51 -0400
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-1cc3c51f830so9836805ad.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 09:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698684947; x=1699289747;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+YTfH4r+D8zgtnLySu9dtkNtqWi6jmhqaDkKG183c0s=;
 b=ZqXJjirYgw1t7KMckZoo7cvm4VaW4yfuIpjesEHViSiT2rmZcoUSaE2KT6A0InC8ei
 SqXu7B4yPA4yP6qQNRvsOx5EjOMd6eDR+UQS7IaEE+61pcZ2k9yee5g6SIYFZKdNmm1B
 mZOSGt1N00/QZdwketwUZcaQCKgz+0wrrc4qVTJHJrrQmMDM4mxoAV8ueTLKTezfw5Cu
 cpbiidJA1wIe+cz9GpcrxHqNdQGFk6/bvfMGnlElNey2dgvtJKzTX1xJKOPjDh6pA8p0
 XwFXCtCa2G3ZBqBjXV7M1HyTqo3E6qqkZnPkxrmg7+/EdzwsDT8YNhFwBcPeu0liazIt
 2o7Q==
X-Gm-Message-State: AOJu0YxRrgQmLIM9e/TrjVeiHGpfFuhknWvYhtBynaWhui9zHPS0R6/V
 qTGXPG2HP3lS6IIeBQoba0PYED2cF6o=
X-Google-Smtp-Source: AGHT+IGTlbP6JM3mFAlT7cXa4lqbI5dSZ/jUJsAu9kYJ9RZfOjJwxvZqR5/7KI2WSku7v7bUhfBX7Q==
X-Received: by 2002:a17:903:124e:b0:1ca:e92f:e7f4 with SMTP id
 u14-20020a170903124e00b001cae92fe7f4mr9186488plh.28.1698684947243; 
 Mon, 30 Oct 2023 09:55:47 -0700 (PDT)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com.
 [209.85.214.182]) by smtp.gmail.com with ESMTPSA id
 y24-20020a1709027c9800b001cc1f504082sm6322179pll.56.2023.10.30.09.55.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 09:55:46 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-1cc0d0a0355so28924095ad.3
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 09:55:46 -0700 (PDT)
X-Received: by 2002:a17:903:1054:b0:1ca:296d:8ff6 with SMTP id
 f20-20020a170903105400b001ca296d8ff6mr6655846plc.38.1698684946617; Mon, 30
 Oct 2023 09:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231029060404.71196-1-j@getutm.app>
 <20231029060404.71196-7-j@getutm.app>
 <998ed878-6cf2-42e3-a764-a2d222bf914c@linux.ibm.com>
In-Reply-To: <998ed878-6cf2-42e3-a764-a2d222bf914c@linux.ibm.com>
From: Joelle van Dyne <j@getutm.app>
Date: Mon, 30 Oct 2023 09:55:35 -0700
X-Gmail-Original-Message-ID: <CA+E+eSDTNt2SQGoGkQVOfcVWswhOqio95vSROGj1JH6Y0M0EaQ@mail.gmail.com>
Message-ID: <CA+E+eSDTNt2SQGoGkQVOfcVWswhOqio95vSROGj1JH6Y0M0EaQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/14] tpm-sysbus: add plug handler for TPM on SysBus
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.214.172; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f172.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

I was debating what to add. I couldn't find a project-wide template
for what the header should be and I couldn't copy/paste from where I
copied the code from (virt.c) because it names a specific author that
I'm not sure wrote this code... Any advice?

On Mon, Oct 30, 2023 at 9:52=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
> On 10/29/23 02:03, Joelle van Dyne wrote:
> > TPM needs to know its own base address in order to generate its DSDT
> > device entry.
> >
> > Signed-off-by: Joelle van Dyne <j@getutm.app>
> > ---
> >   include/sysemu/tpm.h |  4 ++++
> >   hw/tpm/tpm-sysbus.c  | 33 +++++++++++++++++++++++++++++++++
> >   hw/tpm/meson.build   |  1 +
> >   3 files changed, 38 insertions(+)
> >   create mode 100644 hw/tpm/tpm-sysbus.c
> >
> > diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> > index 1ee568b3b6..ffd300e607 100644
> > --- a/include/sysemu/tpm.h
> > +++ b/include/sysemu/tpm.h
> > @@ -12,6 +12,8 @@
> >   #ifndef QEMU_TPM_H
> >   #define QEMU_TPM_H
> >
> > +#include "qemu/osdep.h"
> > +#include "exec/hwaddr.h"
> >   #include "qapi/qapi-types-tpm.h"
> >   #include "qom/object.h"
> >
> > @@ -78,6 +80,8 @@ static inline TPMVersion tpm_get_version(TPMIf *ti)
> >       return TPM_IF_GET_CLASS(ti)->get_version(ti);
> >   }
> >
> > +void tpm_sysbus_plug(TPMIf *tpmif, Object *pbus, hwaddr pbus_base);
> > +
> >   #else /* CONFIG_TPM */
> >
> >   #define tpm_init()  (0)
> > diff --git a/hw/tpm/tpm-sysbus.c b/hw/tpm/tpm-sysbus.c
> > new file mode 100644
> > index 0000000000..ef0592b837
> > --- /dev/null
> > +++ b/hw/tpm/tpm-sysbus.c
> > @@ -0,0 +1,33 @@
>
> A header in this new file would be good. Otherwise LGTM.
>
>    Stefan
>
> > +#include "sysemu/tpm.h"
> > +#include "hw/platform-bus.h"
> > +#include "hw/sysbus.h"
> > +#include "qapi/error.h"
>
>
>

