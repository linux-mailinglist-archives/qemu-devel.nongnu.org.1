Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0D37ABC3A
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 01:20:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjpQE-0008Es-7g; Fri, 22 Sep 2023 19:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qjpQC-0008Ek-AD
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 19:18:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qjpQ8-0006SK-Pu
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 19:18:52 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38MLY1wK032149; Fri, 22 Sep 2023 23:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=1+GeMc82C7HnyTeJ/pNtCMl7fFD5Yzb6rcetdZpUJPY=;
 b=dFnETmrEmzZo3rin/4soXAHu2E6gDs3Xg4M+QVfpl6sIcNUJLRKpGi2VPSplQW8jI6eM
 iMGRMZjKW8l/FrGOirKqsv+Xvm1eKJNnXkqo7IZZN82qkpG8Iiv0SsIqF7fj0LG49if2
 YmGF/JX/fAfeqJlv4usobNtDftwU9dZVlieLS0vFHafXGlgpJRCg/I2eLc+ogiT3lVFt
 Z3YMxFr8WV5tHp9xkK/3qlt5640kwl+0iDdC+kUwqDnDLAlbLSiNMrV7/lu6go2dEtD9
 dIBYyfr5M4VjuZlyV+l1ESK0WUnXJ/VRbmso3v0j8vHzEUvyydXsJVQPr+YN6Fgcuqbb lA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsvu1jb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Sep 2023 23:18:46 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38ML6WRj016710; Fri, 22 Sep 2023 23:18:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t8u0vrnke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Sep 2023 23:18:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmwyvV859ukDJVNXl5Oop61N+ZVoaE0LXbCoMJk6I3Qq1Cq6ja2dgvLveqqJzf2BvMgp5gw0sEakpazO8ALCpKki4fsNsQnAcMMwcZt1dlcZLyDnLCoDapv2IMYahNLuWF4LCvf8cj5G/Olc9u2Je6tMPCCUFKBwKTVPfVP+hP8gVs1axCe2cp0QFKxfLIR9nZ6Tk383kQeUi0GHDeVwzBnJdUhdv3Cs+MXEpWwBWKLYVBdcn9Z/9I9/p726Ov/hf4WiTJQXPL9USJjzFTaHdtcX6ac8fFDNumMXVvn92F0U8Zth1zSxSCCR3THGIDgip1jV52/GmZ5lHyrx4RHLUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+GeMc82C7HnyTeJ/pNtCMl7fFD5Yzb6rcetdZpUJPY=;
 b=K7wacgeqiNGRFh06Yed8srUTp5LmyMdpmx8OSXPLrNyZyyv+ZYnWHIWARm7H1amhPMkaMiIIkhiuozyPE2iN8GB8EXxMaW/CMoeBHrwFtFk8zgjUdHpO34qgQkPv3Vecx44Np+g2s9/NPDjmbavRVB9v305wjsCKplf/tqdTsAbd79P3BJfi5tM9PtixPMrOa90ehEhyXUBq5mqE/b1PE1Vz0wu236F/TwloPYHbl/mRJWk8wRjQYvS8qcDr57qFak05SK5kC340IxBQxpf7afji3CT2nAFKoCGU4C47Mg9WFtg2Fohze67bhQaCJIKTjLglWtWq9DjSSLGUWb50/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+GeMc82C7HnyTeJ/pNtCMl7fFD5Yzb6rcetdZpUJPY=;
 b=r0PoG/edegmObE5QZ6H8Tj+YqNIrmTbxIgVI5u/M6F2m3zmwOs3Uih1hfgLLRU/z/NZ2cP81lTzkVByamnkX4wURmHm59XJZpAy4azOL9Tdn9Z5S8g/bAAujX1yV6QwDtkZvvwxRdtgwwErVsfmahDvij4903GpLzIQTIqUyCZA=
Received: from BYAPR10MB2869.namprd10.prod.outlook.com (2603:10b6:a03:85::17)
 by MW4PR10MB6323.namprd10.prod.outlook.com (2603:10b6:303:1e2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 23:18:43 +0000
Received: from BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798]) by BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798%4]) with mapi id 15.20.6813.024; Fri, 22 Sep 2023
 23:18:43 +0000
