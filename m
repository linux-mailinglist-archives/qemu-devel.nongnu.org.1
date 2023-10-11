Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDFF7C5D9A
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 21:23:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqenN-0004Ob-Ew; Wed, 11 Oct 2023 15:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qqenK-0004OQ-8U
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 15:22:58 -0400
Received: from mail-dm6nam10on20607.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::607]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qqenI-0003mx-8l
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 15:22:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3eElDWhxlmQNIogcgrDdDCMGN5mG5MG/bcYE6R1wPr/PQbOquE+/eP8SdyLQssVXjSTRzfYiSC0YkbvFzlPalA0xQluhexD74vkcjhwoFZ7mchzdtf+kPlkModO29zzn7SgFLglQnVD6xjgFyNDyjwIa4LTwdk6irQb5CPDGmikPvwC46jU3rFqme1yxCrrIzN/XAE5mAbJqlpgwV1R7LXbQsOvrwV3beRJJdpylTdpPyQeK5HMSzaBy6a0ICppFpDZCN8KC2ATATG7adAhHswsgVGYLJ9cdGAPyYTXia/KVresJw992PUfjVlm6XdLbH5jd59KY0Qpy0tMOo+taQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/zdLAnYr2S+oFnK3Dr/ush+SMh9yw9R3bHcdA+T7uk=;
 b=Y+rDDHdNDMrTHJvKZ+dGkyMYiybU9JvRs8/79w40iHZsd061n3mCcLL0cjJTPT9NRCqqtIfqrdSiO4LyzN+czBvImU0XPf4wjc5S1uBjxUFqGLKnNqCVyYizapA1VMGn3lmY34LvcZ5sEVnqzt9XFXlJ0UKQzXWrTdnnfMEIHqddi+N9UsBlKTRLq7urUgWa2o8LkmEXQ0Dwo7fAtes60B2MCIvko1MKD3OFequeI86ZsJdMStzW9X+FmQzOchIMjGeSM+uo5IwOBPa1BNXRiWqOzOMBKMukFYfMr2ct9Eponfi/KKmjazmONS1K/fDMkMjxmFARGuRm9ApR0jhLzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/zdLAnYr2S+oFnK3Dr/ush+SMh9yw9R3bHcdA+T7uk=;
 b=Wr03pOMiDBE/7JHFvScirXZLa+zJrShXjuj6lgIyRs7CWIcgW7kdNjX0GTBvHnl4fCRZRwMnDnOQIAoFuDaMeQniRekbHa8R49ghAIBoe86QKUqpidXyoeBi/3cDiUxLHattkaCXqFIptEm6t0vxSSBeWPfUj7g3hKJ1QKydJtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 by PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 11 Oct
 2023 19:22:48 +0000
Received: from MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::7c95:99c7:7f5f:c24a]) by MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::7c95:99c7:7f5f:c24a%4]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 19:22:48 +0000
Date: Wed, 11 Oct 2023 12:22:46 -0700
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [QEMU][PATCH v4 1/2] xen_arm: Create virtio-mmio devices during
 initialization
Message-ID: <ZSb2BlxYGOfbshqq@amd.com>
References: <20230830043518.21584-1-vikram.garhwal@amd.com>
 <20230830043518.21584-2-vikram.garhwal@amd.com>
 <9f3aad26-0233-4987-9fb0-cfcf8d424ef4@perard>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f3aad26-0233-4987-9fb0-cfcf8d424ef4@perard>
