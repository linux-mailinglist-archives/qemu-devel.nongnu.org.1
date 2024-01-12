Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C5282C165
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 15:12:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOIGP-0003bh-VX; Fri, 12 Jan 2024 09:12:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rOIGN-0003ZN-7e; Fri, 12 Jan 2024 09:11:59 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rOIGL-0002Ez-0h; Fri, 12 Jan 2024 09:11:58 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8BE884536F;
 Fri, 12 Jan 2024 15:11:53 +0100 (CET)
Message-ID: <00443ef8-567d-4d18-ad59-08b19e4d7c13@proxmox.com>
Date: Fri, 12 Jan 2024 15:11:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/clipboard: avoid crash upon request when clipboard
 peer is not initialized
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, m.frank@proxmox.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, mcascell@redhat.com, qemu-stable@nongnu.org
References: <20240112135527.57212-1-f.ebner@proxmox.com>
In-Reply-To: <20240112135527.57212-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Am 12.01.24 um 14:55 schrieb Fiona Ebner:
> 
> Then when noVNC sends a VNC_MSG_CLIENT_CUT_TEXT message (it did set
> the feature correctly, so the check added by your patch passes),

Sorry, forgot to adapt this part. This should read "it did set the
VNC_FEATURE_CLIPBOARD_EXT feature correctly, so a check for it passes".

> that
> clipboard info is passed to qemu_clipboard_request() and the original
> segfault still happens.
> 


