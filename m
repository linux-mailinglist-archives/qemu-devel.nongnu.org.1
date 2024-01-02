Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B35C78216E3
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 05:29:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKWNG-0004zw-Va; Mon, 01 Jan 2024 23:27:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rKWNC-0004zf-6W; Mon, 01 Jan 2024 23:27:27 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rKWN8-0004JA-GQ; Mon, 01 Jan 2024 23:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704169642; x=1735705642;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nD24LTczWanDnILu+PNxGZPSSv73R3rrcDqfeB5tMK8=;
 b=ZoGw71f9NotOYCu/set6R/1z8RsvpBi+/tf7QmYGPveD049zaOKlFzfG
 LkFZHslm12/r4w60iuO99pKCG2JES/HTqant43RrJtYIgbwwCP3zzdXLY
 Dw1sXH+uWXce8YGpv/JwubXzgCmo4rcV2CEUItOwtdJUcr/QBU46qpYUB
 ra+AcoBXqOWXdTf3A+ChXY6EWbtE9Fk0jxmqwIPuEZOUMNTjth2TaIqAj
 mWy+qk3iyovMcvvZK99BPW0HOZNb1JbBiV0CrQ+cJBq4qVhagm86Rqeb5
 AT9jlY1EUAKsm5BCFyO8n4i8i1KkUcWgru+Ex6nfWfmSdg7RCUber8Fwe w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="15478952"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; d="scan'208";a="15478952"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jan 2024 20:27:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="1026670693"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; d="scan'208";a="1026670693"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 01 Jan 2024 20:27:15 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Jan 2024 20:27:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Jan 2024 20:27:14 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Jan 2024 20:27:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+U1Pxxdh9k8JJqmoGOkyiNikvHEgEbgz5tuScIOA/EAAeNjjTe/gd+MV9DAcFYTksbA35zB+Ku81iu9XHN61WRLA335vpWVZgi0YDVuAa7tBSa3BaNU5RM86OAux8lNv4B24wV+m8xps7FCyv2NI8BOLFnFrCiPp70qOr3OTrsOyeoCbDPy3grOQ8Lh+8qYRecZXeI5VW1UrRXnob4xUYqpXvXuXS0hWz9252duAFIBXRFQFLA8Q/YfCOlZocruoLpk7vmRZXnTy8LwncIwTzSE/BqKVyXzNf75sp7eOQ59vjeNTgXG0LDW3oCFv9MKx6cYPN4sX4zpX/JvuYcUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nD24LTczWanDnILu+PNxGZPSSv73R3rrcDqfeB5tMK8=;
 b=DWq7nGRCR3jWdBwR4h+6lkNTjnOy6sAJcSlg6uSpalInoL0XgdDHNb3BapncaHRDQG7a2W5d49hJsHtLMb2QuAtdBoNF1np3J7i6H8XIUzSa8HZdvC6Cvx1fEgIaoqqWMK0dSkxZ4o/mkAq2jqotjZmsfBWhrtVXq95udkdgX/7Ks4Jil/wLSm8C9nxS94jhyyYU3taXKHj5XQ55nzjocEketyCRwRtWQgoY/bwHgwzMS/rAsBe3pseGS7ZNue/5Y0LDpUjwe3qspn3AXOcz9uEHAB9WwxcGkCnO6kZAIl5cURwExrwxadoBqo20Ep8tfe06y9tkXG07QMN5reAZ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CO1PR11MB4916.namprd11.prod.outlook.com (2603:10b6:303:9c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 04:27:12 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 04:27:12 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Vm9sa2VyIFLDvG1lbGlu?= <vr_qemu@t-online.de>, Alex Williamson
 <alex.williamson@redhat.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-stable@nongnu.org"
 <qemu-stable@nongnu.org>
Subject: RE: [PATCH] hw/vfio: fix iteration over global VFIODevice list
Thread-Topic: [PATCH] hw/vfio: fix iteration over global VFIODevice list
Thread-Index: AQHaOpdBPvFVzWrig0mR6PBiMf4g5LDF7vZw
Date: Tue, 2 Jan 2024 04:27:12 +0000
Message-ID: <SJ0PR11MB674437F64A9154EDD0055A799261A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231229203854.8281-1-vr_qemu@t-online.de>
In-Reply-To: <20231229203854.8281-1-vr_qemu@t-online.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CO1PR11MB4916:EE_
x-ms-office365-filtering-correlation-id: 33677356-b6a7-448b-36c4-08dc0b4b175e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kt+aTzvDqEYSPUWH59R57+f1DRrhmb3KAM8chkMRXDuqLS7qzeEevnKjGVL8+vnEyxYCwbhfTiisE1trqMXxqUsA+y9/Yr2iD+IW/Ps2bZJFsqRF0A+6Ewr6p6zJ2ynu+PguDRh4CBj7N39j1H0lKZk/rUHdEik9Zzq7MmeT/7TU+0SIUokTFP6MNgWpEo2dk36nFvXeWpwryHsXNhzxNc4UxEijUiTfccRk+ERQ5OGjt0ey1dnLv4gKUnwx2HNDg9CBGLnShpE/jGeY3rV8+IryCZfE3oIlFgE3/Z+JDEs4RaTK5H42z6HUAZQPrTySfUg9ToaToIZuFDciJCGzA4TwIdoCjkIIgr7ivQFMM3988IcvUGEIqyNw8BfaQNZqOwBlBTui5zbeRUlwCe20Aa9Xlq82dgwcsz/AMnKIyBgNRArlO85FKQhnf/pF7n3ioAO54QgzusUpqOKG7Ui5H5xpyZ8vCcNlKci9TlkhHa5pS36gw+nlj13FuCJjyuI/K5BGNeRFBkdE1KR4vnKSmMsG2J8acj8ehCReFGTq/YsCLq0AK3/xcVEFNxyVjIdm3jB/B/nB4a1GJlci6ymQzhC2V4queXXxrZn8QPdCY6Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(66574015)(33656002)(26005)(6506007)(9686003)(7696005)(478600001)(966005)(71200400001)(41300700001)(316002)(54906003)(110136005)(66446008)(66946007)(64756008)(76116006)(66476007)(66556008)(8936002)(4326008)(52536014)(8676002)(82960400001)(55016003)(86362001)(122000001)(38100700002)(2906002)(5660300002)(38070700009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnRHQ3RMUUpZVGpJdWVQZGNxd1V2SE1JQ0U0TzczMmliSVlFWUJZb3ZISmZs?=
 =?utf-8?B?RGE1SkJlMXUzK0htYU9lSkkyUTNUNGlmcWRVTkVCYTRlb1c1c2NkWkhmVnpG?=
 =?utf-8?B?dXA0K1NNSUNuK2FVL3F5a3gvK2hRU1d1NXZNT2pyQ0wwSFF4bitWc3hQUmw1?=
 =?utf-8?B?UGtkbVdQdko2UG1YbU4wckF6aUwxeWRXaTRWZGpQd2t4enFlTHR6RjVQM0VK?=
 =?utf-8?B?TVI4dVJ2ZCtYUzN0dlJZTnBRamJQN2xnMTJMdTMvMEQvYWE0VkdmNGxYZWRu?=
 =?utf-8?B?M3Z3bTk2bFl2bFVwYi9vZ3dDdHVDOFR6VHhmbWVsVzVQNExyc0FBS1JNSUF5?=
 =?utf-8?B?eDhSaG5MZzdWWWxibnBZNWF6czNuOXAvSDRCdFpib2VScnEwY2FoYmFMRm5n?=
 =?utf-8?B?SVpMb2JUVTI4ZHpLL3V0d0FDcXFkV0hZd3pTb0p4bGFWYTZVSGdTdWZxNWFt?=
 =?utf-8?B?QmJqRmVwdkMrd0hrTVp6LytPbTdYdkdkbUJQREp2blZQWjFUMjVqYjA0dm1D?=
 =?utf-8?B?WmsrVExRcWhmSjhKbm1ndTJlNDNrUzNFUDBvUW01V3lGbkhZK3FHeFdkZ0Vn?=
 =?utf-8?B?ckpjZUZBeTlRVi8zYkJXdDl4OWdUdFlDRlpyT3dLQWYwcnFGblY2ZHk1V0lr?=
 =?utf-8?B?SnpGR0VoWk9GYWJ5LzVmdkdYTzFQMmhkVzJxWi9pRkhqQ0lCNFVPR1cwclY2?=
 =?utf-8?B?Tjh5RExnK29STHJCN004Ync4cEplaTJ1YTdTNFRXZjdTOW5PUFdDcXdpTG1o?=
 =?utf-8?B?aHdSU1o1eTNxanZnSkdIWGZMVEJXbjI3dHhvWncxSHVlbURnN0tvaGhTckdL?=
 =?utf-8?B?TzJyUGRaNEVGSkttM3RUR2d0RVJjMGh6VDNneHQvNTlLVW5HcTJRWjZyNXFK?=
 =?utf-8?B?TVdGMWxQcEw1aU96RURsTUc4aVpXblFIeVo3Q2Vickl3NXdOYUUrY3ZnSFJC?=
 =?utf-8?B?N2xValZ0Zi93ZlVWWHkvYUhScWdOVUtvT0dCMlZLNUdPTWpSWXFURUpNSDR2?=
 =?utf-8?B?aVVaNUtxUW1xb0FwdWRaOWxDcmorOGFwM2RweVVYeFpLUU5OUjA0UzFtZjZu?=
 =?utf-8?B?VG9GUzNoQjdxRGFWQk16OE5wbzVUc1Y5cHRMSWFyZENrMWR2TVdyR0Y2YW5T?=
 =?utf-8?B?L095b2o1clZHNTE1d2xaYXVWbHRnUTk5YlU2MHpuQ3BPZ1N2WDRMekpRN1cw?=
 =?utf-8?B?N0ttQzNweWRTRHNqZDA1OHVYV3NEZjlPc2hoTEtycG5uRExhRnVSV2hWRGM2?=
 =?utf-8?B?R3hWTmRicGVtdEtRNmthOHhLVTZTK0FZSmQ1c2dETlJTVHhqaGF5S1pXeEY0?=
 =?utf-8?B?TW1sV25pL0hJSWVsclNzVXpYaXp5R0s3TDFHMDdNL2tpTWY0MmF3bytDbzdZ?=
 =?utf-8?B?azNrbmtpMDdxLzVYRHBTQWI0bnNiQlJSQlFNcHdnNWNzeUh0bEhURExuRnJy?=
 =?utf-8?B?cHNCd1B3VDRzcWZObllPb1lxYnV6MVJPSG15djdrS01NdUl5TmRZTmEzNWg3?=
 =?utf-8?B?eWhTVlZnaDV5ZUJqcDUybzR2NkUxYUVtaFZNQk9rK0ZKMlBPRXRnc0tTNklC?=
 =?utf-8?B?VlMrQnRMc3BaNE5YMFVLMnpIZmROY1A3UEZtV0E5djRIeGlzOHFhWkQ5TXE4?=
 =?utf-8?B?VjhCa2prNjlub05nVmJxcXZMRnpPdVZ4VU5Cd1RyQllIbGREemN1UjUwTzFL?=
 =?utf-8?B?OEU3anpTK1h3ZEJYcHZySk5WejFWT3Z1blhMQTYvWVhaNXNQdG9UVlMyTlZM?=
 =?utf-8?B?WXhtekg0YUU2U29nUHpoaFhsanZBbnNnVmM3Z3VFUmtFc2pTSmROT0Z5b3A3?=
 =?utf-8?B?b1BBRXBiRm5MSlVLeVY2ZE1uSmcyR0pTLytuWUNYQTRYZGtWRGVadnNCdlAz?=
 =?utf-8?B?T2ZjWGpuNDBsM0JBRFFIZzdjd3pHeHJ2Tmo4ak1QaFVZbUxKdHhBRE9xdGhy?=
 =?utf-8?B?bWs2VWgzY28yZDdBK25zRmM1RXFQdGl0SmFTUU9YYVpGZlU5TkZGRUZuTnl0?=
 =?utf-8?B?WVNmdmlhOXpoOTFPbHE3UWdOdUR6L0FzSVRJaEhjUFoyUkdXUEV2WWllbHdG?=
 =?utf-8?B?VHMweWNiMkE4TW5mY3hwRFBDTUZocC9nYXgvK0wrNjc2cmFIcmEvckJKaGxV?=
 =?utf-8?Q?yHtk1WjkdU6ViwNdBg4u5ieiq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33677356-b6a7-448b-36c4-08dc0b4b175e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 04:27:12.2126 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q1BRlLeFqW2SjX8iMYwrxc/zM68fPIgkoMDof7KDmPKE+32TRBHG1fhai95HSQFo304aHMCLsQQ6tYvGjZkYSzgSCNAQxif1grjJIW6Jevk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4916
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.246,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFZvbGtlciBSw7xtZWxpbiA8
dnJfcWVtdUB0LW9ubGluZS5kZT4NCj5TdWJqZWN0OiBbUEFUQ0hdIGh3L3ZmaW86IGZpeCBpdGVy
YXRpb24gb3ZlciBnbG9iYWwgVkZJT0RldmljZSBsaXN0DQo+DQo+Q29tbWl0IDNkNzc5YWJhZmUg
KCJ2ZmlvL2NvbW1vbjogSW50cm9kdWNlIGEgZ2xvYmFsIFZGSU9EZXZpY2UgbGlzdCIpDQo+aW50
cm9kdWNlZCBhIGdsb2JhbCBWRklPRGV2aWNlIGxpc3QsIGJ1dCBmb3Jnb3QgdG8gdXBkYXRlIHRo
ZSBsaXN0DQo+ZWxlbWVudCBmaWVsZCBuYW1lIHdoZW4gaXRlcmF0aW5nIG92ZXIgdGhlIG5ldyBs
aXN0LiBDaGFuZ2UgdGhlIGNvZGUNCj50byB1c2UgdGhlIGNvcnJlY3QgbGlzdCBlbGVtZW50IGZp
ZWxkLg0KPg0KPkZpeGVzOiAzZDc3OWFiYWZlICgidmZpby9jb21tb246IEludHJvZHVjZSBhIGds
b2JhbCBWRklPRGV2aWNlIGxpc3QiKQ0KPlJlc29sdmVzOiBodHRwczovL2dpdGxhYi5jb20vcWVt
dS1wcm9qZWN0L3FlbXUvLS9pc3N1ZXMvMjA2MQ0KPlNpZ25lZC1vZmYtYnk6IFZvbGtlciBSw7xt
ZWxpbiA8dnJfcWVtdUB0LW9ubGluZS5kZT4NCg0KUmV2aWV3ZWQtYnk6IFpoZW56aG9uZyBEdWFu
IDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQoNCk15IGZhdWx0LCB0aGFua3MgZm9yIGZpeGlu
ZyENCg0KSSBhbHNvIGRpZ2dlZCBpbnRvIHdoeSBJIGRpZG4ndCByZXByb2R1Y2UgdGhpcyBpc3N1
ZSB3aXRoIHR3byB2ZmlvIGRldmljZXMgYmVmb3JlLg0KVGhpcyBpc3N1ZSBvbmx5IHJlcHJvZHVj
ZSB3aXRoIHR3byB2ZmlvIGRldmljZXMgaW4gb25lIHJlc2V0IGdyb3VwKHNhbWUgc2xvdCBvciBi
dXMpDQpwbHVzIGEgdGhpcmQgdmZpbyBkZXZpY2UgaW4gYSBkaWZmZXJlbnQgcmVzZXQgZ3JvdXAu
IFRoZW4gdGhlIHR3byB2ZmlvIGRldmljZXMgd2lsbA0KbWlzcyByZXNldCBkdWUgdG8gdGhpcyBi
dWcuDQoNCkJScy4NClpoZW56aG9uZw0KDQo+LS0tDQo+IGh3L3ZmaW8vY29tbW9uLmMgfCA4ICsr
KystLS0tDQo+IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
DQo+DQo+ZGlmZiAtLWdpdCBhL2h3L3ZmaW8vY29tbW9uLmMgYi9ody92ZmlvL2NvbW1vbi5jDQo+
aW5kZXggMDhhM2U1NzY3Mi4uM2JhODkyZDdkMyAxMDA2NDQNCj4tLS0gYS9ody92ZmlvL2NvbW1v
bi5jDQo+KysrIGIvaHcvdmZpby9jb21tb24uYw0KPkBAIC03NCw3ICs3NCw3IEBAIGJvb2wgdmZp
b19taWdfYWN0aXZlKHZvaWQpDQo+ICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAgICAgfQ0KPg0K
Pi0gICAgUUxJU1RfRk9SRUFDSCh2YmFzZWRldiwgJnZmaW9fZGV2aWNlX2xpc3QsIG5leHQpIHsN
Cj4rICAgIFFMSVNUX0ZPUkVBQ0godmJhc2VkZXYsICZ2ZmlvX2RldmljZV9saXN0LCBnbG9iYWxf
bmV4dCkgew0KPiAgICAgICAgIGlmICh2YmFzZWRldi0+bWlncmF0aW9uX2Jsb2NrZXIpIHsNCj4g
ICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAgICAgICAgIH0NCj5AQCAtOTUsNyArOTUsNyBA
QCBzdGF0aWMgYm9vbA0KPnZmaW9fbXVsdGlwbGVfZGV2aWNlc19taWdyYXRpb25faXNfc3VwcG9y
dGVkKHZvaWQpDQo+ICAgICB1bnNpZ25lZCBpbnQgZGV2aWNlX251bSA9IDA7DQo+ICAgICBib29s
IGFsbF9zdXBwb3J0X3AycCA9IHRydWU7DQo+DQo+LSAgICBRTElTVF9GT1JFQUNIKHZiYXNlZGV2
LCAmdmZpb19kZXZpY2VfbGlzdCwgbmV4dCkgew0KPisgICAgUUxJU1RfRk9SRUFDSCh2YmFzZWRl
diwgJnZmaW9fZGV2aWNlX2xpc3QsIGdsb2JhbF9uZXh0KSB7DQo+ICAgICAgICAgaWYgKHZiYXNl
ZGV2LT5taWdyYXRpb24pIHsNCj4gICAgICAgICAgICAgZGV2aWNlX251bSsrOw0KPg0KPkBAIC0x
MzY3LDEzICsxMzY3LDEzIEBAIHZvaWQgdmZpb19yZXNldF9oYW5kbGVyKHZvaWQgKm9wYXF1ZSkN
Cj4gew0KPiAgICAgVkZJT0RldmljZSAqdmJhc2VkZXY7DQo+DQo+LSAgICBRTElTVF9GT1JFQUNI
KHZiYXNlZGV2LCAmdmZpb19kZXZpY2VfbGlzdCwgbmV4dCkgew0KPisgICAgUUxJU1RfRk9SRUFD
SCh2YmFzZWRldiwgJnZmaW9fZGV2aWNlX2xpc3QsIGdsb2JhbF9uZXh0KSB7DQo+ICAgICAgICAg
aWYgKHZiYXNlZGV2LT5kZXYtPnJlYWxpemVkKSB7DQo+ICAgICAgICAgICAgIHZiYXNlZGV2LT5v
cHMtPnZmaW9fY29tcHV0ZV9uZWVkc19yZXNldCh2YmFzZWRldik7DQo+ICAgICAgICAgfQ0KPiAg
ICAgfQ0KPg0KPi0gICAgUUxJU1RfRk9SRUFDSCh2YmFzZWRldiwgJnZmaW9fZGV2aWNlX2xpc3Qs
IG5leHQpIHsNCj4rICAgIFFMSVNUX0ZPUkVBQ0godmJhc2VkZXYsICZ2ZmlvX2RldmljZV9saXN0
LCBnbG9iYWxfbmV4dCkgew0KPiAgICAgICAgIGlmICh2YmFzZWRldi0+ZGV2LT5yZWFsaXplZCAm
JiB2YmFzZWRldi0+bmVlZHNfcmVzZXQpIHsNCj4gICAgICAgICAgICAgdmJhc2VkZXYtPm9wcy0+
dmZpb19ob3RfcmVzZXRfbXVsdGkodmJhc2VkZXYpOw0KPiAgICAgICAgIH0NCj4tLQ0KPjIuMzUu
Mw0KDQo=

