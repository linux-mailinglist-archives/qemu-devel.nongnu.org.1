Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E86D47E0A6F
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 21:42:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qz0yv-0004P0-9M; Fri, 03 Nov 2023 16:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qz0yr-0004OL-12
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 16:41:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qz0ye-0006np-Vz
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 16:41:24 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A3G7OKi006563; Fri, 3 Nov 2023 20:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=TjH/ATRrrNBt1PxYoqRRloBcocL7pS8vdvPsgXr/To0=;
 b=stfaexP7+yJ87xbKF8L2MtsTrWARixY5CI/+RX/QSxbTOtTFsKvaUjyCWViQ+5/fI9P+
 noajGBaSxQDlnCa4KuGgOWgFR91T7441FNvvpKiqnyohmqFVpZ7FHy64vmw7vwE3kmql
 Q7cIHHcVPVjctf0vMkGbBHtjqOSdBBspXcJsAPUEN2ShH48rqbKRgxb1iQS127UzEG5v
 EF6nyPUHAfO6iMC2VTFWdf5SCbwyoYSWzxihoL1drdS0rGpX0bWQFl+L+0f7dlxFWQxi
 cA2tffJhpGYdqtncqe6sIyLrmd6cyo+MT1XQPBy5VbnQulAIKWnxOJZaHncQqfqL43RQ Iw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tuumsgd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Nov 2023 20:41:05 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A3JHWkK013502; Fri, 3 Nov 2023 20:41:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3u0rrgv8rg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Nov 2023 20:41:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S95lzUUnC0kkYLHH/bYxElmsmHWhPb037UFVcPmXJAinlXJrSsty6lkVIr5uN5tVlDqG6Jb+aS1+17nbwSY1kZCV/XIVLSbJJo5rTrVR+zYmZzgQeYxRGkDySmfLVFfsERDyb+E9WNKiN5NbcwAxsqEPDzWoN4omoYpTq3E65pInwWkcP0XhcfJH+vabmWYfXtqN3YGFRy+MrtyPMzJPG7cGFOAnna2mEjA20fmLsj1RCdP4mGPSJDkmDb5v7ghRok5ZKNCkKoV7MPzC7HHJlguaYreDq2+l7QdxS4yijms/c6W/d+y1IncGP4llhGj47AzaFD8DizL3sQkpS5gjAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjH/ATRrrNBt1PxYoqRRloBcocL7pS8vdvPsgXr/To0=;
 b=WYVCx/mkRJHJZlefZApqFZhjwGjDhKREeTJDyvZ0OIS/MKHi3Qxx2stvgI7LauWvNhrHAJFlbbDWeQ+ztAWXmsp3rHEN3mjpVEvS84UMF0TqMfr0dYhXpXvemmvkShqcHCvR2zNBG+/wEdQ93oyTfCIhRPEmQeG2v75sztggNGfq5hegPWCMYk4M22aB4YWuE+jNz8OxeDbWQnPU8H430oxxeUgoewbykzcX0kCMbJfy6zbyU8edJ72QergWGgWnGR5ieWGBTMuYF49Bw8C/ehbAjS40WBcqfeUsWK7Tfu/kcv+b5NG+R2Yh4LElEi6+VSRAe9aqIMTK2DAv+q27Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjH/ATRrrNBt1PxYoqRRloBcocL7pS8vdvPsgXr/To0=;
 b=lBDGjwhjhUH9TNWcwRwa8WOM9/+twyBlOr7ucXsMczne/rb1xgjE7lNZEGe2zltsM/vWIlfuijiLRO5c/bL3z+u775LzDAhPrONZeesA3+Bno0522jt2RVNfLuIkW2QjyVyGv5FmcacUN6j6gej+fDshg0VdXB/x0pWfonZxCFU=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BN0PR10MB4919.namprd10.prod.outlook.com (2603:10b6:408:129::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.24; Fri, 3 Nov
 2023 20:41:01 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930%4]) with mapi id 15.20.6954.019; Fri, 3 Nov 2023
 20:41:01 +0000
