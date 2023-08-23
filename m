Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1226D784DD9
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 02:33:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYbnF-00025v-Dt; Tue, 22 Aug 2023 20:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qYbnA-00025T-L9
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 20:32:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qYbn6-0001Cr-KA
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 20:32:11 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37MMEAsr022762; Wed, 23 Aug 2023 00:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=A1aQ0BUtb9CNWUi3FzDhWhKY/pCD2GDHvuy8XeElZd8=;
 b=qgwTFih+EKRmQRuRNAC00Oxc25aHq752QhGG5fvEKk8NV0M9aelqo6Ogvl+KCW9BfZ+D
 Cf9OtSJiCXO/2Ebt7v7mwRrVdt3XfVwaZYjfAgrzsD5CRkbOVu0C3Mm0VWxhRjJ4X6KC
 RqY2zq24vx0+i+tm2UVVmBeoL0FC0yQdfoqYPJWBo4IP+oaheZWBVVAO0o6Os6BESap5
 ul4HmJR2vQmkHWeoK2gMlsncSyYdML3giuTt0UjOxEZ1Rf+Gk2LNHqvNdsxaels5870r
 QH2W91s0ZjahsqSZpyWiRsdf6BN1abIbPpFYuWQh+BsimC7YY2rWwLFUtIny0BPdM+TA Gg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20cgp27-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Aug 2023 00:31:51 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37N0Lqar035899; Wed, 23 Aug 2023 00:31:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3sn1ymcbtu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Aug 2023 00:31:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yy8nCv63GpTNfm1FnQ/kgCwnVFMn6+Ok03gFAb3AI0TTPBlhRHiDuCwIvV/x8SvY6gZQNRa3hMMxoxqzxj4kbNB/BgXRJyanr8LHLYEW691FneisL1t/9GLKmMtgqQ+3Kpz0lQahvHlnbhV/RUUgb5LC+RQPH5udH/wMx8DUUQNyZDBwE7SQ5nD7yxEuzRSr+PpNhfT8+TQYzjfs/73gb35+4eJLeFsjVt1T++JKu9iVaLUZ4X+UusW/Rlg6PTt8ZVbb+PCn1L8XwB7tAEz1egBoVmjBoQOtqQBbAAIcQyKoliDZcT6f2sNT8s0Ss+UOLIgaHZLYahp5LU2T5btNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1aQ0BUtb9CNWUi3FzDhWhKY/pCD2GDHvuy8XeElZd8=;
 b=nWjruGaSpdOruL/qKw0+0Kkl7IUw4jIzzX7fNDQwk6vWEiWsQxjXDGG3S+m+BwOmgAs1cIU4Tp3uKhI7ZBtqLw3yRn2vZ2G6Yfw9zV8fOSUVdAdZNJvNlNAlrev3KNA1c0/BJq3EiMZSss2afuFVBcyOJ5SGEq23Lvj/QEBMqVrfB6+Qtdo1MJgdDoIYbJsZZQZaMhW9a7+56ToJ2d2SRwr3cNFSkVU4IFrr0b92IImoxrcq+/VSEL99IBslj+5zfOdzYfI59KZKNEa38cgnS0H0peUYMxhqI1cswXo5gKJc/iwXO7I8mN7UZePhqrvJOZgc0noDAQxFxFqQdUrgjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1aQ0BUtb9CNWUi3FzDhWhKY/pCD2GDHvuy8XeElZd8=;
 b=ODCd6XXUP3V497litnrATfuVYh3nGS0Kye5D/yUyNlZdjR+qyn7bWbsD/3sjVs51+rYVGMC1taadbcACpRqZMAL4LR/TW3jVEqdA2NbWYjqVNJagg4bpfeQgstTBd/jUbsLkcmGcc3Y0Sz0WHo7K3ZKtdVmfHdx4b09Xp10D5ZA=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by CO1PR10MB4580.namprd10.prod.outlook.com (2603:10b6:303:98::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 00:31:48 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74%7]) with mapi id 15.20.6699.025; Wed, 23 Aug 2023
 00:31:48 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, linux-debuggers@vger.kernel.org,
 joao.m.martins@oracle.com, Richard Henderson
 <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH qemu 2/2] dump: Only use the makedumpfile flattened
 format when necessary
