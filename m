Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 407E070EFCA
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 09:45:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1jB6-0000MX-52; Wed, 24 May 2023 03:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1q1jB3-0000Lz-6o; Wed, 24 May 2023 03:44:57 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1q1jAz-0001qd-RG; Wed, 24 May 2023 03:44:56 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-510e419d701so1533111a12.1; 
 Wed, 24 May 2023 00:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1684914290; x=1687506290;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=azQlUZaekqzVbw1xVCGpAP01lrzfd5dmP8lio3pw1+c=;
 b=QHSnrNv0xyMrvWCnoM7btu0au2mK1N+3tZMyOEHyu6Wm16Q2LDM5BbZzFYIu4jBfbv
 qm6qgTwEjNkgemMUGXJpEXH74vXRWNioCWSL0pO/nyzE8um2r/EFKiSnPY19/Yb6fq0Q
 hO604X5nWxC7J3OFJE/xhuefqZMS2xJmz+tTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684914290; x=1687506290;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=azQlUZaekqzVbw1xVCGpAP01lrzfd5dmP8lio3pw1+c=;
 b=YmAYO7qGb1CM3fKRm2YkwqiZG4IqVz5kcHQPgOzUg3Hm+Ztr7PhBkYp88cdm3fynGH
 +yu5Bvsid0btW9yPfhQ3IqEe0IuagerJShWYEHVhm6MzmCtCUwYhYQuuS4giPkR+L+Q/
 OEsbgzBFL0vkEOQDdBQoyRkqgoC3KS70GJYhqyCQ/M9I61o209OUUyAPip68iZrRZvGJ
 Em7ge68+etHFncJ9VqJDCXO8+UrbYAsRne2+WrvEX/dzq0ehquGdaQccFkHOEftIQPw3
 UQR/5eIWk00YL39dAOQA0a21XBXi/Mx3eeRnbVi+b9Z/v8gAETOUfpUi/i3T3MH30pTe
 7TwQ==
X-Gm-Message-State: AC+VfDwsJj6cUSHEKLM6LoNPNxuSF6bRrtqdMZtxkAjYPZAnNuBu6YWE
 Af18TMJGLUOZL0CgVBak3L8b1WrEAkb860Uvw74ZEBQ1+gg=
X-Google-Smtp-Source: ACHHUZ6n3nC0S345/SP2Xmepu7h/ZLY8+2dtOvgCc4D7om94kB7Q5aNAgFcrpw+TUojfTM4Ormg95y0hWe8Xzu3XHeI=
X-Received: by 2002:a17:907:26ca:b0:969:bac4:8e22 with SMTP id
 bp10-20020a17090726ca00b00969bac48e22mr14984418ejc.26.1684914290329; Wed, 24
 May 2023 00:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230523214520.2102894-1-ninad@linux.ibm.com>
 <20230523214520.2102894-2-ninad@linux.ibm.com>
 <7fadea2f-39e0-902f-848a-8f9bd7ff1f52@kaod.org>
