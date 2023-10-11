Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0D57C5B87
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 20:45:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqeC6-0006d5-6z; Wed, 11 Oct 2023 14:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qqeBo-0006Yo-8a
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 14:44:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qqeBm-0003AU-BM
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 14:44:11 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39BI2nVs006808; Wed, 11 Oct 2023 18:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=VXtfji9+wKfPCsZabGm9pEcVXGh995dIv5q6YZ9ERws=;
 b=hhaFW4qDOonbvLDzn6rz9TKPfeOpTqmbn/tK3l7yEq0gTGkoCU1Hs3bfgeT1QJ8u7kTM
 hxKxhLLLp7ezWdUKocakSxzA2YzSaTlzxYSv2R4G/lUawwqiZokWO2fPnzvAR7rN4CCt
 +JxaKzhSWKkJpvKV1qQ4FhDwmLpeRIxhehsdUk/KWaXRWnL56nedQYLf2lHjM8IYN80K
 xyoGRQF2SaFqUWR9D3L8O3jvrc+fgd19rhoTLxOTKKpEBYxJ3tF8wpV2lLdlp8lgMzC+
 jk5yqlFef5X3LYcpJNevm+6UJItiSajc8YlIVUszZIJ7wWjBdC1CQP/xdmg9QQWL0oRa Vg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjxxu91b6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Oct 2023 18:44:08 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39BIIcbm018135; Wed, 11 Oct 2023 18:44:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tjwsesxjk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Oct 2023 18:44:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbM7+Nfu3kqRq7HPDN+C+On7wvRTxa2g6+t5oRc3eggsiOZNF5PjuSQOrw/nmKfwJeLmMuwNW+3lc3lyulRvdZDcdZ9tFbEJkJ3YqAS2e/x6vUMnDogO4Abt9T+uzUfx8FiCBomtMvv2q4TGgATstLuJ8cvaFDeZ1i3KQRNriDWivSASdQ3BrEYwIN1jmToP5ZRkADZiYxZpC6XMquoOEly2hmRN/iH5ZuxM0NQB+KszmGIn79eSzYrhP3SwuERDdEbKcMWqO/Qp8u1a2OJE9AdyCwpGhUyyuWOemai9OtQmILVbghnZK4rXdqeEQXo1NSjBAndUWC/iA2+IPa7HVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXtfji9+wKfPCsZabGm9pEcVXGh995dIv5q6YZ9ERws=;
 b=mUO02L27gPNOuhEgrEA3t7ZbjbR723yZik01oYc1kFHacAejjMQqZtlM49q6CcpncCzTyW+t4VQai8SV++s8ozRjQcKLGhDFfxt9iWdJ0EPuHMS+qVanNyl0x+CPXg0UbMJYiOEKgVk7rZgHOHjmKbdrSG/LwKNKEqhVJhK8hS6xoeK0LtkAU/S2aM/3QZ4Q2dQ/j/PXbtwOkm602QMjLHSSYr2Ux1HfCeQ4n2KGB7z4yWtiKlc8THguNUbk++TdAzpIc3IRNiHvP/SvPmf9qgylgP1s951uYx9LjdBW4NaZPdYsaCNBNw8UxVgQIFXCezsoLB85B3LRGB4AbgFOCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXtfji9+wKfPCsZabGm9pEcVXGh995dIv5q6YZ9ERws=;
 b=gZ0TUO4Y0q7N/kjQ/w/55Pz8H0pBvRD9sYFkyKkprlDZmgV7zNPALvKR8ca7owaYsBBzZmkEyMW0OKI97FajSUxNHRX1pUwS2HAfyaZa690W+x4prHD/TTEkOvZyoGr9OPFBt5D84et3bZTMcYS/c//CUvz13T5AlsfI/y3EMIc=
