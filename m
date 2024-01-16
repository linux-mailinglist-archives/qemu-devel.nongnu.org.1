Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAE582E93D
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 06:48:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPcIX-00013l-Kz; Tue, 16 Jan 2024 00:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rPcIV-00013Q-MD
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 00:47:39 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rPcIT-00038i-Ty
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 00:47:39 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40G5koUt020082; Tue, 16 Jan 2024 05:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 qcppdkim1; bh=CPo6vUDw4vl9lOCPS8NVhOzwRB9mmR6HDBRN+vpSc2E=; b=ho
 N0dEByoI85okmaj46nM+J/nNI9vzUnJc03Glp1eiDnfiov/XPTqtnlin1NmskALe
 8VXqE/k/HMUm5oZ68S6XkDL3gBh8mVGQUKgHEwFD586paRRzq+l1TuZy+50Z6wG4
 +n4C8zdGsyeWGSAKzLBhuKGx3daW5eQMW6l3WbJwalh53VO2j5HxQQk/h6lxXoQh
 wZMsda+Z0kRbtb1nfGkDdc62zyo1cJgorxhqHTp3K+SxCwdgjCSQcaBpPeqRPqRR
 HzkmBFCOq5NXi7WrMsNE9FcW+6LleHuppDlURKc8DenyLJ2mLT4erXB0d073zkRD
 d8ASqjkzuInki/K6rAeQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vmy95j94j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 05:47:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFOfUaXZniCKBbIC0101EA/oOwu1udADfs94SXVgFtMLIGhbJbLrMqzgeNWUiwDLBKSJP560ElZNxVqbPtxRMW9pd8JY4DRDMjodxb0Oy6jp473aFeQo3A+qB9lMaYzfME/JEBLqdCT3TQZgWYhQUbAT9HOXKQyjn2Q5M2iS+V0LPNPQRO2i0CmQz0CUrVz2S8NmPBDmG0LSuocY0kT4LpW6NWddNvL74Xh6TcObXeJxtgijMzL2d6rsjonDhNNcfm0IIohCtWt+xWJEJVK6FEevoyI6JC+ngPJmZa4Mt+B+W5alD+nFRPCVAoygcHtUoCmjpopVkdsGG2vU8Kphtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPo6vUDw4vl9lOCPS8NVhOzwRB9mmR6HDBRN+vpSc2E=;
 b=ieSptnmtwMY+CXBCVAqJfhxKEC+pBrNa84mp1JsrGIoMET2qQYu1oI7dpYNlDy5dD+6UsoBB3JRN6XucMxDF0OyAY/HXCOwCT054crjjekBgbawDcZgjd9DkWa9R85YY18nVdaKMZK9toUysszVbJJvlQac9B9r2D7iaqNu86JV58my5xdkZs9KJoRfV30pNBdBNcl0713PEIZ2E4fK2G/1QIruJhGTVaQlccdxt3BBkkHGXvcHYat1ZQoir/DeOxUjnDxJDjPLT1Qx+pbqHnEI5/Bhk3HV4L0Yxy+wSpCJyi89ff01RpuIc5Swux7fS6E/sZluG8B7OfW52TfklqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by BN0PR02MB7902.namprd02.prod.outlook.com (2603:10b6:408:161::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 05:46:57 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::dfab:83e2:41:20c8]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::dfab:83e2:41:20c8%5]) with mapi id 15.20.7181.015; Tue, 16 Jan 2024
 05:46:57 +0000
From: Brian Cain <bcain@quicinc.com>
To: Taylor Simpson <ltaylorsimpson@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>, Sid Manning
 <sidneym@quicinc.com>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "ale@rev.ng" <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: RE: [PATCH v2 0/9] Hexagon (target/hexagon) Make generators object
 oriented
Thread-Topic: [PATCH v2 0/9] Hexagon (target/hexagon) Make generators object
 oriented
