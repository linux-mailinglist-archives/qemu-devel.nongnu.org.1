Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DC6783DC4
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 12:19:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYOS4-0006k4-QH; Tue, 22 Aug 2023 06:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qYOS2-0006jw-Mg
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 06:17:30 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qYORz-0001Zk-3n
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 06:17:30 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37M27Hma016320; Tue, 22 Aug 2023 03:17:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=yGxLmhzUfIg/gF90zL97W5bFf9nktM0T5JGlkn
 XXQBk=; b=sJAyAZ3mSg3ekW8/R5a3Qdr6uYDTOr0sNzIe6yKIhvhROwch7SK9dc
 CCyq7vnlrfkxYzaC1Iv+0UziQTw/g8TF3+LVEJOrLRQZFyHWxAbRApxQWtvn+xSw
 Ul6dkwNrSd50mHdsagyCa0AQRk3CTX6NdlIUxdoYTDKrqqzWiykfyUomz0Qrc7+S
 v4FFbYnqz5M3v6Exn2otd8FSg5I9Vyjgs8FH9eigeBH8Umil/j+ZxcsSYC7OUvDD
 vpZoMvoJC8OKGZTC7RepQkGaglg/Byty/VrX19eEd5IdqxdJHm1FengzEEox0nFX
 gmR9GLhDP0pY9Lle4XSJ2aPWcGSdfjmw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3skun032c3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Aug 2023 03:17:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fe4EaN2dWrElPjqSrpHlYS0FT3Ktu0MQnr1OS2RydKOgImAu5WLZmg+kJq3Qee2izb20rKlvdUUMMfVNZrIJNjcSRW3bo4ENZOpci+GWXlJo70QxQRQDbpX1//e9MDRiGik1cY0Y/oXc2Mr9tq/RBm15wIKeaPzWT4UPUug+h/11JiqSGUe/Z3idjnfHQBftH1jlWs0ymNaGSYfyexKCSqjUZ4VLG+vy1iHoaq/F7l8LC0/AybIwdRF1oTegWpiStXAgJ0k7r6gUbh22jlEqMx0XRWaMkwBI91XuwGSV87yu/agg0d9ULONu47NbZsoWiULEOnlUCjFFXe9Q4zL9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGxLmhzUfIg/gF90zL97W5bFf9nktM0T5JGlknXXQBk=;
 b=QqBWWTa6oacSqUODQJ99pjI9WXdLt5PrFZl9WpRm2JEfNmIJHbTvtfN2nCtLDrjZ7SzOEBS0xE76t2QEIwq0nfgo5fe2btqoE7I4MCX55/EQSxiy8Dp2iL8y8G7OYokWkOpfSusQ0QaKCS6juwzHW7WL4qlj/P+WOIGTHmCZIO2iHg1pWgaPd3eOZYoB1tAullfRZJWJKzrkkYEzI/kfUyy8LPN6COyrVHALFLw9jkUyu3Q0er/LeI6G+t9BB1QFErpHoZ9QQuIBa57zen8bLpaH9v1IhiGNqxixge0RxPPVxSqRQA8rRNvpX7kyjacpTkEyzAHbzkOYMkIGq1Q7oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGxLmhzUfIg/gF90zL97W5bFf9nktM0T5JGlknXXQBk=;
 b=dA4FZA3mmV+Tr3nnEDu2AR45Lgrgr4SgaBYXyvSsFg7AvHjYlGWODNmQqqzp9wP7v66uCMyxayfr+kTVEs6cJRrG1eZ7JGkE5AO2sAQ6nJPqDza1lMYHGtM5mtvxkp9rReCZvvRjvAoi6Y4bDnyCRzw70Y2dltRpPBY6n3iKcH8o+nlPh+VIrvPtjHBAB/v3wMo2gmAYUSoKoDnTdfhb1CZPU6/Gj7HLr2hTiS70Lc+L0bfh1Yz2q2VQuAxDzNQFQp8xc5OwlFbk6gOnlccDoQQL5xjsXx0wZUYXNxlQ9BkiEDAxkZxNZj7DWd9PaX6tI1rhUN0WJr9ItI0wAigCgQ==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by SA2PR02MB7755.namprd02.prod.outlook.com (2603:10b6:806:147::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 10:17:08 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::1da1:b8:e69e:79c8]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::1da1:b8:e69e:79c8%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 10:17:08 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Li Feng <fengli@smartx.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/2] vhost-user: fix lost reconnect
