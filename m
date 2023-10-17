Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F10847CB77D
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 02:40:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsY75-0006mO-0G; Mon, 16 Oct 2023 20:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qsY71-0006lr-Fu
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 20:39:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qsY6y-0000TW-Vv
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 20:39:07 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GKO9rK000740; Tue, 17 Oct 2023 00:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=PpE4j+Tc2zZFcqaxGNwxNwt7y5eD5LtDiKyA8+VXmMw=;
 b=G0ThKx0syad4+V3aTt1kjVkxzgw89YROqwlobFvpPaYxKv4YUdo5gtrxp38Oyg9X/rwM
 IPKkuOe/36zW7+hRDLbJOkNCybryBv/v/uSw53uMEQLIGlfzGn1JrJ5dkEjRZQoOOCqh
 Khn8rNkYHK/7LIimi97Okz/3Yd4z2LjDJf3dM9Y+uvDLTYRsFqofJCTU+jOYT+nBErnX
 TA1BaNYhODclMgtUma9UmyNNE1WdEml6KhH/y08vtsmYfDKUejlp8WpfdsHJcYRZNxVG
 y+Rh+syGy2FY8HMsKznIgGXbk1RIYH657Jro3Ao6Pa8/FWb2lL4cNQXPxz0yvYRx36Xc 7A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk28m2em-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Oct 2023 00:38:57 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39GMIoRn028597; Tue, 17 Oct 2023 00:38:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3trfy2vs8t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Oct 2023 00:38:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jahltx9uUkjy6b/LwUBQHyM8NpYN3fF3Hlo8m2y2OyKb8rj2Lf4C3E6lf5p2hJujfi4PNuc1yqCZL4BD50yKen1UxoZqsqTLzm+eFjgRbTLwM0Xs0Zn+Ou48aQKnjTiuwEN10ArSqiXBkGC8siEGqbw/fPfVB1mpbXbcb3PITecCTCWGEWSjXdoDDHHlfVF8b/lbXDU1WmDLhYUbCCr8psn6lVVEvzlt4lbMy1yZ3Y6RaEX7V4RoKgfZsrN2BXvn6dM7rQnNvSW4lglCkxgW80B8GRuKiWQzG6CnBpxuzlOKjUdRW6vioGniBeSG+iIxQN+IIqXzaHGbkX6nXUhc+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpE4j+Tc2zZFcqaxGNwxNwt7y5eD5LtDiKyA8+VXmMw=;
 b=aWPN4HVuZtVLtzAWSeebUS7esxWYayE+Ak4/ss17AP+fGKHS7KIt5K98jAfpkEIQ2rWUj9PbC9KZaudmYNjeUrZ02QplWileT/ZKpVKkatIcmYP18OTfM/68yg9uzgFgXbCbyABVJSCwiSj7oycDqg+Wfg0RWNjr2bftxMJfHGoLP1nmQpVpNIaZZu09ApHJJPM+SSt6j1LI4apimnP55caGJoOmw4V6ePpZr9/3Sp36kNRp8kIWou8mJcQyvyHJDRaX29hohcmgf6jeBfI2rHqNHbHYnIbz9nnO/fGK6tr98Yx2tG8A2fZbcZhFnd+yUCE/Z2xZTm6i+RN2rAa+Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpE4j+Tc2zZFcqaxGNwxNwt7y5eD5LtDiKyA8+VXmMw=;
 b=dTpYPrNCzH/sNFAmRtgeXlNvoRa0UGIjE+pcAJkQuFxMgl2s7aakPIqY+o0HD099nQKMKAnEp1nLE9CNeP0zResYdZYs/qU8poWKqKBGYYG3Ip2t2LL4bE4U9p/yuerMvltoY8fP2+V+jz9qpOBGjoq25RmRs7iKe8HSfYdIiDE=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by IA1PR10MB6879.namprd10.prod.outlook.com (2603:10b6:208:421::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Tue, 17 Oct
 2023 00:38:53 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 00:38:53 +0000
Message-ID: <c0af41b7-56dd-4395-8c79-d630ece3b589@oracle.com>
Date: Tue, 17 Oct 2023 02:38:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] migration: prevent migration when a poisoned page
 is unknown from the VM
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, lizhijian@fujitsu.com, pbonzini@redhat.com,
 quintela@redhat.com, leobras@redhat.com, joao.m.martins@oracle.com,
 lidongchen@tencent.com