Thread-Index: AQHaK7VA3rKzqJg9T0yZJnm0gNDcELDcJ1vg
Date: Tue, 16 Jan 2024 05:46:57 +0000
Message-ID: <SN6PR02MB4205C43DCFD4D76E559DA7A3B8732@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20231210220712.491494-1-ltaylorsimpson@gmail.com>
In-Reply-To: <20231210220712.491494-1-ltaylorsimpson@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|BN0PR02MB7902:EE_
x-ms-office365-filtering-correlation-id: b5b26b1e-eab3-48ac-6e74-08dc16568d4e
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4YyViKxGVEiHbgS5O09iDEX5Nqc1DbknirWgfpN3EhPJ5RhKFVNNws5s5vAVotGplZ0NXmzRa4zo9QBT0aS+HCwoJhDcmpr1XRnWjGzIs5uCDRlgc5tD0CaPihZSLrhaBw8l+ganVxrdWKJDcBZs2HQ43m9KO2Llt5kgAuxnqr4i3oBQS9+Ux4e1y2bm5AM5QxXKlsL7MrgwLAaOyvFfEQi2FgqCf8J/IuM/Y5bSZWO8iU5mWUC32whxYAFI4oUZoVLjvl9btco0nxMMiw1CekiwpYYK/z/sR8OpKhtmYUA5ZgbKEAHezYD6+XcAstwoJrJM0TMJMHd0ESw17QIG8wpo1JdW5yu73iF8a7ko00iKIKZ41qTanITNGBYXGcCqn/J4rgzf/gAK9cglPeMHV48okZ1NL9z40+bhlFtukf+BsStRk1iZDMfA9Llo9MtS2yx29LfKUeEMZP0cn8pDcA73jwxQDGuWCX1MsVnH4OaceWzfrcAeoTaxoH2zH0xAry4//JPaTV3mpKeyr0FemIRylPAfENzBodAOThjDtU7As8rHTu3arSYwGXVctfXqCMazUjSs8tz018wrsOOSTep77G7gKrYEk55QBLSmqT/nPHh45QnDlw2QHlsNEZy4nkmE3t95I2uO7U6LgmBdew==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(230173577357003)(230922051799003)(230273577357003)(1800799012)(186009)(451199024)(64100799003)(7696005)(966005)(6506007)(26005)(53546011)(38070700009)(9686003)(71200400001)(83380400001)(38100700002)(86362001)(41300700001)(122000001)(478600001)(33656002)(52536014)(8676002)(4326008)(8936002)(5660300002)(66946007)(66476007)(110136005)(76116006)(66556008)(55016003)(66446008)(2906002)(316002)(54906003)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjAxYjhrSFdRRGpOY3R2a1o5aGZDdi93ZHpQc3QrUngyRngyeExGRFA4K3JE?=
 =?utf-8?B?UkxOOC9aY1lMNDY0bVI4bFIxWFJmOFo3ZEYydi9YNDQ0Mis3R1NCUkVDM1Ev?=
 =?utf-8?B?dG1iY1B1UXNPVnpUSHJGQ082bkJOMmQ3RzY1cERvbERVdVlUME9mMUxmdDN5?=
 =?utf-8?B?Skp2djg2WWVjUFpZYjk5K09YTEJYL0swZ0ZYckllMnhmV0llb2lQUkM4T1ow?=
 =?utf-8?B?WVBiVXltL0VPbEJ0Um9WZTVXWklwU0NMc0p2ZndrVnE2d2t0bEtUaStWQ1Ix?=
 =?utf-8?B?UnUvU2RqNnc5Vk4yS2pTcWM1cEpmdG9RTFpEYThFbEIyaDhLU0VGVkgyVHZw?=
 =?utf-8?B?NE1FUmh5dUJmSmFxcnRTVjV0OHlKOEpNSEJ2MHA2VGM3aWpoQkpPRUk4RjNu?=
 =?utf-8?B?WTlqM25BZ2wrV21YRzhBYmMwRnBIQmtBbUhLQnBNTzA1VjFPa2g5bE5CWlhH?=
 =?utf-8?B?WHpnTEo1aE9sSkE5S3FTL1cyVzNIZUI2WTNGNS8xOThUQ2ZTd1luTnYrMkZD?=
 =?utf-8?B?bzFkNENHUHJDMnc2d1Q4UFY1K1c2SkM2bEw2SXluWEdWYkdvQzFPYW13WDBw?=
 =?utf-8?B?UmpMakovOS9pQlFVVWJJYkQ3c3didVRZeE9TWk9heGp1dTUrckYrMytnWk1V?=
 =?utf-8?B?Y1RvZmtDZmsyWnl1cUpNdVByZ29mS29ZZnV2QjRYaXlqcE9hNTVOemRvcFFW?=
 =?utf-8?B?amM2SEVsQnNoNkdmbExiMkFMTSt6aiswbXB6MTgxTXo2Z0dTL1pBWkpPVDBh?=
 =?utf-8?B?THh1LytUdjM4dG12RUxNRlJObm9ReHJBZGVDeXVCQXNCOGJENkNrdk9qSzJ0?=
 =?utf-8?B?ZW91VjBFbXpqQ05uZUlZWGlKS3NFQUJ0ME5YVS9WTjltcjhPK1JDMEhHNE5y?=
 =?utf-8?B?Z3gyL2tlWUVyWEhYNmkweFh3UVpmdDdlUWxCSG1DaHlNWXRZREl5S0p5WnYz?=
 =?utf-8?B?Lys5eExkelJXdmdkMEVkVHlieXVHdjNaenRJK0JENWNwVFFkRVczdW94RGYw?=
 =?utf-8?B?eU16Y2NPWGEvNlIwWkhhbG9oOEhPanRKQkVsc3ZFSTMvRE5ER0kzNjE2V0xX?=
 =?utf-8?B?aGU5eTZ4TU5vMGgvR3JpVUZFVVhoSUtPTThucmxrUktnb2NkOGZkazlkMURi?=
 =?utf-8?B?VHltS3o1VGJQaklPRGxiTjBWMFRoNzBpRlQ2a3Q5d3N4SG40ck42enB1OW4v?=
 =?utf-8?B?MVZVbHBhNU5EV3Q3MzJXWk9wRnNJMFVoQWQrdnRrcXlrZ0FSZExvbnRFbllK?=
 =?utf-8?B?UVR2Wm5xR3Q3bEZKUlY3bGxlK3FJME16MDYweksyVzZOc2FDRm5jZzRwWUNa?=
 =?utf-8?B?bVdlcG5SRm5jVHZDMktKNlBYNXJaZklzSHVseHBNQ1lxZU44bUsrMC8vRFFD?=
 =?utf-8?B?c1NETndTTkh0Z2k5MzkwdkUrcE4yditybGx3cGVMN3paTVRwZldrbktzRGxh?=
 =?utf-8?B?THRKOHMwdW5ER3JTQVdzTThhN2cvMXZldUV6SUVFM3dzV2J0VGNmdUd3MFhD?=
 =?utf-8?B?SXVYK3pRWm5yOTNVZEdJdFR2ZDBLQ0trTWNNUjJsY2tva0RRdEJONlBSYjZK?=
 =?utf-8?B?eFMycndhR203VnBhL3JSbzJlKzdMeFhWQ2VXNW50U2NVNnhZUkF4RXlOY2Vt?=
 =?utf-8?B?ZWtuaUJsYnZYSlF3eDB1cVR2L1lUZUJtYThpcWlaQzF4N0ZSOGt1TGpzUTQy?=
 =?utf-8?B?TElMMElxYUk1UVZ2QlJNQytEN3J0ZFZzaDBid1l4cTB5WU5FRG55RS9uL3dW?=
 =?utf-8?B?Nkc0NzFkQjFpcm9NbGgvNVZiclE0RldVYWxpRFUrcEJ2Q1hadjNCaVJGK1dY?=
 =?utf-8?B?aDNLeGM2RUVoak9RQmxmc3hjdkp0ajZ3MzRsTmRwTW1DbS9UL3JySFdNY2tH?=
 =?utf-8?B?NWUzYXhSK29Td3F4RzgxMDBpclFzNlBHT1UrckZVZGtKMzFvNmZMQWxjdXU5?=
 =?utf-8?B?c01mWDVVWVJ6Y3RlUitLL1REU3o3VGVuaVdPaGdjdTJoUHNxbEFjWmhKY0Fv?=
 =?utf-8?B?K05mdDd3YkRrN0kyVkxKZEJWZzRqaHIyemtoMWpOOUY3Q1poSDg1QXZiMEFr?=
 =?utf-8?B?endpZE5XMDYyTUVmcEkrWG81WVJkT2wvM013N2xOVVRYOEpXK2dXbTFPdHd0?=
 =?utf-8?Q?33sE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FRjWhERDHGwom7IjS0CWYInrhhfqYu0OAQMQyGvwK6qFZw2vx32ZCzDW4WAtssu2kdALtrDz7Vw+Q1rgDV3wlsDm5m9pDtUkNqvFDCIYCIo9dmJU1Nt+GJEVxSqRoFFOPq9M+d8fXmUx637KXXtZVIPupHXAdAZGR8izXwLaRu8y/m2olBt0nKf7gNkGvIxawHuApTT7a+yukn+m/RAdw5+kYXq/pW9tZPBJG8iIvDxMfkUFoX9VeQDxA8IiLKiclH5GReSJBHB2/tSUNayYkTF/HS0xJhMp08KWWqAz7v2AN3Fz4vEHoD2v+E5nJx7UUMb624EmHBADKFDnTHaCIR9IjpVdN2RNHtD2qJ8/VakFGHSQwPB3/Nprwk0tmSeR0zodrNivYbAWCaIHQcsFsxVnWXhe4vRjS2dHiQvenvgiOguseRod09TiC7dFmSaRj3jwr+lPcLeNmxCRg2C5sQemmD1iEzzM7qWMG8VGCskI+yT/VmkTbbudnZ96zpd3WjYOUO8trlGNeyhhkSfQYqwvr36KFosaBsepQLHG86LSAB/RTvLXfE6q/mMcXCQ5aQ1X9bKZeIyInGQ2hYBrInxvdH/qv2VSNiDeOvPNCjRnKJI27n19G2g8ww/Tx+2e
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b26b1e-eab3-48ac-6e74-08dc16568d4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 05:46:57.3420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GKXlS63LsoKQFZLl3The9OUzKCtJgbDS71O4ZBfzTjoNhmk9fZK19f+hj6TElS+eqWjx4pkGih/0oTRSW38q2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7902
X-Proofpoint-GUID: EnwIeMcuqLbuYelFg_vfwPxzpVTjO46X
X-Proofpoint-ORIG-GUID: EnwIeMcuqLbuYelFg_vfwPxzpVTjO46X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxlogscore=367
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160043
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
VENIIHYyIDAvOV0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIE1ha2UgZ2VuZXJhdG9ycyBvYmpl
Y3QNCj4gb3JpZW50ZWQNCj4gDQo+IFdBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9t
IG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5IG9mDQo+IGFueSBsaW5rcyBvciBh
dHRhY2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KPiANCj4gU2VlIGNvbW1pdCBt
ZXNzYWdlIGluIHNlY29uZCBwYXRjaA0KPiANCj4gKioqKiBDaGFuZ2VzIGluIHYyICoqKioNCj4g
QWRkcmVzcyBmZWVkYmFjayBmcm9tIEJyaWFuIENhaW4gPGJjYWluQHF1aWNpbmMuY29tPg0KPiAt
IENvbnNvbGlkYXRlIGxvZ2ljIHRvIGNyZWF0ZSBoZWxwZXIgYXJnIGxpc3RzDQo+IA0KPiANCj4g
VGF5bG9yIFNpbXBzb24gKDkpOg0KPiAgIEhleGFnb24gKHRhcmdldC9oZXhhZ29uKSBDbGVhbiB1
cCBoYW5kbGluZyBvZiBtb2RpZmllciByZWdpc3RlcnMNCj4gICBIZXhhZ29uICh0YXJnZXQvaGV4
YWdvbikgTWFrZSBnZW5lcmF0b3JzIG9iamVjdCBvcmllbnRlZCAtDQo+ICAgICBnZW5fdGNnX2Z1
bmNzDQo+ICAgSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIE1ha2UgZ2VuZXJhdG9ycyBvYmplY3Qg
b3JpZW50ZWQgLQ0KPiAgICAgZ2VuX2hlbHBlcl9wcm90b3MNCj4gICBIZXhhZ29uICh0YXJnZXQv
aGV4YWdvbikgTWFrZSBnZW5lcmF0b3JzIG9iamVjdCBvcmllbnRlZCAtDQo+ICAgICBnZW5faGVs
cGVyX2Z1bmNzDQo+ICAgSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIE1ha2UgZ2VuZXJhdG9ycyBv
YmplY3Qgb3JpZW50ZWQgLQ0KPiAgICAgZ2VuX2lkZWZfcGFyc2VyX2Z1bmNzDQo+ICAgSGV4YWdv
biAodGFyZ2V0L2hleGFnb24pIE1ha2UgZ2VuZXJhdG9ycyBvYmplY3Qgb3JpZW50ZWQgLSBnZW5f
b3BfcmVncw0KPiAgIEhleGFnb24gKHRhcmdldC9oZXhhZ29uKSBNYWtlIGdlbmVyYXRvcnMgb2Jq
ZWN0IG9yaWVudGVkIC0NCj4gICAgIGdlbl9hbmFseXplX2Z1bmNzDQo+ICAgSGV4YWdvbiAodGFy
Z2V0L2hleGFnb24pIFJlbW92ZSB1bnVzZWQgV1JJVEVTX1BSRURfUkVHIGF0dHJpYnV0ZQ0KPiAg
IEhleGFnb24gKHRhcmdldC9oZXhhZ29uKSBSZW1vdmUgZGVhZCBmdW5jdGlvbnMgZnJvbSBoZXhf
Y29tbW9uLnB5DQo+IA0KPiAgdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5oICAgICAgICAgICAgICAg
ICAgICB8ICAgOSArLQ0KPiAgdGFyZ2V0L2hleGFnb24vbWFjcm9zLmggICAgICAgICAgICAgICAg
ICAgICB8ICAgMyArLQ0KPiAgdGFyZ2V0L2hleGFnb24vYXR0cmlic19kZWYuaC5pbmMgICAgICAg
ICAgICB8ICAgMSAtDQo+ICB0YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVy
cy5jIHwgICA4ICstDQo+ICB0YXJnZXQvaGV4YWdvbi9nZW5fYW5hbHl6ZV9mdW5jcy5weSAgICAg
ICAgIHwgMTYzICstLS0NCj4gIHRhcmdldC9oZXhhZ29uL2dlbl9oZWxwZXJfZnVuY3MucHkgICAg
ICAgICAgfCAzNjggKystLS0tLS0NCj4gIHRhcmdldC9oZXhhZ29uL2dlbl9oZWxwZXJfcHJvdG9z
LnB5ICAgICAgICAgfCAxNDkgKy0tLQ0KPiAgdGFyZ2V0L2hleGFnb24vZ2VuX2lkZWZfcGFyc2Vy
X2Z1bmNzLnB5ICAgICB8ICAyMCArLQ0KPiAgdGFyZ2V0L2hleGFnb24vZ2VuX29wX3JlZ3MucHkg
ICAgICAgICAgICAgICB8ICAgNiArLQ0KPiAgdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19mdW5jcy5w
eSAgICAgICAgICAgICB8IDU2NiArLS0tLS0tLS0tLS0NCj4gIHRhcmdldC9oZXhhZ29uL2hleF9j
b21tb24ucHkgICAgICAgICAgICAgICAgfCA5MjEgKysrKysrKysrKysrKysrKysrLS0NCj4gIDEx
IGZpbGVzIGNoYW5nZWQsIDk2NCBpbnNlcnRpb25zKCspLCAxMjUwIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gLS0NCj4gMi4zNC4xDQoNCg0KUXVldWVkIC0gaHR0cHM6Ly9naXRodWIuY29tL3F1aWMvcWVt
dS90cmVlL2hleC5uZXh0DQo=

