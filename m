Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C247A90FA
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 04:38:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj9ZM-0001yB-2w; Wed, 20 Sep 2023 22:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qj9ZK-0001y2-LD
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 22:37:30 -0400
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qj9ZI-0000dg-57
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 22:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695263848; x=1726799848;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LNNMJ37J40+5+qykxr2ngnYKai0KowQs6Pq/Ag0b6Cw=;
 b=RWgPREzZX/TFOhsQOti+dJXUzekrJT5vpa9nGndeBRGxUQgaOYLOwP7m
 QSNWt922iDqpCQEIrN7Yw9OfgiPEqDdyVH/fqfyf2QCWPfUIi2tT3Zdfy
 AvkoWD6mzuwSsam2JyCVRDDkBLDdB/gxugW7qcxt+ARv7EJv/HgztlGsy
 BEfaoj9k+WMtEGpek6HyRTPh4ibM0WOA61nVXaKQf6wT3ttY5V1myxx+V
 q1lUHxf99V36BRpLFF9+X9Vz6Od/i3kFdwQpMnXMpwzdkO3GnABuSfgRF
 wqGHm+tKZby/plBndkMDWNZcJHzI98KzA0TAAn+dw6SYjKwILRLxh/TVQ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="370715621"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="370715621"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 19:37:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="890194938"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="890194938"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Sep 2023 19:36:33 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 19:37:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 19:37:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 19:37:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJvZCaS1vBbdVOv49oHz0rMq4vbMLurgMnBYVxgXpNPoURxZXveWJ9ThFaEadr6o07X/s+3Zzlhoi+XPOgwJ0Ide1XevcjwEyp6LXwuzGaw8Mmwq5DkoHUcTiVhjnUSaoa3uKl52vLYnIv/dXNKMf9VQafkgrwirNRjRZKcqDPAXaZ8QAkaa7/e7ylmFahrMm7sbYKj+UPE1YGFmLuQC8aJN0o/BcCuQDdw1cFGesOuEXEsXSnljedld1eWLu7jhFntXxBwI1Q9aHL2Rtr2WpE/cO8Syrxpc/FTtfG0PG7W4RYTkUUaDv6xj/X0YdzZ8856sUodWncWF5QwI/ypmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNNMJ37J40+5+qykxr2ngnYKai0KowQs6Pq/Ag0b6Cw=;
 b=n/EJXWe+9t0lWTGYcahIQfVVRpgJJBJtvAUKHSKJ62X7rD+XKiLrOQghxpLqYpTubF7ioBzqTZtrMcUlC90aSgaX6/yF/fihtAFlJRxdgOrUmZ+ip7IBlkkjEuu1bVISK9TlCFrJ1Iv/ZjCzPD4T+OWEDsPJvUrMCVJSp/acVRuMnYmGQTUPtUwSpA5vAK5l8sK4QuaVx/TASj9aRlImXS8n8eHujzmT4PdwMhNV/KHgDiUiNr14E2AaEIuiHME9/kZLsBp9qLaMao/IQjbVdmjNTXwUEwf4vywzOhYkdLgVX+q13W9VBohC7AGjvlsOXaHyI+s2C8166xXhJB1xCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7777.namprd11.prod.outlook.com (2603:10b6:930:71::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Thu, 21 Sep
 2023 02:37:19 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 02:37:19 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v1 17/22] util/char_dev: Add open_cdev()
Thread-Topic: [PATCH v1 17/22] util/char_dev: Add open_cdev()
Thread-Index: AQHZ2zBCaKRM1IrqTUiFNyuosRp9+LAjyH0AgADnZ1A=
Date: Thu, 21 Sep 2023 02:37:19 +0000
Message-ID: <SJ0PR11MB6744489F68287E2D1C8ACD0392F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-18-zhenzhong.duan@intel.com>
 <ZQrn5oyrdIXw2A7Y@redhat.com>
