Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A76E7DC46D
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 03:29:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxeV6-0001iQ-Lv; Mon, 30 Oct 2023 22:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxeV2-0001hu-8z
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 22:29:00 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxeV0-00051g-NA
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 22:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698719339; x=1730255339;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cWyrpoBoB4rh+mtd38oEvs89zxRqGw92EsMNPVnjWXA=;
 b=VVMPBYaSeI45BW3Sm8fHfo+jYuRa6cUd7KcYpTkfoRHSHgIWWcAuiS8I
 gS2rNzRKovNVrBM4fzyKQ9loQuNwpPsV7gg1J7SNPNQDr+d+GEjfH2TiJ
 kivs3A/wf887cCcHTKyfQoYp3i0suZGyUsVE30GMWOtwQ2J6ZhSMgmfVO
 bkGeU77zh+Kyu0b+Rcjynzh5WqxcJikIhsM/yEp9yTN6O4yqeO4e6/t+4
 mbWl5hMJGmUqjqstCzg5qH0jMw6XVkMEJWB2GGhlbd5LoocVYMwBoaTBZ
 3std6IApccyBO0wm2Otpunewu6BASymztlYwwrdFsTZLl9pGpV82yM+T1 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="9727093"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="9727093"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2023 19:27:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="760475449"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; d="scan'208";a="760475449"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 Oct 2023 19:27:44 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 19:27:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 19:27:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 19:27:43 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 19:27:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbaGkr8uWh+aI7y13Sknvo5qMwxpTtueWix8nAbAweN9VXHCFpYM7h/WJuQJ7nkzQymV706/mTHeissCYuMrRxjg2mkafe117GiMK565z4CV14Xyitncv7HySaicWpFD7vijcSfbULxDhvjq4zuzJj4Hy62zGRRn5XwE5taVA8xYbvuqDBqrS/mhQXpWna3sFtgagYkXB9koNORRb/nxnNsfpVRt/y6m43P7fdFgEYRCadsG7HH1lCjBFnpZ/HyQVwOadHU9iLRXTGePsRL/mOVXRNsMan8FShzTW9MdoFFsEAVqgw/7Q06IsR2UIIimGgqGWLekT/eFJOyAvR3vBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWyrpoBoB4rh+mtd38oEvs89zxRqGw92EsMNPVnjWXA=;
 b=hquk7wcnsV8fHaH0tu4ZkKX+IS9xHa2F9w+13twnyRHDAoIdJ8LXFn1t8kH9kK+EVx3CUgp32xEGoNArv/oMJ5K1zZdqsObpCjUH0ZwLAfVEj15+ImxK2nQLKibgmnA6dvYZ6xQAeQ43zRg6A8EXQ+8btLd0g0DOCnUD8FRMVv2BfA8vQiqCbekiSfBxo/Nz9hg/ysZcBZrr6bTkf8Zts44zcVmZwlA84X8MKEd6YTok8B0XYHvNZCSgIRchc2BVoFL+ig/PPkrtTHFnFZ5TcPqwCvVS88zrqXwX1auhvl7sF/+Qa3f+ZLVLXtnKol4nMwi/dOLvJ9uwWsq7E8dMhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH8PR11MB6611.namprd11.prod.outlook.com (2603:10b6:510:1ce::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 31 Oct
 2023 02:27:39 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6933.028; Tue, 31 Oct 2023
 02:27:39 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 31/37] vfio/pci: Adapt vfio pci hot reset support with
 iommufd BE
Thread-Topic: [PATCH v3 31/37] vfio/pci: Adapt vfio pci hot reset support with
 iommufd BE
Thread-Index: AQHaB/nxNvoabNCBIkiRCoU5LZUZ57BiZCyAgADPZIA=
Date: Tue, 31 Oct 2023 02:27:39 +0000
Message-ID: <SJ0PR11MB6744FD2899A28FE238FE8A3692A0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-32-zhenzhong.duan@intel.com>
 <c249da92-ddb4-432c-b4db-66ed1de3f498@redhat.com>
