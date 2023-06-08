Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA220728315
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:52:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7GzO-0004kr-Nf; Thu, 08 Jun 2023 10:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q7Gyf-0004fj-AB
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:51:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q7Gyd-0001Ye-8n
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:51:05 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3589UwfK005548; Thu, 8 Jun 2023 14:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=00FE13bWeh1txtEzvsOSLpOJK2F+J6kvryMQWsg/w6Y=;
 b=ezBR8Tq6vghBjMT5YrPLciCT8zB5eeqKCVx4Ne0AAcbdT7iBKs0ZzwhFTN93e6vLifQL
 VElezHvoqIStdkk3zm+sufgUMbImPIYWa+yhpknXZ3tz+sXQVjuaS191DdrjZH/es4xy
 T2BOh2QXCyjVqKuaegl9WQPFX/xakrfkCtfE9L6PshbGkNDfSux9AZHslHrQI562uiW9
 PQ5S5xOPr4IDJLvcA4bf6mKNtVrdexrJ1cI2jRzIFRnRCAEl9MYLKPekTxDmENgNXb6x
 k92o/ao1f0lN9O7TdEA/E2Dub+w+J9sk7+X5LELo6UA+XrKDFdvFqWZ+9bi75fTyu1ga gQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6smj6s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Jun 2023 14:50:58 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 358EBJiK003005; Thu, 8 Jun 2023 14:50:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r2a6mqgxa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Jun 2023 14:50:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+lHR/1VaI2fZNqZHRMmKQEc0thP2xh4B8gtCk3fyhs7uNudA9BHvMg6XL6jCRQucWrq46FEzaqdOYHu69uVTvwIUVMzt1rOdJPE9xoiAem4jpJo+zmzPG/9Q5AfoKayaKgFsi7tzHzQ+z7i+qJvrzjlrCVYqlLDOJFuU6qP+pPlHeVfSkzCEpycJfEI9YNK8meHHk0lmtW6Ap4gbtH8JNMf51L7juH8jLtNI5Iduey0BUheX0O7zkgRx/82Sd+qaBmmI4/f8OWV3WSMjNtcnJF3K2YEirSy4FSTTV/B7ApBoI06Sc+Zl+szr11bLgA8rXLKtlUJEr6gdaicdzY6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00FE13bWeh1txtEzvsOSLpOJK2F+J6kvryMQWsg/w6Y=;
 b=HecgFupoEuhYShzEVyvUF5yVbzlp1wMiA2lLABc7QfTyQcOlcCHGDVHS3H6nwVrvdKm5Eg4+96jDi552Vpz4QgogIp5kyatojYGR9UjHluc27m95lc0oC/hYe1WZmhLMWvMNJJPHdwZHplQBLB1JyKKcIHZZ/vtFVMW4/i5uNHakW0ovjjt/aRazD4tqvsTJBZJTLKIkkB7+6m8ZOr60ZmFUJWA9SEICg6rO1wWfsEZx9+YGHyaxSkNgZB4G3wseEv3uB3KMu0TT+2npK8byuXV+SPvwFFmjq5ZrYodzdITNAdK2DMFFh05/wOwaAyjJ7uA/bBujudCkOI1eeqzkOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00FE13bWeh1txtEzvsOSLpOJK2F+J6kvryMQWsg/w6Y=;
 b=VKkxl46+gAVIM0Lb30CaLFeU5y496ZPhBvFR3KNlOTCzVn93kjnXJCrUdMkkknhiq1CpQG4BMlqaDLrZIeieeEPFNn6Z9ZuJ9Na1OAoLTQxQ3EfKfYgPe1UIjFjlh59TKsw7ogKTI2POkyDS9EeuLpJJ4FkCI25+4f4oQRHa7gA=
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com (2603:10b6:a03:2d7::23)
 by CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Thu, 8 Jun
 2023 14:50:53 +0000
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::36d3:42ea:8103:b120]) by SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::36d3:42ea:8103:b120%3]) with mapi id 15.20.6455.037; Thu, 8 Jun 2023
 14:50:52 +0000
