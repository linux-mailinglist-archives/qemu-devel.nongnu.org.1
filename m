Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A113805813
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 15:59:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAWso-0006Xj-0L; Tue, 05 Dec 2023 09:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rAWsl-0006XH-TE
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 09:58:44 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rAWsi-0005Hy-Bt
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 09:58:43 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 3B57OkdA022451; Tue, 5 Dec 2023 06:58:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:references:from:cc
 :in-reply-to:mime-version; s=proofpoint20171006; bh=opatGtD1fDyL
 BDFGRk9ne3YS5QlN2X2up7JyaM9xAJ8=; b=ubYh7TgooeKOXdX5Clt99ZUUxeZj
 rNmV9CHdNky+C2Cv1igUOKq4P73lXBtxzTfN+XE7WC0BOmOlc2FfYAqhnRyL/sgj
 iP8cRyfB/OWtqHYDjZUsJO3il3Poaqebw1Kv1YnTGJYXyxRKSEzfoyN1GVq1dr/F
 8hEXJrPq1sTLGPJZI7U0xK/tlfxr0AyzTs0XvzaQRNv1Rh/OrCnfafFvhSafOuz8
 em2ncZ9XXpDZaFWocXIbntIcz3Y2xOjrlx+mwgOLauk7ay24pKVkabnviJY3dYw6
 uO4n8QI7w5DdUOrOtE/PBekcXsQOY37G/he09HC47TZYnqhe78EN1D7PMg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3ur501wjtp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Dec 2023 06:58:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Or3DpBWJWhX5ai1jguBb02UDZ3MIk+jEcClVzT3fsWXXg6ysiL1cppB1FdEkJxtcYjjiSeMXwcTJ4mD3XShHmEw5AcN+XyVEMZ2CXzmyaJQs6NyRrbgl6DBV4LaqMtbRuKUqUZgbOFV8e9zwYpBr/IfdhTSwUUEiuhKgW9BrPxbZByUl5wkpS97sQkG8gGBRSP66ZmDb/R7sSCQhZ2ZqxdgJPgngpEALKlWz1vpXFj4VoX7lqSneSNsCkSVoRXdHPjQuhNGpVCvEgxA+lHOMPWy6B+WJVZ1r66KMAGHs2G+WUQatrw78qgX6pnO/7RKDP251dp2FVi6ikpiGi+/I4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opatGtD1fDyLBDFGRk9ne3YS5QlN2X2up7JyaM9xAJ8=;
 b=Wh6UlFUapUPWjoWDn939jEf87nVsXi0QhLC/zQ9f/omU37w7ess7xlzidYRcLDqF/PC7wrrcXcGNXFzyJ7kpmlLpIsaYmdmadkyTAS7fi5KjYNh3pTajJEq58E6+Nv7XVJHYRJuvO+GmSLPYRfpwrhRL5lXqthuBOBLleDIdmqgMkVpxTMuB/IrdOMc+cNS2qB8G315+1zHvDsqOFs3lxvzZC0qq3J5Ua/wIMYmKJBf3J5xNb+R39apJ/ltQzM4iwRjul4tFlTeds9aX5Ij10tVuL6K6dpfRci4JI6U+ZOHS2erfA/tAf/oYUAixmxAEIVvXUID/cmhPHREv1VdPEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opatGtD1fDyLBDFGRk9ne3YS5QlN2X2up7JyaM9xAJ8=;
 b=JxS6gwSU275tTBF5M4XqAu4AfjveLcfFgynDNI6w0dyaTGkEfIcR3TaJ6Wocy+3wldFEnPAQY5C0MHyJAU+QQ1w283FApZKSQ8FHYcNkDetEgKgty1NY86Ns0Hn+r/qLhLSKbawKK/Yj7qmlj7nhYLOpUdQnAvCe/cjr9PI5Wy104UJWAsURMIczfw9JK0b7juABMGQfrbZAMMaJWTk3N2Lmnv2n1hMBfgBsWiI7PuX0XXHhLft2ZQcpwtCiJL8qMAVpl8MHo/hyTn20EqITp9NtEpx7FrQl0TIh4UxYP+iRvq2Uw1T3J9Di9ACQg3QlIOfnk7Aqum0+qHleIaffyQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by IA0PR02MB9584.namprd02.prod.outlook.com (2603:10b6:208:406::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 14:58:34 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5%2]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 14:58:33 +0000
Content-Type: multipart/alternative;
 boundary="------------PS0Q3P4Qqk87XwyxZ7fXDfHu"
Message-ID: <a5e74e0e-48b6-40ef-9bd3-778936427e94@nutanix.com>
Date: Tue, 5 Dec 2023 20:28:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU developers fortnightly conference call for agenda for
 2023-12-12
