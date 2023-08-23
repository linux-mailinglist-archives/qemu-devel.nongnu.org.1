Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F657859F3
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 16:01:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYoPe-0002Ma-37; Wed, 23 Aug 2023 10:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1qYoPY-0002KP-6f
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:00:40 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1qYoPV-0005dU-8y
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:00:39 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37NCG9Ze004250; Wed, 23 Aug 2023 07:00:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 date:from:to:cc:subject:message-id:references:content-type
 :in-reply-to:mime-version; s=proofpoint20171006; bh=sIM9z5SQxW9n
 doYMGQn3ijBFMaGLjX0sm5XH2jUGm1w=; b=VxyikFn0D9KCbQeQQhbAP3hsC8aT
 s43QxPyWhYui5JKlLGmDTIKLfnLmsGWWkPbYvwiAALzPQXgUK+0R/bx47WLCbsTK
 NnpmwC6GzqjObjiLWQEERo6bt7F2BH9Fw8nJw7fLuPeyf9eekL2XNtmhwIS6DPjQ
 ZINJLyAVs9NK8PlI1VL2LkRCLpHzuxYfVvFgV2OagiMApNNH9AxYSgO1sclZ3HVl
 aFDrdO6/sTmh+jqu2j3QayxCoe3XhT0KZOUXhD+VdVn9SBrNa9nGh59L5Swd9kAT
 aSqeWAqvAQUU2kK9VJF6Fp3FyFco/voREiHsFgtlBHGrK4MI7htqUkydSg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3sn213sthb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Aug 2023 07:00:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9olTfpLTEkhHVAKW1IJ/9Sj9NrGEkEa/jcSIr7WdeXFNnsix8/LKsQOGt23cWXRPGm+jix7fA1FjSn5wmJkZKpLzbP7AkXtm94wAaoVhP8aDPlAmD7BsrQz4Unv1x6/2PPkDf2nGHDx2ZO97uhEmU1dCoU4TG2q7UwAeqVAI9JFlqltHWhMQofLmCnGiq3yfGxZtVASbeLZS4UnULNHk7bb9B0ceMQpGuWRImxHGm9vQBTy4Shou770fCIr43Gq1SK45vSvXj+3sug/RafnY/v1BPs0r0YzVH1vhNtnZ3EDGKJnqJZVLoOvjrtk++RvZY5dcrKY5SEinGQLIuwBQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIM9z5SQxW9ndoYMGQn3ijBFMaGLjX0sm5XH2jUGm1w=;
 b=jPreaPcjRgcKJfJUtifma932ZtPfV2rXZYrxpFgpZLknW8HPdA3D4h0kVhyH/r2COYtImRFUeZWEGQM0Lm4VCOqa8bLB9kmUTighYsDM+HKh08JGpDgMAteqv8fDCejTTD0L4mfArrE/jyMq/bqdJSUG7Ipome56a4BoBycEJbp3cBPw00ff2fxUhPZVYiSX4LeQPf4LXq32qxKOgJh1MDQvsnxU4ynGvdvrmzDHcqGabsLDmtyGePETrAl8ngFjumXIfUP61PpY+cNv9SfvxjvqKY2kZsvrtoZIHPNgAekXVcr35tqrGXWIxu/+LKFyrWsK97cCvfE0bf6TjomyfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIM9z5SQxW9ndoYMGQn3ijBFMaGLjX0sm5XH2jUGm1w=;
 b=fZovxNTvJwO6XCPaPUtwZp5PeDH28nCcLrkEAjugdPECnUlySwMFjsQLAhK5LOxWXDqtjiPsri/c334nm1tkjGvLXki4u44EiJZG6nsUl/ADXsYHvCHP9s8teoOr16XUNoY1g/r5Rz0tlsx/e63BLP6mHvMPuYZIQDy7AYjMzrs+kskskJGA5LxoHhNfvN27DqsR+85o1kgFR9tBK8m3HlXCvj+DFpkA4BCrwK+0g3UaQBaTdmaYUgHJZqvQKIxM0qM8hD21uZNflEkW+itnhKrmU2rcsQMRtFBJEsBVNOIE5HzkoabAMb5Y4rX8ibjwdZXG568KHfbeLfWeNyiUGg==