Message-ID: <917a64ea-c161-b612-4266-343368d6b3f9@oracle.com>
Date: Thu, 8 Jun 2023 10:50:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V9 10/46] qdev-properties: strList
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org
References: <1658851843-236870-1-git-send-email-steven.sistare@oracle.com>
 <1658851843-236870-11-git-send-email-steven.sistare@oracle.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1658851843-236870-11-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:806:20::7) To SJ0PR10MB4686.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4686:EE_|CH2PR10MB4150:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e83187-fadc-4436-72bf-08db682fc1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: buQM9G+Tj5CmesPsKRekUBh2qnpY11b2ZoL42wQkDC/IR4ys0+IUAqj5xLt6YVwJwL1QtXiv4LgJBBujkEfhf3uGNf6LGpwLRmk+7ne4PYVmnXijTpxE+1lBFaCsqGsK3lwrQhLB6jvIinmb+ZCXz+u35nlmPBOZQH1pTzDtb2SR2g9uIZiu83ma0V3xxiDliLC6dxZxTlv9+1kHglo2pMnG7uxSsgzvBRCLxTh41IejUOeGj8pn/7BJyMnxJhhfBtb9uV8yIRJleTywraA6WnPyd/CBlUEDPO2rvm6NFQE/vjVFec/uZvY+KQ5EVUI+eKrYne3p3qYpC7kJl1MPEI2HeItV1JzF1kb9hubK22XBh+ScDL7xAT5LsPn5MIPjsguQNQeIFws1NBym22lJEWXrvFc2ZL9cCBsO+dbwd7CE8l+62awxuL237t+pRAuXQpJul1UFABTGQewdxxXqD/lpC82yl0uMxZQhtipXl+Uf7WvSNmqiDK+eZd8KMQIFsMbXqbcneD6wT7GhJVQsm1G6JLm6Pw718FbixI1Jr/t/P2gvlj2LqcULKQKTr0xme5KNUOmrnPrJ/ep05w7A2e+XydOWUit7q0zbxJ+kehpcl8d9uq1ESs5hmoEgoOInZw9dqXUKhFgPF902TM2inA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4686.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(6506007)(86362001)(36756003)(38100700002)(31696002)(6666004)(36916002)(478600001)(6486002)(8676002)(966005)(2906002)(110136005)(66556008)(316002)(66476007)(4326008)(5660300002)(31686004)(41300700001)(8936002)(44832011)(2616005)(53546011)(66946007)(186003)(26005)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDBMK094TGExMjYrYUREa3QvdzlGLyt5V3o3MEYrSjBZZzdvdUNNSUpycUdE?=
 =?utf-8?B?K3dGQ2ZDYlcweHY5WVhZemdFTlN3bjJXc2poUzlmKzJmNk1va0RaTFZ0NjMv?=
 =?utf-8?B?NWRZa2E4SzBOZkJ5RlZMRXdRV3lTQVEvRVNCUzBodk12SFRhclpvbEpmMHBz?=
 =?utf-8?B?bjNndXFwSEd0UHBxUjg1NnYxL1ZON1lJdzJ1alZGQklaMGY2QncyVXVBWWgr?=
 =?utf-8?B?RXZQdXV0OC9nVW9kVzFrcU11OXBpWFg2akkwTG1NUDdYYmZDeC8vOWdDUVpV?=
 =?utf-8?B?b1FHY20xcDJhYnBIRTNTT0Y2Y05FanJyQmNxc2tQa3o3UnVrQnR0YTFkS2NW?=
 =?utf-8?B?RzQxcytTL3BBVjJiTTJ1bVdCRCtrbGgvZ3pCZlJ5UXBQQ3JTWERabmJOTEJQ?=
 =?utf-8?B?R2Y5TThOQ1dYS2ZuRzFRUll1VHovR2tENDQzZFVMemkyK2NodjF4QlhPeGsz?=
 =?utf-8?B?UHJTMzMxcDlCc1EvT0VoL0hpZ0Y1Zm16RXF4K296R0JCTUxqeUxFTWZxRjdo?=
 =?utf-8?B?NzB3cis0OXpFSjlzRGNpOGY3bUJuc1FVdVplSDl3RG4zTXM5OHZLSThQSU9v?=
 =?utf-8?B?WjB4L2YvMzdYYTZSUWJoalFFTXQ0c0JQMVJTeUNuK1A0Y1R1WVBNSFlRKy9m?=
 =?utf-8?B?MU1PazNNQTFWT3ROYk1hR3VDSzhoTEFkWkt3bnAwTElybTk4U1psMzZRTSt3?=
 =?utf-8?B?cnhoVlJGUGVUSjZjWDZ1R3F4QURwYjhCR2ZOOVhQeDZMc0VhUC96Wko2ZFRl?=
 =?utf-8?B?a09jWkxUaHNZcFU1c0hoUmhVaG5GV3pScmE4ZnNFL0VwNENUWVBFNVR1KzdP?=
 =?utf-8?B?UmZnd01JUkRZT2tPVEtSTldPdVpCTElWTkV2bzJsVHU4MnAzRkdvcDlKMWxo?=
 =?utf-8?B?aTlmd3VOYm1aS2JRNDVqeHFnR1FQaldPQ3prMnRHS2hSOFYyeHlsTlhId3VR?=
 =?utf-8?B?dEdjaGtRVzlXQVBob1BPUEFFUzVKdTNBWWNvbGhQOTJJVEtrOHFtek0vQXQy?=
 =?utf-8?B?L0Y2VFF0SFRRaHFHSGs2Q25oRVliL2lmUlArb3p6YVVvL3VlTVUzNWhtd2oy?=
 =?utf-8?B?YzIxaXhjOFFaUlpQczlVNWg5UmlRVk1Gbmc0aUFyeGVmallHVVVYeS92aGdW?=
 =?utf-8?B?Z3RJN25OMU5mVGtEc2MrRThoTjRuQll2di9tWVRLeGZqcE90bnJPSDN4VUov?=
 =?utf-8?B?ZlVPQ0QxckgyWVY2MWQrTHA1Z3pIaG9NUkttZlg1dnQwcmFROWNMa25EVHJi?=
 =?utf-8?B?OTFaYldhcUZBVG5sWjlKaHdRWURsS0oxb1RJc0tFeDNJS3l6ZURpUlZEWW9m?=
 =?utf-8?B?TXh5RE1Wd3hIZFNpbFNCVEY2bS8zN2FCMTZJMHVrM3ord3FPK0hyUG55MXc0?=
 =?utf-8?B?dE5hTlpJUzN0TEtZS3R2LzZRZ2lIQ2xGYzhJdkwxUUNEeUlreUxRbG9vU2Fn?=
 =?utf-8?B?d3ozaExoVjdaLzdKaDlrUmwrUCtudUF2N0YvbWVCK1FtYWpIZ2w5TkpIWE5M?=
 =?utf-8?B?SXdhTzZVQytFdVUvNDJYczl2MWNVWVhZZStoM21iV2VOOVVwQjRjNVRrVVFy?=
 =?utf-8?B?bTRMNGZMclFSYm5YVmFWNmN2QmpSWW9GanNBZ0NyRkdXeEFGL1JXSVNGMGJz?=
 =?utf-8?B?S2VqcEFqU1VnZW0rMzNGNGZuVlRLem4zdkhlS0JZM3BjRTlQSjJuczNwdDU3?=
 =?utf-8?B?aDVBUW85ZXUxeS8wV04xb3ZkVVRpTjFTeENEVkRTYjl0am9iUEdVRE9DWXNY?=
 =?utf-8?B?R2huZjVRMU95bElyeHZPNFVGeHVOOTRlLzduQzVRM2tKOGJ1ZUU3KzMxdUth?=
 =?utf-8?B?SjZkVTY5UldhK2JKNTRVS24zOUgyZVdUUW51dThaMFp2NnozNlZyVEZvTmd4?=
 =?utf-8?B?dGhVdDdjaFJFekNDbytoNFpMc0tGS3FpLzFYWWUxaDJ4VjF4TFpHY0podVdy?=
 =?utf-8?B?ZnJXYWtFaGlFNlNvdjZMeVpiZ0k3dUhaSHFBU005WlZLbUZXTU1wUkpub1Fx?=
 =?utf-8?B?dEFETUdSREJkQVhKYkxnbzlpQjNpd1A1b1JvVU1yQVIwNzV2V3VXbFdjb3FN?=
 =?utf-8?B?b0VBVmZzbVNXQ29OTElpbVJqeDVsN3o0b0dBM1hLSUpKbCs1SmlFM1pNYXNB?=
 =?utf-8?B?NEhBVW50R1NHazVCOTBWZ0ZqbStsTUlEQXg0dE9qWjNPbkNiam1IcW5IN1hT?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 64Fr0QONUFaPJXh6A/ScR0xEsrvf4DDllhO3e2NsKB06YZuimzKwM/gAdhDyrkusPB5ugbHt1StVaGVyvSX7osyNx5AoPmyoFjKgJHaf0vV/NJY0ifMlxca439svDp3FoNCLHuutxf18JD9h8zGaVxtzk4HnQF8eauTj3ZrWCUWl3OkAcVIhfFxgYdyBoSB/WFfZl0MpN8WnypX+k5afXl92n/61uN/jSLJ7gszvmilmSZr2UFB0IRHdtyOgldcECy9+DT/YdKN7zTs26VGW1GA8PSOKD+cRtC7gsA7q5IOK7cjRkIWqf8deEWm5z2aKsE02vpYahxCmTcvZ21Wl5smrAjdd2SaHtVgKOAMj1uLDBDzJRMOZ3ROXxGkieB2zEai/2eshSFIP5X3+ovzwvjh9ggpXRSUYCfIw6NSuW/swdSX3wdPTUL9sCbQoP6nfcsno565mJixCiJFrD8pR+TRS5OCDXZGQrWRuFGwh1NA5lS8Sw6nm/MPVuZ4hJ9QSVTmGBsH9BwlSrjqPAhqb6GxQU4vC2HIpeGEzLn7uL0aFVb/KABcQb7l894FVRcg00COgdOrOK36VnF496QadPFKg0KpWRC7+SAVuOo/quDN2pqat9Mv8TR9mYaR7tgPeTUaZorA5P+bJfwsEALAcw894AxZC0DvwBwg/pEvSvyiqhp34akDt2v79pWTn85cntB/EgcRL4nUm37128i+yBFTUhPylg8QoJO4alYkPcFy9zvrPzpTb7llA8xqC6VBA4FtFX/y1B5BI1qaMHvn1mAhz+0rNRcwl6PZP50u1xTdAcR4kBPDejdXaa/RBpt9X
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e83187-fadc-4436-72bf-08db682fc1c6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4686.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 14:50:52.8521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ip4qLpjJ1QB1LtwDcpuJr4bXZqqcr1WinNkjKp/6lAFvd0VM+hnYARiJRO9OpUA22HSGpjiAJn1L902jMD+MAeJmN0D8jx6qJ67lS6dOU5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_10,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080129
X-Proofpoint-GUID: mXwyVB5NyZKwgjDJb39dDivFt1pcyvHk
X-Proofpoint-ORIG-GUID: mXwyVB5NyZKwgjDJb39dDivFt1pcyvHk
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

