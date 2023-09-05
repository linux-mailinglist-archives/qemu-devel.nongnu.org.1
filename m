Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E897E7923C0
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 17:05:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdXau-0005JB-Vf; Tue, 05 Sep 2023 11:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qdXas-0005In-75
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:03:54 -0400
Received: from mail-co1nam11on2060c.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::60c]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qdXap-0007Dj-7d
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:03:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUBYLWxv7/68jsH/pLiUuBTIXzFbcWvPs6FAi+T+UJ0H+a1cMPvctyZfu2r/tZqlnIhqAIKjogOoOJmeRDsOdBtgfxK7AwKmQMDoeCLf5RsPFvTYSPdp8EXv2iMXtEY4i7CePXTdRxyJZ8hM3+IkY9pMgPU/0md9qW7j1gizT48N+GE2rrTRhNdH1U/qW7x/gSdMWJmOd7fZnVntmer+Xv7xMsl74ToEjq8ghFbm+1K6dpLYT10klliEpB5QLMipf4Y7yT+noe2WD48cnjvWTBOquo3DBbipmzOriHkWUHTVcysy9pSQlgJ7bMbux358dJDkJYEnJdFUVe72kO4eTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pksGBLGeoYDwRcIB//7mxYd0qD2sBBa4KjX63QJUwY=;
 b=HdSefE9dKy83PXwPKj08s4AyDBhdDx1uizunu7QuDMW6kVnlP6efqyRVBVdE9C9UWMTaUisYNeB/bpKQuuUHrsu0PZm/DSh9lLysv3SHpwOZy0tUqyT7YDCrM4Bq/rUZ2x3tnHyE6t90V6vpZTV7OFs1fhs8HOulf9GIjc2fg/lI028mRbq9sAQZADTjNwl3HNgb5fsC8vvOUax4rduTGLIp1qLgvcobeyX9mH0ARULi3bya4dh/B4EdHOtsY+D24H/g/cs4wNC3uXPDeSAEzSAmct7sjdslvBl/eWMD8bHdUJeax6k+B4BkxQCQ20Pv/KsWyM3+gRIraEGV+vdStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pksGBLGeoYDwRcIB//7mxYd0qD2sBBa4KjX63QJUwY=;
 b=4HwYxj4G6kUrEjxWvAhSqphm2SxLaA5iwmLlsQyCt8tC8YVklljb7vanOEgX20m89dCrSSR1wpsyIeBCFZAfafC6jepn5axOq55aSB1+TCBrIjf3Mm9Qp0IrLiYXmRXVO/Uf7N7OOMGHtA53jQe4WcU/3pFSZW4KjpeQvugOtm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 15:03:45 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::1be:2aa7:e47c:e73e]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::1be:2aa7:e47c:e73e%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 15:03:45 +0000
Date: Tue, 5 Sep 2023 10:03:38 -0500
To: William Roche <william.roche@oracle.com>
Cc: qemu-devel@nongnu.org, yazen.ghannam@amd.com, michael.roth@amd.com,
 babu.moger@amd.com, joao.m.martins@oracle.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
Subject: Re: [PATCH v2 2/2] i386: Fix MCE support for AMD hosts
Message-ID: <ZPdDSgbypubTzGuZ@johallen-workstation>
References: <20230726204157.3604531-1-john.allen@amd.com>
 <20230726204157.3604531-3-john.allen@amd.com>
 <954cbf1f-0cc5-1dac-1e0f-d0203df08863@oracle.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <954cbf1f-0cc5-1dac-1e0f-d0203df08863@oracle.com>
