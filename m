Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E25C8251B6
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 11:18:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLhGd-0005gw-VF; Fri, 05 Jan 2024 05:17:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rLhGc-0005go-FX
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:17:30 -0500
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rLhGZ-0001bG-U9
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704449845; x=1705054645; i=deller@gmx.de;
 bh=S9qWqj52YZIKl+zHWp8yV1ePw0QULm5nMGF+/3QWzKY=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=Lw2pFL8kQfdxcgSskx1V0weijybfLDWL1K+VrRXk7YTmwgAHH5HBsUgzyNQ9xcmR
 XWmA0PQFVCP/xx12tXRSaZ8mzkiN7J8SFj1V28VicQ4lWBp7YmBxHimAmoP7Lk0l/
 oQMJgRblRpNtZC90sHx/6S6f4x+e3q3w9xK6dbEMBJ779lPWD6Hq/X4Fc+15YDR2q
 /VqspUaUZZEbN1OEP2REsFYqxtQAPgYGhufvIk7bopk4URrxGYa+K94icICT6+GO+
 JnGOdbKySv+sfXyfTvDttG+gsEhRAP9888ngw3bqkyRZ7FFthd4Q+jsuLl4izcGHM
 kZK8c+VO3tkk+f1MLg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.157.36]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7sHo-1rGjBP2ywc-0054dR; Fri, 05
 Jan 2024 11:17:25 +0100
Message-ID: <2e2ddfb6-5c8a-4e0e-8443-a2860bf5377c@gmx.de>
Date: Fri, 5 Jan 2024 11:17:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/33] linux-user: Improve host and guest page size
 handling
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DQLly80aj22r1RqlzJs3gSgIb2Joo3u88yrDqn8MKgQwlF1aspn
 0p451eUTW/SVVRRMSyFaiIVu1eK+iwcJ9/7p038ve86YNuSLXQSyFmVRWxjoHj1EDYZwqTH
 GGaK3Zgd9pm/2J5H83iMqSSQixh6vRuTjQyfHob66bh8ov8bn3IQzRQkwzrZUeUvCo+DQsO
 SYjaw28GC2QCsQqu8GQkg==
UI-OutboundReport: notjunk:1;M01:P0:93Cdgc622V8=;+ha7fVoaBjV2Mwa/cXrFw1RhosY
 qUjVnAZYMEcO3ezNZ0OW0iCgLhe4i92JPEUd9fzeHLbopNYHL1C6rrCEE2gHNKSIFmaSkSpwG
 kmjEe+XgkITfaFj7LKF+Sg29pVsd/bT00xFJ4BYAqc9Uy+mRp5n7Eey21evDVA7lObwqhoL7w
 lmw2AOmVq1AAcRQqDk1bXQz6+iqnv06KFLh5U7I+C5B1JtgXpFDEULJaj5dprmBZm5RVOXgKh
 WvSdy1j17BDd4zyWkO9yx4A/DuMiPObHNB4uEoq0uIIHj0rtMUrqU4mzdkOSxsKsVPYdjBRS9
 qt2pnkN2FC1U/ZcxRqIGc9EwTEr8F7rad8Vj5ZHz3G1j4S6T0fesFEEACBk79+HpmKWKHTmT1
 jXm0dlFKqdqg3r7G/H4xn6a5sXiLRYaSW0nfcHOvpFtDS2Qq+h+QzxmqoLtB8LCzRI2J57xk5
 HV/GjF8R2qaYZ4INhGVm/TzZp/bAOWaDNDVSpTWkCSBUFMOiZrJZOF5cmGb/cf2BGz5G4HdpR
 Pbari+JkFYNw0RjmkqcOyMJUvzD6TwXh0Tr7rH5QFQkY38g7T/m4v1LMAyp4dmzCvyRNsvOjT
 l9cJcY/g9B00D5Ol70jkGnfbSTksuun07+CW6+5jUwFOmm5WR077xNs1BJjEJL+OFEYz4jgmi
 TYOMtL5t67k5q5QP2GCPDEsM+PHx9lPyb3QHbiqx8Q/fxm89ahjwHHBdgdUbu4hv0ER+WerCa
 XoQ4dnCE6kOjxYEVRp9I0QlSFnttuoGyoCGKuEzeix3Hksi3KuhfmBLCauSoddXLiEGR+VK49
 b3v0XL2+EaclhDewqFQjRZwTVXYH8YuUotlcAXpShxedhNzYIF8gSq2ynIJzPfwW/EfkYtDe0
 rfi7YVEQ/b3NmghLwIEzT/Tfivif5EGPkCxBlUybODjSi/NFHPyptpZ+OmhFdNXY0aXfxTv5B
 wSJQ81X3cOVeBdBWM/YPz99SfNM=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/2/24 02:57, Richard Henderson wrote:
