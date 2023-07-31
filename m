Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FAF769AA2
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 17:17:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQUdr-0003JX-9O; Mon, 31 Jul 2023 11:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQUdh-000372-11
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 11:16:56 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQUde-0003ML-HF
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 11:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690816607; x=1691421407; i=deller@gmx.de;
 bh=TQxBVMLqUEopry6qRbGT8mG7qZvNacjOSU5lqbStUEw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=UgSpeHsXLjkyvdTtvIZgV51yCWXT81zS46n0OsSt3nkgRNPN4qUAzduesJdwh7y9VhlHSUM
 MoROwQGBDY99yZnuYMwh+IVebgyDQ55fXuMffl1ZU1wD2OlgSqnBI2z/JTC9dfZMBwkq1Plks
 WIlNm8QoEncEwWFVosnEk8yP3cuX+24rXBKVaWKIx6zPQvDWAiqXGCQqSsHt7GkIDLIT9Hshd
 e1zZC/QmQHtsnl9BW1kjv0pO9uRBFahXAl3+HgCAm11MACGd0GNhSJ1ZnHL4+ureqvpwNNeZN
 I28X5rTUMboML6H9FXAd/0DW8OeGScshrnnWtqGi7x9IIrunZlCw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.159.238]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiacH-1ptcin3nKJ-00fkeN; Mon, 31
 Jul 2023 17:16:46 +0200
Message-ID: <c4c61576-4b16-b6a0-d20e-6dcf91168513@gmx.de>
Date: Mon, 31 Jul 2023 17:16:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/5] linux-user: Do nothing if too small brk is specified
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
References: <20230731080317.112658-1-akihiko.odaki@daynix.com>
 <20230731080317.112658-5-akihiko.odaki@daynix.com>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <20230731080317.112658-5-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qStAYeOvdqA+Iw+PvGW4A6lq7r19AGORa8mQS/SDq0mJ8/D6WY+
 qIfxDPWnl3Q6OVA54kKEZurzD/n4qoQQf5YH3fc9c2Ii7c4pmpBe9790cNfcUzEoZOUYny1
 GfQdGmRDrwFfQuA3PLVN3FYATc9CArrmvzw6QnqF/4GgayYBxwPt4pUW5s5YP8QSmKS/2SY
 U9NgzxSbiyzaGyrDd2z4w==
UI-OutboundReport: notjunk:1;M01:P0:6FFAQzG4zv4=;MioplgVH2lOV5Z2BY2+DJqjyn3J
 6AIFQFynwsoa5gMHphjaehC4/oPe6ykzk3kMUmclL5O7jcbkxOLZxkdIXHnzqut06vsCMb4Nx
 ql1JI2QdXfXoSbQuTJ4mXJtPOGZkmamJacSJAMv5dtKkQoqdNVBK+tVK6TOly4X3y6b5wF3P6
 YatQLWnspDLcdRVVEaNGGf00T99eDQHJXGvwWrR7brOjzBIL24q6R4JhI6c2Cc5R1Kalf6mXn
 SEZ0U/Si/clgllcOn3kMpO8nIeqplHZ90nlSmckfsUYYozSfXB2qWjJaKM8Cw5h/aGCufLi32
 N9+gEg13iLCbyqKxJLdt4f0fyx6LGmnE3qiq5D7jJyRVwRNjDRFSNOEI8o97p/1Ptx2bRk3Le
 knGUATE98wS+PydN3o+VE9r8mPu7tnyq1vbxycuMvkuvc2r0C2nuJC18Phxyrm8YejbZnre00
 U5lRzH9schKAmCtn0ISSkHHvqI0qjtbSpXCWz8p1ddkKgUPBkOsaWqoOClFr9S0FUuESW7HT8
 8LzAJRkE9CRsSNGM0L0uxdrBFvkuBcSjOhHTdkO9q9WSh6GaOdPX5/VUZdcpIaoRhfd12Z44T
 2KDFDWIEfiAp8fgQ4EWuelc+cd3vT3kNync89f5DOyphELusl2PZG42TOwTzLgGGMKViyoFii
 2u7WEnaxbsiom5mtrHkqyCCvyQDNIWkik7n7Pb5f2H5bw3ALYQLaVE4JERSt94bHxhJtL3nHD
 Ddss7OGS+4Y/gKQ4lns0iSx8QBArV6f5n4VqCU4TygAiujtTX78Xs5p1LTRBh9cTu+1HPcH09
 Ylu9pNtQTWySWlrHg2ROazketseKkQEiOOxLaoPty5FBMYQrvCqnyC6EkS6NPOGBgc3CJCOBu
 DpghO+zU4XRxbAVf1yFtaZcGH0BZhJdk0J63iA2TRyr7Q1KqAzs2AbuYM6z5LVxVB5pZYSqVY
 aGLfqiPYUDzRja2yntRGzgZBUDk=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/31/23 10:03, Akihiko Odaki wrote:
> Linux 6.4.7 does nothing when a value smaller than the initial brk is
> specified.
>
> Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Helge Deller <deller@gmx.de>

Helge

> ---
>   linux-user/syscall.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index ac429a185a..ebdc8c144c 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -820,14 +820,14 @@ abi_long do_brk(abi_ulong brk_val)
>
>       /* brk pointers are always untagged */
>
> -    /* return old brk value if brk_val unchanged or zero */
> -    if (!brk_val || brk_val =3D=3D target_brk) {
> +    /* return old brk value if brk_val unchanged */
> +    if (brk_val =3D=3D target_brk) {
>           return target_brk;
>       }
>
>       /* do not allow to shrink below initial brk value */
>       if (brk_val < initial_target_brk) {
> -        brk_val =3D initial_target_brk;
> +        return target_brk;
>       }
>
>       new_brk =3D TARGET_PAGE_ALIGN(brk_val);


