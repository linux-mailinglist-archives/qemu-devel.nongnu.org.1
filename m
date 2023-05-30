Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 977FA7152FC
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 03:38:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3oIM-0007UM-Gu; Mon, 29 May 2023 21:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@samsung.com>)
 id 1q3oIJ-0007UE-5q
 for qemu-devel@nongnu.org; Mon, 29 May 2023 21:37:04 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@samsung.com>)
 id 1q3oIC-00080s-Fz
 for qemu-devel@nongnu.org; Mon, 29 May 2023 21:37:02 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20230530013648epoutp0250f11f176fc3c838efa2321908e1fb49~jyAS7xknx1176711767epoutp02H
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 01:36:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20230530013648epoutp0250f11f176fc3c838efa2321908e1fb49~jyAS7xknx1176711767epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1685410608;
 bh=KIPteUOYoEhKBczI05uvmnx3pmAArn+RsMB3Q3+dA2g=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=elfMI8t5D5omSNEJPaM1yM6NVjzxiWBSnElhtXR7GZMB44El6HlKABKo8JyM3Eu5A
 BCrDlXexAQCyUEzpPv5noTLNf0Fg+MVClBVxphNDBdT/lIvKaNHwXliVz6tHEBmoym
 1RjY2yQcVJ4nFlaMLNQxrwnQ6S80ffuTylkKC/Ds=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20230530013647epcas2p1cc9829875fecfa2a7553740b1362e02f~jyASqk-Jl3236932369epcas2p1h;
 Tue, 30 May 2023 01:36:47 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.70]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4QVZkR0WCpz4x9Pt; Tue, 30 May
 2023 01:36:47 +0000 (GMT)
X-AuditID: b6c32a47-eedff70000001ce0-4e-6475532e6047
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 F9.0C.07392.E2355746; Tue, 30 May 2023 10:36:46 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH 1/3] hw/ufs: Initial commit for emulated
 Universal-Flash-Storage
From: Jeuk Kim <jeuk20.kim@samsung.com>
To: Thomas Huth <thuth@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "hreitz@redhat.com" <hreitz@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Klaus
 Birkelund Jensen <k.jensen@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <fbc8003d-9d91-55a0-940f-240d687aae75@redhat.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230530013646epcms2p392066e0dcbd6613d06977974a4f81c1d@epcms2p3>
Date: Tue, 30 May 2023 10:36:46 +0900
X-CMS-MailID: 20230530013646epcms2p392066e0dcbd6613d06977974a4f81c1d
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmha5ecGmKweJLNhZv3qxhsnh5SNPi
 wd1+RouTjXtYLZZcTLVY0NbOavGy/QSzxf9fr1gt9m/7x2qxZoWwxax37WwWx3t3sFisPGbj
 wOuxc9Zddo871/aweTy5tpnJ4/2+q2wefVtWMQawRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7
 x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gBdqKRQlphTChQKSCwuVtK3synKLy1JVcjILy6x
 VUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIztiz+DN7wVqeiq+9bewNjG84uhg5OSQE
 TCS+rL7I2sXIxSEksINRYtav/UxdjBwcvAKCEn93CIPUCAuESRw6dZYZxBYSUJCYs62DHSKu
 KTF9/USwcjYBdYnTC81BwiICShLr/u1nARnJLNDPIjH1dyszxC5eiRntT1kgbGmJ7cu3MoLY
 nAJ2EvvWXGGEiGtI/FjWC1UvKnFz9Vt2GPv9sflQNSISrffOQtUISjz4uRsqLilx6ttjVgh7
 OqPEgv+mIEdICCxglPjVPB2qQV/iWsdGsCN4BXwlvt1+BmazCKhKXH66iw2ixkVi2a4XYDaz
 gLzE9rdzmEGeZAZ6eP0ufRBTQkBZ4sgtFogKPomOw3/ZYV5s2PgbK3vHvCdMELaKxOLmw6wT
 GJVnIQJ6FpJdsxB2LWBkXsUollpQnJueWmxUYAyP2+T83E2M4LSq5b6DccbbD3qHGJk4GA8x
 SnAwK4nw2iYWpwjxpiRWVqUW5ccXleakFh9iNAX6ciKzlGhyPjCx55XEG5pYGpiYmRmaG5ka
 mCuJ80rbnkwWEkhPLEnNTk0tSC2C6WPi4JRqYJJeWFZ86X7C/zsudWsqlYUmnPjrV31ro6vi
 7J03y/6eNz//Z33LkR/dpiU/WSckpr5rc8p+GXvV52NHwpIT5ftqk/x39oqfOzRvW2bS5u6p
 DhMeXxL/+2XTEgZpqanC9sd5xc02V8qvs4wyuHC2LX/GOQ2P28orjhnt/PzFf8kNm8x/bJ8n
 xb6TN9b6c35nj/0aAdPLC6Yz5Ct3nNrBr1n2de6ktOq5B4U33vx8PrpQfpKD+pyHBTZsmSaG
 mfonjuYXZqT6u7HvORNwWjH498L7hwL5T/yQ4boWw8wpzHvSISkvseSR7/rX3kWHjupf9an5
 OUH5W7WGYrBL+yWtyCV8kY/ayjvPLGd9ceoSG78SS3FGoqEWc1FxIgCJ0o7DNAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230526050555epcms2p287be772002cd941cc79226968c319036
References: <fbc8003d-9d91-55a0-940f-240d687aae75@redhat.com>
 <20230526050555epcms2p287be772002cd941cc79226968c319036@epcms2p2>
 <CGME20230526050555epcms2p287be772002cd941cc79226968c319036@epcms2p3>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=jeuk20.kim@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-To: jeuk20.kim@samsung.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 26/05/2023 15:37, Thomas Huth wrote:
>On 26/05/2023 07.05, Jeuk Kim wrote:
>> Universal Flash Storage (UFS) is a high-performance mass storage device
>> with a serial interface. It is primarily used as a high-performance
>> data storage device for embedded applications.
>> 
>> This commit contains code for UFS device to be recognized
>> as a UFS PCI device.
>> Patches to handle UFS logical unit and Transfer Request will follow.
>> 
>> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
>> ---
>>   MAINTAINERS              |    6 +
>>   hw/Kconfig               |    1 +
>>   hw/meson.build           |    1 +
>>   hw/ufs/Kconfig           |    4 +
>>   hw/ufs/meson.build       |    1 +
>>   hw/ufs/trace-events      |   33 +
>>   hw/ufs/trace.h           |    1 +
>>   hw/ufs/ufs.c             |  305 ++++++++++
>>   hw/ufs/ufs.h             |   42 ++
>>   include/block/ufs.h      | 1251 ++++++++++++++++++++++++++++++++++++++
>>   include/hw/pci/pci.h     |    1 +
>>   include/hw/pci/pci_ids.h |    1 +
>>   meson.build              |    1 +
>
>Do you expect lots of additional files to be added to the hw/ufs/ folder? If 
>the answer is no, then it's maybe a little bit overkill to introduce a 
>separate folder for this. Wouldn't hw/block/ be a good fit for this as well? 
>Or maybe we could introduce hw/flash/ or so and also move the contents of 
>hw/nvme there?

Yes. I plan to add more files to UFS for different functions (UICCMD, MQ, zoned, etc.) like nvme.
So personally, I think it would be good to keep the hw/ufs/ directory.

