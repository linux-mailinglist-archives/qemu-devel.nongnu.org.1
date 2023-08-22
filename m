Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC7E78409C
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 14:20:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYQN1-0007EK-PH; Tue, 22 Aug 2023 08:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qYQMO-00079D-EA
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:19:50 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qYQML-0000Y7-RS
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:19:48 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 126C522BB9;
 Tue, 22 Aug 2023 12:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692706784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mNNuPR+eZG5NrD0WNVivJFIRVO+9s1Sxmvq0+4O0igY=;
 b=fE7YbT287SbPfi4K2TldMZYoYcI/aai7boRTXYEq/QHnJkMg5XOKhWJZq226tTjxcndrob
 FC02gajGNy+ktGgyJei7FGik3dFJ053eUvSLAEn2zQV04Y4CbGei/Ub1ewNilHdJMnEqB2
 vjI+SC0XhrMpxy6qtnTb4gyCLTZckSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692706784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mNNuPR+eZG5NrD0WNVivJFIRVO+9s1Sxmvq0+4O0igY=;
 b=Qun1ZEoFnSegJWlesvu5yI5BVLCtAGmeEH0wm17uWcQlS806EGuJ+QjMsyLIZ1vjUfJYg0
 PC36UFpsyxAwSDCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C991613919;
 Tue, 22 Aug 2023 12:19:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NxuBL9+n5GRmYAAAMHmgww
 (envelope-from <cfontana@suse.de>); Tue, 22 Aug 2023 12:19:43 +0000
Message-ID: <45d135fd-55e7-28a3-5430-383ccfdb23ab@suse.de>
Date: Tue, 22 Aug 2023 14:19:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 0/4] migration/ram: Merge zero page handling
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20230816182817.17590-1-farosas@suse.de>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20230816182817.17590-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

Hello,

this series is all reviewed,

and is needed as a precondition for further work to improve dramatically the performance of virsh save, virsh restore
when migrating to disk, can it be merged?

Thanks,

Claudio

On 8/16/23 20:28, Fabiano Rosas wrote:
> For v2 I fixed patch 3 which had a hunk belonging to patch 5.
> 
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/969706915
> 
> v1:
> https://lore.kernel.org/r/20230815143828.15436-1-farosas@suse.de
> 
> Hi,
> 
> This is another small series that I extracted from my fixed-ram series
> and that could be already considered for merging.
> 
> This is just code movement, no functional change. The objective is to
> consolidate the zero page handling in the same routine that saves the
> page header and does accounting. Then in the future I'll be able to
> just return early because fixed-ram ignores zero pages.
> 
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/968300062
> 
> Fabiano Rosas (4):
>   migration/ram: Remove RAMState from xbzrle_cache_zero_page
>   migration/ram: Stop passing QEMUFile around in save_zero_page
>   migration/ram: Move xbzrle zero page handling into save_zero_page
>   migration/ram: Merge save_zero_page functions
> 
>  migration/ram.c | 75 ++++++++++++++++++++-----------------------------
>  1 file changed, 30 insertions(+), 45 deletions(-)
> 


