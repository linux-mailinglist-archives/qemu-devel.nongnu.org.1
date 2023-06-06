Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1787C724BF2
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 20:57:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6br5-0007Lq-T3; Tue, 06 Jun 2023 14:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q6br3-0007Lf-O2
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 14:56:30 -0400
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com
 ([40.107.237.42] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q6bqy-0007LE-Vw
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 14:56:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=He2DE3ij/gx7LHwqRNzlLvEv7NXSeWOWaAEHbZAt0AuH/iM4N/Pf4pWWPCa4J5PnhOx5cHkLXdqKMWtYWogm46KmrT3HXyFYbWzDZ+u/nbGB4h4fNCOV/hJp/6V/bnmgyeC6IvK1fJPU1MKXMgtgrpa9n0qDIvAEfeQWYmxWP6xOFrYPtcjMDl2FodOrpcpIFPw7cafo42puGTwyMHdJNvSW8XZoUAnq19u5La12hOGO7Nh+dWh81Gy+/RqBoozo4vxyZJKxeKhIUKLQMge4SNvxphxDMvTfUTIm2TxbnwKohAGIU36QQcn6zKmSbB0WuHWsnvTvWr1aikEsZIMeDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i79WmenRt8lBF+KhZpbbVaO6JSQPp0QmM0qqBedwsrk=;
 b=ZwKk9qpeQjax3ZWCxSawAPwHhq1dYg/w3K8AR8yLAmFbAo49Njg/gR7UbsOrQuB5jkAmjw/pNP9BhanPmkStvIGhywsdJ+7yST8QAkcpLmHmNgJzFEwu6lHrMeoL4/l/iZASar3vwYtSwUiZoPeukOkqvOGUyr7dbki1VGrEoI+llzkb2urFpB81E6z4bjWp9hw4S+vxjg/axff7OBeEHzBCOAzLykKT9FaPCSluElizK9uuGsWhhbuKC9bu0hKEMTqK06GcKzYhxoPDiFM0yErYuf5NNldvaxhS3EcZODCSTUkC4YctQxu7i3aEUV08KCP3abx7/TR88vbvSbO34w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i79WmenRt8lBF+KhZpbbVaO6JSQPp0QmM0qqBedwsrk=;
 b=Ix6TmZuG85Iw2+TxWlUQiW83wq/xGXxv7AmODf5uOqrDscP/gU8n6NF1IpamCRYZHjt7SKFR3ouGXm3sHF0dKXJ8MW3Nm1OiCZAdCGg/9o0giLbi7p2oEyE1veNcwRGcZSZIaBtwc2OcckLxTIwLXZ7+QGAJuQwmFCEyYg4/hTM=
Received: from MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14)
 by PH0PR12MB7958.namprd12.prod.outlook.com (2603:10b6:510:285::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 18:51:16 +0000
Received: from MN2PR12MB4408.namprd12.prod.outlook.com
 ([fe80::61d6:7feb:e8e8:bc4]) by MN2PR12MB4408.namprd12.prod.outlook.com
 ([fe80::61d6:7feb:e8e8:bc4%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 18:51:16 +0000
From: "Garhwal, Vikram" <vikram.garhwal@amd.com>
To: Richard Henderson <richard.henderson@linaro.org>, Stefano Stabellini
 <sstabellini@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PULL v3 0/10] xenpvh3-tag
Thread-Topic: [PULL v3 0/10] xenpvh3-tag
Thread-Index: AQHZfVQEb+gdQNQpaUqlKAn9LFRpXK9ILFOAgAFotwCAABVhgIA0qRpp
Date: Tue, 6 Jun 2023 18:51:16 +0000
Message-ID: <MN2PR12MB440877291659B9B55ADC0CF79F52A@MN2PR12MB4408.namprd12.prod.outlook.com>
References: <alpine.DEB.2.22.394.2305021708010.974517@ubuntu-linux-20-04-desktop>
 <a01d5ddf-b6b3-7fc7-daef-44debf48ca77@linaro.org>
 <1f6b3666-fc7e-083a-50fb-b2e91ac2c012@amd.com>
 <dd7325e0-7db1-3b1f-7ce1-319aa58ebd1f@linaro.org>
In-Reply-To: <dd7325e0-7db1-3b1f-7ce1-319aa58ebd1f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4408:EE_|PH0PR12MB7958:EE_
x-ms-office365-filtering-correlation-id: 92b21f5b-efc9-4e2f-89dd-08db66bf0218
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EMNwl+eEg68yJvmb6JsNvN6nPxFWdSDVeRJPHiziFipk6s4R9/ovoVoMnpenFqxRazIWOsml8g4OAKTRFUV3Z/fcVCpdj8SlY0CbhG0kJ8I8GtkN0AvnbtP1Qd2kmbalqPXqYgNJ83GTcSOH0zOKxb9V0I1+H3XGnLtwLFDYUttctfYa2L/cMrt/IKMHOiwAlECxFpBjS+3+WH+sZ2OPvF428OC11bwSBAHnP+ecxGLq10QCCnAuaTLWetbmB4smU1UuKRhD6zNWW0cnRO3ApGp8S81jaZTA6Vx4d19zEll5A68Q6Q4b/mVrY2SeCcn3s1499BMLuSS/U/Mpp9IISb2803SkqurR5frI+2bySIQrvWXor0IJXvV1Bk3w/icrTCNvaflBvmBW5LDPzbyQvhCJNqjwLIVOkFB5gLVIkAyq7QFgRMJxGmB+1RylqXUAGpblW/MwYRLimZRgloCUZ33tEcTOnLBRyFhouWLH6oSu69mOWE4ib6NZCGVsl22n0dMnL0oaY3ivnD/R/fPkMPv4tByrJnflay8t4ogjrKNOWvXXvktBMc7XJy8EtXWN8SG5iSr+Zu1ttLeAPT/1CKaqQ/7/K7YCrYPUgFZMrYg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4408.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(9686003)(6506007)(26005)(53546011)(966005)(83380400001)(33656002)(122000001)(86362001)(166002)(38070700005)(38100700002)(186003)(55016003)(8676002)(4326008)(41300700001)(110136005)(66446008)(66946007)(478600001)(66476007)(76116006)(91956017)(9326002)(2906002)(316002)(64756008)(8936002)(5660300002)(52536014)(7696005)(71200400001)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?vd5dPNy+Yk0XhwUcnEH9qD0UlojxN6pA/PtQi9zkfTPhAb47Fw5/Bq6t?=
 =?Windows-1252?Q?3ujdstceUg0KLbEfb6k9Mo6scqSud7XboV2xX7bDqdLmIhzKJr+dVs3E?=
 =?Windows-1252?Q?9tXN9sVR/NS2pKzj+ZFaMmyaptUZvFwWgKtsHj+ibNkMhCU0+UvFxFV1?=
 =?Windows-1252?Q?hGGaSjy1yh8jmBEK1bf3C6Hrgw/YFBOACjYGwLKVmFZ/Y+1Rn2hjtxYz?=
 =?Windows-1252?Q?kQCsRAfxLRMXlhfWu792GTUqKmbDdiesyasihHGC80luFH49D7KJHxjY?=
 =?Windows-1252?Q?hht7kt5ULrwT3U3MLf3+fW2Mt6RzzqSfMJz7eOXzESaBrlZ0l6MVevvB?=
 =?Windows-1252?Q?ea+v4/+UJU8bAi5umiwmQ+X35060GtGbk6tLvjgP7HFr3lA6NcGDiRjT?=
 =?Windows-1252?Q?s6NxXBUIrxwRlwnZ03UI6O3gqHpeApoh5Dx06gNkxDMPlvjaNa2nEgaF?=
 =?Windows-1252?Q?JJytz1WQsnBMA5AWWLQkGef/LFC/E2NukV/0e+8fWO3InbeySa8KLT6X?=
 =?Windows-1252?Q?J/xGtqWEAorgar5juWZ6+QGVCGB5W15lY1slyoPyI/t8Iy+gjyBThgYP?=
 =?Windows-1252?Q?OL2tGYbHkFelQ47k0qgnypxxWDmpaOSG/PF7J6FIzFuM+S1ZZdev3BCT?=
 =?Windows-1252?Q?JEO6aStGGM5582+tpKtD81b48oghArHkyuVATujbo+B+i6GRrmyIsqKo?=
 =?Windows-1252?Q?wGupr5A3NKWa2NbCNN1uKG8BHEFs04dH/zLVs1Ou9sIRR3HzDoIAbq25?=
 =?Windows-1252?Q?IuM9GEejrbYWSziKn62hUOgDxa053lRiYwO1kp6j0GpxegcxPtFdcImf?=
 =?Windows-1252?Q?64aL0OmVBohi8VxCLsDbwOvl/pKUTPi8F8EyeLZNZeOuCrs5eJOjj9PO?=
 =?Windows-1252?Q?cMARHwfuQHjnTeA2+JUtcORT0Pn34EumBJRXyPpc33fbAg95oe/GR6Ls?=
 =?Windows-1252?Q?UVM4UN6bk+Q2C0KnFisQjD9O043NNsGibFbw+nLEvNZw6/1qwclLSy22?=
 =?Windows-1252?Q?y2bfJUDrnMzyJir/LJYvnvugS7K2LFLvNvvjfakj54pKBLI/tamAN5YG?=
 =?Windows-1252?Q?9+7zArvkM0fXPBzl2GGUrXG2/wSmd/qbOnZWbEzsRIhnpwrOC5Qpp8wQ?=
 =?Windows-1252?Q?IbyGWFLZGFtDJxOboTGmmHL+sPuzdGCDj/yP8Ym5AdgUJOgElMWNaRl0?=
 =?Windows-1252?Q?iHeq73FeLQOzBUUe3s1DVhI1Joe8kU65mA1lS9KzPcm5S9zPSMkPW8Dn?=
 =?Windows-1252?Q?XB+0anbOcm4ELwaMQNYrZVQWqH0qipnWKyHVWd0Wsy5bT2rm17UqWLCe?=
 =?Windows-1252?Q?Mu9n0i5sMr94JwxXdWhNfciOB/DosHK/8ifT38UDvAlMUdLzrKmK3YRR?=
 =?Windows-1252?Q?3f4w3jppF7u3V3we3kRbB9ouYHzjwflnRws3WTYhpYkcu3wnfTzwrdGR?=
 =?Windows-1252?Q?skGvmp2xrpO5Ejl3KGL5yVh3Meu7D8x6YgvYA/1t7djSFoXVd/MJcQsJ?=
 =?Windows-1252?Q?/X5TIcUFmHAPdZI1Hd+bj4zgMlGlUh8ul47clnhFKikQ8B4TRGVAtumV?=
 =?Windows-1252?Q?Du/AFG+TZyV200mSfm4bMuZqequotcI6D5DIWUtfMDhTallCcUYk0FH6?=
 =?Windows-1252?Q?KTYmwas9nmMnY42oboiEJQwp0hbQ+CT0x3baxg4Ijg5mpJfE+dbjKngY?=
 =?Windows-1252?Q?oIhsl9i/xLv5Sx9VWQZEfuOq9pnyIOrD?=
Content-Type: multipart/alternative;
 boundary="_000_MN2PR12MB440877291659B9B55ADC0CF79F52AMN2PR12MB4408namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4408.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b21f5b-efc9-4e2f-89dd-08db66bf0218
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 18:51:16.2903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XYWaF517vBzqOyeuEONPloxRFd0x+6aLLQ35uu1oNULySuLqiajidBFWeeEXBCGhmoB/ulaoRDOOyazXwvg+aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958
Received-SPF: softfail client-ip=40.107.237.42;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--_000_MN2PR12MB440877291659B9B55ADC0CF79F52AMN2PR12MB4408namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Richard,
I fixed the tsan-build issue but now seeing another issue with =93=97disabl=
e-tcg=94 option for cross builds xen. Here is the build failure message:
"include/tcg/oversized-guest.h:10:10: fatal error: tcg-target-reg-bits.h: N=
o such file or directory
10 | #include "tcg-target-reg-bits.h=94


Full log for build fail: https://gitlab.com/Vikram.garhwal/qemu-ioreq/-/job=
s/4416773231.
This is my last patch which enables xen build for ARM: https://gitlab.com/V=
ikram.garhwal/qemu-ioreq/-/commit/6f6667217bfc14ff5504ee5fdee23a948d60fb7f.

This seems something missing in disable-tcg config for ARM builds. Any hint=
s on what might be causing this TCG issue?

Thanks in advance for your help!

Regards,
Vikram


From: Richard Henderson <richard.henderson@linaro.org>
Date: Wednesday, May 3, 2023 at 11:35 PM
To: Garhwal, Vikram <vikram.garhwal@amd.com>, Stefano Stabellini <sstabelli=
ni@kernel.org>, peter.maydell@linaro.org <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Subject: Re: [PULL v3 0/10] xenpvh3-tag
On 5/4/23 06:18, Vikram Garhwal wrote:
> Hi Richard,
>
> On 5/3/23 12:47 AM, Richard Henderson wrote:
>> On 5/3/23 01:12, Stefano Stabellini wrote:
>>> Hi Peter,
>>>
>>> Vikram fixed the gitlab test problem, so now all the tests should
>>> succeed. There were no changes to the QEMU code. I am resending the pul=
l
>>> request (I rebased it on staging, no conflicts.)
>>>
>>> For reference this was the previous pull request:
>>> https://marc.info/?l=3Dqemu-devel&m=3D167641819725964
>>>
>>> Cheers,
>>>
>>> Stefano
>>>
>>>
>>> The following changes since commit 4ebc33f3f3b656ebf62112daca6aa0f8019b=
4891:
>>>
>>>    Merge tag 'pull-tcg-20230502-2' of https://gitlab.com/rth7680/qemu i=
nto staging
>>> (2023-05-02 21:18:45 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://gitlab.com/sstabellini/qemu xenpvh3-tag
>>>
>>> for you to fetch changes up to bc618c54318cbc2fcb9decf9d4c193cc336a0dbc=
:
>>>
>>>    meson.build: enable xenpv machine build for ARM (2023-05-02 17:04:54=
 -0700)
>>>
>>> ----------------------------------------------------------------
>>> Stefano Stabellini (5):
>>>        hw/i386/xen/xen-hvm: move x86-specific fields out of XenIOState
>>>        xen-hvm: reorganize xen-hvm and move common function to xen-hvm-=
common
>>>        include/hw/xen/xen_common: return error from xen_create_ioreq_se=
rver
>>>        hw/xen/xen-hvm-common: skip ioreq creation on ioreq registration=
 failure
>>>        meson.build: do not set have_xen_pci_passthrough for aarch64 tar=
gets
>>>
>>> Vikram Garhwal (5):
>>>        hw/i386/xen/: move xen-mapcache.c to hw/xen/
>>>        hw/i386/xen: rearrange xen_hvm_init_pc
>>>        hw/xen/xen-hvm-common: Use g_new and error_report
>>>        hw/arm: introduce xenpvh machine
>>>        meson.build: enable xenpv machine build for ARM
>>
>> Errors in CI:
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/4216392008#L2381
>>
>> ../hw/i386/xen/xen-hvm.c:303:9: error: implicit declaration of function =
'error_report'
>> is invalid in C99 [-Werror,-Wimplicit-function-declaration]
>>         error_report("relocate_memory %lu pages from GFN %"HWADDR_PRIx
> Thanks for notifying this. I am not sure why this particular build is fai=
ling.
> error_report() is defined in "|qemu/error-report.h" and the header should=
 be included as
> |||it builds fine for other configs.

You removed qemu/error-report.h in

     xen-hvm: reorganize xen-hvm and move common function to xen-hvm-common

within this patch set.


r~

--_000_MN2PR12MB440877291659B9B55ADC0CF79F52AMN2PR12MB4408namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hi Richard,<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I fixed the tsan-bu=
ild issue but now seeing another issue with =93=97disable-tcg=94 option for=
 cross builds xen. Here is the build failure message:
<br>
&quot;include/tcg/oversized-guest.h:10:10: fatal error: tcg-target-reg-bits=
.h: No such file or directory<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">10 | #include &quot=
;tcg-target-reg-bits.h=94<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><br>
<br>
Full log for build fail: <a href=3D"https://gitlab.com/Vikram.garhwal/qemu-=
ioreq/-/jobs/4416773231">
https://gitlab.com/Vikram.garhwal/qemu-ioreq/-/jobs/4416773231</a>.<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">This is my last pat=
ch which enables xen build for ARM:
<a href=3D"https://gitlab.com/Vikram.garhwal/qemu-ioreq/-/commit/6f6667217b=
fc14ff5504ee5fdee23a948d60fb7f">
https://gitlab.com/Vikram.garhwal/qemu-ioreq/-/commit/6f6667217bfc14ff5504e=
e5fdee23a948d60fb7f</a>.<br>
<br>
This seems something missing in disable-tcg config for ARM builds. Any hint=
s on what might be causing this TCG issue?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thanks in advance f=
or your help!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Regards,<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Vikram<br>
<br>
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:0in;margin-right:0in;mar=
gin-bottom:12.0pt;margin-left:.5in">
<b><span style=3D"font-size:12.0pt;color:black">From: </span></b><span styl=
e=3D"font-size:12.0pt;color:black">Richard Henderson &lt;richard.henderson@=
linaro.org&gt;<br>
<b>Date: </b>Wednesday, May 3, 2023 at 11:35 PM<br>
<b>To: </b>Garhwal, Vikram &lt;vikram.garhwal@amd.com&gt;, Stefano Stabelli=
ni &lt;sstabellini@kernel.org&gt;, peter.maydell@linaro.org &lt;peter.mayde=
ll@linaro.org&gt;<br>
<b>Cc: </b>qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Subject: </b>Re: [PULL v3 0/10] xenpvh3-tag<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
11.0pt">On 5/4/23 06:18, Vikram Garhwal wrote:<br>
&gt; Hi Richard,<br>
&gt; <br>
&gt; On 5/3/23 12:47 AM, Richard Henderson wrote:<br>
&gt;&gt; On 5/3/23 01:12, Stefano Stabellini wrote:<br>
&gt;&gt;&gt; Hi Peter,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Vikram fixed the gitlab test problem, so now all the tests sho=
uld<br>
&gt;&gt;&gt; succeed. There were no changes to the QEMU code. I am resendin=
g the pull<br>
&gt;&gt;&gt; request (I rebased it on staging, no conflicts.)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; For reference this was the previous pull request:<br>
&gt;&gt;&gt; <a href=3D"https://marc.info/?l=3Dqemu-devel&amp;m=3D167641819=
725964">https://marc.info/?l=3Dqemu-devel&amp;m=3D167641819725964</a><br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Cheers,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Stefano<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The following changes since commit 4ebc33f3f3b656ebf62112daca6=
aa0f8019b4891:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &nbsp;&nbsp; Merge tag 'pull-tcg-20230502-2' of <a href=3D"htt=
ps://gitlab.com/rth7680/qemu">
https://gitlab.com/rth7680/qemu</a> into staging <br>
&gt;&gt;&gt; (2023-05-02 21:18:45 +0100)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; are available in the Git repository at:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &nbsp;&nbsp; <a href=3D"https://gitlab.com/sstabellini/qemu">h=
ttps://gitlab.com/sstabellini/qemu</a> xenpvh3-tag<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; for you to fetch changes up to bc618c54318cbc2fcb9decf9d4c193c=
c336a0dbc:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &nbsp;&nbsp; meson.build: enable xenpv machine build for ARM (=
2023-05-02 17:04:54 -0700)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; --------------------------------------------------------------=
--<br>
&gt;&gt;&gt; Stefano Stabellini (5):<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw/i386/xen/xen-hvm: move=
 x86-specific fields out of XenIOState<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xen-hvm: reorganize xen-h=
vm and move common function to xen-hvm-common<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; include/hw/xen/xen_common=
: return error from xen_create_ioreq_server<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw/xen/xen-hvm-common: sk=
ip ioreq creation on ioreq registration failure<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; meson.build: do not set h=
ave_xen_pci_passthrough for aarch64 targets<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Vikram Garhwal (5):<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw/i386/xen/: move xen-ma=
pcache.c to hw/xen/<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw/i386/xen: rearrange xe=
n_hvm_init_pc<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw/xen/xen-hvm-common: Us=
e g_new and error_report<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw/arm: introduce xenpvh =
machine<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; meson.build: enable xenpv=
 machine build for ARM<br>
&gt;&gt;<br>
&gt;&gt; Errors in CI:<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/4216392008#=
L2381">https://gitlab.com/qemu-project/qemu/-/jobs/4216392008#L2381</a><br>
&gt;&gt;<br>
&gt;&gt; ../hw/i386/xen/xen-hvm.c:303:9: error: implicit declaration of fun=
ction 'error_report'
<br>
&gt;&gt; is invalid in C99 [-Werror,-Wimplicit-function-declaration]<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_report(&quot;relo=
cate_memory %lu pages from GFN %&quot;HWADDR_PRIx<br>
&gt; Thanks for notifying this. I am not sure why this particular build is =
failing. <br>
&gt; error_report() is defined in &quot;|qemu/error-report.h&quot; and the =
header should be included as
<br>
&gt; |||it builds fine for other configs.<br>
<br>
You removed qemu/error-report.h in<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; xen-hvm: reorganize xen-hvm and move common functi=
on to xen-hvm-common<br>
<br>
within this patch set.<br>
<br>
<br>
r~<o:p></o:p></span></p>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB440877291659B9B55ADC0CF79F52AMN2PR12MB4408namp_--