> Changes for v3:
>    * Rebase.
>
> Blurb from v1:
>
> While working on mmap issues for 8.1, I noticed a lot of corner
> cases of host !=3D guest page size that we implement poorly.
> This seems to be particularly visible on Apple M1 with 16k pages,
> more so than Power with 64k pages for some reason.
>
> Objective 1 is to deprecate and (essentially) disable the -p option.
>
> The effect of -p is apparently confusing, so much so that our own
> testsuite misuses it.  One cannot really change the host page size,
> and pretending otherwise means that we don't treat the host memory
> system correctly, and stuff breaks.
>
> I have not yet done the same work for bsd-user.
>
> Objective 2 is to allow the guest page size to change to match the host.
>
> There are corner cases of host !=3D guest page size will fail in odd way=
s.
> For case of host > guest page size, the issues could be solved with
> softmmu, allowing a non-linear mapping between host and guest addresses
> and also disconnecting host and guest page permissions.
>
> However, host < guest page has issues with SIGBUS which I believe to be
> totally unfixable.  At minimum one would need to monitor changes to all
> files mapped in the address space, but I'm sure there is much more.
>
> But as always the best behaviour is obtained when the host and guest
> page sizes match -- there are no corner cases to contend with.
>
> There are a set of guests which can be configured to use multiple page
> sizes, and therefore software developed for those guests (usually) does
> not hard-code a particular page size.  For those, we can allow the
> page size to vary and let the guest match the host.
>
> I have only changed aarch64, alpha and ppc guests so far, as those
> are both easy to test and, especially for the case of alpha's default
> 8k page size, prone to failure.

I did some basic testing (built, installed, started chroots) for various
targets and did not see any obvious issues.
I did not specifically checked for particular page sizes though.

Anyway, for the series:
Acked-by: Helge Deller <deller@gmx.de>

Helge

>
>
> r~
>
>
> Richard Henderson (33):
>    accel/tcg: Remove qemu_host_page_size from page_protect/page_unprotec=
t
>    linux-user: Adjust SVr4 NULL page mapping
>    linux-user: Remove qemu_host_page_{size,mask} in probe_guest_base
>    linux-user: Remove qemu_host_page_size from create_elf_tables
>    linux-user/hppa: Simplify init_guest_commpage
>    linux-user/nios2: Remove qemu_host_page_size from init_guest_commpage
>    linux-user/arm: Remove qemu_host_page_size from init_guest_commpage
>    linux-user: Remove qemu_host_page_{size,mask} from mmap.c
>    linux-user: Remove REAL_HOST_PAGE_ALIGN from mmap.c
>    linux-user: Remove HOST_PAGE_ALIGN from mmap.c
>    migration: Remove qemu_host_page_size
>    hw/tpm: Remove HOST_PAGE_ALIGN from tpm_ppi_init
>    softmmu/physmem: Remove qemu_host_page_size
>    softmmu/physmem: Remove HOST_PAGE_ALIGN
>    linux-user: Remove qemu_host_page_size from main
>    linux-user: Split out target_mmap__locked
>    linux-user: Move some mmap checks outside the lock
>    linux-user: Fix sub-host-page mmap
>    linux-user: Split out mmap_end
>    linux-user: Do early mmap placement only for reserved_va
>    linux-user: Split out mmap_h_eq_g
>    linux-user: Split out mmap_h_lt_g
>    linux-user: Split out mmap_h_gt_g
>    tests/tcg: Remove run-test-mmap-*
>    tests/tcg: Extend file in linux-madvise.c
>    *-user: Deprecate and disable -p pagesize
>    cpu: Remove page_size_init
>    accel/tcg: Disconnect TargetPageDataNode from page size
>    linux-user: Allow TARGET_PAGE_BITS_VARY
>    target/arm: Enable TARGET_PAGE_BITS_VARY for AArch64 user-only
>    linux-user: Bound mmap_min_addr by host page size
>    target/ppc: Enable TARGET_PAGE_BITS_VARY for user-only
>    target/alpha: Enable TARGET_PAGE_BITS_VARY for user-only
>
>   docs/about/deprecated.rst                 |   7 +
>   docs/user/main.rst                        |   3 -
>   bsd-user/qemu.h                           |   7 +
>   include/exec/cpu-common.h                 |   7 -
>   include/hw/core/cpu.h                     |   2 -
>   target/alpha/cpu-param.h                  |  16 +-
>   target/arm/cpu-param.h                    |   6 +-
>   target/ppc/cpu-param.h                    |   9 +-
>   accel/tcg/translate-all.c                 |   1 -
>   accel/tcg/user-exec.c                     |  31 +-
>   bsd-user/main.c                           |  21 +-
>   cpu-target.c                              |  13 -
>   hw/tpm/tpm_ppi.c                          |   3 +-
>   linux-user/elfload.c                      |  67 +-
>   linux-user/main.c                         |  33 +-
>   linux-user/mmap.c                         | 714 +++++++++++++---------
>   migration/ram.c                           |  22 +-
>   system/physmem.c                          |  17 +-
>   system/vl.c                               |   1 -
>   target/arm/cpu.c                          |  51 +-
>   tests/tcg/multiarch/linux/linux-madvise.c |   2 +
>   tests/tcg/alpha/Makefile.target           |   3 -
>   tests/tcg/arm/Makefile.target             |   3 -
>   tests/tcg/hppa/Makefile.target            |   3 -
>   tests/tcg/i386/Makefile.target            |   3 -
>   tests/tcg/m68k/Makefile.target            |   3 -
>   tests/tcg/multiarch/Makefile.target       |   9 -
>   tests/tcg/ppc/Makefile.target             |  12 -
>   tests/tcg/sh4/Makefile.target             |   3 -
>   tests/tcg/sparc64/Makefile.target         |   6 -
>   30 files changed, 626 insertions(+), 452 deletions(-)
>   delete mode 100644 tests/tcg/ppc/Makefile.target
>   delete mode 100644 tests/tcg/sparc64/Makefile.target
>


