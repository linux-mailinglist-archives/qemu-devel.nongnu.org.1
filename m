Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE84582F81F
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 21:38:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPqBr-0006sV-Qy; Tue, 16 Jan 2024 15:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rPqBp-0006hP-1h
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 15:37:41 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rPqBn-0004Co-3k
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 15:37:40 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40GKEBLG026979; Tue, 16 Jan 2024 20:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=GgyHVldkERhg8gfCZwr73p/OCy+bVWFmPUmzGRp+hhw=;
 b=mapS48u3EGrd5SrAta5fuE/vCWC1lziF0B1UU88MPORqObXDjnn2CM3WzyA6IoTlzkRX
 T2vKUfH05h1PKr31RczpahNxSuXRuaKr3eaTQMYdxUTKrAoej64A+/V2+y32EBt20S/P
 wvz5qr4Q87FVcP2jl/TGCB7xlFU3xEjS0kKbKH+ll5R7PzJcePJXrcavB6EnaL+0Mm1j
 RFO56/2MEdU/CkXviS3Ou+BuktHnWmA5fkJJpAX61JVcKszPcWlzyojTQbu6yTd/oS7a
 WO3nE1br3Cah44AM2th+yR1B/+ZBoeD0SNI1tZ0HSRARXLLJG8cJ2yo8nfYT9isPymXe XQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkqcdwpat-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jan 2024 20:37:37 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40GJHYFm023290; Tue, 16 Jan 2024 20:37:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vkgy8s0dj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jan 2024 20:37:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZbXcA/hi2g7wHVKzHiZ49qq4fonhvn4mczbBqB8uapnNLkiJT4Gq+uLLYOTbhziXUelwsTRiFsLHXBpQxFS3SGcv4yp7mSf1Q6/1Yocz/rb4HLNV1YmRZidV012HKaau2x8lv0B/V0ZM7lZQKSyVFqpcQdHBCPih0eBGLP1yDzuPvtbcVaMuaaEDHj1XOIkXK6GtbQpJt7uYRcHJhx/EegwkMxspcw1hLh+sIYdujGsrM7KFcZ3Czz+sZCbisJ/B73u0qTy069Xh231pWaxi8GSCj+XVF2jV406f+JhUndz2ZYoXT6V7ROrckWR0+fubfSjza0gEaH9LJgHGYtHJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgyHVldkERhg8gfCZwr73p/OCy+bVWFmPUmzGRp+hhw=;
 b=V2aq28XmjrOzmXHAbL8TN0bxZoi8r6hM4ai4oMLhX/78NOMxp1hFOwhwSF/de9fFWWOxRXjr2nmMmiQm+thFbCTcwZrzMlvsVVLJUc2snpzBFp3v9Bb+jvsB9kzVTvPBBTfQXRZd3jv1BelshFX64cbOeppyj44PAglz2QJGRfkU3loRR37w5VkOyizf6B7OLBBvBNDq4BTV+PjDaCz9BUFUFEdTFEHepDafc2UdC8Ajw+lDIwrFYGnCBelw1awjJrxumN3bOFZVI8KLhMIb1Uke7ep5C/WWjwS6qJjxSc/wajTWVk4cWiV5PyqC7dBGJSagJLhYzyPdtDoDUshixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgyHVldkERhg8gfCZwr73p/OCy+bVWFmPUmzGRp+hhw=;
 b=DNJyv7ZUxuCTL6gxvwGfsyC3FfX6Xh4ypudHRjfBhVutXJTi8iag0yY0leQf7YxoH3UyA0VTIt03xxR28wqZPAs0V/qLNlYSjd7+XX0GoCuht8jAG0qXeKWkSh7WMuZG+3eojyQLBCoUDPryjhxHAeGxpMgFdHRQ1fTvodPZ0wc=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CH0PR10MB5260.namprd10.prod.outlook.com (2603:10b6:610:c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30; Tue, 16 Jan
 2024 20:37:35 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7181.026; Tue, 16 Jan 2024
 20:37:35 +0000
Message-ID: <470484ea-ece5-4a73-b84a-eef98f84ed9b@oracle.com>
Date: Tue, 16 Jan 2024 15:37:33 -0500
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
 <ZaTfwOs2g_A4a1pO@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZaTfwOs2g_A4a1pO@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0076.namprd05.prod.outlook.com
 (2603:10b6:a03:332::21) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CH0PR10MB5260:EE_
X-MS-Office365-Filtering-Correlation-Id: ac4216e4-ba90-447d-ec60-08dc16d2f89e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kP9XzpBvnBmzmFG5r5yhceoBk+XlmlLWjkALabyZoKYv3Dr2pbvlKJlTyRmbYQBF38sNoN61YRMtxK1s4iPmexbhTbbsp0mgP9i+WcteNkjxXdQM5eoDL/S2LBqlzowmgpYSwwhvZ3yAwLTwf4LUYU0T1EKRygHrYHFikdyUKhmXKvoJpoS23BDxvJcfukN8JcKc3bpH2ZWJgKyPCG9mKpZmoJIxi1cxzreWUfsh25C+UBtlSQy5Z9+1qhF3vAmXjllH0jOHZFyPSL+z4rpt6EonxA8QbDjCN0xerM5chNwg5zD4X1kgSLQfPXabVPBrtHr5uUaIj5sTJuhTNveZ+fJ0R4f+8GZlK/9r3VaWfdTwvlz5hzpGhQEAKsq237uZc7wCzCiYoO3jvM0768t+wW4MwZbr008PNMV4Z5u3mWovSoGvOnfA4OVimt07S4VYEbO3Qb63yVGoa3SX0BG6fyVutMOB97YnV+oflwU2+lw4gktBtFTeqZs0cxF/j84ET8CgXsrWbZ7NWPsDqguvzcQoy3F+6XeK3axDSHHB1CF+h7XF/uDdwo50Wg1F2aGasI2hmp7JcpxtFwjyEMr16HokzjhcwsLpUJORFp2Qj7bVz31pvJCVxDoLE/XBvKfOVex4pKu83lCiH4qMXXodIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(478600001)(26005)(2616005)(6506007)(53546011)(6512007)(36916002)(5660300002)(15650500001)(83380400001)(44832011)(2906002)(7416002)(41300700001)(4326008)(54906003)(66476007)(6486002)(8676002)(8936002)(66946007)(6916009)(316002)(66556008)(31696002)(36756003)(86362001)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1B4bE5qZ2RiRjB4WlU3Z0Z0a1pSZEtXN3N1Sk9oZ08vTkZHc29vK2g1OVEz?=
 =?utf-8?B?dEJ0YjY0eERnYWtvZWRKTXpCa0dmZUI2eXhVZmdtbDZZMCtPTFpTVEVDZzQ5?=
 =?utf-8?B?V1lyY05VSUJwendXVVBRNm94ODZzcTh6UlNRelFsUFRCQzk4RmFTSnlQSHBS?=
 =?utf-8?B?YzBGUVBTVW8wVnZRSlVHbnJMa3AwbEN2c0hzMW1qRlVCTUVSRitpQzBTMEll?=
 =?utf-8?B?VklSdDNvb0hjUTM5TE9SK2VhcUo5akhBMnE4bjNOdnlWSmQ3Tk1mb0c5NXNz?=
 =?utf-8?B?U1k5d2N3ZXA3dU90N1locGNILzZheVVWQzF6NGVYZ1BpOVpNbTJRaFBUNndM?=
 =?utf-8?B?QnI3V1lpeC9XLyt1R0hmam5yWG1mSUM4SnM3bDdWdndMZnRZcFIxNEdkRm1v?=
 =?utf-8?B?SjNCRy8wajJZVHZyaTAwalNJbnp0M2pKSzR2YXdZb0h5dGR4RHdNVzd3ZzZj?=
 =?utf-8?B?MHNtNFgyWmVFZEl6ZlJyUitCaU1qbkNiVmM5eWVOUWUralZnOHE2akRkWlZ0?=
 =?utf-8?B?aHBPSTVjanZ5SjI3VjRnTXk1cFJSWFByM1FyN2pQek13N1VXRjd3UXdtdHc0?=
 =?utf-8?B?d01udzNJUWxHbFVIL2l3SXEzdjJ5SEM4WjhGbExOaHhjcjl3QlNJNVdHUDM3?=
 =?utf-8?B?a0xmNEpWVmxqSkpzMjduYXZEcUoxa2FKNklFZnpZa0xob3I1b1krYmYvUk55?=
 =?utf-8?B?ZTRaalpKNU1TZ0VYdC9wTTFWWW5aZ1N0UFZsS1pCeFdzd1RMc09VcWFUWlYz?=
 =?utf-8?B?ZmRZR09VQkEzYkoxOVR3QTFHRFBQemNIRjdra0tQcEthaXlrMVdGZE1yclZ2?=
 =?utf-8?B?dDd4WTY2MERKaEQyTFd3UlFPcjgvT1VwRG1LL3ZDeXNnUGRYUGxiRU5uTEhN?=
 =?utf-8?B?Wk1hK3Zsb0J2MlJXT0tuanhrMFRvL0grRk1HN2lDVGdNMHBFZU5xTFBUK083?=
 =?utf-8?B?RkIwZGpCcVYrMW1SQThFYjluOSs4dXZRWEFoNnNwWG13MEhwT2tEZDFOVXpm?=
 =?utf-8?B?eGN1ZzZ3VFBKY3VCM0dwUDJ2M3Bqc2IzWWlJMzk0R08rUFBxZjBrQndyYnEx?=
 =?utf-8?B?TWJ0QTNUTjN0L3F1NXNlaXY1UmNnNXNjYldKTzB2NEZrTldsS1ZDazRTVTVM?=
 =?utf-8?B?ZTBmY1hOeHpuc25pSnBsNGtoaWNTazBKVkVtL3NuZVZ2T1dTQXEyOW1mSXNP?=
 =?utf-8?B?UCtVMU5RMWsyOFJnQmJTdTNraVZzWUM2MDVBNUMyUWJGUmdoOUJSN09saHVi?=
 =?utf-8?B?SGZqK1kwbHQvek5TSnlxaFc1bEpxL3Zhc3I2VWpTSFIxUTZleSt1RXZOYWp0?=
 =?utf-8?B?ejNSS2t0akE2RWtlV2lMSS8vOVNvUlpFZ283R3Rxa0lwekozeWN2a21BcW50?=
 =?utf-8?B?N2VVWGh4UVpkNENORytiNWd3VktrQWcvMHNvbzc3NlpJZVk4KytjcE9aeXdu?=
 =?utf-8?B?L3JONjFMRnRaVmp3R0hlNlZnNFBTQm1SQytJU2NUa2pOR0NuU3dnMGd2NFQw?=
 =?utf-8?B?ZmgvcVh6c3RFSzA4WjlIM0cwNFBWRG9LYVdzaDZ2Z0pZbmJON21qNXlNei84?=
 =?utf-8?B?SGxxVTBTUzQyV0lFOUhDUnd5V2loOENaamJiZEVXWGF2bm00YSsxVkZZRlk0?=
 =?utf-8?B?VkZpbHFOTExjaWwyeHFQQ1k5N3IxbTdlSkpSYlMxa3VpMVpVQmhEdmpFS2Vx?=
 =?utf-8?B?VUJtRW5rcXJFSFVyY2I1NW5zcnJRbG5ESDk4WWVJSWVHeS9La3p0cmxvN3ZX?=
 =?utf-8?B?dDJnSHdia2ZHU2xpTkpud3hFbUJlRGxTbnl5R3ZWK3RaWFhmaGIwTkIxREY3?=
 =?utf-8?B?L3h6VnRmUjJQT0RZUDBXYTk1bXowd0QvMFFyM1hjMU5UUk01eXREUVVLYUll?=
 =?utf-8?B?OHFocit0Z3Z3ZmI0YURFcWdkQmVHZTI4YVp0UGpOZmdIRDA0QkxiT1ROK1VW?=
 =?utf-8?B?eW9NelJtaVlzdlBvUGFJby9PVmdqZFdXSC9mQlh1SHZIRURuS21CRWpqd1Rs?=
 =?utf-8?B?bEhTNDlQaEFFYkJobkdhMEU3SmdpbFlscDFJbDl2MThoc2c2LzZjdmpHUG9F?=
 =?utf-8?B?eDQ4QUhzOEJYdHZKUDBIMUxPTVgrYmdHZ0tUMUFTQVczUm5meUhySk1jMC80?=
 =?utf-8?B?UGp4VjBaVGcxY2RLQlNYR1I1N0l3K056UTh5MzNjbW41NlpiZWRFS3VmR2hS?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TANroScmlJrvdB3h+ailXLhgf/KoZXYgUCBJmzz6KdhXLLfQBeaY+ee+0vadTP2DhisgrunSV+sGOzc1rbTu1+OjY7LAyOwFLdSErCiDqFzZQXTOwoGXnx1TwTGTi+n1uhr2ujX2r/WaV4dktqJk/0IXHQ+ASSlD/zhBNlD1Q2p/KL7JABwcHWPnA9r/MPd7CMcoO8pDHQxycNjBWZ488QeTweUgQdHgWCZiRgX8OLQu8nzbmNRsQCw+HWqXrdQRjfdtjaQ8MCAGijLSnOo6KnqAcpw8/HTjuBxlTs3SpUgaXHJagVaLkZWQ6UAkceXqJoZImzdT6jjimy8Rr4EM4YtI818FFy2P8tPAr8EILyPrNY1wF2vRAn+S8sldc/YJZkFckby8qdyUbJkAJ/uKjV827qAVwPq6FGMz1nrllRkdUPc6ba7noKokHvM7u9JBwP7GRb19Vx32WCafwrEiXmg1LqELD7tybxNx6B3AiELPB4RUPliyzJqkXbEloiqtfAeP3MV0tQF6Vvnm61E5bnxC4Etc5PLhz7sf+ofdHQc38vUqmRkvJXHivdUy+nyooz7Oih2Ui5oDSmZmUYilRGDRdlBKBpOhgiPrqxZX/84=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4216e4-ba90-447d-ec60-08dc16d2f89e
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 20:37:35.0950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jozqgwtu2OkSeHlmOgq9rUMYBYcEn/NSL2BZf+wLAePlCxjcKf0KJirp2UAm7izJ0FXT+vsIxPusXPuobtsIWM8mWq4tTGH1+OLI5uyICL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_12,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401160162
X-Proofpoint-GUID: 8ioQLLAnwvnT0WL62FfBJePFTYk39JJg
X-Proofpoint-ORIG-GUID: 8ioQLLAnwvnT0WL62FfBJePFTYk39JJg
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

On 1/15/2024 2:33 AM, Peter Xu wrote:
> On Fri, Jan 12, 2024 at 07:05:10AM -0800, Steve Sistare wrote:
>> Allow cpr-reboot for vfio if the guest is in the suspended runstate.  The
>> guest drivers' suspend methods flush outstanding requests and re-initialize
>> the devices, and thus there is no device state to save and restore.  The
>> user is responsible for suspending the guest before initiating cpr, such as
>> by issuing guest-suspend-ram to the qemu guest agent.
>>
>> Relax the vfio blocker so it does not apply to cpr, and add a notifier that
>> verifies the guest is suspended.  Skip dirty page tracking, which is N/A for
>> cpr, to avoid ioctl errors.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  hw/vfio/common.c              |  2 +-
>>  hw/vfio/cpr.c                 | 20 ++++++++++++++++++++
>>  hw/vfio/migration.c           |  2 +-
>>  include/hw/vfio/vfio-common.h |  1 +
>>  migration/ram.c               |  9 +++++----
>>  5 files changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 0b3352f..09af934 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -128,7 +128,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>>      error_setg(&multiple_devices_migration_blocker,
>>                 "Multiple VFIO devices migration is supported only if all of "
>>                 "them support P2P migration");
>> -    ret = migrate_add_blocker(&multiple_devices_migration_blocker, errp);
>> +    ret = migrate_add_blocker_normal(&multiple_devices_migration_blocker, errp);
>>  
>>      return ret;
>>  }
>> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>> index bbd1c7a..9f4b1fe 100644
>> --- a/hw/vfio/cpr.c
>> +++ b/hw/vfio/cpr.c
>> @@ -7,13 +7,33 @@
>>  
>>  #include "qemu/osdep.h"
>>  #include "hw/vfio/vfio-common.h"
>> +#include "migration/misc.h"
>>  #include "qapi/error.h"
>> +#include "sysemu/runstate.h"
>> +
>> +static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
>> +                                    MigrationEvent *e, Error **errp)
>> +{
>> +    if (e->state == MIGRATION_STATUS_SETUP &&
>> +        !runstate_check(RUN_STATE_SUSPENDED)) {
>> +
>> +        error_setg(errp,
>> +            "VFIO device only supports cpr-reboot for runstate suspended");
>> +
>> +        return -1;
>> +    }
> 
> What happens if the guest is suspended during SETUP, but then quickly waked
> up before CPR migration completes?

That is a management layer bug -- we told them the VM must be suspended.
However, I will reject a wakeup request if migration is active and mode is cpr.

>> +    return 0;
>> +}
>>  
>>  int vfio_cpr_register_container(VFIOContainer *container, Error **errp)
>>  {
>> +    migration_add_notifier_mode(&container->cpr_reboot_notifier,
>> +                                vfio_cpr_reboot_notifier,
>> +                                MIG_MODE_CPR_REBOOT);
>>      return 0;
>>  }
>>  
>>  void vfio_cpr_unregister_container(VFIOContainer *container)
>>  {
>> +    migration_remove_notifier(&container->cpr_reboot_notifier);
>>  }
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 534fddf..488905d 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -895,7 +895,7 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>>      vbasedev->migration_blocker = error_copy(err);
>>      error_free(err);
>>  
>> -    return migrate_add_blocker(&vbasedev->migration_blocker, errp);
>> +    return migrate_add_blocker_normal(&vbasedev->migration_blocker, errp);
>>  }
>>  
>>  /* ---------------------------------------------------------------------- */
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 1add5b7..7a46e24 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -78,6 +78,7 @@ struct VFIOGroup;
>>  typedef struct VFIOContainer {
>>      VFIOContainerBase bcontainer;
>>      int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>> +    NotifierWithReturn cpr_reboot_notifier;
>>      unsigned iommu_type;
>>      QLIST_HEAD(, VFIOGroup) group_list;
>>  } VFIOContainer;
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 1923366..44ad324 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -2392,8 +2392,8 @@ static void ram_save_cleanup(void *opaque)
>>      RAMState **rsp = opaque;
>>      RAMBlock *block;
>>  
>> -    /* We don't use dirty log with background snapshots */
>> -    if (!migrate_background_snapshot()) {
>> +    /* We don't use dirty log with background snapshots or cpr */
>> +    if (!migrate_background_snapshot() && migrate_mode() == MIG_MODE_NORMAL) {
> 
> Same question here, on what happens if the user resumes the VM before
> migration completes?  IIUC shared-ram is not required, then it means if
> that happens the cpr migration image can contain corrupted data, and that
> may be a problem.
> 
> Background snapshot is special in that it relies on totally different
> tracking facilities (userfault, rather than KVM_GET_DIRTY_LOG), so it
> disabled dirty tracking completely.  I assume not the case for cpr.
> 
> If cpr is not going to support that use case, IIUC it should fail that
> system wakeup properly.  Or perhaps when CPR mode QEMU should instead
> reject a wakeup?

Good catch, this hunk would break the non-vfio case where the guest can be
running when migration is initiated.  I should narrow the logic to check for
that:

    if (!migrate_background_snapshot() &&
        (migrate_mode() == MIG_MODE_NORMAL || runstate_is_running()) {
        ... use dirty logging ...

That plus rejecting a wakeup request should be sufficient.

- Steve

>>          /* caller have hold BQL or is in a bh, so there is
>>           * no writing race against the migration bitmap
>>           */
>> @@ -2804,8 +2804,9 @@ static void ram_init_bitmaps(RAMState *rs)
>>  
>>      WITH_RCU_READ_LOCK_GUARD() {
>>          ram_list_init_bitmaps();
>> -        /* We don't use dirty log with background snapshots */
>> -        if (!migrate_background_snapshot()) {
>> +        /* We don't use dirty log with background snapshots or cpr */
>> +        if (!migrate_background_snapshot() &&
>> +            migrate_mode() == MIG_MODE_NORMAL) {
>>              memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
>>              migration_bitmap_sync_precopy(rs, false);
>>          }
>> -- 
>> 1.8.3.1
>>
> 

