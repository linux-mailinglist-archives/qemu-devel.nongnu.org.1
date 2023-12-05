Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D0F804575
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 04:03:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rALiC-00043r-It; Mon, 04 Dec 2023 22:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rALiA-00042o-F3
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 22:03:02 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rALi8-0006Iw-Q7
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 22:03:02 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B519d9d017037; Tue, 5 Dec 2023 03:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=2m/+j0pC7a06+mB4p+hbby9gHC1WvxGjfz8VAit42cQ=;
 b=B1DvbdZXU2rwGHHRPqAmwsiMdfOGVK/i7xOutO+HezReo1sWarCk9IvH5H6L/yHNwW3V
 wKfkE1ZYCR/OtqRWrMEsp3KeGscrn3UFhErACp0MPGI39k6tKSlUmWIbNPXtLImOXNfE
 dPJCN2+MVXYrvUQSfqWV777+drUVIqQb4/o2eUvsMRbgj2QZS+B2wODXuE8b2pqBjJcp
 3E3cqZh4KyNmg6bgmmN/2EQ+ZScu7XPPHp4F1t5WC+XJRs2koxSU/CMVCzgb6a7oLddH
 5gDurkEmz4/lkgSxzGkfwKZkAYgUwCo2oPHEui2Z0ZGGRRUlQPzHNA7K/d4pZOcHdYZH rQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3us8wpjrry-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Dec 2023 03:02:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJTqnWNCDuHBsZlHwBns8sWHN6pOuubvxJG7uvAcNcUb9jLlT+GOENW9WNbdWVup+UZednN78Tb/5c6qDV+dvBSQ6baqOSwSqFLVPJu+V98erBQ04F9M87siyptpfCTjqKh469rh2LjJ93b8dxtkPTAW4gdeqg7R/4/c3FdwrPGf6ryz7hv7vU+IZ0RIkhdlFfue5ThUcb3YDq5AqIDmk10FrQS5zx+I2xpS9YD4tNr+8lL8TftxlWHb4a4O0Jc/N3dfgo9I/Iipapl1nR6cRH343ekWPNfM5bapx16gbEuHiSai5zD0qK/DI3UcH4a9e6tsa186Lc0wDa/GRmFAAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2m/+j0pC7a06+mB4p+hbby9gHC1WvxGjfz8VAit42cQ=;
 b=bhfYTgjVmgO7SUmIFiLeBMZ0zfQynnuTcy9GEHzOr0djGe+ZrLlTKDx/ZITj4Ee5Ab+6lco+c3kCHR1bmidvZDRGU+thAbgdCAaTlbAaG6ayGHbxbhafIn7OWUCVhTrsS9D3W/Dqwm2POL1nFCI+/aZknHOESfL2JoEugLJLNJDlHclHdTGPxYHk3r6o5usfRXkLt2k3uvxqCF1Szfm4k7qK2ahYF5sN14Gipc/VrLH/H5X+ucuYz3Vrwdb41TbeV+MsaRdag4jRgGBBV7DPEdAsPh879DYaLAUC51FwEKYFahuxOj2RAe2TGioonmkAblm/lyOV5xZ2RhIe+bn0/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by CH2PR02MB6901.namprd02.prod.outlook.com (2603:10b6:610:8e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 03:02:54 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::546b:93ec:1242:265c]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::546b:93ec:1242:265c%6]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 03:02:54 +0000
From: Brian Cain <bcain@quicinc.com>
To: Taylor Simpson <ltaylorsimpson@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>, Sid Manning
 <sidneym@quicinc.com>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "ale@rev.ng" <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: RE: [PATCH 6/9] Hexagon (target/hexagon) Make generators object
 oriented - gen_op_regs
Thread-Topic: [PATCH 6/9] Hexagon (target/hexagon) Make generators object
 oriented - gen_op_regs
Thread-Index: AQHaJx3S0Or1vi0/xUWK53+nTmgLW7CaAL9Q
Date: Tue, 5 Dec 2023 03:02:53 +0000
Message-ID: <SN6PR02MB4205F6198111D97C97CDDDE2B885A@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20231205015303.575807-1-ltaylorsimpson@gmail.com>
 <20231205015303.575807-7-ltaylorsimpson@gmail.com>
