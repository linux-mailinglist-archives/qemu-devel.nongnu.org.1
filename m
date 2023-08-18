Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A166780D78
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 16:06:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX05m-0004x3-2y; Fri, 18 Aug 2023 10:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shreyas.shah@elastics.cloud>)
 id 1qWxm0-0006gn-MC
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 07:36:12 -0400
Received: from mail-mw2nam10on2091.outbound.protection.outlook.com
 ([40.107.94.91] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shreyas.shah@elastics.cloud>)
 id 1qWxlx-0000A0-71
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 07:36:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoXL2fir3/lYM1Eslp2qDdYSi7tJjjha98TfPnMB5Gk4PcnrEPcyXsf34sh/FQyFEj9UfRvuuxwi+Esxjz2lWglCsdLazt5KTI+d3VI6ES3wZpV1jJNN7UuPVfCS02+m57Vz9FZs1UEd0NKbrBTOCwls39xtMN/FG4T6e/ephD3LcxqZTPYxyDD728S6Cex+A0sZEmumWIULP6nS+QIn4ijIOScjDk5p9WgL6JDR+jHbvnpfNBYIosgcIrjSj0LP3mC7QTlPz/MRrQbQnrRKpLk/7eX3lHwHOVd77RrakMX3by6tbbI0Pi0kXwAMNHHT9wOnmr04VFZtmVC0WvfCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhJvmXOG82T7B5Lym9qfj84o+7NOQf3KBTSIVQErosY=;
 b=P8Crvj3ZA+H3Rb0ZGHV3I8fYH/DZ0oBqvIOc1kR/LvytYxyizPCHm2eAC63gPJvWqcafJszHXrfo81xBxZ/HWaeSQqgVo7IhoQYrPkh1P9b2ak8j9U71Ofcgz3qm1Y2K22fGTiz1NmCtbDhhR8v9HlR+8f79526xHxI/3LgAwV0ELMfiBTeGaXbECdy9AqHHmMmlpRpWRnOnVjxipQFC61EYkPZvcP9sIiMQe7o9606hDKdvfoOEJYxSusKAnwYqs8uok8GNS2EAkBjynzL1vYjispoSLQRR6/oxYeTAxWATN6ktu/p/ggJ8Em8m+yIkrzelpFEkl2nUL+whNRZzog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=elastics.cloud; dmarc=pass action=none
 header.from=elastics.cloud; dkim=pass header.d=elastics.cloud; arc=none
