Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAA9715C95
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:06:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3x9n-0007oo-KL; Tue, 30 May 2023 07:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3x9l-0007od-0q
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:04:49 -0400
Received: from mail-mw2nam10on2062b.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::62b]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3x9g-0006wE-8D
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:04:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKH0TtEHL0F39NaBlUvNTqRhQRE3IDTQFz5KDhyU+wsgYASi45u/oEOhBxOrdLHP/Q5nqdRrQpmGvH/cqLh2ulvE1+eP6cJ7ryez92mvfGX7mgtXpH9MEEEVuy/Hk0/8wjtZ+Gk4o9pGDpcAuXeOpJ2UcTbk5isQEGl+kN7vlWYQa5p1PbMpmQ6GRhszSsUGb6pc2lw0IRwLGzIEz4ZGYUKqHJSPxeff3q9WHPWdfuZcO7xW17R/i+aIzmkO1rWLOl8EVHWnVaZ0cLrpfcypwjjtTss2JrsznMljpbyhxMpio6MfwM7+tD2NvDgRPw8kih7nourgHIyKF/P0ISVunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtikoLLdxa9fEG6BTkOelInXqT23ToBnBXEEAz47GTo=;
 b=BWQLG1izrSuKP213f/qPkTdO9NX2sz5U3+G2xNBUkzgHp8HhM4r0/gJuqpWyYIv/bBdV7OQNhNjawhQgIObJI9fzwN4o2QfiUvF0PR/CRsQKAny4kiAEZe2eqs5BQeCWDn35tfBF2f9GF1Z7hLfgGHqhMNeFMCf6iTUPRYyd/KiuGO85l/rZSv5BhvC+nLLz8CLkDgG+V5xx8ye7YY7whsJCKYvoXBxAgWZGBdl0zb1hhZBmd0x2KgV6riVt2k/BJRpxMyrzSsuBQyOG2zsLejdrvf5vG6ZYBtIR6ToAXc+WD7lQto+1ZBihDsO4vUmqQagoDdx0op49iFGM1bxZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtikoLLdxa9fEG6BTkOelInXqT23ToBnBXEEAz47GTo=;
 b=tK4EkcuwN6zh/TObjaopF4Z5JMLjzaWWBQslKPGU7ZV2oJ0PD5Ewipk3OxtmDLiUYROuLKSssgme8oQjcL9SF+0sGt11Q3LG+QE04RlvNk99PwSbDReMcyrmxTMiyREMSkd/P2YHC5orqrUsHRIpr/Rs6C+VLTE+8ldTHli0irmZaZQqA/D7KykMgDlSCExx7gVQoEDI3YDX4CEq0/sL63FQ52cYxnZ2NbFv4WehfU406m3h/xi1IHLGAS9wyYNlHlJzgoamqBhmxK8RHM+iKtueKYQlFG/M7p7DZAsDExKxkI7uvp5uMRESyuS9GppR22DDCGyiwPPTX9jOF/zemQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 11:04:38 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c887:8186:c2f0:d7e6]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c887:8186:c2f0:d7e6%5]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 11:04:38 +0000
Message-ID: <bb7bb1f5-9dd4-b72f-1531-f59c1e28ebbb@nvidia.com>
Date: Tue, 30 May 2023 14:04:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 9/9] vfio/migration: Add support for switchover ack
 capability
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20230528140652.8693-1-avihaih@nvidia.com>
 <20230528140652.8693-10-avihaih@nvidia.com>
 <b3da19aa-37d0-16f2-4094-d1931dfa7601@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <b3da19aa-37d0-16f2-4094-d1931dfa7601@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0452.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:398::23) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CH0PR12MB5348:EE_
