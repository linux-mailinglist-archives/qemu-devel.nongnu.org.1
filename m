Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F17A82F811
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 21:37:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPqAc-0004YG-8p; Tue, 16 Jan 2024 15:36:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rPqAZ-0004SV-Sk
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 15:36:23 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rPqAX-00046X-UC
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 15:36:23 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40GKEBgi026972; Tue, 16 Jan 2024 20:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=lZXY9RP1Uvgk1E6NEr5HRSXNJIJAs7FAssPSlHYsNQk=;
 b=b33VLRuw8cfNPCwXj/4dKFNXzE7goTIQ0UF0eSLaNW0v2d2TlMomFf6XiaKfR9W52Vic
 jkkCL9L3tWh4Cwii0T5HgmWzZ95FYL0D0cHRAqmu1g1MZnu6k1dFSC0nAeIpaaw5R0cd
 iD6NSnnz8qGwcTKaBnsNjJ2fR0JY/9aDZFTmubblcfbnkyHB77dgZ+QU38mDsfL1gXRo
 DQDpHLCJHnfUFxUWzT7q+EXAPhyHAfX67QtMdwwXVuFRKgiNMaIIB1cnGjdxqplCwj2C
 AgZ9jxEo6+pGREWirFiokrcI0adsWN8IygLrBQubX3qfSkRla8BpEixvqM+OgiQA9qF6 Pg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkqcdwp86-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jan 2024 20:36:20 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40GJ58aN020140; Tue, 16 Jan 2024 20:36:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vkgy8sdyg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jan 2024 20:36:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LS00/JTg3JfywF7XjSLcW5Sklv8mIaUI6F3e4JpzLe1jCXU0BpCYcVRFNCm713of/zV2Q2TExZryBYAXJ39fJ70RJVOidn9G8kEmEX3s8t+JFmomQ15Qcb0S+KMHbreUnpahUDa1teup9L40qssUBjPzl5Ywcg0bhMdcpqLmlmB4kkvGEmc4n4Eoe+k3Vg/mh5NqPWsYmttNHyoudUkchQZLcDH8GHGSYtm+vdjPUKWh3npaeZzs3fWVuxuKNPI0bU6s6uBFy80QDn7hYF0BF3KptzwLDYrSbvJQDim60vyy6bcoHKB2mogKQIjZJvQi3GdS3ZhFdA7zWkW6OgIm6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZXY9RP1Uvgk1E6NEr5HRSXNJIJAs7FAssPSlHYsNQk=;
 b=g/5XihPzPzEene8fwL0/SPlPmoK0Hja91IbtWMDh35EY7aYILSxqhwbJlXKQORRjkvvpdOem9HJ2U21h1IpzlygZq6Jimj4aDfCiEYhuAOZzOWEu4OuAbJvmC/8fC+Ver0SHiEy2QXAOA0g3abF6v7cV/szJ/pyphXspfh8Pk+CMUvf8T66BrgM3V/jrmqS/LquMYvbeB3Q1a4RMTypeADvr3WhFtcuCDHRCddGKGRjN+EWxgzOMlyGUqiPxh/A/OVpmAHtbqzl3odrz841sFh8iiR3tZuuEqGxDAwHNOiCH3RTlw+KJBX0tF02kbwWpTzD5j0cwlSLxKobV7OV8gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZXY9RP1Uvgk1E6NEr5HRSXNJIJAs7FAssPSlHYsNQk=;
 b=HWrX19UnOkMyMzNucaa/SV37n4vzFA4rPvh8pIpqOj6K4v7aDWRI1whbboI6JhlXqyrLjk0DSws/GUu2Gv9F5lQShtVSK4nvs9VBqD8qRfFfj1c0PTRQpvNNYV1LbMWd49b6AHhj9DNUjSj9uJa/vJ/dLa0UjJVpipO3F0cPS98=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DM4PR10MB6208.namprd10.prod.outlook.com (2603:10b6:8:8d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 20:36:16 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7181.026; Tue, 16 Jan 2024
 20:36:16 +0000
Message-ID: <082287e0-2b1b-4233-b1f3-4ab3dc502377@oracle.com>
Date: Tue, 16 Jan 2024 15:36:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/11] allow cpr-reboot for vfio
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Cedric Le Goater <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
 <20240112143830.377d9f0f.alex.williamson@redhat.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240112143830.377d9f0f.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0076.namprd05.prod.outlook.com
 (2603:10b6:a03:332::21) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DM4PR10MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b27a06-a4b6-41a4-4265-08dc16d2c9f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8l0nLR+UmaNJH8YUJaJLD2BLERGCC5Thkz3BaXuD484uUtka+cgNBH+NDsk8G2xxA/B6SFJeP6xkv11LTgNRlMQUIRn5+heRUdZrbIMitIWWXnFB00et465iH2Xri0iIiAJUTILbZiJ0hnkqPaKihNTejdyDHzL03PyxIwBDQFhyLKabUMH4CD3fwGRXzUEAfVu3QhVono9nB1MfPo8E9GaFut0MPoTtYGA/cO2KZ73h2T14PqZzET7WBqZfgmH0qoZlJu17f92NSdtUH3aqr79vvv3PMt+/vgCJw+vYgQ3lIAldYaqi72oA4vLf4FBuDGy4DVj/IJdoMogkd+Al0oYcwD812LV2l8++8dqtBptOxLDfqHgHM1Ksj4wuYn+KgOUo1yxfiQjobuozNq2mhT6EG7UICqTjlzAl3H1CDCSRH3/H5gzHU1VGyHCZfut3CDxCFKXjhqpKiod/pzTsvL81rg5umvXRZq53uLsjQ+hIQsVmto7JCj+tiF54RaitTZX3jxxKLiovnx+8IwYv49thCXNTbD3BzvopRBbG1rinPFM69wZtBPOl6e5hGArjH88h488stamNH2u2iF07+iwBA/VbNa93tqS7l1V+ws4OqZ+GN84a+Td7G2+TvHcn6w3upnRkGJVSqehf4dF+Ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(39860400002)(376002)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(41300700001)(53546011)(36916002)(6512007)(478600001)(26005)(2616005)(6506007)(8936002)(2906002)(5660300002)(7416002)(66556008)(6486002)(66946007)(66476007)(316002)(36756003)(6916009)(8676002)(38100700002)(4326008)(44832011)(86362001)(83380400001)(54906003)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHN0UmM0R1BYWHlrQVpCb1BHa3RaTXJhUkFaMTh3d0kybEc3YVN1NXY0OTFL?=
 =?utf-8?B?WEpMVUx4YUdYMFV0UWk0cHpZRVNMNERydjkra2VTUWVUV0RPck9hU2E1MGti?=
 =?utf-8?B?bXNYN3h3OHZ1Qzh0OGVmN3ZZY3hIdmhRREsxZlBON3NUZXRmSzdld21FaFhL?=
 =?utf-8?B?bE9wbmh6TmxpQUU2eHhubEFLRkYwemFsK0loZW9SSWdYM0VXZ2xmdXMwWTFW?=
 =?utf-8?B?M0E0LzB6WTZCejh2VE9KM00wcmNnY1l4YUQ4eTVXdG9NcDNpUGJKTE1SeFRJ?=
 =?utf-8?B?T3R6dmliM2lWcnlyVEN3b25tazlTL0hyUHJmM0ZYSjVjQ1gvRnI4N2JTWDI5?=
 =?utf-8?B?U2tFN2ozTkRjRVBlWWxGM0d0RGZlRTdVK21PcituR1hHazlrbCtJcWJrbEtL?=
 =?utf-8?B?d0FrTWFlbW95ZkdqYmtueW9lQTZhUEFiV08yaGdXbkdZT0VpR1VxTk9ENXA2?=
 =?utf-8?B?SS92NG5aREdYWGN0dXpycnU5VTlHZTJSdDRveWFYR1VqcXVxTFdDdXVlVWxV?=
 =?utf-8?B?N0xhU2ZRSjVRd2w1aFZtNEd6ZHRLWWdSMzJUN3crY0gya0tjL3F6eURZamhI?=
 =?utf-8?B?c3VFSjkwZ1hFK3Y1QXVEUTU2TXFwUkpYaTIzc0MycU1vbFhsMVUxVVBteVBV?=
 =?utf-8?B?NER0ZmRLbUpVdmhxS0RVY0V0d2dwVnpRYk42Ry9kSnlKMkZ5OHVPUFloYVUy?=
 =?utf-8?B?cE9wMGx0dWYzcU44Q2xvbEFuSHZtNlo2VFVpcnE3a2ZSYStrT1VuMUtjemRi?=
 =?utf-8?B?Q0p4T056RzNtUk1sMzNUWmhJWnJWT1dLMmhFcVBhSVZRZ1luMjZpaDVQcm9z?=
 =?utf-8?B?WmpVdGVXdGQ5WE9QS2hvV3hPdHZnRFNGcWRPUUtVenBZUjhTcWxGb1VqQllr?=
 =?utf-8?B?am8zQXVBenlpV3Vpa055Wit4K3lUU2lUNXdTUFlLSDg5UzVjZEZkOC9ydXRz?=
 =?utf-8?B?VCtGY1JESjN5YmcweTFRc3hsUUxOcVlzWGpWcmRmNE9aSFYxbTM2Z2lKZ1lr?=
 =?utf-8?B?b2hDam1vRkorSXJ1dm9Lb3JNVzdwZHRrMzNxdzgwYktwd2NLOWNQeFROcW0r?=
 =?utf-8?B?YnpsOU1jbUFFMThseXlRVk5teU0zL2tYdzdlbU1HOHFobmphcmpHOVp4VzVu?=
 =?utf-8?B?VXQ1WVR2ODJKcnhSL1l4VlFKTUtMMEszd0tUT1B5TGVjTVNXQjNpV0JacFk2?=
 =?utf-8?B?Rkp1YjliRy9USlVXbVRKRVhRQmFwOWlJRVdKNHFiRzVXZzNOeVV4ME9rTEtL?=
 =?utf-8?B?WGxpTHR4aUozOGFPYkJjRS9pZ1RnaEZ4dVpjWEF6Y0JJU3lvOXRhcWl4OFJz?=
 =?utf-8?B?STFaTXV3REpPeVNyMkdYQXczTmc1NlRDWWR1VFh2UlhBeFhaWmVzbkxvakM3?=
 =?utf-8?B?OGFtOXM2dkRIMnd5NlM0dWw1NTdCOHlMOFZVcnJCRGpNcXhLVlFuUWRXMTQ5?=
 =?utf-8?B?NFBWY2lraGxmNzlNVjRoQXpuQTI3MStwenN5YXBIVEtpN2FaMVozVUJZRU94?=
 =?utf-8?B?WVE5enc0Ym54bWVIcWVoM21FY0wyeWtJRmZtNWYxeU45YW4vVitoUUFPS1pK?=
 =?utf-8?B?bjVpaytTRHYrUjB1OGNwQ1B6NEl0S3IyTE1FckNPd3dWMUJYRVcxTy9ldE9p?=
 =?utf-8?B?ZnJGWDJMb1BPTVZ3Ujd4SmxidmJvOTA4U2w2d2Nub0FXMVlQc016YVNBam5s?=
 =?utf-8?B?bXp0ejRvRVEzVkNiazhBSXNyTEdacHlmbGRsV1p2dTU1b3BTQ2VSTFZVUXZa?=
 =?utf-8?B?aUsyZTRYS1hEbkRXcW9sMWh4ZVFsaUZSb25iMlZvTTVuaU8zaXNyMnk3UUh5?=
 =?utf-8?B?a3BHWHBXSlB6akxuUHdSRTdtODFzc2wwTmt2S3pISzBKVGJaU21GbWFGbk9Z?=
 =?utf-8?B?OW1GQ2xvbHNmMkNWWlVvc2d0NlVFamYrWU1TY0RTektxVzhZeVJ6a3ZubTA3?=
 =?utf-8?B?MlV6dWtmR2hVSzBXVEFHa245eWg2ODVJZ2IvTzh2bVIzV2d1MGdWR2VpZ3gy?=
 =?utf-8?B?dU1Bbk5XRllmV1pVRC9weXRaS3lxVEZ0MVh5S0sra04wZk5YVUVMVFVSV29X?=
 =?utf-8?B?T2I2WHY4QmJqeVA0WXBwZWtLSEVkMGFDa0c4dGR6cDRmbDYzMkFFYW45RVQ1?=
 =?utf-8?B?Q2wwRXJWdmRERXRKNUZIaVBzeU1oTEVETjBrdFIweTlhNTNRUk1uQ1JzZGMr?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X6uOsPMvEFRb6RHNpCzpCcjKKHozaEUIg4zqNEI1A6krJqXzf0/dg8zUAQQ2UpYhuPe0bRWm8zLINAWSG5iYRfHLSP8dr48ZGGnwLopP1uP10wGTQJ7PBG857a9JCnQLhcLxkYwRDVJXQ2iQnFYPk0EDD4EvS6sg0zNoYm8RZJ5RiktTQApBzvFndPix0DcKNzDgNfxjk/2df2mcvLJZHUIQx4a41Tta/S9yHE6oQWFvicMRqpM5uHy09z8eAsseTXuM56FHZo0riLRPIeEm5ut1dIgnXg2ySwZC4JE59qkuIoF9OJogPpkSnUG+B1sEjmNCyYvuZ3IqctLf6MO9UJoh+xY89vlLBCV6AO/Ez2Gx9xECkVBawrGPHZ86eSSs6dDlvqxdKNMOzpLz+jQG+SobTPo0beWDxm6g36auoJYjVd56U1KNiffqfMFv1mANCVE3tyaRz4+3OT8DB+Jsf9RU3WAu13EXx5xNgqQ6M4Uo3ckYKs/Ad1ttDX8lRLHMJf1wyiYQIjmt9fOBFvCn9/vI9GZS/fZYco8Q8wHPB6QEMPzUfGTroeS0cI2URau/otZV8M9DY6FyjB+iQbCoKHiksdOff6x+V2RQXvRGjWI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b27a06-a4b6-41a4-4265-08dc16d2c9f3
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 20:36:16.8714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCtM0x3e9qfJz0XebPXVsSZkH12lfs8NYJfaV+mxkDN/vdqqF3VsZcx5R2MK9CGRoYIAnOr1LViuNm1M4tJuvtN00Yr3Dkw62pKvE+Qfojw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6208
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_12,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401160162
X-Proofpoint-GUID: 9xVyJ-hE2-HASnT56QGXmybBPFBDZwyK
X-Proofpoint-ORIG-GUID: 9xVyJ-hE2-HASnT56QGXmybBPFBDZwyK
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

