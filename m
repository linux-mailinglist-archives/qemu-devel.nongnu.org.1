Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 367777B6DB3
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 17:59:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnhnf-0005ac-QA; Tue, 03 Oct 2023 11:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qnhnd-0005Zq-5S; Tue, 03 Oct 2023 11:59:05 -0400
Received: from mail-bn7nam10on2060e.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::60e]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qnhna-0006fl-OY; Tue, 03 Oct 2023 11:59:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geGl8728fFyNyngkoKXBkFCzLinAFTv/Yrd3eXihz/WjJkOwLoexIYA7V/vuq9VswPeNk8qbtW1ZM/u/2yaomrFUi6pmkheTzuO1eKPxnTj5u2GFFZrgaas0w3pyvqZgN261hrofH0RBKCD4O0+nOf5Eh3IQNsK1R2j++9tWshQTI3q0yVVq6J23kknzsXoWlu8XvpYoSqyqTzRaT6U88n7c60O1CoWckzyaWIQcrw3ydV4SydQwDo0bZG6ZbesWShMsV8DwhI03V1QHUk8sR+bBA8mh3t1r4cXS6NTOpcFQVhTCqWtXgy/y8kI7lMh9n3S72AwKfOwKnxzW43v2Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnqq4PrnqiR8pMjfFxiLJRfYGon6YhDSPYW4gVMT59s=;
 b=UBHLmkuUp7w8XWBj3jfaP+wX3M3XT95wSAPIEVKD3W5WVIVii9t2mZpyI2wrzMXRYBx51l4jHfGUOWuCSCoeFeWwp2c8lLmqYlXieo78rdyGzlbG6Vsje8StT/652Un7BLAZ9mc+3kMoDI7TMZ+vxqcF8tP/WQcxNezNtBGNkntRmkR9qySwv8j4rh9ZhMWzAAJjKN4RBod4NTtJ2C5Aww6ZkGW+33ByXMNXAwsCgYnnG9fBemgmlkZTHavI4k6gbzqHy8x+JfhXKbS+nn14jHj6sML/aZkVdosIv+hxe5a5tdKCokchky3DWuTDx5FvlW4OK367IOl8/B2NJ6t/2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnqq4PrnqiR8pMjfFxiLJRfYGon6YhDSPYW4gVMT59s=;
 b=C/DM+BO1ftqbYm70erPdVeb6KRmu544R4KGkaBO7WZc48S6xLKnDFdsLxYwhNrKB5vcfFZgC27OTS3Lt+WcVSWD6+PfaLGp7Wem/3Sap+3yB+wqlxejaIEmKPFPfqGLB6vcX8NCSeQbVmH3NMje+Ro3jKeNniJs5xePsC4CJraE=
