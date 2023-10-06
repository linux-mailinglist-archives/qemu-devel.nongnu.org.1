Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 483367BBC93
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 18:19:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qonWZ-0007IW-KO; Fri, 06 Oct 2023 12:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qonWS-0007GS-MA
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 12:17:52 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qonWN-0004Og-JK
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 12:17:50 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 396B7C4e018259; Fri, 6 Oct 2023 09:17:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=w5WCxj63JkbC
 IVj8/Nx8NftK4o3M0QHRiZtWQFOEhXE=; b=rK7CUiGwJsl3G4r5fAnKw9kRP+uQ
 PrZthBsMibOFLG51WRBbn3mMEqYYYV3p8H9ZiQmgUvkzEGifz5RgQK7FbDwDrKkt
 tRgdI7tXqajHd5YTYDbKKM59i87nMcZ1FdYieti4ADJY+yViGJVxTXKjSLc28b2X
 0xZ6CEtxJs5JQWTeeXZYY7+HravTJIsrYAatC8Ax+2Z4dc4bWGyxH1s4uMDd68xG
 QKJ/XeQZomeQ2/CCsM5m7ZljtKI3/2Fd8N03Jdo3knItaZs2VLzydQNw1ZUknp/g
 GBhFe6jxJywJrL77jRfEhA0jc1Qy3xsKTU9wKLwhBzj/HlxYM8oPrab/qg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tek6xe7y5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Oct 2023 09:17:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hR5Y74p4DbN5K7hu+YiyWGe2HfyaROwZtu87RYu0o+hj1Gc2QF1fiEsF0y8ZcgSb3kWj6wRqtz0nbpIYrnD6cR75QeXau725jT+uYG/Rsdycs32Iwuq7S/Guj7FrZPTfyM7ugpiCZp+DUhseCVEDosUTQO4zoMSQYiv8ZI90ymC7XPbAFZnorngNjoCbNGHP6Rtyq5xk5sns906/rRUQUANd2aJnOLoBSmOT59Onq7qJ7uIKFl8X0sHw722OoL48fJ+RAX9wElYX1d1g0c6plhP8YJ264uwMMj4NLjZmn9EdY12fZag8Uk6w1XJgelwwJ24qI9ygbJxTmCP3HqXMvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5WCxj63JkbCIVj8/Nx8NftK4o3M0QHRiZtWQFOEhXE=;
 b=nJbzbEpFYy7rcjJxiRNikpkdDkZRJucUvR4RdIkZTzFwESnsu2WxKLgub5whLvqdDiOo+XEr/a6afkC0vVlwhtHOOhjNsRfISN2AJYNdBEVrupdN1q1tpexgl/FjI16UoSVNrL9DYPMaCA3ZWQnN0eegNSF5C/eOJmYZP6J6mgktByPpLAwx0wprTafR+q9B7E346zZqMfm+uHUuFD8qmZ03YuByr+p+gbD5VkSKQBQYboLOasjTcnIbfcExlwSMtDznR4S5Cb+YF/TsvKwCw5xDwVlxikxyg80y0wMo4SeMcnEOmNc92vlj1fjbwZKuG2MpcQUE1P0z+/X2kgaVvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5WCxj63JkbCIVj8/Nx8NftK4o3M0QHRiZtWQFOEhXE=;
 b=qI5uSFBG4dROWj2W5A8qLAIP6yxJpTpM2lLgP8e/y/5Dqx0C3ZMA0NLp7zVoEjJWzRDwnIK1l3dmwPiX5tm4s2qcYX0tbpnO1iQzOzCHn7CDcyDaMBu8aa8j/+1HIw9JKQnaNCSwUchuTAfaIKtyV1yK8ZDpVPlMpYdUHdpLHkuqdsAXSnAsa0j/ucXGe6FZHF72Ol0qBr1V99bR/HHNjzX8r2krydDx906sFws/rjTsEJsS8RVBZIeweTOoE3BF30JPB8OV10pHI1mn9/waglZChz3m0mV4X6vNO0RROVkZ0ZfwBVv6ABdmSitdcP2Q9ZMNHUN8StEM2+1alsQ7Nw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH0PR02MB7929.namprd02.prod.outlook.com (2603:10b6:610:112::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Fri, 6 Oct
 2023 16:17:39 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6838.039; Fri, 6 Oct 2023
 16:17:39 +0000
Content-Type: multipart/alternative;
 boundary="------------E0uz5wjKCi5LwxChGCnjL8G6"
Message-ID: <6441309b-8244-4b0d-821f-7b3c8fddd618@nutanix.com>
Date: Fri, 6 Oct 2023 21:47:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/10] migration: Modify 'migrate' and
 'migrate-incoming' QAPI commands for migration
