Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B23257F1D27
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 20:11:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r59fV-0007KH-CW; Mon, 20 Nov 2023 14:10:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r59fG-0007Gd-4I
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 14:10:34 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r59fC-0008WI-D0
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 14:10:33 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AKInAdw010140; Mon, 20 Nov 2023 19:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HaWalCoaAK4P6kOTFQGn+f3Js3yj5UNNQGEGbXgNMb8=;
 b=Rd4XvfJWnvhoFF2OupXLFKElWHjswUBupmbqI2U+a4kaGhA5+uV5usGmcnCaN72S2sVx
 wNWcZZwsXHpUDyylA/MNGnLoEFmgUuQhldnE8FCyEvUtNYEg+RdGl27jZ/UFqWya0sL/
 ObvF7wAvoT7lxx7bw0v66pwkLANChrSYw55+XjB9HUgQIdSWB5rPOXgVukrZamTZu2Ra
 4YUr/TQ2I2AI63FTe93ykQ6Ut5K+RQ+Yky/YcLvw+6OYn4Ne2LYN7/vR+3XEPcjV7Qni
 JtnnxihXfRxyTgsBLJ/fFWFVJJf/7lFCJ74nVUJXg+GqTUvoA4tWD2VvwiCpJ+tMpxNK sA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uem24uet3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Nov 2023 19:10:28 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AKHpjpU002385; Mon, 20 Nov 2023 19:10:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uekq5u6e1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Nov 2023 19:10:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVagIadJDE2Wz8Q3WeT9hu6vqg//CLxI3sVrVh0r2WW7HlbVznQ4mFRdT6eTY7odom57brLz7ByU5utCfImuasSrk2KMt71pEsXmzKBzi2qsb45CnySXci9VPlvs2zFZ/X91L22CnVYhiKcO+gJ7Oi0/hXfMUygmpQeV0EZXxKvKe1bPHcaEnsRsZgWtCgm/SZhXSRhCv/+EW+xObTXEF3OS4W/e19BEnzZdAgF8V2xBJgcIEMnXfuQEnYS4FWraxLcuV6+N1QA4eknKTP61j7b4PWvPwkVfkNqb0+VCR5q5mzHVGV6/IogPYapFYz3dLfEnRA8nrp6YVS0D3IjzUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaWalCoaAK4P6kOTFQGn+f3Js3yj5UNNQGEGbXgNMb8=;
 b=X+6xQyqqrIsa6sEnPx4VkZvnPmxZaaE0hrN7FRyPB8MTZ4aSFXYWAyjwt4eirDpYGiT9P9IdEn99TWr9Fz/6PUAXpMTrj86w1nC0ol1J0z1e9x2FYO/irCi1kTM1ddB3PdW79LpVmBugz+NYsSKfvgF5kd0PACJMpoLyfpfMQT1JDwGEqjRxLxQNulvxBrzZWQ7KCh7A6XnGQgGO82EUfdGXjPBVeuiEQ8dpSD1A3pk9sEebS0gACm57iV6m6sLWpzpCsZKp+bw8jEfil2IMvc14sDAkZI+HILxdbHQBq5e+b1zECdvd2WHlJ4BR6wORK4r1Xofmxc+UZvFSm7PztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaWalCoaAK4P6kOTFQGn+f3Js3yj5UNNQGEGbXgNMb8=;
 b=u1r6HnymacRmOoypzp+PZAL30eLYgDnATU0dvIDrl7gxouCTKGSBR3uBkcFjeyfhWea+tUYtofZ0OY1ElDPFJE+tPyGeFynHnB9vWcMxBWR3I7wXMeEqE4z4eCXYAUX7znP9/AuesiWRxg01j3iSpsZCClcZnsuPwIodZTE57+4=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ0PR10MB4606.namprd10.prod.outlook.com (2603:10b6:a03:2da::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Mon, 20 Nov
 2023 19:10:26 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 19:10:25 +0000
Message-ID: <f9907360-54d1-4196-922b-2f8bfc123fd0@oracle.com>
Date: Mon, 20 Nov 2023 14:10:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 02/12] cpus: stop vm in suspended state
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
References: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
 <1699900440-207345-3-git-send-email-steven.sistare@oracle.com>
 <87il5w5x53.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87il5w5x53.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:208:32f::13) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ0PR10MB4606:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7e6f46-594b-4549-1719-08dbe9fc5a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qOlb9C5AsGMNiPZ1aGsMsFMZBN0jtUakAiy/ig0uBt8LsgAKYOd5ICK4zzo4U1vZx0eaDok0a9xe6e/AOvRAmIHk5vqO6gQ82FLfC9kthj4T2tBZlDCf4FOmHtV8kIXvjG09wNa69LwHTqim83SXssi1OyDplGyI/WN1JnuxSBxylU1htxNi1RD+cI3kqb6mmI75U5KBkMd67IVWAfb5KazYzj/xSpiy329wDbPOILnz/nmFig2oWniSB88a7UFlsoFXHPjj63dlIWVH0bk7eC0JUAJAITsozzSyFSW6bvedAfwmDU5ZCryJB2OTBWaEgOqeinbtd0JjqqmI+Jejt+KLvc5YGwFIMVif2u0Nx7jHblT48DFIMJB8tQaVbn6DxVRejp+pz0Ik3vePLiNPSKi9uMZ3+3nuhfO4SVq65HrJqPtJgpHr4sZP0vX6QWFewXj4ybP0Zt2lEKs1ymEG1iJOxs94S5rQmRGKSf1Gu1BZAMFvqvsSw+6bl61R89eaKw27QlGwv9GyFQ69bk2EmsNm1aWjI5dBg+V6rnLYC0HAtTPnYFc/eyIX3UTk9OVI2f6Kj2pdy1aTvDlZNGLGE0pIjEvo9SChjAXd8MS5cTZE1l7w7U2o/JifN82xKG6igSb0Oo1R7AE+0sDSuoSaiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66476007)(15650500001)(2906002)(26005)(83380400001)(5660300002)(41300700001)(2616005)(31686004)(478600001)(44832011)(53546011)(6486002)(36916002)(6512007)(6506007)(31696002)(36756003)(8676002)(4326008)(38100700002)(8936002)(66556008)(86362001)(66946007)(316002)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0xkVEtTRlM2WjN1S0xINm1kYTErbXFRb20zSnhxMXFzSEFMTFJOa2JEYTVX?=
 =?utf-8?B?UVR2MkFCdjBhMDRtU2d4dGNzUnFiZEo5Nzk2ZHMwaUMxL3pTZVowbkdnMGtD?=
 =?utf-8?B?SFVycVl1SkJibHhWb05TcTQ4dHFYOHphQzNmWkFDRmsrQXQxZXByYkg2bVhC?=
 =?utf-8?B?N3NiSHJGN1RhRWRQcVQxeFVFaXMrWnVaYThJM1RvUGt4dGtiT2xKZ3F6c2I5?=
 =?utf-8?B?VU5XRFZRM2VyYkR4V2ViajdudzZmT3Z3UXBSaW1NZ24rMUFaQ1RzMGtReUdN?=
 =?utf-8?B?Q2twU3FaeVJLbmpzcmJXWHFBNlBzcUJNN0tiZzBmdEY4MndCUy9IUEswbjNF?=
 =?utf-8?B?R2RNUzZhYzNzc1FOWG5VUnRFc1UwaUdDYnFvYTBVdithb1ZFMFBBcE03bDhL?=
 =?utf-8?B?NUErcGhGYnlac3RUWUJTWERYVVY3b1QyRy81ZTN2ajllaEgwbGJoNzM1Ty9N?=
 =?utf-8?B?RXk0Z01PdG1PcUNDakgyR2FYV29LZDcxL1kwWlpKbHRocmsxb1NTTFlVY2p3?=
 =?utf-8?B?L3Q1TnU4WWZTWHBVVTdsSmFTYjhGYjlzeG9GZklxY2pXeVp6clFCYjhiUGlG?=
 =?utf-8?B?Yzl1YkFEQ1VPU042ZE1EMU84ZkVUaURLYm1XMGpBS0xUWnJNSVl5MVpQZFhK?=
 =?utf-8?B?Tmtpb1dPVHZhZVZtSnFUS1AwRTIwUzY1ajR4U2d5ZUYyQ2F2aEI3RE5NWjM0?=
 =?utf-8?B?TTFBWEp2Rk14WkZVNHl1bWZkQUlRcW5OY200cUc5dUZCQVVtMU1wc3FYUm5R?=
 =?utf-8?B?V3I1TlZNNEdOSjVpV3BsTWlicnFhd29oQXIrZmUwR2FDMkx4QXpCRWpXTWVV?=
 =?utf-8?B?TFN5Vi9ubUdudFZEaEZqWWhhMkNrVWU0WEIxTVArVVpiRTdISGxsdzlQN1Fm?=
 =?utf-8?B?cGF0Z2trbjVBZS9PQWpjYnlRS1NYaXplZFd4OEdOYklpbTh1ejBObndzNVNp?=
 =?utf-8?B?cjRaK2xmcERXd1RjYXR5QVA3M1hqTnByL2g3VXI0TkxQRWJNNG9taXlZZDho?=
 =?utf-8?B?SjIyRXdkYTduRU4xQ0NpRnlsc3dxU3JLOHVKYmd5d3hPWjdhU1RBOERBNlNK?=
 =?utf-8?B?aUVmSm40Wmo0VmgzQzhSN2xRWFZPTGdpQTAzMjF2dTl0U0JkU3FYRWJkb2pp?=
 =?utf-8?B?Nyt6Y0ZzSlBVaFFvWTJSa0dHTkM3YzU3R0QyNE5HQ1hJUVVPNTk0TW14bDhT?=
 =?utf-8?B?WHQ4U0NtUWhmTWJxQktZVXhQcWE0d0FpNWRGWWNZUmF3MmxEaE0wSVJmRnoz?=
 =?utf-8?B?SnlNWWRLTlN3RHpjck5rOTVZb01VVHFRczJTeDAvaC9MMlk1L0pTRU9CTDdL?=
 =?utf-8?B?OW13dzhNTDNQejMxVUtWMU5ObHk5cXV0RFdjRi9ETVFISUhOQXVlTlpQSUxt?=
 =?utf-8?B?Uk5ianB4L01vNGcwSFFxT1d5UXZFTGVBVkhrTFFFc2FFQkkydklOYWRTTW55?=
 =?utf-8?B?NHBVZEYveEpOTkhLMUU5NDdtd2pYRjJvd1NZeXFhQm95eXkvN0NtRmN2NWRz?=
 =?utf-8?B?S3MxV1NlSmdyTVBidVI3cVFVVVRkYzhkV0RMa2VIaUFpZE5ia3hLUG9PaUZ0?=
 =?utf-8?B?dVlPQlBaRlVHMGxQclBHNkMvNFM5ZG9paldpZ0dnTG9qajNERWZ6aUZCYlpv?=
 =?utf-8?B?Skltb2tIdys4M000OU5aS0RTTU8yNEtMcjFOVEpXUTBnNERvTTRkd09RRngv?=
 =?utf-8?B?VmFOenA5WVVoNTFWSEZva25Ldy8yVFhtcllKSjcxWlRFdzdkUjBQVDJOc2Ju?=
 =?utf-8?B?My83eUhVQUFPb0VVcjZxZGxkVVhlVnFNU25uTEhwQzhEU2ttRmNPd1pJQ1JM?=
 =?utf-8?B?dy96T0RiWmhLKy9WVm5mdTdFVDhaR0ZyOGRLam94UVBwaEI1QmtwbVIzblJl?=
 =?utf-8?B?WFUxV2lrdFdIOWxqd1NzKy8xQ0VvTU5veFl2TWZRalpSdGM1SWZRT3FTbm1O?=
 =?utf-8?B?cFhLajFoOUNneFBvZUo2bm1LZUorUjRadXpnZ29LWC9nWFdhc3IvSmltTi8r?=
 =?utf-8?B?L0tLaXpicWsvR0xOczJjU0JQRlJ6cWdIQUhoYmxxN0ZLaWs3a2NvUmdPSEI4?=
 =?utf-8?B?S0ZFT1l6empOWkFPMndFbi9YUHQwOS9tdXFtN3p1YnkvWGZoNWtVQUE4MEVs?=
 =?utf-8?B?bWdLdU5NOGRFcS80b1lIM212YktVQ3lqRjZuZnR0VVpuSTc5RVI5dUZWelF5?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DiY9rhqvpKqbYJffD2V+Am4XEazFg4kQCpguyiNWN4URedXkUCSy5PDfwlvusjMt8oekomAfNj/xHpe+uYQfaaVBlWh6mbVLuPU03lCpPq2ZqrQavrAJaFmDA+GAI926iIubd033x5y3Q4rZ/UGHh0fMPYuDKTfAOTl8UI76F/cBP90J/fCchW/UIj2oxZzYhbcJt18QmFb9lH/qlr6qCt0p1l41TEkhy0Fyih+XBE91JOL4IVI9ix3xu6cqzjfaBtu21bEwRu7sZfBufglVbbgY07G6XaE99fuf+KphtRJ6MAN/SBABt1rk87Ui766YkxXxu/822i9DrLYlI8/p+ncdA2e5Z27hcqXmLnBsy1PkG3vcCDGHtgLPkiV/y9dYWKFzzBsYIGRQL74LVmYLm6C2K09WrmTc+w64Co81AGfLn6oqqFfZtXTyG6xs32Tjgq2tvxGR3ip9GziXF4ZosUA7PRnQCcChFqw5XxfWC15Nlzfmovs34/8aeXrfDaXYPNgT2ed2OI6LJMgzHuFoLh1pQQhoWTh8owSPo85COjdrhnR9iSqp21J45PNet6oKjdSEHMh2OmW0ni4Jk4+ww3m3xYoG5ltFFjFHqggZkM1jFaVMHKmO45GQdLOezSkpE7linQUoEsCZNCTe7xmJs5cZZkvI3F85O7umC+qQ+7MpJvzW/Pf0UvRBr6rfGU3BjE8J+36lYVdgrt9ET7f0KgA5ghW46zy1iegkVgoKKK7VI0NJTrCC5nb4ltN3BIGIT18P46AC9uJWJG/QNlPI+Bj0MegAeI1wKhPUkV3zpG0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7e6f46-594b-4549-1719-08dbe9fc5a35
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 19:10:25.8397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VkicDTfO9jvQ0bcXOy2dmoUwWrHGUvJD+U/uBl+iTxsGpENYM/eLJ/qf5a3jsjKrll2j0K4xsMByqBCjh6LEgnL/wG3/vi4L3DYDgbIAsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4606
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_19,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311200138
X-Proofpoint-GUID: q4hGPx3P-cqG4EZbBXNRpdCRYEMi1oKC
X-Proofpoint-ORIG-GUID: q4hGPx3P-cqG4EZbBXNRpdCRYEMi1oKC
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 11/20/2023 9:15 AM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> A vm in the suspended state is not completely stopped.  
> 
> Is this a statement of a fact about VMs in the suspended state in
> general or is this describing what this patch is trying to fix?

