Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A500D78C90E
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:00:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb17m-0001is-2t; Tue, 29 Aug 2023 11:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qb17i-0001d4-O3
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:59:23 -0400
Received: from mail-mw2nam12on20605.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::605]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qb17g-0000xc-4O
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:59:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QW53CVWAQrhPevdoQO3b7rHoGLudN75yYMo9q2nkrE8DEIwPubRM0OIiAGNyTpFHY6lh7XkWXMzbWzoFnEuLdh9m02jobs489MJ+CkLy+Q/x+SpnSfa6v4NyUfLOsGU8meTXERqD1Nx67gHnVunYYNfWW4PhbQRn9LDAf0jSl7iQyM2jx60mLbHUcN/sYGpSpU4XDySjtCnfAmahAv8nDGYVNuC0wR9Lg6yQTPUx/EJZPbtVOQRcbaHMZo3iw2d38BbNfGCa+qvIvBG8aTAcZOiEDAt/WjTmmyO5Fp+jMoXkuL0HZs8oTxECz4YbhZKDKVfAJOHK7TKdz6K2N6yhpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2XyU8W2sbQ7zYYJ2tqraCv4xSC2M98PqHXqqD/XrWA=;
 b=XqmyA6CEcm42hqmfgqEwle5e4Zkg5VxF9/9VX/gg94aObIK8ntl9/QH2LuT/x5sMlVT8Gzx0TO80QDZm4TQwBZyz4SbhNJnw8+gOUwtYFEtP3pQPOWv+xfTNM5rqIFp5Va3NJ5pVvea7mBIp6Cfy2Jqx2n+0QiTUsbuEgzO2OagtQz5gmi1vqqKTWzMFcfubkWFK8QNL0PWni4eYrg3YnfdluRr5K6ZPkCINrLbc2ZQPTI20e0EFWRBK9EcEB3IrG0Q4eeMMAyvirjoQ+Y8/YizxtPWMGntk0bhp6VYGALtbrl9zae+l/EDx45k/MMuN50DE/Sp9rbfS5n4aioVqgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2XyU8W2sbQ7zYYJ2tqraCv4xSC2M98PqHXqqD/XrWA=;
 b=jiqmDWrtoPOeI87irSNTUVtrjde+9cfuJIERPrQ1PFl5fRFyrFhEaFUQFiDIeA+FLLJz71Ty4qLKc5xoE9aeAzLpgDVqKk89AHW52R+fhZ9CJ6DDQEFywIkNoXyQpu7FLNIqinfzkJggNEuaxN9h69IU8ySY6NQwNmcBDqmCKev/dWDl6SXFPgXO6UlFq+vIQy18eSmGq9yzwJ7f89cca+1jju6QeOUDBHbNM5ezUUvxtsdV1otOkfoV5zMXVrOV9Xj4RslHJnKith0aYg1KqPSeRygNiP+bdmqSbOjmkwym7f/FdYwZ/Z825KyO3QWO+IbWWncTXk5rnYtQWiZGEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SJ0PR12MB6941.namprd12.prod.outlook.com (2603:10b6:a03:448::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 15:59:15 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96%4]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 15:59:15 +0000
