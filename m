Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65266804279
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 00:18:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAIB9-0002Lo-D3; Mon, 04 Dec 2023 18:16:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.christie@oracle.com>)
 id 1rAIB0-0002LJ-Id
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 18:16:35 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.christie@oracle.com>)
 id 1rAIAy-00075B-Hn
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 18:16:34 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B4Muu38017605; Mon, 4 Dec 2023 23:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=KkNrrte7u+T3cqtl0JmD8BgOrDiWCo3/5ckFwc+BZwc=;
 b=XKShw9nRyV8IavcF3iwAcMhUl13og6+rfJgqsF3cu3/K49nddSgIisxT73h7tUWWFnaw
 yXN3oIbne+edjwBlmGbfquzD5U+3oqoBp1CaJHrHppTRytOPkfcCtkkv9qz9ee7Lf9WJ
 v6END21ewHbD6f4NIcOBGjnfhn+mS6GZSiOHJbmw7X7/Mo/GuJM+HFmfTHljnKrUAjnx
 kBGTMzVagt0JPb5ddVPLQoHSg2xAUPcs6jod55PyZAWVD8AxIRo1I3zgHzL4tZfRJ8kk
 1AIwL4prowWR+lEY/rwC8GAYuyqdhfRUj4ISCe83p4X4UTG6BlVrRhq6QWSztxACaj7R +g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usqnf02bb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Dec 2023 23:16:25 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B4MIoKE026383; Mon, 4 Dec 2023 23:16:24 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uqu16m1wd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Dec 2023 23:16:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtLLQeTS46H33WbXjkLK2yhK2w0Gx5syaQ8h1eyl/nzjr0GhvG5rqZJTuIIpjZ0KCmkDbQOyuTuCcVgPgmu3zRKun7MTVvcYxXDHQCBy6PiVABgTt6dHLXVRfZalXBXUgk9mrqn2HvPM/og80EBr0fuKH871LqerTLySbw0odYWbSTpy9vJ7T26omFyry8anMAwfycvwoUIdF/gMzIE/KFKW86dPJqs1AO+iv07YKzBHszOOjfL+n6QWHuR3Wros68JIsIkS/JdMjOwcwVt3di0NNwDF5Qr5xot1p9gjW9c1EzOlydGDqUPrgBzyH/eTmvIlCVrd78fjYuV8W+IWiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkNrrte7u+T3cqtl0JmD8BgOrDiWCo3/5ckFwc+BZwc=;
 b=V2zz+rjILannMbw1oi86ai/ZSBqABo1posHGcjcjisBYPg45dIqeVkJ0OHF5tCbY3AZz9QwP23DkM9MMBOo2WERUU6HiMSzDdIzcd/KQhzh0CqUCN0wn8yAD+JpArZr7pIQklzrX3U8+Ss5yE3fhiGwk9/fc4KQEXO246j8y5wvYy2n1Wxg1Pc9vZp6eJ/9v3auSpOz+gS8NppELqapoHc0fNZtBIqchqAh+Jtye/ud0q0YbKqidhjKpQBNrM/36lyF/wNwLkoaDTy8s4FTfo/SzJjbIF+2v5kYi5vi4D6cCO6JN7lv/Ar2t+MJGpJYQQ0yeojcdWcDQ33fpRHNx6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkNrrte7u+T3cqtl0JmD8BgOrDiWCo3/5ckFwc+BZwc=;
 b=FGKHvvq/hXAZg8zjjPZn6k/bQ3KBnzw+ahlejit81O4RGoPczCO98XJVEV2wJ81IvqiqbSBrWMbKToMN0ZEUIqEZXHQ823WGlTT5BeVe/Ef8G9FGU3fbOHw/De7aYHlE6O/FULPE7TgOsErnRvKO/YP05GnnM2+wYcHnVlrcoGY=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by MN6PR10MB7466.namprd10.prod.outlook.com (2603:10b6:208:477::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 23:16:22 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 23:16:22 +0000
From: Mike Christie <michael.christie@oracle.com>
To: fam@euphon.net, stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] vhost-scsi: Support worker ioctls
Date: Mon,  4 Dec 2023 17:16:16 -0600
Message-Id: <20231204231618.21962-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::17) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|MN6PR10MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: 9243e352-e93d-4208-e331-08dbf51f078a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oVQsySd8vcey1bEIMrfAVYtBggXXg/4LQ+MTnh3IPEC4zR3rVOBjdde7+fNuD93bStA1ROQTMq+wS08Br07Yy7mMq4yh/VcylxBTPGfgPuVqAl5EXnDX8O4G3oCaqtDc+zihYnKra3sEo6jlK419Q+Ui7p8bixkWmqOJZnop3YYecI3fgdi57k7g7UsqhpBlNCFzxuYJUHxErpXPiEtqLf2BDapY3lHFVcbbqHsKlAg+Z2kdwVNwi4kfVZ1viYAdsxmmfj8Cogo7ku5AvMeqQ0T1LCu0yEdKyDyTwbuExf55wRkGqRmDPA8RdllWJPBJGiBpNjKl5we3Fzga7gZ3X3wl26xBVk/rFeGUhnE8qx0IZ+Ri6c2kAFjndFp/vb6iXAC4Zn7WM4umLHxXho00T7rQE8mA7+VAXs8+fZsnWhQkZcZwg5LTNggHFMFg8kaTVsS3bQcxBLu7owhIzVTC9d+HUmhGoYWzavKE9FfpJCvTVQflHw+DS39z5UWDRctxdRiLii8DAURnqwMGrd6MriVwPiHyJYKMLvqqzneHDFI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(66556008)(66476007)(66946007)(8676002)(8936002)(316002)(6486002)(478600001)(966005)(6666004)(5660300002)(4744005)(36756003)(41300700001)(2906002)(86362001)(83380400001)(2616005)(26005)(1076003)(38100700002)(6506007)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NNJm6odYxUQxR/wd98wkzFVp8iQ4RgA+45Qm5EmhSTtirLpuskTxdU4v0EmI?=
 =?us-ascii?Q?W2j+YULvUfkw3zLA4DX+AANU4NC5TR7cgUEohopUmZmin7pXJAaR6phSqGBQ?=
 =?us-ascii?Q?3t3TMgOZeL02I+OXVD7piwI6FJlPmwhUqDDi6fqkvMDamWlXHFtYhb2eG2x8?=
 =?us-ascii?Q?wYW+0BXPmzoNwFiisgNUekmPyBABvShLo98Cr4AE4R4b/3nIXpYnyGKEK2Bs?=
 =?us-ascii?Q?zk3GpWhrTH1ZwqQ9XFsHQSWZP7KEIaDcQAvg0w8DvfSgKFndJOaTevfBXzqU?=
 =?us-ascii?Q?ykFCyW9oijkRHe59ZdysPSKVc2uQTu8NWtTPTVD4OYSOnrsZTFM8wgFp7HQJ?=
 =?us-ascii?Q?881msq06cC8+egQkFMMzB6QNO0f+LICCKJkLzgosdnjBRF6iqdZSld1TPfpS?=
 =?us-ascii?Q?9n7Qtnq3K6O9aZnqVzlr/uu4ZTY/bwA737aSgSrajjQ+BM/Ja3GQZvZ6Bcd7?=
 =?us-ascii?Q?x2ANBIAShiUYo2FaYKxqzFygxWZPBWQu5WorsFWXYrnUPGxHPrXnlZFzL1Go?=
 =?us-ascii?Q?Dioa10MPTaWV77COTuw7acH6RW51z5IMNIVIps8wM/0NWRyfIqsQSNaavkcs?=
 =?us-ascii?Q?9qX4Sbm1S4JQixMDEHWumvImEG77VQMkvuEd7WiE1Pzd1ElRfz4CbPJk1dqW?=
 =?us-ascii?Q?EPgOsXG/F62NNJBrY+CgNc7lUqrWYl6XMYZwhZY///GIRV3WGxjMezLpy+Rb?=
 =?us-ascii?Q?GeU6+Wkvqe5P9Y9tXXzcFYMkQdDzWlyl9Vuh0ma24+EIQJ1e5S49ZDs21+1p?=
 =?us-ascii?Q?1s3TyGu/WXSJXaB+4Zj/tcgrtbor9SZGvbZKNvHx2NImSc34q9ugY4lecAJI?=
 =?us-ascii?Q?cmdzMzySfkLj73Q4MkFEIGwcXCkr5tLMbMvTHOIBdhN+IXncfDQJ/WqAic39?=
 =?us-ascii?Q?38mVDLLRheKb4qvJLxZvP8iHU085EjepnlPtyQZCVbLAQngNQWYNZ6MSGrFR?=
 =?us-ascii?Q?zNZOj8k41IsnuBfaxXA3XwF3CNWsrD7To9MlT0WknNf0yVP77V3UX0RSU71w?=
 =?us-ascii?Q?OOARHmztq4OC+itwsRvj9hVLTlaas4CPrZeuirp/DXQIpI9gg9+A23Rlp5ap?=
 =?us-ascii?Q?12G78usSYIe5mU3DVu8UY5xWpVbAumBffYkYmAgGFQG/MjHGxo9elFZmyug7?=
 =?us-ascii?Q?VYbJQY1IA4sHXZITDBBzabngY/vZLoxxESA+JwtsvZ/cD/8RmvTUMraBh+Ag?=
 =?us-ascii?Q?oSkRfWYz3mHm7GHDrkXXQLWv2I+Y0tMyx935aar4oYg2DWh1HNZ8ytnA28rF?=
 =?us-ascii?Q?6NgBYeezjhwEs3rdaIYK0QL/My3ThHiWYt96Nidx9QJfdd1iI81dkudXN1vn?=
 =?us-ascii?Q?r1gyz5BIJFGfr7UPDFYCWymJTviml0o8umMQZZy6W4xSIA/D6VI32GhYFRcW?=
 =?us-ascii?Q?mpshfjj1djfzcY6SXWkIK7Yr0KD6EtVQWG9bU0dhe8WC+1U3tkHKcGTeOEKB?=
 =?us-ascii?Q?1OdPwZEIh5N6UC34JT7fntxK91idINeXjYEbdxFZDCHOuMliezxChBe7j7iL?=
 =?us-ascii?Q?KyRw1GkMfMgGRZ4sWh91luXEOOJLBdz38WX7D/oWFccqOxh0K23EChYx/NgP?=
 =?us-ascii?Q?rFmM/wMhydbkyWtDirS2Qy4IPUVdWC9H4S76JSOWOXtmyBojdmozyCJV+p2p?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BdT512t0nNsU6FX+PD0FD9y1Ja6IMok9q6t5BULGSMLjJcInJYhkQG3/uoyR0wmqEwKy2knENKwM+zb0AyEXrQ9+d80OOkNdWANRKIXzfOorxr7qINrI/Iv23cIOW50lP9fSWdQ17B8L0nmIQEIULaU6kkhXey+OyUPAi9Tjc8IfPIMf02nNHrhZikpwoQPCsAGfdPvsjYlC9IIoGEuC/PvLC5sIYMbk9bZQTl+gHnCeJkGoe9hjKZgAdMv1Nl6XntTz2zqbemprP5apl9x7BMJionTz2VtgYOqVTnE2MvyxTaGPEE6f3CIbuHj9jBT/2VaknUJhy10tpH+NDhYIEqm47gZxBk24R7buPFa7OUBKm/yfNUGJlpof5L3uFEseyyQMiAVkIqYcOPZzaszqIYrXwxfpqIuoZIOm9nxphnblfEtGbAEFKatzXMrSl6y+r9PkZZDP4qgyjpVu+bMxZnxfTw0yh6AQuFNONCMzacTq3lzdOWL3zG5XC8rfI76Dqhc2yXFjxVewnXnjLSGbITYxGyEb/xuzbdxor6fkTMu6xJgB5yFk/mTHtCHbIA7vcNGeNOXD6J52Ao83iCdDNC87NBTCibNmhH/3DObfTox72cn4DwlqS3WrZBREF6+cZ2MxZYcXqynnR/nxeOqIIOLj8RD2jUUdflEHfJtyak/RwYNy/Sq6x2c39YyO9W5tYKjI2stOUHKMjr7ru+/oZoFONY7J6vzQQrFLbCtGFTxfrHN6dvD/LrY560I2uRK03+Ag3yiyQiOSjP/oqKf9h9fICwYDrSJPPBfK7UC9/QeHF49FHlLsECH+kXRfHNpl
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9243e352-e93d-4208-e331-08dbf51f078a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 23:16:22.3526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1SMh5DS7xl8m5NOfc+HrZ2R1ZNEu24ZvLHOgqjLZ3pvYzX0WTaby0Dw82cGD9MuOEZ175FqrF2pHJEGFHwvSya+c8q3E/x2dzeolG/AVE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7466
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_21,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=726
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040182
X-Proofpoint-ORIG-GUID: i3ypidvK1UxD1oI95RZUh08cFak4-YOh
X-Proofpoint-GUID: i3ypidvK1UxD1oI95RZUh08cFak4-YOh
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=michael.christie@oracle.com; helo=mx0a-00069f02.pphosted.com
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

The following patches allow users to configure the vhost worker threads
for vhost-scsi. With vhost-net we get a worker thread per rx/tx virtqueue
pair, but for vhost-scsi we get one worker for all workqueues. This
becomes a bottlneck after 2 queues are used.

In the upstream linux kernel commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/vhost/vhost.c?id=c1ecd8e9500797748ae4f79657971955d452d69d

we enabled the vhost layer to be able to create a worker thread and
attach it to a virtqueue.

This patchset adds support to vhost-scsi to use these ioctls so we are
no longer limited to the single worker.

v3:
- Warn user if they have set worker_per_virtqueue=true but the kernel
doesn't support it.
v2:
- Make config option a bool instead of an int.



