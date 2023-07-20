Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0360475B8DD
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 22:44:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMaV7-0007do-7a; Thu, 20 Jul 2023 16:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan@outlook.com>) id 1qMaUv-0007bM-DN
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 16:43:43 -0400
Received: from mail-tyzapc01olkn2061.outbound.protection.outlook.com
 ([40.92.107.61] helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan@outlook.com>) id 1qMaUt-0007SJ-IL
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 16:43:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9szZ4bZXcTMLuLRpuCPULGhWSzDPTTGq3L9HX4TCIuFFgPJyfw0GOsyH7fRx5w5aPqG7KO+8uJWYcb0qrfXQv7iVp+9fWDDhHrJtLXTP7wBXVQVL3LibeFoYApwyH11Ps9iOgsl982rfw5Q4z4AQY+jdGSETNynlhBw7CwNXVQcodvSEO/VkE4d88OsdsF7ccwgJsu7tO8aJ8B5HVpXJEPoVX5NmIerCzbw9uQl147u0VfBvLrumE06CL0LPhwdNCRokP4/rQyE/ogVkb7Rp4eoWnrYt1OHb4qSfj40N8wIKRqrH2XAzu1jV1Umijs+jE/aU5ayhVpy+w00AIuUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yX4gP7cmE0jmp4P7QFEeIYCwM1JW3mdRn7vJ6P0weyI=;
 b=cBtYoa/b2Pjkz9M4Sr7fQLwt/eb3rde2G6/rywk6uto0VOdUEWEKB46swdsnfNDFGRbYlnDcLXivz9qLtrFN4PveS8oPv33/i0lr5Eiw4wYMihEoHzyMUjf1UhCe2Lbv9GZZToUiASoElrnLZijlAt3Rs9LQC/umv7sL45CzeZLz+FCP6aEdV9K0DAUj1pR9fjg96WtiWVEg4sqCLDHFhEhnMS7p2YtOBt3GDWwerw+QCTWXHwMsv44/IG3jTE6H9Ibs8hsp2NY/XTWOuh7Ls14Ng54f6IOKufD1eVKBjojTQUQIF4XCaY4aam+QF1qFJyLkDgvBlbbM5+u6az7FBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX4gP7cmE0jmp4P7QFEeIYCwM1JW3mdRn7vJ6P0weyI=;
 b=MY8Bt7ahI5yX70/3hcnXBAkB7c7wW45CKDyF+KvRwM9qu8l1IfDSG0r+cy9mo33s42kFJCCreE836YVCwo91aHei4z9ktXq7TA4wuA8xGxx8soLrWMEwyENLvYKHIS/T9O7sxBzUe6+VF/M/kDXCEWEy2lIlCgxThOZK9oeTtX3/mqI8GMbVfzpwvHr2yaXJaXBYEDmDoNNKn+JGWvrgDDrnVrhF8SHbaDoD/FtfXN6TwZVxx5GioRJeEqDzqR2XyIFdBgoSxMzNxXy8LOkBS1XO4jRJwyFAAMGrHGgiogKA6h6r2i6X/HSflaqU9YmXaWsJrBanS10Yf8Xy1jrkiQ==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 KL1PR0601MB4100.apcprd06.prod.outlook.com (2603:1096:820:24::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 20:38:29 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::450:9c8c:9058:c94c]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::450:9c8c:9058:c94c%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 20:37:28 +0000
From: nifan@outlook.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, hchkuo@avery-design.com.tw,
 cbrowy@avery-design.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 Fan Ni <nifan@outlook.com>
