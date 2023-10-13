Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1507C8853
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 17:10:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrJmy-0006hj-7c; Fri, 13 Oct 2023 11:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qrJmn-0006gt-Ls
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:09:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qrJmh-0006qo-T7
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:09:08 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39DE0qdJ015824; Fri, 13 Oct 2023 15:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=9NGLnzeExwvPio1+2RRv9UvPCjx3i4nSEDwNTEC9Mus=;
 b=wQMiRoidRAF/5v+ILEoOTdx80tgSKpfrnYLk3kSpo110BgJtFJ7lSnuVu+9Da1ndEJok
 YpWgnjsv2f1VZhIhoj924AkNyVG8l4dMLScRrMx5l5r95NC0XMqK9htJxWP/4h7Rt8Lp
 83N+A36yd4tHB1YFoeN9tBsXBgbRD7sQ5xj2WzLtiOCYJZrSKIDFWxyiGkG8nSODVVgB
 sqzkrHZH1mxuxtWEnX3bBZR4EnX+TuIejfKX6g0vGMaMARQRbfiPhwossutndocETXnx
 dEP5QCE8ZOm2tTIwVyH1phkOS/YlkA6Lcsp9VrSxhIIYAvBKMRlMEUTucNECoiuCfGEa tQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx8cna55-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Oct 2023 15:08:59 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39DEshUt036812; Fri, 13 Oct 2023 15:08:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tpt0ug7b6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Oct 2023 15:08:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgtoOVgF2goqIuzkCpjeIEYR4bxkwCEPFKKBXRS7r2feKhcGQch33nQo0gcAZhLcoSXxnSHg42rU+mdSwAYVsfax5JaBv8An4XkfrYiOM2XGc23DwjdS+HvhpS4A8VW6ekO0yPEiF1c8C8QKTuK8TLE3TirVD/m+/60Z/g1AWFnFzl8JDIyNc3T5BxWCyC2/2kYpRTyeBg3FZFNdUPIMTprrehPcLhuresI0L+UGfRtXw67NfSA+rh0zhlU+bNvYlC2tkufnzEIQNowtfEkoI+BwX4ZTFcWP7GJMKc9qhAjwbmd/MJ2sHaWpVbQZY4E6U0CD+/2hQ+h/RVkKVl1/jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NGLnzeExwvPio1+2RRv9UvPCjx3i4nSEDwNTEC9Mus=;
 b=KEtDSL6y1lHLApY2wiysJnpvxlPyF8bt14csCA/qR/E9WEv3RhbH3d8Gpmi59KLJtEf897TdiOhMSllAwHeJMEo+xVsjLfZrvpEWhBG2Rjq6vmhZ/FGVphduonShNPb/0orwyI1u6UVoM8EsOAsdklnsE9Ns3Jr0KfiGF7SG5AdfFXH1DIactZ7scKqxoXXvi2tl1ZhiY3cDvHjyDus1k/XPdSt4xvSH1ZUPl7SuRNSoZJmVepE/Z5Wl7to1Y1rUx+TqmSsZYcj1rfRGP13/AamQK3DKFgHxqSgY33kRm+CKp5rljRsdZRyvBmBCWavFOtw41DGzN2p0X2HCSC4wgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NGLnzeExwvPio1+2RRv9UvPCjx3i4nSEDwNTEC9Mus=;
 b=foXqfGz1DIgUfelYalIC9Zw3BdMa2TWqqpwRqXQ46fKGxERgNtl7YV+4/6jGsfWXzHPAEsoLkDgneXsQEWB7txEs/icW3Onse1TJTFIFNwsf4W0es1BNKWdoBAnd8MOyS3Y0htbGo4jJN27h4sYazG5LK3BIvCbEoKEc86IwXYE=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Fri, 13 Oct
 2023 15:08:55 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885%4]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 15:08:55 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: qemu-devel@nongnu.org, peterx@redhat.com
Cc: lizhijian@fujitsu.com, pbonzini@redhat.com, quintela@redhat.com,
 leobras@redhat.com, joao.m.martins@oracle.com, lidongchen@tencent.com,
 william.roche@oracle.com
