Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C1C798583
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 12:13:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeYTi-0007mh-WE; Fri, 08 Sep 2023 06:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qeYTI-0007Fs-73
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 06:12:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qeYTF-0001Ta-HE
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 06:12:15 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 388AAq0N016550; Fri, 8 Sep 2023 10:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kQOG8PfrMPXh89RbkpEF3gKHwky97VQL+34qOADWmPo=;
 b=4RDyoulpe27MASUBABVu6hxwPZjVch3nin6d6uhBU81H3LCFnafyYSC0J4zlco4OorgU
 xzIJ7lW5UZVunFs7JM6gYu+M+QtL6IO1H4PWWnATFmxlTQwYdfqV4h2h2bANdvDtAYcu
 g45E7pTlWFaAOeE73DrnGSp+4hRQp5mOsNvBDT0prJJG5MnmFsNEtPo8tKJP7+jbqug/
 CcIAsPb9U9Ck6SlmOfvhkQMwBUYrt20tGdD7ONKIjn7BwbrigbQpwFq6kuZqP/8qST7X
 aOuu99c+dMtZbEhoSexWMFNDVCFdQa7DqKBt9ZDPS1ZHWsQAMtIp+c55KJDiDYkN3hfN wA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t01m5002w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Sep 2023 10:12:02 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3888DW26003946; Fri, 8 Sep 2023 10:12:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3suugf86a5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Sep 2023 10:12:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5hxweFayiRToJNM2LbfzANa00dBsIJKaKZcK3U52bIVveFue7fv+k8IK9/vswrFnWctDAqaUCG8NduqfA9HN+tcfRkUZUTxmn5rZftnWK7e6Dw0Yz3FpbSN/7EyhaKL5HI5FFJHwvnR7t1Y0uQguj3ZeG6rUv0Jx/4dZ8vsCJysgW5nILjl3aNqqy3Hg23a+5M3gWlSGUIqT6vwf7iY19iSqF19rbTGNw63Tgmf84RYUKglvn5ooYfmrfnR3ABELU8Z/VyxTw2DN14bz4LPjiLCXRsfGR7VXMH+WYKlVSmYPaQyV88T9TeoPA0KbhL1lCKlEEcgza/2ZqBQipMCBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQOG8PfrMPXh89RbkpEF3gKHwky97VQL+34qOADWmPo=;
 b=HEbxXbTdRRd2h28laJfHQbfz5/zkzsY0MbDg+HB/C0KUjMPDMujxdXfYxcWGFH573H2lIoRpjxftr1bQVBQ/vYPDm4/rLc1A33H0XNqhy1kMGMkK1WFkwwzmqsUGudIr11j2q6Fl01dX7Kvzz93WGdYh3wJ+qHcEmxGCsi/2OBRO0mikC/3sxtfVK+5A74eMaAKsjG4o6Q1M5VTkkYs1UOHhVEa56gRu8m8J0KZ6SwqiGf8vHoio4Orbi0/Ss7Dr9WQ+yo0gwjemxmoL9gq/ALMXBP7uEt3wojztUs/yBkcrEzcPGeil5gm5Dr23LLxycqA/3Yf5DpoUx6B/fIBnRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQOG8PfrMPXh89RbkpEF3gKHwky97VQL+34qOADWmPo=;
 b=KY2H4CCIcpvnPRH9mXlA1receL28uTvAVb3muE3a4ep8Ua0cTDqzorN68pk3W4LHoW9nDDVzX60aUg/CDD3stogLoRS6QX8PEqqbEh6LSrsyXlQnnCsfk2yNdJ5r2m9XzAPAmC3CHdCwi/yPZWnft8t5nZ3RcrpPIjeV0zzRqpA=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by BLAPR10MB4900.namprd10.prod.outlook.com (2603:10b6:208:30c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 10:11:59 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 10:11:59 +0000
Message-ID: <8d6674de-2546-5de5-eaae-823821396e7f@oracle.com>
Date: Fri, 8 Sep 2023 11:11:53 +0100
Subject: Re: [PATCH v4 15/15] vfio/common: Block migration with vIOMMUs
 without address width limits
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
 <20230622214845.3980-16-joao.m.martins@oracle.com>
 <4ab1868b-730f-ea9e-1c06-00d94090e550@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <4ab1868b-730f-ea9e-1c06-00d94090e550@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::24) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|BLAPR10MB4900:EE_
