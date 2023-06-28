Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 281EE7416DF
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 18:59:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEYVU-0007tv-Su; Wed, 28 Jun 2023 12:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tom.lonergan@nutanix.com>)
 id 1qEYD0-0006jO-Bw
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 12:39:58 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tom.lonergan@nutanix.com>)
 id 1qEYCx-0002HW-Hm
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 12:39:58 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35SEKA9M024880; Wed, 28 Jun 2023 09:39:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=YM0K8+oAOqiDWsJILhfiX5Y1VfLZ7WYAbuHhntTtJY0=;
 b=CglPM03mTi9PHusSRUsGax+r47diNttgjIG2guThAc/4yG6TVtE0U/rdpVdSnRf4mezZ
 hYZzzDiVbU1VSqdSlc1KEOwqg1yKm4qrepHXCtEzmaSuXTt420YJAhIg9anXrmk8UW/G
 w3Wh5XOX5C9lAXkLNSpotrhboj/olxMWQDdU3H1f14OKGcC4W6NlE3jec3uYU2FX2abM
 U3Rhy6tMPtC7kuEPuJxYVPDc1FBuMMtTZ7zP20yRnGT0r3Ws8S5CAsLSXmSefh/E8+Uf
 xZjzlRHKURtcQMMi7lGKnY7Dzu0u1Ru+DpKwDJ/pWlNiG86ZJyuVXLi1mZVlx90YLzVt +Q== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rdvd609ec-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jun 2023 09:39:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7u0kO7lm7yl0MTUsEkmB8CP6mKSfwVDKvr2WET9DcAlxfNGsuPISMCjGmrPRrh4ePJPc8QRyhcFJIOzxcg+yzExQTkPTUuFxqZPhptJA4xAUYs9FMpIAbepkpIe0DJP6ZIDjP/gVVrNbdS2UNa6i9FB46KWiQdDdmb+x4LhawA38u2nhn4xwa796drvPku9X2KGLd5CDsTu07HNPb3gaC+rEj15/9bOrWw7e8Hx2MVOliBMvLdQVVf/3S5gSLTvAsHKroBPePkx7s8Dt2s2+NriJDOd5yoqkWQn1izvrde28/04vRzCakoeoeyTbOucp+0VxAzHLQznQsZzuGNEMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YM0K8+oAOqiDWsJILhfiX5Y1VfLZ7WYAbuHhntTtJY0=;
 b=QymDiD7geFm5wWHVLINNxV2c5KBmEpURedjLcZRJiaMUheJUj6GUl0A4oVrbLqMwUxxBUJNOKiBP6Uf+/to36FnTiv/WByLlUbG4+6KApcQMlrOHERjZnyf3wTo20hwnDlMqWE7/B4ZLMkf8RNA4hGaz5H6dH976MRmkfLZDe58mgkfEvagEPFWueCaE8uJ6URkSOT3dD3G+XZ73haENInxJZlMbIFs+AJBUaK0o7TAV28dHm/yRt+EoqgLS6Osw8hsm2evaBNPid4EeSNzBMJwMfGqE4eRtZ38seNLZo+9z8ofPWRgG1VlK6pnOWiJpYVQ+kTmjoL9b5Opzk/cHLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YM0K8+oAOqiDWsJILhfiX5Y1VfLZ7WYAbuHhntTtJY0=;
 b=Lg0m46ZBu8+z8Dr72RoU1xTRvSyh4uf+0O2AoEh9vJaxVP3iAsyuWvofgJPl5DwkvqX0jnojwYLWqPxg9Xsk/cZjYik9AtuhjB+T4d6PJtzpqkbbFbyFub9+bM5EJ6RHL0bvJXDYkpmqBhmUVPCDVsNsEmnoOWZ1sI4DSaViGgd3sXNIYNL6oB1KtgI1f+dmtxALKSiqGxhcfe0HTYAeHet88/2AplhhqJVCbPLW4cdun+CZiE31c5g3tAxayWIdUgp1p4vm9YwxFLrTYkGcGpEMZesyTh1CIH65IhshWA5hDyRL8Xz/ufgU9jMttnaE43mHfdXjVZJtqVVEnu2New==
