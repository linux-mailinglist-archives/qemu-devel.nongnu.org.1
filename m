Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB62732D27
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 12:14:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA6SG-0003Qu-Pa; Fri, 16 Jun 2023 06:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qA6SD-0003Ql-73
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 06:13:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qA6S3-0002sA-Qc
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 06:13:15 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35G6P0dP021001; Fri, 16 Jun 2023 10:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=pfSux2igfXW+JrFmSDro7rMSD/cR5oTtDLCEha/zOSg=;
 b=afnEo/hdLrepF2oqJQq630G/e68Qunr+wzR0zFcFWDSUbwD8NRsyJwiCncPpQbvVTilC
 QfaXt+X17JGLiYozpoftZqfMCDspVECN7rp1gPg6WEXF5NwY9fsPEYOKTn5e3knq0XH6
 fWts2cvIQQod2u1OdZgE2ysW7I8Tj6yzAuhmOdNouKSJ7AYq6VrJqx586zjYp/hI6szd
 CXdO8obhs4M/ClCeNE1BHmlad5a9loKcEpG8wx7wIGzjfjb2uNvzymBTGbaQXEEjhlEO
 Jj4sfpQO0PdfJZoZGR1VDZ1/HJu4vNl14r1x2MtoYeyXfVnkTXN6odb4vf1YCckiCjkS wQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs23ycj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Jun 2023 10:13:04 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35G9ISgF039035; Fri, 16 Jun 2023 10:13:03 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm7t3ms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Jun 2023 10:13:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgDfcxyhscIBrhsMX1Fyjwz7ZdTKPUGroyFkpYlGIzGM6D5CaU7kd29Rgw9KhaSmbLSj/TDFtkMl2+PpGhUxbUoZRX+RmL7UnpMV2tqata4D2ljINF/ZdFK6kCKCLSEZVqbEOGYUBA8vFhRJMxnjSJUg8eBJ/PqszNT3CaNZJ5cDF1eCLDRoZff0m9vIbyD6yfW63Ex531a+siwPde4YqoDqUv4FzRVPUgG1BEZH27QE+wGEBt1P9vgHMgOir0n4Eq8JThygP2SzBlMtypdaMkSPMh1+3M92870m/AP3j+KNc28fGwZKexP++IiZF2BTTVVh1dA+1l8z3sAwKfSW4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfSux2igfXW+JrFmSDro7rMSD/cR5oTtDLCEha/zOSg=;
 b=Du+wB1ORxpw1UW0lWznUPzuyjOafMkLUwukCO7tyvRGK9X2CiY5epPEvUeeXVykfwHeZ3b/RQTgOaLLp4MZAECWH7ah58SeeTz55ES7PaOXeOjhTA0L9HtKtRVFWE0wDNyz+Bp2DWm5wybNmYY25+4larDCsS6en2WW1wBAvn44QEpStFRJeX+OtG8XSKHox8/qq3dUBY/S3ESfZfhMhN5sxBfcWFQ303AnDfB+D0ZL4BIgCPD96V6Pc9Xq99ocBKD+oxv/FEslreHPnEOCFGiNyUTS4E7jK4gTH9gkYwwWSlalySRiN3cjBy2jn8Tf8dgAr2JgL3SEctvnCdgNNjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfSux2igfXW+JrFmSDro7rMSD/cR5oTtDLCEha/zOSg=;
 b=kYWLfTXAkACJ0tf6rEx74Uk/myvGvz62+kc+DiXKdmVfvWNRS5UWg+torNTXbangvnpUxGAWzJBTvJg+FpJzPIn/uZMtk0Gi9fGUzQvMxuHi3HL9cS+i8IFZO4LXEqSL+jKwRh56A6HHIRMWR76mfAcf5hzMuVdcXxezktg0eeo=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by BL3PR10MB6092.namprd10.prod.outlook.com (2603:10b6:208:3b8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Fri, 16 Jun
 2023 10:13:00 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%4]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 10:13:00 +0000
