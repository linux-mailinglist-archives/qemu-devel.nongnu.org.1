Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D44BA36242
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Feb 2025 16:52:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tixyR-0001g0-EQ; Fri, 14 Feb 2025 10:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tixyP-0001fX-2J
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:51:25 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tixyL-0004so-RV
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:51:24 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EFBYgJ017845;
 Fri, 14 Feb 2025 15:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=cSSgJINe4YEI+HG/WuDEiAEplAcolQQgbgUCN3WWIPA=; b=
 euueEl+d9h1W4r8iljUHzRQZPG0ueGZaoH22OyLvTXxiosrYITG4dYF6djKoHRTO
 eecF+3bBlvLeudnF5gQEXhyN1Kx28t4hiKYN73B91qy6UCHEMmRP5/8kBFp9cwZL
 QPYEFAlOfL8otoIEgzNAhGJ+rA2t4H6zxU3uOE8gfJ2hKYmlejgFH3MBFAvlQY1t
 UQV4CyfNv+WvrpewdCkdK6LJZFWgzOXrK3kn6U02iDWx6O4IQlpclMA7pThuaPUu
 7mL7hBBfLgC7Mm8NR+xMs5ojErjE8b8vKKZw4C6W4C84H2+PC8dal7To14anlN8e
 ZsjPQy2i0dh4wCXl2djGrQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tnbuyq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 15:51:16 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51EF5lYC005135; Fri, 14 Feb 2025 15:51:15 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqd9epn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 15:51:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwq5f8RfpEAIzt2LUrcSkyBVA7vZaYv6l93PG2r18sfLlvFHVGnVMsTL+2sRwNqylXQVoGUznKy992is8HZPPfnwb8Vz3M96CrZEsg1z+0oSgQLmiVFMQWB1IdtMIckrXsHwt1qHl/Ah4XsylxU7jTVvAP5+ptChAXKjxOEwrB35nuzKDKRTmwCnDbxZeD6yqV7UeSWe32WqZi3Jr61XbGcHRC5qdbog3Ir5gpGBmVMeCnkjTf20DoOMOyo3dW+3e7Ga+2j/lbl3VJtmJopwcXh2fyBJkVU2kqy4tCsihUW7QUNFBZABXHLlh4Z6cgXThZGxt62H0zzdbDg1FseYLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSSgJINe4YEI+HG/WuDEiAEplAcolQQgbgUCN3WWIPA=;
 b=H7InMKzRpx33Otcb+351oWym76qoBT0ZHOLgvTHF/XqZJNn5FRLE1M+DQF/As+ADidrizusDJcas/hzOhdOlc0Us4lbYxzfHmdkoGvtzQSxA2DJ11QX0DiFcMb0TXPKnt3ivaiiptyjTN9Jlv0RMwMXVZxGvZGbOPiscmSnxs+bqvPv6iHQbcKQchqdm6XIjxWn/7cuEnQ/UIcmVaTxWqWEyKAAhKkF1FAlk4aRMfnG3pD2WBwhnQPRisi+kRUmWI/rfcu2YAm02+CTOr2Roj/uYl/lf4hkZ2rCyD0uohJFr4PiAZHGTiXNTTJAKRmr/q59l3jHW21MxNvYmYWH17g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSSgJINe4YEI+HG/WuDEiAEplAcolQQgbgUCN3WWIPA=;
 b=qClQLML5RyIq5apepCCjslpRMLn28e0Uk3Is16WeVEU8uABMnsUyKxjgIJ4G1GdoZdBel4qz2aYYsRwcPpX0+8yaRHBXuQpTKw4votRNWZnqhZxdcQsOu7i3GXVtfHzUYXlrxGifv1x5WonzpZQvAaTAGmE7pa6qiAZs65TqJ6U=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH0PR10MB4535.namprd10.prod.outlook.com (2603:10b6:510:31::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 15:51:13 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 15:51:13 +0000
Message-ID: <a52c57e6-a9cb-4c5b-a81c-9ba43023923c@oracle.com>
Date: Fri, 14 Feb 2025 10:51:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 26/45] migration: close kvm after cpr
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <1739542467-226739-27-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1739542467-226739-27-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0484.namprd03.prod.outlook.com
 (2603:10b6:408:130::9) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH0PR10MB4535:EE_