Received: from DM6PR02MB6123.namprd02.prod.outlook.com (2603:10b6:5:1fd::20)
 by PH7PR02MB10061.namprd02.prod.outlook.com (2603:10b6:510:2ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 16:39:45 +0000
Received: from DM6PR02MB6123.namprd02.prod.outlook.com
 ([fe80::4bce:9f20:28bc:8e93]) by DM6PR02MB6123.namprd02.prod.outlook.com
 ([fe80::4bce:9f20:28bc:8e93%7]) with mapi id 15.20.6544.008; Wed, 28 Jun 2023
 16:39:45 +0000
From: Tom Lonergan <tom.lonergan@nutanix.com>
To: mst@redhat.com
Cc: raphael.norwitz@nutanix.com, qemu-devel@nongnu.org,
 yuanmh12@chinatelecom.cn, Tom Lonergan <tom.lonergan@nutanix.com>
Subject: [PATCH 2/2] vhost-user: Make RESET_DEVICE a per device message
Date: Wed, 28 Jun 2023 16:39:27 +0000
Message-Id: <20230628163927.108171-3-tom.lonergan@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230628163927.108171-1-tom.lonergan@nutanix.com>
References: <20230628163927.108171-1-tom.lonergan@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::11) To DM6PR02MB6123.namprd02.prod.outlook.com
 (2603:10b6:5:1fd::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR02MB6123:EE_|PH7PR02MB10061:EE_
X-MS-Office365-Filtering-Correlation-Id: 154811e0-295c-4ac1-d259-08db77f647be
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IPpQ7nxfr7Zu+0Rcl7af7KB5DJG92hD6rXyqS7kB++jfgJLEHN0MTO1W5hoBd+NySA0HmjhaTfN5uHUJRv2fbvJ+nGCuEY86AZoVv99lzix9e/Q7e0K44JqAt5uQMbD7EK1E3Y+FpYvF+GliRF7kZX2ut0Jp+rG0j9nwBOM2MCCasGFtwfe0kOs/yXVIpMxhYUqRzWJOIkjXrYn85JgvHuEZJu5pX8ieQy94vE2LkJIFEpE/ALJOK3p6oDegGs9dg4Uyqf5schZrv6NKcWFUDOXZbUpVQT4WAcGOZ18sT8Qm+J7THlnmrNCQAr7d9m5pKhmRjnpQU7JU23b5hxtbCWGqc2YopMEtoR8CypY3/0NntN5Km9gppCjgKUOrRF0pWq7sUILBkOtfJgS8FmoxRr2SaGZBPGG4+C4aMVRG2O2kooftdk2bE1UFj2hs6MIi4qz0CSY579/rul7eZqF6yCi2XwddlG9DRPSW7r7CjFngTbITr1jtu+uh3tzq9HN8Hev14RcFl3zX1IX4TFQjZWTYXzCKIBYu1KECwqwjbUkYNi9h6Fa2mhKM8V9YmTOWxut/99dID/mFd2HxGYjV2jNovuJHTorGR/cHakkk9YEY3q8Yl2NTyqNGXjSL3qqF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR02MB6123.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199021)(2906002)(4744005)(6486002)(6666004)(52116002)(83380400001)(38100700002)(107886003)(186003)(38350700002)(6512007)(2616005)(6506007)(1076003)(86362001)(41300700001)(478600001)(316002)(4326008)(36756003)(66476007)(66946007)(6916009)(8936002)(66556008)(26005)(44832011)(8676002)(5660300002)(15650500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DcXzOeTM/6t7FPm8NhwNw7OY8v2V5yP++CVJLGD4QsOjHG5QG0AI2ByyTFM4?=
 =?us-ascii?Q?w7fhWaGjhHgUHB3kl8/sXkOquLpxreHSKRIStDh5QqVaJ0QGqEgCseU6paeR?=
 =?us-ascii?Q?ASDHfOaNVOKtkWofPbJnnxQJQMnA3P2GsGDN5uV1rIOsFQYFA4mSvnM7OoKl?=
 =?us-ascii?Q?9CNb+Vbdo+Q26fxH+RIt/r1hmKeOH+Pzfv3G/x5K8lNL22sRWwE8U+CJsU2Q?=
 =?us-ascii?Q?vrbFg4mPEPMqS+kdb7GfxcAh0cVE6Ubk7XTRpdUC1UulrTlnFvLKn51sa8z1?=
 =?us-ascii?Q?Omt2bpRBV/AGvVeqku0HWDnDegPKkB5ZF5i/VpMF1TqmK5doBnP3pUaQPE7b?=
 =?us-ascii?Q?vsJvAEigo7dX+PcJEhl1wIBZJIYWYJ045qIk/bDXW/uPdX0IT5k4jGo8aodK?=
 =?us-ascii?Q?5pADS+3KU/a0Hoj6zuQ72Gm+eRUdV4hWH1uajbxVytOJByWNAUU8uzvXygbv?=
 =?us-ascii?Q?j0yxkUB3fDppAyudM0bZ6v403FVvkCnH4ZxkmtZ6NfEyURXg5XJtBXJvXGvt?=
 =?us-ascii?Q?Vrz+2AQELZOCNBfII17L8aIOAuvBrntMdNENj09xYYuFoNTiww1ZwC/1qFYk?=
 =?us-ascii?Q?5yA8En5OBnKg/QOpw8VLKMs92WPeMNfsiKZxIE6is6H7RNyFsfORmPP0jNx6?=
 =?us-ascii?Q?3cnGAZk/BowI91RT8BnTiCgDCY8UnRUCxNATDHg4lWhocs1MipYOeHQ4Rujp?=
 =?us-ascii?Q?meC41gJTJZnt0WbI0kOH0EcNcboD5qdohyVa+eyjJTwcL8IreEP2JZ6sxy+2?=
 =?us-ascii?Q?YxbiIK/TjTtQ76JrLv6MpKe1+a91IYPaAwLGbs8dKOCUyV7hAwvscoHsqj54?=
 =?us-ascii?Q?25Pgp8ABlfvcx19JviZlttSL8t7BhCOd7MRJZXjHzAFJjUOO4xejTYXOcpSI?=
 =?us-ascii?Q?9+LN4azgt6UzfYoqY1U9l4UtcSP02Pf0FDW6oNmftb5jnR4cc71SH2gJWsLG?=
 =?us-ascii?Q?7Q+O95YmUMmNdJ/uaxh2+K5rJK8tHLUlx2RjyUqcnQs6zcCx0HenY5+I0wwG?=
 =?us-ascii?Q?zvTH7+gGRKwWT5ICm2GbVwmNH5WCqZesOSNZOESKsfhb6ZTdVQKHMmYnyb44?=
 =?us-ascii?Q?J2ItT/liX98SE1VvzcES+EaZ3nZlK6QaH6gkqdZO5amoBrcaq2Bjy93Tq8MJ?=
 =?us-ascii?Q?aMbrBxOvvpUMrLdzdlsStp15Aa1GENh+APsXr7LRgrSGHuMaq4sV5YPlN/Vr?=
 =?us-ascii?Q?vXtraKiVJPz6mXMncl6xUfuAj0nlrtV0pluLtrfzNukap67q7/rmGafmU7Ok?=
 =?us-ascii?Q?YQ4U1XQ85N2kkM6/ahG6DppNkaea2pZMCcXq6AbhLvgGmytx7VvxMWYgJt7h?=
 =?us-ascii?Q?rFJ8XAiKpOGWsppr7MSeLNLn/wqVXKxfrR0k0jsSwd++RVtvrMGn44p7uSB9?=
 =?us-ascii?Q?XtvBE9dgC3IGYb+LvkAkIM3B2HHkucx9YHyFS9Qn5s+I7HPfUjkpHqaO+oWi?=
 =?us-ascii?Q?rwm/bqLD+YyrFDWmFTWTcOVZM86u12CKg3jS6s72oCL08jWnQ1yS5KEoA8qs?=
 =?us-ascii?Q?Wv+l3Fn0/FrAfhZJoyqBks6P49/dlJbHS+rqTfI/xeXI6hSmezRvq87tOLMP?=
 =?us-ascii?Q?87kQUxOnZ6RxOG0J3nQsDC1bJt9zY2dSCLQ6tll/GS6yBMDDZDysQdECiSOn?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154811e0-295c-4ac1-d259-08db77f647be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6123.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 16:39:45.4176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNLHGRI1uyxqcts6XjrMe3wqp17eVHlcPQ78VT0brLZSC0NRzOveI7YhQfar6D7uNByrRwLJkPnci2KP1pMPDNQjWpwlpWaBTBzEOIaq+Nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10061
X-Proofpoint-GUID: 7XEAsxBMpttnaOLqZgDS0bHmJV-W6sqx
X-Proofpoint-ORIG-GUID: 7XEAsxBMpttnaOLqZgDS0bHmJV-W6sqx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_12,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=tom.lonergan@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 28 Jun 2023 12:59:02 -0400
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

A device reset is issued per device, not per VQ. The legacy device reset
message, VHOST_USER_RESET_OWNER, is already a per device message. Therefore,
this change adds the proper message, VHOST_USER_RESET_DEVICE, to per device
messages.

Signed-off-by: Tom Lonergan <tom.lonergan@nutanix.com>
---
 hw/virtio/vhost-user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 65d6299343..8dcf049d42 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -375,6 +375,7 @@ static bool vhost_user_per_device_request(VhostUserRequest request)
     case VHOST_USER_SET_MEM_TABLE:
     case VHOST_USER_GET_QUEUE_NUM:
     case VHOST_USER_NET_SET_MTU:
+    case VHOST_USER_RESET_DEVICE:
     case VHOST_USER_ADD_MEM_REG:
     case VHOST_USER_REM_MEM_REG:
         return true;
-- 
2.22.3