Received: from BL0PR12MB4882.namprd12.prod.outlook.com (2603:10b6:208:1c3::10)
 by SA1PR12MB8842.namprd12.prod.outlook.com (2603:10b6:806:378::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 15:58:56 +0000
Received: from BL0PR12MB4882.namprd12.prod.outlook.com
 ([fe80::fb9f:5469:4cab:3ba1]) by BL0PR12MB4882.namprd12.prod.outlook.com
 ([fe80::fb9f:5469:4cab:3ba1%7]) with mapi id 15.20.6838.030; Tue, 3 Oct 2023
 15:58:56 +0000
From: "Ho, Tong" <tong.ho@amd.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alistair@alistair23.me"
 <alistair@alistair23.me>, "edgar.iglesias@gmail.com"
 <edgar.iglesias@gmail.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: Re: [PATCH] xlnx-bbram: hw/nvram: Remove deprecated device reset
Thread-Topic: [PATCH] xlnx-bbram: hw/nvram: Remove deprecated device reset
Thread-Index: AQHZ9bnNnbGFcZkNhUCWq1jBV4/0irA3mLcAgACftA8=
Date: Tue, 3 Oct 2023 15:58:56 +0000
Message-ID: <BL0PR12MB4882C4BA07C3068A3B7521A5E6C4A@BL0PR12MB4882.namprd12.prod.outlook.com>
References: <20231003052345.199725-1-tong.ho@amd.com>
 <06cd7690-adb6-e9ff-abf7-21c8c05efc2c@linaro.org>
In-Reply-To: <06cd7690-adb6-e9ff-abf7-21c8c05efc2c@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4882:EE_|SA1PR12MB8842:EE_
x-ms-office365-filtering-correlation-id: 3aac1bee-4e97-455f-bec5-08dbc429a642
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fz1KczkLL3OeCcpsm4mdsDmkuHIFPalwHvcH0KRoLeRWNugR1mwpjb+1WCKngP6sYt6LISAH8mhjwbvC2OkWfHb/v/riO9wNGKFNqzRkaXWRbCdHQQEyyFqVQOtd4Z3/hPbA1gbwfQzF4esZImt6eE04wMLHmgB6TfDmuxIS4TMlbtT1K9H04VQiThzqbTOQVwolmjoFj3ApQzzTMlf+VXOeJG6ZYR/VJWJvtZC4h3c2MsUjMf54N8588fY8HTYgiUTa7vEOcE3PYhAv8XPJYFIBfF3V/1cnvH/v1t4lmJIWgCJSsPXEsTMujZSLdLZ/jIpFvBvdX8YO6rI4PNZ1NCaKrvslqkFqg3GWcT3osIXOuvBIZg4IVG3NpQ2ODgtpr7G9DIFMEZ/2WZtIeaboLd7AJgY85SxMZ167XzP38TuAGzYpeD6FD7uA8WMTL/J1gk00IfXxTxqGjWv68INfu4bbdHhpd+cOPi9MJdz6AH/k5xfRzNZbOsi41D3D2vIEKZQcRX6pIrZmVFUyarnkB3GFrIiUUpuvkwyl+ZYifPXCr6cjXzibIwi7I9Bvwl6Tk+SgaGDqbq4MF/N2/7VSPtNBCjHlBl/YrGu9V1+puz5wQHfsf+eNA7KmHckcv3pA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4882.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(19627405001)(4326008)(33656002)(86362001)(8676002)(83380400001)(52536014)(5660300002)(26005)(7696005)(71200400001)(53546011)(122000001)(6506007)(9686003)(8936002)(55016003)(38100700002)(38070700005)(316002)(2906002)(110136005)(478600001)(91956017)(66946007)(54906003)(66446008)(66476007)(66556008)(41300700001)(76116006)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QXvrrIDxsRyvVtdkuuwFv8l8LYH+6+Weahp9qu6NYFHuofY2urDlBn5OaR?=
 =?iso-8859-1?Q?B1cDwvS4gqfAoL3Lrgce3rRSbx/q/9bRDjq81szeK0soIpJfdOEgf0yJrK?=
 =?iso-8859-1?Q?XFXIvrep4kpQV/eSHDuSw7CnJFxRf5qR0DwbJj+cnE8RXShMrr3IJcmB5e?=
 =?iso-8859-1?Q?K2rXUaPGQoIzWq9FNsqIlDf/RXoDSzG3LQxOHj9Y1q54Il8w9o+CD0Lbup?=
 =?iso-8859-1?Q?dL26k5qkqgMVqnmyQ1b4b1K5PATcgcrN/tb6UmcaqUxwUni32vErHZW3Pl?=
 =?iso-8859-1?Q?W5mqXDtrY0BT6aCnRQYGsOkFS0oSMCW7AZFClCoABHP60B1YEqh3hp8oO4?=
 =?iso-8859-1?Q?KQtTmS9hCHeGRfoFEwYKYi5runSoak9j0iPmicKv2NS8obAlsWKMX3q0WZ?=
 =?iso-8859-1?Q?zcRL5WK/88yFXglgNu3mc2/wi9BdCZuHXCKCySR1O6E44TtqGS05q8YE8Z?=
 =?iso-8859-1?Q?YjXOZkLI++e6UoRtMuhCkEtwfHcKWF4HFjDsmfqBZgmiATRAJCN2NB1wmr?=
 =?iso-8859-1?Q?bSk4GJlg/iE/mLO7sv1neJBB3c6CEepmuVKB/pqmfz/yAqo5iBXo8fzs1/?=
 =?iso-8859-1?Q?j0QoZK1tjoHpIyykx3ZQaZf8u+5gWB8uWI/LrObbtqy386MxcqjMw15s5v?=
 =?iso-8859-1?Q?xyfYHGO2mvM/a/w+W+O/7Zap7xLy4RfsdB/75uu18KX5d/afgPVDvob7vR?=
 =?iso-8859-1?Q?T5PLeDYKLfJGNHHLXIOzgmmqTTo+TwC+HGY7jO6dnAHMQz1DXxO56qq6dk?=
 =?iso-8859-1?Q?NmIyYmYjRlRW7y9iRwCWqlK32ukUkzRGCsvIcmNPKruYhGADUz8Bry7KRE?=
 =?iso-8859-1?Q?uGEcqU1OEsPeDbvMI2jl6qPmOe7ERYIZQcod89TkH3GHYTBa3278Nvtlyz?=
 =?iso-8859-1?Q?1CoBBbh9mHf/E70s9DeLzPtBwYdwUNGqj91y99Jnw7yWU7yS17sEEoazZy?=
 =?iso-8859-1?Q?TejmcTA2wPWgHAr0lZkVHeHJ57nd6ee19UtIQ71uFpF6ZlEkxAULYS6xoO?=
 =?iso-8859-1?Q?T8vCTQEkMq5mBf2OX0DyQy98Hw/khMjQfwoabmrKTYNT8fQ/4okGDJQSZv?=
 =?iso-8859-1?Q?GXD1Bj1BobTXv+bJBWhIuiWVce4rT0RK+2MgJaAXfyn3dK5B9Xspp0fuy+?=
 =?iso-8859-1?Q?iGnmeQkqTqt0784qI0KMvtCqRrUNlz5KIsqgaiLX/Yh0w/crSnDoxa8EFB?=
 =?iso-8859-1?Q?V8BWysyzRAIp7xoC0AviUjtF77TfWSvBpz416MG34xGaIHES+HHdEwqyU0?=
 =?iso-8859-1?Q?G2npBvvpjXqrj6Z+/XiasijCM+LH6tdpgO9ULDJMtaz/RsGPQYl9pkaxY/?=
 =?iso-8859-1?Q?TCT/esVVz7KAHkUA0U/bzLzK6axBsMfq97Xic9qLzjIlgbp9UgoMXU+okw?=
 =?iso-8859-1?Q?wYOyg/9xt9bAzTAIMM3yXEkJS0XZl/tHO4OqjCC6BsOC4z3kiL1GGODsYw?=
 =?iso-8859-1?Q?xB2Q+5tSxYQi9Fc4KufcgT+Z+BP+FcUzcpHfFYkvbJimGtcXcNNNgky8xx?=
 =?iso-8859-1?Q?CBJPlBqpXr0tvVVnlI2daTXMkMihUPx7Q8h1Xi2psFEkBVnDdRomJdKcl4?=
 =?iso-8859-1?Q?rWaSXYC+S6hE0UpY1/BidvC4dAkO1CTsfxrqaApAY19OiywwtQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL0PR12MB4882C4BA07C3068A3B7521A5E6C4ABL0PR12MB4882namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4882.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aac1bee-4e97-455f-bec5-08dbc429a642
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 15:58:56.4880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mBuyYMQK47Nt7Lkv7NLNuQYvzLf1UIOFfkEBf3CVRDZCbmBSEQom17MpEPmJCfd5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8842
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::60e;
 envelope-from=tong.ho@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_PASS=-0.001,
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

--_000_BL0PR12MB4882C4BA07C3068A3B7521A5E6C4ABL0PR12MB4882namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

Thanks for the review.  The rest is in the pipeline.

Regards,
Tong Ho

________________________________
From: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
Sent: Monday, October 2, 2023 11:23 PM
To: Ho, Tong <tong.ho@amd.com>; qemu-arm@nongnu.org <qemu-arm@nongnu.org>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; alistair@alistair23.me <=
alistair@alistair23.me>; edgar.iglesias@gmail.com <edgar.iglesias@gmail.com=
>; peter.maydell@linaro.org <peter.maydell@linaro.org>
Subject: Re: [PATCH] xlnx-bbram: hw/nvram: Remove deprecated device reset

Hi Tong,

On 3/10/23 07:23, Tong Ho wrote:
> This change implements the ResettableClass interface for the device.
>
> Signed-off-by: Tong Ho <tong.ho@amd.com>
> ---
>   hw/nvram/xlnx-bbram.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>

Since you did this one, do you mind updating the other Xilinx devices?

$ git grep -F -- '->reset =3D ' hw/*/*xlnx*
hw/display/xlnx_dp.c:1399:    dc->reset =3D xlnx_dp_reset;
hw/dma/xlnx-zdma.c:827:    dc->reset =3D zdma_reset;
hw/dma/xlnx-zynq-devcfg.c:387:    dc->reset =3D xlnx_zynq_devcfg_reset;
hw/dma/xlnx_csu_dma.c:714:    dc->reset =3D xlnx_csu_dma_reset;
hw/dma/xlnx_dpdma.c:601:    dc->reset =3D xlnx_dpdma_reset;
hw/intc/xlnx-pmu-iomod-intc.c:539:    dc->reset =3D xlnx_pmu_io_intc_reset;
hw/intc/xlnx-zynqmp-ipi.c:362:    dc->reset =3D xlnx_zynqmp_ipi_reset;
hw/misc/xlnx-versal-cfu.c:498:    dc->reset =3D cfu_apb_reset;
hw/nvram/xlnx-bbram.c:526:    dc->reset =3D bbram_ctrl_reset;
hw/nvram/xlnx-versal-efuse-ctrl.c:753:    dc->reset =3D efuse_ctrl_reset;
hw/nvram/xlnx-zynqmp-efuse.c:841:    dc->reset =3D zynqmp_efuse_reset;
hw/rtc/xlnx-zynqmp-rtc.c:258:    dc->reset =3D rtc_reset;
hw/ssi/xlnx-versal-ospi.c:1833:    dc->reset =3D xlnx_versal_ospi_reset;

--_000_BL0PR12MB4882C4BA07C3068A3B7521A5E6C4ABL0PR12MB4882namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi&nbsp;<span style=3D"font-family: &quot;Segoe UI Web (West European)&quot=
;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;H=
elvetica Neue&quot;, sans-serif; display: inline !important; background-col=
or: rgb(255, 255, 255);" class=3D"ContentPasted0">Philippe,</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thanks for the review.&nbsp; The rest is in the pipeline.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Regards,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Tong Ho</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b> Philippe Mathieu=
-Daud=E9 &lt;philmd@linaro.org&gt;<br>
<b>Sent:</b> Monday, October 2, 2023 11:23 PM<br>
<b>To:</b> Ho, Tong &lt;tong.ho@amd.com&gt;; qemu-arm@nongnu.org &lt;qemu-a=
rm@nongnu.org&gt;<br>
<b>Cc:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; alistair@al=
istair23.me &lt;alistair@alistair23.me&gt;; edgar.iglesias@gmail.com &lt;ed=
gar.iglesias@gmail.com&gt;; peter.maydell@linaro.org &lt;peter.maydell@lina=
ro.org&gt;<br>
<b>Subject:</b> Re: [PATCH] xlnx-bbram: hw/nvram: Remove deprecated device =
reset</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Hi Tong,<br>
<br>
On 3/10/23 07:23, Tong Ho wrote:<br>
&gt; This change implements the ResettableClass interface for the device.<b=
r>
&gt; <br>
&gt; Signed-off-by: Tong Ho &lt;tong.ho@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; hw/nvram/xlnx-bbram.c | 8 +++++---<br>
&gt;&nbsp;&nbsp; 1 file changed, 5 insertions(+), 3 deletions(-)<br>
<br>
Reviewed-by: Philippe Mathieu-Daud=E9 &lt;philmd@linaro.org&gt;<br>
<br>
Since you did this one, do you mind updating the other Xilinx devices?<br>
<br>
$ git grep -F -- '-&gt;reset =3D ' hw/*/*xlnx*<br>
hw/display/xlnx_dp.c:1399:&nbsp;&nbsp;&nbsp; dc-&gt;reset =3D xlnx_dp_reset=
;<br>
hw/dma/xlnx-zdma.c:827:&nbsp;&nbsp;&nbsp; dc-&gt;reset =3D zdma_reset;<br>
hw/dma/xlnx-zynq-devcfg.c:387:&nbsp;&nbsp;&nbsp; dc-&gt;reset =3D xlnx_zynq=
_devcfg_reset;<br>
hw/dma/xlnx_csu_dma.c:714:&nbsp;&nbsp;&nbsp; dc-&gt;reset =3D xlnx_csu_dma_=
reset;<br>
hw/dma/xlnx_dpdma.c:601:&nbsp;&nbsp;&nbsp; dc-&gt;reset =3D xlnx_dpdma_rese=
t;<br>
hw/intc/xlnx-pmu-iomod-intc.c:539:&nbsp;&nbsp;&nbsp; dc-&gt;reset =3D xlnx_=
pmu_io_intc_reset;<br>
hw/intc/xlnx-zynqmp-ipi.c:362:&nbsp;&nbsp;&nbsp; dc-&gt;reset =3D xlnx_zynq=
mp_ipi_reset;<br>
hw/misc/xlnx-versal-cfu.c:498:&nbsp;&nbsp;&nbsp; dc-&gt;reset =3D cfu_apb_r=
eset;<br>
hw/nvram/xlnx-bbram.c:526:&nbsp;&nbsp;&nbsp; dc-&gt;reset =3D bbram_ctrl_re=
set;<br>
hw/nvram/xlnx-versal-efuse-ctrl.c:753:&nbsp;&nbsp;&nbsp; dc-&gt;reset =3D e=
fuse_ctrl_reset;<br>
hw/nvram/xlnx-zynqmp-efuse.c:841:&nbsp;&nbsp;&nbsp; dc-&gt;reset =3D zynqmp=
_efuse_reset;<br>
hw/rtc/xlnx-zynqmp-rtc.c:258:&nbsp;&nbsp;&nbsp; dc-&gt;reset =3D rtc_reset;=
<br>
hw/ssi/xlnx-versal-ospi.c:1833:&nbsp;&nbsp;&nbsp; dc-&gt;reset =3D xlnx_ver=
sal_ospi_reset;<br>
</div>
</span></font></div>
</body>
</html>

--_000_BL0PR12MB4882C4BA07C3068A3B7521A5E6C4ABL0PR12MB4882namp_--

