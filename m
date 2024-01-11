Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3070482B66A
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 22:10:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO2IW-0004kn-2O; Thu, 11 Jan 2024 16:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rO2IP-0004h4-Qx
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 16:09:02 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1rO2IN-0001wt-Fp
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 16:09:01 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40BKa7Sv006285; Thu, 11 Jan 2024 21:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 qcppdkim1; bh=zDLQe8zDUuvvMb1FM5e0cFlZCGrthb3IGZtHeukCdMM=; b=hV
 6A99zF9S2E5nuzglYaljGGW92Lv4GbxhazXO+/QxYhL0sSGtgqYfLK1LKep7Pawa
 otOj6mwDCo9gE+QL5EIDQfGZM/rlnwvzbsRJjICMEeah1KX7Z3VkWH3qcD8urXA7
 e85ZwxZWqAyei06tB3uHObTLFF/st4FlwLTgh6wwzc27ENvDWJtTmeYe3yoigVQu
 5q7c/vXH37eQ/zQGnomUM5/Xj8W05SddoihLLTHkeVNpB45hEGrGETYLavNzgCjx
 D+gIu00nb6ezXq/NLyETnqAmqYa5s6UIFlgvlLlhy0IFNSaSlSDC0urAkFHfLjPm
 Bt173Pd71VSJ9z/nc+3w==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vj7w22h46-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jan 2024 21:08:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMAwJOWXxrLIYtquad8w6VWCDqlJhUgTALlfSuETFXvgcgy9vArze0DdMgjzvOeAJtpAYuiNkHN14Flk+qPvpkutCJzUVbOzPJmpByU2M05vPVRLZDoO7qqzpQDGn0biBM2fHKTeu/NXzPE5nsspqV+35MCGsC14I3cZVouDKAY1deYg49q/zT2/wuR9+Qfedl5gszbwJBhP9LsuC679Ft/1TXLjQtY4Gmrvf1uzovkPQZLujouoCOz8WsEH6Qso/toE1zl6Ac8TI8T7SgbKS7nEZRwdlmedPhLHtkvpt5xtl+0EcH8eIhcy/5JL5RhTS6TG/au0iDGwiFiazj0BLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDLQe8zDUuvvMb1FM5e0cFlZCGrthb3IGZtHeukCdMM=;
 b=bMcGTn487z9vbPPXrIk7TOyA5HX5XbBLSR0+d4l3SbzfHiJyfRql/TBZeWa6Rxnu/4nTq2sQmtQyIgEStcE9oNLXEuCdg/fDV+wCJvOuEAnM7G65XTEI/IgqeMFbBLFlo+21Y8pHcRpu0qROpKVhJxULe+GU+2eWHLSlSVrVnNVkyEPatb3lzEHgAiiegmoE81BGAajMCFvYJpTm6zhXenlUytY5QA892OybEjYtDXlnbyjf1/NgRjdVIp4F5TJUiwWIlKZ22JNojHwkIN1tYeKeLnt0dqvaeFi55qQ9fpvN6BYu8uornQY+y4pOTcCde/OEJUwY4NMK/r7nrpNXJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by PH0PR02MB7800.namprd02.prod.outlook.com (2603:10b6:510:53::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 21:08:54 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::dfab:83e2:41:20c8]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::dfab:83e2:41:20c8%5]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 21:08:54 +0000
From: Brian Cain <bcain@quicinc.com>
To: Taylor Simpson <ltaylorsimpson@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>, Sid Manning
 <sidneym@quicinc.com>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "ale@rev.ng" <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: RE: [PATCH v2 5/9] Hexagon (target/hexagon) Make generators object
 oriented - gen_idef_parser_funcs
Thread-Topic: [PATCH v2 5/9] Hexagon (target/hexagon) Make generators object
 oriented - gen_idef_parser_funcs
Thread-Index: AQHaK7VDzzh9Iux0XECYjrYLsIFVFrDVTVHA
Date: Thu, 11 Jan 2024 21:08:53 +0000
Message-ID: <SN6PR02MB420561BEDDEF433CF279B900B8682@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20231210220712.491494-1-ltaylorsimpson@gmail.com>
 <20231210220712.491494-6-ltaylorsimpson@gmail.com>