Thread-Topic: [PATCH 1/2] vhost-user: fix lost reconnect
Thread-Index: AQHZxpTSe3WncXIlnk6ipNyEGIOYZ6/pwLIAgARdiwCAB3aAgIAARjUAgABbfgA=
Date: Tue, 22 Aug 2023 10:17:08 +0000
Message-ID: <EBB49CB4-E0AE-4131-9A66-0C50D06E60CB@nutanix.com>
References: <20230804052954.2918915-1-fengli@smartx.com>
 <20230804052954.2918915-2-fengli@smartx.com>
 <894CEF7E-9523-444F-8459-330BE4236B7A@nutanix.com>
 <F0FCF1EC-8E24-4515-A800-BD01D9D3D526@smartx.com>
 <2D662C4C-B636-453A-B2D0-F4EDA4B43041@nutanix.com>
 <CAHckoCxZFe78ghhuxrxF-SzO4XHvAOry993f-rH+kFdK6OPE0w@mail.gmail.com>
In-Reply-To: <CAHckoCxZFe78ghhuxrxF-SzO4XHvAOry993f-rH+kFdK6OPE0w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|SA2PR02MB7755:EE_
x-ms-office365-filtering-correlation-id: be1e0424-a48c-477e-3cae-08dba2f8f10e
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qTIAB6OupQ2YFH36AATgd1qqQBcrlD+vw7fYA1ml9MYDhIvTYYebnC4ad4IKGUSkp66FIzvaNly+/jYl+OHGSS/gfQtph4Kr12WDvgenfFOH7V6SDEiz4O9mc878QlwsvjiFJ8B31zGJTA2Akb0PZgBf59oWNl4TW0FRUC3M8Wzzr54PwxktumskHQlC8pcgv3Xgl/oO8f820YTXKZ2xwxXw8v2iMOKfsGUaMa+RMesiSUxZK6wqYVVArNw/Oc1NthMoe7wCfMIDaJHFrdeDcCShizJYV21wSQoux6G+hy65CiaM1zwztZcCCYDrjgDpU1F0MPzChTGE1wUt/mulovXvVKwsQwR0+P31fMxCuMdsnMEKsLguJ17d3AgqtVFAnYnlds5qgatPKiino68DPVI8gZuGyBCS2BofQuQo63azxfFADtjfOlbAUKbnbs2XFrAbo8pbSU+il8LQz7wi7hiW81MDh43Xut3xr2dzmyaqb5PBRDH6IgOUUHbPdq4wlipyoOwVlEdvsbl/uj/AFh5Wa1l77eGMXb9e7wMd/Wn2ULO4rPtYpabTFAHE9EFsujrRqXVK+2nhaO+r08KbEPiTmKYW96ODoRkSOduRd4h0u+o/PJzzCXV9+eigVmVegFqODbcjiPnUbts1CuMPHA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(186009)(451199024)(1800799009)(6512007)(71200400001)(53546011)(2906002)(6506007)(6486002)(2616005)(86362001)(122000001)(38070700005)(66556008)(64756008)(6916009)(38100700002)(66446008)(54906003)(66476007)(91956017)(316002)(41300700001)(36756003)(66946007)(76116006)(44832011)(478600001)(8936002)(8676002)(4326008)(5660300002)(33656002)(83380400001)(26005)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDlkWWVTYkxxMWtlVlJBSDFVNEl5R0hxb3RkM3d4MEtoK1Brblo0NmlqY0ZW?=
 =?utf-8?B?akZYK1Z3VlNHMjVjT3JiUTZtM3Z0M2xvQ2tkM2hROTFoYnhsSTFyTUdxQVdS?=
 =?utf-8?B?eFIzVFRDUU82cFFMNW5XZUN0THBNWFFGcFhuUU9WeWUreHNvZWwwU0o3RUsw?=
 =?utf-8?B?SlBpQmp2SVRseGJRUllRVlFWd3lyZWZyd0NSQ0QxMjc3YUFsbmszTU5iM2xR?=
 =?utf-8?B?ZFI2SXlhWkRqMEtncTRSekVsbzd3Zit1SHo5aUJ4YTUzN09STFJzTGlxMGIr?=
 =?utf-8?B?dUR5WEtRaFR1dWJaK2hDeVJtOE4zck5nRVNPdTE1MGg4S3ljVSsyOU9FS09P?=
 =?utf-8?B?ejFYZVdoRkRBMnArTkFDOTJELzVEKzVPbHd2aE05eGdmS25QaUo2Q2VmU29v?=
 =?utf-8?B?K050MnAxSHVTVUFpVUQ5L3pMdkZNOGdqZVFEd01jU0QrTGJrN3drZHN0WTFZ?=
 =?utf-8?B?S2RXdWRXOC9sVGVaMWhZbFVvWDd0N09zeVF3OFU1MlhGVzlUOGRKRlZSeWI3?=
 =?utf-8?B?dERnMnVkZzd0V1A3R290TDZYTE1vbFhYb203L01PUWV2cE4veFJpY3Rzbk9J?=
 =?utf-8?B?Q25RYWpSTnY3TDFHNXZJVVpQY3ExcG90MnFIRXViZXdjd25jeTFMV3lBdzlH?=
 =?utf-8?B?d1pXcHFFY2lWSERUY0V3UlZKcGtIbmlEWEFpK3l3NUFzL0RYemVjQU9Sdzlu?=
 =?utf-8?B?Um8yZjBUME90bFg5cUNtc3k4UzhKeGVvVlZ4emVsU3BQWFFZNUJoQ051RXow?=
 =?utf-8?B?MlcraEx3SnRhUVVkMnRDWmZ3Wm9uNU56bkk4bisyZS9raWtYYVlELzVmdW83?=
 =?utf-8?B?T3VDbVlZTllIUytqMHEzZEFYNmlDcnhNOGI2emJTOE5rWVFablpXNG5VRVZw?=
 =?utf-8?B?MU5Bakx6b1FsUnduemcvaExkZUdOQlZoOGtlclpYZGJubG1tOHRIQzNKNWcw?=
 =?utf-8?B?VVppQXJxV1NCK2EwYkFXYys2NE94dGVRMWZNekZuUVBGM1hQd0JzSExqL0U5?=
 =?utf-8?B?ZXhGRHVmRitLNkZ3MytFVE1adnU4REZtdWJDbFFUdlZ6WWNyRmJOUU9UWW9G?=
 =?utf-8?B?TVcrTEM2QlVmYnBCeGRZbHdKVUZCcDNVaXpFcW1yWEJpV2F2WmNoS1hOVUxV?=
 =?utf-8?B?TnpTRys5NFhqZEFZODV6NUUxd1NxMlJjM1ZNeEZSZG9la0svSUZ1N0crSGIy?=
 =?utf-8?B?RW5JaTZOTnlwazBITWl0b3J6Ui85bmdGRWkrbnFlVzlaTFAzL0VnVU5zVVVx?=
 =?utf-8?B?Q1pIUms0NDZHcG12aWpYRnhPK3BNb3Y2WUt0KzUxSmI3QWVXUytRQndmcTdj?=
 =?utf-8?B?SG10TFU0cFlCd3dIRysxQWc4aG9qUGpaU3VQcUxaQTJUR2tWdnZFNE5LY2Rn?=
 =?utf-8?B?TVJTZUJiSi8rc1U3c0tqRlZRRTlqdXB3TmhxWXhOeTVXbVMwUkl5WjZKRTB5?=
 =?utf-8?B?dzRaMjM5KzJZUWV1SXNkS21lZzFWNTJmcEwwZFprNjBvRVdkd3FRTHpTVld1?=
 =?utf-8?B?bUZPL0NlaCtaZXlheEJ0a1Z3Sk40U2plK2dDK2VuWEREaUJueWRXUmhyYTBY?=
 =?utf-8?B?eFR6dkFVbFZGUmlEc0NiaGc0V2dMSTBDUXI3QUtMeGYrV2hVK2NaTlNUcExW?=
 =?utf-8?B?eXkrRkFmV2FmVHFzUGh0YWpUK2ZXWEJMN2hqalFGa2pGYVpzVVFkKzJMam9l?=
 =?utf-8?B?SjBpQ1pUZkRXVU9KTm9nOXR4bWIwQ05iMERwUXU4eHRnVzlnQnhhZi9xdFcv?=
 =?utf-8?B?YStuZi9GK2JuaWRtT0w0Sk5jblIzZUhWWUJWY2hzNnZHWHRHRHZmd3dSaWRZ?=
 =?utf-8?B?bFJ1M0I5TExuQ0F0OW0wUVFGdWE2RUgrbTQ0eFByUUhKR3MyRkNvYnlIS05k?=
 =?utf-8?B?YXdLcWZvKytJdG9MYitwY2E1b0RmazJMZy9KU3JwUHJPaWxhYWpwUGcrMUFz?=
 =?utf-8?B?U0pMQ3RUWjFCcEJhb0tXRlA0YkUyKzRPc0RKYWo4eHNXcy9GSUdqWkh0L3d2?=
 =?utf-8?B?Zlg3SEVkbzdPZUhkdTRiaGczSCtJWkJ1c1IrZUpDeUVBVklESUN4cmo1OVFJ?=
 =?utf-8?B?UHUvc29kQ2s2TSsrTkFnMFE4Z3VIQ3A3UWVucGtwUkhvQ2JFekZDUURWdmJJ?=
 =?utf-8?B?RGRCOWI0VmdTelI5dnVFSGxOUUszQzl0aUt5d0UzK0JvZXFPMTc1L2JGWUdF?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A0290906E6CAE4484CDD43CB0E9BF3A@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1e0424-a48c-477e-3cae-08dba2f8f10e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 10:17:08.2749 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Fw2T9Cxa2wxeUCBRwm2wXhHpLsCK7dWfDgzetuf4iKTqSFijkc53PnyN4PsF3/hZ8apR1rhNCQu1I8vLXQInvH03by4mzaIptedY8YjPk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7755
