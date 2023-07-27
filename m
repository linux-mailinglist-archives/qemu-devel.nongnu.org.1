Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 165237652A2
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 13:39:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOzCB-0000Ff-7h; Thu, 27 Jul 2023 07:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOzC8-0000FW-G8
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 07:30:13 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOzC5-00089V-5C
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 07:30:11 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36QNdA5L031048; Thu, 27 Jul 2023 04:30:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=WH07v2KG0zeOytAwtlAiCW1lQ/aqDnrkP1fuvrMwz
 h4=; b=ojBf6+51Ywhc3RSsI9XSpQEEVWJOA9MvHwy92Tt+gn/Bb40mDbZKAcOJl
 6+t7RAEjNKVpb29a2Dgp0iJOU3IwzHa1Yy2VeMqgQ7Hs40hamnQ0fhUZT45FcYGF
 hRPrxLI9FJlN6BPIls3dhfQuuU7OfDw2x+YGTxjuM2hcQhevlCig71bTcb9hAO/1
 rSAntUNKSg+VN+0EoEvG0fwnrI+/ejh4yyn1f1WAir4d8w4WUjDn9AJS1YY1d0gh
 0hZYIM9Hz61gROqp1b6awJEP68u7XiUI+yxM+kgQPVUbXfn15Z6oU1LLrOJWYEsj
 GxSWVI3WJeon42DledB4lfHo+OrNQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3s0ber2bc4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jul 2023 04:30:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuE4VZLWQxe1VrM4V3dZGr/EOQO98FxWP5HQ0W5LcxGm748JV5my7c+sY0NhtouUTmE37aiWtw/AKwgj5PZGm0hNdM+tXbK3CN+uXmdH1QGJcqIsEGDRpyo6+IAzuuTavo2f7eSn2+856Cnm1JtwoY758mHfLVE8aOAhGbO0qb4qmaIi1KCsaRwRhueTXvEQw1drL4BqqHBIWFbrr7FEymOjsC7rniLZSeylju99h9itCa80VVqgDM+4JkyRqSMklI3eOiaEKy5w1aev7Dlcn8vj4L9x744MxtFIjSxaPQQTSy/xjqYxiu4XEZZb+BgjWzE9DRkHEtRRIfVY6oD7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WH07v2KG0zeOytAwtlAiCW1lQ/aqDnrkP1fuvrMwzh4=;
 b=nLNddudjrTKYweXGzcdoMbOoTFhYIYjNjwt2+F0IBwO5eDYVo6uejL66VkN3+Uw0K4r4U4Q3t8fHW4eUrj55o4Df+f+2wallPEB8U5ZwvFHm/qQMAvBrwP9UFrC1OMbfaXcKN95Ms/7cCYYui3/gMAkmLEgM4sNFfMGpYbT+IP0B6QzpHnkP0aOf5M8Y47NAnJ4VyJsyOc5yCRfCAs24qcsNuh/gyQAwXtTNMuVZ/IFdP2aqIE2JpXdF4c+f/DXB7fMVoyDelpHXcPZoSQ+PDzZvhUzBTxYinLayZRVvfj7/BsEEASX/h1ymjPeBzhMN93jteGpJ+PfZa6ZQed/nxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WH07v2KG0zeOytAwtlAiCW1lQ/aqDnrkP1fuvrMwzh4=;
 b=oFw/9iozLF2GcLoi5DDeLAQ5PAjzi3yHik29Ilv4Mkpw4ZKJ0b9hQhZzbR8giQIV6xs0i34uvJR84Z9yJCxM9/1roU7mF1+Ligc14Tqpu1oOt11CpB3en6ZvnbvrjF9+mSyirT/mrL73chRQ46OoRyCn5GLExpsNYxW7+chUA7toHJy77Ng2JuYijb7yU4/xWtnyxqmWL2+q/VbLdaMD0GakovK9+7NuHqoIiZERGXoV1Cb7sqJ86lPhQgYJQahDuMRrXpiInRGbA5Qhjt+Y+BAiTmRrbZOvT2fal5AH4azDmz4Ei60Hws80aUbKnJIRs6D5aHboulYrkBMucGa78A==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by CY5PR02MB8990.namprd02.prod.outlook.com (2603:10b6:930:39::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.12; Thu, 27 Jul
 2023 11:30:00 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 11:30:00 +0000
Message-ID: <30cffa41-3e39-205f-5119-d84d6303f58c@nutanix.com>
Date: Thu, 27 Jul 2023 16:59:48 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v10 00/10] migration: Modify 'migrate' and
 'migrate-incoming' QAPI commands for migration
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230726141833.50252-1-het.gala@nutanix.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <20230726141833.50252-1-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::6) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|CY5PR02MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 01eda9fa-1b01-4296-4361-08db8e94cfa1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I9pALAbvkH6FZ6KqcGvxrXstSv6qUO+SKMYWltAugRmWBVBUAoqElNwuSHmV8BJH7MFCUdtqQG9Vf4JwApVyzw7194AjZp7CtJGAGglRACbRTaWj7PYMUG8EsR3qq+qMLEC9lctqC96m6IcIbquz9KugmJTN12q/I5K0CXMiqyU6Fjlx8Y9dijkSuCf9A3GwIWnEpBTXeonT4vRQhOhGj+4hiMqKPV0oCjK7MiuyfVa23KUhyQogOUvLL9Lhev4XXzO2D6t17S/U4oPB8Xvnw7VHtd/NyNTc3p6bC4W7kOrz0ImzV6axLQC8nEsujpcti9lGr72AHXFs/AHIYBkwesLd5DzpTrwDve8BvThk2N+nqVJKFEpBNweJdczfpyHLt8iSwI+frmBAmIZjKRsab+gHSMQmFQXU2FPZjhGEdAFFLIqQp1yZyrU+oiYn1QI48dcwotl+VZ1bMNwUr8PUaVVyhO2Pak40Gux3haI6Sg/twHdYCqPx7yzHE1Aluwg0yTOrHqy9vmFy4j3BzZ1/vL2WIgBklOGpEW0peYqznBaBQV/UHN+tkx21OnIjWRmL3BB4cHohmPFieKgR6+YkoLLPXP74ZSs86sQGDTZoUCfNskHezv0Sl14F3IQo1tLFaZcO3Qqj5LenRyUOR6IAU/z9Yljtml2/z7OlUt+5fAQGQcQWfDqXjhRbq4HsuRbU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(44832011)(5660300002)(8936002)(8676002)(41300700001)(83380400001)(316002)(31686004)(2616005)(6486002)(6512007)(66476007)(31696002)(2906002)(66556008)(26005)(66946007)(38100700002)(966005)(86362001)(4326008)(6666004)(107886003)(36756003)(6916009)(478600001)(6506007)(53546011)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ait5VWgwRG5QV2E1RjNmU0dtWVk5b0cxbnNGb2lnc1RiSDAxb1hzY0Q1ZmZo?=
 =?utf-8?B?bFcva3pYSXNGR2R3elhEUWNJM1VXSk0zbW9YZlI3NEE0clZablpLZTErZ0dC?=
 =?utf-8?B?THFsVktNNC93dWJ3YkdKcUIrZmI5WmxGclhocWpTNkFLWkFXVk9jSFgxdjMr?=
 =?utf-8?B?eVU4L3FOODUwYVpYd2RRZ2hDMVFHL1lJc0wxbTNTSTd4bnR3aTFjZCtacUUw?=
 =?utf-8?B?aDhybnRpT3VzTUd5T1hwNjVna1lORzcxMjNDMEJRVEtrMWhqS29rN2RVVUFt?=
 =?utf-8?B?THc4VituYlBORzAyOThRUWt0TnlDYmxlM0FDM0JxbjFwM3F0TWhldWI1YnBp?=
 =?utf-8?B?dU1ua0h5bFo5eDRmSnJZODhyVS8wWGI1cDFiaUI4bU9kU0Z0bjYzV29Xak1U?=
 =?utf-8?B?K2U2U3BPb0RtN2tSVUZ6OFBTeXJIVlpDclRNWVhBdSsrSzRRZ0htMGZWbDly?=
 =?utf-8?B?Znk5aUlBTHVqOTNSZHYxL0FNQ3NhQUlkV005dzhhdG5iYlVtbUZBekt4UkZW?=
 =?utf-8?B?MVBYQThsK3ZCSzRHMUhRd2lQNVFocjFGeHV5UGpOVm5Hb2ZBbVgreUo1L0xl?=
 =?utf-8?B?VUNZaStyd0RLTWpoUkN3VnJPQ05KS1Vlb0wrci9JbDJWMnR5SWxTcUNuR1Js?=
 =?utf-8?B?emM4b2pQZHkzZVdoYytDZGZmSnRZcVNESnZNemVZcGcvQUY4bFBrS0ZjWlY3?=
 =?utf-8?B?V3lsN0dQeVFla2kveGwrK0NyMTgwM2luQ21mR0k0U3hTR3k4bUhLL3JZNFJz?=
 =?utf-8?B?SitwR3llK2N6ODM0UmlVdTVrZmZLOUR1WUtqWWRvSUZlL2dXbEdkMXpTT3pz?=
 =?utf-8?B?ZGFVMzZLNFN0ZGdRdUVocUxHWlQyV2puZk1BeHk0YU1qVmdKdFhQK01ETEpT?=
 =?utf-8?B?d0syY2NiZWZ0ckRyMHUwTlpiYmFQZGd6c2sydVlVNXowL0JaMmFZQWVxWnQ0?=
 =?utf-8?B?OEFCNlUzWW9mY1VOS1NkMGJJWklsTUxxbWZSV3dXWjR0M3NhMVNVeVM4Tm1o?=
 =?utf-8?B?TEluUkZnVkU1OUpmM3VZTWlKSjg5WStEYXJzcXhSS09nWHpYTlBwZU1GUE90?=
 =?utf-8?B?VmN6a0VTT2grQ0NqazVLTFJyU0NaeGR5UXQ3c2w0dUJZUzdmM05HL0lRcmJH?=
 =?utf-8?B?TThXUVlFazR6MTJNTTlvOGdNRkdIS1ZPMDB0WXhsZGlJS2JnVUlEcEVtdzhT?=
 =?utf-8?B?UHk1cXA1MlFvamtPbnkvd3BxS1lack1aYU9pc2dpSVgrRUladkJLMkg2VTlJ?=
 =?utf-8?B?eHFibElnRVpXNlhNbUdwS3UwMjg4djl2YnQxaXMxVm0rYjRnZnhCTXA1TWs1?=
 =?utf-8?B?LytTY1EwZVBYMVVDa2JzZ2wxdUkrYXBsWWZSQXV4dVhkb3pEQ1Zma0o0eDFj?=
 =?utf-8?B?Z2Z1NGdqcmpPZXZnZy94cEtoMk1PSUFxb1hMcFNTNjFrdkZyLzJsYVdwNUhz?=
 =?utf-8?B?UEJjYWQ4RUNwMHdsSFdxWXprL0pQNGxNeE9wVUk2cFU5MVFlWi80NkV2Q3kx?=
 =?utf-8?B?ZU9HMEYzNDhCdG1mRExZS3hsMWpZbk9uR21Pd0p2OXJnanNsdVdCSHcxQWEr?=
 =?utf-8?B?TWhjOXMrZ0pxay9wcUI4dEpFOTNEcEc4SEdVUXkxcGJ0VW1yNm85Um9Jemk5?=
 =?utf-8?B?ZVRMeTJiUnc4SHRPSkN0Z3Z2cmNJYVVhOE5QS2FXTTdJZWNKcDNFbEgxbTBw?=
 =?utf-8?B?QU1WMk41NDN5TEJITjlxMllBV0pSU1Zjc1JaQkFwems2MFRJNGdwT0lFVmtR?=
 =?utf-8?B?YVBFQUlLS2E1eldVaEZ4U0tIc3NYMnptaituOFhqdm5pdTBGMzQvMVJjYUx4?=
 =?utf-8?B?L1J6MHZvOFF6WFlpaG9BOUJ5REgrUjR6TXlYZDYzejUrUDFPRFFKbjAzSFFH?=
 =?utf-8?B?WjdKeWpLN0ozakFtbXVlVWc5dndFbFo3djVtb0lZc2VrUUY2eWY2YThUSEJu?=
 =?utf-8?B?U1ZiaElvSkZHY2hBdHJ5cDVXNDg5bEhQQ2xEVnhWcGNudk4xMW9vcEdubmFz?=
 =?utf-8?B?N0lRV1pmUWIycDBzSkRiL05nMVM4TlFPeVIvUHcrcFRGakRHNjJNRlFlU25W?=
 =?utf-8?B?cC9VK1NMUHVJOUlOR1ZDejhjNlN0MkdtLzhQRHhJWmlWVGdrb3NkZ3JjSmdi?=
 =?utf-8?Q?eBBmCnCsJWlDs+MttIF7TZqpf?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01eda9fa-1b01-4296-4361-08db8e94cfa1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 11:29:59.7778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gM8QHxz03mu4Xjqex4MHjL1YapNKI2LtpewbAig7Ns7ubgbq4giHS1x1sJjGfOu7NoaSgt8WGBmrodlo7mtbDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8990