In-Reply-To: <20231210220712.491494-6-ltaylorsimpson@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|PH0PR02MB7800:EE_
x-ms-office365-filtering-correlation-id: ee08cab7-1297-4409-cf0d-08dc12e98484
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0rNeUliOG+obgkyOz6Ts6PSWt91B1iT0/CxxlxS+PJBP16PFOmeD7BmEWljESQOHXDc2M8vySyoqbthpYXesXuWLAptbH2XvTqUj4IEwO8Q8iuXgvTXkRwXLtL+5RVYm+wHljTxZChahhipTe27ZiADw5VI6KSZbj2mMFTRhgHir13VQ5iAg7cVMerk6vUalpGD5pBWw1CMPdl5CXETNoWkthRFmLyhd6mvcTONEfXOg95ckeMJtOnZ/z5ouCFf/S5dobND4GLF+BnuOQyYLPkfk/D/zE2k2farxt7CFzH0xfb+MupD+9G8XF/aYmLoCXAEgSo2oZNv5uhkKRw9LAiH/E4uUY7XtXMQqTypiWxQhv2aM3KepuEz2xooh4mLoSYGCyTv3ML6Vj2Wfy2pGlc/EePrwv8S9Vt3C4Q1bHd5J8BzJmPFXCYcB0U/cB9xn6LpMIZWThv9RUZwliu3AFkxMu8lTUEHEThGDCNhn3eC9fya+pC2C9ZMy8mk8i/UPgToDI0xuzVVrY1DDpE1/XDyrG5p3L3UIBClcMFDt5Sj3cfFOadfk3QkYJTgdRKsXxG9uMbevg1PqVpXyPcFXGXAyJRvlEGhVQlSJPMR2yjef1oXqD6Iqbpz4/mjbK7eggYCM98r+zsKFtsKBCF0YlRNNRQaNFQmtX4J5tm30ZmA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(39860400002)(366004)(136003)(346002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(55016003)(7696005)(71200400001)(53546011)(9686003)(122000001)(38070700009)(86362001)(33656002)(5660300002)(478600001)(26005)(6506007)(83380400001)(8676002)(52536014)(8936002)(4326008)(38100700002)(76116006)(2906002)(110136005)(66946007)(41300700001)(316002)(54906003)(64756008)(66556008)(66476007)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVFWOTJ5ZjZiNnQ1U25kQUhSRGREZGhQcXZoZFdHMFdzdlU4MW1adGNhdWtS?=
 =?utf-8?B?K1IxV25qRDBsVlVra1piekRxanVkdjhYaGVwZDN4K25IdkdRVWxxZFNOZXVJ?=
 =?utf-8?B?cjVMWEdzS0Vkb1ZWRFVlU25NVDR2L0hHUUo5ZC9PZS9QVDBnWVlDenlpOUFm?=
 =?utf-8?B?bk5icHBucGQwUXlWZ1pwVXFDcW5rMnRzeUJHWjVmbVEzRWVwQXd5OGxBYSs0?=
 =?utf-8?B?TzJ4V0VRd1FJbE1xWmI0RmwyUFlodFc3OUNDMkJGVjdINmhrUG9mWXZiV3Js?=
 =?utf-8?B?WXJqc2xQa1c4RGV5eHJVWnlXZXp0M2ZEUGtoczV2ZG1FdmlLOEJTWWFZYXB5?=
 =?utf-8?B?VHY5QXNubXV2ZnFraFRJS0NoRXQvV0tjTHBJTklVald0blloNUN0MjNLK3VE?=
 =?utf-8?B?QUNxYUhObGs5WDZwOFhVSFNxUHNTbGFmdzVVYXVGcHcydlN6QzhtMnQzcHBT?=
 =?utf-8?B?MC9VdXY3enIrTnFLSHlIdlB0TEdGWE5tc0tYZVNRSHRNbXNYcU5BQXgxamkv?=
 =?utf-8?B?czVObWJsU3V2TU1oTjlENkM1eXA4K2pKQTNwRm5VaGNPUEpySlZDRjg2UlVB?=
 =?utf-8?B?V1VQUWQwbW1MSS9CWXlESlJTRE8xNEl3Y3NNcVFUZEU4blhyV0h2R1N6NHcz?=
 =?utf-8?B?Y1VoRkF4N01pcHhsNTJKekdaVGJZeTBBQnBPRVp0Ykx2Q1YwR1lJbHJaa0Q2?=
 =?utf-8?B?OU9DcFUvM0IwSzdXWitnaXZHNHZmL0hwQ1hmTWZyZUpkWWFXdWMzakNHZU5L?=
 =?utf-8?B?WDdha0ltUVhYTmRySk9QS1NJTHMvbnNEVm5rYm9Ea0hBb1J1M00yWkp6MkIw?=
 =?utf-8?B?eVFhdStXYzR3Q254UnpjZVNXYkJkOHpZbUxtd1RwbFVrN1p5aEZnREJXTmRv?=
 =?utf-8?B?MkF1emNtYS9qN1ZDUVFlY3ZzY2t2WXB2UGpob1hwS2hzZzZBWUlnUWRCWlNQ?=
 =?utf-8?B?VXJHNWpTSFFSWmpHUnExN3NpOUtrVUdzd3Y2L1JFdHpsUzRhMDB6TzFvQTZq?=
 =?utf-8?B?K1hMcDUxbTVGOUdnNTNjUlJLZFJkck01ejR3YkVKVjMwYkpDMGNHZXRBUkFl?=
 =?utf-8?B?dWVVaHBPS2d5QVNzK1IxQlBnK3J2bjh2QnV6YjRmM3JMR1ZXL29GbVBMTVli?=
 =?utf-8?B?RG9ibS9kSUxQeWs3M0RsdURLU1M1UXVmbks1YzJhVlVFSmp2WHp2UTQ5L2Y0?=
 =?utf-8?B?OUF3SlN4TlQ1dXRRWHRwYiswV1hRQ0dlZkFzN1lPaDIrbGNoYkpCMHJicTZ5?=
 =?utf-8?B?K1JMVDRZc2s0Q2s4NUdoZzBBcEx2Ky9kSkFLNm5nVnJPMW80ZGRGZE5YS3k3?=
 =?utf-8?B?Nmw4Wnl6ajdIUkxGQWcxcXJkbDJkeEhIVUpzczdHV1F0Z3BUWHBsMzJubGt0?=
 =?utf-8?B?TzFDRjdrb09BaHgvM0MwOVM4Q0VXQ215UEVIbTl2SW1uU2Ixd1N5MlA3VzBL?=
 =?utf-8?B?SEZhM1lGT2t3SUlZRnNSejdzVVI5OStYTUFWQWxBNmpNVVJIRW9uVWJPQ0VQ?=
 =?utf-8?B?aEZkYStFQnZuMTdvSStnb3R0akhmTGVYSkkvTmc5WFBBYkRoaWx1WTl6MVRS?=
 =?utf-8?B?aUhaaUplOW84Qk9JVkVBYjd2dEtyTGRvSWd6b2xjV2RteGpqcW1kZHJEMm4z?=
 =?utf-8?B?bnVWYlp0QTFiNUhzcHZZa1BKeTh3aVRaV0FIVGtxRENtWWhNdmVyUXJiSWM5?=
 =?utf-8?B?ZFRTcUJEU0ZBQkFlR2M0ZC9EcWNCR3l4bmpLdFNKSGdSc1VTVEd0alltT2lx?=
 =?utf-8?B?dEZxMjlxV0FMSjE3Y2NyZHdhV29kdHV3RExLRjgxVWdsd0RRQkJmbFc5QVB0?=
 =?utf-8?B?bHR3TFJVcGgwT0xDbWppcmFPdytFSUZYUEhUZG1ORmMxU3dhVDJaNU5nb2hN?=
 =?utf-8?B?WFl4ZmU4SlFEVDAzM3pFUFFXbFFjZDRTeHh3UDZqT01vQ1pVbEQ2cTFBY0hD?=
 =?utf-8?B?YXVpYUNqbXB4YWhzMFBoS3Bodnd6N1VDRWlxWnNTUUMxd0NHdVM2bjdWUCtP?=
 =?utf-8?B?Y0RlM2kvUjRRTnhiZUQwcExkYkhqeFUzMGd5WGYwU3Z1TkdBRXdCN0EvRW1N?=
 =?utf-8?B?eThoU1VZb0kyemhUYmlyaXA1eHZ5cURRTkNPSzBTeG1PTFZtQklYd2FKa3hL?=
 =?utf-8?Q?5yJc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bhZy10g52FJZx+9CdCUCE+gKuoQDby6NXcpisxib4a6u2Lq3Am8fA2j5QurS+2ZWGqAgiI499IgFeEK08g03W4VGu4ZQaEMvoylWrhOi1h2hSKa9CHbpFClOEWqaafOmTbkDRx4wQOu6DcV+8sUWDV0Pzgwzo5xWRPQByfacobLiJTNZCXGZIyObb8oPJ1twQxmB8rlOW7mS7+rC/0KJoL9SdAAwibloC5q2MLTLAfmrU2wtvSWExXYBw20PalT3l8f3Yqb2iQcKWGdCNvYEhHMCIrscthLOXK1luVuw51Hyn1+tTKFwqgh8OMkuAhr3pWGKfrr3lAJ0XOCddznWU8xf9dJGO/u9NqxoJJnLQcYzqPrCZel59oSpQIXDRQL12cwpsmy2u/bJUgAO46+FQPkgVz52ahVoj+AAsOMaaz2xSS8qiwkRf4SvLueXkKwDtpixmbTlqOOgaVa/drRULvx3f2yaJMHneWF3wnVt5dTDDX+OpYqe1qKbOxxBlsYQJkdzzNeZgdOEbzrqWqMzv+v/WbRtYTyfL8FDHGhqWlopdNqmKRHhOwEiFZF0rprqdr+o2dknhW6Stp3iOzNxCdrIgMkLLa/h+YX477q8kWb7X5SP1y4kooHkzVx98bJu
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee08cab7-1297-4409-cf0d-08dc12e98484
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 21:08:53.9447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cMftEjjTelSt2M8WduF1NOdOlZtHbfbgVsgUdDvZrHBczDb5+7v70A+OiTawMowDUE5s3fhcJNZ4Lr1blQUPig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7800
X-Proofpoint-GUID: RE-pPShopQO-8nzRqx_z3eHOm3VmysLS
X-Proofpoint-ORIG-GUID: RE-pPShopQO-8nzRqx_z3eHOm3VmysLS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 mlxlogscore=536 adultscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110163
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
VENIIHYyIDUvOV0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIE1ha2UgZ2VuZXJhdG9ycyBvYmpl
Y3QNCj4gb3JpZW50ZWQgLSBnZW5faWRlZl9wYXJzZXJfZnVuY3MNCj4gDQo+IFdBUk5JTkc6IFRo
aXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3
YXJ5IG9mDQo+IGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFj
cm9zLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29u
QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICB0YXJnZXQvaGV4YWdvbi9nZW5faWRlZl9wYXJzZXJfZnVu
Y3MucHkgfCAyMCArKysrLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vZ2VuX2lkZWZfcGFyc2VyX2Z1bmNzLnB5DQo+IGIvdGFyZ2V0L2hleGFnb24vZ2VuX2lk
ZWZfcGFyc2VyX2Z1bmNzLnB5DQo+IGluZGV4IGY0NTE4ZTY1M2YuLjU1MGE0OGNiN2IgMTAwNjQ0
DQo+IC0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl9pZGVmX3BhcnNlcl9mdW5jcy5weQ0KPiArKysg
Yi90YXJnZXQvaGV4YWdvbi9nZW5faWRlZl9wYXJzZXJfZnVuY3MucHkNCj4gQEAgLTQ2LDYgKzQ2
LDcgQEAgZGVmIG1haW4oKToNCj4gICAgICBoZXhfY29tbW9uLnJlYWRfc2VtYW50aWNzX2ZpbGUo
c3lzLmFyZ3ZbMV0pDQo+ICAgICAgaGV4X2NvbW1vbi5yZWFkX2F0dHJpYnNfZmlsZShzeXMuYXJn
dlsyXSkNCj4gICAgICBoZXhfY29tbW9uLmNhbGN1bGF0ZV9hdHRyaWJzKCkNCj4gKyAgICBoZXhf
Y29tbW9uLmluaXRfcmVnaXN0ZXJzKCkNCj4gICAgICB0YWdyZWdzID0gaGV4X2NvbW1vbi5nZXRf
dGFncmVncygpDQo+ICAgICAgdGFnaW1tcyA9IGhleF9jb21tb24uZ2V0X3RhZ2ltbXMoKQ0KPiAN
Cj4gQEAgLTEzMiwyMiArMTMzLDkgQEAgZGVmIG1haW4oKToNCj4gDQo+ICAgICAgICAgICAgICBh
cmd1bWVudHMgPSBbXQ0KPiAgICAgICAgICAgICAgZm9yIHJlZ3R5cGUsIHJlZ2lkIGluIHJlZ3M6
DQo+IC0gICAgICAgICAgICAgICAgcHJlZml4ID0gImluICIgaWYgaGV4X2NvbW1vbi5pc19yZWFk
KHJlZ2lkKSBlbHNlICIiDQo+IC0NCj4gLSAgICAgICAgICAgICAgICBpc19wYWlyID0gaGV4X2Nv
bW1vbi5pc19wYWlyKHJlZ2lkKQ0KPiAtICAgICAgICAgICAgICAgIGlzX3NpbmdsZV9vbGQgPSBo
ZXhfY29tbW9uLmlzX3NpbmdsZShyZWdpZCkgYW5kDQo+IGhleF9jb21tb24uaXNfb2xkX3ZhbCgN
Cj4gLSAgICAgICAgICAgICAgICAgICAgcmVndHlwZSwgcmVnaWQsIHRhZw0KPiAtICAgICAgICAg
ICAgICAgICkNCj4gLSAgICAgICAgICAgICAgICBpc19zaW5nbGVfbmV3ID0gaGV4X2NvbW1vbi5p
c19zaW5nbGUocmVnaWQpIGFuZA0KPiBoZXhfY29tbW9uLmlzX25ld192YWwoDQo+IC0gICAgICAg
ICAgICAgICAgICAgIHJlZ3R5cGUsIHJlZ2lkLCB0YWcNCj4gLSAgICAgICAgICAgICAgICApDQo+
IC0NCj4gLSAgICAgICAgICAgICAgICBpZiBpc19wYWlyIG9yIGlzX3NpbmdsZV9vbGQ6DQo+IC0g
ICAgICAgICAgICAgICAgICAgIGFyZ3VtZW50cy5hcHBlbmQoZiJ7cHJlZml4fXtyZWd0eXBlfXty
ZWdpZH1WIikNCj4gLSAgICAgICAgICAgICAgICBlbGlmIGlzX3NpbmdsZV9uZXc6DQo+IC0gICAg
ICAgICAgICAgICAgICAgIGFyZ3VtZW50cy5hcHBlbmQoZiJ7cHJlZml4fXtyZWd0eXBlfXtyZWdp
ZH1OIikNCj4gLSAgICAgICAgICAgICAgICBlbHNlOg0KPiAtICAgICAgICAgICAgICAgICAgICBo
ZXhfY29tbW9uLmJhZF9yZWdpc3RlcihyZWd0eXBlLCByZWdpZCkNCj4gKyAgICAgICAgICAgICAg
ICByZWcgPSBoZXhfY29tbW9uLmdldF9yZWdpc3Rlcih0YWcsIHJlZ3R5cGUsIHJlZ2lkKQ0KPiAr
ICAgICAgICAgICAgICAgIHByZWZpeCA9ICJpbiAiIGlmIHJlZy5pc19yZWFkKCkgZWxzZSAiIg0K
PiArICAgICAgICAgICAgICAgIGFyZ3VtZW50cy5hcHBlbmQoZiJ7cHJlZml4fXtyZWcucmVnX3Rj
ZygpfSIpDQo+IA0KPiAgICAgICAgICAgICAgZm9yIGltbWxldHQsIGJpdHMsIGltbXNoaWZ0IGlu
IGltbXM6DQo+ICAgICAgICAgICAgICAgICAgYXJndW1lbnRzLmFwcGVuZChoZXhfY29tbW9uLmlt
bV9uYW1lKGltbWxldHQpKQ0KPiAtLQ0KPiAyLjM0LjENCg0KUmV2aWV3ZWQtYnk6IEJyaWFuIENh
aW4gPGJjYWluQHF1aWNpbmMuY29tPg0K

