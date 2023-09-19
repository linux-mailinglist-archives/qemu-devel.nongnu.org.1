Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 034407A69B6
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 19:40:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiehF-0006k1-Ki; Tue, 19 Sep 2023 13:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qiehC-0006jb-S2
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:39:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qiehA-00050V-J1
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:39:34 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38JHODgN028512; Tue, 19 Sep 2023 17:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=cnjrYDQLbLqz06gZngnofSHBPL1TO3eR69CYzMR5WY0=;
 b=gyXVPzYjyVtEzJeMwKjzc3mX+AnuoJycM1H4ngul/y2Bj0XhqIauTdX+SVp+baVH8fsT
 bqJmICwoG3/xjRuYkODdBbiPETriZSZ6ExGyRFQ9Yk5mAVxUoYDXhj2UrQw2sj5Wejel
 3Y+jaabqHskjulbZlLWyLWnjszDEnJ9KfWo49CdS+JYQK9IlPLw4Ih2Q9nwj1QT4ZQzR
 LgvnPRqD+K121cY/LjI3vggyjl7mh9EDWk2nW2IehthQrsz7EXdTbigBM5Ke9Y3EILnG
 OzGjBP1lfaJYvIW+LPw6J595U/7wOqc+1lEtmeB2KNDOHvs/CKc9ShAsFtRu59/zteTW Lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t53yu5fst-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Sep 2023 17:39:28 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38JHUY7O030176; Tue, 19 Sep 2023 17:39:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t52t5yubp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Sep 2023 17:39:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=claGp0mx3JgOrq6BApvLh7J2LZucoUvzzX9qeVRhAESTdBB/6OJo+Z5dYhF4g+vdNg8OfZGi7bHYPhq6FzHRbeiB172XQ4mihn0JVFN1dGxgyLSIjAMsZNB6Cadu/zxSVYOFpdQipulpYh6RQH+ukWdORH0bI/0QvWHu0Mqg6i3nE+WfqbhP2YASW+X8a5nG4V0pFZ55Y7htbwiAKluFoFBZluhVn7XaqMSsJq6a3pAVaZoX6BhwR3K1YPXgUL5F6jvHFOWMvT/dN5hoY8O4hFWZCFZmWfARKuH7Mq39dSnkyMt7RbDI4/urI/rZA7OYRSYb1n5ZgfDbpazs4ayBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnjrYDQLbLqz06gZngnofSHBPL1TO3eR69CYzMR5WY0=;
 b=A7L3m3W2h6crHI2zXJVGRb9rNVvQk15rmyQEzgq0fYHaYIOMX0fU+ti6u2EevzT+687jNLJUJbUekYMyhb0rWvohCf/qZBEVdGpGHnFVf6/bPTGfNRTCnluWO8WbclZxXGzup7EnZcNvrdpTuBUvi/XCyvysnlos+Zp10ph515YMnCJkzdX+cB4L6quPXeN3pBo5fN9t6RLHAWSoEym2nVhBWJs5g5CK54Q1pQrb3lDNvfpVfSgmNIZedNtd4Jfk/V/HXhSYKimtkzeajLD5cDnRUYhiLuDK6E/5XgBlHZpmfBFA9vtFF1gJ5fAxGb6P6tRpeeiAAOxFXfnzAi1Pug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnjrYDQLbLqz06gZngnofSHBPL1TO3eR69CYzMR5WY0=;
 b=CEjZlKzd22SjP/w530L+V7xWp6t3O1rijTKy3rbPBYzAo7hbz1QgKAwOHUl69SKPAY4xwfUh0cbDg8evywpAulcalz1O3+hYhK6R2aZz993wJpyLgqpan3WFEaB6lBBUNPcdtNW/78Isp1z4tw4g0IguCOfhzW3eU4ASNrCjD6o=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by PH7PR10MB7056.namprd10.prod.outlook.com (2603:10b6:510:275::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 17:39:24 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 17:39:24 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: qemu-devel@nongnu.org
Cc: linux-debuggers@vger.kernel.org, Jon Doron <arilou@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Laszlo
 Ersek <lersek@redhat.com>
Subject: Concerns regarding e17bebd049 ("dump: Set correct vaddr for ELF dump")
Date: Tue, 19 Sep 2023 10:39:22 -0700
Message-ID: <87h6nqxdth.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH0PR07CA0089.namprd07.prod.outlook.com
 (2603:10b6:510:f::34) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|PH7PR10MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8d7b30-53f3-456f-a3c8-08dbb9375d77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GiCBJab6X/ZzFHMPbHUDajoqSx/RYnhvF0o1AOC53TAM7bIUPH+ylKKz5IWmHOFb3Z5Bt8GLlNmH33ufebNiR9IvcXNp5G2bnArAg/8Ulp6eru0i0TCKLtQgd6UynArG0GuzKvIadH7TRG0DXoN69G66bZrMH9JDiqgIjxNR6j6dxy7YDlRwXXmewy5PBmjUNelASlnUTmKH20kBCr8EgzfaFSkN/XEqJWkJGjJABEexzHbLktxX25aSIkeX9w/zpoTBclaS7+QgWzeMkDE3LI/j+E9njdKdCg6uvzlRUN1fJ0lDdNhVXGGlJ+G4iktjBXXJlGJtbSp+RbZ6ADa8eCelC+gykzzs+ZKPQvmLyDTFS2x5KpL7lDpM/hnBQY2F8fRPAWCdkOOrxxWbsYAG123JopJFNYEZhjb3+ugRUTk9iaaNaJkmNou4xDKiQ8O21yvshYRmVaN8yczmOWFpDIFBw8Pn3HKpRBGx1/msTJXL7QPm/5k96PIdvI6TosVECsBcN20TrBRqPClUTRE3EuXkEySDBxZ9oNdrAR/WBuykmuBeDow/npJRO8TQOqJwQPvFVh+dUZtmpuU+B3AqUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR10MB6597.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(39860400002)(376002)(346002)(1800799009)(186009)(451199024)(2616005)(8936002)(8676002)(4326008)(83380400001)(2906002)(36756003)(86362001)(6506007)(6486002)(966005)(478600001)(5660300002)(6916009)(316002)(54906003)(6512007)(66946007)(66556008)(38100700002)(66476007)(41300700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWQrZS9lMlRkTXYzR0hWbWc5c0orb253ZzRPb3hGcEdrMzRXNk5ZWUkreEZm?=
 =?utf-8?B?cWRTcml3WmFGOW5OYllkYnFDQ05ucGRCSXp0Tnl3bTlkbzBVZDZ5VXFFZ2ha?=
 =?utf-8?B?UWpMdjUxc3k0ZDVnVnkxQnVlNDZoeU9pYlJkVjJDaGdGb05McTh1ckoveW5x?=
 =?utf-8?B?cnl2dGxBZHFYdG55SFE2eHhnZXZPOVJVWm5Uc3lJV3lFV1ozV0NKNkZObzhw?=
 =?utf-8?B?ZGZSaSt3NEEzOEVTYlJuYUdrQVoyNXV4bXlrTjBTa2JpaFFaU041b3BkWXpH?=
 =?utf-8?B?a0ExYlVSQzFOU3pWWWluaTYxSFVyK29KVmZJQmo4TE0yazE5M1dzQVp1UjBa?=
 =?utf-8?B?bW05c1JoYkNTVjNwMDBjd2Z1b2Q4ZmhKSFd3eWZXRkYyQWQwM2Q1bDlHTkRH?=
 =?utf-8?B?NVM3WlVrcGt2WForbkFUd01XVk5LcUpJTkg2VkZ1dVlld2lsdFlyVC9KMitF?=
 =?utf-8?B?bDlUYm9mZnFBTHdUdi9hVWN5MzAyMHJiTmczcFF3RXBuRm4wWW5uNHN5SEFh?=
 =?utf-8?B?amNZdyt1Si8wNHB3QXYzYkJNdzJ1OXlveEdmZ0ZwZ2xScENnVjk0ajdONWRV?=
 =?utf-8?B?M0hsWTU3aWMraHA2cVJuV09ySlh0S3Fhejd3dGh5NG1WQ0tnQTNuTWk1N2ds?=
 =?utf-8?B?TVBCUEVERTZMQS9NUER0TkVwSVc5N1FZaWgzK1ZNT3VDVlpPTU9xbVRpVEc5?=
 =?utf-8?B?SGRPNW1MSzltc3ZQSzYwQ1NRa0lheUVHMUFNeW43SmNjM2dVVWVHK0hIOHVY?=
 =?utf-8?B?bU9GUGRpSHpxaFRySjFHOWU0cE9XMDUrdkZiVjV5UjBxSDFlZEpWSDNJT3pa?=
 =?utf-8?B?TytDWUZVYzZqUzJFc1JEWVhCeWVLc01LSzkvTTRpSmFuRjhwYzI5clVhVWxQ?=
 =?utf-8?B?NDZaVjJqSUFYOHducG5ka1R0ZEVOSzlWSTNsZWFsTXZZVTlKSHkvU1c1Nks2?=
 =?utf-8?B?K0VlamhtYlAzZzIvaEJadUhDOXNwR3JuR1NzSmFZcTdjZit4L3JBbkJvUEdE?=
 =?utf-8?B?MzlEMURIRTlTeENKR1M5cFlic2NRM1NMVFNXVk44N0psdnhwckY4cnhSbjQw?=
 =?utf-8?B?LzNhZGxTSUR4Y1FGQkpObE15ai9zdXpaWi9wc0VwRkRjcytPZVRXbnY4OXc4?=
 =?utf-8?B?SmRpT09aamVDenRRYlBMbU9UdlBKRHV6RzJKSzk5cFlWdXk2ZkU3dTVCTHZr?=
 =?utf-8?B?SWlQTUVmTEdtRXFmbDF4VXNtVWtoYnpNZmhmSlV3UFRtL2lyQVVTeHBPV0Fo?=
 =?utf-8?B?NTVwTk1HMTJTaGlzTTBFSnVHZk9FRUxTSDQyZU90MU9xYTNYdThXcmJJekF4?=
 =?utf-8?B?UGZ1R2pCWDQwd2ZQK0JlQ1R0RDZTY0pmSUVINTNHcC9ONVBDbGM1bFJGMTRs?=
 =?utf-8?B?bFlZNExmODVqRUxHQms2d1RjTnhaTkZnUmVqWlEyVDdjNlhxYXF0Y3dxNEQ1?=
 =?utf-8?B?MWNwSEplYlJnUHRkRlg1dGJkSTI0YW9PZTErRHZ3MUMycHJOeWtIeTJQTlJu?=
 =?utf-8?B?TVdYWHROaWl6WjZ4bWNwelRzVXJna0RseEYwUkFNcWhFemxDMksxT2czZ3Np?=
 =?utf-8?B?Wk54cDVjOHQvRktzUUFoMVhPNCtDSVFTalZZVVh1TFU2YnlTNjVudWdSNSs2?=
 =?utf-8?B?MEE5T2VPWHgwdCtFMWVCaDJDd3ZsazQ3blRXamFtdVRFMmprM0pkeVAvYzJ0?=
 =?utf-8?B?REM5TXZNWmpQNXNvM2ZlZG9weG1HWGtFckNxc1cwOElBS040VzhpY20yZ1ZZ?=
 =?utf-8?B?djJLUm5YSzM0eXdYSjZHdHJXODZPTlRlb2I2TmNYdnU4c3A5RmVkQlRtWjdh?=
 =?utf-8?B?WWF4OXhXVkRQdmRGZ29ES3RHK2NueWNFOW54dEYxTGFkaDRGT0NRVFAva3A2?=
 =?utf-8?B?ZzAwbFRyM1RUakN2czRyU0dweXVDS0Q2dWJ6bENLbFVTY3ZVZ0p3eFlQb3Nr?=
 =?utf-8?B?VUVrSXBOZFF0Uko2NG5scDRSRDJzQkxMS01zc3FvZTdvRy9DeDhpSVVSR3JI?=
 =?utf-8?B?STZIWmJsRmpJajVjOElBK1dqVmZiTk84b2hPT2V0bm5mdGlUeU4rcmVEbVNy?=
 =?utf-8?B?M3BJUk10dG1NN1F6UlVGTVl0bU5DYXhQdmhhaTJVd1FBN1BVMWdER0FUdWd2?=
 =?utf-8?B?Nmp0VHdZaVhLZS91TVM0eEhrT2FZTUVSWXZZdUsxWWIzTjl4RCsyblJ0Ums0?=
 =?utf-8?Q?UtcjtPImj13dK1Ke9i/cTrKnZOsCZnFaG8DGbt4KrjHA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hM+JhAtSjcoMOnrvN0HGlFTgpbBdVxVHclalrRlyEPKStrua3zA1nVVt2s0DLgA2NBkytOyCvmHJsdf5STmCLIAtZRENEPR5DZy0gJtrus2rK2pwapjsx7qGAibXycXZe+JXLhGs31v1HQX1VmaIGsfaXuNLdnAzLnx1yj56sRQvESwtF4Ff5fdNSuzpEcUXUrvLME9jQLwjv9C9uz+GbkK8mU3OEmEbpQWqRdYea1MDlmDlO+3XFq0/nEPUJdM5xtYEvYCIk7KKlLebBDbSACkCb9DBEWaD6w9mvSYVfs481kH5DZlob7RlDuVb+M63z4M0ixvbEaG78x4tp8raMfQL70gydNZ+wGre2FMAgHWXt/Ks6iSQsjud9ASglv+sZiS7elHofV58SRuplWqWAy1ERNDd4PDAEea/MvJeoSw1W0ZBQ8/ojdQOogzr/lsQciw8GIXDWZKjCtRnvOlhT+2e5cijsjdeXNIx42xyoqwkXownm/f0stLd1buL5zXr2qJp1bWmFn8VOZ2VyjsQ8cQ6mlUGye3Kew/Sqxw8bm870uIaJ+gDhYq+GmbzGt/PPgU/esdYOWp9WvAC4b6FKOOgzbTvqSSNJ++ueWtGoGc4T3xsTTpUVZfCs/S/WuzIB3VliX3RJLhCRjYDeqHtn09zprPmUNWp6qtlkhjUVYCuKNb3/f/LJMe7zHUW3/FIDbiKCNLjgDjjj7KselTWO1oWIh+fa9QAgN/c4bc/XVq2uqx38ig13mxPyeZjKb9UcPNmHjwYsy+qz3OPxIXwTS4HAARi+3RliDpxzenuOOEE0YCmfRVm6S8YrE+tx7p8XpHSxsJPYkS5b46feTnmXlAtvFVtIqBZO4m1x2Wsy4w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8d7b30-53f3-456f-a3c8-08dbb9375d77
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 17:39:24.6618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YAD4yrfBqViJJvaSPm/Q7wORlQcnqCVou2QEoN1S5nBCWYQrR7tMNbSGWn4TjUAKjgFxujkez+AOx3OJwowhKtYPbjbFrPsBDPDOYPshkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_09,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190152
X-Proofpoint-GUID: LixLNSG4O0qR7ZpQJ-yIUt2lMKHqX8Cp
X-Proofpoint-ORIG-GUID: LixLNSG4O0qR7ZpQJ-yIUt2lMKHqX8Cp
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

Hello all,

I've started working on better support and documentation around
hypervisor vmcores in the Drgn debugger[1]. Of course there's quite a
lot of different implementations out there, but recently I'm looking at
Qemu kdump and ELF vmcores generated via dump-guest-memory, and one
thing caught my eye. I generated a ELF vmcore without the paging option
enabled, and without the guest note loaded, and the resulting core
dump's program header looked like this:

$ eu-readelf -l dumpfile2
Program Headers:
  Type           Offset   VirtAddr           PhysAddr           FileSiz  Me=
mSiz   Flg Align
  NOTE           0x000168 0x0000000000000000 0x0000000000000000 0x001980 0x=
001980     0x0
  LOAD           0x001ae8 0x0000000000000000 0x0000000000000000 0x80000000 =
0x80000000     0x0
  LOAD           0x80001ae8 0x00000000fffc0000 0x00000000fffc0000 0x040000 =
0x040000     0x0

In particular, the "VirtAddr" field for the loadable segment shows a
confusing address - it appears to reuse the segment's physical address,
despite the fact that there's no actual corresponding mapping.

By comparison, the /proc/kcore and /proc/vmcore ELF vmcores use the
VirtAddr in the program header to represent the real virtual memory
mappings in use by the kernel. Debuggers can directly use these without
needing to walk page tables. If there is no virtual memory mapping
information available, I would have expected a placeholder value such as
0000... or FFFF... to take the place of VirtAddr here so a debugger can
detect the lack of virtual mappings and know that it needs to use
architecture-specific details (and the vmcoreinfo) to find the page
tables and accurately determine memory mappings. As it is, this program
header seems to advertise to a debugger, "yes, we have the virtual
memory mappings" when in fact, that's not the case.

It seems that this behavior was introduced in e17bebd049 ("dump: Set
correct vaddr for ELF dump")[2], a small commit I'll reproduce below.
The justification seems to be that it fixes an issue reading the vmcore
with GDB, but I wonder if that's not a GDB bug which should have been
fixed with them? If GDB aims to support ELF kernel core dumps,
presumably it should be handling physical addresses separately from
virtual addresses. And if GDB doesn't aim for this, but you'd like to
con it into reading your core dump, presumably the onus is on you to
edit the ELF VirtAddr field to suit your needs? It should be QEMU's
primary goal to produce a *correct* vmcore, not work around limitations
or bugs in GDB.

I'd like to propose reverting this, since it makes it impossible to
interpret QEMU ELF vmcores, unless you discard all the virtual addresses
in the program headers, and unconditionally do all the page table walks
yourself. But I wanted to see if there was some justification for this
behavior that I missed.

Thanks,
Stephen

[1]: https://github.com/osandov/drgn
[2]: https://lore.kernel.org/qemu-devel/20181225125344.4482-1-arilou@gmail.=
com/

---

commit e17bebd049d78f489c2cff755e2b66a0536a156e
Author: Jon Doron <arilou@gmail.com>
Date:   Wed Jan 9 10:22:03 2019 +0200

    dump: Set correct vaddr for ELF dump
   =20
    vaddr needs to be equal to the paddr since the dump file represents the
    physical memory image.
   =20
    Without setting vaddr correctly, GDB would load all the different memor=
y
    regions on top of each other to vaddr 0, thus making GDB showing the wr=
ong
    memory data for a given address.
   =20
    Signed-off-by: Jon Doron <arilou@gmail.com>
    Message-Id: <20190109082203.27142-1-arilou@gmail.com>
    Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
    Tested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
    Acked-by: Laszlo Ersek <lersek@redhat.com>

diff --git a/dump.c b/dump.c
index ef1d8025c9..107a67165a 100644
--- a/dump.c
+++ b/dump.c
@@ -192,7 +192,7 @@ static void write_elf64_load(DumpState *s, MemoryMappin=
g *memory_mapping,
     phdr.p_paddr =3D cpu_to_dump64(s, memory_mapping->phys_addr);
     phdr.p_filesz =3D cpu_to_dump64(s, filesz);
     phdr.p_memsz =3D cpu_to_dump64(s, memory_mapping->length);
-    phdr.p_vaddr =3D cpu_to_dump64(s, memory_mapping->virt_addr);
+    phdr.p_vaddr =3D cpu_to_dump64(s, memory_mapping->virt_addr) ?: phdr.p=
_paddr;
=20
     assert(memory_mapping->length >=3D filesz);
=20
@@ -216,7 +216,8 @@ static void write_elf32_load(DumpState *s, MemoryMappin=
g *memory_mapping,
     phdr.p_paddr =3D cpu_to_dump32(s, memory_mapping->phys_addr);
     phdr.p_filesz =3D cpu_to_dump32(s, filesz);
     phdr.p_memsz =3D cpu_to_dump32(s, memory_mapping->length);
-    phdr.p_vaddr =3D cpu_to_dump32(s, memory_mapping->virt_addr);
+    phdr.p_vaddr =3D
+        cpu_to_dump32(s, memory_mapping->virt_addr) ?: phdr.p_paddr;
=20
     assert(memory_mapping->length >=3D filesz);
=20
diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
index 198cd0fe40..2c587cbefc 100644
--- a/scripts/dump-guest-memory.py
+++ b/scripts/dump-guest-memory.py
@@ -163,6 +163,7 @@ def add_segment(self, p_type, p_paddr, p_size):
         phdr =3D get_arch_phdr(self.endianness, self.elfclass)
         phdr.p_type =3D p_type
         phdr.p_paddr =3D p_paddr
+        phdr.p_vaddr =3D p_paddr
         phdr.p_filesz =3D p_size
         phdr.p_memsz =3D p_size
         self.segments.append(phdr)

