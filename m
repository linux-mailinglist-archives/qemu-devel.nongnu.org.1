Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 387AD7EA2E4
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:33:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2bkO-0001yT-Jx; Mon, 13 Nov 2023 13:33:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2bkJ-0001wD-Nu
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:33:16 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2bkG-00034i-FZ
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:33:15 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ADHimIY022873; Mon, 13 Nov 2023 18:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5rfUEzeEN+Yplrg/KI13xV9UwwC/3iV6Wu52fsIO/a8=;
 b=xU6iSzuAAlZVQ/EweI1E4OMI+eOGyLaNcDz5USMsWcm2I23KAkCEGUKTCsGoEmBwIqwc
 W8Mv0n4ai0StjzE8ZML0DKr3ohZ85Sp18M+cIzrsrIiUAtRhyG9wFOkAid5ujpvJaDav
 FrK3FspCctbC11DdcsbMSorEumTHwLYeNyorZtjh5ZsxCbg92fsIC0BvflEkFgq2k+yu
 tJeutk8cHlrhgsmd1fw/MZkn/FbbChukL4DR2gvOV58oX0cny/1S02xrgHLvVLW1wZZ2
 tMz8kCiAMTczeX/FzE1i1CvVy0msTmIAIICgV46ASW6zNnAT+kUPMPh3DmEodPFYhH4D Xw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2r03g21-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 18:33:09 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3ADHhngI013468; Mon, 13 Nov 2023 18:33:08 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uaxj0tfdw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 18:33:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nv560xKeUt/k2/NL0HDxViK4pBx6MtF6uZlO8F9/bhTpeOI68UGOAWj2YmaHCAMTjvUqh+IPQhYsCmEafXg0p2sMLf1aCMsX7fUmaDoY0MwCyQyjQbqEy22H00WJpc1by/dAEl0dwZzq4V1xmi5q08/IFbeMTjxHgDDZRDqhmqIKbWh546s+DxpBu8acuauXwJWKrzaEV7Iya/IUvqWN3zdbQ+iSomn7OgyVb45c9uCEpGc9jFOhRbVOnW3b9HoW1AlZXFHJG7KFw++UI4wu6HuJZl5sXItMGRtmAyCzAz0sVP0LTN+xbDnUWnoSgCzHKyWS//pvWINmTricWgyRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rfUEzeEN+Yplrg/KI13xV9UwwC/3iV6Wu52fsIO/a8=;
 b=VpTnHtNXcKPNhcHiW4MZqf4tXzFUz5C3kLWNKywMny7lJ5M2eoQ9PeZfQ+CZ8CP2NW5Gn/O5Nbf491u2sTcy19z7h/Tu5MBnp/707cCB2otiWVB+L3Af/vfXx0YqXdFtgCpj1l7wU58hUWDjGslWxtwbuBbDnxSoc8vEA0owlGzAYNU0q+WUQb6X6bcSCj3wgwr2sk4YKGRYJLwf+Hh26uL9B/NgftM8f+Yx8pXt4kXrkbULPdkbe7Z1GsjcJLgMjTNvCeJ64kz1r0FRZZ9hFLud30ipYMGIzevkrIHCzce2vQqXzbZglZa8n21jcYw3T5nxHNrsfW4yh48jDN0Wgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rfUEzeEN+Yplrg/KI13xV9UwwC/3iV6Wu52fsIO/a8=;
 b=QUl80KAWRnyY73dxhph6xqLpHmZtnnMmQjpvaDYy1VF8i/x8xvRt0FflKDeExrTZBPLyI04OVfGTDQHuykBCWFmkxZAPZ7GrpMWWhe/tUa5atf/NAsx0xyb2xRYtgL4gbx/jSkd6DDTEKV4QtvkconOc6L4U3UCXf5mV1L7qAMg=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DS7PR10MB5359.namprd10.prod.outlook.com (2603:10b6:5:3a5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Mon, 13 Nov
 2023 18:33:06 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 18:33:06 +0000
Message-ID: <f42c8267-5885-442d-a2dd-a57a77d5efe1@oracle.com>
Date: Mon, 13 Nov 2023 13:33:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 07/11] tests/qtest: migration events
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
 <1693333086-392798-8-git-send-email-steven.sistare@oracle.com>
 <ZO91uYBncX3VE0D6@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZO91uYBncX3VE0D6@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR20CA0007.namprd20.prod.outlook.com
 (2603:10b6:510:23c::9) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DS7PR10MB5359:EE_