Subject: [PATCH v4 1/2] migration: skip poisoned memory pages on "ram saving"
 phase
Date: Fri, 13 Oct 2023 15:08:38 +0000
Message-Id: <20231013150839.867164-2-william.roche@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231013150839.867164-1-william.roche@oracle.com>
References: <20230920235301.1622672-1-william.roche@oracle.com>
 <20231013150839.867164-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:208:32a::14) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|CH2PR10MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: 4039f06d-e81f-44dc-8e44-08dbcbfe5165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9cKIPFJ6LCTajYTjoU/vfS09NTrqubUI3rCmR/g9zjM/hSSQm07v+DrgComR/WzjxbUbsTlNLzjXlJasUDinkbExRJ3tKmeNYodSIirIeLlfB1AcZ/rU5FwHQ56jf8vVxJANFw8UzirUQuGwg5xR2cYMoaXSsJf4THssj786g3M3qDEAdWvd3bpSZIh5uArxsEV9hnCgjypWhvVIq4oC30Zi3qAbMWmAuXoxB0BPmSly6UlO0xFCgxvCW+gdGjddNd8Eyx4ioWSSnmCslGyhMGOUBXjFQ+zRFRaNIvqB7DoSNA2hWbItGbQwbDUd0x0MU3Pn4BD05DKnZEV1+pmkjKJ/GOAl5mK3xAjk3rIIl6fmEHOG271qBWEr4hmQbqvlRPHGRvgS8Xqc0NiBIwOVEZ4ga8FJ1hZIlZx+2L3zUpRxejUg3KpySxR+xuaX5hk6bck4PuLvOHd7fcoaDZoH/zW1nyVovQqLbjmiJ6U8ISRx6xmrRVTjb46IikE4kJXFDud01M9B9Yg2j5ZV+gmD08+wML4H0xg/2DT4KdMg2v9jAin49UBTLNWVKbh7pbs1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(86362001)(38100700002)(36756003)(5660300002)(41300700001)(66946007)(66476007)(6666004)(2906002)(8676002)(478600001)(8936002)(6486002)(6512007)(4326008)(6506007)(83380400001)(1076003)(2616005)(107886003)(66556008)(316002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V+o3AVbKF53DdSlwv/bh5/9jeBCsAd3j4ujL5BmHSJa1Y3P0HxaPA3Iyvnj5?=
 =?us-ascii?Q?0XHi+yBr3LLjepGloAvDq5fVyIku7YBXmThEGMcZpmTxHunXAv7NgyXz/aXp?=
 =?us-ascii?Q?Sv8qf93YKihT81eapwNSEZoRKI78nmwdPYZmVbdekBckstxnsFm792I+CdVI?=
 =?us-ascii?Q?ZwYFxFvT+6tPKjdDrUqC8nVa0MyxA/7dzIntVoOmSiJS7eVwuc8mT9BQ5icY?=
 =?us-ascii?Q?7amqFw7JWSjQ1LRBbV7H2Riff+iLTMw4ZKqmt6ComNP4XumY1lRCtIokZCDr?=
 =?us-ascii?Q?yr1uSfOQwasbowJO1Oe06tAZEZ3eMHAda6FWynY04mVC0Ib3p/J167oxkGXy?=
 =?us-ascii?Q?BeCs4xurQskpKS/GaZyvxKENqr4eaovEnMPxyjys8qhbl4vOSW+LQJqg77YA?=
 =?us-ascii?Q?gsZ4vEcDA2TJAN2G48Gj1+D6h3xZP67QkrZrmn02lxRDM3Hf/fnSOMr1s5uv?=
 =?us-ascii?Q?m3ryQZxGwTh67gbDRtcaRmikpTbvtXA/X7sXMJj5nJVMuOnm47ZJuWqspVpb?=
 =?us-ascii?Q?wJEBp05o4HHP9ZrLJzKMO/9DUzRUBFcSXbB5ScejerFhC7BEv1mhaWE8bi6q?=
 =?us-ascii?Q?mCqBrltpvku71inJdGvgsXljUFiTH30GSlgMioX49/xcntEncLbBAZLRBlej?=
 =?us-ascii?Q?AE4/GRvXNdYbIGj7WgFp0ifViHn9RVSioHcvT4puODqClQ5axn9ifoXsmYh9?=
 =?us-ascii?Q?aU74ytblp6uJjVuz6atAg93D+kdUvFdXAMAdR86+LCDf+HUkqG/mEsfQ0bYa?=
 =?us-ascii?Q?eha+NsFs/YP1llPVZYLnBO6aHmOTX+YXXZoH9wFOpGNBnPLQ3t83PNvCkZfq?=
 =?us-ascii?Q?nyD6xAA4CGEbxavBdO0qqsOs2Ci7K5OJaddnLo5qzQ8HNTIx+D2nmRl3KUq9?=
 =?us-ascii?Q?dd/5x3ljmsCJhucLh4D9eAP0ZW/wBp3GubTfA+rMXIyTPpU1LeZ+/52zZL81?=
 =?us-ascii?Q?tFiBU/eVvbYq11SyULkjO0anu0y4n9AXNCHQaMzbcs/iUT7SusmeMXyNbfNk?=
 =?us-ascii?Q?I4DZg8FtauJXiWcztz/LvizhLXSj8qQiPiix4ppf3zL48wOMC6mwzD0M0crf?=
 =?us-ascii?Q?yUyLMQ+FC4oXIiC1CXIZNG6973bNHi2U+5ZymW5tAT/YLo8J7SsecdNT1/d0?=
 =?us-ascii?Q?39eD4H/tMCwkuQ6JEq7IWyRjIrg5E4z8V/V2I1Uv1Oc3RcWsuJHWAuAVbuqx?=
 =?us-ascii?Q?fbQfmQ62Ag/N6zGnvGqaN9nelEIWGyvyE/K06JB/VhODN7mvWKwOijgHm1u6?=
 =?us-ascii?Q?2OEGZJ0BImXbLS7r95Bew/8Jr9jAO0gKG02NSk1uTOkT20xFZN+0DMNZcKOY?=
 =?us-ascii?Q?3pV6yssZfeRIfXs3t36MRLjJr8DyMqLf4UlZvyup+nmAD2EyGLKaR4xrhl9R?=
 =?us-ascii?Q?iINYoiVz6OU3d08ZFmsN2+zS00SKZ9DOx7ByF2jn/eKS7Dd5EkVcmYiDje9p?=
 =?us-ascii?Q?i9SrEcTotl/3Tuwg6Bv45PNcUTbkdS95ocqafk2xYddHhvMH3nQHYIYhKZzY?=
 =?us-ascii?Q?apxOxqM140BDiLjf6RkJc+tUJBkUtnj2dQsbZiUgm8q5Lv4H3zl9tv8AO39T?=
 =?us-ascii?Q?94gio74IXpA7UzsTK/2yaF25FNzs/9G+QT3h7MShexlAXyrgqcFAv1qeyKjD?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KhGV0zcZT+gItiVfHdy5fo6xHhpJ/rpNPh50Z6AmpQ7YX/PfyiWDQS7NgotwxYl1YsT7YCERHIz7u/Ej8n6Ra+dYvVNFamzoTM9CFOOtmtRMZnl0fUAnl8vZOUxfl5lMPRWlca+MWSCtbYZZq33rVoWvGmzarKgxD/6sXMJ7UuIw7fW6o65aT3RSXvguri3C8VYGPkCA6Uq1jJ3U2/z/a6P4OpuFMt9oglbHUF7lmJbI3qWywnp2GS/YhkUWclgqc99wa/ZBs0P44t0GpTove3khebs4Lm7McxtFfNHFN22U+fokZbL6jloUv0ZUO9t2wrAo5/gc8o1x7qPL8pZcUdYZ/x3lo/mTKaEe8GiDR5QWwjtUcV0wk/aapvS6VVUmY8as7o7KVvNxaoymXihwWeO14fkXFUT3W2lQpAYRQZ6bihH/IKsMX0Po0f4QBNqIY3A7/k11aKEMeAO/1VcT1AIuMDZj5gAUszKqILTIY1ZnfYKon0lXsrGUKKFEYHpG4fa8X1YtrBMKYNkCU+ShY+udo83Xl6DA4J4RQfSfqE3aQawwnZHwpdqsVoRGAAMytTRXuOvK9YJK4A6fpMwMLhIj7XeFIjTqZJLCNsknFxARDAva/7jMCsffoXj7Sqnjvvct0OQrKWlqdsT3BqrsU8AYD1qAxXtB66OWFTQu2iKORVMKKFPAMrMUZFOh/Mxsf77UTzSRtFn3FAxHeTfwtVIxo6wOSbCTfEglb+1LeSa0ACy7qoo2o8nLcbn260lsxmTqtzr/3OU3tRlmiUwAAKSwSDhuTZEdtHLP65Dofcud7MH9HHm7N2bnbzESWW6F82QdfBIh1AcgKmv69p9ppg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4039f06d-e81f-44dc-8e44-08dbcbfe5165
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:08:55.5175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mf2AqLgPRO9vNltVTOVEzBa32oERbZG5WrqpENpXmSXwfobXFqEdNepWhRXouXsiy8XrbniOGEEkztBtz9F2m0ZMcqcICyYqO0pTU4wJxfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_06,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130128
X-Proofpoint-ORIG-GUID: IgBG_4vI1lWABJ9Mn2vl6i_Sq0Y2hfKT
X-Proofpoint-GUID: IgBG_4vI1lWABJ9Mn2vl6i_Sq0Y2hfKT
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

A memory page poisoned from the hypervisor level is no longer readable.
Thus, it is now treated as a zero-page for the ram saving migration phase.

The migration of a VM will crash Qemu when it tries to read the
memory address space and stumbles on the poisoned page with a similar
stack trace:

Program terminated with signal SIGBUS, Bus error.
#0  _mm256_loadu_si256
#1  buffer_zero_avx2
#2  select_accel_fn
#3  buffer_is_zero
#4  save_zero_page_to_file
#5  save_zero_page
#6  ram_save_target_page_legacy
#7  ram_save_host_page
#8  ram_find_and_save_block
#9  ram_save_iterate
#10 qemu_savevm_state_iterate
#11 migration_iteration_run
#12 migration_thread
#13 qemu_thread_start

Fix it by considering poisoned pages as if they were zero-pages for
the migration copy. This fix also works with underlying large pages,
taking into account the RAMBlock segment "page-size".

Standard migration and compressed transfers are handled by this code.
RDMA transfer isn't touched.

Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Li Zhijian <lizhijian@fujitsu.com> # RDMA
Signed-off-by: William Roche <william.roche@oracle.com>
---
 accel/kvm/kvm-all.c      | 14 ++++++++++++++
 accel/stubs/kvm-stub.c   |  5 +++++
 include/sysemu/kvm.h     | 10 ++++++++++
 migration/ram-compress.c |  3 ++-
 migration/ram.c          | 24 ++++++++++++++++++++++--
 migration/ram.h          |  2 ++
 6 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 72e1d1141c..850577ea0e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1152,6 +1152,20 @@ static void kvm_unpoison_all(void *param)
     }
 }
 