Received: from IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19)
 by SJ2PR12MB7962.namprd12.prod.outlook.com (2603:10b6:a03:4c2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 11:30:56 +0000
Received: from IA1PR12MB6236.namprd12.prod.outlook.com
 ([fe80::4d96:7f43:3c9e:3798]) by IA1PR12MB6236.namprd12.prod.outlook.com
 ([fe80::4d96:7f43:3c9e:3798%4]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 11:30:55 +0000
To: Maverickk 78 <maverickk1778@gmail.com>, Jonathan Cameron
 <Jonathan.Cameron@Huawei.com>
CC: Jonathan Cameron via <qemu-devel@nongnu.org>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>
Subject: Re: CXL volatile memory is not listed
Thread-Topic: CXL volatile memory is not listed
Thread-Index: AQHZy3ZeSnNACG9B5EyNjhi3Zdx1ja/kYcQAgAC+IwCACnALgIAAZzJG
Date: Fri, 18 Aug 2023 11:30:55 +0000
Message-ID: <IA1PR12MB6236E18350FFCB8916E32E86E81BA@IA1PR12MB6236.namprd12.prod.outlook.com>
References: <CALfBBTtUtydebmJuh6JZ5RAXZfx5OgJ+RCug1apbZa4mm17rJQ@mail.gmail.com>
 <20230810113512.00000516@Huawei.com>
 <CALfBBTud4Y7qxKB8nkZ5Lo5sQs-7-F9Rkso+iQGvLO07VyRcDA@mail.gmail.com>
 <20230811145458.000029c7@Huawei.com>
 <CALfBBTsMLP8_eTfmFt5mB+ywF1D0WTR7m=PBqUVzhhvcwC+zYA@mail.gmail.com>
In-Reply-To: <CALfBBTsMLP8_eTfmFt5mB+ywF1D0WTR7m=PBqUVzhhvcwC+zYA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=elastics.cloud;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6236:EE_|SJ2PR12MB7962:EE_
x-ms-office365-filtering-correlation-id: 82f06bec-7a94-4fdc-b360-08db9fde9663
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AMoDkQlHUCQEoXhpLxyfkBZu4GJpG9IudO0vTLa2RmNNbfjvBwlMqS/XY/YJqF8xoelwanYn4Aei0XT8tmz4kZGKkbwjLIiTBm85thdb9YIHiIJxrKAi1PA7XllIQ5nzlRmWynyag3CbRFNBCKvnOfla/FZO37fcj5aF2E90BSFJz1jhrNzRQN8UHfZFwuYkO/OolWPaJQnuOm49Eqf2OyWhOqrxHmZfvrK9pc8Ro8lJQNgJoYsQxpDr/Lhc2O+iqh7o8dKIuIXYb1nqFMAHl3VJbvuM0Y6CKLB5BQ87Twh17x25FKy022kLij07eqGHnwhSaHQAs4hjJpgJJ9xaT+/cuFt+o2EtJ0kFE3mLssTBZQYEVOcReQn2bbtjN7zxxkkXZUJaFocgjcqsUCTmh/4iDBJ1LEBtAVrcS0a+qT1yRpwF4sBqLivKp7ONkJXgvrT3cae0RCDsRtmYqsJp+2JrpmemJZu+aR5SjrspG3W0mJ3DIuEYh+j4jnoL+qXevX3CoR/ihZboMn/6GMsUihcdCUwSTwdIRtGa7WQZzZuhHd45gGvHKbpXuIeKtSualH+5h6I3E4CUpaEnHfR/2oH9a9nB/POdCtjEDc5xiq2PkAljBTlWbKbnH+hlUq3vJhve85HPxczrwTedhkiF/w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6236.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39830400003)(451199024)(1690799017)(1800799009)(186009)(40140700001)(86362001)(33656002)(122000001)(38070700005)(38100700002)(55016003)(52536014)(76116006)(966005)(5660300002)(44832011)(110136005)(66556008)(478600001)(6506007)(66946007)(66446008)(66476007)(7696005)(91956017)(53546011)(54906003)(71200400001)(64756008)(316002)(9686003)(4326008)(8676002)(8936002)(41300700001)(166002)(83380400001)(2906002)(71440200002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V02QIUfGalrKR8bIx+7T4ySAW152NxzOmavvnBxQ5DOkvwyfJKb0uYHfpJhX?=
 =?us-ascii?Q?8b/Pg8fRZSbo5VD8aQnYL5MBDWpjtTpgD/WAgodfBhGNXKw1i2sRHoO0XUSm?=
 =?us-ascii?Q?jBJna0h4RFQHcGf78NyI1viZqqRPOF4PgjVxPak44VcG+cZUMBvSLLS0jjd0?=
 =?us-ascii?Q?9R06OXVGGzEWY3g6NxEW6YZku311GoJ8Cf3wHEwdd1s1LlRLlEMNqZuDGKe+?=
 =?us-ascii?Q?UrzoQXAGdEm1fjwhPZg9ScSRqNXpF+95ice78MeTkq702/m3hXSDBsseER+u?=
 =?us-ascii?Q?HWYS+jFkTiR8DQFP7Ky8BeqTTpeVL+dYP0B6MgbP1itcMHUW2pRDqrugAK2q?=
 =?us-ascii?Q?Re2X/+82g+xhIlUEhRjpNTO2flC6mNaXbz8WR3D7mJewvzHOYoGo08BIR9SD?=
 =?us-ascii?Q?Cd23Gr3kb8m+HMSDXHRHrDF7VmrDiITSj4fR5IOoOsj9aOWerdd1LTA46Qrb?=
 =?us-ascii?Q?XiNNiaLuWw32r0zsaqH/cp8eNuGacJbrjziI3XkjTMERNBBL/vPrdab5R1Xn?=
 =?us-ascii?Q?ADQcRzZ3YTuAWyo9HxOH0KCHidD1JEPtbfwd/qHRjceQlk0PDwnCQi3mAcgc?=
 =?us-ascii?Q?5oNuwQlCsjE9wmMWzOHAiCm6q0aJa5Jzel0eelKJ2PsJ7LfqfrWt8Pi41zyL?=
 =?us-ascii?Q?Y24/JLrt8z3KjQz2A2fkvw3tm5PF+Q9z7WC4K02sd9vVoxBoVUvTDlV6DzxM?=
 =?us-ascii?Q?aNCjNpHhrzFGGcafmJ0EV7ocnfdaa/jP2c27JODok1t364nOUezWy2X8Qux6?=
 =?us-ascii?Q?3it9MSS9hSwLtmTMsLgjXq0xdx+5ZadB0MwQdOYJbp23xkuvXwsQqJa5Z3kI?=
 =?us-ascii?Q?9R1m5JK0LrV4KzH4DtnCXJClgmKkORmkMKr5F0zfihDNo/sH1qS/bsu+5HDS?=
 =?us-ascii?Q?v1m3ZaLjC1uC5rFESG8uNjoratSlxf1HiYaHlUZQ2BScavNIqLdXmFlBhHh1?=
 =?us-ascii?Q?+65QIQt7wSRB4RXH3cVU+1LAui9eXZFNwxKh1V/EoxtWF0eCvFI3TLWc+Lhq?=
 =?us-ascii?Q?qS0tvGlGyeuwM/y7vUpHnrLyTs5tDOpoJop9oHfOXL0YFPBGLoqrdPWiCDSr?=
 =?us-ascii?Q?CnVYZZ/hlUZ1LTQquqk7wsYiO8jyjb+0pBGji/4ciSSSH4pTvTxCX+2YLs79?=
 =?us-ascii?Q?vwzkH411skNzuk8S9DxiNleZAuS2W+9jwYsffvZH6/CUihDqJWGcPPB/WW0D?=
 =?us-ascii?Q?hFznJ1M8MLt+cuGbgxT5276i1b4PWj/YPTijsd1D/Ykub8JQoo2hXoWdX2cj?=
 =?us-ascii?Q?hLxE+iR5OCmh0md4bBiNt5NBXLBU6IZ/rE0xQdW1joAKGEfWps4FyN7kxSsL?=
 =?us-ascii?Q?qZf5Smljqk23kuMGmndEaqPtK+R50TmMvBV73Tz7H+zZYz5VuoT8Whkkf9YZ?=
 =?us-ascii?Q?8uj15ygidx1zwQJBgzVpmbslxPCwkY/JWYpp613KH3dlkjRVwSYJT55CT7nZ?=
 =?us-ascii?Q?hHs4wWW2YwF8rJnQHB0Hb+ZktTvJhatgRnQn7aN5Pu0bVo3p+h1bztG0cBNd?=
 =?us-ascii?Q?o8t1FkybbOOisAmOMZydyDft5PGx00LTG9fk+ULuhanyDw4KObwXoxsOh9CV?=
 =?us-ascii?Q?wlNgDXnFWVihPNZIvds1pq0O83Cit0yb93oQRBIsVnta2XmXEzR/m0W3Mv4C?=
 =?us-ascii?Q?96AtL0qGon6RvXHUFNsz2ojkLEU7vhJN33DszM0xU1N93hS/8eeoQuTU5c36?=
 =?us-ascii?Q?v2YxRA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_IA1PR12MB6236E18350FFCB8916E32E86E81BAIA1PR12MB6236namp_"
MIME-Version: 1.0
X-OriginatorOrg: elastics.cloud
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6236.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f06bec-7a94-4fdc-b360-08db9fde9663
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 11:30:55.7687 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 28558b47-528a-463d-9ef1-81068bcc77f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZiDNWZJVFlzBfvZE+QCmj09bcxNJrK8fqtAlQN9muiNr65EXBlHlqpd2zlA7kSfiCDCI3kpEwnbN9+sFq3Clyz8GjRqZVXNI9J/vGKRA3SM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7962
Received-SPF: pass client-ip=40.107.94.91;
 envelope-from=shreyas.shah@elastics.cloud;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_REMOTE_IMAGE=0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Shreyas Shah <shreyas.shah@elastics.cloud>
From:  Shreyas Shah via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--_000_IA1PR12MB6236E18350FFCB8916E32E86E81BAIA1PR12MB6236namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Once the cxl memory is online, how does Operating system know whether to ma=
lloc in the cxl memory or socket attached DDR memory?



[https://static1.squarespace.com/static/60dbbd6d597c966b91a3b27b/t/6104415e=
6177af1589fb05e4/1627668830393/elastics-cloud-logo-120.png]<https://www.ela=
stics.cloud/>
Shreyas Shah
Founder, CTO and Chief Scientist, Elastics.cloud, Inc.
1730 North First Street, 5th Floor, San Jose, CA 95112
t: 408 476 3100<tel:408%20476%203100> | e: email: shreyas.shah@elastics.clo=
ud

________________________________
From: Maverickk 78 <maverickk1778@gmail.com>
Sent: Thursday, August 17, 2023 10:18 PM
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron via <qemu-devel@nongnu.org>; linux-cxl@vger.kernel.org=
 <linux-cxl@vger.kernel.org>
Subject: Re: CXL volatile memory is not listed

Hi Jonathan,

The use case of CXL switch will always need some sort of management
agent + FM configuring the available CXL memory connected.

In most cases it would be bmc controller configuring MLD/MHD's to
host, and in very rare scenarios it may be one of the host interacting
with FM firmware inside the switch which would do the trick.

Another use case is static hardcoding between CXL memory & host in
built in cxl switch

There is no scenario where one of the host BIOS can push the select
CXL memory to itself.


Is my understanding correct?



On Fri, 11 Aug 2023 at 19:25, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 11 Aug 2023 08:04:26 +0530
> Maverickk 78 <maverickk1778@gmail.com> wrote:
>
> > Jonathan,
> >
> > > More generally for the flow that would bring the memory up as system =
ram
> > > you would typically need the bios to have done the CXL enumeration or
> > > a bunch of scripts in the kernel to have done it.  In general it can'=
t
> > > be fully automated, because there are policy decisions to make on thi=
ngs like
> > > interleaving.
> >
> > BIOS CXL enumeration? is CEDT not enough? or BIOS further needs to
> > create an entry
> > in the e820 table?
> On intel platforms 'maybe' :)  I know how it works on those that just
> use the nice standard EFI tables - less familiar with the e820 stuff :)
>
> CEDT says where to find the the various bits of system related CXL stuff.
> Nothing in there on the configuration that should be used such as interle=
aving
> as that depends on what the administrator wants. Or on what the BIOS has
> decided the users should have.
>
> >
> > >
> > > I'm not aware of any open source BIOSs that do it yet.  So you have
> > > to rely on the same kernel paths as for persistent memory - manual co=
nfiguration
> > > etc in the kernel.
> > >
> > Manual works with "cxl create regiton"  :)
> Great.
>
> Jonathan
>
> >
> > On Thu, 10 Aug 2023 at 16:05, Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Wed, 9 Aug 2023 04:21:47 +0530
> > > Maverickk 78 <maverickk1778@gmail.com> wrote:
> > >
> > > > Hello,
> > > >
> > > > I am running qemu-system-x86_64
> > > >
> > > > qemu-system-x86_64 --version
> > > > QEMU emulator version 8.0.92 (v8.1.0-rc2-80-g0450cf0897)
> > > >
> > > +Cc linux-cxl as the answer is more todo with linux than qemu.
> > >
> > > > qemu-system-x86_64 \
> > > > -m 2G,slots=3D4,maxmem=3D4G \
> > > > -smp 4 \
> > > > -machine type=3Dq35,accel=3Dkvm,cxl=3Don \
> > > > -enable-kvm \
> > > > -nographic \
> > > > -device pxb-cxl,id=3Dcxl.0,bus=3Dpcie.0,bus_nr=3D52 \
> > > > -device cxl-rp,id=3Drp0,bus=3Dcxl.0,chassis=3D0,port=3D0,slot=3D0 \
> > > > -object memory-backend-file,id=3Dmem0,mem-path=3D/tmp/mem0,size=3D1=
G,share=3Dtrue \
> > > > -device cxl-type3,bus=3Drp0,volatile-memdev=3Dmem0,id=3Dcxl-mem0 \
> > > > -M cxl-fmw.0.targets.0=3Dcxl.0,cxl-fmw.0.size=3D1G
> > >
> > > There are some problems upstream at the moment (probably not cxl rela=
ted but
> > > I'm digging). So today I can't boot an x86 machine. (goody)
> > >
> > >
> > > More generally for the flow that would bring the memory up as system =
ram
> > > you would typically need the bios to have done the CXL enumeration or
> > > a bunch of scripts in the kernel to have done it.  In general it can'=
t
> > > be fully automated, because there are policy decisions to make on thi=
ngs like
> > > interleaving.
> > >
> > > I'm not aware of any open source BIOSs that do it yet.  So you have
> > > to rely on the same kernel paths as for persistent memory - manual co=
nfiguration
> > > etc in the kernel.
> > >
> > > There is support in ndctl for those enabling flows, so I'd look there
> > > for more information
> > >
> > > Jonathan
> > >
> > >
> > > >
> > > >
> > > > I was expecting the CXL memory to be listed in "System Ram", the ls=
mem
> > > > shows only 2G memory which is System RAM, it's not listing the CXL
> > > > memory.
> > > >
> > > > Do I need to pass any particular parameter in the kernel command li=
ne?
> > > >
> > > > Is there any documentation available? I followed the inputs provide=
d in
> > > >
> > > > https://lore.kernel.org/linux-mm/Y+CSOeHVLKudN0A6@kroah.com/T/
> > > >
> > > > Is there any documentation/blog listed?
> > >
>

--_000_IA1PR12MB6236E18350FFCB8916E32E86E81BAIA1PR12MB6236namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div style=3D"font-family: inherit; font-size: inherit; color: inherit; bac=
kground-color: transparent;">
</div>
<div>Once the cxl memory is online, how does Operating system know whether =
to malloc in the cxl memory or socket attached DDR memory?&nbsp;</div>
<div><br>
</div>
<div><br>
</div>
<div><br>
</div>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<div style=3D"height:auto; padding:0px 17px 17px; clear:none; font-family:&=
quot;Titillium Web&quot;; font-size:17.8432px; letter-spacing:0.356864px; t=
ext-align:start; background-color:rgb(255,255,255)">
<div style=3D"outline:none">
<h4 style=3D"font-family:&quot;Titillium Web&quot;!important; letter-spacin=
g:0em; line-height:1.3664; margin:0px">
<table width=3D"600" style=3D"color:inherit; letter-spacing:0.356864px; bor=
der-collapse:collapse; border-spacing:0px">
<tbody>
<tr>
<td width=3D"150" align=3D"center"><a href=3D"https://www.elastics.cloud/" =
target=3D"_blank" style=3D"background:transparent"><img width=3D"119" heigh=
t=3D"55" style=3D"max-width:100%" src=3D"https://static1.squarespace.com/st=
atic/60dbbd6d597c966b91a3b27b/t/6104415e6177af1589fb05e4/1627668830393/elas=
tics-cloud-logo-120.png"></a></td>
<td width=3D"2"></td>
<td width=3D"30"></td>
<td width=3D"418">
<div style=3D"line-height:20px">
<div style=3D"font-family:arial; font-size:18px; color:rgb(0,72,255)"><stro=
ng>Shreyas Shah</strong></div>
<div style=3D"font-family:arial; font-size:12px"><span style=3D"color:rgb(0=
,14,62)">Founder, CTO and Chief Scientist</span><font color=3D"#cccccc">,&n=
bsp;</font><span style=3D"color:rgb(0,14,62); font-family:arial; font-size:=
12px; letter-spacing:0.356864px">Elastics.cloud,
 Inc.</span></div>
