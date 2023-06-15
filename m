Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C267321AD
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 23:27:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9uTO-0004ql-0g; Thu, 15 Jun 2023 17:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q9uTL-0004qS-DB
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 17:25:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q9uTE-0001TO-EV
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 17:25:39 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35FGJ9pA004837; Thu, 15 Jun 2023 21:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=DPI/jhpXW/jEwKSr+eCEIT0M4r7vp5GjxzTG0h2P8VA=;
 b=uehi5uLhsWkHKurRsVgx0jKI0TuVo3FMpmMokBI3mns1ZK/aUiJtUEN9YkGZO9qEMqBY
 ze5Rlk7oeCT2zNcn1/tKaIWnidAmh8p84gdyevdR7rWZq21IgG1DTuFmLL8g3SonUsai
 mRvbq76PoIZm9z7jdFByKxbPzoFtGPHs6LvR0VMs5L/2ocEkLaJNbY+7q6ugWss+/Nn3
 xB6y0lFLDC5EpHZSAPp4KEoD8sOQvEINZWUTW7o5FZBigxpHxgWgmfu94ubbZmLqLEkN
 wsu1Dzzy+zLNyKwePdgQbgy95GImIHQM0cs8A+Wp+bJHct5Xd8af9x7AVFS6cdv6jlsH bA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4gsu2wws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jun 2023 21:25:28 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35FKM1op040545; Thu, 15 Jun 2023 21:25:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm76v8q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jun 2023 21:25:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBaRgGsjo82Sr2F65TNkZqyZ4klk/3sstnaG70uQQNWRcp0eGLZUfTEn3xx0ts2S9IbyyYvL+VyB8cTKd3vFEYhtO4rRXL3JnN/C15n4Qx8rorpYoo9cwZJXtvBxZ9wvQixeQQdjoJjEQoNUFIYonN25ZVjNkuF6Jifkfnc45JxpVROo3sUr6/6INllzFRIRHau/Wa4EdzWHN07lsm5kpKfp7UioRq8c9DV5v40Yxccg39oUNP0cGxbofsXft3zLhVxrxWVtQ61gx6lPJQl4WY9Pt3VbCEFKAWyelYU6s4GYt5HtTBFt6Ih1KwaS6J5ZpvSlzxbdZ09Xmwt4ARlIHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPI/jhpXW/jEwKSr+eCEIT0M4r7vp5GjxzTG0h2P8VA=;
 b=jLzQif87KdlbXsb9KOmQ1XBC7mzFvkPd27A8lHiIFu8USGCl9CZ2kyDqTqTXdZRGmSpTwI6UoN5ySLQhe3dSQrxukD2rUcocD0W6vxD1n+v1SUNKpXsQ5nHflIl1e/Oj4QH5uuFbUrwccPpKdCLbXqI4BTqWuHx5ghv4P2p8oYEJxEOTxyLDBxt4kJRq6w3KMW0KRbgDdASOY76M9agwyQDuvN/Y4jK90CanRgdXUGt23uw3v3Nz2BebL0g5j0hSmDqAmxmmhUYc4XDvPD1iuH7CcEleluPRzEpemsr/+306CzLNnunG1iYzhHOAry8wMTBmxdmDKEJkZvTMd1v5cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPI/jhpXW/jEwKSr+eCEIT0M4r7vp5GjxzTG0h2P8VA=;
 b=INJZTD+YTCiVDU1jbeg9fZIBZ9tNJdm1iymXmvATP/4TjYwRE6oWhau7Dv+74IKifjsNH6yewORWnW2iwn/NVX4JYhecSCsPpMyt/L5L54d9MqqCGotFw0dU2o4CEk5J9+nqE6/P73m5eFxOgFUtDjN7omTrCkAYZtqS2cg2UqE=
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com (2603:10b6:a03:2d7::23)
 by CH0PR10MB5307.namprd10.prod.outlook.com (2603:10b6:610:c0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 21:25:24 +0000
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::36d3:42ea:8103:b120]) by SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::36d3:42ea:8103:b120%3]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 21:25:24 +0000
Message-ID: <27092461-aa2c-5a0e-ea9d-3742d9284a15@oracle.com>
Date: Thu, 15 Jun 2023 17:25:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 1/4] qapi: strList_from_string
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
References: <1675795727-235010-1-git-send-email-steven.sistare@oracle.com>
 <1675795727-235010-2-git-send-email-steven.sistare@oracle.com>
 <CAJ+F1CLFMUDvaOq2QXCKpb8Zj4PRr-tKV1q9L8m2EfgORPLj7A@mail.gmail.com>
 <32f34f74-213d-7107-907d-dda0a509878e@oracle.com> <87h6vwnstx.fsf@linaro.org>
 <87cz6j6tt0.fsf@pond.sub.org>
 <d25846e4-13fd-c683-b5e1-1660f4470d35@oracle.com>
 <875yca23dd.fsf@pond.sub.org>
 <7beaf84a-008e-c9a3-3698-2a230196acf9@oracle.com>
 <87cz6izmtz.fsf@pond.sub.org>
 <1bb65a74-d444-7601-47d3-290959239831@oracle.com>
 <87sffdvpmu.fsf@pond.sub.org>
 <555c8a46-a530-c258-8614-0485536c60ee@oracle.com>
 <87legnee48.fsf@pond.sub.org>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87legnee48.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0126.namprd13.prod.outlook.com
 (2603:10b6:806:27::11) To SJ0PR10MB4686.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4686:EE_|CH0PR10MB5307:EE_
