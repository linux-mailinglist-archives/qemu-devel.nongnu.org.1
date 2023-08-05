Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F43770DF8
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 07:59:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSAIs-0001nI-VV; Sat, 05 Aug 2023 01:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qSAIm-0001n4-To
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 01:58:14 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qSAIk-0001Cv-Ad
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 01:58:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5333F18553;
 Sat,  5 Aug 2023 08:58:27 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 20CEC1B936;
 Sat,  5 Aug 2023 08:58:06 +0300 (MSK)
Message-ID: <598990ac-e5f8-fdcc-5936-e219491c4d0f@tls.msk.ru>
Date: Sat, 5 Aug 2023 08:58:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2 2/3] hw/smbios: Fix thread count in type4
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20230601092952.1114727-1-zhao1.liu@linux.intel.com>
 <20230601092952.1114727-3-zhao1.liu@linux.intel.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230601092952.1114727-3-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.093,
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

01.06.2023 12:29, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
>  From SMBIOS 3.0 specification, thread count field means:
> 
> Thread Count is the total number of threads detected by the BIOS for
> this processor socket. It is a processor-wide count, not a
> thread-per-core count. [1]
> 
> So here we should use threads per socket other than threads per core.
> 
> [1] SMBIOS 3.0.0, section 7.5.8, Processor Information - Thread Count
> 
> Fixes: c97294ec1b9e ("SMBIOS: Build aggregate smbios tables and entry point")
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Hi!

This, and other two patches in this area, smells like a -stable material.
Is it not?

196ea60a73 hw/smbios: Fix core count in type4
7298fd7de5 hw/smbios: Fix thread count in type4
d79a284a44 hw/smbios: Fix smbios_smp_sockets caculation

Thanks,

/mjt

