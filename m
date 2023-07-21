Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B311175C8A1
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 15:57:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMqbz-0005ZZ-4y; Fri, 21 Jul 2023 09:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qMqbs-0005VA-Eg; Fri, 21 Jul 2023 09:55:56 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qMqbo-0005bC-9W; Fri, 21 Jul 2023 09:55:56 -0400
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-785ccf19489so89853639f.3; 
 Fri, 21 Jul 2023 06:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689947748; x=1690552548;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZh2RMyknVQ2Cp5YU6ls6IZQgqPcieG0cJv4JEyb9Ys=;
 b=kF42gzPASlaEPQqZSCfJFnVW98uB8NiV+XTQqxUw/vEQMw1Hs4IPc5ZqFjqJixAEFw
 w6tZDiRWv16js30bOFpm/dmUHdrxy6pl/2GSVFofaDAvXOLsg0ZMIQeV5hvdgv3ov9Mc
 XPSCax3uL5IFIJEodeUXZij20EUjDtKLKqokvY8v2MdHgOCDz1c3ADrKvY+6k26w7NAL
 Tm5VwO+vNR2lEwR8ZCE/MYLbU2xtnEzNYV/dVKNmkjb3Ih0TDPa65ZHNxw++9U/ymfJw
 8mC4RVtNtjVqTp+TBh2I9qIowT7JWT4d4P3+iI4XgO9l8bWRveiOYBXksonVLTgMPvEK
 H41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689947748; x=1690552548;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HZh2RMyknVQ2Cp5YU6ls6IZQgqPcieG0cJv4JEyb9Ys=;
 b=bFeCgxmmYlF1KysYC1RvBXJycaXJSf+eWxuJsEw1jkYzvf4kS1R+Atz4llUMKI0PPn
 n5bFH+q+pMTC4xBqx9n4yLAMsc8xC0W7mXFjs1dpruJKBGiaUnZIN70OzP6NulHH0srA
 Y9CKcRVEmkQWZmGCqMOEG/SymRn4uZtcDFtuiMuFlSlYSz+fy0CXdQnCqOCHzYNSMgEz
 avAIxPggAY52eETAFH657ZuJuDe01aHfWUWPyf5yNWQPFldne8y04VDnV6GqCVrurjat
 slCkqh93wshcAt8afJvn5ywfPQC1rkdJnbr7q9sy3AYD3yH5L/lbIdxnQdFYetakvYA3
 m6eA==
X-Gm-Message-State: ABy/qLYyz/ECsytbIWWd/8fmzO4zonAro43rEKTo2rSPSOZRr2zm4Mr7
 4Xh1ekvcmEWCghjAaE2wNNs=
X-Google-Smtp-Source: APBJJlED/EBY3NCpQLJHYrwvQl8G/DSlFvLqS1/vQYIPYYJBJlgVUG1E/bBqpQHoND0WO5ekILrQ2Q==
X-Received: by 2002:a92:c26e:0:b0:348:8576:15b5 with SMTP id
 h14-20020a92c26e000000b00348857615b5mr32929ild.3.1689947748405; 
 Fri, 21 Jul 2023 06:55:48 -0700 (PDT)
Received: from localhost ([203.220.77.10]) by smtp.gmail.com with ESMTPSA id
 e23-20020a633717000000b0056368adf5e2sm3118181pga.87.2023.07.21.06.55.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 06:55:47 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Jul 2023 23:55:38 +1000
Message-Id: <CU7WH5HTBQET.294VC6U7IATH6@wheely>
Cc: <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "David Gibson" <david@gibson.dropbear.id.au>, "Greg Kurz" <groug@kaod.org>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "John Snow"
 <jsnow@redhat.com>, "Cleber Rosa" <crosa@redhat.com>, "Pavel Dovgalyuk"
 <pavel.dovgaluk@ispras.ru>, "Paolo Bonzini" <pbonzini@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, "Beraldo Leal" <bleal@redhat.com>,
 "Peter Maydell" <peter.maydell@linaro.org>, "Richard Henderson"
 <richard.henderson@linaro.org>
Subject: Re: [PATCH 7/7] tests/avocado: ppc64 pseries reverse debugging test
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, "Pavel Dovgalyuk"
 <pavel.dovgalyuk@ispras.ru>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230623125707.323517-1-npiggin@gmail.com>
 <20230623125707.323517-8-npiggin@gmail.com>
 <74691561-c288-abf5-9673-6e230d55b813@ispras.ru>
 <CTMH98YLMT2F.2C2Q4KXXZMEB1@wheely>
In-Reply-To: <CTMH98YLMT2F.2C2Q4KXXZMEB1@wheely>
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2e;
 envelope-from=npiggin@gmail.com; helo=mail-io1-xd2e.google.com
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

On Mon Jun 26, 2023 at 7:34 PM AEST, Nicholas Piggin wrote:
> On Mon Jun 26, 2023 at 5:49 PM AEST, Pavel Dovgalyuk wrote:
> > On 23.06.2023 15:57, Nicholas Piggin wrote:
> > > pseries can run reverse-debugging well enough to pass basic tests.
> > >=20
> > > There is strangeness with reverse-continue possibly relating to a bp
> > > being set on the first instruction or on a snapshot, that causes
> > > the PC to be reported on the first instruction rather than last
> > > breakpoint, so a workaround is added for that for now.
> >
> > It means that the test reveals some kind of a bug in PPC debugging=20
> > server implementation.
> > In this case it is better to fix that instead of adding workaround.
>
> I agree, and I'm trying to find the cause it hasn't been easy. I
> thought the test was still interesting because it otherwise seems
> to work well, but hopefully I can find the issue before long.

I found the problem after too much staring at record-replay. QEMU works
perfectly, it is the ppc pseries firmware that branches to its own entry
point address within the recorded trace, and that confuses the test
script.

I'm not sure the best way to work around it. Initial skip works okay but
also maybe(?) a good edge case to test a break on the very first
instruction of the trace even if we don't reverse continue to it.

I will send a new series and propose to add the breakpoints before
seeking to the end of the trace, so we will catch a breakpoint being
executed again.

Thanks,
Nick