X-MS-Office365-Filtering-Correlation-Id: 985930ea-415f-4232-6c9c-08db6de707f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ENx4MY5WhpXPNBPDpNDtM/FTZQ885CjyI1J9VaJkwngp7jzxPexRd6H54C2C8GqCHPLTLd7aKEi+ggNHjpY2ro5R+eyPr/M69cQvylCI0LtvPQPGIQjOcdwvLbeKfTnQ3nGtPLF6MolEoG8nTjQ3UwzFOQf8F4ECpf/qQfw4yP1VpRrcgsqq8MAUtNquEIk33s++iMVM7yFMVY6gWlnson1ueRQipvx21Dxydy7stm2/UQcL1CN7JISoYT2ZFHPJQyf9q9VA9WvChpHsq20jouXujMZyliPUYVT8f9OVWlKykvwfrLEjl8m3DLcHqQSJ+VspMF1oJbUTDKGMPByPBoSbDUVwAP74Xyst/LjB69NaZaOZnGkNFix8ypK2pNegyPmCAgaYJ8ZDHvZJpRVd3NZ+6qdj5BRf60Um3IX1SJ2G39y23Foh0VPiFoR6DthpBgIDCKCFsiUxEJGnzfeJcuu5EF5gZXNqzI5JvdqExmbePvL+Oewab2JfTyg9LbDN7EddBkCmcB9BqBVtQqNuB/zOs0fEW6aC+MdyDQE4lKKW7gMvj/a8gqJZdi5QPhAcZbNW++jiwkUoLdxdnsJXBr8iHWJ9v0Lnj9iiHH4uRGyxTsZY7oZOCBQKGKqnOgV/D3RJsHHc8xLvbNYqTdfIusnbjxRWOSOUGZysBBdwRO6FKkGU47jhZw103IT5xGQt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4686.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199021)(2906002)(26005)(6512007)(186003)(83380400001)(2616005)(6916009)(66476007)(66556008)(66946007)(31686004)(4326008)(41300700001)(8936002)(8676002)(6486002)(316002)(6666004)(54906003)(31696002)(36916002)(86362001)(36756003)(38100700002)(478600001)(44832011)(53546011)(6506007)(966005)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXpXNjYxSHJUNys4cHpKelpEK3Q1UEVRa054WHdseEVLTWhtMW1BV1ZxbXJw?=
 =?utf-8?B?S3RmczdWMGM4TU1UeW9JcGxqaUY1ZGxxTFIyK01aVWdlMjVMUGpXWXJhdXBu?=
 =?utf-8?B?MGd6cHdXQkRsNmtsc29YRWhPT3FKSzVFSDFsUmxweGdzTlcwYi9vMGplWHUw?=
 =?utf-8?B?eTU4bU5CODJGWmdtVFp5bDUreGZ0RUd2OVRqZjExeG94WGppbWt6cElNQlAy?=
 =?utf-8?B?RCt3bUYvVnBpL0pvVFd5SzVmclNoNUpBT2h4SE1PZWtwQjBUWkpFMmN4dVR1?=
 =?utf-8?B?NnFRYVVMYU9DZXQvUjlPS3Z5UVNUaEJTNDEyVzlVbDU3eHZIVWJHbktYNlM5?=
 =?utf-8?B?Mjh3cmhOU2RLNHJFL0pLR2JHdjZ6d0dLcEcvQUVFVkxQRFJocTh2Z0JzcTZY?=
 =?utf-8?B?QlZreVhiWHRaRHNVVVpQcmp6THp2am11czFHckljUmNBSTZLTTBPbGZ2ZXE0?=
 =?utf-8?B?dHVKeVQyK0pUdERSKzBOMTVCKzltTkpyYUdPM1IxOUp5Mno5aDVJWjJ1b1JD?=
 =?utf-8?B?bXVhMFhveHI0a3VYWlFkZENRMUp1V3ZtQUFMVE1MYzgzMGZDdlU4aDlCTXpa?=
 =?utf-8?B?U0xkTDFPRDBEMG12UDFMcmJJMUNIYm5uUFNVb01LZUd4VVpEdmVPL0IzZzFt?=
 =?utf-8?B?Vkxqbi9EOHN2TzFnbGttcUlncmxvV3pNU3Zaak5nNCt4dkhiWXhqRVZyN09r?=
 =?utf-8?B?YjY5enBYWlZZM1VNSk1wOVhuOW5FQzQ4dDV4NjlRNlNEM1Z3WE9XdFlqckFo?=
 =?utf-8?B?Q0ZpVE5aNExQYk5IZXMydlFITkg5OWp1b1FlZk5kL2FuWncwTTJMUFlSTmU5?=
 =?utf-8?B?dzBCUkNDbWRYSzhnaVo4cDVkWXV3OUlDMXg0VWY5bm5aQTlvMm04L0Fqanpo?=
 =?utf-8?B?OXJhUVYza0h5elVpYi9rZ283T1RHZmQ4dG95TWFIbUx5bmlDWXBhU25YN0JR?=
 =?utf-8?B?ZC9XQkFCbHVBVWdMMjRwU0VCdm1Eb0U2QzQvaUpOSFJLdEZTVExteksxeDBs?=
 =?utf-8?B?bFBBNWllNzRTMFFKMjBaRHkxank0amNyUGlLNXZENFFxV2poQU52M0ZwNFBj?=
 =?utf-8?B?a2dtRmMyQkIzRVpTbjRNT0pZdkpWemQwdjFtWnh3SW44dEs4ZnFqd3pWcmxX?=
 =?utf-8?B?bXlaeDVDRzFHWWhWNEd3c0hvenc1cmhESlFvS1E4RU9pYXRRWWQ0cHNnR2Iy?=
 =?utf-8?B?bmw4ZjVKUEJUQWxrbmxSdmN0dnEvVDBDeHVyelRpU3AyT3A3clo0OGE5SWtD?=
 =?utf-8?B?YnVhVlFRcnZnTTRXb215Z281SERiR0dmRGJ0TWJYZ3FPbDkxRCtBM1dWeEJD?=
 =?utf-8?B?S3VFK3czbEpEcjJyOElxS0lhSlNaaGVTaGZhU3kyUXRrbjZVQ1JDU0MzL3ZJ?=
 =?utf-8?B?L1lVakVUdnE0TkIvSzhWOEF3TGFKVk1sL3BQV3BRQTBtWTZkbVdoRzVycHdx?=
 =?utf-8?B?Wnd2YUc2alNTNUlDZnpFR01FaEpoTFNaeVA5MldVZTMxWnJUNWxHRzFHREJT?=
 =?utf-8?B?R3RTbWlpdC9LT3lhclRYK01OeDluNEZ6NWNGQmdQS04yR1JkYzdqZndGRFhr?=
 =?utf-8?B?TjEzSWppUDduSGZWNDhIL0o0NnZhVVVQYm9jbTUxK0xmbWRZaWpDVGN5LzNM?=
 =?utf-8?B?TWF5OS8yaVA4V1c4bk5BSXptOTlnS29CRU5yaEhsNG1ML0xhQXpBMmRwbEtD?=
 =?utf-8?B?YXphZjVUUnUvUlVHNG1iNm9MOEl6OGpOcUwvVEtqNjA5MGxBQ3FGNG9ac3Rs?=
 =?utf-8?B?Rjh1NHRYbkxpaWs1S1JQbmt0M2kvdmZTSm9NR0lnMUM5S0VCLzBvQUtVR3pS?=
 =?utf-8?B?UVlGZDhTL2k3S2JqZjJGQjBReTVxZEVxZVpsdEY3UWZPVVN0bTlrYzZXQ1o5?=
 =?utf-8?B?TTdhSEUxbXNnc3Y3aFB4dndCY3R2UkZYQmtEeDc0WXJNa01TejVYdHhNb0Nl?=
 =?utf-8?B?cHVBWVNjVXJJdXhXS1BVQ3B5RlY1Qjl1eUJUUmZESHVGUEZpQ0lNQmN5T3pT?=
 =?utf-8?B?OGZXWTJEOVdOZFZrdjV2bEZjUHJVeWRmUnZrSy9MaURZNjNMTDIyZVBmWDg5?=
 =?utf-8?B?QW5nRGdaeWRZNXpDcXV5cmNZVVpXbVBnVDg5dE8rRjRYdVFhYUhNUnNJNGsz?=
 =?utf-8?B?RzU1c1RjQnRNZ1JqdHF5OVdPWnR1aDhadlZBZjJKdFVYc0IzNXp0dWhJYXZs?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eBxpOMKj1v4zlfpCELFh7MwQKCeoUS020Y0CDGmVPYrqII1EKZX0mRiPejjs79juvIYNGhioyvTUpr4C2QlaGWf5XZhOVGWYDWUuZWbgQlWTtdLAcAjT3UqdczrapgCGH4y/OvX7G/uzP5mh6CZ+IlLRRwD7IpHh6hhb7skrREBmWaX/9WkSA4lyrJWWH9xgKVJQ/gB3/401Naa0b1GyrV+1FEuVP4oUEP4twgmYke9rmBBWkko+lfgHSB7fdJ6CsjQINabvv/2b1kYuTRvlzTHSfo4nYKK5weZWvlXCgmDYurdBJuQn+cGzX2v1zXxLr/UXxbtlALfAvPSYSMzxJdbE6+rs+Ir3MNbtcQZBELUT7e3wZjhG1qAtp+Z/LmoJAq89WQ+F4YwrsihiptRh0NkW43OifJWW3elcmL46HqH7GcVqlSTQSDm8aIk4gcuOOH/g8OjQQBCvBWVzZL5iezi7D1GsIaq2Qvuc5tJmVW91j9Go1aY3UoIgfAsHNAC4TqDwvSyNZYpETFCRBKx63uZgjDFKgp/PI3vwwRTMudm46OslcVkEnnvkU6OikQMg10/snvtgXga+7xhjrCo/9YH38dF9wPO4HYRCmFetihTtYDacD2IX/ZLBO3rCfW/gCUfGV8zjnLSKssJohToNbQtqmR+c66tCSRoXDVo9nFFcT1s0L38VZqePICTMzAeL+vHhLYbueefCsaLtf1LRAKkCj3HKpmSK36NgFLPTs825O67VTMiB5mXwgX8K8arTAwbWwIwJS/KTmGTEE5tM/eESNkbVvLvw+qJ/XuCJNBCHEb8vMqEh5vfbl8lRG+TotgjPM3lPy5ETCeimVVnbpeOjjhtonvzAQhInP538Lxw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 985930ea-415f-4232-6c9c-08db6de707f0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4686.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 21:25:24.3129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQqpTCDWkfbcm1ynfanP1tb/VfShvHyQmOKiC8wBheDRMSpuxoXaOaOGsUFN+1coRw8ppUl73FcSaiE7D0k5H2K0VN6789r/0m7CQ6a4c0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5307
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_17,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150185
X-Proofpoint-GUID: 3rERe9otlqKiDWoFYNsQpPYY5arCED8y
X-Proofpoint-ORIG-GUID: 3rERe9otlqKiDWoFYNsQpPYY5arCED8y
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 6/13/2023 8:33 AM, Markus Armbruster wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
>> On 2/10/2023 4:25 AM, Markus Armbruster wrote:
>>> Steven Sistare <steven.sistare@oracle.com> writes:
>>>> On 2/9/2023 1:59 PM, Markus Armbruster wrote:
>>>>> Steven Sistare <steven.sistare@oracle.com> writes:
>>>>>> On 2/9/2023 11:46 AM, Markus Armbruster wrote:
>>>>>>> Steven Sistare <steven.sistare@oracle.com> writes:
>>>
>>> [...]
>>>
>>>>>>>> For more context, this patch has been part of my larger series for live update,
>>>>>>>> and I am submitting this separately to reduce the size of that series and make
>>>>>>>> forward progress:
>>>>>>>>     https://lore.kernel.org/qemu-devel/1658851843-236870-1-git-send-email-steven.sistare@oracle.com/
>>>>>>>>
>>>>>>>> In that series, strList_from_string is used to parse a space-separated list of args
>>>>>>>> in an HMP command, and pass them to the new qemu binary.
>>>>>>>>     https://lore.kernel.org/qemu-devel/1658851843-236870-16-git-send-email-steven.sistare@oracle.com/
>>>>>>>>
>>>>>>>> I moved and renamed the generalized function because I thought it might be useful
>>>>>>>> to others in the future, along with the other functions in this 'string list functions'
>>>>>>>> patch series.  But if you disagree, I can minimally modify hmp_split_at_comma() in its 
>>>>>>>> current location.
>>>>>>>
>>>>>>> I'm fine with moving it out of monitor/ if there are uses outside the
>>>>>>> monitor.  I just don't think qapi/ is the right home.
>>>>>>
>>>>>> I don't know where else it would go, as strList is a QAPI type.
>>>>>> include/qapi/util.h already defines QAPI_LIST_PREPEND and QAPI_LIST_APPEND, so it
>>>>>> seems like the natural place to add qapi strList functions.  I am open to
>>>>>> suggestions.
>>>>>
>>>>> What about util/?  Plenty of QAPI use there already.
>>>>>
>>>>> Another thought.  Current hmp_split_at_comma() does two things:
>>>>>
>>>>>     strList *hmp_split_at_comma(const char *str)
>>>>>     {
>>>>>
>>>>> One, split a comma-separated string into NULL-terminated a dynamically
>>>>> allocated char *[]:
>>>>>
>>>>>         char **split = g_strsplit(str ?: "", ",", -1);
>>>>>
>>>>> Two, convert a dynamically allocated char *[] into a strList:
>>>>>
>>>>>         strList *res = NULL;
>>>>>         strList **tail = &res;
>>>>>         int i;
>>>>>
>>>>>         for (i = 0; split[i]; i++) {
>>>>>             QAPI_LIST_APPEND(tail, split[i]);
>>>>>         }
>>>>>
>>>>>         g_free(split);
>>>>>         return res;
>>>>>     }
>>>>>
>>>>> Part two could live in qapi/.
>>>>
>>>> Works for me.
>>>
>>> Note that I'm not demanding such a split.  I'm merely throwing in
>>> another idea for you to use or reject.
>>
>> I decided to not split the function.  IMO having part 2 free memory allocated
>> by its caller is not clean.
>>
>> However, I will base it on your original function, slightly modified:
>>
>> strList *strList_from_string(const char *str, char *delim)
>> {
>>     g_autofree char **split = g_strsplit(str ?: "", delim, -1);
>>     strList *res = NULL;
>>     strList **tail = &res;
>>
>>     for (; *split; split++) {
>>         QAPI_LIST_APPEND(tail, *split);
>>     }
>>
>>     return res;
>> }
>>
>>>> For future reference, what is your organizing principle for putting things in 
>>>> qapi/ vs util/ ?  I see plenty of calls to g_str* functions from qapi/*, so I 
>>>> don't know why removing g_strsplit changes the answer.
>>>>
>>>> Per your principle, where does strv_from_strList (patch 3) belong?  And if I
>>>> substitute char ** for GStrv, does the answer change?
>>>
>>> As is, qapi/qapi-util provides:
>>>
>>> 1. Helpers for qapi/ and QAPI-generated code.  Some of them are
>>>    used elsewhere, too.  That's fine.
>>>
>>> 2. Tools for working with QAPI data types such as GenericList.
>>>
>>> strv_from_strList() would fall under 2.  Same if you use char **
>>> instead.
>>>
>>> hmp_split_at_comma() admittedly also falls under 2.  I just dislike
>>> putting things under qapi/ that contradict QAPI design principles.
>>
>> What design principle does strList_from_string contradict?  Are you OK with 
>> putting the simplified version shown above in qapi-util?
> 
> The design principle is "use JSON to encode structured data as text in
> QAPI/QMP".
> 
> Do: "mumble": [1, 2, 3]
> 
> Don't: "mumble": "1,2,3"

I don't mumble, but I sometimes mutter and ramble.

> We violate the principle in a couple of places.  Some are arguably
> mistakes, some are pragmatic exceptions.
> 
> The principle implies "the only parser QAPI needs is the JSON parser".
> 
> By adding other parsers to QAPI, we send a misleading signal, namely
> that encoding structured data in a way that requires parsing is okay.
> It's not, generally.
> 
> So, I'd prefer to find another home for code that splits strings at
> comma / delimiter.
> 
>> (and apologies for my long delay in continuing this conversation).
> 
> I'm in no position to take offense there ;)

Thanks, that makes it clear.

I propose to move strList_from_string and strv_from_strList to new files
util/strList.c and include/qemu/strList.h, and leave QAPI_LIST_LENGTH in 
include/qapi/util.h.

(cutil.c already has string functions, but only uses simple C types, so
not the best place to add the strList type).

Sound OK?

- Steve

