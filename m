Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CBE77B857
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 14:12:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVWPv-0003Ph-Eh; Mon, 14 Aug 2023 08:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qVWPs-0003Nq-QG
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 08:11:25 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qVWPq-0006Ai-Ii
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 08:11:24 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37E5pQa9014945; Mon, 14 Aug 2023 05:11:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=BqeqjhvWv5f3ktY1UCjhzrPu3nemfovo8Rk6mZ
 QQanM=; b=KiOg8M7L7RI15wyzOdrxBp2Yl01UzkKoY9z/6lQqKf9KHwFSiZkSyy
 2ebJNSuIRUQxZ8igCrwJmCqaudYGpr0lWoVmihl65Lettg8m28pS9V4MhBPFPnaJ
 S6hVqDyz0rIsjIKDJQnxozg4Vb8arSlQuzltyh7Pe4aSsimQdvdjHI60m7ExfrWm
 YrVAsB+RzOK+zbiawNnGpqbaEaoLWyyZSFLnmxM26kzILeKT27j87WtWiqvPHlGg
 Yevo9X/MIrgQCteJjtE8uOjoUJQPa1GIO+PMbEe8+cSgnairrpCDtcbR8OhJ1Ib+
 TBzVqVwqS16mbQ4n7Z1Pi91cQ3FumPaQ==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3se9kvju8h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Aug 2023 05:11:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nS9xZQ6jjBgWNdOhQam11LnIC+IGnzQui1wFlalbRiOD41peWJ3ydKKY16Smk8j9GtxIKOG3FwJr8pT8HeN8JFYW8cJNTqJ2QJA/7TLP5yQgrgKyaMJhi8Bnk12pGvWKVXWdYEjh8cT2JdzI0m4Wr3cGw8ZUqKakEN7mX8nO5iD2nD0nDM7jElZqhMfs2u2cJtkVO3Md+DtPxh3WLrRlRgEOeH+JwoSP774ZpfxdoNPIuMn9GBXe0sKLgJdyV91wzai9RGlNeOcfosWe487WYFGV2RZL6obQkM5RyBzMGiE9nArrKKdA1S7OYH1h3tHHurrEcTKjUSvYIUtYAYn3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqeqjhvWv5f3ktY1UCjhzrPu3nemfovo8Rk6mZQQanM=;
 b=N6mm7I/iyqeDmZQjz9re1ocdCUBzZSglhBE2SsE1O7keE3CkHHNBTQtw5BExpxJMVgqUV6uvFS7jxyYelBv3xBdZqlUAOzZMKuX2dDICujptJEn3FZDlcu4N/Rh8h3MQ8R235M7lhlIJrHP3/zCZwMKH4Z/2m0Z/HZokU0xjpO7/VO3J5YXKRVr8oaynn8/nPxa2yDCyZMDIU4XOsXRjkgSf8rb+kgb90OAjG5EjHw+yLfxeKw6OGHiOdg/0XytEgtULFiPqvzJB/uktepyQq41ETxxweHlM7Ovc5yuVpc3KuntknRx2fSxPtWueIC7Xqht05QvBM1RChL0fm+IIoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqeqjhvWv5f3ktY1UCjhzrPu3nemfovo8Rk6mZQQanM=;
 b=asy4vXac2SesGFEd8dMZh+9EBSBZELKyv+nreDHD2BsoGkEk4/DlxNB6FE1QgWRPrXZ7HUYqdCXWHarplPZML0rgHAr/44HD5s+koZFCszgWmHKqML7KSBwBC/BUFguchAmzhXCtu1fveGqgwa83ndEhWcjZR4Xa/u2eCOw+68dyrh9tGVLulh1cOCuhr95OHqzBqlTCYFmzlpZDbz5XNpfpl6fFYb8MYznO2BTBpiwR4k75hHOXFpFk5itWTX19Wjf0Au750aJH1frfUj/80cXRDGnY/h7jMSQ8lxhYJcdStSbjZsoOs1s1pCGRMniqziB6vRn3oxwA6M6sjoH9Xg==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by DS0PR02MB9152.namprd02.prod.outlook.com (2603:10b6:8:13b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.13; Mon, 14 Aug
 2023 12:11:09 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::1da1:b8:e69e:79c8]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::1da1:b8:e69e:79c8%3]) with mapi id 15.20.6699.013; Mon, 14 Aug 2023
 12:11:09 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Li Feng <fengli@smartx.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/2] vhost-user: fix lost reconnect
