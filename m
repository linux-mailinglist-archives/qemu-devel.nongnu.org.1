Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E19845849
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Feb 2024 13:57:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVWcR-0001Rj-GR; Thu, 01 Feb 2024 07:56:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rVWcL-0001RJ-Sy
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:56:34 -0500
Received: from mail-dm6nam10on2084.outbound.protection.outlook.com
 ([40.107.93.84] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rVWcI-0007wT-R1
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:56:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kc80G1TQHu3RTMkCxMSEz5G+Q9KNpVaRoGfLoK84cR7CwLoJW1qfoXIezRoRA6Z48QYyU6QvyjEND0Rsk76E+YJC0DaBY3UwnOV4yI6rIBRyngLWNrWXvU8sHnWBKhqc91tgG4v7P3FXX6wNKqQh9Q/c3H70NYlW7obdXmu4bAWA2iYcqBsjGi/M4MC1XFz0LoHZrvSfBjwibAeyHjr8Ihsdv2rPXVJfCMZRw3SVXCVZHyea/IXBJG09+eARIinfkaoRb5xYXV66giPiTfOcZHeI5yvyKvS9jwyRD7V+I2f5yzovVgR8T7/kfnwM/2EJ5fcAb6ZdlDTneHB/7WytTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2RvR7tFy94XsdV9986Pk+ngmLw3UmPLw/+aQ3H54Jg=;
 b=CNE+5S56xDS1w4nCQ/8rRxLW6Kug/Qf1TM4XAVGKdT8t55jwbH0i4WTSJZcuI0E6DIDS68prbqDGodJ5GKqMyOI3GSm5DlmUGt8asQf4yUsrIMLfoO26PxFpEGIBztajmVYUQshVW+mG0YFKVRhAuV0VGhd3J8Sh0v5uEzxwSmJSFJwaEOKNPTE6Lw2z3B6mtdcdHwucTPu+xYZ+M4HRlOMw7ryOhpl+v2cuHQjpxnLF+jE5NJgEhUHpjPV9XIBU/xPskDay1OrVwhuoC1AWVnHfjnViHeyXSUyzRxQINHcO3xy9/Y79uhWVgn1LkRjicg52rZAGOrZYlehBDEo6CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2RvR7tFy94XsdV9986Pk+ngmLw3UmPLw/+aQ3H54Jg=;
 b=ENdRHfCIH1o5/yQfogmmsBo2H7i5x5g3N2iVJPcuJeHxrH7NbTtORMCOtSZuvMe/YZMz7DVLGn1bO94n8ThHOXCYLQCQfcfWkh5A9MaYL0EyoniEJvny6YM7XqJAQrciR7tTRxPueFef9wmAxtE+iiCBXJcbkAsJrZTw+Mskrdnlz1DT7el1AQetQ5l298YRo0oPI7y1srNuIdvqHp3U0uhYIeQnl5jTX46tMbPxbO0X9hGevHMh5+IL97q/jyFsGt4eqGJD4nLoLHqKg6s1bt3GHDfvDTF7cPocQt7Z/NJPuG6+6gRGfSc35S/7RBv7jIDWEWYLY6rXITohfPRxSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CH3PR12MB8993.namprd12.prod.outlook.com (2603:10b6:610:17b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11; Thu, 1 Feb
 2024 12:51:24 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7249.023; Thu, 1 Feb 2024
 12:51:23 +0000
Message-ID: <5515481b-3601-46e0-ba82-cbec056966f0@nvidia.com>
Date: Thu, 1 Feb 2024 14:51:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] migration/multifd: Refactor ->send_prepare() and
 cleanups
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Bryan Zhang <bryan.zhang@bytedance.com>,
 Prasad Pandit <ppandit@redhat.com>, Yuan Liu <yuan1.liu@intel.com>,
 Hao Xiang <hao.xiang@bytedance.com>
References: <20240131103111.306523-1-peterx@redhat.com>
 <871q9xjey8.fsf@suse.de> <ZbswgRJTXP4yKiuf@x1n>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZbswgRJTXP4yKiuf@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::19) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CH3PR12MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: bca76c2c-e25f-4866-d66f-08dc23247ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: riGLDyztv0GqX8dcmyYgyVbASSMnF86HWkhYHgfl/j0PtiOq1ZgE9G4PDaEmPdR8c/CFgZq59c9AlM7wPOowq9qaGrtFvyR3bepMX5eK2R53p4IgfKqunYk14EG2nNi0UhhKxZG7s6aq98B6LwcTB2kNaeY7K0I/eEOTxwOQGxvSRBhwA7UlPTrX5rmM81/k9sAQFhpu1aPtsIii/bv8Ujoq6/lHZuY6CgWrX9hiO3QfLHKxeNAhUVGuz/BIshuuxfeZcMiOSrd+Pel28DXC+QMXo+jCBtFnVW3LWp8Rs5901WCknuKnXGXs2IiVogt09rgZ8InIhrOYCPVhyVqkwD8nZ5GBCbKN85ed/nrZ2DCcG0lH14eTCvqANf9/IaiAEH/T+bhR0+xA7LK/zfj6JA0ntOONax6r/A17o9o9Ex38aX/j2EvfNyDTgmNgVaTcoHIzTOqRz+pKU30lhYvG+ez0KfsyUhp7uYI5j2YpNYXCi7q3VAZmUOdTBSrp7SBI8jQ/FAJGOXR6B0SlxLE9AmjaVDt3BKgP5T7R3qICNK2uKYFjlQn8hYRBeU1EA8dxzjxzkmlM+3Cka7Ye90yLaa6jMImvZ/TJaUvU2BBVVdpWnVcW1sdVxTr3D4K1+HTqiDQQSZOYl/5i9X/JEX7cwoeYlu3S5jUwMgZkNfD8e83Lpx7O79yY/NuUF6MpcMddEM/ZXRwS/BKqiMr7/Q1GPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(230173577357003)(230922051799003)(230273577357003)(64100799003)(1800799012)(186009)(451199024)(31696002)(36756003)(31686004)(86362001)(53546011)(6512007)(6486002)(966005)(478600001)(83380400001)(2616005)(26005)(2906002)(5660300002)(4326008)(66556008)(316002)(66476007)(54906003)(6666004)(6506007)(38100700002)(41300700001)(8936002)(66946007)(8676002)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVNTV01vazQrUFAxYktNMWp4R0trdi91U1hCT0Vxc0JhRElZS05ITjdFemVn?=
 =?utf-8?B?NEoycnRWR3RtL1NSUnNpOS93aW1oczF6aEdKVHIzbXgwMWdoQUN6TDMyUWdM?=
 =?utf-8?B?dEJQOWxTRUl6V0x0NjBmL0tURUgveC8zcTV6SDYrSHdTSHoveCtXbmtWY2VM?=
 =?utf-8?B?VFBVZlYxS20zZVgxalJkSjJiQit0WmVZcDVmQ2E3UXpJeTI1SE9JbnZ4WnNX?=
 =?utf-8?B?RjU2TTRmMnUwTUU1ZFJYTTVGaExJM00yRzY5cEsyQXo1WUVxM1picmJ4UGNB?=
 =?utf-8?B?RlUvY1ZuWUZrTWg0WnQxQWJHdEd5ZlFPUnkwOUZwak9kOUhkbjBEY2Y4QkxU?=
 =?utf-8?B?VnNwbHZFcUVFSTFCZnY3REppVytxZXdHQnBmalQ1MGdaanZLcGtxK3hsR3Fi?=
 =?utf-8?B?SUtMT3dtdUNJSGt5UWNiVk1GM0pLc0tSK3R4aFB6M3A0U1dHeW84Nm00Zm5V?=
 =?utf-8?B?Q1cySUl1M09DZjFUa3NxakFTYmFwbTBSUHRSMFNMbmdPajF1OU1taXRON0hK?=
 =?utf-8?B?Q1BTcHJxcHV4ZjZWL3ZLT3NhT1M5SUQ5a0MyK2dkRklDeVRhT0VDaTlWUFRX?=
 =?utf-8?B?a2xBdVlWRmtDQkFKdHBLY3FRNngyT1ZUTzVZQVpBT3hHa3ROcXV0UisyUS80?=
 =?utf-8?B?d2NZL1dXV0xYVU1oWktucXZaU2RndTc4TVR3eXE3cjdaRWx6R3ZtVnV6OFVF?=
 =?utf-8?B?TVo2dSs1RFZTdGtRNEdVeXVvVUNWdkVka1lwdVhXRVRRUjlxcmtVOFV0R1B0?=
 =?utf-8?B?c0NwNUZjK2tIZWxBUWUzSnAxdWhhajhxU0c4OWczNWxSU1ZjYlRxUHl0WXFY?=
 =?utf-8?B?U0hwWEwwN2x2Y1o5Y29sTHY1ZGpBblN5RmtFRVBoWDRQOTJDWjdTaFNSd2pL?=
 =?utf-8?B?bmNtRE1JcTNhYldrTTJTOE1Yd3lqNHZXK2UxSUk2ZkFmUWFCYjhXeXJJdzky?=
 =?utf-8?B?Q0pTaHBMajJuQUROOGNCN0QvQ1RnK3o5ZW5Sd2FIZ0RYR0JNaHh6N0xOM1BL?=
 =?utf-8?B?ZXk0VjlGYk5FcXd3QnV2MnVub1grRDVlMEIxQlI0SG1vQ3ViRktyTWJDRGdn?=
 =?utf-8?B?MTNzWktOdUhrVUt6a3pVSzVnVDhoeGNiam94VzlMNnAzVTBRbFcyd3llcm5H?=
 =?utf-8?B?cXh4NGdXSUxVSVNHaFprUlp1ZEhQUVcxSlZwTEJxQ3VHQ2FVQ3FlR1hjUnhD?=
 =?utf-8?B?dWc5Wm1qS2dCNE9PU084Uk1uYzFpKzlmbDk0eGp5NkQvcjZsOENBdnZiT0VU?=
 =?utf-8?B?ZTZFUk5xSFIxMmhTbFQ4b1gvMCtIQ0FsZVJyc3kySS9Vdm5RNFcvanZTQ1BJ?=
 =?utf-8?B?c1BsTVlWNnRoc3ovMWdlR3AzMU9FTXovaVJIaHU5S2RSbGZseGxNbGpYVjJK?=
 =?utf-8?B?WnJFUTFhRG1KVGJYMDdQdXZ3WllJUU00Vk9iWUgxdk1lS0JLYjNpY2Jta284?=
 =?utf-8?B?VkRYblQwdm5HMStGT040aVlLdjAzdjNSNUhsK2NXcURsdUxwTXZxOGY1K2dK?=
 =?utf-8?B?TFJLUFI0eTNUcVdyeG1rUTFqUjJ2ZVcwOUwwOXpnYno2OXk1UjJwaXZFUjRn?=
 =?utf-8?B?VzljVlU0OTVPR09WUkc0cjhpaVV2WGF0TWV0Z1Y5YmVtQ2dkdnFnRzZkN3Vr?=
 =?utf-8?B?TkJ5QzdZVFdxSzY5Y3V2L3lVd0JURmtydGg4U1FpTm5NeURkRUFFL1I5Q1dr?=
 =?utf-8?B?NUNZQU9SMGpLeSttTzVXVEkva3JMcWF6Vmsrcm93aTEvU04wWHlpelJhMWY3?=
 =?utf-8?B?K0pPUXU1RmhOWWhYcnQ1K3E3SjkwL2t6Lzl5TWU3TFZ2UGRuVG1qbyt1WjZO?=
 =?utf-8?B?VlZtRFNGS0EwOHRDSFNHMkhUTjNnV3l1UDVUK3ZwMUkxemErais5MjJrNEp4?=
 =?utf-8?B?bHBKSzRXdlQrNmtsYmdwWlg0Skt5cmFEQ2ZTVzIrVHJITE5hSXEraDRZTnVw?=
 =?utf-8?B?N3BKTjcyZDIwRzc2QVFzNnFLTWRDUXBZWnBBTmZmcXJlV3ZwTXBKQmVKSjVi?=
 =?utf-8?B?SVRacXBEaHR3QXpKOTR4TWxoWkkrR1hlUjQxa0FRM2YyUEQrTU1ZdXB3TEJG?=
 =?utf-8?B?eEI0MXBpd3BtQVREQ3RUcWFkSmpPMGtMK1FORHdKUUNIQ3lvaGhUVXNCQUVm?=
 =?utf-8?Q?14awre8ZmdCbGylOLhTeGr6VD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bca76c2c-e25f-4866-d66f-08dc23247ee9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 12:51:23.6899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScI7yTeNCbDcE1Frj32HZdNIOudj8/0H7ZFcl+6puo3Fl3QMyoVrDV2dRQgXsHw8momTfJfEfFD5kGyJWb8uWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8993
