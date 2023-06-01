Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C54719E3B
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:30:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4iMV-0002gn-NY; Thu, 01 Jun 2023 09:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5095203fe=Niklas.Cassel@wdc.com>)
 id 1q4iMT-0002gV-AN; Thu, 01 Jun 2023 09:29:05 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5095203fe=Niklas.Cassel@wdc.com>)
 id 1q4iMM-0004nE-0p; Thu, 01 Jun 2023 09:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1685626137; x=1717162137;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=utJUePeIQApJafwuYHmEKk1nHxw7hEOFDFlA9WOwWOg=;
 b=UsJOpTP2M9N5fXJYMtNbEDAFbaUUTqQNM0hfehEtC/agr+857haopzS9
 uHm8IAH79gq8mvKT2HaI5S/Z7N44ltdfQBhxFVNdZlkE/U/ITW9XQy/5Z
 I1iwjkJi0yyQaGl9WLtjklB/80OnX/XGDMnNYLo+7tHpwkIKbgJVPDN0f
 txwHZr+smw8PQfsC+D2pMZlhOcEnDgtcs40eiwmjVwPQ/kgaV1NbUU/mC
 A2aktrdZX+ozPp96DC+zJUkIZQuCYyh3J1GiP9iO1JBJ4UmcNKshjztjt
 BnHun2M6R1zx1Xb99ulPBFSTCTy+Rs9fM+cw0JsPMopgeQXlmXMdhjH+X A==;
X-IronPort-AV: E=Sophos;i="6.00,210,1681142400"; d="scan'208";a="230307858"
Received: from mail-bn8nam04lp2049.outbound.protection.outlook.com (HELO
 NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.49])
 by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2023 21:28:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiqlfBzJAWDRAxQS0l/7rSLqdCLa7GNJngdC/0v5dsq2lK4bVR4w/khrbdS26ygmBuLx9BqoqgP56voIHz4OVb19XkgDB7vCCkR8jB94P1X/1COnbHZBa97fAaQ1q+Red5JtWHmth86V0KZYUSLvUjsq00NIzVpYlQwgcoDq45DULZOdTjrqBRKHROEtt1gnBi7TD04qcphhtWuOnanr6COWaAXN8lxSg7MVhGoBk/eZVsTiSzHTtZYWMZKG5CADvuHunVeo/E9fCjRcMufWk+ThCjhP+R8HVDL+gNxg8B1xL0kVypQZZrNctjNfdjLdr1feKxGctRJIvh9360mYQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utJUePeIQApJafwuYHmEKk1nHxw7hEOFDFlA9WOwWOg=;
 b=kxd/r6hX2MPTJtzTgOQZ/VlSQ74C490F4uOQwpkHgUPt0kIN7RLKqetT0b5bnO7fGlGlLuDvrFt7UP8t91nCelFGrUfk/lXbDfAh07IRM5jxVtYwwNCv2vQFvDFnzEIij0MpbmDwFDcksiQHQzTXp7N7cdXXToCo0JgYsML8Op27PocDy8jBtddH3u3cmVNMjWruC94YdxVUUMf6TyygetmPUkvD0MQzbNoYG207Lpri/Lnx6ODu1JVB6jHKZTp45StMzHDPh4n7/+v/TUrjVMSJVGmmPUtTkX01ppC821OnppmAXoJX7qEydn4NjMEwq/ntlAPcK/DcsVp3X/Keyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utJUePeIQApJafwuYHmEKk1nHxw7hEOFDFlA9WOwWOg=;
 b=JQ8MqBvvwXghMX9f8eYeIOtMEOUV50ZHcBa0wQ/I2vGFPB2tGE+RoA2e83/CNcPVlldsfPjtnicrt4nora9rmzTVKWQZu3lh7Om2+whhV6QepOoDBcLEY4HImnNLePcgvj4liisN3rVrJdIkGJi/nM11R24QWWdpc2bA8yNfhAg=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SJ0PR04MB7309.namprd04.prod.outlook.com (2603:10b6:a03:291::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 13:28:39 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9%4]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 13:28:38 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: John Snow <jsnow@redhat.com>
CC: Niklas Cassel <nks@flawful.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 2/9] hw/ide/core: set ERR_STAT in unsupported command
 completion
Thread-Topic: [PATCH 2/9] hw/ide/core: set ERR_STAT in unsupported command
 completion
Thread-Index: AQHZedR+UWIYYBc5m0af5JzDV3lvYa9fFQuAgBcROQA=
Date: Thu, 1 Jun 2023 13:28:38 +0000
Message-ID: <ZHidAgMaVTZq23lB@x1-carbon>
References: <20230428132124.670840-1-nks@flawful.org>
 <20230428132124.670840-3-nks@flawful.org>
 <CAFn=p-adzHqAMvdYjiMvXpv1-Z3SE78LUErOD5v0yW+6ZZbumw@mail.gmail.com>
