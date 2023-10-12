Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB417C7066
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:37:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwo5-0002XM-Nf; Thu, 12 Oct 2023 10:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1qqwo2-0002Wc-0x
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:36:54 -0400
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1qqwnx-0005cV-Uk
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697121409; x=1728657409;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1xAaMxnRN5tRFihdp+eL7nX7Jz8GIwWEb01R44UnoZw=;
 b=h/OdjQNXXXiM2Nfoh3rj6a6DBMls9JsSPLyyqL4E/K2MOkKi7HSO31rs
 6Ou0Hpb6FkJTmi+mMIJ5CPCJBjXflDak2QDOR/+irxP7TcL96MU6zJNgY
 qJguVJakE7CSeEiMjQQkcyH1mGxzMZLwEvnWx31zjBBXIJL2gjmdzOMlp
 lsDGea9db7YopkskHfLm7awFXsv2cFASkGplI4N2zA+cYky+wQkNff4sJ
 Zx8e6QCcyLgODxYJJupKxT6P4ArXNy2OH3T2+sBdl9flL3aASzpkcEimx
 5WMb95ANArcCa9BiVYO4qQd0gvMmCACUE7U8J77qjyywmYplzH5JBTYRi Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="451431126"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; d="scan'208";a="451431126"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2023 07:36:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="824634903"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; d="scan'208";a="824634903"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Oct 2023 07:36:43 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 07:36:42 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 07:36:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 07:36:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 07:36:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2dKyBc8E6MVSP0pVw6gEvcMSqhmg/uF/iJoUHZsVJEAuZbD8zWkoTQU1c3vgZL5VL4stIZe71DqoyyLD03PhcfwJ/mFNU85gaoE/82bMFNzD4SB2Ai+o78m04Qydhjj5YkPfHkI/ROGIAYCNeA8FPZRg3rQha3E/mm+QbPIXKEdske/zQ1x68zz6hszRqKgCw9YgJhwsIZsH5ZjKm7cypfm2ELthEDbbXW/sZv3DckmlWy16TyXbRXAxu2ltp3Hw9FqU8maFN3GWu7wCctl2ZWF9wjd4kSTr7Zj+sk6Xg7AYiegjuug9hIRPMrx8oCkWt5oan5TXvNHlksF+i9BCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xAaMxnRN5tRFihdp+eL7nX7Jz8GIwWEb01R44UnoZw=;
 b=LM75NPVe0S+vqyKcKZxd2JGEqBTLVjbmtOIx+EDmJf98rqI7IcYgQWI7P8rjXtIYkUC2JRa+mz7pMUFo4Vi21iCYX61Lke/g7pc3jaaQ2WnNPYpoICkT5eyvTErh2ybxKVSoNcgzBD3LApb2XIuTGo1aw4PuvYKSgVOSX/WcH2D+exBB3/pgbNsYXa7APqJt4Pst1oPSE4fX30bbZFQLwy/IJsDsGWakB88SaATmZPCXGV182+fKeOAAj/GOrNmF/itYNz980cVxRr7d2TV4F6qsKkeHe7fhS3cKg7A3lFCkY19Sx3N2IC9Udj4Eii44+ng5A42+fNihvHtewrh98A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 BN9PR11MB5225.namprd11.prod.outlook.com (2603:10b6:408:132::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 14:36:34 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::6a55:3e93:ac5f:7b6d]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::6a55:3e93:ac5f:7b6d%3]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 14:36:34 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: "quintela@redhat.com" <quintela@redhat.com>
CC: "peterx@redhat.com" <peterx@redhat.com>, "isaku.yamahata@gmail.com"
 <isaku.yamahata@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2] migration: refactor migration_completion
