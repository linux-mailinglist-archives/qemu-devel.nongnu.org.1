Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 637507C573E
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:46:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaTH-0004wt-3a; Wed, 11 Oct 2023 10:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1qqaT2-0004fY-Dx
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:45:46 -0400
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1qqaSy-0007fx-PO
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697035540; x=1728571540;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ncsOfXlS1YcOMGyxa6bcH/xX9tyqdTGuA8aC1XK52QY=;
 b=RTEAG8ZhTKJWqo5kyOn5C1TP6Trls4UP/rXQlqeau2KNOeuX07NjmAc0
 lnH4HZqJV85uvYL91G+/DeQO9EKtuIByO4/4Sil97sEnwl1Xfh8i+0ZI5
 l9gO6LtleivzA9uumysvTT5uUAwwuCA6PoUrTSzu8Xs5+ii5MCEXMfMyB
 NFqAm68mBi+RErLJwqQmJPiu6k4BXpLlCPBj3t1EQayZsLd3AOWRNsl2x
 EYFferuIOtM5emNNjOZ/ip59s6jJcSStSmgYGEiZf5w5kEpY7hMy1ik1t
 EU4ddrhff2k1P5f/5Pqlf3CDm+G9qwewgifX5kJG9oy+hLRtJlDDWz9Uh g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="451174014"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; d="scan'208";a="451174014"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2023 07:45:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="747482046"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; d="scan'208";a="747482046"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Oct 2023 07:45:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 07:45:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 07:45:31 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 07:45:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOw8ThBrCulnVt5CDzrqzXIuwCV26SaI/q+Ik3zlux3AX6F86R5NUjc+dQdKLSZcvDoy7MZQot5bgKsBL4Bt5HMbUt1daD7D0D9u46Mzv2oPOk1ptn0Lr9RNbr6phDZFAfQvvD0gSUUe5xsSBqemOEdiiB6ArM3Ymht6iHn6QaITikzVVjveJI0ctnj3IyEl5zIZ1ON0d8tNDV7yylvEu3eKtPfsJP57IcraSuFlit2ScLjI63X0EF6zrX78GKgc7c1CjnLvGq1oS37/3sNCzFOA7Bw1QB2lcynQHw8cxr4DhEUjfM3v0S2rS3RKiH/N/iNkRZgE44yTqS40DfRzQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iD1/FFjdMeGfDyA+8uICt5mXSyZTwjmBBj6gM6u4oSI=;
 b=ney2g3eDN6mSdLwQDSuWo4ofsRGytzOyFLxezBHPAjgZ2qptLdEkUU+5zsDQNbkc+gYht79tGqQJDs9L5gTKvzCaHXAaiMXtojsB+LQzvGUWirBZ34TtuKQu7PtW6vjNGPwhzZpkNLy0b04ARSv9e4HD8gatTiKijitmIPGruzsMHKhGfFhcZOgOnujwW2BtXuH7DMcpuoM7g1qGExFK5she1yAQNs5gw8ly07bVPOBhWVetJURuJnZUV6/1OAFBkbH859QSqrQNvo2hZt1c+jzXSF00BU66Z4fyrsAoLLFwQ7MHvPvifOvPTqUCbmY+vkb3fqYD4WTqN+b91yxhew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 SA2PR11MB4842.namprd11.prod.outlook.com (2603:10b6:806:f8::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Wed, 11 Oct 2023 14:45:28 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::6a55:3e93:ac5f:7b6d]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::6a55:3e93:ac5f:7b6d%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 14:45:28 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: "quintela@redhat.com" <quintela@redhat.com>
CC: "peterx@redhat.com" <peterx@redhat.com>, "isaku.yamahata@gmail.com"
 <isaku.yamahata@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2] migration: refactor migration_completion
Thread-Topic: [PATCH v2] migration: refactor migration_completion
Thread-Index: AQHZxrZrzbuQ2/SdmUaa0xzmirIuk7BE8xyqgAAgJdA=
Date: Wed, 11 Oct 2023 14:45:28 +0000
Message-ID: <DS0PR11MB637312D6D5D3E178D4B034D5DCCCA@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20230804093053.5037-1-wei.w.wang@intel.com>
 <87v8bdbac2.fsf@secure.mitica>
