Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B3D74298D
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 17:25:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEtWR-0000zK-6s; Thu, 29 Jun 2023 11:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qEtWM-0000z6-7s
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:25:22 -0400
Received: from mail-dm6nam11on2069.outbound.protection.outlook.com
 ([40.107.223.69] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qEtWJ-0007DP-BP
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:25:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7bnkFqtUoOZ9VN0NJQSP4dHEnwqwhrHTjShvMBlBr17ccEIqWMK7xovm8z6vuDKY+5WHwB25PLn5iPJNZ078/m/rP4GdXHcOxqU0k6TQpwRZYKrLwLUg+VQ9YPDdSH/khrUBtFoWKf0JUreavnvLZV/f8HCB0HoyunqwpT/EzVlSDwHJCD9twcdJK8j5GDVGWqsyg0W59dzG+X1L6wXVO7YucW65FqgCdOh1jnL0/1MInDVw5H0E78OWNK7XrRW49SABsqoAUTlpLKz0uaY3lD+SHH+Jk/rKGdGmkCEUdv8XY5M7Aaekv1qmmD1zG39oZCFfrIvdEIukTDdIZ5ulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPPDyqrdtkDyorsKeAMcC9H5+Uo1Qni1ezEzaw+dS0Y=;
 b=LCnzmms0gO2eCA4dTTlln2YC+XIOhgoL7WcFV3AFAm91s5L+6wx/sVcUpKeEuF8clxHqqNk8Uh7BjiC6a5O1VMP9PHPlrWpFUQc1/e2wkcbVqBhhZPvFyKtUh8fw2tiELZc67GEQs3hwzOeQJJxSjhz3IXZNZl2n/+wTmBhOKMmaRuJCx0IBx4vRo0syVOYySnqza0No+SPQmYpu3tnHnXZRENTwJuDbgUXfmE6eERC5ZoraCUC1wII3ua68pA+Mo4HHUi3LHkT8uHdL1pdLJU0wQbhU9YpqmvBcrlEWUdBHBaKGgbop/yWIydpICYtA/t/gvn+rzjyMLSnhtXxRyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPPDyqrdtkDyorsKeAMcC9H5+Uo1Qni1ezEzaw+dS0Y=;
 b=e3W0MO+hSqT9aTnX1Mr+o77qjqUr6ehSXloZZWoMzPhqDIlR4p5G+X2i1hZUG/3V1UZKGLkXgIykYWpSuRLHCsR10qAs0mD+cZBOp8/CpL/k8yzlAx0jBm2k7EoLQ/MEfo+MpbNxlLaNj3YIJBD1smWvnTx/ykMLr9MIiknGjNdUvgEWxStNFK9lvl7RUk1fd1svO+6LlHJk0Saycm8XL4nyCkDKnOXY0gmrl/5BQY/byBIW4ZxzPxT5y1zoTiGWQtF1jX/AkpTWK6uWNsMFBXLZeJvCMEMrevrB5m03g/+FTIVU2YT2fr3FjBcF2kIGpqpSPe36aliD0oeP7U+2sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CH2PR12MB4857.namprd12.prod.outlook.com (2603:10b6:610:64::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 15:20:12 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b%6]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 15:20:12 +0000
Message-ID: <8c9e8103-d194-5e8f-eaa2-1cc16bfb3c9a@nvidia.com>
Date: Thu, 29 Jun 2023 18:20:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 5/5] vfio/migration: Refactor and fix print of
 "Migration disabled"
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, chao.p.peng@intel.com
References: <20230629084042.86502-1-zhenzhong.duan@intel.com>
 <20230629084042.86502-6-zhenzhong.duan@intel.com>
 <9aa97ee7-ee54-a2d3-2cde-36b1a1d1241d@oracle.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <9aa97ee7-ee54-a2d3-2cde-36b1a1d1241d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::9) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CH2PR12MB4857:EE_
