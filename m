Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D4B72690D
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 20:40:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6y4a-0003er-GD; Wed, 07 Jun 2023 14:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q6y4X-0003c7-Tx
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 14:39:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q6y4Q-00083N-Ba
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 14:39:53 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 357ElP0v007974; Wed, 7 Jun 2023 18:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=hqqyqIewHY12XWFEdpsKzom7Qhz19pXLp0rQesSfKA4=;
 b=1udU3ugRWq829w97pFaA4BuNjF/eTiAo9vR5XAX6UcK9Y3B6hJblqoJsaPQgBOf0AviZ
 E77TKJp4+rKmT1VfQl2wiUOoww9lQlOE4XCBgQ67ZnJxYpW9Iro8RdNrzo4gNYeGDYYg
 cTNWk5QUTN+tS2N8CiukhW6I3QULYLKva1LpiIiTeN7pPVquv2FPCt9Glc50YEqM8cBN
 IIW3K7j2klxLKCFv2sh57QytskHPtCYxtP8NxFdKHmMcve9aba3U6UT9A0ZLejfuKwBj
 zIOekcDHKjCdX2bWHDwUX55Mop5cW+ns0qLgvbhwPjaFQup67pf24wrc/IyyOnGum3a7 9w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6rjfrc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 18:39:44 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 357I9nfN035967; Wed, 7 Jun 2023 18:39:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r2a6rw44v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 18:39:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMxL5atH7n5G70yECGrZIXcnrGlgK+cknyzKKpew+0fjdI+YCAG1ewRsDzAPgVToaMkHmfUcSujnPpbGybOr4YV9rhCPgG3sJ7a2G2fLS1i+bflndG8uEKBRcJbPgjaczuR1mVS8ariG5jKVf1AiVh6zVqMlsfs/fImWmunjEqfPYyRMWPolAFTMASw01vdHY2dpc3TM4mrk67vtwf+zm6dBA5BmsDQNl1cs0cSvoq8cR0KTod3wKRmi9PVt86vwh+rpjMzgd7ar8kDEnkbY+Lp/kYU58JpH8IfSN2veaUa2gmBek8hEjgOPATfuEfVr3XRqhj8O9rq5Zbi57my+ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqqyqIewHY12XWFEdpsKzom7Qhz19pXLp0rQesSfKA4=;
 b=oVGmnTePegZrOnrxH/JcphoXWumgL3ltBWk1OAc1GUiIzyV/JdwT7nl/1BY46x3QZkzh7XCqjFbM9lQc3qJC8vhW/fwPnT8U2Prnh0qf0bdwccjawgmbpwOyGWiyd+CgKiaMTkv6GEhw5/lo9KMcfElEWhe8VSlNUuOIZeJ9809zDnpNGirGuVJBmMB6J4mWDXr4CbqPUe6dpOuCUWKrjnri88BwQtPS/OcGGK8f5YEu75eQTugfg5+Xtz5gmbua9y16qOgh2uffJoK8OAQ4TG2FrCOCbfwAFoTceQaf9/8nbNHyb1fnD8gVsfldQz9IcYo8unJOTk2f04gNI1FI/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqqyqIewHY12XWFEdpsKzom7Qhz19pXLp0rQesSfKA4=;
 b=E7SwdVWGrbDbm/wuFFj1sigKa5pUY+7EJKYnWt+yVKo+oznrlC1WGDZX+ba+Er70mh2oZD1k6E/iyRrWoQo4nYwM1jw9bv2GLFfm6r4/OyePAlKxsEJ9PGCv3FqZ3FcT/w0IFIsl+L1vPyiLILEcAtdnaNoNZgkGNTsJ57J8J7s=
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com (2603:10b6:a03:2d7::23)
 by DS7PR10MB4942.namprd10.prod.outlook.com (2603:10b6:5:3ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 18:39:41 +0000
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::36d3:42ea:8103:b120]) by SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::36d3:42ea:8103:b120%3]) with mapi id 15.20.6455.027; Wed, 7 Jun 2023
 18:39:40 +0000
