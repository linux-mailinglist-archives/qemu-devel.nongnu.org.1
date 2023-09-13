Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F316579E88F
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 15:05:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgPYc-0001yT-1X; Wed, 13 Sep 2023 09:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qgPYZ-0001xx-53
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 09:05:23 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qgPYW-0006oE-SF
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 09:05:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F40FB1F390;
 Wed, 13 Sep 2023 13:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694610319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sWszLg+MEDZi67KYdNGjLh1D3La4ghG4Xvb+0/A0ybw=;
 b=aCPhZJLC1tSopA3FGT6Ufi5g/zLqmEohOEZhiM41MoQrqQyweIY5X9jOlWvUcdnW6iRBqP
 HRcwMV5DvGgVlIrpZ5FYVktUlAzbyE+7re9bCdaN6z8Op9p8LObet2rW/L76WMtISu33Oj
 Rf177aPQf/2v4Uc81p3If+0zIfUUO6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694610319;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sWszLg+MEDZi67KYdNGjLh1D3La4ghG4Xvb+0/A0ybw=;
 b=pAcOTNFtXvTvfrfKBFiNasxH/0NDVE8DmVBDizDKu74YASSkFMcvewdmuGBI948tg+5r9E
 205vY+MLhTDtOSAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD72813440;
 Wed, 13 Sep 2023 13:05:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tXeJLI6zAWVcOQAAMHmgww
 (envelope-from <cfontana@suse.de>); Wed, 13 Sep 2023 13:05:18 +0000
Message-ID: <252dea2b-787e-7350-c3b6-95b6192aa005@suse.de>
Date: Wed, 13 Sep 2023 15:05:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH V5 0/2] migration file URI
Content-Language: en-US
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
References: <1694182931-61390-1-git-send-email-steven.sistare@oracle.com>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <1694182931-61390-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d;
 envelope-from=cfontana@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

Hi,

this is the first step towards faster migration to disk that we care about the most,
can it be merged?

Thanks,

Claudio

On 9/8/23 16:22, Steve Sistare wrote:
> Add the migration URI "file:filename[,offset=offset]".
> 
> Fabiano Rosas has submitted the unit tests in the series
>   migration: Test the new "file:" migration
> 
> Changes in V5:
>   * fixed GPL version
> 
> Steve Sistare (2):
>   migration: file URI
>   migration: file URI offset
> 
>  migration/file.c       | 103 +++++++++++++++++++++++++++++++++++++++++++++++++
>  migration/file.h       |  14 +++++++
>  migration/meson.build  |   1 +
>  migration/migration.c  |   5 +++
>  migration/trace-events |   4 ++
>  qemu-options.hx        |   7 +++-
>  6 files changed, 133 insertions(+), 1 deletion(-)
>  create mode 100644 migration/file.c
>  create mode 100644 migration/file.h
> 


