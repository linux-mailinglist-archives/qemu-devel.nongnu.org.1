Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 539A482B671
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 22:11:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO2Jy-0008Aw-21; Thu, 11 Jan 2024 16:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rO2Jv-000845-4V
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 16:10:35 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rO2Js-0002u9-TS
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 16:10:34 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40BIWJ1i002732; Thu, 11 Jan 2024 21:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 qcppdkim1; bh=k7ACzCH4KlgMsYfLITLEWFbl4QPWwCm8AV1YaklL3Y0=; b=We
 lozP7inv7QzBDVH+UqNmKiL4+26PbcKNT5ITrXrc7+pkzjgKOCUK7BxhX4/igm8c
 vlBINoYvZZIJ/6IQPaVItZJfPShnmmY5SaJiqUTS1L9O17Ra+4OX7FTloewjGhw4
 r6Q+VTkw9a2PqjZhKaqb6LNkBa5Fms+2AG9KrRVJT7iF+nycNOc1MpwluPmg3Wk6
 dh2byLUfSy1a00MV3+nBDTqu0Boh3CzNMCe5fH2qUxHk2lueXq6WVK42EguSz4ap
 wdZ8Tq62RZOgEgai6uSDgqFz6tryhWKuW15885mugDTfqVqA0e9SXC1aLlRZqq4S
 OBvR4T7OoegquhtTaQBA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjmkd0j8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jan 2024 21:10:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9hvXIMls+4ay9r7g8DaWZGsQopQhRud5Q9NeBuyMCB2t0ctQNIpLrO1taEPJwUFufNH9GY+snlAhLV+tNuw0oJsC52SrIk5ViPrSJOucaQfZdXT7yPSygsK7x1WLJ6U3ZTHlvYObVMomvf/NwIIfUMoPOwA3slpLg6M9622T5hUu0QjSKNne9eNRK78reuzBCULzADvN3KIPGjKOlGdRf5VHlYTUfIFMhRKLr+9SXk12OGKDWTSjjiUGYpPP0RTYxfly05pUomLQ2J3F6K+JawVSxXCVCDhIHk+iTXTMJEaHUQ1ozSu6olIYsKSXyoZm4w2OC6IU7PIhhpet8jCgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7ACzCH4KlgMsYfLITLEWFbl4QPWwCm8AV1YaklL3Y0=;
 b=K+BB0hx4B4fROxKPWm8G4OSUcgyNQ0aa0n9oXu7bcJ+xt0El2eMz8f4CN4OSfBbRXCwanB8Qm0yxl/ZV0W0/bJtWY+0TckF5LJc+DPtNav5KfbR90zSgmrcF6sxGvqiDYeNOqoAev4DGpo97rMTwu26aNRDCQt20Kgo2RWcOEF+Pt01WSLXpI4b0J4oiQf9r7c06hVF45h9bk10QCOR2G0wi+Y9JGMkYczxAwIgd6FAeDZBc4gHFEfE8MtEzZCkwGS52PrrvinOMadyRkJyCOv8Bq1M/iqgdzvmp+YQLMvHwEMeeD+aoFAsBcDClnHgBQ/51EPKY6Oo74v6dM/2Csw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by PH0PR02MB7800.namprd02.prod.outlook.com (2603:10b6:510:53::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 21:09:54 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::dfab:83e2:41:20c8]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::dfab:83e2:41:20c8%5]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 21:09:54 +0000
From: Brian Cain <bcain@quicinc.com>
To: Taylor Simpson <ltaylorsimpson@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>, Sid Manning
 <sidneym@quicinc.com>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "ale@rev.ng" <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: RE: [PATCH v2 8/9] Hexagon (target/hexagon) Remove unused
 WRITES_PRED_REG attribute
Thread-Topic: [PATCH v2 8/9] Hexagon (target/hexagon) Remove unused
 WRITES_PRED_REG attribute