X-Proofpoint-GUID: CB9R2VvKYV5S05yAn3G8yEwf1sRISnlL
X-Proofpoint-ORIG-GUID: CB9R2VvKYV5S05yAn3G8yEwf1sRISnlL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_10,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=raphael.norwitz@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gT24gQXVnIDIyLCAyMDIzLCBhdCAxMjo0OSBBTSwgTGkgRmVuZyA8ZmVuZ2xpQHNtYXJ0
eC5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPj4gT24gMjIgQXVnIDIwMjMsIGF0IDg6MzggQU0s
IFJhcGhhZWwgTm9yd2l0eiA8cmFwaGFlbC5ub3J3aXR6QG51dGFuaXguY29tPiB3cm90ZToNCj4+
IA0KPj4+IA0KPj4+IE9uIEF1ZyAxNywgMjAyMywgYXQgMjo0MCBBTSwgTGkgRmVuZyA8ZmVuZ2xp
QHNtYXJ0eC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IA0KPj4+PiAyMDIz5bm0OOaciDE05pelIOS4
i+WNiDg6MTHvvIxSYXBoYWVsIE5vcndpdHogPHJhcGhhZWwubm9yd2l0ekBudXRhbml4LmNvbT4g
5YaZ6YGT77yaDQo+Pj4+IA0KPj4+PiBXaHkgY2Fu4oCZdCB3ZSByYXRoZXIgZml4IHRoaXMgYnkg
YWRkaW5nIGEg4oCcZXZlbnRfY2LigJ0gcGFyYW0gdG8gdmhvc3RfdXNlcl9hc3luY19jbG9zZSBh
bmQgdGhlbiBjYWxsIHFlbXVfY2hyX2ZlX3NldF9oYW5kbGVycyBpbiB2aG9zdF91c2VyX2FzeW5j
X2Nsb3NlX2JoKCk/DQo+Pj4+IA0KPj4+PiBFdmVuIGlmIGNhbGxpbmcgdmhvc3RfZGV2X2NsZWFu
dXAoKSB0d2ljZSBpcyBzYWZlIHRvZGF5IEkgd29ycnkgZnV0dXJlIGNoYW5nZXMgbWF5IGVhc2ls
eSBzdHVtYmxlIG92ZXIgdGhlIHJlY29ubmVjdCBjYXNlIGFuZCBpbnRyb2R1Y2UgY3Jhc2hlcyBv
ciBkb3VibGUgZnJlZXMuDQo+Pj4+IA0KPj4+IEkgdGhpbmsgYWRkIGEgbmV3IGV2ZW50X2NiIGlz
IG5vdCBnb29kIGVub3VnaC4g4oCYcWVtdV9jaHJfZmVfc2V0X2hhbmRsZXJz4oCZIGhhcyBiZWVu
IGNhbGxlZCBpbiB2aG9zdF91c2VyX2FzeW5jX2Nsb3NlLCBhbmQgd2lsbCBiZSBjYWxsZWQgaW4g
ZXZlbnQtPmNiLCBzbyB3aHkgbmVlZCBhZGQgYQ0KPj4+IG5ldyBldmVudF9jYj8NCj4+PiANCj4+
IA0KPj4gSeKAmW0gc3VnZ2VzdGluZyBjYWxsaW5nIHRoZSBkYXRhLT5ldmVudF9jYiBpbnN0ZWFk
IG9mIHRoZSBkYXRhLT5jYiBpZiB3ZSBoaXQgdGhlIGVycm9yIGNhc2Ugd2hlcmUgdmhvc3QtPnZk
ZXYgaXMgTlVMTC4gU29tZXRoaW5nIGxpa2U6DQo+PiANCj4+IGRpZmYgLS1naXQgYS9ody92aXJ0
aW8vdmhvc3QtdXNlci5jIGIvaHcvdmlydGlvL3Zob3N0LXVzZXIuYw0KPj4gaW5kZXggOGRjZjA0
OWQ0Mi4uZWRmMWRjY2Q0NCAxMDA2NDQNCj4+IC0tLSBhL2h3L3ZpcnRpby92aG9zdC11c2VyLmMN
Cj4+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC11c2VyLmMNCj4+IEBAIC0yNjQ4LDYgKzI2NDgsMTAg
QEAgdHlwZWRlZiBzdHJ1Y3Qgew0KPj4gc3RhdGljIHZvaWQgdmhvc3RfdXNlcl9hc3luY19jbG9z
ZV9iaCh2b2lkICpvcGFxdWUpDQo+PiB7DQo+PiAgICAgVmhvc3RBc3luY0NhbGxiYWNrICpkYXRh
ID0gb3BhcXVlOw0KPj4gKw0KPj4gKyAgICBWaXJ0SU9EZXZpY2UgKnZkZXYgPSBWSVJUSU9fREVW
SUNFKGRhdGEtPmRldik7DQo+PiArICAgIFZIb3N0VXNlckJsayAqcyA9IFZIT1NUX1VTRVJfQkxL
KHZkZXYpOw0KPj4gKw0KPj4gICAgIHN0cnVjdCB2aG9zdF9kZXYgKnZob3N0ID0gZGF0YS0+dmhv
c3Q7DQo+PiANCj4+ICAgICAvKg0KPj4gQEAgLTI2NTcsNiArMjY2MSw5IEBAIHN0YXRpYyB2b2lk
IHZob3N0X3VzZXJfYXN5bmNfY2xvc2VfYmgodm9pZCAqb3BhcXVlKQ0KPj4gICAgICAqLw0KPj4g
ICAgIGlmICh2aG9zdC0+dmRldikgew0KPj4gICAgICAgICBkYXRhLT5jYihkYXRhLT5kZXYpOw0K
Pj4gKyAgICB9IGVsc2UgaWYgKGRhdGEtPmV2ZW50X2NiKSB7DQo+PiArICAgICAgICBxZW11X2No
cl9mZV9zZXRfaGFuZGxlcnMoJnMtPmNoYXJkZXYsIE5VTEwsIE5VTEwsIGRhdGEtPmV2ZW50X2Ni
LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEwsIGRhdGEtPmRldiwg
TlVMTCwgdHJ1ZSk7DQo+PiAgICAgfQ0KPj4gDQo+PiAgICAgZ19mcmVlKGRhdGEpOw0KPj4gDQo+
PiBkYXRhLT5ldmVudF9jYiB3b3VsZCBiZSB2aG9zdF91c2VyX2Jsa19ldmVudCgpLg0KPj4gDQo+
PiBJIHRoaW5rIHRoYXQgbWFrZXMgdGhlIGVycm9yIHBhdGggYSBsb3QgZWFzaWVyIHRvIHJlYXNv
biBhYm91dCBhbmQgbW9yZSBmdXR1cmUgcHJvb2YuDQo+PiANCj4+PiBGb3IgYXZvaWRpbmcgdG8g
Y2FsbCB0aGUgdmhvc3RfZGV2X2NsZWFudXAoKSB0d2ljZSwgYWRkIGEg4oCYaW5pdGVk4oCZIGlu
IHN0cnVjdCB2aG9zdC1kZXYgdG8gbWFyayBpZiBpdOKAmXMgaW5pdGVkIGxpa2UgdGhpczoNCj4+
PiANCj4+IA0KPj4gVGhpcyBpcyBiZXR0ZXIgdGhhbiB0aGUgb3JpZ2luYWwsIGJ1dCBsZXQgbWUg
a25vdyB3aGF0IHlvdSB0aGluayBvZiBteSBhbHRlcm5hdGl2ZS4NCj4gDQo+IFRoZSB2aG9zdF91
c2VyX2FzeW5jX2Nsb3NlX2JoKCkgaXMgYSBjb21tb24gZnVuY3Rpb24gaW4gdmhvc3QtdXNlci5j
LCBhbmQgdmhvc3RfdXNlcl9hc3luY19jbG9zZSgpIGlzIHVzZWQgYnkgdmhvc3QtdXNlci1zY3Np
L2Jsay9ncGlvLCANCj4gSG93ZXZlciwgaW4geW91ciBwYXRjaCBpdOKAmXMgbGltaXRlZCB0byBW
aG9zdFVzZXJCbGssIHNvIEkgdGhpbmsgbXkgZml4IGlzIG1vcmUgcmVhc29uYWJsZS4NCg0KSSBk
aWQgbm90IHdyaXRlIG91dCB0aGUgZnVsbCBwYXRjaC4gDQoNCnZob3N0LXVzZXItc2NzaS9ibGsv
Z3BpbyB3b3VsZCBlYWNoIHByb3ZpZGUgdGhlaXIgb3duIC0+ZXZlbnRfY2IsIGp1c3QgbGlrZSB0
aGV5IGVhY2ggcHJvdmlkZSBhIGRpZmZlcmVudCAtPmNiIHRvZGF5LiBMb29raW5nIGF0IGl0IGFn
YWluLCBkYXRhIGhhcyB0aGUgY2hhcmRldiwgc28gbm8gbmVlZCB0byB1c2UgVklSVE9fREVWSUNF
KCkgb3IgVkhPU1RfVVNFUl9CTEsoKS4NCg0KVGhlIGZpeCBnZW5lcmFsaXplcyB0byBhbGwgZGV2
aWNlIHR5cGVzLg0KDQo+IA0KPiBUaGFua3MsDQo+IExJDQo+PiANCj4+PiBkaWZmIC0tZ2l0IGEv
aHcvdmlydGlvL3Zob3N0LmMgYi9ody92aXJ0aW8vdmhvc3QuYw0KPj4+IGluZGV4IGUyZjZmZmI0
NDYuLmVkYzgwYzAyMzEgMTAwNjQ0DQo+Pj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LmMNCj4+PiAr
KysgYi9ody92aXJ0aW8vdmhvc3QuYw0KPj4+IEBAIC0xNTAyLDYgKzE1MDIsNyBAQCBpbnQgdmhv
c3RfZGV2X2luaXQoc3RydWN0IHZob3N0X2RldiAqaGRldiwgdm9pZCAqb3BhcXVlLA0KPj4+ICAg
ICAgICBnb3RvIGZhaWxfYnVzeWxvb3A7DQo+Pj4gICAgfQ0KPj4+IA0KPj4+ICsgICAgaGRldi0+
aW5pdGVkID0gdHJ1ZTsNCj4+PiAgICByZXR1cm4gMDsNCj4+PiANCj4+PiBmYWlsX2J1c3lsb29w
Og0KPj4+IEBAIC0xNTIwLDYgKzE1MjEsMTAgQEAgdm9pZCB2aG9zdF9kZXZfY2xlYW51cChzdHJ1
Y3Qgdmhvc3RfZGV2ICpoZGV2KQ0KPj4+IHsNCj4+PiAgICBpbnQgaTsNCj4+PiANCj4+PiArICAg
IGlmICghaGRldi0+aW5pdGVkKSB7DQo+Pj4gKyAgICAgICAgcmV0dXJuOw0KPj4+ICsgICAgfQ0K
Pj4+ICsgICAgaGRldi0+aW5pdGVkID0gZmFsc2U7DQo+Pj4gICAgdHJhY2Vfdmhvc3RfZGV2X2Ns
ZWFudXAoaGRldik7DQo+Pj4gDQo+Pj4gICAgZm9yIChpID0gMDsgaSA8IGhkZXYtPm52cXM7ICsr
aSkgew0KPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZpcnRpby92aG9zdC5oIGIvaW5jbHVk
ZS9ody92aXJ0aW8vdmhvc3QuaA0KPj4+IGluZGV4IGNhMzEzMWIxYWYuLjc0YjFhZWM5NjAgMTAw
NjQ0DQo+Pj4gLS0tIGEvaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QuaA0KPj4+ICsrKyBiL2luY2x1
ZGUvaHcvdmlydGlvL3Zob3N0LmgNCj4+PiBAQCAtMTIzLDYgKzEyMyw3IEBAIHN0cnVjdCB2aG9z
dF9kZXYgew0KPj4+ICAgIC8qIEBzdGFydGVkOiBpcyB0aGUgdmhvc3QgZGV2aWNlIHN0YXJ0ZWQ/
ICovDQo+Pj4gICAgYm9vbCBzdGFydGVkOw0KPj4+ICAgIGJvb2wgbG9nX2VuYWJsZWQ7DQo+Pj4g
KyAgICBib29sIGluaXRlZDsNCj4+PiAgICB1aW50NjRfdCBsb2dfc2l6ZTsNCj4+PiAgICBFcnJv
ciAqbWlncmF0aW9uX2Jsb2NrZXI7DQo+Pj4gICAgY29uc3QgVmhvc3RPcHMgKnZob3N0X29wczsN
Cj4+PiANCj4+PiBUaGFua3MuDQo+Pj4gDQo+Pj4+IA0KPj4+Pj4gT24gQXVnIDQsIDIwMjMsIGF0
IDE6MjkgQU0sIExpIEZlbmcgPGZlbmdsaUBzbWFydHguY29tPiB3cm90ZToNCj4+Pj4+IA0KPj4+
Pj4gV2hlbiB0aGUgdmhvc3QtdXNlciBpcyByZWNvbm5lY3RpbmcgdG8gdGhlIGJhY2tlbmQsIGFu
ZCBpZiB0aGUgdmhvc3QtdXNlciBmYWlscw0KPj4+Pj4gYXQgdGhlIGdldF9mZWF0dXJlcyBpbiB2
aG9zdF9kZXZfaW5pdCgpLCB0aGVuIHRoZSByZWNvbm5lY3Qgd2lsbCBmYWlsDQo+Pj4+PiBhbmQg
aXQgd2lsbCBub3QgYmUgcmV0cmlnZ2VyZWQgZm9yZXZlci4NCj4+Pj4+IA0KPj4+Pj4gVGhlIHJl
YXNvbiBpczoNCj4+Pj4+IFdoZW4gdGhlIHZob3N0LXVzZXIgZmFpbCBhdCBnZXRfZmVhdHVyZXMs
IHRoZSB2aG9zdF9kZXZfY2xlYW51cCB3aWxsIGJlIGNhbGxlZA0KPj4+Pj4gaW1tZWRpYXRlbHku
DQo+Pj4+PiANCj4+Pj4+IHZob3N0X2Rldl9jbGVhbnVwIGNhbGxzICdtZW1zZXQoaGRldiwgMCwg
c2l6ZW9mKHN0cnVjdCB2aG9zdF9kZXYpKScuDQo+Pj4+PiANCj4+Pj4+IFRoZSByZWNvbm5lY3Qg
cGF0aCBpczoNCj4+Pj4+IHZob3N0X3VzZXJfYmxrX2V2ZW50DQo+Pj4+PiB2aG9zdF91c2VyX2Fz
eW5jX2Nsb3NlKC4uIHZob3N0X3VzZXJfYmxrX2Rpc2Nvbm5lY3QgLi4pDQo+Pj4+PiAgcWVtdV9j
aHJfZmVfc2V0X2hhbmRsZXJzIDwtLS0tLSBjbGVhciB0aGUgbm90aWZpZXIgY2FsbGJhY2sNCj4+
Pj4+ICAgIHNjaGVkdWxlIHZob3N0X3VzZXJfYXN5bmNfY2xvc2VfYmgNCj4+Pj4+IA0KPj4+Pj4g
VGhlIHZob3N0LT52ZGV2IGlzIG51bGwsIHNvIHRoZSB2aG9zdF91c2VyX2Jsa19kaXNjb25uZWN0
IHdpbGwgbm90IGJlDQo+Pj4+PiBjYWxsZWQsIHRoZW4gdGhlIGV2ZW50IGZkIGNhbGxiYWNrIHdp
bGwgbm90IGJlIHJlaW5zdGFsbGVkLg0KPj4+Pj4gDQo+Pj4+PiBXaXRoIHRoaXMgcGF0Y2gsIHRo
ZSB2aG9zdF91c2VyX2Jsa19kaXNjb25uZWN0IHdpbGwgY2FsbCB0aGUNCj4+Pj4+IHZob3N0X2Rl
dl9jbGVhbnVwKCkgYWdhaW4sIGl0J3Mgc2FmZS4NCj4+Pj4+IA0KPj4+Pj4gQWxsIHZob3N0LXVz
ZXIgZGV2aWNlcyBoYXZlIHRoaXMgaXNzdWUsIGluY2x1ZGluZyB2aG9zdC11c2VyLWJsay9zY3Np
Lg0KPj4+Pj4gDQo+Pj4+PiBGaXhlczogNzFlMDc2YTA3ZCAoImh3L3ZpcnRpbzogZ2VuZXJhbGlz
ZSBDSFJfRVZFTlRfQ0xPU0VEIGhhbmRsaW5nIikNCj4+Pj4+IA0KPj4+Pj4gU2lnbmVkLW9mZi1i
eTogTGkgRmVuZyA8ZmVuZ2xpQHNtYXJ0eC5jb20+DQo+Pj4+PiAtLS0NCj4+Pj4+IGh3L3ZpcnRp
by92aG9zdC11c2VyLmMgfCAxMCArLS0tLS0tLS0tDQo+Pj4+PiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDkgZGVsZXRpb25zKC0pDQo+Pj4+PiANCj4+Pj4+IGRpZmYgLS1naXQgYS9o
dy92aXJ0aW8vdmhvc3QtdXNlci5jIGIvaHcvdmlydGlvL3Zob3N0LXVzZXIuYw0KPj4+Pj4gaW5k
ZXggOGRjZjA0OWQ0Mi4uNjk3YjQwM2ZlMiAxMDA2NDQNCj4+Pj4+IC0tLSBhL2h3L3ZpcnRpby92
aG9zdC11c2VyLmMNCj4+Pj4+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC11c2VyLmMNCj4+Pj4+IEBA
IC0yNjQ4LDE2ICsyNjQ4LDggQEAgdHlwZWRlZiBzdHJ1Y3Qgew0KPj4+Pj4gc3RhdGljIHZvaWQg
dmhvc3RfdXNlcl9hc3luY19jbG9zZV9iaCh2b2lkICpvcGFxdWUpDQo+Pj4+PiB7DQo+Pj4+PiAg
Vmhvc3RBc3luY0NhbGxiYWNrICpkYXRhID0gb3BhcXVlOw0KPj4+Pj4gLSAgICBzdHJ1Y3Qgdmhv
c3RfZGV2ICp2aG9zdCA9IGRhdGEtPnZob3N0Ow0KPj4+Pj4gDQo+Pj4+PiAtICAgIC8qDQo+Pj4+
PiAtICAgICAqIElmIHRoZSB2aG9zdF9kZXYgaGFzIGJlZW4gY2xlYXJlZCBpbiB0aGUgbWVhbnRp
bWUgdGhlcmUgaXMNCj4+Pj4+IC0gICAgICogbm90aGluZyBsZWZ0IHRvIGRvIGFzIHNvbWUgb3Ro
ZXIgcGF0aCBoYXMgY29tcGxldGVkIHRoZQ0KPj4+Pj4gLSAgICAgKiBjbGVhbnVwLg0KPj4+Pj4g
LSAgICAgKi8NCj4+Pj4+IC0gICAgaWYgKHZob3N0LT52ZGV2KSB7DQo+Pj4+PiAtICAgICAgICBk
YXRhLT5jYihkYXRhLT5kZXYpOw0KPj4+Pj4gLSAgICB9DQo+Pj4+PiArICAgIGRhdGEtPmNiKGRh
dGEtPmRldik7DQo+Pj4+PiANCj4+Pj4+ICBnX2ZyZWUoZGF0YSk7DQo+Pj4+PiB9DQo+Pj4+PiAt
LSANCj4+Pj4+IDIuNDEuMA0KDQo=

