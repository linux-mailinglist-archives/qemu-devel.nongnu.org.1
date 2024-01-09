Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABACC827CB8
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 03:10:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN1Ya-00034x-Df; Mon, 08 Jan 2024 21:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1rN1YY-00034c-8c; Mon, 08 Jan 2024 21:09:30 -0500
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1rN1YV-0004IK-EJ; Mon, 08 Jan 2024 21:09:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704766167; x=1736302167;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KOzbGtrZGRtgBQ6+aw8ags0NCn65wTXkqSDpHflBN+k=;
 b=Yu2XqdihjHFcgzCKTqKjlxxvHRenxr8s2yOD4RzabYgpe2k1/I4Dd5qz
 jeNnkzqiGblcvdIUPkybXxoB5/mvOYxurH5cOU0XI0SYyBjau4HQq1sgU
 19BDYooz2uMHj9PhBckZLt7CGA/fiQ31vKb7SVzwAR7W8kZW9HT884N3Y
 q148ojouymWFAD5g/tKojTg8CLHBEBCc1nJjFNJqZFa7LNWs8evzmGeFj
 2I4leg+9J9AUUrOqQK3GZB5ziZSuBL4PPKUHnFEON/tOURKp+r49whYtW
 eZtKoxCJJHI5O08smW7hec+ftRbmi9D9sGcVkcuVoxgx3R6wlOJhZvq9p w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="429246867"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; d="scan'208";a="429246867"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2024 18:09:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; d="scan'208";a="23383313"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Jan 2024 18:09:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 18:09:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 18:09:21 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 18:09:21 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 18:09:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiGQdQaR6+TxwWNRt22I3CHfbCwRNpHDrZTyoqnPWQbi6ZuYLdKdmM/BCwH4FNi63cdA6dmrfM0thN2teot+FEaEZ5HRXtK8r7eL6G2zgRpoNIB4fWBTG/CTiQZc+TfPgLhW5BMSzXqO1GhZkqeyHWfhdFqsqJKg+RthLTf5ZOXacHFu5bjVo1xJy7CswmAxN4ekD+UHKjZx5dGS3LlOxr3lGHsH9rL4p5i4GR7YD7FojpVsgiV3xQ12ZBDu+44roqvqlN3HHGIDao3gus5Sn4H4E99aexOIWEZnFOjOvrVpAmM3zZ+uSPeMSPu9lMuBBrVgvMZTpObH5HvG9gymRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZTvX7rRH8ooeyP6mun0qcmqP5mUtpThyS24k7BnKzw=;
 b=UE7q6r8aPLc4bTCQSomSCk/dEbbpiFlN4mxCLH6vM0aTb+VFIk+cZVFjJvep6K7Xj8eiTVlY6wjuiRG1ngzq6VXlyf5qIabgDCh3OyedbaMtnRthH+Ab4NhvFtOn1/emC5IiFqSVcwDPt0DKFK8cJc3IspjGnd+FzcRkyFWoMlJNFMBm7MKQU3GCuRFeGO5bnsteSgy/sp1l0rNLXOvgZ4HQFCg6hDlfEv1O1OpNKb/b3SFoveOUZGrvHI1AukUIS1eCPc/kZjxmdkX5LAa9PswNDthQxVSTH8fJ5S5KLeq8nfni/m58sXRi28hi2ydQWC+Jf6AGAUAn4dxBN9Iz5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8432.namprd11.prod.outlook.com (2603:10b6:930:be::8)
 by CH0PR11MB5473.namprd11.prod.outlook.com (2603:10b6:610:d4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 02:08:58 +0000
Received: from CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::3a72:6cef:3265:65ca]) by CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::3a72:6cef:3265:65ca%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 02:08:58 +0000
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, Li Zhijian
 <lizhijian@fujitsu.com>
Subject: RE: [PATCH trivial] colo: examples: remove mentions of script= and
 (wrong) downscript=
Thread-Topic: [PATCH trivial] colo: examples: remove mentions of script= and
 (wrong) downscript=
