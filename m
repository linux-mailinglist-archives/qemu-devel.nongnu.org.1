Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B8B7A510F
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 19:35:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiI8y-0006Sh-47; Mon, 18 Sep 2023 13:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qiI8w-0006SS-8i
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:34:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qiI8u-0005ZZ-3v
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:34:42 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38IA3OEl018978; Mon, 18 Sep 2023 17:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=cpUXY/qP+VZjAa4/1lBjjhoSNglE2VYbL/wU1ts+5e4=;
 b=XysKGxVPAcdBryeHS1GBkMKX4LoPlrvFYEn9SyjPSoN1iE+ocYK0G1zvuW2ygaMnfu2Y
 qkOmzKBzTOHs9j8tmB/Zw1lX6aPOkhd8ywdl7ahu5IHREyVwlMr3y9uLqq9lokR0ImCc
 hhqWulkyk+y5RPwJKig374iNIZ19p9EqdHsrRIpLuSnnDQ2oi41P4tuhX0n0uCk1eUY9
 /LVxXCOAL8TgTh2En2sJf2uU5jvZIbCuXSnS9MpXnMcoDLPDlrSFKnZndjqYXT8d4ZnE
 atg54ANvHFfubKYIxyg6IvsSWg4Cfy4JKIv2Fy9Dd5zZ6VKAQ63nRw/aIhoyyxIx5nmg pQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t54dd33x2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Sep 2023 17:34:35 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38IHXwjd015868; Mon, 18 Sep 2023 17:34:34 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t52t4b09b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Sep 2023 17:34:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaIaixLdJm3PgdPHxfwNUvabphjFtFHoM48oQ2kriZwHS7HmuPthz3SDEoBZWiVAvlkYdnLC3Y5b7xgxKcK+zyPZML45ihUGbHXZAZz2ydIV5G7VlZjwMidUo1/Qd7tf41gCuDJOaCEL8vMOJ0Lp66Aimrkcdk1wfNrHxPoJXiKVzrTYoOUBGkcFcrtGAtBpRSw3ymG0yOKjmvFS3n6UYdIQ6oVabSJawO/hEoP6mQ857Tu6S9dobLWHngBzqg1U/e/JDbrf0QIjRLgt60/x6JG3WLwDjZOxsFW1hi8z806bfetaKWWCPDETuoIvvKRP3I0Z/VL9Me5CX2c0j79Bmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpUXY/qP+VZjAa4/1lBjjhoSNglE2VYbL/wU1ts+5e4=;
 b=moxejLq0KKpD7InPwtkGtTo49+OZfZztNgw4CvV8G+mwJWyoLbhcdCN5G8jJN7NZRZOAeeN5641RnvIuURojwJ/jOdMggOFRmX875wE9xa7WaFXSClgm8r/Y7SkGnVjdCLTUP/xo8Iq/bb13N0Qa4k6V3F7l/gyzwSuD9VXEoCCtp1zW8sU/eF8+gzXtTNmLyo/uufZe4KGVuHahOWdCPvPZUroMtApgPEhbWukvEFgf9oKJyeDB6hHFmbIT0uMZ7w8+rbDLQ7K6ImVbcxcPCjE1nA1ZGYQ57pSRKW063XmaNXAvRJfBA3h1pQ9ZYz67vzo5zg1rFs/Ac6CiioEBwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpUXY/qP+VZjAa4/1lBjjhoSNglE2VYbL/wU1ts+5e4=;
 b=VsS5iO0XoS/SpG55uR8GgWr+SdtaJ6UmLFAbaPma/VQ297XF9h8nMVUrVua3Vl6sMijAW5g2xJFXz5FekSSlcJiGc9BK2X9Z978/CBKEQfevw94OlX/UvHbGzoC9XCmpPPVqF5TR6gO5XfqpxYdgMGKrZj3ciNYH+d6ttKUuYMk=