On 1/12/2024 4:38 PM, Alex Williamson wrote:
> On Fri, 12 Jan 2024 07:04:59 -0800
> Steve Sistare <steven.sistare@oracle.com> wrote:
> 
>> Allow cpr-reboot for vfio if the guest is in the suspended runstate.  The
>> guest drivers' suspend methods flush outstanding requests and re-initialize
>> the devices, and thus there is no device state to save and restore.  The
>> user is responsible for suspending the guest before initiating cpr, such as
>> by issuing guest-suspend-ram to the qemu guest agent.
>>
>> Most of the patches in this series enhance migration notifiers so they can
>> return an error status and message.  The last two patches register a notifier
>> for vfio that returns an error if the guest is not suspended.
> 
> Hi Steve,
> 
> This appears to only support legacy container mode and not cdev/iommufd
> mode.  Shouldn't this support both?  Thanks,

My bad, thanks! I'll move cpr_reboot_notifier to the base container, and also call
cpr register/unregister from iommufd_cdev_attach/iommufd_cdev_detach.

- Steve

>> Steve Sistare (11):
>>   notify: pass error to notifier with return
>>   migration: remove error from notifier data
>>   migration: convert to NotifierWithReturn
>>   migration: remove migration_in_postcopy parameter
>>   migration: MigrationEvent for notifiers
>>   migration: MigrationNotifyFunc
>>   migration: per-mode notifiers
>>   migration: refactor migrate_fd_connect failures
>>   migration: notifier error checking
>>   vfio: register container for cpr
>>   vfio: allow cpr-reboot migration if suspended
>>
>>  hw/net/virtio-net.c            |  14 ++---
>>  hw/vfio/common.c               |   2 +-
>>  hw/vfio/container.c            |  11 +++-
>>  hw/vfio/cpr.c                  |  39 ++++++++++++++
>>  hw/vfio/meson.build            |   1 +
>>  hw/vfio/migration.c            |  13 +++--
>>  hw/virtio/vhost-user.c         |  10 ++--
>>  hw/virtio/virtio-balloon.c     |   3 +-
>>  include/hw/vfio/vfio-common.h  |   6 ++-
>>  include/hw/virtio/virtio-net.h |   2 +-
>>  include/migration/misc.h       |  21 +++++---
>>  include/qemu/notify.h          |   7 ++-
>>  migration/migration.c          | 117 +++++++++++++++++++++++++++--------------
>>  migration/postcopy-ram.c       |   3 +-
>>  migration/postcopy-ram.h       |   1 -
>>  migration/ram.c                |  12 ++---
>>  net/vhost-vdpa.c               |  15 +++---
>>  ui/spice-core.c                |  19 +++----
>>  util/notify.c                  |   5 +-
>>  19 files changed, 206 insertions(+), 95 deletions(-)
>>  create mode 100644 hw/vfio/cpr.c
>>
> 