Content-Language: en-GB
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20231004075851.219173-1-het.gala@nutanix.com>
 <871qea5x7w.fsf@suse.de> <ec1a8f2e-ec10-46e2-1a2c-1ae593080ad4@nutanix.com>
 <87sf6qpjrz.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87sf6qpjrz.fsf@suse.de>
X-ClientProxiedBy: BYAPR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:a03:100::38) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CH0PR02MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e55c81-5e8f-4b59-ad28-08dbc687c2b4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHSqHIgoU4pHVstAQKPx448gYGufydJB0iO4ZVZ5MGtb8QBAYeViPYefvCLvxnodFdbe4d6oHzPB8zKMDJuU9/rx/XcjGwApobMGzGxkzcROcRC3WMtZps+W7ns8oVUKehvvfwP7oKsAulk1afQFEbORMefC1JHbBXgfpG9DKdigNB1MwAlo+lp8PgQMG3JjkkAjloEQ7HjDEQJn+Fgp3mq4xQodZ2rlcO+8wpRJty2j2/H16J4rplloDdoBpi4pO/ImUTb/p/KaaYpY54MVpo71aXRhhPqrr3z5SQv+74YCsVnp7HjiDXt70SWRgmFsCldi0DFTr7+lBLTqAxSckCe5FPOiGl412xGnVTlUiCyNDJlVpcY75DaPXhQUZPni/vAUIebjrhCHxSiKZAobSHx/i0RTpUKjEsNQSS79DguLst3varKJKXEzD0POxKIYaBmftPpir1BIina8N/uNC+6JpOMR0STxL0lkoR6tqYiM07gKG1NoOCKSVuX8d0aYeXwwFFxaXv5dq4q+dlBUV3l7G2mkNw4L2mJkI8bVkB+nXdpRMzEBB8njSJ9KEWWuxTqKS3s7VOc8km5nrGrQCTkDO9wHI6Ba7LpzQl1ycZ48/M7T3BkLbGSqKwOU/AtC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(376002)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31686004)(83380400001)(6506007)(33964004)(53546011)(6512007)(6486002)(966005)(478600001)(31696002)(86362001)(38100700002)(166002)(30864003)(316002)(41300700001)(2906002)(2616005)(107886003)(26005)(36756003)(44832011)(66946007)(66556008)(66476007)(5660300002)(4326008)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXRxMC96bktIdUdoVE1pOThHVFNnYUJOMjlSZlhMbzk3M21QaGxDRTVLN0dL?=
 =?utf-8?B?L0RYK1VjVnNNYUk4RUR3VGgreVdIQkYzTUk1VVR5MGo2Zzd5U3JQYnVYVkRJ?=
 =?utf-8?B?c01iVmRiMkJKOU5PbXU1NUNseXBTS3JIcG8rdEtMYXcwY3dGOTJnNFRGbTFz?=
 =?utf-8?B?b2d4Tm51RDBaMmI1SlljYlJRSjd4RWROdHpjQ1RMQThGMnpGM0wzQ1p4S3J4?=
 =?utf-8?B?aWFyUVFOK2wySnFyZnplTXBoNklmcXE1YVN6MWZmdGRmOUR0RzFpSER2QThk?=
 =?utf-8?B?UCtQN2U1Rkw3SmZPODV1QXlUMkFmSDEwSFFRNGhyRTllZlJoV2hXSXRQUU5M?=
 =?utf-8?B?OXdjenlHeFpWUjdhTHRmSFA0WUpJVnliZlBwcVo2NG0wOTdhNXZ0eDh6by8y?=
 =?utf-8?B?dWNUMGViTHN4V3hsb2pETHkzdEdhVjJhVUgrNkdFWUVNQURSSmJyclV6bXVi?=
 =?utf-8?B?U2E1SUpwNnM3dW5qQjFpVURhMGtzZHR4clNIOFB2YU95WXk2TmVTYkljYmJZ?=
 =?utf-8?B?ck50QWRUbHF5eEE2aldGWnB3QWxZakxKbWlIMGNlbDVWcTh1bEdjSHZZQk1y?=
 =?utf-8?B?TnBoQU5tdWhFenZVbmpxc3JOci9na2RiMU5yTEVveU1hWkF3VlI3eEo4V252?=
 =?utf-8?B?MVVHVU5raFdRUHdGYytaa3pBQnRWU01NSWNmcmVVblJzb0ZTVjR6ajRZcHBH?=
 =?utf-8?B?QVl6eDB3NU5DT203U3FEb3ZOaStORURTWlBuK1ZRQ0xNWGgrMWNVMGlpWUhk?=
 =?utf-8?B?YU80dnM0NWtKbU9tdUlVTHFaQXZ2c0hmUnZqWStqeklaYmpJZEtBcUc4a0dV?=
 =?utf-8?B?blNkZ3pBVGhGVWZHNmU4WFdSblB2aVV3Y3V5K1JOamxlUjRvc1R0b1NJdSsx?=
 =?utf-8?B?aThaSUZXeWthSWZIRDdFYXVpR2xmeitibDhuSkFXQzRDcEtRS3N6ZjZaT1oy?=
 =?utf-8?B?MHRpT1p2Z1lzdWpxWllJV1lqVHZEU1AycEVKL1dkUFFIdnFuSUhaUE1vNUJT?=
 =?utf-8?B?UnorVytHUmxlK0xVdlkrdnBKSXc4cG1ZL3NhdnFHcnY5K25lRWxSVEVXSjAx?=
 =?utf-8?B?SUJCNkFSS2JpSHhIRExQb29JZjRqUWx3SWJrQXczak8rbml5QXRSZmFCSVB6?=
 =?utf-8?B?VHk1bC9PN3RyNmY4MVZWd1dNbFZpc0VNNlI5VUJtemdBL3BDMVB4dGpjZWhE?=
 =?utf-8?B?Mk5aaUF0S3N2WnZUeDdzM0hMcWhGK29WNHRxTFVhYURVNEpZbS83a2V4b25q?=
 =?utf-8?B?S0t5VzJKSW9IM254UHFtbFZVOUdxQVNCcU5tazJHUXd1dm93MTdPQ3IyTGZH?=
 =?utf-8?B?b01Mbk5LWDBQUjgrZWo4d2ZoMHhkeUYrZURYTHIxUWhwZVFtRXlRSnJUZFov?=
 =?utf-8?B?eENWTVNEVEZ6LzIwUmVVMUJzSy84YWdPRkthWmVlRnpTNHhoZXMyWFRUMGFI?=
 =?utf-8?B?VE1TTkltbHMwUUozelA1S0h5dzlmMGNZUzc2YldEaThkeCtDNUxJWjFLdkR1?=
 =?utf-8?B?ZEUxTW53S2JPWXVPNjZlNU1OdGNGM0l5VFQvcnRpdmNyOStQRzdtcDVsMzVS?=
 =?utf-8?B?bUFxbnJuSnFXWXN5OThVME5JSkJMemFEbmtIejFQTXEzVmJRYW96UlVuZ0kr?=
 =?utf-8?B?d2JiYi84VkhWaEdTcW5nNnpubmRyTG85U0RvNXhlY3lCQUlLQ2tENEYwd1NE?=
 =?utf-8?B?VzV4a3NncG9vSWQ4cEh1eitmZzJOTEpFb2tTMlBlNHVIVmFwVEh3d0tKaVMv?=
 =?utf-8?B?MkRuYVNzc1FLZlV2VEJKMElLcmdrTmY3S2JyeE5ScmRwR3F3Q3U2NGVPL0Rp?=
 =?utf-8?B?VGdySjFvckhaUUl0MkprNDJCenJUbE5lZnU5Y1lxY3EySWxjUUhEdUNTZDhx?=
 =?utf-8?B?M3o0SzZZM1VZL3N0bm5GWDFxZyt0aUhjcWhjN1NoQ1lIak1HUmEySmR5V0tJ?=
 =?utf-8?B?czZBYlUyS21FWGg4eU9VcUNuVmE5NHJ1dEhTZjlxck5YOERnM1hxeWZxaEFU?=
 =?utf-8?B?eDJaZXF6R1liajc5eVNETjZEZTVSRWVxUUlFdExZWjd3T1RkZ0U4Tk1sMFAr?=
 =?utf-8?B?alduNFBkOXc4aWNrMFhoeWlvM0NZNTJBT3lCRldFQk1vemdFM1lZNVAxMFpN?=
 =?utf-8?Q?8M4NOnc+Z50/Mb/c97rQqLzt6?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e55c81-5e8f-4b59-ad28-08dbc687c2b4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 16:17:39.4258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6bg0HWOJlyJ2V/FT9FAqAZ0dTCmO7lMdocVPrMlZok6iZgy1+aSDaZpmTJMeY3mAJS55hnfXxxrfI/vG7tiHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7929
