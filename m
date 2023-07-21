Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E346275CA94
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 16:50:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMrRp-0002z4-Fk; Fri, 21 Jul 2023 10:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qMrRj-0002iE-7r
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:49:31 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qMrRh-0004m4-CL
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:49:30 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36LBo1b3027837; Fri, 21 Jul 2023 07:49:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=JXLHqTV6sn5nvsSbIcczXz3Ezhv3xr8Tj/y1wI
 PCOZw=; b=CCNoIWq/E/tayAn/wZNjmj71O7/Lv4PuopxkgL3M1Di3f2OSVeJIEi
 nvWtoqE3L4CEG3hYBn1NVP4usVYoM7epBhNCxscEnWoaOje3w7Fcg0hUWkKwDHi/
 B6qJTaqR0ALD2DSGi7EDjQvO0D4LTy4HrMCm1FqY7HhMs/EMx8y7rN1MclKsQDCc
 WBfRf8b0J9nCDs6WMXT7sCHskSns/KPFiOH2rREY31WDUK3FpFeXmBdeM3MKAkwA
 Vp12UCd/D32BxIo1fSKKarNmK0ZYHfUSQI2CCPvM2qyX3qqFztAubDHpGe6labL9
 UdW5J6bBBtWsWivLr9STd1zFTpy2wS6Q==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rx319phvh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jul 2023 07:49:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUfny+LK2g01Et899KMUb81C5NyPEQ/P+TigDZySuY399NmkUhL+qCWTb7dePfTX6Sd7l/a3MD0bfRlhRs0priebPB6reUKvpqZDo6GWmovJ+ZQrfy0hdVuQf13Kx/Z+ogAtUtfXBNQPBvS8vk+Tz1ArGU/ZqAnOhDyZEHVu0ubQtGiEKLEBkwEHIOhE+IWzGehDo395OFDchLbHTO/fZGY0DpGwFpafSQX8cmE5BnijgDJ4sDj53C076Q5e9fsz6PCnIGku6/O4wtZnGLTWEfSV2h8flA1psJ7bU3vSHZCRYd7VKjXfbj1Qk5ILKVE1Xszr8t2Mo4WYocGXfU24Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXLHqTV6sn5nvsSbIcczXz3Ezhv3xr8Tj/y1wIPCOZw=;
 b=l4EOOtUXuaahvNo5E0WL3/AI1B73AGkO6YSZKef9dpo0yJmftLaTGDgVI4XynnMJe4UvCXU0TF0D/7A/Njthr0J0C1vd8srOHvV3NdJnVyJD0Zpx2Vz45q5sFEpGiJ2DItF3L8eLla63hkCR0aOO49t1v+Spuw+LS7X5SoPW21f+D5DAQJX7a0dr/1BNkjTiqAGASfopv0RxkxQNtc1r0EBHaP3Q3qJsLDq+NSqGlQZMHUsDYM4HnKQB6HED8jkYUfFQLhtSmxNlQSmSjFCwATkLYXe4MDh574dH1Gt6WSyXZ1b0Mt7GN6kSJHT6HPHNyH+nyc5qDrOJp/zVVE6tJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXLHqTV6sn5nvsSbIcczXz3Ezhv3xr8Tj/y1wIPCOZw=;
 b=gctETqcXMmcnYqIuZAlL7TNpDqaNqimUfHVFG7YtboHsVOkQ4S/mVDILyfNENKFdrRFzjcdMUOSA9fPNMvY4h5E2Okwp5oGU+S3TDDBrqYz8r7cyGf+7xfIl9aT6kR5O6i/7mTcMuhTETjH3uR1gDXIHTlpEJIO9kraRjQGBx8ru9uBcFwYjRbivaTOselOXFHmu49iG8OFeRVQZSQVxuTr9ar2BJcu1ZEEaluvd2Ok9Jz/qMVWdyH2A7uE9NuF0B1CTlRyG4fbniRp9c43lz3tBCbGV9b4yudOA39v7LfzH2i5Wl4Gg3xkwfe1G+ESbS+dCEqoMPyON2ER3ehG4hQ==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by SA2PR02MB7561.namprd02.prod.outlook.com (2603:10b6:806:140::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 14:49:24 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e%7]) with mapi id 15.20.6609.022; Fri, 21 Jul 2023
 14:49:24 +0000
