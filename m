Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8597874844E
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 14:38:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH1mA-000815-Om; Wed, 05 Jul 2023 08:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1qH1lm-0007qb-Sj
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 08:38:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1qH1lg-0003vq-Hx
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 08:38:02 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3655uRSk015821; Wed, 5 Jul 2023 12:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=QA5JmvvXdecMx6eNvvd9NDCuqgMB0fV/d4dOPHcsf+o=;
 b=m9DVz3YD9QG7Rr63M4kxLlIMUXwkKo5KzIrgM8WJGpsxaSBta6D2jRR2FomX5FrfxavO
 9Zl2BWv/nMI71+UzPvoNM/yqxAoaT3cInsaIyp61WEB6AC5CKzh7cVKgb8iiUVKsuu4b
 Fy71YxWm83oUygTyyGFrNzORzAmjjeAPUtrjxRSKFsc8gRy1GMwYXsDKTnvhnFRtHZk4
 teA1ctCEKCAMyQwqatOifHDcHq0Tgf34GISDELr/1oStTloIq19s1p/mb+BJgXuFms2b
 PQo/4PXcV2qVPKc9/ZOWozV8oEsr+jNKKcLCKXBoeuD4i9UW24uZTefk4MLqfxVNNbdU sw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjbrte9t7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Jul 2023 12:37:53 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 365BECM3020686; Wed, 5 Jul 2023 12:37:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rjak5k1yg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Jul 2023 12:37:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFx/dNtXax7jK0O44+9LwZzykXTVxzUg/zhbo4NFhdJ7vostMW0Jv6phIyQxT2zJB/B2wmYSDdNwuyI/beRMHFS0A02VMljvtKqmLFMdkpd+hlGEEePNpC+CcmtLx00NvBwpWaUmmf+xSGGLB2nuras53DBS4n4a7zX7RZAS1NJVCv/fwo5tZ3iNekQL/Kr+bBV8b5wTgTy1OZ8ezun0W2Dh5CCaxZ+V/4w8Rs3ehlY5TxXTwKvSHXDHMEEOt/wwVHvzGt8Q70deI3tTFyGJolug9jilBeYh+GpDG0QPth3QPQM4Io5kba9ZflnAyKsbTtu21LTxKq7DeO+vSM2iTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QA5JmvvXdecMx6eNvvd9NDCuqgMB0fV/d4dOPHcsf+o=;
 b=QOFg3G0nAAdZ3QlTDuoOEI+uWZwFNOsYRRKjk1K08hInvl1NxA5ZcufxCi3PBa5jz2IzYYle2d3oWSDxG/3OJ8wDMl7lij3qltO9dvtOyUNtrwyAaUq9zBIqnMhw+CZudF6jZW4t1y0NeDvVOP9ICqGIZ2t2NgTc1eejUJ22+RatUa+1S/NRb7dCsF4E8NlZomFwgJYS9ezOCeuOdVHiXwG3cNBSBc0IiiyWjYa8pZbsASKNyJRaK+wbAkLOKTc+EhRcb/SGRHVQldKs7tx4e05ugq8GCSX4FowCzFQqIOsCPlodz0xjyB50fTjsutRqmXB5j06Ge/sYP4BuLocaMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QA5JmvvXdecMx6eNvvd9NDCuqgMB0fV/d4dOPHcsf+o=;
 b=DxnC69HZrxbW8XWiqrk8C2g4fCYuuIq+B+Yx4xgjTia295I4umsrvh+OgCMchAn1/JLqMalefFxwZUTZlV8LZfr7V3nnrJbw3k3WsPV/k1F+5HR/EFphPxp4U2oFe9jQGyfpCx/x16kORPdFYGYziOkuAJS4xKbWEZJ4mdv6JpQ=
