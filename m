Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDCB7228DF
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 16:33:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6BFx-0001iq-FB; Mon, 05 Jun 2023 10:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1q6BFj-0001gA-NT
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 10:32:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1q6BFe-0002XK-3x
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 10:32:11 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 355BkiE5025103; Mon, 5 Jun 2023 14:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=qmw04lWtKpNNLoxcXTxDIQV/dG623QFG+7Cx5MoMiME=;
 b=kQOjTi58SZPMnCl1Bu3SLZf2XHOJTzrD/0fgtDZoBjUQuBVcYzG6QZ4qcBFSakVbFbw9
 zJDXb09eSGwZWR+clUIsEZmQi5bhQKg+MzM8ZA2+7chDnUqNhDNq66VIuYNrloaAq5wv
 dAStYjlI7gwVnMZmiG/hv6xcvDBdpnPraGBkziwiWYvoiBxL7VJLJicffM3q1RmZhFHA
 w6ftWBuL/dnsLhOs3wGwQVKaunfrhwDHaRuM08SV6dPkN+GuijhGc60V3k+cPlREMJHV
 o1izC52OZL7ON7m72/UJ7jOW2MywVihR/oqR1w0pGh7TBO/icrpeQ8mP98UaQMWbPD0Y wA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyx8s33r3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 05 Jun 2023 14:31:59 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 355E2pXx024175; Mon, 5 Jun 2023 14:31:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r0tkft8fx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 05 Jun 2023 14:31:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4JBtA7TaQGisFi/Fp/Y/nsNPOHwxDr7u9dKqiDHRPP54YZv3wLLN8JeGwq4xUYh/0Ps+LxJFx1xxXkVJ+kA5hSXaL7NpFmn+b0SmxMrFPN33+6lWWhyn63WmkmyTSlWnzxi2fP+3D240mE/JZ4Utw2gKI9I50+kHqs3HL19vQll+REU0/ZX/VeTMpoF8+T/qjZRQsBMdr3+d754jL7433nM84kdomD5Eud2u7cf7cquRrQ2RlIX3zc5PkR4XF2boj+XxgZcf8h1jp4zGntg4pZoQcbQzS3UejN83UhuuX0byjubJapsusz+Mzc1XqDn8S2lE3Hh+PxZn2NEZP2xdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmw04lWtKpNNLoxcXTxDIQV/dG623QFG+7Cx5MoMiME=;
 b=WFQRAvfWZLrZwyIBlzspcc7ei7+tO4Fj0RxshyNwlAlZQWiPtzcUiM9/bEEZwLQYqiIrrrIq4B5c2S+hucCOyMVuxFIy4pbP4MPqGXQPufkhRNTenWu/k2NwGa24az3uBtdqfZINtygG3cjcg6OqIQquUQrXODG6SiaZk8BYHbMQ+QgJwuan1Y5+xnBnWdI1587S4X4fy9Z/qCyjn3jCgxb60BLiF5wZpkORxKqstCXTw7G5+CBp8D6xsaIHyOSLjcFJ48+hH1PBjRdfWHgai35ypHE4j5knKw0WS/JTorcRGxVkFbQlsyN4oOrj0m3xgYg03+Ssa1pa+Vf00X4t/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmw04lWtKpNNLoxcXTxDIQV/dG623QFG+7Cx5MoMiME=;
 b=kZBoDfzVR1TFm2HZBkRBRcbpKyMmn9nT1R/fUXCCC9P2+I8u2/ePge0s5xe4vlB6vvclQChMvBZPK/02sRya5YPs5qjNGQ6KyNZXUQr/1RJ6WhUUxLdKRrQqFoRpmZw5Zybe6sJZBa/uJQQC5oRy9ZTiF65cxemU2lxRyrDwbGs=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 14:31:56 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::c230:6287:27c5:bdcd]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::c230:6287:27c5:bdcd%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 14:31:56 +0000
Content-Type: multipart/alternative;
 boundary="------------GAM0mwXfVArupd6LDBsmP145"
Message-ID: <98505298-7e84-53ae-7c6c-bd488f9d0e37@oracle.com>
Date: Mon, 5 Jun 2023 10:31:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 1/2] qmp: remove virtio_list, search QOM tree instead
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, laurent@vivier.eu,
 mst@redhat.com, boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 eduardo@habkost.net