Hi Paolo, Daniel, Eduardo,
  Could one of you review this patch which is in your area?  It defines
DEFINE_PROP_STRLIST, which is added to migration_properties[] in patch 15 
of this series:
  https://lore.kernel.org/qemu-devel/1658851843-236870-16-git-send-email-steven.sistare@oracle.com/

For cpr, the user passes a strlist of args for exec'ing new qemu, as a
new 'cpr-exec-args' parameter of the migrate-set-parameters command.

Thanks!

- Steve

On 7/26/2022 12:10 PM, Steve Sistare wrote:
> Define a list-of-strings property, to be used for the cpr-exec-args
> migration property in a subsequent patch.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  hw/core/qdev-properties.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/qdev-properties.h |  3 +++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 357b876..851f490 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -9,6 +9,7 @@
>  #include "qemu/units.h"
>  #include "qemu/cutils.h"
>  #include "qdev-prop-internal.h"
> +#include "qapi/qapi-builtin-visit.h"
>  
>  void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
>                                    Error **errp)
> @@ -490,6 +491,49 @@ const PropertyInfo qdev_prop_string = {
>      .set   = set_string,
>  };
>  
> +/* --- strList --- */
> +
> +static void release_strList(Object *obj, const char *name, void *opaque)
> +{
> +    Property *prop = opaque;
> +    g_free(*(char **)object_field_prop_ptr(obj, prop));
> +}
> +
> +static void get_strList(Object *obj, Visitor *v, const char *name,
> +                       void *opaque, Error **errp)
> +{
> +    Property *prop = opaque;
> +    strList **ptr = object_field_prop_ptr(obj, prop);
> +
> +    if (!*ptr) {
> +        strList *str = NULL;
> +        visit_type_strList(v, name, &str, errp);
> +    } else {
> +        visit_type_strList(v, name, ptr, errp);
> +    }
> +}
> +
> +static void set_strList(Object *obj, Visitor *v, const char *name,
> +                       void *opaque, Error **errp)
> +{
> +    Property *prop = opaque;
> +    strList **ptr = object_field_prop_ptr(obj, prop);
> +    strList *str;
> +
> +    if (!visit_type_strList(v, name, &str, errp)) {
> +        return;
> +    }
> +    g_free(*ptr);
> +    *ptr = str;
> +}
> +
> +const PropertyInfo qdev_prop_strlist = {
> +    .name  = "strList",
> +    .release = release_strList,
> +    .get   = get_strList,
> +    .set   = set_strList,
> +};
> +
>  /* --- on/off/auto --- */
>  
>  const PropertyInfo qdev_prop_on_off_auto = {
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index e1df088..df1b869 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -59,6 +59,7 @@ extern const PropertyInfo qdev_prop_uint64_checkmask;
>  extern const PropertyInfo qdev_prop_int64;
>  extern const PropertyInfo qdev_prop_size;
>  extern const PropertyInfo qdev_prop_string;
> +extern const PropertyInfo qdev_prop_strlist;
>  extern const PropertyInfo qdev_prop_on_off_auto;
>  extern const PropertyInfo qdev_prop_size32;
>  extern const PropertyInfo qdev_prop_arraylen;
> @@ -171,6 +172,8 @@ extern const PropertyInfo qdev_prop_link;
>      DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size, uint64_t)
>  #define DEFINE_PROP_STRING(_n, _s, _f)             \
>      DEFINE_PROP(_n, _s, _f, qdev_prop_string, char*)
> +#define DEFINE_PROP_STRLIST(_n, _s, _f)             \
> +    DEFINE_PROP(_n, _s, _f, qdev_prop_strlist, strList*)
>  #define DEFINE_PROP_ON_OFF_AUTO(_n, _s, _f, _d) \
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_on_off_auto, OnOffAuto)
>  #define DEFINE_PROP_SIZE32(_n, _s, _f, _d)                       \

