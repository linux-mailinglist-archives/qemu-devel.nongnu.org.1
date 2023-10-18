Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACC97CDDA6
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:43:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6oT-0006Yb-3V; Wed, 18 Oct 2023 09:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qt6oN-0006Sc-9w
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:42:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qt6oC-0006pT-OK
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:42:03 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39ICwwlM005022; Wed, 18 Oct 2023 13:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=qzaHJeTETlUsJdtDpJ60sJXNZRqU1PY4jqAR07tl9tI=;
 b=BgdUmGM8tnBUVPhkYwCCzUoW7BWZFT9WzNyMZUhOUsOyfBPFdj/qpv5e34eAp0gRmkea
 QfYyQwUFRGnEB9I3N3crKTlcXPE5P4fEeQk3OfTEgkB8brvChx6gm5AiIG8U8XaYgj1f
 QaLvIt9yV8db3UQ7KL3YFJWRoEGnFkVallmT3RylTT1D5920JwE6uxD1csEAGNALYrJ8
 SPfXaW9DZwiQR1/2gNHD5Dh5DKPd9jLFojnLOVb2c7sbawChvuvNT8zQPcw5RRs1kQlz
 MF04zGcYSo4LJaCKtfBdoR4vtD9oSwDo9em0qz8aQX98yiVXKUCAh9Y5eNB0H76r7QlR rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjynfk5f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Oct 2023 13:41:59 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39IDYWuI027127; Wed, 18 Oct 2023 13:41:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3trg55an5f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Oct 2023 13:41:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdHuvqAgoJg4XHGTz4wwsqi7E1i9eRgsUkWehUyxTu+YhVtl/0PI4Pwir3OGPjpopo67toeOXX2yZdpbjeGWLiRjd0UljfdWQF1bGdBWb3aTL2qy7eTnFyiZYygUqt7pv0uD9j+rdxWqNWAHy6QeeWYHu5e1vWxdW9TE/VWbPkUgQ+BJxlH1JNJCl39gHeDJzz/XJ0saSrmQSrW4GrKROrAt4cWGY2C8Af7hvx4phKCZcToIW162YkwJW1eV7K3R4Vr1FqSYjLr3j1nKouTO+KCYyi5Vl+XjqHi8vQSJXUgyxqHwRqzGuNWwAWzvPwZPjviAAa1+tY8bucJ9WxI5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzaHJeTETlUsJdtDpJ60sJXNZRqU1PY4jqAR07tl9tI=;
 b=hj4ah1Rrr+WrO0EvyITS3VGCzEGc1PaxwjFBTKxiKD+v7DaJRAw3n9JQxDrtJ1QNr6YcnDLWxhkg3VIGUFmJjsKXeIrC+ElFarA1B8nhF6gx9uaBFPGec3gtvBeH5ZcY9QAmI8Y0SC7LDYxJhZqOjghyGdkibTjzD5qspt8cq7nTDFV12hPCbYsUitt1tPtGnumhl7hogTotVJhzkwHFSV5dBFNOEiSzDGfeajQSYqPb+EYUVdgqJFg3byb2BoS2g0LeKLYz8CLyfT5My4c24WKAPdudjG50c2QxaynHcoi9bfEsKmImBhM/f9nYwnXAtcwnPNVVXCqoL0EvwScdsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzaHJeTETlUsJdtDpJ60sJXNZRqU1PY4jqAR07tl9tI=;
 b=vn9R9y/te2x2RTN9+gRjQtQM1IbSuhqI15oowvTCvjS/2E8AoyfAjH+N1OQcsJ800D0OXzhmjbbnIy63DMrHtTKGWi3F/2/IlqNSAv/Wm54UPHMlGddSQ/SD9irxAThBy/fPPkdaaGrVlOIzOMdMP9vkjNnCQEliMrfAHX5W9Rc=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by MW5PR10MB5737.namprd10.prod.outlook.com (2603:10b6:303:190::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Wed, 18 Oct
 2023 13:41:53 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::f630:6779:7c5c:fa65]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::f630:6779:7c5c:fa65%7]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 13:41:53 +0000
