Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0849373DD92
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:32:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkRm-0008BT-Q7; Mon, 26 Jun 2023 07:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qDkRU-00089c-4T
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:31:36 -0400
Received: from mail-co1nam11on2060a.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::60a]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qDkRR-0006Jc-Qc
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:31:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1K8ixWq+E42RRvVuBybGtqQXgXKfijGJPHN/m6JyCVuV5CKC2r7YD4/m/v+RtbQh7tUU+Nr3zpLkOxV0ppSvR/OWETI1ijymCD22uX9lNhOT4oS8lAGNB88GKBm5AEUFZUy/vpZFZpEpJ4NV2SszJDSUl+8bFHu/76EQ/LY6w5r0jDT6xwS2GxiwprhLgpj2f4JSDinLikeUScBirdVqsEgwxI/3rOhJexTtj4OYvr/tuu6mHAeVTojAVTCM1t5kv/K4KH8AuesRTEkNgbLO5bAS5BmHdccatzNdaCU2CiYdy8SsGLXr/NKRPYTXMZnnHq1+Bhs07ip2OPWudd/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWnq54NroXaxLexxM/c0Wp9Qh0COzLj1TjkY4jlt/Sw=;
 b=O2SJRELAskRoDcB9MJ1gXiVSSVTrzfzmI3OFkbmIoj6MvrLZixiLj975TACleipNGu8mGUtFXdheM6PJjHog0OMxOUVgZlPdvTzjxqM4LW/nA0t4awpHJJKwoI7sujO6CMl947GVB3uuN6O0Da6Tf0zw8ds7GeJq/82T6idbvM2+CFh38FpL488NjDAdQ2OYr8BABEOkCKMKFwtKVrx8z4q6WQ0TnIVdXtB3d1uIlo5WKfbY8w7rkyzdwI6YXmv75ge9CEXPifvHqZcEfFsfYwLDZw0nTx/JADCwsdfgGxOXFjYBpd6r2He+Y35ptvvRoopWStDBrVubTZ8Fv6uqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWnq54NroXaxLexxM/c0Wp9Qh0COzLj1TjkY4jlt/Sw=;
 b=ikByy8WV3+kyA2DctQ7ycwOXncYsc/moLSD3G54WDCAXVUr9KB7dluFfAWvmGFbwW1QL60u/CSi79rnZQIj/TffMWubYP5SrjRBtObxEbUryNZ1MptZ3UE7bXjq6rN2JRULkvxu/xNpV8L1szUUwKy+9iRAHlJz/0tV7cfsauS0n0IAvuHWH1H77PvWohN0mTnBntbiY6UszBEFwTdwyi4gcA4flMOreJPOmo8YTxKI66yZJ9my51he/KPvxSggtgsMBZ0FfsdWbCp518fmcnc3zS1iOtCps3uTqWW++Ny3D4ZD/tOBTONfRUfxXiveh61yMkc8MIuVEcawYYJa/dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by BL1PR12MB5189.namprd12.prod.outlook.com (2603:10b6:208:308::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 11:31:28 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b%6]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 11:31:28 +0000
