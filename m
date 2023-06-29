Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 574BF742491
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 12:59:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEpNK-00049X-Mh; Thu, 29 Jun 2023 06:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qEpNI-00048q-CX
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:59:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qEpNG-0000Ys-MY
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:59:44 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35TAoQI2003657; Thu, 29 Jun 2023 10:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=gdDnpgRhRi83JwsgxffRox4bqTYaccXurRaQYnFd8XM=;
 b=EiCep/CjgMJ+wLk/GCRbp6UBZMk4PMYy4WzoAdq4wO/gyrw1MVY+QDzKcrieIuqZ4/xu
 8JVqFFvg9lLEQvEolky+frQa0ShiKqNejUqTTqi4uvK2Q+zHSG4kqLIUuVgelVFla3m9
 //tDen5EUYmFdCWAEGI/nXMU07kSPuM6+9hKedXZNFEGRDlkTodQndpysazajXZLlHpQ
 1GotUGVyUvRvN4ASrYcPAKpy6j5N6+xHbM8NPX7tr0OUEJw+A7IYBrYiNJdX5uHWAbP0
 JkAoC4GuzSLFQOjR0v3n7Shie7j6mICvHziz7PUejWXDddF6/Hd6yteV/QNV0gt0BIPC 1Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40e9xvs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jun 2023 10:59:39 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35TA2DlG004049; Thu, 29 Jun 2023 10:59:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpxd8xer-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jun 2023 10:59:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLNPwcP8jxH8VPlNFdu/u/upEbX6v/oLeav1mN/xaUD+NurjWUU8ik4MV652UVtpXFp8NtwQ1g3Cvzl8zE8uefohez/FKGgts2CRlOoGTXUMw+08DFlchD9rEPltSX22kNLQiV8XDSVdCRvUjGIJGAyHwA+hK1772D+iWOLuh7MdUIWi+bF7I4oXR4AVjLcK2NzjrUPMa/fc0sc5L58MFb/3sj/+SoaCpKd/aq9VQJxUcBTf/J39G0zNESgQdSsgCX5kH5Hnrbf+JAktiyfTZh56XT5QSb6PcQ75vLABopZA5xQsc3dipD2f2kb7FgGaLhr8K9cs4oHF7gU4XhWHFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdDnpgRhRi83JwsgxffRox4bqTYaccXurRaQYnFd8XM=;
 b=AEiSyMPDeKvsnY9928DNycEAMQYFIPfL4ZYp7VL/hb7nKMO8OuYcp/3s5CUFWyBj7Yn6xPnYcNKcnS1TLYrAQ7TpQxSXeYeFuFoRQ5VTRnzqRECNjogY5iGd/siVs7uDewQRf7Ri4cDVqX51rCtRtKhM3J9aRbBTqEjsxqXtCXrgfzdh8pHBYC+8YjWbbbzpma1KzgvbkVKjXjGg05FBQOOlbA9sPp3olnYZhUXqHIIyx32MDyY8Cmx/c801hg7B3vlNwZaP4eJuImof0ls5pcK/RPnElmbXA1QgQHRhhRUkQ+O8EBQB7mOUZ8cUB4W+Gyj8j9auJWrF8h8TLFXqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdDnpgRhRi83JwsgxffRox4bqTYaccXurRaQYnFd8XM=;
 b=rNMCGiPy70aaWTD7IJfblwpMZ2xLM3+gKw494h2s3fCTDXC+gIwJRBAYn9rjiIqW5m6vyKaG0zPifMSOGnlLocWpNzMvGxNpKoZNuHklP6XDEE7C49kEXk9RPgFSoER4FLWXafmcKtxMT0GeGTAQdp3ieD0qSfpDTGzRJQpSiPo=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by MN2PR10MB4159.namprd10.prod.outlook.com (2603:10b6:208:1d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 10:59:37 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 10:59:37 +0000
Message-ID: <0c11d499-fee5-32ff-7850-e4243e708b94@oracle.com>
Date: Thu, 29 Jun 2023 11:59:33 +0100
Subject: Re: [PATCH v4 2/5] vfio/pci: Free leaked timer in vfio_realize error
 path
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, avihaih@nvidia.com,
 chao.p.peng@intel.com
References: <20230629084042.86502-1-zhenzhong.duan@intel.com>
 <20230629084042.86502-3-zhenzhong.duan@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230629084042.86502-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0414.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::23) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|MN2PR10MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd404fe-56ce-46ab-640f-08db788fee4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6lO+4ABHNNH/YGDB3oRj6YXR0PUIpY+sPoBndaYDAododQPK1BdSjFZzwPnU/H70iFsUz9WtMZvj74p2etIr4E6+Fnd1RW777aLjcI26r+AHBhtpwUsdBbPrvLrXQTNdWhExoyDQ+B9bGMa1YpvctWhHNjbVYWaluImAUAY/0A3JABEWvcEZjoJ6Jjjpsar07yWC7m09FeCiHSA9N1PsD+pyH8fcGqNmM8YTQXa5clqAxE3XnsBMAm40FSqUjVAtU58sUV+I370tHbV91wNPcTCa83QDxFLjbCf8haRsCMtrZ+E5hrAgvo5qhWqaGxGdQJu+dO8aisbg73dr8wIkSrernXQeDhclBX73S1yW2/RQkYBZeFV8Qlk9Ag9yZ+/V5qZdpaD9pNTAiXKhYcusJXcyd5gPwD+BMQlopdCrAiOPt469NGJOQ68hPHJw4JbGa0z7uBFThaORDNZF+lwHFluQpHHBFlf0ciOZj4LREgb3LlL0ZWD4sZhDxsCX6RneuZoJYaH6POclPLaY2W3M2Tc58iEARiV9R4MrOwoOBV/1bxK8mY09DABvn/ohkcN15Zd+t8VH/4KT2wVruXGZIDmH//2SjOUTK3ryI0os9A5MDhzfA8z3AwBOLgpOEuPJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(53546011)(26005)(36756003)(6486002)(6666004)(2616005)(2906002)(83380400001)(186003)(4744005)(6512007)(478600001)(6506007)(5660300002)(316002)(38100700002)(31696002)(8676002)(8936002)(66556008)(4326008)(66946007)(66476007)(41300700001)(86362001)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MytCMnhsZUtZVVQrSlIxNmczNSs2bGhUakRLODhXV3dydjV1cE42NVBMTHVU?=
 =?utf-8?B?RTVLMXRuVERid01UT0x2UjJQM0N5QjAwdmRHYmV1eEZwZTBYakl5U3E4UkxG?=
 =?utf-8?B?ejFrbkNYSmVjRnVLQ2lIZWlROTFkNzErOUMzU3J6bk1WWTFIWXkwekVERzNY?=
 =?utf-8?B?MW00WlZSQXA4ZkJWK0FtYnhRSkd5U3BUUTZ4L1VFU0RzS00vd05aREt0WlQv?=
 =?utf-8?B?UEdBVW12cTlPNGdRYzNxeDlleWRUd3JITXVFVUNZUlA1VTRlbVIyR1ZXN1pV?=
 =?utf-8?B?Ymg5U2YyZllzbko0QXc3c0tXeTVyREszdmZEdG1GeTFaaWpRMEtkRCsydGxt?=
 =?utf-8?B?bnhCdEVHYlVxRmJLWTRqNzEydzVtWERJOXNXVFN3c25aNnpJWnpJek1ONlFl?=
 =?utf-8?B?YmdaNmR2SUtpTk41UlNEK3JIYXRhVWtZQjFJR1VzdFloQ2dBOU0vYWt0REdh?=
 =?utf-8?B?ck5QZDBtRU0xa0V1dzU4aW1tWUFzdk4wbEphWnhZUEV4QTRydXBrZFc3N3Rz?=
 =?utf-8?B?MStONHAyUHlLY2FFaWtqcDJsMXFEWFYxRDhTS1dSc0FkdGZvcG44dE8wL2hH?=
 =?utf-8?B?dUhuSWkyRGo3b2Q3d2JycW5pbHg4VVd4QUxKa0R6VXBzUEwwS2tHQlFld2dt?=
 =?utf-8?B?ZFF3STc5RjIvZG05UjR0YWZvSDdPU3ZPamN1WDExZW0raFJRQ3dNL2xzdTE5?=
 =?utf-8?B?ODJRM2FsVVk1bG9xaUlONTRHeXFReXhOU3gvSkRlVVUxeUxWSXFsSmdGVDAr?=
 =?utf-8?B?NjNOdW1xejQyWUFQc1htNzJoK1pYdUhNd1JlSmdCQkdTQUN3OFBwQ1pnT3ZW?=
 =?utf-8?B?UUhSR1RGYXJJelBPSUhFVmFLRUpsckNpUFR3c0ZhYklOSmFOQ2ZiVkJPMDdU?=
 =?utf-8?B?VzAzWjJkUFdvQXpzRklxaHhxcGwrTEtnRzhweEIzTkg5TWU1ZHdjMUdsYVYz?=
 =?utf-8?B?K2dSL3BHU3hWMm9ROXlaUnRPMTJjRUp5SGRJWVJEcmlPRSs1MDhUbkVvYW5K?=
 =?utf-8?B?eVVHRktQU0dibnZWMzNzaDFBdld3c3FKOEVwbUVLZE1aOS9ETWZhRjlUSnIx?=
 =?utf-8?B?RUx6ZDIveGZlbWd5VXEwY3M0ZTVFZDBMK3Q3cVpMUWlVRktPajV6ckRyUkFp?=
 =?utf-8?B?MU9peFJ4QWZ3L0pHSnQzWnFaaEVBb3E2VlQ2L0hWWmZzRFRCbzZIWStzcElq?=
 =?utf-8?B?elJHbFQ5Y2F3VDMwUG9CQlRoeUpnaE9yYnZlRUNrZnVTdjZER2tUZUpzbEhK?=
 =?utf-8?B?UjBFZ3RxVm1HRFQxMEhUcityUjdHWDNTQ3I1anBrVlFiVjlBTnBtdzNvZGVU?=
 =?utf-8?B?NkV0ZEJ4N0xBSkVFUEppOE4yUm1PTDBFZ0djWFVLR2lNcG5IOTJwVy8yNDdM?=
 =?utf-8?B?RWFGSGZIdzd1YTRLTnhMbk4yR0pCS25obTBaN1BRSUZOSTNpZVU3Wlo0dXVE?=
 =?utf-8?B?b1UyMFFXMWl3aHJ3TUtVbUpGM3VUL0VQa1ZnZFg4RmYxMm9iaHB4ZlQ5MGFC?=
 =?utf-8?B?M0o4UWJoeVM2MWloYVdtSkxHUHp1ZEo4WnRIS0lzRklvY0RITWRzSElmM3Fw?=
 =?utf-8?B?eVJOZitrYkNJZklnSmVNSDNIbHFTb2ZjK3ZSTWhQQk9JZU9zR3F6Q3VCR0l2?=
 =?utf-8?B?N1B3N3VZelpqSXFlMTRLL0tIRlU4ZUpyeXg0WDZrMXdsYzV2NUw3NndWY3FV?=
 =?utf-8?B?ZE5NNm9xR05BaTVwM0U2N1c2UUE4YmF6U21YYTJJYnJjUjFFYnhzR2tuVjZj?=
 =?utf-8?B?LytmZU5YZFk3WHBhYnJkcFo5azNjTHdwSU41SW84SStpZGxmcUV5ZmdMUmw4?=
 =?utf-8?B?Z0VabmI2SC8wZHhkeS9Ob3MrNm8rd0NOUk9LeVZ2NTRHUmRleFBxM0ZEN2Jv?=
 =?utf-8?B?RHhOKzh5OVRIN0VFWXJ6dzR0VVh3S3dDdzRScTdTODFYMzlYdER1d3QzV3ly?=
 =?utf-8?B?WExGeCtvVVRoRkhnR1NpZ1MwV1hYNkZxVkVxbUl3NUEya0RiSmdDOXRQUzBB?=
 =?utf-8?B?M2pCcDNRUFR4bDVvZXdmQlVJTE0reW9weUZSdHRKeklTZVBhSm1Jc3A1dnJH?=
 =?utf-8?B?NHJhOHZiWEdmYlpkRXI4alhjeERTYU42V3V5T2R2OVE3UzJlUmVtUE9Pb3hs?=
 =?utf-8?B?MGJYaEZQSHlkaWhOQmJQZE5rNzlWeGk2TjBsZjFPRjQ5ekh2eW5UeHFPZzg5?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AL2TS2TRsWgwIzlW735DdjbfiD9OM5atnfAkfHblIEYjZPWMYZ2tw7j+SKyRY7l4SAKKzvQawchqbvLFspnDdlNF/N1YwaeYKRq8cXd/5h6Rg9+y4JNOFQX/OWJZcoIkr/D1TUI4XkdIliR1o/rOH+yK770WQCetvsB7cR/bJF5MgG/3Ajir1f3nx5WsmlVZIrb66gS23hAFgEPhWH5pd3frfQUhk1O8+58oRAuC3UTQBBweF6/vqFeI4fsm4G/S3metBphqxRkm4CrURIJLxiLdcuf6bZeOchFk8b66gu/TZMaFZAEsY9SPf7trVNLOJ8S2WLLBZurMQlSTUl+gRYvO9cYSlG2yuZ1atSWDTGbKQZ1xXQEyaxzCS5/aRMenv+lGmz8to1a++SVSSKEZ7hkQ4GUJQml+vBMg2/yL91oLoilkgDNMc2lTELkB45qhAqXsctfeTU3PhCA1V+72OmjkloDhWxw811kyWivrcQYM9TuJkrEBcuGhVGYGJAOE0IsqpfDtgQzD7WgZdSgvk6TRLy3zSbY5d45YU0Kpqhvs3JbPeKfW1CTk1EUbCMnoIZ3guAR1XnYdFoVuOx5pLNngvBrVQQ63HC/1SwuCMC/vP+1JroeWoXdED0SxBhMq1+WrefbUMIwNOf0tlMNmVANEIoNbJTHly3zkk/BCO1fizH7/Rkp4jUCCeDANNePyJqIdiFm/MFby85Q/OeIklOISOzKom5w+ThTKNHkJP2oXqG2IOe99rEXOiNcsE+xIxyZGk+5+nnqfCpHb34h6WdOgvA3YR0LTgoR/RHFtlfobdGmnoo4GcF5Sa0jFKW7yrz7stuWXpIbEPF4/XEvo0w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd404fe-56ce-46ab-640f-08db788fee4f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 10:59:37.8610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyOE/vHxPPzCXrwzd/RJMoPXr7+MoQ6b8MRIooXIRPYXocczlmNOeEMPl8ScYy6j7J7O6+uimcjTRb68SRRdq1TKL9dZ78kwaf6rBTCu35g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4159
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_02,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=880 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306290098
X-Proofpoint-GUID: L3yFbIW91AV6EtnXlJTEII0bAF285XeK
X-Proofpoint-ORIG-GUID: L3yFbIW91AV6EtnXlJTEII0bAF285XeK
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

On 29/06/2023 09:40, Zhenzhong Duan wrote:
> When vfio_realize fails, the mmap_timer used for INTx optimization
> isn't freed. As this timer isn't activated yet, the potential impact
> is just a piece of leaked memory.
> 
> Fixes: ea486926b07d ("vfio-pci: Update slow path INTx algorithm timer related")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  hw/vfio/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 48df517f79ee..ab6645ba60af 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3224,6 +3224,9 @@ out_deregister:
>      if (vdev->irqchip_change_notifier.notify) {
>          kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
>      }
> +    if (vdev->intx.mmap_timer) {
> +        timer_free(vdev->intx.mmap_timer);
> +    }
>  out_teardown:
>      vfio_teardown_msi(vdev);
>      vfio_bars_exit(vdev);

