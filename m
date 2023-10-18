Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A40D7CD667
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:28:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1u4-00008o-SC; Wed, 18 Oct 2023 04:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qt1u2-00008C-8h
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:27:42 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qt1tz-0003Xn-Vk
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697617660; x=1729153660;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=5PDkn48/WBrNX2NjP2S3iFob5hV5fX0cov/38DQVHaQ=;
 b=PiXaWtt+n6UR6hnbcIn2nZjEFKlun+ZwhduHk+EzYvMkYZleVSQcHK6A
 wrDBeuAFw17NTxygeZ2on8ywntt57sKAjmS0pe1wVGrSByNLS8jszQIDb
 LdqjH8bTj5zE7FGn4MlmvzoVpyAuZNMaklYRweDIk6QyqCg2WIvqqApQQ
 gJMj00m8F4o4oBSfLQeyoAFh2mfUaXDY9PUe8iNxyJpGm4tCKpBcleCA7
 Ul5RJbRHh2pnDvrTa9qotUgll5HrLylhGSTF5Rx81moaQYonwg1731YCx
 EcZGYweT3xWCA2G18x9+RrPDQJCSLIBPaY6peRRkuXRk/P45OiMVGlJZu g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="99790737"
X-IronPort-AV: E=Sophos;i="6.03,234,1694703600"; d="scan'208";a="99790737"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2023 17:27:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ej3B0vqggfJI9WABpEnRTEfhAJ2NeOmNlMVfnS78exOjtjLGl2Zh+OTxnGRWDzutYxpfWvK8DuHHczOK5ms7lOZJMbtGkjaRrq28K68F9L0U9wiWtrtcaBVBLyJteUtlLg1BtSmpWySQTxKCz0poqQ9tLx6vw4RGt25JAMrsXsi1RenvAnF07Sh+rfM30G7zcTqPB/cFCIkPs/l8Kvk0LbxXrvkMAy/utn8Y61nzPilfTJ3HtJ0tptZV/99gR+0FdT7dXIz+5c1GswCDLLp7zTtdgSOC8G+tISfHaHd8UH6+kxTAx2qCFqqzeRM5pCIVIDAwtonKlwCad0xmBn2A8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PDkn48/WBrNX2NjP2S3iFob5hV5fX0cov/38DQVHaQ=;
 b=M9utMHqiGR41NiJwbHBQ3Y7o4HJVlec02sxvXc3gbWXoXJu7xU/1J0yfVM09KE1BCTqbSAV57p98LdsukSZF83XbSOIiSEPq+xyvUs+50krOCy860lzB8JPVriMQXBySlEHdUWNRaasnWEYUm5w8IID9urZyUNSExgD1ED9KdyEAX5BhojQKc9zzRJuzp9U40/XXCH+RZ+2WV15O87J1o68MBu4XwmVxxr1nHGAENGLIHWsiBhxK9lqqpX5STWpVsP5F07RARZILcXwbPRZCpZxHzLayq6IIPySmaNG6VxTxSDmqfM/X9AltrBXd7QfIUomW4Y9MdkRSFLNOMkjOSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TY3PR01MB11004.jpnprd01.prod.outlook.com (2603:1096:400:3b0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 08:27:33 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 08:27:32 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "fan.ni@samsung.com" <fan.ni@samsung.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] hw/cxl: Fix opaque type interpret wrongly
Thread-Topic: [PATCH] hw/cxl: Fix opaque type interpret wrongly
Thread-Index: AQHZ/XhSeepNg6KajECGnAL68ec1gbBHakgAgAfUpoA=
Date: Wed, 18 Oct 2023 08:27:32 +0000
Message-ID: <4f405276-36d1-49bd-90f5-145aec18835d@fujitsu.com>
References: <20231013015515.23647-1-lizhijian@fujitsu.com>
 <657c8046-04f5-a131-cfa8-aeb493caf760@linaro.org>
