Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 691F6707C8D
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 11:15:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzZiJ-0002IB-E1; Thu, 18 May 2023 05:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1pzZi7-0002Hs-QJ
 for qemu-devel@nongnu.org; Thu, 18 May 2023 05:14:15 -0400
Received: from mga17.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1pzZi5-0002Rf-5q
 for qemu-devel@nongnu.org; Thu, 18 May 2023 05:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684401249; x=1715937249;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LytkzkZWWRC174+YtCam9owIWxCAPiaenL62gcId22s=;
 b=av+beGwPbobfBBVK1p735Jt7Yrw8SLs61kxgipHPo+X/NaFrgwGGBJFO
 7cRbMltWjIXGH7afzRFzGc/Ex23Bzmxiq9uUJnQpy6jjXvLi8rbMtTjL+
 peyLqOfnMOw5CDe5GXWRKzrYNIMYPGBJ72ENPLtbE3MZDgjl1yz+m0gp3
 Wg4lAOhCxyXJDdZrLxbBO5rUYQNq3bFARzrje7gzkFGhnXpnN2MFBHfjX
 jELEYbFwLiIMdOCh4/EqrblQ29wABLCPo6f3NdKbo/mpPYOSnRXESSafc
 GDdMP+CLlsUj2LeFZwZPZQWSwjEw29XP2ZF1rgVyBB3IH1hhH3Z276HqF w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="332383058"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; d="scan'208";a="332383058"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 02:14:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="826294731"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; d="scan'208";a="826294731"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga004.jf.intel.com with ESMTP; 18 May 2023 02:14:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 02:14:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 02:14:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 02:14:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 02:14:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cwbey60Ntwen4KEgnubUYpLVHgu7aLPOm1rqqmc7ONNuqiXdhl+BPxia269M/z+bIa5rAvzS+vzg7CnNs1G2ZOknvn+szj7IIrNGQpYPLaMFsVAYKmr6d8r5E30DIpXA4b733CYXPrCPh120z4Qwf4kbKlCqYgT0hWH73b6B5pgU4DeiDFI37PjjI/YfWSR1NWnPAx2k6yWpJGuANq/VJ+584LY7HmmOsmZrJ/ET7Aj31jZf1bleyfOda0NIZh0AnEz5xHaraFjgFleXiqy5I2H2HBRIk+qQefrtLfbvsVzuL4pdAEaUE20NvSrUzJLsa0SjNuKQAyoMnhQFO0Qprw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2zmt73clAxQmpqY70Z6Z7WyPQyiucqy72FNaYfGG+Q=;
 b=nacRhq/cSBfMwZZWjakxDanGmsSVxAOJq2te1+2zwpU7tBK0n/m9QdeVi74lYJu3MyPJ3lCfs9dexzMICuzkhgNUhENn6iZ1nfkJ/rIAqdiVbsZr0Z2L6LQnxjeu1giQW+dkTu/e0tsB1HKK9tMkhhKWsiT5Mku76+D6o+e0ZTjocOKKyTUQDJWTKsA1h1x3GNe3f+3vydDIK3j96cFEQT2EmY64kB/FOceBZejyBMpy7fZFtIU0rx3GpgJbiJv5UmUu1fycXihrpNa6DOGrJB9dZqSu5qJnTxVpySbbQhlHR4iMNplCxh4cPSipbU13+Ndbnkft4+XsWoF7LGuWEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 IA0PR11MB7838.namprd11.prod.outlook.com (2603:10b6:208:402::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 09:13:59 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::14c:205:c858:1ef6]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::14c:205:c858:1ef6%6]) with mapi id 15.20.6387.022; Thu, 18 May 2023
 09:13:58 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: "Wang, Lei4" <lei4.wang@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: RE: [PATCH] multifd: Set a higher "backlog" default value for listen()
Thread-Topic: [PATCH] multifd: Set a higher "backlog" default value for
 listen()