X-MS-Office365-Filtering-Correlation-Id: fc6d2f3c-3ea9-439f-3a91-08dbb05409d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +rOMdq9TEss938Ht/cPwKQnxfcBn5tytQTgLWrQ5En9M1DhNPPZOnfmucmIPnOwHHjKTwU10/nrULFZ7QnLBraXRQu/TzL6g206UcUxZo3Qu8o/p0HNS0F70BDXhez73Lbc0mnBjmpucuk5Ev23qF5cDvf2v8Aoiri4suB8Gxfq9aTTM5UkXwhPevjPA5G2NicjqMxHBaZ9AGXDVohkcEaXt5fDSTzE5aukfU5tpmUzgZhucnDGh5hKAVRM6jxwVUhpoZ4pmfNa6f7CbMHcv4K0oLyuaW+2cp8yhs8ze7ftDHenYex60eQgXZtGJ9eArSF7gfB6Rtc3SwZy2utu6oEejOa9/Jad4uw6PZhVDqRSwyAGFI3x16BUQpK6QBp0JTeawJGlPhB6ScJBpbSBgvYcgsDwioubJOUnYFZAayG7q5A6hljQbsRQ232vtw8XIlfvQyqUROMlJiTsjsD+JiIJy46p7MphJLY4v+zUUnkTYwB6yhMqafNSEKvInW+CrCWnxrO4qKOcrnVNYiHPw/AYtbLzR9n5EtnRcn9VWz2Mss9Xh+Hp/gzkY7NaL/JWv06NsneJelBes9Uq8QtBQq+gvuhL3RiGdJ47yhy8q7aBzrIyy25XW27iESz+EXBYA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199024)(1800799009)(186009)(6486002)(6666004)(6506007)(53546011)(6512007)(478600001)(41300700001)(83380400001)(2616005)(26005)(7416002)(2906002)(66946007)(66476007)(316002)(54906003)(66556008)(4326008)(5660300002)(8936002)(8676002)(86362001)(31696002)(36756003)(38100700002)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHF4VTRsd3piWGF0d3hESDZNUkYyTWxZYzBRTWZiQW1mTGRKcHBpWmRrd1lY?=
 =?utf-8?B?M2w3ZDJ5M1ZoMjh4ZWV3UjQyc3dVTDNjWUJucnNiTm1hZmVCUndhc3ZFV0VF?=
 =?utf-8?B?aHNTeEt4OGNsTW1ROWdZZ3ZFTzh4ZkJCUEdsVERGM0hYbWhaQjNXWFZza0Qy?=
 =?utf-8?B?T2Y4aGtvc3BLaEdiSHFUNVlGSi9jMzhPVm8yWHg0aXRvZFJwWDJxUXdOMWlM?=
 =?utf-8?B?dktIN0lMbG9td3ZLUFJONFRLYlZ0NGdqUU9xT2cyVjFKdElQbS9TeWV1KzBw?=
 =?utf-8?B?YlA5cDFEbWI1YzE0ZUZpdDN4S0FTNE1qWFNVUWQ1TmxEWWNDelFMRTFTL0hl?=
 =?utf-8?B?U3FJYmJDL0dxaVp6VXlDK2hZMjI1ajJkekxsTWFkMnB1UDZocDNvaVAxVDNO?=
 =?utf-8?B?NUVDK2dDOHBYR01ray9zemRzR0VmcmlTd1AxV0MycTVnOW15VVdUaGwzQ1hE?=
 =?utf-8?B?Ry9teTlJc0ZYbG5PSE5GTkl1aGM4SDZ2eENocFdPV0Z5VlFXV0tZNnEwMjRz?=
 =?utf-8?B?d0RyVXFqTDV5aEFCaCtpdWUxWk94WEd6NHdMdURjWFJVdG1aNVBLU2ZBYlFN?=
 =?utf-8?B?Y1NGQTBHbW9pVXJQYkN3NTM1Y0FiVXY0QUJRRkwvdVJhU0dNOStiM05uQXZT?=
 =?utf-8?B?NmY1ZzhlOEpwRWpVenc4cXovOFpzdGltcWJGZ1BieG11VUJYKzAxOCtqRlZQ?=
 =?utf-8?B?SnVDS2g1azNQNlpYYzBDM3N4K2EwaDZBRVYwd3lLM2VjRUJZTG9HVDg3WGl6?=
 =?utf-8?B?QUxrSHFRVFFUQVRuWm01M1lKb294MSsyR0RzSXBOaGhqZmYzd1NHd0NlUDhv?=
 =?utf-8?B?WktTcHVnS0doWjVhQkduM3FFOFZKRjh0aHd4Ylh3d2srM3dtVkRIZ0Y5VjRB?=
 =?utf-8?B?azB4eWg2c09iL3RlZlNmTW04ZEdEQVB5K3Rna3lKWjhoRW5XRUNGYjRycnYw?=
 =?utf-8?B?UnI5UGhjT0RYODlwWjFaUk1FMGhYc25RSC9FdjA4Q3kraGEwek1MYjBTR1Bm?=
 =?utf-8?B?Z3d3VGZuRmJpZnVsUFU1Q3A2NDIvM216RWhLUjE4QS9Ra0tnT2RPbWdpQVV1?=
 =?utf-8?B?dFQ4V0hoSlRCNGRjSHg3dTd0YXZiZGRhNjk2NXprUTdyZFFXeEhQc3ZuclNK?=
 =?utf-8?B?MVY0cmZKNi8yS3JLZEVjNThNWXArd2Q2a3BUWFNyVjlFa0VhTU42V2lLYUh2?=
 =?utf-8?B?VzZHcHFnNDlBd2RlS0gybnEvd29MMERDVmhGcW13bm5xajh1RlArc0VSRitP?=
 =?utf-8?B?VmpiaVI2a2pmUUFrbGtSSVdJWGRPenQ4OWFJZ0RMYkc1QzNHZFZVbDQySDB0?=
 =?utf-8?B?L3NMOWhnK253WndEdGN0RTNNbjMwTklteXowZmNDSGlGOHlYSEFJaDFuVTlI?=
 =?utf-8?B?MU1YcmpKaXlwMjNyU3UwWGEvZ05Ca0pycjF1YW5DQlkyKzVFYWdCcDlpTGtD?=
 =?utf-8?B?bk5MOHl3UEMyNnFWUXI0RTgzcDI5T256Z1RWaW0vREV2czB5bGE4Z0d2S1FT?=
 =?utf-8?B?dHg4TUE3NUhzRnd3ZmtEakxDYk50WEQxMDQyNGYzSG5hV2IrWS95Y0FKYThG?=
 =?utf-8?B?U1Rpak5vc2kvTmptM0cyV3N1L2dNdDN3RmVybWVPTmVZTWE3Zld4Nnk2Y0FC?=
 =?utf-8?B?R1RjSDBIaytyVzNLdFJSeFE4b3lHY1l3by8yeWJrZ2VSaHlGandOUGYyUkRB?=
 =?utf-8?B?K2Fvbkd3TW1mYjYzczlrRUh1SllGclBsRHFicno1MGJQajZNZ0RGRWNSbDY0?=
 =?utf-8?B?MUdtSFZkY3hreWVNZEtvMGt6OTU3cXhaS0hnUkFTRWNMamFKbFNjMVNnMllE?=
 =?utf-8?B?S3NDMyt3M1djMlFUSXZtQXBUNy8vTGVYVDFzZjhQbFhZdVFwNjNCT21BcWhk?=
 =?utf-8?B?MGEyRnFROFRvdUlPclpnMldRbHo3SUl3cncrOGNNRkliU1N2Nzhvd0kzVzRB?=
 =?utf-8?B?SWxOV29kT1U1N1dLa04xTWM3bnJPWUY0M1FmRGxldUZpcXhIb0R2aDNIbGI0?=
 =?utf-8?B?eFVjeWYzTGcyYjlubjFDY1NmV1V0ZWQ5SlVMdWZzRW0yd0l5aWNkVlhXaFF1?=
 =?utf-8?B?VWo3U2tTSmhnRVgzSm0vWTBvbnZBd1ZIQzFhV21aNStxRDUwcmpuTTdXcVdH?=
 =?utf-8?B?WTNMT2Ruekd4bmhINHAvZENVT3dkZThVRCtPelFDUExDOEp3TnFNWktSUTho?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: td3K5s7KxT8onoe3ypNSonQTJ6YUGPLPX7B0PZ3fCcHuvXW8GPv3YjZdUuYO88+Sp9wu4R+I94dIIB8sitbB3Wl67TT9fAFanpTy0pCBr7g0wXvjimtvW6wFAcd38WOH3fiC7es/r4ew7vgAE0UyLJ7d4KUIG4zN0dI+jA3YaAk9S77xLgOoUlWsTLVwrfHgj0GdgRWGvUkjY7FTY41mIDmZJLTPgpDr1SwSUA0JA0oS4EZOUs/IqiEDS7xFiJyquIPeCC6ae20KWNeuQ1CCrEQAncOmR6SJXMdsjcNOvg+9gylO/0eVL87QQGeGcAaptO3+1LZD4wMLAsiLmHynb6AEG09T5Uxc2ihi2KfH44Rl/lDVDQAorBxkiGd0x9zDo4KuqncsJjlcIBc+fTTWeqICZM7iOKVugZ1byXI1nOfkUuL7aSSU06O0Jyz0wmY3r5Cr7eqx98d042IIQGmAvkSLO0r8nav+8ewWCIQS2Q0bJ2b8rzdHz3+tMl5SNgP+xZB62XDoylJh6D2jpftIZep4yrHEUzsV+ayWGk5/4SGRFioNZILgJ53FohPLHxYVi/tc3/IVvnOuP2YfeORF09MZm1cto+levgH1bUad2saPZ824/451b3aFs/FmfnUs4vuG0zyZKEJqnBHLns+cecQmU+RvRlJb3y0wascs7j3mc+QrMxn5BFABcMb8M4m88yMimtFV+sFxq+Dq+TX9pMigcCsxx2ct0WaaDftRiYDlzdLe27VQKZ7MO1o2KR4Xyf23oPVplcZDVpcGyDprOebIy5+hwm9O6qY1rgemDTmENa5fHTPb9LjdVcwI84V56G1Xcl54XpGVnN3ArNCq5ITixpaN2eUF38sR+eNgPcfwBD5dxBAXEMhxyfEr2y9J3d3yFCg4C1mcqPCvyaiI1xiWYUkTRVC3K5pYY/6VfEc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6d2f3c-3ea9-439f-3a91-08dbb05409d8
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 10:11:59.3857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCQRK5ZZRqYqGrKga+vcVatUepMNTR7eByIPWt1JX8P1sVpDdaEE3yQZVVFYodZJviqNDjGxKF0Siq3WUQaIpAq/xRkR6r8lzjapdSvKupk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_07,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080093
X-Proofpoint-ORIG-GUID: 5RVapZMWicyIBgJW6e4uKXH7KotETbj0
X-Proofpoint-GUID: 5RVapZMWicyIBgJW6e4uKXH7KotETbj0
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



On 08/09/2023 07:28, Duan, Zhenzhong wrote:
> 
> On 6/23/2023 5:48 AM, Joao Martins wrote:
>> Only block the case when the underlying vIOMMU model does not report any
>> address space limits, in addition to DMA translation being off or no
>> vIOMMU present. The limits are needed such that can define the IOVA limits
>> that arm the device dirty tracker.
>>
>> Additionally, reword the migration blocker error message to clarify that
>> we the configured vIOMMU does not support migration, as opposed to
>> implying that just being there blocks migration.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   hw/vfio/common.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 62f91e8e102d..c3cc0dd47044 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -449,15 +449,18 @@ static int vfio_viommu_get_max_iova(hwaddr *max_iova)
>>     int vfio_block_giommu_migration(Error **errp)
>>   {
>> +    hwaddr max;
>>       int ret;
>>         if (giommu_migration_blocker ||
>> -        !vfio_viommu_preset()) {
>> +        !vfio_viommu_preset() ||
>> +        (vfio_viommu_preset() && !vfio_viommu_get_max_iova(&max))) {
> 
> Could be simplified as below:
> 
> +        !vfio_viommu_preset() || !vfio_viommu_get_max_iova(&max))) {
> 

True.

