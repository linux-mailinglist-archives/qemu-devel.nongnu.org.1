Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE7F758489
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 20:20:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLpHZ-0001F2-Tv; Tue, 18 Jul 2023 14:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qLpHX-0001Et-T6
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 14:18:43 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qLpHV-0003u9-RX
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 14:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689704318; x=1690309118; i=deller@gmx.de;
 bh=9uedWb2iSIuR2nwl+OakX+r5C/B83DCBtKkYrnV+s2E=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=elezS9dnaFvtfxyvEIkRzJHhFJUOIWUYn8zOFYx5/drUM3a7L+EnECOw39gWK0tfLLE+KOL
 jwiHFOusYT9kLV2gbX4YAOOZXjUCE+00pcHfQH4jdIedcAxkiCzyMmoJz+vXzkgypiT2MtXZT
 hpGh3VVHCCmHRe0a9UdHTfgo5wG6PzfGBIMZ4YkdRt7Ln0BkY1AUi4zSQwr8m7kvVrKE3xdvc
 JlRpJDeIeZK5hSCC4/EeOjFrD7Fav0BTaxJHsxBURJtEkrFZiJOPYcCHiQp5UXNOawuk03qN8
 3rVw8HRDiEO77tax5QL6JCgxOKUFdHhMTHxxSjKKxm12pkKkHpyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.159.74]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtfNl-1q4qaf2mo3-00v4gB; Tue, 18
 Jul 2023 20:18:38 +0200
Message-ID: <dffa87cd-15a4-a064-5c0d-d02a8c3412b9@gmx.de>
Date: Tue, 18 Jul 2023 20:18:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/6] linux-user: Fix signed math overflow in brk() syscall
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20230717213545.142598-1-deller@gmx.de>
 <20230717213545.142598-5-deller@gmx.de>
 <238b4fcf-b7ff-f89f-187e-7c52dd6b782f@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <238b4fcf-b7ff-f89f-187e-7c52dd6b782f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kSrlMX/ulpPgPK9yDXxUenZeRbd2p1E5hxEXnDuPaOmZewgmmqD
 dCA5Oefb8rHj7uZEuwd5+ArO3y5avsm5v9JpzHvIWS8Cl3jBLmlv5wpknMp8/Zrqt/q473S
 /l/99DeAuK42EnpHgUC8PhgiHtUV//Hb9gBcI5sE0Zk0Ww8WB6omTWEOTfeF+NKnQmQN08L
 d6M5EQ9qQjItEko5ioE4Q==
UI-OutboundReport: notjunk:1;M01:P0:UW81a4A1avY=;FEvVHHjBl1x26ySiV9HI//4qe+7
 +GF+cH20wuXzk7AjXqcgYj7HVFanpVEvrJJZbhClV9XTsAU4+2AtoKJEfnC9SFbW+N0XBU6oz
 PyW5lrxHS5XpsR8bU6gisCiHfTmXzCD71hISGqv7ujQO52RnRfujZ5Gj1X1sQx9s3y505sW0P
 9eiLw83NvzzwEQ/xk3q3W+PQ1gAkKGAUXsAlteK0AQU+lNrsg+hYBzgFI4FjZXMQeMQ+TFofm
 Ant6vUO7ljnKaH2/NE2gCs77byRyhWbnUW65KNqSOI1BU2L2uC5F0qfvcmL0KOXo4Y88ElKDe
 nMUBkBGCSR6jdHw2bAKUu8+HcIUBQgBotzYLHpkHgtRKQzlI8o998G8BnsZbGiCL0obKGhKuv
 HPFuGsYRT9Lc6mFnaB0hWEAjxIzSzalskAGfZxFqDRRGjZ4FU06VoGHiGbfwzRq5lyvOelUT0
 X2S1Lj+S7fimhHYjfI4rYuIgIGeN+weWr7mYPXcjaKiIOrpl+6d9WLN5i/UH4ulWaDI+7kMZD
 QBEPVgovy3l9H2liiFixklJ87ZtCc6Aee2gh2j5sK25ksRI4IC3yyq9RPf9ssW6BDm+bv8HOp
 lC842hqgCMew6DYlNiQb+1QJPywEcg3ZdOn2uddoGILoqoShgnDy94RsiVX/WHL2PPiXzqykE
 OX2XeCnCG/7cYppcocXlgJKI7yWYWnPTDCGc0/b77iAMa1//EzWY2qcWmWvdSls2grkQmcIX+
 OQf83G2t+lwppmpc9AU1FHpr0t10XyUiPpAPG8Df6Caa5R6SZFH34mCnwpj5LxVNe+qJnKPns
 83Brlss31L9ihU3As5TajCzoiWM+t+WYHW1+aWUjDViY1Lb7LvNqM5uwLLizhqEC49aU/mVe8
 xzmOYPIDyUx016T7TcfuVZdLHPj0PyTkHRgCWdnFjyQCNTakie9PtGJL7EpkqAgYwkVQ8Npt2
 04mClMaYpTVYa1AAZDf7ButaScc=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 7/18/23 00:02, Philippe Mathieu-Daud=C3=A9 wrote:
> On 17/7/23 23:35, Helge Deller wrote:
>> Fix the math overflow when calculating the new_malloc_size.
>>
>> new_host_brk_page and brk_page are unsigned integers. If userspace
>> reduces the heap, new_host_brk_page is lower than brk_page which result=
s
>> in a huge positive number (but should actually be negative).
>>
>> Fix it by adding a proper check and as such make the code more readable=
.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Tested-by: Markus F.X.J. Oberhumer <notifications@github.com>
>
> Tested-by: Markus F.X.J. Oberhumer <markus@oberhumer.com>

Ok.


>> Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
>
> Hmm isn't it:
>
> Fixes: ef4330c23b ("linux-user: Handle brk() attempts with very large si=
zes")

It's really 86f04735ac because this one introduced freeing of memory which
can lead to new_host_brk_page becoming smaller than  brk_page.

>> Buglink: https://github.com/upx/upx/issues/683
>
> Also:
>
> Cc: qemu-stable@nongnu.org

Yep.

>
>> ---
>> =C2=A0 linux-user/syscall.c | 5 +++--
>> =C2=A0 1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 92d146f8fb..aa906bedcc 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -860,12 +860,13 @@ abi_long do_brk(abi_ulong brk_val)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * itself); instead we treat "mappe=
d but at wrong address" as
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * a failure and unmap again.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 new_alloc_size =3D new_host_brk_page - brk_page;
>> -=C2=A0=C2=A0=C2=A0 if (new_alloc_size) {
>> +=C2=A0=C2=A0=C2=A0 if (new_host_brk_page > brk_page) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_alloc_size =3D new_host=
_brk_page - brk_page;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mapped_addr =3D =
get_errno(target_mmap(brk_page, new_alloc_size,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PROT_READ|PROT_WRITE,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAP_ANON|MAP_PRIVATE, 0, 0));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_alloc_size =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mapped_addr =3D =
brk_page;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> --
>> 2.41.0
>
> Alternatively:
>
> -- >8 --
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 1464151826..aafb13f3b4 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -814,7 +814,7 @@ void target_set_brk(abi_ulong new_brk)
>  =C2=A0abi_long do_brk(abi_ulong brk_val)
>  =C2=A0{
>  =C2=A0=C2=A0=C2=A0=C2=A0 abi_long mapped_addr;
> -=C2=A0=C2=A0=C2=A0 abi_ulong new_alloc_size;
> +=C2=A0=C2=A0=C2=A0 abi_long new_alloc_size;
>  =C2=A0=C2=A0=C2=A0=C2=A0 abi_ulong new_brk, new_host_brk_page;
>
>  =C2=A0=C2=A0=C2=A0=C2=A0 /* brk pointers are always untagged */
> @@ -857,8 +857,8 @@ abi_long do_brk(abi_ulong brk_val)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * a failure and unmap again.
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>  =C2=A0=C2=A0=C2=A0=C2=A0 new_alloc_size =3D new_host_brk_page - brk_pag=
e;
> -=C2=A0=C2=A0=C2=A0 if (new_alloc_size) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mapped_addr =3D get_errno(ta=
rget_mmap(brk_page, new_alloc_size,
> +=C2=A0=C2=A0=C2=A0 if (new_alloc_size > 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mapped_addr =3D get_errno(ta=
rget_mmap(brk_page, (abi_ulong)new_alloc_size,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 PROT_READ|PROT_WRITE,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAP_ANON|MAP_PRIVATE, 0, 0));
>  =C2=A0=C2=A0=C2=A0=C2=A0 } else {

possible, but I like my patch more.

> Anyhow,
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Thanks!

Helge


