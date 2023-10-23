Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9FE7D2E57
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 11:32:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qurHg-0001oc-Eu; Mon, 23 Oct 2023 05:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qurHd-0001n2-A4; Mon, 23 Oct 2023 05:31:37 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qurHZ-0004T5-GA; Mon, 23 Oct 2023 05:31:37 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39N4KRjx004290; Mon, 23 Oct 2023 02:31:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=kkY/BJm+CgCSVU0cQYc8XmLdtU00SV7pyVvHs9
 IwOD0=; b=p+2O1xtStLkrTfnuOhNJjWonfaM2640B+mGDerKlRRZGtbYnL6PNmx
 iDrXpTSSiToepTy+hxEBPEvDJ2ziOX49zHBqYNw7tWv2KZFqpULXqTOWrG8q9AGN
 01WjTgn+hPrl3nUMQ2iSd2jXWi2YYJ8jlEHAbxMLkDIc7Xm6PxTXLKt5aiYQb6Hj
 l9GeLm+rpws7n8KD0wFxRLnqua5dwhItVzAx+3NHe44/VeMYMxC957mv4yENRkdD
 ky1VMoWgNGXJBZx4U58bXRHTN0jVs8NWBhyauZK1hr76HzAGasbPPb9vqrG5FOa0
 j8xTRCZYLcAiCo5JTtcHxvTdc/xqV9/Q==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3tvaj4tgah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Oct 2023 02:31:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2rdXuXT0trEpVSAYNGOg2oQ6IdepTUBxe+d7z08aVyhDP8Gj1vkUWWQzUT+yp3taisCZwhN4LOWT3g+XsppRaMDfBi1xvuPbKW0d/7OqchwPlq1+7xfJTBnISmnvIZD5OrwZYeP4rPPkfpNNkG9jTBQi/umiaOXh6W3VLA4GJSm9fkXqDEXM0Hrh8apzki/m4wJz85QJDrN/jV2rVLvLgnPwHpyM8L9ZxrJMcXz/tSbu8miAWyXzXHbbvfYJbk5BRFtmmJaUZEN3X6wlVJcYzlEvfpmTL69x6a4Iimzn4U2rHNGNL+nvbOR9geH3gIk42dZYc70jAXLbrGuNoZFKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkY/BJm+CgCSVU0cQYc8XmLdtU00SV7pyVvHs9IwOD0=;
 b=CbutRfpL83uqwWrVodQWP1hjv64/2sWVsLLujsge8vZ4c6KooA+QiUmEPsv+L0d7rwc3nd0cSJd9MldLpOtbtwwlcYO35OKHZDU4tKo4D56jza2cexcr3jAcNBP0hDYld7/01Lb1vNVpArKKPjle71xVcOqyAGkIFDdcUfma+Q/jzJDgDJRLZgA0ylK3mhdnWYpmYQ14039clFlCaaBLI6JZtxf8HmdSv+TrW60EMlvQRgTl1qndbCdTyfqmzkon940fpc1PKQQCJGIE2HfPDD1JYWE1/UQ5Ig2JvGRMYJTLHozl9N2cpERsHOK9EgbWOfe99LqFvvXbQ4fcqHXVUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkY/BJm+CgCSVU0cQYc8XmLdtU00SV7pyVvHs9IwOD0=;
 b=I0dd0DZ7WHuLzM3ko/7uqkWHuorrXSBSsG+lvoTmI6t8F3u0PEFTI90TnMDWwBUW0ApvQhIx0BQJ8bsDkOUbLOsycsW7ZpZxNJxA59FIk6T0qFBK9pwSyqcjyaKVraPxORdzFs89Px9vQW3DtrTprDi6gqsDqPZimJG2cV6QwQaeGD1ZfH/DMHKl4dgGrLlOa/PAmXLLhtwJ2+kzRzCX7XnuODlK7MxYUhzkeSPmKY5nWaOugow+O/eyace+Sk6PwNawZm3skNPkekFZXUGF2O+hZxx6eQZXxXDlI9QRdla/bXMWupR4aRcOL0VXFDw3z0eL22iepux8eAUpG9f/0g==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by CO6PR02MB7572.namprd02.prod.outlook.com (2603:10b6:303:a9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 09:31:25 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::69bc:f889:2ed:d7fd]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::69bc:f889:2ed:d7fd%6]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 09:31:24 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: "open list:Block layer core" <qemu-block@nongnu.org>, "open list:All
 patches CC here" <qemu-devel@nongnu.org>, "eblake@redhat.com"
 <eblake@redhat.com>, "dave@treblig.org" <dave@treblig.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "eduardo@habkost.net"
 <eduardo@habkost.net>, "berrange@redhat.com" <berrange@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "hreitz@redhat.com"
 <hreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "den-plotnikov@yandex-team.ru" <den-plotnikov@yandex-team.ru>,
 "daniil.tatianin@yandex.ru" <daniil.tatianin@yandex.ru>
