Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B99070502D
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 16:06:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyvHr-0002y7-FV; Tue, 16 May 2023 10:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1pyvHh-0002xj-6j
 for qemu-devel@nongnu.org; Tue, 16 May 2023 10:04:13 -0400
Received: from mail-bn7nam10on20602.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::602]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1pyvHd-0006w3-P9
 for qemu-devel@nongnu.org; Tue, 16 May 2023 10:04:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihhR1ojZJUa83Yh+aMNm2AwO5cHZ2xpt/ZNFMYh6uwk3nXUtEMVAylckCrR4d1+u9XobSaqr9pnPe8sLksJ0xZnOq2QYTJow8POx0ekclLfgxevy8aQ1BDyfhQ+DLB7TYZ3q1Iqky8UQWQbzAmQOYlTXfJJoM+rbbkzt4Xxx0yK3jgSFkHkcDl3Ndx0xwNFbK8cnQ0KqdA/p+QRg9jZkRXtOtaqcRy/6eb7KCn4hg3m7c72z+pHnqJf1u8zdLEnezf1eJ3OJRpUYeFXiJjqjmzvhc8i1rtKrMk8CKU/hTpfZk6dBHRLPjcStJGl+LP6InwPYoRZfzoRILpFjbNtNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKeP6GhXLC77+NlmrnFgMurgQP6lbEVR3YXl4KXRWAA=;
 b=EGj5QNKFLvTNT1aGtmh7qpbOJDXOoTBlFbx4j4Ph34sP8wYz0V7KIQJLf36d6Cr55Ed3RfYDa5HxFwtSH6L7lLNI9wmOGXg9gxFyo+UVbm6cScXBXkd52D53KYem1nQk0risEx2JGNjKhiInAgCW8dcLWkIPU7Tb7X+GY1JLVIVStgbGPvcUAq59YHMAZdJrFhVgmH+gxFaqCR7ZpVDK0Ti2M8ciKM6I5MZzhFziQR+pmFVgXDYl+EWRRSrGlk8OJL6MYgzPJZEEhvJOcvvn9Ui4UXtiJNTOy3Iu8ZKPYkMAo1Dgjaz+1NFbC6uX4NpdV1IlsMeKY6ozKAHP+wjnOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKeP6GhXLC77+NlmrnFgMurgQP6lbEVR3YXl4KXRWAA=;
 b=LM5zjUl6egciZnG1oPx59MvqsRpi6OczmUjLXkdObpRGECJu1GNgzv8n6J598QGXsNbBVR/NKHe7/ZbLrpnijRiZ2FQrLVg/kXQfN3uFbAiW1vnrfe2BB+i0+2lFFIEl8MjeNiz/MA8h5s6S0ExaZ/lJNavNr2SqtZ97MZhm/B4mNqKYR+X1DlPdfCcE+U+0zeo5zNU2b9F/NsnlKQC+ajlK1VA8ukrmwKGrBiQ0dqCF41COoFhcEQbeZk+3BAwpJOasKwneTEK8OOpqbB27xcoq6onXbzYYlTL+Nl2imaX1j8xp6Lc+RaPOMGieEo0s1TJzT0A1ASrwz7JOnnIywQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7316.namprd12.prod.outlook.com (2603:10b6:930:50::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 14:04:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 14:04:04 +0000
Date: Tue, 16 May 2023 11:04:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Avihai Horon <avihaih@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v11 05/11] vfio/migration: Block multiple devices migration
Message-ID: <ZGONU2g8nxuvrB3v@nvidia.com>
References: <20230216143630.25610-1-avihaih@nvidia.com>
 <20230216143630.25610-6-avihaih@nvidia.com>
 <e333783cc59647ed93d944b05f12fe68@huawei.com>
 <ZGNwK+6HmM8lPjAU@nvidia.com>
 <c61606fdcb074dc88b29ae459dbdc0df@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c61606fdcb074dc88b29ae459dbdc0df@huawei.com>
