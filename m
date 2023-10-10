Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6247BF223
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 07:20:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq5AK-0002Cr-PW; Tue, 10 Oct 2023 01:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qq5AH-0002CZ-DO
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 01:20:17 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qq5AE-0005QK-IC
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 01:20:16 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 399L5tmx029965; Mon, 9 Oct 2023 22:20:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=klGaOFfzyfxd
 8cJPDYPdUGeEz2gABBlicSqQNtEDuI4=; b=loAimDBRn9oz9X23hHDHz25U1X7g
 2MwL2EVyPuOI/Bx5DFE9dLgYOVALTGi96D0bfY2cHk5X5cYgEOucPL5ik2mTQkse
 stSA1yxijBoRFkhGbZ66lzScPdxoXBp3EQdwlPi98em64Q+fBPno+ADanK9SwNDJ
 aaeabYVeE4i1qgdKcMzLl3tkISCB9oVtMPohLbbEXYRCl17qwaV8ADCLUeIZxvqB
 maheMujxCyKOA6B1i0XaLINIeslcKcPyFIZqMg3IvVXhEvOuDZncZBbYPHx0K8MZ
 QQ4EB1ebppZ8wxG2n3c2Pnj+U9ZfpDAwZyIpjr70Sh+S/K3vhvAmPst9+Q==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhu4mefx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 22:20:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgOwjNO62oykm79KTTR1VWUSHDKcUltyJskGsdoGb4hCae1GXH4TpJHItRinbispcn9Dqe8iCLBFAuIdsU8iTOj3v9r+0MvMxDLr6Miel47dh4nJt4qIN790D05l30iGOAJt16aUO7qOWEl4XNQgN5F1cf2gR3/CoUgKaf5FM1mGvX1sAXC10rb3P+J7HTSE8XFHZ81g/mJL7+Ev2/uJIhqOhIG/p0pF/KNhw1irT1i0iB6LvqcztJ6lH9pI9FhY0WVwg35CD7TsCwgsfPQGdqMjnnoSNA2+6Tu8yHxHPQjRZPnPQk4mzcXuUblhN+Rh8OO1fCYnsOy4HgqMmm7OCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klGaOFfzyfxd8cJPDYPdUGeEz2gABBlicSqQNtEDuI4=;
 b=RIsgSJneU0KmboIoPv0vFkAVbtp72EiOT91dEiSUG69LKZp05MjgngWSDGzNNKYpvQXrPtW7S87KfO5JFkzoNC49K9Gh3qJ+JeaPtSP8v8dlzM9TRRFY1Ykfvpcsh21Xky2BMwFYTWYBgaO/hG+QRNhhxLJ8vZwg3ALUQ6SqcnZZFZxPX6WiUhenD24+5cqj0j5d5AMrfsQ76P1+9yVecYZQGH0kEZlDUKrYYPAOACF/vmbZ86DBHoga0wxcmLnJxCnA4A70hpUn1U8Oi1VrnbBf6rnKTvbrMv/5qqZu/3+S2fuTzepjeFUfySE4gHEvgqlf2tybP7l1zGkjXn9M/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klGaOFfzyfxd8cJPDYPdUGeEz2gABBlicSqQNtEDuI4=;
 b=yE9xjA4gTn0K1+kUyDD4jZXximaRyDJklv7Q3YjNTJ/T5uqTXNQSIv4sgHjUk/SfFoJ/Fv3/0qyT40n+zttBgf/g2sx4EakpD4DbWKAvCx3vO5/3yQp6ipchGZ8/ipL6oisfK+NWPu3byYU4BGrBgocpoegtoIiRipAD/GvQ9+fF+Idj/epw9/25uVqE0CY8ilj5o4Ab3g4hf2WBtemWzloZ8xGLaIZEe4jMC49RYfj0NtMms2X6yuyYMQkpCKnTbN5blLNbHSJa6lEv3biOhRt28H77/tXn0sl2xE8piDjXt9bMDSN9+k/ixzRif7qLxSn9G2AT7QOUNmQvfSrWEw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by MW4PR02MB7364.namprd02.prod.outlook.com (2603:10b6:303:64::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 05:20:09 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 05:20:09 +0000
Content-Type: multipart/alternative;
 boundary="------------IytMo0nwEgqSOvb7vqpmRASV"
Message-ID: <cf045403-8af7-4df6-972d-25d366c41436@nutanix.com>
Date: Tue, 10 Oct 2023 10:50:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/10] migration: Implement MigrateChannelList to hmp
 migration flow.