Received: from BY5PR02MB6115.namprd02.prod.outlook.com (2603:10b6:a03:1b2::26)
 by CH2PR02MB6792.namprd02.prod.outlook.com (2603:10b6:610:7f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 14:00:23 +0000
Received: from BY5PR02MB6115.namprd02.prod.outlook.com
 ([fe80::3622:d9f7:7978:c54e]) by BY5PR02MB6115.namprd02.prod.outlook.com
 ([fe80::3622:d9f7:7978:c54e%3]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 14:00:23 +0000
Date: Wed, 23 Aug 2023 15:00:17 +0100
From: John Levon <john.levon@nutanix.com>
To: William Henderson <william.henderson@nutanix.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, philmd@linaro.org, stefanha@gmail.com,
 thanos.makatos@nutanix.com
Subject: Re: [RFC PATCH v2 1/1] vfio-user: add live migration to vfio-user
 protocol specification
Message-ID: <ZOYQ8TuJKCRnSpeR@movementarian.org>
References: <20230823100400.152847-1-william.henderson@nutanix.com>
 <20230823100400.152847-2-william.henderson@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823100400.152847-2-william.henderson@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO6P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::8) To BY5PR02MB6115.namprd02.prod.outlook.com
 (2603:10b6:a03:1b2::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR02MB6115:EE_|CH2PR02MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e45629c-57b6-4814-26ec-08dba3e14b11
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nVLeA75kTap8HX27EJxfSos0+aoUCr3yjmCRdIZxPyblPgfIzecTz3ikB94zWOyTxCsM6mQTGOtauW/BtJeaE9SuDqbkvGpH1gyAhTlWkTAQ98sEn/O/IffItd+OzFDMb9Biag+fSr/EMokX+eosYxXqb4UV6GHDNkaCgnHrQU1bn66STfWpjuQGNaIkZvPsAaat/D5mDtd6vl5+pfLDUayKc6OsYmlUOZOQdIIacsejtTQAjYhvtaSLSeHKyS7AE15gmq0OR9z+G+oFTUet9PrAPkizxGubKM20RrSAaJrZe7NoI23d2g5B8AMpf0eAfQYEPwZs0zpE/+L/38NUYlu/KX1l3WN268XUZbPy5hdA/HrPysHAsmwnffOSkdovpX3bbL+ZOpAtXztzTOYWx1fpDW5oIa5Ak4Q8pql9KngXjvlpK+YumBrpSgqlm5lJw5DV6kgOWN8/N0hSNLd5lBrwssmmU3U5fv2VfYd81QGOUFESo/BgbaUZrYg4G3N8Exo3wkg85hTn253WxZZVsimdW1TpfaGqGA0HGB53hcc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6115.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(1800799009)(451199024)(186009)(6862004)(8936002)(8676002)(478600001)(38100700002)(41300700001)(107886003)(316002)(26005)(83380400001)(4326008)(66556008)(66476007)(66946007)(6636002)(6486002)(5660300002)(6666004)(36756003)(44832011)(2906002)(9686003)(966005)(4744005)(6512007)(86362001)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BF2sphIRkhFand1MOYrNpsyL/19tXD32pfqDnJgCFy367QqngjeQJMBzjgFz?=
 =?us-ascii?Q?bJJwWSC6v4sZxh8lWUjcR5VQhTWX06G97rhJnyRgSMlgzpaSudef3lcn/Gnc?=
 =?us-ascii?Q?LdmbeYBioeBgPKpJcD5wlm12e6IxEyUK25dHnaLbyiLj6pBYtzKhW3a/x5p4?=
 =?us-ascii?Q?45Y43cwl4n062ZLB2XoFP3mHIfbdPhP9oX3aOSjYCNm/aEvTi0CEWk0v+8Lf?=
 =?us-ascii?Q?26ly02WPp2UzwOkEXoYibyObjk4vivKdbZ6GmcgKXocOGFzHbXwaXLhx3SuP?=
 =?us-ascii?Q?7RE0ymxjPafjDtBQxDeh5506vGne57okgpVBVxPLQXj0hjXNzJpUtyfVPI9J?=
 =?us-ascii?Q?dlWhB4aEOYDoMy8NspbF5GrshottHRc/vTijbKJea4aNE/htSoMuELE7uYgn?=
 =?us-ascii?Q?FVRc26v6RbpfED8r+Na2cRrl6ih2xJG/q/tntGbxb4tZbaRzPRJEzUucEZPW?=
 =?us-ascii?Q?K3FaGBjMjad0yOajLxqcuzO2/Bs2PnSjxB3vX1xgP8HyN56vWCjaJApVSlqU?=
 =?us-ascii?Q?cQOIOojYWeDsubi4cZKNh/CRdIoWQ16DHBoPtISI1c2RTNZ0zlfYJea7bQ6I?=
 =?us-ascii?Q?mKxR4AaDFa5AUcttnRAkcBiQOkg2hY1zkzBg2N+SAtxhS4nlAkh+mKbxbEmP?=
 =?us-ascii?Q?Ggx1ryPvxoKG64OS0Hf9d2GdbIuXQ8kN0KSatTO0KGWAHzBwH7FJlX29vA5S?=
 =?us-ascii?Q?6Q7aBUpoH/MUGvyafkC+le1wxfT+YLOCWdynHxPh6EponTPBcpLdzZzqAQqV?=
 =?us-ascii?Q?DfbuP8w4T41y5So57bpPUEmk+9nZIBN3D8+Tbp+Lv8J/Gdm5So+3gVwVS79d?=
 =?us-ascii?Q?BB+otyoOrDPFF6Wg4gwmmFmU+bTRkNacdI3ynKbpZNY17EVv+Tu++BGvDcay?=
 =?us-ascii?Q?Y1+J5ESK77EU6y4CHljqbQFYX0ksg4Ku+2qccLkeA1PRhdfxU1XCDpPe0KT9?=
 =?us-ascii?Q?cUdVIiC9lUPLJlNB/4FpfRXCUyf55WUt4/f8qyJuh1HNYm01ZxZT4pC+U0/w?=
 =?us-ascii?Q?5cBFTJg2I0GdMve74WwSJlOc/GGXQK0IarP/zGZcObMrGk5Jr1KFQgi9kZ9i?=
 =?us-ascii?Q?sEWf2+eXRmYMZaYxTCbboA0QY/bbU2SOI4ab1INqRuoYfCMa6qdGITFM8tEo?=
 =?us-ascii?Q?DfTv+97MBITqqARCaaqbgq7OITsTpgqLAhf3ykK7VOMuFpMmKVVg9I6BfXB6?=
 =?us-ascii?Q?Iiv1Kq2rLJkIQd3XgWelOZKOMYy1HJ+3xy1W9g8DNTXgomiE7cZvuaiHr8j3?=
 =?us-ascii?Q?2pMTmlwj4Ll6Ip3veshIPjnZ3SwhtTXe/3WPaEjbFeKD9hcocX/vxCjHhGNs?=
 =?us-ascii?Q?zG4x3N2yiGcf5sbpdnNT3g+OTcoDXDlFr/LFZAXt54zVbRG7kLy7NTvdL5R2?=
 =?us-ascii?Q?w9MKYHTvxlZNEopcBBf2lokVYV1eTys12pU3l9r4tHErP2EZHGEKOG6UeOFn?=
 =?us-ascii?Q?JMVs43setkdvq1vhsCkrIzNP3lIkLHqw/taZ+i6CATssAZWdeTnNilRJd6Ij?=
 =?us-ascii?Q?O4vhTj80v4kHtVCJ1BB7HVVi/pVviOhaFq2SqEXF/XjP90y3NYTFIgH0fjoG?=
 =?us-ascii?Q?eFvXmNRAdlG7JtSrw6aT0n//ov9CfV3Sfc3mQclw?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e45629c-57b6-4814-26ec-08dba3e14b11
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6115.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:00:23.1034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZoYFhedVjuvAUf+3WOCHwTAuXDV6FUPJSIP8FuzlfEDk8PY1lF5zTiBE3nnepIPisUxgIkhnKxkmBONILlpdDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6792
X-Proofpoint-GUID: Qmm6ekjsmRIXJP-nXIAeswLGM5y8Z6lS
X-Proofpoint-ORIG-GUID: Qmm6ekjsmRIXJP-nXIAeswLGM5y8Z6lS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_08,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Aug 23, 2023 at 10:04:00AM +0000, William Henderson wrote:

> +* *argsz* is the size of the above structure.

As we discussed offline, this isn't right for any of these. They have the same
->argsz semantics as discussed here:

https://github.com/nutanix/libvfio-user/blob/master/docs/vfio-user.rst#message-sizes

So this value should in fact be the (max) size of the reply message.

regards
john

