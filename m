Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C3A82E93B
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 06:47:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPcGo-00006j-LT; Tue, 16 Jan 2024 00:45:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rPcGm-00006W-Rd
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 00:45:52 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rPcGk-0002oS-Qt
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 00:45:52 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40G4u49q030861; Tue, 16 Jan 2024 05:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 qcppdkim1; bh=7swZ0a2UMC5Q1Gf8Rc4pQ7rsfC5WU+96T0Mvc7wiBck=; b=Ik
 Was3BunhErRpHXOZBOjsWeXVTUyfyrG1mEbXeLI9M2oHGESxP0maP+jcjH3hTwbP
 hOPdlLLjLX6nkDdVLxtuNFyS+uAudJtGy74cInay/rJUSv0gXXCbVYVxurOa7Qzo
 JU+EDCFKbPNvMt1PyDzso83xUUS8II8R98JuWnYuWqe3pXMY1uK7jqMKpcwZxYzc
 FNElOgF0CLNRuuRlwyUpM56uVDGNxBd6vV613Z+JjLoA1LQBOZd6R2ZVCKK5iHp5
 JbOHb3g/hhZi63CQjd3G38jEtIgL2k5/A+PwDQWmT2YHGU8ArVv1FvNXpg3Zvg0+
 s3MvOd8cDoQgIUKrVtBw==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vn75t9bys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 05:45:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QomqMthcpKf7KFb92Kuo/tiQ9aba+KcsTIFxday3KMOXJUvFgjHwwAxk88X96mzY1hWo1E1sl5AwY68uoeNxfPmTeX2OI6SunwGXGQHPCsyGj8SsucGY1aJqr+8CGEIQs/XoLCT8qJivQ2exakiV0GHdALv2baUOvzoEWexxJPnBAK8hjEhrxZdITF8N7Lc2Rx7K0UbIWoNqF/2ZtJTeb/dW9RLTmTeaSW5Fh/mAYMTmNjDx4S5H75WaKaoCvyLlWaciM9+TaXs8v9l1vzB0M8dHt9IlNJpW19j3foD+oH54zpVCPPW7pIrS6xFUIlx2KVfVFe6GGtAPxX2xnLPVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7swZ0a2UMC5Q1Gf8Rc4pQ7rsfC5WU+96T0Mvc7wiBck=;
 b=OITJuX60wysOaSgHhccdWIw8wLvjr0J2W5PTe/heKQw6G3s+HkrumxlEV3AT0G/40ynDopqDzXs2YcymVDMzLepqfMSH8mP8A2MYbmPcMs60lItt4XALqSAoZ9nwsYnLt3v+LGPDCQwBnpXX5Y0bOjT5z9omMPuxhXRUgwUCrVwi/JwZKF+pA5bA2iRMKRoPtQED0Zj/j8KElY8xgw00fnV8UulamFWAYoDVo5I+xKr41wBmU3GhQLmS/su5PWuIH88Dzwixs3Xxcsfc7JT2TqWxZCR+rTBMwA+OJnyaO7owpfQDbMkeRkjvy6ezt2quKdcfMWYfjnvtz8hy8sRmoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by BN0PR02MB7902.namprd02.prod.outlook.com (2603:10b6:408:161::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 05:45:41 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::dfab:83e2:41:20c8]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::dfab:83e2:41:20c8%5]) with mapi id 15.20.7181.015; Tue, 16 Jan 2024
 05:45:41 +0000
From: Brian Cain <bcain@quicinc.com>
To: Taylor Simpson <ltaylorsimpson@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>, Sid Manning
 <sidneym@quicinc.com>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "ale@rev.ng" <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: RE: [PATCH v2 0/3] Hexagon (target/hexagon) Use QEMU decodetree
