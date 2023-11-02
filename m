Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E617DF0CE
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:02:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyVSb-0000UJ-Jh; Thu, 02 Nov 2023 07:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyVSZ-0000Tx-RQ
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:01:59 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyVSY-0001Cf-3v
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:01:59 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53f9af41444so1354535a12.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 04:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698922916; x=1699527716; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9Iivy64IlSKOKPpAqNmkp8kNpt7e2OKuAihDgJkt5DQ=;
 b=pHNMJrrKsmVnmhEM9kSNdME17GlNpc0XYgLGX09lXyQPQbyIyLxxVn0P5ZDjodPsQz
 XpenbC7DK48uwb68hdZoMk5UnDb1Vo2j1CnP0AjTaIV3t5NXFFCx5mNNcGYXeVHrcXkF
 g6v1pjpC7Poh8G2htIfR8MAYrZfC4fpu8XwVcIlHvZ9C8Zf3aeVQEeUoPbOH7RPOysZb
 ET1+zuVRSU3yy1fJEGc6V49txPu43ZMbUTl42Cp1/BdVkn6mYgO6qVdRFve0WSCUBX0W
 hWK3a3vZv0FLbeMSpKzRdIQQll3CMbpxg7tbbllShoXxt9qgviKqLWsnvJ0pj9FzvFh9
 rlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698922916; x=1699527716;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Iivy64IlSKOKPpAqNmkp8kNpt7e2OKuAihDgJkt5DQ=;
 b=QE5Epr11QKF02YYgSMokmfX/lUgDXM4lgLK2obV8VEizLYAQAIS6iz4CQXAqIN7S+b
 2G2gtGNpW33raUFVdyv7FIJGZ7jPUrjTxeomVFdvu7WKWBbqYSMYL8y7UNP/God1w14E
 1bn/xy+UTMkZjPPVbYw5Yp0FmOeXHdSMql/WEHPWVJcFQ7h0QLniiFBL+scAk1ezxhea
 5+9llgZlk1pCV+3mm4B4xat/UVjfUnLNuOCvSaLD95YDqGqG6MInHs4aizbiQtxjziDZ
 KNb3jIsfdOeoGS3GQqCvvS75uuB4jyF5SeZQ1SaLyecJ1IzsfClAFLMbEE1AGd8Ik4wb
 se0A==
X-Gm-Message-State: AOJu0Yx5T68X45r/RebfxOy5VpxS0sfOjd8tK8D9dM3Sb8dkXOIWDgNE
 xguxCa9sopJx9kuRRm1voNvh5hdPv/HrvHFfqMogCA==
X-Google-Smtp-Source: AGHT+IG3ktXyYlgpRkvH/mDHAi+zLEu39XdcGo+QcIET5PSowDVVDpZmkeOfnOP85anEVbV7odrvR1ii2Hxd/rKjWQo=
X-Received: by 2002:aa7:cc8c:0:b0:53f:738c:3eeb with SMTP id
 p12-20020aa7cc8c000000b0053f738c3eebmr13941134edt.28.1698922916198; Thu, 02
 Nov 2023 04:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <d9d1ec6c-d812-4994-968d-bd40228dac51@tls.msk.ru>
 <e3bb64a2-fb72-4e8d-a0b2-89ee35365fb3@tls.msk.ru>
 <ZUFK/BHG2WMhAiWG@redhat.com>
 <CAFEAcA_6nPW2f0+zvtYAg6d7ZJJMLxqFzNOyDY0wLgVFNcoahw@mail.gmail.com>
 <ZUN9SZ6VkvLHWNXs@redhat.com>
In-Reply-To: <ZUN9SZ6VkvLHWNXs@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2023 11:01:42 +0000
Message-ID: <CAFEAcA8hssUvz8kb4VYXNZSyrQhRyo+=AebA-hskm64bmhG-MA@mail.gmail.com>
Subject: Re: -drive if=none: can't we make this the default?
To: Kevin Wolf <kwolf@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>, 
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 "Daniel P. Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 2 Nov 2023 at 10:43, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 01.11.2023 um 12:21 hat Peter Maydell geschrieben:
> > On Tue, 31 Oct 2023 at 18:45, Kevin Wolf <kwolf@redhat.com> wrote:
> > > Am 16.10.2023 um 13:58 hat Michael Tokarev geschrieben:
> > > > Almost everyone mentions -blockdev as a replacement for -drive.
> > >
> > > More specifically for -drive if=none. I honestly don't know many common
> > > use cases for that one.
> >
> > One use case for it is "create a drive with a qcow2 backend to use
> > for -snapshot snapshots, but don't plug it into anything". See
> > https://translatedcode.wordpress.com/2015/07/06/tricks-for-debugging-qemu-savevm-snapshots/
> > I dunno whether that counts as "common", though :-)
>
> Ok, I was already wondering what good -snapshot was for an image that
> isn't even used, but what the article describes is actually not using
> -snapshot, but internal snapshots with savevm/loadvm, i.e. using the
> image to store the VM state.
>
> This actually makes a lot of sense for if=none, as one of the few cases
> where "none" accurately tells what device it will be used with.

Whoops, have I got the terminology wrong again? To me these are
"snapshots" (they do store the whole VM state including the current
state of the disk, and "qemu-img info" lists them as "snapshots"),
whereas I never use the '-snapshot' option, so I never remember
that we have two different things here. Sorry for introducing
confusion :-(

thanks
-- PMM

