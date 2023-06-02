Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D757720210
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 14:27:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q53sS-0001RI-2m; Fri, 02 Jun 2023 08:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q53sP-0001RA-E2
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:27:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q53sN-0003D1-Ip
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685708844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8+jcMQvzUC+ortD1ZtD/mMM5g6yTczNO8OGO65NQnxc=;
 b=dJfII4dno7ko4P1GrBJ95APBbUeo2UT7iDv27ItrRFAymalJRJrxFHabqOaSeOsrapLQEe
 FzuxPujEJAf+P9DE/ywy/Zu51+eOypzpAk+kQPdn21aYIpWoBIn5f90S5EsPoWVHkQsJ6b
 yP26/pOlEqpXY+SjieklSp5ZANTEC+w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-Kmc_pWB2MUambnX4Zw1PVw-1; Fri, 02 Jun 2023 08:27:21 -0400
X-MC-Unique: Kmc_pWB2MUambnX4Zw1PVw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D962E2A2AD51;
 Fri,  2 Jun 2023 12:27:20 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 97AA6C154D7;
 Fri,  2 Jun 2023 12:27:20 +0000 (UTC)
Date: Fri, 2 Jun 2023 07:27:18 -0500
From: Eric Blake <eblake@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/21] NBD and miscellaneous patches for 2023-06-01
Message-ID: <gufeky5wg3blkae2nwhxnwzihftdxfp5dbdybqro6tb7vq2xdg@jejg7adlc3ri>
References: <20230601220305.2130121-1-eblake@redhat.com>
 <1e9840bd-65bc-550b-e031-9fe824aac7e8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e9840bd-65bc-550b-e031-9fe824aac7e8@linaro.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
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

On Thu, Jun 01, 2023 at 08:58:46PM -0700, Richard Henderson wrote:
> On 6/1/23 15:02, Eric Blake wrote:
> > Eric Blake (21):
> >        iotests: Fix test 104 under NBD
> >        qcow2: Explicit mention of padding bytes
> >        test-cutils: Avoid g_assert in unit tests
> >        test-cutils: Use g_assert_cmpuint where appropriate
> >        test-cutils: Test integral qemu_strto* value on failures
> >        test-cutils: Test more integer corner cases
> >        cutils: Fix wraparound parsing in qemu_strtoui
> >        cutils: Document differences between parse_uint and qemu_strtou64
> >        cutils: Adjust signature of parse_uint[_full]
> >        cutils: Allow NULL endptr in parse_uint()
> >        test-cutils: Add coverage of qemu_strtod
> >        test-cutils: Prepare for upcoming semantic change in qemu_strtosz
> >        test-cutils: Refactor qemu_strtosz tests for less boilerplate
> >        cutils: Allow NULL str in qemu_strtosz
> >        numa: Check for qemu_strtosz_MiB error
> >        test-cutils: Add more coverage to qemu_strtosz
> >        cutils: Set value in all qemu_strtosz* error paths
> >        cutils: Set value in all integral qemu_strto* error paths
> >        cutils: Use parse_uint in qemu_strtosz for negative rejection
> >        cutils: Improve qemu_strtod* error paths
> >        cutils: Improve qemu_strtosz handling of fractions
> 
> This is failing on Windows (32 and 64-bit):
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/4399466166#L3524
> https://gitlab.com/qemu-project/qemu/-/jobs/4399466165#L3332
> 
> |  21/135 /cutils/qemu_strtol/overflow -
> ERROR:../tests/unit/test-cutils.c:1387:test_qemu_strtol_overflow: assertion
> failed (res == LONG_MIN): (2147483647 == -2147483648) FAIL
> 
> It seems to have returned LONG_MAX instead of LONG_MIN.

Gah.  I see the problem; it is a copy/paste typo in part of
test-cutils.c guarded by 'if (LONG_MAX == INT_MAX)' and therefore
doesn't fire on platforms with 64-bit long.  Will respin the pull
request to fix it.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


