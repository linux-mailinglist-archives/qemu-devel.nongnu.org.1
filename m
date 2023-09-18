Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 085D67A5635
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 01:33:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiNja-0003Ax-QI; Mon, 18 Sep 2023 19:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qiNjY-0003AH-GT
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 19:32:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qiNjV-0001Cz-4f
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 19:32:52 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38IK3poE012950; Mon, 18 Sep 2023 23:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ScZZRPJTPMvWOVwt5webCy/Tq5aeLTW2Ne1qT1zGFsQ=;
 b=fJr3PZxi/zauy2S2DV3PkC0eZ97dRz7fRUNXgrTVNauCBOQxI8VNp8jvGQBpO78QaxND
 GSSzHf5omdBB+uY1D3qc1xMM+ZDtrl6OEQ1QZuurjwlq0HBamASmWGVW6iLSHqJ7T410
 gkmKsofayEabqQxOfZM7UYYuoVxqHXcXl/qxIsWPBYodhAWoS9L0EMdUnkoPSyeYYyuJ
 Xr5L2meHUXjX6uoF0r5L+ZGCt3l4UdnLUlzjThYXJ2n0QsSKpluZpvHmeCYKnf161q0F
 cZ1mTilFuQZwEdpq/DV/nxiWElce+UMv/WXAI7Q7d8QitceuAvf0y1MQjLHK40JpVqUM nA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t52sduq96-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Sep 2023 23:32:47 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38IL45MB030083; Mon, 18 Sep 2023 23:32:46 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t52t4wnv2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Sep 2023 23:32:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwJmumOAg5HIIkYNHkDxqiBUxlRY7pUVXUpxrRAyCkGuL4srSsmOmAvkf4UwEck/ZLp4Qt6b3bJ7kjDypxJqb3uhE8XusXsPL1/Pup5LtGjTZVkn7u1D4SmYh0NNLpNYAMsTMy9Fu//AvjVgMbgqksz0v+CGyaJhnASPRGFRNVSEg2ujswC2LhstMcO/n2RrJYrGFIIb7j0NeMilCQqu3qlrWLPJIuMH6tZ4rP+hh0KRJsA83swZbvA0lvSLgR0AIL9R2lo3Z39fiXKLVsJ0hwiE4cCnhVRmCDj5TzWpDlTfBHmAzlngtg6RwO6L51fddv0qsoCMOCkLkUQxzmU6sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScZZRPJTPMvWOVwt5webCy/Tq5aeLTW2Ne1qT1zGFsQ=;
 b=OlntdOM7WK4UFV8gYX7/4sf40Z34O36qxunoNcz7uR7SsfAnaf31EgIkvhg17zzfl4kH7EExPkTRgbYx0C0lDtkEQRaI6d9S6RuiJgeJihoezb9x0oAztRivWh7Judnhklaf/8WJ1+2AqTTouKgpIlS1w0XFpWe2FAold60Iz3eCduYIwODAx1CBMejRmT7BDQ1ERu0nijWpFoFFwm5aDGnzUKO4zK8jM3mps8Ueei1PI2tVmsmelGarQY4pTWxcWE6CtcOKTxelhXdhGNdGpGzcEUIZcfDSqm71x1Qe8cgeIEj8Ge3KgEZAHQm+e2I0nJ4DoEe2BBZlaDUL5VLT6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScZZRPJTPMvWOVwt5webCy/Tq5aeLTW2Ne1qT1zGFsQ=;
 b=AUii9NhX/0Jo+VgtNDO+OTo5JVgYxC6xy6xfk8mY4JCiL75guehZPi7o5MireCGBXHe6l9rhSJyoHWnUuflGWGMaQVbM4GFhQlxM4tt3IsuzUWZC/+WqNaYIx8uOBkE8YkvICM2mFCfCqPE5G3E1Y+/v3desM++H8VP92Nf2c5c=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SJ2PR10MB7758.namprd10.prod.outlook.com (2603:10b6:a03:56f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 23:32:42 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74%7]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 23:32:40 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: qemu-devel@nongnu.org
