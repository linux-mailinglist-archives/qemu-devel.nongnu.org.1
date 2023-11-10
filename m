Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE047E83CC
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 21:33:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1YAW-0004qX-Cp; Fri, 10 Nov 2023 15:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1r1YAS-0004oe-OR
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 15:31:52 -0500
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1r1YAQ-0001Ut-Cr
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 15:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699648293; x=1700253093; i=deller@gmx.de;
 bh=3HAzdK642guqta26LAR+q3avMteCXbP1MR8UjHZqHYI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=gtFG8o/Dt0k+pjZQlrN7fHGN7NOTbo9zppx3TAddWe8JP3JcsQEMqTrr5Qopn3qq
 CzYDLwcs7Pg8scPyrG5Rh2t0sUWwo/JLm7GQajwtJ5O7d2qAnagKuQpBTSeNBqEoJ
 LP/khD0PEtm4SukUwBrV7XXX87yNvMOdPI7uw91tP7/SAeP7LWGCrDP+qNsi8g6J0
 wxq32FzhndmTEo6DsNQ4xycMkQ+fFYODITcBfI/mKCiGelslc0d3G1vKgpLkMc/yk
 JkShD85dVDnp1BRQxNtWDN0YhXWWGtAau41iQq0r+WosIhg6zbuuuOSlsGwNuqAcF
 qArzg7SXpLdjPfqfrA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.152.22]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0X8o-1rMMs52SQe-00wTrR; Fri, 10
 Nov 2023 21:31:33 +0100
Message-ID: <a20f9852-56f3-4022-976a-0b945b2c9d4f@gmx.de>
Date: Fri, 10 Nov 2023 21:31:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: prctl call wrongly succeeds on HPPA?
Content-Language: en-US
To: Sam James <sam@gentoo.org>, qemu-devel@nongnu.org
Cc: "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 joey.gouly@arm.com
References: <87lebjz9z6.fsf@gentoo.org> <875y2jro9a.fsf@gentoo.org>
 <0fec2446-a523-486f-9df7-4c6af9e2e0e3@gmx.de> <87zfzl8ix3.fsf@gentoo.org>
 <ZU6RzDKaDXHAwosp@p100>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <ZU6RzDKaDXHAwosp@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eWglsSI2rQH5J+b6YKaj5u5Nr0F2g4VLcqxj3WcRxfbUlTyJpf1
 vA2vN0aVV4BU1dYP1/fR8+ptqglGU5qRjrqWHX1Xc9Ee2j+SEnz7/vhLQ47g2zRyKRv3kkO
 4X1j7X+HlUAHrEdT2R5f7bflRDwHSsXBg4btwsWJ9nZNJaKVNvKI/tAXBELgt7kGg3y0LcO
 L1N5pJ8B1yMbvx79rdmIQ==
UI-OutboundReport: notjunk:1;M01:P0:xuq9vG7PQ20=;Ale9Jr6m4ixymKrDRmTgZJ27aV4
 25U+879aVbmWptxwrQ44bh9wmUNvOzONjRIlCnxTAP6UGN+VYLKW5q9aCFnIvrN9ELA24JSm5
 aUjHgyZ2x2wSE3CFnMnVm9moUIE0jZey5PRXn9XoVH77mdzXd0bE3v/hFupnIaWOQ5TpQST9W
 cd7PcD660A8zbmOHYsTuLzKZ1VHiKN+Cb5tMz93+cjpzZwD5BIj+p6RyenNRbC4W+nbePuV5O
 nRSplyTd8g6ywGSX125kiSVmy+dF305+mOq91DWHNFVNvn2uAEIoqSZXNyqExS7VEVcW4Vmnb
 JLfcCt0rchdhwTq3lmlS//l2PlB1Ik8xgZFZWXqK1tNNEkJfKrmK1mYvuEUqFnhi7hYDiNk9Z
 iL2qBMMY3nULNO/1H+WCQJJ4liZNNhqf0eZ2FOugwqmBuWGmL22LXhweNP5TpBfhSQLoOp07h
 xEVsGIgJMXSmn8f82NNN+K0lMtsUoTBl/XhuIiId/tVoc4KCLLA+gZIBzwrb0s++pe5znmAZl
 IFHkdn/M4EuJrEPnsWFRqAjeDbEpaQYAnR9z1bFIajdP8AtAoeM2pjARVDudu6KEvqDMlS9vA
 3m8GMKztADCcD2GqEdsx01C6eggaGx01v460jL85hLRUEjH65OFuS/mXcXGkjkVFfhofytMfQ
 QI/EOBpvWHYtSBeUO19FtfS+Kw9T2ElJeNj/VQx9PWkc5b1mNl4pqAghMGUtz1MDx5xz7tBqC
 ZdOYLV+Xnwgfno74ZC+wlHqbMcgXoi+CZGuDODe22YkqgQYeMmiaAQ7/ag7QNvXtca7yUtN9L
 lsn/pQkhHG955/UhVtEjrl8tHR3ndIJZzoFjE9xuVLEiheLMhhH05wChi5wms7XTL3jqosyJ0
 5qqOvyJEQSnOCeaOX65FcWwZo3vb36rmOwNzol8hQTZZolNmbYipNhCuv9nfoWVNgw/sc+zZi
 CZdnv5ci20WHBZ9U7sY3OILzRdw=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/10/23 21:25, Helge Deller wrote:
> * Sam James <sam@gentoo.org>:
>>
>> Helge Deller <deller@gmx.de> writes:
>>
>>> On 11/3/23 13:53, Sam James wrote:
>>>> Sam James <sam@gentoo.org> writes:
>>>>> I recently hit an issue with systemd-254 which tries to use the new
>>>>> prctl(PR_SET_MDWE) for systemd's MemoryDenyWriteExecute functionalit=
y.
>>>
>>> Is this still a problem?
>>
>> Yes. When I get time, I will play with Dave's changes to allow using
>> non-exeuctable stacks, but for now, it is broken until I can test these
>> (thanks dave for working on that, and helge for the kernel side).
>>
>>>
>>>>> On HPPA, we still need executable stacks, so this option doesn't wor=
k
>>>>> and leads to a segfault on boot.
>>>
>>> For kernel we don't need it any longer.
>>> But there might be dependencies on glibc version and/or combination.
>>> So, I've currently lost overview if we still need executable stacks...
>>>
>>
>> I don't remember which kernel version either.. I think it was last year
>> that you finished off all the DSO bits.
>
> Kernel 5.18+ should be OK:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3Ddf24e1783e6e0eb3dc0e3ba5a8df3bb0cc537408
>
>> I had to configure binutils with --enable-default-execstack=3Dno for it=
 to
>> work in addition to Dave's GCC patches. But I did not test systemd yet.=
..
>>
>> (sorry, I know this is equally vague.)
>>
>>>>> Should this call be succeeeding on HPPA, or should we reject it for
>>>>> now until we have things wired up?
>>>>>
>>>>> Reported to systemd at https://github.com/systemd/systemd/issues/297=
75.
>>>>
>>>> Lennart has made clear (and I don't think I disagree) that he conside=
rs
>>>> this squarely a kernel bug.
>>>
>>> I've read the various bug reports and looked at the kernel commits reg=
arding, e.g.
>>>
>>> commit b507808ebce23561d4ff8c2aa1fb949fe402bc61
>>> Author: Joey Gouly <joey.gouly@arm.com>
>>> Date:   Thu Jan 19 16:03:43 2023 +0000
>>>
>>>      mm: implement memory-deny-write-execute as a prctl
>>>
>>> but what is prctl(PR_SET_MDWE, PR_MDWE*, 0, 0)... expected to return o=
n parisc?
>>> EINVAL? ENOTSUP?
>>
>> Maybe we can ask Joey or the ARM people what they expect the semantics
>> to be.
>
> Looking at https://fossies.org/linux/systemd/src/core/execute.c
>   1636
>   1637         /* use prctl() if kernel supports it (6.3) */
>   1638         r =3D prctl(PR_SET_MDWE, PR_MDWE_REFUSE_EXEC_GAIN, 0, 0, =
0);
>   1639         if (r =3D=3D 0) {
>   1640                 log_unit_debug(u, "Enabled MemoryDenyWriteExecute=
=3D with PR_SET_MDWE");
>   1641                 return 0;
>   1642         }
>   1643         if (r < 0 && errno !=3D EINVAL)
>   1644                 return log_unit_debug_errno(u, errno, "Failed to =
enable MemoryDenyWriteExecute=3D with PR_SET_MDWE: %m");
>   1645         /* else use seccomp */
>   1646         log_unit_debug(u, "Kernel doesn't support PR_SET_MDWE: fa=
lling back to seccomp");
>   1647
>   1648         if (skip_seccomp_unavailable(u, "MemoryDenyWriteExecute=
=3D"))
>   1649                 return 0;
>   1650
>   1651         return seccomp_memory_deny_write_execute();
>   1652 }
>
> it seems this patch/hack might at least not report success:
>
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 420d9cb9cc8e..fe4f2162457c 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2384,6 +2384,10 @@ static inline int prctl_set_mdwe(unsigned long bi=
ts, unsigned long arg3,
>   {
>   	unsigned long current_bits;
>
> +	/* parisc still needs a writeable stack for older glibc versions */
> +	if (IS_ENABLED(CONFIG_PARISC))
> +		return -EINVAL;
> +
>   	if (arg3 || arg4 || arg5)
>   		return -EINVAL;
>
>
> A test would be good though, esp. since I don't know what the seccomp()
> functions are doing then.

actually, I think we should return any error code other than EINVAL.
See line 1643 above, if we return e.g. -EACCES, systemd should give up.

Helge

