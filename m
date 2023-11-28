Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9607FBCE2
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 15:39:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7zEf-0006Dm-Ez; Tue, 28 Nov 2023 09:38:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1r7zEb-0006DV-WF
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:38:46 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1r7zES-000518-J7
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:38:45 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ASDTNds009219; Tue, 28 Nov 2023 14:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=3MocSvrMRXBca+QdtpggtNN6gbNfGLOoqc533XbO5Sc=;
 b=hJ++YBmidigj8wflNlOs+PT/cAWJlHWII6oNmMnjrjXG6PenX8+V+58oPpkdq4fCyO4t
 WiTSR/UIX6cH+D4i7kIGIUGGVEb18/qr5wW+PCSfOErvSgBoMJLP5BxWyNWBR5NuciZG
 Ywd6n98JStTfObZIeoWB/IaioMSR4F0aic4hHyTz1EdVLQfq56Ol6tswbZu4E+pfXqzg
 snLROpbCwNejM+0f3cmNmvBOzox8CwIAI4pzUxS03BE3DbUzbhxmbRgQonyAh33AnbgG
 Syw6rkOOAe3umDcmXhbzu/x1zWBppQc1raIrVjQRTYaHUa/D3SaqSO9Io4MUkFyYbCFN xw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3un5txsf8k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Nov 2023 14:38:31 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3ASEGISt012638; Tue, 28 Nov 2023 14:38:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uk7c787cu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Nov 2023 14:38:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToF/U5aomQc+pFXQFFLT51O+QW/V9n66kVNwe228l1Wa9pzLLxFw7hDXJ+WlquBZjL7LpuCZKl1q1YSg2oQj6rDXX4cWAG5R4gsfNMDwsrimxRNjCZn2VHW7fT1EX3Hq9Lsb7wueuJmJ9+X8u8Ge5jplN/8M8+3pBdROPaqUFNeBcBHvVHhzRKUvBu5cXbATsy1Bhand7U1OxEFFbuw6L5u3gagKYy3EnHdg9BlHMEeR8MEppSdUrv7y8z1sAwIQRdkmtacwNFutTwM4NFe/huiPCRcdcnf6Oa/euA6KKQEF8hw3d7eMcVFUmTrODN38SK0nHgVzbJgZUcjTVWnkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MocSvrMRXBca+QdtpggtNN6gbNfGLOoqc533XbO5Sc=;
 b=Jh56IzskW0TU3YPrfDAsJ57cbaQQ4M8hGeQjh+4Ry7bRl3lWrsQWEKG+/FDEpHF/T7fHsgAMxfci+NQQvSsHJPt4EaLd1L3qZsspRNS/9y5kOUrFyFm135Us1xWGZtEF1q4UoXa8e9RZyQjiP8wsYI46pl032iIHjiDNnD3u8HbmKuAo+nrPflFeYUCuqKRQIIIqVj9EeKhKlAhxfrxDg2munxVmuUkXbrhGL/duZJDD6zUcydj8X0h4AC7lSCAqKZuk6pTtoZeWtxQP4CZmV3rxZ8KjLGGC84U3eh2EoPtjngzeUg+Bd01F583xw+zfU364/62HwK8KIgNN36XfWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MocSvrMRXBca+QdtpggtNN6gbNfGLOoqc533XbO5Sc=;
 b=i5RWpm9kkMJNqy63+wY4rNghBM1tMDtDLaQ/hbj+MJjp3w8YqXFLsI5uDI2kxMGi+Ym0/+qV7HL6b//TCN+ELd2EoRj1egw4YgoG1f/xCtqQ6m5Iqt908ipD1yWko+ArDUY+vVRqk/zeAqxDdJGRQnFZa3O9TdABjZcKKEoifmQ=
