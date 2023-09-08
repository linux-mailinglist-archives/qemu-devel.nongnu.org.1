Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 198EB7986D8
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 14:10:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeaIg-0000Rn-PF; Fri, 08 Sep 2023 08:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qeaIN-0000RA-L6
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:09:09 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qeaIK-00029C-PA
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:09:07 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 388BxvIV007642; Fri, 8 Sep 2023 12:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ymQMZl/oCxPol+p/IaqfkBg74UfJMT3xPYeIhUTuSBA=;
 b=Ptb4d4VN9dmZGojQ2qwtQbp+LFuuisFMA61qK6lpoUYbB8+vGiqlSPKD61U7UfTiJTug
 F5AeA/3bOJg7Fc2eKznVx5bWQrik1oPgVKKtHvakJDAm02mrtZsROjC7x2LLAIDB2J88
 unAKA6ZclLC79IsIPmupaC4l0YTEDX9Bilp66Xa0L5jzxH7hDVDJaSJmndU8dv6qYyGK
 45YZBHLraaLpvuLjD93xm1+DM50zRI6fI51y6GoIkFuBC25a6As6tA3j+XWrEHP3KKc8
 2Jog0nyo4Ow0hfpFff+kjO60wv+NL72xDFD5ynxFzuO7z0l3P5jAAG9b7EMTjc8TGXVI gw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t037f80yr-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Sep 2023 12:08:52 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 388ALcN0030461; Fri, 8 Sep 2023 11:54:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3syfy19uex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Sep 2023 11:54:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahfrEyTMSGohFph4H0jIGfED3ezGYYFpVR8FSfLbyIEC+EzYGyeEc6b9hqR1wIWMwM2MF9esNsOs+KsG2MwnA6T7lcOSDNXBPjZyoI+Ty7suIdarEbmiPSHUUi5lJzsD3Q+uDCPxmCqEPNw6/sAbGYQ5CnUz5LuoN3ngS9eP2i2t+BcoJTx0mGE9wuVykJXywwIQJFBCta9Ib4zpa6LMNDolhcVtkW7HMqi6XYHRdi0MkYXgzSd8MynybnhKiwPLxqqpPiV7ej0CP9z5Yq0sQjV00OmBu7f95K4kbenUxXSuOvBT6nQAANaSBNoMITpoASGstD9jk8A9FsZWzuZc7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymQMZl/oCxPol+p/IaqfkBg74UfJMT3xPYeIhUTuSBA=;
 b=Aod9NqdosNPlmpQ1rnnh4YvQ4t4bWwr3QH+NlspDc1KZS6GI7/778LaIlHYQetFaHG9n0VTMR/3wKmEo+8u8/vp4kRDqbU47XqL8BVLAyPTCE+RQAPPEyjtGHIhJ9PXxIWQxji1CRDMXoxJSxpof8FXb6frdjPb+CCu7JtQfCJ9D/8n6AKqpQy1qUAEZNF5jQ3OdgrLkyz/QDASh6EQ6F2uNHsak1KhCSzeaRAOjjdSRrg0MVHuXBgJN8kGGPmk4l8Mr+J1jNanHedIiy7RZQGNokAXZ3w3OoXkXes/IIxQJPtMF784IjmE9kAMqpTe0FJAmbDf8yO3AMgoLxMFBLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymQMZl/oCxPol+p/IaqfkBg74UfJMT3xPYeIhUTuSBA=;
 b=ztB9kqlptF1eWu1Srk9jweNuog9gDhVM0C8ENSxQEkbkJOZQmQxrdiKBZmSMUgmubX7PTR9rArqNDEqaAaia6zqPhjiIcPCM1ldW7M6JIJSseltuUaSf5REUZjWS2iNw5ZKknRet5cJ0/Nkb1psI+F1pvS4B9zeTtlp4si8A1vE=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by LV3PR10MB7865.namprd10.prod.outlook.com (2603:10b6:408:1b8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 11:54:11 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 11:54:11 +0000
Message-ID: <4c066354-7cc4-1932-2ef5-e83ec37599f2@oracle.com>
Date: Fri, 8 Sep 2023 12:54:05 +0100
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
 <5a849c31-ae80-854c-03af-8fe87ba343c9@oracle.com>
 <eda120ee-cfb7-3e25-acb3-44d4a6bdbcc1@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <eda120ee-cfb7-3e25-acb3-44d4a6bdbcc1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0359.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::22) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|LV3PR10MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: d13a61a3-43dc-4dfd-3ac1-08dbb06250e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VCelmaeOv37dPbwVeH8k3Wbq0h9JyW3ty4P+Cr1JA/MvFh3tXgTouIciTjnsBhZ0JgoYODzJjMtI4aNJKTlqd73WyLf30zAC5Rj+JS3qrsVCF2wOhi6PJVxO4UyggAPQ8/NmEk9efzd8KFw7ZKxG68SOktro5b6ANXXMQkLkmdAH8GIOUkM9JNUL45MhFWswxLybjDwvjNgfLk35O8VW/cVAzXrVCKy1OBhNw9a2TsZwFAEm1YqYE+rr1ApB2EDdLKqJKP+ZqQGEekeKDVXUaMI2lfCqewgFCmr90ZUxKMIOZKpvTejpCvaZr2sfsmrWowZymqBSV+a8oYXQnxl0NqQkPVtjUF3SDT4V/7nKo2/yyk7CtjsP/TwwhmX3/hwAu7UX9bQ4hXQ9QdoEh0vrqogKtMwDNh950/Ccq36lWPIVqfIl179kyF1LagZzM/0YzW4GJFS/UBL6Sl4mTN3iIyPjEsVub/VaWA857y2fS+Cf3by+l8XK6xxu27fbHovqU477Ccnp0zlKLoD4/Ya9dNFycOawtoDJb9m8y9zDyhYUPZ7Kr+4X9Dt3BoPOzzvnYED0ww3QcS6aPx3avh5SHkR2Y6KPOWNm9qVQsOkqAQmaB2o1MJq2GeD0ljPoCmNHopzQVLiG8MCnB+kOz6JGsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39860400002)(136003)(366004)(376002)(1800799009)(451199024)(186009)(66946007)(66556008)(66476007)(26005)(31686004)(5660300002)(316002)(53546011)(54906003)(6512007)(41300700001)(2616005)(8936002)(4326008)(8676002)(478600001)(83380400001)(6666004)(6486002)(6506007)(7416002)(2906002)(86362001)(31696002)(36756003)(38100700002)(14143004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXFDWUtFaHNQOW9iM3F0bmdraE5hVElVTjlpNmpiQ0llRFQ2bk81NzVnRHJX?=
 =?utf-8?B?NzBCNFN1Tll4eWFQTVh1QUlHKzdUWHZ4WkgyUzZRVHhROUVTZU5kdE9vRWY4?=
 =?utf-8?B?N0xkbnFDeUNSbE1QZ0NZRHJqYi96YkxjeGk0dGVhUmQwVkx0V09GU1o5aTZu?=
 =?utf-8?B?NXZFSXR4TTJRelpFc1FUU05aY3pHMEtiZmd4ZnBPLytkNE1XaTJFcWU0Wklh?=
 =?utf-8?B?RmVrRXlqR0N2SlVBMW5kc3hhSE91bStFWktCUGRJYzc2dUxGSFk2MWErYVow?=
 =?utf-8?B?RldSNjV4dGhvSVhHSEdHWGtxYm5sN1ZyTjY4RExOQW9wK3BVbmxIcWVkSDkw?=
 =?utf-8?B?dWZhRVJEOSs1SVhCdUZJTHJEWU1KQWNPL1Yydk9CL3FOUVcyQ3VTYVRuUkhJ?=
 =?utf-8?B?UE1lazVDM1R1U3J3SnlucWhmN3VSNGhNU1ZaR2drMkRxVGlOV05qMERTVHU0?=
 =?utf-8?B?K3JXeENWb09pWWpYRGR1MjBzOFA4dlQ1V1ltK2RxbVRtWVpPZWRKZDdTSHBh?=
 =?utf-8?B?YWdiNnFQYkdFK3lJak16NGhvMXhmUEJHZWljQWxQOUlZUXdGdGxkRWhmR0tI?=
 =?utf-8?B?ZTgydDd3WkdQaHYxRzIvVVgrdUlnekhLaXJxVERkR0tVMFBxV1JtN210dlBF?=
 =?utf-8?B?NWZ4QnVkZmNMaHE3OWlwcDBoYVZQUERmZFpISHY2bGhKcmFIZ01vTlJSbkZz?=
 =?utf-8?B?OTh5bVJIWVJRVTBJVm50R29lZjR1Z1ZDeGxpdnFaUEc5K2FWaUpMbWZXckJ2?=
 =?utf-8?B?QytML0Z1U21wZE5TcXVRcFNndEJWSW8vSGQwcHVTYm1OeVE2TUF5TmpRWktk?=
 =?utf-8?B?N1d5TXFLNXl0WmVMVkJ3REhVMHY3ejlSRHJXYktsSVU3UFdvYStkV0FQM3Fp?=
 =?utf-8?B?K2Z1WDluWTFIdkVqU0R3WU82VmhvaUZIaDU2VkhSWWVhdUdhUVlvdkY0NTJj?=
 =?utf-8?B?dGFDakRmQmNrZk5YaE9zZjhCOFlBZzB6cjZ0bS85RnV5b1EzZ2lERUM0QUVD?=
 =?utf-8?B?a2dxeWh6dHY5Z1VSUm1oc0VhdmZnYm9yNG4xaTFDWnh2ZUx3Z0xURGpRWlcw?=
 =?utf-8?B?VTk3eENNTWhoVFgvQ0RsWHYvbUg2SmVCd0ZmY1MyOUMyV1lBdXl4UEJITWl0?=
 =?utf-8?B?cVhEUVR6TXpkbkxDSXVHMkJValZIUEYzUndiSVI0V1pBRTVwWDFnejNnK2Fz?=
 =?utf-8?B?emo3TnpZUWJ2cVpuN3gwdHF5Y253UWhWWm5sbXZXc3hFQTlKY1JMK0FtMHY1?=
 =?utf-8?B?UnNPUW5pRzRjT283dUJLaW1hTWpTeVliaHo5Sm00Qjh2bHBhSjN0UWhXeEtX?=
 =?utf-8?B?cjFsM1JIN2I0R2svUkYweUNVVmVzMjdjUms5bEoyUjZjbEJid2N1clRBQ0to?=
 =?utf-8?B?bzFyc2lFUnFGMWZwWXRDV3lZbnAzM2NiSEJFNUZxVjJOdGVGSU9jQjhkdUp0?=
 =?utf-8?B?d1A1R29mQkhyQTBhamU2dElQMGZweWt1ZmJFOEw3YVIyZURCczRzeGVwSnpj?=
 =?utf-8?B?UnpleGRFRE5hVkV2eTdDSUNnTGwvR3kveDA4YXA2bDBjcytZQU9Ma1AzRHlp?=
 =?utf-8?B?MzJNU0M3cjhkWm5FM1M4ZWd6NkFIZGtsQ0FNK0ZhZVp3SHl1M1ROZHY2SHdI?=
 =?utf-8?B?ZUJFbVc3L0dyUlZRT0ZodTA3cWFTb1hjZnYwb0tJL3Y4UEFUUVVQY0ZtaXZr?=
 =?utf-8?B?R3RCTlVxc2swOHhMVjVld2RJLzlxVjBVUUhYOVRhejNNRHNueHJGTzU5cHQ3?=
 =?utf-8?B?UzRRb0hxOGJ1dXEzWlRBQ3ZYdDE1WisvSThLbWc5L1hEdGlnTXg4YmdiQlpw?=
 =?utf-8?B?TnFXTHFDR0dIdllRTFFpYUI5ak9sQXNMMWxrVXZyVkNCZWkzRTlXMVMydW5Q?=
 =?utf-8?B?OXRKMlRSZk1qRW9DQU9rOHYyc2xOcEZXZjREZEh3OWFXMzU4SVpQdldaOGtO?=
 =?utf-8?B?QkhCa3hHQkRvbCtnaEtPTDlHMEZMMEN3aDZUWUE2YmNQU2toYmlEMStCdEhE?=
 =?utf-8?B?YTdQU0V1Zi9iRHVwU3FlWW1XMHNEWVg2RExHb0tGZGo2YVJvL1RTWFRoaGVo?=
 =?utf-8?B?YjBQQkdNNVp0dFdpd3VLRTdHazZacGNiT3pZcHEyRXR1KzUyczJLakhhNmEx?=
 =?utf-8?B?VUlXVjZ4WGFEZlo1dU5rV0pkNm1laWxFUmpsZjZqYWdVZFRWU2JQSE9ocExG?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: neMg2jf67YzsV0edXhETm/xIrzwekFILDZoTz2lsJ6XEn1/4qMm1j91QlCLisLXqsaVjiF+xhNSCFthIF3Eetv1rSkZN0CaOB2G5K8ePx5qZlBQYC4OzDWYHbmIRFt2bcpfTJlsD/yW+GalkYW2f+EVgReVzJJ/qI3LMjgnQOjGixR93OLhkB9zk1VdzMGKloC0wIdSgPT88DyHfsIxOwMdFWiC1vP+sS0wtr0lv3qP7DXh7fLJlhmHceX5cMJTbqz6InGVvIF5HZOzKd3CjSuLbYxrlLgUuoxhYbrWHbUpggihgOn13OqN/wNVuBNH/+IkPDl3zTT+LYjDQBQEOjqut9o/Dlg+OViaHkTyEOhfoO77JaNPfn8ngVYuwKls74VnKtQL6A/IuntW+8uI02V4fieRW+1TYLiy133xfchUMlLwk6iuFUugb2xuvA0/tRyiM2fLM5s5E43l8zSzuKyF1GgVunMiLyEX9a8zpn/ZGzD1bqboGsW5pLl6ZHETOU5sn6jPGPajl2vLfrLKVPuFaA2sBTsZYosDTjlAh+cnfJyn8FUI4wV+BNKBhfHDHyXAzg9PpxRwXR6HU+rKK+TewTpTO9TLp9aBDw4+4xkTeFOnBIKerTokAA3EP+kUTKUfakH6JWsmHncHnohsYfIfBM5jJqYKFO/UrHG/jGocRRBGXeDEJmb/LAcxdfLgNQHJVekYKxK/Qi6VJ4fnAv8TeXIp5FJAf3SPhr3WEHH+HIisP5danG344tanbDp009H5xxWHlCDZWqBqRh/gs1U+2pfIcQO+TqKh2+XTHaiD8S5Fw2VsroLt5pEVet334xvd2ivXSqFce8U2nPcCLJ5SbJoftCX4qiNGDXKbaocCp0S+ggi5wT0KrKLfNl87DgaXfGS76NGurV85e8+0PsXAxIsAYXkrQ6gpqqTgBoUs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13a61a3-43dc-4dfd-3ac1-08dbb06250e1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 11:54:11.5012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZMDRXsYZ4N5jgmfuBYvKynRFwY42tg+7I8fqFD3mp6i58MA5w96vUalLAkGKdXP4sw3r4KF6BR8NJ699FJe4yS+SCyUKRgxajEI8w+11pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7865
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_09,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080110
X-Proofpoint-GUID: NzCg43BDvYuH4B5UsotjVxt0kvxRyKJ4
X-Proofpoint-ORIG-GUID: NzCg43BDvYuH4B5UsotjVxt0kvxRyKJ4
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

On 08/09/2023 12:52, Duan, Zhenzhong wrote:
> On 9/8/2023 6:11 PM, Joao Martins wrote:
>> On 08/09/2023 07:11, Duan, Zhenzhong wrote:
>>> Hi Joao,
>>>
>>> On 6/23/2023 5:48 AM, Joao Martins wrote:
>>>> Currently, device dirty page tracking with vIOMMU is not supported,
>>>> and a blocker is added and the migration is prevented.
>>>>
>>>> When vIOMMU is used, IOVA ranges are DMA mapped/unmapped on the fly as
>>>> requesting by the vIOMMU. These IOVA ranges can potentially be mapped
>>>> anywhere in the vIOMMU IOVA space as advertised by the VMM.
>>>>
>>>> To support device dirty tracking when vIOMMU enabled instead create the
>>>> dirty ranges based on the vIOMMU provided limits, which leads to the
>>>> tracking of the whole IOVA space regardless of what devices use.
>>>>
>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> ---
>>>>    include/hw/vfio/vfio-common.h |  1 +
>>>>    hw/vfio/common.c              | 58 +++++++++++++++++++++++++++++------
>>>>    hw/vfio/pci.c                 |  7 +++++
>>>>    3 files changed, 56 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>>> index f41860988d6b..c4bafad084b4 100644
>>>> --- a/include/hw/vfio/vfio-common.h
>>>> +++ b/include/hw/vfio/vfio-common.h
>>>> @@ -71,6 +71,7 @@ typedef struct VFIOMigration {
>>>>    typedef struct VFIOAddressSpace {
>>>>        AddressSpace *as;
>>>>        bool no_dma_translation;
>>>> +    hwaddr max_iova;
>>>>        QLIST_HEAD(, VFIOContainer) containers;
>>>>        QLIST_ENTRY(VFIOAddressSpace) list;
>>>>    } VFIOAddressSpace;
>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>>> index ecfb9afb3fb6..85fddef24026 100644
>>>> --- a/hw/vfio/common.c
>>>> +++ b/hw/vfio/common.c
>>>> @@ -428,6 +428,25 @@ static bool vfio_viommu_preset(void)
>>>>        return false;
>>>>    }
>>>>    +static int vfio_viommu_get_max_iova(hwaddr *max_iova)
>>>> +{
>>>> +    VFIOAddressSpace *space;
>>>> +
>>>> +    *max_iova = 0;
>>>> +
>>>> +    QLIST_FOREACH(space, &vfio_address_spaces, list) {
>>>> +        if (space->as == &address_space_memory) {
>>>> +            continue;
>>>> +        }
>>> Just curious why address_space_memory is bypassed?
>>>
>> But address_space_memory part is done by memory listeners
> 
> Only this part. Still think about the case with two vfio devices, one bypass
> iommu, the other not.
> 
> The device bypassing iommu will get address_space_memory, the other get iommu
> 
> address space. vfio_viommu_preset() return true for any device, so we never run
> into
> 
> memory listener even for device bypassing iommu?

Yeap, that's correct. When I said earlier 'reworking this' I meant this part
exactly to do both.

