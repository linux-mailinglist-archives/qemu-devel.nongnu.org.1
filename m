Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E987B0389
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 14:11:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlTMo-0001Nz-Oj; Wed, 27 Sep 2023 08:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qlTMd-0001MO-F4; Wed, 27 Sep 2023 08:10:00 -0400
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qlTMZ-0001PG-Mu; Wed, 27 Sep 2023 08:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695816595; x=1727352595;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xHluHebULQjBwtyWTKrl3U5mzXKNI5gKuTtcaYh6tgs=;
 b=BlhgFXMTjWfkpNcp3odMzebVI2X7zO8bY1/vNJso437zO2P2uCaJBSom
 75h13y25dGTY9KNYhinqaIoaEXT2YhCX+V4crteeRK6p8cTOqgMWGX5x4
 i1tkQIRh/SqDTHr7BdCmoHJjlVWMkw4f6UpPT652QBanhcN7ZRtKJoUMN
 Mz6si/2vz6XWg4f0wNx4ewTG0/7CnLZOU61qvGhwUvslNFAXOrwSrXd6O
 SV4LC3XsR+srDWMtjKNFsspnIJEhSbGs/CoqL7S5zARbdHqD6Nx1c46aQ
 sqkzf8YHS2hfz2nx10CBeUfb83lgT8Y4vf9LtCD/ogW0uMazEbTYc6QVB g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="381708986"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; d="scan'208";a="381708986"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2023 05:09:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="752548601"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; d="scan'208";a="752548601"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Sep 2023 05:09:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 05:09:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 05:09:37 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 05:09:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mP2+qlv5+owMrBWIFdKeFiNuejYW5ZkYryRskm8IJSxr4VwwzmqSdr2joOhKXpRr7IyvqYHAV/5J5bMZWJ9/GejYKFrv5Om1VTmiHlOlSl0UZCj01OQ28aZ0x2DJa5KlyPJ8OOM96PLtfRxhVXANa5NOMSBrDRjjlzD/1iosg6FrtJdJvFRMBHBbrNEvQx6nAszc+AGNYLVbXXBzHQB26J/HVBDVt0s66aG8rAplOzGWVz9VnvpqCaaLEB13rnTCjQzHiNabhGvt7vtyjN1ZVSuLHafXCAcq4mDlfa2EBsgTL+agNUAzNUbbP/3c3pDlm5koO3EXxg1Dc5krVnMR+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHluHebULQjBwtyWTKrl3U5mzXKNI5gKuTtcaYh6tgs=;
 b=bi0YcWaGp1Gh4/bOikGSMONQdBDtI0CY7MjGWxuecBqmfoMtDlWVri5Bt9a9WOBteI6NLn5mO67yL6GzTAiXPNgBlcsykAebK14Mni4kesr4Mu0IyM0icgcAO+RWWx5eAj6VW5/U6xeTbhoyaizEcLqRZUH2eGmlZMNgeXVrHFw+hfyX4Wo0XYtDFbAmuBgEq0Zh5kNzbw0vmywlbXxfEC2/oGCbBUuaMJR45ShoO6zEBh59XiPblUuFLxHMPvOMeE5T6pbvSCLkmm9fHAzhufCxFDGPO7msEvJ7AzEqS82oP3K++mMbSV1tRS+qG8dSn3N2aYqEF0zQrvVniUXTmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by MW6PR11MB8409.namprd11.prod.outlook.com (2603:10b6:303:24c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 12:09:33 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::cfa6:8eda:9312:1c24]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::cfa6:8eda:9312:1c24%3]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 12:09:33 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "Martins, Joao"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Thomas Huth
 <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, "open list:S390 general arch..."
 <qemu-s390x@nongnu.org>
Subject: RE: [PATCH v2 09/12] vfio/ccw: Use vfio_[attach/detach]_device
Thread-Topic: [PATCH v2 09/12] vfio/ccw: Use vfio_[attach/detach]_device
Thread-Index: AQHZ8G9WWlJp/Edszk2rCn9JZNDPz7AucfuAgAAgoEA=
Date: Wed, 27 Sep 2023 12:09:32 +0000
Message-ID: <PH7PR11MB6722C385397F66D040C8BE5D92C2A@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
 <20230926113255.1177834-10-zhenzhong.duan@intel.com>
 <66548ae7-3cc4-94d8-de46-c15f2e402ed1@redhat.com>