Message-ID: <52bfb600-63e4-42d4-9278-fa8cd5271460@oracle.com>
Date: Fri, 3 Nov 2023 13:40:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/18] Map memory at destination .load_setup in
 vDPA-net migration
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
Cc: Shannon <shannon.nelson@amd.com>, Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, yin31149@gmail.com,
 Jason Wang <jasowang@redhat.com>, Yajun Wu <yajunw@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Lei Yang <leiyang@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gautam Dawar <gdawar@xilinx.com>
References: <20231019143455.2377694-1-eperezma@redhat.com>
 <1e565b27-2897-4063-8eff-e42cfd5934c2@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1e565b27-2897-4063-8eff-e42cfd5934c2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::28) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BN0PR10MB4919:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e7289a-1600-4d09-8c25-08dbdcad30e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nvi8dMRpV11CeTxQj/4BZ+ti0yCcQ218sombv16XVjxDK2Az3xVr43lwlKu1400s4OIKdZeEyqSv3VUKkOBnr2WsXV26ln4AYMWmOz4qz5MMLco/98qnJUbBGKL381nHDU5Yve9A0SF1WP48K/8oAvj6Iil7fy2T/76khKBwQGtd55OXqqscrz5yOEFoZ08vx+C8w1oJ0qXyM6NMlRYNkRnTbyj0oozYsAT8vo1TmEtbMrQXJH7FFVyLGzRCUmtjfrboxGyX4dXw4BuBCsPwZrieFVcdr8rUWtxGjY3hKaErMLIwjNXed9SBJa4HWQtIKd5hEOWkkZzInwoPeDEcNxg/h8lEjlOV1DBUcw/PixcteoguBXpuq5tolmvVt12zCa2qEccLj+XOJqw8jFPcEF1JXvIl4q3gOvOq4R4g9r6z9CTjdajajOl+uLZbLlxEljgdDqGjlVdObLwB/DB7oFl7fSS2P4FrLIQdQcDd1GhSCGQPN1wPqwe6fmIk7HXoGm/KB5cknnTx+/qOjyxsGQr5fD61JEYRyei2Xu4UHLseDaohYv3bQwsyDGoIok+QPeuoUrVa+D4ML+0R9RiOWvYOURamkxuNF15pBgVFv0XadJlp/eqVvmO2dBu2s9b6KgqqqK4kWOTuaUodEo8gkSEoLFbgOSMJq3/g/9tj1S4Xmp/zc9vkxXy/4z1UKvyPLZu87HSd5+7XOvxBtcqEUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(7416002)(83380400001)(38100700002)(2906002)(36756003)(8676002)(8936002)(4326008)(66574015)(41300700001)(5660300002)(66899024)(66946007)(86362001)(66556008)(66476007)(31696002)(316002)(54906003)(966005)(31686004)(6666004)(6512007)(6506007)(53546011)(478600001)(36916002)(6486002)(26005)(2616005)(142923001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2hHS0ZjaEZNZXRMOSt2enpZYzZnSkVwYzlYVW9VbjlvazZWbENnS3dZblFq?=
 =?utf-8?B?NFQ1YnlEc1V4Um5LQlZNLzhnU0FtS0tPRTBZUjlUZ0JMUlVzQ1MxaW9nZUc3?=
 =?utf-8?B?bnZFUkdhQkJjazErZm1FR1lweHlFRFVKZ0N1WlhvT0R0TUs1alZyR012UVJx?=
 =?utf-8?B?UlV6RXhEZWFRWnljQUJQUE9VZ1RIM3IvOUdWT3N0MVlZanRhblpBVWpOaVJo?=
 =?utf-8?B?RVpwclBJMUdEMzl0azZHZ3N0SU14bDFWM1RzWmJDY0svMVFCbElNL2hjRXBN?=
 =?utf-8?B?by9oQkJKQTVPTStOMnRVQ285VkJydHg0LzVYSzBTN1cxNGFjRStPSW9GZnZL?=
 =?utf-8?B?UDFRQXVlR1BBcW5WSGFBaC9XWHBlc29CdVlZcW55elkvbWM3U2cxeGwrTGY0?=
 =?utf-8?B?dVB0NkoydHpUVzVEcVo5NGRSdFVNNS9WTzBJR3Zyc3JIc3ViUnRGY3hVNGFO?=
 =?utf-8?B?dlZxRjVrWmpGV0FDU2JMRnFWTk5JRk9nSCtYZDZmVVYxakZYWk5qRkpFVDZZ?=
 =?utf-8?B?UFZsQ0NFMmpmd1dtVFd4bXFSRlQxanMyV3dzNUxHaHZOZjNickhJUjJuMHEv?=
 =?utf-8?B?Qnd0T1p2RGttdXFqSlRTQTRhREdFdWUyNllqa3p1WUlnbDRoaGxvK3Z5N0ta?=
 =?utf-8?B?VUdqNkMxRzhlZHdJWEV1aWZzd1RsUW93Q3Z3M3JhbE1vT2lrM0RkcVR4cG1C?=
 =?utf-8?B?dWp5U3oycmFMdVB1ZlpHMTYwdmdvb3ZrbTNvTWRaRFUwNm11RVQ5OUZxNVVz?=
 =?utf-8?B?TzgrOWFzSkJTV25lQkZ3MzhhaEFXek5NU1BVdFJ0d2VQcXBEelBUUjZJbytR?=
 =?utf-8?B?RFpRcmhVb2s1SGNUSzJXT1FsU25rVUUwY29oRVpVTmZWazNrT05PRFg5ZjUy?=
 =?utf-8?B?WGIzOFpzUjhBTFlPb0VIOVNmU0laenNmU1ZVd1Y1cTQxRHRwSHBSTmNQM2Qv?=
 =?utf-8?B?czM4dTRyL1hTaVJzbFNrL1NHYklYdi9BWnk1UGZVeVNtZm1RWFRiang2Rloy?=
 =?utf-8?B?bWhYZlJiMkEwUzlsZzBoYnZsKzV3bEt6enlTampvRGxtbWVMTFJOTG1QS2hi?=
 =?utf-8?B?RnBiR01JWkxCQmEyZ2VLeDFtMG05RHA2MmZ5TW1za2tWN3lSMk1jQkhrZ041?=
 =?utf-8?B?RkZ4TFJOVnBHSFJHSHhUdHVCN3AzK1NwcXkrcFZ0TXJ0N2pLWVZWcnU3UlFH?=
 =?utf-8?B?eGdoYUV2bE9DMy8reGcyYXMvcm9iMkJGaVJRays0U2F2MVArWTJVVld4cCsx?=
 =?utf-8?B?eEpiWnVoOGdYTkRnSTI2Y1ZpMUdQMDRkdlljTm5tNjcyYTU5eWwyM2Vqc2hJ?=
 =?utf-8?B?Y25idWpPT2NpZEoyZjVBS1hyVXIwYXljT2pEdXhQOER6WXhyMjcwZXlMZ3B1?=
 =?utf-8?B?eGtEWm9PU2pDeHZ0ZHpjaXBWTEluK2RBV1NtdElWM3VBdWZKd0VLcTNTdWNn?=
 =?utf-8?B?WENHdUFrRGxhdmd6NXFnTDlZZ2tXM2NWWUEzM3FZZndMR3EwZGtYWkRVWnZn?=
 =?utf-8?B?UEdndm95OWgwMUdCY2NpeVUybmthRGgxWUJCTEF0MVBON29PYnBFbzhVdVpG?=
 =?utf-8?B?eFVab2paS3R2M1dNRWVsT055T0VHLzJVV0FXRDdFTHkzWVFQSGMvWlZ5VHov?=
 =?utf-8?B?Z3NIdUpmUHBXbkFMTFJaZWlNMHNlU1RTWENMVkFvMGlLZWpiVEJxMmFYRGRl?=
 =?utf-8?B?YU5ETk9BdUhIRDNOYU02eG1XYjczdzN0eDNqSzJDM0k5eFord1MyUGJBa2ww?=
 =?utf-8?B?UmFPSFh4L2RaNWdRYUlYdlBLUjN3ZzlJZHhHNSttWnVOWkJhMzM0dmY2TnJw?=
 =?utf-8?B?U3p6YlRyc0pvYmYyTHBQZGh1U0VjNTdBMUlRSStPQnlUdllEamd6NXRib2lR?=
 =?utf-8?B?UmhyWXJGMG9MdmpWaVNyOXFwdDJUWEphK0JFNy9vYnJuWVdzOWNuSjl0bTNY?=
 =?utf-8?B?U3JOUk9DTSt6T0tUZXVMWmFxcUhUTG1vTDJRa1ZUNjdtV0p4MHc1VHhIdVZE?=
 =?utf-8?B?OFJHcldDVDlTdXZPVzdOd25kUS9WMGR0V0JkUzJ5SE9zOXFENjZDME1OaGRz?=
 =?utf-8?B?ZjJ4blNBdk9yREdsOElPYWxnN1dmQ1F0Z21GVmVWSEdGVkRqdmRNOGlUeVJm?=
 =?utf-8?Q?9EZf6VnVTFkz+zhQHFv30uk/U?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?LzY0QndBakxlVUdCTnlJMDRTVFBlcnBVWlJPbTR5UFZWb1FQWXpxTDZpWFM0?=
 =?utf-8?B?MkZibFVHbmdwcEJQd0l5V05VU1o4T28wQWpSQ3JINkJXL1FCc1hkWGxuamtT?=
 =?utf-8?B?VjlOTDFjMWZRMDZQa2J1MXc0UHI4YURWNE1ST2QzZGNvWnJEU3lqMllBR2RK?=
 =?utf-8?B?WU9sdzFDcHdHNXJWVmFrMERURHBORWpqOGZFOVFnQlY0Wkg1QnRzK0FJUGZr?=
 =?utf-8?B?blV6QkwyMXB3VEY0U3ZwSVRERkwvOE9EU1hCSERpWDczYW1obEg4cWJaMUZN?=
 =?utf-8?B?NXlldG5YeXg1ZkkwZlNoRk4wcjhNVjE3YjFjR2ZGSExyWm9LcldjWDFkbk1C?=
 =?utf-8?B?cFVydFFLaGRpL0RiVzZZSW5oYlB4encxNEhqYUNUUk02WUZPOW93b0gwZGQx?=
 =?utf-8?B?TGFadGY2TjFranRSTzJhQlNoY1poMkNFbThJelpqZ0lJbkNoQ25uNWxZYlEx?=
 =?utf-8?B?MVZ4Y0FOTUNQcHF0Q2R4RnlXM2NQUEV4SEo1M1J2b00vcEIzL1dkcDRwUTND?=
 =?utf-8?B?UVNtMDE2cUZZSDVadE1QNjk4UHVNdGpMcStkd0lBZTVMdUpnK3Z3MjZxWi9C?=
 =?utf-8?B?aElaSlowTVp4blAvMWNOVUlla0xXR2hzZndab2R5QzZkRWdMMFEyQnZGdG9i?=
 =?utf-8?B?U0VxSnVtbTJzd0RTNEhFeklmeDNDb1lobW1pdWw4OTV3MmlTV0V6TEY5d041?=
 =?utf-8?B?R25ubHZPNGRLVlVMd0wwNVlZOFp4eGVONExnL3hMcXlLbWNuTVpHMHh6QjRQ?=
 =?utf-8?B?aDRtK2N2eGZ2ZEYrWTBLanNiaUZDclZ5TVBWT2dRTm90d01WRFdRRjNzRnlu?=
 =?utf-8?B?eEpoMWxxd05JN3RWUWtQckRvbmYxRVZOYnFWSmx0ZU0rV281akI3STJBdHpU?=
 =?utf-8?B?dHNBemJ1U0EzUlUza0s1aTRXZUZXVG1wQm4xWnAwZGExNXdGckUvRHBVUEVI?=
 =?utf-8?B?WkxvT3MwL1pmVnlmK0NtZDlubUxSRVVTMmlUdWllazhoN0hIRG16TlI1cnZF?=
 =?utf-8?B?SDNWU3VXd0hjczhQa3IxYTJBdWRac2MyOGVsZUhRMTY4TlVnNE1CNy96WFBO?=
 =?utf-8?B?akozem5PeUY3Q2RQUjVDNTI3NlFDV29STDBXamF0U255MTFzOWlJOHB0OFR0?=
 =?utf-8?B?Sm9tMXdJRVJXcW9sUnZnZTM3ZXJDdmVlak50MW9MczF5N3NzMmxSYStDbmx1?=
 =?utf-8?B?LzltbXU0eEpBOWZXbnV1UmpaUjlJalpEWHM4V25BVnQvWXBQZVY5QTEyRFFq?=
 =?utf-8?Q?mlQkL3lbL5giynr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e7289a-1600-4d09-8c25-08dbdcad30e3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 20:41:01.1924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cX1tz0VBCyi1w+QgwZJIcCNaETrTkQLuZBLVOgqldMnYsQ+8hPqSa5wh0D9A5mazYOKrGKhfUNVE6/M0aIVBuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4919
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_19,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311030174
X-Proofpoint-GUID: hvswubajPc_Sag1qVOFIaKP9r5iAyyki
X-Proofpoint-ORIG-GUID: hvswubajPc_Sag1qVOFIaKP9r5iAyyki
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 11/2/2023 3:12 AM, Si-Wei Liu wrote:
>
>
> On 10/19/2023 7:34 AM, Eugenio Pérez wrote:
>> Current memory operations like pinning may take a lot of time at the
>>
>> destination.  Currently they are done after the source of the 
>> migration is
>>
>> stopped, and before the workload is resumed at the destination. This 
>> is a
>>
>> period where neigher traffic can flow, nor the VM workload can continue
>>
>> (downtime).
>>
>>
>>
>> We can do better as we know the memory layout of the guest RAM at the
>>
>> destination from the moment the migration starts.  Moving that 
>> operation allows
>>
>> QEMU to communicate the kernel the maps while the workload is still 
>> running in
>>
>> the source, so Linux can start mapping them.  Ideally, all IOMMU is 
>> configured,
>>
>> but if the vDPA parent driver uses on-chip IOMMU and .set_map we're 
>> still
>>
>> saving all the pinning time.
> I get what you want to say, though not sure how pinning is relevant to 
> on-chip IOMMU and .set_map here, essentially pinning is required for 
> all parent vdpa drivers that perform DMA hence don't want VM pages to 
> move around.
>>
>>
>>
>> Note that further devices setup at the end of the migration may alter 
>> the guest
>>
>> memory layout. But same as the previous point, many operations are 
>> still done
>>
>> incrementally, like memory pinning, so we're saving time anyway.
>>
>>
>>
>> The first bunch of patches just reorganizes the code, so memory related
>>
>> operation parameters are shared between all vhost_vdpa devices. This is
>>
>> because the destination does not know what vhost_vdpa struct will 
>> have the
>>
>> registered listener member, so it is easier to place them in a shared 
>> struct
>>
>> rather to keep them in vhost_vdpa struct.  Future version may squash 
>> or omit
>>
>> these patches.
> It looks this VhostVDPAShared facility (patch 1-13) is also what I 
> need in my SVQ descriptor group series [*], for which I've built 
> similar construct there. If possible please try to merge this in ASAP. 
> I'll rework my series on top of that.
>
> [*] 
> https://github.com/siwliu-kernel/qemu/commit/813518354af5ee8a6e867b2bf7dff3d6004fbcd5
>
>>
>>
>>
>> Only tested with vdpa_sim. I'm sending this before full benchmark, as 
>> some work
>>
>> like [1] can be based on it, and Si-Wei agreed on benchmark this 
>> series with
>>
>> his experience.
> Haven't done the full benchmark compared to pre-map at destination yet,
Hi Eugenio,

I just notice one thing that affects the performance benchmark for this 
series in terms of migration total_time (to be fair, it's mlx5_vdpa 
specific). It looks like iotlb map batching is not acked (via 
vhost_vdpa_set_backend_cap) at the point of vhost-vdpa_load_setup, 
effectively causing quite extensive time spent on hundreds of dma_map 
calls from listener_register().  While the equivalent code had been 
implemented in my destination pre-map patch [1]. Although I can 
benchmark the current patchset by remove batching from my code, I guess 
that's not the goal of this benchmark, right?

If would be the best to have map batching in place, so benchmark for 
both options could match. What do you think?

Thanks,
-Siwei

[1]
https://github.com/siwliu-kernel/qemu/commit/0ce225b0c7e618163ea09da3846c93c4de2f85ed#diff-45489c6f25dc36fd84e1cd28cbf3b8ff03301e2d24dadb6d1c334c9e8f14c00cR639

> though an observation is that the destination QEMU seems very easy to 
> get stuck for very long time while in mid of pinning pages. During 
> this period, any client doing read-only QMP query or executing HMP 
> info command got frozen indefinitely (subject to how large size the 
> memory is being pinned). Is it possible to unblock those QMP request 
> or HMP command from being executed (at least the read-only ones) while 
> in migration? Yield from the load_setup corourtine and spawn another 
> thread?
>
> Having said, not sure if .load_setup is a good fit for what we want to 
> do. Searching all current users of .load_setup, either the job can be 
> done instantly or the task is time bound without trapping into kernel 
> for too long. Maybe pinning is too special use case here...
>
> -Siwei
>>
>>
>>
>> Future directions on top of this series may include:
>>
>> * Iterative migration of virtio-net devices, as it may reduce 
>> downtime per [1].
>>
>>    vhost-vdpa net can apply the configuration through CVQ in the 
>> destination
>>
>>    while the source is still migrating.
>>
>> * Move more things ahead of migration time, like DRIVER_OK.
>>
>> * Check that the devices of the destination are valid, and cancel the 
>> migration
>>
>>    in case it is not.
>>
>>
>>
>> [1] 
>> https://lore.kernel.org/qemu-devel/6c8ebb97-d546-3f1c-4cdd-54e23a566f61@nvidia.com/T/
>>
>>
>>
>> Eugenio Pérez (18):
>>
>>    vdpa: add VhostVDPAShared
>>
>>    vdpa: move iova tree to the shared struct
>>
>>    vdpa: move iova_range to vhost_vdpa_shared
>>
>>    vdpa: move shadow_data to vhost_vdpa_shared
>>
>>    vdpa: use vdpa shared for tracing
>>
>>    vdpa: move file descriptor to vhost_vdpa_shared
>>
>>    vdpa: move iotlb_batch_begin_sent to vhost_vdpa_shared
>>
>>    vdpa: move backend_cap to vhost_vdpa_shared
>>
>>    vdpa: remove msg type of vhost_vdpa
>>
>>    vdpa: move iommu_list to vhost_vdpa_shared
>>
>>    vdpa: use VhostVDPAShared in vdpa_dma_map and unmap
>>
>>    vdpa: use dev_shared in vdpa_iommu
>>
>>    vdpa: move memory listener to vhost_vdpa_shared
>>
>>    vdpa: do not set virtio status bits if unneeded
>>
>>    vdpa: add vhost_vdpa_load_setup
>>
>>    vdpa: add vhost_vdpa_net_load_setup NetClient callback
>>
>>    vdpa: use shadow_data instead of first device v->shadow_vqs_enabled
>>
>>    virtio_net: register incremental migration handlers
>>
>>
>>
>>   include/hw/virtio/vhost-vdpa.h |  43 +++++---
>>
>>   include/net/net.h              |   4 +
>>
>>   hw/net/virtio-net.c            |  23 +++++
>>
>>   hw/virtio/vdpa-dev.c           |   7 +-
>>
>>   hw/virtio/vhost-vdpa.c         | 183 ++++++++++++++++++---------------
>>
>>   net/vhost-vdpa.c               | 127 ++++++++++++-----------
>>
>>   hw/virtio/trace-events         |  14 +--
>>
>>   7 files changed, 239 insertions(+), 162 deletions(-)
>>
>>
>>
>


