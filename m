Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A967CD28E
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 05:12:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qswyG-000577-Ul; Tue, 17 Oct 2023 23:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qswyF-00056y-6L
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 23:11:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qswyD-0003As-6E
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 23:11:42 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39I2OOuG027840; Wed, 18 Oct 2023 03:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=9cSVmBk3Z6TckFpGan+zEKWVA33UoZDZDZain1VUwr8=;
 b=h9hc2LHKOoh5ZfoJ856cjWwBvnaHqjQfrqKUxWzbIYwhgduHyQGN6uMCuAGhRh0xvILU
 KJNZCaDmbMYQRJNi/w6uuQJuNuZTmEJrHT3LM25ahGhZBMOvWGoKs7fz4FnLxzHxyhwx
 IJhKVPYAldzJFIxYWQ+KP/x6gLPzrWcIX2C/GAQJY3ijhP/6CERT02AHxXJmgrYt8bfU
 pNKNQ9ffAOfOkI9o4E6pQmMQaz5sUu204Ug4nTPv74zJDZWv7y3n1L3avJ871drIl10t
 50Y5Kf5/PM2ilaAJqw6OAKdiNpknei8Bt+dkdm3b+AVU/Hbom9bGDe+7KqyLR6CSgBIX nA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsnejac4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Oct 2023 03:11:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RV6M4UqChb91Z9/E2mT6ocYH8lEO+OY+HRXx68mVGv5TfcHDGVJRCF9BCyBDegXOoPTvKPPQD9Amn5bhWqSyIBnvM2PtRJXOTykYC90lcDSqJbHKSgwFl/e0FulSMzcFIYdam4Mgg1YM9PLOcIb1liboIqFa98xoS0Qn/3fSmqt6SRkvPUkVqc6DmRe1Pd2GX+2hwguDFZOCsR2BvBHlMTpx/IopGucqseVT6xCxMVCMw+PBDhfHegN8hs/tRgDS1rRWVN6AnwnY94F+cJK5OofqDNEtrjBRSs1cccrtcvPncUTeGbvZPoz5dqdfh7plbZgP+WnUkBsPWO2l6VRIRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cSVmBk3Z6TckFpGan+zEKWVA33UoZDZDZain1VUwr8=;
 b=Gj+W2mBop5exnGVAO5F8t2yyLaOX7W1+gt4yUkOrWSSpVvE4tbD7OWaxz/JMHfP2AbMnLuWJr32bsQJgdVVY+BfoUDyLxZxlt1IH2ivBmDw+KfF26n23ew6pVs6PEOInNbu5f5N7bukn/gdCdTUqlHNywIs+Zv7EHhWRMo/ycKK8h8HRlwR0JfiQDrEoyY6PGU0QugmSsVk22VnAVMrLp24J2v9usDXkqBlFP9TV/ZaBuicUCvmmP57+YAsS7YQXtP79POUwgFx2vqUylU9pjA2UFopd1G/9BDGi2G7figApXiHZWROcKDfaj9Y+GIHwmr0WW918noaDb6bcZuOg+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by CH2PR02MB6725.namprd02.prod.outlook.com (2603:10b6:610:ab::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 18 Oct
 2023 03:11:33 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::9157:77f0:1ee8:40fd]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::9157:77f0:1ee8:40fd%5]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 03:11:32 +0000
From: Brian Cain <bcain@quicinc.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "anjo@rev.ng" <anjo@rev.ng>
CC: "armbru@redhat.com" <armbru@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "Matheus Bernardino (QUIC)"
 <quic_mathbern@quicinc.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "ale@rev.ng" <ale@rev.ng>,
 "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "ltaylorsimpson@gmail.com" <ltaylorsimpson@gmail.com>, Thomas Huth
 <thuth@redhat.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2 3/3] target/hexagon: avoid shadowing globals
