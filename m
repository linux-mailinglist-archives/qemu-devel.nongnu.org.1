Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E1B7ABBD3
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 00:34:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjoiG-0002cY-H1; Fri, 22 Sep 2023 18:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qjoiE-0002cP-53
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 18:33:26 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qjoiC-0006w2-3U
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 18:33:25 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38MLXw1e004334; Fri, 22 Sep 2023 22:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=tuLj9dBdz30EbOl6TI12xUMjLrRrGSrOSOWAT/Mcm1g=;
 b=BUAgRJJggKTGCprWxaPYJsb3A3C9Bzh2ldxhcGqtxkA1EaaqPojOUxSp38XcFrKCbNq3
 4WT7+mXxmyxixRAxqNN7ySCO1F7wo8wIEJbFbiArmjiW/k2DDIEDF7DYwAUeGYaDV4yw
 ljKmFH434Mzbp1viFvJM136cCqcaztnzq5eM7bebqQkQT9P7wJweSmhtw4o52Rnw3nGD
 sbMBw/IjHyjgexYnMd/e8OeCTv3XPcBzkgrZifZOpV2ifOrf6OYD+UqgLzdiag/pIZK9
 rMX2Q0beXNimMtaUU+nQ/ztaBnYQzG58Qb2cALcXEt2HpkQdkx5lad90mghC81+xM4/e 4g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tswk0xs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Sep 2023 22:33:22 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38MLI4P3007773; Fri, 22 Sep 2023 22:33:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t8uhdd9un-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Sep 2023 22:33:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qqg0adDUumtksh7Z05CUos63C7mFnREQAqu8+9Ia9CXSHdNrodkWLsIFbPMp44sLtXfP6Hem/NH0dKEVITFFgT/Hg88VrzTCQYf5mqOxyVW6QsYmesd43HIba5WLGswq4+OPrsCAPvyp6rux6EhEY3RpClLWH+gc+6lELGAVJz+cAuGlkk4Kk6kjNk+HmTCCfIVOqManYtTP3wIqFs8SW3GgERQuu4cpuG/e8Kj38zeLB+pbhQeIK8qQqoLn8BExtNq7KLEKogyD6gzMh87+oOqgFMbqV/ntgWv8PKYzeAbIShnMQ77TJfmFVQPfT0XLXAxwEIRrTYOhiWK7D348WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuLj9dBdz30EbOl6TI12xUMjLrRrGSrOSOWAT/Mcm1g=;
 b=c33jpDUWe5d5yU28JM51898NlVeXtFLmF4AinAmumYr2DbrrFIt15OjGwzGcPAb6M/GnkYATiNmK4EWa25sOGr9l/6gAGNhtF1ifiagNY7redVsS8dcL/rD+PV+k8iI44mR/Fr/ovcEChCe7iT5d80zfbBfuWcPhjzB1QMsrTRL13TkWyinI5YTSMNCaalR0QepOakwD2iypg43+OHTSXdXj4Ux52WTz6lssWUk9f9MrP5tGG2TyFIKeRalxx9DHn0ewIyZM17+r3/yLDPA4VHK/pCmctbE2drmDSXE82avGBa7FJSi1iUILrlv94Hl5t7Irrqnr42eye3gwYdQljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuLj9dBdz30EbOl6TI12xUMjLrRrGSrOSOWAT/Mcm1g=;
 b=bJWfpjA0uiOdp5GNY46TTqs/oDoXP1sKPqUJyt6xSFoctVb5ImY80O4Ut3+pGiyiUCOS+CVRO2gDSsS6jyuxpNugtOVunZyQsI4lBm8GlpH4BMPj78qmUeuKb1ST4OP73FdgKOfWBKnvgw4HKlmLlsXLDReyaMuhROh82nmJnwY=
Received: from BYAPR10MB2869.namprd10.prod.outlook.com (2603:10b6:a03:85::17)
 by PH8PR10MB6313.namprd10.prod.outlook.com (2603:10b6:510:1cc::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 22:33:19 +0000
Received: from BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798]) by BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798%4]) with mapi id 15.20.6813.024; Fri, 22 Sep 2023
 22:33:19 +0000
Date: Fri, 22 Sep 2023 15:33:10 -0700
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [RFC PATCH 1/3] migration/multifd: Move channels_ready semaphore
Message-ID: <o66r3yvserkbkfxczdweqpr3vzo2fj5jix2dv4hs22g32alqqh@lwk6qjp3fi74>
References: <20230922145319.27380-1-farosas@suse.de>
 <20230922145319.27380-2-farosas@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922145319.27380-2-farosas@suse.de>
