Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A437DC3B7
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 01:55:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxd12-0003gp-ER; Mon, 30 Oct 2023 20:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1qxd10-0003gU-5c; Mon, 30 Oct 2023 20:53:54 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1qxd0r-0004e5-7I; Mon, 30 Oct 2023 20:53:53 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 125A2CE0B1F;
 Tue, 31 Oct 2023 00:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021E1C433C7;
 Tue, 31 Oct 2023 00:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698713612;
 bh=urXH2hnRSeRcthpF6RZiwGpF/nDsF0/rj/yenf+aheY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZvlUm5LyA3R+cYkweKYt2tUvfncxBXSoip80MWS7F1k6PVify/U5UBlNFTQEybcRb
 1FT319of3Nv2Z36GOn8bvCTO8RK1Sko9krJ0q7d0gIkMKFmSsr8dJCL5c1khiz2baZ
 iA3UoFKDm12jX6MJkUXwTttQDoV7XvYHpfMCj0EzMSfTmH/hZX709BsygQDAL/WQoR
 jQnrZozq16kaV7ZW5+F3jwtFy8pLRI77WBqc6YkD74hZkWeIgz6jYVb+vNN4E07viA
 eqGPIPXKywYlpOwt9P6eob2PoTylUtW536eM/Zn9ZGhmNuDecmRtEEJYPlf1aHWOZD
 TZFy2ni6CpYmg==
Message-ID: <6c453ffd-88c4-47ed-80cd-a9dac4095fd9@kernel.org>
Date: Tue, 31 Oct 2023 09:53:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] docs/qcow2: add the zoned format feature
To: Eric Blake <eblake@redhat.com>, Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, hare@suse.de, dmitry.fomichev@wdc.com,
 stefanha@redhat.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20231030121847.4522-1-faithilikerun@gmail.com>
 <20231030121847.4522-2-faithilikerun@gmail.com>
 <j5lohqj57qcsjjgqv3n3tm5jv7bjnqlaogg3yvi5ieoto537tk@h5nhmixdnh6p>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <j5lohqj57qcsjjgqv3n3tm5jv7bjnqlaogg3yvi5ieoto537tk@h5nhmixdnh6p>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=dlemoal@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/30/23 23:04, Eric Blake wrote:
>> +
>> +  .. option:: zone_size
>> +
>> +    The size of a zone in bytes. The device is divided into zones of this
>> +    size with the exception of the last zone, which may be smaller.
>> +
>> +  .. option:: zone_capacity
>> +
>> +    The initial capacity value, in bytes, for all zones. The capacity must
>> +    be less than or equal to zone size. If the last zone is smaller, then
>> +    its capacity is capped.
>> +
>> +    The zone capacity is per zone and may be different between zones in real
>> +    devices. For simplicity, QCow2 sets all zones to the same capacity.
> 
> Just making sure I understand: One possible setup would be to describe
> a block device with zones of size 1024M but with capacity 1000M (that
> is, the zone reserves 24M capacity for other purposes)?
> 
> Otherwise, I'm having a hard time seeing when you would ever set a
> capacity different from size.
> 
> Are there requirements that one (or both) of these values must be
> powers of 2?  Or is the requirement merely that they must be a
> multiple of 512 bytes (because sub-sector operations are not
> permitted)?  Is there any implicit requirement based on qcow2
> implementation that a zone size/capacity must be a multiple of cluster
> size (other than possibly for the last zone)?

Linux requires the zone size to be a power of 2 number of LBAs. As a value so
defined may not align to a ZNS drive internal superblock size (e.g. align to
erase blocks), the zone capacity can be smaller than the zone size. The zone
capacity represents the number of LBAs that are usable within a zone. The LBAs
between zone capacity and zone size are unusable: reads will return 0s and
writes will fail for these LBAs. A drive capacity is reported as the sum of all
zone sizes, so it may be larger than the actual usable capacity, which is the
sum of all zone capacities.

Qcow2 follows this model despite the fact that we do not have the constraint of
aligning to some hardware erase block size. This is mainly to allow emulating a
real drive configuration. If a real drive emulation is not the goal of the
use-case at hand, most users will simply want to have zone size == zone capacity
for their zoned qcow2 drives.

> 
>> +
>> +  .. option:: zone_nr_conv
>> +
>> +    The number of conventional zones of the zoned device.
>> +
>> +  .. option:: max_open_zones
>> +
>> +    The maximal allowed open zones.
>> +
>> +  .. option:: max_active_zones
>> +
>> +    The limit of the zones with implicit open, explicit open or closed state.
>> +
>> +  .. option:: max_append_sectors
>> +
>> +    The maximal number of 512-byte sectors in a zone append request.
> 
> Why is this value in sectors instead of bytes?  I understand that
> drivers may be written with sectors in mind, but any time we mix units
> in the public interface, it gets awkward.  I'd lean towards having
> bytes here, with a requirement that it be a multiple of 512.

Agreed. Let's use bytes to avoid confusion.

-- 
Damien Le Moal
Western Digital Research


