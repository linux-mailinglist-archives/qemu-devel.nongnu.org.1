Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92678798581
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 12:12:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeYTc-0007Yf-1e; Fri, 08 Sep 2023 06:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qeYTH-0007Do-CJ
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 06:12:16 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qeYTD-0001T1-D1
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 06:12:14 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3889t0TB030216; Fri, 8 Sep 2023 10:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=NGHDr7sNBc715A1toM+bVjUR2wiaOWrB1q9nXfVGdjg=;
 b=Nnbq43BdLLl//MgRWJiKHNCWKhosoA6zym0O2WaoAC1EXhDTFC2Yf5DUHR/QRanOdtGH
 3LXnaWHyKfuWuJ2c0hnlyRTDFbDvESFVucs42mMTOeFmeakJcTBgYX0Nh7SiwxXhwcvK
 Jz/ozQYlfqVAL5FtL0D3Zz9ELiLeupwRVb56ZuSDN+zgUFAi2/v4C/WBkuxMRgJp6N03
 PxFUbmFNpUUPNLCvAcKrIzhYweAtN1uvpdxP2gFFmTNzmALRdx/GCBQTntvHiKbz2dro
 jA/Zk8fDjBImsdLXHOMITP7BdjIsgxgj0vuAY2gDAWM9pQ/Du/aEwf1oGJGMFbnB98zP Bw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t01d880sr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Sep 2023 10:11:58 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3888DVs9039846; Fri, 8 Sep 2023 10:11:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3suug8y5qf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Sep 2023 10:11:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQElHS2t5cfIwHdT2HcLfBBxzqj1XyeMV7vf+hMP/zhaaYswc0b1DNjLHD8W2wIU+/zb1hUcbMBTn5RyZz9XrdBg6/PDHE3uRykbM72GWJosqX/5mxZ8fkxAR4pL38/lNCcKoJpatJfqHUl+aLj73v9EZ7YFf+GDp0bxs/tMlOTIIa8hGMkjku4CDn8uY6BzbCgm+s0yqNNP2HcRH2L/a3KVMmK2wTKk6yCCvcM3AJXU1dwruXrPH4lBWr2uab5WS54q1WAANi+ngrYeA2HXW2eko2z9/ONuwlGbIRy2uhHCNKeZHFuF3l3bv5WyecTp+QNIjlDkls95BSgJCTbSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGHDr7sNBc715A1toM+bVjUR2wiaOWrB1q9nXfVGdjg=;
 b=jB05QtznwReKhH79z4AvASPa0KVYz+jBfKTUB8txAki8CubufjT8YPmdR6v3B+HHxNrykxpZM8MnOafua3m7UIg1ky0FaO4ytyO69oS/jM42r0uPUaKnblrOVX2lOomoV5bGLOS1KeEaUw5nB7ucvFnUGHWxsk33O2mXkIBWzCT4CnJtk1b0SSLMrO3YtSD6OtzY+/gwv0lNA49b+xP3QzmQbP4J+HtkwLldXem7Sxzq2zW7xnPsDUNijQ+iQbNoFmyVmiPhvT6k/DgKYJUOWyiIf9neRGb2QCjSHQ7zGs270vQD8eTkpDzyq2vgH97YFp5giY2QtSj6xmqisiQykg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGHDr7sNBc715A1toM+bVjUR2wiaOWrB1q9nXfVGdjg=;
 b=TrggCJ5denZ9WC0W8MKdA7soMLxaAvgbYu/XvZ2k+7LwD3nHPwYT6I5mkkTaZ85ycBFQeFbREUai+4FLZDGoeN5UYl3w42tFqHuzdV7vT2rndnx07C+iwW1+GvTrJn7mZjrblJ/HTcLXpvZxpqozyUeSj+GbHLEZjfTJvwdnpp8=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by BLAPR10MB4900.namprd10.prod.outlook.com (2603:10b6:208:30c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 10:11:55 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 10:11:55 +0000
Message-ID: <5a849c31-ae80-854c-03af-8fe87ba343c9@oracle.com>
Date: Fri, 8 Sep 2023 11:11:49 +0100
Subject: Re: [PATCH v4 12/15] vfio/common: Support device dirty page tracking
 with vIOMMU
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <20230622214845.3980-13-joao.m.martins@oracle.com>
 <de2b72d2-f56b-9350-ce0f-70edfb58eff5@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <de2b72d2-f56b-9350-ce0f-70edfb58eff5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0085.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::26) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|BLAPR10MB4900:EE_