In-Reply-To: <657c8046-04f5-a131-cfa8-aeb493caf760@linaro.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TY3PR01MB11004:EE_
x-ms-office365-filtering-correlation-id: 2df84810-df77-41fb-8fb9-08dbcfb41349
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eUcIFlNBsNRwKHHfRnLF923m0O4EdFAqHQsJ9YJtdstxaIz2F08xLMsBQKQNX9Koulj2J/dYCRMS3LadliPx+Nezlz1rigJyEhsckLv0EJqzqVnErPArs//YfIpdCpJMz1cACtBueiks57gpjKwLYFddd9X8jAT1FIH7lNBfpH4WJH3MAQ/jDiympBsfKRNU9BT4PAtgZQdaXAXLMsnCdEDHwBUxrBFw4JufRoIW/lyv8WxDsAVquMmorC77mmAmAnUdtu9olhkjW/wEMvy0MemRqZeZzfhe0jV/uCXCtrp4w7we5WbZ6dLlSsNYKjd+e5gVNKSg+LSfxfX9uILS2ENQnWu/LpRzNenXN57Ug5z03NB0NF7H8aTDRJrqqajZnj8LV5ZpnIsgWIjzIyB0ece8ix8cLN1HGFbZN5RH5Eh50i0BcnKpPLfgdePCSnlKHkZiqmEhHrfJQpY0S1e4+hJaiYOkLwXqsZfXEyXtIwnIUYSWSAextbmJjmbqEIHyzyvZ+b/wCOTN9kW2T+ZdrybyKZVAAx5Uyw1cVbC4FHVmid8xJfps6yq29Gb/31nXjp5ON79xxgazdR5ZeQ0I/fTOAOZYhawaljX0xNkYjmfav8xIwU18TeBJ3B9laiWgunvH24ZyaplRVQDCzA5rfeCPGvYzCKkBEZAoH7WR05OM+wZIIH1J8BOEq+phu0DZSoyOnmXgg4z8qC/+eczpQg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS0PR01MB5442.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(1590799021)(8936002)(31686004)(1580799018)(31696002)(38100700002)(38070700005)(5660300002)(85182001)(122000001)(82960400001)(2906002)(4744005)(41300700001)(36756003)(86362001)(53546011)(478600001)(66946007)(110136005)(76116006)(91956017)(66556008)(6486002)(71200400001)(316002)(83380400001)(8676002)(4326008)(2616005)(6512007)(66446008)(6506007)(64756008)(26005)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0trRGdqZUdoMUh2cFZuZjBKOGpDOEdwRWdBWGVTZ2M3WnNXR1ZXbGcybzZB?=
 =?utf-8?B?bjdKYk1GRTk3aXFOb1NRTS9IM0xtbS9nZUpmWlhRZTNUT3NnVnRpWklhMHVB?=
 =?utf-8?B?UXBsNEc2citCdnBybTVBQjdhME81L20rb21SQ3gwSkVGb2w2M2wvNWJKc2dU?=
 =?utf-8?B?STNNZkRxOTIxbGZRVStIZVc1dW1LbEI3cFJwYUlEd2xGNkxCVm1UdXJaV1ho?=
 =?utf-8?B?b2FlVU9haitGQmZDaGdyWVpraXZKT0pieGx6YXZZaHltYURKVWczdkNiclNn?=
 =?utf-8?B?VUhpNGdZMU1vY3hTZnNVMWZoQXEwQm55SGtpVVlHb2FiWjVxdkRwREpUYnR3?=
 =?utf-8?B?T1FvK0owWk1zVVptTXBRYVBvNUZ2aFZ5WExmUnVSNmtsRVNySWFLZjF6N2JV?=
 =?utf-8?B?WlVvNXVEU3lEMTduYll4TEhLdlRTbUwzTUMyZDZnc3psSEpZMjZmc1h0N0d2?=
 =?utf-8?B?WkxwSWRuL0pGanRSd0dHd0Y0emxLTzBqWU42RmdjUVJuRHloMFZzYUJXZW9y?=
 =?utf-8?B?OTVmclVLcUF0YjZIQUF2YWMyMHZmdDhucjFHOVpVcm9Kc0N2b0JaZzJ6R3Yz?=
 =?utf-8?B?c1lQcGFQNHhVdk9YWW9ERC9QZjFjTEhOTUFhZWdiUVNiZG5WeVBnRzd1THVS?=
 =?utf-8?B?YUkyQ1JjV1QrRmgvNzJsQm9SY0d3OEdrOEVzaWVka3N6cHd0K2pUbGpQUTF5?=
 =?utf-8?B?TkduNE9uWGo3UWtibU1SYXIyWFNFTmlVN0JubzZsTzFlRnR0amQ3by9TSC93?=
 =?utf-8?B?YndWeWtsbzY1NTBjWm5oNGFZZGE2dWxKejlKMk1SbkpubU9YelREZGEvWGI4?=
 =?utf-8?B?Y2JURWNUQW1xZ0dxYTNtVVdldlh1c2ErU0tvS2JqWlNiQzlsaGVxVjBINWxk?=
 =?utf-8?B?Z0ZvYTE2MkxlUG51T2NwckIrTC80STI3eHFBajR2MmdZaWhWYkZ2aXIyUk5u?=
 =?utf-8?B?bmlmdk5CbGZuL2R0Wjk5Qy9Vb0pJV0ZlWVdTSGk4UXkzeXVTaTIwWFR1aElW?=
 =?utf-8?B?cTdSc3ArRlpFcytSVldPZ1QwbGZyN2pURjArdnEwcWdNZW4vait5ZDBZOERW?=
 =?utf-8?B?TW1uMVJtNThCZGJsaW1HbXdIcGFka2xZNlJmUjEwMlJ3UE1Lb3hobGlNSk42?=
 =?utf-8?B?TXpqZ2hCdHB3d1UxY1UxNFFiN20xVHBJNVRhTlNlQTlRaHVaa3JHaitGU2gy?=
 =?utf-8?B?cEVEbDF0eUJvVGhFZTdqQ05NQVl6aHkwTCt1c0gySkZONVM5ZENMTlB3TGN4?=
 =?utf-8?B?ZWltMWQzSHpBVTF1SWtLbDE0R3dCaWlpWWpxU1BZWlI3Vy9UdGJDZG1IQ1Fx?=
 =?utf-8?B?Q2RTbUpvaC9xV2ttYXE0TWNlaUN1YWg4eWhNRlZXZVlmSzhFN3diSW5EYnVR?=
 =?utf-8?B?ZElIMTNkTFNTeUdneE0rdWc0VzNPa1RZVTNqenRuTUE2VlFuZTdUQS9qQVBK?=
 =?utf-8?B?bUJyOHJaMXVGSUkvM0VpSWtOVEU2SFhxTzFrNU9pdVFrR0pURkg1VWc4K29V?=
 =?utf-8?B?ai9Pcm12RFMrZFZXZFhLYW9kd1poRWZHeFY3eGpDSS9OOXpGbmJzZ2h6enZN?=
 =?utf-8?B?UUFsV0NxNU93TWVFbDZ5dTJsQm5rNHVTTzRsSFFSZnhCOENuMUlzZm1NMnNn?=
 =?utf-8?B?ZkYvTVhGb01VdTVyV0tOczIrNy96RktCRWw0NXR4MVNCOFN0cmt6Z1FBV3ht?=
 =?utf-8?B?TCtvNCtuMEZCa1orTFljVmljV3MzaWI1VXlRQ1YwbUtPbVlXbFA2OG5qbzJO?=
 =?utf-8?B?ZmpDR1NJN2hpTnpzekxSam9jZ1drTUR2cmxwQlJ1aCtvTzFUeE9pZC9hdHNG?=
 =?utf-8?B?RnQzZlBJZU1YNnB1OVlqbFF3Y2Q3OUlQQlhKOXBJVmIyZ1NuaEVOeExmRkw1?=
 =?utf-8?B?Vml2eERKQm1Eb1RFSzZBK2UvV0Vzd0s1QWJtamdWcTU5NjRQaVpOYnQ3M09D?=
 =?utf-8?B?ckV1YkZtNE5mbWhsUjBYQnpLTE9ZVXkybXpqNko3TGFJTHdQQ2xpYzY2R3d5?=
 =?utf-8?B?T3BpMkVEOTNXRHZQdVVtM2lhR0pLWDBnRjVPV3lWaVA3dlpVb1J1Rlp5dTQ2?=
 =?utf-8?B?RG4vSzlTZjIwTFdvRmNXN2xkM0EyY2wyUXpENUUwUW45cm5FUUhnTVl1MUpS?=
 =?utf-8?B?Qm1EaHAxWU1UaFJVSjd2emg1MVhjUGhCeTBMcXM2ZlMxbEMzYWViUVFHSFpE?=
 =?utf-8?B?Q2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7543B515BC3F842BEBF661088107194@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gXnwGhSf7KzPAPJrJJIkUwnRitnal4pQBjD27A1Z0c6eJ35nM07NoD9qHMh4TI79zdYambOdE8MyCLmg68R4nPwbO1iGnOEFPuB2mv2c9TnXIqDFMuUEOWjx8XKvA9qmNqwXk+X7DDwvrfZrMKoOxWc2nhqR+EIdCLCyW3Emeikqoug7JDs6Lje3x8WydtQCWgCyKutx20SNtlcOh1o6RR7L9xxPbxiwDe+YhLSCrt2BfKSI5SugVBWDEnTUlozfxUtvHPw2t1G3hheEe1qNDORI5zma0xJvDNses5F4JP+fai3TOp0hvfNhQcSp3dJMsLTSGD36n55R4T2CKpk3P93yh6Sto7Q0mQP17ap/kXSDtaWmt3pVGHNpUEYq4eXTKWkVjmv4Fczhs1t3d0s+xgOMkYdJuppvurh9R2ynHFkuelUtIOYZV/zHptgPaPAXt8E/TOUDBoi8BF0U3TvsNoZ8woSFdceo6Ya70EtWoIeJGhPBrccIlZ/4v4V+LKieir+ha0+HXt0x59qq6qGi9OqVXR7ZRh3QQMkcbyhuFFwMHlrFphUunA8SRWktp4zktlvRAs52SzZCLmUQj1QTa25vocMt/OfzbUY8CV5zlo76/Unm0xBGI8Y8Cw3fUzpohwWlzm9lcBmwGNkDCklOm6EPhdeixJZyoSNDGz/NMu5tYSe4DwNOw0JZXL93QwGhm0ata2/1oFx9RQwsosIRbrXRP/OAL/2t7+kRhn03Z49jAdmIQRCqfqZLghr7bErOTKmgwYUaqN1cu9mCu90Xzb1GCag7zpBKpWOy0V8Ij6SB3nSBoCLkF0WyHGY//JW2rYCSdPHYOFUGUCXnnJLbaBHJen0DG6eGs/eTE13f+pI=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df84810-df77-41fb-8fb9-08dbcfb41349
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 08:27:32.7198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5xqwDCx9+8k0W1JXLIYOEm2vYuRqv6Uo8B//1ibvDW8tprzim0ZzWDoYNhkUW0gi6V0Yci1h4Eu9bpzAItkWeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11004
Received-SPF: pass client-ip=68.232.159.90; envelope-from=lizhijian@fujitsu.com;
 helo=esa9.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

