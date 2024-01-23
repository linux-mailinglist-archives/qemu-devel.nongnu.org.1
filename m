Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDAC838CB2
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 11:59:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSEUs-0005Mz-8j; Tue, 23 Jan 2024 05:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhedde@kalrayinc.com>)
 id 1rSEUq-0005Mj-Me
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:59:12 -0500
Received: from smtpout149.security-mail.net ([85.31.212.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhedde@kalrayinc.com>)
 id 1rSEUo-0002G4-1g
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:59:12 -0500
Received: from localhost (fx409.security-mail.net [127.0.0.1])
 by fx409.security-mail.net (Postfix) with ESMTP id 910E4349A6E
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 11:59:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
 s=sec-sig-email; t=1706007546;
 bh=sptPLiLaLZ+sttdIIzN/pP4WFx7mYmTgzKBj/QXhbOI=;
 h=From:To:CC:Subject:Date;
 b=F4BqJGUcSQDjnVm7m17Ey+C/cANFOqlLNRXzOmMlddswo2auBG/WNzDkEh2poV9cq
 4eRPbjlnxXVEPPk3WCH7l2Mui410Fp9xt4Z3PY95nDORjFndemaKbfD00VOcqjRJau
 q2EP6NDQ5mKBzKbHPm1ulk8qW2dhxFz22/RM0SE8=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 677CC349A63; Tue, 23 Jan
 2024 11:59:06 +0100 (CET)
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
 (mail-mr2fra01on0100.outbound.protection.outlook.com [104.47.25.100]) by
 fx409.security-mail.net (Postfix) with ESMTPS id 2BB1F3493B9; Tue, 23 Jan
 2024 11:59:05 +0100 (CET)
Received: from PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:8::13)
 by PR0P264MB2405.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 10:59:03 +0000
