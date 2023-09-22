Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6E87AB5B9
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 18:20:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjis9-0005b7-5N; Fri, 22 Sep 2023 12:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qjis3-0005Z7-GX
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 12:19:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qjirz-0001uW-55
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 12:19:10 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38MGHFbG028613; Fri, 22 Sep 2023 16:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=D6+Uxg5PQwylOR2K6HCKZpg8RXBm7MX3q+/3CoXC7Sw=;
 b=Syuhu+QEVcrHFsGkKjXdH14E1laom3QCHmVnzLtksDYWB4rusAuOW/IUoN+wKlJy1J+m
 up9GgWvwAoSHHPIo1Wm8+qiqN0u/lzNIvXdr7+rGNgODi1JTYmfunSYxyfDyW5NHkGEv
 1luTKG9f5HtpIXqT/oAOstO8sfsPizQFyjlcO7Lg2V65aaFYACW+syBNdWCDynoZ8C2i
 G8EHVM9wO6qhPQorpODUqZXMDstwVvVkgu9q7+qwbPBaxiGla3DOdZRJ8YG/HBWxVAwd
 2WV3pj4W996t1dUDd7y0FJ9PjsbE/2BG90oLtjd8/DE+Ou4Ux87DGVB8Fy+uzpp8Ymft Sw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tt1j6v6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Sep 2023 16:18:50 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38MFPOMi006285; Fri, 22 Sep 2023 16:18:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t8tt899rd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Sep 2023 16:18:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+XHFUmveA0UX+v/aX+a0rCedMMIGUf3kmMbpU+aV7UKW5a0gzkGSJXVLyq+9tHXY8CQtLFNjomSLVc6N6QRqhXkXo+zPI1W38/oLd8xbYRQwWjU7kbF9EGOWkALm2cIuD+jd63QF7hnNf6F80EErQzQVFzYmBH0rg2m9mJt61Y0W/AJZM9mOlnKnO3ce23BR/L45UTaQdiT9U1W6uzZcNOln1FCbvWrVNR+nDd5aTq+Yv7He7oELc2VJK0LO4n2xbDuIb/UHMCHvSdAhXEr6akxnNI8LSsbZSE8gq6ndXQtvFiwmfIwzX+lu4cRE1kH3LlXs/J4mHGdK6Jz/P4hZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6+Uxg5PQwylOR2K6HCKZpg8RXBm7MX3q+/3CoXC7Sw=;
 b=kUB0kv8UZB2+WCc2bVqRbXocXe5i7MOne/3ZzQ/WoxBwF4gBKrYdu8HnF2YIN98ghwXd5eDuLbkKBf4Zos9Yy5iHlV+W60dchWBKfmjNr7FiO0CJH2gcKxftVLHtIeOtJARIwBCtypY9tBHI63XPrA4VPXTqFiaQuSj9Zg98WatByowndz45GvHSa3EnkAgJsZI86Mt2OHJUcd57o9Q/Or4U7stInMcPy+5ZwZdb23lPc2hAVNnd6VyHQX+NQ4Hsps+nCCriGztt7UlQlSj4ZNBdEcDad2A/NBkSmwfY3m7Cho++UaMdnVCKuPcdSsNT7ODQBnO3VvCe/J2BNBs/4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6+Uxg5PQwylOR2K6HCKZpg8RXBm7MX3q+/3CoXC7Sw=;
 b=aLhId4sy/Cu9iwTsJhXy9B1P1FMbncwZfn69QcvKDvYzdu6sbrYMoF3ed/qlCcMAwm55l2RPOot4IO1filbZjmaCZvgqvhxEfKKcs8N74HTQLMqHWOwOfDwrHSTNJ/iP8lF7sNhxtVyuigSLVjfv6vLM27xwQrtVFVgvyYBlk70=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by IA0PR10MB7665.namprd10.prod.outlook.com (2603:10b6:208:484::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Fri, 22 Sep
 2023 16:18:46 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885%4]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 16:18:46 +0000
Message-ID: <cec7bf1f-3c43-2e68-ceee-a196d10093cd@oracle.com>
Date: Fri, 22 Sep 2023 18:18:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 2/3] i386: Explicitly ignore unsupported BUS_MCEERR_AO
 MCE on AMD guest