Thread-Index: AQHaQVxb77ChPaUaZUGuO+6+/tz/B7DQuvNg
Date: Tue, 9 Jan 2024 02:08:58 +0000
Message-ID: <CYYPR11MB843238AD2090FC1B9B309DBA9B6A2@CYYPR11MB8432.namprd11.prod.outlook.com>
References: <20240107112459.335594-1-mjt@tls.msk.ru>
In-Reply-To: <20240107112459.335594-1-mjt@tls.msk.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8432:EE_|CH0PR11MB5473:EE_
x-ms-office365-filtering-correlation-id: 54e8a799-f738-42f8-984b-08dc10b7f0e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DF5b3p7drv1a0+bVa4qs5bP9ciTWi38uLxwVxOlfcmG1sz4hpIOlAw6B3wmthsBkTrEWtBTazEF6SbbqTugeb457OJ/y4aHlmrvCs5+ruXeV2md84caICfRNql5GSwkRVSfgUjun2pBg7Y7c1PeOCb02Lsy/vDMaPtXA9QBUv1DQQ8FiRP0eZcc6x0chdO4MS16KLHArrr9R9TXvXIPtueB53s/3s8pfUqU5BkXBsfNoOJSkM/KtJsL1a/TqUrFV44irkONULqew4QUampqNrEtJjiCvOAERD7W7C41p0/npFS5E2t2eUtY1kFnc6Y7wvZaRGBFdvPRwEbJoX1IXWJnMkWuK9GGydXOENGZ7sbP2J/htWdWaGzYeirBcnxN4E3t5XnS9CWHLTYrRubiSM21KeoqqJ/KuzKGF1r0fRcPlNzXVvskDl/fqqATV26Gs8GT5mDKg3ib5jL6B+7+8E4BYQmV3lCWI/mNFh0m8AtPig5K+g9vPUBS5qcrsp4mcMLOcGY/1yYULocVvctFDLaY/c8U7z/5MrKlDtkZ3m4Pi78XkqqnmquGrg+l3IcZewF1Oab1DdxUMwpiYQn3FLFZW8CfZ2B52Tv5V4SbjqUm5xlwzLsN5eYJgE1e5yXmM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR11MB8432.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2906002)(38100700002)(5660300002)(38070700009)(82960400001)(86362001)(122000001)(41300700001)(316002)(110136005)(54906003)(8676002)(8936002)(55236004)(9686003)(55016003)(66946007)(76116006)(66556008)(26005)(66476007)(64756008)(66446008)(478600001)(83380400001)(7696005)(6506007)(71200400001)(53546011)(33656002)(52536014)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4LP4uQ9T4Cby38NeEvLFvn7Pjj7JBxcBHYEaToyg4+xAay204ynbZ14wvYZR?=
 =?us-ascii?Q?lSS/0Zf9DKoMx+kfAUIOZE075qLnNSdnTB+6LZH6bzuIVDrMoMSPazNFrQsm?=
 =?us-ascii?Q?speiCVZxa6cSuRa1/8hW5WRCMzFyrXktvR2lsomy11jV685mdtPq0zdbptvB?=
 =?us-ascii?Q?12migKW+clhJEJO16n+1IJeCEN7PCZthPktoAOoMfVSCn2+RMH/weJjgQuq7?=
 =?us-ascii?Q?/M2T67+eAysxChCzknvUWF/YyPjvdYL3dbDCWRKmKASylAuZEkwJd4Ds4AuS?=
 =?us-ascii?Q?4Abh0c2AvFXhSd29ZcDs81U3QEjygKhN5VgJG1xSYCNwWWLKk3+ZMdCrFibU?=
 =?us-ascii?Q?eGdPIjcghMDfwcbX8mdFkmM/s9qESUYFgINozFCy0uiXB0VltImvdT4jPk0u?=
 =?us-ascii?Q?r0ZLaVhGGcj6F4Gi6tad5sIWv7iyc18+NO/29l/AzD9rGLJCboZtc+FwOv8o?=
 =?us-ascii?Q?MgU5rtwJ6zNCvdbQKZjhr0GHsJ0wj2jFx6tqpz19tRqONJecg/XVbyAIYlBk?=
 =?us-ascii?Q?hzttYu2EQ5wbyHQxBXAuQSUI1CHrdfZwYG8up1cH3NGpP74EN/O2zLKQEU30?=
 =?us-ascii?Q?5Vx75Jh47VNYkNRNsBvg4b01gGlY5fzgKXLmNIj2ZHa4jvAzqjR+GpT4Ld4W?=
 =?us-ascii?Q?osBmLX2Clpif74qtaLTEU+otupst8OwI9oYJdNZyMB4YUQZOmPxIsozYpmBH?=
 =?us-ascii?Q?Wfi59zg0qlMC+mzc8Xf027FdOpzWljIugmd33Q7hoP/1Hz5vxohk8J5kJQjO?=
 =?us-ascii?Q?lVU4cYt6q4jP3aKbLXw3Fs1sqAcQCHuzDrLejdpc+GOfdzcvflOdVpIQIkrX?=
 =?us-ascii?Q?kLC6/kLs4DeWSEYTv4Bsy7aW0SwczyIYJIKcmwtqY+l9yU1xcnWfOQILELg4?=
 =?us-ascii?Q?R93xspQtT6VBVKrve89Kq5dc7uxWwhLuNb/M2n2wXmdLpLXOTzF4NzSGpk2K?=
 =?us-ascii?Q?vxMrADmziZEEnAPiB6BSsNPtHIzrGotvqVpw+WJsVEmuvUWv0HE6OLeHPceZ?=
 =?us-ascii?Q?hIJvc1nuiDDf7TOXk7LM47aVlxCF4pyCVWZI+6MwaD0QxqQMtcCo6T+ZFLAI?=
 =?us-ascii?Q?a1w+dZew+JdDPgBhXwlbN9dKsCB0UvRVc6wZobUuNPLa+WbUhvT9bry07XjY?=
 =?us-ascii?Q?j8eAcK+8djTQ2eYgTlnimPD7GmjIPkD0ilXSJoHwU9zpLf4Nba7Vn/S4ROkx?=
 =?us-ascii?Q?G1NSuIEgjnlW1Y6RGm55cg4RNy0CJvvUbclh01/NQJiltp3t6ch8fb/e8GZY?=
 =?us-ascii?Q?kihisvh7B6XMZmq+uCrGX3U/wFVM0OgWMCDgmnsJ5I50AxF6C03jVKy1EQ1m?=
 =?us-ascii?Q?9kliCM2XoOVPPrpdfe/oXaDP8ACZh18tWp/mONfhq5lYDX0ld003+ApDiZHN?=
 =?us-ascii?Q?Xiv8YBtc0A12Pu+JFs24OG7aHPl0tkAkmUqf4Un6NeGRPP+GXo4QzxLquXgZ?=
 =?us-ascii?Q?tk6yfH4s8VpsXSoByE1YpyfhFu2dRvVFj3HVzaa4SCOE0bechWUf9dOp6SHj?=
 =?us-ascii?Q?R48lzHn34HDdxNJIIVH1t8fsiwmJt/PezzyStJlZKSXkDwx8H2U2m4d8qGPa?=
 =?us-ascii?Q?WxGpmQjNQCdGd+WorJ5Y5bYBU3tXuMwwZexQOR3I?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8432.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e8a799-f738-42f8-984b-08dc10b7f0e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 02:08:58.5705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XVTP/IvmgqIymb89jhgIxBfXqJWJRc1C29ghv0kTOco1FzvbGEU/QJe5P9iX+v0B50UQkMK0BlTi8U3zwT2iJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5473
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.88; envelope-from=chen.zhang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