Content-Language: en-GB
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20231004075851.219173-1-het.gala@nutanix.com>
 <20231004075851.219173-10-het.gala@nutanix.com> <87bkdepfyk.fsf@suse.de>
 <f41198b2-bf86-4ef4-9bab-6c834b011ae7@nutanix.com> <874jizg8xv.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <874jizg8xv.fsf@suse.de>
X-ClientProxiedBy: BYAPR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::19) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|MW4PR02MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: b07b2490-b685-4c09-4309-08dbc950929f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mciO1QnP2aFeuerunmHBedpLAmw671tAa7ximLcj1fqIXv03L/CiMPWIQohAy/WEiZJQGapkSQZVr3RG+XN5FEiKDHbCvLIB5E9GrSec0mtytDj5j6yu+ngXd2YDYaeNSOIc9qY/wxlzjrmXXXhtMuWzgmw1Bc4sfMbEhuqLmJJyZjq9r510NKH6nf0v+wlRYoHo5ekFmHoqnpCW0Chas32kesK4bKHqEMM4uIyKn/5Wji4KZq1W34Caar/XWG1NjPeJYWfbFLRmEanGAyJxTybuByOJ+lzN/Y9J/7bYe8lYoxB/vJerjwXHMbGgU0M5zYIIoEXca19nnFeLUyyEa7IWUZfqcPJRGUzwP5pfsQkTEn0y+zehRyOFJRC4CfUDUwnvYelW6e8oGrJly1vrNBU3Px8mEd+9GOupvOLpjsboT9wYZFDc3aRBFPr+jfopd/1QQNWRs9biaVXf96vcoJUmCJETECDNe0E8hyC/k05s73B82dtKWJCrkBc3IJt2uvuaPyNMyc4LQOAnvo/YeYX/1SLLCx7FGazkiI4AogyxmmxKLNpvcW3NeeOxOzZNSOmzq2NF7uw15DGaZ4PITMkA5x5aAKsljnDSEIHR36hzFD1Xp5IkiwGdnPND0jcs+fDf1K0FCsL/0BRk09VYTpR7H08fmXlj5EQNnVd7iDZ2FRJLZNOxZIFMftPwTjzi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(39860400002)(366004)(396003)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6512007)(33964004)(53546011)(107886003)(6506007)(2616005)(478600001)(6486002)(44832011)(26005)(2906002)(83380400001)(5660300002)(66476007)(66946007)(66556008)(4326008)(8676002)(8936002)(316002)(41300700001)(36756003)(38100700002)(31696002)(86362001)(31686004)(43740500002)(45980500001)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHM4Rm51alpFaXpHaHExZTFTVWZ5VGh6cWRzdHFRV2VicmswQVlTcWlXOWtG?=
 =?utf-8?B?QlN4Zm1CMnJLaVp4NDBMaWI0RGNneDNLWStBVmZENXlQYVBjOHNlTDJuU092?=
 =?utf-8?B?VnphaWdDNHRGS05Da1ZkNFRrcUNXNHJ4SGI5Y25vV080NEZBdjZlSjR1Mnpa?=
 =?utf-8?B?cEVaeEFwSTdyVTNMRXhNNDFZRS83dkdBdzhzRWY3N2xVQXNLUEV0eWpZMGFU?=
 =?utf-8?B?Vi9MZy9TTXE2cWN4RS9CekJQTis1a0lXMkhYRWtuejlHckl3dUxSVEtocEhK?=
 =?utf-8?B?cjVRL01Kb3JVRmZmZGZqb0FJaUN2Tk1KOFZKdHE3QWxxT01heC9heTlhM0x1?=
 =?utf-8?B?WW9kUlJMV284K2ZqaGVRd0s2MzNJR2RVUGllcXNQZDBDWWJjNitpNXRvL09E?=
 =?utf-8?B?clpMVWo3TXNIN3pwTm51U3VtQkJuaUU5UVNNM0FJbTJqNlVRYzh6cHFob1Mr?=
 =?utf-8?B?ZzFJQzhIdmZZdU9hblA4VUdTc3p5SWErNU5qdzU3SzMxQUJiN21PZU8ybmRy?=
 =?utf-8?B?SCt2NHMxZGFVc1VnT0dUdktLNjMrdlZobWcxWXhPM0RUMVpFM3lOemVqWG96?=
 =?utf-8?B?TVlIZWVPaGlrVHp0b0NwcWo4cXRNaDV2bmZudDNMOHhRRjBSTmV6MDF4MjRq?=
 =?utf-8?B?UTRYTmlNYnZGWnBwK1ZCcVNuSVVEQmlkZ2JnTzhoZTJWTytZWVM2cTVwSWRF?=
 =?utf-8?B?TEtXbUhRSTZ1TVJmbEYra3dVTFljakprZElxcnRGQkQ5VzljZzNmcTdBcnBl?=
 =?utf-8?B?a2VBQlBzbXA5dU80T1FWKzFXbHRJTkRtM0h3Qkdaa3hJb0xCWU44YmNRSUJU?=
 =?utf-8?B?ZWsxejV0Q1FDZWZkT1FRMlRGTHJYUnFsd2JKMUVzKzRkQ1d6eWxScmFoQzdO?=
 =?utf-8?B?cjM0UHo2MlJlbXJhRjJBQWR3Mjl0OUtYRGFweSswemdITTNLbnNZZ3ZiNlpo?=
 =?utf-8?B?RDdKWWlRMnRLckNGZzNpdUhOVlBSakxvZGlZNVp6TTQ0VTBqa0N5MWdvUXdD?=
 =?utf-8?B?cGhudXJiSU5ZT1llaThFanJyQzZrYU5xQnBvYXBuejA0ZEZRNk00QXpIUTFj?=
 =?utf-8?B?OGVGRnBEU2trNWF5K0lubEU0dmsvak8zU3VTNmkxeHl4Qksyd1U0Nkd4S3NY?=
 =?utf-8?B?eUJuWXJmcWlWVkgyWUUvWEwxOWJwMFRVbjN3WDFnUkQ4S0NwKzdCS3Z4eTJP?=
 =?utf-8?B?VTBMcWJvOVh1dWxLeGUrWWhWeTBFcnNxWW5ndWpvQU9SLzNyeDBJRTUxR2N5?=
 =?utf-8?B?SDlScnNtQTVwQ3JZa1VzTzM3UThmZ2ZmTGdTd3ZmMWpLdjNqdTNDS3d1cWlC?=
 =?utf-8?B?WjFHWWkwdmM1aW04RnJkaWF1dFBmc2lSUkw2bFlCaW05NklGdGpxRGcvQTlP?=
 =?utf-8?B?c3IwNTExWDB3eUl5bnRiU1FEc1FQZVRNT1I2MW0zc2YxY0JIRkJCb3Z6VnJp?=
 =?utf-8?B?NUVMalYyUGRKejQ0Q2F4Y3E4dWNlbVZvdkkva3ZCMnZ3QlZzVWtpVjRmL1Rh?=
 =?utf-8?B?WTZOWTY1Uzk0Mzh3aVVoZjIwMnhBK2gxOHlDZG5RTFRSSk96RllqSXc3VHkr?=
 =?utf-8?B?WkNNUXlIYWtiRTFXWkxvNnQ0VzQ2Y0tGeGl4MjhNbGhlaHZ6U2ZRNWhrUjMw?=
 =?utf-8?B?RUp4VEJUeFN1QU9mMVBtREJCdy9mWFZnVlNDNGhuUHlUK084R2cvUkw4WXJD?=
 =?utf-8?B?clp6UVVZMUR0dnR1bVpPS2Y5UWlyTXR4bkRpanlEWTlrM0tYUDBmakoyaCtB?=
 =?utf-8?B?aDJLYWlKR0dTZW81WUV3anJrN0hZeXpPZHMvUmdaaDZhYTV5aFJxMy81Ylpt?=
 =?utf-8?B?RFJVVU9ZWWdlOFZxbHdZTVp2UGJVYXl3eXFJNjdrTW9MVjNCVUNDaTkyRnZ2?=
 =?utf-8?B?dWpJbUhSQkhTdFZuc0FGUVF2ellwNFViRnRrMDdCcEJqcjkxUEZDMTZ1WGNj?=
 =?utf-8?B?amhqQmtnemJ5RUl1MHNTMXZiRHBaN1hhQ1k4SFM4b1cyRC9kdDlIbnlORU41?=
 =?utf-8?B?eVg2N3FPWFY5MmgzSGovSGRoNnRoSHlSYkFIaXFvMkhJL203YXNDYTlFOTk3?=
 =?utf-8?B?cnQ0Z29wZlZsUDRTNGRWcVdqNWpWY2pxVVR5VG9QcW1jbTZtd0tjaTdsZmxw?=
 =?utf-8?Q?vDbWGPcqkQ4/qX7Ghy293rIuE?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07b2490-b685-4c09-4309-08dbc950929f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 05:20:09.8779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLPyY5TDtj3ZkgKR41KlJop2di88H8nnr+r9TyuR2KWO5utGE8SrdeTRbEmeuBFmwZLkeT+rurqpNoCzP73KlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7364
