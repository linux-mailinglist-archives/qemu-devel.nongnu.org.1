Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E69947C5B89
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 20:45:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqeBt-0006Ym-AX; Wed, 11 Oct 2023 14:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qqeBm-0006YR-OP
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 14:44:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qqeBk-00039l-8p
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 14:44:10 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39BI2n1n006802; Wed, 11 Oct 2023 18:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Rs/Tm2XrBMQeuA+QscNvu3X6jRClfyeGqMud0XWUkr8=;
 b=K7PiXfL4vPFViw/ZN38ywuxV77xgV331fUqTA1n9nWLzI5kgotl9XiUjQ8LBgtMnWwcL
 oTvT4LjjBHrckFU1kaCJutlXIqzG++p2LpqHHqIghl92cPPlY7/+i/6rC+VRpwHsnUv0
 IqalRodiAXzwnSyph30LODvnQwse9WAlvnpRn3wCO8ha+/e5sKNipwUNG1EjGX6Ck0Rr
 36QqHuqok1+ZgUMArypKVqG514JBsgUqvUnLlnSlj5F60yr3h5ZFBAe0ZaWiLixf9XHQ
 kXEaCKiKCZxBMou0t1C10AERGKPdRqcz+6vunG6v4a7zpw4yBlYvr/1QYVH59YLjif6P Fw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjxxu91at-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Oct 2023 18:44:03 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39BIKdD5018124; Wed, 11 Oct 2023 18:44:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tjwsesxee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Oct 2023 18:44:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wc6yoEKyw6tkG6WvqE9WUyUMAMJL4Pj2k8ltRoYtUy/5U8AryFpKDDtZFbkxJd4egOgjuGNnjwFb7Lxk7eTNFtytAiv9j3fyQakm85YReawXt8+wTXuF8smhFEtpyP8WppaPcmfSa+0v0dPjfSb3lrXh2OJi/EAu9sNT+Bql9W2j0vIgftP21DbMs3WBZhKgGeg1DooQk+8wWcU3wDctl0obcQB92PRLzrCydS6qgDkJXO8bnp0eBKvdUY/sR9/6gKTuYvk5BszAhBn7kg6O8GMRS4kjPOkmbKwGvWgdq1Rm1y87eXvM5KRYneB4n3fj04tNSl8lKHqvUNFEkVWjOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rs/Tm2XrBMQeuA+QscNvu3X6jRClfyeGqMud0XWUkr8=;
 b=d/G15hpl9tKh4yVHNSWZFwYvSzYHR7Jccr6LJTWrT40yS/mMN1kb6HHOFVphg/oOXebfTpmjn7bEJzTv+lNX1P204nI3zDRNf5ttHMVRQLG8bNqoELpv6fCfYQDKrez0WtH8pVHI+VjEGgMFDqsHPKVKvxdyOKPp7LWuCr6axKc7kcsTP7vaC1gas6AcHm3KqP6ksfBXaxyk7VHo2y8ZNma1SaMVClx3MskxuvLT7VMu6lWTpgXBSAwAutpA0e/SSkk6nd6G/GiawXmsBPZ4ITzRQ1SQXM3Z49ulEprjpc+J/9MYIqKQXH9Jd6tM7+AGXOiQSxC8bBwTm5fJg2y1MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rs/Tm2XrBMQeuA+QscNvu3X6jRClfyeGqMud0XWUkr8=;
 b=c2vaLCL84MJ56RgSAOac/+weBbHgEQf+d9rNxhWCvCZbAFWWehze3BatjvsmO1zJbRCdDDGANi5GcHL/q4nCmJfFBc1yi4rTzecWvBTViQndyJL8zmcVHIp9KiYNLf/3j09zrWK1czUqS3QzcjuauLBpEf1Ixyl/V/9FzHYmSjw=
Received: from BYAPR10MB2869.namprd10.prod.outlook.com (2603:10b6:a03:85::17)
 by PH7PR10MB7056.namprd10.prod.outlook.com (2603:10b6:510:275::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Wed, 11 Oct
 2023 18:44:00 +0000
Received: from BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798]) by BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798%4]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 18:44:00 +0000
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: 
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de,
 leobras@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] multifd: various fixes