DQoNCk9uIDEzLzEwLzIwMjMgMTY6NTIsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0K
PiBPbiAxMy8xMC8yMyAwMzo1NSwgTGkgWmhpamlhbiB3cm90ZToNCj4+IHZvaWQgY3hsX2NvbXBv
bmVudF9yZWdpc3Rlcl9ibG9ja19pbml0KE9iamVjdCAqb2JqLA0KPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIENYTENvbXBvbmVudFN0YXRlICpjeGxfY3N0YXRlLA0KPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGNvbnN0IGNoYXIgKnR5cGUpDQo+PiB7DQo+PiDCoMKgwqDCoCBDb21wb25lbnRSZWdp
c3RlcnMgKmNyZWdzID0gJmN4bF9jc3RhdGUtPmNyYjsNCj4+IC4uLg0KPj4gwqDCoMKgwqAgbWVt
b3J5X3JlZ2lvbl9pbml0X2lvKCZjcmVncy0+Y2FjaGVfbWVtLCBvYmosICZjYWNoZV9tZW1fb3Bz
LCBjcmVncywNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgIi5jYWNoZV9tZW0iLCBDWEwyX0NPTVBPTkVOVF9DTV9SRUdJT05fU0laRSk7DQo+
Pg0KPj4gT2J2aW91c2x5LCBvcGFxdWUgc2hvdWxkIGJlIHBvaW50ZXIgdG8gQ29tcG9uZW50UmVn
aXN0ZXJzLg0KPj4gRm9ydHVuYXRlbHksIGNyZWdzIGlzIHRoZSBmaXJzdCBtZW1iZXIgb2YgY3hs
X3N0YXRlLCBzbyB0aGVpciB2YWx1ZXMgYXJlDQo+PiB0aGUgc2FtZS4NCj4+DQo+PiBGaXhlczog
OWU1OGY1MmQzZjggKCJody9jeGwvY29tcG9uZW50OiBJbnRyb2R1Y2UgQ1hMIGNvbXBvbmVudHMg
KDguMS54LCA4LjIuNSkiKQ0KPj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFu
QGZ1aml0c3UuY29tPg0KPj4gLS0tDQo+PiDCoCBody9jeGwvY3hsLWNvbXBvbmVudC11dGlscy5j
IHwgNiArKy0tLS0NCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pDQo+IA0KPiBSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBo
aWxtZEBsaW5hcm8ub3JnPg0KDQpQaGlsaXBwZSwgdGhhbmtzIGZvciB5b3UgcXVpY2tseSByZXZp
ZXcsIEkganVzdCBwb3N0IFYyIHdoaWNoIGNoYW5nZSB0aGUgc291cmNlIHNpZGUgdHlwZQ0KdG8g
Q1hMQ29tcG9uZW50U3RhdGUgYmVjYXVzZSB0aGUgcmVhZC93cml0ZSByZXF1aXJlIGl0LiBQbGVh
c2UgdGFrZSBhbm90aGVyIGxvb2suDQoNCg0KDQoNCj4g

