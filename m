Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51421804277
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 00:18:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAIBA-0002NR-3L; Mon, 04 Dec 2023 18:16:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.christie@oracle.com>)
 id 1rAIB1-0002LX-PQ
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 18:16:35 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.christie@oracle.com>)
 id 1rAIAz-0007Cj-BK
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 18:16:35 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B4MoCt4004747; Mon, 4 Dec 2023 23:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=JWoPemWX+ddCBvFFZOWOFw4Y+h7bgjS6zI46pz45x3c=;
 b=gP8b+GuZhXdYZ0JxrhCteKV/t057T9MZqZn6GawP9MbKcHKx4dFLCmJMM2Eqi9EsWWvN
 Rems3+6jbeOIcUG9D+vekA6ToN3e4nFhX1VZyYvcM1fR7cYsHJMYoxYL3wNbrbB7VhQy
 qnroMKtkgV/F05wxkiHIBGOVsfgeujFsXfIweXOTZncr7svDZQd5AT2HC0I9FbJCgeHj
 iCuv3H58eghtsCAoGEYSH+jePwhraGmTLS0CEe7DRd9q1t6QSh+XKo6Jwdg5B7oTSEyc
 QJ1wzmqTKqszffWU9whWL/xLMqlmTlifOfR7uOe2UoU7/9AB0iwoqpjhKX9n87XZXP1e uQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usqnf02bh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Dec 2023 23:16:27 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B4MIteK028635; Mon, 4 Dec 2023 23:16:26 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uqu1d18xm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Dec 2023 23:16:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCSbUjT7fX6wz/9Wqc0hhTAYwEiUmOVd3UmFa2Ml5I0uwLWj8J2zJQ7NLllVifp5DV3Ocm+NMAtREXCNM38MGPtEpV3cQXvvG4x7Eo9BbO85XmGFEkVm6hBJIGsi0wYqkLH0KmvVQ0OXkpR6oGkZ01RO8bSpa6/q5gCfvQVdc8JPHlTRfYGT0pRBT1fEHMSoR8WQE3EPrSA3XI+PXLqTSS0moicL8Oas768myKZ/k34Kg5f17ky6pHXp0jW3CymQotPYjY5ESBBF81aIhR4mDW9tTzGCEWo62jdX2uD4oWnBoFq0se+5EGQ3jsnpRGBt4ISFvJWdzTd6ZkNph4k9Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWoPemWX+ddCBvFFZOWOFw4Y+h7bgjS6zI46pz45x3c=;
 b=USBsaurFmq2bmtZk7qMfrimquyrkbDVBFdrwmUtMoUhUwTbLRpVHd7kPC5gZ1dAmbbx2mthJQYANZPkFcXxvGhpZMWJtyWi9NbwpRIqla4uNbItZ9G4AqWBRtBuSfS2ieS7wOwwdFQcRnofIkFepC5lxVgSOdCHf2N3CI36xwllzpzs/2tVWgvMMDS2m90uLLueFu/PcL6kM8tXVqK/6PV8MREmwuyPlsd3cQA1jnjphLq08OHF/+TGSp8yWHD93gc/TnesmE3kEK2Gz9eF4eSTkSInAvMBgP+wowBLUOH0x6/ARa/dubPujuAa7xmfoWRU4GeeYtHuh1R9cyTYjSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWoPemWX+ddCBvFFZOWOFw4Y+h7bgjS6zI46pz45x3c=;
 b=NCrrJTeNB98qfLqgyZeE3VQpsB3QvH6qr3tCqF7QJnjlXT443AGuoOmvF4gtGtDeOkcjQ4J/4Xz+1ZZFPo4JB/zWBn5+GvDHEsuqk+NR0XpdFqEbpTUXY42+9PFaGiwSmQdF14NOs7G/XhX4MqbQFx4/0vRmf6DmJxk6SeRXLfo=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by MN6PR10MB7466.namprd10.prod.outlook.com (2603:10b6:208:477::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 23:16:24 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 23:16:24 +0000
From: Mike Christie <michael.christie@oracle.com>
To: fam@euphon.net, stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v3 1/2] vhost: Add worker backend callouts
Date: Mon,  4 Dec 2023 17:16:17 -0600
Message-Id: <20231204231618.21962-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204231618.21962-1-michael.christie@oracle.com>
References: <20231204231618.21962-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:8:2f::15) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|MN6PR10MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: 173042d0-c949-4025-a3fa-08dbf51f0887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MxVx5TFvHqTWgPIiPc1QUA5QZQ6pjUEPzSyWJhtHYzOpfwRoUwytrp629wPK9S4kv+3w8W3qKhhtNGwIN6T98rkBXM5n3ZEzcImyEvUkQwzbUJsuEUByVLAdOllm1J9UFa2c+ofaGfpJ7ssThriGEomOVtCFEh+1oLDT38KO3Uk6xWfAomHZ/ttPscXnrxaU7dd5kGdGF8zEHpqwtzTwHD9jX+KnunzI73p7MaMZFRQCoLz+iT9Ng9b1qaaR2qYcIYGBNRzCRh6fQw+YdlBmPU8H6onMXOnfmT9QA3sS25Cr2WezMq9wpYdr9IWnUf+ah5GascxrSkfKtG4VdHIUOOZG33TkpbH/p4+SG7ZTPIx+sAYx4/vs+0Bdt3XMPAHf+Nh2+Luprr9aU1TfdkU/gV0yCXVY9MDStk/q3QUrn8pQ4zE3p/xns6TslB4Q+vmFi0Vq9N6FiF6cePdJXgiBOuLb6gDL//ZX4cPi1jUXh2/5ZUbigYW03VKkebFMCuEzrc19m16/NnPafECkk8YB3HVhNJ8olgSdXX3djh8Ux//QJnaY4AdXf4gyk+v3PTxb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(66556008)(66476007)(66946007)(4326008)(8676002)(8936002)(316002)(6486002)(478600001)(6666004)(5660300002)(36756003)(41300700001)(2906002)(86362001)(2616005)(107886003)(26005)(1076003)(38100700002)(6506007)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aWP4V8LZ60j9LQHHaMAej13SSFGQqAaKDVNK2JrXn6BrgO93lOnCHobPU6gJ?=
 =?us-ascii?Q?4ASzvp0TspmMTsWMHiSE344JV5MNm2l7cYCf/AxBcU8c3CmobfdEBu+KyFxQ?=
 =?us-ascii?Q?u9/U0tZLtFRr58qZaLTxRZmUB/C9TJIU30Qci7eG77/BwP0eQUMMKL3+OiKn?=
 =?us-ascii?Q?mqXB5bneMofPlzHSpkqIRoNBGl9sJ51QPgjQNwyYRevErA/Rk/SImfyyyWOP?=
 =?us-ascii?Q?JkgLvIK/OSxqbYDTcUTyoxksjJH7vE5JXhBCCsYAnnisqyZKMrS9PFuO5vY4?=
 =?us-ascii?Q?HFRPXviW1/goiDwP/YV5RCLnj8d/4SepyB5OHK9MZFDbZJbSlLDWd1Miyf+U?=
 =?us-ascii?Q?4MguOTxpCjnrL9ZRg/CVB+VTKqj03sw83ZeYfy2WCs96onVx6SDVEpjFqhHe?=
 =?us-ascii?Q?ul/U/bMRN5kw0xFiCUYOq1ThnzQD7GXIDeS/9dsCuKuzuQEUXAP+PjkVKFbA?=
 =?us-ascii?Q?tLx8FPnaGqfntvZ/1bEbxvZW2kuvv5Ajr/ctxt7KmH4YlhNc7hdh0Hmp9cnC?=
 =?us-ascii?Q?x5LsXtYD6q1RZTKudYkey+1xesyRbmOrmmbH5FbXMVKaFSbiHvvTUE8v/Z8I?=
 =?us-ascii?Q?bQWzmhk+gnwlnGn96Czh44PEfR34yHkknXh9WyqLWxZR3DDqU9Wzj+97hUF2?=
 =?us-ascii?Q?yJlQwf1MWUYIuRbPg2JSpN4osyGiQZTR1J1GxOFIdEH5T+Y0RMWlnl1ZzB0T?=
 =?us-ascii?Q?Vv7EzRvzRJ5eYKZ4xL3xThAZotu3zaa4rdUFiO3gzoaA1hw/L4VfMt4PvPtn?=
 =?us-ascii?Q?TBflFwtqvjh65n/oi+P4NnM28h7koyQJcYRk8nG8EdMveoF74LogpCjyGKcQ?=
 =?us-ascii?Q?wgCcrRHdakrsRGpl7lz0r4qNCb5e/UGt+/qAEz/REDadpOKkUEjtSYM6PZ2D?=
 =?us-ascii?Q?fb9pk/MN3vZH3yuJx5+qucePJI5vYCl1g/etubnAJugpMhuQMw4tOVxwGVb5?=
 =?us-ascii?Q?+T8KkUYeBPAnumHF52W/LgWP92X7uN/Ng2rEWNdgrTIuABQftvY5OBkxva5t?=
 =?us-ascii?Q?6xWbtMSIchOoFYdlQI5pNm9xdI9SxN3BYTFpBh93x1RSPRJ6afFN/QJv/wWM?=
 =?us-ascii?Q?yd1Eoa5pA9n+Qtq+T/ksIdJWq/tNV6oOb04+3GwpxLAudkF/a5Ys+NsQDf1H?=
 =?us-ascii?Q?tgSydWSYbwyYXUGSogN8l0rAq+0MwBEzHnS4PEN7EY8HGIeVkvjo9pf6tdqk?=
 =?us-ascii?Q?yD2r/5mjBZSkxyuWCQGLya5C6NzeSvJLbajWD/MqvsP5flllybEAA8+lngUz?=
 =?us-ascii?Q?5C+pTKTixrdl0DEsQEPT3nsBoPKaW1U+9WAfzFyZ7DjQIzt7TLJYUTWy7imE?=
 =?us-ascii?Q?/0iztZTrylorny1GLoq8dJXlElpgz4GMXGIcpJdUpl89ydz8CIYWfAbX55NT?=
 =?us-ascii?Q?M5M9Gl7mK+fr6eZOiMI9ip6zWp2ZrXQ05Xv7+fHK9IGmFoSGs6Iw30Re9Uz6?=
 =?us-ascii?Q?+X0O7pDdtPGBBnT/dsaOoc1iqxsByf3f6+9C8SfqluojhWSJY9q52iOQGrSl?=
 =?us-ascii?Q?VLfrGq9NW4X/wqmWG/Lt4xzcLfPrg/1OzZErSPo+ZUzomOx0MfIXtXi6ojI/?=
 =?us-ascii?Q?rdik+ubXyOvRHgwO7yMQntNTEAjMUCyXuc1cMnXmnUz4Sr3QD7T47q+v/VxZ?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2BoC9sNI7IMW3xshEXy6utVCf2P1XY37yOXAMdrRgxLDE8ILjk+M52HhQrr4/A+DZ9YoTroeEuL8MxDEdsnomH0Boxs1pM1zBft9rn/gDEvnBa/NE7SD0p14Gi4EfRDpaHiTM9gcwSOd3Cw9uvS9ZWXlcYinyGqL59SHfiFSFzR3IT2lxLqZyAfH+u/d2N2xDT9VGm4CeexSus/zHBybuk7K2i8B1m+68rYNsbEHl5dvhr2pOSOv3mqNDtzowXcn3xweIKU+sXzWzko8jlqu6gYTeryXAK0PPm56CXGTrL2FLgbnIbX6C5OUa49fVnuV2FdRHwQvJLxt0GisOkmfED4Xx6Hst3RQyIHHkUgig1ht0A5cs3xLyq29lfTGyOHOkeKHZC2oZVZPA/MJdOm1sa2pobK93AxeDmifUlDcYbjdZ4Ehl3iobrF730JDY3lFhO8bgqyrFNbUFjwoJJ2HIrVHeE9gEIm0n5/+2tQYBzZMmqyMiTh9Nd/lUO9fyoQGuxjjqPiuSKlL8jQPxJe/xXWq9yP3jagdpNeV6W9vbWpsaAIUX4tMS0evXxve84XyraaE7gGsBvov6BIa+7/jS8whWxL9pqWfF3b1PlZq9CJe5gqA5vhn/nF1ObtSBSuHINyFZCzTi2GloICgt8uDeFjxavcTRVund+fD3WvBKvGyHaNvSIACWGxTTwId4C43OIFXwwu4MYeDhTQusE5v9uR8gcSFSuR/eQpgLhjNhr65TO8+UWWix5PN3o+m4WqvZP5g3kzyGSYe+FVwVwPiuGQ14oRDxE+f29ZkbBJDnKmyPsEdH54k8yu//OHIru8y
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 173042d0-c949-4025-a3fa-08dbf51f0887
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 23:16:24.0252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7VUiDmH692U4t66Mn0xl6NKFpBW15MaMH9ygkqL2nAvI1GVmPqUFGhKx291G31RltLO/USIt9abZTy4Lw5A1irrSZ84DTvHOPRTF7U0ACrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7466
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_21,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040182
X-Proofpoint-ORIG-GUID: nDKB-0gEOB6wDXlL7UvDxGDv0k9QpLIG
X-Proofpoint-GUID: nDKB-0gEOB6wDXlL7UvDxGDv0k9QpLIG
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

