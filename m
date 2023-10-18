Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B43C7CD254
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 04:35:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qswNs-0002VT-8B; Tue, 17 Oct 2023 22:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qswNq-0002Uy-Bd; Tue, 17 Oct 2023 22:34:06 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qswNn-0005Ha-Pr; Tue, 17 Oct 2023 22:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697596443; x=1729132443;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BAC4sElvu4yyJlCHmxpZsxXvhfs8t8SpJgqHQ74JBEo=;
 b=laZhRTVb+mGjVluaM+5WuU+UZ4IM7arBcFGtuZ6APJLDFmzMCy7NYBmQ
 uHSBdCGhVfkfORM8f6xBdIGXhvlYaqAcLOGldwGQWsHr5hay3y/9HPkOs
 4GLn4kzjFLQn4xHygNF2joQxWqttfOlcT/1yoJ0MwW4rhzQAClO33EXRe
 NTFLX+qxX5+aVShOOGSayPDDaZ763LsSf9p9kZenmNzBH4rqxWLDutW+2
 NjpmQGiFQQJpiM12zu6yDSvPd6FOse6hbSSrR7bF9sad0mwSCZC1y0gLK
 jQX//09diR50L1j9RaOWCE+9nsGR5TKsPC4DffL5bk5l06cd7u3S0KLBk w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="365274499"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; d="scan'208";a="365274499"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2023 19:33:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="929985101"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; d="scan'208";a="929985101"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 Oct 2023 19:33:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 19:33:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 19:33:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 19:33:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 19:33:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjH8PPzDIakOB4hniAfjTXpty+JWloFKpQNNGX+pYEkwNtlnWj+MvOu9Hk60dxSD68ePzjt948ru/QAmG5ElmsZ7DTX1B6qdGN41O8h+7y584gZ67UGhJWYV/SBJdCMwMWvgQHPUpTiYWn2TlroqDRRMiJbMgrO3uS7jfCnBL3Ec1gUbr2Dwqd1GX0rCfUdo34Q7UUJv3gDJ8V+DXM7Wp67eI9r2/c1LEJTPNaRenO+T8ICMlVBL3kBHge91A7wY2V5NAgVJ5LsBvek1H4crMiKdlosdwisqvRH3vTQJtKUAffo8B5TcNbfnXs/4I9M1eX470onfyax8ggtNmh0gdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAC4sElvu4yyJlCHmxpZsxXvhfs8t8SpJgqHQ74JBEo=;
 b=WFuPzR3mmX7Bcww7q6RNwJlxgzh7+La+4FERXY7zQkQWTMP2Fhjt7oUcyZm+nJszXVZ44Vru4WPvEicY4hDjoFb/vq3ilJ7E7eijACkQtFX8GbvKIj2uW9Xd6IuLrw7EePoQK711eb3VUj9qK8RNIs0ZLaJPAlREEAYX2IkdCMt4O9+ANzN1jxMeUIc5GFvtRqoAl0SgNoQn+qyTuXMqf0UJGcJ9zw36m0t6U8DLWGfSVVPOXXGiuC2rYEeEU5oD5J7wGrQRNtIBaHMgQSVa7+TFGESe9Z9eysdLy8tAHZwAwMkltLTEWQz8XNnBzWg3/Iul4KmRFU/GeRU0BcmTmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by MW6PR11MB8411.namprd11.prod.outlook.com (2603:10b6:303:23c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 02:33:53 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::2cfd:ca55:d42a:e46a]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::2cfd:ca55:d42a:e46a%3]) with mapi id 15.20.6863.043; Wed, 18 Oct 2023
 02:33:52 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Nicholas Piggin <npiggin@gmail.com>, "Daniel
 Henrique Barboza" <danielhb413@gmail.com>, David Gibson
 <david@gibson.dropbear.id.au>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
Subject: RE: [PATCH v2 01/27] vfio: Rename VFIOContainer into
 VFIOLegacyContainer
Thread-Topic: [PATCH v2 01/27] vfio: Rename VFIOContainer into
 VFIOLegacyContainer
