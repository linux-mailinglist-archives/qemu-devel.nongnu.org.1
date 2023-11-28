Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 980BB7FB984
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 12:36:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7wOD-0005vw-Ks; Tue, 28 Nov 2023 06:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1r7wO5-0005sk-F9
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 06:36:22 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1r7wNr-00081M-US
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 06:36:19 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3AS5tN6e006432; Tue, 28 Nov 2023 03:36:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=tfiY4gvYi6dpOcLA6EpNp6V2MOBI32+ah1gHLvPKp
 NI=; b=M0bDJUayhw3B+7gsZfqGCZce2hWLb0+PR77H7A2E5xcVwzzXW/zc7A4v3
 tJiRmHQzwLSQW4WMJ/lTeiVdDkwxFHbc50T1F5uEm+jPE4sXfj8Hv/1Y3oxOtM6b
 WJOB3qUznJqaOEgI9OpOyChGPW9HWzAB4zCLkq031dhQgZK5ykmx5We8Mek8tDyq
 OdVT0/6HiHJEF1i893dGiQg+cgEDjuOifgbMbIwoRmj0x6Cw1qVu8sJTrg06Wr2n
 1TuvNHb9FDR0GGrrmikqJfLyztPUE4DzrfQf5Gwp9x3K4Sa532Z/jgzW+azBlrw0
 8XhwC124c2xftipgo10/YCtU7AMKQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3ukgvhvxyb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Nov 2023 03:36:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K09z2/LeX3/2mluGiax453tNKBnejEiN9YdIqf29Mzk/F3ixQYBoCqMwiV3HoYQMQRWc59gYC8YJHyOrfOzb07NFg5fzDPndUb65ePtFPAn6SUixbtyiRnjxLcbrLprcNCz/6BWEb8BgVv9KAB31HI4unYJfE4+JAdTHdI1H4l0yXqQiziZsiQjtMLE+QiOqUDcxPP4NPL0kHPWYbau+Uf5tXE/1cPFfDUK970fxHxh/zo4PQd5pw0kxds2okSqbxIuvwSXuz6qe2/qfd61Ft3bdo8d8VdMrfBwLuZVNCG75M6mWfwbZcKqJjZilJhMNcEFdAc62vgG8L64JWzrieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfiY4gvYi6dpOcLA6EpNp6V2MOBI32+ah1gHLvPKpNI=;
 b=G3cRImjNxX1Agf0pjctugvcWrliJvOtXIphtI0GoJO0sF/Gk4y8ZBhu1ttpdSxAeEAG/xNqlmcwTRvaO10M33kf5lQXeVdTpAAiSvzR8j58izltZOJZS3BGcpVrPTpH3vkhL2/D1EvY9gwTsLOV9hzYYN43R1eDu6sOwqmKU5E0tdgFhlcNp0jWUmqe6IbSTgCzTdBkKGI/Qx9Lak67MVESDfDBWzREY+8kzHYqZrEzrU65Pb2Z8A9N3SSzGYZ2EVHuE1Xj/0MBwe/SajOr2sMyeoTXPZUh7gaIkJbtYIvOmh6E+7xfYBYGa5bsmSwJk7+huXELWHOxGQurRam9bcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfiY4gvYi6dpOcLA6EpNp6V2MOBI32+ah1gHLvPKpNI=;
 b=OlYh7FHecDjTYzOzMYwZM25OO087ZjW5McrxAlLdnXnoibnZJjzC88U5jw/YzaLWZY02ax+IlQBGn9d04tIVLivEuPVsjwV497oVVEZf/4UHbR3TQJH77HrxP62yLAnw4jJQrw3cPHbCwSGySL/BlvQxsoHkAeIFVGBHdpsrhfNcHoL839394DfTjs8ytbs7A6nxXCJ3Ls23C5mJN9gRrVKxu9r0UxxXxbgUci3qBRZWpA+JAsDmy6uAiGgZiyNBGQ+yxzKfIT6uMWkYjmBsGeTqk4cNd86YMf7pg3sttYaezrwTc6GlguUZPpN/H3vvcqqHuYIBu49CMFe7OHplfg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CO1PR02MB8441.namprd02.prod.outlook.com (2603:10b6:303:154::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Tue, 28 Nov
 2023 11:36:01 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5%2]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 11:36:01 +0000