Message-ID: <9ea51626-4f54-2cb3-c9bb-f99c79183bb9@nvidia.com>
Date: Mon, 26 Jun 2023 14:31:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] vfio/migration: Move from STOP_COPY to STOP in
 vfio_save_cleanup()
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20230626082353.18535-1-avihaih@nvidia.com>
 <20230626082353.18535-2-avihaih@nvidia.com>
 <3b6a527f-351c-8979-c15b-0dc0a8fdea11@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <3b6a527f-351c-8979-c15b-0dc0a8fdea11@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::10) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|BL1PR12MB5189:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa30078-376e-4056-eca1-08db7638e202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qcUoril7DoLeo1x42H5O+UGjD6AUwKJ2iBhGZtn9quAnB8mDrBBA8+RxpIYWpvZhzc1kpOSGbpltnPIyo6wwinpETJ2c9NtGbvWb3JM4tEjq34Bs98phxfQYljfB0Acxa6ZZPOOmU44BR4RYbiiJuDonKRhXRpsJlo/YNtYOzKlLFJBLTa97mfDMXvuGMeQL5zS2erIaD+y4G7HUdNLGYjT6hmE7pavKxAnQGTZSJwYshAFgjAIs19HEYzMtFaYXtOWnzNYuhScbyv37B1yP/sp+04P0dHYy/2TVCRiK7P/9Eei5NQ0ZlwjcoMfGgt8DszCEQ2R6lD3AUioD2bRrmV8NqPslFnowtbfDjt8QMFv3YhHTdr3Ha5FzXu09JZEaMUMHwIWDX6X3Bk2kUTjIUBKj4cVWdpW4kqRBNsKusz/89fy4Xm2Dxis1WZHAVM2ORkmVuzvtP0hF8fawNm9bESiWrVJ6CbHX3IPrCfgTGOxQnR3Gul0D8KEgd4w1hOTXHBfoAAlSydCfDZSZvlJ3I86jKm8racPeqskdC+3JvtK1Sns0cbeCu7F26BcH7FAsK5bA/w8t+CwU16X1ZUH6Om+04w/sLqDyPgf05NGCzjTcQegA5PnuAfV8yhgD1PMPQxpDVDdbGKTaTYcRdUxHGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199021)(31686004)(36756003)(5660300002)(8936002)(8676002)(41300700001)(86362001)(66556008)(66476007)(38100700002)(4326008)(316002)(31696002)(66946007)(66574015)(6506007)(26005)(6512007)(53546011)(2906002)(478600001)(186003)(2616005)(6666004)(54906003)(6486002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE9GbGJwUzNTckowYmR0Z2lUemh4blVjZndENlVhOVV3WVNXaFI3MnA3bWI4?=
 =?utf-8?B?SExkWEEybXZPWG93a1FPcWMyK0lQdTJGcXY0RTdpN3N0Q0p0ejZYVStoWjI0?=
 =?utf-8?B?NFhneGRtQTZEYjZZZ0tNMkFGQ2x5M3E1MTlTUEdRdVN2aWtYUmk4RDc4bWhi?=
 =?utf-8?B?MVRuTlUyZDljZE8rTmVKZUtabUFtL3BWdG1XNloyNHRtekRaWDgveVJFNDdj?=
 =?utf-8?B?ZEM4U2xRejFieWJleERUdituanU1RG9ud2NFT1JVYzNPYk0xVjZ1N3Vid2Jw?=
 =?utf-8?B?cXl5T2JNWXNTV3UxQWlCTVdZSldBK2dpRys2MkhqK3FvdEtwdCtDbkVucEto?=
 =?utf-8?B?cUYzZ0hwWnJtRC81THV1aGQxbm55OFdid2p4dWFKY3RGd0ZJR1RuNGR0SHM0?=
 =?utf-8?B?WERVZktYMndGQUF3d21yRjZELzhyaG1pMUhITDlqV0xML2o5NWticy9sSnk2?=
 =?utf-8?B?QnVaS1lWZ01GZm9CekVRUVkyRDE1Wm5CQ2g4Rmh2K1hOYUNQbEtzTEdrTGJY?=
 =?utf-8?B?TGkzWEIydDlUcjA3MHZScG1FeG1INGNBSHJxWjR2OWFaRWkvclNBS2VwYTQ1?=
 =?utf-8?B?U25BS1lDMHFMdjZ2MGNnSjh0ZE41WkFzMDBVK2pZakZwODc1MzE5dVlOcXgx?=
 =?utf-8?B?TUpJTkZlNUl6dFRIemt0dFRDQmVYVUFTbXNTSWtTNzdnSEVvZUxPQVl3RTNR?=
 =?utf-8?B?Y0xIRW12NW15TGZ3MFVHYnBmR3RmaHUzVGorWnllaG1iOHp0WVdlN0FQYkhE?=
 =?utf-8?B?UlBjcitSc3VrS0JjMFZ3VXJCYjdCbHdmZ1oyUG0vYXhrV2lmRTVlVG5TOXhu?=
 =?utf-8?B?c2VPNk9HOFo0SE9hK1BjWlcvM0Y4ZEc4VTYxcitJOUVYN3hoeHJOcEtvaE9t?=
 =?utf-8?B?VmlmUzEzbmtJaEJ1T3dPZEFZUmg0bDJrT2RyaEpyaGIzRmpEejNucjVGQU5q?=
 =?utf-8?B?VEtDTlYralp5QWtFYmlqeXJiWGZ3Z1BLV0pNTEppam1uSGcwcE1ZaG4ydC95?=
 =?utf-8?B?TVZyQ2ZKZzg4eVB2eSs2Z0ZRQ0V0YjZPU01VY0ROakR0MnBmbDVOTEtZcGRY?=
 =?utf-8?B?YzlLRlNFQVlwWlV5blppMUpCZmRyd0htSWFlTXdZbUlXODVTaE0xVWRuTTV4?=
 =?utf-8?B?cEFScWk4aksrZEtEdVhnR3dOOEtrRVhVVTZ4cG13ajZhZThFUCtDSmR5SElZ?=
 =?utf-8?B?SUxmM05NeExmNUlrdGlocnY5akFTOHB5RDhUcHE2S0JYSktNa1pEMGk0ZWNI?=
 =?utf-8?B?YllzZkZ0cklKcnlFV1JRWTdIMXVMdEVQUGtwR08rd3dTVWhxQ0RhQlVOakdq?=
 =?utf-8?B?NmlZNWpsM0R5NFlmSXpLYmFEVnIreERkUjA0Vm90NWVUR3ZySUgyaGNuN0VR?=
 =?utf-8?B?MTA3YU5QcExTRGlIdENxQnZzZ3pWclFjU1RKWGsxRC95ZEgvWmI3QUN0TUlL?=
 =?utf-8?B?TzV5eFdmUWRzWFRmM2ZNeWNxVEhhZjlLcDZPbngwSzdtNm1URjN6RFN1VTJI?=
 =?utf-8?B?THRJdW9pMmhWTEN1Q2oxUzM5WXdTQVQvaG5od2RSVnUxb2M3aENWUkpTTDVH?=
 =?utf-8?B?Z2VUUW5tTkxENU5JcUJTYkwwS2lWK1prN1YvSXR2MmpJNmtOcHFWWDBadnMr?=
 =?utf-8?B?V0ovdWNkckxDeWE5ODhrN044SjRDTXdEcGxBM0RWalQ1TWpyTDA2cEc0WmNG?=
 =?utf-8?B?RDVxaStNSElZNHhOZXNuMDBpUGRwcWlSNEZvelFXY0t4NWpxUldHQ3psZkZj?=
 =?utf-8?B?L3laUkVnM24zNUNBU09rbDMyaU1DSUw4aG9PY2RxbG9jUDNlR0Y3UHZEOVJE?=
 =?utf-8?B?RFdMb0x4S253bklDU212M1QyL2JER1hCV1owSXViQWUrOGFsakFYTnpWenk1?=
 =?utf-8?B?ditMR3ZPZXkyRU9Uc1ZHZUwwYmVFM2ppVVpsSjMzbFBHSlRHS3VTb3NFNE9q?=
 =?utf-8?B?Q00rQnhycEtPa1VlcWFRcU01OTRmdytUUGtKT0ZrRWVkcDZFZkw4MmRYcnF3?=
 =?utf-8?B?dmJrS0V3QllGcXpSdjNOWGpSS20xdUc1WnRHNWI1ZXdZb0NUUU52VHhnUmZF?=
 =?utf-8?B?OXBveFB1QUR4UzV6dXJpU3ErMEc5Y0lWS1FpOUJIYVhpWGUxTGh2ckQ1ekRF?=
 =?utf-8?Q?qOuomtdGfZBOB3W9VnaLojviX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa30078-376e-4056-eca1-08db7638e202
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 11:31:28.7869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPtZ6jsq3fHGlXDoD2Ms/pFvCYaAYLI/+nM/gFBBFzeWWcsWqnSbxo4ufszXshXeTWoyaOOyygOhsbWMJ/Ee7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5189
Received-SPF: softfail client-ip=2a01:111:f400:7eab::60a;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 26/06/2023 12:56, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 6/26/23 10:23, Avihai Horon wrote:
>> Changing the device state from STOP_COPY to STOP can take time as the
>> device may need to free resources and do other operations as part of the
>> transition. Currently, this is done in vfio_save_complete_precopy() and
>> therefore it is counted in the migration downtime.
>>
>> To avoid this, change the device state from STOP_COPY to STOP in
>> vfio_save_cleanup(), which is called after migration has completed and
>> thus is not part of migration downtime.
>
> That's optimization and
>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   hw/vfio/migration.c | 19 +++++++++++++------
>>   1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index acbf0bb7ab..a8bfbe4b89 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -383,6 +383,19 @@ static void vfio_save_cleanup(void *opaque)
>>       VFIODevice *vbasedev = opaque;
>>       VFIOMigration *migration = vbasedev->migration;
>>
>> +    /*
>> +     * Changing device state from STOP_COPY to STOP can take time. 
>> Do it here,
>> +     * after migration has completed, so it won't increase downtime.
>> +     */
>> +    if (migration->device_state == VFIO_DEVICE_STATE_STOP_COPY) {
>> +        /*
>> +         * If setting the device in STOP state fails, the device 
>> should be
>> +         * reset. To do so, use ERROR state as a recover state.
>> +         */
>> +        vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP,
>> +                                 VFIO_DEVICE_STATE_ERROR);
>> +    }
>> +
>>       g_free(migration->data_buffer);
>>       migration->data_buffer = NULL;
>>       migration->precopy_init_size = 0;
>> @@ -508,12 +521,6 @@ static int vfio_save_complete_precopy(QEMUFile 
>> *f, void *opaque)
>>           return ret;
>>       }
>>
>> -    /*
>> -     * If setting the device in STOP state fails, the device should 
>> be reset.
>> -     * To do so, use ERROR state as a recover state.
>> -     */
>> -    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP,
>> -                                   VFIO_DEVICE_STATE_ERROR);
>
> we loose the possible returned error.

Right, but vfio_save_cleanup() is called as part of migration cleanup 
flow after migration has finished, so I don't think returning an error 
is useful here and the error is still reported in 
vfio_migration_set_state() so we don't really loose it.

> Let's keep that change for later.

Sure.

Thanks!

>
>
>> trace_vfio_save_complete_precopy(vbasedev->name, ret);
>>
>>       return ret;
>

