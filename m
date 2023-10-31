Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E96C7DD691
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:10:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxu7X-0007nN-FV; Tue, 31 Oct 2023 15:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qxu7V-0007nC-N6
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:09:45 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qxu7T-0007pa-31
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:09:45 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39VDCEUQ000744; Tue, 31 Oct 2023 12:09:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=GIf/sgmKgg0B
 MEV5rVEzIFrP5hPiWMZ9hVeskkpk170=; b=OWvR8JJ0rOC+xQAddYa6qVVCR9LA
 rmH3sDLsmtTQoBvSRyN5iC1ZojQDTdwnYhauspW8LKkQTccTQHVgiDLPm+JSvrGf
 dTIelDk17qdupevZCMlgGzw3puFaWHmS9HjUZftyJHl4lQB9mMaBsHfaGHScNWqp
 QPbqY0SYoQSfMFlw4FsP63gvCGLTwlvO+XLekpDz3ynA3l7a8KpDJdStH2BiUlE5
 9qXOuVKpCk6VKsDdY24jHoqIyl1/qvTwvFJJt1xHaJPN1BIz1DS52HGQxChFcJ+l
 M+vicwBLKAgy+C9EFclV66owSercxYYzoR0CVj7Z2rx6K213X5AmlpO1yg==
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3u11uux4ts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Oct 2023 12:09:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuVXubrrsqKzmsD0K7+cuR9U4xGKJ0mLTqlb5gq8szoaUxHs9jBr+ru31eRKTSdN4rbwDNqyqbzJK+TnyS3syRPdIrVvhQGchJJ/0P2JeRk4BhhaeCzZrAzu1662Io113tmqM1APuKaZMvzWdwW22d4qFqtMmCGb/uI6V6fCUV47lCenUScyC4g0ffiA+JqK7PiXQgshAa21WhpjnIN2Vw42bv6le9ixircTIlMIIoNciUIEdJBuZHrkV2K7LYy60WwqwZoKvksAmECIbc5RLZ9GT6bu7mbS1u+6UKcSLryDnrKBAnjh3qjnESRtwwlT9Gpc9Q+2of3FLfK07TPUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIf/sgmKgg0BMEV5rVEzIFrP5hPiWMZ9hVeskkpk170=;
 b=jda+8T0/Gscn6ujAazLuQnsJaCzoJOyDVA/NvVmX7OzME9f/VgaqHvXYjwaNuR4q+zzFkIF7HHE7bKG2e4DBh6epgTTTNN+7N0WTJ0l5xF3IAekeLE/1l6JwQIxqmie5pmuWKZSDSz49vHflOse/qG/u5ISatjDifmcE9EyiMpIwYm559NoNwWTPeWjY0uOq5sOJfMifGFsIu6RDQkHX/gyWF/QeQObnH3+MjJDnSw61+Y50Fd2+TCg2Ux8KxY08xAJK2zPvTvgVObJmN1A4L5UJ8jT9CAhkS9KEb4ldaI5dNAgPiXzczvhjT+bgMD2q2fT2PDOLwxc8STGX7dVvNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIf/sgmKgg0BMEV5rVEzIFrP5hPiWMZ9hVeskkpk170=;
 b=tYohfLSuqrvIj4s4lu1CCc05kh6C6e+PDdE/EJkvgOIUdC733Sw9dHPiSUiorKXnuYSx9P7vwoBD+lVX83ciVG+WvFGaAWD8To2aspFcREGfcS8IHfy9VU2TPFJNfShRq10zSihCEGB1rhucdt4ycaopC7SI8UauZt22s9HvY8tvXR1y1scXSc5FBkMyvcPw3Yfb9F27ES87PkeEj2LLxSmY20A/7ux2RW/eh1zvz9p+nf1q3i+GhuFdwe5vLe0pmUKEjAIwh1b/0cxefzJoCKeyz3hGX/LSeeJ4eE99ABHa0Xo4VWgqs6L4K8m0Il3CCpatttDJ3jkc/FCnAgUKrw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH0PR02MB8258.namprd02.prod.outlook.com (2603:10b6:610:f8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 31 Oct
 2023 19:09:36 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f0ae:86b1:db55:61d7]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f0ae:86b1:db55:61d7%7]) with mapi id 15.20.6907.028; Tue, 31 Oct 2023
 19:09:36 +0000
Content-Type: multipart/alternative;
 boundary="------------oQeQxYqoNzlmMVoVp64t22co"
