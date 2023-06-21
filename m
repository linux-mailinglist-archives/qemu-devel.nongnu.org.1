Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B096A739046
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 21:40:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC3gO-0000Tf-Fc; Wed, 21 Jun 2023 15:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qC3gL-0000TC-JH
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 15:39:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qC3gH-0001ib-Ho
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 15:39:56 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35LDAogX002457; Wed, 21 Jun 2023 19:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=VI/Gm5jTj29c1cB18M6+jO2+c4RCXsbebBjjY36/Nec=;
 b=qitT0IK938ZZ3h4GNaMNST8GqKB39mmOj36serNqOwkKBDTisCV/wXK4+mW4nkL0bBwa
 aGYW9hxebTeJNulUOaTaoJnuuIUE6LJG0Azj4btyFXz0p/avJkPpVZa/Es6M8rg6VVHu
 lQ6f73U6ajNqyXntMAzoT+RuLic2erX6EsdhE9Nkg9aHtSMaQ/lkoI43CXNDCyZaVkSY
 fJg7501b723NUQZ6opXKgEpaoPQu0xnNEQxuInvBXbgRdpZTD1PGoeYmEhikPCEX4yEB
 v5uhTRhQi6QXaS+5JVglbt93ckE3PEY0xs/HpAEftAcydr628gUYoRaWrItAmNI+lE8f BQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93m3revk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jun 2023 19:39:51 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35LJQu1Q007962; Wed, 21 Jun 2023 19:39:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r9w16uubu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jun 2023 19:39:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsKWLv7J3Jzs9G4H4M876Zt4N9JCfq1A6V5CVYALV1/cRhRA8YiUM1s8ZcBPoW1HHEnTgEZjMfODmWre7ZcSq1Qi6/91CXNUhXUxMo7ktNgZN2QEAzTiDea+jd7nRmeHh6VkHwYIw6+VZPMl6TtQ4/iPlHw0EcftMaBimK4gzgQoLtsnnjEtc9eHYRR+QdNWPKqxpHRb6QztBEcMoWI5BjGnuHOjbRyz7NRzT0HOwvolg03o9sr/SqQTUIP2GJYa+IzsuC8lgPTPWSJiGU+TSCclVE3/iAvitmcGb+x7pjd+IvHJmx8tA2/2gjNjtyQHyXoq0ba3jqzDpZA6w8dapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VI/Gm5jTj29c1cB18M6+jO2+c4RCXsbebBjjY36/Nec=;
 b=F5QJUFSdnFna7JNHgELHHa4Nxx2c7QYYzWforyscKKyanyLL33wrh+mjFJNoy4Kt6ZD3ybFvlIjDS//JnGIH+7Gv5FWASKaYliRpzubpdJ43HWZjrBN1VXGqQjKlllZATeRSBpmU1s/pgAgu9ehMkIpMVyr0onuC02aAkq0UGcgNdj03LFDh2OFXYZpKnH0Kn6FCkb7X2pYLhlx/OGKfRQh2ITyi0VYPxAEY0VSDrauhbyeI55tv+eKUb7w0YT0rR57SkgQ/nxVv2+iyAmVa9y/6caVpY7j9p3oK5zHA/EMy6juRbe5Bu1PfP2aRe9a4Ddsb/matr6t1qMqA4hmMXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VI/Gm5jTj29c1cB18M6+jO2+c4RCXsbebBjjY36/Nec=;
 b=DpZkS/1j5snfUsTNYc3pczApED8fGDjaMx/PYHuEdcmgdjhf79GGvvs80ZgU8zfpMm2r9rr0XG4FVDXPP2awP9CptUxez5/Xop290yt+RbvSoCFz5ljplzg+8v+uzPD5w/1O9YaXxrgFlNJJNxnmdec6/e0WvflZ23+WkxuDtFE=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SA1PR10MB7740.namprd10.prod.outlook.com (2603:10b6:806:3af::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 19:39:48 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11%6]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 19:39:48 +0000
