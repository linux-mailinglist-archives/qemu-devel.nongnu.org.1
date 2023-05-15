Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B093C703EAC
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 22:34:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyetB-0008TS-SF; Mon, 15 May 2023 16:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.devolder@oracle.com>)
 id 1pyet8-0008Sj-QI; Mon, 15 May 2023 16:33:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.devolder@oracle.com>)
 id 1pyet6-0005LC-H9; Mon, 15 May 2023 16:33:46 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34FJsJnq015372; Mon, 15 May 2023 20:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=ovkSLOkAhBcjTlEEuPqcqE7zcjWXwTvmP9LhX3As824=;
 b=4GYEITjNuOMFwfhYlzaGv1XXcMH6QQ36YeD2m8OIGhhURKRfolxl1YUHT/uWoU+IgYhc
 eI9No6R3jSRq5tAtFg8YC/CiNTnylBYiDl3hhZ+/MEr/KWbwqlY2J9MQWtbWzF6citZC
 9DGvmC7Gg1uVvl0a2+zGqXE0LS9y9Pa4tf//2AohVhZpSGzdaiinetCyr9q3t4X0icQM
 4ikglx1vCY+MWPglAaNZ0k9QSqg7s1V7txXfAXrq8sGm7/RK3YuwRRTqrXPV4ONDpMnk
 xRubmbKoeua4U0fKCPKA5xJkunMUsFoPgEXyxNMj0YEBOfc2DFa7PQ7QvmoVj8LIKhdn Ug== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj33urwf2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 May 2023 20:33:36 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34FKJtOu023163; Mon, 15 May 2023 20:33:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qj102x7t4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 May 2023 20:33:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3i1nArbj6iCUykBaSv5R+SUIipokgqQzhLEL95m67gM1pWVEMN2RDq3rUdc4HmKII8ItuiyawOsdfemca+tTcBCGMc0AjDPqiQmnwxn8e2rzKjitv9YqwK0xx6XtNNGz0G5hNLq9wiqM/ovT/rzItMCacR39QfsWIppniZs2XzblH3/AcW9nBVjwrPl685qG0F8SA0XFb50Eu5GZsMIe1loK1x6EdWeQaA8ZcVbtANQHuOLEHb+sq+QOzO0RES8+sQhpZ50HdQpXaG17s2riACQBySxIP/0dJgu0RXlnkAvr4Rr4/aPYM2WDvwwDIIWTifqNx8xpP92p1Sz8tZQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovkSLOkAhBcjTlEEuPqcqE7zcjWXwTvmP9LhX3As824=;
 b=P79PiZjnKCJ0UbDRcjBjK04VNrA9EOR71DdXkAoCg+/jDwqdINu7j3fB6dG0N6OP2kG1wW1grq5EvegCZRl3NY0XCm4viSmsLgNOcBLTK1okdR/43j4XN7w3om5QHwx2LdSYtyaIXddqUFBv8NH+RX8AQkShOXIE4wXn53A4iNc4j+EQ56duRvQEwx1rmXtth40dYmwMSRVix0TAGVvms3nVVfdmuBbAGi2IY33BqPc6omlfWcNfJDEMmiUprZ48EiTaXmlG5fuHYc4Nbqn4OQ26nYSDKZNryDnxoUDKic0Z9df7kuldO3DzcH6kYhetzOa+ebtu+uWS2NKdKL6zEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovkSLOkAhBcjTlEEuPqcqE7zcjWXwTvmP9LhX3As824=;
 b=CoyTmtxr6/ooEdb+zFj0K8qaO3HIgfYs4Xa6BU93PPrv8Nf54dfrNiQzi7WVMza/SCscoTEyMdjR2l199PpRhSSaAGTM5EJQ8iZNHxcdYCsFHkgf2LlONqR45ivPDbSzQEQNgqkw0RLSCjmjFV4ofdp5vxCaUcF3jpf00h+Z8sc=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH0PR10MB7412.namprd10.prod.outlook.com (2603:10b6:610:184::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 20:33:20 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 20:33:20 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, mst@redhat.com,
 imammedo@redhat.com, ani@anisinha.ca, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
Cc: boris.ostrovsky@oracle.com, miguel.luis@oracle.com,
 eric.devolder@oracle.com
Subject: [PATCH 0/3] ACPI: i386: bump MADT to revision 3
Date: Mon, 15 May 2023 16:33:08 -0400
Message-Id: <20230515203311.2139-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::30) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CH0PR10MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f75ef9-00eb-4beb-a264-08db55839ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PJbdycWoGj0e5WiZxD2KEsmmOtd/8GrHHEbYhomp75gPpb3wdPrexTLQPWNfK6pkZw/SLJHzc6ahj9KyFZMhnw+ks3rOP5asVzbmVxC+pohtjRzPml36AEwzXnYvgcjSDUPZS0HuG0s3aNfqtHehfUL1tSLgm9BfyuKf9B0zLMa7a4e/BKsixG3mNthIykU4pe0FyLD/574TqYLhqwMb8yWJawSCxMSfTjk7Pt0OJ72LLS5hbwLoYlJ6s9jw9NIjXw+n2MsmgELiDpKhNOW/fH/oFY4DQUN7evzSSdxQfqVvPWNIblgMeGCc4ApQjKpNAJ1y1rHNqzlXJj4bAHj2uKQhJCHB5Cw+HVd7Xi6nNMdND6k8+haVQJMbChVUMz5+oxD2hM6Mvu0/4Mq5SOyYBQAMbJ6At9lhs0tz5uxMrtb3U0c10ftaQHBWTAmPToQc/xEYyh5Z9I2Vgqvv4Z8xmrfK+xxwsMiB2z0qIzGMc9DjwPeLlC8GiZmP8nUfGlh/qBUVRwVmjqU3rgd/31yerhREE6C0XuebVhGS2WJg/FfrogKtRdbLlZxEIwN1tyGcX0ht88ujejr2CgUcYU41rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB4531.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199021)(86362001)(478600001)(36756003)(966005)(107886003)(186003)(6512007)(1076003)(26005)(6486002)(6506007)(6666004)(316002)(921005)(38100700002)(41300700001)(66476007)(66946007)(66556008)(4326008)(7416002)(5660300002)(8936002)(8676002)(83380400001)(2906002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jNo41a/jo9tglNSlU2lvxMp6YOXXp7iHS/N5SfGaIfz7xIcVAQgW7XOyZI6Q?=
 =?us-ascii?Q?cJ2pzDQ717elI0YRIHHnv/BKuQCYc8AeKKmYdLqnh5gTU2KFHBiDvZb5+eFm?=
 =?us-ascii?Q?ynQTpMur88Eswd2LEAtqsdN41c4rjGkIMsz+iy+Bi+XFskO02FZUrvcILtgl?=
 =?us-ascii?Q?o96z0BI8vn1ZgDJp3wfxwgZoX7dtgCzJ09dELmL6ovzGzedgHyPeRvkQ5Xnc?=
 =?us-ascii?Q?YebzxlloYQhYwHZXX62MnQzYvJa3z4MHPw+MKYq3+f8oGPah6KwSPCZykh70?=
 =?us-ascii?Q?B8znfRsE3+o3vc/X3ajbNBUsAqcznpgowgJDQc9iMpfb4Du80REGu9PRmNAS?=
 =?us-ascii?Q?p2fPKCvsfBEMOnsntEpY5KJe6tAYxnoWgEX/vA8kwpbSvmBrDs0wn9BMqp82?=
 =?us-ascii?Q?wSjmVOTcbpGTqI5USvFhLgLQGrGsXfmx3AyQa6pG5rvl49Du50I+5X98cWVO?=
 =?us-ascii?Q?7WWCVGlgji5AddaGsL6GpiuOTOmaj8nBA8sg4pikMa2EAVOiHFQqiPvS1qNc?=
 =?us-ascii?Q?Ubd44MojaTNnz6UnOZBETnlEDxO0VPoE1cURaPc5K1zgxvFePX4iemfSwflW?=
 =?us-ascii?Q?9hPSatP4TzUKy4RKXQ+3yUNWoKfIbXTtHf+D7DPPRClu4ZpW6F/pxHlb4DSC?=
 =?us-ascii?Q?YI3AcyujpSLWkpSPfN1Sp5UvU6tmf5ImWRGVHfGMr07cQbRugvW2O+e7KgYF?=
 =?us-ascii?Q?uCznyVoIfVsbFIZO67Y9de8MnpJVTYWpsPbW9uaHFsROuoKx3TmXDi7U/Pej?=
 =?us-ascii?Q?TR1kzKIUr+a6RGnSX+Qs4k6bEISFYU+9NZaPYRzZUJv6pYZ/QJaeatTmFuzv?=
 =?us-ascii?Q?17bw7kMwjkrWdKlPFwLgN7LI2Zs8ayEiA6Gl11qg9qRQO3zU1Rih1+zkrmel?=
 =?us-ascii?Q?531O6I75QQ2aLJuzYH8oH6eCEBBFqR9+dmr8CafrBrxsKOkCfcSodghxN9K/?=
 =?us-ascii?Q?xMpXjErTuzXsQ/15jT4chEBmw38cbFipm8S+JPoa6bmW0amzjQfxsAKSwDCl?=
 =?us-ascii?Q?of4IR0fsB6XJHrwXVnl5ryLbgacI0qWfcDKqhaXDtbYtC6reJEqxEUoJ1Z5v?=
 =?us-ascii?Q?GLQpzLPtRuaIeNJtqaT8lpPVH5pVw0UBeR6JA7IYH7/0ltFZEXpEXiiuTZjO?=
 =?us-ascii?Q?ZtXCD4WDHpdrP/6PmbN/qr0Jz8B2NPMujs4HMqlf2Xotn5PB3jiZxMKXfNlj?=
 =?us-ascii?Q?Tnv9f2BpWo8rUQpln1MdVQKtpwcBrwxofLSRyKpDBXWS75p6JfDCptFsOMTY?=
 =?us-ascii?Q?xB0nvZklqYqHHonzjhhQncuQPhy3ASj0Rk2zwFbed5lJ68UVztHPr3+f4LnV?=
 =?us-ascii?Q?VksAiqOuH/77k3aNatGCPZdy+y+vsSu4eVpmOb6doo6RSYmBEIcXphT+iExX?=
 =?us-ascii?Q?E4awnnnQsMgh61kT5EQO/8d1LeN/Dnc2fA/LjbLpMrOfV/LVPtfjpglXsiYu?=
 =?us-ascii?Q?fBJKY24WhFQ1NK6u/JBILw9axGOmSe+CSEV2wCIdQSriCxR27oDkiAO2CZAE?=
 =?us-ascii?Q?jd2HTB7l+5jCdJVplHO7MfuN44xTQQMZIPqZ12LRFG9/G5Lr2vhXHL16Nrir?=
 =?us-ascii?Q?R+64uuXO9iXnlYKICWezJ8TaxaKMMSOs27NtD+p8/ZfWsdopIWuvAcz6dDJs?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2JJydj+JmSpMZaXLSX+1LoCQ/eOY+SAHWsatxyHn5ZaDCaw5L4Xo9yzDRXat8YutXkzLoLSmGcagMkVmvM1sBBC2dotEeuZH2XYIN6cSl/6v5ygmExYyMyG4/OxGfDlyQ8T73Jy5tihgnQ+bU/nzhahdL3pf8jedJVYObI9ncOeh7U6HO8/jqYteBRsVCIQLA2/Z+tAg8LJvz9oZA9TKlArxzuqn2SpMs7JINBZeVsdnD4wDeHySSNEvXjwmrDpC2ZBlazFZfmfqqy8a5KrAsvRbbKoby3ftaeceS6IXTmE9iZXyRiKR7/jxzDRFckexZXL9xlfvq6CFEtgmIVIyOBE+5sNotqoYxVCHyGvOwmRoBZDizG7XHX0UqmNEAq1RuDWiaaSwzmtnGWkPwTDLKmabXPsnsLharLFcqbEY+ac/WPWx1PhebMqoc91cCHfv3cbpHOEPDVpUJJ8QkNOvfyNJMXmVq04rDGudL8XJZa3D6kn3K1r1rEYluSiDyjB4dZT1u0Py9vhDSKU/OeymKSaqYmXgQCWR7QKuA6G0JxvRHYbK28gMbYwPMh/lQoz+Czd46QjfDeowCNQ+Oltrerq6+QjqS45ZxvnJlW/x5vZ6awt5HYc3JixjLrvpiMqQuPja90xJS13vByDfyrBC27Z9bdqDniIMnd99HxwDb1MCYQ2PwKGzTIrhOIpi8BKOKKgFZb15ceypoJXDOEzMQLfQl1DCKse6YCeGjWXKbah0//ok34iiQ65uuReeSHAVoOJXAcNB9/84LzjbOyNzUyZlIJC9IRARoATI9kYq5T8u00rt23/vYML5hRVdI6+r4qE0ZpGSYyOGTmKVHdsE1KjoocsClVcYK3l+K+0yMuzF5C1kUCxD4HZtKiy1tFsdU8qyEkI4KHRzAb0GNEV6rQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f75ef9-00eb-4beb-a264-08db55839ed6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 20:33:19.9595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQ29JBW1Zldgbo6dltGisZdkncTdx6APbfsEPS4e2FRYm9bBi8Otuo8aRcTgD0j6QghcJWiiKa/yXkoteUbc2oHWRLOpA/sPaOJygEWjn5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_18,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=980
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305150170
X-Proofpoint-GUID: 91TdlTBbqqpuypUDWEaG89ck9GM2EBc_
X-Proofpoint-ORIG-GUID: 91TdlTBbqqpuypUDWEaG89ck9GM2EBc_
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=eric.devolder@oracle.com; helo=mx0a-00069f02.pphosted.com
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

The following Linux kernel change broke CPU hotplug for MADT revision
less than 5.

 e2869bd7af60 ("x86/acpi/boot: Do not register processors that cannot be onlined for x2APIC")

Discussion on this topic can be located here:

 https://lore.kernel.org/linux-acpi/20230327191026.3454-1-eric.devolder@oracle.com/T/#t

which resulted in the following fixes in Linux 6.3-rc5:

 a74fabfbd1b7: ("x86/ACPI/boot: Use FADT version to check support for online capable")
 fed8d8773b8e: ("x86/acpi/boot: Correct acpi_is_processor_usable() check")

However, as part of the investigation into resolving this breakage, I
learned that i386 QEMU reports revision 1, while technically it
generates revision 3.

Below is a table summarizing the changes to the MADT. This information
gleamed from the ACPI specs on uefi.org.

ACPI    MADT    What
Version Version
1.0             MADT not present
2.0     1       Section 5.2.10.4
3.0     2       Section 5.2.11.4
                 5.2.11.13 Local SAPIC Structure added two new fields:
                  ACPI Processor UID Value
                  ACPI Processor UID String
                 5.2.10.14 Platform Interrupt Sources Structure:
                  Reserved changed to Platform Interrupt Sources Flags
3.0b    2       Section 5.2.11.4
                 Added a section describing guidelines for the ordering of
                 processors in the MADT to support proper boot processor
                 and multi-threaded logical processor operation.
4.0     3       Section 5.2.12
                 Adds Processor Local x2APIC structure type 9
                 Adds Local x2APIC NMI structure type 0xA
5.0     3       Section 5.2.12
6.0     3       Section 5.2.12
6.0a    4       Section 5.2.12
                 Adds ARM GIC structure types 0xB-0xF
6.2a    45      Section 5.2.12   <--- version 45, is indeed accurate!
6.2b    5       Section 5.2.12
                 GIC ITS last Reserved offset changed to 16 from 20 (typo)
6.3     5       Section 5.2.12
                 Adds Local APIC Flags Online Capable!
                 Adds GICC SPE Overflow Interrupt field
6.4     5       Section 5.2.12
                 Adds Multiprocessor Wakeup Structure type 0x10
                 (change notes says structure previously misplaced?)
6.5     5       Section 5.2.12

For the MADT revision change 1 -> 2, the spec has a change to the
SAPIC structure. In general, QEMU does not generate/support SAPIC.
So the QEMU i386 MADT revision can safely be moved to 2.

For the MADT revision change 2 -> 3, the spec adds Local x2APIC
structures. QEMU has long supported x2apic ACPI structures.
So the QEMU i386 MADT revision can safely be moved to 3.

So, set the MADT revision to 3.

Regards,
Eric
---
Eric DeVolder (3):
  ACPI: bios-tables-test.c step 2 (allowed-diff entries)
  ACPI: i386: bump to MADT to revision 3
  ACPI: bios-tables-test.c step 5 (update expected table binaries)

 hw/i386/acpi-common.c                         |   2 +-
 tests/data/acpi/microvm/APIC                  | Bin 70 -> 70 bytes
 tests/data/acpi/microvm/APIC.ioapic2          | Bin 82 -> 82 bytes
 tests/data/acpi/microvm/APIC.pcie             | Bin 110 -> 110 bytes
 tests/data/acpi/pc/APIC                       | Bin 120 -> 120 bytes
 tests/data/acpi/pc/APIC.acpihmat              | Bin 128 -> 128 bytes
 tests/data/acpi/pc/APIC.cphp                  | Bin 160 -> 160 bytes
 tests/data/acpi/pc/APIC.dimmpxm               | Bin 144 -> 144 bytes
 tests/data/acpi/q35/APIC                      | Bin 120 -> 120 bytes
 tests/data/acpi/q35/APIC.acpihmat             | Bin 128 -> 128 bytes
 tests/data/acpi/q35/APIC.acpihmat-noinitiator | Bin 144 -> 144 bytes
 tests/data/acpi/q35/APIC.core-count2          | Bin 2478 -> 2478 bytes
 tests/data/acpi/q35/APIC.cphp                 | Bin 160 -> 160 bytes
 tests/data/acpi/q35/APIC.dimmpxm              | Bin 144 -> 144 bytes
 tests/data/acpi/q35/APIC.xapic                | Bin 2686 -> 2686 bytes
 15 files changed, 1 insertion(+), 1 deletion(-)

-- 
2.31.1


