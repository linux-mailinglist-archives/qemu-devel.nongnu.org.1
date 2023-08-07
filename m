Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEA6771DC2
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 12:08:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSx8g-0005lh-25; Mon, 07 Aug 2023 06:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qSx8d-0005lY-Mo
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 06:06:59 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qSx8b-0007fX-Gg
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 06:06:59 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D944518A16;
 Mon,  7 Aug 2023 13:06:48 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 816F11BF67;
 Mon,  7 Aug 2023 13:06:47 +0300 (MSK)
Message-ID: <ddfe932b-57b7-8f48-03aa-82e1964dda2a@tls.msk.ru>
Date: Mon, 7 Aug 2023 13:06:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/3] hw/smbios: Fix thread count in type4
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20230601092952.1114727-1-zhao1.liu@linux.intel.com>
 <20230601092952.1114727-3-zhao1.liu@linux.intel.com>
 <598990ac-e5f8-fdcc-5936-e219491c4d0f@tls.msk.ru>
 <32cfa897-4472-083f-88cd-a3c3e3c405b0@tls.msk.ru>
 <20230807115615.278fb838@imammedo.users.ipa.redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230807115615.278fb838@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -109
X-Spam_score: -11.0
X-Spam_bar: -----------
X-Spam_report: (-11.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.139,
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

07.08.2023 12:56, Igor Mammedov wrote:
> On Sat, 5 Aug 2023 09:00:41 +0300
> Michael Tokarev <mjt@tls.msk.ru> wrote:
> 
>> 05.08.2023 08:58, Michael Tokarev wrote:
>>
>>> 196ea60a73 hw/smbios: Fix core count in type4
>>> 7298fd7de5 hw/smbios: Fix thread count in type4
>>> d79a284a44 hw/smbios: Fix smbios_smp_sockets caculation
>>
>> plus this one:
>>
>> a1d027be95 machine: Add helpers to get cores/threads per socket
> 
> just to note: v4 was what got merged eventually
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg972625.html

Yeah, I replied to the wrong version of the patch. Sure thing, whatever
is picked up for -stable gets picked up from the master branch, always,
not from any other source.  Above, I'm quoting commit-IDs from the master
branch.

> as for stable, I guess dies/clusters aren't used in production
> (based on lack of bug reports/complaints).

Quite often people try something and just give up if it doesn't work,
trying other ways or working around the issue one way or another.

> It's not worth of back-porting if it's too complex,
> but if it's clean cherry-picks it might help folks who use
> downstream (it's easier for downstream to pickup fixes from
> stable branch) to test this code path.

The whole thing - provided the preparational patch a1d027be95
"machine: Add helpers to get cores/threads per socket" is also
picked up - applies cleanly and in a stright-forward way to 8.0
and even to 7.2, and passes the usual qemu testsuite. Sure thing
since the issues weren't noticed before, the testsuite does not
cover this area.  It'd be nice to have some verifier to check if
the whole thing actually works after applying the patchset.

I'll pick this thing up for the next stable, thank you for the
clarification.

The whole -stable thing is exactly in order to centralize fixes.

Thanks,

/mjt