X-Proofpoint-GUID: Y9PhcfQZ8aZeGOoEw3Q33R4WZsz2_DLB
X-Proofpoint-ORIG-GUID: Y9PhcfQZ8aZeGOoEw3Q33R4WZsz2_DLB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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

This is just a ping for Juan and other migration maintainers, if it's 
possible to have a look at the migration patches for new QAPI design and 
suggest some review comments if any.

Update till now : Have got acked-by label from Markus for the new 
migrate QAPI design, and reviewd-by label from Daniel on the QAPI 
implementation side patches.

On 26/07/23 7:48 pm, Het Gala wrote:
> This is v10 patchset of modified 'migrate' and 'migrate-incoming' QAPI design
> for upstream review.
>
> Would like to thank all the maintainers that actively participated in the v9
> patchset discussion and gave insightful suggestions to improve the patches.
>
>
> Link to previous upstream community patchset links:
> v1: https://lists.gnu.org/archive/html/qemu-devel/2022-12/msg04339.html
> v2: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg02106.html
> v3: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg02473.html
> v4: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03064.html
> v5: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04845.html
> v6: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg01251.html
> v7: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02027.html
> v8: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02770.html
> v9: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg04216.html
>
> v9 -> v10 changelog:
> -------------------
> - Patch6 : Added extra checks for migration arguments.
> - Patch8 : Added checks for 'uri' and 'channels' both not present.
> - Patch9 : Missed adding hmp_handle_error call to print error messages.
> Abstract:
> ---------
>
> Current QAPI 'migrate' command design (for initiating a migration
> stream) contains information regarding different migrate transport mechanism
> (tcp / unix / exec), dest-host IP address, and binding port number in form of
> a string. Thus the design does seem to have some design issues. Some of the
> issues, stated below are:
>
> 1. Use of string URIs is a data encoding scheme within a data encoding scheme.
>     QEMU code should directly be able to work with the results from QAPI,
>     without resorting to do a second level of parsing (eg. socket_parse()).
> 2. For features / parameters related to migration, the migration tunables needs
>     to be defined and updated upfront. For example, 'migrate-set-capability'
>     and 'migrate-set-parameter' is required to enable multifd capability and
>     multifd-number of channels respectively. Instead, 'Multifd-channels' can
>     directly be represented as a single additional parameter to 'migrate'
>     QAPI. 'migrate-set-capability' and 'migrate-set-parameter' commands could
>     be used for runtime tunables that need setting after migration has already
>     started.
>
> The current patchset focuses on solving the first problem of multi-level
> encoding of URIs. The patch defines 'migrate' command as a QAPI discriminated
> union for the various transport backends (like socket, exec and rdma), and on
> basis of transport backends, different migration parameters are defined.
>
> (uri) string -->  (channel) Channel-type
>                              Transport-type
>                              Migration parameters based on transport type
> ------------------------------------------------------------------------------
>
> Het Gala (10):
>    migration: New QAPI type 'MigrateAddress'
>    migration: convert migration 'uri' into 'MigrateAddress'
>    migration: convert socket backend to accept MigrateAddress
>    migration: convert rdma backend to accept MigrateAddress
>    migration: convert exec backend to accept MigrateAddress.
>    migration: New migrate and migrate-incoming argument 'channels'
>    migration: modify migration_channels_and_uri_compatible() for new QAPI
>      syntax
>    migration: Implement MigrateChannelList to qmp migration flow.
>    migration: Implement MigrateChannelList to hmp migration flow.
>    migration: modify test_multifd_tcp_none() to use new QAPI syntax.
>
>   migration/exec.c               |  72 +++++++++----
>   migration/exec.h               |   8 +-
>   migration/migration-hmp-cmds.c |  17 ++-
>   migration/migration.c          | 190 ++++++++++++++++++++++++++-------
>   migration/migration.h          |   3 +-
>   migration/rdma.c               |  34 +++---
>   migration/rdma.h               |   6 +-
>   migration/socket.c             |  39 ++-----
>   migration/socket.h             |   7 +-
>   qapi/migration.json            | 150 +++++++++++++++++++++++++-
>   softmmu/vl.c                   |   2 +-
>   tests/qtest/migration-test.c   |   7 +-
>   12 files changed, 409 insertions(+), 126 deletions(-)
Regards,
Het Gala

