Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EDB830EA6
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 22:32:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQDVB-000804-KD; Wed, 17 Jan 2024 16:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rQDV7-0007zj-6m
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 16:31:09 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rQDV2-0000Xc-BF
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 16:31:08 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40HJdKdC023669; Wed, 17 Jan 2024 21:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=xKdlQ/r6eyhwyJjZ2jMVGQSIyII08YmRz2Gc5JBv/og=;
 b=nwWbXWva/wAWddNtS3XCi9WjusBHn6To4Ki4Mxa5/NSn1jRnpa2n2px24LJvqTIcI5gF
 Bp/zemxOeJ6NvIK2ul+FhQ/HwxUEasPSm4aCcRoj20+sV9GjfgVeehmsWmOTIMyOd+9c
 X7MBuWCR75AU/H1HF8X5AI7ahC5/Y4YPUruoLhRnsa1w3du3NmV4QVX011mfC/4emCX8
 N1xeiLshI1uYimxMv17VCBDwlt3Em+EPuiY9kAJiNmc71ERwn3gLeJz59chfdnxx8FE5
 iBVXdigb4YMWr7MvrbDTkFJRuahgE3P5ksp2WZLSBT8e70+MPpYQiwJXYH+S1DKictKh 4g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkq3h0suq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jan 2024 21:31:00 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40HKww9C005179; Wed, 17 Jan 2024 21:30:58 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vkgyh6pc8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jan 2024 21:30:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jApFRm5I6vQ1gAz+K1bojRwiUUokxtomNwltDt8O5eWEucll6ID4uI+NKHtInwCDISRh1J/UW1bbxO11FW5uPsXdA9d+eTIO1OY9R3CxFKW6DsCmEccdi7nBQRLtkcuyIQADyJrce3VZy6oCy9TyDRQxGJ6REnT/il5p1b0NQSZwwiQQo402ywUw6iB0YQN2eofidok16iF1yX5jYlZXPlufW1KeYdHNRrFbuAZ7asJXFFA4VrGkuqVbMrzztFd5NcDRgz4HFhxnJrWRKclX873zMbpneCB4Rtd3A9CSimYp131P66m0FOFHYEeZQY+M59amjl1wgRKa9GpzKTTtBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKdlQ/r6eyhwyJjZ2jMVGQSIyII08YmRz2Gc5JBv/og=;
 b=jM7fTlFh/UT27SgjIZJiwWMNoSJBIMy/rjN9QLXvlLZfGK3rt3yILPnEM8BX/Q7wK34PnhxhgVRoXWSTxAfP0YT1YQTQ1Wrgqk8BYYHJfbPIph6F87+oQEEsacjdVWDEf4CkwwJD2NVCKXj66ryL2g+Nj/cJDFsYop0ULECiWM6qPijdB/ms35pFmUjRbLa+IcQGxHbVilFnJA1kb4dyqqU9HhvN7lxb69FxXB3UG6ZCskKWm54J6RH1hUb1cELYzSRoNYeGpHKz1QEyD2V/rRGKj4kyLjHfT0IcilFEYCp9b4FpY5YUFVkrwqM/Ca38p1jBXsjYukfCpclgHjncig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKdlQ/r6eyhwyJjZ2jMVGQSIyII08YmRz2Gc5JBv/og=;
 b=HFtBbsBpUdsjuq/Gnx3Wy12uHz5sW3cQdgChQpUKssJWXDy5L3WYFXf3BT0+5guEBHLqqw69103iBRbvbspBl9k4SQVagrqoio1mGuNgXLTlXJKrAlk9F2qvHmI3kTK3w7aaIYjV9ILVCYg3o9/QQVjsiKGPExbtsB/FI76PWnQ=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SN7PR10MB6978.namprd10.prod.outlook.com (2603:10b6:806:34d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Wed, 17 Jan
 2024 21:30:53 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7181.026; Wed, 17 Jan 2024
 21:30:53 +0000
Message-ID: <67b49892-f731-4ced-981f-6303a898ac9d@oracle.com>
Date: Wed, 17 Jan 2024 16:30:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 11/11] vfio: allow cpr-reboot migration if suspended
Content-Language: en-US
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
 <Zad91nqbaW2HizCo@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zad91nqbaW2HizCo@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0059.namprd11.prod.outlook.com
 (2603:10b6:a03:80::36) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SN7PR10MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fbd97b1-6cd7-40d0-a34d-08dc17a39515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EMU2a6f/tZHjW9PPVC3rM9AMyPV49XrRnwR9eZeBpt6wMB0QN0ip1xYxZPli73CKCqPdI+sYWIDXUnSIBIYjLU4vs0K+VhjebQ4pwPcd4d5ieT79e0xexEZEUhulA+KHJUcJa9JyzOTrQswUzvGaza7f85k1apUC+qsFwUBAT4PuUf8WpCzxmPVGzA2p7FbibaT4eLmkdjM4zc9MQxXvkMove++/K63fKj/JDi+qOtHZMhjsMN94ZVhkV9DH2lY+Pdlx5n2mdc400KAkzHNS03G7M75sUX//bfZ3MUuHgac7ymeSwSf+ARFD9V5iPSlE1Y0htrcYrCZdGvqKa6YNnzqaXzDcMVdJzu88O70lLrV40l5TDcrvJMiTZsOOSlbmLPRCmfjd0v90+GLwifzVIlN4ImjBoGlVnp3xZ+X+MuuU9o7Gjm7l+swieM/18lzKKjziQ2a9qLriewfIKRJbZ9OohNEeMB609QbHTOFTXS/LUnnbWrP3GcljZgGWIUL1gF3LZKm+7npfxomgpwKHOm7ZbNS972d0bg2yZhy2sfS84Qmn0Uq4EUvXKX/fxANsEnzpLv40vxIIdzNEFOe3NBFBX4vc6yzrvLifXttU04+fwxG0upUJqvcBqfEjseD6F4tI9ZuU8bQKb0eCoqQhsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(83380400001)(2616005)(31696002)(7416002)(26005)(478600001)(5660300002)(86362001)(966005)(6486002)(54906003)(316002)(6916009)(66476007)(66946007)(66556008)(6512007)(31686004)(6506007)(53546011)(36916002)(6666004)(8676002)(4326008)(8936002)(30864003)(36756003)(44832011)(15650500001)(38100700002)(41300700001)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmJYdlV0QldJMjhqL08rRGU3ZHg1eUhZcjdsQzhJZ09BSVkwVlgrejRvOUov?=
 =?utf-8?B?NWxzZC94MGIvdCtyY3dxOTJDdzU5ZDcvU3Bhb0JyODJqV2I0dnZLem8rRmhB?=
 =?utf-8?B?Q0FWMU84c2ZFS3RpejZ5cXdGSkQ2TjE2bTM3aWVxVEUrSG9XVTl1Sk5qZEht?=
 =?utf-8?B?WUZiYWdzSjRRd05lOE5rQ3M3Y2lqeGpDVUhjeVB0c3ZORFBuWTByZVU5c1ZS?=
 =?utf-8?B?eXZkaERIUml2anN6T0dRajFQeGJnZ09OZ0VhdmNhNDhzdnJqZDVjaFZHRmQ0?=
 =?utf-8?B?TlQ3MVIzV1NDaEhrVHkvMStuM0xQRXBXSXUrZ1QvdUtoUTNJMkNpQ2s5Zzlk?=
 =?utf-8?B?a0NEUS8yUXZCWHk0TlVrTWVPVGJ2bHhrOFpmVFZOby9wOGg3M3JTd3R3Q1Vx?=
 =?utf-8?B?bjdacjB6K3RaRWRUdUR6U3QrcmVtOGpTS1ZoUlFKVjVuMGhWL3M1VjZoOWxy?=
 =?utf-8?B?VG1WejhRZy9Udit0LytpQlBHc0pvVG9yakI5M0Z5UlkzMmVNMDJoTzlQZU9I?=
 =?utf-8?B?MjhpejlvQWFFQnlCUDdvQVRlY1M2SG1FVE8zK3UwbU5OUVRQYlJmV1RsaEpD?=
 =?utf-8?B?UlZZdkk2azBkVUZ4Ri9XZTdwZzBlNzVTOHVndDJRZkhQeWo2d05adHVmc1FX?=
 =?utf-8?B?UlltMkZkRzlRRFZRcGF0bUN6dzVYanIxOFVTcG9nRER0NkZSMWJmSXgwMkJu?=
 =?utf-8?B?YkY3QjdLNTlka2Y2c1RFS3FhRzVnQTNqZGlwaE5nMDhUMS85Lyt2SnJIS09r?=
 =?utf-8?B?Q0RQLzhKWVUrcndwZDNnUU9kZ2YyOHcxaUg2Y3FVeFVwOHdMRUswSzUrdnFj?=
 =?utf-8?B?OVpJQzUrMUpMK2g2d3JJMG9FNHc4MzU3N1dzblhPWmYxZy9UMkVBeDVxRk9l?=
 =?utf-8?B?NlY3dDg3UmRSZnd5T0VSVlRhbGNwK1FNN1JIdGZ2RDV1Nm0wL05wTEVUMmF6?=
 =?utf-8?B?WmMvUW8yeVRtL3lTNVA2NVBEcW05SitPTG54VjZRMDhDaU9sWjluMjVua1pR?=
 =?utf-8?B?VEFjUGlyVG5PYkZBakprMnhkVjNZTjJTcldRd2s3L0gvNytubUZmclpmSGh1?=
 =?utf-8?B?ekpoSHNuYU9wMWVRbGt3cnNOZjUydHNqNDRMSXVremJ5Tmp4NXNWWGZ3c0t1?=
 =?utf-8?B?a0cyOUtrSGgvWXVCZHJEWllBRWcvMDNjNHBBd2E4d3l4aDhRWnJ1MlUvcUhk?=
 =?utf-8?B?T1U4dlJ4bDYvVHZ5MFphUUsvQnFYTG5CUE9lanJ2ZGxlQTVHMjhaWjNOVU1Z?=
 =?utf-8?B?d1ZrVlduSEo5YzIwWTNZK0hLUzNud1JKRG83T3JWdzc0SXBXUjdNOG5wYXFH?=
 =?utf-8?B?Q29qWkVjVHJ2ZWRxY29YN3VTRkxnN3hzbDdjOG9qeHE3V1dWKyt3THFEUU83?=
 =?utf-8?B?ekVOUjRKUDd0VHNkY0kzUzhlcUVDWGIraCtjOWwzSzRmd3ZSTTZrSXZtWGpn?=
 =?utf-8?B?d1NYdlFyVjVpU0l6VExHMkFsVTBWcjBDYUpZazk2OGJFUldkOWJid3QxaWR5?=
 =?utf-8?B?bUdDTzdXcXJvdWtmTUJNS3FRdVY1K2J2S3Y4a2IrSklzblpDRUlZTzFLYkZC?=
 =?utf-8?B?ODNUZXBHamgrWUd2a2hXeGozZ3pJMzd2ck1wdVdyQ0wrMFlBOFFBRjlvZi8x?=
 =?utf-8?B?MkJZQXNydjZYdjV5RGlnTlNVUUd0Q3k5Ym5BbURtcEJLZVhDOVplZURSRnVY?=
 =?utf-8?B?c1dyVVlqT1hBaDJSMFNObUVBc3NXT2dodEI2OVFRQXZ5dEU2WFozVUkvcGF3?=
 =?utf-8?B?Ti9YaWRXOStmUXZFNnBHeGZvdWdhTVlDUGpFSnNMeUdIR2VmUkk1U1o0czJw?=
 =?utf-8?B?VmVZRVNUcjBmWWsxY2JTc3ZlY09FbEM2YmY2c3NMME1oSUtpVXNZWHVaQkY3?=
 =?utf-8?B?eHNDL0d5Y3Z4ZmJJUk9vNzlJMml1T0syUmgya21sNkdaQVhSVVgrZTVoczNC?=
 =?utf-8?B?TEtic2hrK1VFenE4QjBwM256elRhVFNOQWhHMTRGN3NoYWUxZnJRdXNUZU5o?=
 =?utf-8?B?SXk0WVBya3N5cFBlTHV5RXRtdCtXeWhIaUxuRk8yb0d1cGM5elFSdDJYajZC?=
 =?utf-8?B?NU84bW80ckRhQlNhRGlvcUZGYWRVTHd6ZjB2VU5mR3VzSWFkMy9JdFg4cmlj?=
 =?utf-8?B?S3RKaW9WS0VuOFBMQ3htdGlSejk0NEdhRHlrTXVyVXVWQmdvVEF0ZmRpZ01Q?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7lgfLUO/RCa4Hn8SoECJp0yzR/64Yf6pFnoQKO4udwVD6bp/S1k5PhnxpGhTM/1mY+/gtnDOwXm9QTfZMLV1OblOB+JdykDDx0CKsuLXfWrwgoUoBc1UT/ng/jf1JZyfqLDdDQGJZC/ya+iAJ7k0V8w8Z7MmGcvQv1aO4ptCYixCC+Rx9JpP5d4SKtaxhqi0A5uHUwVmnyKz4JZWmeDSl+33ykd/GwUgLfRVobTwIM4w0jVhUrZnoPcrW57T/0iXBMJLIMutmjeJnKd2g3W3MaGwPtdRWR522caG7LzNrz3H8NXE9Tk7RBCdfDEoESKIssyXAZcMtYj6v1hAhr14NX4gUS5L26xrPMTaZhuymSWy+qw/mr8o2zTNymfJ0jnAXz+UzLPmmnua7MgTILRhwBte0EUlnOTKkQWDcyyAfx7BkiARYHRB5n+4AGgV2eIJk24SdjoYSAECwa07yWprp2lyEpjnsrDC0YvSn8RqKUAKKQ+MSS6j0Gq3q5pXVCJXUDo0Go8WK6B65JaJFtRnioJOgpLTU9EZ41Ha5pVoKVLpwwFrrXUvDyrkaT20A4onhNY82OSOFsxIfl60ha6WuDG/Mz5CC57gOF38e/7nMKo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbd97b1-6cd7-40d0-a34d-08dc17a39515
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 21:30:52.9514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rDLHbb09/3QqcqAJ0q8uzXVA6fdBFZXI9LSfX6DSr4t8POqyyEmbi411l3oTaIKSp7e7xrE1LPbHgyE6oUZEeiy3vELVnYfVt5IP+7xilE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401170153
X-Proofpoint-GUID: 9ekVWRx9E9QFJKQU92bRJRkeT1VEel1C
X-Proofpoint-ORIG-GUID: 9ekVWRx9E9QFJKQU92bRJRkeT1VEel1C
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

