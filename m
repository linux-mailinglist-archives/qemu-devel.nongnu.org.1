Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BBE7923AA
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 16:51:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdXO9-0006rS-5D; Tue, 05 Sep 2023 10:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.purdie@linuxfoundation.org>)
 id 1qdXO6-0006oh-TN
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 10:50:43 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.purdie@linuxfoundation.org>)
 id 1qdXO3-0004aq-Sp
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 10:50:42 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5007f3d3235so4113545e87.2
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 07:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1693925438; x=1694530238; darn=nongnu.org; 
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=i4XaxetW0GXNjbOSWHCDq8J1VZUNUO0jbEnTLIRbyrU=;
 b=WKI8SsgTNjejPegQXSdObWHUn+u5iO6JmhVxOkLEA8/hOK1y7tScBdd7e4pxSd1ZPR
 NWle+w55rHPjb+BqHQVwBBz83lGBP63n5MVUIylzjXPGFQ3z7YlQTfQfo7gCgRYgXsma
 smH44NT1SAaPSGURWkJBPS5+oNJgFL27pl15c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693925438; x=1694530238;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i4XaxetW0GXNjbOSWHCDq8J1VZUNUO0jbEnTLIRbyrU=;
 b=UkIJD584ovNUdsiRaDfiG6Rh+0+vH9MoA3k7ncGMY6FakvVdI2SJGfA18LlNo10+Sw
 JsHctIC0utqO5jNy91DuSxfhykZ+rbT8fm8g63R+EZP+HnbwpiXckzaytyUp/7P8k3be
 NqmBTm+YucisLCvCaA69oQ04KUTJFUDDKjr0d0PdtdSbscHTjRE7WIvJ0Txpz3TNiZU7
 dvyrfObKgTETpoejHt85p/dJM8wshJM7VbZa3y7TBLgPgiPPPVCfSmo2UTvDxqAD+xeS
 DpDZEKLI7CWG8z6uMWE+gZKNvB9XrZui0CbAJL5gxU+9unECmnmByFSJzjiR2d66JDo7
 OPjQ==
X-Gm-Message-State: AOJu0YzqIyUA6W/eK002MeITMmHOhCmTA0bBrNVlO/BX1xze9EeLikKD
 bLDkRclBGyfgDtZIYG8vqUkpjw==
X-Google-Smtp-Source: AGHT+IHqLd7cAgphCla9u8ODbufxCU/U80PR1M7MdlAq1IY/O+hMlwTerSSXPBuWhxkaNAJI02PvHA==
X-Received: by 2002:ac2:5631:0:b0:4fa:21d4:b3ca with SMTP id
 b17-20020ac25631000000b004fa21d4b3camr57802lff.2.1693925437799; 
 Tue, 05 Sep 2023 07:50:37 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:9cbb:8ec6:1cb5:104e?
 ([2001:8b0:aba:5f3c:9cbb:8ec6:1cb5:104e])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a05600c379200b003fee65091fdsm20456403wmr.40.2023.09.05.07.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 07:50:37 -0700 (PDT)
Message-ID: <0cbd86af5501f18007a926598c6e2232af240d00.camel@linuxfoundation.org>
Subject: Re: mips system emulation failure with virtio
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <aleksandar.rikalo@syrmia.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Date: Tue, 05 Sep 2023 15:50:36 +0100
In-Reply-To: <87pm2whfyn.fsf@linaro.org>
References: <4f2a4b734b20b80857d56af986335f78a92a0fff.camel@linuxfoundation.org>
 <87pm2whfyn.fsf@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=richard.purdie@linuxfoundation.org;
 helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 2023-09-05 at 14:59 +0100, Alex Benn=C3=A9e wrote:
> Richard Purdie <richard.purdie@linuxfoundation.org> writes:
>=20
> > With qemu 8.1.0 we see boot hangs fox x86-64 targets.=C2=A0
> >=20
> > These are fixed by 0d58c660689f6da1e3feff8a997014003d928b3b (softmmu:
> > Use async_run_on_cpu in tcg_commit) but if I add that commit, mips and
> > mips64 break, hanging at boot unable to find a rootfs.=C2=A0
>=20
> (Widen CC list)
>=20
> >=20
> > We use virtio for network and disk and both of those change in the
> > bootlog from messages like:
> >=20
> > [    1.726118] virtio-pci 0000:00:13.0: enabling device (0000 -> 0003)
> > [    1.728864] virtio-pci 0000:00:14.0: enabling device (0000 -> 0003)
> > [    1.729948] virtio-pci 0000:00:15.0: enabling device (0000 -> 0003)
> > ...
> > [    2.162148] virtio_blk virtio2: 1/0/0 default/read/poll queues
> > [    2.168311] virtio_blk virtio2: [vda] 1184242 512-byte logical=20
> >=20
> > to:
> >=20
> > [    1.777051] virtio-pci 0000:00:13.0: enabling device (0000 -> 0003)
> > [    1.779822] virtio-pci 0000:00:14.0: enabling device (0000 -> 0003)
> > [    1.780926] virtio-pci 0000:00:15.0: enabling device (0000 -> 0003)
> > ...
> > [    1.894852] virtio_rng: probe of virtio1 failed with error -28
> > ...
> > [    2.063553] virtio_blk virtio2: 1/0/0 default/read/poll queues
> > [    2.064260] virtio_blk: probe of virtio2 failed with error -28
> > [    2.069080] virtio_net: probe of virtio0 failed with error -28
> >=20
> >=20
> > i.e. the virtio drivers no longer work.
>=20
> Interesting, as you say this seems to be VirtIO specific as the baseline
> tests (using IDE) work fine:
>=20
>   =E2=9E=9C  ./tests/venv/bin/avocado run ./tests/avocado/tuxrun_baseline=
s.py:test_mips64
>   JOB ID     : 71f3e3b7080164b78ef1c8c1bb6bc880932d8c9b
>   JOB LOG    : /home/alex/avocado/job-results/job-2023-09-05T15.01-71f3e3=
b/job.log
>    (1/2) ./tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_mips=
64: PASS (12.19 s)
>    (2/2) ./tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_mips=
64el: PASS (11.78 s)
>   RESULTS    : PASS 2 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 =
| CANCEL 0
>   JOB TIME   : 24.79 s
>=20
> > I tested with current qemu master
> > (17780edd81d27fcfdb7a802efc870a99788bd2fc) and mips is still broken
> > there.
> >=20
> > Is this issue known about?
>=20
> Could you raise a bug at:
>=20
>   https://gitlab.com/qemu-project/qemu/-/issues

Done, https://gitlab.com/qemu-project/qemu/-/issues/1866

> I'm curious why MIPS VirtIO is affected but nothing else is...

Me too, it seems there is a real code issue somewhere in this...

Cheers,

Richard