Thread-Topic: [PATCH v2 3/3] target/hexagon: avoid shadowing globals
Thread-Index: AQHZ99p0kpQSem9BGEaufyVyuucJMrBA/p0AgAAJZICAAOsEIIAAkM6AgAxtvaA=
Date: Wed, 18 Oct 2023 03:11:32 +0000
Message-ID: <SN6PR02MB420574C86FA3C886818577DCB8D5A@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20231005222206.2784853-1-bcain@quicinc.com>
 <20231005222206.2784853-4-bcain@quicinc.com>
 <48c5233c-c294-f50d-a438-f7f6a63c113b@linaro.org>
 <187100e7-a516-4024-1739-a08c630d76f3@linaro.org>
 <BN7PR02MB4194900078A1AA6E067FE20FB8CEA@BN7PR02MB4194.namprd02.prod.outlook.com>
 <0aa445c4-d39d-e28a-6bb0-00f7b9f12bb0@linaro.org>
In-Reply-To: <0aa445c4-d39d-e28a-6bb0-00f7b9f12bb0@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|CH2PR02MB6725:EE_
x-ms-office365-filtering-correlation-id: 2129f77b-5ace-4593-b4dc-08dbcf87ee3c
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SwppJD6xFHgNCNv/JhETym9Pip3unNHyJ+zwi1xVuShpujB7m4BmIDsoGzoYJpHFNyQuKTw27VZ+z3eNhU2gvXqya1qeTcr9ilXWZarUslaP0jCi23CayHVWAlyviv0DFZgaaHjBdf4T6kouHX4nZ0OyQuOAA2P/V4p4Thuwm4dSQx7Tgzx5SrgS5sMOUB/xFLoT95h9T2w7cdIrHtayjKmhP4NdlpYbaqd9V76PHyb95hr+mnt/5bl7lfLIQPjm7K4qE0q8HkGw15Bz0f1WX3k+p90HQ+/wIbtwAEPN3cukrVs6qSmu3vrBC4oC18T4x6kC8UwDGk2JuhGGiAPGTNHODq+7CKFAo0pLGyOIAA6y3j2JsD9GtzTGDPOvoVFezdh32Lrp/fZaDrmfCGutqnd4Aq8sD0TXV8Wq22qcHo6atgDJ6elcczZGTaZzQRIf58KOqXsW7jdgoPXhHBevg0ixGmjlEk6Db9i4xv5h6/4WKDvDal4JyVyBbMA9X7h+ouwmQJgecVemZyp0OUbf4BM/zOheiSzheibTDgtOPz76aHNHM5X93xaK5iDxPIVvooQdTQwJnXbxz9kt9OQP8IKlJO9S61uEQf5Trx9yPwE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(41300700001)(8676002)(7696005)(53546011)(55016003)(6506007)(9686003)(316002)(478600001)(86362001)(33656002)(122000001)(38100700002)(110136005)(38070700005)(66556008)(7416002)(2906002)(66946007)(76116006)(71200400001)(66476007)(83380400001)(5660300002)(26005)(66446008)(8936002)(4326008)(966005)(52536014)(64756008)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzN3QzY3aHNKalFWS3RhSjRZQWtRZnhtQjViUk0xVUh4eHhNOHVkcWZHTHBz?=
 =?utf-8?B?cHVIeTJzcmx1N3R1R0JXc0NiOHZjUjVZcGNBbDJCek95cGQ4UmZjc1BxYzBz?=
 =?utf-8?B?WkVYS3V4R0lrTnlVVWUxbGZwMXhMOUw4azhoWnNlaHhlU2ZDUXBvMnlMbG1a?=
 =?utf-8?B?NVJURkZPWUNBdUVyb2Y3emFNeTNiYnVoVW85MnNsZHc2c3FqM3NjTTNKWjZN?=
 =?utf-8?B?RUxxTmpGRUNyT2lpZVlJU0VRbm56bHZwcERaRTRhRWU1MlZEckJIME5TWEVO?=
 =?utf-8?B?eXh1dklQT25YcXlSMHA5eXZ4RURKMUNBQnBhaVIyMHlNbGZmbXhXWUNzZHZW?=
 =?utf-8?B?WExTRVBIeWcrWXBJcW0vMlN0MlF6cWV1RnpDZThNUXRWV3gyblRrWGE0eGh5?=
 =?utf-8?B?dXZmcG1Vejc3anFsYVYrdGJjVWZnTmd2elJuZXBlTCs0ZWgySDRvaUlCSFZL?=
 =?utf-8?B?NU9zcEw1dVJ4dkJ0WFZRa3c4VnVlVitLZDRkVUhhWGVzYzYwV2hudGdPSGxr?=
 =?utf-8?B?WVZGb09MU0x5Z0c0OGZYVmh6dm8wbFRXcjc1UnNJRERiNVIvYUVUcjRGMnFZ?=
 =?utf-8?B?TkNqY3ZCdm9nMXFKc1lxOFFvT3V2OXJKS2RCaXdMSXlXQ2ZjQnZUSWJXMmR4?=
 =?utf-8?B?ODRwU2ZTaGgxWkZ5UncySkJMdWtKZFkxdmRuUXhDU1hRS1RYR2lPNysyb3ZJ?=
 =?utf-8?B?UVJvRUxLZjRpQVpLbFh2ZHhoeW9LWnNXZ2pWTXUzajJzOTl5MW9WMnhUc3ll?=
 =?utf-8?B?TE5rU0U5VTRmMGxXRG1rb3A2d1ZSWnFMUWdiMGVTSUJkekdmaEdQcU5xMzk2?=
 =?utf-8?B?QXlwMlhMMjEzMGcrWXZKSkVYZjJKY1h5cDFwMlBQZDJLWVNFNE5Qb2gyc25m?=
 =?utf-8?B?MkU1WTBXSHF3NURuMThlbmlqSmM1QVlzZ1A1ZHo0alVRNnBNRGFKWERia1Jp?=
 =?utf-8?B?T1BEdFpJWjBuY2JLbm5abkljeVFROXdDbUNVNXNQR0ZmOGE5Nlg5cVFSWkM1?=
 =?utf-8?B?UnM4R1I1TXljTUpyelljSDJ3TDNMbTdySDJhdEhYVU0vUlhBNXY2V05lRlo3?=
 =?utf-8?B?emxVRUVKdzBTbldUR0xVb1ZTbFdmOXhKeHlRYUdyWTNwY3NEZDBhc0JTV0Fy?=
 =?utf-8?B?QXhIM2ZtMEdQcWxuM2FPZXY4K2ViSXJJMHU2MGFNdVpRMU4xYU1mamxZUEVq?=
 =?utf-8?B?WE1kTElNUUpDYVNxRy8yeFA1UnBKMXZ6NUF4VThpVXVwSENmQ0hnSkRISDNa?=
 =?utf-8?B?U1FRaUx2QStDWU9UZmt0RjJ5dThLMFRnUU9FLzVjamxqNFcwYXpoMzU3dEt0?=
 =?utf-8?B?QStqREE3Unp5dFgrUnpYRVN3c0F3MW5Rd2FkQmFqYmhTek1WcjRjRUpZZlUy?=
 =?utf-8?B?dXdCQmIzQmFBMWFJa2F5cUVuWDVqVC9naWNqb2plM3luQmthT0xXZEtvNDc5?=
 =?utf-8?B?Qzk5b21MV1czN3o5K2hJVHRjaTFEUGN1SFduNkE2a3Bjb25pNVpoOXlJZm9y?=
 =?utf-8?B?UC9vTVZtbmFvMkI1aTRqRzZKdVRCei9tWXZFa2VUY05pT0hPYUVmdDNQV2pV?=
 =?utf-8?B?KzdJRFdNY3F1VGVGOHlGS01UaFVNZW5wUnBWZHNRSnpJTE51VnJQUnFCR29I?=
 =?utf-8?B?cmpOVUM5N3V2MzI0N3Z2aVBxTWZCcm56Z0xoc1NJb3VwSFh4TVRvdEFVdFU5?=
 =?utf-8?B?eHNkUWpNUlZSTG1UQjJyWTk0c3grcFdac0VPcGtLYVk1THU3TjFXaDNVWEdP?=
 =?utf-8?B?SjRwV1B4YUNzODNFalJqWWJzWktqb0l6V0FuNlBxZ0lmemhXZkNpZHdESEdm?=
 =?utf-8?B?Vi9tK05BUHcrYXAvSEU4VmdVLzVEYmwzTkxqNVliN0lMRks1Y0RpZ29UTFB5?=
 =?utf-8?B?MWVudDIzWDN0eGJLdDJLM0phN1RQRFU5YkZtM1dkZlpaVVRMS2pCVjhRbjdm?=
 =?utf-8?B?dkxMaW1TK1lMNWJ6RXFLR21yMkJzOVp6b3c4QUxCeHd1aVdTYU4yTk8vVGFh?=
 =?utf-8?B?SFVLUlN6UzJ0VHNwSnhhckU4SWpmZ2lKQVNCcnRtbGoxVk40V1hhUW9RUnBp?=
 =?utf-8?B?MEJ6eklrTjMwQlRMK0lUbXNEdklRdVFkZWQ0V2UvSEppWU4zQzUxTHBMK3Y0?=
 =?utf-8?Q?2xvg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ijAm+MevpgyuMmKTb+fM26uItVLhCdKAiHseLia8dXsZm/xjJnNikmi3MJViXdIiztxBtxoOqTG+Ar32FjC+WPLSv0XjWTUGJJw7s+BNBV5FjMx3ymM66onDYZxOrlRhSOTnnjI1rBQZrvuTF90BQsZQS8r9fF0Y+YJd2KJsOTOIE604meeGnoXfGUdfcTikqX5hZvgOL9spCr4r+ItTyip+DX2bM07Te2KpHX4ql1jsjF0Cx91FMOgjRaa4kSJzO3Yw3xG3qM1M5FMDP4Tv4GWUASMSbbF4WYdf52lbrSpgig3mj1fxIwqMa5EayeJam01ucE/6Ogg2BT0tSWG9VECU6q6rGO7BGoGBlu3wJKGy1jHA3+opCwO6PWWqyC7Z+F8HLjkIYHyvmlEko/z+Gf235zr6jEWS2oZEkbJ9eELWCoLZaAYYbsPqHIatF3cUgLzGF0QdmuHhHS0+j07Yna3Lcju1VnDwbLQp/7GF+PlkihmIDAoubcSpo8Y1gXVi05YRmuSTz+2VGgTbG/OP9GZBpl7S1y1OnIEnWTbLZUjEcOS3qlZaA/gjtLaTotd+Dwel2ooQm94sbpdfJ7+Xo9i4TDhD8knjMteLqfjV1++xRHkci1nzO2vcdrizYPOrBVa+/OjfJxY7iIFgCenuEBKPgrZzmOWuYDhspPrC1vT0HU5RfQoq6KnOMQyWHgbh0tDvxtcv0JqtOXRm3UyJNb5jxYAkooGzhRE/hEVxvntnzCyHaXs80wDl9d5qamDAeWN71ha2doLCMuOK1wRT+/51Tre3gV48YBzCYm0ddLNTo053rVokU7weHkzVLva4r2HuaJj2Z7P/KPxYcaDlgz/WrxGEPez9cHs+JCTVz0/ENvWaSRK/5sxer/9hbdP+
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2129f77b-5ace-4593-b4dc-08dbcf87ee3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 03:11:32.7105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PAZUjsojW2dU7AW1nyNbtWiAG+gzoh6OQwAc+TBTcVkMfoNAQQQ5lD6CAkK5MZ8MXWracU5ki9tcbkCFms+yfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6725
X-Proofpoint-GUID: I3AuxAYFfE12srZAcpvbG0K_uU6feWKh
X-Proofpoint-ORIG-GUID: I3AuxAYFfE12srZAcpvbG0K_uU6feWKh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_08,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180026
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDEw
LCAyMDIzIDEyOjIzIEFNDQo+IFRvOiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT47IHJp
Y2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc7DQo+IGFuam9AcmV2Lm5nDQo+IENjOiBhcm1icnVA
cmVkaGF0LmNvbTsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBNYXRoZXVzIEJlcm5hcmRpbm8N
Cj4gKFFVSUMpIDxxdWljX21hdGhiZXJuQHF1aWNpbmMuY29tPjsgc3RlZmFuaGFAcmVkaGF0LmNv
bTsgYWxlQHJldi5uZzsNCj4gTWFyY28gTGllYmVsIChRVUlDKSA8cXVpY19tbGllYmVsQHF1aWNp
bmMuY29tPjsgbHRheWxvcnNpbXBzb25AZ21haWwuY29tOw0KPiBUaG9tYXMgSHV0aCA8dGh1dGhA
cmVkaGF0LmNvbT47IERhbmllbCBQLiBCZXJyYW5nw6kNCj4gPGJlcnJhbmdlQHJlZGhhdC5jb20+
OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAzLzNdIHRh
cmdldC9oZXhhZ29uOiBhdm9pZCBzaGFkb3dpbmcgZ2xvYmFscw0KPiANCj4gV0FSTklORzogVGhp
cyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdh
cnkgb2YNCj4gYW55IGxpbmtzIG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90IGVuYWJsZSBtYWNy
b3MuDQo+IA0KPiBPbiA5LzEwLzIzIDIyOjUzLCBCcmlhbiBDYWluIHdyb3RlOg0KPiA+PiBPbiA5
LzEwLzIzIDA4OjA5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gPj4+IE9uIDYv
MTAvMjMgMDA6MjIsIEJyaWFuIENhaW4gd3JvdGU6DQo+ID4+Pj4gVGhlIHR5cGVkZWYgYHZhZGRy
YCBpcyBzaGFkb3dlZCBieSBgdmFkZHJgIGlkZW50aWZpZXJzLCBzbyB3ZSByZW5hbWUgdGhlDQo+
ID4+Pj4gaWRlbnRpZmllcnMgdG8gYXZvaWQgc2hhZG93aW5nIHRoZSB0eXBlIG5hbWUuDQo+ID4+
Pg0KPiA+Pj4gVGhpcyBvbmUgc3VycHJpc2VzIG1lLCBzaW5jZSB3ZSBoYXZlIG90aGVyIG9jY3Vy
ZW5jZXM6DQo+ID4+Pg0KPiA+Pj4gaW5jbHVkZS9leGVjL21lbW9yeS5oOjc1MTpib29sIG1lbW9y
eV9nZXRfeGxhdF9hZGRyKElPTU1VVExCRW50cnkNCj4gPj4+ICppb3RsYiwgdm9pZCAqKnZhZGRy
LA0KPiA+Pj4gICAgICAgaW5jbHVkZS9xZW11L3BsdWdpbi5oOjE5OTp2b2lkIHFlbXVfcGx1Z2lu
X3ZjcHVfbWVtX2NiKENQVVN0YXRlDQo+ID4+PiAqY3B1LCB1aW50NjRfdCB2YWRkciwNCj4gPj4+
IHRhcmdldC9hcm0vaW50ZXJuYWxzLmg6NjQzOkdfTk9SRVRVUk4gdm9pZA0KPiA+Pj4gYXJtX2Nw
dV9kb191bmFsaWduZWRfYWNjZXNzKENQVVN0YXRlICpjcywgdmFkZHIgdmFkZHIsDQo+ID4+PiB0
YXJnZXQvaTM4Ni90Y2cvaGVscGVyLXRjZy5oOjcwOkdfTk9SRVRVUk4gdm9pZA0KPiA+Pj4gaGFu
ZGxlX3VuYWxpZ25lZF9hY2Nlc3MoQ1BVWDg2U3RhdGUgKmVudiwgdmFkZHIgdmFkZHIsDQo+ID4+
PiAuLi4NCj4gPj4+DQo+ID4+PiAkIGdpdCBncmVwIC13IHZhZGRyLCB8IHdjIC1sDQo+ID4+PiAg
ICAgICAgMjA3DQo+ID4+Pg0KPiA+Pj4gV2hhdCBpcyB0aGUgZXJyb3Ivd2FybmluZyBsaWtlPw0K
PiA+Pg0KPiA+PiBPSyBJIGNvdWxkIHJlcHJvZHVjZSwgSSBzdXBwb3NlIHlvdSBhcmUgYnVpbGRp
bmcgd2l0aCBDbGFuZyB3aGljaA0KPiA+PiBkb2Vzbid0IHN1cHBvcnQgc2hhZG93LWxvY2FsIHNv
IHlvdSBnZXQgZ2xvYmFsIHdhcm5pbmdzIHRvbyAoYXMNCj4gPj4gbWVudGlvbmVkIGluIHRoaXMg
cGF0Y2ggc3ViamVjdC4uLik6DQo+ID4NCj4gPiBObyAtLSBJIGdlbmVyYWxseSBidWlsZCB3aXRo
IGdjYyBhbmQgb25seSBkb3VibGUtY2hlY2sgdGhlIGNsYW5nIHJlc3VsdHMgdG8NCj4gbWFrZSBz
dXJlIEkgZG9uJ3Qgc2VlIGFueSBuZXcgZmFpbHVyZXMgdGhlcmUuDQo+ID4NCj4gPiBCdXQgSSd2
ZSBub3QgdGVzdGVkICItV3NoYWRvdyIgd2l0aCBjbGFuZyB5ZXQuICBJIGZvdW5kIHRoZXNlIGJ5
IGFkZGluZyAiLQ0KPiBXc2hhZG93PWdsb2JhbCIgdG8gIi1Xc2hhZG93PWxvY2FsIi4gIEkgdGhv
dWdodCBpdCBtaWdodCBiZSB1c2VmdWwgdG8NCj4gYWRkcmVzcyB0aGVzZSB0b28gd2hpbGUgd2Un
cmUgaGVyZS4NCj4gPg0KPiA+PiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi4vLi4vZ2Ric3R1Yi90
cmFjZS5oOjEsDQo+ID4+ICAgICAgICAgICAgICAgICAgICBmcm9tIC4uLy4uL2dkYnN0dWIvc29m
dG1tdS5jOjMwOg0KPiA+PiB0cmFjZS90cmFjZS1nZGJzdHViLmg6IEluIGZ1bmN0aW9uDQo+ICdf
bm9jaGVja19fdHJhY2VfZ2Ric3R1Yl9oaXRfd2F0Y2hwb2ludCc6DQo+ID4+IHRyYWNlL3RyYWNl
LWdkYnN0dWIuaDo5MDM6MTA2OiBlcnJvcjogZGVjbGFyYXRpb24gb2YgJ3ZhZGRyJyBzaGFkb3dz
IGENCj4gPj4gZ2xvYmFsIGRlY2xhcmF0aW9uIFstV2Vycm9yPXNoYWRvd10NCj4gPj4gICAgIDkw
MyB8IHN0YXRpYyBpbmxpbmUgdm9pZCBfbm9jaGVja19fdHJhY2VfZ2Ric3R1Yl9oaXRfd2F0Y2hw
b2ludChjb25zdA0KPiA+PiBjaGFyICogdHlwZSwgaW50IGNwdV9nZGJfaW5kZXgsIHVpbnQ2NF90
IHZhZGRyKQ0KPiA+PiAgICAgICAgIHwNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIH5+fn5+fn5+fl5+fn5+DQo+ID4+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBpbmNsdWRl
L3N5c2VtdS9hY2NlbC1vcHMuaDoxMywNCj4gPj4gICAgICAgICAgICAgICAgICAgIGZyb20gaW5j
bHVkZS9zeXNlbXUvY3B1cy5oOjQsDQo+ID4+ICAgICAgICAgICAgICAgICAgICBmcm9tIC4uLy4u
L2dkYnN0dWIvc29mdG1tdS5jOjIxOg0KPiA+PiBpbmNsdWRlL2V4ZWMvY3B1LWNvbW1vbi5oOjIx
OjE4OiBub3RlOiBzaGFkb3dlZCBkZWNsYXJhdGlvbiBpcyBoZXJlDQo+ID4+ICAgICAgMjEgfCB0
eXBlZGVmIHVpbnQ2NF90IHZhZGRyOw0KPiA+PiAgICAgICAgIHwgICAgICAgICAgICAgICAgICBe
fn5+fg0KPiA+PiB0cmFjZS90cmFjZS1nZGJzdHViLmg6IEluIGZ1bmN0aW9uICd0cmFjZV9nZGJz
dHViX2hpdF93YXRjaHBvaW50JzoNCj4gPj4gdHJhY2UvdHJhY2UtZ2Ric3R1Yi5oOjkyMzo5Njog
ZXJyb3I6IGRlY2xhcmF0aW9uIG9mICd2YWRkcicgc2hhZG93cyBhDQo+ID4+IGdsb2JhbCBkZWNs
YXJhdGlvbiBbLVdlcnJvcj1zaGFkb3ddDQo+ID4+ICAgICA5MjMgfCBzdGF0aWMgaW5saW5lIHZv
aWQgdHJhY2VfZ2Ric3R1Yl9oaXRfd2F0Y2hwb2ludChjb25zdCBjaGFyICoNCj4gPj4gdHlwZSwg
aW50IGNwdV9nZGJfaW5kZXgsIHVpbnQ2NF90IHZhZGRyKQ0KPiA+PiAgICAgICAgIHwNCj4gPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgfn5+fn5+fn5+Xn5+fn4NCj4gPj4gaW5jbHVkZS9leGVj
L2NwdS1jb21tb24uaDoyMToxODogbm90ZTogc2hhZG93ZWQgZGVjbGFyYXRpb24gaXMgaGVyZQ0K
PiA+PiAgICAgIDIxIHwgdHlwZWRlZiB1aW50NjRfdCB2YWRkcjsNCj4gPj4gICAgICAgICB8ICAg
ICAgICAgICAgICAgICAgXn5+fn4NCj4gDQo+IElmIHdlIGhhdmUgdG8gY2xlYW4gdGhhdCBmb3Ig
LVdzaGFkb3c9Z2xvYmFsLCBJJ20gdGVtcHRlZCB0byByZW5hbWUNCj4gdGhlIHR5cGVkZWYgYXMg
J3ZhZGRyX3QnIGFuZCBrZWVwIHRoZSAndmFkZHInIHZhcmlhYmxlIG5hbWVzLg0KPiANCj4gUmlj
aGFyZCwgQW50b24sIHdoYXQgZG8geW91IHRoaW5rPw0KDQpGZWVscyBsaWtlIEkgbWF5IGhhdmUg
c3Ryb2xsZWQgaW50byB1bmNoYXJ0ZWQgdGVycml0b3J5LiAgSSdsbCBqdXN0IGRyb3AgdGhlIHBh
dGNoIHRoYXQgaXMgaW50ZW5kZWQgdG8gYWRkcmVzcyAtV3NoYWRvdz1nbG9iYWwgYW5kIHJlc3Vy
cmVjdCBpdCBpZi93aGVuIHdlIGRlY2lkZSB0byB0YWtlIHRoYXQgb24gaW4gZ2VuZXJhbC4NCg0K
PiA+PiBDbGFuZyB1c2VycyBnb3QgY29uZnVzZWQgYnkgdGhpcywgSUlVQyBNYXJrdXMgYW5kIFRo
b21hcyBpZGVhIGlzDQo+ID4+IHRvIG9ubHkgZW5hYmxlIHRoZXNlIHdhcm5pbmdzIGZvciBHQ0Ms
IGVuZm9yY2luZyB0aGVtIGZvciBDbGFuZw0KPiA+PiB1c2VycyB2aWEgQ0kgKHVudGlsIENsYW5n
IGdldCB0aGlzIG9wdGlvbiBzdXBwb3J0ZWQpLiBQZXJzb25hbGx5DQo+ID4+IEknZCByYXRoZXIg
ZW5hYmxlIHRoZSB3YXJuaW5nIG9uY2UgZm9yIGFsbCwgd2FpdGluZyBmb3IgQ2xhbmcNCj4gPj4g
c3VwcG9ydCAob3IgY2xlYW4vZW5hYmxlIGdsb2JhbCBzaGFkb3dpbmcgZm9yIEdDQyB0b28pLg0K
PiA+DQo+ID4gSG9wZWZ1bGx5IGl0J3MgaGVscGZ1bCBvciBhdCBsZWFzdCBiZW5pZ24gaWYgd2Ug
YWRkcmVzcyB0aGUgc2hhZG93ZWQgZ2xvYmFscw0KPiB1bmRlciB0YXJnZXQvaGV4YWdvbi8gZm9y
IG5vdywgZXZlbiBpZiAiLVdzaGFkb3c9Z2xvYmFsIiBpcyBub3QgZW5hYmxlZC4NCj4gPg0KPiA+
PiBTZWUgdGhpcyB0aHJlYWQ6DQo+ID4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2
ZWwvMTFhYmM1NTEtMTg4ZS04NWMwLWZlNTUtDQo+ID4+IGIyYjU4ZDM1MTA1ZEByZWRoYXQuY29t
Lw0KPiA+Pg0KPiA+PiBSZWdhcmRzLA0KPiA+Pg0KPiA+PiBQaGlsLg0KDQo=