Date: Fri, 22 Sep 2023 16:18:40 -0700
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/4] multifd: wait for channels_ready before sending sync
Message-ID: <yuichvhaevd6pfedhgbjdkjpzy77jngudka4xpdcsk5hges4mo@gveqzqzmsx2h>
References: <20230922065625.21848-1-elena.ufimtseva@oracle.com>
 <20230922065625.21848-2-elena.ufimtseva@oracle.com>
 <87bkdumbtu.fsf@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkdumbtu.fsf@suse.de>
X-ClientProxiedBy: SJ0PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::24) To BYAPR10MB2869.namprd10.prod.outlook.com
 (2603:10b6:a03:85::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2869:EE_|MW4PR10MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 0717d9e4-6fc9-4780-d9d8-08dbbbc2432e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5lwbkLgr86/XddQOimjNPfUdprcexk67b6/s0pireQoXwyLTn9VVvm+KiIdrC+AO8bQ83Op0pE/mk8LBi5kVNKamrm5D1e5YGhOQUpRt29ZogBmSqOkvsp/muIclFtwfxx5Jq7qRZx8NZOrbnsjqnf3CKLwlif/TA6ZBdyjPnIzLx1iRK7aAlOT2WqRra5dC9JEIQ3AWzlj4xf/shlTKzNlqanxuvz7zK4t96Yl7ph7k2kJyo0D0N8/yLDfIQMPySB644rnyJaAeR1DUFbugCWMldKsrgKVwPwpxpoLk13Abn56Ag1bmRePhSyCXG4iq83RKHd2bbBtxR4fQnPVBDHivr2UkNdNsTdaF12BJlR9O3lqkgrkldpNEVbbQe80ITmOiPo1k08hEcrFL9PRzulRyenzOs6qY7fRFXm11F8zuyBEfpPgswb5mPiVISVzlZda+AQpfukblY7QKs+ZUWTbFnTRPeFtR/mDMoWA2mIu/L6XH1C4eMoksnw3CFeIEhNZEVoozS2cuD5O0cMcX66AwTZeLj9/Azwp32ZXKMacm7ws/pk2F1kjnvfwXUQl8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2869.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(136003)(39860400002)(396003)(346002)(366004)(376002)(186009)(451199024)(1800799009)(6506007)(478600001)(6486002)(9686003)(2906002)(5660300002)(33716001)(6512007)(66946007)(6916009)(316002)(66556008)(44832011)(26005)(66476007)(8676002)(4326008)(8936002)(41300700001)(86362001)(38100700002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ne+WzWWrC0zediCE8lAF5siEQf2tdt61png6MynlfDai14g7EJWjvPu0tV2g?=
 =?us-ascii?Q?sn1TaybhJGtB9uNQEet07qVTMhLkvwxcygCfbDP6gtPBW6x+M+G56p5ArGeZ?=
 =?us-ascii?Q?qgf3OwUZ7NL/3Siq1KJIR8ZDcr9kGc/nyZNhkDsXZvLG3tgg0RO4WAOdy6v4?=
 =?us-ascii?Q?6zpTl7ZyBA3BSaSPrxFkb/T6yRE31nI0C3ozTQxe6S+cWkkAg29zLUxa4JRV?=
 =?us-ascii?Q?l+3/f0V6vzHEIyyvSfE+ugF+XuwzIH6wjASvvUcOhzb9sUrJNRuWBLWXKgZE?=
 =?us-ascii?Q?u9j86HYaUDuVN3fDBTxlwzq1bLcyWtHsFFSS9leE3IrpLC86Zm8RqxGkfkVA?=
 =?us-ascii?Q?lTfb9v2PjdvEdq905F4V13Q0osN4xu7sbwbttbHjm46Gmo446aBiDJE5POLF?=
 =?us-ascii?Q?eM66QJVYs74yN/DO7wU3YVrLU0HB9F0DWMipB32ZTjdRWNyD1Iccc/7hm1M7?=
 =?us-ascii?Q?Np/lUNizWFNPQvaOdQp+mXr8hlTnawnlZRfLKlBkY8zBcq4Sh2ENh/cMdJ6v?=
 =?us-ascii?Q?lbpiq0T1MavXmryWE1UVnPVuw60GFTdH2tQYcFx2UKvTLbu/cYwiMXy/Roz1?=
 =?us-ascii?Q?3B5nlS7sw/hSOUF28C4CVcoUHq5f+DO9ZnOLk8oZc+j4kJboSlT78iX7PSni?=
 =?us-ascii?Q?6A1aJkcv12IJgeTd8f6Xh4ODMabYrXhyGaPpF/DrQByahCnQ8YYAPfHR9Ru9?=
 =?us-ascii?Q?uRa9Jzwdnk63Z//zfrcnp5SQ/RvAvoIQn5nt5buc8sduCDv2gLfDVIBK83T7?=
 =?us-ascii?Q?AB5nbrDX9OmSc86nOBVZshAm5KDzHdeL8eDbefOSF0yN9dBTJbFZ9O2UWsnb?=
 =?us-ascii?Q?18qL3EY7Wg4cNeZIVgaY1PzcPeT0lK8H6tqjUCu2LMsPHqS7cCzdu52OJ2rA?=
 =?us-ascii?Q?PlDvCrn+7xO92Co9wYptRpOeCQGBIEoHS1RVOntDRivmDc9ijtgmRJ9rpmng?=
 =?us-ascii?Q?nKpNe5b27NpOGbVaMM/TdFmfVLbmQEEtShSIJo3/SVGk1IfAaqAUWsLfyyO1?=
 =?us-ascii?Q?PtiiF8X76/cMg+TpS5DqGPkLB6prLiqIDWax8dP1Uk7YdJlmdJRRLv4RHeif?=
 =?us-ascii?Q?C12xHr4iRHx6l5vHltsTUkxnlPGmpC58Obl1pQXJcgWwEU+nU/orvv4znGMf?=
 =?us-ascii?Q?gtVv61gnjTHd/JxVR7QxmuMAKUtMDlhFtvsAMR2rif1yo4i4aslOOCRfJyyf?=
 =?us-ascii?Q?A5J0J26P9Xwb2wPp+vw0WGrc2gcod/RtcKpZFPMnBhV6+ANlYA7zYdUe8wBr?=
 =?us-ascii?Q?RXD6faQoATyNBAgmhZEm95QeTPsOxghiL/FdUrU/BS4dO9whzMLJrA6kGtYy?=
 =?us-ascii?Q?CdJMaf2lJD9Y+VBpEMiMBLJHSUN0/VVsS65F0b3cDkC6Ap5RGTrqB93q8MxD?=
 =?us-ascii?Q?cAwxEkZAEx6YcPgRCUv0r2Y4oWQkI89d0TIQeDV80xodqyWed4smU/QJ24xe?=
 =?us-ascii?Q?DkvaYFyj+4UhCrJ3XGJhYyucbCabOB+QRVBeBMIouxx5rKqKa5jNz6z0VuYj?=
 =?us-ascii?Q?dJUUrYsXeEaDTwCybzJPzr5KWkCZVG2jDjW1pC8c/tSkqV2c1OQVaYzbNXvP?=
 =?us-ascii?Q?X102i2j9K8dMDOTYHq1tHskSxRwrP1PVtDd4miCFYZNrgvlS1bsyITuGdiRi?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: j5R08jf0JL8T1guSrg5GSTVgMqCtsYPvj3Vx34Jai/Q78t4DA7inv7Ma6kDt1qoPJQZMCumFUkY647xG1VmwTPCU+7CG543yjPqlJEqyP5XbAXgw973TJqzMzcEf0ltfTvdf2n1B9m/mEI3XKI9MKQrPLdKdGA+Sz6UjUx79R67qD/b7AvWN0x8bS2b6XoDnN0EOAJgpgCB4fsoq3N9IvYdYftM+oKetORvl+XOI7fnldjC02v5RXamnDcGhhkTgqQwDcr5BflKm2OjxXN9FARXFGIEmgTpE6IvIdm1pQJo00vWvm1L3drawlrw1dTbTyhUe/MyTrjvqquZEn+r3mpqvIGaPdQ00Of8eIct9YqqsJx5zRheuWGjHdAY1Jgxza36IwQBCDBzNJYQOoClpayyj4ahzY1+/oFLO1eaBOiKJpZdIB1bqlcPFe2Hj6qyogEzlPyaMTxv2CarCOOTimR9/HxROXyFxJZRDB9T84FIM61enSRwDq+Yuj/73DzqnzyGD+uCMSd5JszmTcRK0atnsAbpNd9jjOhLhwFy3Gr16FBFEu1ek+boy/TXX/H3jOFXcmWrR3hPrXDgsdQUVqYOqbcI0kDxdAvy2meFeXNVMviB99vKNFXExzM+DXcWT6olP9myL8NOjuSPm1y02ntcDOJH3iVoJMavyhDcPFC02RwQaoLsAErBp5MKJWUsAgM4WrHWl/kzmWmjHCkyAqfkpWhd118V9F33RH+CU2yllndRiFsaIuU3Se9GnyZaHBI71Mamv3UoUkjPlYcnQsGbO7ihEtqwTncThjOStv50=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0717d9e4-6fc9-4780-d9d8-08dbbbc2432e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2869.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 23:18:43.0813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctiulb8hVVbXOWuFonq+ISQNMlMyJOYfEyZrQmcNuHm6HKkf+5xLgGVK1yF1fkI0xAf7zHnb7EAnmgu93e6XMIK9SZZYW1KRmxq21z24x30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6323
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_19,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220200
X-Proofpoint-GUID: UyOHJ-ARCL9VGXdh9owjRnijUr1Fo56t
X-Proofpoint-ORIG-GUID: UyOHJ-ARCL9VGXdh9owjRnijUr1Fo56t
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=elena.ufimtseva@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On Fri, Sep 22, 2023 at 01:06:53PM -0300, Fabiano Rosas wrote:
> Elena Ufimtseva <elena.ufimtseva@oracle.com> writes:
> 
> > In multifd_send_sync_main we need to wait for channels_ready
> > before submitting sync packet as the threads may still be sending
> > their previous pages.
> > There is also no need to check for channels_ready in the loop
> > before the wait for sem_sync, next iteration of sending pages
> > or another sync will start with waiting for channels_ready
> > semaphore.
> > Changes to commit 90b3cec351996dd8ef4eb847ad38607812c5e7f5
> > ("multifd: Fix the number of channels ready")
> >
> > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > ---
> >  migration/multifd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index 0f6b203877..e61e458151 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -595,6 +595,7 @@ int multifd_send_sync_main(QEMUFile *f)
> >          }
> >      }
> >  
> > +    qemu_sem_wait(&multifd_send_state->channels_ready);
> >      /*
> >       * When using zero-copy, it's necessary to flush the pages before any of
> >       * the pages can be sent again, so we'll make sure the new version of the
> > @@ -630,7 +631,6 @@ int multifd_send_sync_main(QEMUFile *f)
> >      for (i = 0; i < migrate_multifd_channels(); i++) {
> >          MultiFDSendParams *p = &multifd_send_state->params[i];
> >  
> > -        qemu_sem_wait(&multifd_send_state->channels_ready);
> >          trace_multifd_send_sync_main_wait(p->id);
> >          qemu_sem_wait(&p->sem_sync);
> 
> Please take a look at the series I just sent. Basically, I think we
> should wait on 'sem' for the number of existing channels and not just
> once per sync. Otherwise I think we'd hit the same issue this patch is
> trying to fix when we loop into the n+1 channels. I think the
> assert(!p->pending_job) in patch 3 helps prove that's more appropriate.

Thank you!

These patches make sense to me.
Agree on redundant sem_sync. Lets see what others think.

I will run some tests as well with your patches and spend
more time looking at [2/3] patch.

Elena U.

> 
> Let me know what you think.
> 
> Thanks