References: <20230516192626.3521630-1-jonah.palmer@oracle.com>
 <ZGSMciocECtO0StI@redhat.com>
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <ZGSMciocECtO0StI@redhat.com>
X-ClientProxiedBy: BL0PR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:207:3c::43) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: af382b01-329c-4508-c8ec-08db65d19ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W6lFGdjgRGuS7KG5DV3t+duedGFYIYLGE84+1E9iHUA7/BTxirgnPAfPBjrIbOiuUMUHZ+gaeRbX+VbSWLXBPLsjkmEVJn6Uv8P0o6RmcFeViMvnd2Phj28eC2PU4EXgVzAPSQ0n7NcYgGzGEhFGIUhY0qIDiDaoKxogYYsi8k6J1cXE7XPac97cXv1xPS5CoES3i8TBfiyrC0vXYL9a1q17k7TnN6EtnE8ovVsGtcyAqSmiOswYI4ao891SrVvf+Njp827pVnP0/GrTgSoIpZApDigCymYu1ki1J4t2Meh3iFjgT7+DllA8HHXNrNvTXmABjT0kvx0e/LwFxVGV8QYE3MwTRY/RL3tt8Hsqrqe7aRrxsnW5tZ12/NqbnnqBf/92rMZGerMIxaXRkWuVnJALZAiHd7qMoWIovuSb1ReZjl7f7DA3OquTNc7979Ex6xrMZhaZ9DN3KBC00AAybbJD6elInUZ0QsDJY+F+KibMeV32o9C6LYyvfgw1MqYV5Sw/zfQ/2n+7+NIvQCQNJC9p96Q5ZsjbHs7nAZaD3EgGAdSjiT79GelrXK5QMpxVSu83IhqRRF3L2jn884ho2I/UznoKQ8HuY9fGFWuCuhj9l0+xqhwuTLLHUtCtGT4sgs9DlKBY98jgjeWdtE5IqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(2906002)(2616005)(36756003)(86362001)(31696002)(38100700002)(6486002)(316002)(33964004)(41300700001)(6666004)(5660300002)(8936002)(8676002)(478600001)(66556008)(66946007)(66476007)(6916009)(4326008)(31686004)(6506007)(53546011)(6512007)(26005)(186003)(7416002)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFFmVEpzSjRkOXR4Wm80S2lvWlBOTVZVUDQzMHZoSmN3OHY1azZvci82amU3?=
 =?utf-8?B?VHlKckNMZjBmbzNNU2IvVFpNaUpNTnBrVUYwbjdhRTdVTHFyMzB5amZlZENX?=
 =?utf-8?B?RVVQaDJRSGhQZlZGajg3OENidDVoRG9CRHp0dzQxQXM1cVlGL2FMenl5LzFu?=
 =?utf-8?B?Mk5MRkJhNnZjTFJ3Z3Rqbnk5S1VMZ01aSkdDaXYxNmhjWmozVjcvNXJRVTRL?=
 =?utf-8?B?S250NEN1NW42anJBYzFJKzdZWWxnazdkNHc3QWxYYXZzUy9MUEFuc1VIV0ZH?=
 =?utf-8?B?bThGVDlJa3hTTGF3YnB0akdwQlpFd2hrUTJLNGNUaEhCUHZ4WWVWVWlMd2E0?=
 =?utf-8?B?em44K3FYaENFQlJMR082K2FKa2ZDcTZ6aCtMcG5ITng1dEwvU0IzN1dFYjlw?=
 =?utf-8?B?Y0RwaEZVTitMdlJFTFJqZDF4NFhaaHZ1ME1aZTlHK1dPaXQ5akpyL0NkaVZQ?=
 =?utf-8?B?NFI5c2RVOEtUZmIxRHlSamFlVjBjN2hDcjBrTGZ0dkhrRWtZbG1nRXVwbk1j?=
 =?utf-8?B?OTlVc1lDVDc5UjV4SVFDakc3cE81b0loWnM0TFdvTHY3b0RKc2FISEozTXlz?=
 =?utf-8?B?NXg0VjBuRno4dkN5QXN0d0FidWR4T2dpWFRoajJyY3l3MHlaZGl2Q2ZLbElw?=
 =?utf-8?B?YVhHUnBtQWtiaTljZk1HRE5Wd1RHWXYwVkJRTFZZVFJ5dUIrYjVKOGR5Mk00?=
 =?utf-8?B?VStORTM4U2pjV3MzbzNHSCtPWnFIYlZsZlB1YzhySFpXbTNpVmovbTkyVXVC?=
 =?utf-8?B?Q1hmeWlUMWxzZEdrcTZRay94ZW5jV3Y0RzVpRXlkbE9kZWlYRnRoSG1FMm93?=
 =?utf-8?B?bk5WSDkyT0x6azM2eHo3ZXdGekZpb1pleWVVT1hSWU8xTDh5TjNvRmo2MTZV?=
 =?utf-8?B?U1hwZ2tBL3pVTTBKclpDSE1SRHNORU0rSytyMGUvcmJ4bU14WW42WnJoOEI3?=
 =?utf-8?B?clVMSUdKaTNaa1pvbHhBZkVJSlZLbzgvNWFsRlpDVWUwaTJLdStwWVJweVZS?=
 =?utf-8?B?NGxQVHU2MEkzTnY1cTNqcEt0TUdBUXZyWU1mVVZHbWtMMml6aW5yUE41VEVN?=
 =?utf-8?B?dDhZTEkrOS9PN2JnZGQ0UFRGUXNUN3UxbERocmFBTE9ncTdud0RPSmJxaUhU?=
 =?utf-8?B?RHhBZmhmMWwvS281N1UwQTkzbnFLKzllcnZhYnZEU0lhRDlLVGlGQ2V1U1NX?=
 =?utf-8?B?OEoyR3kzM1hQVWFza1pqZi9laTAvY1Q5YzE4T0pKMzRLbzcrT1ovcmp2bnpW?=
 =?utf-8?B?amdFVDRjUXg2ZkM5RThhVWg5TzVYVkRPMkUwQVpzK0R5bTdpNWN1VFVUUjUx?=
 =?utf-8?B?RVgvREdCWDIwclFqUnQ3RHRUTTlLVVZ1WjdLTk9oSmkzS0txeTA1RXZ1bDh5?=
 =?utf-8?B?cVU1RHd5QVZjNVpRVEdIb3p4dmM0RElxZk45QVdhTkExK3h1NWh2RS9uYnpL?=
 =?utf-8?B?aDZLV1c5Znlza3VXaFpwMnNkZDdYVXNRSTZuRlhhL0R6MUY0Y3p3aUhYNE9J?=
 =?utf-8?B?bEU4QTZHaHVWbmkzd1ZkQ2RvQ0krbTd5Ni9weEw3MlBVVTJGZXNCNXNCTzhx?=
 =?utf-8?B?TXpoNjd6WWFvR0Y2WTh4SkdPbG9EQnpENDViak1hcVhrQi9lc0VnWVBNdzlh?=
 =?utf-8?B?dkRLUUdRMTZ0dnl0ektxTjhqdE9tY215Vkl5ZEtWeEZFdW1CTkdsQjdmODNK?=
 =?utf-8?B?QkdaUUg2eTc3NXBNWmJtOTBsZWxlQXNNQmtRK2h1WFZSdU5PT2x6WmE3OXVN?=
 =?utf-8?B?OUE3YXpnVXhoOUN1OTRFYmtKc1ZiS2NIZkp0OFIwMXJ3cVFmZXZNazE1VzRC?=
 =?utf-8?B?UXBLZEc3NUhwRHdlMzdGeTZDVmlnSGRvMk1yZUp6RkpmK1BQRE16bnNzSlFx?=
 =?utf-8?B?ZEpuV0ZRUmdxWnI0Q3dRbndTQmRuNkxNZHYvRVVXRWcyUmJWOEZjczhud0Nu?=
 =?utf-8?B?SWlEcUh2UG9qSEdHTFhjWXgzVzREOVZFNWRMOXRsby9HeE5jN3lDVHBmRkJP?=
 =?utf-8?B?R291SGJJLytkS001bWZlSnFYN2J6NCtpaWlKcmJaYUh4OWlNNnB4T2JiY25U?=
 =?utf-8?B?RnlKL00wTnNnOXM2cnBCV0NJM3JyTkNIbWlDZXhBVlpmRWdNbHlDQzVvU0Np?=
 =?utf-8?Q?kVNyaW+ktyZUDSt0XLiKmKin/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0o16kYjlpmSwBkO6MpnBl/7QgwzfLRRvpCo1KJHBGougdqVyUGoJ2jGMnM1+V+f0e1tzcpftlLQ+nvwiqha+/JcG8ly1NkHzOPhUrPZRswlA0eqawBFb66q2q2ccMwo4RHxj72LOgbpAOZ4y8wxm0EnBM8Ygi3SsrKSnZWTBladyc+aRnMl3A9abQBqcMJoyTGT32m8gUlY45nfHcel15UEVuN7U9vty2eiMkWGCM6QWKkZOakTVhCcz8N5IuGi+VT920zMm7THiw8+eVW0uPsR/xtuDTC7DCeP0Zvg2l0p0PwnoVKP7eOsGrJikmzv2+NeSDWveqt+jkcILFZbM91FD2NXuQt8zoHzwByaFMwELE1ma7/JQ3BoifTuTN2xyciPW6yrqC0idRh6vB+hkyzX6AV0y3emmpoUK5TtLPV34obTvDoh2gGGaa8gbCvpOUvt0XhYDZCwooWwW8jtPWvztOXq9SxbgVh5zAmu3jj312+aMHXh9lgriWCldEKsXDsd6cHjQl/hddAznr0DXEhQOkCcizj+pEYf4wBJCjgR8KgW+fxlSWaVhmQquOcp8Q3jLt/ffFHGMqGa1vkOMWuZosQuVDPFnqZLExx8p+Nk8n+LbC/Ivr9QsS+Ax8VabuBooA+XhFCGEKK5D1se8E5DfTjUTiXb+El5KBy4/6W3GteP/i5NlauAxfVZvwvgctj8B4ZiQSTzmD3PEZMHig0TDyhM9Z5poCJtDuHOFt6nrnsemnKvepWN7zWbcRaP95GLnPwXpeeMOh4wMhw6vTiiDaJq9zBYmdcT5C2bxr5/dYQ7H6aHrvAkwewzeLzdItuK+YXN74qSV/udf4WJ510sMIRrtmjTt2RSjvbGQdaI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af382b01-329c-4508-c8ec-08db65d19ced
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 14:31:56.0667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1lxXjZZav4VrWMmeJIll/iEhdW5trc7uU03oGhwpc6f4QH8+c7G7Fzfi2otX8RMAHqTg9LZHdtwG1LIqGGG5Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_28,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=869 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050125
X-Proofpoint-ORIG-GUID: pckKa66sF40Zz7BuhF-uIePR52bO9_t2
X-Proofpoint-GUID: pckKa66sF40Zz7BuhF-uIePR52bO9_t2
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--------------GAM0mwXfVArupd6LDBsmP145
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/17/23 04:12, Daniel P. Berrangé wrote:
> On Tue, May 16, 2023 at 03:26:25PM -0400, Jonah Palmer wrote:
>> The virtio_list duplicates information about virtio devices that already
>> exist in the QOM composition tree. Instead of creating this list of
>> realized virtio devices, search the QOM composition tree instead.
>>
>> This patch modifies the QMP command qmp_x_query_virtio to instead search
>> the partial paths of '/machine/peripheral/' &
>> '/machine/peripheral-anon/' in the QOM composition tree for virtio
>> devices.
>>
>> A device is found to be a valid virtio device if (1) it has a canonical
>> path ending with 'virtio-backend' and (2) the device has been realized.
> Checking the path suffix feels pretty undesirable to me when we could
> be doing a QOM class check
>
>     if (object_dynamic_cast(obj, TYPE_VIRTIO_DEVICE))
>       ...
>
>
> With regards,
> Daniel