Content-Language: en-US, fr
To: Yazen Ghannam <yazen.ghannam@amd.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 John Allen <john.allen@amd.com>, qemu-devel@nongnu.org
Cc: michael.roth@amd.com, babu.moger@amd.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
References: <20230912211824.90952-1-john.allen@amd.com>
 <20230912211824.90952-3-john.allen@amd.com>
 <f287de21-8eed-0c88-98a4-69f00bd73be9@oracle.com>
 <948a0ac5-379d-44a7-92b1-d2cc0995e187@oracle.com>
 <39a471b1-9ef6-47e9-97a8-b315f63b4917@amd.com>
 <bd6f1942-4f6e-a353-8929-77fdc30bf06e@oracle.com>
 <60d3f74a-a1a8-4fed-a102-9985c47c69c8@amd.com>
From: William Roche <william.roche@oracle.com>
In-Reply-To: <60d3f74a-a1a8-4fed-a102-9985c47c69c8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR07CA0002.eurprd07.prod.outlook.com
 (2603:10a6:205:1::15) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|IA0PR10MB7665:EE_
X-MS-Office365-Filtering-Correlation-Id: 21fb4935-919f-4850-1e40-08dbbb8798bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zqtvt55G9tn434loQGYsm8fU/HBsaHV0FPm6Eem0S9pOhxvok+WHZ9mX0GM/ykX2dQraQkOsZNQjB8km5y45lYdwOIoNmxS7YBvbMfxAG968vtSiNvUeausAyqK+dyMpJSyotEWTpXqDmM6apV5ABDSZKj/78cKCsdYRbQFSWsB3BjNt1wDM79NIC8ymW9RFQETgcGB8TUTcDHVr7usKZRor41UEmCgvr/AAMJMXBwzw8tzdazLRJz+OiLDl2x3XGdMsxoho3rlMeBfGe5yY5nYoDtJGaL+8v5HyDYtbmxlesX+3lGldRH/EC3FBTXeQgra2EkY4Rl/cudkkrytJJ8AqqQZHY3pQMueLJGdu/tIwCCXs9k4JxOQoIcS678GRPhOo4P6zIutM4LIontPDeR+EBZSCgM0F+4omv4dJZz4b8pdijpWzdl5qSDI8x4RvSmDaJiS2k3E86Tk2VOYXXsV1aDsNZjaiW4O9UtwIB4xxA3e0jue1UDhq3J0rCQJABXdEN57O/BVWUXyqYovxp7HcUDeAGYSzMUS+KYMdz3Xe3H5A6e7fTGPZWGwUcwGLWOYbO4bVcjRrClvTst8ZkCmgZRJS3zHlFkPGmuIYcrb+iYpC/fKjte+OrkOhmsCKjBU5VCVE6wDW7pfpXM3CPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199024)(186009)(1800799009)(44832011)(5660300002)(41300700001)(66946007)(8936002)(66556008)(66476007)(8676002)(4326008)(31686004)(110136005)(316002)(2906002)(83380400001)(38100700002)(31696002)(86362001)(966005)(53546011)(2616005)(6512007)(26005)(66899024)(478600001)(36756003)(6506007)(6666004)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enNSQUMyUjU5MW5PMmMwc1c2T3l4MTJvdGsyV1NxenNCMVFGczhZdmVXaW1O?=
 =?utf-8?B?RkFHS3U5OGZsa0Q5YkY2TkhqRjZJd2owZGJUUm95S1dXR1ViL3o1cU11UEtC?=
 =?utf-8?B?UVMrRmFKSkRNWWMvcXhoNllEQzRvRWlWeURuZkFiTEVxcUdrZlNHc1NUWmRN?=
 =?utf-8?B?SlNvcGcyVHhkMC9rTHhmMHNYeWFraFVlazV3aXFlZHM1ZWFpdzBjeHppeXpF?=
 =?utf-8?B?TDgzVUl4bm5jelYyLzN1UHZoQS9seVlZbUo1WXJnZStFUlNpNlEzSE54OElN?=
 =?utf-8?B?ZUpUYk1VSXNOQUprbmQ5cEJUbDlIWmQxdFFWa3RmbCt3Z292dWpVNmo5a2pW?=
 =?utf-8?B?NStFS0FuUVZTbHN5Q21vRGhrVmQzQUtYb044ME5uTlQxdS8xZHMrMU1xQnp1?=
 =?utf-8?B?NUIrdytScWdEanJLVnhubC9EbU1FMW5UTm92cVhHb0M3UWRNRmZCQlFQYmdU?=
 =?utf-8?B?K2RBY2VzU2wvZkxFdStJTzRQT2Z3Y0xJZXEwMmUrZU92STJ5WmFabTAvL0tK?=
 =?utf-8?B?dENoRllOSFlaNWttNTdmT1hCM0M2d0VnQ3AxVFRMSHhudkt4TEQvcDVoSVhF?=
 =?utf-8?B?MjhVQm12aEV6anFtVHl6cXZYR0t6Z09nbDdTTkVKSG1Qc0hPRFRjZ2xOZEhQ?=
 =?utf-8?B?Y0UyaHYwWkx5MXU3UFBOcXBPV0kyRHZuM21aZTM3djFWVndNckVJbHp4Y0RN?=
 =?utf-8?B?M0Y1SjI5STcvQmZ4TU54VlJ4NGErQXIwNmw2N05XK00rd1lRV2NhSWNMU0wz?=
 =?utf-8?B?ZHZ2aE5lM0lja21HRlpWcEpnOEtVVWJjYjBZNUF5NVJIZkhPeXluTzBRUGRG?=
 =?utf-8?B?UW1yc2RiRExLSDVQVXh3clBkNE9qdERVa2ViWVloN2Y3UzhhWnpVMDZnNmZU?=
 =?utf-8?B?VUFNMlI0SHFsZEdjc2w5RC9XdHQzNHJ4bVF4ME0vdHU2UWhvQVhIbFdCQVB0?=
 =?utf-8?B?anV4RVlaL3BpYi91dDlGZ1B2SlRveWFqZ29kMDNxU1IyNDBxZVgvQ2FtS2RD?=
 =?utf-8?B?bkdkMi80UnhCU0c3MDg3MlpiT3EzaWZ6K2RoUmU3dFpXdkxPeWMvaHVsWDJQ?=
 =?utf-8?B?bjU0WDZwMVdiSU42OHlkQWJ2ZHU4ZDR4eXVVL3BBNmUranNkYk53WEhLVXVZ?=
 =?utf-8?B?VTdvY3dDa2NvY0FaWG5ac3UzLzFoL0RoMTZWaG90azZJTndQd0M3cGZ6K0R1?=
 =?utf-8?B?MTl2eUJ5WXloN0Jka0VKQVRKNUZ2bGtQMjFYNkRSYVJiNUVpTjFXejNSb3pI?=
 =?utf-8?B?Rlh5SEpEUGRBODZVaklTVkpZamZscmhNZWtWUFZubjlab2JyVlJUR3RTb21G?=
 =?utf-8?B?T0s4MWdiRU13bllpclFmeVJNcUJnUklzT05QNTRwTlVNUXhqNGZmOC9ua01J?=
 =?utf-8?B?aENEVm82VWN5WnNGOXZFUjlnemlJTkp5WW9WZElMd3hFZno0MmFnTXFUMXY1?=
 =?utf-8?B?MXRZT2YrT2s2a0JIMm83VTRCbUJmQ2UxbURqZ2psTlBRMExtc2xqdXN2cGtI?=
 =?utf-8?B?L3BseWpFRm8yV050eUZMTW1QN0Nxdk82LzlNbi91czBXK2pZcDFPZ2NpTVBx?=
 =?utf-8?B?ZDliWVMyU0Z1YWMxVG03K1V4cXZ1OVZxbzEybDJmVmdjN3pmQXVrMGpsUkw0?=
 =?utf-8?B?OERrNm9ZNlF6TUx2Y3lMT1pVQnczM0lUclkwVG4rK1BobEJaZE9BN0pNaGtT?=
 =?utf-8?B?WEUzejFsMmhvUnhnOFZFWWtwYWRZcDRiSWRCQWs1eDA1eVl5enQxWlM1K0VI?=
 =?utf-8?B?R25MS1FXYWZwK01iRnYrTHpRZVd2Wjk1WlNPcTdJV3c1YnR3azROZGphN1gv?=
 =?utf-8?B?bXplRm5BU3U3a3JQQU8rMGplbFBaQ2orakkra1FuOWVZYlJUNjVpV1RnNEQv?=
 =?utf-8?B?YkNaUnlEbDc4RWhlc0l5dWRaWG9sdUozdEl3dWlhWm5sOExsRVExME5LOEZJ?=
 =?utf-8?B?TUsrMWFDVXBPMW1NREoyd3lQZjJIKzFNb1YxVFNQYkdIMU9Pd1AvVy9QazFC?=
 =?utf-8?B?UlB3Ui9HaW5kWTJ3eWxIR0NKekZ5R0xzK1B1N1BJVDVQRUN4aGR1QTJrYnJj?=
 =?utf-8?B?TmV6dHh4WFZRMlBRLzRrbzc2dkZkejBrRjJNKzhNRDlIVUJmNEoxNFBPeUxX?=
 =?utf-8?Q?A2/mD/wfXi3WZZxChsSZkPyUC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: x/IzRKY3vHVX6W2q+RhO65IE/2mJTg79ec0/uFoC5/Dc0VtIr7csaKwt6DrS9MA3Lzwy0rOBKptTpwREmFBMquG6XBHHiKFihdI5srEZjyn4+qpDWbUhau2FtJEWRknajamMfUhPALH9klACXufdGi2f6MIutxO+h2vsCLZ3/l5khGP1lZN5YDIcl4ga5P0gTTwEyjmZHEs67zB3tTKcWBfEh4/aDqNqLjxz5efaayQ/K3fNEHUOtY6G8K7878eXiV6X9ECZuw4TRJePXQXiptjtdzRbnBaukYbNDlaIDDb5vd9jpV4ztqe6vPAen72LhhFXYWahRFxZS2N1DUIM+u3kp2J3rjwcPFXRkS4zk+1egsT99wCvEl2wVUTXk0mGwkecLuF/6LdjANxkJd5QlGgsTs+Vl+QTNJyBrhJ38juTPGk53Q00ouabgsGVkWbLbAX23V3H+BCU3Ewzm3C7BqwUWtwkXqfGAcZFuO+jcMseCw5kiDHbFjI/zOu5nw/TT8Leqq8hLLxWuGq1Z7Iip/qkqt26cRWxXFdYJYifIy1M40Aho2eYMx6I+Jr2kt3BteyisfEvlvmQ66MPuWH9bmv5GdbNMcA+ZBXZCoAAZjYcF5+Ld8y94cOTaBTn2zg9z9hCZ+K5v00Mt+fk0QlX6lU3WT+xn2cH/h6sBgISQ1PeVcmKCKYS3/QnC1Usaw2lzS6ckqfn+YcYSq+eOaVdwaGftjsHqtvr6ebqae/EZkIFAU/tl/Xxvr1LLkcSFIxud/xAn6M54pcMrUqx5EsXvEV9QsXYPlg3SLIFmSbqFC5NKmyWDkmGerfg/2B8i9kGr9rJfzybBXksbTgM3WP1U5cp4SLemMwozn+Wrjr9/Oo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fb4935-919f-4850-1e40-08dbbb8798bb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 16:18:46.3114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDioJ1qXkjq4Cqpbi3Fk1ievBK/TxcLHf+d7Zpfo+iBoSLtIxPXTSD2P+05k06uVfVIlqdYLmQ8EoMHamI5ILKAxSY8mhakURDp3O1+SDeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7665
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_14,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220141
X-Proofpoint-GUID: T3z-wC8uC7v59BgTghYuHu6X63UNB6bx
X-Proofpoint-ORIG-GUID: T3z-wC8uC7v59BgTghYuHu6X63UNB6bx
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/22/23 16:30, Yazen Ghannam wrote:
> On 9/22/23 4:36 AM, William Roche wrote:
>> On 9/21/23 19:41, Yazen Ghannam wrote:
>>> [...]
>>> Also, during page migration, does the data flow through the CPU core?
>>> Sorry for the basic question. I haven't done a lot with virtualization.
>>
>> Yes, in most cases (with the exception of RDMA) the data flow through
>> the CPU cores because the migration verifies if the area to transfer has
>> some empty pages.
>>
> 
> If the CPU moves the memory, then the data will pass through the core/L1
> caches, correct? If so, then this will result in a MCE/poison
> consumption/AR event in that core.

