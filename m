Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED73713979
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 14:49:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3Foa-0002JY-FU; Sun, 28 May 2023 08:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3FoX-0002JK-UL
 for qemu-devel@nongnu.org; Sun, 28 May 2023 08:48:02 -0400
Received: from mail-bn7nam10on2080.outbound.protection.outlook.com
 ([40.107.92.80] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3FoU-0008BH-B9
 for qemu-devel@nongnu.org; Sun, 28 May 2023 08:48:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCFlVoXstcukQPk+Rwm+epLXuIwTc8Jjne2Ow+hgwtf12GMIZMOj7vJGeUV3XrE8GJoQXS9U4qN24aLu3WDkHWIZCf/RxTVjV0vnvKTuvjnCxjU31DlWN55d6iSMIBuINWWLMUfHdKcJghG9oj/a0zTsn3ZM39ChgAEdFMIvLCvyjQEk6mMaLgqHDzgGI/S4+HXxQCShL34J4/PgKp6WxjkqmGz2o8adYYbu+AnxPTh4gfDkGcUev6HFYO3H0lO7KNaM1wMUrdB9018LcdJPgygLjLwOlZoHidrgoczgALcsEHnqN3cEscawIDKxnQqjHiiFA/Udqi1xgXnQQpYUUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4kbMyzdVloI/Zp/72cM9OtgG3BsewI7aPgUAglEAvw=;
 b=Ax/8nUdF05hwG75sCaevX0I87UjDCwk4Ct2j3pDLXKFwOkIQNbEkE+Q+v3HZ18HqubZk6rntdr1ODYr99PFIomag3lhgi5auw+KTexRGCOPLbjyK+ivemQIueDiZd+JwrX/7aQaTNJywB+eAeOAOCZ9RbBI88PpxG6FS9OcSgwynSI2IJMWV8LGNKbaY1uviXm0YIMaEUWR985b41NnjsfIO/9WidLAR3l3Gcf9BLrZSmNdw4rBY1q3LlCkY8xqyCfQQXrH08973iMsdQuCbumw5JyY8vBOlsQ1eOEfaxsx4GVXNmq4B9Ve/lXyAxAPeEQLH12GGdaYnjb97ugTyzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4kbMyzdVloI/Zp/72cM9OtgG3BsewI7aPgUAglEAvw=;
 b=Oaw4KkDJrRudAGdNge6nTjlWEsgjarvUvM+rp6+FBKLDP5LosLYjobVEwTguQUdMbAPzXsw3gGgDmuqsBH1Onswwz/lWGR3Ez+CEIwrm0pzHsa8+SI3uNi4shEOANUDK8yi/MVsoSDeUhF0nHm/LaxVVHoey8HO1fk8mMsg6M8Buc1L28ATJxN4M24AR3Oh4WJGwbpVEEWNTTeu3c6zSe1h5e7LGcIHAAix+IHkQbGVPHHpd9ueMAzeX0GJPNil0n1AkFWJGBw6JuWQwPjDuGuudDTxDcteiXwJS56WEASyRsqpbcRpkJIn0eNlD+PVLkYchZIjmRtM10JDWw/X6gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Sun, 28 May
 2023 12:42:52 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c887:8186:c2f0:d7e6]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c887:8186:c2f0:d7e6%5]) with mapi id 15.20.6433.020; Sun, 28 May 2023
 12:42:52 +0000
