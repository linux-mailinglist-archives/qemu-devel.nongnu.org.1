Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B64D7E8D1F
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 23:24:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1wNu-0002wI-0J; Sat, 11 Nov 2023 17:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+506890241e50857960ff+7384+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1r1wNp-0002ub-SO; Sat, 11 Nov 2023 17:23:17 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+506890241e50857960ff+7384+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1r1wNm-000538-Nm; Sat, 11 Nov 2023 17:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=UFK1vHdO6GzG4Gs6TcxgZqUW3ESxK4rozJ5G7MTQTpQ=; b=rMgNF+RtBaC1yKs30+newQ95tC
 kJ/xfCILtuh4CmmRwfU+lxrK2uW+y2nF5vbK1DZRrPF0v4S/bS2pKqaZAwfP5GeC2e6bTIVxq6khN
 8WZBPALajJa1JpdOQ+jBs4EBQnY3G/EmVFvBKr4ywrPBn/v2lXpOoAsrx5H0Y2c4QwlnlO0kGfoji
 bWjwm1lLYLM5QVt4+/ZxHOfN/bwZgbN3c8+DpGhtGIFmwFENr9BrGM9tU60HZeeUw4TM27qZIGIRX
 wVO5TgXEq8Ze64MCooiSHMfrSbHKdWrMmz2KdNpRSYNRCWciaYSkwZWdwyaLqo7UFu9GVHYOXYd8+
 NL/7jT9A==;
Received: from [31.94.60.97] (helo=[127.0.0.1])
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1r1wNK-004NRt-4A; Sat, 11 Nov 2023 22:22:47 +0000
Date: Sat, 11 Nov 2023 17:22:41 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PATCH v1 1/7] xen-block: Do not write frontend nodes
User-Agent: K-9 Mail for Android
In-Reply-To: <d4eb2378-d276-47eb-a8a2-b3551020f814@citrix.com>
References: <20231110204207.2927514-1-volodymyr_babchuk@epam.com>
 <20231110204207.2927514-2-volodymyr_babchuk@epam.com>
 <f2f7751a9ea5597e9f7a1417b761fe0802892aa8.camel@infradead.org>
 <db50c864-a429-49af-9762-8bc17d5b0336@citrix.com>
 <0F786C80-FB37-4AEB-8314-3DB4AC4600E5@infradead.org>
 <d4eb2378-d276-47eb-a8a2-b3551020f814@citrix.com>
Message-ID: <81BF040F-EE19-4367-9C4F-94FF2623C75B@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+506890241e50857960ff+7384+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11 November 2023 16:51:22 GMT-05:00, Andrew Cooper <andrew=2Ecooper3@cit=
rix=2Ecom> wrote:
>On 11/11/2023 8:18 pm, David Woodhouse wrote:
>> On 11 November 2023 08:43:40 GMT-05:00, Andrew Cooper <andrew=2Ecooper3=
@citrix=2Ecom> wrote:
>>> Furthermore, the control domain doesn't always have the domid of 0=2E
>>>
>>> If qemu wants/needs to make changes like this, the control domain has =
to
>>> arrange for qemu's domain to have appropriate permissions on the nodes=
=2E
>> Right=2E And that's simple enough: if you are running QEMU in a domain =
which doesn't have permission to create the backend directory and/or the fr=
ontend nodes, don't ask it to *create* devices=2E In that case it is only a=
ble to connect as the backend for devices which were created *for* it by th=
e toolstack=2E
>>
>> The criterion used in this patch series should be "did QEMU create this=
 device, or discover it"=2E
>>
>
>Yeah, that sounds like the right approach=2E

I think we want to kill the xen_backend_set_device() function and instead =
set the backend as a property of the XenDevice *before* realizing it=2E


