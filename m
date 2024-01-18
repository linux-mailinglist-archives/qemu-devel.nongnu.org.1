Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DC88315D6
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 10:30:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQOj8-0008FN-Lr; Thu, 18 Jan 2024 04:30:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQOj5-0008Es-SJ
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 04:30:19 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQOj3-0005Vz-ET
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 04:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705570218; x=1737106218;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jQH2npQYeuINNixXABQL0mGvuzxfutaojZAgkAvpI1E=;
 b=GLZJDOsT356Rex4Gc/dKfDQEB0LVkAUqbJ0LsHp3gCaeS4szWAhKxgKK
 GwVfyLssnz3slYJ3OUPIzZDgP+wak2jPusFrd143Y6KMQBL7NblD0GK+8
 NjkHCc6tvf9CEftdlQgghvuPEtPKYThokdjzXUebYXfDDs3nqefCNX9ZB
 FYDeRPdMS/B4Xhf25y/0K/M8t44sjYeFDwM+i98naJCb3hZzR131HwGGw
 gZ6OVyyElralBAQLx6SoAIyjLA2fnL8Lmgjada6CtQcCOAjmYTkxlbdMR
 SXVmitbBvUxV+NDhHgrSpEGUkLJdaOTW+BEs/KzKkyh5qSejbBKJc84YF Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="293674"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="293674"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 01:30:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="777688142"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; d="scan'208";a="777688142"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Jan 2024 01:30:14 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 01:30:13 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 01:30:13 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 01:30:13 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 01:30:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILEloQRV/cTkR9Brh5fBpIiTFpKMx7BITlCvGlCqqnFmeJlUlN8jsRKVoEYXC7WqbbrN81+HkMOfP3l5pCVMXwkhEtvmB4RS2xI0fyYASM6yk4ruK+QTeNOpxpwPcpgSy5Xo5w7+KX/FYuCQXAEewMlzFSPKuzJjW6sTdFDr1YeUsIkAxkPFgkWh0y5QVlL5++70H9fKqPCRTsNfR/7yeJzr56La8XXzw7iyyPimXt8Xilo4QFokWTWU9O/UzC5PrjQOXe+uQ795X0SnHIRPd1rvI8znx+ngtS8H0GegMrwT2S054Gq4I4k6EbLIe6rCZCPGM8NBwXs7IUaubW+THw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQH2npQYeuINNixXABQL0mGvuzxfutaojZAgkAvpI1E=;
 b=UKdbPFLW2U3baUi4qsWn5H6gAnuA7qUwc24EWZXTxOYtXQXvdqaIs6Q92ijQ3VtTPmBmMtwyS60L4r9Lk6MCw81OnZNOqzrDtV7RtKSL1eV3edJvBmneYwASC1gYp37YYMduUT3OP2bSZpoC1OuaNbwbXaX6gtooX4uF5wqIap3dkrghmr4bUN0ZQLOqZgdDOolhdYlpxnnzr6BIa+sqR1jniifmQCQ5D4HvieKzHcqcAIZhrHW7EfeAg8esdsJtfdyx6gowDHtQRsK3X925B0z2EkUXabN/tf5iKHFI7rWNYbCZUvQBWpmNl/+pCmqSAU6NvCjYdDZ/ze0aR4+WoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB5938.namprd11.prod.outlook.com (2603:10b6:a03:42d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 09:30:10 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace%5]) with mapi id 15.20.7181.020; Thu, 18 Jan 2024
 09:30:10 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH rfcv1 6/6] intel_iommu: add a framework to check and sync
 host IOMMU cap/ecap
Thread-Topic: [PATCH rfcv1 6/6] intel_iommu: add a framework to check and sync
 host IOMMU cap/ecap
Thread-Index: AQHaR5v7WsCg8QEA5Em7AcF13NhjjbDeTamAgAD+K6A=
Date: Thu, 18 Jan 2024 09:30:09 +0000
Message-ID: <SJ0PR11MB6744AC771797D3C7634817BC92712@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-7-zhenzhong.duan@intel.com>
 <cf7ee2c4-6dcd-40f1-8d39-2efdc15c00d9@redhat.com>
