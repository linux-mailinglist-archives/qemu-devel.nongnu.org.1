Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F97C715A09
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 11:26:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3vcM-0001Tt-WF; Tue, 30 May 2023 05:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q3vcL-0001Tk-45
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:26:13 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q3vcJ-0005Se-6N
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685438771; x=1716974771;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=IC+6pVFSUMpOlhCixhAP6zyVHwDMZVuvn3KYtpUCISE=;
 b=TBVQVctHLTPnYF5e9rAuG061N8a3avC89yg836q0XE97nG2w5I/u9QEn
 aEGg+KHbb/upU9F85mxuh3S0Yfnz9yq1SFTdVDQ2c5KA4x4hHcCF6Qlje
 RWC76jggh4kpDsYmRpzgcUmNHwiYBDGguqwGdY1CdJD3YX3Lya1joVWwa
 7JWT9Tz4FHVcjlZMOu+Z/NGaKl31CKA7WQRjBmOpwf29X4xjLXeXETDkO
 6vBe6OGB+2z9gKasUeDRRN83NUj9/5rEtPJxP0CUTwRdmAFutqZXG6Nld
 /uQlqvUeY+mKnmJbxOwFvghX6PGtqxZpqNGugFhVo6Zbb+lfx8izuR291 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="352364337"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; d="scan'208";a="352364337"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2023 02:26:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="796203807"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; d="scan'208";a="796203807"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by FMSMGA003.fm.intel.com with ESMTP; 30 May 2023 02:26:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 02:26:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 02:26:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 02:26:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 02:26:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSYZ9FV7/2FYT76Ero3Hs4hiBeA7Pz/wb0fNDR/adp6cCehmO8lKikDSkyCpLP8Cvm9fcnOE4vjS8EKG2XxCPUXcbjPfr2LxrisW6Qb35/DgEEY/nBXdEp009AFGpTbmSccU1u/IiMfhRH9eYmTyI2PHdNN5N/aZqDciK19yl6phuEjdmqSe9jO/S3PxwwwEw/H29pJ7yTLQXU2gjAyxPl2VxvhnGLqGCqs2QyEByhIfBYXvdifmGkc8ifyvx5xtBDXju9Tm39+loMgNLIgx6sYw9d+2d454zUzOkFabxYFVL/0njSqrVO5N1m+nL8oGgDSp9cMQofWntc9MTKueZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMGYZJeUrJKRtah78ohzDtPVqFy4VamCURn6yMbLuSw=;
 b=fzTTWNoJlIVfCTAWfKcrEuZUBxYwxMl3VhaHjH1bpXy9x5iAcYxmVJYCo+xvGeDKJ4nALAEcK2WWWbAsWf8AsKiu2rf/zL/R+lsqssyCPta1lVdnMMN/O15J3OT6NBfObPeOyidWiyFqzd0/f2ijtJg/JjXbj+UmPy7JA6O3cbmQFqDRhjnmHtfqvLdBygoYjlRDan+XEGb/tpgWuJSBmrU2NVEFb5B0YxIEa0r4MS0OMieXhyYeassDcUhQT6Ws2st8xiuolPZXQSwTKHtDHSt+hY2TdrZmOs0YmF3UX1TMul6e8mdZbgXNMRkDab78RkOxr+NF5rReq3X6+/WpNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA0PR11MB4767.namprd11.prod.outlook.com (2603:10b6:806:97::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 09:26:01 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 09:26:00 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "hao.xiang@bytedance.com" <hao.xiang@bytedance.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "quintela@redhat.com"
 <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 3/4] Implement zero page checking using DSA.