Received: from SA1PR10MB5841.namprd10.prod.outlook.com (2603:10b6:806:22b::16)
 by BLAPR10MB5089.namprd10.prod.outlook.com (2603:10b6:208:330::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 12:37:50 +0000
Received: from SA1PR10MB5841.namprd10.prod.outlook.com
 ([fe80::915d:8c59:a23b:7b42]) by SA1PR10MB5841.namprd10.prod.outlook.com
 ([fe80::915d:8c59:a23b:7b42%6]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 12:37:50 +0000
Message-ID: <aadd585d-a5ab-edb8-99ab-b6b84acba9f0@oracle.com>
Date: Wed, 5 Jul 2023 07:37:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4] virtio-scsi: Send "REPORTED LUNS CHANGED" sense data
 upon disk hotplug events.
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Venu Busireddy <venu.busireddy@oracle.com>,
 qemu devel list <qemu-devel@nongnu.org>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20221006194946.24134-1-venu.busireddy@oracle.com>
 <CAGxU2F6rMpUAeKm=gnFYwaVrGPj7ykPFR+_BEC_tLw_JgnnWyw@mail.gmail.com>
From: Mark Kanda <mark.kanda@oracle.com>
In-Reply-To: <CAGxU2F6rMpUAeKm=gnFYwaVrGPj7ykPFR+_BEC_tLw_JgnnWyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::24) To SA1PR10MB5841.namprd10.prod.outlook.com
 (2603:10b6:806:22b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5841:EE_|BLAPR10MB5089:EE_
X-MS-Office365-Filtering-Correlation-Id: 0501230b-76f0-4cf7-43c6-08db7d54a512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eqIJpV97qGHrEO4vScZrYhaZ5fIcYCWZv4IxWco7cuakYlzFrwdSyqVTKNavEkgz36Gxfx6A2va8gqYg3xs8Gn8LnKGNzvMztqKF9JxQ7S4zEfIyMQ2hHgQEtLkG3UWJPeH5fUtuuBzYfzrVVlLP9jbjyap4r90asKXlMiXL9ja0ntiQKlzSx0ud3HX/XVKsqn7bEoW9/Q99XoRdLyBzxWzZfRYx4C2ucBrnk/4kD7ZPp19n5jIWqzsD13ZUYIAeDmNvRii4puU+pWG7eKCF3bz3AWvcXPDxTklEoNJTFAXkqyOjiO+Tx1X3A5JVXrKub6USIGpffU9kemsp/exdK2k7jpwgSWg0sO2n7F2c57M5LqHL7OjMO9KOYo2e39EbmpxhGIYBQNxt33D+GSoUyL86ku9JvBZa3D/E6tHTfNBVJKcbQ2cHU6T05XVD3XEgirt13axZiip2ANoxx2S3qghw1Had3e95I22zgwEbxIBy743jG97Gduu5MSxBSlnRPfA40ULwdsXmREIWHlbyFaV+OQqW9kccUvrxPk8FlRny00+WB3oNBV7PTrDUf+nM2SlMlWheAJHtqTA7MQp587eERXbQUn5bADSfSNn71CSu5CvZpn4wJG7mZfBL2S/P5fC4b4LzuXiXd7lNXqoY3xCK3Z1VcQuvKGWEG8F3Q9QkTFUJqUAz7JFHOOIE+1fS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR10MB5841.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199021)(8936002)(41300700001)(31686004)(8676002)(36756003)(54906003)(6486002)(44832011)(316002)(2906002)(5660300002)(66476007)(66556008)(4326008)(6916009)(6666004)(478600001)(6512007)(966005)(86362001)(38100700002)(186003)(31696002)(66946007)(2616005)(26005)(83380400001)(53546011)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkRQMyt4dlh5bm1JbHZiaTJWZGpubWtOODJNTDlMYzdGZnRDK05kSkYvRmxW?=
 =?utf-8?B?UFQrdHhKWG93OU1xcVh2TU9hV2R4SEZob2t2UEZLK3dCZENOWU1Ka2R0aU9C?=
 =?utf-8?B?N0czdjZIRmQ0QzJaRzlXeW45NkVQUktoZ2MxQXBpNmRWcGZ3bkdIcDFYeWR0?=
 =?utf-8?B?U0tPWEhNdFFWWDJWL3VUSXRtUFlYR2h3ZUUxazlsZ2ZIMVI2enEzRDNML0ho?=
 =?utf-8?B?SjdMUFhrdkhJZkk2dUFPQUN0bEZvcWdQa2RHc1YzaVhVUFNsUWR2Yk1ReXFr?=
 =?utf-8?B?RHYyaXdWMVFqa1pTWDV5cW0xMkFwMU9WempJM3RZVjZyVXppWDBjQS9xb2Yv?=
 =?utf-8?B?S1A5V2NaMGhnQW5EcHBLaVhtcVVSbFZRYnlOcWE2TSs0czZibldOT3l2U3k4?=
 =?utf-8?B?NVhsckpUTmtDc05vbmxIN2FuR2Z1ZGdQaDU4MmpCbk9JQ1VpcytLQ1N0QnUr?=
 =?utf-8?B?RWZ5ZG14SHMyRHk4cXdIY29yMXpYbkNkeUJscTlrTWwrcGw3bGtuSkpsSW93?=
 =?utf-8?B?NkEyQm9sTGt2Zmw3TEp0dGt0dEtvS2d0aHYvbHYxTml2VzgzYklqZS9nbkNM?=
 =?utf-8?B?Q05nMzFaWnV3OS80SWU4KzRiazBwbFFjOG1WQmdBQWJkdzlIUGxkVXlIckg1?=
 =?utf-8?B?YVF5OEVHZis1ZTRadEFJaGFKWHRBVXV1cTZVaWtsK2R4dEFoYXo5bFN0MWdy?=
 =?utf-8?B?YW91N2VaUmthYTJwdndtZGZNUGVLV2VCMWdoOFYxZFVrUWhWYzAvUERxOXF4?=
 =?utf-8?B?dERzYlhuUVBwdDkvd2toNGN5MnRZNTlpLzJHWXpzY05QcHJpU2lBbjd1alJx?=
 =?utf-8?B?ZjE2d2R1dEg5Yk00ZlZWcVB2ZDR0bGZiYmlxTmRxTzI0aFA4OW5TLzRJUDJj?=
 =?utf-8?B?Y3Fob3pEMEpaMGc0UzBNKzlib0dEeDFTblBzQmF4VktucDZvSk42QlVhOXNX?=
 =?utf-8?B?Z01qUU84aUFuUHJvNzR0Q3AxbFNVTEVzZlVFS0tOL0JneDBCYmJGOFVlNFdQ?=
 =?utf-8?B?bXQ2RkJkY05GcTRtRVMvcHJzZEVZT3UvRDJNeFQ2VnRMTFpUY1FIb1ZDa04w?=
 =?utf-8?B?L09qQzI1clpJenB6T1hxQlYza0c5TVBzeTBZUitaNE9MaitJZFFqUFUxQVRI?=
 =?utf-8?B?YkhlMHd4emRQdFVJT1Y4QW1vUUdBSk9tL3VpNnR1aUtDU3NTTU1IN25xN1NB?=
 =?utf-8?B?QUlya1VINldBR3FTRUxUeU41dmZqSGRkWXpVMENBSXJLKzBheFhjZHVuQTlG?=
 =?utf-8?B?YzIzK256OGJablNueWlSdGFFSXNEMEp0MUZKMS9xamlnV2txcnN3R1dNRWEv?=
 =?utf-8?B?bm1NK1ovMkJ2N2pBRDZPNTZBd0FDcDk1bm5hODluNDhJcXNPbGYxRGpDRXUv?=
 =?utf-8?B?aCs3WG9NOVgrQ0I2UzBhZ0h1aUJkTFBuU0xwQjJUeitKNmtnQ0ZOMTJKdTNp?=
 =?utf-8?B?WXhkNlVoMS91MDlWRVZYTWZ0QXlPVThIMWRleC9pSDBYbDN2MWNTQ1R5Mkgz?=
 =?utf-8?B?Yi8wNTlsN0M2eGdFMHM3WVJFUjdScTMvRGJueVNGWHJlWGtvZXMzZWZZZEgw?=
 =?utf-8?B?dVBGZkJyVDE0R2gxZDlvcVRpTS9sVXlEVnB3dE90QUhTTkNrQ09vL2lWeEFr?=
 =?utf-8?B?U3JXaHIvL0Z2SFFNT0ZCRzdKcGtVZGtIbGEwdDJaWG1KOTRhZWZiSkYrSXpt?=
 =?utf-8?B?M1haeURrRTRHeXdDWHBWZHE5NTVQRm5qcTd0OUt2QWhUOXNtNWdsU3diSTNm?=
 =?utf-8?B?c3c3ck8xanZLVjhkbUhRNUFVRWNSbkxhODlZQ1hLeWZlSjRlZDhMbnZlTlEr?=
 =?utf-8?B?N3RzcVMweEdueDhDNEVpck5NOFFIZEFac3djYm9VWDFDcXBrNW04RTA5amtZ?=
 =?utf-8?B?S3YwNHhibHZXRlVKbkRneEdsK3NXcEtOcjAvQ21IZG10bDJhT01jclVUM3Yw?=
 =?utf-8?B?RW0vaW8vck4ySlc4c3pJTW1Gb0Z5RHRrWEY2RDB1SE1CTk44WVVzMUxrQWhQ?=
 =?utf-8?B?TCtYMUhMcVE3MldSb2xOMmgzRk9adjhQdnFxQWh2Y2w1azJBUGVESjBKT09R?=
 =?utf-8?B?bm9KK3VzdkNsUEVXck96QmJvVitKWlJGc0tsYm0xd2d3ZTgramdRY2FGTE9V?=
 =?utf-8?Q?keWD7UWc7C/KxXirvCpeXXpQ6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7EEoshWBqiAU+3L/xpKPWg2/AM5GV+VVByXCO/JuPBv9q59JqakK7xwEKKLLyIh4Xnk7HidvGnJQZO9eDP1BjWZonZDaQueqhshho/fpkjld+WpWi7SMV63tQ788h44pz7E7G3kNZAqvMsTDQgYV2GjQaM36MXPbvDU8cIQE5GeQG/L4ZAXSxGSeUoKCQBNbE/mDSq7qWJNhRzUc/D1295WvYF60vWV7XGPuGpFUlKS6pHZRC8gcVIzU0qdJP9n6u6azWKbwbuVmgc72Gibnpdhhj28Q3OIqEBw6mtOWgVTGwV3znt1O3xK5lO6G4ZV/o6Zo5GlgPaUhVMONWOWbhBlaFyIq6UFa7dAsRHRh6E4zjutGUb+MJKhrVf4MIaueE2yWABp//0q/Gmf6pjZqK/zTpn/ofZVfaOb12BS5ejsLkg5zRSXEjdgECvj9xd6rv2t8L2JQYqiHgi6QlXvwbFEPR6/4n15EiEU2pBuu/Aj5sJw4orhNIZDQdEegsT1OulLXFTawvtx3kgw6j0CEfRQIEy68d1qZJNVnEcCsqaLBBqteAYLAElF3wYjt0lbQJoyLQ8hjyjUQatHx2udUdZpJeFhtrT+tZsZJWykL0GcWIsA5lUIj4306Na4OE+Hoz9Sl36Erg8yWGU9OvYxDoGtx0V9nqIC5QZbwtqNSsbhKBOzD3PQKaFuUceJh+XEES8l+94vP7Qchhf5T9j/NpUH8aakPFCORWxCxQyIMayHv9h0pEKuMDjVdmWh598o5lvs76gm+XsULKiXsV5AjruxBdeAPRzhWEeYlA69IgCBZNPDMgXEsChWwXjExMrqs
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0501230b-76f0-4cf7-43c6-08db7d54a512
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5841.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 12:37:50.5219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2KAGZumQkcp20tAaPlejJwi5iWp8o3McGpw9xSN0OZBxgaWwq7Yl32Y/4pfxjAAzuhQ1yOnwpAGkfJQ4Rdh6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_05,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050112
X-Proofpoint-GUID: HbCEAX5GOG8haGaOTxJpWGP2cIkE5myN
X-Proofpoint-ORIG-GUID: HbCEAX5GOG8haGaOTxJpWGP2cIkE5myN
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=mark.kanda@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

