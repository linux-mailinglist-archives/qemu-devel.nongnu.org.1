Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D1177E7E4
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 19:50:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWKdT-0005LC-R7; Wed, 16 Aug 2023 13:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qWKdR-0005Kb-Dt
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 13:48:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qWKdO-0006Pi-D0
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 13:48:45 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37GH4DjG025339; Wed, 16 Aug 2023 17:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=A/rxnCYorZUcRO1dXRIX0Y6gQ2fG9YMbxfcnCpXBhqQ=;
 b=lHKFmbeNWmuTcB58NsOjbmoEibNE6NQR1a6w1Tig7k6XZC6q51ulZLZdxKWc/navqVSm
 /dP09I3VyKvuhayRpDTTtpTETWDtTR9RodqnmQx1QMQgehdqZ5xF0RH59q0vYRiitwJx
 kwrrlcUjm1bl4oligEwzpbVdSHDbrkOUEkN8ZDV7kUm1NKsaQHBOYVpZNowVVBalkb/O
 WesoKje1Ox9+hJTAN6t0VvuTS8AZsgEjWNTj65DS1txoCDZyywgnFM4ssWs6WWUP0s2C
 vpOmLM1D/bBYxTuKISDRjglIHPBExG+iq5gYShXVlWmtTos4FtDIP8jAK7Nit9NmRKxD mg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2y2ypyx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Aug 2023 17:48:38 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37GHIrB7003725; Wed, 16 Aug 2023 17:48:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3sexykjxkb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Aug 2023 17:48:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUmUmnd+gu9OvCC5p/mLadMaHW9mk18B+wj2xU1JgdnYBczoWW+BZ+6aTFx6lmNwNpAcCVKKm36FOynPWl6p76yBnAy7FVLBrZtfD73LFqFI6OPYsSEFdxKT5uIYaVj/5KVUy/1/V5oBZ0QoZYN8gsE1iKlnJbI3Gfi1KJN86ouHJJB5GlBfvobg9K/0fC7YUKgqdLMw9jdBuAFPgiQv/6XL0h+txroD6k/iaRUZwECfyp8fbXiO/QXktpmTlZEKrUadVkf1Cu8lhk7u4sXgwEfoo+IZjU9eyT3RJ50Cf37ILLviMr8M+SlX9j+7IQGOr9HpnmOOgcJCgCjI9tsH+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/rxnCYorZUcRO1dXRIX0Y6gQ2fG9YMbxfcnCpXBhqQ=;
 b=DiwnVZuHErV2mSPNxrrKLDQBm5e5HPUEVgnGd1lj4gVb5uAJxYHvzDhtXCSP32nLlfyQf5scqgMVpcag8NFstOlKOkfk9mpqAziV8rpRKfGXsoRk/Ye/mtjQlSNre/vxSqyYrCTpefupgkJtsiZXhhw6PWDaKBoI/EfRgaomR0pbRA/Gd2BcERWna+1VVPjmL1SiIOjcQuflopO2E/ikwn7YLSuz3a1mbjbczjq7PskudtgVNflx7I57s0FIf7jZv6BlbrpinLTUpLqlxD1JzFtq9JTGxyuI7BLgfchkSih0NmonLc7PjnW/SZAqQLom/i1fdfdVC/IQ8UowAoB0fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/rxnCYorZUcRO1dXRIX0Y6gQ2fG9YMbxfcnCpXBhqQ=;
 b=YAMI43DfjTsrqt1ueUlSvPZRXoi0xc+21PTTRC2goGPrH8paY5bYmkii4R1+a94eyxOyr6duj+hQIC/eRoR6Pr0ZvmGf5OwjH6URdZHsAjs6N+YTsm37P3pOUbB4x+l9YBnR8aDHjaya8A7Pip1lSBx6D/kDRa+N2oWWjCAeO64=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by BN0PR10MB5272.namprd10.prod.outlook.com (2603:10b6:408:124::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Wed, 16 Aug
 2023 17:48:17 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d324:ad85:4523:fbb0]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d324:ad85:4523:fbb0%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 17:48:17 +0000
