Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 107A47F96D5
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 01:30:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7PUm-00077H-MV; Sun, 26 Nov 2023 19:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.christie@oracle.com>)
 id 1r7PUk-00076Y-Js
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:29:02 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.christie@oracle.com>)
 id 1r7PUi-0001HS-P2
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:29:02 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AQN0RtW022013; Mon, 27 Nov 2023 00:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=Jgk8p9v6vkAXpcLfp+zGWwoj2p/KKJ7B9XKDSSlYvSE=;
 b=TYNyr92jasyDly/yYxP7HE2Rje4fKB0wCWRGVHBaQXSkEkWV4peZ2s2vhSH0SV7Gq62+
 IZzAaK09qxzd8fyO/OooBs+yONkCx1ZCLVjqIMwCnoXjBg098Um5qQG+oXOvNch9ST3y
 KpGOgCrYsSe77pIzqnJ0XV1eYIsHuCHa83tbbvBGOKvHvi/n5pN2j8j7zn4nt8JsDFSH
 VCiF9JpXVluj6XehQjNW2W8Vk8qE7aZe7+SLLjZu/jfBzom6J2guG5dYBEoYFwa0LP3q
 FztfEXJ4d6YfEMZoRmMKp+mKcWzH/7E0gZutZ0EBd8QH2jGs+tLkkW6Az84jTahoKo+S bg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7uchtbm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Nov 2023 00:28:56 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AQKSNrV012597; Mon, 27 Nov 2023 00:28:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uk7c4vpn1-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Nov 2023 00:28:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VU5EHTkJmsX5gpArFxEUmSJ6scxWdNq9dpAeTidGUcTHBTIr4Kvu48zLtdsfc1tj8xmBRI7wygoZ3L7BqT521+z1u39kCnaRYP3NGdQc+Dmmpmj6ClLzATvuV5shH9LmJQ8eOF0qdWxR0Xs23nhqKzjNhzZaAf+E2mfOAkunIMEaqtGoRWkvYnAhVW3jWvV/H/N6DZLX6sUeMenGn7J13o0E+kvyjlHDvt25R+fsVIxMU1a4N4+7FbV3YSJpsj8mQLiC81N/HaC77wf8bX6DcSZ7fhW9yHgJ9OQy4lMvTn//8wtDZ7+s/R7YtheP6rAnSFTQ93oP3qQpjhh7Tco/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jgk8p9v6vkAXpcLfp+zGWwoj2p/KKJ7B9XKDSSlYvSE=;
 b=Ibv9Xr2LAY4JwNlwI6DVNjFG7X15sbVO53tibCXuMIX2WpNGW0m2f94baAWc0I75/rAT+AZiKM4d6f9+o4/BRsvk6E1jyEBugrYUZCdikdrzZXYNPEHT6UnNDEYLmSzXwOGIklE7Niusjaf5kyDVRLiyk5CvuthnXDIR53hmlT0dXGSvt+rLZTztgt4L2BsUpg+1iafy05WRNbcCDrn1N0eXGGM35FDrkbXIMdnSY1egLnNp4DDTwBJzABO2CAgj4Qtb1NzIR4j8yF+bBoubjkYgFGTGa4wWkLO6MEsI+7dXU69mZOt4Kx9I5NJBINiuu40f2y9KWxD7GcBxHc0r0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jgk8p9v6vkAXpcLfp+zGWwoj2p/KKJ7B9XKDSSlYvSE=;
 b=zNZz6aro9yoLgjpmQ0LLIlfkjMqEkgYps/a7vd9aRhsNbZ5UcF72HOjZy0NUxB0pXWmzBFoCer5bQd9dCx7Zxm02RzUA5nFXjKJhZ5flso1bfCGQxeHMSGMXwsWDO51WXAPbnGta4JDs9dKf4nBaG//Bywm/AyndpJM33bwHkNQ=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by DM4PR10MB6863.namprd10.prod.outlook.com (2603:10b6:8:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 00:28:50 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 00:28:50 +0000
From: Mike Christie <michael.christie@oracle.com>
To: fam@euphon.net, stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v2 2/2] vhost-scsi: Add support for a worker thread per
 virtqueue