X-MS-Office365-Filtering-Correlation-Id: 6108d43e-4401-4eca-b7d7-08db60fda8ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tzRp9euVjIGrwpVx2jCDrFO+3NwKMNCMX+mAVccwhamtzjECjJchLPaSKf1ZN7AoqIkP215QDfq2wnxt9B+vE3FxIofwdGm0DI2o2LdWMM/a98DnvU3cVRDWuYApQ94hCzGFcIFYwnXzYapnlobgOXbzsgsBz+MoVfFqkmyDo7vL6vtP4bNdXy/tzP9c7gY0CURvbDprliHG0an55t/2TOzsr06A3E3MIw30/qg2bkb0Wutdl6qB/AfK4vLlx4TSxSA6HyQY5fIKNI+XYg4SX5v6qiY2LI6vg9xtz77EsXcq/V+rkAwDJtJByvbx6Asnyte0TciGOug3TmWHIGHNlrGepoARFcEQK9Xalfyv86vHbzTA19biNk0DNlzbvlf/0jsR+fsemPRX/A2diBLVMEaTdqQ8jZb0aqmSCcfVPPBJG8I6rAmSUT55/ch5RcIVRU9nzXZDzHh3l7N+FyZpuUAhTyi//1E1H+3uq6rebk/NZ5nll1to6P/rvS59Dx5XgFK9qoaMTD5Xn4uSXi1Kmsi2OmYAkz/2NhwysUwcVayLhgqzGavUKXV+jBTE0dMQii2cZ6awO8uXVvwDKAztXX3Ii4HL3UPnnPzmDPgJdvhNZlMbFr+cYgrT90j7cuMQVtBCahYMlzwhHKvnnPIySw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199021)(31696002)(86362001)(36756003)(478600001)(54906003)(4326008)(316002)(66946007)(66556008)(66476007)(83380400001)(6486002)(6666004)(8936002)(8676002)(41300700001)(2906002)(7416002)(38100700002)(2616005)(5660300002)(6512007)(6506007)(53546011)(26005)(186003)(66574015)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUxZVTdHK1Zma0YycVcyRjZjRHpSYXJaQnRZNnlObzlmcHZjNklPaVREZTI0?=
 =?utf-8?B?SHk4WWhnL2h2ZGdGTGpkbXFONGk0RnJ3cTdHWWZ1WWwxZERZLzlnMElPSk9m?=
 =?utf-8?B?UUxtM2N4OGJ6RGN1MkNsQ3N4NFZ5SVVCVmhjcDc1aU41UTB4VEdQdzdVeXFF?=
 =?utf-8?B?VkF2RVJSZHo0bmxiYUIxbG1nN3FGRTlReFNFUG85QWJwNCswMnd5RVdqcEJn?=
 =?utf-8?B?VzQ1V0dhWlZOcjlvVzlJSysyNWx0QzR5MlgwcS9JRnJzOHlIRnlrTHlWdVd1?=
 =?utf-8?B?bWVUK25QMytzTjgxUDVtSnVmQmFOWUxWZjFRdWlZeWNWMm5UYXEzZm0rVFBG?=
 =?utf-8?B?VCtLNGFWTVg5dXA1N21iTExIVjNjN0IzUlVDanEyZEd6RXpzTTJxM01oMjJ4?=
 =?utf-8?B?OUtKbUdwNk4wR09XZ2U1czdqUGJ5VzZORFpyT2RYV3pwZzdCSEQ1MVdTSlN5?=
 =?utf-8?B?U1ZsRFFJUzBJYVVod3ZwelRWRnVnem53SHdzMmN5ZEhUc0NPN2U1YXpROUor?=
 =?utf-8?B?cHAwK2JnRVM4VE1yb2JuOWM3djI4QXg2bmF3aGV4Wkt2a05oMlRqTnlRbWZu?=
 =?utf-8?B?L3VYeEV3L1pXd0tXVXV5SndxRU16dDloeEFvSzhlVGlMOE9ob0VWU2hMeVk3?=
 =?utf-8?B?bGxnK08wZi9DNUp5djZjS0JZSG5SMXI0L3IrZGs3YjF1ZzVOb1lISkNZT3pD?=
 =?utf-8?B?K3VKQ2dpSEVJeWJqdS9oUVlUSkk1WnVaK0hxQXArUTRzdDAyK25GeFFIWWJH?=
 =?utf-8?B?RUtHTXc5a3lkWWRFRngrVFF3YkROWUd2UHM4YmNsbDloQUU4MzRGTzk2ZVdj?=
 =?utf-8?B?eGJ3V3czV1dNYmRyS2U0bG9CdlJPaklsYXBGUFFTTVpiZGQ2VVFnZmRJT09O?=
 =?utf-8?B?WnNpS2Q5ZkdSZ1FMc1Z0S2R5WDBad2xmZnRzb2dxdkNoazVhZFBINmVSUTdz?=
 =?utf-8?B?Um5PS25Tc1ZNZGtvL3RXV2ZzR2VWU291ay9GUWpsY2NvVlFleHFpQ3FNM2Zm?=
 =?utf-8?B?WllVQUEvMzk4Q1pPRTdvdFVQbzFwRUdPS3o0MlBSZDg3NFFvS2srMTRxcjhv?=
 =?utf-8?B?N21SclE5Y1FpaWw0S3E0ZXdGMnR4anNWMzY3c3dWSE5kY1NhMExxZFppYjhj?=
 =?utf-8?B?ZnJINC9LcVZ3NFNXWE1NYnN2dWl5UGZiWjRvMWxzeThBSmRvclRXRktZZ3F3?=
 =?utf-8?B?Y3Faa0hIUWRoN2V0Uk5pTWg5djJJa1BJdWZoWjUvZDNpSTgvS3V1N1RGdm81?=
 =?utf-8?B?YnJ2bEJRdjBicmF2RlBTY0hHaWozTEpmWkd3L1dsdnJ0RktwaXlxV09IK0hi?=
 =?utf-8?B?VytHQzY5Z0tsdHhNd2FKa0ZIM1JtU21hMHVzMG1ZdjNESDRhUVZBNEhhV2ox?=
 =?utf-8?B?dFlxanFCSGU4U21YWFgzdUw3V1dhakJqSDB0VFRqdGUyZXRHWjVhS0tGQ0Jw?=
 =?utf-8?B?RGNmNDVGUDY0bnFHSlVkRGFHazl3bmZ4ZXJuMFlUME1lNGRSV1FQQWF3QVdR?=
 =?utf-8?B?VUVHcVF4MW5NRzVRelgxVy93SUFOQVc1ZWR5VVhHT0pOQ3YySXdTRVJuWXo5?=
 =?utf-8?B?a01EbGVyWnRjTmx0cmNxS2xWT1QwdTJsa2RPMWE5UTNwZXdCaS94bVlMRFkv?=
 =?utf-8?B?TXJEVTV0YkxBL01TbGd4aThiTDdUVVh0dnRCRzN1dG81blhCL1dHajJiMWlj?=
 =?utf-8?B?MTM5NDFYNEtiZlJlbFh2VWE5eW9jR2pxZFZHMjhQK1ZDdWd3TXgrb3JQOXB1?=
 =?utf-8?B?dmorMW44SkE3N256dEdDVWQ2ZWhaWVIrTG1kMzFTUm1odlZYdmNUZTltRXlD?=
 =?utf-8?B?SjV1VWNtd01JNGFxTXlabTM4Nk14eWllVjdDQTY3bkVOYVU5RFdJcCtQUVUz?=
 =?utf-8?B?ZUhhWmgyM2xFVlBEV3RiVWx6NElYRk55Mi82SGorSWNwVEdCSXpiblgzQ0k1?=
 =?utf-8?B?amxKMkh1SGorTWRXb1NVQXZDSUdhb29NN2JJU2N6S3NXMDBuTEdKZVJSdXNa?=
 =?utf-8?B?OG5Ra2xDZXBZdWVSemNwOUtadHRoNGg5OGM2UXNMNGFIb2pObk5RajlPNGRM?=
 =?utf-8?B?czN5Z0ZaNlVBUHhTT3Rsc0N2OVo4MGM1NFprSTRVSGh3MDk1TmtpdDVxRkhr?=
 =?utf-8?Q?Kgz6PBTTcKQF2iGrUMCuyX7Ja?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6108d43e-4401-4eca-b7d7-08db60fda8ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 11:04:37.9523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4n8iF8sWRsSDhBh5EXTS4o97xdy6B8rQNfEmWsHORbs8FX5HJwuWBoKuGGPH/6gxLk/gkTERaFYcqToLfDX6sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5348