Message-ID: <22f21854-9565-65af-7794-ee2007e7f1aa@oracle.com>
Date: Wed, 16 Aug 2023 13:48:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V1 2/3] migration: fix suspended runstate
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1686860800-34667-1-git-send-email-steven.sistare@oracle.com>
 <1686860800-34667-3-git-send-email-steven.sistare@oracle.com>
 <ZJIeR7svXvtHdgs4@x1n> <6adfae20-60fe-ae08-1685-160b2a1efab5@oracle.com>
 <ZJNdcyrv0TzFUKMy@x1n> <340b5f58-0924-6f8e-6f82-0462a5cc22cc@oracle.com>
 <ZJnYlApmsQLXBK/3@x1n> <918d1568-fa1f-9ebe-59f9-3e5e73200faf@oracle.com>
 <ZMF/ly/FyavT9AMJ@x1n> <9383f79e-561a-aeab-5df9-0501e8d0a831@oracle.com>
 <ZNqClofhPByQP13H@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZNqClofhPByQP13H@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR08CA0036.namprd08.prod.outlook.com
 (2603:10b6:4:60::25) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|BN0PR10MB5272:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b982a36-a6e4-49e7-c226-08db9e80f924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3fPpOJbx+ns3vYQC38XI0/ZARh04uP0zidGqOAgaARiW7im4s99LbbUrp4wupxksbAy2/u3Vy5kSQI76U4FkloBzun0qYDChKooc4RDiM1uY5nozRXRLemNyoTxyEnh2FknwMSo9dXSFNxZHBeVOopWoD9GQFD38T2uu/+jN9+go/tWrwX59VNZbPshLE7uajhQMsfChfJxFi8ajeTMnv/LRA4bV6ICMs+jaFF28L/kqVSKgM1mpxtkcZ+0kkjynQ6QdtnaQLFsXFEcenkg6fDi0wODy7OjOWPyqmcku+EPYGGsHjyjtPDt1I+2ioX77ks6j2SW2dQqZanZkO+L2d2QbRE6tmfKBw8obkxaLqJAHGaCEkVY/B67cuEw8WXPgzbtF8TMHA9csPaT3cWpeEPVQ7OA3U3Gpqm0qE5YcLH1TksraqcHA01FxFE/fxSssYz49frN+AGAwY4F3KJbog9nMoYB1XGrRsCDFjxKoHYZTJ6csrAItHH7+50aes4QiF6Ci2AaZUNO0agAfwLTFNOszJG+UTqWAAUSTRR5j2e9RmMwJ/nK/LQZwSIKY2WEkoDbJS1f8Sje7EzRpi5hsZA08wqxlQH6PNvIgC83Grd9T6OuJSGWZoRFIAldzZcCs89u7OvszjaYd5+rfFfr53A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199024)(1800799009)(186009)(15650500001)(2906002)(83380400001)(66899024)(86362001)(478600001)(31696002)(6506007)(36756003)(36916002)(6486002)(2616005)(6666004)(6512007)(53546011)(26005)(5660300002)(44832011)(41300700001)(54906003)(316002)(66946007)(66556008)(66476007)(6916009)(31686004)(8676002)(8936002)(4326008)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ei8vVXl6cENhZ2RqQTRUUTVzc1NXOG54WHJwQW5HWXlnTzkxcm5ONjRNMmVp?=
 =?utf-8?B?MmtUeU84dUdjUDVUd2NwVmZZVjhjZFk2WThTUXlTVFAvNW9acTQrbXljWW9x?=
 =?utf-8?B?LzlFaituTjJJaERIS29jUWF0Mkk3RCtVZUs5dUVWUWFHSzFJb3p3SDVVcGpq?=
 =?utf-8?B?Sm1MaUNVaGpVOWRvTDgrYWZycnVRRi9vWnd3SkJIRDdjNXhoT2pXWG11K00x?=
 =?utf-8?B?TG81WVpTaHg3L0pHL0E4SFNvNkNhUmZoTWZZVGI0cDdZQnJXRml3dnNZc2F6?=
 =?utf-8?B?ay9mNHZGZEhCWm4vN3dma1daRktGdTR4em4zdDFLWnVPZmlncEJtbytoQmYy?=
 =?utf-8?B?bHNWNktlb2VMS1lnYVNhTnYxWmlLN1NTekVlZkkyWTRKcW41MjFiOUt4ZEov?=
 =?utf-8?B?eVMzUFJiRm5HdjZDZ1BCeGFqMkRISTBIUk1sQTg0dWNqMHpvU21sRnViZUJZ?=
 =?utf-8?B?ZmxVUy83VmMyRXdSTk5xVDM5KzhnelB0NWMzTGtZRldlMDl1NE45U3RDeVpG?=
 =?utf-8?B?RDVQa0dKY3htYjZ0QkF5b1ZRbUthOUdOd3p5V0dYbTViK0pVdHVTOWtIVkFX?=
 =?utf-8?B?MUVlOHgrOGQzT1BnTUZWRFkzSHlvTkZUTFpURWd6V1FucWl4VWNZcnhRMGxr?=
 =?utf-8?B?NklMTzZpbnNLRStLMXJnSkt5Z0dHenFxK1h2c0hxWCtVSnFBRVhDRXpvaFNz?=
 =?utf-8?B?ZHJjdDZKVnRyVE04MCt3ZlZLWXlSNlZuMDVuYkJrK1hTMXMvN00wcTZWc0NH?=
 =?utf-8?B?bnQvWTBQN0l1ZFk2RVh0WGZJZSt4a2Qyb3Z6VTR1ZWpoRjZVYnlrRWlPU0kr?=
 =?utf-8?B?Qm1MRVBYSFVqb3pnaTBGNEgyOWM5UVU4enlQMGxpT2RWQWJyWGFsZ3o1Y0Vr?=
 =?utf-8?B?QnNPWkVQVmxEeG85UHBXUUJYZXNVM3RHTWUvRHh4K1RHdFkvZDZOTlBGVHRR?=
 =?utf-8?B?TFVjUTRhQmc5T2F0TWZmd3pwQ1lSV0pUUHZadHNlUDBBRmQ2Q1hLNlhNM1JZ?=
 =?utf-8?B?eFQ4cFVZQVVpUzR5eVJCdzQvaFpJdGltUUlhTzdpK1YxOVNUdVpndVViS1Fs?=
 =?utf-8?B?Q0hQWW0wbVBGNkJIQmhmaU9FOWpSeDlNaEFHUXhwQ0Q5YkVVTVRFd2NESFZr?=
 =?utf-8?B?T3hYVDNPV3VRRWdQemFYRWpYODZNLytBQmc4OG50UHhPVnJrcU1QMncwaHE1?=
 =?utf-8?B?RFhwVVVCaVQ0YVV6eXI3TkwxVXJzMWpDUk01S2JDWGZFYjNRQUt2SmcwOWNt?=
 =?utf-8?B?ODFWMDJsZ2xXREVEcDRWUlFuWUM0ZXNKWllSbkM3VVpsUTdHK0RNZ0NaSndw?=
 =?utf-8?B?WXlkaXhJL2plS0RMOGVkVGV3TEF3Vm0yVEcreUpsVWw5amlCUTUreXcvNFF2?=
 =?utf-8?B?azZSRjdaZVFxbXpXVGNkZWc0QlROUElLeTQwWmdCN0tRTWlzcHBlWU5jMFJ4?=
 =?utf-8?B?QWswM1kxSis2WE5iUzQ5ZUludEdheUxxWCs5UG9wQW5ZeEl5U2pPNzNWUFEy?=
 =?utf-8?B?M1dXc3JBM2lLNTZCaG43MDMzTjN5RDh4SmFnMEhvOHV1ZW5YNzE3R0lJNVNz?=
 =?utf-8?B?a0cwOS9XQjU1eXBtM2U4emVyWmcvWVhxclR6RWsvUzljRnk1WnY5ZDFNNzVU?=
 =?utf-8?B?b2RibExnUkhuSzA5VWl2SjY3Q1d0VVpLM3BpT0QxdjdyYW5BZWhHMGNJOW1D?=
 =?utf-8?B?ZjZxSHovS1VvYkJ4a3lBSjBtUlhZQVlZaHRnekFzU3orM05UeURKMW5rT0dY?=
 =?utf-8?B?YjFIRXl6a3FUL1U2TVloWk5hYUNscVFSS014bnpBOVJPb1JBdFZXZE53QnJV?=
 =?utf-8?B?RHdjK2JlNVczbklQa3c4akNBcEo1VFdONVVxRjFoeXNnb3VrYXU5OEd4QzAw?=
 =?utf-8?B?WU5UTkFXdHlWTGZKSVc5OE5ZZUtvbWxISkcxVXNEZk1oTEJTYk9sSy9GRnJJ?=
 =?utf-8?B?NTZQK3k0VGlBQkNETTZrTUZQbytrSHBLNkNrdkZlTitjaXNiSkRQemRsdmFP?=
 =?utf-8?B?VnRiWmhOTXJIRWpXMzM2UEx5UDNLUi9NYWRjS01XU3FsUXBmenBCQ0pEZzB4?=
 =?utf-8?B?Y1V2MGhiRlVtTWhrd2ZWbzhaTHRCVUhLNzNKa24yTmk4alJRU0Z3QnMweENy?=
 =?utf-8?B?ZC9KdXNJMkFHQVVQTkl2bzlEeFBMbXBtV0R0QlcvWGI5RDlUR2ZEazcxYXky?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lNVECaUK23WWHylXAT/Omt8iS3p9TvLZV/XKNHzqC1r37p7yHUrDDYkLmU0LHS+WBHBatJR9c/j0rBi1d9t1CIH2uO/tnKEYxpYikc5WCFNSk0ETeQwkaShgMD4jS0nHjFgVoMVLUNnDfkShxUZPOI2JqN+0HNo57xPYUCmW8SPA2uhwV/+LKU16uMJa1q19XendgigA7H/i80fcTuOwIq2RcSXLT2tJwvrRQ+utPBUWxMvC+BPKKTfQSqPBJFYq2ps5fhWYu//BIk5TTTjb5X54waMvjUDMQy2tMNXrGneAQ4ZiVfLrEjQtqA8O6R2EhEtLSC3aMLaGBRQlYr1sRrsLZ2488YuYTn52queqiLvjefKWtt4ZWN7PMLjTv+f2puctbHKJDaDAFb9IQaANxZY9hvznefbCrpo0QRzor8qwc5NvXkgmtsbUT6Y8MxPa0Z6y/IwiF/t90GWVkuZxuAsfth8I9Io0QLzH/oZCS0KGAd1bPOQz5BFuyPFj1SswC4F9wwTECQHsR1RAB/81txQq60xpDKeClvzUicASsPkDxIIlq/d3wR9KOBvcHoN2KH7zP4lVbS/vsuhgGo/zwJsKtKhWiwFRZE4YXn2jy/+KPkmUO/9Yej3tygyoIEi2ET5OnDv8oK903ZzX4sJZRGeTBOmWVGe8/yveSJt37CoOrKkDytz+NrCmBNnLBh8FE5WVDBCNswO1jlpA698i1AeHjHt6wOv0Z1N/Yn5g6XQT8NOFjnusx2iV3hzg00z28fjM6Z6G7jPUpKww+jPhFg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b982a36-a6e4-49e7-c226-08db9e80f924
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 17:48:17.7750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fO8YM9qttTezv9+nKtoHuc+lgHtmZFUyu4uLPwa1o9JG5ntaX9Z9jSd0tyhKMfT+1Q5YoZ/dBQoMwkV0FPa+h0/KvdMlZcem9GJCtDZ/MXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5272
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_18,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160157
X-Proofpoint-ORIG-GUID: VuzaIYFq4Otr7mLpFbmKlA3UUwxlDTZP
X-Proofpoint-GUID: VuzaIYFq4Otr7mLpFbmKlA3UUwxlDTZP
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
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

