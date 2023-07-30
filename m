Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D8476890B
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 00:14:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQEfg-0001o2-Sl; Sun, 30 Jul 2023 18:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qQEff-0001nb-4o; Sun, 30 Jul 2023 18:13:51 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qQEfd-0007Ul-E5; Sun, 30 Jul 2023 18:13:50 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36ULA1xw016109; Sun, 30 Jul 2023 15:13:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=hvLseTS4HAn4Au2I07nqtZou3AfYA8GpW7q0+e
 mJxlA=; b=lUEyFij9NB+vHmKZjBBTNX7f5+fMnYb22swre2OdYNPdS3kD7xJIiN
 5qgCZwDZhysS5/CObzoVihGPJ4bT1yANyfuXnbYXabnlDVkjCgiyRg+mwc8vw278
 vGSn6KJfZp3MUYMwUM8bGx2N7QgU6fBIIbx5YJCm1Sexmh1AXGXDn8tHx91gGuOK
 jaZc8gt2jGdMqMSrDr8uTUlrnCvvu2VkeAQxqsgPhCSPniV2bpNbUESDLsYEu8gF
 JTHQ+Xedq4fh0jbRLYs/MBTxtC8fTqzpPy+nG5dYILZTP5KwPDZQ9pYp8mU3sGXB
 FCxt1nTfhfhxXaIQVqApwpz5sILMu+oA==
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3s529x9nvq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 30 Jul 2023 15:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSzlGQxYjcn11fD2OHyBtujtXPHjYVBsHcX+IKQpeAvE5NvbScPEPj9czyXSvMHux3hpAZdjNLkJ56ZvoeCcCCrbrUMAaKqLCFlCCnrfpj1f+Jxlkvoi4ho8dM88fu1R98ppel1kniEsv5HT0bzKLa8I+gHzUgGFWKCxDYuA7HvQjWjOubRAZAp6n1xPGrPhFzo3Sdo+0akx0Ieegdr2wWA6Om7S3+AR/rKz0MQOIFhfIwIqxcRMcWFx+ckWx1bshc9k2fOklGAst2L60UpyHeqsxT4Lpk0R7IXHK3oI24zGBQqmO7K7U+yv7SgvMb1elN/KctvckNMPHeNsqp+ytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvLseTS4HAn4Au2I07nqtZou3AfYA8GpW7q0+emJxlA=;
 b=mtKLA4/09mlxO1/9ABAU9JphAz1iiyYrMb0FfEqCAbto29YDfu3ex+odeWDMN+wsdVGsjim6UyY8Il5BmE2PPAazJWXpsQ24jWhYEWbkKz3hR1E17bWZYr10H2ePfVqUBy3gfn+yqo+5MKHjLlPFmw8rNgM2Pkh8Sc1OazYxHWtRjbKihnYY2ZGnAZjErHS+bsEUtfzao0ZxuuaNPC4FFm5hl3VL0VHR47WPpPT9jysMz0xYrZxV/xpmpqzJwYjqczMJnCHl90I6Len4z1x6FdpfsTBWewYNBSIPI3NHbBi68Z53bC5bznZkbHwkV5ZRt3AWFNzazRSZ2Y5ANCfpyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvLseTS4HAn4Au2I07nqtZou3AfYA8GpW7q0+emJxlA=;
 b=LlN75tlDW9i8Q/pAFqpZMCGuuNFOyAZkbfGCiNUiW7BUUIXNXVptTkVNKIsEw2qXFxlvWj0Agj+v6kvDWnNNh4/NCVg5QlOBoADdCwNLcbMNDFbQQvMywfyDAYT2x3P0Co0aH7jilVntVDRxGxj7Imu8QCVj1oMiMCOO3nIKqnzFniYqGcVNR0P5BChK9gC+PsNZ3ZYafkeAsrV0+TntRneOgOVPTOMiFV7QCMSc6WK+k1bbkFde8a0a3en4x5fgeAFnjChbCGqxnneLK1uULGdq5vbCbiZeLkLA1kgihzEh8PnLbae08exuua6/XsAHCrRjISx844ZDL+QRQudLqQ==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by IA1PR02MB9419.namprd02.prod.outlook.com (2603:10b6:208:3f4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Sun, 30 Jul
 2023 22:13:31 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::6abe:dbe0:dc92:9239]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::6abe:dbe0:dc92:9239%3]) with mapi id 15.20.6652.004; Sun, 30 Jul 2023
 22:13:31 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Li Feng <fengli@smartx.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam
 Zheng <fam@euphon.net>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "open
 list:Block layer core" <qemu-block@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 2/4] vhost-user-common: send get_inflight_fd once
