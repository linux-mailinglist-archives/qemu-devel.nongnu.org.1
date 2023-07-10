Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F9974D805
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 15:45:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIrCR-0002Zk-VE; Mon, 10 Jul 2023 09:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qIrCP-0002Pr-Gj
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:45:09 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qIrCN-0002Pb-7F
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:45:09 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36ADMaHW003075; Mon, 10 Jul 2023 13:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ZXcgTuQ4MRrd6MLFMvhtteCsdGcCPK1Vm1nMEPnsNzo=;
 b=r0wfKKIlsrCmzIx6oGvoaXBLTQFOkQpLQqnBAVVQ5voVAF5a4x/HC7mmpUvbopH6wshE
 r+5QG+mJLot0kaDdMeKUnJc6O2gw3bb60ieMUNKt+RX+MnLpPIZk7HsZiC4RBU0IAcHr
 I1NmEuRQ7J41weJmaKuFIi4AXZ8CK/FJNmplIdFQeEGP36iGvTv/gOiR4DNGeEb2411H
 pJuiLQXZtIEvi7gc0O0vdokRXYfDiM7qATmejqSmcQkro9DRC5HaejZ6iGhv/P1J4gg/
 haFA1k7Nlz7/DG6CpXKy/SUVBICULZGPUzFIFdecbBJTqBx9ayuT7da5lMyEDXJJAL6m ZA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rr8xugy1k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Jul 2023 13:45:04 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36AC3Wk4006367; Mon, 10 Jul 2023 13:45:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rpx89r8dq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Jul 2023 13:45:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNrZNvTyL44xkDCdjQlVVq430+XznZ/Y/bQuWuU14K18pfFhzoa7MbymR+mZIeEiYzgQcHau57TZ9xDTN6cej5YiFlUmLeFI1kff12EYH9rKfgvbhSSg/AKsU4qIcyrEIytd66ovojDrG18iP9zU24d3fcjUQQFyLFcrA3VOKA1xhzUqc9ET2YdDhZKVkyWnVsHXVYwE1kSBQNSylGsOTc/r8leiszgY7x0/ZEC7hje51JgTB7EXCVa1e0GQg08ak4wwgzuR5LKtwYiUcnrZ3HarO5AxdU6jbdvVKXkNDdkHYr3CyQpwOixI2zEap3+VwmVK2dci5TM3jygBiGQBww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXcgTuQ4MRrd6MLFMvhtteCsdGcCPK1Vm1nMEPnsNzo=;
 b=nWeJx7dzgaD0sxPc+gQgluvxAoJghLKlvMnxgm9b0HA9gbo6/yP9Hd1PdgKDcyqvejuR3Hl4Iohm7IdF9mkHLpBe5pEyMwV1yg7r8BWgfrRXX2g//GkZG5WwUZh4Nh9CG6Gq4FPlashOtXG/i+86O5QesVY0in1nf1wSlno3DJV/2HsH67qQV9lmd/Xsw1di0SoH2uNNcoDp8ABk8lvPpIfiqirCXkJMBGTVGuNDYYmofBbq9N2OJLZEo5Oif1fn3D4k8DirGfaGdCr4F8JGNRtmk5GiaYl14r2x+Bqhwtc602cWWRGSU6QDZrk+kawJOBbAyNq1aBQ+IofRWHPdHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXcgTuQ4MRrd6MLFMvhtteCsdGcCPK1Vm1nMEPnsNzo=;
 b=vkbWte0EOoLNvmWvKmXJeG9sOXYNWDC1DCRXX8fGeXRaE9LoHBs+Yjd9QgV4rNO3gAkSi3cmQeUDRRSQVpkaZaGgBSV8eBvuEC/grlEWOvU9v4pXDXsDVd/Cl8a+Y+VcBE4OzQIlpiWhxg/neE9vKfj/TXAjJUovWzG5tFEKAv8=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by BN0PR10MB5160.namprd10.prod.outlook.com (2603:10b6:408:115::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 13:45:01 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::6db1:c2a8:9ec4:4bbf]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::6db1:c2a8:9ec4:4bbf%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 13:45:01 +0000
