Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B49C5714EBE
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 19:07:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3gJk-0003JN-VF; Mon, 29 May 2023 13:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1q3gJi-0003Im-7F
 for qemu-devel@nongnu.org; Mon, 29 May 2023 13:05:58 -0400
Received: from mail-co1nam11on2049.outbound.protection.outlook.com
 ([40.107.220.49] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1q3gJg-0001Fh-5q
 for qemu-devel@nongnu.org; Mon, 29 May 2023 13:05:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9NPN/ke4rFAbxDcGRNjklCpvFvMKXKAFjqqYJF0OknWJyML8TKJ0oNHgNX4y9uZZM7M8gWTKokZxfeWSX9jz2wyILID/lxaU7a5849+BHmMqFl1lgAl6t6rMz3/lDQX/DXspWx+dypgCU9vw7ILOxbXVtDwAzOBV/EsDidfIfoNgbJWHK7rBDQbV2diUUh7TJ9OgVz/fUp/tDR3CSQ9FEbdVYMKkvwM6UsOkiL7Jx+KShdZ2liaRNeLqYg+KaqsyQ3W1K5Yarywk2Pop5uSjjKcLTQzMkugU8JSQHyxKXhDXv3DFzz1NTRQwpn33BBtHthQKUwozzm0JPiyB49Daw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPJbtLKrq8iH65bZr6wmSNZtGyqySK+2d+JOgv1F5Yg=;
 b=l6ODSARP+PJhyBAwHVmkP0Srofgmug4RZ/nQnbOViImI6BhK7Ucyc22LXPmpiya+LkSkSzQ29E79Q+PJPZ5aWOJYRmefIneUZxydBDId0GNKiiqoS29QR4Jb5K2svla5jMkMgUSD8WpAMNnt1agx/KgtEYFnR39hEBG/adSWSCvXZfKV5MEe4gf2vbpC+schLnhBhWegeFQOXwraK7/P5EyAmgORCQIYtCn0Fybb8OcOogPRC33JfivZvJ2uk/8NKvPKZA6y1GfAVUWdhmWgrcYHDghT3NB7a1oXHZ+dz6YilM9drEGfznKfFIseptlRJ5MMKUEPWwkgZkDOrqRU3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPJbtLKrq8iH65bZr6wmSNZtGyqySK+2d+JOgv1F5Yg=;
 b=Q9ZCdM4DgDXN9zVVxWCBPenpNY0w9AGoKtpBSESaimm6usksAmj4KD6v5FPhDlioHIOOyykd+0lgpFQeODt9Z5Hsbw+zQ6nhtudsv9KRAL62P9MFmFXSDkwWYuIEsUFnKfTdZHELx91jgf04OJxHZZ1eddEnnams+UjPLKRO3ax9KgHPsY9iRT/cx2nBh1RQsU4ZXJBiCsDbJA+5BNFrelP3TPxn+TOXVpIBJ1q/o1awYW3br/qeAOQhJq9ZicG9KasbiHWW/QKzosY20qaBkU2SUFj7e9vuMM805QqHR2FSctWrXsBtNU2rhzeqTiZt94aP0bEdLMqMxFXKmFArIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6859.namprd12.prod.outlook.com (2603:10b6:510:1b5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Mon, 29 May
 2023 17:00:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.017; Mon, 29 May 2023
 17:00:50 +0000
Date: Mon, 29 May 2023 14:00:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: Jason Wang <jasowang@redhat.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, Peter Xu <peterx@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "eduardo@habkost.net" <eduardo@habkost.net>,
 "Peng, Chao P" <chao.p.peng@intel.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Neo Jia <cjia@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] intel_iommu: Optimize out some unnecessary UNMAP calls
Message-ID: <ZHTaQXd3ZybmhCLb@nvidia.com>
References: <20230523080702.179363-1-zhenzhong.duan@intel.com>
 <ZG5CPws85lIvpT07@x1n>
 <SJ0PR11MB67447A3D47F6226F58DB813492469@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <ZG9ocSY+vJAd1Hjs@x1n>
 <SJ0PR11MB67449B49619CCF94ECA7447392479@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEueaUvopf0zv4dxe=D5PLHkQkeV8-QshH8gmObVY6J9cg@mail.gmail.com>
 <DS0PR11MB75294EE1B95AE1953825B845C3479@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS0PR11MB75294EE1B95AE1953825B845C3479@DS0PR11MB7529.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR16CA0050.namprd16.prod.outlook.com
 (2603:10b6:208:234::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: 4367a627-6f46-4b14-d05a-08db60664146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LzmHmuc2RGQDyYGhr7D6VNP7s64jHJ0ChGgzmUssT8b1qEIdPxO4Ywz1/g6iW9TZBqwh7/GqRoAKNNZrc7lehVhZMpKb3s/+EY9PgZQwkPfQnXq0R2iDXQ2geV6X4EKdbOHYoEKCZ8cJEydPeUZz1Ot+Cdz3y8FdW7J3aCEvYB86EUtZd2nR+rGaBlOQQyzrAVOnIBk9zjFKyEizQauKM+rXyqbKHqBIy+oJ/Yubtu7avh8yWDenjQMVi2pshTlQb/lmph/7Mgrs38H42yYJODYPUdu8dQVtpL/Vn7mutdL63yAxDPbu69MagsZlJWSPpNOEuM9r/OB77tDMVZOIjFipOqOcH8PjOwaT+A/ltdDOkXjyyQiLu4dtSbYkx47fa8HJ/5uuxDKOGD6bac32wfkojRPy10puXzldcbRNKQCNMe60yABqi4PpKu/ImiIjmEY2xXKWw2aGUTyntswSNy+NnnJ9uZBkddCg0UGD5FlUh3tPtGeiAWI2ds/8Ymbxfbk4HWkYs1+qzt8NCqaC53/KQWvG4VqsSVVMcjtyF4QPZYc4hvrewQfOnTjzdvOz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199021)(2906002)(4744005)(186003)(6506007)(6512007)(5660300002)(2616005)(478600001)(54906003)(8676002)(8936002)(26005)(83380400001)(38100700002)(6486002)(86362001)(41300700001)(316002)(66946007)(7416002)(66476007)(36756003)(66556008)(6916009)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFJnVUt0QS9qM3dJZ0t2YkR6cUE0WDRmK0piU1NUR0N5UWZTeDdJRUVUSHl1?=
 =?utf-8?B?VWdBeG1jZWRrN0sxaWtjSTVHQWYzWklYbGdya05JektJcW1pWWV2RVk2azNG?=
 =?utf-8?B?eEQwRDFLZ1lUZFdsUHM1bjJ1OGhjaW40c1lnYXFpTDFjdW1vVUkwZjBiQjIw?=
 =?utf-8?B?WXdZLzBuR1o4c1dVTVF2ZS9TOUhCQTFldUMrT0EyNHVQc3NiRU9RemNDc2pZ?=
 =?utf-8?B?eEhKdWJaOVpFcjhNWE1vOW1GV2NId085WXVCeUpqWGg2M0o4UGd5SjBiSm4v?=
 =?utf-8?B?bFRnVytremFNZE0wL1JncHpIcTUzOGpYQ2s5cldhR29TeTBCTHZyNEhlSW4v?=
 =?utf-8?B?TnhjWFA3MkJDWVEwM09jcnN5QXRlSVZrTTZTZ05GRHF6aFN6V2Z6d1lrVUJu?=
 =?utf-8?B?YWs3dm5EeFBPeElUOFFFMEs0Nkljb3g0czlIbHRkbjBDQm5CWkFzZCtMWkVM?=
 =?utf-8?B?M2Jzc2VwbUFwODBCYUx3SndjTnRPcEJKNlJWZWpsS2NWTW93cVVCQ3ZWekVI?=
 =?utf-8?B?N1U1bHoremhRTUFHTzl6MXgwU1htd1o4dG1pQ0JONHFQSzU3L3ZxM0J6bG1w?=
 =?utf-8?B?WDVyMHRqUmp2NGoxTmlZSTRZdm4ydEtLdFZaVnVYWXV6UEcxRHladVQ1Sksw?=
 =?utf-8?B?WC9pcnhjc2F4VHJTT1BvMjlQZmw3WDNSWm8xbng0MTdCcGhqVjNNN0R2NHdr?=
 =?utf-8?B?WHJKVTdkY1loUlRJMzI3MkVUaCs4VHpVYjN6c1pWNXZpQVd5VVJtMllCQ2Jr?=
 =?utf-8?B?Q1QxWldvOEZLNWFGZ0hraDFEam1pRmFzUnJQdTJKL3hYUTF0My9VMUY0QVoz?=
 =?utf-8?B?VTFyT2c3RTlVYjA0dEU2aUw2MWt1UjBsZ0xucXNUODlQU2VtL21MNU1Dam55?=
 =?utf-8?B?N21SL3FyTndYN3lLdVRqbWdzRmFYOVNqS015S2tpTUNoZW1ObVFleitFVjgv?=
 =?utf-8?B?RFJma1pBM1Y5dFBxT0pwY2hMUEgvSHBQVVp3SzhKQzk5TTRyOFcxMDdYNGx1?=
 =?utf-8?B?d3dwZ0N2MW5Rc3ZtdjRqaEZxMDhjdzRaVSs3NnlsL3RMNVhBcUJ4ZmN4S0pH?=
 =?utf-8?B?TjloQnptc2dIV3NkelJ0aDl0a0FKWUowSi8wVHFzYVZUbHF4a1J6MXZoUmZZ?=
 =?utf-8?B?djRFdHBMSWVXZVk5STJ2V3phY2ptMXJuRy9RNERtYjVLd3VWMlU5T0QwVUVV?=
 =?utf-8?B?YVJNNkQ0L0FvdlpNY0dGTHM0VnZEdjJXT1VrNTQvS3EvK3NkbWt2VXhWdFdx?=
 =?utf-8?B?YXdUVkR6UDlrNVVLMEovUjBDbzhlV3IzOTczVTZjelEzMmJKeThWaWtCQ1c2?=
 =?utf-8?B?S0FoY3FjK201ckpSTDFpd2VrRTJ3MVdpRUd1UmZZdlNjV1RVSmE3L2QzVjE4?=
 =?utf-8?B?WGN3cHdmc0lRRDRqNzNta2hJQ3NNeUlxUnJtSTR6S0Z1TER6Y1BYYnF0QU9Z?=
 =?utf-8?B?VDVjWjgyMFB4L0k2TFdMQS9hTm90VUxNZGR2ZE5PTXl5WXN4VHBXUFdDNGFN?=
 =?utf-8?B?NkNkdTV0RUVkL3RmV2NCK09XUmRFRWFROEpwcnR2c0c0aVQyWnNoZUZmWFVn?=
 =?utf-8?B?d1p3cDRiNnVpdW1hM3JxYW1PRGt1NnkxdDFGMXY5UTVhTTJQTzY3UDRjbm0y?=
 =?utf-8?B?UmJCMXZJYWNmenlXazZjSFZPSVdON29VVWM0ZHplQlpOZTllRCtDQ3o1RjdJ?=
 =?utf-8?B?c05LUVE5bWw3QTdsOGx5cHdKUjVGVFJEQjN3LzZMZXVieDZEUGw3bFRlUnh4?=
 =?utf-8?B?bzgzWlVtK094Zm43bkI3bmhDbThhZ25DTzBDRllYMTZJeHkrTlRndjJzMFRZ?=
 =?utf-8?B?SVQyREVNNEVMSTdwcXJSVW5vZWRybFh1NTEzcHB2azFlbXFTSzkvTnFIeWVp?=
 =?utf-8?B?YXNNdGVCRXN5SlhpMXZZNU1uN2xLckxUeGZLRmpSVUpaNm1mT3EyRnBRVVo2?=
 =?utf-8?B?dy83SU11dUpFamc0VzB3cDVDamtQZU83dDdKS0ZHZU1mWHVvTk02Sm5RNVRB?=
 =?utf-8?B?VFVidngrMFNNZklrdjdxdXV0N05MZ3VybXNZVjJueHg2Mk13RU44M2p4R0Jm?=
 =?utf-8?B?VVllUkJZRGdOSStXNW9HM3B4NzhWMjJNMGIrVUNEVEh4L042K3VZZnByL3Nk?=
 =?utf-8?Q?I7tkhhksCrMBjqk2oXAC3qIRA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4367a627-6f46-4b14-d05a-08db60664146
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 17:00:50.4087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xP8/w96u3JFitafrb8/B+RKXbBmZKh+H417tM0lpBcc2o1AHr+sOiE9QvSSip+YU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6859
Received-SPF: softfail client-ip=40.107.220.49; envelope-from=jgg@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, May 26, 2023 at 08:44:29AM +0000, Liu, Yi L wrote:

> > > >> In fact, the other purpose of this patch is to eliminate noisy error
> > > >> log when we work with IOMMUFD. It looks the duplicate UNMAP call will
> > > >> fail with IOMMUFD while always succeed with legacy container. This
> > > >> behavior difference lead to below error log for IOMMUFD:
> > 
> > A dumb question, should IOMMUFD stick the same behaviour with legacy container?
> 
> May need to hear from JasonG. 😊 Should IOMMU_IOAS_UNMAP return error or
> success if the iova is not found?

The native iommufd functions will return failure if they could not
unmap anything.

Otherwise they return the number of consecutive bytes unmapped.

The VFIO emulation functions should do whatever VFIO does, is there a
mistake there?

Jason