Subject: Re: [PATCH 1/4] vhost-user-blk: simplify and fix
 vhost_user_blk_handle_config_change
Thread-Topic: [PATCH 1/4] vhost-user-blk: simplify and fix
 vhost_user_blk_handle_config_change
Thread-Index: AQHZ+JKlhPQF2RjJv0+cASXy029ZOrBXNjsA
Date: Mon, 23 Oct 2023 09:31:24 +0000
Message-ID: <460CC7E8-9ED8-45EB-983D-10C245CDEAC6@nutanix.com>
References: <20231006202045.1161543-1-vsementsov@yandex-team.ru>
 <20231006202045.1161543-2-vsementsov@yandex-team.ru>
In-Reply-To: <20231006202045.1161543-2-vsementsov@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|CO6PR02MB7572:EE_
x-ms-office365-filtering-correlation-id: b7ca375e-03be-4116-090c-08dbd3aad369
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cH5WduvEVx4/ogbogvii5SMW318iGxV11CAIO/bkT31Ogvy2EjfhKRcPnhIvu8w1h0Ex7DjpXNwg0QqxfRi1ZrHjQDMhoR05nUJS4C/YFAomWY0YhCx46p+nrsl9btvpmRyFrdJ5rQLp9ht29cXD2ebuhjHPAlFGkCR1hkwL2n809sCCfEaKLm1b+bYiabqCRY7J1EIXDJ+7aLqfIjwHCOGA7bBNSPXvGtmESJP7ECOaB3RA6YX1ZQj4olP6vye2Xt8hKCU+8kJV5FqK3YQ4UP2zuF5izttgkCHegBlps8NjcFkqoS0+1dt3lnATx3V494I3tYVdOQ9DnPN27zyL+MQesgBkCu9BtYmQdQ/Z8tuuWvfLOBydCAuuIUJ0FMeDIRFbQb124VejmWOkv2WG89ulQrqEmWmLVj/1GSuSp9UtZLvtJANfZqR4zTcCk+orDJcVQPyAJ+kERGa6MFiF/yc4eGlkFXLoexcDw1p5wD7isa1yTFWqneRR+yhlYyrWyxzHOg8uIgOmBuTTcWR5ENDrzlnJZigGvUucl9eIWipKEVqVkiUpqXuLTmEB5qu9IrRl9hm+rH+ahY6xQFv7j1PbmqWziw+iGTvD7sfOv1f6Ndg9IYIq7BlizyMKxIEYV8zS4OWRASxRhQpo+MR+aQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(38070700009)(38100700002)(2906002)(41300700001)(44832011)(86362001)(5660300002)(7416002)(36756003)(8676002)(8936002)(4326008)(33656002)(2616005)(6506007)(478600001)(71200400001)(91956017)(122000001)(66946007)(76116006)(316002)(54906003)(64756008)(66446008)(66476007)(66556008)(6916009)(83380400001)(6486002)(53546011)(6512007)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHJ4R2hORkdTWFM3ZXNiMTQzd2JybENOV0JwME5kNDdxM1dVRmxYd2lOTkNF?=
 =?utf-8?B?UTNGZE4wS3V2azRiakxGSE16QmVIc1pDYUdSaGo0M1czMUVkSDByOTlCaGZZ?=
 =?utf-8?B?S2lsZTlxc1IzSzhpVll3b1dXY3RJNEljdWt3cXZ3Wld2SUdxOEQ1T0xlSGNS?=
 =?utf-8?B?aStIc1ZaRzNxWUdQRHBrQ2FQVS8wakpkcFhETEV0TXJ6WkVZL1BmNnB2bURY?=
 =?utf-8?B?QVJ4VERpTVR5WSs3b2gxSWVENUlPVDJDdHpYaDlMUC9KSThCVzlnUjBua1Fq?=
 =?utf-8?B?QjB2dWhsM2ZrcmtmWVhCZnhEemlqSk5URlBwRkJXd3RTdCt6UVZGRnI2OGo4?=
 =?utf-8?B?c2dwZklWUGhLbnVIVTNGaTFkN1NmdjZLbHltUDdwelNtVDZuTlFhOGg2YXlW?=
 =?utf-8?B?Yy9FdnZUaGQ1ZjRhbUIxTFZVVTJoRHlnOXZOK29hNXFFS1d0cjlLV2dZaFR6?=
 =?utf-8?B?djFLQ2hoZnUycWg5RXExT3djQ3BScDk5YkF5b3owM1h1YlJEZk9UTTZYM0hq?=
 =?utf-8?B?Z1pkZ29YdUFCTGxramc0MlR5M0tEQW9FRHlFc0VYS2xCVGFxMjlLUEZiY1FL?=
 =?utf-8?B?U0Q5VlJCZXBZMjZIWGRVcEJqdU5OZUk2WG03NlhrNTczczVITWZ1V1hoa1ZD?=
 =?utf-8?B?WUJpUWpoTWVYcFZKVXZsZUdDUnh0S3VZUUVXNGJldTZTR0NndlM3azEvNWxa?=
 =?utf-8?B?TlNwcENFbHM0aEY2aVpmNloxTWxtSmw3NnpmbHVrZzBMbHlpUHJOK3NMSnBZ?=
 =?utf-8?B?L2JqQ2VPa3NESnRDck1ESU5rWCtZbHRYVWM4QWs4Ykh0T25FTHJQSjRSVUpL?=
 =?utf-8?B?cnZtNXgyT3BidnhvNzM0T000U3V6RE9EYytlZTRPVWVzNTdyU1dYRDMxcHZL?=
 =?utf-8?B?UkZUMm1NcVBoczN4Y3JFeTVLTkl4bEU3QkdtdEZFcFh5UHVLUFJ2bWJ0Z0sy?=
 =?utf-8?B?ODdpVlYvWnl2V1g5SGRKUGpKVFl2YllDdFhROTRGVXgvenB0aG1QUjhEMFZY?=
 =?utf-8?B?dUhTaGFmRVByUFNPU0QzSXY1a09URjFRdks4Vk9pUEtsYmx5OHY0OExic0JY?=
 =?utf-8?B?dHNwUUZiNFUrM2tjeVd3UGlxNGtzZXNyT3lST3J2Tm1rdnY2bkV1MWVsc1h1?=
 =?utf-8?B?M0h6RkN1Mk1RZFpnek1KQVlqZ2lsR3ozMEhvaU8vMEl0R1djVHRaNXBZR2Nx?=
 =?utf-8?B?ZFFqMlJQNk5hSjJ4cDhyb1RKRFYra0VPeWE4ZEZaaDZldnpxbzlYSkIyMlZQ?=
 =?utf-8?B?NmhLS0dmQlIrSm9COUs4SUdGVk5HRFFPWnpnemkwQTNNcDJkcGF5clR6OTZr?=
 =?utf-8?B?N0Y0aWZHNTcxUG1QUFVhRHlLMHdpcjJ3NTVVSmN2R0xvTm5MeU9sdStSSEVF?=
 =?utf-8?B?Q3JNYk50dXdNcEhNVWJIWXNsSlRWNjl1d0VSNi9zQ2ppRk1HZ2hPR1VENU5D?=
 =?utf-8?B?RnVCUlRyYTJRTzl5Ty9iQ3hmVlgzM0tQSk5rU1FCc0RBMS8yYU83OTUvODVm?=
 =?utf-8?B?bStHdVBiODlRRStsUnZkaEtrQkpCY0czOGpaQStvYnY1QjEvcy9tRzBmc3FE?=
 =?utf-8?B?MWY1eDVKZ3RqdlNQY1huR2VlUkdPeUZtekptSkNaSGduM1JKMFRsY2I0VkRq?=
 =?utf-8?B?SkNvc2YzblBiMlJVNFVnSFRORnNLUi9vd0FGVlRabXJIaFZZK0VybHZXWVYy?=
 =?utf-8?B?YUVnZGptdlA4SHVIajh5RUR3dUJ4cHA2THJiYkphSmlscjF5R2hPM0xsWXdS?=
 =?utf-8?B?NlRsMFZza0o3dXowWUoxb0Yxek01WWlEU1ZZR0FjV0ZIYk0vRHFrbldmcytV?=
 =?utf-8?B?WTlEUFpuR3ovWWtpZEdtaWowNXhJeVNwVTN6TU9Tb0NqQkxYYmVzOHRxaWpl?=
 =?utf-8?B?V3RLTzcrbmdrZElPVkNrdTRyb0lJdzgvR0s0RjRRbGl5WkVWRGJ5enJVRkNu?=
 =?utf-8?B?TUttWklDZ3EySm8zUDM5aDdKYlFPMnRSSkVVZk1MclowR0dlZkNWUlhtWXJt?=
 =?utf-8?B?dFF0azBWcmRCeVNtV3ByN2JHMENLWTA2OS9nU1NhazZMd1JtQUJCcUxvT1I2?=
 =?utf-8?B?T3Jvb2NpK2llNXl3NUlrUGNHNDFFYUcrZGFhOXV1c2V1REdWbFliMDRDcW9a?=
 =?utf-8?B?M2dodVNiY1JxWCtPQjMrQ1BLVFpsZktnZnkwUHNVTDM5S0hwU3pNQTNuSC9G?=
 =?utf-8?B?cjkxb3ROd2x0ZUJ3Q29kdDBFLy8vVG82TUsrRnZ2RFVRNmVsbE9ldmtxaEVi?=
 =?utf-8?Q?1LYXcoLGI31PAmtSVUsoONdJxO/nqleLQQs/IKuTIY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C623E759B57CA449F0B85C545B6871E@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ca375e-03be-4116-090c-08dbd3aad369
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 09:31:24.7656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 55wRwlomvAVY3ww9UXSHVwGauEOJvs0J1cswkfiNbiKuu3tw9C1PpSiVgbsnlemWSbV3LXzpqdy8S2UR4qfKREGgukDUxUl6HrKcd5SQri4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7572
X-Proofpoint-GUID: 5seRUjRvgIF8nFQQdYurIR42pWQjLJ4n
X-Proofpoint-ORIG-GUID: 5seRUjRvgIF8nFQQdYurIR42pWQjLJ4n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_07,2023-10-19_01,2023-05-22_02
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