In-Reply-To: <7fadea2f-39e0-902f-848a-8f9bd7ff1f52@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 24 May 2023 07:44:38 +0000
Message-ID: <CACPK8XeSBh+SMWPZ68rkeRnOcTFE0_SFcCNoYZr85DLhzGsgtQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] hw/arm/aspeed:Add vpd data for Rainier machine
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@aj.id.au, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=joel.stan@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, 24 May 2023 at 06:38, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 5/23/23 23:45, Ninad Palsule wrote:
> > The current modeling of Rainier machine creates zero filled VPDs(EEPROM=
s).
> > This makes some services and applications unhappy and causing them to f=
ail.
> > Hence this drop adds some fabricated data for system and BMC FRU so tha=
t
> > vpd services are happy and active.
> >
> > Tested:
> >     - The system-vpd.service is active.
> >     - VPD service related to bmc is active.
> >
> > Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>
> You can keep the R-b tag when you resend, unless there are a lot of chang=
es.
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>
> Since I am curious, I started a rainier machine under QEMU and ran some
> commands :
>
>    root@p10bmc:~# hexdump -C /sys/bus/i2c/devices/i2c-8/8-0050/eeprom
>    00000000  00 00 00 00 00 00 00 00  00 00 00 84 28 00 52 54  |.........=
...(.RT|
>    00000010  04 56 48 44 52 56 44 02  01 00 50 54 0e 56 54 4f  |.VHDRVD..=
.PT.VTO|
>    00000020  43 00 00 37 00 4a 00 00  00 00 00 50 46 08 00 00  |C..7.J...=
..PF...|
>    00000030  00 00 00 00 00 00 00 00  46 00 52 54 04 56 54 4f  |........F=
.RT.VTO|
>    00000040  43 50 54 38 56 49 4e 49  00 00 81 00 3a 00 00 00  |CPT8VINI.=
...:...|
>    00000050  00 00 56 53 59 53 00 00  bb 00 27 00 00 00 00 00  |..VSYS...=
.'.....|
>    00000060  56 43 45 4e 00 00 e2 00  27 00 00 00 00 00 56 53  |VCEN....'=
.....VS|
>    00000070  42 50 00 00 09 01 19 00  00 00 00 00 50 46 01 00  |BP.......=
...PF..|
>    00000080  00 00 36 00 52 54 04 56  49 4e 49 44 52 04 44 45  |..6.RT.VI=
NIDR.DE|
>    00000090  53 43 48 57 02 30 31 43  43 04 33 34 35 36 46 4e  |SCHW.01CC=
.3456FN|
>    000000a0  04 46 52 34 39 53 4e 04  53 52 31 32 50 4e 04 50  |.FR49SN.S=
R12PN.P|
>    000000b0  52 39 39 50 46 04 00 00  00 00 00 00 23 00 52 54  |R99PF....=
...#.RT|
>    000000c0  04 56 53 59 53 53 45 07  49 42 4d 53 59 53 31 54  |.VSYSSE.I=
BMSYS1T|
>    000000d0  4d 08 32 32 32 32 2d 32  32 32 50 46 04 00 00 00  |M.2222-22=
2PF....|
>    000000e0  00 00 00 23 00 52 54 04  56 43 45 4e 53 45 07 31  |...#.RT.V=
CENSE.1|
>    000000f0  32 33 34 35 36 37 46 43  08 31 31 31 31 2d 31 31  |234567FC.=
1111-11|
>    00000100  31 50 46 04 00 00 00 00  00 00 15 00 52 54 04 56  |1PF......=
...RT.V|
>    00000110  53 42 50 49 4d 04 50 00  10 01 50 46 04 00 00 00  |SBPIM.P..=
.PF....|
>    00000120  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |.........=
.......|
>    *
>    00002000
>    root@p10bmc:~# hexdump -C /sys/bus/i2c/devices/i2c-8/8-0051/eeprom
>    00000000  00 00 00 00 00 00 00 00  00 00 00 84 28 00 52 54  |.........=
...(.RT|
>    00000010  04 56 48 44 52 56 44 02  01 00 50 54 0e 56 54 4f  |.VHDRVD..=
.PT.VTO|
>    00000020  43 00 00 37 00 20 00 00  00 00 00 50 46 08 00 00  |C..7. ...=
..PF...|
>    00000030  00 00 00 00 00 00 00 00  1c 00 52 54 04 56 54 4f  |.........=
.RT.VTO|
>    00000040  43 50 54 0e 56 49 4e 49  00 00 57 00 1e 00 00 00  |CPT.VINI.=
.W.....|
>    00000050  00 00 50 46 01 00 00 00  1a 00 52 54 04 56 49 4e  |..PF.....=
.RT.VIN|
>    00000060  49 44 52 04 44 45 53 43  48 57 02 30 31 50 46 04  |IDR.DESCH=
W.01PF.|
>    00000070  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |.........=
.......|
>
> and
>
>    root@p10bmc:~# systemctl status  com.ibm.VPD.Manager.service  -l
>    * com.ibm.VPD.Manager.service - IBM VPD Manager
>         Loaded: loaded (/lib/systemd/system/com.ibm.VPD.Manager.service; =
enabled; preset: enabled)
>         Active: active (running) since Wed 2023-05-24 06:26:34 UTC; 1min =
28s ago
>       Main PID: 2784 (vpd-manager)
>            CPU: 101ms
>         CGroup: /system.slice/com.ibm.VPD.Manager.service
>                 `-2784 /usr/bin/vpd-manager

When it works we should be able to do things like this, I'm told:

vpd-tool -r -O /system/chassis/motherboard -R VSYS -K TM
{
    "/system/chassis/motherboard": {
        "TM": "2222-222"
    }
}


>
> But, I also got this :
>
>    root@p10bmc:~# [   91.656331] watchdog: watchdog0: watchdog did not st=
op!
>    [   91.734858] systemd-shutdown[1]: Using hardware watchdog 'aspeed_wd=
t', version 0, device /dev/watchdog0
>    [   91.735766] systemd-shutdown[1]: Watchdog running with a timeout of=
 1min.
>    [   91.987363] systemd-shutdown[1]: Syncing filesystems and block devi=
ces.
>    [   93.471897] systemd-shutdown[1]: Sending SIGTERM to remaining proce=
sses...
>
> and the machine rebooted.
>
> Joel had the same problem :
>
>    https://github.com/openbmc/qemu/issues/39
>
> Is it unrelated ? I haven't started a rainier in 2 years at least so I ca=
n
> not tell.

I don't think it's related to Ninad's patches.

I am able to reproduce the issue on my old Skylake x86 machine, but it
doesn't happen on my M1 mac mini.

I suspect the emulation is moving too slowly, but the host's wall
clock is still ticking, so all of a sudden the BMC finds out that time
has passed an the watchdog bites. I could be wrong.

The rainier firmware crashes all over the place due to missing
hardware. These crashes cause applications to core dump due to
OpenBMC's C++ exception throwing coding style, causing the system to
go even slower which leads to more timeouts and more crashes. Ninad's
work is the first piece in an attempt to get us to "BMC ready" without
any services crashing.

The status quo does make it hard to test.

Cheers,

Joel

