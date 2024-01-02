Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B14821AE3
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 12:27:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKcuz-0000oc-Al; Tue, 02 Jan 2024 06:26:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1rKcuw-0000o7-Dx; Tue, 02 Jan 2024 06:26:42 -0500
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1rKcuu-0002yr-BR; Tue, 02 Jan 2024 06:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
 Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UcxLnsNghlf5QtXM7sZPaWgpuHcvCvOvLQvYI4nOJ+s=; b=M1uAS/eOWKxkeyyr/IZ8XSgqFA
 Yasjulo8FhPFDYSdWLMSl3Rk9Sv6BerhbVzrlRUnNzZxRxupI5l+YATuGkePRCJbv1rKbzO8Q2PHn
 hD7iQsf09Nc6zidjBv0cswKOvtRjfoA9GlNq77Cx3ZtwIB+UEKTZLuJzbuWpAt9FWHwBccOC+MHHR
 GS0jX4RkzTfNc1rUndSaAP5p80qyPyfji02qP9xF9eX2eK2KYjnYqWV2KhR4q97EKa9kBmLGyibdy
 Nio5sH3WLlFzvJRrHPi/bZOdmgn5GmYwvtlgMAh0fw7T5l03R5KfnfDc2bJzZAif8MymfETR2Czg/
 a5G2c7fA==;
Received: from [167.98.27.226] (helo=[10.35.4.236])
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1rKcum-00A0Bl-NW; Tue, 02 Jan 2024 11:26:32 +0000
Message-ID: <59b7fbbb-ac65-4794-b87a-5e8aff724d21@codethink.co.uk>
Date: Tue, 2 Jan 2024 11:26:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PCIe with Designware RC.
To: Shlomo Pongratz <shlomopongratz@gmail.com>,
 qemu-discuss <qemu-discuss@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
References: <CAHzK-V1CDcpa5LQzfx8ppU0nZh01AyfPkB-xXQcPqXuue7BJvw@mail.gmail.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <CAHzK-V1CDcpa5LQzfx8ppU0nZh01AyfPkB-xXQcPqXuue7BJvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=188.40.203.114;
 envelope-from=ben.dooks@codethink.co.uk; helo=imap4.hz.codethink.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 24/12/2023 09:51, Shlomo Pongratz wrote:
> Hi,
> I'm working on a AARCH64 project that uses the designeware
> (hw/pci-host/designware.c).
> I've copied the designware initialization from hw/arm/fsl-imx7.c and I
> hope I've updated the dtsi correctly.
> After fixing an issue with the iATU windows (see patch
> https://lists.gnu.org/archive/html/qemu-devel/2023-12/msg02643.html)

Hmm, thought I had fixed this a while ago when doing some work
with another systems and 64bit PCIe support as well.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html


