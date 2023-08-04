Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B9A76FDD0
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 11:51:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRrSV-0002UC-Bm; Fri, 04 Aug 2023 05:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRrST-0002U3-7N
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 05:50:57 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRrSQ-0005At-9Z
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 05:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691142651; x=1691747451; i=deller@gmx.de;
 bh=zyxtWBDsTW1k0FP8wVoiCxE4Txwc8ry3zLmHc4NZiaE=;
 h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
 b=iWzmxOIgWI9avSBFexxr619jT/HGo1urbOU2pkeLUUrb817ZGrIP0M4E1Jk9gXnkd8ztQ4D
 so0zdvZV/yDeYAh0qvW1YfOxwdrm9w2b7Kh1ApdQZBjEtYpI0BXLrFlPZgaakOnkSLRV4JaU8
 /N5Vl87nl0xZxAFQtQMF+yJ5Lu6nnPWNUJy+LDHD03TY5QzknDE9IhexsjRwqvWI36HJf28l9
 fgcSq7ilY81ikef3jz20TwuiZQXXZku2Bty4I2ZkjoL806yrAisC3Edh8GlUFiJR5hEa53/Qb
 j/Q88y8iIxvIsjh/Eg0uQYd9Hl+G/lzo3xJaV7HzqPfXz0iaBh5g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.152.187]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsHru-1pZCXA4BmU-00toGo; Fri, 04
 Aug 2023 11:50:51 +0200
Message-ID: <9a5d6672-72ed-e5bf-2585-6b718e5ab632@gmx.de>
Date: Fri, 4 Aug 2023 11:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: joel@jms.id.au, akihiko.odaki@daynix.com, laurent@vivier.eu
References: <20230804014517.6361-1-richard.henderson@linaro.org>
 <20230804014517.6361-11-richard.henderson@linaro.org>
From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v8 10/17] linux-user: Define ELF_ET_DYN_BASE in
 $guest/target_mman.h
In-Reply-To: <20230804014517.6361-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a3vM+WB6k+D2HDEMd6UAI3jsmbbmcgI2vO4cKV+95pYqq+dObaV
 5w92Kfb1Wyb7dAKE0t4x+wrHdWF2baFLRVjrazuxH1qGrzEy0jcc88pIL7mgTDwnvFgu7Iq
 tWJ1Dv3DoPofzu6r4jsF+BM/CHwyhpTmErc8Um8LyxHI8aCOE5pBDCDUfgbLl6U7E1NS+Pd
 ScKat680Mx0deD96vWwZA==
UI-OutboundReport: notjunk:1;M01:P0:RGrpPhdK7CU=;50StRa++CAJWbGSzo+RrPeLbS3m
 ifWHWW4jjFextOxIrMcNKxyTPYwewAIH/Qb5HLp3tm5Ga4xHF6nCT4b23xQ4Nl2ACntZ/jebu
 XKwyP94vWmDqEgdvROu8foVGk0w2ftBBESjxfE/upFNisZEEdFlFQWqBZp1jWknDlWGQ4KpU/
 Cy0v0c9o0ApRT2KmmUTMKIaMUwU19m1M8E1O8rBLe78utZnW7dAWOI4GUGq2AuDyDWmF6TdGz
 FV/lTTRpJc/TnlLFsVdGWPlX8Z/Q+mx+RkK4L1GWfxt8jGWM1BlvC46DlbmvMKlliGbkn+a+R
 eKrPHP0LV0HltTYLZBYafl7SnEGKJ2FNbDIc/XyG6CCM7Q90sbKmIfWmhiz0rdj1kpJpmW1JS
 fIrHYkol56q9KwWDCcZmW5Byjmi2DSI91QJ6/QMGzkk9XrN/KqUz7y386MRWAsLup1Qu7Yzpy
 OkduZfjE/bcvL4DpHIkFyvTTcee1rdgw8c/OP/hAOjM2HlgKXSj6mQRskAGSbmJe151PKmnJ9
 5Gt8Su6yK27m1GNjmvAzaLSBIyXWSkFkRJYnsp8Bnzq7BbSobF4sO7zyZ4zCzsC67mrBtov0U
 DTcV/+i4f8G9qWh03qnDzh+VUtuItL5UzQC9ftpIm18DdCvk1cNXYhW/h7SMMwmXwH+xSJ2et
 YzIaUEL4wybdYTLUJq2IpyBID6NKdVWyJh5/uENdvyGFePu/ew2/Z+jSEF9PzI5MBBq3bdHpE
 KLg2sDybV3DO3GYI8uU38ipvnYrgt4XU2dGulxRm9yf1H7AMiVeUzPqjC9tsLHVIzr0wsnvPT
 eomXw3Xl1FS6bgSfb6UDafxwYwhPXCPohOULwYIsfITKPQY1pYLip0eiZnxjYgJCHQ+4mKtSW
 Me8bd7K0BPt5Dtw6W6d8vRoN1eVnS19pH9Ywgh3tLoHTvThcE+MY4I6MKr4lL+GTMM8aEcSTO
 rUaDD65KKNtRz9DlJReMBTVSbYo=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 8/4/23 03:45, Richard Henderson wrote:
> Copy each guest kernel's default value, then bound it
> against reserved_va or the host address space.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/aarch64/target_mman.h     |  3 +++
>   linux-user/alpha/target_mman.h       |  3 +++
> ...

I've successfully tested the whole series on the following
chroots (on x86 host):
alpha, arm64, armhf, hppa, m68k, mips64el, mipsel
powerpc, ppc64, ppc64el, s390x, sh4, sparc64.
Both static and dynamically linked programs work as expected.

It's a big step forward compared to qemu v8.0, so feel free
to add to the whole series:
Tested-by: Helge Deller <deller@gmx.de>

For this patch:
Reviewed-by: Helge Deller <deller@gmx.de>

One thing to mention here is, that those values (ELF_ET_DYN_BASE)
reflects the legacy (standard) memory layout of the kernel only.
The process personality defines which layout should be used,
ADDR_COMPAT_LAYOUT means to use the legacy (standard) memory layout.

The Linux kernel on 390, parisc, sparc and x86 doesn't use by
default the legacy memory model, but instead allocates new mappings
from top downwards. This leaves much more space for heap.
Search for mmap_is_legacy() in the kernel sources.

That said, we should implement the top-downwards allocation
after qemu 8.1.
In this regard, could you please include my latest patch titled:

    linux-user: Show heap address in /proc/pid/maps

in your patch series? I sent an updated version today to the mailing
list, which applies to your series. .

If applied, the "[heap]" entry is visible in /proc/cpuinfo output, and
it's much easier to see potential future memory isses, e.g.

armhf-chroot:
-> heap is limited in region 21000 to 00400000.
-> 00421000 to 40000000 would give much more space for heap.
-> arm32 doesn't seem to support non-legacy memory model yet...
Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 20:51:1=
2 UTC 2023 armv7l GNU/Linux
00021000-00042000 rw-p 00000000 00:00 0                                  [=
heap]
00400000-00406000 r-xp 00000000 fd:00 675877                             /=
usr/bin/cat
00406000-0041f000 ---p 00000000 00:00 0
0041f000-00420000 r--p 0000f000 fd:00 675877                             /=
usr/bin/cat
00420000-00421000 rw-p 00010000 fd:00 675877                             /=
usr/bin/cat
40000000-40001000 ---p 00000000 00:00 0
40001000-40801000 rw-p 00000000 00:00 0                                  [=
stack]
40801000-4081d000 r-xp 00000000 fd:00 682674                             /=
usr/lib/arm-linux-gnueabihf/ld-linux-armhf.so.3
4081d000-4081e000 r--p 0001c000 fd:00 682674                             /=
usr/lib/arm-linux-gnueabihf/ld-linux-armhf.so.3
4081e000-4081f000 rw-p 0001d000 fd:00 682674                             /=
usr/lib/arm-linux-gnueabihf/ld-linux-armhf.so.3
4081f000-40820000 r-xp 00000000 00:00 0
40820000-40822000 rw-p 00000000 00:00 0
40822000-4092b000 r-xp 00000000 fd:00 682677                             /=
usr/lib/arm-linux-gnueabihf/libc.so.6
4092b000-4092d000 r--p 00108000 fd:00 682677                             /=
usr/lib/arm-linux-gnueabihf/libc.so.6
4092d000-4092e000 rw-p 0010a000 fd:00 682677                             /=
usr/lib/arm-linux-gnueabihf/libc.so.6
4092e000-40938000 rw-p 00000000 00:00 0
ffff0000-ffff1000 r-xp 00000000 00:00 0

