Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2E37E2F65
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 23:04:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r07hS-0000Lc-Bv; Mon, 06 Nov 2023 17:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1r07hQ-0000Ky-Fb; Mon, 06 Nov 2023 17:04:00 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1r07hN-0006Im-R2; Mon, 06 Nov 2023 17:04:00 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A6FkZhD022018; Mon, 6 Nov 2023 22:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=nsMpA6cOfVtaZmG0mxpAtEq5zd9ltHuV3orvSACb4rw=;
 b=t4dF1AJzWVF6niFZX9jMbPknmd+Xnog7oNgF9yqqyoH1reELH+jMVk5/PU12INvf4VPM
 gINXAxMdAhP9LfuJi/7gTKK9wlE/APkF3rGUpokBIZMFk1lI/5IHY+E6kp57yTmJlErB
 itSW0/yY8Kv44W4cvaJdg+DczWcZLJdExQ8VXqRhQectUGJMoKOHzE5jxFpPsuAeomKC
 UqzjhpO4UiGtUmFtmQKp7/DTWoxfs1vS5w8tPrer5gw6/0aVETSYJrenPRrvsUgnCJhd
 v/sTzAdFIuP/h4xAA0FMOE4bg42RqKCuFIy/fP4O3/HJ5hkMvrB4K3NWpcb34NzIfxCz CQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u5e0dvj6s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Nov 2023 22:03:41 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A6Ljemb026947; Mon, 6 Nov 2023 22:03:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3u5cd5v832-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Nov 2023 22:03:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hm5e1HoRNXeSN9bpTE+DZFQwCIgD1VOJ8crSg6dUmAsn+uInWYT5INMPK6JWDWzmFQCCNV4aOpGe1xg279Ves4ksBlpQbN599TwW5/NQxMWSr3FSWQJKzAv7kir2NeqzAZD9kZEf3yAHaw+kn0hx4404RQwT2jbX6+prMbHCTYS1gmTthPpCeo51KXzdO+/uWHE9OpXWVUGKeVleED5xroIeA2jQ/Z2jKDYNpBv4qkP6Av//EQD0wP3t6OmTooOgYymGJeMzuxdyoQ017m8CxUJfgbOh4qHSlG0CYunaleLzRbgd1uxL1bT0aHArCW1YO/fsag2dFTnGVwzvEJlBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsMpA6cOfVtaZmG0mxpAtEq5zd9ltHuV3orvSACb4rw=;
 b=K+wmwvaFMCxhKmMhUstIjVaOReq3Q/LOGrjcm6GngTsusUZ8AF3ucGXEkq/UG5wgVS0izIpoT1DKKgmuhmCU+VYOjRlyH+q2r3Jg7nOtoYKKh6pDQQzpbJ0gp5Kfqsm+iEVIT9KmfMeAVzCcWOIPcRAScjjfKtAdFgf75Oy0rNM2Rq5BmqKJK1b/nuLSHepw2gAbKtMi0wPQ5a2hb4us2aOgeXgmbJIp7IHKbzRMwbhxALwpgeBM3QnNUr6BDK09Q248+X5aE0Wx6zfEVPBK20uezQpPfJUO8OENyzln5Fpku5cN8HSnXY5iSUEL2Yws/ycuI97WIa+RWyqMk5pKPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsMpA6cOfVtaZmG0mxpAtEq5zd9ltHuV3orvSACb4rw=;
 b=E/PMi7z+eRea70E7nwFLOpZW95yJaf+DyjFw2/xbU5SUF31NKc7Dy8KAK6ikI+TTEer6ghHRItaRIWo3q+jzHC/h9QhSmSNTfnSB3CIr9EqGbwYda2wdd2AD84RVDBrEiAeRPkPwqmNFqUcFclvY37jErmc03/ndEnW/dSM2BPo=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by DM4PR10MB6790.namprd10.prod.outlook.com (2603:10b6:8:10a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 22:03:34 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::a7ee:d2c9:c03e:6ec2]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::a7ee:d2c9:c03e:6ec2%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 22:03:34 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peterx@redhat.com
Cc: lizhijian@fujitsu.com, pbonzini@redhat.com, quintela@redhat.com,
 leobras@redhat.com, joao.m.martins@oracle.com, lidongchen@tencent.com,
 william.roche@oracle.com
Subject: [PATCH v5 0/2] Qemu crashes on VM migration after an handled memory
 error
