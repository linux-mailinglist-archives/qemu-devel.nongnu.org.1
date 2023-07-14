Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 121DB753B47
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 14:46:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKIBW-0004TW-QP; Fri, 14 Jul 2023 08:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1qKIBQ-0004Sb-51; Fri, 14 Jul 2023 08:46:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1qKIBN-000856-Fy; Fri, 14 Jul 2023 08:46:03 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36ECAb9S028630; Fri, 14 Jul 2023 12:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=sy6igTv0M4G4lUQSIqK3IgAe2aHMwHrZgKTdJI2/P9Q=;
 b=FjF5ZZkG1pKfzqUFchpMgVBEgbVwTwdCLia+I0EXmzjmeDyWuCuimxh2+gkbYDArTlTu
 bxFI7wY3efJ1Zb3RRHK0ScPM8CPk1C8jkAfr9McOuBVUzu7fmpxOZv5IDzy20GnGNJqZ
 ZBkIxtpJW8qO/5cWQPOzSVF9wVy0ZAe7NOnAoQRJ8qtJK9JTLsVjSy5+JvFXFA8Bwlf0
 aT+en0gpg1eb6rbykovSuil/HiBiCCzz/YXnkLmGzGx6urIroJ4h2gdhAFG29kP6r852
 ip7GgnSF7CiwfZPCbXMqXS4c/59bH5mvNAdfpQKniNj7rO5iMJPVSDruh5iH/THUfVN3 Mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rtq8ascew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jul 2023 12:45:43 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36ECUUNr001974; Fri, 14 Jul 2023 12:45:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rtpvx3g2d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jul 2023 12:45:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/+SudyIc5d8MB5kyz828ep5CAV+FYDqHBAlwpThEj71qN1e9EjeJY3RuiJeNd266/2i5RvTxTfvxhCSsyE8Gl3iz/d8htCDum7qJRlhh0cxcBt+l8H6ILzkGuB/6bTEtFnKKgGFIe5Rg02rh7+NYURbXGIYwtjTyCXQz4NNqZGUyaD7cTcKI3WGBlMQ7eA1UMHFDbgwY4sfLeGxUIl26a7R0DyLMIaxLEEl+spRspgwx5LNkDHm4si3+14frDNfF5p8IiX8BtO0i2KN+/iCsxxbp5Q/NlrRW16HnmfRnQc3vNVykE0R5Qg+5yrrHAeTKV6fVXlQLfG+zxAnjQMVow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sy6igTv0M4G4lUQSIqK3IgAe2aHMwHrZgKTdJI2/P9Q=;
 b=ImQS40adYwH2nUFpKGyOvrabtM2aJ7Nnqne3c+6T8PbBMYN6X3Ce7iUwGiTOy9nbuPwBTl8IhxP0Vf6coFBpi+NLW4Vbwc6qDOmtBKBPytOPN8EdkNonhZ6lnZT+KPSTc+Wvv5Mw+1716UrN8+4cZKChztbmVmOhIWSSEudUlxPC57DrY434t5pmG/3Str5L+qee88bY3g669aGt3/+RV2ggmAV/M6ijgVKeq3BVPtUr2jQA4OrUCO/WkVzVtIGn9uPWCEdrO2NXdAHxijLercR2CPppX4WWJ0Hlir1hMML+08+tIsgL8NevZOBBa9QjFgmT94HW+gawwx4gX1dfwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sy6igTv0M4G4lUQSIqK3IgAe2aHMwHrZgKTdJI2/P9Q=;
 b=dt1Ggq+FJ/mkM4m05N6D8jgDtcpSbf2jLHm0ICzuuQGiRkkApUV8b+qRS66CNiobuuWCBaacmegDTuXOLA9zoyfA1J1y9L47wzVhlXOPaNR21eDiBpUPzD+++fcgSIa72DrSrjkJqw3y2my4d7SXqE+Q6VsjGZUMmsh2nGUdMIo=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by BN0PR10MB5190.namprd10.prod.outlook.com (2603:10b6:408:12b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Fri, 14 Jul
 2023 12:45:38 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5831:4a1a:fc:d349]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5831:4a1a:fc:d349%3]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 12:45:38 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Eric Auger <eauger@redhat.com>
