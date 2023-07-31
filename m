Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78969769A8E
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 17:14:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQUaI-00020h-MQ; Mon, 31 Jul 2023 11:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQUa4-0001uf-CA
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 11:13:11 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQUa1-0002aD-Gz
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 11:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690816383; x=1691421183; i=deller@gmx.de;
 bh=leQiNpiVJpAKD9D7jkMkYqnqJkUPWWi/YESHds89W4M=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=GINa/rFYUZE8sEOFkriQUtW7C15EkHbLnyHMjXkUAykclSEMKmpwZOx4PKzAD3RaJncOW0a
 Eqq3dRQkitD6cnJD6eql5KYGizgSEpfLZLnUlitpqQTulvPGEvlA4L0X314DOdoyq2GaJUJGI
 1ZrgFNaCi1ajxCdKazlext0C8LeRanpvppQM9LsxFSb9acObq2CzrbcZbvvp1t0Cip5kFPDbv
 uYiwlIgaT2wQkEiSMmXZK6wTN0Ul6GzPQ1+TxCbXZAB1vlPM1Hr/R9a0C8RKBJThIeR3hmnJl
 KgacLP75cJuOXFlt0mPZd9V7cgiPvh5Ec+CwadyFb8YQ52qwChYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.159.238]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvK4Z-1pZDIs01mT-00rDCg; Mon, 31
 Jul 2023 17:13:03 +0200
Message-ID: <0cdb50a4-5a89-20e5-88aa-e026646e6fe1@gmx.de>
Date: Mon, 31 Jul 2023 17:13:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/5] linux-user: Do not call get_errno() in do_brk()
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
References: <20230731080317.112658-1-akihiko.odaki@daynix.com>
 <20230731080317.112658-3-akihiko.odaki@daynix.com>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <20230731080317.112658-3-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iC9ea5ViPoZh9TNxX+aIn5bGMf8GmwF0Jh/Lt1OzquOp30Odzc/
 SCQ5xRXYsHRXKNMVNFigVcj66UFEMoGVddqaxtp/G6Pohog2YktLHz+AHIPTjA0hsvzyulU
 lBZcnwBw1n0QRgBGekHxfBJbMv0XrCY8364ybRM3+24t0k7bDyHiKtf75LfY1pr3cc1nj/o
 79rpu7AhMITWmWmZ5EmrQ==
UI-OutboundReport: notjunk:1;M01:P0:DEgJt7yfM9Y=;NLrA1yFx/Uov3JNwec4s0l3H78Z
 r5U8PEwR43bIjEzGQ8+UyXZqOArf9qHTHeFSg+jjfARQwn+XkNlAkVLOgK4fLSxAagoBJLAsD
 t81Bv2pp9EZUslbJbYuMTsZPz1HvjGYCaLEp3hiiKlOhq+I8PeoG2n0T6XafPxw9vV16KMFwq
 nGO7Q12X39zxBFqvnrcK43nSTqBB+Qwf04hDdlI+KK7tWSS0+5MISxGBDmVzvAQvtQff8IQhD
 o0S7CzLzA6OTZZbfP0xIQ9IdiWWQ4Mor1Xb4oqbZqgoYVhI0sh3+veulrNQm6U35Md7kZW7LQ
 YM9AkxxJMYA5ttIzoKSBk4XYAhlirwpM8ql69WVqW1tmYGeIcGDPkTQDVN/GjtKrfBHQs2t57
 bW/G/eWyUx0yr0M728nm+tYFVzilJZ1shYLtGGAndcKmN+X3BO8MrVvNboxXhnKKy+BAKT/vo
 qT9uwt0bJI1GR56zFIVnfkUCLTmr11wENOrqWoZbiPqm7asPEfIwVK+qMhNo02AS6qz8lDweG
 IE3xQvkDzjzT4MJY47WHY862haGsfFu2UqFFph373dny8GJcIXv1+36upQAFfYsUkrxiMPpYG
 uuAgvLV6LmFDCVM3UGGhg6WxnKy8p21DaNDjcdK6KWtbe2nDHYwBDcUhLkUDcw/BfDeMJAxap
 M6rDlY5zwoc5aCN0KiFg660NomvCqgzDt3xHMnEgQYHT7SNvlO1DzCElwXQ9or/4UCvMyodNt
 te3hsRCYfeJsfoVeZFwzIXp4vcUL940gDpfSppwbb0foP1UhSavCehTdUk3j/xi96B/i7ybfm
 DVnZ6NaX83+ZEkPUNbZvLsxQ4VTRvzoEYey2MBHbqDbMxWP76KDeVK4iYLKQ82RB5szD/3H+g
 Dq/vLu/igceSn/WjIL7rr85bJHvgKNzxk8xWwQ6VhkE6+TiamNFgQeWZ+vB0Pw8mmlaLZ4zdV
 hNoWJktWBAtGnfa6SKZSmD0pHgI=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
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
> Later the returned value is compared with -1, and negated errno is not
> expected.
>
> Fixes: 00faf08c95 ("linux-user: Don't use MAP_FIXED in do_brk()")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Helge Deller <deller@gmx.de>

Helge

> ---
>   linux-user/syscall.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 95727a816a..b9d2ec02f9 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -862,9 +862,9 @@ abi_long do_brk(abi_ulong brk_val)
>        */
>       if (new_host_brk_page > brk_page) {
>           new_alloc_size =3D new_host_brk_page - brk_page;
> -        mapped_addr =3D get_errno(target_mmap(brk_page, new_alloc_size,
> -                                        PROT_READ|PROT_WRITE,
> -                                        MAP_ANON|MAP_PRIVATE, 0, 0));
> +        mapped_addr =3D target_mmap(brk_page, new_alloc_size,
> +                                  PROT_READ|PROT_WRITE,
> +                                  MAP_ANON|MAP_PRIVATE, 0, 0);
>       } else {
>           new_alloc_size =3D 0;
>           mapped_addr =3D brk_page;