Cc: linux-debuggers@vger.kernel.org, stephen.s.brennan@oracle.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Omar Sandoval <osandov@osandov.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 qemu 3/3] dump: Add command interface for kdump-raw formats
Date: Mon, 18 Sep 2023 16:32:33 -0700
Message-Id: <20230918233233.1431858-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230918233233.1431858-1-stephen.s.brennan@oracle.com>
References: <20230918233233.1431858-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0152.namprd05.prod.outlook.com
 (2603:10b6:a03:339::7) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SJ2PR10MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: 36325b31-dcfa-4d87-1a17-08dbb89f8c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T48UZxTns+h1ajYMQxhvtyNgWwoIpn46Me0JBXozQySVQq9V7ESECFksrap2coFFEvjnoZOBuvnUI1x+B+6F3AWhVlJwJkoLgtipz+BHz/PRgH65UJilmBBrvpIL/KewCBNp4EZmVTdxaGkt5PPNLunDzZWWdNS3U1aJp7A24TclyuzmxzZgcu2nCa3BeMbq5r3hBA6xGPFKZS2rczxW1zv1Apfm7sID/l0wR37Ym0uzVfCdHOv/71Wm62+zXTfNfwQipZrNUneSRW28excpqB1Y2uiL4F5hwrSLBULQh/JeqL9BGcZi2tYP2DUtTej2EozPuQlReEC0JJevLsvymBi59QhX3d2DFWRtPPNf0s6fppcxDV1Jx+8t30yWa3jiy5TsKGIQlUTTQ0Z1l0Qfe+JX0QGjjkwPJaTklKVqyVE7Q+xg+oc5FoahEUr7tzKpuBzVbDGt4x23VFXCaEXP1jiqonr9e6v8k0DfY4DkT58+DUqHYtPSiVvIxlkXxkcEeMOJxYZRq3c9b7/cHdGNsPo1XqrnLSvp6IK8B3vc4tNQdYm4DDcslpatgvKmXY+e
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR10MB6597.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199024)(1800799009)(186009)(6506007)(6486002)(6666004)(103116003)(86362001)(38100700002)(36756003)(1076003)(2616005)(2906002)(6512007)(83380400001)(478600001)(5660300002)(316002)(8676002)(4326008)(8936002)(6916009)(41300700001)(54906003)(66556008)(66946007)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DBeHqImJfObXcrQH3r6En2Ja1cXRxkFETBkWd5jhti1352Mlc3Wwy2kpLjuq?=
 =?us-ascii?Q?CHpbe6s4d+JVV+p57AitOB02VqSMGOjF6gsxCD7M4bT1mwfpJixpbLDBFw4H?=
 =?us-ascii?Q?Oc+8lpmDB7cOqSe1Ch32rPr8kgKxlFlWOV5T0K6rJhY3dYzI6PdVwwtJLI1l?=
 =?us-ascii?Q?q4fgOZ0K0c0CBXEUve00aHkv59lz0RLpbCuyIK5yYRAJYMJD2eE24ER05sOU?=
 =?us-ascii?Q?jVxseWHaswN/P2/T2xowJZnV3FV1xoZBl7mkHCc66qiwqDAjRab/W05tftOs?=
 =?us-ascii?Q?SFq1aguYzmzLXtbstUA0MMNIztgi/dUfjJfKGx6jnK7/FutTz5lD5BQZeCAO?=
 =?us-ascii?Q?Pe+RcEzWhE46zikwcn4UH1qznbTd+vALOIU1UcR6gh/AsKhG9J/+P9sR1L1C?=
 =?us-ascii?Q?wbcWzAxemicmL810uHWEnWZ9fxIGse7kdhJD3XNAzjLWWggL746yyHRfMoxD?=
 =?us-ascii?Q?XOnH6AtMFJNd3WOV07X/mobg3uNJEVllwwTxIOirMJ3veAPGV8Q9agMBq5bS?=
 =?us-ascii?Q?vFv+48I1rqByJ/Ft4LdCOchBcmCJWMKIQ+ai0YwJZK1O2pZzRvHXQ60Yg9qz?=
 =?us-ascii?Q?rM90k83+96WzMHwuxURDWGQm9j40+uHez7thZ4pnY0JfpyF3TwJPMlN1Cyvw?=
 =?us-ascii?Q?NhfNegfYIVqi6AMBAe6lGL7EqTjx+DIG0KQGUbtBWGDqLcYbZtioiYe8tCb+?=
 =?us-ascii?Q?2FXpZhpjRiBPN1qmGAaa2UhXv1MaxoXcIe8zaRnqW5yE8wMPXpI7n46dJCIt?=
 =?us-ascii?Q?cZ+888yo3jzfa8r8kt3rb46CA1ap2VvHm9jRyxAB5zu4mJpkkfx+Ven5SlJi?=
 =?us-ascii?Q?eVydGzwnsAagn+2s8w7dYJNe3K00JVpZamHEcxJIl8Jliq+jqVv77oINMLXl?=
 =?us-ascii?Q?Sb53K4ZJU/LxBIEUJn9kDxY6L8v+oqZ7qyRTavQCjUeSvCjhAIZsXspM0KwS?=
 =?us-ascii?Q?4sJIjBGFrbjA0OapVqYHTEwOHYWxel2v4gYplzp5pLhWrt5qNyM3dEX7vkzV?=
 =?us-ascii?Q?YzMW18btk6mDKYJ5rlQ0PBnDht+F5c1dv0+lRmZKYZRFzL6fPHK/n1mttD9I?=
 =?us-ascii?Q?A/0cTsDXoEf1bquMfIuLI0vnieORnJX2QM3eRBRJZVztZM7VAsY479G/aZq4?=
 =?us-ascii?Q?NkiKLm1GRpBD1xuy69DZVqxIWM1jZQy9TJwtlpXNOobeQn4rQ7RKsIxw8DIq?=
 =?us-ascii?Q?btGXdmYOBg/B8gsmP5X9NR6ymK23OEaWxygS21xYw3lIepaDuL/OYT4fkOr7?=
 =?us-ascii?Q?SD8wQLQfG8dXZqtv6zvkQhR7KKptwaiC7WqtpyXUx0gyZg16rDw6rNOsxvOo?=
 =?us-ascii?Q?Rz7+WpsLvRQo+sx9KZZVDdW+WZAIDzIeiqsAkMBTVyzNqXELHEcNDS4mc8F1?=
 =?us-ascii?Q?jGv850DgYi5928Nf37v4HXLYIDJFOTpuhljorwtXosQJ3G7a+vlFi6clLhVH?=
 =?us-ascii?Q?ezJ7ZvuYTZwaCRBGrHC77PT4KetUm46fEnLSodAVGaGiIttOqjm9+a3yOLbR?=
 =?us-ascii?Q?D9vQG6SH38av+A4P5yWXshO2npiv3cBh+Cq43EX/+GywMsxZ2fyJrjsx/+mE?=
 =?us-ascii?Q?JXVY/jYZTwaHgzoT9G65L74qq3QgGDW2vVQu/UDDbzZ7R056uPCpv9ikdlSx?=
 =?us-ascii?Q?jwe29n3RATRJA6Q/X1WhNHU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3uyE6Be9vWL0WjH1Yb5BKSU7wwSiY6poW81Yf+8soFmeWxWUl8uXE9VGiI5x0dlldg4dMShDDijPvJE23/XXMZREuGcEcdqdyQwJXcl/sRdcUKUVi24sR8JRPkcTM83VTlTBETI6lKIoRmPjPZ/o7umJUvFP0PAtmtD/RGkctwXi+NpEjZcXiuFV2FSCqt67aefH01zATymFyQZjmuZjF5n+wqmdHIzSVxUggFcBPkE+8lz20TrWv3XyEOT7DI8pwbt6mTm4+abmJ9zfAPF4Nf0NiSRCiz+3Zy6cqeg+UCUxA1/yuTJVgfLgINSUVgeXxkXu/6nmFwswymE0UOmx2WHinZMuUx/GkDIT/+jMhk+/I9Zkq6LGHhwJuRpKfFtvA3GHGSMPFjfjr+0hxbKX+m55E88RX0HU8FzExZpQKF3oKDJdmNu8bBZJVatAqa3vtcGi2bMkWYDKhkuI0HflMqTOlKNwWPXBJ5uaAy+9MN/DMy9M1wUTJpOcrG/gMq0AYDyyrgLue7vdY71yEhgIX5Seg+vMxHz9Ojlz5DEV8c71VEbpfMUcfV1ciA/usK/xSg7f3GAOagCNY9tXvUl+BFEzTqmymd+azeDTx1GR43ouL4i8Wxd3qaw9yLKw8+vg5XWGnt47BPPBz/IVAgikUamdxLk1zr09XzXLWYWa9zdzfMSZn1jcPh3vx/Aq5K5r/cKbzi/iNt7Nt6UK4NkekEflYU80cygNZguptZ33fGamnN2hBcaKr/nUxU/NfudHjt558kupBD5F46T36asixoyY5GFK2HPuQiak8IhtYzCD1p02IJEnzBTC7fRT7t39C1Asz6DhWliA7KP5JoxWsmq0gw/qchAhdrsWbr4d9eCCkr2+Pum9RbjJ7K11EaW3
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36325b31-dcfa-4d87-1a17-08dbb89f8c9c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 23:32:40.2795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lnEgldqVaHUcZUMa/e2B9Sh04JVbqXCRSGvbgzDDbd1ebFPhCqJa2RIGsULvUfHl74tWKfp4n3krbrz9zFlL/3/ivPxfqR0nDs2uWJwu2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_11,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180203
X-Proofpoint-GUID: KoUwSgA9gFQ7jIcbnJhDVvlYLqH5N0KN
X-Proofpoint-ORIG-GUID: KoUwSgA9gFQ7jIcbnJhDVvlYLqH5N0KN
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

