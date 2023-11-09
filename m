Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7186B7E6515
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 09:20:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r10G3-0002OQ-Q2; Thu, 09 Nov 2023 03:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1r10G1-0002Nz-IM
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 03:19:21 -0500
Received: from mail-bn8nam12on2077.outbound.protection.outlook.com
 ([40.107.237.77] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1r10Fy-0007Jz-LS
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 03:19:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mX0MFtMbh/TqsDjFxDDUaOIkz4HABqZNqAv4VqU5+GF4e3IVhKQ3DAbifZJH71HoYt51r2oiTNIivN0eoKz9UxhVeWJE/qU9NNIOMW/oeJQ3m03K/U7ZI4FMombuKwerKjslt5GLPJuWuf+k9rzbBL5mN8QVT9tJaepm0ctFBN9D9K6JnnWaBg1yV3dSWarooL4SPQ0YJ8H9USPh22xI+zJN22kKlMCaD8wi2cFS8rq0ZFDcc198HMBOhVXfD5bAL+e8p8c4AbrWlspFvCL5kYsVRjLbqU4H9gknnQe4/GAPgZZgRISBFeIAwO7ZJR5e7I/Tw0KQG84h9aJDqtAh7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xg2vwg361R8DrySBYtmg/a5R1d7KDsMIcYWL1/NwHo=;
 b=JFfFc9S1ZwrVlXGO+6TS11vWOaO+DaCygtPn5tpo25UUIF+WvFXw4UkrToE0ZvYm36JM+Xb8fo2l7DMRKEwrI/8sn5D4tH5xNTtHwjREX0RCPKf4qlIrB9Y6UbeLK3cI5zwphCKwN7/zZSRk81ID7XmrJYXn74SW1yKmA88Azmtejz81CAs8B/eBpWSgRAbxD2qH8uOVLTHnmJFo3Ev4FvPy7cxOfEI7Zqet4x+iQjMb6VTRz303MLMrC0UuebL2+BD/CFSZ/C8w48Mh4QZBdUZkI4pMc7bsMFnsccO9Z8WQ45j8FeB34DAqJpQ928RnWfhppROB7aYm2lWwcHVK9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xg2vwg361R8DrySBYtmg/a5R1d7KDsMIcYWL1/NwHo=;
 b=KWloXuxmkDs1J6liXko4ywVwBB2IMmlErYxWNC60Ipz51htDVpr7ftyeO9xoUTJk/pLGapHgkam/BcYrRGqJWfDYIycJfkXZSjv5q0VOQKihQlyOnYwiSkWtV3CNCyqa2MskyZeTTSrWDxZpinYKCmcvk8/7kJXEq6/CHv2UuhM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by CH3PR12MB9171.namprd12.prod.outlook.com (2603:10b6:610:1a2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 08:14:13 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::87d4:680b:51ef:181]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::87d4:680b:51ef:181%7]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 08:14:13 +0000
Date: Thu, 9 Nov 2023 16:13:53 +0800
From: Huang Rui <ray.huang@amd.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Antonio Caggiano <quic_acaggian@quicinc.com>,
 Hans de Ruiter <hans@keasigmadelta.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Gert Wollny <gert.wollny@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: QEMU Virtio GPU features status & roadmap?
