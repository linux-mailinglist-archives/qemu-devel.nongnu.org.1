Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E63882F810
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 21:36:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPq9y-0004Cg-Jh; Tue, 16 Jan 2024 15:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rPq9r-0004AU-QT
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 15:35:41 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rPq9o-0003pQ-Ly
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 15:35:38 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40GKEO5f031439; Tue, 16 Jan 2024 20:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=itMKZGGyj1TR+5HyRLu4gm2i1i1maGDYHItpQ/2AEMU=;
 b=B9JAQzak3BtoDblY/IZ8+KTQ5tTXlYNcfD7oY9IQSR6VLlxZv5Vm+pE7fYs3dvMp/vDM
 ZSbK9IL2WPOLEApMFB8aX9V+N5+pj82MBssp00/J4dC/Y9ZSxKsdNJs79mkH8vmqR7OK
 DOhw2dVmIfLn2tfxnGc64+nrXAkTXfovVAex5PjX9zP1hNhmEHzRi1Cw3Tv4HrDfGcoh
 aaZqoEBXt7lILMh8CtGmN/Yvmv4Ql/IAhYJX9nmlNrptPvx+WEuw4ypGlAYZKnaKyikS
 PlkBjQYaFwhwrQI+Pl1/4TpSWYJewuDEK8BpZmHSLnzym3N5so+Pwoknx2ANyyeqk9Nc Vw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkk2u5xtu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jan 2024 20:35:32 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40GJQ8lT020046; Tue, 16 Jan 2024 20:35:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vkgy8scph-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jan 2024 20:35:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXs/f7Y+FvdA/nNkZ2GMwj6LdzMRrBVNvbisU866UL2Enx/dRWqvsR2OpQIbcV1oesLVZQzC94ZIid6JSmb1XvEasfcN+XU8nJlEnUxPnFhlaVhj6M3Bb4W1PtOS/oBpvM1JtDGewG6EhKlO10w7LrDiBhYCKaDYr7C3e6RioV6qSvSvBxsux5YPaZo2Zr0pKGjJDuL37ALhAi13SjPMCKhFBNGyFqgtDjW9exAz1Aw2kbwidKq43oPHh1MJKrxaFeU1UsiJIvGDpl5B4cy1nM3IP1q9JHbU9fTMJD6OJ/uCyVICtlIZ2ofqR4BAXLWFllnvro7k4D9Qwa8BnK0kug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itMKZGGyj1TR+5HyRLu4gm2i1i1maGDYHItpQ/2AEMU=;
 b=PWFEdRz97G8hGy2bs2tfuAyJXSy64FQrdowBieckVazrHVVNuPeI6AX5QCw46pNgozHrDXcXI4PWTJM89tJ+h9wQh4rC7eOoHU6haij/iTzGYp/z5YKYPqClMqT7HFkhtU7LKL0lJ+U08P0z+pSsWvD9WBbFaPny4qAaixA2R2pe1MsFwYi83UyYl03nMk9SLffdBKWs/rBc/UFzbB8j18oKmA2NQquLWYnJl688vUz6EdipJs16Yz83rDn/EWoc55uXMazXjXcj9vA++eTMdDK0Gn7pf/nvKryXWHIHvX9VPeAn2NzR6Y79nbr3KhU2UJpwMAq2kPklE1Cdzg7LXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itMKZGGyj1TR+5HyRLu4gm2i1i1maGDYHItpQ/2AEMU=;
 b=HWILHILTemKFHu7V5LKzCM0CKylwtFCJuRLfNfmxD5bVRry96+/av9kwg+gslPqB83TjSk1voejqpCco236vGUM5NdU+H8bngHmKRqY16JMXBpX+NcvKYIzmhiVbKO6tR496zMlCae2JLd5MqtczspGnDwlcrBHn9idNTJR3tGw=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DM4PR10MB6208.namprd10.prod.outlook.com (2603:10b6:8:8d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 20:35:28 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7181.026; Tue, 16 Jan 2024
 20:35:28 +0000
Message-ID: <3136365b-ab70-44f7-8863-f39c2a527ac7@oracle.com>
Date: Tue, 16 Jan 2024 15:35:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 08/11] migration: refactor migrate_fd_connect failures
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
 <1705071910-174321-9-git-send-email-steven.sistare@oracle.com>
 <ZaTgyfYvyH-BW4Ev@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZaTgyfYvyH-BW4Ev@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0076.namprd05.prod.outlook.com
 (2603:10b6:a03:332::21) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DM4PR10MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: 58bd84fa-a459-4930-0d83-08dc16d2ad4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CjsUpnOwHvAW8TH9WHN7oywWIJ7v+BMA0bf7zsKRZr5pJ/swzsD8YqBe9178WIZEodAc0q7UbsEY6LkJjd91yeeRIdsdO/l9NqMS160GPMYF00ANbtY7+9nwjaWrFiUGiVA53hLAnc8ccKOqsVtXcUXvgrE1uSHTGu+3U0Wz7Jep4Yt1Z7FSesUgzii8mK79b3lAuk2lpUX7qM+FIyJOPlU5pibCD0xop3nD00efb7yyRkOSAU9KlgVuRDjW1gl7FvSzC6bB2il8M86TLX9ccA5h+nVfDWPoQlX2Ncxp/8wSASyYlBX1k4EfmQq6tSKwPiPwKJtri6mlD1niPbgF0lw0+c6ss6KFK9icTyyVH8ktAhwvxmZQcVEir5oBRwQ7Jb1grH3OorU000tfy+jWo+Wo3OKL6bzM4z4a7a1juK9adm6qVPr1iYF6WLuRs76HIq+m52LHsAEdqd8nCNrCcaqHtx8yVrmvA8z2IcugWXLcqvxNJwDSD/NXbkrF9XvT7/sc5Nqnw1PMKSrzgFQWVR1voY9Bg7SO2AxCEq2LDmEGqvpF8jK7yI06kcF7+ExGGCuPbkM5WUrD2iu0jgaHxN+SD5c96PqxoCCRjELNFpWt0PZFhGPKvmOOZFq7l5dUVExT+ICO1Ske9XkT3C/oLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(39860400002)(376002)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(41300700001)(53546011)(36916002)(6512007)(478600001)(26005)(2616005)(6506007)(6666004)(8936002)(2906002)(5660300002)(7416002)(66556008)(6486002)(66946007)(66476007)(316002)(36756003)(6916009)(8676002)(38100700002)(4326008)(44832011)(86362001)(83380400001)(54906003)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1hLSjIrR3d6dVJ6TjFKSkhXSnZUUjRkbk9nbzNDaE9JVWR0aW13OUtraW5r?=
 =?utf-8?B?Vmt6dFJjS0pUYnZaRTNiVkVlNnZETlNQMTRVbGRwOWttbGtoRHJqSW1PdFFs?=
 =?utf-8?B?Qmw2b01xOEFsL0NNcE50RCtuVncrU0w4SlQzaWlDN2Q0SVNTRlVWczB0MTRC?=
 =?utf-8?B?SUJsVW1zbncxdXdXQ1JTVVRiOFJNOHF0blE1VVR3RVNaWDFZUzhEZ09GWVc4?=
 =?utf-8?B?V2h3T3hKUU5nQ25mU1N0NkRCLzRnQzlzdHBVTER5YlJ0N3RlSEh6RjhzTXUz?=
 =?utf-8?B?WEFIdU5KVTREdzR3UTU0dlBWSFQ4d1d6eEp2OEQ3b002cndnSDNYQ3AvRGJm?=
 =?utf-8?B?eWh3VTk1ZFhFdFZNclM0a3pCczFIc3h4TEViUnhRdkNjd0NwRnJwdmdzVW1n?=
 =?utf-8?B?cFg2VDVyOVVjbjhDVUFlcGdnK01hOWZ2b0M0TU1iM3VybmpnclNHRVVQRi9Z?=
 =?utf-8?B?STVuMzNhT2l6c1RpRjcrQkFaQlp5Mjk3VlJJcVJmTVp5RG1BUlh2bCtWY2ZB?=
 =?utf-8?B?bHFESGRhSXJGNGN5QlV1TFdQNWxxWmUreEt0U296b2ozclg2ZURnd3ozUHo1?=
 =?utf-8?B?bUhVS29Tc091WEYxUUtoYmNLMDlhRTZjclhhQWt6MHY2SG00U3U5Y3A3elhP?=
 =?utf-8?B?bGo1K0dad2RCSEVUUmV5bjQwc1pBTENqK01yZWJjNDFBenZYcFRLYnN0STZT?=
 =?utf-8?B?OERubHg5c1IralVKQUZSVzlRYkVrMkIweDh5R0ZJNlFtaFlhd2Q1bDdNSEJ0?=
 =?utf-8?B?ek40VjN1WVBzcjNTK3RsK01tek55cVNWNTcydm9rM2E2T25VclUyMWNlMTBw?=
 =?utf-8?B?TWdTUFU1V1hBV2ZES0o0NnJ3NmFWZTZFRlpNbTErallGTTEyNEJhTEp0T3Js?=
 =?utf-8?B?azBpbkZwZUlMMmIzYTJSdm9yWGphdjFEVHFPckxqWThuSktmV3FTT09vOVN5?=
 =?utf-8?B?NWpXZFBYWkZadWVvYmM5cHRRYUhYdEV0R3ZJb1pFNHVyTVovdVBHMTJxWnVS?=
 =?utf-8?B?amplVStXaHlYejZvWTJ2YmQ1R3BIcFVjOVBxbkphVGEzWExIV2RleWN5c0Nk?=
 =?utf-8?B?Y0czekZ3VlVpTDk4OUdBN1picEs1ZXhyeUxkeHVxSFQ5Q3N1Z3BZdGVVSU0x?=
 =?utf-8?B?dkcyMjkwb0xSMXJrc1Z6SkRLRjJZbm4xbHdCNTJ0cjFWSm5acFVlU3lPY0l2?=
 =?utf-8?B?TGdsNXZaelhlNGp4VWxmNFkzS1AxQ2xiUisybG9XLytIdjRZWmJFbTNWUDFO?=
 =?utf-8?B?VkM5Q2VjbEJUTk9LWXlWRG9JUFVXNDM3aFVIZXMrUVFIRFFPVWd2UVo1c0tr?=
 =?utf-8?B?d0ZlVHByMko5Unc2M3RNY2NMOEorZGNwRDJyamR2ZGwzSC9GRTNLK0ZxbjBQ?=
 =?utf-8?B?NThYZGY0N1pRZXdrTDJBZUJoNmpHc3YyK0g3TW1VaUhwQVRaclhnZG5OdXN4?=
 =?utf-8?B?R0RvZ2ZuK25YSlZ6ajFVWWgzSGVtRm9qQXpHUG1VYjJPUmUya2ZjbFhXV0hn?=
 =?utf-8?B?WGpoYnFsTXhKVGlxYlAyc0lXc1dHdTJpSHd0RjczQkowNWYzbnM4VUZPbkpR?=
 =?utf-8?B?LzlRUUcyMHNRUDAwZ1BMZkZCaDNvMUk2MUdtTElkUFU2MEdNSFlpYmZvcm5C?=
 =?utf-8?B?Sjhhak9CczZ1M1dKcHlKYVQ5dElDODlEM3A2MkNXRVprUlAyT2xKT2xkczYr?=
 =?utf-8?B?bU9OL09kWkw2ak90bzdBMGtZNHZYOS9uOFhqYk92d2t0d2ZHci96WkVUOHVW?=
 =?utf-8?B?MlJWVS9ERmZpNXdWcHkrYk9BcXFhUjdBaTA3TWF0SXF6SWVUbVVHd0VPT2Iy?=
 =?utf-8?B?SjhpbU1SUTdLM2tmYkU3cUJ0dlNKcG9tTVBhK29yZzNqNVJpT2dDZnlMbUs0?=
 =?utf-8?B?STRHRzJQN3BSeVArMmE5TnYwSjBkT3hEdE1BYkRTZzVUeVV4K1Q2NjJlc2wx?=
 =?utf-8?B?Y3RsaVM1OTJFdWFWR2hEYXR4QXpUUVArSzJFUnRTaVBxWmo1U1d0amM1bXFR?=
 =?utf-8?B?ZTBEMXNnU3BaeUo5UHNWTEhHV0lFUnF6SllRM0NNR2JyWW9VSEIzU2JoTTJr?=
 =?utf-8?B?ZXJPSEF2bWxnSTROakJKMVd4TmZTOHlEOTBOM2RuMUZoSkZicnJVbmNMR1I1?=
 =?utf-8?B?ekl3MzRRRVpIN20vOXMxdGRmOEFXWjZyc09KN2wvMEM2eEhzWWFYd24yOFMw?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Kr2AlfTt9bK/MmEok0UfuBWOePPfzLF/8Nejzzxw+VeJODv2InI6S1yQVsf77FlBI4s62ZTox3touB847RLobafwKAD4ggyaE34yae7Q0mm2nMcDyz3nVGhj01RSYzB3PHh20OdP1UqhJ5cCWzum/3IpPym1HUMelIiqzU/Aqx1LuvOkJY9QnjCPNqYVIbAx2mO2Nu23QoVGmkcZo0OXLAIt2fOiTDzf4SAsMPSatEzZm/uVOVH5GhNmn+kaeT6B3c0oa5tS63z4unymfPMOfKPZupVg/8gtLyDWIe2afi2FwPB4dIsUOSoRE5boda1xaGrbFACq9nYG4kwY6oDvmbis+N7yC8jU+i8mbeYNqASR5uAwFhwY+o5v0LiPt+tg192f+xAZly/3iqdgNDNsNvg4VcvLNh19lApX8QO+s1NoQVh0Gu5X3gAmlr+JQB+AouF/1U+szXsS72zsdYIHJhg1Lawq/v4NN0pbqvvtT9eOEXkpAcYuMVAhICzTmKuZAbz5sRZGyPLrEaJ57wIw1yMRAzpDefIfc+XeVTbX/X0tZNosCHh8RgLBOU4JJw9dlOzbngWvyTHrC3tAJo89z6co5banoyhS9bdYYca5JMQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bd84fa-a459-4930-0d83-08dc16d2ad4c
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 20:35:28.7829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbN/jIusW+R2zI6jphD2TY5fqkxYvkB4zKWNoS7qh06hy7bFvwg2z4nvESALLs/Bj4T5laFoyB04p8QM9t8C5BW60OvGdwSDalcvwDw7vdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6208
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_12,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401160162
X-Proofpoint-ORIG-GUID: yw5WAzW1DZUx3NFfggVzzW8Nq1xmdgdk
X-Proofpoint-GUID: yw5WAzW1DZUx3NFfggVzzW8Nq1xmdgdk
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/15/2024 2:37 AM, Peter Xu wrote:
> On Fri, Jan 12, 2024 at 07:05:07AM -0800, Steve Sistare wrote:
>> Move common code for the error path in migrate_fd_connect to a shared
>> fail label.  No functional change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> One nitpick below:
> 
>> ---
>>  migration/migration.c | 22 +++++++++++-----------
>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index e9914aa..c828ba7 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -3549,6 +3549,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>      Error *local_err = NULL;
>>      uint64_t rate_limit;
>>      bool resume = s->state == MIGRATION_STATUS_POSTCOPY_PAUSED;
>> +    int expect_state = s->state;
> 
> IMHO we can drop this.
> 
>>  
>>      /*
>>       * If there's a previous error, free it and prepare for another one.
>> @@ -3603,11 +3604,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>      if (migrate_postcopy_ram() || migrate_return_path()) {
>>          if (open_return_path_on_source(s)) {
>>              error_setg(&local_err, "Unable to open return-path for postcopy");
>> -            migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
>> -            migrate_set_error(s, local_err);
>> -            error_report_err(local_err);
>> -            migrate_fd_cleanup(s);
>> -            return;
>> +            goto fail;
>>          }
>>      }
>>  
>> @@ -3629,12 +3626,8 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>      }
>>  
>>      if (multifd_save_setup(&local_err) != 0) {
>> -        migrate_set_error(s, local_err);
>> -        error_report_err(local_err);
>> -        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>> -                          MIGRATION_STATUS_FAILED);
>> -        migrate_fd_cleanup(s);
>> -        return;
>> +        expect_state = MIGRATION_STATUS_SETUP;
> 
> Then drop this.
> 
>> +        goto fail;
>>      }
>>  
>>      if (migrate_background_snapshot()) {
>> @@ -3645,6 +3638,13 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>                  migration_thread, s, QEMU_THREAD_JOINABLE);
>>      }
>>      s->migration_thread_running = true;
>> +    return;
>> +
>> +fail:
>> +    migrate_set_error(s, local_err);
>> +    migrate_set_state(&s->state, expect_state, MIGRATION_STATUS_FAILED);
> 
> Then constantly use s->state.

Yes, if you are OK with it, I also prefer to simplify here.

- Steve

>> +    error_report_err(local_err);
>> +    migrate_fd_cleanup(s);
>>  }
>>  
>>  static void migration_class_init(ObjectClass *klass, void *data)
>> -- 
>> 1.8.3.1
>>
> 