From: Het Gala <het.gala@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Prerna Saxena <prerna.saxena@nutanix.com>, "quintela@redhat.com"
 <quintela@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, Manish Mishra
 <manish.mishra@nutanix.com>, Aravind Retnakaran
 <aravind.retnakaran@nutanix.com>, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v9 02/10] migration: convert migration 'uri' into
 'MigrateAddress'
Thread-Topic: [PATCH v9 02/10] migration: convert migration 'uri' into
 'MigrateAddress'
Thread-Index: Adm74oqBvS7bXSvbLEanSGWgWQmLog==
Date: Fri, 21 Jul 2023 14:49:24 +0000
Message-ID: <20230721144914.170991-3-het.gala@nutanix.com>
References: <20230721144914.170991-1-het.gala@nutanix.com>
In-Reply-To: <20230721144914.170991-1-het.gala@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PH0P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::17) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB4343:EE_|SA2PR02MB7561:EE_
x-ms-office365-filtering-correlation-id: 089fa485-ef9a-4619-d092-08db89f9acfe
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HuOuUbNXTSIBY6LL3nLXby55oqqFuQDg90vvD6B4jHRY15jB2ta682tPd0rWViHB1AqJnXAcZRRJ9L9a6ImmPu9LVo6V9xBouB3BL7po8inOfncqameUx5axlOIVm7g7zDO9Em1SymgP8C66km8FLwrBHY7viPtjAOF1pa17rz3E0KA/lyvizoXfjoIb6I+apKD1eIjCuVXfbN6xaFFJDAaSUxYncZETTzXiRMyopVUzTEUAquKA+MvY2SqVK4QEVfDIlEyMHWcaxqAXh/N5c/O1r6OdJP1eSS5HK774/S743LNPu1rEF37s2yAQtrvoPkteJGhqk2ve/a3Jq3dJ6KG5ZC2ng1hy53wHcxs7EQ1VHlmuLVNtBwcuTSTC13o+aP0+OakYbbaTndZOln7y4Q+z4SQgYrK6ReTn/uvMPPAS9fk98M7brNykLZi+uUvWwq+gly56Z4Vl1Ats90hBWy2SSa84gMVGywM6j5olHOLD+shPMXk9WKR19tMIhZLirNMPJtc6KdGW1TyWSw6uLAaSj7TOqo/gP49jziuN+0YOzjAnUoVcn+3//anpZ+bMHzlmY21fDdh60IZTeR03ImF6BUlV8NeNhdCS9gmJBDUJ6kOSPm9VsqhY9fKCjd45
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199021)(2616005)(6486002)(52116002)(6512007)(71200400001)(478600001)(86362001)(26005)(1076003)(107886003)(6506007)(36756003)(5660300002)(4326008)(44832011)(6916009)(41300700001)(8936002)(8676002)(316002)(2906002)(122000001)(38100700002)(54906003)(64756008)(66476007)(66556008)(66446008)(66946007)(38350700002)(186003)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0lxMEJ1QUZ0MGV2c2JDUUZEUnp1bGsyNkFBNUwvcEY2bi9aZnplbjFhVGN5?=
 =?utf-8?B?bmU1OFNUaUJ0ZGliSVNiSktaVnNJbU5UZ0tiY0F4TCt1UGF3NmF3dzV1VFB0?=
 =?utf-8?B?eHR5QUh1S2JCNzJyWU9RYWlMV1hNTys3cmlSdW9ocmd1S2RJdmVwVDNoSExD?=
 =?utf-8?B?eklGbFJZWWljNm9UOVZ4czI5MlRGdDhlV2kzTHZMUFdZTDhMZm4xakp1R25p?=
 =?utf-8?B?UW9lWnRTQ0llRlVRNU84WEQxU3F1TkNVV1VYbVVleFRSN0Roc2JCYUpQYy9i?=
 =?utf-8?B?YWlOOTJueHBKdStZTnJBc2s3VGxPYTY4SDZMWThtK3gxanM4bVdXa0NvVERn?=
 =?utf-8?B?WGhneVQ3NFRyMm9TNHJwakR5VnFaUW10UWVKbUo4Q1Ira01JTko2c3llaGlv?=
 =?utf-8?B?YkwyMGQrckhvSjFnaEpIUkFreHRnNUFqMEhHakp4R1VWRnV4aDlad21iaHFz?=
 =?utf-8?B?L2ltWDQyek41UWhLTlNENWo3c3ovYTdhMis2Mk52TVVBUWtVaklyYjVTWVp0?=
 =?utf-8?B?TVlkb2FQNTl2eERJd2VUNTR3VnR5blFPT2VBWG1pWW16TkFCQWRmMlcwNXZr?=
 =?utf-8?B?OE1PcitpMSsvOGRUQi9mV01VY0JzV2JDZHZTaDFKZmNIaWlDcnZ1VXlJLy9D?=
 =?utf-8?B?SDQxb3JUMVo4ZWphbEZ6QUFDNGEyc1UzRjNvS2Zrb3ZPRXBoTlZQcDgrQmVt?=
 =?utf-8?B?S3UwUVVGVkVVeTdVVmsrSEoxRDUwd24ydlNReUp5a1BvYmFhRC9Fd3NPRkZJ?=
 =?utf-8?B?disyYzNSR2hjMy9uclVDV2N1MHBzUWxGUEttTjZhbFF1aTVkTDlxODFxWnMy?=
 =?utf-8?B?SnVEV2N4M0tWRTNNTFhEMFFVbDFnSzg3SUVqdVFrbVM5Z1ZRVkFpM1VmZE5G?=
 =?utf-8?B?OGI1aDAydlB2ZThaNW4xOTVhVU5jaXUzQ0dtcHU5VWdFYkFuNHk2YlJTblJ0?=
 =?utf-8?B?QUErK3Zab0R6Y2NBUGtqVGtiYWtLNUs3RzFJWlM4Zk5vTk5uVlV3cVhBcjN0?=
 =?utf-8?B?YzN0UjZabVV3bGxQL0xWQS9GTEk1WDhBNXRIeTR6azJrSTV3WEFvS0FLOHNn?=
 =?utf-8?B?T1VZRDJRcE55cjFpOTZUTE0zOVoxT2h3eGVtZUxiS0JRUkd3cEl5eVBNZkp0?=
 =?utf-8?B?VncveS84N0kwUEw1R25jT3E3eU80eXlFQVI1VzNkR0lHTTlqVGd4d0cwUDZZ?=
 =?utf-8?B?YUZISENlZktoelpSeVNGY2RRR2JCdnN3cjN1Y0lVa3NBUkVjODdPTlpLZlhj?=
 =?utf-8?B?L2JnWHlHai80aGpYS2doSG5MRE4vSXBtU3hkNm5HeTNSakNvSm5jRU1heWJW?=
 =?utf-8?B?RjluS0dhZVpXc0ZmMWd1R0ZCc0lMaGVDdUpZMlNsNzlkMWxhLzhlRUxiM3R3?=
 =?utf-8?B?NFFqdWZVaVdJTEpNb2IwbjM0YzlSU0lTTU5OekFFZzJFTGw4dUY2RUVyRUF1?=
 =?utf-8?B?TmNZNHF0SVk1NDlpVGdtNnBjakdlSXRtNWlmUDErcUVDdGNGdW5VRTRpVXYx?=
 =?utf-8?B?d3Ara2VRMVRHMGRwSXVoQ1ZUWU95T21DWCttOGgvRzRUbEFkNFZFVy9jd0tk?=
 =?utf-8?B?MzhmYWRrRlg5b2FnMk9lbWFKcldseDUyYW1VYTlVR0ZpZ0x4QjlVZTNPZ3h0?=
 =?utf-8?B?MUEyMDdLRnFLM1Ruc2dOQ3RkcDN1S3FnNitlY05MNzVTMG5XTEJ5MDdWM1Br?=
 =?utf-8?B?NmFyekRZdlZwTUJEREMwL2ppbmxORFVOM1RtOUZWSXVrbkhzNnZtbGlqTWdq?=
 =?utf-8?B?MWMwZmYrY3pHeXNsUDNYdG5UaHdZRzFiQnhlTitsMmhPLzFhZzREMWViMlpv?=
 =?utf-8?B?eWp4OEdEbUJGa29YUHpLMW1PdTNxUm9icmxLODlJUEt1RGF3RHJNbnp5NXd6?=
 =?utf-8?B?QU9jQS9vZFdTb210eW5vc2hlVENZSVRPZWRJT2t6NURpbWluNlZVc3hYellQ?=
 =?utf-8?B?VzY1YStnSTJHRDMzblRUVlVmRFNqeEw2VnJ2MDVxbG9YdmdtNG9lY3RpeUdI?=
 =?utf-8?B?Vytqa2d6eFRTeWRHb283SUdNZm1zZ3c3Rmdxd2xaN0w1WjY4U0h3WWw0em04?=
 =?utf-8?B?Z3pJaVJpc2E3LzhGMVhCQ3lFVWFvYytlTUN1Q2JHM2I2U2cxbWRTajhHQ01L?=
 =?utf-8?B?ZG5lY1k1Ylc1U3hhWmQ1QitvV1N0a1psSXF2WndLYU5qNzI3dTQrSW1ETGRF?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <441266E840DD9B44A32CEBB18D0024F3@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 089fa485-ef9a-4619-d092-08db89f9acfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 14:49:24.4960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SG2RG5dsK+E5fDVrQe0cH2QtTRZzJMuLAUAnmoEvIfmRDw6MdCxSY0ONyWzSoz9+zG+PsFzOFv2mozf2uXELNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7561