Message-ID: <896322bb-93c6-0eef-c87e-fcdd90c38f51@nutanix.com>
Date: Wed, 1 Nov 2023 00:39:21 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v15 13/14] migration: Implement MigrateChannelList to hmp
 migration flow.
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Prerna Saxena <prerna.saxena@nutanix.com>, dgilbert@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Manish Mishra <manish.mishra@nutanix.com>,
 Aravind Retnakaran <aravind.retnakaran@nutanix.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
References: <20231023182053.8711-1-farosas@suse.de>
 <20231023182053.8711-14-farosas@suse.de> <87msvy4rjg.fsf@secure.mitica>
 <d746e4d6-1572-2360-3780-7be4ae63ac29@nutanix.com>
 <CAGiv1-VF9mCq7B-6RCHPONT43Zd8YTH87xJXFbdf5GLcY_dbcQ@mail.gmail.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <CAGiv1-VF9mCq7B-6RCHPONT43Zd8YTH87xJXFbdf5GLcY_dbcQ@mail.gmail.com>
X-ClientProxiedBy: MA0PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::16) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CH0PR02MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: a00b651b-e873-4bec-969f-08dbda44ec3d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M3FrjbtSAhAmwyaYOd8FTAipPsbOY8rDTdW6dXHljKynHs85MBVczxO3G289I2dM3X3q4QZ8EvWG5zJcl0iVJtoVEfQAJTszQYyBQH1sVBvGU0KO/+grjWIbdmsbUDvliPph9WdLGnTJfsjywYGsQrBnKAyXg8IDQ1eYLTkb2qH08H0f4V6OnmoBZ8oAOCftO6Do0styY2fKunFbJM1J+e9yL+2sBLyGDqoEnYvGiP3mbpvH3e6lXPN2u/KU/2oDj2QCcWr3VnaRI7wtsTIXLlqZbzGRQoKb6JxaNN5xDwGIenE5zg39J3isp7oZrIKB2joVxUsT+vaxDsxjQ8cS4Nko3rxRCtzvJxOW1K1piPeYB2knVdx+T+FBKtVBYO7F8FAxXyBnt6szcAC3yENljFbOw3ArA6e7Xv2nCluef9TRKIBoUAt2VpETtde5av2f8YLTDNNHwZUXdfpuClU5/fqBDkjs/s16VGbrYCHyYQ/j8hQDOpO0r0N+nGejIYmo/HnHDaO9WaNB6h4fCpopl1jQehOVs3Swg/6zixqLWNrL08oNFXVBvsxkuYlxi5HUaJKcOVTVxfNYS8hguvZbZGsmXqSI4jZX26xOPoKuyOhSRHl0uCvUAWCNrkIDEFacoDOqUl6jxF/TYvwVbgvBbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(8676002)(8936002)(4326008)(44832011)(6486002)(53546011)(33964004)(31696002)(31686004)(5660300002)(41300700001)(6506007)(86362001)(6512007)(316002)(6916009)(26005)(478600001)(6666004)(7416002)(2616005)(54906003)(66556008)(36756003)(38100700002)(66476007)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWZ4QlJJZW9Jd1dvS2tBSG5JRjY2ZFdwS1laU3pXSlg1YTU1OFBRY2Y2YW56?=
 =?utf-8?B?VzVoM3dYMGVmZ0FJMEFhdzBpNFIrTktEenNocG5vTkpjK2VCZlhIbkMvTDU5?=
 =?utf-8?B?dlV4cTZ6Y3h6VWJBajBoMDhCZnFMU1pEWm53WmVIR2xaKzdJRHUvcFhKeE9M?=
 =?utf-8?B?NjVxSU5UY0xKV2NiMnhIU2g1ODF4YnVybmczQW80ckk3TUtnOTdjeUZaSVpL?=
 =?utf-8?B?ZTgrNjFWeE1iek1Hcml2cFpNNHhsd1U4WHAxblFqa3BmU3dObGdlTDROOGhw?=
 =?utf-8?B?anZ3dkJuaE5yR3RBMW5BMzlQUXJNRGdQS2c1YzVsOGZOeTBjOWhkc0ZIdnhk?=
 =?utf-8?B?aFh5TUpuS28ycHVNcUZMc216amY2WEFHdFdkbmdlRitML0h0ZlFCTnh4TVlw?=
 =?utf-8?B?ZHgxeFpJUVVtWk1aWHhxbW9SV1VjY2xpeXZ1ZGt2aDVCR09MbGZXeUhwTzVk?=
 =?utf-8?B?MGtpWHZWbkNjY0ZiQi84ekFVSXlqYUthcy8xNHhjYXJIQ0h6UzNMblQ3cy9i?=
 =?utf-8?B?UThRUERjZ3hPaVVzMHJ3by9LYlJ3TVoyb0pHVm9TMWdFbThDaElrMjNmcGdR?=
 =?utf-8?B?QWxhMk83aTRYMXVGSHc1MGtEaHhLd2dVS0ZqRm9lZThrRnVLTWVjN2s5TlBE?=
 =?utf-8?B?c3IzQ28xYVRyRXk1OCtSeFFqWlhJSzZhcnBKaUhITFFJTkgvZHFzMWxXOFNM?=
 =?utf-8?B?MkR6alhFd1hKbE56RGljY1IzR29oYXBTVG1ZQjliL0luMFJ4TnVuU3J2TkpJ?=
 =?utf-8?B?cXZkb1FoUUlLSUtDdVRlZXQreFAxWDFOWXVrblFOeUtwTDgwQXJoMUhtcmVW?=
 =?utf-8?B?TWplaElqN2ZpZnhDTkhlcEhXV3A0UXVqRWtiY3JGcUgxR3dRbGQ3Z1BxcFBD?=
 =?utf-8?B?U0J5Y04rZDVSREJEMVNzUFNsaTJlRXhRM3UzdkV6RXBtMGlHc2Nuaisvb2Rs?=
 =?utf-8?B?STVPelF1WTd1cEUyNHB6dVl3MHVRd1g0NzVGNWR5QXFFQStDZ3JLMWZVNnFn?=
 =?utf-8?B?VzBQOU13Ti9tcVE2azdDblZ6VUdoN041ZDNKWHpwU0FWbVJFMmFSR3lzV0Fh?=
 =?utf-8?B?eWhNR3lyb0dGNmIyb1N0MVI4Y2MrUGcvSU01L05kYTlNQzFTdXJuNnMyVVR5?=
 =?utf-8?B?Zy9HVGVmaE5nVGNHSkpMclhGQUUzSHlBQ1NHazF4U3VxQ1ZMNGpQK0lSemlJ?=
 =?utf-8?B?Q3JoRmZXWUxVU2RGdndha1FtdkFiSE9mVnNDVUY4bXdqSzZadVlnMWhleWpU?=
 =?utf-8?B?UjdGSW8rWWxmNjFoNlNLN214ZFdDRVdxWm9kdjZ2UVJZLzhkZkY1Wk04Qll4?=
 =?utf-8?B?Y3FMbnZKWktzblFzY1ZmbWFNaVlnVHZNODQydUhVTXJnL2pIb3ViMG1TT3Jz?=
 =?utf-8?B?WFdtRHlTak1EUEd5WHFRa3hkME9CSnd2NzhpZjNvdmJwVWxodHFoazlvZGwz?=
 =?utf-8?B?Unhwb2xmWG01NldOV3NMd0FHODkvT0hGY3dPeUVSVjdIWHN0bk1aTmIvaG9P?=
 =?utf-8?B?Q0ZycDBXc1VYWWtJZTNYOWo4aXB5U3NPU1RsWU1FNTRjS2xVU0daV1lXWjJK?=
 =?utf-8?B?UmFQeTRaTHM0aUtZN0VuMnB2bTI2QUVkNDNUNWRGZ0xxT0NwM05EbDEyYXgr?=
 =?utf-8?B?SmRRNWpFa2dVbXF2cllCbVFnNU1OM1BZVzVNU2tPbkhMTkVUa1NFb0NJYlRw?=
 =?utf-8?B?cGNUMDJFS1RmbGRiMVoyOUpvcFZGZXJ5M2FEU1lsMHFEaGZBeVdUTXFJZ2xi?=
 =?utf-8?B?dGM4VDVxL0IvL0dwVWc2aTlNUVdiaitEWXZqdGtLMVBiRExYMUllTmh4dTd6?=
 =?utf-8?B?Q3hMdmo1MTR6dnZDV1RRMjBMMlZ2VkFUN3VCUElGcFJheFE3UExQc2FYUDhR?=
 =?utf-8?B?WHQycnpMVzlUbTF4dlAwMzN3VUhkYlJRM2pqSlhjelNuL29LWmptcFkzMGJr?=
 =?utf-8?B?TVExQ25hdjNvcjVuVm5aVWRhRDlzVisrVlFlVnVNQzhRcm4vM2QxekM3RnpZ?=
 =?utf-8?B?Vi9hYm56a2VUUmRRbjgyTmRuNmNpU0RxbW5ZbSs3dGt0dkJqZ1ExNHMwY3Zu?=
 =?utf-8?B?Z2g1VmMyczZKc3ZiRGZ3MG5nYXFscXlrbUNUQ3hQNGg1b2ZkVExydEVXLzVz?=
 =?utf-8?Q?pDl0w53j/RP8Lx0tMYpyrnqfp?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00b651b-e873-4bec-969f-08dbda44ec3d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 19:09:36.2466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KWU6Y+wwOReIiKRot9RaRbpCq0aBUtqce+NTiI/CdXsDIOu6F/NLfQ8B6aE3abuXngLCuMV1hpcXkc4AgnIDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8258
