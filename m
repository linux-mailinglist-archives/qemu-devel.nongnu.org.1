Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC6A7E69C7
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 12:36:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r13Jc-00022U-TE; Thu, 09 Nov 2023 06:35:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r13JS-0001xO-Kk
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 06:35:08 -0500
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r13JN-0004G6-JZ
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 06:35:04 -0500
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5849fc56c62so411776eaf.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 03:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699529697; x=1700134497; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Vk9hrEFEq4KQMl5T4eABYE2t8GC9MnnKTAtFYUlA6c=;
 b=nAl3zEe7ftFy5YLNO2nyzuepz/0MQT9zDTAJvIwKOK4Pd33ZeXK0NXJ1lBkZ9RlqHx
 2JXD89x7/5CIaTcJzXFcJjihcof6jMFLeslNNwFu2Nn6UK22OWRY2mXHH2urHwS8rPRY
 b6/kZDROEY5rQHmhEz/s68/3JUX4KWY6XeYb0VtwHPe1HMHb9wG/VENjhbV+TD16IuCN
 67miGd866krkbgej9O4qB6W5m8VBwU6QmL0jYKuYZNXp2w4BPw9rjuCKAaRaDFrFIjX6
 IUsyNnuavVfQMkVW8OzKPj4PyQ7dWmKCAWicy77CpvBEFOkhbJGYk+Z9a6wee638Z7bV
 tsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699529697; x=1700134497;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Vk9hrEFEq4KQMl5T4eABYE2t8GC9MnnKTAtFYUlA6c=;
 b=gvp/+SQ+sDty9dcFXi3BqyWaNpZZzt6hvnhFMze+HvXEtrn1CDWAMRinm3UK0ZM+1l
 kGB5Sim/FJgGnL1gP6nkRGuuY/AZLzgr/LxPYUYd7K/VzwtIbFneDtONbq5RFDSkO63h
 khaih8QqT879ryJm5lgnf52PXyKQdNT1xd/lRF3esMnBfmS9/3nF42O63DVThmcP31DM
 vkEigklGLTfldsdkZCTPw8Xom8gAcfyZheYuOnPGnBUSCcBrRkmrDRJwmIyUkFMVxRbe
 HjydCZserJPbWND6BRqu3yOAXR4wxaf/4/0zu+nDgF2/GJ8BEkCpHhbfPpnSRs3Fl4cW
 u9UQ==
X-Gm-Message-State: AOJu0YzwLmcIh6C93I8PPEbhDoumlB9a1sXPkMP99DsDKeHe2S33r3ZA
 ba6Ln5U3t5+efIh/xTBj7YKvczjLs6vZTqRDpcY=
X-Google-Smtp-Source: AGHT+IHADTF1YoxCSQsBUlSEJgZEKwI9kBhCSELZhcJXB2XKGOzStbHZ8TpHabtyqaVa+2RO8DqSngyQ7b6clN/HNjM=
X-Received: by 2002:a4a:350e:0:b0:589:f58f:8641 with SMTP id
 l14-20020a4a350e000000b00589f58f8641mr926464ooa.2.1699529697481; Thu, 09 Nov
 2023 03:34:57 -0800 (PST)
MIME-Version: 1.0
References: <20231107101524.2993389-1-marcandre.lureau@redhat.com>
 <20231107101524.2993389-10-marcandre.lureau@redhat.com>
 <4f89df97e82375b22afca0f59102954434dc08cc.camel@infradead.org>
In-Reply-To: <4f89df97e82375b22afca0f59102954434dc08cc.camel@infradead.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 9 Nov 2023 19:34:45 +0800
Message-ID: <CAJSP0QVbaj0qTor_SEFD9qU8x1c3+-rnyDCQro1Eq3fOpQa5Mg@mail.gmail.com>
Subject: Re: [PULL v3 09/25] ui/console: allow to override the default VC
To: David Woodhouse <dwmw2@infradead.org>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc32.google.com
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

On Thu, 9 Nov 2023 at 19:10, David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Tue, 2023-11-07 at 14:15 +0400, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > If a display is backed by a specialized VC, allow to override the
> > default "vc:80Cx24C".
> >
> > As suggested by Paolo, if the display doesn't implement a VC (get_vc()
> > returns NULL), use a fallback that will use a muxed console on stdio.
> >
> > This changes the behaviour of "qemu -display none", to create a muxed
> > serial/monitor by default (on TTY & not daemonized).
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
>
> Hrm. This breaks the command line documented at
> https://qemu-project.gitlab.io/qemu/system/i386/xen.html
>
>  $ ./qemu-system-x86_64 --accel kvm,xen-version=3D0x40011,kernel-irqchip=
=3Dsplit \
>     -display none -chardev stdio,mux=3Don,id=3Dchar0,signal=3Doff -mon ch=
ar0 \
>     -device xen-console,chardev=3Dchar0  -drive file=3D${GUEST_IMAGE},if=
=3Dxen
>
> qemu-system-x86_64: cannot use stdio by multiple character devices
> qemu-system-x86_64: could not connect serial device to character backend =
'stdio'
>
> Can we make it create a Xen console by default, instead of a serial
> port? And/or make it *not* use stdio if something else on the command
> line already does?

I have filed this in QEMU's bug tracker so it's not forgotten:
https://gitlab.com/qemu-project/qemu/-/issues/1974

Here is the list of open 8.2 bugs:
https://gitlab.com/qemu-project/qemu/-/milestones/10

Stefan

