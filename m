Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42592710205
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 02:33:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1yt4-0008EL-DT; Wed, 24 May 2023 20:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1q1ysm-0008DQ-G3; Wed, 24 May 2023 20:31:10 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1q1ysi-0001mH-DA; Wed, 24 May 2023 20:31:08 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id 208653200312;
 Wed, 24 May 2023 20:30:57 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
 by compute6.internal (MEProxy); Wed, 24 May 2023 20:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
 1684974656; x=1685061056; bh=YfG9zvQQaoepnMMNfqy6+0+2t7ayqDlcNWh
 DHjm2lcM=; b=Swn4lhOeh2zK21cBKQR5jA04+SHWhgQKrAoBe2uAysYZZfmcTG9
 ET15y4oC0o5Xuzc1ZjFjsqCf869rBjJ4kF179Z4Jhix2PbrJnmPSx/GEhE/Gz+ii
 WQSjiI3SHUMxz/Y+pXR058fG1AEAlG8fNYIZmPnMimh0xjUvENCGdiJTy4BejAbR
 36OzejhAvfC9O4zW0b2xpLZzUOBFAstw/CwBhPI6WxN/JDieOWAMhXYBqQyo3Prq
 waWb00OR/SbNkqYICohO8bxHXmx6u2zAlYO0IbQtJmESH0U74z/BRlntJ3B122G9
 ZqvPhOmBXtjG2+BRL1XEj4wGxmmZAFSaXuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1684974656; x=1685061056; bh=YfG9zvQQaoepnMMNfqy6+0+2t7ayqDlcNWh
 DHjm2lcM=; b=S2mB6oLMv0IWQOJXEl/s3hO3mnZmxZaN6eAtqToRsGexpsFKD1g
 mWUP1CJNuNJ9/LraWnspSjJDPIZ+ihGD8nIe0eOVC8jJJhzBPtTTpxvV1lK0HOe/
 D4SzUxsHKzUq43N+n4jj4cCPGg6uFShsRtpDojsum06tf5zegx9VFFdstT3D7VKP
 kNcXi+npv64Mzr9+Fir2iuwTa6SXedwAoGFXJKrM0UzuSWmwyW+q57yAOIL3AaJL
 yEe1urKsFMOmii1UCKQT7/RHDV+Yu939hUHXHLrcusFIZEDYytZDIctA5Hft88Z4
 RbmYC+8lSnPFLjiW1qoEbA3Qpvw1Slfeq2A==
X-ME-Sender: <xms:QKxuZELxonq0O2fZNGCD75eFEKJARqzlo1SlZ_6CHuQ0bewxv3Dbhg>
 <xme:QKxuZEIh8Ii0lnoT2cO22oBQeG-4XPDjvo2XUrakyPx9yWv2Wgy_JGRF_yhTVuwyP
 XXrYQ8UuaVj6LQtSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejiedgfeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
 nhgurhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecugg
 ftrfgrthhtvghrnhepleekteeivdfgkeeuheetkeeufefgueffvdeiudeihefgfeeliefh
 gefhledvfeefnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorh
 hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghn
 ughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:QKxuZEvNV-jCLdXmf-Hxlg2KuJMp3wdKqVJv29EUdTFNyFmN1uy4Ew>
 <xmx:QKxuZBY3219vh-7ASvS_nmhAKpS3cyiBDLU1vCdciTi4tco0z_JCLA>
 <xmx:QKxuZLb8X9y_1WiOxz4URLtVkHjhQ8KtWMV1Jch7YOngwvNgoaRtyA>
 <xmx:QKxuZHGJ0P11_b9JV6xDLjBBNX2tkMuKibp2tx4XHDzGQsy0gpCjOA>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 5BFBF1700093; Wed, 24 May 2023 20:30:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <80168e3a-b0f6-463e-b473-8488a897ef16@app.fastmail.com>
In-Reply-To: <CACPK8XeSBh+SMWPZ68rkeRnOcTFE0_SFcCNoYZr85DLhzGsgtQ@mail.gmail.com>
References: <20230523214520.2102894-1-ninad@linux.ibm.com>
 <20230523214520.2102894-2-ninad@linux.ibm.com>
 <7fadea2f-39e0-902f-848a-8f9bd7ff1f52@kaod.org>
 <CACPK8XeSBh+SMWPZ68rkeRnOcTFE0_SFcCNoYZr85DLhzGsgtQ@mail.gmail.com>
Date: Thu, 25 May 2023 10:00:35 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: "Joel Stanley" <joel@jms.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: "Ninad Palsule" <ninad@linux.ibm.com>,
 "Cameron Esfahani via" <qemu-devel@nongnu.org>,
 "Peter Maydell" <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9_via?= <qemu-arm@nongnu.org>
Subject: Re: [PATCH v3 1/1] hw/arm/aspeed:Add vpd data for Rainier machine
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=64.147.123.21; envelope-from=andrew@aj.id.au;
 helo=wout5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On Wed, 24 May 2023, at 17:14, Joel Stanley wrote:
> On Wed, 24 May 2023 at 06:38, C=C3=A9dric Le Goater <clg@kaod.org> wro=
te:
>>
>> But, I also got this :
>>
>>    root@p10bmc:~# [   91.656331] watchdog: watchdog0: watchdog did no=
t stop!
>>    [   91.734858] systemd-shutdown[1]: Using hardware watchdog 'aspee=
d_wdt', version 0, device /dev/watchdog0
>>    [   91.735766] systemd-shutdown[1]: Watchdog running with a timeou=
t of 1min.
>>    [   91.987363] systemd-shutdown[1]: Syncing filesystems and block =
devices.
>>    [   93.471897] systemd-shutdown[1]: Sending SIGTERM to remaining p=
rocesses...
>>
>> and the machine rebooted.
>>
>> Joel had the same problem :
>>
>>    https://github.com/openbmc/qemu/issues/39
>>
>> Is it unrelated ? I haven't started a rainier in 2 years at least so =
I can
>> not tell.
>
> I don't think it's related to Ninad's patches.
>
> I am able to reproduce the issue on my old Skylake x86 machine, but it
> doesn't happen on my M1 mac mini.
>
> I suspect the emulation is moving too slowly, but the host's wall
> clock is still ticking, so all of a sudden the BMC finds out that time
> has passed an the watchdog bites. I could be wrong.

Yeah, I also suspect this is occurring. In some cases we see output
like:

```
[  295.474921] hrtimer: interrupt took 411679950 ns
Watchdog timer 0 expired.
```

This suggests that we've exhausted the three iterations of the hrtimer
callback list from the hrtimer interrupt[1]. Too much stuff happening
for the time-keeping we have.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/kernel/time/hrtimer.c?h=3Dv6.3#n1869

However, regarding C=C3=A9dric's log above, a reboot is expected on the =
first
boot of a fresh image when there's valid VPD available. For the first
boot of a fresh image we configure the kernel with a minimal devicetree
that allows us to read the VPD data. This determines the system we're
actually on and configures an appropriate devicetree for subsequent
boots. We then reboot to pick up the new devicetree.

The devicetree to use is stored in the u-boot environment (in
`fitconfig`).

Andrew