The former.

>> The VCPUs have been paused, but the cpu clock still runs, and runstate
>> notifiers for the transition to stopped have not been called.
> 
> ...it reads like the latter, but then why aren't we fixing this at the
> moment we put the VM in the suspend state?

cpu_get_ticks() must continue to tick while the guest is suspended, so that
QEMU_CLOCK_VIRTUAL continues to tick, so that timeouts based on that clock
will fire.  One example is timed wake from suspend,  acpi_pm_tmr_timer.

>> Modify vm_stop_force_state to completely stop the vm if the current
>> state is suspended, to be called for live migration and snapshots.
> 
> Hm, this changes the meaning of the "force" from:
> 
> "force a state even if already stopped"
> 
> into:
> 
> "force a complete stop if already suspended, otherwise just set the
> state"

vm_stop_force_state has the same behavior as before for all states
except suspended.  If suspended, it also:
  - stops cpu ticks
  - calls runstate stopped handlers
  - sets a new runstate

> I don't know what to make of this, shouldn't all vm_stops cause a
> complete stop?

We cannot stop cpu_get_ticks.  We could maybe call the runstate stop handlers,
but that requires a careful examination of every handler, and there is no obvious 
correctness or cleanliness reason to stop them immediately on vm_stop(), since cpu 
ticks still needs special handling later.

