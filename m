Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C2C7B82C5
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:54:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo3Gc-0002dq-7v; Wed, 04 Oct 2023 10:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1qo3GZ-0002df-PZ
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:54:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1qo3GV-0004GJ-Of
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:54:23 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3948iqFA031389; Wed, 4 Oct 2023 14:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=NeWM0C+U6ATHNSc15/YYsTTUnrKUJ2Er1kQKT2k2X0I=;
 b=Sh6vsLYTZpYIdEssvP9wmtOzqLGhP/0pYQMgyYvSAiM5lAVCmyIPXCKQRdSu9SEaEa2k
 4nPcAMmm9gFo59IU5O+PcUfSzRZ/fwfdJTsp8rsuRhSY7VabBOmtpIaCKv1WHcEZfNZn
 lz7ci+s8+322ZElow+G9Tjq+yhcDXLGz1+xn9lHrl+XXAqsj2u1kJzSomiaIECoLwulC
 aaYFi723MVK8uE7JdeAwP9bjH4NhgUX/luXBRmQ4mWG5p9u0ChgkAlWreHGRMh9atjPv
 sJW7xQrd6CBsJ7GP9DAGIVWlhWE0UNFZ5AJaheiF1f8ZH4HowAvtddBjOXT1xoacU4+J NQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teaf47bmp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Oct 2023 14:54:14 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 394Dlvib025921; Wed, 4 Oct 2023 14:54:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tea4e377h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Oct 2023 14:54:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/8GvEuqyUEXX0CrKUpAjyX3d84prWpNT/krPuwXcrHt2P/D8udlS7va0wAz2cFG6ctInkRcmkK3lk+bAOq6HQP+fLleAz0PqfuhGxZLUgWIudJuv9Q6NfgPxpsrLMFknaQrMzLydvaAWcIlWtXVuC8NXtI09PDO4zgn0YUEqlDxE2yrt7de9YCkfGv0qzybeEq22SEQFVX7T0vf2LmjmnLi0EPzDAjeV41xI1fMtazF99Fuy+AkmsLzJIFoEcv75f6E3l+1apaGXWenvunCZ/J2sumIWZhRGCoQhSIdliFZ6t7vFix7KCJKsCvkp4FZmIGZgB4YPLzqVh99P4ijcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeWM0C+U6ATHNSc15/YYsTTUnrKUJ2Er1kQKT2k2X0I=;
 b=JWpppy+S2g0zj3UrSE1qEKLE8llo48HLC2MPv/+1+AEuWNvkvLMUMX73QUOOwbLYeKwaP+goKJushBlFgswqn5Rjy/nHuuT7UEjLsweuG3agpbiZzSqAJGwamRhmwGTs1lo4zDcZVFlr2f3m/c1Xeaiz8BUdUQORvp9EyYC+3QESc28+Ngyv0+50+cVCvjaZDlccDVmslk0q/arB2dAdAd9bxhT+jyEPuFrfc7rHqkY4ckVA3wmao+nDFFRAZdYtn+mnt/Ca+dcYVvK3vWV1M5PPygMtVN1nvMBo9+ku7P4F0JeBGgh5/qk5kQ4xqaRp9ArImLSvGTjJP9mIDRhM0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeWM0C+U6ATHNSc15/YYsTTUnrKUJ2Er1kQKT2k2X0I=;
 b=OhJabnLViIcxc0uF9NW48Z4LvAejKjQ11eWHJ35awg08/hUcL4j/ps2hNMfX+RpoS2s4Rlxkl1C7kZ7Tg9R+OZa27Rsy3XV44G0WGl5ok0hxkj5xE27FA4F02KEXa3EtckARcbEc5fdNTrnruxWDstDE+lmpchP85m9i0zz4VuU=
Received: from MN2PR10MB4013.namprd10.prod.outlook.com (2603:10b6:208:185::25)
 by DS7PR10MB5006.namprd10.prod.outlook.com (2603:10b6:5:3a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 14:54:10 +0000
Received: from MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::6639:fc37:2fe9:9955]) by MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::6639:fc37:2fe9:9955%5]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 14:54:10 +0000
From: Jag Raman <jag.raman@oracle.com>
To: Mattias Nissler <mnissler@rivosinc.com>
CC: QEMU Developers <qemu-devel@nongnu.org>, Elena Ufimtseva
 <elena.ufimtseva@oracle.com>, David Hildenbrand <david@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 "john.levon@nutanix.com" <john.levon@nutanix.com>, "peterx@redhat.com"
 <peterx@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 4/5] vfio-user: Message-based DMA support
