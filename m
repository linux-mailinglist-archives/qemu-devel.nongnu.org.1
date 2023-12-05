Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E867806166
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 23:06:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAdXn-0007gC-CV; Tue, 05 Dec 2023 17:05:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rAdXl-0007g1-Dp
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 17:05:29 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rAdXi-0007PD-Ch
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 17:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701813927; x=1733349927;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9zYmK8zA7IvpIJ3kuXIi/vqEiIXZnId+JFyzu7dzXjQ=;
 b=fKPPyjOFX0etXTuYs5Ua+V7J9YkqqKzNexfITB+Z27S7aXuwmDVXbEnP
 JxW7DXUlx+n1jvcGQKil/UwqM6hNNQh8oSQF68WQUFihi1hfdwBJAiIci
 IJ3gM4rhT8HOaQQYGUQK2WkYAE0Fon9dCtj3NsCDWeHGpzlnwOe9gJg31
 Hvmb9+6K4IEZWAyKeOMi+cXQFCkzEqWKMGRTcBJPH1xjh6ePqZdOYT573
 ghWuIZl/p4eKL3kwcGWJcAsm9auaiaSsQCaIf6P1Ru/ASC1WvCzVQ5xiv
 GdikpsAWfawtKRMXf0DuyKmu2V0y+j1j4Lp0ccIEtOSOHojVPsP+kF+AQ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="7313715"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="7313715"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2023 14:05:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="800116927"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; d="scan'208";a="800116927"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Dec 2023 14:05:22 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 14:05:21 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 14:05:21 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 14:05:21 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 14:05:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAw7BvUEC2vpjWLLmOzuapouGDudbtorGHJ0Ed5GpUNNHjoN89chyCzNN5oY42pTfoixsri5k5LxvJwJYBjxw/rZH7lQY8T4VnKHzygsVe9cogf0zcCZsbzHli4Eee2dgcKzS0POcr6FoYUi8nx/ioyTdQ578AVpyEUBqKQjqTorizO5ACIJ4P+TLg+X2VXV5RA9FDt3Uj74ozr+Oo0HVAgJJtP6A4Y/xI1ioOd4Vm1ODf+gKa3nA07EuhYXLgc5jHfvW06x99JrFRtViM5yuN2AUuGkQ2riTGdXsbz15Ez1iXeKHQQOqM/19yIP+tvfMJJtuCwufPbzuxAGfPaMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zYmK8zA7IvpIJ3kuXIi/vqEiIXZnId+JFyzu7dzXjQ=;
 b=b2nJo9vYPgW79XmQkH0hShGBX6iPfVz1vmwkIldyJ7oFmdTBoKOQtNHSLP9VuFG0xk/XefxL1O3SW1TaNoCosEHvaL/dlfOBBRmM1itjFxpanPsDl4O9fu1D6Kl47FCqr5EouzjnR/ZTmnOlLyS8Zq/t/YQEzX78dHFqFcrOlB9hrSAFYFf5tipjGvMNWgLhzHW/JIuCO+8sk7wtkIybo2rmhJmTp+GKdRMLy3VAYb2hPKZow6ZUf8Qv2u3WADh1CUvu7VQ7DzvBSKISZ2c11FiRxgbCmOqPUcwtsIKzleXHyhtiiJ9OdbGKpYp3th1pYLXrXHg/4S/HjaZlcYTiOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by PH0PR11MB5596.namprd11.prod.outlook.com (2603:10b6:510:eb::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 22:05:18 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::3785:7fdc:883b:5fba]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::3785:7fdc:883b:5fba%7]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 22:05:18 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Kasireddy, Vivek"
 <vivek.kasireddy@intel.com>
Subject: RE: [PATCH] ui/gtk: flush display pipeline before saving vmstate when
 blob=true
Thread-Topic: [PATCH] ui/gtk: flush display pipeline before saving vmstate
 when blob=true
Thread-Index: AQHaJyRrPXY0WWk2a0yDzjByQMzS4LCaRyoAgAD330A=
Date: Tue, 5 Dec 2023 22:05:17 +0000
Message-ID: <PH8PR11MB687919540DE3FAACC35F8CE5FA85A@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20231204184051.16873-1-dongwon.kim@intel.com>
 <CAMxuvaxQc0EM0jPDTgmK+hM9EMjqrY696RzS4NWengbdC5ifpg@mail.gmail.com>
