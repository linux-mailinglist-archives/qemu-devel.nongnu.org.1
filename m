Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA7F7158FF
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 10:49:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3v1z-00052c-F4; Tue, 30 May 2023 04:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q3v1w-00051a-9d
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:48:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q3v1u-0000hG-C0
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:48:36 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34U5lLpX013599; Tue, 30 May 2023 08:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Lt7EW7W9ihB4ndaASi1XH5PQTCIxzhVvtQ5dIR12/SA=;
 b=qVsrvnKgSgIPKR4ekPogncSc6g3AhLyIcOG5IAMbYLCH0orSn8B2qnmejb6F3ynfCl+V
 SnMaPach22vbd0w6gRE8TvdR0EMv5qI6IR/ayjamwJ+riwMw7oFTy1gWcD8KdIpOPBZw
 hzS/plm3XnGE4l7czxM++xrWxe8PeWrULYQKh6QyXDKVUQAhJRz/y3lb9kzdRyZ4XxRk
 2sxGbyPa06WRX0V4guGlhhor4Q8sYdQIEOyko/WX3fh0171zLZAyc5LVJiL86nu/Pj10
 yMVCjU0uA2i81GmS6lnY2jZur932AeoAJJaqKllJvWuaUXRI9klOTboRlPpD3ju1Hcgk WQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjh264v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 08:48:31 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34U8GL0U014639; Tue, 30 May 2023 08:48:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qu8a3g51p-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 08:48:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQ0TMP27hqZ3pXTW5hSCDyYoi27P3RPWckbe79B2pqYj+7mZT3b22ljLYIfsMJbMEYG42IqN7skFtAgS4KOzEel8ymBQovNR9Z5fMhqHANGLEQ9rL9jxcXYkmXawiYe1O4UrMojkzXev7PRX2AZNo/mUZxOiDtW3FzllnMSFaTETEYHk4icLvqhd9h7OUbvGWsdE4VpKCiQEwuX5+G5s+/g3qn6p6im+DpJBg8VDNqlZL5jtZfnnQvZpNi6ulT6E4Dw2rtZHcUy/aPQZxBpyxPO6UA8UrJf9mpv9mAt2p5G+Crv9P7JDyLnSH5W92atEvQJekFoCSLARNj0SrEV5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lt7EW7W9ihB4ndaASi1XH5PQTCIxzhVvtQ5dIR12/SA=;
 b=NIP4BTXwh6jx9zH4VFiifY6oGOd3IMtnBbh/fn4zoG5kSiqjswYgtaATI12s2Zf3ti75Js7XtpUg/f7KgAzJ7E4DLU0jOqx0qb2vUoxyB+p5NQRvAlOQEl9weAyUUPpL6u7xpwZWTE3euolm2PNsf9WWg6yzeOSbLC9r653eZkTkzBE4vuFX3ZHKXsGDaVghJRjsXJ+VHjgugF8cemaFGebvksUZqO3tG1BTYuHEuZjcC0SyaOZCOJ7Q2MF4kvRJjvZhzqhSrE4fEugmMDv4KiK6ubp0wnCBCLq14ZrrgaMcxIeiW/mR+KTqJwU+Mpd3IbSVUlTZva5t2+RXFIF2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lt7EW7W9ihB4ndaASi1XH5PQTCIxzhVvtQ5dIR12/SA=;
 b=sJnCcsz+shuoJFK/rWGOlgezZ3SN7/z5ZrY2zK28N4NivAyT1N9nj44yIZpHTAOvLWx539LMu14Au4j/dIyTVO1W3uhRfdWokWpvPpuL+f9eqYJ4+YtrEibuOEtcudC2I5+VJGXiCxsCWzf6rb6g8Z8qI+bTIKXR95wB5gQzuq4=
