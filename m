Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FD270940C
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:49:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzwjy-0006iI-2p; Fri, 19 May 2023 05:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pzwjw-0006ht-5p
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:49:36 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pzwjt-0000Wm-H0
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:49:35 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34J91b1x027989; Fri, 19 May 2023 02:49:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=ScUPq6SlVtqFRz0L3QcbPszcSo53wxJgGW93NSf4Q30=;
 b=ZDHM4EC207QoUc9UpAZDNbtONIWsrxngcfc4VS7z0qjsryeC7Y/1Q3bj+7ux+71bmECL
 pv+7hUKhq60pXTkMSIHSRSYtNcMVF/w8lZO1sQWNiX6Q/0hq+dj78E29jjlWjlwi7FCd
 EhYj8GXSY9tSyGXdVXwR9mrTbr7cLah7O0ycD/SBy5i2J03bp2tJ36uLq0IcA2r8jS8D
 yTjmsm6X0k+GOCLIpqNpoPohG23FMKk+TI6gqsR4V3z4Tddy6RSDqKkogfnnpX1JBUm8
 PWCTjTo+OpA8ygsQTfbOx23hgm7CW7MRs2noCi/yqq7CaooVH7hfyUVj5em9XrXm69qT fA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3qmw97vjjy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 May 2023 02:49:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtgXA3qatJI1UMh4dTP2uuvcIEeyl3IAkrmW74A6UwfOyY76CvQmOUJWyHI0WjmJMn1+FdQvQeRnPE6FJYgEZJu2HoYASBthJ0LZ2cxbSIUwLzjVmcZNZj8tvOsawDlN80CBGNzUnVJz/GF7R2ZS6utEO0GDfkjCsv3lI4AH4FHKmJW+F3clnlOj99e1EGs6ZsHvFf3sDwyfPqSPKahhIicX7Xh6uyoiRse9VoTzK26r9y0Q/pLKl7F/E4xwz2CUAaRY23Ugg9H4ROMkMhHRY2D+3NHeOr606rPXXXY5P8fujFErTrz9mhbJXGiTnmbfI53vZBNT7Nx3KE8/H5xgag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScUPq6SlVtqFRz0L3QcbPszcSo53wxJgGW93NSf4Q30=;
 b=nrKt9baBXBYuoIgZUPgsHwkM5DrmRfeF57s+f81RmzQSTYNHa2Ojoz56S4Dig5o+0BKqyKG/njzgjTlSHIRAQuVjZ6Xdr7vemmq1KIZrkcm848MVu1Gy9gYRXa9PfkaqXte+OFnvYWe6QlY0o6GNmHorzTFZAKtaKUsyEpQeOvkNUWPx3T+QYk1wqxoTqxzDzsEDue0wxMril95010akcDH8ziuInnsMTcweRzmHU6ZC4/pm4HxMY5b+ykKPRpKYq/k2HXvDY/B6Jik7wTyx0/mzEADPgbNuhi150lyfyE/HF/kfg9Mdss9ehWOtO3yFCCfnzNrDHx/sbUurbXwMmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScUPq6SlVtqFRz0L3QcbPszcSo53wxJgGW93NSf4Q30=;
 b=GLv8Av+ga0F7WxKV8WVenlADajDQM68Ww6Y4bXYHutHKPbVAvAa1rLhZdfn/K0X+KAKN1pK1KQXuO0BIBCZxyWZ/OLWF5Ogcq+6OwvqkAZIplv0F+lu8cDJhfGLCISkbrIrJx0Kx5mPL0sutBFVK31sUyLmHuuX0qRuXs4niDqZFJRD8jydD3RqlUE00yqec1mZRS7bBOeOBb4dirVDxRNJvHcpFHV+X4N5urf/No6gioVJ78OUeV4R9/gARQBhcPSIVoJxoIDl9r5zUHes+ZhG1eS8HDKwqv/iluXSd11M/jIDHSO93pEVGtV0sQUD/sS5owFGeT8SF+491evl41g==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by CH0PR02MB7946.namprd02.prod.outlook.com (2603:10b6:610:103::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 09:49:26 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 09:49:26 +0000
Message-ID: <36660a12-1df0-2d16-ac4a-c9ec937b530e@nutanix.com>
Date: Fri, 19 May 2023 15:19:14 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v5 9/9] migration: adding test case for modified QAPI
 syntax
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230519094617.7078-1-het.gala@nutanix.com>
 <20230519094617.7078-10-het.gala@nutanix.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <20230519094617.7078-10-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0147.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::17) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|CH0PR02MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: b667f4ae-43f2-4ae1-d854-08db584e54c6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HiRrEhMQm3W0s0eT/PXOZZLFsrAJeC1NG1N7LAXROGD+Y20iERVMwGlTA2Q//SYEuD/YYMP7F2vFhgXN9Iiu3FOHyx61IMxbM8Zn5I94jfojGEZ6cicvj2ktuo4jmtP8QawdQjrjaLuKfzDG3faN5RVGTHP/ZEAp35ds+KwuPes+b4Bbm5EIVHCNi5yYfrXYv4fVR+V7E+PQt2R/esniMGdVZqiVY0oNYdqvoBn+zsW4pEMQZN+JEB21fAsCnd4PBYgKNG5WoP0hExz1TzyVY9f9ID3Zgh0gOOy0HA67k76uDS6xxlfcmJqEO0kY1Xsu7ymsv4ps4t/cIsfNP9GT3n1MPMfLSPe+Vjw5S8LjcBVmo8y6IrW2dBzkB8vR03i2OYp1rdefJpSv5nQFiKJ8BlcKysw24LHVJihNUAh3pPDoN1jqxGc0ZaHkpo3J18waVWLSpGqfKUo8zr6uuazVx3wHd6L2nRu+8H3xqqfhzvGJwNtu6Et8HOV5rtkOPFLKgUA6RWezK490QLosFLV9ev1xdvoIKwVPUXIsDtpOCt9lAua8P/XImUg8+pESHLTncmlYyePvSiB2Tikgu3e69cgp2wjjojzuFeYIQJnDhklGbfXhwZ869pAex9iFznD6sce8ikhQQkxz+Xjj7mG5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199021)(86362001)(31696002)(36756003)(316002)(4326008)(6916009)(66946007)(66556008)(66476007)(478600001)(6486002)(6666004)(8936002)(8676002)(5660300002)(41300700001)(2906002)(44832011)(38100700002)(2616005)(6512007)(6506007)(26005)(107886003)(186003)(53546011)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1g0QkVleUpveC9OZGx5eS9PaW1xdWVTbmJYWFE4Ni9NNFU5cnF1VjEzK2hu?=
 =?utf-8?B?c3JrdDh1WXlWbm9IRjB2RVlMaTJHVHpmMHJvYU5yUkFlVmJOeWgyb0hTK0dp?=
 =?utf-8?B?bDYvak1jN3dXNzZxMm1UMnRIVHVGWlFBamdPVVljOVRJWEZuTUZFSzVNcm0r?=
 =?utf-8?B?bytwbWpJSGRXWmZ6RWVRWUVVNkx2ODlzdjU2aU9wK0Vyd2w0emZuY3ZtcEtO?=
 =?utf-8?B?bGptaSsxRVViZmMrK1lzVjVWVDlEekFjWU9MMXZKQnZxazZDK2lvMUtOUnNh?=
 =?utf-8?B?dmJyZGRid1kzK3dsNzZibVZ3M0oxci9wdWo0NkhOVUFYY05LMUNMMEs0cHls?=
 =?utf-8?B?SGF0UGxiamJ0aFlKNzE2bHJsTzBUMWIzcW54cWJBeXBqNzFIejhZYWJrb216?=
 =?utf-8?B?eTRPL0pqYjBFV3NyT1BXUThzWWVsVnBVejhxSmx5amo3ZmdaOEVsMmkvNGU0?=
 =?utf-8?B?WUhKNTNTdFlxaUFZUGVvQTZLNTgyU1d6cTVMSG0rVnNWOUU5bDV1SW16MUJu?=
 =?utf-8?B?c2U5d2ZnRWZtMTBQcmtvS013MElVemxQZ3ZpTE9RL0dodWgzQzk0dk5zcVhU?=
 =?utf-8?B?TndkeXc3bXBJb2dHS2NUZER1M2graWlDb2dyc2kvcEY4RWxXVFNnajc3U2FY?=
 =?utf-8?B?V2gzWjMzOFFKT2tsMHdqRTdRSk9ZQWhEYk5qSy9qK1NJZFF4dFVBUFN4MURw?=
 =?utf-8?B?dGxmOEhsTGZuVzAybTRZbVZ0K1NNWk41MGFEcEpSWWRlMUdsTXV4cFJMdFI0?=
 =?utf-8?B?SGl0ZTFMcjNoK1AvL0kyZFdGcG5ic09QWmx0WThkYXhQRjFjL2JnckNYaTZj?=
 =?utf-8?B?Y2FRTG50RWFnQVhUTEhROFcyTHFZY042R1dOM1Era25zR0ZYekI2aE8rK2Ra?=
 =?utf-8?B?ZzZpV1lQbU9HY0YvSDJjZGRRYnRPOXd3cHNMajM3bkw0RVdqMEh1UFV4NXJC?=
 =?utf-8?B?elFxcFh2UUgreXVLTmNMWCt6VjF6aVdvcGF4VXllVllYMUJhQVJwVm1uNUdW?=
 =?utf-8?B?M3M3a2NqZE1JTGJ1aEpvRVNjdnhHM0piWllyWjNhTG55RElDcDVSTkJWVEo4?=
 =?utf-8?B?VVBPa25vZEFkLzk2WFUra2swbElaY1JSQ096bGxJS3NPVnJOYTJsR2htMVI0?=
 =?utf-8?B?ZXd6MnRmbzF1bmZrTW4yUk1EN2FaYjJpWlVXenF1bjRNYUN6cVI2OUp4My9M?=
 =?utf-8?B?cHQrK3RhRytaVjB2RFhuamRsTUloQkFuYTYwQlY0NFlQOHBYbURmcmVCN3N0?=
 =?utf-8?B?YVhWR3ZjR3I5NWJlKzNWd2VOZ1Jxb0I0L29OQTdpL010dGJkdmRMYko3RDI4?=
 =?utf-8?B?SEY2c25wM1lzTWRRWitveHFvaFZmbUI4YlNLNnpKekZWdDRWb2ZpeUxTaGNB?=
 =?utf-8?B?UXEzQUc5YXI5UEJLMVd3SGNFQXhlcHphZXpXcVZiQ25ydEEzMGVqNnBXei9I?=
 =?utf-8?B?NmFqUlVGVE9rRkNUdDNJdC9UNklrYW1YWU9GMEZKK3FnSXprTlVOZStjNHV4?=
 =?utf-8?B?d0N6UEphMW8rbWhLM1hTV21ldG9ZSThObDZKQWkzSXk4aXFPRmVmcDhEclFG?=
 =?utf-8?B?RFhnSWQvaWJTcmFCREkrZHJpaUw2dEl1aG9MeDlad1dleDk3c3JyRkZEZDNJ?=
 =?utf-8?B?Uytub2RucCtnaHNoV2Uzd3k3RkpwOExsdFhwOGIwQVN0WjRNSHNEYlFLSDAw?=
 =?utf-8?B?dGprTWJPbHhzWk1hYVBqbHJoYlpaTkNkc0tIVmhqaXN4bFlqR2IweS9jS3Bh?=
 =?utf-8?B?RGRtWU1vV3FkbWpJeTl1QU8xbDBsQndVRXR6c1lQWHd3TlFzNHFjZUcrNmhp?=
 =?utf-8?B?TU1yZ0NEWkx5NWQxbHpLT2JaN0RGbDlsdWFCbDFpb3NERk1TUXVaNFNFcEJ4?=
 =?utf-8?B?cGtiQzVUM3NrK0xTNlJaaTRocFhydnJiRUtFaVBieDNwT0h2bXl4RGxrSVhG?=
 =?utf-8?B?ajMzMzcvSCtVa2hYZDlsSkc2a0ZaeXdXUWRGK3JKT0hRZFBnTHAwOEt0ZkVh?=
 =?utf-8?B?U29TcmFiYUJIeFoyYWZHUi9CRWV4NytjNm9xWUxLNjVMTjVKdVMxZnRPWjJi?=
 =?utf-8?B?MytRc2pkeTV4RUJiT0RydDU1dmV2anNZMEI4ajhXYTdhYkIxM3dmazdDL2Fl?=
 =?utf-8?Q?pQxy+5PTQLQ/yKuz0lEavIwYa?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b667f4ae-43f2-4ae1-d854-08db584e54c6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 09:49:25.9930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRw1On4f1nRh34OMVgIqBFA0e+f+nDvTqkml7idgIouSbMyEX3D0Z1AcYppGYRtkEc1MfbzBR3IkWBd58pbtqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7946
