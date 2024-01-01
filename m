Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2BC821574
	for <lists+qemu-devel@lfdr.de>; Mon,  1 Jan 2024 22:45:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKQ5M-0006HX-Ut; Mon, 01 Jan 2024 16:44:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <herve.poussineau@reactos.org>)
 id 1rKQ5H-0006GY-9q; Mon, 01 Jan 2024 16:44:31 -0500
Received: from iserv.reactos.org ([2a01:4f8:1c17:5ae1::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <herve.poussineau@reactos.org>)
 id 1rKQ5F-0005HV-4E; Mon, 01 Jan 2024 16:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=reactos.org
 ; s=25047;
 h=Sender:Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Klpoq4IBJlwhgww+5AFWbDVu6+kwoqVKefDdmBTb8R0=;
 i=herve.poussineau@reactos.org; b=KTo6F9xA5eMZRYMALNwiU7LeZPPhe/qRQcqP2qoStkT
 S0uuts6wZq7EU4cf+cvTtUudL4rs3ULzBntS3iXgXRi/3DnLh08lkZra0ujEcWuCVG3agXgzWzPda
 XaQqXfRPCHgMurOPGq+4K+7Nf4XvUwpSUj69o6vblXO+In8gchU=;
Received: (Authenticated sender: herve.poussineau@reactos.org)
 by iserv.reactos.org with esmtpsa
 (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_128_GCM:128) (Exim)
 (envelope-from <herve.poussineau@reactos.org>)
 id 1rKQ59-00FL7K-Kv; Mon, 01 Jan 2024 21:44:23 +0000
Message-ID: <10e3fd96-ede1-1e13-2441-779be98cf886@reactos.org>
Date: Mon, 1 Jan 2024 22:44:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] hw/block/fdc: do not set SEEK status bit in multi track
 commands
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20230812085957.408208-1-hpoussin@reactos.org>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
In-Reply-To: <20230812085957.408208-1-hpoussin@reactos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f8:1c17:5ae1::1;
 envelope-from=herve.poussineau@reactos.org; helo=iserv.reactos.org
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.014,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Ping.

Le 12/08/2023 à 10:59, Hervé Poussineau a écrit :
> I don't understand when SEEK must be set or not, but it seems to fix Minix...
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1522
> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
> ---
>   hw/block/fdc.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index d7cc4d3ec19..f627bbaf951 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -1404,7 +1404,6 @@ static int fdctrl_seek_to_next_sect(FDCtrl *fdctrl, FDrive *cur_drv)
>               } else {
>                   new_head = 0;
>                   new_track++;
> -                fdctrl->status0 |= FD_SR0_SEEK;
>                   if ((cur_drv->flags & FDISK_DBL_SIDES) == 0) {
>                       ret = 0;
>                   }


