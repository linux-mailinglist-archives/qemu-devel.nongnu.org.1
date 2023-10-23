Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0310C7D3F40
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:31:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzgp-0007HX-2w; Mon, 23 Oct 2023 14:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1quzgk-0007HK-R9
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:30:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1quzgi-0002lG-Q7
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:30:06 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39NHwoa4027108; Mon, 23 Oct 2023 18:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=QlroOOL1b4O6aefp6gvDdzsRwbLUFuzhUsjPAsuQm3s=;
 b=c/T5lL7I/+osRUn+4+Y11YFloj2fnIxSb9emBwUuyx+uJnGrv/r8ipPVq07fzvKK8EN2
 /eBmB27e25OvEuryAJru4DMm3GrQcrZl0V2AlLrONoR3g3+b8GkJomfePgPx7efKH8h6
 xUaX911kRpRa25ZVrZ1IgKRnEvPAGUgv4qrZILmGxjOBPAfcxl0qNuSSOKmThMkX1R75
 lzgVxTHRth2K+qc98vYHCPlKIaiUrCO3g2RrGS6eYAxCgV00F2bR9s95e6RMHuOhkIKz
 zxRLbcRrEfY4ITpSYgfl2Mdb6FGDt+V+1wSGQECkcaQ3pkuZ5n52dPEwDsjUSe4XZaQ9 VA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv68tbtb6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Oct 2023 18:30:02 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39NHU5Zj031115; Mon, 23 Oct 2023 18:30:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tv53aub56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Oct 2023 18:30:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OA9sL/nLFDVFh7tDiILsgR8m+gcgSIByIVstnzgf4hLeRXuG17LcZhZ6oyRTJOJl0qiZI1dulGI/8bNEwxenjxRv4L7Wo0wB6cBCc7b3HovLm3gPv+HEgMlTL5myiBJMwAm7Wo3aTtwszaX2zuGLH7tmJrBDqaF9e2Fu8cer37VKqE8YHUvUZZ+4uNKHp9CQlqjSoVvC8qnekQqzPuagQVeFZCdDq/JtaVYCoF8AqQf7Euf0y3ghusjoCUt69WJfFYYZ0FyYi2pcCAtAUGiZS9zPGdHXCSCA1SS/vuBHK63nMay+obFpcQFJPz8Kwl/taqCvy9esu/c3bs1akifm6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlroOOL1b4O6aefp6gvDdzsRwbLUFuzhUsjPAsuQm3s=;
 b=LY2C+eZK85YP1WUUAHfZYHhjhwudBMP5Tio66Y9Lirz0HHlsSh6mr52ca0Ayl/l+UNKOCDjpmTOt75f35c8nm6MqSVshYUFLwI2Li02Czna2sWl8P06d2jLr2Qsw1ii/p34LSgKsqkJeXuJV0bEdtINQ398k9oYeOKAh7RIredc90eufEb93ogd4DvKJxZYIYe/wZS5sRJcGb3iCpUpV7zTXF6Brgvhe8XML2TIFPJzBArJFuCfFuusrB2qNEAbZAp1v0vpCKWbM2nsP5WUYvOHu8hQ7xzsf9wKsE6GO3NcZKpSEtYBHH6a1VRp1WgU37otAGwqSB4sj4wJgCoGVMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlroOOL1b4O6aefp6gvDdzsRwbLUFuzhUsjPAsuQm3s=;
 b=fQm5llucGd++FbSsxh5K5NVudpsK5Hm5/5xbV+lO7aKV2N8Aiclhcxp433PrYnsML5lE1xX1aeQHguchO85O4w0Ksh3N87bX1mEbKDVoeWYS8op5fzR0DQ3xhO6we07oGQ4kJV3YX6+Jl0E1PO+GhMVw5rVbKmucYLC06wmKG0s=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by IA1PR10MB5972.namprd10.prod.outlook.com (2603:10b6:208:3ec::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 18:30:00 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c305:4801:5bd7:4775]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c305:4801:5bd7:4775%4]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 18:29:59 +0000
