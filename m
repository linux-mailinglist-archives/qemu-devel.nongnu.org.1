Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 979D4718845
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 19:15:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4PPK-0005hc-C3; Wed, 31 May 2023 13:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q4PPI-0005hG-EO
 for qemu-devel@nongnu.org; Wed, 31 May 2023 13:14:44 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q4PPG-0005y1-Ox
 for qemu-devel@nongnu.org; Wed, 31 May 2023 13:14:44 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-b9a6eec8611so1847052276.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 10:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685553281; x=1688145281;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+2V/BUjvFbxsY3KM12YozPSGI7tDXiX1mBGhr4Yha7s=;
 b=X+qCB2hjV7JqXIJq6GKXW7/Q+yx05zMO2jQ1KW8QPTpkhlZNa5XWds84vD1IDZsbh6
 yaov0ogpq/9e3yoRXEFeclRkan1OUbf/ucPFXVSMsS3bZ0oQvqMS24pxFIdev1cCd/h1
 IcbVihZ2oaczpsoKIu32gL8kCBflqJTo7LjE4PUJ3kCQNNL9Zgki333DbvhsDYowr745
 vodxIsYiDhLbDXrcqkWsOOk6oWyUMvMsQwnV8LdS+1AccLtYhRtv6CvMNpxfvVWt4u8L
 iJR1P/EfGV9ivx2nAjXAriwoafpngezakXpT7igbzvFrhrSQm//ZNlWuCa67B7Kj+63H
 7PeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685553281; x=1688145281;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+2V/BUjvFbxsY3KM12YozPSGI7tDXiX1mBGhr4Yha7s=;
 b=CnG+s82ZvX1mkWT83OIAMZXOMJTPu2XC6pyzF7plbhDTCHxOe0ouUqlX0Ef1CGR8qu
 vYpo8nYGQcyfrhhzU6+74vGn6Lc3QykLSWXwBhEyXvtkpo3Uq0mu6XzhdMEN4HTzgJGB
 /rZe7oPx6daXzVEzMHxRDJtYurx5O/S10DTuOMUUz4xHm2mjdKvyp/gpGrb3GGucE3TU
 dBpSZYIM4FTuedhipqwWjZNWlix+eZjf77udpdo9nKI2eW0dzTIUnRtINsGV26TWBUh5
 LkLG/FWbgIW316F8saQOeqi/HgFqC3EsHzz6EoBJEQ87ySiD652O4PrTSSzzOkGRI4CD
 HV2Q==
X-Gm-Message-State: AC+VfDxoLLrP/S37W6rxPXBDxtMhIaI5Hret5ejMF62JCzSCpGZ3PPsc
 6ZcUxcvW2SO6Pu/Ue83tfIdbzSr/f05rhcEfyoE=
X-Google-Smtp-Source: ACHHUZ4CItqJoKv9ZRHruPhW9C7noBc+sC5Yhj9WHNRn2HTuJejhpT2nD/VrRI8rmEUjJkSSqVbkUzr4n5/b+woYALE=
X-Received: by 2002:a25:211:0:b0:ba7:4c49:95e with SMTP id
 17-20020a250211000000b00ba74c49095emr7221687ybc.7.1685553281311; 
 Wed, 31 May 2023 10:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <ed0f3a6a-75f3-c6d5-8eb9-3f1575fc0766@redhat.com>
 <CAJSP0QWRLsFyzfP_Hn-frAgh6Xrz_5_JJCoxBQPnY6M60vfLag@mail.gmail.com>
 <34c16474-2022-455a-a506-58a8d2b6c3a6@redhat.com>
 <CAJSP0QUw3YAQoWNutnjoPWoVg4Cp-Cug7RR1MnVWFnes-fC-nQ@mail.gmail.com>
 <3584ed8c-e60c-54bd-1abe-8294e985119a@redhat.com>
In-Reply-To: <3584ed8c-e60c-54bd-1abe-8294e985119a@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 31 May 2023 13:14:29 -0400
Message-ID: <CAJSP0QUc504kE_zM7fb0NQLG49eK2prWJZm9o=S6SosYqntEZA@mail.gmail.com>
Subject: Re: Performance improvement with
 6d740fb01b9f0f5ea7a82f4d5e458d91940a19ee
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=stefanha@gmail.com; helo=mail-yb1-xb2c.google.com
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

On Wed, 31 May 2023 at 12:50, Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com> w=
rote:
>
> Dne 26. 05. 23 v 12:56 Stefan Hajnoczi napsal(a):
> > On Fri, 26 May 2023 at 04:07, Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.co=
m> wrote:
> >>
> >> Dne 25. 05. 23 v 17:21 Stefan Hajnoczi napsal(a):
> >>> On Thu, 25 May 2023 at 06:18, Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.=
com> wrote:
> >>>> the perf-ci detected and bisected the 6d740fb - aio-posix: do not ne=
st poll handlers - as a performance improvement when using multiple concurr=
ent jobs and 4k (22%) as well as 1024k (63%) blocks on aarch64 (on a slow r=
otational disk).
> >>>>
> >>>>     https://ldoktor.github.io/tmp/RedHat-virtlab-arm09/v8.0.0/150-im=
provement.html
> >>>>
> >>>> Based on the commit message I guess it's expected so take this just =
as a record of an improvement.
> >>>
> >>> The commit was not intended to change performance and I'm not sure wh=
y
> >>> it happens!
> >>>
> >>
> >> It had and today the x86_64 pipeline finished which shows similar impr=
ovement just not in read but rather in write instead and only for 4k blocks=
 (~40%). For 1024k blocks I can see it scoring a bit better (~1.5%). Reads =
are too jittery to really tell anything on that machine. Anyway I have not =
done any thorough testing, just a bisection with the most significant setti=
ng.
> >>
> >> From around the same time I can see a NVMe regression in 4k writes, bu=
t first bisection job showed nothing. I'll increase the range and try again=
 as each job since that day shows similar drop.
> >
>
> Hello Stefan, folks,
>
> the regression proved to be there and stably reproducible. With NVMe 4k w=
rites with jobs=3D10 and iodepth=3D4 I can see a 50% regression on my machi=
ne:
>
>     https://ldoktor.github.io/tmp/RedHat-virtlab722/v8.0.0/150-regression=
.html
>
> The rest of the cases doesn't show any change at all. I can provide more =
data if someone is interested.

Which commit caused the regression?

Stefan

