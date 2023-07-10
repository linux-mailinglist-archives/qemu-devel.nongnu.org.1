Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE2D74D824
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 15:50:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIrH0-0004n8-Kj; Mon, 10 Jul 2023 09:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qIrGx-0004j0-DM
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:49:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qIrGp-0004nx-Ts
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:49:45 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36ADMMUf002907; Mon, 10 Jul 2023 13:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=olKSXbONIf6pgzlSRl44DaNwzEyWlfplOs3fyLx82mA=;
 b=c80Z9Vwp/Uo13Uulqkufrt0vNFOmC3G7bjkqbgdD5KTMgKod4yUvflPSfMv+y7Vk7tHk
 ZB3S7hYYD77+bmPW32Cq8WvOw6vu6Fe7CqFxHdPhQEtGEHrSMCbgPsWrda7lnzRSjgLo
 ISxZtY0amWOr7f0L8FkZOJeCrV+qk3RDmCRTNXtqMhngi8/Z4mJGf0wvR1P1FukOfjuN
 XZYjY+tVM49QUYE/6NhKBYQosEeJ90pdYHeKv/QvzpHva58HtheyAEdD9ibWiPd5Z43G
 88tAL4a+BgSEYZPEchKCYy5MMVoXjk9ye3VbYg74/tz5Dao6VmxmPDG64Cgz0eiuj5rF zw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rr8xugya2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Jul 2023 13:49:41 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36AC7INd008876; Mon, 10 Jul 2023 13:49:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rpx83g45x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Jul 2023 13:49:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmp9zvGuG3rGibXa/zhu5g4AX9kDExKLnsa4+XzdY4CvgzKyKP9wRIkfFTieyIMYv8DvURy6SG8q6Pc75hwLtT2slpZBekVIoqRrqLIEKsBLi7qO3KOaq9OfRxp1KzXsnuEi3C+tChUFpHzgAo7jmfaKosJ2e4j00fA5TITvOQNxNx3Jwz6xzxfOyAhcx7K9MJcu50OLmDRzCrzACJ0r1D3fCH2Lsap88HIduO/Si7nXriOt/kHRISw6J0mZ3oMP/dbDpsbFGYVg648xbrchzDegKQ1JHIDA31GGiLnGvHfgh/S4XpFsr1Nupf17K531Vfg8E2sf6M7Pghdt48HE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olKSXbONIf6pgzlSRl44DaNwzEyWlfplOs3fyLx82mA=;
 b=FjfSrIIJs0CwM+UzqaoY4Svh8741clvPd9Qrqy2Dz4XrWY161u0mFbZcAuH+Ao/nqxCkArNvxeyOdky+OBTe5as9vbMZwyziJb0i4yJjO/0blnvvCgr5DGAdGXp4+OuiO7k3+N+cHoMmuIY7xcQs0CJ3FEEYmmTDtC9kO4gapd/K3KO2LJVZbiNLazRFzOljc6H14MCHgDGxrGNlQavg5uRiiCKQ++Q/lao0pOmr9ZOuCX/q8/HuLQP2Ut9nifE3m5SZA0sIzfqu1dCrHDq+OEKUA+9+DS65kZ2OvPgYt0kjUZ/5juBHp9dWUcaxN11Zok1+VUG/om0/+dcbX6E56A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olKSXbONIf6pgzlSRl44DaNwzEyWlfplOs3fyLx82mA=;
 b=M2tHsT0hA3aHwW9dX/QPGDl8RXScfMmZcxLjp2OK0goNCpKjBstWFeyF4j2wuMFuc5q0ZlDUcDu5yKYRrTD1Grl9WK1RcL2i5g/WlIGVTra8YvGjoyWLxzK7rnbKoQnPDIoaYLojGLskp8B5KLT2FXWv04piBe2RS/wt7QswH+I=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by CH0PR10MB4985.namprd10.prod.outlook.com (2603:10b6:610:de::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 13:49:37 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::6db1:c2a8:9ec4:4bbf]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::6db1:c2a8:9ec4:4bbf%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 13:49:37 +0000
