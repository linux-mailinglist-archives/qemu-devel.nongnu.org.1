Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 281B57E52CD
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 10:44:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0f6B-0008Eh-KJ; Wed, 08 Nov 2023 04:43:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r0f69-0008EJ-60
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:43:45 -0500
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r0f66-0000ND-Qa
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699436622; x=1730972622;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=r+HrI2hTuoZfZDSFpFO05Hcj38ftfCYEEl8hYXSEytE=;
 b=HGtEP0ATXvS+kb19GGuzeCbO0wr+k1reAXLkoLskWlQADvKGfHVQ4Ec8
 eeylfLmtUzGkVRqShXYSPfEJmKif+Iken31ZT9Pyt/snABo0eeJPNNfUf
 zgvK5cOj/2lnKCsC0ogygW1k7i8/p7VcoiGVxun20D/cIbpaw8e+/wT48
 BECeETnfb0HnRQgxUPtt9rWFaD4LEkdEJH4Xm/acdCxS13a6nnCqQ9xvk
 su13CsB0JCMaIC3Rr5k7piBLhxOG2+q3r26xeyQjREeR9CDC9BYDw1XYZ
 1tMPH9Ukh5v5rJwpiVMn/2R4z2eSSvAlzEaWa7btrEw/wh4mCaXFrAg+W g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="456224059"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; d="scan'208";a="456224059"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2023 01:43:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="1010205804"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; d="scan'208";a="1010205804"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Nov 2023 01:43:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 01:43:31 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 01:43:31 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 01:43:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkxQH8cvcCaokzqBrLfNV5R6FlCjphJlmIEnytMzX+6B87JoltaTN8nMwLi7myp3fP7IJMgqqEMbheL6wCKEZMwCPKD8hKg+8JQA3s3NJ6xToOE3LJ9+3vVMnRf6PwehTXgIO7XCX63W4ug6sKBF4L0uZzcLWrpNt/51Dt7A7b5JukAqEqBwASgvtP8TUHOTg1aVoD26McM6B47M08yUBAkbuwSdDGhIWdL/3GJaZ8riPpH/KDMW/X8EFy3+BpvlqObDJKKCYjvoExs9gyF8grlef80JjpavWzXFL1V7lDA0UVmCxCWZmTrk9D3NzxQ5ZKboRXkrSV+9YbHcmECxmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+HrI2hTuoZfZDSFpFO05Hcj38ftfCYEEl8hYXSEytE=;
 b=bTNnMmBY5OvIKWzVUPidByUMO0FvYK05NdwgUAzetSosdxIu7Q7PwyLVr3qIKmuYv60vkVmRCIc0zenqqbJtcr9BXt+cL2wUlkOaRh71yAIrN2gQncmPLI5Y6D4GejqFTHm1DCZGNq+PfhWrrEcPr2XQt6kHa/OeTNWql0YliPVZoMxITqaP3gmAjc+Vxg9jtm/ahQdyuGrSS5a2ZPu1m74evSGMQ5Qs7t99kyxhimNd0X0TlUOHoYRQfsX06fxg68nuwtmRTDGBSOE9xnIgaLDJ83BGAl3JeuTRey/3xsR22VGXTXtg4DkbPShA2+2QHrnEhp6zilDAbZyA6CZr/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW3PR11MB4588.namprd11.prod.outlook.com (2603:10b6:303:54::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 09:43:23 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 09:43:23 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Thomas Huth
 <thuth@redhat.com>
Subject: RE: [PATCH v4 26/41] backends/iommufd: Introduce the iommufd object
Thread-Topic: [PATCH v4 26/41] backends/iommufd: Introduce the iommufd object
Thread-Index: AQHaDV55xw4BryR3ak233G0Yz5k1LbBu4yyAgADmiYCAAGrPgIAAAJQA
Date: Wed, 8 Nov 2023 09:43:22 +0000
Message-ID: <SJ0PR11MB6744851A9B1173353CCA482292A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-27-zhenzhong.duan@intel.com>
 <da7de379-bd8c-47d1-b7bf-412be92a2756@redhat.com>
 <SJ0PR11MB67442D810F397F1CAAC3710A92A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <505b6c74-6404-490b-93b9-9c7449d9eaaf@redhat.com>
In-Reply-To: <505b6c74-6404-490b-93b9-9c7449d9eaaf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW3PR11MB4588:EE_
x-ms-office365-filtering-correlation-id: 631abcca-1af6-4681-3c3f-08dbe03f25ee
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jhCSe4kwaafw2NdU9Oxz3c1PIoayA+Yzbfp1ZjITyGuWnvIYsuVophM7KcLU1a1xS0WJtl58yna22Ip+Boi9EA7Jk7cQ3wZuhWIPmEi9q0HIOg/3Vyi7QTKAsch+zleZ5m50YBVI9kvoRmbwrwdLkT/kgxXLzbCnbnJehp108rszBiahiWtrVNA4+3Ok29ei+muB1dqNF1gFvlbxWTbE6ht7nCy5L/Zb282YU8CgicftlMH0buamzdNg+8xg4AZrmcbEA+rPFIXlBGJ2GteoBd6gb5rYJY4J0epjCPpYFN3dXwTOevNghxmgkylgXtvTR7hGqjTduKgrPJFf+0WYBkJKtfd444uLtUaU9uluWfuyVMzxLQolLkAUdeDQVvEizdyhklB2GCseBPFqOfAGlixpj0T0ix4n2CV7cGGSbcNI7GAG8YXLHkt7hN3lwwZ0NGJC+SrtsR8Xs/3hkC+zuR2SoL13miGtL67pu6bOTGXC00BedVT1pLj3nYL0GU/srMtEANgJoX+SehrSZBaEq0snBDWJ+uFYGLfxgranTImdI+cWaylUL690MEq53ZSM3UuZXNskmAPTVfZHCHtITkq6bow2Qypj6XsrzTZKp3zxH0pYQGzZsBLCBhMQk7bu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(7696005)(6506007)(9686003)(478600001)(71200400001)(83380400001)(26005)(4744005)(2906002)(41300700001)(5660300002)(66556008)(7416002)(66946007)(54906003)(64756008)(66446008)(66476007)(76116006)(110136005)(8676002)(52536014)(316002)(38070700009)(4326008)(8936002)(33656002)(38100700002)(82960400001)(86362001)(122000001)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzFuMzRjU3BLcFMvbnBpaUx1a1RMWmxIRUdwTEJWMzRrdG9lME9OeGp6YkYw?=
 =?utf-8?B?VEhUbmJDSFdaTlJEL2d0c3RFdFdzak5Icm8xYzdxZmlwMEwvYnFVTWxib0k1?=
 =?utf-8?B?Sm1TVWYrZmJxMGNjQndyL2JSQjVBODNMcEUvUzdjcW0zOHY0KzU0ajFtdlE4?=
 =?utf-8?B?dXZ2SUhVODdhRThvVGNKVmQ3blp4RnpzelgxZDFTK1EzSzJ5SnpXN1hwSmc1?=
 =?utf-8?B?cFNSVENWamFkV2ptRDA5ejlldnpZOWJXVXlxQ2JHTjZhY0tONUdSZmVBOVRJ?=
 =?utf-8?B?RUdCSWNZOVdyaDJtMFF3YWdTdkZOcVlmWmVJMHlGOHBkV0JqWTViMWpGOWJt?=
 =?utf-8?B?bi9RR29VbWtyZmRhZVc3R0c3TXB5clVCQy93eUJ5R1UyZEpMbEE1N1NoSE91?=
 =?utf-8?B?bm14amN0TlpYODZJVnJidmlsajEvTzVRT2NEN000RTZDeEM3YmE4eDFneXcz?=
 =?utf-8?B?ZVlPNUhJSnBmRkdPQ25EVmh1VDJHUWxsczV6Nnp5dkdLOGs4RWptalJ6L2pI?=
 =?utf-8?B?UFhhT2hEellNYnBoaENTUTg1b3QxZGh4NityYitKV01vaUIzTmk0M2p4THB2?=
 =?utf-8?B?ZHoyY1BXKzUxRjU4eDBSTncybGZZQlkzWnFvMEtkbXBRQnhmK29rODJWaTNs?=
 =?utf-8?B?TjYxem5USFJqeEY2OVBnRm83VHZReUJyTUtqUGlLMmdueW1VeHQvVUNlMTBL?=
 =?utf-8?B?TzlWeWlTSWo3S0pUd0t6Mk9pSVRsQkxoS0lzbWxib2s1anVocGMzWDdOMnpB?=
 =?utf-8?B?TUdYTXl2RkxsczNzQS9iT0VFblpCaTdmQUJWcllZWkc0MFJraFAyZnBrV05J?=
 =?utf-8?B?WVBYc2VnRVRTckFXYjRtV2RhbnFyU1h4Ykd3WmFXc1ZDSHd3SmZlVzVBYjNG?=
 =?utf-8?B?VWJjdmpLWXh1Y2RjaFNWU0RMYzMrT2E4VEtxd2ViOEkzWGZKQlI3MGFQeHhT?=
 =?utf-8?B?L0dwYXRsUjJuZTJtWkdNQ3hUTlJlL2ZidHIyY0tmSmQ0WWtKTldWYk9XRjAz?=
 =?utf-8?B?VlNDNlB4TzVDa0Zydm5BWUNYb1RYSjN4ZnVNazgyd3dFc0h5VlJYWGRUUzAv?=
 =?utf-8?B?WmVVR3FmZWp2WnlJeldyblE5WkI3dzBBSnRONVM0M1EyMXI0NWR5RjhOOEdn?=
 =?utf-8?B?UHAyc3M2QlFPNElseG5FZ3RrQk00Um1NdXBOS2VWTVluaU9tZTlyK3VYMUs5?=
 =?utf-8?B?RTg2aHdiSWNxMDVHdGVWeTdrSWNUY1ZYWG1wS3o3OGd2L3FQMUZLNWZWUk1Q?=
 =?utf-8?B?Q1o1bEQ3RU9JTE81T3BPbW52UUFQR1ZGR3ZMMGR0NHFzL0xVUkZxd0Zad0h3?=
 =?utf-8?B?YTArQjdRaWx3NEZsSmtiYnljMFd0aHhFRlZGL1k2ZjRLVnNQV1BxeVVETnJq?=
 =?utf-8?B?Y2lKb3pjZzR3dWlPVzlVR2Q4QTM4ZUNxcjk2L0N6MmtqcFpFU1VQU29UclFC?=
 =?utf-8?B?YlUyV0VjL1dhR1VlQWNhd01rS3FYTi9qZk5zbUpKL3VYTElSeTA3cE5vTW52?=
 =?utf-8?B?QkJBU3lYUmwvcVNVSW82SUxOZk1GdWVRQlM1SUdkTGVJYklSZEJQQXZRRG5q?=
 =?utf-8?B?TEwwMHBzZDljOVh5TG9vZ2g4U1FDMmtacWNIU3pzQUZiTFRPbktnVnREZHAy?=
 =?utf-8?B?dGhQWE5JYWMxeitIZWJ5aExzN2thL3duTE1lNnVvUTg5Kzg2NFY0OEhqbGJO?=
 =?utf-8?B?NEpheVRTZ2NnVEJtMWZiQUxXdXpFb1lyOHJyQzRWQUtpcFJYb0xMdW5oUkl5?=
 =?utf-8?B?TFZQS1I1b3BjRTFFN1lqRzhQUUxWVHZHTkVybGFJUEJDUzZjYXhuZ01GU2M0?=
 =?utf-8?B?bUs5YVFYTmc3ZVF0UkdTOHp5MHJ4TW9BRllzUjRmZmQ1TTdKMEVJN3Y4ei9a?=
 =?utf-8?B?c3NOZXg0QjIzNzVScCtrUDBPaU54SzNnNWI4aU5xbzlzdzJxK1ptZ0FMNHFV?=
 =?utf-8?B?NUlDVlplWFBpZGJFbFJHakMrRXJzKzhtZzNMWGF4VUg2b0VXZFNmOWVDcmxT?=
 =?utf-8?B?UmFHS3JEdVV5UTRueUtZMHNLd3hMNlZLRXB2aUFRa2RqZlFOMUM1OC96Nk4x?=
 =?utf-8?B?bHMyZmowU3p3OWVteWdNMUNvTXBUREtYRW9yVzhSYUkydmErenlNQWphM2dV?=
 =?utf-8?B?SGJGYzZXV3lLcGozQzBrMlNMa1hBaE8ydTM2WnBpR2NLWDEwUkZIVnZpV3g5?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631abcca-1af6-4681-3c3f-08dbe03f25ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 09:43:22.6777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SS8xDSppSatNZWlakxYXLz+1uQh+fLpDEM0Jcxe/eo56n35fUAq3thc6COxfFHiTAi27l8plUPDTNncGeHexXmTTtg/lwJQQrLMbGhiNTqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4588
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDgsIDIwMjMgNTo0
MSBQTQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMjYvNDFdIGJhY2tlbmRzL2lvbW11ZmQ6IElu
dHJvZHVjZSB0aGUgaW9tbXVmZCBvYmplY3QNCj4NCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGh3YWRkciBpb3ZhLCByYW1fYWRkcl90IHNpemUpDQo+Pj4+ICt7DQo+Pj4+ICsg
ICAgaW50IHJldDsNCj4+Pj4gKyAgICBzdHJ1Y3QgaW9tbXVfaW9hc191bm1hcCB1bm1hcCA9IHsN
Cj4+Pj4gKyAgICAgICAgLnNpemUgPSBzaXplb2YodW5tYXApLA0KPj4+PiArICAgICAgICAuaW9h
c19pZCA9IGlvYXNfaWQsDQo+Pj4+ICsgICAgICAgIC5pb3ZhID0gaW92YSwNCj4+Pj4gKyAgICAg
ICAgLmxlbmd0aCA9IHNpemUsDQo+Pj4+ICsgICAgfTsNCj4+Pj4gKw0KPj4+PiArICAgIHJldCA9
IGlvY3RsKGJlLT5mZCwgSU9NTVVfSU9BU19VTk1BUCwgJnVubWFwKTsNCj4+Pj4gKyAgICB0cmFj
ZV9pb21tdWZkX2JhY2tlbmRfdW5tYXBfZG1hKGJlLT5mZCwgaW9hc19pZCwgaW92YSwgc2l6ZSwg
cmV0KTsNCj4+Pj4gKyAgICAvKg0KPj4+PiArICAgICAqIFRPRE86IElPTU1VRkQgZG9lc24ndCBz
dXBwb3J0IG1hcHBpbmcgUENJIEJBUnMgZm9yIG5vdy4NCj4+Pj4gKyAgICAgKiBJdCdzIG5vdCBh
IHByb2JsZW0gaWYgdGhlcmUgaXMgbm8gcDJwIGRtYSwgcmVsYXggaXQgaGVyZQ0KPj4+PiArICAg
ICAqIGFuZCBhdm9pZCBtYW55IG5vaXN5IHRyaWdnZXIgZnJvbSB2SU9NTVUgc2lkZS4NCj4+Pg0K
Pj4+IFNob3VsZCB3ZSBhZGQgYSB3YXJuX3JlcG9ydCgpID8NCj4+DQo+PiBUaGUgcHVycG9zZSBv
ZiBjaGVja2luZyAicmV0ICYmIGVycm5vID09IEVOT0VOVCIgaXMgdG8gYXZvaWQgbWFueQ0KPj4g
ZXJyb3JfcmVwb3J0KCkgZm9yIFBDSSBCQVJzLCBJZiB3ZSBhZGQgd2Fybl9yZXBvcnQoKSwgdGhl
cmUgd2lsbCBzdGlsbCBiZQ0KPj4gbWFueSBwcmludCBmb3IgUENJIEJBUnMuDQo+DQo+YSB0cmFj
ZSBldmVudCB0aGVuID8NCg0KR29vZCBpZGVhLCB3aWxsIGRvLg0KDQpUaGFua3MNClpoZW56aG9u
Zw0K

