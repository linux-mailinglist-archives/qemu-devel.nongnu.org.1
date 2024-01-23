Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF84B839066
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 14:47:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSH6c-0006Kc-DM; Tue, 23 Jan 2024 08:46:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rSH6Z-0006Hg-Qs
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 08:46:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rSH6Y-0000j1-3F
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 08:46:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706017574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WJQ3jp8FdlIPGjLODAc9Td9bUO2OvrHPH7eu5fv5niM=;
 b=NP6s+lHbKYMJspLszfU+SYZLP4LKlYLBn1sxat8xWrt4J667d8ix8nOWKgKi6WZHDvq8yC
 lgqdw/91LI8Z52J/sGM1zx8cRtmgGH7/rJ/2JbCjV5crA0ZDxcwFuivVL5DCeLRmk5Afgf
 lVEE4pTnWqMM4pQqvpq5emVj0LobSqg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-8HSV42PzOyGylC0SZZBV8g-1; Tue,
 23 Jan 2024 08:46:13 -0500
X-MC-Unique: 8HSV42PzOyGylC0SZZBV8g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FC813812586;
 Tue, 23 Jan 2024 13:46:12 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BFFB7492BFA;
 Tue, 23 Jan 2024 13:46:11 +0000 (UTC)
Date: Tue, 23 Jan 2024 14:46:10 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Ira Weiny <ira.weiny@intel.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] bswap.h: Fix const_le64() macro
Message-ID: <Za_DIm1jBGLbulQY@redhat.com>
References: <20240122173735.472951-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240122173735.472951-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 22.01.2024 um 18:37 hat Peter Maydell geschrieben:
> The const_le64() macro introduced in commit 845d80a8c7b187 turns out
> to have a bug which means that on big-endian systems the compiler
> complains if the argument isn't already a 64-bit type. This hasn't
> caused a problem yet, because there are no in-tree uses, but it
> means it's not possible for anybody to add one without it failing CI.
> 
> This example is from an attempted use of it with the argument '0',
> from the s390 CI runner's gcc:
> 
> ../block/blklogwrites.c: In function ‘blk_log_writes_co_do_log’:
> ../include/qemu/bswap.h:148:36: error: left shift count >= width of
> type [-Werror=shift-count-overflow]
> 148 | ((((_x) & 0x00000000000000ffU) << 56) | \
> | ^~
> ../block/blklogwrites.c:409:27: note: in expansion of macro ‘const_le64’
> 409 | .nr_entries = const_le64(0),
> | ^~~~~~~~~~
> ../include/qemu/bswap.h:149:36: error: left shift count >= width of
> type [-Werror=shift-count-overflow]
> 149 | (((_x) & 0x000000000000ff00U) << 40) | \
> | ^~
> ../block/blklogwrites.c:409:27: note: in expansion of macro ‘const_le64’
> 409 | .nr_entries = const_le64(0),
> | ^~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Fix this by making all the constants in the macro have the ULL
> suffix.  This will cause them all to be 64-bit integers, which means
> the result of the logical & will also be an unsigned 64-bit type,
> even if the input to the macro is a smaller type, and so the shifts
> will be in range.
> 
> Fixes: 845d80a8c7b187 ("qemu/bswap: Add const_le64()")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


