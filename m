Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8A2710D90
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 15:48:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2BJi-0002Y0-Be; Thu, 25 May 2023 09:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q2BJf-0002XG-Aa
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:47:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q2BJc-0001f5-Mt
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:47:43 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34PDYvj7012235; Thu, 25 May 2023 13:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=jpnzOs5kUvosweGXOPWICN3fnhvlrQXskTOFjDYVDBw=;
 b=Cfi+HPPIHrltNu/QxMhSeaHesHYiB5IuIQDjkIQqXDPxui69AnH1y60gARE0MhMvSa54
 wG1arAtB33cjf37nGFL1np7N1gcIkooe7xhWNJELEK4QB4VmoqNyvdHDDylP2lNNOLJY
 pGzHilQi+uPwCLG9QaUymdihVL7ENATeiJCRmyEDLo8Bg2j5Ay9H7//qeZUQ6SrZuEnY
 F87mk33YaEySgTT3KSoiEjwtHFlT4XcXzYp3DHK8kf3WLnAh30hojOlgvUrKE68ZqwNT
 n7yHuzZkKgcWlbe8FRWiy3VN9xm4eazekZnaDvAAvhZxhuWUL1Cj857oBJA0GzLIUJ/W eg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qt8pcg12s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 May 2023 13:47:36 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34PDB9FX028580; Thu, 25 May 2023 13:47:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qqk2tw45p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 May 2023 13:47:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCQPWDlymvsqiFXY5DrcIQ4S5z+pngNJG3/xIGWNXAdi0eu92zQWouQus64lxFAZ1rJOIZK7+AA2huvRAU18tVHR3k4ibsAiOdj2yosa3EN31dkQhJBfydAVgn6HBVRw3T8r26Tpg2pZJzPS0CBu5HNpukIZLD+5FyEN9O7Z6FgR4juBWdusFVPZwEONyWxHaiSB8I1CSS/sk/h5cQolK1A8+YR4ljGvjPmw93KxbNpPS6dU5+HVxrb9lwnwPx91JJwl8U8LoalEcF8qWXcABRq3BYVyfz0rbVkYX02Ij5kzORb95sx7SG/IY1Bfe0xLN9+hssbFH+1vE6gbWrOmgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpnzOs5kUvosweGXOPWICN3fnhvlrQXskTOFjDYVDBw=;
 b=iKns6EVCCv2DveQE4f7Pnuf3CextC7h+98dPf1riP2WQXnBTMEnjnyLe61xmdnk3xGmoGbfejcaGVl7LqJ/oC915NQpkxmnkTmEdgJxfrSBHnTXww8/rAq88+I/z1pO90jNU1weohC8/TDVLANHpo1yKqNABInoo1w2HddEd+U9w8IpyNwLNGW1JVdVINzxeaMZDz89el+FdXmXFiQwlWJRVjWXbeRv1Ay52hhnRIDwyEW+OSYEX3PRJXC/OLhmbaFPipWA44vdIy7YZD1+dcFKFMrHbYrk/uBJCNUYrqTMpPoOKvovyN8r/kmzib1jMz0o6uQr0nAsWeBmkyJ1csw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpnzOs5kUvosweGXOPWICN3fnhvlrQXskTOFjDYVDBw=;
 b=p7eWwg9TCYsEuM8/cvPJaikQa5v7I25fG8cUA1wGRXFLh7qyje52dEScQtLPvLLqYOYgKQ768SXgK46kR199LE0T8cDvQfJHQtSrJnRcp8EWhZcuoChTGNOwxPSQ638CoHDJ1RvIwOO+tlgBEHrgUGsJNhI+jQCl6QM5UsxbeM4=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by CYYPR10MB7651.namprd10.prod.outlook.com (2603:10b6:930:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 13:47:32 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b176:d5b0:55e9:1c2b]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b176:d5b0:55e9:1c2b%3]) with mapi id 15.20.6433.017; Thu, 25 May 2023
 13:47:32 +0000
