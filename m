Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C018387AD
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 07:48:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSAaE-0002N1-GE; Tue, 23 Jan 2024 01:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rSAaA-0002Mn-5g
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 01:48:26 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rSAa7-0001PJ-5x
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 01:48:25 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40N3ghjY020453; Mon, 22 Jan 2024 22:48:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=mZLJp7rxtmuv
 1hkWsTtIbVbBlxljzQDZ5OorRoxXs3g=; b=T/jjgE30Dxy/MbH7ZpjNJDvavhIN
 riyrbHrZpZzdcdn9hykUDPlU17PUmqn/SNCSfOcq7EZGDUs2B24a0y10jJfcI5w7
 7+mwKQdgldBAQiAdGW5y+WdjiAVgvmWtlX9yrD3U+L6GuD83OdhIRFi5UZuUpwx0
 15KdceaUj5DahzWfTRmoJfpfPZ6zqZmCs3g5kn+mY0Pj7nq/kAZWL3kC5jLWnpl+
 u4Kww3dppVCMna5MNmo1eZX+aH46eewOdCVTn9bwGMw2xohJaVnKSd9KK5bFgJmn
 VOcO8KCicOFP2pBeE0y8Nl7H9DKooqfNQQq3JmboFhzk+aAWU/bYele5QQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3vre4hmrmx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 22:48:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEkoNUas/jMhf72Xuisxf+kzT//p7z/Wlqh/1CSb79zU3vus1nfaREML7epQwS0OjBFqQYUzAgZVYPhPNggIzeQxWU5hXixIt+bxHQKnFdESPNP4B7Gq4CyTRVqzraqtbbulzoqdCaRYD94WXBetHaTWy8X+tPrDFHNY9t/s9kkPtLdxcfAi3e6Skhr7Qc1x+z5ToHlMo90Kgxx2tCTutVqKB5WuYFdqnHthIZZJ9PAXdVqbb7yioSo3YECxx+23ODomKiD6q/FYyI1CRoCUwCC0GBpQBbF5hzmhTRHlNBgICmn5kdB+sqI2QoSowwyyK5I++C5V8Ric3/0ITSSnPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZLJp7rxtmuv1hkWsTtIbVbBlxljzQDZ5OorRoxXs3g=;
 b=N2LkPsSZ49ps/x9cyeCQhgmudi7gm3JiYigEpTsfCprzFVB+WuRqh0HVCuRgfQROVWdTok3GIrI8HTR26lNKF1Ytlkt61W3WzAjJWNH3zseKsS4eAvsatUXiGzRHAn70wCdmvTL5/2Uy3sEH+0NuB4igwUMm550bDwWE45nZDZzpMryOYdQfLbBn4LOtgRHVxjYN3Ul5HExCtMfib/Ctw75YcKiQOO6wF7Nxw/2EJ8Y5ZU7BRblaCd5XuLPE8xumOd3HfqVku6wgaQnC7IGJphBQ+aRSkTOG0cRKqHNLgdAVn+eX969BW9q52iV+VsmQ2ByDjoRHxD9eiPLHpF/8Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZLJp7rxtmuv1hkWsTtIbVbBlxljzQDZ5OorRoxXs3g=;
 b=hHbE0ETKNQniNEUWm7ynrNH9Pc+NkV78t0pzIHof1AOl486OqxbgGotG5VDSS8Ge/UZAWrzOeNZOiyO51cnwPLO6VeBbnt8BqEJboaZNWZA0lbF6WINfhyVZsATcPsZS1KP2po7v+g3HW/1dVArUBOUPv1AvItwc/DPYmZ30cvrCCzvvJ1InvjoLUnnAVS1RYwnBZU3J3wyoDI9eCOu8xf0ckw3qUW4OVkgNvlBgpRMU1Vbxi84oNPMvJh2xWLO2F1D3eIenCfW90eRdelloryzu2wR9N0DZFeV0qgvh4WtPqLGRqoOHAfcyp9x7zzKaoOTI+tdtAreEBDZB2dNutA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by IA0PR02MB9170.namprd02.prod.outlook.com (2603:10b6:208:43c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 06:48:17 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5%2]) with mapi id 15.20.7202.034; Tue, 23 Jan 2024
 06:48:17 +0000
