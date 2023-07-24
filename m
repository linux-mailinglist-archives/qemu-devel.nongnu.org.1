Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A06275EB3B
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 08:07:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNoi9-0001OK-RX; Mon, 24 Jul 2023 02:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <18622748025@163.com>)
 id 1qNoi6-0001O9-R9
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 02:06:23 -0400
Received: from m12.mail.163.com ([220.181.12.197])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <18622748025@163.com>) id 1qNoi2-0008KU-5v
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 02:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version:
 Content-Type; bh=TK6k7sSwbdHK5qN3zJXEZ74KTrlD/6cCPV7m8UT5EFU=;
 b=g/TAgA5uug+HN/kxm2PBOX3UuFA/3/Fmc9oLLkGxj2AuvoEKQXwnTQg52V8tjv
 8PEWpW4W9pgRQ7npUKiSfJ8eYKCYCvVbqBojXlYosZ5Wx946ggirv5NqUoKa1Zkj
 JDDNqlatjDUA+vyhU7cFXcGcNchxFMqmbMRlJUtxUSTUw=
Received: from localhost.localdomain (unknown [211.94.245.77])
 by zwqz-smtp-mta-g1-1 (Coremail) with SMTP id _____wAX157DFL5kEUV8BA--.63836S2;
 Mon, 24 Jul 2023 14:05:55 +0800 (CST)
From: "liguang.zhang" <18622748025@163.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com
Subject: Re: Re: [PATCH] target/riscv: Clearing the CSR values at reset and
 syncing the MPSTATE with the host
Date: Mon, 24 Jul 2023 14:05:00 +0800
Message-ID: <20230724060532.3574-1-18622748025@163.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <CAKmqyKMLU-D6C2BA5LjDjKg_t-xAh9kg+WgmfRxkxDbtujkBBw@mail.gmail.com>
References: <CAKmqyKMLU-D6C2BA5LjDjKg_t-xAh9kg+WgmfRxkxDbtujkBBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAX157DFL5kEUV8BA--.63836S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxhSdUUUUU
X-Originating-IP: [211.94.245.77]
X-CM-SenderInfo: bpryljasxumiisv6il2tof0z/xtbBFQi2WWB9ngKp0QAAsL
Received-SPF: pass client-ip=220.181.12.197; envelope-from=18622748025@163.com;
 helo=m12.mail.163.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_BL=0.01,
 RCVD_IN_MSPIKE_L4=1.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

> On Tue, Jul 18, 2023 at 10:22 PM liguang.zhang <18622748...@163.com> wrote:
> >
> > From: "liguang.zhang" <liguang.zh...@hexintek.com>
> >
> > Fix the guest reboot error when using KVM
> > There are two issues when rebooting a guest using KVM
> > 1. When the guest initiates a reboot the host is unable to stop the vcpu
> > 2. When running a SMP guest the qemu monitor system_reset causes a vcpu crash
> >
> > This can be fixed by clearing the CSR values at reset and syncing the
> > MPSTATE with the host.
> >
> > Signed-off-by: liguang.zhang <liguang.zh...@hexintek.com>
>
> Thanks!
>
> When sending new versions of patches please increment the patch
> version:
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#when-resending-patches-add-a-version-tag
>

Sorry about it, since i'm confused about the git send-email, original mail thread lost. -> https://www.mail-archive.com/qemu-devel@nongnu.org/msg977038.html
I would like to resubmit and track the email history.

> The patch looks good, but don't we need an equivalent for the get register call?
>
> Alistair

Sorry, "get register call" refers to which section? It was not mentioned in the previous suggestions for modifications.
Follow the original modification suggestions, I hope to upstream as soon as possible, as it has been delayed for quite some time.

Thanks ~