The QMP dump API represents the dump format as an enumeration. Add three
new enumerators, one for each supported kdump compression, each named
"kdump-raw-*".

For the HMP command line, rather than adding a new flag corresponding to
each format, it seems more human-friendly to add a single flag "-R" to
switch the kdump formats to "raw" mode. The choice of "-R" also
correlates nicely to the "makedumpfile -R" option, which would serve to
reassemble a flattened vmcore.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 dump/dump-hmp-cmds.c | 21 +++++++++++++++++----
 dump/dump.c          | 31 ++++++++++++++++++++++++++++++-
 hmp-commands.hx      |  9 +++++++--
 qapi/dump.json       | 24 ++++++++++++++++++++----
 4 files changed, 74 insertions(+), 11 deletions(-)

diff --git a/dump/dump-hmp-cmds.c b/dump/dump-hmp-cmds.c
index b038785fee..b428ec33df 100644
--- a/dump/dump-hmp-cmds.c
+++ b/dump/dump-hmp-cmds.c
@@ -19,6 +19,7 @@ void hmp_dump_guest_memory(Monitor *mon, const QDict *qdict)
     bool paging = qdict_get_try_bool(qdict, "paging", false);
     bool zlib = qdict_get_try_bool(qdict, "zlib", false);
     bool lzo = qdict_get_try_bool(qdict, "lzo", false);