In-Reply-To: <87v8bdbac2.fsf@secure.mitica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|SA2PR11MB4842:EE_
x-ms-office365-filtering-correlation-id: bd083a96-34df-49c3-295c-08dbca68b63c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q/grpxuchVB6XNAYizPBWulI0/c8DUmNKvpe58hGaEN1GmKJN9/mJXgJwrW2HcBd85SeV+gsZv4LafvvJwxyRy2S46BKFNHTjHIyCGZwNMVQPSQ7PfprGIvdWJhijsJ9I+6REBdTu+xT6sStsxqgaVmQE+0VfT/z+qsNYr4mNxQF/hEFdSoi02e/HEc6iRPuapkbNG1a/MYNaVPuUJlHpmID2dNKGeAMPfguPtowdMlujRMBf0L8+H0NnWN9xThxGEoBFLBF7ys84HjKNyKWTxAgFKB9vGQFDCJc2V8znR6HKZ0Wq61Sg1DgtF1kjcUYhN+/e0zih6I01ryTH7lu+jZotLup6agec1rBEVdWPm8oDfQHIj+EsFz9nfgLZcVLTJKh7F7Wvxpe8YNs4W8dU9Z/wP6WErt1Dh7TDfa0eUwYqG8IDLZ1Pbs+QtBRCSU6cfzpY3Q1NOMZo+bH4kuWdr0LWB6AXeBTogHceoBrXjSMYSshC2NzP2JJSkV/MyvqxYzEyml6L0MzLyGwNa5VKASN5iDYzfUaXY9H8IP0Oe2pGZp7tIsauXGiIP+7KdBUf6KfoID91/wMjy4CxG+fflOTrzdfs/SB3na5GS/jTtB43pEGTTKlcgSzowDibD77
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(55016003)(9686003)(66946007)(7696005)(5660300002)(83380400001)(26005)(66446008)(54906003)(64756008)(66556008)(66476007)(316002)(6916009)(76116006)(8676002)(6506007)(8936002)(4326008)(41300700001)(2906002)(478600001)(52536014)(71200400001)(53546011)(38070700005)(38100700002)(33656002)(82960400001)(86362001)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JNH0nGeHdvkTNix9N5YmvegZO2RijQ+V6FSUnFxW8Lsrji+M0p6MioezI+6a?=
 =?us-ascii?Q?xD7vxRO4zuxsCYiMA7ZNC/EJhq9+JXCcMvvgpgIfMKw8Y0WDwELKCOU9yUFv?=
 =?us-ascii?Q?nldmTvcvqCiM2iEVk1+kWvPEN001l8tbq7StvWPpU0eHjP/W9MRCdmX1chnl?=
 =?us-ascii?Q?i+xAu9rFV7yP+gEisqXa5k+qHVSvoctzG2mCR6q6LEInZUFbobvuqG4fidMX?=
 =?us-ascii?Q?T/lwTzSvTrKCAV2TAjWwik7gpavzmUfnyW2abUkJV3Q5XlA0woVkDhWV07S9?=
 =?us-ascii?Q?wC1P4eDCjk+mkukMUVksRjk9aGMFhJ30yKaQl1ZN50Nfau0XbEB+/hpybw2Y?=
 =?us-ascii?Q?cQ9fKANNGat/duOU6seMAYB7fSZ6wAQCDZ2gg+MW51+SNC0gd+rOA8phdhJY?=
 =?us-ascii?Q?ke3Up2VNnLY5ybyL4b+5zcsM7hoAr0F04aFxZe4hl6NcIGb51PHIcxfSfnHd?=
 =?us-ascii?Q?npCkIyMGI18Sg06HiGsxZb5mkvELBZ5GMDJTdNNx/ty5jVoIhdyJU5x5p+qK?=
 =?us-ascii?Q?b5LjObWBwf3rPLxZzYfMW6Sc/TYi5rGM/7GbLdFA5RNJiNyNat0Dzk4LPSMP?=
 =?us-ascii?Q?5ycDFiePBXCTud8mr62YTEJESuLTZP1TWm0H2P2gAfWKbMoJIymQCpCa/c37?=
 =?us-ascii?Q?FPTSrH8cl+S/sotCz72uQTaZTT8L1vLU5v8HGSTGWpZUVoLCPZTM+H2t1w56?=
 =?us-ascii?Q?Q3nm1AqmSC6qBTYF4ASquStInBkRqSuN66YlafFVDnwDBNYBxcU9EWosjcma?=
 =?us-ascii?Q?EaH1Ll6il6tBfde2oaalFsA8awH2PxYGKwHIxWHNgd6Biezl7p3/eV+g9EZ6?=
 =?us-ascii?Q?tFzDtct5hPpx5W+OQp7mdS/XDxXbMSvB6E5YaCCGs4hgnQF0WrYAOaY6vTkz?=
 =?us-ascii?Q?m7qYjvqwSBsYyFWgUMJjYMBr1YTaWNIgYRM/Txo7QuCnvJ+1IjLb3YBuoqHs?=
 =?us-ascii?Q?BoCJLnxGy18NHXkCwBYoZkVT/qkXYWb3GCbNqEXMIoCCA9nzx0NJc1y6i7+C?=
 =?us-ascii?Q?LH/RyDMIU6ScFYoqiEX5q8xp1UQOy1n7jrPEQ5eabOx1l3qQeRJiHbIg+4+C?=
 =?us-ascii?Q?MZao2xfBJ5VAri739GSCTbHeDJS4JoxJIG1bfbmAuf8ErQ+xBlQMpMo37QAd?=
 =?us-ascii?Q?cTq+G0O4qco5mv546ddrVRsHiScqy3KrEdxTyrjvvKdol14x1Pe/MOVoa2I+?=
 =?us-ascii?Q?jBzviQ/oKSJpMJiTXseqJxc9ZI5okPENa/1Ms/jqFzS5STa4I4sBIxnwFdn/?=
 =?us-ascii?Q?cVl0NIxbkW7fhlx/2xEaFMiI47ijlLx2qYgczK0uZeS+w+8itibaHFCA6AP7?=
 =?us-ascii?Q?C4O4LIXy2+7lD2KYquUY11CHc5oOwq6GFkRu1yevz84IPdQB0VBIQiw7fcNe?=
 =?us-ascii?Q?mMmfM/EUnGiVtbr59K69Laz7eG8tP//IctaEgESHpLQGvCIJETOSeiAqkiXU?=
 =?us-ascii?Q?vgyCnWkTxbTYVFLt5hJY1Z97+iRrq++Dah7aONvcWNvmD8E3s5TKA5wuBPXQ?=
 =?us-ascii?Q?AYKu5J95r4DTB2EN6NX+2JNjrcjgE/W9zru3xOQh+Pbn0tr3IKFjUJsRiBnw?=
 =?us-ascii?Q?9dMBCT2MfUjtqTfGgM9WnG9ZI6nzF6tXpwTPtzyd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd083a96-34df-49c3-295c-08dbca68b63c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 14:45:28.5514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pTYQGz8Q7FLeKEJ6F1TiUMoEtlsTwUK6RJ3Xm+piK4hXEB34KpWwN0dVYxscKTU3SNrbWHgtwG8dbiuJaFEe6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4842
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

On Wednesday, October 11, 2023 8:41 PM, Juan Quintela wrote:
> Wei Wang <wei.w.wang@intel.com> wrote:
> > Current migration_completion function is a bit long. Refactor the long
> > implementation into different subfunctions:
> > - migration_completion_precopy: completion code related to precopy
> > - migration_completion_postcopy: completion code related to postcopy
> > - close_return_path_on_source: rp thread related cleanup on migration
> > completion. It is named to match with open_return_path_on_source.
> >
> > This improves readability and is easier for future updates (e.g. add
> > new subfunctions when completion code related to new features are
> > needed). No functional changes intended.
> >
> > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>=20
> There was some conflict with:
>=20
> commit d50f5dc075cbb891bfe4a9378600a4871264468a
> Author: Fabiano Rosas <farosas@suse.de>
> Date:   Mon Sep 18 14:28:20 2023 -0300
>=20
>     migration: Consolidate return path closing code
>=20
> (basically the traces and the rp_thread_created check were already on the
> tree).
>=20
> BTW, the diff is uglier than it needs to be.
>=20
> You can add to your global .gitconfig:
>=20
> [diff]
>         algorithm =3D patience
>         renames =3D true

Yeah, this generates a nicer diff, thanks.
I'll rebase and resend it.

