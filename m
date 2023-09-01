Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAA778FB84
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 11:57:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc0sS-0003pw-CC; Fri, 01 Sep 2023 05:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qc0sP-0003k2-52
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 05:55:41 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qc0sM-00062D-As
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 05:55:40 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 268381E6F0;
 Fri,  1 Sep 2023 12:56:09 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 545B82504C;
 Fri,  1 Sep 2023 12:55:33 +0300 (MSK)
Message-ID: <663cf3d4-47ea-262d-36b3-cf826f870ef0@tls.msk.ru>
Date: Fri, 1 Sep 2023 12:55:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 00/16] tests: Add CPU topology related smbios test cases
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org
Cc: Zhenyu Wang <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -103
X-Spam_score: -10.4
X-Spam_bar: ----------
X-Spam_report: (-10.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.478,
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

25.08.2023 06:36, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Hi all,
> 
> This patchset is the follow up tests of previous topology fixes in
> smbios [1].
> 
> In this patchset, add these test cases:
> 
> 1. Add the case to test 2 newly added topology helpers (patch 1):
>     * machine_topo_get_cores_per_socket()
>     * machine_topo_get_threads_per_socket()
> 
> 2. Add the cases in bios-tables-test.c to:
>     * test smbios type4 table count (patch 2-4).
>     * test smbios type4 core count field (patch 5-7).
>     * update the test of smbios type4 core count2 field (patch 8-10).
>     * test smbios type4 thread count (patch 11-13).
>     * test smbios type4 thread count2 (patch 14-16).
> 
> With the above new cases, cover all commits of [1] in test.
> 
> [1]: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg06225.html

Hmm.  I definitely didn't expect such a large patchset..  I asked for just
a small, maybe manual (from command-line) reproducer of the original issue,
so I can verify it is fixed before applying the change in question to qemu
stable trees.  It is a large work.  Lemme at least give it a try in the
gitlab CI...

Philippe, can you pick this up for the misc tree?

/mjt

