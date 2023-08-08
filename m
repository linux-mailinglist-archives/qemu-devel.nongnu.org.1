Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1D3773A4A
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 14:53:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTMBu-0007R1-FC; Tue, 08 Aug 2023 08:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qTMBs-0007Qs-QU
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 08:52:00 -0400
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com
 ([40.107.94.52] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qTMBq-0007fY-PQ
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 08:52:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMNdy+FTsBG1kh//AGvoL499y6Fv3rb2cHXlINwB73GVlm2MkdEKjxIlhdkoCLr6vQP5+6KmXd3JMvS9ftH2R/I/p3b+dYGaoHfFDz2fGfVffj0tPvjOqX/I90WpFco+yFzxeTijpcQT6FtaB6d8GFhaGMHqJYj8uacMNjb+9fWlZDr2P+2v1XmecFQVosvlCIFi53EXmcaMlTT3VND2vwUYnoekjDKmItsysRQ47EUKOAjeuEEGb82TR1J9agHjvJpku4e5+LYT4lS62Lajbdb66E7Ms3BQuwlnFezYGnh4v6wjsw2oBR/uMApkBxBwcC0tj1PCaEriIudmr9j18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdojGrloI7YTEjwdMGqbY7pYw92KsaAO3LnaHqs7HIs=;
 b=bmEOywZ4pFuUlk6VJfu+wsMFgT2ls0o0nSqmsfOkItER3YbjRVC+YShImCV1S0bHQP9RcV8CBItjz3Xzo8bjKXcNnxlAqL3z4mUmnaomy3I1vfvprf0DnbN5Sz63ikhHHT7BOxV0LnYpQUxtEE6SKzchxB7+t3QPjOXV2Swi8j6JM5xChfvgidSbb8bhBd2e80exhUTe8HF0zx0O3b7MEfmWfEAKuF/VKXDmQiE5GDU8pws8D+6c7d5N279xp0KvdT4HoHmJ+T1Wv3UXWRnOydlh6gmxSaWgJQ96um7xic3YM+GY32qmrLx/448kvoc9NIH8FYD5xNguK8C/4tw+qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdojGrloI7YTEjwdMGqbY7pYw92KsaAO3LnaHqs7HIs=;
 b=jbNcMVFIKWGQOPkp5glrNhgQCZE070BKCYc/ifGZTjBzya8Sw9QW3S5h7QFzqIkLVFV4aPHDoP+CMtUsa9mTe82Xz5iEhI0oDRyulUf0bsTWPMJTSgDYw1WBQyBwusncngjYyEXRxPK9L6UyZh8V0DCi5axI/rdF0nx/K04Sr/0QYPdncLBWW71o+MUn9v9Uw1gpdR9SdvLml+0s2BeHWIZ0tj+T99eSgnKkkY82vxIsOKZrIz77awPcW2ZH8dlCLfPyMuW0Ul0tiO286X3hF1+fhCQZm1FJ/DaVCA8pN17Qa9MQe5WbHQ7y0eytBIbxhsyKJDaWKBlxJD9RblOHzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 12:46:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 12:46:53 +0000
Date: Tue, 8 Aug 2023 09:46:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH for-8.2 v3 1/6] vfio/migration: Move from STOP_COPY to
 STOP in vfio_save_cleanup()
Message-ID: <ZNI5PG1gtcdGzQI/@nvidia.com>
References: <20230802081449.2528-1-avihaih@nvidia.com>
 <20230802081449.2528-2-avihaih@nvidia.com>
 <cc6d0b1c-036f-00f8-41fb-6ef1c59cafa2@redhat.com>
 <d870e5d4-dd34-6cdc-7586-971928927869@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d870e5d4-dd34-6cdc-7586-971928927869@nvidia.com>
