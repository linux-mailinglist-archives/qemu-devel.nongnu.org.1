Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D69B67E2F15
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 22:39:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r07Im-00019m-Qt; Mon, 06 Nov 2023 16:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1r07Ij-00017v-Jo
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 16:38:29 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1r07If-0001Tn-9z
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 16:38:29 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A6Fkjet006214; Mon, 6 Nov 2023 21:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=D3HcVXkb6EDG5ODcKV7vKMR2avRnubW3YIB8cDntTxU=;
 b=NNAMG2algcBywTLE/lblF9QnvD9D+hWhUGnf7YkRXR3EwMSqLuHvEN5BhQtHh0LaEXx4
 iNuZP2G3vkBSUZ5VSH1GElsmM2lwCETOdgkF/onUowgTGsAllj96HJUDS2o7HnNI71fH
 ADefBbN43Hl7sSVmBYO3InAyJ3PdBP/lhnCuxcaSo7aN7a1ytQ3aB+CQgHDTSFNO2D6K
 fsqLMq7aoCEgdsi/xQzS53OxZHvEVpgCJX/QcKp2WeAPicMSEyLjh1LoZetI3S/V7xpV
 45hWCncqmR6pDaAfMw1bXvp/A9ujLduPqLt7SoOKUAXJJfWXWNeEZ/bNQ85JYRfk6x58 Yg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u5cvccftn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Nov 2023 21:38:19 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A6KNg1C024778; Mon, 6 Nov 2023 21:38:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3u5cdc9trd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Nov 2023 21:38:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQht+R8ZtMDsXyjmatp2saHq54Dbb03xnJygY8PddCrJPpIvgnKmbZRFVKlZEV90GZs0abLdD3bj98ztT2s//ELOcMayPsSB414VShasaQYXGNTUK3z9w9oE9Sw3qjFeZTSBpf+V+1xpCkTemjTZTxLS15FwaAaXEfBrWKwxuJQdVyvfBNKxXO8SeWrZ/lY0VwSgeYMkC1Tfac24oryQwwhZke9M9nRVsAyvc18tkPLVMjy3wPwpb/ww5EYQs/7I+4AOXQDx+BzcBdgc580/KZryYdbmyAl1/XmtivtTSmsAaYhgeDZfvQYxBLXVeEE+4PA6mFHSMQbU6zE9Ar/KTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3HcVXkb6EDG5ODcKV7vKMR2avRnubW3YIB8cDntTxU=;
 b=LDEy0+jee4KxeWACnfU9bXOCS4/IEXBTyHTRaiGwVG3rjZY7E55PvwxTyRjpbEwvhLiHLxjnz+amGsJzvkpV7AS5yykEAyRjpzYrUCV1FyhdoWnK+RM0WNAOWe2ZuYbtEL2cSlj8TO3X8tpkEre2Pup/f94N/xvRSlqRofFN26VLyo3NQuof277TSKf/Ncr9KmirCE33QERqOA5y5PIKm5Vk0l7gvXlkullsEHKMx/tL9slUBCVzNqYNbJMCuoZ1QF3HHeiEDlEi/Y8TeXkFwZArc1iiM+Kbuc5JcFxf2ej+b9/AfYLgyKnC4pm/A+bExqpPKHHDOWaCBmXW0PKKCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3HcVXkb6EDG5ODcKV7vKMR2avRnubW3YIB8cDntTxU=;
 b=RdlhOemHe2YDKU5sWnjMiv0L6zSqSfKCB7aIaOdxuVQTf2OFSL3x6h+5xqq4C4fGlFqDPZo8sjn7I/KP6bLWqvWBrlI4BaGJvVAHNIPbj8pcIIinAImzRHaW8FRXe0XUHV7t9DZulhsLYLapS4NCVXbnrfRkXIVBFAg8Z96zahI=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by PH0PR10MB4631.namprd10.prod.outlook.com (2603:10b6:510:41::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 21:38:15 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::a7ee:d2c9:c03e:6ec2]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::a7ee:d2c9:c03e:6ec2%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 21:38:15 +0000
Content-Type: multipart/alternative;
 boundary="------------wH2OG0nE5QlLN0vzQHS04W80"
Message-ID: <d0c6b2b9-ab95-4b29-969a-85edcac3f8af@oracle.com>
Date: Mon, 6 Nov 2023 22:38:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] migration: prevent migration when a poisoned page
 is unknown from the VM
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, lizhijian@fujitsu.com, pbonzini@redhat.com,
 quintela@redhat.com, leobras@redhat.com, joao.m.martins@oracle.com,
 lidongchen@tencent.com
