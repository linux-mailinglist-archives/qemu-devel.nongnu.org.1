Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AEF7909C0
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 23:15:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcXwL-00023Q-W0; Sat, 02 Sep 2023 17:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1qcXwJ-000232-KA
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 17:13:55 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1qcXwG-0007xg-V4
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 17:13:54 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-401d67434daso2497745e9.2
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 14:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20230601.gappssmtp.com; s=20230601; t=1693689231; x=1694294031;
 darn=nongnu.org; 
 h=message-id:in-reply-to:to:references:date:subject:mime-version
 :content-transfer-encoding:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w0LuNJeVZ74IqV3n1wTUg2pN65vx8qMHsVrL3JlnPkw=;
 b=pr3Y/HUgAjjT1wm/EQzb6DVQVkRI57TOeRBOWsjP2PHJjTykJcq8fzg3tDswMfpIUM
 gcgvUDYRzssH7IK3uYtXYg0hSv+YkAhEDF0HhKTpz5ksyEEz9y4bj0geuUp4FW2BHNyn
 HCCa6Q83QL0as5beKG13YOIwp+1FSgFBHrm2nKojiv1JTNQwcrlFBM67tlIgk7TDudbT
 1p4cut48a2ZruvGLxyfTIgol6lmr0MpbjNcHy+Jrca6s7Ycd0YzS1AqEQqzw0Fw8fzoO
 ZLb1pMQ9tRVEmlxIijJqeJTZSRpyu8xlG+BuOUXwlS2GHiUCXXCUFrKL3hZMP+K22cTe
 p+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693689231; x=1694294031;
 h=message-id:in-reply-to:to:references:date:subject:mime-version
 :content-transfer-encoding:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w0LuNJeVZ74IqV3n1wTUg2pN65vx8qMHsVrL3JlnPkw=;
 b=Khevjs+/457vUxeD2P1QJioB8b11sHC/pRZqn124hvQIBwuMoWZOjuwhqST0M38bAu
 9mejH6CAlRnsA9d0N1bxKwXRjFiGFTYitNdsqpuENaakFYp67oiPtgSKHBMap93xtcGE
 ClPMDvtgD7C+lOZXMEfHqbtWLDYPeb76OxPLFjrvML2E8Nh8ADBRvfztgbf4TTqmzy/4
 6zNbB8X71GjD4FLLVZWKtM+PaeSj4ruhCBfZZEFELkS7/AN3peNuDvc3+N9Byhc/Vo3p
 jkLfD4sIGFHRaxC94Z+srk9+ufyAexDUH1Hk1qShzWu6CbvyOWowfOm8gDRhoZ/oCLc/
 1Qzg==
X-Gm-Message-State: AOJu0Yz5L3cOyZHOlpemzRgtW6OqqPdJVsoeJV8a9vTe+Qne6Be6kqDr
 FSPcMfM+Bzp7d1NRqutQb7GyUgmQOztGHqWTM0Wi8g==
X-Google-Smtp-Source: AGHT+IFQcIsLIhm6xvVMW3UaC2Qz4pkOsqroHHuquqWnfzvf8lZwOev89i690ScpOnbndV2zpHv3YQ==
X-Received: by 2002:a05:600c:3797:b0:401:d1a3:d7f7 with SMTP id
 o23-20020a05600c379700b00401d1a3d7f7mr4475055wmr.30.1693689230650; 
 Sat, 02 Sep 2023 14:13:50 -0700 (PDT)
Received: from smtpclient.apple ([86.121.135.50])
 by smtp.gmail.com with ESMTPSA id
 a14-20020a05600c224e00b003fbe4cecc3bsm12206237wmm.16.2023.09.02.14.13.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 02 Sep 2023 14:13:50 -0700 (PDT)
From: Liviu Ionescu <ilg@livius.net>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: Error: .seh_endproc used in segment '.text' instead of expected
 '.text$qemu_close_socket_osfhandle'
Date: Sun, 3 Sep 2023 00:13:47 +0300
References: <0C1AED16-2AC0-43FE-AEA6-BF3F61B62536@livius.net>
To: QEMU Developers <qemu-devel@nongnu.org>
In-Reply-To: <0C1AED16-2AC0-43FE-AEA6-BF3F61B62536@livius.net>
Message-Id: <0D6F61D2-BC24-4187-AAE1-1CA302E3D12F@livius.net>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: none client-ip=2a00:1450:4864:20::32f;
 envelope-from=ilg@livius.net; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



> On 2 Sep 2023, at 21:43, Liviu Ionescu <ilg@livius.net> wrote:
>=20
> ... With the same build scripts, compiling QEMU 7.1.0 was ok, the =
problem was introduced in the last year.

I also tried 7.2.5, and it passed the build, with the same scripts and =
the same toolchain, so the problem seems to be specific to 8.x.

For now I'll stick to 7.2.5, until the issues with the 8.1.0 build will =
be clarified.

Regards,

Liviu