Message-ID: <e848fa92-3cfe-a3bc-d666-625e72a65518@oracle.com>
Date: Wed, 21 Jun 2023 15:39:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V1 3/3] tests/qtest: live migration suspended state
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1686860800-34667-1-git-send-email-steven.sistare@oracle.com>
 <1686860800-34667-4-git-send-email-steven.sistare@oracle.com>
 <ZJMpFfetFkZ/QjfT@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZJMpFfetFkZ/QjfT@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:806:130::30) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SA1PR10MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: cd3c170e-6eba-4208-b146-08db728f45ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f4IMkSOPRtsY2v/EiPi9t15xYM7RPa+bxUNWIuM5gBIrIzNqT+5rclds4jPrmVValdiiL6hec1jw5m1FI/kHHgZCPv/CFkCgNBwAmFoL/wqpOmiIS4yMm91CoaLef6GeMcumibvq4xbHf1Chsdh/UVU3ZHVXBNb9Kz+66DgqYQJXpfUK9nuMwKBAWDkybXnCzBOtJg4VT2mjj5EsXIyXnJ0MzhtMbT7vdYpyJagDMqWRHZzWByGLL9LkVpdRc4tUxNexoyx7FJh+Z05SX7bOgHAnCF0+T9K9UgphnY7rjPJtPDCaxxDlydKqPSFerq7f906FgcBV7OuX4zO1v/81UHcAL5NIf6zsukFflYSbfekPuGYwb0NKpiYDsRj6uIjaByqyW/aIMYomIro9jeEp45q3jHS7HQvdduYwM24jmR44V6lmwUm/eoSG0a3Talq/nbnj3KskpjZkKO9n4uIpKWcJtFXCugfgpPQQG/h6rXUKWVSpzzCX17TEkQv/Xomcc2WsOLBshSp/BSui697Mx4fjMd+cldbscED2Pt4yqsFzeGac4h55znDQSMTjCTeFgf8F0OEi8lNJtPu7txmmvrRscToQPVyXl8u2/hoavS7cRiZrFP+mPe+IKFb2kPKx/oSlcSVaBdM16eIvCIZeYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(478600001)(36916002)(54906003)(6666004)(4326008)(26005)(6512007)(186003)(53546011)(6506007)(6486002)(2906002)(15650500001)(8936002)(41300700001)(8676002)(66946007)(66476007)(66556008)(316002)(44832011)(5660300002)(6916009)(36756003)(31696002)(86362001)(83380400001)(2616005)(38100700002)(30864003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a05oYXBiaXRSOWlVeXN2bTM4MzlsdjBUZWYrbnRUSTZqbStOSU1jbUMwK3I5?=
 =?utf-8?B?eWRjYjdFa0o2MDhlS0FYTjcyaFZNblR4QU5HU0ZPekM5R0tNNTBqUjl2cTJv?=
 =?utf-8?B?a2RocEJ0dC9GSXhVSGlrRUYvN1RBK2hLMWNKRzRWeC9ScFM2QUlzemZqY2ll?=
 =?utf-8?B?aFRXbk1STVZoUC9aT0F2QU8rQU9rcXBQVzJCKzBLNmlwWEFWSllYTkNpaFU1?=
 =?utf-8?B?dk03TEN2Q3VCK3ArTkJhQ3RqZ3lvSzhTaDZmNjFJVWN5aWhMUUZOZWdpbDB5?=
 =?utf-8?B?T2RpMWJBaU91R29KVEp6WDBnT1lYOGx3T2lNdUVxbENzOXFRMWgzdEFHQSs2?=
 =?utf-8?B?eFMwQ0tzdUNKMUMxOWZBb2ZZMUE3Nms2YTY5Ung1ZkZsbnBSNG9Ucm5nTmhO?=
 =?utf-8?B?VVZlNXJkelVMNlhGNW5oR2QrbjY1K0oyRGEvelB3dXdqeVBWTG0ybkdsVEti?=
 =?utf-8?B?RjFmU3FQRzJPeWJXc3l0MVRYUUpuYk81YmVuc1NnSTVFM3YvQ0RoVDlNUjEr?=
 =?utf-8?B?eEVMdzN5cGtJWEcvQ0FpSVVHdVVGTTlUa0E0UzRNOTE0MCtMM1R6QzlBT1U5?=
 =?utf-8?B?c2tCT1ZWVjlBcHJSUVRsSWcyUmFyaE82ZGFlazV0S3dLalJsdG9FRFRCaFM4?=
 =?utf-8?B?Y0o1THNoQzdZVGF1UFV5aG54d2JaSkNtQ0MzV0plblh6WnlKR1g5Lzg5L2dK?=
 =?utf-8?B?dmdyN2JZbFVUUWVhZlF6OCsvdit5Uk42VmI1WnVDTzQxa2VFbk92aFNRQ3pr?=
 =?utf-8?B?NlFhb0J2Qy9PcllrZndtRzFtMWE1eklQYVhYeEpwdzEzNlJXcm13Q1YrdExs?=
 =?utf-8?B?Tk5uSE1QRjYwZE1lMmgrTU5NcFZDcHlVbDFXWkZIdWhrajJiWGxsWERvTTg5?=
 =?utf-8?B?NFJ6L2s5aHRGcFFYVmc2Um5iN0VBNUd5Qkx2b1EwbXhORzZBajN3TGdRSklE?=
 =?utf-8?B?V01SUURlclp1V1FwbmJqNnc0bE5idVp0ZGN6YnVFNzlYUnRUR1IyMXFiV2Vn?=
 =?utf-8?B?c1FGOTFJZGhhOXYwaUhMc0pXRGpPMVhSYnFuRmVobHZ0aWQ2RndRSzQxelFt?=
 =?utf-8?B?bk5jdDJzZVlIVTlCd3BoZHNKeFlJT3g5TlNSajg1RlduQ1hWWVYxcExmOVJV?=
 =?utf-8?B?VXhWMzIzRWNzaXNsZTVETzNTdEsvT2FzbEZpVmdTU2xnOEpTOGl6c3BSTnJQ?=
 =?utf-8?B?WmhFV3czUEpEMGgrYTUwVWVPc2pZV0pzU3BzaHhaa1NZQklGV2xqZGdKR3B6?=
 =?utf-8?B?OUttMWIxcHJzOUs0eElFcWlJM2s0STZIYU81SVhnZGVOZU0xYnkxSGhaUGlL?=
 =?utf-8?B?MlNRVXphVXRnRjZDYmlvMEdXTk5qUU9LOFFTVFUvRDNrV2xIYlJqSVA0Y1gr?=
 =?utf-8?B?U2czMmNtVzZ2QWp1Nmx2dG1GaFpQS2xmNVZMVGh3cHFQaGhzN1hyUkJWMUVq?=
 =?utf-8?B?ci81Wm5PQUJrQlM4ck9YL2E4ZkFlbFB3S1hta2wxUDVrM1dMVzZxTDZ1QTlQ?=
 =?utf-8?B?Y2V0QnpPdEVrNUkxYSt6anhhbXFkb0d0N1FIYThmMVFjeTEvdzF0ZEVOaHVI?=
 =?utf-8?B?aWtCWTZJbnJlVE1HTE0vK1NYZzNJN29lOUlWMUN6RXY1bk44N3hsZC92akVV?=
 =?utf-8?B?M1FpQXE0cytxQ0sxWUVKSXVCNFMwMmhIUlZxNEEwN2pub0tqeSs5TWM0V1c5?=
 =?utf-8?B?eGx4SE5iM3p6QTZYT3VWSWp2TWpTT2txNklDeERuYTJZRzA0NzZkS0JadmpV?=
 =?utf-8?B?Q2JWb2c2dnI5NDhaM2k5VXdZZ1dJN2JWMkhNNU9LSVdYRzJJWkVHamN5Ry8y?=
 =?utf-8?B?aXd6akxYNDdGcSt5ZXF2S0FZaUxFYVc1a0xBTVMwcW1SWTBTdU9mSUtIOFR1?=
 =?utf-8?B?UVlVOVMrRWg2WGJFdGlNckZOeUQrZVcyKzhNSUQzc2ZQU1lIblNqVjk0cXNh?=
 =?utf-8?B?amZ4bTRQT0Jxa1BQVzhqZjJJNlE1TXhMallHMzVQNytJWXdUTGR3Y2dVTXdx?=
 =?utf-8?B?cnNzMjRoOWtJVG1NVHJxQ3ExUEN4WHdjS05ydUZBTTlxYnF6Z3p0Q2RDZjFV?=
 =?utf-8?B?dDVVaTRaNWhzcUFzUkV1bUtacTBIWDczSUpRNTROcnBTR3AxRnROaUp2dGJD?=
 =?utf-8?B?WWxoM2NEemU5bjdKM2dMMlkyWUFNN2pRekZENVYvZm9VajUzUXVjeUNGN29K?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uUJnUh3hUdAbIbEoXP53rSy+p7mjJFWQ0ko7mDASMvgW4vX75Jlc0ablyJzgRytbpv45VezcT6R7KSI6kO/ZYqxcG/p1ImHRtKcV0T9cp1ROluEcsotkmM5bMay7ihqV17bTfKu6ivOp0xAAy6DoBTO/iRWfqX9DfhqF0RhtO6OWDbcKMBbceel6r3pIezGMSwD5ocd2iFD/HnxBgauqC8m2Szd83aP90lh8KSxEmkzqS0+o6enMKHcsjNhUUj3tfr+hMzcalExK/RpQppi5Su5aYFWVCVkVMxF6+PRwxtOfzCydkobLh3pOPJchHSig7dp/hE/CV+KD3Q/4v4YNvBaAbfkS5+9hTHdW1w0xnv/k9DpoLVhdz9C0hhfrYwShSvn/vn0HLBNl9n9B+i+JhlpNWWQyrmnwMC//Rv3FdvUpgp1X6CtgO5SfnmHuqWuwvXFmzchuay6rjObNaXTmWbrrw6E4hzC8E81HhC/7emg3pj4nR9RRVQA7hruBr8UqnIv+xTDDXvyycpEGJllebSQkHet4NvTzzLBC6fkUP/BjfiIbUbJ5L6aS13SXO6U/xQtxWuCZQpXX6AV3vA4YHjYhYmFBeTfBwDFlpDsi/qIhi8DmQNDUH3iOZD6TflkDp3iiIez18TD+GyaUS8fvBlRZcDdPg7X6UAV9vBjKK7qi6GmcCX1GE63LE+aNOJRVhn2a3pb4JbaZWfZg6+psn++8Ldcc70og82jFsHdOJDM7gQJSnxy11m6q2vijcW/YYySnOQOaBnFShgOe+0M8tw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3c170e-6eba-4208-b146-08db728f45ca
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 19:39:48.0575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHvaI7awWsUi+RS2V+lnUG5JlZXPrm0Ry7WuTG+0INXA5nXWoNG+6s7IsCvoYKHRnC1ixXdar4C+5LSUlcmm4YH6aD/2n47WetdKAg8j1v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7740
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210163
X-Proofpoint-GUID: qbyxfowZPQRh3NygUyk8xIIAKji_6FNq
X-Proofpoint-ORIG-GUID: qbyxfowZPQRh3NygUyk8xIIAKji_6FNq
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/21/2023 12:45 PM, Peter Xu wrote:
> On Thu, Jun 15, 2023 at 01:26:40PM -0700, Steve Sistare wrote:
>> Add a test case to verify that the suspended state is handled correctly in
>> live migration.  The test suspends the src, migrates, then wakes the dest.
>>
>> Add an option to suspend the src in a-b-bootblock.S, which puts the guest
>> in S3 state after one round of writing to memory.  The option is enabled by
>> poking a 1 into the suspend_me word in the boot block prior to starting the
>> src vm.  Generate symbol offsets in a-b-bootblock.h so that the suspend_me
>> offset is known.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Thanks for the test case, mostly good to me, a few trivial comments /
> questions below.
> 
>> ---
>>  tests/migration/i386/Makefile        |  5 ++--
>>  tests/migration/i386/a-b-bootblock.S | 49 +++++++++++++++++++++++++++++++++---
>>  tests/migration/i386/a-b-bootblock.h | 22 ++++++++++------
>>  tests/qtest/migration-helpers.c      |  2 +-
>>  tests/qtest/migration-test.c         | 31 +++++++++++++++++++++--
>>  5 files changed, 92 insertions(+), 17 deletions(-)
>>
>> diff --git a/tests/migration/i386/Makefile b/tests/migration/i386/Makefile
>> index 5c03241..37a72ae 100644
>> --- a/tests/migration/i386/Makefile
>> +++ b/tests/migration/i386/Makefile
>> @@ -4,9 +4,10 @@
>>  .PHONY: all clean
>>  all: a-b-bootblock.h
>>  
>> -a-b-bootblock.h: x86.bootsect
>> +a-b-bootblock.h: x86.bootsect x86.o
>>  	echo "$$__note" > header.tmp
>>  	xxd -i $< | sed -e 's/.*int.*//' >> header.tmp
>> +	nm x86.o | awk '{print "#define SYM_"$$3" 0x"$$1}' >> header.tmp
>>  	mv header.tmp $@
>>  
>>  x86.bootsect: x86.boot
>> @@ -16,7 +17,7 @@ x86.boot: x86.o
>>  	$(CROSS_PREFIX)objcopy -O binary $< $@
>>  
>>  x86.o: a-b-bootblock.S
>> -	$(CROSS_PREFIX)gcc -m32 -march=i486 -c $< -o $@
>> +	$(CROSS_PREFIX)gcc -I.. -m32 -march=i486 -c $< -o $@
>>  
>>  clean:
>>  	@rm -rf *.boot *.o *.bootsect
>> diff --git a/tests/migration/i386/a-b-bootblock.S b/tests/migration/i386/a-b-bootblock.S
>> index 3d464c7..63d446f 100644
>> --- a/tests/migration/i386/a-b-bootblock.S
>> +++ b/tests/migration/i386/a-b-bootblock.S
>> @@ -9,6 +9,21 @@
>>  #
>>  # Author: dgilbert@redhat.com
>>  
>> +#include "migration-test.h"
>> +
>> +#define ACPI_ENABLE         0xf1
>> +#define ACPI_PORT_SMI_CMD   0xb2
>> +#define ACPI_PM_BASE        0x600
>> +#define PM1A_CNT_OFFSET     4
>> +
>> +#define ACPI_SCI_ENABLE     0x0001
>> +#define ACPI_SLEEP_TYPE     0x0400
>> +#define ACPI_SLEEP_ENABLE   0x2000
>> +#define SLEEP (ACPI_SCI_ENABLE + ACPI_SLEEP_TYPE + ACPI_SLEEP_ENABLE)
>> +
>> +#define LOW_ADDR            X86_TEST_MEM_START
>> +#define HIGH_ADDR           X86_TEST_MEM_END
>> +#define suspended           HIGH_ADDR
>>  
>>  .code16
>>  .org 0x7c00
>> @@ -41,12 +56,11 @@ start:             # at 0x7c00 ?
>>          # bl keeps a counter so we limit the output speed
>>          mov $0, %bl
>>  mainloop:
>> -        # Start from 1MB
>> -        mov $(1024*1024),%eax
>> +        mov $LOW_ADDR,%eax
>>  innerloop:
>>          incb (%eax)
>>          add $4096,%eax
>> -        cmp $(100*1024*1024),%eax
>> +        cmp $HIGH_ADDR,%eax
>>          jl innerloop
>>  
>>          inc %bl
>> @@ -57,7 +71,30 @@ innerloop:
>>          mov $0x3f8,%dx
>>          outb %al,%dx
>>  
>> -        jmp mainloop
>> +        # should this test suspend?
>> +        mov (suspend_me),%eax
>> +        cmp $0,%eax
>> +        je mainloop
>> +
>> +        # are we waking after suspend?  do not suspend again.
>> +        mov $suspended,%eax
> 
> So IIUC then it'll use 4 bytes over 100MB range which means we need at
> least 100MB+4bytes.. not obvious for a HIGH_ADDR definition to me..
> 
> Could we just define a variable inside the section like suspend_me?

No, because modifications to this memory backing the boot block are not
copied to the destination.  The dest reads a clean copy of the boot block
from disk, as specified by the qemu command line arguments.

>> +        mov (%eax),%eax
>> +        cmp $1,%eax
>> +        je mainloop
>> +
>> +        # enable acpi
>> +        mov $ACPI_ENABLE,%al
>> +        outb %al,$ACPI_PORT_SMI_CMD
>> +
>> +        # suspend to ram
>> +        mov $suspended,%eax
>> +        movl $1,(%eax)
>> +        mov $SLEEP,%ax
>> +        mov $(ACPI_PM_BASE + PM1A_CNT_OFFSET),%dx
>> +        outw %ax,%dx
>> +        # not reached.  The wakeup causes reset and restart at 0x7c00, and we
>> +        # do not save and restore registers as a real kernel would do.
>> +
>>  
>>          # GDT magic from old (GPLv2)  Grub startup.S
>>          .p2align        2       /* force 4-byte alignment */
>> @@ -83,6 +120,10 @@ gdtdesc:
>>          .word   0x27                    /* limit */
>>          .long   gdt                     /* addr */
>>  
>> +        /* test launcher can poke a 1 here to exercise suspend */
>> +suspend_me:
>> +        .int  0
>> +
>>  /* I'm a bootable disk */
>>  .org 0x7dfe
>>          .byte 0x55
>> diff --git a/tests/migration/i386/a-b-bootblock.h b/tests/migration/i386/a-b-bootblock.h
>> index b7b0fce..b39773f 100644
>> --- a/tests/migration/i386/a-b-bootblock.h
>> +++ b/tests/migration/i386/a-b-bootblock.h
>> @@ -4,20 +4,20 @@
>>   * the header and the assembler differences in your patch submission.
>>   */
>>  unsigned char x86_bootsect[] = {
>> -  0xfa, 0x0f, 0x01, 0x16, 0x78, 0x7c, 0x66, 0xb8, 0x01, 0x00, 0x00, 0x00,
>> +  0xfa, 0x0f, 0x01, 0x16, 0xa4, 0x7c, 0x66, 0xb8, 0x01, 0x00, 0x00, 0x00,
>>    0x0f, 0x22, 0xc0, 0x66, 0xea, 0x20, 0x7c, 0x00, 0x00, 0x08, 0x00, 0x00,
>>    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xe4, 0x92, 0x0c, 0x02,
>>    0xe6, 0x92, 0xb8, 0x10, 0x00, 0x00, 0x00, 0x8e, 0xd8, 0x66, 0xb8, 0x41,
>>    0x00, 0x66, 0xba, 0xf8, 0x03, 0xee, 0xb3, 0x00, 0xb8, 0x00, 0x00, 0x10,
>>    0x00, 0xfe, 0x00, 0x05, 0x00, 0x10, 0x00, 0x00, 0x3d, 0x00, 0x00, 0x40,
>>    0x06, 0x7c, 0xf2, 0xfe, 0xc3, 0x80, 0xe3, 0x3f, 0x75, 0xe6, 0x66, 0xb8,
>> -  0x42, 0x00, 0x66, 0xba, 0xf8, 0x03, 0xee, 0xeb, 0xdb, 0x8d, 0x76, 0x00,
>> -  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0x00, 0x00,
>> -  0x00, 0x9a, 0xcf, 0x00, 0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0xcf, 0x00,
>> -  0x27, 0x00, 0x60, 0x7c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>> -  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>> -  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>> -  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>> +  0x42, 0x00, 0x66, 0xba, 0xf8, 0x03, 0xee, 0xa1, 0xaa, 0x7c, 0x00, 0x00,
>> +  0x83, 0xf8, 0x00, 0x74, 0xd3, 0xb8, 0x00, 0x00, 0x40, 0x06, 0x8b, 0x00,
>> +  0x83, 0xf8, 0x01, 0x74, 0xc7, 0xb0, 0xf1, 0xe6, 0xb2, 0xb8, 0x00, 0x00,
>> +  0x40, 0x06, 0xc7, 0x00, 0x01, 0x00, 0x00, 0x00, 0x66, 0xb8, 0x01, 0x24,
>> +  0x66, 0xba, 0x04, 0x06, 0x66, 0xef, 0x66, 0x90, 0x00, 0x00, 0x00, 0x00,
>> +  0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0x00, 0x00, 0x00, 0x9a, 0xcf, 0x00,
>> +  0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0xcf, 0x00, 0x27, 0x00, 0x8c, 0x7c,
>>    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>> @@ -49,3 +49,9 @@ unsigned char x86_bootsect[] = {
>>    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xaa
>>  };
>>  
>> +#define SYM_gdt 0x00007c8c
>> +#define SYM_gdtdesc 0x00007ca4
>> +#define SYM_innerloop 0x00007c3d
>> +#define SYM_mainloop 0x00007c38
>> +#define SYM_start 0x00007c00
>> +#define SYM_suspend_me 0x00007caa
>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>> index be00c52..433d678 100644
>> --- a/tests/qtest/migration-helpers.c
>> +++ b/tests/qtest/migration-helpers.c
>> @@ -28,7 +28,7 @@ bool migrate_watch_for_stop(QTestState *who, const char *name,
>>  {
>>      bool *seen = opaque;
>>  
>> -    if (g_str_equal(name, "STOP")) {
>> +    if (g_str_equal(name, "STOP") || g_str_equal(name, "SUSPEND")) {
>>          *seen = true;
> 
> This is also a bit hachish.. "*seen" points to got_src_stop, so when
> SUSPEND it'll set got_src_stop.  It's not clear what stage we're in even if
> that's set, irrelevant of the confusing naming after being able to SUSPEND.
> 
> Shall we just add one got_src_suspended here and explicitly check that when
> suspend=true in test?

OK.  I will move got_src_stop and got_src_suspend to the QTestState, and pass the
QTestState as the opaque pointer.  Ditto for got_dst_resume for consistency.
Then we can delete a few globals as a bonus.

>>          return true;
>>      }
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index b0c355b..73b07b3 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -121,7 +121,7 @@ static void init_bootfile(const char *bootpath, void *content, size_t len)
>>  /*
>>   * Wait for some output in the serial output file,
>>   * we get an 'A' followed by an endless string of 'B's
>> - * but on the destination we won't have the A.
>> + * but on the destination we won't have the A (unless we enabled suspend/resume)
>>   */
>>  static void wait_for_serial(const char *side)
>>  {
>> @@ -507,6 +507,8 @@ typedef struct {
>>      bool use_dirty_ring;
>>      const char *opts_source;
>>      const char *opts_target;
>> +    /* suspend the src before migrating to dest. */
>> +    bool suspend;
>>  } MigrateStart;
>>  
>>  /*
>> @@ -617,6 +619,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>          }
>>      }
>>  
>> +    x86_bootsect[SYM_suspend_me - SYM_start] = args->suspend;
>> +
>>      got_src_stop = false;
>>      got_dst_resume = false;
>>      bootpath = g_strdup_printf("%s/bootsect", tmpfs);
>> @@ -1475,7 +1479,13 @@ static void test_precopy_common(MigrateCommon *args)
>>               */
>>              wait_for_migration_complete(to);
>>  
>> -            qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
>> +            if (!args->start.suspend) {
>> +                qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
>> +            }
> 
> This is live==false path, if this test needs live=true then afaict this
> path won't ever trigger.

I verified that live==false works, but did not add a test case for it. 
> Even if it triggers, "qmp_cont" skips for SUSPEND already, so I assume
> we're fine.

OK, I can delete the check for that reason.

>> +        }
>> +
>> +        if (args->start.suspend) {
>> +            qtest_qmp_assert_success(to, "{'execute': 'system_wakeup'}");
> 
> Okay I did look up qmp_system_wakeup and I think it implicitly checks the
> SUSPEND status, which is reasonable but not obvious.  Not sure whether
> that's intended.
> 
> Shall we just check it explicitly with a query-status, even if so?
> 
> If keeping relying on qmp_system_wakeup not failing, I suggest we add a
> comment explaining that this explicitly checks machine state so we're sure
> the SUSPEND state is migrated properly.

I'll add a comment.  I intended it this way, because it works, simply.

>>          }
>>  
>>          if (!got_dst_resume) {
>> @@ -1508,6 +1518,18 @@ static void test_precopy_unix_plain(void)
>>      test_precopy_common(&args);
>>  }
>>  
>> +static void test_precopy_unix_suspend(void)
>> +{
>> +    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
>> +    MigrateCommon args = {
>> +        .listen_uri = uri,
>> +        .connect_uri = uri,
>> +        .live = true,
> 
> We need explicit comment for all .live=true cases to state why.  Please
> refer to:
> 
>     /*
>      * Optional: whether the guest CPUs should be running during a precopy
>      * migration test.  We used to always run with live but it took much
>      * longer so we reduced live tests to only the ones that have solid
>      * reason to be tested live-only.  For each of the new test cases for
>      * precopy please provide justifications to use live explicitly (please
>      * refer to existing ones with live=true), or use live=off by default.
>      */
>     bool live;
> 
> Thanks,

OK, I'll add a comment.  Live runs as fast as non-live for this new test case
because the source is not re-dirtying memory.

- Steve

> 
>> +        .start.suspend = true,
>> +    };
>> +
>> +    test_precopy_common(&args);
>> +}
>>  
>>  static void test_precopy_unix_dirty_ring(void)
>>  {
>> @@ -2682,6 +2704,11 @@ int main(int argc, char **argv)
>>  
>>      module_call_init(MODULE_INIT_QOM);
>>  
>> +    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>> +        qtest_add_func("/migration/precopy/unix/suspend",
>> +                       test_precopy_unix_suspend);
>> +    }
>> +
>>      if (has_uffd) {
>>          qtest_add_func("/migration/postcopy/plain", test_postcopy);
>>          qtest_add_func("/migration/postcopy/recovery/plain",
>> -- 
>> 1.8.3.1
>>
> 

