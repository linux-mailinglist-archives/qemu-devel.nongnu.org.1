Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBAE72CFBE
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 21:40:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8nOL-0001AQ-15; Mon, 12 Jun 2023 15:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q8nOJ-0001AC-1S
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 15:39:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q8nOG-0007Mi-Hg
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 15:39:50 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35CIT6mE014247; Mon, 12 Jun 2023 19:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=GG0Fh7HaRiWV2XjeWqthRaz7/zoOadADcwb2cFJ2cQg=;
 b=z+M0LDGZayN/TSDwbosIZ3aZV2r/RPFOJrd22nuzOLb3XlVkj7i6CeYyEWZO9H28YDsT
 4AIU/BTm4cD7a1gOvShEW5dCwsektuckf2ItZmwbx1iM5yvNK9tUlcrdRLHZx7KmgWuW
 ZXvoCvxobe07s0H5H2G0bTuGg1UvzmxM6DG5d+7XhMVoAuD0XJ7Svshyz1u5YPdirDRh
 ytswjwYZfZL/pzUVasijnncM1kvYl2bA7BRtRcZqt2FQAXXJnXzZn8ivJjTWqeVzY748
 ZhfZgmkcns1U4UiOjFbBAvYWh+44D64A+JIOzvXCGwjG0ieznQrT6bzzaXajzWny70W/ hg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs1utu6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Jun 2023 19:39:43 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35CIYLfA016194; Mon, 12 Jun 2023 19:39:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm37cdd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Jun 2023 19:39:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oX7up4MU92kLXn+aIb7mO2dF9nrU/+pkQUm+f0ky3nNFrFNbvDF0pb2GQX58sMEfDEw1C6u3aANEoDnP+RrT5z2Agjr4/FU51rnjPuO8gkrox2NbwCXxbezbMsKSWCjk5CnvrhfwH+FrtYgbc7fpMgINIppLEo29IYXjZhiNab9GkmmBau1NfQSeRqY4yuFcUi52hD34L5NwHvzPJQtuFccKxkvEKJuVihH1Lg+qFvoEGtze4JYKn97zc75djO07T8z6niPLv0ScxPXBhec446ZD8KhIbQqV6hVVWhV5MoNx0HXdbp+4aqHgBqT6L3cx4jEPq/LF8oCZ40MKh4ydYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GG0Fh7HaRiWV2XjeWqthRaz7/zoOadADcwb2cFJ2cQg=;
 b=U+z1mvClNL6zcQbBulON192vOv4Lo/IqVEqJipKXG5lcg+pX/JyFOfmAqZNsr54Eecb0j2dZSxmljv/G8jxzhHsxZTmO7PPX2I3WqdUy3Cs1sFNO1q4yxP49b43kA9r96e8tWfHjGuSIaOJP7+Vy0tMfkTlGIujwtxBm4cePGntfhB5yOkDmmp0Mzx2l0rr/yYPIea7KRhWw0sJZWrZMDkphzmbZC+WYI9TNEeXtaNFs8b9ldDykkpkJMRRC2Xf9gEcf/R+NwwembMZ8RCaZyLP3t5Rp1AB/zL0gEpt2GcYh+RGUx/yzkcwgs1p+JghiSg7MLUO4V+AO4mh62fVipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GG0Fh7HaRiWV2XjeWqthRaz7/zoOadADcwb2cFJ2cQg=;
 b=pOeOXnNzZdPiclbFNwvRkOJqPAZzAWdd9lCgP5+Qa8ztzb04zkC94+4f+q2l3/g5TedQI2gJn1arjconi+9KYPXLd11qZ1wA7ZBajPEzyrEokzwM4IF2xpilxsGaa9FcoN3CfZV7AcabwSBICektO7wl8GOqjT8iORYx8j8BcbA=
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com (2603:10b6:a03:2d7::23)
 by BLAPR10MB5284.namprd10.prod.outlook.com (2603:10b6:208:333::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 19:39:38 +0000
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::36d3:42ea:8103:b120]) by SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::36d3:42ea:8103:b120%3]) with mapi id 15.20.6455.037; Mon, 12 Jun 2023
 19:39:38 +0000
