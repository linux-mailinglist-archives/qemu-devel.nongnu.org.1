Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF28270EB01
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 03:49:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1dbg-0002bC-V6; Tue, 23 May 2023 21:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q1dbe-0002b4-Dn
 for qemu-devel@nongnu.org; Tue, 23 May 2023 21:48:02 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q1dbK-0000k1-N8
 for qemu-devel@nongnu.org; Tue, 23 May 2023 21:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684892862; x=1716428862;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mw2hNQ6znXZoLPCc77neGvP3nc+rz/FbBoUybAO77Xo=;
 b=bA1JSkrOXOct1+8HhAoHwg6ybK3dD5TkWfqv6x8xSvmz/RIXVxcU09eH
 ZtJYcyGXdOWk5CfV+kyDElVCjjJwr6HbQE5Rjx+eKPw7E6Nvw1cBqQT69
 7ngJOny9rTHb3r/5dNpsU/dStHf04/L8dNbblfi6uCJdcR6oQ8zEI2RLy
 gVk7VAL+iTcEMffvcIBic/t+nNB3h7lddvZjmYhZFpRFvMxZb0+Gvo0d9
 0/MJeTneahJzIgX3/ryIoDg5tUxlc2WDNmT6AwVXCPF091sJ8RmMA55qs
 yym9RNViY6NgJto12bZkgPdMD0Tmp3sbLxSBYQFjdmZLduFBpY1qmKm7v Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="352263366"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; d="scan'208";a="352263366"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2023 18:47:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="704136078"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; d="scan'208";a="704136078"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga002.jf.intel.com with ESMTP; 23 May 2023 18:47:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 18:47:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 18:47:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 18:47:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 18:47:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7f54IlXXDuGu588RO0X3Naywh4Eo2mV7/u36P1EoZTwXJHowGxxjiM/gZ416rytAhkiY3M3L24r6y02RVGK3tG66vVC/Y9ybE9gNwy7UFm2zLv70rDjiBmc8dOaXUOk0oA1RPPrzQU9nrdtFVY268dszge5VIAzOj83OKGvzr9GyIkyV2PGShc7Fndw/lGdPIDzVp3Dj67qUc+OxTdgPsRsfBTsD4AjhBVequLGqu/+2oduMDZANct2bEeFplg6+opp7wALtr2m1aaEUW8QvuWWxkR0TICKMxYnApvKHica4YnKBepzZM1BK8kjhPAjsrPks75FZeGgSJgljc1CdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mw2hNQ6znXZoLPCc77neGvP3nc+rz/FbBoUybAO77Xo=;
 b=e37msvGs264+8JRzTI63U8n6bnC9nidV9ljl8t8z8tXh6M2gYBOv1DX2dpvQJlAA9b7FX1s5sHv4JO/44bvU+Vu+J+NVAHpn+2BvtE2NwbDNJ8FB1jV3jSRSNfKQqgZfT3t8MR90uAM5ojxrVlVuMZHlsKufs/xVd/pqEAIziGK804eXiufF8IOFDddJbVjgSM/EQqOQPvTdG6VmVCb0VNVU5SaCs43WMqxHlmlYiu2sl9NGsS/DKg936qgOKKQs2y3YUyTPFUamhMzGEpQzxBGPP8ieXSxBL49Ds4SFkL8LQFhUC+hpAqfvnIdVOliZqY/TsgMdoMjHccmHaFiPSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 SA0PR11MB4573.namprd11.prod.outlook.com (2603:10b6:806:98::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Wed, 24 May 2023 01:47:27 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::14c:205:c858:1ef6]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::14c:205:c858:1ef6%7]) with mapi id 15.20.6411.021; Wed, 24 May 2023
 01:47:27 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "quintela@redhat.com" <quintela@redhat.com>, "Wang, Lei4"
 <lei4.wang@intel.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v1] migration: fail the cap check if it requires the use
 of deferred incoming
Thread-Topic: [PATCH v1] migration: fail the cap check if it requires the use
 of deferred incoming