In-Reply-To: <20231205015303.575807-7-ltaylorsimpson@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|CH2PR02MB6901:EE_
x-ms-office365-filtering-correlation-id: 01b645b9-c03a-42be-08ae-08dbf53eace5
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ko8YBtRGZA1jvvdGf3LDtMMsBsmalYEq2YMld6/uXLW/8m3LzVhU5WBlvxkR/U2saNHScBhJFz8flaCLwEYedcOeM4sMzSHxDKbqrLB3gVNkr9FzmeYFV1iN11cZBuINGw0JSQTPFVpSHa0uhXjmNcZdS/qNVewDzCl3ABbwCZvpVmz3fCVmbgl6o9I5SZBXsAE+NkgpyoeHk9an0O3vPwK7amwnRrSuGFQk+nHtoS5uetAqQujjZ+hFHFbnhQ/KcfIhhj+dYDsrQ0+hxiKegfe4zHn2coRX+21KtOqiqJoPKPGXcdFuYx5YilZjJPvF9ojIO2aMzy71+912UUyu7rf3TPhjo6TFsmLAlBzjXwxDcDMzceQhKhetFYtXNO+Pv8aqPZHPaQ+Bc6r1LSfND2DSQUy67SGJRyqrDXvqL0APBJclxTPnde7ao+KwiEAvkXlscclL4sEFGQsDEsnMbIOV6lS4T7le07pf6/LdaRTKsAfQtT5w9dcpPodHGSTtEthUKAocBl7wGEOCzf7o1VBhm0S7MvCpgWEXCLJ7S3FzsjU9C73PR8Jwvhp2leTG1RiU8r2icxBIjnf7/neaTViSlaHjFLjJb5kR9JWrEeykhSOXRUGzZWWVZeOPz15xs/l+uYPdzoOEWDoCJ2GZxndFzEonaNPio7dYQ1vAnHI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(366004)(136003)(346002)(376002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(451199024)(1800799012)(186009)(52536014)(2906002)(5660300002)(38070700009)(33656002)(86362001)(41300700001)(6506007)(7696005)(71200400001)(478600001)(9686003)(53546011)(55016003)(38100700002)(122000001)(83380400001)(26005)(8676002)(4326008)(8936002)(76116006)(66476007)(66556008)(66946007)(66446008)(110136005)(54906003)(64756008)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDVCam5KTk1Cd05UUEhJbXFvdDl1VEFLWWtmaVp2OGNjalMvaWszbmdQVHEr?=
 =?utf-8?B?ditzZXRBbmZhdXZWZ1ZYVEppNUFBRldjZFlFaTZrRUQ2MVp0L2ZMTnlPQUdm?=
 =?utf-8?B?dENBQ216RC9Ka3prbGw2WXh0SHBRVHJKNncwL0ZNOFpnQXlJTFhOSjRlRVBl?=
 =?utf-8?B?U3dWTjg0Rlg5SFJKa3g3MExHRVVOeFJoRCtFNm02LzhvRmQ4RUxwazA3T2g3?=
 =?utf-8?B?b2k3d2RvU1pzeUQ1MXc2UkJMSFhDR3JpYXNwL0cyOFBzOW91aXErMWRBamFq?=
 =?utf-8?B?aDIwV1B1RjNkdXpmOEZrZHlyRyt2azFZbm5HMXZpQ1dVdUxySnYwcG1wRDgy?=
 =?utf-8?B?NlUrOTZCZHhOTjZaRmVSQU9SWXNEQlE4STlvMkdZNmNqM1lSc2FBNGxzV3Zz?=
 =?utf-8?B?a0ZXVjJGSXJBNEo0ZTYvUHljcXhEUlR6QUw4elp6ckJzTmoxWWc0UmY4SHVX?=
 =?utf-8?B?RTNuWVZEUjlmUEpvVmllWUtUZ0VoYllpK05SSUFmcGluaHhrYk9kSjk0cDNR?=
 =?utf-8?B?WGJQd3Q5ZGJTV25OSDY3eXpVWjdOZWcyTVBTTTdILzJJMC8wREdhYUZSTDFR?=
 =?utf-8?B?b09iYWQvdVRJSVZJblRpdkFieUFteUplekxmSE5DNlJtMUc2MHB5bTI2TmJo?=
 =?utf-8?B?TFJuT01CN0VSdWtrQ0U0b0drZ2I3bUljVFdmNit6d3hiTTl4YVhFdTlPcjBh?=
 =?utf-8?B?c0RiOHdBVWd6S1J5Zk9PcklTdTg5N2R0L3pMTVRidlhYNFpmNUVRaGtmaFRV?=
 =?utf-8?B?dWhtUHRjY0ExNWsrdGNVZklCL015ZXhVeDFwd0V5N0JkUXVmcHV3TnZ5L05Y?=
 =?utf-8?B?RnM0OXBBL25rYzhGRi9valNCd25xNy9uejBTWDd6U0hJQUs3N0ZNQ3d0WWw2?=
 =?utf-8?B?ZkJJTTVXWXJ4YWdsMDhTM3p3QTlzNkFHRnNZdXA0NnZyTWdZZlBsMlJ2ckJU?=
 =?utf-8?B?THNuaThoSzhoV2ZPa2ZmbDNIazdwT3I4c3N3ZnpDM08yY1Y5TC9VcEw5Und4?=
 =?utf-8?B?eGlrYXNoOEgxUlRPN3F1dWt6MEtpY3VKbjRvTnVDTGFxQVlGdjlrNjRydHU0?=
 =?utf-8?B?YmRxd0cvQVRWMWo0cW8xSllIeXNTQks0WFRNUHlGWWJUbE9Ga0JLc05iRGh2?=
 =?utf-8?B?RVBHMUhDRXV1Y2ZmZUFDZldya1VLdUs2SG5ZQXBLN1VteEtPUi8vSmVwZ3Q4?=
 =?utf-8?B?OE9HM0dNYzJJKzgxWTBUYXBidkhLVXFqcU9wZU1rZUQrTWpmaUpjQWFxaTdW?=
 =?utf-8?B?Rk1aNlNaVlJkc1hsb0N6cDlBeDZQazFDRmFUdUoyamc1eWpITHA3MzhCNkU1?=
 =?utf-8?B?V1gzV1JCYVV4NFNpSE9Dbk1GdlowbHNDb255Z3pmVWFUVVUrb0JyQ1RRM3VS?=
 =?utf-8?B?MFRxT0JVd2x4V0RoaXAyTW9pSWZEYy82OTV5M25SWThON251WWF0dEJNYzZG?=
 =?utf-8?B?VFQvV1NHVUQ2SDZMQVZOUkJSM2QyMjVCNlpWT05ReC9LSDJkRU0wME96N3U1?=
 =?utf-8?B?bXJaWk5QMU5wZjNjYzdDaU5rcWlkbUhPSFpSVXpkTGExelhqMUNSK3BxLzZ6?=
 =?utf-8?B?V2Z4RUtqd3BQTlJleTg3YjNIbTdGUXNIVTBwRjFDM253U2FTdTArUDhQMFFy?=
 =?utf-8?B?NHMxM2RHdHN0YWxjNytXSWkyVmZlOTFhS1JjV3hoT21mY2xaUy9pZlBUUlNk?=
 =?utf-8?B?c1hyalBvemZRMnM1Umd3RVRVaUxYR05YRW5JVHRDcWhVMGMvSnRmdDRxbGV1?=
 =?utf-8?B?VHVRZEVkRk1wckg4aUpRd0R5OENTaGswakxsYklzdmQ4YWlUeDBYcTFiSnNB?=
 =?utf-8?B?WmhXd212ZThzQnJEYytmMTRRMXZVWjlYZ3ViVWR5VnllMmw2Mmtzd0dOOHRN?=
 =?utf-8?B?RCs0VU5UNTNvMDZCUlFDMU9PR1NtSzkzaVYyUU9mZlBOSHBaU09XdzBsbmxl?=
 =?utf-8?B?c2RlbHY5Um5helFvS3ZZc3JYdjFkRUpYNndXMFlYVHpLMHNvSlBZejhjQnJ0?=
 =?utf-8?B?M0JPQmpHTWl4eS9mSlgwc2F6b0l6K081K054Ymxjd3Vyd0EzZ2FmTHhkV3p3?=
 =?utf-8?B?dHExbVVLbHpBallPNWtyajBQZW42VEVZcTdWNi9xVU0zb3YzamRacGFabUVU?=
 =?utf-8?Q?rmk/dWEajhPKlsOkQTyjUA0l7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: W6wIRuRPr2QTSC92JJa07zus3weZA36v1lcfguLJoOSxPXmegMiI9PMHYQL3k+5Ycj3pJjETMXWk5iZtlG2L/SCUOQiyFKURu1V8kHn68wYheQcYmCt9xsAl3CoWxpYBYX0jLWIWxOVgWrHSQYtHh09bteh5I8aC8F7CWROBEFv8YJJQ/3TEhs0CBvI3VeH8eU35X4Sm3thKIznFgC9FRj4Wu8F9tSBRXNuDVLkAa+fEn7sNh36dYPjLSChWTcUikMP9/OAtEnS7IubkdBjGWhiXuamshXud5Vl0ePXDjC47OxCkPs9gRlG75ihAawZs5RKRsIk2EmChBMjaNAtE/5ul5y/eRAsEfqnTm0TzLXCopri+/A6ZC1TwAKavWC5Ff9HUF96q7nVhNc2xfpFuUsZugERypzRK92Xcpm9LsjIt05L1NQ9qCnRKJkHn01lguqqu7WNIDdQUxbgGlXwsH71KmZas6fJXsK4fIsVIyXa+PSHpqRLvKnw4xGw2nEnj2KphQ2Rt3OIwvEB8Kx0qsuRwHRWrDlWJDBTSL0IuImcy/G5wZ/M8Udq7p5y4osYVNX57mjgnw5L/Cil08eTX5NkDxsLjKktscT5NB0uO6WwA2Jvyv3uNEt4Dg27Ff6wTBw+4GT9DkJKvBAzAp1lkjCYy8mwdnYuokTBk+13g5ENvy4STgfg/5+yJBZLIpW9eZeXkf1pmoFW1Vby/MzBhLNE4fjf9GRBhRwrF/PC7lTWgIHFEtghKKJjgGLNGFt5A+2bRPicaPCwZgj2hgNAyRzlVf3E5rNkS6wZlaNteDXXw4yJHwCTjuW3EVmRervmORKHFBeIxnW1EyA4H8yuNFw==
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b645b9-c03a-42be-08ae-08dbf53eace5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 03:02:53.9991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M8k4s8z8GPBcV5+w8Fh8cuA/jFpsnrEw+vE2HRYtVwSuqugiz5Mb8FEd2xUZwTlcQcg3IOPQo2EXqMJjEgl5kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6901
X-Proofpoint-GUID: Q16pYKMTqcTljaQjMJDsWixS7H-2UaiU
X-Proofpoint-ORIG-GUID: Q16pYKMTqcTljaQjMJDsWixS7H-2UaiU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_24,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=405 impostorscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312050024
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGF5bG9yIFNpbXBzb24g
PGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBEZWNlbWJlciA0LCAy
MDIzIDc6NTMgUE0NCj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogQnJpYW4gQ2Fp
biA8YmNhaW5AcXVpY2luYy5jb20+OyBNYXRoZXVzIEJlcm5hcmRpbm8gKFFVSUMpDQo+IDxxdWlj
X21hdGhiZXJuQHF1aWNpbmMuY29tPjsgU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+
OyBNYXJjbw0KPiBMaWViZWwgKFFVSUMpIDxxdWljX21saWViZWxAcXVpY2luYy5jb20+OyByaWNo
YXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnOw0KPiBwaGlsbWRAbGluYXJvLm9yZzsgYWxlQHJldi5u
ZzsgYW5qb0ByZXYubmc7IGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBbUEFU
Q0ggNi85XSBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgTWFrZSBnZW5lcmF0b3JzIG9iamVjdA0K
PiBvcmllbnRlZCAtIGdlbl9vcF9yZWdzDQo+IA0KPiBXQVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdp
bmF0ZWQgZnJvbSBvdXRzaWRlIG9mIFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBvZg0KPiBhbnkg
bGlua3Mgb3IgYXR0YWNobWVudHMsIGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+DQo+
IC0tLQ0KPiAgdGFyZ2V0L2hleGFnb24vZ2VuX29wX3JlZ3MucHkgfCA2ICsrKystLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fb3BfcmVncy5weSBiL3RhcmdldC9oZXhhZ29uL2dl
bl9vcF9yZWdzLnB5DQo+IGluZGV4IGE4YTc3MTIxMjkuLjdiN2IzMzg5NWEgMTAwNzU1DQo+IC0t
LSBhL3RhcmdldC9oZXhhZ29uL2dlbl9vcF9yZWdzLnB5DQo+ICsrKyBiL3RhcmdldC9oZXhhZ29u
L2dlbl9vcF9yZWdzLnB5DQo+IEBAIC03MCw2ICs3MCw3IEBAIGRlZiBzdHJpcF9yZWdfcHJlZml4
KHgpOg0KPiAgZGVmIG1haW4oKToNCj4gICAgICBoZXhfY29tbW9uLnJlYWRfc2VtYW50aWNzX2Zp
bGUoc3lzLmFyZ3ZbMV0pDQo+ICAgICAgaGV4X2NvbW1vbi5yZWFkX2F0dHJpYnNfZmlsZShzeXMu
YXJndlsyXSkNCj4gKyAgICBoZXhfY29tbW9uLmluaXRfcmVnaXN0ZXJzKCkNCj4gICAgICB0YWdy
ZWdzID0gaGV4X2NvbW1vbi5nZXRfdGFncmVncyhmdWxsPVRydWUpDQo+ICAgICAgdGFnaW1tcyA9
IGhleF9jb21tb24uZ2V0X3RhZ2ltbXMoKQ0KPiANCj4gQEAgLTgwLDExICs4MSwxMiBAQCBkZWYg
bWFpbigpOg0KPiAgICAgICAgICAgICAgd3JlZ3MgPSBbXQ0KPiAgICAgICAgICAgICAgcmVnaWRz
ID0gIiINCj4gICAgICAgICAgICAgIGZvciByZWd0eXBlLCByZWdpZCwgXywgbnVtcmVncyBpbiBy
ZWdzOg0KPiAtICAgICAgICAgICAgICAgIGlmIGhleF9jb21tb24uaXNfcmVhZChyZWdpZCk6DQo+
ICsgICAgICAgICAgICAgICAgcmVnID0gaGV4X2NvbW1vbi5nZXRfcmVnaXN0ZXIodGFnLCByZWd0
eXBlLCByZWdpZCkNCj4gKyAgICAgICAgICAgICAgICBpZiByZWcuaXNfcmVhZCgpOg0KPiAgICAg
ICAgICAgICAgICAgICAgICBpZiByZWdpZFswXSBub3QgaW4gcmVnaWRzOg0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgcmVnaWRzICs9IHJlZ2lkWzBdDQo+ICAgICAgICAgICAgICAgICAgICAg
IHJyZWdzLmFwcGVuZChyZWd0eXBlICsgcmVnaWQgKyBudW1yZWdzKQ0KPiAtICAgICAgICAgICAg
ICAgIGlmIGhleF9jb21tb24uaXNfd3JpdHRlbihyZWdpZCk6DQo+ICsgICAgICAgICAgICAgICAg
aWYgcmVnLmlzX3dyaXR0ZW4oKToNCj4gICAgICAgICAgICAgICAgICAgICAgd3JlZ3MuYXBwZW5k
KHJlZ3R5cGUgKyByZWdpZCArIG51bXJlZ3MpDQo+ICAgICAgICAgICAgICAgICAgICAgIGlmIHJl
Z2lkWzBdIG5vdCBpbiByZWdpZHM6DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICByZWdpZHMg
Kz0gcmVnaWRbMF0NCj4gLS0NCj4gMi4zNC4xDQoNClJldmlld2VkLWJ5OiBCcmlhbiBDYWluIDxi
Y2FpbkBxdWljaW5jLmNvbT4NCg==

