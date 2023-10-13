Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9CE7C7F9B
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:10:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDDW-0007pI-SX; Fri, 13 Oct 2023 04:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qrDD8-00072A-JN
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:07:58 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qrDD4-0001Ci-WB
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697184471; x=1728720471;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=q4bnTw/9VYd3NmdknBjoOJhLLSlshadwv304BbtVRRQ=;
 b=U20lGXcA33/9JjqwndBWbjeyxx7AWAbGjO9nnmIfdS0l/v1nf/i/COyA
 u6yvl4T8PB3j9csyPGVu3jqRPbaRStuCBfOh+n1O4oIjARs8A+dyUI8Nt
 sjilQYq1X0bLJBP+gRRXcIFGsg7815f7dBa1uYVbtbJ0j6s5yxMhhzw1h
 sRZ7y9ijwGXzfHeHXngNUbi0DnS4sDH/pgc1xfw82iTgGb4EJYs+iE14u
 g/8g7YZO7IaHPupfd/xVyGWMIJf/RhCY52k+ZXc+4cMhmB95Yir+fHpuJ
 xHNgblR6LnLWW8toLehzLjBTm7wfpSsuynudxaDRgXx94TZq6aLg8cps/ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="98958047"
X-IronPort-AV: E=Sophos;i="6.03,221,1694703600"; d="scan'208";a="98958047"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2023 17:07:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWXFrrDOu7/2X9olx0DTkDs/pUCgdOJhntm1Qd4bedWGNNI9SuFeNgOZpN+A2tEf0F5/uTGYEO55bCUUPOO73dfu4vpy7KRD0oU2JrvwinV+FsIDWeo99buN+9GYiHI5H2Y9SRmBodKsxc9LWh2hV6jEW+ij92y7ntjhUSIvyBxWZ2H7cIwhm2gcMY9C+jrNf3A7e2oPjutgtqCM9/QPBQabykwegfkxgUAX6igAIlvSkBR6VQjD0/iWwZR+JqVJq1cJ7vEMmYpBF1SUwU4+u/8BAPuOHr8foVoYkSetEcw5NseuDZdJkNO3IVYBUWb8qIAzYSlgUaN7gDIuVJSJHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4bnTw/9VYd3NmdknBjoOJhLLSlshadwv304BbtVRRQ=;
 b=MXHKs3DIJfIPaBnpMvu4/nu6AVE38J8z671C/x6HaoiKgH8G/qEgjRn5mwx/oXcK9IsJd6xFQRcN9fAdlXKufKrnuysjRzTVnlkDBmFN965H0RaYg8Y6njdXLdcJqQjk2uChQw144zBLmyL256sW+O32LDiMgABysBWVed4B0O3oEo+uaTWB6TkAkDLghjltVjRRueFDgVVog00o7497npDQtyPumxo5yRLK0PkMRMffyt06yDalz/DbVqQAPLlEVBIm2V7EOo2u8PCmbHWDZE2Yiv5jchDPzGXUL8MoGlpmhvr45mhf2L/n7xar/fUHdAWkouTX0AZwYRnDbeKSxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TY3PR01MB9857.jpnprd01.prod.outlook.com (2603:1096:400:22b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 08:07:43 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 08:07:43 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>, Leonardo
 Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 07/13] qemu-file: Remove QEMUFileHooks
Thread-Topic: [PATCH v3 07/13] qemu-file: Remove QEMUFileHooks
Thread-Index: AQHZ/IKERE1xdBiiJkOE0ClvZ+XFSLBHX6gA
Date: Fri, 13 Oct 2023 08:07:43 +0000
Message-ID: <5197f315-14be-5296-57fc-caaae3e7f716@fujitsu.com>
References: <20231011203527.9061-1-quintela@redhat.com>
 <20231011203527.9061-8-quintela@redhat.com>