Thread-Topic: Re: [PATCH 3/4] Implement zero page checking using DSA.
Thread-Index: AdmS147xDPIGeUJbRt2KIZJGERZFlw==
Date: Tue, 30 May 2023 09:26:00 +0000
Message-ID: <SJ0PR11MB6744115555A361C057C82C30924B9@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA0PR11MB4767:EE_
x-ms-office365-filtering-correlation-id: 102a60e4-75c4-4483-d814-08db60efe1ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hgKOV0jzefjv9apRlKtuKx2rYdaZtN5NPuJVlkJjgwKRnbb9UuB+ijTVECfwOSv8M+q97jUhZC38C3jqMU4K2Muo11aVMwN801wxykGzGAtmVSyjkjd3NL8xttSkh8T+i4I2o/Pf7TMrbDlAQawg8qNHmiZKYCDvTThHGFn7/dMTXkodmR1oUW8Gs8v5xsZJOwRZZa536D2rSuY/HPCv8fAiebyYymDusWDqYFKNcUsGEGpZ0xJojiPC/CBcnugDKJVWv9cSVUMIKEOUAJs53WxigMdsS8wyg+rTeNHppjWg9FlDsld/xzNZGy5qipKbB8fnpoYW7l+Mx31snkP5ECCrX2RjxcalPEu+CfI9HSZIkfV0hlqftYPIlrV+WLI1I3WMyWo0nuEWAtq/WrcaEkTdRG/WO6K4scQLd2mjCS38cNEMu0zXyMZRmEjnVN1iiWo4XILtSxR/GPc5AMDtGkasZ92wUGoVCRDAluyap1VU0+H+TUdRkIm9mCuTO7X09q+xN/hfWxchnLNmOULvtwiEdJIbGhhRUxKgBopK6e+85I9xu39ExkmgVCAR2HDUVsnwFzzWK8vmsiBp4cQRBeuj2DrnuNtv6u3A6uaQD+W7tJD6rLml9V5y7nl5Ts2u
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(186003)(6506007)(9686003)(2906002)(55016003)(38070700005)(6916009)(4326008)(316002)(71200400001)(76116006)(64756008)(66446008)(66476007)(66946007)(66556008)(41300700001)(7696005)(558084003)(478600001)(38100700002)(54906003)(122000001)(82960400001)(33656002)(26005)(8676002)(5660300002)(86362001)(8936002)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AZ1AozyxdE66cITzdYOtwolLcODHNJKuZZWgJ9lEJi9cE9heaGyulrHc4DEA?=
 =?us-ascii?Q?d0Npliy4P2yeA3LFbPI4vqW5B0h4FqxHbOivlS4rk4HJi3srgnMVoJUqRfOO?=
 =?us-ascii?Q?vG3gHZpxmOtRXiK6os5pO2ygrFZfeB9bgpL8oKJ36lRH2BWg0XN1B9gT+G/r?=
 =?us-ascii?Q?oyjU+8nG+bI7DANTTABJqLN2fEBDoyvxFLohwaM0Y8xx/k/Z6G6JIVNyboQx?=
 =?us-ascii?Q?MyCgASvbcwZkT4Efr7KRoK9yx2CyF1X+mEqsYpB6ZxxgPwLw1p8C64njpILm?=
 =?us-ascii?Q?0VxRDB3Xngn7NxtMQBOFm9jNPe2YpiUcS6qE0+iXQFdb5/SYOjBb0DvPUSv9?=
 =?us-ascii?Q?a6Xs37U8Q7V5MRAi+kb2yPo56k2+iPF8fq76/zBES+HBxhRGl1PgvntPxvJ/?=
 =?us-ascii?Q?Q6JYWXJ39jRt3Gh33/QcHNZFZTO9yzL3zkPAwVi61+iKZfMFw3e6wIAm/5yz?=
 =?us-ascii?Q?+1LCRRTgpyaaGUiXKKyLeZ5A4l+6eAdIDlY7f5SA3NfPQIfSm1DWanZ34RHS?=
 =?us-ascii?Q?50cYag6UTPT3U+4ZqLGvQLz4nxZ6MChjZ7Us5BEsccURAmpSbFs5nXj1EGpZ?=
 =?us-ascii?Q?58aOUTsY2uJb626c1uTNzhqJvWLe0hzSa28tGV2vZ0J4hh6vlfFeNVtrFdTl?=
 =?us-ascii?Q?TxGZBjJTbgofCy8LnbrO/fm5o2DE6UipoDOcShnyPH9u7+VD3i0mgoXtiXyf?=
 =?us-ascii?Q?RuPj4Ro5howaaCFHNkp6tcEvQVgQQzB7VmXhLmrZHnV8EkHV6cRhvznUWx0c?=
 =?us-ascii?Q?T8LntxTP2igT0mDrHB7hzaEQPUO28emAn7nQskr7hukXbKoSzepL7+ib0xrh?=
 =?us-ascii?Q?8iDgpLBc6sQfUj00ZA+FEfZVVlbwj3XNFuNjXPA5F/TSUsR7VX2sje4KqYiR?=
 =?us-ascii?Q?E2DNgKbs8JJpP5+jEWSsEVQlTTdYz7iNo1OMEh3QmVeSMeAKSxOH0q8rwlDE?=
 =?us-ascii?Q?PrLOrXXDoDgy+4NavoGhCw8Uo9DmG3D5/nOgjowDGr01yb4pn8+Bh07CcsEQ?=
 =?us-ascii?Q?3mi5xZOx8am1bqB5PJ6td4pmfFZ5zvxrtG55sLjDQtywWVSCR5skozpU9HJj?=
 =?us-ascii?Q?21TJhmwqE11Vhv9iBNzKu5iHPb34Rh/ysOxBlaUgJrvufdXgApVD8XLPE62F?=
 =?us-ascii?Q?3Bam0pv6ftdsHQl74PxExcQYPtAuff0TtYmEMnVUn01U6HOm/pJ7vi6ToA5k?=
 =?us-ascii?Q?jsHNowgEEFvcuF/uw3djqlfdV9ZlncPjaZesMjs3NYiMkj2LP/lStuVDJaLE?=
 =?us-ascii?Q?OY76rGebizSEAKJHh83UXhv2mbZC1ItqbobveQChXpTQW1TKDsdQucANO/67?=
 =?us-ascii?Q?WwfBlnFG0cmazyZFJt15sywugiQNFidSmhjUvWTy3s5WFOTVguneBDy8Sa8c?=
 =?us-ascii?Q?5UKUKzkY0DrcqvlCj6Acl173nub9QV+F8vjGaYIcXPfC9jt/NYlgFnGYHOBW?=
 =?us-ascii?Q?Ukcj+iHS1mvD3GaYS7HqcimJfGzfizWAeRklVyVX2gyWRY0gRhDU3dGWkSUD?=
 =?us-ascii?Q?/RQaabnfnCalwmPVLdUqWU/j/WwJFnaXBB6cHcHyTfxDU/xO1w7nRibu9o15?=
 =?us-ascii?Q?8Xc5j8XRps91zCpUhnGtXRC1HrS2KPcsJA4MShgD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 102a60e4-75c4-4483-d814-08db60efe1ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 09:26:00.6306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LywhdHoP6XGLlF/hJKAtcEK6jhT3ZENAFNBbatOFOwmeGhXT4TgQ7hPyuRfufQO0ZlJve/HtVNSNBEr5eAhkD7myi/XLWqeSSrOAtE1sV60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4767
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=zhenzhong.duan@intel.com; helo=mga11.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Hao,

> +    memset(&descriptor, 0, sizeof(descriptor));
> +
> +    descriptor.opcode =3D DSA_OPCODE_COMPARE;

What about using DSA_OPCODE_COMPVAL with zero?
DSA_OPCODE_COMPARE consumes double bandwidth by reading
from both src and dest address.

Thanks
Zhenzhong

