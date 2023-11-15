Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C337EC7F5
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 16:54:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3ICK-0001La-9r; Wed, 15 Nov 2023 10:53:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r3ICG-0001LS-Pj
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:52:56 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r3ICD-0004T1-Ok
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:52:56 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AFFd3VB022045; Wed, 15 Nov 2023 15:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=khBl1LrRPfaRg1w1ZX4K9BpxqgwI/JWXFLdsLRfyKWQ=;
 b=XcNXGi9McZc6zJ0KA6oshihA3qBsPlPnDJfM5vpnTpQp2dTlULfv3aaitK5e7JgKv60l
 qFZ6DY1tLdJ5L2gPJ2CUnSX8rAXjMpIsFpZyTA0yaqVf44XQPAm1qFOWnMz7N8e/Gp6x
 6ifKhfBgXJTVzrEbb8SkoYyo2akZEFtHv6F0KsVd8WnkDaEpiFN9jvZssnSRTWZfk4yI
 Erm2jP6zIeiIqga0crCrEHgOoDHkYlRwjQkJ7GZ3/am2xlGZ2o7h7VuOtvXMtymcD/xI
 4d5vSgEKXA8Bj2iHyYvXLJnC89zIg2Ro+oSBtIZe3iDROTgEXHxN7lD4djSBPWa1u229 Bw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qd8u57-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Nov 2023 15:52:50 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AFFG7cq004117; Wed, 15 Nov 2023 15:52:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uaxj42b25-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Nov 2023 15:52:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqxZjP0cRQRrgGSwhKLXXNuagB3dNBnE5Guu6h/R626AMBTn6awAXhrmAJXbkYmUVis3ugK2oYzsE5+FUNkbLAOWqgCRvTTYJa1SX15ENxplAo28oKiqdDEVkHXb/sN0dx/HEeP9J2x+fB8jEmxrway5PO5isxmEQw2It7gKVwHJ/oWgFvcf6TpDXpRM1fNjIXeQHCo2babBUW7D1RW+3OT/5Pz3VryI0UlYvnNvNb2yYIWoEAeuYl2ZAx/k0fzyh9KWsn6GTXM6FDCK/4a+5Z5rBxMQh7o6vgCcYhczJS6VuSSnv0VIN6mjRSVCHb+rysJ3WiRhu/8odj7MmThkeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khBl1LrRPfaRg1w1ZX4K9BpxqgwI/JWXFLdsLRfyKWQ=;
 b=RcfuXiXeY3NYYLYOo0pFkRzvpUejPINhotYwF1sdMKmKiLi5fyNZ3+9xB6O+MMXmlvFLUIfFQS4ZDY/0lgDDgIC563mK3ld8SjQmETWkBOPbNzNN8+l917pZFEdAO7jpDW5JnfnXRWEBcDy6G55n47R2Kguoyz4ih8FK4AZ2Ms+2O+L1VKli5Kw7G7Umj0JfBnqoXt76NU88iPU3M0Lcg14V0VzoHZ0tur03qZ2LL+mArBlhnTy255gYXt3uDWx/zwwZZ1yjhwJ8lTm2Y0ckoK1n8JuDt5KkVdEp3h1ibzyp451HKZJeLCbm3eJv19IKFyHmpJQAc+hdSRstP0EzSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khBl1LrRPfaRg1w1ZX4K9BpxqgwI/JWXFLdsLRfyKWQ=;
 b=zZrEfupB+3caHtydiCUnx3a7LRtuQxZRIaHpRmqhW77HIY5Z1/gXZC4roTc9H+Ll34hGJNpYMsVJdpz8fAzCQzY+OtcwRZPSCqMXMEtk11LfOgs7Psg0iIUQFpm0ice0ask9oGtLoI8NjjqRJjwvweSgslnMGujyixBTasfI4eU=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ2PR10MB7599.namprd10.prod.outlook.com (2603:10b6:a03:541::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 15:52:47 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7002.015; Wed, 15 Nov 2023
 15:52:47 +0000
Message-ID: <17078387-f782-42dc-a5bf-25ee22bc518a@oracle.com>
Date: Wed, 15 Nov 2023 10:52:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] monitor: flush messages on abort
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <1699027289-213995-1-git-send-email-steven.sistare@oracle.com>
 <ZUUu2IuUQ/Od7+Vr@redhat.com>
 <3d45ebc0-de9f-4051-9c08-47e40fea65da@oracle.com>
 <ZUi7izJoVpU+iiuC@redhat.com> <875y23s918.fsf@pond.sub.org>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <875y23s918.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::12) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ2PR10MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 243926b6-d7ec-45bf-f5a1-08dbe5f2e9ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4tVafdFrRvIh2pE3EsjVhQf880EXGEHwCQLEJVhAzWpkA7rDDjyYdVRR9Y/VfTkPhXwIVzL/4e7J8PdYr2YXP39ELDhdn704LJ6TzWQSUgXtX6mi9cMnP4T1KAMlr2Gn7bhz0qEQ/cO0a4ceRmkni0rceUQcSKXHQnj5hW1DJc0uB+HjNwhz4Y/1sTA7z3goyVfNjI8E631vs35jbIJEA/UB1bfpk6IrPdsrsSB7mHy+Q2RucvFq0j/tz3y1oEzr9gt9YFopfnBFZWFExKYEIOekMaZ2fHiTVLFwsVd0q7Iu4nzA9YjUJSfx2xVtAg5g3+BuckP8LvhvpSkG3qC2Y8XIAvQhX0gJ01MVQ68sGNR0qgZSBq21bhGAYeNS6NSYyvoOCynKmwPQ56+G8L6zn/AVIycXFK9OdDifz4AWyA0alAjPtYzhTJdfwMb7wMLojkorgG9UZf52oO98XfnxuaX9HAmBUVh+9nCYFebyPamLjULUuQ/M4dhxfSRhCCSdc/qNv6p8Nb31QBfm1kyd5S++VYga/shG+GFqOCrMaNTLL2WSMe1eOHCTe0ANDEVbsuRgJ9+gEItd7iSXDidc5WviUArmW/jXXDjoqT/EKh3HEakqbIUt6YCL5TV7cF6DcTuMEAQgs6ZQKSmH4JpbvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2906002)(15650500001)(44832011)(5660300002)(38100700002)(41300700001)(6666004)(6486002)(2616005)(66946007)(66476007)(66556008)(6512007)(26005)(110136005)(478600001)(54906003)(316002)(6506007)(86362001)(31686004)(36916002)(53546011)(83380400001)(31696002)(8936002)(8676002)(36756003)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDJ3QW02OE41RTFZU0VjeGdzQmNMeHI0eW1raGp2ODN3L1UzV0tmTnYvcEhs?=
 =?utf-8?B?R3VwUVQ4VHZTR1FJd3JyZTJRTlRzNkxoYy9rd1BQWEV6Nm5WZFZzQ2o4Mm0z?=
 =?utf-8?B?cjhMeTJ3NFlxK0JhY3c1dmhIcW9jRkNmOGtEaWgvQnkyQU1nWFNlMEtnTnZL?=
 =?utf-8?B?Ykp4VEVXL0NXT3FheW1VUE9HQktjYzUzdURiVlRSd3MxeHBycUVDUGNUQmtn?=
 =?utf-8?B?c0pMWGhSblFwNnZXSXU3YWJhS1JUbGI4VGxrRTIrMGVlNlp1ckIzbkFzekFD?=
 =?utf-8?B?Uis4TCtOeTR1eEpnbEszMmdueG5JbTZiOTlDdG1XUk9LZzM2OUpVcjdiMXlx?=
 =?utf-8?B?UnBtYVA4dkxERFM4ekNGdXRkb2IyNkk4cldIajJtNlNaaHdFMGpNVU1VY1B0?=
 =?utf-8?B?Sm81YXl1MkgyTXF2L2FKbWVlb3liQVk2TUFjNHp4dUxGZFFjMUpMdDZyeUVO?=
 =?utf-8?B?SDNEdGxSeFNFaGNnUnQ0ajhielFSY2dnU21qeWdyNDNINnI4VFR1ZWNmNXdq?=
 =?utf-8?B?YlRNdWI0eDVxVmdBWGVvQ3lIaDBWVkVhMzI2TWxEZ21KMDlwSlN6eWwwL3dv?=
 =?utf-8?B?bWIzcDRKQjNTNHZ4UXhwVjlkQ2JCWUoxcFkxT2JsbXJtN2x0dlo2UXNmc054?=
 =?utf-8?B?SElvZFh5VlMwM01LeUZkcWRlTkZ5MHhXckprZ05lWnpabDhQNjhuWnFPNHJh?=
 =?utf-8?B?dWtKcnJvbFhiQnBRNkpUdFZkYTZaUlNxQTZTcVNRYXVBZE9xOU5CZDFvZHFr?=
 =?utf-8?B?TnFBTE9ueGZOaksyTFFoaEdvWmVaMHU5OFFJTFRCK0tEUHNPZ2FuRHVTU0Jm?=
 =?utf-8?B?N2dzbEc1cGZJbHNydndnbEQ2K2o4NGJaYUpGeXplU1FNcEZxVFkzZ1pPbzF4?=
 =?utf-8?B?aEJRYWdUS3ltenNXQ0FDQUZnb1BCaWkrZzJyckJMbmVKcEphQzhLNTM0K00x?=
 =?utf-8?B?STZLWHcyMVdOeFcxY0F0NllhMEJZRGQzMGZRVWFZWDY3OUIzZ2tIODZKWVNo?=
 =?utf-8?B?eEYvWEZKanZKZVcydkloKzdvbFFyNTJzWTNMWGdIRGhvdituZ1pLYjhTcFJU?=
 =?utf-8?B?eUZlUmJqdk84WkRrZnJtRjgwY0VyMkhTT3RackdwWDZuS0ZhL3NsMlFJc3F0?=
 =?utf-8?B?N1N3dFRwMHltakFCMmVOVktDUVkxakI3dXpUeS94alRuL3VpUUtVdlF3UkNt?=
 =?utf-8?B?ZXhubkV5a1ZiNmRQNmNBQmh5KzRtcjkrNXc1Nk5KbVNrS1BiaC9VUndSZkR4?=
 =?utf-8?B?eWlYYWhtcmY0WnNKM0JQVjVHMEJmR2NrU0JCU1ZRc2RVODBMSkNacTV6dGZS?=
 =?utf-8?B?UUhMU2xYZGxKZm5DU2ZMRzRWUllOeS80RTJCUk4vT28zYWNTUDU2R1NxZE5L?=
 =?utf-8?B?bW1yYnl6VjlBb3JURnBheUU0RjArUmZZN25ZYzdyYjIvNTZzS2xGNlRkanlz?=
 =?utf-8?B?SU1RZVA1aE5CekNBaEJuRVBYSGk3c3c5YnZ3M0ZINkE1UktRWkJhVjV5QTI0?=
 =?utf-8?B?cUhPVDBNN0F6TWt2eGxiU1FVVjB0Nk51Q1B5MGJKQkJJWlpDTXFmTG9GbExi?=
 =?utf-8?B?MXBYbkxkR09ZbjRHdHNzQk5wL1g0RFhhbDE4dU1maUdJM1pmSSttdjQ4YVJG?=
 =?utf-8?B?aG1MdTdSQ01GdzNFblJybXUvb29pOXdaS3dGYUdRRHpEMnBPRDlIM0E1S0Zi?=
 =?utf-8?B?NytmUE9Bc3BjL1ZyMjl0d2FLcVVKUXBQaUE2Z0pzVHFDUHBHaGpHNmJ3TTAz?=
 =?utf-8?B?VXlXMkVrUXZKT0t6bXdUVTRyODcyWkJkUUhJQ0lqT013ZSs3NnBLZjExN2c4?=
 =?utf-8?B?endHNFg4VlRrNkNITGJrSmdDMTdEdElySGZmSnZPVUNDNitoVURHQXJidDhH?=
 =?utf-8?B?V0ErWXdqNEMydjdOSW9mQ1pKVjJ6WVlxdnl4R09tUGhIZnNYZk1kdWF5NFpz?=
 =?utf-8?B?SjJudnQ0VDQweUZDTjd1c1ZTeXFSbFdHOFJ3VTZUdm9JYWszYmNyY2ZSQjJF?=
 =?utf-8?B?VVdwSXZaaEdCNUs5S1pvMEs2V1ljUXpGQlBWelZlT3h2VmpWM2h6dU0yN2J3?=
 =?utf-8?B?dGt2aGVNYjNxeDdrcUdHczE4MitvQklRNm5XanVubUNuVU9lM21zNHp1cTZ1?=
 =?utf-8?B?YndJL0NTQndMeWc4ckxFd3o0K2FtdzcwaFRreDNLbnkwUzJScGRGZElzTkdT?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sOKCCho3FyUcDjGFMGjOUW6Wo9viWwqmLsmt+CNWDFku93aUfiGy/mV1LqIkklJauRS2cKLOfKZpDIbkdxD4DEL0ZOcUFZumfc0wyUbwXMZhhXTSa9AGCMAe87WzZkQ0vbhRCRVNbqPJ6wksXIxyIhzqxfg8RIpOhtkqPZ4AphpliyIsxu2z3+zskfgMgAUtObqwy++ZcEDf2l6qaipFxXLvIT35fE9CDNd4PNzmZF7+4vWSMKyQdUBvV4ggo1uD4UF7zF2XZZJ5FmsZNhqFYee4IysOMqC34e94bFqFg1SPBM3NVBF8tvhIgbMgxlOZentVRFCFKoXDjogwQFAiXOOsrh6SYquEd52u9dOnr8W7gGod673OH7fwhnkWYhnXb7zyI7USJIriFJRMepRn9vDa8kg6uvElvty1znT0zxwnr/t6N0Pmvp4RQjyjQLysdw3b8BTfb2FHUhiNLhWsKdCYeTx7glEGe2DCltHUuuoQu3I9pI6pzF81m7hOztTs5fx1JzL2sDxQIbmdKqH/pqr22dlsbt5BfkHN9ygUhJYb6Z1LRDkI9o20ziPFwwsYxLjADFQc7hbCTcWzR/jeKpppTvasVT1er+gIcXfgNVuKGGywn3+0qqJk0ikKVzBS8X8A/jDidBJJA5/P5Fa23kTRUfqjFrT25rAkxZYfyis9aDKrvEwX8jOf2JpecX2qKiiK3Pbifo5fg0avSh2RVGsGLVeqpu8uzCsvFUlt6svvF6PRSKeJFivvcTgZ4lA0zzzheiyWrWw1G+8M+sPcQud9tM8RErICGKmNRT2MoLyfAbwuBZWODoZJyZM5z6KBO5OnvWnxF6sn/eJePuOa/A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243926b6-d7ec-45bf-f5a1-08dbe5f2e9ec
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 15:52:47.3828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRD9aM/bUZnt9CI/BJvHq9l2DWp2az+g3VC3EcLUHEpkh9T1cXvicQGsMFlsuLuy78oqj6DCFcGTIgkVpCY5mpAkEX/KXpCEqLh5G76dubg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7599
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_14,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150121
X-Proofpoint-ORIG-GUID: KPqorXrrUfupSIwMNjFilLJDcJRtMBgO
X-Proofpoint-GUID: KPqorXrrUfupSIwMNjFilLJDcJRtMBgO
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

