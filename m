Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 424697C88EA
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 17:41:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrKHx-0000W4-NF; Fri, 13 Oct 2023 11:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qrKHu-0000VY-3O
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:41:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qrKHq-0004mz-Mt
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:41:17 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39DE0Z0d025143; Fri, 13 Oct 2023 15:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=SXOTsc93wqCBZUaOYTD0m3KRZQyWjCsl/mNZIven+hw=;
 b=Ni2r1+QylR/kvOvFmfTiuHfpm4Ul61x2pvEQYnEeOlNU+3PA3NqbfVgAHx2KPL2K6D3E
 0ygl8RFeCQb9+X4Ii3vmCNTX0ikcMEvEfcYfnnLpRW0PYQCYB7jnu3EN6VBKrOjZFNSB
 Hk/PACPZDh29NAzbbuWo/DGW1U2tHQxDapEyq/jOMD3ZYFdbpZ90zOKMFLx2EDphlKyn
 HuIv4zKrXLEHs36QrR02OPGWfwIgf1B23VW4Wi9V0AY7cfn2Hl3Uho7nW+Qnd9dZAwOz
 9h8qHvZ2o6v7PKdW5FUM58UfK1cfZOJFLI8pFF03Wq3oTQE/+Av9zNUtSOLgEBDL1NMU Nw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh8a2jyf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Oct 2023 15:41:11 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39DF0foj006138; Fri, 13 Oct 2023 15:41:10 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tptcshkkb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Oct 2023 15:41:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEct4ymmzKWWtdyLS8Krc88bK3xXb87JuTbc4kQp/42AaDNtZ1kt9FRzt9URIV0pvRUrW0T5Hu4R5RW9jeE6jpFgxeK62L0ILN3RYpXmU0ETPdrGJp5eLPUgVMJgNSycgyGGuxph4h2jsRB1Q1HQ5xWRbnKDmLuYvwwRJvSbTPZOUirHnBLQyz23FNk0ly442+7gR4Fky/MGzGlZgnSNGsR6tKiu2Tnr2fHpIP5/EvMdRSvnZ1snzOzQQdOYx15bfcejNQuNJILU743PhNFORFhGXPwVxQ4mx8NSUzIUmW13MIorJv9wOdEepXPgRC1xFZ/6oNKQjydATH4XQWb1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXOTsc93wqCBZUaOYTD0m3KRZQyWjCsl/mNZIven+hw=;
 b=GDxr/o09BezI/xaho82ZRgUWpajUeZ4Z4hQJduBcq0Aj2RNpryluBI68upOhBXyYWknBdgBSp296AM1js/kWa05gqrHfjpHhqpcqb/adff6zvysugwwmjfp58R/wiM9ZRh2oyyYPNArWHiFfX1YmCe5bCyr2hyfqyd1tozAbFjLTHwigoynjFhgQ71+TMf2eODfRTn8OGWOKnQ4hupFiAFvVa1bPUmxZ45yrwZT/zDfU9K8urCFW89eFrCbtPlogT1MYOFS51iScsLKq9foJOdbs0EdGf19A6BvLRWN5IKXcv7JSYuyJnPcMhNFgCTxXK2Cva537QS4Ik110nFKfOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXOTsc93wqCBZUaOYTD0m3KRZQyWjCsl/mNZIven+hw=;
 b=tbaEMEetgTFALcnIXpZ5iWjgEMTFvVzLc7eH1RAI/3a7sgA31y+Xbzz0KOYwIMNVbt6QxcJLXBkKFT9d4f4omfI7SxTEGTXIc7h1Wdo8jkKHG0XwfttXrFJLbbhuZw5s44B4/DVra68bFGV7JT9P7sakcrqQJE20xObL2Vv0L+8=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by DM4PR10MB6253.namprd10.prod.outlook.com (2603:10b6:8:b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 15:41:07 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885%4]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 15:41:07 +0000
Message-ID: <d492f17f-87a9-4714-aeb9-690d6b972803@oracle.com>
Date: Fri, 13 Oct 2023 17:41:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] i386: Explicitly ignore unsupported BUS_MCEERR_AO
 MCE on AMD guest
Content-Language: en-US, fr
To: qemu-devel@nongnu.org, John Allen <john.allen@amd.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>,
 Joao Martins <joao.m.martins@oracle.com>
Cc: michael.roth@amd.com, babu.moger@amd.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
References: <20230912211824.90952-1-john.allen@amd.com>
 <20230912211824.90952-3-john.allen@amd.com>
 <f287de21-8eed-0c88-98a4-69f00bd73be9@oracle.com>
 <948a0ac5-379d-44a7-92b1-d2cc0995e187@oracle.com>
 <39a471b1-9ef6-47e9-97a8-b315f63b4917@amd.com>
 <bd6f1942-4f6e-a353-8929-77fdc30bf06e@oracle.com>
 <60d3f74a-a1a8-4fed-a102-9985c47c69c8@amd.com>
