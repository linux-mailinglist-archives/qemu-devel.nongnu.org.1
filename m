Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCA974FCF8
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 04:12:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJPKA-0002QY-MX; Tue, 11 Jul 2023 22:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qJPK6-0002Mq-9S; Tue, 11 Jul 2023 22:11:22 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qJPK4-0008KP-EH; Tue, 11 Jul 2023 22:11:21 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-666e64e97e2so3543727b3a.1; 
 Tue, 11 Jul 2023 19:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689127877; x=1691719877;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8m7jMzWLr9TX6pqO0+i3NUh3itcOwN8g4qZsJs3XlQM=;
 b=bJTVS36zN1LNs4csrmLMwlX0pqSV+0SCL+jR2R6KpDgqXKh7JGUNv8PgU05D8zh4f4
 1qUBvA3KAZlaeQXC+Wq+RBAImFd9S1DZpbumRLhB1ip4GjZPoXnARuXmwmK9+ZoGQABh
 9PEhIFPumj/nW97aNT7QSWqSsju1/NbAh7K9tWL8/MLRPbB/KU7HxDyn1WAJYswJ2NCo
 TOtDcSqCvlrnKk6Oc5uxk2QRfzA76ywKM2dmCGtu50H4ObiLpFDog9cPJLsrYj4zzQ7i
 xZDWFF+U6bpOjcBunJaok8CC3m071IRsRz0TUxlMUiWjZlVJBtW6Z55qr21mWWuqlQS+
 qGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689127877; x=1691719877;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8m7jMzWLr9TX6pqO0+i3NUh3itcOwN8g4qZsJs3XlQM=;
 b=K4drpDodPbEoIv4YSufHn1ERomg3NZZwb/pAHpvBBqUn7Nzxu9dpNVrMVXVbQu7iiD
 azBNV2msEK+xhuIpPhHCdIK3yIq06JRrmWNurCgYa5xoP9k9Qb29d8ridodlGrtgTLM9
 1XLadlGbB2CqF+oBJHnXlA+QIDSmxF3RXoC+XC0RNpMayxkTF46O2iosKzGD+6UR49Fe
 ckHOmgBeFYrt8xHlhsRmiEO8hbRTqSVZKH1fv5b5my3Z4+7Y01d+bUaNqh60uXfOKpxY
 hjT1OYXGfdzK0cs3KV/MXzB413m4O5mQ/UMvEHGcaf4ePaB+xe2YqI0RZCNolNeUiKc2
 xiMQ==
X-Gm-Message-State: ABy/qLZmfUEOuoOFqu9E65ZbGi9rcDpEXpbFFjl3L1Qqj883i0BQ76a+
 MBEHQWAB7pV5MoSXyn3zGA8=
X-Google-Smtp-Source: APBJJlFp/gKn9VIpqwpg2OrZlfm6PQ4zrdSk8T4rEFug+dWPs440hJZJeNynNUUQaUGUvjw07AM4xQ==
X-Received: by 2002:a05:6a00:2d0c:b0:65b:351a:e70a with SMTP id
 fa12-20020a056a002d0c00b0065b351ae70amr15709303pfb.29.1689127877062; 
 Tue, 11 Jul 2023 19:11:17 -0700 (PDT)
Received: from localhost (193-116-64-199.tpgi.com.au. [193.116.64.199])
 by smtp.gmail.com with ESMTPSA id
 n2-20020aa79042000000b0067eb174cb9asm2361043pfo.136.2023.07.11.19.11.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 19:11:16 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Jul 2023 12:11:11 +1000
Message-Id: <CTZTUVQXKUGA.11SSOS1KIFLZK@wheely>
Subject: Re: [PATCH] gdbstub: Fix client Ctrl-C handling
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Matheus Tavares Bernardino" <quic_mathbern@quicinc.com>
Cc: <alex.bennee@linaro.org>, <fbarrat@linux.ibm.com>,
 <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230711085903.304496-1-npiggin@gmail.com>
 <a18e346fc0e38f1014f5484e0b1ef27a7bc8cb41.1689073223.git.quic_mathbern@quicinc.com>
In-Reply-To: <a18e346fc0e38f1014f5484e0b1ef27a7bc8cb41.1689073223.git.quic_mathbern@quicinc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Jul 11, 2023 at 9:03 PM AEST, Matheus Tavares Bernardino wrote:
> > Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> > index 6911b73c07..ce8b42eb15 100644
> > --- a/gdbstub/gdbstub.c
> > +++ b/gdbstub/gdbstub.c
> > @@ -2051,8 +2051,17 @@ void gdb_read_byte(uint8_t ch)
> >              return;
> >      }
> >      if (runstate_is_running()) {
> > -        /* when the CPU is running, we cannot do anything except stop
> > -           it when receiving a char */
> > +        /*
> > +         * When the CPU is running, we cannot do anything except stop
> > +         * it when receiving a char. This is expected on a Ctrl-C in t=
he
> > +         * gdb client. Because we are in all-stop mode, gdb sends a
> > +         * 0x03 byte which is not a usual packet, so we handle it spec=
ially
> > +         * here, but it does expect a stop reply.
> > +         */
> > +        if (ch !=3D 0x03) {
> > +            warn_report("gdbstub: client sent packet while target runn=
ing\n");
> > +        }
> > +        gdbserver_state.allow_stop_reply =3D true;
> >          vm_stop(RUN_STATE_PAUSED);
> >      } else
> >  #endif
>
> Makes sense to me, but shouldn't we send the stop-reply packet only for
> Ctrl+C/0x03?

Good question.

I think if we get a character here that's not a 3, we're already in
trouble, and we eat it so even worse. Since we only send a stop packet
back when the vm stops, then if we don't send one now we might never
send it. At least if we send one then the client might have some chance
to get back to a sane state. And this does at least take us back to
behaviour before the stop filtering patch.

Could go further and only stop the machine if it was a 3, or send a
stop packet even if we were stopped, etc. but all that get further from
a minimal fix.

Thanks,
Nick