Thread-Index: AQHZiaHrpdDskbcmfUmdUetnWYWQW69gaDgAgABj4tCAAO5TgIAAAOyAgACb1xCABKHrgIAAHRqAgADO5ACAAAiF8IAACtcAgAAEmGA=
Date: Wed, 24 May 2023 01:47:27 +0000
Message-ID: <DS0PR11MB6373669D3A526109BCB7FDF8DC419@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20230518160026.57414-1-wei.w.wang@intel.com>
 <ZGZ6Yqx2+dOp+Q73@x1n>
 <DS0PR11MB637350354B0285ABF3FA1BD9DC7C9@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZGeWF4lzBldLLH/y@x1n> <ZGeW3R5McptUueJF@x1n>
 <DS0PR11MB63736A4AE4A624D2B9EFD19DDC7D9@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZGv8adigFYpLD89k@x1n>
 <DS0PR11MB63737B09D72A735EC21F3C41DC409@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZGzCYMRWa7sW9xAv@x1n>
 <DS0PR11MB637381609AFD7DA4998AB201DC409@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZGzSnr5eaS1Wsjwf@x1n>
In-Reply-To: <ZGzSnr5eaS1Wsjwf@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|SA0PR11MB4573:EE_
x-ms-office365-filtering-correlation-id: c659d8eb-f33d-4f5f-8b63-08db5bf8d415
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sALNva8GkPGubNYN3FbbnWCHn88HNy6EX550PqYqUIyp1x1ICplDaeckjeBt+D6/8KQd/m16RS2zZqBVY7rl3/TIj62xSkNsPu35GF9f9SLikrZxgOwvn4dQGT/E07Gsr5uGHyN4oap4B9FVka9AKlWIRd7J5Hu74kjhNHE0YAHEnm07/6Xl0T9XdoEKBJJ00EXLsKeRsBsVTYdxsoNgdqozgNOcUzS0CQVL/KhabRTqio+E4nVugYxaPjJlf2pJcyqIh/wurQ4ogw4Y+N/e2rMerb6LUTf4FuImGTW3CKHrAzKkl75oSCLHI+Lq3Xdt8MS+C7Zc8sIcSySB5k6KRS+gTlso8bSIG8t3wxcaaKu+tiOTRDWZKk/HtuAjEBgbhtUl11om8/jeL6YQNQygZL8K9tpvP1G/POlJjD1qfGvKuHLJRZrjwCdB4vIbvDXvtKKsKFJ9xDbJiyFzonuc7urWd/SR9ofk0E0mkakuCagJLG2RLnOu7wdym4ZgNF0QhYjYdUmxSLjqULmslOKOAjZyqbUQOA5xYtv8kA8uroVFPBhSARa245jZmpBsTbIFoj9j7DbP1Hu7VURqAnI3PGLBpkv7WwnRRverYMG3pXTKYWa4ikeFVCaQ9P0UBrM35DN8ZuvQK/tVtIL8rz6Zow==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(55016003)(33656002)(4744005)(82960400001)(6506007)(26005)(122000001)(53546011)(9686003)(38100700002)(2906002)(186003)(83380400001)(71200400001)(316002)(64756008)(66946007)(86362001)(66556008)(66476007)(66446008)(4326008)(6916009)(76116006)(41300700001)(7696005)(54906003)(478600001)(8936002)(8676002)(38070700005)(5660300002)(52536014)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2xFeDhMQjFrQm00QjdabUtjbnJRR244ZWxvR1dITHRlbGhIcUpPYzlVUVEy?=
 =?utf-8?B?ZDJiVE9jWXJZUEorUHhXaitrZjlmWnVBMGxqckU3cTdBM0M3d01RL0dOUHYz?=
 =?utf-8?B?TEY4SU5IQXFOamgyaHdXa1hTTWVZNmhpODZRMlBPdEhkSDlGcWlSQWdiSzZK?=
 =?utf-8?B?UlVZMmtCbXRuMnlLVlhuYUlZL2F2NlRQQnExVjErc2Y0MVQ2YU9VSk41Y2kv?=
 =?utf-8?B?NEt0VHc1R00waW8yWjJrZVA0WlBuY01mNzQvcU0yMEpta2VaMzcvNGp5T1FL?=
 =?utf-8?B?WTBwMkRMQVNoekNpOUVkL3BKQS9lWVFPMC9uSVJSbFM3aVBCeE8wM09HcmJ3?=
 =?utf-8?B?N3d0Z2RFWWFRL3FRcXJvSDBaUXoyM2w0bmlkdnBOQTBpdHBoT1FDT2RrbUVa?=
 =?utf-8?B?Nmh5TWlTZGJRYmVUME9VMEpXcVZUdlVMU0p4WmlsSzRxL0hIRHRGSVdyNmRz?=
 =?utf-8?B?L2poanZibTEzM1paU3lkejBrdm1mT2NYSStvLzQ4REQzQ29jYWNTN0RzeEdy?=
 =?utf-8?B?Vjg0VjZwcHJnbDFDMTN5ZXRHenh6b0RSSWs0Q0JxM3cvVzR2S2pjMVZua1Zp?=
 =?utf-8?B?dXpldzFMYTZNQ2V6dEFwMlFwNDZsUDkwQUNpVmRNdkRlc3liakdtR1V4cWxj?=
 =?utf-8?B?allCbUJNbWVidGdSZDFjdVNYaXIyMzltdmxQVGh0OTBSNVZvTUpOVHRFeHJQ?=
 =?utf-8?B?ZlRybDBNYXF4ZUoxM1V0RUY2TSszK3phWmNybmN2MURJQmoydmFBWXhQVVEr?=
 =?utf-8?B?elljeEczRGRsVDRILzExTkFyVU1hb2d6REUvTmQxcEdUQ3Erem5wSTErcHlC?=
 =?utf-8?B?SWgySHR4VE1lSXBUZGE1MWo3aENYUTliN3BuQXVwbFNXL0xtUkRmZlBsQ3RC?=
 =?utf-8?B?Z0NIdDU0WjRWQ3hmQmFnQmlGcFFJMUxuOEo5dW5zNG9DVGhhbExmcEN4bWZq?=
 =?utf-8?B?MkMySWFYSlBVaGppYWp3ZkM0TXdKUnFWN3Voam5NMTh4UW05TlRTUjBWTDJy?=
 =?utf-8?B?YmUwdktoSUtvUnpsNnBDenM4Qmh6enlHNjlCTTlLYUZuSDBjcGxFcE5weGRT?=
 =?utf-8?B?OTFhUUpXQm9BeUtHcGsyTW5Lc05wRGZwT0VrbVIyWGxzMzE0Q2FLSm5rbDZm?=
 =?utf-8?B?L3NPTkszS1dORldmUzMreHBKMmlCYk55akc0YkF5T1p0bXhqSDZxRDhiNm45?=
 =?utf-8?B?WUJmZDVQdmFQc0VoZ3lNdnFCNW9CbktTUCtncTVjVUoxMTB3TmtBM3RxMG5p?=
 =?utf-8?B?RVVJRU1vK2NIbXJMRDM4RDdOckxmZ1ZMMTlUbE1qS0hXeXY0bTFxVUtsV051?=
 =?utf-8?B?QlArTGh0Z1Eza0FGbGVKYjRWOXloclRiUE8weWhIZWZKTTd5N2ZpbHpVY0Zu?=
 =?utf-8?B?U054bEh6Q29oalJLU25za3ZjcE4rNmgzZDJ5UDhrWEsrbDA2V2QxeUZJTXpI?=
 =?utf-8?B?aEtqMTZ4d0hDSFJDNWdZTy9ZYTZIMW93eGRwd1U1Q2s5UFVTSkU4dHNRL2No?=
 =?utf-8?B?UzJuZGVsSjdpdzd6ckVmS3dkSTRRSkpWbWZYUHRyUGJPZFFVT3dPYUFQb2d3?=
 =?utf-8?B?MVBERXIyQTE1ck9sUHVmQk9DVGc0bFM3cVBMck1lN0xuek1sTWp2YXE2b2Y4?=
 =?utf-8?B?VDlEdjZ2dmplU1ZSTHhIRFlXQ1FJK24xYjNQbjc5aW81cmZ3ZnBjbmllaTh2?=
 =?utf-8?B?MkpuaElNWmpmazZkcVpMdkFNYlE5ZUdKR1dVUUZmVER2eGVpOUV6TFFnelVD?=
 =?utf-8?B?aGJLUG1BaHBuZVpmWHZmbFBpWkwvemJaN2g4M08zY2tOcjFpeTgzTjQ2cC9t?=
 =?utf-8?B?S1FtMkpKTjhTL1lqSVc2TnU4M0ExWm91TXUzR0F2WDRRZlRNYmI5dVlmYzEw?=
 =?utf-8?B?YTd1NkxERXkvMzNQUkVIbVB2TGp5UlgxWmF2b0RjQUJLWmVNOXFsdEVTZmFo?=
 =?utf-8?B?V3NtTkV5ZlBzUGlzdVQ3RW40cE90dTVTcjJZOGpiS3NXMUEvU29PRDl3aFRK?=
 =?utf-8?B?YmFpbkc3Ky94RVhPTXN0L1lHblBOb25IMVY4WEN1K3NscXB3ZjdIRWV2M1p5?=
 =?utf-8?B?Q3JiTFVYNTBDQjJ6RHRWaVFYQTFHQituMlBXUXAyOVlvZE41OGkzdS80cWFu?=
 =?utf-8?Q?scyD0yBqfDhlZboR0sPt6NjAl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c659d8eb-f33d-4f5f-8b63-08db5bf8d415
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 01:47:27.1151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LwC18Hb25TR8gmA8JeScnkOTpvzYsMR4eBcNooDytd/Q583U9uh93/NVpmkjSMkbl4sZEJ0otsbwz3ezlpC0WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4573
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120; envelope-from=wei.w.wang@intel.com;
 helo=mga04.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