Received: from DS7PR10MB4846.namprd10.prod.outlook.com (2603:10b6:5:38c::24)
 by PH0PR10MB4742.namprd10.prod.outlook.com (2603:10b6:510:3f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 08:48:28 +0000
Received: from DS7PR10MB4846.namprd10.prod.outlook.com
 ([fe80::df3:10ce:b3a0:c597]) by DS7PR10MB4846.namprd10.prod.outlook.com
 ([fe80::df3:10ce:b3a0:c597%3]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 08:48:28 +0000
Message-ID: <2aa582b9-2b37-e96c-1dc4-4c0dbcaebf23@oracle.com>
Date: Tue, 30 May 2023 09:48:20 +0100
Subject: Re: [PATCH v3 2/2] hw/vfio: Add nr of dirty pages to
 vfio_get_dirty_bitmap tracepoint
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>
References: <20230529121114.5038-1-joao.m.martins@oracle.com>
 <20230529121114.5038-3-joao.m.martins@oracle.com>
 <33c0d0b3-fbe5-9f1a-b3ff-f3e1f25d09a8@nvidia.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <33c0d0b3-fbe5-9f1a-b3ff-f3e1f25d09a8@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::10) To DS7PR10MB4846.namprd10.prod.outlook.com
 (2603:10b6:5:38c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4846:EE_|PH0PR10MB4742:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c64ec8-fd59-402c-5d14-08db60eaa2d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rut/EZ9lbbYnWbjWFz5zZOMBNqikB++576eduau7kbgFpVbMjxqPEGiuZ6bj38t6t/YL88V8pjZOVa7oYds5G2eWJDwWL1WTr6VFanNjjhoJ5v9+mfRku8bxKQaV0nq2EZWmu49kJCr0iZE0C0F3vJZvrwTB6Tq0lJKc0wlP+YwcF76ewOYDY3AInzB9S4NGSD9idWqwrJvUf/6JsdmH6iITXbFak1EyIjjGolnpJ1YWuiULbIoMPhTRFPtDtET18UsFL1zdcRkOIqlM9agBws47goZzIOIGKMfU7u6DJt7XkpYZqmzQb6jaxbKVYIk7fGV4sOnAZZBpqTfQYvCORImVH5Ytwz0kwIpE4tLeELxMb3cZkGcbvhdckL9AxcP7pAHeKYXApMiO+2ybz8IsZsGUsnv2OolhUqKFdrejzEQHeAPcn8OG7D22SUCBnN5R9BckGtGeUDky74cEd/PkYlWaPRtZn/5xJlfnOME3p5o6tYh0XcTCcxhQBl9e/QSz1KEtt4NUplRfQn4jqhu2HjQ4PIsHXpPMMfJpx6x1OF1ASP2ykjDSUbXqInG3Bd3sHQ6+cA1O04+xTgcxeqlhcR5evlUg4T/TvO6H2P2ixbqbQ/DgkAFHHv63FY1FtgAhY6XQKCQetVO67fGLYuLbrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB4846.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199021)(86362001)(83380400001)(316002)(5660300002)(6666004)(66946007)(66476007)(66556008)(4326008)(36756003)(31696002)(41300700001)(8676002)(8936002)(38100700002)(6486002)(54906003)(2616005)(2906002)(53546011)(6506007)(6512007)(186003)(31686004)(478600001)(26005)(14143004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzBGcU5aQUx2ZmtSNzB3NVZURDZOTU9ua3d3WDZ5ZFBUOGlDQ0o2YVNxK0Nz?=
 =?utf-8?B?VFdTTEpQbWJoRG90K0JZVGw4c0dBN2c4UStvS0lGV2ZteXlrRE1kZmtOSll5?=
 =?utf-8?B?S0wrNE05YjF5bE5LVWJHYTFOL3RWRVJqOVhEZ2N4dmNDTzVLVHJxZGJaRTlw?=
 =?utf-8?B?NnBBQkFrSklLYnNGdWRBcW1nTFUrdnlIT1hMbmxjMzdRY2JlTE5iNGRjRmJi?=
 =?utf-8?B?bEdZeGI4N3VZbmZKVnIrZktQcnF4TEhJZjFGYVpsK1ZiT2Y5SG1NdzRiOWF6?=
 =?utf-8?B?cVQya0djTVlVNXllTTlKVjkveEJOWnRmc3ZBR2QvaE93REdJTXpuU2haK3c3?=
 =?utf-8?B?bjAxT2lyN2pBRmphNkthcCt5SStUN05nNU1FeEFiSVBjWUljTU9seUMzWDdv?=
 =?utf-8?B?WVJkcHdsdnI5MHhkSXpvZGh1SnBNdWFTaG1ITHZ0dHZQdnVNRUs2RjdTWnJv?=
 =?utf-8?B?TTJySG9oVFFXTmpaNGc1Z3FTUDlMSExCditmS29tS2lTTUg3YjlRNHRVOHNm?=
 =?utf-8?B?WHFEMFdXenFQbmFCbElDdE41Ni9NOVR5MTB6cncwak9IWjlTd2hOaGhlOHQ4?=
 =?utf-8?B?cFNVbnJYWFJoYzNVRmFLUzBLOE9YRm1PSmNKUDFlOWJnSUJ6WGV4TUpoVmdz?=
 =?utf-8?B?ZUhtWmlaS1Bxa3NsUUk3c3orM2xEVE9FZ1RNY1RuN3VJVzJNOHJwa3IraHZw?=
 =?utf-8?B?RkV1WnpsTWJzWjI1b0VPNm9KUVVFT1NxNnN2bnZoMW5wZVp2YmVJbkNHWEIz?=
 =?utf-8?B?ZnljWWJMaXViREdaRWxhYjVScmNld3RjVGhhcCs4ZlhESFVCM2luMHQzV1JH?=
 =?utf-8?B?dWxCRlZjYW9jbW9LSUlidFZJdjg1cmJsQmc3dFJuOVRJVEVuazVmaGNIRnps?=
 =?utf-8?B?aHpiRWhKT1hDaU0ybm9BdngzcmVKL3VvN1hQNE9iSE9mMm8yMEdWY3l0NjZn?=
 =?utf-8?B?aVVxSXliL0dYSUdFcDF0ZkpPcGhtUUhwWE00dXlRMnJtSVdEeXVYaGJNbGVJ?=
 =?utf-8?B?dHlLdWlhNXNienluLy9TR1ZCdS9jSFJ3MFFGRGo3SVB5ZWVmVGp4aEhyeHdF?=
 =?utf-8?B?UHhhVHo0SllZNjZvYkFad21sOWc3YUxPS0NidlRabVcrTGV6blNlakF1Mmlx?=
 =?utf-8?B?K093S0tsWURVRzJYYjVqM3o4TEJCUmZTV1FqZlhhbm9uWkpjZ0RYZlhiTC9M?=
 =?utf-8?B?Y3Bodjc1eUhjRjJTMks1SG9ZZWhLbWNxNUtFTE5LU3BWQ2luc0xTMnlLQUw4?=
 =?utf-8?B?OHcvbUFOMzF2TlBsakwwY05ibS9ka0VPQ3NIdW1icmo5RXZUWnlhc05QQTNY?=
 =?utf-8?B?TDdaeGdWOXdaTU51cWtqZTBTelNtSEtaZFlpOFUzSHVGd25sVE9kMlB5S2hQ?=
 =?utf-8?B?dFNzNHJ0TjJaeFJqNmtUQVNlejhEaTgwTlNtYU1ITHNXRHI4L0NnSFBXNEdR?=
 =?utf-8?B?NkxNekZsa3VKcW1MbHhSMW5rY1pmQnJwUWhpcEhnUTVDNWhFQ2hVeFdWcmt6?=
 =?utf-8?B?TnI5Z1c2c1E3U2grV1I3Q0lua3BPcU1sbXZ5OWJhN1hRSUJNQUVEb0pHaEox?=
 =?utf-8?B?SDNJTzlrdmY3Z0Ruc0tnWXJGRnVuY2FrdFBkZ1kxYjFYUERhc2hRQTNyRlhk?=
 =?utf-8?B?WmdESGJ1dHZnNlg3WXNEVnIzdCtmc3pEdlRVcFhNOWtybWdwanBMUFN0WVNZ?=
 =?utf-8?B?Z2sxVHlNbXN5SDgrZkxwdi9pVC9QeVZQc0JoN1JtVkZCM3dkNlZGMTExUlBK?=
 =?utf-8?B?OStXVzJzZlVZbk1WNC80Y21QU2ZidmQyZ2dXanF6UXlVYW9RSE9ja3l1Um9V?=
 =?utf-8?B?WHdoVTJnb1k4OXlyZGRpSUxUK3YwcTdvZWwyQnBCdDdJbmtVRkUrNjRSRXVv?=
 =?utf-8?B?RDhtOFBWOEQ4aE5QSXNISUFvM2JONERxV0lXVWE3bUE5dW1sdDJQd1VzVDBE?=
 =?utf-8?B?Wk13UHh0aGJrOXNYYTl5NE1yWjZ2czlta2ZJM3FhVlZrSHk1M1AvM2lHVFBW?=
 =?utf-8?B?RzNwSjUxc3RnR0I0RWVFcFlwcjNTY2hxTXh2OElLVTMyRTFOY3RHcE9jVlVS?=
 =?utf-8?B?N1lLYlBEMnZCb1Z5WEN4alJKaGRLL3JEVXlibVp2OVpKdDFLMW1MS2N3VTg4?=
 =?utf-8?B?RkhBREFKampScEtYTGhQa1VWa2JJQ3Nzb0l0VTl2U09LY09Zd2JHemhjSDJZ?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OL13NGv99swRxZlG5H6KMLTEt4qOVe+qa3j4UevgLJo2SckMMPEvjxKJ51Cmmjt2JGL5moVcx+b6LIfmO8nIhu5qLd/AxDkXhIzXZwDfrIYv3Wg8OC9ap8qtSVjDbDQylCzY0DJ16slfNKg+U8RuZPdow1BMBhJ/4W2m09db5jonDQwp3LZOSxtAoJZsw0umK6DIXddDQDIxxQqfyN6d4ffleFK8tVBgwXTncgig081KrDcQXr3Lel1GfrU+rozrusdLZp8iGIHw4sHzfx04emKxKJivzie4Uz2Pjh01jQKtIHXzg+YhcKBNWlmT042sItVk8XT5qa6mCqrnf89RFkwh7hqRwe8ptHMnxfC9hgWnN5DWuSXfGTv8AqUp8YgfnTXl1F23DFJLcc6Lgexl9m9Hp9yDBc9O7nDMfp3DS+Ebuz8lF5Zp/uvC8JxVq93SPfEXxPX8q8lWMLqpFP5M94Rtt9kCr/pzpoIEYkFk61XiUKQhsTuZJM0C3oufV+RWxNET7QC+T4MeJrd+TjXWTczfVa4ZiPYfT17/+xs/txkEnMUpLXL7MgZwrzjHFsxoKOVVqkivGdVoW12+TkoV92n6Y3gRaRu58DIIv5KAdZuIFepjHhbdPYo+n06hmQ5IX+se2pwiRCIIuy6TUH6jMwdpDGl5aZ2v5yTvQtI6QCbUIGTGNyQytQZTg1QMk8MB2tAFU6VJlUiIIZaqctRt/+r61VzDrW39snpUy1it9NaR9+Y0iOJOW5jXf2KH/hTqk6M/6G+xi5CPGYts5zpTjS9rELUciG1dL0i3ylnGjg8YqSLp8p4vG+yz6VXPh8SQByqM74Y7Xdq/hKC+AZkBLw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c64ec8-fd59-402c-5d14-08db60eaa2d8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4846.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 08:48:27.9143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFzXBy6ADva2lHRJFvSSkE9xuHqjoR8oKZaw4wzdRDpgTAVr5MsFTSmpGga5vwFuZfBjtej4dSnMe47RK1qYLetl0bfyGOKRtAOtK0p3vRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4742
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_06,2023-05-29_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300073
X-Proofpoint-GUID: 0d_PDFEIzTHmaOq636RY3y3NsQMn6SHf
X-Proofpoint-ORIG-GUID: 0d_PDFEIzTHmaOq636RY3y3NsQMn6SHf
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



On 30/05/2023 09:39, Avihai Horon wrote:
> 
> On 29/05/2023 15:11, Joao Martins wrote:
>> External email: Use caution opening links or attachments
>>
> Just a nit, maybe subject should be "vfio/common: Add number of dirty pages to
> vfio_get_dirty_bitmap tracepoint".
> 

Fixed

>> Include the number of dirty pages on the vfio_get_dirty_bitmap tracepoint.
>> These are fetched from the newly added return value in
>> cpu_physical_memory_set_lebitmap().
> 
> s/cpu_physical_memory_set_lebitmap()/cpu_physical_memory_set_dirty_lebitmap()
>
Fixed

>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   hw/vfio/common.c     | 7 ++++---
>>   hw/vfio/trace-events | 2 +-
>>   2 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 78358ede2764..fa8fd949b1cf 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1747,6 +1747,7 @@ static int vfio_get_dirty_bitmap(VFIOContainer
>> *container, uint64_t iova,
>>   {
>>       bool all_device_dirty_tracking =
>>           vfio_devices_all_device_dirty_tracking(container);
>> +    uint64_t dirty_pages;
>>       VFIOBitmap vbmap;
>>       int ret;
>>
>> @@ -1772,11 +1773,11 @@ static int vfio_get_dirty_bitmap(VFIOContainer
>> *container, uint64_t iova,
>>           goto out;
>>       }
>>
>> -    cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
>> -                                           vbmap.pages);
>> +    dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
>> +                                                         vbmap.pages);
>>
>>       trace_vfio_get_dirty_bitmap(container->fd, iova, size, vbmap.size,
>> -                                ram_addr);
>> +                                ram_addr, dirty_pages);
>>   out:
>>       g_free(vbmap.bitmap);
>>
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index 646e42fd27f9..cfb60c354de3 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -120,7 +120,7 @@ vfio_region_sparse_mmap_header(const char *name, int
>> index, int nr_areas) "Devic
>>   vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end)
>> "sparse entry %d [0x%lx - 0x%lx]"
>>   vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t
>> subtype) "%s index %d, %08x/%08x"
>>   vfio_dma_unmap_overflow_workaround(void) ""
>> -vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t
>> bitmap_size, uint64_t start) "container fd=%d, iova=0x%"PRIx64" size=
>> 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64
>> +vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t
>> bitmap_size, uint64_t start, uint64_t dirty_pages) "container fd=%d,
>> iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64"
>> dirty_pages=%"PRIu64
>>   vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu
>> dirty @ 0x%"PRIx64" - 0x%"PRIx64
>>
>>   # platform.c
>> -- 
>> 2.39.3
>>