> We need to at least resolve the overloading of the 'force' term.

How about a more complete function header comment:

/*
 * If the machine is running or suspended, completely stop it.
 * Force the new runstate to @state.
 * The current state is forgotten forever.
 */

- Steve

>> Suggested-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  system/cpus.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/system/cpus.c b/system/cpus.c
>> index f72c4be..c772708 100644
>> --- a/system/cpus.c
>> +++ b/system/cpus.c
>> @@ -255,6 +255,8 @@ void cpu_interrupt(CPUState *cpu, int mask)
>>  static int do_vm_stop(RunState state, bool send_stop, bool force)
>>  {
>>      int ret = 0;
>> +    bool running = runstate_is_running();
>> +    bool suspended = runstate_check(RUN_STATE_SUSPENDED);
>>  
>>      if (qemu_in_vcpu_thread()) {
>>          qemu_system_vmstop_request_prepare();
>> @@ -267,10 +269,12 @@ static int do_vm_stop(RunState state, bool send_stop, bool force)
>>          return 0;
>>      }
>>  
>> -    if (runstate_is_running()) {
>> +    if (running || (suspended && force)) {
>>          runstate_set(state);
>>          cpu_disable_ticks();
>> -        pause_all_vcpus();
>> +        if (running) {
>> +            pause_all_vcpus();
>> +        }
>>          vm_state_notify(0, state);
>>          if (send_stop) {
>>              qapi_event_send_stop();

