Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C93087692B4
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 12:07:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQPmq-0006bG-A3; Mon, 31 Jul 2023 06:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQPmn-0006b7-8S
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:05:57 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQPml-0003UF-1K
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:05:56 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-522b77956d2so2421536a12.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 03:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690797953; x=1691402753;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3F9p2pSs6R3JTrObS3/84XQ7b1HEeZ3IqqBymucmX5Y=;
 b=nYxoHOQUP0LR+m2ydkKmnb2BMNWFqBCavG5ohmNqwyr5lvqVXEhyFJRW5rsh3JCNna
 uoEwPApzequL34+6K+8AhOPFCep5l0L2evPhzTX4AgfwC5dl4T6hvNjio4y540UZ2lM8
 GGON0uiCWWpyiPmy6ccyoTgiM85zhcfzA1NDlWyawYjeE2gpwzfAAtpI69A1MV+hUCP0
 M1FudRvZW1+Rnkc0Yg6fD+xzURRVpEZQjk4xV26vV7RRFQKrE0R5FB/IhGoi3mzJVIbn
 C3Hylr3969VYyAMxPkppaJCvI808gUPbsoHMqJ4Npnpnrd3cKkrkGNIw0dFuiRmQ0NJl
 s66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690797953; x=1691402753;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3F9p2pSs6R3JTrObS3/84XQ7b1HEeZ3IqqBymucmX5Y=;
 b=SbL4XTueqUjDu+GGTWpfZKLeiplEVbRW+arlpvu8tY8vkpMEkzbWKV2utcfcXcrOFH
 FB9+BB2gRtaxAAzW4nuyLpJz9EiKrSiO8W0/Ir+Z0dOTU8GnDyJdXxxYpY1pANAlYTb+
 6TyBuFeeNcZbAMEzFr8QPgwJxXoxSvlCxS5Yi/RhARwDY94yztf7j34rZ5hfJp4GgeY8
 +X80rMxonL3+SrM2BpqqLeYvgPRPZYcnFLeYZtxMpDYU6N/NTObdhnU0gQHprWT5IRPq
 Rj73QkpCUtOdpufJHVZ2kWiL0nMhWOAgA3fR7y4+SxLCojNcVES2fyNXw2RRLvg1vr3m
 V2JQ==
X-Gm-Message-State: ABy/qLbFTfEU3vP0k/frd1T9VoQGYS085j3ODHe6xSCr4w4txMXSjoIA
 911/gxn7816LWDLGAl9E1J2z0P3y5Z07WvWzJWx4Fg==
X-Google-Smtp-Source: APBJJlHMo0CakWa0BDNM0J9VPjRsLEKSdy2NaJ1HpZ8NqhfuUvdNKvT7LCIb1tGiye/MnuSU90VW9WSMwRk/4yIEzLc=
X-Received: by 2002:a05:6402:746:b0:522:3410:de23 with SMTP id
 p6-20020a056402074600b005223410de23mr7779998edy.3.1690797953182; Mon, 31 Jul
 2023 03:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230728142748.305341-1-thuth@redhat.com>
 <20230728142748.305341-6-thuth@redhat.com>
 <CAFEAcA9PuwSzaWXJYrF9PTs8Yz9oG6_sUY=p7S5rnx6NiS1HeQ@mail.gmail.com>
 <6ca265d4-0dad-3725-1cd5-84da685bc63a@redhat.com>
In-Reply-To: <6ca265d4-0dad-3725-1cd5-84da685bc63a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Jul 2023 11:05:42 +0100
Message-ID: <CAFEAcA-F=6QqdjCSexG9kKsq9irjDGTv63xJNKQn+TD9-5U1pg@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] include/qemu/compiler: Fix problem with
 gcc_struct and Clang
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 31 Jul 2023 at 10:11, Thomas Huth <thuth@redhat.com> wrote:
> Or do you see another possibility how we could fix that timeout problem in
> the 64-bit MSYS2 job? Still switching to clang, but compiling with
> --extra-cflags="-Wno-unknown-attributes" maybe?

Is there any way we can separate out the "take 25 minutes to
install a pile of packages" part from the "actually compile and
test QEMU" part ?

thanks
-- PMM