That's the entire point of this other patch I was referring to:
  "Qemu crashes on VM migration after an handled memory error"
an example of a direct link:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg990803.html

The idea is to skip the pages we know are poisoned -- so we have a
chance to complete the migration without getting AR events :)

> 
> So it seems to me that migration will always cause an AR event, and the
> gap you describe will not occur. Does this make sense? Sorry if I
> misunderstood.
> 
> In general, the hardware is designed to detect and mark poison, and to
> not let poison escape a system undetected. In the strictest case, the
> hardware will perform a system reset if poison is leaving the system. In
> a more graceful case, the hardware will continue to pass the poison
> marker with the data, so the destination hardware will receive it. In
> both cases, the goal is to avoid silent data corruption, and to do so in
> the hardware, i.e. without relying on firmware or software management.
> The hardware designers are very keen on this point.

For the moment virtualization needs *several* enhancements just to deal
with memory errors -- what we are currently trying to fix is a good
example of that !

> 
> BTW, the RDMA case will need further discussion. I *think* this would
> fall under the "strictest" case. And likely, CPU-based migration will
> also. But I think we can test this and find out. :)

The test has been done, and showed that the RDMA migration is failing
when poison exists.
But we are discussing aspects that are probably too far from our main
topic here.

> 
>>>
>>> Please note that current AMD systems use an internal poison marker on
>>> memory. This cannot be cleared through normal memory operations. The
>>> only exception, I think, is to use the CLZERO instruction. This will
>>> completely wipe a cacheline including metadata like poison, etc.
>>>
>>> So the hardware should not (by design) loose track of poisoned data.
>>
>> This would be better, but virtualization migration currently looses
>> track of this.
>> Which is not a problem for VMs where the kernel took note of the poison
>> and keeps track of it. Because this kernel will handle the poison
>> locations it knows about, signaling when these poisoned locations are
>> touched.
>>
> 
> Can you please elaborate on this? I would expect the host kernel to do
> all the physical, including poison, memory management.

