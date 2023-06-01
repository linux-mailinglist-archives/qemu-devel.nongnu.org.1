Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09041719887
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 12:11:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4fFx-0007qT-J8; Thu, 01 Jun 2023 06:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q4fFu-0007qL-Ml
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 06:10:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q4fFs-0001Zy-7I
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 06:10:06 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3513HH3F020019; Thu, 1 Jun 2023 10:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nqazEfKxnQI8/Vmppk/O7fAybAYV/JKrdVTm1Pdg+SQ=;
 b=rMphYR0tNg4fZ5Xj9VoKRVfdnclERBjkB99I9PH/ftJXjfnVNu2bhE5YVNln60rnA6Sn
 EaeiO92g1PvmQ0VwkAuue/gkKUELr58N/oRQgB+gF/3f8uu9nsH7FXf3TUlpANSVmdAo
 ePnzF0Iuf9Zv7R0blVgkDskd83JuOOmxhNsgAIz7GB6v///MkjuNvMKLzm1esSn6biGF
 Yox6f/coG3LOobgxk/r5cui6HMKNZlHytk0Iz+CizcxhwRiePXXjVkZec+vB7wgkfEaE
 oQZf7Napz2J0wegWribvRG5H2tyWr8/CGduYeqqkJYV6+qBi0A/cTyv3mb2/YepF8U11 jw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjh8ep8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 01 Jun 2023 10:09:54 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3518wQqQ019777; Thu, 1 Jun 2023 10:09:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qu8a76shu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 01 Jun 2023 10:09:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDhiTuZ8AIshrNvScTpCjl85DM22ULTcrtFt6PrSWflE63ryC92M3Kp0TxRPFZF6brBCPrZF38dwSyZp1KLrIJnuLqOkGVFZQTaf0hZox38pL93LPxCF0qkI11IobYaisesHpoxkIeNVZBVEGwjw0QsczcEa1n2xf+Q1ovSdU2A9etUntQzwZbDIlUCw9GMY4jLtff5AsL5MKeLyEjTECI0CyCftAcNc3GZh8VICb0+H5+mDOxoM+SFXPpR14MjbR891wx3uJkJVMK2nAqVMrZ0B1G9ZvR+xhQ6pF4RtexPD+e2tm67hkRsfH8KsQ8yTY8PKn7G7BNDH0KpLsh/Blg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqazEfKxnQI8/Vmppk/O7fAybAYV/JKrdVTm1Pdg+SQ=;
 b=U0sSSSUCM0EWlUHuIB4LqxAw/m1EVZjEcij3Trk0y/H8wGFdoVp1xzOivi12RG/586fNR/07kddOQntjwVv062Lk3k6cv6kv0vRfIlSQ6+FdhOcNsbTyJZF7O9CsrBvJn9o3gYYQd8tSbx+nqdLvtNiHRB2ARJ14dAOm39T0d5EhQ5WD2LmMIY+roT4IoequYkEjCgjhOoLzpkt6fEk1nBof1dHZzB/WcnWDW2OjvyDgc4w0v2Ghi+KirEwlpCVi76xDXRNBRiV12RumChT1XfvRNt1C96wJr3ESOxw4FqZXzSIFkDA5kxClxT33QaHrAthCb+h+cWae0QivSvZE+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqazEfKxnQI8/Vmppk/O7fAybAYV/JKrdVTm1Pdg+SQ=;
 b=yC1YLR+l+tJk6Vne+vZ740Xt9KFcpDBBDzOQW+ewNUV7tOlJZlEQ7zAmXfBaTfC9xkYKLJGNUgS8bCw2luVi6e5xO0bMMmOybTx3HMFkbBGoBydeqAJLpyH7T0fiQaKGbtyoWstsPehwmitsdRRSiaNciHZlmxcERUYsOm330EI=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by CH0PR10MB5307.namprd10.prod.outlook.com (2603:10b6:610:c0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 10:09:51 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b176:d5b0:55e9:1c2b]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b176:d5b0:55e9:1c2b%4]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 10:09:51 +0000
Message-ID: <39a49814-28d8-ffc8-42b4-3af14bb9dd47@oracle.com>
Date: Thu, 1 Jun 2023 11:09:45 +0100
Subject: Re: [PATCH v2] pc: q35: Bump max_cpus to 1024
Content-Language: en-US
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, imammedo@redhat.com,
 berrange@redhat.com, jusual@redhat.com, jon.grimm@amd.com,
 santosh.Shukla@amd.com
