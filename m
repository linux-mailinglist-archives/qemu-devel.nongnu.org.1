Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C2C7D7EC6
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 10:47:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvw1D-0008Pe-44; Thu, 26 Oct 2023 04:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1qvw1A-0008KT-NL
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:47:04 -0400
Received: from mail-ve1eur01on2108.outbound.protection.outlook.com
 ([40.107.14.108] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1qvw18-0001IV-4F
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:47:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ge0PXqfwYuO6GK1hNl5UIlTCGVDlzqz+0wgeL4tzciB2mgNPIM5L4xqeryluTbuYMc6puu1dVzznFAqe183I9thKnV886kUwQIjn0i2ID8G9PY2LbHUE5cBIShYR2s+klTjcmBPDeJ3V+vvLqooW/C8o7293bhOO8NlH6YR0vT/o3ZYqHyhOx79444bI7Nd/+YX3LGKmIruiRuBSfWf8+gdSTZ0qn4AqmLOR/qYzzHw58xDBJKJGgZ5grROU8W1tAwa0cJB8xcIeuRsNgufGPKYscDPsDbPgLobpZ89sOzVOz0CBbuHFoxd/vkL8YqJrHXxBTa6KbFmd8hxAzeJ0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAuxsLgup0/LldH4aqrIRT6n1u3G5BIoJkunXbpEI98=;
 b=Q94Ndn4+dxqlK5FCIKuXBKGPYw5Zho8vLmFIH4qwDE0pTzuzmQL7orkU5lpM5prOYzWZJnEQH74AqPSdfmmZ41JQwbgQypTVW5Co4xhwzcbkHk3kdKDXC2InK5LUJ7vdUol3ttF7p5AWGuzPLQuNI1dkWGwplrODP3I1OD6B2R8WLWN7/JUC8P6ZzXISI2cFV/ZxgJpNPoo6yHWfnPKXMhPu+ttxa55tFOl+F+C7GjMcW5Of4jJB7jdWzJMVByiaXka1JQfNMUzmd73o6km9F6bbvYaA5zEpB2ZHXx1oV9HJKOAD/8OYtc76y+qLFU5DAkJdWUrX8J2RAhrai3980A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAuxsLgup0/LldH4aqrIRT6n1u3G5BIoJkunXbpEI98=;
 b=AiuYRT5gdNxdWgrhFfkeU3SHT3omre/hUh98N5DnsuURPq+ebU9OVfVhc9AeI880Zv7QO4DKa9V+c58wG2RbpS2vTM9xwBfmimAuLfiJs5w4sZxlcVfiuRQYGNyzGm+aGSxVOiVpG45H+ZW4MVP51WYjq1JyiztYWjg4yKFkj0uOL0HMfcbdJXiWZAj0Bd7dmTFR1msc6x4CIsIwXMldN6IHr537Dv19lJ7V8U6IS5Ookj36R7o1JUISckM/VCi6nzlc5oeBr8spwwZoiuoQlxG7C67lLAEe9kgpn0YLe40ZJ6Ud5R7eFxwiRMVb5ipXNs0HkTIjTRVR7S7Su1opAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DB5PR08MB10309.eurprd08.prod.outlook.com (2603:10a6:10:4a9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 08:41:56 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::c196:49d8:108c:2254]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::c196:49d8:108c:2254%6]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 08:41:56 +0000
Message-ID: <5d9ab399-c5b2-41cd-9f2d-73d478e3c72a@virtuozzo.com>
Date: Thu, 26 Oct 2023 10:41:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] vfio/pci: Fix buffer overrun when writing the VF
 token
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev"
 <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>
