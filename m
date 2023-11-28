Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 085B07FBCE8
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 15:40:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7zFx-0007lh-T2; Tue, 28 Nov 2023 09:40:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1r7zFh-0007cw-6B
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:39:59 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1r7zFf-0005RO-Ew
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:39:52 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ASDTmgI020095; Tue, 28 Nov 2023 14:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=zLwMSC0WV3sYMyX0K/An2khsMRnuN/fIfcEUPzkLrAk=;
 b=CyNigXuXt4QbBPGaNn/jpODo00ZwlAooMEj1dUfZAFiC2vxxlLK9LQ8mBSKoQQvdhoPi
 5MejaB5tO+WJMIOiERWo0ikZZien8Pet+zRI6GdnvxAd7tS7FYY3m+N+uffclTtiylM8
 R9exHRFH3k/1udjGLsBbMFrteR4CZKUJpxz3FPPVwe2AgqTcaTFwWsZttIrVlgcYoRGu
 CAzoRxFNlfP5vhrrqK39SnLN+DvVI0kQzDLG8jGXBZZE/cQF3e1TRwXtvBZYm0RpA2Pj
 9eY2MlC1EJPp0jyFTgOM2hCAsWYvV5giNvXytA/6Qk4v1nCbdaISkIT+YIvt1ZUm0oWk 3A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7ucnvgt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Nov 2023 14:39:48 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3ASEXbnl014116; Tue, 28 Nov 2023 14:39:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uk7ccqwpv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Nov 2023 14:39:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SD1uRHg/NvJJItdqH4xAqIjo6ZFrM7nPfSpO2MfnIIB+6/TuO1skpjfb9ikczviLxyVXSp/jHRIhjOyzODB5aFqicLWGpubdXepotwQJmyk6f3ZYmuCD0AusRdDJJPRG+KiV2Zos0Fk8m2goN+B28F1fXbN05Ppb4qX7P194c2tVnfX2vf1h0lwtpQZnmI2WRTkijhcbeRRnLTVu7LQqrsqKG0hc4N7eYA/SjzQYNBsvEilSy6xet5pWLRH7irdO4SvvUxcbyav3OjV0e6mIWbKViIm2PR3DIyVYNYgH8APZIDTfQzc0AGf9oACyfpgaZAOawwmuaDF6vjyKU/Rpsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLwMSC0WV3sYMyX0K/An2khsMRnuN/fIfcEUPzkLrAk=;
 b=enTtH8o7uxEOkiCVQlqd/QgJghUrvVQx99s/IfzSHad59mV8zyTRocagWuJimj75fX93ee371GrZPakWEyyZ7UXtptgIX5HQtH09+8PCav3EPfAOFAs4tdnZweWcj8xYcPAjPX7/Ce2hUKta66toIIBJbvYOxnWxxOgq2E6pctCvpIpaUwdu6cDXq/+27c/7MVZzccjBvGNgi2kn1PfE3UsRiDDi4vNhA7cx2/iTiJ5X4OzIbJBbK+dYxjwg5Fvy21GLkWfILiyKOBd5/SA9Nb3nyPH6+YRgsOtifnBfDw0tPUW8s+lqDswACMcZszvhAAPgGOrS3v9A2lsj2bZ/4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLwMSC0WV3sYMyX0K/An2khsMRnuN/fIfcEUPzkLrAk=;
 b=A6W7eeRy/Hm2XSuP4/F7VOCCgXGZpDazvyu1qalqxbBRP1WtO1Mjn6kKmaPwOEfGLWaQ96nsA250RkB6wE74EPJtyf/IAmzoHKV8u3bsX8lugYa/HcvkhK38mxBVVwvHOJTx3UFqda3JOVOUDfL7lxZ3uiYcV0Y65VmTxuHdUsQ=
Received: from MN2PR10MB4013.namprd10.prod.outlook.com (2603:10b6:208:185::25)
 by DM4PR10MB6718.namprd10.prod.outlook.com (2603:10b6:8:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 14:39:43 +0000
Received: from MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::3ee8:64b1:5ca6:c5f0]) by MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::3ee8:64b1:5ca6:c5f0%7]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 14:39:43 +0000
From: Jag Raman <jag.raman@oracle.com>
To: Mattias Nissler <mnissler@rivosinc.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers
 <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 "john.levon@nutanix.com" <john.levon@nutanix.com>, David Hildenbrand
 <david@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Elena
 Ufimtseva <elena.ufimtseva@oracle.com>, Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 5/5] vfio-user: Fix config space access byte order