Message-ID: <bddfc088-268b-2d9b-7a28-6345b8bfa2e7@oracle.com>
Date: Mon, 12 Jun 2023 15:39:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2] migration: file URI
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <1686163139-256654-1-git-send-email-steven.sistare@oracle.com>
 <ZIdnj7Hr1L3iDVUG@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZIdnj7Hr1L3iDVUG@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:5:335::16) To SJ0PR10MB4686.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4686:EE_|BLAPR10MB5284:EE_
X-MS-Office365-Filtering-Correlation-Id: 344864c8-252c-4469-ad80-08db6b7cc21f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +U6B+iRXuJ14opmigaNSrwgiCoUrOobe9O574s5CpAlbYJzpdV2mYNOSw2D/1J55rU1U4Qyx3KXbBWcS26BTSjbCWLia57p+vd2zPX7XLGdNpG6OZ9HDxvBztOdQ8TKHKAMjmrV5cdRipQPgJww9KRPc/HlN/wpbFApQaB+8kGj4dVL9NY/4af56rmQe7P0fIjllnFcW0D9BmNDKdeRO6iLjKfel4Su0wxW3T8/Ipka8UbtPKOZAByuUlpK8xvusJflJG01siAJeU74QGnCuBnN/lyCr1ZpoVlo2GXjYo4i4bOe5iZ+JbrU3VKBWvzRcDGtKE4VFk1OfT2/ikMp6ALoeA+ua+QJLAtDkd7sGnwN9iJnCDyzgeGsq0b0tSsYMQI4xAMv4qz0xKJM7zrXKp+0ZGedn7LwFFKuW6HaWTv510AGgKINzQGxL8b8nviSQdW9zB7aFy+L5ezRkfdx+4ICcDc0+W/NG8pZF00pRB4Xxmi7l+m2u7JhuoCKMzEghDBrdVA8HsRU3ShZxjfsYpYnjkAU/jR93LRUlu7KSPsyLJGpmpwyS838v0sCph86peib7BbPa5dbduLeiSwclkhvDUmbbL+tsssR5vw00x8bGVcUUhG0nRGM+tdq/lIETmsppgkJdsLIyZv0KcVFVhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4686.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199021)(66556008)(66476007)(6916009)(8676002)(8936002)(36756003)(5660300002)(66946007)(54906003)(31686004)(4326008)(478600001)(6666004)(36916002)(41300700001)(6486002)(316002)(38100700002)(186003)(26005)(6506007)(53546011)(44832011)(2616005)(86362001)(31696002)(2906002)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3RGRHYzVm1VZjN2cFU1ZlU5Y0tyUjMrOVd3Rjk4YytzNUpDY0xyMGJWUGpJ?=
 =?utf-8?B?SWg5dFA0NGsrbzA2UTAweXgvazZIMU5wMWZLZTdqYzQ1S1I3NFBnblRwSHZY?=
 =?utf-8?B?U1RSM0Y3V0pSelNMUXpRcTVscGhBdjVZdkxHMk9rV3dXWWNuaWNUNWFMVjNm?=
 =?utf-8?B?SzYzRnJXSkFmd0plUnB2Q3EzeU9ETzUvYW5uREQwWGJpR0l3dFB6VERzL3pu?=
 =?utf-8?B?THNwU1lsc21sVGxhYjZQYUVYL3c5S01hd3RwVDl2SDdyTHB2YVFkZjJab3hS?=
 =?utf-8?B?R1MzZVBKRUlydHk2TGV4OGFlenoxV1dOV2poYjhtVXZSRVM5bVJKR0h4SmNl?=
 =?utf-8?B?VTlDU3BBdWQ3YU5vNXptNFVqTCtyUFhaQ2hPTHpYZGtqcUg5ajBLdGZIcUN0?=
 =?utf-8?B?QytucDJhK01RNUtXRmFJMXhQblpNTnluS0w2OGF2SXhvMGhyckVkVy8zeFgz?=
 =?utf-8?B?TmlTNkQ3NnVZZHBMaEltaUk0bGF4L0xrenQ5YkVPOHBrZUdhK2hIK0pXSTlG?=
 =?utf-8?B?QmVEZWxNemYxa1JtS1J4eEl1V1lOVFZCNGtJclFoRFYyU0lkaEVOS3lNRHFt?=
 =?utf-8?B?UUgvWlJnUnhyN1BXY2YyTThqUkQ2alFxSFl6NEZsTFVKaE93a0lkWXJQMlg0?=
 =?utf-8?B?cklCQjNmdUY1RXoyUkIvUS9pSVpkbTllYjJnd29mR1J5TGdDZWVCRDNaRUFF?=
 =?utf-8?B?QzhGR3pqTHpSYmJXSUFWZmxrRXNNbFY4dnFLZ1BUQnRRT0JVWkNqSENwd1NU?=
 =?utf-8?B?b3hyNVlaMmtIZ3plVjZHMFFQdVZxV3NmOG9EenRmRTd3aStTemIzalRjTWhz?=
 =?utf-8?B?QkhBbDRmakhLSThCcFROYUxGVm9NVFdrdjVyZENjZ3d5UTF5TktkZlhiMWc1?=
 =?utf-8?B?RDc3Y2xOMHlqaEVobzRXUXJqcWoxNlJsY3NHUnBwYWh5SFIxT3NScEd2Vzla?=
 =?utf-8?B?SitzSHh0TDM1b2ZnWHZibWFsTXU0dmRNSVhtQ3JacTZFZ1VRL2Z3RGcvaEpa?=
 =?utf-8?B?MVVkMXBvb3J6SFBiYlRCeFV2T3RvVGNQZ1B3OWtsK1pTNW1TZXNxYWNwSFNV?=
 =?utf-8?B?RVZ1SXBNc2NiaGR0NjFQdGhzbjdoSWJSLzc3eFhYMzBUblpQZ20rcGJiM2xs?=
 =?utf-8?B?bXptQnRiOG95RzRvdy9rbFdYc2FvUzBUVG95bFpYVFlWU3g1WkpsZitpOWlD?=
 =?utf-8?B?cnRoRlk1VWdRVEord2ZON0ZkNHNsbzBmMW1rQTY4b2hOSnNJdlR2UXFFUjRi?=
 =?utf-8?B?ZzJxYjROVGdpZDNacTRPTFcrbnZyYXl1Y1ZDWGlHNkxaOSt6SFZ2ZFVKRWJU?=
 =?utf-8?B?TkZFa3NSM0lGWlk5eTRQdEFnWU1hUXNiZDM2WWoyYmNPY3hMcVYvZGpickQ5?=
 =?utf-8?B?WEsyS3lWWTRzSGtOY3VvQXRnb0x5Q0hwNVUxN2ZBUFR5QVgrbGFQQTBRZit4?=
 =?utf-8?B?NXZETTI3SjVCeGQvSGFHOU11eWRVUzZ2Nk1MOWh2dG9JOFJQNjk2RUhldlR6?=
 =?utf-8?B?ZHJLZ1ovTkJQd1I3dGo5Ni8xNEZPcm50elpKeGJQUWJIejdKbmUxU0Q4YXJT?=
 =?utf-8?B?cVpIaHZON2RWOFN0SjRXZlBYRTFCY2RUa1RQYTRMalpnREtLU0sySWFyQVU5?=
 =?utf-8?B?cENneUxQNm9pR1ZYcTA4MHdacDNIT2x0c0hOdGJCVTZiZ1hCcHFCMmtlbk1t?=
 =?utf-8?B?ZGh2UldVM1grVEtlTWVHK1NEcGpBL1VXblFhTko4bW5jMU1wWFAzbERGZzlr?=
 =?utf-8?B?ZVlZZjBvZERMUVRpNzNZRzFrek9zSGc3M2dRRDV1R01IVC9SNU0vaFFvRVNy?=
 =?utf-8?B?cWJKWmtpeUJ3Z3BUaGFJTVpKUExFOEpadHkzRnlIL0p2eXhFeDFvNFB6eDFK?=
 =?utf-8?B?RmdldUsxTGlFeEVPTzNFU0N4Rksxck04Z21QV0hGZllZMExuQnpJOUgvK3o0?=
 =?utf-8?B?TlpEWTFEWGtMMktrNUUvWE02TUVqcTJsYlNad2VYMUM0cGk2VkU5MnR1WlNR?=
 =?utf-8?B?cWlMUFFRUmVJcHdVUXNYWnRKNW9DWVZjRXJaRHBYUlE2aExZLzNWN1phQ1Nh?=
 =?utf-8?B?dnIxdEp5d3gyQnQzU2lpS1lnc3poQVE0YThTeW5YSmN0blg2K1lwa1hhZGNI?=
 =?utf-8?B?MndEOGQvQlUxSjVjcnJ1Rnd4Z1MrcnVMTEpFbzVTb3J3MkI5VWpZK2lkVG1R?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NmqnVqKSMnKF0tTenYKBnLee+urrEzNeovknePIhc96pbC7hZQhMLvnEHq6doz9h6AXxwbguIxb2V05m71ylTlfcr9IEApjrwC7/nQwHCwg2YowEVwiozXP/OUKFhpaNXGsQLGAFgUhS9y9XMHnoeucwER02HEvNo4QL9UFOfoNWzJjqItUVy3P6XZCVVoeCNw9ni/svwA3RD+3ogYg+vB25ZZUgWGRccGLrSsYvSVKDiPyh6p2MqcGaF1rP9YEIjtbNILDPGaRQ97krUCZb0aL1DqNf+0lffxxTAK7jhI4QWiHf0IS9IxX2kPrcr6pOMd07YgIzVuYduITsZxG16HGJL+zc5Ffyris/tRw3V8iuprYrEANw5DcsRMBCgL9yUar0t8bVGadDwgbmUdqH4M9vgYE4MnYLoypQB5ApGwjAtZ7KltQdPKOiLABkzQpeSBn+s3riUtHkEthjgDmY5ulL1/Z1P1XScQVsRAqJnsUxmGUtoIiJY+dSo0E0mY9/a4OPapsgu4dIBv2toMxwc/BWLFuF0hlhQ6imwxRGoWJW4vK3/a6YsaYSPHRZVk/YhJZGqA7r+xcVROUJ2Uq8NNeO7uUHT5Kx8P9GF9mRBv64FjcLNs9mt5DWBVuFhrvMB//nLMc9GFlBu1ONwBZ427jXUhLx2NH2ooS5iNU0z9Y9z/1FCuHZaCXBIQjXQU3eJLf3wTkKkc21QZC4k6hW8/24hTRbLgrKNI3prqtWyjvktFJeCmb8WuKzeSix/bvS7sDWk0c3lpnjpkaUogXomcGwLHfyx0voiy58Drykfj4fJ9Ng3LJLOHP495MDjGKu
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 344864c8-252c-4469-ad80-08db6b7cc21f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4686.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 19:39:38.1772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KN+aU/ra9bnA48TsKxVe18V+IFB5G/nElfC5PKoTbVanHMcc2XkdjcjdV6X4Rqmxfa2E2LrOUWadhbofLTHuxeytxKRToqXW3V8Bd0lpotI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5284
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_14,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120170
X-Proofpoint-GUID: EJeNb1CIzJh-a0iVEqQYK5mjRx6uzkXX
X-Proofpoint-ORIG-GUID: EJeNb1CIzJh-a0iVEqQYK5mjRx6uzkXX
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 6/12/2023 2:44 PM, Peter Xu wrote:
> Hi, Steve,
> 
> On Wed, Jun 07, 2023 at 11:38:59AM -0700, Steve Sistare wrote:
>> Extend the migration URI to support file:<filename>.  This can be used for
>> any migration scenario that does not require a reverse path.  It can be used
>> as an alternative to 'exec:cat > file' in minimized containers that do not
>> contain /bin/sh, and it is easier to use than the fd:<fdname> URI.  It can
>> be used in HMP commands, and as a qemu command-line parameter.
> 
> I have similar question on the fixed-ram work,

Sorry, what is the "fixed-ram work"?

> on whether we should assume
> the vm stopped before doing so.  Again, it leaves us space for
> optimizations on top without breaking anyone.

I do not assume the vm is stopped.  The migration code will stop the vm
in migration_iteration_finish.

> The other thing is considering a very busy guest, migration may not even
> converge for "file:" URI (the same to other URIs) but I think that doesn't
> make much sense to not converge for a "file:" URI.  The user might be very
> confused too.

The file URI is mainly intended for the case where guest ram is backed by shared memory 
and preserved in place, in which case writes are not tracked and convergence is not an
issue.  If not shared memory, the user should be advised to stop the machine first.
I should document these notes in qemu-options and/or migration.json.

- Steve

