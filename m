Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1F179A725
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 12:13:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfduy-0007Y4-Di; Mon, 11 Sep 2023 06:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qfduw-0007Xh-86
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 06:13:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qfdut-0001HX-8x
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 06:13:18 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38ANURr7006275; Mon, 11 Sep 2023 10:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=gAD7V3ByNBabdgqNZdEapMpfqhofEao1mSjiY2VGshU=;
 b=UtukxYwI0/Z240lGqGKjlqNMx9YpW/6aBwgRQRexNs5nXEKQXUHP5hpKmE8AdQnIUnqZ
 H2Cta8Zq/Xk3lYUOFNzf8dFhLvQtcEQ3+zl054B/92rY7PdDzQmkb3kEDlAFZ24exTpL
 PgWn4HsbZcHOX14V+gQpG8xV+0MIW6lRbgsvFUDbQzg/A9Zc8beDDWqxAPwo4hZpziGE
 bd3DEr58w0Cv8iXadaiCtx09/d9Joo6uh/fAZNuj+f0V6bOOc78nOoow49I1qPZOWigt
 DOCGhGQW3uvqS0WjllcsqPMK0VHg7UiRfSFRw+2PlOXUFClR1JdB2T8zIdtxgzkhtk5Y PA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jpas53r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Sep 2023 10:13:11 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38B9V8RF014713; Mon, 11 Sep 2023 10:13:10 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t0f5a8kg0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Sep 2023 10:13:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afLI4wYnfYwNmqpH+TIasQrnrwSlkqWvzgqdKMWbu0BTnNHx69y9RRFwwZi2eL9HZ20Czl1NNYtPb+/h1vzN1fDVP1KCeLhoxh4BZfjiFZ1TrDXyLGcsWoaGVMnDJlP0iHTM0OqIazBSCC8b6+9T5uCV0TskxNKLurmWalLW6U56t9z7HCIDv06PccH9bjIl85tMqNa6FNfxkfA5DwR7xYEvHZONpnznVJJfYxZOHxWImg7OxMElYORv/60QzYYHTYxVvIm5CYq+eAwm6gu26Gf8aup23uEzFP4AFWIASys+I31bx5OuA6F5ANgCgvY4xtGzwX8FiwZh0LyHviO3yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAD7V3ByNBabdgqNZdEapMpfqhofEao1mSjiY2VGshU=;
 b=bIU72Hsuhm/EHYnzfWCdInhaB99VKIZhw9zJzeW7UbU/iVap/MhWEiYF8miQwZIUq0T6k6ieK5Nwsq17/VOkvKPoINAPvEbrq/wvRW3up1+kyoPKfpCTsuXYbLfwLV947UYtkauWGfXlxryrs6wHKfhHYLkOMoOHeww/Qagrok2T/rclhOepE4LIdVcB6O5u8E48MQFsM3wI+tPP8JRpDAYiectivpa9YolHi/GW2SzbGCC+DDGp34QKBbxi+dDnLF+yuyL6rNYjTkFrd9HBWXsFP3hoywhKQqFgEJG5zk/JfQA8l2Q/TGBmvm9PiClnDyQG1j689O4yyH4h2kAviw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAD7V3ByNBabdgqNZdEapMpfqhofEao1mSjiY2VGshU=;
 b=bka24+5wBv9g8OsaJkav7nrxZatKKNV1gF2ESHkf9n4nRpennKRUqt66DUzGqwmTcQDiciyMBf20gLUlbCN72wvL2p3uBNPVAVBeqJ1EzYa8RUsiYU8NjSikIscrKxqw51EclBJfhDHf2h5EI2coXotdTTfoQN69Ej2OK3SQeMI=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by PH0PR10MB4408.namprd10.prod.outlook.com (2603:10b6:510:39::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 10:13:08 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 10:13:07 +0000
Message-ID: <c2a52c37-b6e5-1229-3e22-90a5ad8068b6@oracle.com>
Date: Mon, 11 Sep 2023 11:12:55 +0100
Subject: Re: [PATCH v1] vfio/common: Separate vfio-pci ranges
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20230908092944.47589-1-joao.m.martins@oracle.com>
 <SJ0PR11MB67441FE6EAE5A0AB8992FEF792F2A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <83d2de3c-7a3d-4943-d4b5-1f4a86030512@oracle.com>
 <SJ0PR11MB6744CC7FE6F48E7D17ABC3CC92F2A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB6744CC7FE6F48E7D17ABC3CC92F2A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|PH0PR10MB4408:EE_
X-MS-Office365-Filtering-Correlation-Id: ef74ee7f-3f83-449e-04db-08dbb2afb1c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hYbvFZMEfaLAvSumDOycTOpBovUca1xk39mRkGIyQjVkpoays4MyAMyVX4J2KiPFW4uYgz/j0XsyFCJSiEHCmzIQofLHtzhvupp5LL/8+qrHKYBD6cMNoGE5n/u9KsDHLbt6r6NsQfn3gqdoiplZ7bsnXNRw+s6mqCOm2wH1XkgKJdAc6K7UB/kqWc3c2ykJwVaAEBH6q2tI0dGo3TXBuabiS+PZhEkYHnkpUTlBSVv3plUPaNp1XFbJrTHcfH8p4mWisZ9JdqYapp07o6zN4Uor2sqVMsnQ4ARfTle08q3TrlDPBw8MEv5V8XFDjmFjCJ9SOnfHr71TgWtDgKH/i0EJ8cGEwJBFButQLejcaHiPFWcyjNVc2Pj7sI+WWP5+pzQltUsBjjl9JUIoYp5KW48T06hzfFjK+pylMWdjW05exr07997iArcnse90lI+jeCf0UIDVpp8zkSkAoFrSbYbiAnT++X6Tg/pcs4jU0/6dHXjHtUu29y9Dax/7livTuKi3NQaxybxCYWuKRWqNnd7oaBq0u1Zbn01pMYxBZM8iGvG1CKacvg3vaJDye6rdlFd/tP5yNTldhbq5Ny5MJ2IpsJwO8ZTHAyZR3s84ZvAozT8MRKxXFN91hPwGWEwN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199024)(186009)(1800799009)(83380400001)(66574015)(26005)(2906002)(66946007)(6916009)(478600001)(316002)(54906003)(66476007)(41300700001)(66556008)(6512007)(2616005)(53546011)(6506007)(6666004)(6486002)(31696002)(38100700002)(5660300002)(86362001)(8936002)(8676002)(4326008)(36756003)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akJMMSsyNU9lRlprTEhndjNCS01YdkVFSUM2L0RuczZLMzFwWHlZdmxkYU5r?=
 =?utf-8?B?WHB4UUF3dmRLOUg1WmVVRTM1UjJBMHJqWFdGbjVYeHlzSVBzME1mYU9XVXlZ?=
 =?utf-8?B?NzhRMHFCNXBPcXlBRzJBN05LUWFBZkFFMG90UVkvRmhnWGhUMmdCUUtBRW5R?=
 =?utf-8?B?RHp3OE9YMXl6MENmejk3dDgvZ0U1WFpvTnlxanNNOXNkaFRVbVAzTjNyYWF3?=
 =?utf-8?B?aFQ0STY2eVUvYVlKWVpsOHJUbC9qcXo0WGx4U1ovK0VtTktTaHBWUW9CcVhY?=
 =?utf-8?B?SC8yRXIwSVcrMzV1bncrS2g4UGVnZ285YVBoTVRTUHF0WU0wV2tQWWM1K3Rs?=
 =?utf-8?B?UmtpT1h3NVp1SmNmR2dCNmZXUmdwckRPTTV6SjcxalN3d2g1OVd5bnN1dURI?=
 =?utf-8?B?M21PSDBXbFFlQlQ5ekxsNW5lK29CcXZtdWVRN1J4akJsekMyQnMyMjJXdFZK?=
 =?utf-8?B?OC9rbGpHUHh1Ry9pbzB4eDNuTjlPU3BiQW1wQzFVWDRjZTZrRC9VOUdReENm?=
 =?utf-8?B?eEVGS3dFVVJBNERyUmVDQzlSQjVzaDZteGZaN3Y4cTV4YXIydU82bDBIeUdZ?=
 =?utf-8?B?SlhPb0xHOUtXRzg1UjdqOE9tSHJBNHV0MDhmK1ZLdmd2RGhyalFsYVUzNlNn?=
 =?utf-8?B?RFNpRmRkWHo3YWdGS2t1WTM1NWxUalVub2hMaXBGNmp3VE0vZTlSVmhrbjl3?=
 =?utf-8?B?enRJSklSVjJubUdWRXBMUE9WY0ZkQURaSVhnWUxqYjhHQjViallKbE5TcWFE?=
 =?utf-8?B?OXpVUHFEOEFRMFRsS0duUTcyTEJLUW1qS016bDZwMUpmOVlEcWxDV3RpSUtG?=
 =?utf-8?B?TW9DenF3YVJBd3l1SGo1Ylg3L2JXc2Rkc0UvSmdoOXAxVnRzTVJYZnNtZjc0?=
 =?utf-8?B?SFgvekEzTmRObmFTVXFKNFI5M0ttcnl1ZWFPaWR4Uk9QM0NvRG5OL1FXVUph?=
 =?utf-8?B?aEQySGFEZ29Hai9KZndQTXljU09LV1Z4bDZXZFlwUTZxVXJuZDQ0d0QrWDIr?=
 =?utf-8?B?TGhtaGw2SHJLRTM2YUVNcTR2SHNRVDJlSVcwR2lKcjlBNHpSZ2p1TUNFenNv?=
 =?utf-8?B?RjV2emF0dGZMUFI1VTZIM3IrVXovcE91SU4xY1RKYldrNlFDeDVWeEEvbm1K?=
 =?utf-8?B?RGpXZFBSaVlIWjZPNzhhd2dGYVZwQWF5TGRGZW5aenEvNnlVZGp4TG94dGlj?=
 =?utf-8?B?UUh4ZWhIUFBCWmczUkRCc1V5ZDFhdUxzOGJ0NXRNaVA4UktvRHRVYzJhRWZL?=
 =?utf-8?B?YURyQ0sxNExoN2o1S1E2VjRpMW8zb2psS1FSNmhPTDAraklkN01YdHpsdmxZ?=
 =?utf-8?B?aGViZ3RZZ3BzVlkvSGV3QWhjU0p5cU9peFg1Wmt1ejFtVjVvZTJOYnFyOHJZ?=
 =?utf-8?B?QTBQUWpLanlIUHJoQ2tGb2FUVnF1QVlyL1NpTFEwUUZWMCtJREg5elRJUmxm?=
 =?utf-8?B?dGlGeHp0a0Ivelc4N1FmeVdocXc3bDFOelVNZ2w4a2Mrc1N1cUc1dng1RXhv?=
 =?utf-8?B?ZXVMNzJoZEs3S0ZjSVVQN0hCSS8yV3JIQkZnNWR0cXB1em9LSmhQR05zMW5q?=
 =?utf-8?B?TngrS2dvenp5cHJPZUQ5ODRWWXN0RUE0ZzNFZnBTRDF3MExCY0M2eDlUNGQz?=
 =?utf-8?B?VENra09zRkdTQTd0NEFiRGZoN3d4MFRlSmZYNzdBekFoY2Vndlk2UkhRWE9O?=
 =?utf-8?B?a2lmeWdkS0d6VzBBVjVHdXhySm9iN3oreXJyS1pwSGc1aHlIN1JFZ0xJWkFL?=
 =?utf-8?B?OFRtS0lyQjQ3Q3ZST0RRQ0tHbTQvWHJxcWxOVUtOblVheVk0OWlXck5RQkJV?=
 =?utf-8?B?cXIrRHBHWWFJUDJWSXFVeHRuV2dTWHUxUmwxTVlwR2NnalNTa0NXQ1BnQ2VT?=
 =?utf-8?B?dllFMUZzaGlJUFlaZnM3R0FGbjlhQ21MaFdEM05rc3VSWkIwVk5NdFpUTTVo?=
 =?utf-8?B?aWlvT0drcWwwd3JNaCs1cUhYQUphNkJwMnRDWXFaYVArUTJIVkhvOS9VYmN2?=
 =?utf-8?B?WVo0TCtPWkpKVUxYSXBuUStGS1JqSmhOOVVsd011N2JOeFZwUE9OV1pJVHhj?=
 =?utf-8?B?dThXUHRBUUdjaTRHQ0VnWjZzLzFUZUVRb3pxdkY5cnZOZjl3RzRUeWVEbEMw?=
 =?utf-8?B?WGJmOXVOZThhUUp3clNLRFFxM2k0WFRBNnhDKzF0WitJZnJMOVNYMm4xcE83?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: w/DE9LrHmCrc1doII6RioNLEewu6JpPNUiG5KZSAZfz6MegJZJ6LLbL3yhhMgIoPUw2sXMCN0eXH1JKXUAmx0qK0iY+7ymnJed/vARqrfDSfZAHutDtG2JfW0ugXHxzlzJyE7b18jrHaxAt2iHy2gWMezuQsBXjBAErh0xiP2igTM4iLYHYI6vGLIMeaSebmXY0QMPFSaM2Yp+pPmECyj/TbjPWP4JXvj2UmqemHk/IjRmaoxrY+Z+hiA0v4xPrpdjVvdGYtKUkvrhNPb2nTcyLV/aFb4ATlkVfbE463ETj1gxYS1ZICEuQe/WKbX8nhdwOXy/D7YfNPrCIo7yXCc8So9dyLeXPDDp5MzKl8UT3DLRKaCu/kCfYjVp0y/qa33Yk2c2A2LsvdHR+x68OpiwVnU2ryQsPstVL4rJI4jO5v7CDHexbzAUZvCdATYEZ5ZQx/sl7sMNaRsEWdKX/iqqOKKd71KDmb5slrWwSPTE9OyschGqvxk6yqwwYyAWvIaIYobX4o5osHPvar5M7T3nviVv0/JRJMkhuDna0ZRGf7yTO4IDh8Z5naWDUQyW79KyaQffMMAB6S2okeuN/OofZYZTdz2jTZxmfHg2/zcGS4XJiUxXYz1JW8x2QIjXCkjwcXL4QGqWeyaVF3iouZLXZseKhUk0XUcq4424WX47T15gYmVygHhhGPqt+Dl75jYOFUbd/RZscFC0JMxh0WkIH11V29BHN/bfxAn7wSLNkuoAMw1GonHtdCRJKPSuXOEqUn/VGwGBOJqQXUD1bVMkUORbaF2HwpgG64AE3Z1odUgO+FV4Ncc0LnWDQm5p08bnJ6eDaTn1XlPt22KwV0iQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef74ee7f-3f83-449e-04db-08dbb2afb1c1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 10:13:07.7748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MufkO9HJhYyftur8k8M5/DlX3BZA57nQZdRr54GkSFAdGqALYFdEiqgcVTtFKNlEha3L5ZwnsJUvRVGQ7C9NmrkiDKvB0VF3Vpzcg5UWryE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4408
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110093
X-Proofpoint-GUID: yrn5mkoiM9Jtvv8OHMgFdTl_j9ymGLtP
X-Proofpoint-ORIG-GUID: yrn5mkoiM9Jtvv8OHMgFdTl_j9ymGLtP
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

