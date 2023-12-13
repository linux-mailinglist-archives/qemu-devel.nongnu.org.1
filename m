Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB7881188B
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 17:02:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDRfn-0005Wz-CB; Wed, 13 Dec 2023 11:01:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crobinso@redhat.com>)
 id 1rDRfl-0005WW-8J
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 11:01:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crobinso@redhat.com>)
 id 1rDRfj-0001mU-Mw
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 11:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702483275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L4o7Rsxoi7EzXnxeiLbfrjZLNLUI/r9IchjR2KTt2v0=;
 b=OrbyuiDBNW1JtQ6YcrHb6qHr+6dVv89G6oq67A4lt3Y4BdsdGdwPfJ8bIfWySSC1x6w5/T
 69v5W3VLG8y3k3wg8MBp7ecgrq/vCi3gJyhXrQ92Ly1hFA3bt+8LhrQBiDCVEMkpc3kI45
 KLLr8y/MUkY5Trmgylk1a7YcMgYDU0A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-NN4kD6VTPxKUkJtfZePIEQ-1; Wed,
 13 Dec 2023 11:01:13 -0500
X-MC-Unique: NN4kD6VTPxKUkJtfZePIEQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC94F2818749;
 Wed, 13 Dec 2023 16:01:11 +0000 (UTC)
Received: from [10.22.18.55] (unknown [10.22.18.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69F562166B31;
 Wed, 13 Dec 2023 16:01:11 +0000 (UTC)
Message-ID: <c3532ed6-1006-24f9-ce8f-0dc536166b25@redhat.com>
Date: Wed, 13 Dec 2023 11:01:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [Stable-7.2.8 00/24] Patch Round-up for stable 7.2.8, freeze on
 2023-12-23
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <qemu-stable-7.2.8-20231213160018@cover.tls.msk.ru>
From: Cole Robinson <crobinso@redhat.com>
In-Reply-To: <qemu-stable-7.2.8-20231213160018@cover.tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=crobinso@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.702, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 12/13/23 8:00 AM, Michael Tokarev wrote:
> The following patches are queued for QEMU stable v7.2.8:
> 
>   https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2
> 
> Patch freeze is 2023-12-23, and the release is planned for 2023-12-25:
> 
>   https://wiki.qemu.org/Planning/7.2
> 
> Please respond here or CC qemu-stable@nongnu.org on any additional patches
> you think should (or shouldn't) be included in the release.
> 
> The changes which are staging for inclusion, with the original commit hash
> from master branch, are given below the bottom line.
> 

We are carrying these 2 patches in fedora to fix test suite failures:

commit abe2c4bdb65e8dd9cb2f01c355baa394bf49a8af
Author: Eric Auger <eric.auger@redhat.com>
Date:   Tue Feb 28 10:29:44 2023 +0100

    test-vmstate: fix bad GTree usage, use-after-free

commit ae4b01b3497934849278b49f3dfd28420f75e300
Author: Richard W.M. Jones <rjones@redhat.com>
Date:   Tue Feb 28 19:06:45 2023 +0000

    tests: Ensure TAP version is printed before other messages


Thank you for your work on the stable releases!

- Cole


