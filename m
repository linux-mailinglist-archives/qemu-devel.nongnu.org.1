Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0849F7879F7
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 23:11:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZHaK-00084W-JR; Thu, 24 Aug 2023 17:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qZHaI-0007sx-1R
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 17:09:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qZHaF-0002oY-Ec
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 17:09:41 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37OJEWu1010371; Thu, 24 Aug 2023 21:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=aI0M4b61yQs3u9ZufSBjRD+9qpwOm6a0lrg79gVUa/g=;
 b=Uw9dre4OVRSi6MAt+j8U/vic7iEuGDWGbMMDEwlDTIRvbwrcOi47+znIdXuN9sSYpJqJ
 S7pBcIW410zHPF3CYvkrRHceSdO6Q5xDHFnolygoSst4BOi9ppFWDRly5fqSN+DzL0gp
 T+u+3qt5WXqx6+4Sx3SqiueuRS4mFx09YXwKMVEoibsXtF0rd0gBFpRdp0HW05k5mEs7
 2JSwXIiKVLaYEWrDhFScGgr6dfvb4y8dmHf5Ng8E/SllKsyg8/KTNccxK9C2/f97RJ9A
 0aYsTubXXY7sdf596RVhA1w+OSRRRks7Nq/IdB2xSPmDNxCgRFxri+Sq3rTPR9Z6Aorc RQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yv56ej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Aug 2023 21:09:37 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37OKs4Tl036090; Thu, 24 Aug 2023 21:09:36 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3sn1ywgk9a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Aug 2023 21:09:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dh7v721fqO6a2NoL0MHJ9chSVPj+M5B/41hH/TkUXlK24GbUnhb6ktp2xJKoHijIa4pORcGvEDF9EnzoIFiz2gZCi6iwaEKb864/hSYT7s9VtPi/TrXaDFejyRarGjLuGUBfTPmvD9Y5d+1XZCKZORghDe5Lcdfw44+a3TdQuei7AxpdOy1zLOknVpZZDlpfNJDGrtcy1+XGRotBqWHKfZBnhXzxbNopKGvpFVaZ0f4H7G4Xr4OZrtfPhrCEBTzeXZ+UtN1XyTtRNxjdo0oy3zNMdm4SQR/rItE17Wolg0NfAdBr7FpOesoLCQieC8J6ShfKeC4CT9Zz1iQBczBf1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aI0M4b61yQs3u9ZufSBjRD+9qpwOm6a0lrg79gVUa/g=;
 b=i4yXhlyHZ9i1qZmqWW2z2uevXrBXt7QELFAuaoq3TLM6MS6Gx5vOEaNoCMjSEEq6HvJrECSDuV67P0IqXcyTXuyJyzJsZ4wIgJMcnDXaLF+yEyxV6/WjqgLzQGoSYYHL0xpMMEBAGB8/mtss3yHDEeWm+DXUf20KdE7J/DaWSYkhEsQIaJieRc7+kF7yRFG17szzr25mbYYOKFKHQsr6YplV0o8kJ7pgGJGpcmKT5O0nCls4Lgo8lI9/NS9DUC6V/8T8VAGo3zlynosJUdYdUP8WB5IWE97EpnoYUUcM+XWQ9YAvLolsoVqZKCP6xct+hhhKIUHy3T2eLvBH+u7/BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aI0M4b61yQs3u9ZufSBjRD+9qpwOm6a0lrg79gVUa/g=;
 b=BlT6mGFeGicTTr+jzIWF/ua1nu1m32mLbECh8D44aqtqZ1ZLIec6WuprcNmHPb6535Ncu0mYDKIQYUk16Hi9s+scs7hRftuVNHWfZpm5OL/P8XNggr3eVWwMlnutYLWAmZ5HPhlhvO4ATF3AuzdgatRsd1GxJPXYPmJmFXSlhl0=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by BN0PR10MB5222.namprd10.prod.outlook.com (2603:10b6:408:114::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:09:34 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d324:ad85:4523:fbb0]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d324:ad85:4523:fbb0%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 21:09:34 +0000