Message-ID: <389959d5-6d15-4557-839b-575b43bd2ed4@oracle.com>
Date: Mon, 23 Oct 2023 14:29:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 4/4] cpr: reboot mode
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
 <1697748466-373230-5-git-send-email-steven.sistare@oracle.com>
 <ZTaTrEPcK2yU8MT5@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZTaTrEPcK2yU8MT5@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::29) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|IA1PR10MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: b7eec8ab-25ab-4411-3e16-08dbd3f610b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lNiy4bnz3DDhdupUlwgSAnBWiyxStySTmuOoz6J5gKleR9aUlw3Nk8sU/BTgJ2eBbJesj6uqi1Fdgvkll3pEXnlscHMNtNLf4NgabSI5XHWKvEvVEMCYAbEVuXNdVTIAutXv9iCWqGYf/k2n6pOts95yWOrnvhr6lY0i7cm4ahuB/uYgesWkkYLyBJ5CUg86Ppsa+yW+7HGpozctEcWeA8RO/l/e76B85A4Lm4WecJJWDjP7GzJzzJSqfoDJZLDgBjR3uxKaotCDDpAnMAM1UtBgOtgg0x27DDmNkrmclJw3yGTbJ7ttvTp34TEnh3qCr9tzWbgIEeFZXIGLFHiGk3z/QshE78342IeKoB0bGOSSCU99xGUQaAK3oAjN6yo/2pmVtjXhbGEYsOs3Lu5S14e4rcctNtaQTb7SO6H2z2KCJFyBL6rSsr+wIp3fFmfPR6W4HvuH002reafNHkvdA1aHv35SS1w2HsBaMQzTrilXleP6G8RaRC5Gx/rPlLjx4pjlj+nZFGCexzCMHeVEXOSqULpAUBSt74hykNDHqcyYQYNaVX5uV/T4s59xC6YjfYHPPInoXDOlzMyNVwrYgJz1DoVhZlInXbm/0jr1fmLIhGa2lQBlQu8prsUKeWfktbeG0QuiNBO278hKOeXXbVC2yisFG1FrHgoSePudcvI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(31686004)(2906002)(6506007)(5660300002)(41300700001)(86362001)(38100700002)(36756003)(83380400001)(31696002)(4326008)(44832011)(6512007)(36916002)(2616005)(26005)(53546011)(8676002)(8936002)(966005)(478600001)(66946007)(66476007)(316002)(6916009)(54906003)(66556008)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWh6a1U2eDZmS1pXODhJWC92NHVGb2FUcEtIam10TGhpY21ZMkJvSklZbkk2?=
 =?utf-8?B?aGlLVWx0ZUtOaXhnendOUFdnekRzVHI2WU9QcVdSdlBtZU1SdFNKdVVSN3NU?=
 =?utf-8?B?WExyYnJ4bi9zT1ljVFNCMDRrTGdHaksrQzJZY3NPWXZNWXMwQWpIRG1uQnpX?=
 =?utf-8?B?MGRFRC9qVU0xVUM3VEFSek9oS2l2Z0dZS3grSEttL05LbEV1RUk2VW0vamhU?=
 =?utf-8?B?SEczWnN5MmVPcUNmTmZ3U2JpNFB4c1RFemVqWmZ0dEV4cnAydHF3RVdKRnZC?=
 =?utf-8?B?TC9pT2djbXBCS2VqY01qWTlBZDNuS0NzZUw5aWxjSkJIT1dJNGxrem1qeXNh?=
 =?utf-8?B?L0NSb2xlOHJQcFNCazB3NDgwK09tVFlYRVpGR2EyRUdrajdBMGVxd1Y5eEE5?=
 =?utf-8?B?SktCL25RL0QvRlU2MGVtaFNxNnZLUG4vNDNWWW5jVnNYV2VrSFUxQ3ZDSFYr?=
 =?utf-8?B?TFl0M3RwY0prcFpha3cycGxsVzRmTmJsWDFIV0dpNDBCL3VhYzFwL0VTekh6?=
 =?utf-8?B?RENkTExRcHVnU2hPeUpGQnNTV1diN1FHOXhIUE5RSXJoN0JpTVNVMkQ2cnlQ?=
 =?utf-8?B?WTRGNTdpSHZmenpOOHhJVS9POFhEOEdpdnN3b3lIWGhMVXRTNzZHR2MwdUFv?=
 =?utf-8?B?QlNMaml4Q1dGNG4xWk01MUFybk1kNW12WmlZUEEwSUozeFpvbWFLM2VFUXdl?=
 =?utf-8?B?U2ViQjhXZkdPSHJOOW0xeTNsQlpxdHRpbkpBTlU1R0dpMDF5bXpNbkpWeVY1?=
 =?utf-8?B?cHpNVmh2RTRaSlhYSE1sQjk1SGJoY1h0K0NmWTRiUElwUjErTHZTQXVPZTZW?=
 =?utf-8?B?RzlFU2ZwWHJ1Z2REZVpHQXViRCtIZlo1M1FWV2FjOStlMEJtbkU0V1V6Vko2?=
 =?utf-8?B?WllYazdoQkhFQ3NyKzlFT21Od2swR0VWS0xKd3N3VjBrLzRhWFE2UnVTT2Mw?=
 =?utf-8?B?L0VLZHJvSHdFMDFpZlozdXRUbG1ycVE5Z0NEc01LNUVVRndXd3R5MU5HL2Jh?=
 =?utf-8?B?UU4yUW84RHppN2x2OEZibWlHWlJacDRHY1NRdWRKV2MzN3hWZXo5SjkzZzNw?=
 =?utf-8?B?RzRSOFAvQUoxeDM3elJtSFY0cnArQWwrWlR3ZDZ2TjlwWGxJWTJFdmtHeXMx?=
 =?utf-8?B?NHA2VzVyZ3laUjNTSUdGM3dRRERUbFFBa0IvMEYwS0hta3d4R3dwMlFsT1cx?=
 =?utf-8?B?di9zTVMvN1FyaFhqcTFtYm4yd0hjekNyR1A1dGwwMXAzSVRRWDhsZ1BQNEhK?=
 =?utf-8?B?NFhJVnN3d25VbFgwMVlySXM0Y2N5TnpyOHh5aVhwSjVMZUhicE5tNk1PWlBh?=
 =?utf-8?B?NHBWd0RjQkQ0ZU1YS3hMQUhMWXBwVENKT3VvdWwvSFc1d3JxcmtTRXllZ1BY?=
 =?utf-8?B?ZnpXTSsyWTYyM2llemZPYWl5cldBSU50aXpqczB2RTAwczhiOWoxRGJab0Qv?=
 =?utf-8?B?UjEyUnhZVUxlZUNYQ3JiOEJuNzR6OU1JbHZ4V2lWYjJ0Z1k0Qm15WW00d1J4?=
 =?utf-8?B?a1pjdDJKSERHN3YrMDYrRXZPVlU4VWIza0xIRHgwenRIL1E4ekJPQ1dVQktB?=
 =?utf-8?B?Y01FeEVmRitkaGtFSVRwcWxmMlBDYmJjYjVUUWJzNGZMbXp4M1hSbUsxVnQ5?=
 =?utf-8?B?WEVzQXFudU56WjZZZzI5dHREalJoMDQzUnY2VUlNUk44Z0taaW9ldUhJMVBP?=
 =?utf-8?B?VlRWRGlQNmZGT3o5TGhRWjZhQ0ZPOFBpOGRtWUdyR0tOVm84L1JOVkVhYWJE?=
 =?utf-8?B?ODBFaFRUcDVET2g3T2czQkNvWlIwNFBWS0prVVpoczREVEkrbXE4R09kU2Jr?=
 =?utf-8?B?TG5MajE2VzlYVzZmTDk3L2pSeHZ2b0JOK2pZdVRZUlNITzhVZjlqSk5neE1S?=
 =?utf-8?B?NW1qdWpYODB6cEZVRkR5SDEzdU1zb1lTZVpUMEtQZ0xIbW54NnV2S0VWdDNM?=
 =?utf-8?B?MlI5clF5SzFKZVUxZFZhWHZ6VWpsVmI1OHk3SWRyZnduTlh5aG0yaGZLL1la?=
 =?utf-8?B?SnJpVXUxdkpHNkFZS2tPTk1NWUdBWDVxMi8xa1NTdXF4T2M2QysvdHBKVW0w?=
 =?utf-8?B?S0taNzczdkVMMnBYNHVGcWtOWFo3RGhqWXh1THovdkRYbndPZFE5aWR0YnQz?=
 =?utf-8?B?M1k0N09CRFA0QjdzNE1wcS8wRDZSbmh4bTFFem8yYlBoSGl5ZWw5eXV3WXRC?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UDHYzWl3Igyz57RMH2c4T3Vlg/AOz2llH+RDWGROTzx7/9ke6GpgUCxrPeClxTCrt/GttXFOQNMgpMzhMn1PPt7GxBIegj5slxf0oSF850h+s77s5US3PJwbR3h/Y6C7tw2fSeM+vjO57rz4t30dWr2MN806uQJj0oF6gTn3DBF54nccFvkuK05iuz28xgC6u91fuuYkN0a7Ai5gLkQEcS4fPlQSuyVeYut3rqXJJKMfu10/N5bCAQqnL4nwTg5DOkwvLnXZu2cIm3uMar3IFVB1ow7qGJr0zbp+XLqxP2zpQum8g78a6r8/QldmYOfOzLsWMRwxDqkOq1n7Xz+UpAKSw41+fuJyPdGGYccxIiNId62lp/geyWdy9QJf8HrsbPxLyOGcfOWHkXOPTTxyTvliluNCFWdQJy7yR1Ii5C5s2IGuWC3hYuen+HnzhsVnWWIQPgcJdkmKCSLJ2tlF4QDzCX6JW+dvf9lmAW8pn+OKhgTOnhkVgvM20ebMF4mP+atPb5AL29Q4oloqXr9Bh1Cmc0LZeeAqVJY2IqgQF/4AhWt3MvkGOZcEQ8xobXPyAXuLJK0Ble/7bukvA+QkRfX4TJzkFQaINhZFF/LfJbJpkbz5VpXKm/0esuqfJgaHWZWJorbPsY8cqpdCkapbMPu8UfgOtNOjK8VNWS77z4/JWHbaDLSiF0rXCFdcXC385iVLzw0cLX3mVjLDQTdZMZ7WLjrBRb8WFk5Hdn6d+K+BxnFGHLGZOzhsgUjqHGLYM9HiEPLFfhZW8zK69tnYhJ2qpNdWld65/co4rzqxuWc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7eec8ab-25ab-4411-3e16-08dbd3f610b2
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 18:29:59.9806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0JNY2m4SnGI5KtE3bhrA7CJPO4GPQ+v9LE0wlaBc/Z2vwRRumrHvHhKTXeEgiORR4OGeX3gBBAvEJ7gbf0l3SMYmjal1K19zv89s2dd0Go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_17,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230161
X-Proofpoint-ORIG-GUID: XQz_pGKPuaDGGhZHGIhy5FvJ_jenoEqg
X-Proofpoint-GUID: XQz_pGKPuaDGGhZHGIhy5FvJ_jenoEqg
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