CC: Peter Maydell <peter.maydell@linaro.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Haibo Xu
 <haibo.xu@linaro.org>, Andrew Jones <drjones@redhat.com>, Marc Zyngier
 <maz@kernel.org>
Subject: Re: [RFC PATCH 4/5] target/arm: enable feature ARM_FEATURE_EL2 if EL2
 is supported
Thread-Topic: [RFC PATCH 4/5] target/arm: enable feature ARM_FEATURE_EL2 if
 EL2 is supported
Thread-Index: AQHZSsnNgqOjmf8mc0OfFMGPlH0ZNK+tLuEAgAzdrIA=
Date: Fri, 14 Jul 2023 12:45:38 +0000
Message-ID: <9EFC06E4-7F76-4E94-A788-D488999870CB@oracle.com>
References: <20230227163718.62003-1-miguel.luis@oracle.com>
 <20230227163718.62003-5-miguel.luis@oracle.com>
 <acb446c4-dddb-30f6-5faf-e976fbe0c605@redhat.com>
In-Reply-To: <acb446c4-dddb-30f6-5faf-e976fbe0c605@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|BN0PR10MB5190:EE_
x-ms-office365-filtering-correlation-id: fc4110a6-12cb-48a7-7274-08db84683a0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fCv2H3bSLH/XaJ+2WbETcaugFhF5VjL18j0BK+kSYKvizSBAHvPSUJtP4pPksOZ/fqlVbtfAD7FIDQ3my40psdGxyYmr5wZqI2fNfW0gHaLPMm7blF3r6XoBwL3mryF3DDqUcK79UtZvzjRSOx/qZhwNC4Gj+iC8v7+XxLy3qtygf5zWPtP2/fYVN7Zy/V7nKmm5cEFnlUAYW+JbiwZYVsbTF/qNkLX+mYCFQwB2UcuhD+7OmAtLBGFJWGQQhmmcvt6duFcLLQr8k01yeoN+i7EU+0lj9FtM4LV+pp1J+kOH8dfxd9cKJSHItr2AcuJKoNrApfAV+z86wwsuPYcBcaxoTUth55Us6YZGgcwWxE4X3fePj3weaMvgOQQpIUtibAJ3MEZJmgfLowA56T4+e2SWBBUpZhzSpHR1nPi1SdzELuIcqhVlQ5qhsNrTEjUbiLK5U2VuPEAGSTj5ScfuaH5Twea3ziS0xJTa/V//Z9JUdlCfKY4M5LyGswto2OxJjufGy5Dtn3S6xBMz8iDvEGqZwZWiSYB03F53RAMTeLIwS4XN5HvEk3FLA/XV4XAyT9+rA1fl1yUM28+x3s46Ied74ZNWNtlf7JEPdOSc1KgrsYC79Jx1bwerw6Jm89GuP3le9o5TKLKCWHSu5/YetA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199021)(5660300002)(38100700002)(44832011)(7416002)(122000001)(41300700001)(8936002)(8676002)(316002)(38070700005)(86362001)(2906002)(966005)(6512007)(53546011)(26005)(6506007)(71200400001)(6486002)(478600001)(2616005)(36756003)(83380400001)(33656002)(186003)(54906003)(4326008)(64756008)(66446008)(66476007)(66556008)(6916009)(76116006)(66946007)(91956017)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YitMdURwMDdBNXFGdnZmbUtDTDNWQzNJamFvSTE5Zms4WWNPdzZ5a0tyOFRp?=
 =?utf-8?B?SFZleEVhYUxVbjJab1NuUi83Ty91TU1lb1JLVDZvRzlUVEoyY3BOZnhlcnU0?=
 =?utf-8?B?bHlHZk5SZnUrNFdQdldEWWRrNGFmVUcwa296c09wS25LeVpyWHlBUEVJTHY0?=
 =?utf-8?B?MGM3S0htSnRNaFB5RzlGdmtxQ2xUWW5PTmpDd3hiTm5QdS83cUk5WjVXU0FF?=
 =?utf-8?B?cjB4Q2FJTEsvRHVzYyszdTdzOW9lUXlubldjUEEwS1ZMcTAzeUtIdElwVmVi?=
 =?utf-8?B?bVFaQ3prY2NoOGJKUnYzYlRZM0J6OXkrNlJ2YXB4RU50ZVRvTm94WEZMNUZX?=
 =?utf-8?B?R0lzelJKWXdrU2tONXhyMU9IWFRUN01xcVNORE5HYmp6Vlk1NUZpU1IwZWx6?=
 =?utf-8?B?aE1YZFlzOVlMQkJsdTl6ZkxPazZWUGI1QW8xa1NiK3pEdUhZTnZKTzZ0anFt?=
 =?utf-8?B?WlN1d1k1blU1Ukp5UHBWdWZVclJNc2NRdDdicThwZ1luNGtOUWd2VzkrUktk?=
 =?utf-8?B?M29SL1F0Zkt4ZmVuOVBtd01LQzFEQzBGUEo2S1lNWWhDMllDMDlDKzJBbnl0?=
 =?utf-8?B?YU1FUlU4MEFQSXppS3poZEQ0M1ZGSjAwNjRibFhDTkRIOFU4MGFEb2dzVWFu?=
 =?utf-8?B?eGt1NzZhejBHckRwMXZ1dnBOcXQxclZMVHZvU29sNS9BcVJLQmpraGdaRkZU?=
 =?utf-8?B?cUxWSUp0RzRaL1lmVXJrN21qZFhLYnM2SXZnS2tXUnp1Mmdyam1KTlBKaG9V?=
 =?utf-8?B?RGxmWkgrdG5rOW4rd3pQb0Zxd1MxNTJwL1hDYXpBY2k1RjFVVjQzTE9jOGQv?=
 =?utf-8?B?eG9jRVppOTlZczUvNHpnZU8zRFVMSlcxS0w0c3dXUW5Vb3A3cCtjNEw1MjRG?=
 =?utf-8?B?NzM5TWtUM1VzcUFhK2NOSDBDUm9IeUhVM05jL0krSDQwbyttcFp1eHBCeEcx?=
 =?utf-8?B?MHZsQW9KOVNzUzBPcWZtbkZTb0hVV2M4eklIb2hqMGVoR2pFQzdEVElKR1ZL?=
 =?utf-8?B?M1RIYXB3N3dRYW14dlk2NzJMdS9vRjJtTTlIeGpLN2c2WnJvRGZ6bzFqOEUy?=
 =?utf-8?B?cW5vd0VKdUxtb2QxaENIdTAxTm5icldqTmdFWWJQV2plaE9lQ0IyUUdFZHFG?=
 =?utf-8?B?MFdJTmlIM1ZWdWU0RUEweWFsMWhmYSs5TDVzOTlTR0FiZTlLcDRUUzU5aU9x?=
 =?utf-8?B?M2lFZk5PQkh1dlZ2ekpONVdDS29rbFZDN0JRTTg1RG9BemtQclpmaU5KTmtY?=
 =?utf-8?B?dFBUWXVPNFl2OFI2VmtNYXlLSUlwNldrRHk5R0MxbUhPV1NreFliZDZEVDZT?=
 =?utf-8?B?b2Z2MkhqajVrNDZsbWJabTNmbHNvTEI4Mm5jZ0lzUFl4bWp6dnl1S25kR0lG?=
 =?utf-8?B?Z3hUd2w1allxanRISFljcGxRdDkzeWhhZHdmVDU3U1ZvSlNKVkZFaUwxR0h1?=
 =?utf-8?B?SE9Bb3ZSV1pIR2dFSEVPR0QvVkJPY3V1SitxTDZjR0ZSMmV6N3JEMm1WT3NF?=
 =?utf-8?B?clV1Y3pBUkRTemJvT3Y5K0ozRFBWdUVTUTBiUEtTT0p3TStzQUphSGluWXZB?=
 =?utf-8?B?cXdzWWxQQzREVGQ0L1QyNFArV1psa3UwR0dpQTRkNUt1czFoV21RZ05SK2l2?=
 =?utf-8?B?TWtlOU14c3JsNlA5ZXZYRG5OV2F5WWZpTE05ZzNYYmFEaWw0UTRKZmsrdXFj?=
 =?utf-8?B?dVUzd0o3NmFRZDVQNUZHc1NMWG5iVWE2YTdXZ3VNZ1BvUi9vdk1HL3QzZ2lB?=
 =?utf-8?B?OFk0SjkwdVFod1ZySjJsMUs0VnNTQ2gwZWNwa25DWjF2MkdrYUhKUXYyMWFJ?=
 =?utf-8?B?dHRaZk9WQStoQWlRWk9KM2RxVGNUVWxlcnlxZkQ5WGw3MjRTUlMzaHMzdVgr?=
 =?utf-8?B?SXJQd2hxVXgxNGkzbFEyc3U0WURZOVgwelo0aUljSVFraGJNV0htY202aUxQ?=
 =?utf-8?B?UnhtVEJPakcrOFRkNEtkaStYbXNJSXdOT2JpN1lJcVhTdExOb1dlSXQvMTVn?=
 =?utf-8?B?bGdxYXlOSnc3Mk52RXJza2RkTUMzai9USm9YNkJHYU9hcy9lM2tCVXpwd1lx?=
 =?utf-8?B?cnZIazQrKzY4dStoSmJLU3hteWhPYXZIdUo5eDVVMlBwRDlaQ3poajJra0Jj?=
 =?utf-8?B?TTl0b0NFYWFkaTRYbmRTU1VkeTVtdWQ0eTlSN1R2cHV4NzNLOGlNUTRGdkJ5?=
 =?utf-8?B?Q2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DB6AB87C8A12944B7C1914A98AB9EF1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hAaUg535ErJhRXx8E5g4C1R0TpzeDtQYg1m+hglkvFk5nYhykHairPalvCXNmz1cUcKsln7PXDFZUmfRYjrf4jPK4HcUrBI5gZdFp5dh3T0SKDc3/39gGSXX9OVGJW7hZnyCpPKP98JnLQI9Vs8Oce88FS8aU+NEkkdA8oENw9asJ6oFth07Y86HLxEZ6Rv8mcZdOIfZfmXiV7c84LfnRanyi7RXO1/yqvdJ9UVaUKqjTi1Yhd7KrfDXGOwV3Q0NRe8GYULgKosTvVUi/s0ZyK/pUHkwdX/7+HLAyjOeGSHxMOXQFnzoY7saHQ48dKuDlMa7IJwtQFnnKbQ3d0MSJ7cZLL/K/LQlxs3f4QS588ZaYsn72iVurxTvnPJL48tTx8snAw4Z58OipusQyay20WAtWvlyHVH9SJXWavuXGaGtY8eOzKw12MKUdr/WpFclt39MYVEo6R584Kf42L410nA81UoSLmjDhwq6kJE4ZlUCgsq7KnH0KmZakVbRtuP/74iolGo37vjz3vcqcwTJ2SO1zvSLpsrO9+IJY962J4Sqfo7G/voDsoyRGGQomufoKVTtaKy39XXE8Y4/o7hIu4MzJUI/SiEju8hoQnIAivYd4BziWT9kmVum8FvpmfAb1AB/6a9mt7qMBKafTM1DmmmwDUP1vQbz7l6yeZlJVreFZREzKmAH2LSEa8IU2zmONDYRip9pY/D+zfM6xTXwsr/mGSv81erYuCWXL1i6OJJ6JC+tL9ZOfoFGD6VRfkpopDEnDUOyCYomLTgNrllSBSRsoX4K5WKi+6T0zcD4WAd3I6pi9zmWFRfEognw5239udpD4TRU3BWgA4qxBOXpnw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4110a6-12cb-48a7-7274-08db84683a0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 12:45:38.7943 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4FdhnAJpDxGKwPypUwFLUtVVtFphpoTQfeQ7c3xlVJs1bXZfJUsHoDduiRnI/QvC4wReSJHXyXexm1EOx0s4UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5190
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307140115
X-Proofpoint-GUID: al8g_JimB_-80-XnogLckNCI8hRseXcL
X-Proofpoint-ORIG-GUID: al8g_JimB_-80-XnogLckNCI8hRseXcL
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