X-ClientProxiedBy: MN2PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:208:d4::42) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB9047:EE_
X-MS-Office365-Filtering-Correlation-Id: 66176e38-2b25-4e2e-f8b0-08db980d8ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XMIUc7TJWv8av1EO1yTLbvx43Ac6ptoD0mNmpn4R1OQOWrJQF1iqx3T5XfCk6CplD3iJ71oWG+KTkihlD79q9a7GJi0NAKxD6ld/oxWNpZ1WBRnQvcqwdmwGN8XS30KngtxdMaYvWRFrdwzvyTSG5bljVSw7/Iel5Z/t/TyOEgJAk8tvBux22hyvJbcuJb76cKns5gU/i8118bH/eYLRHHrxWIK43dHmuhol64f1jiNGyM/MtLjjWV/PUmltiBmLh6AxFla/eYjVomzjuWQIZEdOfWPkMvz812OaiB8UyN3X2E1q6thdC/6Xqs1n9XObPxvR6cvNqM0hiKcVjwXh7pWJIWBXDZiaGi7uuRA2l7HY+N+wObglZDRyv8z4ygoRkBquZTj2XLQFOTvwaaRK7iD/NmhuTOU6agPq91TR0BeMX8W5jm6agiCrQu9A5WGhLnrqTzsp4zhBdRGXOEIHNYRDLwF6fTiyV6WPmKFRT7jpOp+BxGu/ycVkDM4JxYr7ZayqbVG3398ZKrzMjhVXzElP51YjkMTAeTczmTbgxnwmS0vVzd4Mh+wiS7K7BlSF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(186006)(1800799003)(451199021)(2616005)(6486002)(26005)(36756003)(6506007)(53546011)(6512007)(478600001)(38100700002)(37006003)(54906003)(66946007)(66476007)(66556008)(6636002)(4326008)(41300700001)(316002)(66574015)(8936002)(8676002)(5660300002)(6862004)(2906002)(83380400001)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW5zd1l6MVJDZXN4QUk3d2NoWnBlblJMS2tYWXBWdzJVSTc0Q2ZucVRpR2RZ?=
 =?utf-8?B?aE95Z293SU1KcE0waWdNeDZjRXU1dmwybUpnNDFrczFSOWVsUlZRWmlyUlZF?=
 =?utf-8?B?RjJJYStuVURwYkFpQnJwSTBqZ05POTRLUGlUQlFtRERqZVJwMXlxa3gra0R0?=
 =?utf-8?B?aWx6di9sNHpTU2IrYnlQck9IYyt3ZThCcDJDOUpxb09aQk45SzI3MlBkU0hk?=
 =?utf-8?B?RXNjWEp2SkNtckk4V3N1QTF0bytZN1AwL1VYTU14Y0JLeWNiSHY4SURSem1Z?=
 =?utf-8?B?cTF6dXJZMGU1YU5SWGdSWDZrTi9JY2FPU2N4cEN4YUxmVllYNFVxVmlsbnNO?=
 =?utf-8?B?cWxJOWV1UDU4Nm04cnh3cDJRTmhGTUwweUZZNXR2NFB4SDhsbXB6YnhmdUY3?=
 =?utf-8?B?cERVN1lDMGljVFFRYXNSUkl4MjVNSXZLOFc1MnlQcmxKSW5tT1pGTjA5UHJK?=
 =?utf-8?B?L2hYbGw2d3k2LzZsMXlCTHVXSFQrR2xjVXpITXp3TjhEcFFrbWpXRzA3R2xP?=
 =?utf-8?B?d09DZU03TEp2dHFXMDdCc29TalJIaUVTN2Z6Sno3NDFsUlpET25xWFZ5Rkd1?=
 =?utf-8?B?OE5wV1g2R01VeElvZDhGaGhUc0JVcE1YVGM4ZGMyalFRclNnQ3lOZlBrM0VQ?=
 =?utf-8?B?NGdpOG1vd1hRbHpUMDFUQ3Q0K2VsQVlYdGtNTkc3YnJFUERUNitaUXFMSC9Y?=
 =?utf-8?B?RUtMRjFRR0tFMlQ1VnpvMFpWWGJFYmdYZ2JsMS9xNDhNcEZhcG93SVhMMHpZ?=
 =?utf-8?B?S2RwWU1DQU5lN2pnb0NORlZ5ajF5dG5MOVMvNXMyaXNmQWZhUm1XaUorWkly?=
 =?utf-8?B?djN4UVNGK2h0OE1iR3B4V1hLaktNajVDZkxjeDRYdDBXTlRiSnN2aytDMm1J?=
 =?utf-8?B?SVdDTWtlTWhMUzBWbzRud1JVaWxid2JRMlhTa1RDQlBqc2hEdnF1SHVCMXdI?=
 =?utf-8?B?S2g5K3c4b2JZZzkrVVRLYnRqOTJjQ0FsaWU0Z0tOcERwSExyTDdEK3B6dFRq?=
 =?utf-8?B?NEo1enBvYVhiVC9LVWticDNkaW4xQW9HK1hMd3lJUk01MTNCK2lLTkw0bi9H?=
 =?utf-8?B?cTMyRTlJZkM2bm81RWtueS9vWHd1Nnh3dE1EbUhFdmxHSlJ6VFBzK1BtTytm?=
 =?utf-8?B?UHJVMjB5eWZOc0xaNGVwMVROd3crY3M5RUdFSlNTenRFNDkzK3VGVnM5MTJM?=
 =?utf-8?B?N25HQUt1VUg5VXlPSmxVZVN2bkhHYy9SMWpDWUxyZnRoOTc3UGVGZlM1UkhD?=
 =?utf-8?B?aGt5ZlBocTEwWDBKVEwyNEwzR1NKdDVNUXBoVysxaFY3M3ZrdXh4aTh1YkRG?=
 =?utf-8?B?MmZPMnU3bnAvOGFQZDNnMmVidGJWbVJxWVpndWVhQjlFZThGclRIYnhMczhO?=
 =?utf-8?B?WXZCUUNZY1RvTTNnMHRtakw3SUo2b3BDZEYwS1FEdHVKREttbUxVZUpzTnZj?=
 =?utf-8?B?S1VObjBteXBFZUV3YWo4c2FIam5tTDQ1bElDU3dma0p2Y1hrdHp6RHJvbCtr?=
 =?utf-8?B?ek5ZcWtOd2xCck5CczBsRjU2R3psOHFNbVhNbzhHbUFWcWJaYVJDZmg0Wko0?=
 =?utf-8?B?Um4rSEprZ1ZReWh2dHQxZXdIZm1qZTFkd1ZHZ3E3MlVlTno2UmF5ZGYrTVd3?=
 =?utf-8?B?N29WdGt4ai9TallIekpFVkM1QWNxVGxXK2cvWWxQRTdGUWY2MXYxSHRqZlB1?=
 =?utf-8?B?eEZLVy9CTXhHV29uMDBvQVNGTjNURk5ZT3FIMVJTc3dSb1JjYmc2VFpxWFpM?=
 =?utf-8?B?dWNyWGkvbWdLL3Q4MGZiN08xYmtzVGVCaDA4cmFyb1RNdElzeE4zRmNrenFh?=
 =?utf-8?B?bWxMU0ZER0NhYnhSRjJxempsWFRFa3dPQlFmeHlxaVpXWTIzNk9RWHFnLzh4?=
 =?utf-8?B?NTlhTnNrUWhLbVBjTHN4UG5oRS9COUhRYjNlQmlJOWFZa1JHL0VJdngxQTdY?=
 =?utf-8?B?MFJFM0pGaEdPODZTTGxENmVhVjA2MHRQWnpoUmZuZ2NSSUN4UlhmdVpxOGtk?=
 =?utf-8?B?ckdJYVJmTDlyb2c5aUJIRUVCNFhqVFE3VDlXZ2NkMTJsejdsZThjT3J4a0dr?=
 =?utf-8?B?dDFpdTgxbG1KVGZNa0VIdEllN2tLZkpXY2wwWmd3MGhpeVFITDlWTVV5RUdx?=
 =?utf-8?Q?rTamQDHYnurKkPj42KN8ZahfR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66176e38-2b25-4e2e-f8b0-08db980d8ad8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 12:46:53.5938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAlRou9mYw44rbGAEKyQk94M/lhG3MZWPAWrfZ8Qi0OLyieEsLZ7/wnVfRBYTkMk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047
