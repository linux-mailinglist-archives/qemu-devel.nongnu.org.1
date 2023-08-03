Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B851576DD5C
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 03:40:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRNJ5-0005Xt-Gp; Wed, 02 Aug 2023 21:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qRNJ3-0005Xh-6l
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:39:13 -0400
Received: from [134.134.136.65] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qRNJ0-0000ht-VV
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691026750; x=1722562750;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rnLjmAW9puYRXmQBXeIs2NLTbek1HRGQVLvR78RZE5w=;
 b=HMx5ACu8P5JcbgpeuDqStPFPAV16ZyWkXZEXNhnI6MAewVbPtwc/T2q7
 1c5ExdfSPPqxseaO8YIC/BW4F9Q+TMGxL0FDvJXepcnWF1H9hD+FV7TnD
 kXjzLh2N30TGERld501uDaeTdIPQ2Jq9jZl49iiHGkBPBc2hyjTNR3W2I
 mLv0KnnOHkx9ieynlGMaucabam7F8MCSD35KPZGjHU35mfHm5yMq/h6Nf
 ObhIhunD0FFhWxEKh0qobmMyqzW7JSyVR+4ZJvuya1wRlFw+VhhnBgwdE
 eyiVzo/GBHHPLlZax9OMad8oyl53EObdt60pYT6Md0TpJ/bUuDAiWD72Y w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="373377521"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; d="scan'208";a="373377521"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2023 18:31:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="758932982"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; d="scan'208";a="758932982"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga008.jf.intel.com with ESMTP; 02 Aug 2023 18:31:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 18:31:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 18:31:47 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 18:31:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkfEjCBkdk7vJn7KhnSe02t8KHj+VO+eaXPCmolNRdIaAYo9ZBNEn8qiiPaYg6aaxe3kEn2xrdQxfoRUevDw6vMhcZGT322hRfP6gQATp4BIwOWGxbFSIof1b1gupeRT6mzgxo1f2k9LOwm5wpufn7h7m5TxaPqJqMuOrI4J0k1KzluB20Z5bSz7Ldxj3SvOt2zRNIFMi8j9fTEXq+HtOTGZhEfTTxl6V+SEUpJtdDLp1uHhT4DQ81fprrfhTZs7k+kyiwXrcoEGBQA8l0uHNzaz2e1lpMK11uhbNfuZik94NKP/bX43LBEe0VuvSCrylJefdStGvZKoRg1vYfOIAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnLjmAW9puYRXmQBXeIs2NLTbek1HRGQVLvR78RZE5w=;
 b=eh8vtj7doLXOragEJZilMmrAQjNQ5gHu0OJIX+Bya1VLkpK52iQFmoNhrjn4F2MM87vjC9oiIvpOYdHXER6DWXUBBVs1AVd8DJh8oIsKlnFrES7WpjZHxb0qhll+3qgr9PGvoCIGjAuAwp0vynygsr+duRMrWfTFY6BZG2QBsklbj6Rx5KyNMv3z9H3UTrKJCBkqhaLD4r4/uGJP2fRuplXeWuA5tRduEqyeh3XsrFj3MzF/EtRJGc4cFYesw725MLuNkgIqjcc/WpnvCjw3mEqBMAWkukUaAEnEJ30Q8EKzDukWcLZRzk1S3pAxhALrmMryWtX77SZy7pG+lsBI1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7733.namprd11.prod.outlook.com (2603:10b6:8:dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 01:31:45 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::ec75:5d7b:d91e:d80a]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::ec75:5d7b:d91e:d80a%6]) with mapi id 15.20.6652.019; Thu, 3 Aug 2023
 01:31:45 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasonwang@redhat.com" <jasonwang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Martins, Joao"
 <joao.m.martins@oracle.com>
Subject: RE: [RFC PATCH v4 00/24] vfio: Adopt iommufd
Thread-Topic: [RFC PATCH v4 00/24] vfio: Adopt iommufd
Thread-Index: AQHZtJP022BoYWDTBEap0F8lp4sSXq/VOl5wgAKCSwCAAC3osA==
Date: Thu, 3 Aug 2023 01:31:45 +0000
Message-ID: <SJ0PR11MB6744C9FDA0424802785DA91A9208A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230712072528.275577-1-zhenzhong.duan@intel.com>
 <SJ0PR11MB67442D288CD3705A0705CC21920AA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <ZMrcHDFfAxtklauC@Asurada-Nvidia>
