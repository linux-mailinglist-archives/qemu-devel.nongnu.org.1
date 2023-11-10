Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7319B7E77EA
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 04:17:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1I02-0003uj-BN; Thu, 09 Nov 2023 22:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r1I00-0003uV-NH
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 22:16:00 -0500
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r1Hzx-0001iE-UE
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 22:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699586157; x=1731122157;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=93WRGSB50ZP4hTW4OjQL5qONyCY+AxfPyoZBFM+4Wh4=;
 b=O9beDbe5NVCBWtitAQSr5Mji9IPXbPThAHDO1H16eC/4yUzcfzGcvFoS
 mefBAlVOrVTO0bsPUgQUo9fE0E2cBRUpl89wJbX883W7Z50Su59oZF+b9
 TB8iUE/ryml6rJv6b2j+H2RvS91OV1bnO+WO5HvXhNG1KX6vnoyQab0vk
 CTZyXYpfzrCPEl9YXsVlK5Bz7uiRMlzSUewrUFpntVt4HcJjRdhYD7ti4
 A45/icn7plV8uzpNl4e3/vb98V8b1ngxhctjCMkcKMRAbKbdijXLxEkSj
 eEsY5oGm57ftH08335fQxAYXzRc4atgDn6sH7X1RxRCuaxzKTVdh8leel w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="454423794"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; d="scan'208";a="454423794"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 19:15:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="4731816"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Nov 2023 19:15:54 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 19:15:53 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 19:15:53 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 19:15:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THa/vBCJJ2pB9kzJDVXg2sQyLrK6HUJwSnlhpnKWNa+VD8XxiI98YF+goi6Bw/it1+oI728oyqyasgNJ27NCRYkjwI0DV5cfsCBMF/7c4m7RfjWvnZWvFPK+bvQvyeKh6/uLXZ7IbXQ9K/vFaI/Xck9ZdLJTFibAOevkSXaLObhSwYmn1zRtqh1RSFQDQBzBFYr4W+uUX7dqJwz+fTlVWtD+dFwsco/VM0Ulmkx9LlEG3pfb6HsQS+oFeWUlF5ajD/P/IuCkJamu6G7dTXj/ZmTz6Jj0AQUngQ3iuwKKE88k+i5ozitJIU10661kXttJ3LK8makn5yE0rZ2DX1MPbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93WRGSB50ZP4hTW4OjQL5qONyCY+AxfPyoZBFM+4Wh4=;
 b=RJyfOZVX2ZxjfvE83Wde91bPI7d1UD74tEOa3v5x7sG9/lkb0jNRppf2NsONq2CKO08IPjb1z0Vw0IZ1luqHz2Tb1fDz4xN0NTgN+UkUfZF4pLTj5uw7uGE6DspjoMQ+yzhBEO9Z/JypFzC8C9ILrqQDer1tm07Kw+EEeSM2U2b62uHAsdXNr1DCPEhwBakKu5mLZ4ZS2kEGW5zh8gAdWKYbuaDXZT10LdIEOkH6uXgfzvfffoJx0jCqeBzRqRiWlBW0m21zhADzfbqLa0W4B1c7gmlUgpXQs0J6jcOLDjQAWN3rInqSM+9U9NA6JZUc5kBCS92qm52EWLUVs1JXgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CO1PR11MB5076.namprd11.prod.outlook.com (2603:10b6:303:90::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 03:15:50 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 03:15:50 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Martins, Joao"
 <joao.m.martins@oracle.com>
CC: Matthew Rosato <mjrosato@linux.ibm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Thomas Huth
 <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>
Subject: RE: [PATCH v4 28/41] vfio/iommufd: Implement the iommufd backend
Thread-Topic: [PATCH v4 28/41] vfio/iommufd: Implement the iommufd backend
Thread-Index: AQHaDV58rXzWcAbguEiSUs8ukZNa17BvxJKAgABFgECAAF7hgIABicGAgAALAwCAAACygIAAAP4AgAABxICAAAOHgIAAFEgAgADT6yA=
Date: Fri, 10 Nov 2023 03:15:50 +0000
Message-ID: <SJ0PR11MB6744A33106EC2DFA66D397B692AEA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231102071302.1818071-29-zhenzhong.duan@intel.com>
 <76538479-77ec-1a7d-cee1-906f6f758cff@linux.ibm.com>
 <SJ0PR11MB6744D87FD3CBB3380647E68792A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20231108124817.GS4488@nvidia.com>
 <b6f22a3a-84cc-44ab-947b-b7e12656fe87@oracle.com>
 <20231109125700.GZ4488@nvidia.com>
 <592a04c2-0b4e-4bb2-80e4-f4c2dfacf00c@oracle.com>
 <d7475721-2388-4b9c-a47f-1891e82a635e@oracle.com>
 <20231109130921.GC4488@nvidia.com>
 <c761227b-360e-47d5-868d-2cfb71080a46@oracle.com>
 <20231109143434.GI4488@nvidia.com>
In-Reply-To: <20231109143434.GI4488@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CO1PR11MB5076:EE_
x-ms-office365-filtering-correlation-id: fb71b817-5233-429a-88dd-08dbe19b5720
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pkgJjc3dchojJlmAnvH/wj+YfV9cFj8E2rFWEZrgk47DjEbkf4p/noRkS/u8iUn79lT9pFNdn4PMuMmBZB4znHJVkX+JF7v9Fb8/kmJ2Qez1qDhw10Nc7livhqQd3MYTnlFP14bVZPTs2s3l0Y2MofdfTUb0M47aYIdELwN387UxZ5sUhqGuKuHka5Xo5AY/HhC/GVusXTlfX/smi3O19vIjjeM435bJPm+tj03TOhi25HGEquoI/S7b6JLQXJApFJPwCxq3E9YfrS9yQTAw0D3DpZi5e86+jU5NU5euvYrkPq6ioXbB40+JWuCGAkXxw3tYeS4bT8BJblvnPhXgjssGIFIHBoNbbs3jvvBWspLcevqBJsfFvLbFqcoJX4uQlTDBvHrJ/kvHukjQZ1CgVCrZOV9eOrbHCBq9mwf/lw+S7sQ8A5/1JD6ZOG/b5asyJEIwExNqXKlm29OGfAOnuANZCO6UU/DGN36Jz7LOJCnJN7ORq85dsgHmbmpxuBBhK7R+LDKOQ1OgQyJz/lP5We84D0daDZT0ifjTisYyE70MPbgdpfQe62onIb4oyzqZqDjbQeeCO8thwpu+seB5VIWF6nfIxSG+XgP1evfbI/LPS6Masg5ovsQGj85FLvqc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(53546011)(478600001)(8676002)(4326008)(52536014)(5660300002)(55016003)(71200400001)(7696005)(6506007)(83380400001)(8936002)(316002)(2906002)(66446008)(26005)(110136005)(54906003)(66556008)(66476007)(7416002)(66946007)(76116006)(64756008)(122000001)(38100700002)(41300700001)(86362001)(9686003)(82960400001)(38070700009)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?15BDScRlaIAoXSVWim8ZFy4zxPnN73kHexklqyU5/lGQg6Vf8ZNikFi9CJXA?=
 =?us-ascii?Q?Bej8vKbi6usPYbmbWRU2nfDmQlXAIJqWU8D++zODf6Vt/Y5UwevcqSPThiR3?=
 =?us-ascii?Q?IV3RomMGGMdv7qBguUXQBqUzbHbcjNPHsTjs54HZUjSzb4tqBMDFrhHCRUTc?=
 =?us-ascii?Q?yGYVSAipdgazrH0/pzSoeQihz5Xo9u+AXiVV25B4hjKG2HvkYYuHJAgUtAQZ?=
 =?us-ascii?Q?0Yc4y4d7gjTCyzaLZyPNLkFxlRFiN/+MUJv/rr4sXtPpavpCYLWyujQxrlnU?=
 =?us-ascii?Q?RTIUc9LCoUmWY21vmP+JofykBRTAD9mEKFWTYLl7ytUBB4R0Ly3lti886gYi?=
 =?us-ascii?Q?8L9DMcK1xyHumdT1PmdiJMwISA/uk47US+4rM8XCmOWBNl8HRXuQmwLG11SJ?=
 =?us-ascii?Q?6rraRI5ve0jTtmGNGIgB1YCj32/bUBnczDpMdD5Fm5chna52wLIMTtKiummG?=
 =?us-ascii?Q?lJ8QjegqniMs0lf1fCjJoqDO7068TY+jnrAs8fhhyM+FmPGOySLxIRGZKmec?=
 =?us-ascii?Q?qkCPk/k2l0++rtmtbPNRLaba1oUkSPDZL6E1TyIqnZQ+/BGqIoK5MFas+MSZ?=
 =?us-ascii?Q?/A+1nI1LHmsYOaJHFtoN3lSYHnIo54eeqppe2KBYJZbfTJVfDWLV2w42S5D2?=
 =?us-ascii?Q?M+4OY8qD+TnT6tdb1NySlvCda0Y6KiuLfdGLD0DFaSRFxF+hV0UFT91p8Ekl?=
 =?us-ascii?Q?RkumUJwMQLTWapJaCbF+kOWaQ8TbuQm1TreE+3res3qlVRC/hwyaQAPMq5yC?=
 =?us-ascii?Q?5HGGBP9SbUO4UlUhPrKsJbZTAwDbEPafNwHN418DtPtuTFTJOcvwyfsNyS7S?=
 =?us-ascii?Q?Lizq2nbO0aWKIJV4A5JjH9SJn3NQ4jrFkEGlm2b3ZQCeiqQg+j7rB1rIama+?=
 =?us-ascii?Q?bu0k0iuEl+brRfz9feOrS1fdjR0xXR9Jdz5+lIvSVyLAIf7S2sOGDA4UWJ6i?=
 =?us-ascii?Q?lqaWeciaztbV/NuKb28bw7MkXkK4SXwWxKVAvS7Lo3/LdsY7Fb+sUI7R1rNS?=
 =?us-ascii?Q?N9btc9RrxEUdY80DDIJZkNUiWNxNi8DaBcGT34bfvQzTa6H6lQBeyJbN/JXa?=
 =?us-ascii?Q?5fuRn5DSde7bi9LqmT3BDAX7wazW/SlhgSzQ4CdnDUwl+0hpBGwaf9+hySsl?=
 =?us-ascii?Q?UMb7UIVW33hCrHJoXWHVW0dQhtHYxGuyuGmdoa8jCH4XDHpkoZilQ6r/k/mU?=
 =?us-ascii?Q?yz+l1dKx0EUzQ/t9PIGAe1ggmgrbOWg0PKQVocRrTWg6h6R/myWFVp14VYqR?=
 =?us-ascii?Q?nmzo2epwLa6c4OY3BVhH13Vj4D96+jZ2VbCqb+xuny4zObILMJSf6nhLfgrI?=
 =?us-ascii?Q?1Lx5iuU5lRyGSdg7YkBcbjoe8GBVhFhcC5UmYm8ghgyf+7h42otY8dsPF27c?=
 =?us-ascii?Q?LA3UC7j34hZ58DP3kG3FOkUSRN4Cy+DJzuNHmYgwH6+kTtvAnatBFRabH2U0?=
 =?us-ascii?Q?1HElz+fL0IpE9f8thk9VL32isjWVqha0Ppu2TPlRDpDxAXZ+d2wS2atGF8qD?=
 =?us-ascii?Q?9+qbNPK+bqV4w9d7J8oaxYD4D6n9YtwKBfJwOLudVakiJHv02jq8BY/Xfc1S?=
 =?us-ascii?Q?39xOP+3PhBavAI3Lzjj0LisvKiojgLO3mdY80fB5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb71b817-5233-429a-88dd-08dbe19b5720
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 03:15:50.0437 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oy6MQMGALYOtSlBlr01HC4mYHwjYs6fJAmiMiIPHrm2cihjkkejvqWsWdwXhK4y2mr9wqQf61yuhmq3fb2ffKLk8F+Espqnj4H7wAdingV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5076
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Jason, Joao,

>-----Original Message-----
>From: Jason Gunthorpe <jgg@nvidia.com>
>Sent: Thursday, November 9, 2023 10:35 PM
>Subject: Re: [PATCH v4 28/41] vfio/iommufd: Implement the iommufd backend
>
>On Thu, Nov 09, 2023 at 01:21:59PM +0000, Joao Martins wrote:
>> On 09/11/2023 13:09, Jason Gunthorpe wrote:
>> > On Thu, Nov 09, 2023 at 01:03:02PM +0000, Joao Martins wrote:
>> >
>> >>> I am not talking about mdevs; but rather the regular (non mdev) case=
 not
>being
>> >>> able to use dirty tracking with autodomains hwpt allocation.
>> >>
>> >> ... without any vIOMMU.
>> >
>> > Ah, well, that is troublesome isn't it..
>> >
>> > So do we teach autodomains to be more featured in the kernel or do we
>> > teach the generic qemu code to effectively implement autodomains in
>> > userspace?
>>
>> The latter is actually what we have been doing. Well I wouldn't call
>autodomains
>> in qemu, but rather just allocate a hwpt, instead of attaching the IOAS
>> directly. But well mdevs don't have domains and we overlooked that. I wo=
uld
>turn
>> the exception into an exception rather than making the norm, doesn't loo=
k to
>be
>> much complexity added?
>
>Autodomains are complex because of things like mdev and iommu
>non-uniformity's. Qemu can't just allocate a single HWPT, it needs to
>be annoyingly managed.
>
>> What I last re-collect is that autodomains represents the 'simple users'=
 that
>> don't care much beyond the basics of IOMMU features (I recall the exampl=
e
>was
>> DPDK apps and the like). You could say that for current needs IOMMU
>autodomains
>> suffices for qemu.
>
>Yes, that was my intention. Aside from that it primarily exists to
>support vfio compatibility
>
>> Connecting autodomains to this enforcing on the hwpt is relatively simpl=
e btw,
>> it just needs to connect the dirty tracking flag with same semantic of
>> hwpt-alloc equivalent and pass the hwpt flags into the domain allocation=
.
>
>Yes
>
>> It's more of what of a question should be the expectations to the user w=
hen
>> using ATTACH_HWPT with an IOAS_ID versus direct manipulation of HWPT. I =
am
>> wondering if dirty tracking is alone here or whether there's more featur=
es that
>> start to mud the simplicity of autodomains that would approximate of hwp=
t-
>alloc.
>
>This is why I had been thinking of a pure HWPT based scheme
>
>So it seems we cannot have a simple model where the generic qmeu layer
>just works in IOAS :( It might as well always work in HWPT and
>understand all the auto domains complexity itself.

Let me know if there is anything I can do in this series to facilitate
future qemu dirty tracking support of iommufd. Not clear if I should
restore to the manual HWPT_ALLOC method in v4.

Thanks
Zhenzhong