+    bool raw = qdict_get_try_bool(qdict, "raw", false);
     bool snappy = qdict_get_try_bool(qdict, "snappy", false);
     const char *file = qdict_get_str(qdict, "filename");
     bool has_begin = qdict_haskey(qdict, "begin");
@@ -40,16 +41,28 @@ void hmp_dump_guest_memory(Monitor *mon, const QDict *qdict)
         dump_format = DUMP_GUEST_MEMORY_FORMAT_WIN_DMP;
     }
 
-    if (zlib) {
-        dump_format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_ZLIB;
+    if (zlib && raw) {
+        if (raw) {
+            dump_format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_ZLIB;
+        } else {
+            dump_format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_ZLIB;
+        }
     }
 
     if (lzo) {
-        dump_format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_LZO;
+        if (raw) {
+            dump_format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_LZO;
+        } else {
+            dump_format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_LZO;
+        }
     }
 
     if (snappy) {
-        dump_format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_SNAPPY;
+        if (raw) {
+            dump_format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_SNAPPY;
+        } else {
+            dump_format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_SNAPPY;
+        }
     }
 
     if (has_begin) {
diff --git a/dump/dump.c b/dump/dump.c
index 10aa2c79e0..55cb6af20b 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -2090,6 +2090,7 @@ void qmp_dump_guest_memory(bool paging, const char *file,
     int fd = -1;
     DumpState *s;
     bool detach_p = false;
+    bool kdump_raw = false;
 
     if (runstate_check(RUN_STATE_INMIGRATE)) {
         error_setg(errp, "Dump not allowed during incoming migration.");
@@ -2103,6 +2104,27 @@ void qmp_dump_guest_memory(bool paging, const char *file,
         return;
     }
 
+    /* externally, we represent kdump-raw-* as separate formats, but internally
+     * they are handled the same, except for the "raw" flag */
+    if (has_format) {
+        switch (format) {
+            case DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_ZLIB:
+                format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_ZLIB;
+                kdump_raw = true;
+                break;
+            case DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_LZO:
+                format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_LZO;
+                kdump_raw = true;
+                break;
+            case DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_SNAPPY:
+                format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_SNAPPY;
+                kdump_raw = true;
+                break;
+            default:
+                break;
+        }
+    }
+
     /*
      * kdump-compressed format need the whole memory dumped, so paging or
      * filter is not supported here.
@@ -2166,6 +2188,10 @@ void qmp_dump_guest_memory(bool paging, const char *file,
         error_setg(errp, QERR_INVALID_PARAMETER, "protocol");
         return;
     }
+    if (kdump_raw && lseek(fd, 0, SEEK_CUR) == (loff_t) -1) {
+        error_setg(errp, "kdump-raw formats require a seekable file");
+        return;
+    }
 
     if (!dump_migration_blocker) {
         error_setg(&dump_migration_blocker,
@@ -2186,7 +2212,7 @@ void qmp_dump_guest_memory(bool paging, const char *file,
     dump_state_prepare(s);
 
     dump_init(s, fd, has_format, format, paging, has_begin,
-              begin, length, false, errp);
+              begin, length, kdump_raw, errp);
     if (*errp) {
         qatomic_set(&s->status, DUMP_STATUS_FAILED);
         return;
@@ -2214,15 +2240,18 @@ DumpGuestMemoryCapability *qmp_query_dump_guest_memory_capability(Error **errp)
 
     /* kdump-zlib is always available */
     QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_KDUMP_ZLIB);
+    QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_ZLIB);
 
     /* add new item if kdump-lzo is available */
 #ifdef CONFIG_LZO
     QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_KDUMP_LZO);
+    QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_LZO);
 #endif
 
     /* add new item if kdump-snappy is available */
 #ifdef CONFIG_SNAPPY
     QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_KDUMP_SNAPPY);