X-Proofpoint-GUID: l4evCXjzAXNB5JyqGoizfbUr-c2fzfb2
X-Proofpoint-ORIG-GUID: l4evCXjzAXNB5JyqGoizfbUr-c2fzfb2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_06,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.544, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 19/05/23 3:16 pm, Het Gala wrote:
> Adding multifd tcp common test case for modified QAPI syntax defined.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>   tests/qtest/migration-test.c | 47 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index b99b49a314..ef6f9181da 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -2021,6 +2021,34 @@ test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
>       return NULL;
>   }
>   
> +static void *
> +test_migrate_precopy_tcp_multifd_start_new_syntax_common(QTestState *from,
> +                                                         QTestState *to,
> +                                                         const char *method)
> +{
> +    QDict *rsp;
> +
> +    migrate_set_parameter_int(from, "multifd-channels", 16);
> +    migrate_set_parameter_int(to, "multifd-channels", 16);
> +
> +    migrate_set_parameter_str(from, "multifd-compression", method);
> +    migrate_set_parameter_str(to, "multifd-compression", method);
> +
> +    migrate_set_capability(from, "multifd", true);
> +    migrate_set_capability(to, "multifd", true);
> +
> +    /* Start incoming migration from the 1st socket */
> +    rsp = wait_command(to, "{ 'execute': 'migrate-incoming',"
> +                           "  'arguments': { "
> +                           "    'channels': [ { 'channeltype': 'main',"
> +                           "     'addr': { 'transport': 'socket',"
> +                           "               'type': 'inet','host': '127.0.0.1',"
> +                           "               'port': '0' } } ] } }");
> +    qobject_unref(rsp);
> +
> +    return NULL;
> +}
> +
>   static void *
>   test_migrate_precopy_tcp_multifd_start(QTestState *from,
>                                          QTestState *to)
> @@ -2028,6 +2056,14 @@ test_migrate_precopy_tcp_multifd_start(QTestState *from,
>       return test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
>   }
>   
> +static void *
> +test_migrate_precopy_tcp_multifd_new_syntax_start(QTestState *from,
> +                                                  QTestState *to)
> +{
> +    return test_migrate_precopy_tcp_multifd_start_new_syntax_common(from,
> +                                                              to, "none");
> +}
> +
>   static void *
>   test_migrate_precopy_tcp_multifd_zlib_start(QTestState *from,
>                                               QTestState *to)
> @@ -2053,6 +2089,15 @@ static void test_multifd_tcp_none(void)
>       test_precopy_common(&args);
>   }
>   
> +static void test_multifd_tcp_new_syntax_none(void)
> +{
> +    MigrateCommon args = {
> +        .listen_uri = "defer",
> +        .start_hook = test_migrate_precopy_tcp_multifd_new_syntax_start,
> +    };
> +    test_precopy_common(&args);
> +}
> +
>   static void test_multifd_tcp_zlib(void)
>   {
>       MigrateCommon args = {
> @@ -2736,6 +2781,8 @@ int main(int argc, char **argv)
>       }
>       qtest_add_func("/migration/multifd/tcp/plain/none",
>                      test_multifd_tcp_none);
> +    qtest_add_func("/migration/multifd/tcp/plain/none",
> +                   test_multifd_tcp_new_syntax_none);
>       /*
>        * This test is flaky and sometimes fails in CI and otherwise:
>        * don't run unless user opts in via environment variable.

Maintainers, though I have added a tcp test with new QAPI syntax for 
multifd here. I feel it is incomplete because it seems like 
test_precopy_common() finally sees the arguments in form of char *uri -> 
string form. Please advice, do we need to totally revamp the test case 
functions here for the modified syntax ?

Regards,
Het Gala