X-Proofpoint-ORIG-GUID: aJoiXZYASdsGf8ogOycYcwN_MHKopaXS
X-Proofpoint-GUID: aJoiXZYASdsGf8ogOycYcwN_MHKopaXS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_03,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--------------IytMo0nwEgqSOvb7vqpmRASV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/9/2023 8:05 PM, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> On 10/4/2023 8:55 PM, Fabiano Rosas wrote:
>>> Het Gala<het.gala@nutanix.com>   writes:
>>>
>>>> Integrate MigrateChannelList with all transport backends
>>>> (socket, exec and rdma) for both src and dest migration
>>>> endpoints for hmp migration.
>>>>
>>>> Suggested-by: Aravind Retnakaran<aravind.retnakaran@nutanix.com>
>>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>>> Reviewed-by: Daniel P. Berrangé<berrange@redhat.com>
>>>> ---
>>>>    migration/migration-hmp-cmds.c | 15 +++++++++++++--
>>>>    migration/migration.c          |  5 ++---
>>>>    migration/migration.h          |  3 ++-
>>>>    3 files changed, 17 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>>>> index a2e6a5c51e..a1657f3d37 100644
>>>> --- a/migration/migration-hmp-cmds.c
>>>> +++ b/migration/migration-hmp-cmds.c
>>>> @@ -441,9 +441,14 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
>>>>    {
>>>>        Error *err = NULL;
>>>>        const char *uri = qdict_get_str(qdict, "uri");
>>>> +    MigrationChannelList *caps = NULL;
>>>> +    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
>>> Just the pointer here. If I remember correctly the g_autoptr here would
>>> cause a double free when freeing the caps.
>> Yes, we'll just have 'g_autoptr(MigrationChannel) channel = NULL'.
>>
>> Is it because inside QAPI_LIST_PREPEND, caps will be refrencing to the
>> same memory as 'channel', we don't need to free channel ?
> Slightly different scenario here. Here the issue is that we will free
> the caps with qapi_free_MigrationChannel() before returning. Then, at
> function exit the g_autoptr will try to free 'channel', which has
> already been freed along with 'caps'. That's a double free, I think it
> hits an assert inside glib, if I remember correctly.
>
>> I am still not
>> sure what is the right place to use g_steal_pointer(), is this a right
>> place to use (non-error paths) ?
> It doesn't look like we need it here. As long as the qapi list has a
> reference and we're freeing the caps, then channel should be freed by
> that function already.
Ack. Yes, with the discussion in earlier patches, I also don't think we 
need g_autoptr too here. Normal pointer is enough as we are freeing the 
memory after the function is returned.
>>>>    
>>>> -    qmp_migrate_incoming(uri, false, NULL, &err);
>>>> +    migrate_uri_parse(uri, &channel, &err);
>>>> +    QAPI_LIST_PREPEND(caps, channel);
>>>>    
>>>> +    qmp_migrate_incoming(NULL, true, caps, &err);
>>>> +    qapi_free_MigrationChannelList(caps);
>>>>        hmp_handle_error(mon, err);
>>>>    }
>>>>    
>>>> @@ -730,9 +735,15 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>>>>        bool resume = qdict_get_try_bool(qdict, "resume", false);
>>>>        const char *uri = qdict_get_str(qdict, "uri");
>>>>        Error *err = NULL;
>>>> +    MigrationChannelList *caps = NULL;
>>>> +    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
>>> Same here. We free the channel via caps and we attribute it below, no
>>> need to allocate.
>> Ack.
>>>>    
>>>> -    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
>>>> +    migrate_uri_parse(uri, &channel, &err);
>>>> +    QAPI_LIST_PREPEND(caps, channel);
>>>> +
>>>> +    qmp_migrate(NULL, true, caps, !!blk, blk, !!inc, inc,
>>>>                     false, false, true, resume, &err);
>>>> +    qapi_free_MigrationChannelList(caps);
>>>>        if (hmp_handle_error(mon, err)) {
>> Regards,
>> Het Gala
Regards,
Het Gala
--------------IytMo0nwEgqSOvb7vqpmRASV
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/9/2023 8:05 PM, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:874jizg8xv.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 10/4/2023 8:55 PM, Fabiano Rosas wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Het Gala<a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>  writes:

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Integrate MigrateChannelList with all transport backends
(socket, exec and rdma) for both src and dest migration
endpoints for hmp migration.

Suggested-by: Aravind Retnakaran<a class="moz-txt-link-rfc2396E" href="mailto:aravind.retnakaran@nutanix.com">&lt;aravind.retnakaran@nutanix.com&gt;</a>
Signed-off-by: Het Gala<a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
Reviewed-by: Daniel P. Berrangé<a class="moz-txt-link-rfc2396E" href="mailto:berrange@redhat.com">&lt;berrange@redhat.com&gt;</a>
---
  migration/migration-hmp-cmds.c | 15 +++++++++++++--
  migration/migration.c          |  5 ++---
  migration/migration.h          |  3 ++-
  3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index a2e6a5c51e..a1657f3d37 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -441,9 +441,14 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
  {
      Error *err = NULL;
      const char *uri = qdict_get_str(qdict, &quot;uri&quot;);
+    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Just the pointer here. If I remember correctly the g_autoptr here would
cause a double free when freeing the caps.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Yes, we'll just have 'g_autoptr(MigrationChannel) channel = NULL'.

Is it because inside QAPI_LIST_PREPEND, caps will be refrencing to the 
same memory as 'channel', we don't need to free channel ?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Slightly different scenario here. Here the issue is that we will free
the caps with qapi_free_MigrationChannel() before returning. Then, at
function exit the g_autoptr will try to free 'channel', which has
already been freed along with 'caps'. That's a double free, I think it
hits an assert inside glib, if I remember correctly.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">I am still not 
sure what is the right place to use g_steal_pointer(), is this a right 
place to use (non-error paths) ?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
It doesn't look like we need it here. As long as the qapi list has a
reference and we're freeing the caps, then channel should be freed by
that function already.</pre>
    </blockquote>
    Ack. Yes, with the discussion in earlier patches, I also don't think
    we need g_autoptr too here. Normal pointer is enough as we are
    freeing the memory after the function is returned.<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:874jizg8xv.fsf@suse.de">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">  
-    qmp_migrate_incoming(uri, false, NULL, &amp;err);
+    migrate_uri_parse(uri, &amp;channel, &amp;err);
+    QAPI_LIST_PREPEND(caps, channel);
  
+    qmp_migrate_incoming(NULL, true, caps, &amp;err);
+    qapi_free_MigrationChannelList(caps);
      hmp_handle_error(mon, err);
  }
  
@@ -730,9 +735,15 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
      bool resume = qdict_get_try_bool(qdict, &quot;resume&quot;, false);
      const char *uri = qdict_get_str(qdict, &quot;uri&quot;);
      Error *err = NULL;
+    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Same here. We free the channel via caps and we attribute it below, no
need to allocate.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Ack.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">  
-    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
+    migrate_uri_parse(uri, &amp;channel, &amp;err);
+    QAPI_LIST_PREPEND(caps, channel);
+
+    qmp_migrate(NULL, true, caps, !!blk, blk, !!inc, inc,
                   false, false, true, resume, &amp;err);
+    qapi_free_MigrationChannelList(caps);
      if (hmp_handle_error(mon, err)) {
</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Regards,
Het Gala</pre>
      </blockquote>
    </blockquote>
    Regards,<br>
    Het Gala<span style="white-space: pre-wrap">
</span>
  </body>
</html>

--------------IytMo0nwEgqSOvb7vqpmRASV--

