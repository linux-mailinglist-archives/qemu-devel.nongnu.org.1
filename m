Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2950A7286C0
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 19:59:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7JtK-0008UH-Pd; Thu, 08 Jun 2023 13:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1q7JtJ-0008Tk-7A
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 13:57:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1q7JtH-0000dX-I5
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 13:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686247061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=4mJL0p+dXYtHUNHX84VZGaRjD5xRWpy6/Fuia8VRXOk=;
 b=DEdsakNUtQDWn/R5zHarFUgP0kQsrpk47s8Gniiz5Rp/8Mhyt/t0xLsELKgIzw1bE/BpGV
 mvnJs2JeyUrxVA2W8DTVwz97k7gmslaEBcOhRH96jNFwMVObhOEbgwHu6ezNIInr0uyiqV
 jK3dJIc66lLKBxu5/I2/d8oa6WtKHp4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-c-m8oDkwM76BAJomyXGwEA-1; Thu, 08 Jun 2023 13:57:39 -0400
X-MC-Unique: c-m8oDkwM76BAJomyXGwEA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DCD83C0C89F
 for <qemu-devel@nongnu.org>; Thu,  8 Jun 2023 17:57:39 +0000 (UTC)
Received: from localhost (unknown [10.39.192.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62C662026D49
 for <qemu-devel@nongnu.org>; Thu,  8 Jun 2023 17:57:39 +0000 (UTC)
Date: Thu, 8 Jun 2023 18:57:38 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: qemu-devel@nongnu.org
Subject: Collecting information from a hung qemu process
Message-ID: <20230608175738.GA32610@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

I filed this bug about recent Linux hanging very rarely when booting
on recent qemu:

https://gitlab.com/qemu-project/qemu/-/issues/1696

As I'm able to reproduce this bug at will (albeit I have to wait for
100s or 1000s of iterations of the test), I am able to observe the
qemu process after it hangs.  Is there any information which is useful
to collect from the hung qemu, such as stack traces, etc?

I know how to collect a stack trace, but if there's other information
please give me a guide about how to collect that.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW


