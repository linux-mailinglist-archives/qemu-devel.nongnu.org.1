Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 070F57069C2
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 15:24:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzH8f-0005Yc-1u; Wed, 17 May 2023 09:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1pzH8P-0005Sy-3B
 for qemu-devel@nongnu.org; Wed, 17 May 2023 09:24:05 -0400
Received: from mail-mw2nam12on2062e.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::62e]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1pzH8K-00029C-NN
 for qemu-devel@nongnu.org; Wed, 17 May 2023 09:24:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vq7OaiG86/CiFVZ6EnNMzoxMSve17a8vXx4JF/Oq90VJgAJf9sXtdHpRxR/PLtzrtfiK7WTINZhmJXHjeucv1RgISD8NHchFeAQdszI//NJgvhzXXpWakPUjcZOov4AdIdy+7BYquQBOTTd618sKpIPW5qX66U1obySXUW9PkbayfUPEbvG7Ye6V/Ii5Gp0L7jbhO35h0CiK8cVsn9wRCDrIZkDvrHWBQPqD/nTGYpS9NHotSh6QVKLQS9x/jraMjmQGXt4lFeOst3EZzPkKKHgxdcfRm4+WuNUdr6ZbcIuAaRQtvOrYyBcqKgaZF7jHEoEJe88dtdu4TQTkImCg3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9q72FjJDwyRBLXuyk14eg9ZrF9wU/71onL/7DTUHFM=;
 b=clAuT9/5OV83nUKVl9yaJPhc4Rbvoj8oW0Iv7XtaH5FLu7ZPTAdlRSOpXi/zp8RFF6Jkp8eD7SkGigHd0GjuLCJG2dkpxu1LNq09cCWQdzICaei888nUeykcg6gUOKKw00tu+CyfEQ2NC6bP5u+mfodMEfzzPNLhQ0453v6hu5yPtB6e06BSm7bZNW+w+12PzJeROc5JLso7JpQ8JT2iPLHkxLHBj5X7tb3XnbdnTLiz18dtCWLMViuKYVJms3aIknZVjusl3LVTm0rjpEnsIRMynMVhO25GdVzT7WBRfuhi5pLUgsBa//tl6gXbTsTt2YCyA/cekI+p1/E4Pm365A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9q72FjJDwyRBLXuyk14eg9ZrF9wU/71onL/7DTUHFM=;
 b=EsZFhR3i3uFbWwSCjrIZzXgocO9VNMq/HBE2ueku62vB1Bv0AJVbgr1xZyguqsAWFAu4By5bbDxlk0ZbV4FtXHbhyTrp7LwXSCHzICC9xiddg45aAU7n93FvM2dw/3/P8vl07PC941rllm5/jaS0vZqoH5sWH7+37fDDNh2I2owELC9idpDYd+uj2gxrvu934AF7/VSIsi+nO27DehGUjznl0WoPphlUPqH93ZaJ36a5Fv6uHgdSMEn75jJaHLFpKNTy4w0EDZcZuaqgWef1lPNXZRoqHC8pvIRegcUv1bJ2+B9e7t64J52Kg6c1tUtmnUiSPh9EbXt+dasjxa/lfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 13:23:54 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::a29a:c3cf:5edf:9dad]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::a29a:c3cf:5edf:9dad%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 13:23:54 +0000
