Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3722F743E98
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 17:20:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFFu3-0004tC-0G; Fri, 30 Jun 2023 11:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qFFu0-0004sw-Ht
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 11:19:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qFFty-0003xz-6f
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 11:19:16 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UEmlmG009881; Fri, 30 Jun 2023 15:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=F6XFyuep/Sr7RXpZS1zvkiPJICbFbuQA01jHqpN7A+c=;
 b=xZf8431bzFvRDsDGttZ+AhUWmV/zHUVdZdjPjdV3jv4jsjeiOs2ifqBhTkLIzpS6zF1A
 IgxWs/2hNjz2TpyJeMWaxRZOGMVGHVk1ggPz+/VmypzPy8QtKIx5U78fJGbL58Oh9eJg
 saR8+SsJX2GOFk9YA3DWWR5KxCoknC8+S/x/VBVP4SvR/RrugDZz36lpNNfEbcA5ilN4
 hKd3KHb8GZGGvErvYHWz2xDPGB/Z3enxMJKd5n0szH5oZKPXVQowBp27VQLEXGvhLTFS
 LhJTwXal0QqP+AYVi6yXB1Hz9OFl6cN1KNkg8UWx25LovJqOJBiuAV3yB1Mb1NaMxI0m 8g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdpwdrtxs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 15:19:12 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35UDgV7E008566; Fri, 30 Jun 2023 15:19:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx8ydg7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 15:19:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVq+6sprpZLK6VbzBahk8PZemMyfImS7YHYA5g6CB6XPsZajdSrxpLdbQ37zHd89eNMLXnm+T62Z+5KmaPJhpFK7zYzB0nX0YIYaE5uHn9/sqIMe9k8i2Fbx2UZ/iJGzXW/m3ND2IM4GtDZce4fVGP1nCW2XyykjuWP2WxHrBkTwe9gE0hvKCEXhiLI2xoF46OJf7WU118asKDo9SXccW7Xf2Xmry7Li71dKDUz42YZcALmrCQsSy4YcmCMsJ0bwkzWJ48pYwHzpgDk4gRksuN124FIXVgEhoXqh/76vm9tCFpDhksh3QU5mfLkSKSnQ4IOAK5vDYF2xvDyOSzRV6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6XFyuep/Sr7RXpZS1zvkiPJICbFbuQA01jHqpN7A+c=;
 b=UqQ3fmXnocaxsRGcks3e1OmXtUIS/pDQPgJdDGp09c3/SMvRqgNTSvj9v1ra0BgP8LiHZW371guW6WIoCjWF83/b97JRh/ZKNl5BZQBDa+BVQ4LTAsxkhIYQlir0wQ6R8m/jb4f0fwOAwwtVfqmxFAEE6qq5fQ6cjE/+AfShdckilh+Bd8lJIE7SsZtbnIuRT0IIiX8nZDor1U1Efb5Tb+rUBGxWA5/TdK1rjxJncQochHM5L2CqM9SGaQIfZYvzxjC0Ebw/ZVAep9t1KtYo/5jOeO0O1Gvo+cdySAf94r5/KeFurigi5KimluhXvk+yJCAZxxmv9xwI4RX552FfvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6XFyuep/Sr7RXpZS1zvkiPJICbFbuQA01jHqpN7A+c=;
 b=iTxsuXxHURusjEr6gs+iBH2HEKfw3F8qmlSIvopfdn1yEtyYPKwf4WYmx5t0DhAaQPiSjje5xk4bstfoligpG/odDhgIOkqBqhY0zdvMNMfYxQgzGfttRV0cYA9a3oiu3XJn27PlHnaAqF8HRmSmUWq0OETBGabXfMQ/aLKySPk=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by BN0PR10MB5111.namprd10.prod.outlook.com (2603:10b6:408:123::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 15:19:09 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11%7]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 15:19:09 +0000