In-Reply-To: <ZMrcHDFfAxtklauC@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7733:EE_
x-ms-office365-filtering-correlation-id: b4b9d2ee-df3e-412e-b2f3-08db93c1661f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P9w/hy6gA7nd3A4VvxAMwqcvFzkMp7wujY1npqCWhkZ0gpzFHeCk6PZAHSBBkxRGvH6ILBQMAN99shxHPuvAqCAsdvmYuNmVpXfl1rL+L5tPSOc1b1gBuV/u6lPdIOmuPIGgF7tcFYgyAs+BOyHb7iBDp8ChM9mGwHgB7Peu0UYNiM2aNQz+cBDqcWmQ+mAwiBS4frEw6xkgF3WfzN9KDZN8UvQEILqB/KjzbLCFaKovCD9Pa5Kjc3Y/ktqJMt8xwr7kIlSsqQRFkpDlo1DSVHeh/vnIeubDy59NZWkAmn4mMQUuaZzXGoAdUFAqamI+2xE2dqSR7B88++MjioLmHDCBbzcuKWqEgOMkkbPXAthY+ZhgxQr1tfwW2PZ7m7ybwvSOCzSKHdJfgqgvE0rE7S+TJE/aFRL3jrZE5/W0wwPKTx5fIbOFoch3CqbUolgqNmPe8RuVO/CTQsq5GlnVE2dYDRjpMiT3OwEhnnLvwr47ohGr5PmNQc7o4DvLQCo9n0qbdwlYXys7FjFSylEusB5omHUI/buzYIgE8B8FbN4uWK3HOFz3cF1njkP/4fokBM4eoRj/pvNfGKsaNXGpqqUHxOeKXYchXkU+VwwAaVKYPAqkmK1wcFJ6+vF6nDIf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199021)(38070700005)(33656002)(86362001)(54906003)(478600001)(38100700002)(82960400001)(122000001)(55016003)(186003)(26005)(83380400001)(6506007)(41300700001)(8676002)(8936002)(52536014)(9686003)(71200400001)(7696005)(316002)(4744005)(6916009)(64756008)(66446008)(66476007)(66556008)(5660300002)(4326008)(76116006)(66946007)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?znpMHvilVf7LC5b6RoePy+zAEFLuVFeizDvY6vwbFeVdNU2+u7WIhV/dkWub?=
 =?us-ascii?Q?nQlG2JnacXAChc24O5M2z9CbzNsoz7VlorHAZ2f35Bmis16cLRI4kPRo4aIh?=
 =?us-ascii?Q?r+6w4GJ05TxOPr4ga4ju+TFHR+Q9M6frlt+cx78wgasGyBtgQ8/iARDKRwwj?=
 =?us-ascii?Q?Of8SSXPDoJ0JKncE/wGqVaUs56GSqzLH1xGd71IfEJE58DNkXmzLNRlcCjUj?=
 =?us-ascii?Q?UYC0nHzIKvZSIFyn0AykvTkkw8n9kdtphXN693E/7knJzTly/LUN47y4u3J0?=
 =?us-ascii?Q?pHKOW5zCFZXl+yer9TX3fM8MDHNfX8FpLBImkxXsnRl5lZwobkYqSZIbqBot?=
 =?us-ascii?Q?4A0LSWxuXaSkQLTSdt0ute5/R7fZiTXANnKQoaGdGFTnLEF6VCYettjBA9qs?=
 =?us-ascii?Q?lstcjVRlDTMXJmhj3qgSFRr+kjbcQS4HR3wDAVOCeKzdRLIfe+4vuGHTTK5k?=
 =?us-ascii?Q?5MHp3QBajVzziXfUQoTG5ouQMPag3DZUkA5qyYR8mWydid+pVdVsTR3iMd71?=
 =?us-ascii?Q?NveZqCW7BN/Z3DnzucXfTUvuqBtxJUjzXznLbudyc7QPyjO3NRbFFIRwG/xD?=
 =?us-ascii?Q?p9w8QAJMy30gFO3Bsapi8x3AlYkH5w0+PFc7mTpuFliXGdbBsv1wx2uPeCEZ?=
 =?us-ascii?Q?pbAUGpPbE22o6io2Db9NBCKiO2MCdkiOzFk6mo0kEicK2X3bNat65OkRIkMw?=
 =?us-ascii?Q?aeCwlzpiq9cMCyyxy6T9fbbcN1dC6ePTC7HviByPp7aiF2IHNhUFKjmBsAsW?=
 =?us-ascii?Q?e627gNFUcSwZw4e6yEhD9cYldlJsyIV5E8q4iR5vlBY7bioXEGhjIwFuLx0P?=
 =?us-ascii?Q?LeEkQXwNkVbVy7BCGOL+AzQH2zDAkjNLbmTZtYyGyBcN1f1wu67Cn9K4fUXY?=
 =?us-ascii?Q?G1lJtDWtNUF25g/ba40nKUNRIFE4UrWiUjIOwxAOKCkEmAViOmKVox50LuyQ?=
 =?us-ascii?Q?8/wLWEAGpwG2ShY93zV0cS+LpV1u9oh/eAr/NefSl2ChY/OMpAM6s1t3nRad?=
 =?us-ascii?Q?1brsbeLQ7+8d3xso8qjPf1aSJhVt7nsgGiVeYsHgzjX61fOvR3E/cn9gOaHP?=
 =?us-ascii?Q?vYFJ/ej56Ip+x68ehWaoz8gqBCplPD1pkxcT/sEKinJcdXuQLtqRGZkG6bBr?=
 =?us-ascii?Q?tbI3FYvUWkMpFIwDRLMydzHI13uUxTwTa/U4mDcii8Jqs28yCLEWSkgqafJu?=
 =?us-ascii?Q?kPX5edZn/P/0bU7mOKXomY+kVNr0Tgcd11XqjMD2ILmakPHVpn0ufoAiCJZl?=
 =?us-ascii?Q?rBKDCRQ7S1jdSms44P7ula3HRPGkc0znl1cFRGA00zvY4npWyQ0qBFrBFaq1?=
 =?us-ascii?Q?TnVcm4b9swnAz6LsOr56PEwZk2yS5FCn0G2k4HwAoGcCHFUzelw4NuYaodfU?=
 =?us-ascii?Q?YSKydh1EOCI7BP4JfghhMSTWuM1KvW1yzVznNYmdtZIxhaNAoQzF/sjrymul?=
 =?us-ascii?Q?eKLwvi10w5uZ+IAvvTmH81TV5ATCuAtCIpnp3nSSuOwEByUSnssAaFQxJMez?=
 =?us-ascii?Q?srJhU+ZUaqhCV+58NYhfpzUqCiR7jPhNZ+wfT25m1d9N5VHKtFrg/de7N56i?=
 =?us-ascii?Q?e4+ty9fBoTBf/JoE8gW7zRKRHEvXJcnPBnroCT2s?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b9d2ee-df3e-412e-b2f3-08db93c1661f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 01:31:45.4057 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RzuyTKjHU4dbUl1Oq6QMsvPOZyvXrltwbvsF3gLQxHS98oBTV1HlWl4rnCpx5fQy3DRKViFTezWWcX6tqJHT1et9s0C2nWurxwQRbzf76ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7733
X-OriginatorOrg: intel.com
X-Host-Lookup-Failed: Reverse DNS lookup failed for 134.134.136.65 (failed)
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

>-----Original Message-----
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [RFC PATCH v4 00/24] vfio: Adopt iommufd
>
>On Tue, Aug 01, 2023 at 08:28:01AM +0000, Duan, Zhenzhong wrote:
>
>> Ping, any comments or suggestions are appreciated.
>
>Zhenzhong, I'd love to, yet haven't got the chance to go through
>this series. I think that most of us are quite occupied at this
>moment by the kernel side of the changes.
Oh, I see.

>
>I plan to take a close look and run some tests next week.
Much appreciated, thanks Nicolin.

BRs,
Zhenzhong