Received: from CY8PR10MB6587.namprd10.prod.outlook.com (2603:10b6:930:58::21)
 by DS0PR10MB6150.namprd10.prod.outlook.com (2603:10b6:8:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 17:34:32 +0000
Received: from CY8PR10MB6587.namprd10.prod.outlook.com
 ([fe80::e328:4510:e7e4:e080]) by CY8PR10MB6587.namprd10.prod.outlook.com
 ([fe80::e328:4510:e7e4:e080%3]) with mapi id 15.20.6792.020; Mon, 18 Sep 2023
 17:34:32 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, linux-debuggers@vger.kernel.org, =?utf-8?Q?Marc?=
 =?utf-8?Q?-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Omar Sandoval <osandov@osandov.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 qemu 3/3] dump: Add qmp argument "reassembled"
In-Reply-To: <ZQg9qjdMZL4Tt6EN@redhat.com>
References: <20230914010315.945705-1-stephen.s.brennan@oracle.com>
 <20230914010315.945705-4-stephen.s.brennan@oracle.com>
 <ZQg9qjdMZL4Tt6EN@redhat.com>
Date: Mon, 18 Sep 2023 10:34:30 -0700
Message-ID: <87msxjxu55.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR20CA0029.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::42) To CY8PR10MB6587.namprd10.prod.outlook.com
 (2603:10b6:930:58::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6587:EE_|DS0PR10MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d7a2982-71ec-4907-ec88-08dbb86d84d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v0YVHT0YNa3VGBAfmi4xTN3kvLbEMXND89CdMBoZc1rXbzCzaEnQhj1odHJ8QuSpERnF4sVcKBJ581dkgXa9umcyjz7yBnAZ/XzcaWQ47E+uR3ZtpJUOhOE1FDZlbbOuCPdt3RjlNnM9qSq53tS/uD734OXyCSv/R9rpQJAGRoxxxD5bRJHP2iD8Ol3CSLtGxg/AdnrzOnx7l+za8RF231O5RMBVz/sZSow6MwCyer0JPEGEE4q/dHFvh3y5TYSdax9T51RCGYu7dj1eqgxSErsmsw5EZcWNq4YzciGhi1EkR/GL8G3QPZCW0MjbpsRUupVmVZJTeUpQrmgFCJIk08TlEDr9/8N/o45l7VHl+CX3hX6zDT50zL1qDofwPKivEc6dZvCkNRxDDgEjh9vEQeNxvoUhxdIdtissU1FJLyzodJeuPE5eMpYgD87VkV3JKRISgeef6BrGnib+l19j2pgg7GI0WUTLx7TfA3JWm8oBisnjvlrBMDzKaMbAFGwEmCZs+g+iIvrH2SZb6q71fHAS7/csICP4ZtbpVoni+1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6587.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(1800799009)(186009)(451199024)(6916009)(316002)(54906003)(86362001)(66476007)(66556008)(66946007)(38100700002)(2906002)(36756003)(41300700001)(966005)(5660300002)(478600001)(6506007)(6486002)(6512007)(4326008)(8676002)(8936002)(83380400001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzhtWVJNTkxweDNsb0VrVHdTeERteTlVaCtoWW5EQXRYVG55THRHekw5K0ZY?=
 =?utf-8?B?a3lRMUZpeWMxanpOZWFCdnN4VUc3YmpUY253RTRYNS8zaG16QkRWNlNGR1Fu?=
 =?utf-8?B?NGVLZ292UkVpY0NoY1pXbS9mSTg5WXJZOTJhWkZSeFdKWm9lNXZkWk80dDZG?=
 =?utf-8?B?dWFUdmtRbnhNRkk2dUJ1dWdqR1VwZTBzRE91Y3dNNFBoU2N3SUlxQTRwWEJ3?=
 =?utf-8?B?NEZRc0x1WnV1YlJsN0R2cWdNZXFSUGtqV1p6TTg3aTJ6NlBvVm9PL0lDZHgx?=
 =?utf-8?B?RXJJNlhrc1FqL1VITDFTYTBJclFDcE4vLy9vK1ZBWWt5cGtQOGhxYm93T2pi?=
 =?utf-8?B?UVFMUmV5SG85V0swdmU5RkJLRmJ5VHc2K1pqVmpMUGFPYjI2VURXK1FyamdG?=
 =?utf-8?B?SnpKK1VzVFpwdkVSLy9FQ3hoc2JMd1RNRkJManlYdXF0RmlBclRGd3RmbVBk?=
 =?utf-8?B?WkdOblUzVGFFOUZyTnVNWHhUMXorZG1teHJyWmhhV2RTV2EzU2tVbTZQcnM3?=
 =?utf-8?B?aWhRVUJaajJYaDJsaDI3Q2VadnZuSXFhVFVzc0dBK2dEOEtqdjArTkdZcEtp?=
 =?utf-8?B?MG9NUDIwOWpuaG9xaEVONDZncFVnRGV4UzlsTXNJT3h0L2lQNnJaNitFVlox?=
 =?utf-8?B?ZVhmTUZEQnNLVTRJbzBhc0JsQjdDeU91dURWZ0VFVktyRDNqbDNzME4rdVpa?=
 =?utf-8?B?WUJ1bkk0UC8wQzVtV1VVT2ZhZnpyUkVPVDBrQUlGN29zOXlROGE3RllOemxE?=
 =?utf-8?B?QlZmbjdCMjBLSkxkb2lhazBCbVNXNVprU0gxVUtCMGF4eVF0NnZHc3VYR1VD?=
 =?utf-8?B?N0hXZG5LM0llNlZuS24vZG5nVC9QN2o0dXNTMFVodkhwM0l1U0pvd1FDOXJ5?=
 =?utf-8?B?ZGtKbmNMZ1lzUStoRG5TOXhRQmhGMmFHbnhaUDNmR3l2aTVtMlBEWTdPdjNy?=
 =?utf-8?B?Z1VqME5TS3JTQmRQSEdXMDZTc2NmZTNCTE5NUVZYd0RmcjgwR1BYR293TElx?=
 =?utf-8?B?OUpvbFBsRU54OThIWG80cTkzY0xHamRRa00rbmdJZXVCZHdhalZpTU9DSGhJ?=
 =?utf-8?B?UHdaa0MxRTRKZER1bHo0OEc1ZTNJR3NIRDJyVzVQS2hkZ2ZGMCtZTzYyam9I?=
 =?utf-8?B?azFUdGpHd0g1VWhISCtzOVVmTkJpdDBCUC9nWHZVMG41YUZGQVVyOWtYWEVz?=
 =?utf-8?B?emZwL3owNEdLc0poeTRnZ2QxbjF2T2hnTHRXNDI4bEFDV3ZiS3JxZ1VJa2Fw?=
 =?utf-8?B?VG14QnRmMEhoeDhEZjdOM3pJbkJ5N1pFRnRVTGd6QzJ1eE5xSkNrRXNKb29y?=
 =?utf-8?B?N2dmTExsZ0NOMnZBUVpBZHhFV04rRmFTTWx3aUhIMzB2RzdqS0VNdE1yazhp?=
 =?utf-8?B?dzNvL3NZL1d5b2M1ajFOLzNRV0dLN2lza2liT0dNa0Z3MWVPZUVnRDJHd2s4?=
 =?utf-8?B?VUZWY3YzMW5HZjFyZkJhVnh6QUtXS1VMMm1zRXl1YTlFaWtjY0lxLy9jOElI?=
 =?utf-8?B?ZkFVZWNrZGFOY2orcC9Id2JqaHZvTEc2NDR6SzBUNW9HSHlTTU5HaVBSQU5D?=
 =?utf-8?B?ZGR4L3ZGMTdqaXZGbThJOXl4bktMY0h3eTBRTHM3dEVHc1FTZlVscElKMFMr?=
 =?utf-8?B?aVZoR09jeG5hZVZBM3JRd1pDV1JFL1BLOWdiNGNCcDVEWEpKTFUvenkwRlhn?=
 =?utf-8?B?azJ2SVpCVzd2OG1NWWtueDhudWwzc3o5QVFub05VNjhsd2dPOW9tMkFDUmFN?=
 =?utf-8?B?SzhJeVRLWndTM3pOMWV3VncwS2ltbmZxNmNDeENscWVpZ2lyQmpPOXFGMDJN?=
 =?utf-8?B?ZFpjdC9mK2d5RUJ4VDM1aE52eWZKUnpRSXMxWVdrRmlPTDl0eXJoMFd3NG1H?=
 =?utf-8?B?U3ZiZ0ZrVXJaQklLYld4OXQzRFFkN2RaL0tuRnp5TFRJWTRDenA4cDFEQVVH?=
 =?utf-8?B?S0dVK2JiRnJvaXorMWllYlBEQnNFK0pUMjloemYxWEVFYUhSbVNtRDl3OC90?=
 =?utf-8?B?cGdUcTNYa2JaVmd2TnJsZTZTaFgxSzNOK21Pai9DMWd1QkE2VmhpV1RadURO?=
 =?utf-8?B?Ylc3ZHBqejVIeGJGOFVaWXFjSXNtUG1pMG5NTEJROVV2RzNLL1BZL1Zta3pQ?=
 =?utf-8?B?WlNxRlZlb3FlYWY5WEJYcDROcDZRMzdtU3ZaWjYrZXJKVUh3S08wbDNkUS9j?=
 =?utf-8?Q?PA15Av13j2DDOpYt3PwGB/aSzS4XqrL0xnG76wq4Uf1c?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sEOWGd1bDGH/b0A1ZRZQcMbRnSwiejOs9P71Flr5f8eeApcWrQXl0CVb1dfn/o7s7ZH/Ivj7toFE3JUWq/r9sJrxIkcZRaG8WvjOecv4UbgeL1dDw9+8fVQCIAzgkTO6mu6TTvfhnYQELaFUWcJDHI7Dn0G4hdsQgIAib+6MU8fbgA13oo3xi4coFJBqj4nP32fnmPuL1HjLrO/EoOU8LON8Nn14FCMtSZrLAwxqx9CvqD2KZhpDGS6gyKQLDGhxaJ8LRWax+MaaQOIwupLN56wBRGizKfWQFL7VHfW6sy3cBCgDWrklQogcO4x7enZxG2V9chZB5yY9yBYUKR3pJQc8836r7TRZc9FmKQmFhTYMr6hrVFDE4iH5EsSNP3Bc02bQjB+n6638AxrcVqj9OIrL/4zzQjWwnNS9BvYyylus0jQM4jX8kHnJ2C3wjTi5SK5PNm6cMu+d5LbxWVjukEXmYD6lYUaRcpc6LDshd2JnE/jI8mbJ3SU9NL0PDVRJP1Yjvmf5p0YMBLrqzJ/6rMo7MqyTf3+kgM7TpKWfNSaEX4+GfVkdQrpe5GlXoVjLR7cAPV0OP3NzdXUPSprmCye0evn23SKBwCdKV2e49BUmK/Lc9nSHQ+xtgpLedVln8Zd/if6nfe9SpgeLkFttAtDJSgiJOyuSpABXkTtN2w9uEp9+cCbxD+n4lK9fwbAZHb+oqYNaxpc5kr18T92t7onVWy4KoHvDjE8JaQrk19fRsBgNYVIeyRyYB6pOOBpYP1R7MItqI2QVXcdqFMtVeeOLhCrIPHSI9WccRgaSYvpfQKzpsxK4LoLgqn8lP6MLl6yBACA91AVKz2RjFNMX/GM5+YUJ4qBoI6LaV1pF6HGAe+JjrYsNgpNB7AjvrztR
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7a2982-71ec-4907-ec88-08dbb86d84d3
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6587.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 17:34:32.4203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0R/tHdFT5DJmBCJ00GnOeLU8VnqGNuzd1fKgPDWLAvXT5EE/Q2Ngi9r7Wgv1uvOvxmix54ljQqNWamDNfo/9zWHA6EJR8qFVr9Y/mTY94w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_08,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180155
X-Proofpoint-GUID: Flc5NpjVqNtHLriSlCrhHFWAn2sbfH8_
X-Proofpoint-ORIG-GUID: Flc5NpjVqNtHLriSlCrhHFWAn2sbfH8_
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=stephen.s.brennan@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> On Wed, Sep 13, 2023 at 06:03:15PM -0700, Stephen Brennan wrote:
>> This can be used from QMP command line as "-R" to mirror the
>> corresponding flag for makedumpfile. This enables the kdump_reassembled
>> flag introduced in the previous patch.
>>=20
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> ---
>>  dump/dump-hmp-cmds.c |  8 +++++++-
>>  dump/dump.c          | 12 +++++++++++-
>>  hmp-commands.hx      |  7 +++++--
>>  qapi/dump.json       | 14 +++++++++++++-
>>  4 files changed, 36 insertions(+), 5 deletions(-)
>
>> diff --git a/qapi/dump.json b/qapi/dump.json
>> index 4ae1f722a9..9cc7c3ea93 100644
>> --- a/qapi/dump.json
>> +++ b/qapi/dump.json
>> @@ -69,6 +69,18 @@
>>  #     to dump all guest's memory, please specify the start @begin and
>>  #     @length
>>  #
>> +# @reassembled: if false (the default), the kdump output formats will u=
se the
>> +#     "makedumpfile flattened" variant of the format, which is less bro=
adly
>> +#     compatible with analysis tools. The flattened dump can be reassem=
bled
>> +#     after the fact using the command "makedumpfile -R". If true, Qemu
>> +#     attempts to generate the standard kdump format. This requires a
>> +#     seekable file as output -- if the output file is not seekable, th=
en
>> +#     the flattened format is still generated. The standard format is m=
ore
>> +#     broadly compatible with debugging tools, but generating it requir=
es a
>> +#     seekable output file descriptor, and could use more system memory=
 due
>> +#     to page cache utilization. This should be left unspecified for no=
n-kdump
>> +#     output formats.
>> +#
>>  # @format: if specified, the format of guest memory dump.  But non-elf
>>  #     format is conflict with paging and filter, ie.  @paging, @begin
>>  #     and @length is not allowed to be specified with non-elf @format
>> @@ -89,7 +101,7 @@
>>  { 'command': 'dump-guest-memory',
>>    'data': { 'paging': 'bool', 'protocol': 'str', '*detach': 'bool',
>>              '*begin': 'int', '*length': 'int',
>> -            '*format': 'DumpGuestMemoryFormat'} }
>> +            '*reassembled': 'bool', '*format': 'DumpGuestMemoryFormat'}=
 }