Message-ID: <dfdf3ca8-eab5-414b-9ed1-e4781d64e7cd@oracle.com>
Date: Wed, 18 Oct 2023 09:41:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] migration: simplify notifiers
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1697636430-87083-1-git-send-email-steven.sistare@oracle.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1697636430-87083-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0003.namprd21.prod.outlook.com
 (2603:10b6:805:106::13) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|MW5PR10MB5737:EE_
X-MS-Office365-Filtering-Correlation-Id: a066b250-89bd-4c2c-4ace-08dbcfdffd07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DFCoiG/GncwdlQYRa9hgN/BdX0pmOdo5G4ZGfqOOeQA7qRhve56f4tWmrnn7JT191qN4dOPull0laM82VSK6Q2OreLfD+OxiPCM1OEpIMM/TnQtdQ1R0QoYlCJc3JEkNBOyJuJYGaDt5BMSebAPTRhd4egD+yJE3soQ63dCzXl9eHF/vmc7UZojOJan1LAm5/M3hhDgl2ND2uGQdwCbok/O+NHox4Eut+Xh09Vmw3aa8rN7AblGYCSHkn1hureI8H9865ELWIDPcJAuTxLiLGBNwbRJ8fPCL/C/Xa+BSTrheWusDJSTZJWCZ4/aVo4AkQY8I3YfF6kqtDlnm7Tx3V50S/63Ztj0UnaXz7ym4vXliPX9T5hHD8Top9/XQRLqRAqzLVTB8zkH1fJcZhJkUBP+ZYOoQ24on8boZVRAjxhHtaFE6iuPkf9NvNtC6e6qccUXxPxIFMz+DYeNUAybeM/IBl8QxH+nuH6aoYYeF8PE1oRKejqXPV/qQrprern50Q5FccW3+OSomLS2iSpt9LM8/LyC5DXmLZwpKBpP5d4mxDnU2k6I6TF9mzNTRXyyae5NHIvu9N73erO4AfvEt/rf2dBy3HtbXScmGDT5ZR7tr5vN7T16MlT3UiCJLdWVjJ0OkxoCt/eLV+xb7m/KkSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(39860400002)(366004)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31696002)(86362001)(36756003)(44832011)(8936002)(41300700001)(4326008)(66946007)(83380400001)(66476007)(54906003)(5660300002)(2616005)(66556008)(2906002)(8676002)(316002)(6512007)(6666004)(26005)(6506007)(31686004)(36916002)(53546011)(478600001)(6486002)(6916009)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDQzSk9ub29VMlgyd3ljdFJBYzNxS3hNYXdKQTJ3RkZ1eS8zSVRKN21LL3FG?=
 =?utf-8?B?alA0ZUE5czBjQmFHWVJ0R0tKbnR4MmlxZWhvazlIZ0UvOXV5UVdUWFoybjJZ?=
 =?utf-8?B?Q0NiUEpNOEpOa1NvSTlYOTU3aVNtUkNmOTBPekt2Z3NGejBJbTNtRG5kbzRw?=
 =?utf-8?B?V2IxNk5RcWpsRklxMVd1WkVEMlZabzZwRTl3cWVOQlhEUVcrdE9GZ2I0cHRi?=
 =?utf-8?B?a01VZkxsYW5qNkkwSXBHK0lOckppNkg2M3NuNDVWK2VneE04VFVGL1hUQTA1?=
 =?utf-8?B?NmZYL1lrS2crbUsrQ2YrZkdJa2VrVHBoc0lDOTNxR2JlZ051WG9aRUhYaFRZ?=
 =?utf-8?B?a1M4cC9WdjJZMERJQlJHaFMydzR6YlBXMFBZT3VWcW5qakhtaUVHS0RrZDIw?=
 =?utf-8?B?VmVHbEN6aXZlS1c1eVhTYUtJMEhpWnYvNXJKL2ZXT1c2UXU3NUZZS1g4Zm9B?=
 =?utf-8?B?NXlGL3dhVVRaejBhWVJiWlFuREVVaTVPVm1SRkxKSHUycDhITEx6eHNUTjZX?=
 =?utf-8?B?TXVHQmVYUUlKdTlUamxEeWJlTjdjVXo2RjdYbWJ2aTUrc0daSGNVWmxpODZW?=
 =?utf-8?B?QktSVDBwZ21RQmpRN2tMZjdEN05MS2x6Q3JjOXpic0Vxc2Jldit3ait6U1dW?=
 =?utf-8?B?WUI1MzcvRjlRK0xaMDlhNkxNRnk5RU9rZDJBK1hyTllMQmxYSmZ6SDQvOGhY?=
 =?utf-8?B?czNZdUgxenl3Z3NqUzFidSs3ZGlrTWJkNlBmNmlkMDQwUSt6TjAxVjY2ZDhr?=
 =?utf-8?B?SExEN3VjaTdpVlZ0SlN4MkhWcnRHM0VMcVhMN1RSdzRhVHN5WFJCSGpJbHB4?=
 =?utf-8?B?YTdqckV6SkJUb2VudS9LYWc4dTZHUlczV1U3L3RlWUJudzlmcXJYSW5CbDB0?=
 =?utf-8?B?bmFmYnordUJVSDdRZ3FzaVhxUi9aMnVGdS9lSlRNNk81QS9tOFoyV3pLUGR3?=
 =?utf-8?B?dHhBQnhJL1dQQzI5Slg3N0hxOW1JL1NYV1BJcXhpM1RQeElGK2d4cGtLNXFQ?=
 =?utf-8?B?QlptL2txRmNaaTRDL243dWVNRW9oQmk0VEFFNm50T1FhU3JnSkJJVUZDS0o1?=
 =?utf-8?B?blhDdTZFZkNLVUdMdVFhVk15WnlKYWtQekZPZ3RwNkxZOGZ6YkdKZU55UGhR?=
 =?utf-8?B?YUNTWCtuakFIbzlZQk1MdVMzc2RFTWhZVkhqbTk0QzB4aFRobmlHWnZhM2V2?=
 =?utf-8?B?L2xYYjRSQlh2MTRQeWZFc1B2UkViTEhjeFZBdVR5Ty83NWdxdDJiWXNrdktV?=
 =?utf-8?B?R3V4ck1ZZ2NxQWg4dUZkWXVWd1JVekdUN0VRdjZKWXZ5Zm10VzMwenB6Mk9P?=
 =?utf-8?B?RXViODFZbXgwY0dtY0ZlWk94N1h1b2RIZk1rc0Q3dnVseXNQdW1nRkVUdUwy?=
 =?utf-8?B?bXZhSEU0OFpHVmdoZmMrQUpsTUVIWmY0cC9TeEgwYXZRU2MyOGpXbXdaRCti?=
 =?utf-8?B?N05JemM5TVZPU2sxOVBzVkxCZnhKdnRxNDNKeDFJaXA4eHp2dkJVejdtd0pV?=
 =?utf-8?B?bEtTRzE4SW41bmhEaGdnbVlla0pQYWFIUjBKVHVlU0dDeGNIeGdiSUEvTTBv?=
 =?utf-8?B?WkRIcDRZMFhsaFFRelhRdlVWNTdGU3hrUjE4NVNNMlpzamgzVStwYlBPdTVj?=
 =?utf-8?B?NlhYVzEzazNmVnY5RWVPTEFSWXppN0ZnUG1uQUUyTVFvS0JnaEwzNVpyQ0g2?=
 =?utf-8?B?aTRHNHBTTm1CTTZ4R2Vmdy9haTBFRjhGSUVXSmpheFhOMjZuZWJzOWFzWit5?=
 =?utf-8?B?d1QzWVhJbFFXTTVueVp1NFIvL1BVK3FSQTA1RE1sSEpRM0laMHpOcnFoOThV?=
 =?utf-8?B?aVRwVnpOcVZYbExlbWdBb3hqcDlPRldRSXptenlSb1Q0dGJFenpXTWc5SUo5?=
 =?utf-8?B?UHB6NU1yTEN3K0pJbE40a1RuU1NqdXlOMVhHRHB5UDRzWnMvV3FDT3JpVkRF?=
 =?utf-8?B?Ym5mVEpVb2RxYml5TXU3ajdRZGw2b0FlZmRxajhQamQ1RnhyUUZKVnYxNUhv?=
 =?utf-8?B?SXhodXI3ODZGWnI5ajRkbmxaQnRUakFxeHhoTEl1YVdnV25LNmlwYm9rYmNY?=
 =?utf-8?B?L3lyVUcyTVo0S2dYaGwvTjRwWTZseTFiV3lTc3lwdlFuenpUKzJRK3NaMW5n?=
 =?utf-8?B?eHVuZnFNQVVJdm9DWGxQZE9EdXlFR2RiUTB3WmkwbGxnd1F4S0ozN2gzeHRm?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2p8AdOiGH7ft+oOLGgBZVmOuv6+aGNsPe4OvhOfJq7K/fna+fYySdVqQyaDKoKB3f5xW748N3iZiyM9Pa52tJMoMMxvMBYOAe+k06CvpNekqWEpXbXIdZrL/pDsAT8lqve+5HIaRhZisC5Uaq5IpOXC29m85jzJXJVTiyTGnWP93LT3dT4G+zrBLQYaimVPxHuft5yxKntApwgGC16omps14IDO5uod5tVIXxT+hgef7yTEVCnoFyNLpiHDr6JQ0WSgyraePt1Nv7CnroreruvELMP1EstSLMlkQ4/RGN8TNdDaxmMtlkojXAGSR6WL/bqbpfNtDRWZ1MKxZb5N4DcbkcuVFW6E7nVl3HFlExbggtlXYevXrqKbYsOopX1wic/3xeEHdVt3ZZjbcug7Yf85lFr09cEa/BiAAvjqL0W28F6/v3xQ86e565eu5qX8McTVic4AfNmWat33iI2lrCbcJ10d7uQmjUMechFzubM1BxTqUQWS3MoSRZdqaZFUWRFMWYybssNjSjev1RDyY3jAObIesA33jz8qa9ggQTWHugOC6QVIZJuGivP6Unzbz3+c0QC8ORe9pTGIAGE5RjoTIwv4lSUycrs63RF93gXwFgIL5m/Y1dvjd4jdhrsr4449G1gGvTdt66CAVoC2Af29Rgf12kugUTMxz2xzdy07I78CfTGItswS6vM9FdlIUXXQFMP0Ucb6VMfLJHtBmiUDqQfCofx3rPpMA6ut6+9LC5ggRxES/sy4Yk+qSCx8r9tXJEvEDQJHaWl4jSesxeK4eJM9DpGvDZinNweoGaRA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a066b250-89bd-4c2c-4ace-08dbcfdffd07
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 13:41:53.3875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3BAnOuejt2P2JwcQ3N7ZYKq7q/mDesBIdL+mQS0XawdASA+V+Cd03bwuXc0F4V1tyYbv2VeSY8/xEFO0mqYFSb2+Z4KEULDFekF4fGgsKko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5737
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_12,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180114
X-Proofpoint-GUID: jSIyKkb-9BFY2giP-K_cjOEaTcTYzAig
X-Proofpoint-ORIG-GUID: jSIyKkb-9BFY2giP-K_cjOEaTcTYzAig
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I rebased the V3 patch and added the new maintainers and reviewers.
Peter has already reviewed it.

