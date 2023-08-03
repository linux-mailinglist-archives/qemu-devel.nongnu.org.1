Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7F376EB4B
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 15:56:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRYno-0002P9-NV; Thu, 03 Aug 2023 09:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRYnd-0002Oq-AW
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 09:55:34 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRYnb-0000XR-Ht
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 09:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691070925; x=1691675725; i=deller@gmx.de;
 bh=ANqR7KUP3VDls7NvVKyuy2GjBuMlehIUcn1CCbyFHsU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=GfGu0JCycUEsptex8/vut4yw48pqKpwiJF9WeUlzawphhD4ISxr0MnEuup/cwg+bGWsGRc9
 lR/E54bTJ+Nnc/2CNgJp56KAEiVT4unFZbeou9xs961JJyLEQyZC5iAsWf/q9M2KQtWu/4NiT
 XksVZ6e6LfvOge+TWibfwl1JwrSGfoaGeTmgML4NV7DYFL8c721SdmRl8HRfaC7gzU0IX3GT7
 U+xr3Rdf6tf2IsHCssMgt/MHsY7AtXyhOd5EYwtzD4gQV4gFGQNdCLYLzT++I65ae+rj2jTNh
 06KpBxlygA/Rglhl+eAwdQ5MrbCYKmj0ljhzBgo2HDtQ/VUyCcng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.147.53]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3bSt-1pidSQ2VEJ-010b0k; Thu, 03
 Aug 2023 15:55:25 +0200
Message-ID: <cd9b0651-475d-1b11-d648-594b52d48bd1@gmx.de>
Date: Thu, 3 Aug 2023 15:55:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 00/14] linux-user: brk fixes
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, akihiko.odaki@daynix.com
References: <20230803015302.407219-1-richard.henderson@linaro.org>
 <CACPK8XfNiGiprxYd-J+E-oFqPsRVPfQa7+e5hX8DFw0OudT85A@mail.gmail.com>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <CACPK8XfNiGiprxYd-J+E-oFqPsRVPfQa7+e5hX8DFw0OudT85A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aunFPnHbopF7SWR2oSfZjkTxG4bzIy9uMqaHwZmwJ5MRwvsF5VW
 oS6nnyqNKbdltUfOsOpAxX8j+rf0CeR6JkDb87NZUaEVNv2EqLXzKIL210spFrka999EQro
 nAlYSgzrH91nZrQsLl+tcJcik/xAjNaTsBnX00Vd67ouFmM4wYnOtLgqA0DbOiJloq/KHYO
 OHLZmZ92hP2YZScUec6Rg==
UI-OutboundReport: notjunk:1;M01:P0:W/tH0KYzYw0=;xCjYfiBSbNK2H2eNDVoaNlZl83D
 aa2DcPu1S3W2Lr0DhhQDFXcogUQKt01nPO7/LgpWpUgi0hj+94UdSSyhz+X+pKJz4SRNq9JZC
 z7nDxcFH5Lf4FV9KnoVb+PrSgQkHzGQLMUogvPLfFwH5uR6XsZTvTuiaolxZT+5hIMFmQPXC3
 fIphDKjiRRP8gI12xZU//OBkUbbuhmBP4uiPZ9uE9RTTzF+O/k5/V0W/5KbZbNTArXE7Usx1X
 NBCmhPm5T+OjTCGPB+11jDIKWstD94qps4JyKHxOvtVL5PY5MHKHl6wvxNAHJW214X1z1Yq2q
 Rb+95SxqaylMnyhsL8S0hgZUpKeRf1iUWS+EC7Wqp75YZYQngubp5HiAmr5ExSJpHJHqjpYWx
 dph1wV8gLYE/cZzbc0a+W/3mhJKC0lgkf2L74HkFuKCRUi2hXLRyPlL4q5SASYaKoqtyZRMn2
 bm1dhTqxztRkR3R7bXEPh2zyPRw4rXz7Ym6/Oj+CF/4Kcj9v4WiBf6VpmbqxRtA9VncInDVZV
 SOb3rkZjDZgzIRb5hNh4SoPfVIjkauUaneWOaHzRvBAQtHLY0UrOmn5p3zibIYBr/MZqXjzpW
 x05qRqAueFlzXsi36L8BSaooa0OrrEhdkYGsmeWTpdHOx8SP2pB8mjX7uEpPQrN88seG3Wx63
 jdfhiFSamHgWWMJD/xNkdHxu/6COdRblADraAnPFR/wIUKCkW18cRe9NRvvjNlTYBZoe8ONNB
 8eDAyZjO5cgg88+TS0MCpnRUiFiPD+ycoVQqPAxNQsE/tsyfJpyn5AM3sO16RbEh4TwUCHM3G
 0Rmyq74W+pGRGuvDdo/xs6VUruMELDqVN1BBu4X8rP/Ym/7Jh+WugeHFj5i78GtFbChReN7B7
 u5eJC6jvl5ys96RS9JLI7fOm3LnBhdlIomPejbGAWPdej2e2ri1UVgLBuJabGgvDbzxbQzGR2
 qR/+zxX5LuQTIF/I3XXv+foSP+k=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 8/3/23 15:11, Joel Stanley wrote:
> Hi Richard,
>
> On Thu, 3 Aug 2023 at 01:53, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Builds on Helge's v6, incorporating my feedback plus
>> some other minor cleanup.
>
> This succeeds for the armhf static binary on ppc64le host that was
> previously segfaulting.
>
> However, the arm static binary on ppc64le host now segfaults:
>
> $ gdb -q -ex r --args ./build/qemu-arm -d guest_errors,page,strace ~/hel=
lo
> Reading symbols from ./build/qemu-arm...
> Starting program: /scratch/joel/qemu/build/qemu-arm -d
> guest_errors,page,strace /home/joel/hello
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/powerpc64le-linux-gnu/libthread_db=
.so.1".
> [New Thread 0x7ffff762ece0 (LWP 143553)]
> host mmap_min_addr=3D0x10000
> pgb_find_hole: base @ 140420000 for 4294967296 bytes
> pgb_static: base @ 140420000 for 4294967295 bytes
> pgb_reserved_va: base @ 0x140420000 for 4294967296 bytes
> Locating guest address space @ 0x140420000
> page layout changed following mmap
> start    end      size     prot
> 00010000-00090000 00080000 ---
> 00090000-0009b000 0000b000 ---
> ffff0000-00000000 00010000 r-x
> page layout changed following mmap
> start    end      size     prot
> 00010000-00090000 00080000 r-x
> 00090000-0009b000 0000b000 ---
> ffff0000-00000000 00010000 r-x
> page layout changed following mmap
> start    end      size     prot
> 00010000-00090000 00080000 r-x
> 00090000-000a0000 00010000 rw-
> ffff0000-00000000 00010000 r-x
> page layout changed following mmap
> start    end      size     prot
> 00010000-00090000 00080000 r-x
> 00090000-000a0000 00010000 rw-
> 40000000-40810000 00810000 rw-
> ffff0000-00000000 00010000 r-x
> page layout changed following mmap
> start    end      size     prot
> 00010000-00090000 00080000 r-x
> 00090000-000a0000 00010000 rw-
> 40000000-40010000 00010000 ---
> 40010000-40811000 00801000 rw-
> ffff0000-00000000 00010000 r-x
> guest_base  0x140420000
> page layout changed following binary load
> start    end      size     prot
> 00010000-00090000 00080000 r-x
> 00090000-000a0000 00010000 rw-
> 40000000-40010000 00010000 ---
> 40010000-40810000 00800000 rw-
> 40810000-40811000 00001000 r-x
> ffff0000-00000000 00010000 r-x
> end_code    0x00084f7c
> start_code  0x00010000
> start_data  0x00095098
> end_data    0x00098394
> start_stack 0x4080f410
> brk         0x0009b000
> entry       0x00010418
> argv_start  0x4080f414
> env_start   0x4080f41c
> auxv_start  0x4080f4a0
> 143551 brk(NULL) =3D 0x0009b000
> 143551 brk(0x0009b8fc) =3D 0x0009b000

I think the problem is the brk with 9b000 here.
It's not 64k aligned (=3Dpages size of your ppc64le).

Please try with this patch on top of Richard's series:

> @@ -3229,7 +3208,8 @@ static void load_elf_image(const char *image_name,=
 int image_fd,
>       info->end_code =3D 0;
>       info->start_data =3D -1;
>       info->end_data =3D 0;
> -    info->brk =3D .....
change that to become:
     info->brk =3D HOST_PAGE_ALIGN(hiaddr);

Helge

