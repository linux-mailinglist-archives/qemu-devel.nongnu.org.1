Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE449727F7D
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 13:54:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ECi-0000sd-LN; Thu, 08 Jun 2023 07:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q7ECe-0000sE-Ei
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 07:53:20 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q7ECb-00062L-LJ
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 07:53:20 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 358AmQQl007898; Thu, 8 Jun 2023 04:53:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=f9NkNDZQJDB0hkQTbJjUxyqIHke1+pT5Sq+vr2WsWIA=;
 b=GIC8j/C2Dr+b0jDE913wyPeRlHEfhnQrEvRAOIVxxfqhunyElMgt73fWKZCzyEBDe/CV
 I6wxn5cnheMbqbDfnNIcYCJXpXyDQfLNOEzeDmyGfmLXxUmQsBEjq+ftjasQUkS96zKG
 zGC4c86vr4gTmZvvylaKogkR3ql3UNQxw23kHwHthlT/nKq1xycwjcdgFsb2ZtOiVyUf
 VT3qAHcjmX2XSv0btXbGLamvV5BcdsHI2ysqpkdqQ3I+1KTPYqLmTd6nSUzAdyKewlNM
 z0H0fikIk8U417JpbDDaHYpagmI8g1lQgBfeq9AUpya7Itu9gP0kfCgAsBG16kWic24V LA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3r2a7ac8me-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Jun 2023 04:53:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsCzmkADrsw174Bxg6Zmu6lMzbaX/e9vcNDuqoJPtcGANwk//w6BtoBOvASkrzrpErrPM2dbkhcpfe6J3jTZ8vSwwSW2THJUV3pz4Id+4st0yVsWGgLrvXLWs5kMsVWyfX8zhxqLH0HvVab3onUsxtc/Hwh8/oCGKCx9sTWdiQzkgwgroVY5ThaICJFV1km1capuAF1rOwmYMBMLZEd1J4DokMs/OYGj/OmXomL/dQC4capbXce4sgdN+fvxkqy2GWzpheHsWXZGDv2HxIHZv9qDtalqIXzLh25mf0z+NiMWtyk87gbnkwO8QpIt60d2viEmKtDuSKS0O8BDmSGKfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9NkNDZQJDB0hkQTbJjUxyqIHke1+pT5Sq+vr2WsWIA=;
 b=mS6UBOysQMCymaNPDiBzqI2do80UFVr9JZwmKyyn3bMFd8RtxjS99zmygXQ/XuoCqpnwFVZKS7ryPyCriluUmd9DzDRz2hlE37gsJoGqj9cwuOX/6aUF9A5diinMFTkUU6jtao93f+P7iJytMzeR9gwBjgFsxACmf3XqDskZEEHtAgZ7ZCPpC8tksusa8lzUZsoX7Q0s7VDknMVveu+3nIiNoM0ARfqSQWYOuSLZAHWr9NbAIZZB20UMqQAn5/T2dg0lNqHkMcHgJpMgmLTCTCWM4aqecVSo2v7Zy+KdAee8fhbQg0H2IyqSXdb1vKx5YHx+2m7Qn6y1w+5WPJtcvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9NkNDZQJDB0hkQTbJjUxyqIHke1+pT5Sq+vr2WsWIA=;
 b=ydXcjJg+19he8SpHgEczEYXtjcK/HYH0PQbBSOCelXKJgy+giXDYWzIxQBpBiLOQimJG2rNwRYIhwXmLCv3Z8yx5beQ6VnT/LOzRKXBFADdGZBN5l0mw5+iVkNotUP0x47zNt/vzQ71aja7ZRp1VGLfgjlktww+fbiIio6BocahP3ywe2P/XJlwb5X41jdWmQcN5d5a9OSJqE3CvGt49jR9GjRTCvkRAIaQGKtNXSXXs06HdGQX9yy2xbDiIElhNCccJuL7UCYOU/6/0KEFFN6a/zuLTdxf16C0WNZrdZAgOHV+p/oHzf01rHkhpkpQHNEdun318iWvAl/eBeEqqCg==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by SA1PR02MB8480.namprd02.prod.outlook.com (2603:10b6:806:1fb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 11:53:10 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 11:53:09 +0000
Message-ID: <423a4d36-c039-168e-1caa-1a40727308f9@nutanix.com>
Date: Thu, 8 Jun 2023 17:22:57 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v6 6/9] migration: modified migration QAPIs to accept
 'channels' argument for migration
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230606101557.202060-1-het.gala@nutanix.com>
 <20230606101557.202060-7-het.gala@nutanix.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <20230606101557.202060-7-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::19) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|SA1PR02MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 295a86d1-0f04-4002-489b-08db6816ed92
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +xAIBOBcUkbx2JKFKCe2xU+dXuuzJQiNx6dk46gTdZNqOAF85b0oXLPvWlHVxwOX7UNJVYvCe/kfbf2IOuC1vbYoC+eReAf9EBewBOdcl8dcg/oPfwfElsAewY1rml/eUq2DC3uJm6Hc9bgDFCRus/U4OyK2keKJEEHy0In+iChQGUs54UGlJ7MY4WXIv8Bypgb5Y4NoIZPD9QyUhToQjeMDNYHjclz9OIqq1P8xBGoTH4VoxQfZsW/UFDzpfDznAQipWyX6QQ03NJW8MLhV/OjmKuoNPXLT7krHC978Glwkicb3K2YlgdDguqcJ6NkO5bOROdFpah5Q511mfoYhlOfygNKakHMauMQs6cjnz5sPMcEUNttCQMTPWOML8JBk+qKwjWGHIbAIoX3hNlbN/HgeLb1PDodFPIby5NAcu7ElZYKcHDl5YJIjfg6Ku9/qrQdf9XIQbAuz20ktF6Cj4/yU/8uCXzP6dMmU55ks95b5LNLMYp3bS7hQnh6nucsMOnGAyDMHcUm8RRuIocy9LIPEwKdEdXRQ/PanvvVhoActDkBR6gqZJ93QD5bUOPc970rAAUbOMVTr43yesTyFLXd7WpHkwlLPXsuLsVFcbZ7cjWPjzX3xtxnu7TQsQj/mehLAZBeQzpB6uhJR1A5ZYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(6512007)(107886003)(53546011)(2616005)(6506007)(38100700002)(41300700001)(31686004)(6486002)(6666004)(186003)(83380400001)(478600001)(66476007)(4326008)(316002)(66946007)(8676002)(66556008)(6916009)(8936002)(44832011)(2906002)(5660300002)(31696002)(86362001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0hsZUFod0x3OUtiREdPT1FZRGJaNnBOMzgyQmpFZzQ1dVErYlBjVS9Gc1RH?=
 =?utf-8?B?MldGWUxiaUx5U2lYUGYrdUFsTmxQNERISHNUTDZadGZsWEExYTFnemJLVCtG?=
 =?utf-8?B?c1I4V0I0THlvbjU3QklkV0xja25NMlA3RzBuSm92anFRQ3lHV0RpbUZyMDBZ?=
 =?utf-8?B?amdPWDVncktVcTJyVmlDcFVHd1VDekdtZ3pDbXBqZCtheXZ1WGFiTDdvMnhE?=
 =?utf-8?B?WWV2clBDRUxMUmhGaHhlTGFXUkZTK1R3cWpsTURQYk1vaENlQmRXT2xnaUhT?=
 =?utf-8?B?UStocFVGaU9rVVMzdk9TU1plV0QycVV3L05yblZ3eERjZTVaeWo1bHA4MTBU?=
 =?utf-8?B?S0U4NlBWL2ptakE1NU41SnYxU3R1U2RidzNmMSt1bjdpbWpBanFUZzd5cXRh?=
 =?utf-8?B?akNYZDNwTXU3TVd3V0FQYVRma0NPUm1CM1BMb2NaQ3R6RmNLd3ZmbXEzNDFn?=
 =?utf-8?B?WnRvcU03a2Y3dWE5bzNPaFg3OUdBcEh4SzF1ZE9rNVVaaC9Td09kYklCZHFy?=
 =?utf-8?B?QUp1bEplQTQrNU01TVZ0OXZKRDhwbkIvTVl1cGdvZ2VWcFl6MVMzZlovaXdD?=
 =?utf-8?B?bjNoTGF4eUE1SWt5WWJLSG5IdW9MbEttczVWVzl1aU03cWw2QmhCMmk3V2lF?=
 =?utf-8?B?UzZVV21BQTROdFBHQVRVOTROSlRoN0Q0dURJZTZkOGhWbmJtZ280NGVIQktv?=
 =?utf-8?B?N0VlS0NiOWdkd20xdU5rMmk5eDNlbjREWHZnYnVZVW93VHljRlQ2ZWZ3Y2Nw?=
 =?utf-8?B?MjRwNjYyd2lvSW1CSGpKVlVBSUJlQmhDdFFxRTRFYnRSVGozR3lLS1dQWlgx?=
 =?utf-8?B?cEJ4a1hOOStPVzVjYm5yRHBHOCt4a1VuZm9tRXhLZWFucXpxckJoaFM0Nzcv?=
 =?utf-8?B?dVFIclBXTGRYdllJNlp0WWFBZWdCWVE4amhiTUI5U2NBREp1eW41Rzd3MUlJ?=
 =?utf-8?B?TE1VTGFQVklTNUt2OGdhbjlkS0prYmRxK2FDTU12c2ZpRFQrZ0c2MzRmZWpW?=
 =?utf-8?B?TkZWaEJIc1hGZE5pZmFpcE9NR3pMUTJhU2FoUnRocEpZU1VCZEdtUDZIQ1ZM?=
 =?utf-8?B?SFVuOFF6ak02ZURHVFJMN0c0ZFl5VlpIb1J6RGtrTG82VXZ3UFJxeWxmWjc3?=
 =?utf-8?B?eSs3cHJHeW5vRGRRSGNrK0lsa3JvNjIzZDJiNWU2R2V4cERZaE5XckFFN1pF?=
 =?utf-8?B?ZWQvbVkvOTN3Z1JPNzBQTVh4UmpnZDdGTnJ1VjIxVXlsMldSNEF4WU1VZmk2?=
 =?utf-8?B?SCsxVmNkNWFITERlNWRrVmprMzFzVklGNW1kbUpDTnJGa09ac1RVNFBrdHRn?=
 =?utf-8?B?Z25BcEwzZGtpUy9oWnBrMm5rTlg5SFJkMDE0RVVSR1RsbjhJdWRGMWtPT3Zi?=
 =?utf-8?B?VEV2ZlUyZ1pKdGxMRVE2YmpUY2FTVjlTSk5pcnhDc2Z5S3MxRGJidEkzN3p2?=
 =?utf-8?B?Q1kyOWRiU1RSS0gxQTZqcTZ2VFRkQWd1L0ozVGJoQm9nMXo0K3ZIYXh1ajZ2?=
 =?utf-8?B?M3FXZldoS3llbm1tQ3BTVTdDMHc3VFAyZ2ZpeXl0Tmx3OGJwRHVxL05IOW1a?=
 =?utf-8?B?Ti91cWhpZGhLR3hVSytvTUwyNGFhYnAyTkZYSEdacFZWWUhkSHZHYVBHc2xv?=
 =?utf-8?B?QWo0SHVxRTJBSFJxN2FPaitGbFJHODV2RXNvZEpLLzJtSlZwbEZQYUw4WnNF?=
 =?utf-8?B?UThqTFRZSklMRkZXWkppc3k3VlRGaENTc253VGFLbnVrZ0U5WVZWak1USm8w?=
 =?utf-8?B?SUt2MjB5ejRoU1RyNC9ZeDVXc3JzQlpPQ2FKWDVyZGVseTFReWYrMTNOUWV0?=
 =?utf-8?B?cUpBajQ5SEN6T1NONk1KV2U3eTJKMWZFSXg2Nm9YbXRqRFpiV1RPNEdIK1d6?=
 =?utf-8?B?dHdVN1pXM2JzTks2WllHbGEvOEhvVTlWYXVRVy9wZmZKOG5aWnFNT3QyTGhK?=
 =?utf-8?B?dG45eEs5SW55UVZkdCs2bzAycGJ4VmRncFBWQVRabHpNRDhwY0gwVGNlYkM4?=
 =?utf-8?B?d2JmRkpkSHNTRk5XWlZoSmhBcUxJOFhtZk5vMzRpNitqaXdEWUhQMkttZWdJ?=
 =?utf-8?B?cVJ6UkhPbW1JYi9nTGRKay82WUN5NEplUC9UNXRHdXBlUHdaZUpBL1dmY29D?=
 =?utf-8?B?YVFrRzVLY0N1bVlLenA3TjVLQ3N0VEorVGtxeFZuMnZCclQzQmZ0Vmg4V2kx?=
 =?utf-8?Q?0omUxIvCbh4BJS6egtfFnEoIdZMRrCoVksw7idJHI1yO?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 295a86d1-0f04-4002-489b-08db6816ed92
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 11:53:09.1165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FR8NYeopoce5BixZqFisXny0/DkbcKxemKi8nXjchQD7UgCxHbHzYO7L+xzjpdFEfXxXsDHUYEXOGWzaFV9rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8480
X-Proofpoint-GUID: NfT7QYWWWNlZoq8vnld8nGmJdeH5amep
X-Proofpoint-ORIG-GUID: NfT7QYWWWNlZoq8vnld8nGmJdeH5amep
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_08,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 06/06/23 3:45 pm, Het Gala wrote:
> MigrateChannelList allows to connect accross multiple interfaces. Added
> MigrateChannelList struct as argument to migration QAPIs.
>
> Future patchset series plans to include multiple MigrateChannels
> for multiple interfaces to be connected. That is the reason,
> 'MigrateChannelList'
> is the preferred choice of argument over 'MigrateChannel' and making
> migration QAPIs future proof.
>
> For current patchset series, have limited the size of the list to single
> element (single interface) as runtime check.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>   migration/migration-hmp-cmds.c |  16 +++--
>   migration/migration.c          |  34 ++++++++--
>   qapi/migration.json            | 109 ++++++++++++++++++++++++++++++++-
>   softmmu/vl.c                   |   2 +-
>   4 files changed, 147 insertions(+), 14 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index e61d25eba2..7d4160e130 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1452,6 +1452,34 @@
>       'exec': 'MigrationExecCommand',
>       'rdma': 'InetSocketAddress' } }
>   
> +##
> +# @MigrationChannelType:
> +#
> +# The migration channel-type request options.
> +#
> +# @main: Main outbound migration channel.
> +#
> +# Since 8.1
> +##
> +{ 'enum': 'MigrationChannelType',
> +  'data': [ 'main' ] }
> +
> +##
> +# @MigrationChannel:
> +#
> +# Migration stream channel parameters.
> +#
> +# @channel-type: Channel type for transfering packet information.
> +#
> +# @addr: Migration endpoint configuration on destination interface.
> +#
> +# Since 8.1
> +##
> +{ 'struct': 'MigrationChannel',
> +  'data': {
> +      'channel-type': 'MigrationChannelType',
> +      'addr': 'MigrationAddress' } }
> +
>   ##
>   # @migrate:
>   #
> @@ -1459,6 +1487,9 @@
>   #
>   # @uri: the Uniform Resource Identifier of the destination VM
>   #
> +# @channels: list of migration stream channels with each stream
> +#     in the list connected to a destination interface endpoint.
> +#
>   # @blk: do block migration (full disk copy)
>   #
>   # @inc: incremental disk copy migration
> @@ -1483,14 +1514,50 @@
>   # 3. The user Monitor's "detach" argument is invalid in QMP and should
>   #    not be used
>   #
> +# 4. The uri argument should have the Uniform Resource Identifier of
> +#    default destination VM. This connection will be bound to default
> +#    network.
> +#
> +# 5. For now, number of migration streams is restricted to one, i.e
> +#    number of items in 'channels' list is just 1.
> +#
> +# 6. The 'uri' and 'channels' arguments are mutually exclusive;
> +#    exactly one of the two should be present.
> +#
>   # Example:
>   #
>   # -> { "execute": "migrate", "arguments": { "uri": "tcp:0:4446" } }
>   # <- { "return": {} }
> +# -> { "execute": "migrate",
> +#      "arguments": {
> +#          "channels": [ { "channel-type": "main",
> +#                          "addr": { "transport": "socket",
> +#                                    "type": "inet",
> +#                                    "host": "10.12.34.9",
> +#                                    "port": "1050" } } ] } }
> +# <- { "return": {} }
> +#
> +# -> { "execute": "migrate",
> +#      "arguments": {
> +#          "channels": [ { "channel-type": "main",
> +#                          "addr": { "transport": "exec",
> +#                                    "args": [ "/bin/nc", "-p", "6000",
> +#                                              "/some/sock" ] } } ] } }
> +# <- { "return": {} }
> +#
> +# -> { "execute": "migrate",
> +#      "arguments": {
> +#          "channels": [ { "channel-type": "main",
> +#                          "addr": { "transport": "rdma",
> +#                                    "host": "10.12.34.9",
> +#                                    "port": "1050" } } ] } }
> +# <- { "return": {} }
> +#
>   ##
>   { 'command': 'migrate',
> -  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool',
> -           '*detach': 'bool', '*resume': 'bool' } }
> +  'data': {'*uri': 'str', '*channels': [ 'MigrationChannel' ],
> +           '*blk': 'bool', '*inc': 'bool', '*detach': 'bool',
> +           '*resume': 'bool' } }
>   
>   ##
>   # @migrate-incoming:
> @@ -1501,6 +1568,9 @@
>   # @uri: The Uniform Resource Identifier identifying the source or
>   #     address to listen on
>   #
> +# @channels: list of migration stream channels with each stream
> +#     in the list connected to a destination interface endpoint.
> +#
>   # Returns: nothing on success
>   #
>   # Since: 2.3
> @@ -1516,13 +1586,46 @@
>   #
>   # 3. The uri format is the same as for -incoming
>   #
> +# 5. For now, number of migration streams is restricted to one, i.e
> +#    number of items in 'channels' list is just 1.
> +#
> +# 4. The 'uri' and 'channels' arguments are mutually exclusive;
> +#    exactly one of the two should be present.
> +#
>   # Example:
>   #
>   # -> { "execute": "migrate-incoming",
>   #      "arguments": { "uri": "tcp::4446" } }
>   # <- { "return": {} }
> +#
> +# -> { "execute": "migrate",
> +#      "arguments": {
> +#          "channels": [ { "channel-type": "main",
> +#                          "addr": { "transport": "socket",
> +#                                    "type": "inet",
> +#                                    "host": "10.12.34.9",
> +#                                    "port": "1050" } } ] } }
> +# <- { "return": {} }
> +#
> +# -> { "execute": "migrate",
> +#      "arguments": {
> +#          "channels": [ { "channel-type": "main",
> +#                          "addr": { "transport": "exec",
> +#                                    "args": [ "/bin/nc", "-p", "6000",
> +#                                              "/some/sock" ] } } ] } }
> +# <- { "return": {} }
> +#
> +# -> { "execute": "migrate",
> +#      "arguments": {
> +#          "channels": [ { "channel-type": "main",
> +#                          "addr": { "transport": "rdma",
> +#                                    "host": "10.12.34.9",
> +#                                    "port": "1050" } } ] } }
> +# <- { "return": {} }
>   ##
> -{ 'command': 'migrate-incoming', 'data': {'uri': 'str' } }
> +{ 'command': 'migrate-incoming',
> +             'data': {'*uri': 'str',
> +                      '*channels': [ 'MigrationChannel' ] } }
>   

Markus, I have tried to make the definitons short, compact and 
meaningful. Please have a look at it once again, and add your 
suggestions on what looks wrong. TIA!

Regards,
Het Gala