In-Reply-To: <20231011203527.9061-8-quintela@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TY3PR01MB9857:EE_
x-ms-office365-filtering-correlation-id: 3de67be3-a2f1-4e00-6431-08dbcbc37a4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EN4i7AfH52z/Skj3FOtkUvucvKpJIzInEgZEmrmre7FwvjU+VBGv9oVlrrKLlcCObtHOKzbjwMkEtyyMxJ7UBV7LwClNBgj4tTFkPaPNvpTWNOsZydE7Ge/M2vhAOn7HzyPKw4Iwh9BnAhpD3aymnrabrELbekzhTGjqceE9NZiGIm1bicEVVnU0F/MfTnSnyXmc6/ifc+HVchktOGWYNof+FSvZQfZ+Ggmkykx5QTEei88NKhevkPzS6ayIQ5emJPeAFeLiaGDsywYDG++eDIRgbwRGGItRoZa5GC/0R4dS7eV5RatbBvozCU9e9PnUV5pB9oLezju0ZM+fGxga4ko6D/7tWdmTyLcRu7lwUzXjPNOBPWYjHgGpVem4HXyd68pNyq7MkUsNPga08u4svnUSanmAJVf1nGrBEhFmhvtYuVzcx+pFbOtZ8Ou2eC0VdXaRZhPu0JpU7reQU8nJ0GhP584V5fTofCgjkaI0zbEfPyTFd5Vpcm5Oo0J6PskqhIpBWALD7bDEuyFu1BRYpVOZ1ZpxBo/Iw5soNNbO3GEcjytJgfmi2wKJZ5LcEFnrXoxshGKEvy68lKiqqTPODQg5jp8k7hc0wH8qFXGQrxjDGfgRcgaMdzBrEU/af9dfOMIHOx/Q8ptnEccevaCSK8Ar7708DRzM70kCs6snTxv+jAjPWSwLM2OkCwyDvOTx8iZRVF63/nUnEPxxxLfHqw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS0PR01MB5442.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(1590799021)(451199024)(85182001)(36756003)(86362001)(31696002)(31686004)(1580799018)(91956017)(110136005)(66476007)(64756008)(54906003)(316002)(76116006)(66446008)(38070700005)(82960400001)(38100700002)(66946007)(122000001)(66556008)(53546011)(71200400001)(83380400001)(26005)(2616005)(41300700001)(5660300002)(6512007)(6506007)(8676002)(478600001)(8936002)(6486002)(2906002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUg5bFgzSThpNGlnTS9YYlZ0Umx6clpLZWpsbGdjK2dVZzYzNlJvTjc3ZmVT?=
 =?utf-8?B?djdySm4zMFZsWWJSejZmaXc5amkrVGVYL3dDY2FaQXZLMmdxKzhnTVkySFlp?=
 =?utf-8?B?Rm9hakV1ZGsxbGkzTndVaUc0UWtQTjR0WXVXS0hjMzR5OXl1ODQxZkJYT0Jp?=
 =?utf-8?B?WGhKMUFGWnIxc0hCVm1raEh2SnFoU2FhYXJkdHhwRHp2cXNpL2xES1BJVFZx?=
 =?utf-8?B?OE1ycHdXOGhBclhIeEEyaitaeEdodW9nS1BIRzl0ZkNYMjFGQWh5K3Ivejdj?=
 =?utf-8?B?U1NwQVFIbE83MmlBM04wWllGZUJKS0RobFZmdTEwNFF0dE96bnM2bmp0M3JQ?=
 =?utf-8?B?UkxkUlNnYXRidG1nYkVjOUhocUxzbXZZMWhRUUZnNVBITko0MlFOdFI0cDVC?=
 =?utf-8?B?VVlmMWVFQXFKeDZheEE4RlB2RlJxWXY3VG4zcHRKdjZYODBqc3lxNFdXZjlE?=
 =?utf-8?B?SVkyNEIrWWxkTEdjSzFnR0N5RHVSRmoyMzByY3ZBNUQvM0oyUEU3Y0ZDby9N?=
 =?utf-8?B?UkFiV01yRUQ5bFJPUDE3UDFoWVpudEVucXMzdmkvd2pzbW5LbkVkbHpQdjhM?=
 =?utf-8?B?bWJsN1J1VjRYV0ZPcUQ4TWVMRHd1N1JyVWRaRzZKbE9xUFhkd25helNuNlFo?=
 =?utf-8?B?M09zenpkTHA3d29xdDAzSGdZMjdnMmQ3WTZjNWNVM0twaWpXNmtKdVVrWTJl?=
 =?utf-8?B?ckpteXN2N2xib2hpS1NNcGhiWkNBaG5QSmRQdEVWWmFFdFM3UWhLaUIvcHBK?=
 =?utf-8?B?VlppTG5QQ0dRclJqYU5kOFBBMWc0THd3YVZsTTZ5bFNCQStlSjA5TUJ5eU41?=
 =?utf-8?B?c1czMXhLbjBmTUxyN295dHJFZGh4V0ZoWTlqd2ZjWHNDcDRXT3E3aVZkTU5M?=
 =?utf-8?B?MitSanBoeTk2TzNUK0tVRGR1aW9iSzNXaWc3SnFpSUo2VGM0a1JoaGZ0R3Bw?=
 =?utf-8?B?NmJzSE5XNVBGRW5hYXErUFFCeVEvNUtTU1htTk5FTjZDKyswMENSZ3JScTNy?=
 =?utf-8?B?VFUra09JVnJVMnBPSkN4aW5DbUhlMTJFczZIZzEweExIUWxLb0VDYjlCUkVu?=
 =?utf-8?B?cml4YkV5ODdoNm5OSVBjTGdCZGFXZXNXc3lEVUk1M3B6YXRiOWNWeW41a2JD?=
 =?utf-8?B?NmdyOFRtSmtSUGVNaDcxeFNjM1pWNjhrK2FmVDlyaTZnN2RNL2dEVHd4SU9U?=
 =?utf-8?B?Z3dxVUhhZ21pbnExWUxBZ2M2TDl2VGU5Zmd1b21WSmswZmR4OFVFWUU5TStH?=
 =?utf-8?B?NWRrVUxUTExxRkxEWFk4SWdKWkRUL2pWWXAwcVBoK09NeE00aWdCS2tBSGRa?=
 =?utf-8?B?ZWZtZmxSM3RQaDlsWENBYXQrODc0VURjaHZMR3VnYU5UeFgxYjNEdEoyUEdB?=
 =?utf-8?B?TCtIR0s3dUhqc0pERlc2VTFVQXNyMHYzck9xYTZUMnQzOS90b2Y4bVMrQzdi?=
 =?utf-8?B?MGNRUWdJb3pDcVBvV2JqZFpzMUpCVitJY0xrV2tZZS85Rks4d2lkZFNhTkFu?=
 =?utf-8?B?Zmx0cGlwajlPQVZaSmEwVklxWUhKZ3d1ckJyZ2ZlR0hRY3ZkM0NNVDc0Z2Fi?=
 =?utf-8?B?bHlSdDN2N0s4b0gvU1RnUldydjdyQVozUEMzWlpOZHNBTFozTmVTZVpZa2Ro?=
 =?utf-8?B?ZzBpTTdlMFcwM2ViQnFmVmZkRXQxcGdGZ0kzeUcrTnd1Ullyd2V4aTN6VTZ0?=
 =?utf-8?B?Zm1PY2Q3OEhQT0xyOFRRcXhlS29LbTBUdTh4RmFObHBPOEkzREZVVVJTYTZL?=
 =?utf-8?B?TFRzTGJSYnJqOUdqTlpGYmNsS1A1eVB2V3lVY21Zeml2dVd0ME1YYTN1aG5n?=
 =?utf-8?B?YTJsRFIxOG1PQ1VocG9LSlVza21CbUQrbEdrbXJaaWZBRnN6MWpEV0JGb0tJ?=
 =?utf-8?B?SVRLMjBvUW9jaDIvNElYZTR0NDBGM3JmNGlDRnpIUTJOcEdlc3ZvcmdFTlFk?=
 =?utf-8?B?cTlWRHRwWVdjaVU5UFVDNWg0QUxzNGpzM3JBbXBRN1hQZ3JYeTlkM0tRazBn?=
 =?utf-8?B?VXZJTktETHlDRmhjd3d5L3ZTSUorcFNPaGxVZmcxa3RFYnNLV1hQbHZ5TTZl?=
 =?utf-8?B?UnkvVDZnMWFVQnZIbExxTDBQQW5pTTltL3R6QXlLSWRCTGhhM2NHV0hMZkRm?=
 =?utf-8?B?cUp6WXV0b0hWYlBEbkhXWlM3b0QwYTlHVmtpQnZIM0NjSEV6WmVoUy9SR3Fa?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87D0911D3D28984EA1527E6901A0F8BB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nowK21RYZImeqLUOeBGXQrXADLuJHh7eJARtvYYjSpbr4zkTJfiy+eYR+OS8sNiUnW71vRJCi+/zXJqWRtZrfmURXd4A6pscJidLeAU+9jRc1UUkv4z9fPySLvaDSRwid8lQ+BpqfDA1poffCQPdpu2LVd6BWgITYzbg3BYLx5cTyJLdgYU6MJwvar3WsE4YcEP77Zwp4Lv8mrid4W0KBnVsXmHUJgD/0f63pvtlMzU+XL/A9o/Q3oReOHrDpiTzfPs5bCPZ/Ai/efnWrysgwLlhiTWqQ0UaBXHN0L4jkn9Ob+Y+cyY+H+MOhjVXxXvJklqJDgSDMlKPyQXQgwX+hUrbRheNjg8kkdCVlYKcvtxmcAzaPFxWFUMBg44LaBS0Yjooq+hjmRHai9Lo6bs1pZ0zorE7qCGcdtS+FcZaAWpWVR96aweJMLLI3hPMDnSdR6iVbmqupnmjKzGHwps0RXMPb79OLmP7+BBk30p/Jq2alS5NdiUJXBGDwxz26FNuTrk/GSsp5ezI/hktpzAobA4K/TefY8+xaIDISjAqQyNxDLu/trb9gaUPUbCOifse8z2WEHyKFBaNJywHQSgLUop0CWz/55jZzCMKBYYeDmZJvrWOsBRXrqYFpYwRGUPiagdZtDwmKdGBUlFt/FBqFl/qxeEV34jkgk27/ynU+sHUrpc8ZxnVQ/T9Q2AYCk8reiSDtcW9LlzCUWQ4kDbhng02aft3c16lueIVyVE84DkvxQFMw1KFwfACtlvsU/S0yXfvX8XmuiidqlvBbphPrQfbCU3izA6W8IiJAT6Sfxfj+tXv6nVNC9t3WtuhP7P+
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de67be3-a2f1-4e00-6431-08dbcbc37a4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 08:07:43.3782 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jnmiitT4LH3hyZBPdFJLfYoTqz4t78C4nSxCOfSB92j9fEDbv29/b1Ss4TOp/wM5+8ew7h7cdVXQeEFnRdtlOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9857
Received-SPF: pass client-ip=216.71.158.65; envelope-from=lizhijian@fujitsu.com;
 helo=esa20.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -76
X-Spam_score: -7.7
X-Spam_bar: -------
X-Spam_report: (-7.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCk9uIDEyLzEwLzIwMjMgMDQ6MzUsIEp1YW4gUXVpbnRlbGEgd3JvdGU6DQo+IFRoZSBvbmx5
IHVzZXIgd2FzIHJkbWEsIGFuZCBpdHMgdXNlIGlzIGdvbmUuDQo+IA0KPiBSZXZpZXdlZC1ieTog
UGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKdWFuIFF1aW50
ZWxhIDxxdWludGVsYUByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogTGkgWmhpamlhbiA8bGl6
aGlqaWFuQGZ1aml0c3UuY29tPg0KDQo+IC0tLQ0KPiAgIG1pZ3JhdGlvbi9xZW11LWZpbGUuaCB8
IDQgLS0tLQ0KPiAgIG1pZ3JhdGlvbi9xZW11LWZpbGUuYyB8IDYgLS0tLS0tDQo+ICAgbWlncmF0
aW9uL3JkbWEuYyAgICAgIHwgOSAtLS0tLS0tLS0NCj4gICAzIGZpbGVzIGNoYW5nZWQsIDE5IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9xZW11LWZpbGUuaCBiL21p
Z3JhdGlvbi9xZW11LWZpbGUuaA0KPiBpbmRleCA2MDUxMGEyODE5Li4wYjIyZDgzMzVmIDEwMDY0
NA0KPiAtLS0gYS9taWdyYXRpb24vcWVtdS1maWxlLmgNCj4gKysrIGIvbWlncmF0aW9uL3FlbXUt
ZmlsZS5oDQo+IEBAIC0zNiwxMiArMzYsOCBAQA0KPiAgICNkZWZpbmUgUkFNX0NPTlRST0xfUk9V
TkQgICAgIDENCj4gICAjZGVmaW5lIFJBTV9DT05UUk9MX0ZJTklTSCAgICAzDQo+ICAgDQo+IC10
eXBlZGVmIHN0cnVjdCBRRU1VRmlsZUhvb2tzIHsNCj4gLX0gUUVNVUZpbGVIb29rczsNCj4gLQ0K
PiAgIFFFTVVGaWxlICpxZW11X2ZpbGVfbmV3X2lucHV0KFFJT0NoYW5uZWwgKmlvYyk7DQo+ICAg
UUVNVUZpbGUgKnFlbXVfZmlsZV9uZXdfb3V0cHV0KFFJT0NoYW5uZWwgKmlvYyk7DQo+IC12b2lk
IHFlbXVfZmlsZV9zZXRfaG9va3MoUUVNVUZpbGUgKmYsIGNvbnN0IFFFTVVGaWxlSG9va3MgKmhv
b2tzKTsNCj4gICBpbnQgcWVtdV9mY2xvc2UoUUVNVUZpbGUgKmYpOw0KPiAgIA0KPiAgIC8qDQo+
IGRpZmYgLS1naXQgYS9taWdyYXRpb24vcWVtdS1maWxlLmMgYi9taWdyYXRpb24vcWVtdS1maWxl
LmMNCj4gaW5kZXggNzQ1ZWFmN2E1Yi4uM2ZiMjUxNDhkMSAxMDA2NDQNCj4gLS0tIGEvbWlncmF0
aW9uL3FlbXUtZmlsZS5jDQo+ICsrKyBiL21pZ3JhdGlvbi9xZW11LWZpbGUuYw0KPiBAQCAtMzgs
NyArMzgsNiBAQA0KPiAgICNkZWZpbmUgTUFYX0lPVl9TSVpFIE1JTl9DT05TVChJT1ZfTUFYLCA2
NCkNCj4gICANCj4gICBzdHJ1Y3QgUUVNVUZpbGUgew0KPiAtICAgIGNvbnN0IFFFTVVGaWxlSG9v
a3MgKmhvb2tzOw0KPiAgICAgICBRSU9DaGFubmVsICppb2M7DQo+ICAgICAgIGJvb2wgaXNfd3Jp
dGFibGU7DQo+ICAgDQo+IEBAIC0xMzMsMTEgKzEzMiw2IEBAIFFFTVVGaWxlICpxZW11X2ZpbGVf
bmV3X2lucHV0KFFJT0NoYW5uZWwgKmlvYykNCj4gICAgICAgcmV0dXJuIHFlbXVfZmlsZV9uZXdf
aW1wbChpb2MsIGZhbHNlKTsNCj4gICB9DQo+ICAgDQo+IC12b2lkIHFlbXVfZmlsZV9zZXRfaG9v
a3MoUUVNVUZpbGUgKmYsIGNvbnN0IFFFTVVGaWxlSG9va3MgKmhvb2tzKQ0KPiAtew0KPiAtICAg
IGYtPmhvb2tzID0gaG9va3M7DQo+IC19DQo+IC0NCj4gICAvKg0KPiAgICAqIEdldCBsYXN0IGVy
cm9yIGZvciBzdHJlYW0gZiB3aXRoIG9wdGlvbmFsIEVycm9yKg0KPiAgICAqDQo+IGRpZmYgLS1n
aXQgYS9taWdyYXRpb24vcmRtYS5jIGIvbWlncmF0aW9uL3JkbWEuYw0KPiBpbmRleCBiZjE2OTkw
ZjkxLi5jYTJhMTViZTk5IDEwMDY0NA0KPiAtLS0gYS9taWdyYXRpb24vcmRtYS5jDQo+ICsrKyBi
L21pZ3JhdGlvbi9yZG1hLmMNCj4gQEAgLTQwMDQsMTMgKzQwMDQsNiBAQCBlcnI6DQo+ICAgICAg
IHJldHVybiAtMTsNCj4gICB9DQo+ICAgDQo+IC1zdGF0aWMgY29uc3QgUUVNVUZpbGVIb29rcyBy
ZG1hX3JlYWRfaG9va3MgPSB7DQo+IC19Ow0KPiAtDQo+IC1zdGF0aWMgY29uc3QgUUVNVUZpbGVI
b29rcyByZG1hX3dyaXRlX2hvb2tzID0gew0KPiAtfTsNCj4gLQ0KPiAtDQo+ICAgc3RhdGljIHZv
aWQgcWlvX2NoYW5uZWxfcmRtYV9maW5hbGl6ZShPYmplY3QgKm9iaikNCj4gICB7DQo+ICAgICAg
IFFJT0NoYW5uZWxSRE1BICpyaW9jID0gUUlPX0NIQU5ORUxfUkRNQShvYmopOw0KPiBAQCAtNDA2
Miw3ICs0MDU1LDYgQEAgc3RhdGljIFFFTVVGaWxlICpyZG1hX25ld19pbnB1dChSRE1BQ29udGV4
dCAqcmRtYSkNCj4gICAgICAgcmlvYy0+ZmlsZSA9IHFlbXVfZmlsZV9uZXdfaW5wdXQoUUlPX0NI
QU5ORUwocmlvYykpOw0KPiAgICAgICByaW9jLT5yZG1haW4gPSByZG1hOw0KPiAgICAgICByaW9j
LT5yZG1hb3V0ID0gcmRtYS0+cmV0dXJuX3BhdGg7DQo+IC0gICAgcWVtdV9maWxlX3NldF9ob29r
cyhyaW9jLT5maWxlLCAmcmRtYV9yZWFkX2hvb2tzKTsNCj4gICANCj4gICAgICAgcmV0dXJuIHJp
b2MtPmZpbGU7DQo+ICAgfQ0KPiBAQCAtNDA3NCw3ICs0MDY2LDYgQEAgc3RhdGljIFFFTVVGaWxl
ICpyZG1hX25ld19vdXRwdXQoUkRNQUNvbnRleHQgKnJkbWEpDQo+ICAgICAgIHJpb2MtPmZpbGUg
PSBxZW11X2ZpbGVfbmV3X291dHB1dChRSU9fQ0hBTk5FTChyaW9jKSk7DQo+ICAgICAgIHJpb2Mt
PnJkbWFvdXQgPSByZG1hOw0KPiAgICAgICByaW9jLT5yZG1haW4gPSByZG1hLT5yZXR1cm5fcGF0
aDsNCj4gLSAgICBxZW11X2ZpbGVfc2V0X2hvb2tzKHJpb2MtPmZpbGUsICZyZG1hX3dyaXRlX2hv
b2tzKTsNCj4gICANCj4gICAgICAgcmV0dXJuIHJpb2MtPmZpbGU7DQo+ICAgfQ==