References: <20230920235301.1622672-1-william.roche@oracle.com>
 <20231013150839.867164-1-william.roche@oracle.com>
 <20231013150839.867164-3-william.roche@oracle.com> <ZS1pSeL3hj4/73lk@x1n>
 <c0af41b7-56dd-4395-8c79-d630ece3b589@oracle.com> <ZS6ksf8o7dJ8mzUe@x1n>
From: William Roche <william.roche@oracle.com>
In-Reply-To: <ZS6ksf8o7dJ8mzUe@x1n>
X-ClientProxiedBy: LO6P265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::9) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|PH0PR10MB4631:EE_
X-MS-Office365-Filtering-Correlation-Id: 5330921e-9534-47bb-134d-08dbdf10aed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6iERCiMW3HhyVEl869MJAgEVs76OKK5KILwG/BDgcfWo04Am8QdKLBOactGvurbuD1w2TY9MiD7Gi+3KpYmNhtVaTFMKw36j/ty7Acqc8cGNpjXnW7lFnB4acXaA7ID/FpyNunrLu3XbMCg8asW5aClxtrWEeXVlj/VXH5cyRrPzisaFJGVTkiIrj/tb76DkZl0q324IfPUuFu6F65RGk9xGuebWIU2dRhlNh/I2qB9BuzBWmFyxo+0hjV1R6x7J2CxW4ljXR2DYNPjVrRVNZO1sYQVwfGKGRmFJ0GDvkqDzANZiMwk6962hFqAby7kTuhT//Ed4MP+hbuy1DxZEJM5bf59OlVdZ93Mb9BzxcXyzCtxc/eOKa3k4onlVQzT/MHpQluagBIvXUB43vVIMGPoTHobLzqk0zr7ofWlCantMJXS3wrTKtl0BAi+0KSvFnS/svRM8qOaC41bCfeIDuNoGHnyYENV94qvT/tywLjeR/NA4T8L1o9AxjoHHISBM9iBEwaue2wnWu19aISg8+9DjDaGa4p7WxBMZFTB5Hgw/3OKtcGfmRuOxynKzE+faJzRm/4AcL3QwtGglZXHDfkwUv1tvRfY4I+mqCL//aFewHqNkyOMxdRe6jy+7yJOkxMLH5TW14SSJIxWRe5gqKW4sdbTAK/P3SjK7fiJaJJfO32hgB0UKsR8+ySoQgRBW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(40265005)(33964004)(6506007)(53546011)(83380400001)(31686004)(166002)(6512007)(66899024)(2616005)(86362001)(41300700001)(30864003)(2906002)(966005)(31696002)(4326008)(5660300002)(36756003)(8676002)(8936002)(66946007)(44832011)(66476007)(66556008)(6916009)(316002)(26005)(478600001)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDI4YWxDN1NnaFRPMnFweTFCQ1lRenlNaU9Mc2VhOEJUVE56SjRnWnhCN1hT?=
 =?utf-8?B?c01mNHRuNnY3ZVhnWjNWUDdlSzJYQitQaDZYamd1cFlJVnFPazlsY2ZEU3gv?=
 =?utf-8?B?N3FUSWU0aGhlSVR0Umh4SUx0NmlXRmU4U21WdndMc091VW9tYVJjU0tPYlRh?=
 =?utf-8?B?aGpxRWhZakVyMW1mL3RCTzdBL1lndFMramE5dGJyWitqZlpGb2JyS2dGNGoz?=
 =?utf-8?B?dUErSEFaT1VhYllpRlhiWVZLaWtnR0VmcTRsM1o5ckZyS3NZRG1zbGRvY3BE?=
 =?utf-8?B?UHZpclkvRWtaME9HYWlkUDAvN2VRRkN2OUY4MC9BaUtvU3Q5clh3S2ZzdWEz?=
 =?utf-8?B?TE9iSWJ2UEI0cE1KM1l2bHZLWVA5YVFwZVRhUkpJcjdKZDU3T0ZoSytjL3p5?=
 =?utf-8?B?cUwvK3BKMHhhR0h2V3VTZkgrTGY2cnh0M1I0MVdIOFdOWFBlUnVXd1dJd09K?=
 =?utf-8?B?QkxKUGYzUTVsZ1lWbDM5WTdLRXIvTFQ3L1djMFdWVlhFbXM4WWZSUHJuRkxn?=
 =?utf-8?B?dlFjYld1Z3VCNHhtQ3dsQ1d6ZmdUSkE3YXRUNGphcVRLcmZQM0p5eTM2YVZu?=
 =?utf-8?B?bEc1VXZRMDQ3MlhBdUVRT2pDVXY4dHd6L2xVUUpvZGNML21hQ1JNdHVsVTJ1?=
 =?utf-8?B?Um95VnBtejczTDNLWFdlMlkrWnI2aEwxVkdEbEFLRVNoSXpnbTE4NFZyc0VG?=
 =?utf-8?B?Mit0cnRmUURlRmsyNHQya2xiSXFuMWFVY0VUMG4yNk0vS2hxL1o2eEdRY2JO?=
 =?utf-8?B?MGk5bjNzc2U5NFJxYzJVL2xMcDM3V0J6amdDZHpuaFZiWXB1bGVtZzcwdDBP?=
 =?utf-8?B?VzNQT1FvdDArNVVXSjNpdkowL3BudXJDQ2RMTmdJR29YekwvSWRjRjBuNllM?=
 =?utf-8?B?QlhkcHJOazdpZlFuR3N4dmp2bFRJYkc2OWRtT2VtS05IMXlSdVA4a1gwOHE0?=
 =?utf-8?B?bFdTbnVmWDlXZ3d1THFVT0QyeVRvMFNVNThnc3FNbEVTbytqbDl1WDhJN01G?=
 =?utf-8?B?c1pUUzIrYTNHOThMQkVKTUM0U0lVZlZtQXFPUFFLdWNSVUVvWVYrb2ZMOTNY?=
 =?utf-8?B?SVJkZld4YVYrOVZFK2JCKzMrNCtLbDhaa09tNU1UcDlPbys2dkdoZ2w3Sndy?=
 =?utf-8?B?bGJ2eTQ0UFlyaEt2MGkzUG5MMHRLQVB2UlNSemwrQkMvRkJwODdkMzArbEUx?=
 =?utf-8?B?QlJrd1V4ZlhPOTNQdEhyTnhicDFPTm1VcDI4em5FbTBISFUyWllMZ0lnWk1F?=
 =?utf-8?B?bjhrajdNRkU4VkszQ2VaNUpKK1d3d0VWRHJJZFB6V05kdW9HbEkwNzZzV0tD?=
 =?utf-8?B?bHlwZDFMempPT3F0U1lxV3h0ZGhFM1NkcEIrcm1Vdy9KaFFVUUxSNm9hdU5T?=
 =?utf-8?B?N1l1eTRlUEVsOEdPcUJhTVhLWFJNM1pVVzg3RnJDQ0Zwd093cFIrWllycGZS?=
 =?utf-8?B?bGE1UUd3c3RMdDRCTGpmdlZPeGFzN24waXJMMmpWSnhmNm5MZ0Z4WEVkbE1E?=
 =?utf-8?B?TVYxMThZM2NMQTk2WmIxRWJUK21JNnB6cXlaSjVpZkVDbEVZY2NiS0VsWFJD?=
 =?utf-8?B?dTJpOS9abEZVUkxUREN5bjlUekswZjV6RGxMTVIzT2dQUktoYm9YL0Q2K1Br?=
 =?utf-8?B?VUcwSm9EVjJkWW5teE9mOUxIbzkvaWs3YjZKZGhCN1IrYWJhRDVNVnc3enZG?=
 =?utf-8?B?WGE5RGdUbnlxOUQ5ck1PTkJzRzltNVpyOUdyRVk2aldrUUhIamFTUUJmL3ZB?=
 =?utf-8?B?QVE1cllzNHYyQmJzbUxLZEw3QjJjaW5ENjIxQldpblRwMjI0ZWxaT01nOEll?=
 =?utf-8?B?RXdnWkxBckZ0QUdKQ09NR3AwSXp3T2VBM0xML0xEVTE2aitTR0ZPdlhnWnN3?=
 =?utf-8?B?ZlZROUs4a0cwOC9vVnN0dFdQSmJoZ2lPb081Umk3YXcvaG00TEpwakhtK2ty?=
 =?utf-8?B?VGdySUpvM1o5aXlUL1FLOTFYTE9zd3JZNEtmZU1zdU1aelZoVmJRMlVmYmJR?=
 =?utf-8?B?K2lRL0dmbllaQkRLMDZmaHF6Y25GRDlnQXRWR29sM1gyekcyd0lud3FiTmFi?=
 =?utf-8?B?UktrZTdJb296YllvOWJ5N2R5Vzl5Nnh0ZVBQU1lHY2pEZkxxempDaHVHYjg5?=
 =?utf-8?B?Z2pOMXhoZHRjR0xRN2swNGRUcVVPbm93U0NSMU9mTnlEZVEyaWg1Z0hIZXhw?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aylZoV3vF7V3GSVsk9LXesepxGtZj23Y2nErnhFHzZ5zmfPJADwCXnC8OlFoqDNhBi0uRvann4XqOm+3zAZb/HhLjfaCRfjYfIO04tROsKfrAhkh36U+RiyfVfclbe3x66OTNuWvPHkRntlKdBTzzOy+A5to+TyVIaFTVvrbZbgRyOxkdiSfXjnGtqRHBLLtmuwAwSKQIpuDP+XNqXDj6UwJhUgFv7KNMaFUuHzb2/79pppG93ho6adV2NozUVVXFNkT4fPGq1yOftV4OmOg7j8vmQ+Z8s97ZWylCeTlkxzbhibQSsXjKwhp+g51b/F++tlTbvPYenC+96HioTezo7czyC7E41PrvLj5VQuBpijIhAnYVYqO3ejZgRSJFP4990ettvreksbMQAcAguuzRJrUyvFGBrUfRH6D0cKV28/VSwSIvmR5ZXZSTh2tKAG+Ah7mk8yZRJBeE1IDhphlk6DLeDcYifRJ+VO/OvKEYhc/iakAJN0LdtWOfLnEX4Ne6odoG79fLdZ99s+a5b+fmG4AlA27PrcOgdeSKZmgLKWzVApjXfSr+L4eYVMFws4FrU5FXuoZJtvsoqOQiyM+Qk5bwd3K5WqNHgXgS+Kb/PW8PSBix+on0MYE+m5Gr1S+lawPshmws8YSUK7HNz4Tsdu9KI0nZXkHHqjtWbO14jh4bsUoIph2kBdX2+vTUbgT5LlzXtU7/KeEjykAKOQ7uersV6xPy3cIE2rBiETVeIh6CuKz+wMHHT/lHDyAgcTrwBJApe1devBCqzOqXsjrpYVwd+0vipwicTO+8GRXNKhR3Cupw7bwEdgzbLoYJIuBflkZR7vq5+OKPG5U26ioMQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5330921e-9534-47bb-134d-08dbdf10aed3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 21:38:14.9557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTTX7+KYYS/QS6tPbpDc8+S2vLTswbn2ZUrZabqZLkqTCvawSu0YMWAB8swc0egnSPGypBU+HHc68lalpmfc6tJecf4W2Tl9ayr1kGZEoYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4631
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060177
X-Proofpoint-GUID: ibRHFBq_scfEKqgdVbe-JX25Dl2t7zna
X-Proofpoint-ORIG-GUID: ibRHFBq_scfEKqgdVbe-JX25Dl2t7zna
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--------------wH2OG0nE5QlLN0vzQHS04W80
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/17/23 17:13, Peter Xu wrote:

> On Tue, Oct 17, 2023 at 02:38:48AM +0200, William Roche wrote:
>> On 10/16/23 18:48, Peter Xu wrote:
>>> On Fri, Oct 13, 2023 at 03:08:39PM +0000, “William Roche wrote:
>>>> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
>>>> index 5e95c496bb..e8db6380c1 100644
>>>> --- a/target/arm/kvm64.c
>>>> +++ b/target/arm/kvm64.c
>>>> @@ -1158,7 +1158,6 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>>>            ram_addr = qemu_ram_addr_from_host(addr);
>>>>            if (ram_addr != RAM_ADDR_INVALID &&
>>>>                kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
>>>> -            kvm_hwpoison_page_add(ram_addr);
>>>>                /*
>>>>                 * If this is a BUS_MCEERR_AR, we know we have been called
>>>>                 * synchronously from the vCPU thread, so we can easily
>>>> @@ -1169,7 +1168,12 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>>>                 * called synchronously from the vCPU thread, or a bit
>>>>                 * later from the main thread, so doing the injection of
>>>>                 * the error would be more complicated.
>>>> +             * In this case, BUS_MCEERR_AO errors are unknown from the
>>>> +             * guest, and we will prevent migration as long as this
>>>> +             * poisoned page hasn't generated a BUS_MCEERR_AR error
>>>> +             * that the guest takes into account.
>>>>                 */
>>>> +            kvm_hwpoison_page_add(ram_addr, (code == BUS_MCEERR_AR));
>>> I'm curious why ARM doesn't forward this event to guest even if it's AO.
>>> X86 does it, and makes more sense to me.
>> I agree that forwarding this error is the best option to implement.
>> But an important note about this aspect  is that only Intel architecture
>> handles the AO error forwarding correctly; currently an AMD VM crashes
>> when an AO error relay is attempted.
>>
>> That's why we've submitted the following kvm patch:
>> https://lore.kernel.org/all/20230912211824.90952-3-john.allen@amd.com/
>> Among other AMD enhancements to better deal with MCE relay.
> I see.
>
>>
>>>   Not familiar with arm, do you
>>> know the reason?
>> I can't answer this question as I don't know anything about the specific
>> 'complications' mentioned in the comment above. Maybe something around
>> the injection through ACPI GHES and its interrupt mechanism ??
>> But note also that ignoring AO errors is just a question of relying on
>> the Hypervisor kernel to generate an AR error when the asynchronously
>> poisoned page is touched later. Which can be acceptable -- when the
>> system guaranties the AR fault on the page.
>>
>>> I think this patch needs review from ARM and/or KVM side.  Do you want to
>>> have the 1st patch merged, or rather wait for the whole set?
>> I think that integrating the first patch alone is not an option
>> as we would introduce the silent data corruption possibility I
>> described.
> I asked because I think patch 1 itself is still an improvement, which
> avoids src VM from crashing when hitting poisoned pages.  Especially IIUC
> on some arch (Intel?) it's a complete fix.

Yes, this is almost true: According to me this fix would be a transitional
solution - a small change of the code to allow a VM live migration after a
memory error. This change would be only needed on the source machine, and
no necessary change on the destination machine.
But let me just repeat that this fix relies on trusting the VM kernel to
correctly deal with memory errors it knows about to avoid a memory
corruption!

Note also that large pages are taken into account too for our live 
migration,
but the poisoning of a qemu large page requires more work especially for VM
using standard 4k pages on top of these qemu large pages -- and this is a
completely different issue. I'm mentioning this aspect here because even on
Intel platforms, underlying large pages poisoning needs to be reported 
better
to the running VM as a large section of its memory is gone (not just a 
single
head 4k page), and adding live migration to this problem will not make 
things
any better...

> But for sure we can keep them as a whole series if you want, but then it'll
> be good you add some more reviewers; at least some ARM/AMD developers,
> perhaps.

I'll add qemu-arm@nongnu.org to the CC list for the updated version I'm
going to send.
Giving a word about the ARM specificity of the second patch.

>> It would be better to integrate the two of them as a whole
>> set. But the use of the kernel feature you indicated me can change all
>> of that !
>>
>>> Another thing to mention: feel free to look at a recent addition of ioctl
>>> from userfault, where it can inject poisoned ptes:
>>>
>>> https://lore.kernel.org/r/20230707215540.2324998-1-axelrasmussen@google.com
>>>
>>> I'm wondering if that'll be helpful to qemu too, where we can migrate
>>> hwpoison_page_list and enforce the poisoning on dest.  Then even for AO
>>> when accessed by guest it'll generated another MCE on dest.
>> I could be missing something, but Yes, this is exactly how I understand
>> this kernel feature use case with its description in:
>> https://lore.kernel.org/all/20230707215540.2324998-5-axelrasmussen@google.com/
>>
>>   vvvvvv
>> So the basic way to use this new feature is:
>>
>> - On the new host, the guest's memory is registered with userfaultfd, in
>>    either MISSING or MINOR mode (doesn't really matter for this purpose).
>> - On any first access, we get a userfaultfd event. At this point we can
>>    communicate with the old host to find out if the page was poisoned.
>> - If so, we can respond with a UFFDIO_POISON - this places a swap marker
>>    so any future accesses will SIGBUS. Because the pte is now "present",
>>    future accesses won't generate more userfaultfd events, they'll just
>>    SIGBUS directly.
>>   ^^^^^^
>>
>> Thank you for letting me know about this kernel functionality.
>>
>> I need to take some time to investigate it, to see how I could use it.
> One more hint, please double check though: in QEMU's use case (e.g. precopy
> only, while not using postcopy) I think you may even be able to install the
> poisoned pte without MISSING (or any other uffd) mode registered.
>
> You can try creating one uffd descriptor (which will bind the desc with the
> current mm context; in this case we need it to happen only on dest qemu),
> then try injecting poison ptes anywhere in the guest address ranges.
I did that in a self content test program: memory allocation, 
UFFDIO_REGISTER
and use of UFFDIO_POISON.
The register mode has to be given but MISSING or WP both works. This gives
the possibility to inject poison in a much easier and better way than using
madvise(... MADV_HWPOISON, ...) for example.

But it implies a lot of other changes:
     - The source has to flag the error pages to indicate a poison
       (new flag in the exchange protocole)
     - The destination has to be able to deal with the new protocole
     - The destination has to be able to mark the pages as poisoned
       (authorized to use userfaultfd)
     - So both source and destination have to be upgraded (of course
       qemu but also an appropriate kernel version providing
       UFFDIO_POISON on the destination)
     - we may need to be able to negotiate a fall back solution
     - an indication of the method to use could belong to the
       migration capabilities and parameters
     - etc...

>> The solution I'm suggesting here doesn't cover as many cases as the
>> UFFDIO_POISON use could help to implement.
>> But it gives us a possibility to live migrate VMs that already
>> experienced memory errors, trusting the VM kernel to correctly deal with
>> these past errors.
>>
>> AFAIK, currently, a standard qemu VM that has experienced a memory error
>> can't be live migrated at all.
> I suppose here you meant AO errors only.
No, if any of the memory used by a VM has been impacted by a memory error
(either with BUS_MCEERR_AO or BUS_MCEERR_AR) this memory isn't accessible
anymore, and the live migration (whatever mechanism used) can't read the
content of the impacted location. So AFAIK any mechanism used currently
doesn't work.
When we have such an error, either the migration fails (like RDMA currently
does) or it completely crashes qemu when the migration is attempted.

> IIUC the major issue regarding migration is AO errors will become ARs on
> src qemu when vcpu accessed,
This is correct.

>   which means AOs are all fine if not forwarded
> to guest.
You are right in the case where the VM stays on the source machine.
With my current proposed fix we don't forward poison to the destination
machine, so the problem is not to be able to access the content of
these Uncorrected Error memory locations -- which means that if this
content is needed we have to inform the requester that the data is
inaccessible -- that's what the poison is for, and we count on the
running VM kernel to enforce the poisoning.

And if the AO error hasn't been reported to the VM running Kernel,
we either must forward the poison to the destination machine or
prevent the live migration. (That's what the second patch does for
the platform ignoring the AO errors - currently only ARM)

>    However after migration that is not guaranteed.  Poisoned ptes
> properly installed on dest basically grants QEMU the ability to "migrate a
> poisoned page", meanwhile without really wasting a physical page on dest,
> making sure those AO error addrs keep generating ARs even after migration.
Absolutely, this is the huge advantage of such a solution.

> It seems the 1st patch is still needed even in this case?
If we can transfer a poison to the destination machine, there is no
need for the 1st patch (transforming poisoned pages into zero pages).
That's the reason why I do think that enhancing both the source qemu
and the destination qemu to deal with poisoned pages is the real
(long term) fix.
In the meantime, we could use this current small set of 2 patches to
avoid the qemu crashes on live migration after a memory fault.

I hope this clarifies the situation, and the reason why I'd prefer
the two patches to be integrated together.

I've updated the code to the latest source tree (resolving conflicts
with 8697eb857769 and 72a8192e225c) and I'm sending a v5 with this
update. Adapting the commit message to reflect the new stack trace
on crash.
I also re-ran my migration tests, with and without compression,
on ARM and x86 platforms.