X-ClientProxiedBy: BYAPR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::42) To BYAPR10MB2869.namprd10.prod.outlook.com
 (2603:10b6:a03:85::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2869:EE_|PH8PR10MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: 0add092f-56aa-4a6a-bdb3-08dbbbbbebad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +WSUf6cv8yocl5vj9IY1pGC4x6Lpnhvkdf1GgKtMBCob2oHL2Xc/oqwvowa3dRnjtYYfS2z80Drs3ULlRFQ7dHX1dejOpIif/xr4IwsLMYb0dLoX4mQJh06B6nPB44/kFg8r9+Et2nylPBEbpsjx7zFTSQd1rxa4dXcm1sYyxyYfXUYO/0nKg0opyqQaomv1Kxw1jBu/wLR53ajruyAkQSRa7sSvGmWetbAUOfxmxf023yYo4gE+pNOxfXFXlkiwRQrOOmpsxQmz5Ag8exuE7FKDBnaK9opslTccYoZObjp4WpxTdREpLVqsv8on3mZh8SNZ7NbAdE+t3YOCrQ5KCeo+UOWA7XwQWPaF6b0aW/2xlHG87mvmTm163sTFMSVBbAmYlID2+iaJyyrH1ZY7psIigwLGTQ4IIIHy1N9kKRL1X1U10eTb6kVaXayOlQk4LjafaLSYWPUermD20u3m7vMcLDtYG4uj1CtxwBhtSCRbYq29vdGUDuX0c0aWm7a9vTYjFyy/yKPU50Q4CNwWW0l7ztqgebhUAJCR6H9C+W0ThmBPGajBvkCFlpQxPgHJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2869.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(366004)(376002)(346002)(136003)(39860400002)(396003)(186009)(1800799009)(451199024)(33716001)(6512007)(9686003)(316002)(26005)(6916009)(38100700002)(66946007)(54906003)(66556008)(66476007)(41300700001)(478600001)(6506007)(6486002)(6666004)(4326008)(2906002)(83380400001)(86362001)(8676002)(8936002)(44832011)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FokFuE0KoqU4bTy6HOrnjbZCJkawNZ8O53CnKc6wkjc9fl597y4EPY31id0X?=
 =?us-ascii?Q?5d1uBqaTbn612vJgotfqGvIGeJPERzuc/UjIYWRbitCkqyLDJDqzkqfM7kRK?=
 =?us-ascii?Q?GYDt5j+pvI1+DZLbOOoatEx4UPdFab8IFjpSVYGDrjjUgo1kIAzwujYlfwXo?=
 =?us-ascii?Q?jbBU1u/++6iA7IdS0TznFErOv1V2f6TwwXUrZXflT6+LJRduQMcmwngkSrtj?=
 =?us-ascii?Q?Ni9TdoDRyC9s9MoJcoxTtHcWAiMIDBwY62qsu74Aw90zGX0zGyl/RVzdPzCn?=
 =?us-ascii?Q?g+ksMMK94VLbI4QAQU8L57AV1i7mnD4MKVUTSKmpRKslO7Dd//+lR08kV4rQ?=
 =?us-ascii?Q?p4apW6P9BkfEU+8NrhjD+BFlBurvVDfrRWYO1J5Ey08PPrBpoSj26FPqXYWh?=
 =?us-ascii?Q?QuIbE9TrSXfzC+IP01BFTOD9UxZ3nRXGdakiYRXYdFluy/PRdIAoMMUSE2cY?=
 =?us-ascii?Q?ok2rV+T4Jo0dmbfqKyrhy8xPP/Zccg8bZbp9c78+/GtPD2YtJ/cHh2nU50FK?=
 =?us-ascii?Q?iebvLjcSVRfHOITwFUzHIpJhNZHjAKW9030qEWyoSkZRPt79VpAKzyMdh5Nt?=
 =?us-ascii?Q?SqHqbKRPPZpKXH4PijHdFqfaAiyorSLvkOniXAb2JQVKlMyvg0fn57Uslssx?=
 =?us-ascii?Q?GEGnN2J8s6hgmPDydy2gSauSqwzCqGX1ihVWpWB4KxhyqyM3UfavWfX7jlYd?=
 =?us-ascii?Q?+ikvKXBovaXJjS08Ll0ZEWwnX5wQBBI56XTEeoDOaPLaGZHGHuhfHYYmv0ff?=
 =?us-ascii?Q?JhC0ytK+BFuM+2l1KzB+KiLjQs2j9lriSzuZi2Akr4pyWLo3z3dx4QgJoSD9?=
 =?us-ascii?Q?+hyPHhbGx4FheK0cmDDY4An7z/E4CZ8XybmL+IV1k4hGBlAV1PPEPrMMjJcC?=
 =?us-ascii?Q?CODhcmx34W7j/z3JdWI+MsV8QN/0hh/6wHsJodHGs/1d0Eg/d4N5AbHsWAK4?=
 =?us-ascii?Q?wOA+VEFIMd53rFN2m3XwZ2zejl0xyhhQ6PGf48VqkDi5QWMgfwiG97zeo4bX?=
 =?us-ascii?Q?vrU5iU8A5rChyk907eOSrEc07nq68/Ub36LRk2/kqBC/rqfu9rem+dsyagm5?=
 =?us-ascii?Q?cU0jPe7Yl3SqTlvObFu4f4RPNbzcHJ1xPTVitNE4fp+Ih5NUY+l6Cw7Kn7+4?=
 =?us-ascii?Q?W0WOeyehJrCk/gskWd4+AX+yyH1Nca3ZgN5doehhg5Qhx9fLrCj3iyKo6Lzk?=
 =?us-ascii?Q?vL5OE24dPjXPVxYK0o2+fX5ZVGLzk/b2vCjvMQZZAT0XpWLqPmEq22w+u7R4?=
 =?us-ascii?Q?HHUJBL+AVwX+3FLxtud32Qp9sSPHeixghtcRbxnf47xUkUPomdzoyjqkHmba?=
 =?us-ascii?Q?RjZAFKyGHXJBQpvd/Jy4ikPR2yFo8g8VYxp2qwjU7iw5AvtZ7dHnXY/ZsJ0E?=
 =?us-ascii?Q?15gyGf7a6taG8wQAacKz3zSBZqRH1IH4FGgDrAnMEs9D7atFnwpbErvvMeDW?=
 =?us-ascii?Q?QK9/YIKPrz5/RRkEQh2oWs4hnfKu1dLjOXgMOWPNTjmsRFzKYidSbGyQ7J5O?=
 =?us-ascii?Q?oGEcSEuYUQdIIu6PtDv1YjV+3gVYzhUlSOXJlT52tMmpggt5sSVhi2F9pM7o?=
 =?us-ascii?Q?68+9BmhkpZuwfHmN0M4xsziQBAC6zN7xslSbQrG6VG4xrZP/Bx9IlbDmSmrH?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jeDCzLo7FhiyFD/EgI6RFF5ubQrfkNdy6v6b1hLBrMjNy+NpyDGPofmGg2JKi3hPxNi0SHpwZV2ov5h1Q1qkC0Kvn5r2334CUPIJnuzO4rtlyGi3wGuZBcwjOLXxXQpw/4/P1JxucFh21rm2AVAt8sNlpj4blo2XhqmtCZlmvnpD6CsHvGcFjb05qJCuVbEa0EtpZce+DjOAq9myKS9kFPM59TQt407gBMaKbz+zA11S72jFCv4dMPp7J9q0BXVBIBo+dx8mrjiGql+xKgiZwVXuFYgeb3WBl4RnBC2uPotprKhtKKeCisQYBGrOebSP8yGQtg05U+lr1v6cF0GIh3QLEorrPBtkrHgJkC9hHhKJ8L0OzUzoKTogj1oSa+rnTwaJjmCXhRSLBbCKudU50+sKE1hzlYthl3sJUrniq9EtM37cgGnVhZViobfE5peqOTpRU5inJ7FpTyCvtQuzpkrf3WN0Xvon8tkXfYQNrK6kNmu8n8zA/IPaR6yrR0b8MRbLu6x2skJnXbwRpshS7LuldcFSxxnEVUYEb2cdQ2i0nLAiUp8ZZ1rnEHHhuIEJHF6oWGqx7DeFf2CyKyFcuNhdkcUBc7XGvxmNRcwFQQBKfaeihp0YCiY6LGrb6BShnX4pzip+CZqb+9G6PpRf9CPaaeuLvePL6LzdPGqKn5SiltSAEdmcWLBerDMU5GgIEjORDjyuXN1S0eaac/C6xAOyGEDVhrXaPgE4iwku8AgajXSMff3GJdtlzjusSXWBu6iv636uzs0YTTyHVZt5P3tonkgFr4E/8rZKMi+tR4Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0add092f-56aa-4a6a-bdb3-08dbbbbbebad
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2869.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 22:33:19.3809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSOYGLQiD5HCSchJ78OjvfgFwfC101gKbDOirDeWR5OZIXTWcM8V5OiyfuG7mtDeBTGIVDWGBJjqkHHNMuD9KpeHNNlNA1R9qG51j0Z5Rz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6313
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_19,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 bulkscore=0 mlxlogscore=768 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220193
X-Proofpoint-GUID: eExav6rTe9TBdsGwp0yUCBhuvwTndYYU
X-Proofpoint-ORIG-GUID: eExav6rTe9TBdsGwp0yUCBhuvwTndYYU
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

On Fri, Sep 22, 2023 at 11:53:17AM -0300, Fabiano Rosas wrote:
> Commit d2026ee117 ("multifd: Fix the number of channels ready") moved
> the "post" of channels_ready to the start of the multifd_send_thread()
> loop and added a missing "wait" at multifd_send_sync_main(). While it
> does work, the placement of the wait goes against what the rest of the
> code does.
> 
> The sequence at multifd_send_thread() is:
> 
>     qemu_sem_post(&multifd_send_state->channels_ready);
>     qemu_sem_wait(&p->sem);
>     <work>
>     if (flags & MULTIFD_FLAG_SYNC) {
>         qemu_sem_post(&p->sem_sync);
>     }
> 
> Which means that the sending thread makes itself available
> (channels_ready) and waits for more work (sem). So the sequence in the
> migration thread should be to check if any channel is available
> (channels_ready), give it some work and set it off (sem):
> 
>     qemu_sem_wait(&multifd_send_state->channels_ready);
>     <enqueue work>
>     qemu_sem_post(&p->sem);
>     if (flags & MULTIFD_FLAG_SYNC) {
>         qemu_sem_wait(&p->sem_sync);
>     }
> 
> The reason there's no deadlock today is that the migration thread
> enqueues the SYNC packet right before the wait on channels_ready and
> we end up taking advantage of the out-of-order post to sem:
> 
>         ...
>         qemu_sem_post(&p->sem);
>     }
>     for (i = 0; i < migrate_multifd_channels(); i++) {
>         MultiFDSendParams *p = &multifd_send_state->params[i];
> 
>         qemu_sem_wait(&multifd_send_state->channels_ready);
>         trace_multifd_send_sync_main_wait(p->id);
>         qemu_sem_wait(&p->sem_sync);
> 	...
> 
> Move the channels_ready wait before the sem post to keep the sequence
> consistent. Also fix the error path to post to channels_ready and
> sem_sync in the correct order.
>

Thank you Fabiano,

Your solution is more complete. I also had in mind getting rid of
sem_sync.

With your second patch, this one could be merged with it?

> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/multifd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index a7c7a947e3..d626740f2f 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -618,6 +618,7 @@ int multifd_send_sync_main(QEMUFile *f)
>  
>          trace_multifd_send_sync_main_signal(p->id);
>  
> +        qemu_sem_wait(&multifd_send_state->channels_ready);
>          qemu_mutex_lock(&p->mutex);
>  
>          if (p->quit) {
> @@ -635,7 +636,6 @@ int multifd_send_sync_main(QEMUFile *f)
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
> -        qemu_sem_wait(&multifd_send_state->channels_ready);
>          trace_multifd_send_sync_main_wait(p->id);
>          qemu_sem_wait(&p->sem_sync);
>  
> @@ -763,8 +763,8 @@ out:
>       * who pay attention to me.
>       */
>      if (ret != 0) {
> -        qemu_sem_post(&p->sem_sync);
>          qemu_sem_post(&multifd_send_state->channels_ready);
> +        qemu_sem_post(&p->sem_sync);

Can this thread in this error case be woken up again between
these two qemu_sem_posts?
I see in other places p->quit is set to true before it.
Or maybe it should one more patch to make these consistent 
as well.

Elena U.
>      }
>  
>      qemu_mutex_lock(&p->mutex);
> -- 
> 2.35.3
> 

