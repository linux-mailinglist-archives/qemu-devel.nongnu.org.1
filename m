Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6497E7E44
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 18:42:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1VVu-0006SN-M2; Fri, 10 Nov 2023 12:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1r1VVs-0006QJ-Ii
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 12:41:48 -0500
Received: from mail-cwxgbr01on2134.outbound.protection.outlook.com
 ([40.107.121.134] helo=GBR01-CWX-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1r1VVq-0005HY-L5
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 12:41:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/pgP4UMGUW/z9Yij2nzDAEC3Eik7Kbm7Boh0I0w8LxHswjLRMv0p4hNlW5dTIzL9FB55U8vpEPDXV4aQjqpWpID7xPj1Pi1dHEu1uNNltdC8xd1wnamn/xzcnGB/2sXoJvbj3OvZLs14uAI3GBkvTsmX5jISpKxTeZyDIiTQr6k1Lxa3CgYLWrUkhkkgl+V58b/i26vN8yjm4qvZANQ2nWytJBa6jmlPWvnPHTwLyChusa8uyPz08SpaT9EUHalGEAZraoXBzgVYhY0S6RrGAFcDX0IoPZGi9IZJl3sLH7TvYzlpoQZ58Kvb7Z82dnYmwq0ainMLholWM37htRBGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fu8X6yd4SgVmUCOhFux9sIK3VmJdvtPu1ODysqOVCRk=;
 b=Jb2m0nW+51YZ8gx4woG/t8jcUqhrEnt1CqapLbrscrIzcBbesLyD95pG+f1CqmVT5h68f1hxPIkgJktKuVgPVlUCTqBckMGvv4FQoSr5GFU8humIWLnvaliuFl191yzVAxXmmEGtGQQq7rBYz9PBXTDOi11XJUX3goDyF+vkWI3tZWSoU0UD1HJ6MPPRg/F7bywFD2BV4oo55DM2tm6t+MlKycvLcwnBTlts3h4Ec3HDDscmUSWfUB5OPFuNBA7LTcXCmvRmBYtdIPk7FmT5kQBO0btKo2qAkzaVRqvE3Ig5ienopGr+FcfZiWTj5yvILfakNSIfLbMn5txXq6G36w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rapitasystems.com; dmarc=pass action=none
 header.from=rapitasystems.com; dkim=pass header.d=rapitasystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rapitasystems.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fu8X6yd4SgVmUCOhFux9sIK3VmJdvtPu1ODysqOVCRk=;
 b=fbMkC4LJSVajCxZjnLeh6yEe5QVIwtAkejmsefU2kX8rKuCaqJkbjeaMOKclQD7fYGG9H1OlnjIl4jHehsvk8YnleoD6zAVIkLW+lTtrvse56C8OZUTePrdARp1C6WiThrYo0wtVDOftRd0x3iNvOlPL+/iJl+LMNRFcRkePDAw=
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:d8::10)
 by CWXP123MB2854.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:30::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 17:36:41 +0000
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e732:bfe0:f22b:d2c0]) by CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e732:bfe0:f22b:d2c0%4]) with mapi id 15.20.6977.019; Fri, 10 Nov 2023
 17:36:41 +0000
From: Greg Manning <gmanning@rapitasystems.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/1] plugins: Move the windows linking function to qemu
Thread-Topic: [PATCH v2 1/1] plugins: Move the windows linking function to qemu
Thread-Index: AQHaEu7BBO+sdjBdeEioJxiIh9khErBz0Ow9
Date: Fri, 10 Nov 2023 17:36:41 +0000
Message-ID: <CWXP123MB43413EFD75E3292155EBAA0DD7AEA@CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM>
References: <20231109092554.1253-1-gmanning@rapitasystems.com>
 <20231109092554.1253-2-gmanning@rapitasystems.com>