In-Reply-To: <ZQrn5oyrdIXw2A7Y@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7777:EE_
x-ms-office365-filtering-correlation-id: 03f788be-7fba-429c-1a85-08dbba4bad2e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MdTO0KOWLOJSvr/LXx3NzkATZJfLlHJlhj2VukVM+k48E+i508JgApc/W2VfkeUAp6idGI3/b73dSGa2FwH68UyshEBua9UWXRqsf5Jias6SV+0dU2V2EjxyZEHDnuTVSD00OKy/trbkw78OlLj+nrjCmiBl8UJV8/LKMIVDhN69LzyUbBx21EIUzqnTL51SD4zzDa+gQBLOvgqlAkJeKD7uS63E+TOUVeKzAqQ17kpK4PRAxv8H0lFrKO9EyvnAvXckVAJanwgczoaItaQsraE7jZx6F6hqlzLN3NKzgG3gEmSM1K64adouqenKbIxJCNnNmNd9Z84OfcCuOsUN0makNTeOIsfmanMsXm0qV393nWNNU6MjIOIzJkEj5SwwiBaEAVUsg8Cx4A7kUaH9DgIiLCoTKYbY+O5wvZGj0NPvGVjnaIDudYDbsyOJGC9F765jHYxJS4JN63vdJ/a5NBLuO6WcE1EPsMXbeJelRw3vAZvUowi9mbWGK2mnEUeLpaEqG1HZSE7w41EUHsCbWLbyoZSKyuAXAT8nZW/PabTL94a6H/MUVZyHICwhtJs7BfvFoBdUq6bkRoQM444g1fG4TEhdfdhRRrQXZYUZ8NU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199024)(186009)(1800799009)(83380400001)(55016003)(7696005)(6506007)(9686003)(33656002)(38100700002)(38070700005)(122000001)(82960400001)(86362001)(26005)(64756008)(2906002)(966005)(8676002)(478600001)(8936002)(5660300002)(52536014)(4326008)(41300700001)(66946007)(54906003)(66556008)(66476007)(66446008)(71200400001)(6916009)(316002)(107886003)(7416002)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1dRbDJCQVA5bER3R3FaVUNXbEhYdEpHVk5hNDZpdGkwREJEOVFJNSs4Y2ph?=
 =?utf-8?B?UjJ3ZGdnekNMdncyUnpqckdpWHBZSGZLUkNheGRZYlh3Vm5tRWQ4OThIMHdF?=
 =?utf-8?B?alRPSWhrVXp5UzF4SUVmOW5QbUJEQ1ZrRnMzUWE4Wm9DNlJPRnlpZW1TcTk5?=
 =?utf-8?B?YkRVb1M1b2paRTN1S0RLcVhzQ1hlS3I3M3VzOHQwNEo0dHZaM200K3BjeE5q?=
 =?utf-8?B?cEpNem13MDgxZTh3b2pmZTY3dXVkNmkvN2dJQ2liRjRoZUtpZGd3aGE5ZjJF?=
 =?utf-8?B?SEZxT3NjK3E3WTFuODJQZks4QWVZZ1lOdDBFa1Q0STROdDdOK3RIeTM5Tll3?=
 =?utf-8?B?Q0dtSnRya1BiYUZoZWl0QXVvc0huWlBKTWV5aXNiM0JpakhaT1Q5NjNpaDNl?=
 =?utf-8?B?Ti8rd3ZIK3lBNzZCazQxbHVaMjZpLzNHbExEcFl6ZGROSE1mRWlFanNVMlFt?=
 =?utf-8?B?dkVVaTVSekpOUXJXajF0V29KNjA5QmsrMUk0aWFkM1hsQkNaSW91SWg3a2kz?=
 =?utf-8?B?QzlxUlp1OVpNRzRDeTlMQTl5ZmNZQ21jUm5SbDJoVmE2MkxKdG1YdERGR1ZC?=
 =?utf-8?B?R2tnaVladjVENWMrcHFNbDhuWnBzSXVwc2FOQS8zck9uZm9qQk96YUkxbGtk?=
 =?utf-8?B?QzI0eFB5SHM3L1J6TEw1bGliVVVBT2YrNlBOdWdjRHZZRXFJeHRvWldNN0FC?=
 =?utf-8?B?TFlwU1NZbEJqVEJFL25Ma1c3M2ZFN3VwWVFySWs2L0tUTG50MksrUDQrcmY1?=
 =?utf-8?B?UnEyRlpuMExXbEN6c0NteGZscEJwbGRRUi9WaVhXU2xoVnMrVjdKMDlvSk5K?=
 =?utf-8?B?SjVEekJXajA2eWFlb040WVFCcHhtdUxLNW9VY2ZIMHg4YlozbVBYdVRtckZS?=
 =?utf-8?B?dUk2QkpFZFd5RmdzTm4zSjRHKzNCSExEUWVrT25HdnZCRWg1b1RvV2R1RnFC?=
 =?utf-8?B?VlBGUE1wYjg1ZnNSK2l6cjZKcGZ1VWxtYzQ1ZFhwT253ZnBCV1U5bkJwTGhD?=
 =?utf-8?B?aHVTaVkrc1FZVGN3ektkUTVnSVV2dkQ1ZDFBSVhabDZ1a0lhK1JtRU9ublRm?=
 =?utf-8?B?b3JrVHB5V2JnYVZFSUdqdEdjd0RHdXVLSFhBQ1FCWGwyNHBnWDFtSEFjTDho?=
 =?utf-8?B?OUZqSVNZa0JNOCtDdUh2dCtScVN6UStxNGF0azJZU2E3MlBOSXFjTnNSbUsw?=
 =?utf-8?B?OFdXbUZ0VWMyNG1OVjFxRHhUWC8vT0FHZ2tiMElxaGN2eFhYSE1kODBtZFQ3?=
 =?utf-8?B?aS9zYWl2WFY0WVhBU1g4UDAvUDNyWVVqcXFYblcwbStMQXpHN3ZnbTYva3M5?=
 =?utf-8?B?WUZCRzh5azRGS0Q5Zk5wMXhGdVNVRG9WZm1uK1l5Mlo2NnBsaGs5anRraWc1?=
 =?utf-8?B?QUp1UzA5SFk5ZXVNNjN5dGw1aFhCZklvWlJGTXNBVHNzeXBiRDV5Y3NTRVI0?=
 =?utf-8?B?QUF1L3U0QnBDdEF1QVEvcWgzYThZdUVWUlBlZFJrbElaRHJWKy8vNnB5K2RN?=
 =?utf-8?B?SW5LWmhTS216eVpaVjZQRmgybm9zTTNmL2hlTzhvY09BRGdQSFlWSnFPOWFo?=
 =?utf-8?B?RTFmczRTeS9TSXRVMmZtc0pxU0c5SHhoK0xiK2FSYVdkVXhJdW1kUkgrS2tu?=
 =?utf-8?B?Y1NFY3UyUWtycXBVVHFXZVdIeE50eHBiUHB6Nk9NV1duREJWZ2owQ2V6eU12?=
 =?utf-8?B?V3B3TFVmOGhYOXowM0pHNUV6L3l0NVpMRkZ1Z1UrK2x4dmZiSzlZZEtQU21O?=
 =?utf-8?B?TU9iVTNpUUpaQWl4OHVUWkZjTGVURXN6bDN2T3RGUUlqRWI2NEg0cnlzS0Js?=
 =?utf-8?B?WUZsdDFXWUR4SGh2eXZjTGY1K0xlWG9EUFd5Zk1MOUYvSGVsYnh0UWRwazVh?=
 =?utf-8?B?TnA5M3Q3MWN1YzJrVTQxVUI5WlI0S3YxUVNuZ3lmOUFFRGhFMTMwd05JZHJn?=
 =?utf-8?B?bTJrbDV0M0c4di9ucytNeWV0LzF1NVdWNEJSQUliUURKZ20rUGJ5cVdYdDQ3?=
 =?utf-8?B?RjBIanhhcWlXbzFpb3pkZUt3UXlGVm1OZ0dQeitjY1d2cFJQSGplM0xJcnZ4?=
 =?utf-8?B?aUFrSFpDdlZJM05ORWk1UU5BUE5nMElsMnlQaEdRYmNzZzc2aXd4YTJBVXpq?=
 =?utf-8?Q?XFW0KsljGXgB6X8quLBYcslCu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f788be-7fba-429c-1a85-08dbba4bad2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 02:37:19.3459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gSJSUWFoi/3yaa8C3PZ4ncLQ1oUjoAgNKKCzpA/JwKx6oKBpNNexTczRehy/HdObDYzSnamqLkv5eoZVbuUZaouyDTlXRqthiou7QbWNVrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7777
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IERhbmllbCBQLiBCZXJyYW5n
w6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+U2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjAs
IDIwMjMgODozOSBQTQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMTcvMjJdIHV0aWwvY2hhcl9k
ZXY6IEFkZCBvcGVuX2NkZXYoKQ0KPg0KPk9uIFdlZCwgQXVnIDMwLCAyMDIzIGF0IDA2OjM3OjQ5
UE0gKzA4MDAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gRnJvbTogWWkgTGl1IDx5aS5sLmxp
dUBpbnRlbC5jb20+DQo+Pg0KPj4gL2Rldi92ZmlvL2RldmljZXMvdmZpb1ggbWF5IG5vdCBleGlz
dC4gSW4gdGhhdCBjYXNlIGl0IGlzIHN0aWxsIHBvc3NpYmxlDQo+PiB0byBvcGVuIC9kZXYvY2hh
ci8kbWFqb3I6JG1pbm9yIGluc3RlYWQuIEFkZCBoZWxwZXIgZnVuY3Rpb24gdG8gYWJzdHJhY3QN
Cj4+IHRoZSBjZGV2IG9wZW4uDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBKYXNvbiBHdW50aG9ycGUg
PGpnZ0BudmlkaWEuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRl
bC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5A
aW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgfCAgNiArKysr
DQo+PiAgaW5jbHVkZS9xZW11L2NoYXJfZGV2LmggfCAxNiArKysrKysrKysrKw0KPj4gIHV0aWwv
Y2hhcmRldl9vcGVuLmMgICAgIHwgNjEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4NCj5Vc2luZyB0aGUgc2FtZSBuYW1pbmcgc2NoZW1lIGZvciB0aGUgLmMgYW5k
IC5oIGlzIHN0cm9uZ2x5IGRlc2lyZWQuDQoNCkdvdCBpdC4NCg0KPg0KPj4gIHV0aWwvbWVzb24u
YnVpbGQgICAgICAgIHwgIDEgKw0KPj4gIDQgZmlsZXMgY2hhbmdlZCwgODQgaW5zZXJ0aW9ucygr
KQ0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL3FlbXUvY2hhcl9kZXYuaA0KPj4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCB1dGlsL2NoYXJkZXZfb3Blbi5jDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4+IGluZGV4IDA0NjYzZmJiNmYuLjc0ZDE4NTkz
ZmUgMTAwNjQ0DQo+PiAtLS0gYS9NQUlOVEFJTkVSUw0KPj4gKysrIGIvTUFJTlRBSU5FUlMNCj4+
IEBAIC0zMzcyLDYgKzMzNzIsMTIgQEAgUzogTWFpbnRhaW5lZA0KPj4gIEY6IGluY2x1ZGUvcWVt
dS9pb3ZhLXRyZWUuaA0KPj4gIEY6IHV0aWwvaW92YS10cmVlLmMNCj4+DQo+PiArY2RldiBPcGVu
DQo+PiArTTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiArUzogTWFpbnRhaW5lZA0K
Pj4gK0Y6IGluY2x1ZGUvcWVtdS9jaGFyX2Rldi5oDQo+PiArRjogdXRpbC9jaGFyZGV2X29wZW4u
Yw0KPj4gKw0KPg0KPg0KPj4gZGlmZiAtLWdpdCBhL3V0aWwvY2hhcmRldl9vcGVuLmMgYi91dGls
L2NoYXJkZXZfb3Blbi5jDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAw
MDAwMC4uZDAzZTQxNTEzMQ0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvdXRpbC9jaGFyZGV2
X29wZW4uYw0KPj4gQEAgLTAsMCArMSw2MSBAQA0KPj4gKy8qDQo+PiArICogQ29weXJpZ2h0IChD
KSAyMDIzIEludGVsIENvcnBvcmF0aW9uLg0KPj4gKyAqIENvcHlyaWdodCAoYykgMjAxOSwgTWVs
bGFub3ggVGVjaG5vbG9naWVzLiBBbGwgcmlnaHRzIHJlc2VydmVkLg0KPj4gKyAqDQo+PiArICog
QXV0aG9yczogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiArICoNCj4+ICsgKiBUaGlz
IHdvcmsgaXMgbGljZW5zZWQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR1BMLCB2ZXJzaW9u
IDIuICBTZWUNCj4+ICsgKiB0aGUgQ09QWUlORyBmaWxlIGluIHRoZSB0b3AtbGV2ZWwgZGlyZWN0
b3J5Lg0KPj4gKyAqDQo+PiArICogQ29waWVkIGZyb20NCj4+ICsgKiBodHRwczovL2dpdGh1Yi5j
b20vbGludXgtcmRtYS9yZG1hLWNvcmUvYmxvYi9tYXN0ZXIvdXRpbC9vcGVuX2NkZXYuYw0KPj4g
KyAqDQo+PiArICovDQo+DQo+U2luY2UgdGhpcyBpcyBHUEwtMi4wLW9ubHksIElNSE8gaXQgd291
bGQgYmUgcHJlZmVycmFibGUgdG8ga2VlcCBpdA0KPm91dCBvZiB0aGUgdXRpbC8gZGlyZWN0b3J5
LCBhcyB3ZSdyZSBhaW1pbmcgdG8gbm90IGFkZCBmdXJ0aGVyIDIuMA0KPm9ubHkgY29kZSwgZXhj
ZXB0IGZvciBzcGVjaWZpYyBzdWJkaXJzLiBUaGlzIG9ubHkgYXBwZWFycyB0byBiZSB1c2VkDQo+
YnkgY29kZSB1bmRlciBody92ZmlvLywgd2hjaWggaXMgb25lIG9mIHRoZSBkaXJzIHN0aWxsIHBl
cm1pdHRpbmcNCj4yLjAtb25seSBjb2RlLiBTbyBJIHRoaW5rIGJldHRlciB0byBrZWVwIHRoaXMg
ZmlsZSB3aGVyZSBpdCBpcyB1c2VkLg0KDQpJJ2xsIGNvcHkgdGhlIG9yaWdpbmFsIGxpY2Vuc2Ug
aGVhZGVyIHRvIHByZXNlcnZlIHRoZSBHUEwgT1IgQlNEIGNob2ljZS4NCkFzIGl0J3Mgbm90IHJl
c3RyaWN0ZWQgYnkgR1BMLTIuMC1vbmx5IG5vdywgSSBwbGFuIHRvIGtlZXAgaXQgaW4gdXRpbC8u
DQpMZXQgbWUga25vdyBpZiB5b3Ugc3RpbGwgcHJlZmVyIHRvIG1vdmUgdG8gaHcvdmlmby8uDQoN
Cj4NCj4+ICsjaWZuZGVmIF9HTlVfU09VUkNFDQo+PiArI2RlZmluZSBfR05VX1NPVVJDRQ0KPj4g
KyNlbmRpZg0KPg0KPlRoaXMgaXMgc2V0IGdsb2JhbGx5IGZvciBidWlsZGluZyBhbGwgZmlsZXMg
aW4gUUVNVQ0KDQpXaWxsIHJlbW92ZSBpdC4NCg0KPg0KPj4gKyNpbmNsdWRlICJxZW11L29zZGVw
LmgiDQo+PiArI2luY2x1ZGUgInFlbXUvY2hhcl9kZXYuaCINCj4+ICsNCj4+ICtzdGF0aWMgaW50
IG9wZW5fY2Rldl9pbnRlcm5hbChjb25zdCBjaGFyICpwYXRoLCBkZXZfdCBjZGV2KQ0KPj4gK3sN
Cj4+ICsgICAgc3RydWN0IHN0YXQgc3Q7DQo+PiArICAgIGludCBmZDsNCj4+ICsNCj4+ICsgICAg
ZmQgPSBxZW11X29wZW5fb2xkKHBhdGgsIE9fUkRXUik7DQo+PiArICAgIGlmIChmZCA9PSAtMSkg
ew0KPj4gKyAgICAgICAgcmV0dXJuIC0xOw0KPj4gKyAgICB9DQo+PiArICAgIGlmIChmc3RhdChm
ZCwgJnN0KSB8fCAhU19JU0NIUihzdC5zdF9tb2RlKSB8fA0KPj4gKyAgICAgICAgKGNkZXYgIT0g
MCAmJiBzdC5zdF9yZGV2ICE9IGNkZXYpKSB7DQo+PiArICAgICAgICBjbG9zZShmZCk7DQo+PiAr
ICAgICAgICByZXR1cm4gLTE7DQo+PiArICAgIH0NCj4+ICsgICAgcmV0dXJuIGZkOw0KPj4gK30N
Cj4+ICsNCj4+ICtzdGF0aWMgaW50IG9wZW5fY2Rldl9yb2J1c3QoZGV2X3QgY2RldikNCj4+ICt7
DQo+PiArICAgIGNoYXIgKmRldnBhdGg7DQo+DQo+Z19hdXRvZnJlZSBmb3IgdGhpcy4uLg0KDQpX
aWxsIGRvLg0KDQo+DQo+PiArICAgIGludCByZXQ7DQo+PiArDQo+PiArICAgIC8qDQo+PiArICAg
ICAqIFRoaXMgYXNzdW1lcyB0aGF0IHVkZXYgaXMgYmVpbmcgdXNlZCBhbmQgaXMgY3JlYXRpbmcg
dGhlIC9kZXYvY2hhci8NCj4+ICsgICAgICogc3ltbGlua3MuDQo+PiArICAgICAqLw0KPj4gKyAg
ICBkZXZwYXRoID0gZ19zdHJkdXBfcHJpbnRmKCIvZGV2L2NoYXIvJXU6JXUiLCBtYWpvcihjZGV2
KSwgbWlub3IoY2RldikpOw0KPj4gKyAgICByZXQgPSBvcGVuX2NkZXZfaW50ZXJuYWwoZGV2cGF0
aCwgY2Rldik7DQo+PiArICAgIGdfZnJlZShkZXZwYXRoKTsNCj4NCj4uLi5hdm9pZHMgdGhlIG5l
ZWQgZm9yIGdfZnJlZSwgYW5kIGFsc28gYXZvaWRzIHRoZSBuZWVkIGZvcg0KPnRoZSBpbnRlcm1l
ZGlhdGUgJ3JldCcgdmFyaWFibGUuDQoNClllcy4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