References: <20230531225127.331998-1-suravee.suthikulpanit@amd.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230531225127.331998-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0149.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::13) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|CH0PR10MB5307:EE_
X-MS-Office365-Filtering-Correlation-Id: ddd259f0-a87e-4dd2-9aca-08db628856df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3S0voECV4256Nwjlb93C7ScAlLerMG0ArnAgZysjOu+BctaCiQUR47i9G48k17WGXCTYDsKOz4F2NQ9pAbfGDK8iPdGueIT22DChQ5Nb6J7aoLjX7aM4Xfge9SZ/7TQmsV6Or2lhHlJIDcMStfnxUkHMsh+cYSYFe//nG3FQuPJFBZvm1HJDrV6r4klFkpoB4eKnSoLkOqKJgcqsarI9GVBSXyPRmVq4nEVSxhBBsEVksIN//Vnc4IZUYceRAtm2j0H9ts4v8qksgrr91YWZYi9xxoa0ZNP996AzWE3JUaGXuLaan/zhUfwvbrUq2UfYINGTjlg2TEVoFVjIObbWNO7aNL+xVi8EVwxF0wFyy7XYigz4pyV32pRHHvasjt5xEGIR5aqLGYhHqW5eb5CqIRZOFdPVZgyIFygOTz2+SMgXAvB8vtJ5lZWsCi1HKa2WKLjmFSX374ZAej2PKVI4qf7WngA+d7HQQfCjcMJNRWV1455HsKRaeByR+s5IMq/QW5KZn9dKPrXyNcyiHl6lxKto47qH0GLNdQ3iaGtCQGaHujWFiOJ7EDdK9xLjuW7QAHiM8D9viD5GB98SaP/LBKB4Z7EO/htBFdh8H0jcfWYiyyCilf/g7dLQt1Zih9CX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199021)(83380400001)(6486002)(316002)(41300700001)(6666004)(7416002)(53546011)(8676002)(6506007)(6512007)(26005)(36756003)(8936002)(186003)(2906002)(5660300002)(31696002)(86362001)(2616005)(38100700002)(31686004)(478600001)(4326008)(66476007)(66946007)(66556008)(21314003)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFhGdXh3dTJ1V2laZ0E2YWd3bzlSVjVlWlc2azZFR3ZEZU9zM0VTWitFM3Ew?=
 =?utf-8?B?cmFXWWFiYmtLL1huc2xLNHQyK1hWclJUV0VtUWJtUXh3RG9TUjd0bkFtTlB5?=
 =?utf-8?B?b2xDS0ZxRDBZTGdQUHV4RVNITURFT3JzUkVlcU54bU8vemZWb21SNnR6OVdr?=
 =?utf-8?B?SFN3aE1hREFickdZOWlQek52Z1NhaUZBR081UTY0bzY5cnFGc1lWdk9uUmh6?=
 =?utf-8?B?d1M0Ym1vNUZjd0pxeDBWTFRVdnYrNG85WXF4dHRZbFQvaW1hZm8rZ0FWdE5r?=
 =?utf-8?B?bmZEam4wTTV0a21uWG1UZGZMVjRtSy8rV3JyUUcrNXphNlU5alZZSmhkSG9w?=
 =?utf-8?B?NkN5RlVpVWYwUXVDQ2VTQ0h0M1FJTUxpOFZMbXhiMjZ3MVA3MHVjK05tN1Qw?=
 =?utf-8?B?MzRBaTB3RGlDZGFPQXZZUDJwQ0lHWHoxMVUwTERFaUNZZkFMcFBNSExtZW5C?=
 =?utf-8?B?Y2prcVQyU1lIbEtoT0hEYkNPTWowYmNZSzNGUVJRbENQNGFLLzhGak1Uc0ZN?=
 =?utf-8?B?Z2hJNTNSMjZacEFHSzJWUjV3dHFlemxRZ2x4VjN5d2hQM0dwNEN0Zkg0NUxS?=
 =?utf-8?B?cHhiVUpXSWRkdGZvelJTdkdUMXJaQ2ttSEh2eFErUTkxaytZYnZvbjAvL0pT?=
 =?utf-8?B?MmFBWFdxVlJRVno2bGlDeGJHc3RsZFMyL0dsSjI0WkcrY0pQbXdNMFRXczRE?=
 =?utf-8?B?WGNESytmTlNsaFhCOGhOdFZlc28zUHBna0Z4S2szdng0RWpaUHlpaGNBOUZV?=
 =?utf-8?B?MmhWOVZxQUJDMkxaZUtJanBQNWxHa3VFTUhmRDJDTGdDS3dFVHY5N1BBL0Zp?=
 =?utf-8?B?Mnc3QnY2TnI5VEFMSTZjZnNIS250TjRKK0Vja3E1MTAra2lrV0I0V3ZyS0pL?=
 =?utf-8?B?QWNBRGo2Y1JjUDlMRUZlQUYwVFdGU2VWdjhwaUZ2S1p0eWtpVlNUQ0hjZEtR?=
 =?utf-8?B?R0pxbWovdGZrTmh2Q1A0MUVodyt1V3JNdjVrSTM1V2VoaTMzOW90MDY3ZWZH?=
 =?utf-8?B?bmw4djZJL21iZU1UZU5CMFh2dUcrQjRsWHlnMDhnNFpMZVpHaElYVnNTSGhR?=
 =?utf-8?B?VS9rWjJCWEMvc2JlUW9TK3MxSmFjZEFPOFoydVZZNGdoTGEzSGhoYmk4VVdi?=
 =?utf-8?B?WWdnOXc0MG84UzQrTHF1UVVMSzlSY0FzQXFtVjdxS2dNYlJyMDRoY3FhTnph?=
 =?utf-8?B?MlZZVjVQS1BkSFNCRUN6WkR2RnVoVmdYM1VtcHRqNktDOGxlZXFOdEdNZVlM?=
 =?utf-8?B?WWNTeUdFUFJDeUhOdXlreXpmaGJoQWZuekNNalA1V3c1bW5wTEpRSGpqZEVE?=
 =?utf-8?B?SzdNU05rM1hFMVVqdzlwT1NoRXN2c2ttNnRacnhmU202RnRNWmQrQnRrTXNx?=
 =?utf-8?B?UXJtMFpOMWxxWXlSRWVWdFY0RUR2aW1NczVaT1J2WWpvWlExUmJQZXlhV2dH?=
 =?utf-8?B?THdaeWVaUmVvUkNENnlsWUEzSloxNEdmTHlwZVVDd0tSdW5CV1JERUwzR1Bz?=
 =?utf-8?B?M1FGY0V3aU4wekl1SkdBNGR3bUxUODhKYW9BU3ZnanpxcVlwbXlDenAvcitK?=
 =?utf-8?B?TFpySDlJa21SNnV6aE5EY2FYRkF6c2Q1LzZQTDBXVmdTWnd2WGFjb0ZuRHhZ?=
 =?utf-8?B?Z21oODVNU01wdE1pdUtvTTh0NUN0MzhGTjhoUE1WWHV2TEdxeVJtVUU0dVJH?=
 =?utf-8?B?WkJRY2ZXLzRKblp1bTgyTFpNQmVFeUpJL2h5cDlpYlZYMUd5NGt0QXlQT1Nq?=
 =?utf-8?B?VlZkb25DQWdBUzMxUHZNREltU2R4Y1BzSDdkclhneTltb1dvaWQ3WHp6T3g2?=
 =?utf-8?B?MDRJM2Zqa0dISWJXZ2I2bjZmcTZBYjJYME1ZNjlOMXlpd1ZnL29ObkJGVWov?=
 =?utf-8?B?TVNSMElLMEpwM2R3UVlVQ0E1V0xITHZaWWRpUlpVZWJ2bW1wQ0tidWJHbWFY?=
 =?utf-8?B?Nmwyd2daZWtVZ29kWUFXN0NxcUxiWXZvQXJXNXpnWWZhU2VpdHpORVRrU1p6?=
 =?utf-8?B?K3NUWTdqcWxUZUZ0UHJadklEZ1JVZWxsMTFOdXpRM2hQWWQ4NVJmMldJNmdx?=
 =?utf-8?B?aVdJUWFaM1hkMHkyZnUvSG5lVmN3SVo0blBaLzVjU3NoUnQvWDdwTkVnOHY3?=
 =?utf-8?B?S0NaQWs3c3dObWdVTGdudjJsK1kvY1hxa0lDdVdFVStrV0hVeUNIMm5iVkd0?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AOH9bLVVKeMg5tTe1hcOM5viFyNIdjPphz5Z6oJ45CCEaU2c+UeWLoPUpyFEwQT01t7y9bYK0V2HATRhwfMMK6dyEcytEIhZydwKIVCqzswjKXEny12h5sqP1RG1BoPLZ+D46p1NqmtbOfpVMFQz4qfLC4+xDIM+frMYaDrAfiqw99PVACrjvw0rQDiWBgUfe26uwODRe4Z4TXDrOTxxQ0umJIz9Zi6t9Tqc8KRs2eD9431mbCSUGgt66F4ZxCFGHTPkp440rvB0vmuWXVKO9s1gwMyU/BqSos6YCH4c4onFMdZYrMWjuy185smMPTaJl3XypKBUVPvTWvXkNRDpwEHtpIAiSC2ZpxYxM5d2xZqRWJNYORZrtR7+E3/OM7HBfS2dVPyKfcFLMTPGMhHqwRfPkVVAZ0iEubMqoIOJ8/nkBd4X6U8oWtevJ/t3e1T1T7lox/WwTG3eTpHBRS3gT7FcZQsz2jE0MLfJsf5cow0l3ZMDZa3Ga6pHHQSkG2gi3EYOI/5qnctdz4GY1+boWQLzELiO6GhBc3pmFz0DVklR06B8r4bXY3vtcVEREwWZmyxgsd4drvoPxfVYbdAF5GpWN59EFeQ2t6E8zGD0QafUgPvdwrZ8ogknfLkxpDnPzMo0/rbh/tJHsWQM83FZEf3EvyocT4+3YbaUeDuMx67UKvIavjr4C66LF151KueqD6N4FKQeUGVIZK+aBXQfqTIaiN70uHDM9n0NRAr4OpqNIFgt9GO7O0/ncxKAq3ui58IhPseH+OrhALObB79aEvY4Gbsac3OdNjEj+7CWQVLAnUgB8hngnHH25EmUbXyar4/woWZgZSIx4nUkvjnoDruNns9qPFnqd21A37SdHJ77YxUlX9sg35OllGKuIs5l0ydhb9W200QPwQsXKgQTCA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd259f0-a87e-4dd2-9aca-08db628856df
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 10:09:51.7732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgkLXnki4SMniyy7IFEbm5FCxULPAM1AHZs3cuD+sH23rJFNGKcHAFloJhE3TtwSvamK0r81DDNtQmhMiDnx/8Om3dEJWv9Zq8IS3nzD9lA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5307
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_06,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010090
X-Proofpoint-GUID: 1KHf9RS-KY_6dSa9RI3GF6UAtuMok_LV
X-Proofpoint-ORIG-GUID: 1KHf9RS-KY_6dSa9RI3GF6UAtuMok_LV
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 31/05/2023 23:51, Suravee Suthikulpanit wrote:
> Since KVM_MAX_VCPUS is currently defined to 1024 for x86 as shown in
> arch/x86/include/asm/kvm_host.h, update QEMU limits to the same number.
> 
> In case KVM could not support the specified number of vcpus, QEMU would
> return the following error message:
> 
>   qemu-system-x86_64: kvm_init_vcpu: kvm_get_vcpu failed (xxx): Invalid argument
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
> 
> Changes from V1:
> (https://lore.kernel.org/all/YnkDGsIi1vFvXmiP@redhat.com/T/)
>  * Bump from 512 to KVM_MAX_VCPUS (per Igor's suggestion)
> 
> Note:
>  From the last discussion, Daniel mentioned that SMBIO 2.1 tables might
>  cause overflow at approx 720 CPUs, and it might require using the
>  SMBIO 3.0 entry point. Also, we might need to change the default for
>  the x86 machine type to SMBIO 3.0. However, I do not know the status
>  of this.
> 
I suspect smbios 3.0 (64-bit entry point) is already supported.

With current qemu and all the smbios fixes in the last cycle, perhaps this is
mainly just setting smbios_entry_point_type to SMBIOS_ENTRY_POINT_TYPE_64 if
MachineState::smp::max_cpus is bigger than 720 (e.g. in pc_q35_init()?)

> Thank you,
> Suravee
> 
>  hw/i386/pc_q35.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index f02919d92c..e7dc226bd5 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -370,7 +370,7 @@ static void pc_q35_machine_options(MachineClass *m)
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
> -    m->max_cpus = 288;
> +    m->max_cpus = 1024;
>  }
>  
>  static void pc_q35_8_1_machine_options(MachineClass *m)