Thread-Index: AQHZiWYZ7y7VWW++XEaEtTpWSpii1K9fvHdA
Date: Thu, 18 May 2023 09:13:58 +0000
Message-ID: <DS0PR11MB6373D659BCA67BD75D8ECC5DDC7F9@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20230518085228.172816-1-lei4.wang@intel.com>
In-Reply-To: <20230518085228.172816-1-lei4.wang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|IA0PR11MB7838:EE_
x-ms-office365-filtering-correlation-id: 040da3ef-44a1-4d05-dc8e-08db57803648
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VcldP67LDQRz1zEjdESPdHAcHf0KSmklJIjbUpLRXmGuQLb0f5va1EBFW5RmxevExuC/+aK0cnBdovxHOnf8MOF7/v+jIPaw2QN23bxd/FtmspOf2D4Qpij/L+cpFOuFp1noRpX0j4aqVT0HohXE5ycx6vZifL7GiDDM8zvQiqewO8h8YB5h2EI9pV6dPtRRzFXLi1U3cnSouDNJFAX5Y+xuecoOjPPqvVOIVnZEiy/3y19XVUnrTeV3WkAUmmbgbN2fLtU/2c+Mk0StVV8P/j6W6YrHuClHF61i5noDrT4izEquo1vzU0fAkt45HTX9sqbWEmPw9xl/WB7zAh8U4x0E7NPOjNYoZxhpDtZSGtK86qcVQxVDne6xsyi7ITWRF6k7y3J73o4KgUfUakhciO2KiW8ZK3fsrI+GQrKa/5krnU3hVddOqOvRQEZShHqQvya4oE927Rd9HkP6FjfrWKWzR8FyYauW9svylWExPvkNqnJJcTUFCQ4YY6j87xZ4lY0WtiB9MWJh0e2Et8eeehwA7qWyu1KHbTBVtQdZuYLz+nLFSaktwSP0jvk/VEjG5FY7t76s8xhZQuX5Li03+6YRag2cbpB56HK1Nt852IOb36bM8YL1k+NNcUp09KOM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199021)(2906002)(316002)(478600001)(52536014)(41300700001)(4326008)(8936002)(8676002)(54906003)(110136005)(71200400001)(64756008)(66476007)(66446008)(76116006)(66556008)(66946007)(5660300002)(7696005)(9686003)(6506007)(26005)(53546011)(82960400001)(122000001)(38100700002)(55016003)(186003)(83380400001)(86362001)(38070700005)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cgpLmOKksxwcmckSEh+LDBpju0occ7AwVinkUa2BHO+8E54ShX7PakVlNlX6?=
 =?us-ascii?Q?/rn48Z7Kr/+soOakm3sBILk1YCwYFIyl8tv6lcvFXMcQ28nRJKR0v/RVNxQP?=
 =?us-ascii?Q?its5GwJs4C6U0ssyPVCwMwheGJER6LFcPhQ4U5MB7LV0Emz+R997qoYb40bc?=
 =?us-ascii?Q?1fATmyCK9LtLsc6bMgM9by/WGRHEGONoN5CQqgEM34CupN9Zqy5S/Xlx87Mc?=
 =?us-ascii?Q?GIpSKKyiB3NAY4Xzrac9nl+hdMdCQy/8DgacD6YAj+2Wdp30rXe8wdrabqZB?=
 =?us-ascii?Q?fad+f/sdvhomovAajC+p9yX5EVn6AwAaGUyGfuXSv83wTdSpoySkrUPI4ytk?=
 =?us-ascii?Q?UqLJULnBiYCTACKIQJx1yM1M7McZbAEwg2cR7dpay/598sTf7KN7sQ4Qx1em?=
 =?us-ascii?Q?qP3eF/g7Zi4MK6K8K4/o4N02/9Z1qKvVc/xfdJblr/aPbU75MWFMn1nBywr4?=
 =?us-ascii?Q?ipI2d0eAt9XrrOE1F3zG5wnye1qTAR6rS1SPytV/v2/U1yNFUMtNDe5hvpEt?=
 =?us-ascii?Q?V2kxCHwBJOR0YhIlSsKfslc0f71E/odasoPbyH58RZv2LFYky2wcTI7yDiem?=
 =?us-ascii?Q?i2AetVZRWLdDl/u3MlEL9L/CZOz5BIkvWIW3a2C0XcTlNbTtL18UxGIpSLbm?=
 =?us-ascii?Q?BjktTSZeh3ziEM9TTvQLxdvAJJqN5SSoMLkPrVMktIjenFDF/U6ltMjm+V3C?=
 =?us-ascii?Q?VfbH0+Ug4BA6GJ6iQrBan2x3o2MmY512b3wFXSsHET/ejNhryPYJfaPI92s+?=
 =?us-ascii?Q?g17S9r4thTR2suDMpw+oTxRxyNaGWtEULU7Cy/uC+TXpNlbiA9D0O+XllNKR?=
 =?us-ascii?Q?Sj63ISiSQg3NZtiBJbgLLLOX2Ay2yuGfC4br29IUY1n1ZY/geUl5whUG/8dE?=
 =?us-ascii?Q?a/3NPvB2xodx3r7N1NBVzC14Of8LAKTGc+zHRTWaRbf/o3/rwhgbGbLLkOIS?=
 =?us-ascii?Q?/dnQCU2A+/rcPGzegc23j0OEb010Q1O4ZifRcsK2BT/BvE14cArM7a+QUuzN?=
 =?us-ascii?Q?EOxzXB3hqR8+VxteZMsgWt/DDSXa8MWysleEhK0kQG1LlLPWDB1jOhK1oJ32?=
 =?us-ascii?Q?0Uu+HbGt8dw1Hair1RWd2KV+4omH1dCIPJEiQ7nRyNhoMO3/CuMnKZ2uX7c2?=
 =?us-ascii?Q?HnAxdGdK01qpAzXzyNWwxTeM1FCk3LNqQVxhF0D8OSR2bqq5AudVVyDC9Od7?=
 =?us-ascii?Q?6I5a00ebq32UcrbQESKKfB1ytX990UL5NEVqpN4PBsdGv6F5DFkBOSqAyAxj?=
 =?us-ascii?Q?ikBeXz2vySXIlJBkiPQTrj/Avf9PgoLuqc7cVB8NeDGrwZi/1rP9xAXyQAHM?=
 =?us-ascii?Q?uXZLLJE5/0uFUQFuw6JSJzYPzZjrldSyjWFqUBzb5Bp3lSnAhFH6zth4kinN?=
 =?us-ascii?Q?mbMaNxais84vfNehVt+o6l++UDllO5fYA9ZQXMyb7sLWMPlMgnhlr7GsU0Y8?=
 =?us-ascii?Q?3L6/isb3GWE/qBG35WMMrAnhOvJH5cb1ZD8BfIaIID9S1f6rFiuDEOqbDyvz?=
 =?us-ascii?Q?zM+rnUKLTt1Apr7NMe/QcvZ+B/8YMqinj5+Xk3DZt9mrNNN9dYwlqNYtqjBS?=
 =?us-ascii?Q?5sssAOHl+ABlDwz/3IFq6tjzSh5BkDAlPEbTOcQ4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 040da3ef-44a1-4d05-dc8e-08db57803648
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 09:13:58.0615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XP/W0uhPu6MLYkUWwIIPi2ruqy5BGhx2xRNcHZcL2D1qxtKqBLIwCEvJArtfJZalgEQfFur4MxiWCLmmnofR3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7838
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.151; envelope-from=wei.w.wang@intel.com;
 helo=mga17.intel.com
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

