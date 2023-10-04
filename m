Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC027B7C76
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:42:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnyON-0002M5-I6; Wed, 04 Oct 2023 05:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1qnyOC-0002Av-FG; Wed, 04 Oct 2023 05:41:57 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1qnyNx-00070l-IR; Wed, 04 Oct 2023 05:41:56 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3945KmWD003906; Wed, 4 Oct 2023 02:41:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:from:to:cc:references
 :in-reply-to:mime-version; s=proofpoint20171006; bh=7wF9v1WC/LQA
 LLvH/5AFG6EeHFm55sggF3kfzQlee0g=; b=Am9IyCyg5QVSmKnKQWeHihpA6UST
 2eMlubEHvevRS/zbPZjGRU0ji9f/D6YatZ65JhIDmz6lvtQvtc3NlREvJEliAHDk
 p4gbsZOew9jw4Pvk19viqKChI1hXt+cOmUgKRfM5F7tHXE+fUr2H6FQ4xsdqktUc
 WpcUBnH8GWXDyxQ2Ke0OGh7BiClj3mC5MgUY25MPQTYXC1CWHjxByl/nRhq0IL2S
 XRUMp3QLKIexZI6birVex34EBllS367IGTFULBN/z+ySPkjn93UKNg7D1OIR6OJL
 aw7NoQ9c8LSuyzj065WbhMo3feXQSsw2mXY/jm8tUrYb/F/Z2GNVAstroA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3teh770946-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 02:41:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lx2QDlOAFQ2DGTNXl5D/DT8iC5hc2XQg1hP84xTYe0yKsNFtN+DcjGWONg6jdstO7yNwcWu9WKq1807ueHhXrswi4vvPlmogqf7aIL3aynLwf34m64aYB+Mk6MlWN6oG/U4Pv3MBLnBTfbOcmlwpIOIQSq6pdKMIq2l5LJhn40BbI9PwgQWBrvRM9nPXypNF1eSC5uYXtsHDd1qEqEjrv0IY7/pzhSQ769IgV53/SDS6aGh+ER3s2/Y8RB2+41YbDCpeqPxY2aYEUhBsiHb0NwhwuvXR/HYCJAhX9WUnum8ao2n+N/IPEd2B4n7C7mByuXBTbMx68PMguBSleHrVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wF9v1WC/LQALLvH/5AFG6EeHFm55sggF3kfzQlee0g=;
 b=CfzZmXqeJJc1QdGhUzGOUu+8JR+IwgpI8RSVco9Xs09pJrXVAyWVsxFlba922eALYbwJRWEQFqv6LU6TwX7nYM9ozRlrXFRPO30Si3srzxZGTSvHUgbsUVk22sua51AKTyo2fUe7mL4x7HYIaujgcKjkz+aRFfX7QtwzzCqVgFnwBLHC3hBVQmOOw9HqgEuGhRfNYPLeM0pqivNkEkmibNbSgOxVop9FOgPwHDsllhkYvHgus7aiTJS2E1ZaaURD4HQ+3dCPui79ZGBPXciRlXcaxTzUGb/fDvcJLmyFsNJ4paILvGfl40FLl985FsLt//fj5G4dIfX/Lq6QPHcsVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wF9v1WC/LQALLvH/5AFG6EeHFm55sggF3kfzQlee0g=;
 b=Lvo3LzVhX+5FGPhuOofpfmxJyabU3CaERw08S6pJcaavtuBtnXVtuOyTiHQCnCu+ltQP4QBWTaF+i6Obx5boA6d4eibB7UUa+QtdqRY9mce3e45bBv/gGnxPAGM74JSWSNyiNF3G5ZbOPKRLDa+ojEt4sqBjmNftCqZCj3YqwEjDQsrM5WwnSHJdfau/CY0mX0LXBaOWOa/yhLR7I6yqOIRUhDEDBXLRGXPCUaWYuHMBdENZ1EPT5+yqPxRK7oINpnHavdgnrT7JAXd4LM3Oq2HCd9oHH9wuoT01WSmMB+Myw/RDMfF2ObUaH/KUqLaLzbucxuegcF7EPDK8wS9PXg==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by PH0PR02MB7477.namprd02.prod.outlook.com (2603:10b6:510:15::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Wed, 4 Oct
 2023 09:41:33 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::efe6:606c:24a8:a313]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::efe6:606c:24a8:a313%3]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 09:41:33 +0000
