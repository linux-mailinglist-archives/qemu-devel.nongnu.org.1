Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C120F78BE3E
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 08:07:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qarrp-0006BS-1R; Tue, 29 Aug 2023 02:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1qarrm-0006AR-II; Tue, 29 Aug 2023 02:06:18 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1qarri-0007Ab-Cf; Tue, 29 Aug 2023 02:06:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C74FC62350;
 Tue, 29 Aug 2023 06:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB32C433C8;
 Tue, 29 Aug 2023 06:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693289171;
 bh=S9rH+USM90dosKr/31uKNgEbE4zqscHh13CRUB4TbOQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SW4h6Ak32hDCRmK/psONnZOxaoyVWcWRqYTNGrcBFFC/QPUmFCmnOsjpS9YAKXFAT
 OFHLxEWRUtGAbPQyDTJonZFp9hl7reomMiDePEtfIek0RSWLd/Xwn/HIwbkpDfrKnI
 D+kwgIuUAc03gWZ45e7QVR7VuzXTSXGKQ4BSPRJCSV08p5qX4cjNKf+7rVuB5epHyW
 Ke+uXQwidGbxZrzYkMpkZAYB6JbL8M640oxzmE75cCaJGLRF8FSUYEusf/Vc/CVI6Q
 KShww+8ymb7JV5KnhSrBMC0uSJUwq7Am0W1IEbd/8NCbSItqSCMtIMYYHdUZp7Kp9a
 pE3rddUO77Jrg==
Message-ID: <4c167bfe-2b93-358d-8e13-9e4fc1016766@kernel.org>
Date: Tue, 29 Aug 2023 15:06:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/4] qcow2: add zoned emulation capability
To: Sam Li <faithilikerun@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, hare@suse.de, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, qemu-block@nongnu.org, Kevin Wolf
 <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>
References: <20230814085802.61459-1-faithilikerun@gmail.com>
 <20230814085802.61459-4-faithilikerun@gmail.com>
 <20230822194814.GB37847@fedora>
 <CAAAx-8KQOBxt3S+nB0MNtOdG_8SZVg1HOud0hp65A+LXUrL-fw@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAAAx-8KQOBxt3S+nB0MNtOdG_8SZVg1HOud0hp65A+LXUrL-fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=dlemoal@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -92
X-Spam_score: -9.3
X-Spam_bar: ---------
X-Spam_report: (-9.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.169, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

On 8/28/23 20:55, Sam Li wrote:
>>> +            /* close one implicitly open zones to make it available */
>>> +            for (int i = s->zoned_header.zone_nr_conv;
>>> +            i < bs->bl.nr_zones; ++i) {
>>> +                uint64_t *wp = &s->wps->wp[i];
>>> +                if (qcow2_get_zs(*wp) == BLK_ZS_IOPEN) {
>>> +                    ret = qcow2_write_wp_at(bs, wp, i, BLK_ZS_CLOSED);
>>
>> I'm wondering if it's correct to store the zone state persistently in
>> the qcow2 file. If the guest or QEMU crashes, then zones will be left in
>> states like EOPEN. Since the guest software will have forgotten about
>> explicitly opened zones, the guest would need to recover zone states.
>> I'm not sure if existing software is designed to do that.
>>
>> Damien: Should the zone state be persistent?

Yes and no. Yes you need to preserve/maintain zone states but not as is.
With a real drive, if you power cycle the device, you get the following states
changes:

 Before		| After power cycle
----------------+-------------------
 EMPTY		| EMPTY
 FULL		| FULL
 IMP. OPEN	| CLOSED
 EXP. OPEN	| CLOSED
 CLOSED		| CLOSED
 READ=ONLY	| READ-ONLY
 OFFLINE	| OFFLINE

So any open (implicit or explicit) zone will show up as closed after power
cycle. That is, the number of "active" zones does not change.
For the qcow2 emulation, as long as you do not also emulate read-only and
offline zones, you actually do not need to save the zone state in the zone
metadata. On startup, you can infer the state from the zone write pointer:

zone wp == zone start -> EMPTY
zone wp >= zone capacity -> FULL
zone wp > zone start -> CLOSED

And make sure that all closed zones are counted as the initial number of active
zones. The initial number of open zones will always be 0.

So it is easy :)

-- 
Damien Le Moal
Western Digital Research


