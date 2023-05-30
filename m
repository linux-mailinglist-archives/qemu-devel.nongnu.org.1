Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F4C7158AC
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 10:36:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3upw-0008K9-F4; Tue, 30 May 2023 04:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sriram.yagnaraman@est.tech>)
 id 1q3upu-0008Jt-1H
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:36:10 -0400
Received: from mail-db8eur05on2126.outbound.protection.outlook.com
 ([40.107.20.126] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sriram.yagnaraman@est.tech>)
 id 1q3upq-0004Yw-7x
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:36:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmSb/de/atYvCrIqCme5uA7WHmVxKE9Ondvxhs2MRcG4j/DllnHK/MHI1wdue60obRHEz1Vfu/gLgff6F3MaUqvHTQoDdDGaQCDLUErcKosi9JaxFc5/+unv6Ku+LeH2RF062ezUrF/Oy3ksH3tNTEsM1g6BCYI/uNHT4ck2UYKZxbkY121SE+IwB7De2BWeDJME17C9+utKLuzdLZGvhAvFSfrUdPOJvqWVareZ5bJfLxF44brllxGpM9RHML/VgRUlKZx+m98xl9tVGKEWTEWtqqWwhVH+s/fLQSnK55XWXZzJw+frXTAIt08coj2H52H8oMdXUy1Ws1FQHll9FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQMytqJGwAWo+hT9sQ7gG4wuE6YUd6REnJn4kO/E/HI=;
 b=L7TtEixTEBlGwnBKnH+BcnE29TMUxFEYO6vaFf+n3Uw4Bf06PxyCNtHzNA4ysYkmiz0dgos23gkXq6Zyt2L/KoYmaVPEK1+z89QQNQDCVWi3eB1JmSbDif/7Ur2S5tVbTiL4uwu/PElEr0L09G+4o1MyU+ZjiegjAMcCMmwqkdmTAT4OoEqkcEN2hGit8U2z2p53OrHKvUjrDTLicQRiLJG6BN3f0cOm7z2o5FQy3SDNUAPlsHXGv2m/28bUvM6fGFSqIWnjUqvn1GXjzPh7PltUvdNEtI7aTrZHz4jpEdqbWT1EVwOFWhk3D8qf3GKXPDk0msbqfl3DmNOM7dzsTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com; 
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQMytqJGwAWo+hT9sQ7gG4wuE6YUd6REnJn4kO/E/HI=;
 b=gGFz+0FP3V5T1sCTI4reNSeIPmizDdUnxaULvwLAdgWKhgs13hvCX4WiDOgKam6okFWZHhHMVYeH9UJU+JrIGD2HJm7fkbn24uGaNk92V5cGlIh4YSd9TfBHVuhJtHpkv4rho4yPjjEg/YNbIEtEBU9MgVm7uhgbwkmHzkUdAKY=
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by AS4P189MB2111.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:517::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 08:30:58 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6%4]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 08:30:58 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH] igb: Add Function Level Reset to PF and VF
Thread-Topic: [PATCH] igb: Add Function Level Reset to PF and VF
Thread-Index: AQHZj/fQujQCROZFWkiFuksETv6UNa9vggJggAENLQCAAEfGgIAADDAAgAB7iYCAALbjAIAAa1EA
Date: Tue, 30 May 2023 08:30:58 +0000
Message-ID: <DBBP189MB1433898733717D58F8A58C75954B9@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
References: <20230526173035.69055-1-clg@redhat.com>
 <DBBP189MB143330236AFF956285CD74F295459@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
 <e2bed67c-23ea-6364-bd5a-f7b330346302@daynix.com>
 <8fb19b45-0dc3-a3d6-fcf9-5fc8728edf4d@redhat.com>
 <5ab583be-8e7a-5636-d14c-f04ecd670894@daynix.com>
 <d5c359c5-79fa-dffc-101b-08c0f08f7071@redhat.com>
 <5a69feb7-0dcb-6620-536a-e6778f79ccde@daynix.com>