Date: Wed, 11 Oct 2023 11:43:54 -0700
Message-Id: <20231011184358.97349-1-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0019.prod.exchangelabs.com (2603:10b6:a02:80::32)
 To BYAPR10MB2869.namprd10.prod.outlook.com
 (2603:10b6:a03:85::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2869:EE_|PH7PR10MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: 2deed9b9-b350-4ba1-9b6a-08dbca8a08b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0Nhg9UiWvTJqBkkClkHeyJcjHwigID7LPDkRdqaKZt9pjoV8drz4yD5tpSWHdIAiSV+GL245rWBrH9nC838RV/NAvj65FKJWGOphbGIhsbHnHXtpAuaRTaGMdIMSeqptzoPqng9ncXAbgDrEF8R4v39XM4lmHYe97RYCBgrwht0vzgMDRoNrZK/rQQ4zYI9jZqbuFQe5hNxJPJB8sxLnRJkf8O/ahEwgZsupRZJxa53a48TyKXUgaHRUtFjUMhBTOWVtv/dtko+RTPaKIGwQ265Hay9DBHVzBhoM+r6dCiwyfXZ0DRjXYaQmdItqwAHAR3X5+5cYt3FEIRjh2Tu2gsa9LKd1N83RTkLjMCk/1iCoGJ3D/05oiQewaMcFkelJDulcqSSUQi0RKl0d077VZ6qYBQyaBwAlnsLXurPfqvpCHuOcrGx1CtbbWk1hWvC0aiabBGCSl1Tf2vg+IR7ohG2czyXbIeABOEdmx1+gNvKEDS5g9+4IgStHjYy3SvsHt/0iqlLWhl4C+rE3sEzH58sGSHPjUe+Fb/WZyvxfFawfZqsP1nY1DIFdKxucH2LArGqWTSs5YsIjUCmV3UMUElvjpi2UComVesImFNmsyU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2869.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(109986022)(451199024)(1800799009)(64100799003)(186009)(4326008)(6666004)(1076003)(8676002)(6512007)(38100700002)(36756003)(86362001)(8936002)(966005)(2616005)(6486002)(6506007)(83380400001)(66946007)(478600001)(2906002)(41300700001)(5660300002)(316002)(66476007)(66556008)(44832011)(266003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yc/JeeYlrpOaVSjFR+2jN5J52VhSN6yxiLRtWhrSSWNRQJZvLVyL4LdL76fl?=
 =?us-ascii?Q?DCPNzTFh1nYe92vzCfGArVpunWF9HmbfCyAW7UuEaRQzh3qzhqqL3E4d+/V2?=
 =?us-ascii?Q?LWzF1FRN9ED7+KGOpsBGtBNPn6K+qjr+KWl5QRgiW6LhUAY1zf9LblZ8fQhg?=
 =?us-ascii?Q?6ZE34E50hnig1r7SNNKThSPSx8zjB45/Gv3wbURciNAT22vTt+lM3xOG3ffH?=
 =?us-ascii?Q?lMmJccSit24WbYHoxQ5XxsvCfhDz6H/7qEAx5Msw+xnb2fk3+Mf9FI53vbQF?=
 =?us-ascii?Q?cujdRNXdQ/wdBasP47+0h9WG4HugOpG1eFqYMiDm1OfEpgR75Yo6I6KMKlub?=
 =?us-ascii?Q?O6JpGlA8UBxLjY5EE5L+an2WY8vG6OZBEKjhWL5hOw2NSQzBk+1t7L+cO3O3?=
 =?us-ascii?Q?8B5ltt0ywrRzJFcT6Ho9XiPT6jEu85cLJs0h3smqE39GAKqR+CwuH7N+Clgm?=
 =?us-ascii?Q?pkusmGRQ3y4ISq65MsLPkQdTDjy6fM20Rgfm7G8znBF2gkKbniizRkltdTvN?=
 =?us-ascii?Q?wOP84kFSmXJrFMWq0K0KkN3wj0JHntFI6QQNPWTb2mP/SxjVFVnp95ViQceD?=
 =?us-ascii?Q?xlhItIba0RJh3bWv5m9PI/Nl7IpfOcLWo15CPdNc0SOlM7FTYvhLPcsceP0G?=
 =?us-ascii?Q?Cxq4kLNJvUiBUOQLUodoGUS8WOATM4VMWK7SNk7h3iTd+RP3l0BXKW06rj9m?=
 =?us-ascii?Q?kmvOsaoU15WVSETvB3HSjsjCrIvfeeqsU3MyVYZvtVxMezD744bolEfqPFxX?=
 =?us-ascii?Q?qbR04Z3po9/nnB9TyNgRPuKReY82fy1T8lleHYEw7JoSHdXT16lRvdcr6SZ7?=
 =?us-ascii?Q?bNe6bFozH5Ruo5LtzDbE5O2JAY6o5nKd3wBlfY6hfwh3uDu07G/6QJibdr2P?=
 =?us-ascii?Q?TJCrSP2z/BAuUuZUBtceP/SlbQ1Ymck6CotH8cmBbAZH1tknrUuEBZalGzNK?=
 =?us-ascii?Q?FbbN1kve5D2HjfGr4UbqHtg90wQIwKWyOUK2VxEsPiK54z7+GgtYGrLwSdEM?=
 =?us-ascii?Q?wuU754Sukqb7w8DjakZzUkr1+3RJizP/fda1YXOCdEAPUbKMCjV+gngfhSOo?=
 =?us-ascii?Q?4zybuiCzKTrWygWcmmqXz+axfXAI7gDB2LjbSxMbpOn3Mjp9lNfrppQcn2fQ?=
 =?us-ascii?Q?p4qYGpfP6nlvqr69ytkgDezT7uXnvRYbEoC0+Hue3mSAlCUlx2NVPylnj0rJ?=
 =?us-ascii?Q?BYzuQklID/xDI1zSewppPgbp/Oataj2nb2ZsoqRJzA6z9n1RjxZo0nbhsmNe?=
 =?us-ascii?Q?b3krV7lS85sqRJj6fHKuIA/zWHwxsR061jRazJiUVb8Tj/7eqMci5U6MQnLJ?=
 =?us-ascii?Q?G/H3pkx+I5mNv937/K6oAUfdfdNBm4KeBcfwj127JEnKAR/eZdza6rVnn1pU?=
 =?us-ascii?Q?RWYctsv62FyxWkFjuYzBlzZKVqQNjMYmKPc/DDif5C/8Qs7W1oo9fjeM5mJK?=
 =?us-ascii?Q?7x7o4AiuGVZcH96rEOHuZxGXTYvrZrPnDqUlMG4LabMwlQqjlKpIYQe4Keot?=
 =?us-ascii?Q?KZdAoF/GtJEVqCBzNDyk1L21dt0cjMWnz3kKqxmhtLAU/6GQhJT5whp3cLdv?=
 =?us-ascii?Q?L3vEQbzNFQ6hjlsW/1JLYTqi28AlSPgUQwWtgfltX/ZArg14hUTEIbTz35yj?=
 =?us-ascii?Q?45obf0R0queOUeKLQPCwnJ+J0vKQqiRqrX4J/EPOlIOfh6Aaq0wfpbG7s/3m?=
 =?us-ascii?Q?t58K8A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e9u9b9Zee7uMsksdm5Kyzvn4K8goKf2nKzeEEmLeHTG2y/i2Qm5sgX6fPMsJJO4jkrgDoVTMvY1+TmI88VTP4GC74VJvY804ai5rXHA6GBmlFhcO4NCVN088cWY/mwNFX4aydskL/aeKicEJQ0fGb1R7CG7i6vvUQZJDKMkmtpQEPOwFxWRSMz6inPJ48KpSsoLmnxiYp8/HvhXrRjElpDbcATXZ2ebE8OcZCK8imduu01oaM5h1XHrS5fnNwABs6N2j5F+EI9lcmKebG4YF38WXcpWzcd2oXzHsGsfV0rHifMBKJkoGnFXCZDPjI1/WY17/qTZ1al0CKXivkQ+c6ACoE6mKD9Tpc7pyN40TV+J7ScO5JyJXYBSnRJloXvlBfszSbT+UfocMltbOo89Aytejl2T87Gmgw3PRsIoj9+kMSiZAw0olLhGBPeZ0twmUPtgAqgwOuAGy/obYyNEDr1gwyPhrw2ELbgqhQsZ/2j3Ifm7nGTSoZXAsR1zEjo3Wv0+4M3JwHkYGdFZWSe26prbUeOpV50H8xrcGcGz2OAcCgtuctrN47e5NCF41JBbFYcm2JK1bs1+31UyxOMvIouiPid8MZgQkrK0YpEIzOvURA0mI38NDAsGhjs4gyRI2y1EwMXLpBC11kC+oTEfWagbErBwXSnU8M0qRDzo1aKgzD5iZcB14WCaOXIbdv8NDQSg3PpI5H3Zqmuh8N7q4iCwydicwDd0XrDheAqYV4w1fEMSLuAjuD0Cl0Y+sC2B/V5jEPz4vp67bUXn/qMKxxGcEMKesPoj8PH3z/+dIATE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2deed9b9-b350-4ba1-9b6a-08dbca8a08b3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2869.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 18:44:00.5098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9qUyZJz2y0pTwdzglsJNLWT1jvbVe8WT3VK899KulFa/wt3/QepV2N3xaT89mJ+ydYOtWCK662VYAX3tKn0FRWKveaegBY2pp01UpFza/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_13,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110166
X-Proofpoint-GUID: Jtrqkfv-TppI2yEAAVmlTbQPY5hV3JwN
X-Proofpoint-ORIG-GUID: Jtrqkfv-TppI2yEAAVmlTbQPY5hV3JwN
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

Hello

While working and testing various live migration scenarios,
a few issues were found.

This is the version 2 of the changes with few non-functional
modifications minus the dropped patch.
I have dropped the patch [1/4] since the discussion with Fabiano
and his proposed changes:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg995782.html

In new patchset, the [PATCH 1/4] addresses Peter's and Fabiano's
comments and Reviewed-by are added.

I added [PATCH 2/4] to add more description about the packet_len
and next_packet_size.

Patches 3,4 are unchanged, added Reviewed-by and moved discussion
of the other issues under "---".


Thank you in advance and looking forward for your feedback.
 
Elena Ufimtseva (4):
  migration: check for rate_limit_max for RATE_LIMIT_DISABLED
  multifd: document packet_len, next_packet_size
  multifd: fix counters in multifd_send_thread
  multifd: reset next_packet_len after sending pages

 migration/migration-stats.c |  9 +++++----
 migration/multifd.c         |  9 +++++----
 migration/multifd.h         | 35 ++++++++++++++++++++++++++++++-----
 3 files changed, 40 insertions(+), 13 deletions(-)

-- 
2.34.1