- Steve

On 10/18/2023 9:40 AM, Steve Sistare wrote:
> Pass the callback function to add_migration_state_change_notifier so
> that migration can initialize the notifier on add and clear it on
> delete, which simplifies the call sites.  Shorten the function names
> so the extra arg can be added more legibly.  Hide the global notifier
> list in a new function migration_call_notifiers, and make it externally
> visible so future live update code can call it.
> 
> No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Tested-by: Michael Galaxy <mgalaxy@akamai.com>
> Reviewed-by: Michael Galaxy <mgalaxy@akamai.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/net/virtio-net.c      |  6 +++---
>  hw/vfio/migration.c      |  6 +++---
>  include/migration/misc.h |  6 ++++--
>  migration/migration.c    | 22 ++++++++++++++++------
>  net/vhost-vdpa.c         |  7 ++++---
>  ui/spice-core.c          |  3 +--
>  6 files changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 29e33ea..b85c794 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3624,8 +3624,8 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>          n->primary_listener.hide_device = failover_hide_primary_device;
>          qatomic_set(&n->failover_primary_hidden, true);
>          device_listener_register(&n->primary_listener);
> -        n->migration_state.notify = virtio_net_migration_state_notifier;
> -        add_migration_state_change_notifier(&n->migration_state);
> +        migration_add_notifier(&n->migration_state,
> +                               virtio_net_migration_state_notifier);
>          n->host_features |= (1ULL << VIRTIO_NET_F_STANDBY);
>      }
>  
> @@ -3788,7 +3788,7 @@ static void virtio_net_device_unrealize(DeviceState *dev)
>      if (n->failover) {
>          qobject_unref(n->primary_opts);
>          device_listener_unregister(&n->primary_listener);
> -        remove_migration_state_change_notifier(&n->migration_state);
> +        migration_remove_notifier(&n->migration_state);
>      } else {
>          assert(n->primary_opts == NULL);
>      }
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 0aaad65..28d422b 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -872,8 +872,8 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>                       NULL;
>      migration->vm_state = qdev_add_vm_change_state_handler_full(
>          vbasedev->dev, vfio_vmstate_change, prepare_cb, vbasedev);
> -    migration->migration_state.notify = vfio_migration_state_notifier;
> -    add_migration_state_change_notifier(&migration->migration_state);
> +    migration_add_notifier(&migration->migration_state,
> +                           vfio_migration_state_notifier);
>  
>      return 0;
>  }
> @@ -882,7 +882,7 @@ static void vfio_migration_deinit(VFIODevice *vbasedev)
>  {
>      VFIOMigration *migration = vbasedev->migration;
>  
> -    remove_migration_state_change_notifier(&migration->migration_state);
> +    migration_remove_notifier(&migration->migration_state);
>      qemu_del_vm_change_state_handler(migration->vm_state);
>      unregister_savevm(VMSTATE_IF(vbasedev->dev), "vfio", vbasedev);
>      vfio_migration_free(vbasedev);
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 7dcc0b5..673ac49 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -60,8 +60,10 @@ void migration_object_init(void);
>  void migration_shutdown(void);
>  bool migration_is_idle(void);
>  bool migration_is_active(MigrationState *);
> -void add_migration_state_change_notifier(Notifier *notify);
> -void remove_migration_state_change_notifier(Notifier *notify);
> +void migration_add_notifier(Notifier *notify,
> +                            void (*func)(Notifier *notifier, void *data));
> +void migration_remove_notifier(Notifier *notify);
> +void migration_call_notifiers(MigrationState *s);
>  bool migration_in_setup(MigrationState *);
>  bool migration_has_finished(MigrationState *);
>  bool migration_has_failed(MigrationState *);
> diff --git a/migration/migration.c b/migration/migration.c
> index 65f9791..29a69bf 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1204,7 +1204,7 @@ static void migrate_fd_cleanup(MigrationState *s)
>          /* It is used on info migrate.  We can't free it */
>          error_report_err(error_copy(s->error));
>      }
> -    notifier_list_notify(&migration_state_notifiers, s);
> +    migration_call_notifiers(s);
>      block_cleanup_parameters();
>      yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>  }
> @@ -1308,14 +1308,24 @@ static void migrate_fd_cancel(MigrationState *s)
>      }
>  }
>  
> -void add_migration_state_change_notifier(Notifier *notify)
> +void migration_add_notifier(Notifier *notify,
> +                            void (*func)(Notifier *notifier, void *data))
>  {
> +    notify->notify = func;
>      notifier_list_add(&migration_state_notifiers, notify);
>  }
>  
> -void remove_migration_state_change_notifier(Notifier *notify)
> +void migration_remove_notifier(Notifier *notify)
>  {
> -    notifier_remove(notify);
> +    if (notify->notify) {
> +        notifier_remove(notify);
> +        notify->notify = NULL;
> +    }
> +}
> +
> +void migration_call_notifiers(MigrationState *s)
> +{
> +    notifier_list_notify(&migration_state_notifiers, s);
>  }
>  
>  bool migration_in_setup(MigrationState *s)
> @@ -2231,7 +2241,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>       * spice needs to trigger a transition now
>       */
>      ms->postcopy_after_devices = true;
> -    notifier_list_notify(&migration_state_notifiers, ms);
> +    migration_call_notifiers(ms);
>  
>      ms->downtime =  qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - time_at_stop;
>  
> @@ -3265,7 +3275,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>          rate_limit = migrate_max_bandwidth();
>  
>          /* Notify before starting migration thread */
> -        notifier_list_notify(&migration_state_notifiers, s);
> +        migration_call_notifiers(s);
>      }
>  
>      migration_rate_set(rate_limit);
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 939c984..0f2e6fc 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -339,7 +339,8 @@ static void vhost_vdpa_net_data_start_first(VhostVDPAState *s)
>  {
>      struct vhost_vdpa *v = &s->vhost_vdpa;
>  
> -    add_migration_state_change_notifier(&s->migration_state);
> +    migration_add_notifier(&s->migration_state,
> +                           vdpa_net_migration_state_notifier);
>      if (v->shadow_vqs_enabled) {
>          v->iova_tree = vhost_iova_tree_new(v->iova_range.first,
>                                             v->iova_range.last);
> @@ -399,7 +400,7 @@ static void vhost_vdpa_net_client_stop(NetClientState *nc)
>      assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
>  
>      if (s->vhost_vdpa.index == 0) {
> -        remove_migration_state_change_notifier(&s->migration_state);
> +        migration_remove_notifier(&s->migration_state);
>      }
>  
>      dev = s->vhost_vdpa.dev;
> @@ -1456,7 +1457,7 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
>      s->vhost_vdpa.device_fd = vdpa_device_fd;
>      s->vhost_vdpa.index = queue_pair_index;
>      s->always_svq = svq;
> -    s->migration_state.notify = vdpa_net_migration_state_notifier;
> +    s->migration_state.notify = NULL;
>      s->vhost_vdpa.shadow_vqs_enabled = svq;
>      s->vhost_vdpa.iova_range = iova_range;
>      s->vhost_vdpa.shadow_data = svq;
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index 52a5938..db21db2 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -821,8 +821,7 @@ static void qemu_spice_init(void)
>      };
>      using_spice = 1;
>  
> -    migration_state.notify = migration_state_notifier;
> -    add_migration_state_change_notifier(&migration_state);
> +    migration_add_notifier(&migration_state, migration_state_notifier);
>      spice_migrate.base.sif = &migrate_interface.base;
>      qemu_spice.add_interface(&spice_migrate.base);
>  

