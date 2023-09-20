Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD80B7A8215
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 14:56:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiwke-0005dB-G8; Wed, 20 Sep 2023 08:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qiwka-0005cy-TF
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 08:56:16 -0400
Received: from mail-dm3nam02on2063.outbound.protection.outlook.com
 ([40.107.95.63] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qiwkZ-0006Cc-2T
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 08:56:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMtm6yylAarONj3LCpfiQcNhRlABN9dvkhXGEAl1+HmHgUgoFLKg/oQuG330rJaa2Xj7jTv0Vwq9RzO5+1MqzPLq6rGgjWuZCcWD927NnZ3CXdBvibNXot95pXHV6ZTjRYj/FwaK644lP9nysMYj449/tk5k/Wg6s2sZhPg4UbLCtXXMLuY4FO+La9M+Uo5FvhyaHjMu/CAt1a/FjgUlnwWdOKjxulMtD0ZF3KE83xLHsZHredXzUxCl+KLhOpnurmf4quhhh29guRmVPf93vi0W7pDeb04+X34KTBl21PLNKfzhpmO/5sgNS9I9qXL3ucg0243INR5UEEHGhantaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayB+YCPijG2SEb1AjrPLQM54BZ4tXlzUeqyO2iNeNVk=;
 b=fZ5flihZQhi5CWcJWUbdrMxNALaeDuNvFKUhKkccdS7VuraWZOGOhAtSPS8Goe19Vur/rjLzUuOUrTsKQ4VCGGyv8+wY0kCCqvvcmfwBhUNsQF86C85HcSlIZN2igzxdkVA8oShy+kNSGgkc7KVY8ek04DEetYX13skQVDLgQF/pPgCg2XqtzoOfmFcXh+qk6gRte59XbfsOww7eCv/mojU2jG1X8szYloqVC6djzMbCsuG2m7wvPJvbTUCHu6XNItiObWTB47SoKsrqNgfdVhcD6DVtaDZzLMwBNhveA6yBYIosLnqicuDm70qj26hLfr3MTtpXOnyQ1XZ9abDxuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayB+YCPijG2SEb1AjrPLQM54BZ4tXlzUeqyO2iNeNVk=;
 b=e7ZzhC1ga3jUi2WiJUFvAdp7OZdzTzKPZN5zWrGfzSj+CbfLn7yhs4BlDkaKEgtGoPw26VRT7sQcgvMkSTZhSuMbQJnbPp5RFSfIofDba6d+z8l9D1po7eEXmPzmKfwf0boJq3Haj8PkPoXD7qpcEwxdfF1N4zsOuTRVOufgQbVzVhzgAqhK/63koJOKUUiYYa3U0XupJmpv9pROcTdysQktQCptEWAaxuyhGXhlF9aXIDZSf3Uf+HH+zVz6GoePuGGQ0gi/hRDttstctZSsPuzmNevOACfhHnU6XyNEbJ1WU9EmLECrdCAUv/0/j/f/8+ecu70p+RPhN9Kr2VcSWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB8040.namprd12.prod.outlook.com (2603:10b6:510:26b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 12:51:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 12:51:06 +0000
Date: Wed, 20 Sep 2023 09:51:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v1 15/22] Add iommufd configure option
Message-ID: <20230920125103.GS13733@nvidia.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-16-zhenzhong.duan@intel.com>
 <75c9c56e-f2da-f2a3-32b6-c9228678b05a@redhat.com>
 <SJ0PR11MB6744E56158500CC3A0A34BDC92F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <664d3338-c280-6d16-b03e-bb235931ce99@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <664d3338-c280-6d16-b03e-bb235931ce99@redhat.com>
X-ClientProxiedBy: SJ0PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: 536a52cb-8a81-4525-0573-08dbb9d84123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u64id5HweFAQgcJnqPosRgchfQxqxLL4lSRXhMYbGy0QHpGHiIfyWotfduccW2S/tmMC/AkXy+TgI6b/hxio6pXVryo9m2MiYyEto0BaHhjSYhl/5FAaS6haLQqRO4sddTf4ESrTg3nqvHGfImaFEKKFcTn1qYkIdRnGfyOXrYSbpsMFbnf5jadAaDSCgwSPRs8af2QBrmJxe80yboic6YBVeRNvYpeTczH26tj1pq9efBpHj3c4xug8yiwFvUbl03iX8sNnTsPk7cT1l8XRRfgRTP6MWYGSMlXp0tAYD02PE9+ESrhndznksXNOueHSRHXrviSE2kH8bKFYICsKMuyaB9UV6mj/vN+PMPMH/cXG9RqhSQt5BeihTUWLCfmSRMFQ97aJT8dALJpiBHdm7od7ncH8WXiknVPGghUxJw1QfNHdrC7RC4SdFsWrB3JGPqKxsvo53tulzUOH7ZnT1cyi7meshuXaE2ugs1MSjJmYahK6MgLwijYpbDDjh0S+x9O75cIZ87zDxkHoi2FHYo6LNYf0Bs6Kp28/TbxQn3pGKdqketfA5h2Kz0OFDO2K
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(1800799009)(186009)(451199024)(2906002)(7416002)(33656002)(36756003)(86362001)(6916009)(38100700002)(316002)(6512007)(54906003)(66556008)(66476007)(66946007)(41300700001)(4326008)(8936002)(8676002)(2616005)(6666004)(1076003)(53546011)(6486002)(6506007)(83380400001)(478600001)(26005)(5660300002)(66574015);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzhoNjhZTTgveE5EQW12WjBLbUZCRWxQcGVSankwQ0NFcVFYVTE5TnBmRDJP?=
 =?utf-8?B?WFR6enAwcWtEM0w2bjNDSDBIUEhEd3hnaUlML20vYXk5U3Z4OTd2NXl5N2c1?=
 =?utf-8?B?OG9zZFJzb0NxMmkrdWRmYUR6QVNlUkxQNml5Y2xRY00xNnBiWTNqN1lCS2t2?=
 =?utf-8?B?ZDFiaXpqaXljZ05TZm9lQnlMcE5MZmFKMi9FSEordkJjb0c2WGJDcmxxUjFy?=
 =?utf-8?B?MnJ3SDNXcGw1amhNL3YwMmUxTitFYlJxSE1aWVJYNmZZRktWeFF5NnE0QjlB?=
 =?utf-8?B?OFlod2VlQUNaN0FyVGc1bGxUa1F4QnhxMUN2TXFKbmpYN2F6Nkorbk1MbmF2?=
 =?utf-8?B?SjlWRXcwRXp2OTZNMWlRcmdLSlhlUGpVMnpOM2g2K1lTUFdWS0RnV1lhWTZ3?=
 =?utf-8?B?eVBVN2hTdFI5dDJkWlR6bXJzRDZUMVphMWNYOEZyUTFwM2FlTmdYcko5Mk1W?=
 =?utf-8?B?cFlFSXAvd0VBeVJMSnRvNm1Ec0xCOVdEUkF0ek9Ua3IrQ2lyRjRDaEtWZ1hY?=
 =?utf-8?B?RWloUlpBQTdJQjl5UjNjaDhIeGF3dEpQQTR5bEF4dkJlaE82WmVOVkY4QVVs?=
 =?utf-8?B?VHVWdnlKb295VkJUZTFzUUR5UWVmbldJZFNuOTdVZmJoOEZWZitUZXVjWG8v?=
 =?utf-8?B?SVZ6eHBMSFpiNVV0dFZ3V0JmeE1SKzRjYlNIQWg3VWU3WWc4NVI1SlJUamYr?=
 =?utf-8?B?NlVtcFpFU3VIeEtUNFQyeU5pWUh2UFpmdkVFdnJaUlhZT1o4bFBDdlZxREhl?=
 =?utf-8?B?ZE5NcWdFL21pSEV4Ykd3WVZUUlhCbmtmMWJJcmxyN1pKNThYeUErSFRMcEsr?=
 =?utf-8?B?UVVyclZTakVrU1M0cmQ3TTFnTnVlb2pVRmZya0lad283T0ZONm5YSTN4bWEw?=
 =?utf-8?B?a1FPNU0rbFdNV3BGZFk0VlpMRGlvUndPejRVclFzUUU0NmpsMGUxdzA2SGh1?=
 =?utf-8?B?cmlVUkw4bjhsUzhZdEZTMlRlVXpNOEo5VlZHR210Y0EzMjJPcG5idTV6WHJS?=
 =?utf-8?B?N01Bbk8wa29IN29aRzdGZmk4VFNtdzY5cFdiSlZlejhGUjN0WTNnejExZ1A1?=
 =?utf-8?B?eTkwd2hDMlhhZWRkNTdGenJ3VkloZHFxUmdyYVhmSElpbzhoNmR0bEdmNDFG?=
 =?utf-8?B?cmxsU0g1ZTZNeDlsaTdLdTVabnFTdTlVa3E0SUhxZnNOUzRHc0lKRTduaTZz?=
 =?utf-8?B?ajVrWFo5eFF3Nm9QUUlMZzlKcnZDdzh2dTZPNlhLNjR5UmFHVVRGVU9LcFpS?=
 =?utf-8?B?a0QxMlMwcTFIaTl0Y2N0TnV1V3pZK3hScFVjMURsd3RKZzYwZ1I0VEZYSU5S?=
 =?utf-8?B?OEoxd3g2ekJ4Tk5WbDBveC9VNFU0TGxtTFdhMUxET1NJTUdQWk9aMXM1SHM4?=
 =?utf-8?B?d1g4T0Uwa0trbVNvakJLU2ZpODZOdWZDZDlDdERycFdPcXJrTmNHUWhyRnIz?=
 =?utf-8?B?NXBpUnFFbm5nRzNnZUw5MUhTNVcvSjByU2E5MEVIU0JwM0FYRm5MTEFScUpG?=
 =?utf-8?B?RmsrOFBNVDhwVENlMllKTUI1NEo1ZTlYa3crVTFLeWtTc21aVlYzZ1dCRFRK?=
 =?utf-8?B?RTNHNmdtTGdWU2FTTEkvQytPV3FrajI2bE9CTEM1RElMZzFhRTFTZk1ybzJP?=
 =?utf-8?B?d0x6ZEU2bUVyWlRPZFl1amNONGZwM2FobWVXMm9WdUhiYVd5N2ZCeUlqdy9C?=
 =?utf-8?B?Ny9iWWIxQTZCSFA0aVdoL0pJWHc3Y2h0MS9ub3g1Z0xxdWFFbzZwT3FHSmFz?=
 =?utf-8?B?ZEpRbGdkcEpZL0U0MU9CMStrMnRXcG5QdGF0YWlnYkV3c2duRXhMU2NiY1JH?=
 =?utf-8?B?YkVtNnlxYTZtWU9YRW9xUGxLNTRPRng4S25obVcrMkRRaGxGcVJpVVNNaEtC?=
 =?utf-8?B?cG04bDlCR1U2ZGpIUGNxSE9kcStjRE5UZlFGbWE0K3hZczRjMkpRSWs3WFRm?=
 =?utf-8?B?K0djN0VTOUppQXM0UnVKVUl5OEVHZ1Q3OWdzU29mTUJhUWt5bGc4WHl0ZEx5?=
 =?utf-8?B?Z1dtRmwrVVZMRDBXenA1bzRLYVlYYVNkRHdnVXVIc0gvUEZxc05ieHloeTBJ?=
 =?utf-8?B?cWtJNGJYOTN6TVkxMUU5MEpRY2t2aDE1bjVSQlZ4NHZoQ0hJWm84bm12Mk41?=
 =?utf-8?Q?TrnBU7aIB684Eq6NBu0+MWNlE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536a52cb-8a81-4525-0573-08dbb9d84123
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 12:51:06.1249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfKzkgtwV/BUf5RbriWDR+yul8PlSap88MlGJlv/TmnieFjXTXH0V6Zifg52xrLA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8040
Received-SPF: softfail client-ip=40.107.95.63; envelope-from=jgg@nvidia.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 20, 2023 at 02:19:42PM +0200, Cédric Le Goater wrote:
> On 9/20/23 05:42, Duan, Zhenzhong wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Cédric Le Goater <clg@redhat.com>
> > > Sent: Wednesday, September 20, 2023 1:08 AM
> > > Subject: Re: [PATCH v1 15/22] Add iommufd configure option
> > > 
> > > On 8/30/23 12:37, Zhenzhong Duan wrote:
> > > > This adds "--enable-iommufd/--disable-iommufd" to enable or disable
> > > > iommufd support, enabled by default.
> > > 
> > > Why would someone want to disable support at compile time ? It might
> > 
> > For those users who only want to support legacy container feature?
> > Let me know if you still prefer to drop this patch, I'm fine with that.
> 
> I think it is too early.
> 
> > > have been useful for dev but now QEMU should self-adjust at runtime
> > > depending only on the host capabilities AFAIUI. Am I missing something ?
> > 
> > IOMMUFD doesn't support all features of legacy container, so QEMU
> > doesn't self-adjust at runtime by checking if host supports IOMMUFD.
> > We need to specify it explicitly to use IOMMUFD as below:
> > 
> >      -object iommufd,id=iommufd0
> >      -device vfio-pci,host=0000:02:00.0,iommufd=iommufd0
> 
> OK. I am not sure this is the correct interface yet. At first glance,
> I wouldn't introduce a new object for a simple backend depending on a
> kernel interface. I would tend to prefer a "iommu-something" property
> of the vfio-pci device with string values: "legacy", "iommufd", "default"
> and define the various interfaces (the ops you proposed) for each
> depending on the user preference and the capabilities of the host and
> possibly the device.

I think the idea came from Alex? The major point is to be able to have
libvirt open /dev/iommufd and FD pass it into qemu and then share that
single FD across all VFIOs. qemu will typically not be able to
self-open /dev/iommufd as it is root-only.

So the object is not exactly for the backend, the object is for the
file descriptor.

Adding a legacy/iommufd option to the vfio-pci device string doesn't
address these needs.

Jason