Thread-Topic: [PATCH v2 2/4] vhost-user-common: send get_inflight_fd once
Thread-Index: AQHZvuTf0tONfWzQHEWFimKSn57JOK/OtNUAgAAdVACABBYxAA==
Date: Sun, 30 Jul 2023 22:13:30 +0000
Message-ID: <70D32B59-8B40-45E2-AFEC-0E3395867D15@nutanix.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230725104256.4861-1-fengli@smartx.com>
 <20230725104256.4861-3-fengli@smartx.com>
 <20230728020156-mutt-send-email-mst@kernel.org>
 <09BB8CEC-26F4-4FC5-A2DB-479FCD5F0548@smartx.com>
In-Reply-To: <09BB8CEC-26F4-4FC5-A2DB-479FCD5F0548@smartx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|IA1PR02MB9419:EE_
x-ms-office365-filtering-correlation-id: 4295e2e2-6152-4a0f-a91e-08db914a3541
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M5t0oBcsvbq34z5I8jEU175Tocr7ayFNIGg55GnFoKG5ri/9MdqZMSxFjTMnwP8DCOBSf4AJ5tNbD2c2Xyuwbh/Wa2jdGCx0dRDHNGFhwI+zK/cIQ3Aj+VdOnVOooU8zUfDJadY2c/hPoIE0VAkg5V0iraIruijuzDA8AKl+6vyhjKP4Ea0JQnVezIZw7F9veoca41pTiCVOzVl/qSjd9V4+6jLGu8g0erwmb3fHJCyDX++7S/q/LzjOofLtZCJlVMxufDmvOQF83KDEhc3I70QawVb1jpPYMGoUlEGkPEDtul2exIkHT1VRyAHG24o3CiyH3PS+mgl+I7xmgJC4DyDks3FzQeB1M+5u1vd6JGhQWSUbzzn5qGP3jEU30aqbi4G6UCzhsGdW35GHkZpkhDPobVCnI+gO4WkM4JabzoI0IOz+qoJqFj0kS1er9UuxGFMGFV53T1I4ZnXuJVgqnABCz7zcuJOaiIwnULnnKl52EDCuNR+UQB+QDM9K+5Bp8wCkdgsQed1dVRVo1UMKsheCSCEyFyI/OOIDcBwstGctXuzDhWqxp6KzJIp+Bl88UaFLSDozA345tmHf4N3PWch6y9WLY7QeTRg3UX2Vf05lXjS/cmozVyL5C64nKF9I+GV+//FjyyNBKR63SGTawA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199021)(71200400001)(6486002)(478600001)(83380400001)(53546011)(6506007)(26005)(6512007)(64756008)(6916009)(4326008)(66476007)(66446008)(122000001)(54906003)(66556008)(66946007)(76116006)(91956017)(186003)(38100700002)(2616005)(7416002)(38070700005)(316002)(8936002)(8676002)(33656002)(2906002)(41300700001)(86362001)(44832011)(5660300002)(36756003)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGZzMkMwcHlVdUhaUFA4TXlHaW5MV2ttL2dueXAraUxvbm9IZXNiV2JFUXZv?=
 =?utf-8?B?ZGIxNTVmVkc3VU9VdlV1WWdHK2xZNy8yem1sUGZBMllFaHNHaFFiN2xNNy9q?=
 =?utf-8?B?enVsbnlvbVdCa2Y4TkdhTVQ0NWpjMUVZeTFYWTZrdFpkVXpyWlVhQ2FGNkVC?=
 =?utf-8?B?Zk9Oak90UDNZNjYxeDZIZjBUVXIzTHg0ZHRFUldwcktjeTA2Z0ZBS1BXK2JG?=
 =?utf-8?B?VWQ4ZHUvODgzTHVLMklJU3V4WFYvVnkrV09KNGtVTUd4STlUZGVBNFA2NVJu?=
 =?utf-8?B?TGJjMzdXZWppREZQZG1yOVo2d1ZLNnVRcEVHd2xpdnJmcmlaK1dmbDA0dmxG?=
 =?utf-8?B?bDU2UWlNV3NtaXhhUVYyMHBxWWdRUUUwbFZtSjdoZlNwZ3hhZ1BydGprRENx?=
 =?utf-8?B?UVFGNlZmRVFacnZiSFVabU5FZ0Yzb2FPREJLNHVCcTg4N0k3QnlsQWUyeEho?=
 =?utf-8?B?Zmd2NUdwVVFERUE0TjNjM0tvMm9PVHoycGt6WmFDTTFLYkhCTmdiZHV1WnZz?=
 =?utf-8?B?c1hxbFR4NnQyZHdmc2lKb2RoMUc4eU1OSTVMSHBaNjlsdVc2RWJtRjk0QWlF?=
 =?utf-8?B?L0U2Uy8yZURDdTQ2d2dSQWVaRExuQjJaV2ZYOVpaNVRReHJpa2k4ajJqcGc0?=
 =?utf-8?B?dVBuQ21NSXJNSzA2aGhENVRRaG9QZFB4WDZwS1V1RnNrN2w1VGlIazFuMk5I?=
 =?utf-8?B?MUtjVUt4K2VqSkI2NW0zQ0ZyTXMyZDFvbTk5QnpYendkUm9BWjMxaGFpTUUv?=
 =?utf-8?B?OElUNndzUk8zUFo4R3VZMGgrR1UzY3laTS91M0NTSFVLRjllTjdhQ2pZUkRC?=
 =?utf-8?B?Nk5iRGNjczZjbGYvZXVTc0F0UTZXclM3NHg5VlFVaVNsUVhWaXcvSjh1V1pV?=
 =?utf-8?B?V3d4TS9LWkdNSDl1c2N6SXdwMFBrWU9IZnA0c3d6MWk1ZnpEVk14eis5ZjFH?=
 =?utf-8?B?dzcrVDdXODcxN0trck15ZnpIMDh1RUl2YnNER0x1eXFVcERtcWFlVUYvc01T?=
 =?utf-8?B?ZzJhNmRldDZySm5YTEFiUW55b21yOHIwSTJSSVlhQzlhODZ4dEZZUXpHVUdm?=
 =?utf-8?B?ZGcxc3FZUzBlTTlHZk0xTGdjYURGWERoSSttTk9JMnUvdDUwY09zMHI4TGti?=
 =?utf-8?B?UWhDNkdqTEhoNlRicXp4YktubjFYMC9qVWQxbTRHYVEzaFZPMG4yQ1lpeUJG?=
 =?utf-8?B?M1FXRklMVGlxYVNhOHpGbDRFV2hhUER1SzlxL2tqMGNSMjNVcFlUZnlTZzJq?=
 =?utf-8?B?MEwxdEMrOXBUT2wvWUN4d2lEWk9GT3RGSE1aN3ZLSWcxRllXem9TZUdDZzVH?=
 =?utf-8?B?a0E4ZG14QjUyQzFFM0RoU2h0R01FdG5KRXNTZkM0alVjQjBoSlBqd2tTYW1L?=
 =?utf-8?B?RURqS05hSFRXcE0wZFhsNEE5MS9HN3pOdWZ2Q3lRak13ZGFhOE5Jak1mSlFp?=
 =?utf-8?B?QXlKajg1RzEreFdSNGJ2YUhEcEdSTjNDcmJxOUpQbm9Od2c3aWZLK3NyN0Zy?=
 =?utf-8?B?VnVySGZFMWUwMUhzekZPcFo4MWZmRXMvWEhHbm4vV0pxQXQzdTRRSit1NE9q?=
 =?utf-8?B?c3N2ZXZMRHllcStsV2xWdzlSOG5ua0NTREM5N0FmSE4wSXUwZWpjL1BUbU5q?=
 =?utf-8?B?WHQ0UDNPS21kNkN4ZThnK2dZMlhXelMzNkpsR0xnTUYxZ21KakFRWnQyNHdx?=
 =?utf-8?B?bDAvL05VVFBDVnBrTzl3K0tLZTIrK2lQL2tVd2RhNWVRMTZHSFhGOCtOUXkr?=
 =?utf-8?B?Q1VrdnhKTE5SYThuTFhKZndUSEx1L1NKczZmeFIydW0wMzE3ZGhsdzFtUWF3?=
 =?utf-8?B?WWp3VFZFSm5KRUF5dUIxbHhHZG1rRVBuRFFPckVTU0ZWUXk0d2hXVkZHUFNs?=
 =?utf-8?B?aXVqRndPQlZlaFpvcHZmc1YvRnJXelIwRGRhUFpXb29ad3JFQi9QOFhVbmxw?=
 =?utf-8?B?cER0NTlCTGZLbFdqcXdLZE9aU3FXNEhnQkx2SitnaFpUdjlvOTlnSVpIZlpO?=
 =?utf-8?B?WENvSDQ5Z0pjbmNtNUV0VFlNR2JzbDdEdWs4QlQ2VlJNb3dZYW5sVCtnd2hG?=
 =?utf-8?B?K3pFdVhkRTQwMFFhWDlOWFc5bFh3bVUvMEcxZUJXT25qblI2WmwrYjFYNGk4?=
 =?utf-8?B?eldyOGRJYkZMbVh0WTBhc3dLaS9acFVVeFZQeWZFcFQrOGhOSmdYLy9peU5v?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CA86F3F33342146B81402F60767F873@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4295e2e2-6152-4a0f-a91e-08db914a3541
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2023 22:13:31.0074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 19YpYbPXXXFrVTKPcHseIHXDgZgwBjb4ALSAPZwbq0sLSDXHNthUheYocpi2WKlfWJZQpok9dtdkgS9zEx9zW/CGblhSMywLSvu6/lFUga8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9419
X-Proofpoint-GUID: X2Jd0E-6Xvhsk9K95yJTYT3d8VGczwtY
X-Proofpoint-ORIG-GUID: X2Jd0E-6Xvhsk9K95yJTYT3d8VGczwtY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=raphael.norwitz@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

