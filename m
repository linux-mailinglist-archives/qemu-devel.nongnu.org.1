Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E96297CD156
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 02:34:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsuUi-0000jc-W9; Tue, 17 Oct 2023 20:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qsuUg-0000dr-EO
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 20:33:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qsuUQ-0000pV-Vk
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 20:33:02 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39HJxIhs018419; Wed, 18 Oct 2023 00:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=KNpTv7BBg0iIrcVuPxwex8zaskB5IhCVCd6s4Aju5EU=;
 b=OcD/PKOG1bZ2gkukcAlGR+niv+nqA9VZ5b6nro3aAoPha80oBl6gFOC48VewztraYRst
 vediqh9bKOe4Mzy/vB0sZDK/xIzqYcXZec5sUrwl4hQOveQuq2uN5NVjfWijh42Pem7S
 hQfI6G1H6FgnQmXt16Wy0DuI9ApOoeiXo2RftGSguiDlZJaPY594b+bv7I5s6HdHABXM
 HXheMIx8hrRZIk6r+E0ODaGiRRdxJYr0x14pUdj43KVkip34Zk/V6AJEbsNfTrj9yMyY
 uAToxkFJgcF+UnUn5azbobalBX2L1f4vNId1T5NX0yOrYRgOSIsphqk5udeL+I1AweSK nQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqkhu6f7c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Oct 2023 00:32:41 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39HM0bgp040573; Wed, 18 Oct 2023 00:32:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3trfyn2erx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Oct 2023 00:32:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqh8L88j3xIf036GWJmSvz92PIGekTV4fvJFM2IWJCep8p1xZI4vwjWrmdTDtndF64Y40wNHxcPzyRVHGfMmABTdQfwwbA7YPb9bw7/t4xSMvZiPGziM4TrcDuxhmSsJN0oIVf6r/RHK2pB9vCV6m2dezyKf5z2RarNsD1k2tE7D4HouZ5HhxOLP+y0/U0OGUO12P+Xty1y0aLAHPs0Uou4FGqNNkrMA35LyCdBzX6J7ILhiIBdqs1qL3voDJtrjmRHRPthR4P1xUtBh20Pr5eKu7j1wy4OpYR04aMg+tJu7nrVOFAderN5mRI5l+o+pOylmgHrCRzBr2HjEboMFMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNpTv7BBg0iIrcVuPxwex8zaskB5IhCVCd6s4Aju5EU=;
 b=fGEy6PcgBhf9DB5QeiZjjBNyNVQ6hJbKzVaoJNphqrhz/i+82x/YgM+6Cx02e3UU4p1fi/bDcyp/WN/sM2DarpjpqLAMb9EmePfdqBWDYioBE1ySDDF3/8bWLJN8yuBnPhVIEBaXygqi6V1bpJwey3w4L+cb57u2IfhOQC5fSPZTsu5TGQnE2xPzbNj3LipqB8OmWmxCQElP4YTzU4SVG9yIbmHmVVmJNYhWwXxXqNSmZMzOjRBWb08CxmPBiTVZvzXDrGWncbPmB0lQOJbgegIJMHikxSPbb+1sO8yLsL/OQ+AQqtiQTsf4MjzTI91GAvIw3ehUL/4wL9+PVdoGMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNpTv7BBg0iIrcVuPxwex8zaskB5IhCVCd6s4Aju5EU=;
 b=LBmcY/9kQBBamWRyXkIDwL+dBKO8AhxcN7oDADYMolr7xpcrZYiWBvizzGqEAqaE339d0N3LzJalpZ8fYCbljVjT3GONB/9k99yDBWW+H+PeUrG9droCF0TdEsXJ045a1+qwRMMmoFNgU951HcgN4QlE+yRbWjg5ffy5U82Fsos=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CO1PR10MB4451.namprd10.prod.outlook.com (2603:10b6:303:96::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 00:32:38 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 00:32:37 +0000
Message-ID: <454ea1c5-7e77-41b5-b6e6-88efb6c437a3@oracle.com>
Date: Tue, 17 Oct 2023 17:32:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost: Perform memory section dirty scans once per
 iteration
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20230927111428.15982-1-joao.m.martins@oracle.com>
 <20231003095019-mutt-send-email-mst@kernel.org>
 <6e40003d-d2a6-4120-aa78-de26de088d86@oracle.com>
 <20231006054342-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231006054342-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0109.namprd12.prod.outlook.com
 (2603:10b6:802:21::44) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CO1PR10MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b968ef6-ec76-4fee-dad5-08dbcf71bae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ScJ051MaZkAwfdfwF3ROfgVVX+cRcxV/eEHZRG8yMo66Tds5lcfS/Mliv8D8jIiqKRtcIASsw6Z4/t4asDDQTmPmrmCy/E+qTADuBKtoeXy1mPDWm7CLyERA3tvuKeWq13upkBsszcHHF8LMTg+sEKDr+JHO3OSweHH5BPPkdpCWhkroJ41muxqbEte702igwUFvtoMqJBIRglS6rgXWoDxqNrjbIpkC8A6kVuvXRZqS20DzsYqQW+u1CpvrwMineFVBp399KyaDyATLjmoH9vSmcyNsVAdYVnIhJPx05S++TCS5TsnV+tNJDWrP2WClkgcCryzgGBwegviIUh3x3mUu1nkiK+oyh08nSz1Ikamshh95Wxg9LDkFA7/EVKwSqTQ7E/lFeMM5iZJiugWi2aLCpj7EBdO1o7tpZWaqHZqxsTBL2VWnStWZwPGpJwWjpUMfQK63s4NhLnXLp5Dz2wEdRghAIvS0098YxA24T5/qID+Bv1S1cbPLE0d38D1hMyiywOTBcCZjt5fBPZsRpFiBxg3q6IMDIcAnvlJh4g9raDlyJCkax7jjNdBpUo+fA+YCYdRXyuavAzcPRAkeEqC9gUnBrB6ArKUS8+uRS+0TEtSalq2C7aINCcgyPCqnP4uQ48jnJ2zNJBbAGXVHmwnJAs1eLEPkduqhNxPM7b4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(26005)(6666004)(2616005)(6506007)(36916002)(53546011)(6512007)(110136005)(107886003)(83380400001)(41300700001)(2906002)(4326008)(8936002)(8676002)(478600001)(6636002)(66556008)(5660300002)(316002)(66946007)(54906003)(6486002)(66476007)(38100700002)(31686004)(36756003)(86362001)(31696002)(14143004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkhpSGdrTUo4Wmp6a2M3dHU0eDZuRW1KN1gzV0I5bUlkeEVQYzZuRG5NYmxJ?=
 =?utf-8?B?b0pGQzBlSkVXQ2hTeVVKKzVQWm1VUUpxYVBuMjQrQTlJdXF2VWpRY3d5RGdK?=
 =?utf-8?B?T2JvN3BaTEdNaUFITkJWZit1TzFJQnBLSEFMcEx2VmxWZ2FVVUo2YmF6OUl5?=
 =?utf-8?B?S01PNUxYSlo3UFFmenFpMWZvaVVNQjFlUTF0bWFQUGloLzhjYU9UNk9rVDlR?=
 =?utf-8?B?aFNhVXVpVVlLeWhyUFpQblpBZnZ2aE5nMjc2Y3NaVWxlM3lqNUFQTm44SFFm?=
 =?utf-8?B?b2RVQVh4NjFHUjA3SC9wdnlydGovZ0hFZ2tQK0hGT1UxMjZHbW1kdkw2TFlz?=
 =?utf-8?B?QnFMOFN1T0dCaG5HY1l6U1ZYUFZOc2hDdERKeERGQmM4aHhPTnNXTnB3a0Ro?=
 =?utf-8?B?Q1JrUVVWQnZzdDhuL1F0OXZ2LzBZbkh5RkhVa1pXa2tkRUV5WjFZSG1aakw5?=
 =?utf-8?B?VUV6cUVKUEtpaENNRUR0UDFHV1VYbDlILzgwUXpNSzhVeUdSWmVjYm5ZV2dF?=
 =?utf-8?B?TS9YUHlMbE8rczBXZW5xc1FaWUJnenBBYnNacERMWnJHM2xtN0ZIR0pOeURD?=
 =?utf-8?B?TUR5cnJoc0FCQThZOXhmRVM1ZmpXSjhiOU9oZDVtT3U1Nnk3Y3gwRW1zVG9U?=
 =?utf-8?B?MFhPYlVvdUNVOTBWSnhzZEE3ejFkWmIxbTU4WEZDUzJLNkJCaXlJenFiNlNi?=
 =?utf-8?B?MVE0eDZrcFFoZ1dnQlNpcVF0bHlyMVdUcmczeVZsam9kT2FIWFdKVEE5dEJ2?=
 =?utf-8?B?VVdqeVNZMkVEL0VPYjdWbnpiYmE3T0JReXNtakxLc3JMdGlRSnUxZlVYZTVm?=
 =?utf-8?B?T0hId1p3MG8wenRTME9GWVFXc0thRmFNSC9PSDRVaE5tbUpoNUJVZEJaOVVX?=
 =?utf-8?B?TlIwYzU2VWdSNHNKV3J4dG4xZHpkY0ZHYnVOTHFHbWFpbERONDBnMXVKck1Q?=
 =?utf-8?B?c3oyY2lnUzFMNEFLSDRIWmE5cjJvbktaTWkrVkwxZ1BOVGxmUjJQQUU0V05L?=
 =?utf-8?B?NnlpN0R3eFA5eUJ4VnVZSWd4TGRqdEVsTTdVSEJveVVhZTJRbERhMmgvTThY?=
 =?utf-8?B?elhnUzNmdkh0L0Q2OFJsT0N3V0FKLzRDclhySjl5U3dKUFpWK3JNRTA4eEpV?=
 =?utf-8?B?NWZ5QVRlZVhQbzMvWklhYnNXbHhhNVUxWFZzUWs0NVVuZU1XbHI4Zi82U2NG?=
 =?utf-8?B?ODdBb0QzbnhZZitnMWNBSXBQT1FwOW1pdE4xbVQvZ3pUVTNoZ3Z6SlFOdS9w?=
 =?utf-8?B?OHZZSmdpUXpuME1QQlRpOTFQWTU4VW1Ec0RrOGQ4VEtneE1VVnRXNitoVjFB?=
 =?utf-8?B?ZVo5dmYvVmh3QXpzcHFJMThUME5DQ1VGcXI5ZklzNEdMKzhZWGp3L3drK2t4?=
 =?utf-8?B?VVQrck82a2xIQWlKODk2OThzRjhtMit3UUtyOUI3eUJ0MnBvVlpaakt1Rk8x?=
 =?utf-8?B?MkRXaFBYUkRIdzRJVmY3bnJkZkl6NytRSlRKYURYeVUyb1hpNGxrWDM5MHRi?=
 =?utf-8?B?UFE3eG94ZWdqWjY0N1RJaEd0NVcwMmJyL3IxUUxQWXFNTHFjcVhvL2RORk9I?=
 =?utf-8?B?YkJ5OW5MK29WdFFPaXo1ZlNkMmxuNUpsTis2K1VLTlVXSWtzc2s1Sk5qYjhw?=
 =?utf-8?B?QTRzZU80ZVM2UU15SVp3TXAzQ2s2azFpZW1SUlp6K2VtcUVNUnZsYWY3cVZj?=
 =?utf-8?B?d281Tjd2VklNSDBKWEN1S2NteGFuWUNORDZJalRvT2ZOdkFFQ1FNeHZCVHAw?=
 =?utf-8?B?ZTltNTNYRWdWbWpQSHBES1ZJbGI2ZVhIeWFWdm5JUjlHbm43VUt2VEZoQTdG?=
 =?utf-8?B?RGR5OExtY0JOcDlzL2ZSLzVCb3RTcGJaVlR1cGxJcjYvK0VLb0RRcUhOek9Y?=
 =?utf-8?B?VEpWaU5Ra2RJelV5MFFRcmdjbDJMblpWT1dIY09UdmJsL3NQTmF0b3A0LzB5?=
 =?utf-8?B?ai9FdkU2QVJJTmcxNjR6WjJkaEdlS2RwR3hZNHd2bWprVm90cHVYQklJc09D?=
 =?utf-8?B?QVJleXZZTkorZkllS0RCWVczR28yWnBnSTFWUXU2KythM1NTZFV1WXpBay85?=
 =?utf-8?B?NHY1anhXMjNyZmNJRTVUaFBrNjVjMEZZMEFkNk04SGQxVk1iQmdjaWQzaEw2?=
 =?utf-8?Q?AjRkJ5jvAHryLtBog/+OabRcJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: H5Sy9jzwRThvC0z92Kh5akF+jDeJaTL2NZy5RTiEspRWVNOfbdSxoFirpdPtfyqoMJy+QmMAKXwPdVSG44tLlHTmRV3H/FxevF/mp4DmuOXvN87/CY8ypnjhXUeGhSdb1XsN4O6Q8Wv0GN2ldYCUAyev7H357Fs8Hh03hXS1JcR7jDmdG/cJhZE5IdhcOc8Akq4coVfoSe8p9pGXbLqBwYSOeUOyj4YgqMLXyhSsOcruUr+E1Xe5dhlqTun437gDHDylEsps7nN4SLL0TA8SvWhW50cbu/sH8mOJbfvdlG+/G0nr3WUzHwyf/XrN+bCPko2bzefyA5vEgADyMVxOC6G+xFozKydJzBbzz34cvk4uaCuYYr5+NN4IDbBNMTnGMIH+HhkOOtxI9b44lTnZEPjWsVLLulWyWy7MJkeaezT7TXrKNPzfQrBw4Eej3O8gM4KAVmAawzSB7fVdfuWR+kVdx46J0pQ76Tcz6/lsLd4ChCjGtoaYh7tmv4lKaFRmOHxBTrymAKIawm4uTyvhPWJN5RyDPJyi9g4/fPbARYfreuuGVpGCzJSJ8YCZes2lYm/BrQe/dhtY3So/mUXypL0k8VVnDseo3jH93V5HqnKIdCcrgntC5ikJfAFPl41catM1BtJztu4fMTEucGXHIKLocpbh+RCyQLNbtFekhkvX9p2XbTLSC6QAl3jVu7vMTJg7w2kZuyiAS8ui/MwVaQGbbW8irkf5E+daDvt+BvPZj78hM2bADwcIJP8X9yYYWmUxOF9rn9KtBIX3fl0l3PPivDSL4A8EencxzlXvERY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b968ef6-ec76-4fee-dad5-08dbcf71bae2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 00:32:37.9205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIzG0keXrMM1k4UwmMgTMR6KDyz2xlHYcI3+lehrbnmAF+J7kOdR41387znWXlUTrr1+QH8Phg3CBT2aMu3LMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4451
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_08,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180002
X-Proofpoint-GUID: ecRry6WYwzQHntJUO35g3SGRGndnQFCb
X-Proofpoint-ORIG-GUID: ecRry6WYwzQHntJUO35g3SGRGndnQFCb
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 10/6/2023 2:48 AM, Michael S. Tsirkin wrote:
> On Fri, Oct 06, 2023 at 09:58:30AM +0100, Joao Martins wrote:
>> On 03/10/2023 15:01, Michael S. Tsirkin wrote:
>>> On Wed, Sep 27, 2023 at 12:14:28PM +0100, Joao Martins wrote:
>>>> On setups with one or more virtio-net devices with vhost on,
>>>> dirty tracking iteration increases cost the bigger the number
>>>> amount of queues are set up e.g. on idle guests migration the
>>>> following is observed with virtio-net with vhost=on:
>>>>
>>>> 48 queues -> 78.11%  [.] vhost_dev_sync_region.isra.13
>>>> 8 queues -> 40.50%   [.] vhost_dev_sync_region.isra.13
>>>> 1 queue -> 6.89%     [.] vhost_dev_sync_region.isra.13
>>>> 2 devices, 1 queue -> 18.60%  [.] vhost_dev_sync_region.isra.14
>>>>
>>>> With high memory rates the symptom is lack of convergence as soon
>>>> as it has a vhost device with a sufficiently high number of queues,
>>>> the sufficient number of vhost devices.
>>>>
>>>> On every migration iteration (every 100msecs) it will redundantly
>>>> query the *shared log* the number of queues configured with vhost
>>>> that exist in the guest. For the virtqueue data, this is necessary,
>>>> but not for the memory sections which are the same. So
>>>> essentially we end up scanning the dirty log too often.
>>>>
>>>> To fix that, select a vhost device responsible for scanning the
>>>> log with regards to memory sections dirty tracking. It is selected
>>>> when we enable the logger (during migration) and cleared when we
>>>> disable the logger.
>>>>
>>>> The real problem, however, is exactly that: a device per vhost worker/qp,
>>>> when there should be a device representing a netdev (for N vhost workers).
>>>> Given this problem exists for any Qemu these days, figured a simpler
>>>> solution is better to increase stable tree's coverage; thus don't
>>>> change the device model of sw vhost to fix this "over log scan" issue.
>>>>
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> ---
>>>> I am not fully sure the heuristic captures the myriad of different vhost
>>>> devices -- I think so. IIUC, the log is always shared, it's just whether
>>>> it's qemu head memory or via /dev/shm when other processes want to
>>>> access it.
>>> Thanks for working on this.
>>>
>>> I don't think this works like this because different types of different
>>> vhost devices have different regions - see e.g. vhost_region_add_section
>>> I am also not sure all devices are running at the same time - e.g.
>>> some could be disconnected, and vhost_sync_dirty_bitmap takes this
>>> into account.
>>>
>> Good point. But this all means logic in selecting the 'logger' to take into
>> considering whether vhost_dev::log_enabled or vhost_dev::started right?
>>
>> With respect to regions it seems like this can only change depending on whether
>> one of the vhost devices, backend_type is VHOST_BACKEND_TYPE_USER *and* whether
>> the backend sets vhost_backend_can_merge?
>>
>> With respect to 'could be disconnected' during migration not devices can be
>> added or removed during migration, so might not be something that occurs during
>> migration.
>> I placed this in log_sync exactly to just cover migration, unless
>> there's some other way that disconnects the vhost and changes these variables
>> during migration.
> The *frontend* can't be added or removed (ATM - this is just because we lack
> good ways to describe devices that can be migrated, so all we
> came up with is passing same command line on both sides,
> and this breaks if you add/remove things in the process).
> We really shouldn't bake this assumption into code if we can
> help it though.
>
> But I digress.
>
> The *backend* can disconnect at any time as this is not guest visible.
>
>>> But the idea is I think a good one - I just feel more refactoring is
>>> needed.
>> Can you expand on what refactoring you were thinking for this fix?
> Better separate the idea of logging from device. then we can
> have a single logger that collects data from devices to decide
> what needs to be logged.
Discussion. I think the troublemaker here is the vhost-user clients that 
attempt to round down&up to (huge) page boundary and then has to merge 
adjacent sections, leading to differing views between vhost devices. 
While I agree it is a great idea to separate logging from device, it 
isn't clear to me how that can help the case where there could be a mix 
of both vhost-user and vhost-kernel clients in the same qemu process, in 
which case it would need at least 2 separate vhost loggers for the 
specific vhost type? Or you would think there's value to unify the two 
distinct subsystems with one single vhost logger facility? Noted the 
vhost logging interface (vhost kernel or vhost userspace) doesn't 
support the notion of separate logging of memory buffer sections against 
those for VQs, all QEMU can rely on is various sections in the memory 
table and basically a single dirty bitmap for both guest buffers and VQs 
are indistinctively shared by all vhost devices. How does it help to 
just refactor QEMU part of code using today's vhost backend interface, I 
am not sure.

Regardless, IMHO for fixing stable p.o.v it might be less risky and 
valuable to just limit the fix to vhost-kernel case (to be more precise, 
non-vhost-user type and without vhost_backend_can_merge defined), my 2c.


Regards,
-Siwei
>
>> My thinking on this bug was mostly to address the inneficiency with the smallest
>> intrusive fix (if at all possible!) given that virtually all multiqueue vhost
>> supported QEMU have this problem. And then move into a 'vhost-device for all
>> queues' as it feels like the problem here is the 'device per queue pair' doesn't
>> scale.
>>
>> At the end of the day the problem on this is the vhost object model in log_sync
>> not scaling to amount of queues. But you could also argue that if the log is
>> shared that you can just log once for all, plus another one for each deviation
>> of normal behaviour, like the points you made in the earlier paragraph, and thus
>> the thinking behind this patch would still apply?
> The thinking is good, but not the implementation.
>


