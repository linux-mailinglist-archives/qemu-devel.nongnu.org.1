Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 325FF79234D
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 16:08:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdWhc-0004VV-0X; Tue, 05 Sep 2023 10:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qdWha-0004VE-O0
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 10:06:46 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qdWhY-0004x6-3q
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 10:06:46 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40078c4855fso25263615e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 07:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693922801; x=1694527601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=63dKeOWWjtOewwSOzTopZH+LnBxtUDrpAsCJ2y5bJUc=;
 b=BzrsnvNaJid1a1S5vCPGpINXO3JyX6+iaXUg9H5FgEtoL58XdpmIkYxTJcnSduVXgC
 h/ioeNrk2yG8aMLvkHXyeoHtbhKCLdw58cN+rQGREfJVPo1OpzeMRPZdELNIYpRPBiIk
 Mw7WbDkJIG7wSk98l4cvczsiWjxSe8JXVIoGeVoBImbaAj9s0PeD9YFFugqjZdxU+nRf
 BmtYB9MJfnmFJ/0Zl9993GqCg8YapZFJUbkr8QRTVHabsTBNXXohY71E1yVWDlwebKjh
 am+ISIGUh7iRsRwGquu/n+vlTNwdQd2+RaumFKQLOk5vkCznUnGOctU7ZYMtUlAiqqhQ
 wRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693922801; x=1694527601;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=63dKeOWWjtOewwSOzTopZH+LnBxtUDrpAsCJ2y5bJUc=;
 b=SkSiLqh40oQVHNx6WnEKLbjpKAwNaKPw3QZYOYWWHP9CyXBGTcB1Mw/2Ww0ktB968d
 F/cWWb//p4ucghgNSFTAMEmW1DSDmmgu8CxVqLR2Me4qixIgQQQF3SG34zOQVeaMSD1T
 1X/9jPcaxvxMoqSN4Q1KEqVV8n4m7BFt4autOeydWTMIMz1vyATQTBRwh+ku1aSiSN2i
 OXcstQI1Ep4+fWKRV3c5vuWUSE3x+/elpDV4MBr3TzSQM0p90x4PCLraH6BVINI1IpVv
 /2Oz2YYc0AOfahADemzb7Hj1juxu2kLD6kgeF07EIrkGNdEv/GKfVL1hdaCJa98bbImV
 neLA==
X-Gm-Message-State: AOJu0YxWaMc9eVk1K8hiE7Iz4tF9HmQAXCcf3LgwGT4t8o31/jZBMj1Z
 wvNNCXHTNffunKvh962qNfPCOA==
X-Google-Smtp-Source: AGHT+IG1aFHZ3q+GpckyIQ+FGt9r0ABnjHKtum/Sf4AgBsHuGuqEmp+dWKtsLCu+HsF1yck+05NopQ==
X-Received: by 2002:a05:600c:ac4:b0:3fb:efe2:34a2 with SMTP id
 c4-20020a05600c0ac400b003fbefe234a2mr8807666wmr.5.1693922801396; 
 Tue, 05 Sep 2023 07:06:41 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t25-20020a7bc3d9000000b003fed4fa0c19sm20288718wmj.5.2023.09.05.07.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 07:06:41 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8ED111FFBB;
 Tue,  5 Sep 2023 15:06:40 +0100 (BST)
References: <4f2a4b734b20b80857d56af986335f78a92a0fff.camel@linuxfoundation.org>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <aleksandar.rikalo@syrmia.com>, Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: mips system emulation failure with virtio
Date: Tue, 05 Sep 2023 14:59:57 +0100
In-reply-to: <4f2a4b734b20b80857d56af986335f78a92a0fff.camel@linuxfoundation.org>
Message-ID: <87pm2whfyn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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


Richard Purdie <richard.purdie@linuxfoundation.org> writes:

> With qemu 8.1.0 we see boot hangs fox x86-64 targets.=C2=A0
>
> These are fixed by 0d58c660689f6da1e3feff8a997014003d928b3b (softmmu:
> Use async_run_on_cpu in tcg_commit) but if I add that commit, mips and
> mips64 break, hanging at boot unable to find a rootfs.=C2=A0

(Widen CC list)

>
> We use virtio for network and disk and both of those change in the
> bootlog from messages like:
>
> [    1.726118] virtio-pci 0000:00:13.0: enabling device (0000 -> 0003)
> [    1.728864] virtio-pci 0000:00:14.0: enabling device (0000 -> 0003)
> [    1.729948] virtio-pci 0000:00:15.0: enabling device (0000 -> 0003)
> ...
> [    2.162148] virtio_blk virtio2: 1/0/0 default/read/poll queues
> [    2.168311] virtio_blk virtio2: [vda] 1184242 512-byte logical=20
>
> to:
>
> [    1.777051] virtio-pci 0000:00:13.0: enabling device (0000 -> 0003)
> [    1.779822] virtio-pci 0000:00:14.0: enabling device (0000 -> 0003)
> [    1.780926] virtio-pci 0000:00:15.0: enabling device (0000 -> 0003)
> ...
> [    1.894852] virtio_rng: probe of virtio1 failed with error -28
> ...
> [    2.063553] virtio_blk virtio2: 1/0/0 default/read/poll queues
> [    2.064260] virtio_blk: probe of virtio2 failed with error -28
> [    2.069080] virtio_net: probe of virtio0 failed with error -28
>
>
> i.e. the virtio drivers no longer work.

Interesting, as you say this seems to be VirtIO specific as the baseline
tests (using IDE) work fine:

  =E2=9E=9C  ./tests/venv/bin/avocado run ./tests/avocado/tuxrun_baselines.=
py:test_mips64
  JOB ID     : 71f3e3b7080164b78ef1c8c1bb6bc880932d8c9b
  JOB LOG    : /home/alex/avocado/job-results/job-2023-09-05T15.01-71f3e3b/=
job.log
   (1/2) ./tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_mips64=
: PASS (12.19 s)
   (2/2) ./tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_mips64=
el: PASS (11.78 s)
  RESULTS    : PASS 2 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | =
CANCEL 0
  JOB TIME   : 24.79 s

> I tested with current qemu master
> (17780edd81d27fcfdb7a802efc870a99788bd2fc) and mips is still broken
> there.
>
> Is this issue known about?

Could you raise a bug at:

  https://gitlab.com/qemu-project/qemu/-/issues

I'm curious why MIPS VirtIO is affected but nothing else is...

>
> Cheers,
>
> Richard


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

