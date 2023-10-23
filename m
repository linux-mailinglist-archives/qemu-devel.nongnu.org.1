Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D582A7D2CD2
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 10:35:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quqNq-0006OB-Vx; Mon, 23 Oct 2023 04:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1quqNo-0006NR-Ml
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 04:33:56 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1quqNl-0002dB-1N
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 04:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698050033; x=1729586033;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Xmcrz6UoNvrKNsDSynrAwzu1bUXo+m0yBSMtijJ0jWs=;
 b=BUXX5JNeKbPdqDrTAmVPPICxOgBuym8XmDiKyx1U1YQlLbRQpULpVQmO
 M4Ok/LmlC/Ml0R2M0Lf5Xf5JYIRAM+HUrMqsiJrf1XMpPX+62zVBwdvZK
 M7VqjQf7d5rPwpX0yfbyzxTxHahnyZsFEqP1nxaKX55xVApN3xlQwPsi4
 MOtl1B/Y/9c6Ex2ljA3XbWVAhv0qDcdJbQQjRvbUT8C9u+hINE+riB3JW
 ZQvDU69uR8VEgd9WQpJ7OUgcE1+AELkg0rm5Vo3pv+9U47bQvO95FJ0cR
 bNTtuHw1lL0cjErLMBsg6ZppOQN8aeTFquqkITIWCAmmDV4UBO/t89LjX w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="385675933"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; d="scan'208";a="385675933"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2023 01:33:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="5997872"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Oct 2023 01:33:45 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 01:33:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 01:33:48 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 01:33:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTnof4sXvRUBeOg20Z1hVdbUKYbqweafHjlvaTJM6r1Jh+DQy+7SgjVv0JUA98qCpytOjn8nIc9VMI5yk0DZff3JR0/SnUgboDoKyrATjmJIQPTy6l7TcyRVu0HmpgZbJEFY72R22pYnUAAxZMv/RIZXuVyMH/MjmrTwgkF1qPJC8gWSZROuRHUW6gDa5tjM2lOXV/O3wqtHMVvpWyQTZ4Q//Hy7Pgj0Gz2o/d/wAs0vVj0gBaYOnew1udNLa9CQIfTSoqGRYwnVO6UMN5hDVLjSW0sSkPrVQOkVEAgoGDy2U+dGMUfPPx9kvAmvZEmFLdJFirUXAk0xgIAECtYw2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xmcrz6UoNvrKNsDSynrAwzu1bUXo+m0yBSMtijJ0jWs=;
 b=Iatds40B6F9/iPB6HaG6Z2I59u9fV6Xc7MdlyUlo1jzmNJ3sUkyyMVw3cHqyyvXmmiZFWf05Uov7LnHgSKc97lmYwGIHJlxemRUefDGFqAHbrcKXJbBe8Vgj0m3QYoFLoTfo2LflyvPnyuUtnEYg5UeU7yHbBzqd0V2fbOz0N81gK6VZLkwTVfIXS6NLnBd4fzRTTeGbUEvPfdOz3ZPUGHhy93/VHOLj5jsJ8twhzvU1XktKvxs2sQsDs0YZkphZDFVn3ezjvJi7mTa3bgo6OWTaU3fELXnnbQwPbOfcDPyHbicwT07opAR/Mp5VJS/ooQ3p6mo9YyvFhF2n7/cRDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB4388.namprd11.prod.outlook.com (2603:10b6:a03:1c9::17)
 by CY5PR11MB6092.namprd11.prod.outlook.com (2603:10b6:930:2c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Mon, 23 Oct
 2023 08:33:46 +0000
Received: from BY5PR11MB4388.namprd11.prod.outlook.com
 ([fe80::a164:ef88:9f1a:8519]) by BY5PR11MB4388.namprd11.prod.outlook.com
 ([fe80::a164:ef88:9f1a:8519%3]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 08:33:46 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, Peter Xu
 <peterx@redhat.com>
CC: Juan Quintela <quintela@redhat.com>, "farosas@suse.de" <farosas@suse.de>, 
 "leobras@redhat.com" <leobras@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: RE: [PATCH 0/5] Live Migration Acceleration with IAA Compression
Thread-Topic: [PATCH 0/5] Live Migration Acceleration with IAA Compression
Thread-Index: AQHaAmKFMfJOhFrqz0aucJcr+N/dnbBQ/WaigAA1hgCAAAi9gIAAAmkAgAW4zJA=
Date: Mon, 23 Oct 2023 08:33:44 +0000
Message-ID: <BY5PR11MB4388F9495DD42ACCFB980A6CA3D8A@BY5PR11MB4388.namprd11.prod.outlook.com>
References: <20231018221224.599065-1-yuan1.liu@intel.com>
 <87cyxa6dso.fsf@secure.mitica> <ZTFCnqbbqlmsUkRC@redhat.com>
 <ZTFJ84SnSOAcU5gY@x1n> <ZTFL+N3mxESxXpfv@redhat.com>
In-Reply-To: <ZTFL+N3mxESxXpfv@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB4388:EE_|CY5PR11MB6092:EE_
x-ms-office365-filtering-correlation-id: 3029cd55-224b-478e-4631-08dbd3a2c50f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /k8jBY+P5FGuular0YuitqWNmv+3eRV/bHAqz/i79O4gW4yy0DSmqWNjNCU73xPAHlcXlDyoS130vzLRkEmcHXjBEgo6PH2mR0RoNwZV40oMd2bTSPkP1uZ2SwwGz6K62ctEojkf8yuHChlwTJqS2ZWGZxlJL5zG11reE7KM+VfPL3s31yu8rjuOjCkmjZW4+xGxprLgbxJtCc+WBZKylIKsqOMYfx6/RAnNfzGiFpKgdg8EanNlIpi00nuU6Wew9TnbIJZht+mYuy9zFWE0ABDotsVCcsyxaAJJDDSajf9WjZTkdc1W4PFL/H+eHg3v3PTaaeTaP5O9W6Zh1JoYkS37P0RYzPG+asRDRwV31BYlVnq1M+k/by0XfwfsJCeSFCr+Tu3EuTNMZMw8TK7sZrEbWe3hzbNLJWWaM/30o/uhjQ3oEiHF+8lSzSVJJWh7AVSSrGWcZxdeSOYYMGsxEp1hmlzB3o/7EQDipSIZkgzA5/kDNGHCuBiBX+3Z6nyIdGPNhYwctsSN8MuBK7extSnHt97b3I/RWCvHUlTYCTaqXkgsBXp7jVtu7ZBV12fxvANMEv+tTTQjZtussD8bjWJfeuYI+4zKNcj2Ma5NRmDo+MoD4faEVhHbNluRg2gkCXskFs2S38Oh03lBVbzLhA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4388.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(38070700009)(66899024)(41300700001)(53546011)(86362001)(33656002)(6506007)(7696005)(71200400001)(966005)(76116006)(66476007)(55016003)(66946007)(9686003)(110136005)(64756008)(66556008)(2906002)(316002)(4326008)(83380400001)(66446008)(8676002)(38100700002)(8936002)(122000001)(82960400001)(478600001)(5660300002)(107886003)(26005)(54906003)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWlrOG9YdisrQjdWeGFJNjVMeStRRHV1dHBpcHBNdkhDcjdIenRaUmNNSGJv?=
 =?utf-8?B?MmFTZ2hWOHZDTE1sOTFaUEU1S0JuR0c3MDRPMnpyV1JKMUZNT3Brd29neVNo?=
 =?utf-8?B?TEdKSGNXUldIeTBteVFwOG5aNWdUVlNLRFNtRHdPVDJzVEVwRTBQV1FNLzZp?=
 =?utf-8?B?dU1kOURzTVdmenhnQWo3RWhSTmw1YWdGeFpmWjBDd1dYVk1pUHdMM0xXSTBx?=
 =?utf-8?B?a2liUVVjcEtpSWorYm1wNGpSMnJsNGZzSnBCNWZpWWxCSmJkODloUmR5aE9x?=
 =?utf-8?B?Ulo1ODNoWXZXLzI4ejlsSzRXRUtFZDdJTFBjaWYvL2h4YlN0NStZOXdnR2Jt?=
 =?utf-8?B?eU1aeExDUVhJK25MMWREb3VqeVdPM2tYWjZvWFJ1VEZ4MGNQcEdpQ2NQVDgv?=
 =?utf-8?B?UHBaTGFycnEraGpDS3ZCTWxIdjl6Mk00Tm1kUkVLUFhkTk4zSDA2YWdreGRp?=
 =?utf-8?B?VVdLOXdIN2J5YkRlZE5ScXJFSkZFTEVIWWhDY2hyR1cwb3FWb1VyNGRqc3Qv?=
 =?utf-8?B?bDAzSXBpOTB2ekhWM0hSZ3hlc2RGWFlNRi9qb2ZiczZvQ0hSMHFLSWNQVVM3?=
 =?utf-8?B?cVZTaC9pRSswN3F6akk3Rjd4WnROQ084R0p0RjVVUklxQ01FYVBmMDhwSm54?=
 =?utf-8?B?VjZuWXA5NkZJelRpTWRUZlh5Q0ZUVWRzR1h6SW13MUFVbmh0QTNtWHZ5TEhY?=
 =?utf-8?B?dXJkT2pma1VJMm41RkpzeWI3WGRGSVFGS0pWMlRPdFpaRzdBN1pkSGdZWXhK?=
 =?utf-8?B?czdMQjBHUmcxU3BQN1ROaEMvc1NQQzJWQ2hQWXFEdmtxeGZ1ZmY1RjRDYXg0?=
 =?utf-8?B?em0vUmt1djFqcFFDVlo5VGZLVVNBOHdhTzMzdXAzeHRmQjE0R2lrNXpiUnQz?=
 =?utf-8?B?MFBBY3JTTTBQUzA4dDd0U3p4U3VNVVNYd3ZjYnRDQWFvMmlrYUFDa2pidjRj?=
 =?utf-8?B?V0VBTEIrSGJSUWFqbnc1QW1HSjdWeFBIbXVVQ2E4QVBpK1ZhZEMvbjZwcGFS?=
 =?utf-8?B?M2lILzRxYWRoNlFVTTJudkdjZXZZQlhRaENOcWVyZlNFeEpDaEZjNXh6enRM?=
 =?utf-8?B?bTAzMkdYdktoQkR2VmI5SkpKeGJjQ1RpMG5nd0tZU3VDMFJ2TkQ4RFlJTnkv?=
 =?utf-8?B?TGJaS3QyY0ttMkxQY0pjRjJZQ2dIYUFpbnFGWGpTdUFuUGhCNU9xdlNQWnpH?=
 =?utf-8?B?WU1RbE1wamZxb0l1YTI2OVlhS0dBa1VYZnlTeHZ0WFN4VUNZaFBaZ0s5L0xO?=
 =?utf-8?B?dW8yNHhKSFFEaWR2YkdXNU44ekZRMHVveDNmcjdJL3dFUi9sQ3phOVZ6SCsv?=
 =?utf-8?B?dC9SMWhlcFpzODNyaHVFa3Jwc2RCcWZ1UFpBbm1vL3lXeU5CWHl6NjJqWVYx?=
 =?utf-8?B?NldvSjdRWjg3MDRUNytMbXZwZVJ6ZlpkQnUveU1WdWJUbVRlMHBiaHkzQm5K?=
 =?utf-8?B?KzNXR1Vma0dUUHdrWVpmOE9URG9SMTdNTVVjdEtlR25hRlF4YnY4N2JycFZa?=
 =?utf-8?B?Z2s5aFdIYUltMDVXVHBobGVESGJTRUFqMXBmOUxEK2FSVFhlWXp2aHB2MkNO?=
 =?utf-8?B?bkhRWmZ1RGcySitRWW9tY2RUM0ZJZXpCU1I0Q2svdnFQWEhVM2o0SklUSFNV?=
 =?utf-8?B?c0xBU2lvWkg1THkvaXNlMWlIeG1GTGpqTnRKcGxHcjVNODMzRWh5QjNSOU5i?=
 =?utf-8?B?RmZiK0hEMmQ5My9LbU96cmdUYlpZbVAzd0lVOWpsSVRuQW1WK2txOHdRK2dz?=
 =?utf-8?B?YUJsanZ4MDd1MFlPUDVDRnBtVkM3ejJHMWxPeEFSRkhDWnZHeU95Q3FsQVl5?=
 =?utf-8?B?RXZHN0N6QlhMOWR1Wmg0NDBaMzNWdVlGYm5jbjFQTjdvSnQwU3U1TUdveE1Z?=
 =?utf-8?B?eWMxV250Qk5CbEsxeGF6NXFaNUF4VkJ5YWJnQmxtK0x1UkxCVUp6ZFd4d1BO?=
 =?utf-8?B?aFVvMGVHcWY2RkNvem9yWENWeFpWMFZ4SFVlSHZWamt3ZFFlQTRhNjJpNVlP?=
 =?utf-8?B?SDJYTW1pajlBN1hNdFIvRXpQNEJZZmtUalR5U0E0WEJrZy84L2lHcjFub2Zr?=
 =?utf-8?B?OVJFeXVrdUZWamxwTFY2aEhCdFNWYzdLVDIzUzFvVmw4TjFQR1N5QjR3cU1o?=
 =?utf-8?Q?OHEouFc4COTCcZkK1vvaiVsiT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4388.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3029cd55-224b-478e-4631-08dbd3a2c50f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 08:33:44.7265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lH+smVbmS5FB9Njn361R2swNqDyIHGeZqRfI0eLL2oXZVtdl8UVWuNsaxMNNZm2KVg/3FmzmAyIjrJyolhJEZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6092
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5pZWwgUC4gQmVycmFuZ8Op
IDxiZXJyYW5nZUByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAxOSwgMjAy
MyAxMTozMiBQTQ0KPiBUbzogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0KPiBDYzogSnVh
biBRdWludGVsYSA8cXVpbnRlbGFAcmVkaGF0LmNvbT47IExpdSwgWXVhbjENCj4gPHl1YW4xLmxp
dUBpbnRlbC5jb20+OyBmYXJvc2FzQHN1c2UuZGU7IGxlb2JyYXNAcmVkaGF0LmNvbTsgcWVtdS0N
Cj4gZGV2ZWxAbm9uZ251Lm9yZzsgWm91LCBOYW5oYWkgPG5hbmhhaS56b3VAaW50ZWwuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIDAvNV0gTGl2ZSBNaWdyYXRpb24gQWNjZWxlcmF0aW9uIHdp
dGggSUFBIENvbXByZXNzaW9uDQo+IA0KPiBPbiBUaHUsIE9jdCAxOSwgMjAyMyBhdCAxMToyMzoz
MUFNIC0wNDAwLCBQZXRlciBYdSB3cm90ZToNCj4gPiBPbiBUaHUsIE9jdCAxOSwgMjAyMyBhdCAw
Mzo1MjoxNFBNICswMTAwLCBEYW5pZWwgUC4gQmVycmFuZ8OpIHdyb3RlOg0KPiA+ID4gT24gVGh1
LCBPY3QgMTksIDIwMjMgYXQgMDE6NDA6MjNQTSArMDIwMCwgSnVhbiBRdWludGVsYSB3cm90ZToN
Cj4gPiA+ID4gWXVhbiBMaXUgPHl1YW4xLmxpdUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4gPiA+
IEhpLA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSSBhbSB3cml0aW5nIHRvIHN1Ym1pdCBhIGNvZGUg
Y2hhbmdlIGFpbWVkIGF0IGVuaGFuY2luZyBsaXZlDQo+ID4gPiA+ID4gbWlncmF0aW9uIGFjY2Vs
ZXJhdGlvbiBieSBsZXZlcmFnaW5nIHRoZSBjb21wcmVzc2lvbiBjYXBhYmlsaXR5DQo+ID4gPiA+
ID4gb2YgdGhlIEludGVsIEluLU1lbW9yeSBBbmFseXRpY3MgQWNjZWxlcmF0b3IgKElBQSkuDQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBFbmFibGluZyBjb21wcmVzc2lvbiBmdW5jdGlvbmFsaXR5IGR1
cmluZyB0aGUgbGl2ZSBtaWdyYXRpb24NCj4gPiA+ID4gPiBwcm9jZXNzIGNhbiBlbmhhbmNlIHBl
cmZvcm1hbmNlLCB0aGVyZWJ5IHJlZHVjaW5nIGRvd250aW1lIGFuZA0KPiA+ID4gPiA+IG5ldHdv
cmsgYmFuZHdpZHRoIHJlcXVpcmVtZW50cy4gSG93ZXZlciwgdGhpcyBpbXByb3ZlbWVudCBjb21l
cw0KPiA+ID4gPiA+IGF0IHRoZSBjb3N0IG9mIGFkZGl0aW9uYWwgQ1BVIHJlc291cmNlcywgcG9z
aW5nIGEgY2hhbGxlbmdlIGZvcg0KPiA+ID4gPiA+IGNsb3VkIHNlcnZpY2UgcHJvdmlkZXJzIGlu
IHRlcm1zIG9mIHJlc291cmNlIGFsbG9jYXRpb24uIFRvDQo+ID4gPiA+ID4gYWRkcmVzcyB0aGlz
IGNoYWxsZW5nZSwgSSBoYXZlIGZvY3VzZWQgb24gb2ZmbG9hZGluZyB0aGUgY29tcHJlc3Npb24N
Cj4gb3ZlcmhlYWQgdG8gdGhlIElBQSBoYXJkd2FyZSwgcmVzdWx0aW5nIGluIHBlcmZvcm1hbmNl
IGdhaW5zLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhlIGltcGxlbWVudGF0aW9uIG9mIHRoZSBJ
QUEgKGRlKWNvbXByZXNzaW9uIGNvZGUgaXMgYmFzZWQgb24NCj4gPiA+ID4gPiBJbnRlbCBRdWVy
eSBQcm9jZXNzaW5nIExpYnJhcnkgKFFQTCksIGFuIG9wZW4tc291cmNlIHNvZnR3YXJlDQo+ID4g
PiA+ID4gcHJvamVjdCBkZXNpZ25lZCBmb3IgSUFBIGhpZ2gtbGV2ZWwgc29mdHdhcmUgcHJvZ3Jh
bW1pbmcuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gPiA+ID4gWXVh
biBMaXUNCj4gPiA+ID4NCj4gPiA+ID4gQWZ0ZXIgcmV2aWV3aW5nIHRoZSBwYXRjaGVzOg0KPiA+
ID4gPg0KPiA+ID4gPiAtIHdoeSBhcmUgeW91IGRvaW5nIHRoaXMgb24gdG9wIG9mIG9sZCBjb21w
cmVzc2lvbiBjb2RlLCB0aGF0IGlzDQo+ID4gPiA+ICAgb2Jzb2xldGUsIGRlcHJlY2F0ZWQgYW5k
IGJ1Z2d5DQpTb21lIHVzZXJzIGhhdmUgbm90IGVuYWJsZWQgdGhlIG11bHRpZmQgZmVhdHVyZSB5
ZXQsIGJ1dCB0aGV5IHdpbGwgZGVjaWRlIHdoZXRoZXIgdG8gZW5hYmxlIHRoZSBjb21wcmVzc2lv
biBmZWF0dXJlIGJhc2VkIG9uIHRoZSBsb2FkIHNpdHVhdGlvbi4gU28gSSdtIHdvbmRlcmluZyBp
Ziwgd2l0aG91dCBtdWx0aWZkLCB0aGUgY29tcHJlc3Npb24gZnVuY3Rpb25hbGl0eSB3aWxsIG5v
IGxvbmdlciBiZSBhdmFpbGFibGU/DQoNCj4gPiA+ID4gLSB3aHkgYXJlIHlvdSBub3QgZG9pbmcg
aXQgb24gdG9wIG9mIG11bHRpZmQuDQpJIHBsYW4gdG8gc3VibWl0IHRoZSBzdXBwb3J0IGZvciBt
dWx0aWZkIGluZGVwZW5kZW50bHkgYmVjYXVzZSB0aGUgbXVsdGlmZCBjb21wcmVzc2lvbiBhbmQg
bGVnYWN5IGNvbXByZXNzaW9uIGNvZGUgYXJlIHNlcGFyYXRlLg0KDQpJIGxvb2tlZCBhdCB0aGUg
Y29kZSBvZiBtdWx0aWZkIGFib3V0IGNvbXByZXNzaW9uLiBDdXJyZW50bHksIGl0IHVzZXMgdGhl
IENQVSBzeW5jaHJvbm91cyBjb21wcmVzc2lvbiBtb2RlLiBTaW5jZSBpdCBpcyBiZXN0IA0KdG8g
dXNlIHRoZSBhc3luY2hyb25vdXMgcHJvY2Vzc2luZyBtZXRob2Qgb2YgdGhlIGhhcmR3YXJlIGFj
Y2VsZXJhdG9yLCAgSSB3b3VsZCBsaWtlIHRvIGdldCBzdWdnZXN0aW9ucyBvbiB0aGUgYXN5bmNo
cm9ub3VzIGltcGxlbWVudGF0aW9uLg0KDQoxLiBEaXJ0eSBwYWdlIHNjYW5uaW5nIGFuZCBjb21w
cmVzc2lvbiBwaXBlbGluZSBwcm9jZXNzaW5nLCB0aGUgbWFpbiB0aHJlYWQgb2YgbGl2ZSBtaWdy
YXRpb24gc3VibWl0cyBjb21wcmVzc2lvbiB0YXNrcyB0byB0aGUgaGFyZHdhcmUsIGFuZCBtdWx0
aWZkIHRocmVhZHMgb25seSBoYW5kbGUgdGhlIHRyYW5zbWlzc2lvbiBvZiBjb21wcmVzc2VkIHBh
Z2VzLg0KMi4gRGF0YSBzZW5kaW5nIGFuZCBjb21wcmVzc2lvbiBwaXBlbGluZSBwcm9jZXNzaW5n
LCB0aGUgTXVsdGlmZCB0aHJlYWRzIHN1Ym1pdCBjb21wcmVzc2lvbiB0YXNrcyB0byB0aGUgaGFy
ZHdhcmUgYW5kIHRoZW4gdHJhbnNtaXQgdGhlIGNvbXByZXNzZWQgZGF0YS4gKEEgbXVsdGlmZCB0
aHJlYWQgam9iIG1heSBuZWVkIHRvIHRyYW5zbWl0IGNvbXByZXNzZWQgZGF0YSBtdWx0aXBsZSB0
aW1lcy4pDQoNCj4gPiA+ID4gWW91IGp1c3QgbmVlZCB0byBhZGQgYW5vdGhlciBjb21wcmVzc2lv
biBtZXRob2Qgb24gdG9wIG9mIG11bHRpZmQuDQo+ID4gPiA+IFNlZSBob3cgaXQgd2FzIGRvbmUg
Zm9yIHpzdGQ6DQpZZXMsIEkgd2lsbCByZWZlciB0byB6c3RkIHRvIGltcGxlbWVudCBtdWx0aWZk
IGNvbXByZXNzaW9uIHdpdGggSUFBDQoNCj4gPiA+IEknbSBub3Qgc3VyZSB0aGF0IGlzIGlkZWFs
IGFwcHJvYWNoLiAgSUlVQywgdGhlIElBQS9RUEwgbGlicmFyeSBpcw0KPiA+ID4gbm90IGRlZmlu
aW5nIGEgbmV3IGNvbXByZXNzaW9uIGZvcm1hdC4gUmF0aGVyIGl0IGlzIHByb3ZpZGluZyBhDQo+
ID4gPiBoYXJkd2FyZSBhY2NlbGVyYXRvciBmb3IgJ2RlZmxhdGUnIGZvcm1hdCwgYXMgY2FuIGJl
IG1hZGUgY29tcGF0aWJsZQ0KPiA+ID4gd2l0aCB6bGliOg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBo
dHRwczovL2ludGVsLmdpdGh1Yi5pby9xcGwvZG9jdW1lbnRhdGlvbi9kZXZfZ3VpZGVfZG9jcy9j
X3VzZV9jYXNlcw0KPiA+ID4gL2RlZmxhdGUvY19kZWZsYXRlX3psaWJfZ3ppcC5odG1sI3psaWIt
YW5kLWd6aXAtY29tcGF0aWJpbGl0eS1yZWZlcmUNCj4gPiA+IG5jZS1saW5rDQo+ID4gPg0KPiA+
ID4gV2l0aCBtdWx0aWZkIHdlIGFscmVhZHkgaGF2ZSBhICd6bGliJyBjb21wcmVzc2lvbiBmb3Jt
YXQsIGFuZCBzbw0KPiA+ID4gdGhpcyBJQUEvUVBMIGxvZ2ljIHdvdWxkIGVmZmVjdGl2ZWx5IGp1
c3QgYmUgYSBwcm92aWRpbmcgYSBzZWNvbmQNCj4gPiA+IGltcGxlbWVudGF0aW9uIG9mIHpsaWIu
DQo+ID4gPg0KPiA+ID4gR2l2ZW4gdGhlIHVzZSBvZiBhIHN0YW5kYXJkIGZvcm1hdCwgSSB3b3Vs
ZCBleHBlY3QgdG8gYmUgYWJsZSB0byB1c2UNCj4gPiA+IHNvZnR3YXJlIHpsaWIgb24gdGhlIHNy
YywgbWl4ZWQgd2l0aCBJQUEvUVBMIHpsaWIgb24gdGhlIHRhcmdldCwgb3INCj4gPiA+IHZpY2Et
dmVyY2EuDQo+ID4gPg0KPiA+ID4gSU9XLCByYXRoZXIgdGhhbiBkZWZpbmluZyBhIG5ldyBjb21w
cmVzc2lvbiBmb3JtYXQgZm9yIHRoaXMsIEkgdGhpbmsNCj4gPiA+IHdlIGNvdWxkIGxvb2sgYXQg
YSBuZXcgbWlncmF0aW9uIHBhcmFtZXRlciBmb3INCj4gPiA+DQo+ID4gPiAiY29tcHJlc3Npb24t
YWNjZWxlcmF0b3IiOiBbImF1dG8iLCAibm9uZSIsICJxcGwiXQ0KPiA+ID4NCj4gPiA+IHdpdGgg
J2F1dG8nIHRoZSBkZWZhdWx0LCBzdWNoIHRoYXQgd2UgY2FuIGF1dG9tYXRpY2FsbHkgZW5hYmxl
DQo+ID4gPiBJQUEvUVBMIHdoZW4gJ3psaWInIGZvcm1hdCBpcyByZXF1ZXN0ZWQsIGlmIHJ1bm5p
bmcgb24gYSBzdWl0YWJsZQ0KPiA+ID4gaG9zdC4NCj4gPg0KPiA+IEkgd2FzIGFsc28gY3VyaW91
cyBhYm91dCB0aGUgZm9ybWF0IG9mIGNvbXByZXNzaW9uIGNvbXBhcmluZyB0bw0KPiA+IHNvZnR3
YXJlIG9uZXMgd2hlbiByZWFkaW5nLg0KPiA+DQo+ID4gV291bGQgdGhlcmUgYmUgYSB1c2UgY2Fz
ZSB0aGF0IG9uZSB3b3VsZCBwcmVmZXIgc29mdCBjb21wcmVzc2lvbiBldmVuDQo+ID4gaWYgaGFy
ZHdhcmUgYWNjZWxlcmF0b3IgZXhpc3RlZCwgbm8gbWF0dGVyIG9uIHNyYy9kc3Q/DQo+ID4NCj4g
PiBJJ20gd29uZGVyaW5nIHdoZXRoZXIgd2UgY2FuIGF2b2lkIHRoYXQgb25lIG1vcmUgcGFyYW1l
dGVyIGJ1dCBhbHdheXMNCj4gPiB1c2UgaGFyZHdhcmUgYWNjZWxlcmF0aW9ucyBhcyBsb25nIGFz
IHBvc3NpYmxlLg0KSSB3YW50IHRvIGFkZCBhIG5ldyBjb21wcmVzc2lvbiBmb3JtYXQoUVBMIG9y
IElBQS1EZWZsYXRlKSBoZXJlLiBUaGUgcmVhc29ucyBhcmUgYXMgZm9sbG93czoNCjEuIFRoZSBR
UEwgbGlicmFyeSBhbHJlYWR5IHN1cHBvcnRzIGJvdGggc29mdHdhcmUgYW5kIGhhcmR3YXJlIHBh
dGhzIGZvciBjb21wcmVzc2lvbi4gVGhlIHNvZnR3YXJlIHBhdGggdXNlcyBhIGZhc3QgRGVmbGF0
ZSBjb21wcmVzc2lvbiBhbGdvcml0aG0sIHdoaWxlIHRoZSBoYXJkd2FyZSBwYXRoIHVzZXMgSUFB
Lg0KMi4gUVBMJ3Mgc29mdHdhcmUgYW5kIGhhcmR3YXJlIHBhdGhzIGFyZSBiYXNlZCBvbiB0aGUg
RGVmbGF0ZSBhbGdvcml0aG0sIGJ1dCB0aGVyZSBpcyBhIGxpbWl0YXRpb246IHRoZSBoaXN0b3J5
IGJ1ZmZlciBvbmx5IHN1cHBvcnRzIDRLLiBUaGUgZGVmYXVsdCBoaXN0b3J5IGJ1ZmZlciBmb3Ig
emxpYiBpcyAzMkssIHdoaWNoIG1lYW5zIHRoYXQgSUFBIGNhbm5vdCBkZWNvbXByZXNzIHpsaWIt
Y29tcHJlc3NlZCBkYXRhLiBIb3dldmVyLCB6bGliIGNhbiBkZWNvbXByZXNzIElBQS1jb21wcmVz
c2VkIGRhdGEuDQozLiBGb3IgemxpYiBhbmQgenN0ZCwgSW50ZWwgUXVpY2tBc3Npc3QgVGVjaG5v
bG9neSBjYW4gYWNjZWxlcmF0ZSBib3RoIG9mIHRoZW0uDQoNCj4gWWVhaCwgSSBkaWQgd29uZGVy
IGFib3V0IHdoZXRoZXIgd2UgY291bGQgYXZvaWQgYSBwYXJhbWV0ZXIsIGJ1dCB0aGVuIEknbQ0K
PiB0aGlua2luZyAgaXQgaXMgZ29vZCB0byBoYXZlIGFuIGVzY2FwZSBoYXRjaCBpZiB3ZSB3ZXJl
IHRvIGZpbmQgYW55IGZsYXdzIGluIHRoZQ0KPiBRUEwgbGlicmFyeSdzIGltcGwgb2YgZGVmbGF0
ZSgpIHRoYXQgY2F1c2VkIGludGVyb3AgcHJvYmxlbXMuDQo+IA0KPiBXaXRoIHJlZ2FyZHMsDQo+
IERhbmllbA0KPiAtLQ0KPiB8OiBodHRwczovL2JlcnJhbmdlLmNvbSAgICAgIC1vLSAgICBodHRw
czovL3d3dy5mbGlja3IuY29tL3Bob3Rvcy9kYmVycmFuZ2UgOnwNCj4gfDogaHR0cHM6Ly9saWJ2
aXJ0Lm9yZyAgICAgICAgIC1vLSAgICAgICAgICAgIGh0dHBzOi8vZnN0b3AxMzguYmVycmFuZ2Uu
Y29tIDp8DQo+IHw6IGh0dHBzOi8vZW50YW5nbGUtcGhvdG8ub3JnICAgIC1vLQ0KPiBodHRwczov
L3d3dy5pbnN0YWdyYW0uY29tL2RiZXJyYW5nZSA6fA0KDQo=