Content-Type: multipart/alternative;
 boundary="------------2VKsTmn2TUzPFxfqQnCzQnic"
Message-ID: <e841e0a6-6b8d-49f5-b2b2-40afa1550bae@nutanix.com>
Date: Tue, 23 Jan 2024 12:17:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Make 'uri' optional for migrate QAPI
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, farosas@suse.de, armbru@redhat.com
References: <20240123064219.40514-1-het.gala@nutanix.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <20240123064219.40514-1-het.gala@nutanix.com>
X-ClientProxiedBy: MA0PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::17) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|IA0PR02MB9170:EE_
X-MS-Office365-Filtering-Correlation-Id: e43df3bc-8c4a-44db-eca3-08dc1bdf47d4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X9SRlB95K2+CSpcqnWb1qIxnt0nwdMxtX3P6uBuvk1FYnoRr6HSMoHA5Govxo3LGf7KDocLpMcyv7AJfLz9JZMNi4Exy6s6m3YEN551SBFdUI2TmsS1347iZ+yJY66kNhUF1cCbfp0JFped9ZQOqp3D22VHP7WPRYcT3V+F5HM/8g5HJ5ArsutVFl01yyqair46vuoZZIutjr2wAgne0UmOxHGGqCpUMn71UETZePjb7M70e2aHkqBs3q2PjlKgKqTkx4GO8VqOyKZoCQCNnhI2VEbldLfKz/0PoNCRDj8OUGsYZYm0u9lWxUOEkqInVDXWV6AWjSoFQgNufupP5sa6m66qu+UvJOdkVe4KNkBieQ8WkYR0qY1KM3WspbLUmRB6hjCpxIW/g/9oUJ0nMnojoWzVvFf7iNc8dJb8w4ZR79XrKH9fqlqJ1Sz5xXp2mJdCgI8SSp0f+Taki1opc1OGHOWQ/j8V2Gt2YU7ISSg5bmGbt9URM5Hf42dcuHt+8FqpkpYaxbXQToX1HDebpDOFiyF8jVMd4kzWZsC30MHQjbpyP9yBl+hHXBj41KqQIg1NXD6CyyBZlZQKb4lnALwLl0glFsgxSDS623FSas7R5lRWMZM/6cRnlFmbhmF6a9CDbLLFtnHU6iFfxoTceYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(376002)(396003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(8936002)(2906002)(8676002)(4326008)(66946007)(5660300002)(66476007)(6486002)(31696002)(966005)(86362001)(66556008)(316002)(44832011)(36756003)(6512007)(478600001)(38100700002)(6916009)(166002)(53546011)(33964004)(6506007)(6666004)(2616005)(83380400001)(41300700001)(31686004)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzF0NzMwRUV4enhaS0NSbGt3VXRxQnFCSithSU8zc0tYTkJnd1ZKc2lpYWh3?=
 =?utf-8?B?dDIrMU85Ymh6YTNwaHNuRW56cHppNStZMU5ZVVYzUWlVWmlWUDN1eWNaM29z?=
 =?utf-8?B?TGZ1WWhSQitLaEdCSFdhcHFsU2xqNFVmZXhlR3J0aGVUV0gyWkNmSEhyYkdp?=
 =?utf-8?B?eDU5ajNvazhMd1BTOU5MT0hFUXhiUEpGZGdSaENZaDlKZGl5bTRHWkZHMlJ4?=
 =?utf-8?B?ZSt0UzBRN09hcFRnQTNIQkk1ZXM1bTlHandYLzlJMmZOQWJQQ0RnQjR0c0dH?=
 =?utf-8?B?N2pPNUV3dFdiTG55RzdWOVlhOTNTSFc3QUp4ZURsYVRLTUNJSEhXcUQvcEJn?=
 =?utf-8?B?OEs4Y05uSnBWZVBuSkRybDJ1Tk8xaGJkN0RKbGR6VWNyRGF0OWVSMmU3bnMr?=
 =?utf-8?B?TGZhVjJOYkZjaUJuTmVhd0RjQUhUemNUZGdRbWJXNlZzeUVJZVhIRkxQR0xE?=
 =?utf-8?B?VWlZRGk0d3VyajRqMUV0Tm15Uml1MGdiaXJuTW1EZjJhRmxaNlQ2WnZuZE5P?=
 =?utf-8?B?ZmNRbjd5UVpERmx0TmNqNU53bTFTTmpudUVkcWlHQVcrR2JQNUlUUjJXWDFy?=
 =?utf-8?B?WUlVS0Vram5PQ2N0ZEJ4Z2J4Mm52aytoNmpmUlUzM01kYktsZUZsVCtiSUQy?=
 =?utf-8?B?T0NkeTdLMmJZUldzZXdqVGFNeW1ySHBzcmZrL0FsVXorV3RTQk9WUGFGd043?=
 =?utf-8?B?QmNKUVlFMCs4RjAxeGJ5RmRCSHhVN2pNaEZCOWU4MzBoODQvWFZoL0duTUF3?=
 =?utf-8?B?b3J4WUl0QnVmT1ZxN2VQNTUxWDc3Q1BXVnZaRytmdXFaaE9Lazk3UklWRnFz?=
 =?utf-8?B?NGpaZEZxb0hFdTRxVUZUR21UUjVuVkMyd0V3RTF6cWVVcWM0dXdGYS9lODhj?=
 =?utf-8?B?SS9CV0FGMWxqZ1A2eGZtN0dQNEVQVEcrdHVxaGI0K1ZmSnBvMVRPUEZNRE9Y?=
 =?utf-8?B?UjU3eWVCRTY5QzluQTJuZU00ZlFRYWZkeEFTYXpUWFduUkYxUmJRZTFQR2Vp?=
 =?utf-8?B?NGJLN29OR3lZbFJCWVpNeTNQTHlkbFZDNG5DeUlGV3pYVjVkRTYzMUNMeFVM?=
 =?utf-8?B?WkdIcWRzTkVkdUREUzd2bW1qSk1jbFFtUHpCQUJvTUxFVk5vcUNEZVk5QVZ1?=
 =?utf-8?B?RnpPVVdWNXpaU1ZTemIzbWVSZDJVbHFMcVFlelpCRG9IOFVpZGppMDdmMUlq?=
 =?utf-8?B?QlkxNTZyd0FqVDAvTTY1bUhnRFBIRFZoZ1ZyV1ZyWTJZRW1HQlljZitEaGhq?=
 =?utf-8?B?TFkxZ1NGaVJnazNHTkdlNnRDMThqOUtlalJmbHR0TGFEK0xvQ0JLU3M0M09W?=
 =?utf-8?B?QTZ0d2t5UnVXU1piVVJZU3NEY25Rc3Y1WVBFM2h0dFVEM0xud0Nub3UzcXhu?=
 =?utf-8?B?cTRHaG5iZjY5RHNPaDVBVVg1QUJUNHlwTEI5MHh5Vzhya1p2dHVVTENXZmFp?=
 =?utf-8?B?d1dFa0ZmSmlHc2VvUVlFNUlmcjlEWmlqdHltNHhsZzBpdnUzQkFiS3BWUk55?=
 =?utf-8?B?MFJRc0dHWERsU29yVkdTRzh1aUNjSUw5WlFicC9zTm1ESjdtdmtOWTJkemJu?=
 =?utf-8?B?M1JKOFVGZkV4S2VaWWRoSE9LY2VScUVDSGJIOGxZOElYTlFLUVVxN0xKMzl5?=
 =?utf-8?B?ZE5Rd1k5SHFPYnIvY1MrTGFhQ3EyTmIwTC9WUldWQmtxMFczMHNUMjZjblkx?=
 =?utf-8?B?UG03WFVkdnFLaUxHY0dhOHM3N3dReGx4TzhSc2oxVmNxbWlVd1JuRDNGKzYr?=
 =?utf-8?B?UWRWZ1IxRnZzZzJJVnJ5SzRMQi9hQXVxWk9XQVVTZkt6RkR5M05YSUtGN0tJ?=
 =?utf-8?B?WVNMNDY5U0JEbzdUNkt1a1ZlNUJyU1A2Qy8ySGQ4WlJRQ2RQRys2MkhjcFg0?=
 =?utf-8?B?R3l0MGpNczFZUXhUK3dQQ0JDSHJqUFhPcUdROGR0R2thVUREdlhtbzc3QzZl?=
 =?utf-8?B?ZTUwelNpSGFYbXJGK2hHVFI0amdHWmNNdTd5ZUU0c2QySWgrNHhsRTlOTkRX?=
 =?utf-8?B?cjBGZUFtenhVRWJzZ09UTk1wZUFEQWpTa2pVQUZUUzZESEoxUERUZ2Z3WGVM?=
 =?utf-8?B?cmRkbzRTZnB2VXZpanUvdDYxNWtqRnp3bzlIVUJoL2hSNkdzWFlXeTcxc29m?=
 =?utf-8?Q?lXeN1c0AyxExYuBoKoRHB6Fsn?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43df3bc-8c4a-44db-eca3-08dc1bdf47d4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 06:48:17.7561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FATWx1IMvqsKnwbfzn/YB5onY5XKOy/JQHbnR7GeRiTYMGOml7XbDWwYlc05gZ3aApqFw5ruPsA22r+sCs5eiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9170
X-Proofpoint-GUID: VTYgvX0YgK2ZpdOPfbiIhXVLtBu40dca
X-Proofpoint-ORIG-GUID: VTYgvX0YgK2ZpdOPfbiIhXVLtBu40dca
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_02,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--------------2VKsTmn2TUzPFxfqQnCzQnic
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 23/01/24 12:12 pm, Het Gala wrote:
> 'uri' argument should be optional, as 'uri' and 'channels'
> arguments are mutally exclusive in nature.

Also verified by running the qemu CI/CD pipeline. ref: 
https://gitlab.com/galahet/Qemu/-/pipelines/1147048455

> Fixes: 074dbce5fcce (migration: New migrate and
> migrate-incoming argument 'channels')
> Signed-off-by: Het Gala<het.gala@nutanix.com>
> ---
>   qapi/migration.json | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index eb2f883513..197d3faa43 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1757,7 +1757,7 @@
>   #
>   ##
>   { 'command': 'migrate',
> -  'data': {'uri': 'str',
> +  'data': {'*uri': 'str',
>              '*channels': [ 'MigrationChannel' ],
>              '*blk': { 'type': 'bool', 'features': [ 'deprecated' ] },
>              '*inc': { 'type': 'bool', 'features': [ 'deprecated' ] },

Regards,

Het Gala

--------------2VKsTmn2TUzPFxfqQnCzQnic
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 23/01/24 12:12 pm, Het Gala wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240123064219.40514-1-het.gala@nutanix.com">
      <pre class="moz-quote-pre" wrap="">'uri' argument should be optional, as 'uri' and 'channels'
arguments are mutally exclusive in nature.</pre>
    </blockquote>
    <pre><span style="white-space: pre-wrap">Also verified by running the qemu CI/CD pipeline. ref: <a class="moz-txt-link-freetext" href="https://gitlab.com/galahet/Qemu/-/pipelines/1147048455">https://gitlab.com/galahet/Qemu/-/pipelines/1147048455</a>
</span></pre>
    <blockquote type="cite" cite="mid:20240123064219.40514-1-het.gala@nutanix.com">
      <pre class="moz-quote-pre" wrap="">
Fixes: 074dbce5fcce (migration: New migrate and
migrate-incoming argument 'channels')
Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
---
 qapi/migration.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index eb2f883513..197d3faa43 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1757,7 +1757,7 @@
 #
 ##
 { 'command': 'migrate',
-  'data': {'uri': 'str',
+  'data': {'*uri': 'str',
            '*channels': [ 'MigrationChannel' ],
            '*blk': { 'type': 'bool', 'features': [ 'deprecated' ] },
            '*inc': { 'type': 'bool', 'features': [ 'deprecated' ] },
</pre>
    </blockquote>
    <pre>Regards,</pre>
    <pre>Het Gala</pre>
  </body>
</html>

--------------2VKsTmn2TUzPFxfqQnCzQnic--

