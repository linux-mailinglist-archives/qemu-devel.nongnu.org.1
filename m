Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A8B76E908
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 15:02:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRXxH-0005dr-Vu; Thu, 03 Aug 2023 09:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRXwz-0005a2-No
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 09:01:14 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRXwt-0000PW-Em
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 09:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691067656; x=1691672456; i=deller@gmx.de;
 bh=OM0D0vH0S/8w2HJ248/jgun29ld1eyyO0w5kvgvxxVA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=VRIiDx8FdgqQh8AZuHrcTEsru7hutDsA2uon9t25hQ+48JDu8uhJUrmhWruFVCfPCA3u8hI
 O91YkLKFKDmbohrHa7QDqa7Qw+C9DwGHTu3t+OssJXU+rS8kO3MNerbEVVJAA8DtA1Or/BEfq
 SdS8zvT5GP9voiuuJMVwIpi2zzeEvdlb0uYlmsMqmuAbHHaIbToV+Cxg/LYyWLtzMPPap/obo
 ZdT41ruURUDxcGnhK5EWUiLKCKwHuLhgAl5kaCLTIaj0X+8Pfj/pKRu+4oLKqYTe/b7SmP6KJ
 7RBoudvJuN55LiYzF69vxb+bHp3PqM35p37DB4Fsh/Xoa5ZcPv9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.147.53]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKbkC-1q8vAK39cC-00L1OO; Thu, 03
 Aug 2023 15:00:56 +0200
Message-ID: <e859158c-ab10-8fb3-0841-e4d50213f354@gmx.de>
Date: Thu, 3 Aug 2023 15:00:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 13/14] linux-user: Adjust initial brk when interpreter
 is close to executable
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, akihiko.odaki@daynix.com, joel@jms.id.au
References: <20230803015302.407219-1-richard.henderson@linaro.org>
 <20230803015302.407219-14-richard.henderson@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <20230803015302.407219-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SKXk574h0zy8oIJdhIJuXjx05CJ36WhOUiHqZZ/iH4kRVVBZtQL
 F97TqUSPrUoKMnnoEm/zI1NIdaZXoJYM8wxlj/zbc/MLVqVp27houzAlIIvY1pFEm5IG8OC
 aSlL6STiDpulVuTF4zXHifRA4FKgFz19hqsZcR8XneNfiFpO0k1CztL1xYJA4rDVEk35E84
 og1SQhjC7FGFmmbHtGThg==
UI-OutboundReport: notjunk:1;M01:P0:Y37tyJ/AhgM=;GrtlAJgij1p4YTTXwZwOQFu6vGq
 sh6v9FwZ1n9Rd82mtc5C3yPVCJBP5VziJ76eLniZ6vAs7UBnkr1bHBGQxhFGGJDM7YHx9rZtO
 gZEHAiec9aCWJnZiwzqXDx4rQ30awlnHwkPjRjaKzvDz62EICupaZXh+kPGHbuRYNcPfefwSx
 dwD+b6OLyF+G+V9Vmkra4k+wK9bJDM7kXU603ufAu6u3yqtXxJle7X3f520RRCkZbyIXClXmt
 CHeoNVYb7oeBmMHXWTn78Y9qXyEDmKmXxv1o4lib4JYxTWsP3kI5KcDrx1I9TdOXedENFqdM2
 +M3p/1281TWqXZhykftkIkPuBkvwPgy/Fynmt9gFGWta1xrAYFJfWD8mWJJA7WByLJOhIZTOg
 fwNQ5aFGLQwbVyuV+CFqb1APRBHmbLx4+OXmtI5i9sD+/phiHw7lI7JExUIlvoIXF8Y5Exnk9
 +XicVV61QucLYLNrGGK1ohfLxIi+GEyn++VmdzvPfZrG/w5njIDWe2C8hlzSpjq6HmtaJ0OnX
 CfWkcQSzd+yqbCa2Ax6O6uF0u3mrzmPcmgRYZmUpS6EhMm5tYVh05h1p7dEVp6xRuRqDIuJcO
 8v03MM4lJjyoha7WexomcfW8KrGJJMpjw/r6X50JBPkno0nrZsxI3Nc1fdPJPRzBfh1ptjRBk
 DsBjzRmXtixQyEUd/w1xHtMvFKf68xklNKNHeyWvDQiLsSD37X6ygD0x5hp4SNMYz56f94oE/
 4OGxkynBu+oEXsyIiquh7A2BMiExjH0Dla8bLMarwaatfPrFbXJfhTAjv57MYagseqnXY1WXG
 /ulK4kClU+flmO3qcCP4Te4Tww1uZIwRfVRUJG/c1X+oMWJKxL6UXbT0pbVZkQnSgE1EMTGEh
 KNjs2ZbShDzmEJfyqqCywQx7f3IBblrIHGFUMR3k06iMtF+8FJ+x163+IMpAHZflShQlvJotp
 5t2h5GI7KWpJ5U/bjHaUFzRvyYU=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Hi Richard,

Thanks for putting this all together!
I'll test asap.

I haven't checked yet, but Akihiko did send a revised v2 patch
series, while my v6 series included his older v1 patches.
We should consider his latest series...

One other thing below....

On 8/3/23 03:53, Richard Henderson wrote:
> From: Helge Deller <deller@gmx.de>
>
> While we attempt to load a ET_DYN executable far away from
> TASK_UNMAPPED_BASE, we are not completely in control of the
> address space layout.  If the interpreter lands close to
> the executable, leaving insufficient heap space, move brk.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> [rth: Re-order after ELF_ET_DYN_BASE patch so that we do not
>   "temporarily break" tsan, and also to minimize the changes required.
>   Remove image_info.reserve_brk as unused.]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/qemu.h    |  1 -
>   linux-user/elfload.c | 51 +++++++++++++-------------------------------
>   2 files changed, 15 insertions(+), 37 deletions(-)
>...
> @@ -3229,7 +3208,8 @@ static void load_elf_image(const char *image_name,=
 int image_fd,
>       info->end_code =3D 0;
>       info->start_data =3D -1;
>       info->end_data =3D 0;
> -    info->brk =3D 0;
> +    /* Usual start for brk is after all sections of the main executable=
. */
> +    info->brk =3D TARGET_PAGE_ALIGN(hiaddr);

This is from my original patch, and is probably wrong.
I think this needs to be:
     info->brk =3D HOST_PAGE_ALIGN(hiaddr);

The brk page needs to be aligned to the host page size variable (which
is always >=3D target page size).
The page will be mapped +rw (on host), so may need the distance to code/sh=
ared
libs below it, and for that distance target-alignment may not be sufficien=
t.

I think this fixes the problem which joel faced with armel static binary
on ppc64le.

Helge