X-MS-Office365-Filtering-Correlation-Id: 53fb54b8-d459-437a-2f9e-08dd4d0f686c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REExSkdQbnRrNTBsSUl3WjNxV0krQmpTTEhJRWppOUZ6UGxHanZTSHREUGFu?=
 =?utf-8?B?cjBMem5nMEh2RDBFbFhocWRSdkpYbys0L2FDbkpyWjRzTHdkN3E1eXdLSXVN?=
 =?utf-8?B?aVFla012dHE1eE5hb01Jd3dYZEVMcmxna05NSDZ2MTRRRnBTMmRKNklIeDRE?=
 =?utf-8?B?Mk1jeWZMekJhSEcyc2VZWHQrTzBKcGw2UktMcGdaTmR1L1kxLzVNY0JBbVZW?=
 =?utf-8?B?UWFIc0x1eWV5emNIczZEcTgvRFQvcGVOSHNrYWVsYXJpWkVPc01ua21PcEhQ?=
 =?utf-8?B?d1dTMWxhWEhLeU5Caml4NjIxNHJwSGRsVENyL0xjS0hic1p3SUZuVVM2azdR?=
 =?utf-8?B?U0ROU3E0N3QwOEt0M0NWcFpaWUpSUzZDY0h0aGwwRjZnUURSS1I3MUVJcG1n?=
 =?utf-8?B?bnhJRmwwSE1KU3htQnQ4LzM0UWZLNkI5cnAwdkxTeTlRMm5Rc3h6Zk9JeTJY?=
 =?utf-8?B?dkY5Z2xHSlljT0RwQUZpV0RMWHN0bTQ5b20xbnoxUmpmbHVKMEN0aVhLU2s3?=
 =?utf-8?B?cE13cFhlSXZQcDhpQ0dBNWNWM3lqT3hvSVNHbFJTa21UQ0VhcU9UZWxzalFu?=
 =?utf-8?B?TXNROGxvVXNJbDJNWkltWUdpV1dYN2dYdlQwREpJVmRYbmRFVEg4Yk9IaE95?=
 =?utf-8?B?K3ByWTRSd3kyS2d0MU45VzdreFhudmlYMEwyelp0U0N3RFk1MWp4MXVURGVr?=
 =?utf-8?B?M3RIWk16QWN3Z0ZWczJjdnBTay93UU9hY24zMjhpZGhaZFFFMHpwMFlrWUR5?=
 =?utf-8?B?RWdNUzZzMU80VC9sTjNZTFY1S1lsMDhJQU5uMTRuS3RHZWoxdy9ybFkyOXBN?=
 =?utf-8?B?Y3dabGdxSUV4WHdiS0thRVd3djlITndyMFFSY3NvUk1OWXpFdDZUMllicjlR?=
 =?utf-8?B?NTRFR0UxZVpZWHNKUHdWRGJ6YTZiZDBrUjJQYUw0SUFRWU5paEx4RVR1ZEpX?=
 =?utf-8?B?Umo0MGhOdk82VGFvbnNEbUdldFI5bUlkNzk0ajkrR1Rwa0lrWFpYaFBxdU03?=
 =?utf-8?B?anlWQm9YbGY1eUQ3dFhUZVVYZDNJUC9IeHR5UTdYMC9TWndVckszTTVCbHZO?=
 =?utf-8?B?SXN6b1J3OHF5eWR3b25CSXlLbjQ4ZjBqZEEzMGR0Z2ZEZm1GY1k3UGtqdWlM?=
 =?utf-8?B?SkUvdE9nRnY0eHE1eW9CUGZJU1h2QldOSlZuSy9OVjhtVGZvZ0t0Q0FUempi?=
 =?utf-8?B?cVFWWDJXTGlDWk1jS0l5RjM4OGJQSXBjOTgxb2dwWTBNRmwyeUdDbXliNngw?=
 =?utf-8?B?TEVsb1JPOUFhSVNFUDZ1MzNxaUE3ZHBNREtURjFHb21KdThHd1pvSUljWWM5?=
 =?utf-8?B?TGRxcVQ0cytTRzB2T3J4VXZtTkdaa1BmdlZvWHlPa3FXUDJueG9DMnMvTGpI?=
 =?utf-8?B?YmdLaWNpL2NjNVJ0V055di9rMmRNSXpJcmlkVFNYRi8vQUsxazVaN2dtbVpO?=
 =?utf-8?B?bklER3d6Q1FWN1kxMy9xd0VVbFp1ejl4ekNNRGRXVDB0SC9ySVVZUTdvSXRm?=
 =?utf-8?B?dXNlZEdhVk5NQWdFYjUvemtnMmRoeGRqQXQ5ajQxMlN3OHZacTFlM2d3MGZG?=
 =?utf-8?B?OVl3WjZ6MnIyOWFEdmRmUmNGdzJxbEIwSXNVSnhBQ3FQWjNPS0RiU2N0L0xl?=
 =?utf-8?B?OVlJMGRXaUJpTVh1K0pBQUhPWjhCbGxsRFNuU0FIREhWeVlYb3l2YVRSaXpj?=
 =?utf-8?B?OHhxTVdyT1ZxZ1hHN0dvRmJoUllqVW9nOUVXRUFzNEZZS2RkNFA2bThyUmVB?=
 =?utf-8?B?SzR5YS9IL2tWVWJDS25ZcWs1RmlTdU54Y0x6TVVDbFBDekM2amd6L2Y4M1hx?=
 =?utf-8?B?S0h5Y0dNdk9NRlB2VWtrY2Vta2JHZWFYcUlxNFJ6V3dxMW1uU01WSnVLWk1s?=
 =?utf-8?Q?YUFEMuLDOYFBy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MytOYWd3M3NQQUpzVXgvQ0JlRzlBWnJydGJ2UUprM0tSZEF0d0RzQnJHQ2lC?=
 =?utf-8?B?QXdnWnJyNU1ZSlErZk4rNVpNbDMyS0ZYMmxuRUQ2WG45QlorQW9iOFk5S1hP?=
 =?utf-8?B?RjBwdGdPY25JNm0zMFNCcmkrOEZaNXIvZDNBeXlBUXVGRS80czlCOTBjd3gy?=
 =?utf-8?B?aE5ESjE1djJVQlgyd3dBc0VXc1VhQ2luUyt5OTFBVVVaV1k0NHdpdDd1ZlJl?=
 =?utf-8?B?WHFtN1pyUmVDNXV4YnN0SnNaOUUyQi9ENTlKeDR3MUVBUU5uR0FoVW9Gbksv?=
 =?utf-8?B?RDFiWXUzUUI1OW5wTzJwNWxGUGtCdFgrS3FKbUtkamorTlRDdmRmcCtrZytz?=
 =?utf-8?B?NzJTRUVJRy91RUNlQmJJeHF0QmxEZ0ZGVzhIbDN0aDQ5TU1ManFmamQ3aWho?=
 =?utf-8?B?S1o2N0JaM3V5Z0RWS01QblBEMzNIZS9weTJOeGJOTk9vMWdGRS8wWlBNOU45?=
 =?utf-8?B?am4wRmZvUzZUY1Y0a3VPOSt1THJnMktJeWVrbDJmeWE1ZUFNRURxcHNSdWg2?=
 =?utf-8?B?ckpRbU5TKzZIYTMyeU0zeWV2RnlmUkFIaW9TdjluRFFrZ2YzUE1BTlJrUEgr?=
 =?utf-8?B?VWp0VXVScVRjeUc5bUFDQUk3bDhaRjNicW04MEJOZzc0TzI5ZmpIeDg3NFp4?=
 =?utf-8?B?SGpwSnFZdHU3YTFFQzhDT1d3RStuOW9JM2tlcXFmRlRQZG1Na3F3Z25xdFdR?=
 =?utf-8?B?NWVQQ3BxNFNtcmZ4akJqLzRDMFJCZ05ndWRWTllmTVI1YTlJTUxncnVyQm5S?=
 =?utf-8?B?Y3Njano2RmYzUlZ0QWNoem5GOTZiaC9JNG10cFRVTVBxdzJpZEI3YkYzeHR2?=
 =?utf-8?B?VXcwOUEvNHhPc0hldGNvZlR2dTlGNzVSV2xhVXZoWVcwb0hZVWNscnptbmp5?=
 =?utf-8?B?aGQ4dko1WVBjUWxEYTRDaStKM1ZKUXlPTTl0UE56TkZVOGc0UDdiNGR3MTNa?=
 =?utf-8?B?bWluRW9Qck81ZnVPZzFWcnNoUWVTdVpZbGUrWkUxSkhEeTF4ZEwrNzVEUGQ1?=
 =?utf-8?B?RTNiYWpmSnZMekRMYW1tTHlVVkZIK05BY29oZEFLeEZ1VGJGUVhjMjYzU3A1?=
 =?utf-8?B?dnYyR2pkRTZzTWQ2eTRtL1pCUnFtRThFZ0ZaWTZTRE1weUFnUklyTzE4ODNV?=
 =?utf-8?B?N291WERTT004OThUY2I2ZUM0ZW56YjBLVUJUZkplbndtN2xJbTFYR2djR3hW?=
 =?utf-8?B?N0tnNlNGaGxPM09URXQxcXZlWmxNWEE0MGJVUTIyclNha1ZJYzRKNzlFSCtk?=
 =?utf-8?B?NWVleUkzdUVBRmc5WUc5YW45dEZDMVNuTXhCVnJPTzI3cFU3WkQ5eVJ5M3FG?=
 =?utf-8?B?S05IREhlZ2RzbkQ4eEx3NkpnSFM1T0pndHFpaWFBb2FiYmJWSzUzZzFKMXgw?=
 =?utf-8?B?bE1BMkdnV1d2NldkdlV6dU1ycmJLa1dtN2ZJS1YvaG10b3pPL2FRRkJndmF1?=
 =?utf-8?B?MXl0dGJyWHE2UDJuc2JIUGo2UGRkOWN3eG5FVmFKSXU1N1BxdXdTZGttY0g2?=
 =?utf-8?B?Rmg2QW5nUkpsUXRERjJ2U2RhNkNMQW9YdTRGcmI0eUtQZXBjVXRhaVBndEQ0?=
 =?utf-8?B?emdxVDlQUmJ0dVJPbXZ6aDlSaUJHYnF6M0NRL0lLcy9BaXpXUS9TOHBiZmFh?=
 =?utf-8?B?M3pFNnBWYU9ISVBOV09Kb0FKNUI5ZDNsaXB2WFl1dE5nZW1Yb29Ga1dVaDNZ?=
 =?utf-8?B?Yzl1cnh3akp3RnNGMGU2WkJHY2ZlM1FYSU1OQU9qUUJFM0FhU1c2bGhLSDNF?=
 =?utf-8?B?Z1JLa3Q0Z2dSREhOSTZxWUllb0I1eHd3aHB3dHdxTllmWHE0MFhRWnhaWnFl?=
 =?utf-8?B?OTdQeERacEpzaVRreVJ2U2lTZXBFdnpDdjlHUFFQRlM3dkZId21xcUZneUJP?=
 =?utf-8?B?b2NUdzNQQ0h3dkNkQ294VmkveDdzbDEyTCtXRXkycHhwOGo2V2kwRWVXbHBM?=
 =?utf-8?B?MFRZbXUwUGMvNVZSYUJYeGhSY3lpMk1YNUNzcWlHM1k1eSswWEpoV291ZWRF?=
 =?utf-8?B?RGtaZWlac3dtaEE1MS9qWWx2Ym5wOTJaaFljQVpzNlQ5RzNjVUoveXBaVmZW?=
 =?utf-8?B?d3ZxNTZ5MmJna01yNWJDMzRGSUxyUjVXcThWTlp4bk9KaWJ2djJ6TnUrK2ZP?=
 =?utf-8?B?TGpXbHR3RW5GQWh6YVN4R21MbmRXQnAwREZaVnRIa2swMTBFSHpRQ2oyYWU0?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2tWflXC3Ak4rqAtqNUkGGjAeX0/t2Stf5eggYeX4FIDhDrihWFupsGCMtirgFlfwFewLKbFkliWxJ/Bbml8AX2BZ7R5qOs3UuBkUke/y2zLWliXckwccs7JDgZC+iQkTgw0f1IBSlrQ+R/Mf/+PtLLnKLnyuKFlEH7Tv063+1kOa9s1LDCjN2/fYorOh+C/VffI7slcVIArVODGOUkk2Ehf2KXfGhcWx1+u8wHcJgsFJclnpH7BWKLtBlqOT90fuf6R1zWFwSCNT4cyZpi/Yiyvk3RgXK3d1bWXODjFO9NNmx1eAMcU+Z8aowylHz2fbjW3lsHBfzem3Pr9m8Hny9T8JIZSa82FE6UzohK0Sbu07m9EG85ky32OaQp5/t9DqGLuUKNCWd2RpdpRFrYvYezE9iBI4KFf8Xf/C7CLdsGWftNyhXLe4OFP7YI+hs39LOmdwtr4yYurhQ84e9vnIReWvhooXwrhKu9gSTLGrfUi26tXbvsV5vfFNAAdM1pcYQMPxEjU5y0hB3Ip1fmyuWTuAfkn3nashSAm4si3C7jcDemzci7BojRXjnyrL7UY44niljYKyj0e6g3fMFbPaim9ecX7g/JB9Ji7W1C2CE1E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fb54b8-d459-437a-2f9e-08dd4d0f686c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:51:12.9425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkPqfaZNnwAaeEaDQETm8reHNkXzNyqG783BvtpPSqx2lBbwO8MVsDpWyePK8kBRYD42Ihdlu3piXvtNR/jfwXtt3jnSjLtKJSWlYzdwsWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4535
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140113
X-Proofpoint-GUID: dmlZjOIINEUQH2rreoAN3FDjhWfGPrqo
X-Proofpoint-ORIG-GUID: dmlZjOIINEUQH2rreoAN3FDjhWfGPrqo
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