Message-ID: <4e8a19de-f56a-0dd5-6eed-5a9d8caa270e@oracle.com>
Date: Thu, 25 May 2023 14:47:26 +0100
Subject: Re: [PATCH v2 1/2] exec/ram_addr: return nr of dirty pages in
 cpu_physical_memory_set_dirty_lebitmap()
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Avihai Horon <avihaih@nvidia.com>
References: <20230525114321.71066-1-joao.m.martins@oracle.com>
 <20230525114321.71066-2-joao.m.martins@oracle.com> <ZG9fungk+x/F0vD+@x1n>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <ZG9fungk+x/F0vD+@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0173.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::16) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|CYYPR10MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df3a1b5-1ece-4d46-28d5-08db5d269698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: knQvxPHZIbMMxkIYPXDbDWRvpXhwq4PrD6K/m6DpBaPxExkFT8yDwlXdpXhhfp1MuAh8gMLvO2vX3IYEV93Khe8SSurT2lD66rltMPVgIBLLnvVe0Ki0f2lFsVlbvPdln9K1EZjBYPUd5ufn+WCXUkBDKwKJwb+gJ0VS8VNuZsyBals/5xBYiEofURTbmcQKwxeDfsAXt+p49dwEzNfEzcF5LBlIj9XTq1l9XiEFfj0Zgp5CQt5NPz1o0oBBWdRylWo1unsm48iEYrg72hIOOO9ORV/g3FBu2uLdJddsR4MiawtfH0fC4+PYmfs3oTcOETxhVL9jRxX1ar6vHERleawziIQcwTJbCYBV/jia5uCmE4OFy4cFWmO4wbS3cQmJlrGck4zrJnHA1VjdZlmNr7b/22iI1dsuWYdjwoFa6QNKCOjVCwlw/VzhOzjAPZlWt5Cww496Qo/nyQHoly/sV5uXMYLrFuBQU3VuBVOXUImkHj3MNYyJ5IyH8qH6pzfEjiJkZFbPBge1kDDbwOOORf7GwDAqlUBKUiE+ZXkfAqlV+ElXw4AGWThj4mSkCvRgn0xf/MvMBnafaPQxBj1f95iDqeOHBfn22aGw9F/Xjr6mO03HjBBJBMMY5arOiLArHTeWMufe7UkQeesmgmC16g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199021)(2906002)(2616005)(36756003)(186003)(8936002)(8676002)(6512007)(5660300002)(26005)(53546011)(6506007)(478600001)(66946007)(66476007)(66556008)(6916009)(4326008)(31696002)(86362001)(54906003)(38100700002)(31686004)(6486002)(316002)(41300700001)(6666004)(14143004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmhwRXhsT0tqeVB6Y3Vad3FYZmtFZ2ZZTjVqY0o3ZHd0UzVuUllFeThWTm1M?=
 =?utf-8?B?NVVtQWxndWV5NS8vOHByaVNNZFJLcHBJVjdmUFVPR003TkNqWmt2dkxTZXVm?=
 =?utf-8?B?cm01aUZFanBENDkzNllmSXhJenRlcTRDYitZU1JycTdCeVRBM00vRERPNHBz?=
 =?utf-8?B?TERzRWhOVlB5Nm5KcTVZM0l6TTJoZmhmd0pDMEJHQlkrMU1DSEE0ZlN2eXBL?=
 =?utf-8?B?amwvSXhHSTdSUFdpNVF3Y0hlbzhRSU5DYVhEcENJQlc0d0FiQUlnSTFKb3FP?=
 =?utf-8?B?M1FhNFNXMXNMZjZPOGlXVEZuVEVETXgxM2ZoYTZ3R0NuUE9aYlJvTWFhVzhh?=
 =?utf-8?B?WmhEblZodU1hWEZnaytkNlN0WUM3TzNWcjBYSkVLOXpnKytnbFhiYTBMSlZQ?=
 =?utf-8?B?bEphWnNyWEk3UzM1eC9EbHNISS8rUGZzcnFleElOQjI5Wmd1UDFTRDh3RmtL?=
 =?utf-8?B?RGdoMW03NHlrQ0VyTTU2a2dYcmt1R0VOWldNK0RFZi9ZRFp0UU5WNHdsVzFU?=
 =?utf-8?B?ejVnNERHNTk3UUIwbjBmWnNSdnAzZXhVT0Q0WnJpSUJOWU5ydzlPcGpaQ2VM?=
 =?utf-8?B?M0NMQ2FQb1B2RGx0MXo4WDdBQjlNb3VGN2tvRncvakZiVjNrNWx6djBaNmFC?=
 =?utf-8?B?QnRZUUdUVHVEc1FiRmljZ0ZoWEsxZG9zaXZKVmlrakJTZXJwQ0N4dWVwMGR0?=
 =?utf-8?B?bm9ZUHpybXpXekNUOHI1UG1rb0haQ3VZTkVSZnJLZytHWCtnRHRkREJ3TGJ2?=
 =?utf-8?B?aXZzeUV6WXBCaS9sYlI5K1JIZ2VVQVBYTjBubWRkT0Y0ZVZTQ3hpTUoySHdL?=
 =?utf-8?B?enNGbUhhejhsc2N6UnZDRnFERHQvT3lQOHpZTGZDdlFpS1FDRDlQTW95RSti?=
 =?utf-8?B?dXR5Q1ZzZEQ4THY2RGZlR0c1OWRybjNOQmJRbmRWT3dRcGNEVkZyM2V6VXJw?=
 =?utf-8?B?bUZEMGhPYkJQcHNIUFQ1YUlHQnhNazBMbkdrWmR6bGdCRmRsMXZMamFNdXo4?=
 =?utf-8?B?aEFhUmxlalRCbTFlRW9FN2NtUUt3aDJQdHpQSnZvOVc2ZU9abnVWaGdycm1j?=
 =?utf-8?B?cjdxTHJxYUtyWHoyanh5R21VajE2L2JjOEhXbmtTMW5hYzNVMkFSeENrVlRt?=
 =?utf-8?B?KzR2SlZUSmFDZE1vTGdWcmFCVzkwdmpMOFlnVDR3R0tKNmtPVTBQNjJUM3Zl?=
 =?utf-8?B?bGFCbXREQkpHc2xGT1dUVVNvdG1RQjNMNU91SnA2UDFMUFNJMlpUeHJidWYr?=
 =?utf-8?B?b2cvb0xWZEd6Ym1wVXMzbGF1Z2ZGRytlZGtEalk4OGsxZWRYblVJSWQyaEZF?=
 =?utf-8?B?UGt5VTJUS2ZwOHNaWkF2WGl6TDdvQ1dUeGRHWXhBWk9FM3NqUHBwR2N0MEpp?=
 =?utf-8?B?cUU3ZFNnRUJIbEhkanpvZ0hOWFpQMUVTM3BFbU1uNEpjcnNnVFQwcHcrZjRV?=
 =?utf-8?B?cjlxSHkyZ1NFMmxZVTZIZ0xOZ1dzOG01cG41bHZXVDJ0QSszYmNZR1Q3L2po?=
 =?utf-8?B?bGFLNzEzM1Rma0RjVVFkZk5qcDg1Tkx2aVUrSXdRYnUxTG5sVWN1UytNVWNY?=
 =?utf-8?B?T1BNcEtPZzVXb293T3J4YXViT0hBRnhDb0grYU1sOGdjNTFRZDQwVTZJcXM4?=
 =?utf-8?B?UURRTktZYXp4Q0VVYnF5d0RrMnlJd1FJdHE2OURYQ3Fyb1NTUmFkb1drNDlC?=
 =?utf-8?B?ZFZXQTE3UDRabVArNC9ZeC93ampUTitxTWpxUzlNTTBWOFJRb0hKRUR1aGlp?=
 =?utf-8?B?bUZqbXd3TVF4a1FwUUtBT0FXNGo4aERKczEyaS9VMCtFVGVjeXBFbkh6SWdX?=
 =?utf-8?B?Szh1QTQxY1NxMHdmcTR2U2dRTG5UQjE5QnRUU2w5MXUvekFoblhZTndOTzFQ?=
 =?utf-8?B?cnVHUG5yWWh2ZXNFZGRnN1YzUXFvMWI0WUtIajU0MTlObEF3NkpwWkNYRVlS?=
 =?utf-8?B?Zi9iRlRvSFV2WVBXOEFKeU16TjkwSDFGdG5YcmtNemM5TEFiMEYxYjdVT1hR?=
 =?utf-8?B?cVNJekFyVTNlbnUvNEUyclByVjVPTlh5NG5oOEJzRytWOHlVYWhHS2ZSNEhN?=
 =?utf-8?B?VTNVcGVMcnNkZDUrcjlnN00vN0piU0hVeDVRZ0FFZStxd2hHQ2RtK0s4VTMy?=
 =?utf-8?B?SS9hQ1ZwdVNFbTZ4em1PTDhYbzIrYjlmcE1YQ1BzQnNxbVNCV24vRjhsSU5H?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zf/h+SWrieoRiC9yUbZKcWpUNWUMPVM1Nfr9s6rspT31H7QKDIv0LCDYOK6ExNJcjN4Q8IOjO8vnAwQdvD5v3DBfXEjYFyIgsaJz8n/496+G7+mxGrCipyDQnyNJEZNnyyrx/q8mgm/KT9Dt0l6H3g24TTTSOThXK5XMM71tuR+pGLoSQ2OImC9gcmhyRjeItAJKwGsib4f52MnZv7tAT7puGuY4W8ZMbKfTNyu4RZVaLT/Mx1vShCi9MA71o+EsmJ79jBk5cuc+M30pB3MlZtp4ej9d3kvdv/R+lrdbJ10rYh+X6RCol/f4rx/Xa2nFtAy1a1PJ4pY1yxotEZZ36smocMGYCMiPqy4yAog4bR5klW3z2hvFxQCEmzep885YeJBge9fsEXtEh9FJDGeYLUyahjNDaN1HWs0KWLgOWVt+yyylMM27kr38Yk7JfO+Dez5cTtxR4S/WmzDkBLwHuvkH09ouTwAiFEHtXIwmgmIGOiWwomrXYRSHe7R8VxsZ25yyDIcE4dM8IoDCUXk42ALbNd11uXf+MpTmSQndosJuSUhdbpBLaHTBz3s1fyRT07AYWz3DIBNhcVX+WXxVWU1te3tIbz1matJXAwLq26bYQfXlBvQo3o5M/KprOYpV8hiWPZdIJg7Igon6+lCBiSTkXyNabyAT7mrJhwzTTosBtr2F+NEARJhiyerkQuqg3NU6VAeqFqgWKWOEjJlF/LTLOSSybivoyTo1I3tVVajlW0rh6QsPR/RwMYLLYzp08RB/JE/2ieUbPWuRhnp7v58LuBhmF2hOT1og+/JA/gSKm5XDXNm/rcsoTl1/T3G2GzdsFdxeUl6dM8WSzWpLFg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df3a1b5-1ece-4d46-28d5-08db5d269698
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 13:47:32.1771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mz80+2TtFU6ZaB0qYZBqXlge/Lute6fUBdxTEfe0xTuMReXgDt897rGAFpIGzxKV9M5cJpXhAAIYjSnI4g323WMdFPhZedOd483eHO4+dQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_07,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305250114
X-Proofpoint-GUID: uZwiwz65Z6H7YNRHzoxup59EvqWux_yM
X-Proofpoint-ORIG-GUID: uZwiwz65Z6H7YNRHzoxup59EvqWux_yM
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 25/05/2023 14:16, Peter Xu wrote:
> On Thu, May 25, 2023 at 12:43:20PM +0100, Joao Martins wrote:
>> In preparation for including the number of dirty pages in the
>> vfio_get_dirty_bitmap() tracepoint, return the number of dirty pages in
>> cpu_physical_memory_set_dirty_lebitmap() similar to
>> cpu_physical_memory_sync_dirty_bitmap().
> 
> The patch itself looks good to me, but it's slightly different from sync
> version because that was only for MIGRATION bitmap, meanwhile it counts
> newly dirtied ones (so exclude already dirtied ones even if re-dirtied in
> the MIGRATION bitmap), while this one counts any dirty bits in *bitmap.
> 
Good callout.

> Shall we perhaps state it somewhere explicitly?  A comment for retval might
> be suitable above the function?
> 

Yeap, Something like this?

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 8b8f271d0731..deaf746421da 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -333,6 +333,13 @@ static inline void
cpu_physical_memory_set_dirty_range(ram_addr_t start,
 }

 #if !defined(_WIN32)
+
+/*
+ * Contrary to cpu_physical_memory_sync_dirty_bitmap() this function returns
+ * the number of dirty pages in @bitmap passed as argument. On the other hand,
+ * cpu_physical_memory_sync_dirty_bitmap() returns newly dirtied pages that
+ * weren't set in the global migration bitmap.
+ */
 static inline
 uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
                                                 ram_addr_t start,