X-Proofpoint-ORIG-GUID: Hx-wFB0_ldT_WKlGE02qmNbGIMt7_gvA
X-Proofpoint-GUID: Hx-wFB0_ldT_WKlGE02qmNbGIMt7_gvA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_06,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, NICE_REPLY_A=-3.053, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--------------oQeQxYqoNzlmMVoVp64t22co
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 01/11/23 12:25 am, Juan Quintela wrote:
> I intrehated al parches until this forma next pull.
I should just add the last 2 patches as individual ones, is that what 
you mean ?
>
> On Tue, Oct 31, 2023, 19:51 Het Gala <het.gala@nutanix.com> wrote:
>
>
>     On 31/10/23 11:12 pm, Juan Quintela wrote:
>     > Fabiano Rosas <farosas@suse.de> wrote:
>     >> From: Het Gala <het.gala@nutanix.com>
>     >>
>     >> Integrate MigrateChannelList with all transport backends
>     >> (socket, exec and rdma) for both src and dest migration
>     >> endpoints for hmp migration.
>     >>
>     >> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>     >> Signed-off-by: Het Gala <het.gala@nutanix.com>
>     >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>     >
>
>     > Later, Juan.
>     Regards,
>     Het Gala
>
Regards,
Het Gala
--------------oQeQxYqoNzlmMVoVp64t22co
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 01/11/23 12:25 am, Juan Quintela
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CAGiv1-VF9mCq7B-6RCHPONT43Zd8YTH87xJXFbdf5GLcY_dbcQ@mail.gmail.com">
      
      <div dir="auto">I intrehated al parches until this forma next
        pull.</div>
    </blockquote>
    I should just add the last 2 patches as individual ones, is that
    what you mean ?<br>
    <blockquote type="cite" cite="mid:CAGiv1-VF9mCq7B-6RCHPONT43Zd8YTH87xJXFbdf5GLcY_dbcQ@mail.gmail.com"><br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Tue, Oct 31, 2023, 19:51
          Het Gala &lt;<a href="mailto:het.gala@nutanix.com" moz-do-not-send="true" class="moz-txt-link-freetext">het.gala@nutanix.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
          On 31/10/23 11:12 pm, Juan Quintela wrote:<br>
          &gt; Fabiano Rosas &lt;<a href="mailto:farosas@suse.de" target="_blank" rel="noreferrer" moz-do-not-send="true" class="moz-txt-link-freetext">farosas@suse.de</a>&gt; wrote:<br>
          &gt;&gt; From: Het Gala &lt;<a href="mailto:het.gala@nutanix.com" target="_blank" rel="noreferrer" moz-do-not-send="true" class="moz-txt-link-freetext">het.gala@nutanix.com</a>&gt;<br>
          &gt;&gt;<br>
          &gt;&gt; Integrate MigrateChannelList with all transport
          backends<br>
          &gt;&gt; (socket, exec and rdma) for both src and dest
          migration<br>
          &gt;&gt; endpoints for hmp migration.<br>
          &gt;&gt;<br>
          &gt;&gt; Suggested-by: Aravind Retnakaran &lt;<a href="mailto:aravind.retnakaran@nutanix.com" target="_blank" rel="noreferrer" moz-do-not-send="true" class="moz-txt-link-freetext">aravind.retnakaran@nutanix.com</a>&gt;<br>
          &gt;&gt; Signed-off-by: Het Gala &lt;<a href="mailto:het.gala@nutanix.com" target="_blank" rel="noreferrer" moz-do-not-send="true" class="moz-txt-link-freetext">het.gala@nutanix.com</a>&gt;<br>
          &gt;&gt; Signed-off-by: Fabiano Rosas &lt;<a href="mailto:farosas@suse.de" target="_blank" rel="noreferrer" moz-do-not-send="true" class="moz-txt-link-freetext">farosas@suse.de</a>&gt;<br>
          &gt;<br>
          <br>
          &gt; Later, Juan.<br>
          Regards,<br>
          Het Gala<br>
          <br>
        </blockquote>
      </div>
    </blockquote>
    Regards,<br>
    Het Gala<br>
  </body>
</html>

--------------oQeQxYqoNzlmMVoVp64t22co--

