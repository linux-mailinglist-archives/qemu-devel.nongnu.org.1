Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 661B9749CB0
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 14:52:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHORe-0007a8-0H; Thu, 06 Jul 2023 08:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.hogberg@ericsson.com>)
 id 1qHORa-0007Yh-9c
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 08:50:46 -0400
Received: from mail-ve1eur01on2079.outbound.protection.outlook.com
 ([40.107.14.79] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.hogberg@ericsson.com>)
 id 1qHORY-00025h-Dz
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 08:50:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFxvCTarJCDNgeJOqI2HI5ncmWML4UiKTVutmpCr33vfylurAJ5GeMua5Cn4XMT/f8KfqJOVa4LvDY1YW2Pj3niHM3p2yEGI3C0UXkW4/DsR2pq+QLRUne8RQGc7teP8GXNr5sWvQwr+90E42MrzX3t/77ybJDsRFwrnjmN/RznlkyD/hY0gBSMOA7ApLLb60L+8YxXj/JsD9CPhX/n7t1X6SyVcq4i3iS13ii7ShfFFJw8EMZJN9RbyWGBcQCVPnJKM5a93HemVKALxN1uI5+ej75dsfzh4wfcd8lIE5u0qAJXqfSCyC4t55bP8t5VzB01xfVarq8Wwm4lL8rfXAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5/o4jqUDFRfIDjGalw0S5j5EbVlLnvj0sUP9UCPw8g=;
 b=R1HWVGQV+8WkbjMys+AYrVC1d+XaZMVue1+eG5NfsblTY/JOzFcXV5oCzfPJ0p1xR1ayTUNadXYWz1vtx1anVAJ3Q4TCnDq3aEt7i4lKW6Ikd0mNt4dyPmvCjq7Ee5VMaaWVAbBP3vVq0VGCTOzf7c0qy1LpBnU+wlV4wNcVkHklZEDN5UaD4c8INisWXQfxbiYN7y8072yKlSwMDXyt8dDygm8SBTjXj0KajiB+0x7emn6xq9hqy0cHC3EQzyWId02Tw3MiteLX6j+G0CbnBkbUP5jYe79wxOBCORCjbmOFBwc4xQFZ44OxJUF1Js70sKMgtxAg2pT92eZGatff4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5/o4jqUDFRfIDjGalw0S5j5EbVlLnvj0sUP9UCPw8g=;
 b=B2+n0QJLHlHVzCqH3c8M+L3HJEzFCuuG90T9HOldqC8kQBxHdgA2B+yYew+b3N/Y93WlPd+l9+8XJMqW7hQkzOKZIowWlRwcplo3zyWiZ1Bz2TRsxXVaNQDE7z0aGlQE6RfrIWUP1C1yDqESB4sEeUY6ThEEparDgXvIJLHs7/g=
