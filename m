Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C768715935
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 10:57:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3v9n-00073n-8Y; Tue, 30 May 2023 04:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q3v9k-00073R-L8
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:56:40 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q3v9i-0000E1-LI
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:56:40 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34U1bcVN020114; Tue, 30 May 2023 01:56:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=Ng4GG1eUausDrLFwy2pi+lFz/b1OtteeZlQPvjBhXjs=;
 b=yL5zEZu8U46dSvjiW5JswyjikGJvOjRkrG15rvUCx0wbxprkLv2LvRmb2x3jA+0+RUmk
 Zkqk5JSnUn/iN/UtOsWCClwmXa8vOYf78oQBNcr7CbwVhC27FgIZw+Xlo7fstsbOquDY
 ghegfhMkHdKvdvdFn1HS4iZ0qctkKzi6i3SN2ua4qcvZtE9iHSEStBIojB9uN8xbS58M
 +WqmMcxSqjywmzOsoSQcsaMoCYSGuz9W2raIQ3npid9YpGOFGA7riRRKcEiaxQdkDUv1
 E9Uu8cTXFPD/ibEsuH9QoZPRzd5fokbAzb3CwAUEvv6AEJkInXXwMdTzsUtEPck/XtW3 hw== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3quhcxpmr7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 01:56:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJ7Ptzp1Je3MLA0NmkclaPwKgJJkSi6UCV8axS1IYXTwNPBMbAp9OnaOceIrvs/tU7vbZAtecQ5uD5oX4RTuJy8I5BtRb5KHUZpgrIUwTDMMqS1gWMkc6c7VLwNjDVzcs7p+a8XnVBdxvXbe/QGYYsT0cvlvQISbz/h/oYbQCjlAvO6rT4qffeum9ORjHJKDiE/Shp+bg6Kf8jD1eT+FyDygn/s6Ynk1PcH/h77oYGfR4pO51R0W9uHxxCJhv/524mYBQXv5hDQdxDhw/oJX2cEmN0YpSksa8DOZhCpfWfH1xhqrkFsItNDjRGg2sXxYPWDNGMIYXW+U0vodUitoDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ng4GG1eUausDrLFwy2pi+lFz/b1OtteeZlQPvjBhXjs=;
 b=ee9KpfVehAXcCHAUVd3nFnIADxidykqfmV+ipxCMjlDoCHBfq8o4kAr4z1gZHDNdY50z5st14RUC3vNKhQ0GcZeJqv/bwrAFqa+jD8n2GutZHL0SAy5Mj9GK7udU+D3uqWsKl1E1LPmf1Vn4lFMMh54NR61e1deoL23G1kfQ6eCmrmuTo/myNhSq+ObJAlenaeGLyCneFILEONZoxY7LZ/RbQo6WIimsLlhdrWQzhL+hOuJnICypgeqF1TG0We7PdUwpOWAfAR+D362wCT9mVE6lsYJLYorrSH1P1a13PsvkHvRTjkdiwoao16XWeOhTCxzwVl7jVrv5iE14pOg+GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ng4GG1eUausDrLFwy2pi+lFz/b1OtteeZlQPvjBhXjs=;
 b=QCqsZwQrkLEl8R4gpn1hakqyqyqrpM6ShrWn+OZUnLx3nu5qFwG/koeOfMLy0NRyGhiIV3bJkQhRvHZNovb+epYaGmrCNV+aIM+l2554YbXlaW62vR+TgDBeNnnym8qiBJ2wOsCZecM0Im/f0K3/4W/2kaq0lCSeHMnqQS00nbpNm70xEOWgqlO3x3TWxIeoC6Qsd7EZ59ME0luFP3u9moKNBwz/mPmNxYQrV1NySqA4NRYe0GoxFT+nyCSUQstLGXGiHtGQXxszOFUS2jEOF1AB/eRnTJ/M7A/e730NkhH3xs+fWj1jIqkw4C/+qe2Zp3zD2bAZMC/C0iCVx4k2NA==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by SA0PR02MB7147.namprd02.prod.outlook.com (2603:10b6:806:e0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 08:56:34 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::1a4c:7e55:b776:43cb]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::1a4c:7e55:b776:43cb%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 08:56:34 +0000
