Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AFF75CA91
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 16:50:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMrRo-0002uH-OO; Fri, 21 Jul 2023 10:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qMrRi-0002iB-UZ
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:49:31 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qMrRh-0004lx-0N
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:49:30 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36LBo1b4027837; Fri, 21 Jul 2023 07:49:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=Lu7RYOYUT7ZvuwWWjZLt5SHjd1hMIBqQ7OkfsG
 17fWw=; b=UtK+Nej4bvtZTPdUx9b3qIMHFJZYN91ybk2jbtUvWQ11Rn1SqE1Atm
 d94u1I+1UzPPkI8+5w6sQGM7QrTNhaC5a44jRHYPHCC/tv/+go0V23/ebhI/dox6
 YGhB+AGmoJpeCArwNd7v1i36c2OSLKUACkEYokFN5vzUT83gWiHvJ/Tn3EFodxFj
 2Bytu33+zKww9bBxTM2hJRB18qg23qvg831Vkln0/uky488QCGCT8WQK+zuU/8pG
 6uoIJ7XqcBpkAUbBoPesk5bUZ+QdK7fTj3NQAfnUdp8IHU9WCEBEO+VMeQiHNwa7
 AUB5X3SRtKNSf0Q+2QCpIqkMD74YTDmA==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rx319phvh-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jul 2023 07:49:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8yXIdo3kE6yWzHrvIuat6cgY/aZsTt1fjLwgLMhupnNE8qeGZagJGx8uUcm0hVsqnjW6gqHQeWwJaWK89+R1EUGme8hkMQYF0tkh0IOLdKGYCApSlfRhJOEVrrrst7vbjedHcItTg5OQgBTNoCuK7A6aloutX8x+/15lJodFGCMD9ZrrGbdMk91gqs4/DDp01M1M2tuhr4exh4SmR59XU0vHovDAJFTYrowhU/vdP525lmeL9iZ0W52gL4rRQ+GUC63pgWlY5Qr5/Oqgyu+TWUr41UOH1wNERgsHKukX7kIrTtUbzgPuPfseuUmJx7afsNWpKZZE0Nazbkk3/SXmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lu7RYOYUT7ZvuwWWjZLt5SHjd1hMIBqQ7OkfsG17fWw=;
 b=Z+1lenhbMQhHHOA4eQILGTFL0h4V0l3a/IfQKY7n65cTP4NxE8iqFXPVP2hP8Nq6D3WtHZVg6hLOTaepA8QC5rhXbMndn78imz8vR8YvyUPyJXzynJEGygBirDKsVo0saw+2jjGKiNhvnodFiT06mMqad1oYbFottbQlRJk9gDWsFR0d3ZV/VkRlvnicAOvkiXk2GE6yAGlB6+P1TLJSFxl8rD8mSeMa10tdypOcu9zXLusvIl6osETD2Rol/znlTUnoJWHLUDm3B4PDjIdsvxZ3wyKElqciTYfHOTJRH3vDDaACE8nTt1ccvLW7oPDnqTHKiswpOz8wQDx5BCsesA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu7RYOYUT7ZvuwWWjZLt5SHjd1hMIBqQ7OkfsG17fWw=;
 b=ROhFHWDa7ygA6zsEiRR2kowdyEMAtokKkXh73/Ve8DTRgsbY2qqUN88M/cFhWVA8s0p8YRg+Dlko+WpC+Id71IezdqV5XxqsJghGzRGAhctOZvuFJhdleQOew+03wzi/jugbc5ew59y4ocnBvGwXmNb0WeU0mTj1dI1UWQVpV4PmqB/H8AcTDcrjudnsZZk7PTeRKwm0n3keENJbnWxj1ubC54OzbN75392V63+1LJk8gdzGN1oA9yFCGnnm82Qqt32OM6XYG2fIVbG3+WVeehX0jdtqvR6GiJbxx5zFk3umh64z9O6PH3bP61nBXgziR8F44+2JZbcg8OOUyEVxuQ==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by SA2PR02MB7561.namprd02.prod.outlook.com (2603:10b6:806:140::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 14:49:26 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e%7]) with mapi id 15.20.6609.022; Fri, 21 Jul 2023
 14:49:26 +0000