In-Reply-To: <CAMxuvaxQc0EM0jPDTgmK+hM9EMjqrY696RzS4NWengbdC5ifpg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|PH0PR11MB5596:EE_
x-ms-office365-filtering-correlation-id: 74bd95e2-5fb4-4231-b4ea-08dbf5de4443
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4NvrIcf41f+knpG7xdU+jVh/3z0bNqADWENJnzKSvriJNl+V0GU/5Q/mEBGUNJsuIccHCl4aVda+zsvC7DAMvFQFXcGMc+6P0o5Us6G/68OhQlf0SSs57Sr5vB/HbJTjjxbPsNwUBgaAGIprncu+thyvPZaSSzsXcXPdq/KiJdyHD4cSgud6ZykBHONbTeWOHE7QZn8lSf1b0K0iDt5SyWyDqJ5yHnisSf7esbfPUDmY7i6aMyzHwhzvUqkFHwcaR4ERvFmCS7DUixeYHZYhD+KtuF/qxuzbUOyLgRscP2PC+OQGkBojrD11M3ml/lfkThSgs/vhSK1Rbv5ReVfra6mfgWs1nqE39vY0xvdAIsfU3WNRP6WE3+lv2rqN3QZ9pem40m6S/fP5S+XuZW+Fb093yXatePWo777TcZm3Ra5JwgYMLYHbAKfhEfckaeB7UPwmGYFy14fdJB0svQ7zLi5c68Jvnj1I0XjwZmKd18At+SQGQ/d3j7BIpEkOP7bBVSMK9e/UdS+EAxLIryjkm655aqdG1KpXNQtRaYrf1eLuekeRx1L+QDd8UnrWEYcsP1gioxeB2rfTpSDXD1bN3VZAKBjsfWDlqjDlEcJcxKM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(122000001)(38100700002)(41300700001)(55016003)(83380400001)(82960400001)(38070700009)(2906002)(9686003)(26005)(33656002)(107886003)(71200400001)(6506007)(53546011)(478600001)(7696005)(5660300002)(86362001)(76116006)(316002)(52536014)(64756008)(66946007)(54906003)(66476007)(66446008)(6916009)(66556008)(8936002)(8676002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cm1TZDlHeHVhSEFGcFc3NXdWZ1FMZ2M4a3dIWlVEdVFHeSs1NE9tVGRhMHcv?=
 =?utf-8?B?S1ZDdndPYllmM0dzcGZ5alJRM1l5SjlPMlZUQnRVakljaHpncHdFZWJtN3pS?=
 =?utf-8?B?dFBVVEdxZXhhcGlySlJ6UHN6aXRvK1RPWnI0ZXEzYXY4bWhIdlpOaXQzaHVU?=
 =?utf-8?B?TVR4UkZnY3hvMUsyMEx2WUdhRWdqemNacWUyQnZWVTZYU2ltUXFUd1VYVmFB?=
 =?utf-8?B?dDVGTTdDTnhGK1lSZ05OV1ZyK1BIWEdMRGZrbExMa3VyOVIzRWNZQXZMVmVK?=
 =?utf-8?B?eFJlejRLZmJWemMrTUZoeFJLak1ML3d6VU5Ed3dzUjB4S3BMbDNCVnpXUnc3?=
 =?utf-8?B?cEtnaWhJWkszcEQ0bStRTjRUbGoxVUowMmZ4ZW4xcWZoMWROOU5IR1dleHpC?=
 =?utf-8?B?RXFPdmFXdTdCeDgrZktEUjh1VStMZ0daZE9hdUtWNWZQN1c3WmFibkhnVWMy?=
 =?utf-8?B?QVdTbmJMZ2RDdWNLQXJkRWhWVytCdnYraExBU2phS0owa2tBTnR3NWU0bHNJ?=
 =?utf-8?B?OU5YTlJ4TklyeVlmTk1BeTJiY2JiTmswMkJUZE5OWkZUTVVZYVREMjFFZ1U1?=
 =?utf-8?B?T09mQWlzZERGMUo5ZmI3SytlMStxZFh3dU9XSlZhekJPVHk5bFdyNG5jZ2pl?=
 =?utf-8?B?NmdnMDdHd1BrSjF6K3NHSXNnMmRsbXh6YUQ3eFVaZTFidkpWT3pMYkpVQmVU?=
 =?utf-8?B?eWdyaW9BcVZLTTFFczhmbjdMWFV3RjdNSW1wNXAxUzF1dU40ejMyK3V0SnZZ?=
 =?utf-8?B?STJVRVRDTlJDc3E3UWVwYm5LUG1Xc1NGcHc4ZHU1c21iSGNCeFNQWGx0aHlL?=
 =?utf-8?B?SjArbVVTVFhtNTcvSVdUM01OZjlrbm1nTlZOV00yZGRHV1J4aUJPN2lzSHBv?=
 =?utf-8?B?UDN3YnRlN0NvbnEzSWJqNDZqdTFCcDl3aEMvTi9VdlZyTGV6SDRBZll0L3Ey?=
 =?utf-8?B?WEhDUHBzRW9sRjhqREhVcGJwc3NTemRWenFzenZwN2ZVZ1dFZXh2L2lHMWdD?=
 =?utf-8?B?dGl1Y202K2hHNlZkY0ovaytjZkdtcFNtV0hIRzFHMnZiT0xhazZiSWVZaWpr?=
 =?utf-8?B?dlpINlZKT3NNZHMrTGpkSDFZYUFTRGo3YStJTWZReUtHU0hUSDY1eHpUTjZJ?=
 =?utf-8?B?Y3ZLQnl4QmlVYnZvU1lvUVVhOWZNZmJGK1M4L1B2cDZ3dmNCeEd6MDdJRnV5?=
 =?utf-8?B?dEtpMUtveFJ5MEFuWlRSSm1sektUSEkrZzQ3ZWVzR2tZM05QNVIrcTlqQUFl?=
 =?utf-8?B?TXJqckV0RGNGS2dNQ2l4RWNlTE90R1VKMCtSQktYV3pnVVpLbys1WjlQcjhw?=
 =?utf-8?B?SDBHUExVRzBpdUhHajNyaldMZHZOZ05xRWthay9FUVZTRVJteHhHbHAxWThk?=
 =?utf-8?B?K2UxTmVFbTlaTWZLS0paQmhSUjZsYVhBSm91UERpMWlvOHQ2NmtocUd2dXdH?=
 =?utf-8?B?dldlOE5KaEM0Qmx3bDU5L0FIai9yNzJIOE1BdlpiZ01FWjU1RFJxbWdUbHlV?=
 =?utf-8?B?Tk5RRzFYYmljMWl6NnV0blRrcDlla2VVS1QrWiswcDV4V3M3c2lpaWJ4bGFG?=
 =?utf-8?B?b1YwUS9MdTNUSUlNblQ1c1lsUGhxK2N6VVFtR1pCZ1JDOVZVdlcrV3crREtq?=
 =?utf-8?B?VHBpUjZNbW1HdmF2TFJqMXNncjZocmpIU2FqZXY1bUpod3lWWmVJemhGVW1H?=
 =?utf-8?B?TFZxa1JheWdoR0UwMlNUa3BsVUx4RmFjS1pCVU9HOEIwdFdJRGh1cE0zYlQ4?=
 =?utf-8?B?TzluVWxGSWVoekx6ajMyc1JxcE9CZjByZHU4Y3Z0U3JwRlNRbTlYZnpXS3NV?=
 =?utf-8?B?MnN1T3V2STZ4WG9zdFNtY1ovK2krRTV1YTRQWCs0SW5oRDl0cC92ZjJna2dL?=
 =?utf-8?B?K3BHRGN3emlJQ1dpOWxKTGx0RnFQbURuRXYrSXp3N3l0MWFPQm5zajJlOEhB?=
 =?utf-8?B?NXl0ZXo3dDRVV3o1dUxoNGIxbElLdWZONlowaUJJekgwa3pNQVBJOFBCTGls?=
 =?utf-8?B?OGNiazFrMzZhQnptblpHMjZUMDh5bWdqYjF3Vlg0RVNLazFheXgvRlp5REgv?=
 =?utf-8?B?Z0FuUVljNnZmemVPeitseldGcnJHVmR6MnFodHBKOFFKZ0c4dm9vMm16SHJH?=
 =?utf-8?Q?Tnamf7tLTwgyjtpH0vvDv4j9r?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74bd95e2-5fb4-4231-b4ea-08dbf5de4443
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 22:05:17.9341 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NcCKDwQCmMUB/iSWQT7Cxl/iIDyXlRq+T0ACi6zXvJ8tEGskY5FJ/lddnrtfXTyen5GCiHgRTP4+kEuG54QKjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5596
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

SGkgTWFyYy1BbmRyw6ksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
TWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+DQo+IFNlbnQ6
IE1vbmRheSwgRGVjZW1iZXIgNCwgMjAyMyAxMToxNSBQTQ0KPiBUbzogS2ltLCBEb25nd29uIDxk
b25nd29uLmtpbUBpbnRlbC5jb20+DQo+IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IEthc2ly
ZWRkeSwgVml2ZWsgPHZpdmVrLmthc2lyZWRkeUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIHVpL2d0azogZmx1c2ggZGlzcGxheSBwaXBlbGluZSBiZWZvcmUgc2F2aW5nIHZtc3Rh
dGUgd2hlbg0KPiBibG9iPXRydWUNCj4gDQo+IEhpDQo+IA0KPiBPbiBUdWUsIERlYyA1LCAyMDIz
IGF0IDY6NDDigK9BTSBEb25nd29uIEtpbSA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPg0KPiB3cm90
ZToNCj4gPg0KPiA+IElmIHRoZSBndWVzdCBzdGF0ZSBpcyBwYXVzZWQgYmVmb3JlIGl0IGdldHMg
YSByZXNwb25zZSBmb3IgdGhlIGN1cnJlbnQNCj4gPiBzY2Fub3V0IGZyYW1lIHN1Ym1pc3Npb24g
KHJlc291cmNlLWZsdXNoKSwgaXQgd29uJ3Qgc3RhcnQgc3VibWl0dGluZw0KPiA+IG5ldyBmcmFt
ZXMgYWZ0ZXIgYmVpbmcgcmVzdG9yZWQgYXMgaXQgc3RpbGwgd2FpdHMgZm9yIHRoZSBvbGQNCj4g
PiByZXNwb25zZSwgd2hpY2ggaXMgYWNjZXB0ZWQgYXMgYSBzY2Fub3V0IHJlbmRlciBkb25lIHNp
Z25hbC4gU28gaXQncw0KPiA+IG5lZWRlZCB0byB1bmJsb2NrIHRoZSBjdXJyZW50IHNjYW5vdXQg
cmVuZGVyIHBpcGVsaW5lIGJlZm9yZSB0aGUgcnVuDQo+ID4gc3RhdGUgaXMgY2hhbmdlZCB0byBt
YWtlIHN1cmUgdGhlIGd1ZXN0IHJlY2VpdmVzIHRoZSByZXNwb25zZSBmb3IgdGhlDQo+ID4gY3Vy
cmVudCBmcmFtZSBzdWJtaXNzaW9uLg0KPiA+DQo+ID4gQ2M6IE1hcmMtQW5kcsOpIEx1cmVhdSA8
bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPg0KPiA+IENjOiBWaXZlayBLYXNpcmVkZHkgPHZp
dmVrLmthc2lyZWRkeUBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogRG9uZ3dvbiBLaW0g
PGRvbmd3b24ua2ltQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgdWkvZ3RrLmMgfCAxMiArKysr
KysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS91aS9ndGsuYyBiL3VpL2d0ay5jDQo+ID4gaW5kZXggODEwZDdmYzc5Ni4u
MGY2MjM3ZGQyZiAxMDA2NDQNCj4gPiAtLS0gYS91aS9ndGsuYw0KPiA+ICsrKyBiL3VpL2d0ay5j
DQo+ID4gQEAgLTY3OCw2ICs2NzgsMTggQEAgc3RhdGljIGNvbnN0IERpc3BsYXlHTEN0eE9wcyBl
Z2xfY3R4X29wcyA9IHsNCj4gPiBzdGF0aWMgdm9pZCBnZF9jaGFuZ2VfcnVuc3RhdGUodm9pZCAq
b3BhcXVlLCBib29sIHJ1bm5pbmcsIFJ1blN0YXRlDQo+ID4gc3RhdGUpICB7DQo+ID4gICAgICBH
dGtEaXNwbGF5U3RhdGUgKnMgPSBvcGFxdWU7DQo+ID4gKyAgICBpbnQgaTsNCj4gPiArDQo+ID4g
KyAgICBpZiAoc3RhdGUgPT0gUlVOX1NUQVRFX1NBVkVfVk0pIHsNCj4gPiArICAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgcy0+bmJfdmNzOyBpKyspIHsNCj4gPiArICAgICAgICAgICAgVmlydHVhbENv
bnNvbGUgKnZjID0gJnMtPnZjW2ldOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgaWYgKHZjLT5n
ZnguZ3Vlc3RfZmIuZG1hYnVmKSB7DQo+IA0KPiAmJiAuLmRtYWJ1Zi0+ZmVuY2VfZmQgPj0gMA0K
PiANCj4gPiArICAgICAgICAgICAgICAgIC8qIGZvcmNlIGZsdXNoaW5nIGN1cnJlbnQgc2Nhbm91
dCBibG9iIHJlbmRlcmluZyBwcm9jZXNzICovDQo+ID4gKyAgICAgICAgICAgICAgICBnZF9od19n
bF9mbHVzaGVkKHZjKTsNCj4gDQo+IFRoaXMgZGVmZWF0cyB0aGUgcHVycG9zZSBvZiB0aGUgZmVu
Y2UsIG1heWJlIHdlIHNob3VsZCB3YWl0IGZvciBpdCB0byBiZQ0KPiBzaWduYWxlZCBmaXJzdC4g
QXQgd29yc2UsIEkgc3VwcG9zZSB0aGUgY2xpZW50IGNhbiBoYXZlIHNvbWUgZ2xpdGNoZXMuIEFs
dGhvdWdoDQo+IHNpbmNlIHRoZSBndWVzdCBpcyBzdG9wcGVkLCB0aGlzIGlzIHVubGlrZWx5Lg0K
W0tpbSwgRG9uZ3dvbl0gDQpTbyB0aGlzIGlzIHRoZSBmbG93IHlvdSBhcmUgcmVmZXJyaW5nIHRv
Pw0KDQogICAgICAgICAgICBpZiAodmMtPmdmeC5ndWVzdF9mYi5kbWFidWYgJiYNCiAgICAgICAg
ICAgICAgICB2Yy0+Z2Z4Lmd1ZXN0X2ZiLmRtYWJ1Zi0+ZmVuY2VfZmQgPj0gMCkgew0KICAgICAg
ICAgICAgICAgIEVHTGludCByZXQgPSBlZ2xDbGllbnRXYWl0U3luYyhxZW11X2VnbF9kaXNwbGF5
LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2Yy0+Z2Z4
Lmd1ZXN0X2ZiLmRtYWJ1Zi0+c3luYywNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgRUdMX1NZTkNfRkxVU0hfQ09NTUFORFNfQklUX0tIUiwNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMTAwMDAwMDAwKTsgLyogdGlt
ZW91dCBvZiAxMDBtcyAqLw0KDQogICAgICAgICAgICAgICAgaWYgKHJldCAhPSBFR0xfQ09ORElU
SU9OX1NBVElTRklFRF9LSFIpIHsNCiAgICAgICAgICAgICAgICAgICAgLyogZm9yY2UgZmx1c2hp
bmcgY3VycmVudCBzY2Fub3V0IGJsb2IgcmVuZGVyaW5nIHByb2Nlc3MgKi8NCiAgICAgICAgICAg
ICAgICAgICAgZ2RfaHdfZ2xfZmx1c2hlZCh2Yyk7DQogICAgICAgICAgICAgICAgfQ0KICAgICAg
ICAgICAgfQ0KDQpJZiB5ZXMsIEkgd2lsbCB0ZXN0IHRoaXMgdGhlbiBjcmVhdGUgdjIgYmFzZWQg
b24gdGhpcyBmbG93Lg0KVGhhbmtzIA0KDQo=