On 10/23/2023 11:39 AM, Peter Xu wrote:
> On Thu, Oct 19, 2023 at 01:47:46PM -0700, Steve Sistare wrote:
>> Add the cpr-reboot migration mode.  Usage:
>>
>> $ qemu-system-$arch -monitor stdio ...
>> QEMU 8.1.50 monitor - type 'help' for more information
>> (qemu) migrate_set_capability x-ignore-shared on
>> (qemu) migrate_set_parameter mode cpr-reboot
>> (qemu) migrate -d file:vm.state
>> (qemu) info status
>> VM status: paused (postmigrate)
>> (qemu) quit
>>
>> $ qemu-system-$arch -monitor stdio -incoming defer ...
>> QEMU 8.1.50 monitor - type 'help' for more information
>> (qemu) migrate_set_capability x-ignore-shared on
>> (qemu) migrate_set_parameter mode cpr-reboot
>> (qemu) migrate_incoming file:vm.state
>> (qemu) info status
>> VM status: running
>>
>> In this mode, the migrate command saves state to a file, allowing one
>> to quit qemu, reboot to an updated kernel, and restart an updated version
>> of qemu.  The caller must specify a migration URI that writes to and reads
>> from a file.  Unlike normal mode, the use of certain local storage options
>> does not block the migration, but the caller must not modify guest block
>> devices between the quit and restart.  The guest RAM memory-backend must
>> be shared, and the @x-ignore-shared migration capability must be set,
>> to avoid saving RAM to the file.  Guest RAM must be non-volatile across
>> reboot, such as by backing it with a dax device, but this is not enforced.
>> The restarted qemu arguments must match those used to initially start qemu,
>> plus the -incoming option.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  qapi/migration.json | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 184fb78..2d862fa 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -620,9 +620,23 @@
>>  #
>>  # @normal: the original form of migration. (since 8.2)
>>  #
>> +# @cpr-reboot: The migrate command saves state to a file, allowing one to
>> +#              quit qemu, reboot to an updated kernel, and restart an updated
>> +#              version of qemu.  The caller must specify a migration URI
>> +#              that writes to and reads from a file.  Unlike normal mode,
>> +#              the use of certain local storage options does not block the
>> +#              migration, but the caller must not modify guest block devices
>> +#              between the quit and restart.  The guest RAM memory-backend
>> +#              must be shared, and the @x-ignore-shared migration capability
>> +#              must be set, to avoid saving it to the file.  Guest RAM must
>> +#              be non-volatile across reboot, such as by backing it with
>> +#              a dax device, but this is not enforced.  The restarted qemu
>> +#              arguments must match those used to initially start qemu, plus
>> +#              the -incoming option. (since 8.2)
> 
> What happens if someone migrates with non-shared memory, or without
> ignore-shared?  Is it only because it'll be slow saving and loading?
> 
> If that's required, we should fail the mode set if (1) non-shared memory is
> used, or (2) x-ignore-shared is not enabled.  But I had a feeling it's the
> other way round.