mipsel-chroot
-> heap is locked in from 00021000 to 2aaab000
Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 20:51:1=
2 UTC 2023 mips GNU/Linux
00021000-00042000 rw-p 00000000 00:00 0                                  [=
heap]
2aaab000-2aaac000 ---p 00000000 00:00 0
2aaac000-2b2ac000 rwxp 00000000 00:00 0                                  [=
stack]
2b2ac000-2b2d8000 r-xp 00000000 fd:00 816208                             /=
usr/lib/mipsel-linux-gnu/ld.so.1
2b2d8000-2b2eb000 ---p 00000000 00:00 0
2b2eb000-2b2ec000 r--p 0002f000 fd:00 816208                             /=
usr/lib/mipsel-linux-gnu/ld.so.1
2b2ec000-2b2ed000 rw-p 00030000 fd:00 816208                             /=
usr/lib/mipsel-linux-gnu/ld.so.1
2b2ed000-2b2ee000 r-xp 00000000 00:00 0
2b2ee000-2b2f0000 rw-p 00000000 00:00 0
2b2f0000-2b4ae000 r-xp 00000000 fd:00 816216                             /=
usr/lib/mipsel-linux-gnu/libc.so.6
2b4ae000-2b4bd000 ---p 001be000 fd:00 816216                             /=
usr/lib/mipsel-linux-gnu/libc.so.6
2b4bd000-2b4c0000 r--p 001bd000 fd:00 816216                             /=
usr/lib/mipsel-linux-gnu/libc.so.6
2b4c0000-2b4c3000 rw-p 001c0000 fd:00 816216                             /=
usr/lib/mipsel-linux-gnu/libc.so.6
2b4c3000-2b4cd000 rw-p 00000000 00:00 0
55550000-55559000 r-xp 00000000 fd:00 818831                             /=
usr/bin/cat
55559000-5556f000 ---p 00000000 00:00 0
5556f000-55570000 r--p 0000f000 fd:00 818831                             /=
usr/bin/cat
55570000-55571000 rw-p 00010000 fd:00 818831                             /=
usr/bin/cat


hppa-chroot
-> heap & stack is ok.
-> heap could greatly benefit if qemu later supports top-down mmap allocat=
ion,
    because then the shared libs will be mapped >fa000000 and heap&stack c=
an grow
    from 0001a000 up to fa000000.
Linux p100 6.4.6-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Jul 24 20:51:1=
2 UTC 2023 parisc GNU/Linux
00000000-00001000 --xp 00000000 00:00 0
00010000-00019000 r-xp 00000000 fd:00 1061893                            /=
usr/bin/cat
00019000-0001a000 rwxp 00009000 fd:00 1061893                            /=
usr/bin/cat
0001a000-0003b000 rw-p 00000000 00:00 0                                  [=
heap]
40000000-45000000 rwxp 00000000 00:00 0                                  [=
stack]
45000000-4502f000 r-xp 00000000 fd:00 1069300                            /=
usr/lib/hppa-linux-gnu/ld.so.1
4502f000-45030000 r--p 0002f000 fd:00 1069300                            /=
usr/lib/hppa-linux-gnu/ld.so.1
45030000-45034000 rwxp 00030000 fd:00 1069300                            /=
usr/lib/hppa-linux-gnu/ld.so.1
45034000-45035000 r-xp 00000000 00:00 0
45037000-45039000 rw-p 00000000 00:00 0
45039000-451f5000 r-xp 00000000 fd:00 1069303                            /=
usr/lib/hppa-linux-gnu/libc.so.6
451f5000-451f7000 r--p 001bc000 fd:00 1069303                            /=
usr/lib/hppa-linux-gnu/libc.so.6
451f7000-451fc000 rwxp 001be000 fd:00 1069303                            /=
usr/lib/hppa-linux-gnu/libc.so.6

Thanks!
Helge