HI Stefano,

On 7/4/2023 9:14 AM, Stefano Garzarella wrote:
> Hi Mark,
> we have a bug [1] possibly related to this patch.
>
> I saw this Oracle Linux errata [2] where you reverted this patch, but
> there are no details.
>
> Do you think we should revert it upstream as well?
> Do you have any details about the problem it causes in Linux?

While the patch fixed an issue with Solaris VMs, we unfortunately discovered 
regressions with hotplug on Linux VMs. The symptoms were similar to what is 
reported in bz2176702. I think reverting it is the right thing to do until this 
can be investigated further.

Thanks/regards,
-Mark

> [1] https://bugzilla.redhat.com/show_bug.cgi?id=2176702
> [2] https://linux.oracle.com/errata/ELSA-2023-12065.html
>
> Thanks,
> Stefano
>
> On Thu, Oct 6, 2022 at 9:53 PM Venu Busireddy <venu.busireddy@oracle.com> wrote:
>> Section 5.6.6.3 of VirtIO specification states, "Events will also
>> be reported via sense codes..." However, no sense data is sent when
>> VIRTIO_SCSI_EVT_RESET_RESCAN or VIRTIO_SCSI_EVT_RESET_REMOVED events
>> are reported (when disk hotplug/hotunplug events occur). SCSI layer
>> on Solaris depends on this sense data, and hence does not handle disk
>> hotplug/hotunplug events.
>>
>> When the disk inventory changes, use the bus unit attention mechanism
>> to return a CHECK_CONDITION status with sense data of 0x06/0x3F/0x0E
>> (sense code REPORTED_LUNS_CHANGED).
>>
>> Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
>>
>> v3 -> v4:
>>      - As suggested by Paolo Bonzini, use the bus unit attention mechanism
>>        instead of the device unit attention mechanism.
>>
>> v2 -> v3:
>>      - Implement the suggestion from Paolo Bonzini <pbonzini@redhat.com>.
>>
>> v1 -> v2:
>>      - Send the sense data for VIRTIO_SCSI_EVT_RESET_REMOVED event too.
>> ---
>>   hw/scsi/scsi-bus.c     | 18 ++++++++++++++++++
>>   hw/scsi/virtio-scsi.c  |  2 ++
>>   include/hw/scsi/scsi.h |  1 +
>>   3 files changed, 21 insertions(+)
>>
>> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
>> index 4403717c4aaf..ceceafb2cdf3 100644
>> --- a/hw/scsi/scsi-bus.c
>> +++ b/hw/scsi/scsi-bus.c
>> @@ -1616,6 +1616,24 @@ static int scsi_ua_precedence(SCSISense sense)
>>       return (sense.asc << 8) | sense.ascq;
>>   }
>>
>> +void scsi_bus_set_ua(SCSIBus *bus, SCSISense sense)
>> +{
>> +    int prec1, prec2;
>> +    if (sense.key != UNIT_ATTENTION) {
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * Override a pre-existing unit attention condition, except for a more
>> +     * important reset condition.
>> +     */
>> +    prec1 = scsi_ua_precedence(bus->unit_attention);
>> +    prec2 = scsi_ua_precedence(sense);
>> +    if (prec2 < prec1) {
>> +        bus->unit_attention = sense;
>> +    }
>> +}
>> +
>>   void scsi_device_set_ua(SCSIDevice *sdev, SCSISense sense)
>>   {
>>       int prec1, prec2;
>> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
>> index 41f2a5630173..cf2721aa46c0 100644
>> --- a/hw/scsi/virtio-scsi.c
>> +++ b/hw/scsi/virtio-scsi.c
>> @@ -956,6 +956,7 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>           virtio_scsi_push_event(s, sd,
>>                                  VIRTIO_SCSI_T_TRANSPORT_RESET,
>>                                  VIRTIO_SCSI_EVT_RESET_RESCAN);
>> +        scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
>>           virtio_scsi_release(s);
>>       }
>>   }
>> @@ -973,6 +974,7 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>           virtio_scsi_push_event(s, sd,
>>                                  VIRTIO_SCSI_T_TRANSPORT_RESET,
>>                                  VIRTIO_SCSI_EVT_RESET_REMOVED);
>> +        scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
>>           virtio_scsi_release(s);
>>       }
>>
>> diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
>> index 001103488c23..3b1b3d278ee8 100644
>> --- a/include/hw/scsi/scsi.h
>> +++ b/include/hw/scsi/scsi.h
>> @@ -186,6 +186,7 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
>>                                         BlockdevOnError rerror,
>>                                         BlockdevOnError werror,
>>                                         const char *serial, Error **errp);
>> +void scsi_bus_set_ua(SCSIBus *bus, SCSISense sense);
>>   void scsi_bus_legacy_handle_cmdline(SCSIBus *bus);
>>   void scsi_legacy_handle_cmdline(void);
>>
>>