I hope this can help.


--------------wH2OG0nE5QlLN0vzQHS04W80
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>On 10/17/23 17:13, Peter Xu wrote:</p>
    <blockquote type="cite" cite="mid:ZS6ksf8o7dJ8mzUe@x1n">
      <pre class="moz-quote-pre" wrap="">On Tue, Oct 17, 2023 at 02:38:48AM +0200, William Roche wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 10/16/23 18:48, Peter Xu wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On Fri, Oct 13, 2023 at 03:08:39PM +0000, “William Roche wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 5e95c496bb..e8db6380c1 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -1158,7 +1158,6 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
          ram_addr = qemu_ram_addr_from_host(addr);
          if (ram_addr != RAM_ADDR_INVALID &amp;&amp;
              kvm_physical_memory_addr_from_host(c-&gt;kvm_state, addr, &amp;paddr)) {
-            kvm_hwpoison_page_add(ram_addr);
              /*
               * If this is a BUS_MCEERR_AR, we know we have been called
               * synchronously from the vCPU thread, so we can easily
@@ -1169,7 +1168,12 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
               * called synchronously from the vCPU thread, or a bit
               * later from the main thread, so doing the injection of
               * the error would be more complicated.
+             * In this case, BUS_MCEERR_AO errors are unknown from the
+             * guest, and we will prevent migration as long as this
+             * poisoned page hasn't generated a BUS_MCEERR_AR error
+             * that the guest takes into account.
               */
+            kvm_hwpoison_page_add(ram_addr, (code == BUS_MCEERR_AR));
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">
I'm curious why ARM doesn't forward this event to guest even if it's AO.
X86 does it, and makes more sense to me.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
I agree that forwarding this error is the best option to implement.
But an important note about this aspect  is that only Intel architecture
handles the AO error forwarding correctly; currently an AMD VM crashes
when an AO error relay is attempted.

That's why we've submitted the following kvm patch:
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20230912211824.90952-3-john.allen@amd.com/">https://lore.kernel.org/all/20230912211824.90952-3-john.allen@amd.com/</a>
Among other AMD enhancements to better deal with MCE relay.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I see.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap=""> Not familiar with arm, do you
know the reason?
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
I can't answer this question as I don't know anything about the specific
'complications' mentioned in the comment above. Maybe something around
the injection through ACPI GHES and its interrupt mechanism ??
But note also that ignoring AO errors is just a question of relying on
the Hypervisor kernel to generate an AR error when the asynchronously
poisoned page is touched later. Which can be acceptable -- when the
system guaranties the AR fault on the page.

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
I think this patch needs review from ARM and/or KVM side.  Do you want to
have the 1st patch merged, or rather wait for the whole set?
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
I think that integrating the first patch alone is not an option
as we would introduce the silent data corruption possibility I
described.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I asked because I think patch 1 itself is still an improvement, which
avoids src VM from crashing when hitting poisoned pages.  Especially IIUC
on some arch (Intel?) it's a complete fix.</pre>
    </blockquote>
    <p><font face="monospace">Yes, this is almost true: According to me
        this fix would be a transitional<br>
        solution - a small change of the code to allow a VM live
        migration after a<br>
        memory error. This change would be only needed on the source
        machine, and<br>
        no necessary change on the destination machine.<br>
        But let me just repeat that this fix relies on trusting the VM
        kernel to<br>
        correctly deal with memory errors it knows about to avoid a
        memory<br>
        corruption!</font></p>
    <p><font face="monospace">Note also that large pages are taken into
        account too for our live migration,<br>
        but the poisoning of a qemu large page requires more work
        especially for VM<br>
        using standard 4k pages on top of these qemu large pages -- and
        this is a<br>
        completely different issue. I'm mentioning this aspect here
        because even on<br>
        Intel platforms, underlying large pages poisoning needs to be
        reported better<br>
        to the running VM as a large section of its memory is gone (not
        just a single<br>
        head 4k page), and adding live migration to this problem will
        not make things<br>
        any better...</font><br>
    </p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:ZS6ksf8o7dJ8mzUe@x1n">
      <pre class="moz-quote-pre" wrap="">But for sure we can keep them as a whole series if you want, but then it'll
be good you add some more reviewers; at least some ARM/AMD developers,
perhaps.</pre>
    </blockquote>
    <p><font face="monospace">I'll add <a class="moz-txt-link-abbreviated" href="mailto:qemu-arm@nongnu.org">qemu-arm@nongnu.org</a> to the CC
        list for the updated version I'm<br>
        going to send.<br>
        Giving a word about the ARM specificity of the second patch.</font><br>
    </p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:ZS6ksf8o7dJ8mzUe@x1n">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">It would be better to integrate the two of them as a whole
set. But the use of the kernel feature you indicated me can change all
of that !

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
Another thing to mention: feel free to look at a recent addition of ioctl
from userfault, where it can inject poisoned ptes:

<a class="moz-txt-link-freetext" href="https://lore.kernel.org/r/20230707215540.2324998-1-axelrasmussen@google.com">https://lore.kernel.org/r/20230707215540.2324998-1-axelrasmussen@google.com</a>

I'm wondering if that'll be helpful to qemu too, where we can migrate
hwpoison_page_list and enforce the poisoning on dest.  Then even for AO
when accessed by guest it'll generated another MCE on dest.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
I could be missing something, but Yes, this is exactly how I understand
this kernel feature use case with its description in:
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20230707215540.2324998-5-axelrasmussen@google.com/">https://lore.kernel.org/all/20230707215540.2324998-5-axelrasmussen@google.com/</a>

 vvvvvv
So the basic way to use this new feature is:

- On the new host, the guest's memory is registered with userfaultfd, in
  either MISSING or MINOR mode (doesn't really matter for this purpose).
- On any first access, we get a userfaultfd event. At this point we can
  communicate with the old host to find out if the page was poisoned.
- If so, we can respond with a UFFDIO_POISON - this places a swap marker
  so any future accesses will SIGBUS. Because the pte is now &quot;present&quot;,
  future accesses won't generate more userfaultfd events, they'll just
  SIGBUS directly.
 ^^^^^^

Thank you for letting me know about this kernel functionality.

I need to take some time to investigate it, to see how I could use it.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
One more hint, please double check though: in QEMU's use case (e.g. precopy
only, while not using postcopy) I think you may even be able to install the
poisoned pte without MISSING (or any other uffd) mode registered.

You can try creating one uffd descriptor (which will bind the desc with the
current mm context; in this case we need it to happen only on dest qemu),
then try injecting poison ptes anywhere in the guest address ranges.</pre>
    </blockquote>
    <font face="monospace">I did that in a self content test program:
      memory allocation, UFFDIO_REGISTER<br>
      and use of UFFDIO_POISON.<br>
      The register mode has to be given but MISSING or WP both works.
      This gives<br>
      the possibility to inject poison in a much easier and better way
      than using<br>
      madvise(... MADV_HWPOISON, ...) for example.<br>
      <br>
      But it implies a lot of other changes:<br>
      &nbsp;&nbsp; &nbsp;- The source has to flag the error pages to indicate a poison<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (new flag in the exchange protocole)<br>
      &nbsp;&nbsp; &nbsp;- The destination has to be able to deal with the new
      protocole<br>
      &nbsp;&nbsp; &nbsp;- The destination has to be able to mark the pages as poisoned<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (authorized to use userfaultfd)<br>
      &nbsp;&nbsp; &nbsp;- So both source and destination have to be upgraded (of
      course<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu but also an appropriate kernel version providing<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UFFDIO_POISON on the destination)<br>
      &nbsp;&nbsp; &nbsp;- we may need to be able to negotiate a fall back solution<br>
      &nbsp;&nbsp; &nbsp;- an indication of the method to use could belong to the<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migration capabilities and parameters<br>
      &nbsp;&nbsp; &nbsp;- etc...<br>
    </font>
    <p><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:ZS6ksf8o7dJ8mzUe@x1n">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
The solution I'm suggesting here doesn't cover as many cases as the
UFFDIO_POISON use could help to implement.
But it gives us a possibility to live migrate VMs that already
experienced memory errors, trusting the VM kernel to correctly deal with
these past errors.

AFAIK, currently, a standard qemu VM that has experienced a memory error
can't be live migrated at all.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I suppose here you meant AO errors only.</pre>
    </blockquote>
    <font face="monospace">No, if any of the memory used by a VM has
      been impacted by a memory error<br>
      (either with BUS_MCEERR_AO or BUS_MCEERR_AR) this memory isn't
      accessible<br>
      anymore, and the live migration (whatever mechanism used) can't
      read the<br>
      content of the impacted location. So AFAIK any mechanism used
      currently<br>
      doesn't work.<br>
      When we have such an error, either the migration fails (like RDMA
      currently<br>
      does) or it completely crashes qemu when the migration is
      attempted.<br>
      <br>
    </font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:ZS6ksf8o7dJ8mzUe@x1n">
      <pre class="moz-quote-pre" wrap="">IIUC the major issue regarding migration is AO errors will become ARs on
src qemu when vcpu accessed,</pre>
    </blockquote>
    <font face="monospace">This is correct.<br>
    </font><br>
    <blockquote type="cite" cite="mid:ZS6ksf8o7dJ8mzUe@x1n">
      <pre class="moz-quote-pre" wrap=""> which means AOs are all fine if not forwarded
to guest.</pre>
    </blockquote>
    <font face="monospace">You are right in the case where the VM stays
      on the source machine.<br>
      With my current proposed fix we don't forward poison to the
      destination<br>
      machine, so the problem is not to be able to access the content of<br>
      these Uncorrected Error memory locations -- which means that if
      this<br>
      content is needed we have to inform the requester that the data is<br>
      inaccessible -- that's what the poison is for, and we count on the<br>
      running VM kernel to enforce the poisoning.<br>
      <br>
      And if the AO error hasn't been reported to the VM running Kernel,<br>
      we either must forward the poison to the destination machine or<br>
      prevent the live migration. (That's what the second patch does for<br>
      the platform ignoring the AO errors - currently only ARM)<br>
    </font><br>
    <blockquote type="cite" cite="mid:ZS6ksf8o7dJ8mzUe@x1n">
      <pre class="moz-quote-pre" wrap="">  However after migration that is not guaranteed.  Poisoned ptes
properly installed on dest basically grants QEMU the ability to &quot;migrate a
poisoned page&quot;, meanwhile without really wasting a physical page on dest,
making sure those AO error addrs keep generating ARs even after migration.</pre>
    </blockquote>
    <font face="monospace">Absolutely, this is the huge advantage of
      such a solution.<br>
      <br>
    </font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:ZS6ksf8o7dJ8mzUe@x1n">
      <pre class="moz-quote-pre" wrap="">It seems the 1st patch is still needed even in this case?</pre>
    </blockquote>
    <font face="monospace">If we can transfer a poison to the
      destination machine, there is no<br>
      need for the 1st patch (transforming poisoned pages into zero
      pages).<br>
      That's the reason why I do think that enhancing both the source
      qemu<br>
      and the destination qemu to deal with poisoned pages is the real<br>
      (long term) fix.<br>
      In the meantime, we could use this current small set of 2 patches
      to<br>
      avoid the qemu crashes on live migration after a memory fault.<br>
      <br>
      I hope this clarifies the situation, and the reason why I'd prefer<br>
      the two patches to be integrated together.<br>
      <br>
      I've updated the code to the latest source tree (resolving
      conflicts<br>
      with 8697eb857769 and 72a8192e225c) and I'm sending a v5 with this<br>
      update. Adapting the commit message to reflect the new stack trace<br>
      on crash.<br>
      I also re-ran my migration tests, with and without compression,<br>
      on ARM and x86 platforms.</font><br>
    <p><font face="monospace">I hope this can help.</font></p>
    <p><font face="monospace"><br>
      </font></p>
  </body>
</html>

--------------wH2OG0nE5QlLN0vzQHS04W80--

