Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5713979A65B
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 10:55:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfcgw-0000ti-Fq; Mon, 11 Sep 2023 04:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfcgs-0000sw-2h; Mon, 11 Sep 2023 04:54:42 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfcgp-0003a2-Bj; Mon, 11 Sep 2023 04:54:41 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E530D20B64;
 Mon, 11 Sep 2023 11:54:36 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3C58D2729D;
 Mon, 11 Sep 2023 11:54:35 +0300 (MSK)
Message-ID: <1a46e003-b009-4a89-f555-67277bcd3ce6@tls.msk.ru>
Date: Mon, 11 Sep 2023 11:54:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/7] i386: spelling fixes
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20230909131258.354675-1-mjt@tls.msk.ru>
 <20230909131258.354675-3-mjt@tls.msk.ru>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230909131258.354675-3-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Paolo, Michael, can you take a quick look please?

https://patchew.org/QEMU/20230909131258.354675-1-mjt@tls.msk.ru/20230909131258.354675-3-mjt@tls.msk.ru/

09.09.2023 16:12, Michael Tokarev:
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   host/include/i386/host/cpuinfo.h | 2 +-
>   hw/i386/acpi-build.c             | 4 ++--
>   hw/i386/amd_iommu.c              | 4 ++--
>   hw/i386/intel_iommu.c            | 4 ++--
>   hw/i386/kvm/xen_xenstore.c       | 2 +-
>   hw/i386/kvm/xenstore_impl.c      | 2 +-
>   hw/i386/pc.c                     | 4 ++--
>   include/hw/i386/topology.h       | 2 +-
>   target/i386/cpu.c                | 4 ++--
>   target/i386/cpu.h                | 4 ++--
>   target/i386/kvm/kvm.c            | 4 ++--
>   target/i386/kvm/xen-emu.c        | 2 +-
>   target/i386/machine.c            | 4 ++--
>   target/i386/tcg/translate.c      | 8 ++++----
>   tests/tcg/i386/system/boot.S     | 2 +-
>   tests/tcg/i386/x86.csv           | 2 +-
>   16 files changed, 27 insertions(+), 27 deletions(-)

Thanks,

/mjt

