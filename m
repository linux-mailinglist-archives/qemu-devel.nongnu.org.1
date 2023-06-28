Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B98A17416E1
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 18:59:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEYVV-0007uZ-FR; Wed, 28 Jun 2023 12:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tom.lonergan@nutanix.com>)
 id 1qEYD3-0006k5-Nr
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 12:40:01 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tom.lonergan@nutanix.com>)
 id 1qEYD0-0002I7-Ht
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 12:40:00 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35SEKA9K024880; Wed, 28 Jun 2023 09:39:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=proofpoint20171006;
 bh=ksn6oLc58OREj44VrAr2aMtyei2dCiRPrN7b+bxeJwU=;
 b=sIO/q9FYW2171kCxHtjZv3gUq1jEyi6X7jAjyKEe7NDfW5dmoxF0vi9w/+bUKYyXgLrS
 lHIn5h9A4AqaQjOYzM7+uWmnuy24VNZYwN+i92MiBvQZM/0tWLy87rhuoh5OBKPhlw8i
 aBhJ8+cBzR+SPeZdACwkpTe3UuSA0G3mK82oQnt3Mk54U8rXTYN8vq4sc7vExQ7Ed37L
 K1rTvDprzboL8JnF4wNF6WXAvbzJqZYFE7x/dxe1SQVxPmLjwWlvaYxY/LPRh/O7odfT
 deC5lY6LksFtgWhpQYV5HbO1AYDI0XeQdStes/x54CFiFVSW5v24uwDGrPQbSUHyHvCg 0A== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rdvd609ec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jun 2023 09:39:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imutzQhcjaFx2yKy/kOYSRSyPZvYvrpvOGHeHBRqKeGai6k7NOpPaUDdfpND/kuIP61Y/edNH0S5uB2bZMJcDGflkVKD2TsuVSWDsXpc/+7WhBgjMWp9NXy0BiggHkkGrdBKcFG58ulqTqZXnvI2arWK7R2/dPVD5XR/tcZpPGFFjOKURJqiyt89HHCa2NkNVb2gZ388o6oVheBIxt0vArOQUAyX3ptyusKf4hDVzSHGIuwcwtD8r4equ/qle8m2nRuido8R+i5Y8qDgDdFRk7AifrdEuUKza9PKHSc0Li7gMBjqmeAvFTYWhla4U0EGU6W9eTgvefudOPNx+5MEXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksn6oLc58OREj44VrAr2aMtyei2dCiRPrN7b+bxeJwU=;
 b=HoKJFjYSCY1RfdaR/BNfXQu9Zgc5n7Cyr4OnckK6syKyc6bhISgA2hi0H3JG7Hq6uurdmEZrpeqZ+Fm7/ynUlRQGxzPJwkX4vF63ZXD6DYD/iusJMiCOlL6eNzFJBeqFAqaob5cckkNMWdZXnj4COkGHHJqMQz2qGreXSTBez7Dmp8UMcFGbjCir5VEF9u1I4quCDcTNNud4OdUMGG4rfpxAkCKdL1CLNKJuZlMDr4rf5EKbEDYQV0NuvOnaJmxCg1DHo51my9KQzHkvgBzugzA/uy6Y7HroWzxXDxdWqeilZTq/Ut5bX8cJ7QjazZXchgp7/Cey0IxHg9CujF4fSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksn6oLc58OREj44VrAr2aMtyei2dCiRPrN7b+bxeJwU=;
 b=XX1xMeVcy+UfSeRxxpuJzxIe3GNoEYUYliQB4hT5h1PlVlypvYYIlpWDI0eOOjmprPP8/peFTB3THtOxSQU+p+HYxFb2eN5xz4ut4g2dkG7zJQeaNj44me9d1ytGUxkKkadQaHMorEURsoO+jBcy1VsWhjDMrs27aRv0Qj4C65sNZN33474JOm//0fllnN5/4pJ8l7V3tA50UadaNo5S7YMs1zUPzrIudwSCYlI56Q1bxRt9Ko9QNg5OKVfoijTv/3bgTkheNo7b0/ihr3M+LkEpxDCDN1hMq5AIIAxboLr7np9OPC+r5CXsN6hs3fUJGYyd6JxHPwPjsPyKrcehtA==
