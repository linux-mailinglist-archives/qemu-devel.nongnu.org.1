Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5587E792F98
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 22:09:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdcKy-0002Yx-BP; Tue, 05 Sep 2023 16:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qdcKx-0002Yp-Db
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 16:07:47 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qdcKv-00026Z-Bw
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 16:07:47 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-41205469f4eso1348311cf.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 13:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693944464; x=1694549264; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9aRAXt+ECrlaHhlCgYZb491ZS13e3fbXJXvD215Zmqc=;
 b=ARyqx0SzfuWhxt3Ahiiw5qqSr5etl0hGH1iRS0PIbY65SyBUEaeoAIJfTl3GEQgsjp
 Rq6zysNCJ4r7a8Gv2vVPRIqlv3u4oyCkVguP9KBueP2+6naFa3p84o11aji2PCoy8xfk
 RcNXQlQa6OYQNpLSghE7z/Xz3IgdmZ7NFDVx4Ydm/YezT9DHXIs0cmA7JwJk3+uqr2nO
 wkJxgCC6LCCnh56dEqXk6nK5pY/dwY2FH6KB25XOQ4VupsbPdFAV9/WUFtDsHBz3xnDv
 8FhzoQw0FBuNkY3Y8cN2ZTGs0PfgQNjuJQEQu/lB8M1K6W92ZhjLPSSjymK02xLHV7mu
 bzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693944464; x=1694549264;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9aRAXt+ECrlaHhlCgYZb491ZS13e3fbXJXvD215Zmqc=;
 b=cwx76sSjdhKKKO8Rex5uLgi2DlVlo6R08D9KaN8N2Tw9d2sBzwBf9kzxXmqIiEX9CM
 mAz8unrIyvwk2Z51e97k7k2n+1x86oHEQz3UBCpv2vC3eu9iMA8pJ5PGXJqm6MBdgykX
 Y5Tm+24dHD0sBXOyf98lE8BPCXn86z3vhilzXUcwgQPZvgfIdW4+8VUVnhGAd/y7p05S
 JUkZIHVOZsZfOjakU4/ogAuXViA3RjSvxKGnjlbvq/OEg3MlOeWm6bFz8aMxndU3k47l
 FDd+IZO4WysZpZZ9Q6amtaMa4tVyT9GwK78e/e/3KTquwdD6htyjaP2qcKyhu1B/pTDQ
 BZkQ==
X-Gm-Message-State: AOJu0Yyd5ia//62xjUgMin3fHDotZ44vQzLZtWoSkdJmr+KWyHGh2jn1
 +YeMP1U/JP3i+9fCJ7KSPZL8IXWzcKKqECn6aGM=
X-Google-Smtp-Source: AGHT+IGiJAPPfJwW5JVliuSdhnShZhacN8Ax1l5thE2P58X74+XcPoz/SL3lbqagAYU1xOW/CEKmaj2aP3KgwK7Oduw=
X-Received: by 2002:a05:622a:1055:b0:403:abf5:6865 with SMTP id
 f21-20020a05622a105500b00403abf56865mr20134241qte.18.1693944464044; Tue, 05
 Sep 2023 13:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-66-marcandre.lureau@redhat.com>
 <cb0e2856-afdc-294b-d111-28be168eeed2@eik.bme.hu>
In-Reply-To: <cb0e2856-afdc-294b-d111-28be168eeed2@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 6 Sep 2023 00:07:32 +0400
Message-ID: <CAJ+F1CLxP7-8AS-4zSNLYtNVX_ZgR1rEBHzxgmCv3oJOiNU22g@mail.gmail.com>
Subject: Re: [PATCH 65/67] ppc/kconfig: make SAM460EX depend on PPC & PIXMAN
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
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

Hi

On Wed, Aug 30, 2023 at 4:35=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Wed, 30 Aug 2023, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > SM501 is going to depend on PIXMAN next.
>
> Why is this patch needed when SM501 is the one that depends on PIXMAN and
> should pull in the dependency? Also what's the change in default.mak?

(see Paolo answer)

> ati-vga also uses pixman and currently has no fall back.

Indeed, and it is disabled not by Kconfig but by meson:
system_ss.add(when: [pixman, 'CONFIG_ATI_VGA'], if_true:
files('ati.c', 'ati_2d.c', 'ati_dbg.c'))


> The sm501 already
> has fallback when pixman fails so could work without pixman too, see
> x-pixman property in sm501.c.

Correct, I have changed it to conditionally compile x-pixman related code.

thanks