T24gVHVlc2RheSwgTWF5IDIzLCAyMDIzIDEwOjUwIFBNLCBQZXRlciBYdSB3cm90ZToNCj4gT24g
VHVlLCBNYXkgMjMsIDIwMjMgYXQgMDI6MzA6MjVQTSArMDAwMCwgV2FuZywgV2VpIFcgd3JvdGU6
DQo+ID4gPiBJdCdzIGFib3V0IHdoZXRoZXIgd2Ugd2FudCB0byBwcm90ZWN0IGUuZy4gYmVsb3cg
c3RlcHM6DQo+ID4gPg0KPiA+ID4gMS4gc3RhcnQgZGVzdCBxZW11IHdpdGggLWluY29taW5nIGRl
ZmVyIDIuDQo+ID4gPiAibWlncmF0ZS1zZXQtY2FwYWJpbGl0aWVzIiB0byBlbmFibGUgbXVsdGlm
ZCAzLiAibWlncmF0ZS1pbmNvbWluZw0KPiA+ID4geHh4IiB0byBzZXR1cCB0aGUgc29ja2V0cw0K
PiA+ID4gNC4gIm1pZ3JhdGUtc2V0LXBhcmFtZXRlcnMiIHRvIHNldHVwIHRoZSBudW0gb2YgbXVs
dGlmZCAgIDwtLS0gd2lsbCBiZQ0KPiBpbnZhbGlkIGhlcmUNCj4gPg0KPiA+IFllcywgc3RlcCA0
IGlzIGludmFsaWQsIGJ1dCBJIHRoaW5rIG5vYm9keSBjYXJlcyBhYm91dCB0aGF0IChpLmUuIG5v
DQo+ID4gcGxhY2UgdXNlcyB0aGUgaW52YWxpZCB2YWx1ZSkgYXMgc3RlcDIgYWxyZWFkeSBmYWls
cyB0aGUgY2FwIHNldHRpbmcgKHdpdGgNCj4gZXJyb3IgbWVzc2FnZXMpLg0KPiANCj4gU2luY2Ug
b25seSB1bnRpbCBzdGVwIDMgaXQgc2V0dXBzIHRoZSB0cmFuc3BvcnRfZGF0YSwgc28gc3RlcCAy
IHNob3VsZCBiZSBmaW5lDQo+IGFuZCBub3QgZmFpbD8gIFRoYXQncyB0aGUgd2hvbGUgcG9pbnQg
b2YgbXkgZXhhbXBsZSBvciBJIG1pc3NkIHNvbWV0aGluZw0KPiBoZXJlLi4NCg0KT0ssIEkgbWlz
cmVhZCBzb21ldGhpbmcgYmVmb3JlLiAgR29vZCBwb2ludCwgdGhhbmtzLg0K