Message-ID: <f26b44e5-ef9a-60fc-1172-559ff5ea70de@oracle.com>
Date: Thu, 24 Aug 2023 17:09:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V3 00/10] fix migration of suspended runstate
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1692039276-148610-1-git-send-email-steven.sistare@oracle.com>
 <ZN5lrPF9bY4acpvM@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZN5lrPF9bY4acpvM@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:a03:505::13) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|BN0PR10MB5222:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b857c7-bfea-4308-adc1-08dba4e66a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7YMsmvuHe/GPdf0GoRXSatuFjpHwg59bhMfXEnHfxeTVXCHR8fUAmfjSmBOx7AJguNYWm56jQb2B5uJ5okIQGZDq7es6HjvdP5/UG19GZhGFB8S24Z+bMvWg5UXYhNcPrO8eO48Mh27kYduVg0TTeUEWDSbA2PrMgSMUyKgYp9m1brN7tyGgB1tp1L8qPYYoruCHkRexz396ziYX58JkmeSjKt55LI/47DHKBdCxCNcQ5Ub6EfryKZ5ap1/LFMovSKKoOnxVADTyrBBa5hXBfdZrnj/gru7WSuyP24fHeUNsnZfSrxdmCtr7nw4QmRiX/jsidiAj+9FPh3Uvzk6prFPIwLBXguK+F/Iu5+Np2lvJ/Jk3BU6f37EAxAoJA91eH9zuvEhMuYobWRE2iac4TFCjP+sIjkrtxpIWw6tRPJdhrOGndunlXvWr3eqZV6PStJ6kkpkSCP+seXafau6IWemVV1poiNsW6I4dOyPoLGgnXusbv2aC04kBH68SQZsCPZLpFv7BN2ixOnh0la8uFUqgpUUEMfYE0ffti4f6EWBLM2t6Pq/W01GLm143HW+7mlCMGVdt+7LKo9y2zQ9J5d15/9QN8J6HNZ4I9DjXMG0jkvLSMu8vnIVypOMb9rzediJ6GkSC2+tf2jj/nsUupA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199024)(186009)(1800799009)(54906003)(6506007)(66556008)(66946007)(66476007)(316002)(6916009)(478600001)(26005)(44832011)(38100700002)(6666004)(41300700001)(36916002)(86362001)(31696002)(6486002)(6512007)(2906002)(53546011)(31686004)(8936002)(8676002)(4326008)(2616005)(5660300002)(83380400001)(15650500001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHdkUUVyTlJaYWJoaTMyb1ZmeDZObDVKbGpXWkNDT3dud2JIbEJGWllMSzkx?=
 =?utf-8?B?SGxUVUl4OSt0aFdZR3djdytXaXhtMzNNaEEzZWE0d09OcXAxS1hjelB4cU1C?=
 =?utf-8?B?MGVkQURnblpZNjJKd2liOEEvVnREdzBPTWVkNWpQZlZRVlZpbFNuWG1wbjVH?=
 =?utf-8?B?cHRUeHQ2YWpvelFPWUpVQjlDS0srZUR1RlRYcFNFY0kxTkZFY3VZdmNwL2xp?=
 =?utf-8?B?T1dBY2sxZ25mUERtZXhUcU9lQkNpd2QrVkszNEFtTjZmUWxxTERrL1ZFS0h3?=
 =?utf-8?B?eFhQbmNrVHpoKzVPaVVmNTVMY0cwdXVGeDhxS0dweTZCWVR0U3lJbDJCSHZO?=
 =?utf-8?B?Qm01clB6dks4LzRHcFY1c1NrZUt0T0Z0dVNyWXdzYUtKZjhxOXpiREhxUVE1?=
 =?utf-8?B?ZVVFOWs5MGFYTlc2RFVNcmt1LzNhcVBrdnZ1WG4vL2ZPRmlvYXQ5YStSU3JG?=
 =?utf-8?B?WkNudnd4dDZjR290RU5Ucy9QaVluM3UySEQ5WHFUSnJidEhLS1BJZFA2RFVD?=
 =?utf-8?B?bnpSTHZpNnp3eWJmQmk0eDJwY1RZa1I4bzlwWXc1YzBpWEh2Um9TVjMzSG9a?=
 =?utf-8?B?eWxtcjlqNFhnbjJpR3U5Q0k2RGtNb3pzRklZQWJTRWtzeFBUeU5HU3diYzRE?=
 =?utf-8?B?TjJkRWU0bUZBS0J0VnN0THhYODRGQkFWdnZvYzFKRDU1NFVtS1QwTS9lSUFG?=
 =?utf-8?B?SmdHTDdta0MzM21VZUZ5cmpkcHdGZDVrYWJyY2VFWmNCLzlzOHA5aXplUm1q?=
 =?utf-8?B?N2FtV2wvUXpaem9udHU0TCtkb1JrajkyQUN3ait3cStYbUp2eWRxNHFuNEhE?=
 =?utf-8?B?aGczMFU1eUZra0FLcHQzY3JET0lPOW1kZ0Z1OUF4dGFLY0l1QllvZ21MeW43?=
 =?utf-8?B?WVRPQjFiZ3EwU05salpCRDdNdnY2Q3BOdlVpZzZ4aElGV29zeXFSRlZTR2JK?=
 =?utf-8?B?NjJKd2FJZnJEVGZxQ1JFS3ovVGhkc2s1SC8zMDRWV1Z5WERMYVFwNitxTHNp?=
 =?utf-8?B?eUVDdzJ6SXBhczJ4cXdHVDR5d3BweEhzZW8xemtJSGUzb0Z2WWV5Q0pxbFJi?=
 =?utf-8?B?Z2Yxd2s2Tmg1T1ZEcFdBOU85OEc5dU1HT0xacG1ycnY3YnJJQXdabFNOa3Nz?=
 =?utf-8?B?cUIydmExcTRMZnBVS2tnSjg5bGk5T2kvWi9CV3p5MWxUdGx1RWpQSHpvZENt?=
 =?utf-8?B?SVk3QTBaL0t5NVcybFVnT3VHMWttcVA1OFhETnc0VURTNDJ5dWlIOTQ0RWF4?=
 =?utf-8?B?T29ERFV6NmdTcUZyTDJNSFhoU3FHbWFiOW8wQmgzc2pmZFZNais5Zng1aGdi?=
 =?utf-8?B?T2Vhcm9hQXVNdnlXWnhTTXZUUnFJUXVxWU9NUVVGMTZodXZ1VmMwNTdCYnRW?=
 =?utf-8?B?MDJJbTg5cVo3L3ZqaUozUWREeW13ellJS1cxOU1mbGZ0Z0l0eVhhajBLenlm?=
 =?utf-8?B?c2lSRGJ6TFYrdENidDBOT0FBZE5GMlRPdGdzaDRGeHpYNWZlTENLN3FnL1ZP?=
 =?utf-8?B?R2NQTmd5V2ExRE1lU2N1WXNnbDhLUmdBS2pyUVpCYlh1SGl3U1Iwek1wN2x1?=
 =?utf-8?B?aDJzQmRzMk93N3JBT2srMEE4SVlsNXVOR1diVkxxUlE2MVNDKzU4RU9rZ2hw?=
 =?utf-8?B?QWhseXIvVmhSVjJYUFBoTFdPZitZNVN2cnp5M3NFa3ZQUDJnbFUySnV0Vyty?=
 =?utf-8?B?WVBSa1BZYjVMakpPM1hwNmFYc3BaYmFRdjc4NGg2TGtwcGFIYUZOWmNLeEJv?=
 =?utf-8?B?OXB0ZlZRWFNvemp1YVJ5cWRlb2lVT3NzOVhLRFdPSlY4anhRdVl1NW52NGZa?=
 =?utf-8?B?cjlBcnhHYVZ1ZC9kK0FuejFTOUsyRjNLeEh0UlVnSHhnS2xqWHlOamJzS21J?=
 =?utf-8?B?RGZUL3Fxd2ZUNkVoN2E0enJvODZ3OFpMeCtiQVJjTXpRUi9lUEQzY0VpMnBa?=
 =?utf-8?B?Uk5TZGpqOTk5Zm1DL2NlZHpSUkJNdW9SekkyUjlXeU1qSzBndWhHbXZ2M2Mz?=
 =?utf-8?B?T3k2UWNwY29iNzkyQ2RRdVl5MndjYU91TUE3SGpCSzExZ1piYWg0VWMzaURV?=
 =?utf-8?B?N2xKSzkrWDlZMWw3R05DQWdTeEpoYTE4N2hzMUwrc0kyNEQ2cTZIUmZXS3Z4?=
 =?utf-8?B?UGpuTDJ6RjdaUTFycExZNWtqeVlLMVpIblFITE9mTmhXREREa0FTM2hRQ0pX?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5D+RF1NL4YSeyVPOhdgZADGEKwxVThJ6HXk+iJLIi8DVXv+/MMNgqiRvQNanFNJIwKdIxekDimgM1lmqkQsjL9yJneqfOp8DbCutMWyERiTv1zIf1gClq/bOV8xbbuMXolj6iwwifIO3+XqdTK9Avsqg8Ht+mQJxu/tHR6Z0Iy81iFaZKlXLhtfODdySuaIPfxEETCX7gLuJARTJpH+4D98xe1ASR3DaCF7t4om706XefpXeVgzasEmIlw5FSDPUSxqSHOeUYP79VfPcvEMKQVUqABOyyjCbW3itCRuJRrjRQCF4SQ/WxuhfTU4qlhpnRE+iPDRsrc/ZQ8El5IcWSieI/NgCC9fDMmtzdRozk/pb29pyFYOv/+lviIo02YU0jxcDoRnl97nogqXyCxoG3PfMvYes0hznXDosrQAypAqxHG7u6KaSNwZwve0Y831CFUqKKwip0dnp9ManE5Auee2idLLma18mSRUIULx6L9HfTcf3VW5J3fBKdkCoYRKZjJ10xRjjFg4RAwcsKTwxO8Ow4o5zNaCPYIsBr4/tG//TxRcpJ9MTDFIVEp7t8HgJF07jLemUPxtfQuuSYWPOLbgzgg8WTXivjEa6QoYZDi/p83Pbft20dWSh5R8p2Wk8MxvXOoBv/x7fRj/IYKS23bMI74H9MceEjXtzO/FubfAeHAXgh3OWZ9NfKf0IuQplgWN4F+fYuvA4/Y9Ymku2rduLK7ogeaFcLJ9weM9/O7oy6Yo9Hj8ND14tPBErPVsayl1ccCE6/oGwlh4b7p7KMg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b857c7-bfea-4308-adc1-08dba4e66a77
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:09:34.0220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmFUFy7StisQf+olyrJyvFr31IPW0LuI90WxxIKJRlXy6Cngq0nV+yytMlnmAX6VgCd1j5mcV/CgEiaul6Tdq9hOYf4p0ygG3RDdmsSSVhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5222
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_18,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240183
X-Proofpoint-GUID: tliy7O8iFH2N1nAd4M9A6pbUSSyaQH_b
X-Proofpoint-ORIG-GUID: tliy7O8iFH2N1nAd4M9A6pbUSSyaQH_b
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
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

On 8/17/2023 2:23 PM, Peter Xu wrote:
> On Mon, Aug 14, 2023 at 11:54:26AM -0700, Steve Sistare wrote:
>> Migration of a guest in the suspended runstate is broken.  The incoming
>> migration code automatically tries to wake the guest, which is wrong;
>> the guest should end migration in the same runstate it started.  Further,
>> for a restored snapshot, the automatic wakeup fails.  The runstate is
>> RUNNING, but the guest is not.  See the commit messages for the details.
> 
> Hi Steve,
> 
> I drafted two small patches to show what I meant, on top of this series.
> Before applying these two, one needs to revert patch 1 in this series.
> 
> After applied, it should also pass all three new suspend tests.  We can
> continue the discussion here based on the patches.

Your 2 patches look good.  I suggest we keep patch 1, and I squash patch 2
into the other patches.

There is one more fix needed: on the sending side, if the state is suspended,
then ticks must be disabled so the tick globals are updated before they are
written to vmstate.  Otherwise, tick starts at 0 in the receiver when
cpu_enable_ticks is called.

-------------------------------------------
diff --git a/migration/migration.c b/migration/migration.c
index b004475..89d56a8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -63,6 +63,7 @@
 #include "sysemu/cpus.h"
 #include "yank_functions.h"
 #include "sysemu/qtest.h"
+#include "sysemu/cpu-timers.h"
 #include "options.h"
 #include "sysemu/dirtylimit.h"

@@ -2125,6 +2126,9 @@ static int postcopy_start(MigrationState *ms, Error **errp
     trace_postcopy_start_set_run();

     global_state_store();
+    if (runstate_check(RUN_STATE_SUSPENDED)) {
+        cpu_disable_ticks();
+    }
     ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
     if (ret < 0) {
         goto fail;
@@ -2333,6 +2337,9 @@ static void migration_completion(MigrationState *s)
         s->vm_old_state = runstate_get();
         global_state_store();

+        if (runstate_check(RUN_STATE_SUSPENDED)) {
+            cpu_disable_ticks();
+        }
         ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
         trace_migration_completion_vm_stop(ret);
         if (ret >= 0) {
diff --git a/migration/savevm.c b/migration/savevm.c
index 7b9c477..eff6976 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -58,6 +58,7 @@
 #include "qemu/cutils.h"
 #include "io/channel-buffer.h"
 #include "io/channel-file.h"
+#include "sysemu/cpu-timers.h"
 #include "sysemu/replay.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
@@ -2969,6 +2970,9 @@ bool save_snapshot(const char *name, bool overwrite, const
     saved_vm_running = runstate_is_running();

     global_state_store();
+    if (runstate_check(RUN_STATE_SUSPENDED)) {
+        cpu_disable_ticks();
+    }
     vm_stop(RUN_STATE_SAVE_VM);

     bdrv_drain_all_begin();
@@ -3037,6 +3041,8 @@ bool save_snapshot(const char *name, bool overwrite, const

     if (saved_vm_running) {
         vm_start();
+    } else if (runstate_check(RUN_STATE_SUSPENDED)) {
+        cpu_enable_ticks();
     }
     return ret == 0;
 }

-------------------------------------------

- Steve