On 8/14/2023 3:37 PM, Peter Xu wrote:
> On Mon, Aug 14, 2023 at 02:53:56PM -0400, Steven Sistare wrote:
>>> Can we just call vm_state_notify() earlier?
>>
>> We cannot.  The guest is not running yet, and will not be until later.
>> We cannot call notifiers that perform actions that complete, or react to, 
>> the guest entering a running state.
> 
> I tried to look at a few examples of the notifees and most of them I read
> do not react to "vcpu running" but "vm running" (in which case I think
> "suspended" mode falls into "vm running" case); most of them won't care on
> the RunState parameter passed in, but only the bool "running".
> 
> In reality, when running=true, it must be RUNNING so far.
> 
> In that case does it mean we should notify right after the switchover,
> since after migration the vm is indeed running only if the vcpus are not
> during suspend?

I cannot parse your question, but maybe this answers it.
If the outgoing VM is running and not suspended, then the incoming side
tests for autostart==true and calls vm_start, which calls the notifiers,
right after the switchover.

> One example (of possible issue) is vfio_vmstate_change(), where iiuc if we
> try to suspend a VM it should keep to be VFIO_DEVICE_STATE_RUNNING for that
> device; this kind of prove to me that SUSPEND is actually one of
> running=true states.
> 
> If we postpone all notifiers here even after we switched over to dest qemu
> to the next upcoming suspend wakeup, I think it means these devices will
> not be in VFIO_DEVICE_STATE_RUNNING after switchover but perhaps
> VFIO_DEVICE_STATE_STOP.