On 11/09/2023 10:48, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Sent: Monday, September 11, 2023 5:07 PM
>> Subject: Re: [PATCH v1] vfio/common: Separate vfio-pci ranges
>>
>> On 11/09/2023 09:57, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: qemu-devel-bounces+zhenzhong.duan=intel.com@nongnu.org <qemu-
>>>> devel-bounces+zhenzhong.duan=intel.com@nongnu.org> On Behalf Of Joao
>>>> Martins
>>>> Sent: Friday, September 8, 2023 5:30 PM
>>>> Subject: [PATCH v1] vfio/common: Separate vfio-pci ranges
>>>>
>>>> QEMU computes the DMA logging ranges for two predefined ranges: 32-bit
>>>> and 64-bit. In the OVMF case, when the dynamic MMIO window is enabled,
>>>> QEMU includes in the 64-bit range the RAM regions at the lower part
>>>> and vfio-pci device RAM regions which are at the top of the address
>>>> space. This range contains a large gap and the size can be bigger than
>>>> the dirty tracking HW limits of some devices (MLX5 has a 2^42 limit).
>>>>
>>>> To avoid such large ranges, introduce a new PCI range covering the
>>>> vfio-pci device RAM regions, this only if the addresses are above 4GB
>>>> to avoid breaking potential SeaBIOS guests.
>>>>
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> [ clg: - wrote commit log
>>>>       - fixed overlapping 32-bit and PCI ranges when using SeaBIOS ]
>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>> ---
>>>> v2:
>>>> * s/minpci/minpci64/
>>>> * s/maxpci/maxpci64/
>>>> * Expand comment to cover the pci-hole64 and why we don't do special
>>>>  handling of pci-hole32.
>>>> ---
>>>> hw/vfio/common.c     | 71 +++++++++++++++++++++++++++++++++++++-------
>>>> hw/vfio/trace-events |  2 +-
>>>> 2 files changed, 61 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>>> index 237101d03844..134649226d43 100644
>>>> --- a/hw/vfio/common.c
>>>> +++ b/hw/vfio/common.c
>>>> @@ -27,6 +27,7 @@
>>>>
>>>> #include "hw/vfio/vfio-common.h"
>>>> #include "hw/vfio/vfio.h"
>>>> +#include "hw/vfio/pci.h"
>>>> #include "exec/address-spaces.h"
>>>> #include "exec/memory.h"
>>>> #include "exec/ram_addr.h"
>>>> @@ -1400,6 +1401,8 @@ typedef struct VFIODirtyRanges {
>>>>     hwaddr max32;
>>>>     hwaddr min64;
>>>>     hwaddr max64;
>>>> +    hwaddr minpci64;
>>>> +    hwaddr maxpci64;
>>>> } VFIODirtyRanges;
>>>>
>>>> typedef struct VFIODirtyRangesListener {
>>>> @@ -1408,6 +1411,31 @@ typedef struct VFIODirtyRangesListener {
>>>>     MemoryListener listener;
>>>> } VFIODirtyRangesListener;
>>>>
>>>> +static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
>>>> +                                     VFIOContainer *container)
>>>> +{
>>>> +    VFIOPCIDevice *pcidev;
>>>> +    VFIODevice *vbasedev;
>>>> +    VFIOGroup *group;
>>>> +    Object *owner;
>>>> +
>>>> +    owner = memory_region_owner(section->mr);
>>>> +
>>>> +    QLIST_FOREACH(group, &container->group_list, container_next) {
>>>> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>>>> +            if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
>>>> +                continue;
>>>> +            }
>>>> +            pcidev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>>>> +            if (OBJECT(pcidev) == owner) {
>>>> +                return true;
>>>> +            }
>>>> +        }
>>>> +    }
>>>> +
>>>> +    return false;
>>>> +}
>>>
>>> What about simplify it with memory_region_is_ram_device()?
>>> This way vdpa device could also be included.
>>>
>>
>> Note that the check is not interested in RAM (or any other kinda of memory like
>> VGA). That's covered in the 32-64 ranges. But rather in any PCI device RAM that
>> would fall in the 64-bit PCI hole. Would memory_region_is_ram_device() really
>> cover it? If so, I am all for the simplification.
> 
> Ram device is used not only by vfio pci bars but also host notifier of vdpa and vhost-user.
> 
> I have another question, previously I think vfio pci bars are device states and
> save/restored through VFIO migration protocol, so we don't need to dirty
> tracking them. Do I understand wrong?

The general thinking of device dirty tracking is to track all addressable IOVAs.
But you do raise a good question. My understanding is that migrating the bars
*as is* might be device migration specific (not a guarantee?); the save file and
precopy interface are the only places we transfer from/to the data and it's just
opaque data, not bars or anything formatted specifically -- so if we migrate
bars it is hidden in what device f/w wants to move. Might be that BARs aren't
even needed as they are sort of scratch space from h/w side. Ultimately, the
dirty tracker is the one reporting the values, and the device h/w chooses to not
report those IOVAs as dirty then nothing changes.