References: <20231026070636.1165037-1-clg@redhat.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20231026070636.1165037-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0091.eurprd04.prod.outlook.com
 (2603:10a6:803:64::26) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DB5PR08MB10309:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ef54e3-f076-4b2d-d264-08dbd5ff692a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h5ojH7mhsGVvNAap6BMS0OKWOQqaTDR6dFWnKYM9ItGFa6TdwD2Gr51Wa2Vw6epsKgxdzIykctJ1nuBRe5/jaz6+pnbtvZO4qMVvJARMHHawph7RkQiQ3VylBwT816e9nT8q2O9Uu3uoTi8vBbmYaKw550wlN1TVFr5DG9I7KRNMs1b06tGsFw4e1RI+jHX0JXVYbtxdqx3QuPQFICWO1p+MTvfJHAlsPbU1bZamoIz5jnn5j5mMabnLQUhPiqmYnOWDsesz8GzHdOb4Sj8tb6JQdKrAJAH3gm7BNmCBRHvoriDDeCosAi6jb3zid6R2+JH5XEITcYlMAsogqoxfV8nUj4MTasN1eksW+48qPliUwpaRMXnnyARalnehuMoTPaw0UU6lKep3wz83hiWB60GzNCy9G2i4CciOD2Lk6Kp1aYY0iniJ7BVBK+NFy0ZX0LpF+Jnk1ku7Jx9Uy8yD2D/4GF2MA/2FYB4qizd/Qk0vH8bK7AlYkLNn+NfQDoZJDCWo5CHvrZ1mb2sWJRadE7tiFVeQ9VKC6dIOpuCjIUkMuFzBDyAUBgxzy24sQuCQWNWB1fnVgU/YGhzMCd942SqC2WZInlzOFjv0ymVcMQmkci22z7k2CdPQcllGuFAK0BBT+EFAsnBotAS9itNUHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(376002)(366004)(346002)(136003)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(83380400001)(36756003)(54906003)(66476007)(66556008)(316002)(38100700002)(41300700001)(66946007)(4744005)(2906002)(7416002)(5660300002)(8676002)(8936002)(4326008)(478600001)(6486002)(31686004)(53546011)(6512007)(6666004)(6506007)(2616005)(26005)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGZpeDMzL3AyLzBaWFNGY2J1RzFQcHhuTUJDTFBvZnRyMTBMY3pIYTJOMW9j?=
 =?utf-8?B?QnB0ZDdqK3ZoaHJYc3BRYlN6MXh6empvQlNvV0pVeHJ2VnpISEdMMUg3RGZm?=
 =?utf-8?B?U3Z0TVNtWXFtWXlJMnZhUlAvTEtoWnRrVHQrbzdZc0pxakxFN2UrZCtZVTFS?=
 =?utf-8?B?SkRvYTV6bjNSWW5pOG1vZGtDWm9RdGdJcUR2a3dDLzkrWk5yc0Z0MHdxQ0JE?=
 =?utf-8?B?TmlBc3VvOGhvOVVVelhJWWxTeVBOWUtOOXZjQUoySll0UldEUlZvd0ZHSkZo?=
 =?utf-8?B?bU1zc1M2MlozczBMVXgvcjAzc3FrYitod2g5NWF4SkRKRUhCVzZndFZLUHd3?=
 =?utf-8?B?Uy9TQmJCdkxCTGh3RldjMW9wbS9Xd3FvLys3ZnJzK3cxVnkxMWhXbHFYYTd6?=
 =?utf-8?B?WC9UUDZwMzVhMC81bnZlLzB4SS9TdmZBSDBPSXlUdmpDNTU1UG40QWdsdC9D?=
 =?utf-8?B?dW1NWmdRM3N2NXJVK2JXVS9hbTFiRmNXR3VQMHVKNDhkUmhWYUovK3lOdXVy?=
 =?utf-8?B?OWVSYTJjQUhmZkdOL2xaVVp4ZUgzazZheDF0WitkU216L3h5U0hXdzdTZmIr?=
 =?utf-8?B?eGNUZGVrWnBMK3FwVkg2S0JjNGVtSzdjMHFFdFE4TG9VUzV5NjliZjUzVG9n?=
 =?utf-8?B?RHJNOTFTYmlQUXRRdUNnVnBkWHpMRzB6YkVNRUN1d3RXZUYzUExwaFRGK2Fh?=
 =?utf-8?B?VklkV3lVSlkzZ01MRDhLc0lDVXcwTURaZTBIR2kxTGZLVzhSamlNdjBjK2FD?=
 =?utf-8?B?K0QzdWZRelo4Z3VjVDVXcjMrM3REa1l4T0ZsUTQwOWs1QkxPUnAzdGtlakk5?=
 =?utf-8?B?RktTRU9hcldiLzlqQWdQNTMxdlRJWWxDUEJhaFVSN0xYME81eTUzZkY1U3A5?=
 =?utf-8?B?STEzTDJDN1VhN2YyVW9tZjR1dmhJOUw0NENvMHlzZzJleVN6aXZ2RXFmLzVJ?=
 =?utf-8?B?b3MrVTh5TE5vSXlMWk80TytaSFRRSlc5QjRhcTNhM1RIM2ZEMjR0aU9Cd0F1?=
 =?utf-8?B?YkxBU1JLcmlGekJNTzdmK01ZK3hlclN4a0ZVYXFYL3RwVWJYMW9Sb2I0MFFD?=
 =?utf-8?B?eXV2bWpNNU1GMDIvQjVkbzl1cnVSLzA5VWxqcTV2MDZld3I0MmhRUWc5YnI5?=
 =?utf-8?B?M2hMQzQvbkZ2b2xYYkhBY2lVWENhdTk2MEZvWkk3NGhZNjF4QW5WbnVrcjQy?=
 =?utf-8?B?WmsrV2pOYmlEeFBOMXBoVEtxaE9ETFpmYnkwSTRSQkp1c0ZQVDJHYnhyUVRt?=
 =?utf-8?B?VTI1c293enYxbVNRYTE3cXAzdWlObTFjalRMT0JuZWlENVE3UlFKdUNxMncr?=
 =?utf-8?B?TWxPbEZpd0tGckhvY3VVOC9pblJnL2ZZdGZPYThub0FZNkRqSEVWay9NVU03?=
 =?utf-8?B?M0psSEVrc2hrc1o5Mmxzb2tJRkpSUW9TQ3Bxeno3NHNyUWlXL0VSNjBOQWRm?=
 =?utf-8?B?eVNQVmZZY1lnUnU1dklSdUtDNWt5ZS92Q1BiN3BWU2JiOWVRWHMzaHFQOWxn?=
 =?utf-8?B?WEl2eVlSSWVuOG1SQVRwc2JPY0xGSVhlWkRtL0crRkhXcFk5Y3YxQmZZaTZn?=
 =?utf-8?B?Vy9senZkWHVxWGtkU0ZkQ2RlSE9HalQxMWNyLzVXdUVXREZDWmRobGljYm12?=
 =?utf-8?B?UjhLaytpdFVPLzNXTlJ3dGRYMnF4TXRFMCt5aytRRGI2ZXo4UnhGUzZqNnFV?=
 =?utf-8?B?Q0svVThBRlcvVE1hMm8wOU9ncmp6RWZCRFc1bkdKR2FjMGFRVHdmOWZPTnJx?=
 =?utf-8?B?emFYYnJGejVoY29UbzBGb3VpKzJzUEZ2YStRTGhSUWt2YS9WdVlpWXBCV0Ev?=
 =?utf-8?B?eU95ZTV3T2lhR3M1Vk1YMkp2RUpuVXp6WGpMV1VGVlVGaWt2UFM2cWJWVFZU?=
 =?utf-8?B?WGZPblBkb3hOaytmVDFQSWxVenpVM0NSMjl1T1U1b1NaekhDUDR3TjJsdzVq?=
 =?utf-8?B?RmNKWWluOG1wM0JMSnNrMTNVUC9KYnltMkljMkxZMzhyN1I1V240em5jaG1V?=
 =?utf-8?B?Qm40M3RTaUhxalZJWjQ4Skg4MDZJUzNXbzk5MXhZY2VPd050TExZMUlHdlVD?=
 =?utf-8?B?WVRFT0MrMndUQi80Ujh4NDI3ME54RVZydjNpb2JpS0Z2UzYrWGp3RmFld0lR?=
 =?utf-8?Q?UAfc3kobexZdhHKCgAeSNik/i?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ef54e3-f076-4b2d-d264-08dbd5ff692a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 08:41:56.2671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVjjpBxYx8JgfmUnAmG0zih0pdpgf5qVQGxx/fwqWe5qDydwGkO9Lp+4oWa2t/bJvbnInbe0qssIApLuSp9stg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10309