Juan also asked me to clarify this.  I plan to resubmit this:

#                                        ...  Private guest RAM is saved in
#              the file.  To avoid this cost, the guest RAM memory-backend
#              must be shared, and the @x-ignore-shared migration capability
#              must be set.  ...

> 
> Reading the whole series, if it's so far all about "local storage", why
> "cpr-reboot"?  Why not "local" or "local storage" as the name?

The use case is about rebooting and updating the host, so reboot is in 
the name.  Local storage just happens to be allowed for it.

> I had a feeling that this patchset mixed a lot of higher level use case
> into the mode definition.  IMHO we should provide clear definition of each
> mode on what it does.  It's so far not so clear to me, even if I kind of
> know what you plan to do.

I believe I already have, in the cover letter, commit message, and qapi 
definition, at the start of each:

# @cpr-reboot: The migrate command saves state to a file, allowing one to
#              quit qemu, reboot to an updated kernel, and restart an updated
#              version of qemu.

The cover letter hints at the cpr-exec use case, and the long V9 patch series
describes it, and I will make sure the use case comes first when I submit cpr-exec,
which is:
  * much shorter guest downtime than cpr reboot
  * support vfio without requiring guest suspension
  * keep certain character devices alive

> I tried again google what CPR is for and found this:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg08541.html
> 
> I also prefer spell it out, at least make it clear on what that means..  I
> didn't even see "Checkpoint/restart" words mentioned anywhere in this
> patchset.

Will do.

> Besides: do you have a tree somewhere for the whole set of latest CPR work?

I have the V9 patch series:
  https://lore.kernel.org/qemu-devel/1658851843-236870-1-git-send-email-steven.sistare@oracle.com
and I can re-send my proposal for breaking it down into patch sets that I presented in the
qemu community meeting, if you did not save it.

- Steve

