Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC12B7D0AC8
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 10:48:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtl9S-0004Fv-B9; Fri, 20 Oct 2023 04:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qtl9P-0004DX-9r; Fri, 20 Oct 2023 04:46:35 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qtl9N-0007Ne-3k; Fri, 20 Oct 2023 04:46:34 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 7B31D43579;
 Fri, 20 Oct 2023 10:46:27 +0200 (CEST)
Message-ID: <a7e6b65c-145c-4e5b-b2eb-7baac03ed78a@proxmox.com>
Date: Fri, 20 Oct 2023 10:46:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] blockdev: mirror: avoid potential deadlock when using
 iothread
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru, jsnow@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com,
 t.lamprecht@proxmox.com
References: <20231019131936.414246-1-f.ebner@proxmox.com>
 <20231019131936.414246-4-f.ebner@proxmox.com>
Content-Language: en-US
In-Reply-To: <20231019131936.414246-4-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
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

Am 19.10.23 um 15:19 schrieb Fiona Ebner:
> The bdrv_getlength() function is a generated co-wrapper and uses
> AIO_WAIT_WHILE() to wait for the spawned coroutine. AIO_WAIT_WHILE()
> expects the lock to be acquired exactly once.
> 
> This can happen when the source node is explicitly specified as the
> @replaces parameter or if there is a filter on top of the source node.

Correction: this should read "or if the source node is a filter node".


