Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC83C80C714
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 11:48:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCdpn-0006fd-6G; Mon, 11 Dec 2023 05:48:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rCdpk-0006eF-GI; Mon, 11 Dec 2023 05:48:20 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rCdpi-0004Vd-Fh; Mon, 11 Dec 2023 05:48:20 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8A23A44ECD;
 Mon, 11 Dec 2023 11:48:06 +0100 (CET)
Message-ID: <a736f5be-b1f9-4ee6-b9f1-a8271566a9e4@proxmox.com>
Date: Mon, 11 Dec 2023 11:48:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 29/32] virtio-blk: implement BlockDevOps->drained_begin()
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Thomas Lamprecht <t.lamprecht@proxmox.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20230530163239.576632-1-kwolf@redhat.com>
 <20230530163239.576632-30-kwolf@redhat.com>
 <ee6374dc-c644-449f-b5d1-788695e1a83e@proxmox.com>
 <c3e115ff-c143-4d1b-901c-6b386d012eac@proxmox.com>
 <ZXLUuoOawqQpyodD@redhat.com>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <ZXLUuoOawqQpyodD@redhat.com>
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

Am 08.12.23 um 09:32 schrieb Kevin Wolf:
> 
> I'm not involved in it myself, but the kind of theme reminds me of this
> downstream bug that Hanna analysed recently:
> 
> https://issues.redhat.com/browse/RHEL-3934
> 
> Does it look like the same root cause to you?
> 

Thank you for the reference! Yes, that does sound like the same root
cause. And the workaround I ended up with is also very similar, but it
was missing kicking the virt queue.

Best Regards,
Fiona


