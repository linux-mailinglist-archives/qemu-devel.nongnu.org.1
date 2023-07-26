Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2514762B91
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 08:37:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOY8F-0006Qc-Fh; Wed, 26 Jul 2023 02:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qOY82-0006QG-0h; Wed, 26 Jul 2023 02:36:11 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qOY7y-0004U9-5m; Wed, 26 Jul 2023 02:36:08 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99b9161b94aso479056766b.1; 
 Tue, 25 Jul 2023 23:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1690353362; x=1690958162;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qtWy4Qr3W53Jne3KHksCdYtdSKDVEhLq+YRssUDNl6U=;
 b=kSbQQg52pOzq4dwobVY+sg9moYwwLI8SciXcF9JjfBO1mYpHyLdJMFtqRLm1+jRNKl
 EWmN+zyD74P+NeO2CYTRchPQvWPOHhpfVPqbMY6f2oMNUeLh3BEjcov1Q/gxydKJKtXn
 qx1VFwK2tu/kV78sLKnTnVQU3+ui+yo+yEymY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690353362; x=1690958162;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qtWy4Qr3W53Jne3KHksCdYtdSKDVEhLq+YRssUDNl6U=;
 b=Ctx3u2RFY8VULHMz5SMI1D4yGiy2T/mqL3daL7yig18FQygfIkE51u+z8ESMElsnfg
 iTy7INlMU6TgfZq9b91vL/wiHuo+gXwgTxfkIKYS2APZdQkUuGEkrJKnpCrQkfz4/cP6
 jp2ggYCCZ4C9O4saI0+Umk9fiyNpArAvvxj793HF0U368szWrpKwXYJgHqXK72LxpcvQ
 2cod/Nkb6aw3xT1Vy5VcBfVi+gfy3QXUqdRbN6oDFUy8smjj7aTMjbeJHbxBlAuzmdgs
 fsXm4pKhCdI2o2StO4S3+gik7ryrRUXVW0OFGqAXZmD4e2cwqgR/VTFY0dKqoEXMSxLW
 mVCQ==
X-Gm-Message-State: ABy/qLYRoxQA1BGxxHddjHRJilOs8w/42UTmXxTAVgO8BCsPlhxUAhYh
 oFTORJehu4/EaW+tfBZTFGouBcZYPS1R6mDIXmk=
X-Google-Smtp-Source: APBJJlHK+arAvwWcqDQ8xp25YWZ6K8PtonYQrOMt5PxKJQDH3VhFxMj4eemC91qGqvPoWFXQ7lz3veZcfRNymFeb1AM=
X-Received: by 2002:a17:907:75c8:b0:994:1fee:3065 with SMTP id
 jl8-20020a17090775c800b009941fee3065mr893093ejc.15.1690353361963; Tue, 25 Jul
 2023 23:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230711085903.304496-1-npiggin@gmail.com>
 <a18e346fc0e38f1014f5484e0b1ef27a7bc8cb41.1689073223.git.quic_mathbern@quicinc.com>
 <CTZTUVQXKUGA.11SSOS1KIFLZK@wheely>
In-Reply-To: <CTZTUVQXKUGA.11SSOS1KIFLZK@wheely>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 26 Jul 2023 06:35:49 +0000
Message-ID: <CACPK8Xf-fa4qKZpgg4FvMkgzwbqgP1rh4=qLmv12N1JFcBn3Cg@mail.gmail.com>
Subject: Re: [PATCH] gdbstub: Fix client Ctrl-C handling
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 alex.bennee@linaro.org, 
 fbarrat@linux.ibm.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, 12 Jul 2023 at 02:12, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> On Tue Jul 11, 2023 at 9:03 PM AEST, Matheus Tavares Bernardino wrote:
> > > Nicholas Piggin <npiggin@gmail.com> wrote:
> > >
> > > diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> > > index 6911b73c07..ce8b42eb15 100644
> > > --- a/gdbstub/gdbstub.c
> > > +++ b/gdbstub/gdbstub.c
> > > @@ -2051,8 +2051,17 @@ void gdb_read_byte(uint8_t ch)
> > >              return;
> > >      }
> > >      if (runstate_is_running()) {
> > > -        /* when the CPU is running, we cannot do anything except stop
> > > -           it when receiving a char */
> > > +        /*
> > > +         * When the CPU is running, we cannot do anything except stop
> > > +         * it when receiving a char. This is expected on a Ctrl-C in the
> > > +         * gdb client. Because we are in all-stop mode, gdb sends a
> > > +         * 0x03 byte which is not a usual packet, so we handle it specially
> > > +         * here, but it does expect a stop reply.
> > > +         */
> > > +        if (ch != 0x03) {
> > > +            warn_report("gdbstub: client sent packet while target running\n");
> > > +        }
> > > +        gdbserver_state.allow_stop_reply = true;
> > >          vm_stop(RUN_STATE_PAUSED);
> > >      } else
> > >  #endif
> >
> > Makes sense to me, but shouldn't we send the stop-reply packet only for
> > Ctrl+C/0x03?
>
> Good question.
>
> I think if we get a character here that's not a 3, we're already in
> trouble, and we eat it so even worse. Since we only send a stop packet
> back when the vm stops, then if we don't send one now we might never
> send it. At least if we send one then the client might have some chance
> to get back to a sane state. And this does at least take us back to
> behaviour before the stop filtering patch.
>
> Could go further and only stop the machine if it was a 3, or send a
> stop packet even if we were stopped, etc. but all that get further from
> a minimal fix.

I was taking a look at -rc1 and it looks like this hasn't made it in.
Is it something we want to propose including?

As a user of qemu I'd vote for it to go in.

Cheers,

Joel

