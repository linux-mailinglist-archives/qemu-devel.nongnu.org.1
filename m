Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C251B8AB4E1
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Apr 2024 20:15:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxskO-0006L2-K4; Fri, 19 Apr 2024 14:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregory.price@memverge.com>)
 id 1rxskM-0006KY-8e
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 14:14:02 -0400
Received: from mail-bn8nam12on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2418::700]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregory.price@memverge.com>)
 id 1rxskK-00046U-K6
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 14:14:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4rkvRi5/peCtRdsQdLUZBDevoi80SQyNogPKG/M+4BBmM272Wa1Ev+hxPfFERD5dtHmCsfSagCzcjC1pQ4ewFcyn30SRDxLnIb0RB8Az/522kLOawrcPrc5TR7jSEqIu5JZ/xVxiH+drGp6W+lHCBRMChvjkCzJCKWrC9RN7u6FyIke25qdZi4bJmkKSRbqkyr/f1g1Qndn5PIPABCh26wq1Dd2ZVUZDt2b3QGDLDBuBE2O4D5YsSanCo8kdQosVbObadQRwLKUoZj18VhyrwSrhCLvmIUYk28eBO8JCs/rnNbUInhVzYp41ftA0ogbO/C7SJJjeMQQ7hfQc46iJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLpTNxv58ZflsCHI+lE6yzVtfTfAnfaPCl4xbAg4riE=;
 b=iaFX1J7n9IZZxdHZflFWyPekD4PqtWkzn3B5qgiKyBS+3KKxww9pxV/IOgZRokAUa1JnGsGrgQIF/Y6+PN1nMmaN5CqvQSZ7EjJOf/GPWZoNCjTYKFArFIhaGchi0227mu67oW/r5EtxOy1fLwotlHzqxJtU6Ghi2YqoFr1G6DyZNCVrFwEoi62ZdXMjGTqgQ8cSM1XLbMeYyXm1XCAW/BBAZUqOikm4RxekGy0RKcBGOh6cRUQDGsYkfWsyVIWIqHakwkb6VXzY6tbhZt/qJycQZ9avUfyvALlrAvUZhgYcEIS2t+y/+8RKJHuSNiCUjNgh0rtzp51CrGa+/HVcgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLpTNxv58ZflsCHI+lE6yzVtfTfAnfaPCl4xbAg4riE=;
 b=Gbry/kA7E5IWU2P6Gx/v005tf3owmuqbl5zaSon4K21L4hm/vIXbfMRWAAj+h7m0gDLt+EDdcYP+yPMEGv3cBpYTEC1IAFGNUuajOr8/GkYtrjIPU2ZhJCwCGSy2Syc3ofqBuKCgj4ujCxqzj4nCSBpHV3BM9hJMPtyIZNrRqe8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DM6PR17MB4044.namprd17.prod.outlook.com (2603:10b6:5:250::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 18:13:56 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 18:13:56 +0000
Date: Fri, 19 Apr 2024 14:13:53 -0400
From: Gregory Price <gregory.price@memverge.com>
To: nifan.cxl@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org, ira.weiny@intel.com,
 dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
 Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <ZiK0YcbduQ+ShCEh@memverge.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-10-fan.ni@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418232902.583744-10-fan.ni@samsung.com>
X-ClientProxiedBy: SJ0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::35) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DM6PR17MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: cf44366d-c7b4-4349-2085-08dc609c7a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rkC0kzG1KMPSDS9R9dQqa0OQz6sEHk0ZsAaATMg8SJNYaDGMiDmhOm7OxfuP?=
 =?us-ascii?Q?Tqo/kXdvYxeIbqfv/Ic30CloAgUNThBZyXdjKNAeHa2YAgzel7Nc4WWTp2+c?=
 =?us-ascii?Q?C4eh0ek9uv5Xcq+MYHJ5rb5NzEtrnu3pRP4xyZMEdpJB6BinoxCTWKkZNtV5?=
 =?us-ascii?Q?wEsiS9TTcmiKnVQJD+ojq2rmBdlfvHoqwTuP5PvEu9RZYeXiahbNBk5R0Ugq?=
 =?us-ascii?Q?58eKc+p4Akfhi35hoD8lZBYNmNJ+PhmKuC0Bwcng/QYE/QDg+pfEvXBbc6Hg?=
 =?us-ascii?Q?+/pVxgx1aAUsxR/BL7d/j0LkO/RNZcwhRnwHUKX5TCvpFohopFOVwKgDRk/u?=
 =?us-ascii?Q?aSJ4nFwg+5bXudjfyzgaHHj7wf266PJRNOG7Z7Ih3r2HTt4ES4w1+f4s+qfC?=
 =?us-ascii?Q?eh+pda30ZN+AyKrDSKI5D+7QyDVNq7PqPqziapLsIQDM1eDAZMSdrlCUeVOM?=
 =?us-ascii?Q?PCF5ybSlHzsBsf7xgC6z9ArCkuk3t6aa7+1K0P6wTXKiID9UC5+rY24oAgpF?=
 =?us-ascii?Q?jTxXKUrS7uwNijgavd9uPqQAgUo+M0yQQ1f8a8Ik63O2cxgBRTVqaBzj1TpV?=
 =?us-ascii?Q?dw6MWnkNOhQIrdV9+skvRa8125POI0GCHkjCA7XaW5B5mhGnfXVm5QVJgK22?=
 =?us-ascii?Q?i0Hl25h0kfyjo88uSy+cdKiVN2FqWyP+CLn7yR+oOlPQXRaNYGORwriImETK?=
 =?us-ascii?Q?6iYK7SlQoWbWlBLmN0EANkbvzc/Hx0Y1YsYv9S/lR3fUI7R0BalKxfWCHp7f?=
 =?us-ascii?Q?WEtJ6Q/VeLjBNFd0dPfmlWjCoy4d/KjJLcqnU0ZXT49MPoe7rpgL4cuwikie?=
 =?us-ascii?Q?MWZFtopEkgwOQOGZD41x4HpvKSIjOyjia3VZRP/R82Fb1Zl8V+soIacs0OT4?=
 =?us-ascii?Q?1fvrlVoALPT+sun2UaXM/CsB2uTplg0vG0LkTYdmSdNx62k2KQfGKGhHbg29?=
 =?us-ascii?Q?zBJjxRlkUW0OcFstW6S0K2zz2i4YAVUiyB8mRYGXw4iz15/7bWOoOHsO3f7+?=
 =?us-ascii?Q?MDpAGm1Zc3rJoSC6SuIfnFizpdDuHkjBxvvxmhrFMLZQY2mmMdU8xQMOpJ1K?=
 =?us-ascii?Q?whmq8gf5hZytE6PU/FIPndk6Yk5Ha4OrwRiSjSMumb4S2dtxBXiETrw02jj6?=
 =?us-ascii?Q?yMJNOwYC2PFjgFzV9x0JEVxD5uraLRHERvZOEhA3ElZCEcj/amrQQ3Jl6Bt3?=
 =?us-ascii?Q?oFH+cNErLyUXbO4cBXD5L5qotG9GOXrDH+1/3LeLAjwDDg9DFE++3YDfKX2s?=
 =?us-ascii?Q?tlgJT0nijRAvax6A3bbMODwDfk1c23c96kCpBrnUNg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR17MB5512.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(7416005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z1b7im0CpnMPaHkje52uBd0GqgnteEIdmQzGBMyrx+ZgBrzj75ZAVe1v8H4l?=
 =?us-ascii?Q?hB50n6trQQwEZO/B/ayC1jvBsXJ0MIgNEB3fswiII1djErwwXh9nJYXpevPZ?=
 =?us-ascii?Q?J1u4Iw9ysn2iLONw2Hfn4Enfx9n6aytmbchrSC9tdLKtde6+huiv33UOmA0e?=
 =?us-ascii?Q?b1bUyvQ1xCeC9iPQyeIMJC3R+9ZGzaHWQlWYaR+7JxJ5y1Iv2kI1SHUtai/t?=
 =?us-ascii?Q?NlP/dvqm1TOwru8U9avA4KGrf0CZ5QirBv8C4VG5LMVhVpjFTsQGVoB1z2xP?=
 =?us-ascii?Q?enIP3uPkMp9aKFCFyKvyGcbycmHOrlXYQazrAI1iH3r3z8oVeTeLGkUihgS6?=
 =?us-ascii?Q?/F93GwRoIVGFTPqYFSCr2mus79qxVCf13lPY0HcQ1v6m9Eu3zR1fgLR0QFdI?=
 =?us-ascii?Q?TONW9qUXgOxtAHvRw7QcDjaoqr99Yqp1wYiOzunLqmQMC/l5aHI1rdFxgq0k?=
 =?us-ascii?Q?pYywisYt/v7v4gjufFQXnduJB8IfJWoZBGmfwVJ2mb0rdbPrhfHfdL0u40Vh?=
 =?us-ascii?Q?oE4weGoi8JbF6K507DD7XIJSwoid9giMXf3gbkt047LbE5pRNy6z6jJPoi8i?=
 =?us-ascii?Q?8AXtOFaNep4hvgIPI8EKjl+j9v+9JTxCAEvPCd+4SveYwyjqiXh5WWGFrP/k?=
 =?us-ascii?Q?W2iKNvw8yacarujE6qipOLMDZjtFYuPSWBX07pl9IHG2UBfVIwQ9OEfl/gme?=
 =?us-ascii?Q?GZcbaFvBKVdCaT64I4R4B5uiJf96lSRwmBwaWJa3vFnZqDgT+cWNKGh8Lzs8?=
 =?us-ascii?Q?AU/mQRWjDkYJNKyHj4CtZ/sHXKNs8/jsZFgP0BI5y8sEuKage+qsf2IDvmUy?=
 =?us-ascii?Q?PiCe0RgjcxOISp1tU+10Qr0F7lQZei1T61z9ZGQvv3A2W1/j1FvPUI+0GmZu?=
 =?us-ascii?Q?jAiPlMERDkkxfviVT3TSx2XKkXr8RgXR5cqHEuU21l+YAKL6OAaF9F1Jn0pX?=
 =?us-ascii?Q?FgeqqZQLcq475chI6Ld9XGSAq7ElL1guK25DPVdX4FiH3ovuIsANdr7pik58?=
 =?us-ascii?Q?c9gvbTjjvTpAQqHEQUi8LBnvd96Vb98qdqspPOetYp8v6QmPN9yAVZvNVOq1?=
 =?us-ascii?Q?8Gnejw6yc/b83bt/4K/etAW7zHXEW08QzaT+q3nqdm+9hDVmcU4O8IwG7RjT?=
 =?us-ascii?Q?aLrBcR0mAoTfKTQ3iVOffjX/yB8ViKI+QPmN+rV4aPK3VS0JUroyfunBT576?=
 =?us-ascii?Q?oEvomjUtwJ250wXQb9qa9NjgtgNwyREbz4P/O0oDfTEUr/C+UWDfDFKKKUkH?=
 =?us-ascii?Q?Sfpgcn7UTQw9ZxfFJ5zJnk3TY6Dx19eUVA+7YIYTFjKtwzSUQGiwBHbsQnxO?=
 =?us-ascii?Q?FIgYt4MC0irmqyuNqH0yUo0wpA2xbxZABzv2zOM5nC1Jrz2Y7EW8NUtARVId?=
 =?us-ascii?Q?vCHGesx5nKyIx4utTkrFNJ/7MWO5DuVlHaoRUJFIyfVTvdYJMWtYAWR9RKID?=
 =?us-ascii?Q?eQnmoMOcVIJzc6ZviINdyTNt193RQtB0ba/xEpvctR9QmZ/FypbqKdyOKFce?=
 =?us-ascii?Q?TocwV53SLTUw+ZVakDxwpl6UJMIWOUA87ug9DXm8N1VhyMDU90RGnyUT3ESd?=
 =?us-ascii?Q?kvmuSezDIX6jQIZQVAXIfkqFTOQxe2tvwgV66q5PC8lpvo3RSipzCJssO1mE?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf44366d-c7b4-4349-2085-08dc609c7a6c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 18:13:56.6391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fl+cbfEwGDlqgKFJB+Zf39QuiNzgH2uk8jhHR4PnxqpW3DUxJfa9VuJ4MCngLuiJknZvRNP775wYPY2n2273wqvrBpvAmHOnYo2wEio/+jA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR17MB4044
Received-SPF: pass client-ip=2a01:111:f403:2418::700;
 envelope-from=gregory.price@memverge.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Thu, Apr 18, 2024 at 04:11:00PM -0700, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> To simulate FM functionalities for initiating Dynamic Capacity Add
> (Opcode 5604h) and Dynamic Capacity Release (Opcode 5605h) as in CXL spec
> r3.1 7.6.7.6.5 and 7.6.7.6.6, we implemented two QMP interfaces to issue
> add/release dynamic capacity extents requests.
> 
> With the change, we allow to release an extent only when its DPA range
> is contained by a single accepted extent in the device. That is to say,
> extent superset release is not supported yet.
> 
...
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  |  62 +++++--
>  hw/mem/cxl_type3.c          | 311 +++++++++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3_stubs.c    |  20 +++
>  include/hw/cxl/cxl_device.h |  22 +++
>  include/hw/cxl/cxl_events.h |  18 +++
>  qapi/cxl.json               |  69 ++++++++
>  6 files changed, 489 insertions(+), 13 deletions(-)
> 

Reviewed-by: Gregory Price <gregory.price@memverge.com>

