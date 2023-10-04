Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBCA7B774F
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 07:03:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnu1g-0000eA-78; Wed, 04 Oct 2023 01:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qnu1d-0000dy-T5
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 01:02:21 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qnu1a-0000tR-Lt
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 01:02:21 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 393N0WCO015825; Tue, 3 Oct 2023 22:02:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=ATxEvhuOzO9Q3ElaSpbZh4nbs1F8dC/03Bo6qmuUf
 wo=; b=Jwbznh+4Bj2YRhYYGR6Ii9PJJuvrRaw1+LOyWTodYaaPItSrWIrBfVhRY
 jBBwbHfiQCQxSNpya4Pr/ZV6k3rc10PtuRa6TPATGNkhZwyvb8a4U4bjoOAyHUUw
 ivvi0XvPAO7UZof3Yq/VSXg5vh1tooyxKfTupneMF210X2n1MuuMUD9MEbPqpSdp
 Orvmy6opywjXYkVPq+efd2w4MsrXVDhbXOzm8/Wk0R8X9M5Zru8SezCjgKdfT0gD
 CaqyqXRRyK5raJPPJJaUxsQRNt8hCs3OXlXXly3ANP+Vte1/1KUPL8SKg4TBH0u+
 D91qPgMlG+t2wSpJr1ww40wEtk3tw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3tek7vx79q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Oct 2023 22:02:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeRpYWErlf0AKf42GVFZ/kpZ7+0AcquCUpIW4m480F/jYObo8XGR7l8yUPDqCEuyFQmq/GSG2azqX479q2ICRebaC9TXtIg8aUoXGnBzj5R2gXIL1KLLlSRx7IECpAc6QIIaLYFeQuMwSppYPIsaLgyGbu3hUPEYndbURVmaf38dC/chm6vcAkqY9Xff57M2citJy//GKEwcHQsvLD6Gq9xA604/EcEc5zhqNidblbh4UL1NZtDfXBGF2PbwPrN9cpFKC2SWcTks7YYkD5Qe17otdEFHt9GKEDtqFtDj2wz1Wgm/kq/I7YUwH1R78cV4rxox+jvlGOC+TI1MLMk6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATxEvhuOzO9Q3ElaSpbZh4nbs1F8dC/03Bo6qmuUfwo=;
 b=hV7rOfTJqsVZ2cMhCU57I72z4oOzJyP6PSkYeEkRGnYd2+ImqyYDTN80wmX3ke8ixWVA40F44bINHXiMuxbJF+Kfov4TJWgU8NKfGxwalwFXNRGB6A4VSeGW31YwJ0Jq66f3qnsm2vLnFpVcy0EInwah/1k0WVKA4sRyz575zJfIiQXqU+XeY8gzQVD/jar+4GVUR5GFmkRTsCw2WKDWRUvtw0aBdsDTLSn8cpNSS6lTFi/hBb+hd73raYRy9Z9csf8IT5ttCMfXIdDFSFhi48FbImVJEpa5Kircmk7YrLapBMatmgsVOS8FoKQNDm9EKa1i0ejOgXL7m0k5jSAc0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATxEvhuOzO9Q3ElaSpbZh4nbs1F8dC/03Bo6qmuUfwo=;
 b=qyI8bsaNFKgoUchgLkXgTm65OJFROEypDsltbgC6moPgPVr9uYJLRNV/jh5G+eromhHMaJw1XZTdyIf/n+/EoKn7C5jCsb8YSUsp4icXq7u4cCIy60/4Oi/0brQxUgLBnAkX24ShWd7blLQoTRLkCQeGLlbmvOdBlP9VIRTvy4mO8xBoXetqUTRH5VG0cP3sBcEzZYKCO6c21jUZ4+cGCeR4UMcoKPs743n4AB4JOemO8NHsMURxFIQvHpk8mtAex5hWfPWxfCYgnXlaek7oEMeU6hT3m2QWTWkD50oxgDvVSyNYY8R/WK/FuBB6UAFMHZsBBEMf5ZBDeEFFljNzBg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SJ2PR02MB10004.namprd02.prod.outlook.com (2603:10b6:a03:557::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 05:02:11 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 05:02:10 +0000
Message-ID: <aee971b9-6482-6783-7358-192c81cbcce9@nutanix.com>
Date: Wed, 4 Oct 2023 10:31:57 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v10 00/10] migration: Modify 'migrate' and
 'migrate-incoming' QAPI commands for migration
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Peter Xu <peterx@redhat.com>
References: <20230726141833.50252-1-het.gala@nutanix.com>
 <30cffa41-3e39-205f-5119-d84d6303f58c@nutanix.com>
 <a81add8b-f08b-6589-e9f5-779a4a7bd63f@nutanix.com>
 <3fb6b8c1-7790-3ad6-62b1-81642e878f7d@nutanix.com> <875y4orbza.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <875y4orbza.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0215.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::8) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SJ2PR02MB10004:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c54c7fa-b1be-4e0d-0349-08dbc4971087
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y8kIlXM7KgasDsBOVJf3+MJMbarKGoPLF+l6Gu+RLjRp0Aj9JPT+MABJupI8VidEUgUzQ5B+qecxG+rvfv/PGoBGUjbww4R3yMJTRVX4j6945ccs1wBuUf+H8q+8WlePE3mNercZ54tB4pC3C+OHHzopLRS5w0rw/9Kv5Dnm+sRYRHLAAyVfp93Vkj8rygsVMFa2zFwQvI7HOHdpJ9hlJnPkmrbfy0HjlqxbkVAShTepFUlLD1GW2tkfD1oV3NIbxQt4OqVZEN6B2md7ymbLJgfVWw/KWBGuM3/FAuq5NUb2+Xs++W/9QH2HYxiz1fBUIgKYUMl0QW0krwC3n3MrF1D5o0RFs04ReJzfFOWf9KjXJZqz+ed2iEtduQDEmqhVGYohuERowBmst/ItayoeEXL0qhuzhR2Sa2dsi9v28ZEkUcdD8bZmSosNOtVd4ksqItji9Q4W3w63ToDlYR2aYRH2OVLimO8NGL+hHd0urKrbA/aDQF8eq4AKviq0PZhzTjKQElZLGU+0zTV0HDsE+rHXoN49jy63x6EwvyEje8mdqynGmdaRBW0wbqTTcl62W+aMowtB1EqplJ6k53hsURk7gUPcXpHJTretTUuTvEwfqQNkIcOXHMBIdJWOAPQweWPpR525AlF/iikr8c3dYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31686004)(478600001)(6666004)(6486002)(6506007)(53546011)(38100700002)(31696002)(86362001)(2906002)(41300700001)(2616005)(26005)(83380400001)(6512007)(66946007)(36756003)(316002)(44832011)(8676002)(4326008)(66476007)(66556008)(5660300002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDBNd1FrWkNpMTlva2tkcWlleDU1aUVpOHVNeGRKSkN5WlhyZWJuNXN4YXJy?=
 =?utf-8?B?RDRpU2xtcnhrc1ZXWUdaajJ1bGZleHc4NXo3OG0yNzI2QXpkeFgyK3hXNWlv?=
 =?utf-8?B?YllWUDBmTkNaQVJmRlRlOHdWUXYxeFhSaEF6dXNHbjJTQ2t4TC9ZT3lNb0xF?=
 =?utf-8?B?dm5oKzdrd3pDZWwvaE9QMEtXTDFmRi9xLzNqSjdUZUpMKy9Gc2R1WGRYd0VH?=
 =?utf-8?B?eFN0d3FrUjQ5b1ROYUF6NkZYMk9Ra1ovQkFYMysvS1l2OUVqb3dKUG5xWVBM?=
 =?utf-8?B?bDFRZVh4NytmY2thVnhQUXJDQ0QxOHpUR3VzTEpHcktKZnc4UTNqYUI3Z1lY?=
 =?utf-8?B?Y1d3eTFncmZxWU04YnlSdUNONXkwVytzdk5VUlhLbGNGZXpsMVZvbG1aNjNM?=
 =?utf-8?B?dkcrZzFPZGV0RHNGMVZCSXQwM3VOSnlBZWl3Nk5VU2NNWjVUdnl5Q2lQbWtV?=
 =?utf-8?B?M3ZkQTc1ZmZBYmxHc3hFSFBEbjNhMkdhRWo5T0szalUyaVVia0twajE4RXY2?=
 =?utf-8?B?Qzh5eDlLbTZ6Y3pMbXFuQlozSXRnRnk2SzZLODI4d29JM2NDMkM5R25nRGti?=
 =?utf-8?B?YWQyU2xkSWJlOFpBYmh2VlAvWTJFN2ZXQkt5YnR4Z0NaaGc2MXNHTEtjM1Yx?=
 =?utf-8?B?MWZhVUpTWWZXZjB3MXRsNytKdVY2bmt6UGFXNUpDb296cURZNUpLWnNjRUIv?=
 =?utf-8?B?K0RhcGs1UlJTd2hCUENkcVZVbWpNT0Vwb2JJZ0dXdlZ3VW1abnlzUUVRV2Ev?=
 =?utf-8?B?Mk9QSmR4OWtNQ1BoOUhaTWUvanFVUVdiMmVnQ01jQWdHOGdvNTh0YkVJdHVJ?=
 =?utf-8?B?SVF6R2MyUStEL0NCbWNLNTR2MEdIRUVhWlBWMkZxa2g3WVJhTW9pcjhLVU1l?=
 =?utf-8?B?bUpEQUpyaGV4OUxmaTJtbzA4OWRZcWxBcUx0WE1lWm1vSWZjU20zTThvRnlh?=
 =?utf-8?B?dXJXWUdYQm8xQlBuY0E5OVpJM0NPbFJ3NWk1N1hZVHpFTUFkSDBySGwxYVBE?=
 =?utf-8?B?cWpFOTdnR3YvcHZLTXkrQ1RDOGg5Vk1YMk05eGVrOGNyaFZ4SFNOWnl6RjZR?=
 =?utf-8?B?QnNxekZwV2UyVnJRbjZiWTc3NEhvOXhBZlNEelVLOW5DcnlFaldqN3lublI0?=
 =?utf-8?B?eVBUc25VMzFidkdFNXVScDU3eE03QUw5dWZNdU1NVDYvdzk1UVpxZGtoazFP?=
 =?utf-8?B?VFNxMGlQKzk0bloxWnFLZ1JnVGxabnY1T1ROWENhSjZzOC9ROHRTaWhZSW5M?=
 =?utf-8?B?NDZEMWkzMFdJbldhS0kvQnh5UVFIT1EzMmViM1RjRS9VZ01YaDFUT1lKSXpE?=
 =?utf-8?B?USt1QmRYR1FqRDZGalFsYW0xd3ovL2NnUC9PMWhLNmxGcml3UGdFbHF1Nmk4?=
 =?utf-8?B?T1lTc29zUFRFeGZNSzRwSVFaZXNYUCs1Sm42ejgyS2dhU1QxRWFROGFsSlVD?=
 =?utf-8?B?MVB2NWkrZEVXQzlGMGNGZHRiMjJWSEo1MGdOT25RZFJxRVppRlZjcER6dENY?=
 =?utf-8?B?WnljbVhZMVRaZTltTXJDd0E0VWtBWkg3WXRzS0xtVmNEckE0TUpuOVlKdVFw?=
 =?utf-8?B?eWxQZGtibDhWUEJpMS9KczNJbFltUkIxMlc3Z1ZKQ3dtLzBCcVFGWkFLRUdy?=
 =?utf-8?B?VnphM3h0K0QrZXh3Z0NvSHl0bHZiVUdGUTU1TzJ6U3NydEZxUGtNTmNnNWVQ?=
 =?utf-8?B?eUg4dWJId2R0THBITktkUlIrRTUxQm9mTjM3c0w0L1duTXd6NzNGWkV3WW5J?=
 =?utf-8?B?NE1QT2VHSVZ0Ukl1V001cTZxa0JraTg3QkZFWENiOU9lZ0d3MXBIcHdNNlY0?=
 =?utf-8?B?STk5U1hKdUpVTmNiSWE2Ylp0MlhidmFsSFVRYlQ3aHY3dXpCd1dYWk00citw?=
 =?utf-8?B?dzdnTm84YXdVTG5ac05QNVNYNE9hUG5Gb1g3WHlZSGVGdG4rTWE1YnRiTU1k?=
 =?utf-8?B?K2RiN2laZnlJQlIwazlTRUVYUXJkVWlid2JybEs5ODlCR0M4QWtjeTFxc1Bt?=
 =?utf-8?B?c1luRVNYcnZuZkpHQjFOM2VCeTFURlNYNG9wL1Z4NVJod1NHc1FSci83aWtD?=
 =?utf-8?B?SnRRTklGa2VNaWFKaXhyUEtWMEZ3dnFBNGpDdFk4TUxIb3pscVFzVFNiY0pV?=
 =?utf-8?Q?bEaZC9M51S9wDtTZ2xHEPpjuE?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c54c7fa-b1be-4e0d-0349-08dbc4971087
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 05:02:10.3414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcWgmdLcBh+0BHJWzUenyebb6c4rkFcGLSviUovm+lCK8lYWLImgtKQzKwI4oQZNUFTx95sfptOeaYye7reEqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB10004
X-Proofpoint-GUID: sTaPZK5MwDFWa6GUbZDD30vPS-RLL323
X-Proofpoint-ORIG-GUID: sTaPZK5MwDFWa6GUbZDD30vPS-RLL323
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.09, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 05/09/23 6:52 pm, Fabiano Rosas wrote:
> Het Gala <het.gala@nutanix.com> writes:
>
>> Hi qemu-devel community,
>>
>> A gentle reminder and request for all migration maintainers - Peter,
>> Juan, Dr. Gilbert and others too for review of the patchset series.
>> Received reviewed-by from Daniel on migration implementation patches but
>> need final approval from migration maintainers before getting it merged.
>> Also got acked-by tag from Markus on the QAPI patches. This is Part1 of
>> the 4 patchset series. Ultimate goal of the whole 4 series is to
>> 'introduce multiple interface support on top of existing multifd
>> capability'. Hope to get approval or comments from migration maintainers
>> on the patches soon.
>>
> Hi,
>
> Is this the latest version of this series? I see errors with make
> check. Let me know if I should wait for your next version to comment.

This series was last posted in July end and make worked fine then. There 
might be changes with respect to migration workflow by now I suspect, 
that might be the reason for make check errors. Let me send a fresh new 
patchset version and will resolve make issues there. Thanks !

Regards,
Het Gala