Message-ID: <229c4b19-77ce-e0a6-c76d-7ab9cd74c6e6@oracle.com>
Date: Wed, 7 Jun 2023 14:39:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 04/20] migration: file URI
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <1686163075-256597-1-git-send-email-steven.sistare@oracle.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1686163075-256597-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:806:21::30) To SJ0PR10MB4686.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4686:EE_|DS7PR10MB4942:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fef396d-0cca-4ab6-e897-08db67868da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRelSyP4NC1hzQqZIzA5kV3jLJJs/FBFAJXLEffaKzAO8jnSbG5u2kJRD3WO0V/b9BofncIPo0C4q10ZTdvg+Hdgui/7PoiBvIFXp+Uo8eIM4YlKtmLY443GYdqzjFVvHUwwd+27WnYfUv8Kh0TpfuSTJNmNAZBP34Z0nwxT3aSsU7BNzYfLWLspATr7gYXJ6WqSl46pjwPiSygEDQKblIDJC2kObSuG3xNWoGQElYjndl2d3AAJu7ef9yXlSG9gk3805pZcHI5z4iQ+keGh5DXF5yLYRqa+vp6C8yRxFCdeuYB0nZx4xnD2sbPz4+cZUrpUsPvSBgKGYBV/R6F2CmOHtJbC2zgq5l+/HNuE6++NTnUtYd8lKiZ/ylqiHhwk7cLWZCZYpRfseb+NAcLkz76H3TPslLVCOnJ6BVxNSIJFJsm758SZbKgoC5I5HaOQ1ro67HBXa3707R8njyKl9YNgKVBIdCT7W7qtIQzOKFnSPurxoDjUBHyn/Y8rzWVxxrWzgqPkEegOBj2/tdbREz419ZlkTkTEorXeLs4aTk8GiEwsgLan2V9O6g81ICjsx5jkykAaVjJgHN/c07vDUwFKUHE0yg0b4OCyXgYn8S2wOhriKsu5MrtWNkpE2mrx2+S6SlAyqFbVE9Sd+s2dsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4686.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199021)(36756003)(2906002)(31696002)(86362001)(5660300002)(44832011)(31686004)(6666004)(36916002)(6486002)(83380400001)(53546011)(6512007)(26005)(6506007)(478600001)(316002)(54906003)(66946007)(4326008)(38100700002)(41300700001)(2616005)(186003)(66556008)(66476007)(6916009)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkdlQnNrdkUwa0dRbXRRYlBuR3F5bnIrSTBHNU9vTmVEMzA4blRFVFBOdEg3?=
 =?utf-8?B?MGdvQ3FHTXlRVWJqblZaWEZoeFdiamFrQm1ycHB3WTlZVGprbzdDdThtYkI5?=
 =?utf-8?B?Y0szaEVrZ2libE1kM2RxdEUyNlIwQ3VzbjJJanNiaXRZa1FNQUNyeU9QUFJB?=
 =?utf-8?B?U2Y1WU9RMmNBam5vQTRWUzNtVHVPdFQwOXNnSm5vdVJVZmFNZnd6RUZ1NFZ4?=
 =?utf-8?B?elVsZ09zbGVPM05rSEZlUGFJb3RnMG4yNVBpc0pJbEQyTE1hek92Q1ZhRTRq?=
 =?utf-8?B?TnZPUHFMdHRBQ01JakY2TUE5UHBxWHJpdTJKUlV6OEtzVUdOdzJQbVVvbUFI?=
 =?utf-8?B?RytTdnlwaVdkcnNzSXRBOFpxRTFkVW5nU0k2WXAvZnZmMHdOOUwvbzFaRG9O?=
 =?utf-8?B?dy9Ba0FlR2gxTDF0TzgxelZlaE5nMVZJQ0JsVldMN0V6VXdYcmZLL0hoS2ll?=
 =?utf-8?B?NCtLRVY1OXBkSWdPVlhjL0dtT0tLeEgvREx4YkRQcFZaOGV4WGd0VTc2RzU3?=
 =?utf-8?B?Smw2dWtpbHFscGJ6WU9XbVJVZnd0b285Y09GUi9zUUtlVE1jSmU5Rk42VHN4?=
 =?utf-8?B?Wk1Ud2FzZkVVaUlwSWFaRDhzTzdRbEoyVDJQR3RZZFZjY2F6dVRzdFNFRy85?=
 =?utf-8?B?QkNJY3R3NHFERGJhazhMclFPaVlYRmc3c0JBQktEcjk0WWxEb3R0Rml1eUh5?=
 =?utf-8?B?M2YrV3lGVStRcFpEMnVUNXg3L3lhcmM4cDJ4M0VTUHlLbHo4d3dLUVo0VW9B?=
 =?utf-8?B?YnFWc1g5ZkFaOEJnTHdIUExOZnNIQ1JVR2xGK3hJNUcrQUt6SEhaVnVDTzVs?=
 =?utf-8?B?UGZ3aW0yamFVY0Rvak1pWGlLRkJFWlBjNk14bE5PV2FteXNGMGlnbG43Uko5?=
 =?utf-8?B?NFh3MVJHRC9ESkR0VUllYmlYK0xuWERnbDVSZGZEQXNvaWdKQ09oaXNQTnB2?=
 =?utf-8?B?QWQwVGlVM2M0U0wwbUFzcXJMdit6cXpFVlNQZWFCOHkrRzRkQ0VtMXlEOS8y?=
 =?utf-8?B?bURveDU1c1l1T0JIRW9XZE1OOUVBVTNCcCtzbTBaWThqeFJNbS9LZGFES09l?=
 =?utf-8?B?bTBlTmNZZS85T1Y5MW9KZkprWTBXVE9zMXJTN2RMbzB6blNCY0ZKWEJWYWti?=
 =?utf-8?B?QXJ1Y0FJT0ExaDFkc2ZQT0liVi9rUFdKWm1HMWRDa1JvdjhiZmV5MXBuNGVt?=
 =?utf-8?B?WmZwU1c1OVVjb0hzekoxQ3dkdTExVHBNN2ZRVjdrTVlJUmJleExjOXl5Skh4?=
 =?utf-8?B?U3BVc2M1ZGcrQkRudC9KRm9tRU9WbkFrVTY2bytmYi9TV2ZDOVR4ODlsVGt2?=
 =?utf-8?B?dlhZWWRnNFJHU01DaHozeE9GSXNNMFc0M3ppOGt2aEgrS1VYbStoUVUxbTg2?=
 =?utf-8?B?L1VzSTVONEJlRG1HT3ZYNlBLcTAzc3VlWG52U3J3TEFQU1RHdU5HbDlqbGMr?=
 =?utf-8?B?dVVjWGVsWUNiN3JxQkdIOGRjNUdMTjQ1QUIrQUhRengvTldpMUREN2ZWNW9k?=
 =?utf-8?B?U0VzeEUrZ3BYMjBTcUNYNTVaWktTZ3RYWXJNb3g5VWFUU1JmSzkxUFNhRE9m?=
 =?utf-8?B?RnI5NUpKbUFlcUtVV29IVDdmNVBaR2ZhOGpERzduV3dYcE1aT21heDNsQkF3?=
 =?utf-8?B?MHhKVkZzdWRYTFI0WVZCZ0lQcFgyb1RYdlFaTW9INUZVREVGZ1FTcUswZ0NU?=
 =?utf-8?B?SHdCeGtsYW90ZVRYTkpVU1VWSUhnZVFlNHFiYU9MeUtkUnFNMXo2bXNickpJ?=
 =?utf-8?B?RVJ4S0p5dFQ1Qm9BVHc2Z25LR2Y5Mmd0eUkxY1hSK2UwcEpaV1dPVTczbFRN?=
 =?utf-8?B?b3dlWTRLcHRleTE2a1hvZitiNUs2QlR6YjNNSm8zU3lKRXJWK1BiN2xiQTRy?=
 =?utf-8?B?Ujk2anI2YlVhWDd1MTBuS3M1NVN5d2F4ZEIwV1JsQ1FuL3B5endJQnVpZmRR?=
 =?utf-8?B?V2EzNHZtZHJRVEVCSzBncWdmZE5xSHVOTFB2NWVrYnVUbXhvNEpNMWs4UzNN?=
 =?utf-8?B?a2FlazNtSVFnWHFhb0RxUitrK3BiOU5HYTZrRGY5K2tiTyt6NmZaemltRXNN?=
 =?utf-8?B?ZXhCTUhLQ1NYOXcrQnFFWnp2OHJFZU5kSXd0NjM5UDdRNnBRWTU4QWJVZzZD?=
 =?utf-8?B?Qjl4ci9yMDkzZVdCSWc5RFlFb3FTUGNIMkYwcTE0MTFScldQaUdXUDIxT2Y0?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oQhDUWVePmuAcDS4YIzKv/+jQHYqdsOkVd8syPzEHeCG2jz/M7Uevn+oK+84ZKmDququI+MyxDF5pDSUaPjdGPf7MCxEd+or9r4Fvh4qM7FP0mcNFzTxKQTZ/17T8y/m9ehQuxNCOfAE4HmsfOS+C3BmKLSWSDcr6vtsNxoZb2oR48CjkAwaUy6itKbZEZiuRL1+cr22McHymGy/Y2KNOuwtw799U+qP3v0UQSdHcZVm2d17mwKJM4QidI/e8LnZzvg/7/HxmF0nz0FJualmj19NQtGeVaY8tZerF+9dvxrfW6T2XfI7EAQl1O51AWc/IDjP5tB2JDn4MacZqvGOntMFC08F5kuPYpbzhtihJVKCNK4ZM5W27xymfuxxDMhHG62Kp0etWKU0Onx2WZF0jAOu06QpbHP6ohRvbrYmDywOA7+WEIcjDpgmEpOEbltAdznQMxeAd+wJawt61XbbsIoNjcMp3TseVphYy76nxtwUmrGjgPCWokTLMhawrxBhqE5SvS6ILAtDwwgLI1pu9oqQnX6eMxO1WT+AIHTUvtXuzyie4c0mOO7oxYgf8a1VdQLPtwptvkezSdXgXI0S3uliZ/MCeyUUdNi0t/CyyyoX/aXg10WC887t7ymNz8tE2V9EfPY4HgpLMLp36uF66XMfHsvPE06ykRz1KVQlEEiN7+ASgvkvWAflytE32RsrORpBSR1GYdv6hfDFr5oha6wrmPWdWEFs0TgxpgllT9kvbdh2ut3+q3MhRL9SNK5Ui3SqUbPqTiBnCTp0xXrMq/uq1cvHj5xds1QwG5MBvfTBzaAkq5foJW1fSUuOln1A
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fef396d-0cca-4ab6-e897-08db67868da0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4686.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 18:39:40.3900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWWm1nRhAYOtYQDKRc37CHCI3fsgZEkTSeeX/ZZULHKK1jFTwcWUW2LA3jioqylPI+s/WhrY/mknRHIqRFd2XRdQDjxrLb9LXKN5x+zDBBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_10,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070161
X-Proofpoint-ORIG-GUID: M-pRKfcHhfpLITJASRzjlA8spVQ1wuXy
X-Proofpoint-GUID: M-pRKfcHhfpLITJASRzjlA8spVQ1wuXy
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Please ignore this, wrong subject line.  I will resend. - steve