X-MS-Office365-Filtering-Correlation-Id: b2792492-b7b0-461a-14dc-08db78b45505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HreZUSOiAwCrTQ+E/DKKI0uHhVapmL83i5lAduZTBXKRkb5rqKNyINUp86LRRY//ZTc5acc3F8TNQTjfdcMHX0wzl24MwSxXkztUGtiNxYepLzF7GxPRV590bzePOlGdWANEPQAV7Z2V2B0CL2tSfs79d2BHBKuz9yZsxk21EkB3tWfprZYCdKSrmllsJhAuw0I00ELj0ifkEwVh6KN/gy3EZNt6gsfqT8DRMwOalxP33imQvGZyqdKfjnsFf8OnxOV1nX1Ra7MfD5ObB351ySxQR2X4TM0ywKIUsKqHzN5gzf6/sB4O7+FjKA6GK4v72at3WTW3mUfSYHm+E82JldFsLU/NrMJC/3XuXFGuFqqDHJlRgrknz11EYzSGkKRAU+eKp1F5b9U0wpsHYqGCN9t/6/GAWRw68U+FdINYB/Nr3QfrVX9L+XQhCPpqJOCtTPZJLLTEiONYUgidZAtG8DSxA+ma8cK8NIYMAMYrY6Bn0ZvwXDdkeZ0OzOwOJmeDSFXkwVHT+fRIkpUzkfmAEfqkWYWFFESa/l2uQ8A5Hr+v3Si9Sp0zFBfTMCr/AyIwMtKYD3Hck6AaQ6pPaVcXtB2vQgRUM+xftH4PmGvKcBR82ojHiPWdp7bE9C74vAC35krDFqRJVOUPk29TDhJ+4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199021)(53546011)(6506007)(36756003)(66556008)(6486002)(26005)(6666004)(2616005)(83380400001)(110136005)(6512007)(186003)(2906002)(478600001)(86362001)(316002)(5660300002)(30864003)(66476007)(31696002)(66946007)(8676002)(4326008)(41300700001)(8936002)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXZBOTh0SWFySlhmRGQ3bUpPWmZCVG9pcnMySElld0IvcE9lVEJOb2EvMnlx?=
 =?utf-8?B?bks4YktPMUxRTmlLTXl2T0xaQ0REZm1XMDBFUkN1ZkU5SFQyRHYzc3lLL0NU?=
 =?utf-8?B?ajZHQ0x0TEpEK0xtU2NlWUVUYzBUVVFIeGs4MU5FOHpYVG9aQ2NVSE5RcnNL?=
 =?utf-8?B?VVJ5d3ZEUFlBUzhEYkxndXZ6b2I2Y3o2MThKa0VFdVI4WE9QS0FYYkErWGwz?=
 =?utf-8?B?eUxqZGZ3M0g0dklmaFFES0d4L2FlVTV4L0lqdXBMU3NmWXoxWUtBQm5NTDg5?=
 =?utf-8?B?c0FLd2Y4WDV1ejlFR3J5dGhvZjY0cXlTcWRaWXNvT3hzaXlhUzh3SlgwMzV5?=
 =?utf-8?B?RC9lK3N6UzdOdUpLNVhSaVFWWGpORkxCaGJLL09wZm42aHdCcldJQkRCS05R?=
 =?utf-8?B?Y05FdHh3LzdRUFl0VXVvUHB3V3dwNFAxOW5zWlhVeURobkttTTk4MGNKc3I0?=
 =?utf-8?B?dndmZlMwUVVkNWVQWXhZTVZjMVJGN1AraldjU0VRWnRUWm43MzNlZUlOSktZ?=
 =?utf-8?B?TENlWGNScUF4Sk5aaVZ3OCtFd0x0MzFrdENEMWo2bThxeHE4S0x2aklmRTVS?=
 =?utf-8?B?a0NTcSs2NURkM0k0WHBPMkVVaEtHeFRXTGxCOEJ1WTNyWjM4aTZ2OG96SUFZ?=
 =?utf-8?B?YTVFYkNJd3FROU9UcDMzemoyUnFZMHE5MDBTaWxlWndPU1lXUVAyZmwwc2My?=
 =?utf-8?B?N2hnZFltSGdPV243Qk1PT2RwMHBlak56QXh2YUNMZjNqKzJ0U29iVEszT1p0?=
 =?utf-8?B?VkN5dy96R3RPdXhQa2w4dVdkSDVCMDVFaXplS2pQcTQ1SDMxUFNmZm1xMXZF?=
 =?utf-8?B?b1hZeXhPK2Zadyt0UHB3T20rMWVaS0pIQTJ1dXErTHlFVnNnNmR5UVpmcGZa?=
 =?utf-8?B?ZTNGeTdqdmVITDN3UzdhWlcxVkJNZS81WDJwNHhnaDZycE1QVExEOTJHZU5G?=
 =?utf-8?B?ZWNQakNZd2tVazFmbXFnK3Fqd2VqNVVTU0NSNGxkS1BIeEh0Y0Q3TXJkR3lu?=
 =?utf-8?B?NTJlaHVvY2pWL1JSdmhpMXQzSVJZSkhEaklYRkdsWCtZTng4VlV2SHdCTHVV?=
 =?utf-8?B?T2RaSVcydUtZbUtPVlhkWFRGQVpFeXAyOWFxeEM5dFUraXlZZG0yK05vb2g5?=
 =?utf-8?B?UGlmcXorWGRGdEpNZHhlb1YvTGNFRVF5WEZQTDRjWnh3VlVpd0xiYnJpajhp?=
 =?utf-8?B?T1Z2M3ExTU9KTmxLUjVHdzN5aEdsMyt2QmhuOFhLcFhTa1FSMThBRTRwLzJX?=
 =?utf-8?B?dGZ2R09pc2ZDcUFRNDNGajdEN25GSEFWajY4OEdjUE1nSzBYT2UwbTlKUkhE?=
 =?utf-8?B?T1hjL3FSYy9YZjd3Yk5LL0lob1djVVlyOFkyRDVUdGF5T0VucDFEN3hzcG9v?=
 =?utf-8?B?Q2k1Y0JVN3FWOCtXcUkyV1RzVTVOOHdiaUtBOGM2RXh0R3RGWEpuV1E3aDQ4?=
 =?utf-8?B?SFZCcFRSVk9hbW9mMW43V2tCUmNKUk5VN1laekJyNmdrc0RsL0NqLy83VHp5?=
 =?utf-8?B?S3NzNldUYmdGVlVGRlVrN2V4Tm1kS0h4bk04eE1yRHg0bjN5eloxcVN2ZXpm?=
 =?utf-8?B?R2FjSEp6Ty9DNlZTeEx0WlJZREdvaTI4WGZUWmVYUllZT0FxSStpZE83Y0tP?=
 =?utf-8?B?S0pCSE96R2xjcVYvK0pZZXV1YVZDRnVWaVZ0MG9vc2d4elF5dkg2Vnd2R3FN?=
 =?utf-8?B?emp5MlFjSXUxb3dxUmpSd0RQRWtCQkh2OXhHUEpBSHplR3h6VVhuaHhhaVV1?=
 =?utf-8?B?dHRVTnVXVHhGK2ZMclBnSE5lUXlSRzhrdlUzcjRMMkVXR3hHQUxlNmhOekdP?=
 =?utf-8?B?QzYvV0FxODlTZW9JdjhsbEtWcy96Q0dCVVRUVWdKU1hjbE1ocnlZeWwxUVF6?=
 =?utf-8?B?alJoUHRERjFRTjJnVXZ6bHFISitMbVZUQVIwcW04dTBCS29UWWphOFlVMitQ?=
 =?utf-8?B?RTEyTFJ2a093aEYvc1RGM0JuVWxVdEkyTG1NcHFOUDJla1IrSHd2em8wN2dO?=
 =?utf-8?B?TGlObE9sQzl6eXdDVHVBdVN5b2ttLzJUUWlPanpUYUsxZzV2aVRpM1RUUHFC?=
 =?utf-8?B?ODdMMlVNVENNd2lBZnd6OWRna1NYalNlRWl5MW03M2FNSU0rRkdFRTZ1VXFN?=
 =?utf-8?Q?cOHKI2zoyR9jvLQGUIRsB7ar4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2792492-b7b0-461a-14dc-08db78b45505
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 15:20:12.2325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ihDu/oynq35LLSFCb7QybrrFaqdmI1zF/eSQUrdIAa24GwroHntz5QeLUc4qWfUga8WV2QJaib7STNdkia/pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4857
Received-SPF: softfail client-ip=40.107.223.69;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


