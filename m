Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 536BF82EEBF
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 13:13:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPiIB-00030h-C3; Tue, 16 Jan 2024 07:11:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rPiI8-00030R-T9; Tue, 16 Jan 2024 07:11:40 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rPiI6-0005Fp-IA; Tue, 16 Jan 2024 07:11:40 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id ECE3149142;
 Tue, 16 Jan 2024 13:11:25 +0100 (CET)
Message-ID: <960d7ef2-9e73-4987-98ca-529118325909@proxmox.com>
Date: Tue, 16 Jan 2024 13:11:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/clipboard: avoid crash upon request when clipboard
 peer is not initialized
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, m.frank@proxmox.com,
 berrange@redhat.com, mcascell@redhat.com, qemu-stable@nongnu.org
References: <20240112135527.57212-1-f.ebner@proxmox.com>
 <CAJ+F1C+JXE9hSQ_oDNZvhpYDqPeeKayopB3x2L2YyJTxM8t+Yg@mail.gmail.com>
 <2150aa28-3eba-4e95-a301-d87377ba40a4@proxmox.com>
 <CAJ+F1CKQkXUiuQH+mNC7p00wWrznsgWJD4xjR-AzjJGPnsF8gw@mail.gmail.com>
 <ccd23263-f19f-401e-b476-a7eb1fd22571@proxmox.com>
 <CAJ+F1CJHKsRrxUcUijAVV2bv0EOtbz0BAmH1OEnmciwo7ACXLQ@mail.gmail.com>
 <0c2d35cb-cacf-4a81-9b6a-f07fdea9fc07@proxmox.com>
 <CAJ+F1CJ4F6Kv9Vx_4H+GJ0ME0Q0X4GTm2n6L1JGg-SWFgi18SA@mail.gmail.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <CAJ+F1CJ4F6Kv9Vx_4H+GJ0ME0Q0X4GTm2n6L1JGg-SWFgi18SA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Am 15.01.24 um 13:00 schrieb Marc-André Lureau:
>>>>
>>>
>>> The trouble is when qemu_clipboard_update() is called without data &
>>> without a request callback set. We shouldn't allow that as we have no
>>> means to get the clipboard data then.
>>>
>>
>> In the above scenario, I'm pretty sure there is data when
>> qemu_clipboard_update() is called. Just no request callback. If we'd
>> reject this, won't that break clients that do not set the
>> VNC_FEATURE_CLIPBOARD_EXT feature and only use non-extended
>> VNC_MSG_CLIENT_CUT_TEXT messages?
> 
> If "data" is already set, then qemu_clipboard_request() returns.
> 
> Inverting the condition I suggested above: it's allowed to be the
> clipboard owner if either "data" is set, or a request callback is set.
> 

Oh, sorry. Yes, it seems the problematic case is where data is not set.
But isn't that legitimate when clearing the clipboard? Or is a
VNC_MSG_CLIENT_CUT_TEXT message not valid when len is 0 and should be
rejected? In my testing KRDC does send such a message when the clipboard
is cleared:

> #1  0x0000558f1e6a0dac in vnc_client_cut_text (vs=0x558f207754d0, len=0, 
>     text=0x558f2046e008 "\003 \002\377\005") at ../ui/vnc-clipboard.c:313
> #2  0x0000558f1e68e067 in protocol_client_msg (vs=0x558f207754d0, 
>     data=0x558f2046e000 "\006", len=8) at ../ui/vnc.c:2454

Your suggestion would disallow this for clients that do not set the
VNC_FEATURE_CLIPBOARD_EXT feature (and only use non-extended
VNC_MSG_CLIENT_CUT_TEXT messages).

Best Regards,
Fiona