In-Reply-To: <CAFn=p-adzHqAMvdYjiMvXpv1-Z3SE78LUErOD5v0yW+6ZZbumw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SJ0PR04MB7309:EE_
x-ms-office365-filtering-correlation-id: f05770f6-9218-4875-c613-08db62a41bf7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jBJW4WquRmHM5m7GvECUf6y0vHZwRqgeKN3YD9tqhltHskC280lsLKgSsbfu+fdZn2zPz2seb7Q9vZwn2CwWoKL6V/ly/FiAmm9JOeDcDd86w0GLqUXc2R0fpGwhuVOSgqMI1o4mzlnrjJa7kfWWpHXGDbJW6SYmEfv48K+TVPllyZ9IGYfGT9QI7dJZx8vAZznz753w3dla7u2FHlgWWH+poHnU01KwZvYnmXA+ci8C11X4wOub5LJ4ppANHROHBGqSI5QgwlBxOW6zg5uCBNYmAVsgSgM04RaPozuA/2HRAyMCz1IEJLAUMdtpDW2Hg/4pAgQVRKpVfwoxkNzfQ/iXMvZIpkhTxqNxhXWtAzRszUEF9cCpnUXy4QJDae2FRyLTYCAIbNQtuKWTwTyckXEOtSXcA25ihb6+8qvC2aUegjhV+pYDjcznFGIVDOICHsMxAWDOajvGV7byt9oFxU/anJethtp3kpH1TBxLmEXIplkNEcULi+w0WJS5wBtH8L8KoCHLGX7HxFuBdQCbT++cLNYUGcloLn3EuRxrrxodn7+2qxv3MCdyZQVUIpo4gmHHkN735mMOlXiZvtJHLfRxHDDJH3448opUX5MYpqStHqFijajitQbIuc9toYt6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6272.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(7916004)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199021)(4326008)(91956017)(66556008)(66476007)(76116006)(66946007)(66446008)(64756008)(6916009)(8676002)(316002)(41300700001)(54906003)(8936002)(5660300002)(2906002)(71200400001)(6486002)(478600001)(186003)(26005)(6512007)(53546011)(83380400001)(9686003)(6506007)(33716001)(38070700005)(82960400001)(122000001)(86362001)(38100700002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rm9tQkMwQS9ucDBkSlVhck1vWStBUnhUSUhiTW9vSmJVUDhwRTRGY21aRU5X?=
 =?utf-8?B?VjRKRlZCM1JYYk9nMkpuVGhndG9XblBQWmhKb2pYZ2pTRXBpVEtYNlkwZ2sy?=
 =?utf-8?B?bHovcUxYUGpzamVTM0xtaG55SE9PNFhJbG9Td21aRFhHMVZuQWt6enBEbStV?=
 =?utf-8?B?S0cwMGhXU2pEZmQ5WTlvMmxZbjRxeitaazJFS2RJR2JhYVlpY0hYZjh5aTY3?=
 =?utf-8?B?RjNnRm9wemNUMDNjOHhLV0k3V1ZNRHFtbWZ1aGVyd2hRd2dzREx4UW93Tmcz?=
 =?utf-8?B?bnMySGRSVzlKVzJ4YnkyRENldlBQcXJIUk40bVR3dDQzN3VHbGR0WjZxeW5m?=
 =?utf-8?B?VWJ4VjdtWEpVVWNoTUlkWDN3ejN5dWl6YnltTzY0emtlb1gwZ1hJUDI4T0E0?=
 =?utf-8?B?ellRSkE4R3gzSjYwRUpPNXMzd0JkdUJRek11RzV3SXJkazFqb0JsZVAwSkVJ?=
 =?utf-8?B?dFd2WTVoUjBuOUxQNGRSZkVSbWVWREJyeEV1c0ZvTGJROGcyMXdEcUFXQmZx?=
 =?utf-8?B?S0xkZ0plakNGNlFTekM4NjA2cFZzREo3czBkRmx2OUdxTTJ3RzJieG9tS2Zo?=
 =?utf-8?B?c1V2aFZYVXczbnBlaVdCa3BtMmdPcG5rYlRSc1FuUUdubkw3cmgxVkxFL1F3?=
 =?utf-8?B?TXg5MnZaandvZXNLWFFyTWgyUC9RbVRzcTA2ZkV0NmVFSmZmZUl1WDVOVmRi?=
 =?utf-8?B?TGIvdzRzcTlPRXdycTI5NHd5VUU4UHh0d0dZN2t6eEJDOVRjdTV2UW0vWXFj?=
 =?utf-8?B?S0M3aDlIOXlnMVJlc0JDOWY2SnBuY3Q1eTRpelQram5XRzZWSXdqZlQxbXp1?=
 =?utf-8?B?WmQzY3AwSmZRZkJVbDV2VkFFWnBmcWNKazdvL3hxb1E3ejdnSFNpdjF0NUVw?=
 =?utf-8?B?YkgwQTFyTDEwZC9UNHVkQmJHckhNTzZQemEwc0NPM0RqZWsrQ1ZKY01xdCtl?=
 =?utf-8?B?WGwyR21pTFc1eEFkK1VTS29wVmd4aFgwVmZ1eE5obE1nV3lDN2dSdVpIWk9X?=
 =?utf-8?B?bEVXRmRGYm41YnNYZmlaSjZqT0xjSStSZ3Z0VEhNZjc0dm5WMXN1ZVNJK3JO?=
 =?utf-8?B?clpSRlBpaitwOEwwdjJWSGt5SklrYlJhdEtMVm5ISGZLdzR0ZDRhL1ZFeUlw?=
 =?utf-8?B?aGtVaDB3UE1zK3FLdC80ckt4UnJBSWJGQTlnaGhiZGJTV1dBRmRkUUxWNWdm?=
 =?utf-8?B?R0k2aEFOUURmWVA4QmMxdzNqZXY5eEcrMm9Bbm9YbFhDUm9kdjRYRDJoT2Rp?=
 =?utf-8?B?cWJwMy9Ua2hwOVZFb3VFOE1BbGNHNVBNc2V6NzdubWY1a3NManBhQkU2VU0v?=
 =?utf-8?B?RXFtejQ0SlRUWEpBaitEYlU0bWFzajl5WWhrd2hobjVLcHBkZlZlU0xIZ3NO?=
 =?utf-8?B?cm9EUUduWjlwbEhhelI0S2dKc3FqanRxd1ZjcGgxYzR5TGV3UjNUZDU3c1lQ?=
 =?utf-8?B?OWhZRER1YWpWTGlBZ0ZVR1J3TDd0TnVzcFRhMnNEMjc0MWswYTFxL28wL2oz?=
 =?utf-8?B?OGQ4MGF3ZVo0ZFFocXFNbllJNUJkZkZsalRQR1dqN1pnblZ4Z3EvSlhvNVVs?=
 =?utf-8?B?Mi9GZ0xyVGFaQk41azFmcCtHcHFteW90dTY3Rk1Cek1aWnJSNkV0SC9ja3pF?=
 =?utf-8?B?dW1WRzRGTnBBWDBidUxSdUY2Qk1IRzNRd0gxck10czhPc2NpclNBTXkxeUJT?=
 =?utf-8?B?dDZTbWhoOFpJcFlkOExvdktlTnR6M0JFM0wvLy9rZzdzb0dSQVJhQ1o2a0Q4?=
 =?utf-8?B?TlQrd2l0YVlFLzEyVVpldm93TjErL0pYYWllcTh4WFcza0RkTkpyYXd3RXFm?=
 =?utf-8?B?eUlJcDhjcllLSTRIMDRKSkFhcW1OYlIrM0RmNEhkMEsxdEhxQThXQ1VaZmp4?=
 =?utf-8?B?bXpRKzBMNmU2K1REeHo3RUlYaHBkem9nd29mNDBnZ2VnMXlmbzQ4WjcvLzM4?=
 =?utf-8?B?elpiNzVBcjlKdE1TYmIvQUZMdkI5RmNVN2VBc0VycTFud2FvVFVncjJtTVV5?=
 =?utf-8?B?cHBYdzVZMjlSN213VUpXeVFFTmVYLzcrWWliSWFvRU91VnZkK2kvVFJqSHVi?=
 =?utf-8?B?N09od2FNeUxBTXppbUlsWEE5cElEY3dRZ3lRenpINml4WXVNbDR1aVZrNkVl?=
 =?utf-8?B?WjQ5a0JFMTJ2d2JQQTBBbHNlK1l5NnllcEZ1S1VUSzgzRVpqT2lOQitTL0ti?=
 =?utf-8?B?cGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3675DAFC2845A428B68A8F1DEC636DF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kCtRp48JHkD+HRya2JFIeRoih7b1zGQcdtSvvkVgJsk4GmQEcPNUUOz3xFsJA8a9yp1bh+w5+ARJLWlYJlpRCB7hLSMeCC8TeGzC4l1yDVdZcku1dv/POyGyuMEz/WrJ7dnbxBAPiPEdNbw4ETTM744YEP1VWXjkk6W85JZbPcFx+Z5499JPddSZ+/gbTKG55CSrZo9mgU3t65DZezR/rmZUu/34YrCX9PmmhueOvYM13O9H3KQmm0X7qKzcOWLmuCFP9WB1ztJGt9R87a9SWhQ61Hfa8fiAsk43FOTzw6UMD0HfeH4FzBzWpfye7ahGxjyj+vLAAHqP9hq+fZsA4LG4MIMOh8PQzkfFrXpTji5Z04HRGqieeNYeTA7Da4zUXvydsztv5nAZqN4mq6UJWBJt5Sf4miUPGV58/0rVt5akAz59ODGeJcAaTOHeqKIcuB40O2vFWDiAT8UzN21pmsaUUS18kXlxxSZo8dXm4idOb67B/EXRhOJqjx843IbgcQc96FC4y0JumaLPgykVdtN2MBE0lZa92Ce883+F1m2fENUcY4wBHa6b+u+J6T5iy0Dx/apAXoY59bxumjCAT6/NJX0gfWkkfrPKhVG3BBTCMLwXfSodNAoGcK9gTmMDDJN7maXMutQQXrA8nxX63WGrtWwcBss3FoHCPUi4opny9YoACdARRBNuksxZJU+/QEXuj6LynBpzynEJymlqUnSUQZu93ZqKD7RuyMw9vMVuJVubrtH6zbd1nNrsV0vuVp+AXsaeE69JVU4R/T9wdf1yqUTNgBy64rp1B4+Q1lAertJD/VPHoIllGSZlCDiZRH8wqQahbhvqMx+syWa2LdRau+RmpL89z6DbCo2+rFU=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05770f6-9218-4875-c613-08db62a41bf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 13:28:38.6409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: faRqUGc81e9raG4YPILSOcsvBiA3OAhwDj5OnLPMMBCejtEllxL/5Ly8ypKhOE3MDhGj8MerLkxHTqm547mTFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7309
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=5095203fe=Niklas.Cassel@wdc.com; helo=esa4.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

T24gV2VkLCBNYXkgMTcsIDIwMjMgYXQgMDU6MTI6NTdQTSAtMDQwMCwgSm9obiBTbm93IHdyb3Rl
Og0KPiBPbiBGcmksIEFwciAyOCwgMjAyMyBhdCA5OjIy4oCvQU0gTmlrbGFzIENhc3NlbCA8bmtz
QGZsYXdmdWwub3JnPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IE5pa2xhcyBDYXNzZWwgPG5pa2xh
cy5jYXNzZWxAd2RjLmNvbT4NCj4gPg0KPiA+IEN1cnJlbnRseSwgdGhlIGZpcnN0IHRpbWUgc2Vu
ZGluZyBhbiB1bnN1cHBvcnRlZCBjb21tYW5kDQo+ID4gKGUuZy4gUkVBRCBMT0cgRE1BIEVYVCkg
d2lsbCBub3QgaGF2ZSBFUlJfU1RBVCBzZXQgaW4gdGhlIGNvbXBsZXRpb24uDQo+ID4gU2VuZGlu
ZyB0aGUgdW5zdXBwb3J0ZWQgY29tbWFuZCBhZ2Fpbiwgd2lsbCBjb3JyZWN0bHkgaGF2ZSBFUlJf
U1RBVCBzZXQuDQo+ID4NCj4gPiBXaGVuIGlkZV9jbWRfcGVybWl0dGVkKCkgcmV0dXJucyBmYWxz
ZSwgaXQgY2FsbHMgaWRlX2Fib3J0X2NvbW1hbmQoKS4NCj4gPiBpZGVfYWJvcnRfY29tbWFuZCgp
IGZpcnN0IGNhbGxzIGlkZV90cmFuc2Zlcl9zdG9wKCksIHdoaWNoIHdpbGwgY2FsbA0KPiA+IGlk
ZV90cmFuc2Zlcl9oYWx0KCkgYW5kIGlkZV9jbWRfZG9uZSgpLCBhZnRlciB0aGF0IGlkZV9hYm9y
dF9jb21tYW5kKCkNCj4gPiBzZXRzIEVSUl9TVEFUIGluIHN0YXR1cy4NCj4gPg0KPiA+IGlkZV9j
bWRfZG9uZSgpIGZvciBBSENJIHdpbGwgY2FsbCBhaGNpX3dyaXRlX2Zpc19kMmgoKSB3aGljaCB3
cml0ZXMgdGhlDQo+ID4gY3VycmVudCBzdGF0dXMgaW4gdGhlIEZJUywgYW5kIHJhaXNlcyBhbiBJ
UlEuIChUaGUgc3RhdHVzIGhlcmUgd2lsbCBub3QNCj4gPiBoYXZlIEVSUl9TVEFUIHNldCEpLg0K
PiA+DQo+ID4gVGh1cywgd2UgY2Fubm90IGNhbGwgaWRlX3RyYW5zZmVyX3N0b3AoKSBiZWZvcmUg
c2V0dGluZyBFUlJfU1RBVCwgYXMNCj4gPiBpZGVfdHJhbnNmZXJfc3RvcCgpIHdpbGwgcmVzdWx0
IGluIHRoZSBGSVMgYmVpbmcgd3JpdHRlbiBhbmQgYW4gSVJRDQo+ID4gYmVpbmcgcmFpc2VkLg0K
PiA+DQo+ID4gVGhlIHJlYXNvbiB3aHkgaXQgd29ya3MgdGhlIHNlY29uZCB0aW1lLCBpcyB0aGF0
IEVSUl9TVEFUIHdpbGwgc3RpbGwNCj4gPiBiZSBzZXQgZnJvbSB0aGUgcHJldmlvdXMgY29tbWFu
ZCwgc28gd2hlbiB3cml0aW5nIHRoZSBGSVMsIHRoZQ0KPiA+IGNvbXBsZXRpb24gd2lsbCBjb3Jy
ZWN0bHkgaGF2ZSBFUlJfU1RBVCBzZXQuDQo+ID4NCj4gPiBTZXQgRVJSX1NUQVQgYmVmb3JlIHdy
aXRpbmcgdGhlIEZJUyAoY2FsbGluZyBjbWRfZG9uZSksIHNvIHRoYXQgd2Ugd2lsbA0KPiA+IHJh
aXNlIGFuIGVycm9yIElSUSBjb3JyZWN0bHkgd2hlbiByZWNlaXZpbmcgYW4gdW5zdXBwb3J0ZWQg
Y29tbWFuZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5pa2xhcyBDYXNzZWwgPG5pa2xhcy5j
YXNzZWxAd2RjLmNvbT4NCj4gPiAtLS0NCj4gPiAgaHcvaWRlL2NvcmUuYyB8IDIgKy0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvaHcvaWRlL2NvcmUuYyBiL2h3L2lkZS9jb3JlLmMNCj4gPiBpbmRleCA0NWQx
NGEyNWU5Li5jMTQ0ZDExNTVkIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2lkZS9jb3JlLmMNCj4gPiAr
KysgYi9ody9pZGUvY29yZS5jDQo+ID4gQEAgLTUzMSw5ICs1MzEsOSBAQCBCbG9ja0FJT0NCICpp
ZGVfaXNzdWVfdHJpbSgNCj4gPg0KPiA+ICB2b2lkIGlkZV9hYm9ydF9jb21tYW5kKElERVN0YXRl
ICpzKQ0KPiA+ICB7DQo+ID4gLSAgICBpZGVfdHJhbnNmZXJfc3RvcChzKTsNCj4gPiAgICAgIHMt
PnN0YXR1cyA9IFJFQURZX1NUQVQgfCBFUlJfU1RBVDsNCj4gPiAgICAgIHMtPmVycm9yID0gQUJS
VF9FUlI7DQo+ID4gKyAgICBpZGVfdHJhbnNmZXJfc3RvcChzKTsNCj4gPiAgfQ0KPiA+DQo+ID4g
IHN0YXRpYyB2b2lkIGlkZV9zZXRfcmV0cnkoSURFU3RhdGUgKnMpDQo+ID4gLS0NCj4gPiAyLjQw
LjANCj4gPg0KPiANCj4gU2VlbXMgT0sgYXQgYSBnbGFuY2UuIERvZXMgdGhpcyBjaGFuZ2UgdGhl
IGJlaGF2aW9yIG9mDQo+IGlkZV90cmFuc2Zlcl9zdG9wIGF0IGFsbD8gSSBndWVzcyB3ZSd2ZSBi
ZWVuIHVzaW5nIHRoaXMgb3JkZXIgb2YNCj4gb3BlcmF0aW9ucyBzaW5jZSAyMDA4IGF0IGxlYXN0
LiBJIGRpZG4ndCBrbm93IEMgdGhlbi4NCg0KSGVsbG8gSm9obiwNCg0KTm90IGFzIGZhciBhcyBJ
IGNhbiBzZWUuDQoNCg0KS2luZCByZWdhcmRzLA0KTmlrbGFz