Content-Language: en-US
To: Juan Quintela <juan.quintela@gmail.com>
References: <calendar-98548e19-3517-40fa-a2ae-1c384aa3f98f@google.com>
From: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org
In-Reply-To: <calendar-98548e19-3517-40fa-a2ae-1c384aa3f98f@google.com>
X-ClientProxiedBy: MA1PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::15) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|IA0PR02MB9584:EE_
X-MS-Office365-Filtering-Correlation-Id: dab32652-95bc-49f2-5b19-08dbf5a2a6a8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xOTEx6DsKdyBOZme3aO9zVM4nTY78heT5EER/3o7FcfsJrunyti2x1Lt9tz/DJdG4/J3cUjRNDoWTQBaI6MFe4EP0Q0DYGRQ7LaFPTqrJHKZSGdoKVt2ya3+6d7uFvxLC5beXOKTb6eTWs5L8Dw4yxEoNZqPRPvqqq+6O420bly0uJb9+mlaiCX3NGTnpwS6H0uM88bIyUs2u6O9E9iFHYP5sgiSGOK00/+msu9o7ZxEmoZLMZKb3peK8oJSErLZUpx6C8t3rHt1kQJ0BfgANtteoi0ZSOULRvKF62zocxX+cckEVCyOmvQnA439uWh1nXNEIw4xdTj1jOhTBGJ+/gyJYsEsj1T4cLISuC4q3XTSozSQjZW1Ws19okPTNI5qzbArX4c60b1mybpCftD3Fo0Ev9/88dq6aO0wg4fILww6iyNz+281ZomhcUlkEU2UPD6rLoeoywU8grORlyxC2ryZuTuJlSiqgwYgbWPFVR7YRURbFirRFQsQcwPz4ULagDP064VzU+hL2vDOE3oMwdcuGw1UTq8nbG3F4O4cDNx7RjGhWHttDGcaZ4gAvI6CuK9f+L3my4jmBmaOdW9FeMpPtuk2TcNRKdHmX4mz4eh4FebiiFSmO3al4VSPQ1pydVl/fGwjDtOncre55ralXlcbVLTKpktp+x1YQABc01D3mcTA5MNzcQq613LElWW1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39860400002)(230173577357003)(230273577357003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(19627405001)(31686004)(478600001)(6512007)(33964004)(53546011)(6506007)(8936002)(2616005)(966005)(6486002)(6666004)(26005)(6916009)(66476007)(66556008)(4326008)(8676002)(66946007)(316002)(83380400001)(38100700002)(36756003)(166002)(44832011)(21615005)(2906002)(5660300002)(4001150100001)(86362001)(31696002)(41300700001)(45980500001)(43740500002)(579004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGJCUVRrSXVBTXFDb2dWTW9FeWlBaUZUa2RudmcxZXBWNXZ3UzZ3QjZTRkRh?=
 =?utf-8?B?RWZTdFZaYUdmK1BlMyt3aHpJeG4xWWVzVnNGem43dldUZ2RnbG1zOHhwNi9a?=
 =?utf-8?B?RXVjanVWTTFQR0VLZm1adEMzZzRBWlQxckQrSmFNRzY3b3Q4N0VGN1pPYmph?=
 =?utf-8?B?WUVaN1JvbDUycVNOL2pzejRvSmduR1hHYmU4RWNFTXJCeU5XR1RIbktqdVBY?=
 =?utf-8?B?a3RwYmZsbWEzdkFmQVRZeVhwRlJuWmZRNUx4YkJHTTJjTGQxMVVPRC94ZFpm?=
 =?utf-8?B?T2Mvb2Mvd3lCTVZpOGh1ODlHME41MENFODdWREczNEtRUnBBWVVyRHpmN1FO?=
 =?utf-8?B?SEk0QzNGV3Jqbm9VU1Bha3JaQ3Y4MEZ2eHRnU3JHeVZ4TExHZHdXVStGNjFn?=
 =?utf-8?B?K0dQK3JHOE84TUVkUWhkSTZYMkJRZEVXSDhZdE9mdzRmejk2WUhobzlmL1BU?=
 =?utf-8?B?eUtGK1pYT2ZxSFZpdnVuVGlYdFlWT2tKRFhMMyt6VkQ0cDYzMlhKaElHUmpk?=
 =?utf-8?B?UEM0MXRoUHg0eU5ZR0xEdkpLamVDc214N3hWWG1HTzVxS2lpUCtIMG1Yd1JT?=
 =?utf-8?B?WWx2dSszNkp5VWowdHpmZ0ZlVW9ObjNNVUQxWlFhQ0FMdWFiZExWTXhsUkxh?=
 =?utf-8?B?SUtaQnZjZVRTY2U3LzR4TEVjdGZZVmdDWm43NlhQamdaYnF4VXo4OFNFbjBY?=
 =?utf-8?B?Wkhqam0zSTdlTW9PdW5YKzhIYUdmYjFDQzRtZFQrMXZwb2hVSHNqNmlXTk5s?=
 =?utf-8?B?QWdES0grWTN6TmpOM3I5MzdCSmRIVzNDWkNUTVA2YnUrQ1loZDVXZmhyZU1i?=
 =?utf-8?B?NnU0MnRrTWdDTjFGVXVqUkNtc0MvNmF1V3BUL1dXTW1zbkJucVB2eEl3Zjls?=
 =?utf-8?B?UmtGTGZFL3JNWkZKWE14bEx0QXp5a2wzRlJWRzYvbDJiWWFnWEdIVkFTY2tZ?=
 =?utf-8?B?VlFrQ3d5cStWcmtuOFVKYVlvdmU0alBiK1JhT08rNTl6TWV3eGo4YnNYZjhT?=
 =?utf-8?B?ZWNtcU9xVjlHUFFQSkdnSEwrWFZEMFBDcTkzazlrOUl5M1hRL25Sb1krRkJW?=
 =?utf-8?B?eWtkQmF1MEE1ZUFrSVAyVUlHUWhiMkplRXRua256eXRiZ1RteldsWnZmMStz?=
 =?utf-8?B?aDYrQmZvQkdPZGw3OE51RVZPVmNpdmdYZEhKbTRXcnR6Nkp0a2FqcXg3WXhH?=
 =?utf-8?B?YU1tdDdUbGtTR3lSVGk2TmFxdGlSRHA3WHRBWUljYk1MVmRnUVhrdXNFb0Zt?=
 =?utf-8?B?Q0VHTW5aOU9KVUEvYmpPc2xuUTl3L2x6OVBjSkxvS1RPUkgxc3NPWnJuaUZS?=
 =?utf-8?B?eExaaVFYTTdmYkFreks0YnZiTWROQlEyRjUzYjhhRlA4TkZ0WllrMUVDdUIr?=
 =?utf-8?B?YlhGVjYyTGJqU3BqVzMyU0JCelVmOUsyK21yR3E2WGNKeENpSU5QMUNSNDFZ?=
 =?utf-8?B?SFd1YUtlcGJ1MEV6RklVTU5MbHMxK3NzL2ZYMDlmZXE5aVgycnBhUlhvOUZJ?=
 =?utf-8?B?eUphc0xDTjNKbzh2dERRTDd2amJKMUh5cndDdXJJQVFYb2UvbzlwRUJqM1VW?=
 =?utf-8?B?SlhwdkxKRzI1Nm5OVG54UW1tbXB3Rkg4SEcwZklZRHN1TVRqUGNNU04wbnZM?=
 =?utf-8?B?SmtjcUYzaVY3bk1CQy9EdXVwVHlKeHV6REpVd1JnLzhEYm1YMVZPL2dudkxP?=
 =?utf-8?B?ZERzNTQzYWFHejRkTk5WUUNpYmxiSTF5WUtjdWJyaWViMzRMR3VwMDUrRUIr?=
 =?utf-8?B?MFBlMUdQYm54YVJ0VU9XV0RvL0FaWk9UUWVwemM2WE1XYjNhSnZjN1plSzdW?=
 =?utf-8?B?SkdydytnQ0p4dE5NLzFRcnh6WmswMUhDR1lhZ0RGZ0JnbFNmSHBMbiswcXk1?=
 =?utf-8?B?M29ra3Rod2t6dG4zZHFqalc4dG1rOXVXUXk1cGs2K2d5MVZ4Y3J4MnY2allw?=
 =?utf-8?B?Z3QzY2UxZ0tqeHNKMkkxaklaU21JYjYvNkQ3MldocUZGcStTVy92RVRqeFF4?=
 =?utf-8?B?TlY0UmpwSDJpUThjL0RTS20rZWpkd0FLbTRtcEJ4eWg1ZWhJMFFaRU84UW5E?=
 =?utf-8?B?bW5iUlNVc1VuS1crWWZQeFRLSHp1Z2FkRFUxRlNTWndUNEdROExzclhaMXNU?=
 =?utf-8?Q?1CwWdhEYmjHZcBusGD93w9qsq?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab32652-95bc-49f2-5b19-08dbf5a2a6a8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 14:58:33.6481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qQauaONEiVtG7WUOHco1tZqdwTKzK+nHZoRXpkBB2IXPckY9JySGQRIr1HxlMV7655u4niglWp71ka7dT3SGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9584
X-Proofpoint-GUID: _-oYQImIp5ijg2-Af3Cb-oISE3a9LDvs
X-Proofpoint-ORIG-GUID: _-oYQImIp5ijg2-Af3Cb-oISE3a9LDvs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_27,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--------------PS0Q3P4Qqk87XwyxZ7fXDfHu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I wanted to know - plans for the project of "Configuration migration" 
ref : https://lists.gnu.org/archive/html/qemu-devel/2023-11/msg00488.html.

Reason being, I am planning to soon post 2nd patchset series for 'adding 
multiple interface on top of multifd' - which would cover the addition 
of multiple destination interfaces, along with number of multifd 
channels parameter per interface inside 'migrate' QAPI. This is along 
the lines what we have been discussing under "Configuration migration", 
so it would be great to hear, how we intend to modify the architecture 
in near future.

Thanks,

Het Gala

On 05/12/23 7:17 pm, Juan Quintela wrote:
> QEMU developers fortnightly conference call
>
> Hi
> If you have any topics for the last qemu conference call of the year, 
> feel free to answer to this email.
>
> Later, Juan.
>
> QEMU developers fortnightly conference call
> Tuesday 2023-12-12 ⋅ 15:00 – 16:00 (Central European Time - Madrid)
> If you need call details, please contact me: quintela@redhat.com
>
>
>     Location
>
> https://meet.jit.si/kvmcallmeeting
> View map 
> <https://www.google.com/url?q=https%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&sa=D&ust=1702216020000000&usg=AOvVaw1xrpPSmMRu9niy1trqCKrA>
>
>
>     Guests
>
> Philippe Mathieu-Daudé <mailto:f4bug@amsat.org>
> Joao Martins <mailto:joao.m.martins@oracle.com>
> quintela@redhat.com <mailto:quintela@redhat.com>
> mdean@redhat.com <mailto:mdean@redhat.com>
> felipe@nutanix.com <mailto:felipe@nutanix.com>
> afaerber@suse.de <mailto:afaerber@suse.de>
> bbauman@redhat.com <mailto:bbauman@redhat.com>
> cw@f00f.org <mailto:cw@f00f.org>
> eblake@redhat.com <mailto:eblake@redhat.com>
> edgar.iglesias@gmail.com <mailto:edgar.iglesias@gmail.com>
> eric.auger@redhat.com <mailto:eric.auger@redhat.com>
> iggy@theiggy.com <mailto:iggy@theiggy.com>
> jan.kiszka@web.de <mailto:jan.kiszka@web.de>
> jidong.xiao@gmail.com <mailto:jidong.xiao@gmail.com>
> jjherne@linux.vnet.ibm.com <mailto:jjherne@linux.vnet.ibm.com>
> mimu@linux.vnet.ibm.com <mailto:mimu@linux.vnet.ibm.com>
> peter.maydell@linaro.org <mailto:peter.maydell@linaro.org>
> richard.henderson@linaro.org <mailto:richard.henderson@linaro.org>
> stefanha@gmail.com <mailto:stefanha@gmail.com>
> imp@bsdimp.com <mailto:imp@bsdimp.com>
> z.huo@139.com <mailto:z.huo@139.com>
> zwu.kernel@gmail.com <mailto:zwu.kernel@gmail.com>
> jgg@nvidia.com <mailto:jgg@nvidia.com>
> cjia@nvidia.com <mailto:cjia@nvidia.com>
> Elena Ufimtseva <mailto:elena.ufimtseva@oracle.com>
> konrad.wilk@oracle.com <mailto:konrad.wilk@oracle.com>
> ale@rev.ng <mailto:ale@rev.ng>
> anjo@rev.ng <mailto:anjo@rev.ng>
> Shameerali Kolothum Thodi <mailto:shameerali.kolothum.thodi@huawei.com>
> wei.w.wang@intel.com <mailto:wei.w.wang@intel.com>
> Chao Peng <mailto:chao.p.peng@linux.intel.com>
> qemu-devel@nongnu.org <mailto:qemu-devel@nongnu.org>
> mburton@qti.qualcomm.com <mailto:mburton@qti.qualcomm.com>
>
--------------PS0Q3P4Qqk87XwyxZ7fXDfHu
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi,</p>
    <p>I wanted to know - plans for the project of &quot;Configuration
      migration&quot; ref :
      <a class="moz-txt-link-freetext" href="https://lists.gnu.org/archive/html/qemu-devel/2023-11/msg00488.html">https://lists.gnu.org/archive/html/qemu-devel/2023-11/msg00488.html</a>.&nbsp;</p>
    <p>Reason being, I am planning to soon post 2nd patchset series for
      'adding multiple interface on top of multifd' - which would cover
      the addition of multiple destination interfaces, along with number
      of multifd channels parameter per interface inside 'migrate' QAPI.
      This is along the lines what we have been discussing under
      &quot;Configuration migration&quot;, so it would be great to hear, how we
      intend to modify the architecture in near future.</p>
    <p>Thanks,</p>
    <p>Het Gala <br>
    </p>
    <div class="moz-cite-prefix">On 05/12/23 7:17 pm, Juan Quintela
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:calendar-98548e19-3517-40fa-a2ae-1c384aa3f98f@google.com">
      <title></title>
      <!--[if !mso]><meta http-equiv="X-UA-Compatible" content="IE=edge"><![endif]-->
      
      <meta name="viewport" content="width=device-width,initial-scale=1">
      <meta name="color-scheme" content="light dark">
      <meta name="supported-color-schemes" content="light dark">
      <style>body, html {
        font-family: Roboto, Helvetica, Arial, sans-serif;
      }body {
        margin: 0;
        padding: 0;
        -webkit-font-smoothing: antialiased;
        -webkit-text-size-adjust: 100%;
        -ms-text-size-adjust: 100%;
      }#outlook a {
        padding: 0;
      }.ReadMsgBody {
        width: 100%;
      }.ExternalClass {
        width: 100%;
      }.ExternalClass * {
        line-height: 100%;
      }table,
      td {
        mso-table-lspace: 0pt;
        mso-table-rspace: 0pt;
      }img {
        border: 0;
        height: auto;
        line-height: 100%;
        outline: none;
        text-decoration: none;
        -ms-interpolation-mode: bicubic;
      }p {
        display: block;
        margin: 13px 0;
      }</style>
      <!--[if !mso]><!-->
      <style></style>
      <!--<![endif]-->
      <!--[if mso]>
          <xml>
          <o:OfficeDocumentSettings>
            <o:AllowPNG/>
            <o:PixelsPerInch>96</o:PixelsPerInch>
          </o:OfficeDocumentSettings>
          </xml>
          <![endif]-->
      <!--[if lte mso 11]>
          <style>
            .outlook-group-fix { width:100% !important; }
          </style>
    <![endif]-->
      <!--[if !mso]><!-- -->
      <style>body, html {font-family:Roboto,Helvetica,Arial,sans-serif;}@font-face {
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/roboto/v18/KFOmCnqEu92Fr1Mu4mxP.ttf) format('truetype');
}@font-face {
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 500;
  src: url(//fonts.gstatic.com/s/roboto/v18/KFOlCnqEu92Fr1MmEU9fBBc9.ttf) format('truetype');
}@font-face {
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  src: url(//fonts.gstatic.com/s/roboto/v18/KFOlCnqEu92Fr1MmWUlfBBc9.ttf) format('truetype');
}@font-face {
  font-family: 'Material Icons Extended';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/materialiconsextended/v149/kJEjBvgX7BgnkSrUwT8UnLVc38YydejYY-oE_LvM.ttf) format('truetype');
}@font-face {
  font-family: 'Google Material Icons';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/googlematerialicons/v137/Gw6kwdfw6UnXLJCcmafZyFRXb3BL9rvi0QZG3g.otf) format('opentype');
}.google-material-icons {
  font-family: 'Google Material Icons';
  font-weight: normal;
  font-style: normal;
  font-size: 24px;
  line-height: 1;
  letter-spacing: normal;
  text-transform: none;
  display: inline-block;
  white-space: nowrap;
  word-wrap: normal;
  direction: ltr;
}@font-face {
  font-family: 'Google Material Icons Filled';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/googlematerialiconsfilled/v113/WWXFlimHYg6HKI3TavMkbKdhBmDvgach8TVpeGsuueSZJH4.otf) format('opentype');
}.google-material-icons-filled {
  font-family: 'Google Material Icons Filled';
  font-weight: normal;
  font-style: normal;
  font-size: 24px;
  line-height: 1;
  letter-spacing: normal;
  text-transform: none;
  display: inline-block;
  white-space: nowrap;
  word-wrap: normal;
  direction: ltr;
}@font-face {
  font-family: 'Google Sans';
  font-style: normal;
  font-weight: 400;
  src: url(//fonts.gstatic.com/s/googlesans/v14/4UaGrENHsxJlGDuGo1OIlL3Owps.ttf) format('truetype');
}@font-face {
  font-family: 'Google Sans';
  font-style: normal;
  font-weight: 500;
  src: url(//fonts.gstatic.com/s/googlesans/v14/4UabrENHsxJlGDuGo1OIlLU94YtzCwM.ttf) format('truetype');
}@font-face {
  font-family: 'Google Sans';
  font-style: normal;
  font-weight: 700;
  src: url(//fonts.gstatic.com/s/googlesans/v14/4UabrENHsxJlGDuGo1OIlLV154tzCwM.ttf) format('truetype');
}</style><!--<![endif]-->
      <style>.body-container {
          padding-left: 16px;
          padding-right: 16px;
        }</style>
      <style>u+.body .body-container,
        body[data-outlook-cycle] .body-container,
        #MessageViewBody .body-container {
          padding-left: 0;
          padding-right: 0;
        }</style>
      <style></style>
      <style>.appointment-buttons th {
        display: block;
        clear: both;
        float: left;
        margin-top: 12px;
      }.appointment-buttons th a {
        float: left;
      }#MessageViewBody .appointment-buttons th {
       margin-top: 24px;
      }</style>
      <style></style>
      <style>.main-container-inner,
      .info-bar-inner {
        padding: 12px 16px !important;
      }.main-column-table-ltr {
        padding-right: 0 !important;
      }.main-column-table-rtl {
        padding-left: 0 !important;
      }.primary-text {
        color: #3c4043 !important;
      }.secondary-text,
      .phone-number a {
        color: #70757a !important;
      }.accent-text {
        color: #1a73e8 !important;
      }.accent-text-dark {
        color: #185abc !important;
      }.grey-button-text,
      .attachment-chip a {
        color: #5f6368 !important;
      }.primary-button {
        background-color: #1a73e8 !important;
      }.primary-button-text {
        color: #fff !important;
      }.underline-on-hover:hover {
        text-decoration: underline !important;
      }.grey-infobar-text {
        color: #202124 !important;
      }</style>
      <style></style>
      <!--[if !mso]><!-->
      <style>.prevent-link a {
        color: inherit !important;
        text-decoration: none !important;
        font-size: inherit !important;
        font-family: inherit !important;
        font-weight: inherit !important;
        line-height: inherit !important;
      }</style>
      <!--<![endif]-->
      <!--[if mso | IE]>
      <style>
        .main-container-inner {
          padding: 24px 32px !important;
        }

        .info-bar-inner {
          padding: 12px 32px !important;
        }

        .cse-banner .encryption-icon {
          /* We use the IE workaround instead. */
          background-image: none !important;
        }

        .cse-banner .encryption-icon .ms-fallback {
          display: block !important;
        }

        /* NB: Some MS clients ignore dark-scheme styling and apply their own, so there's nothing we can do to help there. */
        @media (prefers-color-scheme: dark) {
          .cse-banner:not([class^="x_"]) .encryption-icon .ms-fallback {
            display: none !important;
          }

          .cse-banner:not([class^="x_"]) .encryption-icon .ms-fallback-dark {
            display: block !important;
          }
        }
      </style>
    <![endif]--> <span itemscope="" itemtype="http://schema.org/InformAction"><span style="display:none" itemprop="about" itemscope="" itemtype="http://schema.org/EmailMessage">
          <meta itemprop="description" content="Juan Quintela: Hi If you have any topics for the last qemu conference call of the year, feel free to answer to this email. Later, Juan.">
        </span><span itemprop="object" itemscope="" itemtype="http://schema.org/Event">
          <meta itemprop="eventStatus" content="http://schema.org/EventScheduled">
          <span itemprop="publisher" itemscope="" itemtype="http://schema.org/Organization">
            <meta itemprop="name" content="Google Calendar">
          </span>
          <meta itemprop="eventId/googleCalendar" content="5dt5ji87j5qrc00o63ktq7ghou_20231212T140000Z">
          <span style="display: none; font-size: 1px; color: #fff; line-height: 1px; height: 0; max-height: 0; width: 0; max-width: 0; opacity: 0; overflow: hidden;" itemprop="name">QEMU developers fortnightly conference call</span><span aria-hidden="true"><time itemprop="startDate" datetime="20231212T140000Z"></time><time itemprop="endDate" datetime="20231212T150000Z"></time></span>
          <table role="presentation" style="width:100%;" class="body-container" cellspacing="0" cellpadding="0" border="0" align="center">
            <tbody>
              <tr>
                <td style="" class="" align="left"><!--[if mso | IE]><table border="0" cellpadding="0" cellspacing="0" role="presentation"><tr><td height="16" style="height:16px;"><![endif]-->
                  <div style="height:16px;" aria-hidden="true"> &nbsp; </div>
                  <!--[if mso | IE]></td></tr></table><![endif]-->
                  <table role="presentation" style="width:100%;" class="" cellspacing="0" cellpadding="0" border="0" align="center">
                    <tbody>
                      <tr>
                        <td style="" class="" align="left"><span itemscope="" itemtype="http://schema.org/EmailMessage">
                            <p itemprop="description">Hi<br>
                              If you have any topics for the last qemu
                              conference call of the year, feel free to
                              answer to this email.</p>
                            <p>Later, Juan.</p>
                          </span></td>
                      </tr>
                    </tbody>
                  </table>
                  <table role="presentation" style="width:100%;" class="" cellspacing="0" cellpadding="0" border="0" align="center">
                    <tbody>
                      <tr>
                        <td style="border: solid 1px #dadce0; border-radius: 8px; direction: rtl; font-size: 0; padding: 24px 32px; text-align: left; vertical-align: top;" class="main-container-inner"><!--[if mso | IE]><table border="0" cellpadding="0" cellspacing="0" role="presentation"><tr><![endif]-->
                          <div class="" style="font-size: 13px; text-align: left; direction: ltr; display: inline-block; vertical-align: top; width: 100%;overflow: hidden; word-wrap: break-word;">
                            <table role="presentation" class="main-column-table-ltr" style="padding-right: 32px; padding-left: 0;;table-layout: fixed;" width="100%" cellspacing="0" cellpadding="0" border="0">
                              <tbody>
                                <tr>
                                  <td class="main-column-td" style="padding:0; vertical-align:top;">
                                    <table role="presentation" style="table-layout: fixed;" width="100%" cellspacing="0" cellpadding="0" border="0">
                                      <tbody>
                                        <tr>
                                          <td style="font-size: 0; padding: 0; text-align: left; word-break: break-word;;padding-bottom:2px;">
                                            <div style="font-family: 'Google Sans', Roboto, sans-serif;font-weight: 400; font-size: 22px; line-height: 28px;color: #3c4043; text-decoration: none;" class="primary-text" role="presentation"><span itemprop="name">QEMU
                                                developers fortnightly
                                                conference call</span></div>
                                          </td>
                                        </tr>
                                        <tr>
                                          <td style="font-size: 0; padding: 0; text-align: left; word-break: break-word;;padding-bottom:24px;">
                                            <div style="font-family: Roboto, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" class="primary-text" role="presentation"><span aria-hidden="true"><time itemprop="startDate" datetime="20231212T140000Z"></time><time itemprop="endDate" datetime="20231212T150000Z"></time></span><span>Tuesday 2023-12-12 ⋅
                                                15:00 – 16:00 (Central
                                                European Time - Madrid)</span></div>
                                          </td>
                                        </tr>
                                        <tr>
                                          <td style="font-size: 0; padding: 0; text-align: left; word-break: break-word;;padding-bottom:24px;">
                                            <div style="font-family: Roboto, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" class="primary-text" role="presentation"><span>If
                                                you need call details,
                                                please contact me: <a href="mailto:quintela@redhat.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">quintela@redhat.com</a></span>
                                              <meta itemprop="description" content="If you need call details, please contact me: quintela@redhat.com">
                                            </div>
                                          </td>
                                        </tr>
                                        <tr>
                                          <td style="font-size: 0; padding: 0; text-align: left; word-break: break-word;;padding-bottom:24px;">
                                            <div style="font-family: Roboto, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" class="primary-text" role="presentation">
                                              <table role="presentation" style="padding-bottom: 4px;" cellspacing="0" cellpadding="0" border="0">
                                                <tbody>
                                                  <tr>
                                                    <td>
                                                      <h2 class="primary-text" style="font-size: 14px;color: #3c4043; text-decoration: none;font-weight: 700;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">Location</h2>
                                                    </td>
                                                  </tr>
                                                </tbody>
                                              </table>
                                              <span itemprop="location" itemscope="" itemtype="http://schema.org/Place"><span itemprop="name" class="primary-text notranslate" style="font-family: Roboto, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;"><a class="moz-txt-link-freetext" href="https://meet.jit.si/kvmcallmeeting">https://meet.jit.si/kvmcallmeeting</a></span><br>
                                                <a href="https://www.google.com/url?q=https%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&amp;sa=D&amp;ust=1702216020000000&amp;usg=AOvVaw1xrpPSmMRu9niy1trqCKrA" class="accent-text underline-on-hover" style="display: inline-block;;color: #1a73e8; text-decoration: none;font-weight: 700;" target="_blank" itemprop="map" moz-do-not-send="true">View
                                                  map</a></span></div>
                                          </td>
                                        </tr>
                                        <tr>
                                          <td style="font-size: 0; padding: 0; text-align: left; word-break: break-word;;padding-bottom:24px;">
                                            <div style="font-family: Roboto, sans-serif;font-style: normal; font-weight: 400; font-size: 14px; line-height: 20px; letter-spacing: 0.2px;color: #3c4043; text-decoration: none;" class="primary-text" role="presentation">
                                              <table role="presentation" style="padding-bottom: 4px;" cellspacing="0" cellpadding="0" border="0">
                                                <tbody>
                                                  <tr>
                                                    <td>
                                                      <h2 class="primary-text" style="font-size: 14px;color: #3c4043; text-decoration: none;font-weight: 700;-webkit-font-smoothing: antialiased;margin: 0; padding: 0;">Guests</h2>
                                                    </td>
                                                  </tr>
                                                </tbody>
                                              </table>
                                              <div style="padding-bottom: 4px; text-align: left;;color: #3c4042;">
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:f4bug@amsat.org" moz-do-not-send="true">Philippe
                                                        Mathieu-Daudé</a></span>
                                                    <meta itemprop="email" content="f4bug@amsat.org">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:joao.m.martins@oracle.com" moz-do-not-send="true">Joao
                                                        Martins</a></span>
                                                    <meta itemprop="email" content="joao.m.martins@oracle.com">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:quintela@redhat.com" moz-do-not-send="true">quintela@redhat.com</a></span>
                                                    <meta itemprop="email" content="quintela@redhat.com">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:mdean@redhat.com" moz-do-not-send="true">mdean@redhat.com</a></span>
                                                    <meta itemprop="email" content="mdean@redhat.com">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:felipe@nutanix.com" moz-do-not-send="true">felipe@nutanix.com</a></span>
                                                    <meta itemprop="email" content="felipe@nutanix.com">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:afaerber@suse.de" moz-do-not-send="true">afaerber@suse.de</a></span>
                                                    <meta itemprop="email" content="afaerber@suse.de">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:bbauman@redhat.com" moz-do-not-send="true">bbauman@redhat.com</a></span>
                                                    <meta itemprop="email" content="bbauman@redhat.com">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:cw@f00f.org" moz-do-not-send="true">cw@f00f.org</a></span>
                                                    <meta itemprop="email" content="cw@f00f.org">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:eblake@redhat.com" moz-do-not-send="true">eblake@redhat.com</a></span>
                                                    <meta itemprop="email" content="eblake@redhat.com">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:edgar.iglesias@gmail.com" moz-do-not-send="true">edgar.iglesias@gmail.com</a></span>
                                                    <meta itemprop="email" content="edgar.iglesias@gmail.com">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:eric.auger@redhat.com" moz-do-not-send="true">eric.auger@redhat.com</a></span>
                                                    <meta itemprop="email" content="eric.auger@redhat.com">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:iggy@theiggy.com" moz-do-not-send="true">iggy@theiggy.com</a></span>
                                                    <meta itemprop="email" content="iggy@theiggy.com">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:jan.kiszka@web.de" moz-do-not-send="true">jan.kiszka@web.de</a></span>
                                                    <meta itemprop="email" content="jan.kiszka@web.de">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:jidong.xiao@gmail.com" moz-do-not-send="true">jidong.xiao@gmail.com</a></span>
                                                    <meta itemprop="email" content="jidong.xiao@gmail.com">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:jjherne@linux.vnet.ibm.com" moz-do-not-send="true">jjherne@linux.vnet.ibm.com</a></span>
                                                    <meta itemprop="email" content="jjherne@linux.vnet.ibm.com">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:mimu@linux.vnet.ibm.com" moz-do-not-send="true">mimu@linux.vnet.ibm.com</a></span>
                                                    <meta itemprop="email" content="mimu@linux.vnet.ibm.com">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:peter.maydell@linaro.org" moz-do-not-send="true">peter.maydell@linaro.org</a></span>
                                                    <meta itemprop="email" content="peter.maydell@linaro.org">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:richard.henderson@linaro.org" moz-do-not-send="true">richard.henderson@linaro.org</a></span>
                                                    <meta itemprop="email" content="richard.henderson@linaro.org">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:stefanha@gmail.com" moz-do-not-send="true">stefanha@gmail.com</a></span>
                                                    <meta itemprop="email" content="stefanha@gmail.com">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:imp@bsdimp.com" moz-do-not-send="true">imp@bsdimp.com</a></span>
                                                    <meta itemprop="email" content="imp@bsdimp.com">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:z.huo@139.com" moz-do-not-send="true">z.huo@139.com</a></span>
                                                    <meta itemprop="email" content="z.huo@139.com">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:zwu.kernel@gmail.com" moz-do-not-send="true">zwu.kernel@gmail.com</a></span>
                                                    <meta itemprop="email" content="zwu.kernel@gmail.com">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:jgg@nvidia.com" moz-do-not-send="true">jgg@nvidia.com</a></span>
                                                    <meta itemprop="email" content="jgg@nvidia.com">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:cjia@nvidia.com" moz-do-not-send="true">cjia@nvidia.com</a></span>
                                                    <meta itemprop="email" content="cjia@nvidia.com">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:elena.ufimtseva@oracle.com" moz-do-not-send="true">Elena
                                                        Ufimtseva</a></span>
                                                    <meta itemprop="email" content="elena.ufimtseva@oracle.com">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:konrad.wilk@oracle.com" moz-do-not-send="true">konrad.wilk@oracle.com</a></span>
                                                    <meta itemprop="email" content="konrad.wilk@oracle.com">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:ale@rev.ng" moz-do-not-send="true">ale@rev.ng</a></span>
                                                    <meta itemprop="email" content="ale@rev.ng">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:anjo@rev.ng" moz-do-not-send="true">anjo@rev.ng</a></span>
                                                    <meta itemprop="email" content="anjo@rev.ng">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:shameerali.kolothum.thodi@huawei.com" moz-do-not-send="true">Shameerali Kolothum Thodi</a></span>
                                                    <meta itemprop="email" content="shameerali.kolothum.thodi@huawei.com">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:wei.w.wang@intel.com" moz-do-not-send="true">wei.w.wang@intel.com</a></span>
                                                    <meta itemprop="email" content="wei.w.wang@intel.com">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:chao.p.peng@linux.intel.com" moz-do-not-send="true">Chao
                                                        Peng</a></span>
                                                    <meta itemprop="email" content="chao.p.peng@linux.intel.com">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:qemu-devel@nongnu.org" moz-do-not-send="true">qemu-devel@nongnu.org</a></span>
                                                    <meta itemprop="email" content="qemu-devel@nongnu.org">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                                <div><span itemprop="attendee" itemscope="" itemtype="http://schema.org/Person"><span itemprop="name" class="notranslate"><a class="primary-text underline-on-hover moz-txt-link-freetext" style="display: inline-block;;color: #3c4043; text-decoration: none;" href="mailto:mburton@qti.qualcomm.com" moz-do-not-send="true">mburton@qti.qualcomm.com</a></span>
                                                    <meta itemprop="email" content="mburton@qti.qualcomm.com">
                                                  </span><span class="secondary-text" style="color: #70757a; text-decoration: none;"></span></div>
                                              </div>
                                            </div>
                                          </td>
                                        </tr>
                                      </tbody>
                                    </table>
                                  </td>
                                </tr>
                              </tbody>
                            </table>
                          </div>
                          <!--[if mso | IE]></tr></table><![endif]--></td>
                      </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
            </tbody>
          </table>
        </span></span>
    </blockquote>
  </body>
</html>

--------------PS0Q3P4Qqk87XwyxZ7fXDfHu--