Message-ID: <ZUyUwf3e6d8njOW3@amd.com>
References: <65466251-5c0c-90d0-c482-29ebc4e16a20@keasigmadelta.com>
 <6c565178-f34c-57f9-90be-25b2c738b068@quicinc.com>
 <CAJ+F1CK6Y-DqHTfC4u7EUhdgK0T++KTvvus6mqnRz-a9v-HQyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CK6Y-DqHTfC4u7EUhdgK0T++KTvvus6mqnRz-a9v-HQyQ@mail.gmail.com>
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|CH3PR12MB9171:EE_
X-MS-Office365-Filtering-Correlation-Id: 55615f39-8d2a-4a6f-9a6e-08dbe0fbdbd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M5LaGVtTK9vU8sImQM5/K+xq9RIPG5aGYq8qYXZPEA/Z3x7wvIH7u7UsrRrZbXZKdddMn1n2hLlrRIRYfMnj4ljuziAV7UAs/xXx+1m58DHveNtrEJpYasFffANjQj7HPaDk9s+Z50sI1cgyL2QUQLOD08UMj0/r+lH4kGuBVX+OtUiZh+wOku6dChIGiu5z4JtEodfLCORtlCr8FaoyDNLwyox7sPDoX6leKzfWdc1MIQNlwdbVxtJh6hjRIukePqLJnaT+YZBgtmY6ZANYnGMUymnJkeh6KUfrYb9qx8Ik4hjmfpqyiG9ZoLtwvUj9WRiKZ3LgsmUxrYOlSTZvLiAfrPTAOSuXw7U64wQ0Ou8J7UOrZXst3JMQoPwA0p7zAOvlsXjA+BcWTynaFtLYp1AYbIo4jNKdMSJ60caQXP0qwMoIqgVrxRX6siq88+1u1DynUP+/lQnArpjPLIAoLtnCVARqvHzgXI5GdSHhlCRnW/TymSP4qPlew8GPovVuwZJbItvetkNpOx5tSdhmB91JuDXVj7rfdZPu2macNx7NuyHgrB221a8sV/RGY1Ir/XFpXjNwGKiF0CnxqCwqHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8690.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(5660300002)(83380400001)(2616005)(4326008)(6506007)(53546011)(8676002)(8936002)(6512007)(26005)(36756003)(66556008)(66946007)(66476007)(478600001)(41300700001)(54906003)(86362001)(6916009)(316002)(38100700002)(6666004)(6486002)(966005)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkRhSWxIZER1Q21KRURzei9nUE5OWjVnNTRhNzMwL2FHNzZhdGtrQ1kyY2lT?=
 =?utf-8?B?OG8rREZUblphT1gvQzZpbGhYVW5QWmhtanpxaFJqeUJXUzFqSkNieEhwWkJJ?=
 =?utf-8?B?YjBqTVV2MDR6NjkzNEN3L2o0UlBleTFkTDhpWmVIMXlJTzFwdHEzaDl6VDR2?=
 =?utf-8?B?UitBa1FFSHZkMnVvMUZEZzBJc2w5YkZCRndTTVVFNVZQZGJibGQzaDZVM0cz?=
 =?utf-8?B?cnNtb2hnVHRDNUZMM21UbmpyV3hWWEtjWnFKMFJwNkRScXNqZGFWaGlSZ1Rs?=
 =?utf-8?B?clNzeTErRElMb3d2eTJKdlk4N0l4N3NqYWo2cWFhcG9xYjgxdTVhTi9zVzA1?=
 =?utf-8?B?TU05eC83aEdsNmhpZEZ0YmQxTlZIbDljOCsva0dzYWo5bEZ2SEJLaC8reWk5?=
 =?utf-8?B?UytXRVdHSjhKOUhxMFRPTWpOTjh1VWNYamM5dUFVTTNlUjgxUlV3UC9mMWZk?=
 =?utf-8?B?YUxUZXJ2QzdmR1RLRHBXaDJHejV0ekxJb2Ntb1ZRZHFLblJOQnNkdk5ENTRT?=
 =?utf-8?B?ajhERlhHb09TSG8zc2tBejM2TXc5SUZLelFSbklCT0hVNldJajZvZU9mOE9W?=
 =?utf-8?B?L0dZQm84bEhEbmFUc2JldFcxZ2ZIYVd0VjJvTG16WkNzc2R1S1docFNmYjVC?=
 =?utf-8?B?RVlPN3lGNlA1eUdERDg1Nyt1M1hVMXdNbktESmlIdjVDMXVFMER6ejdQSXdY?=
 =?utf-8?B?ajNubFVhRGFaUjBIek1DSjJMZG5QQWFLc3FmM0ZNSHNReEE0WG1yRWpXU3lT?=
 =?utf-8?B?Qy9PaWJ2enpXaTEyNFd2MENLeDZZVHhjWHVPbDN1cm5jUHJ2ZHFqRzZTK29i?=
 =?utf-8?B?K3hjWVhIK0l0Q0RtTS9HSk0yZXp0aE11TDA1L0hjcHhxR0t2VzBmaHh3dXFS?=
 =?utf-8?B?RGRadlI5QnZhd1dKekJxQWkrQXliendwVWs2ZjFVUWhleE85VmFYNUVuNTJT?=
 =?utf-8?B?Ym9pcW0reU9rSkVXalJ1VVJod3JuTDNuRUdRMERCbkc2SkM3UnUvL210WHFQ?=
 =?utf-8?B?Zkk0SHlkRzR6Si9SUHhON2NQZWpPZEVDeFhlYk9lU0h2VWJVT05HODlLaWZW?=
 =?utf-8?B?T1VOeGRLRzZ1Wk13RGtDQ0d5UHdyOCtvSkNBU3l5WUJtdnRVc2p5dHNpNFRV?=
 =?utf-8?B?V1lROWQ0aXBwNmlCWWNZdDRBRGtZMXU4a3dTc3lldG9ZSytCNTI0RFhZSWNo?=
 =?utf-8?B?Tk0xTyt6UEd1YXl3S21VNy92N1RYOEFubEZCL1dEZlAzZGR2aHhEVmx2Wmcr?=
 =?utf-8?B?TjB4VWVNZW1kdWRFYTIwTm55Q0NxbDlPNk9VczYwSHFHZDNFUVg2TnpSdkxs?=
 =?utf-8?B?NVR6aXRIaWpicWtEN0s5cmFQaFNYNWpqT0VUeUdWN2ZMTnkzK29FcFJySk9o?=
 =?utf-8?B?Tm9IbTFlc0xvR2ZWN21rbFkzUTFzdVlKTmNsWjJzL2pMc0dWc29CV0YzVlVL?=
 =?utf-8?B?TEE1ZnBjZWxTMXp2Tmc5aVJ4aml1dFlyL21WUzRQMS96UkQ5dHhPc3VjUEdn?=
 =?utf-8?B?N1ZaMjdidGQ5amFUcWpQSE9Jak9PWkNIcGFwbkp3b0JqbzZweFlzWE9sZ3Bz?=
 =?utf-8?B?K0xyQUhQZnNaOGxKTnN2S2tVVnJJS0VNcnJlNHc3SlRhSTNhVktVUlZ0anpW?=
 =?utf-8?B?Kzg2Z2VXczQ2NEsxaXp4SUk1VUFML3c1Vms1Qmd1TVQ1QzY1Y3ZmQkpvYVg3?=
 =?utf-8?B?U1pBRUpyWWUvQUdDM1V2dld2SDhhUDdPeEFJYjczaDIyR0hBZ3o1SnVCVE9r?=
 =?utf-8?B?MktSRGM0aHNiWXVNblRUUk1xb010ajJIMHJzMzRlbkxIcU4yK1VzeFJuK2tV?=
 =?utf-8?B?TmhOK0MzcnRjdUhPRy9NRGtjRHFLVzNkbHlINlgwbS9Yc29nY0ptb0ZFdmd0?=
 =?utf-8?B?UTR5RWpBYnhwNDZoeDB5SFVjaU01OENoY1JleGZIaGprVDJVdlZaWG1BTDFt?=
 =?utf-8?B?SWg5a3Q0ck44VVh3VjBuTWc1TlJMcDJESjJOTUt3NVBUbzVXUXVWTXF3a3BD?=
 =?utf-8?B?cFlvTVpBWjNGZVdYTjM2VEd5UkxiK09BVVpxWGMxQnB3S1dGVXQzY3Bvek9p?=
 =?utf-8?B?RSsvM2wyQUFtOWVQZXBBamFLT2NEaDJ0YlVDQ3Q2bU5vbkF3dVNHUXJYeEVE?=
 =?utf-8?Q?egcAH9Fh9NiM5iUq25NfWp6cj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55615f39-8d2a-4a6f-9a6e-08dbe0fbdbd4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 08:14:13.3729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/+Ei5Yj75udUkTBKNYF3URWp2LYpmKH8G3CLk8DVr+JT7FEA+TMAbskz6WOuMcDb1moOdgv3b3O2gG/Fox0lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9171
