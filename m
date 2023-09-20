Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD887A8AC3
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 19:44:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj1Eb-0005jp-ET; Wed, 20 Sep 2023 13:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qj1EY-0005iR-N2
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 13:43:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qj1EV-0002lN-Dr
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 13:43:30 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38KGiJXw030528; Wed, 20 Sep 2023 17:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Mv/g2U9ex7f5ef2dpDnoX7wEOAk8grV7dQ9KuXQ81Fg=;
 b=NOLhw66iqE36oJJUSHbfX66tZG01kl4DLm13yM6ahzvdJSmrBEDzFaTZspuHQs2x+LNg
 WLrpODF8I0/xF5hdslBDat7QbwPmX/LyLPhFiMknDD6Zz2D4HZLjwOnkk0ZjnRUOxvby
 OCfDlavysvRmpzD0ycmeRoEwHvheG1CCL0C8OUwmgBcTbdAKKUHDfEORXDtVr825n2BG
 +LM6VuD1NYy7GfepuOdZdDqyNnJStP5z/Lf/RlAtQ54d03ZXkSHU9KM34/1emm7fOsX3
 Euxji0WLHu7xDmWPWhf+wZdEPSA6dwLjd+JAAQcfL4Krde0KmywMC+22d9YdjjtAwa+6 sg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t53yu7y2h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Sep 2023 17:43:22 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38KGZ6sI030918; Wed, 20 Sep 2023 17:43:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t52t7e24r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Sep 2023 17:43:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0L99A7eum5wNig91Bd+8LH98wlBFFIRV/9+3VfnVLRa74YyopAS3RgYn0+AXl5/oyt2X3kf4JFRUzvcmhjPhmCCr2XLpl/FFihIESGy3Hu3+S2Xqvwkyd3ZFZckBp46wCrQnrRcqFOoHRraPZcUAIE4wmcDWB21rWOCM0yw+31TaQ2ku0n3IfeNFnEmcGUcY5GrY5C1S3asAoybyCBYiT1QhRZ74rXaEJoMjkR6fZEw7Sb2IRTyoSkuxsVPuYYRR8GUU7tPxyXd4UZFYsXiOsCB+T6kvkD0gpT1wiNudXl8hpSuvZOB/ury6DVcU5c2Fgl2DuB3jgZq7YEeKA/wfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mv/g2U9ex7f5ef2dpDnoX7wEOAk8grV7dQ9KuXQ81Fg=;
 b=S7PdACfCwaZX/O9ayGfk1nzmjPpg6ZpnZI09wvTJ2jv+Hy6vZrSf1yoIufcqubjGxazIN9BwfrsPvwoNBX87DR6wzH+IAmwhOY9BvOdwhwRW/oijzb9kwhkFHqCa3GRGaaj8nwpzVkz4XWPmtY4iUHFMOpIG0ORM33O9BBrC3UW8ZjndZ4TYKMuaE3+mswKFeJTWG6NmS+UrMtFtQCkfPjUwSchJhnQloXoZJVKeDpiWWz7YUB5vGQ6DdeXTlj9bjmt60AnUo94scB+EBpf04K87Y6yeGkGIw4T48D2/6Gx0gOBUD6DREEM9IQm9gUsn1xI7aV+7wZ/MECgy2A0uUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mv/g2U9ex7f5ef2dpDnoX7wEOAk8grV7dQ9KuXQ81Fg=;
 b=hz8zcyGVMSRVMwsA2gvi4cRNnWEKO47vqwG/HQz/hYg0AB9gvSVH85trRTVQF16Ohe+kW3qp+40KEPskt+0hxPjqUbyfXlWh2UH4G37/9r77rEkIOswAV9xNrw9xiQB7q/H+CmEptCw4zAhrCgU07+dTFO5zDr+NlP1auITdZIU=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SA3PR10MB7000.namprd10.prod.outlook.com (2603:10b6:806:316::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Wed, 20 Sep
 2023 17:43:19 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 17:43:19 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Jon Doron <arilou@gmail.com>
Cc: qemu-devel@nongnu.org, linux-debuggers@vger.kernel.org, =?utf-8?Q?Marc?=
 =?utf-8?Q?-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Subject: Re: Concerns regarding e17bebd049 ("dump: Set correct vaddr for ELF
 dump")
In-Reply-To: <87edisycgu.fsf@oracle.com>
References: <87h6nqxdth.fsf@oracle.com> <ZQqj9tFS7cLMTkHv@jondnuc>
 <87edisycgu.fsf@oracle.com>
Date: Wed, 20 Sep 2023 10:43:16 -0700
Message-ID: <87bkdwyc3v.fsf@oracle.com>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: DS7PR03CA0266.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::31) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SA3PR10MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cc7f0ef-cc64-4e15-686a-08dbba0113c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2YPePqCdQOOcjoczdNwbmRdbe7EElzmj4VS6vAcATDu07C8k7WQLZ7h2cK8MQFIifciDuZ2fqtIPaWzQfT3q7q0u+HzMhMFlp7wjqYo2kUmFXpGqV254Q3XO2miD4k+wX0s2vLjfTTDOJCPtdW7hX7EU79V6mS+FkbEECCERIwS0/RJJOB/w1qYTHY/nz1XUTjY99xgj6KNu78h933MIJZFTBu94MZHXKtCOwyP1q9jh7MNggVMLJeBCVPNvipnSctmRcUjj3mS0Sh09TjNXjkch3yz8Nx6aI4IXv1sekf3rlDKyGn4DHYvpG+KucBLaSz1/2i/6Ia2QXQhRUvX5XsBm+njiqUAiBrAQElYC1LBhtNRc+6WpEqB80+/wNmIFWQXGYglq2Jxti78z4J6UAAoHAHYBZRp4gTd4Jm+DHcU1QAqISna9LTDUZ7rZ6KIrrs3skocueEMChJYH3++SC+BWbaemdvZZN3kqq5k/dkKlGV/OTbsaoC+5XRHrV23YPxjDSJNPwZF1nsieehwzwwg7cNkOzoFUmRXkeAqfOdvlMBBE9iWSB+syLp/VJERnitbMnl29yqVxMMxYro/cNDMQV8VCygMtUD8XUwzIXjg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR10MB6597.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39860400002)(186009)(451199024)(1800799009)(83380400001)(6506007)(6512007)(4326008)(5660300002)(36756003)(2906002)(54906003)(41300700001)(316002)(235185007)(8676002)(6916009)(8936002)(478600001)(6666004)(2616005)(6486002)(66946007)(38100700002)(86362001)(66476007)(66556008)(2004002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8AdU0nl9OmsXClPpJf+FT6sRsk3cH6T2HlxcEIeLLpYfoudPZEjTzkMwinAF?=
 =?us-ascii?Q?bFyC5Fztq8PShx+YP4h4WfFScaujaeBK3Lih/HtDJVHFYUNafTSh/Nqd19GO?=
 =?us-ascii?Q?xUAPPsyYdeJPuY3UhVBgnXEIyTEsxEY3y2ag1VHYTsEDu/24YpWQzzP4q8gZ?=
 =?us-ascii?Q?tG/MwaUJ+OPkLsdZRvaZ4iotQG3qUGmU8B5diSBNqo9eoNF0w8sNLy596kC0?=
 =?us-ascii?Q?Qsb2rlyIXtM06cgJY4CVwNT//7kCyIcjHh5OFQJorFydnpTltJZa+Dy9eGzp?=
 =?us-ascii?Q?h9HSZGNEyyLMzLDO6u//bqXm/xO+1BHzP47Ejgv9p39vNZxbReboTwZK+QqY?=
 =?us-ascii?Q?vojnJ3tBhpDGGLoug//wDJIX7iyaiHsT5XHaJKuW2oDb8i+wDAo0O9HLEo8p?=
 =?us-ascii?Q?7KGL0G3T1JOM+Y2+9Q5LMSujJelOY1H75TtcC1ztzk9ibRLINy76F6bBvnME?=
 =?us-ascii?Q?9VAWlDF0/GJ7Ogq/jZVWU8heAA70EsNqimwypTYQZLPhHseU3tzGQwCvoEVz?=
 =?us-ascii?Q?PWD6BXHXZ0hRuU3oI6To/DkvJaT2RCrymebIgNUtjgMUYpUU0tHcANOerzOb?=
 =?us-ascii?Q?SxXqy96nBn6FwAK3F7KkMQZUS0Oy2PhhBP3M5vVMlddEogEZByXFo/LL1PJ1?=
 =?us-ascii?Q?ZCb++jW7J0RHhWuTae38oOPaB+Z67CBsded6JVaIyVfn5kOMI6mpGeKsePyn?=
 =?us-ascii?Q?VZz0eRnnSv2Rxxq+p+rm4Rk28gUeDHcMgKNSX6FMUPWW9X7aQyNBrWOmrjpv?=
 =?us-ascii?Q?I/EM63Jkj3G1TM5ZsnIhYfPt3Etag1czlpb9ePWw5sybCGzGr/q8zv6ctgL0?=
 =?us-ascii?Q?AMTRVVAv3cQ/TqIiXyWS8AsrkFv7VBw+Hbj8DHQx2Es+6qCiRVpoZqpjK+2S?=
 =?us-ascii?Q?uurqvlfr5Nv+BtQG0vpa15abuPSJMDQ9GWITfXWZwJvLYzRglBSThyGflzTU?=
 =?us-ascii?Q?Bj8V0bIx4TuswRIjStFYTdUl00XQW5IA9heXfLD5r3038V8wbYjLLbaQqxDW?=
 =?us-ascii?Q?RzcbcbUepk/TC5EeSMgPw2G6KqdONPqeuoUZ8Bfp8q2WXxWktr0qr2R7qcTI?=
 =?us-ascii?Q?sHXytiZNPH6mE7sU/9ILuLzhQNvLKOQuEcwZT/kea5BJ7G22errn06R98gBK?=
 =?us-ascii?Q?IwCpbsHM/dGLaS4ZHK+W+usSfeboXqGXn1QrAlHc5do/jufyeyaDD0eSz51m?=
 =?us-ascii?Q?vje2SVeMVtGp1HAoDhYltRUchwEICROXK6wyhLCc9DdBdI/RveYgNsG1d6xH?=
 =?us-ascii?Q?KdBvf+ZlxBFjoUEPBi8Cz3Gwy1xjqrIj4vyxPyFntPuIBDncng9SbTMFX506?=
 =?us-ascii?Q?Q8iuXG3UG2bkKo+0wRCNqDainw0VMkEd8bxfPArVJnOF7UskV0pXMoRpvu97?=
 =?us-ascii?Q?vqzRltLXxco553iPzvzpmZxaQ3rx8O8//Q3RHYcBAnIvxTAO8g9xoh0pBV1u?=
 =?us-ascii?Q?OIqVdcuXI2hP0u18ovajAUOjt/nFxILkN0hEbrtVYicHO7klzKAJ2ZItU/cD?=
 =?us-ascii?Q?9j2XfGdrgDah5xySQff1XreVTWLzUp5f3OHIJ9arUSDl7jH0UVhxggAS4bRX?=
 =?us-ascii?Q?LCxZXd0Geja7CuSDAwyQjIU4i7/X3V4H679PXt5BzwVH9qnjYSZUW9vWESSx?=
 =?us-ascii?Q?Y8z7X989MTg8etBNLMdHd9wCF8rWdlT5yDZBpd6Tx2Cx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NnBDzyXS3ykHiVxc0cR1i0hr6euCATewGnEOjY+Xq7S6qTe6R6RBPlhm6AospBsJbJiPRoZtCCIW+9lIruBWPx3OtnhI3AcpCVvxua2cu5lgv7B6T97hSrkZ2hnT8leQMGBV6VGgYgn0BzHIgKA8XclgK8OkAPIJyiPeMhvfaF0bOXinEJQNJNVtCEAJC9vlySVp2ttrXpQT3j47HZMK33pqs2lcgf2WndIFqC+PWFaBmSWQUFMaXireSnzhAx9ezM5j7gP54JodpRIs3XtNi73S8ivnBVlbt8Bm9R9UvZ+lpO2olhy+ptI0px7HtTzKQ7Vr3tj+2BuFkm3BLAyeFrss8plZ1luv9OidysEusaHX0303m5xYSm++jlada5ziy6VX+LgjhK5+B2DnMfxSHdoMd0pmQKGc4hQqxzmYYHqSOxQTeVnyQLh4kLe274YEhT5clEOrB5V/Jp6Dfr1FhUWjOaxbt6VI03Fz2uvrM6jKHTRJKapsVUBJYBWyg7UMFi9ApWxh2PAwqH/D1/rzpo0ExVGqzj8VKON6hOTLzdjQcfk4U9NDv13uy9goNMPDLRhMhU6Y3CVDRs9p0tMRSpJX3nVHKnIIxWk7e6bJjLslfuvQz5QEwErHjHmKSuHT4F1zCb0Wc9V6N3L1+OGOWeY0C8P9M5zG6CG+skM2lHFKUj/CynAdXF4MEH9JsDP+7FBOliLlsu/fowABVjXgBGXhtvRn1P/ZbNTUDGh+cZbnwWr1r3K5r/loasaPrwCL1l827OgTV721wc0zYXeJjxaQTWRbs5KvxPOi3dbVJAQ/+St6D0JqDhND1GmbmOHTi+bU/yy3gDhKDfyrr2E3sed4/uaC5tp3dadAgp5EINA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc7f0ef-cc64-4e15-686a-08dbba0113c2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 17:43:19.3323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9AM5MRKcNzlB8DKjNZYkLahhdIVYKhIHcmbfFZ95p5wnoQc8d101/5+ooG5F0RExQPvbuqvMM5Ea8LhRbPVdDyFdcOD1bN54AertQvfoaLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_08,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309200146
X-Proofpoint-GUID: hM9Rl48J93-9XVe2gtUa_dyMZACnszpE
X-Proofpoint-ORIG-GUID: hM9Rl48J93-9XVe2gtUa_dyMZACnszpE
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=stephen.s.brennan@oracle.com; helo=mx0b-00069f02.pphosted.com
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

--=-=-=
Content-Type: text/plain

Stephen Brennan <stephen.s.brennan@oracle.com> writes:
> Hi Jon,
>
> Jon Doron <arilou@gmail.com> writes:
>> Hi Stephen,
>> Like you have said the reason is as I wrote in the commit message, 
>> without "fixing" the vaddr GDB is messing up mapping and working with 
>> the generated core file.
>
> For the record I totally love this workaround :)
>
> It's clever and gets the job done and I would have done it in a
> heartbeat. It's just that it does end up making vmcores that have
> incorrect data, which is a pain for debuggers that are actually designed
> to look at kernel core dumps.
>
>> This patch is almost 4 years old, perhaps some changes to GDB has been 
>> introduced to resolve this, I have not checked since then.
>
> Program Headers:
>   Type           Offset             VirtAddr           PhysAddr
>                  FileSiz            MemSiz              Flags  Align
>   NOTE           0x0000000000000168 0x0000000000000000 0x0000000000000000
>                  0x0000000000001980 0x0000000000001980         0x0
>   LOAD           0x0000000000001ae8 0x0000000000000000 0x0000000000000000
>                  0x0000000080000000 0x0000000080000000         0x0
>   LOAD           0x0000000080001ae8 0x0000000000000000 0x00000000fffc0000
>                  0x0000000000040000 0x0000000000040000         0x0
>
> (gdb) info files
> Local core dump file:
>         `/home/stepbren/repos/test_code/elf/dumpfile', file type elf64-x86-64.
>         0x0000000000000000 - 0x0000000080000000 is load1
>         0x0000000000000000 - 0x0000000000040000 is load2
>
> $ gdb --version 
> GNU gdb (GDB) Red Hat Enterprise Linux 10.2-10.0.2.el9
> Copyright (C) 2021 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
>
>
> It doesn't *look like* anything has changed in this version of GDB. But
> I'm not really certain that GDB is expected to use the physical
> addresses in the load segments: it's not a kernel debugger.
>
> I think hacking the p_vaddr field _is_ the way to get GDB to behave in
> the way you want: allow you to read physical memory addresses.
>
>> As I'm no longer using this feature and have not worked and tested it 
>> in a long while, so I have no obligations to this change, but perhaps
>> someone else might be using it...
>
> I definitely think it's valuable for people to continue being able to
> use QEMU vmcores generated with paging=off in GDB, even if GDB isn't
> desgined for it. It seems like a useful hack that appeals to the lowest
> common denominator: most people have GDB and not a purpose-built kernel
> debugger. But maybe we could point to a program like the below that will
> tweak the p_paddr field after the fact, in order to appeal to GDB's
> sensibilities?

And of course I sent the wrong copy of the file. Attached is the program
I intended to send (which properly handles endianness and sets the vaddr
as expected).


--=-=-=
Content-Type: text/x-c
Content-Disposition: attachment; filename=phys2virt.c
Content-Description: phys2virt.c

#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <byteswap.h>

#include <elf.h>

static void fail(const char *msg)
{
	fprintf(stderr, "%s\n", msg);
	exit(EXIT_FAILURE);
}

static void perror_fail(const char *pfx)
{
	perror(pfx);
	exit(EXIT_FAILURE);
}

static void usage(void)
{
	puts("usage: phys2virt COREFILE");
	puts("Modifies the ELF COREFILE so that load segments have their virtual");
	puts("address value copied from the physical address field.");
	exit(EXIT_SUCCESS);
}

static int endian(void)
{
	union {
		uint32_t ival;
		char     cval[4];
	} data;
	data.ival = 1;
	if (data.cval[0])
		return ELFDATA2LSB;
	else
		return ELFDATA2MSB;
}

int main(int argc, char **argv)
{
	char *filename;
	FILE *f;
	Elf64_Ehdr hdr;
	Elf64_Phdr *phdrs;
	off_t phoff;
	int phnum, phentsize;

	if (argc != 2 || strcmp(argv[1], "-h") == 0)
		usage();

	filename = argv[1];
	f = fopen(filename,  "r+");
	if (!f)
		perror_fail("open");

	if (fread(&hdr, sizeof(hdr), 1, f) != 1)
		perror_fail("read elf header");

	if (memcmp(hdr.e_ident, ELFMAG, 4) != 0)
		fail("not an ELF file");

	if (hdr.e_ident[EI_CLASS] != ELFCLASS64)
		fail("file is not 64-bits: unsupported");

	if (endian() != hdr.e_ident[EI_DATA]) {
		phoff = bswap_64(hdr.e_phoff);
		phnum = bswap_16(hdr.e_phnum);
		phentsize = bswap_16(hdr.e_phentsize);
	} else {
		phoff = hdr.e_phoff;
		phnum = hdr.e_phnum;
		phentsize = hdr.e_phentsize;
	}
	if (phentsize != sizeof(Elf64_Phdr))
		fail("error: mismatch between phentsize and sizeof(Elf64_Phdr)");

	if (fseek(f, phoff, SEEK_SET) < 0)
		perror_fail("fseek");

	phdrs = calloc(phnum, phentsize);
	if (!phdrs)
		fail("error: allocation error");

	if (fread(phdrs, phentsize, phnum, f) != phnum)
		perror_fail("fread phdrs");

	for (int i = 0; i < phnum; i++)
		phdrs[i].p_vaddr = phdrs[i].p_paddr;

	if (fseek(f, phoff, SEEK_SET) < 0)
		perror_fail("fseek");
	if (fwrite(phdrs, phentsize, phnum, f) != phnum)
		perror_fail("fwrite phdrs");

	fclose(f);
	return EXIT_SUCCESS;
}

--=-=-=--