Message-ID: <2cca62e2-6b16-9736-d015-15883ed1b02d@oracle.com>
Date: Mon, 10 Jul 2023 14:44:53 +0100
Subject: Re: [PATCH v4 10/15] intel-iommu: Implement IOMMU_ATTR_MAX_IOVA
 get_attr() attribute
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Gunthorpe <jgg@nvidia.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <20230622214845.3980-11-joao.m.martins@oracle.com>
 <d6787c69-e66b-9e09-2efd-8f60129f0ea5@nvidia.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <d6787c69-e66b-9e09-2efd-8f60129f0ea5@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0026.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::12) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|BN0PR10MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b5f996-3a80-45d3-65ec-08db814bdbfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eBV/9wYnoCMPKEgCcLkS8xc1rFjHd+fHucUQBAhKxbZL2uc9Fnn2HBbNvRnKdDHPQoiU/LNFRPNpKDKkEWdh7QhfVjNBgiLqPIiLuZBLYIBLq5oZESy7bh+UuzZvIvO8ckM7oMuxQiwOPdzGb9KWBd+k6ITl6fejyjYKDS07CjF3g2Fk6yn/FeNp9FTGKWK0ggIn2ZlqUXEPSpmQBtxsRlArx3xaj+tB3Bi5VgvPT/7YXbr4J3As4ePT6AH+/b3vs0OSBvLa/T8Dnpyuj4SijT0JKftGweuKMpUGyHVqbbt5muhO15aaEphRgdJovKT7E7PYcOEyF4ryL29xN/o+mIF6layGbTQz5l1p+I84/44HMrBNQkSlTt/AognwirOEEfoAvGlM1dM4nmiW4UiLLowWTi4Ulcx0OT2BPcHiVwL46uYkCIGEx8Ws33posEYU+zYFBs9lXgy/920XGZIDTKrfSSsmvKQW/K2WOfvAZJh7EPgs1S8KrzZdGglZbqWiusvbhk8v0ROYIGNPhaplzdu84J2pD/xsrYr9H1MkHAzvzL5tJk92QW1benCOTj+a4BiB3VvXAnS9/AKAJy/rR+cYGDhDTEfRAA0BR9vqF6g4W3+FwbthPHD2K0LumNAS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199021)(316002)(4326008)(53546011)(66476007)(66946007)(186003)(66556008)(6506007)(26005)(2616005)(36756003)(2906002)(38100700002)(6666004)(6512007)(6486002)(31696002)(86362001)(478600001)(54906003)(31686004)(7416002)(5660300002)(8936002)(8676002)(41300700001)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d25WQUQxWi9GdUVWanFMajdpMUFiaWkvSkJkM0hjajZQa0xNeXVkTVhYVmRi?=
 =?utf-8?B?cDNFOTlvUWFVcDk1ODV2cGJzc0ZlMWZEclNXSjVrYzZVTFVhMDdNZWdjVWkz?=
 =?utf-8?B?MkJYWGduYmJ5QVJML1RERkVwZUhoNmNsSUpuZjRVRVJPMUZZaVI5QjFTVEd1?=
 =?utf-8?B?cGhDSmJ2UnpkdHowSVI2YmxoeXFPb3dMbUxHNWdoMWpYR2tSTnlFSE5WNTAx?=
 =?utf-8?B?WndSaE5LdHFYek1DSXV5d1F6MjJUM2Fxd2RoMzF2QUdNbFhBRTBGVjBIN1du?=
 =?utf-8?B?VkV0YjFydUhwbzJldVZ1VXhGbUtOOWt5TURjY3F1SzZRV2VhT2VKbHI5TWZp?=
 =?utf-8?B?dndKeDYrMzkvakNjaGRQcFk5RDhZOGEwdVZyWXlFNGs0T3l0dUFvZ0VCZjV5?=
 =?utf-8?B?bGVEcmRnM1dRWEozdGhPR3doWCt3eUhqQVRPUE0xdnZWemFSb05oY1pUalJX?=
 =?utf-8?B?dkEyRmhtbGVnWFdoaDFMWFF6bHMycis0TEFHelY2OVdVNWR0L01NaXVzUDFh?=
 =?utf-8?B?bnlqZnlUWWdON0FuR0dmSzNWVlJ0K21IUndPcUFiN2s1VVI3Rm5XdGlTeTJ3?=
 =?utf-8?B?aXhwM0x2ZWFoNUx0SjB4cnlHbzNkbHY3YjBzOUpkQ25Ka0NxL2krVHhqYnpD?=
 =?utf-8?B?aFA4RC9kUWY1SlU2MCs1cm1TSTlMN2xsVzBzTTdTeEo4eWlBakQzQkpsalZa?=
 =?utf-8?B?aU5JMllwZy9XZnVSbFN4WTRkY3FKU2VpMVRxMFVlY21naVptYmovRUhLN0xp?=
 =?utf-8?B?YlFqNHMrZ0VoQ0ZsdGtzOWZ3QjVNVzdIemNqbHFlYjdmVTZqRE1DeklabjZy?=
 =?utf-8?B?dXhLc0dlQnBOQzBvOEZYTE5EM0VTTVRvR0E0Y1hOT3hyM1JhaDhzSzYxT1dv?=
 =?utf-8?B?UGMrRzhDb01yTU5ZN2ZReHZXNWkvd29qaWFuMTk1MVpTYS9VclhuVXJ3M090?=
 =?utf-8?B?TElVSVJubC8rVERGaXJSOG1KOGZnVFIzbk9DVUNPclpHcERxckZUU3lvK0hm?=
 =?utf-8?B?ZHVZTXl6UmpDZW5JS3hNTGp6aVd0Vnp3WjVxbCtRMFlzVDd6TGZrUkk1Z2ZT?=
 =?utf-8?B?WGJqZTI4WTlPQjdzaFoxM0YzWFNXNGdTcGFZZ3JlT2pySTJoOFJyd3IvOTR1?=
 =?utf-8?B?MCtTVG43cGMzbS82MHN3cUp0b3FldHc3L2NYVFhCcnZkQjZCVlBSeUxadmd6?=
 =?utf-8?B?cU05cUNNTm1nNzBQeXlKc1RhSXpielRUNno2c2hZTzNCODR6WjFHLzVGNzh0?=
 =?utf-8?B?WXNkTkFKWWZKbjBPaVdHTFVhWnBKY2Npb3hubXE0SG5uM1RadlRZeXd5OTJy?=
 =?utf-8?B?am5EUmVjVkdYanMySUpRWW9RbHRLdVBocjZFTFZicWROaXpmQU9WaGZHazdQ?=
 =?utf-8?B?TGxJY3dGcnR0TERMRXlJd0o5Sm5kS3hzcTRRT1VqMHhNWDAwZ3Vab2RieWZa?=
 =?utf-8?B?NmVUbHVaY3FKVEhhZmZCZ3VieFQ5YmpRT0J2K2dvRTgrcU1BRVVvSzVOQlY5?=
 =?utf-8?B?R0VHdUJHL2lTMTR4d1RGaStQb0JkM2RZcWJiYTdrZGlHUFVqRU9UMFVFSWNT?=
 =?utf-8?B?c2ZEUWpzNHJRcmZxWE9MU3pjUjc0M0FvZnR1NFRwZzdEcWlPRE9XQ0RGSG03?=
 =?utf-8?B?bTNWNnpOb1BmTlZ3elhQdy9MYXhzZ0dUaVo0YWFiMGpaNzZka2RMMDVSQzJz?=
 =?utf-8?B?WVF1Z2x4LzBHaHpJckc3OGtPT2NLMUZXc21ibHhzRXRQVzlCVEFKaEY3Qkxr?=
 =?utf-8?B?YlRVc0RFZ0RxM0RkaGVBRGsyMWx2L2ZjV3Y2bytVbVMzckVjRk9sRHZhT2xF?=
 =?utf-8?B?VkpTQ094Um9YOE5ONzl2dFE0Y2M3Z2lyODREUGVQWGIvd1hxNUtUKy9aV0JI?=
 =?utf-8?B?UGw4L2VxRjQzOUU5OUZLTkdXQ0Z5ZUkycXFOaklhSndBZTVIamxJcFFIRnN0?=
 =?utf-8?B?M1UrWU5mS1JQWE1Xc0hQM0VNY3o1UEFVWnJodEZQdUxWdXFBeUowcTd2T01K?=
 =?utf-8?B?NEY1SHkxMnVna3V3ZTMwSDlTY0FjWTVpSERJLzFtM24rV2RxcDFzejI0OXAr?=
 =?utf-8?B?MTR1TDBncm94RVAyMDE3MFd2c1gzR0owY3dXL0F0cTA0UkluMmltai9HTXMw?=
 =?utf-8?B?Nlk5cnRCY3BaVDY1dkdxRjFOeS9vbWw5N1QwVTYyQVBUS0VZbWgwVFluMVQr?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Q9A/fBIPMZ0NGUMmWZe2Y73bXhrTuXaZ/XMVbjUKLByPXxQNKqa/GBLruF7Sk6sPMzz+fz/NsEYFEiQwCjhKFRsQjYSDftl3rsjA97YSkE5kYyeJlChBicSKmVrd/Xi78Ganfu2idXYdoDSrZSVprvc6Od3H89f6j/+s22d1Jyh3MkOIHhysL2/10PSG6zaYygQ49XhvfgUpLhoOG56UBFTi3huD1gbdhMHDYHLp1yECDrVb2HWJdkgOhzKn/nOHOESQp3Xo+HBhH0sX7jLy3epe0JYVZWjuSaRDIoS0clnYDB2t38b44wCBbmDPp2xI8wuVB2/bfz4L7ETltdXGYbosE1s8U519Iztvs2acRjSGdBtBNuQBLTe3r5dUOK96uH1rFvTxwXmGVkjZla/5JUDz7bAwcbBj1W3PZytwOW/9gm3qQIqTBMPPkHXibdp+7k2mljxRvnksgCrQllkTaCvTr91W7+7C0eZqsMcYRTYRMoSnO8UmaU2uAdl5NJFTY4OL/hOQX3fiqK+sBqYqBOBN/iH35QvOY+bkl9kuiLEuTw+kJWUGP/uGtuA4rI5UdcUFOqoLCJ9o9zhnpVY3wpFzh+TaUHlHVYcOBYXZZxcf+WYWEJl3Ah40v1H9CNedHFjsycwA8fUTbgrcpgxAXzaZXMM67qTFj66HD8ueq0hX2B4eZXsYI1VvAI4CoRsfG20ErS/9+Q6kY2JIBDfed31oIVEGEL6WjroqIyDrKGnT1YhywEXod9aD6aw2+f5go8FAdWtCCPgoQvun4S0Iv6Sxah6g29e4ZvCLdP2XcF1hqox/dwWg59g0ajWG1IlzWaKeDB7SSlHIJUs0qJvXpe0oSRysT2rfRqYKmwAKDWJouEOmOwKyN1k+/BX2ZKPjtYskDyy3ZFji2c9vE0Taqw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b5f996-3a80-45d3-65ec-08db814bdbfe
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 13:45:01.8641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vFOu+V6AmZYjmYW9guHEr00xMSCzyUPf/OTnlZ1/w/xy87a3i0K6+jqouiyg/mHX2Q2Ys3eaH2T4vGl8vJIP9mpb09Bji6D05IUCgLw2kM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5160
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100124
X-Proofpoint-GUID: QLqfrWfFisV4eE90xxRobxl8FDpJSb6O
X-Proofpoint-ORIG-GUID: QLqfrWfFisV4eE90xxRobxl8FDpJSb6O
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



On 09/07/2023 16:17, Avihai Horon wrote:
> 
> On 23/06/2023 0:48, Joao Martins wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> From: Avihai Horon <avihaih@nvidia.com>
>>
>> Implement get_attr() method and use the address width property to report
>> the IOMMU_ATTR_MAX_IOVA attribute.
> 
> Nit: get_attr() method was already implemented in patch #6.
> Maybe just "Use address width property to report IOMMU_ATTR_MAX_IOVA attribute"?
> 
Yeap, makes sense.

> Thanks.
> 
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   hw/i386/intel_iommu.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index ed2a46e008df..989993e303a6 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -3876,6 +3876,13 @@ static int vtd_iommu_get_attr(IOMMUMemoryRegion *iommu_mr,
>>           *enabled = s->dma_translation;
>>           break;
>>       }
>> +    case IOMMU_ATTR_MAX_IOVA:
>> +    {
>> +        hwaddr *max_iova = (hwaddr *)(uintptr_t) data;
>> +
>> +        *max_iova = MAKE_64BIT_MASK(0, s->aw_bits);;
>> +        break;
>> +    }
>>       default:
>>           ret = -EINVAL;
>>           break;
>> -- 
>> 2.17.2
>>