Subject: [Qemu PATCH 0/9] Enabling DCD emulation support in Qemu
Date: Thu, 20 Jul 2023 13:36:59 -0700
Message-ID: <SG2PR06MB33976BB3F9C47CBE08F02D09B23EA@SG2PR06MB3397.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [hEJeCfUOvIoSh/EqANQ0Ju6AJirbujao]
X-ClientProxiedBy: BYAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::21) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <20230720203708.25825-1-nifan@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|KL1PR0601MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 44799932-469b-43cf-95ae-08db896121de
X-MS-Exchange-SLBlob-MailProps: cn60g5V53KPsqNME0xQJrzHWqF+9xFSr+Zi9WDsuRF7mXQVoVD7zwBt/veIRh16+YCu6q6LvRX7fRcbvSuFldfO27VTGl6JWphcjviDV86vURZwgbRM3611pZstXArsfccVxrvwh3gmhB+kpk4c1NdrBbblChiObylKiTb4Q4yvfgyjeCu6CQlG6OxxikUNJh8H3xbj/S1npYLYCZxf+DdRqJxjUNmB4njaipS4ctsv1XGusADfkcBVT7mtujQDe801UWeO4e6iZ7Fh/nQbJcLw0/6Lj4ynuLY+RWkG8+J0FmV1Eat4gT36uGy34JHpwHa5ZI2toBEP6jlZZHg4GzWrgRAy84pdUfEHOCU25g9THsoJYisKj+cu4rE5VP8zefafqSA2xbrBqEVAGGqvRshEIoPQ0r9c2CUxdWvS6aAefhBS/++w29cZ0VhpG8jyM81vCpybYz08wrFzvBRtjC+9W97z+uHAMDWm6InNlb1gWDBtHehun89g6ZgTNFrSuUdezcfsALLK5THipstgNTPn4NRiaeHCGj1ho0qOhuTxRkA4TqUCoILeFluwnmf04bvlsD+sL64MZ5EByiRxuSFxUTIHP4Mq1q9pacEObcw6YMB42rP9ePMmPP4jIWSRw/TWSaxX6byLjDhcOThwYG/VtN1FxZdDz96qj4l+CGTjn5SKQYDGnQsfCEeFw8Aj18T3BTVk27HgpdpHWWEnazLD1fQzGc0FAZExIqZhTBxCppDGmXTnmEHq8dplYJXLIuuEhVdoRIn8t+LeuMYLMKKq5izCuESgezqyLJdTd1hQlxH4g3p//RSbVNVX+DEEngknunUV6a4ddoqyeYXBf0ROkft+D87EXWKB6OIyy5UIefw+KpjKjAQ==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PNfqlOQbyK6AT465atZI2kCJFo+qchRNhF3i9prPzhyCLcGMdAdUL+keEZ478c9FhOla9tU6ba9n59rPgoS4DtVlz+jnqsDg8Vtuthk3aBVseOyaQt0sw+rexrKtDj/17e1k7wFijfyBe/XWPC1tI6rvYGrfvpl+T0pcSjoecYIdZ+6xMTbipV5MqJ2CKjsrTuIKlsnOq68wn6yIXg8pcwwwqPnbHvcC2nUrcWHLRKTuQR3XSKYzeQXuQ7s29lYz7hib72JfBbJi0ovMP5hJe+azcor+pkCVg6X8kHsnJ01mMOcz6l/57aBQL3REhQyihUkp5DSX1E3X6xMTpQnn2DWt+XpIIXuYpI/YgEvUzck1ui+CHifcI/EDOXGVJCy//m8uu3uCa2K3TqPTms1b8Mj/AytkYOWKW23t43hcVzXgvMJ3yNvLlPfqYCUZnDMunaFm1eXkG2kFamp34n12T6yYilE2+PQaPnj8Kx/T9ANLGBmM2EC0O952l4UKi9GoL/nzzwyec1sFmOB6/FhnoekNpsgPXjajBWkWnpo0+I2BmHviLtSe42GTA1KLerDvd/KIdhxw6oYDELxMq9SL7XAEm58BuqSI5QYjY4qskHI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K3h4ypE9dn1GCha73W48u3UxULg+k7KbnvbbiJogIyzG6Xhlkn+ky0xbnHqc?=
 =?us-ascii?Q?B8/sIfsbdeQL+iRT+1UGCWn2jG3NduJjsx1epVf9V9gyElux9Q9QeBv8pcSJ?=
 =?us-ascii?Q?49prNOThuAq/WeWnAcJ4eTtPkAa9/3/7E2dsFQITOr+pFg0AWbSGQpr94SSj?=
 =?us-ascii?Q?52dSXO1jIMM6Cv0+9szk9fHg70cVPS+w9WwaQCxE/B05KbAwE65xYoOA+JuW?=
 =?us-ascii?Q?Plf4WHclNsIHA9X5KuuC+hq06DjEa616QMCnSRXhJnRUaqmPMC87y7bshwA6?=
 =?us-ascii?Q?54w0qZba6Gzd1DdFZG1K9G9hijeX17HIU5+1VKdMRzdKvjP2vZjXkHnNtLkh?=
 =?us-ascii?Q?nzzWGYQx6ae4lfH/svBOuwQk+5r+/kbjQ6XGosd1PFiWYprqhLYOuOqUHcG+?=
 =?us-ascii?Q?t+NnALUKPj6jGdgHsi1m4TMAoRjoBZ/qoUG9voYN+rj9zuws+emseD2/iIRS?=
 =?us-ascii?Q?oLg0wxR2+fs1Hfy43JawAe3bHUy1xBBtZfbvNe9OSiFRcRI0g0guQaAqS4NZ?=
 =?us-ascii?Q?mhATNZrEMvyli2YmX0UcKESU7mCSwTYhUBrjm6APY3wpVvmVlx5tdgE/IW9i?=
 =?us-ascii?Q?KJLJWBTaJkQmJT5GT9bL7rtxuzOO8vcJfYDA+N4r6EJ/EfWLIQcwXptkHJko?=
 =?us-ascii?Q?EymJXcGiKiupcqmbFjpadSwf+P59VXsd9qX0yavZvkJ8/DE/ooIPDjwkWLMi?=
 =?us-ascii?Q?V7U7fdbkzU2QiTq7KxY8m/hI3MfRIfXsBWCyiBFIUnX9p8nKRK0ikXOArBiW?=
 =?us-ascii?Q?6sbRGylUK+XqgahtLov2vnSHPIDSgbll3TVDI181G6zvq0zgqxIO58BR714G?=
 =?us-ascii?Q?jGOSBO9NS2RxodvIpskJoTYlNRLT3IlUZWzl+2S4MYsvr7WcRZGV8wIV9ou+?=
 =?us-ascii?Q?qDZToY5ua1XgbOB5+U9NxMD7sWeNV0S1rlxZJYiSR2i9j20tK2Uiq+vU1tr3?=
 =?us-ascii?Q?el6RPp5KqE4p/pHsN/TFyUnVJWxOBgRg/mORojruinTl4xR95Meg5mTxPW+i?=
 =?us-ascii?Q?IuYI61P5TQ5kIXpwT847C4Cy4rmb3enJOLIgyz8m/HmtOJ3X3yRPiZh5uRN3?=
 =?us-ascii?Q?Is7j4N/q3FCyIfBdbFzCIW8KmSYhCDqOWjsRA5REpmmHn/yrN+PK641JNHXd?=
 =?us-ascii?Q?bzPq/eRP18b7q2grsRPEvYZrC41oyIVP1Og9Bzp1jyxSNhIlLYWCbCdEz8Rg?=
 =?us-ascii?Q?Ur2ATdNxmueMWOTB1BLA+DMbflNK4GPyMtJsHA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44799932-469b-43cf-95ae-08db896121de
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 20:37:28.0547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4100
Received-SPF: pass client-ip=40.92.107.61; envelope-from=nifan@outlook.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

