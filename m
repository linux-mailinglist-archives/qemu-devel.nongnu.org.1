Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CDC7C9633
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 22:00:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrkoM-00036N-9p; Sat, 14 Oct 2023 16:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qrko9-0002h2-CN; Sat, 14 Oct 2023 16:00:30 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qrko7-0005BQ-4k; Sat, 14 Oct 2023 16:00:21 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id CECE475721D;
 Sat, 14 Oct 2023 21:59:13 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D646F7456A7; Sat, 14 Oct 2023 21:59:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D3D95745681;
 Sat, 14 Oct 2023 21:59:12 +0200 (CEST)
Date: Sat, 14 Oct 2023 21:59:12 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: QEMU Developers <qemu-devel@nongnu.org>, 
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Subject: Re: -drive if=none: can't we make this the default?
In-Reply-To: <d9d1ec6c-d812-4994-968d-bd40228dac51@tls.msk.ru>
Message-ID: <bfc0ea0d-afda-50c6-d1d2-a89a227ad4f9@eik.bme.hu>
References: <d9d1ec6c-d812-4994-968d-bd40228dac51@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Sat, 14 Oct 2023, Michael Tokarev wrote:
> Can't we make -drive if=none the default?
>
> Yes, I know current default is ide, and whole world have to use if=none 
> explicitly
> to undo this.  I think at this point we can deprecate if=ide default and 
> switch to
> if=none in the next release.  I think it will be a welcome change.

I don't think that would be welcome by all people now using -drive 
media=disk,format-raw,file= shortcut (which they were forced to use 
instead of the previous -hda shortcut just to specify format=raw) and now 
they would need to change that to -drive lot,of,options,here -device 
ide-hd,drive=[what was it called and which drive is that?] instead. That's 
a lot more typing and much less convenient so please keep the convenience 
option at least somewhat convenient for command line users.

Also machine class has a member (possibly) set by board code: 
mc->block_default_type = IF_IDE; Isn't that the default used if no "if" 
property given?

Maybe I don't understand how this works but if it makes less convenient 
for users and breaks their scripts then I don't think it's a good idea.

Regards,
BALATON Zoltan