Yes, the host kernel does that, and the VM kernel too for its own
address space.

> 
> Or do you mean in the nested poison case like this?
> 1) The host detects an "AO/deferred" error.

The host Kernel is notified by the hardware of an SRAO/deferred error

> 2) The host can try to recover the memory, if clean, etc.

 From my understanding, this is an uncorrectable error, standard case
Kernel can't "clean" the error, but keeps track of it and tries to
signal the user of the impacted memory page every-time it's needed.

> 3) Otherwise, the host passes the error info, with "AO/deferred" severity
> to the guest.

Yes, in the case of a guest VM impacted, qemu asked to be informed of AO
events, so that the host kernel should signal it to qemu. Qemu than
relays the information (creating a virtual MCE event) that the VM Kernel
receives and deals with.

> 4) The guest, in nested fashion, can try to recover the memory, if
> clean, etc. Or signal its own processes with the AO SIGBUS.

Here again there is no recovery: The VM kernel does the same thing as
the host kernel: memory management, possible signals, etc...


>>> An enhancement will be to take the MCA error information collected
>>> during the interrupt and extract useful data. For example, we'll need to
>>> translate the reported address to a system physical address that can be
>>> mapped to a page.
>>
>> This would be great, as it would mean that a kernel running in a VM can
>> get notified too.
>>
> 
> Yes, I agree.
> 
>>>
>>> Once we have the page, then we can decide how we want to signal the
>>> process(es). We could get a deferred/AO error in the host, and signal the
>>> guest with an AR. So the guest handling could be the same in both cases. >
>>> Would this be okay? Or is it important that the guest can distinguish
>>> between the A0/AR cases?
>>
>>
>> SIGBUS/BUS_MCEERR_AO and BUS_MCEERR_AR are not interchangeable, it is
>> important to distinguish them.
>> AO is an asynchronous signal that is only generated when the process
>> asked for it -- indicating that an error has been detected in its
>> address space but hasn't been touched yet.
>> Most of the processes don't care about that (and don't get notified),
>> they just continue to run, if the poisoned area is not touched, great.
>> Otherwise a BUS_MCEERR_AR signal is generated when the area is touched,
>> indicating that the execution thread can't access the location.
>>
> 
> Yes, understood.
> 
>>
>>> IOW, will guests have their own policies on
>>> when to take action? Or is it more about allowing the guest to handle
>>> the error less urgently?
>>
>> Yes to both questions. Any process can indicate if it is interested to
>> be "early killed on MCE" or not. See proc(5) man page about
>> /proc/sys/vm/memory_failure_early_kill, and prctl(2) about
>> PR_MCE_KILL/PR_MCE_KILL_GET. Such a process could take actions before
>> it's too late and it would need the poisoned data.
>>
> 
> Yes, agree. I think the "nested" case above would fall under this. Also,
> an application, or software stack, with complex memory management could
> benefit.

Sure -- some databases already take advantage of this mechanism for
example too ;)

>> In other words, having the AMD kernel to generate SIGBUS/BUS_MCEERR_AO
>> signals and making AMD qemu able to relay them to the VM kernel would
>> make things better for AMD platforms ;)
>>
> 
> Yes, I agree. :)

So according to me, for the moment we should integrate the 3 proposed
patches, and continue to work to make:
  - the AMD kernel deal better with SRAO both on the host
    and the VM sides,
  - in relationship with another qemu enhancement to relay the
    BUS_MCEERR_AO signal so that the VM kernel deals with it too.

The reason why I started this conversation was to know if there would be
a simple way to already informed the VM kernel of an AO signal (without
crashing it) even if it is not yet able to relay the event to its own
processes. But this would prepare qemu so that when the kernel is
enhanced, it may not be necessary to modify qemu again.

The patches we are currently focusing on (Fix MCE handling on AMD hosts)
help to better deal with BUS_MCEERR_AR signal instead of crashing --
this looks like a necessary step to me.

HTH,
William.