X-Proofpoint-GUID: FjufQOS2jPyUzjQymuGZVnyuIxFvuRr9
X-Proofpoint-ORIG-GUID: FjufQOS2jPyUzjQymuGZVnyuIxFvuRr9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_12,2023-10-06_01,2023-05-22_02
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

--------------E0uz5wjKCi5LwxChGCnjL8G6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/4/2023 7:33 PM, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> On 04/10/23 7:03 pm, Fabiano Rosas wrote:
>>> Het Gala<het.gala@nutanix.com>  writes:
>>>
>>>> This is v11 patchset of modified 'migrate' and 'migrate-incoming' QAPI design
>>>> for upstream review.
>>>>
>>>> Update: Daniel has reviewed all patches and is okay with them. Markus has also
>>>>           given Acked-by tag for patches related to QAPI syntax change.
>>>> Fabiano, Juan and other migration maintainers, let me know if there are still
>>>> improvements to be made in this patchset series.
>>>>
>>>> Link to previous upstream community patchset links:
>>>> v1:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2022-2D12_msg04339.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=jsRvKRy1JOiy05KX1CtLqWN1su5XNmKPKuJTSx5sZpU&e=
>>>> v2:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02106.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=mzt3n5PD1QclHfpZEh-VMoLkkwT8xqjPYN-1r7MOly0&e=
>>>> v3:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02473.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=fa9W71JU6-3xZrjLH7AmElgqwJGUkPeQv3P7n6EXxOM&e=
>>>> v4:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg03064.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=Xr1y3EvBzEtWT9O1fVNapCb3WnD-aWR8UeXv6J6gZQM&e=
>>>> v5:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg04845.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=OtK10W2Z0DobrktRfTCMYPxbcMaaZ6f6qoA65D4RG_A&e=
>>>> v6:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D06_msg01251.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=XH-4qFQgdkAKmRsa9DuqaZgJMvGUi1p4-s05AsAEYRo&e=
>>>> v7:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02027.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=RwvfliI4wLm7S0TKl5RMku-gSSE-5fZPYH0MkzJdoPw&e=
>>>> v8:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02770.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=BZsKBJGVPDWXwGgb2-fAnS9pWzTYuLzI92TmuWBcB3k&e=
>>>> v9:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg04216.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=YcWFU9I2u-R6QbVjweZ3lFvJlllm-i9o5_jtLBxC_oc&e=
>>>> v10:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg05022.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=JQt63Ikbz21vmsLmSensQu8zknGuS9bls-IFpndor78&e=
>>>>
>>>> v10 -> v11 changelog:
>>>> -------------------
>>>> - Resolved make check errors as its been almost two months since v10
>>>>     version of this patchset series went out. Till date migration workflow
>>>>     might have changed which caused make check errors.
>>> Sorry, there must be a misunderstanding here. This series still has
>>> problems. Just look at patch 6 that adds the "channel-type" parameter and
>>> patch 10 that uses "channeltype" in the test (without hyphen). This
>>> cannot work.
>> Ack. I will change that.
>>> There's also several instances of g_autoptr being used incorrectly. I
>>> could comment on every patch individually, but this series cannot have
>>> passed make check.
>> Are we allowed to run the make checks ? I am not aware from where these
>> failures are arising. It would be helpful if you could point out to me
>> where g_autoptr is incorrectly used ?
> I mean just the project's make check command:
>
> cd build/
> ../configure
> make -j$(nproc)
> make -j$(nproc) check
Okay, now I got it. I was not aware of make -j check to pass the qemu 
tests. Will make sure that it passes the make check.
>>> Please resend this with the issues fixed and drop the Reviewed-bys from
>>> the affected patches.
>> How to verify which are the affected patches here ?
> I'll comment in each patch individually.
Thankyou for commenting on the patches. Will try to make all the changes 
in the coming version.
> We'll also have to add compatibility with the new file: URI that's
> included in the latest migration pull request. I'll add comments on
> where I think we'll need to add code to support that feature.

