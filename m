Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 878FF732B0B
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 11:07:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA5P5-0000Gz-IA; Fri, 16 Jun 2023 05:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qA5P4-0000Gf-7l
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 05:05:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qA5P1-00028U-Qt
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 05:05:57 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35G6OgU7009544; Fri, 16 Jun 2023 09:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=YdMXtSmoIn8T7zD0yxaXiiDwrOWlJmVzDHCO6MWF4+U=;
 b=uv9cz9l8h8dqTw7i6GHJi7fJKYht+BvBOXp2oZqZY0+nuAXqMuQaDYZl5JrAEcyWCXmU
 O6e6h4B/phzTG58zdZ8sM/dP8ZZ//xwCNwVF3Kg2hkghDqPfAIhqHqg0oYYJ+blsVUWH
 1q9pshwTxuYGAi6Fmj40c4OZ3hoovypptYHv56mNf8SR18OmTNNuxia9kIpfSWrU8/Jr
 dL3seSRyy7MqXecapMWIThnJU45WhU1B2Zz5r7pEhbR6KCj3DSJzKEBsYi5fQKfQAMif
 hdFygKqEcVPQ+CDYxloRs0txM0N5kEnCbTmpV+YCN8hGXAvNrqL2sxtZDRMBDviTPwY5 kA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fy3kt3q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Jun 2023 09:05:50 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35G7OFY5012367; Fri, 16 Jun 2023 09:05:50 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fme9m4a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Jun 2023 09:05:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxaoB4lvYnBXGyM05ybOi7zdJCme/LpUWJ7DfchGZLFdfsBvIUXQBj/dRx5jhaG9Gdbjboshlb01xkugU7WBMDQD/eBxZmKHDI+4eGkg+GuZ9MwoGV4l03YXWJYrHuTip/C8Xe5MZz87LiH8s6ZaHozYHxkacaw2AEI2iQWz9WekAmUkYf2muFhhkXMgWu0Qy6O14vToeLBm/qUd4R42aX+DGHFDs4STTwDbabfDtUL5mGbnT0JNwqz3vwEUCP5SQWv0EQHSXrzZewRACL/bb1j1Lzr4X/CSLljVMcu3RVP24fPdLw6Xaqn0zzlAJi6vlDD/Ml+f+s7MQAY4YB6szg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdMXtSmoIn8T7zD0yxaXiiDwrOWlJmVzDHCO6MWF4+U=;
 b=JCLZAdSHY+1yqt3Ok7gIV9F1JpHkQaYWiwMFR35s3NicznSF2k2C8VTspdfBIY7RRfPwHWW3J92RUfuaaasHIplfwAaHYThjn4KC/+LJlaVc854lI6EGJHVMVUNtUrski4FW6UxoOwKub5PLsOaUWd/jnytay6lRJFsBu9pkC0Y4+GKywTpKt/GTLjG4HGQj4lLCruQbjWpV80sJa2V8womQ7JdDZH9XA2xdMyqalhbMF1drmPeYhenuKa20cejBs9k/F4sD0WiFMcLh0naw3gkw5BgLJJsQZ4efhlq/XA8CGfSD87xetkxlkMlpX8KYmNTgIKrQCwxm5jmcCa+0qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdMXtSmoIn8T7zD0yxaXiiDwrOWlJmVzDHCO6MWF4+U=;
 b=fKNn2nvQfUzD2aQ2/G7CMVjamDv7X3siJ7pc6Qh1bgAgAHjvyvrMtoXHzhHL75V/QOe+iYa/GJKNt5HPDO0zBU4hH515c6+jL4p1vY0SK3HIdYVA06kcTmeXFtmjwHRmX/+JCUNeiinH5IcOTIkMtNZDPDVd6ZcDO/jKaoXEVfg=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by DS7PR10MB7376.namprd10.prod.outlook.com (2603:10b6:8:d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 09:05:47 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%4]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 09:05:47 +0000