Thread-Index: AQHaAA1jQM2FiKYmAEyGiumLX3tjcrBOIziAgACzQJA=
Date: Wed, 18 Oct 2023 02:33:52 +0000
Message-ID: <PH7PR11MB672202D8A075DCCEA4E6361092D5A@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
 <20231016083223.1519410-2-zhenzhong.duan@intel.com>
 <1b073713-a154-4ca3-b1eb-4f1b1b21bc28@redhat.com>
In-Reply-To: <1b073713-a154-4ca3-b1eb-4f1b1b21bc28@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|MW6PR11MB8411:EE_
x-ms-office365-filtering-correlation-id: ec6fa7ba-5e32-484e-dd04-08dbcf82ab14
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nYFKK63QHYfXd+pJAZ5rqfOztfnwvrhZQ8bmK6XY1mDabv8YGYX78aPVxuZ/Pa7OvQBZlBIW03YNhddPZOj15c+b7dUREQpfta9/aC7oBmrgd9NtOpxvvQPq1hBi05qn32QfllImXEzs7vVHP+jx7c8paGLBmSC2uSCNLoSH5ar+oE2yw/o418td11a509Csa5psDyN2PA9CYg92ljEBH+R4GXn4H0z9uSNb47jkfmL4RsCcAGXmXBs7r0/QhAlYH0Jrhr5TCVcaSp/RxcTvP48PXP7t1X/wDZsgW1lXXroE4gMksijb3+jJ77AEu8d+8W6bNI2q6LZ0Zks9mwUZvsPXBBLX58hqKYcfLYPcQQa1saKR9AULiJIk8JsnJ6RlWuSa9IqYxwMQicGp/Tj9h6WhL6P7YJR8znMNxVyC5oqRGF+ZgmrC3I+lPFy0suhYyrCp8DzVS0VnLv+ZyeAWShQ8X0vSBmUGafNXQnU9qXWo6Zf0MqI9uYoPn3x0h3ejPgQPpd5NyNR/yAoc++oc1r4mZF/e6TVInuUMtzEQk4PbPGyjy/YJKa3YuilnBjpAitZrFVVaiBTgBWAjf7nOfm0Rkat6IUlHQjyTJKeCbbudYmDfVutI5M2qMd5CKc50
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(5660300002)(52536014)(38100700002)(4326008)(110136005)(316002)(66446008)(66946007)(76116006)(64756008)(54906003)(66476007)(41300700001)(66556008)(8676002)(8936002)(55016003)(33656002)(71200400001)(83380400001)(82960400001)(7416002)(38070700005)(26005)(9686003)(4744005)(86362001)(66574015)(2906002)(122000001)(478600001)(6506007)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUJpb0tqVDNKbDZkSUlrK0hjYTMvV3NmbnZuVHRWTS94WitFaXQ0OXJhVmVy?=
 =?utf-8?B?b0JjSnpQUDVrZFdNamVCdzRuSUpiRVIrQzAyejMwYWtkNVB4cGx2YzhTbUpy?=
 =?utf-8?B?c0NkZ1NrOE15MGJaSE8xNWZGdzB3Q2RLQmViUnNURlJrTHcxNStTQUJkWEI1?=
 =?utf-8?B?ZmwxdjNSNjlKYm1WTk8zNDhSem93NXRFcUxHcnJhbmNFbFdIbkRHaXJDV1lj?=
 =?utf-8?B?SHpKc2RSaisrNjJMd2kvS051WS9wbU1rbHY3Ymcrc3gweDltNXNpZU92Vmxo?=
 =?utf-8?B?K1NEWERjL3MrSmorSWRxN0NjMmdrVHhtd05qdTdhU1JvZzZWd2JTdmU4OFcy?=
 =?utf-8?B?cXdGYm1qdmt0bEdBaXIyZktZOEhtRGQ0bnIydjM3dFMrUmpCVEwwdWJuZ0Vs?=
 =?utf-8?B?aXpWbElJaUlUTWREN1pxRnlscTVxQnhBbU80WEcrOFNuWFJnRFhXN3pyNUhw?=
 =?utf-8?B?Tm93SUVIcmZZbXRQRTJTa3QvMnRtNHdXTFM0dENJUEUwZ1g0OXl6RVlzTXZh?=
 =?utf-8?B?Q1hIQW9yczlwWGk3UllzQktCNWw1bWZrSTlPUzBIMUxsbGZQMDBUSWwzRk5B?=
 =?utf-8?B?dEhNRGxBaDVISFZlWXFDTktwZldMeENEQjBKWEp2bjRhakZwRUZRRmROakhL?=
 =?utf-8?B?OE4wenRKcGdrUXlSNjJhRDdvZUt0VVFFelhmOTlIc29uSjgrdUpJM2JJNmIv?=
 =?utf-8?B?YXVLeUpwb2FYejAzcE9CVmovVnc0Ri9NbjduRnlIZ3M2VGFHVU9NMmJpbzc2?=
 =?utf-8?B?UVA2dXNXV09Idm95ZFRmdmZ1SUd5R3BuTGxEQmJ1VEdEZzA0eXduK0tRTDBk?=
 =?utf-8?B?RllqVzZnQ25UVWZaeHJFbWhoT2daeDhJakEyZ3luM1JITVE1Wi8yUnVTWEZW?=
 =?utf-8?B?QWY3S09JN0ROVWtkdUErK3hPdnN3bFhxd3haUjF4Q3g2L015c2MzMDAzODZJ?=
 =?utf-8?B?UmZpNFgrOFNhNmlYVDYwOGY3bFh4NW9wRXhXMEJLc2FBSkZvdjlXYjZraHpy?=
 =?utf-8?B?dlNJZUx6MWZjVDRnU013cTY5UnNDS3d2NkNtQnRHaWIrQ01abFNOSjZTWTc3?=
 =?utf-8?B?d211UDZISjZoVUh3MDlET2FGek5KaGhhVG96SWcycUQ0ZE1FT2ZpNFM4aXQz?=
 =?utf-8?B?RGpwK2lsbGhBSjVoRTkwVFlHL1JDUzFMOUFqNGYzSW9jZ2ZWZm41SlNZMktx?=
 =?utf-8?B?NnoxemZVbTZHNXRJdFFvem9wQmswTkx0Qyt6ZTVrc1lWL01CNEUrMUxneUUz?=
 =?utf-8?B?NlQ3Nk4rT2YzTk5NeTY4bTFaQTdwUEJNNzZ1eElSdVRhYnY2TW9XVTkvbkVl?=
 =?utf-8?B?NGVnU3h3UXNsK3NuSGo2TFdER3owQktEUGpIY1RRZW53RHNVQmNQMlcydTJS?=
 =?utf-8?B?enA2VjQxTnEwb1dSM214MUdWRXJCT3N0andCdnY4L1pzUGs3cU5INkdqVnBW?=
 =?utf-8?B?Qk9ieGQ1a3h6OE1JM1pmWnpTdy9MTXgzQXFVcE5oYXIwc2pEdG9jck1TVFdN?=
 =?utf-8?B?dTR1NVJNZ0hra215eE55MUpWbjczYXZJbmhkazVPK3Y4OFFZOVVBNHR1K2F3?=
 =?utf-8?B?L1RHVnZJcmY2MzZWS1RCTlowaHRXL1cxSEl5dm5FUDFkU2EzTnFiYVA2S1Qw?=
 =?utf-8?B?elM2eE5iWWJVK3hQdEdHcGNpSC83OGRMTDhtb3FYZGZDVXRaK3FuSklsdVAy?=
 =?utf-8?B?R0FQcGUySmhOWnZ5R3k3UzJEYkYrcVBKYUtxOEJpOHNUZkRYYUk3T1JaRDRz?=
 =?utf-8?B?b0RUSlpOVitKMEU5ZFJobWhmVGs5QzJIeTFRYXo4QTNFQXk5TTh4VitIR01B?=
 =?utf-8?B?b1hUQlgzUEs1YWovb1pOamRabGk0TCtOVXJwTVF1ZS8wRGxCQlFINStWNFEz?=
 =?utf-8?B?ZUFTYm01cTZuS3FqMTJBeEVROEtjRExGblhGOHZDZUJyTCsvSGxTeFJOMFVw?=
 =?utf-8?B?R2VTRjFjbmNxOVRPVGN5bElNYVpMbEhtK3VIQkh6N2VsQmQxMzJzY0xaaG1W?=
 =?utf-8?B?OHRiWndNOGVCNHpqd3BHbEwxYmQxMEVjc291Mm13QyttdjR6T2U0amI5a1Nq?=
 =?utf-8?B?VHRvSTdTKytZOVBseDBjTU9RK1F4OHQ2Z0NJME9ZOEIzZHoyVnloMVI5QjRm?=
 =?utf-8?Q?PUyNS/akglF1tgZCTUm5LmWon?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6fa7ba-5e32-484e-dd04-08dbcf82ab14
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 02:33:52.5762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WrSCYppX/AiqS9Boe50Mmkz26WxWnTw9sLwyFaH8z/RHXBVGRRZnZZ5PGELShhn3PtIGk9OBxjBE464BBm7rLXmBQnZaOaj7n6Lnw/xk67s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8411
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUdWVzZGF5LCBPY3RvYmVyIDE3LCAyMDIzIDExOjUx
IFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MiAwMS8yN10gdmZpbzogUmVuYW1lIFZGSU9Db250
YWluZXIgaW50bw0KPlZGSU9MZWdhY3lDb250YWluZXINCj4NCj5IZWxsbywNCj4NCj5PbiAxMC8x
Ni8yMyAxMDozMSwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBGcm9tOiBFcmljIEF1Z2VyIDxl
cmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+Pg0KPj4gSW4gdGhlIHByb3NwZWN0IHRvIGludHJvZHVj
ZSBhIGJhc2Ugb2JqZWN0IGZvciB0aGUgVkZJT0NvbnRhaW5lcg0KPj4gYW5kIGRlcml2ZSBpbnRv
IHRoZSBleGlzdGluZyBsZWdhY3kgY29udGFpbmVyIGFuZCB0aGUgaW9tbXVmZA0KPj4gYmFzZWQg
Y29udGFpbmVyLCBsZXQncyByZW5hbWUgdGhlIGV4aXN0aW5nIG9uZSBpbnRvDQo+PiBWRklPTGVn
YWN5Q29udGFpbmVyLiBUaGlzIGlzIGp1c3QgYW4gaW5jcmVtZW50YWwgc3RlcCB0byBlYXNlDQo+
PiB0aGUgbWlncmF0aW9uLiBTb29uIHRoZXJlIHdvbid0IGJlIGFueSByZWZlcmVuY2UgdG8gdGhl
IGxlZ2FjeQ0KPj4gY29udGFpbmVyIGluIHRoZSBjb21tb24uYyBjb2RlLiBPbmx5IHRoZSBjb250
YWluZXIuYyBzaG91bGQNCj4+IGhhbmRsZSB0aGUgVkZJT0xlZ2FjeUNvbnRhaW5lciBvYmplY3Qu
DQo+DQo+U28gSSB0aGluayBJIHdvdWxkIGhhdmUga2VwdCB0aGUgY3VycmVudCBuYW1lIGFzIGl0
IGlzLCBuYW1lZCB0aGUNCj5uZXcgYWJ0cmFjdCBRT00gb2JqZWN0IFZGSU9Db250YWluZXJCYXNl
IGFuZCB0aGVuLCBkZXJpdmVkIGZyb20NCj5WRklPQ29udGFpbmVyQmFzZSwgdGhlIGN1cnJlbnQg
aW1wbGVtZW50YXRpb24gVkZJT0NvbnRhaW5lciBhbmQNCj50aGUgbmV3IG9uZSBWRklPQ29udGFp
bmVySU9NTVVGRC4NCg0KT0ssIHdpbGwgZG8uDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

