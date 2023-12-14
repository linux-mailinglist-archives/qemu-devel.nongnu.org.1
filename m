Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7828131CD
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 14:40:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDlvd-0005WK-BK; Thu, 14 Dec 2023 08:39:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rDlvb-0005Vr-N6; Thu, 14 Dec 2023 08:39:03 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rDlvZ-0003Tf-WA; Thu, 14 Dec 2023 08:39:03 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B38544760A;
 Thu, 14 Dec 2023 14:38:50 +0100 (CET)
Message-ID: <ba257408-5fb2-41d3-8b43-297ebcd312ea@proxmox.com>
Date: Thu, 14 Dec 2023 14:38:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] aio-posix: call ->poll_end() when removing AioHandler
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 pbonzini@redhat.com, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>
References: <20231213211544.1601971-1-stefanha@redhat.com>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20231213211544.1601971-1-stefanha@redhat.com>
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

Am 13.12.23 um 22:15 schrieb Stefan Hajnoczi:
> But there you have it. Please let me know what you think and try your
> reproducers to see if this fixes the missing io_poll_end() issue. Thanks!
> 

Thanks to you! I applied the RFC (and the series it depends on) on top
of 8.2.0-rc4 and this fixes my reproducer which drains VirtIO SCSI or
VirtIO block devices in a loop. Also didn't encounter any other issues
while playing around a bit with backup and mirror jobs.

The changes look fine to me, but this issue is also the first time I
came in close contact with this code, so that unfortunately does not say
much.

Best Regards,
Fiona


