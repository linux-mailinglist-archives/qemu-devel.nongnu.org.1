Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CF970CAEF
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 22:26:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1C6h-0005PQ-T1; Mon, 22 May 2023 16:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <siddhartha.punj@intel.com>)
 id 1q1Ax3-0005Fj-OM
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:12:13 -0400
Received: from mga05.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <siddhartha.punj@intel.com>)
 id 1q1Awz-0005Hy-QE
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684782729; x=1716318729;
 h=from:to:subject:date:message-id:mime-version;
 bh=Dd9KYp4LUr6yyPcO95CC+JIAsqpe9qqlM8+J+XcWPAo=;
 b=Qqouqk7X6psZ4GWxGz6NuMEU4klX/l24SLiCY+sOhjz3sJG0ovnlIb+U
 yelw02mAb/wotxUlm6+0+u94yRWUKk7Lr+Z2j5fzbbMYT71BmPb3ZDNzw
 gtjKu1BBm52VV3hbefiJ4C6QF7rgiViZx0q7ChKegG1hMZCIzOoCTJBYq
 4EWgeZGYQXLYkv4MnTk3u6dA4NLT1vNF4gX7Wr0x3AZVPTXfLggrrDkrT
 fdkWi8mOQeu70L+kV9fF/H21jLX5SIeS1tDXBVCPTCKuRoEacvKviET7l
 KsLz1JqntvnPvQc96eZdaJXXmYl5vw5wmC0exDTlZ3PSbX6XSBCNSWaCI A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="439371185"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
 d="scan'208,217";a="439371185"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2023 12:12:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="697747912"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
 d="scan'208,217";a="697747912"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga007.jf.intel.com with ESMTP; 22 May 2023 12:12:03 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 12:12:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 12:12:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 12:12:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 12:12:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbemKv84Atttu8l2g1PfZyfJ/MDnsD4tXsAsO5T+OkSCEV2Zfj06Z0+gsAKB8SWaR5spOQp4FA/NYUP0NJQVPYuHa9l08tNG/YewzddTik0GS5ifoy2wDQaw3tKh9/SRt5BcXOwUTTJd0v7phLfoquHBVFy/zcUyaDVNfhaC6UECP0WGbe5r6XOqrwNvKJ3czYpsXKY8Cw7ssOtFJ8yM4v/FTCnzrCA2SGTt5/d7TIW9BD6fiNX+9+qLCI7prnAGw2u/8gw6UO/gRKLwBABu+TOB5/FcJ6W8o9AoTNHuLn6hg/mj/EgWi2e0tvPXIChZdprIoSqoWcGp4QqYeNnAkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUCvd49BnmojTPYi3DJ3JCbobmShVpRwgEBTylGY9iE=;
 b=jrwfHQgLTfW2tPSmkvtschh9m0q6kius3meOpFw7F778dpc0bxuRJsdZPuLJahOxBL2+bjtp6z2nNJIbBtgrLBlcTSP7pDvAi7lgQVSShD95PR8xfAnf3rtNFGRA5rWqp8a4F2u6HGSxTrYInqgukO5zBc3Pyd86OE1tMMVmkc/hY5/b73OmL0aS9qNuCTFTXHLYG6WCjpNT9DlIaMvChoCFc5BR5pvbbX2QjajtcOnYtyLd8NvEhhFNlEXp6GwpS1NnhVNXz1GDWroe1x0WUOEWY9ZIAuxs9DfUnXoxXD/G//zopTfqgP+PndmT7XLeMv2KOqN3oxyqPLb1u7+ibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7142.namprd11.prod.outlook.com (2603:10b6:510:22e::22)
 by PH0PR11MB7636.namprd11.prod.outlook.com (2603:10b6:510:26f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 19:11:55 +0000
Received: from PH8PR11MB7142.namprd11.prod.outlook.com
 ([fe80::a8d3:958e:258d:309b]) by PH8PR11MB7142.namprd11.prod.outlook.com
 ([fe80::a8d3:958e:258d:309b%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 19:11:55 +0000
From: "Punj, Siddhartha" <siddhartha.punj@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Building QEMU errors
Thread-Topic: Building QEMU errors
Thread-Index: AdmM37rgPD942hM5TX+0v59nyq96pQ==
Date: Mon, 22 May 2023 19:11:55 +0000
Message-ID: <PH8PR11MB714207F8969670F0685FAB30FC439@PH8PR11MB7142.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7142:EE_|PH0PR11MB7636:EE_
x-ms-office365-filtering-correlation-id: fb11826b-6190-4ee5-c986-08db5af86850
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RI1qKx5XjiHzBA8geVKKW+JRatCPo1Qm9IG9GZrgeH4QetXYgqxcLxpPIIHMop8HsqcKy9HAaDXvJM0vQJOoLUCQpnH5N2HBHe+YhRqdT5LmQZQ3rRfgSSIJA9Gk60OiW8IXlZNNdI/1DyFppPw5g4oOdBeFi1ys1JuvYYCSLhUzEn0Ac4agi550lmGVq/Dfc08wUA0iFsoQQ4XpeB9CXHqp2gaN4GWGrEkEg/kdLeD+hSstqQ75kdgGK/BPayQQJ9LgVOFebIilnGNB1FDErdn7qH/PvGGFIj+kYpR3iWaxk+I4rLgEnXqb/UbAVO2IzP/feBdDuKKdqWB1nv56hJZ16+oMyCtG6IRlNPJjo1sjlV0yc2ZQAejoH3339qi+/dcUgHEw6lIjzI4RlU8I5Kr/+B6OtnCrLO/Jdf3TGIrHlwJBbGHCagrruScZW8HPsx1NfbXlzGde5FGiAjH2Mvn/7dApSKY1HoScmes0Ww7CN8wNzGz1+QdVX7wHZER8b0/MYW8/lzywSxy6eInytc3PlGUc2ory3yqwUL2p3AA4HiE54dVFZfL8uqJxL0WI3CfE+EACxArwl3k6GbGDjbO2KRDl9TOfFxxKEmqC7bsWfMMSBJJao3/ca/dzZwNh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7142.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199021)(2906002)(71200400001)(38100700002)(55016003)(122000001)(8676002)(52536014)(6506007)(26005)(83380400001)(186003)(3480700007)(9686003)(8936002)(7116003)(86362001)(33656002)(316002)(41300700001)(5660300002)(966005)(7696005)(6916009)(166002)(82960400001)(38070700005)(66476007)(76116006)(66556008)(66946007)(478600001)(64756008)(66446008)(460985005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B85IxWzkruUTm6O++RgR7wSdpgtiatokIRTA5bT5showKve8EBYloYr3Ostx?=
 =?us-ascii?Q?N1Uvy61xCJh6yDQTHlIRjCodKo++Ze19SUwo0iETWdSh3Cykb3+dy+eNH6J4?=
 =?us-ascii?Q?gBInvAdGKLx4uHYcaOv3xsV7QMCpu21lueNr5Thqy3fxwDDOTrC1138Kxfwo?=
 =?us-ascii?Q?Ro7LeR8DFsGwlJuVCZ16I9JreqbOE2vMpVVAc5JJ9+pxN40EnhFWLs3Rf9v8?=
 =?us-ascii?Q?+1CwVu54pPQTvSq9n1npiB9ivR5+3m9RZWzSZ8ArCuGvrWqZ2Qzmbx/CW0yh?=
 =?us-ascii?Q?uAkhjoHt6wImuMoWl88RjaAmZbthVgBAV0AeaZvrvEmRnw5PXREOQrHisG5f?=
 =?us-ascii?Q?rWi9T2LkDjXxc/TXILIOonfX8toUN+9vG5hXldns1a1B0T9NfbZ9BxXxMmOC?=
 =?us-ascii?Q?KB+STA1UXAOByH5lcR4lM9IS9n2Lip+o4dqaLQNnis2iDDgQvd+9IAo+xOp6?=
 =?us-ascii?Q?Ibvr12kNdr8/6IKA9U2lUJjbnXHy5xDOA/KKtV6C4Pxy9BVOvqTkjYVoi/wL?=
 =?us-ascii?Q?Z5Mn83Z2hW6hKy1iXKL/j1PImBgQ08f8levUneZOlivdpqQTjZM0NWhSPeZd?=
 =?us-ascii?Q?xRNMgZ4hCET39wBbrgOXD7JpqorPd0gGyIAQOvMQhfWVnJ1egBvG8YySXVeG?=
 =?us-ascii?Q?EZghl5+rpHnDYMO/eVkG4ytRyOP9tJZyXJ9CPxOe7gPOZoTCe7kgv38mYSx9?=
 =?us-ascii?Q?W6g+BpEGkvLjQqVdc0//vJV/tkR7FTSHNbMXg88WnOuDEkG2xynJdG4AvY3N?=
 =?us-ascii?Q?c4J1gOuhi9cQ1lND1vsvcpEv+io6wX85Jn8FdepHN9RRfPZMrkpeg3Hyzox7?=
 =?us-ascii?Q?mYzUvYPAW/DvmrDmW7+1cj06+H1CTgMag2+Q+PdGyJAvHX7fzZLPUNMRykDD?=
 =?us-ascii?Q?8zDrtOaJ1VifHxQy2UjPIU/KmW5zT+c2ylSLGFcyYbnprCka8uNr1hUbMOk+?=
 =?us-ascii?Q?oAf0XOW4w5HPx5Q/GstBDW3Aa7pOGfTfOMtwVO/dDwVY1k0+j1ZP7BSS8efr?=
 =?us-ascii?Q?3QlFabgisQZIp+cHWop+tPe31i4V64zVU1pu8HLgHox55Mjxd/IFNfQOUtaw?=
 =?us-ascii?Q?J8YxEoKTgH+PcLxBD8oM+PgQOFQAqUj2MI4x/QYK4rJYbI9gd158OHheyN6w?=
 =?us-ascii?Q?17JyQ8N9aUzvcYa9YyXDcuU6KP7CS/7/oPPQkL3s9ilSp9vPdtJT0TYAFGpQ?=
 =?us-ascii?Q?9dxMHg4kZQ6bUzuNh0CAthui9RDPJ6m4ROVlyn+DdWPjruOBTIkwOC5Wo8+r?=
 =?us-ascii?Q?+uG3bnBXwFdq2XbhwcvRGdbP9sC3KPmZeuznu51frBoPXI0Ewa6P6qQZqSNf?=
 =?us-ascii?Q?VqEq9uijnewHhIGB0E3gbyqSk2dWMzvqngkisr6HRUvi0uxaskfr0MgvLT0r?=
 =?us-ascii?Q?zP8Kc5BOZUlcVHA403osr9SPpQ54Z2Xb0N3lEsV4ympfyOlvXiNL5dPkzy1C?=
 =?us-ascii?Q?1CyNT3ZFFgm/tt7Tq9LKwrYzS294NM5jA492j3TGNBMQuMVF/uMuYetHhQf/?=
 =?us-ascii?Q?oCaV4v2svIlEiKUyYcyjrZor5pVVJ26sLrZOaqZCLwQaNNg2Fv/0ufTaAaHb?=
 =?us-ascii?Q?Xe8AnRwHJwvSxi83On9E0vxq1E1LK6OKKa4IEB3/?=
Content-Type: multipart/alternative;
 boundary="_000_PH8PR11MB714207F8969670F0685FAB30FC439PH8PR11MB7142namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7142.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb11826b-6190-4ee5-c986-08db5af86850
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 19:11:55.1232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jDx/LFvDvjTPvnAKtrpP1PCOABeVCEhQXhc7dhIcNuxF2H3+ApHH0gZ8PNuTCV8Gg/ccGRle+Awm2mb1pfuOHfwy8CJpyXjY0GWfYKF7krU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7636
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.43;
 envelope-from=siddhartha.punj@intel.com; helo=mga05.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 22 May 2023 16:25:51 -0400
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

--_000_PH8PR11MB714207F8969670F0685FAB30FC439PH8PR11MB7142namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi QEMU community,

I'm trying to build QEMU on my development environment on Windows (64 bit, =
windows 10 enterprise), but am facing issues.

I'm using the MSYS2 installer as administrator with the following commands:

pacman -Syu
pacman -Su
pacman -S base-devel mingw-w64-x86_64-toolchain git python ninja
pacman -S mingw-w64-x86_64-glib2 mingw64/mingw/w64-x86_64-gtk3 mingw64/ming=
w-w64-x86_64-SDL2 python-setuptools
closed console

started mingw64
git clone  https://www.gitlab.com/qemu/qemu
cd into qemu
and then ran the following command on MinGW64:


./configure --enable-gtk --enable-sdl --target-list=3Dx86_64-softmmu --disa=
ble-werror --disable-stack-protector --disable-capstone --enable-debug

And I'm getting the following output in my build: ln: failed to create symb=
olic link 'x86_64-softmmu/qemu-system-x86_64.exe': No such file or director=
y

Is this a known issue for QEMU right now that's critical? I'm trying to use=
/modify QEMU to create a virtual PCIe device. Please let me know/how I coul=
d potentially resolve this.

Thanks,

Siddartha

--_000_PH8PR11MB714207F8969670F0685FAB30FC439PH8PR11MB7142namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://sc=
hemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-=
html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Lucida Console";
	panose-1:2 11 6 9 4 5 4 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi QEMU community,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;m trying to build QEMU on my development env=
ironment on Windows (64 bit, windows 10 enterprise), but am facing issues.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;m using the MSYS2 installer as administrator=
 with the following commands: &nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">pacman -Syu<o:p></o:p></p>
<p class=3D"MsoNormal">pacman -Su<o:p></o:p></p>
<p class=3D"MsoNormal">pacman -S base-devel mingw-w64-x86_64-toolchain git =
python ninja
<o:p></o:p></p>
<p class=3D"MsoNormal">pacman -S mingw-w64-x86_64-glib2 mingw64/mingw/w64-x=
86_64-gtk3 mingw64/mingw-w64-x86_64-SDL2 python-setuptools<o:p></o:p></p>
<p class=3D"MsoNormal">closed console<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">started mingw64<o:p></o:p></p>
<p class=3D"MsoNormal">git clone <span style=3D"color:black">&nbsp;</span><=
a href=3D"https://www.gitlab.com/qemu/qemu">https://www.gitlab.com/qemu/qem=
u</a><o:p></o:p></p>
<p class=3D"MsoNormal">cd into qemu<o:p></o:p></p>
<p class=3D"MsoNormal">and then ran the following command on MinGW64:<o:p><=
/o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:0in"><b><span lang=3D"LA" style=3D"font-size:10.0pt;font=
-family:&quot;Courier New&quot;;color:#FF0080">./</span></b><span lang=3D"L=
A" style=3D"font-size:10.0pt;font-family:&quot;Courier New&quot;;color:blac=
k">configure
</span><b><span lang=3D"LA" style=3D"font-size:10.0pt;font-family:&quot;Cou=
rier New&quot;;color:#FF0080">--</span></b><span lang=3D"LA" style=3D"font-=
size:10.0pt;font-family:&quot;Courier New&quot;;color:black">enable-gtk
</span><b><span lang=3D"LA" style=3D"font-size:10.0pt;font-family:&quot;Cou=
rier New&quot;;color:#FF0080">--</span></b><span lang=3D"LA" style=3D"font-=
size:10.0pt;font-family:&quot;Courier New&quot;;color:black">enable-sdl
</span><b><span lang=3D"LA" style=3D"font-size:10.0pt;font-family:&quot;Cou=
rier New&quot;;color:#FF0080">--</span></b><span lang=3D"LA" style=3D"font-=
size:10.0pt;font-family:&quot;Courier New&quot;;color:black">target-list</s=
pan><b><span lang=3D"LA" style=3D"font-size:10.0pt;font-family:&quot;Courie=
r New&quot;;color:#FF0080">=3D</span></b><span lang=3D"LA" style=3D"font-si=
ze:10.0pt;font-family:&quot;Courier New&quot;;color:black">x86_64-softmmu
</span><b><span lang=3D"LA" style=3D"font-size:10.0pt;font-family:&quot;Cou=
rier New&quot;;color:#FF0080">--</span></b><span lang=3D"LA" style=3D"font-=
size:10.0pt;font-family:&quot;Courier New&quot;;color:black">disable-werror
</span><b><span lang=3D"LA" style=3D"font-size:10.0pt;font-family:&quot;Cou=
rier New&quot;;color:#FF0080">--</span></b><span lang=3D"LA" style=3D"font-=
size:10.0pt;font-family:&quot;Courier New&quot;;color:black">disable-stack-=
protector
</span><b><span lang=3D"LA" style=3D"font-size:10.0pt;font-family:&quot;Cou=
rier New&quot;;color:#FF0080">--</span></b><span lang=3D"LA" style=3D"font-=
size:10.0pt;font-family:&quot;Courier New&quot;;color:black">disable-capsto=
ne
</span><b><span lang=3D"LA" style=3D"font-size:10.0pt;font-family:&quot;Cou=
rier New&quot;;color:#FF0080">--</span></b><span lang=3D"LA" style=3D"font-=
size:10.0pt;font-family:&quot;Courier New&quot;;color:black">enable-debug</=
span><span lang=3D"LA" style=3D"font-size:10.0pt;font-family:&quot;Courier =
New&quot;"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">And I&#8217;m getting the following output in my bui=
ld: <span style=3D"font-size:9.0pt;font-family:&quot;Lucida Console&quot;">
ln: failed to create symbolic link 'x86_64-softmmu/qemu-system-x86_64.exe':=
 No such file or directory<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Is this a known issue for QEMU right now that&#8217;=
s critical? I&#8217;m trying to use/modify QEMU to create a virtual PCIe de=
vice. Please let me know/how I could potentially resolve this.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Siddartha<o:p></o:p></p>
</div>
</body>
</html>

--_000_PH8PR11MB714207F8969670F0685FAB30FC439PH8PR11MB7142namp_--

