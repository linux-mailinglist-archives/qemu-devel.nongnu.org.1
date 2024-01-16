Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E78E982F880
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 21:46:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPqIu-000141-Sx; Tue, 16 Jan 2024 15:45:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rPqIr-00013o-L5
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 15:44:57 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rPqIn-0005FR-KQ
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 15:44:57 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40GKEB4P002019; Tue, 16 Jan 2024 20:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=JBHzyepdzE5a+ZqAo/4d35Xn3PIGYQtP0iOtMlxdgQk=;
 b=NT4UfGTMGMOlA3AcpAgd0oL6QbTmCyHe5CHsVdRlB/evrxfUpQ9uOJN3Z9Tj5nDKyjPC
 Who7ccq3ScM76aiWrKh5RjTZm/Dsy9k9hqQG+/RDkdpQL318n0fpTeNRA8haov63e2P9
 7W11UOmtoUTSSHr0T9KWxg1vEH8nZ64ytLP3/UpNeKQRsvbGbM3xnaYwl2emz33xM/6I
 uZkJbmzQIOheVmdGOQ3qUVqDWYlK9/L1kluxHHy5vAFz5rZLMQfwF3X6EfheeV8hxjls
 dcGaRrDHegeF6GHpImiDzEfrnW82J+qbog5iODtPbQOwNhbipkdmPd+AwQRKuRtmQowQ og== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkjb9x21d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jan 2024 20:44:51 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40GJPJSZ004491; Tue, 16 Jan 2024 20:44:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vkgyetm4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jan 2024 20:44:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlGzD8gVu4RZYUnTxj+7jSd3aWaA5sClBw3jPYZ/mGhjrmoaVmxLIFbNcmejog79bwrLycf6+2sxne3huGqyox1RT/NiuVX9WGMnqy5EWkiJLqs8GdF979cwvzbTChh5gxRstlEYWng6ERYP+OQ2G+B3BOC+pLzsQSPpegbk7JVWQARs3o2fTpe1I4xriVu5W9uoNEsODAKp608MnJx5qjFUUyC9HUXGquJBx6sQutW7G+WtjlhSX7Ti47L9V2/Aci1CFZMf0x/po5fDzQeGsJw3JAwXbJlK9cqpeguRdU/z7msYVlv5hXK7zILIpxNUcneZHFNluqt8yP8sEZF4dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBHzyepdzE5a+ZqAo/4d35Xn3PIGYQtP0iOtMlxdgQk=;
 b=MR2hqRk4QVeOXpiAheZ1f3F6vkgAqP27DpSCyS1kZlNZnnVKUPHoj3aa2d1OVYkz6UpgZpPRGv2SsvFnRIQ/GMBiF93+fhQDIH5akp0pCH/y8FAuyX/593UTdsdlCa8SJpYXXn9U8/otGFCTHZUK08EM4t9eZjjG5tQSRyVBEP/I7fGu8u/UdR54IO5p1RbQTM1MJB3CRwmswGY9RVSdwaL+tAjS/JDlKlga/ZcOksUAxswYqnX1OOrfB6mM85Tht7ftzNe4sssz80CAMXgaTawVgWyUglgamsiuXuOy0IUPhzpBWVHb7Z1Ci0RYbbadX+b9qvSJoDoYz553+73VwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBHzyepdzE5a+ZqAo/4d35Xn3PIGYQtP0iOtMlxdgQk=;
 b=kJmlXu6Ce7kTYCdaJCpVETUIwPEqbmaxVhqK8VqQFoGDPIjbpi1LnRAzWJ8tL5tZmX3V82rp4PkVKRr0OIr92MK6jaRgZPA5laSwEI5pfA5ymZWth+xLG1//cGEUyZTAY2S+TnyK7nbiTV40FRlXM+xjeSHEymrSkXvwNlIdV0s=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ0PR10MB4720.namprd10.prod.outlook.com (2603:10b6:a03:2d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Tue, 16 Jan
 2024 20:44:47 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7181.026; Tue, 16 Jan 2024
 20:44:47 +0000
