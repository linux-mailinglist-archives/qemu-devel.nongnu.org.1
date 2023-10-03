Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F5F7B6F3A
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:04:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnino-00045Z-Fh; Tue, 03 Oct 2023 13:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qnink-000456-Ut
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:03:16 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qninj-0001Xy-6W
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:03:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5F17C27281;
 Tue,  3 Oct 2023 20:03:55 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1D3FE2C940;
 Tue,  3 Oct 2023 20:03:10 +0300 (MSK)
Message-ID: <ce76c905-71bc-d141-cd98-b310732e4e41@tls.msk.ru>
Date: Tue, 3 Oct 2023 20:03:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH for-8.1] vfio/display: Fix missing update to set backing
 fields
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, kraxel@redhat.com
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 "Kim, Dongwon" <dongwon.kim@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
References: <20230816215550.1723696-1-alex.williamson@redhat.com>
 <a3a6f8ec-ca61-4472-45b4-1077dd27bb52@linaro.org>
 <acddfb4a-fe42-ba8c-e920-edc7e9ff5268@intel.com>
 <CAJ+F1C+YiDgRuyWcGeUPhaNO4SdjOSFSHKBY1wBS3dJFLO-k2w@mail.gmail.com>
 <20230904081129.3908c083.alex.williamson@redhat.com>
 <CAJ+F1CJFiHCu4FTbSFfLgSANiHJHEowJg7Um3j+ZMiHb_S21aQ@mail.gmail.com>
 <20230905090907.2b70b6a0.alex.williamson@redhat.com>
 <20230913131827.3bfe7bcb.alex.williamson@redhat.com>
 <b138199a-ceaa-4bf9-4d91-50a05ccc3267@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <b138199a-ceaa-4bf9-4d91-50a05ccc3267@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -79
X-Spam_score: -8.0
X-Spam_bar: --------
X-Spam_report: (-8.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.09,
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

22.09.2023 12:38, Cédric Le Goater:
> On 9/13/23 21:18, Alex Williamson wrote:
>>
>> Hi Gerd,
>>
>> Some consultation would be appreciated on this thread to get this patch
>> out of limbo.  Is there a better solution that what I've proposed?
> 
> This does fix a regression reproducible on systems with an Intel Gen 8,
> my T480 laptop for instance.
> 
> Tested-by: Cédric Le Goater <clg@redhat.com>
> 
> Also, queuing it in vfio-next.

Cédric, can we get this in time for 8.1.2 please
(which I'm planning for Oct-14 for now)?  Looks like
it hit quite some people already.

I dunno what are your plans for vfio-next, maybe this
one (which missed 8.1.0 already) can be pushed as a
bugfix?

Thank you!

/mjt