Received-SPF: softfail client-ip=40.107.94.52; envelope-from=jgg@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

On Tue, Aug 08, 2023 at 09:23:09AM +0300, Avihai Horon wrote:
> 
> On 07/08/2023 18:53, Cédric Le Goater wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > [ Adding Juan and Peter for their awareness ]
> > 
> > On 8/2/23 10:14, Avihai Horon wrote:
> > > Changing the device state from STOP_COPY to STOP can take time as the
> > > device may need to free resources and do other operations as part of the
> > > transition. Currently, this is done in vfio_save_complete_precopy() and
> > > therefore it is counted in the migration downtime.
> > > 
> > > To avoid this, change the device state from STOP_COPY to STOP in
> > > vfio_save_cleanup(), which is called after migration has completed and
> > > thus is not part of migration downtime.
> > 
> > What bothers me is that this looks like a device specific optimization
> 
> True, currently it helps mlx5, but this change is based on the assumption
> that, in general, VFIO devices are likely to free resources when
> transitioning from STOP_COPY to STOP.
> So I think this is a good change to have in any case.

Yes, I agree with this idea. Kernel drivers should be designed to take
advantage of things like this and defer time consuming work to the
stop arc.

> > and we are loosing the error part.
> 
> I don't think we lose the error part.
> AFAIU, the crucial part is transitioning to STOP_COPY and sending the final
> data.
> If that's done successfully, then migration is successful.

Yes.

> The STOP_COPY->STOP transition is done as part of the cleanup flow, after
> the migration is completed -- i.e., failure in it does not affect the
> success of migration.
> Further more, if there is an error in the STOP_COPY->STOP transition, then
> it's reported by vfio_migration_set_state().

If STOP_COPY->STOP fails then the migration should succeed anyhow and
qemu has to FLR the VFIO device to recover it. This probably only
matters if the migration is aborted for some other reason and qemu has
to resume the VM. It will not be able to restore the device to running
until it has been FLRd.

However, qemu can probably ignore this error and eventually if it
tries to go to RUNNING the kernel will report failure and it can do
the FLR at that point. Otherwise on the migration success path qemu
should simply close the VFIO device.

Jason

