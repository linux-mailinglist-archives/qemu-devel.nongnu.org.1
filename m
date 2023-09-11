Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A27079A692
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 11:07:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfct4-0003Jm-OK; Mon, 11 Sep 2023 05:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qfct2-0003JU-JX
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:07:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qfcsz-000644-Rg
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:07:16 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38ALFSwl026936; Mon, 11 Sep 2023 09:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=fDWmZBBTbpcWiB659e56kAHX7FU4K4ZBXIFSt0/tAp8=;
 b=DLBJHPRn2on6i6Tkt85QsKCUBYtTUI9zO1QRaCrANxxnhsX9PJR/TgpYa4xYsn/Gy5G+
 ZN8+eow+9vQcYY18uJkV7h6XJt6h7L/0siGWqmambAZtba8Q1kfWlnXMXVsJY+n64r2r
 pUnXzf2XJ/tetXzLVg3mk+kB8x2p9h+8FNcZJniBfzq2Np8de+GoYbfrnjmC9kCQ5aFt
 JbnKibM/ozWE1dFX+pU+nCe1yYfIV8pgiRHutIxyNhgtvznH5fTPz58eLBxv8UKFBQ9E
 TMe4I5X2U6Cbx0nacjdMwF8QYZ+AJqpHgNzuR1Hx5mbugFhrCnYi6Ub2t2YkJ9mWLhjG kQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1k4c908n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Sep 2023 09:06:51 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38B8kZDa023065; Mon, 11 Sep 2023 09:06:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t0f546jfy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Sep 2023 09:06:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDragSgBG6x7/cZ8vZu7azDXQfp+JEL7Fyj0psZzJiQDYGqsxBd8k73GfNuVeC1RwJvAbeMQxGNAnZkqBeIRMRs+60u4unhxcvyf+QVmbtL5W5B48mbyVcOanzuipI1loVz2zD9Cn4DQUNyVz4Mhl2Roaw5jG+l8hUdiD6tfdhPos9AmHpuzpyFX4VGv1j7iiQe8Aa8WD2yKdkPdvz1JL+Q0g1Yubo9HvhZiOtpnbIsuQS6ugQJ2N3mxVv4FzcBaTPPrsyJG3aF3/M5j8NIeqfomW1zGpIFC+Aca5P7sYRFP47W+JCTijWXuqC+UWBddYQyztpNkFu05r+HQfL7E8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDWmZBBTbpcWiB659e56kAHX7FU4K4ZBXIFSt0/tAp8=;
 b=BWGikkezxRwr70+06KTVV2oxoL0Y552hNf1FTViWjYRPcBa4CYB/8Dl3z8O+ifCDLx2lRnMlT+zRT3wZfFOG2XZr7fjQikUw+GSx0czn3LwyQZZaDWlsvosPZVpuQIWfVomaIqdoO1b7yaPSwkZU6Aw97JQaCw6Xyh6FKxIyAGmBW/TJpmT4ypzqQIZz5BlUP4hAY/Y++ZSMvPOhUFeXhkrxv0REWM4st0ZRV71BYayKSgDT6/BjmXhF1RWtzmJILRKmMaEOf/QQ16OMdB5Rj1oGBemxtWDGSae+g+/R2HlnfJRUkoAkPBkvi3HHsQ8FzOFcgk3t0BkmgUPk/cY31Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDWmZBBTbpcWiB659e56kAHX7FU4K4ZBXIFSt0/tAp8=;
 b=f1v8E6v+6PmR6c7YdzkqrzktmPOEkvotKrJWkoqglirHRroy1KkCROjxKVMbC20HineJNQjzVlt9ZTZGMoM9E96EPBJDW9GbEmckcK+IKo+neTuwdTxxV+PdweJ7huZFLpK3lnJJIlMdGj/0PC5AvxJb94yqVdxsrkOo4RkSTr0=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by IA1PR10MB7214.namprd10.prod.outlook.com (2603:10b6:208:3f3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Mon, 11 Sep
 2023 09:06:48 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 09:06:48 +0000
Message-ID: <83d2de3c-7a3d-4943-d4b5-1f4a86030512@oracle.com>
Date: Mon, 11 Sep 2023 10:06:42 +0100
Subject: Re: [PATCH v1] vfio/common: Separate vfio-pci ranges
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20230908092944.47589-1-joao.m.martins@oracle.com>
 <SJ0PR11MB67441FE6EAE5A0AB8992FEF792F2A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB67441FE6EAE5A0AB8992FEF792F2A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0419.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::23) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|IA1PR10MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ce0be1-3ed3-48b7-fe07-08dbb2a66da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vSmFGQ0z0tXdEJ/H/fZyCUZGbU88kap42i+6f1xTHc8J57el9O4D8eedczwq90YGxfkilkQDSpCgHNkXCSrioSYuNuLNasxWpdn8MH7eIU64n7zspRBwHGsAoIjTWD7OwS4Uu8FU94Lpi6hhEwQpWvehY8P2CinJ7B25jMR3vOPChHSPP6vfqepI1tAelGsxx3QwUq4N15/9QkQGQxDTG/suFJrVAlN7II56KhjaxI32626IYFXLD/h/CKhP893kHAEJ8SmbJQiBAIpr3TMGosRKFVJaw8j/1d68FJ47eo/59y0C1zafhcIyUtmAU6ccO+FB61bMguoY0xMUL1RhqJzvjpscnJbuYswsuvSiIbDXjtT+onozk6gzxbN6IcQ9zYEcPW62lNO404IMMxIfkmxV95h/ZKn11JNCtHeSvQ71zXkJePmT3a4r8738O6xUjKugfn6uiU+FtVUkjS+1tXz24b98eL2lWGRtwjJzaLK2xaP16l7Yg6LNEy7XVFXqWPmkCNDLbfwrC4yCiKy3xRHJsF84xyf+TQ3SSXavqJ3GseMZZZGcXdjY8QkBmZiB1+7ATBN1jUDmqnLAYccKZDHI/kxRMR5DHTZnMWPgscFQVuvCjneC63Sc+lFgwOw7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199024)(186009)(1800799009)(6486002)(6506007)(53546011)(6512007)(6666004)(83380400001)(86362001)(31696002)(38100700002)(66574015)(36756003)(2616005)(26005)(31686004)(316002)(41300700001)(2906002)(66556008)(8936002)(66946007)(8676002)(54906003)(66476007)(4326008)(110136005)(5660300002)(478600001)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVhocS93Uk9HTDBmd29mSUQyTEhUalY5Tjdyby9XTGtKN1RzQ3RxYlc0amZY?=
 =?utf-8?B?SmFDOVRNdFRQZFhTMXZOYnJuVXJSd25NVW1iUDV4cFY5ZlJPTmpqVUtlZHVz?=
 =?utf-8?B?SlA3MFpnWjdtaGJ1YU5iUXlLTzQ4V3hEMFA5enVFYlM4bFFvYmdXRG5tUmFI?=
 =?utf-8?B?SG9vdjV1aGF0S1J4WVVFeDJ0TUk5Nm5UWjZabUhNRC95MGdoVmcrbmxLRmJv?=
 =?utf-8?B?N3hadWk2K3pRZU43cTVsVlkwV25KdERZWHJ3Y3BkZklzSEliZ1JPNmt3eER0?=
 =?utf-8?B?VUREL1Q0ampTay9mbEIrUG9Ebllpc2x6dWhwK3dUaXMxQ1lpVzQvZkJoaW5r?=
 =?utf-8?B?RGdoUHo2aEV5WGt3OUR0OUxpRGVZRlg1V253SnMyb0dKNTRsK2g3Y2VDRjgv?=
 =?utf-8?B?UjZjV3FXS2EvazFydThhY3V0cEFFMGpTQy9JVVhMWm5PMFIyRVdrajhsR3Nn?=
 =?utf-8?B?TnM3RnlMdnB1cU1UT29KU1dLSVQ3THdGV2dqb0VjR2h0ZGhnTWM1MVR4LzdQ?=
 =?utf-8?B?MFJWRExPdTA3L1lWejhaZEhZODN5ZHRKbVBjN01XcThQUU9CdDJIWm5oVmZ5?=
 =?utf-8?B?bVVrci9BV0FVOEJ6TE10WDFMM0t2T1RSbDRVQjRTa3laV1R0VitMZkZJNDhQ?=
 =?utf-8?B?SFZaRGFtYlNWSjNNYlpJNEV5WW1zOWFTQ1dSRDhIVWtyUGRPeG1UREFmTEd3?=
 =?utf-8?B?V0k5YkIzTnBhUEJmZnpITWdpQlNvVnRIaDdBMTBpRlhIWFVmNzRLQnZmams1?=
 =?utf-8?B?Z2RVODg1OWkyOGZodElCVG9nUklYU1ZPOFRoWmk5ekRTMThCR3U2TTNZb2pZ?=
 =?utf-8?B?N0FkanBLdTJDMWVPS00yK3o5bXp1aWFWMWFab3NHaDJ0Wm9kVDhXay9QUS9O?=
 =?utf-8?B?R3kyMkhzZnpKWmhIRmcxbFRMbUhxYWRqbDZCKzBhQWpDeFNSOHFqUXFUaDRj?=
 =?utf-8?B?dWR4SDJMb0x4dFZ0Si8raGpTeldDUjdrR0QyTHg5Ly9LbVB2RFpwOW1mMy9m?=
 =?utf-8?B?eFkyMmluVFVKQzNRVVdyVXNJY2JtRHJibHVOdWNOOUVwNlducFpYYS9TRzhX?=
 =?utf-8?B?bFkwVS9TTyt5enNHQUtUVkVHUGdrM0J2MTc5QWEyRGNsN1BjUGhSYTlSb0FS?=
 =?utf-8?B?QnczbVRuMzJ2TXhZNlQ4NHJVOVBKZS9VSGlkWThBaGVTTXA2b2NNNm9YOU9E?=
 =?utf-8?B?TFd3K3BwRmNWeVRsMy83STE1ZEV4SGVYZE1aRS9DYVd6ZzFTVGQwbjRiTDhD?=
 =?utf-8?B?OWxkWlkyV1FJODNucjNHYklXS3d4YkJNbE5XMW5Mb1AyWHNjTjhDS1lLOVBl?=
 =?utf-8?B?eEt2VTMrRFdZSExFQ0o5VFlxeEcwMjNVVDFkU2hsaFBHU29jSTBTeGFsb3B1?=
 =?utf-8?B?eGFIczJQRXk4am1YUld5Ynh4dWxIYzZpc25KVVlFKzBIUDBrcWxSSlZ1QjdK?=
 =?utf-8?B?Vk80aDJTcTZuOFk0TjAxUGxjRmRVdmU2NGZmQkQ4U2NaWURSNTU0OWlhTVIz?=
 =?utf-8?B?YnZnRjhwVkQ4ZGtuTlloOVQwa3U5TVBCWmFKZFNLdkYvZnJBdC92dnBTdjBH?=
 =?utf-8?B?U0UzN0FocW93b2h3c2VpT2JYalBpYXFJSnZCKzB6RXppT3FKb2pyZVNOeFJ5?=
 =?utf-8?B?V29BbHZ1Si9mVmpvRzZMSTdCeUZNUTZQR01iQjM5bTVZeHE1Q3lHdlM4TkJF?=
 =?utf-8?B?bjNIdDZWcVBhZE5DSEc2TTB5R3JJd2VBWkVpTCtyblpyVS9paG5yRXVtU1Y3?=
 =?utf-8?B?Rml0RkNkeFUva1dPZndaNEg4MWJhb0Q4MHBpWmFGWWpPR1pNdmNmd1JxREJ5?=
 =?utf-8?B?U3lxQzVkM1ExOG1ETXd6a1hqL3ZXODFCOGlLZzE1SXhPbk5YaE5VOWc3aHR0?=
 =?utf-8?B?WDV6N0NaVkRLdURuWDl0UHU1eTRJN3FkV1hzbVdrcklKVjh3S0t6VWVQWEQv?=
 =?utf-8?B?b2hCUERyQnBWRDdlOUpSN0tIMDRlUHhwV0RkNDVMNkZvaVBmOGc3eU5KcEMw?=
 =?utf-8?B?dFBoanhiZHN5amIrOXRpNm9WWUNDdStXcFloZDBPcHk4QTdnWi9RN25yZGln?=
 =?utf-8?B?Tk5JTWdrY3p3Q0toUkhZaUtKdEY2SHZnMGFsbGgzaW45OEY0QXdyWm8xSmlr?=
 =?utf-8?B?eEhjdzRVV2RVVXR5TmVqRzAxUzcrNHVKM0YrRUFDZExxeUJ2T05WTkwzcStw?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6LPZBJUMzS4f6/4AjiObMet3ysUXO6BCTKg+LyhHAF1AZ0CQkls2GmH2O1eOrZzH/h9qyPDH7lLrrbnpmh28hThteYnyy3Z1oHjudSPxa3Ape4e02oF5Nsev3uQWniykvG6+4MSjrBqkrjE6N4FklC/fB+wgv2X8a88BoOGC6C5uN7B49qI33ZXaUgy7H0vyg/QhirSaTO5VdnvsJF++qtlbRyloBFPJxkONHlzK717UYO66dADOyA2wv73zxiVCEcGUaZe4qqcT0wUrMnTyHKToEH0hJIHA3DNWUGYPjD2vCuT2vnb1Y5vpGxxZVf+U7u49hx3CR2/3MWHfQcsj4XGvsuhKpvmbraznW/MruUij2ZiH3yKUyJZCvMoyYjHHQRMyqXStOx32cTdPOoTf+pC2le6G7rmmfeFEbrkwl1x8sMX1d5lOwp8Hr/RW32H5vQTBzX2FHgZ1bQLzX7BtOUfVI5s0iMzvS+cFgVICZDrhzdyYiapHL3B13G5aKC5J93W0wS2wZSI3mDat2XB3IKkuvp2D7+8hvMdDhQRt9DgVoVhi+JoA26791Rsb5cGkD+4Zn2Ba6e0u4uqwIAtwwlCNqTOf4h5SKbC/8FvSyT50Ytvq7mTGi0zVlsm5KQP8t556BZWtGjsyoC88La/npeljAmDDyt+vF5gpgBZV26/X97LDVRLQRCciGQDBWtJlq5ek1gJo3OAHh6idTdUBkfL9V4uwvVC/iE29MJvozaE2cRQXZCV+qxJpY/daJuVpIeUctsyVfrMhErWFQzCpfD/u7Pitt6Bh3gr0+cu9PTD9VzMUbSyX4d2/V50qdBlHIVmus13zqK80rw8RUjSqRA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ce0be1-3ed3-48b7-fe07-08dbb2a66da6
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 09:06:47.8696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqO4vTRpie0xbKuC0OaIawyirWegrYM4X7i4CnP/QFYAR3K4WlMYkq73E9+lHiYIdlL4lDNc19GBAmHSdY4Zt+xbJzN12GovRGSa0esFUkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110083
X-Proofpoint-GUID: AhotekdvefQ8THoucBG8pJ0FwacuYjOB
X-Proofpoint-ORIG-GUID: AhotekdvefQ8THoucBG8pJ0FwacuYjOB
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 11/09/2023 09:57, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: qemu-devel-bounces+zhenzhong.duan=intel.com@nongnu.org <qemu-
>> devel-bounces+zhenzhong.duan=intel.com@nongnu.org> On Behalf Of Joao
>> Martins
>> Sent: Friday, September 8, 2023 5:30 PM
>> Subject: [PATCH v1] vfio/common: Separate vfio-pci ranges
>>
>> QEMU computes the DMA logging ranges for two predefined ranges: 32-bit
>> and 64-bit. In the OVMF case, when the dynamic MMIO window is enabled,
>> QEMU includes in the 64-bit range the RAM regions at the lower part
>> and vfio-pci device RAM regions which are at the top of the address
>> space. This range contains a large gap and the size can be bigger than
>> the dirty tracking HW limits of some devices (MLX5 has a 2^42 limit).
>>
>> To avoid such large ranges, introduce a new PCI range covering the
>> vfio-pci device RAM regions, this only if the addresses are above 4GB
>> to avoid breaking potential SeaBIOS guests.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> [ clg: - wrote commit log
>>       - fixed overlapping 32-bit and PCI ranges when using SeaBIOS ]
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>> v2:
>> * s/minpci/minpci64/
>> * s/maxpci/maxpci64/
>> * Expand comment to cover the pci-hole64 and why we don't do special
>>  handling of pci-hole32.
>> ---
>> hw/vfio/common.c     | 71 +++++++++++++++++++++++++++++++++++++-------
>> hw/vfio/trace-events |  2 +-
>> 2 files changed, 61 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 237101d03844..134649226d43 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -27,6 +27,7 @@
>>
>> #include "hw/vfio/vfio-common.h"
>> #include "hw/vfio/vfio.h"
>> +#include "hw/vfio/pci.h"
>> #include "exec/address-spaces.h"
>> #include "exec/memory.h"
>> #include "exec/ram_addr.h"
>> @@ -1400,6 +1401,8 @@ typedef struct VFIODirtyRanges {
>>     hwaddr max32;
>>     hwaddr min64;
>>     hwaddr max64;
>> +    hwaddr minpci64;
>> +    hwaddr maxpci64;
>> } VFIODirtyRanges;
>>
>> typedef struct VFIODirtyRangesListener {
>> @@ -1408,6 +1411,31 @@ typedef struct VFIODirtyRangesListener {
>>     MemoryListener listener;
>> } VFIODirtyRangesListener;
>>
>> +static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
>> +                                     VFIOContainer *container)
>> +{
>> +    VFIOPCIDevice *pcidev;
>> +    VFIODevice *vbasedev;
>> +    VFIOGroup *group;
>> +    Object *owner;
>> +
>> +    owner = memory_region_owner(section->mr);
>> +
>> +    QLIST_FOREACH(group, &container->group_list, container_next) {
>> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>> +            if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
>> +                continue;
>> +            }
>> +            pcidev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>> +            if (OBJECT(pcidev) == owner) {
>> +                return true;
>> +            }
>> +        }
>> +    }
>> +
>> +    return false;
>> +}
> 
> What about simplify it with memory_region_is_ram_device()?
> This way vdpa device could also be included.
> 

Note that the check is not interested in RAM (or any other kinda of memory like
VGA). That's covered in the 32-64 ranges. But rather in any PCI device RAM that
would fall in the 64-bit PCI hole. Would memory_region_is_ram_device() really
cover it? If so, I am all for the simplification.

	Joao