Received-SPF: softfail client-ip=2a01:111:f400:7e89::62b;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 30/05/2023 12:58, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 5/28/23 16:06, Avihai Horon wrote:
>> Loading of a VFIO device's data can take a substantial amount of time as
>> the device may need to allocate resources, prepare internal data
>> structures, etc. This can increase migration downtime, especially for
>> VFIO devices with a lot of resources.
>>
>> To solve this, VFIO migration uAPI defines "initial bytes" as part of
>> its precopy data stream. Initial bytes can be used in various ways to
>> improve VFIO migration performance. For example, it can be used to
>> transfer device metadata to pre-allocate resources in the destination.
>> However, for this to work we need to make sure that all initial bytes
>> are sent and loaded in the destination before the source VM is stopped.
>>
>> Use migration switchover ack capability to make sure a VFIO device's
>> initial bytes are sent and loaded in the destination before the source
>> stops the VM and attempts to complete the migration.
>> This can significantly reduce migration downtime for some devices.
>>
>> As precopy support and precopy initial bytes support come together in
>> VFIO migration, use x-allow-pre-copy device property to control usage of
>> this feature as well.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   docs/devel/vfio-migration.rst | 10 ++++++++
>>   include/hw/vfio/vfio-common.h |  2 ++
>>   hw/vfio/migration.c           | 48 ++++++++++++++++++++++++++++++++++-
>>   3 files changed, 59 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/devel/vfio-migration.rst 
>> b/docs/devel/vfio-migration.rst
>> index e896b2a673..b433cb5bb2 100644
>> --- a/docs/devel/vfio-migration.rst
>> +++ b/docs/devel/vfio-migration.rst
>> @@ -16,6 +16,13 @@ helps to reduce the total downtime of the VM. VFIO 
>> devices opt-in to pre-copy
>>   support by reporting the VFIO_MIGRATION_PRE_COPY flag in the
>>   VFIO_DEVICE_FEATURE_MIGRATION ioctl.
>>
>> +When pre-copy is supported, it's possible to further reduce downtime by
>> +enabling "switchover-ack" migration capability.
>> +VFIO migration uAPI defines "initial bytes" as part of its pre-copy 
>> data stream
>> +and recommends that the initial bytes are sent and loaded in the 
>> destination
>> +before stopping the source VM. Enabling this migration capability will
>> +guarantee that and thus, can potentially reduce downtime even further.
>> +
>>   Note that currently VFIO migration is supported only for a single 
>> device. This
>>   is due to VFIO migration's lack of P2P support. However, P2P 
>> support is planned
>>   to be added later on.
>> @@ -45,6 +52,9 @@ VFIO implements the device hooks for the iterative 
>> approach as follows:
>>   * A ``save_live_iterate`` function that reads the VFIO device's 
>> data from the
>>     vendor driver during iterative pre-copy phase.
>>
>> +* A ``switchover_ack_needed`` function that checks if the VFIO 
>> device uses
>> +  "switchover-ack" migration capability when this capability is 
>> enabled.
>> +
>>   * A ``save_state`` function to save the device config space if it 
>> is present.
>>
>>   * A ``save_live_complete_precopy`` function that sets the VFIO 
>> device in
>> diff --git a/include/hw/vfio/vfio-common.h 
>> b/include/hw/vfio/vfio-common.h
>> index a53ecbe2e0..ad0562c8b7 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -69,6 +69,8 @@ typedef struct VFIOMigration {
>>       uint64_t mig_flags;
>>       uint64_t precopy_init_size;
>>       uint64_t precopy_dirty_size;
>> +    bool switchover_ack_needed;
>
> Do we really need the 'switchover_ack_needed' bool ?
>
> It seems that each time it is used in a routine it could be computed
> locally with migrate_switchover_ack() and vfio_precopy_supported().
> This would simplify the code a bit more.
>
You are right.
I will drop it and send a v5 (will fix the superfluous " as well).

Thanks!

>
>
>
>> +    bool initial_data_sent;
>>   } VFIOMigration;
>>
>>   typedef struct VFIOAddressSpace {
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index cb6923ed3f..ede29ffb5c 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -18,6 +18,8 @@
>>   #include "sysemu/runstate.h"
>>   #include "hw/vfio/vfio-common.h"
>>   #include "migration/migration.h"
>> +#include "migration/options.h"
>> +#include "migration/savevm.h"
>>   #include "migration/vmstate.h"
>>   #include "migration/qemu-file.h"
>>   #include "migration/register.h"
>> @@ -45,6 +47,7 @@
>>   #define VFIO_MIG_FLAG_DEV_CONFIG_STATE (0xffffffffef100002ULL)
>>   #define VFIO_MIG_FLAG_DEV_SETUP_STATE (0xffffffffef100003ULL)
>>   #define VFIO_MIG_FLAG_DEV_DATA_STATE (0xffffffffef100004ULL)
>> +#define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
>>
>>   /*
>>    * This is an arbitrary size based on migration of mlx5 devices, 
>> where typically
>> @@ -218,6 +221,7 @@ static void vfio_migration_cleanup(VFIODevice 
>> *vbasedev)
>>
>>       close(migration->data_fd);
>>       migration->data_fd = -1;
>> +    migration->switchover_ack_needed = false;
>>   }
>>
>>   static int vfio_query_stop_copy_size(VFIODevice *vbasedev,
>> @@ -350,6 +354,10 @@ static int vfio_save_setup(QEMUFile *f, void 
>> *opaque)
>>       if (vfio_precopy_supported(vbasedev)) {
>>           int ret;
>>
>> +        if (migrate_switchover_ack()) {
>> +            migration->switchover_ack_needed = true;
>> +        }
>> +
>>           switch (migration->device_state) {
>>           case VFIO_DEVICE_STATE_RUNNING:
>>               ret = vfio_migration_set_state(vbasedev, 
>> VFIO_DEVICE_STATE_PRE_COPY,
>> @@ -385,6 +393,7 @@ static void vfio_save_cleanup(void *opaque)
>>       migration->data_buffer = NULL;
>>       migration->precopy_init_size = 0;
>>       migration->precopy_dirty_size = 0;
>> +    migration->initial_data_sent = false;
>>       vfio_migration_cleanup(vbasedev);
>>       trace_vfio_save_cleanup(vbasedev->name);
>>   }
>> @@ -458,10 +467,17 @@ static int vfio_save_iterate(QEMUFile *f, void 
>> *opaque)
>>       if (data_size < 0) {
>>           return data_size;
>>       }
>> -    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>
>>       vfio_update_estimated_pending_data(migration, data_size);
>>
>> +    if (migration->switchover_ack_needed && 
>> !migration->precopy_init_size &&
>> +        !migration->initial_data_sent) {
>> +        qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
>> +        migration->initial_data_sent = true;
>> +    } else {
>> +        qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>> +    }
>> +
>>       trace_vfio_save_iterate(vbasedev->name, 
>> migration->precopy_init_size,
>>                               migration->precopy_dirty_size);
>>
>> @@ -526,6 +542,10 @@ static int vfio_load_setup(QEMUFile *f, void 
>> *opaque)
>>   {
>>       VFIODevice *vbasedev = opaque;
>>
>> +    if (migrate_switchover_ack() && vfio_precopy_supported(vbasedev)) {
>> +        vbasedev->migration->switchover_ack_needed = true;
>> +    }
>> +
>>       return vfio_migration_set_state(vbasedev, 
>> VFIO_DEVICE_STATE_RESUMING,
>> vbasedev->migration->device_state);
>>   }
>> @@ -580,6 +600,23 @@ static int vfio_load_state(QEMUFile *f, void 
>> *opaque, int version_id)
>>               }
>>               break;
>>           }
>> +        case VFIO_MIG_FLAG_DEV_INIT_DATA_SENT:
>> +        {
>> +            if (!vbasedev->migration->switchover_ack_needed) {
>> +                error_report("%s: Received INIT_DATA_SENT but 
>> switchover ack "
>> +                             "is not needed", vbasedev->name);
>> +                return -EINVAL;
>> +            }
>> +
>> +            ret = qemu_loadvm_approve_switchover();
>> +            if (ret) {
>> +                error_report(
>> +                    "%s: qemu_loadvm_approve_switchover failed, 
>> err=%d (%s)",
>> +                    vbasedev->name, ret, strerror(-ret));
>> +            }
>> +
>> +            return ret;
>> +        }
>>           default:
>>               error_report("%s: Unknown tag 0x%"PRIx64, 
>> vbasedev->name, data);
>>               return -EINVAL;
>> @@ -594,6 +631,14 @@ static int vfio_load_state(QEMUFile *f, void 
>> *opaque, int version_id)
>>       return ret;
>>   }
>>
>> +static bool vfio_switchover_ack_needed(void *opaque)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +
>> +    return migration->switchover_ack_needed;
>> +}
>> +
>>   static const SaveVMHandlers savevm_vfio_handlers = {
>>       .save_setup = vfio_save_setup,
>>       .save_cleanup = vfio_save_cleanup,
>> @@ -606,6 +651,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>>       .load_setup = vfio_load_setup,
>>       .load_cleanup = vfio_load_cleanup,
>>       .load_state = vfio_load_state,
>> +    .switchover_ack_needed = vfio_switchover_ack_needed,
>>   };
>>
>>   /* 
>> ---------------------------------------------------------------------- 
>> */
>

