Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A714D7D6D51
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 15:34:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qve1S-0000YJ-84; Wed, 25 Oct 2023 09:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qve1L-0000Y0-El
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:34:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qve1J-0008PS-DB
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:34:03 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39PCww7i007835; Wed, 25 Oct 2023 13:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+YceBLwai4gpqRi/dCYmccEciAXoGut9iym0F34NkmA=;
 b=HXYqq4jHd7IWhb2TSb+GDRklQhioTfrn6rceHwJ/zArTNChurp44nL+0MDrH0cwCtdOh
 MXGauumUMQWlyYInIYuVN2f5w8k6TWGDvB+OPerOmdGwQcVpyxte0jZoazrhoRMRaYVi
 2y+zhTB3QvqEaucbYh/uVOJy7NbwzmN5JZGbCzMlN2Gmj8YZS9EE2+Yt0OMJKrEDds0S
 dPSUSKhd6dp+sxjlDlLrF3KHuEBRu63NcT6mf0/hTqQHGPGWlbZ2GargdWKUeOS4oS7M
 Ztko5gG70mJ9RSMqyaxFVa38h3BDVc6hpHhoLx9R7/xKsTKZXVOydE6yWjNUQWv+EMWO rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv68tfrf2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Oct 2023 13:33:57 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39PCq4q0034598; Wed, 25 Oct 2023 13:33:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tv536nm5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Oct 2023 13:33:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tv85twFektgUtlIf6+cW94hYflyPLHc4l5OFJplwZNe9AWZ9wSAKfv/JPA7Oydl24aj6qFNNvDSrbuVHHECoES3cxt3su/VOvYYbVrfRzAJF3BABRgK436wIosb81jfsJCvRQLE1MFntP5IMsAZMbT1HqT40n+y/hkqAI1UqPeZBJ1gktJRzJnJLHQU//MerkoWZ6fHA5CdX4mYrnCNR6pYNm7t41T89JkQwEArALwO8RyXFKSXaINZ62q9TamBXiypc7MRlHvTcEOHNpVvMv2eW9ue1SuFXQygxQ2flqAEu6EsBiiKtZlWkceJq9a+cTIBPdpTI07RvcQmma9OAUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YceBLwai4gpqRi/dCYmccEciAXoGut9iym0F34NkmA=;
 b=JYoHDt7X7s72OevHH0kRg7eKj1TE2pYntx7tS14i63pURFgCZX4EIvRF4eE2u1aTcR7j14R0K7wbhohlY/Wv04lbm+qbgYaUnfSt8E9M+IUFq3MdSl6zPR+zUO0RcVylvn8oNxNXbnGFv5PwZ3A9mNdKyuum8V8J++T1yh9EBh1xLoXGOfCiMfVMLdmrLM1Wt+y3Ap/lqeBhYT3VobSiwOHLePKqzdxGqs1wrm+aMq1O7xlavuGFHnRqgJZtizHMJbvgsZT6KSNpx5xE4dHEH7b+xvZJ4yMyZaYCCXpYSIuDOCZvERR+tJRP25QJJ9FawsZLayQpzlAJTxDbtbyEJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YceBLwai4gpqRi/dCYmccEciAXoGut9iym0F34NkmA=;
 b=VFGxtVnUU2iDLiu3kqkRdWN9XqEKIVYkPxoBlSp6VYCw//llH6zVLqD/3nJHD5ye2jBYnlyQL7eyKfHnOjni/aVLdIeu0HCSZ2xeWBwnIdCdp2J4quCKVLSnYsZvl4XoaImbmULWMZYfyb2/o1O89kFCBsE4J8Q3WX/Z6HyAnIU=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CY8PR10MB7122.namprd10.prod.outlook.com (2603:10b6:930:70::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 13:33:53 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 13:33:53 +0000