Received-SPF: softfail client-ip=40.107.93.84; envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


On 01/02/2024 7:47, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Jan 31, 2024 at 07:49:51PM -0300, Fabiano Rosas wrote:
>> peterx@redhat.com writes:
>>
>>> From: Peter Xu <peterx@redhat.com>
>>>
>>> This patchset contains quite a few refactorings to current multifd:
>>>
>>>    - It picked up some patches from an old series of mine [0] (the last
>>>      patches were dropped, though; I did the cleanup slightly differently):
>>>
>>>      I still managed to include one patch to split pending_job, but I
>>>      rewrote the patch here.
>>>
>>>    - It tries to cleanup multiple multifd paths here and there, the ultimate
>>>      goal is to redefine send_prepare() to be something like:
>>>
>>>        p->pages ----------->  send_prepare() -------------> IOVs
>>>
>>>      So that there's no obvious change yet on multifd_ops besides redefined
>>>      interface for send_prepare().  We may want a separate OPs for file
>>>      later.
>>>
>>> For 2), one benefit is already presented by Fabiano in his other series [1]
>>> on cleaning up zero copy, but this patchset addressed it quite differently,
>>> and hopefully also more gradually.  The other benefit is for sure if we
>>> have a more concrete API for send_prepare() and if we can reach an initial
>>> consensus, then we can have the recent compression accelerators rebased on
>>> top of this one.
>>>
>>> This also prepares for the case where the input can be extended to even not
>>> any p->pages, but arbitrary data (like VFIO's potential use case in the
>>> future?).  But that will also for later even if reasonable.
>>>
>>> Please have a look.  Thanks,
>>>
>>> [0] https://lore.kernel.org/r/20231022201211.452861-1-peterx@redhat.com
>>> [1] https://lore.kernel.org/qemu-devel/20240126221943.26628-1-farosas@suse.de
>>>
>>> Peter Xu (14):
>>>    migration/multifd: Drop stale comment for multifd zero copy
>>>    migration/multifd: multifd_send_kick_main()
>>>    migration/multifd: Drop MultiFDSendParams.quit, cleanup error paths
>>>    migration/multifd: Postpone reset of MultiFDPages_t
>>>    migration/multifd: Drop MultiFDSendParams.normal[] array
>>>    migration/multifd: Separate SYNC request with normal jobs
>>>    migration/multifd: Simplify locking in sender thread
>>>    migration/multifd: Drop pages->num check in sender thread
>>>    migration/multifd: Rename p->num_packets and clean it up
>>>    migration/multifd: Move total_normal_pages accounting
>>>    migration/multifd: Move trace_multifd_send|recv()
>>>    migration/multifd: multifd_send_prepare_header()
>>>    migration/multifd: Move header prepare/fill into send_prepare()
>>>    migration/multifd: Forbid spurious wakeups
>>>
>>>   migration/multifd.h      |  34 +++--
>>>   migration/multifd-zlib.c |  11 +-
>>>   migration/multifd-zstd.c |  11 +-
>>>   migration/multifd.c      | 291 +++++++++++++++++++--------------------
>>>   4 files changed, 182 insertions(+), 165 deletions(-)
>> This series didn't survive my 9999 iterations test on the opensuse
>> machine.
>>
>> # Running /x86_64/migration/multifd/tcp/tls/x509/reject-anon-client
>> ...
>> kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)
>>
>>
>> #0  0x00005575dda06399 in qemu_mutex_lock_impl (mutex=0x18, file=0x5575ddce9cc3 "../util/qemu-thread-posix.c", line=275) at ../util/qemu-thread-posix.c:92
>> #1  0x00005575dda06a94 in qemu_sem_post (sem=0x18) at ../util/qemu-thread-posix.c:275
>> #2  0x00005575dd56a512 in multifd_send_thread (opaque=0x5575df054ef8) at ../migration/multifd.c:720
>> #3  0x00005575dda0709b in qemu_thread_start (args=0x7fd404001d50) at ../util/qemu-thread-posix.c:541
>> #4  0x00007fd45e8a26ea in start_thread (arg=0x7fd3faffd700) at pthread_create.c:477
>> #5  0x00007fd45cd2150f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
>>
>> The multifd thread is posting channels_ready with an already freed
>> multifd_send_state.
>>
>> This is the bug Avihai has hit. We're going into multifd_save_cleanup()
>> so early that multifd_new_send_channel_async() hasn't even had the
>> chance to set p->running. So it misses the join and frees everything up
>> while a second multifd thread is just starting.
> Thanks for doing that.
>
> Would this series makes that bug easier to happen?

I think so.
Patch #3 added an extra multifd_send_should_exit() check in 
multifd_send_sync_main(), so now it can exit early if the first channel 
fails.
Plus, now migration state is set to FAILED early by:
multifd_new_send_channel_async()->multifd_send_terminate_threads() and 
multifd_tls_outgoing_handshake()->multifd_send_terminate_threads()
so migration_iteration_run() is completely skipped because 
migration_is_active() check before it will return false.

I *think* this is what makes main migration thread finish earlier and 
call multifd_save_cleanup() earlier, at least for me.

> I didn't do a lot of
> test on it, it only survived the smoke test and the kicked CI job.  I think
> we can still decide to fix that issues separately; but if this series makes
> that easier to happen then that's definitely bad..
>
> --
> Peter Xu
>