Received: from BYAPR10MB2869.namprd10.prod.outlook.com (2603:10b6:a03:85::17)
 by PH7PR10MB7056.namprd10.prod.outlook.com (2603:10b6:510:275::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Wed, 11 Oct
 2023 18:44:05 +0000
Received: from BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798]) by BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798%4]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 18:44:05 +0000
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: 
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de,
 leobras@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] multifd: fix counters in multifd_send_thread
Date: Wed, 11 Oct 2023 11:43:57 -0700
Message-Id: <20231011184358.97349-4-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011184358.97349-1-elena.ufimtseva@oracle.com>
References: <20231011184358.97349-1-elena.ufimtseva@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::15) To BYAPR10MB2869.namprd10.prod.outlook.com
 (2603:10b6:a03:85::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2869:EE_|PH7PR10MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b2f3b3-bc47-496a-dfaf-08dbca8a0bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BQPm5f4Eg5qESYlApe8YKriymiEqyX0DDqJBeAhx7wFHLhNUdlBgWaMK+JaasXQ9543WiGl4RS8/KGEYdYBtvlMHEUf+U8zF0z3hFO0xY+MnT6989moDrx+a6hGomoSIfO5trJwJSoPOIi23wAiWGbD8DV+G39eKX1mwPh6oIB9/Y46wp8ErPAc49yRzCst3/xdhpw3MMBu1d6CHBSPeJK/xU3hrGXtdjDzTF8GvQplrByyZOO5vC2TWA0ZUDcfUsh+UfhKDeWwYv914iCD1BGBUHl6usFoxSWnn/1R4ZKCsoVOjt4RG7jvAkb8bBrUKQvRrAGeDyCuw6Yfif57EcS6S83LSn52wcB6ejdYmMJ8U8T8OPERB7LmRuqmUfxgIr3NLXIXfuY1/2/BxibikfD2KT6cysZJCCocPj+DfuCMbENdu/3GKl7luuUcXAfbW9PfR+Q7o0AF+QJihts/i9pVr/uBOcDgfmRASsUedVHUoXTkj1oCLsfqJIG5FPHyQ5JLJBfr1KQLOvUBku2JgcH9fVCfFbS7U7UOZeoqDc2zzQmvw34OtMuVkZfdTJ3taUwcfIG4FBmULpqsc+2AaTjBriRf2rNWWS/cHFAs2a9Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2869.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(109986022)(451199024)(1800799009)(64100799003)(186009)(4326008)(6666004)(1076003)(8676002)(6512007)(38100700002)(36756003)(86362001)(8936002)(2616005)(6486002)(6506007)(83380400001)(66946007)(478600001)(2906002)(41300700001)(5660300002)(316002)(66476007)(66556008)(44832011)(266003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GFmdxe1GgngF7t+zm0vlWo1yEsoMYbBdxeWxAkETEIuNmYYI6O4swYD2NCiD?=
 =?us-ascii?Q?dTMInvQX9CXzCcQD9ZoSfPQCE830RMIDf3JdL3uLqI0yvbwbrnB0YMZe/3Tl?=
 =?us-ascii?Q?1UlyTtlAYpigCOX4K9mWXmYgQyb3RtcS68HF5mGS6+XoiNeNZQE5iTBhtghZ?=
 =?us-ascii?Q?YZHrso38ywWY3vLQtfMxtdswmyps/mEuRbTs+OMj8gWldpjIC6B5J7UIKEds?=
 =?us-ascii?Q?gq5NnUyurB0g89BgslQ5GKlaNVLr8wrdakzzmGk1dPFe7QEIMHihvxCFyRlW?=
 =?us-ascii?Q?I/Iep5LHbt2uA15wwEDgpjhoyUhhofI3YrH+2cMD+slmeVMbufZZvRMc5iDD?=
 =?us-ascii?Q?FNWooivYj0YuBbw23E8tNEIkMNAsPzpNwqotZnXaLMbDBEZZIaxa3ltsxeXW?=
 =?us-ascii?Q?GlRoVWWaFdjVuaEBedZUXpuc4HkH7Va+uzBrD3Eenl8JU60/1ouKapr2+xan?=
 =?us-ascii?Q?yD44nM+B8lJ9C9v3am1Ug76S9T9Ps9N5w+QrTfvV2dsBDFWjRwcJkGEXKCMk?=
 =?us-ascii?Q?Q1GHnJPibfP041VSELruGCphmDYTzaSDyOjpOfRqZI5kpAp0nUht/7RCSrZ7?=
 =?us-ascii?Q?ctSTQF6NJ0gj4HCwo1kMKsHhpvL2lMN58/7YXVhq7vrPYMzUjnlcjQFc/q+a?=
 =?us-ascii?Q?zVBbLRVBaWbj349l0+QnLGq3vUYkBdmJfTKuFCFkCPJAu+lyvioaM1OIXeU9?=
 =?us-ascii?Q?II283yv5U1+fwWIeVvugIODvmCiKf+JWO4l/cWwuTHZKH8TGvvvDrgzYREmf?=
 =?us-ascii?Q?g5uyq5aHBoj98egM5dZRKn9dSFPltGgUbm+SuLCDySjY1I1ZBQigLvfmD3Jf?=
 =?us-ascii?Q?2FbAPzQU0ytaSKEINmYTjuX8YZlK+Uj3YkKxMjRB4devLXv19V91ksHMNXei?=
 =?us-ascii?Q?XdSpNM8SCgY5M415OiOCdfulyo2U+5Eid4dh3nvJtP9FS7L1Qk62BmoKq/yo?=
 =?us-ascii?Q?giZvyeDWnK+MDtg1Zglb7JRppBNtdgG+9NlGsd/sZSQfVEdhLFCp0k5ir9fe?=
 =?us-ascii?Q?0DlZqr8D9GiuCco3zC6yBfw4PtL3F+wZSB9rf1RtzAkXvws84Oo68bq3yRq0?=
 =?us-ascii?Q?Zcr+1D1ScVy5Q6I3fvV6lgUDsi6NpJeFEbdIA9xXFnh5aqrMgm5+YXhPHUK0?=
 =?us-ascii?Q?Pxl+WFSY0uHlplhS2gK/oQVnpKjCtkS5iGcw1tOqN4VJhycti1MOrXr6VDBp?=
 =?us-ascii?Q?HNZ31Og4HZgYG8ZVA+43EcseNVy3jXT6nO4Q+a84Pyf+XNomNEVaXFK59dDA?=
 =?us-ascii?Q?W+7/W/i9lKk8W+/kKvVDpMa+ReIqoYCNOA1qQHp5YlTgxi73K426yFrNSPyK?=
 =?us-ascii?Q?YNX75QDce7Got/7HRS+MeX0ivFB/VBB7P/0q/kad4v7OXib8xvYwHB7ad+sY?=
 =?us-ascii?Q?3tBykQwXPyDvu/Hh2wsFKFI0Z4lbntECEyFvOnux8tfAPV6vs5bvuUVA/2xS?=
 =?us-ascii?Q?gyryl6EvU0OfdiDx+gvSTIaPRcWQQlLkB6EggxNq/9nlSgDiRPAxy8M3HIYJ?=
 =?us-ascii?Q?Z51ddPRl2tIR2cRDsL687h3Xq2njaHLBYzvGicUuIur8H6Ufflu2ZxMvQ+m+?=
 =?us-ascii?Q?4ucyY4MQR5NPCmiVoVFd5jrT4pqK4X5G0+9FOfU1cUwTFK/RZiIT3VvmSms7?=
 =?us-ascii?Q?TB1dbJPTf70MNlR1AJeR4icU7R6lqokpoQzZDXMDLPWnwvmtTQHM2jwxzrm9?=
 =?us-ascii?Q?eFak0w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: u7vxWSUztG0Pd4L36iR4K1/LgrsjptPaBpuoTftPH5vATnnu6ROO/O+BAqzZ1sfOc0ZZlk4USu2SJDzeXRzlNoPk9R3XgF3PVBWjeRAxS7G60EoAV4vm155dqJkEYj4524NNEE4EWsPziOLCjPeQ4UVxNLkzQ3qcgUa0XVZr1T3Nxr4f6QAgNs94MDO/K7C4d+tuoOdwuoY3XTzJ0FJ7KZltrz30V5AeNPoR1OyXYEyWHBo2n7Mab4+uD9blS3vTua24sMFj8jb0zT041SCxCS1CwTu+/kVic30I+ZaHGkhS/7n2PP6RJfXdhU/6lGGCq//bhJ6zksBbIl4d2oGl7CHvNKCEUPbLL8B0OJPgiqzgr6h2vwC979PcOxmCVsy6C7Dv+QgTHSkYqqogDdm8Wkfwik8nJDp5idbyHZrdTTWbeoQnN2nD4dk1Usahwm28n267AYbI919HW3CljnwBkPxMTRldPmwosq+i8Z/OG5rAFqqx/EoZtp67mXLgzYclY5nHwadjaBOWRkGeJFiCVj2pi8uwOK+4HoTdetJnknx+MTbSUj2zKcD3UFUHRiFFrtYuclGtaT1YH1hH2UGtZjPn0+vv84CPlAWKbJ67rOjhuHh3Gw/DNom5hPVxmrSCisPB1D8u3JHk5bWLv2g+XspmCeuJHRwn9ooB/NjZ8yLl4J2R7SBztRHvg8gqNEb+BCDnKKmIxouczmAbHZtcN3EerWhGtMzO4oaCcQr7fymrR8OsaMmH00avhSamfYunajyM2mBBqKw+rSfHFMzESazsnsZ2L4wEB9aZIlb9jKQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b2f3b3-bc47-496a-dfaf-08dbca8a0bcf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2869.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 18:44:05.7439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymCu4bDIvlwui3P3yQTc8kudwPAyi813n+fl0GNM/rbYymVqTvxRHlEAu75C/LIPzEQ9N9XaTdYDPV06Rhc3nM4mv2Ryrhb+k55E+pXQbp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_13,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110166
X-Proofpoint-GUID: Xirff4Ci1W22XPNt7tyzGTKaNNJHRW38
X-Proofpoint-ORIG-GUID: Xirff4Ci1W22XPNt7tyzGTKaNNJHRW38
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=elena.ufimtseva@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Previous commit cbec7eb76879d419e7dbf531ee2506ec0722e825
"migration/multifd: Compute transferred bytes correctly"
removed accounting for packet_len in non-rdma
case, but the next_packet_size only accounts for pages, not for
the header packet (normal_pages * PAGE_SIZE) that is being sent
as iov[0]. The packet_len part should be added to account for
the size of MultiFDPacket and the array of the offsets.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 0f6b203877..e6e0013c16 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -714,8 +714,6 @@ static void *multifd_send_thread(void *opaque)
                 if (ret != 0) {
                     break;
                 }
-                stat64_add(&mig_stats.multifd_bytes, p->packet_len);
-                stat64_add(&mig_stats.transferred, p->packet_len);
             } else {
                 /* Send header using the same writev call */
                 p->iov[0].iov_len = p->packet_len;
@@ -728,8 +726,10 @@ static void *multifd_send_thread(void *opaque)
                 break;
             }
 
-            stat64_add(&mig_stats.multifd_bytes, p->next_packet_size);
-            stat64_add(&mig_stats.transferred, p->next_packet_size);
+            stat64_add(&mig_stats.multifd_bytes,
+                       p->next_packet_size + p->packet_len);
+            stat64_add(&mig_stats.transferred,
+                       p->next_packet_size + p->packet_len);
             qemu_mutex_lock(&p->mutex);
             p->pending_job--;
             qemu_mutex_unlock(&p->mutex);
-- 
2.34.1


