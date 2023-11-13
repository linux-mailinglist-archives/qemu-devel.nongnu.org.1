Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B25007EA2E2
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:33:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2bkJ-0001q8-4g; Mon, 13 Nov 2023 13:33:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2bjz-0001ll-4V
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:32:55 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2bjx-00032L-34
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:32:54 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ADHi6gD017357; Mon, 13 Nov 2023 18:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HSpnQNex17BCyLyGkxpU0HsjaY6iJSBLtINlv7tI+KY=;
 b=dyjqGebTl/Bg/lzST7F0TzHY/PDpjFgXqo4oh2TUPnWuemvYsmTbar4JUH05YeNfxw3V
 x4liB2FfRpMpeCS+Dobfd+whxeIs0enml5qcNJmAbpskt2pIgzxyy6dgZJNJ8FXHRyvz
 ISs4lI/EkpUNF1oTP06IVNFGQRrm+6yl04nMRut7+U++9dWcVf1UdYggp6oE8bXnVGv3
 KiNFCrU430JxoLBqkVJNcYn3a163pL9R0hjlJZxLVUhabno69KlvahlSW4jwPtZWnIEe
 v6wWRfGhXf6hdi+vqdRHLUsszQeXdoPRKFDEYcGqysoVqOagM3t3VRhk7Pi7vY8ivOqK ZA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2mdkj6h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 18:32:50 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3ADHMh4a013391; Mon, 13 Nov 2023 18:32:50 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uaxj0tf47-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 18:32:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+T5ZgLIOT8gXYfnQ2vrHS5Mj1H5WpqRKQa+qu7FYyOzpTpjd7wwparZMK78er9C+Iv44f6EyuEuM7TQmK0VIrUt1iE2kOyhUIpylE7bBELZhN0La5mc3HeJ8Vg8tNeWF4kDyjP/BdzdqOu/hcQwx7D9un3wrFHblIXUbBvzX3BTqBVgcI6d8YcMnG/3NHM6CC5QBo2dSUoT5KoJJOg8snGQFE57ubeE9Wt/U81JiWmWtY9ieammpXv+nWxqzKMi1hFWHa/Odfk0o40qxjE5wEAlDNvShnkrxnMFM/8NwReQ6XEQeCamsv9xgFHRYLAadVls/RSstAl5uMEorXxqEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSpnQNex17BCyLyGkxpU0HsjaY6iJSBLtINlv7tI+KY=;
 b=LDYO8NWiXVtJ07YNxg+tJrFaL4GT+Uj/o7aIkBSjV+DGQT+TtVFlsUty5KsKMHBYZl4ruh8hla/OSSxDlUqWARk39p2yWY42O96iix7oYDrX3v/WQvetIATCcESMYmWpTDCPQB1cKAxxmGmRYSYwKXVWRjKz8wZ8SazFLT/R+4Uh9VgyfyChGgPttmc4fKUBbM+hSsXy1OB7fYtU4b7E73qrjH2X6jhpXrnzN1zffIvgwq6Rg3cbGO8LR6FMC4qmMzP6YnVltAgTjqafYRoFueY8u0lFmK85tdzS3WDZsqr5l7NrrDZ28qgNsjw7cp2yXSQzkpYy3R8UP8I6fFr5sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSpnQNex17BCyLyGkxpU0HsjaY6iJSBLtINlv7tI+KY=;
 b=u6mgFdr2+TIbewP0hQia5z4e7ET+E2LMUIkGeSJJRio9AV/kGa1hzHyTVY309yR40J9ui0g96TzYtQiOFIHigRyMoLB22VlQ+jNE867YEK5MWyM/3EXc5R5XfmEChS5Fo4H6iwM/bLErbK2mSe1wK2RKSp/5FFBhSAIyQmnAmaU=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ0PR10MB4735.namprd10.prod.outlook.com (2603:10b6:a03:2d1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 18:32:48 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 18:32:48 +0000
Message-ID: <2cb60a9c-f1f9-4fcc-b119-002dab892891@oracle.com>
Date: Mon, 13 Nov 2023 13:32:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 05/11] migration: preserve suspended for bg_migration
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
 <1693333086-392798-6-git-send-email-steven.sistare@oracle.com>
 <ZO9vuqhUgaEkjPtV@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZO9vuqhUgaEkjPtV@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR20CA0007.namprd20.prod.outlook.com
 (2603:10b6:510:23c::9) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ0PR10MB4735:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b6a3b58-4b63-45c2-596e-08dbe476ef95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ymtu6bes2c23ZZY91cI74fuTUiuUHtWzX2nQyim2u2ogH9koF1IiRYYf4PxwDO4Iqxa8xqIfPIry+ALzrvKiiXXewPhJZe+ecCTrrtueH+kAdzjGGc0TJwMyHZqEy5Hmil8fkPGOfU1yCbe6ssESA+iSjFCSGqxgvDwdx6E7QuQn99ye4kRyabne7cKaO0q1B6dK53hOq2unbRw2FQrMePCJq/Ws3hq7pjOyLxXkl1Fg+CjF/MxqJ+vouoEH9qRD8tOWujwxhVoxTnW7CAbuPio7To9S7184uXz1N8ys60jluyfPiEp5QmcIDdQhJ/ibCMTjWX7UyWE8+zZ/sgsfWW8jjkXrgvVxbrj+fcYAOyrlGjAeHKG3fMrn98sTXe8GyCAX+XFlb/gllop+CmwdL4Su3g7Ad4/eioAEJ3XJaAdaxLxhq0A4pzXKlRDdjGqKb7r6E8BedePrp/xgDjJgX6vGVYekmGICxbnsdjlV8r3F2wOzdwVPEw9m+Da82/vZG8T2ZdhZq30YM0hZpiviok4HGdxz2rqmUYk0pqY+EzpINGM7n4nLF3IbwKXKdCPlIEcCZkMSAxTxrp8LbUJ8PctPadBTdoVjnVpQBUz6VHr2X6YpC7ru6/LCAmsIju18ZWNDNPKaJN/U96WTcF+dXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2906002)(15650500001)(8676002)(8936002)(4326008)(5660300002)(44832011)(83380400001)(41300700001)(31696002)(86362001)(478600001)(6486002)(6506007)(36916002)(53546011)(36756003)(26005)(31686004)(6512007)(2616005)(316002)(6916009)(38100700002)(66556008)(66946007)(54906003)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFlRMlE4NHdSQ2NWVGNYZmh5R2VsTVRpQ2xyVjRhZUxoT2JVOXd4NXBRUmZw?=
 =?utf-8?B?VTFQZHV5OTNGc0NtLytwdCtNQURlZDJkcHpaTGwzd3NWMElham9UcUZEeE5i?=
 =?utf-8?B?aC9ZbEtQc2dRVVpYVUZZRWI4MXJmeUpmNkVYU2VLc2wzaHkvN3Q0Uzlxc2hI?=
 =?utf-8?B?SU5NSGFFRmdOclJKZjRJOFZaNmV5cXBScjBhS0ZxUW9UYW50RkQ3Q210Q1Jk?=
 =?utf-8?B?cDJ0TVBCVXJqSUs3TFIwaVVPWEIyamJwbFNScEU2RGQxQ0RJaTVFMkJyYmZZ?=
 =?utf-8?B?aTJESzlTOGtCTnBiVVJwRmNWOWhYaWQxVW10OFlsbExPUmkvc09STmVsUjNw?=
 =?utf-8?B?R3J3ZEhrQi9aRkY1VW9wcFBtQ1hXVVlyQ2UxMmt6Z3FtTEJBU00rWnpLMm5j?=
 =?utf-8?B?eGdjdUFTY0szVndkdTJSVHVFTE5PbGlJd0VwdGkvb2xmcjhwWkE4SWhZTk1z?=
 =?utf-8?B?SHNuZ0pyODM1SGpYYVp4VXgyRml5R2haNlUwS2ExTTBqZHFlTzArRnRWL29u?=
 =?utf-8?B?L2MwV1ZXRkhLUUZsbTZuaDB1RW50V2pMblpad2E2bndtWVY0REx3cGJvZWJi?=
 =?utf-8?B?R1k1V0drRTRteXV2VWc4YlBIZ2pzemh0UkIxUGVIWTMwRlh6bmd5bHlXVzU0?=
 =?utf-8?B?K2t4ZnYvdU9NVG1UVGRPdVhCSEFWL1RrQVhPSTBDQ2xxN25sZG44WStDMVln?=
 =?utf-8?B?aTNBZkR6ZmlsaTNabVhmM09aMStwSSt2NjVDeXgrd0FIR3pxUENOQ3oyVlcr?=
 =?utf-8?B?RzVUdlJ3MlpvYXBtMTN1bHI1Nlo0T0Q0STRQeHkyanNJNFJ5N1A2S05uMWZO?=
 =?utf-8?B?dzhVblR0NFFCSjI2VFRzK3FGdDlLZ01JUjJxU0pNQkdReHdmVlo3eFhnZVdP?=
 =?utf-8?B?SC91RnBwZU04Z2U1Nks4b1ZTb1VsbTV1UmZqRXN0YzVicU5SMm9nMENMZy9H?=
 =?utf-8?B?bVNiMGJ2RVpmOGh4bkRzZHlCTWUxNWVoblo0dis0Yk1pNHB2NGo5Zkg0T1Jk?=
 =?utf-8?B?aHVXekV2M01KRm5JZmJjRGhCYWs3R0IzNnlSUjA2R2ZWdE5lUzU0VmpaWXpP?=
 =?utf-8?B?KzhPcGNWVDQyV2Y0REpxWUdKMjNXZHZxbW10TTE4aGRQQy9FVG50d0dYOTUy?=
 =?utf-8?B?MTRudkpST3BsSnlvc0Y5Nm4vU1ovQ2dKV29GazU1ZXR4aHJEK0xXcFhoY3Ev?=
 =?utf-8?B?bUZrSE8vd0JSbWR4Ty82bUVFS25OL2pVaEZNajd6T2MwZlUxa1hDNW9COVZB?=
 =?utf-8?B?OXZFV0IrcGdadE0vVnRoSU5hMHROR2JDVGIwdGd6ZEhPOENadC95b2dlTnN4?=
 =?utf-8?B?cmdOeEtCb20zM0FtN1dKRDhOQW9ib1V1SFpDVS92OE9hd3VscXU2c1VnZnY4?=
 =?utf-8?B?dmVKMHkvcnBpM1REZjNJd2pKQnB6NUVNc3kxTHJMM0pPVXNZaVlFaDg5OE8r?=
 =?utf-8?B?R2NXcklqL3R3bzUzQzFVcW9VT3JrTVlXU1JGVzJEdXpUd0lZVDl6RE0wNFA3?=
 =?utf-8?B?S0U0UnRZZFUyZ2VHaE5ZS2ZpMDgvak9tczNMN0JlYktZRTN5dWZFUjQ0djU1?=
 =?utf-8?B?RXNGQUoxTmgzVnhEeGhnWXNjdUx3ZTNvcTl2UTJWZi9VN3Nncyt2dTJxQng2?=
 =?utf-8?B?QmZwYnBna3Y3K2RxQkx6L2crelpCSmJVc1Q2emxVcHNhQ0lrWDllTWJyc0da?=
 =?utf-8?B?SlBhbzNhZys1Mm1iSk5ya01aTkx2SWpCaVRzQjBiY0VkYjBrdmV1Q0tUOEN6?=
 =?utf-8?B?OTc3MVJtQXVVbWFjUmZNa1VOeGdmcW9sQUFxTGJNWUpydXQyMkN0alNuZ2ZR?=
 =?utf-8?B?VG1aQjNnaEdFSENwVStKSG5HLy9lNTlPdGxoSHlZTVovRk4vQmJBNkZ4dmo5?=
 =?utf-8?B?NmdNNk80bG5mdUVHTWNuMWpHZzgvRC9zdExoNHFsZW1Hemd3TFAyUUVZUGh4?=
 =?utf-8?B?NllhQUZkdk5uQm85QVFXN3pxVjJzQTZ2bzBGOWg4UGcyWmRXVkdicjZ2R1JT?=
 =?utf-8?B?M1pjWHdualhsdjdvR0tETnhCQmtlb0Zvd0lSQTQ1VHVTbU44Y1o3b245N0p3?=
 =?utf-8?B?UHJ1VHc3L1JWVzV2ZXVyNEJ3WUV2RFhSRXQ1bXJkVFRoSWxXeVNQL1BRMFh3?=
 =?utf-8?B?S1dLNEwyQnBnSmk2ZXNvTGpQR213YTZ6MDZRa1d6T05maTlmcmg4SDVkQkZ4?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fUALTn0SIkCkTf8PyK6Rjz/KGaN0LtxL/fdqQi12l5WREkn3ZeqWjOrFcAr3iKENKzxLTrnt+sKICwoJ4Bpj5b6cyXJM8X758gtt6NTUpmeusMji7ZWDlaQqCD0XiXfofOMqj1qwPzvYvgniB6/wpufXsbul+8aPTFnzis87SBH0WsOa+lV9SqrSCbdH57DgE0Ti0fsr46nIBxrpSmvxAsz6auuY16jcNEMON+deBJPRDGWrCmpGp0HRf03msw4rpwU0x5MHlJ/7VsHzZlit5SFAZV+MEklmZTnM7EHcXx9qDsmQqQITWZH/5atieeoVN01sgd+GT/zbz36vvNGgbWdSu0xOLIQW/5HhEOo7czHlhTc7F7kFh7Q3ONdbeTG3rXaaRg9IxTMtK/l5tiRt6QRD1mvFj0gjjihz539oMMN0uufZ6cJ73a3LiEajI7mFgQyhZooub5EB5S8+UH0ld3F8RxLlmGLfBRVcOSyDXA0QyS5E7R1hIJrgxeZcwyHEL2qn/56rtNW+TqlE0VnU3AMdLJem4Sfi8Ls4RNLn97gbKr581CdkVA8TnuCPx6XzWQy3TNDJUkjJVzNVfjbuAlzdWnhRD5DuY83GG8/7tHIUyzVwjYjBDnX6oNZfjLa2+v8Rs81vYz+9368cC3zj3UzfqyNdwvYwWACsBEzChibxTH0/xaIJ3en2Wlv3tQSPJ1pNCUrO6WvH8pbJra98SfzPyyIJhX/VAVjvRj8QU2NnHQzhaRIT2QhCg1uyDzIBU+g9BcqicG/R4N47XK5lQA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6a3b58-4b63-45c2-596e-08dbe476ef95
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 18:32:48.1152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /YdRoQ+MOHKwNUd9qlJqe8w9EVPTnO078rd2QNdM9fDYcC5+FqbA5S/cZSx+CHGwtx1FzwvaeCgh4LIfStWH96Uj5b30KsEy6TkKICyNN5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_09,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311130151
X-Proofpoint-GUID: Ed3KM3OpQCFZaMAvwpS4UCKlj5tMmsCd
X-Proofpoint-ORIG-GUID: Ed3KM3OpQCFZaMAvwpS4UCKlj5tMmsCd
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 8/30/2023 12:35 PM, Peter Xu wrote:
> On Tue, Aug 29, 2023 at 11:18:00AM -0700, Steve Sistare wrote:
>> Do not wake a suspended guest during bg_migration.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  migration/migration.c | 12 +++++-------
>>  softmmu/runstate.c    |  1 +
>>  2 files changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index a9ecb66..303d5a6 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -3064,7 +3064,9 @@ static void bg_migration_vm_start_bh(void *opaque)
>>      qemu_bh_delete(s->vm_start_bh);
>>      s->vm_start_bh = NULL;
>>  
>> -    vm_start();
>> +    if (!runstate_check(RUN_STATE_SUSPENDED)) {
>> +        vm_start();
>> +    }
>>      s->downtime = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - s->downtime_start;
>>  }
>>  
>> @@ -3134,16 +3136,12 @@ static void *bg_migration_thread(void *opaque)
>>  
>>      qemu_mutex_lock_iothread();
>>  
>> -    /*
>> -     * If VM is currently in suspended state, then, to make a valid runstate
>> -     * transition in vm_stop_force_state() we need to wakeup it up.
>> -     */
>> -    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
>>      s->vm_old_state = runstate_get();
>>  
>>      global_state_store();
>>      /* Forcibly stop VM before saving state of vCPUs and devices */
>> -    if (vm_stop_force_state(RUN_STATE_PAUSED)) {
>> +    if (!runstate_check(RUN_STATE_SUSPENDED) &&
>> +        vm_stop_force_state(RUN_STATE_PAUSED)) {
> 
> IIUC we need the vm_stop even for SUSPENDED?  I think we need to make sure
> all backends are stopped before we start wr-protect the guest pages, so
> when wr-protect happens the guest pages should be in a consistent state.

Agreed, I stop everything for suspended in V5.

> I'd think it proper to juse reuse the helper you introduced in the previous
> patches, but maybe you have a reason to not do so (I didn't see it
> mentioned anywhere, though)?

This code is outgoing. The helper applies to the incoming side.

- Steve

>>          goto fail;
>>      }
>>      /*
>> diff --git a/softmmu/runstate.c b/softmmu/runstate.c
>> index 21d7407..4417527 100644
>> --- a/softmmu/runstate.c
>> +++ b/softmmu/runstate.c
>> @@ -163,6 +163,7 @@ static const RunStateTransition runstate_transitions_def[] = {
>>      { RUN_STATE_SUSPENDED, RUN_STATE_FINISH_MIGRATE },
>>      { RUN_STATE_SUSPENDED, RUN_STATE_PRELAUNCH },
>>      { RUN_STATE_SUSPENDED, RUN_STATE_COLO},
>> +    { RUN_STATE_SUSPENDED, RUN_STATE_PAUSED },
>>  
>>      { RUN_STATE_WATCHDOG, RUN_STATE_RUNNING },
>>      { RUN_STATE_WATCHDOG, RUN_STATE_FINISH_MIGRATE },
>> -- 
>> 1.8.3.1
>>
> 

