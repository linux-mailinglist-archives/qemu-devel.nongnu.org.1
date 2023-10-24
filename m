Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F302A7D472E
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 08:05:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvAW3-0003aK-66; Tue, 24 Oct 2023 02:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvAW1-0003Zz-2I
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 02:03:45 -0400
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvAVy-0006nv-3T
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 02:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698127422; x=1729663422;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pxu6uLInzIlWzq7Lp3OvdBLWzaLxyKtVM2YQ5Nuk+nA=;
 b=YOYFCfEy+DapuOlB1lA40/w2BDDJtoUsvfnIkjVidnHZlE7xmTIHX3ns
 MoADH0FCZxThhqRN88SPgQv9nImZm1rA9QdtYVvnNFRBylb8dOf/3Bgy7
 7NWHPdHrwyWmJGwNMNfd8oKC5TUfOGvpAzTzrQTga8T2HT+e5m3vB2JQn
 obYWJPz4nS3Ox04RANNQUgePEIhJQHWmsXcKcLCP1Y0ga/AkFkx1nf0Eb
 kgmNSOaHaI7ZyLoF2ZycYDM4/y+b/oQsMH7oKuZO/hsxK2EN+nUSNVOMw
 cgTKfZhwPOb3DukxCp+zSk0EZzdukDnIPa1lf2+DkmY8etyIjN9cs+SG9 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="386804582"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; d="scan'208";a="386804582"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2023 23:03:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="751888198"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; d="scan'208";a="751888198"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Oct 2023 23:03:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 23:03:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 23:03:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 23:03:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 23:03:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpIAdAWrFoMYlY/3tJIuOUja6cJjNMY2x3f2mJ9OPysvapUtkSCBjCy8vGk3+wIKTBR4N6QLRsWwKPDrZkzb1iBPvMZKxQr4zMznYmWLMEyxv/ic3JSaNeBE6Mlbzw78ZMbmCVGzYqP+xoznZEC7dQzJ7BWcM0sXeUHgqv5jI9TAF7EBgk0rlhoyQAm0jBnYcPmJKstRrxkt5c+EQjsognlzAmSPs9zI/TruDBMaTA+16A+VAgP9AmRITvNBkH43afuKhi7X5RQx/bX3DD9PaLq3uuM6cxYsggWmn7GfO09AAeHRamO4lYdyQjDgXO/VdJf4oDfklz/7yh8G384JIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxu6uLInzIlWzq7Lp3OvdBLWzaLxyKtVM2YQ5Nuk+nA=;
 b=avt6ICxS8xHmtYrCKz8Yw4qTWIbbWfxnG0qKZaP47pKi9HnBelIM0Tvv9rxkVsTnFnz120cFq6B1809toW6nFL5B/GBSlUAXa88t03esCkEoDp8UXfqf351VBbZbDcx76roeHyqopwyVLf1s9ITj+e7Zv2caXSYvO0WYk4IihYLUVhRACzYbAlIZyJ9S1qRzepEZ4WD2wpZMo4gooyhHvIcfE2sN3zUVD0LU5RwCP4izWxEAJ0Xt3RvpIR6bilns3PtmTf/+rULdpXh8WE+U7g/UqXSDIO8iykaZahn6NLDk6iOyQRLYcunEPaJX/olAksukI0GKkDILkibKA89wXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by MW4PR11MB6837.namprd11.prod.outlook.com (2603:10b6:303:221::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 06:03:30 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::2cfd:ca55:d42a:e46a]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::2cfd:ca55:d42a:e46a%3]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 06:03:30 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, David Gibson
 <david@gibson.dropbear.id.au>
Subject: RE: [PATCH v2 02/27] vfio: Introduce base object for VFIOContainer
 and targetted interface
Thread-Topic: [PATCH v2 02/27] vfio: Introduce base object for VFIOContainer
 and targetted interface
Thread-Index: AQHaAA1niboIxiaoHk+mLfxtQdCD+rBOI2WAgACzxLCAAFwsgIABLpGggACqjoCAAP5hIIAAUToAgAUvEgCAAO2fYA==
Date: Tue, 24 Oct 2023 06:03:29 +0000
Message-ID: <PH7PR11MB6722A19603BF7CB244BBB27A92DFA@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
 <20231016083223.1519410-3-zhenzhong.duan@intel.com>
 <f8089865-20cf-4f11-981a-e593a103a387@redhat.com>
 <PH7PR11MB6722FF23DC574EB09300075292D5A@PH7PR11MB6722.namprd11.prod.outlook.com>
 <c5c0c0ff-3eb1-4b46-b39c-e4e7fa250618@redhat.com>
 <PH7PR11MB67226A6A32A4655138CE1C8A92D4A@PH7PR11MB6722.namprd11.prod.outlook.com>
 <cf232093-a59c-49ef-9271-bb691860215b@redhat.com>
 <PH7PR11MB6722D6969CD287A86CFC469792DBA@PH7PR11MB6722.namprd11.prod.outlook.com>
 <3573353d-5153-2678-e121-33cf20798aa6@redhat.com>
 <759053f1-995b-4238-b0be-bace84a1249c@redhat.com>