Thread-Index: AQHaK7VJPWwwiUvuY02l6OiD9RPX37DVTZlA
Date: Thu, 11 Jan 2024 21:09:54 +0000
Message-ID: <SN6PR02MB42053D60FC80F926E1EEA6C9B8682@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20231210220712.491494-1-ltaylorsimpson@gmail.com>
 <20231210220712.491494-9-ltaylorsimpson@gmail.com>
In-Reply-To: <20231210220712.491494-9-ltaylorsimpson@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|PH0PR02MB7800:EE_
x-ms-office365-filtering-correlation-id: 7f964045-346f-436d-5b9f-08dc12e9a8b3
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eHCxWjB2I5EoufRj3jg9WCBhrHSElx1ZORFYskekfs/ajtXSHTVL60dygk4In/D5mDWPm7CTrZzO5O/uE7ixgbAg3eNfyYyNJr5ez1t06/KpGy6rGvlcKcCwttg/N0zILyBGJpLlEIBeXERqKU4y5g6OEPpRUvuUldjAdN6axkp+UFpiJBZ4H+xwAcsAYmS6yQPBQb/FU6EfbMG28cMWS4AoeVrtX3MFFkwrlj5LxRpPY89Y8zZIWJoYjx+KTm/kvcAJ72g+vL4OfOtvJmqjXFic4M7CDXL90AD++IHbR0AF18JVSG8k8NXy1PR4VSuFaIb+bjz77lo4a2S2Z0uWId68SWIRREwtaMWIuB60oyzqI88z9OrwFESyfQ65HLbZgP8pcYTNM5oS+jjx4WM24UHbqe7gK4QrRsTgcHerliw0uPqZU2kH3kplVE/DUYxm/vnKjq0hLDVBJ2XcQix7RL2hTbzQJOoEpUX5aA4oJTwwp1ayNv1nQ3O1ZAkYMRY2xGfbf5OCRqqjFpfwp1A1hff+B+yz/4uIlrbFuuhjTf/9ZrjL9QhfVkvvQtmPzTOEo7agaIqQmIeiqLzRPD6K1ydMgQ5nVncp/8tHcl5uLP/64262gArOqObZLiB/KivsempgEmkH6/qDm1wouJlvCVRKsClvjaFoDEIxCZa7Ip8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(39860400002)(366004)(136003)(346002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(55016003)(66899024)(7696005)(71200400001)(53546011)(9686003)(122000001)(38070700009)(86362001)(33656002)(5660300002)(478600001)(26005)(6506007)(83380400001)(8676002)(52536014)(8936002)(4326008)(38100700002)(76116006)(2906002)(110136005)(66946007)(41300700001)(316002)(54906003)(64756008)(66556008)(66476007)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmhUbVp6QVJ4aHJhcXFhYXRqc3lRSXhmZE1wMmJqcnp2OHp6bTc3ZzZLRUs2?=
 =?utf-8?B?TkM3aGhONStzRU1HcFZmam5IOGNxVWNuT3dmWFpIaGorYWlyNEFaMzF0Y2ZS?=
 =?utf-8?B?MkRUMmJ0eVlOTFhRcnlwQ1VBZVh5d1VwR0pnbHBxMWdkb2s2ckxYelhjUTNo?=
 =?utf-8?B?Ry8ySmxxTndBSnV2K3lBT3dwTE1SVm5odWQvUWNlbTIwUTU1bkU1cDBrelJu?=
 =?utf-8?B?ZHFXcVZ4dS84czZnNmh6M2Q1d29GSmZKMnR0b0t4WmFvTUtmWUFmOStsZDNB?=
 =?utf-8?B?em5ibUYxMG04NGRDaUQ1U2U2WTgvZ3doVVJJdEcrbEE2OVVBUDRnN25pQmh0?=
 =?utf-8?B?ZHluWE8vdFBsNUE3QUlZRnR2akVUWnlDSU5MTlkwWTRiZjZGZ3BwdFYxS0pL?=
 =?utf-8?B?Z0hpWjVzZldCWDY0YU11eDg3R0hGN3dOREFDNjlJV2Q1WE51WGxsUXFKc09m?=
 =?utf-8?B?Z2RUTG1GUFRCNDhwdy9abTlXdzVTUHNlRWFhQVN0emJCZEVkRDgxSVlSS2d2?=
 =?utf-8?B?M3R1QmVPZXhUQ3lUczUxbXBqL1dTVGEzRDF0ZkN1K1RBUGp1UDJPQklScXd5?=
 =?utf-8?B?eEx0bkRpamlQdmlISnJuUnptVWNBZXZhNnFKSzFMTnFXMjFrRTM5RU5hcFVx?=
 =?utf-8?B?NGt0K2hPU0w1dDNIUGxjYnpkUmdFNENTanJNRTdzd2hvWDhnRXNsMmZlbkw3?=
 =?utf-8?B?WE5QeHdEdmozRWcrbFRhV1dycW55bGI3NEI0Q3dSSmxyNURDSVpJRmY2cjdo?=
 =?utf-8?B?S0xmaEs4OWdPS1BIdUdnMmh2MVFlUWRzUWc1U1NPS0dtNVBTVVJxcjQzMHFK?=
 =?utf-8?B?Rzh3cE9memFGSHZtakw4MWVoNzdSRjVXYmN5ekd4SVNhVTdReDlFL0RjOVps?=
 =?utf-8?B?eE0zS0RwYWpjaFI0akx1S2JnVm44U1Q1SmFZMEs5T0pnRnpKcTlSMmx2aFh6?=
 =?utf-8?B?b1pEMnFkeERlb0VERmgyK2Z0M2VxZWtuL0tKYjU1aXFDVGRNS3VySlVKTFRJ?=
 =?utf-8?B?cEt4Z0o5RGRJejl2M2lGZkVWd0pNbE9nLzdZTk1pTHhWL28zRjBySUNObXFl?=
 =?utf-8?B?a203WThDMkwrNlA4SUVyUStOdHZ5NFowMjJpeWFWaDd3SUZwYlpjZDI4Mmhy?=
 =?utf-8?B?R3dReFpCR0ZTR3BJQzRBWEJXMzUyd1lxeXVQK2pjRFRCNGdYMFd4Z2VUUlpP?=
 =?utf-8?B?RnRLb0tVU1o2aGJ2dWNaNUk0QllNQ3VubG5zL2VyKytCdjNsSHNOejZ1Zko0?=
 =?utf-8?B?RHVMK0JBWGxPYXhKQ0tPamx1M1IyMm8vc2NZOHdFQ3dYNFpzVjJ6T3BvZ2pp?=
 =?utf-8?B?cHFhaDVTYURMb0FSbENjalpXS0NlZVI1Rk1DTC8zR0xnTFZ1RUdhYVZvQ1lI?=
 =?utf-8?B?VTJXVC9ORGFQSGIyQ0ZGUGVBS2JWUjdXMVpPSHA2eCsyTS9vak1wdWsyRkNN?=
 =?utf-8?B?ZThNU1YzOXpRMHloQkxhWHFxSkhwbmt0ZFZFaW1tRldXRmlnOFVjcXBjTWJD?=
 =?utf-8?B?blBqc0JJWkNhSUxSRnlUNTMrNmo4czByVmtQM21xdVprTzlCWmdNeGFNTnYr?=
 =?utf-8?B?K1RIY2N5bjYrNE9scHdIcWhrSXQ4ZllBZDN0cHUvOWhsR0QzRVp6VVhNd0hS?=
 =?utf-8?B?SENkc3dxWFdNdjBUd0tndzNWa3VEcWRLTHRTQ3FkckREQ3FZbzFjbUEzc2Zi?=
 =?utf-8?B?dUN1TUd6MVA4T3FBTEpQdS9QTzErTkNBZzd6cmwyR1RZU2NYTWx0aWZYd2lz?=
 =?utf-8?B?VnU4a0FJMVVhRVdFZmMwYXNIOGNad0lBNnpZUE5jMmZjTkJxdmZqSU1XRmZ5?=
 =?utf-8?B?S1dqSmFjSGVpelJCWnZPOVYyY3haVDR4Tng5NnlyOWhBako5TmtsYWd2aTJL?=
 =?utf-8?B?eFEvRW9PWUg4dkJzaENReGF0WkZRMDltSCt3SDlZMkdjbjk3eHoxOW5Dd2Ju?=
 =?utf-8?B?aFQ0RnUrdEM3U1AzNzVWcy9rNlI2RlFrTjJpSndLZlJaM3d3c2w5WXFJOFI2?=
 =?utf-8?B?eGkyQXdYc2MxZ2RrVHRhcW9TUlVqaGJoR2FRa0xDUVhSaFdrdEdiaTJHYUR2?=
 =?utf-8?B?emsyWkVZbWIyTkgyeXJmWTNRNGovUzVJQjhsWFJxZDlVUC8rOEg4OStqdVJ6?=
 =?utf-8?Q?P9B49iLda7KvLguEHCVIfVhiL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v4Sb206XPtlCCg9v+N4LiYo5dwDgtaF+Gp4slCfIErkZ0OGgvac3ky2Mth9PX4zrS9acKM/61GzyWWQr2VrXAhyUf3SNpebp0Whyvthripu2PPNVGHCCvybw8+bMpRhFh4QPyHtGWS3+fssgJd4MsM/AL2JproSZmweUCQ2bAQXN+pYHmaqsBXp8XWcADtDmHeqfhW3UHk/ucUte8l2q4bctfuuITnZ+mxSys4f1vSCsmM+xhg8V9ugOCjSlM/AvBOCSMCAA1sp+vPFOPQMoffzMBsbw46IWVEO1P81cBjeeVqD4HtlDQd+jNyoZpU3yBlcZS2BF6TR+ByjortTszbXGqnNp4Gjy3wFH3Eyn37huGKSV4aYowrwAvkSb+6xaoevXIdrglSwQpJpbJS/lemQ+EJjGdcABHoc8yjZ1W2D3rXUQBRNDAQxvDFlPYihLgGTU9i04FXh3BGd8hmMaTJHrA4KGNYl1g3AuyZqcem4qWKfQ4tNUJGPrYgxa6zpgrXPurMp7Kl+R51ju/6nIewr6BDMedbLR0vQUKSk/vbnxPKayaowsfCrRPTNtWFl0H3zQwq2Xt+rS7+LXRKNKVQ5B4ndZMtK7b0hlsUg1xZce/zMMapJCmF7LVv1OkJVD
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f964045-346f-436d-5b9f-08dc12e9a8b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 21:09:54.6573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 11wnDwEDes79lt7RAeRshNxDYCazdO/LlQfm0gYy3wywn30j7ghTdJdoeDp18xtk7S3oD+d74wykxbKBZsVKYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7800
X-Proofpoint-GUID: aDSU3gr4wqZ4fTSvktS6PQ845N94v9oZ
X-Proofpoint-ORIG-GUID: aDSU3gr4wqZ4fTSvktS6PQ845N94v9oZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=388 bulkscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110164
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
PGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4NCj4gU2VudDogU3VuZGF5LCBEZWNlbWJlciAxMCwg
MjAyMyA0OjA3IFBNDQo+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IEJyaWFuIENh
aW4gPGJjYWluQHF1aWNpbmMuY29tPjsgTWF0aGV1cyBCZXJuYXJkaW5vIChRVUlDKQ0KPiA8cXVp
Y19tYXRoYmVybkBxdWljaW5jLmNvbT47IFNpZCBNYW5uaW5nIDxzaWRuZXltQHF1aWNpbmMuY29t
PjsgTWFyY28NCj4gTGllYmVsIChRVUlDKSA8cXVpY19tbGllYmVsQHF1aWNpbmMuY29tPjsgcmlj
aGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZzsNCj4gcGhpbG1kQGxpbmFyby5vcmc7IGFsZUByZXYu
bmc7IGFuam9AcmV2Lm5nOyBsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20NCj4gU3ViamVjdDogW1BB
VENIIHYyIDgvOV0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIFJlbW92ZSB1bnVzZWQNCj4gV1JJ
VEVTX1BSRURfUkVHIGF0dHJpYnV0ZQ0KPiANCj4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5h
dGVkIGZyb20gb3V0c2lkZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdhcnkgb2YNCj4gYW55IGxp
bmtzIG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90IGVuYWJsZSBtYWNyb3MuDQo+IA0KPiBUaGlz
IGlzIHRoZSBvbmx5IHJlbWFpbmluZyB1c2Ugb2YgdGhlIGlzX3dyaXR0ZW4gZnVuY3Rpb24uICBX
ZSB3aWxsDQo+IHJlbW92ZSBpdCBpbiB0aGUgc3Vic2VxdWVudCBjb21taXQuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29tPg0KPiAt
LS0NCj4gIHRhcmdldC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jIHwgIDEgLQ0KPiAgdGFyZ2V0
L2hleGFnb24vaGV4X2NvbW1vbi5weSAgICAgfCAxMSAtLS0tLS0tLS0tLQ0KPiAgMiBmaWxlcyBj
aGFuZ2VkLCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi9hdHRyaWJzX2RlZi5oLmluYyBiL3RhcmdldC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jDQo+
IGluZGV4IDIxZDQ1N2ZhNGEuLjg3OTQyZDQ2ZjQgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9oZXhh
Z29uL2F0dHJpYnNfZGVmLmguaW5jDQo+ICsrKyBiL3RhcmdldC9oZXhhZ29uL2F0dHJpYnNfZGVm
LmguaW5jDQo+IEBAIC0xMTcsNyArMTE3LDYgQEAgREVGX0FUVFJJQihJTVBMSUNJVF9SRUFEU19Q
MSwgIlJlYWRzIHRoZSBQMQ0KPiByZWdpc3RlciIsICIiLCAiIikNCj4gIERFRl9BVFRSSUIoSU1Q
TElDSVRfUkVBRFNfUDIsICJSZWFkcyB0aGUgUDIgcmVnaXN0ZXIiLCAiIiwgIiIpDQo+ICBERUZf
QVRUUklCKElNUExJQ0lUX1JFQURTX1AzLCAiUmVhZHMgdGhlIFAzIHJlZ2lzdGVyIiwgIiIsICIi
KQ0KPiAgREVGX0FUVFJJQihJTVBMSUNJVF9XUklURVNfVVNSLCAiTWF5IHdyaXRlIFVTUiIsICIi
LCAiIikNCj4gLURFRl9BVFRSSUIoV1JJVEVTX1BSRURfUkVHLCAiV3JpdGVzIGEgcHJlZGljYXRl
IHJlZ2lzdGVyIiwgIiIsICIiKQ0KPiAgREVGX0FUVFJJQihDT01NVVRFUywgIlRoZSBvcGVyYXRp
b24gaXMgY29tbXVuaXRpdmUiLCAiIiwgIiIpDQo+ICBERUZfQVRUUklCKERFQUxMT0NSRVQsICJk
ZWFsbG9jX3JldHVybiIsICIiLCAiIikNCj4gIERFRl9BVFRSSUIoREVBTExPQ0ZSQU1FLCAiZGVh
bGxvY2ZyYW1lIiwgIiIsICIiKQ0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4X2Nv
bW1vbi5weSBiL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkNCj4gaW5kZXggNDU2NWRkMTk1
My4uY2E1ZTk2MzBjMSAxMDA3NTUNCj4gLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5w
eQ0KPiArKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5DQo+IEBAIC05NCwxMCArOTQs
NiBAQCBkZWYgaXNfY29uZF9jYWxsKHRhZyk6DQo+ICBkZWYgY2FsY3VsYXRlX2F0dHJpYnMoKToN
Cj4gICAgICBhZGRfcWVtdV9tYWNyb19hdHRyaWIoImZSRUFEX1BDIiwgIkFfSU1QTElDSVRfUkVB
RFNfUEMiKQ0KPiAgICAgIGFkZF9xZW11X21hY3JvX2F0dHJpYigiZlRSQVAiLCAiQV9JTVBMSUNJ
VF9SRUFEU19QQyIpDQo+IC0gICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmV1JJVEVfUDAiLCAi
QV9XUklURVNfUFJFRF9SRUciKQ0KPiAtICAgIGFkZF9xZW11X21hY3JvX2F0dHJpYigiZldSSVRF
X1AxIiwgIkFfV1JJVEVTX1BSRURfUkVHIikNCj4gLSAgICBhZGRfcWVtdV9tYWNyb19hdHRyaWIo
ImZXUklURV9QMiIsICJBX1dSSVRFU19QUkVEX1JFRyIpDQo+IC0gICAgYWRkX3FlbXVfbWFjcm9f
YXR0cmliKCJmV1JJVEVfUDMiLCAiQV9XUklURVNfUFJFRF9SRUciKQ0KPiAgICAgIGFkZF9xZW11
X21hY3JvX2F0dHJpYigiZlNFVF9PVkVSRkxPVyIsICJBX0lNUExJQ0lUX1dSSVRFU19VU1IiKQ0K
PiAgICAgIGFkZF9xZW11X21hY3JvX2F0dHJpYigiZlNFVF9MUENGRyIsICJBX0lNUExJQ0lUX1dS
SVRFU19VU1IiKQ0KPiAgICAgIGFkZF9xZW11X21hY3JvX2F0dHJpYigiZkxPQUQiLCAiQV9TQ0FM
QVJfTE9BRCIpDQo+IEBAIC0xMjIsMTMgKzExOCw2IEBAIGRlZiBjYWxjdWxhdGVfYXR0cmlicygp
Og0KPiAgICAgICAgICAgICAgICAgIGNvbnRpbnVlDQo+ICAgICAgICAgICAgICBtYWNybyA9IG1h
Y3Jvc1ttYWNuYW1lXQ0KPiAgICAgICAgICAgICAgYXR0cmliZGljdFt0YWddIHw9IHNldChtYWNy
by5hdHRyaWJzKQ0KPiAtICAgICMgRmlndXJlIG91dCB3aGljaCBpbnN0cnVjdGlvbnMgd3JpdGUg
cHJlZGljYXRlIHJlZ2lzdGVycw0KPiAtICAgIHRhZ3JlZ3MgPSBnZXRfdGFncmVncygpDQo+IC0g
ICAgZm9yIHRhZyBpbiB0YWdzOg0KPiAtICAgICAgICByZWdzID0gdGFncmVnc1t0YWddDQo+IC0g
ICAgICAgIGZvciByZWd0eXBlLCByZWdpZCBpbiByZWdzOg0KPiAtICAgICAgICAgICAgaWYgcmVn
dHlwZSA9PSAiUCIgYW5kIGlzX3dyaXR0ZW4ocmVnaWQpOg0KPiAtICAgICAgICAgICAgICAgIGF0
dHJpYmRpY3RbdGFnXS5hZGQoIkFfV1JJVEVTX1BSRURfUkVHIikNCj4gICAgICAjIE1hcmsgY29u
ZGl0aW9uYWwganVtcHMgYW5kIGNhbGxzDQo+ICAgICAgIyAgICAgTm90IGFsbCBpbnN0cnVjdGlv
bnMgYXJlIHByb3Blcmx5IG1hcmtlZCB3aXRoIEFfQ09OREVYRUMNCj4gICAgICBmb3IgdGFnIGlu
IHRhZ3M6DQo+IC0tDQo+IDIuMzQuMQ0KDQoNClJldmlld2VkLWJ5OiBCcmlhbiBDYWluIDxiY2Fp
bkBxdWljaW5jLmNvbT4NCg==