X-ClientProxiedBy: SJ0PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::33) To MW3PR12MB4409.namprd12.prod.outlook.com
 (2603:10b6:303:2d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4409:EE_|PH7PR12MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: b172ed97-308e-4de9-c486-08dbca8f7471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qUsHP84tvYEE2JgSC2OpyL8J9WiIDeA9DHQlwOU40camKqc7nniqZhdIHVLXNCDCTwGCRpGe+qjb+lsGm+7lXKlTC2u/oSRTPIBn3rlGK4dnmJ78E9GRpATQWlfm5xk0ITx0JqI5qOycWziRXgFUM9Cmew6VW8j5ZVVyWvJ9KVEwivhQTcJ0voaAsgOmoKxnkzHkCEMqxMe4HLxHvB47hYp+1QwQGYUzI+KWnYJGXa4bw73lcSxA3GnwsA51IxNLUDgihY8wB5CKGVCuPEUSs5Y0vo9XwlElO2P8zfuER0dMBlbkSRV8Vya66P0Yt27LvGQNEJKPe1XmslkkeWKE4fTqoMZ2KjdR99JkeiuytLAs/RAWs0n4NIt/tnsob6Xpq6Knkluqc8KPfKTTyRuLLpcsVE8xbodtPeHDCC1KK+5pa4Jhy6vrSOJ4vo7MNVAUGe+MRcuXIVVz1zPniexSwkrQVVseDz5OoNogZDQFgAfF0unYJY9qcuRtsrNF3JJroKBNkZtwzkeS7Mndtbh3v1Xt9YSGnzmoYCTJwOfozBSg37jc9Ub88i7Xy6Ru8bvB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4409.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(41300700001)(6506007)(2616005)(6512007)(316002)(36756003)(86362001)(478600001)(44832011)(38100700002)(2906002)(66556008)(8936002)(66946007)(26005)(4326008)(5660300002)(8676002)(66476007)(6916009)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzVaU3RIMWdFVU1nanBYNW9NRDF1Zng0RUNFNDB4QnZlUUhRUC9ZdnFOd1dp?=
 =?utf-8?B?U2dLWU9oR1lGNDlaQnB4SXk1c3JadE1BYjhhSlhvQm41a0pTZTAzSW5lMWlm?=
 =?utf-8?B?anhsRkd4SDJ4enpkRnc3bVhVMWEvV3JaK2Z6TmNMSXB4eVFZMWpPekM1TVl0?=
 =?utf-8?B?aG40eVpSVGJ6K0gzQWxPa0tnR01XVVowOGlDWXJnb0NoOXozZ2VYbFJiWThT?=
 =?utf-8?B?NkxScENJdDV5aXZkVUt0eEJTT1Rid1JGMTZGd0dReDE1WVEvcm5XU3lvSlh5?=
 =?utf-8?B?OFZzaGprMzFoQ1VicEIrSFJMMmZnSzlZQXJGZ2RaR2pDV1pHczVKSVZxSmda?=
 =?utf-8?B?YnB5R0ZoMUw0NmExOElnY0xxdUh3VXFzUXgzeUxrYXJ2TWRFV0dRR29LcFBo?=
 =?utf-8?B?R2R5dURUYVdEQitaMFVLYllhbEkrZmQyekg1UHovLy9PazY4MCtwbE5QMjlQ?=
 =?utf-8?B?akIvdDJFMHZtVjNubFRoMkU3R1dCM1k4Q2hVK2d4ZzJVSzlXUjNraTdWN2dW?=
 =?utf-8?B?NUlKU05rUWExc0p5MkhBdzZPUk5VSjhHanRWV0d0ekxzNjBTSVE1UGhoQ2ZN?=
 =?utf-8?B?bHE3V2NLcmt1eVZMV1lUN0NBNzlsUmpMUFJiRTZGK3JMZWZ1bjFjYVRwZGZw?=
 =?utf-8?B?Ni9FNjF0R0V3NVkyVXF3WXd0eVpJTFE5NFRkUDZDUFkwc1BDc2diMEFxTk5N?=
 =?utf-8?B?ZEtNRkJvYkV5WWNzTzY2UGVSck9leElCNUMzUlFkbU43dkswVkd2bEIwV1Vv?=
 =?utf-8?B?SnlxSGRGekJocFplMlhBaHVZNWxuaFhNb2ViMEdwY0QzLzA2NFNzd2pIZFdo?=
 =?utf-8?B?N3NKL3JrNU02S3IrRXJzZVpsaW01S2VlaUllam5tUk0xR3FuMmZPRWM5Rjc0?=
 =?utf-8?B?OWt0QkhzMzljejhRR3h4bmY2M1RFSnpFbDNySnR3dmhIVU9GUGdtWXpwelNE?=
 =?utf-8?B?R2FZOHNUcUp2cVpKejJtazJDWGxwYWFGbkh6SS9nV1gvM3RaOUtiWC8zSTQr?=
 =?utf-8?B?R0xGNGQ3N1gzU1h5U1RoQjdIWW1ZZVB6aU1LV3YyRVdCWEtEdHZ4Uy93RzJp?=
 =?utf-8?B?UFpHcllEbExBSm9uQkhROVF4Y3diUlFmcmlueERUMDBDSnpmOFhFM0p0Vkor?=
 =?utf-8?B?S3dHRW9PVGFBanN4aW5ydnBxaTBkVS9yTWlBbHJJeUFOdXZQZ3ZiZkg0SUVo?=
 =?utf-8?B?ekxEQ0FMQmJEcFZNUm9mWC84bUdUaGwzWHBrNGJZVjZZVDV2bDI5N2ZSWTRB?=
 =?utf-8?B?aEprcE9FYmlCUHprUSs3Njh5ZTc1NmoxVk9rcmJyRE84SEliNGhsVjZvSmJz?=
 =?utf-8?B?cXd4MEFaNUF2cFBDVkRpallZSkM3dXhuQ05UOGZQV3FKMzkwTTZ4VWlXbThB?=
 =?utf-8?B?RU5tS1FLQ1Mvbnh4T3lQSFpjbG9TelFUZXdRUFMyR3FEQ0VMc2dOdlU1cCs4?=
 =?utf-8?B?RlV6T3F5ZHdGbXFDaVZpcHZTZEJUR09qL21kTEk4bFBNMlNCV3VVZnRremlU?=
 =?utf-8?B?dU5tcUdYTzdtVnJ5QzBDck5GRnlDZVlKYXhZWHYrSmp4djJZdTEybnBZclFs?=
 =?utf-8?B?TlNmZE8yR2lQTEJoMWRvZXZJU2x5NGtuK2JSVDgwSng3MXBWam03K0NNMG1o?=
 =?utf-8?B?NU5GVzJldzFUMmdRanI1YUVmWmVPSlhXQ1czak52aEdoRU5TZFNCdUF2aG9r?=
 =?utf-8?B?bmpaODFjMVJkZTZ1b2EvRStWcWxMU3YzaVZzd2FDOC8vRW51TWNmODFXM2tz?=
 =?utf-8?B?dGhJcXd6WkVncEI0M0ZqZnNQR0E4L2NkYTN3N3BnUEhhRi95T0F3WkVCZ1JD?=
 =?utf-8?B?M3A3SnZsaDB5ZjdvaFlOSVFlL2h6UnlCYUdPYlRQTTBEaHNSay9oUk43VUha?=
 =?utf-8?B?WjRuRlhVTFNJbFZ3eWdSMGhZN2dkdEVNWWIyR2k2b0x5TTYwUVNkelBrN2N1?=
 =?utf-8?B?MU51Wm9ZeS9nVVRxR2dsSGVqYkhGRkZYSUxoK3Y3d3FUOXFNMnFFRzlpbjFS?=
 =?utf-8?B?SjBCbVJsUkFtNHVhdy9BVHhDSzljSWFxREg2ZFlHUlFQSlN5citLVnlub1pF?=
 =?utf-8?B?dENGRVQ3aUFzZzEvckg4bUU2OVo2UHBGdXY5R0xybnpHRkZtaUY5QVFYRWFx?=
 =?utf-8?Q?YQe8Pc4dDd21DnNeKiCMysEDl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b172ed97-308e-4de9-c486-08dbca8f7471
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4409.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 19:22:48.7325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlgGWTdN1Kk6HMgtDTviFg9QF+0THxepk2W3c/gK1YtbRvHbLEp4JNE7dP3B4sSNrpmfiYi8Q6sZbm4fb/Dp7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393
Received-SPF: softfail client-ip=2a01:111:f400:7e88::607;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Anthony,
On Thu, Oct 05, 2023 at 11:40:57AM +0100, Anthony PERARD wrote:
> Hi Vikram,
> 
> This patch prevent QEMU from been build with Xen 4.15. See comments.
> 
> Also, why didn't you CC all the maintainers of
> include/hw/xen/xen_native.h?
I missed it. Initial version didn't have this file change and i missed updating
my cc list.
> 
> On Tue, Aug 29, 2023 at 09:35:17PM -0700, Vikram Garhwal wrote:
> > diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
> > index 4dce905fde..a4b1aa9e5d 100644
> > --- a/include/hw/xen/xen_native.h
> > +++ b/include/hw/xen/xen_native.h
> > @@ -523,4 +523,20 @@ static inline int xen_set_ioreq_server_state(domid_t dom,
> >                                                   enable);
> >  }
> >  
> > +#if CONFIG_XEN_CTRL_INTERFACE_VERSION <= 41500
> 
> xendevicemodel_set_irq_level() was introduced in Xen 4.15, so this
> should say '<' and not '<=', otherwise, we have:
>     include/hw/xen/xen_native.h:527:19: error: static declaration of ‘xendevicemodel_set_irq_level’ follows non-static declaration
Thanks for spotting this.
I will create a fix and gitlab-ci for the patch.
> 
> > +static inline int xendevicemodel_set_irq_level(xendevicemodel_handle *dmod,
> > +                                               domid_t domid, uint32_t irq,
> > +                                               unsigned int level)
> > +{
> > +    return 0;
> 
> Shouldn't this return something like -ENOSYS, instead of returning a
> success?
Changed return to -ENOSYS for older version.
> 
> > diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
> > index 1d3e6d481a..7393b37355 100644
> > --- a/hw/arm/xen_arm.c
> > +++ b/hw/arm/xen_arm.c
> > +
> > +static void xen_set_irq(void *opaque, int irq, int level)
> > +{
> > +    xendevicemodel_set_irq_level(xen_dmod, xen_domid, irq, level);
> 
> So, you just ignore the return value here. Shouldn't there be some kind
> of error check?
> 
> And is it OK to create a virtio-mmio device without an error, even when
> we could find out that it never going to work (e.g. on Xen 4.14)?
This is something Oleksandr can answer better as it was written by him. But
I think we can print an error "virtio init failed" and exit the
machine init. Does that aligns with your thinking?
> 
> Cheers,
> 
> -- 
> Anthony PERARD