Message-ID: <2f3ee2ab-e37b-c429-e604-b62440d37278@oracle.com>
Date: Fri, 16 Jun 2023 10:05:39 +0100
Subject: Re: [PATCH] vfio/migration: Fix return value of
 vfio_migration_realize()
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20230615081851.326816-1-zhenzhong.duan@intel.com>
 <67af377f-a8b7-c879-516e-9544d6a4fab2@oracle.com>
 <SJ0PR11MB6744E8D7540A3B9E540A9F69925BA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <186c9e07-c1e6-74ae-0a4f-7d6bc0c8ceb6@oracle.com>
 <SJ0PR11MB674488BE146A88E35D763C639258A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB674488BE146A88E35D763C639258A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0011.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::21) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|DS7PR10MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f37214a-bbc5-443b-c05e-08db6e48ded2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tzuevlDFMi7Z1nnL+ga9xPKyY3vZ1YQEXganSym7fNwXIUzsSlRSiMTEzlgRyoNBTOyxtFVe4AcchLDO+EgWylOb2+Yjz7dtwpm94+uiaoPdDDUgsZejdFWq9j9Vzr+WQSKznaKFO5rNsC0O0lYyCUPEJ6R5Fd3CUAOpc5KDlqIWR4c/mm/KGguEzCYnB5E8yoio0raTOAJHNCvvYHE4LPtarZrHziQxatbY0ZXE2L7iTveZ8pni1kY9nu1dzF0nhKumd9nxp7UhFOmVzOthe3h7ogCXj42dkD5H9oxkaoxsyPYH2vAj7j1KCEUfeGEkxptrQ5j7BCEjifFuJ5uAwDtAhMqvrI5xHraV47t8C6aXn76vCNmm6Pz6Unem9oHSYMB//jyfOEDx2+eF4Glvdh7v2GyrLewl3PtpOpcZyDnri0lsXNZyKG7tSrqguHo2ATkgNgXt2qc3n9Ub2sbLCObL633tGT3wIolt5ywuKYojDf5jOCMyLMCYw6BKluLU5N1aNdaJtIX550bbofpNBCcEc03sFCXTmsFZ4bSQWb1fjs+cWQOzqPcoB/r+8FCOWssC+8qEaIosqAemKfMHRMlJauILXVy8A/EAlwcBOlL7DKHJc+xFJnDyywbnDlr9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199021)(83380400001)(5660300002)(38100700002)(2616005)(6506007)(2906002)(186003)(53546011)(26005)(6512007)(478600001)(66556008)(66946007)(66476007)(316002)(6666004)(6486002)(6916009)(8936002)(86362001)(41300700001)(31696002)(8676002)(4326008)(36756003)(31686004)(54906003)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qml1djlTcGRFSDBFUnFJK0hPanRtbnExYURURjR5TjJJNndHZnVWQ01NNUYw?=
 =?utf-8?B?bWJ5WUFsbU5tQ2RIeEhWM1QrY1JpUDBQRWZKSW90cE5LaE1RdWdOaU8rdmRI?=
 =?utf-8?B?TXBUdy83dmpOVTZGTVdEblBWZk1sZTRpV3cyYnkzNFFYbHN6Z3pCQWc0R1h3?=
 =?utf-8?B?QzFTNXUxYzJxdzFwdTZZclUvYXozNUpRRU9UTHZsR2RxQ3UyeDVlNnhEdU5B?=
 =?utf-8?B?ejczZHl0cVBsTFVhbDRTdVFYOU5lOXRBVHR3SEN0NDVTQkhmZThYbXhXeGl3?=
 =?utf-8?B?d0xoSXdsTkVSdytCY3JUY2NzMGlKU3pSc3ZvaURlWko3V3Y0ODhOeXlIYWFT?=
 =?utf-8?B?UnZ6MllUb1lHTXJ1bGxDUXlRWi9MM1prRTFxV3FDWEVNVUs5Yjhla3FaVGN5?=
 =?utf-8?B?QnhtS0dMVDFBNDlTUlFiWVFzR09DSlhDM015Y3RUYkJScE1YSXQ4ZkJ3Vjdo?=
 =?utf-8?B?eW85UStXcmNVY015R0ZkY01SVWttUlRBaVdoclp6aGNOTDIxQVNYN2ErdzFx?=
 =?utf-8?B?aEpUOFhMSE1uRndrVk9Hdm1JNUVjVkNtWmVGUWxReWFJU01NWnRRQVQ3ejlK?=
 =?utf-8?B?bUdGTnA5c3ZseitCM0hVc1AvSUsxaVAvUEVueFBGVElqTmJKYkFlRHlKN3ND?=
 =?utf-8?B?Ri9JK3pKUjNxVW5XMFJvZXR5MzFmY3Jhc1Y5S1ZkbktDSkt5MzVUdHlTM0kz?=
 =?utf-8?B?aG90cjRNQnBrOSswQWlWSWlWUG9RdllTdGY3RytCQVhjcGpWbVRKcVpjakcz?=
 =?utf-8?B?RktySXlqbGs5VUhPTWZIUmtTMFFlNVE2YkRsUTB1cUoxVnBma0tkZkN3elNI?=
 =?utf-8?B?QUtNSXRlSWhmMURzTWV6dzZld0xvWWVjbkY1azRRdllLZXNNZTFkc1Z0TWZF?=
 =?utf-8?B?UDYzclFwcHRlTGJiMlpPdEtyQkZ1RU1GWFdteVlzQjJyZXRiWEJyNUIwWFJL?=
 =?utf-8?B?cFRoUjdURnFHT2oxQ0UrSjEzRThPK1UzMlNhR3psZGR1NlU2WUVnbHhhUjdz?=
 =?utf-8?B?U3U0blZZVVlkY0Q0YVZPTCtLT3hydm5VUFphdWdqY3NLS1NpRmpyN3ZsYlZM?=
 =?utf-8?B?OXREU1J3dk9WNmRURno1WUU3eVNLMEJ1czFTYlNOOW5wSERneEdDTms2bHpL?=
 =?utf-8?B?RXRtMlY2b3VZd2hlN2pVZmtubTRNM2lNYkRyd0Q5dHNqd25nL3Vsek1oQkgv?=
 =?utf-8?B?QXRQZHBjZ2tIWjdBcUI3bXIyaklqNFJvZCtjNCsrRFFTVzVVMUI5aVFWdmhL?=
 =?utf-8?B?MFdhQjU4UzQzTDJMZUdXa055RHRtMlR3RXlKeFBMRmZoL0pTdm9QQU1Wa0Fh?=
 =?utf-8?B?UFBCeTF1eEpkR3ZWcUZHWVhJelJ3WU0zTUpESWs2YXVMQ0NZdDRJR0VkWkxE?=
 =?utf-8?B?djc2WFlsZ2pEbFhQaWlTN2F2OHZPeXFvM3huY1pYcWZpTHVBUm4zQlZzVFQ5?=
 =?utf-8?B?REl2M2hzQXJ2QVdiOHdhUndRNGVoTnB5QWVWS2xxemdxYlBlOHJIeXdZSkh2?=
 =?utf-8?B?VnJ0N0gvOXZoalZyQjJwMWViT3JlcWRRSEdscWpPM21tRlVGSWlISDd0N3lE?=
 =?utf-8?B?Rk96aWhpMW4xWGNieDlodmVCd3dacEZpT205d3VHWUYwVktFVExUVldSYUVE?=
 =?utf-8?B?ekdXWWxBQzhxV2JIVHZKc0dGY0l5RWlYcGZqQzd2UlVqMk9kMzlyUDhIdjVO?=
 =?utf-8?B?M0wxSktYaTRhUGlVWEE3NFlpY2NpTlQ0NzBUNUc5Uks2Q1J3YzMzT2s4dFlh?=
 =?utf-8?B?VmdBTGcyZXdQUWFsVHN6RmhjRzNwQmt3NlE2TjYxdDNqbS9TbUZBb1dNY3Jt?=
 =?utf-8?B?U2NQZXlvbno5NkdzSW9UREg5SDI1RDhyZXZhdkZWdUVvdEhMalFmZ0c1RXBT?=
 =?utf-8?B?RFBaQ25HRzRYQWI0aVQ0S3creFhkT0tMZzB3YTRNOGtnS2VuKzVLTFR2UklW?=
 =?utf-8?B?TUhWcWFtSFFmZ1k2M2VWR0gvTDF2L3kwc1NzYnNRTHdFQVJ1RWFXSVVoSmlN?=
 =?utf-8?B?M0ZzeS94Y21pZThseDRtak1IZjdZYks3ZWo4QWNLTXBLNE1JWGJDczJLOTRF?=
 =?utf-8?B?WWdRdG1yRWx6YWdQTVlxMy9tSWNOTUtPSlVhL252RmF0YmgwUWV2MG9qcFlx?=
 =?utf-8?B?b3BkaWNFV1dnZE9JZkMvQkg5SVFMVElEbUVpRVJ4K0lXOWlVOXlIQm0vU1Jp?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: O6XFNfwt3jFUAbSh9Jljq+SEDr3xuk1QSnSzH3uLMb13cyilC6f8nJpWrusH70lUeH/GuI/q3wW7wKSLuphHK7kg4LmKN6LDZF+uoLTBc5N/mkYwa5Xw1hcD1h32mnLuz0GMSAxKv7LzgXJRAQjH2I/+BVZ691NDBtchD6qV0SYEvr9F6tDSUJNVqrd3XU94gj0YtTkz9JSEndEvraUTCBGP4/pgX6qVA3OgMEE4G+fojxD6i5h3uzeTydCDk2AUqhxMpxhSOS6YA6IlKVfHbd3b2B8z/nbsQ4zfzSlan4wU0cZ15Wz/0GckbeeaRPKrqu4syTCBXaWBE0S55rcPZm2NbLReRoKb6VoNP1j80tiK57je6p4f8JhvFu7imP7FvH6ALXA3eY4vmAjCOFvjURIyEYl32VUsRbwUWvVjBjx2bI8ico3oOzYsJ4RJvh4L4J/fOHy98rVoNglLbODLcsTAttNJM6g+LLZ5IMWY//2slabfVZJIy7yVK71wzhHMgacjwCF8R7hpAnoXVgx04cHT+TTDwNkwVIMk6fKUOXaPi/hjYE+SG/RrF4PJU8uBiOrf6muDA5g9EHyE5nKJMCTo7ORCYoDg/Pk2KU2R4uf99S9Mo1H9oAWMNhOd8DwaBBV9t1rFBtnK8uBWrYQxg1KOEvkF1Bap8WqTIW7jLD88enEHD/JfikcsiNpPt9CZaO8SqwaEZLiC8JRP35xobRHofyJHV7icdGq29YbB0sZcjr6PDfJ10I2iQgwvRwkrnZwVNRrOlo7h07/KCwyZ2gEzgEPRIk4qJ9q7KIWQaCCAxQIsdY4t7IQvKtz3Mq60
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f37214a-bbc5-443b-c05e-08db6e48ded2
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 09:05:47.4372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQlXe6RMDTTGWYPPmcNpJdgU6D0a8mkpzcUG6z9h4HBKXy3+bpfdSkzaMo8tyPfg7KjppyLgixAcgq/wgYYuXlRbVCw+g5MX/wp87r57oU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7376
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_06,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160080
X-Proofpoint-GUID: nU8Ufo6PBx6p1iDlDJ0452SJkJljAlxu
X-Proofpoint-ORIG-GUID: nU8Ufo6PBx6p1iDlDJ0452SJkJljAlxu
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 16/06/2023 03:42, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Sent: Thursday, June 15, 2023 6:23 PM
>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>> Cc: alex.williamson@redhat.com; clg@redhat.com; qemu-devel@nongnu.org;
>> Peng, Chao P <chao.p.peng@intel.com>
>> Subject: Re: [PATCH] vfio/migration: Fix return value of vfio_migration_realize()
>>
>> On 15/06/2023 10:19, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>> Sent: Thursday, June 15, 2023 4:54 PM
>>>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>>>> Cc: alex.williamson@redhat.com; clg@redhat.com;
>>>> qemu-devel@nongnu.org; Peng, Chao P <chao.p.peng@intel.com>
>>>> Subject: Re: [PATCH] vfio/migration: Fix return value of
>>>> vfio_migration_realize()
>>>>
>>>>
>>>>
>>>> On 15/06/2023 09:18, Zhenzhong Duan wrote:
>>>>> We should print "Migration disabled" when migration is blocked in
>>>>> vfio_migration_realize().
>>>>>
>>>>> Fix it by reverting return value of migrate_add_blocker(), meanwhile
>>>>> error out directly once migrate_add_blocker() failed.
>>>>>
>>>>
>>>> It wasn't immediately obvious from commit message that this is mainly
>>>> about just printing an error message when blockers get added and that
>>>> well
>>>> migrate_add_blocker() returns 0 on success and caller of
>>>> vfio_migration_realize expects the opposite when blockers are added.
>>>>
>>>> Perhaps better wording would be:
>>>>
>>>> migrate_add_blocker() returns 0 when successfully adding the
>>>> migration blocker. However, the caller of vfio_migration_realize()
>>>> considers that migration was blocked when the latter returned an
>>>> error. Fix it by negating the return value obtained by
>>>> migrate_add_blocker(). What matters for migration is that the blocker
>>>> is added in core migration, so this cleans up usability such that
>>>> user sees "Migrate disabled" when any of the vfio migration blockers are
>> active.
>>>
>>> Great, I'll use your words.
>>>
>>>>
>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>> ---
>>>>>  hw/vfio/common.c    | 4 ++--
>>>>>  hw/vfio/migration.c | 6 +++---
>>>>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c index
>>>>> fa8fd949b1cf..8505385798f3 100644
>>>>> --- a/hw/vfio/common.c
>>>>> +++ b/hw/vfio/common.c
>>>>> @@ -399,7 +399,7 @@ int vfio_block_multiple_devices_migration(Error
>>>> **errp)
>>>>>          multiple_devices_migration_blocker = NULL;
>>>>>      }
>>>>>
>>>>> -    return ret;
>>>>> +    return !ret;
>>>>>  }
>>>>>
>>>>>  void vfio_unblock_multiple_devices_migration(void)
>>>>> @@ -444,7 +444,7 @@ int vfio_block_giommu_migration(Error **errp)
>>>>>          giommu_migration_blocker = NULL;
>>>>>      }
>>>>>
>>>>> -    return ret;
>>>>> +    return !ret;
>>>>>  }
>>>>>
>>>>>  void vfio_migration_finalize(void)
>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c index
>>>>> 6b58dddb8859..0146521d129a 100644
>>>>> --- a/hw/vfio/migration.c
>>>>> +++ b/hw/vfio/migration.c
>>>>> @@ -646,12 +646,12 @@ int vfio_migration_realize(VFIODevice
>>>>> *vbasedev,
>>>> Error **errp)
>>>>>      }
>>>>>
>>>>>      ret = vfio_block_multiple_devices_migration(errp);
>>>>> -    if (ret) {
>>>>> +    if (ret || (errp && *errp)) {
>>>>
>>>> Why do you need this extra clause?
>>>
>>> Now that error happens, no need to add other blockers which will fail
>>> for same reason.
>>>
>>
>> But you don't need the (errp && *errp) for that as that's the whole point of
>> negating the result.
>>
>> And if there's an error set it means migrate_add_blocker failed to add the
>> blocker (e.g. snapshotting IIUC), and you would be failing here unnecessarily?
> 
> If there is an error qdev_device_add() will fail, continue execution is meaningless here?
> There is ERRP_GUARD in this path, so it looks (*errp) is enough.
> 
> If I removed (errp && *errp) to continue, need below change to bypass trace_vfio_migration_probe
> Do you prefer this way?
> 
>     if (!*errp) {
>         trace_vfio_migration_probe(vbasedev->name);
>     }
>

I am mainly questioning that the error testing is correct to test here.

IIUC, the only one that can propagate any *new* error in vfio_migration_realize
is the calls to migrate_add_blocker failing within the vfio_block* (migration
code suggests that this happens on snapshotting). Failing to add migration
blocker just means we haven't installed any blockers. And the current code
presents that as a "Migration disabled" case. If we want to preserve that
behaviour on migration_add_blocker() failures (which seems like that's what you
are doing here) then instead of this:

	return !ret;

you would do this:

	ret = migration_add_blocker(...);
	if (ret < 0) {
		error_free(...);
		blocker = NULL;
+		return ret;
	}

+	return 1;

Or something like that. And then if you return early as you intended?