X-ClientProxiedBy: MN2PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7316:EE_
X-MS-Office365-Filtering-Correlation-Id: ead5e695-c526-4b28-2b54-08db5616688c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4jd8u/iah7/MZ/v6NKlBRHRKFvbyS6b2EAovHBHT/AtuV3iTmKbMhrj+YypCB+L6n9uG2mOiu+BCh41IEQCWA4PPbHwVfl9CJGnh15mK/Q8g6HQ+o47QLUWB1h93XiKhxHnsStHH8sCisVW1BsDpyc4nmCysN6+q0pP99mUqGv4HPTkKV2Gk/fqaEG9kx4dBsvnKOwSBVrgKSS4/Hj5/E1Cx2zocv/QNbVk30l3+p7Ag7H2jX9rM4uzVsVZGJtQqjyCg9MsgVFKh2V8gJacHQ5wqQe3iI+v3ZmK2csCwzinYg9vGaGBy6cYn8Qk7WWUrzANHUpjCjUtuiYSs2DpkqPaRy0dEEa7Nu3GRe6C2kuwpUMbu/uJ75iQACQzbwtIguBKxlA06kGemD0qs54/g1+cWdlTig0muPunBm5C0+vIC4NdiZJBsNihyllUpAPf6bXO0/NKiRnHtgdUOIsqxEAAphfBU+Fs/ZQ1vLVqd3dSTdcMVSQa7KNN3A+MmrSiTJ2bc5nN8Fww/f0FquOaUe762DZcB8H/fIY8QzurQfL/bwqnizv9Oy2aLV+rI/xv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199021)(66946007)(66556008)(66476007)(6916009)(4326008)(478600001)(316002)(54906003)(86362001)(36756003)(6512007)(6506007)(26005)(186003)(2616005)(6486002)(41300700001)(5660300002)(4744005)(2906002)(7416002)(8676002)(8936002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YJIWQSTCXTtIcFjC6M+vCuCwNSzJf4yxRMASDvByYqnvLGdp5Z099KxnE4D7?=
 =?us-ascii?Q?gBuKqFmJIRA6JVtUhBglxUSzF/BmWWwN68Vj8hpysZ7pxb7qxqEWs+1fHfmb?=
 =?us-ascii?Q?xFis3xnwayHG6ak7tLvb4GtsLRShWxDlTdYifkk6glXY/Kue3hgudZD9QBPE?=
 =?us-ascii?Q?qu6TBTyt2r4PLqiQ/ExYfYHBU5Zbr/Qu+P2/BzkaG7G3TUQdd9HU2d3weXZM?=
 =?us-ascii?Q?PkIPKv/QaXwoZAZbsAYOovLnogJJ8K+nR5ZEVzX4OL7pt6GXPO+MffJJRmOC?=
 =?us-ascii?Q?vKA0EDmFqYHluA6oGgFVjxN1vH0adbjbmNlpQqBlKHxkCHFJ2t8Z+lujQGqK?=
 =?us-ascii?Q?64FOHrP9u378TznTo1nPD7elDY3NqwuqOGhga/xKPTc7oQ3/kpY4B3x/zjaa?=
 =?us-ascii?Q?j8UtOzeufHBhQOCz7E2AMge3zs2et83o/6ABeZ5irhub+ivA4lpwjDqCcSbm?=
 =?us-ascii?Q?WpmWul/7DAIaHyu7+CfmURpCtPMRTpIqHcplQ36Lxa2zTeY0lVDqw8XWYTNi?=
 =?us-ascii?Q?+2Gk9FAIHFsce/IicN9Wztw/Sw/r179QoBavH1dksgaVE+hqsiHo869Bk41u?=
 =?us-ascii?Q?FGvbIL79U2TQGalQETORrgu3abT2A3Pm4kXK9XJQfkAMvTK/iBt1uaHcS+Cm?=
 =?us-ascii?Q?rheVEUU4SAUVGThVPXmmzHmgWuYRZmjlaQj07giZ0ESSTB5hLV1pwSMzr1P9?=
 =?us-ascii?Q?ToNoWvjti/sN62MWqu0HeA5uNCL9TvPtyjlvFT3KP5wphuUIube5IGi6UWkN?=
 =?us-ascii?Q?L8uCfesSeKrVNFx4HZx8Rvqgoq8iyu4pnPEKKC0dwlVz3XtAVK+oKXQuaYqz?=
 =?us-ascii?Q?mcyaAOV9WIlzIvoWzNwIBTy6Kwl+QGRb8DKLFk2uyKGCTPRDo0JY6ZQ4vKbg?=
 =?us-ascii?Q?Hb+J5oTkURwFPoWUSK3LRdKSrJhs6m6IyRZg66nw8jrqif53Vl6de0Rjh3c9?=
 =?us-ascii?Q?j5bJ+8NXmgMfw0/w82y+5VArR4+v5iE01Y0RIxrZVL9eFoFa+TrEHYK04hcp?=
 =?us-ascii?Q?UxLRcCF6ZHA2CmnboWD1wy2XHJQzq1koPV9dbA1gUE5ZfAt8LJhML3OARRwA?=
 =?us-ascii?Q?jZyGHi6EX7kHkuFylUzfp7AM9+D2ted+Cu49W0h/JHicQtAKfFksMdBWTh1w?=
 =?us-ascii?Q?PT9w3ZK5opFA5IEvgCjGkjyJqP9pfYVJg5cRgTTQVav24LitcWy6M3fhJ7SK?=
 =?us-ascii?Q?Ajdc33SsREJaYfIbzRwTX2qu7mTsZwk2KNF6xV+ybmyMKoStri+Bw5Z+32Us?=
 =?us-ascii?Q?CzHs9zn6t6PyzbodoNmt9hYIeqnV3dlf82fDhCBbHuu6Af8YxW94dEpTAlxA?=
 =?us-ascii?Q?mbeQbmu6ndj83Q4VMuG4dVvwph1UiOj7icNzEfLJU0pkVUiwQcv8xCKMPxAj?=
 =?us-ascii?Q?6SELJqPYTQsP2wQIGAMdjtBgMPFAADgj3FUe56ETpCEHyfXccuqqYw+J1kUR?=
 =?us-ascii?Q?SvvRWn/A8DnnfapSlYcjpr/Pb2ZrR0smsEtGazAEA9b3dy7TOuKdNh87O3sV?=
 =?us-ascii?Q?bVZbZO15Kwi5hGE8OspFIeJsh/Hzyd30PiB0hsBTWXVZl0w9+Cx4S0E0vQwc?=
 =?us-ascii?Q?OQYxDSdAJ59lPBaigFq+Z0dohEbaOyNsliefZo4K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead5e695-c526-4b28-2b54-08db5616688c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 14:04:04.8294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzQSAJmyxkP75GVb3jLJvFm39Tnj8D05A4BawVRhKH62KMgVTRy3NWzCvvAIc4Mk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7316
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::602;
 envelope-from=jgg@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On Tue, May 16, 2023 at 01:57:22PM +0000, Shameerali Kolothum Thodi wrote:

> > What happens on your platform if a guest tries to do P2P? Does the
> > platform crash?
> 
> I am not sure. Since the devices are behind SMMU, I was under the assumption
> that we do have the guarantee of isolation here(grouping).

That is not the case. The SMMU will contain an IOPTE with the the CPU
address of the P2P memory and when the SMMU executes that operation
the system does .. ??

Hopefully it responds back with error and keeps going, or it
crashes..

Jason