Message-ID: <48da3061-4743-7759-2c68-001edd16e63a@nvidia.com>
Date: Tue, 29 Aug 2023 18:59:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/6] migration: Add migration prefix to functions in
 target.c
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Yanghang Liu <yanghliu@redhat.com>
References: <20230828151842.11303-1-avihaih@nvidia.com>
 <20230828151842.11303-2-avihaih@nvidia.com> <ZO36+h2p/X/LCG5B@x1n>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZO36+h2p/X/LCG5B@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0309.eurprd07.prod.outlook.com
 (2603:10a6:800:130::37) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SJ0PR12MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: 25cc92b9-7876-4d47-b4be-08dba8a8e4fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OmK5EV0uJiwQH/yoH8nVi//oLg3QbUKu6tA6Zl0sPlVMf/Iyv0nFsVoYQ5gUwZYDgD2ckKRwYRkZSnXyMZ372uZv2uwNlG3/yv0jiOwUtWcnRLsQ1rP7AB6qMZdoyxarItGbX28kC0uSxobHMXvhfhZUF86UXp5qUKCf54DtglTj8xz+tuWPZ+Qqtn5T7l3IGscyqDOizVTDO/hmwPBJOsTeSzI4FqkthQlIEI9J3WXt47URumNxkjJWO4RusOFPl3TntbxvwV0w/lBRFPMB2eBQGNPTVtIpwGq+TF3ja+gXYheQbkc6E6TJFeZpfap2Ov0hflEdM/TPLzb07ZTU4I4hXS9kOLKox/CXE1Fpy2pPYw0hSjgp9No/s/Vj0B5Y/U4uyYQ6MJp6VWkuhSbU+a75o3hzXMBvgfoSbVqtREOBTt/CJCtJWpjftd3I4ZTTLHFYEjh6QKwojGFv/OgCmhiTNedHuoyxN4Cn1OVOMG1jGD6RUbAsVXl7g7E7UO/KWwfANTuA1L2yh03Ftm465lBK6nXOR4rVS6eHNvT8wgOKMdkvSCWmhaTgMnC5Rk0Ccjo7zF3j9uU3rNsbRhVGr5394ydz8U80EPgrSn27sos8tuguRBPNIZRetxsDL7sgP3FY8+Vwlp3hFgQmLbIyYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(136003)(376002)(346002)(366004)(1800799009)(451199024)(186009)(31686004)(478600001)(6512007)(53546011)(2616005)(6486002)(6666004)(6506007)(6916009)(316002)(26005)(66556008)(54906003)(66476007)(41300700001)(66946007)(83380400001)(4326008)(8936002)(8676002)(38100700002)(2906002)(5660300002)(86362001)(31696002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHFRVTJaa2xvUUs0Z1lSVU40cTk3WW9mc0oxZ1dzQTlYTCtJRXFYSzFkY2J2?=
 =?utf-8?B?NXJERlJoNVNMSXRjQjZxRlJEdzdyZGlxbENNYkpFUmhxNTJid25iVHJZVHZP?=
 =?utf-8?B?aS9DbG5PRU9BdkJpSUhROHdvWmJDM3BSaENyeHdhNDl4UUQ4bm55OUNzczFJ?=
 =?utf-8?B?NDhhYXJ6eTk2MGhtUVVOb0dGWTlPZDE2OE5PMzFKUmdIUlhVaGpZRldQbTlR?=
 =?utf-8?B?UGExaWFLcmg2WUR4MVp3Y1QzSXQzeHkwdW1oelF0MWRzRlFiWGs2bEhSYStt?=
 =?utf-8?B?MWcvcEVqTmJ6d3ZCU0k2L2FCVW1MbFBUdWh5dXUreDF4RVIrM3ZlTGxtQXRz?=
 =?utf-8?B?YnRTS0kvMkkzMWg4VS93L1kydmF6OHVHUHE5U2xKRG5GbVl6QlA0enI1QVFr?=
 =?utf-8?B?NTR3M0tTT2FEZjdSSGUyQkJrMkhZdVBvRHZPY1VTSEdibUVwdDhZZDVBRDRI?=
 =?utf-8?B?S2pDZVlDOUpTQXJjZ0thaUZiSTNzdVJlYmRzb0xmeTd3Vm1wVERkeWNPZlRh?=
 =?utf-8?B?WVlPc3hOT2hGR3dkc05yd21rU3A4TExJTCs2ekU3SEIrcS9aaHBockxlUkNw?=
 =?utf-8?B?cEJwVlgzODU2eUEybVFjbXVjV1JRSjZVSDR1SkNVcTFwdDE1b2dEWWlpZ2R0?=
 =?utf-8?B?bmNlM0MrejhTNmowSEFTTGV5eTVUcUEreXdlLzdJcFJQTm1YNUp4eHh3Y3pP?=
 =?utf-8?B?UDdtUDNRSHVzTjhQUXhweFY2a3BlRENhYi9Bb25UaGtFTFJCV1JXRmMrQTdW?=
 =?utf-8?B?S2RpR3JXOWxjVzY1TEdlV0pwYVNITnZ6b0EvL2J5aEhsL21SZlFTamcva0VF?=
 =?utf-8?B?RzhzN0lBeVJUcnB3TlZjdGFtSlVBM2Jsb0hjRkdaZmRxTDVSMW0wMU5kUHNy?=
 =?utf-8?B?WXh2emM1blBDVTJNWVBZNmt4TU9IWVcrWUJ2eHdiS2FrNEVOS29BbFhINCtt?=
 =?utf-8?B?YjVFWWdHL3JjTzZlN05MTDRzMFFueWNTd3Y0dWdoVlJqNS9QRVZCQzNlS1FS?=
 =?utf-8?B?Z2NmQk9CallYd2NLVHkyY1JOM2RkUkxsNTB4VnhyM0JSZlAyRlpDaHllMTE0?=
 =?utf-8?B?VjMrU2Q4aUlkbk9Rc2JmRTk5UG1NOEdXbWFvV1FNdFlVVXZjS1NXYXRZcGl5?=
 =?utf-8?B?cnBMYXBVZTVUM2hRajBOQ1BCUTRncWMvZDM1a2dMWW5oRUFNTzRzclQ1NVpt?=
 =?utf-8?B?UG1uenNWMndjZkYzNjdDQXNkQ2VxdG5naFVoTGQwUUxVZFJpWjVTeDNKU0pl?=
 =?utf-8?B?azFoUGxMeFNoRFJFSk9GYXBSTllSWEdQdHpuSmZXMWxDNWhQT3AxcVVLOS9B?=
 =?utf-8?B?dEQwMTUwOVhFNU93eEZKbE8wYVZYOFZjYlFMOWF0eExDMDFNWnBKTGpKVFpK?=
 =?utf-8?B?aDhhckZDWnZFMmlCdkVXbGRRUWFGR0ZzQ253ZFpjNEhyc3RhZFFHUXBUOVJZ?=
 =?utf-8?B?Qnd6cSsrczFwUWhjb2wvZ0NsYzRFUjF5VU1LVGlSbHBPUE9BbG1jalM0ZmUv?=
 =?utf-8?B?QStkMk1SSXJLUW9rdW1vUXlJOHRiM2FkeUgvVWFPMTQyaVJHNjc3ZDBDelA5?=
 =?utf-8?B?UUIxT2hjekY5WDA4aXpNaFFJM2hJejJpbkVxZzh5SUxoS1BEdnhWL1R5SmdM?=
 =?utf-8?B?ejdMS3hCemNPVGVyL3k0TkxTZlhsOGhyYUhGb2R5KzRIVE5tUG9oVVV6dnZB?=
 =?utf-8?B?MEpsczE0MnBkOHFjam53eHFGS3FhY2VQaVUwR0ZNLytzaVZGOG9ydmx0YkIz?=
 =?utf-8?B?WlkyUkpLQW5QdzBnSmRvMytwQmd3dG1MYlZqSGgwY2FocG84aDFaWnRLeGgx?=
 =?utf-8?B?WGhIWFJldzhBM0YvZnBNbmUrVGlmZEJmaEZDS2Y0WkdHcE16RnM0eHArS2tP?=
 =?utf-8?B?bDI2SVFLdEkrNjdBNVJ5ckc5UEljVzlORUMzeExDUHEwVHV0Y05ValNTaHZx?=
 =?utf-8?B?bTBYeUpIb0tNQ0RJWnllVkNqQzBSYnZGdEFCRFA0SHUvdGo5WFhiMTR0T1lC?=
 =?utf-8?B?dmt6bkt4VVRNZlJlZS9BMFFTWUdXRXhMZDcvZkc2QVZzeVE4SzBPVW9YUS9V?=
 =?utf-8?B?Y2RuZTJRUkxDZUNsYTR6K0YrWTFGZ2d2Y25LZjk3c0FCTUhMbm1Ja1lkTlVx?=
 =?utf-8?Q?8LkpDFo9XX0fENT5jwbb9/rih?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25cc92b9-7876-4d47-b4be-08dba8a8e4fc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 15:59:15.5270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FbWf+op5maxJF9EWPB46hlK/QsifC/ktxwXZ4gVRjwZlsT4YJ2JiVCW8BR4XzgrkYdqQFIGAw3sMTA9yUP+jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6941
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::605;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.242, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URG_BIZ=0.573 autolearn=ham autolearn_force=no
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