Thread-Topic: [PATCH v2 0/3] Hexagon (target/hexagon) Use QEMU decodetree
Thread-Index: AQHaSABCcHZ2KzTmfk23O/hVEpUsirDb7jrA
Date: Tue, 16 Jan 2024 05:45:41 +0000
Message-ID: <SN6PR02MB4205E3F6F03AECDDD36875B1B8732@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20240115221443.365287-1-ltaylorsimpson@gmail.com>
In-Reply-To: <20240115221443.365287-1-ltaylorsimpson@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|BN0PR02MB7902:EE_
x-ms-office365-filtering-correlation-id: 578a1171-14ca-4b59-9fb3-08dc16566038
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NkI5FHjBYn7xsU4XtQJ0XZsyBcIX3dizEXGTlcniO46XHDnzbDaiqT5uB3TvhpqPMdWsANrl/ajST6hFGZEjtoE/Eb2B+lxMn3w1okUSOailaSER4+4/KHrh+MHLxOix0L49YaPieEuOnVXolcJrzNzBBCOOlzkZtJEHBo1BjkdRwFfxhXGOTBsLuqdbWsuTIAZ/O89U3M1ArXxlajm7EpyImsCh6qzehNRQ958z+afBJPa2nXf+wnYPhIy0B9/Vu3OCtcOYjW3oiIsJqgl4PNfqtJKNa7htywGYGtFStzBVl0Gis+lH1Y5h4y2Jc7ujkN7RDp1ikXvh3Ee/pCxGhz2TmrVTJZ6/jO3dxdlz+389ztWvJoWmtSeuhx3UHe7y8W6mvaQUpN8buI30U9tpZDfCR3zxd/uAcyd2OfimddWOp1fxS8J61WAz2b4uHBohfoBxrh+lWhEAjmy3H9IEA3kB7rJ/23HuW5wo6mvr0C6WdYtapZbo8AT5K+mkePyObOvPlV0eRzgZD502v6bhubrq941D3FXijGJb965S+i2FKPsdLdZZz5OD+G8kPwenjtyrDHgUZfGiDfGJY4STVGdXtx77goj5IXDc6B95SkG7luRQDLdldVm2/rOtEmkhbH74NdznSutnyxnLwxHFBw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(230173577357003)(230922051799003)(230273577357003)(1800799012)(186009)(451199024)(64100799003)(7696005)(966005)(6506007)(26005)(53546011)(38070700009)(9686003)(71200400001)(83380400001)(38100700002)(86362001)(41300700001)(122000001)(478600001)(33656002)(52536014)(8676002)(4326008)(8936002)(5660300002)(66946007)(66476007)(110136005)(76116006)(66556008)(55016003)(66446008)(2906002)(316002)(54906003)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUhnVUV2MGM4d3ExMVlvdHc0K3N4OXNjYmwxSzNya0YxK0YySWxRVnFYQlpF?=
 =?utf-8?B?b0NvcExOalJrdENCZVJsY0xxSHpIRnpMOHQxSFhPRHhUNHVHT2pDcDZEbk1v?=
 =?utf-8?B?TFV2ek1FTzA1UTR4NU9sUHUwWFdFWDh5STd6d3ZxalZpWXcyQXcvS1I4VkJm?=
 =?utf-8?B?VkdnOEU4Z2lzZUsyMFQweFVFZGp4azJTQnRoTUIxdXN6TzVUVjI5VWNPcDZ1?=
 =?utf-8?B?MDliamszSnhEYUFJc0M4d2czam5YaHVFN05yY1p1dDY1cGdSWVgvUDVBMGNJ?=
 =?utf-8?B?eFJMYWRGRFUvK0lDdlJXUWRGNVM5a3VtVGVVSEFJcmw3L0JDWVBieG41Q1c4?=
 =?utf-8?B?NFk3Y0dwQXpaYVNYZzNLQklaa0NQaVdBMmdIdFhpRTQzQmMzVWZ0eHBrVDN0?=
 =?utf-8?B?bkRTeVoyYzVueUdLU21XUFJvTVRwOXNnalpUWGJnQi9aT2N1azVDU0ErSjVF?=
 =?utf-8?B?MklHamhNWE9TWDlxUytLS3BqS0hlajlzTEVHZEJJWE9yKzloVFlSVXo3WEhZ?=
 =?utf-8?B?a3lPY0xLbHBLR3kwem5JVzFIdDZyQU1OSjBnY3VFWVhsRS9NZEE4Z3M4bXF5?=
 =?utf-8?B?THc4M01yRjB1aEhKZ2ZZY0RHNjJoMXZYZ083MTF4UlFIQVJtaEkxYktDUytw?=
 =?utf-8?B?dFNxVFNXTDRhUmRJRWFuS2JqVlJaRUlDU1Y4ZGhiS0VnVFEzN2ppRmxaVktp?=
 =?utf-8?B?aTJHeG94cHprRVMzWkZqMlR6Wmo2MndaK0JLU3R4TWJkVjZKNVJTc09DMmxO?=
 =?utf-8?B?ZFRma2kxMVY3cXN5c1JkWFdoZ1d2eEd5NmJ1ekNURUp2VDM0TGtQeUcxZUhl?=
 =?utf-8?B?a1hsWTdjWmFaRFAxWTZlS1Z4Rm5kcGxYVjV2dGI0Z3BENGJoY0xsQlpETHA2?=
 =?utf-8?B?ZjAyS2dhOWRwcWxkTjNzbWd1K25NTUp5dE9CeFFYUjJsRjhRN05wVU5udk9w?=
 =?utf-8?B?bnhFaHl2WVlCRmFHalBKRHZZM01qLzFCWU1zWGplTUIrbFpPRjhUR1VEQ0FK?=
 =?utf-8?B?ek1OdFlrRmR3cElqSVhIdE42QUgrc3EwUDE0OFVXM0V4UTkxQ2NVK253Y09J?=
 =?utf-8?B?dTJONnZOdlhXY2ZVZ2ZTZ0Jjdyt1MXNmakw5MEMvanpCYnU4RjN3WlBVb05S?=
 =?utf-8?B?THNTbEdwR0ZjaVZueExyNnZXVThYZXFGY2J0WWtJd3laNll3KzJLaUQ1d0sr?=
 =?utf-8?B?ZlRpWHM1STFKY0tMd2Jod2hOYmpnUkMvbkg3eDBpc0tEQWVKS3dJN0NyQ3F4?=
 =?utf-8?B?ZWFkTkVzUFVBdlJQeXZLbjV1cG5MNk1DdExBTXZabTVVYjFMZEZtY0JibkpI?=
 =?utf-8?B?OHJZQ2Nodk9lUzZUamtpcG5NTWFhQk5KaHlIVDcwS0VaQllLTlk0eWRRT1Fq?=
 =?utf-8?B?ak1tVkhQMmo2ckQrYkZmNGJHblZJWTZZcXhmRkZyNnVPS3RPME1naEJyMDR4?=
 =?utf-8?B?L2piVlBRMGRlOXBNajk1VU1OYzh2enNzdzA5YjU2d2Ywb1B5L2VSRjI1ZUFO?=
 =?utf-8?B?eFdSNXBtOUgxMzV0Y1dwY0FqSHE3KzQrSHlQcElrS3grWnpDaFhLVzhBWXJV?=
 =?utf-8?B?SU9UcUdTWEszelJoWGo4S0tRS0s2TEJwMi9YUUFHT3lGVWhGS3ArMjlESHhL?=
 =?utf-8?B?TXM5cFBaUHk2d0F5TE4zL2pFVS9tRmY1RkxXTThzaXpBMU1HdFB0QWFwYVNt?=
 =?utf-8?B?RG9oOUdBNndPbS9Fakp0dS9BZUM2K2dJcHJOcmlic0RMcTlIUXZ6b2xKb1dw?=
 =?utf-8?B?RU9zcmlqMVQ5Qmt0clhoMmJBbWxkMTdOR3FIKzFvYjBiYXhuMmZndHpwbVll?=
 =?utf-8?B?ak9sY2xhcWs2WXRhS0U4ajQxd3RhMWw0L2tDcURYaWN5QXFQeEp5QlY3WHQr?=
 =?utf-8?B?WlFQS3FyRGVYckxOamx4RTllQTZhZVZiRlNlcDJhSnd5cEoxMGlrbm5VbDYr?=
 =?utf-8?B?MENjSUZFMHcwZHR6TXlzMXF0d2pnZXdNNlBsdXRrQXdPdEFqY29pREd0RnpX?=
 =?utf-8?B?dTJQYjZkOVhJQ0w2Nzh1TVp0UDNTOXBQZitxdC9uUkN6bDc1MTlWS3pZQU9M?=
 =?utf-8?B?azgyMWZMcnI2SUF6a2MwbU9hOEd3ckhzKytrQnRUMkFRbjhxYTRvUll0OG5w?=
 =?utf-8?Q?FQYA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XEkpx5/H6C4OtJ49zv2DXTLKd85OP9jZI6+Y0y2C9ktdtc5Kbiupf0GGZb6FPaYLwzBtQePZ6/E9ECmLQBU3NbuoHSHvW/uW8W/Rv1A9YRKIPIryr8AjxPQ1f1mLrqYaDuHxdDpmYuiJ69eG79m8HzvqTfwvIJmIg2zXk4NMHw8f5eZavzhqOsc+Q3U+SjAvKmbSl1D/HcQy04qf/aZcC7rVFVm1kJj+h/Np0BlT0fzU0bGX/mK6iXx3GVO8KvUlPuE5EYHd/lH6JG5I9Xgi2C2OvfmK/Gxa//LLr1ndYdAS9W1Lv11fNRc76cyxLpUkIzSt8P7Ksvpk5xW66R5gQA0h/0/nl70kiUc8UTklgUxMs+3ibhuV9o3yAEGbiwxeV4wYe39z6OUrT6FUU+AzMBCe7z4n/44C2BRhkQZGAhfHKOYmEkWIjuzxU92BUK1QS/TIafkVgwlmHbMCF6IXIrR3lBfmXBWPrVSz9fZn2g/3ZB5GWOt2S4PMqTdh+Iw4Kr6i+ylrap4MVGq6Cb0bKyHKUewzkuJvQaZtZHfU0MiYMrT8Mu3ynz6M98KO/SGUynCOVAocs37z9zwy8pOOpi0x2GdNd+ScXybUMm6Eu1M5c6JQSvMvHmKo0Gzmgb7d
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 578a1171-14ca-4b59-9fb3-08dc16566038
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 05:45:41.6742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Qj5htByf3FLFR6O4tbmofQEkM52eix6EbAGzorl6hf82aOcFxcbCqMJvVTa+UHTKZOjl1O9SUXc/Uv19bgzdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7902
X-Proofpoint-GUID: 3yYuDwsbdZbtrWj3rh_BMqx6Hp7RCSGN
X-Proofpoint-ORIG-GUID: 3yYuDwsbdZbtrWj3rh_BMqx6Hp7RCSGN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=358 lowpriorityscore=0 malwarescore=0 mlxscore=0
 spamscore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401160042
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
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
PGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDE1LCAy
MDI0IDQ6MTUgUE0NCj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogQnJpYW4gQ2Fp
biA8YmNhaW5AcXVpY2luYy5jb20+OyBNYXRoZXVzIEJlcm5hcmRpbm8gKFFVSUMpDQo+IDxxdWlj
X21hdGhiZXJuQHF1aWNpbmMuY29tPjsgU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+
OyBNYXJjbw0KPiBMaWViZWwgKFFVSUMpIDxxdWljX21saWViZWxAcXVpY2luYy5jb20+OyByaWNo
YXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnOw0KPiBwaGlsbWRAbGluYXJvLm9yZzsgYWxlQHJldi5u
ZzsgYW5qb0ByZXYubmc7IGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBbUEFU
Q0ggdjIgMC8zXSBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgVXNlIFFFTVUgZGVjb2RldHJlZQ0K
PiANCj4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBRdWFs
Y29tbS4gUGxlYXNlIGJlIHdhcnkgb2YNCj4gYW55IGxpbmtzIG9yIGF0dGFjaG1lbnRzLCBhbmQg
ZG8gbm90IGVuYWJsZSBtYWNyb3MuDQo+IA0KPiBSZXBsYWNlIHRoZSBvbGQgSGV4YWdvbiBkZWN0
cmVlLnB5IHdpdGggUUVNVSBkZWNvZGV0cmVlDQo+IA0KPiAqKioqIENoYW5nZXMgaW4gdjIgKioq
Kg0KPiBTdWdnZXN0ZWQgUHl0aG9uIGltcHJvdmVtZW50cyBmcm9tIEJyaWFuIENhaW4gPGJjYWlu
QHF1aWNpbmMuY29tPg0KPiANCj4gDQo+IFRheWxvciBTaW1wc29uICgzKToNCj4gICBIZXhhZ29u
ICh0YXJnZXQvaGV4YWdvbikgVXNlIFFFTVUgZGVjb2RldHJlZSAoMzItYml0IGluc3RydWN0aW9u
cykNCj4gICBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgVXNlIFFFTVUgZGVjb2RldHJlZSAoMTYt
Yml0IGluc3RydWN0aW9ucykNCj4gICBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgUmVtb3ZlIG9s
ZCBkZWN0cmVlLnB5DQo+IA0KPiAgdGFyZ2V0L2hleGFnb24vZGVjb2RlLmggICAgICAgICAgICAg
fCAgIDUgKy0NCj4gIHRhcmdldC9oZXhhZ29uL29wY29kZXMuaCAgICAgICAgICAgIHwgICAyIC0N
Cj4gIHRhcmdldC9oZXhhZ29uL2RlY29kZS5jICAgICAgICAgICAgIHwgNDM1ICsrKysrKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gIHRhcmdldC9oZXhhZ29uL2dlbl9kZWN0cmVlX2ltcG9ydC5j
IHwgIDQ5IC0tLS0NCj4gIHRhcmdldC9oZXhhZ29uL29wY29kZXMuYyAgICAgICAgICAgIHwgIDI5
IC0tDQo+ICB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyAgICAgICAgICB8ICAgNCArLQ0KPiAg
dGFyZ2V0L2hleGFnb24vUkVBRE1FICAgICAgICAgICAgICAgfCAgMTQgKy0NCj4gIHRhcmdldC9o
ZXhhZ29uL2RlY3RyZWUucHkgICAgICAgICAgIHwgNDAzIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+ICB0YXJnZXQvaGV4YWdvbi9nZW5fZGVjb2RldHJlZS5weSAgICB8IDE5OCArKysrKysr
KysrKysrDQo+ICB0YXJnZXQvaGV4YWdvbi9nZW5fdHJhbnNfZnVuY3MucHkgICB8IDEyNCArKysr
KysrKw0KPiAgdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgfCAxNDcgKysrKysr
KysrLQ0KPiAgMTEgZmlsZXMgY2hhbmdlZCwgNTg2IGluc2VydGlvbnMoKyksIDgyNCBkZWxldGlv
bnMoLSkNCj4gIGRlbGV0ZSBtb2RlIDEwMDc1NSB0YXJnZXQvaGV4YWdvbi9kZWN0cmVlLnB5DQo+
ICBjcmVhdGUgbW9kZSAxMDA3NTUgdGFyZ2V0L2hleGFnb24vZ2VuX2RlY29kZXRyZWUucHkNCj4g
IGNyZWF0ZSBtb2RlIDEwMDc1NSB0YXJnZXQvaGV4YWdvbi9nZW5fdHJhbnNfZnVuY3MucHkNCj4g
DQo+IC0tDQo+IDIuMzQuMQ0KDQoNClF1ZXVlZCAtIGh0dHBzOi8vZ2l0aHViLmNvbS9xdWljL3Fl
bXUvdHJlZS9oZXgubmV4dA0KDQoNCg==