On 1/17/2024 2:12 AM, Peter Xu wrote:
> On Tue, Jan 16, 2024 at 03:37:33PM -0500, Steven Sistare wrote:
>> On 1/15/2024 2:33 AM, Peter Xu wrote:
>>> On Fri, Jan 12, 2024 at 07:05:10AM -0800, Steve Sistare wrote:
>>>> Allow cpr-reboot for vfio if the guest is in the suspended runstate.  The
>>>> guest drivers' suspend methods flush outstanding requests and re-initialize
>>>> the devices, and thus there is no device state to save and restore.  The
>>>> user is responsible for suspending the guest before initiating cpr, such as
>>>> by issuing guest-suspend-ram to the qemu guest agent.
>>>>
>>>> Relax the vfio blocker so it does not apply to cpr, and add a notifier that
>>>> verifies the guest is suspended.  Skip dirty page tracking, which is N/A for
>>>> cpr, to avoid ioctl errors.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>  hw/vfio/common.c              |  2 +-
>>>>  hw/vfio/cpr.c                 | 20 ++++++++++++++++++++
>>>>  hw/vfio/migration.c           |  2 +-
>>>>  include/hw/vfio/vfio-common.h |  1 +
>>>>  migration/ram.c               |  9 +++++----
>>>>  5 files changed, 28 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>>> index 0b3352f..09af934 100644
>>>> --- a/hw/vfio/common.c
>>>> +++ b/hw/vfio/common.c
>>>> @@ -128,7 +128,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>>>>      error_setg(&multiple_devices_migration_blocker,
>>>>                 "Multiple VFIO devices migration is supported only if all of "
>>>>                 "them support P2P migration");
>>>> -    ret = migrate_add_blocker(&multiple_devices_migration_blocker, errp);
>>>> +    ret = migrate_add_blocker_normal(&multiple_devices_migration_blocker, errp);
>>>>  
>>>>      return ret;
>>>>  }
>>>> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>>>> index bbd1c7a..9f4b1fe 100644
>>>> --- a/hw/vfio/cpr.c
>>>> +++ b/hw/vfio/cpr.c
>>>> @@ -7,13 +7,33 @@
>>>>  
>>>>  #include "qemu/osdep.h"
>>>>  #include "hw/vfio/vfio-common.h"
>>>> +#include "migration/misc.h"
>>>>  #include "qapi/error.h"
>>>> +#include "sysemu/runstate.h"
>>>> +
>>>> +static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
>>>> +                                    MigrationEvent *e, Error **errp)
>>>> +{
>>>> +    if (e->state == MIGRATION_STATUS_SETUP &&
>>>> +        !runstate_check(RUN_STATE_SUSPENDED)) {
>>>> +
>>>> +        error_setg(errp,
>>>> +            "VFIO device only supports cpr-reboot for runstate suspended");
>>>> +
>>>> +        return -1;
>>>> +    }
>>>
>>> What happens if the guest is suspended during SETUP, but then quickly waked
>>> up before CPR migration completes?
>>
>> That is a management layer bug -- we told them the VM must be suspended.
>> However, I will reject a wakeup request if migration is active and mode is cpr.
> 
> Yes it needs to be enforced if it is required by cpr-reboot.  QEMU
> hopefully should never rely on mgmt app behavior.
> 
>>
>>>> +    return 0;
>>>> +}
>>>>  
>>>>  int vfio_cpr_register_container(VFIOContainer *container, Error **errp)
>>>>  {
>>>> +    migration_add_notifier_mode(&container->cpr_reboot_notifier,
>>>> +                                vfio_cpr_reboot_notifier,
>>>> +                                MIG_MODE_CPR_REBOOT);
>>>>      return 0;
>>>>  }
>>>>  
>>>>  void vfio_cpr_unregister_container(VFIOContainer *container)
>>>>  {
>>>> +    migration_remove_notifier(&container->cpr_reboot_notifier);
>>>>  }
>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>> index 534fddf..488905d 100644
>>>> --- a/hw/vfio/migration.c
>>>> +++ b/hw/vfio/migration.c
>>>> @@ -895,7 +895,7 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>>>>      vbasedev->migration_blocker = error_copy(err);
>>>>      error_free(err);
>>>>  
>>>> -    return migrate_add_blocker(&vbasedev->migration_blocker, errp);
>>>> +    return migrate_add_blocker_normal(&vbasedev->migration_blocker, errp);
>>>>  }
>>>>  
>>>>  /* ---------------------------------------------------------------------- */
>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>>> index 1add5b7..7a46e24 100644
>>>> --- a/include/hw/vfio/vfio-common.h
>>>> +++ b/include/hw/vfio/vfio-common.h
>>>> @@ -78,6 +78,7 @@ struct VFIOGroup;
>>>>  typedef struct VFIOContainer {
>>>>      VFIOContainerBase bcontainer;
>>>>      int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>>>> +    NotifierWithReturn cpr_reboot_notifier;
>>>>      unsigned iommu_type;
>>>>      QLIST_HEAD(, VFIOGroup) group_list;
>>>>  } VFIOContainer;
>>>> diff --git a/migration/ram.c b/migration/ram.c
>>>> index 1923366..44ad324 100644
>>>> --- a/migration/ram.c
>>>> +++ b/migration/ram.c
>>>> @@ -2392,8 +2392,8 @@ static void ram_save_cleanup(void *opaque)
>>>>      RAMState **rsp = opaque;
>>>>      RAMBlock *block;
>>>>  
>>>> -    /* We don't use dirty log with background snapshots */
>>>> -    if (!migrate_background_snapshot()) {
>>>> +    /* We don't use dirty log with background snapshots or cpr */
>>>> +    if (!migrate_background_snapshot() && migrate_mode() == MIG_MODE_NORMAL) {
>>>
>>> Same question here, on what happens if the user resumes the VM before
>>> migration completes?  IIUC shared-ram is not required, then it means if
>>> that happens the cpr migration image can contain corrupted data, and that
>>> may be a problem.
>>>
>>> Background snapshot is special in that it relies on totally different
>>> tracking facilities (userfault, rather than KVM_GET_DIRTY_LOG), so it
>>> disabled dirty tracking completely.  I assume not the case for cpr.
>>>
>>> If cpr is not going to support that use case, IIUC it should fail that
>>> system wakeup properly.  Or perhaps when CPR mode QEMU should instead
>>> reject a wakeup?
>>
>> Good catch, this hunk would break the non-vfio case where the guest can be
>> running when migration is initiated.  I should narrow the logic to check for
>> that:
>>
>>     if (!migrate_background_snapshot() &&
>>         (migrate_mode() == MIG_MODE_NORMAL || runstate_is_running()) {
>>         ... use dirty logging ...
>>
>> That plus rejecting a wakeup request should be sufficient.
> 
> Sounds good.
> 
> Please also consider adding "VM suspended for the whole cpr-reboot
> migration process" into the cpr-reboot mode qapi/ documentation as a
> hard requirement.  I don't see that mentioned at all, then people will be
> surprised to see a wakeup failure otherwise.

I will add something, but suspending is not always required:
  * If the VM has vfio, then the user must suspend it before cpr-reboot
  * If the VM does not have vfio, then the user does not need to suspend it.  
  * If the VM is suspended when cpr-reboot begins (regardless of whether it
    has vfio or not), then wakeup is blocked until cpr-reboot finishes

> Frankly, every time I re-read the cpr-reboot description I get confused on
> what is implied and enforced in this mode.  Can we provide an update?
> 
> # @cpr-reboot: The migrate command saves state to a file, allowing one to
> #              quit qemu, reboot to an updated kernel, and restart an updated
> #              version of qemu.  The caller must specify a migration URI
> #              that writes to and reads from a file.  Unlike normal mode,
> #              the use of certain local storage options does not block the
> #              migration, but the caller must not modify guest block devices
> #              between the quit and restart.  To avoid saving guest RAM to the
> #              file, the memory backend must be shared, and the @x-ignore-shared
> #              migration capability must be set.  Guest RAM must be non-volatile
> #              across reboot, such as by backing it with a dax device, but this
> #              is not enforced.  The restarted qemu arguments must match those
> #              used to initially start qemu, plus the -incoming option.
> #              (since 8.2)
> 
> For example, is shared-mem enfornced?  AFAIU it's not required for now, at
> least I don't remember any code to stop cpr-reboot migration if there's
> private memories.

shared-mem is not enforced or always required.
*If* you want "To avoid saving guest RAM to the file", then
"the memory backend must be shared".

If you are willing to incur the cost of saving RAM to the file, then shared-mem is 
not required.

> What about the image location restriction on non-volatile?  Is it required?
> IIUC "guest ram must be non-volatile across reboot" asks more than what we
> need to document for cpr-reboot.  For example, can someone use cpr-reboot
> to upgrade the userspace virt stack, but doesn't want to upgrade the
> kernel?  Then I assume dax is not required, since anyone can use a
> memory-based file (like shmem, hugetlbfs, or even guest_memfd in the future
> of security contexts)?

"Guest RAM must be non-volatile *across reboot*".
If you are not rebooting, it can be volatile.

> I think it's okay to keep such descriptions, but the document (so far only
> exists in qapi/migration.json) should clearly describe what must be done,

I believe I did so, perhaps too tersely, but I will expand it.

> separated from what is suggested.  The current version is still unclear,
> IMHO, and it'll be good to amend it when adding the hard requirement on
> suspended mode.  AFAIU the suspended mode helps:
> 
>   (1) vfio devices all stateless (vfio use case specific)
> 
>   (2) no dirty tracking required (vfio + non-vfio use case, e.g., merely no
>       restriction on what block type the VM uses)
> 
> Also, since we already have cpr-reboot mode merged, we need a solid
> document file describing this feature.  Maybe "what is suggested" should be
> put into that document instead, keeping the qapi document the essential
> documents.  Above explanations can also be good material to be mentioned
> there (if my understanding of why suspended is a hard requirement is
> correct..).
> 
> For that, feel free to pull the lastest qemu master branch, then you can
> create a file under docs/devel/migration/, possibly, cpr-reboot.rst, and
> link that into the features.rst file.  Currently we lack of docs for
> migration features, but we do have plan to enrich it to some degree soon:
> 
>   https://www.qemu.org/docs/master/devel/migration/features.html
> 
> So it would be good to have cpr-reboot since the 1st day the whole feature
> is there.  The doc can be posted separately if you prefer, so I can merge
> the doc series even sooner (one patch to update qapi/, one to add that file
> to docs/, perhaps).  You can also maintain missing items as TODO in the
> same .rst file, depending on how much work is still leftover, then remove
> entries alongside of your patches merged, which I mostly suggested the same
> to fixed-ram.

Sure, I will work on a doc.

- Steve