Content-Type: multipart/alternative;
 boundary="------------QMlt4G3P0cjnICQo70DRWojM"
Message-ID: <25c0a7aa-0b5e-86c5-b523-344e62078736@nutanix.com>
Date: Wed, 4 Oct 2023 15:11:23 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [Qemu-devel] [PATCH] ahci: enable pci bus master MemoryRegion
 before loading ahci engines
From: "manish.mishra" <manish.mishra@nutanix.com>
To: John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 andychiu <andychiu@synology.com>, Prerna Saxena <prerna.saxena@nutanix.com>
References: <1568049517-10261-1-git-send-email-andychiu@synology.com>
 <20190910025404-mutt-send-email-mst@kernel.org>
 <9f402933-7256-75da-af77-2e47b656ab27@redhat.com>
 <20190910095329-mutt-send-email-mst@kernel.org>
 <a4a39c82-e5bc-71e9-28e8-25a0c68e2d6e@redhat.com>
 <16bffa8e-aeb5-187d-ada8-8cf954782528@nutanix.com>
In-Reply-To: <16bffa8e-aeb5-187d-ada8-8cf954782528@nutanix.com>
X-ClientProxiedBy: MA0PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::8) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7384:EE_|PH0PR02MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b3982f-fc46-45b0-6b4f-08dbc4be183e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PgQ3WtRMiKV+x/RPNzIoI0ehMnoAowlZVTfNQKwUbBFhOibrjiQQr+gGFH7g5DngLMu5iu5HxAvLyeP/xmvfxNcGgIA1Um2QwboribL1VQ14TYgl34Ee4eB8ohW0domaXjcXAL5lErGzqbW/WqaVbNKqxdGWXE98kq3ANS0z794OBVe3wV/uesglC/n9U4vJ055EbScQBvwLPj+UWzwc4bso4IKXD8zdUkZ5Xkb28FQ2wGuZzeaj0g79EyzPxsEZAJ0Pzrx8Ui8N8BKxEVxD/BU4UIoDgjKN6gGupYo2/rUy6uSNbolGf3M5pGEXiozGfRmK//0p5et+MnvuGHQMPVmazGRjE2REIsE56FhcSDMoBUS6sP5XVgok11/FT+7TP+a4sH1COcs1coPI+OzEDxtBQ8UWkJkx6BHzEwICIBnUNUBgrj0fd7BEsGq0rfvQc3ZnFfUC1JHN7xu/rorbi23raI+kSmroMt+Zf/9ywG3X4lkK5ppbwiDNTaljmbNNle7/Z0rjA9lWfCVCWAyUYG16u/rxr/Rn54urUSBN5Q3iCHJFkD2g7x6qb/ud+cYPW9hmKPtCDmqjQmfmKj0tpdpG0xgECK0edupnygYYGmAQNqArgF0Ere8KQKuIP/dKydtZ55BRpluHNtfit6qnKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(107886003)(36756003)(33964004)(2616005)(6486002)(6506007)(53546011)(6666004)(6512007)(83380400001)(86362001)(8676002)(4326008)(8936002)(5660300002)(30864003)(2906002)(31696002)(478600001)(316002)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N05EcmxGd2ZiRXo4TWVjdkVNSlhuRVYvMmJYc1VYNEVHOUJ6MHd1YytQUnZG?=
 =?utf-8?B?QmdGMUVQUDRqanZIRDVqZFg5bkVOcWtOWjZLRHR6ZUVvZ1ErWXRLRVlSM3Fs?=
 =?utf-8?B?V0I1VzROTnJTcDFXZXFwTFAxL0Nlb0Q2U1d3ZFptY1UzMkxWMGFGbjVpWXBM?=
 =?utf-8?B?WEt6ZlEyeWo1SGd0Ynd1bXA4clNIelpVd2pMdy9wT0svNFhGOWhLd0FPczNT?=
 =?utf-8?B?SGJpR3pYWkhUbUIwdjRWWmlVNmxmZlpmS2ZIY2JqbHBaTzJCejNZbEs4YnRr?=
 =?utf-8?B?WjZDZ0V5QUF5SXdyYS9RL1VocUh6ZC9yblFycERhRjh1S2FuYUg5emtpMmhY?=
 =?utf-8?B?UGxrMTZxUGNJUkxUcktTS3hQanVyQzBXc1RzeTU3ci90YW1aWDZsaFJtOWt3?=
 =?utf-8?B?Y3lJeFF3eGNGaGwxME8xblVCVDJpT0lzMXJibXcrWnlkRHNvZW51VWIxNmo0?=
 =?utf-8?B?a3daSFVSR2JtZUcxQWRla21QZTJLb3FaaXEzT2dUODBvSjlzcGFrUURCUE4y?=
 =?utf-8?B?TEFva01pZzF0c2U5cWpqdVE0SldweVFJMWxVVFZ0azk3dTI0eDFYcXpTSFBP?=
 =?utf-8?B?NzU5TCtMU3hneFFPZy9ndGg0NkpIWVBLOCtHS1dsWFBpcFNmV2ZmRk1sdjFn?=
 =?utf-8?B?Wm1QVHVMM1ViQVBOM0trMWY0UTduaHpoMytvbElFcGVzdUdBWE5oRnNBREs1?=
 =?utf-8?B?US9EcGFKcldaOFRPa3JqSVUyNjF2cWU5cEdjQUJ5UXFkelBwVEhsekNGUnVu?=
 =?utf-8?B?ZWRWTC81SFg1YVRRUnQ1ZG4ranVIaStIZnE1THRJNkpJVVJ1ZUNiMFFkbnFa?=
 =?utf-8?B?V0FVVHRENGpFQTJFVnN2T29ydWFSbkdXa0ZOdm5wdlZ3WHF5YVpWbDhXMWYw?=
 =?utf-8?B?OG95L0RNc1pINzBoSU1oTGFMWjZJSDRPM0xuUy9wajBDOFA3Vkx4MUxhRnNL?=
 =?utf-8?B?WnRMbXJUY2ozN2U5TWFBUEFrTldEM3NlYkg0ZFB1MENaZ09pNGlLMGhpNFdO?=
 =?utf-8?B?YTVpeHlnTmxRTmMzMVFyUG53MTI2dnBsVTJPSlhHbjlUR1dCRWx2NnlxVnB6?=
 =?utf-8?B?L0xDcFY1SS84dUpJL3lCVWpEVHFxaDJuSXdYbWVLKzRyZ3F1RTBLN2VqdFFz?=
 =?utf-8?B?Wkk3SUZVUW41dDc4M1p5QkpDRGlFUGJIQkNhVUlNZVp0N2xuU0NtM09PNXht?=
 =?utf-8?B?Vzcrc0kyYklIcGp0dWJ5MU9iaXhKZXhrZEIvellPWmRRb0twWTQrSXk4aC9G?=
 =?utf-8?B?VlhrNmw5d3R6cE1EbzdsUXliY3dvRk1qY2NXZk1aRVdkckdZcllmUDkxZnlW?=
 =?utf-8?B?KzdhYlhmUko4M1l1OTRQeFJFUzEvRDFMN2ZzMmxIQlNaWkNTYjhncHMwV1dO?=
 =?utf-8?B?NEFibFNhYzh6QXJDeFd2NEJRN3g2aGZJNkdqVlk5WEZHRE15WmVEa0g4bTVU?=
 =?utf-8?B?L2Uwbk1IVVk0djRtcjVzWEphNTBrdmVIeVVsUWc1WUJwTndZOFpkTG5JZ21r?=
 =?utf-8?B?bGFtOWwyZDh6SDQyUm9Ta0xTeU1nWjZxL1FuL2pYN0wwMG5PYkVoRjlGeUky?=
 =?utf-8?B?M2pudCtzbmIvL1FKeEk2OVB2eFVIUWJGNHgrd2pIc2J2Smg2SG5LdU5MWUpy?=
 =?utf-8?B?R2k5ZG41cmFKR1FOR3pXVnFRMU5oYWsxNUJRT3lNNUxaOGdOL1l0NjFHaEs4?=
 =?utf-8?B?cng1dkFhUm8rYWtWc21GN2xmN1NkMWNUZDZwcVd4bmpZT05xVFJRYVI0a21Y?=
 =?utf-8?B?eUVCVkNhRVZIQWNqTDJVQThBdXBJbnVNekEwRDlOaUxPUTlRZ0tsOTR6a2d1?=
 =?utf-8?B?MjBkeXdtRWwxc2txMDk1R2hFbW92WTgvQnZCK2tvcjFTeTAvSTdTV0FnZy9M?=
 =?utf-8?B?VXpkRE5wRkRoZzc3T3Iwend5cjdmVWN3ZTF3Um12VWlZaXlnVnRGWTRsbGlC?=
 =?utf-8?B?K0ppR1d0YVZRa2xNeWp6czY2NjJFOUlnWDhtN2dnd2xBdFByMDJoLzRGVnZp?=
 =?utf-8?B?dFNSdGVTT3I5aTJLMWpNM1c0NVk2aE9mbkZxU1k4QmdHdGFITjFXQm1VQVcy?=
 =?utf-8?B?cHBUUlVJc3JVbSs2dHFmMVd4TTFNZ0VqM0hUWWwvRXU0U2VqZm5SRGtqNnRN?=
 =?utf-8?B?bmUvUGtmbmFoNTlud1dhamo2MitjQnJ4ZlpBNWhMZFhjTzRCbnNOcE9oQ0d6?=
 =?utf-8?B?MVlJdmcwZXcrVFY2cjROd1dUeGNkLzVQQnRmQ0ZMNTFpdHRuNy9zSVlQc2dH?=
 =?utf-8?B?V1k1VjVadmxoRERxanBHUjVYUVFBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b3982f-fc46-45b0-6b4f-08dbc4be183e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:41:33.4025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TK0ojZCpeqvyOZ4d7PzLQ9bhtEoRL5oHaG/Vz/2D/D1N8eMHPrXFLWse6s8oWrtXWy6qdw45TE5BqDNwiMM6vEYf3AwrEAU111B82advDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7477
