Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E77577F4587
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 13:16:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5m9K-0007iG-QS; Wed, 22 Nov 2023 07:16:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1r5m8x-0007gW-H5; Wed, 22 Nov 2023 07:15:47 -0500
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1r5m8v-0006kg-ED; Wed, 22 Nov 2023 07:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=l6UqClNkHI9Ss1/AhKfveyyRus2UiUOzHKfP+gre8w0=; b=VgvT6a9BaEERDtEFxwTjDaukBj
 KUvbQppBCArtKQpCDdMEpWlFEqrS8uNsDJ5+RWlj7M3wAAqXXRDqDr63dss4O5D69OL2jrJCjV3Nj
 oHI/y5CgJThPNFCA04GcYjjHVWQ6w1CdKrcmngKeDpf0djV73e8EwOQlrpniyXqVNbOu/B8ZK3h0/
 BLi4Sb7tICWXOV1XqoZFLa/UKbS11E52rxViNqnAZRslVkdRU92ChsOlDGE9fz7M4ESCi7vMEfE/E
 A5Xc/a9huoqkfB3CZCoFQ9IeK7+DZqXx7AfeKGYYR1LlaMp/iYTwLQr53HZgUW/xSb4URWpoga7Z5
 zvVGcvCA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1r5m8k-005xer-Fi; Wed, 22 Nov 2023 13:15:34 +0100
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1r5m8i-00GR4n-A6; Wed, 22 Nov 2023 13:15:34 +0100
Received: from berto by gate.service.igalia.com with local (Exim 4.96)
 (envelope-from <berto@igalia.com>) id 1r5m8i-00GPs2-0S;
 Wed, 22 Nov 2023 12:15:32 +0000
Date: Wed, 22 Nov 2023 12:15:32 +0000
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: Converting images to stdout
Message-ID: <ZV3w5A-8Kid-9-5W@igalia.com>
References: <ZVZV2ZKcxoSargry@zeus.local>
 <6hipeyoml7qpxcycxbydmldohcwsle56tpeavzddpciycb4vfm@gmr7uf56skye>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6hipeyoml7qpxcycxbydmldohcwsle56tpeavzddpciycb4vfm@gmr7uf56skye>
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Mon, Nov 20, 2023 at 05:23:27PM -0600, Eric Blake wrote:
> > I'm interested in this use case, and I think that the method would be
> > as simple as this:
> > 
> > 1. Decide a cluster size for the output qcow2 file.
> > 2. Read the input file once to determine which clusters need to be
> >    allocated in the output file and which ones don't.
> > 3. That infomation is enough to determine the number and contents of
> >    the refcount table, refcount blocks, and L1/L2 tables.
> > 4. Write the qcow2 header + metadata + allocated data to stdout.
> 
> It may also be possible to write a qcow2 file that uses the external
> data bit, so that you are only writing the qcow2 header + metadata,
> and reusing the existing input file as the external data.

Sure, although I'm not so certain about the use case here... also, the
input file might not be raw.

> > Because this would be an external tool it would only support
> > a qcow2 file with the default options. Other features like
> > compression would be out of scope.
> 
> Why is compression not viable?  Are you worried that the qcow2
> metadata (such as refcounts) becomes too complex?

Yeah, mostly... also, since the output file would be streamable it's
trivial to pipe it through gzip or whatever.

> I've also wondered how easy or hard it would be to write a tool that
> can take an existing qcow2 file and defragment and/or compress it
> in-place (rather than having to copy it to a second qcow2 file).

That sounds a bit more complex, but I guess it's doable. But not
something that I need atm :)

Berto