Message-ID: <fde7d182-0744-d907-5c1d-3f60f9a5d19c@nutanix.com>
Date: Tue, 30 May 2023 14:26:23 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/9] migration: introduced 'MigrateAddress' in QAPI for
 migration wire protocol.
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230519094617.7078-1-het.gala@nutanix.com>
 <20230519094617.7078-2-het.gala@nutanix.com> <87sfbkjow3.fsf@pond.sub.org>
 <af2e5fbe-75f5-d6dd-df8c-8894cc5b0056@nutanix.com>
 <87edmyuwzc.fsf@pond.sub.org>
 <99b3e516-2a4a-aa48-8bc2-7bb886b8db52@nutanix.com>
 <878rd6tfqi.fsf@pond.sub.org>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <878rd6tfqi.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::8) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|SA0PR02MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ebecb26-4b8e-47c9-3e63-08db60ebc4e3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZIgmzDzOKj87O9xDMDaESDE33kz2AQHKozhuuB+kFd5lPKPD3Qgu0a1DB8PhGcAIy9EaK4TdLaDV0P5zefP7RjgadQoMXBE+hY4VQCRT8Zkd2kGwDJP8QTG6NMi2/B1pRUtm4fqg8pysdRDtBqrTkkBHUVGQkXXKcPml2kk27vzkCUCIZTGdIfl6+zhzADbCPBN6dYIKrVmSJvZAw6wLTniQDGREL5t+hhZTMXAOJZv+3rIeW04mAZcx5BA6KYoSh+9Rz7KAUB/L+8NpCePGIV7d7lDI1gVSmdIrUUWdH+r6/MAAzjegkWJ0ISYggnurSC0BYl1nc+QZbuUwsIl76KJxR8m1go8636PfwGzHLRriLPLmqHIuDWYWXQaCFGPpJ5nT16fgIfZ4kO2SptQCwT8YsL2rAe/GtwHQs+Hbsxei1ml4LpkfMrQCz3EfNhEUrV5+3a0y3pDdp5NI9ZJMnR0oslQZrIV0RLQfdhDYxU+TrLpP3lgO1hxxjftuYBu5Xmuyd4VlAyvpK7cvkLdsX7q5SHfs+M4m2qxBDo8s7ph+vCED/TIcGDZI9JpWJsSRmyhhCoEFqF70aITwasWzOeT9LuSv3BdWU387ami4WC58WYO19TDfe4E8FEEoEwsXLdj9w2e6Q0lyffA9hsQ9vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199021)(186003)(107886003)(2616005)(38100700002)(41300700001)(31686004)(6506007)(6512007)(53546011)(26005)(6486002)(6666004)(478600001)(4326008)(66556008)(66476007)(66946007)(6916009)(316002)(8936002)(8676002)(5660300002)(44832011)(2906002)(31696002)(86362001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amI5MkNCS2M0SWdDYWhGS1BGcFdoZkszQ2JLOEM3MjZsa2F3NVJ0MDEydC9H?=
 =?utf-8?B?ZWVDR3F0alJVSFRWQm1tZmZIUlJZbnlkQ25HVXRhaUlTVWdpYVJTck9FYVBX?=
 =?utf-8?B?VWxzZ1lKeHI0R0t6QWpDK1NyWHFLdVRPdFJpZ0xHeEJVU0NWTytFd3lIU1Qz?=
 =?utf-8?B?VC8yeHlkRDYveXJ3cUJWUGVBSVhuR3BTOHhLTDk5ampRZ2NwUFdhQ2E1OTBk?=
 =?utf-8?B?N3dzRGhMc2R6Y0hlaHBXZzZEMGhqbmtsbTFWcXdJNGovZWdQaVEzOGl3YUwv?=
 =?utf-8?B?Mm9PVmhJbzBvc1pEcUhFL0NrRUFjNFUramhxbW9kNyt3RmtVZ05GbjFRanVI?=
 =?utf-8?B?MGpheDZqQ3ZWZUhiUkJGNHRQNEhjbCtBbzgyV2t1RjdOTlpOMGh6dXBDcE0v?=
 =?utf-8?B?Y1FTWWl3aGpwTG5YMmQ2WlFXN1BGMml6SlR4L21EcVNDOW42MGxKejBwNkEr?=
 =?utf-8?B?akRFdGduSUduUHhOc0I4TXpuZ0dwVklYK1BzNjMzVWVndlZhNmdpb2Z1N0ZG?=
 =?utf-8?B?b2NYSFdiYkNadzZPYzYrQ051dksxRDJYbktCc0hlU0lTMWIwYUFEaTRKWkhs?=
 =?utf-8?B?c1RwZGRkdzFZcGxDRER0Rit0TllsMFdpQ1VPU1ZwQ2RsS1QxOE0zRjBnQ1Ju?=
 =?utf-8?B?SkU2RmxlOHRTUzRoOGE4UWFWMHFiWG01b3FYb2wzTDI0d3huQ0UySS9aRjky?=
 =?utf-8?B?NmkyMVpRalV3LzJ5d0tsODRhUUV3NWFOcHdIdEkrTjBhcXRuVlBaZTFlcHY1?=
 =?utf-8?B?ZDg5UG1XRG5ReEVwRlhyKzJPeUl6OFFBZXllZ0ZSOTlLVkdYUGVQeW1RbFNH?=
 =?utf-8?B?M1lzRVBHL0Y3RHZEVmlRZVgzc1FXMURNNjRmaE5YN3pzUklKa29mcGpKUjBs?=
 =?utf-8?B?ZE9TN3JTQWxqcWgvOGFQVUhUenVkQ09tRUd3N2JVcjJONSticDUzS2pNS0hN?=
 =?utf-8?B?RTFtanIycEFZUkk0b2RSMXY0QmdOZXF1U2RVZ0p2N3BST1pLWjhoWUFTSXI2?=
 =?utf-8?B?N01PVkF6WUJjRkk1czNrREpBdXFQeEFDL3U3RitndVJKQVZQMkVyQW9YSGlI?=
 =?utf-8?B?ODRnVWE4Ti9HTjNXWFpwSnhMWFlLZVpXOU9IR1F6cE9XdXhRTjFIR3B1VnM2?=
 =?utf-8?B?SXd1VkFpV1VOVDlGclhaMnpJcjhraUN2SExLQW13b05OQTA3QjlESFFwRGFp?=
 =?utf-8?B?KzhwOGsxUit0YWRqSTJOQmNrSW4zS1VFUnpRZHlEb2tVNkpPWjdadlVrcjE2?=
 =?utf-8?B?TVpNa1pWd2xTWFVRRWJDTDRVQ2JhVzBjSDZCZUxxUzhmSnV1dFVqcWs0aFRs?=
 =?utf-8?B?RFRiM2JLT1d5c1cyRVJaaXBESmJScCtXeEVxVktJeElDR0FQSWRYMThTOG9i?=
 =?utf-8?B?TWZETE1KSXlhNy9tVXY5dVJZRm11S0tPdGxCY1JaTXdoM0ZmQkVNV2YyUmVu?=
 =?utf-8?B?QkdETkRZczNFeko3VXhPV1czYmdZRVFPeGJKbnovbEpkU01DSHFmdUk3VDN4?=
 =?utf-8?B?anI0RFgyWjEraWx6OG4zaXJ5RmFwZ2xhN3Fud01oTW8ybDVtSUhqYW5uTHRa?=
 =?utf-8?B?TUdrM0RHaFhLOXJ4Qi93YzJSdEFzcnQ1VmIrYzM3R0ZjUXJjZ0ZTaFpFTlhv?=
 =?utf-8?B?ZEVvdGxORHYyamU5WFZ1RXlGN0JkVjRrdklZdGJrUEw1Y0pKMTZ1cWVGbVJV?=
 =?utf-8?B?ZjNzcDVic1NVLzdZOVROSkE2eFM4WGRmbDYxcUdRTlRxODRJQjZkaTY4TFls?=
 =?utf-8?B?dUxUdEJtRDdNSmxERDRlbVMvSzNYaWhqM1ByNVJneEl6TmE4WlNoWUd4alJN?=
 =?utf-8?B?VC9JVEVEYjJ4L21YZnI2VGo3bnpITVcwWlJUS1dTUWVNL09TemwyeWFFblN1?=
 =?utf-8?B?MldYVEVvRUVnbng5NHdlcXBvUGNEQkdMK1kreUphdExtOWRxelVNWEkvOHAy?=
 =?utf-8?B?S2RtNWczbkQzdEE0T0VhcGp3YjlDRy9WTDVWODhlWnNzWW10aTlpVUV4NjAy?=
 =?utf-8?B?djllMWp3ckh1RXQwL2NXdG45amZ1RTl0VExOSzhKZDRFWFhCdUJUMzhmRGEw?=
 =?utf-8?B?Tkl3cUhvUTFnc1JxcGV6Z2xKT243NXJvdGdhR3NxWWN6T2pKTzFDM1kxVHkv?=
 =?utf-8?Q?xuzqNLBTmrD6tCCZXt1shBvdV?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebecb26-4b8e-47c9-3e63-08db60ebc4e3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 08:56:34.3700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4M4i581puYj5rqR8FeokBzPOqaJcjAZIuySG8B8DD6qlb1Cs9unZiyzFaJNp7nP2M5gFeZGezzmf6GjPRIuww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7147
X-Proofpoint-ORIG-GUID: aZbUJyPQGxHy5kc4U_vTQuaXUjBdYkUJ
X-Proofpoint-GUID: aZbUJyPQGxHy5kc4U_vTQuaXUjBdYkUJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_06,2023-05-29_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
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


On 30/05/23 1:26 pm, Markus Armbruster wrote:
> Het Gala <het.gala@nutanix.com> writes:
>
>> On 30/05/23 12:28 pm, Markus Armbruster wrote:
>>> Het Gala<het.gala@nutanix.com>  writes:
>>>
>>>> On 25/05/23 11:04 pm, Markus Armbruster wrote:
> [...]
>
>>>>> Aside: a more powerful type system would let us extend SocketAddress
>>>>> with additional variants instead of wrapping it in a union.
>>>> Markus, what do you mean by additional variants here in context of socket? Can you give a small example.
>>> As is, we have a nest of two unions:
>>>
>>> * The outer union has branches @socket, @exec, @rdma.
>>>
>>> * Branch @socket is the inner union, it has branches @inet, @unix, ...
>>>
>>> A more powerful type system would let us extend SocketAddress instead,
>>> so MigrateAddress has everything SocketAddress has, plus additional
>>> branches @exec, @rdma.  Naturally, the type of the discriminator also
>>> needs to be extended, so that it has everything SocketAddress's
>>> discriminator type has, plus additional members @exec, @rdma.
>> Okay, so you mean something like :
>>
>> +# Since 8.1
>> +##
>> +{ 'union': 'MigrateAddress',
>> +  'base': { 'transport' : 'MigrateTransport'},
>> +  'discriminator': 'transport',
>> +  'data': {
>> +    'inet': 'InetSocketAddress',
>> +    'unix': 'UnixSocketAddress',
>> +    'vsock': 'VsockSocketAddress',
>> +    'fd': 'str',
>> +    'exec': 'MigrateExecCommand',
>> +    'rdma': 'InetSocketAddress' } }
>>
>> Even I agree that directly leveraging this is the best option, but then wouldn't it introduce redundancy ? we would not be able to leverage socket union right in that case or am I missing something.
> Yes, there's redundancy, due to QAPI's insufficient expressive power.
>
> Is the cleaner external interface worth the (internal) redundancy, and
> possibly coding complications that go with it?

Honestly, I would like to have it this way, where the user is aware of 
all the transport mechanisms available. But I guess for external 
interface problem statement, the migration code flow has similar path 
for SocketAddress and non-socketAddress (exec and rdma). So even if on 
the QAPI side we express explicitly all the transport mechanisms, while 
implementing it we either would need to brinf them under a single 
umbrella. For now, I would keep the implementation as it is (union 
inside a union) but would want to have a more powerful and better 
appraoch out there if possible.

I would like to have Migration maintainers - Juan, Peter Xu and others 
to comment on what approach from the above two is a better one.

Regards,
Het Gala

