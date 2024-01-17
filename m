Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0618309A4
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:23:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7kS-0000rR-Is; Wed, 17 Jan 2024 10:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1rQ7kP-0000qZ-KO; Wed, 17 Jan 2024 10:22:33 -0500
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1rQ7kP-0007Tq-Bi; Wed, 17 Jan 2024 10:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=vs/rjXDdPV8iry5rDQ7h2bIsyzWv8a0NXFU9duucoEQ=; b=Tm19OAZHRVmYA/ZTOvo6
 AHTZLh9po8oEw4w3FMWdOKfDH0SLSBqDUSh5JoFOv+YyB3Opg8Ml4tJVx95rzEvhQNVI3h4V41f5Y
 qKBiZWGXD5KcqWaA6wcttnHsJS5UY78cZq3EdLlTprpfAkKhja5h72fY32ZJuYV1MxCg6lpSNG2g2
 6q2KEIcnMV9H8b5zefCs+36uLlBBQx7M2jBtTj2a6PqjJ4OiPFAghPB4a6KZENHolGzBDPahmPvx0
 SM+lwR0V7eKyJBzXJBpn9I7ANdM2XbcasLZwykZBHJxT3H9CEHHqxZTcGCQx4/2ENWe0Iel8D2n0Y
 9jdVGpkQiLlmSA==;
Date: Wed, 17 Jan 2024 16:22:30 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Manolo de Medici <manolodemedici@gmail.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, bug-hurd@gnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/4] Avoid multiple definitions of copy_file_range
Message-ID: <20240117152230.bnnjln5mnhxuh5ib@begin>
Mail-Followup-To: Manolo de Medici <manolodemedici@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, bug-hurd@gnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <CAHP40mkL6EzLgRvYZ2gp=dmF_5gxD-9cJBTODAb8UtjurZuBKg@mail.gmail.com>
 <37ef47fc-92a5-4ffe-9677-2bc013cfe20b@linaro.org>
 <CAHP40mkNb5EH_Js02LpENMc2CA2pj7fEJY_S1sTMNWh_3rcUEQ@mail.gmail.com>
 <20240117143306.lnycf2ijwkzycowj@begin>
 <CAHP40mkk4aRG+9PGjoW2U38WXSvd1NpvDgMet4AQASg3=H=UdA@mail.gmail.com>
 <20240117150323.xn5otaf2ovg3hyp5@begin>
 <CAHP40mmG_SxUqhwysVzYt-c+UF5YVNqk2fBTZpHzAhLn7BCijw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHP40mmG_SxUqhwysVzYt-c+UF5YVNqk2fBTZpHzAhLn7BCijw@mail.gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
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

Manolo de Medici, le mer. 17 janv. 2024 16:08:34 +0100, a ecrit:
> Understood, but I cannot judge if it is a bug in qemu or it fixes
> another host os,
> since qemu doesn't target only glibc.

Yes, but freebsd too uses ssize_t:

https://man.freebsd.org/cgi/man.cgi?copy_file_range(2)

glib mentions that it only exists on linux and freebsd.

https://www.gnu.org/software/gnulib/manual/html_node/copy_005ffile_005frange.html

> In order to avoid breaking other hosts, I consider it more cautious to
> ignore the difference.

Ignoring a bug is not a good thing on the long run :)

When there is something suspicious, it's useful to fix it.

> In the long term the Hurd is going to implement copy_file_range

Yes and by just fixing the prototype, we'll keep qemu able to
automatically use it when it becomes available.

Really, please, no tinkering, rather fix bugs.

Samuel