From: Het Gala <het.gala@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Prerna Saxena <prerna.saxena@nutanix.com>, "quintela@redhat.com"
 <quintela@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, Manish Mishra
 <manish.mishra@nutanix.com>, Aravind Retnakaran
 <aravind.retnakaran@nutanix.com>, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v9 03/10] migration: convert socket backend to accept
 MigrateAddress
Thread-Topic: [PATCH v9 03/10] migration: convert socket backend to accept
 MigrateAddress
Thread-Index: Adm74otwXZ11rOI+JUiscwI+vxTRZw==
Date: Fri, 21 Jul 2023 14:49:26 +0000
Message-ID: <20230721144914.170991-4-het.gala@nutanix.com>
References: <20230721144914.170991-1-het.gala@nutanix.com>
In-Reply-To: <20230721144914.170991-1-het.gala@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PH0P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::17) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB4343:EE_|SA2PR02MB7561:EE_
x-ms-office365-filtering-correlation-id: fc5cd793-bacc-4e0b-c07c-08db89f9adf6
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r6eo9cKCwV55kckO2q9SR9VegOlrq3PNgSq08cghPjUFg9AQ3cNDWXoCfaEK2mkQaa5RG2NUCiWmILZ8nglk9O+kKJOfvAd2dlFxYjxm+hjkqFk9oS4iLipdYDwk4WmzMR2HjcleJbbQI8XlU33mAGdmaqAsn1gEGV4qb7Y/8hvJ+2YBEsztzJpR/x5Iz1nKQP2Sj8CCQ+HAT3xqI8UmtKNGi15dTZ4I+gUKGhnX7U8ypEEAwElizj+6qiTnCI3a8wNuv6hQATnXo8jxAwGhxYaEzIVBOFYmmq/hmWdKg4OX7AhFuStbISFPfLCBw0KLJ1FYNorjQWRWbK8ZNGWtRGxeFU2oSGR4W2rtUX38RVmmTqOwKMQQoIj7e4YOj9g69noEfIxqRq6ViYycqIBDMwuUFgHU2waNHwRm8nTN728FE5SymOEYey1acHkz3gy1nj/V3yYdjUe/UZbCvRC04TcMTfwgoM3vL/OgbKxE/vjJC9EVOODYFeYfn3gB17ceQCCU+8a4hdHRbixoVZ/GIZdl4eJQ/OXYSjb70PrMFmli5JTIwk8XE6bCDsZ0Sveq9ghICdHA3dHECHVJi0XH1240xTguX+kNRDeeTHXgH/NAud8o2YEYKuzLqDX7wSUY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199021)(2616005)(6486002)(52116002)(6512007)(71200400001)(478600001)(86362001)(26005)(1076003)(107886003)(6506007)(36756003)(5660300002)(4326008)(44832011)(6916009)(41300700001)(8936002)(8676002)(316002)(2906002)(122000001)(38100700002)(54906003)(64756008)(66476007)(66556008)(66446008)(66946007)(38350700002)(186003)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGFHRTFvMDJrZ1dUb2hYVjBoM3RwRFM2Sm9wLzNmRldaeDVMYU5NSG5ZQWxM?=
 =?utf-8?B?ai90MFVTMzV3K2tnVEtDVXJuRWplK2FIT2cyd0t5dWlzNXRxaHorNHF6dHZL?=
 =?utf-8?B?ZnFjTnUyS1VFREJzNGtDRzNhMG1lTWlZTVdIc3ZnTmEvQjcraS9PTVJDVmFl?=
 =?utf-8?B?QkVFaVlhc21jOXRqa1k3emFNQldTU21qT25Dam5CeUdTNUY3cC9GSHJSNlhP?=
 =?utf-8?B?RUF6a0V1M0tMUkh1SXZaeGc3L01tUlU3bU9DOUhLdTlpV2NOYzM0OTIwQlFV?=
 =?utf-8?B?ckR5WVhMZzczcnZwNzBsdDZiT25EN3JvRmVVdVo3azNoNHo5bXNYTE80dVg4?=
 =?utf-8?B?SER6ZGNMZFJYdUhZMG5UZEdGeG1kV0pqbkpqM3pRNEh4OWZON2R3WW8zdzkw?=
 =?utf-8?B?aXg3bGM2a0NoTVQzRlpmY05XYklvSnVJalJxK1JST25oanhoZkJtMzZ0azJV?=
 =?utf-8?B?TUtXYURoZ2RSMW9HMC9yaHBOWjFLVitJQlora0hvd0pUMkZsbWorb0JKZ1hp?=
 =?utf-8?B?UThvR1N3d3F2UUdXbFVEL2hsVVhQRnhQTDRmSzEvMGZ4WFpSNFRJS3FmOC92?=
 =?utf-8?B?cnNjaFRPUFdlQTN2SGxUTHB6TURpT003SDVIV3d6anpNYnZ2SVlVZDkwVXIx?=
 =?utf-8?B?ajU1RHloeFFJMElCbVNPQ3NUMkw0ZjdCRjVoTURvTDBkUmYwVzdRbUxwSDlU?=
 =?utf-8?B?U0luV2dBSmdTVUFkb1lDdGtPaExzMkt4WUpNeUpjb1cvS1hhQlBZcXdSbUFr?=
 =?utf-8?B?dUVYa284R3hoVFJJaGp0VWM2OUtrY3NET0pFdGU1NFU0U2xCT2pLdythaEdZ?=
 =?utf-8?B?S0JlSUUwZjVXbFNjY016OGhsTld0MDlqTHhycjZIRXRsYnFHeGxnZFBnaTZv?=
 =?utf-8?B?UldKTzRicU9LRGUyTnJyNUV2WWRLVi8wUy9zcGN4QlpaL1BzalNzRUZ6TktF?=
 =?utf-8?B?ajZ1ZFdPa3lFYmZJNnI0Sm5xUDFiS0tCZ0c2TUxyZ2gxOGVFYjBEOHJLN1kv?=
 =?utf-8?B?cUNVY1dwMkgvL3ZlaVF3OWdMQ2FRS3NlVjNUZUcxR0xPZnNhaEpodndtUzNh?=
 =?utf-8?B?bTZ3UkMzZ3BhMURzb2NtVzRKQnViZnc5VVJaRnprNXRISUtWbWkzaCtBZ20z?=
 =?utf-8?B?VjFhUjhEWXE5QmhHd2RkKzB0RlFZQmlpeWVqSnpybGt2WlllVmtObVRlL0pt?=
 =?utf-8?B?ZW9hemljUlozU3hrS1dSdUZpcHZ3azF4WWpadjR3NDBwWi9peThBNU1LWUFX?=
 =?utf-8?B?NDdZdnFRbytRclh3UlF0UXRQWXloUXNSK3pMdEdzQkZzZlBpUWdFWkFRRWNv?=
 =?utf-8?B?bSt1WGpzYWt0REJDeGEyMGRkZHh3RFQreDE4TEpCZTBGZWV3Z3c4cnQwVHlV?=
 =?utf-8?B?end3Zk55WVlVWUpUbi8vQVJDejBKQTRrVE9vZ2FSdCtReDN4d3diRGJhQnNE?=
 =?utf-8?B?dEVpV24rY3JIa0tLS01YQ1o1OU8yZTZ1VDVKMjRsVnBSaE85d3ZweGNJMnE0?=
 =?utf-8?B?allwR1BuaFRpWnhwbFJSL0FWQmxOZkhZVnU2cjhUT3hkZklSSmRQU2N2NzBv?=
 =?utf-8?B?T0M3K3BGM3h4b0dGOS9xRDJkMmM1MkpVUEh2UWoyc01NcytERXV1M1VaSGxO?=
 =?utf-8?B?bklVZUIrV2RwZ0tqaC91K3A2MUZFOWF6bGpXaTR3NEpuUU90TmNiRlIxNW5J?=
 =?utf-8?B?ZEtPQ2U3Z3ovRUczdVZtTkw0VkRQdUFaUHl3T0tnL3hYRVAyakpjZXNLR3I2?=
 =?utf-8?B?YWRRQ1dJYy9ab2Z1VGIzSXVzeGpyWTB6dlJmRk90VXdiZTJibzFkTnZUSHlz?=
 =?utf-8?B?Ym1zT211VzZITkM1bVdBbEJ3NDVQVHhHb0pVRFNxN1JjYzdjR09jdUFjYlB0?=
 =?utf-8?B?bG5XVXc5K21WZ1RIRG5ibThZOHV3WUM2U3lFL3F4VnRORTg1ei8yakdpN3c5?=
 =?utf-8?B?eDdwUTZmM1NEeGdVNEtnOGhZamR6cFZmazBVcE5WVFpacGQxbVkxU2tGTm5x?=
 =?utf-8?B?SE9WZEFUK3padyszenZRSW56NWJXMGp4bCtOZ0lOWDBidFBRS3kvWjJ3YnNU?=
 =?utf-8?B?Mko2S203WElueHNYc3F0clNsTkNzK1F4TG45RXZIcGFNMGhFS21vbmdUNkxt?=
 =?utf-8?B?REloOWFPOFdYWk1mQzNaVkhiT0tZNlZCTFVYL09wY25CUGRua1FWazdBdlpx?=
 =?utf-8?B?SWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61B72B5CAAA5FB44B75FE0B491C6851B@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5cd793-bacc-4e0b-c07c-08db89f9adf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 14:49:26.0922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y3iggOamZPegcXVBi1mIdJKFrXi8Zjg+drEAlvZkC+EV6Yj3Brd3rZ1Ocu85NOAOOv1aXasgIpWBHwmBh7yM3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7561
