Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D195D717E35
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 13:38:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4K9M-0005OO-Rf; Wed, 31 May 2023 07:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q4K9G-0005Nq-Oy
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:37:51 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q4K9E-0000h7-6I
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:37:50 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-30ae967ef74so2733704f8f.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 04:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685533066; x=1688125066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:user-agent:from:to:cc:subject:date:message-id:reply-to;
 bh=Fh64C8hkWvIxoEEFtvqDZZB+RBg5ssruAXb7wVEo5B8=;
 b=fWNWclVCP7yb6PRGdaHwJU36vdosmEtILhVpHh1Dft7yjU5+tpffc0T3bKIHaLvVa5
 6GUlw4ZT2w4JSrjJX35NsQEpGu4Pq37gCstpF8uBjvHfW9J9eStHKGh/zhokAxRC0eO6
 S9RVU7Dyf2hRn1j4oo04JPj5FtiFCcnLQB1ZKU8ozGdJdStwMGXaAwuuf1Ob/PfcIs2S
 5AVV6a5NomIoKYT6rX4Cm4s2WpsB4Xd2b5aE8oQtK1rB4KyQhTkyutJo/36YNf90ikHc
 ugblG3MrlEcPUWYoMXlaHWxsBYww6mVY1fxqJTIW1bHm/NRbH7hQTrTiMRF9IdkjOzwW
 4qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685533066; x=1688125066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:user-agent:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fh64C8hkWvIxoEEFtvqDZZB+RBg5ssruAXb7wVEo5B8=;
 b=jDHcUIW/WF6iVHjgQTJ7Ozz5Sg81qxElLWtKyW0MZxUYs4sQ/5R+CXatFnJFA1eTUd
 PjkAnrrwE3M57lZWsSwiARYKSRQG1zh6+YV/IbgcsuAN2uIwTrpqKMrFJYIU5GPK2nUm
 uCIPAeLYtMWGMMizpsncpcFQ11F63aGNiMq2H5uDDrryD59y7Uz826gTvAF7PBgldKDW
 hKDf6Ix+QD27BRJ663OzU7iXoNeSbR4v3jHnw1Q1YcnpcRHOuEBqIAe1Z/H6noxIl8rC
 +3oum2n7aqEJsQyaCJQYDSQzqJhQitMXaZdOUNEa1y+raO13Zja8FZSIsXwHYUACqqYF
 Y93Q==
X-Gm-Message-State: AC+VfDyayF3ZK/k8LyJmoloJqyh2KFCieXlTZWilX/GMHg63rXg+0QMc
 BnPsJejJzzn4nAlFI9s5+oF3Vw==
X-Google-Smtp-Source: ACHHUZ6jnp2FzjY3fQcGeDHSIt1/q0pWik8dCMLsPJ6NzDzQyWupB/Uwo9GtMWd9+TBeAlnUgIhO9w==
X-Received: by 2002:a5d:50ca:0:b0:30c:2bbf:bf75 with SMTP id
 f10-20020a5d50ca000000b0030c2bbfbf75mr392223wrt.26.1685533066074; 
 Wed, 31 May 2023 04:37:46 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a05600c46cd00b003f1978bbcd6sm3030231wmo.3.2023.05.31.04.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 04:37:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4BC041FFBB;
 Wed, 31 May 2023 12:37:45 +0100 (BST)
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Erik Skultety <eskultet@redhat.com>, Brian Cain <bcain@quicinc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>
Subject: How do you represent a host gcc and a cross gcc in lcitool?
Date: Wed, 31 May 2023 12:23:34 +0100
Message-ID: <87wn0obuk6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

Hi,

While trying to convert the debian-riscv64-cross docker container to an
lcitool based one I ran into a problem building QEMU. The configure step
fails because despite cross compiling we still need a host compiler to
build the hexagon codegen tooling.

After scratching my head for a while I discovered we did have host GCC's
in our cross images despite there being no explicit request for them in
the docker description. It turned out that the gcovr requirement pulled
in lcov which itself had a dependency on gcc. However this is a bug:

  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D987818

which has been fixed in bookworm (and of course sid which is the only
way we can get a riscv64 build of QEMU at the moment). Hence my hacky
attempts to get gcc via side effect of another package failed.

Hence the question in $SUBJECT. I tried to add a mapping to lcitool for
a pseudo hostgcc package:

+  hostgcc:
+    default: gcc
+    pkg:
+    MacOS:
+    cross-policy-default: skip

however this didn't work. Do we need a new mechanism for this or am I
missing a way to do this?

RiscV guys,

It's clear that relying on Debian Sid for the QEMU cross build for RiscV
is pretty flakey. Are you guys aware of any other distros that better
support cross compiling to a riscv64 target or is Debian still the best
bet? Could you be persuaded to build a binary docker image with the
cross compilers and libraries required for a decent cross build as an
alternative?

Thanks,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