In-Reply-To: <cf7ee2c4-6dcd-40f1-8d39-2efdc15c00d9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB5938:EE_
x-ms-office365-filtering-correlation-id: cce174ec-b0fb-44ac-84de-08dc180810cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eaGU5iUpvhYYeO7LVxUMUtSFt3jenq1hM4smOUcVRNSIz4DSufQ+9e+KJmW38Fnn9/o7AneghcIsqcIHyIuFaMKpKLjTFkDidKLFKl39sg0IWIM0sZo8xiEsoxWBi5ORvtPx3Hp7P2Um42LLyzRJTTXC+FAgloJhrg07xf1jUxeJ9TDyElMD23EBrzCQayqxFJFMMfO3jQKd/3WiTLlYAekKI8CQhkcC7xETi7j0T8O4qgemmjTWJGit/qQIZs2aJVEOBoapjWn/Y0bTYATwQqEkipY85GVDdwR49baYJp7p3K4ydLNSt6Y37Bv5ppUdNqtA3cswfnsNVPVAjKub06Ph0zKQVruKyHFH6+IMU+oPG6JBo0B7cQ/J5RAIdfHK5YfKj7gfAboie93IZFSY0c0TCecYwZPjNiWkLhgkd9SpIRpGXOJdj0L+Ey+VG+xvuR6r7KzmErTcjOmmwiBTdAUYvDkG+NZTJweUxy+qvAfBcl9wjAARTy7oj0fmavfpgQEbwRX/d6j3gsxRpSsULR5cP8ABl7JGQqAEKDw1qfuf/fukk6A5ZQK77ProQz8uJ9R2fGikEZrJAXjdUdZII06eRMHTuntTApvMH2yp7CxzLyjuRKlhqwGDCiP/Gncz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(396003)(366004)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(66946007)(66476007)(66556008)(66446008)(82960400001)(122000001)(54906003)(8676002)(4326008)(8936002)(64756008)(76116006)(110136005)(478600001)(38100700002)(9686003)(26005)(55016003)(316002)(52536014)(86362001)(6506007)(71200400001)(7696005)(83380400001)(2906002)(5660300002)(7416002)(33656002)(38070700009)(41300700001)(473944003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUdPdHc4T1dOMXdKamJlOTFNVEczVzFwcGZoSlhZek9wanlBaVhSM2VDWnd6?=
 =?utf-8?B?TWc4T3J3SmV2bTczV2ZxTFZSSnRvL0ltNTFob2VzWkVwUERTTHZUZTZSRlk3?=
 =?utf-8?B?YVprSm1lVjBUS2pQOXBxZ2tIa3FLSURKSklXNlAzaEVSUGxzRVRQT2Jqb0d3?=
 =?utf-8?B?Tks4U1hLZzMxMGJpTXZGN3p5R090S1JPNWxnTXh5d3ZsblFPemRsVFVmOFRv?=
 =?utf-8?B?SElRTG55UTFvbkg0L05YRUk1TUhYT29PODZpMC9INWtWS0pBeDFGS256aTZn?=
 =?utf-8?B?L3JVandyazhoZm9BTGpQS1V6TTZZSXpGWEpibjNheXhhd001TEtXdUpMTUJ5?=
 =?utf-8?B?WUFSa09CVWhQdWRPQkJxYWJiZjhscGZvNDFXVDZFcTAyRGtqQWlDVDZNNkIr?=
 =?utf-8?B?cG1xNFgvZ2w0K1pkMjJydXVneno4N0s3Q01PeGFvbVI2bGk0b0dRUmdkbklL?=
 =?utf-8?B?V1B1d0tydVgzNFd3V08wMlU1cTNyc3lPaUx1WjZ3UWVPY2JMeDZvajRaUkcv?=
 =?utf-8?B?TFNJemVvbXhvL2UrbGNkTFZXSmZNbHRUU1daNUpIbGFHSzhNMXRWL2FOdWVS?=
 =?utf-8?B?ZkFpalR6UTRXOGFmaDJUclJOUFRrdkpQOWVWSWZWcVQ5ZHkxa01vWTg0Wjh3?=
 =?utf-8?B?ZlVNVTh6aEE1Zk1qZDh2bmFyVldpVnZQVE14amQvU3lJb3dLOXJwb0MzUi9u?=
 =?utf-8?B?QnhFOWRDRjJFMzYyTzRIVzB2SlV2bjQwVE41YXkzVS84aTNrTWtIbGpDVmwz?=
 =?utf-8?B?ZUgzdWhJNE02WWhwQlI2S0ZMT0dmYnlMQTFHdWNUTnpJdlVKbnVyaUpsR0d3?=
 =?utf-8?B?YkJrOUlWbDZSaGRvUW1POWtsRndJbXNaZTZxckhhejBLNkVYRlBianUvMUw1?=
 =?utf-8?B?K0JjcmUzNSsyWXFUalN6Z2k4MlE0OStvSWYweTkrdGdYdDErVlg0RmNFcklp?=
 =?utf-8?B?NVdUeUJ6c0F5STAwSnd5dzNuUGRLM21tYzA5OEx1RDFxWVpkU2lQL05VNER2?=
 =?utf-8?B?SGNEOURIVk12akFhT1p1SURVeW92OURTRVF1VDZCaFY0RlNNaUZQTzI2Mkxo?=
 =?utf-8?B?VjQ0WmJ1cjRuVTVHOUt6NFlmR3FrN3FKeE9YVERpVG5Pb2xjd3hGS3d1eFVw?=
 =?utf-8?B?LzFCU0IyU3E2bWZwV2U5WElDQ2pRWVVSam1UdnJITWltckJJVVdPS0NMV2dD?=
 =?utf-8?B?ZjhiajBuRjRUaHN0N205V3duYlhhb0FQbE5PU1RFalJSaEk1dllVRlc3Y1Nw?=
 =?utf-8?B?ZFN0c2JxZ3NRZ0RITzhnVTE3dS8yTWQ2b0Y1Q3hUNXAxSFdwZ0NEQkh5Q090?=
 =?utf-8?B?c0x2Z1JYRGhZdmRQMXpkSGFYVEt3cWlmU3BoWHJmQ1lPZzZVTXRkUGd6eVcv?=
 =?utf-8?B?VS9KK0s1Zk04L2Zpc2RRdnN2S09ycm9HbkZjOVNmZmlGVVMwZTJtMWVhc1d1?=
 =?utf-8?B?NEhhejdiUFdmSDhnbnd2eG9mbWI1bmtidmhHNkhXeC8yT01iWFpjNHhSamdU?=
 =?utf-8?B?WDFZRmtDa1NDdW5uZ3lvVmVab0lOUFBCR01WbGRXNlMrMXNWK3hFQVRUMWhz?=
 =?utf-8?B?Q01VZFVvck5PNEpweVpUR2JSQ1lTMVAwUHo4T3ptdkFNNUd0aUNYMzI0YnRj?=
 =?utf-8?B?UHJySVRGMjFjUmlUM0tzZmJGZmdhd00wVFBMSnB0QTk0MVcxK3ZjQ2xReGZj?=
 =?utf-8?B?elVMQityMUZrelJMdWJvdVRuRXdnQ2Z2MElKUUxvcUtDY2tISlRwS2FIQVVQ?=
 =?utf-8?B?TTUrTkI0OC9CQkZiSkgrT0xnL1RRZ3JFRzVvQ1NadGRzdnQ1eEdqU2ZDZmh0?=
 =?utf-8?B?MFVkQTgxVGc1WEV2cXhmK1luZnNiNDZtVHpIWlIzc3FSZDM3NjVnN2FhMnNh?=
 =?utf-8?B?Nko5VmVsZTQydXRGTGpKdWFOTWZJRVU2b2o0TDJ6b0ZTOEs5SFZqaFBMMmFP?=
 =?utf-8?B?SnhwcHFncWZaNXdlTVI5VzNzc2ZuZ0xVVkZaMTJHMEVJT3NmcUlNY2JYY2l0?=
 =?utf-8?B?UjdHTFI4aktDL08yRGNjTDFTSFRQdzFJSm9INitmQkNST0w3Z094cXdiS3NT?=
 =?utf-8?B?TFJ3bUpjWXdmZVBvWE9YKzJGK0hmVG82VHdjN3JLcE15VlpXa08xamk5UGk3?=
 =?utf-8?Q?tY4qu+9s/v+PaADOrAH5TcnP3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce174ec-b0fb-44ac-84de-08dc180810cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 09:30:10.0035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJrHxxvr0whrWbsc4SgrO/Hq3UPIDO4WKBuK+bF83Uc/3bQbULsBuVXqtjCtIviUxGrNQssL8jZA90NP3mYhYguVn+RC8/zyj0HV0oI1Gdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5938
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggcmZjdjEgNi82
XSBpbnRlbF9pb21tdTogYWRkIGEgZnJhbWV3b3JrIHRvIGNoZWNrIGFuZA0KPnN5bmMgaG9zdCBJ
T01NVSBjYXAvZWNhcA0KPg0KPkhpIFpoZW56aG9uZywNCj4NCj5PbiAxLzE1LzI0IDExOjEzLCBa
aGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEZyb206IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29t
Pg0KPj4NCj4+IEFkZCBhIGZyYW1ld29yayB0byBjaGVjayBhbmQgc3luY2hyb25pemUgaG9zdCBJ
T01NVSBjYXAvZWNhcCB3aXRoDQo+PiB2SU9NTVUgY2FwL2VjYXAuDQo+Pg0KPj4gQ3VycmVudGx5
IG9ubHkgc3RhZ2UtMiB0cmFuc2xhdGlvbiBpcyBzdXBwb3J0ZWQgd2hpY2ggaXMgYmFja2VkIGJ5
DQo+PiBzaGFkb3cgcGFnZSB0YWJsZSBvbiBob3N0IHNpZGUuIFNvIHdlIGRvbid0IG5lZWQgZXhh
Y3QgbWF0Y2hpbmcgb2YNCj4+IGVhY2ggYml0IG9mIGNhcC9lY2FwIGJldHdlZW4gdklPTU1VIGFu
ZCBob3N0LiBIb3dldmVyLCB3ZSBjYW4gc3RpbGwNCj4+IHV0aWxpemUgdGhpcyBmcmFtZXdvcmsg
dG8gZW5zdXJlIGNvbXBhdGliaWxpdHkgb2YgaG9zdCBhbmQgdklPTU1VJ3MNCj4+IGFkZHJlc3Mg
d2lkdGggYXQgbGVhc3QsIGkuZS4sIHZJT01NVSdzIGF3X2JpdHMgPD0gaG9zdCBhd19iaXRzLA0K
Pj4gd2hpY2ggaXMgbWlzc2VkIGJlZm9yZS4NCj4+DQo+PiBXaGVuIHN0YWdlLTEgdHJhbnNsYXRp
b24gaXMgc3VwcG9ydGVkIGluIGZ1dHVyZSwgYS5rLmEuIHNjYWxhYmxlDQo+PiBtb2Rlcm4gbW9k
ZSwgd2UgbmVlZCB0byBlbnN1cmUgY29tcGF0aWJpbGl0eSBvZiBlYWNoIGJpdHMuIFNvbWUNCj4+
IGJpdHMgYXJlIHVzZXIgY29udHJvbGxhYmxlLCB0aGV5IHNob3VsZCBiZSBjaGVja2VkIHdpdGgg
aG9zdCBzaWRlDQo+PiB0byBlbnN1cmUgY29tcGF0aWJpbGl0eS4gT3RoZXIgYml0cyBhcmUgbm90
LCB0aGV5IHNob3VsZCBiZSBzeW5jZWQNCj4+IGludG8gdklPTU1VIGNhcC9lY2FwIGZvciBjb21w
YXRpYmlsaXR5Lg0KPj4NCj4+IFRoZSBzZXF1ZW5jZSB3aWxsIGJlOg0KPj4NCj4+IHZ0ZF9jYXBf
aW5pdCgpIGluaXRpYWxpemVzIGlvbW11LT5jYXAvZWNhcC4gLS0tLSB2dGRfY2FwX2luaXQoKQ0K
Pj4gaW9tbXUtPmhvc3RfY2FwL2VjYXAgaXMgaW5pdGlhbGl6ZWQgYXMgaW9tbXUtPmNhcC9lY2Fw
LiAgLS0tLSB2dGRfaW5pdCgpDQo+PiBpb21tdS0+aG9zdF9jYXAvZWNhcCBpcyBjaGVja2VkIGFu
ZCB1cGRhdGVkIHNvbWUgYml0cyB3aXRoIGhvc3QNCj5jYXAvZWNhcC4gLS0tLSB2dGRfc3luY19o
d19pbmZvKCkNCj4+IGlvbW11LT5jYXAvZWNhcCBpcyBmaW5hbGl6ZWQgYXMgaW9tbXUtPmhvc3Rf
Y2FwL2VjYXAuICAtLS0tDQo+dnRkX21hY2hpbmVfZG9uZV9ob29rKCkNCj4+DQo+PiBpb21tdS0+
aG9zdF9jYXAvZWNhcCBpcyBhIHRlbXBvcmFyeSBzdG9yYWdlIHRvIGhvbGQgaW50ZXJtZWRpYXRl
IHZhbHVlDQo+PiB3aGVuIHN5bnRoZXNpemUgaG9zdCBjYXAvZWNhcCBhbmQgdklPTU1VJ3MgaW5p
dGlhbCBjb25maWd1cmVkIGNhcC9lY2FwLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8
eWkubC5saXVAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWWkgU3VuIDx5aS55LnN1bkBs
aW51eC5pbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpo
b25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgaW5jbHVkZS9ody9pMzg2L2ludGVsX2lv
bW11LmggfCAgNCArKw0KPj4gIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgIHwgNzgNCj4r
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPj4gIDIgZmlsZXMgY2hhbmdlZCwg
NzUgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj5iL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21t
dS5oDQo+PiBpbmRleCBjNjVmZGRlNTZmLi5iOGFiYmNjZTEyIDEwMDY0NA0KPj4gLS0tIGEvaW5j
bHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRl
bF9pb21tdS5oDQo+PiBAQCAtMjkyLDYgKzI5Miw5IEBAIHN0cnVjdCBJbnRlbElPTU1VU3RhdGUg
ew0KPj4gICAgICB1aW50NjRfdCBjYXA7ICAgICAgICAgICAgICAgICAgIC8qIFRoZSB2YWx1ZSBv
ZiBjYXBhYmlsaXR5IHJlZyAqLw0KPj4gICAgICB1aW50NjRfdCBlY2FwOyAgICAgICAgICAgICAg
ICAgIC8qIFRoZSB2YWx1ZSBvZiBleHRlbmRlZCBjYXBhYmlsaXR5IHJlZyAqLw0KPj4NCj4+ICsg
ICAgdWludDY0X3QgaG9zdF9jYXA7ICAgICAgICAgICAgICAvKiBUaGUgdmFsdWUgb2YgaG9zdCBj
YXBhYmlsaXR5IHJlZyAqLw0KPj4gKyAgICB1aW50NjRfdCBob3N0X2VjYXA7ICAgICAgICAgICAg
IC8qIFRoZSB2YWx1ZSBvZiBob3N0IGV4dC1jYXBhYmlsaXR5IHJlZyAqLw0KPj4gKw0KPj4gICAg
ICB1aW50MzJfdCBjb250ZXh0X2NhY2hlX2dlbjsgICAgIC8qIFNob3VsZCBiZSBpbiBbMSxNQVhd
ICovDQo+PiAgICAgIEdIYXNoVGFibGUgKmlvdGxiOyAgICAgICAgICAgICAgLyogSU9UTEIgKi8N
Cj4+DQo+PiBAQCAtMzE0LDYgKzMxNyw3IEBAIHN0cnVjdCBJbnRlbElPTU1VU3RhdGUgew0KPj4g
ICAgICBib29sIGRtYV90cmFuc2xhdGlvbjsgICAgICAgICAgIC8qIFdoZXRoZXIgRE1BIHRyYW5z
bGF0aW9uIHN1cHBvcnRlZCAqLw0KPj4gICAgICBib29sIHBhc2lkOyAgICAgICAgICAgICAgICAg
ICAgIC8qIFdoZXRoZXIgdG8gc3VwcG9ydCBQQVNJRCAqLw0KPj4NCj4+ICsgICAgYm9vbCBjYXBf
ZmluYWxpemVkOyAgICAgICAgICAgICAvKiBXaGV0aGVyIFZURCBjYXBhYmlsaXR5IGZpbmFsaXpl
ZCAqLw0KPj4gICAgICAvKg0KPj4gICAgICAgKiBQcm90ZWN0cyBJT01NVSBzdGF0ZXMgaW4gZ2Vu
ZXJhbC4gIEN1cnJlbnRseSBpdCBwcm90ZWN0cyB0aGUNCj4+ICAgICAgICogcGVyLUlPTU1VIElP
VExCIGNhY2hlLCBhbmQgY29udGV4dCBlbnRyeSBjYWNoZSBpbg0KPlZUREFkZHJlc3NTcGFjZS4N
Cj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lv
bW11LmMNCj4+IGluZGV4IDRjMWQwNThlYmQuLmJlMDNmY2JmNTIgMTAwNjQ0DQo+PiAtLS0gYS9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4g
QEAgLTM4MTksNiArMzgxOSw0NyBAQCBWVERBZGRyZXNzU3BhY2UNCj4qdnRkX2ZpbmRfYWRkX2Fz
KEludGVsSU9NTVVTdGF0ZSAqcywgUENJQnVzICpidXMsDQo+PiAgICAgIHJldHVybiB2dGRfZGV2
X2FzOw0KPj4gIH0NCj4+DQo+PiArc3RhdGljIGJvb2wgdnRkX3N5bmNfaHdfaW5mbyhJbnRlbElP
TU1VU3RhdGUgKnMsIHN0cnVjdA0KPmlvbW11X2h3X2luZm9fdnRkICp2dGQsDQo+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+PiArew0KPj4gKyAgICB1aW50
NjRfdCBhZGRyX3dpZHRoOw0KPj4gKw0KPj4gKyAgICBhZGRyX3dpZHRoID0gKHZ0ZC0+Y2FwX3Jl
ZyA+PiAxNikgJiAweDNmVUxMOw0KPj4gKyAgICBpZiAocy0+YXdfYml0cyA+IGFkZHJfd2lkdGgp
IHsNCj4+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgIlVzZXIgYXctYml0czogJXUgPiBob3N0
IGFkZHJlc3Mgd2lkdGg6ICVsdSIsDQo+PiArICAgICAgICAgICAgICAgICAgIHMtPmF3X2JpdHMs
IGFkZHJfd2lkdGgpOw0KPj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gKyAgICB9DQo+PiAr
DQo+PiArICAgIC8qIFRPRE86IGNoZWNrIGFuZCBzeW5jIGhvc3QgY2FwL2VjYXAgaW50byB2SU9N
TVUgY2FwL2VjYXAgKi8NCj4+ICsNCj4+ICsgICAgcmV0dXJuIHRydWU7DQo+PiArfQ0KPj4gKw0K
Pj4gKy8qDQo+PiArICogdmlydHVhbCBWVC1kIHdoaWNoIHdhbnRzIG5lc3RlZCBuZWVkcyB0byBj
aGVjayB0aGUgaG9zdCBJT01NVQ0KPj4gKyAqIG5lc3RpbmcgY2FwIGluZm8gYmVoaW5kIHRoZSBh
c3NpZ25lZCBkZXZpY2VzLiBUaHVzIHRoYXQgdklPTU1VDQo+PiArICogY291bGQgYmluZCBndWVz
dCBwYWdlIHRhYmxlIHRvIGhvc3QuDQo+PiArICovDQo+PiArc3RhdGljIGJvb2wgdnRkX2NoZWNr
X2lkZXYoSW50ZWxJT01NVVN0YXRlICpzLCBJT01NVUZERGV2aWNlICppZGV2LA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+ICt7DQo+PiArICAgIHN0cnVj
dCBpb21tdV9od19pbmZvX3Z0ZCB2dGQ7DQo+PiArICAgIGVudW0gaW9tbXVfaHdfaW5mb190eXBl
IHR5cGUgPQ0KPklPTU1VX0hXX0lORk9fVFlQRV9JTlRFTF9WVEQ7DQo+PiArDQo+PiArICAgIGlm
IChpb21tdWZkX2RldmljZV9nZXRfaW5mbyhpZGV2LCAmdHlwZSwgc2l6ZW9mKHZ0ZCksICZ2dGQp
KSB7DQo+PiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJGYWlsZWQgdG8gZ2V0IElPTU1VIGNh
cGFiaWxpdHkhISEiKTsNCj4+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAgfQ0KPj4g
Kw0KPj4gKyAgICBpZiAodHlwZSAhPSBJT01NVV9IV19JTkZPX1RZUEVfSU5URUxfVlREKSB7DQo+
PiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJJT01NVSBoYXJkd2FyZSBpcyBub3QgY29tcGF0
aWJsZSEhISIpOw0KPj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gKyAgICB9DQo+PiArDQo+
PiArICAgIHJldHVybiB2dGRfc3luY19od19pbmZvKHMsICZ2dGQsIGVycnApOw0KPj4gK30NCj4+
ICsNCj4+ICBzdGF0aWMgaW50IHZ0ZF9kZXZfc2V0X2lvbW11X2RldmljZShQQ0lCdXMgKmJ1cywg
dm9pZCAqb3BhcXVlLCBpbnQzMl90DQo+ZGV2Zm4sDQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgSU9NTVVGRERldmljZSAqaWRldiwgRXJyb3IgKiplcnJwKQ0KPj4gIHsN
Cj4+IEBAIC0zODM3LDYgKzM4NzgsMTAgQEAgc3RhdGljIGludCB2dGRfZGV2X3NldF9pb21tdV9k
ZXZpY2UoUENJQnVzDQo+KmJ1cywgdm9pZCAqb3BhcXVlLCBpbnQzMl90IGRldmZuLA0KPj4gICAg
ICAgICAgcmV0dXJuIDA7DQo+PiAgICAgIH0NCj4+DQo+PiArICAgIGlmICghdnRkX2NoZWNrX2lk
ZXYocywgaWRldiwgZXJycCkpIHtJbg0KPkluDQo+W1JGQyAwLzddIFZJUlRJTy1JT01NVS9WRklP
OiBGaXggaG9zdCBpb21tdSBnZW9tZXRyeSBoYW5kbGluZyBmb3INCj5ob3RwbHVnZ2VkIGRldmlj
ZXMNCj5odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDAxMTcwODA0MTQuMzE2ODkwLTEt
DQo+ZXJpYy5hdWdlckByZWRoYXQuY29tLw0KPg0KPkkgYWxzbyBhdHRlbXB0IHRvIHBhc3MgaG9z
dCBpb21tdSBpbmZvIHRvIHRoZSB2aXJ0aW8taW9tbXUgYnV0IHdpdGgNCj5sZWdhY3kgQkUuDQoN
CkkgdGhpbmsgeW91ciBwYXRjaCB3b3JrcyB3aXRoIGlvbW11ZmQgQkUgdG9v8J+YiiBCZWNhdXNl
IGlvbW11ZmQgQkUNCmFsc28gZmlsbHMgYmNvbnRhaW5lci0+aW92YV9yYW5nZXMgaW4gaW9tbXVm
ZF9jZGV2X2dldF9pbmZvX2lvdmFfcmFuZ2UoKS4NCg0KPiBJbiBteSBjYXNlIEkgd2FudCB0byBw
YXNzIHRoZSByZXNlcnZlZCBtZW1vcnkgcmVnaW9ucyB3aGljaA0KPmFsc28gbW9kZWwgdGhlIGF3
Lg0KPlNvIHRoaXMgaXMgYSBwcmV0dHkgc2ltaWxhciB1c2UgY2FzZS4NCg0KWWVzLg0KDQo+DQo+
V2h5IGRvbid0IHdlIHBhc3MgdGhlIHBvaW50ZXIgdG8gYW4gb3BhcXVlIGlvbW11X2h3X2luZm8g
aW5zdGVhZCwNCj50aHJvdWdoIHRoZSBQQ0lJT01NVU9wcz8NCg0KUGFzc2luZyBpb21tdV9od19p
bmZvIGlzIG9rIGZvciB0aGlzIHNlcmllcywgYnV0IHdlIHdhbnQgbW9yZSBmcm9tDQpJT01NVUZE
RGV2aWNlIGluIG5lc3Rpbmcgc2VyaWVzLiBJLmUuLCBhbGxvY2F0ZS9mcmVlIGlvYXMvaHdwdCwN
CmF0dGFjaC9kZXRhY2ggZnJvbSBod3B0LCBnZXQgZGlydHkgYml0bWFwLCBldGMuIEl0J3MgbW9y
ZSBmbGV4aWJsZSB0bw0KbGV0IHZJT01NVSBnZXQgd2hhdCBpdCB3YW50IGl0c2VsZi4NCg0KPg0K
Pg0KPg0KPj4gKyAgICAgICAgcmV0dXJuIC0xOw0KPj4gKyAgICB9DQo+PiArDQo+PiAgICAgIHZ0
ZF9pb21tdV9sb2NrKHMpOw0KPj4NCj4+ICAgICAgdnRkX2lkZXYgPSBnX2hhc2hfdGFibGVfbG9v
a3VwKHMtPnZ0ZF9pb21tdWZkX2RldiwgJmtleSk7DQo+PiBAQCAtNDA3MSwxMCArNDExNiwxMSBA
QCBzdGF0aWMgdm9pZCB2dGRfaW5pdChJbnRlbElPTU1VU3RhdGUgKnMpDQo+PiAgew0KPj4gICAg
ICBYODZJT01NVVN0YXRlICp4ODZfaW9tbXUgPSBYODZfSU9NTVVfREVWSUNFKHMpOw0KPj4NCj4+
IC0gICAgbWVtc2V0KHMtPmNzciwgMCwgRE1BUl9SRUdfU0laRSk7DQo+PiAtICAgIG1lbXNldChz
LT53bWFzaywgMCwgRE1BUl9SRUdfU0laRSk7DQo+PiAtICAgIG1lbXNldChzLT53MWNtYXNrLCAw
LCBETUFSX1JFR19TSVpFKTsNCj4+IC0gICAgbWVtc2V0KHMtPndvbWFzaywgMCwgRE1BUl9SRUdf
U0laRSk7DQo+PiArICAgIC8qIENBUC9FQ0FQIGFyZSBpbml0aWFsaXplZCBpbiBtYWNoaW5lIGNy
ZWF0ZSBkb25lIHN0YWdlICovDQo+PiArICAgIG1lbXNldChzLT5jc3IgKyBETUFSX0dDTURfUkVH
LCAwLCBETUFSX1JFR19TSVpFIC0NCj5ETUFSX0dDTURfUkVHKTsNCj4+ICsgICAgbWVtc2V0KHMt
PndtYXNrICsgRE1BUl9HQ01EX1JFRywgMCwgRE1BUl9SRUdfU0laRSAtDQo+RE1BUl9HQ01EX1JF
Ryk7DQo+PiArICAgIG1lbXNldChzLT53MWNtYXNrICsgRE1BUl9HQ01EX1JFRywgMCwgRE1BUl9S
RUdfU0laRSAtDQo+RE1BUl9HQ01EX1JFRyk7DQo+PiArICAgIG1lbXNldChzLT53b21hc2sgKyBE
TUFSX0dDTURfUkVHLCAwLCBETUFSX1JFR19TSVpFIC0NCj5ETUFSX0dDTURfUkVHKTsNCj5UaGlz
IGNoYW5nZSBpcyBub3QgZG9jdW1lbnRlZCBpbiB0aGUgY29tbWl0IG1zZy4NCj5Tb3JyeSBJIGRv
bid0IGdldCB3aHkgdGhpcyBpcyBuZWVkZWQ/DQoNCkknbGwgZG9jIGl0LiBBYm92ZSB3ZSBoYXZl
IG9uZSBsaW5lIHRvIGV4cGxhaW4gd2hlbiBjYXAvZWNhcCBhcmUgaW5pdGlhbGl6ZWQuDQp2dGRf
aW5pdCgpIGlzIGNhbGxlZCBpbiBxZW11IGluaXQgYW5kIGd1ZXN0IHJlc2V0LiBJbiBxZW11IGlu
aXQsDQpDYXAvZWNhcCBpcyBmaW5hbGl6ZWQsIGFmdGVyIHRoYXQgd2UgZG9uJ3Qgd2FudCBjYXAv
ZWNhcCB0byBiZSBjaGFuZ2VkLg0KU28gd2UgYnlwYXNzIGNoYW5nZSB0byBjYXAvZWNhcCBoZXJl
Lg0KDQo+Pg0KPj4gICAgICBzLT5yb290ID0gMDsNCj4+ICAgICAgcy0+cm9vdF9zY2FsYWJsZSA9
IGZhbHNlOw0KPj4gQEAgLTQxMTAsMTMgKzQxNTYsMTYgQEAgc3RhdGljIHZvaWQgdnRkX2luaXQo
SW50ZWxJT01NVVN0YXRlICpzKQ0KPj4gICAgICAgICAgdnRkX3NwdGVfcnN2ZF9sYXJnZVszXSAm
PSB+VlREX1NQVEVfU05QOw0KPj4gICAgICB9DQo+Pg0KPj4gLSAgICB2dGRfY2FwX2luaXQocyk7
DQo+PiArICAgIGlmICghcy0+Y2FwX2ZpbmFsaXplZCkgew0KPj4gKyAgICAgICAgdnRkX2NhcF9p
bml0KHMpOw0KPj4gKyAgICAgICAgcy0+aG9zdF9jYXAgPSBzLT5jYXA7DQo+PiArICAgICAgICBz
LT5ob3N0X2VjYXAgPSBzLT5lY2FwOw0KPj4gKyAgICB9DQo+PiArDQo+PiAgICAgIHZ0ZF9yZXNl
dF9jYWNoZXMocyk7DQo+Pg0KPj4gICAgICAvKiBEZWZpbmUgcmVnaXN0ZXJzIHdpdGggZGVmYXVs
dCB2YWx1ZXMgYW5kIGJpdCBzZW1hbnRpY3MgKi8NCj4+ICAgICAgdnRkX2RlZmluZV9sb25nKHMs
IERNQVJfVkVSX1JFRywgMHgxMFVMLCAwLCAwKTsNCj4+IC0gICAgdnRkX2RlZmluZV9xdWFkKHMs
IERNQVJfQ0FQX1JFRywgcy0+Y2FwLCAwLCAwKTsNCj4+IC0gICAgdnRkX2RlZmluZV9xdWFkKHMs
IERNQVJfRUNBUF9SRUcsIHMtPmVjYXAsIDAsIDApOw0KPj4gICAgICB2dGRfZGVmaW5lX2xvbmco
cywgRE1BUl9HQ01EX1JFRywgMCwgMHhmZjgwMDAwMFVMLCAwKTsNCj4+ICAgICAgdnRkX2RlZmlu
ZV9sb25nX3dvKHMsIERNQVJfR0NNRF9SRUcsIDB4ZmY4MDAwMDBVTCk7DQo+PiAgICAgIHZ0ZF9k
ZWZpbmVfbG9uZyhzLCBETUFSX0dTVFNfUkVHLCAwLCAwLCAwKTsNCj4+IEBAIC00MjQxLDYgKzQy
OTAsMTIgQEAgc3RhdGljIGJvb2wNCj52dGRfZGVjaWRlX2NvbmZpZyhJbnRlbElPTU1VU3RhdGUg
KnMsIEVycm9yICoqZXJycCkNCj4+ICAgICAgcmV0dXJuIHRydWU7DQo+PiAgfQ0KPj4NCj4+ICtz
dGF0aWMgdm9pZCB2dGRfc2V0dXBfY2FwYWJpbGl0eV9yZWcoSW50ZWxJT01NVVN0YXRlICpzKQ0K
Pj4gK3sNCj4+ICsgICAgdnRkX2RlZmluZV9xdWFkKHMsIERNQVJfQ0FQX1JFRywgcy0+Y2FwLCAw
LCAwKTsNCj4+ICsgICAgdnRkX2RlZmluZV9xdWFkKHMsIERNQVJfRUNBUF9SRUcsIHMtPmVjYXAs
IDAsIDApOw0KPj4gK30NCj4+ICsNCj4+ICBzdGF0aWMgaW50IHZ0ZF9tYWNoaW5lX2RvbmVfbm90
aWZ5X29uZShPYmplY3QgKmNoaWxkLCB2b2lkICp1bnVzZWQpDQo+PiAgew0KPj4gICAgICBJbnRl
bElPTU1VU3RhdGUgKmlvbW11ID0NCj5JTlRFTF9JT01NVV9ERVZJQ0UoeDg2X2lvbW11X2dldF9k
ZWZhdWx0KCkpOw0KPj4gQEAgLTQyNTksNiArNDMxNCwxNCBAQCBzdGF0aWMgaW50DQo+dnRkX21h
Y2hpbmVfZG9uZV9ub3RpZnlfb25lKE9iamVjdCAqY2hpbGQsIHZvaWQgKnVudXNlZCkNCj4+DQo+
PiAgc3RhdGljIHZvaWQgdnRkX21hY2hpbmVfZG9uZV9ob29rKE5vdGlmaWVyICpub3RpZmllciwg
dm9pZCAqdW51c2VkKQ0KPj4gIHsNCj4+ICsgICAgSW50ZWxJT01NVVN0YXRlICppb21tdSA9DQo+
SU5URUxfSU9NTVVfREVWSUNFKHg4Nl9pb21tdV9nZXRfZGVmYXVsdCgpKTsNCj4+ICsNCj4+ICsg
ICAgaW9tbXUtPmNhcCA9IGlvbW11LT5ob3N0X2NhcDsNCj4+ICsgICAgaW9tbXUtPmVjYXAgPSBp
b21tdS0+aG9zdF9lY2FwOw0KPj4gKyAgICBpb21tdS0+Y2FwX2ZpbmFsaXplZCA9IHRydWU7DQo+
SSBkb24ndCB0aGluayB5b3UgY2FuIGNoYW5nZSB0aGUgZGVmYXVsdHMgbGlrZSB0aGlzIHdpdGhv
dXQgdGFraW5nIGNhcmUNCj5vZiBjb21wYXRzIChtaWdyYXRpb24pLg0KDQpXaWxsIGJ1bXAgdnRk
X3Ztc3RhdGUgLnZlcnNpb25faWQgd29ya3M/DQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4NCj5U
aGFua3MNCj4NCj5FcmljDQo+PiArDQo+PiArICAgIHZ0ZF9zZXR1cF9jYXBhYmlsaXR5X3JlZyhp
b21tdSk7DQo+PiArDQo+PiAgICAgIG9iamVjdF9jaGlsZF9mb3JlYWNoX3JlY3Vyc2l2ZShvYmpl
Y3RfZ2V0X3Jvb3QoKSwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZ0
ZF9tYWNoaW5lX2RvbmVfbm90aWZ5X29uZSwgTlVMTCk7DQo+PiAgfQ0KPj4gQEAgLTQyOTIsNiAr
NDM1NSw3IEBAIHN0YXRpYyB2b2lkIHZ0ZF9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9y
DQo+KiplcnJwKQ0KPj4NCj4+ICAgICAgUUxJU1RfSU5JVCgmcy0+dnRkX2FzX3dpdGhfbm90aWZp
ZXJzKTsNCj4+ICAgICAgcWVtdV9tdXRleF9pbml0KCZzLT5pb21tdV9sb2NrKTsNCj4+ICsgICAg
cy0+Y2FwX2ZpbmFsaXplZCA9IGZhbHNlOw0KPj4gICAgICBtZW1vcnlfcmVnaW9uX2luaXRfaW8o
JnMtPmNzcm1lbSwgT0JKRUNUKHMpLCAmdnRkX21lbV9vcHMsIHMsDQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAiaW50ZWxfaW9tbXUiLCBETUFSX1JFR19TSVpFKTsNCj4+ICAgICAgbWVt
b3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uKGdldF9zeXN0ZW1fbWVtb3J5KCksDQoNCg==

