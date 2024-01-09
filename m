Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C09828984
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 16:57:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNERz-0000ML-AS; Tue, 09 Jan 2024 10:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1rNERv-0000M5-MG
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 10:55:31 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1rNERs-0000il-2d
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 10:55:31 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 409FdSFt021095; Tue, 9 Jan 2024 15:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=PVK9DYwO5FCgXJv4196Aa0foVUFyNc40PwooypkTqHw=;
 b=XEPVaj3TxNd5EaFIwqu7+eNA0lIV3umd0MxHzruZHlBdihF+GN3dHLUs9zj8GDj/iUnZ
 EydMgGB8z4JDcxCBU7QBkg5Ln61sufk1wn1VxUJNN8juDnrNhT2EwgRylQL117EhH2vu
 3iLdBRd3/Q69yBRd93LYyhNntCXgu47/tZmWhpeH0SSlTvf2F4yOrB1dcsiRaAoyuk65
 JULsqyejX78Ehyf7Lsd1DF7twxDFBsx0mbA+Wu9RAIX/yW2mrv9G6DqnaiOfC26FaJDs
 NpLmBViDIf2cPEnjks8NtDBRGFSd8gTCzI8kXfmynlCdm3LIO4rqxgWs3rWprCQQUqZV Ew== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vh88mr6ae-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jan 2024 15:55:21 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 409Fegvs013855; Tue, 9 Jan 2024 15:55:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfurbh7e0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jan 2024 15:55:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFxcIY9MAcN4tqdQt5HjZ93vo86tZlkYilFWzr+Paui0yX1yOoyX0Tzwfj5L0KaAQ+zt8Q4h777Sl1JUJAWUn5Vdugfg3dZCP/TQ8TYIWfxl9TNt5+FKq4FksK2ECNm4RiIhD8DQWpvMEzUntkIXFku0QH4uWdCFb1y6gdfVK6Tby6vtjWMscZbI9l25505iNok+021flgXFRv6Y2xuvNfM93zRKw72xKCw3hFx7dX0WMQgYKA+gpY/HYJDsx1+RLWbA7Pxq7Dc2R0WOp9uTA7rUhQy54J8nGEN+nmTbV0liX0Lgy97byE2SOZQecbYTaZoVmhT0zDi5J8Sz8ah27g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVK9DYwO5FCgXJv4196Aa0foVUFyNc40PwooypkTqHw=;
 b=ISZ7CwcDP//XJYV/czpkXpw8f45JYOBPQNoOmcSzOp0+yKY8di3WK+IsRTVS8o4Hi/QD8SmDx5V1JPjFi0kUBvaSALYaIrr76SkscRq0Yb4iyn6tYs+lAs7XoTaVbLVb1tBQycxYp4r+Xmbf9yAEjsAs2126IOIaLgFCuvdysIM9ryTX9m0HbIgmBKch2P6Jo5DmxiGA35JTLbB6NRpLpKYC91mKuRF9XDLcLxiN7jrx6tjDTanhiJvvYqjF1OkzWCS4WHFoxV7K3pH4RURFUVvSExN5JL3CkSBbr4BjpbjxXhZtLE7mdMRpVHu8Xu9WV7vzX9qFWbnDpnlMFu6YXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVK9DYwO5FCgXJv4196Aa0foVUFyNc40PwooypkTqHw=;
 b=im4gRuUndvjA6ldG6HkJo6VvurU4tANT6iaGyvYaTOJxRtSphIeyoc06Cy6alrGlj84tXJxm72lRnMkuKWQf8IXjAF96euo8ILs3EC/X+zhDAty9vARP8LHHq8Hfe3I4RKYPZDOO7Ojb0kj03zsbZ5HAKBPjZW3DkoucETGpeNo=