Received: from PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM
 ([fe80::fa4d:17cf:cac:bc9c]) by PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM
 ([fe80::fa4d:17cf:cac:bc9c%6]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 10:59:03 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <10c45.65af9bf9.24f39.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBLAzDiSI881IxYV7kZld/m3Lh+dO51DTQz2erbsSZQSTOeGNTFZ1qiRKYz5K8DU60PdTVs7QHOvJmZVrScgwAr+GaSOWLve4zA8RdP9Zz/mlQNnw9hkeEZcl51oS2Tc8AL1Songr7rvdQ0edyNZaLrVSPYvqz7V3Z14HNfF+Meo2P0BttrM5z1PEQUob5voKVT/SX51WvY4SuFBFYxtjrszAwMcX8zj4OkPzQM77M2OHGo48cPg+E3BZYkWl9ngjtTAEYbPkTi8OEa+Fxjj4VKFMfsNSyRlHKPcwQdcV1hiRAANXwJ+4lDOeuOdy9OyAd5K5BCr3alL47q5sKOb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okgnh4s+OpL0CG4jXWaI1jVl/HWXczLwElVMGxvzx5I=;
 b=Zzy9x93oOxzUeq2iZqva2CsYSbYSC+63Mv+Mz9DXF8volcqqbCMJSdXXE1xN+qScbTmfr8ADle1TlIp+oqa7umylyuUkOx1Z1r7IzmINC1iyEp9sfuHtisodxeXuKhcHgOFDgYTiGVpCYQ+Q3KmrivRN6OHDNoQHbpE3y7/SVjQwW/1ubr6MJj9M9ZvyQn5BSoqh6upLkS+0mzm3fIH8iq0bep539wODlyKAo69/vxt4QCxicbnhmMErDnO01y7+zOvszXiR9BuXQBBRJVR1QMuw+PyO7hw/ZqMKaL66xXgW/OgQamnxrFVr56iGs8ikA6sN0oKrc75+x9/Nw0m1gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okgnh4s+OpL0CG4jXWaI1jVl/HWXczLwElVMGxvzx5I=;
 b=JDz3qHuQLJVfmLlUYmk7t+yXuhH9EkA3BKUOS3RZFxjEETRUNKRdUMxKRfq1TGTUPLZsty+Jta6eFIq4IO5raCgwtTWpCW89wNX6jkyAsQtNObvZAfx3Fb5iQ6Zf9r8vJugk1swsRQs3kA04t/5d3j+LNWgPNefD/7RN6PUbBOuQuinMqZNpOq30W+7ZaJHZG1kHg1xfGNsVyerlymOpIjHtMgtWcDH+EPic5stOrOnNd/0fJi2wvGY3hw3FEnTzEpdAce5RBoCZHJdMNI04HpvVAw1HHhteucV7bS02MLVCtCqPH6stB1lZnh5bwt/ysHclx2RZNIBH/e4XOI4uDg==
From: Damien Hedde <dhedde@kalrayinc.com>
To: qemu-block@nongnu.org, Klaus Jensen <its@irrelevant.dk>, Keith Busch
 <kbusch@kernel.org>
CC: qemu-devel <qemu-devel@nongnu.org>, Titouan Huard
 <thuard@kalrayinc.com>, Hannes Reinecke <hare@suse.de>
Subject: NVME hotplug support ?
Thread-Topic: NVME hotplug support ?
Thread-Index: AQHaTemUKUcWU+peLkKmaBpL1QwG4A==
Date: Tue, 23 Jan 2024 10:59:03 +0000
Message-ID: <PR2P264MB0861AAF89D0B361A33710261D1742@PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-fr
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR2P264MB0861:EE_|PR0P264MB2405:EE_
x-ms-office365-filtering-correlation-id: 448d741c-69c1-46df-6fc1-08dc1c024fde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4r/0ByBRIk+MGRdyRARR1oHBSQsS2am/loh9R2Zq+Qbahjv3tgGrQ86YXoZjduEFN8k8uiJFKB5AyyyNitGkkdBqadkO59A2u4gIT0nUnCYUeZH/0s3JTxOt9Bxp8Nf1MP9Q8N021nKV7PoGaLkC6G/v/zAMsvwIMAxQA5enoRuQQxOfIQI9UV67UcXZ2GoLtVQfUo4vmwnTaXPh965sfoX9/DfD3zzsCN+Qwf2CWXcS3EW4M3++oPLCyFCPBKxD617MVRYIv5hQWq4Ije317uBlLRds8arrF1o7gYJZpWU9/JFItak/gTNd/tI7XsQKa8/juCpvUb2HtxSp/U/dn1+3DcLAg+7guVUDxs24XmZkzN3D01E+rmj6kwAHbizpIEUsq0M2PiKMPae/bzMA/ON69L+gRDU3kpdZVpzCH6vC8rPhf9xtHCpOBhwzmGK+S15jvVnO/FX8Isa/8mRXwyk9orfvEnm1F8yyku/sbB83ozRVctgUkyIlDBGS0lai7VPe0QgVgIi6np/8/25t/FCnGCD/ZkMHRhXmzGw3IT0uED1oDRR2WImB8U4tCNW/rohWeZsx7dbeTpyHTcHwW1C3EoL8yk6hJP7O7AzxyGG5Ft+UevOOW+02qCxpnHEz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39850400004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(83380400001)(55016003)(3480700007)(26005)(4326008)(8936002)(7116003)(52536014)(91956017)(4744005)(66946007)(110136005)(76116006)(5660300002)(66446008)(66476007)(64756008)(54906003)(66556008)(316002)(86362001)(38100700002)(478600001)(2906002)(9686003)(7696005)(6506007)(122000001)(38070700009)(41300700001)(71200400001)(8676002)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: LvF/gg3tWSkHBLK4pAhVUMByg7chVKZ7z4PBcVyx66QWAdJfxXg8jIuv8oJ+nkLqgQxzyQ6ooRXKQMb5XZLFoz3/42lAAHIPa8Xv58QvdvBce4XeDRW/YP8DmP4IDm8479xhB2BF6ffURmo14vcnrv0rZZqYK7N8w+QX93Nb6gE6QkB69yJzGp9ecjBVef+Mg6dScgZcaBQLjB5s7AnwdQMerjHTN1O39A/CneDVOKlJ5jfv6SpocFuHdv2fKegUwp93gMcEnKXpwuSgZUx1Tekw/udxULieEd6fOevQ9mg8vuUfZ6CdFWumHRl2ZZ5DGwuYtRuCohD0Dm2zsipw/42cO1eDq42zfKXW3nc0IeMctisa9D+zxizJvHotNos1lK1qWmpoSrSfAJT8WQJ13z/yzru+aWl6OUGrtkQkN38Ww8OSqBGUcZSmoklBtVKDAILMhjZT829zAilx4BnuLQcRBp7Cv/8gwxk1jY0A+1fq2v/lxs2StCxqefXE2jrCHHeOsFINNV240uI9SjJ4jx8bxzBJK/ibtm9J7SljhHbVoGrrZnDUYDl+ePqIx1wtOgbY2kZBrr6ets/H1cH6xDlCjhX5KXCUmuzzslvM8lBKIxPpK8EcGCi5hREOxV8LIMo/TIiI4yM+tT12KjrmQIFdo7ulpoBZ/aUp+lQljBtVaiCekdumSOSNd0Pl0jR0Zv1EZR3YDQAnZ4XATnz644Mut2Z9QYb2JsTnJ6vQoPt/E5Fmlco2dWg9m971skJAU0KdZ7UOnRez/UwZo/Yc1sRC51t3JnvoIf5JqmQHYQ/nQeRrMvU3M0q7ffWtVpX4yeEvNFP0dGMZrefsK1y2ED4ECIYSt08Hv9DBLqo73sZgX8BRFI/+Eef1VsF+awcrgJj0K/3Pp5AZPlb3oVBWoayV2XA9kcXNcjM/EXd309/vos/zcDCVKuz/IVKSYIg+
 FQl0peIa0rR/2t/z2CV8a7xthDc8uA57+dt/vCoMcw6+YHp4wcIpgWiswLE56i/REOmO9Y/g0MACdJ1qd+f71GH7XCAArucIQeKCiPqpAxGqIflpy7FD9nwuvkeNuHccspm7cs232iQFWI1RezzX1W5mFQWv99y3sHdOMJOe2xpM79R9zmoTFZR/AiTCYukIn27k88IFmefUddpK687WgXpmMBXCxqB10sAS52GPlGnaJqBzFY5Qu++6TIIicOWSo0ly7rk2sBn/5ODz/m6kB7sCPTts8YtP7AGPgsRkJIA0nOkMx+QEmSGBY7yJlDwyAAhyDPrBj4JeOgCAS6RDrsUg9WX3TZeO0bAAAoyAnbGiPWvLujC4E/0niTcZDHoTUch8HhoMBmWmR6JFmjQJTO4mlk9mwFxsTWJSkZf7rjT7dEO9bhHaQgeaneorGTcAbXQ4PebjsU8Wn3KCLLUlnge+kZdCwUV1XUgyxRH/sovCRhnAeajoIRVMv5XbivmexcpKSdGjd7tW1pP8ZsY5IJyNLSXhKZJmjSN7/vUTfQbAayB/WjisyXTUCWlRq3/n5ErAX+msMFvMI9iSrUaEDJNh6iRDuQq+r1nfSyA841KyizUuqTJsRdnKEwUidkjn
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 448d741c-69c1-46df-6fc1-08dc1c024fde
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 10:59:03.4994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YOOigRYZHSG0R1d25fkLDPBzW5TYEd6gJATQq6jFmEQjbWJCS8UNBZpOdPJSHFFUXXXEMMlAV0DsMb0G8ywgbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2405
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
Received-SPF: pass client-ip=85.31.212.149; envelope-from=dhedde@kalrayinc.com;
 helo=smtpout149.security-mail.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi all,

We are currently looking into hotplugging nvme devices and it is currently not possible:
When nvme was introduced 2 years ago, the feature was disabled.
> commit cc6fb6bc506e6c47ed604fcb7b7413dff0b7d845
> Author: Klaus Jensen 
> Date:   Tue Jul 6 10:48:40 2021 +0200
>
>    hw/nvme: mark nvme-subsys non-hotpluggable
>    
>    We currently lack the infrastructure to handle subsystem hotplugging, so
>    disable it.

Do someone know what's lacking or anyone have some tips/idea of what we should develop to add the support ?

Regards,
--
Damien 





