Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E64BA75E177
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 12:44:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNWYV-0005hO-A4; Sun, 23 Jul 2023 06:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qNWYU-0005hC-3Z
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 06:43:14 -0400
Received: from mail-dm6nam10on2069.outbound.protection.outlook.com
 ([40.107.93.69] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qNWYR-0006Uw-DY
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 06:43:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqxkmzPlbfZ08UcYuS5T4Mv9ua1d07jk1OYbcXz6JFkuVkS1w0HucSnNmSR1PXo/uL+iWWXTMIn6SUWVYksUlTSNoqj9oZAc399cGoOaN842DRiiGtXVck1YaQPup1UnWSRDEpkHkGHr16AYjzcvRhhIlmTe/LxNWHS8Bc/QviMtuhmgTCUisZ4pyMC98x268sMzfhPC5uudsJBQoYZ3lPokjk/rTqcfznQZSRS9mXwz9OXCxyjaukYjatPhFvUOoMqSleoXc6NlXUGgy8tis3oX6roO6QFLwzmY9JVodXE9ZXCY/MIVpM6EcXzpgOztXSI5X51mN3P2ACzREiQBDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HT+6j8QT6+LG3lKjQTZhFl+RsfRqSRuuvI6gsl1H7a8=;
 b=l4KwFdzuPe1XGTVWoRLD8EgDyI4KIPGgZ2eafRzU+CilaZMPKL/3rGUaOHnPfGjx48TEQNarBPt2NZycmaN0b6kHWbigMNxwfIXPoRNyML8chcFfUz7qWF6Zv3LjfRBfAfTCuDMyLIFBn1HkSAD6/bQ3yqHcMN3kK2fJPEb9fUJ2oASQKINy4Z2JookTbgVtpfKmhlnPrAl6Z2+1AtV4QprFLxEF6Zil10Per7wmlUF4vX17Ri0s5sd9Dst5Z1mFxgIWzj+U4nxvKzFYrgErmNnAuJ5WM2eunxA+OBTDClBALYjIFrdvUIgVG6PuiYzAg4orqaklsw8+qONit+uQlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HT+6j8QT6+LG3lKjQTZhFl+RsfRqSRuuvI6gsl1H7a8=;
 b=rvOftyjwEPT3V3CM58OwICbS5Hm+FiGvIdflmc8hNnJFccNXVqI6SLJ2beFbCEXztZ4Jq0OEPNjN9DHhjsIxcxVE/VN0No/6r7Klbv74VDk6yDsWzgOwS/c4ix27mR8GvSH4lCbAM6p1x7DlKjNWmUuYVr5cnO3+BcXSUeV4ZYrZ1981iUt4xPhW2z3OQykeOIHqVmHn64ELTwvNNP1rjn7FTKyCUM9OZIgfs0joS79i2sU1l81hLarmBolCPnn7OIjF4YUc2X4Mwlw177Ndly04+Vu5y26fCd2NN90uZ9Gxc2DU8zNe6+jJlqbHqBwmYZMsXG5zDJEdvG+SFUzwlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Sun, 23 Jul
 2023 10:38:04 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96%4]) with mapi id 15.20.6609.031; Sun, 23 Jul 2023
 10:38:03 +0000