On 29/06/2023 15:44, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
>
> On 29/06/2023 09:40, Zhenzhong Duan wrote:
>> This patch refactors vfio_migration_realize() and its dependend code
>> as follows:
>>
>> 1. It's redundant in vfio_migration_realize() to registers multiple blockers,
>>     e.g: vIOMMU blocker can be refactored as per device blocker.
>> 2. Change vfio_viommu_preset() to be only a per device checker.
>> 3. Remove global vIOMMU blocker related stuff, e.g:
>>     giommu_migration_blocker, vfio_[block|unblock]_giommu_migration()
>>     and vfio_migration_finalize()
>> 4. Change vfio_migration_realize(), vfio_block_multiple_devices_migration()
>>     vfio_block_migration() and vfio_viommu_preset() to return bool type.
>> 5. Print "Migration disabled" depending on enable_migration property
>>     and print it as warning instead of error which is overkill.
>>
> I am not enterily sure we need to keep "Migration disabled". Perhaps we should
> just derisk from error to warning and use always the same error messages.
>
>> migrate_add_blocker() returns 0 when successfully adding the migration blocker.
>> However, the caller of vfio_migration_realize() considers that migration was
>> blocked when the latter returned an error. What matters for migration is that
>> the blocker is added in core migration, so this cleans up usability such that
>> user sees "Migrate disabled" when any of the vfio migration blockers are active
>> and it's not intentionally forced by user with enable-migration=off.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   hw/vfio/common.c              | 66 +++++++----------------------------
>>   hw/vfio/migration.c           | 30 +++++++++-------
>>   hw/vfio/pci.c                 |  4 +--
>>   include/hw/vfio/vfio-common.h |  7 ++--
>>   4 files changed, 36 insertions(+), 71 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 77e2ee0e5c6e..c80ecb1da53f 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -362,7 +362,6 @@ bool vfio_mig_active(void)
>>   }
>>
>>   static Error *multiple_devices_migration_blocker;
>> -static Error *giommu_migration_blocker;
>>
>>   static unsigned int vfio_migratable_device_num(void)
>>   {
>> @@ -381,19 +380,19 @@ static unsigned int vfio_migratable_device_num(void)
>>       return device_num;
>>   }
>>
>> -int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>> +bool vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>>   {
>>       int ret;
>>
>>       if (multiple_devices_migration_blocker ||
>>           vfio_migratable_device_num() <= 1) {
>> -        return 0;
>> +        return true;
>>       }
>>
>>       if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
>>           error_setg(errp, "Migration is currently not supported with multiple "
>>                            "VFIO devices");
>> -        return -EINVAL;
>> +        return false;
>>       }
>>
>>       error_setg(&multiple_devices_migration_blocker,
>> @@ -403,9 +402,15 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>>       if (ret < 0) {
>>           error_free(multiple_devices_migration_blocker);
>>           multiple_devices_migration_blocker = NULL;
>> +    } else {
>> +        /*
>> +         * Only ON_OFF_AUTO_AUTO case, ON_OFF_AUTO_OFF is checked
>> +         * in vfio_migration_realize().
>> +         */
>> +        warn_report("Migration disabled, not support multiple VFIO devices");
>>       }
>>
> Perhaps you could stash the previous error message and use it in the
> warn_report_error to consolidate the error messages e.g.
>
> bool vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
> {
>      Error *err = NULL;
>
>      if (multiple_devices_migration_blocker ||
>          vfio_migratable_device_num() <= 1) {
>          return true;
>      }
>
>      error_setg(&err, "%s: Migration is currently not supported with multiple "
>                       "VFIO devices", vbasedev->name);
>
>      if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
>          error_propagate(errp, err);
>          return -EINVAL;
>      }
>
>      ...
>      if (ret < 0) {
>      } else {
>          /* Warns only on ON_OFF_AUTO_AUTO case */
>          warn_report_err(err);

I'm not sure this warning is needed.
If I remember correctly, I think Alex didn't want migration 
error/warning messages to be logged in the AUTO case.

>      }
> }
>
>> -    return ret;
>> +    return !ret;
>>   }
>>
>>   void vfio_unblock_multiple_devices_migration(void)
>> @@ -420,55 +425,10 @@ void vfio_unblock_multiple_devices_migration(void)
>>       multiple_devices_migration_blocker = NULL;
>>   }
>>
>> -static bool vfio_viommu_preset(void)
>> +/* Block migration with a vIOMMU */
> I meant in the previous version to put the comment on top of the caller, not on
> the definition. But with the new code structure from Avihai the error message
> further below... it will look a bit redundant.
>
>> +bool vfio_viommu_preset(VFIODevice *vbasedev)
>>   {
>> -    VFIOAddressSpace *space;
>> -
>> -    QLIST_FOREACH(space, &vfio_address_spaces, list) {
>> -        if (space->as != &address_space_memory) {
>> -            return true;
>> -        }
>> -    }
>> -
>> -    return false;
>> -}
>> -
>> -int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp)
>> -{
>> -    int ret;
>> -
>> -    if (giommu_migration_blocker ||
>> -        !vfio_viommu_preset()) {
>> -        return 0;
>> -    }
>> -
>> -    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
>> -        error_setg(errp,
>> -                   "Migration is currently not supported with vIOMMU enabled");
>> -        return -EINVAL;
>> -    }
>> -
>> -    error_setg(&giommu_migration_blocker,
>> -               "Migration is currently not supported with vIOMMU enabled");
>> -    ret = migrate_add_blocker(giommu_migration_blocker, errp);
>> -    if (ret < 0) {
>> -        error_free(giommu_migration_blocker);
>> -        giommu_migration_blocker = NULL;
>> -    }
>> -
>> -    return ret;
>> -}
>> -
>> -void vfio_migration_finalize(void)
>> -{
>> -    if (!giommu_migration_blocker ||
>> -        vfio_viommu_preset()) {
>> -        return;
>> -    }
>> -
>> -    migrate_del_blocker(giommu_migration_blocker);
>> -    error_free(giommu_migration_blocker);
>> -    giommu_migration_blocker = NULL;
>> +    return vbasedev->group->container->space->as != &address_space_memory;
>>   }
>>
> nice consolidation
>
>>   static void vfio_set_migration_error(int err)
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 1db7d52ab2c1..84036e5cfc01 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -802,13 +802,13 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>>       return 0;
>>   }
>>
>> -static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>> +static bool vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>>   {
>>       int ret;
>>
>>       if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
>>           error_propagate(errp, err);
>> -        return -EINVAL;
>> +        return false;
>>       }
>>
>>       vbasedev->migration_blocker = error_copy(err);
>> @@ -818,9 +818,11 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>>       if (ret < 0) {
>>           error_free(vbasedev->migration_blocker);
>>           vbasedev->migration_blocker = NULL;
>> +    } else if (vbasedev->enable_migration != ON_OFF_AUTO_OFF) {
>> +        warn_report("%s: Migration disabled", vbasedev->name);
>>       }
>>
> Perhaps you can use the the local error to expand on why migration was disabled e.g.
>
>          warn_report_err(err);

