Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA9383250E
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 08:32:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQjMD-0002p0-Jv; Fri, 19 Jan 2024 02:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQjM9-0002oj-M2
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 02:32:01 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQjM7-00017V-GJ
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 02:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705649519; x=1737185519;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=u7sZcXsEHcRG/C3B0xGlQ7ohSCa21n03bPdCgWxRkg0=;
 b=byfzy8EIa8u4xhRHTGETWYE5YsxHdCFPIqM/1mrZ37KbOJAmWu4awq80
 8iHVQXZAAufGHPR49QXw5tU5Gq6gnGd+92tVhE2CNm2kotyb87aKEtvYb
 xu94aZMmtDbmgJrbOg30ANaWS/Tq7NDi96n+5lTik2SwNbe21lelsn3g0
 65HVFGk47UQNAAO72ClsVzeCeyo8QKUDi0gp+6SJCThxTBuT9Vv4H5piP
 52kTJwXOxvmsNhDWwntU2jNXcEX7DKnAthmH1rPqaJWCMvU5YgjpmMKpg
 mAuuyWQRWQ0O5we4EpXMCuYJUMHnsnctqtB7NUuCmcyf0VR2WNeaMulf6 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="14040894"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; d="scan'208";a="14040894"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 23:31:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="875304151"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; d="scan'208";a="875304151"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Jan 2024 23:31:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 23:31:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 23:31:55 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 23:31:55 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 23:31:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFX6Vn3EKGO1WANg0qU7kJJJrkmE48PwJNf2lehdHfotxrwijMGtiARh8+kN1700y6kBu0Dg3b5jCNry1bAGqwUbA5S0mGcgx0PWmh7li7klFSGdp7E67JXA9jIz+lJBfGYTsuWHeCx33PWSOwJcbo1UcWai7HbuvdxdgvB6Vo1wWx9FVe5oFEZPYP6LzZTqqkYNXmEodYTKl6NY/zr+7ZaaF/NOdWaXQJGLCXxyyeX668AKObuNFrChqjob/jKQsCiajyAA/nrki9FiuCoynZ5YG/mXhTAXSX/qKyMQIE3TMhQGaO0UjuOyZmqX1jXSbaOzOAgXvY03Wa3hSQHR+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7sZcXsEHcRG/C3B0xGlQ7ohSCa21n03bPdCgWxRkg0=;
 b=ed2CqUMtv6IrwA3bzJbnoT77o/hxZIrA0WwSVSpNm5ts90PaIXthfIMLEzs8iByx+Qm4BVyMsfdbSbnXslhVgVcg3CvFxmukG1o/yTcHGyfpI7giWN7vvn9MiCmeqrIfxRGDgHXit+nRmA9Jmu9qSlN5OtsxULcv8qvKKuIjsCX80UTomPpwOvgDLdIoBWgXbHUKdCvc3c4S7FF9huTlrcqCx3yI88mqgiUexn9flMhuxj9Fh/OFyBjh1FQHe5DlCWMbL+EU3o7aZ7SpcK7G4coqAFAOSVz/8hpDuW9UzCRy1WBGjY7vcTmSaUuSvQ6025vAEU4kQ07JP45tKGbKmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB8384.namprd11.prod.outlook.com (2603:10b6:610:176::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Fri, 19 Jan
 2024 07:31:54 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace%5]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 07:31:54 +0000
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
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH rfcv1 1/6] backends/iommufd_device: introduce IOMMUFDDevice
Thread-Topic: [PATCH rfcv1 1/6] backends/iommufd_device: introduce
 IOMMUFDDevice
Thread-Index: AQHaR5vs9PoNqR9b3kO5arx2FhNKM7DfiG6AgAE6r8A=
Date: Fri, 19 Jan 2024 07:31:53 +0000
Message-ID: <SJ0PR11MB6744950843CB68DB485FF03792702@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-2-zhenzhong.duan@intel.com>
 <180a39fb-aa2b-4dca-9f01-adb4f392b846@redhat.com>