Ah, yes, you're right. This is a much better solution. I will do this instead
of the hacky string manipulation (which also felt undesirable to me).


Jonah

--------------GAM0mwXfVArupd6LDBsmP145
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/17/23 04:12, Daniel P. Berrangé
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ZGSMciocECtO0StI@redhat.com">
      <pre class="moz-quote-pre" wrap="">On Tue, May 16, 2023 at 03:26:25PM -0400, Jonah Palmer wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">The virtio_list duplicates information about virtio devices that already
exist in the QOM composition tree. Instead of creating this list of
realized virtio devices, search the QOM composition tree instead.

This patch modifies the QMP command qmp_x_query_virtio to instead search
the partial paths of '/machine/peripheral/' &amp;
'/machine/peripheral-anon/' in the QOM composition tree for virtio
devices.

A device is found to be a valid virtio device if (1) it has a canonical
path ending with 'virtio-backend' and (2) the device has been realized.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Checking the path suffix feels pretty undesirable to me when we could
be doing a QOM class check

   if (object_dynamic_cast(obj, TYPE_VIRTIO_DEVICE))
     ...


With regards,
Daniel</pre>
    </blockquote>
    <pre>Ah, yes, you're right. This is a much better solution. I will do this instead
of the hacky string manipulation (which also felt undesirable to me).


Jonah
</pre>
    <blockquote type="cite" cite="mid:ZGSMciocECtO0StI@redhat.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------GAM0mwXfVArupd6LDBsmP145--