or VFIO_DEVICE_STATE_RESUMING, which is set in vfio_load_setup.
AFAIK it is OK to remain in that state until wakeup is called later.

> Ideally I think we should here call vm_state_notify() with running=true and
> state=SUSPEND, but since I do see some hooks are not well prepared for
> SUSPEND over running=true, I'd think we should on the safe side call
> vm_state_notify(running=true, state=RUNNING) even for SUSPEND at switch
> over phase.  With that IIUC it'll naturally work (e.g. when wakeup again
> later we just need to call no notifiers).

Notifiers are just one piece, all the code in vm_prepare_start must be called.
Is it correct to call all of that long before we actually resume the CPUs in
wakeup?  I don't know, but what is the point?  The wakeup code still needs
modification to conditionally resume the vcpus.  The scheme would be roughly:

    loadvm_postcopy_handle_run_bh()
        runstat = global_state_get_runstate();
        if (runstate == RUN_STATE_RUNNING) {
            vm_start()
        } else if (runstate == RUN_STATE_SUSPENDED)
            vm_prepare_start();   // the start of vm_start()
        }

    qemu_system_wakeup_request()
        if (some condition)
            resume_all_vcpus();   // the remainder of vm_start()
        else
            runstate_set(RUN_STATE_RUNNING)

How is that better than my patches
    [PATCH V3 01/10] vl: start on wakeup request
    [PATCH V3 02/10] migration: preserve suspended runstate

    loadvm_postcopy_handle_run_bh()
        runstate = global_state_get_runstate();
        if (runstate == RUN_STATE_RUNNING)
            vm_start()
        else
            runstate_set(runstate);    // eg RUN_STATE_SUSPENDED

    qemu_system_wakeup_request()
        if (!vm_started)
            vm_start();
        else
            runstate_set(RUN_STATE_RUNNING);

Recall this thread started with your comment "It then can avoid touching the 
system wakeup code which seems cleaner".  We still need to touch the wakeup
code.

- Steve

