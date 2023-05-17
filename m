Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F655706E17
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:27:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJyY-0006Wl-HD; Wed, 17 May 2023 12:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.devolder@oracle.com>)
 id 1pzJyW-0006WY-7d
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:26:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.devolder@oracle.com>)
 id 1pzJyT-0004tf-Db
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:26:04 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34HE4Ipr022248; Wed, 17 May 2023 16:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=LLfEklBBBSIJwOUTvSXEq2muxZ+fWEbdt5TYd3IXQDQ=;
 b=ohLqxNGWTJTP1fBdjeDGqJaU6KI1PMQ4REAGmkBd/KLPRng9LXgfAL50HHpHhe5Itrh6
 kyUexQ98yhV02M256zmfEpUDZHICoHvbfZsaCGCHlCuXp1X2xTO0vxr1He2g6eYPQSCJ
 1br+9MnlipVur8Ongt0wc4J5pWCgb86PqqFvUWh1hvZXZ8Z5LUYHUMNCe26EvWVuc67S
 daAGirlQg1T4huFC5bs8Hd0LJTVMt4Q28tGkbMsUPbz4K/NsBXdLE2U7x7U3PivPKfdI
 00EYY4ipetSns/dJuhu86FT43lbD3KrmebtD4pfX8/sYY/mpN4CHiqGJLM8vaSK6dKLr /A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxwpgkdn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 May 2023 16:25:58 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34HFBnLo004297; Wed, 17 May 2023 16:25:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3qj10bx9e3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 May 2023 16:25:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqpzblnuxnY89E1I1dxzoeR9qZKdAdMyg0zEQiqNqDKDJ0V789/Tmhzfvz/HKp912qadOLxVmieIEmmahVmRV+78VJkskQj9pfMS7Qmi7XsuQalHe/I4Hz8cKfUHd/D1NR55aER8o5NgMLNG+TOL5wTZFDe/GzbgU8TePQ+YrpNvCEuOnY/B3b+SJ0fJ3DMKmpwtOwt7S/Ly0J0RvBLm8X7yI/35p1pMZx52qc325/6cWYX51RwhKUqiXPtvpCfLhB14K5CdHofwH8g3aFiW47KCnzOWuQ4StQWj8FeG30YtkzlKWQhYQ4Y1PV4Oc1pAUfdG4QVG6VA93WtNX1zCFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLfEklBBBSIJwOUTvSXEq2muxZ+fWEbdt5TYd3IXQDQ=;
 b=G/Fypn8EjSZaZeQXTnEXrEF5Dfp/Wj4qqBKqA5H4m973geT+DD6PLPTpgRKvVEyQkFXzCdd8MuRO9TRPdPfwuCDFcRlj5bbNG3ZtJrOCOoCYCbEJANpXU/i91q+WtQQHdvDF4L0jYagZ5/2OgQ3biCzViB/8eZ7x6vUttsR3P1XrrbYLvQ5xhl4HVrFwlFdbeIzymzslGTCYwicOOGsfOHW4r/2F6wZdw3IAUV1F9W2WX64AXouC2R6MraioIAstsQwBCv6DNbSAgCzN11FsKuheIodXjmA6+bp+rbBt2/w9G647zClTOLUN/RlGMpEHlIdsJ7+5SUlz2HmVPwWmYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLfEklBBBSIJwOUTvSXEq2muxZ+fWEbdt5TYd3IXQDQ=;
 b=YwMxJBjdQaTFqVjQD4Ak/b0Nwy+iRNvPkK27omIihLiMoD72PoxQ4iot27DPPjWyHlCc7zsn+LbYPO9gyHTYlfPznboZebWwHin1SKWdVKlonhH1RiA1/M18hxF2kHT91HwM+J2uS699MMOe6bZRphhPNH/z7bnLThaKL9ROKRA=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BY5PR10MB4178.namprd10.prod.outlook.com (2603:10b6:a03:210::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 16:25:56 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 16:25:56 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
Cc: boris.ostrovsky@oracle.com, miguel.luis@oracle.com,
 eric.devolder@oracle.com
Subject: [PATCH v2 1/3] ACPI: bios-tables-test.c step 2 (allowed-diff entries)
Date: Wed, 17 May 2023 12:25:43 -0400
Message-Id: <20230517162545.2191-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230517162545.2191-1-eric.devolder@oracle.com>
References: <20230517162545.2191-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0060.namprd02.prod.outlook.com
 (2603:10b6:a03:54::37) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BY5PR10MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: 096bd075-4fd0-471a-9188-08db56f36418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L5Oxq+MMx+btHWBOvvVI6isQhztWANCSXpSXzBUIeQ5zP+qxH61mLlwkfeeT4RkjizOFYIiDF3mD9d7eoQCGHe5Vi2TxU10pdGt4JIHLYs/c7rlsr04vmqyfj6MujUqUHn6bk1WtgxQLCLgekfd8BLWHIBP7fY9lMSB+OKOlCphQ/ediDf7PaOuGJ1EOY7jTYS1OBMQdsOsowaqjIijbwashdjNpGBhvYGrgHSNPpql0W/x1U8U6p9rAsqHGaO12mATpdcNVMi+yC8R4/XL2zagnq9PhGEbPJxC0BNWkax6d54er2IBYENG03y9/5AdrwVXFA4pKzShHgnnsjMr3CPm2dn7rHs1yvJ17F+FPQY89l+FH4Soecxg2WM6CcPF/6AE7I99aF6RzkCVDs7xDCPj5hDTUuxnaxkDy8wAaXG1CFpBbse2zCCtB6GZp6sLgDd7XZJ4GuBs2NN9ZXNSirB/0kX/P3QJVXda2liZQVuoTMdZSXMfFxsvKk6NxMEFkA+1wYLiS6voMQbxxU7HYa+2vD94piQ44y4imW6fNLGENYW6gQFcXTai6blv36iBieLuKkGHoBPZE+bnPJ3eIRB8wLs7wnpbTzX+lSnDxiYY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB4531.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199021)(5660300002)(41300700001)(2906002)(36756003)(2616005)(86362001)(38100700002)(1076003)(26005)(186003)(6512007)(6506007)(8676002)(8936002)(107886003)(66556008)(66476007)(66946007)(478600001)(6666004)(6486002)(316002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GHjgs06mYq1TMLvtNCwE9Pya0i4HxEqRBzjmLUUOehDhgQE27IpkHVzZthSX?=
 =?us-ascii?Q?iQ9IWZ2FTyN9gQkzb2wOtGn1B9GSDeYRXgTu5/KJB64tJvPYtAEel+j1dg9O?=
 =?us-ascii?Q?PrAnLICmXo3tqVao3hFDK/HYYAqWS7ZgEA/uKsHV76wGI9w+C/Nna2yafzBs?=
 =?us-ascii?Q?htfWP2jpDasuVJ1gmpCn/0SCKkJyV6feRLe7tKjgncI3pgKbbsH7YcYZuPGn?=
 =?us-ascii?Q?peUebMWrVMM9SeiWnOOZ/eNPZmGwNANMpf2RVQkSh7H0rKf3dJon6f3M/13B?=
 =?us-ascii?Q?SPCQa2RkoRvQ8RjRHKPEBH8UwDFhItNd/gBOyWbNXnh5gwG8d1dVAdFM4eH/?=
 =?us-ascii?Q?rwamUzSBsOWn5oZgo/emki31NP979mmIQE+QRtTk281hHYuJPrDVyzdWFOlo?=
 =?us-ascii?Q?GkPIYJoUg9MnfUNJfEjdmVOCEBYJn69jbvriEvNUtvbfloiglxg15HxVPBfx?=
 =?us-ascii?Q?3JLwfgYAyoOulVZRH+YJxdQvN2sBs1Q8bLqW7eiVRyLkAqaX9XPWENqjYXRp?=
 =?us-ascii?Q?L868KJhjXyEed24rgFrbZv/n1wVolgzXlnUODd/dcbftXbY390xUIxu+vPdU?=
 =?us-ascii?Q?F+HjA9vSskfyFRyrpbP7MCW4KwXfBZYxkFLkV0CItN8hm8rglSv496k1FBPZ?=
 =?us-ascii?Q?VdACED82EV8oR0ewjmH7vkLj8srX77x4pxMA0wY45AQrYosyPTCe5So/I77M?=
 =?us-ascii?Q?pm/ypKwXhfYAZqsELpscq/MqFQfQCbirUfflt2TA9fQrH5OLuNiOb01gGpEz?=
 =?us-ascii?Q?s8zqHfKE+21qhRHGzkANBT3oY3VrFgjPzvftr86MhC3EX6by2uSZTfx07XW6?=
 =?us-ascii?Q?+mu8mmTbfmORj7JMA5FFhCskTCoOp+UU5H3HExxUQxyrF181EAv05CoQI6FJ?=
 =?us-ascii?Q?POhR2mh4xjNzLycBA2bxD6b39Ff9hWgObSE6uMS8my2lwlkKLSlsX1hHThBq?=
 =?us-ascii?Q?/DORVwweHDHBfyZK7ykYiZyd6n7C0rCubk45ma6pj+5KJwEuwVXmdH/I2Gje?=
 =?us-ascii?Q?OBumDJgqwfjvI0/21c8a2ExyZaPbLSCXtzvFQg7l+IC8Xfq4DG3/XCnXad9r?=
 =?us-ascii?Q?rMW1IfNZOaq0JShyhAsAYJZhXuVJBKJqBGTThvkjNErjrY6s4nKWWdrxzrCU?=
 =?us-ascii?Q?hmtFmMHVvtkh3eG//ewOixik0Q0m/LigydcuoueDRiYMQZE/IrBr06XeJRky?=
 =?us-ascii?Q?M43UgFheT8uzuGRMUG93jldUmiwR8g1mlopq9jgr6XvmYbqINH82G/CCyc6y?=
 =?us-ascii?Q?ut2BHlO8h3XsDLm64jMQbNx1sMF70y2/oc0bwvr/2SnxKheUvfo2PgbU0TxQ?=
 =?us-ascii?Q?tEmiZo4vcUVs0OYrTyj20xWsHLf2K67BTV5RvVhKSU26bRli9ye3Vujj0qPR?=
 =?us-ascii?Q?mbZqdXqIuh4i36IUeNJ2PblFSWC+kJJDpz0gSbV02HjoxkD4dMaw0Ma8sEW6?=
 =?us-ascii?Q?pR+po6yCSdSG5/my87m75wgTGRTNSi7FZW1BcbO2Drh5C/CceA6Lti6YjNrU?=
 =?us-ascii?Q?ZZFh1Z0YIbEJh3r3zeYOEt012YbhdvPxBa7AJmd+CTBjQVztLRxeygatS5iV?=
 =?us-ascii?Q?mD5w+ShXG+duh9hXYSd6liiiyxCn6pzJlkAFd2bynDKExN5rSHaNGUjPDvAN?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: A6GBz7NVENQnlsoTTp5DwOu2DocqgGEMKDCF5wN1xurdIAbeW5xKCNzNNG8J10Dzdc4WTRfTlPP/DbfgPLHSdxJ0DlFuWPQN0sZ/wLEZLpnXtKcYqKOAbCdQMtesMVoDqlD74aUr+zbCV8GG/tyIt7hJakXzrVA6sBdyMColOtjWT4XRDEdbONqOurPJMgddwcAgKdwH92ARa11pmBLPikyNKudyg7ky1AtJJ0xlEW2YE/igKQlwblFznYDqTX+y8dm7TJNl1XHqeTB0lupvKbdqjN4RScUt9JElsDdSLtqIRH8quhdKBqjy7dGHLxqzbl726SR2kALlviWMsYl7VdRbejEmAffjdd6UQ50IvRhhP8fWQmCsOtLgn6iPmN8Mr6D6KuSkotncvl6UWckdmH6Vfpcqmae2X2zb5zTklpp3F5kMdBOjZaw+YELu6DvMzywiHSBrKC6cxX7Vg+mmd/+wLQh8WurjogzkGU2wuPbvv6gxtK5077qruip6ySJkNU/SlCvOIY5hY2KBREK2kBBAMGkfBeZQ7DSDQIlNvIC3LgTe8t7u2I/6v4/nYSXBd85oAk+uZHGPtI72y9bS+F44BJ84s6EZidM40WaQ+pyk9F23plbsGXRzE6+9F7fq2MkMabFLPMYJ4ex7PWWoQxBVvK+/gB2RZNqRtJq+lxV8hJ7aTZjgmfPNnysrmagbgNWQhrul4glb4Fc0+zQBcxPGR9NH3YQFkFojvF8Uk75boR3Rq7x+3EdPA4FyMSftt9Xv7yWRwlWzyVVezAGUYQ+uEtjU+plMTcv3EA5AUlplivDsNnfVDEGA2PFEpkEw9ILOUpjjLeZjPFATSZUTVRLqkiRzLvM4jlj1UTzoX0k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 096bd075-4fd0-471a-9188-08db56f36418
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:25:56.1470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nX4J9fZm2cVCLqaEd+pfjidNsaEYbudIVGK6Jw+w2VEcXeGNx+wOavzG6LgnmLFOFKuA7CHMtcorQo4lfn1LtOA7X/rpnCWsNie7Fzfe6Ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170133
X-Proofpoint-GUID: MXjRUVxt1yaw4GjX2fcrSxOOOLTyNjXm
X-Proofpoint-ORIG-GUID: MXjRUVxt1yaw4GjX2fcrSxOOOLTyNjXm
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=eric.devolder@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Following the guidelines in tests/qtest/bios-tables-test.c,
set up bios-tables-test-allowed-diff.h to ignore the
imminent changes to the APIC tables, per step 2.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..66ae44e6b9 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,15 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/microvm/APIC",
+"tests/data/acpi/microvm/APIC.ioapic2",
+"tests/data/acpi/microvm/APIC.pcie",
+"tests/data/acpi/pc/APIC",
+"tests/data/acpi/pc/APIC.acpihmat",
+"tests/data/acpi/pc/APIC.cphp",
+"tests/data/acpi/pc/APIC.dimmpxm",
+"tests/data/acpi/q35/APIC",
+"tests/data/acpi/q35/APIC.acpihmat",
+"tests/data/acpi/q35/APIC.acpihmat-noinitiator",
+"tests/data/acpi/q35/APIC.core-count2",
+"tests/data/acpi/q35/APIC.cphp",
+"tests/data/acpi/q35/APIC.dimmpxm",
+"tests/data/acpi/q35/APIC.xapic",
-- 
2.31.1