In-Reply-To: <20231109092554.1253-2-gmanning@rapitasystems.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rapitasystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWXP123MB4341:EE_|CWXP123MB2854:EE_
x-ms-office365-filtering-correlation-id: 89e6064c-8b92-4bd3-57ca-08dbe21399c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cfOBpaV+9gkxZcP5Tfo3CIRTGmKxKYafsp1poywife02XtmM89rn5HtH2rt9LIvTdb8RcKSwrFlgudAfepEELSjCtcX7Bb6ZhuGYT4GzJFTVslXxxXqXR0P4RZiIFREio5vg2ab2xHlDEjtDUjLExT2Xr3j9a4cDuaAAosJVspELt+VjsCw6X+RizzKvPIfQUpxx3gNqgSjCMK1/OISdHcPqNki8BsyqK1aL1yuFtj5uRMgIFngwl+q9VqRNAnw1MK20n9apP4v+7SQhX2+OY1NdwxhrGUmI41rAincCILMIVGc4t6gErZ7ZI81+QKIXhNkOkbVfFRCnd/IBvT6FDLnaiPSNFMJR0TtgCvJRsiW5Gpn0jefBo2KuKJwVPsq5QK+ZLmEPCfD1EBNo/itzis1iIUfihhQnuMdprOiBxC0YUFn930qkNFDLCkSnNxPunhR/BrDr3KWJHO6w2uS38gZMUV6y+i7QdK0elGgXdyWC4/OuU0T8qAF2Zbep65woYsHf5sx5yShtARGiqCc3PQInrpPjJsBxD/d6qpWilnIHoFTBfl35mad5oSVTzZ+tA4gjXkbgkeCjNPt/nbLRA/yDF0EJypeEmlQ4MIKE4ImQ0M/S+rU7FoP7hNt30mxf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(366004)(39840400004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(55016003)(9686003)(478600001)(71200400001)(7696005)(6506007)(33656002)(66476007)(38100700002)(86362001)(122000001)(66446008)(316002)(5660300002)(41300700001)(6916009)(76116006)(54906003)(66556008)(91956017)(83380400001)(64756008)(26005)(2906002)(38070700009)(4326008)(66946007)(19627235002)(8676002)(52536014)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?f9b5K66Atgr92u82itE+MYXKdzbRp5JCZOQqtT2KKTWHuvRexipC0Wx6yp?=
 =?iso-8859-1?Q?xtcSr7V+OCyGAuln2wDoNrRT0t/R+ube+vefQv1sNN2jzQcbjz6LMaddF3?=
 =?iso-8859-1?Q?bBS1zv7pByUToea3rWWSzzqjLo6MHDPWJ3pmoVtz5ICm+nA+HnP9bpyh1p?=
 =?iso-8859-1?Q?srmPzbqY+SjuDJGHZq2rwIQ+nZ3aJYMdtFSidKH+Nh/qEOGV6QXk9At1rd?=
 =?iso-8859-1?Q?MiNUuYpjaIY/DiHtAuZpCdTa6Qq8nrcjCY+0LfLpgzCUbMes8S78vzrrCN?=
 =?iso-8859-1?Q?x8TMfLuWB56YNHUIW88KOQYQSK6MBfNkoZDkasaLsISv/dG7dQD797KhN4?=
 =?iso-8859-1?Q?s/U93MK3tLIqoqsxTlOrg+RErehbZVyB3sHRrOSsED7jGbN8Tm0ATd9MAT?=
 =?iso-8859-1?Q?pZTjxoiu0KSiE19fmSyu+5I9yhBwngt0jNpjP89Hw5lU2N2eQWVSHl8wdR?=
 =?iso-8859-1?Q?5Q2PT9AyujcPBEneP7NS3xhCV1BF0JZWhDsCpqUJfPEUdnfzFAPCeu0Lys?=
 =?iso-8859-1?Q?qw8vOtrGNOI6PN7h33rxd7J+EwyiuxTtTAAIzJThtw11esbAR1vlnXEpKA?=
 =?iso-8859-1?Q?ONVo3CamAZRarMNRcTVNWartLjVbnCxjF3GwkK30PZhXQdyPkTMhBHaTa/?=
 =?iso-8859-1?Q?66y31JjyvGecIfl3klOSmyl17WNDA+7bJe00vLVof1NYCXPL3EE4QxeepX?=
 =?iso-8859-1?Q?SYG6srQ5KNs51DxaoQ9n9DGU8ZfIC56BUQxrJImFydBxOSszeXPmYdM8U3?=
 =?iso-8859-1?Q?TUbQsgBvJN1QSPVARCeGufHpiAhjDnkBfmUSwyGNqczGlyYTzKHu2OoTSy?=
 =?iso-8859-1?Q?OnARJcJI+9eQg3g2NOymojrLca0DbxD/eRb9f4bkaYpbMsdz5HoIKfcjqW?=
 =?iso-8859-1?Q?FB9RSN3TbQ/xhLe6R9180rUyepHjh20bQnpMaa7rK5/DHxqdAWRrPfqup9?=
 =?iso-8859-1?Q?cw83xVBlEFGhk6oHqhg2k9ovY/UTT0wMT9qOIwmRU1v3dP7bHp1+8zj4EI?=
 =?iso-8859-1?Q?VP7j9bbuJF7u2N4fbaJ3Fk82gRyPU4EFQ3O2B1HfrkjemMJScTQjxpQqKS?=
 =?iso-8859-1?Q?Cj5zUZddhy9/uYoSN6gjIg9KcBLV/eJrc7psNLKEKMNXtXFnd48fwNCfQI?=
 =?iso-8859-1?Q?5TlNyCaWtcNHk2BzQfo+g9lAZmeE3ZJ/Er9G8oZyTqwfRA3Beklq1BXTfp?=
 =?iso-8859-1?Q?85335ISjCQA30r8vgJVJNEP0orJR4P8JW7pmKTXNG+5bEvphGHEoVryuGt?=
 =?iso-8859-1?Q?XsIX4q8iZujKOvswle/gehX832KeMxPFIuIgxOIHxs7ifCgVw04qYal3Y+?=
 =?iso-8859-1?Q?FPLFg+KD/6Ou1aCabZwHxhxFS+DyjWNbb+pxAkuMQBTJU+dAlB4BYtcuBS?=
 =?iso-8859-1?Q?wtMe69dXyRPax+nfGTkl3MuiOLjn7JFvcF40Mj3g5p5kFyXiQE9pit1fEC?=
 =?iso-8859-1?Q?8pa/Axc6unWvUlnYbC/MOT73PQshi9E/gzTx+9scK1kpxAwquLYc2e4ja8?=
 =?iso-8859-1?Q?2QBJeSRPnCye3BkERLyNOFZ7OQM7Rs4cRDBY4hVDzo+LNehjKVC+tOWTH8?=
 =?iso-8859-1?Q?DPRKZUZKZgKNzFSOQMJUWMTZzLElaMf3Zej7Ssqlgd5/02Cslkgzb7CgB+?=
 =?iso-8859-1?Q?75RhO0hlLNJnLFBzt2YtvpBT43E8gSVKBf?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: rapitasystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e6064c-8b92-4bd3-57ca-08dbe21399c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 17:36:41.4524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 63a1ab10-c4bd-4b99-881c-0040cec74971
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MzwnJZiUEZO4b4MFs3IX1R9rScl9Kn4TU2zW+/pN+ABDuQ0TN6moX2qPmyNuPbiMxnisbWOjAOcpTFnhF/7QaMd/4/gzYcVhf0B9wChc9Zs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB2854
Received-SPF: pass client-ip=40.107.121.134;
 envelope-from=gmanning@rapitasystems.com;
 helo=GBR01-CWX-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

> Previously, a plugin author needed an implementation of the=0A=
> __pfnDliFailureHook2 or __pfnDliNotifyHook2 hook in the plugin. Now all=
=0A=
> they need is a null exported pointer with the right name (as in=0A=
> win32_linker.c). If QEMU finds this, it will set it to the hook=0A=
> function, which has now moved into qemu (os-win32.c).=0A=
=0A=
I have a new idea for this. We've made the qemu_plugin_api.lib file which =
=0A=
is a delaylib with all the symbol names of all the api functions, so window=
s=0A=
can do the whole delay-linking thing. We could also put into that archive=
=0A=
the object win32_linker.o:=0A=
=0A=
ar -q qemu_plugin.api.lib ../whatever/win32_linker.o=0A=
=0A=
Then hopefully when a plugin links to this, it gets the __pfnDliFailureHook=
2=0A=
symbol defined and set up and everything would work. Except gcc strips=0A=
out any unreferenced symbols from static libs when linking. So the plugin=
=0A=
would have to be linked thusly:=0A=
=0A=
gcc -shared -o my_plugin.dll -Wl,-u,__pfnDliFailureHook2 my_plugin.o qemu_p=
lugin_api.lib=0A=
=0A=
But no other qemu-fiddling-with-things or extra code in plugins required.=
=0A=
=0A=
Hmm. Feels like half a solution. I wonder if there's a way to mark symbols =
as =0A=
"always required despite what dead code analysis says".=0A=
=0A=
Greg.=0A=

