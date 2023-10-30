Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B197DBD8C
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 17:12:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxUrr-0005oU-0d; Mon, 30 Oct 2023 12:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qxUro-0005o7-MJ
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:11:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qxUrm-0006tU-BR
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:11:52 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39UDDFEQ020890; Mon, 30 Oct 2023 16:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6+IG2WGyymR0KFiSl5GeckLJo2blE1qsWDus28/Pv24=;
 b=vexdbFWXH0HdjH08mNjRLrU6S42No1ImRol4Nc1jcFmAuSDqqMTsDNjggcZksU4Vqshk
 HWUKe0tsuKD4j6rrZokW6fCbHFZ3rs2ng2cepFV64Hgj10UgKhOabnPG9xmvwDWcml8H
 tcKTjPQzXA2G9eb80HBZ/U4GMqTnn9b+nbx9MUsFP19mbwI9MiHh8BWg6svVMBoQtwhI
 cv6mjg4kbj179IZOKpOUvo/Zudlufh8lhrfwyTg44ad4ehG5lYrJ05tICRzEGTaKJMK9
 8K9p3xHYvpwjvG3ufZ92Ey5mSw3d5BZXb7y9DxYg7xy8eJuLiAGR97jCRAl/bBwwD4A1 hw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0swtk5mk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Oct 2023 16:11:46 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39UFa3J5001038; Mon, 30 Oct 2023 16:11:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3u0rr4uhej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Oct 2023 16:11:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3T3XoBhx4G/glRGhIRZ2iMCMcObm5moSaEcfC7by0nZhWxISP1Isz/7fPJqALx0yioesp6Gu/x8bfiIpKMQsmqA1UC941stg4uXTNsLvoDvtGHIX4dMOpm21DU8F+dG+MfMl2gO/QSstXyznoXrtnKH+FQG9IXzThDdHxezVKTMgKs1YdvbfYWy6FtUPdX9fdmQgvsUHWOMmk68qrwOl9DayOmT+YTJLiCnAaSCkvb2KwzbIwvoMJUcMWk8MmRotZQo5st+A3GujmlofYZswr7PiGtEDKH9Z3b9QBVGSwXt9LlYta5t9OjpInC7YOEo/rkagxTcg0ollb+0wkyvAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+IG2WGyymR0KFiSl5GeckLJo2blE1qsWDus28/Pv24=;
 b=PxoEP+a8II1pNbJNbn5P8b3pQ3ixzNvQERZKbwu3Fx/Bl+5Z8/DMwTuXYqNVbrZaKxFr1d2tBSaSn7balHslyOgtrV9LVCl/udUaozQL04TpP9jdFguk6Eo4xm3B14XbcUOwpqd6yL7+hYUtr7hL06gDjwSGHo7wLEl45STiCXioT+mF8NBWMbybKbXa3KmtaWL8jutclJck7smFEl453evwDD2OhNx8t0hoPFR726L+16d7JjsqtUc7U6OeMsRnKyJC7792vcd00bOnZ2wHx7OUePfCXFpsh928GiQ4ZL2qeeB5yyw3jglX8OxslZkImbpUVNX3GpvQEoAbXyRUZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+IG2WGyymR0KFiSl5GeckLJo2blE1qsWDus28/Pv24=;
 b=QXYQ4XYRd/fWcwLgWZ9PBZi12XmB4H89+qpqCqpF/U0NVSxjFGR+gmVQ8RHM5wQg8hze5AoUM+EXlJYS4g2yoMDVqcp6EnTFq5NjX5++pbqfCTd0kJvC4GisvLkmVc6qc5HnW90WlHU5G4Q1sBBrIHkpAUQ4Ow/FczDMEJDVRME=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by PH0PR10MB5595.namprd10.prod.outlook.com (2603:10b6:510:f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 30 Oct
 2023 16:11:36 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::c8c3:56ba:38d5:21ac]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::c8c3:56ba:38d5:21ac%3]) with mapi id 15.20.6933.024; Mon, 30 Oct 2023
 16:11:36 +0000