Message-ID: <7d7c582a-50fa-4f66-a4c1-0753f69fc7d8@nutanix.com>
Date: Tue, 28 Nov 2023 17:05:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 'channel' and 'addr' in qmp_migrate() are not auto-freed.
 migrate_uri_parse() allocates memory which is returned to 'channel',
 which is
 leaked because there is no code for freeing 'channel' or 'addr'. So, free
 addr and channel to avoid memory leak. 'addr' does shallow copying of
 channel->addr, hence free 'channel' itself and deep free contents of 'addr'
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 berrange@redhat.com, peter.maydell@linaro.org, farosas@suse.de
References: <20231128062520.36456-1-het.gala@nutanix.com>
 <87a5qy4aag.fsf@pond.sub.org>
 <db753099-b8a4-4057-9459-5174ff81ddee@nutanix.com>
 <875y1m19ls.fsf@pond.sub.org>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <875y1m19ls.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0170.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::20) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CO1PR02MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ffd5602-565a-4aa1-ef9d-08dbf00632a3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AkFcEI+FmkSCUVNPPYZGmGP8nP90RuEhWGbn4o8CZwPRE1XFBjkEcR4VwqI6Z6t/GA1bG3BlrBzrbOqxzYT1SNtfxAaKkVrgExsOoTRmgMyD+HuetIQ29g3ECT7V5SyaL6fKzKQ/+IJ5fRiv4J1geIlLtsI2sRPGAJkujd9gnLpJXEwFOIGk9zKhakFi6FfXmrsuaXuJD2sVG4XlBWDEeoX2XsVlfj0Q8mVPzdfY9DjgOt0nOrTnvZP3UAkIHl4A2Jcjqo8eSoQB9YfTbZenOJKL6pdx/bhA4PTuJXT9VRiCZFNuLPRvyGdTOB1ftLJmPNemFZ9OnaUf0DasxDl+ufhaZKdxEVtoFyrpktF5iRPYYbrcn3CfwZyKKQ18577jJPZNJ9cNSe5R13H6vG+xwcbT55XIEq7Mw+KJKo0ifX1GFRBgKKNoDNazAPJ3xx1jc/GV1UTiDsftQzOYEzvbJvaCZnvYIuTbuFRsov+3L7JObFEiTKSMeAc+5HKjcFEj4XCJIGF6tJ8syjvG8Wyw1sqKqNZH8PB3h7EJvuuPvkrBHhlNMf9GqTY5EjTzTx1/QSatynzOjWFI8GYHIkZrqym+I0+gJe+lKG+LKuXGplQxHBQVx9qqfP+v4QP9Ng1a4f+joPh9kiXaeEb+v+Ejt8/od75gZga3fm7ORwf2enme97GatykWqZqnUasfF7Zo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(36756003)(41300700001)(31686004)(2906002)(26005)(83380400001)(5660300002)(86362001)(2616005)(6506007)(44832011)(53546011)(8936002)(4326008)(6666004)(31696002)(8676002)(6512007)(6486002)(478600001)(66946007)(66556008)(66476007)(6916009)(316002)(219693005)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDhqOCtYTlRORy9yaHh1bDVWK2VwWDNSRlZMTk5mUitDZVozVHl1NzhYNkkr?=
 =?utf-8?B?OEs4ZWlBR2F1VkxsZlpkaUdUYjRRSGFIa20rMkZ3cjgwNytESGwvc0ZLb3Fy?=
 =?utf-8?B?MGVRaWg3aFFZdEE5aldqQ1d6NVZzby9QRU1QdzI3R2hWdUZJN2J1b21Rd2Z5?=
 =?utf-8?B?NGRydi9ITUFQRW9mRmxHV3JGa2ZveDVBNU5LREphOWwyc29Bd1RnRmFieFNx?=
 =?utf-8?B?RXdJenMvY2Z4bkhqdnNvOVE4bE5ORzJRQWw2WGJ6Z0FTTlRKOVlSaWxlYW9v?=
 =?utf-8?B?ZEJueE5vQXNweW1XMGpZN0drWXZaWllETVBKTGtTZnZsS3IrTitVYnQ3NWFR?=
 =?utf-8?B?UTB6UElNZVA3M1R1RGpzK1dhb0dESFlJZjdGUjJWZ3diNForc25qWGdCcDhV?=
 =?utf-8?B?ZWcwRlRSZk9zb2R4enl1NkFpbWJmZTJTYlo4ckVpUHE4dlk3OEdlV3VIZmVn?=
 =?utf-8?B?QzQ0QXg1NzhHV1VYUVRXOGdyeTI0RzVKUlFlZkVTRUxBU052Y0hPL2ovTmtJ?=
 =?utf-8?B?WEVYUWtVOHRDZFdzOWtmdkl6SkI0aEE1WW1PZjNwN3ZIb1FTUTAyT1ZoRnlt?=
 =?utf-8?B?RWNjeUZnd2N4MmJHbVRmSFdsQ0ZmYzFmYmVFVTlyZG1ycFNiZ3VaaWlNNGFB?=
 =?utf-8?B?TlRyNU5ad1dVelpnTWg5TFZnaEV6WkxiY0pXRVNoZVZIaThtSjNOdU5OaTIy?=
 =?utf-8?B?MFVXUUtNWDBZcmFIYXRHUk9MUVJHYU5JV2lPWW4zazhTUHAwRHE4NUU5czZH?=
 =?utf-8?B?ZmRkdENmR2lkNEc2RXMzNlBhTm1lQ1MxVU1OOVZyU29QRVE2MFpIdDJwZ2pn?=
 =?utf-8?B?d1hMTm53SFRWTm41eWJhSFhTVGdyVEJLKytMcHRMdHptRk5HTzZ5TjNISCtK?=
 =?utf-8?B?SlNhMTRSempBeWJHK3lQMkdIZlI3SWc5anZoc1J3a1B4RkFRazQ1clNNZ1Fm?=
 =?utf-8?B?OXVObmk3OVFueEltY1dQNzZ1anBHZ0RwZjVVYjdXVithSHZiWGwxR2hBVWhY?=
 =?utf-8?B?ZXpZMFBMT1lITEcyYXV5WWVWNzRmdER6NGRBT1VpeG1lWjBHeVZkWkMvdUlW?=
 =?utf-8?B?bHpWbncvWmFCZ1lPd3dNazhDZlZJT09iVXgyQ1QxT0FTOHlYcnljRmJQTDVw?=
 =?utf-8?B?YjQ4MUgyZy9JQ3RFeklYTjQ0KzM3eWpwYnJaRTk0bTZpY2J5VlJvSFR1Yy9q?=
 =?utf-8?B?bHhTbS9ZQ201ZmcxQTg1OXhWdjFhMUN4M1c5ZUlNcnh0YjBEY2MvdVFUQ0Ja?=
 =?utf-8?B?MnFLbkp5aTVWa0UvL3NWWFJ3VmpseEtUYWM0UXU5YzRoSnZod1VEZXh4eDhC?=
 =?utf-8?B?LzhzUGdvTUJlb0ZYcVBwMkc2dVcveXFjelpIRWYwWGFWL2c3Njd2K2JSMHcv?=
 =?utf-8?B?S2tOV2tZL0NjUklDcUxWOVJUQUJvV3QzODR6TW9OcjV2cFBqdnZtR2VSMGc3?=
 =?utf-8?B?SmdXVkhCenV6RmFQdlRHYkcxeXgvUVRBYVozYU1mN3dseXFaKzVKc3NFUjVR?=
 =?utf-8?B?WDNCS3VUa0Q1VHMveUsxME5vUTl1QWFlaWgzdWozd0VFY2IyUVc0VjduSGRD?=
 =?utf-8?B?MlZJM0R0Si9aM0YrMTRzUEUyaU13b2hoSlZ1MzNER25Xa3lEVkJIN1NvT2xu?=
 =?utf-8?B?bllRR2xkR2p3c3B5cFFmQlE1bC9Xc2Y5WWU4SmZjaHl4VUVTNkVpSnY0V2tm?=
 =?utf-8?B?N1RqNlZTNVoxbndXbnNrV2hjS1BZaWErUWtTeUp0YW91Zmh1M1QxQVI5YS9L?=
 =?utf-8?B?dVRHV3ZwTHZmVDBzRUdtMXN0SituQnRsY1VaRS9qcmdGbnhVUmw2L3ptVWxN?=
 =?utf-8?B?dHVGTHdhNkEvYWpxUnd3Skc1Rk0rei9OL2pZUlRQS3ZwOUY4TUt4TS9NS2hO?=
 =?utf-8?B?K3l3ck5UUWtGdlNMN0ZiN2lIQy9Yd3NuRENSSE9SVjZPd3NvaUQ4aVdSNHRu?=
 =?utf-8?B?RFRoVFVSbHZCeTZzMU9ZbHd5YmxvKyt4ZFRrdnJZZHdmVFBKQkdPRDduNjA3?=
 =?utf-8?B?RnRkL0d4dmlOVTBXVGc3eVVFZVNpQVMwcTBGWXBlYklvMGdmVlNRanpxQ01p?=
 =?utf-8?B?c3diS1ZhSlUzTWhjT2EveXlyWHJyMjZYQ1RrM2h6djRSRlVKcDJuSnlVcU1U?=
 =?utf-8?Q?2fDbfUTAB+ZvN43ARXd282AXU?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffd5602-565a-4aa1-ef9d-08dbf00632a3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 11:36:01.6367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZcPNIuZES5giIXHzlDwtamg2DjmFv0FmA87Z4z2Fquz7D/LJXqiRBLtmOsbzP7I2nnM+/oINV7ZOmV3iIBag6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8441