Ack.

Regards,
Het Gala.
--------------E0uz5wjKCi5LwxChGCnjL8G6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/4/2023 7:33 PM, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87sf6qpjrz.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 04/10/23 7:03 pm, Fabiano Rosas wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">This is v11 patchset of modified 'migrate' and 'migrate-incoming' QAPI design
for upstream review.

Update: Daniel has reviewed all patches and is okay with them. Markus has also
         given Acked-by tag for patches related to QAPI syntax change.
Fabiano, Juan and other migration maintainers, let me know if there are still
improvements to be made in this patchset series.

Link to previous upstream community patchset links:
v1: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2022-2D12_msg04339.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=jsRvKRy1JOiy05KX1CtLqWN1su5XNmKPKuJTSx5sZpU&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2022-2D12_msg04339.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=jsRvKRy1JOiy05KX1CtLqWN1su5XNmKPKuJTSx5sZpU&amp;e=</a>
v2: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02106.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=mzt3n5PD1QclHfpZEh-VMoLkkwT8xqjPYN-1r7MOly0&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02106.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=mzt3n5PD1QclHfpZEh-VMoLkkwT8xqjPYN-1r7MOly0&amp;e=</a>
v3: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02473.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=fa9W71JU6-3xZrjLH7AmElgqwJGUkPeQv3P7n6EXxOM&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02473.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=fa9W71JU6-3xZrjLH7AmElgqwJGUkPeQv3P7n6EXxOM&amp;e=</a>
v4: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg03064.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=Xr1y3EvBzEtWT9O1fVNapCb3WnD-aWR8UeXv6J6gZQM&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg03064.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=Xr1y3EvBzEtWT9O1fVNapCb3WnD-aWR8UeXv6J6gZQM&amp;e=</a>
v5: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg04845.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=OtK10W2Z0DobrktRfTCMYPxbcMaaZ6f6qoA65D4RG_A&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg04845.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=OtK10W2Z0DobrktRfTCMYPxbcMaaZ6f6qoA65D4RG_A&amp;e=</a>
v6: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D06_msg01251.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=XH-4qFQgdkAKmRsa9DuqaZgJMvGUi1p4-s05AsAEYRo&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D06_msg01251.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=XH-4qFQgdkAKmRsa9DuqaZgJMvGUi1p4-s05AsAEYRo&amp;e=</a>
v7: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02027.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=RwvfliI4wLm7S0TKl5RMku-gSSE-5fZPYH0MkzJdoPw&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02027.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=RwvfliI4wLm7S0TKl5RMku-gSSE-5fZPYH0MkzJdoPw&amp;e=</a>
v8: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02770.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=BZsKBJGVPDWXwGgb2-fAnS9pWzTYuLzI92TmuWBcB3k&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02770.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=BZsKBJGVPDWXwGgb2-fAnS9pWzTYuLzI92TmuWBcB3k&amp;e=</a>
v9: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg04216.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=YcWFU9I2u-R6QbVjweZ3lFvJlllm-i9o5_jtLBxC_oc&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg04216.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=YcWFU9I2u-R6QbVjweZ3lFvJlllm-i9o5_jtLBxC_oc&amp;e=</a>
v10: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg05022.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=JQt63Ikbz21vmsLmSensQu8zknGuS9bls-IFpndor78&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg05022.html&amp;d=DwIBAg&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&amp;s=JQt63Ikbz21vmsLmSensQu8zknGuS9bls-IFpndor78&amp;e=</a>