Thread-Topic: [PATCH 1/2] vhost-user: fix lost reconnect
Thread-Index: AQHZxpTSe3WncXIlnk6ipNyEGIOYZ6/pwLIA
Date: Mon, 14 Aug 2023 12:11:08 +0000
Message-ID: <894CEF7E-9523-444F-8459-330BE4236B7A@nutanix.com>
References: <20230804052954.2918915-1-fengli@smartx.com>
 <20230804052954.2918915-2-fengli@smartx.com>
In-Reply-To: <20230804052954.2918915-2-fengli@smartx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|DS0PR02MB9152:EE_
x-ms-office365-filtering-correlation-id: f93d702a-cf66-4a4a-72c4-08db9cbf8b32
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hBfzIBfb82A8rNk3m3iLSCAzMb+XE1s0YIq1wmDsg1u/dGoIpS8DfYiSAs3t6EbShckeA6w7N3FZqKYdVCzH/Q8uWg2oMMlFo7R8Ui9uUzSjK8dckXC+/WUKpSZ2qGsUI/RHV3pwrvkg3dBt2iPJCplmdLBCrrZQOqjUIEItfQc6e30mC73kZ8HHCzVoxOzLOVgCKNNrd13VqkEkCNmR4ikjEvjyYlPAmnKJUR3JuFkzDu76J0GuCVxZ1DZn/PClX9wup59/b6k4NGWQETTt9GKa74Q8DyrZiiBmqEoBcHBIYoq1kJyWKzVl57utZBfjRQSM7QL+1VB8qZDlO7jKzdoK90i++EwYdIOeVk4oHSNsLsBwtH9QpSNkcpt/i8fF/uzuc1JJAeG9ULqxvfa+dif5bHpNlE6YTaSKfcIrMI1xN4gO8QMRpNcrszN5/An92O589B599v/ddiWaB+MayIVtPYQ0njF9s7JpHNZLZfTXSKi5ZPL+j/1arknsp1L+GtWCz4r4w2iYreiHRXQ0FRiII+ZeLWY2gs4wfepFix5cHczT9bJiPjHePv4G5onplEBnbSOCHSBgmSmaWTnWidurkMvu8mQREpGMQR0QxLKQQhkFPfOTfEQSgH22bV4nKXO5AGQOLCbo+PtZ3AROzA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(396003)(376002)(346002)(39860400002)(366004)(1800799006)(186006)(451199021)(71200400001)(478600001)(6486002)(91956017)(76116006)(6506007)(26005)(6512007)(53546011)(2616005)(66946007)(2906002)(8936002)(8676002)(64756008)(66556008)(66446008)(54906003)(66476007)(6916009)(316002)(4326008)(44832011)(41300700001)(5660300002)(38100700002)(38070700005)(122000001)(36756003)(33656002)(86362001)(83380400001)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wk9yQlBUN3pZejJWWG5UU2JPVWxPdkFoaWdyUGRIa0NwSk1zYkFadVN4YWZH?=
 =?utf-8?B?aTRXVWlHOXF2dk9ucEtsQjMxbHN6cnpzYzJxV29ocUpJbk1JTXdVUHdUZlkv?=
 =?utf-8?B?aGV6cWhBR3JQMVdpYmVvOW0wa0dTZFBZSkZhWW5Za1piYVMyQjhHZnJsb1Vr?=
 =?utf-8?B?S1lRdUlJVHZpZzdXL1BVQUFWdnlFdjl2RzRSY3ZUZTFYZjlVZklnWWJKYWxP?=
 =?utf-8?B?WUx6RlhLOE5HNFY1T3VOcDl5QitJelJWVmxWZE94WnFxbU9CSmhLdU1INFk3?=
 =?utf-8?B?dDJzWisvSExZOFRSQytvZTJiRWFzam5qYkEwWDNXTFdTd2ZFMC9ZRjlkanNo?=
 =?utf-8?B?MXZvdTJrcXlFYUt2WUlKenpRUmNwRm5ScWRETERkSGE2aThmaU5aY29KU2hY?=
 =?utf-8?B?SVlUODhDR3RENndKQVVGL29LZVVZYTZjSUNybGU4V0lwT01YWSt2NUwzTUh4?=
 =?utf-8?B?bVBndlBRbnJFRkwycklRdlRWeXo0LzUyNWNkVTBhek9xR0tMUGxvRVBxWGFB?=
 =?utf-8?B?WThJWXMyOTlyVkE0Sy9PWDVPQzlPcHJXNEFJL0Z1N1kza2JiUE9OWVVWRm1X?=
 =?utf-8?B?bEx5WjhXalNvZUVpRTF2dStHcUQ0eDY1WXdYdG1FUVh3YWhjbWJQNlNtODZX?=
 =?utf-8?B?Vllyd2RBWlRJK0JlMXp1RTRLNTBBTGRXRjgzS1ZZeENLREI3SzcvNUtQVXdK?=
 =?utf-8?B?YnhPUTMwNjFFMVF0ckViTVhsVFJxT25vcXo2cDM5eXA4MVc0NHV6dmFJSGRv?=
 =?utf-8?B?TGhZUnI2NkQ0N05ZQWF6dzRFY1ByU2crTmI1eXFNYTlmOTVtVHVyOGJYRldE?=
 =?utf-8?B?NXV5V1JwOUlvTnpQWkI3Sjh6bVR1VU9aMTVTQU1ocFVYeWR0aExyVG5XTzFT?=
 =?utf-8?B?SjJhZU1WYVc3ZHNNaEk2ODNUd1ZzZldZYjc2TTU2R2I2YzRwdGJXTTdUcUVS?=
 =?utf-8?B?bk5xNzM0NVB0WmhKcmJjY2lFZ0hYbXQ2RG5NTzFEYnR0aDJuUlRkU1BXd2dQ?=
 =?utf-8?B?eFo2NWhvQUoyWHNpTXAyb0tPVFgwaExUYXprbGVWUENOOFg0eDBLZjNWSmZZ?=
 =?utf-8?B?N0JWemN2dmZzeDdnQnZQUE1zd0M4cSthQktpVGR6MW0wOU4zcVQwcFZPU3lm?=
 =?utf-8?B?ZVg3QzlEWVhqQXdoalhQRm5tRFZlTEFzejJBWUtzMURqcVdWVU03NzFiVFAx?=
 =?utf-8?B?ZkwrWXovOTNaWVIwUkRmeFBiTFduK1I4dW1HSWx2SmhMM0N5aGQ1ZWlkeXBR?=
 =?utf-8?B?TDNZRGJVTzkyc3habmUvcEwyTEMwdUdVSnpwOXNQS2V5NitSRkUrT1QxRHpm?=
 =?utf-8?B?UE1VSFFRTUNEZ3EyaHBGUXB2NHlwK25POVF1WkFTb2xYNSttandFVU56ekZD?=
 =?utf-8?B?R2pEeTRtT2FjcEVYTndabHpyT3huU2lPaGp0eEJnRWZoUlFmdjZoQ0VENVkr?=
 =?utf-8?B?cy9SZlUrK2QzdXEreWoxWU9jOXNPM2Vxam4zV3JiMi9DZk1kamxGZ1FPQmQ5?=
 =?utf-8?B?UTB3T3ZtYXRCSTNHZ3pPMDVHcU10N1FlbGNERzJ2UHI2L2JLUm9JVmlUa3hH?=
 =?utf-8?B?K293dVpwUjN5UGs5UFBuU3pjdTg4dmFiVHpRVVJLa0RNKzJVODJzbmlMZ1hB?=
 =?utf-8?B?SWFiMDFLOWNEd01xTkllSHE4cnl0V3VhVURIaWI4Nm11N3dtK3ZHeWpYc3Ba?=
 =?utf-8?B?T09menpOZ2ViWWJlZGJSYW94RHB0QVp3cnRXWU5BMXVIYXJkZkg5YXNmRUpj?=
 =?utf-8?B?TEpSMmlBdWYrd3JnRTVDZzBjTWNZZzNkTHBPUUJxckd5NmNuT3JlRkF5T0RN?=
 =?utf-8?B?NzU3UEp1djV1eGowcnd2MUdEa3Q0LzVsNnZwNU9tb0Z0SXg4ckc1MGNOWDNG?=
 =?utf-8?B?OHRyaDV0eStrR2ZMT3NVZnEwZDNHbGFMclYwa0FFRlFQelJzZmdzVlBNbEdO?=
 =?utf-8?B?bWJnUTYwcExNdE1FV09wdG42UlZ1aDhtN1U5RUlpNm95RDNNKzRVd2RlaHU2?=
 =?utf-8?B?ZUZsRzNzQlNaNUtYc0JxaTcyU1FydHVuazFKL2tKV3JvRGUxNUE3VXhJSHpE?=
 =?utf-8?B?V1NvYUgrc1FDenVGd0FwM0lmczFYaGdRVVNFVmNoOE5SMDNENURjdSt1L1M5?=
 =?utf-8?B?NWhSZHBBbWtJVE5zSU93S2VwR0tmeFp0ODRaVFZZZFBmanlQazhVTzl0ZzE1?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52D45262533E3742A814F37AA7BFA7B0@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f93d702a-cf66-4a4a-72c4-08db9cbf8b32
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 12:11:09.0795 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9UKzNOASMUxYuWig9/GErV0PdNz7G1Z9WJyyDQR/IKlVd4opVxrot+L1JdP8B84gte/In64VLsPMz7AQqC8ydmwd/6hg/fl2z+QVUkKBTig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9152
X-Proofpoint-GUID: 5XVrO6G_9MfLp27j0r0bXigX3353XXMP
X-Proofpoint-ORIG-GUID: 5XVrO6G_9MfLp27j0r0bXigX3353XXMP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_07,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=raphael.norwitz@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

