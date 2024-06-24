Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DB6915041
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jun 2024 16:43:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLktZ-0005Df-Pn; Mon, 24 Jun 2024 10:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sLktW-0005DC-Vb
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 10:42:10 -0400
Received: from mx22.baidu.com ([220.181.50.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sLktU-0007pK-1t
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 10:42:10 -0400
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "imammedo@redhat.com"
 <imammedo@redhat.com>
Subject: Re: [PATCH 1/1] hw/i386/acpi-build: add OSHP method support for SHPC
 driver load
Thread-Topic: [PATCH 1/1] hw/i386/acpi-build: add OSHP method support for SHPC
 driver load
Thread-Index: AQHaxkSBL8TNAxRJokSQEfxysWw53g==
Date: Mon, 24 Jun 2024 14:40:48 +0000
Message-ID: <a048130a668d44aa955599fc5c5e84cf@baidu.com>
References: <20240624131426.77231-1-gaoshiyuan@baidu.com>
 <20240624091745-mutt-send-email-mst@kernel.org>
 <a15cb952e03845b684f5211d75dfb4ff@baidu.com>,
 <20240624094556-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240624094556-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.157.49.59]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.11
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=220.181.50.185; envelope-from=gaoshiyuan@baidu.com;
 helo=baidu.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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
Reply-to:  "Gao,Shiyuan" <gaoshiyuan@baidu.com>
From:  "Gao,Shiyuan" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

> > > > +static Aml *build_oshp_method(void)
> > > > +{
> > > > +=A0 =A0 Aml *method;
> > > > +
> > > > +=A0 =A0 /*
> > > > +=A0 =A0 =A0* Request control of SHPC hotplug via OSHP method,
> > > > +=A0 =A0 =A0* no need parameter and return value in acpi_pcihp.
> > > > +=A0 =A0 =A0*/
> > >
> > > Quote spec and earliest version documenting this, please.
> >
> > I cann't find document describe this, only find in the kernel code
> > and describe it in the commit message.
>
> Hrrm you really should read the spec not just go by the fact things
> happen to work.=A0 Look up PCI Firmware Specification


Thanks and I will quote it.=

