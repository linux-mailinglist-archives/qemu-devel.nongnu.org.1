Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4907C9D42
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 04:00:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsCtE-0006dO-L4; Sun, 15 Oct 2023 21:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qsCtC-0006d5-Ar; Sun, 15 Oct 2023 21:59:26 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qsCtA-00057f-Ep; Sun, 15 Oct 2023 21:59:26 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9936b3d0286so646824466b.0; 
 Sun, 15 Oct 2023 18:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1697421562; x=1698026362; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k0WOLpHhSf2HakUYTgs5AWCSxD3KIR7UsaoQsjnZ5Fw=;
 b=YjRN3BWxvJvz057vlxBrlW6ulxb6ZId3tlLeqfmmg/gDTmyJlO9BPiBCaFxRH2yVAY
 +BN0n+7/9BQi5Htiqollyle52UP16+R2c8xbzar5p2uglkw47FnMEy9RZVejubW2vwSG
 H4kUDcN3A3S1o9UpbxVwnzgZ89kzWONbEUJwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697421562; x=1698026362;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k0WOLpHhSf2HakUYTgs5AWCSxD3KIR7UsaoQsjnZ5Fw=;
 b=EILN+umutf8/m2icvGWy7HRvI+Ew/JDPqzlrM44foGRhtxr4yjGzVkhv8Zutky+wlF
 uJcYZ/jk2lAIykgyICk2mGRfmZ+u3CnKi2+Cy3MmKV5hjvuF62yyXyHn7YCMSpmTGx5d
 pCWLhvWx4ehGo+8ShPMUnpL/dcIdCwmpfZNS9TxgKiaIFqVF4p8TtXm0x4lIvC5a2FOz
 FxX2F+KHgch3E0HJ1cQCir2jyw00EeeLfirimlf5meSwAXukhYdTspnfwmBNRARFtL1V
 b4Q2fCgJxNNqsfuubidgSGfQyeHlAlIq8Mgx8/5sF7S16cuHmp4O00POOsOFMYg9pCR9
 bZHw==
X-Gm-Message-State: AOJu0YzV7LrDGga6fDWc6SH7u4lF0xzK0hEjvEk4x+e93SgHg3/sHPcO
 ws9ewPartbDmc0YgZ+dD1C24qpf1CzRDXaaOpMc=
X-Google-Smtp-Source: AGHT+IEQhA2rKzFwJ3B5u3BVDSGZ4IeUvo+w6RcR/IaNFVOqSHxk0OkOntf2AxsKeYPEUUalxnhnpL+yBv74UG7qo4k=
X-Received: by 2002:a17:906:3ca1:b0:9b7:37de:6009 with SMTP id
 b1-20020a1709063ca100b009b737de6009mr26089322ejh.3.1697421562229; Sun, 15 Oct
 2023 18:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-12-npiggin@gmail.com>
 <CACPK8XeLPd3yw=+jBtc1mj94cxF3e1HAaSZ-4mubh5XV4tvgXg@mail.gmail.com>
 <CW526IRMLS2I.85TF1PIVGU0I@wheely>
In-Reply-To: <CW526IRMLS2I.85TF1PIVGU0I@wheely>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 16 Oct 2023 12:29:11 +1030
Message-ID: <CACPK8XdMZtufr3PPvN5o-4=9Ef6+XsPjRM4g2BWaC8C5Wb9SnA@mail.gmail.com>
Subject: Re: [RFC PATCH 11/11] ppc/pnv: Change powernv default to powernv10
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, 11 Oct 2023 at 07:28, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> On Tue Oct 10, 2023 at 10:05 PM AEST, Joel Stanley wrote:
> > On Tue, 10 Oct 2023 at 18:24, Nicholas Piggin <npiggin@gmail.com> wrote:
> > >
> > > POWER10 is the latest IBM Power machine. Although it is not offered in
> > > "OPAL mode" (i.e., powernv configuration), so there is a case that it
> > > should remain at powernv9, most of the development work is going into
> > > powernv10 at the moment.
> > >
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> >
> > Do we need to update the docs?
>
> What did you have in mind? Add some powernv10 examples?

Nothing in mind. The docs don't actually mention which cpu is the
default, which has the upside of us not needing to update it.

Cheers,

Joel