V2h5IGNhbuKAmXQgd2UgcmF0aGVyIGZpeCB0aGlzIGJ5IGFkZGluZyBhIOKAnGV2ZW50X2Ni4oCd
IHBhcmFtIHRvIHZob3N0X3VzZXJfYXN5bmNfY2xvc2UgYW5kIHRoZW4gY2FsbCBxZW11X2Nocl9m
ZV9zZXRfaGFuZGxlcnMgaW4gdmhvc3RfdXNlcl9hc3luY19jbG9zZV9iaCgpPw0KDQpFdmVuIGlm
IGNhbGxpbmcgdmhvc3RfZGV2X2NsZWFudXAoKSB0d2ljZSBpcyBzYWZlIHRvZGF5IEkgd29ycnkg
ZnV0dXJlIGNoYW5nZXMgbWF5IGVhc2lseSBzdHVtYmxlIG92ZXIgdGhlIHJlY29ubmVjdCBjYXNl
IGFuZCBpbnRyb2R1Y2UgY3Jhc2hlcyBvciBkb3VibGUgZnJlZXMuDQoNCg0KPiBPbiBBdWcgNCwg
MjAyMywgYXQgMToyOSBBTSwgTGkgRmVuZyA8ZmVuZ2xpQHNtYXJ0eC5jb20+IHdyb3RlOg0KPiAN
Cj4gV2hlbiB0aGUgdmhvc3QtdXNlciBpcyByZWNvbm5lY3RpbmcgdG8gdGhlIGJhY2tlbmQsIGFu
ZCBpZiB0aGUgdmhvc3QtdXNlciBmYWlscw0KPiBhdCB0aGUgZ2V0X2ZlYXR1cmVzIGluIHZob3N0
X2Rldl9pbml0KCksIHRoZW4gdGhlIHJlY29ubmVjdCB3aWxsIGZhaWwNCj4gYW5kIGl0IHdpbGwg
bm90IGJlIHJldHJpZ2dlcmVkIGZvcmV2ZXIuDQo+IA0KPiBUaGUgcmVhc29uIGlzOg0KPiBXaGVu
IHRoZSB2aG9zdC11c2VyIGZhaWwgYXQgZ2V0X2ZlYXR1cmVzLCB0aGUgdmhvc3RfZGV2X2NsZWFu
dXAgd2lsbCBiZSBjYWxsZWQNCj4gaW1tZWRpYXRlbHkuDQo+IA0KPiB2aG9zdF9kZXZfY2xlYW51
cCBjYWxscyAnbWVtc2V0KGhkZXYsIDAsIHNpemVvZihzdHJ1Y3Qgdmhvc3RfZGV2KSknLg0KPiAN
Cj4gVGhlIHJlY29ubmVjdCBwYXRoIGlzOg0KPiB2aG9zdF91c2VyX2Jsa19ldmVudA0KPiAgIHZo
b3N0X3VzZXJfYXN5bmNfY2xvc2UoLi4gdmhvc3RfdXNlcl9ibGtfZGlzY29ubmVjdCAuLikNCj4g
ICAgIHFlbXVfY2hyX2ZlX3NldF9oYW5kbGVycyA8LS0tLS0gY2xlYXIgdGhlIG5vdGlmaWVyIGNh
bGxiYWNrDQo+ICAgICAgIHNjaGVkdWxlIHZob3N0X3VzZXJfYXN5bmNfY2xvc2VfYmgNCj4gDQo+
IFRoZSB2aG9zdC0+dmRldiBpcyBudWxsLCBzbyB0aGUgdmhvc3RfdXNlcl9ibGtfZGlzY29ubmVj
dCB3aWxsIG5vdCBiZQ0KPiBjYWxsZWQsIHRoZW4gdGhlIGV2ZW50IGZkIGNhbGxiYWNrIHdpbGwg
bm90IGJlIHJlaW5zdGFsbGVkLg0KPiANCj4gV2l0aCB0aGlzIHBhdGNoLCB0aGUgdmhvc3RfdXNl
cl9ibGtfZGlzY29ubmVjdCB3aWxsIGNhbGwgdGhlDQo+IHZob3N0X2Rldl9jbGVhbnVwKCkgYWdh
aW4sIGl0J3Mgc2FmZS4NCj4gDQo+IEFsbCB2aG9zdC11c2VyIGRldmljZXMgaGF2ZSB0aGlzIGlz
c3VlLCBpbmNsdWRpbmcgdmhvc3QtdXNlci1ibGsvc2NzaS4NCj4gDQo+IEZpeGVzOiA3MWUwNzZh
MDdkICgiaHcvdmlydGlvOiBnZW5lcmFsaXNlIENIUl9FVkVOVF9DTE9TRUQgaGFuZGxpbmciKQ0K
PiANCj4gU2lnbmVkLW9mZi1ieTogTGkgRmVuZyA8ZmVuZ2xpQHNtYXJ0eC5jb20+DQo+IC0tLQ0K
PiBody92aXJ0aW8vdmhvc3QtdXNlci5jIHwgMTAgKy0tLS0tLS0tLQ0KPiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcv
dmlydGlvL3Zob3N0LXVzZXIuYyBiL2h3L3ZpcnRpby92aG9zdC11c2VyLmMNCj4gaW5kZXggOGRj
ZjA0OWQ0Mi4uNjk3YjQwM2ZlMiAxMDA2NDQNCj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LXVzZXIu
Yw0KPiArKysgYi9ody92aXJ0aW8vdmhvc3QtdXNlci5jDQo+IEBAIC0yNjQ4LDE2ICsyNjQ4LDgg
QEAgdHlwZWRlZiBzdHJ1Y3Qgew0KPiBzdGF0aWMgdm9pZCB2aG9zdF91c2VyX2FzeW5jX2Nsb3Nl
X2JoKHZvaWQgKm9wYXF1ZSkNCj4gew0KPiAgICAgVmhvc3RBc3luY0NhbGxiYWNrICpkYXRhID0g
b3BhcXVlOw0KPiAtICAgIHN0cnVjdCB2aG9zdF9kZXYgKnZob3N0ID0gZGF0YS0+dmhvc3Q7DQo+
IA0KPiAtICAgIC8qDQo+IC0gICAgICogSWYgdGhlIHZob3N0X2RldiBoYXMgYmVlbiBjbGVhcmVk
IGluIHRoZSBtZWFudGltZSB0aGVyZSBpcw0KPiAtICAgICAqIG5vdGhpbmcgbGVmdCB0byBkbyBh
cyBzb21lIG90aGVyIHBhdGggaGFzIGNvbXBsZXRlZCB0aGUNCj4gLSAgICAgKiBjbGVhbnVwLg0K
PiAtICAgICAqLw0KPiAtICAgIGlmICh2aG9zdC0+dmRldikgew0KPiAtICAgICAgICBkYXRhLT5j
YihkYXRhLT5kZXYpOw0KPiAtICAgIH0NCj4gKyAgICBkYXRhLT5jYihkYXRhLT5kZXYpOw0KPiAN
Cj4gICAgIGdfZnJlZShkYXRhKTsNCj4gfQ0KPiAtLSANCj4gMi40MS4wDQo+IA0KDQo=