Received-SPF: softfail client-ip=40.107.237.77; envelope-from=Ray.Huang@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Nov 08, 2023 at 07:07:43PM +0800, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Nov 8, 2023 at 1:04 PM Antonio Caggiano
> <quic_acaggian@quicinc.com> wrote:
> >
> > Hi Hans,
> >
> > +cc Gert and Dmitry
> >
> > On 17/10/2023 02:48, Hans de Ruiter wrote:
> > > Hi,
> > >
> > > I'm working on Virtio GPU drivers for AmigaOS, and would like to know
> > > what features are currently stable enough to use. Looking at the master
> > > QEMU branch, both Virgl and blob resources are supported, but NOT at the
> > > same time. Is the ability to use both simultaneously coming soon?
> > >
> >
> > Mmh, well, they should be compatible, I'll try sending a patch.
> >
> > > Also, what's the state of Venus/Vulkan support? Surveying various
> > > forks/branches, it looks very experimental and subject to change.
> > >
> >
> > I believe this is quite stable now:
> > https://gitlab.freedesktop.org/virgl/venus-protocol/-/issues/5
> 
> The last patch series for QEMU is from Huang Rui:
> https://patchew.org/QEMU/20230915111130.24064-1-ray.huang@amd.com/

I am working on V6, and will send them out very soon.

Thanks,
Ray

> 
> >
> > Virglrenderer 1.0.0 has been released as well. I wonder if that requires
> > any change in QEMU. Gert or Dmitry might know the answer.
> 
> No changes required afaik.
> 
> >
> > > I have the added difficulty that the AmigaOS Picasso96 driver API
> > > expects direct CPU access to all of VRAM, and likes to peek/poke
> > > directly into the bitmaps. That's clearly not possible without blob
> > > resources, or shared memory (not entirely sure what the shared memory
> > > feature is for). This is why I want to know what features are stable or
> > > coming soon.
> > >
> >
> > The shared memory feature is just a requirement which enables support
> > for blob resources.
> 
> Now that we are in freeze, we won't merge new features until the end
> of this year / next year. But we can already plan / test / review etc.
> 
> Antonio, do you have your work coordinated with Huang?
> 
> Huang, are you going to send a new version of the venus series?
> 
> It would be great to include docs/system/devices/virtio-gpu.rst
> updates too. It's getting difficult to follow the various ways
> virtio-gpu can be used nowadays.
> 
> thanks
> 
> -- 
> Marc-André Lureau