<div style=3D"font-family:arial; font-size:12px; color:rgb(0,14,62)">1730 N=
orth First Street, 5th Floor, San Jose, CA 95112</div>
<span style=3D"font-family:arial; font-size:12px; color:rgb(0,14,62)"><stro=
ng style=3D"color:rgb(0,72,255)">t:</strong>&nbsp;<a href=3D"tel:408 476 31=
00">408 476 3100</a>&nbsp;<span style=3D"color:rgb(204,204,204)">|</span>&n=
bsp;<strong style=3D"color:rgb(0,72,255)">e:</strong>&nbsp;email:
 shreyas.shah@elastics.cloud</span></div>
</td>
</tr>
</tbody>
</table>
</h4>
</div>
</div>
<br>
</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Maverickk 78 &lt;mave=
rickk1778@gmail.com&gt;<br>
<b>Sent:</b> Thursday, August 17, 2023 10:18 PM<br>
<b>To:</b> Jonathan Cameron &lt;Jonathan.Cameron@huawei.com&gt;<br>
<b>Cc:</b> Jonathan Cameron via &lt;qemu-devel@nongnu.org&gt;; linux-cxl@vg=
er.kernel.org &lt;linux-cxl@vger.kernel.org&gt;<br>
<b>Subject:</b> Re: CXL volatile memory is not listed</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Jonathan,<br>
<br>
The use case of CXL switch will always need some sort of management<br>
agent + FM configuring the available CXL memory connected.<br>
<br>
In most cases it would be bmc controller configuring MLD/MHD's to<br>
host, and in very rare scenarios it may be one of the host interacting<br>
with FM firmware inside the switch which would do the trick.<br>
<br>
Another use case is static hardcoding between CXL memory &amp; host in<br>
built in cxl switch<br>
<br>
There is no scenario where one of the host BIOS can push the select<br>
CXL memory to itself.<br>
<br>
<br>
Is my understanding correct?<br>
<br>
<br>
<br>
On Fri, 11 Aug 2023 at 19:25, Jonathan Cameron<br>
&lt;Jonathan.Cameron@huawei.com&gt; wrote:<br>
&gt;<br>
&gt; On Fri, 11 Aug 2023 08:04:26 +0530<br>
&gt; Maverickk 78 &lt;maverickk1778@gmail.com&gt; wrote:<br>
&gt;<br>
&gt; &gt; Jonathan,<br>
&gt; &gt;<br>
&gt; &gt; &gt; More generally for the flow that would bring the memory up a=
s system ram<br>
&gt; &gt; &gt; you would typically need the bios to have done the CXL enume=
ration or<br>
&gt; &gt; &gt; a bunch of scripts in the kernel to have done it.&nbsp; In g=
eneral it can't<br>
&gt; &gt; &gt; be fully automated, because there are policy decisions to ma=
ke on things like<br>
&gt; &gt; &gt; interleaving.<br>
&gt; &gt;<br>
&gt; &gt; BIOS CXL enumeration? is CEDT not enough? or BIOS further needs t=
o<br>
&gt; &gt; create an entry<br>
&gt; &gt; in the e820 table?<br>
&gt; On intel platforms 'maybe' :)&nbsp; I know how it works on those that =
just<br>
&gt; use the nice standard EFI tables - less familiar with the e820 stuff :=
)<br>
&gt;<br>
&gt; CEDT says where to find the the various bits of system related CXL stu=
ff.<br>
&gt; Nothing in there on the configuration that should be used such as inte=
rleaving<br>
&gt; as that depends on what the administrator wants. Or on what the BIOS h=
as<br>
&gt; decided the users should have.<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I'm not aware of any open source BIOSs that do it yet.&nbsp;=
 So you have<br>
