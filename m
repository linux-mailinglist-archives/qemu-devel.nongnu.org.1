Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C5E707A3E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 08:25:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzX3t-00060R-68; Thu, 18 May 2023 02:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1pzX39-0005wF-Mx
 for qemu-devel@nongnu.org; Thu, 18 May 2023 02:23:44 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1pzX36-0006oT-26
 for qemu-devel@nongnu.org; Thu, 18 May 2023 02:23:43 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34I4GUFq010641; Wed, 17 May 2023 23:23:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=proofpoint20171006;
 bh=/u1xA4rvUVOtlY/Rs9+JHilNQI1h5wn7but7Wj07YRU=;
 b=wKV231njhkgHjIIH6elrc7xpJSGyVl9ZzfleHnauvVhZ+0/iAsUNgY2BNDi0bU15W5jg
 MU47W5qi7EPYfDC+mep2NYxG1JvOPOoLzAjr7FDHI4bMmft15AwhXomBc7/xHvdUtNPZ
 Y00KiZa2T+KLNhfsw+mev50AFVGG8Am9pPwJHtNjomV7vFPkGybvOTsYYaC/VWDxFBGQ
 FyWHJKx4EQ2Ivn0PV93GhkEImMJswSZgy0gyMYwDk2SB9eZMqN0QiWrHOquyPC/iSSnZ
 bJm/KIQ+ABFsb7pRT70UgT1xH30NYzW/i03M5A28SKrbagvxJaPFrFJan3Q2QxSKKdEi WQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3qmw97sxbn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 May 2023 23:23:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUshBqt0fhTRusCYLpUKHGjWqKpkHaR24kyb08BI50txdyNY1Tfi89Y9UyuKj+CgjFc7m6CMQrTV3/pYf/jtrNkY7qIFQm0jMB6KAPYIR6ZV7DHVxcSc65yiyIrp0rWHBc0zq7Qk4TEJ3BDJkodL94R26aW1iMryMAPvo+7ke8svbhe3/kej6BFO0hYFVtCGwzycZ4EQ1VPaq1VRYX5KxmmNW1XkdiHWmS5A3ZdlfJriqSf9hLWfvX3bBjnXa5QCf/GWkACBqQoCcfbDTZftGi+ytECqjpGUWm2dPfrFCTA7lLRTY4UQBsQHjCLS6oa+ABHH4fSIMyiEGKrsykxu0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/u1xA4rvUVOtlY/Rs9+JHilNQI1h5wn7but7Wj07YRU=;
 b=jUQKWKavfScvPSfcg1EbwJ8CmNqE4mMG2i0m1C5q9msWqWiJsGZI/fQ2CvQN8Wsj9ViA44bgZk6BmZ7OWKkblyRcMdK61YQicsJlztpIxIPrtCT+74OMO98MUc37gR38Dopjp/QZA206Ne2yGG0W3sPiJTFQ5aMjWeBxjF326vPyQzWj6zONKz2yjcgbbwsma05oXyBIgP5G4Q4KfqzjXqGEKqe28fyHFKsqmXhMFxIGynedwNSk6bxapm4v5wwCF4msF0DBqmgBgEGumy7jYebSbCegkSeRZ1bMWsjl4sn4L3F3ItakmbVvF0Ww+43CIhMXCAuligbrMTuKpCOEYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/u1xA4rvUVOtlY/Rs9+JHilNQI1h5wn7but7Wj07YRU=;
 b=RheoyMLuNo9Ivmb7hpo8NhSRYeTB3l9PTZeaGWwLXKU926SrdmS0ZbwVYRc1ieOMsOtwpKKVB8ujNyZE/TmbVrZwVT8Z/MJDpeJh9GK5dZtdh3kU+DJ3qTyD3B009heRYk0yHqyGhR+/L6Ka0KF+zOSbUS8+cLhfEgSVBgH0WFMm3zAFOSI3c8c1fM113zmqAgtxy/Du05oZ0C9VuBsdXORS1qU0EqB98Laqg3INbOXsNkCi9A7bzdJUNmeNDWLYlCYlniQtvCL8WS6Jbu7HyBCbqfAZfxMrryhpoVShDUhAjPJ++vML5FxfZu3RHoq4Azi//jqB4vgJBXqw1ZR2RA==
