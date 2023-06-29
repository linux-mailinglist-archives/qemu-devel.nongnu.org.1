Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E25774248E
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 12:58:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEpLz-00023m-4C; Thu, 29 Jun 2023 06:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qEpLv-0001vV-3e
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:58:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qEpLs-0000H2-6Z
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:58:18 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35TAohQt006748; Thu, 29 Jun 2023 10:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=soQNUeEb/jhn30LxbS1e56qDKnIrptIZWRCy5AorHhQ=;
 b=s//i7GlZGbmjaUNuTP+36b/K+PHuWWas4lDZMnIA1AvKmoqSkS2nvjJ5NFvhiP7oneGy
 UrZd23Fkj7YD+uQ3dfEV4NCHKpkNZ1PVQS0UdzBd+LF7GZq2mimTuW4uhMQbwE578KHG
 GqlqYfkhcM0vFtgP5aPJLjLXlKNUjlSqV1+5lLtSEUc5/zCtr/xbCKFpj7W2GqDadZVO
 azlGEhDbGYar3faP67YatwdW4miUuTZ9Da1sLdelBdD/CknhNg3ruXToPV8DKB3cvt5b
 LY0IpYH5RRBaR6CpvLrQIVOxdaSZuOBT+wPiZOiLqatUiqhka8UoNNhkClru1/jWIquM 9A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdqdtupv9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jun 2023 10:58:13 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35TArlj7013126; Thu, 29 Jun 2023 10:58:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx7fpgh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jun 2023 10:58:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cv9xU59UFAs0zBwR/cNYTyLrnW/ruyQgCv9K44OWyEwjiCLpY3uUkvuOUjgqRHBYLxxPc9ys23X7Q+u3Cx9VrBCig0A6hkBIKIB0m+8vAKe9Xy4a5mhIzzESClLMB+NTFeHlB24xteXLBqkrGLlnX1ycEbX2lYbcApaXDutDMwXPI3KPGVyzIOyxjJRC/QaKYUzsqOPn8HDYf9xbTjuYbMpawmwTl0E4d9YCHKC9nczAWYKXgyghNOejz96rdW6puh3FIXZ2UZpCgGDmZOVErV47WKYhMHYKx8+hfodNiTcxY2TLfAbW3oITyJJGa8A+btFswEqTokM7jirvoZksnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soQNUeEb/jhn30LxbS1e56qDKnIrptIZWRCy5AorHhQ=;
 b=Ft8q4peEDHWptbvJD6ZqHOQaytqjXHwfCIqlIvllP+uBlhjjncBVwQQB0hh4uBFmz/H9k3fMhFZneN7u1EuX8G4Da7BFNzdrz2f/T8ckfpz+as2T9hRW7xxEEYVh+TYTmHh/wslT5tshuebghHO6oMV+dzEuhNus0Q+kGvGi80innw4SD9ma+RG0y6gqOqzHrvucIhMH5tz/ySjmFpzXCiEE8j9KuJH5jiMvuhdR2d0vu+MxfyU6SfJ1eFB8+mXJ3pmZ4lsxn8l1CTiECRrwMs30S6svKfV1Ed61BMRWbScMFtzQlTYYJN8SQlReWvsCWtS3aEAokVJKo5Jgz5vBGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soQNUeEb/jhn30LxbS1e56qDKnIrptIZWRCy5AorHhQ=;
 b=sQYvqCE6Tna9nPHmuaSMPz+HtStPzu3p/WZlE4sxWJSQCNv15XTcdk5QL9fhXGaAw3CA7KLu8YTzDXcO13yJFsgiA/DYE6wj94LZsgRS1FG6k+kgWTEawCNDZcGQfRe1S+/nZUu4a9RzJe6EZsXplwq1NtPlL3bVsv0EFFUeJiA=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by MN2PR10MB4159.namprd10.prod.outlook.com (2603:10b6:208:1d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 10:57:48 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 10:57:48 +0000
Message-ID: <9aa530f1-93fd-16a1-fae4-4b7bd6e7005b@oracle.com>
Date: Thu, 29 Jun 2023 11:57:42 +0100
Subject: Re: [PATCH v4 1/5] vfio/pci: Fix a segfault in vfio_realize
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, avihaih@nvidia.com,
 chao.p.peng@intel.com
References: <20230629084042.86502-1-zhenzhong.duan@intel.com>
 <20230629084042.86502-2-zhenzhong.duan@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230629084042.86502-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0401.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::10) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|MN2PR10MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: 35dee3c4-8f8a-4aef-7582-08db788facf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9DI3DnILaPW6El2o0HRkSTQdthdxX6JJZm9edc1XivuJfry64etRDP9iJQ5BdS8DyBjZ5WXAotfn9H8edYbIINq/VapwQmXKQinvKbwY+VFzPQAG+2MhS70TN8t30EdqUu7QmVNP4KO0J2nnVM23ZUB6CcuiWfuvCzYEJVsiLQWjwrU+RWeqf/3jpdJW9Fb9Z2Y4jsn/2+0c3/wSmMSo9xZMJt1HYyBM3c0Y/uz1AcnnJtcwsRqTbAEzs/xYR+RJGlqLYVh7hH9RTvaQ99GvEUYcjrpvuV/yYoNRwN3zMogAUAmkpEcyxP2Wft/e1u7u9M/JiWCYBGWyvmprk01j8c5s/sU+HhXCvIKIBrVhxb6owRPOoIcl3eArteQdL+IW3lNPh22HxckFP3R+dpSVIfgV86OesEV328BrX/w8S4u/uMEIDMAd5kdHkZSLHOfusMJTlRZ+j1XsS1P6ir3/gVojJBeY/q+d5imuNqUdjqpHAj5As+9SbZCp1JSsgnJObORLHW3FgL82BiRiflMTsjJC15XNx/Ny98FgXmnm/CoYaP+UKvwoYHkN3f0CsJl+MVL9igtsLJrNKIWxAj7TzY0SCKCji4gq1xdW76prZJjNtbOubT7HUc1mZ8h/0XRN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(53546011)(26005)(36756003)(6486002)(6666004)(2616005)(2906002)(83380400001)(186003)(6512007)(478600001)(6506007)(5660300002)(316002)(38100700002)(31696002)(8676002)(8936002)(66556008)(4326008)(66946007)(66476007)(41300700001)(86362001)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEVIR2U5N2cweUF3T3NCRE5lczdKMkJ1QnZDRUoxWjJYdW4vVzVFM0NkZWt3?=
 =?utf-8?B?SEkzSjBtMC9VeldSTGRlbG4wYTcvbG5GMjY3QmJxMU9vdnBScTFkaEVuZU1I?=
 =?utf-8?B?dDdVaTd4bVRWRStUaENBUGZTbWNDcC9rY1pWVm1HdWhjSjIreWlCTFh5eWh2?=
 =?utf-8?B?ZlgrVlBOekxPL2pjTnlOK25TTEMxSldpaStVbTlQQ0NER0pQU0ZibHlRY0pm?=
 =?utf-8?B?Y2phZUcxUGJuRW5ISVAyVHYrMkZ6SlBVOVcrWDZwNzV3dXhLWDFrMGZwOEts?=
 =?utf-8?B?cGpCalUzMU9DMDBFci9TaE9wMEJpVGNQTUdobnh6a1djcEtmU2h4SFZOTW14?=
 =?utf-8?B?RkZGV2c2VXFmNnlaekc2UnRtSU1BZWdVSllqaS9kOWFyalcxbS9HbE5LQ1hV?=
 =?utf-8?B?ZFNkR1hwOG9jNUJLZ25tTkRXSm1SUFhiUVc2RGZxWW8rN0h2eXBGdlhEcW5P?=
 =?utf-8?B?MG9BWmlrYk1lY0ViMmt5dlJsYW9ReHdqdUc3L2kzQlhFdFE5RWVHZUIzYUZO?=
 =?utf-8?B?bHJXRUVtMXg0SmlRTmNtS2VpUnBleElMQkw1SGlvRXdxa3JEWmI1eG80SDNm?=
 =?utf-8?B?NFB6QzVrY0xWTE5WMHJMWEZ4ZVRKSW83MzZoMmx0QnhjTDNCRVV4dWljTk4x?=
 =?utf-8?B?QXJoZ2ViNHA4aW16VjJQdGNOUnNBdDRxdVpmQ1pQaGNKNEJvUDhVYXcvdjgv?=
 =?utf-8?B?VTVlL2tkMzdvQUNVTXIraWpyaE1PTm1JdWFqY0JuS1ZjamdEeGJmbkp4STFK?=
 =?utf-8?B?MnpaWXRPT0pjMmVXY3RWVG80a1F1dzZIRXo0N0k5RXhDV0I4WlZjaXZHZzhK?=
 =?utf-8?B?YnFGY1BZaGU2YmlKT0JEU2hSQ3Ezb1I5L0cyVGJQQy9tUUlEL3BpTTBzVFlE?=
 =?utf-8?B?bFhXTHJXQmlGb1JhMmx0ODJJRmNGTC9wWGM2OHI1K1VLdTZObFlDeTZQczVt?=
 =?utf-8?B?Umx1eG9ia1ZkczljZ05va2dEZ2VKcmRBOEc0OVpydVVQQWxNWTN1bGJQbU9s?=
 =?utf-8?B?YzhOZWh2YUZzaXRaQ212Rmg2SFk1aXlEdDFSRkdaeGdXRE5rbEJERWpBT1Zx?=
 =?utf-8?B?MXhENHpQa3N5M1ZHYWFCSWlpL2FKQ0xjY3dTdVJTT00rQVkvN2p6TmVXbWxI?=
 =?utf-8?B?YjczWjA0QUsvMXRwZTA3MGZ0SS9LKzNkelM3dk9ESUt1dndHMldlYWk1WlZi?=
 =?utf-8?B?T20rSy9CQ2tyZlpjR3dZYXRFdTQreTVEVnNuc3VqenZIU25hYldEdWNIb1ho?=
 =?utf-8?B?Nml5WkE3akV1Zk9HS1N0U1VXQ0VQeFRBNnc4bGt3T1ZkUUdLVXp4cTdyS2xI?=
 =?utf-8?B?LzUveVJtNWFTYzFHQllCTFpyME54TnMrMEQzWDVNTGhVOXFicWhJeUg2dTd5?=
 =?utf-8?B?Tjd6cUN6eUNwOUdDMStNRVdQdHo1MnpwTVFYcXAwMFpKZk5CQ0RkVUFuMWpH?=
 =?utf-8?B?Uno5b0Vnc0wxZTB3M0xaTmJsSi9FL1VPVGY5Vis2Q0p0L3YySHl3ZUlwTmV3?=
 =?utf-8?B?cVIvM1VzbDJNYlY4cDNzbEd4bHo2dlAydGtrSzA4WCtxTGV0bmU2a1hVa0pX?=
 =?utf-8?B?UzhtakZmaXdsbnl3c0NxbWFueFlrZ01KM0NST0RCelEybC84TWxueGpzNExz?=
 =?utf-8?B?dVljbjVMQ2pmUml3UnpyejM3WUtzQnFpdmMyN3g2SEg2UVZGQXhtSnFhdVhn?=
 =?utf-8?B?d3BUa3UvVXVLRWNRR2Q4Q2F6U29jM2kxQVRnNk9lNjVyelJnQnRFVjVUYjRN?=
 =?utf-8?B?ZStMNGxjSHFHQ25pQ0oweEFQNnY1K0VsUGVuS05meDRNa094cDgwSGNrL0tW?=
 =?utf-8?B?ay9SUG1TZ1E0eUZPNk80YnlSTDNvbURXRktlY29pUVRPdDJvTENueElGYUZ0?=
 =?utf-8?B?aEQycllnNFR6bkF3Q21hOVgrVHZhdGswQlI2S0l0ZlhITFdKdVh1ZDJiQlhN?=
 =?utf-8?B?SXMxTDhnNlFIK3VIamQxWXBiK1hnQ2k2UGpodERYUGJaa0hkRVQwNzQ4YXZM?=
 =?utf-8?B?N3dhS0VOR3JDMWxVTUdLS1huYnIzZjBqQ1ZBTDRjL05MTy9Wdk1kOFFpRXhr?=
 =?utf-8?B?OGMxakt4YVU5c1RqS2FkWmpZY25BKzBCWDdFYVJoZ1VGSkpNK2lDaDFidHlI?=
 =?utf-8?B?UEMvbUFwZ2sxODNmRnMrRDVrSm9DTDNOekVQQnhHbXlnb2RxM0RITE9vdEQv?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MJYAmKK2MiRFtZiNxZ0nF/zRTO4ynDyQ8YAVg7SHzrL+H4eIUU4lbbEsXvOcefHPrxqZnJ74MNUOlGJEmybPLTZQr2Zci5Q5Ca0Q6SB0bvAIObVcJZJZBa76b2Qc58Y/4XE4GPon7Oi1DWVZLcxv0blNc+FzuM3qMi+7obrK4+zIrDsOnt6u5y2Osv4H9/Qmp4aXYseUyTU+9IhokCqnAp1Yg0NGe4J+53KCaM1ZJdhWSmrdrtSIZTHKwUYlBr4XvR3Uv8qCiMRzYch2gQ6W5yi1K1QlkgJS3VDFqZVha0c2QU3lhDCfP7d02d9RvYbl0BX10t+iEUmPiECslNB3HsDPK4Uvosn4r55/lGZ/crgJk6OXvDiDZ3srWGZJo4TotOVCNc2mntreD0s0SN3C3eGavV7m0avptzdPvD3jdGcRo+6ris1QOFIGFlRCYPbnvzMygBL/uJmKP1pTdzS2B88AjYONpuBrgDSNTElyEsfKyROKMKYr25ImYsEwCELFasaTalPgK4wk6q1GFT7H2E92dkkCgZwMuYiTGWT20Zyit425RyhzzRrTA68x7J0TMghqdBhMdKbxE+UZQyNBGOdpVRNhE0SHuCfKsX8Qpy+5ZgvubeNRiVMZTlK17WDIwlfmVZMFYcI4qv8jr7MYsbfQSKRSnx0W9IT4Lh6XdmJ6B79s+c/w5KZWhzjFykkZYu1Uql1XWPKwchrhCtEibP2TfOz1kFdejvDSjmSkxVQfE96uVMwFySbe7aM3mIRm7fALco//6Uq3WBaStZh02W/MU+ueuAaO6w87eMYF7aJTRq7p9/gr6wBOtcyZqMpy2VXJIQx6jd0fJRAPzZI1Wg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35dee3c4-8f8a-4aef-7582-08db788facf1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 10:57:48.1996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cq+z/PU4K6vOGyJcy0p7Qg7reNup+fAKIrfl/ozoRSxAVKuM+DWpYAY8NGVvuKcDo6u621VFYutXZFG9A/U9KVnBCtcv6CTWrZs9nUPgBVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4159
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_02,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=730
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306290098
X-Proofpoint-GUID: iUW15Xh14Vogs3GfoqLShGR22jwsJ7Pu
X-Proofpoint-ORIG-GUID: iUW15Xh14Vogs3GfoqLShGR22jwsJ7Pu
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



On 29/06/2023 09:40, Zhenzhong Duan wrote:
> The kvm irqchip notifier is only registered if the device supports
> INTx, however it's unconditionally removed in vfio realize error
> path. If the assigned device does not support INTx, this will cause
> QEMU to crash when vfio realize fails. Change it to conditionally
> remove the notifier only if the notify hook is setup.
> 
> Before fix:
> (qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,xres=1
> Connection closed by foreign host.
> 
> After fix:
> (qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,xres=1
> Error: vfio 0000:81:11.1: xres and yres properties require display=on
> (qemu)
> 
> Fixes: c5478fea27ac ("vfio/pci: Respond to KVM irqchip change notifier")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  hw/vfio/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 73e19a04b2bf..48df517f79ee 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3221,7 +3221,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>  
>  out_deregister:
>      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
> -    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
> +    if (vdev->irqchip_change_notifier.notify) {
> +        kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
> +    }
>  out_teardown:
>      vfio_teardown_msi(vdev);
>      vfio_bars_exit(vdev);

