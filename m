Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A06B1E9EC
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Aug 2025 16:05:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukNhy-0004Yr-MI; Fri, 08 Aug 2025 10:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1ukNht-0004Y9-V9
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 10:04:29 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1ukNhn-0005D9-V0
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 10:04:29 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bz5Hr33LGz6L4vy;
 Fri,  8 Aug 2025 21:59:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 6817A14022E;
 Fri,  8 Aug 2025 22:04:15 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Aug 2025 16:04:15 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 8 Aug 2025 16:04:15 +0200
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "armbru@redhat.com"
 <armbru@redhat.com>, "dave@stgolabs.net" <dave@stgolabs.net>, Linuxarm
 <linuxarm@huawei.com>
Subject: RE: [PATCH v5 1/7] hw/cxl/events: Update for rev3.2 common event
 record format
Thread-Topic: [PATCH v5 1/7] hw/cxl/events: Update for rev3.2 common event
 record format
Thread-Index: AQHcB7IbgHJy8x5snE+W5U6ovLZH5LRYn+mAgAArEnA=
Date: Fri, 8 Aug 2025 14:04:15 +0000
Message-ID: <891c3fc930fa45cc9a3b01ac028a4c15@huawei.com>
References: <20250807154346.2209-1-shiju.jose@huawei.com>
 <20250807154346.2209-2-shiju.jose@huawei.com>
 <20250808142907.000022f4@huawei.com>
In-Reply-To: <20250808142907.000022f4@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.244.202]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56; envelope-from=shiju.jose@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Shiju Jose <shiju.jose@huawei.com>
From:  Shiju Jose via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



>-----Original Message-----
>From: Jonathan Cameron <jonathan.cameron@huawei.com>
>Sent: 08 August 2025 14:29
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: qemu-devel@nongnu.org; linux-cxl@vger.kernel.org; armbru@redhat.com;
>dave@stgolabs.net; Linuxarm <linuxarm@huawei.com>
>Subject: Re: [PATCH v5 1/7] hw/cxl/events: Update for rev3.2 common event
>record format
>
>On Thu, 7 Aug 2025 16:43:40 +0100
><shiju.jose@huawei.com> wrote:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> CXL spec 3.2 section 8.2.9.2.1 Table 8-55, Common Event Record format
>> has updated with optional Maintenance Operation Subclass, LD ID and ID
>> of the device head information.
>>
>> Add updates for the above optional parameters in the related CXL
>> events reporting and in the QMP commands to inject CXL events.
>>
>> In qapi/cxl.json added fields of Common Event Record to a common
>> structure CXLCommonEventBase.
>>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Hi Shiju,
>
>Sign off chain doesn't make sense. Drop my SoB.  I guess this is because i=
t went
>through my tree at some stage and hence was tagged by me. Given it's your
>patch, you should drop that from new versions.
Hi Jonathan,

Thanks. I will do.

>
>Jonathan
>
>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Thanks,
Shiju

