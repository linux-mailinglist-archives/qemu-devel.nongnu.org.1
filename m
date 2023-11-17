Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EE17EF204
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 12:41:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3xCO-0002Nf-NX; Fri, 17 Nov 2023 06:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3xCM-0002NT-B1
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 06:39:46 -0500
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3xCJ-0004oD-Mv
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 06:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700221183; x=1731757183;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vOoy/lMGhdbqvdM5CyL5qkDu626pWW/1xeY8ij4XE0E=;
 b=To4V4qErLuazyH7K4cm3nC49jmF+8pZlPD/4YAiOSs1tsG4bOhuftMxI
 pl5ljNS5EUKVDpx/zh5G9lwpcvhJr6wS32Rg5PLoBMOVKKYffMMCYaFJV
 jL6AkKa70UbhTONs7+DMGg7mzCF90x+l5IshfsVQ1b/IMPbe28xb5L0gE
 BWIpqQbGObyZO0PTwwESteg5/RfGAO44JSkgMmCZCdJceNrds+4TycIE0
 NEwhg3IZOAjUGoskNUIQPcNv7HblC3RM4ffA8FaBszoTVx0pYGPrPMbLM
 LwIm9VFoz1DhGxgwVyeXWjS8yx9+ok66eguHb339Gl35Q5FBDbQ7N0dpC Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="422379042"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; d="scan'208";a="422379042"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2023 03:39:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; d="scan'208";a="13901347"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 Nov 2023 03:39:23 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 03:39:23 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 17 Nov 2023 03:39:23 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 17 Nov 2023 03:39:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PL2Mwp3w1ku5AjFkP89Eqd87QRanEs4osD2ELG2W0SeeK1aP1qKW2r6OmRlkvr3xyD06oRN9m3f3k2+SigLQLYt3t7hGXn6Ts6K9hhzrSDHtGQakWdR5MDHAv/q/xVTuE4CrPWNT93zc1RDu94dc6GRBOJlPE7AtMXlA3I6QrDe4fJ1NnCSm7OgeTkrhD6qf0TfXjiu7+bdKM+4fzJJCmStBtPHp+0wCuZXEl043f1LS1k4r6qENy0sFx8jSpPOxeVzeCewn4afRcpNY6lulBjSPl+iHvXTMLFk88Lp2VwA2SEvwf435nyTyKxfmhofz1Uq2cR/pwUO5LYBsuhBRUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOoy/lMGhdbqvdM5CyL5qkDu626pWW/1xeY8ij4XE0E=;
 b=c+N6RVNsddbVX3JFMjQd7+QLNUNPGHgnXU6WfPBQPwDLbFyxwBXZeq418BWJHBSh/Zm+C3rwHj/7gu2lEVK696KEYf3Xdd58PKsZ1DClEEaOZgv/JNmGXdSUpxjTn28AOyJoVxqfLBajx0TLiE4N4tQbZ2ZPoaP3EXKHn41yvqjieGlAy1Kt16/d3XBWqch93cvnnaVZB7Ib1qABaFhluZx1KuqmWIPsMQuk94G/MJRiwm1vd9GYnYQDSb8Dx6NjF7J5/mEMB/GfEFW15SD7L/JKwjCyTnIddAuxooqTHgXo6wAFF3ucDh5EAmMAHL2KAmj/OIHc/NyHiIsF9zn8og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CO1PR11MB5186.namprd11.prod.outlook.com (2603:10b6:303:9b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Fri, 17 Nov
 2023 11:39:21 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 11:39:20 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "Eduardo
 Habkost" <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>, "lersek@redhat.com"
 <lersek@redhat.com>
Subject: RE: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
Thread-Topic: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
Thread-Index: AQHaFuTq+kqpFvBx/0+jXWJho7L/CbB+X2AAgAAFFfA=
Date: Fri, 17 Nov 2023 11:39:20 +0000
Message-ID: <SJ0PR11MB6744B1B91C890A9A1B81E89792B7A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-2-zhenzhong.duan@intel.com>
 <c964fdf3-d6ef-40cd-b4c0-32f1fb8501ae@redhat.com>
In-Reply-To: <c964fdf3-d6ef-40cd-b4c0-32f1fb8501ae@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CO1PR11MB5186:EE_
x-ms-office365-filtering-correlation-id: dd2525d2-be5a-4d6d-8c1b-08dbe761d6c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bp6If6EMNUC3jp3LndoXjVx+xv3M083WFrc8U8F2tYzim4nWumsip4VBxLrDVFcoJH/Mus5PMSlTfZtckPJC1XJxDYWEWC+crGjpfEd87929O91z9zaD+n44L/N5hZZQcUn9gVBcF0C+CTlpmehNAT/4NqAUpUTZXVXhIxz60RLBgX2/XxMzzq+iHkYiNJt9iCf21PiER0QEadOv8qUiV7HwurIbi1/LYUEBipZs48jHdSwTf2fLwWITIIsmAK+wNBr4QA0arPaNpe4hNxfDQbeX5CXFFZ+RtJCfu/jhvGEiKp5ZnUFlWEhOcwzza7b+mkOFBYYRvMGc1b1tnoX469sPw5IBkJJ1Bkj+u8U7vbQNYclpsXTu1m0SqG5NgAQQug2fiBxRAn9yw+elQhLVZ7T6KBsUb7VmpIDYmD4ESxkFJ6TmZ8TiLsD4Lc6ysRmDVQvRFWa6PxjhsYjGH5/AmenkzAEjg92h0xvBj5utQDjIlUT1U/YYWB6SXOcbkBhaL0Thjmfxlh4tAlm7dTqrSR3belY+IjSCe6oC9FT2/4JTAXRL+itmJDGMJezQ91DzDVCEjMzx/j4+JInhmrswkGmZQl1QR+9E7BvCkjWYTM4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(376002)(39860400002)(136003)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(41300700001)(9686003)(83380400001)(55016003)(4326008)(8936002)(8676002)(71200400001)(66574015)(26005)(2906002)(478600001)(122000001)(38100700002)(7416002)(5660300002)(6506007)(7696005)(52536014)(82960400001)(54906003)(966005)(316002)(66446008)(66946007)(64756008)(110136005)(66556008)(66476007)(33656002)(38070700009)(86362001)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1kwQUR5a3RucGY0Sm5tNXZNZlVCOVkrNUoydTVUektZamp4NE1Pb01OZWlp?=
 =?utf-8?B?aDkrc2NJMUVKTnI0Y3luRUtoaHJtRkc2MjhaZDJuNmpLZngybUdkS1k3MXJG?=
 =?utf-8?B?RmtGUU5QdHdrRWRVWExhdjdHa2RlU0tDcTE5eEhnWFBqWHcrVzg3RVhZZXNT?=
 =?utf-8?B?VkV6elVHMXcyNVpQQTFjMGlSK0c2WFI2cnZzZVQ0aTRDWDJ4bVUyVnAwZkVw?=
 =?utf-8?B?bzlEdmxjQ2xlK2pXWkZVcU83N09BdHFLVmtkRWxscFQxQWVQYWovMy9Hd2Fu?=
 =?utf-8?B?OHJ6TkViOERuOC9tSUVtMUhsYzN1MjFpMHliN3Y4QUVKMXpGWlJSdVJtQ1k4?=
 =?utf-8?B?M0k4SS9BVFdKMjFGYkNVMUpjSkl6a01OZVlGdlRSdDFJeW45SlBKNTB1aThQ?=
 =?utf-8?B?L2RNL3JxWFRWMjFpZ3RGOGNyd2dtS0lmVXVvMXdobitrN3V0eC9UdkgrTjJn?=
 =?utf-8?B?QWRtUFM1NDhXTFNiVGh0MTRzZk1Vb1J1OTRvdlViTFFaS2dWTFJuSHBVdERm?=
 =?utf-8?B?SGkwMzJ3ZlRaRzRBZzZwL3VrMWpldkF3bGZUM2RuNTl1dnREd2dYRnJoRCti?=
 =?utf-8?B?anJTNDUrc2dpcDNkeTRhV0VueHZxcDlVN1VpNk9rMFdyNGVMaFpXUHM3U0JP?=
 =?utf-8?B?TzJtekFTckprbXFUSnZuM0JHbmZReFdWdFdqZlZ3QW5paGdHcVN4MlJtbzFM?=
 =?utf-8?B?Q2dLNVUyVzlOdDVTMHQ4TjROYk5obTlUR3RscnMydUNreHN2YkloZ2htVWRl?=
 =?utf-8?B?RDNOcDBEMTRVU1NyeUtmVXhGdkwrQnZTM0NnZ3JlOGVkaFZBeGprYUFXTmVT?=
 =?utf-8?B?M3RHWFRJQlR3NGJiem1kbitwbDFOU2xHZ3JlUWdJWWxuMzkwRFZyNEh4TmI3?=
 =?utf-8?B?RjVkRkhsYXlKOEpibE1DRG1PYjBaZmNEd3ZKOFRZMmhSWjU0VFFiRmFTQmw1?=
 =?utf-8?B?M0dSejBpZG5kMzRSaDAvWksrU2l6bjhtU3VFQXJ6SmZwakpjdkFySVBOc09O?=
 =?utf-8?B?QWV2Tkw3Rk5IUXM4TDZVMENKYjFKaWl5WXlZSjJMY2pzWHN5UHkyQkRERDRk?=
 =?utf-8?B?UExNVWZUSEtJZVlXUW5qMCtGQkI4VmYxS1BwUHRGdFBsK2ZmZGVHMW9IN1dv?=
 =?utf-8?B?TDNlVTJNMWRuU1N3NWx3OE1VU0dCbFZjdGNoSHRFd1EzbG53b2Vaak1NS3Zo?=
 =?utf-8?B?RUplOGhPRnhjWTBzcS84NTRYc0g5SFN5NTZLQ2JONHNXS09zcGc5SEhRMmUz?=
 =?utf-8?B?bjhuZ0dHMkJLc0ZxWGt6cXJ0WlFQMjJFN3pwYVJRT1ptOEUza1oyVFNvZEx4?=
 =?utf-8?B?ZmNBM01FRFRjbHRtMmRJMVhSRTM4d2FhS05DYm1kS3J6Wm90RkZPeHhWSXJR?=
 =?utf-8?B?UDlCLzRJMEh2RnRsWkgwK2NmOEc4T1doMks5SU1jM2plU0RqbDNyZEtHSjBD?=
 =?utf-8?B?THBzQ0dQUzVKaFRISGwvU0VmbVZzZVQrdmJDci9LejVKa0lCRDg2VU5Ya2Q4?=
 =?utf-8?B?SExVNWlrREVHYVgyQkpLUm5qcUYyWjhVVm9GNUd2UjBvZ0pnYWIwZWl1djVr?=
 =?utf-8?B?Q2NJSFlkQUlBNEtlWTcvUUFsbndJOTB5VHFKMUMzUExjamt3UE1JdFozeCtl?=
 =?utf-8?B?UzB3cUZUUGFqbldxNWZ5Z2U0WlZuMnNiOHljZHhBSmlUaXRXbGc2WUpSa0cz?=
 =?utf-8?B?VUowTWFCWVNPQ2NGRFpXOGRBMHUwb3B1aUR0dytJUUFTWjFQRDFPdit3cUZs?=
 =?utf-8?B?Qm5kWEw1ZnlPR0xJSmVGaVFVWUtINTlkUnd6eS9jSHlVSEREcy9RQUcrbksr?=
 =?utf-8?B?YnVkOTY2WnNTSnJmYnIzdGVWTmpqTThHSDZVQzg4QUpCM2dyaDlBNHhuVzY2?=
 =?utf-8?B?WE1mblA0QW5uTmp1SG5IdzF0OGFhLzM4RmpBM0pwcThFczVlbEFrUWRPQ3pn?=
 =?utf-8?B?b1llSys2MzRhOEI5eVdwUWJwN0l6ZW5XVXlVQnQ0SzY3LzUzMlhGTmVWS3ZT?=
 =?utf-8?B?U00zQkMwcmFVTXdaS2xUQ20zeWtrVFAvaUp5c3RUNTZuTi9HdDFnaVNyTnJF?=
 =?utf-8?B?UTVkakVPWENPbzg5ZS9IMGRGOVFReDQ1T25Tejg2NUtSVXNtb3gyd3NaZVNu?=
 =?utf-8?Q?BYogLckct2CVyzS8rjTa9kfG/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2525d2-be5a-4d6d-8c1b-08dbe761d6c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 11:39:20.3692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E1u2byjIH4521cyOACmQhIlSmRBYM2r+8JLBvcF3iymboCU859vNkS/V/uHrMrxEQggonouVqLvB1uRmw36JyLDE85vvw+4+dM05CChFBQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5186
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.88;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMTcs
IDIwMjMgNzoxMCBQTQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDEvMjFdIGJhY2tlbmRzL2lv
bW11ZmQ6IEludHJvZHVjZSB0aGUgaW9tbXVmZCBvYmplY3QNCj4NCj5IZWxsbywNCj4NCj4+ICtp
bnQgaW9tbXVmZF9iYWNrZW5kX21hcF9kbWEoSU9NTVVGREJhY2tlbmQgKmJlLCB1aW50MzJfdCBp
b2FzX2lkLA0KPmh3YWRkciBpb3ZhLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBy
YW1fYWRkcl90IHNpemUsIHZvaWQgKnZhZGRyLCBib29sIHJlYWRvbmx5KQ0KPj4gK3sNCj4+ICsg
ICAgaW50IHJldCwgZmQgPSBiZS0+ZmQ7DQo+PiArICAgIHN0cnVjdCBpb21tdV9pb2FzX21hcCBt
YXAgPSB7DQo+PiArICAgICAgICAuc2l6ZSA9IHNpemVvZihtYXApLA0KPj4gKyAgICAgICAgLmZs
YWdzID0gSU9NTVVfSU9BU19NQVBfUkVBREFCTEUgfA0KPj4gKyAgICAgICAgICAgICAgICAgSU9N
TVVfSU9BU19NQVBfRklYRURfSU9WQSwNCj4+ICsgICAgICAgIC5pb2FzX2lkID0gaW9hc19pZCwN
Cj4+ICsgICAgICAgIC5fX3Jlc2VydmVkID0gMCwNCj4+ICsgICAgICAgIC51c2VyX3ZhID0gKHVp
bnRwdHJfdCl2YWRkciwNCj4+ICsgICAgICAgIC5pb3ZhID0gaW92YSwNCj4+ICsgICAgICAgIC5s
ZW5ndGggPSBzaXplLA0KPj4gKyAgICB9Ow0KPj4gKw0KPj4gKyAgICBpZiAoIXJlYWRvbmx5KSB7
DQo+PiArICAgICAgICBtYXAuZmxhZ3MgfD0gSU9NTVVfSU9BU19NQVBfV1JJVEVBQkxFOw0KPj4g
KyAgICB9DQo+PiArDQo+PiArICAgIHJldCA9IGlvY3RsKGZkLCBJT01NVV9JT0FTX01BUCwgJm1h
cCk7DQo+PiArICAgIHRyYWNlX2lvbW11ZmRfYmFja2VuZF9tYXBfZG1hKGZkLCBpb2FzX2lkLCBp
b3ZhLCBzaXplLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2YWRkciwg
cmVhZG9ubHksIHJldCk7DQo+PiArICAgIGlmIChyZXQpIHsNCj4+ICsgICAgICAgIHJldCA9IC1l
cnJubzsNCj4+ICsgICAgICAgIGVycm9yX3JlcG9ydCgiSU9NTVVfSU9BU19NQVAgZmFpbGVkOiAl
bSIpOw0KPj4gKyAgICB9DQo+PiArICAgIHJldHVybiByZXQ7DQo+PiArfQ0KPg0KPldoZW4gdXNp
bmcgYSBVRUZJIGd1ZXN0LCBRRU1VIHJlcG9ydHMgZXJyb3JzIHdoZW4gbWFwcGluZyByZWdpb25z
DQo+aW4gdGhlIHRvcCBQQ0kgc3BhY2UgOg0KPg0KPiAgIGlvbW11ZmRfYmFja2VuZF9tYXBfZG1h
ICBpb21tdWZkPTEwIGlvYXM9MiBpb3ZhPTB4MzgwMDAwMDAxMDAwDQo+c2l6ZT0weDMwMDAgYWRk
cj0weDdmY2UyYzI4YjAwMCByZWFkb25seT0wICgtMSkNCj4gICBxZW11LXN5c3RlbS14ODZfNjQ6
IElPTU1VX0lPQVNfTUFQIGZhaWxlZDogSW52YWxpZCBhcmd1bWVudA0KPiAgIHFlbXUtc3lzdGVt
LXg4Nl82NDogdmZpb19jb250YWluZXJfZG1hX21hcCgweDU1YTIxYjAzYTE1MCwNCj4weDM4MDAw
MDAwMTAwMCwgMHgzMDAwLCAweDdmY2UyYzI4YjAwMCkgPSAtMjIgKEludmFsaWQgYXJndW1lbnQp
DQo+DQo+ICAgaW9tbXVmZF9iYWNrZW5kX21hcF9kbWEgIGlvbW11ZmQ9MTAgaW9hcz0yIGlvdmE9
MHgzODAwMDAwMDQwMDANCj5zaXplPTB4NDAwMCBhZGRyPTB4N2ZjZTJjOTgwMDAwIHJlYWRvbmx5
PTAgKC0xKQ0KPiAgIHFlbXUtc3lzdGVtLXg4Nl82NDogSU9NTVVfSU9BU19NQVAgZmFpbGVkOiBJ
bnZhbGlkIGFyZ3VtZW50DQo+ICAgcWVtdS1zeXN0ZW0teDg2XzY0OiB2ZmlvX2NvbnRhaW5lcl9k
bWFfbWFwKDB4NTVhMjFiMDNhMTUwLA0KPjB4MzgwMDAwMDA0MDAwLCAweDQwMDAsIDB4N2ZjZTJj
OTgwMDAwKSA9IC0yMiAoSW52YWxpZCBhcmd1bWVudCkNCj4NCj5UaGlzIGlzIGJlY2F1c2UgSU9N
TVVGRCByZXNlcnZlZCBJT1ZBcyBhcmVhcyBhcmUgOg0KPg0KPiAgWyBmZWUwMDAwMCAtIGZlZWZm
ZmZmIF0NCj4gIFsgODAwMDAwMDAwMCAtIGZmZmZmZmZmZmZmZmZmZmYgXSAoMzkgYml0cyBhZGRy
ZXNzIHNwYWNlKQ0KPg0KPndoaWNoIHdlcmUgYWxsb2NhdGVkIHdoZW4gdGhlIGRldmljZSB3YXMg
aW5pdGlhbGx5IGF0dGFjaGVkLg0KPlRoZSB0b3BvbG9neSBpcyBiYXNpYy4gU29tZXRoaW5nIGlz
IHdyb25nLg0KCQ0KVGhhbmtzIGZvciB5b3VyIHJlcG9ydC4gVGhpcyBsb29rcyBhIGhhcmR3YXJl
IGxpbWl0IG9mDQpob3N0IElPTU1VIGFkZHJlc3Mgd2lkdGgoMzkpIDwgZ3Vlc3QgcGh5c2ljYWwg
YWRkcmVzcyB3aWR0aC4NCg0KQSBzaW1pbGFyIGlzc3VlIHdpdGggYSBmaXggc3VibWl0dGVkIGJl
bG93LCBjY2luZyByZWxhdGVkIHBlb3BsZS4NCmh0dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZl
L2h0bWwvcWVtdS1kZXZlbC8yMDIzLTExL21zZzAyOTM3Lmh0bWwNCkl0IGxvb2tzIHRoZSBmaXgg
d2lsbCBub3Qgd29yayBmb3IgaG90cGx1Zy4NCg0KT3IgYmVsb3cgcWVtdSBjbWRsaW5lIG1heSBo
ZWxwOg0KIi1jcHUgaG9zdCxob3N0LXBoeXMtYml0cy1saW1pdD0zOSINCg0KVGhhbmtzDQpaaGVu
emhvbmcNCg0K

