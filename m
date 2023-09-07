Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9B57972F1
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 16:02:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeFZT-0006C8-OR; Thu, 07 Sep 2023 10:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qeFZR-0006Bm-OJ
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 10:01:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qeFZF-00067o-Cs
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 10:01:21 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 387DReX4025800; Thu, 7 Sep 2023 14:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=NZZBHq+yzOF9jYPT/aDdDdYSat/OsLy7KE3+Rgcwtt0=;
 b=lxBAELHIT6O0O3IXh3SKFHPhN3Hjs7FRMsvZcd2f036IE5GgbEnZLeE32bvIoYr5ZkiA
 VjO79P3lYbczR12MzGbAEDedebQb41HIXMnhEBtCri1s3yamSCq6PXJB4vtsUm6RplAt
 iWMwp1NO3NgcaG1RFAzZMmmx3aJ8WByUXM8ux993725fw9NBPU9Xz6zjHyxse/5RykxM
 I61iV0UzfKPx5dx/uqpt1UOb6vHnwAeDcrZ7JbDMFy/igWJBwmd4kkklWN35YOEDh5TB
 pi+xWbghRlmVCP/4KKOCyPbmI2xgA0RpK+4tvEiAn82CfESv21pgqbaeYjzPgzyYEPw2 vw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3syeqj890x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Sep 2023 14:00:56 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 387E0nns017875; Thu, 7 Sep 2023 14:00:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3suug87wfc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Sep 2023 14:00:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7hudU37BvGMqCqBGkj1aIET49+Qoz71/WdhzUDeom4Nl+lhuu25vbH6gW3bXwrU7hu8Ytu8nM2CH0D7Xg9Fd0AARKBU2eG7GwwZlb9tgUvvOeQxfWIxlgqLNOTGMcJ1gKzzFmakcvghNtpcwTBkysHaIj+VMwi4aFujdne2wuDUCUjXPvlg4uF6p1fi+cOx7LCAJBd7Fl5agOcmh6EpAfFnjIM+QKkN56TOpzg5eaQVU0eIf2RvYhZmXlr3llRYrLfW+D72UUZlprk1a9NZtONAQxkxChbD3x2aze88iRHkeWLlx0gWrxPFhcV+xkTccJwBlpuhVtAPFJ/NRPacIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZZBHq+yzOF9jYPT/aDdDdYSat/OsLy7KE3+Rgcwtt0=;
 b=Ne0oZx+thFjz0xb2AsIGHlipQ1o8TWSJYlBHfOvi3cHe5knYxc3DhabB7jr2Cfm9IYtlnnehQf1eSKCwy3VZt/9uZUcbREWIVHG+td3ruHg/Wm99VN3Ogk+0a1KA92+kh1sylk+XdFi+14v76qfN2RkG96S/h5nn9bbXm3MDxHM1u5pLIqvyIEAQohSUcSUvuOp32AGZB9DjIc6femgM3x7X8HeJCo+T4tESUwbCmfURqw3z7Utvroeiv78cMqsXlzUdk7jTzry/4siDXUBVXjMfcDxdCYOoHsQ8Gh07NOopKcB+GDKsBAB2EkyK8AHZaK8qqLYPnDe+d46KdDmKwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZZBHq+yzOF9jYPT/aDdDdYSat/OsLy7KE3+Rgcwtt0=;
 b=IiuoJr3IhQ4gNx2E+XOlF7GLQJSqrDX+ixMAulF67qHtmdOU5IEDVE1/66RUigbkbcSGnfHBkEvc2eUsoWolxL3/jMsBpYIULVjmHl67sYNSXi/DxfA0bzVm4gN/D6D2CwXiW0/tg+r1lhk9BTmcvDhRFZmW5ej6CikRvEe4UtE=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by IA0PR10MB7208.namprd10.prod.outlook.com (2603:10b6:208:404::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 14:00:34 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::a3a4:998b:966b:41ac]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::a3a4:998b:966b:41ac%3]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 14:00:34 +0000
Message-ID: <81389375-3ed7-48c1-f8d1-4eeb67a3a8e0@oracle.com>
Date: Thu, 7 Sep 2023 16:00:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/3] i386: Explicitly ignore unsupported BUS_MCEERR_AO
 MCE on AMD guest
Content-Language: en-US, fr
To: "Gupta, Pankaj" <pankaj.gupta@amd.com>, John Allen <john.allen@amd.com>,
 qemu-devel@nongnu.org