Received: from DU0PR07MB8833.eurprd07.prod.outlook.com (2603:10a6:10:310::5)
 by AS8PR07MB9332.eurprd07.prod.outlook.com (2603:10a6:20b:618::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:45:35 +0000
Received: from DU0PR07MB8833.eurprd07.prod.outlook.com
 ([fe80::fe43:aa1:308c:b32b]) by DU0PR07MB8833.eurprd07.prod.outlook.com
 ([fe80::fe43:aa1:308c:b32b%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 12:45:35 +0000
From: =?utf-8?B?Sm9obiBIw7ZnYmVyZw==?= <john.hogberg@ericsson.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "philmd@linaro.org"
 <philmd@linaro.org>
CC: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PULL 07/11] tests/tcg/aarch64: Add testcases for IC IVAU and
 dual-mapped code
Thread-Topic: [PULL 07/11] tests/tcg/aarch64: Add testcases for IC IVAU and
 dual-mapped code
Thread-Index: AQHZrpXy6z7PV/lvLU251CqHWLCVua+qnCOAgABL3ACAAcUCgIAABVUA
Date: Thu, 6 Jul 2023 12:45:35 +0000
Message-ID: <9cc96e295ba6ee2e8cad5cf82da6b926713fa9fd.camel@ericsson.com>
References: <20230704163634.3188465-1-peter.maydell@linaro.org>
 <20230704163634.3188465-8-peter.maydell@linaro.org>
 <2e39933a-b9d9-5792-8c4e-dd558d4aad5d@linaro.org>
 <dd6a96b4-1b72-67e2-58ce-8011203128ae@linaro.org>
 <CAFEAcA8o8nG7_DWnjYHOL7R2x1DjJdQ-=Moe_jkSibXscZ2mQg@mail.gmail.com>
In-Reply-To: <CAFEAcA8o8nG7_DWnjYHOL7R2x1DjJdQ-=Moe_jkSibXscZ2mQg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR07MB8833:EE_|AS8PR07MB9332:EE_
x-ms-office365-filtering-correlation-id: 1e0eea06-8664-4f03-ab93-08db7e1ee4c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HC43QFsJtLDXgYYPHqcv8TkAQ7P536Xru2ZofLoQPkSqDGZy828yHXU+Nw968hUdirs/0NdK2YK9gAywikQqxYH5/8GIhk1itdMWLs4uq6yYRc8t4moQ2MTvYNOdorezkWkbLrsgEi5GXCmIsdb8v9bkZwpSpsL+E0+ubK9I6ZRh5GXH4v2j2uJvsjR4aAEOFYXVbbNBMGWsNHbR3zd7chgiLhSgCHg9Mm0elTFLK1Uti1XonbNVb4LgsEVXP2B9tjv1CucootkANLAMK1KydZGUXWS5KvIauPPQv+L6QRIwUVZc6F+VpJdfiqaTRIeQzMN+eYiUhSW+0n/Xq2zuVLhwa0cBQWAgS3rFUeUh7d0adg2gUWq3a3Db1CyYWCIw+k1GzEzOpmZf44HZVhbqT5aXl1Ux7PO68VBiUJYC1BmDiypAa91GwRGaxvHJP6LvilsyKOjSGE+pv0Q1tFdqafkzF+Y8OWGUL5mQhMyxCvYlCu4hUuCfksVO6ZldLocA3/cMrMQBKIiHkS4O//qotDS7ckTaIba9bjtqzRx4J1Afjx735v6T8ZTBUEA/ij4lM7tZherXerrLbQixNCLm4coiZqMD8rrbdktw50ShI7VMQinj6WDWF598fo40syJR55Tn9vtpLRO9oXCPRHPl1w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR07MB8833.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199021)(186003)(8676002)(8936002)(6506007)(26005)(2906002)(2616005)(66946007)(76116006)(85202003)(5660300002)(4744005)(41300700001)(36756003)(91956017)(71200400001)(122000001)(6486002)(82960400001)(4326008)(85182001)(64756008)(316002)(66476007)(66446008)(83380400001)(66556008)(110136005)(54906003)(6512007)(966005)(478600001)(38070700005)(86362001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ck5BM0lVUzdGdHR6S0N0VnZ4R1BaU0ZKRnBJbWZBUllGSFJYMFZWdnlsQnBo?=
 =?utf-8?B?YVNyb1VlK3htRlJIRjVUcDVuSlR6QUEwaUtBRDVOQ2lhbTAybXI2dlM0ZjM0?=
 =?utf-8?B?UC9FQUE3dkJwejJJbUhwTHd3OFRYYkNqT2hSSmZqc0xpODdDNGtlTHEvdWR3?=
 =?utf-8?B?YUtxcXk4VUJacVQ1V1pHbkFDTlJhVzN4a2ozRFZIc3FRbjV3N2crS1BxNTdK?=
 =?utf-8?B?cVlBVzNBb3oxWkY2RWtlRy9uL2FGdnlEQmZnaU9YYlMvYmNUL1hHUWRndGg0?=
 =?utf-8?B?cWhlVDB3b09LVkdTbW5EelJjb2lxekFBa0hCMERHQkpiVTBVNjBDcUFaMkhi?=
 =?utf-8?B?ZTdIYUhZMTl4dmo4QlJjbmlUM3JZeHpCTFJ1SVVDaGdLcjFGVXd4bUpQSzhw?=
 =?utf-8?B?blh3aFl4U050V0lGQlE4NC9ReWYrcUdoazFWUE5UYkZQcVRlTDFKL0JYQ21i?=
 =?utf-8?B?dUJNRmxvRnIyV25Oc1liQW9WaldmRUNPYzRBTTF4SUE5NDJjSS9ueXB0aWRz?=
 =?utf-8?B?UE9DMGVjQ1Q1MHdSSTRUMUNaMFV6YWRrZFkyV2RvVk41SDE1bURwSHFUVURQ?=
 =?utf-8?B?aDY4QTdHdkpoalh5VGFFRnVpUHYxbzEyK3VoaHJyMlJFclN0RlBuVTdXaWRj?=
 =?utf-8?B?SFpZVTlCZmt1NnFrc0N5Y1VxM21nZmR4clc5TjVJb2w3YXdNZ1ZxNkE1dG5q?=
 =?utf-8?B?Q0xUTGpaSjhWR0huVW9LS2R1c0Y2RzJKMGVmZE4yUWZ3dlZ5L3JTWDNqUlhL?=
 =?utf-8?B?QnNTVmNIdmlTZW1VbGl4YWprRnhVS25oUEJrbmVXcElXdm02ODlJR05IeXp1?=
 =?utf-8?B?MVdna1orclNKYjlpY3QrVFE3UTc5Q3dEV1VONy9CcTRlWU14OEkvQm5VSzVq?=
 =?utf-8?B?aWtmZFRFRzB3aFZTZ1Y0SnZhRTRPeC9QYWk0QkpqbnFnRFdTQUoyQWJBeEJ3?=
 =?utf-8?B?WXFsR0t0QXVJcGpyUHBQL0tqTmRJNSsxc1ZtVTNsRkt6OWFLSmJrZ3FsaHhJ?=
 =?utf-8?B?SWsvOEVVSVg3bWtCL1dRMWRDQzRka1MvcjhiRWFwV0VRbW9nNjJGVnpQOHBK?=
 =?utf-8?B?MndsaU4wc09VTjYxZktRcHIrTnBJK05sWDlLcGZvQUNLdnhUVmlTVTFvOVJl?=
 =?utf-8?B?WXpkanhIN1E0VS9GWlpRVDJITmdaaUNlcHBpMk5GV1lSUjUyREJzdVRJYnhZ?=
 =?utf-8?B?KzMyV1MwYzlOTTlFeE9aM2dpSGxwZC9rTVdHREd4T2RyME5PbVp3MVNjZlpm?=
 =?utf-8?B?Vm44VEpCSisyYUhUdzFlVURObnZrMjAwT1RINWxxSjdZejk2aktPelEwa3pk?=
 =?utf-8?B?Q1JsZVRNQks2SW5wWFhzUkI5TndQRHFJdkxaNlo1aEhMMkNzeUsva2I3VlNL?=
 =?utf-8?B?Nkw3QkJSZ1hNMURIK3dxOEY4eW9iSHVtZnZScjNqdm1XbHRRWFVpZ1AyUFFu?=
 =?utf-8?B?QUdsWlh0ZjlKOVNQa1VyMjVxU3hkMU05QTBkTW5DTWVxL1Q4WWF6QWducEdt?=
 =?utf-8?B?Tzd3MFBUc3MxdE1JbTNTWTRERnN1ZVdJZnpzUXUzWE53a2hSQXVuUmNzcUN0?=
 =?utf-8?B?TFFHVkhwYVZNaUVjNXhGQWhFNFQwSEtFc2xYcGJQaUNpcDJGbTRPemtkVXU5?=
 =?utf-8?B?N0dVM2ZEMWJWNE54eG5DTGUvSE1rMGh5OG9VeVRsS3Znb1lobG9qRkJzN3Zp?=
 =?utf-8?B?aSsrejBKNVJaMUJpcGE4QWw4SDZlazMrWE9MNUJtVkl4MWtqazNTWU81b2Qx?=
 =?utf-8?B?VUhoMjVXTDcxUzZSTkRlQWsvYndzdlJHWkpkdHlaQjNuQTM1VFZwaElIUGMy?=
 =?utf-8?B?ZTdJd21qZTdOMFJtUzZOZUUrTzAxLzFXYkYxUFBHc1BKV3hKZnFQaVFTazND?=
 =?utf-8?B?cWM0RnJaN0pjMHFMMEViVFNrK1AraStPS0xrMGgrcmU0blp4NUV3WHJ4Vmty?=
 =?utf-8?B?ZmpRdG9ycElwUE1DUE5uNktXS3g2bVNIRXlpdW51YWFYQzJMSnVnTEtCMUZ2?=
 =?utf-8?B?Q1BqYVhaelhhRnR1Z1lqUnltNk9XanJxREtQRDhMQ2RyTDFUT3lYQXViQXMy?=
 =?utf-8?B?MlNuR3cxL3FFVGtDRy9aZ3RpWlBYSnRlL3ZSbXJzaW92Q2VHYldpWWlUSEJv?=
 =?utf-8?B?WDFWNmt3RGJLZndJcUdsZUlRWW9BdEZlZmd2VTQxYi9XejF4NjdOTVFqYXQw?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEA0B4619E21E648A4DFAD14BF2BDE59@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR07MB8833.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0eea06-8664-4f03-ab93-08db7e1ee4c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 12:45:35.5125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L+TfXo1F1UgXWkrwX24yP8tlutBjQbVqtyD4haR6mLjTsfajgBxi8aE2dQj39zHl3QnhF3yepehknq5MYBdBVp/odrA684zv/ZAvagct08g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9332
Received-SPF: pass client-ip=40.107.14.79;
 envelope-from=john.hogberg@ericsson.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PiBUaGF0IGlzIGVub3VnaCB0byBnZXQgaXQgdG8gYnVpbGQsIGJ1dCB0aGVuIGluIHRoZSBDSSB0
aGUgdGVzdA0KPiBjb25zaXN0ZW50bHkgZmFpbHM6DQo+DQo+IGh0dHBzOi8vZ2l0bGFiLmNvbS9w
bTIxNS9xZW11Ly0vam9icy80NjA2NDQ3ODc1DQo+DQo+IFRFU1QgaWNpdmF1IG9uIGFhcmNoNjQN
Cj4gbWFrZVsxXTogKioqIFtNYWtlZmlsZToxNzg6IHJ1bi1pY2l2YXVdIEVycm9yIDENCj4NCj4g
SSdtIGdvaW5nIHRvIGRyb3AgdGhpcyBwYXRjaCBmcm9tIHRoZSBwdWxscmVxIHVudGlsIHdlDQo+
IGNhbiBmaWd1cmUgb3V0IHdoYXQncyBnb2luZyBvbi4uLg0KDQpPb3BzLCAtcHRocmVhZCB3YXNu
J3QgcmVxdWlyZWQgb24gbXkgbWFjaGluZS4NCg0KSSdtIHVuYWJsZSB0byByZXByb2R1Y2UgdGhl
IGZhaWx1cmUgbG9jYWxseS4gSXMgaXQgcG9zc2libGUgdG8gc3RyYWNlIGl0DQphbmQgc2VlIHdo
ZXRoZXIgaXQgd2FzIGNhdXNlZCBieSBmYWlsaW5nIHRvIHNldCB1cCBkdWFsLW1hcHBlZCBjb2Rl
Pw0KDQovSm9obg0K