In-Reply-To: <180a39fb-aa2b-4dca-9f01-adb4f392b846@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB8384:EE_
x-ms-office365-filtering-correlation-id: e85ed37a-052b-4ee4-4d11-08dc18c0b5a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YjA6zialIa45+2Se/SLJjglzmXiFATnmPEjmgzulr2AJK7HwMDm5ge2Ia1xdQ8lOhV9gq7LSMA0PRfYo1D6FS1u8TrY2vIL4agp0zg/I6Jvb1DygfppN1c6QtKyBxMIUgM0MAa4kxFzJH1A8apYWaE80fqnC2QIBWJCyFc3rcEVEEzeqV+gUB8DTNvo0LpPSijJ+P4xSm+I1QqJLZ2CDjP+6gwBRcFjd5EjYe1CwmApg9iMqLYHqCkchTBPwm4bbpC9A8IZr49bCsywwlIl8DblHJmCYdrVmLyMWA8CgpnMFjNsyBtyttdYONSk/o8bzma2gYasPBtLUzbBUVzZgFwooWPK+hPRmupnwZlWlRDj1hvoMEmfre5UgA9iYMC0iFgGcmGRvfDHI/qcCJFqsHEPwb6E1EiXMuhCSweTUZJ1oxGmYzGHCswH0IFix+BQYZdoT9PG4wXI919auqM426AF7QyQuzpkzcKx+Z95si0peWHqqIG5DWGOQbc3P0dYmwf331Mp0f8tiTeL8HBl8AoRaN6xvm6JLEr0L5OVfcuPYwDFTwyJbQ4a09gRfPA4dgKKMARhgIUD24NcQubpsTruFl4a1N0OlohPi1vI/QYOPJuOpoXkaIDeraTSBikdD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(346002)(376002)(366004)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(26005)(6506007)(7696005)(71200400001)(9686003)(83380400001)(7416002)(5660300002)(2906002)(52536014)(41300700001)(478600001)(110136005)(4326008)(8676002)(8936002)(66446008)(66476007)(66556008)(66946007)(76116006)(64756008)(54906003)(316002)(82960400001)(33656002)(86362001)(38100700002)(122000001)(38070700009)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eU5ROWN6QUpYRGxweUEwZzB1MllhRDJWdmgzTy9JcjJiNkM0MWpWeVJXdW84?=
 =?utf-8?B?bE5Qa1NzY3J3NGQ2NGEwczE4dEw0VGFYNVgxRUpPRWlxWWF3aHUxYlh5ZzdJ?=
 =?utf-8?B?Q1F2T3lrYjM4SWlNeGVhbUFQYm8zVndQcS9HQUpick1sc0JUY013bDlnZDBi?=
 =?utf-8?B?c2draU9OUVBwMkFqaENQVUkydnhJQmRUakZ6UFp0QnpIUXk0aDd6cTl2ZW1B?=
 =?utf-8?B?cGlSUTQ5Z2tTL1I0Tmh0QnFVV1ZQbEFxWFpYRkpIZnhmRGtxd2E1dExIdUJa?=
 =?utf-8?B?TUI1UE04ZnFqcEREQ1loTkcyU2k2MkpCdzdHODNDNk13citpaHFPM0ZWOVZF?=
 =?utf-8?B?bzJSeENOM2ZYaE52blNuRFQ2amdnOGJmeVpKRSt4U1ptOHpoQVNhWjdDWkMz?=
 =?utf-8?B?c3IyaXoyemxXcmlManE3RExueVlSZ2I5MSt1cmNvQnlSRm9JaUFWM3l5S0JK?=
 =?utf-8?B?OVhFc1FyVmpIeG9YS3FQS096a0ZlYmFxUVRZT1U0c0dIUDV5YmIwdDBNSFZN?=
 =?utf-8?B?QmJXU1lEVFJhRGNPTk1vWmZrM3lCR3djWXhnMlBCSzVEUXd5bi93UlY4aDFI?=
 =?utf-8?B?Z0xKY3E3bUJqNTNpaHJwUWdsa2RQSFZoZGpuMkJsOWxyRHFTbmVsaWhpc25j?=
 =?utf-8?B?ZzZ4czNzc0I3cVpvTDUzak84eEduRjNKSHJTTGlZNHFmclJsLy85WnZyL1hV?=
 =?utf-8?B?eExpTFJrTHRGNnI2NERNbndtdlVDRkZyZ2J0blp5N3pNMjBjTUVKTlhQOGdV?=
 =?utf-8?B?ZUR4R2twZjNMUVc1cEJBUkJ4R21zcm5BV3FseUd1TS9pNVF0Z3JaNUZYV0Jz?=
 =?utf-8?B?NHFJNVdxZ0ozYSt5UEkrR2QzbDdEMk5BMjNyUVdwcGtrL3lzT25IdmxhWkd4?=
 =?utf-8?B?YmUwZXJzVXhIL0ppWHVkWnk5UjNXbHRxRmQwUmFQNEhtSlVTY0xLSndJOXhG?=
 =?utf-8?B?ZkhyNmlXaFJKbGZCSEZPTUFNdTZmK0QxNWI4b3ExRGMwRWNsWEJ1RkZwWTZY?=
 =?utf-8?B?ZXVLRHVnZTZDSkxsNi9vUlZCdHZaY3J6dUx1YTBDRWpoZzlwaU9mSmZTQ1c2?=
 =?utf-8?B?akMyWS9yMVh3d2tVb3FYMkVBWk1UV3B6cHNZZi9XWkc2UGZaamFJQTFBd2ow?=
 =?utf-8?B?cTQvd1NlaU9yemJpbW1VMEtyWk5ldWNSWkNYWHdOQVpraVNqRy9iTnBQbWhi?=
 =?utf-8?B?MmlsdmRnYzEyN0NONm1KNFRiWU9MT0NZR0RPblZOVmdmWFlEWHJlRy9qZnpV?=
 =?utf-8?B?MDJNNDQ1ZjBDNXdwTmk4c0s0MkZQQmlvWVV6aWc5SXpzallxQzRmZnBMTDlE?=
 =?utf-8?B?dnZUZWQ4eTRQdmtLcFBETE1BN1NTUmdzS2R1VDNSaWlQZVUvQUltYXZ6Y1Jr?=
 =?utf-8?B?YlBlK3NtdEhJaXNTb1ViOFZtME0zdm5Ya25NMldtRG5Hb1BYZUJyWnVObGZj?=
 =?utf-8?B?YUZoMjczSXJhRVAxZllVclI0bUdFbld1dmlQY2p6ZDdaWGhadW92S3k5ZWsv?=
 =?utf-8?B?MUI0WlVNS3dWOWtBaG5LWThIU200anFHelNobVFQVkJMeTBqbDFmeCs0Wis4?=
 =?utf-8?B?enhHRmhVa3hoVEMxOVBTK3BvNHRUYTlFR1hzeWRta2xxQmJGdXpBZEdOa3lT?=
 =?utf-8?B?WXhaOG56em5GTnRCKzBDMk13bG5wekRhZ244ZytCc081ZUNBdTVrd2Vhd0Jy?=
 =?utf-8?B?eC92N1lhUXIwUEFyM1hKVW5qODJTK0FIa05SWEpSVFlRRjQ3Y0JxOC8va2ZX?=
 =?utf-8?B?Yk9hajRPNkVSVTRHK1VOWEhOL0h0d1d5a202elJZNElrYzlrUFpEc01aSmVp?=
 =?utf-8?B?Z0Q1MXVNaWNYVUVwZW1ydnpLb21ldVYvYmc4MDhLLzNBdVBoUGpkTFJNWVFK?=
 =?utf-8?B?ZWZYU3JFRGR3TWcxVjNBdDF1WEZQRVIwTUVhYmMrMWpTdG83anpnb1pNblVH?=
 =?utf-8?B?RTBRLzJwcmd2TlFmSnVHa3U3MFJiRlF2ZlY0YVYvTkdiRUQxY29tU2ZKSkUz?=
 =?utf-8?B?Tm1sOC81S21HVGo0T3pHekI1VExxaXcrVnlWekRyajM5U3pGa1IycXNvZHBm?=
 =?utf-8?B?TFZ4MXYrKyt4aDVWd3UxNUs1cDI3cXRKaGNTYjdCQnZDOWRqOTJEOXBGNHJ6?=
 =?utf-8?Q?yKlslEUs0n4x2I4xY9r0vG731?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e85ed37a-052b-4ee4-4d11-08dc18c0b5a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 07:31:54.0111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IByQ78sHJ5kyILU5Ypir8uJiDWjV1VKxSnFmGvRGeMeMtzalbh9UUt+c5//5JKbmeqtr5GUCrNUfmoWQJ4N8EBr/tcRUesNHqKInPwRO3Vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8384
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YxIDEvNl0gYmFja2Vu
ZHMvaW9tbXVmZF9kZXZpY2U6IGludHJvZHVjZQ0KPklPTU1VRkREZXZpY2UNCj4NCj4NCj4NCj5P
biAxLzE1LzI0IDExOjEzLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IElPTU1VRkREZXZpY2Ug
cmVwcmVzZW50cyBhIGRldmljZSBpbiBpb21tdWZkIGFuZCBjYW4gYmUgdXNlZCBhcw0KPj4gYSBj
b21tdW5pY2F0aW9uIGludGVyZmFjZSBiZXR3ZWVuIGRldmljZXMgKGkuZS4sIFZGSU8sIFZEUEEp
IGFuZA0KPj4gdklPTU1VLg0KPj4NCj4+IEN1cnJlbnRseSBpdCBpbmNsdWRlcyBpb21tdWZkIGhh
bmRsZXIgYW5kIGRldmljZSBpZCBpbmZvcm1hdGlvbg0KPj4gd2hpY2ggY291bGQgYmUgdXNlZCBi
eSB2SU9NTVUgdG8gZ2V0IGh3IElPTU1VIGluZm9ybWF0aW9uLg0KPj4NCj4+IEluIGZ1dHVyZSBu
ZXN0ZWQgdHJhbnNsYXRpb24gc3VwcG9ydCwgdklPTU1VIGlzIGdvaW5nIHRvIGhhdmUNCj4+IG1v
cmUgaW9tbXVmZCByZWxhdGVkIG9wZXJhdGlvbnMgbGlrZSBhbGxvY2F0ZSBod3B0IGZvciBhIGRl
dmljZSwNCj4+IGF0dGFjaC9kZXRhY2ggaHdwdCwgZXRjLiBTbyBJT01NVUZERGV2aWNlIHdpbGwg
YmUgZnVydGhlciBleHBhbmRlZC4NCj4+DQo+PiBJT01NVUZERGV2aWNlIGlzIHdpbGxpbmdseSBu
b3QgYSBRT00gb2JqZWN0IGJlY2F1c2Ugd2UgZG9uJ3Qgd2FudA0KPj4gaXQgdG8gYmUgdmlzaWJs
ZSBmcm9tIHRoZSB1c2VyIGludGVyZmFjZS4NCj4+DQo+PiBJbnRyb2R1Y2UgYSBoZWxwZXIgaW9t
bXVmZF9kZXZpY2VfaW5pdCB0byBpbml0aWFsaXplIElPTU1VRkREZXZpY2UuDQo+Pg0KPj4gT3Jp
Z2luYWxseS1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4LmludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpo
ZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICBNQUlO
VEFJTkVSUyAgICAgICAgICAgICAgICAgICAgIHwgIDQgKy0tDQo+PiAgaW5jbHVkZS9zeXNlbXUv
aW9tbXVmZF9kZXZpY2UuaCB8IDMxICsrKysrKysrKysrKysrKysrKysrDQo+PiAgYmFja2VuZHMv
aW9tbXVmZF9kZXZpY2UuYyAgICAgICB8IDUwDQo+KysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+TWF5YmUgaXQgaXMgc3RpbGwgdGltZSB0byBtb3ZlIHRoZSBpb21tdWZkIGZpbGVz
IGluIGEgc2VwYXRlIGRpciwgdW5kZXINCj5odyBhdCB0aGUgc2FtZSBsZXZlbCBhcyB2ZmlvLg0K
Pg0KPlRob3VnaHRzPw0KDQpBbnkgcmVhc29uIGZvciB0aGUgbW92ZW1lbnQ/IEh3IGRpciBjb250
YWlucyBlbnRyaWVzIHRvIGVtdWxhdGUgZGlmZmVyZW50DQpEZXZpY2VzLiBJb21tdWZkIGlzIG5v
dCBhIHJlYWwgZGV2aWNlLiBJdCdzIG1vcmUgYSBiYWNrZW5kLg0KDQpUaGFua3MNClpoZW56aG9u
Zw0K

