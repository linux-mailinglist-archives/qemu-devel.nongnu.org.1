Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9A681CE83
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:40:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGkQb-000803-KB; Fri, 22 Dec 2023 13:39:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1rGkQY-0007zb-4k
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:39:18 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1rGkQU-0000U9-Qn
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:39:17 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BMFSp2s026568; Fri, 22 Dec 2023 18:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=EQ6a2mdWytXHzAy6Nl0ZQlsa/GE/uotBm3Q4TxUvBY8=;
 b=Mv7u/c5vLNwLmcphhx9N1d9mHSQTLI3gs9ZOIUrASVQHefX7lE7uEMEnZhjNLhcOCira
 cU5na8LlNAapnqljKv1gOVNq/w+J1//fC9BtvDiU7Q6L8dzhGbRya4KCgFhkPNmkd+WD
 +7MpNaW4MYnkni78b/QExRWPGBdCqmytsCgzam7sDwIM2bwgy7xv92f8FystFN2wyND9
 4hYLlQY5CvrQLQR8G0N3dGu5Qt1IvhooYIxsoPEczDTsI1ilo/kidhozXNkG9l1ebuuG
 OnmfNEuVdglLpkDYfCzRlv63E7QSotNsAOcPTH8ZBzQHjEiXDLmDS3EFUTCaBY65gJVu bw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13gupa31-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Dec 2023 18:39:09 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3BMGgZsP031008; Fri, 22 Dec 2023 18:39:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3v12bmab4s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Dec 2023 18:39:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1foe0gObSuysLPUFsCGoIb0u4FLMd12C4aePckRVumnC8IFdVIBS5C6JGfxPBG09fbkh4BfoCk+K6Ns+oFA90ybRY1PlMNGTfInXHXLiBPB25UjNBCqZS5cPjYecEap4bA3knGnMwawpAsz+HrtxPFCgET6xBLpm2r5NlN14UNDdD24X0UIxKwYbOVCzXigKr7oTzJ7bmaZRtwq6ExGhRRFejAsWOKl0qqtGDFeY+E1fe4CSjsSPuY6P4WT5+aSbqSB9erJw/JJpu9ebMxP1nX4iAW93Ir9AW29qwsidRk4irfr+imXqJbKScJnGb+GHgpjLn0ZZyAqkwOGqzJqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQ6a2mdWytXHzAy6Nl0ZQlsa/GE/uotBm3Q4TxUvBY8=;
 b=HtmfJkUXaHoq77o7GAa3f/TUM+WMcxPoS62Kn7XQYy71tlvQf0y9wq3UnLgk7gLNJw7+b59RitR8jr/F4GJpkVoNREEVxNNDnBKNKupxfEPTwPwkiZACSitKZyt7RvWGxYETHrkYMLOoKoN81DPfr0ZIR7XsASgXubzb2TQ4rYVCsuyBXB4bk87Olmh84g2HDcW4gt3ue/0S7FuM4rQ6o67fah44BkmjlWl3bDbHXWXgXYJ1eEiYD8Zbk1znObIvT3baFpdFPWJZhszi5SRiz+MM2zQgtqFcFTSBIUBsp2s8EWeM9jjWGbWbo7SvVaseRn8xcGp/tq5CvSkHW3fg6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQ6a2mdWytXHzAy6Nl0ZQlsa/GE/uotBm3Q4TxUvBY8=;
 b=hVCxUenSVW1OTe+g3+/FIW0RmcG3jc8Nyy9FZyeGo1esCYm+vmFjWT7O5KD4qOOJfpC6GsttKD79IbOiTiFDzjaekqVuXxWUEfvtIvzagk0lUJWuhOWNuaW6jPQFJN6n4rAK3gHzJc8f47M7Flov/xHHrgE1Wa2HejCcfqzQG2Q=