On 29/08/2023 17:04, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, Aug 28, 2023 at 06:18:37PM +0300, Avihai Horon wrote:
>> The functions in target.c are not static, yet they don't have a proper
>> migration prefix. Add such prefix.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> No issue on the patch itself, but just noticed that we have hard-coded vfio
> calls in migration paths.. that's slightly unfortunate. :(
>
>> ---
>>   migration/migration.h | 4 ++--
>>   migration/migration.c | 6 +++---
>>   migration/savevm.c    | 2 +-
>>   migration/target.c    | 8 ++++----
>>   4 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 6eea18db36..c5695de214 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -512,8 +512,8 @@ void migration_consume_urgent_request(void);
>>   bool migration_rate_limit(void);
>>   void migration_cancel(const Error *error);
>>
>> -void populate_vfio_info(MigrationInfo *info);
>> -void reset_vfio_bytes_transferred(void);
>> +void migration_populate_vfio_info(MigrationInfo *info);
>> +void migration_reset_vfio_bytes_transferred(void);
>>   void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
>>
>>   #endif
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 5528acb65e..92866a8f49 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1039,7 +1039,7 @@ static void fill_source_migration_info(MigrationInfo *info)
>>           populate_time_info(info, s);
>>           populate_ram_info(info, s);
>>           populate_disk_info(info);
>> -        populate_vfio_info(info);
>> +        migration_populate_vfio_info(info);
> (maybe in the future we should have SaveVMHandlers hooks for populating
>   data for ram/disk/vfio/..., or some other way to not hard-code these)

