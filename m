Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 995687BB3AA
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 10:59:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogfW-0002EM-ED; Fri, 06 Oct 2023 04:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qogfU-0002E7-Eg
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:58:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qogfS-0006hQ-AD
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:58:44 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3967tUu1013591; Fri, 6 Oct 2023 08:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=gKGJzbhs11/7zXB03KUBSyvoRGuBeqtxQAj6/AJFZKg=;
 b=vZ1su+drzhRSRhgDEUH/GCccbnnay4dJGHuycOV/8Iqto1jTK+PkGs/LvOJcLuSzgXpy
 bqUbSJJPIUHhW2Q+YlQq9CthFQKPJBT8msVh6DKEqm82moRiJsC9ES6BifcRJoluJCBg
 1iFMVSbC3SHy9OQ6cki6J+2nnIL3HMhhLFzq7PSBQrbFA60EuP8smEUlZPdasH7FK6Q0
 gtjx+QHHypIqumCcl1y77QqSsvnXOmjQMyPbOBjaLBEHHVj1CN5JNC6JVyrrKmlcq5Uh
 nqSHfHDDiHqxFsOelD6J20d5TzZhS9Y2gRLNHmag8i/hsD3Xl1FDMP8iGQKwGl8gXh5X nw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tec7vkcdh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 08:58:39 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3967x9hA009722; Fri, 6 Oct 2023 08:58:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3thcx85fxd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 08:58:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxVuRTrKWApJDbgXHPJ57cHENM8lwslHtn3NeKmdEaEwk7OaWurqvcLzOA6jsZRMjM+CqGQTjtjk1rY1iaAekNf4IE8tWZJqOM0jcEJQ0lMWGt/ajdStCZN1oeiuKNXiD55w+jZsISBc8npOOa8vBcTh1Aaf+bPjltDaeIqTZIrBlcdYqKNalLJAMxJ3dQI/dRg4DmQIiJ0s3LlF6mWPyEk/Zvi7ulVEfLcgRSfDPUaSSHqHq9Ufv6AA/a/B8muXCx3k4W8UfB4VpeJIsjyZXGUWzb04lM7HqJ+vPRE2dR+pR21TMvx/9QLWacLnocRc5wRRtrEbUPWPW5KpmJoK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKGJzbhs11/7zXB03KUBSyvoRGuBeqtxQAj6/AJFZKg=;
 b=YrwOLXUeTo7PU1fUWdAxgApMgPMtSF+evW5TmOqrnxcEhRaid5YHBiqBrq6gc6P0xfp3dYHMbS404lctS9mHiXvRyAEQ4wU2c79N5z8tSPFLA/pCR/t2blZg187j59rmiSE7DdFxLKUvrgOmPQ8C0J62lV3pUFEf8r8wy/Q0p/krHEj34c+h4XSmsuvM5ztKn25OgUs1j0cmcFmeL6uY9q377vbY+J6dl7fjpW2seS9E1wb3RPXFSyjn/6uTkHkub+Dp1HgeHKRWGAN9XfM/DTS5Te7eKZboAu81ljFodg5FBqfm+oDHV4zxplJyH/hMD0uuMmD11ido88lKqWX1lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKGJzbhs11/7zXB03KUBSyvoRGuBeqtxQAj6/AJFZKg=;
 b=g74IVAeLBEl+930bVgiCaBKsni7bX1yd01rbtzKy1wIYCx8pN6tRh2Xumvff12A68omLNMPLpEhC2fpskRQOhFUhA17Ym9HDvWRPb0/Kd9DhzDMuNEzil0pX0Le7LCboxYwj66gvoZRuxtLic39A34IsYRNrL12xIihDZ99cZFY=
