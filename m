Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E240B7922F7
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 15:23:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdW10-0003GI-AO; Tue, 05 Sep 2023 09:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qdW0u-0003GA-Gd
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 09:22:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qdW0s-00045Z-CD
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 09:22:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BFB461FDDE;
 Tue,  5 Sep 2023 13:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693920156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XouEucA4cKn13wg6R9GWF2/JEADYpI/SrZ6Radii6II=;
 b=tZdZxHOQwFkK/m/XAOsGSE8nah6BdEXGaxLOQZMB0SD29ukTDH+jemX50NCafhMrSluAGI
 nbnY+8hhPskH1WM8RBlhwbki9EsnEx/dzv/won/QDzHqlkjxR+VNSyJL/X1S2zMDx/lbOR
 tt2WEM1CMs9uCsxW2HWoHUVdLe/pjTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693920156;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XouEucA4cKn13wg6R9GWF2/JEADYpI/SrZ6Radii6II=;
 b=01rJ8gZxsbAk5RaKPF0J2d7Zg8hW/32rIymUnlvpDjcZIZYGY23vWj7t2blzw5xU6rtnWH
 rlbuvai6NuNQDYCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 513B413499;
 Tue,  5 Sep 2023 13:22:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id s59zB5wr92RfMwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 05 Sep 2023 13:22:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v10 00/10] migration: Modify 'migrate' and
 'migrate-incoming' QAPI commands for migration
In-Reply-To: <3fb6b8c1-7790-3ad6-62b1-81642e878f7d@nutanix.com>
References: <20230726141833.50252-1-het.gala@nutanix.com>
 <30cffa41-3e39-205f-5119-d84d6303f58c@nutanix.com>
 <a81add8b-f08b-6589-e9f5-779a4a7bd63f@nutanix.com>
 <3fb6b8c1-7790-3ad6-62b1-81642e878f7d@nutanix.com>
Date: Tue, 05 Sep 2023 10:22:33 -0300
Message-ID: <875y4orbza.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Het Gala <het.gala@nutanix.com> writes:

> Hi qemu-devel community,
>
> A gentle reminder and request for all migration maintainers - Peter, 
> Juan, Dr. Gilbert and others too for review of the patchset series. 
> Received reviewed-by from Daniel on migration implementation patches but 
> need final approval from migration maintainers before getting it merged. 
> Also got acked-by tag from Markus on the QAPI patches. This is Part1 of 
> the 4 patchset series. Ultimate goal of the whole 4 series is to 
> 'introduce multiple interface support on top of existing multifd 
> capability'. Hope to get approval or comments from migration maintainers 
> on the patches soon.
>

Hi,

Is this the latest version of this series? I see errors with make
check. Let me know if I should wait for your next version to comment.

