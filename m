Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BE37D3978
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 16:38:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quw2l-0002Te-JZ; Mon, 23 Oct 2023 10:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1quw2i-0002Q5-L3
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 10:36:32 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1quw2f-0005LM-ET
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 10:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698071789; x=1729607789;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BA3c1GSKna7ocMGDzv/r+/vFX91s0/aKFHYIA+az23I=;
 b=eFCbZKLCM2nJe+PHhDr0oOPcEdOqiJfA7ZqgLy7hiIk2CsCzur3NDniE
 3XZXNsULOCE01Fx2sAesbqK4QOaRV+6XFLfxbeFeuOL0oUUxAec2+p5R0
 lE0Qv6DxVBF3rA95ZhTeta4uJJYD6Y4//d4wpV0Ov8V4FMvvs3wmQh6GL
 WyC5QDjCF5wpFr3Em2In6ROUCoSIdPtQb5vXfHDUCc+wCKZg7qHDkS4FV
 9gvrqxka2WV+84IFum4bbOSHGg/TpdliFhqSVp26gzsoatkf2XdFt1N7d
 nkvSu3PdMI1rNEbdoW3M1CtZQ7wLTMI3zTeRbA+PNBgaCM5/4FKfaV37Z g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="390741437"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; d="scan'208";a="390741437"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2023 07:36:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="823978490"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; d="scan'208";a="823978490"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Oct 2023 07:36:23 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 07:36:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 07:36:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 07:36:22 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 07:36:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCtzxqOPEluXlJ86UfFCmVdRJ8OIUfYDjxeIRbg8paTgP0ctUdq2qP2vWnpK5nwTZkRXs+wF4arxRPtkip17eXhHnmMr2y+qD6q2D4WKuy9NdRtMVL2ywYw4m+VvfJNKcYzTUGktT/wL2V/bhoyhK5xR6UNzrEVd16YcRerATLSX2zwb6fy/+wbLxSSDXMIpt1M01iU5TtYJnh6vTYsd6jNsZvUM1KC5ZRH62iq8uPscl5Ija4dE12XaU0C8CykKSYSl4VR7V5wZqi9X9XvVjVsFazW5/jGyIdfZfv+gnzsb4DAyK6N39SPhrqCALI1zKjV3cKaDIIzsd9y/Zriozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BA3c1GSKna7ocMGDzv/r+/vFX91s0/aKFHYIA+az23I=;
 b=hPiSaNTOvedjUboy3+yxyydN3x/D/D2p9T/oMzCfZZ21nJFW3cD8UJ+yM4KTnZvtZLKP9KINFFRfNQdym7j92h+ZPslMqJBJxfvdUsU2chId+VVz8t+4qgt6bVz839s8kd7+BF3hdfAaFz2r/vj1aWhPd7n9zeWYKUm75H2kpKRRdorugeGuhW4Rlsu7qnGnr5rOQU8Scn2rCu+oE9bw7TwsJCXdfJ6v26nZZXx2q8oob7vYP2yLRGv38Ky3EVfbVz3poxyHeczgYZ7VCstHp1weJ+tPrm3CGZ8o0qpxWFRzW7WyzMjXz7bVNy50r6msIY8nE41DRv+ILfNKgPLO+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB4388.namprd11.prod.outlook.com (2603:10b6:a03:1c9::17)
 by SN7PR11MB7440.namprd11.prod.outlook.com (2603:10b6:806:340::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 14:36:17 +0000
Received: from BY5PR11MB4388.namprd11.prod.outlook.com
 ([fe80::a164:ef88:9f1a:8519]) by BY5PR11MB4388.namprd11.prod.outlook.com
 ([fe80::a164:ef88:9f1a:8519%3]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 14:36:17 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "leobras@redhat.com"
 <leobras@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zou,
 Nanhai" <nanhai.zou@intel.com>
Subject: RE: [PATCH 0/5] Live Migration Acceleration with IAA Compression
Thread-Topic: [PATCH 0/5] Live Migration Acceleration with IAA Compression
Thread-Index: AQHaAmKFMfJOhFrqz0aucJcr+N/dnbBQ/WaigAA1hgCAAAi9gIAAAmkAgAW4zJCAADwXgIAALNVQ
Date: Mon, 23 Oct 2023 14:36:16 +0000
Message-ID: <BY5PR11MB4388E7499CC21519B8B6C74AA3D8A@BY5PR11MB4388.namprd11.prod.outlook.com>
References: <20231018221224.599065-1-yuan1.liu@intel.com>
 <87cyxa6dso.fsf@secure.mitica> <ZTFCnqbbqlmsUkRC@redhat.com>
 <ZTFJ84SnSOAcU5gY@x1n> <ZTFL+N3mxESxXpfv@redhat.com>
 <BY5PR11MB4388F9495DD42ACCFB980A6CA3D8A@BY5PR11MB4388.namprd11.prod.outlook.com>
 <ZTZLI1r+U5EbX12E@redhat.com>
In-Reply-To: <ZTZLI1r+U5EbX12E@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB4388:EE_|SN7PR11MB7440:EE_
x-ms-office365-filtering-correlation-id: d03779e3-0cbe-476a-2437-08dbd3d56a57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w2TNBMG8yX8Uk3+oMokpiC4g1V6VGergVt4PRIQlDgu3xbRUmhIBg2SpRJMOZ0Ffqu9mKfUg5jK2oJRLswZugI/4pEqVpZdB6OrdSLtYr7FE5Bn1nmH/FMji8XHzbpS277dAmVXXzky60CUxTJLH/fUT2+EZeS/hHFojEofsIZSHcvSy3nX5RKIjy1nAzWH/L0mB4YogSgcEBh50b7SokRv+xdvLEjKqZaZdjDqRh9QTsUXcdSLYxQQ0DICMVDpC1BhqQcPBDPm+MxYvjec4TdyXZahkF/cCqPs4iMRcArX0mfgrJ+LLBPmjjNCS5kCVZyK7GtNNJQOcGhQ+uvosEHqfsSQrdH9Nu74sMPrZwdzm/1GKk1EALOlCglaoGt7ZRkWTSMDe/V9DJ656Sl4oigVBzQUy6ml9i7MqQDPy8xdMV0czyV+JsKZXpDZPo18CWdyXtk9q2ZPJLsGCqlvXiFJsbT9qlMbz0gOgdM4NoRSMGJ97prLLxPLiyw5X43y8O52Ffs5DfRVB0Z79jcduavkxraDJ/Uo0Ifce1CcwC9glHLc5hlrhEa7xc+g4IBdzinxc8aFCFy0RMlCCxXFwLkEd8I7tukAtSlCqVyeWhomOrCCJwEa2nbOmHEJOwhBIp9+nFQkiSqqtEZufxa4xLg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4388.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(366004)(346002)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66899024)(55016003)(86362001)(66946007)(54906003)(76116006)(66446008)(66556008)(66476007)(64756008)(41300700001)(6916009)(316002)(7696005)(9686003)(6506007)(5660300002)(966005)(478600001)(52536014)(33656002)(4326008)(8936002)(71200400001)(2906002)(26005)(122000001)(38100700002)(107886003)(53546011)(82960400001)(8676002)(83380400001)(38070700009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUhpbCtSZEQ2U051SmxnSlQ2VjFpSUhnYndWTlA0VWxMSUY0UjVseXZSUW9H?=
 =?utf-8?B?dW5zVlFDUG1zaEFIbktBekFqcUhxYkphUEl6ejRDY0RMZVZONlNCWW0vdHQv?=
 =?utf-8?B?Tm9NcmVLK2FpOUxCSVJacnQxTENQL2lsUkdJY3BuQ3JNMDd1bGQrMFZ6T3J4?=
 =?utf-8?B?VGZ0dkJVZWsxNE1jKzFTMW84d3VRSkhIZzZxdjB2WlRML3hpa1oyU1VoWDNN?=
 =?utf-8?B?Zk1Md2N6Y25zSXhiekE1Vm8wV25vTUw4VVdGTW1mMkhnVC91dVFrYmtONEMw?=
 =?utf-8?B?VFJxY2lXOFdSd3NFcU54SWYzQXJaaFNobmhwamgvRGQ2QkZSUXhPWEdmUEV6?=
 =?utf-8?B?dkxVRXlmWFJGT2ZsSmVQR1c5R2FiZ0Exb0dVWXNKWlYraDE1K21RU3l3YlF1?=
 =?utf-8?B?c1VReXpZSFBEeUxHNjdzSFFNTmJDUHpaR21GNk9kcGx3NnpNQUdiSzE2VFlj?=
 =?utf-8?B?dWtwZlMxUkN0bFRFWWtVdUh3cmxlNUx5bktoYkFiVXJqZzN1RTEyNnhUUGZj?=
 =?utf-8?B?eEVDK1gySUR6bXNpc2ZBUVlaSGpRZmlNN3ZBS3FwVlVqUjJmajJ3eVFlUFRa?=
 =?utf-8?B?ZnR6QmgyTHZ0VGFsNTk0Tlk4RitlQzg3WnEyeU1wVlFtc1Q2MGJrWmxlZzB1?=
 =?utf-8?B?amppd2k5TXlMTW54TnNtU0dzanBxT2Y5YjJNRlJwT0JUangwOTBJMjdwdUJy?=
 =?utf-8?B?emtBSW1Tc0JuYzAyc3RyOExkK241akxVZFBQWjhsb01PWUVicko0bk1HYmtG?=
 =?utf-8?B?YTJTQWp1eDA4TUF6d3FqeTRsL2cxMis2NWJ6cjlHdnNEZ0NocTZ3cURyUEN2?=
 =?utf-8?B?ZEtBZm1rRHY5ajlmOTVCMGIyQjZmRDRSSnBTbUgzRmw0TzgxMHkrN0R4c2Vv?=
 =?utf-8?B?Vlo5R0ZsZlFPbmd3TTdxOE15dGkyS2trRHc1T3ZUaHh5S3JsUDB1LzErZ2hw?=
 =?utf-8?B?czBtckxST2xuQzVtMU9yZlEzcnBKUHkyb3JmSW12V2xqeDdiVGNHUHlCQ1FJ?=
 =?utf-8?B?a3ZGYmp5YjFwRHF1azB2ZSs0Z1JKNG82cEU2SjRxT21HZk5iajZhT1c1YWRY?=
 =?utf-8?B?ZkhFWFRBTDZ3aXMyNDUvQ1lFak1FZVkvakJUWkg1VEt4c1NBSEJya0cyWUlz?=
 =?utf-8?B?eVJ3b1pHdHRMUHZhRjBOMmN5dWQ0YmNNRXQ1RTR4MUk5OVUweXlFMDAzUC9P?=
 =?utf-8?B?K3lWbFREQnR1NzY3MmkxUzlwZzVEU20rZTVOMmE0dUdLUlBGN2llTHBWQUlB?=
 =?utf-8?B?VDFIejJPallzU1Y0d3RwdjZTTGpUdHRUU0tRWjY1OUpQL1BRL3ZsNEJYZjRT?=
 =?utf-8?B?VzlUZEF2bDhrc01hdmI2bVNHMVc3UUhEcDRQL2FnZTF0Yi9TMGVtVERXUDlh?=
 =?utf-8?B?WjFXL0hrRE9OSkVheW8zdE9mckFOU01CSUtxRGFTYjF3ck1LWWJUcWlIVnAr?=
 =?utf-8?B?RnNqRjEzVW1XY2U4dWtBV0NZbDVPQTRoOXF3Wkl1M09TSVZ4MjJMTjMrdDNa?=
 =?utf-8?B?VktMN2k2NHZ0MGtzRE5VcHdpc3pRQjVmTU9teFJNLzFPV1lGS3BrUGw5cnNh?=
 =?utf-8?B?Z2R0WEF5d0F4dExhbFlzTkczcFNOTlRaUHhaYngyQmtpTGFyUXp5U0dybjlJ?=
 =?utf-8?B?VkpSU2RlT3Jia2s3aCt6TnVldE5uNmhBemZYcllkVE9aZXYvSm5LcWJKNXhV?=
 =?utf-8?B?TDkrVUtLNlpPamVUTjVHOE1hK3Exc3ZBMmdxdG53aGhxQzF3Rk52Y1pEdFpQ?=
 =?utf-8?B?VWtXZzF4bzl2Qno2Qk40OXd2WDU4SGlmb0lTVXh1NVlHb0QwLzdYR0h0TWtK?=
 =?utf-8?B?K0gwdlJqWHZHTm1GNlVST1ZYbDIrS2VuWGhocnM0SmRUYkxIbjBxQkE5SFlz?=
 =?utf-8?B?MUYxT1RNWS90Mi9sYldKRk1nTWVuQ0tsN01sTm9TRU1UcncrM3dRTU11Tzhz?=
 =?utf-8?B?ZWVjZENadnIydE9qV1R1Z1dSZzZORFkwR1VnZjcvTW5EdGs4MTFkWUNHck83?=
 =?utf-8?B?a2lHZzVrUUszUFhnN3J0dEs5OWRKVk45SnhUcnpkUmRLbGFLajd2cTMrdFlS?=
 =?utf-8?B?U0c0WGpjR0FKS1BuT1dCOTJML0VkcWNiRTdhak1PMjlCcU14ZlNva2ZsTU9E?=
 =?utf-8?Q?kLvYMobiM7sletr4mqSzJKKEb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4388.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03779e3-0cbe-476a-2437-08dbd3d56a57
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 14:36:16.8117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cayUbP5GVSvFBQNpKHw9j11BYvln6jeT4aE8kHngl3P/AW2+kbMGmxhwiHL3Z4BvUsWvst38e35xiyRXeWNMDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7440
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.65; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5pZWwgUC4gQmVycmFuZ8Op
IDxiZXJyYW5nZUByZWRoYXQuY29tPg0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIgMjMsIDIwMjMg
NjozMCBQTQ0KPiBUbzogTGl1LCBZdWFuMSA8eXVhbjEubGl1QGludGVsLmNvbT4NCj4gQ2M6IFBl
dGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT47IEp1YW4gUXVpbnRlbGEgPHF1aW50ZWxhQHJlZGhh
dC5jb20+Ow0KPiBmYXJvc2FzQHN1c2UuZGU7IGxlb2JyYXNAcmVkaGF0LmNvbTsgcWVtdS1kZXZl
bEBub25nbnUub3JnOyBab3UsDQo+IE5hbmhhaSA8bmFuaGFpLnpvdUBpbnRlbC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMC81XSBMaXZlIE1pZ3JhdGlvbiBBY2NlbGVyYXRpb24gd2l0aCBJ
QUEgQ29tcHJlc3Npb24NCj4gDQo+IE9uIE1vbiwgT2N0IDIzLCAyMDIzIGF0IDA4OjMzOjQ0QU0g
KzAwMDAsIExpdSwgWXVhbjEgd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+ID4gRnJvbTogRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4N
Cj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDE5LCAyMDIzIDExOjMyIFBNDQo+ID4gPiBU
bzogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0KPiA+ID4gQ2M6IEp1YW4gUXVpbnRlbGEg
PHF1aW50ZWxhQHJlZGhhdC5jb20+OyBMaXUsIFl1YW4xDQo+ID4gPiA8eXVhbjEubGl1QGludGVs
LmNvbT47IGZhcm9zYXNAc3VzZS5kZTsgbGVvYnJhc0ByZWRoYXQuY29tOyBxZW11LQ0KPiA+ID4g
ZGV2ZWxAbm9uZ251Lm9yZzsgWm91LCBOYW5oYWkgPG5hbmhhaS56b3VAaW50ZWwuY29tPg0KPiA+
ID4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzVdIExpdmUgTWlncmF0aW9uIEFjY2VsZXJhdGlvbiB3
aXRoIElBQQ0KPiA+ID4gQ29tcHJlc3Npb24NCj4gPiA+DQo+ID4gPiBPbiBUaHUsIE9jdCAxOSwg
MjAyMyBhdCAxMToyMzozMUFNIC0wNDAwLCBQZXRlciBYdSB3cm90ZToNCj4gPiA+ID4gT24gVGh1
LCBPY3QgMTksIDIwMjMgYXQgMDM6NTI6MTRQTSArMDEwMCwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3
cm90ZToNCj4gPiA+ID4gPiBPbiBUaHUsIE9jdCAxOSwgMjAyMyBhdCAwMTo0MDoyM1BNICswMjAw
LCBKdWFuIFF1aW50ZWxhIHdyb3RlOg0KPiA+ID4gPiA+ID4gWXVhbiBMaXUgPHl1YW4xLmxpdUBp
bnRlbC5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBIaSwNCj4gPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+ID4gSSBhbSB3cml0aW5nIHRvIHN1Ym1pdCBhIGNvZGUgY2hhbmdlIGFpbWVkIGF0IGVu
aGFuY2luZyBsaXZlDQo+ID4gPiA+ID4gPiA+IG1pZ3JhdGlvbiBhY2NlbGVyYXRpb24gYnkgbGV2
ZXJhZ2luZyB0aGUgY29tcHJlc3Npb24NCj4gPiA+ID4gPiA+ID4gY2FwYWJpbGl0eSBvZiB0aGUg
SW50ZWwgSW4tTWVtb3J5IEFuYWx5dGljcyBBY2NlbGVyYXRvciAoSUFBKS4NCj4gPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ID4gRW5hYmxpbmcgY29tcHJlc3Npb24gZnVuY3Rpb25hbGl0eSBkdXJp
bmcgdGhlIGxpdmUgbWlncmF0aW9uDQo+ID4gPiA+ID4gPiA+IHByb2Nlc3MgY2FuIGVuaGFuY2Ug
cGVyZm9ybWFuY2UsIHRoZXJlYnkgcmVkdWNpbmcgZG93bnRpbWUNCj4gPiA+ID4gPiA+ID4gYW5k
IG5ldHdvcmsgYmFuZHdpZHRoIHJlcXVpcmVtZW50cy4gSG93ZXZlciwgdGhpcw0KPiA+ID4gPiA+
ID4gPiBpbXByb3ZlbWVudCBjb21lcyBhdCB0aGUgY29zdCBvZiBhZGRpdGlvbmFsIENQVSByZXNv
dXJjZXMsDQo+ID4gPiA+ID4gPiA+IHBvc2luZyBhIGNoYWxsZW5nZSBmb3IgY2xvdWQgc2Vydmlj
ZSBwcm92aWRlcnMgaW4gdGVybXMgb2YNCj4gPiA+ID4gPiA+ID4gcmVzb3VyY2UgYWxsb2NhdGlv
bi4gVG8gYWRkcmVzcyB0aGlzIGNoYWxsZW5nZSwgSSBoYXZlDQo+ID4gPiA+ID4gPiA+IGZvY3Vz
ZWQgb24gb2ZmbG9hZGluZyB0aGUgY29tcHJlc3Npb24NCj4gPiA+IG92ZXJoZWFkIHRvIHRoZSBJ
QUEgaGFyZHdhcmUsIHJlc3VsdGluZyBpbiBwZXJmb3JtYW5jZSBnYWlucy4NCj4gPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ID4gVGhlIGltcGxlbWVudGF0aW9uIG9mIHRoZSBJQUEgKGRlKWNvbXBy
ZXNzaW9uIGNvZGUgaXMgYmFzZWQNCj4gPiA+ID4gPiA+ID4gb24gSW50ZWwgUXVlcnkgUHJvY2Vz
c2luZyBMaWJyYXJ5IChRUEwpLCBhbiBvcGVuLXNvdXJjZQ0KPiA+ID4gPiA+ID4gPiBzb2Z0d2Fy
ZSBwcm9qZWN0IGRlc2lnbmVkIGZvciBJQUEgaGlnaC1sZXZlbCBzb2Z0d2FyZSBwcm9ncmFtbWlu
Zy4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBBZnRlciByZXZpZXdpbmcgdGhlIHBhdGNoZXM6
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gLSB3aHkgYXJlIHlvdSBkb2luZyB0aGlzIG9uIHRv
cCBvZiBvbGQgY29tcHJlc3Npb24gY29kZSwgdGhhdCBpcw0KPiA+ID4gPiA+ID4gICBvYnNvbGV0
ZSwgZGVwcmVjYXRlZCBhbmQgYnVnZ3kNCj4gPiBTb21lIHVzZXJzIGhhdmUgbm90IGVuYWJsZWQg
dGhlIG11bHRpZmQgZmVhdHVyZSB5ZXQsIGJ1dCB0aGV5IHdpbGwgZGVjaWRlDQo+IHdoZXRoZXIg
dG8gZW5hYmxlIHRoZSBjb21wcmVzc2lvbiBmZWF0dXJlIGJhc2VkIG9uIHRoZSBsb2FkIHNpdHVh
dGlvbi4gU28gSSdtDQo+IHdvbmRlcmluZyBpZiwgd2l0aG91dCBtdWx0aWZkLCB0aGUgY29tcHJl
c3Npb24gZnVuY3Rpb25hbGl0eSB3aWxsIG5vIGxvbmdlciBiZQ0KPiBhdmFpbGFibGU/DQo+ID4N
Cj4gPiA+ID4gPiA+IC0gd2h5IGFyZSB5b3Ugbm90IGRvaW5nIGl0IG9uIHRvcCBvZiBtdWx0aWZk
Lg0KPiA+IEkgcGxhbiB0byBzdWJtaXQgdGhlIHN1cHBvcnQgZm9yIG11bHRpZmQgaW5kZXBlbmRl
bnRseSBiZWNhdXNlIHRoZQ0KPiA+IG11bHRpZmQgY29tcHJlc3Npb24gYW5kIGxlZ2FjeSBjb21w
cmVzc2lvbiBjb2RlIGFyZSBzZXBhcmF0ZS4NCj4gDQo+IFNvIHRoZSBjb3JlIHF1ZXN0aW9uIGhl
ciAoZm9yIG1pZ3JhdGlvbiBtYWludGFpbmVycykgaXMgd2hldGhlciBjb250cmlidXRvcnMNCj4g
c2hvdWxkIGJlIHNwZW5kaW5nIGFueSB0aW1lIGF0IGFsbCBvbiBub24tbXVsdGlmZCBjb2RlLCBv
ciBpZiBuZXcgZmVhdHVyZXMNCj4gc2hvdWxkIGJlIGV4Y2x1c2l2ZWx5IGZvciBtdWx0aWZkID8N
Cj4gDQo+IEkgZG9lc24ndCBtYWtlIGEgbG90IG9mIHNlbnNlIG92ZXIgdGhlIGxvbmcgdGVybSB0
byBoYXZlIHBlb3BsZSBzcGVuZGluZyB0aW1lDQo+IGltcGxlbWVudGluZyB0aGUgc2FtZSBmZWF0
dXJlcyB0d2ljZS4gSU9XLCBzaG91bGQgd2UgYmUgZGlyZWN0bHkgY29udHJpYnV0b3JzDQo+IGV4
cGxpY2l0bHkgdG93YXJkcyBtdWx0aWZkIG9ubHksIGFuZCBldmVuIGNvbnNpZGVyIGRlcHJlY2F0
aW5nIG5vbi1tdWx0aWZkIGNvZGUNCj4gYXQgc29tZSB0aW1lID8NCj4gDQo+ID4gPiA+ID4gSSdt
IG5vdCBzdXJlIHRoYXQgaXMgaWRlYWwgYXBwcm9hY2guICBJSVVDLCB0aGUgSUFBL1FQTCBsaWJy
YXJ5DQo+ID4gPiA+ID4gaXMgbm90IGRlZmluaW5nIGEgbmV3IGNvbXByZXNzaW9uIGZvcm1hdC4g
UmF0aGVyIGl0IGlzIHByb3ZpZGluZw0KPiA+ID4gPiA+IGEgaGFyZHdhcmUgYWNjZWxlcmF0b3Ig
Zm9yICdkZWZsYXRlJyBmb3JtYXQsIGFzIGNhbiBiZSBtYWRlDQo+ID4gPiA+ID4gY29tcGF0aWJs
ZSB3aXRoIHpsaWI6DQo+ID4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGh0dHBzOi8vaW50
ZWwuZ2l0aHViLmlvL3FwbC9kb2N1bWVudGF0aW9uL2Rldl9ndWlkZV9kb2NzL2NfdXNlX2MNCj4g
PiA+ID4gPiBhc2VzDQo+ID4gPiA+ID4gL2RlZmxhdGUvY19kZWZsYXRlX3psaWJfZ3ppcC5odG1s
I3psaWItYW5kLWd6aXAtY29tcGF0aWJpbGl0eS1yZQ0KPiA+ID4gPiA+IGZlcmUNCj4gPiA+ID4g
PiBuY2UtbGluaw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gV2l0aCBtdWx0aWZkIHdlIGFscmVhZHkg
aGF2ZSBhICd6bGliJyBjb21wcmVzc2lvbiBmb3JtYXQsIGFuZCBzbw0KPiA+ID4gPiA+IHRoaXMg
SUFBL1FQTCBsb2dpYyB3b3VsZCBlZmZlY3RpdmVseSBqdXN0IGJlIGEgcHJvdmlkaW5nIGENCj4g
PiA+ID4gPiBzZWNvbmQgaW1wbGVtZW50YXRpb24gb2YgemxpYi4NCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IEdpdmVuIHRoZSB1c2Ugb2YgYSBzdGFuZGFyZCBmb3JtYXQsIEkgd291bGQgZXhwZWN0IHRv
IGJlIGFibGUgdG8NCj4gPiA+ID4gPiB1c2Ugc29mdHdhcmUgemxpYiBvbiB0aGUgc3JjLCBtaXhl
ZCB3aXRoIElBQS9RUEwgemxpYiBvbiB0aGUNCj4gPiA+ID4gPiB0YXJnZXQsIG9yIHZpY2EtdmVy
Y2EuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJT1csIHJhdGhlciB0aGFuIGRlZmluaW5nIGEgbmV3
IGNvbXByZXNzaW9uIGZvcm1hdCBmb3IgdGhpcywgSQ0KPiA+ID4gPiA+IHRoaW5rIHdlIGNvdWxk
IGxvb2sgYXQgYSBuZXcgbWlncmF0aW9uIHBhcmFtZXRlciBmb3INCj4gPiA+ID4gPg0KPiA+ID4g
PiA+ICJjb21wcmVzc2lvbi1hY2NlbGVyYXRvciI6IFsiYXV0byIsICJub25lIiwgInFwbCJdDQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiB3aXRoICdhdXRvJyB0aGUgZGVmYXVsdCwgc3VjaCB0aGF0IHdl
IGNhbiBhdXRvbWF0aWNhbGx5IGVuYWJsZQ0KPiA+ID4gPiA+IElBQS9RUEwgd2hlbiAnemxpYicg
Zm9ybWF0IGlzIHJlcXVlc3RlZCwgaWYgcnVubmluZyBvbiBhDQo+ID4gPiA+ID4gc3VpdGFibGUg
aG9zdC4NCj4gPiA+ID4NCj4gPiA+ID4gSSB3YXMgYWxzbyBjdXJpb3VzIGFib3V0IHRoZSBmb3Jt
YXQgb2YgY29tcHJlc3Npb24gY29tcGFyaW5nIHRvDQo+ID4gPiA+IHNvZnR3YXJlIG9uZXMgd2hl
biByZWFkaW5nLg0KPiA+ID4gPg0KPiA+ID4gPiBXb3VsZCB0aGVyZSBiZSBhIHVzZSBjYXNlIHRo
YXQgb25lIHdvdWxkIHByZWZlciBzb2Z0IGNvbXByZXNzaW9uDQo+ID4gPiA+IGV2ZW4gaWYgaGFy
ZHdhcmUgYWNjZWxlcmF0b3IgZXhpc3RlZCwgbm8gbWF0dGVyIG9uIHNyYy9kc3Q/DQo+ID4gPiA+
DQo+ID4gPiA+IEknbSB3b25kZXJpbmcgd2hldGhlciB3ZSBjYW4gYXZvaWQgdGhhdCBvbmUgbW9y
ZSBwYXJhbWV0ZXIgYnV0DQo+ID4gPiA+IGFsd2F5cyB1c2UgaGFyZHdhcmUgYWNjZWxlcmF0aW9u
cyBhcyBsb25nIGFzIHBvc3NpYmxlLg0KPiA+DQo+ID4gSSB3YW50IHRvIGFkZCBhIG5ldyBjb21w
cmVzc2lvbiBmb3JtYXQoUVBMIG9yIElBQS1EZWZsYXRlKSBoZXJlLg0KPiA+IFRoZSByZWFzb25z
IGFyZSBhcyBmb2xsb3dzOg0KPiA+DQo+ID4gMS4gVGhlIFFQTCBsaWJyYXJ5IGFscmVhZHkgc3Vw
cG9ydHMgYm90aCBzb2Z0d2FyZSBhbmQgaGFyZHdhcmUgcGF0aHMNCj4gPiAgICBmb3IgY29tcHJl
c3Npb24uIFRoZSBzb2Z0d2FyZSBwYXRoIHVzZXMgYSBmYXN0IERlZmxhdGUgY29tcHJlc3Npb24N
Cj4gPiAgICBhbGdvcml0aG0sIHdoaWxlIHRoZSBoYXJkd2FyZSBwYXRoIHVzZXMgSUFBLg0KPiAN
Cj4gVGhhdCdzIG5vdCBhIHJlYXNvbiB0byBkZXNjcmliZSB0aGlzIGFzIGEgbmV3IGZvcm1hdCBp
biBRRU1VLiBJdCBpcyBzdGlsbCBkZWZsYXRlLA0KPiBhbmQgc28gY29uY2VwdHVhbGx5IHdlIGNh
biBtb2RlbCB0aGlzIGFzICd6bGliJyBhbmQgcG90ZW50aWFsbHkgY2hvb3NlIHRvIHVzZQ0KPiBR
UEwgYXV0b21hdGljYWxseS4NCj4gDQo+ID4gMi4gUVBMJ3Mgc29mdHdhcmUgYW5kIGhhcmR3YXJl
IHBhdGhzIGFyZSBiYXNlZCBvbiB0aGUgRGVmbGF0ZSBhbGdvcml0aG0sDQo+ID4gICAgYnV0IHRo
ZXJlIGlzIGEgbGltaXRhdGlvbjogdGhlIGhpc3RvcnkgYnVmZmVyIG9ubHkgc3VwcG9ydHMgNEsu
IFRoZQ0KPiA+ICAgIGRlZmF1bHQgaGlzdG9yeSBidWZmZXIgZm9yIHpsaWIgaXMgMzJLLCB3aGlj
aCBtZWFucyB0aGF0IElBQSBjYW5ub3QNCj4gPiAgICBkZWNvbXByZXNzIHpsaWItY29tcHJlc3Nl
ZCBkYXRhLiBIb3dldmVyLCB6bGliIGNhbiBkZWNvbXByZXNzIElBQS0NCj4gPiAgICBjb21wcmVz
c2VkIGRhdGEuDQo+IA0KPiBUaGF0J3MgYWdhaW4gbm90IGEgcmVhc29uIHRvIGNhbGwgaXQgYSBu
ZXcgY29tcHJlc3Npb24gZm9ybWF0IGluIFFFTVUuIEl0DQo+IHdvdWxkIG1lYW4sIGhvd2V2ZXIs
IGlmIGNvbXByZXNzaW9uLWFjY2VsZXJhdG9yPWF1dG8sIHdlIHdvdWxkIG5vdCBiZSBhYmxlDQo+
IHRvIHNhZmVseSBlbmFibGUgUVBMIG9uIHRoZSBpbmNvbWluZyBRRU1VLCBhcyB3ZSBjYW4ndCBi
ZSBzdXJlIHRoZSBzcmMgdXNlZCBhDQo+IDRrIHdpbmRvdy4gIFdlIGNvdWxkIHN0aWxsIGF1dG9t
YXRpY2FsbHkgZW5hYmxlIFFQTCBvbiBvdXRnb2luZyBzaWRlIHRob3VnaC4NClllcywgdGhlIGNv
bXByZXNzaW9uLWFjY2VsZXJhdG9yPWF1dG8gaXMgYWx3YXlzIGF2YWlsYWJsZSBmb3IgdGhlIHNv
dXJjZSBzaWRlLg0KRm9yIHRoZSBkZXN0aW5hdGlvbiBzaWRlLCBhIGZhbGxiYWNrIG1lY2hhbmlz
bSBpcyBuZWVkZWQsIHdoaWNoIHN3aXRjaGVzIFFQTCB0byB6bGliIG9yIFFQTCBzb2Z0d2FyZSBw
YXRoIGRlY29tcHJlc3Npb24gd2hlbiB0aGUgaGlzdG9yeSBidWZmZXIgaXMgbGFyZ2VyIHRoYW4g
NEsuDQoNCkluIHRoZSBuZXh0IHZlcnNpb24gb2YgdGhlIHBhdGNoLCBJIHdvdWxkIGNvbnNpZGVy
IG5vdCBhZGRpbmcgYSBuZXcgY29tcHJlc3Npb24gYWxnb3JpdGhtLCBidXQgaW5zdGVhZCBhZGRp
bmcgYSBjb21wcmVzc2lvbi1hY2NlbGVyYXRvciBwYXJhbWV0ZXIuDQpUaGVuIA0KQ29tcHJlc3Np
b24gYWxnb3JpdGhtW3psaWJdDQpDb21wcmVzc2lvbiBhY2NlbGVyYXRvcltOb25lLCBhdXRvLCBp
YWFdDQoNCj4gPiAzLiBGb3IgemxpYiBhbmQgenN0ZCwgSW50ZWwgUXVpY2tBc3Npc3QgVGVjaG5v
bG9neSBjYW4gYWNjZWxlcmF0ZQ0KPiA+ICAgIGJvdGggb2YgdGhlbS4NCj4gDQo+IFdoYXQncyB0
aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIHRoaXMsIGFuZCB0aGUgSUFBL1FQTCA/DQpCb3RoIElBQSBh
bmQgUUFUIHN1cHBvcnQgdGhlIGNvbXByZXNzaW9uIGZlYXR1cmUuDQpJQUEgZXhjbHVzaXZlbHkg
c3VwcG9ydHMgdGhlIGRlZmxhdGUgYWxnb3JpdGhtLCB3aGljaCBpcyBjb21wYXRpYmxlIHdpdGgg
emxpYiAoaGlzdG9yeSBidWZmZXIgPD0gNEspLiBJdHMgdGFyZ2V0IHdvcmtsb2FkIGluY2x1ZGVz
IGNvbXByZXNzaW9uIGFuZCBkYXRhIGFuYWx5c2lzLg0KUUFUIHN1cHBvcnRzIHRoZSBkZWZsYXRl
L3pzdGQvbHo0IGFsZ29yaXRobXMgYW5kIGlzIGNvbXBhdGlibGUgd2l0aCBzb2Z0d2FyZSB6bGli
L3pzdGQvbHo0LiBJdHMgdGFyZ2V0IHdvcmtsb2FkIGluY2x1ZGVzIGNvbXByZXNzaW9uIGFuZCBl
bmNyeXB0aW9uLg0KDQpUaGUgUVBMIHNvZnR3YXJlIHBhdGggaXMgYSBjb21wb25lbnQgb2YgdGhl
IEludGVsIElTQS1MIGxpYnJhcnkgKGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC9pc2EtbCksIGEg
cmFwaWQgZGVmbGF0ZSBjb21wcmVzc2lvbiBsaWJyYXJ5IHRoYXQgaXMgZnVsbHkgY29tcGF0aWJs
ZSB3aXRoIHpsaWIsIA0KSVNBLUwgaGFzIHRoZSBzYW1lIGhpZ2ggY29tcHJlc3Npb24gcmF0aW8g
YXMgemxpYiwgYW5kIHRoZSB0aHJvdWdocHV0IGlzIG11Y2ggYmV0dGVyIHRoYW4gemxpYi4NClFQ
TCBlbnN1cmVzIHRoYXQgdGhlIHNvZnR3YXJlIGNhbiBlZmZpY2llbnRseSBkZWNvbXByZXNzIElB
QS1jb21wcmVzc2VkIGRhdGEgd2hlbiBJQUEgaXMgdW5hdmFpbGFibGUuDQoNCj4gLS0NCj4gfDog
aHR0cHM6Ly9iZXJyYW5nZS5jb20gICAgICAtby0gICAgaHR0cHM6Ly93d3cuZmxpY2tyLmNvbS9w
aG90b3MvZGJlcnJhbmdlIDp8DQo+IHw6IGh0dHBzOi8vbGlidmlydC5vcmcgICAgICAgICAtby0g
ICAgICAgICAgICBodHRwczovL2ZzdG9wMTM4LmJlcnJhbmdlLmNvbSA6fA0KPiB8OiBodHRwczov
L2VudGFuZ2xlLXBob3RvLm9yZyAgICAtby0gICAgaHR0cHM6Ly93d3cuaW5zdGFncmFtLmNvbS9k
YmVycmFuZ2UgOnwNCg0K