X-Proofpoint-GUID: 9-TZ7449ankJKBwEMo065A5_d3rNqGi3
X-Proofpoint-ORIG-GUID: 9-TZ7449ankJKBwEMo065A5_d3rNqGi3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_09,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

VGhpcyBwYXRjaCBwYXJzZXMgJ21pZ3JhdGUnIGFuZCAnbWlncmF0ZS1pbmNvbWluZycgUUFQSSdz
ICd1cmknDQpzdHJpbmcgY29udGFpbmluZyBtaWdyYXRpb24gY29ubmVjdGlvbiByZWxhdGVkIGlu
Zm9ybWF0aW9uDQphbmQgc3RvcmVzIHRoZW0gaW5zaWRlIHdlbGwgZGVmaW5lZCAnTWlncmF0ZUFk
ZHJlc3MnIHN0cnVjdC4NCg0KU3VnZ2VzdGVkLWJ5OiBBcmF2aW5kIFJldG5ha2FyYW4gPGFyYXZp
bmQucmV0bmFrYXJhbkBudXRhbml4LmNvbT4NClNpZ25lZC1vZmYtYnk6IEhldCBHYWxhIDxoZXQu
Z2FsYUBudXRhbml4LmNvbT4NClJldmlld2VkLWJ5OiBEYW5pZWwgUC4gQmVycmFuZ8OpIDxiZXJy
YW5nZUByZWRoYXQuY29tPg0KLS0tDQogbWlncmF0aW9uL2V4ZWMuYyAgICAgIHwgIDEgLQ0KIG1p
Z3JhdGlvbi9leGVjLmggICAgICB8ICA0ICsrKysNCiBtaWdyYXRpb24vbWlncmF0aW9uLmMgfCA1
NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogMyBmaWxlcyBj
aGFuZ2VkLCA1OSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9t
aWdyYXRpb24vZXhlYy5jIGIvbWlncmF0aW9uL2V4ZWMuYw0KaW5kZXggMmJmODgyYmJlMS4uMzJm
NTE0M2RmZCAxMDA2NDQNCi0tLSBhL21pZ3JhdGlvbi9leGVjLmMNCisrKyBiL21pZ3JhdGlvbi9l
eGVjLmMNCkBAIC0yNyw3ICsyNyw2IEBADQogI2luY2x1ZGUgInFlbXUvY3V0aWxzLmgiDQogDQog
I2lmZGVmIFdJTjMyDQotY29uc3QgY2hhciAqZXhlY19nZXRfY21kX3BhdGgodm9pZCk7DQogY29u
c3QgY2hhciAqZXhlY19nZXRfY21kX3BhdGgodm9pZCkNCiB7DQogICAgIGdfYXV0b2ZyZWUgY2hh
ciAqZGV0ZWN0ZWRfcGF0aCA9IGdfbmV3KGNoYXIsIE1BWF9QQVRIKTsNCmRpZmYgLS1naXQgYS9t
aWdyYXRpb24vZXhlYy5oIGIvbWlncmF0aW9uL2V4ZWMuaA0KaW5kZXggYjIxMGZmZGU3YS4uNzM2
Y2Q3MTAyOCAxMDA2NDQNCi0tLSBhL21pZ3JhdGlvbi9leGVjLmgNCisrKyBiL21pZ3JhdGlvbi9l
eGVjLmgNCkBAIC0xOSw2ICsxOSwxMCBAQA0KIA0KICNpZm5kZWYgUUVNVV9NSUdSQVRJT05fRVhF
Q19IDQogI2RlZmluZSBRRU1VX01JR1JBVElPTl9FWEVDX0gNCisNCisjaWZkZWYgV0lOMzINCitj
b25zdCBjaGFyICpleGVjX2dldF9jbWRfcGF0aCh2b2lkKTsNCisjZW5kaWYNCiB2b2lkIGV4ZWNf
c3RhcnRfaW5jb21pbmdfbWlncmF0aW9uKGNvbnN0IGNoYXIgKmhvc3RfcG9ydCwgRXJyb3IgKipl
cnJwKTsNCiANCiB2b2lkIGV4ZWNfc3RhcnRfb3V0Z29pbmdfbWlncmF0aW9uKE1pZ3JhdGlvblN0
YXRlICpzLCBjb25zdCBjaGFyICpob3N0X3BvcnQsDQpkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL21p
Z3JhdGlvbi5jIGIvbWlncmF0aW9uL21pZ3JhdGlvbi5jDQppbmRleCA5MWJiYTYzMGE4Li41YjNi
ZTc2N2YwIDEwMDY0NA0KLS0tIGEvbWlncmF0aW9uL21pZ3JhdGlvbi5jDQorKysgYi9taWdyYXRp
b24vbWlncmF0aW9uLmMNCkBAIC02NCw2ICs2NCw3IEBADQogI2luY2x1ZGUgInlhbmtfZnVuY3Rp
b25zLmgiDQogI2luY2x1ZGUgInN5c2VtdS9xdGVzdC5oIg0KICNpbmNsdWRlICJvcHRpb25zLmgi
DQorI2luY2x1ZGUgInFlbXUvc29ja2V0cy5oIg0KIA0KIHN0YXRpYyBOb3RpZmllckxpc3QgbWln
cmF0aW9uX3N0YXRlX25vdGlmaWVycyA9DQogICAgIE5PVElGSUVSX0xJU1RfSU5JVElBTElaRVIo
bWlncmF0aW9uX3N0YXRlX25vdGlmaWVycyk7DQpAQCAtNDIxLDE1ICs0MjIsNjQgQEAgdm9pZCBt
aWdyYXRlX2FkZF9hZGRyZXNzKFNvY2tldEFkZHJlc3MgKmFkZHJlc3MpDQogICAgICAgICAgICAg
ICAgICAgICAgIFFBUElfQ0xPTkUoU29ja2V0QWRkcmVzcywgYWRkcmVzcykpOw0KIH0NCiANCitz
dGF0aWMgYm9vbCBtaWdyYXRlX3VyaV9wYXJzZShjb25zdCBjaGFyICp1cmksDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgTWlncmF0aW9uQWRkcmVzcyAqKmNoYW5uZWwsDQorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KK3sNCisgICAgZ19hdXRvcHRy
KE1pZ3JhdGlvbkFkZHJlc3MpIGFkZHIgPSBnX25ldzAoTWlncmF0aW9uQWRkcmVzcywgMSk7DQor
ICAgIFNvY2tldEFkZHJlc3MgKnNhZGRyID0gJmFkZHItPnUuc29ja2V0Ow0KKyAgICBJbmV0U29j
a2V0QWRkcmVzcyAqaXNvY2sgPSAmYWRkci0+dS5yZG1hOw0KKyAgICBzdHJMaXN0ICoqdGFpbCA9
ICZhZGRyLT51LmV4ZWMuYXJnczsNCisNCisgICAgaWYgKHN0cnN0YXJ0KHVyaSwgImV4ZWM6Iiwg
TlVMTCkpIHsNCisgICAgICAgIGFkZHItPnRyYW5zcG9ydCA9IE1JR1JBVElPTl9BRERSRVNTX1RZ
UEVfRVhFQzsNCisjaWZkZWYgV0lOMzINCisgICAgICAgIFFBUElfTElTVF9BUFBFTkQodGFpbCwg
Z19zdHJkdXAoZXhlY19nZXRfY21kX3BhdGgoKSkpOw0KKyAgICAgICAgUUFQSV9MSVNUX0FQUEVO
RCh0YWlsLCBnX3N0cmR1cCgiL2MiKSk7DQorI2Vsc2UNCisgICAgICAgIFFBUElfTElTVF9BUFBF
TkQodGFpbCwgZ19zdHJkdXAoIi9iaW4vc2giKSk7DQorICAgICAgICBRQVBJX0xJU1RfQVBQRU5E
KHRhaWwsIGdfc3RyZHVwKCItYyIpKTsNCisjZW5kaWYNCisgICAgICAgIFFBUElfTElTVF9BUFBF
TkQodGFpbCwgZ19zdHJkdXAodXJpICsgc3RybGVuKCJleGVjOiIpKSk7DQorICAgIH0gZWxzZSBp
ZiAoc3Ryc3RhcnQodXJpLCAicmRtYToiLCBOVUxMKSkgew0KKyAgICAgICAgaWYgKGluZXRfcGFy
c2UoaXNvY2ssIHVyaSArIHN0cmxlbigicmRtYToiKSwgZXJycCkpIHsNCisgICAgICAgICAgICBx
YXBpX2ZyZWVfSW5ldFNvY2tldEFkZHJlc3MoaXNvY2spOw0KKyAgICAgICAgICAgIHJldHVybiBm
YWxzZTsNCisgICAgICAgIH0NCisgICAgICAgIGFkZHItPnRyYW5zcG9ydCA9IE1JR1JBVElPTl9B
RERSRVNTX1RZUEVfUkRNQTsNCisgICAgfSBlbHNlIGlmIChzdHJzdGFydCh1cmksICJ0Y3A6Iiwg
TlVMTCkgfHwNCisgICAgICAgICAgICAgICAgc3Ryc3RhcnQodXJpLCAidW5peDoiLCBOVUxMKSB8
fA0KKyAgICAgICAgICAgICAgICBzdHJzdGFydCh1cmksICJ2c29jazoiLCBOVUxMKSB8fA0KKyAg
ICAgICAgICAgICAgICBzdHJzdGFydCh1cmksICJmZDoiLCBOVUxMKSkgew0KKyAgICAgICAgYWRk
ci0+dHJhbnNwb3J0ID0gTUlHUkFUSU9OX0FERFJFU1NfVFlQRV9TT0NLRVQ7DQorICAgICAgICBz
YWRkciA9IHNvY2tldF9wYXJzZSh1cmksIGVycnApOw0KKyAgICAgICAgaWYgKCFzYWRkcikgew0K
KyAgICAgICAgICAgIHFhcGlfZnJlZV9Tb2NrZXRBZGRyZXNzKHNhZGRyKTsNCisgICAgICAgICAg
ICByZXR1cm4gZmFsc2U7DQorICAgICAgICB9DQorICAgIH0gZWxzZSB7DQorICAgICAgICBlcnJv
cl9zZXRnKGVycnAsICJ1bmtub3duIG1pZ3JhdGlvbiBwcm90b2NvbDogJXMiLCB1cmkpOw0KKyAg
ICAgICAgcmV0dXJuIGZhbHNlOw0KKyAgICB9DQorDQorICAgICpjaGFubmVsID0gYWRkcjsNCisg
ICAgcmV0dXJuIHRydWU7DQorfQ0KKw0KIHN0YXRpYyB2b2lkIHFlbXVfc3RhcnRfaW5jb21pbmdf
bWlncmF0aW9uKGNvbnN0IGNoYXIgKnVyaSwgRXJyb3IgKiplcnJwKQ0KIHsNCiAgICAgY29uc3Qg
Y2hhciAqcCA9IE5VTEw7DQorICAgIGdfYXV0b3B0cihNaWdyYXRpb25BZGRyZXNzKSBjaGFubmVs
ID0gZ19uZXcwKE1pZ3JhdGlvbkFkZHJlc3MsIDEpOw0KIA0KICAgICAvKiBVUkkgaXMgbm90IHN1
aXRhYmxlIGZvciBtaWdyYXRpb24/ICovDQogICAgIGlmICghbWlncmF0aW9uX2NoYW5uZWxzX2Fu
ZF91cmlfY29tcGF0aWJsZSh1cmksIGVycnApKSB7DQogICAgICAgICByZXR1cm47DQogICAgIH0N
CiANCisgICAgaWYgKHVyaSAmJiAhbWlncmF0ZV91cmlfcGFyc2UodXJpLCAmY2hhbm5lbCwgZXJy
cCkpIHsNCisgICAgICAgIHJldHVybjsNCisgICAgfQ0KKw0KICAgICBxYXBpX2V2ZW50X3NlbmRf
bWlncmF0aW9uKE1JR1JBVElPTl9TVEFUVVNfU0VUVVApOw0KICAgICBpZiAoc3Ryc3RhcnQodXJp
LCAidGNwOiIsICZwKSB8fA0KICAgICAgICAgc3Ryc3RhcnQodXJpLCAidW5peDoiLCBOVUxMKSB8
fA0KQEAgLTE2NDEsMTIgKzE2OTEsMTcgQEAgdm9pZCBxbXBfbWlncmF0ZShjb25zdCBjaGFyICp1
cmksIGJvb2wgaGFzX2JsaywgYm9vbCBibGssDQogICAgIEVycm9yICpsb2NhbF9lcnIgPSBOVUxM
Ow0KICAgICBNaWdyYXRpb25TdGF0ZSAqcyA9IG1pZ3JhdGVfZ2V0X2N1cnJlbnQoKTsNCiAgICAg
Y29uc3QgY2hhciAqcCA9IE5VTEw7DQorICAgIGdfYXV0b3B0cihNaWdyYXRpb25BZGRyZXNzKSBj
aGFubmVsID0gZ19uZXcwKE1pZ3JhdGlvbkFkZHJlc3MsIDEpOw0KIA0KICAgICAvKiBVUkkgaXMg
bm90IHN1aXRhYmxlIGZvciBtaWdyYXRpb24/ICovDQogICAgIGlmICghbWlncmF0aW9uX2NoYW5u
ZWxzX2FuZF91cmlfY29tcGF0aWJsZSh1cmksIGVycnApKSB7DQogICAgICAgICByZXR1cm47DQog
ICAgIH0NCiANCisgICAgaWYgKCFtaWdyYXRlX3VyaV9wYXJzZSh1cmksICZjaGFubmVsLCBlcnJw
KSkgew0KKyAgICAgICAgcmV0dXJuOw0KKyAgICB9DQorDQogICAgIHJlc3VtZV9yZXF1ZXN0ZWQg
PSBoYXNfcmVzdW1lICYmIHJlc3VtZTsNCiAgICAgaWYgKCFtaWdyYXRlX3ByZXBhcmUocywgaGFz
X2JsayAmJiBibGssIGhhc19pbmMgJiYgaW5jLA0KICAgICAgICAgICAgICAgICAgICAgICAgICBy
ZXN1bWVfcmVxdWVzdGVkLCBlcnJwKSkgew0KLS0gDQoyLjIyLjMNCg0K