From: Fan Ni <nifan@outlook.com>

The patch series provides dynamic capacity device (DCD) emulation in Qemu.
More specifically, it provides the following functionalities:
1. Extended type3 memory device to support DC regions and extents.
2. Implemented DCD related mailbox command support in CXL r3.0: 8.2.9.8.9.
3. ADD QMP interfaces for adding and releasing DC extents to simulate FM
functions for DCD described in cxl r3.0: 7.6.7.6.5 and 7.6.7.6.6.
4. Add new ct3d properties for DCD devices (host backend, number of dc
regions, etc.)
5. Add read/write support from/to DC regions of the device.
6. Add mechanism to validate accessed to DC region address space.

A more detailed description can be found from the previously posted RFC[1].

Compared to the previously posted RFC[1], following changes have been made:
1. Rebased the code on top of Jonathan's branch
https://gitlab.com/jic23/qemu/-/tree/cxl-2023-05-25.
2. Extracted the rename of mem_size to a separated patch.(Jonathan)
3. Reordered the patch series to improve its readability.(Jonathan)
4. Split the validation of accesses to DC region address space as a separate
patch.
5. Redesigned the QMP interfaces for adding and releasing DC extents to make
them easier to understand and act like existing QMP interfaces (like the
interface for cxl-inject-uncorrectable-errors). (Jonathan)
6. Updated dvsec range register setting to support DCD devices without static
capacity.
7. Fixed other issues mentioned in the comments (Jonathan&Nathan Fontenot).
8. Fixed the format issues and checked with checkpatch.pl under qemu code dir.


The code is tested with the DCD patch series at the kernel side[2]. The test
is similar to those mentioned in the cover letter of [1].


[1]: https://lore.kernel.org/all/20230511175609.2091136-1-fan.ni@samsung.com/
[2]: https://lore.kernel.org/linux-cxl/649da378c28a3_968bb29420@iweiny-mobl.notmuch/T/#t

Fan Ni (9):
  hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
    payload of identify memory device command
  hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
    and mailbox command support
  include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
    type3 memory devices
  hw/mem/cxl_type3: Add support to create DC regions to type3 memory
    devices
  hw/mem/cxl_type3: Add host backend and address space handling for DC
    regions
  hw/mem/cxl_type3: Add DC extent list representative and get DC extent
    list mailbox support
  hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
    dynamic capacity response
  hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
    extents
  hw/mem/cxl_type3: Add dpa range validation for accesses to dc regions

 hw/cxl/cxl-mailbox-utils.c  | 421 +++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          | 539 +++++++++++++++++++++++++++++++++---
 hw/mem/cxl_type3_stubs.c    |   6 +
 include/hw/cxl/cxl_device.h |  49 +++-
 include/hw/cxl/cxl_events.h |  16 ++
 qapi/cxl.json               |  49 ++++
 6 files changed, 1034 insertions(+), 46 deletions(-)

-- 
2.39.2