In-Reply-To: <5a69feb7-0dcb-6620-536a-e6778f79ccde@daynix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBP189MB1433:EE_|AS4P189MB2111:EE_
x-ms-office365-filtering-correlation-id: 8a61e07e-f447-4228-43b8-08db60e831ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XcCZ0g72mIYIrtFDlXKBfRYqpoMskbh2z7qcQtRfL9L7UmruzWmpyDtx5u3PN4InflBh7lfhAqBS0E8uEozb08FzBNMNLIW985L4vxjup2mtL8XjyRwIck5FZYAQ6StFIF7vscmTJqDtvUYMH906IYN4ylpLXl8+dkfNGAepMC51RrxjSj97QSopEVo3kF6cRC14X3ydfsirlYFR/3zzgjz9ZjcDTjojWG3hG16oDLVO6kfkwoK2tGAHxWbsQSfm83D8zUH2zjTX4CEDFadlSm7xDw9MNCKbB7rqtkcVptSdGtlQC/ScF1KoKrvEHNviPWt8ylSTZ5igsh49VZ4Ky7k0RyB18F4/0m7IffhcdAqMGpSap1CFEgVgIUATnuQmpeKxoir7Hk0MtsWXWudpdReOcmnyyDksX49SZY1jzcqis7EvPVm9V6medmloNP4jZuJZahavXrGqzKty6UdQ3o9eZDeetRhkFB5sBfpP+YYE+TDNvu5SPmVNFCtMSdS5U+nZxlanKIKLM+Gqqex1upsrB86zs6RuTaI3heaJWtsx6jZnbxeT6jyalZemKWCcTNo1rIOEAJkDYctJoB/MuI2AT/yxQqNyHiQrXy5WSXs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(136003)(366004)(396003)(39840400004)(376002)(451199021)(966005)(186003)(38100700002)(41300700001)(83380400001)(6506007)(53546011)(9686003)(26005)(66574015)(7696005)(478600001)(110136005)(71200400001)(4326008)(66556008)(66476007)(66946007)(66446008)(76116006)(64756008)(122000001)(55016003)(316002)(5660300002)(52536014)(8676002)(8936002)(44832011)(2906002)(33656002)(86362001)(38070700005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzdaWWkwMWorZDNvcjRvcEcvNC83dnpOMXRDTFhud2xMZlhzejZYRHBiVm1F?=
 =?utf-8?B?c2JvVkdMdkhnQVIvdjZMK0FQYko5RW5maWJYTXlSOTZoRjdoNzl5WHlyUnRV?=
 =?utf-8?B?VmNsQm1vdTY0UURlc0d3WHRzVUlpeFpXWkt2Tk9lRVZnUndhSnR5NHhjQkhS?=
 =?utf-8?B?czNtdmhDWXFFTXRLWVJuQTJoWEV2aEEwZ240UVZpeEwzenRuWUY1V0x0cVFj?=
 =?utf-8?B?R0lBVGlhVmI0S0RaYnkvcHpBdGpDZ1lkM252cWFxbmk1a0FJaFJhUjhnTDZ6?=
 =?utf-8?B?aENML2lvZXFkSEdGZ1BxK3p2OFhZTGZROWZxK1kvajZyem4vUU5aK1lmU3FV?=
 =?utf-8?B?Q0l1alVwNVZXWXJvNmlmMnNrWHlZdWZKNkdPc0hxeTJxa3JNc3JvY2ZaVmZF?=
 =?utf-8?B?WWlxNjdSN2NJRzFVQWJZNVVBT1ViVnk1TURPcllSTkhmbnFqY2VEMFNKcW5U?=
 =?utf-8?B?Qmx2SGtyMWJoUEwzZ05zQWl5QzNXNjdIaUlaY1gyUmgxK21QUitxb005c3Qx?=
 =?utf-8?B?MFBPRzBiWkwyU1hqTmhIZXhma3FOWS9HSjlQRGlneE56dDJRLzBmbWtWTlls?=
 =?utf-8?B?d1pqQ0ovZVFPV3crVSs3NFJXbURBOCtIZ1dyOGYyL0dSbmtuaERyd2lodDB6?=
 =?utf-8?B?bDNHakZja3Nrc3o1WGdyZXZaUXg1d1RxOUg1U3dGSmNQQXZJd0ppN29STnVh?=
 =?utf-8?B?SlYvMTNYMWE4TmJIM3l0OTFEZXFTUzU0Z25Hc1cxVXFDUDc2NEZsUDJDUFhQ?=
 =?utf-8?B?QzBrT29SSVVsWTVYbmpZQTAyM2NOdG80bzViVGk0R2tnSVZMQUwrNW1GQTJU?=
 =?utf-8?B?eHBmaW1UelFIam4xd2FrcDRWZmFXZ0h5ZW9Demh2WnpiV0JiYUZHaDVYS0hq?=
 =?utf-8?B?V0Q1cXVIczZ0MldNMmV5MUludXJnOVNkUlpDUXdCc08yV2ZtS3JpQjdGNXFS?=
 =?utf-8?B?emVETFphY0oyWFVtbGlxUEpNR1FVSnlCbFc3Ny8rUGw2TUpGNWVtK2k4cGR6?=
 =?utf-8?B?UEsyeFd4MTV3K20zTDIwd29yT1E2RkIyczFQMnpGTUZjQ2FHaTgxUTByQnF5?=
 =?utf-8?B?dFpPakxiTEdDdVUxQ0hscGk1TWRqWEFqZzluV2l4YzRNOXFrRFRMZTBJQWNN?=
 =?utf-8?B?WS9LNU02SjFOVTFpSmFzQVVMRW9aamxFTVFDeERIUG9uQXRmQ3BXV3RteEZH?=
 =?utf-8?B?Y1BXT2l2RTA5SHJBazZmZlhSbVZhYVJZSmpQaVBuaE83c3R5K2c1TFhoZWhx?=
 =?utf-8?B?S2l4UVpHNUg3Q1FHdFdkdGoxc1dBMDZuRXRiWUlFOUt1T2puZGVpOGlCWVVv?=
 =?utf-8?B?NC92bWhVcDRHMnVuU2ZyZjVEZW03T2VpU2l2SEdqN3pJTWtHcTBLa2ZodWJZ?=
 =?utf-8?B?QXNVWkRBSWpkeXYxdmpqVGNZT3pWRzI2dVNJcU03ZXNvTi9CMmg1M0U5Q2Y1?=
 =?utf-8?B?YTdpcHdNWUpVc3Vhb3RneDJqZlVBQ2JFdE14VFpMNlBMVW4zb2o4UmFWTWxz?=
 =?utf-8?B?NGZhWW5tYUtJektXU28yMnZybzdYRHhVZ0p2eTdHSHdpa3psb1hZSnNaWE1U?=
 =?utf-8?B?aHNGTVV2a09ISFVDa2VkK1JKeVVqb0hrMU1oNUkyTXRlVHhXbE5SSjZyT2dv?=
 =?utf-8?B?NTViQzhhZEN3NDYxUVREZ2FrV29DU0liaEJIK2RZMktyekdnUllzRFk0YXhi?=
 =?utf-8?B?RktMTEI1NmZUdmowMUlRV25pQTc3VXdsbklyVW8xYVdEVlBvTG1odXhSNExL?=
 =?utf-8?B?V1YvaXROTkt1OUtld25HZE9jWkZxWm9BaHJVTWxNNjBjVlpBMHRXZUkrcFR5?=
 =?utf-8?B?QkFQbWlPQTRsTElqMkVVWnY4NENqVGpybEVnNUcvckkrWTlpOTNiN1UrclVt?=
 =?utf-8?B?VjlYV1VaUkE0UlJSbmFCNzBzcldVUjc1am5IOXBMZTA1VFlYMCtxWi9Rem1Q?=
 =?utf-8?B?U3NHd2pSSXQ4cWVnM29pbmdVZExLNnRXaXU3N09TcW9ZVVB4SkhtUGd2Y1Yy?=
 =?utf-8?B?bS9KcFIzTXdDZ0hMczN4WXdNY2prSG5udU9VSSs3SGMveWRJeFR6MGtMNzZP?=
 =?utf-8?B?Qy9XUXFpenB0UXQybnBQejVYYkZ0THlza0dRWjNMc1FkL0g0UDdtUjZaeklm?=
 =?utf-8?Q?Q8RjLkmKiLtUz46WRxfyw3VqX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a61e07e-f447-4228-43b8-08db60e831ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 08:30:58.6860 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgwWpBk4AaakPmFpxTnUhGrEeCayr2HqFjfAUFi9pRZdej/C2NFUf10DYDWkRcpezm337eipDigeoPvgpl0rJAGvmGR7B1f6TuynWhKrm2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB2111
Received-SPF: pass client-ip=40.107.20.126;
 envelope-from=sriram.yagnaraman@est.tech;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWtpaGlrbyBPZGFraSA8
YWtpaGlrby5vZGFraUBkYXluaXguY29tPg0KPiBTZW50OiBUdWVzZGF5LCAzMCBNYXkgMjAyMyAw
NDowMg0KPiBUbzogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPjsgU3JpcmFtIFlh
Z25hcmFtYW4NCj4gPHNyaXJhbS55YWduYXJhbWFuQGVzdC50ZWNoPjsgcWVtdS1kZXZlbEBub25n
bnUub3JnDQo+IENjOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIXSBpZ2I6IEFkZCBGdW5jdGlvbiBMZXZlbCBSZXNldCB0byBQRiBhbmQgVkYN
Cj4gDQo+IE9uIDIwMjMvMDUvMzAgMDowNywgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+ID4g
T24gNS8yOS8yMyAwOTo0NSwgQWtpaGlrbyBPZGFraSB3cm90ZToNCj4gPj4gT24gMjAyMy8wNS8y
OSAxNjowMSwgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+ID4+PiBPbiA1LzI5LzIzIDA0OjQ1
LCBBa2loaWtvIE9kYWtpIHdyb3RlOg0KPiA+Pj4+IE9uIDIwMjMvMDUvMjggMTk6NTAsIFNyaXJh
bSBZYWduYXJhbWFuIHdyb3RlOg0KPiA+Pj4+Pg0KPiA+Pj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPj4+Pj4+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNv
bT4NCj4gPj4+Pj4+IFNlbnQ6IEZyaWRheSwgMjYgTWF5IDIwMjMgMTk6MzENCj4gPj4+Pj4+IFRv
OiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gPj4+Pj4+IENjOiBBa2loaWtvIE9kYWtpIDxha2lo
aWtvLm9kYWtpQGRheW5peC5jb20+OyBTcmlyYW0gWWFnbmFyYW1hbg0KPiA+Pj4+Pj4gPHNyaXJh
bS55YWduYXJhbWFuQGVzdC50ZWNoPjsgSmFzb24gV2FuZw0KPiA8amFzb3dhbmdAcmVkaGF0LmNv
bT47DQo+ID4+Pj4+PiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+ID4+Pj4+
PiBTdWJqZWN0OiBbUEFUQ0hdIGlnYjogQWRkIEZ1bmN0aW9uIExldmVsIFJlc2V0IHRvIFBGIGFu
ZCBWRg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IFRoZSBJbnRlbCA4MjU3NkVCIEdiRSBDb250cm9sbGVy
IHNheSB0aGF0IHRoZSBQaHlzaWNhbCBhbmQNCj4gPj4+Pj4+IFZpcnR1YWwgRnVuY3Rpb25zIHN1
cHBvcnQgRnVuY3Rpb24gTGV2ZWwgUmVzZXQuIEFkZCB0aGUNCj4gPj4+Pj4+IGNhcGFiaWxpdHkg
dG8gZWFjaCBkZXZpY2UgbW9kZWwuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gQ2M6IEFraWhpa28gT2Rh
a2kgPGFraWhpa28ub2Rha2lAZGF5bml4LmNvbT4NCj4gPj4+Pj4+IEZpeGVzOiAzYTk3N2RlZWJl
NmIgKCJJbnRyZG9jdWUgaWdiIGRldmljZSBlbXVsYXRpb24iKQ0KPiA+Pj4+Pj4gU2lnbmVkLW9m
Zi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiA+Pj4+Pj4gLS0tDQo+
ID4+Pj4+PiDCoCBody9uZXQvaWdiLmPCoMKgIHwgMyArKysNCj4gPj4+Pj4+IMKgIGh3L25ldC9p
Z2J2Zi5jIHwgMyArKysNCj4gPj4+Pj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25z
KCspDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gZGlmZiAtLWdpdCBhL2h3L25ldC9pZ2IuYyBiL2h3L25l
dC9pZ2IuYyBpbmRleA0KPiA+Pj4+Pj4gMWM5ODlkNzY3NzI1Li4wOGUzODkzMzhkY2ENCj4gPj4+
Pj4+IDEwMDY0NA0KPiA+Pj4+Pj4gLS0tIGEvaHcvbmV0L2lnYi5jDQo+ID4+Pj4+PiArKysgYi9o
dy9uZXQvaWdiLmMNCj4gPj4+Pj4+IEBAIC0xMDEsNiArMTAxLDcgQEAgc3RhdGljIHZvaWQgaWdi
X3dyaXRlX2NvbmZpZyhQQ0lEZXZpY2UgKmRldiwNCj4gPj4+Pj4+IHVpbnQzMl90IGFkZHIsDQo+
ID4+Pj4+Pg0KPiA+Pj4+Pj4gwqDCoMKgwqDCoCB0cmFjZV9pZ2Jfd3JpdGVfY29uZmlnKGFkZHIs
IHZhbCwgbGVuKTsNCj4gPj4+Pj4+IMKgwqDCoMKgwqAgcGNpX2RlZmF1bHRfd3JpdGVfY29uZmln
KGRldiwgYWRkciwgdmFsLCBsZW4pOw0KPiA+Pj4+Pj4gK8KgwqDCoCBwY2llX2NhcF9mbHJfd3Jp
dGVfY29uZmlnKGRldiwgYWRkciwgdmFsLCBsZW4pOw0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IMKgwqDC
oMKgwqAgaWYgKHJhbmdlX2NvdmVyc19ieXRlKGFkZHIsIGxlbiwgUENJX0NPTU1BTkQpICYmDQo+
ID4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgKGRldi0+Y29uZmlnW1BDSV9DT01NQU5EXSAmIFBD
SV9DT01NQU5EX01BU1RFUikpIHsNCj4gQEANCj4gPj4+Pj4+IC00MjcsNg0KPiA+Pj4+Pj4gKzQy
OCw4IEBAIHN0YXRpYyB2b2lkIGlnYl9wY2lfcmVhbGl6ZShQQ0lEZXZpY2UgKnBjaV9kZXYsIEVy
cm9yDQo+ID4+Pj4+PiAqKmVycnApDQo+ID4+Pj4+PiDCoMKgwqDCoMKgIH0NCj4gPj4+Pj4+DQo+
ID4+Pj4+PiDCoMKgwqDCoMKgIC8qIFBDSWUgZXh0ZW5kZWQgY2FwYWJpbGl0aWVzIChpbiBvcmRl
cikgKi8NCj4gPj4+Pj4+ICvCoMKgwqAgcGNpZV9jYXBfZmxyX2luaXQocGNpX2Rldik7DQo+ID4+
Pj4+PiArDQo+ID4+Pj4+PiDCoMKgwqDCoMKgIGlmIChwY2llX2Flcl9pbml0KHBjaV9kZXYsIDEs
IDB4MTAwLCAweDQwLCBlcnJwKSA8IDApIHsNCj4gPj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBo
d19lcnJvcigiRmFpbGVkIHRvIGluaXRpYWxpemUgQUVSIGNhcGFiaWxpdHkiKTsNCj4gPj4+Pj4+
IMKgwqDCoMKgwqAgfQ0KPiA+Pj4+Pj4gZGlmZiAtLWdpdCBhL2h3L25ldC9pZ2J2Zi5jIGIvaHcv
bmV0L2lnYnZmLmMgaW5kZXgNCj4gPj4+Pj4+IDI4NGVhNjExODQ4Yi4uMGE1OGRhZDA2ODAyIDEw
MDY0NA0KPiA+Pj4+Pj4gLS0tIGEvaHcvbmV0L2lnYnZmLmMNCj4gPj4+Pj4+ICsrKyBiL2h3L25l
dC9pZ2J2Zi5jDQo+ID4+Pj4+PiBAQCAtMjA0LDYgKzIwNCw3IEBAIHN0YXRpYyB2b2lkIGlnYnZm
X3dyaXRlX2NvbmZpZyhQQ0lEZXZpY2UNCj4gPj4+Pj4+ICpkZXYsIHVpbnQzMl90IGFkZHIsIHVp
bnQzMl90IHZhbCzCoCB7DQo+ID4+Pj4+PiDCoMKgwqDCoMKgIHRyYWNlX2lnYnZmX3dyaXRlX2Nv
bmZpZyhhZGRyLCB2YWwsIGxlbik7DQo+ID4+Pj4+PiDCoMKgwqDCoMKgIHBjaV9kZWZhdWx0X3dy
aXRlX2NvbmZpZyhkZXYsIGFkZHIsIHZhbCwgbGVuKTsNCj4gPj4+Pj4+ICvCoMKgwqAgcGNpZV9j
YXBfZmxyX3dyaXRlX2NvbmZpZyhkZXYsIGFkZHIsIHZhbCwgbGVuKTsNCj4gPj4+Pj4+IMKgIH0N
Cj4gPj4+Pj4+DQo+ID4+Pj4+PiDCoCBzdGF0aWMgdWludDY0X3QgaWdidmZfbW1pb19yZWFkKHZv
aWQgKm9wYXF1ZSwgaHdhZGRyIGFkZHIsDQo+ID4+Pj4+PiB1bnNpZ25lZCBzaXplKSBAQCAtMjY2
LDYgKzI2Nyw4IEBAIHN0YXRpYyB2b2lkDQo+ID4+Pj4+PiBpZ2J2Zl9wY2lfcmVhbGl6ZShQQ0lE
ZXZpY2UgKmRldiwgRXJyb3INCj4gPj4+Pj4+ICoqZXJycCkNCj4gPj4+Pj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCBod19lcnJvcigiRmFpbGVkIHRvIGluaXRpYWxpemUgUENJZSBjYXBhYmlsaXR5Iik7
DQo+ID4+Pj4+PiDCoMKgwqDCoMKgIH0NCj4gPj4+Pj4+DQo+ID4+Pj4+PiArwqDCoMKgIHBjaWVf
Y2FwX2Zscl9pbml0KGRldik7DQo+ID4+Pj4+DQo+ID4+Pj4+IFNvcnJ5IGZvciBteSBuYWl2ZSBx
dWVzdGlvbiwgYW5kIHBlcmhhcHMgbm90IHJlbGF0ZWQgdG8geW91cg0KPiA+Pj4+PiBwYXRjaCwg
SUdCVkYgZGV2aWNlIGNsYXNzIGRvZXNuJ3Qgc2VlbSB0byBoYXZlIGFueSByZXNldCBmdW5jdGlv
bnMNCj4gPj4+Pj4gcmVnaXN0ZXJlZCB2aWEgaWdidmZfY2xhc3NfaW5pdCgpLiBTbywgSSBhbSBn
dWVzc2luZyBhbiBGTFIgd2lsbA0KPiA+Pj4+PiBub3QgdHJpZ2dlciBpZ2JfdmZfcmVzZXQoKSwg
d2hpY2ggaXMgcHJvYmFibHkgd2hhdCB3ZSB3YW50Lg0KPiA+Pj4NCj4gPj4+IEl0IGRvZXMgdGhy
b3VnaCB0aGUgVlRDVFJMIHJlZ2lzdGVycy4NCj4gPj4+DQo+ID4+Pj4gWW91J3JlIHJpZ2h0LiBB
ZHZlcnRpc2luZyBGTFIgY2FwYWJpbGl0eSB3aXRob3V0IGltcGxlbWVudGluZyBpdA0KPiA+Pj4+
IGNhbiBjb25mdXNlIHRoZSBndWVzdCB0aG91Z2ggc3VjaCBwcm9iYWJpbGl0eSBpcyBxdWl0ZSBh
IGxvdyBpbg0KPiA+Pj4+IHByYWN0aWNlLiBUaGUgcmVzZXQgc2hvdWxkIGJlIGltcGxlbWVudGVk
IGZpcnN0Lg0KPiA+Pj4NCj4gPj4+DQo+ID4+PiBJIHdhcyBsb29raW5nIGF0IGFuIGlzc3VlIGZy
b20gYSBWRklPIHBlcnNwZWN0aXZlIHdoaWNoIGRvZXMgYSBGTFINCj4gPj4+IG9uIGEgZGV2aWNl
IHdoZW4gcGFzcyB0aHJvdWdoLiBTb2Z0d2FyZSBhbmQgRkxSIGFyZSBlcXVpdmFsZW50IGZvciBh
DQo+ID4+PiBWRi4NCj4gPj4NCj4gPj4gVGhleSBzaG91bGQgYmUgZXF1aXZhbGVudCBhY2NvcmRp
bmcgdG8gdGhlIGRhdGFzaGVldCwgYnV0DQo+ID4+IHVuZm9ydHVuYXRlbHkgY3VycmVudCBpZ2J2
ZiBpbXBsZW1lbnRhdGlvbiBkb2VzIG5vdGhpbmcgd2hlbiByZXNldC4NCj4gPj4gV2hhdCBTcmly
YW0gcHJvcG9zZXMgaXMgdG8gYWRkIGNvZGUgdG8gYWN0dWFsbHkgd3JpdGUgVlRDVFJMIHdoZW4g
RkxSDQo+ID4+IG9jY3VycmVkIGFuZCBtYWtlIEZMUiBhbmQgc29mdHdhcmUgcmVzZXQgZXF1aXZh
bGVudC4gQW5kIEkgdGhpbmsgdGhhdA0KPiA+PiBzaG91bGQgYmUgZG9uZSBiZWZvcmUgdGhpcyBj
aGFuZ2U7IHlvdSBzaG91bGQgYWR2ZXJ0aXNlIEZMUg0KPiA+PiBjYXBhYmlsaXR5IGFmdGVyIHRo
ZSByZXNldCBpcyBhY3R1YWxseSBpbXBsZW1lbnRlZC4NCj4gPg0KPiA+DQo+ID4gQUZBSUNULCB0
aGUgVkZzIGFyZSByZXNldCBjb3JyZWN0bHkgYnkgdGhlIE9TIHdoZW4gY3JlYXRlZCBvciBwcm9i
ZWQNCj4gPiBhbmQgYnkgUUVNVSB3aGVuIHRoZXkgYXJlIHBhc3N0aHJvdWdoIGluIGEgbmVzdGVk
IGd1ZXN0IE9TICh3aXRoIHRoaXMNCj4gcGF0Y2gpLg0KPiA+IGlnYl92Zl9yZXNldCgpIGlzIGNs
ZWFybHkgY2FsbGVkIGluIFFFTVUsIHNlZSByb3V0aW5lDQo+ID4gZTEwMDBfcmVzZXRfaHdfdmYo
KSBpbiBMaW51eC4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgdGhpcyBwYXRjaCBtYWtlcyBkaWZmZXJl
bmNlIGZvciBlMTAwMF9yZXNldF9od192ZigpIGFzIGl0IGRvZXMgbm90DQo+IHJlbHkgb24gRkxS
Lg0KPiANCj4gPg0KPiA+IEkgZG9uJ3QgdGhpbmsgYSByZXNldCBvcCBpcyBuZWNlc3NhcnkgYmVj
YXVzZSBWRnMgYXJlIHNvZnR3YXJlDQo+ID4gY29uc3RydWN0cyBidXQgSSBkb24ndCBtaW5kIHJl
YWxseS4gSWYgc28sIHRoZW4sIEkgd291bGRuJ3QgbWltaWMgd2hhdA0KPiA+IHRoZSBPUyBkb2Vz
IGJ5IHdyaXRpbmcgdGhlIFJTVCBiaXQgaW4gdGhlIENUUkwgcmVnaXN0ZXIgb2YgdGhlIFZGLCBJ
DQo+ID4gd291bGQgc2ltcGx5IGluc3RhbGwgaWdiX3ZmX3Jlc2V0KCkgYXMgYSByZXNldCBoYW5k
bGVyLg0KPiANCj4gVGhpbmtpbmcgYWJvdXQgdGhlIHJlYXNvbiB3aHkgVkZJTyBwZXJmb3JtcyBG
TFIsIHByb2JhYmx5IFZGSU8gZXhwZWN0cyB0aGUNCj4gRkxSIGNsZWFycyBhbGwgb2Ygc3RhdGVz
IHRoZSBrZXJuZWwgc2V0IHRvIHByZXZlbnQgdGhlIFZGIGZyb20gbGVha2luZyBrZXJuZWwNCj4g
YWRkcmVzc2VzIG9yIGFkZHJlc3NlcyBvZiBvdGhlciB1c2VyIHNwYWNlIHdoaWNoIHRoZSBWRiB3
YXMgYXNzaWduZWQgdG8gaW4gdGhlDQo+IHBhc3QsIGZvciBleGFtcGxlLg0KPiANCj4gSW1wbGVt
ZW50aW5nIHRoZSByZXNldCBvcGVyYXRpb24gaXMgbm90IG5lY2Vzc2FyeSB0byBtYWtlIGl0IGZ1
bmN0aW9uIGJ1dCB0bw0KPiBtYWtlIGl0IHNlY3VyZSwgcGFydGljdWxhcmx5IHdlIHByb21pc2Ug
dGhlIGd1ZXN0IHRoYXQgd2UgY2xlYXIgdGhlIFZGIHN0YXRlIGJ5DQo+IGFkdmVydGlzaW5nIEZM
Ui4NCj4gDQo+IFJlZ2FyZHMsDQo+IEFraWhpa28gT2Rha2kNCj4gDQoNCkkgZGlkIHNvbWUgZGln
Z2luZywgYW5kIEkgY2FuIHNlZSB0aGF0IHRoZSBsaW51eCBpZ2J2ZiBkZXZpY2UgZHJpdmVyIHJl
Z2lzdGVycyBmb3IgRkxSIGFuZCBwZXJmb3JtcyBhIFNXIHJlc2V0IGFueWhvdy4NCmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDMwMTEwNTcwNi41NDc5MjEtMS1rYW1pbC5tYXppYXJ6
QGludGVsLmNvbS8NCkkgaGF2ZSBub3QgY2hlY2tlZCB3aGF0IHRoZSBvdGhlciBkcml2ZXJzIGRv
IHRob3VnaCwgSSBjYW4gc2VuZCBhIHBhdGNoIGlmIHlvdSB0aGluayBpdCBpcyB3b3J0aCBoYXZp
bmcgYSByZXNldCBvcGVyYXRpb24gb24gdGhlIGlnYnZmIGRldmljZS4gDQoNCj4gPg0KPiA+IFRo
YW5rcywNCj4gPg0KPiA+IEMuDQo+ID4NCj4gPg0KPiA+DQo+ID4+DQo+ID4+IFJlZ2FyZHMsDQo+
ID4+IEFraWhpa28gT2Rha2kNCj4gPj4NCj4gPj4+DQo+ID4+PiBJIGFtIG5vdCBzdXJlIGEgVkYg
bmVlZHMgbW9yZSByZWFsbHksIHNpbmNlIGl0IGlzIGFsbCBjb250cm9sbGVkIGJ5DQo+ID4+PiB0
aGUgUEYuID4gQy4NCj4gPj4+DQo+ID4+Pj4NCj4gPj4+Pj4NCj4gPj4+Pj4+ICsNCj4gPj4+Pj4+
IMKgwqDCoMKgwqAgaWYgKHBjaWVfYWVyX2luaXQoZGV2LCAxLCAweDEwMCwgMHg0MCwgZXJycCkg
PCAwKSB7DQo+ID4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaHdfZXJyb3IoIkZhaWxlZCB0byBp
bml0aWFsaXplIEFFUiBjYXBhYmlsaXR5Iik7DQo+ID4+Pj4+PiDCoMKgwqDCoMKgIH0NCj4gPj4+
Pj4+IC0tDQo+ID4+Pj4+PiAyLjQwLjENCj4gPj4+Pj4NCj4gPj4+Pg0KPiA+Pj4NCj4gPj4NCj4g
Pg0K