Message-ID: <93212792-c244-0c13-91d9-d7556f3be41f@nvidia.com>
Date: Wed, 17 May 2023 16:23:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/8] migration: Add precopy initial data capability
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20230501140141.11743-1-avihaih@nvidia.com>
 <20230501140141.11743-2-avihaih@nvidia.com> <87lehn71wm.fsf@pond.sub.org>
 <1836389d-0774-08a1-ef54-8487d238fe73@nvidia.com>
 <87lehn2lnh.fsf@pond.sub.org>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <87lehn2lnh.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P192CA0021.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::26) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: 26142cd7-ea27-4cb3-4c1e-08db56d9f62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vh+jBuV6ea+glo526Fo8/pDLonMve1ZNfSQgnrvE/WaDvi89G3ElJlIvm5K925l8SJ4wktlElzgphqL5ogdbiyhSC7DJeOLkOL099nLR52mwIGm5o96Slu/VUdAjnmuR9zUFjdsX2qdB5FpejDIv3PBQqeWx2/m9HpluZAJiyx5ycnoU+1zehVDe/ujDqCh1ALcKsUkxV4tWpVPDhg1Z/IfWZfzrEssqle+ZKJW7G/CSlbEfsehjpoo6Z+fpH5mqqOf9B2mAYzwzBr2kLNS3AUCTlaexQrUOJDBO/EyEHEJDbGa54IYbDMhw658WzYGpQaW65WqONJIUwiLV2+Et9I8XDyN/+RtxqhuyAJuGEfN7d8qOslIi4cJPxadrWG+Dcn2K7Pnd8c8AtCCa9JMF22OnmJPcgizLB83QO8hlqLAjFdWxFDPWcaCJgSbkOeteB0daY6FzZVyHFeG5cu9Ol5uvBmUn+BqYhP43EqdCmLLEet/CR3V6SvPbpYOpBAdxgGzqhtUwK+avLKNmdzWbSgWI0tmvappW/JwCw39B2G2yrXCTCeF90rpuBo8P0XH8mIC/7uZXh5UMhkxZPdb3YQf0WTW8O3wUpvtGgtX2UD6/PQ9dyLSdB4D2cPSYdZjOa4pIlaR5o1psPLKTRgvPwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(7416002)(966005)(8936002)(8676002)(5660300002)(83380400001)(186003)(2906002)(2616005)(36756003)(38100700002)(31696002)(86362001)(53546011)(26005)(6512007)(6506007)(478600001)(6666004)(41300700001)(316002)(66476007)(4326008)(66556008)(6916009)(66946007)(54906003)(6486002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk9UWWhKYWdyWVV5VWNhZjB0NEVuWjdsSHZwcVpScGhlS3A4aWNjNVFtdlg4?=
 =?utf-8?B?MHZIRy9vY09mdzZtQVB5c05yeThVK2lxU1Z6VHo4UTFITkRzZTNxQ2xBWTkx?=
 =?utf-8?B?Qy9aT3dVWFg5RjhpL3VVQ1RwTVdiVGNKMXJJYTl3eXEwMGl0WGJUSEhpMGh2?=
 =?utf-8?B?RjhFWkZaRXhWS1pUeDc0aEJuU0Q2VGF3cTFkQnd4aVNSZTUrLzhNdWowVnNr?=
 =?utf-8?B?d0wySXVwaUE5SENOeHQ0T2dMcjRCdmRwZ3p0ZW9pNnJHalZPWHFnU0ZBN0pB?=
 =?utf-8?B?cWRjYmFXb2tLK1U2UVorNFcxSWVTQU1USHV2RHR0bmptOWxUNXE3K3RiQmlD?=
 =?utf-8?B?cXJVZzBIRVJyRWtjTnBGamV1cTRaVTM1QUNOUnBHWUtRRHlUbTRVclB4MExm?=
 =?utf-8?B?SVl4Y1k3Z0RrK3lpSHpXSVE5OWMvQnl0YnFlZXQ4Qy84QUVrcVNLR3VQR0RH?=
 =?utf-8?B?czhWWTVJL29XaGdHOHN3RXVXc0RhQm5lTDJ0U3EzT1RHbDdPb0g4dXpUM1M3?=
 =?utf-8?B?QURYRGg2SE9hYTZEbWZLcitOK05ONFlJVkRFWWJWODRQQkpIQlJyZ0xaRUls?=
 =?utf-8?B?enExWjk3cmRyRlkzRWZXYXFvS1FvMVhWYUtndlNmR1ZQV2R3UExkbnhneTA3?=
 =?utf-8?B?RGhsR0JWam9wQ2tvTE10N2l6Z1FQWUdaOHYwcmFicGg4bEo5R0tYSUlnaTEw?=
 =?utf-8?B?bnRkckwzaWFtbkN2VnQyRXNzSS9XdXZwRUo5SEdSMTZVMFBsQ0t1Z2k4QXVT?=
 =?utf-8?B?MUJrSitpM1RhaG9UclY2b0UxdEN1ZWJpVXByQVAvUTlZSWJjUTdoQk1vc1NS?=
 =?utf-8?B?cm55UkNkNGtrNWpuQm1JSEVMZVlqRDcwa1ZmUUtPZGpDTnFYQ2dRc1psWEhG?=
 =?utf-8?B?R1ZxZTIyNHBLVnRsdnBKS1Fxcy9qcEF6Uk1valJpL0NtQlZLKzZlQ1hoUzN2?=
 =?utf-8?B?cXlnZ3pFTE85OVp6cTRPTksrL0NzelUxYnY1UWVqL2VocE9HejJoWDBPNTlk?=
 =?utf-8?B?blBrOXg3M3JHQ0lDczYzdUtndGtVMUxkM0pjNXpVdXY5eTF3RDJSdUxCVmly?=
 =?utf-8?B?Z0tVYlVoTlo3U3BGOFdJMUp4a09sM1VtSU1LZjdjeGpGUTkrN2VXNmFxb0t4?=
 =?utf-8?B?MFVmMDlwL3F0Q0pBMURBWnVNUEREQWZJc2w4c1pkM0c4QjViM0szRFEyZTl2?=
 =?utf-8?B?cEsydTVyQVdRT3p4MWt3MWcycU1BdFlBMTBXTTNPa2RSOGdHSXl0M2dEaGx1?=
 =?utf-8?B?WHNmeWM4LysrOHJUTTM2VGEvRlNOV3YwSnlWVDg4czlIZXpFOHdlS3BscU1z?=
 =?utf-8?B?aHZvVlNkbVpqanRvcmNPc3dKTzU2VkoyVnFST0hJb0puTVVjaG1KNDVvTW94?=
 =?utf-8?B?N0Q3WTgxUVdOdUxTaS9vem1xNmUrczl1dEtvdTI4N0Qzd0ViVnJJRnZUMFBN?=
 =?utf-8?B?VlFINjJkdGpIMUJLNGpUdytiSmhOMFdnRk5RMjZZNG12ajNHVWhDUVhnODNt?=
 =?utf-8?B?OCt2bzZYbVdqZFVjS2pwRCtHbHlxL2dxcVFZKzRlckErWkk4b1hoWmxtREw5?=
 =?utf-8?B?aVhIRWZ2Q2t1ME1oKythTXdoTmpSS3dPQkp2UXVuU2pmWHFETlgrc3V1Z2pp?=
 =?utf-8?B?aFV2WElOandEcll0WVg3TXBTUVJQZDNzeFlsaVdWK0RXTjMvTGtncDVMZVdP?=
 =?utf-8?B?cjJxSDkxa3BIRlVCZkRCUGl4TjQzRXZwV245TWRJRXBWcnNoYndPUEpnL1V3?=
 =?utf-8?B?RnVXMXBMQkhIM2hCRHVFR002eElyRVpYbUdoNnBzSVdiYmNVU0EzWjdReE1W?=
 =?utf-8?B?a000cllFc2w0L0FxanJOc2FidDdkdVhwcUVVMUc1MVZOWGJwYTBEY0NsWTBa?=
 =?utf-8?B?Y21SdW5WWkhoSmk4K0d3Q25CREpXUnY3RStlL0h3ZnZKY1dKRjFXTjJYVytZ?=
 =?utf-8?B?RDRObGRBTkRmYmg3dmtMUWNiajgyOXNyNFg3Yy9pWVBYcEZjY2pTWndZVWNr?=
 =?utf-8?B?QWZjYUpuck9mdWFidTU0MlJ2ejhGMndZQU00UVhrOVhVTURDQlRCQXVZNVJE?=
 =?utf-8?B?NnpkS1N1V050Qkp5ZHFHeWovR0J4a1loYXZVNHlrNEQ4NWt4a0lubk5NOWtM?=
 =?utf-8?Q?zGcOOH0GqDc7ZhwjE12i4/2RB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26142cd7-ea27-4cb3-4c1e-08db56d9f62f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 13:23:54.3377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9dpBwbUW/EQP3BhhkZ1ALrEFWwzgUV1U+UiLX+syCuUgaJAd3gOFZDxIxe8u4RFWtqpA2VVapYwzENI+Zrb3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::62e;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.412, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 17/05/2023 15:21, Markus Armbruster wrote:
> External email: Use caution opening links or attachments
>
>
> Avihai Horon <avihaih@nvidia.com> writes:
>
>> On 17/05/2023 12:17, Markus Armbruster wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Avihai Horon <avihaih@nvidia.com> writes:
>>>
>>>> Migration downtime estimation is calculated based on bandwidth and
>>>> remaining migration data. This assumes that loading of migration data in
>>>> the destination takes a negligible amount of time and that downtime
>>>> depends only on network speed.
>>>>
>>>> While this may be true for RAM, it's not necessarily true for other
>>>> migration users. For example, loading the data of a VFIO device in the
>>>> destination might require from the device to allocate resources, prepare
>>>> internal data structures and so on. These operations can take a
>>>> significant amount of time which can increase migration downtime.
>>>>
>>>> This patch adds a new capability "precopy initial data" that allows the
>>>> source to send initial precopy data and the destination to ACK that this
>>>> data has been loaded. Migration will not attempt to stop the source VM
>>>> and complete the migration until this ACK is received.
>>>>
>>>> This will allow migration users to send initial precopy data which can
>>>> be used to reduce downtime (e.g., by pre-allocating resources), while
>>>> making sure that the source will stop the VM and complete the migration
>>>> only after this initial precopy data is sent and loaded in the
>>>> destination so it will have full effect.
>>>>
>>>> This new capability relies on the return path capability to communicate
>>>> from the destination back to the source.
>>>>
>>>> The actual implementation of the capability will be added in the
>>>> following patches.
>>>>
>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>> ---
>>>>    qapi/migration.json |  9 ++++++++-
>>>>    migration/options.h |  1 +
>>>>    migration/options.c | 20 ++++++++++++++++++++
>>>>    3 files changed, 29 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>> index 82000adce4..d496148386 100644
>>>> --- a/qapi/migration.json
>>>> +++ b/qapi/migration.json
>>>> @@ -478,6 +478,13 @@
>>>>    #                    should not affect the correctness of postcopy migration.
>>>>    #                    (since 7.1)
>>>>    #
>>>> +# @precopy-initial-data: If enabled, migration will not attempt to stop source
>>>> +#                        VM and complete the migration until an ACK is received
>>>> +#                        from the destination that initial precopy data has
>>>> +#                        been loaded. This can improve downtime if there are
>>>> +#                        migration users that support precopy initial data.
>>>> +#                        (since 8.1)
>>>> +#
>>> Please format like
>>>
>>>      # @precopy-initial-data: If enabled, migration will not attempt to
>>>      #     stop source VM and complete the migration until an ACK is
>>>      #     received from the destination that initial precopy data has been
>>>      #     loaded.  This can improve downtime if there are migration users
>>>      #     that support precopy initial data.  (since 8.1)
>>>
>>> to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
>>> to conform to current conventions).
>> Sure.
>>
>>> What do you mean by "if there are migration users that support precopy
>>> initial data"?
>> This capability only provides the framework to send precopy initial data and ACK that it was loaded in the destination.
>> To actually benefit from it, migration users (such as VFIO devices, RAM, etc.) must implement support for it and use it.
>>
>> What I wanted to say here is that there is no point to enable this capability if there are no migration users that support it.
>> For example, if you are migrating a VM without VFIO devices, then enabling this capability will have no effect.
> I see.
>
> Which "migration users" support it now?

Currently, only VFIO devices.

>
> Which could support it in the future?

Any device that uses "iterative migration" [1], such as RAM, block, or 
some new type of device in the future.

[1] 
https://www.qemu.org/docs/master/devel/migration.html#iterative-device-migration

>
> Is the "initial precopy data" feature described in more detail anywhere?

The cover letter of this series contains more info on the background and 
motivation behind it and also about the workflow of the feature.

>
>>> Do I have to ensure the ACK comes by configuring the destination VM in a
>>> certain way, and if yes, how exactly?
>> In v2 of the series that I will send later you will have to enable this capability also in the destination.
> What happens when you enable it on the source and not on the
> destination?

Migration may fail.
For example, this is what happens if I migrate a VM with a VFIO device 
and enable this capability only on the source.

Thanks.