Message-ID: <ac6cc709-e1cc-4d5b-9fb5-eb4239395068@oracle.com>
Date: Wed, 25 Oct 2023 09:33:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/29] tests/qtest: migration events
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-2-farosas@suse.de> <8734xyg7mu.fsf@suse.de>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <8734xyg7mu.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::24) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CY8PR10MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e19b96-da20-4ac7-011e-08dbd55f07b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PN7HIy9M2R4hoFNLa7bMLm1fAlDalDjTAlmFTkbKsBor6KUyCmzDO419y0OuE9pn719wKWchGKBNuXr12gsLBI8XRNwnaFI3H5tUNQ9F57oVX5SyZoJvQHJ10gdspeZs8WYQ3xTngRHolfuE8OdE8tY+0cQxD4Kal4nZRT8MQgjUJl0cMnB+lE/E9UaNJwiYbeOEGbNMINPNNP7pQDbRpudGAY34QA8D0/e/pWrdNB+sX065g9eHcCiyexU0p0ScqwMm17emXyfVW6kWq5jKC/gbjmK9F39q3hbYZM+Fay9fFpiIZ6HcATD/ASINvjp4s8mWYjFyoy7Hb62V5uERfZbDpzHCzyDHO9SC1eYFjws4m8paxHUFRngiLc4o3qPrqRZUdS507T399UpmXCX2GhcJLXxcQLhivK0vaXmgynb3i+XDiohSCy/9RczcnN6B8xM7NtMFB1YysIIJeSPC+zI5ye9rj9MZwPdcBcmE+oRuyOaFPZN0Nx/HdIeUg/ongaECmlLgtEzWshRzYnAXJnRSCfT8elU68R70yrKa0CaUjFhtzSjDQn0M2udK1RVUlP3rC4C13dK1zV7L7GgISARkVNAsfgsDGBjJq5pPLUTSHazCO/S1raVI6Zsp8jTTLBw6Ic7fcBWciltejqyL3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(31686004)(4744005)(83380400001)(8936002)(7416002)(36756003)(2906002)(26005)(44832011)(8676002)(53546011)(2616005)(38100700002)(36916002)(4326008)(6506007)(478600001)(31696002)(316002)(5660300002)(6486002)(6512007)(6666004)(66556008)(66946007)(66476007)(41300700001)(54906003)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1UycjQrMXlMeHdsY3AzcU90YkRJa1kzRFM3bmFLeE9mbzVWc2gzbFZOUGZZ?=
 =?utf-8?B?eUdDR2FJNTVpSWtPenVpdmtFeUU2UU9qK1h0cmdPeFRRUVBnWFYxRTRHY3ZQ?=
 =?utf-8?B?QWcyZndPOTROL0JOVXRKSUtaWFpvYkgyc0hDbWpJcW14aFBrTU5NY2dCWVF1?=
 =?utf-8?B?WlBtZzcvb3RFaEhtckh4c1dMVVlZNkc2NlBKV1B4NTZtVVk2TWpIQjBKR3VH?=
 =?utf-8?B?S092QUtkMGhMb2gvczdNVnFIK2ZqRjBOYzhrRDRwUWxaQUFSZ3ZwWWh0eFhx?=
 =?utf-8?B?aWpRVFVLQUpBNlhIMG1LbDMycmpkMHNwbUdzSi9UTHlVWXg1MEw5L3JlTUN6?=
 =?utf-8?B?aGlOWmc3S2RIcVlEejBpbzBRcjFsM04vV2VSTlcrbzVzbFJ1VmQ5ZjY3Ry95?=
 =?utf-8?B?YnMyWHl5SUFDZEFzQWtaemdUT3pKQU1UbDhnYkllL1dKa0ZsRVRSTWZxZnZV?=
 =?utf-8?B?WDJEUGd2UVp6eEVPTjhLa1BKaWNZRzQzL29VTTQ3RjJySUE4bGY2a2NOUUx3?=
 =?utf-8?B?NnlZQnpDQWd4aGU5cTVxd0NLQWN5VEtJWDNQMDl3bnRPYWtEK3JCbE5aelhE?=
 =?utf-8?B?UTY4SDFZejJDc2kwUkdnS1N3V0lPM0NmWURMeTRSNFhPaWlnQ1lSc1dFNzJ6?=
 =?utf-8?B?MW9uajN3TFlqbWtONVBHY2trV1ZscmNKMFk0NU1aRTYzb0taY0ZUWmlBbjgr?=
 =?utf-8?B?ZHdkbGZUKzZQbW1NRmZ3N3Q1eDQzek5DMU5YNzczTWJGZk1yc01vVVdHeWV2?=
 =?utf-8?B?YlpIMjZXaU5IaGhLcEx3QmRZalRJSEpKRjFpMk9xR2t2bHBwa0pycDJLL0hS?=
 =?utf-8?B?VElFM1Q4dUlDZTRxclIwMXNVU256U1ltZjdkKzNwakg0UXpnaEZNYjZ0eG5T?=
 =?utf-8?B?ZWw3QmFWaVVYNlZTS2lPUVp2ZU1XOWo5VlJSMVpSampMak9xQzErRm9wWkkw?=
 =?utf-8?B?V3gzeW1CTGszZmorOHVtVUh2anEydU9qZm5BUDBTa0ZBR1gyRmRRaEFRcjZM?=
 =?utf-8?B?UnpSTnlRN2w2SFl6VnAyOHRsVEtkUCtCNDZaeDFHUUIyUGtzdGUwb01qTUZh?=
 =?utf-8?B?UklDbTNtUzJCMVB5OS9zeXpjdlRTQzNyUkw0ZnZaV1ZzT3lkdzlWZ1RsZVJ5?=
 =?utf-8?B?S21uK09YQVk4SWxONStEVTNDRXUxY0lSaVRBSk9odWUzb3JvNUt1T2NxZ3pY?=
 =?utf-8?B?OVVZckpIVlRCdXpSRkVHd3BGMzN1eEk1VU5xNEdLcWhrMHFibllzNTFCYnRW?=
 =?utf-8?B?bmIrYWNHdlNYLzdVczlta0hnVXBwRElCM3FGMGVXQThheXBvQmJzZE5vOG1Z?=
 =?utf-8?B?cTd4V3RhZDZmdk1tNWRaQ0ZuV2VpSWttdzFRdVJiS2NaQzFYVnJxRERHZ1hT?=
 =?utf-8?B?Q1RjMzBGeFZ4L3pWQWRaMmJyWHdpMEduMmkydFJ1QVE3bDAzYzgzUUd5NkVt?=
 =?utf-8?B?Z2ZJWGNCNGpxWU1ib05sZjVsMFRrbW1tN3I5bU0zSkVvcSt6NFdVTy8rQnp2?=
 =?utf-8?B?ZEx3VFhiOGtLT3VJd2U4Z0dOeTVNUFNadEZ2K3VldlFvSnFuWmQyQ0Uvd1kx?=
 =?utf-8?B?VjZmWHpxU1FPVDIwMjFNSUYyMSsrT3c4U1B3RWVKQVJEd3VUVTJoYWs3cHpC?=
 =?utf-8?B?cktHMy81Vm85N0NEeEg3b2E0TVZJcUY3SkVNejRhNzdhaTdEZ3M5Wlc3c1E1?=
 =?utf-8?B?cEcvV1ZrQVd3elc3SGNJNW43cEVzOTIvMHZNQ2FON0V0MTRsT0poRWRBWkpr?=
 =?utf-8?B?ZEh4RE9ZM2Vzd3A3ckJMOUNjYXZyL01tU25aMFlSdmN5cGVES2dVSFF5RzFJ?=
 =?utf-8?B?Z3FwR1FETkdIU0doZjZ5NVp3M2JrKy8vaWJkaXA3UjZwdng1VUUyUzBPMWZz?=
 =?utf-8?B?MHBUVzVXYTNqY0IzZ04zMWtZZ2tWVUxETFZSTFY2RC8zckRKcmYvTGpTTjdz?=
 =?utf-8?B?dThKQ255d0I4cjZUVk1iR1NZSGdPVUZVNVp0ekJVVDUxNG96dXpFYXJIUGZ0?=
 =?utf-8?B?eUlCN01yL2crOXU3dldQemFJYVdweDZ0dUI5ZUdKeGRDeTZWOUFuSW44MHZl?=
 =?utf-8?B?ZjdRY3k4UTFGcE1PY3l5MDJRYTYwRDFMOVBsZ1k0bThmYzBHVUhXd1l6L0hC?=
 =?utf-8?B?RGpuS3RHYllnK3ovb3F3V3dHbTg3QmRrQ1AyUWNUWU1jRDJ2M2s5ZkNiNVVN?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: biK2xne8SzsC1+M3O01ZHGEf810WhZQNv1upmF/m+4ZbuAHc86fVRJzZu3PqpPyvLFCV60HPx4i8/wkcCNf7lbXCK8UhusQK1toO02NiMjii2juSFboT3la3cHvIT2p9BNLJqyr4AKHDtJdlHuOC24PJfEPVlNt7Q/qL68E6PtZcW+obPY1e1jR6XxIxzup72z34FKIzQXkGTcUHm/sAMfIXg4LxuXhV8kqMoLIfXn5xg6tR+RCmUcgumGHZk3AUn3btcp4/uF7BjUcltnxObhZR2EIf/aY7Tet9tlqxEYRyzQcv9KfbM5ceuajniYFeNgtzMaQ57Sv9nM5D8qvyvqyibLgQGIxaKW8WfTcIzhUwkKmdiT44Gr7Kp4khlJmo+lVJobNqbpHwIq7EA7JMSVpVbJO2myF4Vfo2Wta1fSUPuM+katvduHzndHeV5SH2FxyXJE8gm31VvVJoCoaneDWnJWYfwJY++cWbMv6Ah6e9FhmA71hIihrTmCP66w966lAXl7ylLk2Pc1rR9RyHQC/p2/T6FxYZHoUVj0RyVkdx0ArVTXwbXD3c4yIhpKvM1dl1d9+tKAz6niqYQSOHXnp/I1GTKS43MqSlojUI0zqWSNrwo4IhDQ4b0jzJqQEFLuIMe8NaSYD56GZ/Tqm5x9OYJH80acU4oJoDI5cEtMxSVUHGFswBRIS4e4Y6fR9itANNsfGrDKjh6ByF7vX57KY4vUEy6NfnGRlbF0+wF+mRWp1vjd2tvVNHcJi/6usUKmVvpRildZO7seYhgFFwCeLdpmHsLwiY8MIK4BZIsZSiaRZVaUjg0jDNhST52mg4
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e19b96-da20-4ac7-011e-08dbd55f07b1
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 13:33:53.6035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fy/h0+mB3s7edMU4JGMMI27urWc/WUFqwsfUmWRPE9lM0hSc58eIfjJ4GDyU4lyL7hHxlT8jyM3SySINYl49BRyrD66/87BMpU7NpeX37cM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_02,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250118
X-Proofpoint-ORIG-GUID: aS_s007agnywvEPGOt_6CwH4_us4KJTY
X-Proofpoint-GUID: aS_s007agnywvEPGOt_6CwH4_us4KJTY
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

On 10/25/2023 9:21 AM, Fabiano Rosas wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
>> From: Steve Sistare <steven.sistare@oracle.com>
>>
>> Define a state object to capture events seen by migration tests, to allow
>> more events to be captured in a subsequent patch, and simplify event
>> checking in wait_for_migration_pass.  No functional change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Steven, I haven't seen your series that contained this patch for a
> while, let me know if this is an acceptable version to merge. Let's make
> sure your series gets in first so I don't get in your way.

Sure, feel free to merge this patch as is, and thanks for asking.
My suspension series needs more work before I post its next version.

- Steve