X-Proofpoint-GUID: 8deqt2Oi2SriADX8o2GrnWFpkZqAtU6O
X-Proofpoint-ORIG-GUID: 8deqt2Oi2SriADX8o2GrnWFpkZqAtU6O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_09,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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

U29ja2V0IHRyYW5zcG9ydCBiYWNrZW5kIGZvciAnbWlncmF0ZScvJ21pZ3JhdGUtaW5jb21pbmcn
IFFBUElzIGFjY2VwdA0KbmV3IHdpcmUgcHJvdG9jb2wgb2YgTWlncmF0ZUFkZHJlc3Mgc3RydWN0
Lg0KDQpJdCBpcyBhY2hpdmVkIGJ5IHBhcnNpbmcgJ3VyaScgc3RyaW5nIGFuZCBzdG9yaW5nIG1p
Z3JhdGlvbiBwYXJhbWV0ZXJzDQpyZXF1aXJlZCBmb3Igc29ja2V0IGNvbm5lY3Rpb24gaW50byB3
ZWxsIGRlZmluZWQgU29ja2V0QWRkcmVzcyBzdHJ1Y3QuDQoNClN1Z2dlc3RlZC1ieTogQXJhdmlu
ZCBSZXRuYWthcmFuIDxhcmF2aW5kLnJldG5ha2FyYW5AbnV0YW5peC5jb20+DQpTaWduZWQtb2Zm
LWJ5OiBIZXQgR2FsYSA8aGV0LmdhbGFAbnV0YW5peC5jb20+DQpSZXZpZXdlZC1ieTogRGFuaWVs
IFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4NCi0tLQ0KIG1pZ3JhdGlvbi9taWdy
YXRpb24uYyB8IDMwICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KIG1pZ3JhdGlvbi9z
b2NrZXQuYyAgICB8IDM5ICsrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
IG1pZ3JhdGlvbi9zb2NrZXQuaCAgICB8ICA3ICsrKystLS0NCiAzIGZpbGVzIGNoYW5nZWQsIDMx
IGluc2VydGlvbnMoKyksIDQ1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvbWlncmF0aW9u
L21pZ3JhdGlvbi5jIGIvbWlncmF0aW9uL21pZ3JhdGlvbi5jDQppbmRleCA1YjNiZTc2N2YwLi5j
NGJjZjhiYmQ3IDEwMDY0NA0KLS0tIGEvbWlncmF0aW9uL21pZ3JhdGlvbi5jDQorKysgYi9taWdy
YXRpb24vbWlncmF0aW9uLmMNCkBAIC00ODEsMTggKzQ4MSwyMSBAQCBzdGF0aWMgdm9pZCBxZW11
X3N0YXJ0X2luY29taW5nX21pZ3JhdGlvbihjb25zdCBjaGFyICp1cmksIEVycm9yICoqZXJycCkN
CiAgICAgfQ0KIA0KICAgICBxYXBpX2V2ZW50X3NlbmRfbWlncmF0aW9uKE1JR1JBVElPTl9TVEFU
VVNfU0VUVVApOw0KLSAgICBpZiAoc3Ryc3RhcnQodXJpLCAidGNwOiIsICZwKSB8fA0KLSAgICAg
ICAgc3Ryc3RhcnQodXJpLCAidW5peDoiLCBOVUxMKSB8fA0KLSAgICAgICAgc3Ryc3RhcnQodXJp
LCAidnNvY2s6IiwgTlVMTCkpIHsNCi0gICAgICAgIHNvY2tldF9zdGFydF9pbmNvbWluZ19taWdy
YXRpb24ocCA/IHAgOiB1cmksIGVycnApOw0KKyAgICBpZiAoY2hhbm5lbC0+dHJhbnNwb3J0ID09
IE1JR1JBVElPTl9BRERSRVNTX1RZUEVfU09DS0VUKSB7DQorICAgICAgICBTb2NrZXRBZGRyZXNz
ICpzYWRkciA9ICZjaGFubmVsLT51LnNvY2tldDsNCisgICAgICAgIGlmIChzYWRkci0+dHlwZSA9
PSBTT0NLRVRfQUREUkVTU19UWVBFX0lORVQgfHwNCisgICAgICAgICAgICBzYWRkci0+dHlwZSA9
PSBTT0NLRVRfQUREUkVTU19UWVBFX1VOSVggfHwNCisgICAgICAgICAgICBzYWRkci0+dHlwZSA9
PSBTT0NLRVRfQUREUkVTU19UWVBFX1ZTT0NLKSB7DQorICAgICAgICAgICAgc29ja2V0X3N0YXJ0
X2luY29taW5nX21pZ3JhdGlvbihzYWRkciwgZXJycCk7DQorICAgICAgICB9IGVsc2UgaWYgKHNh
ZGRyLT50eXBlID09IFNPQ0tFVF9BRERSRVNTX1RZUEVfRkQpIHsNCisgICAgICAgICAgICBmZF9z
dGFydF9pbmNvbWluZ19taWdyYXRpb24oc2FkZHItPnUuZmQuc3RyLCBlcnJwKTsNCisgICAgICAg
IH0NCiAjaWZkZWYgQ09ORklHX1JETUENCiAgICAgfSBlbHNlIGlmIChzdHJzdGFydCh1cmksICJy
ZG1hOiIsICZwKSkgew0KICAgICAgICAgcmRtYV9zdGFydF9pbmNvbWluZ19taWdyYXRpb24ocCwg
ZXJycCk7DQogI2VuZGlmDQogICAgIH0gZWxzZSBpZiAoc3Ryc3RhcnQodXJpLCAiZXhlYzoiLCAm
cCkpIHsNCiAgICAgICAgIGV4ZWNfc3RhcnRfaW5jb21pbmdfbWlncmF0aW9uKHAsIGVycnApOw0K
LSAgICB9IGVsc2UgaWYgKHN0cnN0YXJ0KHVyaSwgImZkOiIsICZwKSkgew0KLSAgICAgICAgZmRf
c3RhcnRfaW5jb21pbmdfbWlncmF0aW9uKHAsIGVycnApOw0KICAgICB9IGVsc2Ugew0KICAgICAg
ICAgZXJyb3Jfc2V0ZyhlcnJwLCAidW5rbm93biBtaWdyYXRpb24gcHJvdG9jb2w6ICVzIiwgdXJp
KTsNCiAgICAgfQ0KQEAgLTE3MTUsMTggKzE3MTgsMjEgQEAgdm9pZCBxbXBfbWlncmF0ZShjb25z
dCBjaGFyICp1cmksIGJvb2wgaGFzX2JsaywgYm9vbCBibGssDQogICAgICAgICB9DQogICAgIH0N
CiANCi0gICAgaWYgKHN0cnN0YXJ0KHVyaSwgInRjcDoiLCAmcCkgfHwNCi0gICAgICAgIHN0cnN0
YXJ0KHVyaSwgInVuaXg6IiwgTlVMTCkgfHwNCi0gICAgICAgIHN0cnN0YXJ0KHVyaSwgInZzb2Nr
OiIsIE5VTEwpKSB7DQotICAgICAgICBzb2NrZXRfc3RhcnRfb3V0Z29pbmdfbWlncmF0aW9uKHMs
IHAgPyBwIDogdXJpLCAmbG9jYWxfZXJyKTsNCisgICAgaWYgKGNoYW5uZWwtPnRyYW5zcG9ydCA9
PSBNSUdSQVRJT05fQUREUkVTU19UWVBFX1NPQ0tFVCkgew0KKyAgICAgICAgU29ja2V0QWRkcmVz
cyAqc2FkZHIgPSAmY2hhbm5lbC0+dS5zb2NrZXQ7DQorICAgICAgICBpZiAoc2FkZHItPnR5cGUg
PT0gU09DS0VUX0FERFJFU1NfVFlQRV9JTkVUIHx8DQorICAgICAgICAgICAgc2FkZHItPnR5cGUg
PT0gU09DS0VUX0FERFJFU1NfVFlQRV9VTklYIHx8DQorICAgICAgICAgICAgc2FkZHItPnR5cGUg
PT0gU09DS0VUX0FERFJFU1NfVFlQRV9WU09DSykgew0KKyAgICAgICAgICAgIHNvY2tldF9zdGFy
dF9vdXRnb2luZ19taWdyYXRpb24ocywgc2FkZHIsICZsb2NhbF9lcnIpOw0KKyAgICAgICAgfSBl
bHNlIGlmIChzYWRkci0+dHlwZSA9PSBTT0NLRVRfQUREUkVTU19UWVBFX0ZEKSB7DQorICAgICAg
ICAgICAgZmRfc3RhcnRfb3V0Z29pbmdfbWlncmF0aW9uKHMsIHNhZGRyLT51LmZkLnN0ciwgJmxv
Y2FsX2Vycik7DQorICAgICAgICB9DQogI2lmZGVmIENPTkZJR19SRE1BDQogICAgIH0gZWxzZSBp
ZiAoc3Ryc3RhcnQodXJpLCAicmRtYToiLCAmcCkpIHsNCiAgICAgICAgIHJkbWFfc3RhcnRfb3V0
Z29pbmdfbWlncmF0aW9uKHMsIHAsICZsb2NhbF9lcnIpOw0KICNlbmRpZg0KICAgICB9IGVsc2Ug
aWYgKHN0cnN0YXJ0KHVyaSwgImV4ZWM6IiwgJnApKSB7DQogICAgICAgICBleGVjX3N0YXJ0X291
dGdvaW5nX21pZ3JhdGlvbihzLCBwLCAmbG9jYWxfZXJyKTsNCi0gICAgfSBlbHNlIGlmIChzdHJz
dGFydCh1cmksICJmZDoiLCAmcCkpIHsNCi0gICAgICAgIGZkX3N0YXJ0X291dGdvaW5nX21pZ3Jh
dGlvbihzLCBwLCAmbG9jYWxfZXJyKTsNCiAgICAgfSBlbHNlIHsNCiAgICAgICAgIGlmICghcmVz
dW1lX3JlcXVlc3RlZCkgew0KICAgICAgICAgICAgIHlhbmtfdW5yZWdpc3Rlcl9pbnN0YW5jZShN
SUdSQVRJT05fWUFOS19JTlNUQU5DRSk7DQpkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL3NvY2tldC5j
IGIvbWlncmF0aW9uL3NvY2tldC5jDQppbmRleCAxYjZmNWJhZWZiLi45OGUzZWExNTE0IDEwMDY0
NA0KLS0tIGEvbWlncmF0aW9uL3NvY2tldC5jDQorKysgYi9taWdyYXRpb24vc29ja2V0LmMNCkBA
IC0yOCw2ICsyOCw4IEBADQogI2luY2x1ZGUgInRyYWNlLmgiDQogI2luY2x1ZGUgInBvc3Rjb3B5
LXJhbS5oIg0KICNpbmNsdWRlICJvcHRpb25zLmgiDQorI2luY2x1ZGUgInFhcGkvY2xvbmUtdmlz
aXRvci5oIg0KKyNpbmNsdWRlICJxYXBpL3FhcGktdmlzaXQtc29ja2V0cy5oIg0KIA0KIHN0cnVj
dCBTb2NrZXRPdXRnb2luZ0FyZ3Mgew0KICAgICBTb2NrZXRBZGRyZXNzICpzYWRkcjsNCkBAIC0x
MDgsMTkgKzExMCwxOSBAQCBvdXQ6DQogICAgIG9iamVjdF91bnJlZihPQkpFQ1Qoc2lvYykpOw0K
IH0NCiANCi1zdGF0aWMgdm9pZA0KLXNvY2tldF9zdGFydF9vdXRnb2luZ19taWdyYXRpb25faW50
ZXJuYWwoTWlncmF0aW9uU3RhdGUgKnMsDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBTb2NrZXRBZGRyZXNzICpzYWRkciwNCi0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCit2b2lkIHNvY2tldF9zdGFydF9vdXRn
b2luZ19taWdyYXRpb24oTWlncmF0aW9uU3RhdGUgKnMsDQorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFNvY2tldEFkZHJlc3MgKnNhZGRyLA0KKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQogew0KICAgICBRSU9DaGFubmVsU29j
a2V0ICpzaW9jID0gcWlvX2NoYW5uZWxfc29ja2V0X25ldygpOw0KICAgICBzdHJ1Y3QgU29ja2V0
Q29ubmVjdERhdGEgKmRhdGEgPSBnX25ldzAoc3RydWN0IFNvY2tldENvbm5lY3REYXRhLCAxKTsN
CisgICAgU29ja2V0QWRkcmVzcyAqYWRkciA9IFFBUElfQ0xPTkUoU29ja2V0QWRkcmVzcywgc2Fk
ZHIpOw0KIA0KICAgICBkYXRhLT5zID0gczsNCiANCiAgICAgLyogaW4gY2FzZSBwcmV2aW91cyBt
aWdyYXRpb24gbGVha2VkIGl0ICovDQogICAgIHFhcGlfZnJlZV9Tb2NrZXRBZGRyZXNzKG91dGdv
aW5nX2FyZ3Muc2FkZHIpOw0KLSAgICBvdXRnb2luZ19hcmdzLnNhZGRyID0gc2FkZHI7DQorICAg
IG91dGdvaW5nX2FyZ3Muc2FkZHIgPSBhZGRyOw0KIA0KICAgICBpZiAoc2FkZHItPnR5cGUgPT0g
U09DS0VUX0FERFJFU1NfVFlQRV9JTkVUKSB7DQogICAgICAgICBkYXRhLT5ob3N0bmFtZSA9IGdf
c3RyZHVwKHNhZGRyLT51LmluZXQuaG9zdCk7DQpAQCAtMTM1LDE4ICsxMzcsNiBAQCBzb2NrZXRf
c3RhcnRfb3V0Z29pbmdfbWlncmF0aW9uX2ludGVybmFsKE1pZ3JhdGlvblN0YXRlICpzLA0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMKTsNCiB9DQogDQotdm9pZCBz
b2NrZXRfc3RhcnRfb3V0Z29pbmdfbWlncmF0aW9uKE1pZ3JhdGlvblN0YXRlICpzLA0KLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpzdHIsDQotICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCi17DQotICAgIEVy
cm9yICplcnIgPSBOVUxMOw0KLSAgICBTb2NrZXRBZGRyZXNzICpzYWRkciA9IHNvY2tldF9wYXJz
ZShzdHIsICZlcnIpOw0KLSAgICBpZiAoIWVycikgew0KLSAgICAgICAgc29ja2V0X3N0YXJ0X291
dGdvaW5nX21pZ3JhdGlvbl9pbnRlcm5hbChzLCBzYWRkciwgJmVycik7DQotICAgIH0NCi0gICAg
ZXJyb3JfcHJvcGFnYXRlKGVycnAsIGVycik7DQotfQ0KLQ0KIHN0YXRpYyB2b2lkIHNvY2tldF9h
Y2NlcHRfaW5jb21pbmdfbWlncmF0aW9uKFFJT05ldExpc3RlbmVyICpsaXN0ZW5lciwNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBRSU9DaGFubmVsU29ja2V0
ICpjaW9jLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdw
b2ludGVyIG9wYXF1ZSkNCkBAIC0xNzIsOSArMTYyLDggQEAgc29ja2V0X2luY29taW5nX21pZ3Jh
dGlvbl9lbmQodm9pZCAqb3BhcXVlKQ0KICAgICBvYmplY3RfdW5yZWYoT0JKRUNUKGxpc3RlbmVy
KSk7DQogfQ0KIA0KLXN0YXRpYyB2b2lkDQotc29ja2V0X3N0YXJ0X2luY29taW5nX21pZ3JhdGlv
bl9pbnRlcm5hbChTb2NrZXRBZGRyZXNzICpzYWRkciwNCi0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCit2b2lkIHNvY2tldF9zdGFydF9pbmNv
bWluZ19taWdyYXRpb24oU29ja2V0QWRkcmVzcyAqc2FkZHIsDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCiB7DQogICAgIFFJT05ldExpc3RlbmVy
ICpsaXN0ZW5lciA9IHFpb19uZXRfbGlzdGVuZXJfbmV3KCk7DQogICAgIE1pZ3JhdGlvbkluY29t
aW5nU3RhdGUgKm1pcyA9IG1pZ3JhdGlvbl9pbmNvbWluZ19nZXRfY3VycmVudCgpOw0KQEAgLTIx
MywxMyArMjAyLDMgQEAgc29ja2V0X3N0YXJ0X2luY29taW5nX21pZ3JhdGlvbl9pbnRlcm5hbChT
b2NrZXRBZGRyZXNzICpzYWRkciwNCiAgICAgfQ0KIH0NCiANCi12b2lkIHNvY2tldF9zdGFydF9p
bmNvbWluZ19taWdyYXRpb24oY29uc3QgY2hhciAqc3RyLCBFcnJvciAqKmVycnApDQotew0KLSAg
ICBFcnJvciAqZXJyID0gTlVMTDsNCi0gICAgU29ja2V0QWRkcmVzcyAqc2FkZHIgPSBzb2NrZXRf
cGFyc2Uoc3RyLCAmZXJyKTsNCi0gICAgaWYgKCFlcnIpIHsNCi0gICAgICAgIHNvY2tldF9zdGFy
dF9pbmNvbWluZ19taWdyYXRpb25faW50ZXJuYWwoc2FkZHIsICZlcnIpOw0KLSAgICB9DQotICAg
IHFhcGlfZnJlZV9Tb2NrZXRBZGRyZXNzKHNhZGRyKTsNCi0gICAgZXJyb3JfcHJvcGFnYXRlKGVy
cnAsIGVycik7DQotfQ0KZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9zb2NrZXQuaCBiL21pZ3JhdGlv
bi9zb2NrZXQuaA0KaW5kZXggZGM1NGRmNGU2Yy4uNWU0YzMzYjhlYSAxMDA2NDQNCi0tLSBhL21p
Z3JhdGlvbi9zb2NrZXQuaA0KKysrIGIvbWlncmF0aW9uL3NvY2tldC5oDQpAQCAtMTksMTMgKzE5
LDE0IEBADQogDQogI2luY2x1ZGUgImlvL2NoYW5uZWwuaCINCiAjaW5jbHVkZSAiaW8vdGFzay5o
Ig0KKyNpbmNsdWRlICJxZW11L3NvY2tldHMuaCINCiANCiB2b2lkIHNvY2tldF9zZW5kX2NoYW5u
ZWxfY3JlYXRlKFFJT1Rhc2tGdW5jIGYsIHZvaWQgKmRhdGEpOw0KIFFJT0NoYW5uZWwgKnNvY2tl
dF9zZW5kX2NoYW5uZWxfY3JlYXRlX3N5bmMoRXJyb3IgKiplcnJwKTsNCiBpbnQgc29ja2V0X3Nl
bmRfY2hhbm5lbF9kZXN0cm95KFFJT0NoYW5uZWwgKnNlbmQpOw0KIA0KLXZvaWQgc29ja2V0X3N0
YXJ0X2luY29taW5nX21pZ3JhdGlvbihjb25zdCBjaGFyICpzdHIsIEVycm9yICoqZXJycCk7DQor
dm9pZCBzb2NrZXRfc3RhcnRfaW5jb21pbmdfbWlncmF0aW9uKFNvY2tldEFkZHJlc3MgKnNhZGRy
LCBFcnJvciAqKmVycnApOw0KIA0KLXZvaWQgc29ja2V0X3N0YXJ0X291dGdvaW5nX21pZ3JhdGlv
bihNaWdyYXRpb25TdGF0ZSAqcywgY29uc3QgY2hhciAqc3RyLA0KLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0KK3ZvaWQgc29ja2V0X3N0YXJ0X291
dGdvaW5nX21pZ3JhdGlvbihNaWdyYXRpb25TdGF0ZSAqcywNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgU29ja2V0QWRkcmVzcyAqc2FkZHIsIEVycm9yICoqZXJycCk7DQog
I2VuZGlmDQotLSANCjIuMjIuMw0KDQo=

