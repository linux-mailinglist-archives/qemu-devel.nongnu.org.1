Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EACC712522
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 12:57:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2V7K-0004BJ-QV; Fri, 26 May 2023 06:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q2V7I-0004B0-Ln
 for qemu-devel@nongnu.org; Fri, 26 May 2023 06:56:16 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q2V7H-0004cp-1S
 for qemu-devel@nongnu.org; Fri, 26 May 2023 06:56:16 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-561afe72a73so10799057b3.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 03:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685098574; x=1687690574;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBwoHGOTPdRBF9QuH3BagRUHLkxHjBwFzHq/xd5Hu0Q=;
 b=VfwdHfhx2223SoXj1S47Z9qxi0TQw45shm3wAVoJtZucHU/sOTZOz3hXV27vvDpNZ8
 yO02KvPoJT7X7NzowWOvAVxr0rYxG3APhCvHvQnfoC2Q9qZpbRv5GYYvOsfQ8LSFk2l/
 Bn7VvS8pzugLk3Y+yNX+AfNaINXc4bZPUygX9Ibtb9Z22CCqvsHp8YWuhLcc0tVWzydI
 jnib/t6Rr0c2AP/XKBh+9OJCLtPWH2UwoYyDE//MlSkTRbsMqkZpTw+DhUoTSQP/fTuX
 TjVkbnUbnz5zIP8M0URfOdl6ipWbI0clkrCIvvaJ0ddcG5qH27KVtgHpPqiLP1dE4A2z
 80PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685098574; x=1687690574;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wBwoHGOTPdRBF9QuH3BagRUHLkxHjBwFzHq/xd5Hu0Q=;
 b=PLigdH+Q8VhMT9oAOHSoBktwmh+YJ1apxPhvn+3Fp79Hf8zrnb4lQwEEb/p2dHPL6R
 WwaZCr429jQUwD6zToeAtZ8l2yQZhCUJ3em2WPA/N5wttbyNn/EMHhgyFMGpyW6IDMaU
 iFOKiFfPsBIbnyw05SYCt0aHs8brvrDENZvS+n7IoGctvq0M4s8APWgZS4MZ4vSqRcOg
 +aDpOHQ/CPBzTE7UhPzPoJkZGMiUsqOP3Ulk5tsDQQtzCMbNMfDxHEh5YckuBfthenbG
 Sc0Bu6PR5CLYyffTLuHerhn77BxPaNE5Idj2//AGRAykI4lPYCDEQcYydJtFSGX4H++A
 oIlw==
X-Gm-Message-State: AC+VfDyqWqoBjIldvDAWb1o0+aewhdxyFqpcYHfEF4jHLwzOewIC4vHQ
 Y694z/ztQZ4wOfgN1NI34QpgYFuB3JUJzLnJn2w=
X-Google-Smtp-Source: ACHHUZ5qQI5ti8W6erf42uGk0nL/Cp03oOIN+tZCYoPGTBTNMlKLK1tDf0G3y8l5+y+dLmyIHu1MlAsAGHNVq+2NzpQ=
X-Received: by 2002:a81:5209:0:b0:561:e540:b1b3 with SMTP id
 g9-20020a815209000000b00561e540b1b3mr1534380ywb.38.1685098573724; Fri, 26 May
 2023 03:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <ed0f3a6a-75f3-c6d5-8eb9-3f1575fc0766@redhat.com>
 <CAJSP0QWRLsFyzfP_Hn-frAgh6Xrz_5_JJCoxBQPnY6M60vfLag@mail.gmail.com>
 <34c16474-2022-455a-a506-58a8d2b6c3a6@redhat.com>
In-Reply-To: <34c16474-2022-455a-a506-58a8d2b6c3a6@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 26 May 2023 06:56:01 -0400
Message-ID: <CAJSP0QUw3YAQoWNutnjoPWoVg4Cp-Cug7RR1MnVWFnes-fC-nQ@mail.gmail.com>
Subject: Re: Performance improvement with
 6d740fb01b9f0f5ea7a82f4d5e458d91940a19ee
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=stefanha@gmail.com; helo=mail-yw1-x1133.google.com
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

On Fri, 26 May 2023 at 04:07, Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com> w=
rote:
>
> Dne 25. 05. 23 v 17:21 Stefan Hajnoczi napsal(a):
> > On Thu, 25 May 2023 at 06:18, Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.co=
m> wrote:
> >> the perf-ci detected and bisected the 6d740fb - aio-posix: do not nest=
 poll handlers - as a performance improvement when using multiple concurren=
t jobs and 4k (22%) as well as 1024k (63%) blocks on aarch64 (on a slow rot=
ational disk).
> >>
> >>     https://ldoktor.github.io/tmp/RedHat-virtlab-arm09/v8.0.0/150-impr=
ovement.html
> >>
> >> Based on the commit message I guess it's expected so take this just as=
 a record of an improvement.
> >
> > The commit was not intended to change performance and I'm not sure why
> > it happens!
> >
>
> It had and today the x86_64 pipeline finished which shows similar improve=
ment just not in read but rather in write instead and only for 4k blocks (~=
40%). For 1024k blocks I can see it scoring a bit better (~1.5%). Reads are=
 too jittery to really tell anything on that machine. Anyway I have not don=
e any thorough testing, just a bisection with the most significant setting.
>
> From around the same time I can see a NVMe regression in 4k writes, but f=
irst bisection job showed nothing. I'll increase the range and try again as=
 each job since that day shows similar drop.

Thanks!

Stefan