Received: from DM6PR02MB4810.namprd02.prod.outlook.com (2603:10b6:5:fb::15) by
 CY5PR02MB8920.namprd02.prod.outlook.com (2603:10b6:930:38::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.17; Thu, 18 May 2023 06:23:34 +0000
Received: from DM6PR02MB4810.namprd02.prod.outlook.com
 ([fe80::7b0b:cd05:f137:7f12]) by DM6PR02MB4810.namprd02.prod.outlook.com
 ([fe80::7b0b:cd05:f137:7f12%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 06:23:34 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 berrange@redhat.com, shivam.kumar1@nutanix.com,
 Tejus GK <tejus.gk@nutanix.com>
Subject: [RFC v3 0/2] migration: Update error description whenever migration
 fails
Date: Thu, 18 May 2023 06:23:06 +0000
Message-Id: <20230518062308.90631-1-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::15) To DM6PR02MB4810.namprd02.prod.outlook.com
 (2603:10b6:5:fb::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR02MB4810:EE_|CY5PR02MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c872bfc-b937-4c81-9b81-08db57686847
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O8LkomTPEdNGDwIYzzgbkF6u/a8unmaeO31lZh70FXzH1hf/EluTuttReydnxfcawlBf140UJyXLB3toUdnCdMxO1Q6+ajHKKENZ+LBFO1MteD+dsPGoO/aSdz52AUhe+k5/UgadsSKEzXM6bkskNffXSqBpf/S78u7WIftQ8f1wKc1DIN3q+aU/SQ7AHAdqhwt8PFRUaxnD9ygZUN813vAvbp0ogS3TP+UyoCM4Hbd4IZudm/0Itx1aj1WG3l5FLGA82CXCBR5WyV6zO+X9VW7seoPoICakM7pA83D5AgfZjZrF29Wc7jMva8O+lS/cw9C8u6MiAA5hcXb/39Rm3mhy4hGcwXj4kDh6PQU8PVI4X+W8/yv60MDUyQW6VkXAcjdwR1i7abjaehrXyesreAKK94pvU2yegIIcAn79bJAcS3HMcQ/jufcN8XYU0A03y51xh3KYHITnPEqp9r8CQpR7wdDWQvrQGXeDWmnMr3Z26E2ulwf+K3YgdV4aj+D3eyIT6USnU9mryBNJIjVmMah7RWBfQUJdMhf7+TYS+BEPu7G/fqyxduEBZE9WrJNaZEalMsjfIR1r7tITdF1S6c9hLmbPYfy/nAzGcjz60R6OatNdtLzYTQLOTvW4FZD0CTgl4tZVZlqrsV4tU00Ipg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR02MB4810.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199021)(66556008)(316002)(6916009)(66476007)(52116002)(478600001)(4326008)(966005)(6486002)(86362001)(36756003)(83380400001)(1076003)(6512007)(6506007)(107886003)(186003)(26005)(66946007)(2616005)(8936002)(2906002)(5660300002)(8676002)(15650500001)(6666004)(38350700002)(41300700001)(38100700002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZW2maVzlf9Ke8knF3hyHkPwyxufcl+WTg1zzCz4RZBUfgt3RI7Ughr10ux7P?=
 =?us-ascii?Q?IQDK27XYVALDCKxvMXF6cetU0YZOKtgb6AOdJh+spBiOtbekaHq8I28tjPD5?=
 =?us-ascii?Q?ABn48XopJU5R+CfTHCdxWb2zeRS2lmk+QU83wl0lrK1I7n2UxRXRt/BT47m2?=
 =?us-ascii?Q?Dg6ASbP2vuTor9yyuqnGTZ76vpcTmr7GKdFO2v3xGAHh28NZiQsHkP4dypOS?=
 =?us-ascii?Q?qozBTUp0B1V8He/3QR+4QQh/gs8HpTxJdEgmPY88silaV7bxNfcCs/EwpdZd?=
 =?us-ascii?Q?MQvi1RbqCzZLoEycSNCM/NfFvjjVsSF8rUWrEhTIdnaHpSc3dfCGQsRMDQj8?=
 =?us-ascii?Q?5933Mx8bBNpZec8mjsCKlewwb+DwFUYPDs2Vo/PJafXA3nMRfp/pi41j9rwA?=
 =?us-ascii?Q?u4wzpcpLLtE6UDb6vccVLauEL7b5hKw5ID4AxWe8H9pzoBCbidG6y1m0TDb2?=
 =?us-ascii?Q?SrMLeU5XGx7Y4R0mqpdoSnE9cAHaoBrInCLNKoYW/bXcTkRTqDHZrCL+fFLJ?=
 =?us-ascii?Q?NK3LVrGqPjlLuAWyt2NSXJO6RZs2cl9KTkc+QqNqbnEkBKAXSrGaPwZajdC/?=
 =?us-ascii?Q?nBQ+n3HMbGhrK8euvO54JRvfYqCIVxbmJ1EgYYflmGVIpNyQqU6xF6l8FxIu?=
 =?us-ascii?Q?rZrmtbXnMEmLmkHaWSJRZCPfF7gYOGR3HPwuNNibzBDuFFTDrM6qnE3EkPmx?=
 =?us-ascii?Q?QbnhPaOdJrizM2CIIMRj6iDi9SnlH6jeX3u9KEaEVgPCyp7Hfyyj3RBwce4N?=
 =?us-ascii?Q?LeuGIZN96/56h7DtV4q7Zyvq+rhv1FefCTHi9Mwc/1rFi1kD7iSY86h0HqJI?=
 =?us-ascii?Q?R5pLzZO1xPqClUIPQ6efVT/PdOx7F0rP6WFPahQUp4QDv71V8moRtvxEwSMS?=
 =?us-ascii?Q?hda4yEwnnKrPT2znAvuxOCH7+V3HiALK8d6nGbonMHU1W42n1a/1Owa/n/Ue?=
 =?us-ascii?Q?vPpGEOGgrOM37tm9LWwnXtwdCSIy8+COZhRNh7vX4pylzYzTloyzi9O7jHU6?=
 =?us-ascii?Q?ZEjUnsBXT6XO9FPsqn7C5IQqAYrKfKqwyUJIVsHza089Nfk5aV5vM4FFfCWJ?=
 =?us-ascii?Q?iJF2E1rru2lV6lns5DPPCAfJ/U+kutssbAoggbpMYSjapC1qbGEXpcRCG217?=
 =?us-ascii?Q?2PIVsis1THyZUP6RnTy7i/p/VQMr+pj5G0NotXkp9gh8pD2x39Kvdm3qncXM?=
 =?us-ascii?Q?X9ZqpPfSPGpbCN+hcPqdrk7nQ6+DDsjTyguc1mX7FoqRU5RAxjxd2t1MKAgJ?=
 =?us-ascii?Q?qSC0eXQ3ysp5Hc1VFkpvXWsSHGP9aDD74h/xP09Lu2pnhqdNqoSCMPlq6m5Q?=
 =?us-ascii?Q?J7x04x7xr5lQQv8QBNH3s7yD2q6QJkcIu4jeuMAth4JwvG61+nRlP1jE6M1b?=
 =?us-ascii?Q?5BnKDDZRQEEsd3VEH9Qc5LGr1SumCvjbYzl7oGvdcpzx4+DSDJCnWOrlHi2t?=
 =?us-ascii?Q?GpZf0MWPorQsJRFmBFDMFp3eOWQfz4MSskBxddpRAPj6l3/iPOISxUO3ooSb?=
 =?us-ascii?Q?7/L5nbf0tEz5+6xRmo8ipaEiw0WLmNDBEpSwAck309AAT0AKdsiIh3ssXz/g?=
 =?us-ascii?Q?3s5Tn4WvYXzWnZCTchXyMSlb+QANAKmUHVAFkWM/?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c872bfc-b937-4c81-9b81-08db57686847
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB4810.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 06:23:34.2718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14DG48s/lBZtkptNePy8LosBplx5eaHisNjhUqyADmixTmJKEojaKlMr68xXFJ2DHcxsM7/EWTlhiwjfETxpgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8920
X-Proofpoint-GUID: Xz8I2hZemRIwxPHxNxqkqi75R6-KG4hX
X-Proofpoint-ORIG-GUID: Xz8I2hZemRIwxPHxNxqkqi75R6-KG4hX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=tejus.gk@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi everyone,

Thank you everyone for the reviews, this is the	v3 patchset based on the 
reviews	received on the	previous ones. 

Links to the previous patchsets:
v1: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg00868.html
v2: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg01943.html

I've broken this patchset into two parts; the first patch contains fixes
for places in migration.c where	the failure reason is not updated.
Compared to the	previous patchset, this	fixes a	few errors existing in  
the last patch and covers a few	more places where the failure reason 
isn't updated. 

The second patch, covers places	outside	of migration.c,	which eventually 
lead to	a migration failure, along with	an error_report() call being 
made, however without an update	for the failure	reason.	I am aware that	
the changes in vmstate.c breaks	the build due to a unit-test build 
failing, so I wanted to	know the right way to approach this. 

regards,
Tejus


Tejus GK (2):
  migration: Update error description whenever migration fails
  migration: Update error description whenever migration fails

 migration/migration.c | 23 ++++++++++++-----------
 migration/savevm.c    | 13 ++++++++++---
 migration/vmstate.c   | 13 ++++++++++---
 3 files changed, 32 insertions(+), 17 deletions(-)

-- 
2.22.3