X-ClientProxiedBy: YQBPR01CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::9)
 To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: c49edd2e-e54a-4efd-9dfa-08dbae214ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cEeXDTtYfTsy5LRISYH1LfZ6ZrJXqKnigd6eN3Tr9J/ZSM5FRhsNPI7GBViJeIWE3KcCQbU3kduuI9rTQYms719xbp5qRSjBwRNcyEqNZftDtZVav3P66Yd34dNW95oastJzWRkKAikTMqDzQx5CkgaAsUizTsOmZA9kHE11TDVmArJbjq2PB/JXPYcrgEEEGSJf7DDLGueWUIUfo2zm40pAxWplkWSpcoPihWqOkM1vnJu3EacXeZcyLMEDfd3bHdJyi0sHwseyS6IdHO5VacuiDaMIDkNTL0qm46eY3wOHN70Doc/a1oEnmwvjoVMQq1loPfS+D140u3Elien4YXdZMF9XjpuT14HPD5ZVa25IKHIepiFplnUZpwDFqgdOg9J9Q470o5CrsGv5YIHSyGJkjJJmg699z6bAgA4rR92P69RJRzqAjTWGDll/5mz/W8BYRtkCZvqg2omLmOLMxavCghleP/R1TBacqpN8O5i8RMxFEafQYisaQWOXl4KGsnKBkBw+n4Q8MV++5YgwZ6GF/IcHB0Csh/ghLu4r8rwhZxCFkrZaxm9hImHH05qz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5995.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199024)(1800799009)(186009)(66476007)(66556008)(66946007)(86362001)(33716001)(41300700001)(316002)(6916009)(9686003)(6512007)(26005)(44832011)(53546011)(6486002)(6506007)(4326008)(5660300002)(8936002)(8676002)(6666004)(478600001)(38100700002)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?xDTNq9Gw6YJ1or2sWpviqeBxspMB+qdXY6EmJ9XyvGgXVEqQWd7eqnLExv?=
 =?iso-8859-1?Q?1uiIbCq0EHRePY92hNiXJG1mFa/vxcTVsIQj1AoYfTzUgYvVdOimVb16EF?=
 =?iso-8859-1?Q?tO4SkA3Uz420BEqUf1Qb0h0ZEeDtJI4bG24OoJr7LQO+pn++2Z/KLtMjpL?=
 =?iso-8859-1?Q?4uJU7xEnsxuWdq33y06+UUgwhc3shaS2H1YA3KN9StXXft5Ou/H9B6PrfU?=
 =?iso-8859-1?Q?Xg5TRZ7GLqYN25tAUZEiLZVpEAU2jtEy9l3FyCSFdrwfEBToSvFXZJlHWu?=
 =?iso-8859-1?Q?siSGyVorNKtLuEbqPGTlFr2FEpn5/MECo0PUfmi5WgKGtBTp/h3H1W24Uv?=
 =?iso-8859-1?Q?bEfRcIKIjsJ0DlI75jf8kOwLTW79An/fJCaTRcJwhCBDoqjKuK7suTglZK?=
 =?iso-8859-1?Q?GtAp1aaH7xkxHajSR3qXUI4pxwKCPPgJ9Smz8WOreTePQmdjjVtxN6Ia2b?=
 =?iso-8859-1?Q?ChkcpHB6NssSPvxTwM9aGPLjyHa9UgGV/X7vr1WAjN4yq9FygH6Qdlp9PB?=
 =?iso-8859-1?Q?07qAk4lR0Ug5Ndf9yGJuN+bbWNKnpP+4bAtHOPvbra+iiStSHYPHvwkj2R?=
 =?iso-8859-1?Q?Wqph6eTB+Ml1IoFIb+RRaRcHyua/EpE/0ngSYEO5hXfS/jHAQ+Rr4ASjPV?=
 =?iso-8859-1?Q?Boztdda/xQW7JbcNgsQweJ7lTxlEuG5rLuWBJXQTHjdVgoDsytrwjaRxeD?=
 =?iso-8859-1?Q?YRSDJQXWUBVeYohHEVFJr5NcIYaEv2QVObbyUsX9ZR7U7ITcxLXhMBwEqi?=
 =?iso-8859-1?Q?MojmebVSEIkZm3Tl8HSqlGxEayaS2EKr3FJOtrh+uIxiJRzmJTyD9uAP81?=
 =?iso-8859-1?Q?2maGcpVCi/wCrXMB2+28GAPex98BiQBRmFqeZ+90zHOHpyvaMcX80OfS92?=
 =?iso-8859-1?Q?2Keh/uI+BFhFOFThjDxq3UwGFZHZjJDEltvy2n6D37Iwvj+dzK4jq32MOU?=
 =?iso-8859-1?Q?gckIODnFxBb7dl7TA7V1wxIsC1PTKroyMvii8neKG3eh/T8dt+d8un+cKs?=
 =?iso-8859-1?Q?YCSkg3rNAMO2/Fe/vj10kzvBHg9JT1J57GuiqcrOV2dv4E5omGgSXsg8vZ?=
 =?iso-8859-1?Q?YMYAifqNYdI63P8tTe1vJ2RJ//R+xIci+919R+Ksek2YzI6qm5te/iQG8u?=
 =?iso-8859-1?Q?9mZtZje6TepRPN66XT2M20jwDlt0XXYAjB+CjmxKHxKodvitA57w6MVt0d?=
 =?iso-8859-1?Q?QlBwbNtygcSKgXo8DtMWFvCM2/o8XdiJ6gBpqEOdOKv+lEQrhlqX3znvVA?=
 =?iso-8859-1?Q?PByqUvePvwXeU4mUY3eaU8GFp60wlg1K0D6AkW2aBZxSZyNe49a1V6aixA?=
 =?iso-8859-1?Q?vmsDWTHhEId/dNDFfrtBqs7eWHmYGAoOiUxGGFfsLFMwQbOlkw0kzv4I/H?=
 =?iso-8859-1?Q?ghd06vwoRE8P6kr9Df74ZVUIbpigQ9/eJMaNNrs3okk3hXUfvygEGyyn4+?=
 =?iso-8859-1?Q?ntamPTMg4QLZCfGz2afpY78/+xzjxgpUbCFXlHBeAMSGGOK6GACvcW4Pbb?=
 =?iso-8859-1?Q?HL9wjZYkvqDnu8Az7lrog3/XPshVe0E4lRvrtTJROL8l1bfKzq0+vEOZfT?=
 =?iso-8859-1?Q?D088yflvyrKSiz9wKKPCtIxBkhs63eIKgmecdJ9azXrvSEpxw0rK4pElZE?=
 =?iso-8859-1?Q?r1TcpesMcUejhNSP7X3iLS0bFOXE5awyuq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49edd2e-e54a-4efd-9dfa-08dbae214ccb
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 15:03:44.9847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfszqN7oslP43YtCqnIg/QA7DwbgLAwBj20dWhocrEgcCkRa0qSa1bwKFZT66IPczn1Jlggx9zopWs8MczJgXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930
Received-SPF: softfail client-ip=2a01:111:f400:7eab::60c;
 envelope-from=John.Allen@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  John Allen <john.allen@amd.com>