Same here.

Thanks.

>
>> -    return ret;
>> +    return !ret;
>>   }
>>
>>   /* ---------------------------------------------------------------------- */
>> @@ -835,7 +837,12 @@ void vfio_reset_bytes_transferred(void)
>>       bytes_transferred = 0;
>>   }
>>
>> -int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>> +/*
>> + * Return true when either migration initialized or blocker registered.
>> + * Currently only return false when adding blocker fails which will
>> + * de-register vfio device.
>> + */
>> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>>   {
>>       Error *err = NULL;
>>       int ret;
>> @@ -873,18 +880,17 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>>                       vbasedev->name);
>>       }
>>
>> -    ret = vfio_block_multiple_devices_migration(vbasedev, errp);
>> -    if (ret) {
>> -        return ret;
>> +    if (!vfio_block_multiple_devices_migration(vbasedev, errp)) {
>> +        return false;
>>       }
>>
>> -    ret = vfio_block_giommu_migration(vbasedev, errp);
>> -    if (ret) {
>> -        return ret;
>> +    if (vfio_viommu_preset(vbasedev)) {
> The /* Block migration with a vIOMMU */
>
> Would go above, but I don't think we need it anymore ...
>
>> +        error_setg(&err, "%s: Migration is currently not supported "
>> +                   "with vIOMMU enabled", vbasedev->name);
>> +        return vfio_block_migration(vbasedev, err, errp);
> ... as the error message when placed here makes it obvious. So the comment I
> suggested won't add much. Unless others disagree.
>
>>       }
>>
>> -    trace_vfio_migration_realize(vbasedev->name);
>> -    return 0;
>> +    return true;
>>   }
>>
> I think somewhere in function we should have vfio_migration_exit() being called
> behind a label or elsewhere from vfio_migration_realize (...)
>
>>   void vfio_migration_exit(VFIODevice *vbasedev)
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index dc69d3031b24..184d08568154 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3209,7 +3209,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>       if (!pdev->failover_pair_id) {
>>           ret = vfio_migration_realize(vbasedev, errp);
>>           if (ret) {
>> -            error_report("%s: Migration disabled", vbasedev->name);
>> +            trace_vfio_migration_realize(vbasedev->name);
>> +        } else {
>>               goto out_vfio_migration;
>>           }
>>       }
> (...) Which then void the need for this change. Perhaps your previous patch
> (4/5) could come after this refactor patch instead ... where you would fix the
> unwinding error path inside the vfio_migration_realize() as opposed to
> vfio_realize().
>
>> @@ -3257,7 +3258,6 @@ static void vfio_instance_finalize(Object *obj)
>>        */
>>       vfio_put_device(vdev);
>>       vfio_put_group(group);
>> -    vfio_migration_finalize();
>>   }
>>
>>   static void vfio_exitfn(PCIDevice *pdev)
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 93429b9abba0..3c18572322fc 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -225,9 +225,9 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
>>   extern VFIOGroupList vfio_group_list;
>>
>>   bool vfio_mig_active(void);
>> -int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
>> +bool vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
>>   void vfio_unblock_multiple_devices_migration(void);
>> -int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp);
>> +bool vfio_viommu_preset(VFIODevice *vbasedev);
>>   int64_t vfio_mig_bytes_transferred(void);
>>   void vfio_reset_bytes_transferred(void);
>>
>> @@ -252,8 +252,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>>   int vfio_spapr_remove_window(VFIOContainer *container,
>>                                hwaddr offset_within_address_space);
>>
>> -int vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
>> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
>>   void vfio_migration_exit(VFIODevice *vbasedev);
>> -void vfio_migration_finalize(void);
>>
>>   #endif /* HW_VFIO_VFIO_COMMON_H */