Message-ID: <b5023864-f56e-24b5-4e1b-007184484c2f@oracle.com>
Date: Fri, 16 Jun 2023 11:12:54 +0100
Subject: Re: [PATCH] vfio/migration: Fix return value of
 vfio_migration_realize()
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20230615081851.326816-1-zhenzhong.duan@intel.com>
 <67af377f-a8b7-c879-516e-9544d6a4fab2@oracle.com>
 <SJ0PR11MB6744E8D7540A3B9E540A9F69925BA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <186c9e07-c1e6-74ae-0a4f-7d6bc0c8ceb6@oracle.com>
 <SJ0PR11MB674488BE146A88E35D763C639258A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <2f3ee2ab-e37b-c429-e604-b62440d37278@oracle.com>
 <SJ0PR11MB6744FA7630BA42F4DBFB30FA9258A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB6744FA7630BA42F4DBFB30FA9258A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR09CA0017.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::11) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|BL3PR10MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 380ee057-5b49-4982-c471-08db6e5243a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brsP7OLEaI3HkyNnSGl0wzYaNsJNZkqx05GlMF0kw+375pLLM8D2yapcuID+T+5KkAvejogttuv5ln3Uk6vogRRE/M3JVTO6X39iWDWEz3ZHkIP8r86Rwt16gvgTD215NcCxee0mC30gxxogrrm52J1WM0mznwTo3+Ix/53RW9GiRd1U2Fs8Zixleo8bMOdd7fzhI/kheY/q+YGYw1GC70+zmy/dljuJDc2Ra/yRrLPNcz+dit7hIKtjvBGZhajYX69t3i2gqebvVtsMTEIfAhQyQLbHqlLdXfnWoPDqSly4ta/sj54g2jKZjzBRH5za8DR1azhXHjYHzk8F/Glwt+uI0boeSdj4JmC2HZ4fQCJ3CtWdHJGxtqBVmv3KMQCE4BxaR7tq0ByII9NKcIjD0EVOeAVSB7P4/67MMWvEgUrwg6Z4IVs22RnGUkD0JSrc/f5xsrMY1C01GszMQ7uxsb9hxIj1LwoKifh8+Mw/3iyUmcDzwbZMwxcheykBeehrCORFzyYxSDhjdzBD/s1bdXTjGCI57lcnigHvyPcCpR/YnPaT4UHs9wGVdyFwi7IDp5wk58qhCSgXT0J4oIzS9PrbbWL3Gex0wR+k2s45NNxiRkcgOnNWwk2hu8QZrNKp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(86362001)(186003)(53546011)(6512007)(26005)(6506007)(31696002)(6486002)(2616005)(31686004)(83380400001)(8936002)(6666004)(8676002)(5660300002)(478600001)(54906003)(2906002)(36756003)(41300700001)(66556008)(66946007)(66476007)(38100700002)(316002)(6916009)(4326008)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjM5SVh4TVZ6WElYM1FMTTR1TlJlclpsRWJjQVU4WUVHYno4aDJQTHBHR0ls?=
 =?utf-8?B?bmtLNTM1K01iOVg2Y3VzM0dYV1YrY3loY3RQa1JHZkk0VSt1c2lKaXg1OS9u?=
 =?utf-8?B?NThETkJMdllIVHJaYVltNVJsNVNlYzl6ZjdIa1BtZEkvbXZLUmlvUFdRUnJD?=
 =?utf-8?B?eVFPeVVoRU82eXlhOExxZVVEVksrWmd6L3kxREZBZkdmMVZGdG1nbnpnYmxs?=
 =?utf-8?B?ZTlqbzV2eWFMTE5pa2hnZEIvM2tuM2dEdlFwMXNva2hrZFA1OStSU0o0Y3BD?=
 =?utf-8?B?cmRYM2dWYlErby9DenNjbS9XNFMwRUg4OVRQcEJBUFUvMm0xSEtmV3FiWUxC?=
 =?utf-8?B?VWVwNzl6bVBpVXhaNSsvNlZJSU9EOHkvL0NsR2x4dXlYUmxEMlpYbm5XSGE4?=
 =?utf-8?B?VEZLL3AxMG1sV0ViWkxqVXFPQkJMcjE2NkRJdWJJMUpTcEdJTXNrbjFxa1pi?=
 =?utf-8?B?UlVJK0ZUOU1aQUdtSHRpYXZ4Q3J1aVZsc3dYOGpabHBzRG9HeVVXUnNVZ3FW?=
 =?utf-8?B?OGtBWHRxcHVjRFo4SmJlNzFSb1JrVFF2SHNOUXJ0M0NSNFRFc1p1SEpSS1ll?=
 =?utf-8?B?WWg3SUpEaU1JMEJ1VGZ0VzRESFQwY25pZnJHTDdtN1pjWERtZytjM0E2NFNF?=
 =?utf-8?B?R3BDQkNQRzNaT2ZxZHZQZ0ZBU3BhSXd5RzRKS1liTEVTYmlQb1VxcWRkUzZw?=
 =?utf-8?B?TmljZEtWMVhPQnU5Z2dOallCMnBCUFVWdHZOYi90WVdmQXNJQm1kRG5xaXly?=
 =?utf-8?B?WmdkeWZLNkFQZkpMUmtENTdFNjV2eG5qRkdDYUgzU1prd2xIWkF5SFM5OHdK?=
 =?utf-8?B?ZkJ3bHcvaXhCTFZvTnI2MWtLZkFMaG5HSjMwMWtqTDNhdklRQ1ZLMUJ1NWxn?=
 =?utf-8?B?M2RxN3VEeExiOHFncERxd3BXeGdDSjROUHJDNW41MHg0MDhITTdLNURSUVFL?=
 =?utf-8?B?cUt4Q2lTdjdwYjROeTE1aXFmY0xTSnFic0MweldoSDhJcjJRaEtwcndSWmZB?=
 =?utf-8?B?TG5lODI4aWRtdWRnZTNlNGUzQktGckdxTWdJb3g4U0REZ3podHNqTHkzTzJF?=
 =?utf-8?B?SEM1eXI4MnlTV0wrZWhYOHNsOW8yR1JjLy9nNDdOSGNOaWtSWHA2Vllab29o?=
 =?utf-8?B?QVRHdTRCTWlIc1JLVlVEL0JtdUxYVlNudzJyRE1JQlBDdkZlcG1ndkhKdFZr?=
 =?utf-8?B?WklPSmRIZnpSZ2pGU1czZnkvTEhKTkx3anM1Tzg3T0RHUUFEYk5qdVV5enhx?=
 =?utf-8?B?NStSVWhaaVVBU0Y5RVpwOWhSY1AybkY2eVlsQlRDd1gyand3RzdIK3RuUURp?=
 =?utf-8?B?clBhcjhCSWgvTWdyMm0yeFhwd3ladXRXd0ZIcXZody9ZaDBUbzE1TEJiRXJ6?=
 =?utf-8?B?Mm5HWVUydTZJaTB4YTJWcFU4ZVd0bEVNaWtlZUlyRS9ERFpaempXZmFqczhT?=
 =?utf-8?B?a0tUZmI1dTk4YjVFOTlmVkFZR0RnMVo3N1JTQ0pPTDFWZkpMN0FJU0Z0TU9p?=
 =?utf-8?B?SkR3RXVZT0gvYlZoVm9uSkVMVy8wOGNnU3RvcmliQXdtSmFKb1BiREdiZk5I?=
 =?utf-8?B?cVljM0FJV3N2SDREOWlidGxyWmRTeUVzd3dBSjFFTXBVZEh4T2V4Uk1iWldD?=
 =?utf-8?B?RGI4Nm5CWFJNUzdnN2RHR0RQZlVDQWZQc2RYZEtvakMwdWxDbUJRclRrZjhw?=
 =?utf-8?B?Q1hYTm5pN0pSaEhKYTJVWjlSVmVsRm9oSk9YVE1nQmhBQ1lzODhXUXlDVDlK?=
 =?utf-8?B?MzNxd3hyQlhpbjArQktzdnVML2IxVGNZYjlKZzZKWWltaCs1bmFTb29ma1Rx?=
 =?utf-8?B?R1NFaUlBZ281S0IxdVBBM1loSGYxbmdQamgvME0yeWRBTmN4UTF0YlJ5c0xS?=
 =?utf-8?B?M1lla29CNS9BY1o3dDZ1UUxvTFdRNVlBVU15b2Y1eFdGd1hkRGRpT1hIYzhL?=
 =?utf-8?B?M0NHVDNYTXllZmF0YU5IbHZIdUphSEZmT1VWWWY2ZWhMdFdxN0xBUzNCU24r?=
 =?utf-8?B?ZXBoYjRDNXgvRTZZTmRCNlVxbDJVeGN4TFFYRHpONFRiNmt3Y0M4UlFZWERT?=
 =?utf-8?B?ck11TTNQQ3NEeDFvaitpbnozOVlvNHhjNEtmTkJXKzRsc3UzOTlkV3E4d1VZ?=
 =?utf-8?B?SFUvSkFoclRETXlPc2FqZFZ3WHdmb3lua0Q4L1JBTlVtRmNtK3JxUmdLKzdu?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GlfVQrD4YzCK+JzA3Xufz286ZVsAJD2dJuJTvHdb8hNjYJmyM61K0iGE+OGzhw8JPBAtXv9BJus2EhJXLf57h4XWwATr2soTucQfcRMDc2NdWuSaauGgILmeq8UiRQdKWY/dckZNN8O5s4yVXqlhcLo/uRtsoluHk2G6wN3d+23c5UqUNFQY2AmrS+gzq0ZSps28SDdsn3D2PIMSZ6iThNfo4ZwbaGS4YF7g/+Omrp9dgWwFH41P67zuKGn7q+vQEHVpTwwL8GrZjzovSW2eVHQtDxdzgCCdjv7EoTjM9cJcc1j5HqQN0Xj3sno0xt9euft+SXWCuXYvcMFQFRoRjNp6k5v6Zn2jgD1gtCgEEFgzCKfxxrLfsr5W5oLQXgX13KxohEk3xx/IDiUB9e8l9B97K+XzgR5RW2gIivR3nt39idUqlX6jZE9yGKtlks99ePq6wqFrYzwVX2dysGjux6VlNEznL3V5GFzvT9cX0GSItPCIOoSfmg/xKHlEThWUteBYdkTt9CX/pZSxO3/ZxoFXpauDHzmWmOrvfS5Y+YtAb6iVKeMPlQucv0tCkAj51EP3vaLvHCNbiHxmqedVKhU09ttXZZJ7P8vNYxxvYHkkjenS8r63PYVUCWy9pT66cKQH57heHxMcHSonvLbQsOx65A8C8yU8TwbJ66uCu99ED3a885yiIW+uWYtS/37AaK9RIdWy+7hM+Snxi10L5+qavOZ4/re4r8AQ2CQyaGTHX0PteZ2tebkH1KDCu/EXdaJ0LhjccFgXJDKHGplkhWccoH2fS2BW2VEEeyzKr6jzkH+yneHrtIE96uWMrap8
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 380ee057-5b49-4982-c471-08db6e5243a2
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 10:13:00.4986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbHgbe2IyVv2peeLeXTFBn2Qmmuu//U3nrCElms2fzKtpnXpKJf6tKcWGvZ8nnS90ofGHDSytWLwFYnNUHt3dvIeXlUnFRoC9A1bKcrEhTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6092
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_06,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160091
X-Proofpoint-GUID: 28G7VU8QF8CZfTqsIdD-3VtJSknVL-G6
X-Proofpoint-ORIG-GUID: 28G7VU8QF8CZfTqsIdD-3VtJSknVL-G6
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

