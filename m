Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4A477CB25
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 12:28:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVrGY-0001GS-I9; Tue, 15 Aug 2023 06:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wbx@openadk.org>) id 1qVrGW-0001GI-2v
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 06:27:08 -0400
Received: from helium.openadk.org ([2a00:1828:2000:679::23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wbx@openadk.org>) id 1qVrGT-0008Ig-Hq
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 06:27:07 -0400
Received: by helium.openadk.org (Postfix, from userid 1000)
 id 3C81E35206C7; Tue, 15 Aug 2023 12:26:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=openadk.org; s=2022;
 t=1692095219; bh=j6pGqqNekoXbx1pCyhFcIGz1keqgjnuzmNZrE9UO1A0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LalWRp+I+286tvs/7KqZ+NhHTEr5udWuPLh23QfHc3nb36BOxAxxUK+L54itXzFFA
 +nN4X9SMkArBMdebUm+tFl9swIBepLe2ZVStVYaO6RJQe4Rs1MYLPwu2MhTbkPVwf4
 /hrlqh3GI9WxQfJd/c1pn3C92WAEtM2IKt3bYjehJ1TlWMeDO02TCpk2fmg7rjDJGW
 kD1SDpbWwYnk/25oDtMtqMc+4TvLejRNprHCqFzCaehgFQ42342YuWhu3AqWnx+CGN
 Yw8ap+LDQktsq9WFgBeWQRnfBhm9eobCwXb09h1LQovOHAPqdOBu7xb+5jW7H+4/as
 acLz2ysyTg4Dg==
Date: Tue, 15 Aug 2023 12:26:59 +0200
From: Waldemar Brodkorb <wbx@openadk.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Waldemar Brodkorb <wbx@openadk.org>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: qemu-system-m68k: ../hw/scsi/scsi-disk.c:557: scsi_write_data:
 Assertion `r->req.aiocb == NULL' failed.
Message-ID: <ZNtS8ypmcGBwyrIG@waldemar-brodkorb.de>
References: <ZNiKYwbkk5zwlLB5@waldemar-brodkorb.de>
 <ef2fb553-fbac-7947-7be0-cdc7801b7a4c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef2fb553-fbac-7947-7be0-cdc7801b7a4c@redhat.com>
X-Operating-System: Linux 5.10.0-21-amd64 x86_64
Received-SPF: pass client-ip=2a00:1828:2000:679::23;
 envelope-from=wbx@openadk.org; helo=helium.openadk.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,
Thomas Huth wrote,

> On 13/08/2023 09.46, Waldemar Brodkorb wrote:
> > Hi,
> > 
> > I am using Qemu 8.0.3 and getting this error:
> > qemu-system-m68k: ../hw/scsi/scsi-disk.c:557: scsi_write_data: Assertion `r->req.aiocb == NULL' failed.
> > 
> > It happens f.e. when I extract the glibc source code inside Linux.
> > Linux 6.1.44, glibc 2.38 is used for the Linux system.
> > I am starting qemu this way:
> > qemu-system-m68k -nographic -M q800 -kernel /home/wbx/openadk/firmware/qemu-m68k-q800_glibc_68040/qemu-m68k-q800-archive-kernel qemu-m68k.img
> > 
> > What can I do about it? Why this is happening on "heavy" I/O usage?
> 
> Is it a regression? I.e. did it not happen on older versions of QEMU?

It seems to be a regression. It is the first time I use
qemu-system-m68k to build glibc natively, before that I only running
the uclibc-ng testsuite.

I now tried older releases and 5.2.0 is the first good version.
6.0.0 is crashing again.

best regards
 Waldemar

