Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA3571F502
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 23:48:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4q8T-0000qw-82; Thu, 01 Jun 2023 17:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4q8P-0000q6-DP
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 17:47:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4q8N-0007W8-IK
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 17:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685656021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ACtypPiOBrMEQvVnHz/IgrKX1xCgW6k/NXpT9ZQWBIA=;
 b=I3a1n6P3BfTxhj3AXdYJFY6EnXttKAwllNFyL3vSQzhvJ7FpVfxenEVVVvEkWYSur2G9Rt
 NLVPNFJDP6/ITyJFCMymFzTlgatX32ndB2qa/bcDAsrTFIrJo8emTJ6fc/TbCk4FCxRDK0
 BPjk44iQilEX0KHh/idPPMHA6zOda2E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-BfP_qFpmOr6ojLx8Cn9bxg-1; Thu, 01 Jun 2023 17:46:59 -0400
X-MC-Unique: BfP_qFpmOr6ojLx8Cn9bxg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9208F85A5BE;
 Thu,  1 Jun 2023 21:46:59 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BDD02166B25;
 Thu,  1 Jun 2023 21:46:59 +0000 (UTC)
Date: Thu, 1 Jun 2023 16:46:57 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com, qemu-block@nongnu.org
Subject: Re: [PATCH v3 19/19] cutils: Improve qemu_strtosz handling of
 fractions
Message-ID: <pkk2whklk5ceqypnfvc7kdycic677oajez6oh7iuftcodhw4po@bousmxdkzgjv>
References: <20230522190441.64278-1-eblake@redhat.com>
 <20230522190441.64278-20-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522190441.64278-20-eblake@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, May 22, 2023 at 02:04:41PM -0500, Eric Blake wrote:
> We have several limitations and bugs worth fixing; they are
> inter-related enough that it is not worth splitting this patch into
> smaller pieces:
> 
> +++ b/util/cutils.c
> @@ -194,15 +194,18 @@ static int64_t suffix_mul(char suffix, int64_t unit)
>   * - 12345 - decimal, scale determined by @default_suffix and @unit
>   * - 12345{bBkKmMgGtTpPeE} - decimal, scale determined by suffix and @unit
>   * - 12345.678{kKmMgGtTpPeE} - decimal, scale determined by suffix, and
> - *   fractional portion is truncated to byte
> + *   fractional portion is truncated to byte, either side of . may be empty
>   * - 0x7fEE - hexadecimal, unit determined by @default_suffix
>   *
>   * The following are intentionally not supported
> - * - hex with scaling suffix, such as 0x20M
> - * - octal, such as 08
> - * - fractional hex, such as 0x1.8
> - * - negative values, including -0
> - * - floating point exponents, such as 1e3
> + * - hex with scaling suffix, such as 0x20M (0x1b is 27, not 1)
> + * - octal, such as 08 (parsed as decimal instead)
> + * - binary, such as 0b1000 (parsed as 0b with trailing garbage "1000")
> + * - fractional hex, such as 0x1.8 (parsed as 0 with trailing garbage "x1.8")
> + * - negative values, including -0 (fail with -ERANGE)
> + * - floating point exponents, such as 1e3 (parsed as 1e with trailing
> + *   garbage "3") or 0x1p3 (parsed as 1 with trailing garbage "p3")

This latter clause is wrong - we reject 0x1p3 earlier under the hex
with scaling suffix rule.  I've touched up the comment as part of
preparing the pull request.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