Message-ID: <0a08cd54-49bc-4d03-a979-b10faa4b15b0@oracle.com>
Date: Mon, 30 Oct 2023 16:11:31 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] migration: Downtime tracepoints
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>
References: <20231026155337.596281-1-peterx@redhat.com>
 <c8d16910-a496-410c-9c1c-68661b81f030@oracle.com> <ZTqb/XDnwhkTUL3s@x1n>
 <ZTqtieZo/VaSscp5@x1n> <778f6c92-221c-41d2-b0ae-4f5f4a208f65@oracle.com>
 <ZTrHAbyDxLsDl007@x1n> <af899e9e-a1b6-4682-ba83-6d0267e46247@oracle.com>
 <ZTvMEqYYVS4KjL0F@x1n> <e6be9230-2f63-4c48-9db4-5eff2c4399eb@oracle.com>
 <ZT/IM4gz6s6PfKg8@x1n> <ZT/VKagmVpzDuUrd@x1n>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <ZT/VKagmVpzDuUrd@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0426.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::17) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|PH0PR10MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: 4754ccc5-a935-4751-de38-08dbd962e430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OjVGuCqebh3h9QFkg2mPYP8WqUHHO0qfUmrFfvJ0ACTHggKVr66lqya6E08T4CN/9qM2Xm+OSbvsFPbHB35I2x0q8lKVFziwkAprYlXuJkP3qFSWUoo6D0Ou5WSP6fM+lRiig1czsGFCoWY9zFPY2dpWu3aqUwH1Qf0inBXh+fN+JYSxt5JG30HZZEn4UbvzVo5nheNMIVtS8Z1Nzgkz3bcpWl1VgbbZIhnZtXZwY1asoj3HGo75I66tYt8mim3yWqoOJRKGVJFfIX2zBS3dJS0LiFWec2CiN1YscjpJKcP24qxxjxvEdHOAJbCbJC0Ln1ki+pYG5k21j5G3bzkXFkoBZJX0za+/iBRPUDSl93KZMyHmMUriDtsbopYi103KY+3WhQNCEJE0/kWO8LzqfhdDTiWiuLrSS9K2Sxzpum657QkjWJT7TTsB0L6oFoIJ4HgjVuQnNDc+PVjoPxy1kQKjo7vXRanKfHqC6vy1Jcp5PvppGa4mrEP1RnaA4fXrusUUcO8hoXMGUCsVHOOe9Nq1FuBea1wXLDGodHmBs3Dvr3XteRhx2si98Cr2MsDsSdkj3qFCQ2XhzOj9Td8RmaLH1wRcMwqpZbjxI2UXUUaBvEWPgU38tvREVLuV6GSC8oG/wJH7aUXbmh1zFAD9hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(39860400002)(396003)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(36756003)(5660300002)(4744005)(2906002)(31696002)(41300700001)(86362001)(8676002)(8936002)(2616005)(6506007)(26005)(6486002)(4326008)(478600001)(6666004)(83380400001)(6512007)(53546011)(38100700002)(31686004)(66556008)(66476007)(54906003)(66946007)(6916009)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RS9vT1JqWW9MRHpkLzV3UExBK3RyQlU5ck9QOVRaMGlOaHorOS9CSG9iMmlP?=
 =?utf-8?B?VnEwaG1HNDhkL1J5QTZBd1lvRVhBYk9ZUDNINTgxM1M4WTNSdGJSem1qODJm?=
 =?utf-8?B?T1c3bUdOMGhvZDRQYTZrUUR5VkdZY2l3cWhadVBTVFFZYkNjeFVWOThTSEo4?=
 =?utf-8?B?b3NDcjBNeFZaZUlrb0t4RUFEcHR4UmFyWWdnb0FQV2VmaFpNUWxMVFJhVEdi?=
 =?utf-8?B?Vm5kSmkrWUlSN0ZrUzNJdFA5T3M4R2RTUFU2WVdrRE42T0hHbWp6L2x4WjZN?=
 =?utf-8?B?Mm1lZzBpSE5zMlUwempWSTlBTFJuU2FwSzZmOWU3UEhzNWVNeTNTRmFDOGpH?=
 =?utf-8?B?WWhEOEhTeUh1a0dldlhwQkJwUjgwUWdDRDdQZEV3TUFBRlNGRGpjQ3VjdXY0?=
 =?utf-8?B?NTVoRUZSMUNlR3k3UFFkV2hscTJROExtZEdtL2tBcHFhMXZ2M251VmhadnN4?=
 =?utf-8?B?WlZrRVVNRWQ0aVZXbFJ6MkJzRnVaSEthRFVVSzMxRUx1VkpMMytYWThzNHBZ?=
 =?utf-8?B?ZnVMM254YUdwTFpERmVJUVBoY01DYWlJbGd3Nno5NnpuMUxWeXd5bVJyS2po?=
 =?utf-8?B?dFh3aXZPQlZmcTF4RmhEc0t3QU00RWw1U1JmUnpzQlR1N25TV0ZhQk9ibGdj?=
 =?utf-8?B?c3ZsWE9tR1YyVTFrRDYrdkJPa0hvM0swUVlPbzJKSU9IRlIvKzRBdmlTSUlJ?=
 =?utf-8?B?bXkyaWNQVW9oajBWTURDc1A5ZzVvRG9QM0ZtZ3RCc1BwQVB3WEgyeThwME1F?=
 =?utf-8?B?ZFJDdDQrTlZsUXdKdEl0YXNxZUdmTDU5dkt5U09tNXA2VXFUK0NLRGlodW1i?=
 =?utf-8?B?S0g0V01WYjVzQWx2cittcTF5Rm1VN0JQdVdWOUJLUE5nWmQ2MUdpMXQxK3Ux?=
 =?utf-8?B?TVRIQzRGKzIxQXJZQkE0UnExS0xxQklrOGdDQnlUNU5EVlBKZXhXTk1rNlB3?=
 =?utf-8?B?enVJNXlTbzhUeEt6M1IyNzJJVWZTdFNOSmxTODN2ZGFmQ3NIZVpET09pMHVn?=
 =?utf-8?B?L2hrUWpCenI0aFE4QnYrV1ZDVUc1N282L2NaczZRS2RPQjF1eER1cWszdXdC?=
 =?utf-8?B?akZaRE5YRC85SUtPOWRmYXI4ZG1CTXNYRlB0KyszQnJsck13bXRmOTRlUjlN?=
 =?utf-8?B?TCtORFRKd1NhYUg4S3k0SXBoZEJVaDNhTUZaNjhiSlpxN3N6YUdrYWljSVov?=
 =?utf-8?B?YTQ1UHpUbDQwOG5xU2JReFZCL1ZCZXI5RVVPZ1U1K1h5dnpscVUxUFVDZmtj?=
 =?utf-8?B?Ym5rN2J2alJtZlJWVFpEamVWNE1DSjFTNlhBUWd2NkpnK2s1MC9CYkVDOWZ6?=
 =?utf-8?B?TXBSRXZ2b0gzVGxXMUxubEhoaldIWG9OR3RTMHNud1pmRldUYnVoaE9PNkg5?=
 =?utf-8?B?VVRsRDZtVCsxV2hGZlhlK2ZuSFduR1FwZ0RpVVVleFZTQUQzOVlURk42S1Za?=
 =?utf-8?B?VGFTanZWV0p0aW9nMk5ZS2N0MWFxWGViMkM0V2pEZU1rZmxIRTlpTFBRRW4v?=
 =?utf-8?B?NjJhbkJmVG0wQ1lOUEd3THRISS9PRWVrNVc0VjRJMVoxMXg5ZFNsbWprNHBp?=
 =?utf-8?B?NDF3cGxlcVFXWTJmL2Y3eWh1eEd6OXJhWDZwRlRtRHNIaW0vWUtJczZWZFl2?=
 =?utf-8?B?ZHd5QWcwQ3hxZWFOcVNXVjZ2UFNXaXdyU01sdjBtL2VpVFY0bzBQWXBVcTZm?=
 =?utf-8?B?YjNyMXBwVGpPU3Byamt4NGZrTEVQN1pFZTBCUlY4VG1Gd3VlWjNBbUw4Y3hl?=
 =?utf-8?B?UnQvMGlWS3EyVmVDTzV5cHlvYXNQQUxkbnR5YXhsR3JpUzZiV1U2N1NYMzE2?=
 =?utf-8?B?OG9IcTZUNUtRQ0h4Ky9DZ1pGanlGYzhWTmxYSy9rcWM5alhIRU5hZmlab0RZ?=
 =?utf-8?B?Q21IbldiZmhQQS9sV0NyTFpiYUdRa2RZdlRVM3RWSlJKb3ZWd1NQbG9YbVp2?=
 =?utf-8?B?Qmo0Mzh3enR3ckZZV1Z0Mm51MW9kenRqVmxYUkk3Nkd0UXZGUkNJYzhJZnU3?=
 =?utf-8?B?djk3ZnJkNzdnd3FIK1VvY0pmamF0OHArSnVFVEZ2TitOUklnY29PR1JBOU81?=
 =?utf-8?B?aC92c2JISDJsU3RMUnkzZHNKMVNPVTFzeEdhdUJJQStjNXFzYS9XNFU1OHFN?=
 =?utf-8?B?U3VvcDlSa0Z6cWcrMFRacU53T0VDNkRLNWcxMjB1T2xaSVlvUGhPVjBxWmt2?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2/6zWVU9ZltJV4G9Nh/G5bP0qKhgzRSr2WYJ5rv0Ry0GBP2f8JEcQwW7P90rGi5wjzjq6inSt9X4fi7b71AxfHv2XjDPqwJH8jQRaQykMe6+H+stxaOaBdCEtFkVPMzLb1lYo4cGbVkOMAdOW+dIUou0ZaadUBJbn+98jM528sYhE5BNKwy4UUrvVhb4K9s7uYZE3jew1S4evpRiPuH3cYG2wKbvAVeQmLqmzMMAaoGUBnFLAbPBCA4CfrcoSyi619ci5Oe2wegowt6lSLg7lodCOGJ8SuCpbJpcoiKmWPwZ7v6/LU/mYztrDHxTvDz3g9D2aJqxe2mootASw0Bz3PUVxGwmatLM2pKzL94VMX2eNohsE9X0CH9RwjSZ/f++TvfxMz3yI0b2ah65N21JAB4DpqQjmA3b1+6EddiroZzMu9+REKV8If+B9hvZax4ImVMzrqh3j5sTEp7OAC9PocznA8XdD64baGQSq80JFFzQALFSHUgj7fVjX0rSOSab56HsmqcPh3FxbRrXkl/jc+G/HiJxRdp243gjGI3WHqly9KsfVH8r26ZkQW41xFO+kPF98lA/n3NOpx9kVeOEnvycd4vAFqw+Qs1ncXex+gQtutarlgSgXwX3Q72os9pAlvKGcn0zKxINhkJ6LWTXa0h7gRIZdllace4xRi1sCBmPBtjnwm13V0B11IDEDHrovuDwvqoEn2zFX8U63gx4ZSz+98XHDUkjK0eSK/QKghzT1QFj901PV2xryvqoyG3s80AOqHF5qXDlcm25TWIvNpPHJzEXUwOxcVEMvlmflQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4754ccc5-a935-4751-de38-08dbd962e430
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 16:11:36.3301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpSqnESMuwEKJtwwNMy076P7sJkgOkpscCWn4QTYENgsFkcRry6RmdF/PkkQ2UcV6V5DqjEp09avwphZ8leIRJW3OwFhJKAtp4briTxI2Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300125
X-Proofpoint-ORIG-GUID: tdUkc2E91R591ZmuMALY_Y9LmD6TrsSQ
X-Proofpoint-GUID: tdUkc2E91R591ZmuMALY_Y9LmD6TrsSQ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 30/10/2023 16:09, Peter Xu wrote:
> On Mon, Oct 30, 2023 at 11:13:55AM -0400, Peter Xu wrote:
>>> Perhaps it is easy to wrap the checkpoint tracepoint in its own function to
>>> allow extension of something else e.g. add the timestamp (or any other data into
>>> the checkpoints) or do something in a particular checkpoint of the migration.
>>> The timing function from qemu would give qemu own idea of time (directly
>>> correlable with the downtime metric that applications consume) which would be
>>> more consistent? though I am at too minds on this whether to rely on tracing
>>> stamps or align with what's provided to applications.
>>
>> Yes it should be more consistent.  Let me add them into the checkpoints.
> 
> I just noticed dst qemu doesn't have downtime_start to offset..  Only
> offset the src downtime checkpoints will make it less consistent.  I'll
> leave this one for later.  Posting a new version soon.
> 
Argh, yes.

Somehow was thinking in source only -- let's leave for later then.