On Thursday, May 18, 2023 4:52 PM, Wang, Lei4 wrote:
> When destination VM is launched, the "backlog" parameter for listen() is =
set
> to 1 as default in socket_start_incoming_migration_internal(), which will
> lead to socket connection error (the queue of pending connections is full=
)
> when "multifd" and "multifd-channels" are set later on and a high number =
of
> channels are used. Set it to a hard-coded higher default value 512 to fix=
 this
> issue.
>=20
> Reported-by: Wei Wang <wei.w.wang@intel.com>
> Signed-off-by: Lei Wang <lei4.wang@intel.com>
> ---
>  migration/socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/migration/socket.c b/migration/socket.c index
> 1b6f5baefb..b43a66ef7e 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -179,7 +179,7 @@
> socket_start_incoming_migration_internal(SocketAddress *saddr,
>      QIONetListener *listener =3D qio_net_listener_new();
>      MigrationIncomingState *mis =3D migration_incoming_get_current();
>      size_t i;
> -    int num =3D 1;
> +    int num =3D 512;
>=20

Probably we need a macro for it, e.g.
#define MIGRATION_CHANNEL_MAX  512

Also, I think below lines could be removed, as using a larger value of num =
(i.e. 512)
doesn't seem to consume more resources anywhere:
-    if (migrate_use_multifd()) {
-        num =3D migrate_multifd_channels();
-    } else if (migrate_postcopy_preempt()) {
-        num =3D RAM_CHANNEL_MAX;
-    }