In-Reply-To: <66548ae7-3cc4-94d8-de46-c15f2e402ed1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|MW6PR11MB8409:EE_
x-ms-office365-filtering-correlation-id: eb7b7a80-ec0b-4d3b-7310-08dbbf529c30
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NdjXaMptErGMdk5iSn0YIujCrlsGAiitIx7dRbuCjvV1RBtWK6r3hAGLj//9QAOxmZmb/yf9TawQwd+DYNdzPec7cZ5ypeuKFQdTz3lioAZ9ToCprmx1aQyRrjuUZ9eCWT2AHlsh7MgELrZ69UmBAiBjsGgs0cs2lMU2pYpDfTnMxN488OzEDOKjBL3kwfFSJhT0MtvbJ0x2oeM6l9IAE0Ed8Rp39vhiO7mZH1MR/0WF+EnVQ6EiLWz+ZBzo66gx9CSwko24zssUvdAiAF5/mHTfRw6p2lNV49SnnjjIE79oQvOFsW0bQbR8/0mmeb7rZD1mRt7I5fG1Nitww+WEI8XAkER81/O/fcSQoQyAWqTjbI3v7B3Yv+ZIVH2KnzptgZ3kNWE4WpDRP5SFqInAPalrcJnFdsmg9J/yhJyMoenrncUDy2jFFOLRW5TCOqVAg8zvafS1Djm+NQt7yg4rhr43NYGmbkiJCaFRwsZm9tZh7CeR24cOlbrteYkMgmn11biVwuF5l92xu+2y82ZvUeRONmfN8SC1bySqm65mlPIUhZmU6SmKxqlnKiMwUJHVVjaU/L+ejXrqnJN4WkqvMAUxbzZ9byKk1SyQ8aUvZ+GJ+oez+wCDAmVEDqg/teho
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(66446008)(7416002)(9686003)(76116006)(316002)(64756008)(66946007)(2906002)(66556008)(66476007)(54906003)(110136005)(41300700001)(4326008)(52536014)(8676002)(8936002)(478600001)(71200400001)(5660300002)(33656002)(38100700002)(55016003)(38070700005)(7696005)(122000001)(6506007)(83380400001)(86362001)(26005)(82960400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlIwQmlMa00rbHdFY2E2TnlpZ2lvZEJ1dXg5MThwNEczdU5ldFdkQXZ5ZTdr?=
 =?utf-8?B?N0NYMExoYjduKzFhd3dtaWV1WWx1RWg4eEpsZ3pCM00yNEVEd0tHaG5nTUdl?=
 =?utf-8?B?RDBNVzR1UGVxMGk0dUVZM3U5anBhRGkrOXJmVkhuRjBVbjQwS1hlZTZVY2Zi?=
 =?utf-8?B?bS9EbkQ4dTM0QkJjakJlUkxHaHlUN3o2WkZGUmxCYTFaZDAzRXVlcldUVk1z?=
 =?utf-8?B?UGJvTEMzM3R5VDhOMWJNc1RncmdUWWZqN0ptUTdpWW51b3RCTVFNc0lBME5a?=
 =?utf-8?B?d0Npb083STdlazRRR09YTWFrMjcycWxPcThKWEp0V1R1bkRlek5uTnp5L3cy?=
 =?utf-8?B?VnpsVU56RkJrU3oxMEVka0dSc0MzYjRCTmZVdy9PL1ZJV3NkMmhMbGlscXBz?=
 =?utf-8?B?N1dsN01GbjNtTk5XSHIzTDMwNVoyaklpVm8zbHJ3cmlrTUtsTkNLM0VIaWxz?=
 =?utf-8?B?S05vWFdPNG8xN3kzT21pRC9UZU9HOW1ZY0FsQmxrQXQ2QzRvZlVKTnhjd1Ra?=
 =?utf-8?B?SjltVStJbUxBcVZnOTZBN0g2K3ZFa1FzMlZnZ2NIRlF5ZFpYZmtCRjlBZ2Fl?=
 =?utf-8?B?MDRNbnpYRDVyYkV0MmduSTdlVTcwYnQzTldrUWN0eFYxemVCaW0vQUNYTkV1?=
 =?utf-8?B?b2M5eHdJTjdHYlhNMEJXT3M1VGYrd2dwd0lyRjlMYWlsNDhPdDhGcCtDZmpV?=
 =?utf-8?B?UGtpdno5aDdIcXFhV2RwWGVrZVgvUVpDYzUwRlRqQXFpVXU4UXpOdm5ZeU1Q?=
 =?utf-8?B?Z1pEbWt3a3NrNnEvL1A0a284cDlPUStuOWFkNDBUQy9QMFl4RjhNTCtvcHor?=
 =?utf-8?B?V1I5eGxXb3NCcW12M3U4WnZHUnZURGhEdGxOR0IrSHFkZ3hhRlhVZ28xS05U?=
 =?utf-8?B?RHFTekh4dGlqY3drdkE0NUUzbWZXRzRHc2V5UFlWSHZnU2FDV214U3U3NlNr?=
 =?utf-8?B?eFdaQjVWQks1bjBBMFJyOE51UGFJRlFmUG9MVU9PbjFOUzBJbC9hWTRTQTRj?=
 =?utf-8?B?OWw1ZDhSY2dXYkx1M29qcURXSXlpWE0xdGY3Wm0yV3dreGpWN0FWSVZyWWtz?=
 =?utf-8?B?Y2ZmZzNkMkF5ZlAwbXZYUStMR2c0V3NLSjR0cnVRWXZWRnVUZ01YZVJGeVBN?=
 =?utf-8?B?ZHF1VThZZnpROEoxdzMrWFEzWDJiRXhkRS9QME4xU3ZVVnhNSDNaN1d5M1d6?=
 =?utf-8?B?U1BqZWZaTnEzejVtWVlvdXJxbGgrWEVVMkc2S1dZM1pqQzkzUXcyYXJSQ3lS?=
 =?utf-8?B?eWw0ZmlPTFBFQk9Xek00dzVTNEdzL3E2bXNrblZROGdiRmJObEluUGxyZnVF?=
 =?utf-8?B?cGpudlMvU1VpUkoxSjNkKzczS1RKVVF5bjVYOG4wYk0vd0JjSWY1K01NRXhB?=
 =?utf-8?B?OE9vUFlVRzJORUdFV3dXMlpGWk1LblVDNGJoaU9wTndoVGRNK3JCSFZQdEZl?=
 =?utf-8?B?TGU0R2Fxa1RiMm5KUVc3V3N5dXoxRlc3K2FrWWsySnh6dU9UTVdyRnMxU2tk?=
 =?utf-8?B?cUw3ZFVuUzRkZjUrRTVSWmh6R2c3ZU1PMm1KMHNwUmFOa05aYkIzTklucmlI?=
 =?utf-8?B?T2VGS2xkd2FVbnhuVlFFZi95c0hMbnU5V2pBL0Jld2JOc2VUV1RUYnhzTHVP?=
 =?utf-8?B?bkdlQktMRUw1WlFhZzFSZGovZUNsWG1RWVI3S05wKzQ1aFBDcXBKeWdtbTVD?=
 =?utf-8?B?VStabjlMMkEyWmtuOXpKc25kK3dXU1VPN2ZxWm9UOU5Oam9kWi9MRU1YNHd2?=
 =?utf-8?B?cDJXYXVMbzg0bzBDaXVNdXRrbFBhNEc2YnpwZ0hGckJsZjBwSC9hMXFoZWlI?=
 =?utf-8?B?T0p5Z080dkNnNEJnVFlQSjQzd0FhS1M1b0F1ZEZQdlY4Y2hMWGNRSC9CcGpa?=
 =?utf-8?B?Vm52b3ZNTnEyMkdBRnVGaklGUWlpUnkxSG5HY2lSc2lyL2I5QmFYVitXQ1hS?=
 =?utf-8?B?ODFUaitvdzVucjFQKzZKT21QaVdPdjN1TkxrVi9FdjRDaS9IVnA4dmgwb285?=
 =?utf-8?B?d1JLbDBNbGhCeFV2SzBkV0U2eThGU0JEOHlETFNQQUFWVkZVOUhNZ3pYVi9r?=
 =?utf-8?B?bTFpYTg0TDJNSnJDaFNmK2JOb3ZRMGExUlBiS3RGNDMyVE9JWG9oeUNVOWFP?=
 =?utf-8?Q?Cyg7Bn9StxTY9xKWd7mAZx9fd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7b7a80-ec0b-4d3b-7310-08dbbf529c30
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 12:09:33.0983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1nbcku//Gun3A6oeGkDE8TLU+S5T7/s2fwIhSGYtsi1BFtSPA4sBj/Q/wrcjkFbcI8xypWs53ICcY9rrG+1l/OP52KznSdmaZuFc43ad2JU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8409
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.115;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyNywgMjAyMyA2
OjAwIFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MiAwOS8xMl0gdmZpby9jY3c6IFVzZSB2Zmlv
X1thdHRhY2gvZGV0YWNoXV9kZXZpY2UNCj4NCj4NCj4NCj5PbiA5LzI2LzIzIDEzOjMyLCBaaGVu
emhvbmcgRHVhbiB3cm90ZToNCj4+IEZyb206IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0
LmNvbT4NCj4+DQo+PiBMZXQgdGhlIHZmaW8tY2N3IGRldmljZSB1c2UgdmZpb19hdHRhY2hfZGV2
aWNlKCkgYW5kDQo+PiB2ZmlvX2RldGFjaF9kZXZpY2UoKSwgaGVuY2UgaGlkaW5nIHRoZSBkZXRh
aWxzIG9mIHRoZSB1c2VkDQo+PiBJT01NVSBiYWNrZW5kLg0KPj4NCj4+IEFsc28gbm93IGFsbCB0
aGUgZGV2aWNlcyBoYXZlIGJlZW4gbWlncmF0ZWQgdG8gdXNlIHRoZSBuZXcNCj4+IHZmaW9fYXR0
YWNoX2RldmljZS92ZmlvX2RldGFjaF9kZXZpY2UgQVBJLCBsZXQncyB0dXJuIHRoZQ0KPj4gbGVn
YWN5IGZ1bmN0aW9ucyBpbnRvIHN0YXRpYyBmdW5jdGlvbnMsIGxvY2FsIHRvIGNvbnRhaW5lci5j
Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNv
bT4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4gU2ln
bmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+
IC0tLQ0KPj4gIGluY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oIHwgICA1IC0tDQo+PiAgaHcv
dmZpby9jY3cuYyAgICAgICAgICAgICAgICAgfCAxMTUgKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPj4gIGh3L3ZmaW8vY29tbW9uLmMgICAgICAgICAgICAgIHwgIDEwICstLQ0K
Pj4gIDMgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgMTAwIGRlbGV0aW9ucygtKQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaCBiL2luY2x1
ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+PiBpbmRleCAxMmZiZmJjMzdkLi5jNDg2YmRlZjJh
IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj4+ICsrKyBi
L2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+PiBAQCAtMjAyLDcgKzIwMiw2IEBAIHR5
cGVkZWYgc3RydWN0IHsNCj4+ICAgICAgaHdhZGRyIHBhZ2VzOw0KPj4gIH0gVkZJT0JpdG1hcDsN
Cj4+DQo+PiAtdm9pZCB2ZmlvX3B1dF9iYXNlX2RldmljZShWRklPRGV2aWNlICp2YmFzZWRldik7
DQo+PiAgdm9pZCB2ZmlvX2Rpc2FibGVfaXJxaW5kZXgoVkZJT0RldmljZSAqdmJhc2VkZXYsIGlu
dCBpbmRleCk7DQo+PiAgdm9pZCB2ZmlvX3VubWFza19zaW5nbGVfaXJxaW5kZXgoVkZJT0Rldmlj
ZSAqdmJhc2VkZXYsIGludCBpbmRleCk7DQo+PiAgdm9pZCB2ZmlvX21hc2tfc2luZ2xlX2lycWlu
ZGV4KFZGSU9EZXZpY2UgKnZiYXNlZGV2LCBpbnQgaW5kZXgpOw0KPj4gQEAgLTIyMCwxMSArMjE5
LDcgQEAgdm9pZCB2ZmlvX3JlZ2lvbl91bm1hcChWRklPUmVnaW9uICpyZWdpb24pOw0KPj4gIHZv
aWQgdmZpb19yZWdpb25fZXhpdChWRklPUmVnaW9uICpyZWdpb24pOw0KPj4gIHZvaWQgdmZpb19y
ZWdpb25fZmluYWxpemUoVkZJT1JlZ2lvbiAqcmVnaW9uKTsNCj4+ICB2b2lkIHZmaW9fcmVzZXRf
aGFuZGxlcih2b2lkICpvcGFxdWUpOw0KPj4gLVZGSU9Hcm91cCAqdmZpb19nZXRfZ3JvdXAoaW50
IGdyb3VwaWQsIEFkZHJlc3NTcGFjZSAqYXMsIEVycm9yICoqZXJycCk7DQo+PiAtdm9pZCB2Zmlv
X3B1dF9ncm91cChWRklPR3JvdXAgKmdyb3VwKTsNCj4+ICBzdHJ1Y3QgdmZpb19kZXZpY2VfaW5m
byAqdmZpb19nZXRfZGV2aWNlX2luZm8oaW50IGZkKTsNCj4+IC1pbnQgdmZpb19nZXRfZGV2aWNl
KFZGSU9Hcm91cCAqZ3JvdXAsIGNvbnN0IGNoYXIgKm5hbWUsDQo+PiAtICAgICAgICAgICAgICAg
ICAgICBWRklPRGV2aWNlICp2YmFzZWRldiwgRXJyb3IgKiplcnJwKTsNCj4+ICBpbnQgdmZpb19h
dHRhY2hfZGV2aWNlKGNoYXIgKm5hbWUsIFZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgQWRkcmVzc1NwYWNlICphcywgRXJyb3IgKiplcnJwKTsNCj4+ICB2
b2lkIHZmaW9fZGV0YWNoX2RldmljZShWRklPRGV2aWNlICp2YmFzZWRldik7DQo+PiBkaWZmIC0t
Z2l0IGEvaHcvdmZpby9jY3cuYyBiL2h3L3ZmaW8vY2N3LmMNCj4+IGluZGV4IDFlMmZjZTgzYjAu
LjY4OTNhMzBhYjEgMTAwNjQ0DQo+PiAtLS0gYS9ody92ZmlvL2Njdy5jDQo+PiArKysgYi9ody92
ZmlvL2Njdy5jDQo+PiBAQCAtNTcyLDg4ICs1NzIsMTQgQEAgc3RhdGljIHZvaWQgdmZpb19jY3df
cHV0X3JlZ2lvbihWRklPQ0NXRGV2aWNlDQo+KnZjZGV2KQ0KPj4gICAgICBnX2ZyZWUodmNkZXYt
PmlvX3JlZ2lvbik7DQo+PiAgfQ0KPj4NCj4+IC1zdGF0aWMgdm9pZCB2ZmlvX2Njd19wdXRfZGV2
aWNlKFZGSU9DQ1dEZXZpY2UgKnZjZGV2KQ0KPj4gLXsNCj4+IC0gICAgZ19mcmVlKHZjZGV2LT52
ZGV2Lm5hbWUpOw0KPj4gLSAgICB2ZmlvX3B1dF9iYXNlX2RldmljZSgmdmNkZXYtPnZkZXYpOw0K
Pj4gLX0NCj4+IC0NCj4+IC1zdGF0aWMgdm9pZCB2ZmlvX2Njd19nZXRfZGV2aWNlKFZGSU9Hcm91
cCAqZ3JvdXAsIFZGSU9DQ1dEZXZpY2UgKnZjZGV2LA0KPj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPj4gLXsNCj4+IC0gICAgUzM5MENDV0RldmljZSAq
Y2RldiA9IFMzOTBfQ0NXX0RFVklDRSh2Y2Rldik7DQo+PiAtICAgIGNoYXIgKm5hbWUgPSBnX3N0
cmR1cF9wcmludGYoIiV4LiV4LiUwNHgiLCBjZGV2LT5ob3N0aWQuY3NzaWQsDQo+PiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY2Rldi0+aG9zdGlkLnNzaWQsDQo+PiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY2Rldi0+aG9zdGlkLmRldmlkKTsNCj5EaWdnaW5n
IGludG8gdGhhdCBmZXcgbW9udGhzIGxhdGVyLA0KPg0KPm5ldyB2ZmlvX2RldmljZV9ncm91cGlk
IHVzZXMNCj4NCj4rICAgIHRtcCA9IGdfc3RyZHVwX3ByaW50ZigiJXMvaW9tbXVfZ3JvdXAiLCB2
YmFzZWRldi0+c3lzZnNkZXYpOw0KPg0KPndoaWNoIGlzIHNldCBhcyBhIHByb3AgaGVyZQ0KPiAg
ICBERUZJTkVfUFJPUF9TVFJJTkcoInN5c2ZzZGV2IiwgVkZJT0NDV0RldmljZSwgdmRldi5zeXNm
c2RldiksDQo+d2UgbmVlZCB0byBkb3VibGUgY2hlY2sgaWYgdGhpcyBtYXRjaGVzLCB0aGlzIGlz
IG5vdCBvYnZpb3VzIGF0IGZpcnN0IHNpZ2h0LiBBdCBsZWFzdA0KPmlmIHRoaXMgaXMgdHJ1ZSB0
aGlzIG5lZWRzIHRvIGJlIGRvY3VtZW50ZWQgaW4gdGhlIGNvbW1pdCBtc2cNCg0KR29vZCBmaW5k
aW5nLiBJbmRlZWQsIHRoZXJlIGlzIGEgZ2FwIGhlcmUgaWYgd2UgdXNlIGEgc3ltYm9sIGxpbmsg
YXMgc3lzZnNkZXYuDQpTZWUgczM5MF9jY3dfZ2V0X2Rldl9pbmZvKCkgZm9yIGRldGFpbHMuIEJ1
dCBpZiBpdCdzIG5vdCBhIHN5bWJvbCBsaW5rLCBJIHRoaW5rDQp0aGV5IGFyZSBzYW1lLg0KDQo+
DQo+dGhlbiB0aGUgc3ViY2hhbm5lbCBuYW1lIGlzDQo+ICAgIGNoYXIgKm5hbWUgPSBnX3N0cmR1
cF9wcmludGYoIiV4LiV4LiUwNHgiLCBjZGV2LT5ob3N0aWQuY3NzaWQsDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgY2Rldi0+aG9zdGlkLnNzaWQsDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY2Rldi0+aG9zdGlkLmRldmlkKTsNCj4gICAgUUxJU1RfRk9SRUFD
SCh2YmFzZWRldiwgJmdyb3VwLT5kZXZpY2VfbGlzdCwgbmV4dCkgew0KPiAgICAgICAgaWYgKHN0
cmNtcCh2YmFzZWRldi0+bmFtZSwgbmFtZSkgPT0gMCkgew0KPiAgICAgICAgICAgIGVycm9yX3Nl
dGcoZXJycCwgInZmaW86IHN1YmNoYW5uZWwgJXMgaGFzIGFscmVhZHkgYmVlbiBhdHRhY2hlZCIs
DQo+ICAgICAgICAgICAgICAgICAgICAgICBuYW1lKTsNCj4gICAgICAgICAgICBnb3RvIG91dF9l
cnI7DQo+ICAgICAgICB9DQo+ICAgIH0NCj4NCj53aGlsZSBuZXcgY29kZSB1c2UNCj4rICAgIFFM
SVNUX0ZPUkVBQ0godmJhc2VkZXZfaXRlciwgJmdyb3VwLT5kZXZpY2VfbGlzdCwgbmV4dCkgew0K
PisgICAgICAgIGlmIChzdHJjbXAodmJhc2VkZXZfaXRlci0+bmFtZSwgdmJhc2VkZXYtPm5hbWUp
ID09IDApIHsNCj4rICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiZGV2aWNlIGlzIGFscmVh
ZHkgYXR0YWNoZWQiKTsNCj4rICAgICAgICAgICAgdmZpb19wdXRfZ3JvdXAoZ3JvdXApOw0KPisg
ICAgICAgICAgICByZXR1cm4gLUVCVVNZOw0KPisgICAgICAgIH0NCj4rICAgIH0NCj4NCj5XZSBy
ZWFsbHkgbmVlZCB0byBkb3VibGUgY2hlY2sgdGhlIG5hbWVzLCBpZS4NCj5uYW1lLCB2YmFzZWRl
di0+bmFtZS4gVGhhdCdzIGEgbWVzcyBhbmQgdGhhdCdzIG15IGJhZC4NCg0KVGhhbmtzIGZvciBj
YXRjaGluZywgSSB0aGluayBiZWxvdyBjaGFuZ2Ugd2lsbCBtYWtlIGl0IHNhbWUgYXMgb3JpZ2lu
YWwgY29kZToNCg0KZGlmZiAtLWdpdCBhL2h3L3ZmaW8vY2N3LmMgYi9ody92ZmlvL2Njdy5jDQpp
bmRleCA2ODkzYTMwYWIxLi5hOGVhMGE2ZmE4IDEwMDY0NA0KLS0tIGEvaHcvdmZpby9jY3cuYw0K
KysrIGIvaHcvdmZpby9jY3cuYw0KQEAgLTU4MCw2ICs1ODAsOSBAQCBzdGF0aWMgdm9pZCB2Zmlv
X2Njd19yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkNCiAgICAgVkZJT0Rl
dmljZSAqdmJhc2VkZXYgPSAmdmNkZXYtPnZkZXY7DQogICAgIEVycm9yICplcnIgPSBOVUxMOw0K
ICAgICBpbnQgcmV0Ow0KKyAgICBjaGFyICpuYW1lID0gZ19zdHJkdXBfcHJpbnRmKCIleC4leC4l
MDR4IiwgY2Rldi0+aG9zdGlkLmNzc2lkLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNkZXYtPmhvc3RpZC5zc2lkLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGNkZXYtPmhvc3RpZC5kZXZpZCk7DQoNCiAgICAgLyogQ2FsbCB0aGUgY2xhc3MgaW5pdCBmdW5j
dGlvbiBmb3Igc3ViY2hhbm5lbC4gKi8NCiAgICAgaWYgKGNkYy0+cmVhbGl6ZSkgew0KQEAgLTU5
MSw3ICs1OTQsNyBAQCBzdGF0aWMgdm9pZCB2ZmlvX2Njd19yZWFsaXplKERldmljZVN0YXRlICpk
ZXYsIEVycm9yICoqZXJycCkNCg0KICAgICB2YmFzZWRldi0+b3BzID0gJnZmaW9fY2N3X29wczsN
CiAgICAgdmJhc2VkZXYtPnR5cGUgPSBWRklPX0RFVklDRV9UWVBFX0NDVzsNCi0gICAgdmJhc2Vk
ZXYtPm5hbWUgPSBnX3N0cmR1cChjZGV2LT5tZGV2aWQpOw0KKyAgICB2YmFzZWRldi0+bmFtZSA9
IG5hbWU7DQogICAgIHZiYXNlZGV2LT5kZXYgPSAmdmNkZXYtPmNkZXYucGFyZW50X29iai5wYXJl
bnRfb2JqOw0KDQogICAgIC8qDQpAQCAtNjA0LDcgKzYwNyw3IEBAIHN0YXRpYyB2b2lkIHZmaW9f
Y2N3X3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQ0KICAgICAgKi8NCiAg
ICAgdmJhc2VkZXYtPnJhbV9ibG9ja19kaXNjYXJkX2FsbG93ZWQgPSB0cnVlOw0KDQotICAgIHJl
dCA9IHZmaW9fYXR0YWNoX2RldmljZSh2YmFzZWRldi0+bmFtZSwgdmJhc2VkZXYsDQorICAgIHJl
dCA9IHZmaW9fYXR0YWNoX2RldmljZShjZGV2LT5tZGV2aWQsIHZiYXNlZGV2LA0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgJmFkZHJlc3Nfc3BhY2VfbWVtb3J5LCBlcnJwKTsNCiAgICAg
aWYgKHJldCkgew0KICAgICAgICAgZ290byBvdXRfYXR0YWNoX2Rldl9lcnI7DQoNClRoYW5rcw0K
Wmhlbnpob25nDQo=