Message-ID: <743c8d19-2e74-0542-d39c-df75a2ebb4f3@oracle.com>
Date: Mon, 10 Jul 2023 14:49:29 +0100
Subject: Re: [PATCH v4 12/15] vfio/common: Support device dirty page tracking
 with vIOMMU
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
 <20230622214845.3980-13-joao.m.martins@oracle.com>
 <3dd304a7-3ec2-9e6d-1916-adfbb0c417b6@nvidia.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <3dd304a7-3ec2-9e6d-1916-adfbb0c417b6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0141.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::46) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|CH0PR10MB4985:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e8bb5e7-51d2-4807-0471-08db814c8066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tyhDsvJF0a4he7QXwr6Xe1GjvwFnOcHLmKPLX4pa0GHRv89w7ewiPxLqSv4qLljYyCl2uTljYKD/48W8oBLCyCzwoZtdCiVThjn2D0jqQ9t+sY9ibR/4C3RDba6f/4XQAU/2dlyKsiLrn7nV8mTOubD54A7I1r7gl/pDEQOuEg0UpZ1FPBmvuwCE4xVKlY3Ddz5SBzm2LdH61gQnqZtODxW2BCnIrRZs66TRlOfBb7jrQ5gBifw2wn+MFRC+RDJV/7Du5sJ60OswNrFOh1Jg24WwNpGwCshaaaAzU+JEBtBspsGKHAUrXetEmnEQU5wOvBoc8rhpOm+gBNwIwCrS5j8trsmy1mtu4vl/3PhPeK/ZuQG0AVKkpp4bM7JZF7sFOMAtSIOVIbPKqMUBKrRveDK5HI/moCf1cLp8eBvRl72PsGQqBstZsS3ORXbsZl0dMOAH+BlY6XEutzcO+Xmkeobwg6jV8r9hadx5L7VTRdYCnPRHFMcT21SSIBxnQpGJbcAqdZ8CJQhXg3IB62zZ00ZwDiWcTTCbZQcrMfA4BNdwRwWs4moX5Z+7eOCg+F8FBMe0J1ZD8w5jXrzmiAQkq8OtQ1VJ1PbHJnovMXDB9Gy9DADqdLNtyt4k1GTlAMpvwM+a4og4or9DckxrmhVvng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199021)(31686004)(6486002)(478600001)(6666004)(54906003)(83380400001)(36756003)(31696002)(86362001)(2616005)(2906002)(66946007)(26005)(53546011)(6506007)(186003)(6512007)(38100700002)(8676002)(4326008)(5660300002)(316002)(66556008)(66476007)(41300700001)(8936002)(7416002)(14143004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N081cHkrTUFhdHY1MkhKSlpIQnZqaXpQeVpZMTlmV3EySnUzMmdkb3dNa0FK?=
 =?utf-8?B?c0RSZjF0OFpsQ2gxY3RwcEZZSlNDUnV5cG5HSFRCNlRWOEdLc0VDUi9TcjNn?=
 =?utf-8?B?dE1ZZ05XV1NRYmdqNDRwNUNxZ3NBVWtmZWNuMlpnOVFJVVp5QXFLdjY5VVJC?=
 =?utf-8?B?eWswS2RneG5MTktwd3Z6NGpvT2E3L0h6NjlJZjd6OHVWOXpBYU8vcEd0RTBZ?=
 =?utf-8?B?U0swSjdBampBMDh4THlhbjdtanhaVmhMMFJENlo3dS8wWU8wN09xaFhlTnF6?=
 =?utf-8?B?RUliQTNGQ3VDSjJoamFuY1V2d1ZCck5KOGVFVis4VXo1NGlYMlRJU2MvS3Ix?=
 =?utf-8?B?aWhZeDB2ZHJ5eU9Zdjd2OE9wS1VLQ1kwcHNESzlzdi9Ia01iT1R3SkNHU2xT?=
 =?utf-8?B?b1hSNHJnRzdheDBIMkl4VldnenUwYWRHeXRIQWcxbnh6VmVxODcvOFA4RVUr?=
 =?utf-8?B?ejlRQ2dNUGx0TEtDcms4TERlQmE1bnduYWhjajVDbGRrU0g0STZPTjVCL3py?=
 =?utf-8?B?aHVpTlQ2UTRNUWJoZDVFSzZWZUNZRHBMYjRUTTF3QkdySW5ic28rNkxTMHJ3?=
 =?utf-8?B?STVTazlDVWJFSUNFcHNLZkpUbWgwckM1bzdzQXZFL2Z0SGRpcHdnUlpHUkFK?=
 =?utf-8?B?cnJNSlNZeWUzWEJyZ1J1aWg0TlNFMXNtZmxxd2JpbDVwUFc2NlUralNiYk1R?=
 =?utf-8?B?bmtubGpubUZwOUVOK1pFUGZkNmcxT2g4MnpOb1FWeWhQRWlZWFRNWi9lM2Zx?=
 =?utf-8?B?ZGRjMTV0YUpobllqS1ZZNnprWkJoWkJVZlVUbithRTJ4NmZOUk4ycVJhdEhX?=
 =?utf-8?B?TFMxMkhqaHdaVDZSSFpIUnNkYXlxUzR2K2lwL0Rvc2V1eEQ0dHdGamRkdEFq?=
 =?utf-8?B?SzV4ZnhkamxETXZ4ZExkREFIWWovNHI2MEJzQzBranRSQk8xcUlmWjZudDIz?=
 =?utf-8?B?V1VuSHJwK2h6eXpVZWdSdjB1cUJ4NkpyekVXU0xJOVVoMllZV3E2cE9BZ2Vx?=
 =?utf-8?B?L1QzL1RUdHM5WTVIaTEyR3FnN1VxMFNBVkdSdkdLeUt5bFBQb0F5d2REY2FS?=
 =?utf-8?B?OGI1cEFmZHFvSkZDNzU4VlJ6QkdKZnd1RHNJRElXaEJkd1VvYzVOWUR5R1Qw?=
 =?utf-8?B?bmdQOUtUSlU4ZG1YOGtwWkEyKzZ5cTFXcTBheVpBdVpsZ1BQNC85UTE1RjRL?=
 =?utf-8?B?OFlUSDA0OEd3K1BOUmVVaUNpbVFkNENycVQvTWlSNkUrNUFCSGQ3K0laTFgw?=
 =?utf-8?B?a3VLV3ZGU29HY3NScTJFTG0wNytjdEI1WG54cjNZWG9pTkVESmxVZzU1emdv?=
 =?utf-8?B?UjFPV2NiNlYyNXluR1FoMGtpMlRReGdVTmI4bE1ZOGpwWGRvQ0tVMnFFM2p2?=
 =?utf-8?B?cjVlb3VwL3dFeWYzV3gwTExqanlST0JFbmZEQ0I1V2g2c21vWjFaZmQvdm1h?=
 =?utf-8?B?eHhPbVpBRmozak1kejhrcFJhVG5ta1FYWm13b0F5RlFxZWJyQTkySlV5TTNk?=
 =?utf-8?B?c1FtaTl3WWI2TGJGeGJTYVUveGttNnpJamI3cnZYb2dOU3F1WTZGUGxWeFVF?=
 =?utf-8?B?QmUyZU54UEN2ODE5VGRUWVN2cDBuOW44aVZ5V0dXVUthaDl5VWpJczZpdUFK?=
 =?utf-8?B?T2FHVHNZY3E2RnNnMWhGS1FRd29HcUhzRk1MR0tBRGkvaUtJTGRTakZEenhD?=
 =?utf-8?B?OUg1YjNtbi9PZEF3eWI3elFmSEI2TnF1d21FNlg0aFlBSjhYb0hpTE9Manpy?=
 =?utf-8?B?Qm53ejJVM2cwV0JYOW5aWkc4MWpEbXREUWVXNjZUaWxSc3ZnRkxRNDFtbkFE?=
 =?utf-8?B?anlyeSszbGF2S0UwL040UnRCVDRVZkw1VzhJYWowNzFoVW0rTUQyVHZ5MXZo?=
 =?utf-8?B?dTNvR003K1UxZnFHaWVVR3hDd1N1SUZmaERwZVBEMkU5QXRvbklxSkJWeGlq?=
 =?utf-8?B?dVd0T2t2ZDVnUm9GVkZpVlBVckZsYWJEaEdpcmw5eEZWU0g5dTlNU2pKNXNv?=
 =?utf-8?B?c2ZNL1JIei8zY2RkbFRaaE92bzVhSG9kZWlsazdmeFU2RERMTXllT2ZvZC83?=
 =?utf-8?B?T25NTHhwc2JmdjJGd0k1bW1RRzlhbVphZm96SjdGd2dnMVR1M2JKZVFTL2xO?=
 =?utf-8?B?V3NQN3ZYU2xiRkpkbXhmOSs4V2lZL3Z6N3dXOWwyaEpRU3lLVUFVOVZsVito?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DTl8HElh5iCxlph0RsWuTb3jV3oHUMrl2myktBwjgTAbEmRdivWJbK9zqwZaJQv0sxfpdvJgk8OGL1iBIRtXs3eWmx1UPe7GB9psoC7KxdVDfs5bHjVPeolH8XO9rU3tUPlLOKbQchGB/tSYTTzhL8jBMWmNgD0aOOnL9Rji1I+aVtm6EswzmH9Kr/brZ9s8zFyHChmK9oIdMREtByIp5V4RgfEciW/Mf2cE/ytNyUYqT0uiGpKue8LM5LzxEnrVG65wMQh9kOAWfDmC+Wx8QYrum5AyFUM0I9dn/hv2YEtbmJCIEKc9sUub8mTdcnAiMbvbviTyqiLOwak8DXbFPwKzFGiOosm8tZf4zprTdHUoDGBf5lhlKxEZEHeQ+TWcVqoKlWvN2Fx7CL1StAxIURof2bBOWPbboXnCYfupPM6WYJDhoedSbit14XIFNONOaEeCiwEeWG8tysIMvfWj1QqaV9s97uQRjSg0ZmQmSNJAOaEk5wwxs7yNokRa9gFT+Sg7W2AUA1Oktm/yhFyClRGtlLbLfdVmIFvrEWI2OD/JCWKr+DD/oWHIYnRDe/EI854rTzDMo/y5Iyu98HM7GKqECiysIIFUC4Hfhik8/vfWcGwvtaVBA/LnsOyw/JrKs2bQf4eXIuRbL9Dsjk2E3PbcRRZz6nAvVzIVlN4plY0Cyl9gBBhN8rGvjq0PuxW28IHB0ZddJvKDlqkIxBbYbkFLDCZ+WWUum+Its4lZDIVRsDwZAWNwhawmeiwfzc1PMCosT9ETxz7jT5467QqxSwV1uPykqyCfcEoavmbTq1cLS0xalD8Ke2nrYMJz9m8D0WiWvJXOheLAybzaKvNm56mGxsWUDKgli2Iq9sHACh95l29lmv8y+aXxDjYOzSRJOKWJ9xckiJZAL2blmDng+A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8bb5e7-51d2-4807-0471-08db814c8066
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 13:49:37.6704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjEd35FTB1P/umCIgACi/JHQJaxSeCSkCEB+rE5oxZQonQDnmVHgLfwSOWWWUrKtTQ1D08mfonfNpP+mjgDafNkxeORNQuiCiQ6kUvEvTgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4985
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100125
X-Proofpoint-GUID: I_IL8gF05UGBMSQMcJF5jDl1hxy6llvW
X-Proofpoint-ORIG-GUID: I_IL8gF05UGBMSQMcJF5jDl1hxy6llvW
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

On 09/07/2023 16:24, Avihai Horon wrote:
> On 23/06/2023 0:48, Joao Martins wrote:
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
>>
>> +static int vfio_viommu_get_max_iova(hwaddr *max_iova)
>> +{
>> +    VFIOAddressSpace *space;
>> +
>> +    *max_iova = 0;
>> +
>> +    QLIST_FOREACH(space, &vfio_address_spaces, list) {
>> +        if (space->as == &address_space_memory) {
>> +            continue;
>> +        }
>> +
>> +        if (*max_iova < space->max_iova) {
>> +            *max_iova = space->max_iova;
>> +        }
>> +    }
> 
> Looks like max_iova is a per VFIOAddressSpace property, so why do we need to
> iterate over all address spaces?
> 

This was more futureproof-ing when Qemu supports multiple vIOMMU. In theory this
tracks device address space, and if two different devices stand behind different
vIOMMU, then this loop would compute the highest IOVA that we would track by the
host device dirty tracker.

But I realize this might introduce unnecessary complexity, and we should 'obey'
the advertised vIOMMU max_iova for the device. With Zhenzhong blocker cleanup I
can make this just fetch the max_iova in the space and be done with it.

	Joao

> Thanks.
> 
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
>>
>> -static void vfio_dirty_tracking_init(VFIOContainer *container,
>> +static int vfio_dirty_tracking_init(VFIOContainer *container,
>>                                        VFIODirtyRanges *ranges)
>>   {
>>       VFIODirtyRangesListener dirty;
>> +    int ret;
>>
>>       memset(&dirty, 0, sizeof(dirty));
>>       dirty.ranges.min32 = UINT32_MAX;
>> @@ -1475,17 +1495,29 @@ static void vfio_dirty_tracking_init(VFIOContainer
>> *container,
>>       dirty.listener = vfio_dirty_tracking_listener;
>>       dirty.container = container;
>>
>> -    memory_listener_register(&dirty.listener,
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
>>
>>       *ranges = dirty.ranges;
>>
>> -    /*
>> -     * The memory listener is synchronous, and used to calculate the range
>> -     * to dirty tracking. Unregister it after we are done as we are not
>> -     * interested in any follow-up updates.
>> -     */
>> -    memory_listener_unregister(&dirty.listener);
>> +    return 0;
>>   }
>>
>>   static void vfio_devices_dma_logging_stop(VFIOContainer *container)
>> @@ -1590,7 +1622,13 @@ static int vfio_devices_dma_logging_start(VFIOContainer
>> *container)
>>       VFIOGroup *group;
>>       int ret = 0;
>>
>> -    vfio_dirty_tracking_init(container, &ranges);
>> +    ret = vfio_dirty_tracking_init(container, &ranges);
>> +    if (ret) {
>> +        error_report("Failed to init DMA logging ranges, err %d",
>> +                      ret);
>> +        return -EOPNOTSUPP;
>> +    }
>> +
>>       feature = vfio_device_feature_dma_logging_start_create(container,
>>                                                              &ranges);
>>       if (!feature) {
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 8a98e6ffc480..3bda5618c5b5 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2974,6 +2974,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>                                 &dma_translation);
>>       space->no_dma_translation = !dma_translation;
>>
>> +    /*
>> +     * Support for advertised IOMMU address space boundaries is optional.
>> +     * By default, it is not advertised i.e. space::max_iova is 0.
>> +     */
>> +    pci_device_iommu_get_attr(pdev, IOMMU_ATTR_MAX_IOVA,
>> +                              &space->max_iova);
>> +
>>       QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
>>           if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
>>               error_setg(errp, "device is already attached");
>> -- 
>> 2.17.2
>>