> -----Original Message-----
> From: Michael Tokarev <mjt@tls.msk.ru>
> Sent: Sunday, January 7, 2024 7:25 PM
> To: qemu-devel@nongnu.org
> Cc: Michael Tokarev <mjt@tls.msk.ru>; qemu-trivial@nongnu.org; Zhang,
> Chen <chen.zhang@intel.com>; Li Zhijian <lizhijian@fujitsu.com>
> Subject: [PATCH trivial] colo: examples: remove mentions of script=3D and
> (wrong) downscript=3D
>=20
> There's no need to repeat script=3D/etc/qemu-ifup in examples, as it is a=
lready
> in there.  More, all examples uses incorrect "down script=3D" (which shou=
ld be
> "downscript=3D").

Yes, good catch.
Reviewed-by: Zhang Chen <chen.zhang@intel.com>

> ---
> I'm not sure we need so many identical examples, and why it uses vnet=3Do=
ff, -
> it looks like vnet=3D should also be dropped.

Do you means the "vnet_hdr_support" in docs?
If yes, we can't drop it. Because the filters use this tag to communicate w=
ith an independent vnet_header.
And when a filter with vnet_hdr_support tag(like filter-mirror) connect to =
another filter without tag(like filter-redirector),
They cannot correctly parse the data sent to each other.

Thanks
Chen