On 11/15/2023 3:41 AM, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>> On Fri, Nov 03, 2023 at 03:51:00PM -0400, Steven Sistare wrote:
>>> On 11/3/2023 1:33 PM, Daniel P. Berrangé wrote:
>>>> On Fri, Nov 03, 2023 at 09:01:29AM -0700, Steve Sistare wrote:
>>>>> Buffered monitor output is lost when abort() is called.  The pattern
>>>>> error_report() followed by abort() occurs about 60 times, so valuable
>>>>> information is being lost when the abort is called in the context of a
>>>>> monitor command.
>>>>
>>>> I'm curious, was there a particular abort() scenario that you hit ?
>>>
>>> Yes, while tweaking the suspended state, and forgetting to add transitions:
>>>
>>>         error_report("invalid runstate transition: '%s' -> '%s'",
>>>         abort();
>>>
>>> But I have previously hit this for other errors.
> 
> Can you provide a reproducer?

I sometimes hit this when developing new code.  I do not have a reproducer for upstream
branches. The patch is aimed at helping developers, not users.

>>>> For some crude statistics:
>>>>
>>>>   $ for i in abort return exit goto ; do echo -n "$i: " ; git grep --after 1 error_report | grep $i | wc -l ; done
>>>>   abort: 47
>>>>   return: 512
>>>>   exit: 458
>>>>   goto: 177
>>>>
>>>> to me those numbers say that calling "abort()" after error_report
>>>> should be considered a bug, and we can blanket replace all the
>>>> abort() calls with exit(EXIT_FAILURE), and thus avoid the need to
>>>> special case flushing the monitor.
>>>
>>> And presumably add an atexit handler to flush the monitor ala monitor_abort.
>>> AFAICT currently no destructor is called for the monitor at exit time.
>>
>> The HMP monitor flushes at each newline,  and exit() will take care of
>> flushing stdout, so I don't think there's anything else needed.
> 
> Correct.
> 
>>>> Also I think there's a decent case to be made for error_report()
>>>> to call monitor_flush().
> 
> No, because the messages printed by error_report() all end in newline,
> and printing a newline to a monitor triggers monitor_flush_locked().
> 
>>> A good start, but that would not help for monitors with skip_flush=true, which 
>>> need to format the buffered string in a json response, which is the case I 
>>> tripped over.
>>
>> 'skip_flush' is only set to 'true' when using a QMP monitor and invoking
>> "hmp-monitor-command".
> 
> Correct.
> 
>> In such a case, the error message needs to be built into a JSON error
>> reply and sent over the socket. Your patch doesn't help this case
>> since you've just printed to stderr.  I don't think it is reasonable
>> to expect QMP monitors to send replies on SIG_ABRT anyway. So I don't
>> think the skip_flush=true scenario is a problem to be concerned with.
>>
>>>>> To fix, install a SIGABRT handler to flush the monitor buffer to stderr.
>>>>>
>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>> ---
>>>>>  monitor/monitor.c | 38 ++++++++++++++++++++++++++++++++++++++
>>>>>  1 file changed, 38 insertions(+)
>>>>>
>>>>> diff --git a/monitor/monitor.c b/monitor/monitor.c
>>>>> index dc352f9..65dace0 100644
>>>>> --- a/monitor/monitor.c
>>>>> +++ b/monitor/monitor.c
>>>>> @@ -701,6 +701,43 @@ void monitor_cleanup(void)
>>>>>      }
>>>>>  }
>>>>>  
>>>>> +#ifdef CONFIG_LINUX
>>>>> +
>>>>> +static void monitor_abort(int signal, siginfo_t *info, void *c)
>>>>> +{
>>>>> +    Monitor *mon = monitor_cur();
>>>>> +
>>>>> +    if (!mon || qemu_mutex_trylock(&mon->mon_lock)) {
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>> +    if (mon->outbuf && mon->outbuf->len) {
>>>>> +        fputs("SIGABRT received: ", stderr);
>>>>> +        fputs(mon->outbuf->str, stderr);
>>>>> +        if (mon->outbuf->str[mon->outbuf->len - 1] != '\n') {
>>>>> +            fputc('\n', stderr);
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    qemu_mutex_unlock(&mon->mon_lock);
>>>>
>>>> The SIGABRT handling does not only fire in response to abort()
>>>> calls, but also in response to bad memory scenarios, so we have
>>>> to be careful what we do in signal handlers.
>>>>
>>>> In particular using mutexes in signal handlers is a big red
>>>> flag generally. Mutex APIs are not declare async signal
>>>> safe, so this code is technically a POSIX compliance
>>>> violation.
> 
> "Technically a POSIX compliance violation" sounds like something only
> pedants would care about.  It's actually a recipe for deadlocks and
> crashes.
> 
>>> Righto.  I would need to mask all signals in the sigaction to be on the safe(r) side.
>>
>> This is still doomed, because SIGABRT could fire while 'mon_lock' is
>> already held, and so this code would deadlock trying to acquire the
>> lock.
> 
> Yup.
> 
> There is no way to make async signal unsafe code safe.

The handler calls trylock, not lock.  If it cannot get the lock, it bails.

However, I suppose pthread_mutex_trylock could in theory take and briefly hold
some internal lock as part of its implementation.

- Steve

>>>> So I think we'd be safer just eliminating the explicit abort()
>>>> calls and adding monitor_flush call to error_report.
>>>
>>> I like adding a handler because it is future proof.  No need to play whack-a-mole when
>>> developers re-introduce abort() calls in the future.  A minor benefit is I would not
>>> need ack's from 50 maintainers to change 50 call sites from abort to exit.
>>
>> That's a bit of a crazy exaggeration. THe aborts() don't cover 50 different
>> subsystems, and we don't require explicit acks from every subsystem maintainer
>> for trivial cleanups like this.
>>
>>> A slight risk of the exit solution is that something bad happened at the call site, so 
>>> qemu state can no longer be trusted.  Calling abort immediately may be safer than calling 
>>> exit which will call the existing atexit handlers and could have side effects.
>>
>> If that was a real problem, then we already face it because we have
>> ~500 places already calling exit() and only 50 calling abort().
>>
>>> A third option is to define qemu_abort() which flushes the monitor, and replaces all abort
>>> calls.  That avoids async-signal-mutex hand wringing, but is still subject to whack-a-mole.
>>>
>>> So: atexit, signal handler, or qemu_abort?  I will go with your preference.
>>
>> Just replace abort -> exit.
> 
> I disagree.
> 
> Use exit(1) for fatal errors.
> 
> Use abort() for programming errors (a.k.a. bugs).
> 
>> I'm not seeing a need for an atexit handler on top.
> 
> I'm not yet seeing a need for anything.  A reproducer may change that.
> 