In-Reply-To: <c249da92-ddb4-432c-b4db-66ed1de3f498@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH8PR11MB6611:EE_
x-ms-office365-filtering-correlation-id: d2ff496f-2c2f-44b6-0a4e-08dbd9b8f43a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wKho9eIggTERf0xvx52U4uLoo+z9E0yvXzRZSL6shWUG+3J5Ds1bqbA786deP4Sl1Yx6XY3O4b/xuyo/QWrpOzVfxca/8XWUCDc6rUCtmQ+xJ3H66sfzgYhDXtTXnZApHfICVlrTUsH5t62x4mB0X97rd7Hx1TdKesHh0Tnc0gB4g4qpio7Y50PRTexgMe8eRxiSNZRtlKiLGY3+bMXfkZl2ilw0BvW2TG5MgJ77dCDSPOaMKtiIsl2nEU0lbPLDOT0gU+VmMhj38W7VLBgiedg60E9TFY0MQPVrhs7s4yubQpTdQXrBbaLDfhAgbAdgo5mABxr/lDL1t/1eFBvdy/CeDVLWcXxH8SUM6+Kl99xS5v4ZchE5FXBfVh+hMVdg9PEJPK8GY3I0FPQOQ9M8+UWsp4n7wm+J53YdSuybwUDOSMQDiuhUp65TbnTQ0QZNQ+bdGDB2hwKOOvRimG5y4bYcUMBauqGBYrYYPdL6WRQEvSywYHBs3iu2R9vRPIfwl5UrVLEQvY1zuoTHqGr8irKVL1xAjdBISuG9lA2aNk3NCZSxtvWL/ttZ0qu9xO3vgdDKqa8SoHQDTzlmlvKGqGp3Y9tjAF3Ko5VQRxms04M81kDXMDYOdrFWm+PlYaJ3RZ9xgkBeVaY4lFvSgvUnpg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(122000001)(9686003)(71200400001)(7696005)(6506007)(82960400001)(110136005)(33656002)(26005)(66556008)(316002)(66476007)(54906003)(64756008)(478600001)(66446008)(55016003)(66946007)(83380400001)(107886003)(38100700002)(76116006)(86362001)(8936002)(38070700009)(41300700001)(2906002)(8676002)(4326008)(4744005)(52536014)(5660300002)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2hGa29veDNkUUNKNFR6cVNxUUZrYlNyVjdubzFBV2VCeWthYXU1d0RJa1Ev?=
 =?utf-8?B?d2FIS2ZaYmlXcnNDNjV6L1JiVGViM2hHeVpwcGZvNmdDRk5uTE51d1IwTy9T?=
 =?utf-8?B?STIzdmV0Q1dkQkcrMGVYYWZreGh4c1ZhVG1PL1VCZ1I3elBLbm01UUswcUh0?=
 =?utf-8?B?UHFmTUI3MnRFTjBxdmRjZldRcmdKbHBXMWg5aUZBZlV6SHJqbFl1TXhidjI3?=
 =?utf-8?B?Q2JndEtIWW15bkt0M0tOaTlITjZHWmxKSm5LcXArNFczUGZPcjRQQWg1K0ZX?=
 =?utf-8?B?Sk5UUURSdVVtaDhIZ1Bka2FycHVrNG9kZDBHcnhUYmZxUGFRK2V6L2laOHdP?=
 =?utf-8?B?ZC9kR0FmN2hmaXJod2h6YXZOYzFhd1MrSHRNQWR1c1dQTnpqWXEwckxmQWla?=
 =?utf-8?B?VEpaNzY5YzV3bzk0YVFEaHBTeitlaWVQQlFGUnA0NCt4TG5RMTdZN09EdUw1?=
 =?utf-8?B?R0hCbW1HOW9pMWVEc2NsVlZpTHhLdGNYbTZIcDBrd1psYnhoekhQTUhPUFBS?=
 =?utf-8?B?S2pVQTNNMXkrWkZDRkFCYmxxRXF3cmZ6KzFNeWhCNDV2cU9XVkVOcGFIMWhM?=
 =?utf-8?B?SGcwbEhsNCtQSUVkOFJ5eGhwU2dkY2gzaXo2SmEvYmxlcUpheVd3YkZkdWJr?=
 =?utf-8?B?RnFwTlAxc3pGMXY1VFZtK0w3c2JUVjlUc29EL2w3YXNSbXYxeU5ZVE5SY0xS?=
 =?utf-8?B?WDUvQ3hnNkFiUFZKUG9vb3ZjS3loRlY5UmNieUY5bW5EVEhtdm5XbGFGdVkr?=
 =?utf-8?B?QmpDL2NRbVlXUG5Zb2NNTnliYStLUW5MNzIydXZqRmZCWm1TQzlYYjYyN01y?=
 =?utf-8?B?ZjdxVTNWOUVBUUN0OGxLSGpvU3JhMnRPZ3hjVnVjd285dVFBS2kxSGdsNjEr?=
 =?utf-8?B?aW8zc0pYaEV4RE9TRXZIUlo1Nnd5K2ZwazNaUFRGazdnNE9MTDh6dFdTMFFp?=
 =?utf-8?B?VnVXQlNUSFZXbGptQ0VQME1mWDFGK2hkQTRnSTNSQTczbjlJQmtnbDBqaHZH?=
 =?utf-8?B?eFQ4cnNxTHZQTEE2LzlvV0xSV2pPTzhOcHd6cFc0alFyMnA0UlUzdTlyLzdP?=
 =?utf-8?B?MFkxdFJDd0g4cXdKdUxmaXIzN2Y0WE5RMlZHbGJsaU9mL2s0NUhVam5oSTVX?=
 =?utf-8?B?bDRLV2xzdm5oZ1c3QU9lOE5GTU95M2lZUkZrM1oxcG1uc1ZMU1ppYmhFYmN5?=
 =?utf-8?B?YWduMGxkWjNmcE9kZVBzbzJMOEdDb0RFR2M1SzcwUSt4aXo4RlNFTWdZWUZn?=
 =?utf-8?B?YlpJVkNJUkJyQ3ZNN0NINzFud29rSThKdzYycVRKZmNOSDVmbUE0Zzg4NGN2?=
 =?utf-8?B?Ti82cDlSUUtRdVc1U1dRYXJ2ZGpPdGpDeURrRzJyZVVLUGMxTmZxbzdWT1hi?=
 =?utf-8?B?K1p1Z2tSR1NzcU4wUUwwV1hOVkFBcG5TT2NCYnlIcFdpekUrNzVEMHlXejZO?=
 =?utf-8?B?MnYzT2w1R0UzTlVBV2tBcEVVWnp0SnppSHIraWRWeDlXaE1JQk52ZEM3cnpG?=
 =?utf-8?B?L3o4NWdnUW1hMEhNTzAxcDZTK1l5cFVMSktndDZ0WlZBQTZnTnl2bWo4eDBn?=
 =?utf-8?B?TUg4ZWhuMkZwSVpOcUxVUjk3SENvL3AyL2lyUmhiMVA2RUdadmVraU9tSGp5?=
 =?utf-8?B?R3ZnS2xBUnZ2N0paVlU3N3NaalJjOWlzZnFzREhlRnM4QXRrOHp5QjhIbmpG?=
 =?utf-8?B?UTRhS2pMc3daNkp5dklXdzRIUVdmT0xKejBIOVNXZUcwMDRTSFB6TFNoQ0xD?=
 =?utf-8?B?TEFmaUlzVkhLMXN0NUc4VVU2TlhuaWpidGM5WVhjYnFDWVZQTWNiNFJUUUpy?=
 =?utf-8?B?Skg3SmZ3YzFvU3UySlYxeW9wNFY4TUdGM3YzbVpPRWs2M241Umg1Y3NONGwx?=
 =?utf-8?B?aDI2TXQ2QjdXRDBuaTIwL2dXN25tMi9SRmkzSmtSL3pMcmVMN2RkVUlYUUZB?=
 =?utf-8?B?OE9FTlJMa2ZNVlhydE1BNko1QU9weHozR25RMEQ1Yysya2xCZWVBb0lLWlls?=
 =?utf-8?B?UGRMQ2RLb2c5ODNkcFNKMWltQ2JOQ2VFYVBoRGZ5a0hEZWYyRUdZMDBLWHJt?=
 =?utf-8?B?elNnUHp0ekFRa1h6ZXlCbkh1N0FTS3kxUlZ3by85Uk1aT1Fsc0lILzJlTk9p?=
 =?utf-8?Q?s+lpqWyGj0FhctuwvWHS4GcWO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ff496f-2c2f-44b6-0a4e-08dbd9b8f43a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 02:27:39.7287 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vU4U/25XTytOGuk5o+KZrW0sM3pkl46UE4NiyH6z8pJx2svcQuIBEtmJRe0ZbYV2SO97Vql1va4B5ao98ydhJeWC0kAH2Hqsdp+s2SwFvTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6611
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBNb25kYXksIE9jdG9iZXIgMzAsIDIwMjMgMTA6MDUg
UE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDMxLzM3XSB2ZmlvL3BjaTogQWRhcHQgdmZpbyBw
Y2kgaG90IHJlc2V0IHN1cHBvcnQgd2l0aA0KPmlvbW11ZmQgQkUNCj4NCj5PbiAxMC8yNi8yMyAx
MjozMCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBBcyBwY2kgaG90IHJlc2V0IHBhdGggbmVl
ZCB0byByZWZlcmVuY2UgcGNpIHNwZWNpZmljIGZ1bmN0aW9ucw0KPj4gYW5kIGRhdGEgc3RydWN0
dXJlcywgYWRkaW5nIGNvbnRhaW5lciBsZXZlbCBjYWxsYmFjayBmdW5jdGlvbnMNCj4+IGZvciBs
ZWdhY3kgYW5kIGlvbW11ZmQgQkUgYW5kIHJlZmVyZW5jaW5nIHRob3NlIHBjaSBzcGVjaWZpYw0K
Pj4gZnVuYy9kYXRhIGlzIG5vIGJldHRlciB0aGFuIGltcGxlbWVudGluZyByZXNldCBzdXBwb3J0
IHdpdGgNCj4+IGlvbW11ZmQgQkUgZGlyZWN0bHkgaW4gcGNpLmMNCj4NCj55ZXMgYnV0IGl0IGlu
Y2x1ZGVzIGEgbGFyZ2Ugc2VjdGlvbiBvZiBJT01NVUZEIGNvZGUgaW4gcGNpLmMNCj53aGljaCBp
cyB1Z2x5LiBQbGVhc2UgbWFrZSB0aGlzIGFuIFZGSU9JT01NVU9wcyBoYW5kbGVyIGluc3RlYWQu
DQoNCk9LLCBsZXQgbWUgdHJ5IGl0Lg0KDQpUaGFua3MNClpoZW56aG9uZw0K