v10 -&gt; v11 changelog:
-------------------
- Resolved make check errors as its been almost two months since v10
   version of this patchset series went out. Till date migration workflow
   might have changed which caused make check errors.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Sorry, there must be a misunderstanding here. This series still has
problems. Just look at patch 6 that adds the &quot;channel-type&quot; parameter and
patch 10 that uses &quot;channeltype&quot; in the test (without hyphen). This
cannot work.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Ack. I will change that.
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">There's also several instances of g_autoptr being used incorrectly. I
could comment on every patch individually, but this series cannot have
passed make check.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Are we allowed to run the make checks ? I am not aware from where these 
failures are arising. It would be helpful if you could point out to me 
where g_autoptr is incorrectly used ?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I mean just the project's make check command:

cd build/
../configure
make -j$(nproc)
make -j$(nproc) check</pre>
    </blockquote>
    Okay, now I got it. I was not aware of make -j check to pass the
    qemu tests. Will make sure that it passes the make check. <span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87sf6qpjrz.fsf@suse.de">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Please resend this with the issues fixed and drop the Reviewed-bys from
the affected patches.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">How to verify which are the affected patches here ?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I'll comment in each patch individually.</pre>
    </blockquote>
    Thankyou for commenting on the patches. Will try to make all the
    changes in the coming version.<span style="white-space: pre-wrap">
</span><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87sf6qpjrz.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">We'll also have to add compatibility with the new file: URI that's
included in the latest migration pull request. I'll add comments on
where I think we'll need to add code to support that feature.</pre>
    </blockquote>
    <p>Ack.</p>
    <span style="white-space: pre-wrap">Regards,</span><br>
    <span style="white-space: pre-wrap">Het Gala.
</span>
  </body>
</html>

--------------E0uz5wjKCi5LwxChGCnjL8G6--

