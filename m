Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 489C8768C77
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 09:00:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQMs9-0007Oo-7H; Mon, 31 Jul 2023 02:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qQMs5-0007OZ-Bg; Mon, 31 Jul 2023 02:59:13 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qQMs2-0001IJ-Up; Mon, 31 Jul 2023 02:59:13 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9936b3d0286so662147566b.0; 
 Sun, 30 Jul 2023 23:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1690786748; x=1691391548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xhaS7hK3rZFDGMOlFXsnipU4QaqfUrYIYdaopBrccg0=;
 b=IEivPDKyZNHPlTt+lb5k9bpiJIFBrDoY7ZtHJkTDEfcV2OORFZk/tKzf5jGvmxROfV
 CcHaP+AQtPtRkqtXCLR1w2HcpGqajYONfroJITpjdou+ojSrVv4XMSewnRmlIHyaR6LK
 cKwXwP0pLyL2FO8MzRpqb/+3aLyheC3Z4uJL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690786748; x=1691391548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xhaS7hK3rZFDGMOlFXsnipU4QaqfUrYIYdaopBrccg0=;
 b=Ziyh5xoeC5EhB6cSOf5DbvYBRaPbbOwYBrFTCZadBLjIoxio0b/a0y4g3hmLncHZ0c
 eI+KfyYXvrjUURBpQ5sD/6S8dlKetvBMlKxLiCvi9NfRdDV06Mla2DK4FLN6Q6/yd9Gj
 s8COIz0zcU/m3//+2TLwsxT62z4vvlYOSntthlLSlZjihBpJ4CrcUBoDOGgBaLANeO9s
 tTfnY+qJC4bBxa+sJ7CD7t7DWINRTwfDDM9J/7Lxm1iJvGK42xHGTU92LvVogW5gYXHK
 0HoXAmJFHFmYyE/ZlYpiISOE/gW6zLwKWBHUVlQY6wNdK9bdhzjmq3B9YjDaxlT7Ir3D
 3H2Q==
X-Gm-Message-State: ABy/qLYWEeC/4pDRmvNLmar/NLd3EjsncdX98dWSxsmlvWXTm29AdtiQ
 x950vyJNbpOEGE5wHc+SsVP7uJcT8e4EXVWp9/M=
X-Google-Smtp-Source: APBJJlF88otNRBOoAhGSYBSuYJBSZWGw/8fCLzWracg6Y+ajMnC3kP5quGGvwjhc201ZPjCB7YV8pQtmFTEQBJSjNhQ=
X-Received: by 2002:a17:906:53d4:b0:99b:4668:8666 with SMTP id
 p20-20020a17090653d400b0099b46688666mr6546918ejo.6.1690786748379; Sun, 30 Jul
 2023 23:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230711085903.304496-1-npiggin@gmail.com>
 <a18e346fc0e38f1014f5484e0b1ef27a7bc8cb41.1689073223.git.quic_mathbern@quicinc.com>
 <CTZTUVQXKUGA.11SSOS1KIFLZK@wheely>
 <CACPK8Xf-fa4qKZpgg4FvMkgzwbqgP1rh4=qLmv12N1JFcBn3Cg@mail.gmail.com>
 <CUFEQY5EGPAK.BFTBD2ZPJV5A@wheely>
In-Reply-To: <CUFEQY5EGPAK.BFTBD2ZPJV5A@wheely>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 31 Jul 2023 06:58:55 +0000
Message-ID: <CACPK8XdTVArJCVh0UaSe2mwY2FtO3zpMepkqPfkDy7zAmc16jQ@mail.gmail.com>
Subject: Re: [PATCH] gdbstub: Fix client Ctrl-C handling
To: Nicholas Piggin <npiggin@gmail.com>, alex.bennee@linaro.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 fbarrat@linux.ibm.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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

On Sun, 30 Jul 2023 at 09:43, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> On Wed Jul 26, 2023 at 4:35 PM AEST, Joel Stanley wrote:
> > On Wed, 12 Jul 2023 at 02:12, Nicholas Piggin <npiggin@gmail.com> wrote:
> > >
> > > On Tue Jul 11, 2023 at 9:03 PM AEST, Matheus Tavares Bernardino wrote:
> > > > > Nicholas Piggin <npiggin@gmail.com> wrote:
> > > > >
> > > > > diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> > > > > index 6911b73c07..ce8b42eb15 100644
> > > > > --- a/gdbstub/gdbstub.c
> > > > > +++ b/gdbstub/gdbstub.c
> > > > > @@ -2051,8 +2051,17 @@ void gdb_read_byte(uint8_t ch)
> > > > >              return;
> > > > >      }
> > > > >      if (runstate_is_running()) {
> > > > > -        /* when the CPU is running, we cannot do anything except stop
> > > > > -           it when receiving a char */
> > > > > +        /*
> > > > > +         * When the CPU is running, we cannot do anything except stop
> > > > > +         * it when receiving a char. This is expected on a Ctrl-C in the
> > > > > +         * gdb client. Because we are in all-stop mode, gdb sends a
> > > > > +         * 0x03 byte which is not a usual packet, so we handle it specially
> > > > > +         * here, but it does expect a stop reply.
> > > > > +         */
> > > > > +        if (ch != 0x03) {
> > > > > +            warn_report("gdbstub: client sent packet while target running\n");
> > > > > +        }
> > > > > +        gdbserver_state.allow_stop_reply = true;
> > > > >          vm_stop(RUN_STATE_PAUSED);
> > > > >      } else
> > > > >  #endif
> > > >
> > > > Makes sense to me, but shouldn't we send the stop-reply packet only for
> > > > Ctrl+C/0x03?
> > >
> > > Good question.
> > >
> > > I think if we get a character here that's not a 3, we're already in
> > > trouble, and we eat it so even worse. Since we only send a stop packet
> > > back when the vm stops, then if we don't send one now we might never
> > > send it. At least if we send one then the client might have some chance
> > > to get back to a sane state. And this does at least take us back to
> > > behaviour before the stop filtering patch.
> > >
> > > Could go further and only stop the machine if it was a 3, or send a
> > > stop packet even if we were stopped, etc. but all that get further from
> > > a minimal fix.
> >
> > I was taking a look at -rc1 and it looks like this hasn't made it in.
> > Is it something we want to propose including?
> >
> > As a user of qemu I'd vote for it to go in.
>
> I think it should, gdb is hardly usable without it.

I think I hit this issue when debugging u-boot in the aspeed arm
machines. Your patch fixed things:

Tested-by: Joel Stanley <joel@jms.id.au>

Alex, Philippe, can we get this queued for 8.1?

Cheers,

Joel