&gt; &gt; &gt; to rely on the same kernel paths as for persistent memory - =
manual configuration<br>
&gt; &gt; &gt; etc in the kernel.<br>
&gt; &gt; &gt;<br>
&gt; &gt; Manual works with &quot;cxl create regiton&quot;&nbsp; :)<br>
&gt; Great.<br>
&gt;<br>
&gt; Jonathan<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; On Thu, 10 Aug 2023 at 16:05, Jonathan Cameron<br>
&gt; &gt; &lt;Jonathan.Cameron@huawei.com&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Wed, 9 Aug 2023 04:21:47 +0530<br>
&gt; &gt; &gt; Maverickk 78 &lt;maverickk1778@gmail.com&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Hello,<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; I am running qemu-system-x86_64<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; qemu-system-x86_64 --version<br>
&gt; &gt; &gt; &gt; QEMU emulator version 8.0.92 (v8.1.0-rc2-80-g0450cf0897=
)<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; +Cc linux-cxl as the answer is more todo with linux than qem=
u.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; qemu-system-x86_64 \<br>
&gt; &gt; &gt; &gt; -m 2G,slots=3D4,maxmem=3D4G \<br>
&gt; &gt; &gt; &gt; -smp 4 \<br>
&gt; &gt; &gt; &gt; -machine type=3Dq35,accel=3Dkvm,cxl=3Don \<br>
&gt; &gt; &gt; &gt; -enable-kvm \<br>
&gt; &gt; &gt; &gt; -nographic \<br>
&gt; &gt; &gt; &gt; -device pxb-cxl,id=3Dcxl.0,bus=3Dpcie.0,bus_nr=3D52 \<b=
r>
&gt; &gt; &gt; &gt; -device cxl-rp,id=3Drp0,bus=3Dcxl.0,chassis=3D0,port=3D=
0,slot=3D0 \<br>
&gt; &gt; &gt; &gt; -object memory-backend-file,id=3Dmem0,mem-path=3D/tmp/m=
em0,size=3D1G,share=3Dtrue \<br>
&gt; &gt; &gt; &gt; -device cxl-type3,bus=3Drp0,volatile-memdev=3Dmem0,id=
=3Dcxl-mem0 \<br>
&gt; &gt; &gt; &gt; -M cxl-fmw.0.targets.0=3Dcxl.0,cxl-fmw.0.size=3D1G<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; There are some problems upstream at the moment (probably not=
 cxl related but<br>
&gt; &gt; &gt; I'm digging). So today I can't boot an x86 machine. (goody)<=
br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; More generally for the flow that would bring the memory up a=
s system ram<br>
&gt; &gt; &gt; you would typically need the bios to have done the CXL enume=
ration or<br>
&gt; &gt; &gt; a bunch of scripts in the kernel to have done it.&nbsp; In g=
eneral it can't<br>
&gt; &gt; &gt; be fully automated, because there are policy decisions to ma=
ke on things like<br>
&gt; &gt; &gt; interleaving.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I'm not aware of any open source BIOSs that do it yet.&nbsp;=
 So you have<br>
&gt; &gt; &gt; to rely on the same kernel paths as for persistent memory - =
manual configuration<br>
&gt; &gt; &gt; etc in the kernel.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; There is support in ndctl for those enabling flows, so I'd l=
ook there<br>
&gt; &gt; &gt; for more information<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Jonathan<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; I was expecting the CXL memory to be listed in &quot;Sy=
stem Ram&quot;, the lsmem<br>
&gt; &gt; &gt; &gt; shows only 2G memory which is System RAM, it's not list=
ing the CXL<br>
&gt; &gt; &gt; &gt; memory.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Do I need to pass any particular parameter in the kerne=
l command line?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Is there any documentation available? I followed the in=
puts provided in<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; <a href=3D"https://lore.kernel.org/linux-mm/Y+CSOeHVLKu=
dN0A6@kroah.com/T/">
https://lore.kernel.org/linux-mm/Y+CSOeHVLKudN0A6@kroah.com/T/</a><br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Is there any documentation/blog listed?<br>
&gt; &gt; &gt;<br>
&gt;<br>
</div>
</span></font></div>
</body>
</html>

--_000_IA1PR12MB6236E18350FFCB8916E32E86E81BAIA1PR12MB6236namp_--