In-Reply-To: <759053f1-995b-4238-b0be-bace84a1249c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|MW4PR11MB6837:EE_
x-ms-office365-filtering-correlation-id: a19a3117-7050-4921-8c30-08dbd456f220
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bTGhrRiS2JV9OPadCEaVk2hSSjtgAiyjhJT+A7/4ZXvk8JwG2MtqEXAYyFZAN1MkfJbssNhMo1w62hK9cBZQWdfNNZMOY+xi4g2nGO1axOpPB5hMbv4xDzieYo+Upjxw6GZA4292+RglhY2/FzCsrqY4lkSeN7Puy9HT+4F4YAJyO10rj83dtomX5zD2sypmMe7yVD6ilcwwBQ9o0pRy1OIoeRVLYOgEywSNn2g7KEKJCbaDW7239cDMpUnP/PxHcEw8sWDIK1dh5snrs7QLlZaLXq+maJwtNcbI8472+Ew8K3/3OjYlZeQuVNGb9U3FGigHZHLwRFsIWIOcIPeUDlu5U9kvJw0sGDDzEPh5+n//PXlb+EXsZjNtL040/hGJnee4gWfki5Zuxm73aUT7RyVi4c8/7Lm8d/hjKC8yDLLlQ+TGdTa89wh79Agx2AaAmymOEPNidVCwuE6GImRmmE7NdweLoxdOcT33DuKJ6PjZJTZNTbGxdvPZffST4QSAdW6Ixh24L7rqE7YjT/k0mU0JRlX5NQYYH/L96esZbwiQMpBxZWn8lCfN1sH/Sb4fwYf+540OUzcezbyZNwOpAeQxwQZ8eoAse7l/1vNKsqLGOLT5zzkv+lDoFU7DEaKYf80/jO3Pww7pKam4H8cc+Q9QNDQrcIyyoXubc8webaM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(366004)(396003)(39860400002)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(38070700009)(26005)(9686003)(53546011)(55016003)(478600001)(86362001)(966005)(82960400001)(38100700002)(33656002)(122000001)(2906002)(66574015)(83380400001)(7416002)(71200400001)(7696005)(6506007)(8676002)(66556008)(54906003)(8936002)(316002)(4326008)(52536014)(66446008)(41300700001)(66476007)(76116006)(110136005)(66946007)(64756008)(5660300002)(2004002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlFEelFxU0grenIvVk1YNldrN283eko4WUZFaHZETithTHlRMUFBZ1MrMmFm?=
 =?utf-8?B?aG9rRUVJUnIvL3AxZ0dva0g0Y0xDWTVaVlMzVTdadzNwZnBLYlBWTGsyWHJh?=
 =?utf-8?B?TXI5cHVOWVN0bUhDdkdXR3Y4QitLemF2TmhVQUlSTUY5NlFPTXVaVGFrWUEz?=
 =?utf-8?B?NTlRR0xTZWpwdkV5UUFFRkJTYUIvajB2N285VE9lOW5KUWVMc2tPS3N2Nkox?=
 =?utf-8?B?cEs3WUFreUNtNlhMN2lPTjB4VjJpQ293NXVNQUVMMklyaC9oOGU2cWJwb1F1?=
 =?utf-8?B?b1VDR1RpTGY4WmxXc1N6UXRkYVJTVWloMHJyUzdReEt6RXJ2aWpnOFpadERM?=
 =?utf-8?B?WWUzMUxyU1ZTU1NzMGgrTVhVbXpmOGtjWHY5QjVWTy8rMjRpZWViRDM2ZCtE?=
 =?utf-8?B?ZzdRcVA2R3lmRzVyL09JMzkrQUoxQWZxTi94N1JTcEQvUVVXTXVZQVk5TFRz?=
 =?utf-8?B?d3VnYlBNTkl6S2FkTmRIcm5Fem8yREJqL0dWU2pzaHcvNFlFVG0vMXZqdmJj?=
 =?utf-8?B?Ykp4SUZDNGtIUGE5UnlmbVAyWlJvR21ITThiaFBab3gyMEpaRC9FZHJ2OTlI?=
 =?utf-8?B?aENaWTIwb1ZLSXFPRk01T0s2N213anYyWDNGWkVQc3IyTklZa1pYZUFZdzA5?=
 =?utf-8?B?a2FUck0rL2hVQjgyTUdRdXVDS2M3VjdqNVp6OWUzNldjUVdhYTVuemFlM0Ni?=
 =?utf-8?B?U3NyVFgzQ2k3Uy9IS05OS0lBcnIrODRjM0NmcW0yV3NNcXBGQVJNS0p4OGpn?=
 =?utf-8?B?T3I2RkI5TGtCaG5kUHMyUitSRmcyR3JMeFArUWN5L0U5Ryt1T0wxVHhSNS93?=
 =?utf-8?B?RDhHTDd2MS8rRm5OanVoQno2d3ByRDVQN3Y1SFJHN2RiU21TNU5SUmVuNDhN?=
 =?utf-8?B?YVl0dlBVWUF3aW53Z29CY0pXblkyajdDa1cvemU0OVRELy9VZWptQndqMWJQ?=
 =?utf-8?B?b0lHSjJIbERhaUcwbkRrZTh4MFBnaGsvK1JDNjlCQytxcGRoSnNUNEdVNnoz?=
 =?utf-8?B?N0hjNWMvd1JaTWlCMjdEVVQwakxjS3NGZmt1T3FhTm81YWwyc3RBb0xTalQ4?=
 =?utf-8?B?RHNTdzlJR0svTWd1S3JPYjFHcUVuMEtFTTI2bE5BdG5aWDZ1YkFWK1NOclJi?=
 =?utf-8?B?MlpKQVRkQlJkQ0w1dUt1WjYxcWhYd3NsMHN0aWE3eTZDV2JPQ3crL0V5Mm5r?=
 =?utf-8?B?eVhKQlJPaXhER2htbHFUVmVZeG9lL1FOL2lBc1FLb3NMUEhYWW1JZnlXU0N1?=
 =?utf-8?B?QUJSSkd0c3pLb3lVcXp2M3lFTGlLaU13aGNzYTBmd1BtMEpMeUx6SlpYaFh6?=
 =?utf-8?B?cTJmTFpYTnFlRDV4bnNYZHZhbWxsQjU4YndkUGZSYmM1bUlRUjNaWUNDU1Vt?=
 =?utf-8?B?Qlp0cjNuV1dneUduOTFDK1ozS1VjQ0dHdWNEcURXOVNydS9kMGc0bHhzbFdM?=
 =?utf-8?B?ajYrVUFCcGMxaEFyR0FJZnFTN2diOElEMlJtSGxTS1hWMGNzbWxQTGFJZEN5?=
 =?utf-8?B?V0wreGlJR1YvcW1MWWVXNHdhMXA0VFJFMkFJKzIrOTNTS1BWVUhKL3N2YWlt?=
 =?utf-8?B?VC9qd2p4TU5KUGxCL3J0L0NaT2hyaWVYRjZSR2IxcEhvQ0ZrR21CWWl1ei9i?=
 =?utf-8?B?NjV1WXBuMTArSEYwU3c0TXQxS3NBUFZPdGl0ZHFDcnJQbVJVQzR6NE5Dcnhn?=
 =?utf-8?B?VEExeFNsL244aVNDSXo0UE1oZ0M4ditSKzFORkljOWYwZEhBSU1oYWFVVnpB?=
 =?utf-8?B?T3dUNCtHNng4RXVtTWI5Qkxjb1FXaHBSbHZoT1F6UVU1YmJMNjV1ZXAvcUZn?=
 =?utf-8?B?U045d2VCMjg1STRjNHgzNWVKeHVuSkV2dkxCTFdDRzY5b3pLTklrZmRzNHRL?=
 =?utf-8?B?MUJZUXczMzVNMHZoZTZEMXJwZ0VFTlorV1Vwa0RGZFFwbmN6UFRqNlFwbzhh?=
 =?utf-8?B?SjVBYWFMaDVnTytvMXNxakhOcTRyc2pkZXRYRlFXZjFWRy85aUt0YnloTEx5?=
 =?utf-8?B?WFF4czdvTFRtWmlhbWV5TU5PYWlDMjAzSHV4NE1YaE1MdnhhZmE1UTFqN29q?=
 =?utf-8?B?ZURFYlRWcHVFMkpTZDZxdEtoWmRjQ0g0WjJURG1uRDgxZGwxOVJSdndNdm5s?=
 =?utf-8?Q?Cyx3iWH8R6ISYbdqAYKL5MhkK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a19a3117-7050-4921-8c30-08dbd456f220
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 06:03:29.7099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jf9wh+ei5ERwpMvkJt49D6PSgVvGj93TlE+p7xA0GPEfafKF8MChR9wzcnU3F8nbj/voen5HSnYr6NpaGEQg6VvamfIn7iM6TcGYyzQ22Mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6837
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.115;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBNb25kYXksIE9jdG9iZXIgMjMsIDIwMjMgMTE6Mjkg
UE0NCj48ZGF2aWRAZ2lic29uLmRyb3BiZWFyLmlkLmF1Pg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0gg
djIgMDIvMjddIHZmaW86IEludHJvZHVjZSBiYXNlIG9iamVjdCBmb3IgVkZJT0NvbnRhaW5lciBh
bmQNCj50YXJnZXR0ZWQgaW50ZXJmYWNlDQo+DQo+T24gMTAvMjAvMjMgMTA6MTksIEVyaWMgQXVn
ZXIgd3JvdGU6DQo+PiBIaSwNCj4+IE9uIDEwLzIwLzIzIDA3OjQ4LCBEdWFuLCBaaGVuemhvbmcg
d3JvdGU6DQo+Pj4gSGkgQ8OpZHJpYywNCj4+Pg0KPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPj4+PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+Pj4+
IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDE5LCAyMDIzIDg6MTggUE0NCj4+Pj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MiAwMi8yN10gdmZpbzogSW50cm9kdWNlIGJhc2Ugb2JqZWN0IGZvciBWRklP
Q29udGFpbmVyDQo+YW5kDQo+Pj4+IHRhcmdldHRlZCBpbnRlcmZhY2UNCj4+Pj4NCj4+Pj4gT24g
MTAvMTkvMjMgMDQ6MjksIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+Pj4+PiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPj4+Pj4+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVk
aGF0LmNvbT4NCj4+Pj4+PiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMTgsIDIwMjMgNDowNCBQ
TQ0KPj4+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDIvMjddIHZmaW86IEludHJvZHVjZSBi
YXNlIG9iamVjdCBmb3INCj5WRklPQ29udGFpbmVyDQo+Pj4+IGFuZA0KPj4+Pj4+IHRhcmdldHRl
ZCBpbnRlcmZhY2UNCj4+Pj4+Pg0KPj4+Pj4+IE9uIDEwLzE4LzIzIDA0OjQxLCBEdWFuLCBaaGVu
emhvbmcgd3JvdGU6DQo+Pj4+Pj4+IEhpIEPDqWRyaWMsDQo+Pj4+Pj4+DQo+Pj4+Pj4+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+Pj4+Pj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIg
PGNsZ0ByZWRoYXQuY29tPg0KPj4+Pj4+Pj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAxNywgMjAy
MyAxMTo1MSBQTQ0KPj4+Pj4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwMi8yN10gdmZpbzog
SW50cm9kdWNlIGJhc2Ugb2JqZWN0IGZvcg0KPlZGSU9Db250YWluZXINCj4+Pj4+PiBhbmQNCj4+
Pj4+Pj4+IHRhcmdldHRlZCBpbnRlcmZhY2UNCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBPbiAxMC8xNi8y
MyAxMDozMSwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+Pj4+Pj4+Pj4gRnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gSW50cm9kdWNl
IGEgZHVtYiBWRklPQ29udGFpbmVyIGJhc2Ugb2JqZWN0IGFuZCBpdHMgdGFyZ2V0dGVkDQo+aW50
ZXJmYWNlLg0KPj4+Pj4+Pj4+IFRoaXMgaXMgd2lsbGluZ2x5IG5vdCBhIFFPTSBvYmplY3QgYmVj
YXVzZSB3ZSBkb24ndCB3YW50IGl0IHRvIGJlDQo+Pj4+Pj4+Pj4gdmlzaWJsZSBmcm9tIHRoZSB1
c2VyIGludGVyZmFjZS4gIFRoZSBWRklPQ29udGFpbmVyIHdpbGwgYmUgc21vb3RobHkNCj4+Pj4+
Pj4+PiBwb3B1bGF0ZWQgaW4gc3Vic2VxdWVudCBwYXRjaGVzIGFzIHdlbGwgYXMgaW50ZXJmYWNl
cy4NCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IE5vIGZ1Y250aW9uYWwgY2hhbmdlIGludGVuZGVkLg0K
Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdl
ckByZWRoYXQuY29tPg0KPj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVA
aW50ZWwuY29tPg0KPj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFlpIFN1biA8eWkueS5zdW5AbGlu
dXguaW50ZWwuY29tPg0KPj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4+Pj4+Pj4gLS0tDQo+Pj4+Pj4+Pj4gICAgICBp
bmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaCAgICAgICAgIHwgIDggKy0tDQo+Pj4+Pj4+Pj4g
ICAgICBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oIHwgODINCj4+Pj4+PiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+Pj4+Pj4+PiAgICAgIDIgZmlsZXMgY2hhbmdl
ZCwgODQgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4+Pj4+Pj4+PiAgICAgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oDQo+Pj4+
Pj4+Pj4NCj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9u
LmggYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby0NCj4+Pj4+PiBjb21tb24uaA0KPj4+Pj4+Pj4+IGlu
ZGV4IDM0NjQ4ZTUxOGUuLjk2NTFjZjkyMWMgMTAwNjQ0DQo+Pj4+Pj4+Pj4gLS0tIGEvaW5jbHVk
ZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj4+Pj4+Pj4+PiArKysgYi9pbmNsdWRlL2h3L3ZmaW8v
dmZpby1jb21tb24uaA0KPj4+Pj4+Pj4+IEBAIC0zMCw2ICszMCw3IEBADQo+Pj4+Pj4+Pj4gICAg
ICAjaW5jbHVkZSA8bGludXgvdmZpby5oPg0KPj4+Pj4+Pj4+ICAgICAgI2VuZGlmDQo+Pj4+Pj4+
Pj4gICAgICAjaW5jbHVkZSAic3lzZW11L3N5c2VtdS5oIg0KPj4+Pj4+Pj4+ICsjaW5jbHVkZSAi
aHcvdmZpby92ZmlvLWNvbnRhaW5lci1iYXNlLmgiDQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiAgICAg
ICNkZWZpbmUgVkZJT19NU0dfUFJFRklYICJ2ZmlvICVzOiAiDQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+
PiBAQCAtODEsNiArODIsNyBAQCB0eXBlZGVmIHN0cnVjdCBWRklPQWRkcmVzc1NwYWNlIHsNCj4+
Pj4+Pj4+PiAgICAgIHN0cnVjdCBWRklPR3JvdXA7DQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiAgICAg
IHR5cGVkZWYgc3RydWN0IFZGSU9MZWdhY3lDb250YWluZXIgew0KPj4+Pj4+Pj4+ICsgICAgVkZJ
T0NvbnRhaW5lciBiY29udGFpbmVyOw0KPj4+Pj4+Pj4gVGhhdCdzIHRoZSBwYXJlbnQgY2xhc3Ms
IHJpZ2h0ID8NCj4+Pj4+Pj4gUmlnaHQuDQo+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gICAgICAgICAgVkZJ
T0FkZHJlc3NTcGFjZSAqc3BhY2U7DQo+Pj4+Pj4+Pj4gICAgICAgICAgaW50IGZkOyAvKiAvZGV2
L3ZmaW8vdmZpbywgZW1wb3dlcmVkIGJ5IHRoZSBhdHRhY2hlZCBncm91cHMgKi8NCj4+Pj4+Pj4+
PiAgICAgICAgICBNZW1vcnlMaXN0ZW5lciBsaXN0ZW5lcjsNCj4+Pj4+Pj4+PiBAQCAtMjAwLDEy
ICsyMDIsNiBAQCB0eXBlZGVmIHN0cnVjdCBWRklPRGlzcGxheSB7DQo+Pj4+Pj4+Pj4gICAgICAg
ICAgfSBkbWFidWY7DQo+Pj4+Pj4+Pj4gICAgICB9IFZGSU9EaXNwbGF5Ow0KPj4+Pj4+Pj4+DQo+
Pj4+Pj4+Pj4gLXR5cGVkZWYgc3RydWN0IHsNCj4+Pj4+Pj4+PiAtICAgIHVuc2lnbmVkIGxvbmcg
KmJpdG1hcDsNCj4+Pj4+Pj4+PiAtICAgIGh3YWRkciBzaXplOw0KPj4+Pj4+Pj4+IC0gICAgaHdh
ZGRyIHBhZ2VzOw0KPj4+Pj4+Pj4+IC19IFZGSU9CaXRtYXA7DQo+Pj4+Pj4+Pj4gLQ0KPj4+Pj4+
Pj4+ICAgICAgdm9pZCB2ZmlvX2hvc3Rfd2luX2FkZChWRklPTGVnYWN5Q29udGFpbmVyICpjb250
YWluZXIsDQo+Pj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGh3YWRkciBtaW5f
aW92YSwgaHdhZGRyIG1heF9pb3ZhLA0KPj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1aW50NjRfdCBpb3ZhX3Bnc2l6ZXMpOw0KPj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oDQo+Yi9pbmNsdWRlL2h3L3ZmaW8vdmZp
by0NCj4+Pj4+Pj4+IGNvbnRhaW5lci1iYXNlLmgNCj4+Pj4+Pj4+PiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPj4+Pj4+Pj4+IGluZGV4IDAwMDAwMDAwMDAuLmFmYzg1NDNkMjINCj4+Pj4+Pj4+PiAt
LS0gL2Rldi9udWxsDQo+Pj4+Pj4+Pj4gKysrIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFp
bmVyLWJhc2UuaA0KPj4+Pj4+Pj4+IEBAIC0wLDAgKzEsODIgQEANCj4+Pj4+Pj4+PiArLyoNCj4+
Pj4+Pj4+PiArICogVkZJTyBCQVNFIENPTlRBSU5FUg0KPj4+Pj4+Pj4+ICsgKg0KPj4+Pj4+Pj4+
ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjMgSW50ZWwgQ29ycG9yYXRpb24uDQo+Pj4+Pj4+Pj4gKyAq
IENvcHlyaWdodCBSZWQgSGF0LCBJbmMuIDIwMjMNCj4+Pj4+Pj4+PiArICoNCj4+Pj4+Pj4+PiAr
ICogQXV0aG9yczogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pj4+Pj4+Pj4gKyAqICAg
ICAgICAgIEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+Pj4+Pj4+PiArICoN
Cj4+Pj4+Pj4+PiArICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVk
aXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkNCj4+Pj4+Pj4+PiArICogaXQgdW5kZXIgdGhlIHRl
cm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQNCj5ieQ0K
Pj4+Pj4+Pj4+ICsgKiB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lv
biAyIG9mIHRoZSBMaWNlbnNlLCBvcg0KPj4+Pj4+Pj4+ICsgKiAoYXQgeW91ciBvcHRpb24pIGFu
eSBsYXRlciB2ZXJzaW9uLg0KPj4+Pj4+Pj4+ICsNCj4+Pj4+Pj4+PiArICogVGhpcyBwcm9ncmFt
IGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsDQo+Pj4+
Pj4+Pj4gKyAqIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBs
aWVkIHdhcnJhbnR5DQo+b2YNCj4+Pj4+Pj4+PiArICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5F
U1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlDQo+dGhlDQo+Pj4+Pj4+Pj4gKyAqIEdO
VSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuDQo+Pj4+Pj4+Pj4gKw0K
Pj4+Pj4+Pj4+ICsgKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5zZQ0KPj4+PiBhbG9uZw0KPj4+Pj4+Pj4+ICsgKiB3aXRoIHRo
aXMgcHJvZ3JhbTsgaWYgbm90LCBzZWUgPGh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+Lg0K
Pj4+Pj4+Pj4+ICsgKi8NCj4+Pj4+Pj4+PiArDQo+Pj4+Pj4+Pj4gKyNpZm5kZWYgSFdfVkZJT19W
RklPX0JBU0VfQ09OVEFJTkVSX0gNCj4+Pj4+Pj4+PiArI2RlZmluZSBIV19WRklPX1ZGSU9fQkFT
RV9DT05UQUlORVJfSA0KPj4+Pj4+Pj4+ICsNCj4+Pj4+Pj4+PiArI2luY2x1ZGUgImV4ZWMvbWVt
b3J5LmgiDQo+Pj4+Pj4+Pj4gKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQ0KPj4+Pj4+Pj4+ICsj
aW5jbHVkZSAiZXhlYy9od2FkZHIuaCINCj4+Pj4+Pj4+PiArI2VuZGlmDQo+Pj4+Pj4+Pj4gKw0K
Pj4+Pj4+Pj4+ICt0eXBlZGVmIHN0cnVjdCBWRklPQ29udGFpbmVyIFZGSU9Db250YWluZXI7DQo+
Pj4+Pj4+Pj4gK3R5cGVkZWYgc3RydWN0IFZGSU9EZXZpY2UgVkZJT0RldmljZTsNCj4+Pj4+Pj4+
PiArdHlwZWRlZiBzdHJ1Y3QgVkZJT0lPTU1VQmFja2VuZE9wc0NsYXNzDQo+Pj4+IFZGSU9JT01N
VUJhY2tlbmRPcHNDbGFzczsNCj4+Pj4+Pj4+PiArDQo+Pj4+Pj4+Pj4gK3R5cGVkZWYgc3RydWN0
IHsNCj4+Pj4+Pj4+PiArICAgIHVuc2lnbmVkIGxvbmcgKmJpdG1hcDsNCj4+Pj4+Pj4+PiArICAg
IGh3YWRkciBzaXplOw0KPj4+Pj4+Pj4+ICsgICAgaHdhZGRyIHBhZ2VzOw0KPj4+Pj4+Pj4+ICt9
IFZGSU9CaXRtYXA7DQo+Pj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4+ICsvKg0KPj4+Pj4+Pj4+ICsgKiBU
aGlzIGlzIHRoZSBiYXNlIG9iamVjdCBmb3IgdmZpbyBjb250YWluZXIgYmFja2VuZHMNCj4+Pj4+
Pj4+PiArICovDQo+Pj4+Pj4+Pj4gK3N0cnVjdCBWRklPQ29udGFpbmVyIHsNCj4+Pj4+Pj4+PiAr
ICAgIFZGSU9JT01NVUJhY2tlbmRPcHNDbGFzcyAqb3BzOw0KPj4+Pj4+Pj4gVGhpcyBpcyB1bmV4
cGVjdGVkLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IEkgdGhvdWdodCB0aGF0IGFuIGFic3RyYWN0IFFP
TSBtb2RlbCBmb3IgVkZJT0NvbnRhaW5lciB3YXMgZ29pbmcNCj4+Pj4+Pj4+IHRvIGJlIGludHJv
ZHVjZWQgd2l0aCBhIFZGSU9Db250YWluZXJDbGFzcyB3aXRoIHRoZSBvcHMgYmVsb3cNCj4+Pj4+
Pj4+IChWRklPSU9NTVVCYWNrZW5kT3BzQ2xhc3MpLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IFRoZW4s
IHdlIHdvdWxkIGNhbGwgOg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+ICAgICAgIFZGSU9Db250YWluZXJD
bGFzcyAqdmNjID0gVkZJT19DT05UQUlORVJfR0VUX0NMQVNTKGNvbnRhaW5lcik7DQo+Pj4+Pj4+
Pg0KPj4+Pj4+Pj4gdG8gZ2V0IHRoZSBzcGVjaWZpYyBpbXBsZW1lbnRhdGlvbiBmb3IgdGhlIGN1
cnJlbnQgY29udGFpbmVyLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IEkgZG9uJ3QgdW5kZXJzdGFuZCB0
aGUgVkZJT0lPTU1VQmFja2VuZE9wc0NsYXNzIHBvaW50ZXIgYW5kDQo+Pj4+Pj4+PiBUWVBFX1ZG
SU9fSU9NTVVfQkFDS0VORF9PUFMuIEl0IHNlZW1zIHJlZHVuZGFudC4NCj4+Pj4+Pj4gVGhlIG9y
aWdpbmFsIGltcGxlbWVudGF0aW9uIHdhcyBhYnN0cmFjdCBRT00gbW9kZWwuIEJ1dCBpdCB3YXNu
J3QNCj4+Pj4gYWNjZXB0ZWQsDQo+Pj4+Pj4+IHNlZSBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvWW11RnYyczVUUHV3N0slMkZ1QHlla2tvLyBmb3INCj5kZXRhaWxzLg0KPj4+Pj4+IEkgc2Vl
IHRoZSBpZGVhIHdhcyBjaGFsbGVuZ2VkLCBub3QgcmVqZWN0ZWQuIEkgbmVlZCB0byBkaWcgaW4g
ZnVydGhlciBhbmQgdGhpcw0KPj4+Pj4+IHdpbGwgdGFrZSB0aW1lLg0KPj4+Pj4gVGhhbmtzIGZv
ciBoZWxwIGxvb2tpbmcgaW50byBpdC4NCj4+Pj4+DQo+Pj4+PiArRGF2aWQsIEhpIERhdmlkLCBJ
J20gZGlnZ2luZyBpbnRvIHlvdXIgY29uY2VybiBvZiB1c2luZyBRT00gdG8gYWJzdHJhY3QNCj5i
YXNlDQo+Pj4+PiBjb250YWluZXIgYW5kIGxlZ2FjeSBWRklPQ29udGFpbmVyOg0KPj4+Pj4gIlRo
ZSBRT00gY2xhc3Mgb2YgdGhpbmdzIGlzIHZpc2libGUgdG8gdGhlIHVzZXIvY29uZmlnIGxheWVy
IHZpYSBRTVAgKGFuZA0KPj4+PiBzb21ldGltZXMgY29tbWFuZCBsaW5lKS4NCj4+Pj4+IEl0IGRv
ZXNuJ3QgbmVjZXNzYXJpbHkgY29ycmVzcG9uZCB0byBndWVzdCB2aXNpYmxlIGRpZmZlcmVuY2Vz
LCBidXQgaXQgb2Z0ZW4NCj5kb2VzLiINCj4+Pj4+DQo+Pj4+PiBBSVVJLCB3aGlsZSBpdCdzIHRy
dWUgd2hlbiB0aGUgUU9NIHR5cGUgaW5jbHVkZXMgVFlQRV9VU0VSX0NSRUFUQUJMRQ0KPj4+PiBp
bnRlcmZhY2UsDQo+Pj4+PiBvdGhlcndpc2UsIHVzZXIgY2FuJ3QgY3JlYXRlIGFuIG9iamVjdCBv
ZiB0aGlzIHR5cGUuIE9ubHkgZGlmZmVyZW5jZSBpcyB1c2VyDQo+d2lsbA0KPj4+PiBzZWUNCj4+
Pj4+ICJvYmplY3QgdHlwZSAnJXMnIGlzbid0IHN1cHBvcnRlZCBieSBvYmplY3QtYWRkIiBpbnN0
ZWFkIG9mICJpbnZhbGlkIG9iamVjdA0KPj4+PiB0eXBlOiAlcyIuDQo+Pj4+PiBJcyB5b3VyIGV4
cGVjdGF0aW9uIHRvIG5vdCBwZXJtaXQgdXNlciB0byBjcmVhdGUgdGhpcyBvYmplY3Qgb3Igb25s
eSB3YW50DQo+dXNlcg0KPj4+Pj4gdG8gc2VlICJpbnZhbGlkIG9iamVjdCB0eXBlOiAlcyIuDQo+
Pj4+PiBJZiB5b3UgbWVhbiB0aGUgZmlyc3QsIHRoZW4gSSB0aGluayBRT00gY291bGQgYmUgc3Vp
dGFibGUgaWYgd2UgZG9uJ3QgaW5jbHVkZQ0KPj4+Pj4gVFlQRV9VU0VSX0NSRUFUQUJMRSBpbnRl
cmZhY2U/DQo+Pj4+IEkgd2FzIGltYWdpbmluZyBzb21lIGtpbmQgb2YgUU9NIGhpZXJhcmNoeSB1
bmRlciB0aGUgdmZpbyBkZXZpY2UNCj4+Pj4gd2l0aCB2YXJpb3VzIFFPTSBpbnRlcmZhY2VzIChz
aW1pbGFyIHRvIHRoZSBvcHMpIHRvIGRlZmluZSB0aGUNCj4+Pj4gcG9zc2libGUgSU9NTVUgYmFj
a2VuZHMuIFRoZSBmYWN0IHRoYXQgd2UgdXNlIHRoZSBJT01NVUZEIG9iamVjdA0KPj4+ID5mcm9t
IHRoZSBjb21tYW5kIGxpbmUgbWFkZSBpdCBtb3JlIHBsYXVzaWJsZS4gSSBtaWdodCBiZSBtaXN0
YWtpbmcuDQo+Pj4NCj4+PiBHb3QgeW91ciBwb2ludC4NCj4+PiBUaGlzIHdheSB3ZSBpbnRyb2R1
Y2UgYSBuZXcgUU9NIHR5cGUgInZmaW8tcGNpLWlvbW11ZmQiIGZvciBpb21tdWZkDQo+c3VwcG9y
dCwNCj4+PiBhbmQgdmZpby1wY2kga2VlcCBzYW1lIGZvciBsZWdhY3kgYmFja2VuZCwgZS5nOg0K
Pj4+DQo+Pj4gI3FlbXUgIC1vYmplY3QgaW9tbXVmZCxpZD1pb21tdWZkMCBcDQo+Pj4gICAgICAg
ICAgICAgICAgLWRldmljZSB2ZmlvLXBjaS1pb21tdWZkLGlvbW11ZmQ9aW9tbXVmZDAsaWQ9dmZp
bzAuLi4gXA0KPj4+ICAgICAgICAgICAgICAgLWRldmljZSB2ZmlvLXBjaSxpZD12ZmlvMS4uLg0K
Pj4geW91IHdvdWxkIG5lZWQgdG8gZG8gdGhhdCBmb3IgYWxsIHR5cGVzIGZvciB2ZmlvIGRldmlj
ZXMsIGFwLCBjY3csDQo+PiBwbGF0Zm9ybS4gTG9va3MgaGVhdnkgdG8gbWUuIFdoeSB3b3VsZCB3
ZSBuZWVkIHRvIHVzZSBhIGRpZmZlcmVudA0KPj4gdmZpby1wY2ktKiBkZXZpY2Ugd2hpbGUgd2Ug
Y291bGQgc3dpdGNoIHRoZSBpb21tdSBiYWNrZW5kIGFjY29yZGluZyB0bw0KPj4gdGhlICJpb21t
dWZkIiBwcm9wIHByZXNlbmNlLiBUaGUgaW5pdGlhbCBkaXNjdXNzaW9uIHdhcyBhYm91dCBRT015
ZnlpbmcNCj4+IHRoZSBjb250YWluZXIgaW5zdGVhZC4NCj4NCj55ZXMuDQo+DQo+SSB0b29rIGEg
Y2xvc2VyIGxvb2sgYXQgdGhlIGZpcnN0IHBhcnQgd2hpY2ggYWRkcyB0aGUgYmFja2VuZCBvcHMs
DQo+aW5jbHVkaW5nIHBhdGNoIDE5IGFkZGluZyB0aGUgaW9tbXVmZCBiYWNrZW5kLCBub3Qgc2F5
aW5nIHRoYXQgSSBoYXZlDQo+aWRlbnRpZmllZCBhbGwgdGhlIGRhcmsgY29ybmVycy4NCj4NCj5B
IFFPTS1saWtlIGRlc2lnbiB3b3VsZCBoYXZlIGludHJvZHVjZWQgYSBWRklPTGVnYWN5Q29udGFp
bmVyLA0KPmluaGVyaXRpbmcgZnJvbSBWRklPQ29udGFpbmVyIChzYW1lIGZvciBWRklPSU9NTVVG
RENvbnRhaW5lcikgd2l0aCBhDQo+VkZJT0NvbnRhaW5lckNsYXNzIHRvIGltcGxlbWVudCB0aGUg
c3BlY2lmaWMgYmFja2VuZCBvcHMuDQo+VkZJT3NwYXByQ29udGFpbmVyIHdvdWxkIGhhdmUgbWFk
ZSBzZW5zZSBhbHNvLg0KPg0KPkJ1dCBRT00gZG9lc24ndCBzZWVtIHdlbGwgYWRhcHRlZCBmb3Ig
dGhlIGN1cnJlbnQgbmVlZHMuIFNvIGxldCdzIHRyeQ0KPmEgc2ltcGxlciBhcHByb2FjaC4gSXQg
c2VlbXMgdGhhdCBWRklPSU9NTVVCYWNrZW5kT3BzQ2xhc3MgaXMNCj51c2VsZXNzLiBJTU8sIGl0
IGNvdWxkIGJlIGEgY2FsbGJhY2tzIHN0cnVjdHVyZSBsaWtlIHdlIGhhdmUgZm9yDQo+bWVtb3J5
IHJlZ2lvbnMgaW5pdGlhbGl6ZWQgd2l0aCB2ZmlvX2NvbnRhaW5lcl9pbml0KCkuIFRoaXMgd291
bGQNCj5yZW1vdmUgc29tZSBub2lzZSBhcm91bmQgdGhlIFFPTSB0eXBlaW5mbyBkZWZpbml0aW9u
cy4NCg0KWWVzLCBnb29kIHN1Z2dlc3Rpb24sIHdpbGwgZG8uDQoNCj4NCj4nc3RydWN0IHZmaW9f
aW9tbXVfb3BzJyByZWFkcy9zb3VuZHMgbGlrZSBhIGdvb2QgbmFtZS4NCj4NCj5DYW4gd2UgdHJ5
IHRoYXQgaW4gYSB2MyA/IEl0IHNob3VsZCBub3QgYmUgc3VjaCBhbiBlYXJ0aHF1YWtlLg0KDQpT
dXJlLg0KDQo+DQo+c3BhcHIgaGFzIHNvbWUgc2luZ3VsYXJpdGllcyB3aGljaCB3b3VsZCBiZSBn
b29kIHRvIGlzb2xhdGUgaW4gYQ0KPnZmaW9faW9tbXVfc3BhcHJfb3BzIHRvIHJlbW92ZSBhbGwg
dGhlIFZGSU9fU1BBUFJfVENFXypfSU9NTVUgY29kZSBpbg0KPmNvbnRhaW5lci5jLiB2ZmlvX2xl
Z2FjeV97YWRkLGRlbH1fc2VjdGlvbl93aW5kb3cgYXJlIFNQQVBSIHNwZWNpZmljLg0KDQpZZXMs
IGxldCBtZSB0cnkgaXQuDQoNClRoYW5rcw0KWmhlbnpob25nDQo+DQo+RllJLCBJIGRpZCBzb21l
IGFkanVzdGVtZW50cyBiYyBvZiB0aGUgcmVjZW50IGludHJvZHVjdGlvbiBvZiBpb3ZhX3Jhbmdl
cw0KPmluIG15IGJyYW5jaCA6DQo+DQo+ICBodHRwczovL2dpdGh1Yi5jb20vbGVnb2F0ZXIvcWVt
dS9jb21taXRzL3ZmaW8tOC4yDQo+DQo+VGhhbmtzLA0KPg0KPkMuDQo+DQoNCg==