From: William Roche <william.roche@oracle.com>
In-Reply-To: <60d3f74a-a1a8-4fed-a102-9985c47c69c8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0032.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::9) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|DM4PR10MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dea297a-3c08-4b41-7486-08dbcc02d11f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R866nhzDe2UQzXjlAeD7Q3f9lXMNW+lpCg3RIqLM8ADGn5M4emxGyJUrWo7j3QD2rOc9qyZNHrnQQWnAYQSGL0qtxq7bHD5jhUZgC8xVLgKcNa3rRfjeAMtlcPTjbmN8lrN5rzhaYolHJvbJmQqYxTY65S4k874PFZt4n+ezCbTgcqVwl87/F0kutXdN19/yhl9Xq6llUop58UyXwVbO2qK1EJGOtCrKMQIw9PNLYbbFpg6bkoYOgMBKLcld3z3DHSzIOm5/1hyMxGn+vIzSlqxjc1CJrVGLjhj64Ps3+Z4TNqNwZMZUkQIqMg5iytxk90N/M82oTiGWSuRv6PNHqYRqInTiO2IOTp0sypQTnsba9ptMV81DTK4LK91FFere37r6fnNDyQ6Hy/Y/WAcLnbvDiyBvH1U9YCFZOpUpXgL7ZG/uvbiUckbgxjqipS7SlsIYnq6uj8iliqGLQTXfu1vDrNdHFz/UFA/oFgFPiBxIDbCcHvTfO4ilLuZRGNhsacMIjgtWL4ui84BRLG43eW3741Fdjo3VVLw9I0Y741d5sQPka4z90TacICAL+4FHVv8PBTCdqA32Ug0x+QxRxiEiQ/vQ9PmkcqhqRYEJhy4EgJrGkbkAlzWL/QUPgQfsR2API2gh1T5WoJiHxy3fcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(966005)(478600001)(5660300002)(6666004)(38100700002)(66899024)(6486002)(44832011)(66476007)(66946007)(66556008)(110136005)(41300700001)(36756003)(8936002)(4326008)(8676002)(6636002)(316002)(83380400001)(6512007)(26005)(31686004)(2906002)(2616005)(31696002)(6506007)(53546011)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXM0MWYyUjczRXNCNmcwUnhnVi9VM1pQYTBUWTlsN2FxZ2M0bnpaWUlLcGVq?=
 =?utf-8?B?TCtEMSs1ZEhpM0x0VjhKNVJHalhaby94cUZDMUMwbkZpUFNDejQ5WE5YYnp6?=
 =?utf-8?B?YWdaMnd0dGN6T0NReFloUnB4cVhNeTgxWitnT2tBcWZIUFBCM2VBM3JnSTZQ?=
 =?utf-8?B?d2dSU2FuSVZzQzdJRUFET0s3NFhBRU9GWWFWM0Nrb1NkTWwydlFVY3VJcVJN?=
 =?utf-8?B?OEVjcEhUSHIrLzJaaW1TUE53ZlFxUHFvQ1VqTFo3WEhRU05qbFBNaHNyM2JX?=
 =?utf-8?B?U21BV1FMcGNEM05lWmYrbCtKZy9aZkc5QlNrbytESEJnRnRsdFIxSng0U2Rk?=
 =?utf-8?B?OEU0Qy9FWnRaTjZhbnBtb2tFZFovVlBwMHpWdjJha3FTLy9yOXdIbVNScm5l?=
 =?utf-8?B?YnlqS2crTWoyRzEzQU5RQWI4bmVIandZOXhWbWhYMnYraVFSTVJoVURIcFlp?=
 =?utf-8?B?NkZoZW9Xd1lWZzRNOUFDS01DRGlFbmU5RnhDTzdnYXcrajdnUENNMjZmREZx?=
 =?utf-8?B?QXUvaTU2bndYeGhBYm1HcWVGMkprd2xEK2xnZ1pQUVFBaFdmd1F2c01YSm9r?=
 =?utf-8?B?cXgwU3ZJeTZoRkxMTE1YR3JmK09rZmo5YThaTU1VZmoxVis4R2luMWErK1Vw?=
 =?utf-8?B?eDdleGdDTzJCcWJUZ04xaDdTbDd5Wmhza3lwSFpWTUVlT1lxR2JDcnpXZGky?=
 =?utf-8?B?MS9zQ1lnOHJlNmw2RUhEVVBTR2pZRWRSeURhbm1pMlZwbzF3RlVFc0xsUGFa?=
 =?utf-8?B?SHFEZmJQWFdsWU1ueXV0Qmk5MnVOMFI1eXdoay95UG1NYzhpQUVpUDVNQVg4?=
 =?utf-8?B?L2tOTTNwVXBIWE1GQ2RUY0N2MDZXNW1wNk1oOCtBUGF6RmxCTWxqRU9TZTBF?=
 =?utf-8?B?MmphWUJrQm8zbWN3aVYrRW5kbjNBTUZTWXk0S0NhTUFra2k1OTV6dFo2bDJK?=
 =?utf-8?B?OXhNcUljQXZiQjRXQ0xQS3BDWWRhZk9adEwxeEgrT21hRDQ2QVJSWUFMVTBp?=
 =?utf-8?B?VXFUd0pzQzBoeWljTmVOMkMyc2wzSmNXMUZIVGNYVUxjV0xwSzhsOHB2VTcz?=
 =?utf-8?B?b2FMV2lRSnpNcFBEeGZkRTdOalN6SFRJV1RPRzdlalh0NW9KSi8wZHhZdC9p?=
 =?utf-8?B?SFlwSzV6OFdubVVaMjNyTDlDZEN1SERjK3pjNEJUTVQ2Mkh6RDQxbzVQWWxX?=
 =?utf-8?B?OEdjcENvNUpyRmRzaEJ6SzJtMVF3cEh1Z1dIMHZiRTVuMjNvZlA4VEFkNFhI?=
 =?utf-8?B?ODVaWVp0VVAvVkJsU2tQelNoeXkvOCs4clR2djc0NFlFRTRabDh1NHlVNFhY?=
 =?utf-8?B?WGQvWU56VUZIZlh0SG45OEtzM0d6aGNOekRMMUFaTlc1TSsyRnNnWmJwd29x?=
 =?utf-8?B?Q2JQb3Bpd0wrTmVUY2hOcU9GT3pZT0x6OGZqNzZyVXNxK1ppN2J4MG4zSjEy?=
 =?utf-8?B?Vng3eXpYOFVoeEd6UUt1ZTFlVUxRcFVmdkZweDgxcE9YTEQ1QWZWVkV0MFN1?=
 =?utf-8?B?cHQ4L2MrYmloNHE3UkdLQU9RQitiZW95SkJqck95aUg4WkI4a1ZuZGZCRUZR?=
 =?utf-8?B?dWtRdDNKelVuakhJNDFiYS9BM1lYMjNKOHNVbTBtVCtGZEI3R2RBaGpxVEZQ?=
 =?utf-8?B?KzJlKzFvQjFKRWVxZDg2TEZ3eHpvZ21udnJidVFCWW1pVFZ0M0ZYOXQrWFNm?=
 =?utf-8?B?bjl4V3ZXb1V2RStmYnE5ZzlkeTRlLzhCaHNQVUpkTnJPdUxoVUJoNlYvM1hN?=
 =?utf-8?B?V1hxcG9yYXorRW1lVDdRS2Yxd2p0cHBDKy9TalU0dkhZbklqM0MxRVFTRWFZ?=
 =?utf-8?B?cDUrUjFYUFFLRll1V3RsRTZ3WVgvQlRGa2F5MjRLV3gzWkJCb09PWUVPdVdB?=
 =?utf-8?B?TUJnY2RVTXZUejBIenRWOFdwLzI0NzRrSERzUWw1ZDMrbGJjMGMyLzIrd0VQ?=
 =?utf-8?B?L2MwakVoTkc0Mk5jUEMvNUxhVVZZS1k0eGdrZDRocUJFTHFrQjQ5NUtJUWJ0?=
 =?utf-8?B?K1dVY1J6RHhDaFNHSUM2VlkxQWZMNm1rR0ZVQzJ2R0RQSnBlY2VYb3RIaGk2?=
 =?utf-8?B?V1Nxa3h2bHQrU2EwRTMzOW41aytkWUNwaDNRd25KaHVTbDM1dHFYYldWL3hR?=
 =?utf-8?B?a3o1UkRuR0EyTHdKOGJJSFFPMzBNakhvek1KZ2V5b2JaWDN1emVkTHlHeDhz?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /LKcX+rtbuUGgK5CtFDRQ/fwP22tjf3Ri2hocA9VskgiUGlzG+PbUJVGfbqJ+K/UqLYDDiBPr0gcERaJpfTZLJ3X/lB3G8OsVtN26eS8QfXvCjFbt+zFD6MGTbV2URi6iodS+5xXCZe97+zACjpJt5vnaiDo+ZCsWFb3tNkw8T4DwQhGiFQG9H2CGkSRGIJ+JldwQrHO2T9rSwm5ZLDS+iIox3PHel5ie+hyY39mH4Gx/WJUfz11xJTyYTsOyzjLFhskixnFEehmbMLyVmMWQG0eFVMERZT0oPMYKgLp5aW5ABFxv5Q/biqsFffIi02sRHZIv0olbdG5stW7fP+1Yy6o1g0BvIAVTC5Sd3bDm2s2J4G2kS6QUImmt69jKz4aX0ysy/b6lyacGp3bnRR8HT8cJcXJK0ELiKKJKFktk8dLMsZtKRmx/TvRs5GgdK27hI6Zv2DYxkbskU/3eSw3ImStZ9z1sgE5BObkmmOrXLadMlXKEjFj9QPN8trT0u/2jckXWQ/fYwFnsSaTn9D6j/5LnjQnZDHqvTmUgPUV7cSloB09hxoITg02vejgCf5kO+vVyHViR31yR0sK+Gsr6+hI6NJwTbUIxwx2RGg9kxTeGOQvINAnEl60nc2Df3hD09PCDgFBzOCEH4mFBjVRiEBcfQwUKqQOFOAsw4tlmR19x9sABhVBio9b2AnFVl/g8DDZyDO/JnwwEasYSqQqCr4IXZ9eLDUsGHGrflKYs/IfCM8G+80/ChHH1g6qXNDuDEGtcQKQxT7i0+jxe9X0PMOHNpKIZx//X5imMYKjk5eUuP2dkxbReUoE0Q67/5qf/P/miy9qBdf4eMYFoqVNlFImuYKzcpq/IId8fnTjM9I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dea297a-3c08-4b41-7486-08dbcc02d11f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:41:07.5828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RqIGAtbNhA6ejia26YlGbLuXwFez+5UrLDFDTCMdrE5jMb4J05ds2MofVDsJqafwjZtXt1YqBn0Gy0qS9E7+A2pEl4hCIgXf9QS8sF3sj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6253
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_06,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130133
X-Proofpoint-GUID: yHS7pTbIUQPYmyaQIeRsxmloyAHAxeQ_
X-Proofpoint-ORIG-GUID: yHS7pTbIUQPYmyaQIeRsxmloyAHAxeQ_
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Just a note to inform you that I've submitted a new patch on a
separate thread -- dealing with VM live migration after receiving
memory errors:
https://lore.kernel.org/qemu-devel/20231013150839.867164-3-william.roche@oracle.com/