Message-ID: <8c03494b-7d0b-8a0b-ae79-1dfc3e9eaa50@oracle.com>
Date: Fri, 30 Jun 2023 11:19:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6/6] tests/qtest: migration-test: Add tests for file-based
 migration
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230628165542.17214-1-farosas@suse.de>
 <20230628165542.17214-7-farosas@suse.de> <ZJ35d0yqB5YD+8IH@x1n>
 <874jmpq9cc.fsf@suse.de>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <874jmpq9cc.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0104.namprd05.prod.outlook.com
 (2603:10b6:803:42::21) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|BN0PR10MB5111:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e8914a-4433-4e87-0d92-08db797d59de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aW1Qged6oT9HYL7A1omTCV7+J9vFCOEsYhklYLa8Zu+Bc5uGA+luPV/GskDEX7EY6M6qHFA/NuHZmRjyt+EUGqQmHj+MiDP8xwW6yVeb3DY9dVbHQbsyi0/c14+TG83UwJ4MmwZYldu8ynLTzO2vxztwXC4zEiw2ufc9lUyl6ieFAVgGOEBjo87IDPKvJk/gohfE825rUzg6+8BlnhXIEJ56UJ1S5vSifSWjCGFlOcT2+semYW0GQE7T64Why6PEoq+SDhOx1HDNRYGzBwHYorEUCxA2s3WDLWEZZ+KtR+Of8nLEtpu6WKRjNGkf8ukUek71VzK6+fS4On8gLMKjfcVAy2FoiJ0w5DgxmyvMHgmrN7NGZHsRgATr0uGb/paGLCOi87iMalTLqHY2pyHtSZyuMtkLVPnZpv2R+KbqzUG8zaZlhXDwzLtrEQdDd1cJCfZB3WEmMF3IpF5nfnBYJPgAPnINo59Ate8QOyHGlTyzDIYe62VFk1RikYl5MKBmHliMPCkTRNUvVBDdIO+HnXxC1E33gpvZcxbWqiP6/CgFshJDyucSdpmYYPrIuRmkqZ2IsOeSz7GuDuWdlyVgsl18mWKE3jNUx1a9Ifsnr/RXlkSvyp1d6dtu/Kn0JUnM7DcIQf0exoD3bwPggRXgQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(31686004)(86362001)(54906003)(8936002)(8676002)(5660300002)(110136005)(31696002)(26005)(6506007)(44832011)(53546011)(6486002)(36916002)(478600001)(66946007)(66556008)(66476007)(4326008)(6512007)(41300700001)(316002)(186003)(2616005)(2906002)(83380400001)(36756003)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGVSSXFMWTR4YkZDNVVuc1EwN3NEbk9yOVYrWUR1NkhUTXhuTXdwUzNZY0Iz?=
 =?utf-8?B?MmdGdEpqTlNBLy81eUp2MWpHbDJTREl5OXpTWCtvZ1haZEFtQU9JR2NnUkhv?=
 =?utf-8?B?ZTRSaXZ2eU1yNlB0dlVuU3gycTdjZElkK29QV0RwcFkrZWM1V2tCTnRpcDdV?=
 =?utf-8?B?MzB5NGs3dUpvNGUvUU9QYi9CNnRnM3VJNjc2Q3JyZjVmekVqVDk2dGQwS25W?=
 =?utf-8?B?RGt2Wm1iQi9DdTAyZGF2OXRVakZRL0wvT2Z4YlZ4dFdpZE9zZ3ZTMm1hVmE2?=
 =?utf-8?B?TFRUaTlGVUl0Zm9pWkN1L0lHTkZDelovdjc3TVE5aFlzZnQva0xxY3FoN2Vw?=
 =?utf-8?B?STdYdVdLUVdFZkg5RDJXVHdHSHZVcCtneXh5MnR1bEU2SXhEYXhUeXA1UlB3?=
 =?utf-8?B?eVJiVG5GT3NwWno0S1BpRjdqbTZVdzNuNVJPQzlKRkcwR0JXTjNOMzNxV0c4?=
 =?utf-8?B?WUw1QzFMUzcxS1RMN0RmWEEwWjRObGtMd0VZSTBhbUdKT1F6bjZUVmRISXhX?=
 =?utf-8?B?WjNSZXpDcExtWEp0dzFSdW4vbGUyUkJOQmZDZ3o1Ny91aTBtZHE5VTNHWElu?=
 =?utf-8?B?ZmdGL2JWZllyaDVic0pSeG1HeVc1RWUrSW9QRHczODFpRnFiSDhJNXVUYzdB?=
 =?utf-8?B?UXcvc1RidTBVdDFwUTBjOFlWZHBoRUQxNjlOVVBHUU1BOXcxRm4ybkQwUjVP?=
 =?utf-8?B?RTRFMnlGSDVMOVk0SWZJWHNHZVptTUtUN3dzVm40ZG9xMlFobXRCdFpFWHh3?=
 =?utf-8?B?bDBueTAvSnc5b3NINEhMM3djbWd1WXNheElBbU9qOWFzb0FYeGJSbFBhZFZP?=
 =?utf-8?B?SllJOVVIZDFvVUVGVitYM2hvOTRvMlEyTWVQU3NDRVdxdVZqRFdXOTBUcTN0?=
 =?utf-8?B?RHpMbmliMWc2MXF1bWszYTVJY2w0VFlnUXE3ZVZSWC9nRUZlZjBpMnJXajcx?=
 =?utf-8?B?VmpYZG1CYlJORjdiS01yUktKcVgvdjJ4MW55aUoyRFdjK0pQNnZaSy9SQkFw?=
 =?utf-8?B?K2VsRGlPV2RzK25zcCt4cUlDNmx3ZHZ5MXZZS2tHR0gzZm5LZmdwcE1jdHM0?=
 =?utf-8?B?SFBBRzZKQmEyK1VKV1QvaHZmdnhucDNnSktoL04vR0pZSTJTclQ0K3RleitI?=
 =?utf-8?B?a0xXb3hWRGpORjNBN0VTcEpQZi9LVG5qNDVLRFIxd2ZxM2N6Y0NFQWdIY1ZS?=
 =?utf-8?B?bE0xUVJtT2w5R3BaK1hVWitaYUhOK2tmemNaT3JmRTB3R2c1UmR4T203SUNE?=
 =?utf-8?B?WDNRZE1NaUhBL1ZKWG5TbncwWkRMcytMR3g4NEpPQXpCbEkyN2tmTDFSQVVR?=
 =?utf-8?B?VnNvdEQzd0pUN2U1M1FKeTBjZmJaMlZIcTRvNTU3alNHdEsyekIvcm9YTGNO?=
 =?utf-8?B?anJqZnF5M2pmT2JlVXFOQ3g5QmYzcmdSREcrRVNJVitPekhSTmtscmIyQ3FS?=
 =?utf-8?B?NW5rQTBOaHpjS2NsTFU2ai9kdUREaXFLRTIySU5sV0Ura3F0VEM2bENFZXNH?=
 =?utf-8?B?MzI3Y0h2VlpPOUQ1WmdLWERvYnBzejlJWlJFMWxZMldacHJvSWVRTzVnU05l?=
 =?utf-8?B?QksxWFBHV2NqeUN4a2xZV3Jqa3FVU3VKVWRzVGwrRTBlU2NNcktaa3RoTE9x?=
 =?utf-8?B?K3RwcVNKR1RBWk55UHk4dWdIRTFzNTRIK0dYL0tFL3dIUDZMaENvSDN6K3dX?=
 =?utf-8?B?MGM1dk53MzRFb3V3YjZBY2gzTC9FY1p0Y09hc043WVowTndCSDU2UHJMTUIy?=
 =?utf-8?B?ZHpRUTY1QnpDOGU3bFR0c2k3RnhoM2lXVjB4M2M2d01DbFU3TVhsRDEzaTBP?=
 =?utf-8?B?Q1cvdDViSHptTXlla0lCdXRiRXpveXVyVUExQlpyME96THQ4T3JKSG81WTVD?=
 =?utf-8?B?Z3dQZFFoZnNGMVg0LzZLNTBiSDJkV1ltOVZDczYvSlliUG12RXNjRnVrdVFn?=
 =?utf-8?B?UFJhK2hDNllXQmJOWldWMzRURTFJWnZCcjUzengrR3hDL0toMENGb1NTdzlh?=
 =?utf-8?B?R2REQlBoUmZ4UWZyOU5pRnhvT2QvZk82QzFEVlhmYzZDalZSeDVHL1UvNEdp?=
 =?utf-8?B?S1N5cGlPYjN0RFF5c3o4MklQZEpDVVRWcmtLb05ZVkFha1VWK2Q2YVg1OXpN?=
 =?utf-8?B?c3liOUUrY09Pa1FSMERyWXpIbThwVzNTaWp3NlJYL2pLK3RNd3FaRVk2QlRR?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GW++1M0+wXuJVfmOSN54Oa6mJzCjgKo/yEf9RR7wwTwgAAfj1v2D9OVUUQ3KvturdppkdlqU3cItkO85JIK+juBVcOWtoO89qbzmfhzkNKrGDBSqP5LO8kjuqNgHzF3/bJhuttjL77HeI3OncwJiJEOeiwjDEKo//gjDtZ6uCEz3yF0ou6kQgkW1UytSNzqnJz8oJ2xUR8we2nZDboN9uDEqz9oxiWBjtUpeuE+U5u9nS8N+DulDSpo/g5FcQNuDUnD3eFEVTZg08jVWPXacj/BMlzk7WrHb60yHZRtCKXvha3f6dloEikFKkCrDzpFvt56gN31n0GCx0oXYprkpiQqpKjhFqdOWemkixGd1pAD0oAm924x01a64XJNZGu9NDviUypPWczN93EbZIMnIQD/4C/VFDudcIJCkQIc6yn4KToawmIKi/b1vBFQiAzKLMNiJbRUT5SDSPtrams7JK0itC2HhPXmdkmalR7iQ+ip6zV4bB/zWpU8Sv35qdBbKfthJo7aRq1wPqAoKsplfRLIiK8xUhLU8ZX6xD8cqdn8ji2XVJChswcJCjPovb/YbhcZH7/JueUFheTjXlx/BEBGwkN/OBj2msA4tq5kAkkxTiQEr/wpNtseDsi53NoI0bVE54UKHnh0pyKyTUMmMWp8xUOGLkSslia86obSLlD9Bbl+OHNWEDplH/iexx/WEBxf00omKQECyMIc/QhlTmW6c5W5osI4GOM67fugRQvu7dVAQpbycCeOm6ITU3mHb72s/NPLvQRbASAG25GTWbJ9Vvl/y2gYwy8/75LBEA4A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e8914a-4433-4e87-0d92-08db797d59de
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 15:19:08.9802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SP20dftI1WybWiZaVL7BNZSAne5DK7Egfw++ZzGq4byURSkpe5ZfCZi+uR7j5GNtm+0e36YSWnVZo2UWqMmt+7tH4p1WntZkR4kO8Q1j4Mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5111
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300130
X-Proofpoint-GUID: U4WRckyO0QbR4sTVLqXXx0yGSvkRVijf
X-Proofpoint-ORIG-GUID: U4WRckyO0QbR4sTVLqXXx0yGSvkRVijf
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/30/2023 11:05 AM, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
>> On Wed, Jun 28, 2023 at 01:55:42PM -0300, Fabiano Rosas wrote:
>>> Add basic tests for file-based migration.
>>>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> ---
>>>  tests/qtest/migration-test.c | 104 +++++++++++++++++++++++++++++++++++
>>>  1 file changed, 104 insertions(+)
>>>
>>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>>> index acb778a8cd..b3019f54de 100644
>>> --- a/tests/qtest/migration-test.c
>>> +++ b/tests/qtest/migration-test.c
>>> @@ -52,6 +52,10 @@ static bool got_dst_resume;
>>>   */
>>>  #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
>>>  
>>> +#define QEMU_VM_FILE_MAGIC 0x5145564d
>>> +#define FILE_TEST_FILENAME "migfile"
>>> +#define FILE_TEST_OFFSET 0x1000
>>> +
>>>  #if defined(__linux__)
>>>  #include <sys/syscall.h>
>>>  #include <sys/vfs.h>
>>> @@ -763,6 +767,7 @@ static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
>>>      cleanup("migsocket");
>>>      cleanup("src_serial");
>>>      cleanup("dest_serial");
>>> +    cleanup(FILE_TEST_FILENAME);
>>>  }
>>>  
>>>  #ifdef CONFIG_GNUTLS
>>> @@ -1460,11 +1465,28 @@ static void test_precopy_common(MigrateCommon *args)
>>>               */
>>>              wait_for_migration_complete(from);
>>>  
>>> +            /*
>>> +             * For file based migration the target must begin its
>>> +             * migration after the source has finished.
>>> +             */
>>> +            if (strstr(connect_uri, "file:")) {
>>> +                migrate_incoming_qmp(to, connect_uri, "{}");
>>> +            }
>>> +
>>>              if (!got_src_stop) {
>>>                  qtest_qmp_eventwait(from, "STOP");
>>>              }
>>>          } else {
>>>              wait_for_migration_complete(from);
>>> +
>>> +            /*
>>> +             * For file based migration the target must begin its
>>> +             * migration after the source has finished.
>>> +             */
>>> +            if (strstr(connect_uri, "file:")) {
>>> +                migrate_incoming_qmp(to, connect_uri, "{}");
>>> +            }
>>> +
>>>              /*
>>>               * Must wait for dst to finish reading all incoming
>>>               * data on the socket before issuing 'cont' otherwise
>>> @@ -1682,6 +1704,78 @@ static void test_precopy_unix_compress_nowait(void)
>>>      test_precopy_common(&args);
>>>  }
>>>  
>>> +static void test_precopy_file(void)
>>> +{
>>> +    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
>>> +                                           FILE_TEST_FILENAME);
>>> +    MigrateCommon args = {
>>> +        .connect_uri = uri,
>>> +        .listen_uri = "defer",
>>> +    };
>>> +
>>> +    test_precopy_common(&args);
>>> +}
>>> +
>>> +#if defined(__linux__)
>>> +static void file_offset_finish_hook(QTestState *from, QTestState *to, void *opaque)
>>> +{
>>> +    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
>>> +    size_t size = FILE_TEST_OFFSET + sizeof(QEMU_VM_FILE_MAGIC);
>>> +    uintptr_t *addr, *p;
>>> +    int fd;
>>> +
>>> +    fd = open(path, O_RDONLY);
>>> +    g_assert(fd != -1);
>>> +    addr = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
>>
>> Not something that matters a lot, but RO mapping a file with private is a
>> bit weird.  Maybe just use MAP_SHARED?
>>
> 
> Yep
> 
>>> +    g_assert(addr != MAP_FAILED);
>>> +
>>> +    /*
>>> +     * Ensure the skipped offset contains zeros and the migration
>>> +     * stream starts at the right place.
>>> +     */
>>> +    p = addr;
>>> +    while (p < addr + FILE_TEST_OFFSET / sizeof(uintptr_t)) {
>>> +        g_assert(*p == 0);
>>> +        p++;
>>> +    }
>>> +    g_assert_cmpint(cpu_to_be32(*p), ==, QEMU_VM_FILE_MAGIC);
>>> +
>>> +    munmap(addr, size);
>>> +    close(fd);
>>> +}
>>> +
>>> +static void test_precopy_file_offset(void)
>>> +{
>>> +    g_autofree char *uri = g_strdup_printf("file:%s/%s,offset=%d", tmpfs,
>>> +                                           FILE_TEST_FILENAME,
>>> +                                           FILE_TEST_OFFSET);
>>
>> Is it intended to also only run this test with linux?  IIUC it should also
>> work for others. Maybe only file_offset_finish_hook() is optional?  Or am i
>> wrong?
>>
> 
> Yes, only the hook is linux-specific. I'll change it.
> 
>>> +    MigrateCommon args = {
>>> +        .connect_uri = uri,
>>> +        .listen_uri = "defer",
>>> +        .finish_hook = file_offset_finish_hook,
>>> +    };
>>> +
>>> +    test_precopy_common(&args);
>>> +}
>>> +#endif
>>> +
>>> +static void test_precopy_file_offset_bad(void)
>>> +{
>>> +    /* using a value not supported by qemu_strtosz() */
>>> +    g_autofree char *uri = g_strdup_printf("file:%s/migfile,offset=0x20M",
>>> +                                           tmpfs);
>>> +    MigrateCommon args = {
>>> +        .connect_uri = uri,
>>> +        .listen_uri = "defer",
>>> +        .error_str = g_strdup(
>>> +            "file URI has bad offset 0x20M: Unknown error -22"),
>>
>> "Unknown error" may imply that in Steve's patch the errno is inverted..
>>
>> Shall we not rely on the string in the test?  It might be too strict, I
>> worry, because error strings should be defined for human readers, and we
>> may not want some e.g. grammar / trivial change to break a test.
>>
> 
> Well, you just caught an issue with the errno by looking at the string,
> so maybe testing it is a good thing?
> 
> I'd expect anyone changing the string to run the test and catch the
> mismatch before sending a patch anyway.
> 
> I don't have a strong opinion about it, though. I can remove the
> error_str.

FWIW, I fixed the errno, so it should say
  file URI has bad offset 0x20M: EINVAL

- Steve