+bool kvm_hwpoisoned_page(RAMBlock *block, void *offset)
+{
+    HWPoisonPage *pg;
+    ram_addr_t ram_addr = (ram_addr_t) offset;
+
+    QLIST_FOREACH(pg, &hwpoison_page_list, list) {
+        if ((ram_addr >= pg->ram_addr) &&
+            (ram_addr - pg->ram_addr < block->page_size)) {
+            return true;
+        }
+    }
+    return false;
+}
+
 void kvm_hwpoison_page_add(ram_addr_t ram_addr)
 {
     HWPoisonPage *page;
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 235dc661bc..c0a31611df 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -133,3 +133,8 @@ uint32_t kvm_dirty_ring_size(void)
 {
     return 0;
 }
+
+bool kvm_hwpoisoned_page(RAMBlock *block, void *ram_addr)
+{
+    return false;
+}
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index ee9025f8e9..858688227a 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -570,4 +570,14 @@ bool kvm_arch_cpu_check_are_resettable(void);
 bool kvm_dirty_ring_enabled(void);
 
 uint32_t kvm_dirty_ring_size(void);
+
+/**
+ * kvm_hwpoisoned_page - indicate if the given page is poisoned
+ * @block: memory block of the given page
+ * @ram_addr: offset of the page
+ *
+ * Returns: true: page is poisoned
+ *          false: page not yet poisoned
+ */
+bool kvm_hwpoisoned_page(RAMBlock *block, void *ram_addr);
 #endif
diff --git a/migration/ram-compress.c b/migration/ram-compress.c
index 06254d8c69..1916ce709d 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -34,6 +34,7 @@
 #include "qemu/error-report.h"
 #include "migration.h"
 #include "options.h"
+#include "ram.h"
 #include "io/channel-null.h"
 #include "exec/target_page.h"
 #include "exec/ramblock.h"
@@ -198,7 +199,7 @@ static CompressResult do_compress_ram_page(QEMUFile *f, z_stream *stream,
 
     assert(qemu_file_buffer_empty(f));
 
-    if (buffer_is_zero(p, page_size)) {
+    if (migration_buffer_is_zero(block, offset, page_size)) {
         return RES_ZEROPAGE;
     }
 
diff --git a/migration/ram.c b/migration/ram.c
index 2f5ce4d60b..5a53802ddc 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1137,6 +1137,26 @@ void ram_release_page(const char *rbname, uint64_t offset)
     ram_discard_range(rbname, offset, TARGET_PAGE_SIZE);
 }
 
+/**
+ * migration_buffer_is_zero: indicate if the page at the given
+ * location is entirely filled with zero, or is a poisoned page.
+ *
+ * @block: block that contains the page
+ * @offset: offset inside the block for the page
+ * @len: size to consider
+ */
+bool migration_buffer_is_zero(RAMBlock *block, ram_addr_t offset,
+                                     size_t len)
+{
+    uint8_t *p = block->host + offset;
+
+    if (kvm_enabled() && kvm_hwpoisoned_page(block, (void *)offset)) {
+        return true;
+    }
+
+    return buffer_is_zero(p, len);
+}
+
 /**
  * save_zero_page_to_file: send the zero page to the file
  *
@@ -1150,10 +1170,9 @@ void ram_release_page(const char *rbname, uint64_t offset)
 static int save_zero_page_to_file(PageSearchStatus *pss, QEMUFile *file,
                                   RAMBlock *block, ram_addr_t offset)
 {
-    uint8_t *p = block->host + offset;
     int len = 0;
 
-    if (buffer_is_zero(p, TARGET_PAGE_SIZE)) {
+    if (migration_buffer_is_zero(block, offset, TARGET_PAGE_SIZE)) {
         len += save_page_header(pss, file, block, offset | RAM_SAVE_FLAG_ZERO);
         qemu_put_byte(file, 0);
         len += 1;
@@ -1190,6 +1209,7 @@ static int save_zero_page(PageSearchStatus *pss, QEMUFile *f, RAMBlock *block,
  *        > 0 - number of pages written
  *
  * Return true if the pages has been saved, otherwise false is returned.
+ * TODO: hwpoison pages fail RDMA migration, should be handled.
  */
 static bool control_save_page(PageSearchStatus *pss, RAMBlock *block,
                               ram_addr_t offset, int *pages)
diff --git a/migration/ram.h b/migration/ram.h
index 145c915ca7..805ea2a211 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -65,6 +65,8 @@ void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
 void ram_transferred_add(uint64_t bytes);
 void ram_release_page(const char *rbname, uint64_t offset);
 
+bool migration_buffer_is_zero(RAMBlock *block, ram_addr_t offset, size_t len);
+
 int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr);
 bool ramblock_recv_bitmap_test_byte_offset(RAMBlock *rb, uint64_t byte_offset);
 void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
-- 
2.39.3