+    QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_SNAPPY);
 #endif
 
     if (win_dump_available(NULL)) {
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 2cbd0f77a0..69eaa1d6a6 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1085,14 +1085,16 @@ ERST
 
     {
         .name       = "dump-guest-memory",
-        .args_type  = "paging:-p,detach:-d,windmp:-w,zlib:-z,lzo:-l,snappy:-s,filename:F,begin:l?,length:l?",
-        .params     = "[-p] [-d] [-z|-l|-s|-w] filename [begin length]",
+        .args_type  = "paging:-p,detach:-d,windmp:-w,zlib:-z,lzo:-l,snappy:-s,raw:-R,filename:F,begin:l?,length:l?",
+        .params     = "[-p] [-d] [-z|-l|-s|-w] [-R] filename [begin length]",
         .help       = "dump guest memory into file 'filename'.\n\t\t\t"
                       "-p: do paging to get guest's memory mapping.\n\t\t\t"
                       "-d: return immediately (do not wait for completion).\n\t\t\t"
                       "-z: dump in kdump-compressed format, with zlib compression.\n\t\t\t"
                       "-l: dump in kdump-compressed format, with lzo compression.\n\t\t\t"
                       "-s: dump in kdump-compressed format, with snappy compression.\n\t\t\t"
+                      "-R: when using kdump (-z, -l, -s), use raw rather than makedumpfile-flattened\n\t\t\t"
+                      "    format\n\t\t\t"
                       "-w: dump in Windows crashdump format (can be used instead of ELF-dump converting),\n\t\t\t"
                       "    for Windows x86 and x64 guests with vmcoreinfo driver only.\n\t\t\t"
                       "begin: the starting physical address.\n\t\t\t"
@@ -1115,6 +1117,9 @@ SRST
     dump in kdump-compressed format, with lzo compression.
   ``-s``
     dump in kdump-compressed format, with snappy compression.
+  ``-R``
+    when using kdump (-z, -l, -s), use raw rather than makedumpfile-flattened
+    format
   ``-w``
     dump in Windows crashdump format (can be used instead of ELF-dump converting),
     for Windows x64 guests with vmcoreinfo driver only
diff --git a/qapi/dump.json b/qapi/dump.json
index 4ae1f722a9..5cbc237ad9 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -15,11 +15,23 @@
 #
 # @elf: elf format
 #
-# @kdump-zlib: kdump-compressed format with zlib-compressed
+# @kdump-zlib: makedumpfile flattened, kdump-compressed format with zlib
+#     compression
 #
-# @kdump-lzo: kdump-compressed format with lzo-compressed
+# @kdump-lzo: makedumpfile flattened, kdump-compressed format with lzo
+#     compression
 #
-# @kdump-snappy: kdump-compressed format with snappy-compressed
+# @kdump-snappy: makedumpfile flattened, kdump-compressed format with snappy
+#     compression
+#
+# @kdump-raw-zlib: raw assembled kdump-compressed format with zlib compression
+#     (since 8.2)
+#
+# @kdump-raw-lzo: raw assembled kdump-compressed format with lzo compression
+#     (since 8.2)
+#
+# @kdump-raw-snappy: raw assembled kdump-compressed format with snappy
+#     compression (since 8.2)
 #
 # @win-dmp: Windows full crashdump format, can be used instead of ELF
 #     converting (since 2.13)
@@ -27,7 +39,11 @@
 # Since: 2.0
 ##
 { 'enum': 'DumpGuestMemoryFormat',
-  'data': [ 'elf', 'kdump-zlib', 'kdump-lzo', 'kdump-snappy', 'win-dmp' ] }
+  'data': [
+      'elf',
+      'kdump-zlib', 'kdump-lzo', 'kdump-snappy',
+      'kdump-raw-zlib', 'kdump-raw-lzo', 'kdump-raw-snappy',
+      'win-dmp' ] }
 
 ##
 # @dump-guest-memory:
-- 
2.39.3