Message-ID: <94b99d4b-481e-405e-b439-76bec9960d09@oracle.com>
Date: Tue, 16 Jan 2024 15:44:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 11/11] vfio: allow cpr-reboot migration if suspended
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
 <1705071910-174321-12-git-send-email-steven.sistare@oracle.com>
 <ZaTfwOs2g_A4a1pO@x1n> <470484ea-ece5-4a73-b84a-eef98f84ed9b@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <470484ea-ece5-4a73-b84a-eef98f84ed9b@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0291.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::26) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ0PR10MB4720:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f83764-9e08-485e-70ed-08dc16d3fa4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mC8w9wdeHR2AbzC8VA2Gfufgu9pcusQL7TJh7S3EH885X/XU3PiBrITzB/7iDR2KVtIiqU/64RKW6Qtel9bMTGrVE/tyMBhblpPzJ4C90+Vyl+ccHIReOdMroGTDahzEUYOHakpd1P8hrdWMisqkDqvQk8mwhJD+0sYyKr1OIrQNFlmDMbbkQYFSVOWMRXpVqcwtCT5FTjPqqGS0l6UPziXK6eKbp9HxN3heJiNYnjBqfHPuniJQakRt7p2fzCnPLkH5sT6TnvPT6ZHdojiUiK74je7Nd9W7HRVZoG7Tkra3XuzWhLDAHy32f7KKL5yiozo3PFoVKcl8eSUYElYsElpY74xdXxH2oTEX6XWzoV0mgMcRBek0JhbITMEB/odf3zflMmJwaVK07XyYaBaU/XF0hDW+UUWmOewFVAOQ/lIR9GewTJJ3JiwJQdFzjwTD39bua/tVOKqhxbRnwuKmuJrNd4Yx2nr5ZaYEIK4yE0a82xQuTYtORlFVuGmWk+Wa7KWyInqM0U7mJYinKM9cWN1qDNT25l8a0cnzsoo84uLf6nhr3CHrWCsJ29UhvfBN6+BnZUSwASz76v2OiLUB/o9Twp3hd+Npug22lhuORvgZOJnQpUpxcoBzF0D1ZTlp15cmGgx+OaeUT2KKm37GEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(4326008)(8676002)(15650500001)(5660300002)(6916009)(7416002)(316002)(8936002)(66556008)(66476007)(54906003)(2906002)(26005)(2616005)(36756003)(31696002)(86362001)(44832011)(66946007)(6486002)(31686004)(6512007)(53546011)(6506007)(6666004)(478600001)(36916002)(41300700001)(38100700002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHBYcVVvZmdyYzJLb1A3SHJoY2QzRzRaRDZLWHFzdFNOZ0tLMDdLUlBRU3Rs?=
 =?utf-8?B?Zkp4QUU0bjQ0Vis4YVJkMlhuMzJkV3l4QjM0SWI2NzlBSUIzaTZjRlAxK2FL?=
 =?utf-8?B?TDF6N2gzNkJGeE8xNUtsVjhlc1ZLejFqQzI5RjBLTUgrOUc4THphRjZXMTNt?=
 =?utf-8?B?QTRmbzZLM2RKNHp4WUtyVDZZTWhnQzFVN2JRMVNRRCszZzFNcy8zN1ZCM0ZP?=
 =?utf-8?B?TVBhRGFUTTg4ZkVwVDJxOWoyekZKQlZjTDJYWWp4RVVxUUo5OUVpTEVCdlNl?=
 =?utf-8?B?UDVOQjBNZzFsMVNuWVMweXE2LzZqUmlIL2JKSnRsSDZJS0pKSUNMaGo2cW9R?=
 =?utf-8?B?NU5vd3U3ZC9xRWxRYWxnL3BJelAxRlJ2WVFWcldncitZMG9BRFQrMEE4Qm96?=
 =?utf-8?B?S1lYSHp1SndRQVZvTkZSUXFaOTBhSCs1Y1J1TDVuejVBMFNCNmhWR21hTEpY?=
 =?utf-8?B?bm16M3ROVTA5ODRLV2Z5T2V3elFYR2xTZkk5TW4yeURUSEhIaDZaenN3UlZC?=
 =?utf-8?B?V1lScEkvU0ZnU0FPdmhoRWxBemhrem1yZ0luY3hDc3oxcU9EejJUZjljTnpr?=
 =?utf-8?B?Ull0MXEzck1aQ1ArWXg0eUVDWWM5TkJKUGFiMmRBUUs3b1MrMmoxeC9WbTY4?=
 =?utf-8?B?Y0c3cUFQUERmcjVqRVRTZjBKVnlEY2ZFQ0Zwb2Qwb1pPMzRrYXphMk1Xbm9z?=
 =?utf-8?B?ckhZQS8ybkpINWVybWtoRDJteGxhVjFMZi9haVBXWE53RGNQTEJ2ZG1IWmtj?=
 =?utf-8?B?dXYzcS9vWjRrd3RqT0UrUlRlbThyWGE3RGh3SEpsZVF3TytSbFFTSUlYU3NK?=
 =?utf-8?B?bUNBTDlkeTJEaGZMZGFtSXQ1ckFuektNemVqUVh4T2Z6RXpQYnVHc053MTVw?=
 =?utf-8?B?TlFpcjRrekVIcUlOWE1xc3JVVTFjQndXYUs2TWhRQTR1RTdPbWg1c0E2cGFa?=
 =?utf-8?B?NXdmNDg3eDFlT0k5a2NzUURBSnM4LytPSkttZWZrLzRyaWNpelVLNnJlWHN4?=
 =?utf-8?B?TTMrVW5sOUYxenFvNkJ2RTF4YmF6eDdsNVEranZ0WjRoSjk4WWJhMllKRGpX?=
 =?utf-8?B?SzBIckd6Y3E3M2dPdXN3Ti9JUXpnaGJreTZ6VDVmdHM0U1o5YllvamI1K1k5?=
 =?utf-8?B?ZjZZSjVXbmR5bGtYSWNIOG9lbnh4dnFsYytjbHBRTlg0WnBjTnZHSEFpSW5z?=
 =?utf-8?B?QkphWDNlcVQ3RWM1NGlqU2s2Wi8zZTVWaDkvK0daOWUxZ0E1RnQ1czkrb1BF?=
 =?utf-8?B?UldueFRuVzJEVitMQTArd1VEMk54WGJ4ZStDZG9KbkpCczBHK2pDTnR0V0d2?=
 =?utf-8?B?akxOME1aTDVFMHpWWUR2NTQyQWxBdGdnQVdnN2dldW9Tc0dQSmVBeEhsNGNx?=
 =?utf-8?B?MTZ5ZkV0dG1adUtUb3V2R0pCcnRObW1GY2ladUVzQmNDMDZXVmR0SGlYRHh6?=
 =?utf-8?B?SmxvY2F6dDRzZ0FpYU5GYVBuSmxhMUt2anVaVUZBeGdCaXIyVHlWVUJ2K05q?=
 =?utf-8?B?MWdQMXNLeXpnZnJmZ0o5QlZUNjNVTTZUL3RPbDZYZWllZGlVMHpnLysrOGFk?=
 =?utf-8?B?eUIvMXExSUZRQmExckFpZERmdjRsY2FGM0RodjB0aXNrdmtyVkdUU1FocjRR?=
 =?utf-8?B?amFHU2ljaHc4MjVreXI4Rm9iM2tXT0tabHUxTnpiL1UrZWw1bTg0OTA3OElO?=
 =?utf-8?B?c2l1bUx6RzZta0RyeHJMckMyMVV4aWVPME5ua2t4UnR3eWlMK1pFZURQMnV3?=
 =?utf-8?B?a20zV1BXL0lwd25Id3NRTUkyK2VocHdOc083bE4wQkMyTVRVNk5WdjZta1JH?=
 =?utf-8?B?dWJVZ1NYVXBITjZyWHZXdVRITzhNTmNVRnZicTdMU2ROSVkyc1RaUWFFb1RY?=
 =?utf-8?B?RXVvYU13ZDJZOVVyTjZmQllaUlhnTDNBdHZaazQ3MzBmSEozZzRKNld1QjlL?=
 =?utf-8?B?SlJ4eFluaUVxa1Y1b21DS2J5Q1dUaDUyamdwbXhjWm00c3RkbmdPVEU2NDAw?=
 =?utf-8?B?bmV5NjQzU2NBVTd3UnEwYUgzWHRMMHpoVlE0bHhFTkt0NFpLZUc1Y1M4TjlW?=
 =?utf-8?B?c3JzWDlieGd6eUxJbUU3T3d6NHMxa0Q0WmxmTzdvRmtXZVJsQ2NTSHlnQU5C?=
 =?utf-8?B?ekdLTmtrdWtFNThueXZYVEVMZGo4aDBQalpKV0w3OVBxV08xZVVHeEgwK1Ez?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qunO51+86AxYpPcsYPYKcphFYz0XrwytnhQUKcHXmmlgKS5RyKq4TcObIpZs6LfXjH3r4w4WpIjwdoL0VciYkVzlRilWBWP6YF3GsBKegOLYeb+hdKDOdqtydI+QU4LXxaIG5eTgdbL78YKigGC7GnnD9Yh8/0tHOa819t2fTtdz1B37mqBgAU2QeHTH5BxuuPmOxvelPSAGtbqI6TQz3T2O2iVZRE5sue0bt+ajQ0H45Aoichop0z5iKl+r5/iER9XZfvbd3iSqV5t3J6a6Kz4MdxhIapDJmLywwWr3+yBskByzKBqKXqQ0EDj6/ooHa/RCrMT9Ecl7CCehUiy1n0KxDjfKj7CNKqCXzh55C9ueQ4V/PorTSArapcwHfPmISJ0uML+gOAOYV4zRi3waylN7XwflWCpxP9QU8grDAlGEyjqJHn/CW3cs1R/XMD6BeKmw6mmv28v84N3+1e5knawaUGgLlMxPZWsFAqNwoDYZerlrKxPDwc8pOsQlZ46WV3Aep0Yu2+P+ly5gLbBQIfP4od9LdDEuZFtzfpI/4xejMoALPcWsPNy+Zc1vCI/k6Pkgcnd/7rbg0nq5VvEL4MaZ5VAOCOZ6LsXgHDbyzsY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f83764-9e08-485e-70ed-08dc16d3fa4b
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 20:44:47.4365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpxVE+HafELjewEfO6u2q/rEO3I6Cl8fa2jJOnWDmCmGS2du9I2mVP+JJ0yia0mVwGcX15E7hBs3ztVsRUOeRR6wRs8jNN1006oYR8uZMu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_12,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401160164
X-Proofpoint-GUID: UXifKGhvcrMLDyNDQY_GEq8kZA-atK8u
X-Proofpoint-ORIG-GUID: UXifKGhvcrMLDyNDQY_GEq8kZA-atK8u
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 1/16/2024 3:37 PM, Steven Sistare wrote:
> On 1/15/2024 2:33 AM, Peter Xu wrote:
>> On Fri, Jan 12, 2024 at 07:05:10AM -0800, Steve Sistare wrote:
>>> Allow cpr-reboot for vfio if the guest is in the suspended runstate.  The
>>> guest drivers' suspend methods flush outstanding requests and re-initialize
>>> the devices, and thus there is no device state to save and restore.  The
>>> user is responsible for suspending the guest before initiating cpr, such as
>>> by issuing guest-suspend-ram to the qemu guest agent.
>>>
>>> Relax the vfio blocker so it does not apply to cpr, and add a notifier that
>>> verifies the guest is suspended.  Skip dirty page tracking, which is N/A for
>>> cpr, to avoid ioctl errors.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>  hw/vfio/common.c              |  2 +-
>>>  hw/vfio/cpr.c                 | 20 ++++++++++++++++++++
>>>  hw/vfio/migration.c           |  2 +-
>>>  include/hw/vfio/vfio-common.h |  1 +
>>>  migration/ram.c               |  9 +++++----
>>>  5 files changed, 28 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index 0b3352f..09af934 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -128,7 +128,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>>>      error_setg(&multiple_devices_migration_blocker,
>>>                 "Multiple VFIO devices migration is supported only if all of "
>>>                 "them support P2P migration");
>>> -    ret = migrate_add_blocker(&multiple_devices_migration_blocker, errp);
>>> +    ret = migrate_add_blocker_normal(&multiple_devices_migration_blocker, errp);
>>>  
>>>      return ret;
>>>  }
>>> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>>> index bbd1c7a..9f4b1fe 100644
>>> --- a/hw/vfio/cpr.c
>>> +++ b/hw/vfio/cpr.c
>>> @@ -7,13 +7,33 @@
>>>  
>>>  #include "qemu/osdep.h"
>>>  #include "hw/vfio/vfio-common.h"
>>> +#include "migration/misc.h"
>>>  #include "qapi/error.h"
>>> +#include "sysemu/runstate.h"
>>> +
>>> +static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
>>> +                                    MigrationEvent *e, Error **errp)
>>> +{
>>> +    if (e->state == MIGRATION_STATUS_SETUP &&
>>> +        !runstate_check(RUN_STATE_SUSPENDED)) {
>>> +
>>> +        error_setg(errp,
>>> +            "VFIO device only supports cpr-reboot for runstate suspended");
>>> +
>>> +        return -1;
>>> +    }
>>
>> What happens if the guest is suspended during SETUP, but then quickly waked
>> up before CPR migration completes?
> 
> That is a management layer bug -- we told them the VM must be suspended.
> However, I will reject a wakeup request if migration is active and mode is cpr.
> 
>>> +    return 0;
>>> +}
>>>  
>>>  int vfio_cpr_register_container(VFIOContainer *container, Error **errp)
>>>  {
>>> +    migration_add_notifier_mode(&container->cpr_reboot_notifier,
>>> +                                vfio_cpr_reboot_notifier,
>>> +                                MIG_MODE_CPR_REBOOT);
>>>      return 0;
>>>  }
>>>  
>>>  void vfio_cpr_unregister_container(VFIOContainer *container)
>>>  {
>>> +    migration_remove_notifier(&container->cpr_reboot_notifier);
>>>  }
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 534fddf..488905d 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -895,7 +895,7 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>>>      vbasedev->migration_blocker = error_copy(err);
>>>      error_free(err);
>>>  
>>> -    return migrate_add_blocker(&vbasedev->migration_blocker, errp);
>>> +    return migrate_add_blocker_normal(&vbasedev->migration_blocker, errp);
>>>  }
>>>  
>>>  /* ---------------------------------------------------------------------- */
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index 1add5b7..7a46e24 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -78,6 +78,7 @@ struct VFIOGroup;
>>>  typedef struct VFIOContainer {
>>>      VFIOContainerBase bcontainer;
>>>      int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>>> +    NotifierWithReturn cpr_reboot_notifier;
>>>      unsigned iommu_type;
>>>      QLIST_HEAD(, VFIOGroup) group_list;
>>>  } VFIOContainer;
>>> diff --git a/migration/ram.c b/migration/ram.c
>>> index 1923366..44ad324 100644
>>> --- a/migration/ram.c
>>> +++ b/migration/ram.c
>>> @@ -2392,8 +2392,8 @@ static void ram_save_cleanup(void *opaque)
>>>      RAMState **rsp = opaque;
>>>      RAMBlock *block;
>>>  
>>> -    /* We don't use dirty log with background snapshots */
>>> -    if (!migrate_background_snapshot()) {
>>> +    /* We don't use dirty log with background snapshots or cpr */
>>> +    if (!migrate_background_snapshot() && migrate_mode() == MIG_MODE_NORMAL) {
>>
>> Same question here, on what happens if the user resumes the VM before
>> migration completes?  IIUC shared-ram is not required, then it means if
>> that happens the cpr migration image can contain corrupted data, and that
>> may be a problem.
>>
>> Background snapshot is special in that it relies on totally different
>> tracking facilities (userfault, rather than KVM_GET_DIRTY_LOG), so it
>> disabled dirty tracking completely.  I assume not the case for cpr.
>>
>> If cpr is not going to support that use case, IIUC it should fail that
>> system wakeup properly.  Or perhaps when CPR mode QEMU should instead
>> reject a wakeup?
> 
> Good catch, this hunk would break the non-vfio case where the guest can be
> running when migration is initiated.  I should narrow the logic to check for
> that:
> 
>     if (!migrate_background_snapshot() &&
>         (migrate_mode() == MIG_MODE_NORMAL || runstate_is_running()) {

Correction: I need to specifically check for the suspended state (RUNSTATE_SUSPENDED
or vm_was_suspended), since I will not reject "cont from stopped" requests.

- Steve

>         ... use dirty logging ...
> 
> That plus rejecting a wakeup request should be sufficient.
> 
>>>          /* caller have hold BQL or is in a bh, so there is
>>>           * no writing race against the migration bitmap
>>>           */
>>> @@ -2804,8 +2804,9 @@ static void ram_init_bitmaps(RAMState *rs)
>>>  
>>>      WITH_RCU_READ_LOCK_GUARD() {
>>>          ram_list_init_bitmaps();
>>> -        /* We don't use dirty log with background snapshots */
>>> -        if (!migrate_background_snapshot()) {
>>> +        /* We don't use dirty log with background snapshots or cpr */
>>> +        if (!migrate_background_snapshot() &&
>>> +            migrate_mode() == MIG_MODE_NORMAL) {
>>>              memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
>>>              migration_bitmap_sync_precopy(rs, false);
>>>          }
>>> -- 
>>> 1.8.3.1
>>>
>>