Received: from DS7PR10MB4846.namprd10.prod.outlook.com (2603:10b6:5:38c::24)
 by CH3PR10MB7905.namprd10.prod.outlook.com (2603:10b6:610:1be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Fri, 6 Oct
 2023 08:58:36 +0000
Received: from DS7PR10MB4846.namprd10.prod.outlook.com
 ([fe80::f2cc:fca5:e473:d420]) by DS7PR10MB4846.namprd10.prod.outlook.com
 ([fe80::f2cc:fca5:e473:d420%6]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 08:58:36 +0000
Message-ID: <6e40003d-d2a6-4120-aa78-de26de088d86@oracle.com>
Date: Fri, 6 Oct 2023 09:58:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost: Perform memory section dirty scans once per
 iteration
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Si-Wei Liu <si-wei.liu@oracle.com>
References: <20230927111428.15982-1-joao.m.martins@oracle.com>
 <20231003095019-mutt-send-email-mst@kernel.org>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20231003095019-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0026.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::6) To DS7PR10MB4846.namprd10.prod.outlook.com
 (2603:10b6:5:38c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4846:EE_|CH3PR10MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: a39b632b-9a7d-4e7d-ff22-08dbc64a6cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oHEU8afuOI9OQinufpWzEMcSXkrNNxeNkym6b9QP5pa9+0dhiAsE86o4xSL+0gZAv7q+Wd5OOtJhLz0cun0jwM7ukk/pqnBaxr/XLhlIKtGQLdn0kvdvbiDAu+yzoJ8MIoZ4YPhVUfEbsI8snVRXGe/YxnB4BpckXitTuj3LfarZwFA+/ZT3aSLeoushIXtE/31DcbFM0Z2swXxa597+y0pjLUSGPoZANVnlbtQPtKDa6YWDTLPkPnDGcxpSvbvJN3WiIuiE/e8r2PIrC7fOHABEDcYKgkPZ93MXYJDaK3tMl+0j7mY/Aq0+h+2srwJA6va12IgGj6ZhbqzAlcjNLxwfyZHqdtP/cLuLx0W4uto2knE9d31PF+Mxs7xRWJrW2NASr2eDQqO4fAQIPqkWh1LYbY02Wkn9oXVXGzf3D+i3OLr/unZcUtBh/m27tmMPm8QcqDflsPAU81G9PVusCpyH+pfhVXcX6R2OZhFUe3z/ejUf9+H+ent0KsboYIxVkDfbmN7oDfzHi3fmBFGUkV4DYiajMhK7xkqSxsWyr+nP8MIarA6PVds+FxbBFFOOEtdRloo/fC37Ly2kcUOlgv2BQwN6p5iaV1lKpk0LkCtNTiihm9KPl55oRUhtfRfu15GK/LD2a4p3G2I2QU272WHV6WxqfOW72w8bRbV8v9w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB4846.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(54906003)(316002)(5660300002)(66946007)(6916009)(2616005)(6486002)(66556008)(8936002)(31686004)(6506007)(66476007)(478600001)(53546011)(6666004)(2906002)(4326008)(8676002)(41300700001)(26005)(6512007)(107886003)(83380400001)(38100700002)(86362001)(31696002)(36756003)(14143004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmtPTzVSOVorWEtjQm9DWmhiSW14QUNpQ1BnNmc0MURTSEp3MWNQSjlqQTF5?=
 =?utf-8?B?ckpoc1FUcnB4VkNjUmpXbFBSMGRwYk1vZTlZL0FwQ0IvRlVMMyswMS9jV2l2?=
 =?utf-8?B?RjlRR0ZPVEZCMmY0WFNybEllakJieC94NWZRRHBKQ242SWM0Z3Q1OUJjRVM0?=
 =?utf-8?B?QVgwZEhNaldIRmx1RnpwWFFBdlpOL3BpcVhEc005bjVwVjd4dE1oMUVLWVZW?=
 =?utf-8?B?NG5rL1huMSsxTUNQVy9pemlrUnBrT2EwT3hJakx5UmxXM2pyaC8xUW1kaTZv?=
 =?utf-8?B?NTF4R3hzQmlycFFhN3llUXJqaXJGbS8wY2FwblNrL3JSazJQalhXY0JBb2V4?=
 =?utf-8?B?ZmYwKy9EcFJJV3k5RmlTVHlCZE80SVJ6d1B6aFhrMkhkcjh5VDVDcDduUFVY?=
 =?utf-8?B?c1UzUm9TQTVBakNHRHd2c1B4emtFbEhRQ01tNnhaQjU1cEFrVnJueWlXazRD?=
 =?utf-8?B?blcwN2NsVVk5ZG9CV1U4SERIdkFvZW1La0tZR0FmR0owYVhIaXptR01qOVI5?=
 =?utf-8?B?eTZxUVptNGZjdkdzcXRRMFNDelFTM2IrVG1RZktIRWFqT3VENk9OeldiVGxD?=
 =?utf-8?B?TktKL08wM3IrRWJDK0ZDZkY0eTFEYlJrK1h3RFdrTEhsangrSTB5MmlkaW44?=
 =?utf-8?B?ZDl6UXk5eGhJSm5nMWpqNHE3N1ZpK3o5TzRzTXhSNXQyMFVwOWthVmpDclRC?=
 =?utf-8?B?YXh2bzZNSkFGb2t5cXcxWmtUMkxJY0NsYU5GVS84SnNnZ2RrUEhYZzNXZGhX?=
 =?utf-8?B?Z0dIZlVsZmVBL1FZbmsrU3dNZ0wwUnZUemU4YVVGdk8xaW1Uc1RSbkNJVUE5?=
 =?utf-8?B?K2hpNXhQcjNTVDlyRXozYW4xMHROb1lRY2FBai8rRllYNVUrd09jTlZoUHl6?=
 =?utf-8?B?bDBicHRXT0s0TlE2dDAvQ2t4ZEJsNC9TdDd2blB5ckdJTFNKaXlDdlZjL1Fj?=
 =?utf-8?B?Vi9FZEpQVUZCNGVYM2NZS0M3SllTaHUyV292ZTZQT2lqanVWWDRqR2NXRkdh?=
 =?utf-8?B?SnREaTQ3UFBhaGpodGNWSEltT0cwckdtM0VBYVBsMjZTemtTSzVoUWhWZHo4?=
 =?utf-8?B?azl6elpHaTNUS2dEeFVUTXZtdmxlcG9TSCtLV011eUlHcEZKRndNV3Q5WHJ3?=
 =?utf-8?B?ak82QVpaVkp2d1N0WFE2Z0tCZEZwRklaeHYzajdoc0hZRlFHdjBFSzRkaHdF?=
 =?utf-8?B?Y0d1Z0NDR0wwTDMya2cvaktxYWdwcVhNWmZEUUw2WlI3WGJPLzR3OXNWV0hr?=
 =?utf-8?B?OTdoOVVUeUg1WU1MR0p1bURMOW8yVGx6YXpyaWN2L3N5VTR0Y3pSNG1pMlRq?=
 =?utf-8?B?dmh6YjQ3MnlycU4vUnlnWUViSkRYdHY4R2JxWDlkb1V6Y0E5OUIyVmRoc1E4?=
 =?utf-8?B?Y3VNc05NOEpINTJHN2xwSm5IcnpMNm04VHVQRyszcUFDTWFOTUgzeWgyMldF?=
 =?utf-8?B?WVByY0ZrUTlJeS8wMjhBREM4TVR1RmcwaFNRSDdTZ3FxU01rbTZhMGJCV0pK?=
 =?utf-8?B?bk8rQnpEYzBpY1Y4Vy9oVXAvTFh2cjhRMjl6YlNtd2pmVUlhN3NXTnZ5MnJa?=
 =?utf-8?B?RkVTWkN4N3Q2ai9HYy9XZlcycFhnbC9KUENVQ3I4ODczT0cra1hGeDNrK1Az?=
 =?utf-8?B?VGtlRjdOQm5lK1hBaDlrRFlxMndZZDNlL1RReEJQYlQ5TWh6Z05PbDlyR3RZ?=
 =?utf-8?B?R09DNklnbkJ3STl5aU53MmZ0d0I0RFpXclJkdStWWmo1VHBxbWI5RjkwZS9W?=
 =?utf-8?B?dlJyS2I3azQ1aXJQU2MrOHU0ckdoTmNZdEFnR0FUak02VCtlMlZTRHptRm84?=
 =?utf-8?B?bTJtZzBFdDBIdFBtMkFVWWJ5YmdBcGtkbFZ1UTA5a2YxZUZwdXJqYjVjSEpP?=
 =?utf-8?B?Um95VWVxdWdUaFMxbGJ4UGdFUkhtbENTN0R5b2ZEckFyb0prN1ZIMjFKUEd6?=
 =?utf-8?B?dEpISGtsZG15TlVqelYwa0JDYlFOeGxnSTJENVdGb3FraVZDT1pJd29yNldn?=
 =?utf-8?B?N1RhT1JyZ3Z4aFR0dEVlcTg5dElIa1p3NTlXTm8rM010Qm9qbGlhTW5JaHo2?=
 =?utf-8?B?Z29iRFBlSllHTUNnRG1yTTdwd0U0bmRLVGY5eFduY2QxUm4yVWVCSFZRbzVU?=
 =?utf-8?B?SndqRWJQY1RLUVBLaGw2bnhvQmRqWGViZjRjM09mS1YvYU50b0FUdE5xeXpC?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Y+EUx8sSRuHY+5OPboywCxl+/wWP83eVnojbe5kGcmQ3eHgjtGuw2CtiBUNjZCcc4Raobieqg250I6INF8+zqq9iHniwKJqGjVXwc7vU0MQOeDfbZuhAh6R7/db3mZ1t9kGSvlK4wkS0pNgjkTEvlnjUqjgRBwtYNeFZP8GTNWSLaNCfDgKL1t8/MrA3WoHd1a2csSJQ2cYTNGNeDAVmS5ewqYLgK+2orH2hp18DvCkZIIkHBGOS+TOCwHkv50PepY3or5RdFweM7AYUbRzEF8BLwE/L4A4bvTp8eZD0BB6YfntHJ38a8esp0ydPSXnY7iVecO/b3pb7tjQfIq/i2xQgfKdiqBAYQp/3cFgmSrB6M0637zd+nw5dRNNlf3Au7+xsl81h26EMOOFTMzHCqxJp858fQKLk1vgg/diTD2j4bDfwjZX/reJj9XhFq3O0ZajhX9j5doP9JkZZkNO21POzcu2QPcCC7frXs03aDy8u+A3xldxqC1F0bWxBu76gweuXDDjzxZOds/M02DYcxAkWsnazWgIrr830/+47eAiXbNeCSaFP8HLDmTIdfzz17WuKCkIccHKRTH6J79DyRdFwwKzDj6e9vPfxdmwCGXYoQpHYerOaGAvHQTWJol3TTGzowIRWNcI+CDHFzXHfVXQCemIeGYjev5G4oRMiEo+TTYXjYQ4vdUoKDWeFBxbK/oKpaXyuQnojK9pVy4D4oxooars8mKvmEusWIws1ild7nhHvCbKKupTOCOLGwF37xu+cybdWZBPEjyjyd9I+qQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a39b632b-9a7d-4e7d-ff22-08dbc64a6cd7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4846.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 08:58:36.1119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBNjya41AFNS1NIjAW2DKhIN5JBBuW+K/lnp5eMOe2UAgjiPEZ8qI0wkKLbo484MV7+jZONoiwDvusF8VqRr1SDb1MjZ7yJ7UbDsr8KIegY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7905
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_06,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060064
X-Proofpoint-ORIG-GUID: GexinKqt4zzyy0aUPahxciHbUX6rDoLN
X-Proofpoint-GUID: GexinKqt4zzyy0aUPahxciHbUX6rDoLN
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 03/10/2023 15:01, Michael S. Tsirkin wrote:
> On Wed, Sep 27, 2023 at 12:14:28PM +0100, Joao Martins wrote:
>> On setups with one or more virtio-net devices with vhost on,
>> dirty tracking iteration increases cost the bigger the number
>> amount of queues are set up e.g. on idle guests migration the
>> following is observed with virtio-net with vhost=on:
>>
>> 48 queues -> 78.11%  [.] vhost_dev_sync_region.isra.13
>> 8 queues -> 40.50%   [.] vhost_dev_sync_region.isra.13
>> 1 queue -> 6.89%     [.] vhost_dev_sync_region.isra.13
>> 2 devices, 1 queue -> 18.60%  [.] vhost_dev_sync_region.isra.14
>>
>> With high memory rates the symptom is lack of convergence as soon
>> as it has a vhost device with a sufficiently high number of queues,
>> the sufficient number of vhost devices.
>>
>> On every migration iteration (every 100msecs) it will redundantly
>> query the *shared log* the number of queues configured with vhost
>> that exist in the guest. For the virtqueue data, this is necessary,
>> but not for the memory sections which are the same. So
>> essentially we end up scanning the dirty log too often.
>>
>> To fix that, select a vhost device responsible for scanning the
>> log with regards to memory sections dirty tracking. It is selected
>> when we enable the logger (during migration) and cleared when we
>> disable the logger.
>>
>> The real problem, however, is exactly that: a device per vhost worker/qp,
>> when there should be a device representing a netdev (for N vhost workers).
>> Given this problem exists for any Qemu these days, figured a simpler
>> solution is better to increase stable tree's coverage; thus don't
>> change the device model of sw vhost to fix this "over log scan" issue.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>> I am not fully sure the heuristic captures the myriad of different vhost
>> devices -- I think so. IIUC, the log is always shared, it's just whether
>> it's qemu head memory or via /dev/shm when other processes want to
>> access it.
> 
> Thanks for working on this.
> 
> I don't think this works like this because different types of different
> vhost devices have different regions - see e.g. vhost_region_add_section
> I am also not sure all devices are running at the same time - e.g.
> some could be disconnected, and vhost_sync_dirty_bitmap takes this
> into account.
> 

Good point. But this all means logic in selecting the 'logger' to take into
considering whether vhost_dev::log_enabled or vhost_dev::started right?

With respect to regions it seems like this can only change depending on whether
one of the vhost devices, backend_type is VHOST_BACKEND_TYPE_USER *and* whether
the backend sets vhost_backend_can_merge?

With respect to 'could be disconnected' during migration not devices can be
added or removed during migration, so might not be something that occurs during
migration. I placed this in log_sync exactly to just cover migration, unless
there's some other way that disconnects the vhost and changes these variables
during migration.

> But the idea is I think a good one - I just feel more refactoring is
> needed.

Can you expand on what refactoring you were thinking for this fix?

My thinking on this bug was mostly to address the inneficiency with the smallest
intrusive fix (if at all possible!) given that virtually all multiqueue vhost
supported QEMU have this problem. And then move into a 'vhost-device for all
queues' as it feels like the problem here is the 'device per queue pair' doesn't
scale.

At the end of the day the problem on this is the vhost object model in log_sync
not scaling to amount of queues. But you could also argue that if the log is
shared that you can just log once for all, plus another one for each deviation
of normal behaviour, like the points you made in the earlier paragraph, and thus
the thinking behind this patch would still apply?

