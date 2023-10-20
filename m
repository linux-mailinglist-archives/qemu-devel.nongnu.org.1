Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DA27D13DF
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 18:17:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtsAY-0000Wl-AE; Fri, 20 Oct 2023 12:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtsAW-0000WY-2a
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:16:12 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtsAS-0004Z2-DA
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:16:11 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40675f06f1fso12797975e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 09:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697818563; x=1698423363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:user-agent:from:to:cc:subject:date:message-id:reply-to;
 bh=GDbL6Mo4wpAhcHFPKBdGxdswiLrH14lvwplut/17gXk=;
 b=binS8okxOQXBOfAB7Jn7fU59M0JwBVus7AVrLh78+OoxmHF7CaM+qKbOGa1jvNLqkG
 O6QehvrRlxzaRC6MXzkoz3XlCnw8VRO1BxaHchN9JGUlTmXXP2JmX7W8VQaiz8Ij6aOd
 MdM+LQAMU8mATFuPRRJsfsIr7kxJLt5fLCqLFhCIjoIJ0Ir2tNK7iu8/DQDTPuauelhz
 8QU1yb9EPMdE3BelMLqVVG6yZ7bNQ6V+bdrGQhr8Ow4NaMo7HFGnk85ICJPULPnbps1h
 O15+Cu2p64HcQFxiM1B4Nhi9TdyixQ/WllWfIQqv0/uZBP/TXNiwy7yvy1QuevySC8Cb
 OO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697818563; x=1698423363;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:user-agent:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GDbL6Mo4wpAhcHFPKBdGxdswiLrH14lvwplut/17gXk=;
 b=SRcvLO3OCN26tVKJ92VRc0n/+S6Xnj7cfG3VrFFEJ7lAb6NHMscI1Jv8CGioH4hfaa
 GH2v5OOg3+SHz1NubPVWJMULf3eV30sy6i9wiXE8kcYUBjiOKD5Q1A/rWF+bz2t6iuFe
 TRgHqtFpaLRBe9kQXHqwnHhciZWEBFVO7ulAlaGh94jbT05bvQiKeGnWj8Cvf1BBAThV
 p8RBqQQLj/bxtUFkaS2QMTEGkVV57MJUKHDCQg9VdyTvMGbDr33LOKmftXod0eaQUhYD
 XAA9go+Mj2RE+fN34VuZVH/vl4Mg85T3ywUsCgf15xsW3G3ux5GtLX9+g8y4fDu8Usd5
 6dVw==
X-Gm-Message-State: AOJu0YwJXlaEBxEbRiWTPqLbnAVm4vdenaksq4795TC1J15AMYEo+tqx
 KLDpcSNdalWeeRRvabLBex+KBw==
X-Google-Smtp-Source: AGHT+IFp4rlnCgNH5uDROkpQ307gZEpXoDeE1mx3aF2I0WH1cLNVW10wbgErwcoCJOsmfag7jcEgLQ==
X-Received: by 2002:adf:eec8:0:b0:32d:ddb9:289f with SMTP id
 a8-20020adfeec8000000b0032dddb9289fmr5753858wrp.34.1697818563227; 
 Fri, 20 Oct 2023 09:16:03 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u25-20020a05600c00d900b004068495910csm7226372wmm.23.2023.10.20.09.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 09:16:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 786461FFBB;
 Fri, 20 Oct 2023 17:16:02 +0100 (BST)
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard
 Henderson <richard.henderson@linaro.org>, Adhemerval Zanella Netto
 <adhemerval.zanella@linaro.org>, Matthias Klose <doko@debian.org>, Peter
 Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, debian-alpha@lists.debian.org
Subject: alpha toolchain broken for static builds in bookworm?
Date: Fri, 20 Oct 2023 17:02:59 +0100
Message-ID: <87mswd6zi5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

While updating QEMU's debian-all-test-cross docker image to bookworm I
found "check-tcg" broke for alpha. The docker image is essentially a
slim debian image with minimal qemu build deps and all the cross
compilers Debian packages that support a QEMU guest.

Digging into the failure it was pretty early on in start-up code:

  (gdb) x/5i $pc
  =3D> 0x12003e370 <__ctype_init+48>:       ldq     t0,0(t0)
     0x12003e374 <__ctype_init+52>:       ldq     t4,56(t0)
     0x12003e378 <__ctype_init+56>:       ldq     t2,64(t0)
     0x12003e37c <__ctype_init+60>:       ldq     t0,80(t0)
     0x12003e380 <__ctype_init+64>:       lda     t4,256(t4)
  (gdb) p/x $t0
  $1 =3D 0x0

which looks like TLS is very broken on static builds. Chatting with
Peter and Adhemerval pointed me to:

  https://lists.debian.org/debian-alpha/2023/01/msg00020.html

which has been merged into glibc. However I can't work out if its in the
bookwork packages. I suspect not because I ran a test where I bumped
debian-all-test-cross to trixie (which ships 2.37-3cross1) and alpha
passes check-tcg. However I'm not sure how to navigate the
cross-toolchain-base-ports-62 to work out if the fix is in. The upstream
doesn't have any stable release tags beyond glibc-2.36.

In the release/2.36/master branch the fix is:

  d5aaece8a3 elf: Fix GL(dl_phdr) and GL(dl_phnum) for static builds [BZ #2=
9864]

So to summarise:

  - what does Debian's 2.36-8cross1 map to on the release branch?
  - if it doesn't include the above commit can we get a newer release
    with a fix?

Thanks,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

