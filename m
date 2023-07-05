Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB9B748FF3
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 23:35:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHA87-0003bz-2N; Wed, 05 Jul 2023 17:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qHA7s-0003bk-Uh
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 17:33:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qHA7q-0007iT-VE
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 17:33:28 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 365IdPOj005159; Wed, 5 Jul 2023 21:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2sVUpF4CgHrN34Sd5y5DsDkookB5yzj48nI1KO957i8=;
 b=W7zzDexcT/VOFETQwgtz/3OoKoS+i9mSxg6rVAFM7entJeC3Z3/R2p1IM7IcaBeikRah
 slqmtfqEG7GUCBAXvqMZegfFk5q1kf1A1HYq+0B9jbxsbY44u1fAgvTZM7PjLuw1WlKk
 zJQModuz/H8zVYzy/cvJfwWkaDCCBHx0hO4VUZTuaTv8FhKBREG6aP3Ye3FM10+WNQtU
 DtstSW2QbTViRKPDTyRWlrUlAZ3f+0KKKqyXPxIvz1BKyUl/QGlJ2Yyr4mDJJa8WHbjd
 qp6dF2JKM28KVcio1Egtu/f/kJPerSaWsmsyC03+glrhijwQf8sD/iKBavOxL60o9ZM2 OQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rnd8q8dqt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Jul 2023 21:33:22 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 365KuJSE013468; Wed, 5 Jul 2023 21:33:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rjak65qry-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Jul 2023 21:33:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+f64MAGBziWljPzb3nXLCO2sP6+JZTpTRBJ9KxyyfuaSHGXDnmN2xABU9xr/tCDFwxBixXBUgGaIV+yhTEpN1sHdxiKsrjV9bxozVTRdafH4eQQsoW8i7J+vwleU151VYZ8nud6iLL3LapKBhvZnp1KOWgTcP/EYL4GMJWujhRMjmlFwsLk2W2MvIynW7dRWDSzWhApDkmhpH2n9+ULLvbXxnCGMyvslj0rZ3uRPVZ8TeM9S5/m/ciio+UlJ40HYa+d9/c6mBXhpVFntZQbr60+J87euzvShDaz+68ueDuCNxySzqNVX/AyOg/GtqDr51pVwImNBT7sQHIgduutVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sVUpF4CgHrN34Sd5y5DsDkookB5yzj48nI1KO957i8=;
 b=NxUtya0BtTIaEHNB3mfbJZx8luYCuYfXC2lx2z5dYshOotRWhVbcoo+STq+W0RTHp7vicuiRRw30vuT+DZJIzy6xz+qBS9oKoD8hRWkPqQG++MNY1Zc7g/dpwUM5LkBKNkwb4BU8QKtlF19WW5gqnq1nEdKhFqmgsBsqbJR7uKAcaiQ29RIxOTzza6bGWCWotacmImaMw9Q34k40s1BAwSiDEv/XROeVicKq9O9VbbCrOwg82uN95heyVBWBWvnURMc5uuQoJ+9vnl3z7IxTBXzOe0cNa8G2Gt1hE4F0kee8PFy6ohxnTo34NCZThD2J7VekMMRiYFQq5MD5GHOhIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sVUpF4CgHrN34Sd5y5DsDkookB5yzj48nI1KO957i8=;
 b=H+HtZ7leOmhZ5ysJZ4ySYPT3LrjFa5PSi6fuFnCpSIFbqtn87tEqRjQueAgc+H+bA2WdOyz1ZmIUFjwQdVV9MJV9OzqPTtE0Zxf+ZHCIbX4HSZsrZzeGEfkn0dKPP85PQNIx7CxraPs1tlDr0AeUxPhH/2efYjR0F/p8W3F81j4=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by PH0PR10MB6436.namprd10.prod.outlook.com (2603:10b6:510:21c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 21:33:15 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 21:33:15 +0000
Message-ID: <28823c9d-e82f-9073-ddb3-6211d80d81c7@oracle.com>
Date: Wed, 5 Jul 2023 17:33:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V3] migration: simplify blockers
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Peter Xu <peterx@redhat.com>
References: <1686148532-249302-1-git-send-email-steven.sistare@oracle.com>
 <ZICpKM2zSZSkhmTW@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZICpKM2zSZSkhmTW@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:5:60::17) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|PH0PR10MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c4e5eb-c3ff-4b89-ae99-08db7d9f7114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H4GHk/zbjszEp6kMrUifLbIBqR0LG7TYasUXx/iLdLPKAp5JYAGSzHQvtjrRv4X1JRHncDLdUm9eZh4l77AvTZ1zo597GXwN3kW0wo2i/KtW4mCoWpgXGvU4YaKfmVfI+CK5TuTks1y4u50/cZSlEMKkJqdFsMCBGBVfot5xZEY2LabLSMD5mLIPFiCbRi18hqH1noQG20PbRA39m5X4BYibnNHWmRAzXcPpC59TuJH6jyg1MYk1EwS8qL70QKwea9jKjWdmifcaWFJwCE74xsmNDjVMaPNjiqX5eWemF2s5PrkF6iYlOOaIewMOJSrBDnD+5Te6d4gk4QFFV/o3OULLj7b+qUrmlrOkjQR8VZTMY0XF+XWBaYfpVWrK1brVwDhsDnXGmSASOHFCcij5atc0uMORyDE676j6UFhDQhr2ghmi6VLibvypf1farcyKiKQicwwwA56CrQtGRK2miI0DNfTndZTZsuW3M9Bakq1wl96N7Y6QkDkSe3HVn0Pdsam2EPJxp8dQyI4qNIBpFAvNFnByy/1ivzp4uzgsbbXTRlRyXtADWW8L0VYcZG9BiUrunmtFtaQY0XZAbWt9N/isEtdIGDnwPLVFchnU9q4JE3D9EUQS3VEHh0rRnKTRWn158Hb7y+Ea4UP8y5tadg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199021)(54906003)(478600001)(6666004)(6486002)(36916002)(26005)(53546011)(6506007)(186003)(6512007)(66946007)(6916009)(41300700001)(8936002)(4326008)(66556008)(316002)(5660300002)(44832011)(66476007)(8676002)(38100700002)(4744005)(86362001)(31696002)(36756003)(83380400001)(2616005)(2906002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU9ibWRFMWlzeUc5MDlISU1KMlVpd1cvWXhPSDZZeGFCd0x1enhJTUFZODVO?=
 =?utf-8?B?SmVIemJHSVNTQ2hSK096eGxNY1JKK0R3d211QUlJakp5WmhpUUhDNWQ0Uitn?=
 =?utf-8?B?QUd1UG9hN0cweTU2Zkx1NlhZL29FdERTQkhwRkNQSkRhWU9SRVJFbWdPYXRp?=
 =?utf-8?B?aG9ZU1dGVDJxMlRhMFZ1MHVzUElCUmo2S2ppWXVBWGlLdXZjOForY0FnU2k0?=
 =?utf-8?B?dWJ0V2d6Yzk4c1pvQ3lFekZnYTRDdHk0czlZb1k2Tm5oaHpaL0puZ2JmY1pS?=
 =?utf-8?B?VGZuVTgrTWlrNGpGRGZsdmJ4M09TWWdGMnoxcm5YTzI5RTdBUy9YaDZPS0Zj?=
 =?utf-8?B?OG9SQmx2WFJ1djVRRGJocUloNWpPRTJxbFFtZ21IeHVKVXJYaWs3b2tTU1FX?=
 =?utf-8?B?OHV5TitVdklTYVVlWkVqaThySFhTQzVZT1lFOU0ybFhQSGZPbVZ3UERTUXl5?=
 =?utf-8?B?bmpvUmlVYWN1b1I1ZmxwdkVzdmxLSWVyVVVsWHJoeVdwNmNBbG40R3NSNC9z?=
 =?utf-8?B?YXE0SWNhSUQ2Q2NtNkdCWUpUalNqMHQrVGZ4U3k0YlZiRUxsZlRNKzJBckFN?=
 =?utf-8?B?N0dXbDJ1WEJuS0NwNy9PK1FnaGIwTVJSMkxqd1RscGpuYXlGMnc3aGdjWE5a?=
 =?utf-8?B?OFVINUIvZVJ0R3c4VU4xRS9vL2lWL1J4R3poSW14T0JnK3pTVTJXRTVMNUxT?=
 =?utf-8?B?d0pZR2NEY252Y2ZFQm1TNEh4dDh2cjRxanJzMTlyNEhac1Z3aFRNbTdhRU1V?=
 =?utf-8?B?Z01XdFB2K05HY1phb3d4R0FzcnRlRGc4NDFxQ2prZTNkYnNWWmMzeGhiUk4z?=
 =?utf-8?B?WjZVeUhyc0JpdFplbzc5TEpmcEJ4Z2gvc2V5aEhkLzNMUXI4RVN1aExabkNX?=
 =?utf-8?B?TG9YeWl1bWQreEFKLzFFa0R2aTNidzdCOXl0YWM0ZkRDR3NPZFVxRTdZMFVm?=
 =?utf-8?B?V0FGTnhUMzMxZnY5L3EzRyt4VENZeEttM29HYjFuS05wUmE2V213MXl4WkNT?=
 =?utf-8?B?Q3lKOGFaVTFINUROMmR2NWlLbXBmYWl6K0c0cnYyR09NUmVDb1lxZU1JOHpO?=
 =?utf-8?B?VTFUQ29sYnBKbjkyd3lxcExHQVNxbEI5aVpEc3V1TEh3bWpSdmNZNDZXOHdF?=
 =?utf-8?B?RTlIcmpDeEIxVTlZdlV4enRWZTZYOUxqNVRXM0FWMk1yMXJpQ0VibmJVY0s1?=
 =?utf-8?B?VFJZS2JIeUZ3R0lqaW1kWVhsSWZ4bnd1WENEZStPaVVjUW9IVzBBekpCRXNR?=
 =?utf-8?B?YXZ3cmtSbWVxWEY3QURGRHVLRG9RSThrT0JXU1Z4SlFJcFpaMm9vSllCZnUz?=
 =?utf-8?B?TzNvR3FNdFhaVHRONzhlVUxMY3hOVlFXdEkzeWpZNVk5VWpBVWFCc2E5VHJU?=
 =?utf-8?B?Yk5YODQ0WWxvYzBkUko0VTE2dWdETHMyalBvb0NySThINFFxd2ZXOVl5Skp4?=
 =?utf-8?B?Z1FuRmVHQjE2anhiWFlpWE5pS00zNmhnMlRmM0JNQWphSlRHU20yc2N6Q2hP?=
 =?utf-8?B?M3U1SEhUbmdhY2FZbVg5V2dMSUs4M013RFFBUUxWUkdTQ0lyeWpVM3lmREdv?=
 =?utf-8?B?Y1JtTHM2aFNrdkdVaE9YSW02NndXKzdTSEI1dEFBOVViUXV4RmlVaWQ0SXdU?=
 =?utf-8?B?dzZDdmFIeENEd2U4UlJiaFFMdFRPNzBsRW9qNVA1VFJUZ3ZBd1BHeDFheXFN?=
 =?utf-8?B?YTNmZVVFUUJBSGRHOXIybmVVYmhRQVRPazJ4NW5BdTZGWHIzUnNTVUNJa0RT?=
 =?utf-8?B?V2gxeFpZeXJRV3RjSnhGK1hLQnliWWJJQklCYVRWd3RZbWVCNWlWWTZvNjZ4?=
 =?utf-8?B?dGNtMXVldnNMTG14bElTbGthZUk1RTNwVFN5enh3RFdiYmdqR3pmdnl2Wktu?=
 =?utf-8?B?UFhYWUJUSCtDUjQ4aVZaMmc1QjBic2dFeFhycjNtUjhxK2tKY0R6OWlJd2Mv?=
 =?utf-8?B?d2xLcStHM1o5cFBxT2dSb0x1N2xYTnhqdDVGY3J5RW9BWHRqMDJlRFVEdnQx?=
 =?utf-8?B?NDRVMmR4QUgyWitwSnJOWCtJRkdDU3kwOVFJODVEamNTd3V6WFNpcUFNNVF5?=
 =?utf-8?B?UC9ucUozMFFwbktiZTk3WUpJcHdyd3QrMEQyaEZUM1p6N2ttNFZob2dIWFh2?=
 =?utf-8?B?eWkrZGoxby9XL0lnVXJRc0FkclZoSTd5MzFjbGkzUm5zMFVTbzlyMFQzbDQ3?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vlDtpzbbzolFGdmWnyRtXYGzTUp+4gHb5uCXbKPq9vFG88aEGEnl5PobxclWgR1HcwLevjDFFvD0aIuFgqcJ06bLUxxfwwhf4rO2inSJsvBUlxbjOovgXXS9d2p2bqB8aXFOowlASZW1cZ98GlUA6kcrc/hZsYYgVJE7vNDx+af46UPnwRHgFbatFqJR5JyG4pV9XWMOrC4Rp4GN+mERT6fBoKBtzEzle8dIraTA5kcFYk9+OH2rvyA8dawD0AAmXiyNv5eiSCSUMovFOF7C+3k4mpVQPLFcp/j7+elADduJFhLHz1PdTgyh62ajaa6HB4ll7yDbix4x0xr6OL5F+30bcP94rXQqs9pDroPk8tbpk7bRVbbnpfm+0nngrVJ08F2lgrJwf1PLcikyIOoYcq6uVGDXV4yV/i4QldkXb68ReMCvTBDV9lFcz2qozzsQxG8WAsVioEVXdHnpr6mH+ImMrABYgQzNdViv6g1BgzRT3xSAo32kl1MsN5evfXPCUwpdGg7pVrdb2Sn5Nz8apgivIUCA9VtoF4yW7Ps8riQZY1A2bTfccEHNLSe5VjQLD9qXIL1bbe+1XVmXiDmEOg+EMEBFQgXk0YUEh43LlRIVun1wKAOQppaTmZkhhi0fpBp9Tp6bgPVqHN1o7G6IsF88TcoOMWVNBiN3pGM6qbr9hfoSTmbF3T0yZ2ng/dNoCZ6GQI/xCSlHc3YNrqKccjXbiqoAxjQDsIntU8O8TpLpirm0E/whqKEX2/oWZtYa3hexteGywax/jLbghePtnXuO9JuJo2TfnOyYcQAvEBHN0Q+M1hwkJXmsDnPS6V7G
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c4e5eb-c3ff-4b89-ae99-08db7d9f7114
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 21:33:15.5864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kur/PY7ryWjj/L61PQVsAtaH/T2sYp/DPP59CmMGGDiPDPhs9hWJYIJ+dxBdjyRXy6NJbR9e7ZlqoJ1c3k9MzpXGz2uxp1IvFFuRN+UwVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6436
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=996 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050196
X-Proofpoint-ORIG-GUID: pcQx3I-MC6bq4XIKEWqnJiVUgcuRskqS
X-Proofpoint-GUID: pcQx3I-MC6bq4XIKEWqnJiVUgcuRskqS
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/7/2023 11:58 AM, Peter Xu wrote:
> On Wed, Jun 07, 2023 at 07:35:32AM -0700, Steve Sistare wrote:
>> Modify migrate_add_blocker and migrate_del_blocker to take an Error **
>> reason.  This allows migration to own the Error object, so that if
>> an error occurs, migration code can free the Error and clear the client
>> handle, simplifying client code.
>>
>> This is also a pre-requisite for future patches that will add a mode
>> argument to migration requests to support live update, and will maintain
>> a list of blockers for each mode.  A blocker may apply to a single mode
>> or to multiple modes, and passing Error** will allow one Error object to
>> be registered for multiple modes.
>>
>> No functional change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>

Hi Juan,
  This stand-alone patch is ready to be pulled.

- Steve

