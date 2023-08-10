Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5FA777560
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 12:06:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU2Y2-0000va-Ev; Thu, 10 Aug 2023 06:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU2Xz-0000v5-Hh
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 06:05:39 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU2Xx-00012U-PS
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 06:05:39 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-317715ec496so729459f8f.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 03:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691661934; x=1692266734;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gGEAh/P5ez76h40W/roYh84ES8XuTQgdd5ZBqlehzKA=;
 b=Kko5ZaoB+wfjlb6L8k1mwLGgxegC/D7CD7xXRhnpElNHOKkIwYHx/c8azQMPgKYz6R
 ZFtwOeVaLIXo1VC3mxr8L5oRGNUfyapD1I5Wx2hiWw0SBLRPcfIk7DIM6zVaNOGh2VLe
 S8xZUQkigtQFzygSvBvfZvj38g65r64G9MBHCTrWeWgC5zuUazs+v7oeJSsHN65oqS3n
 V/gi0X+5uywD6jscU7Aw4AJE4kltEmhyg1w7QSyNqqnqQ443Emn03DmoSrL+enaegD6/
 de9WRVa5SYJTyyVdE2uhv1OOP/gzxPtDFhIm0G9u8fdHr5C7JyJsGyAjoCqyUhIWuPQ4
 OiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691661934; x=1692266734;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gGEAh/P5ez76h40W/roYh84ES8XuTQgdd5ZBqlehzKA=;
 b=GQxdph6alFwkO/O+lS7I48QPlS5/jV9V8SAS8nO7DUZUKCS1cwgCYDaboWrvQqUXo9
 X2j0tOFalKqRcp/m1SSKy0cxnNrIkt0Fj1XdrDCU91cs1qhZf9tXDQTWyjPMGqk29Y3q
 IcDD9QLihmBevq6KIUcSAYqREf13DEVnAaD4zPQ4kPUDmabnjkmhUQ1oq6sIOGa+ZXrM
 dWeYPn/6W6qhUtRg3aCVG9NNoobEakx3POjHDCAGgL7KOXTeLRs7ofwdS1ZN4akSvAIL
 jmKiseKyp1QzJLsQm2yOfC56YoqxYATNxnEUILWPFno9b69n5WzjZW6zKd/xJnanOxyA
 SFpw==
X-Gm-Message-State: AOJu0Yzg9PxznaCXicrw8n9PzQkUnSIm925/vWnTRAmr/NsDcyUA1Qih
 e7XjQSq4HSxnEopATgHxfBm4rQ==
X-Google-Smtp-Source: AGHT+IFzezoKrJ6CRFDFqgJwxniwIKtgAllfIwpONLLK9GRw1nMlCWcyeNx/aq+7VLkV094GwjFakg==
X-Received: by 2002:a05:6000:110d:b0:317:f714:3be6 with SMTP id
 z13-20020a056000110d00b00317f7143be6mr1365157wrw.61.1691661933717; 
 Thu, 10 Aug 2023 03:05:33 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p1-20020adfcc81000000b003179b3fd837sm1640121wrj.33.2023.08.10.03.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 03:05:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E02CD1FFBB;
 Thu, 10 Aug 2023 11:05:32 +0100 (BST)
References: <CTZTUVQXKUGA.11SSOS1KIFLZK@wheely>
 <456ed3318421dd7946bdfb5ceda7e05332da368c.1690910333.git.quic_mathbern@quicinc.com>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Cc: npiggin@gmail.com, fbarrat@linux.ibm.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, bcain@quicinc.com
Subject: Re: [PATCH] gdbstub: Fix client Ctrl-C handling
Date: Thu, 10 Aug 2023 11:05:07 +0100
In-reply-to: <456ed3318421dd7946bdfb5ceda7e05332da368c.1690910333.git.quic_mathbern@quicinc.com>
Message-ID: <87r0ob2owj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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


Matheus Tavares Bernardino <quic_mathbern@quicinc.com> writes:

> Hi, Nick.
>
>> Nicholas Piggin <npiggin@gmail.com> wrote:
>>
>> On Tue Jul 11, 2023 at 9:03 PM AEST, Matheus Tavares Bernardino wrote:
>> > > Nicholas Piggin <npiggin@gmail.com> wrote:
>> > >
>> > > diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
>> > > index 6911b73c07..ce8b42eb15 100644
>> > > --- a/gdbstub/gdbstub.c
>> > > +++ b/gdbstub/gdbstub.c
>> > > @@ -2051,8 +2051,17 @@ void gdb_read_byte(uint8_t ch)
>> > >              return;
>> > >      }
>> > >      if (runstate_is_running()) {
>> > > -        /* when the CPU is running, we cannot do anything except st=
op
>> > > -           it when receiving a char */
>> > > +        /*
>> > > +         * When the CPU is running, we cannot do anything except st=
op
>> > > +         * it when receiving a char. This is expected on a Ctrl-C i=
n the
>> > > +         * gdb client. Because we are in all-stop mode, gdb sends a
>> > > +         * 0x03 byte which is not a usual packet, so we handle it s=
pecially
>> > > +         * here, but it does expect a stop reply.
>> > > +         */
>> > > +        if (ch !=3D 0x03) {
>> > > +            warn_report("gdbstub: client sent packet while target r=
unning\n");
>> > > +        }
>> > > +        gdbserver_state.allow_stop_reply =3D true;
>> > >          vm_stop(RUN_STATE_PAUSED);
>> > >      } else
>> > >  #endif
>> >
>> > Makes sense to me, but shouldn't we send the stop-reply packet only for
>> > Ctrl+C/0x03?
>>=20
>> Good question.
>>=20
>> I think if we get a character here that's not a 3, we're already in
>> trouble, and we eat it so even worse. Since we only send a stop packet
>> back when the vm stops, then if we don't send one now we might never
>> send it. At least if we send one then the client might have some chance
>> to get back to a sane state.
>
> I just noticed now (as I was integrating the latest upstream patches
> with our downstream qemu-system-hexagon) that this causes the
> gdbstub-untimely-packet tcg test to fail.
>
> My first thought was that, if 0x3 is the only valid case where we will
> read a char when the cpu is running, perhaps not issuing the stop-reply
> isn't that bad as GDB would ignore it anyways. E.g. from a `set debug
> remote 1` output:
>
>   Sending packet: $qSupported:multiprocess+;swbreak+;hwbreak+;qRelocInsn+;
>                    fork-events+;vfork-events+;exec-events+;vContSupported=
+;
> 		   QThreadEvents+;no-resumed+;
> 		   xmlRegisters=3Di386#6a...
>   Packet instead of Ack, ignoring it
>
> So, perhaps, we could do:
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index f123b40ce7..8af066301a 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -2055,8 +2055,9 @@ void gdb_read_byte(uint8_t ch)
>           */
>          if (ch !=3D 0x03) {
>              warn_report("gdbstub: client sent packet while target
> running\n");

This warning seems to be triggering either way, investigating now.

> +        } else {
> +            gdbserver_state.allow_stop_reply =3D true;
>          }
> -        gdbserver_state.allow_stop_reply =3D true;
>          vm_stop(RUN_STATE_PAUSED);
>      } else
>  #endif
> -- >8 --
>
> Alternatively, since GDB ignores the packet anyways, should we just let
> this be and refactor/remove the test?


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

