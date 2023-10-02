Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C01D7B5183
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 13:37:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnHEG-0006OI-6L; Mon, 02 Oct 2023 07:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiewen.yao@intel.com>)
 id 1qnHEB-0006Ns-II; Mon, 02 Oct 2023 07:36:43 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiewen.yao@intel.com>)
 id 1qnHE8-0007By-SS; Mon, 02 Oct 2023 07:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696246600; x=1727782600;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=x09ANSEyFo06nI/UkJW8BRpS39bkGnnk2QqyDh9xaXs=;
 b=NL1CwGQ4kyrF0EpSzySJcAYi2wNZRnucw3axhnAMj4pTIvcaEdBJdeUi
 jsvbt8ERbSDzcRnJUULEoHP08Z47fDx9aDbnysIYR4o5nDjRpurPkTfFd
 oNQcJ0q2vI56WyDFa3PwvbelvXC8G7CMZTyjfJ8REoESQALyUj0npTDUn
 b8yCmatEUdmgcDz0yihuRIvvRBmDHUyNyLuloosDRXzRQys2/aMBlYPt9
 c7wAFl3F5/VlOwFS2q4rGpfyG4ebm2Ma/eSIsawE52GzQQpxGR21YoUi5
 R+guStskDIrffn+ta61I4NZs7dHFwd8uu5tXFoB4sTf5NvnWp5i13Q/JW w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="362002091"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; d="scan'208";a="362002091"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2023 04:36:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="750555782"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; d="scan'208";a="750555782"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 02 Oct 2023 04:36:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 04:36:35 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 04:36:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 04:36:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 04:36:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SszclQF082YCoxs6ETteBwI76+vOyti8P5Vqjh9d4NSCCiX2ep+uEUmfCUMqOIdcwGFvTGcYLTad1Y3z00X75nmREYSqkPB73K1HhxszmIQ5PAsUhIrnFX9fVfTuOGHONuGS3uj32VfP8EGWNngrbldRODtTewGemX9apKJCXiyV1ZisEY5D5o/YNyG/hoF3iEAYn8/qUjQlNTa2osovzd4S2uNF9rU3yxr4IVlnO2BWrbR8IjC4GOQ3Ywg7WGpgGF0yKIfjFrmvapGf44roltNmENugLm4Ijvz/on6HUNfR+aUVidZ4W63Ch8y56GeJNjMFzr6+A5I4+pUaOZkU/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6a2Fsx6aKEoV9iRSbEz4qpYpDFmJ9BRJYlLjknLz9A=;
 b=elcObvN6hL2rWrLp5UW2jTVThsLQDTumIbmu529tYi78BZ/pZv+vct3vHHAGlNsZXng8rN6feRIw55oE1j3CGMCnBGTG25G876wHMlWIkokIah7tDh3zuwOvUMniqLgv0b6PfbSxkGAd22mJYjn9GxS6ujNYqrP4Wh2HfF2GNKckBOef6dKM3QdXO/FJYLfWHGDC9CpHptPQ+CxJyqQFG1O12R+4qLzrMg+uvokbV6uuLzs4zfztA3AULmTK5XE9Yi4eipG/GycEGW+Q8GghgBBLCp7o+tRFupYLfM+l7QAybbKGc/IIDAmHObPbxM690kmbzyVhRRi86f+KaKhuHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14)
 by CY5PR11MB6344.namprd11.prod.outlook.com (2603:10b6:930:3b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 11:36:25 +0000
Received: from MW4PR11MB5872.namprd11.prod.outlook.com
 ([fe80::fdf8:dc0e:db69:f35b]) by MW4PR11MB5872.namprd11.prod.outlook.com
 ([fe80::fdf8:dc0e:db69:f35b%4]) with mapi id 15.20.6813.017; Mon, 2 Oct 2023
 11:36:25 +0000
From: "Yao, Jiewen" <jiewen.yao@intel.com>
To: Lukas Wunner <lukas@wunner.de>, Alistair Francis <alistair23@gmail.com>
CC: "wilfred.mallawa@wdc.com" <wilfred.mallawa@wdc.com>,
 "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "its@irrelevant.dk" <its@irrelevant.dk>,
 "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "hchkuo@avery-design.com.tw"
 <hchkuo@avery-design.com.tw>, "Browy, Chris" <cbrowy@avery-design.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: RE: [PATCH 3/3] hw/nvme: Add SPDM over DOE support
Thread-Topic: [PATCH 3/3] hw/nvme: Add SPDM over DOE support
Thread-Index: AQHZ58e8ZejDHgg5jECw+fb9Qu+kSrA2SrOAgAAufzA=
Date: Mon, 2 Oct 2023 11:36:25 +0000
Message-ID: <MW4PR11MB58723743D7A01A9E6876A4F78CC5A@MW4PR11MB5872.namprd11.prod.outlook.com>
References: <20230915112723.2033330-1-alistair.francis@wdc.com>
 <20230915112723.2033330-3-alistair.francis@wdc.com>
 <20231002084753.GA23546@wunner.de>
In-Reply-To: <20231002084753.GA23546@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5872:EE_|CY5PR11MB6344:EE_
x-ms-office365-filtering-correlation-id: 2c62211f-2065-49d3-52ba-08dbc33bcf9f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3VyizAH0XFt+i4tdfuN0RCjliKzoDnWnN93jBG/LJtPpEi24nUI0TBsyQlLEckn6nhQYzs5a+0ktYRbjt3UIWs9j0phhQeaulzFDG5ut0hBZXutcXgax3xNeB4Puh16FjTGOd6DpbIHfx28nVvx/mL3uGaeZqgQq8dKH6/rxDbIWChlDNn6Azh1FRzZF43UtJSWqUYz3HPKMTfU/VAG7hmuM7+74yFHC3kOsHKuCk4Hl27G6V+48hIZL0TEgv2Y0MwDLCmSxRAcTyEQlvdYO7DRKndxayyUrU0Zltf8gYOWkJzlVjfxxtm4US2n1ETDvretHAwIFFz54CDVC8b+LCM7JTdTGOZ7v6wXW+XhUL1R0bfmwqKkRc+TlUwP2SMkAg8labAA4LEp6K4d1QeOMhNzgaw17sTM3AjiREtj+x8u6UZKxucTZc7ay7msDH8tC/32MDzfj6nL9fzJZI2PNAL8/qZylNTG8lN2XJpKOP/7luxocYKqb6bSPrF9zuhrCEvYODCvtUuKfUaca477WjAjjG2iFkGyoZAtQgB12VXhTTr4WsRgLIlTSlumJyXiM/4o/EiWEf9zY7vuHZqjWM3z04GIdboZwX/qDqHLYEYEfn8bRF5X65kAM7wTVEUkqrcwpOiAhCEsViB3BobRsm2GEaAngJFpQXnrmv1PS6OY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5872.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(39860400002)(366004)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(52536014)(66556008)(5660300002)(66946007)(8676002)(8936002)(4326008)(64756008)(66446008)(66476007)(478600001)(316002)(7416002)(54906003)(71200400001)(53546011)(2906002)(6506007)(76116006)(7696005)(41300700001)(110136005)(966005)(26005)(9686003)(83380400001)(55016003)(86362001)(122000001)(38100700002)(38070700005)(33656002)(82960400001)(414714003)(473944003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hbLer0+DmkXykaWJAKQPq44+1ghFKojwZoxsWwvRwbL7nfrGGPWVJZijfK?=
 =?iso-8859-1?Q?Z78+gW3y2PN7jmpsIXbCCJ8RKuxkHgjVNV5CxOD5pYrMNSK+9wUD6Sab/B?=
 =?iso-8859-1?Q?WDez2xesPp5EPcIr2iOvyqh8LDcMed7pFfFaaeNuyhPz3GXLt1gzyx4kJm?=
 =?iso-8859-1?Q?KmwDBQGOczVYsBw80X6myW8O9klCaQyH8/F7+ZWabFUMIjNV5T7VOXy+Tx?=
 =?iso-8859-1?Q?+ZPLHnaAiMgF4hNhhClaP/d5QFxDjTs29ZNQbADm3AHUv+8ZvWslifcTjM?=
 =?iso-8859-1?Q?kP5fghawhkAr7wyGdotDiHLSSLw7bmWtaPiSPlrh7lOE9GTm1rQQlgW8fD?=
 =?iso-8859-1?Q?6HFN+pQpr/P+L5V4kdviu7dFaBCzQtjlTQCiXe618IuoPJ0+sGynRQtqzm?=
 =?iso-8859-1?Q?zZXY5fiC9iHjJYAA/zY5tNMzQv3YngLw+zFhfrRxbvT5WohFhjhAnje9eC?=
 =?iso-8859-1?Q?tx70kJrxV/9tMycWeV8YvG4Y2DOFJ0WvY1TTAJV4RkOcachYpSrRGCw/GX?=
 =?iso-8859-1?Q?3o3O8rERLDDz5vlZZ/OQRTN0VfycSsa4zot6VxfM6DsDxM8lxNgIk1vTjJ?=
 =?iso-8859-1?Q?tIzDrQZzghF0IQ9J0+nPSxhPhOtoVRlcBLdwmK53bafe7R99qS+6fmPhDL?=
 =?iso-8859-1?Q?CO2s3LWLvTRhUJcvY+bhdLTa+PPD4BfaHmZXJOW8EntRchvQEo6yCwwqlv?=
 =?iso-8859-1?Q?WowbXutsNzDb1fTDXDKcC5MS6dYtQadzWU8Gw3j3hYp5Uuu/oTIhqf+0tL?=
 =?iso-8859-1?Q?ZdtGwjEDefbhqXhvlqzSsKflU/N4iw/2jVYjZ2KnSaanqgtv8vgxS3VLV2?=
 =?iso-8859-1?Q?H3zHJjksPn+gcWaRKMA0V3vd1F2Wfm+suf5M3KpyADahfu+hQuwM7VtE6h?=
 =?iso-8859-1?Q?JvmB8IoKDMY8DPUrAZ+05u3cFEKUuFpVRhfwssXT6A0e9PoLBTU+s8jE9S?=
 =?iso-8859-1?Q?/VeK62A5Iss1Uybh8ssVFgvfkalNjI1liwge2tj7ASQUaHCvNbzV5KUxfz?=
 =?iso-8859-1?Q?10EJXqDxviPEhIw6EmVHN0tS6qt7lGnLEsgMNwgQPI1eG2ttv+DQF1fFGq?=
 =?iso-8859-1?Q?GiPIBy6lvL+ultPl/5foykaSwTEtAD7x6x/5ueVXNbzWLXZR6k/ByTdiZD?=
 =?iso-8859-1?Q?Pc5a01aW1nesqWOLiuosYneegOhtgQSIiyOQM4aPKL7GW5iKkssirstdu0?=
 =?iso-8859-1?Q?YvXgQamZcnT2MGDYgzpQcmGZq0HVPBP7YVQ6++ORlZTSR7piVvVTzzTFGj?=
 =?iso-8859-1?Q?9v3JHHVx+ve3G4C5pJ+HhCcMrZstfloJQo6KpptUkO0iHcW8bkMTh8/MXe?=
 =?iso-8859-1?Q?XU+kX2/3urbE8NITXFIcv0h0/sX0x4e6HQ7JrI5GkSn5oAaHSi+R4N/Y8O?=
 =?iso-8859-1?Q?Q8Tkr8c6+UQKnpEctWpHmXau/cEjn0vGi4KIJcH9viEFamymOnvuvBMty1?=
 =?iso-8859-1?Q?UfoKI+/Wrcd/pC+e9JG09qMOlR+2palTWZDKhvCzSKeuL/Bu3g98L7A8er?=
 =?iso-8859-1?Q?vQW8V+u8uF48wrBJsDZ3mbZTBJHWceM0AzNh0dSwvNDha7Ynz88SLRPuIR?=
 =?iso-8859-1?Q?uZe5TD2zG2eFwUq3i0AT0KG8hdfTBO5uBO3ZR0F5EeeAeTClqZP+kysWPm?=
 =?iso-8859-1?Q?c0PsGPCYlU9JeNnn29LkOZhyUU9h9ZjkzE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5872.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c62211f-2065-49d3-52ba-08dbc33bcf9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 11:36:25.6473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cd8uNygCrY1vZMSx9ut83M4nME/VEqBiepqVbrSnqgUTyui+azzDyjweQX0lF3D0OFAzldKQzDGD4wasoeUdqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6344
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136; envelope-from=jiewen.yao@intel.com;
 helo=mgamail.intel.com
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

Comment on subjectAltName.

PCI-SIG realized that it may cause problem for certain device and decided t=
o remove such requirement in future ECN.
I=A0don't think that is absolutely needed.



> -----Original Message-----
> From: Lukas Wunner <lukas@wunner.de>
> Sent: Monday, October 2, 2023 4:48 PM
> To: Alistair Francis <alistair23@gmail.com>
> Cc: wilfred.mallawa@wdc.com; Jonathan.Cameron@Huawei.com; Yao, Jiewen
> <jiewen.yao@intel.com>; qemu-devel@nongnu.org; kbusch@kernel.org;
> its@irrelevant.dk; mst@redhat.com; marcel.apfelbaum@gmail.com;
> hchkuo@avery-design.com.tw; Browy, Chris <cbrowy@avery-design.com>; qemu-
> block@nongnu.org; Alistair Francis <alistair.francis@wdc.com>
> Subject: Re: [PATCH 3/3] hw/nvme: Add SPDM over DOE support
>=20
> On Fri, Sep 15, 2023 at 09:27:23PM +1000, Alistair Francis wrote:
> > --- /dev/null
> > +++ b/docs/specs/spdm.rst
> > @@ -0,0 +1,56 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > +QEMU Security Protocols and Data Models (SPDM) Support
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > +
> > +SPDM enables authentication, attestation and key exchange to assist in
> > +providing infrastructure security enablement. It's a standard publishe=
d
> > +by the DMTF https://www.dmtf.org/standards/SPDM.
> > +
> > +Setting up a SPDM server
> [...]
> > +    $ cd spdm-emu
> > +    $ git submodule init; git submodule update --recursive
> > +    $ mkdir build; cd build
> > +    $ cmake -DARCH=3Dx64 -DTOOLCHAIN=3DGCC -DTARGET=3DDebug -
> DCRYPTO=3Dopenssl ..
> > +    $ make -j32
> > +    $ make copy_sample_key # Build certificates, required for SPDM
> authentication.
>=20
> Might be worth pointing out that certificates need to have a
> Subject Alternative Name in compliance with PCIe r6.1 sec 6.31.3,
> what to add to openssl.cnf to get one, e.g. ...
>=20
>     subjectAltName =3D
> otherName:2.23.147;UTF8:Vendor=3D1b36:Device=3D0010:CC=3D010802:REV=3D02:=
SSVI
> D=3D1af4:SSID=3D1100
>     2.23.147 =3D ASN1:OID:2.23.147
>=20
> ... and how to regenerate certificates after modifying openssl.cnf, e.g. =
...
>=20
>     $ openssl req -nodes -newkey ec:param.pem -keyout end_responder.key -=
out
> end_responder.req -sha384 -batch -subj "/CN=3DDMTF libspdm ECP384 respond=
er
> cert"
>     $ openssl x509 -req -in end_responder.req -out end_responder.cert -CA
> inter.cert -CAkey inter.key -sha384 -days 3650 -set_serial 3 -extensions =
v3_end -
> extfile ../openssl.cnf
>     $ openssl asn1parse -in end_responder.cert -out end_responder.cert.de=
r
>     $ cat ca.cert.der inter.cert.der end_responder.cert.der >
> bundle_responder.certchain.der
>=20
> Or preferably modify upstream libspdm to automate this process,
> make it less cumbersome and error-prone.
>=20
>=20
> > +static bool pcie_doe_spdm_rsp(DOECap *doe_cap)
> > +{
> > +    void *req =3D pcie_doe_get_write_mbox_ptr(doe_cap);
> > +    uint32_t req_len =3D pcie_doe_get_obj_len(req) * 4;
> > +    void *rsp =3D doe_cap->read_mbox;
> > +    uint32_t rsp_len =3D SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE;
> > +    uint32_t recvd;
>=20
> Might be worth mentioning somewhere that this only implements the
> responder role.
>=20
> CPUs are coming to market which contain a Trusted Security Module.
> Some of those TSMs are capable of the SPDM requester role.  Should
> qemu ever have the need to emulate a CPU containing a TSM, it may
> become necessary to add SPDM requester support.
>=20
> Thanks,
>=20
> Lukas

