Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4FA7409CC
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:46:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPsR-0006Xr-3w; Wed, 28 Jun 2023 03:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qEPsE-0006Wj-3l
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:45:59 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qEPsC-0004QL-BW
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:45:57 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-56597d949b1so647228eaf.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 00:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687938355; x=1690530355;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDfXm0HRGmVo52R4I8/8hrEitkifaDUExfWbR+l4n2k=;
 b=rYW19t2ScFwZ94dWElCM0TntGh9jyRkOf9KeDVdbtNP8MKFpVLewe7VhNa6y+FXJCo
 WwLTq1tNC/8eLHHpyBQJwxHBRUHBGUK0DggU9pAlZ3OeYST4KxVE7/LkKW4bVPOeSTrq
 pLt2FrkWCW5m9q0Bw3rCNWxw295+/ss+HutttrfDGTmnznhvsvAAn50f0K13aYorOdbn
 wU3ysF1YHLPeyhrkhYJb8AcoRukhB7GQkxBwSnPz8VY/p3qVvRpV683gOKrZxipHt5L6
 lc8E31dwXzwLE1a81WZPmX+hHZgVur3NRkhBkXF4T6qHEqp6MSiRI9pWNOp4vgX/6gwh
 Gsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687938355; x=1690530355;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LDfXm0HRGmVo52R4I8/8hrEitkifaDUExfWbR+l4n2k=;
 b=BQWTFS+EQzvGbSKpnqu+tdNETFHJtTEZwAElJ4Wi3N0JfzyN4BEbd6VF4MmdcAH49B
 YQ0RNe2vlFngb96EXk9FaS1xPToh3XSAgJMjxSImkDxvmZ5/AFccUYMBQIlJKx4q8vSl
 3Yvvqfw8D9J4N19kb2AJF57aamHwjY93wNiYPUUXSRPvawhOwrKBgTzix5feujQ2b1ac
 wj3hzrOjzv8f5gCd69PaIfcr3knLirgfrgYBhW+AN7Z6ft1zD6Q7M9OEfNFeIISjiD1Q
 f95uKkOW9S18pk7nAiH/AhZCkLnCdEUzKT33noVkzAyzG1JTWzBT92b4E4d+TMJnSkJS
 9ZNQ==
X-Gm-Message-State: AC+VfDxHk9HHJPA9VwZg9JBkzUSoeUS8Vur5VGV58zBOLIimly6Txao+
 lRtPhOtIUOox4VhztaC69OoU0Tk6IZAGXur8Rz4=
X-Google-Smtp-Source: ACHHUZ4+eaUvukeTASI2I6LcslMWzK7o72lmH1qU0og1LGyelZWlIm3ColO2e3lMm0OqGEQkjq1/Q2/iqIxzi/W6q3U=
X-Received: by 2002:a4a:d032:0:b0:563:624a:8c6c with SMTP id
 w18-20020a4ad032000000b00563624a8c6cmr4675212oor.6.1687938354984; Wed, 28 Jun
 2023 00:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230622215824.2173343-1-i.maximets@ovn.org>
 <CACGkMEsXOb8wiYo9ktgqh8MqD971=ARJ_etL7MBF-uyo6qt1eA@mail.gmail.com>
 <CACGkMEuyq+5_cqx4T03fcaLOGUCrKLZn51sZxNSXyZq8CqLXTg@mail.gmail.com>
 <93a056c4-b6d3-5491-0c1f-7f58e9f9d1ad@ovn.org>
 <CACGkMEuaUTGeCYfH-MbtX_79scN-CkBmFMcY0fwKo4vO_9cn4w@mail.gmail.com>
 <26c03cd4-5582-489c-9f4c-aeaf8e157b42@ovn.org>
 <CACGkMEsE6_91mOhCP5ezT96zz-Tb-bLXQr9ktrLg6zG0TZC3Lg@mail.gmail.com>
In-Reply-To: <CACGkMEsE6_91mOhCP5ezT96zz-Tb-bLXQr9ktrLg6zG0TZC3Lg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 28 Jun 2023 09:45:42 +0200
Message-ID: <CAJSP0QXPiNK2rH6_8bB7sjMpdQjT--oX0u4FkdaTj7Ew3qs8CA@mail.gmail.com>
Subject: Re: [PATCH] net: add initial support for AF_XDP network backend
To: Jason Wang <jasowang@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2f.google.com
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

On Wed, 28 Jun 2023 at 05:28, Jason Wang <jasowang@redhat.com> wrote:
>
> On Wed, Jun 28, 2023 at 6:45=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org=
> wrote:
> >
> > On 6/27/23 04:54, Jason Wang wrote:
> > > On Mon, Jun 26, 2023 at 9:17=E2=80=AFPM Ilya Maximets <i.maximets@ovn=
.org> wrote:
> > >>
> > >> On 6/26/23 08:32, Jason Wang wrote:
> > >>> On Sun, Jun 25, 2023 at 3:06=E2=80=AFPM Jason Wang <jasowang@redhat=
.com> wrote:
> > >>>>
> > >>>> On Fri, Jun 23, 2023 at 5:58=E2=80=AFAM Ilya Maximets <i.maximets@=
ovn.org> wrote:
> > >> It is noticeably more performant than a tap with vhost=3Don in terms=
 of PPS.
> > >> So, that might be one case.  Taking into account that just rcu lock =
and
> > >> unlock in virtio-net code takes more time than a packet copy, some b=
atching
> > >> on QEMU side should improve performance significantly.  And it shoul=
dn't be
> > >> too hard to implement.
> > >>
> > >> Performance over virtual interfaces may potentially be improved by c=
reating
> > >> a kernel thread for async Tx.  Similarly to what io_uring allows.  C=
urrently
> > >> Tx on non-zero-copy interfaces is synchronous, and that doesn't allo=
w to
> > >> scale well.
> > >
> > > Interestingly, actually, there are a lot of "duplication" between
> > > io_uring and AF_XDP:
> > >
> > > 1) both have similar memory model (user register)
> > > 2) both use ring for communication
> > >
> > > I wonder if we can let io_uring talks directly to AF_XDP.
> >
> > Well, if we submit poll() in QEMU main loop via io_uring, then we can
> > avoid cost of the synchronous Tx for non-zero-copy modes, i.e. for
> > virtual interfaces.  io_uring thread in the kernel will be able to
> > perform transmission for us.
>
> It would be nice if we can use iothread/vhost other than the main loop
> even if io_uring can use kthreads. We can avoid the memory translation
> cost.

The QEMU event loop (AioContext) has io_uring code
(utils/fdmon-io_uring.c) but it's disabled at the moment. I'm working
on patches to re-enable it and will probably send them in July. The
patches also add an API to submit arbitrary io_uring operations so
that you can do stuff besides file descriptor monitoring. Both the
main loop and IOThreads will be able to use io_uring on Linux hosts.

Stefan