Message-ID: <32bade47-89f4-ec42-e805-0b7c59a32aa4@nvidia.com>
Date: Sun, 28 May 2023 15:42:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/7] migration: Implement switchover ack logic
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
References: <20230521151808.24804-1-avihaih@nvidia.com>
 <20230521151808.24804-3-avihaih@nvidia.com> <ZG5mOKlGtQEyywyQ@x1n>
 <541dc36f-618e-a2c5-a27f-51db65abecbd@nvidia.com> <ZG9YP45oULV3YJl4@x1n>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZG9YP45oULV3YJl4@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0091.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::10) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|BN9PR12MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a8c9b40-24cd-40b0-e4e6-08db5f790ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6CyCwVbaTXkP9Fe+lF7eoPe0XRPI1VrNN9IgatZRsy7onxTzAWFdLHuFXn+Q3rcfqglXfHnHyUXTEDru/rlWGW+zrDILb6Z9MGeK7TNHioSmYHmFQ0i7AZkmqELXHeItNz2OV/LtmrMAVQ5assYEF/fGrpGOELUU/69vsZFCgTeCVqOVZFPRf+xYqZnYBQOzdxRnru3R6dbV/bfl90dvokqT8nLjkYb2tE6He6uGuNMOhTS2zHDc2BBAqa+7VyjOnRCLxwL1FqquO7fuvK3BhJQzrlQkIAUMKQkuck/4cBXrA5W/bdmWElvW/75TPw+ws0XM87iwszyNjmirv5yxZynfyBNt5X0x9yj/MNy2JzxzDhAmsEvN6qYPGDZnIba+UCQ4R53xVUIeg1DbYsT8eWrYPIBm2qgNj+r9BEN6dFUss6exsmGk5UqrNhD8c4keBP9455p5zxNo00o3B9VDm3FEqVgVOprpFLPAEosMnhKX4PmrEFX6CH1dW5pKm2BADhHc3qU8zl5lchoxI/2l8cCkStP6eDp2KdP0BKJPoyVVJjLI4+o3lq3qeg4leudBdEqC+yfaHCm7Uu+sDJzqwXCe2qlKfW/DX/09qtZT1zsLhvgTCRnVp34rsJ7hVr2AplJuNZmNdZ1EFiOSk7ohSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199021)(186003)(53546011)(6512007)(26005)(6506007)(31686004)(38100700002)(41300700001)(6666004)(6486002)(83380400001)(2616005)(54906003)(478600001)(4326008)(66476007)(66556008)(316002)(66946007)(8936002)(6916009)(8676002)(7416002)(2906002)(86362001)(31696002)(5660300002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajRLakwzMUFFMmpCOEJsbFpyQS9lYld3VFN4N1lBRWE1K2ptNEU4VElsdkkw?=
 =?utf-8?B?cnVnWTl0N0hscWJzNCtFb0xPY21wZkRHUGxNM3JuVE9FQmduZ0lrRzYxMGly?=
 =?utf-8?B?SHl3em1Lc0xNb1lZcnFXYWRCanQ4N1lXS3FMaSswY1dKRmVINEtlbURTMThn?=
 =?utf-8?B?WHVMeEUwQkFXTXpSU0NLRk9rdmhzKzVKUVBSM2R5Ly9aQ29xWmJRR0o0L0RT?=
 =?utf-8?B?Q2pRUmU0blFpT3l0TXFmQW9GOTJRdEhFbGhDb0JWVnBpbUdHTDVVcW1oaHpG?=
 =?utf-8?B?c3ZkcHE5Qk9uOVdrbW83dUhVY3FGM2NWWkRmMGgwRHRlQlpCVUVSdFRSMm1B?=
 =?utf-8?B?TEhMV2JTRVhjVzFiY0xOS3BnT2R3Mmo5TlR3N2FVYWI1QXVKZ1BLZzJRd1V4?=
 =?utf-8?B?Q2IrbjBPRTZSeEZxcmExbFZEc050YWJnT2x2VElNOE1XZm56WHk4RFpKb25G?=
 =?utf-8?B?ckhldzFiSjkrQTJoV2t1S1VPZHllWFhjZVpGdDZHM1Q4U3gwdVNkWHJTaU9Y?=
 =?utf-8?B?VXN5VDYzc2JZOGYyZ3NFVmo3UVpsZHlhbkJkMlR4MmhpZCsrUUphdDlUeXBo?=
 =?utf-8?B?aG1zR2JXbW1sNldKTFBsRDlrNWQvVk9hWmNIL2ViTXY2eHVGcjNnL25CelZw?=
 =?utf-8?B?MXMvcmFoWVQ3ODFobXBCYzJJcmVDNHMvNXhXbjJlMlVOcGNWK1RCbHVKZGRN?=
 =?utf-8?B?TWJNRGhldS9VWThWWVFUTXBBMi81UnhuQVh6UGt6QUJGckNTRTltazhKMVBi?=
 =?utf-8?B?OW91djZxeE5RMngyVitia2tiK2JWODJ2dzd3L3JhbURGME50VFVhdjRid0o1?=
 =?utf-8?B?eklPaGRjYWdISmVVZUFyWTExOExsNXdVVTNTaVo2R0VMM2VxNEk0anYvZFlX?=
 =?utf-8?B?N1Y4bUVoN0U0WHB5NTVTeUMzUE5PSXpRaSs1ZmhIQWpON0htdkpibjRIWXVS?=
 =?utf-8?B?V1FMdlBnNWhRemMrVXBDbGowRTBVL0VseUxDc09NVU1nTERxR1VGSHNDSEQr?=
 =?utf-8?B?NGZkdzFFUWZoaTdtNUlxcDI0cFEwRWJ6aE5EbmNPays3WGxrUUtIUUdaZ2pa?=
 =?utf-8?B?VE0reEY2TUNPeldSNWlRTDJzV1dndjhsZG9XL2hlNkFvTXU0dnJCSER1R0Rq?=
 =?utf-8?B?NTRFWW96dmttb2Zna1JJTXFFWXNURDZxdVY3blBISFdQT1Q5QVhHS2hXR25v?=
 =?utf-8?B?QWdtcGNJZFBtOW53emF1WnFCWkhldjI0WFVPc0RwQW93Q2RJeldZZSszN0sy?=
 =?utf-8?B?bkMxOXJTSGV4UFo0UXRieVdqQ1FiT3hQNWZ5TlZURjU5blhVdlFiai9LL1Bq?=
 =?utf-8?B?Y2ZWUmJzTzkxd1NUQ0J4ZDlEYVJ5VkhoQlNEaWN6STBHN2d6bzB3Y1RIeDBi?=
 =?utf-8?B?YkMxaW5weEYxT2FIRXU0Ty9saEFNM2JRV3I2d3FRNGI4MzBma3hOTTVYamhl?=
 =?utf-8?B?YWgyQVhQd0VnSlpZK2hUL1hiazJ4eFF6T0V5aHlUK1JmTzkxNEp2YU5KYnhF?=
 =?utf-8?B?Tmc3eUNndHZaZmN2UDkvUS85eXF6dTV4Z2tsVWkwYk9DWUJxcFh2NGVKemt5?=
 =?utf-8?B?VklWbTJmVWx0Q2RicEJEM2lUdHpaTnVYdGNxUEZJMWpaUWlDVXFUWGhDODhI?=
 =?utf-8?B?Wm5QODYzL1k5YytycjJvK0crSUVjSFJHNk14STloZW9JQ0RubHBQMktXRGJ2?=
 =?utf-8?B?SWxTancyTi90d3JrRDJqRmlEK1NBVDRDRCtVV3gxcStabWFFdms4UGZMMkRv?=
 =?utf-8?B?SGk5cTJNaHd3NlhQc01iM3pHRGYzSmxNUnFWTml5R0pCb2loTFBQZWw1b0hp?=
 =?utf-8?B?clQrMndCNWEydE1sUDRkSnJVQlhKR01Dd1Z2Y21Bc0dqMnZyMW9HNTdFRlNL?=
 =?utf-8?B?UUhwQlhCZmNHM05DcmFVZ1VEZERHcVNaNlFPUTBYR292U2txVVAxZ2RsUEYy?=
 =?utf-8?B?bzU1TXF6VllrMXNjeFNOc0hraUtpeE5ybXFVOVBYUExpUmsxUUhJR042OUNH?=
 =?utf-8?B?NnB0RjlEYU90WXhZVmJDUGtlNEg1bjFTWGgxbFU4bHBNaUpjZ0tTU200aUJu?=
 =?utf-8?B?Q0tCTlhyOHFNNVY2MStNaytFNWhGZTZaVnQ2ZEQvYUcrWmxNVkJZNUZWMkRp?=
 =?utf-8?Q?mvIO28Agu9/HCCRKp+RJHo0cf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8c9b40-24cd-40b0-e4e6-08db5f790ccb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2023 12:42:51.7602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6EV3BS1u5nzJgBtWev+lU/n6TrwjHkfidX55KjKg/5vvaBFCPVeTIPYbd/JyfpwWmYSQ63K99Uy48J+5QfCZXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5179
Received-SPF: softfail client-ip=40.107.92.80; envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 25/05/2023 15:44, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, May 25, 2023 at 12:51:46PM +0300, Avihai Horon wrote:
>> However, there is one issue -- we can't send the ACK up here [1], as at that
>> point the return path has not been created yet.
>> A possible solution is to check for mis->switchover_ack_pending_num == 0
>> when we create the return path and send the ACK there.
>> It's not as clean as checking the number of users and ACKing here in the
>> same place, but it works.
>>
>> Do you think it's OK? or do you have another idea?
> Good point. It looks fine to me as we create the return path mostly at the
> very early stage right after the migration headers.
>
> Let's just add a comment describing the ordering fact?  IMHO it's about
> switchover_ack_pending_num won't be used before setup of the return path
> due to current wire protocol (we create return path before sending mostly
> anything else), so setup it there is fine.

Sure, I will also add a comment.

Thanks.


