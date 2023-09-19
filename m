Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2BB7A6B69
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 21:20:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qigGV-0000tu-5O; Tue, 19 Sep 2023 15:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qigGI-0000ez-P2
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 15:19:56 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qigGG-0008Ov-Eq
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 15:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695151188; x=1695755988; i=deller@gmx.de;
 bh=PbrqXDE3JBn9ckkRFPhBrQLxDNS1QmqF2tCOwzt9vEQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=cPHIc2oJL78BXci1ir52YRRJWppnN4obkim2hZOaOx7thOyP2Z1r6k8APpGnDxSYAFw4MQOvIcr
 Ialzkj70XY1R7IwpsUn0NmhzkBHAXvc267wKqbsktf0OtIPALkBNHVU64u0E2N8suxU/l/rPfX+pP
 muxpF998RDs2PwcoFGZu12I4Yuh4v76V/SNVgywwpKq2b53Dl3+PkzMMX5Tqzf4yGS+bL1voi7blU
 C4uoDdOz7ZBm7R0sLGfyjmjmCzdblqBGlIGDPajFZA081Tfi63U1ic77HBOFliZ25tU4PwjlXt34a
 2HzBnUre2l+nMim31a4ntyHLFBVnAgqBIq+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.152.254]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdNcA-1rHk1s0hii-00ZOTX; Tue, 19
 Sep 2023 21:19:48 +0200
Message-ID: <8f048789-98dc-8e76-dec6-0bb4c77d0de9@gmx.de>
Date: Tue, 19 Sep 2023 21:19:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/8] Hppa btlb patches
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <20230916193235.169988-1-deller@kernel.org>
 <CAJSP0QVykDpDoH8UVWR+ONv04AFcc91Tx5S5z9VCRXaoRW2paw@mail.gmail.com>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <CAJSP0QVykDpDoH8UVWR+ONv04AFcc91Tx5S5z9VCRXaoRW2paw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UhRN+7ctW0hmVHos3Jh1Zf8TJgmA6VbFaqm4FFs6y5X7Udu1H/q
 9KlDj7k9q1O0iOEiTYSl12uEAt2aGAIqQPu3E6bovHeEI2dAa7lzPduNgfHpFJATRO8LR2X
 Oecii//pIwJ1z024qhlGzG2IYcFVZQ5TGQa+18/RXoFj1Ntlnl/Tcds0ej8+gbpTcoDMk/0
 hLQeaG5ehQSmKqP8OHLeQ==
UI-OutboundReport: notjunk:1;M01:P0:QJl8ogUeyBo=;DPbhMuf61MypkvxAeku9K6iuAV9
 N9Yy8qfwYuuGYPlw+DILxsIkQZeg141Ryg1OhZojRp3la0zoS5qnllq29/U2aqjrMb2OwZPmO
 tGGJaoSJiehCaIBY+ul21LJs4vliV5GagnqTXL5jj24BaCg/o0pa8OB7p5njrELrEXureKSl+
 setF7pVO3+cELSExhfng/tYPiEVy1gXkMDRo/PLwxMKF3K55Zo8XL9gxkTRflWi9eSG+jkIiY
 K5YxXwR7RqtgHhlfDw0m7eECowEcBoY5zjEPyZLkAe8PDFU8la54XXsXptVCHwn2KCNOMntID
 Q2I9LyIvMdF4tzkaEmgcdcCjwpab3BLc9KeL/ZERkQyZfnSk3gS2Tpibnsh/GDlzEba3Ii5bd
 RX/R8CfqAQ0fv0gGfx+51ZXe516xmYUfwRKQKqv4R3DXG3V2yFddE02BdNSieQbWOm1EbqBS0
 yoxa+GhqEyTKf5PYNjnw00jyC0aYaizG18m2cA++M7GZ8SJ1duXFAE2rmT3V3c+JhuClRTaOS
 fGme3rh4xq5rsPMTZc0aMZJILEvAuFsyT9zKR7Bh/+w1xGhLDH86imXEO9+YzWr/7ucHovutK
 XAE1oaDq3YqVRPkqazs5yGuUvK3ry7TQOXT8iTwmGDSk7Zjm/dGX79kxKbRrkKyBCjiINBrCP
 J4wSUhzkeylXKXC2Q6q2QGDUdbrKWZzDcJLAHhDgjSdl+3UmOITqNrtQcZYk411qh0+czBr+2
 vL49/p70Sj/ezJb0G82zKYnmlH0i3dIoyAxOCOJLDASUaTpL/eyRvDTJTdtP2rqI+qyxRxOef
 VpKZWhTyDOr1IemSMZ/VmFUuEEDiCGAKS3hAnx6L3QJIDlt1iYAKq/A4XWsh+VWzlXetnHMSe
 aZacoHxgyHbOp57/VEOZwDXYEsjGsHQ5/9Dqs9ztspRWiVX1j2500VPYFd0WFqVDVFzlDUBM2
 nnXIHDkRhEttgHpkHdD/I+4H/TE=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Stefan,

On 9/19/23 19:18, Stefan Hajnoczi wrote:
> Please take a look at the following CI failure and resend when you
> have fixed the error:
> ...
> In file included from ../target/hppa/mem_helper.c:21:
> ../target/hppa/mem_helper.c: In function =E2=80=98helper_diag_btlb=E2=80=
=99:
> ../target/hppa/mem_helper.c:461:36: error: format =E2=80=98%lx=E2=80=99 =
expects
> argument of type =E2=80=98long unsigned int=E2=80=99, but argument 4 has=
 type
> =E2=80=98uint64_t=E2=80=99 {aka =E2=80=98long long unsigned int=E2=80=99=
} [-Werror=3Dformat=3D]

I just send out a v2 pull request with this fixed.

Thanks!
Helge