Message-ID: <87e8830d-453e-9389-30e0-dc2664ebd4d6@nvidia.com>
Date: Sun, 23 Jul 2023 13:37:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 5/6] vfio/migration: Add P2P support for VFIO
 migration
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>
References: <20230716081541.27900-1-avihaih@nvidia.com>
 <20230716081541.27900-6-avihaih@nvidia.com>
 <99a770f6-7f45-d7df-9555-bcc854914472@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <99a770f6-7f45-d7df-9555-bcc854914472@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::10) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|MW4PR12MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bdd7b5f-dc1b-4b57-f93b-08db8b68e4cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /kHt4beXWtYTSW5TIg2Xf4+n9HUspkhWbRGMZ3kMuaZxq/mPt8W/z00U2CMy8jh8i//+rD/NdDtRB2dLuyv0pWO8+fz/4XJ6fW9B1vaDBR4QuIEU+FsqfSBLZy3quVokZE0AFUQ7jaSybXDO5EVWk41wE1cmzd81clE4UmjLcntYJ5AYzdlXb1Wgq6qtTmen5mAQOHcjl10777fpkIb331M9MzNS1zlNGNkT+Xlw7sQ9V6Xos3ly116RTwZ6lJRIf83A1SEyI/HFc/zwt6iINLPJZc5HEtZWiIgXabP8YqjwO0G108S1HvomanfYtTUSPrmA3ENPrwxMWZr8YeGMV8iCPR3vs9gogzOsyiVLadVPBXFZaQtXTHNrEzFnevbAVSa7WfzS7HfMmIFHLY8GcpzKlfzDlUxiSOAdD83o/d12piknMV9HgsK5FKWJ0hpmntBIiCsooP9SeXlMRe4EBzck87F0SQ2WgFNqy+Pe2HFkINwqOznBnDBDCdsYk08fuKwdpFJdciQIen81b6mNq3cZUm5SjCPiaWrmXBaDxw2n3g1Tt/gSyrJlMa9K5NRELAg3yvBl0LUc/8mq8eMrwvylom7DEvs3a9F5WgCIBaocgrXEyF62sFnKVlyRiKUYDpDZbBMhZ/W+4UBw7AoCEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(83380400001)(66476007)(8936002)(30864003)(66574015)(2906002)(36756003)(2616005)(478600001)(8676002)(41300700001)(66556008)(54906003)(4326008)(316002)(66946007)(5660300002)(26005)(6506007)(186003)(53546011)(6512007)(107886003)(6486002)(6666004)(31686004)(31696002)(86362001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFpyOGNha1F2cDZUS2pBVmdzTzc2RzZXNVhvTSszZGg3SUpicnZUZ1FqbHRu?=
 =?utf-8?B?YkxwcWtETUJMU1F5cUFUT05wMWVJQzlwRWc1N1NlSC8xM0FrSTlRN1JHb2NQ?=
 =?utf-8?B?VGMwZzVYY0NBVXpiWDRnQlpDL0pvdjZrTjZtVkp1VkxhVFoydXNaZkpvVCt6?=
 =?utf-8?B?eHErVVVNR3FVMGhlbE5wL29TNTJkbkVWZWtCK00wcGVwbCtUZGJGY0VxeURF?=
 =?utf-8?B?WmVCNTV6US9admpKamNEZDMxdjIrcUVLSm4xTzNnZDBqUlNMSGQ1VXdiNkxD?=
 =?utf-8?B?aTIvOUJHQ1pnR2NsZnZhWEdiTzVLOU94UHNXVHNIaUIzaEt0TTRtWUU3ejNi?=
 =?utf-8?B?VDFTNVNJR3ZXTEhyMUlxQ3dPdXJFSDNjMXd2YlBTVDBSSnFYZlo1UExHT1Nt?=
 =?utf-8?B?YytTV0VZRWduQnZuYkZNSC94bEV5ZEd1Z1R3WElRNk9sUWFSVzRESGxiU0VK?=
 =?utf-8?B?ZnVBYW5ramRFMlFYZHJwOE5oZ2RvaEJBMitZeEpqVUxPcDBBV0hCZmtKb3Ir?=
 =?utf-8?B?TXBIMEdDb2dVOEcxdVZmdU9hVGJBODBlQ2lBbkRPbVRMcmZIdTU4VzZOZHg2?=
 =?utf-8?B?clFGeENlRzd0emFjUnJsOS94TE44N2gyRWZkQmY5NE1ZVmZZS3ZNQmRLdk90?=
 =?utf-8?B?WWUvYnJzZ3VGL3FwMjlNd0xzNkMzcWlEVnhFOFM3eEdtbkcxekZYTDJTb2R5?=
 =?utf-8?B?RDlkQUE1QnRWQmJjR0JFcEl2bmZ2bnVrYy9KQ2ZKZ2VCYzZCb0lFNmRHaDdQ?=
 =?utf-8?B?S29WaXZUWEsxWDM2bW0zcVp4YkFFTzRBTHpHcC8vTk9PanY2a2lFTUthR0RX?=
 =?utf-8?B?TG1LUG5sUjZ0VUxZbzE1UlBKV2dFa0lYUXNFdkpNd1piZ2lDbVM5UmRlajlC?=
 =?utf-8?B?VW5EaUwydWpIRnltazJ1QTBXY2o4RlBZc1A4VFFncTdQSTNtOFFVYlBLWlFY?=
 =?utf-8?B?WDM3RzdIMTBwNEh1Z3FSZTlTd1hNMXg3V2dTMVZjV1c5WmFZTllpaExURi9x?=
 =?utf-8?B?ajNoc3dURllTTzE3NTI1K1BWTGtmSDFodDYwWDBOclpvOFRHRUNwYktxNGdz?=
 =?utf-8?B?NVMvRmhldGRCdlh4RWNrNWhKcGxJTnNDdStLelFMaWhpdU9qcmdiaDgvQUJW?=
 =?utf-8?B?dnpjby9EenY4U2dvb211aElCSUZIU2hTQ2xiRlQ5Zk9BYmFBSW1adVU2RFo0?=
 =?utf-8?B?cWk3dnhiekxwNjdwdS9paDdLeGtQUklmVmdGODFVZXI3MlF5bVkxN1RxRURY?=
 =?utf-8?B?d0l6b0FHZXcrYUR0cmRvdkRWS0FiR05qSm1yNVlzcTdlRm1URGUxRTE4ZkNT?=
 =?utf-8?B?cndnL3NJY2R3N29iVjc1ZlRhNGxlMEFKRmNVaFIyUW50S3NXOTh4cEJadmxi?=
 =?utf-8?B?ZHZhVWVaSVl2MVRka3JaUkM0aXF2SDV4akJQSEE1QXlPdmJOajNCZWNURTVu?=
 =?utf-8?B?c0N3cjJDaUw2YmxoMEdrZUlaWWd1L0orL2NndWtmMFNYcjB3SzQvZ1FGL2l3?=
 =?utf-8?B?UGI0Zytsd3VzQkdMZW5OaW5kei82emlRL1p2K210anE0SzlZMzNqMXZnZFFT?=
 =?utf-8?B?MGVvSitQc3hwZ1hXangrWC85OGE2K2RXM0ZWNTVxazk4UW5CTU01ZUx1SS9v?=
 =?utf-8?B?eHRWWkNOUlY1K2VVaWdicXI1YnBpbTh6SGJWT2pwYlpMUVJ1aFJ1VlVXYlNE?=
 =?utf-8?B?K011TVFjZlM2UmFpOHE5a05VYU5zaXpMamtySkRsaUtISGdVaXFqZjZva0s4?=
 =?utf-8?B?Y3ZBeVp3emFVUzBsb0s4dEloUWRTVjVRNEtvemxTSXFYZXZ5bDRicXlNL1F6?=
 =?utf-8?B?VjU0ZEVYaVBiTkR5WDROM1F2UjZtYUM4SXJnM3gvYjRoTjZRN1RLRFVIdWNR?=
 =?utf-8?B?ZkN3OHlUVVVzaXM2ZnhYckJJYmRONzdwVStMTXBzWjdna2VaMkxkemVjWnhR?=
 =?utf-8?B?eXJnaUxJb0NtTURjS3VXVUhITjM3WDhGejk4Tm1TNWF1K3VzTFU1aXZqMEhz?=
 =?utf-8?B?bUVtd0svOEFMdWxZa2U0NGVHKzQzUXdoaXlBYStEdTRIWXBnekc0Y0pXUnRK?=
 =?utf-8?B?UUhNM2ZYZUtaNFNwNWVvTGFJRm1UR29YVVI5dERDVGFZNXNPSncrZmw0S2pw?=
 =?utf-8?Q?t9a585e1KJhxEoA+RJv6FtRMC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdd7b5f-dc1b-4b57-f93b-08db8b68e4cb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 10:38:03.6100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnfDkWKREO5Y88/o7taZdiYOb2mRl+GtOAo7Nl9IX31gMDPh3SSbqwxUpeGA9jsQ+Jxt33/pQm2FlWT5aNNIOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213
