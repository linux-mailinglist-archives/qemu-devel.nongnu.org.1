Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 053EC7D7C21
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 07:18:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvskX-00018L-LE; Thu, 26 Oct 2023 01:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qvskK-00010Q-90
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 01:17:33 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qvskH-0003Ca-Eu
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 01:17:27 -0400
Received: from [192.168.13.88]
 (ppp118-210-136-142.adl-adc-lon-bras33.tpg.internode.on.net
 [118.210.136.142])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C379220174;
 Thu, 26 Oct 2023 13:17:09 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1698297433;
 bh=RxSHpIL9+GPsscpy12l/3v5ATdsE/2ye8USPTnJnKp0=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=ffdHQ0N+gGThJP9S2hW5hh1ij4P7DsDpKRJAcZZHn28689iEeJPupQfjRoE6LwUgK
 VrRCwxrb1pWZL4fNPy0PlmXfqml01W1LfFbFRDmcHR85fQHTHjxATRP/gs7/0G37mK
 c99JG5I4pUCWJ8qb4FXjZFszZbDhn5qN/fDjc+NGmZZUpXiwbaTcM55LnUTZYyQcx2
 LJiw3rUVDLP9jpZnOP9RdOl5c4M8k2eR2v9IJveqE0SB8eeVNdMxKrAbvHjZL2lfnu
 lm++Iww4EHIaOmIJuNlo3EzdhZLRZ9C61lTbVT8K2P8EM86GHqJRR/CNcwgHwmV35x
 2EIzu1PXejZIw==
Message-ID: <184dad276f060c72db1227b7de6ae9368b078531.camel@codeconstruct.com.au>
Subject: Re: [PATCH] eeprom_at24c: Model 8-bit data addressing for 16-bit
 devices
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Klaus Jensen <its@irrelevant.dk>, =?ISO-8859-1?Q?C=E9dric?= Le Goater
 <clg@kaod.org>
Cc: qemu-devel@nongnu.org, peter@pjd.dev, joel@jms.id.au, cminyard@mvista.com
Date: Thu, 26 Oct 2023 15:47:08 +1030
In-Reply-To: <ZTjeZ6LB96yaiW3l@cormorant.local>
References: <20230921034816.320655-1-andrew@codeconstruct.com.au>
 <f5e6727c-887c-4533-a5df-db1a57318870@kaod.org>
 <ZTjeZ6LB96yaiW3l@cormorant.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
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

On Wed, 2023-10-25 at 11:22 +0200, Klaus Jensen wrote:
> On Oct 25 11:14, C=C3=A9dric Le Goater wrote:
> > It seems that the "at24c-eeprom" model doesn't have a maintainer. Until
> > this is sorted out, may be this change could go through the NVMe queue
> > since it is related.
> >=20
>=20
> I can, but I'm not that confident on determining if we choose to
> implement this behavior broadly. I have no qualms, but someone who works
> more with embedded stuff might?

What are the feelings on putting the behaviour behind a flag? We could
add it as a property that we can set, e.g. when defining a machine.

Andrew

