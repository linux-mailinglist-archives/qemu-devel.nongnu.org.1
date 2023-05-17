Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88212706558
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 12:34:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzETQ-0001iL-LL; Wed, 17 May 2023 06:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidhartha@drut.io>) id 1pzETO-0001he-EH
 for qemu-devel@nongnu.org; Wed, 17 May 2023 06:33:34 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sidhartha@drut.io>) id 1pzETM-0004Zl-IP
 for qemu-devel@nongnu.org; Wed, 17 May 2023 06:33:34 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-24e01ba9e03so539834a91.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 03:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drut-io.20221208.gappssmtp.com; s=20221208; t=1684319610; x=1686911610;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uxeKV1jhRAKtj3vrNVTrlK2aCCjrDA/BZFbawZmJKk4=;
 b=dMtw2gW7lqosFjXLP7APG/4a8erTkfiR4czxUJ11jA9EqSr/b3Kg2SzJbE8GejQxVq
 UICm2arw5DLV1x11D96FRiPZIJo7FyW8vgQsLfu4ntntg8j+BCy9x6mMOE68R9D2DpWi
 8pyNuFT3kbk4Vlx8wFbLoUU+6/A7aoClB0ZEUtuIVUH+54jaq9w5HEZqtiJQtoa0ePBd
 ws8+Zm5K2ivEwmARxJ5XgB3nr/KFnb+HcWg0deGffFhHQ3Yd1h+YIreMgWhGUyosJCyY
 cS3BjQJKXmjjm+sCwkSkYiRQEbROZxFsSCS5HQFjz8foLd527kYtzGM8Cem4PUc3gdcW
 J44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684319610; x=1686911610;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uxeKV1jhRAKtj3vrNVTrlK2aCCjrDA/BZFbawZmJKk4=;
 b=Yipz1dpScIsm0WL4S8JuGe3VxG8hauoT6F+fHuyYvypc9InhU98SNFCm0ptJH2+fLe
 l4ObgoQkQ1xIyVpWxKaQwewYFGeWyty/kDiuXW6FwxzQmCbXvEO1+AHihSccfuOFZxct
 Wb3tm8gYFiRFb8yrZkh2WfvziRS2YLOpQkx2YuoY7yJYqs4HH0yrl7JZKPwPfBJD5asw
 TsRZz2JNQQLDhjzgKt7mjFPTOa+mOlsAVHadSUcj+G0xDo+5QoYfRZ3Z2h8JTezwUJLj
 a5JzVsJLrwNYVfJCmMTxP5WDPlYX4HzuSCcTp8S5+Lzirg1JdC4ufP2lIH/lCSiI2PYO
 GszA==
X-Gm-Message-State: AC+VfDxeFhEGkHHORUEKAktfLReKl1uCchFbEFTNXLbOsx4N4vaE/+UK
 0w5QeDOvF3ZVdiRNPhRfoyozPN7Gchgdo4+n8DZP
X-Google-Smtp-Source: ACHHUZ5uxe7u1SOKUdi2rkn8lPBMK+gb6VKkvnRolUZpGW/zWLHPEbUc8T1VNFrWzQbROUOj82Ax0j53kt8rAybS5Ls=
X-Received: by 2002:a17:90a:66ce:b0:253:3e9d:f92a with SMTP id
 z14-20020a17090a66ce00b002533e9df92amr2504183pjl.29.1684319610540; Wed, 17
 May 2023 03:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <CADfM=uvE+DdOAVU-WZmNgiAPom0isN9OFUeky0pPqPbtFmvyRw@mail.gmail.com>
 <87y1lonxdj.fsf@linaro.org>
In-Reply-To: <87y1lonxdj.fsf@linaro.org>
From: Sidhartha Reddy Kaliki <sidhartha@drut.io>
Date: Wed, 17 May 2023 16:03:22 +0530
Message-ID: <CADfM=utkc2zM9LX==ge5Z0Bbm2p+UitOv1vHu5R-OFm+8xicHg@mail.gmail.com>
Subject: Re: How to communicate 2 guest machines over serial in qemu?
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: openbmc@lists.ozlabs.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=sidhartha@drut.io; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

we tried of working on socket and pipes,

In the original hardware, We have 2 compute modules. A serail
interface is available between them and we run a SLIP protocol in
software for the communication.

We would like to replecate the same in Qemu environment. In our
scenario the machine A and a machine B both runs the same software
image, they both should communicate over a SLIP protocol.
We tried using pipes but we are not sure how to communicate between 2
Virtual machines using them.

We appreciate a solution to communicate between Machine A and B using
pipe or by establishing a SLIP protocol between the machines.
Is there any way to establish a pipe between master and slave machine ?

On Tue, May 16, 2023 at 8:20=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
>
> Sidhartha Reddy Kaliki <sidhartha@drut.io> writes:
>
> > Hi,
> >
> > We have 2 independent devices running openbmc software on each of
> > them. These devices can communicate with each other over a serial line
> > using SLIP protocol. Now we would like to emulate the same using qemu.
> >
> > Do we have any provision to communicate 2 guest machines over a serial
> > interface using SLIP protocol?
>
> You can connect the two chardev backends to each other. One will want to
> be a server, the other a client. You can use pipe, socket or network
> backends to do this.
>
> > We have tried a few options which are not helpful to solve our purpose.
> > It will be really helpful if you can provide us some guidance on this.
>
> What have you tried so far?
>
> >
> > Thanks
>
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