X-Proofpoint-GUID: bS05J6_D-Vpj_PIsBppzElMVil5XUAkj
X-Proofpoint-ORIG-GUID: bS05J6_D-Vpj_PIsBppzElMVil5XUAkj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_11,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 28/11/23 3:29 pm, Markus Armbruster wrote:
> Het Gala <het.gala@nutanix.com> writes:
>
>> On 28/11/23 12:46 pm, Markus Armbruster wrote:
>>> Your commit message is all in one line.  You need to format it like
>>>
>>>        migration: Plug memory leak
>>>
>>>       'channel' and 'addr' in qmp_migrate() are not auto-freed.
>>>       migrate_uri_parse() allocates memory which is returned to 'channel',
>>>       which is leaked because there is no code for freeing 'channel' or
>>>       'addr'.  So, free addr and channel to avoid memory leak.  'addr'
>>>       does shallow copying of channel->addr, hence free 'channel' itself
>>>       and deep free contents of 'addr'.
>>>
>>> Het Gala<het.gala@nutanix.com>  writes:
>> Yeah, I made the changes in v2 patchset.
>>>> ---
>>>>    migration/migration.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index 28a34c9068..29efb51b62 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -2004,6 +2004,8 @@ void qmp_migrate(const char *uri, bool has_channels,
>>>>                              MIGRATION_STATUS_FAILED);
>>>>            block_cleanup_parameters();
>>>>        }
>>>> +    g_free(channel);
>>>> +    qapi_free_MigrationAddress(addr);
>>>>          if (local_err) {
>>>>            if (!resume_requested) {
>>> 2. hmp_migrate()
>>>
>>>      hmp_migrate() allocates @channel with migrate_uri_parse(), adds it to
>>>      list @caps, passes @caps to qmp_migrate(), then frees @caps with
>>>      qapi_free_MigrationChannelList().
>> Markus, sorry if I was not able to put point clearly, what I meant is that the local 'channel' variable used in qmp_migrate() i.e.
>>
>> 'MigrationChannel *channel = NULL', is defined in qmp_migrate() and if the user opts for 'uri' then '@channels' coming from hmp_migrate() will be NULL, and then migrate_uri_parse() will populate memory into 'channel', and that is not getting freed after it's use is over.
>>
>> I think, that is where memory leak might be happening ?
> Aha!
>
>      if (uri && has_channels) {
>          error_setg(errp, "'uri' and 'channels' arguments are mutually "
>                     "exclusive; exactly one of the two should be present in "
>                     "'migrate' qmp command ");
>          return;
>      } else if (channels) {
>          /* To verify that Migrate channel list has only item */
>          if (channels->next) {
>              error_setg(errp, "Channel list has more than one entries");
>              return;
>          }
>          channel = channels->value;
>      } else if (uri) {
>          /* caller uses the old URI syntax */
>          if (!migrate_uri_parse(uri, &channel, errp)) {
>              return;
>          }
>      } else {
>          error_setg(errp, "neither 'uri' or 'channels' argument are "
>                     "specified in 'migrate' qmp command ");
>          return;
>      }
>
> At this point, @channel is either channels->value, or from
> migrate_uri_parse().
>
> We must not free in the former case, we must free in the latter case,
>
> Before your patch, we don't free.  Memory leak in the latter case.
>
> Afterwards, we free.  Double-free in the former case.
>
> You could guard the free, like so:
>
>      if (uri) {
>          qapi_free_MigrationChannel(channel);
>      }

Yeah, you explained it right. The above solution seems fine to me.

I am just curious to ask this: can we use g_autoptr() for local vaiable 
'channel' and 'addr' ? As we are not passing these variables to the 
caller function, nor we are trying to transfer their ownership to 
another variable, so use of g_steal_pointer() also might not be required ?

>
> By the way, I the conditional shown above is harder to understand than
> necessary.  I like to get the errors out of the way at the beginning,
> like this:
>
>      if (uri && has_channels) {
>          error_setg(errp, "'uri' and 'channels' arguments are mutually "
>                     "exclusive; exactly one of the two should be present in "
>                     "'migrate' qmp command ");
>          return;
>      }
>      if (!uri && !has_channels) {
>          error_setg(errp, "neither 'uri' or 'channels' argument are "
>                     "specified in 'migrate' qmp command ");
>          return;
>      }
>
>      if (channels) {
>          /* To verify that Migrate channel list has only item */
>
> Or even
>
>      if (!uri == !has_channels) {
>          error_setg(errp, "need either 'uri' or 'channels' argument")
>          return;
>      }
>
> Suggestion, not demand.  If you do it, separate patch.
>
Yeah, I probably opted for 'if, else if' block because I found it easy 
to have all 4 options in that manner.

'!uri == !has_channels' is same as '!uri && !has_channels' right ?

Now looking at the Qemu code, it is better to have conditional 
statements the way you mentioned. Will do it in a separate patch.


Regards,

Het Gala