X-Proofpoint-ORIG-GUID: kX3fWom_pA3EcPsHvzdvYQBtvtZusobe
X-Proofpoint-GUID: kX3fWom_pA3EcPsHvzdvYQBtvtZusobe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=manish.mishra@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, NICE_REPLY_A=-1.09, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
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

--------------QMlt4G3P0cjnICQo70DRWojM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 21/08/23 5:31 pm, manish.mishra wrote:
>
> Hi Everyone,
>
> We are facing this issue. I see this conversation was never conversed and discussed issue is still active on QEMU master. Just for summary, the solution mentioned in this thread "temporarily enable bus master memory region" was not taken with the following justification.
>
> "Poking at PCI device internals like this seems fragile.  And force
>
> enabling bus master can lead to unpleasantness like corrupting guest
>
> memory, unhandled interrupts, etc.  E.g. it's quite reasonable,
>
> spec-wise, for the guest to move thing in memory around while bus
>
> mastering is off."
>
>
> There was an alternate solution mentioned in thread, that is to mark PORT_CMD_FIS_RX and PORT_CMD_START disabled forcefully if the bus master for the device is disabled. But there are no further conclusive discussions on this.
>
>
> I wanted to start this conversation again to hopefully get a conclusion for this.
>
> Thanks
>
> Manish Mishra
>
>
> On 10/09/19 7:38 pm, John Snow wrote:
>> On 9/10/19 9:58 AM, Michael S. Tsirkin wrote:
>>> On Tue, Sep 10, 2019 at 09:50:41AM -0400, John Snow wrote:
>>>> On 9/10/19 3:04 AM, Michael S. Tsirkin wrote:
>>>>> On Tue, Sep 10, 2019 at 01:18:37AM +0800, andychiu wrote:
>>>>>> If Windows 10 guests have enabled 'turn off hard disk after idle'
>>>>>> option in power settings, and the guest has a SATA disk plugged in,
>>>>>> the SATA disk will be turned off after a specified idle time.
>>>>>> If the guest is live migrated or saved/loaded with its SATA disk
>>>>>> turned off, the following error will occur:
>>>>>>
>>>>>> qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS receive buffer address
>>>>>> qemu-system-x86_64: Failed to load ich9_ahci:ahci
>>>>>> qemu-system-x86_64: error while loading state for instance 0x0 of device '0000:00:1a.0/ich9_ahci'
>>>>>> qemu-system-x86_64: load of migration failed: Operation not permitted
>>>>>>
>>>>>> Observation from trace logs shows that a while after Windows 10 turns off
>>>>>> a SATA disk (IDE disks don't have the following behavior),
>>>>>> it will disable the PCI_COMMAND_MASTER flag of the pci device containing
>>>>>> the ahci device. When the the disk is turning back on,
>>>>>> the PCI_COMMAND_MASTER flag will be restored first.
>>>>>> But if the guest is migrated or saved/loaded while the disk is off,
>>>>>> the post_load callback of ahci device, ahci_state_post_load(), will fail
>>>>>> at ahci_cond_start_engines() if the MemoryRegion
>>>>>> pci_dev->bus_master_enable_region is not enabled, with pci_dev pointing
>>>>>> to the PCIDevice struct containing the ahci device.
>>>>>>
>>>>>> This patch enables pci_dev->bus_master_enable_region before calling
>>>>>> ahci_cond_start_engines() in ahci_state_post_load(), and restore the
>>>>>> MemoryRegion to its original state afterwards.
>>>>>>
>>>>>> Signed-off-by: andychiu<andychiu@synology.com>
>>>>> Poking at PCI device internals like this seems fragile.  And force
>>>>> enabling bus master can lead to unpleasantness like corrupting guest
>>>>> memory, unhandled interrupts, etc.  E.g. it's quite reasonable,
>>>>> spec-wise, for the guest to move thing in memory around while bus
>>>>> mastering is off.
>>>>>
>>>>> Can you teach ahci that region being disabled
>>>>> during migration is ok, and recover from it?
>>>> That's what I'm wondering.
>>>>
>>>> I could try to just disable the FIS RX engine if the mapping fails, but
>>>> that will require a change to guest visible state.
>>>>
>>>> My hunch, though, is that when windows re-enables the device it will
>>>> need to re-program the address registers anyway, so it might cope well
>>>> with the FIS RX bit getting switched off.
>>>>
>>>> (I'm wondering if it isn't a mistake that QEMU is trying to re-map this
>>>> address in the first place. Is it legal that the PCI device has pci bus
>>>> master disabled but we've held on to a mapping?
>>> If you are poking at guest memory when bus master is off, then most likely yes.
>>>
>>>> Should there be some
>>>> callback where AHCI knows to invalidate mappings at that point...?)
>>> ATM the callback is the config write, you check
>>> proxy->pci_dev.config[PCI_COMMAND] & PCI_COMMAND_MASTER
>>> and if disabled invalidate the mapping.
>>>
>>> virtio at least has code that pokes at
>>> proxy->pci_dev.config[PCI_COMMAND] too, I'm quite
>>> open to a function along the lines of
>>> pci_is_bus_master_enabled()
>>> that will do this.
>>>
>> Well, that's not a callback. I don't think it's right to check the
>> PCI_COMMAND register *every* time AHCI does anything at all to see if
>> its mappings are still valid.
>>
>> AHCI makes a mapping *once* when FIS RX is turned on, and it unmaps it
>> when it's turned off. It assumes it remains valid that whole time. When
>> we migrate, it checks to see if it was running, and performs the
>> mappings again to re-boot the state machine.
>>
>> What I'm asking is; what are the implications of a guest disabling
>> PCI_COMMAND_MASTER? (I don't know PCI as well as you do.)
>>
>> What should that mean for the AHCI state machine?
>>
>> Does this *necessarily* invalidate the mappings?
>> (In which case -- it's an error that AHCI held on to them after Windows
>> disabled the card, even if AHCI isn't being engaged by the guest
>> anymore. Essentially, we were turned off but didn't clean up a dangling
>> pointer, but we need the event that tells us to clean the dangling mapping.)
>>
Hi Everyone,

I would appreciate some response on this.  :)

Thanks

Manish Mishra


--------------QMlt4G3P0cjnICQo70DRWojM
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 21/08/23 5:31 pm, manish.mishra
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:16bffa8e-aeb5-187d-ada8-8cf954782528@nutanix.com">
      
      <p dir="ltr" style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;" id="docs-internal-guid-95bfb0c6-7fff-8be7-dee5-ab656b644e9a"><span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">Hi Everyone,</span></p>
      <p dir="ltr" style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">We are facing this issue. I see this conversation was never conversed and discussed issue is still active on QEMU master. Just for summary, the solution mentioned in this thread  &quot;temporarily enable bus master memory region&quot; was not taken with the following justification.</span></p>
      <p dir="ltr" style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">&quot;Poking at PCI device internals like this seems fragile.&nbsp; And force</span></p>
      <p dir="ltr" style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">enabling bus master can lead to unpleasantness like corrupting guest</span></p>
      <p dir="ltr" style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">memory, unhandled interrupts, etc.&nbsp; E.g. it's quite reasonable,</span></p>
      <p dir="ltr" style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">spec-wise, for the guest to move thing in memory around while bus</span></p>
      <p dir="ltr" style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">mastering is off.&quot;</span></p>
      <br>
      <p dir="ltr" style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">There was an alternate solution mentioned in thread, that is to mark PORT_CMD_FIS_RX and PORT_CMD_START disabled forcefully if the bus master for the device is disabled. But there are no further conclusive discussions on this.</span></p>
      <br>
      <p dir="ltr" style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">I wanted to start this conversation again to hopefully get a conclusion for this.</span></p>
      <p dir="ltr" style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">
</span></p>
      <p dir="ltr" style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">Thanks</span></p>
      <p dir="ltr" style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">Manish Mishra
</span></p>
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 10/09/19 7:38 pm, John Snow wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:a4a39c82-e5bc-71e9-28e8-25a0c68e2d6e@redhat.com">
        <pre class="moz-quote-pre" wrap="">On 9/10/19 9:58 AM, Michael S. Tsirkin wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On Tue, Sep 10, 2019 at 09:50:41AM -0400, John Snow wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">On 9/10/19 3:04 AM, Michael S. Tsirkin wrote:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">On Tue, Sep 10, 2019 at 01:18:37AM +0800, andychiu wrote:
</pre>
              <blockquote type="cite">
                <pre class="moz-quote-pre" wrap="">If Windows 10 guests have enabled 'turn off hard disk after idle'
option in power settings, and the guest has a SATA disk plugged in,
the SATA disk will be turned off after a specified idle time.
If the guest is live migrated or saved/loaded with its SATA disk
turned off, the following error will occur:

qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS receive buffer address
qemu-system-x86_64: Failed to load ich9_ahci:ahci
qemu-system-x86_64: error while loading state for instance 0x0 of device '0000:00:1a.0/ich9_ahci'
qemu-system-x86_64: load of migration failed: Operation not permitted

Observation from trace logs shows that a while after Windows 10 turns off
a SATA disk (IDE disks don't have the following behavior),
it will disable the PCI_COMMAND_MASTER flag of the pci device containing
the ahci device. When the the disk is turning back on,
the PCI_COMMAND_MASTER flag will be restored first.
But if the guest is migrated or saved/loaded while the disk is off,
the post_load callback of ahci device, ahci_state_post_load(), will fail
at ahci_cond_start_engines() if the MemoryRegion
pci_dev-&gt;bus_master_enable_region is not enabled, with pci_dev pointing
to the PCIDevice struct containing the ahci device.

This patch enables pci_dev-&gt;bus_master_enable_region before calling
ahci_cond_start_engines() in ahci_state_post_load(), and restore the
MemoryRegion to its original state afterwards.

Signed-off-by: andychiu <a class="moz-txt-link-rfc2396E" href="mailto:andychiu@synology.com" moz-do-not-send="true">&lt;andychiu@synology.com&gt;</a>
</pre>
              </blockquote>
              <pre class="moz-quote-pre" wrap="">Poking at PCI device internals like this seems fragile.  And force
enabling bus master can lead to unpleasantness like corrupting guest
memory, unhandled interrupts, etc.  E.g. it's quite reasonable,
spec-wise, for the guest to move thing in memory around while bus
mastering is off.

Can you teach ahci that region being disabled
during migration is ok, and recover from it?
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">That's what I'm wondering.

I could try to just disable the FIS RX engine if the mapping fails, but
that will require a change to guest visible state.

My hunch, though, is that when windows re-enables the device it will
need to re-program the address registers anyway, so it might cope well
with the FIS RX bit getting switched off.

(I'm wondering if it isn't a mistake that QEMU is trying to re-map this
address in the first place. Is it legal that the PCI device has pci bus
master disabled but we've held on to a mapping?
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">If you are poking at guest memory when bus master is off, then most likely yes.

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Should there be some
callback where AHCI knows to invalidate mappings at that point...?)
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">ATM the callback is the config write, you check
proxy-&gt;pci_dev.config[PCI_COMMAND] &amp; PCI_COMMAND_MASTER
and if disabled invalidate the mapping.

virtio at least has code that pokes at
proxy-&gt;pci_dev.config[PCI_COMMAND] too, I'm quite
open to a function along the lines of
pci_is_bus_master_enabled()
that will do this.

</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Well, that's not a callback. I don't think it's right to check the
PCI_COMMAND register *every* time AHCI does anything at all to see if
its mappings are still valid.

AHCI makes a mapping *once* when FIS RX is turned on, and it unmaps it
when it's turned off. It assumes it remains valid that whole time. When
we migrate, it checks to see if it was running, and performs the
mappings again to re-boot the state machine.

What I'm asking is; what are the implications of a guest disabling
PCI_COMMAND_MASTER? (I don't know PCI as well as you do.)

What should that mean for the AHCI state machine?

Does this *necessarily* invalidate the mappings?
(In which case -- it's an error that AHCI held on to them after Windows
disabled the card, even if AHCI isn't being engaged by the guest
anymore. Essentially, we were turned off but didn't clean up a dangling
pointer, but we need the event that tells us to clean the dangling mapping.)

</pre>
      </blockquote>
    </blockquote>
    <p>Hi Everyone,</p>
    <p>I would appreciate some response on this.&nbsp; :)</p>
    <p>Thanks</p>
    <p>Manish Mishra<br>
    </p>
    <p><br>
    </p>
  </body>
</html>

--------------QMlt4G3P0cjnICQo70DRWojM--