Received: from DM6PR10MB2523.namprd10.prod.outlook.com (2603:10b6:5:b2::27) by
 DS0PR10MB6846.namprd10.prod.outlook.com (2603:10b6:8:11d::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.21; Fri, 22 Dec 2023 18:39:07 +0000
Received: from DM6PR10MB2523.namprd10.prod.outlook.com
 ([fe80::78e:ef0:dac6:d229]) by DM6PR10MB2523.namprd10.prod.outlook.com
 ([fe80::78e:ef0:dac6:d229%5]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 18:39:07 +0000
Message-ID: <8c9eb284-f293-fdbd-7cc6-286ac12c8b1f@oracle.com>
Date: Fri, 22 Dec 2023 13:39:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [RFC PATCH 01/11] acpi: hmp/qmp: Add hmp/qmp support for
 system_sleep
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, miguel.luis@oracle.com
References: <20231205002143.562-1-annie.li@oracle.com>
 <20231205002356.1239-1-annie.li@oracle.com> <87r0k075ij.fsf@pond.sub.org>
 <bc3d29ae-48ab-3d85-24e7-89f4f08f9c9f@oracle.com>
 <87h6kah0q7.fsf@pond.sub.org>
From: "Annie.li" <annie.li@oracle.com>
In-Reply-To: <87h6kah0q7.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::16) To DM6PR10MB2523.namprd10.prod.outlook.com
 (2603:10b6:5:b2::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB2523:EE_|DS0PR10MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: d2da0240-0ad5-48d1-1170-08dc031d4769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /09sxvquBMIQDHvMV8Tx4bi9usd7A7tMyuGMSEM2ttEndjuNCoyHa5AtsIkwzXqKad+w8nZ5mBOkAY2QIOyB21YN00zdGQzT4Jgu2ORbwFW/OsanaL5LtfNqg67Fg/eJNZ+apNTGNxhOD8O0XrzXwT11/Ks2tZfL01vShxuM6cEUW5K4zCuT+J1BEiVJACnBA8EnCKWc6+oXFBpcYL01fTWagSrb6/FkRzGACnj8pHVkCxYmRzjgd4cChbNmqoSSt61jYlExHLp2MKyMZCq3+DZ8jO05gBLCqiBLH8rhHiBMQeDeUlI5Ai/x9Um2nRYu4yEegwibZAtq/ygeWEKBCGceoNUM9qLTesMVo8Eyt+6h3ooAjZMf8lOmZja9wOi0iCznPWpI+l/YQGMW2vq/NfVTISmYT6hzevdpAgbXn9rqXXq1vrFzPUUz1Y1agcgexBQlbkALR2PG8hXTYnsYHt8uQNYJeZyjW7nV2Zxs/IxT392UL2jNWeWHv5JEnNLv6K7ibHjL/j/nXQGAa7MVKza6zRWT49EG8UJqDX/1GMz2QJ88lRwS7T1fb0pZgyTfkhzxf5UFVAPyECvBU8lQL5qeMKDmc8TkEc4yRY9mRAYg0Iey47V2HZq5BuTCsNn1j9vIsXNXdv58sIiI+UHeig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB2523.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6512007)(38100700002)(6486002)(478600001)(4326008)(53546011)(5660300002)(316002)(66556008)(66476007)(66946007)(8676002)(6916009)(8936002)(26005)(107886003)(2616005)(83380400001)(6666004)(31686004)(6506007)(41300700001)(86362001)(31696002)(36756003)(4744005)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1JCRWcycjF2dW12ZGNYSDdnZFRaeVVqS2JxZ09lem5QVFMwZERQa0s4M0lR?=
 =?utf-8?B?c0xDSFNMZWxwOTlESVMzT2EwWS96OEo2K2RqeVp6QWRzWmkreVFXT25QYmh4?=
 =?utf-8?B?VWt3aGpTSTBmMHMzUGQ4REE3YWJHUDBwcjcrVWh2MXkwak5UdkNxQ09DTkJ0?=
 =?utf-8?B?dTVxV29IT3dRcnhZMEw1TTVaTlczU1VsQkJYaG5CR1VQVzBIcXVEUWREWkN6?=
 =?utf-8?B?MzNUc21rc2RzTVIxa3Zrd3FiMlJJQVJ5OEJzUjRLVDIvNGc1YXZLZndJRXpC?=
 =?utf-8?B?dEVGYlNuVU1sYlQvN3JFVEIwcU1TTjQ1NDZMb2pQSnlCZ1VOd0xLUVRYUE1W?=
 =?utf-8?B?Y2NYcEkyQ3FxcmxlaGdKVVE2ZXNXS1RwU1NiMHZqKzZtQ252cXlVQ0FsQjNw?=
 =?utf-8?B?d3B6UFhpMVg2d0pnQjJUY0VXaThVZ0VCOVJDMUh4SFIzeHdPWnVOZWMyNWZU?=
 =?utf-8?B?Z0JydGZOQlE2Y2QwQXlQbHFUSGxheGtidVRiQWRxMGNuTzh6ODNpTnZtcUVj?=
 =?utf-8?B?dzNZM1dVMjhzOExLay9LNzdWK2hwWFEyb3NpNHFMa25GK2ZlWUJmMFBJalFM?=
 =?utf-8?B?WUcxNW5pY0w2SGluTXd4VWtRb3hnSzVEdlJYUittVnNicU5zMjBDTXZ0TUpH?=
 =?utf-8?B?NjNqVnpWZVQwcHV6Wmt2K1IwYmtwVW0vNmRtcEJ5V3NndTZDSzBFczFGeUZX?=
 =?utf-8?B?cjYwUmxPci9zeWJFazNnOVRSWHFMV09KR1p3dmNtRk5JUWQyZTlQQUs0M1dL?=
 =?utf-8?B?L20rUU5HNTdqY1VnaldndDRIbTFsQWJzR3ZrTXVnbWZrSyt3ZGxpa2MxM3lR?=
 =?utf-8?B?VXd0Y0dHZ2tuVjFCNVV0ZlNVOHZYdnpLMFgrRVoza0N4Y1R2NWlXM2hQVW9v?=
 =?utf-8?B?dUhodUp2WS9UMEVTWkpSWTNad1NneWYrOHJIeVRaMlVVQ2lrc3NzOGZLQmo4?=
 =?utf-8?B?Y2VMRGIrTU9GaGxpQXJhKzhubVlCK1dBSHVCL1U2SkZBeDlCRFlRR3Uxb0JB?=
 =?utf-8?B?S1RuTEFmU0ZQQWdaT3paKy9FMmtzWXp5OHFRaGFvamNGdUpST0p1S3JUeEta?=
 =?utf-8?B?MHJKb2dKZzdsR2tqMy9vRlNaUTFlM2VobjdRSkpRMkJvMDdJVlBvMElLNWJC?=
 =?utf-8?B?NFU4cHh5M09vbndYU2tSb3VzcE5nVDFscjVjMFdrMm5uaHc5R09RRHNsSEU2?=
 =?utf-8?B?MXk4OUhhSm1LZEduYzFCdU9qOFNUeFhRRklpcnNhNmdYQ25MMnhQbTJ3Tzh0?=
 =?utf-8?B?b1NMSTBnS1pKYTByNkxGUk5pZ2YrcTM4STRGOVZWT2RDRmlHZGEyN1o4YWpn?=
 =?utf-8?B?Z2lLZmtzM0hZQXBhZUZ3ZHM0MWlpdk92UkJWRVBsdUZPRXNNVHRhSWRxS2c3?=
 =?utf-8?B?bUxiRGZJd1UvcTI5dGxDVFJsY3FFNFZmNlNJbjRhMG5TL09XQmxYZkx3Nitp?=
 =?utf-8?B?eFAzcnVLaWNaZUlSVHBmRWE4SXpOeEltVVVrWkZ4cE5QdEVQaW91d3ZtNVBI?=
 =?utf-8?B?SzNmYWFMZGdIVjlnUnBTb2E4YlJHdEZwOTIvSlFLT3hsZHplcHdoREY3Y0R4?=
 =?utf-8?B?alltRE41NlJCS0lNQldsbGh3NVMvQ1hIeVJHbVZ3TU9rMjRVUlUrNDRDZXFE?=
 =?utf-8?B?ZDgzL0dOMFdndDE0U2swK1ZqcTVVbnhZMS9QR0tOaG1EMXVYd0VmVjhxTEN0?=
 =?utf-8?B?cVJtcms4aUlhSFdQYUp0bW85dTRYZGxmZ3k1VW92RXMzRzVqZTMrUEpSeDRs?=
 =?utf-8?B?UFA0YTlXblNmaFh3QURZL1Fid0IraEMxUEY4S0pkZ3A2aWEyV29NV1dlalJL?=
 =?utf-8?B?L2gzZnVXT25PbmpNZDBnaHVUU1VhZGZnZzQ5RW43OEpoSVRaZEhFMFp1WXUv?=
 =?utf-8?B?QjF3VGxpTytvNm0xRFZnREprY2NBdFpzd3RWaDc4TmxId1RrbWtWZWRkcFNH?=
 =?utf-8?B?SDRyeFJ3eStUSU0xN3RWUnlWUi91NWZaYmtzb0dUVTMvZHR5REhjU0NTbmtG?=
 =?utf-8?B?ZFZOZEhqS3hORWJmMkhLa0VLdlFES0YvTDdrOFdMZG1YVjlFc0tHZmd0ZGVm?=
 =?utf-8?B?cnRTQWF1K2h6OVdXOVFGT25KajYxczJYbHFKdldtcnFXOE85aUw1YUErY05i?=
 =?utf-8?Q?QEV4h+DNIul7tfW65W10WaSXM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s9ry1FSOhd6X7UosvJvDUJCI6+Q5vQLfPVxWVmoJZ4ASLBt7PY45LXT8+rWDsv4o8cEtcts15tSARgER41gTeyGJEeDG1d50ptw4mq6DYT+YKcijKp3J6xDqvz/ugTflYeDOvSM8CljoTf4hm1inqH/98CMdGCcO1Zl3ecWpmp/rTn3KN5EheB5l+ete1yPKB4kgt3z9jTvKeCLwBdgGDnesBbhL0p9wsSWZ6i0787Sr1vkmqBCFknQK89VR5GR39DVIoJBxGCRBA4pJxw0O4N4I9WYYoNT6yRXVXmlWDnon7qMnijqrBLuObt6xQbzBNrRkj9L/X5qQbSaR9Si0FdWyXI+yGyVBx7H+dLoqHTNCC9vcmfve1UV8hHCLzk/imx9QpZbiftmhzeBCZIo6NBPttZW7tsLD0GI8QzmPDVHvJDo/h6aAwLlQ/FcoEFy7B456pYBgubjqG+LZNmV5uFh93KtjSbhbAlyz02Ymnq7xi/fbD7vKOBTAH+jiwvmMFLY5N4Qc+Cy8zx8Oirsjz+VZpMoFCuc1D3XxM2tAJVe3U+F6QRFl/tWxIPN1QZ3KFv3L0uW24BZrtSLBs7nJxQAXealq1ETsnR5xMlBbyRY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2da0240-0ad5-48d1-1170-08dc031d4769
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB2523.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 18:39:06.9525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGSP1zRaZ9zwtwWYTxxOdnnd01G0nLj5KSUjfWndQphprboZ2mHiuEOUFHiAX6IJsA4JfVag0bgaREorIpUygA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-22_12,2023-12-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312220136
X-Proofpoint-ORIG-GUID: 8KqHrvk_KoPt034T6JSo_kuQmKF39vwx
X-Proofpoint-GUID: 8KqHrvk_KoPt034T6JSo_kuQmKF39vwx
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.121,
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


On 12/22/2023 7:37 AM, Markus Armbruster wrote:
> "Annie.li" <annie.li@oracle.com> writes:
>
>> Hi Markus,
>>
>> On 12/5/2023 3:34 PM, Markus Armbruster wrote:
>>> You neglected to cc: QAPI schema maintainers.  I found it by chance.
>>> Next time :)
>> Yep, should have cc to the maintainers.
>>> Annie Li <annie.li@oracle.com> writes:
>>>
>>>> Following hmp/qmp commands are implemented for pressing virtual
>>>> sleep button,
>>>>
>>>> hmp: system_sleep
>>>> qmp: { "execute": "system_sleep" }
>>>>
>>>> These commands put the guest into suspend or other power states
>>>> depending on the power settings inside the guest.
>>> How is this related to system_wakeup?
>> Both 'system_sleep' and 'system_wakeup' trigger the event to notify the
>> guest OSPM the sleep button has been pressed. 'system_wakeup' triggers
>> wake up notification when the guest is in suspend state.
> Thanks.  Would it make sens to work this into the QAPI schema doc
> comments somehow?

Sure. It totally makes sense.

Annie


