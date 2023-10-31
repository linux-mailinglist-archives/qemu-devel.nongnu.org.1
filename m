Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 571397DC41B
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 03:03:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxe5y-00069O-MW; Mon, 30 Oct 2023 22:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxe5w-000691-A9
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 22:03:04 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxe5r-0000OY-NT
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 22:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698717779; x=1730253779;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/dllWBln9ngohO+XOnHy3vKL59rkyeU1CTq1m/5TftE=;
 b=PD/qBHkJUwms+rkE0/EAWhaZ3JBJO9DbIB/GxuaV9HUBKg0vl/syLcpz
 rifIjGE1BIXGthnUOtmuNkKzXdIdhsxngYiNESjJQntxT4ukLokYEc+AQ
 SOQF0u/Yqh3ZMxom9mGW0U2o0yOb5uXasM5JwqYDTJXe3KbzWiWoajv6B
 HBk+Wi1reTougcNQoXlwg/4GeT3kxxIwQTI3kMLnOJuXhdPa6Bv62Vo0e
 Miysk4w/+wELvkmWTtKwAmXXmWyqtX0bUu0Cl5iJn2KIEwk/L9I9fX0tk
 h88uB1j/KfRVfTIwIJ1ELW1W/lpgPczIQOwsZY2EKcPDASeoUR/zUZsuC g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="452470391"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; d="scan'208";a="452470391"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2023 19:02:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="933960052"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; d="scan'208";a="933960052"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 Oct 2023 19:02:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 19:02:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 19:02:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 19:02:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 19:02:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lagYilUVdQIAlmHyIsdiLkVUFGlpR2lOZwXJng2k2oRONF+nPh4JnA0uAKdYnETqAp5FfdBovsRm/wyf2zvEPbMLw7Q5m+aCO0JZuonrDdSubs7pw+AwQLXrJ6vqHe4DpAPAKB//WuF39Ig2hB6uFZ8k2RNfub8KLLSKc8i6n6QNpBnmqhyr5meYTGeHCfOCRe+zaGwJkgIo3knuNhY0poNTrf6tuhQ4BPOWx7XafR8G2XkpXogIsTjUasbZgqTCNe9I770/0f4etiW+pkbLfrjTVncXjnrZjjeFYRNkvexT9wpOup7BzOin/z05jtuQ7beV+Rl3LKxXIOTSdGctbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dllWBln9ngohO+XOnHy3vKL59rkyeU1CTq1m/5TftE=;
 b=TjRuHkJy6ce9Jgab3ZRG5NL8K/lrNo8hlfNU8mjVr1ndlGxEfKtgyiQ7a12vksPDRMoNNePhanDhEyr9+eEA8Gh1DTlwhDW9V0ljCLWhIlwO/9daGbq6V43fyWJQBzxuUMvzYio8jkgqrlH+w9ThvLO8MpXM2O2ud6sw49XgdRiypo+FazoT5cAWd7UiHcwC4V/RLO0heXm3q6dSlOacHq3aaWFFUs83cB8qFFydv0RN9rDJZ+7YKnbj8BezKaDv6h+cE+jJxJZIcUEt2xZoaA4eYo7sWCr2xQNB/AkNcxApLCm6qTMsD1by5jMpl5t9DQfTSABWDCZcN6ptUSYXhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA2PR11MB4876.namprd11.prod.outlook.com (2603:10b6:806:119::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 02:02:51 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6933.028; Tue, 31 Oct 2023
 02:02:51 +0000
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
Subject: RE: [PATCH v3 27/37] vfio/iommufd: Switch to manual hwpt allocation
Thread-Topic: [PATCH v3 27/37] vfio/iommufd: Switch to manual hwpt allocation
Thread-Index: AQHaB/no1YdDM5op4EKGrs83c0t47LBiYKeAgADLc8A=
Date: Tue, 31 Oct 2023 02:02:51 +0000
Message-ID: <SJ0PR11MB6744F2BA05FBE5998E34F86E92A0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-28-zhenzhong.duan@intel.com>
 <4adcd2be-98fb-45bc-9023-a08b035b8b71@redhat.com>
In-Reply-To: <4adcd2be-98fb-45bc-9023-a08b035b8b71@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA2PR11MB4876:EE_
x-ms-office365-filtering-correlation-id: f1e4b78e-a9df-4382-8bd8-08dbd9b57cf0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bezZMHMk2xiZx0CvuvLX5oVj860WUcC2ZOD/PA+ZWSIT8wmLIum5ghHKDF52/Y1k/X+4jiW8ed6zgVDXy56epQjxZukOu1W8xl9COHZQqBNr3Yf3XlZDyzgDZeK8vGgnzGa9wsiVGPH/i/kd379rSDbL4bmrTpnGdwAe3LgFxKpgoC2+s5og9/a0ZkDhmhqy4pW4lj1BjWixbp4CpnJWtOtFVs/ES1QuqQfqCvjk1EwTDUfe0U3bTuPpO/+G03mydDOU4n1S9T/OGursxPjpMgWolNrfRzzwypBFAU1NNt6+DzaAbQVLLELyCPDgdoSmDGzw/UvtjFJDWKvqDFefp/wumAb0Wyt8Qhur9QFxlPNlnxEqtTDABUGNSL++Ks3GOY+g2SSTSQgBZedMRjdz+Qx+IFVDVU1k9SdsdA4NmIDdk107YHI0KQRFqlovPoWToXVDlkB6nyeDd9VwGocC0RuXwGBK2WX360JeTAb6GR6p2iyC+OUaJ1ABALnPMptdG20VuUu+gUaqmmedwkhmIsJJrWEsAJvYNU/wbF8OYyTf/IWAEoiZQbMa6GE3lre9tIQ5GSEAyo2F5GxNtfbvYR0nrUzQvktZv8UshpsR5SSzZGAF0AV7NVf3IGK3U6ypZbEJ1OFhwv4smv9+ivRkKA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(55016003)(9686003)(26005)(6506007)(107886003)(478600001)(7696005)(71200400001)(83380400001)(2906002)(4744005)(5660300002)(41300700001)(66556008)(66946007)(76116006)(110136005)(66476007)(66446008)(64756008)(8936002)(52536014)(8676002)(4326008)(316002)(54906003)(38100700002)(122000001)(82960400001)(86362001)(33656002)(38070700009)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzBwNUMxODlGYitLbXhTVTRyMzJUZjlQcnd2YWdzWG9pNWpUZzRoeW5OVExv?=
 =?utf-8?B?a1gwRDljWEtFQ2k1OUdsS29LYWM1a3k4UEJiNzlmamUyem9nc1I0alhJL2k2?=
 =?utf-8?B?RG9RQnZGRFRuMlhiMkFSckdNeHRqWTU2aEJEV3l2b2tvbTZYNzhiTDE4S1M4?=
 =?utf-8?B?ZnN6Z1VIbHpUU0kzci9kQmhZK1VqMjFPemZmUkUxc0xwaVdSeE1PLzczS28x?=
 =?utf-8?B?N0ZvOGhtdGZ2SjhONnRNQks2WnZHZFg0WllueEJTbk11ZExnSFhNblQ4cG1a?=
 =?utf-8?B?c0VNMXNXRU5hSjE0VFM1TXBWV2gvbkUyS21jVU8xNStvY0QwWlMyODFCZ25Z?=
 =?utf-8?B?R1RDblNTWHVkRXJ2TzBKeWdXWFhBdlQ4VmQ5YVBWQXVCTkdUamIxN2d3U1pK?=
 =?utf-8?B?THNsazJaUXVUVjY4NEZQa1dLVmdSZ2YvaHMrd2xQQktzaXhYN1piM3R0blFv?=
 =?utf-8?B?SEpDaVJjejJGUmtDWXVTMU5MdXhpZXhPZXRGSUorQnJXNmJvUS9mc2xNZFJp?=
 =?utf-8?B?M0ZJZHhVSlo5VjVFWWhSYkNiSEtLeW9oSmV5SS90Qi8rQW9SNkNxZ3FBbE8r?=
 =?utf-8?B?NHJUNmFmNlhYWUtqYzkvWkNVZXhzNUcvVXlEdjZvUWlxaUhydTAvZHRNK1hr?=
 =?utf-8?B?L3AyQUlHNlNRUnB3STJGSnl4SnhGQVIyeXV0bW15S01wMnlnSGM3OHhxMWFV?=
 =?utf-8?B?R0pJWEIzKzZrMjc4YUJxS2dmVDdXYm5mNWZZUE9pcTFCc2FYa01lVnc3cTA4?=
 =?utf-8?B?RnpzUmlQWjI0WnoyRmU3QXpMazJIdDlvQ1JEVTlUR2hjZnBIaG15Rm5IUVdv?=
 =?utf-8?B?dGtJeW03UUpqaVJ3UzYyZlBHVEVhTlphbEYreTcrcDJKYThYM0lEcGZadE96?=
 =?utf-8?B?RDN5cjZxQndZZFRldDNTV0gvNlRUanB3Q2xrTzBOVDREcUR0YWJQK2F6WThP?=
 =?utf-8?B?K2d1NlM4VHFCUFhZU2FIVWRiakpDbXlRd043MXBkekZ4eW9FSzJwTEd6azB1?=
 =?utf-8?B?UnRPWG4rWnRrMXJ0UEpiUjF5ZXRhZ3BKRlF6c0pySFhDRWhkSHcwMUprQlhF?=
 =?utf-8?B?NFlQb3VwNmtrczIzUElLVkJ4a0IwaGg2VVlXVG0zRkpRYlV1bGgwU2tjdWJU?=
 =?utf-8?B?TGFsWEdEeXBheXVGK3RZY3Z6TTNPcndjUlYzbzQrcXBudkdPZU5xZklLTUFJ?=
 =?utf-8?B?bVNaL0J5M2s5T3BWck94c2JFaDlhS29EZGY2Vm9obnpRSllRQnNFa01OK2pT?=
 =?utf-8?B?V2tnS1NzN09mNzE2cDZ1K0xoQVZUbWNVTjlHSjMzSHlyMFI1eXA5RW1Zb1JF?=
 =?utf-8?B?eTdpZ2xFWll4SFFmZFdOaHU3NVJHV0l1QW9URUVFbzNGNndHSmJuOUJXT0R0?=
 =?utf-8?B?RmtTclRHUFpLdjlqQ0xQaER0bFdqdTI4eHVVcEFMalpWQXRvbEk4enQ3SHM0?=
 =?utf-8?B?eXZCU3paa2J1YkZVeGFZY3Mrb2JvWTdMNjRCbUR4b1N3WU5ITGc3eWV5a2RD?=
 =?utf-8?B?VWM0dmdFRU00VmdsVjVHSVhIR0FKV3cybEsyN3VqUXV1VUlCdG9ETW9TRWIw?=
 =?utf-8?B?ejVQb2VoL2Q5Z3Nmd0hEMWV3ZHJxbEpaMWMvWkxLY2tUYXF2eFl4b1hkTUt3?=
 =?utf-8?B?K3RaTXBtVHRuMHk4MHhHcUdSVGIwcHRzRnoxdS9ycVcxS3NHRWxOTnVPMGsv?=
 =?utf-8?B?aTlIbHpYM3h2cFFLKy91YnVGRHExRDVlS0IwYjQrMTU5bVZ0RGx1QWx3eUhQ?=
 =?utf-8?B?M2JUc01GSFh5cHMybE1vMFBjUE91dEFMVyt6YzVyS0IvN09tWFNBNDV2dG9y?=
 =?utf-8?B?VWhZazFYaGZTazlIUXJvSmtsVHRjaUY4SE5PQkR1ZGlVYVJLM2NnTlBMbG41?=
 =?utf-8?B?ZHM4S21SQ1I5eVFxZ1lyYkIxQ0l0Z3djWHBjZkR6Um1pOVZQZjN0QndlNU5Y?=
 =?utf-8?B?ckFGN2xHc3ZNdWZGZnprQ2svcDZNU1cxZHViMm5yalc4Q1FueUZtVWVmcHU2?=
 =?utf-8?B?SmROeVNWbDZmTmNKekJyRW1mY2VkN2kyOWE1TEVwWC9qSkJ5WGRCdm1qUXdz?=
 =?utf-8?B?RmZIVXVlVUd0MStDNkhsV2x4bEdyZEJNNUlpbW1mSzZGUnFMVi9qSFBVS2VC?=
 =?utf-8?Q?8Ea6vSQ/F7akzGE8ndJ+w4YG7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e4b78e-a9df-4382-8bd8-08dbd9b57cf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 02:02:51.1275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x/ZxUaC1VnkFD5yNHDXe8/7pdxVynY4smuNPiO8uAZ1zlRsFkgdKS1T59QcKTL3yaGzNyCi3LsulePVqAs2jLIn2FKh8XPsVFoSsXFzA9kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4876
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBNb25kYXksIE9jdG9iZXIgMzAsIDIwMjMgOTo1MiBQ
TQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMjcvMzddIHZmaW8vaW9tbXVmZDogU3dpdGNoIHRv
IG1hbnVhbCBod3B0IGFsbG9jYXRpb24NCj4NCj5PbiAxMC8yNi8yMyAxMjozMCwgWmhlbnpob25n
IER1YW4gd3JvdGU6DQo+PiBJT01NVUZEIHN1cHBvcnRzIGF1dG8gYWxsb2NhdGVkIGh3cHQgYW5k
IG1hbnVhbGx5IGFsbG9jYXRlZCBvbmUuDQo+PiBNYW51YWxseSBhbGxvY2F0ZWQgaHdwdCBoYXMg
YmVuZWZpdCB0aGF0IGl0cyBsaWZlIGN5Y2xlIGlzIHVuZGVyDQo+PiB1c2VyJ3MgY29udHJvbCwg
c28gaXQgY291bGQgYmUgdXNlZCBhcyBzdGFnZSAyIHBhZ2UgdGFibGUgYnkgbmVzdGVkDQo+PiBm
ZWF0dXJlIGluIHRoZSBmdXR1cmUuDQo+DQo+V291bGQgYW4gb3B0aW9uIGJlIHVzZWZ1bCB0byBz
d2l0Y2ggZnJvbSBvbmUgbW9kZSB0byBhbm90aGVyID8NCg0KTG9va3MgdW5uZWNlc3NhcnkgZm9y
IG1lIGFzIHdlIHByZWZlciBtYW51YWwgYWxsb2NhdGlvbi4NClRoZSBwdXJwb3NlIG9mIHNwbGl0
dGluZyBpcyB0byBtYWtlIHJldmlldyBlYXNpZXIuDQoNCj4NCj4+DQo+PiBJbnRyb2R1Y2UgdHdv
IGhlbHBlcnMgX192ZmlvX2RldmljZV9hdHRhY2gvZGV0YWNoX2h3cHQgdG8gZmFjaWxpdGF0ZQ0K
Pj4gdGhpcyBjaGFuZ2UuDQo+DQo+SSB0aGluayBtZXJnaW5nIHRoaXMgY2hhbmdlIHdpdGggdGhl
IHByZXZpb3VzIHBhdGNoIG1ha2VzIHNlbnNlLg0KPkl0IGRvZXNuJ3QgYWRkIG11Y2ggdG8ga2Vl
cCBpdCBhcyBhIHN0YW5kYWxvbmUgcGF0Y2ggdW5sZXNzIHdlDQo+d2FudCBhIGZlYXR1cmUgdG9n
Z2xlLg0KDQpPSywgd2lsbCBtZXJnZSB0aGVtIGluIHY0Lg0KDQpUaGFua3MNClpoZW56aG9uZw0K