Received-SPF: pass client-ip=40.107.14.108; envelope-from=den@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

On 10/26/23 09:06, Cédric Le Goater wrote:
> Hello,
>
> This series fixes a buffer overrun in VFIO. The buffer used in
> vfio_realize() by qemu_uuid_unparse() is too small, UUID_FMT_LEN lacks
> one byte for the trailing NUL.
>
> Instead of adding + 1, as done elsewhere, the changes introduce a
> UUID_STR_LEN define for the correct size and use it where required.
>
> Thanks,
>
> C.
>
> Changes in v2:
>   - removal of UUID_FMT_LEN
>
> Cédric Le Goater (3):
>    util/uuid: Add UUID_STR_LEN definition
>    vfio/pci: Fix buffer overrun when writing the VF token
>    util/uuid: Remove UUID_FMT_LEN
>
>   include/qemu/uuid.h              | 2 +-
>   block/parallels-ext.c            | 2 +-
>   block/vdi.c                      | 2 +-
>   hw/core/qdev-properties-system.c | 2 +-
>   hw/hyperv/vmbus.c                | 4 ++--
>   hw/vfio/pci.c                    | 2 +-
>   migration/savevm.c               | 4 ++--
>   tests/unit/test-uuid.c           | 2 +-
>   util/uuid.c                      | 2 +-
>   9 files changed, 11 insertions(+), 11 deletions(-)
>
Reviwed-by: Denis V. Lunev <den@openvz.org>