Thread-Topic: [PATCH v2] migration: refactor migration_completion
Thread-Index: AQHZxrZrzbuQ2/SdmUaa0xzmirIuk7BE8xyqgAAgJdCAAGNkCYABLV6g
Date: Thu, 12 Oct 2023 14:36:34 +0000
Message-ID: <DS0PR11MB6373765B01E9F78463675C6DDCD3A@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20230804093053.5037-1-wei.w.wang@intel.com>
 <87v8bdbac2.fsf@secure.mitica>
 <DS0PR11MB637312D6D5D3E178D4B034D5DCCCA@DS0PR11MB6373.namprd11.prod.outlook.com>
 <87mswo7vfg.fsf@secure.mitica>
In-Reply-To: <87mswo7vfg.fsf@secure.mitica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|BN9PR11MB5225:EE_
x-ms-office365-filtering-correlation-id: c83ce3cf-a512-4a15-d200-08dbcb30a225
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oe+xatqLQPxfFOakUkoiWfZxZ8h4s6NfljMWUY/afM0Y69c/LGqsvfy76FU3uNxAPPc41QM9kYkXectuo64PQ0U/5gUq0BTrGVyPVD8vbd0+zkshiPicRreE3Mx3Xu5eVIHN4anMXpRn59rxrObTde8KraMcFA/UORZCbThaN+2No3xo/3Hik/IBjzyRmkPgv569AkW1M8Z12qgS4xt8RIpM5QtX0jQKKWaF+vr9RkK47XBStFcq7iCMcwSNu5YsyziOhk5bEwzsC1PeUx8Y0YkhXSxq8aSEZEDqTDKjVgdkz4VhmsWtDVsd75gIPtGszjoumgHC7XFGgW3y2b4kcAK8toVv6liHBsmIP1cCHcFaaZBS27WF4rzMLZ3fuPVZy0ofq2lUDis8py2NMiB6lBBPcWtdcCCeW/lNQBZyLHbhvoolWqQFTFgd9ee8p5oSaoZTEeLXblqn/8titgWwtiN0t2EGUmD5bJnrl38i68hevF6gZkbG9X3BIIL7Zd46HgTyuDNgVNEZLvdplv0xbRL0c14dPEDPqQMvrze8QPoDIpYRH7nX8tdUSSvOxoYiADKb7uE2SUOjmB98ZgrFNAADv5HW9u8Ah9ui8QkKgS7J/XZ4O/obYL3WX0n+4oFb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(478600001)(316002)(6916009)(7696005)(6506007)(53546011)(9686003)(64756008)(54906003)(76116006)(66446008)(66946007)(66556008)(66476007)(4326008)(41300700001)(71200400001)(55016003)(52536014)(8676002)(8936002)(38100700002)(33656002)(82960400001)(122000001)(38070700005)(26005)(83380400001)(4744005)(2906002)(5660300002)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/pqOUnqnB1ceOgoBcY4dRq7Kyr1cTDemzx10AB60xHq1LL5D+hRcocufmpgd?=
 =?us-ascii?Q?aeYRVZRNlY6sbrEWD5vuc2fZfza2zvVnTrzfxafUTZL1tPlK2mP7bLIImmao?=
 =?us-ascii?Q?YmfbOWkSwr75LPZDscQv1+S/0f9zkdCWmgLJPFw0TNJXEW9eLY2si6qbrLBf?=
 =?us-ascii?Q?vxu/R7twCfWh/PE0PgRoXDvgcRV1Y6gxcAcfzRcsWvf5O18m7hIIN3VDcUxD?=
 =?us-ascii?Q?lNytozDiJR2RkuIfoD3twDknPY1FuKUhHAT2LlMGTnP7zuT3sIzgqlP4p8/3?=
 =?us-ascii?Q?e/6LyCTAePheNvK45wZvIB4i6//DNUj+VIu+HbfnrTveL7fql1GNPXBesA+X?=
 =?us-ascii?Q?Jt51UzSPj2fMWiVs1Fu8LX9BR4InT1oxHVYG73ofC+rddvLOMW4vHQ3bHJ2n?=
 =?us-ascii?Q?XlvBfShpoI2wkrzI2JxIgusmd5M/RZzUF4SsFcxWFN4XDBjF/aeutZEwUA5g?=
 =?us-ascii?Q?a1+3FbGq395vwq59bAV4Zrgnjeb5xPxd3ZX1uc2WGUMGfn600jj3oCgKSBp/?=
 =?us-ascii?Q?U2ASGWgHG2WnKt2oUzyiyDi5yTJkbKWQHcnqQG14cRby23I1KN+87zlmafBv?=
 =?us-ascii?Q?M62TUcMMGdIUAHNVQvoi2WCaRlkEU1Z9u2x2kaiFH+XY3WZg47qwgAhBtNrY?=
 =?us-ascii?Q?mrujK2RW/F9TlUk7UmpkHzsax71kp2CWfK5aNFaHDt/HaY/zMcKfCCD7sY8c?=
 =?us-ascii?Q?qsbXmqu3r7nGNISnh9ta9Z89qJNeREG5ly3COzXlTLk/P4T9eqSjvv8GpxXa?=
 =?us-ascii?Q?d/TPAp3vKmDYklA21OBfN3DCGZ0B2XdwXYA95sDCLWeS/W7Rpu+1Ei7bepeo?=
 =?us-ascii?Q?ogXFZkbIe3EU+Cy9JAjRpJeR6Z26yAfRQ+Z9W96UrwSnOXIVFAnVkM4jZjtC?=
 =?us-ascii?Q?BQAOdlVpNqF05SjsLOtYvhq2/jNBmYGiw2sC8EMCVlrL7n0OO3WXFk+fNR3P?=
 =?us-ascii?Q?+Xqr1PG96CTJEHDtThVTlOAzBFEm90zjdZfrskXiOz2ZiMwoPhKXkiOvCREC?=
 =?us-ascii?Q?jX/Uc5ad9fooFCXd9HbnrgGRxtfpQD347f5XMrsbk2+zYP4460EfPpYpiXXQ?=
 =?us-ascii?Q?6tIqlqxjHyJdlx0diH09S98nXQixCjqM2lrrTwrt8nsq/o7/TwjSRhKJttQT?=
 =?us-ascii?Q?S5Lys/LHsPiGisCBCa7vmuv8Da3PJ8vH4I7jZLwlQ5S/6VGRK2f/xW2XIK5b?=
 =?us-ascii?Q?oMW5BvK1R2TkAlf15c3WlbqPU7c5RfzeleK0GdXi0ulNRoK5EtW0SsS0v36f?=
 =?us-ascii?Q?YUAh5O8utwuZjy14Q4E2lgkR1p7QHEeqqs6YiztyLB6G1ioOfYc6+Vup3bJS?=
 =?us-ascii?Q?o+2odQ98d1MzFWlBtETMrU/MCOiYB+Z7dws7+TFAA0hjy37T5/icBC+u9e0d?=
 =?us-ascii?Q?l338OJMoPchCAHoF8vhMaL9mGL13eyg10NAhpxut4S78tsi6ISLquEJRjudF?=
 =?us-ascii?Q?aT3nBskJy9xZ2KgGK0E447niHArcyBdQbnym/ik5jlfjTHH9re/T9yPjuoc5?=
 =?us-ascii?Q?DOq/dxiVjDi+BuxGuhHt6ADJcuw08gwfmQq/60b3QGnAtxGNNgzLOLSB7Sza?=
 =?us-ascii?Q?QxT3TWzZ67G4CM87RAyYmcYFANxhsxMY5WW6jWIW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c83ce3cf-a512-4a15-d200-08dbcb30a225
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 14:36:34.2292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aWoo2oQsb4ptwq04LNQr6fntjGEMdkj/x5c4kES7zv2F+E+Q7Wn6Zu1blM/sWFJorc1vhzZMItiXL6hhkespnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5225
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=wei.w.wang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thursday, October 12, 2023 4:32 AM, Juan Quintela wrote:
> > Yeah, this generates a nicer diff, thanks.
> > I'll rebase and resend it.
>=20
> Already on the pull request.
>=20
> I have to fix the conflict, but it has the same changes that yours as far=
 as I can
> see.

Yes, just need to remove the conflict part, other changes seem to be the sa=
me as before.

