Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D100C7C7F6E
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:05:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD5p-0000gL-U5; Fri, 13 Oct 2023 04:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qrD5P-0007uA-2N
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:56 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com ([216.71.158.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qrD5K-0007N3-CJ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697183990; x=1728719990;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=QRz9Ler2lW4gFe01fYaOsSagUefhMg16ZMdlgiQrBVY=;
 b=lprvBxQxoww/hf4JVukEirEFx4/tfhCLepnfD1xEVBiBrPVkLjcmIyBA
 EM30FuN/6gb3r+O4FXlM8ZXH8XCuTOUDulEc/xwMPuEbPNGEQgdoVDQ4Z
 H3/1Ok4gC0ypHvI5/1fRgszwh58Y5Wf3m7t2y0N49sc4pDITXk9uH54Cs
 +YakqxjQHT0iuzbquAycWmP9kYUFoUuHiQLJ3PW0zTUHWn/ElLJCurt/W
 5vseh7NOf4U4/0MOANSWaADADFmNozmXoi4LhBdwUNPAXoviaKWjdlLxq
 BjdhC7+qBJVWReLk0feZS9nZdE5bohg+TZyw4S5gu3SLdk1ryKW796PwR A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="98620409"
X-IronPort-AV: E=Sophos;i="6.03,221,1694703600"; d="scan'208";a="98620409"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2023 16:59:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nkjnt4SblzQ74UQs71bqS1uFK26cyCnF4dSfvm1LbwrVhTkUa4WkZqNe92SQ8mI2atAc/YmXRFc7DnH0jgJ8AOgUx6vQsvTKXaGRgwnXkcQUxddTKA7F0z1nJxwdspIcjSUv7pK+DQaaWMZR9YkDj/jLe9wtvQOp09QpT7Sqs25CTWS+5NO6/olf96wVUTtFScG7AfP6vhim/TniZ6quu4kXF45CRZ6lPkjkfDfDIL9f11dU5Opwyw4SgUKcKDx5crA9RONY323gOFDVXE346C4G+CbUxuFRsmlg8tzktxVQ6MV3iLpplYj68NK1BDunx4ZsrRvVmjMirNqriflnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRz9Ler2lW4gFe01fYaOsSagUefhMg16ZMdlgiQrBVY=;
 b=X2TZNSSJ75qe15ARwrWVO1vNyWKyb424i3G6I9yxIl2vJ76X9f7BSP5wUvqI0ejjQDLbXjAewYop2ALtMdp8FZ3qLzQO7svoh/JGD7BApHGirLBP5AdLYU7eXOT6wdeQSq+gLhbhr7YMw7tmsdSObfr3UlD1W5tBhBcSXkUeatSUTUSD8YZSA1b7qOSZakNijgNQB89P5yOmDUB8tbXtrUUW8fP/zMBCZSNlDNnaKy+Ehk3VseZgffXPEklrQdw3CEyKHLOL44j2QKSKdbrLsbub8SDiE1oyFXvI453og3EUGdv4MgJRGxC+KrFara1fK3UnyNMlQSYCsSPOk55apg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYTPR01MB11035.jpnprd01.prod.outlook.com (2603:1096:400:3a1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 07:59:42 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 07:59:40 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>, Leonardo
 Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 03/13] migration/rdma: Unfold
 ram_control_after_iterate()
Thread-Topic: [PATCH v3 03/13] migration/rdma: Unfold
 ram_control_after_iterate()
Thread-Index: AQHZ/IKCRgjTf/+iGkO0KTti9uEjpLBHXWgA
Date: Fri, 13 Oct 2023 07:59:40 +0000
Message-ID: <e33b2402-f14e-b413-d01f-bc0e3b4b7936@fujitsu.com>
References: <20231011203527.9061-1-quintela@redhat.com>
 <20231011203527.9061-4-quintela@redhat.com>
In-Reply-To: <20231011203527.9061-4-quintela@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYTPR01MB11035:EE_
x-ms-office365-filtering-correlation-id: d72a19cb-e85e-4cf9-1790-08dbcbc25a88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XAvhbkCC1WM0KRTsc3chCdtEfS4sMvbTKjqpA6ncAvo4rhr7G1zvVk54Dws8ZTcnPWxc7I309KCpatJS0kYPRRN9+7qp5+thxr5ff2UUApMtZbQavo3t/BrZ285JcMqcuK83V8Tqn/dRR8L2qPPE8fOFZ13QFqFQyPCGEB//FzdS+GSDdeV3lTiV7JUirD6ZK8FfArcS26UGUASvKTVdz3rBvtw0hT7jmRLyvZHeYaN639mf/ks2HmczHuy7rrU5foXVLApWkIVv3RQJVuT7om8uIwzdOoELxphF0VDDhU+B2jnIMYnuYC/S2lO4es6DvY4xnG2HiXJfQLtyeSyKafJe3SB85lv2aHQTK2l3NIcTsKNkMUteN9aXpVRJfac1btQbDIdvq3h5j8KBq5aH4uQV7o4O0BTZCTxwwUIaOhpiGHCsbrzm46817F33sTla8DUV8fC6+iFz2/66n+VwsBP4U5mhDt2I4sGcM2S/Dr3HOCHPJ0whO3R57eQi2iHjMsKNw/IH7nijMYYLN45pvYuwOtziOVHmckMA0OjRvrMIwBG0eaiF44UVBHgWdtKcfwmHWTdjiU4VZ41oJLTxvum2t2uT1C6IUejA1aY+N0HBYdVrHjZv7DLzj122ZYE1y+ONPtahY5lkgZiQ2HKW3i2VLNbBl0DIe9FBAriJiny/JgfOQciOPZPPR+SpH/yF3I3HfBgBwRFnZ2KhBuPgDw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS0PR01MB5442.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(346002)(366004)(396003)(230922051799003)(64100799003)(1590799021)(451199024)(1800799009)(186009)(6486002)(41300700001)(110136005)(316002)(91956017)(66946007)(54906003)(66446008)(64756008)(66476007)(66556008)(76116006)(8936002)(478600001)(4326008)(8676002)(6512007)(31686004)(1580799018)(53546011)(6506007)(5660300002)(38100700002)(122000001)(86362001)(38070700005)(31696002)(82960400001)(2906002)(2616005)(26005)(85182001)(83380400001)(36756003)(71200400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTVPMjZ5a3I3U1JZbk03WStyMGs1R1kxSlB0a1hnRVduTnQ0RVNBTExCRTFj?=
 =?utf-8?B?MStkUWZPS1k3RktOaVBaclhyOHJTeWRHSnVWUlRhSTIxSllNbkZKYVNoTHVH?=
 =?utf-8?B?cEhQR2Y1dWYxaDhTK3d1QTRJVFZyVjJ5YjNZMXBuZ2NiWmRsN2w1RDRFbjNU?=
 =?utf-8?B?ZjQ1cWg1U3JZTzFhUFU3Z3MxaEEvaEJNUEZoS2R5T0hlR0JFOXgvcWFXdlBm?=
 =?utf-8?B?dERGNWRrdnluNUNRU2x4NVpqK1VTZURuaW9WWitMN1JpQ3VnYURTMDB6VnU1?=
 =?utf-8?B?Sk9NeURGa3drQzNsd2xiMTFDZno1elBLZXhxbTljcjVKM3hGYVVvTVgyQVkx?=
 =?utf-8?B?UmdYUkFpMnpnSDVWb0JwbkRrcG8xRU5IVXdwR3hyZk42cFNvSXZkM3NGY2hB?=
 =?utf-8?B?bC9aREpaWURJZWFaaUpJYXEyTzJvdDZZZGtjTTdzb1FKM0paZDRHK3Y1azBK?=
 =?utf-8?B?czFUMFROMFR3aXc4UmlQWVdSTXlXVnlta1BGZXdNNFNEUW5UVVNQNGNBYjln?=
 =?utf-8?B?ZFJBSzVDS3RjYk8xUHhVN0YzT2FWMHovTWQrQkV2Qjl1L2hwZlErTHlJSE5P?=
 =?utf-8?B?OHE3NGloMWd0Zk5wVllIUmk5R2hZRnFVT1NFeVp0VlA5N29hVk91RzROam9a?=
 =?utf-8?B?UjIwZWV1TGpGTWh0WkorYjg0VE91WDJPR29BQk5kcHIrWjl3Ulh6Yy84WUFV?=
 =?utf-8?B?V1VxblVySmkrUTlEalRpNHFqaHkvVjBybFNvbTFoTWNZTzlWd2RZR014VHo5?=
 =?utf-8?B?empZaVZVZVdIdHAxOE81ZVBHSWg1YlZQRjJFQmZtVVRaUU5vVmhwa29mLzMv?=
 =?utf-8?B?VXR3SFdzdlpSZnBZZm5KdS8vTEdWeVRDdHRnaVU5c2phZHAySDlFNllEOHpn?=
 =?utf-8?B?WFc0U1RYRTMyUGRtaXVRbEx5emF1dUt6V0dLOEgxTG5KKzJrYXdySW01TEJs?=
 =?utf-8?B?RHFBR0V1YWhrTVhxT3VNb0YyazBOcDV6d2tKOFpHL2RzTGppQ2N6d1RaR1Bh?=
 =?utf-8?B?elpsejh6UGRUaytWSmVacjB6RnhIL0JxTVlCK0g2ZFd2RFMrWEFnRlhlZ1Vl?=
 =?utf-8?B?Y3E5ay9TcEpXT0x1d3p1cjZFYTlOd2dFU1hnVHpIZjRZYUE0eFllb3dEU1Bp?=
 =?utf-8?B?aDBsY1hWUHJ4bTZQNEpGVTBzYVNEdDZYMlhONnhzTlpLRDEwR2ZLWUNWSStY?=
 =?utf-8?B?QkttSkcxRjkrNWNtYWJ6Vk5iaWZwSU03bktjMFphL0V1Q0cxZTVNdlpoV0ly?=
 =?utf-8?B?eFF6VkFYMUJHa1dXZVQzdCtlbXltd1Zpck41ME9HMFRIN240dXgxeStkNjdz?=
 =?utf-8?B?eWNIYk1oOVRvYm10SWNMc2doRFA0aTl5R1VYRml4WTE3TVVuUTNjS1lTeWsr?=
 =?utf-8?B?THQ0OWhJT1NCT25EUGJHeVluMzNpU1JmN1UwcWtmaWR4MTJ3anBYeWVQRHFE?=
 =?utf-8?B?ZXFNV1pyMnlnQ21EdVcvQ0dwWDNnNnE3TnAvR1lPRmQvVUt1aUZTSGZaam1U?=
 =?utf-8?B?cHJ0T0tBYnRxNVRNYnBjUUZhNURGMkJSeTl6VWxNbUFSUXVlUEFHaklMeldw?=
 =?utf-8?B?a25LRUg1VkoxQ0k1SWwzcVFQVFpLUmxOdDJQUlZpQ216bXlXMmtlcjBoVUk4?=
 =?utf-8?B?N2h6VDZ2WjRmcFFJc1pJdCtSM2wzRlB3MHNRNnlHMGpvRm1EQmdoY0xDang3?=
 =?utf-8?B?VjZoQ3JVMnRmVWZONGJpaXM3a1Q5TG1TTDdMUG05Yzk0SWhZTUNmNWF5ZFpX?=
 =?utf-8?B?ZCtab0EzdGJpemhEMnhFZWZ5TzZWNWdlUkRQZkhUZVRoV3VPNEVuTEtYZEVZ?=
 =?utf-8?B?Ri9heVNBNlJ0Ukd0VVEyTHVRV0hnTW1GY3Rhc1FNcnVBRnZDVDVaclZxVEZx?=
 =?utf-8?B?Y21vRHV3K0tSRnhGcEU2SDVPdDlGbk1POWYxYWsySFB5Lzkwbm5Od096MnYr?=
 =?utf-8?B?VEIrTnNtbWRHV1JkSXpyYnMzTG1hazFJVFhFSUxZVVk4NWl1dXdyWU5ja3ZS?=
 =?utf-8?B?SzdKb3Z0RUhwRTZSN0dGaW5TTVR2K2k4amxRaG10S3RJSFk5Z2U1UFA5K29j?=
 =?utf-8?B?dWpYT3lHOHpJK2ZhayswMWduQ3E5eEpSc1RuUC9uWTFMUGlrOVNkd1NpNkRC?=
 =?utf-8?B?N3VQNHpUT25GTEZ6V2h4YjZ1UTdwcVdLOUFCZG41SklVL2VjaXdJTFBuVEtV?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A78C5E460ECF9243B7B97AB645A7260A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8kc+RYWy+aWSYYo3TVlQM8i3jsFgqg75OOwSOeudAwMgHosUs/j7K8o4BB+D1pbhyDGIAtEVFyriEUHnz6PqbPq1Jf58NV2AENXMdu5ywb7CD0N3PBIwQdqmFsAPa083OrGg+4DcYlmNOObTyw3wd9OOSQ9XFkZbDKydVIleyc7O4wpSeqKqgV+gsJTn7jU1EmEIL0RWbx+oSZ6qu79JHsjTHBIJFm1ovpqHiNrnXwjIiAtH/463/4qpWzAT0b8udArbr7fxRw+q7jMq1RXeMCSu5S3Gw3qOEImQSzvgwVGBqDJyLJdteb0AXMTvwPEgfUDmogUwrCSG3L42sbZVKuqy/Zaem7woRDKJKNEREb6wqk1vMBn08/s1Q2hzsv7C5sUGnxoIa/Xa87ffdYqcIX0Jz4atSubqgnKcKk7Hb3MXFyezkYvVec4l55p0Gk4/92+aSVvl3IqW8H9pNDW5CcPtjqYcAeOKmKjxIJ9e3gRw3q3ZpfVD6gjzm2S6i6hGWy8D3NeFIRVgJJbDUiGXNiYB8y3pyi5ATXzezLSY+WHGReFRzwHcBIA5o8+GvYsu1WCjhWjxZBmyXG977F65h7u9Zl1JYX7xkvqh8k2mEPGM6n038QJAhEwnPy9+iD01nKz1hW/YOQWcBiD5VQ0Gu0pvdxx11Rq543ht5ACunQaszeg9AwPpOnWNHgtxN9VbhduGH6Df6BEWvfticlDxcJSdhb5BHL0z1EjM6r4zA3BP97kHUlTlt2rsaJW5gpfMWKqgVf+BiM7WigvtGGHA51uTCvNB4ilb74feKS2guDn1UCIWfyhssskHVPxC6m1M
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72a19cb-e85e-4cf9-1790-08dbcbc25a88
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 07:59:40.5441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tkz9XvsxOxQGE6MBxlAzp4P9D34jYf2+PWBLT4l8aR2kyJzJf17hbKYBCE5+EbwwADTwWEoWJ8GhETbn94Ezbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB11035
Received-SPF: pass client-ip=216.71.158.62; envelope-from=lizhijian@fujitsu.com;
 helo=esa19.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDEyLzEwLzIwMjMgMDQ6MzUsIEp1YW4gUXVpbnRlbGEgd3JvdGU6DQo+IE9uY2UgdGhl
cmU6DQo+IC0gUmVtb3ZlIHVudXNlZCBkYXRhIHBhcmFtZXRlcg0KPiAtIHVuZm9sZCBpdCBpbiBp
dHMgY2FsbGVycw0KPiAtIGNoYW5nZSBhbGwgY2FsbGVycyB0byBjYWxsIHFlbXVfcmRtYV9yZWdp
c3RyYXRpb25fc3RvcCgpDQo+IC0gV2UgbmVlZCB0byBjYWxsIFFJT19DSEFOTkVMX1JETUEoKSBh
ZnRlciB3ZSBjaGVjayBmb3IgbWlncmF0ZV9yZG1hKCkNCj4gDQo+IFJldmlld2VkLWJ5OiBQZXRl
ciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEp1YW4gUXVpbnRlbGEg
PHF1aW50ZWxhQHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWpp
YW5AZnVqaXRzdS5jb20+DQoNCj4gDQo+IC0tLQ0KPiANCj4gVGhpcyBmdW5jdGlvbiBoYXMgZ290
bydzLiAgU28gSSBkb24ndCBjaGFuZ2UgdGhlIHBsYWNlIHdoZXJlIHdlDQo+IGRlY2xhcmUgdmFy
aWFibGVzLCBhbHRob3VnaHQgSSB0aGluayB0aGF0IGl0IGlzIGNvcnJlY3QsIGp1c3QgZG9uJ3QN
Cj4gc3RhcnQgdGhhdCBkaXNjdXNzaW9uLg0KPiAtLS0NCj4gICBtaWdyYXRpb24vcWVtdS1maWxl
LmggfCAgMiAtLQ0KPiAgIG1pZ3JhdGlvbi9yZG1hLmggICAgICB8ICAzICsrKw0KPiAgIG1pZ3Jh
dGlvbi9xZW11LWZpbGUuYyB8IDEyIC0tLS0tLS0tLS0tLQ0KPiAgIG1pZ3JhdGlvbi9yYW0uYyAg
ICAgICB8IDE3ICsrKysrKysrKysrKysrLS0tDQo+ICAgbWlncmF0aW9uL3JkbWEuYyAgICAgIHwg
IDkgKysrKy0tLS0tDQo+ICAgNSBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAyMiBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9taWdyYXRpb24vcWVtdS1maWxlLmggYi9t
aWdyYXRpb24vcWVtdS1maWxlLmgNCj4gaW5kZXggZDZhMzcwYzU2OS4uMzVlNjcxYTAxZSAxMDA2
NDQNCj4gLS0tIGEvbWlncmF0aW9uL3FlbXUtZmlsZS5oDQo+ICsrKyBiL21pZ3JhdGlvbi9xZW11
LWZpbGUuaA0KPiBAQCAtNTUsNyArNTUsNiBAQCB0eXBlZGVmIGludCAoUUVNVVJhbVNhdmVGdW5j
KShRRU1VRmlsZSAqZiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplX3Qg
c2l6ZSk7DQo+ICAgDQo+ICAgdHlwZWRlZiBzdHJ1Y3QgUUVNVUZpbGVIb29rcyB7DQo+IC0gICAg
UUVNVVJhbUhvb2tGdW5jICphZnRlcl9yYW1faXRlcmF0ZTsNCj4gICAgICAgUUVNVVJhbUhvb2tG
dW5jICpob29rX3JhbV9sb2FkOw0KPiAgICAgICBRRU1VUmFtU2F2ZUZ1bmMgKnNhdmVfcGFnZTsN
Cj4gICB9IFFFTVVGaWxlSG9va3M7DQo+IEBAIC0xMjYsNyArMTI1LDYgQEAgdm9pZCBxZW11X2Zm
bHVzaChRRU1VRmlsZSAqZik7DQo+ICAgdm9pZCBxZW11X2ZpbGVfc2V0X2Jsb2NraW5nKFFFTVVG
aWxlICpmLCBib29sIGJsb2NrKTsNCj4gICBpbnQgcWVtdV9maWxlX2dldF90b19mZChRRU1VRmls
ZSAqZiwgaW50IGZkLCBzaXplX3Qgc2l6ZSk7DQo+ICAgDQo+IC12b2lkIHJhbV9jb250cm9sX2Fm
dGVyX2l0ZXJhdGUoUUVNVUZpbGUgKmYsIHVpbnQ2NF90IGZsYWdzKTsNCj4gICB2b2lkIHJhbV9j
b250cm9sX2xvYWRfaG9vayhRRU1VRmlsZSAqZiwgdWludDY0X3QgZmxhZ3MsIHZvaWQgKmRhdGEp
Ow0KPiAgIA0KPiAgIC8qIFdoZW5ldmVyIHRoaXMgaXMgZm91bmQgaW4gdGhlIGRhdGEgc3RyZWFt
LCB0aGUgZmxhZ3MNCj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9yZG1hLmggYi9taWdyYXRpb24v
cmRtYS5oDQo+IGluZGV4IDY3MGM2N2E4Y2IuLmMxM2I5NGM3ODIgMTAwNjQ0DQo+IC0tLSBhL21p
Z3JhdGlvbi9yZG1hLmgNCj4gKysrIGIvbWlncmF0aW9uL3JkbWEuaA0KPiBAQCAtMjUsOCArMjUs
MTEgQEAgdm9pZCByZG1hX3N0YXJ0X2luY29taW5nX21pZ3JhdGlvbihjb25zdCBjaGFyICpob3N0
X3BvcnQsIEVycm9yICoqZXJycCk7DQo+ICAgDQo+ICAgI2lmZGVmIENPTkZJR19SRE1BDQo+ICAg
aW50IHFlbXVfcmRtYV9yZWdpc3RyYXRpb25fc3RhcnQoUUVNVUZpbGUgKmYsIHVpbnQ2NF90IGZs
YWdzKTsNCj4gK2ludCBxZW11X3JkbWFfcmVnaXN0cmF0aW9uX3N0b3AoUUVNVUZpbGUgKmYsIHVp
bnQ2NF90IGZsYWdzKTsNCj4gICAjZWxzZQ0KPiAgIHN0YXRpYyBpbmxpbmUNCj4gICBpbnQgcWVt
dV9yZG1hX3JlZ2lzdHJhdGlvbl9zdGFydChRRU1VRmlsZSAqZiwgdWludDY0X3QgZmxhZ3MpIHsg
cmV0dXJuIDA7IH0NCj4gK3N0YXRpYyBpbmxpbmUNCj4gK2ludCBxZW11X3JkbWFfcmVnaXN0cmF0
aW9uX3N0b3AoUUVNVUZpbGUgKmYsIHVpbnQ2NF90IGZsYWdzKSB7IHJldHVybiAwOyB9DQo+ICAg
I2VuZGlmDQo+ICAgI2VuZGlmDQo+IGRpZmYgLS1naXQgYS9taWdyYXRpb24vcWVtdS1maWxlLmMg
Yi9taWdyYXRpb24vcWVtdS1maWxlLmMNCj4gaW5kZXggNWUyZDczZmQ2OC4uZTdkYmEyYTg0OSAx
MDA2NDQNCj4gLS0tIGEvbWlncmF0aW9uL3FlbXUtZmlsZS5jDQo+ICsrKyBiL21pZ3JhdGlvbi9x
ZW11LWZpbGUuYw0KPiBAQCAtMjk4LDE4ICsyOTgsNiBAQCB2b2lkIHFlbXVfZmZsdXNoKFFFTVVG
aWxlICpmKQ0KPiAgICAgICBmLT5pb3ZjbnQgPSAwOw0KPiAgIH0NCj4gICANCj4gLXZvaWQgcmFt
X2NvbnRyb2xfYWZ0ZXJfaXRlcmF0ZShRRU1VRmlsZSAqZiwgdWludDY0X3QgZmxhZ3MpDQo+IC17
DQo+IC0gICAgaW50IHJldCA9IDA7DQo+IC0NCj4gLSAgICBpZiAoZi0+aG9va3MgJiYgZi0+aG9v
a3MtPmFmdGVyX3JhbV9pdGVyYXRlKSB7DQo+IC0gICAgICAgIHJldCA9IGYtPmhvb2tzLT5hZnRl
cl9yYW1faXRlcmF0ZShmLCBmbGFncywgTlVMTCk7DQo+IC0gICAgICAgIGlmIChyZXQgPCAwKSB7
DQo+IC0gICAgICAgICAgICBxZW11X2ZpbGVfc2V0X2Vycm9yKGYsIHJldCk7DQo+IC0gICAgICAg
IH0NCj4gLSAgICB9DQo+IC19DQo+IC0NCj4gICB2b2lkIHJhbV9jb250cm9sX2xvYWRfaG9vayhR
RU1VRmlsZSAqZiwgdWludDY0X3QgZmxhZ3MsIHZvaWQgKmRhdGEpDQo+ICAgew0KPiAgICAgICBp
ZiAoZi0+aG9va3MgJiYgZi0+aG9va3MtPmhvb2tfcmFtX2xvYWQpIHsNCj4gZGlmZiAtLWdpdCBh
L21pZ3JhdGlvbi9yYW0uYyBiL21pZ3JhdGlvbi9yYW0uYw0KPiBpbmRleCBhYjU5MGE5ODNmLi4x
NWJkNGFkNjk3IDEwMDY0NA0KPiAtLS0gYS9taWdyYXRpb24vcmFtLmMNCj4gKysrIGIvbWlncmF0
aW9uL3JhbS5jDQo+IEBAIC0zMDY3LDcgKzMwNjcsMTEgQEAgc3RhdGljIGludCByYW1fc2F2ZV9z
ZXR1cChRRU1VRmlsZSAqZiwgdm9pZCAqb3BhcXVlKQ0KPiAgICAgICBpZiAocmV0IDwgMCkgew0K
PiAgICAgICAgICAgcWVtdV9maWxlX3NldF9lcnJvcihmLCByZXQpOw0KPiAgICAgICB9DQo+IC0g
ICAgcmFtX2NvbnRyb2xfYWZ0ZXJfaXRlcmF0ZShmLCBSQU1fQ09OVFJPTF9TRVRVUCk7DQo+ICsN
Cj4gKyAgICByZXQgPSBxZW11X3JkbWFfcmVnaXN0cmF0aW9uX3N0b3AoZiwgUkFNX0NPTlRST0xf
U0VUVVApOw0KPiArICAgIGlmIChyZXQgPCAwKSB7DQo+ICsgICAgICAgIHFlbXVfZmlsZV9zZXRf
ZXJyb3IoZiwgcmV0KTsNCj4gKyAgICB9DQo+ICAgDQo+ICAgICAgIG1pZ3JhdGlvbl9vcHMgPSBn
X21hbGxvYzAoc2l6ZW9mKE1pZ3JhdGlvbk9wcykpOw0KPiAgICAgICBtaWdyYXRpb25fb3BzLT5y
YW1fc2F2ZV90YXJnZXRfcGFnZSA9IHJhbV9zYXZlX3RhcmdldF9wYWdlX2xlZ2FjeTsNCj4gQEAg
LTMxODYsNyArMzE5MCwxMCBAQCBzdGF0aWMgaW50IHJhbV9zYXZlX2l0ZXJhdGUoUUVNVUZpbGUg
KmYsIHZvaWQgKm9wYXF1ZSkNCj4gICAgICAgICogTXVzdCBvY2N1ciBiZWZvcmUgRU9TIChvciBh
bnkgUUVNVUZpbGUgb3BlcmF0aW9uKQ0KPiAgICAgICAgKiBiZWNhdXNlIG9mIFJETUEgcHJvdG9j
b2wuDQo+ICAgICAgICAqLw0KPiAtICAgIHJhbV9jb250cm9sX2FmdGVyX2l0ZXJhdGUoZiwgUkFN
X0NPTlRST0xfUk9VTkQpOw0KPiArICAgIHJldCA9IHFlbXVfcmRtYV9yZWdpc3RyYXRpb25fc3Rv
cChmLCBSQU1fQ09OVFJPTF9ST1VORCk7DQo+ICsgICAgaWYgKHJldCA8IDApIHsNCj4gKyAgICAg
ICAgcWVtdV9maWxlX3NldF9lcnJvcihmLCByZXQpOw0KPiArICAgIH0NCj4gICANCj4gICBvdXQ6
DQo+ICAgICAgIGlmIChyZXQgPj0gMA0KPiBAQCAtMzI1OSw3ICszMjY2LDExIEBAIHN0YXRpYyBp
bnQgcmFtX3NhdmVfY29tcGxldGUoUUVNVUZpbGUgKmYsIHZvaWQgKm9wYXF1ZSkNCj4gICAgICAg
ICAgIHFlbXVfbXV0ZXhfdW5sb2NrKCZycy0+Yml0bWFwX211dGV4KTsNCj4gICANCj4gICAgICAg
ICAgIHJhbV9mbHVzaF9jb21wcmVzc2VkX2RhdGEocnMpOw0KPiAtICAgICAgICByYW1fY29udHJv
bF9hZnRlcl9pdGVyYXRlKGYsIFJBTV9DT05UUk9MX0ZJTklTSCk7DQo+ICsNCj4gKyAgICAgICAg
aW50IHJldCA9IHFlbXVfcmRtYV9yZWdpc3RyYXRpb25fc3RvcChmLCBSQU1fQ09OVFJPTF9GSU5J
U0gpOw0KPiArICAgICAgICBpZiAocmV0IDwgMCkgew0KPiArICAgICAgICAgICAgcWVtdV9maWxl
X3NldF9lcnJvcihmLCByZXQpOw0KPiArICAgICAgICB9DQo+ICAgICAgIH0NCj4gICANCj4gICAg
ICAgaWYgKHJldCA8IDApIHsNCj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9yZG1hLmMgYi9taWdy
YXRpb24vcmRtYS5jDQo+IGluZGV4IGE4YmZjMDUyYzQuLjk5YzA5MTRhMjMgMTAwNjQ0DQo+IC0t
LSBhL21pZ3JhdGlvbi9yZG1hLmMNCj4gKysrIGIvbWlncmF0aW9uL3JkbWEuYw0KPiBAQCAtMzg3
OCwyMCArMzg3OCwyMCBAQCBpbnQgcWVtdV9yZG1hX3JlZ2lzdHJhdGlvbl9zdGFydChRRU1VRmls
ZSAqZiwgdWludDY0X3QgZmxhZ3MpDQo+ICAgICogSW5mb3JtIGRlc3QgdGhhdCBkeW5hbWljIHJl
Z2lzdHJhdGlvbnMgYXJlIGRvbmUgZm9yIG5vdy4NCj4gICAgKiBGaXJzdCwgZmx1c2ggd3JpdGVz
LCBpZiBhbnkuDQo+ICAgICovDQo+IC1zdGF0aWMgaW50IHFlbXVfcmRtYV9yZWdpc3RyYXRpb25f
c3RvcChRRU1VRmlsZSAqZiwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHVpbnQ2NF90IGZsYWdzLCB2b2lkICpkYXRhKQ0KPiAraW50IHFlbXVfcmRtYV9yZWdpc3Ry
YXRpb25fc3RvcChRRU1VRmlsZSAqZiwgdWludDY0X3QgZmxhZ3MpDQo+ICAgew0KPiAtICAgIFFJ
T0NoYW5uZWxSRE1BICpyaW9jID0gUUlPX0NIQU5ORUxfUkRNQShxZW11X2ZpbGVfZ2V0X2lvYyhm
KSk7DQo+ICsgICAgUUlPQ2hhbm5lbFJETUEgKnJpb2M7DQo+ICAgICAgIEVycm9yICplcnIgPSBO
VUxMOw0KPiAgICAgICBSRE1BQ29udGV4dCAqcmRtYTsNCj4gICAgICAgUkRNQUNvbnRyb2xIZWFk
ZXIgaGVhZCA9IHsgLmxlbiA9IDAsIC5yZXBlYXQgPSAxIH07DQo+ICAgICAgIGludCByZXQ7DQo+
ICAgDQo+IC0gICAgaWYgKG1pZ3JhdGlvbl9pbl9wb3N0Y29weSgpKSB7DQo+ICsgICAgaWYgKCFt
aWdyYXRlX3JkbWEoKSB8fCBtaWdyYXRpb25faW5fcG9zdGNvcHkoKSkgew0KPiAgICAgICAgICAg
cmV0dXJuIDA7DQo+ICAgICAgIH0NCj4gICANCj4gICAgICAgUkNVX1JFQURfTE9DS19HVUFSRCgp
Ow0KPiArICAgIHJpb2MgPSBRSU9fQ0hBTk5FTF9SRE1BKHFlbXVfZmlsZV9nZXRfaW9jKGYpKTsN
Cj4gICAgICAgcmRtYSA9IHFhdG9taWNfcmN1X3JlYWQoJnJpb2MtPnJkbWFvdXQpOw0KPiAgICAg
ICBpZiAoIXJkbWEpIHsNCj4gICAgICAgICAgIHJldHVybiAtMTsNCj4gQEAgLTM5OTksNyArMzk5
OSw2IEBAIHN0YXRpYyBjb25zdCBRRU1VRmlsZUhvb2tzIHJkbWFfcmVhZF9ob29rcyA9IHsNCj4g
ICB9Ow0KPiAgIA0KPiAgIHN0YXRpYyBjb25zdCBRRU1VRmlsZUhvb2tzIHJkbWFfd3JpdGVfaG9v
a3MgPSB7DQo+IC0gICAgLmFmdGVyX3JhbV9pdGVyYXRlICA9IHFlbXVfcmRtYV9yZWdpc3RyYXRp
b25fc3RvcCwNCj4gICAgICAgLnNhdmVfcGFnZSAgICAgICAgICA9IHFlbXVfcmRtYV9zYXZlX3Bh
Z2UsDQo+ICAgfTsNCj4gICA=