Received: from MN2PR10MB4013.namprd10.prod.outlook.com (2603:10b6:208:185::25)
 by DM4PR10MB6718.namprd10.prod.outlook.com (2603:10b6:8:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 14:38:27 +0000
Received: from MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::3ee8:64b1:5ca6:c5f0]) by MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::3ee8:64b1:5ca6:c5f0%7]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 14:38:27 +0000
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
Subject: Re: [PATCH v6 4/5] vfio-user: Message-based DMA support
Thread-Topic: [PATCH v6 4/5] vfio-user: Message-based DMA support
Thread-Index: AQHaDMWm7/wnkBhCcESdrwbIQa3YE7CP94AA
Date: Tue, 28 Nov 2023 14:38:27 +0000
Message-ID: <07E1244B-ECC2-4691-923E-07673C913D04@oracle.com>
References: <20231101131611.775299-1-mnissler@rivosinc.com>
 <20231101131611.775299-5-mnissler@rivosinc.com>
In-Reply-To: <20231101131611.775299-5-mnissler@rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR10MB4013:EE_|DM4PR10MB6718:EE_
x-ms-office365-filtering-correlation-id: 2e093839-7cab-4efb-9a71-08dbf01faedd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YgynLXEXpq8LefN4F4EwPz6noKFGOdTrKHyL2Mb56qPMBOSvFTpnIYjx3ZOI/ipBkm1e7B01bjq6BMRG1EsqJEJjqmCpSTr941dJCI8ILjCRFJoEdCv2KRpEnXzB2QzaNGlAz5P0LYjoe1oDS/y5dGMGoeTmrjXzcjQ5nQbKYmpmyUdhMlDb5tlfmSPDo9SM5LnTE8BrQscAzyZ6Wo93LvSV1dk73781AMcXN3k3rmCJ9KI3lKWbU8UkLj4kJOCPn1QRNFqZCFTdPUe6TmfwF1nyEDnxVhyyOiKtEC0FUE1UVtTaV690zdudueQ1VxxI+3V82oqdDjNXQ1g4tMP7d01nhwGXQH73hjsTZ7vBg9hfNr8iEL+hivglGadE+npmBoz4iqZcn6pgaFIIx2BOBaoqLA0a9/pyqZ8+KgYK6w/QiI0ALb/gz11obml6bOfI6ORB6xJq+gqn8cdijlx2l98YhpeuS/3qbaF0qyZOJgeqO0Vq8bHs18JjVRLaWw1U0dB9VZdteJwvM2ctipIbiUjyJoqi/QyYyS7PKe5Xzdz7hjcjsn+SLirKQtB3uF+FNK8OB1Tz/yjuAxV3/yh7sTJfK+wadPfTvBs7ayKhUpZY5tekmokF+nHfVRsTDkGQZoEfcl65n9XDTzoC+RvFqQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR10MB4013.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2906002)(7416002)(44832011)(66946007)(41300700001)(76116006)(6512007)(66446008)(53546011)(64756008)(8676002)(6916009)(316002)(66556008)(66476007)(8936002)(54906003)(4326008)(6506007)(478600001)(5660300002)(966005)(71200400001)(6486002)(2616005)(26005)(83380400001)(38100700002)(86362001)(122000001)(38070700009)(36756003)(33656002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OC7ltFNgW6tKbMvpi2CKT+GtoB9E3Gw5i1MpWvL5KG4gGswW7XGQP4JZFe?=
 =?iso-8859-1?Q?PpdG68HjM3zSYCfui89FvgPOx4+8HTA20dAJwE0qIvyXeaXBzw6zIBJP/5?=
 =?iso-8859-1?Q?69AYNZTdHFOMzs1R4J1U+bwWg2JT/+N+bPQiA7D0axsdKPo1sV98MhKSen?=
 =?iso-8859-1?Q?/D9spFB4Kw7q72emDXFKLr/ZHOPpqueteSgjOCDcIdjwN7HJUNTiHszYBy?=
 =?iso-8859-1?Q?UEJysf7qOH3rRHomrWLDvbHL+nZxAiAYpMbNpwMuu39N2kh15Po60Tec8h?=
 =?iso-8859-1?Q?XCpaTJOYEebBFyz304jlMi6HRMZ9O5v9unhkEhOLVtNmRXfdKG4Cqti54I?=
 =?iso-8859-1?Q?qf4vxs54D9+gpguSVVH+mlTSyyRx78DzHZYpqH7P2L26Wkaa9reaTxzB2d?=
 =?iso-8859-1?Q?c9Ws84eUQdj7CZJZRB2+6/MqFJ+A7rHV9bqx/Xap2N3B2LhDFCw6dGeTNB?=
 =?iso-8859-1?Q?uWoTA04hLvsWnhPzBI5J6LUu5QAn2E77VwAXdNOjKZ4TIjrqMnhpyyO/1F?=
 =?iso-8859-1?Q?jcXgxEAyPP01+wub17HDUxsdrmfPouUoL4AmeVhGtwoL2q0Vbln2VB39rR?=
 =?iso-8859-1?Q?6s9Xm3wDlIXwkP07bH89IvfDF5EHDlhgY7bRH2YSgHo614R10htOR7IF6c?=
 =?iso-8859-1?Q?QUNb10o2BDMmG1CSpWhfYTVs+/yDIp4AFGHqvvcwgJlXUtmO7RU5QUPU22?=
 =?iso-8859-1?Q?UAdOFmZFS8OiTPBD97X6PVkdcivH2Emv5fr8z0F5AEsn0OMjJvC++bRfhf?=
 =?iso-8859-1?Q?NarmiWGZl0uUBl6zvXabNWE/JwNXJxlzxVA7+RcNgN904eZFkSXCfO6it3?=
 =?iso-8859-1?Q?nUQ6KgpWj7GXfl09htbC1pda385p/qMsKtZ2yhq0klk9+YwwjqaWB4enwv?=
 =?iso-8859-1?Q?xwJ/usDcqqzOo5fRu80IWC6T5yI/+XzOK+H7zeQs0Y9BW1a0u54SX2ynJm?=
 =?iso-8859-1?Q?J6TQXRSFyWKONUXZ1F4lrR2WCcAbKC2Yp8IDgmYX+YAaBsZIBnk+qyMa/O?=
 =?iso-8859-1?Q?8WrkCVzPFx2ioZvJosEJRIe2BhEbcMQwUThSOdcz9pfWqaQGLz2nVgRRtN?=
 =?iso-8859-1?Q?shHqvPMyXghPhD+yW7QVLeOhmOn09mRgicZBBjtT5DyhjXUgKBGmhBO8eT?=
 =?iso-8859-1?Q?se5cft27b2LR14KKHavWvVATLQBo5YIINx5DVzLRJd5TnXzyppQKxD3AOn?=
 =?iso-8859-1?Q?Rhg+B+P+RLxd4we7Tj4fv2UznIm9RW9RozhrTcoLwrU3Cf7JYqNqfZURzJ?=
 =?iso-8859-1?Q?BvaphX7ljkgtjH6ZXrWY4I0FGNd6gsPrr7DVovhdkTkymotEDqGoLwET50?=
 =?iso-8859-1?Q?I/FTm7XC4v1LTdw6CFVIzAcZIxL7ae3jy+B4DT9Q6Mfe+MN0RLs2UVvkq2?=
 =?iso-8859-1?Q?RL277bzPwWBOFu9xnSRk9tMrKKjitNA+OgmKvO/ivEAlNj+D2L2Tf5Zb4U?=
 =?iso-8859-1?Q?BaCoHWn5Pthxozn9QPAybSI73I6Kfv+zluF56oQPKLYZF5nEW//9aIIY7Z?=
 =?iso-8859-1?Q?H2f+tHjIdK0O4c/b6r/x9k1xHvqjz275DtIvjmOXVDTo4V6iSAVXVFZOpU?=
 =?iso-8859-1?Q?SYhjqUX1G8Mj1y+frO2q+ItQQx7C8ETO5WWbYva+YqDt6iek+qjUeBcwFH?=
 =?iso-8859-1?Q?wDw5HGvEdB3wJIc8pHOa3dj/pmBfuCjwfr?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <C5E726B3AB6A6C429D80F69C629114D6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: M5ggzAJV+0GGSxrGGmsVKoPGvsE0SkRBWMgBGqbHtY5zrfrRvXfot+SJoEKm00K9pO9NPQ+i8eQnanCV3hpmXAYGl70XvnQvsoq2maEe8HI2AJLB05eEp8g69HdFyLgtcVVB2BEWrPZUQYMmVuJRi7S+L/A/I7EPNPJfSHpXT7fhzY8NklQ6NuqsRGqRlz/D/HWiHLY6z0m/w0M7wyPr9HdXNPSLGiBwV5kJHf3iSb573IofUIxbv++Hw1ClPPDkmh4/ZbHup5zyBwQa+H0ZStCHoZX1OnNP1dNy4PkfGEzGpDHpnNGQqpPpMiseMV4TRyTRiVxA3mctD1wnESPBKy370s9Zb9XXQ0bVnF42F3ECeSQfRDa8dtBIW3twXKWU+E1yQC74IW5oC4t4stsxLcRcV2Ljs7wMOTdgsHYYDyF3OQrVJH0BPcCTD0cfB/xexrVCvLPdoM9Fn2+cUMjm0v9/WUIdA+c4HkWEUiaGOjQSy2um39dFndWlaVz9wYwmtGVPDBWezZ9RAE53J/Ut+cxEG95l9snpVQ4F8B2vkJ+G0Z1aTJiF4J865Po+iZ3ItqU5NXtktT7CD/d9MsPACC0f34nG3hLXlSiMQ+mWmWXN2Awr/tOWNNSJscGVR/9ra+RHO/x/EGsGmZEnyzVWXY23K0amAutr+5DEQ60tWxazQNNxFEGzQ3pobuN+USVXYF/NU//UDKVXi9PelbfAERVcHuXJJMofHiCcWnM9d0mAo7yTzJvfaY4eERl8h6cUkFelBf+kYQNcheumQI4FppO8wtW3oQtD/UdTZzwQfNnMKD9atClw+1zM0VmXxOjH2VdNzIA4ae9Ytj1co3ye336ipGKtuK3wwTcKv2pziGNU7D25fHHnJ/hPX4ksz9RVOKSSKA4T0Ony9w7SP47Hfw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4013.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e093839-7cab-4efb-9a71-08dbf01faedd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 14:38:27.1438 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0+2bhdTOrrM+5SrzUH1SqCMlRxiU68CkH+d07g3Kfyzwo5RHTKPG5D4s7h5UQncdwnbuaLpvxId+0smNyQ8Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6718
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_15,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280117
X-Proofpoint-GUID: pvS0R_ICMAVW2ziZ8ImZf_lbtsVd_2F4
X-Proofpoint-ORIG-GUID: pvS0R_ICMAVW2ziZ8ImZf_lbtsVd_2F4
Received-SPF: pass client-ip=205.220.165.32; envelope-from=jag.raman@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Jagannathan Raman <jag.raman@oracle.com>

> ---
> hw/remote/trace-events    |   2 +
> hw/remote/vfio-user-obj.c | 100 ++++++++++++++++++++++++++++++++------
> 2 files changed, 87 insertions(+), 15 deletions(-)
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
> index 8b10c32a3c..9f5e385668 100644
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
> +    }
>=20
>     dma_as =3D pci_device_iommu_address_space(o->pci_dev);
>=20
> @@ -330,20 +400,20 @@ static void dma_register(vfu_ctx_t *vfu_ctx, vfu_dm=
a_info_t *info)
> static void dma_unregister(vfu_ctx_t *vfu_ctx, vfu_dma_info_t *info)
> {
>     VfuObject *o =3D vfu_get_private(vfu_ctx);
> +    MemoryRegionSection mr_section;
>     AddressSpace *dma_as =3D NULL;
> -    MemoryRegion *mr =3D NULL;
> -    ram_addr_t offset;
>=20
> -    mr =3D memory_region_from_host(info->vaddr, &offset);
> -    if (!mr) {
> +    dma_as =3D pci_device_iommu_address_space(o->pci_dev);
> +
> +    mr_section =3D
> +        memory_region_find(dma_as->root, (hwaddr)info->iova.iov_base, 1)=
;
> +    if (!mr_section.mr) {
>         return;
>     }
>=20
> -    dma_as =3D pci_device_iommu_address_space(o->pci_dev);
> -
> -    memory_region_del_subregion(dma_as->root, mr);
> +    memory_region_del_subregion(dma_as->root, mr_section.mr);
>=20
> -    object_unparent((OBJECT(mr)));
> +    object_unparent((OBJECT(mr_section.mr)));
>=20
>     trace_vfu_dma_unregister((uint64_t)info->iova.iov_base);
> }
> --=20
> 2.34.1
>=20