Thread-Topic: [PATCH v5 4/5] vfio-user: Message-based DMA support
Thread-Index: AQHZ65loUWID0U2a/EqOqiPUV7ljErA5zgOA
Date: Wed, 4 Oct 2023 14:54:10 +0000
Message-ID: <A72E08FA-53B4-43A3-978B-7E5771588597@oracle.com>
References: <20230920080622.3600226-1-mnissler@rivosinc.com>
 <20230920080622.3600226-5-mnissler@rivosinc.com>
In-Reply-To: <20230920080622.3600226-5-mnissler@rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR10MB4013:EE_|DS7PR10MB5006:EE_
x-ms-office365-filtering-correlation-id: fb2e33a9-4df4-49c1-43e7-08dbc4e9c44c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rQqEpyi3Nh52qsddbMJ7jQ0jP80E0cFxx/1LflD2e6OS/OurH4lozrn7UUkaHVEnOs7TONqP0uTOBD/1Plz810aNaznFxUDWt4a2MnI6jiGZtfU/aDk3Mq+0kqQ1OnYtBBR7SPKnM9oC1eNt/kuKXBWuq2cm7lUsYWveqKMLWuB8bgGeJQV1IwBHIjGtSOe6mz4J4ZMS7FLYsZ598rcriqTt+u8p0G+1Im5uuHypGF44OlyNdX3o1ETuRMb2HVt11XKfOj57uaDQjeWejdyK8MQv9xzuxAzCMm+Nd3QoSYOmgyLjKatCrvhALSCASDr7mmRJUAO5CHwAUmdAUuQOc8X4UCcVXK1cGKVG8ViEiK8D0R/SQnWfftR8KdawFy5qWvO1rdMfbfhV6OBg+ES6YrW43m/xv3YGheCka7BaC73Wy0iVT2E8EpY50QVFQwrJ+TwhcA8fIFNkYsK9+LSeVJUElYScd8Zy9XkW1M7nEeqj5I/RCP/LAfmE4k4J3ac6ahZ30XllaWp1YiCBjNjSj9Pm5kP7iWFpTR4d4C+CIvATXs9sRUiKmEgDeIbs0VHp0AYGlEcCRhvgu56vNJjKOupVPFuBb7yaFcNjha3haOtmUTi0LuYp1iEjHQctFmyOT3gQeDHJhCZDyDt2EUJIOQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR10MB4013.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(2616005)(66556008)(66476007)(66446008)(64756008)(54906003)(66946007)(6916009)(316002)(41300700001)(53546011)(6512007)(33656002)(26005)(36756003)(71200400001)(6506007)(478600001)(6486002)(966005)(38070700005)(38100700002)(122000001)(86362001)(83380400001)(76116006)(44832011)(15650500001)(7416002)(2906002)(4326008)(8936002)(8676002)(5660300002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?t0sBYk6rliQZD/NLZXYtPm7tJ8Q21xe/jrQxkbzgnzLUy5aWF+MT62vVnY?=
 =?iso-8859-1?Q?Ta8e9XWUA33Zjc/r0efnuTRYZUKEm10jVCDyCTnzXk9xpK0ywtA3jU6Z1e?=
 =?iso-8859-1?Q?OcK65uFtyKFD9qBGSPggembOCUVB5KxGKvJP/2h2wSGV0fDrhKI8oSa0G4?=
 =?iso-8859-1?Q?typ5tG0/y83DMifdwSvLp05G0U/hJjeorOC8suyOT6VeLuzWhzVeqjZIIB?=
 =?iso-8859-1?Q?M/kO9l7u2saz8OO6ZizhBo5BE60aVVCxZRoie0TEkRcbX7c0FjDs9AW6ZL?=
 =?iso-8859-1?Q?kxDC37Qu50yFhUGyZtKaqbDbSrKYYMc25JP3UuV5TcXlOv3WsapK0CiORi?=
 =?iso-8859-1?Q?qpsiTUOBQud/219B0cZRltNY5do5Cf8IurQPeBVGKZ3JwSxEmJS26/yc/2?=
 =?iso-8859-1?Q?zdZg+QXJnQ6x/en91HCrwTStaiQy3Ej24l84EYRyr3yi79hV6O+7SSRBjg?=
 =?iso-8859-1?Q?wM6TypUDLPJl7z3lAdffc1Dig3V5GJsmjF9+7nxtpJWWz2VFC2SP1dsb3T?=
 =?iso-8859-1?Q?wTp4IUJ7AkMznkQ5LpEcCBjS55PVqF23Vx5EL7Me/vlMz77oJulrFF2jql?=
 =?iso-8859-1?Q?jJb2AUfNYeY9KSK96aRmHurb9vPJdhkwnirbr+JceZUE/kD/3Gjl1FJUmv?=
 =?iso-8859-1?Q?GTsDxdVux1yys3jUeEeOMMS7Vn0JvIH3YdT22oYofvUPbQLuZQ9A6EU6ma?=
 =?iso-8859-1?Q?k8R49140yLkb48gCTZeZXu0X2ulKkNCOnZ6g4A6qW+jAUVWVvaIPuiIDtK?=
 =?iso-8859-1?Q?ir4F0PxTKacxHUSWrdG+XvkbzrYPxvIAP8s+LaQas7oMxyrLTjf2K5i3Mp?=
 =?iso-8859-1?Q?ev60nAutpnK7YM6O1vU1Y2wlGh2XNIOdx9LgxvfNzekofTohnkV4vIeg2t?=
 =?iso-8859-1?Q?HMMxW77VIwvAyP0RiCeWCRMg0ukdvQxT++h6EftIRXk2vpTXt8/8ARzVDu?=
 =?iso-8859-1?Q?oYp3qnH7XybrL2rdgQvazwfb6edr2GA2MsV6qJs3nihUotoO0QxH8V0HIg?=
 =?iso-8859-1?Q?T6YSGKreLmje8/huYAQGp/j4Y7XEdwAFwRSJvHenY/fWQDfxJ8r0Ur0Wxr?=
 =?iso-8859-1?Q?47zPJWYCz8YieTMT16NTC2d4rXr73RsZ+bOJdYlGgfp0jAEKsVxmZTeX/q?=
 =?iso-8859-1?Q?oLhfaVrjoI7IgAEkkGpWe8eGXdUDNubZHi1tgcLi00K3I7UNPpzJsA9s43?=
 =?iso-8859-1?Q?t/KJfl9+awdsUiDrUJagEjFXKjxQj3a7Nf9I+EJhzms6LJEmzgG0olsEW5?=
 =?iso-8859-1?Q?hrGCaBMz0mNLUqIkYS9F99Yzb33jXuPvL7REb/sw53mFnKtbqnr5osflap?=
 =?iso-8859-1?Q?fAmasCiLgT7IB7NFa0TTKgUqhEnTNciX2jw0YYUDp2AuGcnykWXnc781VL?=
 =?iso-8859-1?Q?LTPkqpDERK0lCcE8AHYGB+hNBwR90c4N9oVjPiAbrFpIKX5cvS9dLEVHOl?=
 =?iso-8859-1?Q?942vY+tJX99tvV1OLQMiHp77ILrn46HIriaz87QlHjh4aSQms15OyPneVf?=
 =?iso-8859-1?Q?kzWUCWS3znu9odae41a9U1ECWspPpHY5jyxGMZGID7BImZhFy3QLEW6ax2?=
 =?iso-8859-1?Q?iJlbxr/99MvD4IBAposfRT3yUYDAqaGQb+9dwdLiPBrJYX5wb/a3PaI2Iz?=
 =?iso-8859-1?Q?pJcyYLXh6czzlmZZDlZ9cloPWiqe5q7cAr?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <CB4930531E86A04AB297F8A05DF2489F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XN/XfqgHE5NrMCvxPvtM80rWZQDG2Xa/P6M5vt5Gtr112Q9UQ3wgnVr4nMe28LNRsM/CnhKC6yBaryBo9wWdacftckk4PgjNq1PvOZdJY14FbBZy2+9LmVVpwuQqnH7R50dncWPh65To8LLr+PHQkv9jIKW+tfzpKZgnnEujNwtgeEYhmHXMQGmoMWbnAt7hfw4DOcwY+HwFQyesqN3JnYjc8TSM26+DRcP2NX5evxsDqWKNoKyAsrACYpSnXn+U5kXwG+W2PuDUi0yAA+aMNbdXj8Nx6Bn9EhIggFCOuNcfRKAv3Z2PT+rmaXrYXt7LDyXgNZdN73ZzKF4pAQQ6R1qeZnui+1QGe9zvAT93ZpEc3Cxnk2w7EkLwk0l2+DGX1sRzwD6YMXQekQNdvBCxZthL6Lyk0xjSvFqxGVHf/FpbgmFAJxLTeOEpV5i25+K9NLcTlQwubOo42Yzu9f/DVvLZm6+1C2qBFGVDnmX6W2GadaE7N34ufUv2Je8nQyeHpqwAVF+GwjIT6rzF5GL+GnJ68+l+n/vI7RAmOkdvHANtjivUohs6IZcOvCGQWD7hYIC/ScJLT/x4Y61qmkwHuFIEkScIN/QC6Lr9+FA24zMEUnnXDZSeadBcrqGRJCeDCp0bCVXIzTKhYBkoainGpxZiTym1d2dVj1qERk/npHdz8cl/KYsotDnNgcLLEJqhjLk5IN0d1aZNAI1BzaUBcq6cGxTQ9oqNWOKQ1WNwLbmBuq8b84835+9LA2gHZHN3WaM5QqhCr6Ob5eumBJjZJZfYjyzF5FCs0KHWWPI6uvc1Bfc7dRtaVnE233S2TnZnnvS0unIHYztA3CLZ4AtFUhaMQ1nEKa0AgrslHYbXSNJvprM3TXzIxvBUWwbbwgvEo2PWi2rxlgtYSqgUQaNANQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4013.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2e33a9-4df4-49c1-43e7-08dbc4e9c44c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 14:54:10.2429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VL3lLFuzTHl19QLrM3Tj4Eh6PlB6/SPKwmBL1kliVGJ7T60/cop+1bsgMbSLf2wptDy0buImtN6k8ZBcBQZPnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5006
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_07,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040108
X-Proofpoint-GUID: 2eFFD5MMtRr6JOI2_A0i-2NkVpIEFcGy
X-Proofpoint-ORIG-GUID: 2eFFD5MMtRr6JOI2_A0i-2NkVpIEFcGy
Received-SPF: pass client-ip=205.220.177.32; envelope-from=jag.raman@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On Sep 20, 2023, at 4:06 AM, Mattias Nissler <mnissler@rivosinc.com> wrot=
e:
>=20
> Wire up support for DMA for the case where the vfio-user client does not
> provide mmap()-able file descriptors, but DMA requests must be performed
> via the VFIO-user protocol. This installs an indirect memory region,
> which already works for pci_dma_{read,write}, and pci_dma_map works
> thanks to the existing DMA bounce buffering support.
>=20
> Note that while simple scenarios work with this patch, there's a known
> race condition in libvfio-user that will mess up the communication
> channel. See https://github.com/nutanix/libvfio-user/issues/279 for
> details as well as a proposed fix.
>=20
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> ---
> hw/remote/trace-events    |  2 +
> hw/remote/vfio-user-obj.c | 84 +++++++++++++++++++++++++++++++++++----
> 2 files changed, 79 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/remote/trace-events b/hw/remote/trace-events
> index 0d1b7d56a5..358a68fb34 100644
> --- a/hw/remote/trace-events
> +++ b/hw/remote/trace-events
> @@ -9,6 +9,8 @@ vfu_cfg_read(uint32_t offset, uint32_t val) "vfu: cfg: 0x=
%x -> 0x%x"
> vfu_cfg_write(uint32_t offset, uint32_t val) "vfu: cfg: 0x%x <- 0x%x"
> vfu_dma_register(uint64_t gpa, size_t len) "vfu: registering GPA 0x%"PRIx=
64", %zu bytes"
> vfu_dma_unregister(uint64_t gpa) "vfu: unregistering GPA 0x%"PRIx64""
> +vfu_dma_read(uint64_t gpa, size_t len) "vfu: DMA read 0x%"PRIx64", %zu b=
ytes"
> +vfu_dma_write(uint64_t gpa, size_t len) "vfu: DMA write 0x%"PRIx64", %zu=
 bytes"
> vfu_bar_register(int i, uint64_t addr, uint64_t size) "vfu: BAR %d: addr =
0x%"PRIx64" size 0x%"PRIx64""
> vfu_bar_rw_enter(const char *op, uint64_t addr) "vfu: %s request for BAR =
address 0x%"PRIx64""
> vfu_bar_rw_exit(const char *op, uint64_t addr) "vfu: Finished %s of BAR a=
ddress 0x%"PRIx64""
> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> index 8b10c32a3c..6a561f7969 100644
> --- a/hw/remote/vfio-user-obj.c
> +++ b/hw/remote/vfio-user-obj.c
> @@ -300,6 +300,63 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vfu_=
ctx, char * const buf,
>     return count;
> }
>=20
> +static MemTxResult vfu_dma_read(void *opaque, hwaddr addr, uint64_t *val=
,
> +                                unsigned size, MemTxAttrs attrs)
> +{
> +    MemoryRegion *region =3D opaque;
> +    vfu_ctx_t *vfu_ctx =3D VFU_OBJECT(region->owner)->vfu_ctx;
> +    uint8_t buf[sizeof(uint64_t)];
> +
> +    trace_vfu_dma_read(region->addr + addr, size);
> +
> +    g_autofree dma_sg_t *sg =3D g_malloc0(dma_sg_size());
> +    vfu_dma_addr_t vfu_addr =3D (vfu_dma_addr_t)(region->addr + addr);
> +    if (vfu_addr_to_sgl(vfu_ctx, vfu_addr, size, sg, 1, PROT_READ) < 0 |=
|
> +        vfu_sgl_read(vfu_ctx, sg, 1, buf) !=3D 0) {
> +        return MEMTX_ERROR;
> +    }
> +
> +    *val =3D ldn_he_p(buf, size);
> +
> +    return MEMTX_OK;
> +}
> +
> +static MemTxResult vfu_dma_write(void *opaque, hwaddr addr, uint64_t val=
,
> +                                 unsigned size, MemTxAttrs attrs)
> +{
> +    MemoryRegion *region =3D opaque;
> +    vfu_ctx_t *vfu_ctx =3D VFU_OBJECT(region->owner)->vfu_ctx;
> +    uint8_t buf[sizeof(uint64_t)];
> +
> +    trace_vfu_dma_write(region->addr + addr, size);
> +
> +    stn_he_p(buf, size, val);
> +
> +    g_autofree dma_sg_t *sg =3D g_malloc0(dma_sg_size());
> +    vfu_dma_addr_t vfu_addr =3D (vfu_dma_addr_t)(region->addr + addr);
> +    if (vfu_addr_to_sgl(vfu_ctx, vfu_addr, size, sg, 1, PROT_WRITE) < 0 =
||
> +        vfu_sgl_write(vfu_ctx, sg, 1, buf) !=3D 0) {
> +        return MEMTX_ERROR;
> +    }
> +
> +    return MEMTX_OK;
> +}
> +
> +static const MemoryRegionOps vfu_dma_ops =3D {
> +    .read_with_attrs =3D vfu_dma_read,
> +    .write_with_attrs =3D vfu_dma_write,
> +    .endianness =3D DEVICE_HOST_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 8,
> +        .unaligned =3D true,
> +    },
> +    .impl =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 8,
> +    },
> +};
> +
> static void dma_register(vfu_ctx_t *vfu_ctx, vfu_dma_info_t *info)
> {
>     VfuObject *o =3D vfu_get_private(vfu_ctx);
> @@ -308,17 +365,30 @@ static void dma_register(vfu_ctx_t *vfu_ctx, vfu_dm=
a_info_t *info)
>     g_autofree char *name =3D NULL;
>     struct iovec *iov =3D &info->iova;
>=20
> -    if (!info->vaddr) {
> -        return;
> -    }
> -
>     name =3D g_strdup_printf("mem-%s-%"PRIx64"", o->device,
> -                           (uint64_t)info->vaddr);
> +                           (uint64_t)iov->iov_base);
>=20
>     subregion =3D g_new0(MemoryRegion, 1);
>=20
> -    memory_region_init_ram_ptr(subregion, NULL, name,
> -                               iov->iov_len, info->vaddr);
> +    if (info->vaddr) {
> +        memory_region_init_ram_ptr(subregion, OBJECT(o), name,
> +                                   iov->iov_len, info->vaddr);
> +    } else {
> +        /*
> +         * Note that I/O regions' MemoryRegionOps handle accesses of at =
most 8
> +         * bytes at a time, and larger accesses are broken down. However=
,
> +         * many/most DMA accesses are larger than 8 bytes and VFIO-user =
can
> +         * handle large DMA accesses just fine, thus this size restricti=
on
> +         * unnecessarily hurts performance, in particular given that eac=
h
> +         * access causes a round trip on the VFIO-user socket.
> +         *
> +         * TODO: Investigate how to plumb larger accesses through memory
> +         * regions, possibly by amending MemoryRegionOps or by creating =
a new
> +         * memory region type.
> +         */
> +        memory_region_init_io(subregion, OBJECT(o), &vfu_dma_ops, subreg=
ion,
> +                              name, iov->iov_len);

Hi Mattias,

We should update dma_unregister() to ensure we remove this subregion.
dma_unregister() presently removes the RAM region, but not this one.

--
Jag

> +    }
>=20
>     dma_as =3D pci_device_iommu_address_space(o->pci_dev);
>=20
> --=20
> 2.34.1
>=20


