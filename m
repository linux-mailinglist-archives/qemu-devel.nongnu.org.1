Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06820722788
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 15:34:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6AKa-00071y-8K; Mon, 05 Jun 2023 09:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q6AKY-00071U-AX
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 09:33:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q6AKW-00076P-Q4
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 09:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685971982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tr5HrglYb8nBSgQjwzSfuZnnfiQQRaEPi7ECSMJFQ/E=;
 b=QAFl3QuaaVD/D5HVKlbsLaCFrdO249mfvtrzkYNaTKRPRZiHs5YHlDc18RMonbiFCR3mE2
 x8vyC0VPnREOHr+DtmMpED15yHmHVoVMMshBEM9qj0uOdj7CmwMctgrt2criIYqMJQME7O
 1tRg0xv/PJWozNmw+NWDiWumHY2J/yU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-t5jLAEScMfaG3W3zAuXhhQ-1; Mon, 05 Jun 2023 09:32:58 -0400
X-MC-Unique: t5jLAEScMfaG3W3zAuXhhQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F057385A5B5;
 Mon,  5 Jun 2023 13:32:57 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BC0040CFD46;
 Mon,  5 Jun 2023 13:32:56 +0000 (UTC)
Date: Mon, 5 Jun 2023 08:32:55 -0500
From: Eric Blake <eblake@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [PULL 07/21] cutils: Fix wraparound parsing in qemu_strtoui
Message-ID: <j322ihz6lx6zpjy7mun4mzfwnpih7seqjnpffm5dhebyur45ur@p2aqn2znt6wq>
References: <20230601220305.2130121-1-eblake@redhat.com>
 <20230601220305.2130121-8-eblake@redhat.com>
 <62d84222-7da7-d036-7ef1-37b88de69572@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62d84222-7da7-d036-7ef1-37b88de69572@tls.msk.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Sat, Jun 03, 2023 at 11:17:27AM +0300, Michael Tokarev wrote:
> 02.06.2023 01:02, Eric Blake пишет:
> > While we were matching 32-bit strtol in qemu_strtoi, our use of a
> > 64-bit parse was leaking through for some inaccurate answers in
> > qemu_strtoui in comparison to a 32-bit strtoul (see the unit test for
> > examples).  The comment for that function even described what we have
> > to do for a correct parse, but didn't implement it correctly: since
> > strtoull checks for overflow against the wrong values and then
> > negates, we have to temporarily undo negation before checking for
> > overflow against our desired value.
> > 
> > Our int wrappers would be a lot easier to write if libc had a
> > guaranteed 32-bit parser even on platforms with 64-bit long.
> > 
> > Whether we parse C2x binary strings like "0b1000" is currently up to
> > what libc does; our unit tests intentionally don't cover that at the
> > moment, though.
> > 
> > Fixes: 473a2a331e ("cutils: add qemu_strtoi & qemu_strtoui parsers for int/unsigned int types", v2.12.0)
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > CC: qemu-stable@nongnu.org
> 
> Trying to pick this one up for -stable. The implementation changes are good.
> But the testsuite changes are.. difficult.  The thing is that testsuite changes
> (here and in the other -stable patch) applies on top of previous changes in
> there (in the same series), which, in turn, requires other previous code changes
> in the implementation to succeed.

Yeah, I did wonder if it is worth even trying to get this for stable.
The series is inter-tangled enough that it feels like an
all-or-nothing approach may be easiest - but all means 19 patches and
hundreds of lines of testsuite additions.  My other argument when
first posting this to qemu-stable was to just declare that these have
been broken long enough that it is not a recent regression, and users
are unlikely to be supplying command-line or QMP strings to tickle
these bugs, so not backporting may be okay.

> 
> For example, this patch changes test_qemu_strtoui_overflow() which was introduced
> in previous patch "Test more integer corner cases" from this series and further
> modified in "Test integral qemu_strto* value on failures" one.  Picking them result
> in testsuite failing due to missing previous code changes.
> 
> I tried to drop just the testsuite changes, but the result is that the testsuite
> fails with fixed code :)
> 
> It's quite fun situation actually, like it fails no matter what you do, one way
> or another.
> 
> I'll try to find the most stright-forward way from here.  Good stuff.

Let me know how I can help in deciding what, if any, is worth backporting.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


