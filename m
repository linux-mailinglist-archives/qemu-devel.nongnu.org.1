Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 758EC7F6D9C
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 09:03:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6R8m-0002eb-7B; Fri, 24 Nov 2023 03:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r6R8k-0002eH-4D; Fri, 24 Nov 2023 03:02:18 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r6R8i-0007ZI-3r; Fri, 24 Nov 2023 03:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700812936; x=1732348936;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4bmi0GDFZbMEEMazEviYMbe0oG3w9fyXHvF1EuP46GQ=;
 b=exsa9FZPTqmgFuiqHHrZjHxVKb9F0Tng8hOO9tCusTR1ElwzCh9beQY5
 5BWIJ5fzI9H8Ai261yvDbHgwo3YIZ0uHZ8W91ch/xtpPJ9+ONZ6LS5E/g
 ydG5ob0p5z/0Cul/XuYQZk3r/WhGBSvu+lQbLXgETofl1bpIYzIffwsN/
 BIth+LF8LJRvV9DhlIErdvV+aLYua7Gx2oHRoirk7Q2MexAMUkGfcn/ty
 0lfnnCq+tW2aYsGRGRKGrTv6uUCjUdAOngHr/Sw5SMQWnj4c4BNRkFqdI
 rWa/vKt5/DvYKy3+8ph/PKflwynCZiXP/njYfYlISaJG+fVI1KG2S+KjL Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="382786406"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; d="scan'208";a="382786406"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2023 00:01:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="717277219"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; d="scan'208";a="717277219"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 24 Nov 2023 00:01:40 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 24 Nov 2023 00:01:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 24 Nov 2023 00:01:39 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 24 Nov 2023 00:01:39 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 24 Nov 2023 00:01:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcH9dQrZbkjYzye417d2cp9nb5ArsACHL7dJuIGx4tX4c4yGbYpqxb7cJkw0lM3T8gKKcPrm1YcrfN7gATsei4zogJ2o5PTqcNpW4BpPHxjJjotzJjc9YGrst0JFZe3cbCKC3jUxbX7NjqmsEgXVn2VP9RMJVdBMsun3MjjFwDY4cinFoZf1k5njTEXmXrPjrsPflR6iHMHzccPAtkRzgfGd4gqEcbo+CtrQv+LxHpNiOORsbcl5rxoq4kdSFH/aRSPj0SUB1Wk6mV/79UD2OpTrcN8EVIpZasmhIo1MWB1E60CYFGqJsopFmYif1z4ALlRBOsCSIE0yeyurpMq36w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bmi0GDFZbMEEMazEviYMbe0oG3w9fyXHvF1EuP46GQ=;
 b=n22BBB2DdsgeEGe6Bda+Ma1jzb5MoeW2wjw/vQHD/CBn3nkM5HK1rr224V11EbDAup7CeQxXwWNk85iBhJesY8pvB4JNOvx5u2fambBw4Uavm+UeDpnSY2bFM6KqBsciw886iLz5j+9unMK4Dw2Hy5jwMyGeNoI5zrv8CzWBpxctevoAD2CjlQ/rq81GXL3mrKHEyceXX7PPSFXenLF24y55C7ADJ8oZPLwpPQ0hxP8Gp/Sw57gd9wDfCnQFgpERyRuXZjXD48lSKUYO0vQoLBxjP4ElhjfZbaNKxzg6SnxLDGstm3LXST239a4UNXtrjqxDpLXHHrOduWUXmVjj0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6745.namprd11.prod.outlook.com (2603:10b6:510:1af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 08:01:32 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 08:01:31 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, "open list:PowerPC TCG CPUs"
 <qemu-ppc@nongnu.org>
Subject: RE: [PATCH] hw/ppc: Improve build for PPC VFIO
Thread-Topic: [PATCH] hw/ppc: Improve build for PPC VFIO
Thread-Index: AQHaHdK5y2MYznEAe0iiTj2wR1sQdrCHgwWAgAAuUgCAADmzgIABMZAAgAAAW6A=
Date: Fri, 24 Nov 2023 08:01:29 +0000
Message-ID: <SJ0PR11MB6744E4F7FD52A7CA607B0B1492B8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231123060109.131904-1-zhenzhong.duan@intel.com>
 <dd2db398-908a-46a8-b02b-8418956462cb@redhat.com>
 <8a95349c-4005-484f-b623-a1898a224896@linaro.org>
 <95739695-ce1d-458d-802d-91346cf10025@redhat.com>
 <1df63b54-f93f-4f6d-a917-fab25b9f82bc@redhat.com>
In-Reply-To: <1df63b54-f93f-4f6d-a917-fab25b9f82bc@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6745:EE_
x-ms-office365-filtering-correlation-id: 2edbfbe2-4a59-461f-5d66-08dbecc390bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yzdiksTIThYnw5mrWs9fD1eRZeVQxXXsfM0CTrmtC/9e1Ha0YhE4usANfUQTCESfaYEmlnxFhOM7zMcq1O5FzWrNh2mfBj6eAbhoSwRrpKwMHQ6WI2M4MKdDLuc3QjprRvFYNF2RmLjW6lJzjwpDW4J64cjeYQG7mcrwxUut2gbwZMduDjhMbyMxfTDbz38G48m3SugHTQfiZJj1GuMyKvYS9F2IOJw/8VxYUYAzEgWOHmhPMKKnRpjR7UuRjEh3qzuehci66TaLF12mB5z82LyoruUsouLSGvllagVptPu8+vK/F9qViFUCU4L+CVznKhriHUMXAb5QmLs9NkggUxS6EJ6DfTZY1LN1WpDVLfpyUBlimhfruZRj3GWvWN2e/+tV7fbrGsGV5PN8Yz9bom/bvQ8P/SoBAovpGoXZbFbRLMm7kAGqqnGs+h4sdLEpY1PmsMrkszsEVrl6fW/DeYP32jpDzH5fKa+sSLhHE9VuNaZCKR32pnDGCBO2jqWKiSUxwBInC9J9vKPSGJN2fMpBRR/dYAh2+jWk3xS086SYtc9ryEOs7fyOTju87P5jjpK+df0QM+eIKc2+B9q+FqqZ1bLuV63EBjHAy7Q3dyxtSaRDLNEDjkPepEoaY+xl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(366004)(39850400004)(396003)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38100700002)(82960400001)(122000001)(478600001)(33656002)(41300700001)(8936002)(8676002)(4326008)(86362001)(66476007)(64756008)(54906003)(66946007)(316002)(110136005)(76116006)(66446008)(66556008)(26005)(7696005)(66574015)(83380400001)(6506007)(71200400001)(9686003)(38070700009)(52536014)(2906002)(55016003)(4744005)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkVObElBN1EwcjBSMDFmSWJmd1pUQTBjWkZDSUU1bHZVbUVjZG1SZW00Q3V6?=
 =?utf-8?B?S1RGZnBDQjNQYTJzNTRiVjlDM0tCQXd6WWxFblVUWFFsOHpPU2RGYm5jcWhk?=
 =?utf-8?B?VFR4RWFqWHBkbmxvS085ZUdMQnRtQkYrM3NjVFpyZjFnK01DTTA4VUhieklN?=
 =?utf-8?B?RzZiQ0lUZi9pa3BJbzBwVnMveVpOc3dSRjVIZVNmQ0VOcFNQb1h5L1B6QjdK?=
 =?utf-8?B?YXNPMHBORWwvTE5OWk9SMlhsZTVLOXNHZVd4aUQreDFyR28zdG0rQ25yZ3RX?=
 =?utf-8?B?bWJSL1RiN1FlUzFkV09MRXFzZWJycFZOQXBwNDhMSzdIWFAvMUo1K3oxUHpk?=
 =?utf-8?B?Q2lOWEl6ZjN3MUM5YUhSRFgvK1p4VXhHTUxjb3JjMGlUR1hIMk9aTWhlbWtu?=
 =?utf-8?B?YVh6N2JjM01SMmhSNS93RnRLRjBuSXM0UlpkdWpoUm9YZUUxNWNmQmdqcXJw?=
 =?utf-8?B?U2YrcmM2UWVmc0wwdGZEVGlMMElPWjNNTUdQWEFjVnVGNDUyQVBLOTdnSmRV?=
 =?utf-8?B?bkVxRitmN1JaUFgva3Z3VzZINE9pUnhYWVAzZDVQOHBlNkFCaVFuVDV0bzgz?=
 =?utf-8?B?dW4zOUtHV2gvb1FHOEVNVEhTYlJzeFp5VjV2V0hYYVN4RUI4ajVzb0dUdVFU?=
 =?utf-8?B?eXE3Q1JrUVhDVU14enVvTjUyOFp3NHZJLzZHS21kSG1sd2dsQ0lKY0g2bUZ5?=
 =?utf-8?B?bXNNZXRZZGVDQnEvbFBuOWVleWhOUmwrRDRNTHk0ZVdJVFlXUzhNUzJIQm0y?=
 =?utf-8?B?MDFGdW9jVE8yUHpJYk1Jb3NRNXlRMzhpVnlyUk9uRkpueENURWV2cHNvcXlT?=
 =?utf-8?B?TzI4MmsxVjEvSUY4YVFiUEtPRkVNSVpsamJOV3RkbHZmRlBSK3VSTG5Bdzlp?=
 =?utf-8?B?dDVaQ252dzFMM0Y4cmRoU01HRzlVK0wwTWNQUGpocUlFMCs0NEx0SThVWk9h?=
 =?utf-8?B?aDZ0UnFaVHdXUE1JUHhPWGN2WkJ5Sy8xT2U1V09EbzMyNXJVYThCdzlXVVBy?=
 =?utf-8?B?cDZOck5BMjZLUm9rTitiVEcxekg4TTc4RGFvbWlVS21MMTFOUzhsaUJkTktX?=
 =?utf-8?B?cTgyNkxOR2IrOUo4Q3cxeVpsbjl0NFNjaytweFNoSnV0d2hpcTlxTHBWMEsz?=
 =?utf-8?B?dUtveUpiYXdqRkhTUE9GMzE0azlHcHR2MkpWZ2V2WDUrd21aZnpITXF1cFpG?=
 =?utf-8?B?ZkFrNlV6Q3liUUIzNHE2VFZOVFpvUFhxNGhkWkplWVQwTjZzMTVlTGh0S2dB?=
 =?utf-8?B?Q0ZkdHlUU0h2ZGZXMHdRRkRCanM3Y05wSy9wSW90endsTEVGMmNDT1pMbmdV?=
 =?utf-8?B?OVZKVVJKODJXeVRWelBLNC9Pbm1raXVHMVF4ZnU0MHNncFZURnRRdFBIQmdB?=
 =?utf-8?B?U21PdGQvMjhvWk9tNzNDcDZTWXJvbEZCT2dFdTVybVJsblo5U3FSVEN6bDRK?=
 =?utf-8?B?Q2h3cmI0b3ByWHZWaVNYY093bXFmODFIZS9GbUVxbHRSUkpSdXhYYkZyTzhQ?=
 =?utf-8?B?Q3lYRkxxT2VseTNJcUtreG5WemY4b1ZBbmdyTzZjVlltQ3VObndGSTNDd0pz?=
 =?utf-8?B?WUtWdjMzR3hVWm42QzVTRXRKMFNVQ0JBN1dERHV4QUxXbHRBS3BRdDEwazdB?=
 =?utf-8?B?RWR3Ri9rZWZwYm9jeGNuaTJBN1ZYU1FmUG9YTHlBUUFjOUJEL1NodTBiWEpi?=
 =?utf-8?B?V2VFRzB4S1FzNGlpcjI4a3lOb044a2E5eG1lZnMwWHhWelE5VUExVmV6b1BX?=
 =?utf-8?B?YXZ0WFM1TmkwQ0JGVzJ2MFVrV0FWay93dUxqRXk3bUU3eFA3dVFuWjFUOXFR?=
 =?utf-8?B?dnUxWlhkb2lpQVd6L3Z6aW5SZ1Q0Yjh5SlB5NGphcVgyKzNydktaV1dVUFcw?=
 =?utf-8?B?OXE4S1pueW85aEliRnZxcXZ0dW0wbTQ2dlRPam1XRFZOTWRnQ1ZvYzE0UXBX?=
 =?utf-8?B?R1BqTFh0VXR1VTdqcXJseUd3ZHY3a1l4N3c5a09iZ3FFbVRTRmRGdnIzN1Jo?=
 =?utf-8?B?L2pFSG5UaG5MYlVqa3QvdVQ4STVTZTZvZTcwcVY1cGlLV2xZVmszMUpqS0wv?=
 =?utf-8?B?Qld1ZzlQUmxaOHM3alVidVQ4cUNXeFE2bzY5N0FKQ3lrVTBTUE5acFZhQVhn?=
 =?utf-8?Q?dhIC8NvEVj2QqQLTZk/RF9ml1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edbfbe2-4a59-461f-5d66-08dbecc390bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2023 08:01:29.4099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gF3Suqti8nC9QtvGLIes/K+9i8b2bVDW3RSKWOM94h8PFNkyG2AUYj2ky+OmqerimuROHUpjqNK2VEZDxzGknlVCjd6ktkn5dUJ1E+UVZX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6745
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIE5vdmVtYmVyIDI0LCAyMDIzIDM6NTkg
UE0NCj5TdWJqZWN0OiBSZTogW1BBVENIXSBody9wcGM6IEltcHJvdmUgYnVpbGQgZm9yIFBQQyBW
RklPDQo+DQo+Wmhlbnpob25nLA0KPg0KPj4gSG93IGFib3V0IHdoYXQncyBiZWxvd8KgIGluc3Rl
YWQgPw0KPj4NCj4+DQo+PiBUaGFua3MsDQo+Pg0KPj4gQy4NCj4NCj5JIHdpbGwgcmVzZW5kIHRo
ZSBidWlsZCBmaXggd2l0aCB0aGUgcHJvcG9zYWwgYmVsb3cgc2luY2UgaXQgYWRkcmVzc2VzDQo+
UGhpbCdzIGNvbmNlcm5zLg0KDQpTdXJlLCBhcHByZWNpYXRlZPCfmIoNCg0KVGhhbmtzDQpaaGVu
emhvbmcNCg==

