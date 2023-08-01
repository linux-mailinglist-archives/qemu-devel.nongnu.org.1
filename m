Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B1E76A68F
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 03:48:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQeU8-00016e-49; Mon, 31 Jul 2023 21:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qQeU4-000165-Hl
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 21:47:36 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qQeTp-0008Ih-20
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 21:47:33 -0400
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-1bb775625e2so33234105ad.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 18:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690854426; x=1691459226;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rW9fvq+/IzSh13UDxvaI2F3DsmsKlzHnFw3Ir6bz7zg=;
 b=A2kZdB46pa3JOUnvuhMW7VvhCia0oOYLPRhamtoVp5DdyAP+4SDd9tlt63d8dkD+Be
 UyG+fg1ZGc94sMHoL+xHND6moHTxeeSiRQWduiIbVj/1RmvbHQQtYKvyE0BiNTHxGsf7
 2B+k5ZsND8hGJHeYNDAwycClK1bcJEoZnp00D7LXPEXbPdRIXeTdyr4CgyNXhwibLe+V
 d8qRxcXzq30yOitVsOkzP5b5pU6tZWoO8syYZxlqBSCUYznvDPzK/7YYncnim1YPjk/D
 uxxgFduCEjLzCcT+nHYwzJYlGGxFdjILMZ88mGiqYuYJaU7KtpEzbLTCpA5LoN03aUsT
 a7WQ==
X-Gm-Message-State: ABy/qLYaGvn1XDs8F1hYF08iYAatEfYIs7BqYCNdDvAbXTSiA+aN7PDn
 5tQI016IRnSwcsfBXpBvFz7sOMdnTq4=
X-Google-Smtp-Source: APBJJlEpN9a28YBQvLEGME+COnZytq7YZDylt7PE4Dn3nGWf4MSQpMBBU+T2P3BnlW4mQVs+SOPECg==
X-Received: by 2002:a17:902:6943:b0:1b8:6984:f5e5 with SMTP id
 k3-20020a170902694300b001b86984f5e5mr11043231plt.12.1690854426371; 
 Mon, 31 Jul 2023 18:47:06 -0700 (PDT)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com.
 [209.85.216.48]) by smtp.gmail.com with ESMTPSA id
 x13-20020a170902a38d00b001b9cf522c0esm9322920pla.97.2023.07.31.18.47.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 18:47:06 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2681223aaacso3275508a91.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 18:47:05 -0700 (PDT)
X-Received: by 2002:a17:90a:d915:b0:268:798:a28b with SMTP id
 c21-20020a17090ad91500b002680798a28bmr13830055pjv.23.1690854425558; Mon, 31
 Jul 2023 18:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-6-j@getutm.app>
 <20230717154630.64759bd1@imammedo.users.ipa.redhat.com>
 <efb02b9c-e8ff-c78f-b4c0-10dc0f41bb16@linux.ibm.com>
In-Reply-To: <efb02b9c-e8ff-c78f-b4c0-10dc0f41bb16@linux.ibm.com>
From: Joelle van Dyne <j@getutm.app>
Date: Mon, 31 Jul 2023 18:46:54 -0700
X-Gmail-Original-Message-ID: <CA+E+eSBJkXJKJq6_6y3UtyJ5KbonwhRvCb1=Pb9RQer=XXwpRQ@mail.gmail.com>
Message-ID: <CA+E+eSBJkXJKJq6_6y3UtyJ5KbonwhRvCb1=Pb9RQer=XXwpRQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] tpm_crb: use the ISA bus
To: Stefan Berger <stefanb@linux.ibm.com>, Alexander Graf <agraf@csgraf.de>
Cc: Igor Mammedov <imammedo@redhat.com>, Joelle van Dyne <j@getutm.app>,
 qemu-devel@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.214.174; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f174.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jul 18, 2023 at 7:16=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
>
> On 7/17/23 09:46, Igor Mammedov wrote:
> > On Fri, 14 Jul 2023 00:09:21 -0700
> > Joelle van Dyne <j@getutm.app> wrote:
> >
> >> Since this device is gated to only build for targets with the PC
> >> configuration, we should use the ISA bus like with TPM TIS.
> >
> > does it affect migration in any way?
> >  From guest pov it looks like there a new ISA device will appear
> > and then if you do ping pong migration between old - new QEMU will real=
ly it work?
>
>
> >
> > If it will, then commit message here shall describe why it safe and why=
 it works
> >
> I would just leave the existing device as-is. This seems safest and we kn=
ow thta it works.
>     Stefan

Alexander, do you have any comments here? I know you wanted to move
away from the default bus. The concern is that switching from the
default bus to the ISA bus may cause issues in migration. The current
course of action is to drop this patch.

