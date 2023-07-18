Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD52875734C
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 07:44:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLdUI-0007pz-Aa; Tue, 18 Jul 2023 01:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qLdUD-0007pX-Fc
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 01:43:01 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qLdUA-00087x-Dt
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 01:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689658970; x=1690263770; i=deller@gmx.de;
 bh=gOSuOvinD9pCC4YOWSuiCcOepxgUwXFp2wjEq4LEVEU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=jwI0fUZ0YhzUrC5sEbzSewH4u3jLxUWJPXrmZopgmNVOG2PLTKVFnJwWmOFl00Qa0N32DYT
 5fvylxmTpG76OACoTKZACKq36k1Ot7C+y7c0Y3Gd01pihLdBMKtoiInGFUBHUmcNJ8FkffjTI
 XbIIx3FaqiNEVmd76qglPDSOrRhlUWDQHU8L+GelcPQ6J+SIk+v/3F7YMSo1AsuCw/AnxQPGQ
 wZC3MJqp990nJmLaWDAICQLb9bT5UdhssG4zP+hGc2dxY0v/GBAt1JVHQ+fYgKmSOZB3jrPyJ
 OG9Jiq1tbeI7I60QAuh6ZivMsEOBfXEQQUvNnDUjKHzc8v6JUYug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.159.74]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpDNl-1paBiX22BT-00qlZR; Tue, 18
 Jul 2023 07:42:50 +0200
Message-ID: <bde51a26-4572-67bd-d9e0-58826db9d5fb@gmx.de>
Date: Tue, 18 Jul 2023 07:42:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/6] linux-user: brk() syscall fixes and armhf static
 binary fix
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20230717213545.142598-1-deller@gmx.de>
 <703ab494-1778-c50a-d46f-988fab846da3@loongson.cn>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <703ab494-1778-c50a-d46f-988fab846da3@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:34A89nj/eyaltCifbC5SjdgCaXf25sEk50OY/oFwKFY8J5Zww+6
 XkPWAfp76bqIY0UAVRE/aaMzoa32PAM6R40S6fsiyKfayhSfqbaRDW1Hqt9m0HPcfQz0+Sq
 BpSezUCQiDF+J/ZtQ744Ea1K+aV2HzgANgWMMhE51KUOgK8IgwTfZJ3lKrD5I1cJgAT/NfQ
 2G+sNu2bygNWOB8mReI8Q==
UI-OutboundReport: notjunk:1;M01:P0:RiNYILax3Nk=;ygUeAcJWLLkudoASMhGdh47h8WD
 WIF84QSoebLxiSB8RxFJbrHhrkAqzndh4/kQN0+QXz9H/GLomuhOyoVxy29UIC4SHjvt0FHWe
 a9Et7ssyeLeVCtXZzZolmDD1ULb0LWXnupBEuzQJkJLU83tLuxEL/6ZeEEF0hadTWo7oPK7xV
 l5pwvvYF2qBr43T+A057IPvVQT5q1RuMKrRjQNRRm09HViJ9Lo3kvrZQxIpLhhBVzQ8HGvLk7
 57r55EAR3Rlg644th3CbkdJ3E2w6BtWRBo9jAjDy0ynUzBkCnyPzFgtFHMp1mvfnlizLJfmgb
 VdkF5shKLEm8BzC3yCp0eL7MufWmR9Bx3CtNOsv8Il4foEUc5rZ3DKsf5ur2MbeX7P6PNXSxk
 fX7T/l6HavMEx/TDDpLpo7o3l+KDqZGQqzZKwBnHrYObN0Ksn4CkrFCmDRun/jDWTSULLRz5v
 IqGsOAnj+i22a29kqC1n04J46vjka9evcJw/htg5/sUYLcTyZhl8HTl9gxuEoPZH9mM7xD+RH
 VYUEYM4DbEHgu4rPx78cjqiTVN86VlJvpw66GWMfxEKx5L5a5QKKpkFc9/tcRcphEO9kbzZGX
 5WGPEsKgaM2OtkxFCTe3G3gWThsjy3hUiTPBGAx55SG/0T3UsxJI+x+Q5qJgSydI8noZn3AOu
 4l9ruqE5eOScHKrFOB40E88amHZNuyYtZZ4sO2UYiwFXYgmVFww2EXbYyqRfWEH6wqq43W6b0
 NkC1PfcEIuZ5JmVnael4lwrTEOhxzkiNaxe5/AuF6W6HEGgrZDDU9x7TvfMf2MRIt8XElsbNt
 jTTMD0zzI333jvres5eiXFeDKh9XZiLBTTlnFvskuhxMDStiLN7WTiHxrV1aYHzrAUQo+mY9N
 gwmBVfdKvJ3ldWya7LWMMAegdgLYd2RH1GdBwGtvytcLJRLHNghKH4cGGbShdiD4fFv6+KpQn
 bh/baAgMgQ0w9XCj5cKcYUPp3v8=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.097, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 7/18/23 05:03, Song Gao wrote:
> Hi,=C2=A0 Helge
>
> Could you see the following bugs:
> https://gitlab.com/qemu-project/qemu/-/issues/1707
>
> This issue is also caused by=C2=A0 the commit=C2=A0 86f04735ac.

I don't have access to such a box (and on an arm64 debian porterbox
I get unmet build dependencies, e.g. for gcc-powerpc64-linux-gnu).

If you can provide me with access to a machine I can test,
otherwise you may simply check out:
   git pull https://github.com/hdeller/qemu-hppa.git linux-user-brk-fixes
and test yourself.

Helge


>
> Thanks.
> Song Gao
>
>
> =E5=9C=A8 2023/7/18 =E4=B8=8A=E5=8D=885:35, Helge Deller =E5=86=99=E9=81=
=93:
>> Commit 86f04735ac ("linux-user: Fix brk() to release pages") introduced=
 the
>> possibility for userspace applications to reduce memory footprint by ca=
lling
>> brk() with a lower address and free up memory.
>> This change introduced some failures for applications with errors like
>> - accesing bytes above the brk heap address on the same page,
>> - freeing memory below the initial brk address,
>> and introduced a behaviour which isn't done by the kernel (e.g. zeroing
>> memory above brk).
>>
>> This patch set fixes those issues and have been tested with existing
>> programs (e.g. upx).
>>
>> Additionally it includes one patch to allow running static armhf execut=
ables
>> (e.g. fstype) which was broken since qemu-8.0.
>>
>> Helge
>>
>> Helge Deller (6):
>> =C2=A0=C2=A0 Revert "linux-user: Make sure initial brk(0) is page-align=
ed"
>> =C2=A0=C2=A0 linux-user: Fix qemu brk() to not zero bytes on current pa=
ge
>> =C2=A0=C2=A0 linux-user: Prohibit brk() to to shrink below initial heap=
 address
>> =C2=A0=C2=A0 linux-user: Fix signed math overflow in brk() syscall
>> =C2=A0=C2=A0 linux-user: Fix strace output for old_mmap
>> =C2=A0=C2=A0 linux-user: Fix qemu-arm to run static armhf binaries
>>
>> =C2=A0 linux-user/elfload.c |=C2=A0 7 +++++++
>> =C2=A0 linux-user/strace.c=C2=A0 | 49 +++++++++++++++++++++++++++++++++=
+++++++----
>> =C2=A0 linux-user/syscall.c | 25 +++++++++++++---------
>> =C2=A0 3 files changed, 67 insertions(+), 14 deletions(-)
>>
>> --
>> 2.41.0
>>
>