>
> The 'reassembled' flag is changing the meaning of 3 out of the 5
> 'format' enum values. IMHO, we should just be adding new formats
> instead of changing the meaning of existing formats. It is a shame
> we have the current 'kdump' naming prefix, but we're stuck with
> that for backwards compat, we need a new prefix. I'd suggest
> 'kdump-raw'. eg
>
> #
> # @DumpGuestMemoryFormat:
> #
> # An enumeration of guest-memory-dump's format.
> #
> # @elf: elf format
> #
> # @kdump-zlib: makedumpfile flattened, kdump-compressed format with zlib-=
compressed
> #
> # @kdump-lzo: makedumpfile flattened, kdump-compressed format with lzo-co=
mpressed
> #
> # @kdump-snappy: makedumpfile flattened, kdump-compressed format with sna=
ppy-compressed
> #
> # @kdump-raw-zlib: raw assembled kdump-compressed format with zlib-compre=
ssed (since 8.2)
> #
> # @kdump-raw-lzo: raw assembled kdump-compressed format with lzo-compress=
ed (since 8.2)
> #
> # @kdump-raw-snappy: raw assembled kdump-compressed format with snappy-co=
mpressed (since 8.2)
> #
> # @win-dmp: Windows full crashdump format, can be used instead of ELF
> #     converting (since 2.13)
> #
> # Since: 2.0
> ##
> { 'enum': 'DumpGuestMemoryFormat',
>   'data': [ 'elf',
>             'kdump-zlib', 'kdump-lzo', 'kdump-snappy',
>             'kdump-raw-zlib', 'kdump-raw-lzo', 'kdump-raw-snappy',
>             'win-dmp' ] }

Hi Daniel,

Sure, I'll go ahead and use this approach instead. One question: I see
that this generates the enumeration DumpGuestMemoryFormat in
qapi-types-dump.h. I just wanted to double-check if there's any ABI
considerations for the numbering of this enum? Inserting kdump-raw-* at
this point would result in 'win-dmp' getting a different numbering, and
it seems possible that the API/ABI which libvirt uses might depend on
the enumeration values not changing. E.G. if libvirt is built against
one version of Qemu and then used with a different one.

Thanks,
Stephen

> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

