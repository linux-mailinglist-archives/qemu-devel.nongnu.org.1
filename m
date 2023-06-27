Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF92D73F978
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 12:00:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE5UQ-0006bs-WA; Tue, 27 Jun 2023 06:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1qE5UN-0006bP-Rp
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:59:59 -0400
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1qE5UL-0004qQ-Gr
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687859997; x=1719395997;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sIP/sZ53iGRUze1hKYbncWiCEUtmXWpDEXuKqn2MDWg=;
 b=PGEqPLK18VqThuE1lc+sulXtfdcBsdV92/0AWFbqkFl6fM7fbRo8fqG5
 YGGQJrafy/UyRAPFg//QqNCK4ihQB5kNbDKbAIYKam6fmxXpHCP8aN3if
 v9xo71K8JGHqvza1wnHP4uwTANZe9EvU6RhCPf79hKb82G9CVy5sfFMKV
 +C8n0y5H8BrqVi0v3uw5KDpdwTl9D45CmKurcn5eye3wVDrMhdjV4u7Yy
 mmfqjU8FLkrEDyhBEVTPODC9avvrPHdPFjXX9UMpw76dUMXCMn6Qtg/DA
 karsjhBKAbt8LeoXrf2PFn1nWGV63ETWpne9SreNwDLflojPeGW4TiooP g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="425198713"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; d="scan'208";a="425198713"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2023 02:59:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="806404865"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; d="scan'208";a="806404865"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by FMSMGA003.fm.intel.com with ESMTP; 27 Jun 2023 02:59:37 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 02:59:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 02:59:36 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 27 Jun 2023 02:59:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLJxyJHTBLsZGQRx33zIy8tTZlusXZm9bM4n5zuGoIO7SiSdhanORVD1VbkARGu9KqzrjKpxetNgMZOEXWttim6yDCAPiIM1FJsRnaioZqHXrZ2rNljCds/mHluA46x7lXKlCsmvbXJtt25Hif+WjNwHG/agl7jb28oi62Qb5DT0Wn4hD6RSwJjeJHGsHz2q4fA9LJFdE5wdn2O4gWlwkbyclW7eT6gPw30Bu47m8GeysgDA555plHLLajVc3K7kWUMobgFehVD3KTiaEKxgDKZN0Z4QUUN8Y21NdixQPNzuTajpQGEiHGcU6VJUPoS/FSotknxUNowG1EZQMvF3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrURVSOa3tlmc2b16wwSVNnnInhYCZyJYcoKZwn2Sqo=;
 b=ZySMR0jy2I7SKTlpQKXwniB8gf0sWZMQOJdjfw1Vq8VxKhaGJAOn8814Sw24SFtxWax0D894prNOYHjD1rii0AcIKfZzt+WThZ/k61ASmhG18LaAQHwSUztlXm8A0rniuWQn+57oGMrrNM4jtOdsRGWTU3Lo9mpA7ZSpz3JMuqxstafHrUJL/JH1/Vc+HpLSfCQATLCtmg21r+LKydbVm5Vd+ROnB4EaaT0wlpsYL8epbN6rulKPetiswCSTb4K2/YMpQn2rAZzrBPOcJGJMn4S1fLsL8pA4YmLfaS7A2UeZBgNcov6KvD77H3ZnebTVwcCnSXzS7SwQ4PjFYQv7TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0031.namprd11.prod.outlook.com (2603:10b6:301:69::37)
 by SJ0PR11MB4879.namprd11.prod.outlook.com (2603:10b6:a03:2da::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 09:59:34 +0000
Received: from MWHPR11MB0031.namprd11.prod.outlook.com
 ([fe80::3c25:c17a:81f3:460a]) by MWHPR11MB0031.namprd11.prod.outlook.com
 ([fe80::3c25:c17a:81f3:460a%6]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 09:59:34 +0000
From: "Zhang, Chen" <chen.zhang@intel.com>
To: "Dong, Eddie" <eddie.dong@intel.com>, Lukas Straub <lukasstraub2@web.de>, 
 qemu-devel <qemu-devel@nongnu.org>
CC: "Zhang, Hailiang" <zhanghailiang@xfusion.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: RE: [PATCH 1/8] colo: Only support the same qemu version on source
 and destination
Thread-Topic: [PATCH 1/8] colo: Only support the same qemu version on source
 and destination
Thread-Index: AQHZpQNAMGFImxmxIEOhh9/+Q/HLYq+XELMAgAWFyoA=
Date: Tue, 27 Jun 2023 09:59:34 +0000
Message-ID: <MWHPR11MB0031EC3A2EC720FFE61B24709B27A@MWHPR11MB0031.namprd11.prod.outlook.com>
References: <cover.1687429356.git.lukasstraub2@web.de>
 <9acf84c3a558357d1c834923b832ddc1d2aa7548.1687429356.git.lukasstraub2@web.de>
 <BL0PR11MB30423A1ABF3C53240E3ABD878A22A@BL0PR11MB3042.namprd11.prod.outlook.com>
In-Reply-To: <BL0PR11MB30423A1ABF3C53240E3ABD878A22A@BL0PR11MB3042.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0031:EE_|SJ0PR11MB4879:EE_
x-ms-office365-filtering-correlation-id: 1ff582e7-e180-4466-0ae5-08db76f535bd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZSKSfMFqUPuhG3ltKmdUYnPK0nuqoJSduTptEmh38gW79Ddx7oxVwcMfuxXpOfA/T2GRjdMlCQBjcTNopeHkRap2uIvKTg2RMnJCnpaNXRCl3/FYh8QGf5UzupI+xsJ048IxroIfQTKk/V9zfKRB/dMj1TzyUbg1gB6MXs6qD7X715rkPvWsDPmBt5qwPy3fmhrU0nPPJaTK2UVNRaTttuB9+on39cZetWDOwUuEWFmW1hcpEWs0xMFC8zNzvd6p1iQ4tSMuWyNcDMDJoo7Dp7QKckD5EZiAea2cmAx8e4oV6Bza+seQEwKJt3P2V2P7dV/flgE5wktwWtw2oVve3KaHBAUqLphUaDOrIYOVL5UeL72m1fAukV5dzNtaioX519e9DBB/2dl6tLj5MDpGBIpgYW0suh9L0hbTozOfNEtsCnlEYtAFNeh7lZf8y38suFX4V8PAtVg8FD+4sRSbH/GlzraVqraujrEf3XCIM8g8Vi9mOMG1k8ky4y0oJFsCFHtlVSZps7oswD4u8utFS+pHtghv1AvjP4A23ExNYjFM7eYAHllaon6l7XXJfBMcshvOf8Jw4wlUFV2zLc80bHjkAVzl8zS5Owi41rbGMnDkDyVorwnDLfOYNzdNoqB0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB0031.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199021)(2906002)(186003)(26005)(55016003)(38070700005)(82960400001)(8676002)(33656002)(54906003)(7696005)(478600001)(110136005)(316002)(86362001)(4326008)(122000001)(38100700002)(71200400001)(52536014)(9686003)(5660300002)(8936002)(66556008)(83380400001)(64756008)(66476007)(66946007)(66446008)(76116006)(41300700001)(53546011)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wptkvRr/MGjFLyRND9Oznlmd6uCnfwZRdaVfYzuUV6Ax2+aYiDwrJJZJupwg?=
 =?us-ascii?Q?yz9iqpdkL6Io6UwgoL+f3NrNCAG8zFuupR9JvGBEpXlY6LwMJ5utLI/l8fYv?=
 =?us-ascii?Q?UaRUwY2M9WQ4mQLu4/Tu0gJfgxf7ua30N/yc9WU1yfk/2lsO+Cp1swiVs4uA?=
 =?us-ascii?Q?H9TNkKwe1UGM5AQxT6DOQ77E4kDOruqqCgIS4foJMx2OL6PhQqKNeTml7hUk?=
 =?us-ascii?Q?wOnhH6n/p49yKAppWk6sCXGMFlAh79SPSNfPtPKTK5P4u8lZHjYjS/E3Kry6?=
 =?us-ascii?Q?m+DTRSb0mZKebLoN2zwLun7pnaCeQ4JMU+39uBaVL7mZtqvipcuofYt5gcEi?=
 =?us-ascii?Q?Wa8OCYCMZcjZpBTukHcQilBEx4taUdmh1c433YfnnEyAdXUGXoAGXFzSWGp4?=
 =?us-ascii?Q?UwnUJ7KHi4Uxs16VTdzleexzf9UFXefZa192WBRS4V0EKQLU3pyNoy0xmEb8?=
 =?us-ascii?Q?0YDdSUKPUCkhb2j58LE16pzKeYhQ0WDWovbhz4uRzn7+dVFIw1vGeRnxE1s2?=
 =?us-ascii?Q?bA+ZaArXGnNiWEF+gqvrTTdGFph/bcHZpidRpBBvE4nDoa6hyUDlcyUS6OSl?=
 =?us-ascii?Q?soC5LFqhwpNaoudf2s7NkGxdEOJ6SbTcGnSpV01snwo9gSQywoe2dxnAz2FT?=
 =?us-ascii?Q?CxOzYv7BPQefoFmHhOoOQtMWhZxM7MqamcGJvWpSw2YJ0DZp7qcYJ9i+gNBE?=
 =?us-ascii?Q?Efic/lwDgAixA163o7D1wnGz/4v8UxuFXwVJtRkt+gobQuPFakh+tvlDpbQb?=
 =?us-ascii?Q?m/IFlfwzUcYG+GHyFAsG+/BPSqRDxVq9xEkJK8Kxf/kZU0edoQIXE412Csrn?=
 =?us-ascii?Q?mp8TPMaNYWfiFChtNZmtEMtjU+VGGj3mCSAeuL9bPNsz32NKQf6vkvJJerAl?=
 =?us-ascii?Q?yucPvNtXR22VvujODtRsT3SNTa5RqiY2MWt7r6x6j2I9QjxfqaNXk6lYu+ix?=
 =?us-ascii?Q?tTK0/TMwPJGIx8feCPX5kT3JhFeLFk9jnyztx/b1aspy+h8tSceLTM+MZf3p?=
 =?us-ascii?Q?9vUfQUYXM8wLi2QgSdXMi+HURS3PJ09ZKDfe89s7ADFhw18X567Im4x5Vcl2?=
 =?us-ascii?Q?HijGdJdmiSRqSGIEYzxyLDvdFyPd5fm04Gu/3DcZhyogUy69ofd5NJaJoZMI?=
 =?us-ascii?Q?k/WrA/TGVvhHV/rvFref0YnEKXuwUFD22KI7FTAg3FRuwLqHyXe6LJTFE3rW?=
 =?us-ascii?Q?ILA8XTG69tN9NdNMEajfTeGifc9FuyFY9WwiHA4cdWiWafXXkSuH1o7YQk3h?=
 =?us-ascii?Q?SfbB6lZkS2N9N7BCNd0GdXNmA81Wx9wv7o55eMtX/9+6caDXxvX5oDPTZMRN?=
 =?us-ascii?Q?rC8tOGlrQv6B+xcwyr73LcyXsuv78q9vjY0P5ce5u1wL2hzBDdn9iijoML/r?=
 =?us-ascii?Q?t/WlVUVln5d7osYhQwGoDFcxbWbtbu6oVvQ/vaum8ZSPdWPTX0CIYZHLXTrM?=
 =?us-ascii?Q?4O++O11yF6xxBB07Rl14f9hQr2qkM4jwBcswszSsQM3HwzKKTzCCxytNSBRQ?=
 =?us-ascii?Q?GyKzt2hnEV4ErqLgdqXQNXI3VwSlG3OltVWjtkgwV7KOmWGLufOzmUQWatP1?=
 =?us-ascii?Q?fAlqpb8L7uCfwyNohgWMTw7ZR9xMCtKFt/MR8KEl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0031.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff582e7-e180-4466-0ae5-08db76f535bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 09:59:34.3626 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UmEMRQUBA10u3vl3OugiBopxTrtIFT1ugBlVC7EpXRX6Tr4ezrGpHMEpbZCwbUiqoc+e1zol29P/+k9SnN7XjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4879
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.31; envelope-from=chen.zhang@intel.com;
 helo=mga06.intel.com
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



> -----Original Message-----
> From: Dong, Eddie <eddie.dong@intel.com>
> Sent: Friday, June 23, 2023 1:17 AM
> To: Lukas Straub <lukasstraub2@web.de>; qemu-devel <qemu-
> devel@nongnu.org>
> Cc: Zhang, Hailiang <zhanghailiang@xfusion.com>; Juan Quintela
> <quintela@redhat.com>; Peter Xu <peterx@redhat.com>; Leonardo Bras
> <leobras@redhat.com>; Zhang, Chen <chen.zhang@intel.com>
> Subject: RE: [PATCH 1/8] colo: Only support the same qemu version on
> source and destination
>=20
>=20
>=20
> > -----Original Message-----
> > From: qemu-devel-bounces+eddie.dong=3Dintel.com@nongnu.org <qemu-
> > devel-bounces+eddie.dong=3Dintel.com@nongnu.org> On Behalf Of Lukas
> > Straub
> > Sent: Thursday, June 22, 2023 5:15 AM
> > To: qemu-devel <qemu-devel@nongnu.org>
> > Cc: Zhang, Hailiang <zhanghailiang@xfusion.com>; Juan Quintela
> > <quintela@redhat.com>; Peter Xu <peterx@redhat.com>; Leonardo Bras
> > <leobras@redhat.com>; Zhang, Chen <chen.zhang@intel.com>
> > Subject: [PATCH 1/8] colo: Only support the same qemu version on
> > source and destination
> >
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  docs/COLO-FT.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt index
> > 2e760a4aee..8e64480dbd 100644
> > --- a/docs/COLO-FT.txt
> > +++ b/docs/COLO-FT.txt
> > @@ -148,6 +148,8 @@ in test procedure.
> >  Note: Here we are running both instances on the same host for
> > testing, change the IP Addresses if you want to run it on two hosts.
> > Initially
> >  127.0.0.1 is the Primary Host and 127.0.0.2 is the Secondary Host.
> > +Note: COLO is a experimental feature,
> an experimental feature
>=20
> >so currently is should only be
> it should ...
>=20
> > +used with the same qemu version on sourcee and target.

S/sourcee/source

Thanks
Chen

> >
> >  =3D=3D Startup qemu =3D=3D
> >  1. Primary:
> > --
> > 2.39.2