From:  John Allen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Aug 31, 2023 at 11:54:56PM +0200, William Roche wrote:
> John,
> 
> I also noticed something important about this specific code:
> 
> Qemu commit cb48748af7dfd7654323eb839d1f853ffa873652 introduced the use of
> the MCG_STATUS_RIPV in the case of a BUS_MCEERR_AR error, but it looks like
> your reference code is not having this flag.
> 
> According to me, we should keep this flag in the case of a non-AMD machine
> with a BUS_MCEERR_AR.
> 
> The patch should look something like that:
> 
> [...]
> -    if (code == BUS_MCEERR_AR) {
> -        status |= MCI_STATUS_AR | 0x134;
> -        mcg_status |= MCG_STATUS_RIPV | MCG_STATUS_EIPV;
> +    if (!IS_AMD_CPU(env)) {
> +        status |= MCI_STATUS_S;
> +        if (code == BUS_MCEERR_AR) {
> +            status |= MCI_STATUS_AR | 0x134;
> +            mcg_status |= MCG_STATUS_RIPV | MCG_STATUS_EIPV;
> [...]

Yes, that looks correct. I will fix this in the next version of the
series.

Thanks,
John

> 
> 
> Cheers,
> William.
> 
> 
> On 7/26/23 22:41, John Allen wrote:
> > For the most part, AMD hosts can use the same MCE injection code as Intel but,
> > there are instances where the qemu implementation is Intel specific. First, MCE
> > deliviery works differently on AMD and does not support broadcast. Second,
> > kvm_mce_inject generates MCEs that include a number of Intel specific status
> > bits. Modify kvm_mce_inject to properly generate MCEs on AMD platforms.
> > 
> > Reported-by: William Roche <william.roche@oracle.com>
> > Signed-off-by: John Allen <john.allen@amd.com>
> > ---
> >   target/i386/helper.c  |  4 ++++
> >   target/i386/kvm/kvm.c | 17 +++++++++++------
> >   2 files changed, 15 insertions(+), 6 deletions(-)
> > 
> > diff --git a/target/i386/helper.c b/target/i386/helper.c
> > index 533b29cb91..a6523858e0 100644
> > --- a/target/i386/helper.c
> > +++ b/target/i386/helper.c
> > @@ -76,6 +76,10 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env)
> >       int family = 0;
> >       int model = 0;
> > +    if (IS_AMD_CPU(env)) {
> > +        return 0;
> > +    }
> > +
> >       cpu_x86_version(env, &family, &model);
> >       if ((family == 6 && model >= 14) || family > 6) {
> >           return 1;
> > diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> > index 4b62138459..87a50c8aaf 100644
> > --- a/target/i386/kvm/kvm.c
> > +++ b/target/i386/kvm/kvm.c
> > @@ -532,16 +532,21 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
> >       CPUState *cs = CPU(cpu);
> >       CPUX86State *env = &cpu->env;
> >       uint64_t status = MCI_STATUS_VAL | MCI_STATUS_UC | MCI_STATUS_EN |
> > -                      MCI_STATUS_MISCV | MCI_STATUS_ADDRV | MCI_STATUS_S;
> > +                      MCI_STATUS_MISCV | MCI_STATUS_ADDRV;
> >       uint64_t mcg_status = MCG_STATUS_MCIP;
> >       int flags = 0;
> > -    if (code == BUS_MCEERR_AR) {
> > -        status |= MCI_STATUS_AR | 0x134;
> > -        mcg_status |= MCG_STATUS_EIPV;
> > +    if (!IS_AMD_CPU(env)) {
> > +        status |= MCI_STATUS_S;
> > +        if (code == BUS_MCEERR_AR) {
> > +            status |= MCI_STATUS_AR | 0x134;
> > +            mcg_status |= MCG_STATUS_EIPV;
> > +        } else {
> > +            status |= 0xc0;
> > +            mcg_status |= MCG_STATUS_RIPV;
> > +        }
> >       } else {
> > -        status |= 0xc0;
> > -        mcg_status |= MCG_STATUS_RIPV;
> > +        mcg_status |= MCG_STATUS_EIPV | MCG_STATUS_RIPV;
> >       }
> >       flags = cpu_x86_support_mca_broadcast(env) ? MCE_INJECT_BROADCAST : 0;