DQo+IE9uIEp1bCAyOCwgMjAyMywgYXQgMzo0OSBBTSwgTGkgRmVuZyA8ZmVuZ2xpQHNtYXJ0eC5j
b20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPj4gMjAyM+W5tDfmnIgyOOaXpSDkuIvljYgyOjA077yM
TWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4g5YaZ6YGT77yaDQo+PiANCj4+IE9u
IFR1ZSwgSnVsIDI1LCAyMDIzIGF0IDA2OjQyOjQ1UE0gKzA4MDAsIExpIEZlbmcgd3JvdGU6DQo+
Pj4gR2V0X2luZmxpZ2h0X2ZkIGlzIHNlbnQgb25seSBvbmNlLiBXaGVuIHJlY29ubmVjdGluZyB0
byB0aGUgYmFja2VuZCwNCj4+PiBxZW11IHNlbnQgc2V0X2luZmxpZ2h0X2ZkIHRvIHRoZSBiYWNr
ZW5kLg0KPj4gDQo+PiBJIGRvbid0IHVuZGVyc3RhbmQgd2hhdCB5b3UgYXJlIHRyeWluZyB0byBz
YXkgaGVyZS4NCj4+IFNob3VsZCBiZToNCj4+IEN1cnJlbnRseSBBQkNELiBUaGlzIGlzIHdyb25n
L3VubmVjZXNzYXJ5IGJlY2F1c2UgRUZHLiBUaGlzIHBhdGNoIEhJSi4NCj4gDQo+IFRoYW5rcywg
SSB3aWxsIHJlb3JnYW5pemUgdGhlIGNvbW1pdCBtZXNzYWdlIGluIHYzLg0KPj4gDQo+Pj4gU2ln
bmVkLW9mZi1ieTogTGkgRmVuZyA8ZmVuZ2xpQHNtYXJ0eC5jb20+DQo+Pj4gLS0tDQo+Pj4gaHcv
c2NzaS92aG9zdC1zY3NpLWNvbW1vbi5jIHwgMzcgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPj4+IDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxOSBkZWxl
dGlvbnMoLSkNCj4+PiANCj4+PiBkaWZmIC0tZ2l0IGEvaHcvc2NzaS92aG9zdC1zY3NpLWNvbW1v
bi5jIGIvaHcvc2NzaS92aG9zdC1zY3NpLWNvbW1vbi5jDQo+Pj4gaW5kZXggYTA2ZjAxYWYyNi4u
NjY0YWRiMTViNCAxMDA2NDQNCj4+PiAtLS0gYS9ody9zY3NpL3Zob3N0LXNjc2ktY29tbW9uLmMN
Cj4+PiArKysgYi9ody9zY3NpL3Zob3N0LXNjc2ktY29tbW9uLmMNCj4+PiBAQCAtNTIsMjAgKzUy
LDI4IEBAIGludCB2aG9zdF9zY3NpX2NvbW1vbl9zdGFydChWSG9zdFNDU0lDb21tb24gKnZzYykN
Cj4+PiANCj4+PiAgICAgdnNjLT5kZXYuYWNrZWRfZmVhdHVyZXMgPSB2ZGV2LT5ndWVzdF9mZWF0
dXJlczsNCj4+PiANCj4+PiAtICAgIGFzc2VydCh2c2MtPmluZmxpZ2h0ID09IE5VTEwpOw0KPj4+
IC0gICAgdnNjLT5pbmZsaWdodCA9IGdfbmV3MChzdHJ1Y3Qgdmhvc3RfaW5mbGlnaHQsIDEpOw0K
Pj4+IC0gICAgcmV0ID0gdmhvc3RfZGV2X2dldF9pbmZsaWdodCgmdnNjLT5kZXYsDQo+Pj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZzLT5jb25mLnZpcnRxdWV1ZV9zaXplLA0K
Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2c2MtPmluZmxpZ2h0KTsNCj4+
PiArICAgIHJldCA9IHZob3N0X2Rldl9wcmVwYXJlX2luZmxpZ2h0KCZ2c2MtPmRldiwgdmRldik7
DQo+Pj4gICAgIGlmIChyZXQgPCAwKSB7DQo+Pj4gLSAgICAgICAgZXJyb3JfcmVwb3J0KCJFcnJv
ciBnZXQgaW5mbGlnaHQ6ICVkIiwgLXJldCk7DQo+Pj4gKyAgICAgICAgZXJyb3JfcmVwb3J0KCJF
cnJvciBzZXR0aW5nIGluZmxpZ2h0IGZvcm1hdDogJWQiLCAtcmV0KTsNCj4+PiAgICAgICAgIGdv
dG8gZXJyX2d1ZXN0X25vdGlmaWVyczsNCj4+PiAgICAgfQ0KPj4+IA0KPj4+IC0gICAgcmV0ID0g
dmhvc3RfZGV2X3NldF9pbmZsaWdodCgmdnNjLT5kZXYsIHZzYy0+aW5mbGlnaHQpOw0KPj4+IC0g
ICAgaWYgKHJldCA8IDApIHsNCj4+PiAtICAgICAgICBlcnJvcl9yZXBvcnQoIkVycm9yIHNldCBp
bmZsaWdodDogJWQiLCAtcmV0KTsNCj4+PiAtICAgICAgICBnb3RvIGVycl9ndWVzdF9ub3RpZmll
cnM7DQo+Pj4gKyAgICBpZiAodnNjLT5pbmZsaWdodCkgew0KPj4+ICsgICAgICAgIGlmICghdnNj
LT5pbmZsaWdodC0+YWRkcikgew0KPj4+ICsgICAgICAgICAgICByZXQgPSB2aG9zdF9kZXZfZ2V0
X2luZmxpZ2h0KCZ2c2MtPmRldiwNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHZzLT5jb25mLnZpcnRxdWV1ZV9zaXplLA0KPj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdnNjLT5pbmZsaWdodCk7DQo+Pj4gKyAgICAgICAgICAg
IGlmIChyZXQgPCAwKSB7DQo+Pj4gKyAgICAgICAgICAgICAgICBlcnJvcl9yZXBvcnQoIkVycm9y
IGdldCBpbmZsaWdodDogJWQiLCAtcmV0KTsNCj4+IA0KPj4gQXMgbG9uZyBhcyB5b3UgYXJlIGZp
eGluZyB0aGlzIC0gc2hvdWxkIGJlICJnZXR0aW5nIGluZmxpZ2h04oCdLg0KPiBJIHdpbGwgZml4
IGl0IGluIHYzLg0KPj4gDQo+Pj4gKyAgICAgICAgICAgICAgICBnb3RvIGVycl9ndWVzdF9ub3Rp
ZmllcnM7DQo+Pj4gKyAgICAgICAgICAgIH0NCj4+PiArICAgICAgICB9DQo+Pj4gKw0KDQpMb29r
cyBsaWtlIHlvdSByZXdvcmtlZCB0aGlzIGEgYml0IHNvIHRvIGF2b2lkIGEgcG90ZW50aWFsIGNy
YXNoIGlmIHZzYy0+aW5mbGlnaHQgaXMgTlVMTA0KDQpTaG91bGQgd2UgZml4IGl0IGZvciB2aG9z
dC11c2VyLWJsayB0b28/DQoNCj4+PiArICAgICAgICByZXQgPSB2aG9zdF9kZXZfc2V0X2luZmxp
Z2h0KCZ2c2MtPmRldiwgdnNjLT5pbmZsaWdodCk7DQo+Pj4gKyAgICAgICAgaWYgKHJldCA8IDAp
IHsNCj4+PiArICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCJFcnJvciBzZXQgaW5mbGlnaHQ6ICVk
IiwgLXJldCk7DQo+Pj4gKyAgICAgICAgICAgIGdvdG8gZXJyX2d1ZXN0X25vdGlmaWVyczsNCj4+
PiArICAgICAgICB9DQo+Pj4gICAgIH0NCj4+PiANCj4+PiAgICAgcmV0ID0gdmhvc3RfZGV2X3N0
YXJ0KCZ2c2MtPmRldiwgdmRldiwgdHJ1ZSk7DQo+Pj4gQEAgLTg1LDkgKzkzLDYgQEAgaW50IHZo
b3N0X3Njc2lfY29tbW9uX3N0YXJ0KFZIb3N0U0NTSUNvbW1vbiAqdnNjKQ0KPj4+ICAgICByZXR1
cm4gcmV0Ow0KPj4+IA0KPj4+IGVycl9ndWVzdF9ub3RpZmllcnM6DQo+Pj4gLSAgICBnX2ZyZWUo
dnNjLT5pbmZsaWdodCk7DQo+Pj4gLSAgICB2c2MtPmluZmxpZ2h0ID0gTlVMTDsNCj4+PiAtDQo+
Pj4gICAgIGstPnNldF9ndWVzdF9ub3RpZmllcnMocWJ1cy0+cGFyZW50LCB2c2MtPmRldi5udnFz
LCBmYWxzZSk7DQo+Pj4gZXJyX2hvc3Rfbm90aWZpZXJzOg0KPj4+ICAgICB2aG9zdF9kZXZfZGlz
YWJsZV9ub3RpZmllcnMoJnZzYy0+ZGV2LCB2ZGV2KTsNCj4+PiBAQCAtMTExLDEyICsxMTYsNiBA
QCB2b2lkIHZob3N0X3Njc2lfY29tbW9uX3N0b3AoVkhvc3RTQ1NJQ29tbW9uICp2c2MpDQo+Pj4g
ICAgIH0NCj4+PiAgICAgYXNzZXJ0KHJldCA+PSAwKTsNCj4+PiANCg0KQXMgSSBzYWlkIGJlZm9y
ZSwgSSB0aGluayB0aGlzIGludHJvZHVjZXMgYSBsZWFrLg0KDQo+Pj4gLSAgICBpZiAodnNjLT5p
bmZsaWdodCkgew0KPj4+IC0gICAgICAgIHZob3N0X2Rldl9mcmVlX2luZmxpZ2h0KHZzYy0+aW5m
bGlnaHQpOw0KPj4+IC0gICAgICAgIGdfZnJlZSh2c2MtPmluZmxpZ2h0KTsNCj4+PiAtICAgICAg
ICB2c2MtPmluZmxpZ2h0ID0gTlVMTDsNCj4+PiAtICAgIH0NCj4+PiAtDQo+Pj4gICAgIHZob3N0
X2Rldl9kaXNhYmxlX25vdGlmaWVycygmdnNjLT5kZXYsIHZkZXYpOw0KPj4+IH0NCj4+PiANCj4+
PiAtLSANCj4+PiAyLjQxLjANCg0K