Thread-Topic: [PATCH v6 5/5] vfio-user: Fix config space access byte order
Thread-Index: AQHaDMWofF08x6QB7kqt0yE9jkNGU7CP99uA
Date: Tue, 28 Nov 2023 14:39:43 +0000
Message-ID: <66A22F11-CBDA-4CBB-84C6-A06FED7D3499@oracle.com>
References: <20231101131611.775299-1-mnissler@rivosinc.com>
 <20231101131611.775299-6-mnissler@rivosinc.com>
In-Reply-To: <20231101131611.775299-6-mnissler@rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR10MB4013:EE_|DM4PR10MB6718:EE_
x-ms-office365-filtering-correlation-id: 957c81c9-f92c-4b3c-0a2d-08dbf01fdc9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uvvFPnxmiQ+jhQy4xxkhjUdvi8+8bvZMT+QoYSmvNiCrpiH7mRG8CuIano6z3Q8+W++XeadL9JtexlYY9/afvJlrgNO8HWN5S4tpZuXqukT0NkRRh+zAUIpFzA8tbz/AorBDZimOdR6yBnxTC1pHcQQaAApYBoUXd4noAbNaOU6LFq66Q4xGss3gC33aDxba0+dz8/DzeWW6rutf1ls037qRWT3kmNNdZSR6UAjGe2l7ztZx9G6MHQNz+1xkjC/hEUxSJzbWPwNeUCOApjLMgnkOGflQGTOtZj+NqEYUnAaVjkgo+w2IcCsCuIDj2WLoWrYhhQ9GKkoWyzQibYESmuM+22eN5vUyFtcW2aMMVY5jt8F1R0vH2XFXmjYI4J00eqItPa6usEpZjsPLg/1L8dcLFWrAyrpWi4tnx4Jyma3CrEzCEjJ83hO7sFJjVpLNiJMGBYQcaba8fgT1AtZmEDghsZPBZY2CkQXebylr9WWj30ZJSrHmoi8ETSF37bQ7I5fegTeDfHdMmzWynzZzSbIRaBQDX7c7qFPEz087+D0aGY439D66Hm3KyhGtvBQRayMaDY6zkHyvLyhhHv9s968izvnyNyu1BcaEwroaLkKQrUGRhvgZmkgSeNCVfTVswh7tz2aMqC+GKkvJ1zg7nA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR10MB4013.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2906002)(7416002)(44832011)(66946007)(41300700001)(76116006)(6512007)(66446008)(53546011)(64756008)(8676002)(6916009)(316002)(66556008)(66476007)(8936002)(54906003)(4326008)(6506007)(478600001)(5660300002)(71200400001)(6486002)(2616005)(26005)(83380400001)(38100700002)(86362001)(122000001)(38070700009)(36756003)(33656002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dy6gS0wCgzr/EnF8AlHhDVs6YwMCNJilMuI93ap5csxjJvL5+pFwaBm9VU?=
 =?iso-8859-1?Q?USbYeDMgfJQv+PMumqG3bDxEy/tPHE344dnGoOpA33F+XNGDZ0qIQIDkiV?=
 =?iso-8859-1?Q?cFCsnt9oOyHA4XS6t/ltyzNOrewfbRWxyk96l8drmmQfbR7ijEocgG50X7?=
 =?iso-8859-1?Q?B2JQchLuYZq+pVgo44IDwffeJ+vSzcKUet+b3BRhRbGpWcIquxLl8Fn0GY?=
 =?iso-8859-1?Q?6Vx58Zf5F5MOk/JCK57QI8p5nqiqcbtDjIy7punlPhHJmRJ7HRmE0YiwFt?=
 =?iso-8859-1?Q?Hd5BEgwV3rKniK+OzNQfTtCqMxQiSYAyRiPZpoTtdFj2bCKfsVtO4+s4x6?=
 =?iso-8859-1?Q?iew7GNQAwFt+b0PY2uM5u1pDZIu4jRbk8Bhl9YTkWUGgWfjCIKmWNGKRzV?=
 =?iso-8859-1?Q?8j9cTeo3fFhEujMVNvyvEtawZ5SAgGK8fEqfwj2Ba4xvEb9OxLDmeJs2e6?=
 =?iso-8859-1?Q?FlWj+XT9qItn32nqI4K2F/aJBuSJKUS9h3IgRWKjVaxxUKqpvwgAgjb/2M?=
 =?iso-8859-1?Q?iHw7/hiLbFMTvGNgewXhdw6aPQ3Vk/Ay7F4GxmcTdmtNxd6awGDu8UWiB0?=
 =?iso-8859-1?Q?SqJOdt+BUKB8VOMTJ2R2OhZ8ynYqlLgYBT4LpOLTXlx2s7A1Ulcs33bVoP?=
 =?iso-8859-1?Q?GoszbHbGSzUzVwMfHbyl8H56mwIHql9wmTxGEZ5pOpUvlI59mUS6fNirf/?=
 =?iso-8859-1?Q?9iWFwddl8Ibe8Ulc2ArdyoKpNGY//ifdLM0F9rgyqBuSRki5wBsGqWbKl0?=
 =?iso-8859-1?Q?fH6XfHyL8yGHMtwr+cRu7Z1Mk93KqxVGVAYpyBqmJ4bdiF0e5Yu7jU8W8s?=
 =?iso-8859-1?Q?zTrpQq3itMzDN5vI6NMuNoyDudmNAb5h9qQmUOzmu1eL3nNDUCZS7HL0QW?=
 =?iso-8859-1?Q?SD3dHPBLmH/H4bzbivfj4VCZSFZ0MLEvSYFKIIAtlnP9+tU+pxibO/XW0m?=
 =?iso-8859-1?Q?nFcaNS9XSONiLvh8vFFGnUxJV5SgutaDZfEA3U1cb4pgs4sJLaDr9qFYix?=
 =?iso-8859-1?Q?sKdfDRGErBXITx8IarRVUcn9bK2RGxE3QxACgsGtYVTWWj57eriTKOVIV0?=
 =?iso-8859-1?Q?3hdU7vVSieFob0oA5mVvTqFN59JHK/Wi5H32LoedqWx15OJvWmLnBmQhhe?=
 =?iso-8859-1?Q?rW+lRYE6LPdHiwQIwLqHS0RTceqh96J26qIVFYzVajYVEWtAgSaSSpqnuL?=
 =?iso-8859-1?Q?Ksy64ArEUgqaJICTD8eumOmn8H7y0AJtd0M0dfoX3gMPfckcXN58+tUjzy?=
 =?iso-8859-1?Q?1UuDTo3Wx5jyKmWqBRBUzBbPoWimRHT32gpSFMNdS1sSBcTrWafPv9tlh8?=
 =?iso-8859-1?Q?cDTdeJUr9vnWFLMShsLo2DbOv1cSbGtbyOtmQETeTimup+bave9ESnmWAC?=
 =?iso-8859-1?Q?fN7RcHZinbx6ZmvnIUAyDS1GRwuhNiIQe3k+j2Hn2Ycf9Zs99DmacWeu/v?=
 =?iso-8859-1?Q?Ap6AOB4PRi3aD/TuRsPjzPqr2xMeckTSQ3HirvIZJrRf2WUjn0oMEfce8e?=
 =?iso-8859-1?Q?8TBO9Z8+AhfciY8ZVfmBLD+vrhv7QL0EXkq4lA7KxlFefs2/auq5HRlGHt?=
 =?iso-8859-1?Q?S0z/V6uZkKBNfoonBZEjAB3jQaQL4dHxdRhfPGNgqV5zqiCVlXTwwJ3vdj?=
 =?iso-8859-1?Q?P37aL/O8vwYafQvQNLhG8/YNbVgr/7GRvi?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <FA7DB0BAD29BB84B8D23C5B396B403A4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uE3nE7IDN90ccerPRTuU0pFy62bR/LgLh2aX/QhauP1V65peGNQyJ5pUsNUXGtxUA7GAmrZBV5ufleF/xGgAne61UJDAU/wWTRkLRuFwkpbk8SOlBLhEtEbxHX+Y1iT7tRGvm7fh8itV7Bk/fkp3V25GbPHenawQnwltAShXVkaj6SkPa4lP52UZ0Dnxql61ZaWIYPfgfOZxnwzDGLwrsIu6t9OrjKQofDku2l5YnkpXkLmjUs2dJ5HqTjyp5ihyYWelOXkeoa9SgMhDL7Td53LpVawJMwsSRZUfJOHncOBJK3gnQe+5teIO/t9lUJVGcGe2OxBXDIivbQ6qlZttQapwcLkwS2c8JgqyEdo/ZQkVJf6IQoopaHDz1dDej55dZOxTO3gPrAlGmZmly6FXZDJObGW3Y94/hv956+Zr4S9BUejK9iZputLMBsKi76zuEiOPiEbXX93viP9nK7TK9bcudF5qLN/rRHT1SYn7Z256gL665PJjGvIguI25qhfNBQzuZWKuNbNAEj9v27qHrtnin17IzjNxSyZXH39LMbuB/7H+BpgLtDblUjPpP6gujt3D39+MsrZ1sfRTgJWTD0GZQAWiYfUq0aHvSTpKg6HuRWC7LG9AwXtkbBFOaufCcTTdPZ/f5DBoJd+GSA3x7pHjEw3T2510m2vIq781Lvi/2WUcyQsj+lPxZXyv1rcgmppy7udzDI126ku/dZlxYCOaH5udb9zlryiJRRv0xcjbsB7hJJNmIpnqlQUwasXNQezP8l2jZzsCm3E6+npV5Z9GwLx0kxKX8T5odQpwnKPRCsbw3QMQ+7g/vHh8eimCVa1meEIzDBtpiAJxBcjhI608np6DG5mggPkte/cAEtUyVfLMJI8rZ26OM7ty3AgFYBsWuP/NvAT/qP2r8odV7g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4013.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 957c81c9-f92c-4b3c-0a2d-08dbf01fdc9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 14:39:43.8704 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HbIb7L8/2CRVLNlxt4ZSPjPloIhRxcB4itseYYfWE10rry/aEESwGNEfK/3cjtvKo0nsGqouHZkx7OFqC1Umdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6718
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_15,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311280117
X-Proofpoint-GUID: -pKpfWQXWLYRJLgOkBlVWYecm_nc5vFr
X-Proofpoint-ORIG-GUID: -pKpfWQXWLYRJLgOkBlVWYecm_nc5vFr
Received-SPF: pass client-ip=205.220.165.32; envelope-from=jag.raman@oracle.com;
 helo=mx0a-00069f02.pphosted.com
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



> On Nov 1, 2023, at 9:16 AM, Mattias Nissler <mnissler@rivosinc.com> wrote=
:
>=20
> PCI config space is little-endian, so on a big-endian host we need to
> perform byte swaps for values as they are passed to and received from
> the generic PCI config space access machinery.
>=20
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>

Reviewed-by: Jagannathan Raman <jag.raman@oracle.com>

> ---
> hw/remote/vfio-user-obj.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> index 9f5e385668..46a2036bd1 100644
> --- a/hw/remote/vfio-user-obj.c
> +++ b/hw/remote/vfio-user-obj.c
> @@ -281,7 +281,7 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vfu_c=
tx, char * const buf,
>     while (bytes > 0) {
>         len =3D (bytes > pci_access_width) ? pci_access_width : bytes;
>         if (is_write) {
> -            memcpy(&val, ptr, len);
> +            val =3D ldn_le_p(ptr, len);
>             pci_host_config_write_common(o->pci_dev, offset,
>                                          pci_config_size(o->pci_dev),
>                                          val, len);
> @@ -289,7 +289,7 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vfu_c=
tx, char * const buf,
>         } else {
>             val =3D pci_host_config_read_common(o->pci_dev, offset,
>                                               pci_config_size(o->pci_dev)=
, len);
> -            memcpy(ptr, &val, len);
> +            stn_le_p(ptr, len, val);
>             trace_vfu_cfg_read(offset, val);
>         }
>         offset +=3D len;
> --=20
> 2.34.1
>=20


