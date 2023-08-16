Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C16C77E070
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 13:32:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWEk7-0002sp-IG; Wed, 16 Aug 2023 07:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wbx@openadk.org>)
 id 1qWEk5-0002rv-2I; Wed, 16 Aug 2023 07:31:13 -0400
Received: from helium.openadk.org ([89.238.66.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wbx@openadk.org>)
 id 1qWEjx-0001qv-Mz; Wed, 16 Aug 2023 07:31:10 -0400
Received: by helium.openadk.org (Postfix, from userid 1000)
 id 66B853520C53; Wed, 16 Aug 2023 13:30:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=openadk.org; s=2022;
 t=1692185458; bh=r6sey43s8Qf1fyOawR2E8P8KhVh07KrX7IRa/X9uOB4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pypXtrSBxI3OzM7FFvZEACEkuD1ZfsVLK9f0SYbxC4rXJa1nSk2VfEqMFtao5g0Cj
 53O7JXQaEl3fYqAspx3XsGuMEpX4nndIjtdztm5H/2jLhH3BC/DKQmTxZbXjNF2Trb
 zqTqizSOvyrRABrmI2OQ0VCUw54lIFO3xs+VGA+Nv3DOmEWVxodAuImZc2xD6PONkM
 ipIA0YC79vwsu+8fb42L+vqX84AcexT+LQ6VF1pA9Fu4M6lDYQ82DD/ZTDhytQZaX6
 Z3xyo7vboF5YIJVGH4i+sBZKroscmto0CDd8DbnqtyY+0TDPvQEm3yRSplIrXYIh4Q
 wBMOlPlMDUJww==
Date: Wed, 16 Aug 2023 13:30:58 +0200
From: Waldemar Brodkorb <wbx@openadk.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Waldemar Brodkorb <wbx@openadk.org>, qemu-devel@nongnu.org,
 qemu-block <qemu-block@nongnu.org>
Subject: Re: qemu-system-m68k: ../hw/scsi/scsi-disk.c:557: scsi_write_data:
 Assertion `r->req.aiocb == NULL' failed.
Message-ID: <ZNyzch8J7Pv0pDEo@waldemar-brodkorb.de>
References: <ZNiKYwbkk5zwlLB5@waldemar-brodkorb.de>
 <389cfe6d-aade-f79a-b618-fb0e029fff5d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <389cfe6d-aade-f79a-b618-fb0e029fff5d@linaro.org>
X-Operating-System: Linux 5.10.0-21-amd64 x86_64
Received-SPF: pass client-ip=89.238.66.15; envelope-from=wbx@openadk.org;
 helo=helium.openadk.org
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
Philippe Mathieu-Daudé wrote,

> Hi Waldemar
> 
> On 13/8/23 09:46, Waldemar Brodkorb wrote:
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
> Cc'ing the qemu-block list.
> 
> Do you mind filling a bug report at
> https://gitlab.com/qemu-project/qemu/-/issues ?

Okay, see here:
https://gitlab.com/qemu-project/qemu/-/issues/1831

best regards
 Waldemar

