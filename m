Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D917684B5
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 11:55:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQ2xb-00068P-RZ; Sun, 30 Jul 2023 05:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qQ2xa-00067R-NS; Sun, 30 Jul 2023 05:43:34 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qQ2xZ-00046k-5L; Sun, 30 Jul 2023 05:43:34 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bb119be881so30025975ad.3; 
 Sun, 30 Jul 2023 02:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690710211; x=1691315011;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F6yhqemb4q6E/64EA9QWdYvoxGQneY0CN5VUwd4twJg=;
 b=P7ZqEK7YPO8TrY9pCo9gRGtQJ/tBsRccSTekhRQkGO+FUvTHzh+rheemDRfrCG/bbx
 uFsZdoO7WZNdwSTRc9WaIXw25RUknwtvngb6sjfDZqXCcFouSyZeh9IU0FfKGCwjcJfw
 pzUF79u5s2SogaRV6Aq6FuwpKqgBF72is5bMT8GRNSY2pbOeVN764yreJ9y0sZhGl1GO
 +99Nn4Ke/g3maWz/aCxFonKfxpZZhxcYPde5o5HDZIaMBdWL7jQcWJMxDrH0stucA5vV
 oTzXilJM6QWT8UONeDu7B/QL8r8lJKKNZ8sJe4jk0Wt51ytZmDWLw6Rcl42xj3a5BEaY
 6+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690710211; x=1691315011;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F6yhqemb4q6E/64EA9QWdYvoxGQneY0CN5VUwd4twJg=;
 b=liFnLI84DQO2sY7rmQV0wdtBLHKxrh/RbN1EdNdESIH5PFEESx8hu/wDIfgOUwphvY
 yiNndpecXiAyiKNqWOXZbburj42UYVuOlPhprA2b3NJDChGdyacqfturjyX3vKgu8SxX
 iQjdTuUl/7NNfMcFaOz+WJ0o//DdwR2LoTomSCiLUO6UpRPVpjKphGI5mA3Arf5ZYkrm
 t1NimjW5p5wI5sgJXiX+VkHgfM6S2nOnjoaKNjSWNQ6By7IN6PLLttOsSbVAW6ktENrG
 nBaxQ3GFXLCh4kOR/Mc8ONfKuNumQ2CYCI4O/MDP+fAahOcz7C797YYUG895nd/uosA8
 JD0w==
X-Gm-Message-State: ABy/qLbidjSP05xL3O79oTzGh7Zwha8VpNMFsSHCghp1cugvUnRn1g2W
 uQqxyrV+D8J8Mk/BWmTTmHf+OsK15Mw=
X-Google-Smtp-Source: APBJJlEBjVaJrjZEcWP8IMYty6Au/sW6scb4AIeqNXV9rrXU9cVWNm8sDF73+2F0yWYy86fkxnP1Mw==
X-Received: by 2002:a17:902:e892:b0:1bb:ab44:1957 with SMTP id
 w18-20020a170902e89200b001bbab441957mr8196984plg.28.1690710211122; 
 Sun, 30 Jul 2023 02:43:31 -0700 (PDT)
Received: from localhost (110-174-143-94.tpgi.com.au. [110.174.143.94])
 by smtp.gmail.com with ESMTPSA id
 6-20020a170902c10600b001b8a00d4f7asm6402509pli.9.2023.07.30.02.43.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jul 2023 02:43:30 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 30 Jul 2023 19:43:26 +1000
Message-Id: <CUFEQY5EGPAK.BFTBD2ZPJV5A@wheely>
Cc: "Matheus Tavares Bernardino" <quic_mathbern@quicinc.com>,
 <alex.bennee@linaro.org>, <fbarrat@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-stable@nongnu.org>
Subject: Re: [PATCH] gdbstub: Fix client Ctrl-C handling
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Joel Stanley" <joel@jms.id.au>
X-Mailer: aerc 0.15.2
References: <20230711085903.304496-1-npiggin@gmail.com>
 <a18e346fc0e38f1014f5484e0b1ef27a7bc8cb41.1689073223.git.quic_mathbern@quicinc.com>
 <CTZTUVQXKUGA.11SSOS1KIFLZK@wheely>
 <CACPK8Xf-fa4qKZpgg4FvMkgzwbqgP1rh4=qLmv12N1JFcBn3Cg@mail.gmail.com>
In-Reply-To: <CACPK8Xf-fa4qKZpgg4FvMkgzwbqgP1rh4=qLmv12N1JFcBn3Cg@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

On Wed Jul 26, 2023 at 4:35 PM AEST, Joel Stanley wrote:
> On Wed, 12 Jul 2023 at 02:12, Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > On Tue Jul 11, 2023 at 9:03 PM AEST, Matheus Tavares Bernardino wrote:
> > > > Nicholas Piggin <npiggin@gmail.com> wrote:
> > > >
> > > > diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> > > > index 6911b73c07..ce8b42eb15 100644
> > > > --- a/gdbstub/gdbstub.c
> > > > +++ b/gdbstub/gdbstub.c
> > > > @@ -2051,8 +2051,17 @@ void gdb_read_byte(uint8_t ch)
> > > >              return;
> > > >      }
> > > >      if (runstate_is_running()) {
> > > > -        /* when the CPU is running, we cannot do anything except s=
top
> > > > -           it when receiving a char */
> > > > +        /*
> > > > +         * When the CPU is running, we cannot do anything except s=
top
> > > > +         * it when receiving a char. This is expected on a Ctrl-C =
in the
> > > > +         * gdb client. Because we are in all-stop mode, gdb sends =
a
> > > > +         * 0x03 byte which is not a usual packet, so we handle it =
specially
> > > > +         * here, but it does expect a stop reply.
> > > > +         */
> > > > +        if (ch !=3D 0x03) {
> > > > +            warn_report("gdbstub: client sent packet while target =
running\n");
> > > > +        }
> > > > +        gdbserver_state.allow_stop_reply =3D true;
> > > >          vm_stop(RUN_STATE_PAUSED);
> > > >      } else
> > > >  #endif
> > >
> > > Makes sense to me, but shouldn't we send the stop-reply packet only f=
or
> > > Ctrl+C/0x03?
> >
> > Good question.
> >
> > I think if we get a character here that's not a 3, we're already in
> > trouble, and we eat it so even worse. Since we only send a stop packet
> > back when the vm stops, then if we don't send one now we might never
> > send it. At least if we send one then the client might have some chance
> > to get back to a sane state. And this does at least take us back to
> > behaviour before the stop filtering patch.
> >
> > Could go further and only stop the machine if it was a 3, or send a
> > stop packet even if we were stopped, etc. but all that get further from
> > a minimal fix.
>
> I was taking a look at -rc1 and it looks like this hasn't made it in.
> Is it something we want to propose including?
>
> As a user of qemu I'd vote for it to go in.

I think it should, gdb is hardly usable without it.

Thanks,
Nick