Cc: yazen.ghannam@amd.com, michael.roth@amd.com, babu.moger@amd.com,
 joao.m.martins@oracle.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
References: <20230906205308.50334-1-john.allen@amd.com>
 <20230906205308.50334-3-john.allen@amd.com>
 <6efe4fc0-3c9a-dc91-4a04-498b38c66374@amd.com>
From: William Roche <william.roche@oracle.com>
In-Reply-To: <6efe4fc0-3c9a-dc91-4a04-498b38c66374@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0003.eurprd03.prod.outlook.com
 (2603:10a6:208:14::16) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|IA0PR10MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e411689-713f-467e-eaae-08dbafaace73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SfsWwTKe6oFWtPEiSm64MegcP8bmXhulYWypNO2lr5bi3bhuBzVdGGz/Kq5t3i/hfbH/g+CO1/+IYbFgRXoB1CHh5HR+TQdoau2W1xQ9Xb/m/xLj/ZMg43cNZsVhosOPlrGBM/EJA6NbtM4ufS/e2HK/Yj6ceJ9+J5qqPKCvHW/aAmYuY9lZoBwiiSXTO2OVWl7/bmrElo8Vryj6VwcNRiCbnY/yruA0jB1hMj7NT20FH7dHI5VbYJCdBrAqBchpCYWbHIwDBdnXTXOrGLv0gjvXeFbePBUVAb+csVDFbiMW2xToiywLDBAvgUs5Xfh50zA5PquX32riRqHJU/GhiPR9jwltvBffNnSVqwAXUjdmiDfAc7rPzPyZh50l25MLyx0rh8+lPlUnBR9HAqQMmiyoAxko+BHA+ruUlpvQTWlPlsE6vDNpO0gxtWdh+H7oOXTptLI0JJO4DBSkcC9nXenHvd02TT/6VaHRMIbYx5nvQByOfu3UwfbDguR5HTgpgutkX6sfLcjjWmwm0M37csjIIva1rwnynnRcI4NtR2rNI9Kszy9ql/P4gwNXK65wS7Y+cxZLFEq0f/Zl0kSPViZTVz5upC9OSr36lVJim6ShTZGfgmnMGVRhUUxoKwUKqsO20M+FYnSmQADqE3nSELZuStx97AcsSPBMdb27gqs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(1800799009)(451199024)(186009)(66556008)(26005)(2906002)(83380400001)(6512007)(2616005)(66476007)(66946007)(4326008)(110136005)(316002)(8676002)(6506007)(8936002)(44832011)(478600001)(5660300002)(6486002)(53546011)(6666004)(38100700002)(41300700001)(36756003)(86362001)(31696002)(31686004)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzBVTzhYWmUxenVZcUNpWng5L2FKWVNSV1FrMzFCTytoais4bkl5bC9MOEpQ?=
 =?utf-8?B?c2E5TXN5RmtwWFpMRVNQb2NvYkRCaStrRE84bFJFaUN2L1pRTlM4WFltc2JG?=
 =?utf-8?B?QVpYa05oQ1pETFRXNTVLWjliK3J2bW9kTUdET1NocTVvNUUwRWJEVDJoMHE2?=
 =?utf-8?B?WHJad05MOHB1ckIwZG0rTkdiZzRxbEVCOGgvcU9naE41cnpNYnlGMG91SVRx?=
 =?utf-8?B?SUpuYk40dU56UjVIbTRXZ21rOVNqYzRaa2pySXd6bno2UGZQK3JQS1VyMUJL?=
 =?utf-8?B?WE5hOUROcFRhcm5pM0F5N1JJQkxlNlB5eTVreWhkdEN2ZXhDZ2JtUGdCK1o1?=
 =?utf-8?B?Q3dSbWRRclp3Z0hBck9QR2JLZ2x5OGhqS3pTQUFxOWozZTZtY1lCVDZibGo3?=
 =?utf-8?B?UWtQeVMyV2U2RUt2WUxFSm1XZkNxMC9FcE5wNUZMU0RGR3A3NnRDMVVSRUlE?=
 =?utf-8?B?NDZVNzBwUnNWL0pYY3E3blNxNjNkVEVvL0xqc1czeUc5YjVmUjFkUmxqWVkx?=
 =?utf-8?B?T2lsdUVCaVdrNjJuTGJLTGZNU2Z0MU5zeTB2Wnl3OXdSSnhUUGxBYTAxc0JE?=
 =?utf-8?B?Tnc3V0RPYnZieDIxaVFuS0hmWS9MYzQrQVdseUoyZVQyMWc1QmFzd3dlTTBB?=
 =?utf-8?B?UXlpYXdGak1wb1FlQWpzUzZtOGhLdUJ0cnV2MG9SaFJ5WWpWTm9CS0MreTY3?=
 =?utf-8?B?MU9XK2Y1VnVVaUVWTCtuelNvMUwrQkI0aUdGd3o2K3RjWnNUc1VBZlN4RDhQ?=
 =?utf-8?B?V01nYUpJcUVnUnR4SDhTM0xjRGRvZUcwOVFzMDdlbFZtenpLTDIwbWsyaEYv?=
 =?utf-8?B?ZkZVY1FCZzl1RTdwMU9OQ0hzRXJUWFhyeXAyVVNKYUN3UkhOK2FzRXZiNEpZ?=
 =?utf-8?B?L1cxYzh4VGZKUU5WUFVzUTl2WUZpQW11Ri9JY1VsVFZnaGNmNG55Y3dmRGtZ?=
 =?utf-8?B?dVJCLzNsdVNTTFJIYTlucUZvblFnVWg0ejBwRmhpc1pKZWdwWUNYZ0lIaU1s?=
 =?utf-8?B?SGhXMjNQOEhPSnRpRjQyS25vNmpsaDJWbTRvNEt5YVE4NFhZNEZHYnZ0eFI4?=
 =?utf-8?B?ODl4alRUWEZQOE1UbDNHcHVmR1FVbCtvNkxHdmVOcW9ZazZQdVVvQzYzNS9s?=
 =?utf-8?B?aTZaWVRCOEZCQnpsUm5PaS9KemV2cHkyU2JHL3NKSWZZL09SVTNEQlA5Z0xv?=
 =?utf-8?B?Rm9NcmpiK0xrdlVWSW1yQjhDVWVqWStTWEFRUGVQWUlFVzRsb1JhTXJXa0NM?=
 =?utf-8?B?YWhZVkkxcWpYSGs3ZjFsc2pURnZpVTB6aGhweGpIMDduTHVJMUxhMU5URHF4?=
 =?utf-8?B?VHhNZURRYjVsNzd5cCtBVGpOcEhrNHVyYXBnSkxEbzlBL3RIT3lUaW5oRmZS?=
 =?utf-8?B?d2ZxUWkxU3EwN1FGVWhUMXJMSGE5VHB0MUN3S2tVYzhoMElmRFB4Z1ZPQTR3?=
 =?utf-8?B?QTZKR3huY1ZnQzlPK1A3K0tXOTd5QStVZFZUWFhKWFI2YlBTUTdMMzZ1MTNu?=
 =?utf-8?B?dVB1bjJIZ1liWWppbUNTSkhuRkVRK1M2elQ2NFY4QUpqVmxxVkRzZEx1aVVM?=
 =?utf-8?B?MzU0RGlnV1dzbTRvandJYndXTDZFdUYzdlRQcFR2Q2M1RHJ0UEJnSXVrWXRz?=
 =?utf-8?B?UHdZbGpkcnJSZkt4bFl5aWcyOHFnNHZ4RUtxZzVsdlBLQTlXSHVCNDNIUm5k?=
 =?utf-8?B?SDB5MHZsNWVMOEhqRm9vbi9TdTl0RXA0WVhESVRDK3JFcGczcW1GOXhVbHpt?=
 =?utf-8?B?citXeHc0RG80QjUra1Fxd0tqTFRNVmMrZ0VTdDFHMEdaNDFIYk93NFRpWkdx?=
 =?utf-8?B?Q0ZsZmQ0ZDB6ODBXdjZVdldUZ1hhVHBDdzlDUXUxdDBpNVg4Ly9UT1NCL2Fj?=
 =?utf-8?B?eGFhcitvSXo1SmNtbEp3ekY3VmhlcTlEUnZqS2taZkhWQXRPcHZRbjZ0Wms2?=
 =?utf-8?B?SWxuYVpMK1VQMjZjVElPalY0NThGRkhLMEVhTW94NTB3bDcwUFBabEpHRlZC?=
 =?utf-8?B?K1l2VFhjcVo4c3dQR2ZnUkRlYitQVHI5QTAzOWpuUm9aV3hvc1NodWNiTHBu?=
 =?utf-8?B?QXRxNnUzWkJLekF0UGJRdWxHbjFVcHVaZ2VqejRaNGJBa0w0cE9uaU9ubVVP?=
 =?utf-8?B?OVREU1pHVjZCZUdXYzJEVVdwY3gzQ3dsYkZSRWNwMnEvVUJpbERGTkJwU2FU?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7fgu5G7r4EYXx/qeTo7O2RvzYOQRnqBc3i4+0iidiwN8tHRic4+kybInbRG2LxApjcDLmeBFGonSvIgQTO1BeHq2Z+9w9fHZCcIwYjuM8w84fq7lLGOo0vjq/THkVb/1yMLSpvyUQgi8myij/T5q19sAzHv4VGKeKpDRzzVoLlsDnDsACkhKa3B5DD5q30A5WmUmtX2NebOkyMxLwZ7+jqO2I7f+1yjrtDaFqkpClaok6b+bSfLOBBeNILQ9tnwg2OrhC8UPwcTd9Z8iRp2N4FjMMmRT+0Mji0NcZdHkqNqTGugqqNn+7y2VYBXQlGVz9tHL63Bg+pBHZioJF8JCu/9r+3vTYFFfnNXHIw89hnrnfyCB2QIb0jPivdvJIi/UqfKXjd1ur7W7FUyQscl8jEiilEZcO+S9qaHs7kQbIWsIt1HET5ACHZUCmglhG7XychuIhxUmMY8SutFg5EA+JCKs4qVFHD7S6IOiVhP99a2/c95bHSVm3Ooy7COV456O+uLFDkstr5JkAG9QdVyAy1HWmas1qbxjr87NIxGGmBKTTLMXe3ruDVEFe82stwtQhQdd/ZRoBnqczu2/aMk/gID3skYxy8P1dx0zV7hjqITIOY9UiEt9VvKzmaPdI2dOxbP6SlFERMT0ywXAaPD/AilsfuGtVOtvHIqC36Tfp2ebfjGZew4IyTmYEkKCeAglE2IE6ROAfAL29gnG9HF6VCfYhqnynn9pxxO39X6rAdpIMufkZ5umf7VzvsfEK9QUf+GmNICk8eSk9bY6LiR9B06UC7Lcktl8JN+aEgNGK5UPJNMBn5jHMOkVwwfFFU7vUxphDdbi9TezZKW91mwe4wjPQYoTDtXDB6JMXpk8teU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e411689-713f-467e-eaae-08dbafaace73
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 14:00:34.7882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMEo3h34Z836glVa7uYtpJ56ksJ9aDkUXGfKa81bEAwOL5VMBSpHBsKn/GmP4VW1ZVoihrQrpvUp4f2T98/ViXA252Z1FABuSZR/2A2SEdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7208
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_07,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070124
X-Proofpoint-ORIG-GUID: qWFmuFgylR0cWCl0xzH9EhyWPZwSZdPZ
X-Proofpoint-GUID: qWFmuFgylR0cWCl0xzH9EhyWPZwSZdPZ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/7/23 13:12, Gupta, Pankaj wrote:
>
>>
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index 5fce74aac5..4d42d3ed4c 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -604,6 +604,10 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr 
>> paddr, int code)
>>               mcg_status |= MCG_STATUS_RIPV;
>>           }
>>       } else {
>> +        if (code == BUS_MCEERR_AO) {
>> +            /* XXX we don't support BUS_MCEERR_AO injection on AMD 
>> yet */
>> +            return;
>> +        }
>>           mcg_status |= MCG_STATUS_EIPV | MCG_STATUS_RIPV;
>>       }
>> @@ -655,7 +659,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int 
>> code, void *addr)
>>           if (ram_addr != RAM_ADDR_INVALID &&
>>               kvm_physical_memory_addr_from_host(c->kvm_state, addr, 
>> &paddr)) {
>>               kvm_hwpoison_page_add(ram_addr);
>> -            kvm_mce_inject(cpu, paddr, code);
>> +            if (!IS_AMD_CPU(env) || code != BUS_MCEERR_AO) {
> 
> Isn't the 'optional' case we already handle inside kvm_mce_inject()?
> So this check seems repetitive to me.

You are right, it is repetitive, but can be considered as a reminder of 
the situation and an explanation of the "ignored on AMD guest" message 
later in this function.

Of course it can be removed if you think that the code is easier to read 
without it. When the AMD BUS_MCEERR_AO support is integrated, both 
locations would need to be cleared, but this sounds reasonable to me.

John, it's up to you.

William.