SGkgRXJpYywNCg0KVGhhbmtzIGluIGFkdmFuY2UgZm9yIHlvdXIgY29tbWVudC4NCg0KPiBPbiA2
IEp1bCAyMDIzLCBhdCAwODoxNiwgRXJpYyBBdWdlciA8ZWF1Z2VyQHJlZGhhdC5jb20+IHdyb3Rl
Og0KPiANCj4gSGkgTWlndWVsLA0KPiANCj4gT24gMi8yNy8yMyAxNzozNywgTWlndWVsIEx1aXMg
d3JvdGU6DQo+PiBGcm9tOiBIYWlibyBYdSA8aGFpYm8ueHVAbGluYXJvLm9yZz4NCj4+IA0KPj4g
S1ZNX0NBUF9BUk1fRUwyIG11c3QgYmUgc3VwcG9ydGVkIGJ5IHRoZSBjcHUgdG8gZW5hYmxlIEFS
TV9GRUFUVVJFX0VMMi4NCj4+IEVMMiBiaXRzIG9uIElEX0FBNjRQRlIwIHN0YXRlIHVuc3VwcG9y
dGVkIG9uIHRoZSB2YWx1ZSAwYjAwMDAuDQo+PiANCj4+IFJlZjogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvcWVtdS1kZXZlbC9iN2MyNjI2ZTZjNzIwY2NjNDNlNTcxOTdkZmYzZGFjNzJkNjEzNjQw
LjE2MTYwNTI4OTAuZ2l0LmhhaWJvLnh1QGxpbmFyby5vcmcvDQo+PiANCj4+IFNpZ25lZC1vZmYt
Ynk6IEhhaWJvIFh1IDxoYWliby54dUBsaW5hcm8ub3JnPg0KPj4gW01pZ3VlbCBMdWlzOiB1c2Ug
b2YgSURfQUE2NFBGUjAgZm9yIGNwdSBmZWF0dXJlc10NCj4+IFNpZ25lZC1vZmYtYnk6IE1pZ3Vl
bCBMdWlzIDxtaWd1ZWwubHVpc0BvcmFjbGUuY29tPg0KPj4gLS0tDQo+PiB0YXJnZXQvYXJtL2Nw
dS5oICAgfCAgMiArLQ0KPj4gdGFyZ2V0L2FybS9rdm02NC5jIHwgMTYgKysrKysrKysrKysrKysr
Kw0KPj4gMiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
PiANCj4+IGRpZmYgLS1naXQgYS90YXJnZXQvYXJtL2NwdS5oIGIvdGFyZ2V0L2FybS9jcHUuaA0K
Pj4gaW5kZXggOWFlZWQzYzg0OC4uZGUyYTg4YjQzZSAxMDA2NDQNCj4+IC0tLSBhL3RhcmdldC9h
cm0vY3B1LmgNCj4+ICsrKyBiL3RhcmdldC9hcm0vY3B1LmgNCj4+IEBAIC0zOTYxLDcgKzM5NjEs
NyBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaXNhcl9mZWF0dXJlX2FhNjRfYWEzMl9lbDEoY29uc3Qg
QVJNSVNBUmVnaXN0ZXJzICppZCkNCj4+IA0KPj4gc3RhdGljIGlubGluZSBib29sIGlzYXJfZmVh
dHVyZV9hYTY0X2FhMzJfZWwyKGNvbnN0IEFSTUlTQVJlZ2lzdGVycyAqaWQpDQo+PiB7DQo+PiAt
ICAgIHJldHVybiBGSUVMRF9FWDY0KGlkLT5pZF9hYTY0cGZyMCwgSURfQUE2NFBGUjAsIEVMMikg
Pj0gMjsNCj4+ICsgICAgcmV0dXJuIEZJRUxEX0VYNjQoaWQtPmlkX2FhNjRwZnIwLCBJRF9BQTY0
UEZSMCwgRUwyKSAhPSAwOw0KPj4gfQ0KPj4gDQo+PiBzdGF0aWMgaW5saW5lIGJvb2wgaXNhcl9m
ZWF0dXJlX2FhNjRfcmFzKGNvbnN0IEFSTUlTQVJlZ2lzdGVycyAqaWQpDQo+PiBkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2FybS9rdm02NC5jIGIvdGFyZ2V0L2FybS9rdm02NC5jDQo+PiBpbmRleCBiZTgx
NDRhMmI1Li5mN2ViZDczMWFhIDEwMDY0NA0KPj4gLS0tIGEvdGFyZ2V0L2FybS9rdm02NC5jDQo+
PiArKysgYi90YXJnZXQvYXJtL2t2bTY0LmMNCj4+IEBAIC01MDUsNiArNTA1LDcgQEAgYm9vbCBr
dm1fYXJtX2dldF9ob3N0X2NwdV9mZWF0dXJlcyhBUk1Ib3N0Q1BVRmVhdHVyZXMgKmFoY2YpDQo+
PiAgICAgICovDQo+PiAgICAgaW50IGZkYXJyYXlbM107DQo+PiAgICAgYm9vbCBzdmVfc3VwcG9y
dGVkOw0KPj4gKyAgICBib29sIGVsMl9zdXBwb3J0ZWQ7DQo+PiAgICAgYm9vbCBwbXVfc3VwcG9y
dGVkID0gZmFsc2U7DQo+PiAgICAgdWludDY0X3QgZmVhdHVyZXMgPSAwOw0KPj4gICAgIGludCBl
cnI7DQo+PiBAQCAtNTM1LDYgKzUzNiwxNCBAQCBib29sIGt2bV9hcm1fZ2V0X2hvc3RfY3B1X2Zl
YXR1cmVzKEFSTUhvc3RDUFVGZWF0dXJlcyAqYWhjZikNCj4+ICAgICAgICAgaW5pdC5mZWF0dXJl
c1swXSB8PSAxIDw8IEtWTV9BUk1fVkNQVV9TVkU7DQo+PiAgICAgfQ0KPj4gDQo+PiArICAgIC8q
DQo+PiArICAgICAqIEFzayBmb3IgRUwyIGlmIHN1cHBvcnRlZC4NCj4+ICsgICAgICovDQo+PiAr
ICAgIGVsMl9zdXBwb3J0ZWQgPSBrdm1fYXJtX2VsMl9zdXBwb3J0ZWQoKTsNCj4+ICsgICAgaWYg
KGVsMl9zdXBwb3J0ZWQpIHsNCj4+ICsgICAgICAgIGluaXQuZmVhdHVyZXNbMF0gfD0gMSA8PCBL
Vk1fQVJNX1ZDUFVfSEFTX0VMMjsNCj4gVGhpcyBkb2Vzbid0IHdvcmsgaWYgeW91ciBob3N0IGJv
dGggc3VwcG9ydHMgU1ZFICYgTlYuDQo+IA0KDQpNYXkgSSBhc2sgaWYgdGhpcyBwcmV2ZW50ZWQg
eW91ciBMMSBvciBMMiBndWVzdCBmcm9tIGJvb3Rpbmc/IEnigJl2ZSBhZGRyZXNzZWQgYWxsDQp0
aGUgcHJldmlvdXMgY29tbWVudHMgb24gdGhlIHRocmVhZCBmb3IgdGhlIG5ldyBSRkMgdmVyc2lv
biBhbmQgdGhpcyB0b3BpYyBpcw0Kd2hhdCBJ4oCZbSBjdXJyZW50bHkgYWRkcmVzc2luZy4NCg0K
U28gZmFyIHRoZSBMMSBndWVzdCBib290ZWQgc3VjY2Vzc2Z1bGx5IGJ1dCBub3QgdGhlIEwyIGd1
ZXN0Lg0KDQo+IFRoZSBlcnJvciBvdXRwdXQgYnkgcWVtdSBpcyBub3Qgc3RyYWlnaHRmb3J3YXJk
DQo+IA0KPiBxZW11LXN5c3RlbS1hYXJjaDY0OiBjYW4ndCBhcHBseSBnbG9iYWwgaG9zdC1hcm0t
Y3B1LnN2ZT1vZmY6IFByb3BlcnR5DQo+ICdob3N0LWFybS1jcHUuc3ZlJyBub3QgZm91bmQNCj4g
DQo+IFRoZSBwcm9ibGVtIGlzIHRoYXQgd2UgY3JlYXRlIGEgc2NyYXRjaCBWTSB3aXRoIGEgQ1BV
IGZlYXR1cmluZyBib3RoIFNWRQ0KPiBhbmQgTlYgYW5kIHRoaXMgZmFpbHMgYXQga2VybmVsIGxl
dmVsLCBJIHRoaW5rIG9uIHZjcHUgcmVzZXQuDQo+IA0KPiBUaGUgdHJvdWJsZSBpcyB0aGF0IHdl
IGRvIHRoYXQgZXZlbiBpZiBzdmU9b2ZmIGF0IHFlbXUgbGV2ZWwuIFNvIEkgdGhpbmsNCj4gdGhp
cyBpcyBhIG1vcmUgZ2VuZXJpYyBpc3N1ZSByZWxhdGVkIHRvIHRoZSB3YXkgd2UgdmFsaWRhdGUg
aG9zdCBjcHUNCj4gZmVhdHVyZXMuDQo+IA0KDQpPSywgSeKAmW0gaGF2aW5nIGEgbG9vayBpbnRv
IHRoYXQuDQoNClRoYW5rIHlvdQ0KDQpNaWd1ZWwNCg0KPiBUaGFua3MNCj4gDQo+IEVyaWMNCj4g
DQo+IA0KPj4gKyAgICB9DQo+PiArDQo+PiAgICAgLyoNCj4+ICAgICAgKiBBc2sgZm9yIFBvaW50
ZXIgQXV0aGVudGljYXRpb24gaWYgc3VwcG9ydGVkLCBzbyB0aGF0IHdlIGdldA0KPj4gICAgICAq
IHRoZSB1bnNhbml0aXplZCBmaWVsZCB2YWx1ZXMgZm9yIEFBNjRJU0FSMV9FTDEuDQo+PiBAQCAt
NzE0LDYgKzcyMywxMCBAQCBib29sIGt2bV9hcm1fZ2V0X2hvc3RfY3B1X2ZlYXR1cmVzKEFSTUhv
c3RDUFVGZWF0dXJlcyAqYWhjZikNCj4+ICAgICBmZWF0dXJlcyB8PSAxVUxMIDw8IEFSTV9GRUFU
VVJFX1BNVTsNCj4+ICAgICBmZWF0dXJlcyB8PSAxVUxMIDw8IEFSTV9GRUFUVVJFX0dFTkVSSUNf
VElNRVI7DQo+PiANCj4+ICsgICAgaWYgKGVsMl9zdXBwb3J0ZWQpIHsNCj4+ICsgICAgICAgIGZl
YXR1cmVzIHw9IDFVTEwgPDwgQVJNX0ZFQVRVUkVfRUwyOw0KPj4gKyAgICB9DQo+PiArDQo+PiAg
ICAgYWhjZi0+ZmVhdHVyZXMgPSBmZWF0dXJlczsNCj4+IA0KPj4gICAgIHJldHVybiB0cnVlOw0K
Pj4gQEAgLTg4MSw2ICs4OTQsOSBAQCBpbnQga3ZtX2FyY2hfaW5pdF92Y3B1KENQVVN0YXRlICpj
cykNCj4+ICAgICAgICAgYXNzZXJ0KGt2bV9hcm1fc3ZlX3N1cHBvcnRlZCgpKTsNCj4+ICAgICAg
ICAgY3B1LT5rdm1faW5pdF9mZWF0dXJlc1swXSB8PSAxIDw8IEtWTV9BUk1fVkNQVV9TVkU7DQo+
PiAgICAgfQ0KPj4gKyAgICBpZiAoY3B1X2lzYXJfZmVhdHVyZShhYTY0X2FhMzJfZWwyLCBjcHUp
KSB7DQo+PiArICAgICAgICBjcHUtPmt2bV9pbml0X2ZlYXR1cmVzWzBdIHw9IDEgPDwgS1ZNX0FS
TV9WQ1BVX0hBU19FTDI7DQo+PiArICAgIH0NCj4+ICAgICBpZiAoY3B1X2lzYXJfZmVhdHVyZShh
YTY0X3BhdXRoLCBjcHUpKSB7DQo+PiAgICAgICAgIGNwdS0+a3ZtX2luaXRfZmVhdHVyZXNbMF0g
fD0gKDEgPDwgS1ZNX0FSTV9WQ1BVX1BUUkFVVEhfQUREUkVTUyB8DQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDEgPDwgS1ZNX0FSTV9WQ1BVX1BUUkFVVEhfR0VORVJJ
Qyk7DQoNCg0K