In-Reply-To: <87edl4d9wi.fsf@oracle.com>
References: <20230717163855.7383-1-stephen.s.brennan@oracle.com>
 <20230717163855.7383-3-stephen.s.brennan@oracle.com>
 <CAJ+F1C+VFpU=xpqOPjJU1VLt4kofVqV8EN4pj5MjkkwWvVuxZw@mail.gmail.com>
 <87edl4d9wi.fsf@oracle.com>
Date: Tue, 22 Aug 2023 17:31:46 -0700
Message-ID: <87fs4aha4t.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::34) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|CO1PR10MB4580:EE_
X-MS-Office365-Filtering-Correlation-Id: 0890025e-29b7-411b-3da5-08dba3705613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X8pVoe/pW60x2jO3fE4VdBQQtFxdD+wzF7kjQemR1jTBMMHxpzXT7OweMp5CSUzgMShcmYXVqWqJc4E05DXNQ2dbfbuFKcO44HhRNpdggcdCZhXjFrUQqEjBoE95S8M0f9Nm+dsd9fzfNV8LiK1JwJjfGN6VdZ6gjfGY7HdlVP2pS08BO3h7akp6EyMOFPVK70WI51H5Hcw9C1wxcvsSgNTmX/weELTDWP1soRhBI2yhQ19P7HVtwS/twNBwNo0M3vXolD5Me8RuDkPw0xXvCyt0pUDML8fsK1ytL/EHvFrSx08N8Y9/bYjdnHXgCsGv4Yxc5R5rGSXkQqJMX0WvQLTUy4fhvioba3peviqzTM83KV4WX0MsWE/vmwIAjVukZUJz6g++MEEfgQnZM3mmW3Mz8Kki0wUG7bDYvz2gpMzDKqOEOwR+DiOOy5uMm/YhI1bITMTsc8r9PveFg9eqVqSbn/vjM/kUvUk2LoupZH5F0kK0bgdZYaD/Bn3VEnxfQoCIrfVgD2+h/wPtZGBGfl/sKm2QUT9/pVn+Gm0v31wep7Hln1Z0XwWXj6Hnil5h
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR10MB6597.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199024)(1800799009)(186009)(83380400001)(478600001)(6506007)(6486002)(2616005)(6512007)(66899024)(4326008)(5660300002)(2906002)(66556008)(54906003)(38100700002)(41300700001)(66476007)(316002)(6916009)(66946007)(8936002)(36756003)(8676002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzkycmlsTDRUaGRBYm4xZ1NOaW9CWXdYaitJU25jRkUwRTVKRFN0b0F4bTJF?=
 =?utf-8?B?SnV6SnRKRTR1U2RPamYzcDhnOE5zZE5TbkRFOHlZUXFLem5saU82SGEvTWNR?=
 =?utf-8?B?dkhLNm1FWDlWWkhYNEFSUTVqb2ZhcVdjdkk4ZVBhcHIzRnJTYWpNckFOTjFW?=
 =?utf-8?B?M0IwOG54ZWxTSkpXNG5lY1ZrUW5rNDNvRkZERzc0YndicCtzakFGbmtDcDNh?=
 =?utf-8?B?VUp2UksrNTFETmdnMlB1NUg1ZlNtQnlOdXFEY2lVdkRwdW1BLzIveEMwOWcz?=
 =?utf-8?B?M1E4UnZvd2U0cmxIZXBKWlJPc0dma1poN29OSGc4bWFodU9scU5QNFM5N28x?=
 =?utf-8?B?MUtDRTNrYUliQ0NYelVaZ0dRNTl5MXFNbVdFM0NwTitYck5ObC9paGR3dXhI?=
 =?utf-8?B?K292ZWZTUSs2Mk1DaXI1dlYzTGh5UFpXaHM2OWsxVkVzU2I1SGh6V1g4eWJz?=
 =?utf-8?B?MHI0RW5QQmNIakNPVGlWaDFLZ1FOY0c5Ly94VEtpNzhvbm84bEZoR2JleEk5?=
 =?utf-8?B?RDhvajg4M0FReUtpenc2emNjZHhlSmZQdndTQndWRlJxV21kYzBHK2wrcENM?=
 =?utf-8?B?ejdocWh0a0V0VHZwb3hMeEJ4a3hzUkYvczEvdkNyU3BKakZwa0RZTTZGUUxp?=
 =?utf-8?B?eUlPVnV1NVJLcVYyYmxEaWcvT2lhUWc3d1VoekJ6N0xxcEFYQjF6Q1JHSGUy?=
 =?utf-8?B?c0RGRTQyZ2htSFJReGU1UDlpUStKVWhlQzdMWGFoS09iTENsdytualFjNzV1?=
 =?utf-8?B?THdMREJjZkJIWnIySlFOQkZmb1FJYWxxWS8vci9IMU5qQ1VWeWFURko4RGpC?=
 =?utf-8?B?SXJtVUgzQUVMcHNRQlhoNlB1VFBtdXUyb3hHZ1dJZHRHVFZxeGRIL3hwcUNz?=
 =?utf-8?B?TGx5cE1xcG5SV1JZRVVCVzNDQkJPd0oyMXpkaEtXWXBTYUo3d2wwTHBIeWh2?=
 =?utf-8?B?S3FmV1JwRHZ3NkdMalBhMHg0UzdFaFhiKzVOR2lBaTJTNDNjWEFXeVo0S2Nk?=
 =?utf-8?B?K0RlVXhrSGREWGVXeWViN0lkRUpubkNEOWo4dnF4M1FPMDBHemZ4b3A3dFNl?=
 =?utf-8?B?alYxZVNES3ZtaGgzZFZyVGJYREsrc1VlT28zNWsxdzVKYXJsVGF6TDViaG01?=
 =?utf-8?B?eEZpUUZLOTdOYmhqVDcrbVBQSkZlZ0NPZngwbFBVdVlteFJCTXBXYWR0VVhq?=
 =?utf-8?B?MDlsME96ME14QWt2TjcrcGVuYUx2QytaT1daUDBEYmVrUUFkeTB2UnJTM3Ry?=
 =?utf-8?B?YlZTNTN1NW9EK1R1ejRzWkRPcG4yU1RRd1l1L0tGN1RQUzVyd0tsZEhKa2tp?=
 =?utf-8?B?a1l3WDZNSWRtSnpqMXV6NGFIdGJNTEhBQVJkQ01XSVd4SW4wbXd4aUR5UUhh?=
 =?utf-8?B?L29QRlRhQ1M3MDc1bU5pR1c2Z2s1RU9SYUdRWG55Y3RZLzk5QVVLaEVkZlVl?=
 =?utf-8?B?eExOd3Nnd0NFUm9DQzRsQk43eS9MMUZKNVhZamdYY3VXN2l5K29FVUJld2k2?=
 =?utf-8?B?WnZZSUhvZDA0K09xeGtya1FLb2l5aDN1UTNNOVQzaE0yMFFhWFBoSzFCc0pQ?=
 =?utf-8?B?dXc0VDdnTjI2SnpjRTR2M2l0SVZDK0JyMis0a3dENHhjOE4xMnk4SGJ2Rzk5?=
 =?utf-8?B?aldabnNlaDVwelNKM2JpMUVsNytwLzQwVEFuYlJDd2dDWlVVcjRBd0lLRC9E?=
 =?utf-8?B?WGtjdWppc0Y3QWF6bTJQaFVyL3FhNkhLOHkwc1lNVlF2MENVYkhYOEJzd09I?=
 =?utf-8?B?L3hPZ3JMbUF2Z01nWWduQlJHVVFsVDU2aGgwSzFBaWFKOC9kbU9TckkyMjlP?=
 =?utf-8?B?cUErY3RubnhtOGlpSlpOWk90b2dkbW11QUJXZVZjWWlWWkZoMU5FQVl5ZFNu?=
 =?utf-8?B?T0JEcUdOa1ZzN0UrbTJ6d2w1MDVobnUzTEUvcnFNUFZPZUdxQ2hxWjNVeFlM?=
 =?utf-8?B?SWZoQXJuSng1RXlVb2tOMEVBZ0l0R0gyM25JeDduWGlrckpqZ2lsSUE5NlJx?=
 =?utf-8?B?ZUxSTWxWVzV1NmR0OU1ZayszNlozSmdaeCs0dGg3V1IxQlFRY1FxOUNnbDNP?=
 =?utf-8?B?NmNxRmhyZnZLNlZlUUhWbmNZVThUWUZXcWRPaTNBU25wMUJtcE5qekRyOG4v?=
 =?utf-8?B?aFIxV0RoS2t0RjYwZzBtQVZ4U3VOTmUwbTZacWtlSE94NjBDY21PNURuWlBL?=
 =?utf-8?Q?7IZnGjFKK/6nNbXUs1virfSyNtpnoiuQE6EyX7XYEJkf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uV5qWlSdIMQS4noLwujM363SPRrBvYlf8H5cLXonCV9PrgQw663wfvR4YS5PhBQJYTqXe4UxpVXXYh4pzKVjY94f5hfJrs59fQaWuuRS96oS9Fbnltc5CKv5nIgCQR+D330B67GIiH2FP6jNAyES12AtjkmjhPI1ISlMexNR2lrKHE6JiQ2VPTAH0RQqVkrHmz4wbYs1Xn7+JxkNvshQerVl8cYKzrY7Q1sqxu4aMRokcRHlAgmP1OGglnrA93tGylmrhM3mWYvzAFsUaWJu45fiAhN9MTPLTViryPFxA8i7LR9OyjKa1pUvItHyXd5TUIlbn84wDm/zmat5FPLsqcMEVW5tIc8AufmNe/8kZWN0dj0xBUuxxKlnoE28EhLCYlGYXxBC+G9urYnMoBKBbVRA/foMtJpK65bmQG9umZL6mxR4jLmcroRGchI4jo6hZcHyH6crreE2sZd34rY6jQnHx2mRlm+zgLX1IRiB/TZ6I1VB2ADN8C+cHTz/Gvw+FXmraa97b90ZgBQOKWkt9uqhzSzDSyxxcDRsGM5PDjl5MDRHJ+rqcXtlwKxDzWbaJeEckLQtH2hZGAE5J9LAdE4S+LI3R324CoQt2REWw/A2L9oARgyRcEeOAUVgFEWvg7q60RHOkM2Y1EpKk1kdbRy5tAwoSI0mlHrV4SQ8I2Vi+qMD8+I2ODqqEgbSgv7U/fCazAVAT+V6MnR5Hztta8+NVldBQPdgc2iqZMj8E12Y785blZMLSpy4wpDiVXsmbeYvC3HKs9ufDb3yRKZzFUuGDPiK0SHJLoG2JJ38lbVB20chEG+cNXZbaRit7WgnHAipKfS+QYCHVi/lyGfs1Xav8uwwC8HvlnlDNP2sggjeFWGvdjPkzLzrln0XbcGF
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0890025e-29b7-411b-3da5-08dba3705613
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 00:31:48.0737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PtJOTp3mTJ7C6p3tvaGCx79FzlnrXKiR1I15Agcxe8QC5iCw9SxcDZDu3ImnCs0cxeUTLA1L7oYwTMNnyWx1+Qey2xzChAZXQxo21ZUyzOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4580
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_22,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230003
X-Proofpoint-ORIG-GUID: 4MVZtUECQiADyEuONMU3ha9FEnLdS3Q9
X-Proofpoint-GUID: 4MVZtUECQiADyEuONMU3ha9FEnLdS3Q9
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=stephen.s.brennan@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Stephen Brennan <stephen.s.brennan@oracle.com> writes:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>> I am a bit reluctant to change the dump format by default. But since the
>> flatten format is more "complicated" than the "normal" format, perhaps w=
e
>> can assume all users will handle it.
>>
>> The change is probably late for 8.1 though..
>
> Thank you for your review and testing!
>
> I totally understand the concern about making the change by default. I
> do believe that nobody should notice too much because the normal format
> should be easier to work with, and more broadly compatible. I don't know
> of any tool which deals with the flattened format that can't handle the
> normal format, except for "makedumpfile -R" itself.
>
> If it's a blocker, I can go ahead and add a new flag to the command to
> enable the behavior. However there are a few good justifications not to
> add a new flag. I think it's going to be difficult to explain the
> difference between the two formats in documentation, as the
> implementation of the formats is a bit "into the weeds". The libvirt API
> also specifies each format separately (kdump-zlib, kdump-lzo,
> kdump-snappy) and so adding several new options there would be
> unfortunate for end-users as well.
>
> At the end of the day, it's your judgment call, and I'll implement it
> how you prefer.

I just wanted to check back on this to clarify the next step. Are you
satisfied with this and waiting to apply it until the right time? Or
would you prefer me to send a new version making this opt-in?

Thanks,
Stephen