This adds the vhost backend callouts for the worker ioctls added in the
6.4 linux kernel commit:

c1ecd8e95007 ("vhost: allow userspace to create workers")

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

---
 hw/virtio/vhost-backend.c         | 28 ++++++++++++++++++++++++++++
 include/hw/virtio/vhost-backend.h | 14 ++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 17f3fc6a0823..833804dd40f2 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -158,6 +158,30 @@ static int vhost_kernel_set_vring_busyloop_timeout(struct vhost_dev *dev,
     return vhost_kernel_call(dev, VHOST_SET_VRING_BUSYLOOP_TIMEOUT, s);
 }
 
+static int vhost_kernel_new_worker(struct vhost_dev *dev,
+                                   struct vhost_worker_state *worker)
+{
+    return vhost_kernel_call(dev, VHOST_NEW_WORKER, worker);
+}
+
+static int vhost_kernel_free_worker(struct vhost_dev *dev,
+                                    struct vhost_worker_state *worker)
+{
+    return vhost_kernel_call(dev, VHOST_FREE_WORKER, worker);
+}
+
+static int vhost_kernel_attach_vring_worker(struct vhost_dev *dev,
+                                            struct vhost_vring_worker *worker)
+{
+    return vhost_kernel_call(dev, VHOST_ATTACH_VRING_WORKER, worker);
+}
+
+static int vhost_kernel_get_vring_worker(struct vhost_dev *dev,
+                                         struct vhost_vring_worker *worker)
+{
+    return vhost_kernel_call(dev, VHOST_GET_VRING_WORKER, worker);
+}
+
 static int vhost_kernel_set_features(struct vhost_dev *dev,
                                      uint64_t features)
 {
@@ -313,6 +337,10 @@ const VhostOps kernel_ops = {
         .vhost_set_vring_err = vhost_kernel_set_vring_err,
         .vhost_set_vring_busyloop_timeout =
                                 vhost_kernel_set_vring_busyloop_timeout,
+        .vhost_get_vring_worker = vhost_kernel_get_vring_worker,
+        .vhost_attach_vring_worker = vhost_kernel_attach_vring_worker,
+        .vhost_new_worker = vhost_kernel_new_worker,
+        .vhost_free_worker = vhost_kernel_free_worker,
         .vhost_set_features = vhost_kernel_set_features,
         .vhost_get_features = vhost_kernel_get_features,
         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index a86d103f8245..70c2e8ffeee5 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -45,6 +45,8 @@ struct vhost_memory;
 struct vhost_vring_file;
 struct vhost_vring_state;
 struct vhost_vring_addr;
+struct vhost_vring_worker;
+struct vhost_worker_state;
 struct vhost_scsi_target;
 struct vhost_iotlb_msg;
 struct vhost_virtqueue;
@@ -85,6 +87,14 @@ typedef int (*vhost_set_vring_err_op)(struct vhost_dev *dev,
                                       struct vhost_vring_file *file);
 typedef int (*vhost_set_vring_busyloop_timeout_op)(struct vhost_dev *dev,
                                                    struct vhost_vring_state *r);
+typedef int (*vhost_attach_vring_worker_op)(struct vhost_dev *dev,
+                                            struct vhost_vring_worker *worker);
+typedef int (*vhost_get_vring_worker_op)(struct vhost_dev *dev,
+                                         struct vhost_vring_worker *worker);
+typedef int (*vhost_new_worker_op)(struct vhost_dev *dev,
+                                   struct vhost_worker_state *worker);
+typedef int (*vhost_free_worker_op)(struct vhost_dev *dev,
+                                    struct vhost_worker_state *worker);
 typedef int (*vhost_set_features_op)(struct vhost_dev *dev,
                                      uint64_t features);
 typedef int (*vhost_get_features_op)(struct vhost_dev *dev,
@@ -172,6 +182,10 @@ typedef struct VhostOps {
     vhost_set_vring_call_op vhost_set_vring_call;
     vhost_set_vring_err_op vhost_set_vring_err;
     vhost_set_vring_busyloop_timeout_op vhost_set_vring_busyloop_timeout;
+    vhost_new_worker_op vhost_new_worker;
+    vhost_free_worker_op vhost_free_worker;
+    vhost_get_vring_worker_op vhost_get_vring_worker;
+    vhost_attach_vring_worker_op vhost_attach_vring_worker;
     vhost_set_features_op vhost_set_features;
     vhost_get_features_op vhost_get_features;
     vhost_set_backend_cap_op vhost_set_backend_cap;
-- 
2.34.1