SSBkb27igJl0IHVuZGVyc3RhbmQgdGhlIOKAnHZhbGlkIGZvciByZXNpemUgb25seeKAnSBjb21t
ZW50LiBMb29rcyBsaWtlIHRoaXMgaXMgemVybyBkYXkgYmVoYXZpb3IgYW5kIEkgY2Fu4oCZdCB0
ZWxsIHdoeSBpdCB3YXMgYWRkZWQuIERvZXMgYW55b25lIGtub3c/DQoNCldpdGggdGhhdCwgcmVh
c29uaW5nIGFuZCBjb2RlIGxvb2tzIGdvb2Q6DQoNCkFja2VkLWJ5OiBSYXBoYWVsIE5vcndpdHog
PHJhcGhhZWwubm9yd2l0ekBudXRhbml4LmNvbT4NCg0KPiBPbiBPY3QgNiwgMjAyMywgYXQgNDoy
MCBQTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB5YW5kZXgtdGVh
bS5ydT4gd3JvdGU6DQo+IA0KPiBMZXQncyBub3QgY2FyZSBhYm91dCB3aGF0IHdhcyBjaGFuZ2Vk
IGFuZCB1cGRhdGUgdGhlIHdob2xlIGNvbmZpZywNCj4gcmVhc29uczoNCj4gDQo+IDEuIGNvbmZp
Zy0+Z2VvbWV0cnkgc2hvdWxkIGJlIHVwZGF0ZWQgdG9nZXRoZXIgd2l0aCBjYXBhY2l0eSwgc28g
d2UgZml4DQo+ICAgYSBidWcuDQo+IA0KPiAyLiBWaG9zdC11c2VyIHByb3RvY29sIGRvZXNuJ3Qg
c2F5IGFueXRoaW5nIGFib3V0IGNvbmZpZyBjaGFuZ2UNCj4gICBsaW1pdGF0aW9uLiBTaWxlbnQg
aWdub3JlIG9mIGNoYW5nZXMgZG9lc24ndCBzZWVtIHRvIGJlIGNvcnJlY3QuDQo+IA0KPiAzLiB2
aG9zdC11c2VyLXZzb2NrIHJlYWRzIHRoZSB3aG9sZSBjb25maWcNCj4gDQo+IDQuIG9uIHJlYWxp
emUgd2UgZG9uJ3QgZG8gYW55IGNoZWNrcyBvbiByZXRyaWV2ZWQgY29uZmlnLCBzbyBubyByZWFz
b24NCj4gICB0byBjYXJlIGhlcmUNCj4gDQo+IEFsc28sIGxldCdzIG5vdGlmeSBndWVzdCB1bmNv
bmRpdGlvbmFsbHk6DQo+IA0KPiAxLiBTbyBkb2VzIHZob3N0LXVzZXItdnNvY2sNCj4gDQo+IDIu
IFdlIGFyZSBnb2luZyB0byByZXVzZSB0aGUgZnVuY3Rpb25hbGl0eSBpbiBuZXcgY2FzZXMgd2hl
biB3ZSBkbyB3YW50DQo+ICAgdG8gbm90aWZ5IHRoZSBndWVzdCB1bmNvbmRpdGlvbmFsbHkuIFNv
LCBubyByZWFzb24gdG8gY3JlYXRlIGV4dHJhDQo+ICAgYnJhbmNoZXMgaW4gdGhlIGxvZ2ljLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVu
dHNvdkB5YW5kZXgtdGVhbS5ydT4NCj4gLS0tDQo+IGh3L2Jsb2NrL3Zob3N0LXVzZXItYmxrLmMg
fCAxMSArKystLS0tLS0tLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA4IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L2Jsb2NrL3Zob3N0LXVzZXItYmxrLmMg
Yi9ody9ibG9jay92aG9zdC11c2VyLWJsay5jDQo+IGluZGV4IGVlY2YzZjdhODEuLjFlZTA1YjQ2
ZWUgMTAwNjQ0DQo+IC0tLSBhL2h3L2Jsb2NrL3Zob3N0LXVzZXItYmxrLmMNCj4gKysrIGIvaHcv
YmxvY2svdmhvc3QtdXNlci1ibGsuYw0KPiBAQCAtOTMsNyArOTMsNiBAQCBzdGF0aWMgdm9pZCB2
aG9zdF91c2VyX2Jsa19zZXRfY29uZmlnKFZpcnRJT0RldmljZSAqdmRldiwgY29uc3QgdWludDhf
dCAqY29uZmlnKQ0KPiBzdGF0aWMgaW50IHZob3N0X3VzZXJfYmxrX2hhbmRsZV9jb25maWdfY2hh
bmdlKHN0cnVjdCB2aG9zdF9kZXYgKmRldikNCj4gew0KPiAgICAgaW50IHJldDsNCj4gLSAgICBz
dHJ1Y3QgdmlydGlvX2Jsa19jb25maWcgYmxrY2ZnOw0KPiAgICAgVmlydElPRGV2aWNlICp2ZGV2
ID0gZGV2LT52ZGV2Ow0KPiAgICAgVkhvc3RVc2VyQmxrICpzID0gVkhPU1RfVVNFUl9CTEsoZGV2
LT52ZGV2KTsNCj4gICAgIEVycm9yICpsb2NhbF9lcnIgPSBOVUxMOw0KPiBAQCAtMTAyLDE5ICsx
MDEsMTUgQEAgc3RhdGljIGludCB2aG9zdF91c2VyX2Jsa19oYW5kbGVfY29uZmlnX2NoYW5nZShz
dHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpDQo+ICAgICAgICAgcmV0dXJuIDA7DQo+ICAgICB9DQo+IA0K
PiAtICAgIHJldCA9IHZob3N0X2Rldl9nZXRfY29uZmlnKGRldiwgKHVpbnQ4X3QgKikmYmxrY2Zn
LA0KPiArICAgIHJldCA9IHZob3N0X2Rldl9nZXRfY29uZmlnKGRldiwgKHVpbnQ4X3QgKikmcy0+
YmxrY2ZnLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmRldi0+Y29uZmlnX2xl
biwgJmxvY2FsX2Vycik7DQo+ICAgICBpZiAocmV0IDwgMCkgew0KPiAgICAgICAgIGVycm9yX3Jl
cG9ydF9lcnIobG9jYWxfZXJyKTsNCj4gICAgICAgICByZXR1cm4gcmV0Ow0KPiAgICAgfQ0KPiAN
Cj4gLSAgICAvKiB2YWxpZCBmb3IgcmVzaXplIG9ubHkgKi8NCj4gLSAgICBpZiAoYmxrY2ZnLmNh
cGFjaXR5ICE9IHMtPmJsa2NmZy5jYXBhY2l0eSkgew0KPiAtICAgICAgICBzLT5ibGtjZmcuY2Fw
YWNpdHkgPSBibGtjZmcuY2FwYWNpdHk7DQo+IC0gICAgICAgIG1lbWNweShkZXYtPnZkZXYtPmNv
bmZpZywgJnMtPmJsa2NmZywgdmRldi0+Y29uZmlnX2xlbik7DQo+IC0gICAgICAgIHZpcnRpb19u
b3RpZnlfY29uZmlnKGRldi0+dmRldik7DQo+IC0gICAgfQ0KPiArICAgIG1lbWNweShkZXYtPnZk
ZXYtPmNvbmZpZywgJnMtPmJsa2NmZywgdmRldi0+Y29uZmlnX2xlbik7DQo+ICsgICAgdmlydGlv
X25vdGlmeV9jb25maWcoZGV2LT52ZGV2KTsNCj4gDQo+ICAgICByZXR1cm4gMDsNCj4gfQ0KPiAt
LSANCj4gMi4zNC4xDQo+IA0KDQo=