Received-SPF: softfail client-ip=40.107.93.69; envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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


On 21/07/2023 14:48, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 7/16/23 10:15, Avihai Horon wrote:
>> VFIO migration uAPI defines an optional intermediate P2P quiescent
>> state. While in the P2P quiescent state, P2P DMA transactions cannot be
>> initiated by the device, but the device can respond to incoming ones.
>> Additionally, all outstanding P2P transactions are guaranteed to have
>> been completed by the time the device enters this state.
>>
>> The purpose of this state is to support migration of multiple devices
>> that are doing P2P transactions between themselves.
>>
>> Add support for P2P migration by transitioning all the devices to the
>> P2P quiescent state before stopping or starting the devices. Use the new
>> VMChangeStateHandler pre_change_cb to achieve that behavior.
>>
>> This will allow migration of multiple VFIO devices if all of them
>> support P2P migration.
>
> LGTM, one small comment below
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   docs/devel/vfio-migration.rst | 93 +++++++++++++++++++++--------------
>>   hw/vfio/common.c              |  6 ++-
>>   hw/vfio/migration.c           | 58 +++++++++++++++++-----
>>   hw/vfio/trace-events          |  2 +-
>>   4 files changed, 107 insertions(+), 52 deletions(-)
>>
>> diff --git a/docs/devel/vfio-migration.rst 
>> b/docs/devel/vfio-migration.rst
>> index b433cb5bb2..b9c57ba651 100644
>> --- a/docs/devel/vfio-migration.rst
>> +++ b/docs/devel/vfio-migration.rst
>> @@ -23,9 +23,21 @@ and recommends that the initial bytes are sent and 
>> loaded in the destination
>>   before stopping the source VM. Enabling this migration capability will
>>   guarantee that and thus, can potentially reduce downtime even further.
>>
>> -Note that currently VFIO migration is supported only for a single 
>> device. This
>> -is due to VFIO migration's lack of P2P support. However, P2P support 
>> is planned
>> -to be added later on.
>> +To support migration of multiple devices that are doing P2P 
>> transactions
>> +between themselves, VFIO migration uAPI defines an intermediate P2P 
>> quiescent
>> +state. While in the P2P quiescent state, P2P DMA transactions cannot be
>> +initiated by the device, but the device can respond to incoming ones.
>> +Additionally, all outstanding P2P transactions are guaranteed to 
>> have been
>> +completed by the time the device enters this state.
>> +
>> +All the devices that support P2P migration are first transitioned to 
>> the P2P
>> +quiescent state and only then are they stopped or started. This 
>> makes migration
>> +safe P2P-wise, since starting and stopping the devices is not done 
>> atomically
>> +for all the devices together.
>> +
>> +Thus, multiple VFIO devices migration is allowed only if all the 
>> devices
>> +support P2P migration. Single VFIO device migration is allowed 
>> regardless of
>> +P2P migration support.
>>
>>   A detailed description of the UAPI for VFIO device migration can be 
>> found in
>>   the comment for the ``vfio_device_mig_state`` structure in the 
>> header file
>> @@ -132,54 +144,63 @@ will be blocked.
>>   Flow of state changes during Live migration
>>   ===========================================
>>
>> -Below is the flow of state change during live migration.
>> +Below is the state change flow during live migration for a VFIO 
>> device that
>> +supports both precopy and P2P migration. The flow for devices that 
>> don't
>> +support it is similar, except that the relevant states for precopy 
>> and P2P are
>> +skipped.
>>   The values in the parentheses represent the VM state, the migration 
>> state, and
>>   the VFIO device state, respectively.
>> -The text in the square brackets represents the flow if the VFIO 
>> device supports
>> -pre-copy.
>>
>>   Live migration save path
>>   ------------------------
>>
>>   ::
>>
>> -                        QEMU normal running state
>> -                        (RUNNING, _NONE, _RUNNING)
>> -                                  |
>> +                           QEMU normal running state
>> +                           (RUNNING, _NONE, _RUNNING)
>> +                                      |
>>                        migrate_init spawns migration_thread
>> -                Migration thread then calls each device's .save_setup()
>> -                  (RUNNING, _SETUP, _RUNNING [_PRE_COPY])
>> -                                  |
>> -                  (RUNNING, _ACTIVE, _RUNNING [_PRE_COPY])
>> -      If device is active, get pending_bytes by 
>> .state_pending_{estimate,exact}()
>> -          If total pending_bytes >= threshold_size, call 
>> .save_live_iterate()
>> -                  [Data of VFIO device for pre-copy phase is copied]
>> -        Iterate till total pending bytes converge and are less than 
>> threshold
>> -                                  |
>> -  On migration completion, vCPU stops and calls 
>> .save_live_complete_precopy for
>> -  each active device. The VFIO device is then transitioned into 
>> _STOP_COPY state
>> -                  (FINISH_MIGRATE, _DEVICE, _STOP_COPY)
>> -                                  |
>> -     For the VFIO device, iterate in .save_live_complete_precopy until
>> -                         pending data is 0
>> -                   (FINISH_MIGRATE, _DEVICE, _STOP)
>> -                                  |
>> -                 (FINISH_MIGRATE, _COMPLETED, _STOP)
>> -             Migraton thread schedules cleanup bottom half and exits
>> +            Migration thread then calls each device's .save_setup()
>> +                          (RUNNING, _SETUP, _PRE_COPY)
>> +                                      |
>> +                         (RUNNING, _ACTIVE, _PRE_COPY)
>> +  If device is active, get pending_bytes by 
>> .state_pending_{estimate,exact}()
>> +       If total pending_bytes >= threshold_size, call 
>> .save_live_iterate()
>> +                Data of VFIO device for pre-copy phase is copied
>> +      Iterate till total pending bytes converge and are less than 
>> threshold
>> +                                      |
>> +       On migration completion, the vCPUs and the VFIO device are 
>> stopped
>> +              The VFIO device is first put in P2P quiescent state
>> +                    (FINISH_MIGRATE, _ACTIVE, _PRE_COPY_P2P)
>> +                                      |
>> +                Then the VFIO device is put in _STOP_COPY state
>> +                     (FINISH_MIGRATE, _ACTIVE, _STOP_COPY)
>> +         .save_live_complete_precopy() is called for each active device
>> +      For the VFIO device, iterate in .save_live_complete_precopy() 
>> until
>> +                               pending data is 0
>> +                                      |
>> +                     (POSTMIGRATE, _COMPLETED, _STOP_COPY)
>> +            Migraton thread schedules cleanup bottom half and exits
>> +                                      |
>> +                           .save_cleanup() is called
>> +                        (POSTMIGRATE, _COMPLETED, _STOP)
>>
>>   Live migration resume path
>>   --------------------------
>>
>>   ::
>>
>> -              Incoming migration calls .load_setup for each device
>> -                       (RESTORE_VM, _ACTIVE, _STOP)
>> -                                 |
>> -       For each device, .load_state is called for that device 
>> section data
>> -                       (RESTORE_VM, _ACTIVE, _RESUMING)
>> -                                 |
>> -    At the end, .load_cleanup is called for each device and vCPUs 
>> are started
>> -                       (RUNNING, _NONE, _RUNNING)
>> +             Incoming migration calls .load_setup() for each device
>> +                          (RESTORE_VM, _ACTIVE, _STOP)
>> +                                      |
>> +     For each device, .load_state() is called for that device 
>> section data
>> +                        (RESTORE_VM, _ACTIVE, _RESUMING)
>> +                                      |
>> +  At the end, .load_cleanup() is called for each device and vCPUs 
>> are started
>> +              The VFIO device is first put in P2P quiescent state
>> +                        (RUNNING, _ACTIVE, _RUNNING_P2P)
>> +                                      |
>> +                           (RUNNING, _NONE, _RUNNING)
>>
>>   Postcopy
>>   ========
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 16cf79a76c..7c3d636025 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -441,14 +441,16 @@ bool vfio_device_state_is_running(VFIODevice 
>> *vbasedev)
>>   {
>>       VFIOMigration *migration = vbasedev->migration;
>>
>> -    return migration->device_state == VFIO_DEVICE_STATE_RUNNING;
>> +    return migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
>> +           migration->device_state == VFIO_DEVICE_STATE_RUNNING_P2P;
>>   }
>>
>>   bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
>>   {
>>       VFIOMigration *migration = vbasedev->migration;
>>
>> -    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY;
>> +    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ||
>> +           migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
>>   }
>>
>>   static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 48f9c23cbe..02ee99c938 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -71,8 +71,13 @@ static const char *mig_state_to_str(enum 
>> vfio_device_mig_state state)
>>           return "STOP_COPY";
>>       case VFIO_DEVICE_STATE_RESUMING:
>>           return "RESUMING";
>> +    case VFIO_DEVICE_STATE_RUNNING_P2P:
>> +        return "RUNNING_P2P";
>>       case VFIO_DEVICE_STATE_PRE_COPY:
>>           return "PRE_COPY";
>> +    case VFIO_DEVICE_STATE_PRE_COPY_P2P:
>> +        return "PRE_COPY_P2P";
>> +
>>       default:
>>           return "UNKNOWN STATE";
>>       }
>> @@ -652,20 +657,31 @@ static const SaveVMHandlers 
>> savevm_vfio_handlers = {
>>
>>   /* 
>> ---------------------------------------------------------------------- 
>> */
>>
>> -static void vfio_vmstate_change(void *opaque, bool running, RunState 
>> state)
>> +static void vfio_vmstate_change(VFIODevice *vbasedev, bool running,
>> +                                RunState state, bool pre_state_change)
>
> Instead of mixing both vmstate change handlers in one routine, I would 
> prefer
> a new pre_state handler to be introduced.

Sure, I will change that.

Thanks!

>
>>   {
>> -    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>>       enum vfio_device_mig_state new_state;
>>       int ret;
>>
>> -    if (running) {
>> -        new_state = VFIO_DEVICE_STATE_RUNNING;
>> +    if (pre_state_change && !(migration->mig_flags & 
>> VFIO_MIGRATION_P2P)) {
>> +        return;
>> +    }
>> +
>> +    if (pre_state_change) {
>> +        new_state = migration->device_state == 
>> VFIO_DEVICE_STATE_PRE_COPY ?
>> +                        VFIO_DEVICE_STATE_PRE_COPY_P2P :
>> +                        VFIO_DEVICE_STATE_RUNNING_P2P;
>>       } else {
>> -        new_state =
>> -            (vfio_device_state_is_precopy(vbasedev) &&
>> -             (state == RUN_STATE_FINISH_MIGRATE || state == 
>> RUN_STATE_PAUSED)) ?
>> -                VFIO_DEVICE_STATE_STOP_COPY :
>> -                VFIO_DEVICE_STATE_STOP;
>> +        if (running) {
>> +            new_state = VFIO_DEVICE_STATE_RUNNING;
>> +        } else {
>> +            new_state = (vfio_device_state_is_precopy(vbasedev) &&
>> +                         (state == RUN_STATE_FINISH_MIGRATE ||
>> +                          state == RUN_STATE_PAUSED)) ?
>> +                            VFIO_DEVICE_STATE_STOP_COPY :
>> +                            VFIO_DEVICE_STATE_STOP;
>> +        }
>>       }
>>
>>       /*
>> @@ -685,7 +701,23 @@ static void vfio_vmstate_change(void *opaque, 
>> bool running, RunState state)
>>       }
>>
>>       trace_vfio_vmstate_change(vbasedev->name, running, 
>> RunState_str(state),
>> -                              mig_state_to_str(new_state));
>> +                              pre_state_change, 
>> mig_state_to_str(new_state));
>> +}
>> +
>> +static void vfio_vmstate_pre_change_handler(void *opaque, bool running,
>> +                                            RunState state)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +
>> +    vfio_vmstate_change(vbasedev, running, state, true);
>> +}
>> +
>> +static void vfio_vmstate_change_handler(void *opaque, bool running,
>> +                                        RunState state)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +
>> +    vfio_vmstate_change(vbasedev, running, state, false);
>>   }
>>
>>   static void vfio_migration_state_notifier(Notifier *notifier, void 
>> *data)
>> @@ -798,9 +830,9 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>>       register_savevm_live(id, VMSTATE_INSTANCE_ID_ANY, 1, 
>> &savevm_vfio_handlers,
>>                            vbasedev);
>>
>> -    migration->vm_state = 
>> qdev_add_vm_change_state_handler(vbasedev->dev,
>> - vfio_vmstate_change,
>> - vbasedev);
>> +    migration->vm_state = qdev_add_vm_change_state_handler_full(
>> +        vbasedev->dev, vfio_vmstate_change_handler,
>> +        vfio_vmstate_pre_change_handler, vbasedev);
>>       migration->migration_state.notify = vfio_migration_state_notifier;
>> add_migration_state_change_notifier(&migration->migration_state);
>>
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index ee7509e68e..efafe613f2 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -166,4 +166,4 @@ vfio_save_iterate(const char *name, uint64_t 
>> precopy_init_size, uint64_t precopy
>>   vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) 
>> data buffer size 0x%"PRIx64
>>   vfio_state_pending_estimate(const char *name, uint64_t precopy, 
>> uint64_t postcopy, uint64_t precopy_init_size, uint64_t 
>> precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" 
>> precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
>>   vfio_state_pending_exact(const char *name, uint64_t precopy, 
>> uint64_t postcopy, uint64_t stopcopy_size, uint64_t 
>> precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 
>> 0x%"PRIx64" postcopy 0x%"PRIx64" stopcopy size 0x%"PRIx64" precopy 
>> initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
>> -vfio_vmstate_change(const char *name, int running, const char 
>> *reason, const char *dev_state) " (%s) running %d reason %s device 
>> state %s"
>> +vfio_vmstate_change(const char *name, int running, const char 
>> *reason, bool pre_state_change, const char *dev_state) " (%s) running 
>> %d reason %s pre state change %d device state %s"
>