References: <20230920235301.1622672-1-william.roche@oracle.com>
 <20231013150839.867164-1-william.roche@oracle.com>
 <20231013150839.867164-3-william.roche@oracle.com> <ZS1pSeL3hj4/73lk@x1n>
From: William Roche <william.roche@oracle.com>
In-Reply-To: <ZS1pSeL3hj4/73lk@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0017.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::6) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|IA1PR10MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: ebdd7bc0-fdbe-48a6-d5b3-08dbcea97067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eAbUBQaENMk3tfxJ4oZmH5TcoiBxXMS3/eKSl3NpojZmDiomnjD4vxQIfXQz6dXiOTMyWIa5u//xPgXQU8qoZXhsY2Et9SmdYwif7/TqVR2CTGQMvlPHLK574Pcx6b8ZwFRP5mpCzCiH/3DjxuW8q3K6EqLHNAPHSWSEPpx4dU6tiXEdZn7z0l260Be+nqe65X9eE5XywhzMgJjaPbsfcq7d+gz2er61lvGMeeTOX5Wtx9fPTNs6sLreL2qBmv5nXtZ5E8i2/Dh80WGQi9p8wr6emzNGpHLgwPKB4d0pDzusrqDU92PcUO7eGjqksL1/K54J3i04KB4fOA4ZdsR16xxe6eGP7+aIkaaov8pA31VIiRPqlNfdkr2QVNcweGe9484VurOMA8QEgvM7D0rEFgm8+zXMVcbG4s6gEQRsfewktmWBKIgPbt/GwBcECW/4oeYewo3n6qtvQVlRXxeRuz4PHGuIJLz5yUsnmH8ETphWnbcxYdL+tPRM9I1saNs1HEsnwfeJQZ/3IFm5WXRk7Oxhvbrygg8kXEGn7WBjOrWmPcaqqpxrSGI2IyT1Z1yUS2WKVVhvlx7g5UDhXH6EHHw+PyOJP6/IvZ5gB4yyGHsk4+cjg64D3/XgHwn/sVF8pWolwLT2DcjedOFxUz4cvZODD/DLWpjmqhj/pFwIBmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(38100700002)(66899024)(26005)(6512007)(2616005)(36756003)(44832011)(8676002)(4326008)(41300700001)(6916009)(66476007)(66556008)(66946007)(8936002)(316002)(86362001)(6666004)(53546011)(6506007)(966005)(6486002)(31696002)(2906002)(478600001)(5660300002)(83380400001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3hENHQxckF3RjRaMDVFWFl0Y3RXSDJLMGkzbHdqQmVNM3Y1L3JOdDdCY3ZQ?=
 =?utf-8?B?UFFZekU5RW1zRlQ1a29yRiszeHdOTUZsdVFsTi9WVm9nYVh2aFNTZGxDblVQ?=
 =?utf-8?B?TUU3TWdLeUQxejZzOGtpUUZQNnllY01RUmRFMFdna0FRWVdvZEhVd1ZWQ09k?=
 =?utf-8?B?RzJic0ttWHRFZEZTcFk3REFjM1ZtSG96UmZGcHdPZWRJVFlld2FrUStvaU1T?=
 =?utf-8?B?K3U1dXUvaTdpbnFyOG5BUDkrRXAyMVhTd2gvN3VWOEt5b0pSL1dUNi9FRzRT?=
 =?utf-8?B?Y0JSMWZvcm02UFBNRkV4M0Z3b3Z3Z3FhQ09CbHVuWU1vYlBlT3IzbWdEeVhV?=
 =?utf-8?B?T2dHT1ZwQWhOUXhaYUxxQ09iQXZaUTdWQmZpd1ErSlIxbjc5UFQyU243Qita?=
 =?utf-8?B?WnZ0NmZUMWpkZUEzZVp2VDJCcWljY2ZxL3F5dkdlV2E3Zld5Q21RNkUwcnpj?=
 =?utf-8?B?ZDA0Vkk1b3FNWWpuYTFianZxRHVJMmFPSXdiUEhlVFl2WStFc0VFNG52UEk3?=
 =?utf-8?B?TlRBMjhIMzdQQytwWFJtTEVXUENLS2x3R1Vtc2JJQVk0RGxXdDhZZzhoZHNi?=
 =?utf-8?B?aG1wcS9OUXlMZERRY3Era0tDK2Qxb0xGbmVSSVVsOGRnUzQ3T1BFZDBNMDVP?=
 =?utf-8?B?SGZUNk5WTGVqM2cwU1FKcVpaWHFWemVwa3Vsamo2UENuOUx6TkRHUGpCWlZZ?=
 =?utf-8?B?V1g0bEVtVDRFN0FBQXl1SkF5LzhwN0x0VU4yM1JFZ1k1SnZvSEdCN29ESEZI?=
 =?utf-8?B?MWtPNEdjaERIZVFRLzdGb3cvMG5hcUl6LzYyZ0Mvb1FITTl5TDVlb1p6dnZo?=
 =?utf-8?B?RE81N3RsK250ZkcvalZGekQrS1N0L3VDcG5EcFpYSWRucFh2eFdLMEVpSlhP?=
 =?utf-8?B?S1dwUGNIWW1WOEdydzhyNWdQem9wbGI2U2p0VDB4NldzODhYZHVhL2l1T3Bn?=
 =?utf-8?B?VSsyWlQ1c1o5MEFxNU9UVE04ZGo1dkhmUGNrZE5Dc1RhbXIwZldUenlYUlMy?=
 =?utf-8?B?SmdPcmRndW82L05HZFZOdjgwKzBTc3NoZVhwNWFqQ1NIbFdOR0VyaXFOOEJE?=
 =?utf-8?B?YzBCM0pZYVdEc2NzRUZWY1g5T2c4MVcrdWRWdlpWazNFUGlUeFl6T3AySmRK?=
 =?utf-8?B?UWswaGRpdC9MKzgrMnBKVzFTUnQxeW5pQ3NtMHRZZ2lIWlRURW4weU9haUdP?=
 =?utf-8?B?aHB6aVh0MFgrRzY4L2hmMjFwZnI5TzlDWFZlQ0xkN2lKTmxkQndiMkUxQ1p3?=
 =?utf-8?B?VFd0MEpyS3ZMRmpQR3hQdHpKbWhoak5zajg4alNqQ21mdUlsaTlsdzlnVkNX?=
 =?utf-8?B?SUZnc3ZPMEZyWEZTOFgxdGRTSlBoVHBZOHBzQXZKNktmNGRLY3ZDVUk3V2ZR?=
 =?utf-8?B?VXdGTEswOWFZZDdaNFNpL2ZWQnluM1RBZXl1bkNvTVduMXVBSE9Vc3ltYnlV?=
 =?utf-8?B?ZlRRdER1dytyTVREQkpTQnNnNkhLOVIrR1BvQUJ6Qm43bmJBaUhzQXJyMUFw?=
 =?utf-8?B?Vy9uazNPSmYydWRjMXZtSitFTGQ1ZEpDS2FuYjhvTEVHeUZ5TkppUmxhSVVM?=
 =?utf-8?B?V2owR0xGejBuQ0g0dkh6dUh4c3RLZWsxYWNsOUJWb3p6WDgvVlg2ekJlMmE4?=
 =?utf-8?B?SjlOQXd2UStBZVA2WWh5VHdXVktTeVdZQ3FmL1N0dENuR2FqNklkd3dBazU3?=
 =?utf-8?B?TFRWUUNYYVVEY2dlczIxcm5lT1lQemRGTFNMNWNiVFVEQ09kNVlmWE9laEJN?=
 =?utf-8?B?M0JSelQ2TnVISDF1RVRLZ2FPV2JjeFhkQ01uZW9EbUlhbngwQldGdDBNSW1o?=
 =?utf-8?B?YzUrcm9GbHlZL2hxSlFCakJ1ZDVRUEVPbGtxTzZVcW5EUndDdys2dXlZK2xN?=
 =?utf-8?B?UlNqMml6aFQwWXZTVS9DVVhPckhGc241QzdUSEJFbjlUcVhTcjhGck5XaG40?=
 =?utf-8?B?Y1JqenpQUVJKdEIwYWJiMUR2cGt1bm52dk0zRDBDbStmeTdmODFXaWpqS0dQ?=
 =?utf-8?B?U0YzT1pwWHpBSXhGdWdocm9kRlY1VmlsY1hLaUlHQWFIVkFJZGpoaEZ2ZlRX?=
 =?utf-8?B?MFN3WDFKMFM0N05PY2I0SGJCR3FNcWpvL3A1NDdQbzZoQ2Jtd01xUmZCclRV?=
 =?utf-8?B?TE5aU1BLbVFWNVRtZ3JjU2txZGQ4bi9NckFlWEVkZjYzV0JBUW1Ec3dGc2dE?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Z5qOxer661WOZHmRiow82vGbwV4lZcAjfCwoTloV17xTIwsmcPL/a+Hkd033MDkXLM4WzFhojtN8dxK+fikP9vT31PzujUl/KXvJfcnKhN7R30LwWBPS5Taz24Ia4Q15+COBaC8OaYW5tySWybjKlosBn8F9FCz1zwUGOvcbyx23e+YzMBsYcyxawzRFc/1IqO0ggTr3kZ16vdpHoaQczcJaKfuDrSpz9yVNqrRWdc24/2srxE30OIFcestQ1/+X+yRYjc41ZX/DFQ40M1mOpmOhSvkGsaDwj07JAaxKu0KMEAHidAnqNmlgq9so7zlAY8V5SfQnxLLBGtY6rEUsrvwz8xBk6997MnySmcoasA6/ZW0xqCf5W+Ld3lfv8tK/r4A6lKbXLTD2O75CLyOs0f0Yb9sJwom0iiLgajVuxF37RQChvm8IChXTja7Ol5vvSLf0eXMmbTn9BLIH1chDeAMcvzEhXQEDEZ5BQhDCFpTqTIVH60N8FQtqx4ZDtLz9VkWXCJ07UHwJ8eU1ZFH4unYzjEf5EW9SuNrbfCWPKQ4SBLw5BO5hicKL5OshI3MvEmlnoLgcDN16cpNHdgqKXLGrkeiwQOQXGnrRIT2tl2j8KgtcUGScij+k/dMItE5yq7+B7YJ1q/YnfAEOv7w2ObvffsKO2Zlv0KmFHRwfB2JXomzAw481V5JIx+X208oXJ5epQHB3lxk5Ua6fFfWH8Uqjas/UofoJ2IeAkbGW3OmEblaFotB9ia64kVsaB3cYfnz4pnTgOKRNp0q8rm+mj/iZ49IW9j2iKj1hhyfMcaVkYCl8STIO6t9RIFD1kppghdWBnP6dBDeSp8y9w+ZGX2Pqp7a1dXk3GsalszCrebM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdd7bc0-fdbe-48a6-d5b3-08dbcea97067
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 00:38:53.6283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGZ+cuXxwu7rovpneaBcX6aP9/cj6myNAv2zqwZ/ZQskvEq2Eo9AGDS5I9jcQrHAtuTvwbk6ZTvxsyx6WSin14wbejZYO54AYWN4g5NtKg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6879
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170003
X-Proofpoint-ORIG-GUID: 0bW_BwN-kyeBuoSIbTblV2Sou7NXHBHk
X-Proofpoint-GUID: 0bW_BwN-kyeBuoSIbTblV2Sou7NXHBHk
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 10/16/23 18:48, Peter Xu wrote:
> On Fri, Oct 13, 2023 at 03:08:39PM +0000, “William Roche wrote:
>> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
>> index 5e95c496bb..e8db6380c1 100644
>> --- a/target/arm/kvm64.c
>> +++ b/target/arm/kvm64.c
>> @@ -1158,7 +1158,6 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>           ram_addr = qemu_ram_addr_from_host(addr);
>>           if (ram_addr != RAM_ADDR_INVALID &&
>>               kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
>> -            kvm_hwpoison_page_add(ram_addr);
>>               /*
>>                * If this is a BUS_MCEERR_AR, we know we have been called
>>                * synchronously from the vCPU thread, so we can easily
>> @@ -1169,7 +1168,12 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>                * called synchronously from the vCPU thread, or a bit
>>                * later from the main thread, so doing the injection of
>>                * the error would be more complicated.
>> +             * In this case, BUS_MCEERR_AO errors are unknown from the
>> +             * guest, and we will prevent migration as long as this
>> +             * poisoned page hasn't generated a BUS_MCEERR_AR error
>> +             * that the guest takes into account.
>>                */
>> +            kvm_hwpoison_page_add(ram_addr, (code == BUS_MCEERR_AR));
> 
> I'm curious why ARM doesn't forward this event to guest even if it's AO.
> X86 does it, and makes more sense to me.

I agree that forwarding this error is the best option to implement.
But an important note about this aspect  is that only Intel architecture
handles the AO error forwarding correctly; currently an AMD VM crashes
when an AO error relay is attempted.

That's why we've submitted the following kvm patch:
https://lore.kernel.org/all/20230912211824.90952-3-john.allen@amd.com/
Among other AMD enhancements to better deal with MCE relay.


>  Not familiar with arm, do you
> know the reason?

I can't answer this question as I don't know anything about the specific
'complications' mentioned in the comment above. Maybe something around
the injection through ACPI GHES and its interrupt mechanism ??
But note also that ignoring AO errors is just a question of relying on
the Hypervisor kernel to generate an AR error when the asynchronously
poisoned page is touched later. Which can be acceptable -- when the
system guaranties the AR fault on the page.

> 
> I think this patch needs review from ARM and/or KVM side.  Do you want to
> have the 1st patch merged, or rather wait for the whole set?

I think that integrating the first patch alone is not an option
as we would introduce the silent data corruption possibility I
described.  It would be better to integrate the two of them as a whole
set. But the use of the kernel feature you indicated me can change all
of that !

> 
> Another thing to mention: feel free to look at a recent addition of ioctl
> from userfault, where it can inject poisoned ptes:
> 
> https://lore.kernel.org/r/20230707215540.2324998-1-axelrasmussen@google.com
> 
> I'm wondering if that'll be helpful to qemu too, where we can migrate
> hwpoison_page_list and enforce the poisoning on dest.  Then even for AO
> when accessed by guest it'll generated another MCE on dest.

I could be missing something, but Yes, this is exactly how I understand
this kernel feature use case with its description in:
https://lore.kernel.org/all/20230707215540.2324998-5-axelrasmussen@google.com/

  vvvvvv
So the basic way to use this new feature is:

- On the new host, the guest's memory is registered with userfaultfd, in
   either MISSING or MINOR mode (doesn't really matter for this purpose).
- On any first access, we get a userfaultfd event. At this point we can
   communicate with the old host to find out if the page was poisoned.
- If so, we can respond with a UFFDIO_POISON - this places a swap marker
   so any future accesses will SIGBUS. Because the pte is now "present",
   future accesses won't generate more userfaultfd events, they'll just
   SIGBUS directly.
  ^^^^^^

Thank you for letting me know about this kernel functionality.

I need to take some time to investigate it, to see how I could use it.

The solution I'm suggesting here doesn't cover as many cases as the
UFFDIO_POISON use could help to implement.
But it gives us a possibility to live migrate VMs that already
experienced memory errors, trusting the VM kernel to correctly deal with
these past errors.

AFAIK, currently, a standard qemu VM that has experienced a memory error
can't be live migrated at all.

Please correct me if I'm wrong.
Thanks again.