>=20
>  docs/colo-proxy.txt | 6 +++---
>  qemu-options.hx     | 8 ++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/docs/colo-proxy.txt b/docs/colo-proxy.txt index
> 1fc38aed1b..e712c883db 100644
> --- a/docs/colo-proxy.txt
> +++ b/docs/colo-proxy.txt
> @@ -162,7 +162,7 @@ Here is an example using demonstration IP and port
> addresses to more  clearly describe the usage.
>=20
>  Primary(ip:3.3.3.3):
> --netdev tap,id=3Dhn0,vhost=3Doff,script=3D/etc/qemu-ifup,downscript=3D/e=
tc/qemu-
> ifdown
> +-netdev tap,id=3Dhn0,vhost=3Doff
>  -device e1000,id=3De0,netdev=3Dhn0,mac=3D52:a4:00:12:78:66
>  -chardev socket,id=3Dmirror0,host=3D3.3.3.3,port=3D9003,server=3Don,wait=
=3Doff
>  -chardev socket,id=3Dcompare1,host=3D3.3.3.3,port=3D9004,server=3Don,wai=
t=3Doff
> @@ -177,7 +177,7 @@ Primary(ip:3.3.3.3):
>  -object colo-compare,id=3Dcomp0,primary_in=3Dcompare0-
> 0,secondary_in=3Dcompare1,outdev=3Dcompare_out0,iothread=3Diothread1
>=20
>  Secondary(ip:3.3.3.8):
> --netdev tap,id=3Dhn0,vhost=3Doff,script=3D/etc/qemu-ifup,down script=3D/=
etc/qemu-
> ifdown
> +-netdev tap,id=3Dhn0,vhost=3Doff
>  -device e1000,netdev=3Dhn0,mac=3D52:a4:00:12:78:66
>  -chardev socket,id=3Dred0,host=3D3.3.3.3,port=3D9003
>  -chardev socket,id=3Dred1,host=3D3.3.3.3,port=3D9004
> @@ -202,7 +202,7 @@ Primary(ip:3.3.3.3):
>  -object colo-compare,id=3Dcomp0,primary_in=3Dcompare0-
> 0,secondary_in=3Dcompare1,outdev=3Dcompare_out0,vnet_hdr_support
>=20
>  Secondary(ip:3.3.3.8):
> --netdev tap,id=3Dhn0,vhost=3Doff,script=3D/etc/qemu-ifup,down script=3D/=
etc/qemu-
> ifdown
> +-netdev tap,id=3Dhn0,vhost=3Doff
>  -device e1000,netdev=3Dhn0,mac=3D52:a4:00:12:78:66
>  -chardev socket,id=3Dred0,host=3D3.3.3.3,port=3D9003
>  -chardev socket,id=3Dred1,host=3D3.3.3.3,port=3D9004
> diff --git a/qemu-options.hx b/qemu-options.hx index
> b66570ae00..d667bfa0c2 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -5500,7 +5500,7 @@ SRST
>              KVM COLO
>=20
>              primary:
> -            -netdev tap,id=3Dhn0,vhost=3Doff,script=3D/etc/qemu-
> ifup,downscript=3D/etc/qemu-ifdown
> +            -netdev tap,id=3Dhn0,vhost=3Doff
>              -device e1000,id=3De0,netdev=3Dhn0,mac=3D52:a4:00:12:78:66
>              -chardev socket,id=3Dmirror0,host=3D3.3.3.3,port=3D9003,serv=
er=3Don,wait=3Doff
>              -chardev
> socket,id=3Dcompare1,host=3D3.3.3.3,port=3D9004,server=3Don,wait=3Doff
> @@ -5515,7 +5515,7 @@ SRST
>              -object colo-compare,id=3Dcomp0,primary_in=3Dcompare0-
> 0,secondary_in=3Dcompare1,outdev=3Dcompare_out0,iothread=3Diothread1
>=20
>              secondary:
> -            -netdev tap,id=3Dhn0,vhost=3Doff,script=3D/etc/qemu-ifup,dow=
n
> script=3D/etc/qemu-ifdown
> +            -netdev tap,id=3Dhn0,vhost=3Doff
>              -device e1000,netdev=3Dhn0,mac=3D52:a4:00:12:78:66
>              -chardev socket,id=3Dred0,host=3D3.3.3.3,port=3D9003
>              -chardev socket,id=3Dred1,host=3D3.3.3.3,port=3D9004
> @@ -5526,7 +5526,7 @@ SRST
>              Xen COLO
>=20
>              primary:
> -            -netdev tap,id=3Dhn0,vhost=3Doff,script=3D/etc/qemu-
> ifup,downscript=3D/etc/qemu-ifdown
> +            -netdev tap,id=3Dhn0,vhost=3Doff
>              -device e1000,id=3De0,netdev=3Dhn0,mac=3D52:a4:00:12:78:66
>              -chardev socket,id=3Dmirror0,host=3D3.3.3.3,port=3D9003,serv=
er=3Don,wait=3Doff
>              -chardev
> socket,id=3Dcompare1,host=3D3.3.3.3,port=3D9004,server=3Don,wait=3Doff
> @@ -5542,7 +5542,7 @@ SRST
>              -object colo-compare,id=3Dcomp0,primary_in=3Dcompare0-
> 0,secondary_in=3Dcompare1,outdev=3Dcompare_out0,notify_dev=3Dnofity_way,i=
oth
> read=3Diothread1
>=20
>              secondary:
> -            -netdev tap,id=3Dhn0,vhost=3Doff,script=3D/etc/qemu-ifup,dow=
n
> script=3D/etc/qemu-ifdown
> +            -netdev tap,id=3Dhn0,vhost=3Doff
>              -device e1000,netdev=3Dhn0,mac=3D52:a4:00:12:78:66
>              -chardev socket,id=3Dred0,host=3D3.3.3.3,port=3D9003
>              -chardev socket,id=3Dred1,host=3D3.3.3.3,port=3D9004
> --
> 2.39.2