Received: from DM6PR02MB6123.namprd02.prod.outlook.com (2603:10b6:5:1fd::20)
 by PH7PR02MB10061.namprd02.prod.outlook.com (2603:10b6:510:2ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 16:39:44 +0000
Received: from DM6PR02MB6123.namprd02.prod.outlook.com
 ([fe80::4bce:9f20:28bc:8e93]) by DM6PR02MB6123.namprd02.prod.outlook.com
 ([fe80::4bce:9f20:28bc:8e93%7]) with mapi id 15.20.6544.008; Wed, 28 Jun 2023
 16:39:44 +0000
From: Tom Lonergan <tom.lonergan@nutanix.com>
To: mst@redhat.com
Cc: raphael.norwitz@nutanix.com, qemu-devel@nongnu.org,
 yuanmh12@chinatelecom.cn, Tom Lonergan <tom.lonergan@nutanix.com>
Subject: [PATCH 0/2] vhost user one time message fixes
Date: Wed, 28 Jun 2023 16:39:25 +0000
Message-Id: <20230628163927.108171-1-tom.lonergan@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::11) To DM6PR02MB6123.namprd02.prod.outlook.com
 (2603:10b6:5:1fd::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR02MB6123:EE_|PH7PR02MB10061:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bfdfa6d-761e-435f-5674-08db77f646dc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JXzosmNmPQhLiEh20/7mdP9bEL6vp0G7XMmP/OHugYZ/h2fr1DMVstDuIS2pZwma6Y7J221B2uk1X0Z5C+SgjmcIFqN28Bz8kx03Z9i30VOHcLMme1DlTsr5ZFRlETjldfMHLPmNRznOytVDk/R5flE9NeL4wYdY63fIsc0Ake4ljemrxy09W9D82LZC/QSeXGZnNFgYzlbH4mDBO/D+2/gSyUAK9l0n/WTUlhSseBQgZV2Px33GDA0fl85E+gebQuwIASez95OdttfRdEy2Fx+vWk/8rWilIsrGkuqgxiWpPJMF8Wm/oZeGFCBdtTR8ZGlnzbE7PkTz1VCNiTHq91YqODODuRdy/NnwiJqdSzlyFQazkheYPMrkZ9ADYZ8MB6MopiWBWYMM0OnBdiN14MOts+2fFVCf0MR60/wlArjFbZt9ZGMiJOhtvpRmLXeeILYYaIAHj24sSRjh7YOtbX+xrSielbthOXjsY2VKL0Kf7OIaCWOgPlXf2uiz3Ifqw+XbDCOzfxWfZSzXkNMQaxGh334S7diRSv82KWC1Xm0RCMEQOjQ/aS77PBNwelB68wyKgmFyA+jH0xBLWaLzsjhmAkKizedyv6g2/OxiVcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR02MB6123.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199021)(2906002)(4744005)(6486002)(6666004)(52116002)(83380400001)(38100700002)(107886003)(186003)(38350700002)(6512007)(2616005)(6506007)(1076003)(86362001)(966005)(41300700001)(478600001)(316002)(4326008)(36756003)(66476007)(66946007)(6916009)(8936002)(66556008)(26005)(44832011)(8676002)(5660300002)(15650500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LpTEjkku3PjtMrpgsS+qBZ2dd0QYdZmW4Mjx8UBN0UKxPPLsHbZOxeA34swn?=
 =?us-ascii?Q?0XiFoxtS9zT7PP4YmW2S6lWK8QVoDUgbBpcsqFqNx0DMpQdCQ1FKQ/xa4n9N?=
 =?us-ascii?Q?QACl1IQ6L32Q8QhkvaAgXnrPgGtO3L1vj7wcluNx8q83q+CljSDDtWaMvuWk?=
 =?us-ascii?Q?HeGchTJ0jHt3Ucq12+7n9VUyv+dp0wiKYx2BNuOTXmx82M2tRCUHwNEk7Ahk?=
 =?us-ascii?Q?gLpcukAl0Q6FvFnT/XMynEUiRq7p1EXgkrJcwNognbRMufXGyiHRFsrQJw1Z?=
 =?us-ascii?Q?bzDPDvrWvVJIn51yIFQZC97mfHE8bP9DEgwNvs2egnLVRoSiRRb4v9rxVieT?=
 =?us-ascii?Q?grRN0ycrhxkoHV4SLxTLfSA7PsLBKi8zf/PKp9MW/FXdDh6NN2KX4+pWCbuD?=
 =?us-ascii?Q?UT70Mizm0gFdjwpZ41TYUs4xi7p+7NR0cd/P5ZwDMr3585f4gTdT8A1Hel7i?=
 =?us-ascii?Q?sLAEpv3bShcOF9eOIcPTkfTCoE9aKtIsod2T5rxr/jJhxrGMpeV7oxrdyw8T?=
 =?us-ascii?Q?F04z0PaVRymRQoW8TV7GWxEsrTHh9rZpAK8RK3XwWyxm2rysJ47sUw19q5U3?=
 =?us-ascii?Q?oSP22xD2/iH4+mKaTvVsZ7d99NHHtj7BXeQlcn08vVD/Hfw31lCuYmlFHy1A?=
 =?us-ascii?Q?42W5AL4GkEugJO2Jo4VPZNsx24bZej9QPDCxheGpe+IX4+3eitqtun0upBIo?=
 =?us-ascii?Q?A9n3q1g4WiLzZlHvw+mYzqyZZaUSWhLRZkv6EOynT3yy0GslKGhAxGTRaKrm?=
 =?us-ascii?Q?/xbm9xEBf62WrDzr/7fXznbTWyCoWodgNnxgt0gmdKQd7MQgFBPp9BDmQu9N?=
 =?us-ascii?Q?drSv+MIeSGdkfJKWx0lw1uhJSuMH8sJuPH7N4aAnBpJJyMtFyE10vSY14YQV?=
 =?us-ascii?Q?q/x4+H5h7FYuKl8FZw3GQl1hI2HP3kHxAn+xePg5KWY2Wi5Lv2hkBCRvKZ3I?=
 =?us-ascii?Q?NFTpZuknD7rmNGuwCyIu+SRNUw+k1UToZr45/3oErKpNR4IaZ50CCmnuLZmf?=
 =?us-ascii?Q?nU8efV1r0X3DNCDro0ylhldLIT3brvIOPgmuRByJifK/u04zvWuTq86FRKv+?=
 =?us-ascii?Q?/kIrNXUJMm9wpRWoW5JjAo+iYISyPp2uPZaorv5pKBPRYCdJQ94MQkjfeptC?=
 =?us-ascii?Q?GP6q3jOPCRKFOtso8IGxF5BLHySq3BXUVTRh3lQ2bEBtljDfPYG6h5Qr3raQ?=
 =?us-ascii?Q?7J+BqmtOw7gXbIFPXsoLF56QpzHo9JdqaMsiTipAvFMp1cLVWOGuFOPo/0F3?=
 =?us-ascii?Q?MuPaQ0rGc5yC0FHdFPsezss9tqybP8y5V5zTezhmfd9aFe+x4Xx1qcyPGWxn?=
 =?us-ascii?Q?Ad31rJJWTPA7VPGrM3SLMjo+QYxXZekM9ky/zM25CxAX5uI9yLCszqgX7hGn?=
 =?us-ascii?Q?M8ja1DZHl3pfTGz4jnZoXvuHopBXn+vtxbXq69A/En72GU99T37lXyrpFPvy?=
 =?us-ascii?Q?zq+mW7s6KyGLwHTR5C7mpJoPCAdQH+MY13iq5G3K9Rd59AouD+MAX+PBRMkH?=
 =?us-ascii?Q?YmSIYIUwS7xZhBRM8F4szXZSnm/QYVTeU7OiQlUlK8tpeyR7MOPT+/eGQtb2?=
 =?us-ascii?Q?gb88zeH0AB4Mi+lvD6w7ggyogEbN4SMPQyL5XeP7esG3NmykvTckSKcxXPNQ?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfdfa6d-761e-435f-5674-08db77f646dc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6123.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 16:39:43.9529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxbR7tZVxlckyd3rSfVY6UiLkfr36SDWAMzNfcYxFAELXVpW/Rzr5DQJ7/Dnn5qjh5HAn10Jxv+GOJopnkcb9lNbQhxFdyom8q6cjUJtlY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10061
X-Proofpoint-GUID: 9Xa52Tgmi1yDu06ovxFH9GL7KB9vaugG
X-Proofpoint-ORIG-GUID: 9Xa52Tgmi1yDu06ovxFH9GL7KB9vaugG
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

Add a missing message to vhost_user_one_time_request, and fix naming for the
function and update the associated comment.

Patch 1:
vhost_user_one_time_request is actually catching messages that are sent once
per device, not only once for the lifetime of the machine. I've renamed the
function to match the functionality and changed the comment to reflect that
as described in [1].

Patch 2:
VHOST_USER_RESET_DEVICE is used in the same cases as VHOST_USER_RESET_OWNER,
so I've added it to per device messages.

[1] https://lore.kernel.org/qemu-devel/20230127083027-mutt-send-email-mst@kernel.org/

Tom Lonergan (2):
  vhost-user: Change one_time to per_device request
  vhost-user: Make RESET_DEVICE a per device message

 hw/virtio/vhost-user.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

-- 
2.22.3