X-MS-Office365-Filtering-Correlation-Id: 7607dd6e-c3a9-4ec3-30dc-08dbe476fa44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RIRziKf9yw1p8qDgvABL8xgKQWWojm9QNL2yGu0RrpNa2ObG254cp4iQ2Ufdu8hLEv/nAs80uKDNTAvHL0uZJFZm17JRnTQRTe6Ad1bxJUykWyVasOfsKmbUcoOiy6JR88dAb36Ig4y99aL4rRuk2S9pMC7xdhoC99X6SHrpKQk/PGU8VDRhxcBnlstsraNIS22CJ4dzVJ+brquVD7/DCCqgt/GDedIkj8pOoOd6GUZiavlOesGK/YU7s/exQ42D+f7V5UFBw+vrSoPORWEX6cAjjPfuF5oFaG/HuZaDVrh1zePb0wnst/boVRAEOq8n8LjcXPoGXcNhx1xrH8EhHlDpBXOD/+18KGXbdGqKsBiJMlhH6V0LPopaKCTsQmyeLTKMeO6BUilrtY9xiDT0Sobcgx4i6N2J8UzMJtkr/JMaj6SEhgHJGf63HpJkcIihhgF9rUlz2Eccnmqra//Lmyd7B92j6IQGAyfRXZPvxLDBQJHeY9QUuHPYfkzyiLboc9L76AOqFJr1U4xPyk0o8doLUKYR1s/WUohMyyQvXnoXZOqm7sadMzqAw0H4CW4Qylwz/+dMnBhg/DSqQXXZN6l9kx3L6KJlCS/Y6KzdXqLhiFfoz4TY1jKvKx9QFOV/vZ0tz8WPc8lJu+F+X97TyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(39860400002)(366004)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(83380400001)(36756003)(31696002)(86362001)(38100700002)(8676002)(8936002)(4326008)(6486002)(478600001)(44832011)(36916002)(53546011)(6506007)(316002)(66946007)(66476007)(66556008)(6916009)(54906003)(31686004)(2616005)(5660300002)(41300700001)(26005)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzA0cEtwc2g0VVB4UGwzMERPU0tSYzVBYTJFS09iQ1V6L0t3YUo5Y2R6ZDdL?=
 =?utf-8?B?dGdxOTJUaGNHbVg3RUN4MDY1cEtSd1lkVEVNS0tNbXBPRnlyWXM3TVFXUXpv?=
 =?utf-8?B?SXNDTnZGQ3EzQ2dhSm9vYlY5RmIxS2tOcWlxT2NuK056NDhnWTVNV3dxQTh2?=
 =?utf-8?B?VlBaNjc3OG12bXA1aXoyYURta2Q2UldPcHIzMlREUnBrMk90VXlvem5rTytR?=
 =?utf-8?B?c3JUc3pUVG1USk1hc3Y3UjFaVFpBcFl6a3oydTZtNnJxaUp5RlhzTUlqMVV3?=
 =?utf-8?B?Q0N2d2pZaDlkNi9ZRGxxVFYzZ0dscy9ZNnljYlpoeHVSdThGZkllYUJFZWI0?=
 =?utf-8?B?U0MybmFJWlYxQk1mT1lidVkrbk5rS29Qdkl3NFVXUUlveTdoK3JCSm43Q2pl?=
 =?utf-8?B?L3h3ajU2ZktITUI0QjFXVElnV3RLMGpTMU5telg5QXVaTFRabGRacGtiZTZO?=
 =?utf-8?B?M1VuV0tUekRQcGJKNHJQeFhFbG5wclY2c3NycmU1WWZiRzhqSWdpUy9FTnls?=
 =?utf-8?B?N0xtMVhNVVAxT3lHbnZrekd0YkUrTXp2em1LRVN5em1yWTcxT2NyKzFWY3lH?=
 =?utf-8?B?T29GUXV4TzJXRHdiYmN0OHhuZmpLNE0wdDNQU0hnREJyZ1BxY3NJRnVld2c2?=
 =?utf-8?B?L3doUTJMcEFwczY0MTRyVmsrNTB1Y2NPRmdsMzQ4MFFoTEFYWngyRGplby9S?=
 =?utf-8?B?SVIyNmttQ0hmRUdJU252bmo5NFZUVHF5OVBmWFZPU1B1QkJScHhnVytLSlNE?=
 =?utf-8?B?YnYybDhmRlRKZFRqOWx6Rk01Uloxb0pWbmRIaWkrbWNUMzNlUDhGLzNndk00?=
 =?utf-8?B?RE0rTURLc2pFV1BENllyOFVUOVlkWmhkT1JDQ3dsTHJaNnA2Zk04M212MDNt?=
 =?utf-8?B?cmczS2NEbGxFRkRlWDJ5NkM3dGxFUVk3TEpEbWNuUkJBS3lnNmpjK2lBbXNn?=
 =?utf-8?B?REZpaElyNXppcWhKVHprV2pBMkZoUTRWa0VPRWpGd3BmQ2tFTkZmeWxnaEVw?=
 =?utf-8?B?bnloNkJCTHRnUXdXMEpDNC9XQ2l4RVZIZjM4U0tlMGJFVXJaWlVhTk03MzFi?=
 =?utf-8?B?QXB2YzVkSWN4QmZmS2R2NjRxckZZb2MyMERZMlFtb0F6RmUwOHY3TTlIRzFB?=
 =?utf-8?B?V2Z6ZFp6TzFWRGtkUVRzMHdqNW1WQWhrbHZLOFNaSWtmK04zSithbk8wNlk4?=
 =?utf-8?B?NHdNbTJPcGR5REtSVXpVOFdCckhFMlhkWjhsNUkxTW5qaGFxd25SOE1hbkNZ?=
 =?utf-8?B?Q3dQUkFoUlRsaTNGZW5QOUpoaTU4MFZ6RHdLYWVySnFEN3pJU0ZNWjN2RTAy?=
 =?utf-8?B?R09ZNENVVnZPTmNVaXlZdXZqNGRqUzZKbnhkS1YwRk5aM1MvRG4zZzVMTkNO?=
 =?utf-8?B?c1kyZU5Ta2daeTk3aTZkSllVTDFaZVZhaE4rZVIrNzN0WXdaZVp4cTNuVmFV?=
 =?utf-8?B?L2dTOGFNclZUM3BjLzQzSlVJNlg0em9JVGFuY2Yzbm9lRVVESVFwUWFhSXBo?=
 =?utf-8?B?Y0VPYldpemR0bHB0c1IvYlB6Wk5qZXVhSk1iUkZmMjlSMFl2WUQ4MzVTNGxM?=
 =?utf-8?B?c042YWxVUG5pS2ovemg1V0huTHAyYUl3dzJZd2h3L0tzZ2hHV0J1V0JRNzN0?=
 =?utf-8?B?R29WSDRyTkQ1NUl4TEZyMnZZU1E3dUdPMldLS3hXTFo3UldlOGtLeHhNMlI3?=
 =?utf-8?B?YWMxSkZJOTNsZmErbTVDNVljek80dEhYZGkxcVhWbytlZFlPeVJpT3JVRVYr?=
 =?utf-8?B?a25LYlJKRDRBK25UWGdxSGEzd1VOeENuZVh4K21xUUhQUHdYREs0OWNtcFJM?=
 =?utf-8?B?ZDdsNlVGSHQrSENiT0pTdGVoWlQ1QWNzUmEwcmFPUHl6TWFwUjNZdlMvQ0Zp?=
 =?utf-8?B?WHEwdmZGcHYyNDhGRGFVUU1jMDBYeHZlUkVLYWp1YjNucW5QV3RQcWhJS20w?=
 =?utf-8?B?bVhaUkRaZzZORmFPeEh5amZMSnB6OTJQMlFoemJmUTBaSFNoRWROWHdKaktp?=
 =?utf-8?B?eWM0azVNTXVJZWpwNEFheFo2Q1pMb0xjVjNnZDZTajcyaXE5ckZPU05qRXho?=
 =?utf-8?B?MmRoc1BTRFMzTnpRaUxuQmtqc0x5dW1xRjA3M0RZV09lWTQ4Y3VPZjJseURq?=
 =?utf-8?B?bWZNbnl2YnpXSVhpaVgzeXBLM0hGRE5pRUgwVWV2cVk4TnlOdEw4VEprMGJM?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 19IdFcjuwNIe4RNvxAycUpX6NmVT3zg9m45aAkA50RwlQDQV1+Uqz/ZyuLL81Qh+dMRNP/j4tRH902bZUoFSq4G8opz3HK0EnIVRH2Tk69dyZBM88awCq5mZ5zzK6foTKnOqTRhf2n5ghqsn2gbzWD0l5EoQmgk68lPopRL/WbOUDncgXSUU9c2M0pNijAPb3RrD83bJ8q/Jas39yryAF9g6zpZpUBELGAFolZHWWal3jBkR31pFATYyix6AchAV/D7z3q2It8r8t+2qL5hLhRgBnJcJzDs5fIQvrpC4W+mnUH10xZeUi+H1EANr5eSgQU7Ybifz6EvZ8YAiFyciKqhcdKfApm41f5YdWfseocaCRYgOXEFa9MUWxFeVnnduSjUyoB2ZEMmgksncIl1ij3vs5rwDABZbRpLvqO5TFzPMcy9J6xdnn80kLek26rVCEIdEzfRnUx/9vN2e7I3mHTzr0Fa181ZeWHSuivR899rsno3ZRPvffuJ/Dkz/UOqk3bzs+E/z7aul3jVdiIScYaQGx7FLkxwiSQu63Tt1oFCrwd3gBGbZh2w2A9ANIARv2qOoEzuNZiN1WvF5zwrpHrVOjRXfZHgNLBG3OFMxgBpodVkBVy55PqQyXDJrMAdtceMTLNbLcwlh1aPMvDodGuw+KWOIuIfUiPU7fBpVaVg7KIo5eye2tPb1JckiD+ftN/0Tq70ttrEBBzUB6ss0UE8pJDt9HhkYr9p06P0jPQzUsEUKxC42LeXDUQzwriYjrrHD+ZauwgndoDMwkQb53g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7607dd6e-c3a9-4ec3-30dc-08dbe476fa44
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 18:33:06.0109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hOkt+MKOUht/gtiDsqW0Ke6ixvCyG25y9D4+5ssRMQ8lpVP8+b4EnOcvAYA6dW8tgnAOfNqeIo7t3KGZp4osFYWmNlpwhLLNe5AS4K4Jnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5359
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_09,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311130151
X-Proofpoint-ORIG-GUID: dBq3MsvsjLG0IpsjqH2C1CQXbsrijVko
X-Proofpoint-GUID: dBq3MsvsjLG0IpsjqH2C1CQXbsrijVko
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 8/30/2023 1:00 PM, Peter Xu wrote:
> On Tue, Aug 29, 2023 at 11:18:02AM -0700, Steve Sistare wrote:
>> Define a state object to capture events seen by migration tests, to allow
>> more events to be captured in a subsequent patch, and simplify event
>> checking in wait_for_migration_pass.  No functional change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/migration-helpers.c | 24 +++++----------
>>  tests/qtest/migration-helpers.h |  8 +++--
>>  tests/qtest/migration-test.c    | 68 +++++++++++++++++++----------------------
>>  3 files changed, 44 insertions(+), 56 deletions(-)
>>
>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>> index be00c52..b541108 100644
>> --- a/tests/qtest/migration-helpers.c
>> +++ b/tests/qtest/migration-helpers.c
>> @@ -23,26 +23,16 @@
>>   */
>>  #define MIGRATION_STATUS_WAIT_TIMEOUT 120
>>  
>> -bool migrate_watch_for_stop(QTestState *who, const char *name,
>> -                            QDict *event, void *opaque)
>> -{
>> -    bool *seen = opaque;
>> -
>> -    if (g_str_equal(name, "STOP")) {
>> -        *seen = true;
>> -        return true;
>> -    }
>> -
>> -    return false;
>> -}
>> -
>> -bool migrate_watch_for_resume(QTestState *who, const char *name,
>> +bool migrate_watch_for_events(QTestState *who, const char *name,
>>                                QDict *event, void *opaque)
>>  {
>> -    bool *seen = opaque;
>> +    QTestMigrationState *state = opaque;
>>  
>> -    if (g_str_equal(name, "RESUME")) {
>> -        *seen = true;
>> +    if (g_str_equal(name, "STOP")) {
>> +        state->stop_seen = true;
>> +        return true;
>> +    } else if (g_str_equal(name, "RESUME")) {
>> +        state->resume_seen = true;
>>          return true;
>>      }
>>  
>> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
>> index 009e250..59fbb83 100644
>> --- a/tests/qtest/migration-helpers.h
>> +++ b/tests/qtest/migration-helpers.h
>> @@ -15,9 +15,11 @@
>>  
>>  #include "libqtest.h"
>>  
>> -bool migrate_watch_for_stop(QTestState *who, const char *name,
>> -                            QDict *event, void *opaque);
>> -bool migrate_watch_for_resume(QTestState *who, const char *name,
>> +typedef struct QTestMigrationState {
>> +    bool stop_seen, resume_seen;
>> +} QTestMigrationState;
>> +
>> +bool migrate_watch_for_events(QTestState *who, const char *name,
>>                                QDict *event, void *opaque);
>>  
>>  G_GNUC_PRINTF(3, 4)
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index 62d3f37..526a1b7 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -43,8 +43,8 @@
>>  unsigned start_address;
>>  unsigned end_address;
>>  static bool uffd_feature_thread_id;
>> -static bool got_src_stop;
>> -static bool got_dst_resume;
>> +static QTestMigrationState src_state;
>> +static QTestMigrationState dst_state;
>>  
>>  /*
>>   * An initial 3 MB offset is used as that corresponds
>> @@ -188,6 +188,13 @@ static void wait_for_serial(const char *side)
>>      } while (true);
>>  }
>>  
>> +static void wait_for_stop(QTestState *who, QTestMigrationState *state)
>> +{
>> +    if (!state->stop_seen) {
>> +        qtest_qmp_eventwait(who, "STOP");
>> +    }
>> +}
>> +
>>  /*
>>   * It's tricky to use qemu's migration event capability with qtest,
>>   * events suddenly appearing confuse the qmp()/hmp() responses.
>> @@ -235,21 +242,19 @@ static void read_blocktime(QTestState *who)
>>      qobject_unref(rsp_return);
>>  }
>>  
>> +/*
>> + * Wait for two changes in the migration pass count, but bail if we stop.
>> + */
>>  static void wait_for_migration_pass(QTestState *who)
>>  {
>> -    uint64_t initial_pass = get_migration_pass(who);
>> -    uint64_t pass;
>> +    uint64_t pass, prev_pass = 0, changes = 0;
>>  
>> -    /* Wait for the 1st sync */
>> -    while (!got_src_stop && !initial_pass) {
>> -        usleep(1000);
>> -        initial_pass = get_migration_pass(who);
>> -    }
>> -
>> -    do {
>> +    while (changes < 2 && !src_state.stop_seen) {
>>          usleep(1000);
>>          pass = get_migration_pass(who);
>> -    } while (pass == initial_pass && !got_src_stop);
>> +        changes += (pass != prev_pass);
>> +        prev_pass = pass;
>> +    }
> 
> Here won't it start to wait for 2 iterations every time instead of 1?
> 
> Note that previously we only wait for 1 iteration as long as not the
> initial pass.  

I don't think so.  Both the old and new code require at least a transition from
pass 0 to 1, and pass 1 to 2, to return.  With the old:
  when initial_pass becomes non-zero, done with first loop
  when pass changes again, done with 2nd loop

- Steve

> And I think the change will double the counts for below..
> 
>             while (args->iterations > 1) {
>                 wait_for_migration_pass(from);
>                 args->iterations--;
>             }
> 
> The event-related changes are all fine, but maybe leave this piece as before?
> 
>>  }
>>  
>>  static void check_guests_ram(QTestState *who)
>> @@ -586,10 +591,7 @@ static void migrate_postcopy_start(QTestState *from, QTestState *to)
>>  {
>>      qtest_qmp_assert_success(from, "{ 'execute': 'migrate-start-postcopy' }");
>>  
>> -    if (!got_src_stop) {
>> -        qtest_qmp_eventwait(from, "STOP");
>> -    }
>> -
>> +    wait_for_stop(from, &src_state);
>>      qtest_qmp_eventwait(to, "RESUME");
>>  }
>>  
>> @@ -720,8 +722,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>          }
>>      }
>>  
>> -    got_src_stop = false;
>> -    got_dst_resume = false;
>> +    dst_state = (QTestMigrationState) { };
>> +    src_state = (QTestMigrationState) { };
>> +
>>      bootpath = g_strdup_printf("%s/bootsect", tmpfs);
>>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>>          /* the assembled x86 boot sector should be exactly one sector large */
>> @@ -801,8 +804,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>      if (!args->only_target) {
>>          *from = qtest_init(cmd_source);
>>          qtest_qmp_set_event_callback(*from,
>> -                                     migrate_watch_for_stop,
>> -                                     &got_src_stop);
>> +                                     migrate_watch_for_events,
>> +                                     &src_state);
>>      }
>>  
>>      cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
>> @@ -821,8 +824,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>                                   ignore_stderr);
>>      *to = qtest_init(cmd_target);
>>      qtest_qmp_set_event_callback(*to,
>> -                                 migrate_watch_for_resume,
>> -                                 &got_dst_resume);
>> +                                 migrate_watch_for_events,
>> +                                 &dst_state);
>>  
>>      /*
>>       * Remove shmem file immediately to avoid memory leak in test failed case.
>> @@ -1516,9 +1519,7 @@ static void test_precopy_common(MigrateCommon *args)
>>           */
>>          if (args->result == MIG_TEST_SUCCEED) {
>>              qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
>> -            if (!got_src_stop) {
>> -                qtest_qmp_eventwait(from, "STOP");
>> -            }
>> +            wait_for_stop(from, &src_state);
>>              migrate_ensure_converge(from);
>>          }
>>      }
>> @@ -1560,9 +1561,8 @@ static void test_precopy_common(MigrateCommon *args)
>>               */
>>              wait_for_migration_complete(from);
>>  
>> -            if (!got_src_stop) {
>> -                qtest_qmp_eventwait(from, "STOP");
>> -            }
>> +            wait_for_stop(from, &src_state);
>> +
>>          } else {
>>              wait_for_migration_complete(from);
>>              /*
>> @@ -1575,7 +1575,7 @@ static void test_precopy_common(MigrateCommon *args)
>>              qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
>>          }
>>  
>> -        if (!got_dst_resume) {
>> +        if (!dst_state.resume_seen) {
>>              qtest_qmp_eventwait(to, "RESUME");
>>          }
>>  
>> @@ -1696,9 +1696,7 @@ static void test_ignore_shared(void)
>>  
>>      migrate_wait_for_dirty_mem(from, to);
>>  
>> -    if (!got_src_stop) {
>> -        qtest_qmp_eventwait(from, "STOP");
>> -    }
>> +    wait_for_stop(from, &src_state);
>>  
>>      qtest_qmp_eventwait(to, "RESUME");
>>  
>> @@ -2139,7 +2137,7 @@ static void test_migrate_auto_converge(void)
>>              break;
>>          }
>>          usleep(20);
>> -        g_assert_false(got_src_stop);
>> +        g_assert_false(src_state.stop_seen);
>>      } while (true);
>>      /* The first percentage of throttling should be at least init_pct */
>>      g_assert_cmpint(percentage, >=, init_pct);
>> @@ -2481,9 +2479,7 @@ static void test_multifd_tcp_cancel(void)
>>  
>>      migrate_ensure_converge(from);
>>  
>> -    if (!got_src_stop) {
>> -        qtest_qmp_eventwait(from, "STOP");
>> -    }
>> +    wait_for_stop(from, &src_state);
>>      qtest_qmp_eventwait(to2, "RESUME");
>>  
>>      wait_for_serial("dest_serial");
>> -- 
>> 1.8.3.1
>>
> 