cc kvm reviewers.

The series is here:
   https://lore.kernel.org/qemu-devel/1739542467-226739-1-git-send-email-steven.sistare@oracle.com/

- Steve

On 2/14/2025 9:14 AM, Steve Sistare wrote:
> cpr-transfer breaks vfio network connectivity to and from the guest, and
> the host system log shows:
>    irq bypass consumer (token 00000000a03c32e5) registration fails: -16
> which is EBUSY.  This occurs because KVM descriptors are still open in
> the old QEMU process.  Close them.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   accel/kvm/kvm-all.c           | 28 ++++++++++++++++++++++++++++
>   hw/vfio/common.c              |  8 ++++++++
>   include/hw/vfio/vfio-common.h |  1 +
>   include/migration/cpr.h       |  2 ++
>   include/system/kvm.h          |  1 +
>   migration/cpr-transfer.c      | 18 ++++++++++++++++++
>   migration/cpr.c               |  8 ++++++++
>   migration/migration.c         |  1 +
>   8 files changed, 67 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index c65b790..cdbe91c 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -507,16 +507,23 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>           goto err;
>       }
>   
> +    /* If I am the CPU that created coalesced_mmio_ring, then discard it */
> +    if (s->coalesced_mmio_ring == (void *)cpu->kvm_run + PAGE_SIZE) {
> +        s->coalesced_mmio_ring = NULL;
> +    }
> +
>       ret = munmap(cpu->kvm_run, mmap_size);
>       if (ret < 0) {
>           goto err;
>       }
> +    cpu->kvm_run = NULL;
>   
>       if (cpu->kvm_dirty_gfns) {
>           ret = munmap(cpu->kvm_dirty_gfns, s->kvm_dirty_ring_bytes);
>           if (ret < 0) {
>               goto err;
>           }
> +        cpu->kvm_dirty_gfns = NULL;
>       }
>   
>       kvm_park_vcpu(cpu);
> @@ -595,6 +602,27 @@ err:
>       return ret;
>   }
>   
> +void kvm_close(void)
> +{
> +    CPUState *cpu;
> +
> +    CPU_FOREACH(cpu) {
> +        cpu_remove_sync(cpu);
> +        close(cpu->kvm_fd);
> +        cpu->kvm_fd = -1;
> +        close(cpu->kvm_vcpu_stats_fd);
> +        cpu->kvm_vcpu_stats_fd = -1;
> +    }
> +
> +    if (kvm_state && kvm_state->fd != -1) {
> +        close(kvm_state->vmfd);
> +        kvm_state->vmfd = -1;
> +        close(kvm_state->fd);
> +        kvm_state->fd = -1;
> +    }
> +    kvm_state = NULL;
> +}
> +
>   /*
>    * dirty pages logging control
>    */
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 48663ad..c536698 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1501,6 +1501,14 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
>       return 0;
>   }
>   
> +void vfio_kvm_device_close(void)
> +{
> +    if (vfio_kvm_device_fd != -1) {
> +        close(vfio_kvm_device_fd);
> +        vfio_kvm_device_fd = -1;
> +    }
> +}
> +
>   VFIOAddressSpace *vfio_get_address_space(AddressSpace *as)
>   {
>       VFIOAddressSpace *space;
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 1563f3a..78e4f12 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -259,6 +259,7 @@ VFIODevice *vfio_get_vfio_device(Object *obj);
>   
>   int vfio_kvm_device_add_fd(int fd, Error **errp);
>   int vfio_kvm_device_del_fd(int fd, Error **errp);
> +void vfio_kvm_device_close(void);
>   
>   bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
>   void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> index 6ad04d4..c5c191d 100644
> --- a/include/migration/cpr.h
> +++ b/include/migration/cpr.h
> @@ -32,7 +32,9 @@ void cpr_state_close(void);
>   struct QIOChannel *cpr_state_ioc(void);
>   
>   bool cpr_needed_for_reuse(void *opaque);
> +void cpr_kvm_close(void);
>   
> +void cpr_transfer_init(void);
>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>   QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>   
> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index ab17c09..ad5c55e 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -194,6 +194,7 @@ bool kvm_has_sync_mmu(void);
>   int kvm_has_vcpu_events(void);
>   int kvm_max_nested_state_length(void);
>   int kvm_has_gsi_routing(void);
> +void kvm_close(void);
>   
>   /**
>    * kvm_arm_supports_user_irq
> diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
> index e1f1403..396558f 100644
> --- a/migration/cpr-transfer.c
> +++ b/migration/cpr-transfer.c
> @@ -17,6 +17,24 @@
>   #include "migration/vmstate.h"
>   #include "trace.h"
>   
> +static int cpr_transfer_notifier(NotifierWithReturn *notifier,
> +                                 MigrationEvent *e,
> +                                 Error **errp)
> +{
> +    if (e->type == MIG_EVENT_PRECOPY_DONE) {
> +        cpr_kvm_close();
> +    }
> +    return 0;
> +}
> +
> +void cpr_transfer_init(void)
> +{
> +    static NotifierWithReturn notifier;
> +
> +    migration_add_notifier_mode(&notifier, cpr_transfer_notifier,
> +                                MIG_MODE_CPR_TRANSFER);
> +}
> +
>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
>   {
>       MigrationAddress *addr = channel->addr;
> diff --git a/migration/cpr.c b/migration/cpr.c
> index 12c489b..351e12d 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -7,12 +7,14 @@
>   
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
> +#include "hw/vfio/vfio-common.h"
>   #include "migration/cpr.h"
>   #include "migration/misc.h"
>   #include "migration/options.h"
>   #include "migration/qemu-file.h"
>   #include "migration/savevm.h"
>   #include "migration/vmstate.h"
> +#include "system/kvm.h"
>   #include "system/runstate.h"
>   #include "trace.h"
>   
> @@ -266,3 +268,9 @@ bool cpr_needed_for_reuse(void *opaque)
>       MigMode mode = migrate_mode();
>       return mode == MIG_MODE_CPR_TRANSFER;
>   }
> +
> +void cpr_kvm_close(void)
> +{
> +    kvm_close();
> +    vfio_kvm_device_close();
> +}
> diff --git a/migration/migration.c b/migration/migration.c
> index 3969285..bdc5255 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -296,6 +296,7 @@ void migration_object_init(void)
>   
>       ram_mig_init();
>       dirty_bitmap_mig_init();
> +    cpr_transfer_init();
>   
>       /* Initialize cpu throttle timers */
>       cpu_throttle_init();


