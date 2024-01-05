Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2449825237
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 11:37:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLhZF-0007eu-2V; Fri, 05 Jan 2024 05:36:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rLhZD-0007ec-3i
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:36:43 -0500
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rLhZB-0004L6-2P
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704450999; x=1705055799; i=deller@gmx.de;
 bh=HTqM978rbb6eILELo0Y/p4brHOX2rqT/ZFRKWalX2m4=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=qowmSMtujuJmxB8s42ZysKXttKO+RslTcZ2qeHhRAia7Z1oS1PEd6DGgpth1Wboe
 bvg9eJ/UN6RYGbFckaMsT9IGlqr4ih8pA7mgL1HPXgmz5NzjNmKGlTOAzCXioku3m
 kVfSlhmEvsV86Goao/+io3fbx6AaY1H/6k2BqTanSA0dp3b4/FzIJWKksj5jL4exN
 PpDhODkuoQg1Y+AGDqq8b8arbXVa+/sFaoOy1R58u3w707zkTAQl1LxLbp7Hn5NLb
 LRlnZd79plkclGKLSVnBKOswGDTxrkBAHfCsC8CLb+9b5c42S0QfjbaLoqVJ4QH4I
 nX+mxjj5hontL34/og==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.157.36]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCbIn-1rThuH3eEt-009jEL; Fri, 05
 Jan 2024 11:36:38 +0100
Message-ID: <02ea954a-ba42-4143-8311-6f4d6093c3e0@gmx.de>
Date: Fri, 5 Jan 2024 11:36:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] hw/hppa/machine: Allow up to 3840 MB total memory
Content-Language: en-US
To: qemu-devel@nongnu.org
References: <20240104183628.101366-1-deller@kernel.org>
 <20240104183628.101366-2-deller@kernel.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240104183628.101366-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uZsHJlbenzvP5nNlG6fvpn80q4aVxyxe1mHMdX9LoQ+sUnfKBfT
 p2T/OtJDu2+S2MhnZcqKxesL+W917pTYvDodflsbEppk1klQyB36VUDCaoOyeN/c2kfAyWC
 gSazzhW/AfDbtdSViFbo0H3ZDB+0oJAsmx8htsKk6x2a5JyoaIZLYfQ8e/9ZA5Dr9XmA87N
 4DBVqSH7FfWQ68sZT1FDg==
UI-OutboundReport: notjunk:1;M01:P0:TMT5tzZMBwc=;bRxtLklLT0Piy/2sgj+sl0P3qsa
 CsYlAz4APHeDxQml9/GJQ0xU+/nv4qCDxYH4RlzIRBmvEBOrRWwfeTu+SZ+zl1v2UuxMegT1g
 wm9phpIg9HGvAYsj+8OsAzisjQI8NvwyKh5TTKrPc3IFgI9W/jxZtP21IAM1haNylZaZhigJW
 WF5xeH8mybb13mhDItUE0nzrt2Hj2eetym58qUKtLsT+KDW6V9AzH3li9fU0Da6ebXJHg6MtH
 w6G7mv9hbUMHePcm9Lztq2e1MM0tUA8rHPE5pC3QqvLoQ51SvvjkvfSI7to1k56QcZ0zKmUny
 gNOOL2fQfXY9yBTbgu6sUFujESQpmWRQwtSxywOkB8qyHLmpXqqcCdKbz7chVZEbkwwcNw5lU
 UilljeT3uh7qju7v7JvtTINaHt3AiAbW1Doc3L7lXvyfuwZx7T2fYXD+0KYGK+OaA2oGrBu7n
 0Zmf8jGsyysg4TvOFSXJ4mnvopfWVG1elVuF5Uyh78V5LaAFC9AZV9UvlbOHFhyza5TkNhd6h
 0vlMELl1j98/stg7oO6YW9mYmRUzYjO8jguuVlnUcSN9BnZST7iHfG4gm85CQadEGR9CPRNYB
 cbQfx+9TAC9Kh7YRnJBhA7aezAaqTKMU6RmrRAo5ky4L+Im5PR5jFVPlNvn0i6mOxslUt8RmJ
 9We3crzmte9EXxlhDL69zue1M2pjg4OUzxHiTQWMdBbO0ghmgdKYeYVFnGGlKpjYPntn3BFLr
 /oCpHkt4/E9kioiijIxsAbReCrhIyDjKWEvGHRA09tTko7PpUh9dHlWNB62V0ztrdjA+wWaq0
 6Ru3WyKBvlqPFrtO0i7O04lM0PxCS+XN0eFF5RJwS3TK0uo1/rXmCy2R4Dhe2+fSIqOXBtOcb
 vzZfdf10yU+1Ge90Fwf0LERhxl8EJ91PTqWt3mE7NJ9IjMcTOP5fXndO574BPkCmcVG4XqWCl
 Nj0s+g==
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On 1/4/24 19:36, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
>
> The physical hardware allows DIMMs of 4 MB size and above, allowing up
> to 3840 MB of memory, but is restricted by setup code to 3 GB.
> Increase the limit to allow up to the maximum amount of memory.
>
> Btw. the memory area from 0xf000.0000 to 0xffff.ffff is reserved by
> the architecture for firmware and I/O memory and can not be used for
> standard memory.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Noticed-by: Nelson H. F. Beebe <beebe@math.utah.edu>
> Fixes: b7746b1194c8 ("hw/hppa/machine: Restrict the total memory size to=
 3GB")
> ---
>   hw/hppa/machine.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index c8da7c18d5..6181f4b747 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -276,6 +276,7 @@ static TranslateFn *machine_HP_common_init_cpus(Mach=
ineState *machine)
>       unsigned int smp_cpus =3D machine->smp.cpus;
>       TranslateFn *translate;
>       MemoryRegion *cpu_region;
> +    ram_addr_t ram_max;
>
>       /* Create CPUs.  */
>       for (unsigned int i =3D 0; i < smp_cpus; i++) {
> @@ -288,8 +289,10 @@ static TranslateFn *machine_HP_common_init_cpus(Mac=
hineState *machine)
>        */
>       if (hppa_is_pa20(&cpu[0]->env)) {
>           translate =3D translate_pa20;
> +        ram_max =3D 0xf0000000;      /* 3.75 GB (limited by 32-bit firm=
ware) */
>       } else {
>           translate =3D translate_pa10;
> +        ram_max =3D 0xf0000000;      /* 3.75 GB (32-bit CPU) */
>       }
>
>       for (unsigned int i =3D 0; i < smp_cpus; i++) {
> @@ -311,9 +314,9 @@ static TranslateFn *machine_HP_common_init_cpus(Mach=
ineState *machine)
>                                   cpu_region);
>
>       /* Main memory region. */
> -    if (machine->ram_size > 3 * GiB) {
> -        error_report("RAM size is currently restricted to 3GB");
> -        exit(EXIT_FAILURE);
> +    if (machine->ram_size > ram_max) {
> +        info_report("Max RAM size limited to %ld MB", ram_max / MiB);

Need to use RAM_ADDR_FMT instead of "%ld" here.
Will fix in v2.

Helge


> +        machine->ram_size =3D ram_max;
>       }
>       memory_region_add_subregion_overlap(addr_space, 0, machine->ram, -=
1);
>


