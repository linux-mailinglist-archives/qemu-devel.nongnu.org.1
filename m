Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D0480CADC
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 14:24:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCgFx-0005GK-R8; Mon, 11 Dec 2023 08:23:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rCgFv-0005G8-Bm
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:23:31 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rCgFt-0000aG-8e
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:23:31 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BBBn0fP013605; Mon, 11 Dec 2023 13:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=g7MMDaCH7JmDOLTedYMpNK0/T57h0bZ2VC0hYhPKU5U=;
 b=OkVFsvM7uZZ3AUPn3kIEcgYZhNXy4+aLMuZixy+OiduF5bQickXpJMrD6HAYY8XqJn6i
 fGXdB//00pyQo2UQQJNo+tRVbOMLPaUZxsQ0XfM3T+h8r/ThuDNogC20gQ0UPDRDL4ds
 bBbSurvTaLrTDvWTVdBMxr6aXQE/OJ6cQQ/cRdoBMtUEL6RAiGmds8FtCuWLv8UVSSlm
 bjJsHBPQEruB2STqXwQFPWjeWNMcYzDEm6WmXFKiTEYz2EghxTieIfQlzS7o7oRmGb3U
 9n7AvswU4x3QlJapgvqARU45rt2PU/UZpQotH7v2S+rkjth+472vrmVJHrtPxDe/ZSiI 8Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuu2wef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Dec 2023 13:23:20 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3BBD26lW004375; Mon, 11 Dec 2023 13:23:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uvep4wdd5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Dec 2023 13:23:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3JkicpTjGyVWltDnnZhz87amcVtwDfVCPOvpoOfQ34NUy7eAd9mfinYytNdK61aleb9fkcusEcGKQaahP5OV6/R4sd6QsRowk59Yhesp04mIUvlRfErP4g1+cJXM8yk/N6xEmnMRelLOON7fnuc1r+vpe3rvOx2XLpL/jk5LZmf6topl7otfx56kRzJ8Midb90H30A+f8ZqELF2+nkJVT8HrSULggBaa5LMy1IWh++4kumLs31duIoCk3hno3+rdTgfHKIcUjhTwW7qr5obCGvOqoORwocxzRUdS4+vLOmf2fsKpG6TsSa7NgkJ80MmNO3ymN+lnNpQ2s+8auOg+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7MMDaCH7JmDOLTedYMpNK0/T57h0bZ2VC0hYhPKU5U=;
 b=IDzYc6EdU63Ba/6VOfNkNmqIvQPaQRflnuF/PHsaXJQTFnOA+C+Z+EhSqOct2CqPaVZzIkEaEX4LrA7aDlfxliOGHe73et0U6hSyn/UEnuSzD5clKJNirtyMkXI+eFWwbZgzQRATNaR4/l/jBiQAz6Ihx4eBZUw3aorE76IGTndzFZSTMBBmgsU09qdBeoZQWwfJQshuvWTp7ybdUuvUrrrPzucSKEybMHCO+zYJKqyHrN+EsfThYoWFL2XynPWihQFicKBKVaErkTbomEhSdpZs7l3sKR33fXCL+UIcygAjk7pWti2ildg/Bu/slrGcsCCksJrPq1Ga3IGTWpGnRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7MMDaCH7JmDOLTedYMpNK0/T57h0bZ2VC0hYhPKU5U=;
 b=qJecBYIxE2WDRw2S+3E8hi3EpDX3Zc2XppZPPU6x+5BD5+DrGgUa5csi2CLF0yBdvmIy0W0asKvV1cpsmI9mLOk55ygWDmYZaJB5fRVbcZBkmwxI07P0FMH22fycJs17nKM/rXu9Pf/rUAWWYkZhPZ7IYZgwjj9OYMn3sfIqDzQ=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by MW5PR10MB5740.namprd10.prod.outlook.com (2603:10b6:303:19a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 13:23:17 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 13:23:17 +0000
Message-ID: <1215e673-83c0-403b-b01a-50d7da756ed2@oracle.com>
Date: Mon, 11 Dec 2023 08:23:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 05/12] migration: propagate suspended runstate
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1701883417-356268-1-git-send-email-steven.sistare@oracle.com>
 <1701883417-356268-6-git-send-email-steven.sistare@oracle.com>
 <ZXawLKhxgJiPYfdX@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZXawLKhxgJiPYfdX@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::29) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|MW5PR10MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: e0536bf4-be2c-425d-1951-08dbfa4c561f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJV2rxsbzhQETdgJH3nXQPaA79eye2QPVa9wp7pDkllT+pAtOLO+P5XkklTDOuLsudbKMbfxynb4Tt5uznQObpBjNWRNJglqdUbjAjBCbkDOsrP1KYpwzE9kqqAsQwf/lzfOIOlRGOnKOkoZZMst8r20dzYQPAEIlU7PnfKUGZGXgDaes3d/YZzTYjvyCfku89TNqFdk071M1WW8CwO+SxWSND12/p63zyTbXLIK7KefpbdwpdHAsJxD5Utl7pTHDUannfKUF4JGvZLCer+u6TMtSva7AeIm61+GqN+wLu/1R8wSEwTaEmRG6K2xNFkp7vh+pNkBO0Iid8ufaCw6Z1TrjkEKodfJr8KJ7V/LWylSJtjmOXuOGt/5mITmOS64A9EZkL5h8kWYmgdXqh+Bv5D6E/WYqzlYSs5KbfHKGgpb/pTq13eMTHdBqmdg6VvkXjKZ/IHmMABCPvnur2ch58pRPKvf8N7eqf0ilI8AbjcfHe35iE3KJ8UmGCx/TlNXONxqoNQt2QJ9RGZzQadCzEC6oYWvX3pR3MDGyucflNQTMrzS1CtCJewEtqnfT4fHnDfNkoM1ddSFpNiRrjxbDQbR+0GsiigGh3gxHbGcfCI4EyIkl09U9vGqxFRE5Mes3uvQY/p39yGaEopMsuNXAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(39860400002)(346002)(366004)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2616005)(26005)(6506007)(6666004)(36916002)(6512007)(53546011)(83380400001)(5660300002)(15650500001)(44832011)(4326008)(41300700001)(2906002)(478600001)(8676002)(8936002)(66946007)(66556008)(316002)(54906003)(66476007)(6486002)(6916009)(31696002)(86362001)(38100700002)(36756003)(31686004)(66899024)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEZvbEtNRFBCLzdWa3NRTkZPNG5lZGMrK09zOFhRZ1NybVhRS2dKWVluVlFI?=
 =?utf-8?B?b0lkYnBFNEhNRk1pazVOT0xCZ24vdWNnQlZnMDRpUkg2czROTloxY25wZndH?=
 =?utf-8?B?RTUrQ3VDdlNOcjlpUzdDcFI1L05OUXFiYUZ5M2JFWVF5UW9UNFkxeHJidGcw?=
 =?utf-8?B?UmJQVWV3K2dZSngyQXoyMnc2eGlibnJ3L04yZkVVVGxNZ1JGRERibFB3NjN4?=
 =?utf-8?B?cGtrUStpV094VnA2MnZoWFhYTlZ1KzNIanVEUktBbldrNmJMMWgrUlZMYzJo?=
 =?utf-8?B?Unl0aERqeHEzWGdWRnZjakhZSmg0VHgrblZkYjFXRU15RUhyYUkwMDJOYWJT?=
 =?utf-8?B?NnZCSWRqRThJeHZ2c3o0TkcxZlFUNkx5NXJNelh5UVZEQlc0SHZSdmhlaW9S?=
 =?utf-8?B?U0JYSHIybm1Rb3BHaEp2ckM3Yi8wRUVhNDhTeXVkNEhiMjRISXZTQUlyeXBn?=
 =?utf-8?B?NEVTV2JlUTN2NHlNMm5qcUd6NjluODF3eW5rQ0xOVXhIdEtzSENSclc3L3Qv?=
 =?utf-8?B?dkxMUHo3bnpobGxRelZYN2dRdlAwRzE2akVndlZlU3lXT1FRSzV2VmJRcmZt?=
 =?utf-8?B?OUNjbTdydjBuYkVBcWxLUjh0cFFLTVBLaGVkdkx4cE1SZTd1V1RDenZVOTVV?=
 =?utf-8?B?SVR5YWw0SXA5Q3FGOW1nTjlSTk11NGxUaytJUXpiNVozekpuSForNFU3Z2t5?=
 =?utf-8?B?VGR1ckVqdXRQQW04YURXMG5CUUsxc1RQK3VKZzlmSFRWWitPd1prOHR2ZkJU?=
 =?utf-8?B?NFRXcDY4Qzg3QWR1VWkyV2VDU0NoOVZZUVlwdFd4R3BRNGZTL2JZcjFka3VD?=
 =?utf-8?B?eXN5eXlOMHJmS1ZMb0tDdnAzc1YzNkZ6ejRJdjR4WjJOK2ozN2JmVHNjTnZl?=
 =?utf-8?B?K2lpZEF3U0kzdzJ5WE12dmxUc0VjeVZrY2NPdDQyWVJSd0NtaFNSa1ZuM0FV?=
 =?utf-8?B?MmpEVnNtTWpzTWg2YVBaanhTdWtwSFBqdUMzalZMek1ySHdYcVdlN1VIdFUz?=
 =?utf-8?B?SUl3SFFmUXFCTjhaSDNIMUZWb3NmRjdSRHRUWmQ0QS9LQVdLNGhQTlJsRkJn?=
 =?utf-8?B?dStMUnFzQmRsUzBISGRhbWlIYVRiQWpIV1hjVWRlVFhDZy8xMVF5VlBSaFZ1?=
 =?utf-8?B?Rk16M2YxalBHbUc0eHpZMjUwQ3RuZk9XM2VlSVZGcHorRklXUVhkK0lGVGZ1?=
 =?utf-8?B?ZkhHTGVOZ05JbW1iKzVoMG01RkRlY0Z4UkhoTU9BOE9LcEVhL21SeklCYmxX?=
 =?utf-8?B?YjE4MkU5VlRlZTlGSitub3hpbzNqcWZNYWlFa05KclBWcXBVaS9sZUU3NlpR?=
 =?utf-8?B?MDJFV3lsNml2UDQyM3pMc05oWkF4ejBYYXdDSlZOZEVaZjJjMWRBYjlKT1Vt?=
 =?utf-8?B?WDhQZmFtb1F2QWxVdEJxZTRUMVZPZFZoa0ZleFdMbjZ1ZDlPeFAvdGRQdUtT?=
 =?utf-8?B?ZVJIdU9EZ016K0cxbTNTV1NBMXd6UkcrdGhTQVlMV1p4K1FuQXJra0pVTVJu?=
 =?utf-8?B?YTdWbFF4Y3ljVFlReG83UlNmWDYrY2JXUE5mQ05mUFo4TlpJbzFyMldKTUZG?=
 =?utf-8?B?WUFRRG5CVXNqaDh3ZyttR1JUSGlhckNkOUNGTkhNdElOVjZQczVEcHNQVlJN?=
 =?utf-8?B?Qm5BaGhxek51S2lBTjRXY2JSUWhld3phSCs4ZmxxSjNSdWh4SkpIaU1NME1P?=
 =?utf-8?B?aDZBNXVhcFNzc0dySDhzaStNSitMTGs0eEJIeGlib2NZNytEM0h4TnFzS2Vi?=
 =?utf-8?B?RS9vMjZXTFBZU3FyTE1wRkhMaG9ldGM0NENMSjdIZjZGU3A0TVoyYW14Zlph?=
 =?utf-8?B?T2tSYldvc25IVVhYQmpVZmhLbnBXMlVySVdlYnBIRTZDbTlLSDh0ME9xR1hP?=
 =?utf-8?B?SU5vaXpORnpiSDhrNjN2a3BEczlra21qMGJhY25GQzBDU1hKMjNNWHdlWTJ3?=
 =?utf-8?B?VTV3NzFPNDRQMDlJY2sxUFFnVm8wRkFPWTFTN0U3Y3BHQ3VWbkNrbEZOa1g3?=
 =?utf-8?B?eUEwVlM5MEhFbE94NXFPWWdOUzlET3JQZ0owekJ2SHlnenNQT3FPZ2N3dXNV?=
 =?utf-8?B?K0dMRjJJWkYyQ1ZGM0xiRkZIRkN6ZmRGZmcxc0ViVEQ2Q2VmdWhRUnp3WjE3?=
 =?utf-8?B?TDZUVUNsYWwyRUpBRmF2RVlEclhJY1o0ZzQrYUhqbklTL3hFb1hFTHRyQkZq?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bpBzGVPQk7xI+5gp+i1icA+QxTt5n+wH/ofzA/Ky67DZ2vI/oPUdBAsL/0bUvV2OdDmlUH6BGoH3f6F8Na+9JC0/7zVcJRKuGh1D6V1d5LE+e8tG/Rdb+sNSdGrU5o97kBZdCwPNIQEb/TANXdRxZpmUZm2FWuNqZbZSY+MaIrDmGvXq94NCpsRD+OlnCY0/rQPspKvYgxBPcL6c69xO31kn3YUXwJ1EsIPC4NpngexOsxhJxTGN7OB+5ULmJD1d9YfPZbvmUuFEL0yT9xO8wyOhSiSw9X0y9NzAqeUY6xAqJHPNXNOcM5aNp4RMJXDpYQRZJtpTIHqKnVxSS4mQwMej0aW8j8LzqWn1q2c0RaoB4Hpk4MiF+teMzcGZCUG03IC/TLtC7CAYb1Z3QnakpYIV5oBgxrAhFby83HfGRyo2vzIb9WuwpZ54WUxMPt0aSJEILng86ON3PYOec6B+oYcCGkH8ORGp8jso0VqOypmZzCExaFM/Z5AODKkb0koY2f8V4yjLAB13wBNY7KzopceMnQGZ0NtRJ/ROJ/LeJicf2wUUkzoKtKIbhXDxWEqH/4ldt6QcCdV1l6DSzx9kyx922dPr4aQszb2k9GTf8covt1s+ejhd6uRHAzohnx+DYOgHkeOyvvhFr9783vdFXc9KGcJNWGQ0lMEpvzMiNq+SCWS628Fy9NbkM7nmBLrQGZRrYR/WIRken+OlVEMTFUyAi6fiEXlz/oFTKtj1uEvD3AhVob3tQvUJ5OGFxPq3dK7QS3NRe9nPUvI6VNKKhRD44YP1RAixA3zEbeVGm8U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0536bf4-be2c-425d-1951-08dbfa4c561f
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 13:23:17.3426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23prtiiLL/CTscKYqoDNReehyxRAdCIqcFFbd6c+zUTD+ia8xb2+HWcZjlhm3sl+kIBfmugtjQeMoepi0LONf6jtlFDHDQ2937LnleLDEgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5740
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_07,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312110109
X-Proofpoint-GUID: SUrmC42jEUl3NiIwPg5wA1lzPzYnkNfU
X-Proofpoint-ORIG-GUID: SUrmC42jEUl3NiIwPg5wA1lzPzYnkNfU
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/11/2023 1:46 AM, Peter Xu wrote:
> On Wed, Dec 06, 2023 at 09:23:30AM -0800, Steve Sistare wrote:
>> If the outgoing machine was previously suspended, propagate that to the
>> incoming side via global_state, so a subsequent vm_start restores the
>> suspended state.  To maintain backward and forward compatibility, reclaim
>> some space from the runstate member.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> One nitpick below.
> 
>> ---
>>  migration/global_state.c | 35 +++++++++++++++++++++++++++++++++--
>>  1 file changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/migration/global_state.c b/migration/global_state.c
>> index 4e2a9d8..d4f61a1 100644
>> --- a/migration/global_state.c
>> +++ b/migration/global_state.c
>> @@ -22,7 +22,16 @@
>>  
>>  typedef struct {
>>      uint32_t size;
>> -    uint8_t runstate[100];
>> +
>> +    /*
>> +     * runstate was 100 bytes, zero padded, but we trimmed it to add a
>> +     * few fields and maintain backwards compatibility.
>> +     */
>> +    uint8_t runstate[32];
>> +    uint8_t has_vm_was_suspended;
>> +    uint8_t vm_was_suspended;
>> +    uint8_t unused[66];
>> +
>>      RunState state;
>>      bool received;
>>  } GlobalState;
>> @@ -35,6 +44,10 @@ static void global_state_do_store(RunState state)
>>      assert(strlen(state_str) < sizeof(global_state.runstate));
>>      strpadcpy((char *)global_state.runstate, sizeof(global_state.runstate),
>>                state_str, '\0');
>> +    global_state.has_vm_was_suspended = true;
>> +    global_state.vm_was_suspended = vm_get_suspended();
>> +
>> +    memset(global_state.unused, 0, sizeof(global_state.unused));
>>  }
>>  
>>  void global_state_store(void)
>> @@ -68,6 +81,12 @@ static bool global_state_needed(void *opaque)
>>          return true;
>>      }
>>  
>> +    /* If the suspended state must be remembered, it is needed */
>> +
>> +    if (vm_get_suspended()) {
>> +        return true;
>> +    }
> 
> Can we drop this section?
> 
> I felt unsafe when QEMU can overwrite the option even if user explicitly
> specified store-global-state=off but we still send this..  Ideally I think
> it's better if it's as simple as:
> 
> static bool global_state_needed(void *opaque)
> {
>     return migrate_get_current()->store_global_state;
> }

I agree, I also did not see the point of dropping global_state for some states.
I will simplify it to this. 

- Steve

> I don't think we can remove the old trick due to compatibility reasons, but
> maybe nice to not add new ones to make this section more unpredictable in
> the migration stream?
> 
> IMHO it shouldn't matter in reality for the current use case even dropping
> it, as I don't expect any non-Xen QEMU VMs migrates without having the
> option turned on (store-global-state=on) after QEMU 2.4.
> 
> Thanks,
> 