Date: Mon,  6 Nov 2023 22:03:17 +0000
Message-Id: <20231106220319.456765-1-william.roche@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <ZS6ksf8o7dJ8mzUe@x1n>
References: <ZS6ksf8o7dJ8mzUe@x1n>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:217::21) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|DM4PR10MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: fc2930ae-2180-4227-511e-08dbdf143846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RycGdWWK+Mxxy5J9+6X8J0S0MGDqcL8LLYHv7W7suWt5Bqk+jaS+mML8TIzBkG8c8NGTqovUXMKzyZJTgJxGfNoiE2cKNCwqLLY4rvq3c0QQ+DgrqJpq93bLmx+WxPMhkwHsnTZA7lwe9UXi3WTviq74qAH+/duGxOvaACdZMm2YRbPeCs3mxSBLclvE7ASY3EflgQskw8WBK5eA0K628fKyh3jdLypBAE38i4f1fdJOucma9cqWzmhipRHbrLSMSXvfurBU7NQWS3BflY8fCdf+QFFX/lP75WkQDN7FsljbXFauz+e7Nqj7rHAvjTgRXEg1Ehc41eurAoI5MJ3tkp9y1YF8i4gqQ+nNq0EjVJDi7m/0tv1+2oLLlQBL9gSr3ca/rqYCXb2znAbYikFy5wpJITpe0q20dZ76+jTKLPcJnDMZkg6+U1IUbUw6XhA3f9iUixWKQBR0av4mjff5bYk+faK4j+Qz5/Y4Dm66bVt0mAltyj5t1Bn6zLGlwowBCrIhKjr7D0aybp1TaDw6rrIlEO2mSUYyX1uRxUYX24E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(6666004)(6506007)(83380400001)(6512007)(107886003)(1076003)(66899024)(2616005)(66556008)(2906002)(86362001)(41300700001)(966005)(36756003)(5660300002)(8676002)(8936002)(4326008)(66476007)(66946007)(316002)(26005)(478600001)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cPpbVqiBAl2MknORkCxgcowOgypEexBAaP8exQPq9xKfARFFO9Yl0Mm1hcY8?=
 =?us-ascii?Q?W/E/JQn3spWmYJdffN0/En9gpE8F48YPqvXNeW9URBAUsVOTAAryGqpAhCSu?=
 =?us-ascii?Q?lxoZ61pXEk0e3c8bG2rbQXlO3bGdECENcktywV2GD0kRp0WvjCOLMoxX9Vp2?=
 =?us-ascii?Q?13pUjpWZeuZxBfnQZTF3KVG9DeUG5fvz6enXNXteOK5CCZRNpi9TCS5INVrt?=
 =?us-ascii?Q?eNMy9SDUZNpoK55y54WcA/hyYyBMT3xKfc+8H8tuoR65ILqdhrJpLa+ws44Y?=
 =?us-ascii?Q?6Zdk58ufEba8ydjbpoTuEW0M0sH6Tq5OIOQg9IOD2H4nZfZa6kdEfXE4YwEM?=
 =?us-ascii?Q?8r14aRPXkJOwCECB/SRFf78SiONiB3gpRtuLm4OY3S/7oiuADN2HOknct6P5?=
 =?us-ascii?Q?w6yaoFvCS25wvSZn0Fh8qV6iq/kZXnh4DNd2o4XdLTRjhrwd0r2cGAjMdMtQ?=
 =?us-ascii?Q?7RlmAz94d7KRonONsfez5ep8ejSK7NGzYOwgSV38LUBYdfpOX3wPH3LiMVIC?=
 =?us-ascii?Q?VkjBIDpW8fyNeRTVHmgnKjZuzRJWuZcQ5ZzsgZGQh04cF04U3BiJfAu27Ck/?=
 =?us-ascii?Q?xqz8CdfB1fghUA9jk6tQ32AtwfxZqH7+pP4AOr+Rpo1ygBXjxWrvWQq26XXC?=
 =?us-ascii?Q?PHTx5VObGmyZfI0WQJEf2vVC1enXG0eExb2rRBn5072R9RuPCAarSEc0y7+W?=
 =?us-ascii?Q?TbImo6oOh/JvDycQ6sR/FLNAml6l1kZURPiJytcD9dYlBT4HbsXF+IFooqkh?=
 =?us-ascii?Q?zI+EtwH9iXfUfrJquXE2KNVlvDDfK95i6M/I7mG9FEmDZxJ8vjhnh6zmpFQy?=
 =?us-ascii?Q?Wnzz6SW7HpH5op0MmIIxCysW1JOMojobIXRt64Wv7AIHd/nE9Z5KWgYOUTd5?=
 =?us-ascii?Q?UMNxdCr5QV6ktN9rzfkj/foZhkVoRIngohnWxXDNbnRo0fH0FyLyKcxRHOeQ?=
 =?us-ascii?Q?lPLf1Oe9hdlgIyOIO24jjxOYQ8YvTQYqW2eF0416K9HGAYwvmKFUbk0OUsdG?=
 =?us-ascii?Q?dLsqvbtORd2+sSksBXOqHkrLXxsv+sYm5C649MdBBLXIijBiMLxwd/fAzQ3Z?=
 =?us-ascii?Q?j7SyDwh+wvmjgI55Asq8A4M1uregC3CoaSz/DMPHdjcOqX11Kmyt2l5ftUT/?=
 =?us-ascii?Q?rTFbbMHAePhBfSVIzJyagjVPYsqMywDPdabQlA0bN5oSxxUNUndEk3QP597O?=
 =?us-ascii?Q?bO3IuHEQppLlUb2uB/KqSv7Xmk8iyXd/hShweDPDmrrzIOnsVEH4vKiEhGwL?=
 =?us-ascii?Q?zFQHsC3XQM/XpFLdP6acsse/ujFknPBoWvkKG6UQSgXslYAO5L4sqhaCvsOv?=
 =?us-ascii?Q?EJuhLRVxudTBA9xi+Nx9UzD3WfQTh8VyDNRxcV6mWbvKa0wMsBFKPYmjhDB1?=
 =?us-ascii?Q?i1XKs69tE7qdkZFsGR63WfNHXL8Or5YZI187pWUwoZmmNVXyIPSfJz+GYUeG?=
 =?us-ascii?Q?sPNIR1War0paGF0LNG7lRaBGI2OknkLf971/XxP8leAImICPw1tQogYX2zY+?=
 =?us-ascii?Q?ThJ7uyM9aR4oePWeOE4q86MzLDNS6kQnxCwCFHyTXBb3G0vH1+P+4m4LrY3B?=
 =?us-ascii?Q?cplUFBR6XKVy6lmJ4rMNetLTSgHDWnb5gZj3927zfleveFf7nCfTpt1Ye98F?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: avsJs0hIi9W2QNoCJmEEGq6T2cCa/kiNvKzUbN2YYkeOStoT8CN4agelRx64Nroz3t4KWSFVbFejSgkfhOVPJFHj8dT/lB7R/C2hAoixSJcJYvfQuzAgaWorKvttYnuhI5KrEwaXsVV+99GEUH0vz6+72mqJrRyF9e+f5Y1TjSAk+tk7/huGTHPNnyK0TrutgjGe3kApNMQDP82i/I4OFBb27q4fC64Ch6sZnNhIAWy+sN/CSQdzmDKsUud5TwIEbHEb5488MIuOa7um5CedtzRQOtNVzGYaC4+xisYkgw2NRE7EQ9n4PEp5FV7g0fPfYbcZi2afTJeyjPvTuJB+2y62Tw+zZ459fS656GVPTlS+tjxwljFY6wGisqEVCvc2udjSMlLoZrVebOWuMQVs4Ouc45WEs+FusK5MJX55RLIKtF39ZKbOhwrZ7jdqpdt/YqN19hdbIq7RbVbgblupnyVzK6LWz6ZRakDidHpAySNquOOnHrQP0TB2kEOgbjtGm0HHfG/YSpMXsDWmvdFnT7rXv7AMTHb3DgRttUoTx48f0e6N3Bipzc3/TmXCCFZYz/ELtlODSHamkj7Zcic6o2kzQJ46ZDXTthztnPYz6R5iYU/wKLF7vhEKXsvqON9QZokrHxsPuilxFguQ8aJE4lWpmU0Kc7UdULh/vc/x6Y3FP+HsW2IOVc9vZ4hyB1VEPx/EUYp639Jc2OLBNRJMlcJP7eCehpKIjFSK0IlAtHDG2r7UTl/2NzZhUnB4M6ajKkQnb1XlEi3D/ygYuYtIXWOXuEz4IpxSmLl7hL3XI7q8wO0sVDD8Ut9mBweyOwHMCz+nGenADkQFrJXF1sKjiA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2930ae-2180-4227-511e-08dbdf143846
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 22:03:34.0935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmR6OyslxSJUjheiY2AmOBalvMuLqVxS9yI3hiwmZkKGmIkpCTXk5kS5z2FJvJw+gWtyqcKwi6Iia4koffF2691f1YrbyCheaeio5MXzZpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6790
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311060181
X-Proofpoint-GUID: 40VD6yW_oqsn9UgQ6B2qClQaI5lc4NBh
X-Proofpoint-ORIG-GUID: 40VD6yW_oqsn9UgQ6B2qClQaI5lc4NBh
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
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

