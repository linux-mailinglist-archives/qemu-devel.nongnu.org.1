Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 284D17DD83B
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 23:25:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxx9x-0006z5-JQ; Tue, 31 Oct 2023 18:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1qxx9v-0006yl-Hl
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:24:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1qxx9s-0000Ic-A4
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:24:27 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39VKWWD4001674; Tue, 31 Oct 2023 22:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5Ge93TN4VPEWbxW1D4IwFP6zjK/aV8pxbAltVCWjU6w=;
 b=lRP7jYBU7zQcaprye8Mvg7SlAoXmm4rv62l5S1Is6NyMjqIIrpcy+mTUFPK3Eux3CXFu
 2HH2adyDy3oM2S7pP9TIpRa8kYcEVosXvYetx/00fehqREj2XKFH3UAVC7Qfa02z0DI0
 XsisVBeXPgQ7DGVxaV1Hi9hjUzscDy6XdxAMeFkQBqVy75uPDEzFhahh8txJpgsUz3QB
 p4HrZ52IYNYga6w51Fm++fvgtCzokq51RWmu5oqPBufmn1C13PhYh6n3IcEjDpgge7VB
 /bIc5yyRYEfpxIpzE10mB2sk0DDao3LbXoyMJGdV8q2dTYgnolfRhYmj59qybcXh9kDd WA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0swtpbbx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Oct 2023 22:24:20 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39VKcXM2022605; Tue, 31 Oct 2023 22:24:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3u0rr6bdjy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Oct 2023 22:24:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGjEQNevxFC8nftLxiAhdlHrWQ3stBRnpf4Xpaw3gXT6vM7IdJz8ijUuK53MdhPPxg01ppcwSuExaoQowQT+T+AIiiSztFz4bO3Efnoi4nuzp2mVtiTzUu7CfQ/DGG5pey1IPl8g8CSUgIIDJQY8CgAK+V7KNd5Kcctabe7L/kzYpI1N9rSO4v6YxuHgik2CiZVeNEIcnc7/qU0x+M5u2ZMein0TK/4/0Lt7VyFM88IoVsIxpHEKhxYJG7K+Zv0QwuR0KmTMT2xoHXE7rwxoyH76R32F5wrQG/ODL8/+23gCoh+oFvKhapdcMo9oyaEaPXG5sUkno4JITGQnvAopvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ge93TN4VPEWbxW1D4IwFP6zjK/aV8pxbAltVCWjU6w=;
 b=nL3CgXg9JB3ZMxEy27FTSZIeNG5C5iXVYTwUeLZjO0NBa7XTugW06X3bjmfpOh1iaYuoDDhnEGPGiZ+IIP3/EwTX88qspBqfEKCgZqhgD+uyrV48uF1qfUaWYK7th+npMm9in6m8vHyvv4ght7yWfQ43Z6/i7n47hz7wIRdgFPiREwhpq3O5bdJxYkwQ5rfY5P5484KyeGgnkNHF/WcKtWIuk8HTV8p/SuNxON8SL8d0sNOWZUux07SadKnQgpMVtjw2BFN47kmIf0unuqtMY/iPvAsJa8EGcWmuWcJPQajVaGZ1zQgR6Z3CagB6hVIR7DvCUIjnYU6akrLCXqpwJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ge93TN4VPEWbxW1D4IwFP6zjK/aV8pxbAltVCWjU6w=;
 b=r7jswq6ZTM3++C4zxslOniv+gNn6bhDROv98kKVI8+6WPfUzlHb/rdBg9UbrhqQYWb7KTcguwAVgLaVVo5K5C1fKykJHLJFy9z/dolK37aNLV8k3cFdMciJcI+ZWw3ibbChCWg7DZtue8GdQQHzFze5zla6OAE3Q0P2w9t7oGUQ=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by DM4PR10MB6088.namprd10.prod.outlook.com (2603:10b6:8:8a::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Tue, 31 Oct 2023 22:24:17 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::afac:25ec:c0ba:643]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::afac:25ec:c0ba:643%4]) with mapi id 15.20.6933.019; Tue, 31 Oct 2023
 22:24:17 +0000