Received: from MN2PR10MB4013.namprd10.prod.outlook.com (2603:10b6:208:185::25)
 by IA1PR10MB6688.namprd10.prod.outlook.com (2603:10b6:208:418::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 15:55:17 +0000
Received: from MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::3ee8:64b1:5ca6:c5f0]) by MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::3ee8:64b1:5ca6:c5f0%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 15:55:17 +0000
From: Jag Raman <jag.raman@oracle.com>
To: Mattias Nissler <mnissler@rivosinc.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers
 <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 "john.levon@nutanix.com" <john.levon@nutanix.com>, David Hildenbrand
 <david@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Elena
 Ufimtseva <elena.ufimtseva@oracle.com>, Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 3/5] Update subprojects/libvfio-user
Thread-Topic: [PATCH v6 3/5] Update subprojects/libvfio-user
Thread-Index: AQHaDMWjWoperRFDP0C26s0Vy0f5B7DSDuOA
Date: Tue, 9 Jan 2024 15:55:17 +0000
Message-ID: <AB0FEF17-1421-45C6-B67B-DEA80559E74C@oracle.com>
References: <20231101131611.775299-1-mnissler@rivosinc.com>
 <20231101131611.775299-4-mnissler@rivosinc.com>
In-Reply-To: <20231101131611.775299-4-mnissler@rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR10MB4013:EE_|IA1PR10MB6688:EE_
x-ms-office365-filtering-correlation-id: 439b6e28-94e2-49e1-900f-08dc112b604c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +HYBdVXMFmkdfptqLbPrNGCJ1/d813ZGg1Kgyt5/jBR2mEme6zcdoG1746VvHuLI26guP0mWBncC0WYLJ+FA/h50EvrtvPqKYSeI66y/OjYce5AOPZlMCRsptOqYPLRE8PV7FwRWJ3bT39IScVYvPoGWBDMNVxmoXjzdxSVH2HyUEDP5F21pfvvtCzUhhKOeR1R9YFtzT9p3VPTjXw0nd41USdAMxUNW74yJudUpwOBlkmKxjtbWvTv+Dbhbz8HI71QoCKOq08qoRnW1js2bX77QlTPoGvf5II9TwtFaUObcLAYPFHKgjEOgiFyv04SAxPujW8NfPOopc1J/nTDU5HKM+rrfaQRX3Inl/PxK7fgQW7q0APQNyrXjdQuic0G+AQpsCZ8BrkbbCONleSvaFFx4OQhOmRJeAu9/27AYP7wRQJoXbRRIdbQ9bMQaGRS0rIwvgcWAw1UrVSuOs+rkP8D/Ygz89VdT0N4LrzFusolg45kJKY+FNQccw1DSSVUP/oNWWRV5qvxFBGEMcmr14fnzRv7Cb/G+WrJdMCmnrGRcxOw65agk8OJKJj3NGpR6Iwbod5WVqR/A5xyaSzoXqH8kOJzblyBRVIR/8t/YCe/pqImIzg1nkl6p5UnO+jdM1jDVSHVYlEo5iJtZACpNSA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR10MB4013.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(6506007)(6512007)(53546011)(2616005)(83380400001)(26005)(4326008)(44832011)(38100700002)(71200400001)(122000001)(478600001)(966005)(6486002)(66946007)(316002)(76116006)(8936002)(6916009)(66476007)(66446008)(64756008)(54906003)(66556008)(8676002)(86362001)(41300700001)(33656002)(2906002)(36756003)(38070700009)(15650500001)(7416002)(5660300002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkFNZ0VzVGZoU2pNUjIxVE5zOWkwMjZ0YUltNEhqWWFJL0IrM3lObGVzWTFp?=
 =?utf-8?B?WUJBSlZ6S0pkU0s0YUV3TmdFZlhrRlByVGsvaDFmYXZMV2hXZ0M5djhGTUFC?=
 =?utf-8?B?RHdvV2YvMUV4MENiald2MXpxOGxOKzFnbW9FZHZmbk1iVDB4bHVnNU1sbUlw?=
 =?utf-8?B?bTJ6N0ZDajdPTzBHRDNwRDQzcjdQZnV2a0NTeUI4dVlxcjNHUEhyeEVCYjFL?=
 =?utf-8?B?elIwVDNFNCtuOXJLNDJMODNMU09zSTdPNUVLU0N0d1R1c1ArSEtrZG05MXFj?=
 =?utf-8?B?ZDVMNDJldndjbHBKMDFOTnBYeFhvY0lNMVhpOGZibzJkbDlsZDlyUEFpc0hp?=
 =?utf-8?B?VnRET3F5QW1FVktKVnR6cEhpalRNZ2YzTFZqdmVUNllqSDF3dXFOb1FnT3Zl?=
 =?utf-8?B?K3NwZnYydC96Um5BcWhxQVRISjlGSG1oNWFsV2dKWGlYb0hvQ1BEL3F1TmFy?=
 =?utf-8?B?QWw0OG01SEF1d01vWTIwb3ZZY1VzeTZ3bUhCdVowOEszOG5Nd3h3bXVzbnlq?=
 =?utf-8?B?dzR1OVlTNiswUEh4OWVaODgzdFkyTEV6RUV5VlVzTEZVbHYvVTF5RUQ0ckRz?=
 =?utf-8?B?Q3ZxZjJ5YnE4MzNtNVhXQzRNaEp5UkdFQ051WUJTY0pGenY4WlNYNGxlUTZq?=
 =?utf-8?B?Y0VEZmxYUUdVWTlzTVVNRVM2cjZVQ2t4YytPYXRCUzZlWFZYc2t0QmZhR2Uw?=
 =?utf-8?B?NkNqazlpbWdhWkw4bXpySUpiS1g3YTJqZ0ZYSVRPZ3oxeWxqWmpSVHFBKzNE?=
 =?utf-8?B?YlNma0JpTTJ6UXBCODRTeEN0akFiY1AzUGVZWElXUHplazhCQlgwQ2N5NFNH?=
 =?utf-8?B?bnZ5aC9ZSVRtSmVQQjAzU0pZbUoyWU01eU8wdGYraGE5dzZpTTJEVW42TGVj?=
 =?utf-8?B?UHp2SVRUZ2thRjd0Vm5sNkJTYnFBS2RjdlhyaTdBcXdLamR3Mm5sNWExTmdK?=
 =?utf-8?B?bEkzc1gydy85S1ZaWjA4WlN2ZFU3ZnJLbGNYT2k5bFl5SVovUDFPYjZaZlkw?=
 =?utf-8?B?QVQ3SDRoZlZhQXJwc3N1TG82S0QxZXU2M0FGNXZVb2s5a3MzR1ZaTUVUelR3?=
 =?utf-8?B?dDI5N09nTTg5M2JDQmc5MjV6ZUNoT3Mrb1JZUk5YZjNjZXlCMTJZRUhUaDZz?=
 =?utf-8?B?S2JRQ2JJdEF6RFNHQ1VYRXI3aVhPRS93SGJBcTFZV0tkSThzWVBnNkF0dW9P?=
 =?utf-8?B?YmZwNUtHTWZ5M0FzVGtUUjVvVlhqT1dGSW5aR2srR1hmY0hOOFF0TkUreHB1?=
 =?utf-8?B?SFQ0NkVYbExha05SY0ovMkNJQkV2V0dWZ082cnB3U3U3ck85ZUxFS1RPbjEv?=
 =?utf-8?B?S2ttdXp3Smgva2crb05RWUQvVkE0QTlzZHlrbHlibmVOT2xzTzlHbXJiTFV1?=
 =?utf-8?B?bjhlbjNtTXlrYUlVaklQbXFZTCt5QXpraDdJMFJneSt1R1FiVWtJbCtyWWJy?=
 =?utf-8?B?OGJaN01yUkVPdVYvTzJFRXF6amJpMVVDMDVrVGZhTHJzOFBIanJ3alVTaXRB?=
 =?utf-8?B?eGNZMU03SGRZc1JnOEVDNHp4VGVYR0tsOW9SL1I4SHBEVHVmMUpJQi8xSDZ5?=
 =?utf-8?B?NUVoYjhYRnVKckw5cjI5Y3Y5MGF6YS9kS3ZrdWIrY1M5cVN6Y0VJUldmb2ZX?=
 =?utf-8?B?YVB3Nm9haEF4bS9KT3BtSVZqYXJScklIdUZvVkZrNnBMVk5Dd3Z0RW40aExT?=
 =?utf-8?B?eG5TMGtXbmFTZUFESjVySWxXaXVxR3BqaFdNdzhYYmYyNEx2M2p4ZFdVeXNa?=
 =?utf-8?B?NERpQXhiWGRGY2FlbW9BamZuQVZTdmpKQyt0Ty9DN2FtVCt5OFB0YnU3clBF?=
 =?utf-8?B?YWdKR1JubGlPOEpOais2NlY1dHNZQnRGcGtYdk9DTzYwcGpkc09IQ1NHdFZi?=
 =?utf-8?B?RW5VWW56WkZJUVVvb0tXWWFIa2YrU1JsTlh0b3U5blFLb3FFNisxRUNsNllj?=
 =?utf-8?B?VzlBN3luOWxBc3Y2cUdwamVyRkl2bGprYUlNNytkczNyaTB6cjBTZFM0VmJE?=
 =?utf-8?B?VXVIdEozVGxPN3NobXY3MUNOVEhKWWtjMnB6OXFUUnJRUlVaMlViblNyOU5u?=
 =?utf-8?B?Y2tTS2RPV2xlL1R1c09BZGFaMGJ1eDMwNDZKV0h4QUFLS09seDdDbWJ5Y2tv?=
 =?utf-8?Q?i37whQB2knRF0glLYU9Aluuk+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66969319B9D21742A0949083C1FD92F0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ofTsi8ZkKmc5k59YaCj+LDUIC0gUXzV8f62hNweJGgrX7qrAx3MsP0xPCxPmTQ5gpPNmEO7Eq1ErY3nUX7t3U07n2JCiTy8XxTWQ432rGPiThWyX09mMpSohGkUh8EtHhAsqw+7q56F/I3/G407ERCwZJwIfeTxrZ89mccjn4hZ0Fx6BaPyx/qrTGDuCjbj3j5Rw2ukOL0+nukcdOjptAo2TGg16RIYxEkUZtClXEr3sVuz6SOEWfJG+MpgIi2pK00CzqDNBZhM/XQS53yiJ7qefIRCNiH33p2mhHPRJq9FlX9FKabMRAgdaYzz4CpVXeQsmilxBMg9pyLx9R3Lh5FmpAS6HW/7sMbnOrjSDgPfFANADA3jeUNSQcHhIJG6ZfOspTCiwmFyYRFyTtjB7JSVnRh6dQeo8QjlWHgt01XEJMMOTgrofgJNcwuhGa08eBnpfrnEaMy5t1gjFr0jzhW5M8xJEiDRLrC1IFLP0DbYVI9FNkfw4zeLyQsUD1VnLbrU4PAiBhaPOdtT1uiWL0/M0Bn3fI+3JKCK8ANac9MSW56lDZZvxE5nnJJIXmzBSHrLVsGH7YJOh4HDrLJSQi/wyxjhs9zMEpgAQSzAtiyY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4013.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 439b6e28-94e2-49e1-900f-08dc112b604c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 15:55:17.6465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nu3agcLRaTGKFTGabw9KZjYLqjwYofDTpMvKY8SYgalz1z6dYTNheFohHaC21WJfD1aXngSlFL94YvTCpOyAsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6688
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_07,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401090129
X-Proofpoint-ORIG-GUID: ShuKhr-G1U_ivufP0lh3ONe1L2Du3a2F
X-Proofpoint-GUID: ShuKhr-G1U_ivufP0lh3ONe1L2Du3a2F
Received-SPF: pass client-ip=205.220.165.32; envelope-from=jag.raman@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

DQoNCj4gT24gTm92IDEsIDIwMjMsIGF0IDk6MTbigK9BTSwgTWF0dGlhcyBOaXNzbGVyIDxtbmlz
c2xlckByaXZvc2luYy5jb20+IHdyb3RlOg0KPiANCj4gQnJpbmdzIGluIGFzc29ydGVkIGJ1ZyBm
aXhlcy4gVGhlIGZvbGxvd2luZyBhcmUgb2YgcGFydGljdWxhciBpbnRlcmVzdA0KPiB3aXRoIHJl
c3BlY3QgdG8gbWVzc2FnZS1iYXNlZCBETUEgc3VwcG9ydDoNCj4gDQo+ICogYmIzMDhhMiAiRml4
IGFkZHJlc3MgY2FsY3VsYXRpb24gZm9yIG1lc3NhZ2UtYmFzZWQgRE1BIg0KPiAgQ29ycmVjdHMg
YSBidWcgaW4gRE1BIGFkZHJlc3MgY2FsY3VsYXRpb24uDQo+IA0KPiAqIDE1NjlhMzcgIlBhc3Mg
c2VydmVyLT5jbGllbnQgY29tbWFuZCBvdmVyIGEgc2VwYXJhdGUgc29ja2V0IHBhaXIiDQo+ICBB
ZGRzIHN1cHBvcnQgZm9yIHNlcGFyYXRlIHNvY2tldHMgZm9yIGVpdGhlciBjb21tYW5kIGRpcmVj
dGlvbiwNCj4gIGFkZHJlc3NpbmcgYSBidWcgd2hlcmUgbGlidmZpby11c2VyIGdldHMgY29uZnVz
ZWQgaWYgYm90aCBjbGllbnQgYW5kDQo+ICBzZXJ2ZXIgc2VuZCBjb21tYW5kcyBjb25jdXJyZW50
bHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aWFzIE5pc3NsZXIgPG1uaXNzbGVyQHJpdm9z
aW5jLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEphZ2FubmF0aGFuIFJhbWFuIDxqYWcucmFtYW5Ab3Jh
Y2xlLmNvbT4NCg0KPiAtLS0NCj4gc3VicHJvamVjdHMvbGlidmZpby11c2VyLndyYXAgfCAyICst
DQo+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL3N1YnByb2plY3RzL2xpYnZmaW8tdXNlci53cmFwIGIvc3VicHJvamVjdHMv
bGlidmZpby11c2VyLndyYXANCj4gaW5kZXggNDE2OTU1Y2E0NS4uY2RmMGE3YTM3NSAxMDA2NDQN
Cj4gLS0tIGEvc3VicHJvamVjdHMvbGlidmZpby11c2VyLndyYXANCj4gKysrIGIvc3VicHJvamVj
dHMvbGlidmZpby11c2VyLndyYXANCj4gQEAgLTEsNCArMSw0IEBADQo+IFt3cmFwLWdpdF0NCj4g
dXJsID0gaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9saWJ2ZmlvLXVzZXIuZ2l0DQo+
IC1yZXZpc2lvbiA9IDBiMjhkMjA1NTcyYzgwYjU2OGExMDAzZGIyYzhmMzdjYTMzM2U0ZDcNCj4g
K3JldmlzaW9uID0gMTU2OWEzN2E1NGVjYjYzYmQ0MDA4NzA4Yzc2MzM5Y2NmN2QwNjExNQ0KPiBk
ZXB0aCA9IDENCj4gLS0gDQo+IDIuMzQuMQ0KPiANCg0K