This patch belongs to a 2 patches set that should fix the migration in
case of memory errors received and handled by the VM before the
migration request.

For the moment this other patch only fixes the ARM case ignoring
SIGBUS/BUS_MCEERR_AO errors, but the same mechanism should be used with
AMD ignoring SIGBUS/BUS_MCEERR_AO too. Using the same new parameter
to the kvm_hwpoison_page_add function in kvm_arch_on_sigbus_vcpu with:

     kvm_hwpoison_page_add(ram_addr, (code == BUS_MCEERR_AR));

Of course we'll have to wait for this above patch to be integrated first.

HTH,
William.


On 9/19/23 00:00, William Roche wrote:
 > Hi John,
 >
 > I'd like to put the emphasis on the fact that ignoring the SRAO error
 > for a VM is a real problem at least for a specific (rare) case I'm
 > currently working on: The VM migration.
 >
 > Context:
 >
 > - In the case of a poisoned page in the VM address space, the migration
 > can't read it and will skip this page, considering it as a zero-filled
 > page. The VM kernel (that handled the vMCE) would have marked it's
 > associated page as poisoned, and if the VM touches the page, the VM
 > kernel generates the associated MCE because it already knows about the
 > poisoned page.
 >
 > - When we ignore the vMCE in the case of a SIGBUS/BUS_MCEERR_AO error
 > (what this patch does), we entirely rely on the Hypervisor to send an
 > SRAR error to qemu when the page is touched: The AMD VM kernel will
 > receive the SIGBUS/BUS_MCEERR_AR and deal with it, thanks to your
 > changes here.
 >
 > So it looks like the mechanism works fine... unless the VM has migrated
 > between the SRAO error and the first time it really touches the poisoned
 > page to get an SRAR error !  In this case, its new address space
 > (created on the migration destination) will have a zero-page where we
 > had a poisoned page, and the AMD VM Kernel (that never dealt with the
 > SRAO) doesn't know about the poisoned page and will access the page
 > finding only zeros...  We have a memory corruption !
 >
 > It is a very rare window, but in order to fix it the most reasonable
 > course of action would be to make the AMD emulation deal with SRAO
 > errors, instead of ignoring them.
 >
 > Do you agree with my analysis ?
 > Would an AMD platform generate SRAO signal to a process
 > (SIGBUS/BUS_MCEERR_AO) in case of a real hardware error ?
 >
 > Thanks,
 > William.