On 16/06/2023 10:53, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Sent: Friday, June 16, 2023 5:06 PM
>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>> Cc: alex.williamson@redhat.com; clg@redhat.com; qemu-devel@nongnu.org;
>> Peng, Chao P <chao.p.peng@intel.com>
>> Subject: Re: [PATCH] vfio/migration: Fix return value of vfio_migration_realize()
>>
>> On 16/06/2023 03:42, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>> Sent: Thursday, June 15, 2023 6:23 PM
>>>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>>>> Cc: alex.williamson@redhat.com; clg@redhat.com;
>>>> qemu-devel@nongnu.org; Peng, Chao P <chao.p.peng@intel.com>
>>>> Subject: Re: [PATCH] vfio/migration: Fix return value of
>>>> vfio_migration_realize()
>>>>
>>>> On 15/06/2023 10:19, Duan, Zhenzhong wrote:
>>>>>> -----Original Message-----
>>>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>>>> Sent: Thursday, June 15, 2023 4:54 PM
>>>>>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>>>>>> Cc: alex.williamson@redhat.com; clg@redhat.com;
>>>>>> qemu-devel@nongnu.org; Peng, Chao P <chao.p.peng@intel.com>
>>>>>> Subject: Re: [PATCH] vfio/migration: Fix return value of
>>>>>> vfio_migration_realize()
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 15/06/2023 09:18, Zhenzhong Duan wrote:
>>>>>>> We should print "Migration disabled" when migration is blocked in
>>>>>>> vfio_migration_realize().
>>>>>>>
>>>>>>> Fix it by reverting return value of migrate_add_blocker(),
>>>>>>> meanwhile error out directly once migrate_add_blocker() failed.
>>>>>>>
>>>>>>
>>>>>> It wasn't immediately obvious from commit message that this is
>>>>>> mainly about just printing an error message when blockers get added
>>>>>> and that well
>>>>>> migrate_add_blocker() returns 0 on success and caller of
>>>>>> vfio_migration_realize expects the opposite when blockers are added.
>>>>>>
>>>>>> Perhaps better wording would be:
>>>>>>
>>>>>> migrate_add_blocker() returns 0 when successfully adding the
>>>>>> migration blocker. However, the caller of vfio_migration_realize()
>>>>>> considers that migration was blocked when the latter returned an
>>>>>> error. Fix it by negating the return value obtained by
>>>>>> migrate_add_blocker(). What matters for migration is that the
>>>>>> blocker is added in core migration, so this cleans up usability
>>>>>> such that user sees "Migrate disabled" when any of the vfio
>>>>>> migration blockers are
>>>> active.
>>>>>
>>>>> Great, I'll use your words.
>>>>>
>>>>>>
>>>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>>>> ---
>>>>>>>  hw/vfio/common.c    | 4 ++--
>>>>>>>  hw/vfio/migration.c | 6 +++---
>>>>>>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>>>>>>
>>>>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c index
>>>>>>> fa8fd949b1cf..8505385798f3 100644
>>>>>>> --- a/hw/vfio/common.c
>>>>>>> +++ b/hw/vfio/common.c
>>>>>>> @@ -399,7 +399,7 @@ int
>>>>>>> vfio_block_multiple_devices_migration(Error
>>>>>> **errp)
>>>>>>>          multiple_devices_migration_blocker = NULL;
>>>>>>>      }
>>>>>>>
>>>>>>> -    return ret;
>>>>>>> +    return !ret;
>>>>>>>  }
>>>>>>>
>>>>>>>  void vfio_unblock_multiple_devices_migration(void)
>>>>>>> @@ -444,7 +444,7 @@ int vfio_block_giommu_migration(Error **errp)
>>>>>>>          giommu_migration_blocker = NULL;
>>>>>>>      }
>>>>>>>
>>>>>>> -    return ret;
>>>>>>> +    return !ret;
>>>>>>>  }
>>>>>>>
>>>>>>>  void vfio_migration_finalize(void) diff --git
>>>>>>> a/hw/vfio/migration.c b/hw/vfio/migration.c index
>>>>>>> 6b58dddb8859..0146521d129a 100644
>>>>>>> --- a/hw/vfio/migration.c
>>>>>>> +++ b/hw/vfio/migration.c
>>>>>>> @@ -646,12 +646,12 @@ int vfio_migration_realize(VFIODevice
>>>>>>> *vbasedev,
>>>>>> Error **errp)
>>>>>>>      }
>>>>>>>
>>>>>>>      ret = vfio_block_multiple_devices_migration(errp);
>>>>>>> -    if (ret) {
>>>>>>> +    if (ret || (errp && *errp)) {
>>>>>>
>>>>>> Why do you need this extra clause?
>>>>>
>>>>> Now that error happens, no need to add other blockers which will
>>>>> fail for same reason.
>>>>>
>>>>
>>>> But you don't need the (errp && *errp) for that as that's the whole
>>>> point of negating the result.
>>>>
>>>> And if there's an error set it means migrate_add_blocker failed to
>>>> add the blocker (e.g. snapshotting IIUC), and you would be failing here
>> unnecessarily?
>>>
>>> If there is an error qdev_device_add() will fail, continue execution is
>> meaningless here?
>>> There is ERRP_GUARD in this path, so it looks (*errp) is enough.
>>>
>>> If I removed (errp && *errp) to continue, need below change to bypass
>>> trace_vfio_migration_probe Do you prefer this way?
>>>
>>>     if (!*errp) {
>>>         trace_vfio_migration_probe(vbasedev->name);
>>>     }
>>>
>>
>> I am mainly questioning that the error testing is correct to test here.
>>
>> IIUC, the only one that can propagate any *new* error in
>> vfio_migration_realize is the calls to migrate_add_blocker failing within the
>> vfio_block* (migration code suggests that this happens on snapshotting).
>> Failing to add migration blocker just means we haven't installed any blockers.
>> And the current code presents that as a "Migration disabled" case. If we want
>> to preserve that behaviour on migration_add_blocker() failures (which seems
>> like that's what you are doing here) then instead of this:
> 
> Current behavior(without my patch):
> "Migration disabled" isn't printed if migrate_add_blocker succeed.
> "Migration disabled" is printed if migrate_add_blocker fail.
> 
> I think this behavior isn't correct, I want to revert it not preserve it, so I used !ret.
> Imagine we hotplug a vfio device when snapshotting, migrate_add_blocker failure
> will lead to hotplug fail, then the guest is still migratable as no vfio plugged.
> But we see "Migration disabled" which will confuse us.
>

/me nods
 >>
>> 	return !ret;
>>
>> you would do this:
>>
>> 	ret = migration_add_blocker(...);
>> 	if (ret < 0) {
>> 		error_free(...);
>> 		blocker = NULL;
>> +		return ret;
>> 	}
>>
>> +	return 1;
>>
>> Or something like that. And then if you return early as you intended?
> 
> Yes, this change make sense, I also want to add below:
> 
>      if (!pdev->failover_pair_id) {
>          ret = vfio_migration_realize(vbasedev, errp);
> -        if (ret) {
> +        if (ret > 0) {
>              error_report("%s: Migration disabled", vbasedev->name);
>          }
> 
Makes sense. Checking errp above before printing the tracepoint (like you
suggested) is also an option taking the discussion so far, but perhaps the
return type to be bool to make it clear to callers that this is not no longer an
error code? Maybe let's wait for others on what style is generally preferred in
error propagation.

	Joao