X-MS-Office365-Filtering-Correlation-Id: 8047af2b-6fb9-462b-49ea-08dbb0540784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cg0+qnj6ehJBb2JTkBdv/5lGLAudODS5JsxxBQ/t/NLqHZwlpvl4HTYI9ZSBKd+MBQirwT1d66qOg9vNK32yuazULVmJ6/nv/hU2Wlb3BnSpGEAbE7+dqE019XQdCUSFUIhANpARmK9GAKWMxss1xYvJ8gODDN/UK5uQW3Ck5QHsHnfaeESmpw3K9mXl9HaKCnVDfeXoTGeYmPdf7DmhLbCr/MnFNzpLx1daFB1YY0fBuCAbsBU6FQl1QG42LomRn6OoKSTg7lEdNCaC8jcbjv7m5z0namhtyQ6NX8aJXlIixvfFCH0j5yq4EyxF8t9pSTnQJbCL8nRKnB6X7By/Ruo0iKnsm7jQ/HiOTWJzMygUjZ7O9qh7NTxCifEWny8+flFNfkuf185+6GraaOxqxWiPqspMNjs4zkuRA0IRNP5mku8nUdHpJ8vIl5peJmeSChMav1GGIG75iUPPkzc8L81KSWvv6bzpBNGQncgh/KVMZ/tJOYyfCB976pxRdwFWz6h6rifOak4IKAgVrGKMgCUHIOj5h59TXoyfrzZRH6225POxS4fgdk9ufRVsuXbhQwuiuYMAaiUCXwXd/f3qfR7nNhM9fGZrQ9Dfifuox9iWtr+Z69RKDiEJOsqRAgKs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199024)(1800799009)(186009)(6486002)(6666004)(6506007)(53546011)(6512007)(478600001)(41300700001)(83380400001)(2616005)(966005)(26005)(7416002)(2906002)(66946007)(66476007)(316002)(54906003)(66556008)(4326008)(5660300002)(8936002)(8676002)(86362001)(31696002)(36756003)(38100700002)(31686004)(14143004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm1neHVNaGdjOHl0dUdYUVZtS0lKWjhKUVljZVVKWEpCWGNWSEpueVVlaDhJ?=
 =?utf-8?B?QlIzcisrb212TlVyQ2tGYktmdFRrT0NXait5bzVEL0QyWWJ2cUZFWFRXTjJP?=
 =?utf-8?B?SFI1RVg2K3VSN3owQU5wcmlkekovZ21IZVRhODZ1cCswL2VXRkMyR3hUNUtN?=
 =?utf-8?B?dmhVVXI3Unp0MnFSNWduZHdIdFYyQjV1cDMyN3NJK3lRelYyUWtLdVNsY3Rt?=
 =?utf-8?B?V2wyT3BybEJ0MEx0KzdRWlYzbTlSYTN4emc1MHZ4YXU2Mkl4cmRCWVl5UWpL?=
 =?utf-8?B?dUtOQ1BHYzU3azFJbmFJZWdHbFlUUGczOVF0Y0Y2VnptZ0Jsd2dYQ0VsZ1pK?=
 =?utf-8?B?OW03ckFVZUdmbDNOaDk1aUF3SVY5cmVGakp6WldHb2xjeTl0L0Jrb3lrRlZ2?=
 =?utf-8?B?T0EwbGh1cUx5cXdpR0ZKNEMxTmhDWlZqNmpra2hhWWxvaXZzeWFyV1RiRnpP?=
 =?utf-8?B?eW9MZ2ROVnlnN0xsbUZiS09GMGFhU1hCZ25ITDVZeXJHTmg0S1grejlIVHRq?=
 =?utf-8?B?S0NsTHFZMTlVeE1FS09pUU9NcWVGeUM3cEFUYlFuL1RuR2cvbGtVTldGWDhI?=
 =?utf-8?B?V1QwOUN2STYwRWpkN0ZEaVpkeGhPdXBzbkFtcjZzVUJuQTQ4akJpVlFmek1z?=
 =?utf-8?B?bEpPSHNRWm9Kb1VLYTlTejlzMzJRUFduNzhSWmpCMGJOL004ZTVVdzhxd3Qv?=
 =?utf-8?B?N1R3L0llOThtNU1VVjlodXBnZmdaUUpGajhNYkN2SU5hYVJwNTVxTENxN0V0?=
 =?utf-8?B?djdBMUUxOS84VG5tVzc4RTdlOGEyWHVkallSOUprRUszWmJXQnYvZFFsLzdY?=
 =?utf-8?B?a0JuT1pNc2FhZ0V0b0JqeHkyNkgyMXgrbWFXSXFxNVRMcEJKcFlkb1BzZFVY?=
 =?utf-8?B?ZDJoZEhFTFNHRktpVjl5QnlCcnJCSzVUWmlPTk9uTVM1eFNVa3oxMUZYeTRV?=
 =?utf-8?B?OU5CL2xBd2tmOHdUdTdReDN5Yjl5ZjJ1VUxHaEQyZzVvZytwZnVtVjNCZkpo?=
 =?utf-8?B?dm1KNUk3YXhUOWR5UHhMWnJTNVZuVEVlZjZSb3BJS2s4dW9hZXRIa0MxZ2tr?=
 =?utf-8?B?WlNHZzM4R0xabExuc0h6TUNqaXo5Zk5BZC9tTk4wZ29zL1dXelZJNHFpZERh?=
 =?utf-8?B?eUpJdE9iSVpMd0FvZzJzOW14bXhoZHpMbDZCeS9QajAyYTRRbXhuTUpyMGd1?=
 =?utf-8?B?V3N0TmNZR3c2Y25QWVVDMFdDNnN6NUM1UVh5MFJrR0lkeGh3MmpvSVY1Szll?=
 =?utf-8?B?Y0c4WmJCY1c0T3BnOTFWdjBQTFFvaUNlR3BrbTRrNlpzMit4MjlrUzF4VGE5?=
 =?utf-8?B?TTZWdHh0YjRTZVNaVFJMTEVuMUhrVUliSHRQUk1oa3RnSVRTWml1OWM0SGxn?=
 =?utf-8?B?NGp0bWltZEdSZS9yMHdrWWtNbjFtMmhoZmxFU1A4NHRRczBUWUE5enY2Wlpw?=
 =?utf-8?B?cjdhYWxOVU4xZXNROHJMOW1EbGdUQzZYWWo5RGhoYVdqQTdvKzhNVitWS1Ry?=
 =?utf-8?B?ZE9za2lidFpQaXZ4WUxDYm94YjBSNER0ZFJ0QlFwZEE2WXUvbW9FcVNybGI1?=
 =?utf-8?B?TCtibVlJZnFqYmxYTWZCanBQeHZ6Q2pTZWlsZDNESWFaTHhwLzJ4a0hPWE1w?=
 =?utf-8?B?U1dFNERWcElmTm1xbjRlcHc4c016ei9STTNZLzNkbXNOWjN0Q1pOcjlodzgz?=
 =?utf-8?B?ZnFaTmc5L2NOTEcyY3RsNTRUM1JJYkhDOFRIeUJxaHd2Sk1CVVpYc2lWZWZ0?=
 =?utf-8?B?bWpmOXY1WjdLaWJYVGdCUFI1QkU0Sk9TZjREOFp3dEMrVFZ6Zm02enNEVkRQ?=
 =?utf-8?B?WnpGd2g5V2Znbm53cFBjV1hiM3J1d1lDcjFRcHkvRHpIM1YxVjdWbUxnaXcr?=
 =?utf-8?B?YW9NT1RqM0lqbStRcXY2MVk1TG9GdnA4ZVRwalJBYlZsL2YvODcyZjZ2Tndq?=
 =?utf-8?B?S1dtRytuQS95cllUZFZ1M2NSdjN0VlRGMTJJRHpGZ1NHNndZWkRpaXZ4WUVi?=
 =?utf-8?B?dFRZbDRNTUY2TjRKdnEydy9Zdm9lRyt2aFUvRTlaamVhUlljRS91Nk9GcnJJ?=
 =?utf-8?B?WTRCc1FHendCUXlqTm9ZaE91K2tBL0xrMS9qeVVranNicGFwMDBadTQrM2Fj?=
 =?utf-8?B?VW00M1NSdnNscG5uNWduM0FOZlgweXh6RWlJMHdlalFZcUR2bUQybFByQTIr?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1JTL03FgFA5/x7nKVQhQA5bD5+NquqSkczrR1ptlWYqek1waW8LWRGV7cRfztfdmLWBw6rWxE75MtjTvScrH4yYvb4mpcmjtDKQ3x+cOTP7wK2YkeAGXtp704A+aRYAkzeafZcMucBSXc+GIfGdrXtqvPXjzSB/gZrWmnRCNZxPCquIogDsHjk971Rao0MNz3/IpjCs7FAs9URL3fKK62at4Vfdhh3SwWpJHmxg4fRxiKsM+uR0MtqIVnDPpaD+Fi0FgMsnYML8hTMLY8l6xftjwwujkz8iQ/9Lzv82zW+rU4mb+FRlll0hFczGopuqyKkbjDFP0XYj2Bba1/AQYDLAcctfg8A880ngNug44Z6wDr/Bfdovt5EPazGaYW3d5KGyYOGDAOG9nZoCbq2c+WRfxLlWtiQBYxvR0UXBo912Xan6xPNyIsPZvLg0D0PhHf1D0zn0raP2H/n8HyCgeekLdpqPScYLOLClZHfxddaiti3VabqLU8zh798ANpkzndwRwmrijKlAEA1GGPTPDxeuqtFgcnEchv3n8mtGim3JKGjTcv2R4RnPeTqBRjKrcUXlMG2c76bFU9JrC0JUPZLSErDuWMlS1SpQTaoFub1skWMcCOZNTp/QFhmXC6tCFWErEWt3d1xOEa6Q7ri2WzfLbo8Fm9VuNl7t+CsmcSTdfqYCtBxZYi7IcGfqyHpBOkcIJD490kHA5ycaJq8syu8G+bbmp4niKAr4q4SN6SMpZAnbepOlzRgk+zjo02eSkqyid22VnsO1bJ+T+wdw3E9XrqxWlHFT0Qx47BSeDVj1zuHGhCer7oWLcsPL82fMnGMV9M82yc2Px0AMs6Y86/aXCFmLMd6ho5bR3biODFQyYkzi9bXodZaBLT1PbuCRioD0J9cm3Mm5TfYCJLRR31J7H8VuTnIlPhMfkoEHP0ic=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8047af2b-6fb9-462b-49ea-08dbb0540784
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 10:11:55.5075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/wi42FVfxrVTyU5ZfnXK8Nj71tfT7y9zDgMKmEg7NsyW33Pl0fyPFG46g1CR3F/G+XZMZq4BSyBXOTAMDxGqN4n0zsBjCtkkuGbCWAYHtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_07,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080093
X-Proofpoint-ORIG-GUID: fujO8NYptj72qnl7po8oZDOwSJO67rtr
X-Proofpoint-GUID: fujO8NYptj72qnl7po8oZDOwSJO67rtr
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 08/09/2023 07:11, Duan, Zhenzhong wrote:
> Hi Joao,
> 
> On 6/23/2023 5:48 AM, Joao Martins wrote:
>> Currently, device dirty page tracking with vIOMMU is not supported,
>> and a blocker is added and the migration is prevented.
>>
>> When vIOMMU is used, IOVA ranges are DMA mapped/unmapped on the fly as
>> requesting by the vIOMMU. These IOVA ranges can potentially be mapped
>> anywhere in the vIOMMU IOVA space as advertised by the VMM.
>>
>> To support device dirty tracking when vIOMMU enabled instead create the
>> dirty ranges based on the vIOMMU provided limits, which leads to the
>> tracking of the whole IOVA space regardless of what devices use.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   include/hw/vfio/vfio-common.h |  1 +
>>   hw/vfio/common.c              | 58 +++++++++++++++++++++++++++++------
>>   hw/vfio/pci.c                 |  7 +++++
>>   3 files changed, 56 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index f41860988d6b..c4bafad084b4 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -71,6 +71,7 @@ typedef struct VFIOMigration {
>>   typedef struct VFIOAddressSpace {
>>       AddressSpace *as;
>>       bool no_dma_translation;
>> +    hwaddr max_iova;
>>       QLIST_HEAD(, VFIOContainer) containers;
>>       QLIST_ENTRY(VFIOAddressSpace) list;
>>   } VFIOAddressSpace;
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index ecfb9afb3fb6..85fddef24026 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -428,6 +428,25 @@ static bool vfio_viommu_preset(void)
>>       return false;
>>   }
>>   +static int vfio_viommu_get_max_iova(hwaddr *max_iova)
>> +{
>> +    VFIOAddressSpace *space;
>> +
>> +    *max_iova = 0;
>> +
>> +    QLIST_FOREACH(space, &vfio_address_spaces, list) {
>> +        if (space->as == &address_space_memory) {
>> +            continue;
>> +        }
> 
> Just curious why address_space_memory is bypassed?
> 

But address_space_memory part is done by memory listeners, but I see your point
conceptually on not considering it

> Imagine two vfio devices linked to two host bridge, one has bypass_iommu set
> 
> and the other not. Don't we need to include the guest memory ranges in
> 
> address_space_memory?

I am probably making a bad assumption that vIOMMU maximum adress space is a
superset of the CPU address space. But as you just reminded me, there is a user
case where all it takes is one bypass_iommu=true on a 2T guest setup with
aw-bits=39.

I'll rework this to consider this.

> 
>> +
>> +        if (*max_iova < space->max_iova) {
>> +            *max_iova = space->max_iova;
>> +        }
>> +    }
>> +
>> +    return *max_iova == 0;
>> +}
>> +
>>   int vfio_block_giommu_migration(Error **errp)
>>   {
>>       int ret;
>> @@ -1464,10 +1483,11 @@ static const MemoryListener
>> vfio_dirty_tracking_listener = {
>>       .region_add = vfio_listener_dirty_tracking_update,
>>   };
>>   -static void vfio_dirty_tracking_init(VFIOContainer *container,
>> +static int vfio_dirty_tracking_init(VFIOContainer *container,
>>                                        VFIODirtyRanges *ranges)
>>   {
>>       VFIODirtyRangesListener dirty;
>> +    int ret;
>>         memset(&dirty, 0, sizeof(dirty));
>>       dirty.ranges.min32 = UINT32_MAX;
>> @@ -1475,17 +1495,29 @@ static void vfio_dirty_tracking_init(VFIOContainer
>> *container,
>>       dirty.listener = vfio_dirty_tracking_listener;
>>       dirty.container = container;
>>   -    memory_listener_register(&dirty.listener,
>> -                             container->space->as);
>> +    if (vfio_viommu_preset()) {
>> +        hwaddr iommu_max_iova;
>> +
>> +        ret = vfio_viommu_get_max_iova(&iommu_max_iova);
>> +        if (ret) {
>> +            return -EINVAL;
>> +        }
>> +
>> +        vfio_dirty_tracking_update(0, iommu_max_iova, &dirty.ranges);
>> +    } else {
>> +        memory_listener_register(&dirty.listener,
>> +                                 container->space->as);
>> +        /*
>> +         * The memory listener is synchronous, and used to calculate the range
>> +         * to dirty tracking. Unregister it after we are done as we are not
>> +         * interested in any follow-up updates.
>> +         */
>> +        memory_listener_unregister(&dirty.listener);
>> +    }
>>         *ranges = dirty.ranges;
>>   -    /*
>> -     * The memory listener is synchronous, and used to calculate the range
>> -     * to dirty tracking. Unregister it after we are done as we are not
>> -     * interested in any follow-up updates.
>> -     */
>> -    memory_listener_unregister(&dirty.listener);
>> +    return 0;
>>   }
>>     static void vfio_devices_dma_logging_stop(VFIOContainer *container)
>> @@ -1590,7 +1622,13 @@ static int vfio_devices_dma_logging_start(VFIOContainer
>> *container)
>>       VFIOGroup *group;
>>       int ret = 0;
>>   -    vfio_dirty_tracking_init(container, &ranges);
>> +    ret = vfio_dirty_tracking_init(container, &ranges);
>> +    if (ret) {
>> +        error_report("Failed to init DMA logging ranges, err %d",
>> +                      ret);
>> +        return -EOPNOTSUPP;
>> +    }
>> +
>>       feature = vfio_device_feature_dma_logging_start_create(container,
>>                                                              &ranges);
> 
> No clear how much dirty range size could impact device dirty tracking.
> 
> Maybe some devices linking to vIOMMU with small aw_bits or bypassing vIOMMU
> 

So, my intended usecase with this series starts with DMA_TRANSLATION=off, where
vIOMMU is restricted to interrupt remapping, yet guest only uses it for
interrupt remapping. Right now only supported by intel-iommu, but my
understanding of AMD IOMMU is that is also possible there (haven't checked
smmu-v3). This unblocks guests with more >255. I have another patch separate to
this that hopefully relaxes vIOMMU blockage for these older guests.

Now with real emulated vIOMMU DMA translation usage, intel-iommu there's only
39, 48, 57 address space width (mimmicing the levels). And it's true that only
the first value is supportable and somewhat limiting as you say.

virtio-iommu has more going there as you can limit input iova to be the size of
the CPU address space. Eric latest series[0] is actually nice on that end of
fixing that issue (my alternative I had there was to introduce a gaw-bits
equivalent, but it's better done like [0]).

[0]
https://lore.kernel.org/qemu-devel/20230904080451.424731-1-eric.auger@redhat.com/

> with small guest memory could benefit if we use per address space's dirty range
> 


Yeah, I'll need to fix that, when there's big guest memory and small vIOMMU
address space. Hopefully I picked up on your comment right :)