Message-ID: <f0adae79-7c6c-3e52-3bd1-f2e094d4a735@oracle.com>
Date: Tue, 31 Oct 2023 15:24:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/1] hmp: synchronize cpu state for lapic info
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, armbru@redhat.com,
 thuth@redhat.com, kkostiuk@redhat.com, berrange@redhat.com,
 dwmw@amazon.co.uk, pbonzini@redhat.com, joe.jin@oracle.com
References: <20231026211938.162815-1-dongli.zhang@oracle.com>
 <87edhc9inl.fsf@secure.mitica>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <87edhc9inl.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::17) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|DM4PR10MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a03069-2633-4f26-a8c6-08dbda601efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a4Mq28nTbAb5SJedxl5u2C5VVTdJM6B9yeB9y8IhkxO2JGs/Tzd6tHoscj0eKmtmRdYJ5ijPUv1lXM9xYv0PmCce7U8LPzXCoVChqBcX02ziOgTzGPSJiBRe2G5dsa61nguRWIdepGrOjddWYtscaSLVk0WVnxSqk762tQDhft8TFEyBDnBaKornugwL3OBS3wguoGUpH/skv7OisQzS7EwZW20/NHcICfOptbn2pN7+NYCRsCyA6CPtmQ6fWjy34JVsHm/XNq8/fHZH9DvOyqv56ltrl4WbbnhKAvhIldBhwn5/rmXwRHMh2khypnMl610D7XUyqQE15iy6OkRLhkLi1FbGSU/55nQsbl9GXTEgS4nd2bENGJ7nHLHeTy8CQPItv7m/USunFZPZf2l4iucCYYbUm9vUUfIXC0kb+M08SUY/DGah++m/vff7oe9Xq+SB7s6jYx5t07xsdxmd40nKtYGdT4yxwr3vFUKl1LM1SU4NEQ680NA7YxRv7Kk4KZy3D+sBoqZVR4uwpKEjN6gJyHer6oIZqtem1dySV7NIhGW1sfAjMfLIaMCKk7n963uHodFtVd4F6ueftVyyAo4gIWoU5izEk3EQXx3mSdpHpbSGBiJhY+oSZkmoXB0Ny+wbRNMP4LcYYeUhxXMZzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2663.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(107886003)(44832011)(38100700002)(6506007)(6916009)(316002)(66556008)(66946007)(2616005)(6512007)(478600001)(66476007)(26005)(6666004)(6486002)(966005)(53546011)(31696002)(83380400001)(86362001)(4326008)(8676002)(5660300002)(36756003)(41300700001)(8936002)(2906002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEZrWGRaNENacS81MTJEZVMwM2pnQldweXdmYVV3MnYvVml5QWQ4bzZvQ2Zh?=
 =?utf-8?B?bnFrOUZ3UzR5WnYwVUJicndRRzZ4UUM1eDl0aGU2eXdkM1RDTVNob0dlS1lr?=
 =?utf-8?B?eGpjTVJ5bzY2QnpMR0lOWkF6K0I0SUx0bUFUSnFvZFd6cmJiM1h6aERWTndh?=
 =?utf-8?B?WVVrMWlld3ZaQVYzZzFRWWJhNXc0amFSbWNHakFqbExaSlFvM0lPQTdYNkIw?=
 =?utf-8?B?bHhOUUNTSnNkQXZTWkVQcGJIdHVEdWxMS0x1d2lsWGJ2QWkySGFRZlE4anlM?=
 =?utf-8?B?TDhQamJnbXJDSE02VUxFRGRNSUJTMWYwRzJLZHJjTm42aUxqNjZ6ejRDZDMy?=
 =?utf-8?B?Ym9BWFFxa1lCd2Jyck9iWitlMDNxTnBlR240bHlvR0V2OHlJUnJlQXB2djhO?=
 =?utf-8?B?Yi81THJSd3FidUNQTzRsdUZVQndkTWVCOS9PK1p3ZkhiWGNhSkpVRi8wUDhu?=
 =?utf-8?B?OFdFckg5QkZPRy83Rml0aDFmV2NvUnppRlJVclZIVU41bGphTEIzSUdBbjF2?=
 =?utf-8?B?bklIcDdjcVhuZk9pNkFMc3llUkdBRlRobmpuSjZkUFo1eFRPQ2JuMWRFbXhW?=
 =?utf-8?B?ZlNqQlE4STg5NzNwYUY0RWJFSitEVWtaZ0E1SzUyaXhJVUNtWUgvTENmR2NT?=
 =?utf-8?B?WU5DL2lIVmRqb0ZqZDlWLzZhRHA2bGhQcGY1aU5QVzVBOWpJS1IrUG5ybU51?=
 =?utf-8?B?b2JPTXFkSVpQWUh3OFlRSDJZL081YzZjaFVORXZXWDZtOStEVzB3SlVib2Rt?=
 =?utf-8?B?NGJ5a0JqVjVOMmpaWCtGK3RkUVJieDdMSytTdlBaNlRXaWw0TEZHWVp0bDlF?=
 =?utf-8?B?dWg0RUo5K2lYRUpjQkVCa2NXUW1CL0dBeWdNTFNyVkpzMXFaNFJyQm5McHlG?=
 =?utf-8?B?M1JvSDFhNUJLQWdna0tnVEx2S1JHT1NJS1lJc2NSMy9SZE5JNlpkb1NjVUY1?=
 =?utf-8?B?cjd1VkkzdUpXYjh4TTFRV3o1N0tHMVBNNzcwc1plOHRZS1BhZkkzRDZaRGxZ?=
 =?utf-8?B?VGowemxuQ0s0T3U2LzdZcm9Fck9Lemh0N1g5ZU9tQktBLzU4S3owcTFaMDN1?=
 =?utf-8?B?RGNObFVDOEFJZkpDTGFhNStrNy8zZXhpOUZMRi9HVTAwRHNFUWlLSzZWMEJE?=
 =?utf-8?B?UHJHcnlJWnVKSDNna2RYTzJ3L1R0Snh1U3c4N0ErWDYzZWt0bmJsVjNZN05Y?=
 =?utf-8?B?VXNRcnZPK3EvYWt6Nk4rdlEwaHkrNE9wdWxxZ3c3VDlCQlUyeEVsSUhhMzVq?=
 =?utf-8?B?R0c0RVhIbmJFbmxhRnlEQUx4QTY2eEFKb0Znd2REMWUxWUs3RjlwMHRRbzFt?=
 =?utf-8?B?elNvTEpZcURjQkRzZUlORUZtK2U5T25GWW44RmUxdVhJK1pCa2UyKzZuRTRO?=
 =?utf-8?B?dUg1NUJOcDcwZkQvRGZpRlkrYnBUV3Q2bWVSS2prNThhbzI2NFhKeXY1Vm01?=
 =?utf-8?B?R0RaK05JMi9IdE1WVVdtYTVaN01NR0Y0bWp6dk5PaVZvMVVENzV6dENtVmlP?=
 =?utf-8?B?cmNtc1dBNU84SSswYU9VaWRvNFRwVlVTSVhzeWJZS1dCMy9IU0k1TCtreEJi?=
 =?utf-8?B?MFc5cDN1NEJXd0tXVXh4QytGRUh0UHhhNEUvdFRHQzBJaEF2SzBkWTVQQmlk?=
 =?utf-8?B?RytQUmxIbE5zUy9Sdmk2Q21Ba3JHSG1iSm9CS3ZJZGhjL2I2M29VcHBZSGNt?=
 =?utf-8?B?QUl5RkVHNy8yZ1haUTU2RWdsYUF0cmJjWXhmYUM5ODJnNTdlTVlPYkZ6NGhu?=
 =?utf-8?B?R1dQd3NIbyt2RHdQUmR6RmIycW9BZ0x1cnppYUE1MVhMNjR6b1o3U3pmR29q?=
 =?utf-8?B?d2NsemE2MzlMK3FzdjNZRHdRTThSMGRPOVk5cDFJNGlpYWlvQmI1b0tVcVVt?=
 =?utf-8?B?b3RMaXJyeTYxU0pPNExZY0pEUXdYSnZuSG5PRDYxd2s2NzRuUUJhZ2FYbFEx?=
 =?utf-8?B?M0gyTnFxcEE4N0QzOTBhZkhNWTF5Y3NHQXBiNkRacWt1ZGtBVTRtTmhuWkd2?=
 =?utf-8?B?emVSN2R2d1ZvYlR5NmhkcWlBWHNadzZ2Vk5PRFVQYzNFaFFvKzd4UzZ1S1B2?=
 =?utf-8?B?Zi9DK2N2YURLUjRka2FYYVVXU2dkL0Yrbng2cVI2R0RyRDdabkZIM3RJOEVi?=
 =?utf-8?Q?uZCiiiDNNEAI02ra8iE0XcIez?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XYsQQanVu1JdBx5M5TLgKHpvwmsoe6uIdF9M83y/7y4jEr1PzKJIyeo4HfvvoEkwrTKUzMPIP1N5/gb7tsSlTzCC/NJiv5UqaV+/ShNky6CAbSmzPVYyN80PnTW+XYMimWTfxyBzjciZhKc9U5j7KHNoaeoNIzRxcnryYLtS846wvSd/Y7zCSaIqL51fr52ZvzfGoXIg2IykKe8lT1hf1UCADxAkEVtf79zIyh6KuMZOxuDdsN2XvXc+8vbIvoZ158EQrj56oNtByaxMeBQTybWha4Oj6fJkWp2ZkPs49L/hUTPmZ0VO/jiXMTNqtIf0KvGWwUTDOtu9LMa32/V0mE5kvcxBYa1vbyPYe9y9awYzjUtNiTqwQpj8jIiFcV+Wbgi4or3T4KmZ/Dj72dUt6wUlz6mkyHhVNQ1Hmp2RHgk85klxRhUKOr6rmrHnnBkm7t1SrHR6ogp3Hvxkwbn/pNYZO2K0V/ZT8NjQ0aQvxoueAnK5YYCBeMMDNbYaBmO9eHCBBTj3bJE9rYnytwqzY93aHXGaGiwsH1mvKaLmYhK/8O6hkKeGYnfDd1cydjEZFSEEcJew2rlZJX9VbeN+SmSxcFAp4Zi7e6ovjbUutHbwt9fdZzR7KPeTEYMjezpOaME/kqgLuD2Fvq4qlcS9S/A92woRxf0s5jLFUwvTCYvB+1vjbVm6UHO0z3lC6R5C541lciHJpJrvwgYKOAbzTkkd5E/G9WajQn73oAKxf6IdqqgmzMkmmMIR/Htis/asUMnJPZWCHZJvQQRpDM26++KE6l8O1VYV96ZGHpBa5qNESGzftIOypxqpUTLakaJXFY/28fH5Ejp/PBVFS40XjW9T0VdM5G1uZ7NveC6OdvE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a03069-2633-4f26-a8c6-08dbda601efd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 22:24:17.5983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTFO8JUfJBGYytOHge4D9v5S72FbzKn+frodSI/9fhoFyGGHimS6vFzuEaY1Dcf3ORdRihd8M5bAArD4sf0T5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6088
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_09,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=966 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310185
X-Proofpoint-ORIG-GUID: eLelWS7hHloVxUj8bSmy8Eno6hqsVvGK
X-Proofpoint-GUID: eLelWS7hHloVxUj8bSmy8Eno6hqsVvGK
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.053,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Juan,

On 10/30/23 09:31, Juan Quintela wrote:
> Dongli Zhang <dongli.zhang@oracle.com> wrote:
>> While the default "info lapic" always synchronizes cpu state ...
>>
>> mon_get_cpu()
>> -> mon_get_cpu_sync(mon, true)
>>    -> cpu_synchronize_state(cpu)
>>       -> ioctl KVM_GET_LAPIC (taking KVM as example)
>>
>> ... the cpu state is not synchronized when the apic-id is available as
>> argument.
>>
>> The cpu state should be synchronized when apic-id is available. Otherwise
>> the "info lapic <apic-id>" always returns stale data.
>>
>> Reference:
>> https://urldefense.com/v3/__https://lore.kernel.org/all/20211028155457.967291-19-berrange@redhat.com/__;!!ACWV5N9M2RV99hQ!KOLfuCesLC4T6ka9bjf4x6ncC34GPK9pVvWwOJhbwSZw2fwp3Mxlakk0fnR-NCoqRPKOX7X4SOAxozQBC7VQ$ 
>>
>> Cc: Joe Jin <joe.jin@oracle.com>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> But I wonder how I did get CC'd on this patch O:-)
> 

Thank you very much!

This component does not have a maintainer. I just blindly cc all suggested
reviewers :), in order to get it reviewed and merged.

get_maintainer.pl: No maintainers found, printing recent contributors.
get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.

Thank you very much!

Dongli Zhang

