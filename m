Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 116087C83DA
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 13:00:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrFtF-0006fS-0K; Fri, 13 Oct 2023 06:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qrFt5-0006RL-Nw; Fri, 13 Oct 2023 06:59:25 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qrFt3-0001EW-9w; Fri, 13 Oct 2023 06:59:23 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id AC4B347D12;
 Fri, 13 Oct 2023 12:59:16 +0200 (CEST)
Message-ID: <2c90c89b-15c5-487a-b093-0372705fd247@proxmox.com>
Date: Fri, 13 Oct 2023 12:59:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] migration: hold the BQL during setup
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 jsnow@redhat.com, vsementsov@yandex-team.ru, eblake@redhat.com,
 leobras@redhat.com, peterx@redhat.com, quintela@redhat.com,
 pbonzini@redhat.com, t.lamprecht@proxmox.com
References: <20231012103307.371092-1-f.ebner@proxmox.com>
 <87mswnziak.fsf@suse.de>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <87mswnziak.fsf@suse.de>
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

Am 12.10.23 um 22:40 schrieb Fabiano Rosas:
> Fiona Ebner <f.ebner@proxmox.com> writes:
> 
>> This is intended to be a semantic revert of commit 9b09503752
>> ("migration: run setup callbacks out of big lock"). There have been so
>> many changes since that commit (e.g. a new setup callback
>> dirty_bitmap_save_setup() that also needs to be adapted now), it's
>> easier to do the revert manually.
>>
>> For snapshots, the bdrv_writev_vmstate() function is used during setup
>> (in QIOChannelBlock backing the QEMUFile), but not holding the BQL
>> while calling it could lead to an assertion failure. To understand
>> how, first note the following:
> 
> Would it make sense to add a GLOBAL_STATE_CODE() annotation to
> qio_channel_block_writev?
> 

Since bdrv_writev_vmstate() is IO_OR_GS_CODE(), would using that be
better? And I guess if we add an annotation for
qio_channel_block_writev(), we should go ahead and also do it for other
functions in the file? E.g. qio_channel_block_new() would have to be
GLOBAL_STATE_CODE(), because it uses bdrv_ref().

Best Regards,
Fiona