On 6/7/2023 2:37 PM, Steve Sistare wrote:
> Extend the migration URI to support file:<filename>.  This can be used for
> any migration scenario that does not require a reverse path.  It can be used
> as an alternative to 'exec:cat > file' in minimized containers that do not
> contain /bin/sh, and it is easier to use than the fd:<fdname> URI.  It can
> be used in HMP commands, and as a qemu command-line parameter.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  migration/file.c       | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  migration/file.h       | 14 ++++++++++++
>  migration/meson.build  |  1 +
>  migration/migration.c  |  5 ++++
>  migration/trace-events |  4 ++++
>  qemu-options.hx        |  6 ++++-
>  6 files changed, 91 insertions(+), 1 deletion(-)
>  create mode 100644 migration/file.c
>  create mode 100644 migration/file.h
> 
> diff --git a/migration/file.c b/migration/file.c
> new file mode 100644
> index 0000000..8e35827
> --- /dev/null
> +++ b/migration/file.c
> @@ -0,0 +1,62 @@
> +/*
> + * Copyright (c) 2021-2023 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "channel.h"
> +#include "file.h"
> +#include "migration.h"
> +#include "io/channel-file.h"
> +#include "io/channel-util.h"
> +#include "trace.h"
> +
> +void file_start_outgoing_migration(MigrationState *s, const char *filename,
> +                                   Error **errp)
> +{
> +    g_autoptr(QIOChannelFile) fioc = NULL;
> +    QIOChannel *ioc;
> +
> +    trace_migration_file_outgoing(filename);
> +
> +    fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC,
> +                                     0600, errp);
> +    if (!fioc) {
> +        return;
> +    }
> +
> +    ioc = QIO_CHANNEL(fioc);
> +    qio_channel_set_name(ioc, "migration-file-outgoing");
> +    migration_channel_connect(s, ioc, NULL, NULL);
> +}
> +
> +static gboolean file_accept_incoming_migration(QIOChannel *ioc,
> +                                               GIOCondition condition,
> +                                               gpointer opaque)
> +{
> +    migration_channel_process_incoming(ioc);
> +    object_unref(OBJECT(ioc));
> +    return G_SOURCE_REMOVE;
> +}
> +
> +void file_start_incoming_migration(const char *filename, Error **errp)
> +{
> +    QIOChannelFile *fioc = NULL;
> +    QIOChannel *ioc;
> +
> +    trace_migration_file_incoming(filename);
> +
> +    fioc = qio_channel_file_new_path(filename, O_RDONLY, 0, errp);
> +    if (!fioc) {
> +        return;
> +    }
> +
> +    ioc = QIO_CHANNEL(fioc);
> +    qio_channel_set_name(QIO_CHANNEL(ioc), "migration-file-incoming");
> +    qio_channel_add_watch_full(ioc, G_IO_IN,
> +                               file_accept_incoming_migration,
> +                               NULL, NULL,
> +                               g_main_context_get_thread_default());
> +}
> diff --git a/migration/file.h b/migration/file.h
> new file mode 100644
> index 0000000..841b94a
> --- /dev/null
> +++ b/migration/file.h
> @@ -0,0 +1,14 @@
> +/*
> + * Copyright (c) 2021-2023 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QEMU_MIGRATION_FILE_H
> +#define QEMU_MIGRATION_FILE_H
> +void file_start_incoming_migration(const char *filename, Error **errp);
> +
> +void file_start_outgoing_migration(MigrationState *s, const char *filename,
> +                                   Error **errp);
> +#endif
> diff --git a/migration/meson.build b/migration/meson.build
> index 8ba6e42..3af817e 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -16,6 +16,7 @@ softmmu_ss.add(files(
>    'dirtyrate.c',
>    'exec.c',
>    'fd.c',
> +  'file.c',
>    'global_state.c',
>    'migration-hmp-cmds.c',
>    'migration.c',
> diff --git a/migration/migration.c b/migration/migration.c
> index dc05c6f..cfbde86 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -20,6 +20,7 @@
>  #include "migration/blocker.h"
>  #include "exec.h"
>  #include "fd.h"
> +#include "file.h"
>  #include "socket.h"
>  #include "sysemu/runstate.h"
>  #include "sysemu/sysemu.h"
> @@ -442,6 +443,8 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
>          exec_start_incoming_migration(p, errp);
>      } else if (strstart(uri, "fd:", &p)) {
>          fd_start_incoming_migration(p, errp);
> +    } else if (strstart(uri, "file:", &p)) {
> +        file_start_incoming_migration(p, errp);
>      } else {
>          error_setg(errp, "unknown migration protocol: %s", uri);
>      }
> @@ -1662,6 +1665,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>          exec_start_outgoing_migration(s, p, &local_err);
>      } else if (strstart(uri, "fd:", &p)) {
>          fd_start_outgoing_migration(s, p, &local_err);
> +    } else if (strstart(uri, "file:", &p)) {
> +        file_start_outgoing_migration(s, p, &local_err);
>      } else {
>          if (!(has_resume && resume)) {
>              yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> diff --git a/migration/trace-events b/migration/trace-events
> index cdaef7a..c8c1771 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -307,6 +307,10 @@ migration_exec_incoming(const char *cmd) "cmd=%s"
>  migration_fd_outgoing(int fd) "fd=%d"
>  migration_fd_incoming(int fd) "fd=%d"
>  
> +# file.c
> +migration_file_outgoing(const char *filename) "filename=%s"
> +migration_file_incoming(const char *filename) "filename=%s"
> +
>  # socket.c
>  migration_socket_incoming_accepted(void) ""
>  migration_socket_outgoing_connected(const char *hostname) "hostname=%s"
> diff --git a/qemu-options.hx b/qemu-options.hx
> index b37eb96..b93449d 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4610,6 +4610,7 @@ DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
>      "                prepare for incoming migration, listen on\n" \
>      "                specified protocol and socket address\n" \
>      "-incoming fd:fd\n" \
> +    "-incoming file:filename\n" \
>      "-incoming exec:cmdline\n" \
>      "                accept incoming migration on given file descriptor\n" \
>      "                or from given external command\n" \
> @@ -4626,7 +4627,10 @@ SRST
>      Prepare for incoming migration, listen on a given unix socket.
>  
>  ``-incoming fd:fd``
> -    Accept incoming migration from a given filedescriptor.
> +    Accept incoming migration from a given file descriptor.
> +
> +``-incoming file:filename``
> +    Accept incoming migration from a given file.
>  
>  ``-incoming exec:cmdline``
>      Accept incoming migration as an output from specified external