From: William Roche <william.roche@oracle.com>


Note about ARM specificities:
This code has a small part impacting more specificaly ARM machines,
that's the reason why I added qemu-arm@nongnu.org -- see description.


A Qemu VM can survive a memory error, as qemu can relay the error to the
VM kernel which could also deal with it -- poisoning/off-lining the impacted
page.
This situation creates a hole in the VM memory address space that the VM kernel
knows about (an unreadable page or set of pages).

But the migration of this VM (live migration through the network or
pseudo-migration with the creation of a state file) will crash Qemu when
it sequentially reads the memory address space and stumbles on the
existing hole.

In order to thoroughly correct this problem, the poison information should
follow the migration which represents several difficulties:
- poisoning a page on the destination machine to replicate the source
  poison requires CAP_SYS_ADMIN priviledges, and qemu process may not
  always run as a root process
- the destination kernel needs to be configured with CONFIG_MEMORY_FAILURE
- the poison information would require a memory transfer protocol
  enhancement to provide this information
(The current patches don't provide any of that)

But if we rely on the fact that the a running VM kernel is correctly
dealing with memory poison it is informed about: marking the poison page
as inaccessible, we could count on the VM kernel to make sure that
poisoned pages are not used, even after a migration.
In this case, I suggest to treat the poisoned pages as if they were
zero-pages for the migration copy.
This fix also works with underlying large pages, taking into account the
RAMBlock segment "page-size".

Now, it leaves a case that we have to deal with: if a memory error is
reported to qemu but not injected into the running kernel...
As the migration will go from a poisoned page to an all-zero page, if
the VM kernel doesn't prevent the access to this page, a memory read
that would generate a BUS_MCEERR_AR error on the source platform, could
be reading zeros on the destination. This is a memory corruption.

So we have to ensure that all poisoned pages we set to zero are known by
the running kernel. But we have a problem with platforms where BUS_MCEERR_AO
errors are ignored, which means that qemu knows about the poison but the VM
doesn't. For the moment it's only the case for ARM, but could later be
also needed for AMD VMs.
See https://lore.kernel.org/all/20230912211824.90952-3-john.allen@amd.com/

In order to avoid this possible silent data corruption situation, we should
prevent the migration when we know that a poisoned page is ignored from the VM.

Which is, according to me, the smallest fix we need  to avoid qemu crashes
on migration after an handled memory error, without introducing a possible
corruption situation.

This fix is scripts/checkpatch.pl clean.
Unit test: Migration blocking succesfully tested on ARM -- injected AO error
blocks it. On x86 the same type of error being relayed doesn't block.

v2:
  - adding compressed transfer handling of poisoned pages

v3:
  - Included the Reviewed-by and Tested-by information on first patch
  - added a TODO comment above control_save_page()
    mentioning Zhijian's feedback about RDMA migration failure.

v4:
  - adding a patch to deal with unknown poison tracking (impacting ARM)
    (not using migrate_add_blocker as this is not devices related and
    we want to avoid the interaction with --only-migratable mechanism)

v5:
  - Updating the code to the latest version
  - adding qemu-arm@nongnu.org for a complementary review


William Roche (2):
  migration: skip poisoned memory pages on "ram saving" phase
  migration: prevent migration when a poisoned page is unknown from the
    VM

 accel/kvm/kvm-all.c      | 41 +++++++++++++++++++++++++++++++++++++++-
 accel/stubs/kvm-stub.c   | 10 ++++++++++
 include/sysemu/kvm.h     | 16 ++++++++++++++++
 include/sysemu/kvm_int.h |  3 ++-
 migration/migration.c    |  6 ++++++
 migration/ram-compress.c |  3 ++-
 migration/ram.c          | 24 +++++++++++++++++++++--
 migration/ram.h          |  2 ++
 target/arm/kvm64.c       |  6 +++++-
 target/i386/kvm/kvm.c    |  2 +-
 10 files changed, 106 insertions(+), 7 deletions(-)

-- 
2.39.3