Date: Sun, 26 Nov 2023 18:28:34 -0600
Message-Id: <20231127002834.8670-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127002834.8670-1-michael.christie@oracle.com>
References: <20231127002834.8670-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::27) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|DM4PR10MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e7c327-832c-4f66-1651-08dbeedfd3c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jkQS2rl98lN6bdLYSQxhTZk1DFTz6DF+gWPOCTBxkUNWIuz1nSBdgwupExk2ASRa14r+B3AWK0+gC6500jKYCGKBFmRWLzKuM58cFxBtpafKsH4NLruIijoOVeBCCLicG0okMcGMiqZGBBuS/ZAbR3E5PkV8NpFDA9gUSaWNaMKxcWPYhbFgdFh0+vwOD1uNYfaZAs8SaCIIf3H4Rm2vNm6dJ6AEA7JWv6Ygq1ScErokpvfz572yVciHpIw8WJetnfa38gC1J/ItncDXXl4rbih4T+ar103VSCeCx5A4iKml4fteWb4pVhUrjJUGrYkrTFOBKccemjW+YnGJ7s0Hp7tSHijArd2MyvnVCE7NIc7460mHlHpOqjnulIEDBJd972L1WtAqQwz9IKrUeUEAUcRCc+XxAOCLAKqkSM2yHyssIXze4cTBIic4ZIfjb7j8dvGy1gKnhUGtsC6UOHN68IXRtdQT+nyGcO110D0WHzPuoXvyRED6I5JepLMuzul5R23qm/jFzrheIblbp0Q+oek94gKH2G7qLyfGjlJnhVXJyv5zMA5t1n3hu0Iur/uk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(4326008)(5660300002)(41300700001)(1076003)(26005)(8936002)(8676002)(2906002)(478600001)(6666004)(6506007)(6512007)(107886003)(2616005)(38100700002)(316002)(66946007)(66556008)(66476007)(6486002)(86362001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Saaano0JpD25AuEds/ChCblzbZkANVwLqFthTu6+mKOnMudvou+gqCTBJJj6?=
 =?us-ascii?Q?OCdx0uxMg6Pb/GuQ+qZIvMcwjsESKnQK1Erdyh6CkGL97/HAqzjHXKJIwIIx?=
 =?us-ascii?Q?GCOtI/GTXl8PpeQkC+QGkIOzm5mVB5Er+Aoq8vTbTnChPLJVmc6y8FHZ5ZtC?=
 =?us-ascii?Q?3DZEJmp/scNur0bPwryFGF5DAZyH93WWOS3QPJzEZ3wl2yiyFkECnwgZOGt3?=
 =?us-ascii?Q?HitiUvbBrHsDSDgYSoXjidUYwvgRV+5dKlO843oF8IZgrEHKQKNCBrkNyfhN?=
 =?us-ascii?Q?f9VJbRlzPZgpIO8lInUZkQ0MtQ4ER1LZho/vvSW3DXkWHSThyeo4okcjEU2O?=
 =?us-ascii?Q?1K31oNWXxxBkzQcclWUK0iXti0HB8V2MOj7N74tDMt29vOpnAq//CZLLrPkP?=
 =?us-ascii?Q?cbtU+OFNGFGuYI+ERtWYPiKWyBPxep0TxO4nhIA0KhjPB8QFs0O9rzECEDOA?=
 =?us-ascii?Q?MSj/Pvd+XOQyBg1dMFSnbdZ8CTF9B4JwLH2eA8wjRFXXCz/vQg9TFZ/d7E88?=
 =?us-ascii?Q?dBRTrt19+Fty5U6bxNwtRrBlOZDG4McdBJke6xAQ+j2d27MCps8qQjckcvoS?=
 =?us-ascii?Q?7ZASLAFqFPo6ZVz+LlYbtiotPs845QFhZEM9NpNwzsn08n7JNqrNMvgboVKZ?=
 =?us-ascii?Q?qaw7+fASeAYnwZeoPs+BLgtWIfooBhXRX2t6qi5ow5R2ucXCDbjxPcgsT1J/?=
 =?us-ascii?Q?DgupXxO5iJhzD/X5t8wBo08s/26mQW38mgCf/jdVrw88xK2dmYVtvj6v08Pa?=
 =?us-ascii?Q?3Tna03NLarlboovfZSc0RJJocG3YW7eCpIScCERUJNNyAIt2s8wed9ptVuro?=
 =?us-ascii?Q?/RLEw+4YTRVMP929u1hyEMYuiGokwFYZ4SAYdNqCX+OPQq1S7KfOavxVqQ9H?=
 =?us-ascii?Q?2KvM+CqnxugzLLuElSOLC8wVBjptMynH1wQVnQwNuEjXEZXFmSJNYLb7dEpK?=
 =?us-ascii?Q?f8+mW19JuKKqBlbcX4Kw5SqnOvHacfK9+uDKDdZ16O2vanwFLI4x0euBmEsC?=
 =?us-ascii?Q?K2qwQhBgRiKZR40PJncpXxgcVoVIpCeNQxMEGKNEX2SbJGNuCdc/4egetz5Q?=
 =?us-ascii?Q?a5d6OPTi6WYKZlEvUuVfesYm5XTp0OPJk/yCqJIRUwZqJG+TD9Jv3exZbYkb?=
 =?us-ascii?Q?lRlt52KeIrfnwZtSD7hhdCZ8mjxzPUr4GP6jdg0Vp4/gKaiph3NZ3c+pgnjd?=
 =?us-ascii?Q?Svy0ElPegU834UPkAfD3hUEAry7k8jYpqJx8sjTiWPW8Z9bmhxCl+s9oz74G?=
 =?us-ascii?Q?nE14j7KTIeO1uoCVGkefluE9gMwIEpfg1gxOu6OFZ9hoNhY8OchSDOobuk1x?=
 =?us-ascii?Q?svmDGoODABwmthYhE8rKBUwSXHg3YHN16KIqKAzLEz2m0WML+1GPaOLM+1+E?=
 =?us-ascii?Q?t6fVRQSAVx6nDmjLvhGj8RFZXq7SZ4cEfXr8oi86DAYGqcFKG8G3A1rfXl/R?=
 =?us-ascii?Q?/zy6CDhKy1eto7MVu9DRMt0ruiCqVyuvLQ6xaUX1nKVhsHeXorOXDAEppvbP?=
 =?us-ascii?Q?8LW46lI64cGNuzoEoGDPjkrzRTRgFC+2LODCdBkZ0yKtEEwivgbygxi3j5JO?=
 =?us-ascii?Q?pNwjJhbEnsIYQivPcHasPpFoSWGVhrCy/D7q/cENgmvc6sxey3eNwuvQokOL?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1dQkjkYJxkNv+XpXXdAiYnWBr2mov2Xt2urSDWeEel+jWfStnh4Xp3JmjguFPvzlaSULCrzXcGnCRzxCxprJEta7PPzeJeXSs6qxQlIsmb/KGNK8MS18QLR8Nbf37enqZPKoAKricmjUPzHy4SvMKLSfF4+wDSE0uwyoRrY1Riz53ePeb41rhfB7t/2Q4t7mTLAWo+VeVCWHqRzFO0EgyFebnE8+j/Gjo0+F0VEe6TVMVNXvNLGIapKWljJlgAqk1gdprPbnJicMl4QoAJkxHv/JQFhj2RNJaX/C8mFUNtEKu7mNnfLnueyauGj7iEzjlr54vvrOsvP6Hj+evSQVHdm77d8JV8f5C+2ekp3Sqs/v8+u9y9ZZeeuvdz7bprU8N3dla7sDDx/W8yyQ9fBmX4W5oXC0IxNQEbpuEdrM8guhQffO3PkS1mFcIDVaageavKRefUcM0455kpjUIW9lyaOK9ATxXf+R7KsOmea2I1FiXAmmhKSbK3FcNG5H7FOGtXQoT8uyVilucbnOunmZ13qKtfNE/zvvrdxsbd3PkEMmKpvHftWqzyt9MliPJB8HLB/9K+j2cQ8fMZ1PfRGMeQytnSDlxqW4qndYnoCGAUWN5ZPjd+iMtg8DM6cssD9zoEAPIiLBWbA7pYjSeG+JT0PXUXsevdIUcZ6am4yI0EjCj62sLWR7BpAR2so2KrG2OdPDSlEeSJHAf/wzY3ftmgn7V6RhUxcMaPusTR8JuDpStGW495/qzW/kLdR5iQjM2UkNWuHcV86wCy74V0yd1G6x4jpMfx7onVAojkVybMbYVRQ0NhlaeIP2iEkPuvKe
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e7c327-832c-4f66-1651-08dbeedfd3c0
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 00:28:50.1647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJ5lMvh6jTRfb+laryB/xWRWgqCMAPQNBvERDR0w7ZZAehkfwawLvnc9UCoqD2ORL3vGYch4K3bDIgaZF26sjdGiaRe9sFB4mGR5JAdy9dQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6863
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-26_25,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270002
X-Proofpoint-GUID: xIGmbUT2IQ_iZpKIOM4pHwDZglerixNX
X-Proofpoint-ORIG-GUID: xIGmbUT2IQ_iZpKIOM4pHwDZglerixNX
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=michael.christie@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

This adds support for vhost-scsi to be able to create a worker thread
per virtqueue. Right now for vhost-net we get a worker thread per
tx/rx virtqueue pair which scales nicely as we add more virtqueues and
CPUs, but for scsi we get the single worker thread that's shared by all
virtqueues. When trying to send IO to more than 2 virtqueues the single
thread becomes a bottlneck.

This patch adds a new setting, workers_per_virtqueue, which can be set
to:

false: Existing behavior where we get the single worker thread.
true: Create a worker per IO virtqueue.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 hw/scsi/vhost-scsi.c            | 60 +++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-scsi.h |  1 +
 2 files changed, 61 insertions(+)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 3126df9e1d9d..77eef9474c23 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -165,6 +165,57 @@ static const VMStateDescription vmstate_virtio_vhost_scsi = {
     .pre_save = vhost_scsi_pre_save,
 };
 
+static int vhost_scsi_set_workers(VHostSCSICommon *vsc, bool per_virtqueue)
+{
+    struct vhost_dev *dev = &vsc->dev;
+    struct vhost_vring_worker vq_worker;
+    struct vhost_worker_state worker;
+    int i, ret;
+
+    /* Use default worker */
+    if (!per_virtqueue || dev->nvqs == VHOST_SCSI_VQ_NUM_FIXED + 1) {
+        return 0;
+    }
+
+    /*
+     * ctl/evt share the first worker since it will be rare for them
+     * to send cmds while IO is running.
+     */
+    for (i = VHOST_SCSI_VQ_NUM_FIXED + 1; i < dev->nvqs; i++) {
+        memset(&worker, 0, sizeof(worker));
+
+        ret = dev->vhost_ops->vhost_new_worker(dev, &worker);
+        if (ret == -ENOTTY) {
+            /*
+             * worker ioctls are not implemented so just ignore and
+             * and continue device setup.
+             */
+            ret = 0;
+            break;
+        } else if (ret) {
+            break;
+        }
+
+        memset(&vq_worker, 0, sizeof(vq_worker));
+        vq_worker.worker_id = worker.worker_id;
+        vq_worker.index = i;
+
+        ret = dev->vhost_ops->vhost_attach_vring_worker(dev, &vq_worker);
+        if (ret == -ENOTTY) {
+            /*
+             * It's a bug for the kernel to have supported the worker creation
+             * ioctl but not attach.
+             */
+            dev->vhost_ops->vhost_free_worker(dev, &worker);
+            break;
+        } else if (ret) {
+            break;
+        }
+    }
+
+    return ret;
+}
+
 static void vhost_scsi_realize(DeviceState *dev, Error **errp)
 {
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
@@ -232,6 +283,13 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
         goto free_vqs;
     }
 
+    ret = vhost_scsi_set_workers(vsc, vs->conf.worker_per_virtqueue);
+    if (ret < 0) {
+        error_setg(errp, "vhost-scsi: vhost worker setup failed: %s",
+                   strerror(-ret));
+        goto free_vqs;
+    }
+
     /* At present, channel and lun both are 0 for bootable vhost-scsi disk */
     vsc->channel = 0;
     vsc->lun = 0;
@@ -297,6 +355,8 @@ static Property vhost_scsi_properties[] = {
                                                  VIRTIO_SCSI_F_T10_PI,
                                                  false),
     DEFINE_PROP_BOOL("migratable", VHostSCSICommon, migratable, false),
+    DEFINE_PROP_BOOL("worker_per_virtqueue", VirtIOSCSICommon,
+                     conf.worker_per_virtqueue, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index 779568ab5d28..0e9a1867665e 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -51,6 +51,7 @@ typedef struct virtio_scsi_config VirtIOSCSIConfig;
 struct VirtIOSCSIConf {
     uint32_t num_queues;
     uint32_t virtqueue_size;
+    bool worker_per_virtqueue;
     bool seg_max_adjust;
     uint32_t max_sectors;
     uint32_t cmd_per_lun;
-- 
2.34.1