This sounds like a good idea.

>
>>           break;
>>       case MIGRATION_STATUS_COLO:
>>           info->has_status = true;
>> @@ -1048,7 +1048,7 @@ static void fill_source_migration_info(MigrationInfo *info)
>>       case MIGRATION_STATUS_COMPLETED:
>>           populate_time_info(info, s);
>>           populate_ram_info(info, s);
>> -        populate_vfio_info(info);
>> +        migration_populate_vfio_info(info);
>>           break;
>>       case MIGRATION_STATUS_FAILED:
>>           info->has_status = true;
>> @@ -1641,7 +1641,7 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
>>        */
>>       memset(&mig_stats, 0, sizeof(mig_stats));
>>       memset(&compression_counters, 0, sizeof(compression_counters));
>> -    reset_vfio_bytes_transferred();
>> +    migration_reset_vfio_bytes_transferred();
> Could this already be done during vfio_save_setup(), to avoid calling an
> vfio function directly in migration.c?
>
> Again, not a request for this patchset, but more to see whether it'll work
> to be moved there.

VFIO bytes_transferred is a global variable for all VFIO devices.
Resetting it in vfio_save_setup() means that if there are multiple VFIO 
devices, it will be reset multiple times and that doesn't seem clean IMHO.

But maybe it would be a good idea to extend the VFIO migration info: 
make it per device and maybe split it to pre-copy data, stop-copy data, etc.
Then we can reset it in vfio_save_setup().

Thanks.


